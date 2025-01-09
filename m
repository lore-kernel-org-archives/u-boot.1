Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91498E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0161E806DB;
	Thu,  9 Jan 2025 13:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oOZ+kWna";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ACCD806DB; Thu,  9 Jan 2025 13:31:15 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56090805EA
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:31:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a7d7c1b190so2360915ab.3
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736425869; x=1737030669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mE7qIEBzMxNEytH9+1Ydw3htDV/ZecgPOVjmOKabTp4=;
 b=oOZ+kWnaCtnvFDoaNNwEJkrRw2MWLs6+zqEvDD9atoPyOr3mgU30EXM0SOXko9b/Xn
 jj1OTxxpINB3Yybbp3bV7bmLwcBIkcAhm46/QPZ1H85meDI/lgQvPV+E2L2uNoG8ngDQ
 dfa2w60yWNg7ObX03tMmUsQFeS6mxnHGDUoUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425869; x=1737030669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mE7qIEBzMxNEytH9+1Ydw3htDV/ZecgPOVjmOKabTp4=;
 b=Cvs4gfK9xi6HWEunCnCu9A3vumO04oLS/+gSCPSxy0tMOEbYr61Wlu4QrS168bvVlA
 XWZB8b2drZZIypJGKd+BhrNJV6iOVKedbE2WhdRAqJXl0ysZLBktdPx3S8rGEW3YVik6
 UffbvCdlZOi9CpN3d3Xv7nP/qSYl3tbmsLID1NNMu0N4JIdASsCqjMPenbDxkO126rDG
 qFWJ3JmgNM/iLcI+POEsdfDh/cXQlnTruHu7I8Hql2kH8LQ1jf5F2hS2lvauW3z6J84j
 6QJusQw6J/hEMYbgn9IqKtBNFjogAUblbdyfklnXhXHBE6O044WtCgMCrtwrODt1trQN
 Dskw==
X-Gm-Message-State: AOJu0Yxua7/NzYxU5XJdvbYd/4bDYDCw7p1FHAQNyiVfvUHzAgY40/YV
 +LGZHs2K04KYNcU84wC4odcsuhGw4U5UcGEy8XXawmGAWdQ3EomBWQUeLA+0tCK2ARvBG/XUIzU
 =
X-Gm-Gg: ASbGncutupDPTDXpzxkhO19gn2uz7SmqriTVnUXI/gJOAR6X9gTkC6qapMHGFOwlTzW
 0T3RKp4vrR4l+BUNZP+YVGHSpwu9e5/r6VXXqR4xeI4RotTtF+asHsrDEfDT14VUwhshwHzvv9A
 JHBDPSu9soipZOCBKr0+0+wAd1Gd7/H8Yzq+07PKxndX2spQ21o60KxAIvZqdr9rsfnQbOovqko
 +YAHLYJUEsv05yUqG94Ylu4AT1ln7ITxnnsbUaC9MaVFkgr+L1wuqrjedOSEyWVCVU9e0JIcXDs
 oRV32w0KKFZW2a0FWw==
X-Google-Smtp-Source: AGHT+IGSz4hfSlB7i8UAtCIesmu9pKmIVK+bsNBjwfq0OhTXLsNItLZ51d2FqP8p3/V3/ko3sqW5lw==
X-Received: by 2002:a05:6e02:1c4a:b0:3a7:e67f:3c5b with SMTP id
 e9e14a558f8ab-3ce3a9a663fmr47505325ab.2.1736425869423; 
 Thu, 09 Jan 2025 04:31:09 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm281678173.20.2025.01.09.04.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:31:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 15/15] vbe: Update simple-fw to support using the SPL loader
Date: Thu,  9 Jan 2025 05:30:10 -0700
Message-Id: <20250109123010.4005298-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109123010.4005298-1-sjg@chromium.org>
References: <20250109123010.4005298-1-sjg@chromium.org>
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

For a sandbox implementation, where code size is no object, it makes sense
to use the full bootstd drivers to load images.

For real boards, running from SRAM, this adds quite a bit of overhead.

Add a way to load the next phase using just the underlying storage
driver, to reduce code size. For now, only MMC is supported.

Change the log_debug() to show the load address and size in a more
neutral way, rather than suggesting that the load has already happened.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/vbe_common.c    |   2 +-
 boot/vbe_simple_fw.c | 112 +++++++++++++++++++++++++++++--------------
 2 files changed, 77 insertions(+), 37 deletions(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 799f33d9ffa..549a3f955d1 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -152,7 +152,7 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 	if (ret < 0)
 		return log_msg_ret("ld", ret);
 	node = ret;
-	log_debug("loaded to %lx\n", load_addr);
+	log_debug("load %lx size %lx\n", load_addr, len);
 
 	fdt_load_addr = 0;
 	fdt_size = 0;
diff --git a/boot/vbe_simple_fw.c b/boot/vbe_simple_fw.c
index 9da3e49a66e..cb5534fc731 100644
--- a/boot/vbe_simple_fw.c
+++ b/boot/vbe_simple_fw.c
@@ -8,6 +8,7 @@
 
 #define LOG_CATEGORY LOGC_BOOT
 
+#include <binman_sym.h>
 #include <bloblist.h>
 #include <bootdev.h>
 #include <bootflow.h>
@@ -17,13 +18,24 @@
 #include <image.h>
 #include <log.h>
 #include <mapmem.h>
-#include <memalign.h>
 #include <mmc.h>
 #include <spl.h>
 #include <vbe.h>
 #include <dm/device-internal.h>
+#include "vbe_common.h"
 #include "vbe_simple.h"
 
+#ifdef CONFIG_BOOTMETH_VBE_SIMPLE
+binman_sym_extern(ulong, vbe_a, image_pos);
+binman_sym_extern(ulong, vbe_a, size);
+#else
+binman_sym_declare(ulong, vbe_a, image_pos);
+binman_sym_declare(ulong, vbe_a, size);
+#endif
+
+binman_sym_declare(ulong, vpl, image_pos);
+binman_sym_declare(ulong, vpl, size);
+
 /**
  * vbe_simple_read_bootflow_fw() - Create a bootflow for firmware
  *
@@ -54,6 +66,8 @@ int vbe_simple_read_bootflow_fw(struct udevice *dev, struct bootflow *bflow)
 	ret = vbe_read_fit(blk, priv->area_start + priv->skip_offset,
 			   priv->area_size, NULL, &load_addr, &len,
 			   &bflow->name);
+	if (ret)
+		return log_msg_ret("vbe", ret);
 
 	/* set up the bootflow with the info we obtained */
 	bflow->blk = blk;
@@ -63,16 +77,14 @@ int vbe_simple_read_bootflow_fw(struct udevice *dev, struct bootflow *bflow)
 	return 0;
 }
 
