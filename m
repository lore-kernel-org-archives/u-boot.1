Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8D6FC6165
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 00:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E0783BC8;
	Sat,  3 Jan 2026 01:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cK5hI5DZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="t85gVh6m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F4BA83C04; Sat,  3 Jan 2026 01:22:00 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB5A383A64
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 01:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4djh855Hdgz9t1v;
 Sat,  3 Jan 2026 01:21:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767399717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1zdpI1sxw6pwbi23laMYmNqG+3a/tVr8GQPPPZiFAYQ=;
 b=cK5hI5DZaDuYIAgEdrai9tQW55Tmcp3Gb9AAi1GYnfhK+2lp55BBPakVSqfrm1+koJqVsZ
 py+6kIkR3IL0xqBuJeD5eOCON1rFGIcjldZZj32IXVZTRD+S6/Kh4GdP8LpPFVMRuDr9Zd
 GjqTE3ieWqcRfdLOPqyzJyioXrxaXeHim/yzmwnYv4DJEYZjCdied5DOzLNFEt0oJ/wtxO
 va+VIRqv3AHm1jSWwmppMPgiYMsdIvL31XdlXvMFIYzANdWa5BhW5SCVi6upAHakD4N7F9
 b3hL1RJnSgyOeBAjMzRzHAJRYjMYvylBzIfkCGm6TZoW3RyPyaDQFpoI6oEiMA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=t85gVh6m;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767399715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1zdpI1sxw6pwbi23laMYmNqG+3a/tVr8GQPPPZiFAYQ=;
 b=t85gVh6mdFdxbWjOa0H568tdV0BI0RIZDsqYB2/O83VqgTJOOedi1sHn8UNZt7cJYMaqkl
 RXzE8PbZlWWIFSIxKRFb9tSVtxY/+n3pxI0Ilvdlz2lgUhuUc6OrWQ8aIfJmK8EryPqX38
 27xGvmMmTjjFFezX8a/LKO89e+aIsrPhyTfxVJWodT7I4ZgjEt9cpVlRq8ErH/coDjGW3m
 94t/r1ZeQ/TYwV8xfQpvvjb43CSH40Y+8eGSqvpW33Uh0muTpiaNBQZNTdjZlK/0ASWRiD
 ByMUd2+hTN0RHNXpii+FkBtS1krcO9LAePRPU4GiHVuz1oIc7EWMuLQh18MGZA==
To: u-boot@lists.denx.de
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 1/2] nvmem: Add R-Car E-FUSE driver
Date: Sat,  3 Jan 2026 01:21:10 +0100
Message-ID: <20260103002151.183285-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ee3d68212e2c93cc106
X-MBO-RS-META: jgixag78qxqkgru938imgmqk76c3fobb
X-Rspamd-Queue-Id: 4djh855Hdgz9t1v
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

R-Car Gen4 SoCs contain fuses indicating hardware support or hardware
(e.g. tuning) parameters.  Add a driver to access the state of the
fuses.  This supports two types of hardware fuse providers:
  1. E-FUSE non-volatile memory accessible through the Pin Function
     Controller on R-Car V3U and S4-8,
  2. E-FUSE non-volatile memory accessible through OTP_MEM on R-Car V4H
     and V4M.

The state of the cells can be read using the MISC framework, either
from U-Boot space (e.g. by the Renesas UFSHCD driver), or from
command line (e.g. by the 'misc' command).

Ported from Linux kernel commit
1530b923a514 ("nvmem: Add R-Car E-FUSE driver")

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Link: https://lore.kernel.org/r/20241030140315.40562-3-srinivas.kandagatla@linaro.org
---
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: u-boot@lists.denx.de
---
 drivers/misc/Kconfig      |  8 ++++
 drivers/misc/Makefile     |  1 +
 drivers/misc/rcar-efuse.c | 94 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)
 create mode 100644 drivers/misc/rcar-efuse.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index dde773ab6b1..9b75b002b92 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -92,6 +92,14 @@ config QCOM_GENI
 	  for providing a common interface for various peripherals like UART, I2C, SPI,
 	  etc.
 
