Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B69BCCD19A
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 22:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE4F83AE9;
	Sun, 16 Nov 2025 23:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kJ6wTUav";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E4683A64; Sun, 16 Nov 2025 23:55:51 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A27E83AAC
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 23:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d8mSM2vnyz9sTl;
 Sun, 16 Nov 2025 23:55:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763333747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zo3Diek2Sxn52mFOGWnugLZWl5ANLZP2PSTBVGCN4Fk=;
 b=kJ6wTUavZr6xm5Cc9K0HOSyHXAJyr9ZEsEq2mnmc0XbfZbem2uDrtvqw7eqn3LG2HVQvJb
 MrA6RnL//8BpAQxbIYtD+QwuG5fDnmGAZgV2YTpZfphTDek6/GxfanRlnLukGSwG2QKYRJ
 1SuQFRggNLA4d4cJxPxIhaEyQz53VBjh+ufdtu9iRJvner1PD+jZL+r79bTOB+Fm0M8TRU
 j1pXy4bA3bNxZVMgn5mLJbyhpst4g7I76InMELqEvIlxLwamiPbAcjPaXLIMEj7oVYBUzr
 2PYLjaVGt/6N6IDSoCI9RRbhiijp5b7WbVsmfrNRYBzka/AtPcdY6UrTrIH3og==
Message-ID: <11a631a3-644a-4c4f-8b09-7202687a4a90@mailbox.org>
Date: Sun, 16 Nov 2025 22:48:45 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Synchronize DTC to 1.7.2
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113175700.GM6688@bill-the-cat>
 <63d6a47c-99cc-48d1-9d71-869c58e2eb69@mailbox.org>
 <20251113184917.GN6688@bill-the-cat>
 <71261c83-0a3e-46b6-a0db-d3587a54d71c@mailbox.org>
 <20251116141151.GC2125796@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251116141151.GC2125796@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 707a8f295f826354ee6
X-MBO-RS-META: 51h6jitf6b87adzipdxehfx3gbwi6icx
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

On 11/16/25 3:11 PM, Tom Rini wrote:
> On Sun, Nov 16, 2025 at 12:23:30AM +0100, Marek Vasut wrote:
>> On 11/13/25 7:49 PM, Tom Rini wrote:
>>
>> Hello Tom,
>>
>>>> CI does show that no boards went oversize . If there is some growth on
>>>> existing devices, maybe we can shrink that, but maintaining obsolete DTC
>>>> code base going forward and picking random updates into it, that will only
>>>> lead to increasing maintenance pain, so I don't want to do that.
>>>
>>> Yeah, it's not an easy spot. But I'm really not happy with growing main
>>> U-Boot almost everywhere by 2KiB - 4KiB, and SPL by ~512 bytes or more
>>> just to keep up. I do see that integratorcp_cm1136 barely grows at all,
>>> so maybe there's something that can be done more widely and just wasn't
>>> clear at first. m68k only grows an average of 500 bytes and MIPS is
>>> ~1KiB. PowerPC grows a lot. RISC-V a little.
>> I suspect this might have to do with DTO support. The imx8mp_dhcom do use
>> DTOs and the fdt_overlay.c code grew a lot.
>>
>> I also found out that if I patch out can_assume() and replace it with plain
>> 1 , then the size drops by 1-2 kiB, but that's probably not what we want to
>> do.
> 
> I'm not sure, maybe we do? Or maybe we need to look and have *one* place
> that confirms correct alignment and either fixes/complains

That's already part of new libfdt, that is also what triggered the 
various fixes I posted recently:

scripts/dtc/libfdt/fdt.c:       if ((uintptr_t)fdt & 7)
scripts/dtc/libfdt/fdt.c:       if ((uintptr_t)fdt & 7)

> , and then
> every follow-up location doesn't need to perform that (or possibly many
> other as well) validation checks. My impression from when I looked at
> the code last, a few year ago, was that it was designed with "validate
> with most? every? function" and we would be happy enough with "validate
> once".

If you can make that assumption -- that whatever we feed into libfdt is 
valid -- then we can simply patch out can_assume() .
