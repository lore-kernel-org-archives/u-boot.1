Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47416C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99A8888856;
	Sat, 13 Jul 2024 09:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NALp/mhT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB447887F3; Sat, 13 Jul 2024 09:03:57 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E51558882D
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2eeb1ba040aso34132901fa.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854234; x=1721459034; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwAtympgi3yNZyNwX2hqQkaKoWrFU7jB4QN/O83FSq8=;
 b=NALp/mhTSjVjZlduwTg279qBJ3iOWD/TKeMhXa0y6HCyUcDK2CHmDkC0TlD2Mdtiqy
 lKtEiO7HClJlVpd1CIax6pcjDPzi2bdo0WIs7JT3xlGZ7kjX1FB2WCs9+beGlxRB5YeB
 KzDK0ybSh5DWNpY0YGOZMhxYMxbMpoElTN1Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854234; x=1721459034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZwAtympgi3yNZyNwX2hqQkaKoWrFU7jB4QN/O83FSq8=;
 b=sQ3Z4UAGZUJQ0+bK9fqhroM+DHMTigqnws40T9SabrXAwx0nlTnS9wtc7ck0svi9rl
 rfRng+cZjBXyW5bHGH2m24w3gc8vgj9QDd4cxgWteUuXGJM08hpzLyDLQzYl0bskZGOd
 KNQdsL9AIEUQF5aUSvfRoV2JNT65mw/8MzoGoV6in8qz3mqTYUWh74IhwGQQ/zkvuQWh
 u2YlXL1CHtb4e2caLn5+Yb/gRtd4h+K/JKtr0bmN4dHN+LPYcpGmSbQJyds2CuZ0RTcy
 ZyYb1q8vyqs6iPLWhQQKewI85M765H31rfjepV/Lab0kFbCic1bSZwaISV7msWmxSTFx
 cVJw==
X-Gm-Message-State: AOJu0YzrURrnGRWqeqKTz5X7wrZwEiLd6UZCB0GUWPok24w2/+qmrWvl
 lEILHVPZtpqzt9bsEuCimKboyn6bAJNBXe4KEsd7ChpOdrYuWl5AKfgQN34UxTqd/zU9djMS5Mc
 =
X-Google-Smtp-Source: AGHT+IEluAiRFqoUZKuIn6lwST+FE7eyjlPCX/lF+745WPiTsmeagh22iNAvaGW+dW8BrA2Za0A9Dg==
X-Received: by 2002:a2e:97cb:0:b0:2ec:1042:fb02 with SMTP id
 38308e7fff4ca-2eeb30b4debmr96932191fa.8.1720854233963; 
 Sat, 13 Jul 2024 00:03:53 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>, Devarsh Thakkar <devarsht@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 14/21] upl: Add support for Universal Payload in SPL
Date: Sat, 13 Jul 2024 08:00:48 +0100
Message-Id: <20240713070055.2172883-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

Changes in v2:
- Add a function to init the UPL process in SPL

 MAINTAINERS          |   1 +
 boot/Kconfig         |  32 ++++++++
 common/spl/Makefile  |   2 +
 common/spl/spl_upl.c | 171 +++++++++++++++++++++++++++++++++++++++++++
 include/spl.h        |  16 ++++
 5 files changed, 222 insertions(+)
 create mode 100644 common/spl/spl_upl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2932273c0d7..5078e8c30f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1700,6 +1700,7 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-dm.git
 F:	boot/upl*
 F:	cmd/upl.c
+F:	common/spl/spl_upl.c
 F:	doc/usage/cmd/upl.rst
 F:	include/upl.h
 F:	test/boot/upl.c
diff --git a/boot/Kconfig b/boot/Kconfig
index 6c322ac99bd..3b7c8dd663c 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -724,6 +724,7 @@ config UPL
 	imply CMD_UPL
 	imply UPL_READ
 	imply UPL_WRITE
+	imply SPL_UPL if SPL
 	help
 	  Provides support for UPL payloads and handoff information. U-Boot
 	  supports generating and accepting handoff information. The mkimage
@@ -740,11 +741,42 @@ config UPL_READ
 
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
index 00000000000..12337a05cc0
--- /dev/null
+++ b/common/spl/spl_upl.c
@@ -0,0 +1,171 @@
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
+int upl_add_image(int node, ulong load_addr, ulong size, const char *desc)
+{
+	struct upl *upl = &s_upl;
+	struct upl_image img;
+
+	img.load = load_addr;
+	img.size = size;
+	img.offset = node;
+	img.description = desc;
+	if (!alist_add(&upl->image, img, struct upl_image))
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
+	if (!alist_add(&ser->reg, region, struct memregion))
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
+	if (!alist_add(&gra->reg, region, struct memregion))
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
index 5dfdf778d2d..089b1864c57 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -1074,4 +1074,20 @@ static inline bool spl_decompression_enabled(void)
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

