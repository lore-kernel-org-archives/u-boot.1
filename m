Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796E0C982DB
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 16:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAEE883015;
	Fri, 16 Jan 2026 17:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PW8dkuNs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24A758309A; Fri, 16 Jan 2026 17:33:17 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D42C82BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 17:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dt54n0Pzcz9t9Z;
 Fri, 16 Jan 2026 17:33:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768581193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XoaKmOYElTjwM/yBAoU+MSlXFAOitdXCQlX5vo4VqhE=;
 b=PW8dkuNsh1Nf0IwUYW5SOGIAzISNLnOLMczonFSULtqQnKF9HZKMlLjGyd7AT1jCx/14/a
 TwSKRKtoL2RRgFG66NKcef0OrXT/Q2fAeHmTk9FleiX1YIqqsRs54ZeZ3z9MktG+jXKGJP
 6nFi9MohvUxfV21UQy+Zg/ix2L6BB21i4n64NVxMRwaw+dEHZfzWKZRgKHNWISOjxh6aCL
 hDuLJMqISBLxIwz3qYdq+CjGo4BMVtrQfBN0oKhHfWhjryRDo9bb/9g9c+SReBaUJb0fWH
 KnJNECviFKMcf5vCQR9w/HEsJ/1zB7Mqyzb3MGtwECHhY9VsWDwHx66Y7Z3q3w==
Message-ID: <82e5aebe-5792-4a68-b054-7f90dd82e7b3@mailbox.org>
Date: Fri, 16 Jan 2026 17:33:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
To: Jamie.Gibbons@microchip.com, trini@konsulko.com
Cc: u-boot@lists.denx.de, Conor.Dooley@microchip.com,
 Valentina.FernandezAlanis@microchip.com
References: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
 <d5d2320f54090420c32207c25b35c881ea1519b4.camel@microchip.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <d5d2320f54090420c32207c25b35c881ea1519b4.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0f3fcd6fbc9be57659a
X-MBO-RS-META: 6t5inczz3ssja94jj8iutqy6fc4sc4t4
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

On 1/16/26 5:13 PM, Jamie.Gibbons@microchip.com wrote:
> Hi Tom, Marek,
> On Tue, 2025-12-02 at 20:32 +0100, Marek Vasut wrote:
>> Synchronize local copy of DTC with Linux 6.17 . This includes the
>> following picked and squashed commits from Linux kernel. The squash
>> was necessary, since the DTC here contains changes which were also
>> part of DTC in Linux alraedy, and the squash helped resolve those
>> without going back and forth with the changes.
>>
>> The following commits from Linux are picked:
>>
>> 8f324cd712df7 # scripts/dtc: consolidate include path options in
>> Makefile
>> b5b3d9b63b0ee # scripts/dtc: Add yamltree.c to dtc sources
>> 7d97a76f226d6 # scripts/dtc: Update to upstream version v1.4.7-14-
>> gc86da84d30e4
>> ea6f243be74e5 # scripts/dtc: Update to upstream version v1.4.7-57-
>> gf267e674d145
>> 02d435d4eccd8 # scripts/dtc: Update to upstream version v1.5.0-23-
>> g87963ee20693
>> 6e321b7637396 # scripts/dtc: Update to upstream version v1.5.0-30-
>> g702c1b6c0e73
>> 9f19ec91a7a35 # scripts/dtc: dtx_diff - add color output support
>> 8287d642f38d1 # scripts/dtc: Update to upstream version v1.5.1-22-
>> gc40aeb60b47a
>> 4c52deef9225d # scripts/dtc: Revert "yamltree: Ensure consistent
>> bracketing of properties with phandles"
>> 5d3827e1452ed # scripts/dtc: Remove unused makefile fragments
>> 40dd266887654 # scripts/dtc: Update to upstream version v1.6.0-2-
>> g87a656ae5ff9
>> 8d4cf6b6acb59 # scripts/dtc: use pkg-config to include <yaml.h> in
>> non-standard path
>> b9bf9ace5ae90 # scripts/dtc: Update to upstream version v1.6.0-11-
>> g9d7888cbf19c
>> 69a883b6f5ac0 # scripts/dtc: dtx_diff - make help text formatting
>> consistent
>> 8f829108b8aed # scripts/dtc: only append to HOST_EXTRACFLAGS instead
>> of overwriting
>> b39b4342ac495 # scripts/dtc: Update to upstream version v1.6.0-31-
>> gcbca977ea121
>> 93c6424c486b3 # scripts: dtc: Fetch fdtoverlay.c from external DTC
>> project
>> 0dd574a1d75c3 # scripts/dtc: Update to upstream version v1.6.0-51-
>> g183df9e9c2b9
>> ec38b5df8a231 # scripts: dtc: Build fdtoverlay tool
>> a0c8c431411f5 # scripts: dtc: Remove the unused fdtdump.c file
>> e7dc653d4e890 # scripts/dtc: Add missing fdtoverlay to gitignore
>> d2bf5d2e3f09c # scripts/dtc: Update to upstream version v1.6.1-19-
>> g0a3a9d3449c8
>> a60878f5532d0 # scripts/dtc: dtx_diff: remove broken example from help
>> text
>> 8b739d8658a9b # scripts/dtc: Call pkg-config POSIXly correct
>> b6eeafa67df00 # scripts/dtc: Update to upstream version v1.6.1-63-
>> g55778a03df61
>> f96cc4c787588 # scripts/dtc: Update to upstream version v1.6.1-66-
>> gabbd523bae6e
>> 09ab9c092ef2b # scripts/dtc: Update to upstream version v1.7.0-93-
>> g1df7b047fe43
>> ded8a5a498f2d # scripts/dtc: Update to upstream version v1.7.0-95-
>> gbcd02b523429
>> ee6ff6fca7e71 # scripts/dtc: Update to upstream version v1.7.2-35-
>> g52f07dcca47c
>>
>> This also includes forward port of U-Boot commit
>> e8c2d25845c7 ("libfdt: Revert 6dcb8ba4 from upstream libfdt")
>> to avoid binary size growth.
>>
> 
> During testing I discovered the following error on Microchip's PolarFire
> SoC Icicle kit. I found it during a bisect between the v2026.01 tag and
> the master branch while looking to solve another issue. With these other
> issues solved I am left with this one still on master and I am looking
> for some help.
> 
> The error is: failed on fdt_open_into for DTO, i.e. overlay application
> fdt error. This was introduced by 0535e46d55d scripts/dtc: Update to
> upstream version v1.7.2-35-g52f07dcca47c, i.e. this patch. Please see
> the attached log which includes a `printenv` attached.
Does this fix your problem ?

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 2d040e38d97..1163e837d7e 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2491,7 +2491,7 @@ int boot_get_fdt_fit(struct bootm_headers *images, 
ulong addr,
                 ov = map_sysmem(ovload, ovlen);

                 ovcopylen = ALIGN(fdt_totalsize(ov), SZ_4K);
-               ovcopy = malloc(ovcopylen);
+               ovcopy = memalign(8, ovcopylen);
                 if (!ovcopy) {
                         printf("failed to duplicate DTO before 
application\n");
                         fdt_noffset = -ENOMEM;

