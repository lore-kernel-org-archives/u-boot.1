Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE7BCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A83786E16;
	Thu, 12 Oct 2023 03:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VbSqUvyG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 946E786DD6; Thu, 12 Oct 2023 03:57:01 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B8FF86DB1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-773ac11de71so28018085a.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075791; x=1697680591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/wM0vKc1u1bRKoFxFA8aALHzY064sRXE1bRPQ5N9I4=;
 b=VbSqUvyGJS6DrnoXRtaQ0zzeCBYZyqXw90C7leOSIF+CUjC5PQ9FZpzFbFz9By05Gw
 2c0Mp3hd4hsyBDhbWcMlzzGY/i5LEBEdQGh/7K0xZxvJXfa97pvKMjRsbxZSnA+g4WFl
 aKDWDlQse4krqf1uXgu18IMcJK9EiBR1JuusCWwG8gp1kPBze0t+mEt/ZrEjnRxTRJKa
 3q8M4S9MFexWIr1j6pMZV2SQUBj1KSEP8v8KqiwsRV9GbF3vbcQ9sHzOZG0ghzXfa6aZ
 2k3ys8iWWRdQQBxf+f68OZqZrApEgxioi/gWISbkzCeBOKnydC9tM/s4WLCtTGxhC4OY
 YmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075791; x=1697680591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f/wM0vKc1u1bRKoFxFA8aALHzY064sRXE1bRPQ5N9I4=;
 b=t29WTWpecRFM7WdnX1rPMXJjUpYKyLM0PLD+vs0BUpObfOJG3y1PsL6J3rtmEwqDfp
 K2GhwbwhC1NGuX4DKxXaRDuS+zCARRfmALwqcy+wLs3TkWz4Erfvl+A91hj2V4UHlJFv
 4UY/TR+i3+AwM8zBBBebU8nQSDwM3K/3ETLMC2/AoieUbVUZ+hsLeHXVb09mR/qQzZgZ
 PKWsxrseVs2i3keETBADlOH1MNrWtLx0uTgwp2VtsXHJjHggV1m1ho1AnYBPAoq/liMf
 txL/5BDYriood83gaMmW9YUgmvYVfZ85gHkSYKS7pYCCJdt9ma9P7wPlwkHsKZSBwWjk
 N1OQ==
X-Gm-Message-State: AOJu0YyB/rgaG4FesamgOp5nLQmS0QZ4oAGLToEmQMh9uLqUaSpY6yn/
 ysiwyeXPpP8D8fU3HkS7SvVS2yU7dOBVWw==
X-Google-Smtp-Source: AGHT+IFQppmvY2C12HnK2cvZ7egyZy9sLj01gNWdpdu3rFcPAgbIwsh4dyOnrQkMsz+gURyDffbBFg==
X-Received: by 2002:a05:620a:4791:b0:775:c335:1ee8 with SMTP id
 dt17-20020a05620a479100b00775c3351ee8mr24173894qkb.54.1697075791136; 
 Wed, 11 Oct 2023 18:56:31 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 pj40-20020a05620a1da800b007743360b3fasm5666775qkn.34.2023.10.11.18.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:30 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 02/26] spl: nor: Don't allocate header on stack
Date: Wed, 11 Oct 2023 21:56:02 -0400
Message-Id: <20231012015626.3487451-3-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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

spl_image_info.name contains a reference to legacy_img_hdr. If we allocate
the latter on the stack, it will be clobbered after we return. This was
addressed for NAND back in 06377c5a1fc ("spl: spl_legacy: Fix NAND boot on
OMAP3 BeagleBoard"), but that commit didn't fix NOR.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 common/spl/spl_nor.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
index 79d4f1d7aa8..c141a9ae629 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -26,7 +26,7 @@ unsigned long __weak spl_nor_get_uboot_base(void)
 static int spl_nor_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
 {
-	__maybe_unused const struct legacy_img_hdr *header;
+	struct legacy_img_hdr *header;
 	__maybe_unused struct spl_load_info load;
 
 	/*
@@ -41,7 +41,7 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
 		 * Load Linux from its location in NOR flash to its defined
 		 * location in SDRAM
 		 */
-		header = (const struct legacy_img_hdr *)CONFIG_SYS_OS_BASE;
+		header = (void *)CONFIG_SYS_OS_BASE;
 #ifdef CONFIG_SPL_LOAD_FIT
 		if (image_get_magic(header) == FDT_MAGIC) {
 			int ret;
@@ -91,8 +91,8 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
 	 * Load real U-Boot from its location in NOR flash to its
 	 * defined location in SDRAM
 	 */
-#ifdef CONFIG_SPL_LOAD_FIT
 	header = (const struct legacy_img_hdr *)spl_nor_get_uboot_base();
+#ifdef CONFIG_SPL_LOAD_FIT
 	if (image_get_magic(header) == FDT_MAGIC) {
 		debug("Found FIT format U-Boot\n");
 		load.bl_len = 1;
@@ -111,14 +111,11 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
 
 	/* Legacy image handling */
 	if (IS_ENABLED(CONFIG_SPL_LEGACY_IMAGE_FORMAT)) {
-		struct legacy_img_hdr hdr;
-
 		load.bl_len = 1;
 		load.read = spl_nor_load_read;
-		spl_nor_load_read(&load, spl_nor_get_uboot_base(), sizeof(hdr), &hdr);
 		return spl_load_legacy_img(spl_image, bootdev, &load,
 					   spl_nor_get_uboot_base(),
-					   &hdr);
+					   header);
 	}
 
 	return -EINVAL;
-- 
2.37.1

