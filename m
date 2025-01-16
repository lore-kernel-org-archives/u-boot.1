Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB6CC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0E66807A7;
	Thu, 16 Jan 2025 02:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cZsrjCYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F826807DC; Thu, 16 Jan 2025 02:28:43 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE463807A7
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844bff5ba1dso32152939f.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990919; x=1737595719; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LXRATSqjr6ZAKInnopUjOHqO1QiBqDud4pKp2dltmI=;
 b=cZsrjCYahIvogKGQZfIDqb+MICNnoFXWIaIB+TT0ralqf4xbiIYzEuRAng6GOECzKI
 zMteT3P450+NAyqCd9JHAyw51X4SmT97tNDsXqJDxGb/qfzu7htZdHEpMvWm35yDq68r
 PSxa2Dw840MKsJGr9qANj0Hcg4873P19dKp6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990919; x=1737595719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LXRATSqjr6ZAKInnopUjOHqO1QiBqDud4pKp2dltmI=;
 b=lmuc28wbuXwKhTZLFy4beSgj6dMaW2m8s5re0JecMCl/tm7NbuWbxHpdfYlGkgiVI9
 xsxrfwp+RoA0uuyBA0DcQ1xd5BTQhaIo5u+RlSB6avbxgi/sr5ks1HPqzKIH7Fs3TCxw
 w2E1Vn8htbhQVYRAFHHwFeNdJG+iOwAgJqBOCx8Sh1mTsumN6L2bL8Q4oT8Bsc0dX/DI
 i4PJ5kjgr78Pf0C29SH/u6nT4UzKIMxKoWngzU41yODI2k80YQPiYs9zSkiLRozuXU7+
 jWkxakS5SGBnzBY3MamN1mbU909Kpk+Vyeroce5hABCJ0DuvAUeA4935Is+db95N/YGC
 BCkA==
X-Gm-Message-State: AOJu0YyAt4ieKWamg3y2Dj9+pysdvmQbWbMNf0g2qmf3LlAa18alBYNr
 q+ksYrPI3tWkYWt432V3g+OZo3LAa2hcREmmz+8P1FSW3aPlmDpIVOeB7qaV1wblbPvFLLmgd0A
 =
X-Gm-Gg: ASbGnct7AYPUWKcHYQ75JpME/kBGd/yudXlDhWSXUAPxECawRpoa5J8iw+b6UDltOFP
 5NMVn48bzukUH/SZh0YGnKETsoy58l+pDwUJsCZZDzt2vQKFccGLE3kFSt4YQEMbkclS421NjW0
 yc/+iKGFFIRP3KgjHvZ890blAjdI7TQVU9HvFd5RwniD7LDf6IF6lsghT1hyX9QgTWNGDJBJTGK
 TMy7513nw/krfV57Q/QL4iaLyC67NLMw9+FqA8N2XrgexvM2zIINNOZDPIEO42NGbg9IgqGusQ6
 Mnf9kVWWoEtXNQKz5Q==
X-Google-Smtp-Source: AGHT+IF1amGfUHINvsqB/cIqI3YWke4BIxxkffuUbwfnqDtdI37nYhG7wHzeDT75z0AuNXMOmI2H9g==
X-Received: by 2002:a05:6e02:1905:b0:3ce:7cf3:27c1 with SMTP id
 e9e14a558f8ab-3ce7cf33107mr68994895ab.1.1736990918700; 
 Wed, 15 Jan 2025 17:28:38 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:28:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 22/22] vbe: Update simple-fw to support using the SPL loader
Date: Wed, 15 Jan 2025 18:27:23 -0700
Message-Id: <20250116012723.2820301-23-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116012723.2820301-1-sjg@chromium.org>
References: <20250116012723.2820301-1-sjg@chromium.org>
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

Changes in v2:
- Split up the first patch into 5 separate patches, to highlight code size

 boot/vbe_common.c    |   2 +-
 boot/vbe_simple_fw.c | 112 +++++++++++++++++++++++++++++--------------
 2 files changed, 77 insertions(+), 37 deletions(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 2bc6c4d73ab..0d51fe762c3 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -239,7 +239,7 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
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

