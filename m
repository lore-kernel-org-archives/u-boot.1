Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5ADC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 03:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 633C8870ED;
	Mon,  6 Nov 2023 03:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BE5T02eq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B26886F9F; Mon,  6 Nov 2023 03:29:12 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71B6987021
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41cd7a3e8f8so28290991cf.0
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237588; x=1699842388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCSEX4TwLXUNDiFUR4shBrmByjI4SgINK4Km4dRkQm0=;
 b=BE5T02eq/+fxZodqk4hDrgHGro9oBb2a74RNOZ4RBwdAfdpfTRfQs2oB7IntJ9BWSa
 Zooa+4L29jDa+dTs5vBGA9uRzIi4jGEEqn7Mmpox5Yn3ZGVKQXysf327wG50G4LJVoQ3
 gSXFh11VmrqPA/Mie96GlZs005tvJ77AGLhUBK5t8FyysINPNYiIpGN8lYzEEeSC+BXF
 zlBSAGsY+mKKc8ESoJ54Tz5bgvvnA2XKRcUZXMC0NegVM0OA7kfzNWwwfO7KOlqfMFfv
 iL3rTXUseGrCh5p6TXDK7f1lBm2uC5OZkNeGMhCFBvdfRHK1467r1wVX+s5kZya3+/fl
 QPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237588; x=1699842388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCSEX4TwLXUNDiFUR4shBrmByjI4SgINK4Km4dRkQm0=;
 b=WvRQvCtFqZ/ZbXSnoYssvq9annw8DHisAfsYifAjhNxXlfr9pa6833lK8ASyHYEhz1
 80w/0tF91u7Bg33qnBZNkc3s7VPvBaUX721fJ/d57St0wdkSqxK894H1LbtJ5CiS6xw1
 PzSa7KdnWwhoat2tdJ/URiLL5rdLieDSeNWule8w4Zb5nbajH8wbd/HSrTUm/dut0Gmi
 w8mLuJ5duN0ErjCvLVlJIKyLDSCjcHKN0oPPuqWl0CoSMT47B2niuP0JivTBqKQrvQ3d
 tAZYztO2dIppLyfdu5espzbNFaHlx5AGE/gMKL/pkykiNmAk0DKBHlNryWsuvfXtkVu9
 aL4w==
X-Gm-Message-State: AOJu0YwRfqC7sthxM5QhFePUiwDbBJwWPyy+qWnhcNQ4TxzyIqfsb+CS
 gRBq5iYHEEwBLTzX4WRzmLA=
X-Google-Smtp-Source: AGHT+IFPa+XVrFRSSHshgx+lvpMNmGsjZq1ffjUkHkjagXtksXL2q4DOBHD5yXDVslEmd4xhf2SiAQ==
X-Received: by 2002:a05:6214:21cf:b0:66f:b88c:ff07 with SMTP id
 d15-20020a05621421cf00b0066fb88cff07mr32059188qvh.33.1699237588511; 
 Sun, 05 Nov 2023 18:26:28 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 u18-20020a0ced32000000b006585c7f64a3sm3066253qvq.14.2023.11.05.18.26.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:28 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v6 19/25] spl: Convert net to spl_load
Date: Sun,  5 Nov 2023 21:25:57 -0500
Message-Id: <20231106022603.3405551-20-seanga2@gmail.com>
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

This converts the net load method to use spl_load. As a result, it also
adds support for LOAD_FIT_FULL and IMX images.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v6:
- Explicitly initialize load_info members

Changes in v5:
- Rework to load header in spl_load

 common/spl/spl_net.c      | 29 +++++------------------------
 include/spl_load.h        |  1 +
 test/image/spl_load_net.c |  2 ++
 3 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/common/spl/spl_net.c b/common/spl/spl_net.c
index 47994e28165..898f9df705a 100644
--- a/common/spl/spl_net.c
+++ b/common/spl/spl_net.c
@@ -11,8 +11,8 @@
 #include <errno.h>
 #include <image.h>
 #include <log.h>
-#include <mapmem.h>
 #include <spl.h>
+#include <spl_load.h>
 #include <net.h>
 #include <linux/libfdt.h>
 
@@ -29,8 +29,7 @@ static ulong spl_net_load_read(struct spl_load_info *load, ulong sector,
 static int spl_net_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
 {
-	struct legacy_img_hdr *header = map_sysmem(image_load_addr,
-						   sizeof(*header));
+	struct spl_load_info load;
 	int rv;
 
 	env_init();
@@ -49,27 +48,9 @@ static int spl_net_load_image(struct spl_image_info *spl_image,
 		return rv;
 	}
 
-	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
-	    image_get_magic(header) == FDT_MAGIC) {
-		struct spl_load_info load;
-
-		debug("Found FIT\n");
-		spl_set_bl_len(&load, 1);
-		load.read = spl_net_load_read;
-		rv = spl_load_simple_fit(spl_image, &load, 0, header);
-	} else {
-		debug("Legacy image\n");
-
-		rv = spl_parse_image_header(spl_image, bootdev, header);
-		if (rv)
-			return rv;
-
-		memcpy(map_sysmem(spl_image->load_addr, spl_image->size),
-		       map_sysmem(image_load_addr, spl_image->size),
-		       spl_image->size);
-	}
-
-	return rv;
+	spl_set_bl_len(&load, 1);
+	load.read = spl_net_load_read;
+	return spl_load(spl_image, bootdev, &load, 0, 0);
 }
 #endif
 
diff --git a/include/spl_load.h b/include/spl_load.h
index 38294a21ad0..4777f84ac6b 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -99,6 +99,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 	IS_ENABLED(CONFIG_SPL_FS_FAT) + \
 	IS_ENABLED(CONFIG_SPL_SYS_MMCSD_RAW_MODE) + \
 	(IS_ENABLED(CONFIG_SPL_NAND_SUPPORT) && !IS_ENABLED(CONFIG_SPL_UBI)) + \
+	IS_ENABLED(CONFIG_SPL_NET) + \
 	0
 
 #if SPL_LOAD_USERS > 1
diff --git a/test/image/spl_load_net.c b/test/image/spl_load_net.c
index f570cef163f..9d067a7a592 100644
--- a/test/image/spl_load_net.c
+++ b/test/image/spl_load_net.c
@@ -248,5 +248,7 @@ static int spl_test_net(struct unit_test_state *uts, const char *test_name,
 	return ret;
 }
 SPL_IMG_TEST(spl_test_net, LEGACY, DM_FLAGS);
+SPL_IMG_TEST(spl_test_net, LEGACY_LZMA, DM_FLAGS);
+SPL_IMG_TEST(spl_test_net, IMX8, DM_FLAGS);
 SPL_IMG_TEST(spl_test_net, FIT_INTERNAL, DM_FLAGS);
 SPL_IMG_TEST(spl_test_net, FIT_EXTERNAL, DM_FLAGS);
-- 
2.37.1

