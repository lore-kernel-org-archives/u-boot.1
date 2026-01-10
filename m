Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952B1D277C9
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 01:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91BB9843A9;
	Sat, 10 Jan 2026 02:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="oOwDa3bu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A16084390; Sat, 10 Jan 2026 02:07:19 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95D6E843FF
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 02:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1768007229;
 bh=8u+l6K39hl13Jvz3mAUYZU7NWy9MusWhrZ9pK+Y7Fd0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oOwDa3buAv3XQuhLUVe58OGtBCFcazNI/AuEGWgMp4lbEtM52NSGfkR2dPBoD8arz
 ZA8+VnmAW5DUSeGkaMnz+epEoOtlcZlkaNHrdTXuQVGrwDSgzXW29DimILHhZk61a1
 nK0lBG4Pl5zvOS6YxLpAno+2wYqYLB+6951OnSttjaB1roEyhN6XZOjPWVAyFxtYt6
 aRWDuFMcdDrtIKFZcRZ93Q6tXDqkxfMG/qWhlb1jxNe1hyuSNqNz+N6IaHuTai4yMd
 7spr2W31jdh4AgmgMNzszsn5GdeNyAUvTQdSu3pIy4/tKPpx5zJXpW+ywNB4RxsoJs
 avLMWs5hQgpGQ==
Received: from [IPV6:2605:59c0:2078:cf00:c0b6:e37b:5515:2b98] (unknown
 [IPv6:2605:59c0:2078:cf00:c0b6:e37b:5515:2b98])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 0B174B22032B;
 Sat, 10 Jan 2026 02:07:08 +0100 (CET)
Message-ID: <37d1dc68-9774-44a5-9cf0-0876975d9801@freeshell.de>
Date: Fri, 9 Jan 2026 17:07:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc/develop/process.rst: Expand on the Custodian workflow
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20260109172905.1446923-1-trini@konsulko.com>
 <35fe875d-0bcc-452b-bb66-a2158b96629e@cherry.de>
 <20260109183203.GH3416603@bill-the-cat>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260109183203.GH3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi, and thank you Tom, here follows my thoughts on this to consider.

