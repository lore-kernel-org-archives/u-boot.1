Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE56F9B5FE
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 09:37:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B9E9840CB;
	Wed, 22 Apr 2026 11:37:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="jqiWxPJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0715C840D8; Wed, 22 Apr 2026 11:37:47 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9960583936
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 11:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1wFU1e-0001WZ-FW; Wed, 22 Apr 2026 05:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=kWGw8C6KvoTnsxil6SU3VyxxCzZxioErmoAo49tmaZE=; b=jqiWxPJYZWk/Dg
 d5MdjLlqCs97c3zBQukxA50bWTIH+iTRh77m9WgZgrLM0q6E56KQzLyO0B/4wwB6IwJC9cNVzKpZJ
 jRCgSKq5rBIw5gOjeo86ZtMZjZccvc8PvklvkKtNqVg/9I3IDLfG9+HrO9BpN+43FBqUhOrdwEqNa
 u/YHlaKPCaWVNeVJhC3SBUXSaiTlFO75K57WuipNuOAbAD1GrDzLLYodGmvIqjVGFGph1dteGms27
 CC6WzzmSuvIOOljONOm+6G+hhTDCD8fjEN4DU4Q0kcMO/McdWwNxPNPuRBfl+rNzTchA6kWsX637t
 fbIpdgTkgq3v34GBbvsA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Mathieu Othacehe <othacehe@gnu.org>,
	u-boot@lists.denx.de
Subject: [PATCH v3] misc: Add RZG2L OTP support
Date: Wed, 22 Apr 2026 11:36:56 +0200
Message-ID: <20260422093658.15723-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.52.0
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

Add OTP support through the fuse command. Fusing is directly performed by
U-Boot, which means that the trusted-firmware must allow the non-secure
world to perform fusing operations.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
Changelog
v3: Read the OTP_BASE address from the device-tree.
v2: Depend on CMD_FUSE. Use readl_poll_sleep_timeout and clrbits_le32 functions.

 arch/arm/dts/r9a07g044-u-boot.dtsi         |  15 ++
 arch/arm/dts/r9a07g044l2-smarc-u-boot.dtsi |   6 +
 drivers/misc/Kconfig                       |   7 +
 drivers/misc/Makefile                      |   1 +
 drivers/misc/rzg2l_otp.c                   | 255 +++++++++++++++++++++
 5 files changed, 284 insertions(+)
 create mode 100644 arch/arm/dts/r9a07g044-u-boot.dtsi
 create mode 100644 arch/arm/dts/r9a07g044l2-smarc-u-boot.dtsi
 create mode 100644 drivers/misc/rzg2l_otp.c

diff --git a/arch/arm/dts/r9a07g044-u-boot.dtsi b/arch/arm/dts/r9a07g044-u-boot.dtsi
new file mode 100644
index 00000000000..a64ef16fa7f
--- /dev/null
+++ b/arch/arm/dts/r9a07g044-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2026 Mathieu Othacehe <m.othacehe@gmail.com>
+ */
+
+/ {
+	soc: soc {
+		otp: otp@11860000 {
+			compatible = "renesas,r9a07g044-otp";
+			reg = <0 0x11860000 0 0x20>;
+			status = "okay";
+			bootph-all;
+		};
+	};
+};
diff --git a/arch/arm/dts/r9a07g044l2-smarc-u-boot.dtsi b/arch/arm/dts/r9a07g044l2-smarc-u-boot.dtsi
new file mode 100644
index 00000000000..5fe2e6c54a2
--- /dev/null
+++ b/arch/arm/dts/r9a07g044l2-smarc-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2026 Mathieu Othacehe <m.othacehe@gmail.com>
+ */
+
+#include "r9a07g044-u-boot.dtsi"
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ea785793d18..324a88c9494 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -132,6 +132,13 @@ config SPL_ROCKCHIP_IODOMAIN
 	  for the IO-domain setting of the SoC to match the voltage supplied
 	  by the regulators.
 
+config RZG2L_OTP
+	bool "Renesas RZ/G2L OTP support"
+	depends on MISC && CMD_FUSE
+	help
+	  Enable support for the OTP controller on
+	  Renesas RZ/G2L SoCs.
+
 config SIFIVE_OTP
 	bool "SiFive eMemory OTP driver"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e2170212e5a..64b2701b672 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