-static int simple_load_from_image(struct spl_image_info *spl_image,
+static int simple_load_from_image(struct spl_image_info *image,
 				  struct spl_boot_device *bootdev)
 {
-	struct udevice *meth, *bdev;
-	struct simple_priv *priv;
-	struct bootflow bflow;
 	struct vbe_handoff *handoff;
 	int ret;
 
-	if (xpl_phase() != PHASE_VPL && xpl_phase() != PHASE_SPL)
+	if (xpl_phase() != PHASE_VPL && xpl_phase() != PHASE_SPL &&
+	    xpl_phase() != PHASE_TPL)
 		return -ENOENT;
 
 	ret = bloblist_ensure_size(BLOBLISTT_VBE, sizeof(struct vbe_handoff),
@@ -80,36 +92,64 @@ static int simple_load_from_image(struct spl_image_info *spl_image,
 	if (ret)
 		return log_msg_ret("ro", ret);
 
-	vbe_find_first_device(&meth);
-	if (!meth)
-		return log_msg_ret("vd", -ENODEV);
-	log_debug("vbe dev %s\n", meth->name);
-	ret = device_probe(meth);
-	if (ret)
-		return log_msg_ret("probe", ret);
-
-	priv = dev_get_priv(meth);
-	log_debug("simple %s\n", priv->storage);
-	ret = bootdev_find_by_label(priv->storage, &bdev, NULL);
-	if (ret)
-		return log_msg_ret("bd", ret);
-	log_debug("bootdev %s\n", bdev->name);
-
-	bootflow_init(&bflow, bdev, meth);
-	ret = bootmeth_read_bootflow(meth, &bflow);
-	log_debug("\nfw ret=%d\n", ret);
-	if (ret)
-		return log_msg_ret("rd", ret);
-
-	/* jump to the image */
-	spl_image->flags = SPL_SANDBOXF_ARG_IS_BUF;
-	spl_image->arg = bflow.buf;
-	spl_image->size = bflow.size;
-	log_debug("Image: %s at %p size %x\n", bflow.name, bflow.buf,
-		  bflow.size);
-
-	/* this is not used from now on, so free it */
-	bootflow_free(&bflow);
+	if (USE_BOOTMETH) {
+		struct udevice *meth, *bdev;
+		struct simple_priv *priv;
+		struct bootflow bflow;
+
+		vbe_find_first_device(&meth);
+		if (!meth)
+			return log_msg_ret("vd", -ENODEV);
+		log_debug("vbe dev %s\n", meth->name);
+		ret = device_probe(meth);
+		if (ret)
+			return log_msg_ret("probe", ret);
+
+		priv = dev_get_priv(meth);
+		log_debug("simple %s\n", priv->storage);
+		ret = bootdev_find_by_label(priv->storage, &bdev, NULL);
+		if (ret)
+			return log_msg_ret("bd", ret);
+		log_debug("bootdev %s\n", bdev->name);
+
+		bootflow_init(&bflow, bdev, meth);
+		ret = bootmeth_read_bootflow(meth, &bflow);
+		log_debug("\nfw ret=%d\n", ret);
+		if (ret)
+			return log_msg_ret("rd", ret);
+
+		/* jump to the image */
+		image->flags = SPL_SANDBOXF_ARG_IS_BUF;
+		image->arg = bflow.buf;
+		image->size = bflow.size;
+		log_debug("Image: %s at %p size %x\n", bflow.name, bflow.buf,
+			  bflow.size);
+
+		/* this is not used from now on, so free it */
+		bootflow_free(&bflow);
+	} else {
+		struct udevice *media, *blk;
+		ulong offset, size;
+
+		ret = uclass_get_device_by_seq(UCLASS_MMC, 1, &media);
+		if (ret)
+			return log_msg_ret("vdv", ret);
+		ret = blk_get_from_parent(media, &blk);
+		if (ret)
+			return log_msg_ret("med", ret);
+		if (xpl_phase() == PHASE_TPL) {
+			offset = binman_sym(ulong, vpl, image_pos);
+			size = binman_sym(ulong, vpl, size);
+		} else {
+			offset = binman_sym(ulong, vbe_a, image_pos);
+			size = binman_sym(ulong, vbe_a, size);
+			printf("offset=%lx\n", offset);
+		}
+
+		ret = vbe_read_fit(blk, offset, size, image, NULL, NULL, NULL);
+		if (ret)
+			return log_msg_ret("vbe", ret);
+	}
 
 	/* Record that VBE was used in this phase */
 	handoff->phases |= 1 << xpl_phase();
-- 
2.34.1

