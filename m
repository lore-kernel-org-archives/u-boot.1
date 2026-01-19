Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D03CCF2DD
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 19:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16A168397D;
	Mon, 19 Jan 2026 20:48:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wA9/gwgJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DF6483981; Mon, 19 Jan 2026 20:48:08 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B9E8389A
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 20:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dw1GD3X2zz9vCQ;
 Mon, 19 Jan 2026 20:48:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768852084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPD1/whn1uwe4mJ8WQoTTS/0/DaEAfmClkP5/H/+2/Y=;
 b=wA9/gwgJ6TZ6dU6x+fHZo9bAozinPQGjakfkGfc9df6MT0Caw8b4CNqbMzlMNl/48z65Qj
 c5HxpTRXRXCz71lwe7reEDyNb+xgRFLFW1xPUvsjEkrnjQKF3b1D71Z51RLovGdzCtLtag
 iQxMKwI0WoXFaII/j9SbS+lVZ2be501JxxRFA6AurpXLxxsDYwpPr8iqioG9+HJmwhLwJr
 5HPWQjvsI5X7mOLKiBJz0CG7SdUKCkQwd+o1ollltATfgIKzpjBvQbQWy+4mKnCVuPZFqU
 mRa1n5mougeZuAeZ3WTEkEQw7E0uXDeb04PcCIRsq7EMWUPub5IFJ5Qeft/Sjw==
Message-ID: <baa48570-2114-4313-9bac-280aab0960fb@mailbox.org>
Date: Mon, 19 Jan 2026 20:48:01 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
To: Jamie.Gibbons@microchip.com, trini@konsulko.com
Cc: u-boot@lists.denx.de, Conor.Dooley@microchip.com,
 Valentina.FernandezAlanis@microchip.com
References: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
 <d5d2320f54090420c32207c25b35c881ea1519b4.camel@microchip.com>
 <82e5aebe-5792-4a68-b054-7f90dd82e7b3@mailbox.org>
 <bb9936a8bafa83fceed86f0805d2340914b52dca.camel@microchip.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <bb9936a8bafa83fceed86f0805d2340914b52dca.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rdbpdump5x1hikpqyjw9d9rth5igi7pp
X-MBO-RS-ID: 8d1f0df621ef35fe748
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

On 1/19/26 6:12 PM, Jamie.Gibbons@microchip.com wrote:

Hello Jamie,

>>> The error is: failed on fdt_open_into for DTO, i.e. overlay
>>> application
>>> fdt error. This was introduced by 0535e46d55d scripts/dtc: Update
>>> to
>>> upstream version v1.7.2-35-g52f07dcca47c, i.e. this patch. Please
>>> see
>>> the attached log which includes a `printenv` attached.
>> Does this fix your problem ?
>>
>> diff --git a/boot/image-fit.c b/boot/image-fit.c
>> index 2d040e38d97..1163e837d7e 100644
>> --- a/boot/image-fit.c
>> +++ b/boot/image-fit.c
>> @@ -2491,7 +2491,7 @@ int boot_get_fdt_fit(struct bootm_headers
>> *images,
>> ulong addr,
>>                   ov = map_sysmem(ovload, ovlen);
>>
>>                   ovcopylen = ALIGN(fdt_totalsize(ov), SZ_4K);
>> -               ovcopy = malloc(ovcopylen);
>> +               ovcopy = memalign(8, ovcopylen);
>>                   if (!ovcopy) {
>>                           printf("failed to duplicate DTO before
>> application\n");
>>                           fdt_noffset = -ENOMEM;
>>
> Apologies for the delayed response. The above proposed solution did not
> change/fix the issue. Any other suggestions would be greatly
> appreciated.
Look at this piece of code in boot/image-fit.c :

2489                 debug("%s loaded at 0x%08lx len=0x%08lx\n",
2490                                 uname, ovload, ovlen);
2491                 ov = map_sysmem(ovload, ovlen);
2492
2493                 ovcopylen = ALIGN(fdt_totalsize(ov), SZ_4K);
2494                 ovcopy = memalign(8, ovcopylen);
2495                 if (!ovcopy) {
2496                         printf("failed to duplicate DTO before 
application\n");
2497                         fdt_noffset = -ENOMEM;
2498                         goto out;
2499                 }
2500
2501                 err = fdt_open_into(ov, ovcopy, ovcopylen);
2502                 if (err < 0) {
2503                         printf("failed on fdt_open_into for DTO\n");

This is where it fails. Is $ov or $ovcopy 4-byte aligned ? Enable the 
debug() print at the beginning (or #define DEBUG at the beginning of 
this file) to find out.

If $ov is 4-byte aligned, try to generate your fitImage with "mkimage 
... -E -B 8 ..." , does that make any difference ?