+obj-$(CONFIG_RZG2L_OTP) += rzg2l_otp.o
 obj-$(CONFIG_SANDBOX) += syscon_sandbox.o misc_sandbox.o
 obj-$(CONFIG_SIFIVE_OTP) += sifive-otp.o
 obj-$(CONFIG_SMSC_LPC47M) += smsc_lpc47m.o
diff --git a/drivers/misc/rzg2l_otp.c b/drivers/misc/rzg2l_otp.c
new file mode 100644
index 00000000000..a1a8b8e9df6
--- /dev/null
+++ b/drivers/misc/rzg2l_otp.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2026 Mathieu Othacehe <m.othacehe@gmail.com>
+ */
+#include <dm.h>
+#include <fuse.h>
+#include <malloc.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+
+/*
+ * XXX: To enable direct fusing through U-Boot, the trusted-firmware must
+ * allow the non-secure world to perform fusing operations. This is controlled
+ * by the SYS_SLVACCCTL7 register.
+ */
+
+/* OTP register offsets (relative to OTP base) */
+#define RZ_OTP_PWR		0x0000
+#define RZ_OTP_STR		0x0004
+#define RZ_OTP_STAWR		0x0008
+#define RZ_OTP_ADRWR		0x000c
+#define RZ_OTP_DATAWR		0x0010
+#define RZ_OTP_ADRRD		0x0014
+#define RZ_OTP_DATARD		0x0018
+#define RZ_OTP_FLAG		0x001c
+
+#define OTP_PWR			BIT(0)
+#define OTP_RDY			BIT(0)
+#define ERR_WR_1		BIT(1)
+#define ERR_WR_2		BIT(2)
+#define ERR_WP			BIT(3)
+#define OTP_ACCL		BIT(4)
+#define ERR_RDY_WR		BIT(8)
+#define OTP_DUMMY_READ_OFF	0x100
+
+#define RZ_OTP_POLL(base, reg, val, cond) \
+	readl_poll_sleep_timeout((base) + (reg), (val), (cond), 1000, 1000000)
+
+struct rzg2l_otp_priv {
+	phys_addr_t	otp_base;
+};
+
+static struct rzg2l_otp_priv *otp_priv;
+
+static int rzg2l_otp_open(void)
+{
+	phys_addr_t base = otp_priv->otp_base;
+	u32 val;
+	int ret;
+
+	if (readl(base + RZ_OTP_PWR) & OTP_PWR) {
+		debug("OTP already powered up\n");
+		return 0;
+	}
+
+	ret = RZ_OTP_POLL(base, RZ_OTP_STR, val, !(val & OTP_RDY));
+	if (ret) {
+		printf("OTP power-up timeout\n");
+		return ret;
+	}
+
+	ret = RZ_OTP_POLL(base, RZ_OTP_FLAG, val, val & OTP_RDY);
+	if (ret) {
+		printf("OTP power-up timeout\n");
+		return ret;
+	}
+
+	writel(readl(base + RZ_OTP_PWR) | OTP_PWR | OTP_ACCL,
+	       base + RZ_OTP_PWR);
+
+	return 0;
+}
+
+static int rzg2l_otp_dummy_read(void)
+{
+	phys_addr_t base = otp_priv->otp_base;
+	u32 val;
+	int ret;
+
+	ret = RZ_OTP_POLL(base, RZ_OTP_STR, val, val & OTP_RDY);
+	if (ret) {
+		printf("Timeout polling ready for OTP read\n");
+		return ret;
+	}
+
+	writel(base + OTP_DUMMY_READ_OFF, base + RZ_OTP_ADRRD);
+	readl(base + RZ_OTP_DATARD);
+
+	return 0;
+}
+
+static int rzg2l_otp_close(void)
+{
+	phys_addr_t base = otp_priv->otp_base;
+	u32 val;
+	int ret;
+
+	rzg2l_otp_dummy_read();
+
+	clrbits_le32(base + RZ_OTP_PWR, OTP_PWR | OTP_ACCL);
+
+	ret = RZ_OTP_POLL(base, RZ_OTP_STR, val, !(val & OTP_RDY));
+	if (ret) {
+		printf("Timeout leaving OTP ready state\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rzg2l_otp_read_word(u32 offset, u32 *val)
+{
+	phys_addr_t base = otp_priv->otp_base;
+	u32 str;
+	int ret;
+
+	ret = rzg2l_otp_open();
+	if (ret < 0)
+		return ret;
+
+	ret = RZ_OTP_POLL(base, RZ_OTP_STR, str, str & OTP_RDY);
+	if (ret) {
+		printf("Timeout polling ready for OTP read\n");
+		rzg2l_otp_close();
+		return ret;
+	}
+
+	writel(base + offset, base + RZ_OTP_ADRRD);
+	*val = readl(base + RZ_OTP_DATARD);
+
+	ret = rzg2l_otp_close();
+
+	return ret;
+}
+
+static int rzg2l_otp_program_word(u32 offset, u32 val)
+{
+	phys_addr_t base = otp_priv->otp_base;
+	u32 str, otpval;
+	int ret;
+
+	ret = rzg2l_otp_open();
+	if (ret < 0)
+		return ret;
+
+	ret = RZ_OTP_POLL(base, RZ_OTP_STR, str, str & OTP_RDY);
+	if (ret) {
+		printf("Timeout polling ready for OTP write\n");
+		goto close;
+	}
+
+	writel(base + offset, base + RZ_OTP_ADRWR);
+	writel(val, base + RZ_OTP_DATAWR);
+
+	writel(1, base + RZ_OTP_STAWR);
+
+	if (readl(base + RZ_OTP_STR) & ERR_RDY_WR) {
+		printf("OTP not ready for write\n");
+		writel(readl(base + RZ_OTP_STR) & ERR_RDY_WR, base + RZ_OTP_STR);
+		goto close;
+	}
+
+	ret = RZ_OTP_POLL(base, RZ_OTP_STR, str, str & OTP_RDY);
+	if (ret) {
+		printf("Timeout polling OTP write finished\n");
+		goto close;
+	}
+
+	ret = RZ_OTP_POLL(base, RZ_OTP_STAWR, str, !(str & OTP_RDY));
+	if (ret) {
+		printf("Timeout polling OTP write finished\n");
+		goto close;
+	}
+
+	if ((readl(base + RZ_OTP_STR) & ERR_WP) ||
+	    (readl(base + RZ_OTP_STR) & ERR_WR_1) ||
+	    (readl(base + RZ_OTP_STR) & ERR_WR_2)) {
+		printf("OTP write error (protected or invalid)\n");
+		goto close;
+	}
+
+	writel(base + offset, base + RZ_OTP_ADRRD);
+	otpval = readl(base + RZ_OTP_DATARD);
+
+	if (otpval != val) {
+		printf("OTP verify failed: wrote 0x%08x read 0x%08x\n",
+		       val, otpval);
+		goto close;
+	}
+
+close:
+	ret = rzg2l_otp_close();
+	return ret;
+}
+
+/* ---------------------------------------------------------------- */
+/* U-Boot fuse API                                                   */
+
+int fuse_read(u32 bank, u32 word, u32 *val)
+{
+	return rzg2l_otp_read_word(word >> 2, val);
+}
+
+int fuse_prog(u32 bank, u32 word, u32 val)
+{
+	return rzg2l_otp_program_word(word >> 2, val);
+}
+
+int fuse_sense(u32 bank, u32 word, u32 *val)
+{
+	/* not supported */
+	return -ENOSYS;
+}
+
+int fuse_override(u32 bank, u32 word, u32 val)
+{
+	/* not supported */
+	return -ENOSYS;
+}
+
+/* ---------------------------------------------------------------- */
+/* DM driver                                                         */
+
+static int rzg2l_otp_bind(struct udevice *dev)
+{
+	phys_addr_t base;
+
+	otp_priv = calloc(1, sizeof(struct rzg2l_otp_priv));
+	if (!otp_priv)
+		return -ENOMEM;
+
+	base = dev_read_addr(dev);
+	if (base == FDT_ADDR_T_NONE) {
+		printf("Cannot find OTP reg address, binding failed\n");
+		return -EINVAL;
+	}
+	otp_priv->otp_base = base;
+
+	printf("OTP: RZ/G2L OTP module bound\n");
+
+	return 0;
+}
+
+static const struct udevice_id rzg2l_otp_ids[] = {
+	{ .compatible = "renesas,r9a07g044-otp" },
+	{ }
+};
+
+U_BOOT_DRIVER(rzg2l_otp) = {
+	.name		= "rzg2l_otp",
+	.id		= UCLASS_MISC,
+	.of_match	= rzg2l_otp_ids,
+	.bind		= rzg2l_otp_bind,
+};
-- 
2.52.0

