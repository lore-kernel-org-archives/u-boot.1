Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11B8CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C25E786FDC;
	Sun, 15 Oct 2023 09:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bs3NiW0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3416F86F04; Sun, 15 Oct 2023 09:33:19 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0761386F88
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-774141bb415so213265985a.3
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697355102; x=1697959902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NI0vbBfTpdpIfzcMEMgs4xqGAMu68hFK4woSxZPZniI=;
 b=bs3NiW0jWrgKmzAimTfzE+/vwyb4yFthA1EB6R/K6J8xpjwtpnu6hf8BouVXeomJAw
 nfkf0nvkVNic+1M98ZqYQCKUBbMXYeItxFQQkRfQWMGRnuKGj3MyG+hrmCofYKYSdFPa
 8EqVgcxabwmsgNGieEVdZPUGMsC5iNf7HWmWR1zy0R28fDsm0kLSYvsQcqdjH27D27+x
 8In48a+pnDiJVBCCFlvxIfDLAB/LKkxfyHUulYVDmPdiwmfRJMaNABXOuz0TLTGTeMq4
 wSxLdkDF9+5pItVP7K/hgSgdI88WAv/zRaOQIyuWx3vHW+j0gG6TuavmeFE6sOvIfYpw
 hNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697355102; x=1697959902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NI0vbBfTpdpIfzcMEMgs4xqGAMu68hFK4woSxZPZniI=;
 b=t8xeOzdLgGSihDiFPD4OXIoxI61w42n97YorRJZ2qb76cK+huwrj8sQAYk5fAED+j1
 DHiREZj9hAgl1uEH0AR6jq6ItDt+R9j+vQDXRB4JHfDqUMIo9YVOSza71UYWIxncFv+A
 zeFqe8fxl5J9AhrJIHCHS0prAZcUC3J+SmcK5ohF/TCASyipxthhC8KyWIKQUZOQnIy8
 YzbCpOkbsJ9ebYpxRSv1TqsxRLFCbEteW3sz+t1A5RTODP2KaGxg0y9YjJOOQy0020tK
 BBcTyHKUEJxDi7QlJnfZh23KKPoM8BdpGupkR9IO7wxc92Pkzcu3AqXq16vjRT5ZQJ5p
 tK+A==
X-Gm-Message-State: AOJu0Ywp0H3Ew0C675IXN5TqCmxthC1eSSt0chJzEuB4Ld4DKuRsYG+V
 hRYSbQL+KmkLY+mquF+icS/b+MCFMlGh+A==
X-Google-Smtp-Source: AGHT+IGf5XOiobsHk52Cg5USP9GExWsLSRckAVTYjCj9120GugkrcxUT+AZglxdq7vTl/epZNg8UIQ==
X-Received: by 2002:a0c:f247:0:b0:65a:fe8f:14a5 with SMTP id
 z7-20020a0cf247000000b0065afe8f14a5mr27155057qvl.52.1697316490248; 
 Sat, 14 Oct 2023 13:48:10 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 d4-20020a056214184400b006588bd29c7esm1944121qvy.28.2023.10.14.13.48.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:09 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 02/29] spl: nor: Don't allocate header on stack
Date: Sat, 14 Oct 2023 16:47:38 -0400
Message-Id: <20231014204805.439009-3-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
---

(no changes since v1)

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

