Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E1110A1E7D
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7D2783FA3;
	Thu, 26 Mar 2026 12:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="zj/vzwfL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A50C83FA3; Thu, 26 Mar 2026 12:28:58 +0100 (CET)
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DBE881E18
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-1273349c56bso1061700c88.0
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1774524534; x=1775129334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOmPf7pVOZfVaKWARfzyjy34cnRpMT9ra0XlHy3wdyk=;
 b=zj/vzwfLTVpht5E8rfJZhkNP/evGarPrFl2vildJkdPUHG3a0LSZ05aqMKJ7Ecltpy
 7qJz47pEL4b9y6g5FsPhN3LnzUoOOZULOgm8WoWKNwCPB+E5UR5ukiAundbAQ2iXw2Wk
 h8Sp0KYTkLbuWiVCOcfx9NH13o1i4Phvd2pLtEGbt/wgVb/foeBmTS5t9fNIY0WLEoiv
 CdSK0tmGt/VAygxkCR+mJ+dGf1gONapvpLwefMn2OERgX18KmtW3W28MUowGlZq0smwV
 P15O0NqMW+Z5oUMAFdxq3I3NJ+o3FReLaopv+hLXKDEuNkCyPcpPNC7tHTOggjCp57br
 7/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774524534; x=1775129334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YOmPf7pVOZfVaKWARfzyjy34cnRpMT9ra0XlHy3wdyk=;
 b=TjDSqYqxNFVw2qiCy0hmfC6L3PiWGanjD/vm/Zy23Vs8jVlTD2v0u4SBHmkCvRS7Si
 O4fAQ2IWpexQq2ogDwprHA7EgzmY4nJGxB1IT4XKvgEOL/rjCwiIRlRP6mckgg1nRUfP
 vzB7doRXHoSYhkVAXjIv+htZ4ICGljbPdVTonpKEBZ1s7V8bqJ8JRbOiXyrLFO2PrtkB
 M9RV8hjCslpsvCSr7uVJOCMgpp/CmRWCpoJCKEMWwwzsUot8kpolt2Mue8Imq+emyzRH
 W3JiAnMaIrexwE8EPbBi/X46+HjbWuyYNEPEvTImNKCinYGIg7r7qBxwcjbNKjvM+ax7
 ZqsA==
X-Gm-Message-State: AOJu0Ywq7V8fspjdXMZrvJtRwx8fPJlOI3p7PIBwt520gOv2RZbLMajG
 MtN/SQqQNnpPvRjMhXiWMZiMqPtFRkA4hjxemlXBVgDB3GksiBn0PGZ1eYnd3+gDC2kQpqJ5OHU
 inILiC3j9W6QfclHIXY+ck+e+Ts/mZ6lXrpI4cPxXEUrEso3OeA3hN5YTQVjWy4sfxEueogM6bE
 Ujl5KVvvozUjmPQulcxEyiMi53FiletU9dB/C5MzZkF5s=
X-Gm-Gg: ATEYQzxtMiR+XEnak6dTK0KxvENwAfW32NxiSptpkQ5O8rivUUU6jIHIWtbbCQ5D6p4
 /OeQzluEvv7n7MxPqva8UYEHfYhTl8xJKNnoLNK+pAvUg4wLLWHGFaa2qsTPXEYmv6JJAnA56TH
 1ye3mvgk3qpUQflTJFdQJSOaJavxhvKQL3+Vjjfmnavmg3s1/xOQL+aYCdWUO4Jtf0AkWeYmSQ0
 2c7kEUp2Si0batqJTjrXfwtqYlTh1ouolHX0ae5u3ey+dTuVXu1k0lIweMIMlI4pRNAbK+Fcnzg
 AWeH5Pj49rPqEi3/lX9LOjEMDDyN6cGh0R0aXTuOgs9Vb/LFhHbGXaEw8wxrTpLFbci2VX4X1KV
 RvBM6gbsW3u7IJdt2+N5H3xiQSNViL3V4EZaSQr0VOM+6CDxQNxUXNI5GTZ5BbWdU2AjVlvi0rq
 UXXpIna9BWBrvvtxbiER8TFVcYPk49GzTLMrGe3xe3PH5LuB1jhRUJ7P0hZmbNn4okf93CB7KIO
 DOIM9kL2lDGcuQuvG9rd96z65zbYjWgHJR1I+hQHU30lr/sMZY=
X-Received: by 2002:a05:7022:490:b0:11f:2c9e:87f8 with SMTP id
 a92af1059eb24-12a96f0944emr3395503c88.34.1774524533877; 
 Thu, 26 Mar 2026 04:28:53 -0700 (PDT)
Received: from fedora (cpe-109-60-83-68.zg3.cable.xnet.hr. [109.60.83.68])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-12aa7624247sm3729221c88.11.2026.03.26.04.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:28:53 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: u-boot@lists.denx.de, trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, gregory.clement@bootlin.com,
 lars.povlsen@microchip.com, horatiu.vultur@microchip.com,
 jerome.forissier@arm.com, marex@denx.de, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 03/14] clk: add Microchip LAN966x and LAN969x support
