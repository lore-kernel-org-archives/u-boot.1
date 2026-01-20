Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7434FD2ED0F
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 10:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D53BF83A8D;
	Tue, 20 Jan 2026 11:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IC84ms1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02CF783A8F; Tue, 20 Jan 2026 11:59:06 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD88683A83
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 11:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dwPTJ49cjz9v6C;
 Tue, 20 Jan 2026 11:59:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768906740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qF3LIjjtr9QC7bjOdwG8UmXSWv3JjxrXat0ZtQEciYw=;
 b=IC84ms1eJCxlnpjr5LsRbQomN+N6NF7YDWOs4XvatYHAHGzTFS6vwkDnWuIVNyYM7KMwVK
 7jclEKp625e8YYF29zjV7HJjCahj+6J6BGw71xfrFXB2oFqf+SiZACUu7if3YI/KI/YxsI
 kc9QVG5R5xL0l54i1dCytyD1QSXl2+3hGo20qlMMYFU0p3XeB3OFdItP0BvYeOmfFZwp6O
 mx6qQ+Ad0C6i0s1euHFEOBD4UVb+iUdjhOi2l5V1Cr+0mNRpSXM5xyGY+zZSx7KS/iEmWO
 xg8qsP+U6E8vLWZQbkP8IUV6xPpgQyjpY0QeyWr7hYrtu3DhutzmSsBvQpGCXQ==
Message-ID: <712cfdc9-b3c3-4fca-8f14-763efdf5e0ae@mailbox.org>
Date: Tue, 20 Jan 2026 11:58:56 +0100
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <58101ca60af16df66be8e2707fef2597f855a8e1.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: o9nr7dqzahyigartgrq767oyf4nd3te9
X-MBO-RS-ID: 9a4550ec1a386cb4966
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

On 1/20/26 11:45 AM, Jamie.Gibbons@microchip.com wrote:

Hello Jamie,

>> 2489                 debug("%s loaded at 0x%08lx len=0x%08lx\n",
>> 2490                                 uname, ovload, ovlen);
>> 2491                 ov = map_sysmem(ovload, ovlen);
>> 2492
>> 2493                 ovcopylen = ALIGN(fdt_totalsize(ov), SZ_4K);
>> 2494                 ovcopy = memalign(8, ovcopylen);
>> 2495                 if (!ovcopy) {
>> 2496                         printf("failed to duplicate DTO before
>> application\n");
>> 2497                         fdt_noffset = -ENOMEM;
>> 2498                         goto out;
>> 2499                 }
>> 2500
>> 2501                 err = fdt_open_into(ov, ovcopy, ovcopylen);
>> 2502                 if (err < 0) {
>> 2503                         printf("failed on fdt_open_into for
>> DTO\n");
>>
>> This is where it fails. Is $ov or $ovcopy 4-byte aligned ? Enable the
>> debug() print at the beginning (or #define DEBUG at the beginning of
>> this file) to find out.
>>
>> If $ov is 4-byte aligned, try to generate your fitImage with "mkimage
>> ... -E -B 8 ..." , does that make any difference ?
> 
> Thank you for your suggestions.
> 
> I followed your advice and investigated the alignment of the overlay
> buffer. The error code returned by fdt_open_into was FDT_ERR_ALIGNMENT
> (-19), confirming that the overlay was not sufficiently aligned for the
> updated libfdt.
> 
> I modified our Buildroot post-image.sh script to generate the FIT image
> using the suggested arguments. With the -B 8 option, all blobs in the
> FIT image are now 8-byte aligned. This resolved the alignment error,
> and device tree overlays are now applied successfully in U-Boot.

But this is not the fix. Which parameter of fdt_open_into() is 
unaligned, the ov or ovcopy ?
