Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75316CD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 07:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2C1E846A4;
	Mon, 15 Jun 2026 09:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="jb3MZHOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 193E18484C; Mon, 15 Jun 2026 09:57:04 +0200 (CEST)
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch
 [79.135.106.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C25B83FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1781510220; x=1781769420;
 bh=wnseJ1saBp5G5lxGb4vT1H+9kD2UQ5p0egqS9QZ011E=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=jb3MZHOAHjJOnfJ5/hut21rD/42fH+3lpXVeO3WIfzeNi8e5cxzkXbZjwBsECwG4l
 rP/SX721lrnPIo+fBqeHN7cxHgTJXslWxJNBzg4/Pem2JiKVqFUJ/oFvWawCZviI5z
 och0p4yt5nTettp/aAn8agFvQsIlbxYJlKUGE5Zvsx5s5o+vQpmbExI0vHBOTAcGyG
 NJLys+sA6DBAxEYEN4aeTfPe1CjT7Cw4qqdE9e4G+xpfYCp967LwhDK3DMWCrV8dru
 /eo32oxGlUs7vizgqLmQ/s+xzr3prumrVZYx5rT5JLh+T03I+wnU+5gOvikGJGD0Dk
 z8omvML/u4abw==
X-Pm-Submission-Id: 4gf2Wt39JZz1DDXY
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: "Marek Vasut" <marek.vasut@mailbox.org>
Cc: <u-boot@lists.denx.de>,  "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH] Makefile: let 'make clean' remove files created by
 DEVICE_TREE_DEBUG
In-Reply-To: <5c5d874d-6c52-4d77-9ae9-3cbbaffa2ab8@mailbox.org> (Marek Vasut's
 message of "Fri, 12 Jun 2026 16:28:53 +0200")
References: <20260611140857.1522036-1-rv@rasmusvillemoes.dk>
 <CaqH7y3qsM-yb7Q-nigLb2M8qlSEPjlb3wBWmPH37mg1S3hybj61GqoqUEYu2Eeug_HxNqYM-FEviK0r5NKTZQ==@protonmail.internalid>
 <9924cd04-b312-4196-b394-1aa8a44aead6@mailbox.org>
 <87a4t0p9g2.fsf@rasmusvillemoes.dk>
 <P0ttL79jHJWGreavvBpJf3oHSXY7rT4xc8vTAEU4nbS16InxugwWnUliHtU-lCCf7mDCXb3BKiFzTRkH0JX_Zw==@protonmail.internalid>
 <5c5d874d-6c52-4d77-9ae9-3cbbaffa2ab8@mailbox.org>
Date: Mon, 15 Jun 2026 09:56:57 +0200
Message-ID: <871pe8p77a.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Jun 12 2026, "Marek Vasut" <marek.vasut@mailbox.org> wrote:

> On 6/12/26 8:19 AM, Rasmus Villemoes wrote:
>> On Thu, Jun 11 2026, "Marek Vasut" <marek.vasut@mailbox.org> wrote:
>>
>>> On 6/11/26 4:08 PM, Rasmus Villemoes wrote:
>>>> Originally, 'make DEVICE_TREE_DEBUG=1' only generated extra output on
>>>> the console. But since 6cdd7597a2f ("kbuild: Produce diff between base
>>>> DT and U-Boot augmented DT if DEVICE_TREE_DEBUG=1"), that has also
>>>> left behind lots of files that clutter the repo and are hard to get
>>>> rid of manually.
>>>>
>>>> Make sure that a 'make clean' will remove those files, and add them to
>>>> .gitignore.
>>>>
>>>> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>>>> ---
>>>>    .gitignore | 3 +++
>>>>    Makefile   | 1 +
>>>>    2 files changed, 4 insertions(+)
>>>
>>> This is nice, thank you.
>>>
>>>> diff --git a/.gitignore b/.gitignore
>>>> index d57d3be0291..0e09715cc60 100644
>>>> --- a/.gitignore
>>>> +++ b/.gitignore
>>>> @@ -16,6 +16,9 @@
>>>>    *.dtb
>>>>    *.dtbo
>>>>    *.dtb.S
>>>> +*.dtb.clean.dts
>>>> +*.dtb.diff
>>>> +*.dtb.full.dts
>>> Would it make sense to simply change this to *.dtb.* ? Or do you think
>>> that is too much ?
>>
>> I think I'm leaning on the explicit mention of each suffix. Had there
>> already been a *.dtb.* pattern, I would probably not have noticed and
>> thus not been prompted to amend the 'make clean' rule, so I think it's
>> better that some potential future .dtb.foo artifact does show up in 'git
>> status' as an untracked file. But this is certainly not a strong
>> opinion, and I'd be fine either way.
> I would be fine with .dts.foo showing up, but .dtb.foo are most likely
> build artifacts ?

Yes, but my point was that if we add a blanket *.dtb.* pattern to
.gitignore, the fact that some future .dtb.foo does _not_ show up in 'git
status' will make it less likely for the developer who adds .dtb.foo, or
someone else shortly afterwards, to note that it wasn't added to the
clean rule, as I'm sure we agree that it should be. Hence I think the
patterns should be added one by one to .gitignore in tandem with their
addition to the clean rule. But it's still not a strong opinion, so if
you or Tom or someone else think *.dtb.* in .gitignore is the way to go,
I won't object.

Rasmus