+config RCAR_EFUSE
+	tristate "Renesas R-Car Gen4 E-FUSE support"
+	depends on RCAR_GEN4
+	depends on MISC
+	help
+	  Enable support for reading the fuses in the E-FUSE or OTP
+	  non-volatile memory block on Renesas R-Car Gen4 SoCs.
+
 config ROCKCHIP_EFUSE
         bool "Rockchip e-fuse support"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 1d950f7a0ab..14b15079e1a 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
 obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
+obj-$(CONFIG_RCAR_EFUSE) += rcar-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
diff --git a/drivers/misc/rcar-efuse.c b/drivers/misc/rcar-efuse.c
new file mode 100644
index 00000000000..8d6109d2249
--- /dev/null
+++ b/drivers/misc/rcar-efuse.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Renesas R-Car E-FUSE/OTP Driver
+ *
+ * Copyright (C) 2024 Glider bv
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <misc.h>
+
+struct rcar_fuse {
+	void __iomem *base;
+};
+
+struct rcar_fuse_data {
+	unsigned int bank;	/* 0: PFC + E-FUSE, 1: OPT_MEM + E-FUSE */
+	unsigned int start;	/* inclusive */
+	unsigned int end;	/* exclusive */
+};
+
+static int rcar_fuse_reg_read(struct udevice *dev, int offset, void *val, int bytes)
+{
+	const struct rcar_fuse_data *data = (void *)dev_get_driver_data(dev);
+	struct rcar_fuse *plat = dev_get_plat(dev);
+	u32 *v32 = (u32 *)val;
+	int i, ret = 0;
+
+	for (i = 0; i < bytes; i += 4) {
+		if (((offset + i) < data->start) || ((offset + i) >= data->end))
+			continue;
+
+		v32[i / 4] = readl(plat->base + offset + i);
+		ret += 4;	/* Count only non-skipped OTP data */
+	}
+
+	return ret;
+}
+
+static const struct rcar_fuse_data rcar_fuse_v3u = {
+	.bank = 0,
+	.start = 0x0c0,
+	.end = 0x0e8,
+};
+
+static const struct rcar_fuse_data rcar_fuse_s4 = {
+	.bank = 0,
+	.start = 0x0c0,
+	.end = 0x14c,
+};
+
+static const struct rcar_fuse_data rcar_fuse_v4h = {
+	.bank = 1,
+	.start = 0x100,
+	.end = 0x1a0,
+};
+
+static const struct rcar_fuse_data rcar_fuse_v4m = {
+	.bank = 1,
+	.start = 0x100,
+	.end = 0x110,
+};
+
+static const struct udevice_id rcar_efuse_ids[] = {
+	{ .compatible = "renesas,r8a779a0-efuse", .data = (ulong)&rcar_fuse_v3u },
+	{ .compatible = "renesas,r8a779f0-efuse", .data = (ulong)&rcar_fuse_s4 },
+	{ .compatible = "renesas,r8a779g0-otp", .data = (ulong)&rcar_fuse_v4h },
+	{ .compatible = "renesas,r8a779h0-otp", .data = (ulong)&rcar_fuse_v4m },
+	{ /* sentinel */ }
+};
+
+static const struct misc_ops rcar_efuse_ops = {
+	.read = rcar_fuse_reg_read,
+};
+
+static int rcar_efuse_of_to_plat(struct udevice *dev)
+{
+	const struct rcar_fuse_data *data = (void *)dev_get_driver_data(dev);
+	struct rcar_fuse *plat = dev_get_plat(dev);
+	fdt_size_t size;
+
+	plat->base = dev_read_addr_size_index_ptr(dev, data->bank, &size);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(rcar_efuse) = {
+	.name = "rcar_efuse",
+	.id = UCLASS_MISC,
+	.of_match = rcar_efuse_ids,
+	.of_to_plat = rcar_efuse_of_to_plat,
+	.plat_auto = sizeof(struct rcar_fuse),
+	.ops = &rcar_efuse_ops,
+};
-- 
2.51.0

