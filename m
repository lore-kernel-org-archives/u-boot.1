Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6ABC44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 18:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C3A784ACF;
	Sun, 19 Jul 2026 20:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Q3B8zh11";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 945D884A5B; Sun, 19 Jul 2026 20:04:17 +0200 (CEST)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6066D84A4B
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 20:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=asrinivasan@tenstorrent.com
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-66825848551so2866641d50.0
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 11:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1784484254; x=1785089054; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OS1agDURoZppaBMGKfF0miyVa+hh68F1CEGHY5gZ8Oc=;
 b=Q3B8zh11+LByVql1xLr5e2ETbmn7U4DK+gU7QsWfJCxjlbWdVMZYPjo4V24jBE44JG
 l78y2x3bi7+T7DY5aL6APvosA6A5cLHMFAxAWG+IjaR9zW1VqXshg14Yc8czUefbBXtE
 p+FdmUNlngFbIss4rF/qBeTFCwZxd7rvZhWVpA5p6CYKNGYNFB06ScsTYdYEXB2Is4Ax
 df2whwtzWNpovRiKVMooBpA6HaB9RQpJauyTyit/Ymr/FnAZF69CdRbR3s/9ue1EHvHD
 Yq7gSQlQzSs81HTfVhMvU7O7o2KSlUlSGDk/eAKeZFRgd76ENIfUcI9R2nl5eqh9Oe8p
 BAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784484254; x=1785089054;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OS1agDURoZppaBMGKfF0miyVa+hh68F1CEGHY5gZ8Oc=;
 b=QD+g+fp5nzua05/Vwch0WzEAvuk77kQPTDLPrdg+MUbcgXKo6O/qzd8/7eJu6o2Sbi
 aQNzkCjqLSReD1xYrAOdMAYccrqQVDFc373UtdZZr2ZGaHomzXrc0+gpKMwMfjlJkBKX
 4zNXic0fy61VjwPZ4hpRNFg5SHWIE25GgTnGR/rk8MJrjw7Fu6sgu2cypwNsfloWZInp
 65L3w2y++9fKPACkmAGDL2TNQ1UmwB/mrXj60oHG++UgIbMZv88INqnSj8P0BGHiNM7P
 xf45efdKHQrMKy+ei7/atTyhMGYE8EryNPk56Sn2Jt1VjfQhWETxRTsN6Xz8xMKNlOza
 V22w==
X-Gm-Message-State: AOJu0YxgPAC8cVOhQ5Zxw0TwaE3xjZC42Xx+PEb00lmFe2G01M6v/Mz4
 7MrNdkvVyY2Nf6hRIAztBraDAHuxji2kpBULlvjSYtHGJ1pikwY5YNS6gJmyGXqQjjE=
X-Gm-Gg: AfdE7ckOdiKgp5RFl7lo5FygALvO8e9qPlMFfjSq84HF9zWFCJAUjcKYZul5ZHmVYC6
 f+lZpBUHBiPgau8bO0badcZzJW4bVlKBJZEKGAgGxUvi3+QpIs6TJE804EQ7Y9gMl802khTfueJ
 hIa1xv+PGitSCeH0oAeTiqhaYAE9oHArw1Lc2IwGmA+cjvFo5HdT1l8PaX0T5SXAsmxxFV4XWhN
 /gDDfk+MAvEQXTg+6I/fYMs/6Bw/O729rV+7FkSfSCQTwjkKP83Stv2bnO2oyTwnXK20V2e0rGp
 pwcXzekZKxb/4uFrmVE2L+L8ke0/4iC/f5d9fGpHz6+CDl8opQAXjGUyuCv9M78S8OL2ACHQyyL
 j2gIqkRDHD6rxKMTyln6EuSCm1u+b43rgufzs4EK+qMjRg7JFtT8nxaQNO1rp9KqoIfkUiziZ0h
 EIToQDX2eG4hHQDGaizjVwewtqqDc/Hwz9cz23mBmH6i82CjUVCjwRbw==
X-Received: by 2002:a53:a6d0:0:b0:667:e2e1:4c with SMTP id
 956f58d0204a3-6683bb03e7bmr1970606d50.2.1784484254208; 
 Sun, 19 Jul 2026 11:04:14 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:423:c42:416:fc31])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6683b513a3esm4879882d50.2.2026.07.19.11.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 11:04:13 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sun, 19 Jul 2026 13:03:37 -0500
Subject: [PATCH NOT-FOR-UPSTREAM 6/8] video: Add Aspeed VGA driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-aspeed_vbios_fixes-v1-6-c94026f28250@oss.tenstorrent.com>
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
In-Reply-To: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Martin Herren <sputnik@on-the-web.ch>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Sun, 19 Jul 2026 20:36:10 +0200
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

