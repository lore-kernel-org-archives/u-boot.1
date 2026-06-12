Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFEACD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 06:19:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 000D7839A8;
	Fri, 12 Jun 2026 08:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="oAx1wJW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8F3C83FF5; Fri, 12 Jun 2026 08:19:31 +0200 (CEST)
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch
 [185.70.43.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC9458005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 08:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1781245167; x=1781504367;
 bh=H91xuFTh9eAvIzP2Y7dy9St6ubADyxR0Dn3IQvkq4W0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=oAx1wJW8cxQvO70FUNF5g6YNCNsmk1uxZpcLLjg5wmfpIaRwiPBJ+B6IrUllWr3q7
 NFKbf4p+7dp3lkBmT8lGo6vOcWmxAmwFU+T86pLjm265W+4PczaAgQiRN/ga2ZqQXC
 9svXYjRW3i3TEFUp+rYOivkwAZzyEfKMKO/d6wEZOcG89Z8+n5kOgdl9KWX4oqnLlX
 RPFXv0J3oV4wX2skriIJutHrKOYSdnR8bx7tyFzWvxQPp0ebVNzoMB7MoKzZy0uRDM
 7RyvuIyMmLqfDLRk4yTQrGxqK/L/iZ5dNIzHRRtwfGu2T+87whpSpsXLFeidZZ9wrX
 PSaro3YfxN7Nw==
X-Pm-Submission-Id: 4gc8Vk5x2Rz1DDLM
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: "Marek Vasut" <marek.vasut@mailbox.org>
Cc: <u-boot@lists.denx.de>,  "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH] Makefile: let 'make clean' remove files created by
 DEVICE_TREE_DEBUG
In-Reply-To: <9924cd04-b312-4196-b394-1aa8a44aead6@mailbox.org> (Marek Vasut's
 message of "Thu, 11 Jun 2026 16:50:30 +0200")
References: <20260611140857.1522036-1-rv@rasmusvillemoes.dk>
 <CaqH7y3qsM-yb7Q-nigLb2M8qlSEPjlb3wBWmPH37mg1S3hybj61GqoqUEYu2Eeug_HxNqYM-FEviK0r5NKTZQ==@protonmail.internalid>
 <9924cd04-b312-4196-b394-1aa8a44aead6@mailbox.org>
Date: Fri, 12 Jun 2026 08:19:25 +0200
Message-ID: <87a4t0p9g2.fsf@rasmusvillemoes.dk>
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

On Thu, Jun 11 2026, "Marek Vasut" <marek.vasut@mailbox.org> wrote:

> On 6/11/26 4:08 PM, Rasmus Villemoes wrote:
>> Originally, 'make DEVICE_TREE_DEBUG=1' only generated extra output on
>> the console. But since 6cdd7597a2f ("kbuild: Produce diff between base
>> DT and U-Boot augmented DT if DEVICE_TREE_DEBUG=1"), that has also
>> left behind lots of files that clutter the repo and are hard to get
>> rid of manually.
>>
>> Make sure that a 'make clean' will remove those files, and add them to
>> .gitignore.
>>
>> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>> ---
>>   .gitignore | 3 +++
>>   Makefile   | 1 +
>>   2 files changed, 4 insertions(+)
>
> This is nice, thank you.
>
>> diff --git a/.gitignore b/.gitignore
>> index d57d3be0291..0e09715cc60 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -16,6 +16,9 @@
>>   *.dtb
>>   *.dtbo
>>   *.dtb.S
>> +*.dtb.clean.dts
>> +*.dtb.diff
>> +*.dtb.full.dts
> Would it make sense to simply change this to *.dtb.* ? Or do you think
> that is too much ?

I think I'm leaning on the explicit mention of each suffix. Had there
already been a *.dtb.* pattern, I would probably not have noticed and
thus not been prompted to amend the 'make clean' rule, so I think it's
better that some potential future .dtb.foo artifact does show up in 'git
status' as an untracked file. But this is certainly not a strong
opinion, and I'd be fine either way.

Rasmus
