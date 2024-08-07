Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F797C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF4B88B28;
	Thu,  8 Aug 2024 00:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ENhdJamN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ABCF88B0F; Thu,  8 Aug 2024 00:48:20 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8DC88A6E
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-81f8f0198beso16914639f.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070895; x=1723675695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x1ucNQIn7MFX0LbrnoTZIqKiel2ZIGAWoT2/hhgrgic=;
 b=ENhdJamNzQHiRJqBWj9SO9vj5EHfOf55EiIxVdThqepROHNPtda/v8d19BEhDosMIN
 em11AjVQjE3ABMA/VK9E3Iz/10wllRYZT6V0aybbGv9ZzthJl5bIuzIRajjthK4Ud1zy
 qLDCagkRNGVCHKT9bKYnCZhTMKu5dv2RflnGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070895; x=1723675695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x1ucNQIn7MFX0LbrnoTZIqKiel2ZIGAWoT2/hhgrgic=;
 b=E6ATDhYO0Hgci0xPVkyuAGNDAl4lSMwIMj2oscRQt8f4+VWM1HpXfSCB3lPMipLsZQ
 /FojfQRO6o8IzwWNT324al2/KmfrSp+0/HuVAW2xXsZbtxpeXYXX6wWCZ7Cpe6E+xEGw
 Zh3+prMjRK/s7vGJKkjUM8+2cwFVahZ54DZnbWoEUI0d69hyXbYX4i8wS6MJ/rElCesG
 k9QD9sqv1ANh864DjRMpqt/VUdYFQhwRA9hB1POOTRD8A6SxQwNMKg4OUwBSBFWbNfSh
 whe279gzj/ZHrUxWJtKLySPZURosywWYOt3j+F4A5DPSQhfw9qaa47ks2HHD6Ubd5SFc
 fPSQ==
X-Gm-Message-State: AOJu0YxXwjOVrQiruGv/2xGpR8U6QdHnXwPcCAHyhpQ2PavTMrayeqtd
 d13dlC3Xzei0S5zeK6duMXW7yrMHIzjtsVJHJij/4gAjjZHCSgNhBBxt8vWv4R8emz3GYjR30WA
 =
X-Google-Smtp-Source: AGHT+IEM1OCZ6ZLmihm4zXb5IjjpLzq5IB2F89+QV8Qj9MG7mIoNeBjGU1JxnSOPaj3bixj25UDczQ==
X-Received: by 2002:a05:6e02:152e:b0:398:770d:1fa4 with SMTP id
 e9e14a558f8ab-39b5ed3a401mr735475ab.25.1723070895334; 
 Wed, 07 Aug 2024 15:48:15 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 13/21] upl: Add support for Universal Payload in SPL
Date: Wed,  7 Aug 2024 16:47:31 -0600
Message-Id: <20240807224739.3858517-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
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

(no changes since v2)

Changes in v2:
- Add a function to init the UPL process in SPL

 MAINTAINERS          |   1 +
 boot/Kconfig         |  32 ++++++++
 common/spl/Makefile  |   2 +
 common/spl/spl_upl.c | 172 +++++++++++++++++++++++++++++++++++++++++++
 include/spl.h        |  16 ++++
 5 files changed, 223 insertions(+)
 create mode 100644 common/spl/spl_upl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d17c966053..43d430c603a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1715,6 +1715,7 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-dm.git
 F:	boot/upl*
 F:	cmd/upl.c
+F:	common/spl/spl_upl.c
 F:	doc/usage/cmd/upl.rst
 F:	include/upl.h
 F:	test/boot/upl.c
diff --git a/boot/Kconfig b/boot/Kconfig
index e37b08bf391..60a4cddf5ec 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -750,6 +750,7 @@ config UPL
 	imply CMD_UPL
 	imply UPL_READ
 	imply UPL_WRITE
