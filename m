Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95B7C83F01
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 23:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3481386574;
	Thu, 31 Aug 2023 01:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SqzrHn19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B0EC8656F; Thu, 31 Aug 2023 01:30:09 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2625A8655B
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 01:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-794e0e8b588so11617739f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693438204; x=1694043004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yo4RgK5SnuP8Z2tDNefvft1yhvM4DPbBAimysZAyhEQ=;
 b=SqzrHn19MBibjjhYq3R9ZSIJhcvSAKS3MZsYoMmyoRmNYdjILKAfHUr7qRtdhCjmDA
 1/EXyK4iWqNnSfM578s6kcd0eCfATpLMIbktdM+A0exMc531B5k9mfkJABF5s0+U9hrQ
 3DtPZ9rXFbaEau5oKZSxTvArrfzm0MuntLD/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693438204; x=1694043004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yo4RgK5SnuP8Z2tDNefvft1yhvM4DPbBAimysZAyhEQ=;
 b=Eo5JGmOpF+vX84VohhNvIO0F0Rq8z9rUAtoHMkj7miXEJsBklGKHWo9+dCQvJjyYWE
 cPLbmP4Hsk5z9J/9R6XuIeUpye+pjwYBMpCibPBzfMcH+p8EogKUiZ+HZbM0AjXQhxjd
 d63kEH3jqx2xl9ksB7l0UjkYo7awsuevxwphhPA8bwR/XWSIU+Vxpmrjq8jeXb4MM5D7
 B4cI9872OsTCsMxNpWc7tOCMivegMeSu2njf/v96NtKZwx9L5r4t6HxqDDYCI0d8nnCa
 4e/XmSeEqa9NByuSk9nJOFQVVROZ8wWTS7hdJQ5A8YjkzaNXaizm6CS2aud+X0FgsEMn
 82vA==
X-Gm-Message-State: AOJu0YyrFIO+WPvEaFlffmoqzMdtq8MmhdFGY0p73CSV6za30ZAzEsg2
 SWHUEB1w+5XjtD1qwYw8fGhX/zigX7uLD7zgY28=
X-Google-Smtp-Source: AGHT+IFfQvtN01nvBbZ0cN+epMzbGaBnuNjsVZCDkfmi3HZ9XBa7X86VSFAw+xsvnxl0U4pok4SeAQ==
X-Received: by 2002:a6b:650b:0:b0:787:1555:efca with SMTP id
 z11-20020a6b650b000000b007871555efcamr4187373iob.5.1693438204717; 
 Wed, 30 Aug 2023 16:30:04 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dj14-20020a056602256e00b0077e35ffac2fsm78512iob.32.2023.08.30.16.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 16:30:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [RFC PATCH 5/9] upl: Add support for Universal Payload in SPL
Date: Wed, 30 Aug 2023 17:29:19 -0600
Message-ID: <20230830232928.2590178-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830232928.2590178-1-sjg@chromium.org>
References: <20230830232928.2590178-1-sjg@chromium.org>
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

Add the basic code to create a handoff structure in SPL, so it can be
passed to the next phase. For now this is not plumbed in.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig         |  32 +++++++++
 common/spl/Makefile  |   2 +
 common/spl/spl_upl.c | 153 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 common/spl/spl_upl.c

diff --git a/boot/Kconfig b/boot/Kconfig
index b8b1032ca63..1cefa7d6873 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -681,6 +681,7 @@ config UPL
 	imply CMD_UPL
 	imply UPL_READ
 	imply UPL_WRITE
+	imply SPL_UPL if SPL
 	help
 	  Provides support for UPL payloads and handoff information. U-Boot
 	  supports generating and accepting handoff information. The mkimage
@@ -697,11 +698,42 @@ config UPL_READ
 
 config UPL_WRITE
 	bool "upl - Support writing a Universal Payload handoff"
+	help
+	  Provides support for encoding a UPL-format payload from a C structure
+	  so it can be passed to another program. This is just the writing
+	  implementation, useful for trying it out. See SPL_UPL_OUT
+	  for how to tell U-Boot SPL to actually write it before jumping to
+	  the next phase.
+
+if SPL
+
+config SPL_UPL
+	bool "Write a UPL handoff in SPL"
+	imply SPL_UPL_OUT
+	help
+	  This tells SPL to write a UPL handoff and pass it to the next phase
+	  (e.g. to U-Boot or another program which SPL loads and runs). THis
+	  provides information to help that program run correctly and
+	  efficiently on the machine.
+
+config SPL_UPL_WRITE
+	bool  # upl - Support writing a Universal Payload handoff in SPL
+	select SPL_BLOBLIST
 	help
 	  Provides support for encoding a UPL-format payload from a C structure
 	  so it can be passed to another program. This is just the writing
 	  implementation, useful for trying it out.
 
+config SPL_UPL_OUT
+	bool "upl - Support writing a Universal Payload handoff in SPL"
+	select SPL_UPL_WRITE
+	help
+	  Provides support for encoding a UPL-format payload and passing it to
+	  the next firmware phase. This allows U-Boot SPL to function as
+	  Platform Init in the meaning of the specification.
+
+endif  # SPL
+
 endif  # UPL
 
 endif  # BOOTSTD
diff --git a/common/spl/Makefile b/common/spl/Makefile
index bad2bbf6cf1..8e34933230c 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -36,3 +36,5 @@ obj-$(CONFIG_$(SPL_TPL_)SPI_LOAD) += spl_spi.o
 obj-$(CONFIG_$(SPL_TPL_)RAM_SUPPORT) += spl_ram.o
 obj-$(CONFIG_$(SPL_TPL_)USB_SDP_SUPPORT) += spl_sdp.o
 endif
