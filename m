Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C03CEBF86
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 00:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6158383A56;
	Sun, 16 Nov 2025 01:20:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UnLftIKI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9536683A5A; Sun, 16 Nov 2025 01:20:14 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD3D1839E4
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 01:20:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d8BNB4Qflz9ssd;
 Sun, 16 Nov 2025 01:20:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763252410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7C112OKScA3u4txzPWLR+x5arrRrbB/94++4MQX1plQ=;
 b=UnLftIKILjvfi1yBQPs5+FK4WCEec14OMLxfU1rvaFE8urZpSUZAqXPmgSTeVdjjUb1FBE
 g6gwUvQ/BXABVugFt7giWrrMuTTGGaaaOX0pPfArejLiYJ42VlCrljSev7pMqcykAMmAoj
 hiQrmUNSTASk1cCViio6XfbEUv6aORoZosqlyyIiPLx1NkvKpVHM98kI/m5GqyFtsIHyky
 9NpdEN6Vj6lDAncOHk2vC0pdqJDSfavr1maJl+HEidDgoRxikpBvATxc2lwXel2uo+EvKF
 y11SU7LrogLn8EEdRlXdW2amvGWMm5uLudv/sPJwzqpMR34p7hYK/l7jThpPgA==
Message-ID: <bed4a846-6356-463f-a8a9-3d4bf05439a4@mailbox.org>
Date: Sat, 15 Nov 2025 18:11:20 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>
References: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjofjQ_zmwJrGZ-sLejQ=x=-8tyqr4SBPYgt3683GVAbQ@mail.gmail.com>
 <20251113193816.GP6688@bill-the-cat>
 <CAFLszTjwpoCwCKKvJX5cZMLK480EK-=BWaFd5A6yLMrfsVWC6g@mail.gmail.com>
 <20251113200527.GQ6688@bill-the-cat>
 <CAFLszTjydNqmo=6qLv--m4fB07QzWd01XHGY3hxgTEbarJF-VA@mail.gmail.com>
 <20251113203654.GR6688@bill-the-cat>
 <385cdc16-cf73-443b-a0a1-440e233d4506@mailbox.org>
 <CAFLszThc4YC6mKp5sNsiuCFfaMNqMWJjVV27d4UkyLU4rPWY6A@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszThc4YC6mKp5sNsiuCFfaMNqMWJjVV27d4UkyLU4rPWY6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 212c9a25fed193426c7
X-MBO-RS-META: 4ba5e4ft5irfg91fwabrae4frsohpd3x
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

On 11/14/25 1:45 PM, Simon Glass wrote:

Hello Simon,

>>>>> Which is different from disagreeing with your specific feedback about
>>>>> how we get there, to be clear.
>>>
>>> And again, since your feedback to this patch was "Don't?", I'm saying we
>>> need to. But the rest of your feedback was structural on moving towards
>>> resolving it and so I assume Marek will respond.
>>
>> The "blast radius" are these patches, that's all that tripped the tests:
>>
>>    - boot: android: Always use 8-byte aligned DT with libfdt
>>    - test/py: android: Point fdt command to aligned addresses
>>    - test/py: Use aligned address for overlays in 'extension' test
>>    - sandbox: Fix DT compiler address warnings in sandbox DTs
>>    - sandbox: Fix DT compiler pin warnings in sandbox DTs
>>    - boot: Assure FDT is always at 8-byte aligned address
>>    - arm: qemu: Eliminate fdt_high and initrd_high misuse
>>    - efi_loader: Assure fitImage from capsule is used from 8-byte aligned
>> address
>>    - MIPS: Assure end of U-Boot is at 8-byte aligned offset
>>
>> Regarding last minute alignment, the problem with this android image
>> seems to be in the android image itself, which packs in badly aligned
>> FDT. We therefore have to copy it out and realign.
> 
> My request is to implement these checks as part of the boot flow
> (bootm, etc.) rather than adding memory allocations in leaf function.
> We already support copying the FDT to a different address so we can
> expand it and add things. Can we make use of that code?
It seems the 'abootomg' command is extracting DTB from a container where 
the DTB can be at 4-byte aligned address. Thus far, the command 
internally used that possibly 4-byte aligned address, which is wrong. It 
also returned that address which was used by further U-Boot commands 
as-is, which is also wrong.

This DTB usage here has nothing to do with any boot flow, this is 
incorrect DTB alignment during manipulation, which is not part of boot.

What exactly do you propose should be changed with this patch ?
