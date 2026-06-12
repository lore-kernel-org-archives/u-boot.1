Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC57ECD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 14:29:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D528583FEC;
	Fri, 12 Jun 2026 16:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PVjOIJZO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E022783FF5; Fri, 12 Jun 2026 16:28:58 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF729839A8
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 16:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gcMMW1fwwz9v6D;
 Fri, 12 Jun 2026 16:28:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781274535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DR91e3PU7Z1gk5s+9GUYQhVao5Dmym44Nq6wihfgCSM=;
 b=PVjOIJZOofCuCsaTZfZo1n5bYXIHeYLkDpwI8awX4ALAKeVrvcAt/HeOxSbVTx/0tU5+Gy
 KYHhFpzsE0x1g846YN8N4eWsV8xny47n9h873yQeGOo474upcSdxVC0RBP5J2fghePblzQ
 KwieesK0ga/iltHTFLoRu+sTeW7UyQj/0WPpKJecL0nJnC0skSzEzWxuJa/81tX81KkdUx
 5UmrxgxnE+xs26gECnKqx7fPy8AvDseEgmtClZkbtVGeJNPhnulgLsttDrn+29lfHiaMNU
 YY3hotN+pYuO4Pmh6C+C9fLmHz+DcuKLAT+dqfOI1bAR72UodbdWQVcG62eGuw==
Message-ID: <5c5d874d-6c52-4d77-9ae9-3cbbaffa2ab8@mailbox.org>
Date: Fri, 12 Jun 2026 16:28:53 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] Makefile: let 'make clean' remove files created by
 DEVICE_TREE_DEBUG
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20260611140857.1522036-1-rv@rasmusvillemoes.dk>
 <CaqH7y3qsM-yb7Q-nigLb2M8qlSEPjlb3wBWmPH37mg1S3hybj61GqoqUEYu2Eeug_HxNqYM-FEviK0r5NKTZQ==@protonmail.internalid>
 <9924cd04-b312-4196-b394-1aa8a44aead6@mailbox.org>
 <87a4t0p9g2.fsf@rasmusvillemoes.dk>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87a4t0p9g2.fsf@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 54b2dd187099626a10a
X-MBO-RS-META: oy11ka4kozip8qzoke5up4j1gkp8e76e
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

On 6/12/26 8:19 AM, Rasmus Villemoes wrote:
> On Thu, Jun 11 2026, "Marek Vasut" <marek.vasut@mailbox.org> wrote:
> 
>> On 6/11/26 4:08 PM, Rasmus Villemoes wrote:
>>> Originally, 'make DEVICE_TREE_DEBUG=1' only generated extra output on
>>> the console. But since 6cdd7597a2f ("kbuild: Produce diff between base
>>> DT and U-Boot augmented DT if DEVICE_TREE_DEBUG=1"), that has also
>>> left behind lots of files that clutter the repo and are hard to get
>>> rid of manually.
>>>
>>> Make sure that a 'make clean' will remove those files, and add them to
>>> .gitignore.
>>>
>>> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>>> ---
>>>    .gitignore | 3 +++
>>>    Makefile   | 1 +
>>>    2 files changed, 4 insertions(+)
>>
>> This is nice, thank you.
>>
>>> diff --git a/.gitignore b/.gitignore
>>> index d57d3be0291..0e09715cc60 100644
>>> --- a/.gitignore
>>> +++ b/.gitignore
>>> @@ -16,6 +16,9 @@
>>>    *.dtb
>>>    *.dtbo
>>>    *.dtb.S
>>> +*.dtb.clean.dts
>>> +*.dtb.diff
>>> +*.dtb.full.dts
>> Would it make sense to simply change this to *.dtb.* ? Or do you think
>> that is too much ?
> 
> I think I'm leaning on the explicit mention of each suffix. Had there
> already been a *.dtb.* pattern, I would probably not have noticed and
> thus not been prompted to amend the 'make clean' rule, so I think it's
> better that some potential future .dtb.foo artifact does show up in 'git
> status' as an untracked file. But this is certainly not a strong
> opinion, and I'd be fine either way.
I would be fine with .dts.foo showing up, but .dtb.foo are most likely 
build artifacts ?
