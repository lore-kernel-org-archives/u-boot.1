Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9E7D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6325A83AA0;
	Tue, 20 Jan 2026 15:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lHbPTq5Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0612C83B03; Tue, 20 Jan 2026 15:32:50 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ADEC83A8D
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:32:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dwVCx2rnjz9vB1;
 Tue, 20 Jan 2026 15:32:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768919565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HXsniV265UkTlk9MaROReSWJIn9hrS+Q/sDJPm5FJLg=;
 b=lHbPTq5YqRrtrl60z8sNH7nAGf+WK5oUt/l5F3/IdJcP9Jp8N1WfE2lVWTI97m4uXDEirH
 ReDjyypZxi4aYi4wbM52Rtu9AVSqIzFTRJ0cQYT8fjQm0H2hC0mvn+FuXtSrL/kd0V1AaS
 VRmyDK/c0uu2j0VWJqcHPlU2edE/ioEiO2ZnNzYeoOi8Kz2c+FyimZdbvtpTSgeHur3pvM
 b8a1RNEAn4BZQTt+k/GMlPrYmpyYXkxdhYrw6F9cq9OFzTzSb9ygypbQ5UaqMqS2Tnh0oe
 SaGVqexCvTCqi6vNg0ksP41VuwL93BYTdLr90F9Z8epaOWA/2ubcKeXWg/inig==
Message-ID: <d6ea8e7c-1fc4-4f05-8a6b-805c0be12f4c@mailbox.org>
Date: Tue, 20 Jan 2026 15:32:43 +0100
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
 <baa48570-2114-4313-9bac-280aab0960fb@mailbox.org>
 <58101ca60af16df66be8e2707fef2597f855a8e1.camel@microchip.com>
 <712cfdc9-b3c3-4fca-8f14-763efdf5e0ae@mailbox.org>
 <856f8b6cdbc2311ac535d9b03c6e2d21a859c526.camel@microchip.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <856f8b6cdbc2311ac535d9b03c6e2d21a859c526.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8jp5daap38twgi4dtosryxwosuwmnzmi
X-MBO-RS-ID: eea1d3c66b4bc3541ec
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

On 1/20/26 2:53 PM, Jamie.Gibbons@microchip.com wrote:
> Hi Marek,
> 
> On Tue, 2026-01-20 at 11:58 +0100, Marek Vasut wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>>
>> On 1/20/26 11:45 AM, Jamie.Gibbons@microchip.com wrote:
>>
>> Hello Jamie,
>>
>>>> 2489                 debug("%s loaded at 0x%08lx len=0x%08lx\n",
>>>> 2490                                 uname, ovload, ovlen);
>>>> 2491                 ov = map_sysmem(ovload, ovlen);
>>>> 2492
>>>> 2493                 ovcopylen = ALIGN(fdt_totalsize(ov), SZ_4K);
>>>> 2494                 ovcopy = memalign(8, ovcopylen);
>>>> 2495                 if (!ovcopy) {
>>>> 2496                         printf("failed to duplicate DTO
>>>> before
>>>> application\n");
>>>> 2497                         fdt_noffset = -ENOMEM;
>>>> 2498                         goto out;
>>>> 2499                 }
>>>> 2500
>>>> 2501                 err = fdt_open_into(ov, ovcopy, ovcopylen);
>>>> 2502                 if (err < 0) {
>>>> 2503                         printf("failed on fdt_open_into for
>>>> DTO\n");
>>>>
>>>> This is where it fails. Is $ov or $ovcopy 4-byte aligned ? Enable
>>>> the
>>>> debug() print at the beginning (or #define DEBUG at the beginning
>>>> of
>>>> this file) to find out.
>>>>
>>>> If $ov is 4-byte aligned, try to generate your fitImage with
>>>> "mkimage
>>>> ... -E -B 8 ..." , does that make any difference ?
>>>
>>> Thank you for your suggestions.
>>>
>>> I followed your advice and investigated the alignment of the
>>> overlay
>>> buffer. The error code returned by fdt_open_into was
>>> FDT_ERR_ALIGNMENT
>>> (-19), confirming that the overlay was not sufficiently aligned for
>>> the
>>> updated libfdt.
>>>
>>> I modified our Buildroot post-image.sh script to generate the FIT
>>> image
>>> using the suggested arguments. With the -B 8 option, all blobs in
>>> the
>>> FIT image are now 8-byte aligned. This resolved the alignment
>>> error,
>>> and device tree overlays are now applied successfully in U-Boot.
>>
>> But this is not the fix. Which parameter of fdt_open_into() is
>> unaligned, the ov or ovcopy ?
> 
> ov is unaligned
Does this help even without the mkimage -B 8 ?

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 2d040e38d97..49fdc1f0535 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2481,7 +2481,7 @@ int boot_get_fdt_fit(struct bootm_headers *images, 
ulong addr,
                         addr, &uname, &uconfig,
                         arch, IH_TYPE_FLATDT,
                         BOOTSTAGE_ID_FIT_FDT_START,
-                       FIT_LOAD_IGNORED, &ovload, &ovlen);
+                       FIT_LOAD_OPTIONAL_NON_ZERO, &ovload, &ovlen);
                 if (ov_noffset < 0) {
                         printf("load of %s failed\n", uname);
                         continue;
