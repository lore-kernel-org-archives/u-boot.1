Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D72CD37B6
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 08:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ACD186504;
	Sat, 16 Sep 2023 10:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="erLq8nxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A6248650A; Sat, 16 Sep 2023 10:23:07 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6772A86503
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 10:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-404573e6c8fso27868855e9.1
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 01:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694852585; x=1695457385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=QuwLIPVk/uRNLcc2W3inuJxZwPuTgc431WKv7WAGimg=;
 b=erLq8nxSUO9R/dbklPee4Fy1dW8SNniwYNHmxap0KlaOMuLkLRLunLTBJZTmcIhu2r
 CS1DXoVRDUwYxry1VB3hZGZRi5HNWyXI8qiU4OOXM1PBJgo4QRqBUvpPVqlpvqc6kd7M
 QKhVk4Jqm7snUaLaQMWD74G3M7fLiATOxqV1Ie5bCJpiLfGymULdTAo58En8P+cTMVGf
 w8Tw0BcRCu/pCG80ZbEclVy0QBQsNBHL2m8we+AmKe2NNRVSOKZFoOunxglMRm1VEckP
 6ZjS0XsUv8tjqw0J+iHyNKPjX0flepCtBNplZWpPUS/r5FNa0xnfBrPgStsXMem5rBlk
 UjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694852585; x=1695457385;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuwLIPVk/uRNLcc2W3inuJxZwPuTgc431WKv7WAGimg=;
 b=p407rDXizc7ltXF7ZimanHBsNGUCcyGltvCXHbMPjeGyTbi3ilORbAG/HK/quoXv46
 UdoIJrlEDblCoUT5nQVQgH4lIw9ay5tsefC6PxCXsZlwoidlFaaZU+Z5HyNAJDonxt1t
 YCtW/USqvjIkc2mapv9NNCXQhXFAc+lRAZmrcqmsPzNWzv+UnNvPgJLumFWa1uL7UA4m
 tmIDkp23ZSsbSfphP86YKYSD03FQdapNZPi+zDyqccAZJ/NO+7lDKrXagRCcKeaUnm5h
 kbcBop2ZOK46CtLKVq1IfnmeaWQMCQWxx81Kt0auIJmZwqcuc9mmulpMfnE2ptlA25mX
 tS3w==
X-Gm-Message-State: AOJu0YyhsPywEJWfrdD2qnJM+80Eh+H4BmLvLiOWMs8x6HvMwRn6pAUJ
 CIiMmdin4+cqOCLwdFGKrdCsafXNwH4=
X-Google-Smtp-Source: AGHT+IEDwQKLjK6/a4+dEn8AgWW211SALM3UZl646rx7yRhISlMLG6VkTKBBpk32wCvG1q4FT6E4Uw==
X-Received: by 2002:a1c:6a0a:0:b0:3fa:77ed:9894 with SMTP id
 f10-20020a1c6a0a000000b003fa77ed9894mr3216138wmc.7.1694852584866; 
 Sat, 16 Sep 2023 01:23:04 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.71.172.204])
 by smtp.gmail.com with ESMTPSA id
 r4-20020adfdc84000000b0031753073abcsm6475794wrj.36.2023.09.16.01.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 01:23:04 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joseph Chen <chenjh@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 1/4] spl: atf: Improve comments and code readability
Date: Sat, 16 Sep 2023 10:23:01 +0200
Message-Id: <20230916082301.583248-1-massimo.pegorer+oss@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Rename bl31_entry static function to avoid name clash with its first
argument. Fix spaces misuse. Describe code accurately: load address
is used if getting entry point address fails, and not if addresses
differ. Remove not up-to-date comment about BL3-2 usage.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 common/spl/spl_atf.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index 2c10252834..3d022ed4e7 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -189,10 +189,10 @@ static inline void raw_write_daif(unsigned int daif)
 
 typedef void (*atf_entry_t)(struct bl31_params *params, void *plat_params);
 
-static void bl31_entry(uintptr_t bl31_entry, uintptr_t bl32_entry,
-		       uintptr_t bl33_entry, uintptr_t fdt_addr)
+static void spl_enter_atf(uintptr_t bl31_entry, uintptr_t bl32_entry,
+			  uintptr_t bl33_entry, uintptr_t fdt_addr)
 {
-	atf_entry_t  atf_entry = (atf_entry_t)bl31_entry;
+	atf_entry_t atf_entry = (atf_entry_t)bl31_entry;
 	void *bl31_params;
 
 	if (CONFIG_IS_ENABLED(ATF_LOAD_IMAGE_V2))
@@ -240,7 +240,7 @@ static int spl_fit_images_find(void *blob, int os)
 
 uintptr_t spl_fit_images_get_entry(void *blob, int node)
 {
-	ulong  val;
+	ulong val;
 	int ret;
 
 	ret = fit_image_get_entry(blob, node, &val);
@@ -253,25 +253,25 @@ uintptr_t spl_fit_images_get_entry(void *blob, int node)
 
 void spl_invoke_atf(struct spl_image_info *spl_image)
 {
-	uintptr_t  bl32_entry = 0;
-	uintptr_t  bl33_entry = CONFIG_TEXT_BASE;
+	uintptr_t bl32_entry = 0;
+	uintptr_t bl33_entry = CONFIG_TEXT_BASE;
 	void *blob = spl_image->fdt_addr;
 	uintptr_t platform_param = (uintptr_t)blob;
 	int node;
 
 	/*
-	 * Find the OP-TEE binary (in /fit-images) load address or
-	 * entry point (if different) and pass it as the BL3-2 entry
-	 * point, this is optional.
+	 * Find (in /fit-images) the TEE binary entry point address
+	 * (or load address if entry point is missing) and pass it as
+	 * the BL3-2 entry point. This is optional.
 	 */
 	node = spl_fit_images_find(blob, IH_OS_TEE);
 	if (node >= 0)
 		bl32_entry = spl_fit_images_get_entry(blob, node);
 
 	/*
-	 * Find the U-Boot binary (in /fit-images) load addreess or
-	 * entry point (if different) and pass it as the BL3-3 entry
-	 * point.
+	 * Find (in /fit-images) the U-Boot binary entry point address
+	 * (or load address if entry point is missing) and pass it as
+	 * the BL3-3 entry point.
 	 * This will need to be extended to support Falcon mode.
 	 */
 
@@ -281,17 +281,13 @@ void spl_invoke_atf(struct spl_image_info *spl_image)
 
 	/*
 	 * If ATF_NO_PLATFORM_PARAM is set, we override the platform
-	 * parameter and always pass 0.  This is a workaround for
+	 * parameter and always pass 0. This is a workaround for
 	 * older ATF versions that have insufficiently robust (or
 	 * overzealous) argument validation.
 	 */
 	if (CONFIG_IS_ENABLED(ATF_NO_PLATFORM_PARAM))
 		platform_param = 0;
 
-	/*
-	 * We don't provide a BL3-2 entry yet, but this will be possible
-	 * using similar logic.
-	 */
-	bl31_entry(spl_image->entry_point, bl32_entry,
-		   bl33_entry, platform_param);
+	spl_enter_atf(spl_image->entry_point, bl32_entry,
+		      bl33_entry, platform_param);
 }
-- 
2.34.1

