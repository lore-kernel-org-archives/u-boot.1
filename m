Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7878ACD98CE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 22:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0698846CF;
	Tue, 16 Jun 2026 00:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="aa6RgU1V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC5CE84704; Tue, 16 Jun 2026 00:25:49 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C1CE846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 00:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gfPpK5pCKz9tws;
 Tue, 16 Jun 2026 00:25:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781562345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Azb89THpwnl5DcTHcpoxZ5bW0rcK5ygHRg6Sh1hkR8o=;
 b=aa6RgU1VaPQ36P4LKavTXZZAqkOT5nIn1PVAHYkhviR+j3N8Bin1P8EmSwbovlsZ7wp7UP
 tqFitkzdxKQ90KYX2rdMTEejqbEQo0z8gV629WFOrZztvrxyb06WT1Xqu/PvEcRxQxEXhD
 hY+Sk4v4oGKFYl+DLdHXqWsGze9a93N66OetYnynYU0PlhuEdilQviXBOZffLQszfXIR5x
 XUWhBVzarHEUHs+vc3LFE702SEd9ZRvYONtWxQHlXO/+T1Sg63QH81ey9fY3mbJXRkZFSQ
 fBEMCOobkP2ImwrjRAzzSCY4MUDpGTEPXpORKjgSyiM3qU2jAXenVEYke/QDVw==
Message-ID: <c40102f6-d939-4c54-95f3-886e79cb2c17@mailbox.org>
Date: Mon, 15 Jun 2026 23:28:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] Makefile: let 'make clean' remove files created by
 DEVICE_TREE_DEBUG
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20260611140857.1522036-1-rv@rasmusvillemoes.dk>
 <CaqH7y3qsM-yb7Q-nigLb2M8qlSEPjlb3wBWmPH37mg1S3hybj61GqoqUEYu2Eeug_HxNqYM-FEviK0r5NKTZQ==@protonmail.internalid>
 <9924cd04-b312-4196-b394-1aa8a44aead6@mailbox.org>
 <87a4t0p9g2.fsf@rasmusvillemoes.dk>
 <P0ttL79jHJWGreavvBpJf3oHSXY7rT4xc8vTAEU4nbS16InxugwWnUliHtU-lCCf7mDCXb3BKiFzTRkH0JX_Zw==@protonmail.internalid>
 <5c5d874d-6c52-4d77-9ae9-3cbbaffa2ab8@mailbox.org>
 <871pe8p77a.fsf@rasmusvillemoes.dk>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <871pe8p77a.fsf@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: d6rjswdgijgo4jspaaiftmm17uyrijuc
X-MBO-RS-ID: 462e611d6b3a9618d0b
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

On 6/15/26 9:56 AM, Rasmus Villemoes wrote:

Hello Rasmus,

>>>>> +*.dtb.clean.dts
>>>>> +*.dtb.diff
>>>>> +*.dtb.full.dts
>>>> Would it make sense to simply change this to *.dtb.* ? Or do you think
>>>> that is too much ?
>>>
>>> I think I'm leaning on the explicit mention of each suffix. Had there
>>> already been a *.dtb.* pattern, I would probably not have noticed and
>>> thus not been prompted to amend the 'make clean' rule, so I think it's
>>> better that some potential future .dtb.foo artifact does show up in 'git
>>> status' as an untracked file. But this is certainly not a strong
>>> opinion, and I'd be fine either way.
>> I would be fine with .dts.foo showing up, but .dtb.foo are most likely
>> build artifacts ?
> 
> Yes, but my point was that if we add a blanket *.dtb.* pattern to
> .gitignore, the fact that some future .dtb.foo does _not_ show up in 'git
> status' will make it less likely for the developer who adds .dtb.foo, or
> someone else shortly afterwards, to note that it wasn't added to the
> clean rule, as I'm sure we agree that it should be.

Ahhh, I understand now, thank you for clarifying.

> Hence I think the
> patterns should be added one by one to .gitignore in tandem with their
> addition to the clean rule. But it's still not a strong opinion, so if
> you or Tom or someone else think *.dtb.* in .gitignore is the way to go,
> I won't object.
I retract my concern.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you.
