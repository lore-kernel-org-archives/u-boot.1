Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91FBC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A6887675;
	Wed,  8 Nov 2023 17:49:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZkUtYTVU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 248AE8774C; Wed,  8 Nov 2023 17:49:43 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E07B787748
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-41cc7b67419so48036981cf.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462166; x=1700066966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uHNEEm3MccHpPyLAYzw2BuGWM8S6BmovX39pCc07NdE=;
 b=ZkUtYTVUl992x7QS3clzOk+vTiBGXXF7id+0oAYopFf5UeA8tmMB+rCGb9MM1Mxe+g
 ImVU0OQyVX0TPV145QkutNuDRNWnhFMWItW1uBKql09uMLNlpTkrznPO3tt0qGrKMC0E
 KJXPbvG960Kw4rrNNrntwK+dfayzkxJ5M6nu878cGkA3C609fl/FvOL1YGVtfR4DyMaL
 CXJ1zRPRxqr6DeWneKwA3mT083wkQjN72zx8j3VvQkCbv2Suogp3WXtxsYu4aw9sko9Y
 Hm5xDXCQdXqLOzTeX10aU/UKZvyXDC6O76qdSq6nPGuakLqvev7/3N6Ah4OUJOqfL+xO
 muyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462166; x=1700066966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uHNEEm3MccHpPyLAYzw2BuGWM8S6BmovX39pCc07NdE=;
 b=wzo9xG0/K8H1wfef7+QkGN4TrIO6QoxfG5Ll5R45GThFxgj8uHW6mAZzdoJYRzBhAR
 bYYbBYM3jL5KcGA4kUXI/iE3hoFlWrPDSwWtCo22AuC9lfpr7WEXVctdoKNKdjiNFZcD
 RDCb7cs85Cnvehhf4wrTVZu9nGdnAAQTHPyfwgOiyfT7L991xmr1JIZZ3hQRm3hDj5tj
 h11Y09Xw1psozUk4iQDi1aT7PdHHAkkgWWAG2jfMmATIFcGDUyBFGZxDUX/vmdVAmLYw
 PXeuTxsS8tMU+Z/YWxyvV3ysKl1pFHZ5AkbD4gr00TTqvb5HBJrBcGc67o1kdfakdQZ+
 8Hng==
X-Gm-Message-State: AOJu0Yyu9MkGE7R8wCnlTFY8CwCbP9kVqS/gaVDmlt7+7yUvKsThpaXQ
 /ISc5JZbD3jSdTdqD/udF7s=
X-Google-Smtp-Source: AGHT+IGsv60QjxAIPgGonO5jDuP2TdLuE+hCA26k2NfeTtUhzxWkHn50lnpiqLPIRlXkic5z21SYzg==
X-Received: by 2002:a05:622a:1494:b0:419:5309:20fd with SMTP id
 t20-20020a05622a149400b00419530920fdmr2799004qtx.25.1699462166655; 
 Wed, 08 Nov 2023 08:49:26 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 a17-20020a05622a065100b00407906a4c6fsm1061886qtb.71.2023.11.08.08.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:26 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v7 20/26] spl: Convert net to spl_load
Date: Wed,  8 Nov 2023 11:48:52 -0500
Message-Id: <20231108164858.3497420-21-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v6)

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

