Template.memberP2p.replaces("member");

Template.member.helpers({
  getUserAccount: function(userId) {
    ReactionCore.Collections.Accounts.findOne({_id: userId});
  }
});
