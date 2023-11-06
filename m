Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F1AC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 03:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFD6D8715B;
	Mon,  6 Nov 2023 03:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BnlL9Fvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A31886CF7; Mon,  6 Nov 2023 03:29:33 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88D0D87068
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7789aed0e46so266542085a.0
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237592; x=1699842392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPNJhuVKuSH6cTi9NqEKmYuZJxAbOqGfQrxVuvXJEvQ=;
 b=BnlL9FviezQG5vlh4toQhTDvWfzYjsrzTbiyEDcELyeyc/dYpFMAG1Ua99adlEMeQH
 SNYxESCt4RBpix/7fMr/36ilSZVtErLF1qcCzObh+htkpWr9NQ3PW8iBadjo02PKUvOA
 5GxN2arOjzUn5dzcyX4UdVVu+VvDK04joedgfSubW2w9be7noqel0Thxw3QkeIPb/IwY
 2i9ctuQ2I1eyBNvlharkE8qiZJBXth2tviKJR94yTXueK5ONH+meaaBcCVAFT4ppKkLy
 VNs1O8VUS1+Esr6q0FZIDvrwPXbbjaWQAAWcw5zC6rZjsSAsRyIKBbqobvH1fuw1qqfl
 N9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237592; x=1699842392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPNJhuVKuSH6cTi9NqEKmYuZJxAbOqGfQrxVuvXJEvQ=;
 b=OkklfcdP8s1tu6jCP6wOSaQwRoIcL4Ep8jsDlrKvU4uycpPt/6Gi/VsTNx1D6TwCMz
 9KbH7fro+qpPRRPG4eaWPCNrWKEkCqqXpaDg5i09qRJ+2/8hthYmjpIFiqY4Sr1sS1uM
 yOrMwnDltwlLkPxaaqS3M5AqfbK0nht39nVk+ERYRnfuCrWhiLrhZ/5bnYKGQqMAtDfO
 0ndpCA8+76QKQNDDl2KOpM3TxDb+GbKm5Cm+oLCDmOW934g2xFy3LCOr8g6dOhg0vusT
 MLE1+ox5UGsG/Q3ffncolk2gaPGJ+Ye12lc2KXjJ5UMK9/rZyu5WWNGXK8ypEC21TWIZ
 Ikng==
X-Gm-Message-State: AOJu0Yyv/6F06Ca6DGBHzwEtGhf0ErZYYsRR50gBe4JSuMjulvCL4Hny
 vqzJnszkvOLcrajNzrQpN0++Y5zizll07w==
X-Google-Smtp-Source: AGHT+IFdluY7MIjxMtNt70HV2w7RlHCru9MZbPxWOc+GN+M+sLqvMKqmpWm91aFU6d7YCv5eLOkLkQ==
X-Received: by 2002:a37:ac01:0:b0:76f:24bd:fef2 with SMTP id
 e1-20020a37ac01000000b0076f24bdfef2mr26416188qkm.68.1699237591797; 
 Sun, 05 Nov 2023 18:26:31 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 bk41-20020a05620a1a2900b00767d6ec578csm2889032qkb.20.2023.11.05.18.26.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:31 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v6 22/25] spl: Convert semihosting to spl_load
Date: Sun,  5 Nov 2023 21:26:00 -0500
Message-Id: <20231106022603.3405551-23-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
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

This converts the semihosting load method to use spl_load. As a result, it
also adds support for LOAD_FIT_FULL and IMX images.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v6:
- Explicitly initialize load_info members

Changes in v5:
- Rework to load header in spl_load

Changes in v2:
- New

 common/spl/spl_semihosting.c | 52 +++++-------------------------------
 include/spl_load.h           |  1 +
 2 files changed, 7 insertions(+), 46 deletions(-)

diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
index 9b0610b8fc8..941fa911040 100644
--- a/common/spl/spl_semihosting.c
+++ b/common/spl/spl_semihosting.c
@@ -8,18 +8,7 @@
 #include <log.h>
 #include <semihosting.h>
 #include <spl.h>
-
-static int smh_read_full(long fd, void *memp, size_t len)
-{
-	long read;
-
-	read = smh_read(fd, memp, len);
-	if (read < 0)
-		return read;
-	if (read != len)
-		return -EIO;
-	return 0;
-}
+#include <spl_load.h>
 
 static ulong smh_fit_read(struct spl_load_info *load, ulong file_offset,
 			  ulong size, void *buf)
@@ -40,8 +29,7 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
 	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
 	int ret;
 	long fd, len;
-	struct legacy_img_hdr *header =
-		spl_get_load_buffer(-sizeof(*header), sizeof(*header));
+	struct spl_load_info load;
 
 	fd = smh_open(filename, MODE_READ | MODE_BINARY);
 	if (fd < 0) {
@@ -56,38 +44,10 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
 	}
 	len = ret;
 
-	ret = smh_read_full(fd, header, sizeof(struct legacy_img_hdr));
-	if (ret) {
-		log_debug("could not read image header: %d\n", ret);
-		goto out;
-	}
-
-	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
-	    image_get_magic(header) == FDT_MAGIC) {
-		struct spl_load_info load;
-
-		debug("Found FIT\n");
-		load.read = smh_fit_read;
-		spl_set_bl_len(&load, 1);
-		load.priv = &fd;
-
-		ret = spl_load_simple_fit(spl_image, &load, 0, header);
-		goto out;
-	}
-
-	ret = spl_parse_image_header(spl_image, bootdev, header);
-	if (ret) {
-		log_debug("failed to parse image header: %d\n", ret);
-		goto out;
-	}
-
-	ret = smh_seek(fd, 0);
-	if (ret) {
-		log_debug("could not seek to start of image: %d\n", ret);
-		goto out;
-	}
-
-	ret = smh_read_full(fd, (void *)spl_image->load_addr, len);
+	load.read = smh_fit_read;
+	spl_set_bl_len(&load, 1);
+	load.priv = &fd;
+	ret = spl_load(spl_image, bootdev, &load, len, 0);
 	if (ret)
 		log_debug("could not read %s: %d\n", filename, ret);
 out:
diff --git a/include/spl_load.h b/include/spl_load.h
index 2618109cee0..2a20e866cd8 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -102,6 +102,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 	(IS_ENABLED(CONFIG_SPL_NAND_SUPPORT) && !IS_ENABLED(CONFIG_SPL_UBI)) + \
 	IS_ENABLED(CONFIG_SPL_NET) + \
 	IS_ENABLED(CONFIG_SPL_NOR_SUPPORT) + \
+	IS_ENABLED(CONFIG_SPL_SEMIHOSTING) + \
 	0
 
 #if SPL_LOAD_USERS > 1
-- 
2.37.1