+
+obj-$(CONFIG_$(SPL_TPL_)UPL) += spl_upl.o
diff --git a/common/spl/spl_upl.c b/common/spl/spl_upl.c
new file mode 100644
index 00000000000..1b284974736
--- /dev/null
+++ b/common/spl/spl_upl.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * UPL handoff parsing
+ *
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_DEBUG
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <common.h>
+#include <bloblist.h>
+#include <dm.h>
+#include <image.h>
+#include <mapmem.h>
+#include <serial.h>
+#include <spl.h>
+#include <upl.h>
+#include <video.h>
+#include <asm/global_data.h>
+#include <dm/read.h>
+#include <dm/uclass-internal.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+struct upl s_upl;
+
+void upl_set_fit_info(ulong fit, int conf_offset, ulong entry_addr)
+{
+	struct upl *upl = &s_upl;
+
+	upl->fit = fit;
+	upl->conf_offset = conf_offset;
+}
+
+int upl_add_image(int node, ulong load_addr, ulong size, const char *desc)
+{
+	struct upl *upl = &s_upl;
+	struct upl_image *img;
+
+	if (upl->num_images == UPL_MAX_IMAGES)
+		return log_msg_ret("img", -E2BIG);
+	img = &upl->image[upl->num_images++];
+	img->load = load_addr;
+	img->size = size;
+	img->offset = node;
+	img->description = desc;
+
+	return 0;
+}
+
+static int write_serial(struct upl_serial *ser)
+{
+	struct udevice *dev = gd->cur_serial_dev;
+	struct serial_device_info info;
+	int ret;
+
+	if (!dev)
+		return log_msg_ret("ser", -ENOENT);
+	ret = serial_getinfo(dev, &info);
+	if (ret)
+		return log_msg_ret("inf", ret);
+
+	ser->compatible = ofnode_read_string(dev_ofnode(dev), "compatible");
+	ser->clock_frequency = info.clock;
+	ser->current_speed = gd->baudrate;
+	ser->reg.base = info.addr;
+	ser->reg.size = info.size;
+	ser->reg_io_shift = info.reg_shift;
+	ser->reg_offset = info.reg_offset;
+	ser->reg_io_width = info.reg_width;
+	ser->virtual_reg = 0;
+	ser->access_type = info.addr_space;
+
+	return 0;
+}
+
+static int write_graphics(struct upl_graphics *gra)
+{
+	struct video_uc_plat *plat;
+	struct video_priv *priv;
+	struct udevice *dev;
+
+	uclass_find_first_device(UCLASS_VIDEO, &dev);
+	if (!dev || !device_active(dev))
+		return -ENOENT;
+
+	plat = dev_get_uclass_plat(dev);
+	gra->reg.base = plat->base;
+	gra->reg.size = plat->size;
+
+	priv = dev_get_uclass_priv(dev);
+	gra->width = priv->xsize;
+	gra->height = priv->ysize;
+	gra->stride = priv->line_length;	/* private field */
+	switch (priv->format) {
+	case VIDEO_RGBA8888:
+	case VIDEO_X8R8G8B8:
+		gra->format = UPLGF_ARGB32;
+		break;
+	case VIDEO_X8B8G8R8:
+		gra->format = UPLGF_ABGR32;
+		break;
+	case VIDEO_X2R10G10B10:
+		log_debug("device '%s': VIDEO_X2R10G10B10 not supported\n",
+			  dev->name);
+		return log_msg_ret("for", -EPROTO);
+	case VIDEO_UNKNOWN:
+		log_debug("device '%s': Unknown video format\n", dev->name);
+		return log_msg_ret("for", -EPROTO);
+	}
+
+	return 0;
+}
+
+int spl_write_upl_handoff(struct spl_image_info *spl_image)
+{
+	struct upl *upl = &s_upl;
+	struct abuf buf;
+	ofnode root;
+	void *ptr;
+	int ret;
+
+	log_debug("UPL: Writing handoff - image_count=%d\n", upl->num_images);
+	memset(upl, '\0', sizeof(struct upl));
+	upl->addr_cells = IS_ENABLED(CONFIG_PHYS_64BIT) ? 2 : 1;
+	upl->size_cells = IS_ENABLED(CONFIG_PHYS_64BIT) ? 2 : 1;
+	upl->bootmode = UPLBM_DEFAULT;
+	ret = write_serial(&upl->serial);
+	if (ret)
+		return log_msg_ret("ser", ret);
+	ret = write_graphics(&upl->graphics);
+	if (ret && ret != -ENOENT)
+		return log_msg_ret("gra", ret);
+
+	root = ofnode_root();
+	ret = upl_write_handoff(upl, root, true);
+	if (ret)
+		return log_msg_ret("wr", ret);
+
+	ret = oftree_to_fdt(oftree_default(), &buf);
+	if (ret)
+		return log_msg_ret("fdt", ret);
+	log_debug("FDT size %zx\n", abuf_size(&buf));
+
+	ptr = bloblist_add(BLOBLISTT_CONTROL_FDT, abuf_size(&buf), 0);
+	if (!ptr)
+		return log_msg_ret("blo", -ENOENT);
+	memcpy(ptr, abuf_data(&buf), abuf_size(&buf));
+
+	return 0;
+}
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

