Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12FFEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 12:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54AD7864EA;
	Tue, 22 Aug 2023 14:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m2z/dO3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D83BA86497; Tue, 22 Aug 2023 14:10:46 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2264E86497
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 14:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-307d20548adso3768693f8f.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692706243; x=1693311043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76bBAbUZytI5whAv3vVAMAc0oQ2N7NIs9sExeYZTL/g=;
 b=m2z/dO3qtDCXLrjhd14ea+jOztWgpogEU9rLOfjtCrThcnLRUna4WAgkPUOKlQp0Ku
 VUssMT4sYEyP5WHFkShHm8MLzYhEImHgcinsZ9R0as66HLAdwN07ciIN+9opBxwKKQtS
 A1/R73KjgHHgeMqv1V4cUT2AoSIqGI22FA9wiwdyZ0XcopS4LHp34VUpvuFQHPHZ0Bcy
 8ExJ/oINa+q5MHjzGlLClIuvr1m24rufySg/7u3KBjte9CIRAUNlOWWe+jepSlXnYowe
 kQIeJXHnpuROFcTSOm2tjNJCRcfkM4t3a9+MwGPMDDuhHwESNXkUb3uhVQNHXHV6ZWYn
 TnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692706243; x=1693311043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76bBAbUZytI5whAv3vVAMAc0oQ2N7NIs9sExeYZTL/g=;
 b=VBA7dRkembwLMwYy2HMMlyL2keEDqvqE97hacZvMykD23A+1v/EF8kcDHT52YY7gIG
 qF0QHwF08IrBUKrSGspc19ktHe4v6kp3S2sMdL2NzWxhdRpfh8u1XGSoqbp6TUhXgs9I
 PULLmXbTd3q4zbATACq6Yj2QjI0gw8QS+e5pG66a0LBY/XVV/xzGACbF4ofOQbORUy8h
 boOx5bBv0Q8o29ltVdxTPHcM9+ayD4Kl9sFS52N/kXeGY+CB9BilT9t2PY44TXrzNALt
 VsDHCrPIFBaBQGXEMUOPfg2g3T7Yy2pW+HBr0DgPJiAp/+Pl1FwW5Gi7Iyo1IySx99eh
 9fdQ==
X-Gm-Message-State: AOJu0YzJnKoH4IEvL5ku5JQna8OSHNiTCuXd/GpZMYRuZ9NWsbFDZ4XE
 vaZd0PplqgAuqqyjX+LYVVW9X5tPERY=
X-Google-Smtp-Source: AGHT+IGB59zgVaZhioPjnx7Kk5xKdw2AadVOEF0Eln5Z6sdtcDtHbJX14KRWsxvaAz+G9zrUyO6GxQ==
X-Received: by 2002:a5d:62cf:0:b0:319:79a9:4d9e with SMTP id
 o15-20020a5d62cf000000b0031979a94d9emr6960538wrv.44.1692706243566; 
 Tue, 22 Aug 2023 05:10:43 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 a2-20020adffac2000000b0031753073abcsm15704611wrs.36.2023.08.22.05.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 05:10:43 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v2 2/7] ramfb: Add driver for ramfb display
Date: Tue, 22 Aug 2023 15:10:20 +0300
Message-Id: <20230822121026.1007105-3-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
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

From: Alexander Graf <agraf@csgraf.de>

QEMU implements multiple ways to expose graphics output to the virt
machine, but most of them are incompatible with hardware virtualization.

The one that does work reliably is ramfb. It's a very simple mechanism
in which the guest reserves a memory region for the frame buffer and then
notifies the host about its location and properties. The host then just
displays the contents of the frame buffer on screen.

This patch implements a trivial version of a ramfb driver - hard coded
to a single resolution set in Kconfig.

Signed-off-by: Alexander Graf <agraf@csgraf.de>
[Alper: Deduplicate depends on DM_VIDEO, drop MAINTAINERS, decouple from
        EFI_LOADER, add .bind(), kconfigurable resolution, struct in .h]
Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

Changes in v2:
- Remove extra "depends on DM_VIDEO" already in "if VIDEO"
- Drop drivers/video/MAINTAINERS file
- Decouple framebuffer allocation from EFI_LOADER
- Add .bind() method for ramfb driver
- Make resolution configurable with kconfig
- Move struct to qfw.h and add comments for members
- Use RAMFB_* definitions instead of DEFAULT_*

 drivers/video/Kconfig  | 30 +++++++++++++
 drivers/video/Makefile |  1 +
 drivers/video/ramfb.c  | 97 ++++++++++++++++++++++++++++++++++++++++++
 include/qfw.h          | 10 +++++
 4 files changed, 138 insertions(+)
 create mode 100644 drivers/video/ramfb.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 69f4809cf4a6..6ab46107483e 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -849,6 +849,36 @@ config VIDEO_MCDE_SIMPLE
 	  before u-boot starts, and u-boot will simply render to the pre-
 	  allocated frame buffer surface.
 