Date: Thu, 26 Mar 2026 12:26:44 +0100
Message-ID: <20260326112830.313874-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326112830.313874-1-robert.marko@sartura.hr>
References: <20260326112830.313874-1-robert.marko@sartura.hr>
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

Import clock driver for Microchip LAN966x and LAN969x SoC-s from the vendor
U-Boot as it is based on the upstream Linux driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/clk/Makefile                |   2 +-
 drivers/clk/microchip/Kconfig       |   7 +
 drivers/clk/microchip/Makefile      |   3 +-
 drivers/clk/microchip/clk-lan966x.c | 198 ++++++++++++++++++++++++++++
 4 files changed, 208 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/microchip/clk-lan966x.c

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 5f0c0d8a5c2..88b76652378 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -39,7 +39,7 @@ obj-$(CONFIG_CLK_EXYNOS) += exynos/
 obj-$(CONFIG_CLK_HSDK) += clk-hsdk-cgu.o
 obj-$(CONFIG_CLK_K210) += clk_k210.o
 obj-$(CONFIG_CLK_MPC83XX) += mpc83xx_clk.o
-obj-$(CONFIG_CLK_MPFS) += microchip/
+obj-y += microchip/
 obj-$(CONFIG_CLK_MVEBU) += mvebu/
 obj-$(CONFIG_CLK_OCTEON) += clk_octeon.o
 obj-$(CONFIG_CLK_OWL) += owl/
diff --git a/drivers/clk/microchip/Kconfig b/drivers/clk/microchip/Kconfig
index 62072e100b1..275cd849fec 100644
--- a/drivers/clk/microchip/Kconfig
+++ b/drivers/clk/microchip/Kconfig
@@ -1,3 +1,10 @@
+config CLK_LAN966X
+	bool "Microchip LAN966X and LAN969X clock support"
+	depends on ARCH_MICROCHIPSW
+	depends on CLK
+	help
+	  Clock driver for Microchip LAN969X platforms.
+
 config CLK_MPFS
 	bool "Clock support for Microchip PolarFire SoC"
 	depends on CLK && CLK_CCF