On 1/9/26 10:32, Tom Rini wrote:
> On Fri, Jan 09, 2026 at 07:08:40PM +0100, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 1/9/26 6:29 PM, Tom Rini wrote:
>>> As seen with a recent pull request, there have been implicit assumptions
>>> about how much custodians can change patches before applying and merging
>>> them. This has lead to an unfortunate situation with a contributor being
>>> understandably upset about the changes.
>>>
>>> To avoid this in the future, document a few things:
>>> - Non-trivial changes to make something apply need to have at least
>>>    [name: what] in the commit message.
>>> - Only trivial and obviously correct changes can be made by the
>>>    custodian, and ideally this is done in a merge commit and not the
>>>    patch itself.
>>> - It is the responsibility of the custodian to gather relevant tags that
>>>    have been provided by the community.
>>>
>>> Link: https://lore.kernel.org/u-boot/1faefbf2-e8b0-4c94-85f5-025355915e0d@gmx.de/
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> With this, Heinrich, per E Shattow's comment on IRC, can you please
>>> revert the commit in question, then apply his patch as-is, and then your
>>> changes as a new patch in order to show correct history?
>>>
>>> And I realize at this point the subsection of this document is a bit
>>> wordy. Maybe a follow-up of restructuring this part of the document
>>> would be helpful? I'm not sure what would flow better however.
>>>
>>> Cc: E Shattow <e@freeshell.de>
>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>>> ---
>>>   doc/develop/process.rst | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/doc/develop/process.rst b/doc/develop/process.rst
>>> index 4bfbf0eb9c63..84ab09132a0b 100644
>>> --- a/doc/develop/process.rst
>>> +++ b/doc/develop/process.rst
>>> @@ -244,7 +244,12 @@ like this:
>>>         custodian can also accept patches against older code.  It can be
>>>         difficult to find the correct balance between putting too much work on
>>>         the custodian or too much work on an individual submitting a patch when
>>> -      something does not apply cleanly.
>>> +      something does not apply cleanly. If non-trivial changes need to be made
>>> +      for it to apply the custodian is expected to annotate the commit message
>>> +      with ``[name: note about changes made]``. Furthermore, only trivial and
>>
>> We should provide an example, I think.
>>
>> commit 66be03b7ee19444b23aae3990a434a7470fc1641
>> Author: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
>> Date:   Fri Nov 28 12:03:04 2025 +0100
>>
>>     binman: blob_dtb: improve error message when SPL is not found
>>
>>     When using binman with the '-a spl-dtb=y' flag, if the SPL blob is not
>>     found, binman throws a cryptic error message:
>>     binman: 'NoneType' object has no attribute 'startswith'
>>
>>     Let's improve the error message to explicitly state which SPL blob is
>>     missing.
>>     This is particularly useful when binman is used as a standalone tool
>>     outside the U-Boot source tree.
>>
>>     Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
>>     [trini: Add '# pragma: no cover' because coverage doesn't seem to like
>>     the documentation about this error]
>>     Signed-off-by: Tom Rini <trini@konsulko.com>
>>
>> is a good one I think.
>>
>> You also added your SoB which isn't mentioned as a requirement here. I
>> believe it must, because whatever you added/changed, you must comply with
>> DCO to do it.
>>
>> I'm tempted to say we maybe should add a link to the original (unmerged)
>> commit so that people can actually do the diff themselves if they want to?
>>
>> For the above example, have
>>
>> Link: https://lore.kernel.org/u-boot/20251128110304.63138-1-jeremie.dautheribes@bootlin.com/
>>
>> Maybe? Not sure how much friction we want to put on custodians. There's
>> probably already a lot to do :)
>>
>> I would really like also that custodians *tell* people that they have merged
>> the commits with changes. https://docs.u-boot.org/en/latest/develop/process.html#work-flow-of-a-custodian
>> says it's only "ideally" they do for merged patches, but I really think we
>> should tell people when changes are made to their patches.
>>
>>> +      obviously correct changes can be made, no other changes should be made to
>>> +      the patch itself. Ideally all of these changes will be in a merge commit,
>>> +      and not the commit itself, but that is not always possible.
>>
>> I have never been a maintainer in public spaces, and in private spaces I
>> enforce a strict rebase policy so I don't have merge commits ever. I
>> wouldn't know what this means (but maybe custodians do, and that's the most
>> important as this isn't something contributors need to know?). How are we
>> supposed to do that? Note also that not everybody know that git log -c (or
>> --cc? I use -c but it seems to be showing the diff of the whole merge and
>> not necessarily the conflicts?) needs to be used to see the content of a git
>> merge commit (it won't show with git log -p).
>>
>> Can we provide an example here of a good merge commit that highlights what
>> is expected from custodians?
>>
>> I cannot really comment on whether this will help custodians do the right
>> thing as I am no custodian.
>>
>> We need to set the expectations for contributors as well.
>>
>> """
>> Trivial fixes may be applied by custodians when merging your patches,
>> sometimes without public notice. The operated changes are explicitly listed
>> at the end of the commit log or in a merge commit by the custodian.
>> """
>>
>> or something like that? I'm wondering where we should put this though. https://docs.u-boot.org/en/latest/develop/process.html#review-process-git-tags
>> or https://docs.u-boot.org/en/latest/develop/sending_patches.html? I think
>> this kind of change should be in the same commit (or one that follows after,
>> but is done now).
>>
>> We can have some words about proper etiquette too? Like avoiding big series,
>> waiting a bit between versions, not silently ignoring previous reviews for
>> newer versions (you can disagree but you need to speak your mind publicly
>> and "resolve the conflict" before sending a newer version (or at the very
>> least say why something wasn't done in the cover-letter or under the ---
>> section in a patch), waiting at least a week (more?) to send a ping on yet
>> unreviewed patches, ... That's what's coming to mind right now, there's
>> probably more to add? This is a separate topic and I don't want this to be a
>> blocker for this here.
> 
> That's a lot of feedback, thank you. I think this means for v2, I need
> to:
> - Move most of the existing wording to another section, and reference up
>   to it.
> - Note that some things we have done before, really shouldn't be (in your
>   good example, maybe I should have pushed back on the contributor to
>   try and figure out how to convince Python it *had* coverage and not
>   just pragma past it, to not have the contribution sitting out even
>   logner).
> - Incorporate much of the above and try and remove other assumptions I
>   did make / added in my wording above.
> 

Expectation-setting is distinct from telling someone how to do some
task. You may explain clearly each step of a process with provided
examples and yet there will be mistakes even when following a guide that
details exactly how to avoid mistakes.

Thought experiment: Hypothetical patch handler with commit rights is
compromised by nation state or employer to insert intentional errors in
code; or for a modest monthly cash retainer the side-hustle is to be
on-call to insert changes (or delay the process of accepting specific
changes) and to conceal this ulterior motivation. Maybe it is the
project leader themself or personal friend saying "Trust me, we can
commit this and just make a change quietly, I assure you personally that
it is not needed disclose alterations in public".

Do we want to encourage that? It is not illegal... or maybe not even
technically against any Code of Conduct. In-fact your employment may
require it or it may be your patriotic duty is to do so, and you would
ignore any written rule and specific procedure outlined in documentation
that we are discussing now...

[End of thought experiment]

For my part in the (real) incident it is a community trust issue and as
already stated is a concern of respecting people's time. Misrepresenting
material changes to any patch in-flight is a fantastic waste of time for
anyone now and in the future looking at the history of changes. This is
also just as much of a problem if say, there's some bad tooling
involved, and quiet changes are being made without consent or
disclosure; even without knowledge of the handler with commit access.

I agree that the norms about notifying when changes are committed are a
bit lacking however I consider this a tooling issue. If your role is to
send (x) additional e-mail confirmations manually when handling patch
submissions then I'd argue that is not reasonable to expect a person to
do so reliably. By far for my part the most alarming fact is that unless
I (as the patch author) personally check that the work was applied
properly it is an unknown. Well, what else might be silently manipulated
about the code base and misrepresented as if someone else had knowingly
done so?

None of this is new for open source development projects or
vulnerability disclosure frameworks, but it is quite interesting that no
one is pointing to earlier malicious instances of this in the U-Boot
project. I have trusted that patches are applied as reviewed in public
discussion, and apparently we just assume that is usually true (until now?).

We should add some kind of reporting to say if code entering the source
tree is or is not what was reviewed as it landed on patchwork; and this
should be done in a way that answers the process questions consistently:

"What license requirements are suspected to be in conflict, that might
pertain to required legal handling?"

"What national/professional/nepotistic conflicts of interest have been
identified, that might pertain to required Code of Conduct measures?"

"What tooling changes are identified to improve the disclosure cycle?"

"What additional requests or delays in a resolution are identified
beyond a what is able to be promptly resolved by a mulligan (revert,
re-apply) within one cycle of cooling time or release schedule
requirements for a patch series?"

Separately from the initial handling of patches this effort should be
expanded that questions asked (such as examples I have given above) when
something does not go as expected, are common questions asked by all
involved.

Why when I explicitly say "revert my patch 4c105d2ae7b0 and re-apply
properly" this was not done the same-day, or even within one week now
that we're still talking about it and other quiet alterations have been
identified? That is irritating to know we don't fix mistakes as a
project. We should all be asking the same process questions.

-E