+config VIDEO_RAMFB
+	bool "QEMU ramfb display driver for in-RAM display"
+	depends on QFW
+	help
+	  Enables a RAM based simple frame buffer driver which uses qfw to
+	  notify the hypervisor about the location of a Frame Buffer allocated
+	  in guest RAM as well as its properties.
+
+if VIDEO_RAMFB
+
+config VIDEO_RAMFB_SIZE_X
+	int "Width of ramfb display (X resolution)"
+	default 1280
+	help
+	  Sets the width of the ramfb display.
+
+	  These two options control the size of the display set up by QEMU.
+	  Typical sizes are 1024 x 768 or 1280 x 1024.
+
+config VIDEO_RAMFB_SIZE_Y
+	int "Height of ramfb display (Y resolution)"
+	default 1024
+	help
+	  Sets the height of the ramfb display.
+
+	  These two options control the size of the display set up by QEMU.
+	  Typical sizes are 1024 x 768 or 1280 x 1024.
+
+endif
+
 config OSD
 	bool "Enable OSD support"
 	depends on DM
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index d13af9f3b19b..775b4e46e600 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_VIDEO_SANDBOX_SDL) += sandbox_sdl.o
 obj-$(CONFIG_VIDEO_SIMPLE) += simplefb.o
 obj-$(CONFIG_VIDEO_VESA) += vesa.o
 obj-$(CONFIG_VIDEO_SEPS525) += seps525.o
+obj-$(CONFIG_VIDEO_RAMFB) += ramfb.o
 obj-$(CONFIG_VIDEO_ZYNQMP_DPSUB) += zynqmp/
 
 obj-y += bridge/
diff --git a/drivers/video/ramfb.c b/drivers/video/ramfb.c
new file mode 100644
index 000000000000..ba17cac312b6
--- /dev/null
+++ b/drivers/video/ramfb.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2022 Alexander Graf
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <log.h>
+#include <video.h>
+#include <asm/global_data.h>
+#include <qfw.h>
+
+#define fourcc_code(a, b, c, d) ((u32)(a) | ((u32)(b) << 8) | \
+				 ((u32)(c) << 16) | ((u32)(d) << 24))
+#define DRM_FORMAT_XRGB8888 fourcc_code('X', 'R', '2', '4')
+
+#define RAMFB_WIDTH	CONFIG_VIDEO_RAMFB_SIZE_X
+#define RAMFB_HEIGHT	CONFIG_VIDEO_RAMFB_SIZE_Y
+#define RAMFB_BPIX	VIDEO_BPP32
+#define RAMFB_FORMAT	VIDEO_X8R8G8B8
+
+static int ramfb_probe(struct udevice *dev)
+{
+	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
+	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
+	u32 selector;
+	int ret;
+	struct fw_file *file;
+	struct udevice *qfw;
+	struct dm_qfw_ops *ops;
+	struct qfw_dma dma = {};
+	struct ramfb_cfg cfg = {
+		.addr = cpu_to_be64(plat->base),
+		.fourcc = cpu_to_be32(DRM_FORMAT_XRGB8888),
+		.flags = 0,
+		.width = cpu_to_be32(RAMFB_WIDTH),
+		.height = cpu_to_be32(RAMFB_HEIGHT),
+		.stride = 0,
+	};
+
+	if (plat->base == 0)
+		return -EPROBE_DEFER;
+
+	debug("%s: Frame buffer base %lx\n", __func__, plat->base);
+
+	ret = qfw_get_dev(&qfw);
+	if (ret)
+		return -EPROBE_DEFER;
+
+	ops = dm_qfw_get_ops(qfw);
+	if (!ops)
+		return -EPROBE_DEFER;
+
+	file = qfw_find_file(qfw, "etc/ramfb");
+	if (!file) {
+		/* No ramfb available. At least we tried. */
+		return -ENOENT;
+	}
+
+	uc_priv->xsize = RAMFB_WIDTH;
+	uc_priv->ysize = RAMFB_HEIGHT;
+	uc_priv->bpix = RAMFB_BPIX;
+	uc_priv->format = RAMFB_FORMAT;
+	uc_priv->fb = (void *)plat->base;
+	uc_priv->fb_size = plat->size;
+
+	selector = be16_to_cpu(file->cfg.select);
+	dma.length = cpu_to_be32(sizeof(cfg));
+	dma.address = cpu_to_be64((uintptr_t)&cfg);
+	dma.control = cpu_to_be32(FW_CFG_DMA_WRITE | FW_CFG_DMA_SELECT |
+				  (selector << 16));
+
+	barrier();
+
+	/* Send a DMA write request which enables the screen */
+	ops->read_entry_dma(qfw, &dma);
+
+	return 0;
+}
+
+static int ramfb_bind(struct udevice *dev)
+{
+	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+
+	/* Set the maximum supported resolution */
+	uc_plat->size = RAMFB_WIDTH * RAMFB_HEIGHT * VNBYTES(RAMFB_BPIX);
+	debug("%s: Frame buffer size %x\n", __func__, uc_plat->size);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(ramfb) = {
+	.name	= "ramfb",
+	.id	= UCLASS_VIDEO,
+	.probe	= ramfb_probe,
+	.bind   = ramfb_bind,
+};
diff --git a/include/qfw.h b/include/qfw.h
index d3aaa4d54efc..811abac6fd27 100644
--- a/include/qfw.h
+++ b/include/qfw.h
@@ -142,6 +142,16 @@ struct bios_linker_entry {
 	};
 } __packed;
 
+/* ramfb configuration details to read into etc/ramfb fw_cfg file */
+struct ramfb_cfg {
+	__be64 addr;	/* Address of an allocated framebuffer */
+	__be32 fourcc;	/* Pixel format in Linux DRM fourcc code */
+	__be32 flags;	/* Unknown, appears unused */
+	__be32 width;	/* Width of the requested ramfb display */
+	__be32 height;	/* Height of the requested ramfb display */
+	__be32 stride;	/* Number of bytes per line? */
+} __packed;
+
 /* DMA transfer control data between UCLASS_QFW and QEMU. */
 struct qfw_dma {
 	__be32 control;
-- 
2.40.1