diff --git a/drivers/clk/microchip/Makefile b/drivers/clk/microchip/Makefile
index 329b2c0c93f..bce4cbebd69 100644
--- a/drivers/clk/microchip/Makefile
+++ b/drivers/clk/microchip/Makefile
@@ -1 +1,2 @@
-obj-y += mpfs_clk.o mpfs_clk_cfg.o mpfs_clk_periph.o mpfs_clk_msspll.o
+obj-$(CONFIG_CLK_LAN966X) += clk-lan966x.o
+obj-$(CONFIG_CLK_MPFS) += += mpfs_clk.o mpfs_clk_cfg.o mpfs_clk_periph.o mpfs_clk_msspll.o
diff --git a/drivers/clk/microchip/clk-lan966x.c b/drivers/clk/microchip/clk-lan966x.c
new file mode 100644
index 00000000000..1d704af006c
--- /dev/null
+++ b/drivers/clk/microchip/clk-lan966x.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <asm/io.h>
+#include <clk-uclass.h>
+#include <div64.h>
+#include <dm.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <linux/bitfield.h>
+
+#define GCK_ENA         BIT(0)
+#define GCK_SRC_SEL     GENMASK(9, 8)
+#define GCK_PRESCALER   GENMASK(23, 16)
+
+struct lan966x_soc_clk_gate_desc {
+	const char *name;
+	int bit_idx;
+};
+
+static const struct lan966x_soc_clk_gate_desc lan966x_clk_gate_desc[] = {
+	{ "uhphs", 11 },
+	{ "udphs", 10 },
+	{ "mcramc", 9 },
+	{ "hmatrix", 8 },
+	{ }
+};
+
+static const struct lan966x_soc_clk_gate_desc lan969x_clk_gate_desc[] = {
+	{ "usb_drd", 10 },
+	{ "mcramc", 9 },
+	{ "hmatrix", 8 },
+	{ }
+};
+
+struct lan966x_clk {
+	void *base;
+	void *gate;
+	int clk_cnt;
+	int clk_gate_cnt;
+	const struct lan966x_soc_clk_gate_desc *clk_gate_desc;
+	ulong parent_rate;
+};
+
+struct lan966x_driver_data {
+	int clk_cnt;
+	int clk_gate_cnt;
+	const struct lan966x_soc_clk_gate_desc *clk_gate_desc;
+	ulong parent_rate;
+};
+
+static struct lan966x_driver_data lan966x_data = {
+	.clk_cnt = 14,
+	.clk_gate_cnt = 4,
+	.clk_gate_desc = lan966x_clk_gate_desc,
+	.parent_rate = 600000000,
+};
+
+static struct lan966x_driver_data lan969x_data = {
+	.clk_cnt = 12,
+	.clk_gate_cnt = 3,
+	.clk_gate_desc = lan969x_clk_gate_desc,
+	.parent_rate = 1000000000,
+};
+
+static void* lan966x_clk_ctlreg(struct lan966x_clk *gck, u8 id)
+{
+	return gck->base + (id * sizeof(u32));
+}
+
+static ulong lan966x_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct lan966x_clk *gck = dev_get_priv(clk->dev);
+	unsigned long parent_rate = gck->parent_rate;
+	u32 div;
+
+	if (clk->id >= gck->clk_cnt)
+		return -ENODEV;
+
+	if (rate == 0)
+		return -EINVAL;
+
+	/* Calc divisor */
+	div = DIV_ROUND_CLOSEST(parent_rate, rate);
+
+	/* Set src, prescaler */
+	clrsetbits_le32(lan966x_clk_ctlreg(gck, clk->id),
+			GCK_SRC_SEL | GCK_PRESCALER,
+			/* Select CPU_CLK as source always */
+			FIELD_PREP(GCK_SRC_SEL, 0x0) |
+			/* Divisor - 1 */
+			FIELD_PREP(GCK_PRESCALER, (div - 1)));
+
+	return 0;
+}
+
+static ulong lan966x_clk_get_rate(struct clk *clk)
+{
+	struct lan966x_clk *gck = dev_get_priv(clk->dev);
+	unsigned long parent_rate = gck->parent_rate;
+	u32 div, val;
+
+	if (clk->id >= gck->clk_cnt)
+		return -ENODEV;
+
+	val = readl(lan966x_clk_ctlreg(gck, clk->id));
+
+	div = 1 + FIELD_GET(GCK_PRESCALER, val);
+
+	return parent_rate / div;
+}
+
+static int lan966x_clk_enable(struct clk *clk)
+{
+	struct lan966x_clk *gck = dev_get_priv(clk->dev);
+
+	if (clk->id >= gck->clk_cnt) {
+		/* If there are no gate clock then this is not allowed */
+		if (gck->gate == NULL)
+			return -ENODEV;
+
+		if (clk->id >= gck->clk_cnt + gck->clk_gate_cnt)
+			return -ENODEV;
+
+		setbits_le32(gck->gate,
+			     BIT(gck->clk_gate_desc[clk->id - gck->clk_cnt].bit_idx));
+
+		return 0;
+	}
+
+	setbits_le32(lan966x_clk_ctlreg(gck, clk->id), GCK_ENA);
+
+	return 0;
+}
+
+static int lan966x_clk_disable(struct clk *clk)
+{
+	struct lan966x_clk *gck = dev_get_priv(clk->dev);
+
+	if (clk->id >= gck->clk_cnt) {
+		/* If there are no gate clock then this is not allowed */
+		if (gck->gate == NULL)
+			return -ENODEV;
+
+		if (clk->id >= gck->clk_cnt + gck->clk_gate_cnt)
+			return -ENODEV;
+
+		clrbits_le32(gck->gate, BIT(gck->clk_gate_desc[clk->id - gck->clk_cnt].bit_idx));
+
+		return 0;
+	}
+
+	clrbits_le32(lan966x_clk_ctlreg(gck, clk->id), GCK_ENA);
+
+	return 0;
+}
+
+static int lan966x_clk_probe(struct udevice *dev)
+{
+	struct lan966x_clk *priv = dev_get_priv(dev);
+	struct lan966x_driver_data *data;
+
+	priv->base = dev_remap_addr(dev);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->gate = dev_remap_addr_index(dev, 1);
+
+	/* Get clock count for target device */
+	data = (struct lan966x_driver_data*)dev_get_driver_data(dev);
+	priv->clk_cnt = data->clk_cnt;
+	priv->clk_gate_cnt = data->clk_gate_cnt;
+	priv->clk_gate_desc = data->clk_gate_desc;
+	priv->parent_rate = data->parent_rate;
+
+	return 0;
+}
+
+static struct clk_ops lan966x_clk_ops = {
+	.disable	= lan966x_clk_disable,
+	.enable		= lan966x_clk_enable,
+	.get_rate	= lan966x_clk_get_rate,
+	.set_rate	= lan966x_clk_set_rate,
+};
+
+static const struct udevice_id lan966x_clk_ids[] = {
+	{ .compatible = "microchip,lan966x-gck", .data = (unsigned long)&lan966x_data },
+	{ .compatible = "microchip,lan9691-gck", .data = (unsigned long)&lan969x_data },
+	{ }
+};
+
+U_BOOT_DRIVER(lan966x_clk) = {
+	.name		= "lan966x_clk",
+	.id		= UCLASS_CLK,
+	.of_match	= lan966x_clk_ids,
+	.priv_auto	= sizeof(struct lan966x_clk),
+	.ops		= &lan966x_clk_ops,
+	.probe		= lan966x_clk_probe,
+};
-- 
2.53.0