Add a video driver for the Aspeed VGA device that relys on the vesa
video implementation and VBIOS emulation. The VBIOS requires a custom
INT15 handler, so that is added in this commit.

This commit isn't usable as is, and depends on the next commit for the
device to actually work. And I'm not sure if the next commit is suitable
for upstream, so I've marked this one as such too.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/video/Kconfig      | 10 ++++++
 drivers/video/Makefile     |  1 +
 drivers/video/aspeed_vga.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index c2acc13139c..012abcebebd 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -874,6 +874,16 @@ config LOGICORE_DP_TX
 	  Note that this is a pure transmitter device, and has no display
 	  capabilities by itself.
 
+config VIDEO_ASPEED_VGA
+	bool "Enable ASPEED AST2600 VGA support"
+	depends on BIOSEMU
+	help
+	  This enables support for the ASPEED AST2600 VGA controller. The
+	  display controller is initialised by running the card's x86 Video
+	  BIOS through the biosemu emulator, so this driver depends on
+	  CONFIG_BIOSEMU. A small INT 15h handler is supplied to satisfy the
+	  VBIOS's PLL/DRAM settle-time WAIT calls during POST.
+
 config VIDEO_BROADWELL_IGD
 	bool "Enable Intel Broadwell integrated graphics device"
 	depends on X86
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 082b8967982..dffe018eb03 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_NXP_TDA19988) += tda19988.o
 obj-$(CONFIG_OSD) += video_osd-uclass.o
 obj-$(CONFIG_SANDBOX_OSD) += sandbox_osd.o
 obj-$(CONFIG_VIDEO_BCM2835) += bcm2835.o
+obj-$(CONFIG_VIDEO_ASPEED_VGA) += aspeed_vga.o
 obj-$(CONFIG_VIDEO_BOCHS) += bochs.o
 obj-$(CONFIG_VIDEO_BROADWELL_IGD) += broadwell_igd.o
 obj-$(CONFIG_VIDEO_COREBOOT) += coreboot.o
diff --git a/drivers/video/aspeed_vga.c b/drivers/video/aspeed_vga.c
new file mode 100644
index 00000000000..6595cd2e426
--- /dev/null
+++ b/drivers/video/aspeed_vga.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ASPEED AST2600 VGA driver. The display controller is initialised by
+ * running the card's x86 Video BIOS through the biosemu emulator.
+ * This driver sets up an INT 15h handler that is used by the ASPEED
+ * VBIOS for delays during PLL initialization.
+ */
+
+#include <bios_emul.h>
+#include <dm.h>
+#include <log.h>
+#include <pci.h>
+#include <vesa.h>
+#include <video.h>
+#include <linux/delay.h>
+
+/*
+ * INT 15h handler used by the ASPEED VBIOS. The WAIT subfunction
+ * is implemented and the rest are reported as unsupported.
+ */
+static int aspeed_vga_int15_handler(void)
+{
+	switch (M.x86.R_AH) {
+	case 0x86:		/* WAIT: CX:DX = interval in microseconds */
+		udelay(((u32)M.x86.R_CX << 16) | M.x86.R_DX);
+		CLEAR_FLAG(F_CF);
+		break;
+	default:
+		M.x86.R_AH = 0x86;	/* function not supported */
+		SET_FLAG(F_CF);
+		break;
+	}
+
+	return 1;
+}
+
+static int aspeed_vga_probe(struct udevice *dev)
+{
+	int ret;
+
+	ret = vesa_setup_video(dev, aspeed_vga_int15_handler);
+	if (ret)
+		return log_ret(ret);
+
+	return 0;
+}
+
+static int aspeed_vga_bind(struct udevice *dev)
+{
+	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+
+	/* ASPEED exposes a 16 MiB VRAM BAR */
+	uc_plat->size = 16 << 20;
+	log_debug("%s: Frame buffer size %x\n", __func__, uc_plat->size);
+
+	return 0;
+}
+
+static const struct video_ops aspeed_vga_ops = {
+};
+
+static const struct udevice_id aspeed_vga_ids[] = {
+	{ .compatible = "aspeed,vga" },
+	{ }
+};
+
+U_BOOT_DRIVER(aspeed_vga) = {
+	.name		= "aspeed_vga",
+	.id		= UCLASS_VIDEO,
+	.of_match	= aspeed_vga_ids,
+	.bind		= aspeed_vga_bind,
+	.probe		= aspeed_vga_probe,
+	.ops		= &aspeed_vga_ops,
+};
+
+static struct pci_device_id aspeed_vga_supported[] = {
+	{ PCI_DEVICE(0x1a03, 0x2000) },
+	{ },
+};
+
+U_BOOT_PCI_DEVICE(aspeed_vga, aspeed_vga_supported);

-- 
2.43.0