+	imply SPL_UPL if SPL
 	help
 	  Provides support for UPL payloads and handoff information. U-Boot
 	  supports generating and accepting handoff information. The mkimage
@@ -766,11 +767,42 @@ config UPL_READ
 
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
 
 endif # BOOTSTD
diff --git a/common/spl/Makefile b/common/spl/Makefile
index 4809f9c3ec1..137b18428bd 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -37,3 +37,5 @@ obj-$(CONFIG_$(SPL_TPL_)SPI_LOAD) += spl_spi.o
 obj-$(CONFIG_$(SPL_TPL_)RAM_SUPPORT) += spl_ram.o
 obj-$(CONFIG_$(SPL_TPL_)USB_SDP_SUPPORT) += spl_sdp.o
 endif
+
+obj-$(CONFIG_$(SPL_TPL_)UPL) += spl_upl.o
diff --git a/common/spl/spl_upl.c b/common/spl/spl_upl.c
new file mode 100644
index 00000000000..067d437150f
--- /dev/null
+++ b/common/spl/spl_upl.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * UPL handoff parsing
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <alist.h>
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
+void upl_set_fit_addr(ulong fit)
+{
+	struct upl *upl = &s_upl;
+
+	upl->fit = fit;
+}
+
+void upl_set_fit_info(ulong fit, int conf_offset, ulong entry_addr)
+{
+	struct upl *upl = &s_upl;
+
+	upl->fit = fit;
+	upl->conf_offset = conf_offset;
+	log_debug("upl: add fit %lx conf %x\n", fit, conf_offset);
+}
+
+int _upl_add_image(int node, ulong load_addr, ulong size, const char *desc)
+{
+	struct upl *upl = &s_upl;
+	struct upl_image img;
+
+	img.load = load_addr;
+	img.size = size;
+	img.offset = node;
+	img.description = desc;
+	if (!alist_add(&upl->image, img))
+		return -ENOMEM;
+	log_debug("upl: add image %s at %lx size %lx\n", desc, load_addr, size);
+
+	return 0;
+}
+
+static int write_serial(struct upl_serial *ser)
+{
+	struct udevice *dev = gd->cur_serial_dev;
+	struct serial_device_info info;
+	struct memregion region;
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
+	region.base = info.addr;
+	region.size = info.size;
+	alist_init_struct(&ser->reg, struct memregion);
+	if (!alist_add(&ser->reg, region))
+		return -ENOMEM;
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
+	struct memregion region;
+	struct udevice *dev;
+
+	alist_init_struct(&gra->reg, struct memregion);
+	uclass_find_first_device(UCLASS_VIDEO, &dev);
+	if (!dev || !device_active(dev))
+		return log_msg_ret("vid", -ENOENT);
+
+	plat = dev_get_uclass_plat(dev);
+	region.base = plat->base;
+	region.size = plat->size;
+	if (!alist_add(&gra->reg, region))
+		return log_msg_ret("reg", -ENOMEM);
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
+	log_debug("UPL: Writing handoff - image_count=%d\n", upl->image.count);
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
+
+void spl_upl_init(void)
+{
+	upl_init(&s_upl);
+}
diff --git a/include/spl.h b/include/spl.h
index 1eebea3f981..f92089b69ea 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -1073,4 +1073,20 @@ static inline bool spl_decompression_enabled(void)
 {
 	return IS_ENABLED(CONFIG_SPL_GZIP) || IS_ENABLED(CONFIG_SPL_LZMA);
 }
+
+/**
+ * spl_write_upl_handoff() - Write a Universal Payload hand-off structure
+ *
+ * @spl_image: Information about the image being booted
+ * Return: 0 if OK, -ve on error
+ */
+int spl_write_upl_handoff(struct spl_image_info *spl_image);
+
+/**
+ * spl_upl_init() - Get UPL ready for information to be added
+ *
+ * This must be called before upl_add_image(), etc.
+ */
+void spl_upl_init(void);
+
 #endif
-- 
2.34.1

