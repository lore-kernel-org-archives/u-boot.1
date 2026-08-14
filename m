Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEFCC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 740B960A7F;
	Fri, 14 Aug 2026 18:30:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cEWga2Dv5Ti3; Fri, 14 Aug 2026 18:30:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 75F9B608FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732222;
	bh=GrH1R5xqBIkt+kFF9LCfzb9AUsYOtbc9vEcFV/FhfrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c41qG2+1Uik4YI8AJbIBt2JQ5uEkGOEmWNZrwBFuF7cxlLLFYu9iKLg5G3kIyAOlb
	 QrmNAc1YGQidLxJH4L0p5KDNtmUWvlXN4yfzJXO9Chx8AV9o32v4DPeIxgrDbdOGWi
	 EPoGAlK5KR9lLUOs3g5zeWN7c0srEjGndzmjSHfV0wgT8G3YmDDj70J+LbooYR+Lgc
	 I+GdpR6fJ0IO2UXAhOLLfonvRHGnRaZ9eFVEL+blbdI1Aai0qzEHrG/d90WE8/m9fe
	 D3VsRJ1StecA+kZ89MnE1MYw4oaECtm1sgwOZbDJ6N6aBRJ+d9TACWuh77g8Zp2jN2
	 KJPDXTGMbNj3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75F9B608FE;
	Fri, 14 Aug 2026 18:30:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7659B2B2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73EC5608FE
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:30:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OfOVlC-ipLv5 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:30:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 75785606D3
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 75785606D3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=RTAJyakL
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 75785606D3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:30:19 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-930f72317a6so72724785a.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732218; x=1787337018;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GrH1R5xqBIkt+kFF9LCfzb9AUsYOtbc9vEcFV/FhfrM=;
 b=RTAJyakLhD1g9h2SO1qfdf1CkHKK/ZQ6lU4JHI4pKyoRu5D72r7naSjRDlFk9sTIFU
 6cjTjA7S/BfEWUYCCvK6FSzt7dYKgPUArPBGGe5bf+CC7cMzgjpnkCNZE+JzuVGE6JRF
 YFRUvHOKwa+V9jftpmcGrSJAfUkb6E+pUqPAI7Lx/6oBxjHXQQVx77QHMQhW4XEw5uQc
 gk1tpiu9F81HRzPZHMTll+0IX/rkcLjv27rVof1rCiWq2GOLg+Cbd4Ldfjv4uPYqXfNV
 36gmQ9dDg4+HtHnAQURE/jPnBiHvc3h0+MXrfIO/CZ94hGCBd5py4w76zZXwmtU6ew4L
 GSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732218; x=1787337018;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GrH1R5xqBIkt+kFF9LCfzb9AUsYOtbc9vEcFV/FhfrM=;
 b=pVqpyjex8jPLi9PvUJ1KxdoIFT5x2EWFhyOAiG2v4P/VIhZzVxfYyenZIUtIecnM2B
 tSnewHjFKNhc1TzXBLAw0oNFRax3XRm9veEsaihziknIJ4Obs72sbCrxc41xEtnw12A1
 UtJIKGOXLnWgz0RkHAYziGtMS43UiuA+lYbwyqT0isSz4/rI3iAwyQJQBdC6Zkp9h36s
 J/3AfhVxM2/l3nUth2oWDsJbuw7gyHNLgY8XedEV8T0dIxjr5sl4NZo8jAs5nHDfxlbj
 Yq9j90d7ZgsAVt/eo+2UtHKTbZsNVo3QJbKRey57GALMU5wtDYH4uvOOc4LadviFn1p8
 UG+w==
X-Gm-Message-State: AOJu0Yw4kseQcnb0fuAD9rXjZp19MPB4yYcAGS0Ou+Fd+bq8fqH6fbWk
 vsNF6/EBExOfP7T6BbafWhCTy9TvRECAICD93WcRSHr+mWe1f5/VvuA53RfxI/tZVrs=
X-Gm-Gg: AR+sD11tmpPWO2m7HffjZoKUmxqamE1RfrFKRdumiKzBeNtRpEsCg7OngP4+j2Y6jDU
 10eocgchjENitYAd3L3/mF2h9zF0WXat33t07LrYmB/3Ldkcu7EZrGAdvrC77YuWvFeJDaI3Eap
 dRZnJp23s2mW1UdLo/E8C696Kto5zAgDeebXOtenjy/Xc0j6lYIkUT9/Ba9t5yh/QOCeN1XZjx6
 kCA+e1/cABquBToagueIrrxMiv8htaZwuhRtprR3uArg5ipcVvJs09GzgKda6mVxSPeB32/+z6f
 HARjxsjXWhzEWA3a9XP8xgtaQ+K15QjjCLAJ88eIeRzUJgPkP9jOCjnfYojja9NJ7h0g7K602g/
 CdfScXL2lfnGe2XINUnqFjpq2CZIHfc2MafoY9QfnxQ3zO98lDyLYOtc0crbXOR2uyh4N2rGFSF
 q7Z9GmTXilnXrVzlpqV+fYxW6tckPs2bf1pZRXrD0BVz5xW5dWjNKRBE5b+B/gRzWwCQeOznihI
 Gn0vtCeCj82l2woQPEfh0wNKLPg0qJDs0Jyljq/08jOF1daRKGE2yZlXw==
X-Received: by 2002:a05:620a:25d5:b0:92e:8a84:7041 with SMTP id
 af79cd13be357-936d2246864mr625131485a.8.1786732217909; 
 Fri, 14 Aug 2026 11:30:17 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936ce24d0b5sm324606285a.45.2026.08.14.11.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:30:17 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:30:13 -0400
Subject: [PATCH v2 2/3] net: add r9a06g032 MIIC driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rzn1-2026-10-net-v2-2-ff03583dc2b0@linaro.org>
References: <20260814-rzn1-2026-10-net-v2-0-ff03583dc2b0@linaro.org>
In-Reply-To: <20260814-rzn1-2026-10-net-v2-0-ff03583dc2b0@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732214; l=7027;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=JSeVXe2CLC2QKTvvNM9u5dsKpbOyfwBuwvpe/SNP5Jo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QB6hagO865E+7z2cmw0P1lYXpEGNui6khKGiBR+RU9uYEZCGqzsFefUF4kEgEVk7VWQ6TTJFTwk
 ZTt3u/kxPgAo=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Driver for the MII/GMII/RGMII media converter blocks found in the
Renesas RZ/N1 SoC. These converters sit in the Ethernet data path,
and need to be configured with speed/duplex as detected by the PHY.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 drivers/net/Kconfig     |   6 ++
 drivers/net/Makefile    |   1 +
 drivers/net/rzn1_miic.c | 193 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 200 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index edc4cb29598..659e9fd82d0 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -886,6 +886,12 @@ config RZN1_A5PSW
 	  Support the Advanced 5-Port ethernet switch (A5PSW) found in
 	  the Renesas RZ/N1 SoC.
 
+config RZN1_MIIC
+	bool "Renesas RZ/N1 MIIC ethernet accessory"
+	help
+	  Support the MIIC ethernet accessory found in Renesas RZ/N1 SoC.
+	  These are media converters for MII/GMII/RGMII.
+
 config MPC8XX_FEC
 	bool "Fast Ethernet Controller on MPC8XX"
 	depends on MPC8xx
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index b8f270ae233..049212b1fd2 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_PIC32_ETH) += pic32_mdio.o pic32_eth.o
 obj-$(CONFIG_RENESAS_ETHER_SWITCH) += rswitch.o
 obj-$(CONFIG_RENESAS_RAVB) += ravb.o
 obj-$(CONFIG_RZN1_A5PSW) += rzn1_a5psw.o
+obj-$(CONFIG_RZN1_MIIC) += rzn1_miic.o
 obj-$(CONFIG_RTL8139) += rtl8139.o
 obj-$(CONFIG_RTL8169) += rtl8169.o
 obj-$(CONFIG_SH_ETHER) += sh_eth.o
diff --git a/drivers/net/rzn1_miic.c b/drivers/net/rzn1_miic.c
new file mode 100644
index 00000000000..491923d8511
--- /dev/null
+++ b/drivers/net/rzn1_miic.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MII/GMII/RGMII converter support
+ *
+ * Based loosely on Linux drivers/net/pcs/pcs-rzn1-miic.c
+ * and the older driver in Renesas u-boot.
+ */
+
+#include <clk.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <dm/of_extra.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <miiphy.h>
+#include <net/dsa.h>
+#include <regmap.h>
+
+struct rzn1_miic_plat {
+	struct clk_bulk bulk;
+	struct regmap *regmap;
+};
+
+/* RIN Ether Accessory (Switch Control) regs */
+#define PRCMD			0x0		/* Ethernet Protect */
+#define IDCODE			0x4		/* EtherSwitch IDCODE */
+#define MODCTRL			0x8		/* Mode Control */
+#define PTP_MODE_CTRL		0xc		/* PTP Mode Control */
+#define PHY_LINK_MODE		0x14		/* Ethernet PHY Link Mode */
+
+/* RIN RGMII/RMII Converter regs */
+#define CONVCTRL(x)		(0x100 + ((x)) * 4) /* RGMII/RMII Converter */
+#define  CONVCTRL_10_MBPS		0
+#define  CONVCTRL_100_MBPS		BIT(0)
+#define  CONVCTRL_1000_MBPS		BIT(1)
+#define  CONVCTRL_MII			0
+#define  CONVCTRL_RMII			BIT(2)
+#define  CONVCTRL_RGMII			BIT(3)
+#define  CONVCTRL_REF_CLK_OUT		BIT(4)
+#define  CONVCTRL_HALF_DUPLEX		0
+#define  CONVCTRL_FULL_DUPLEX		BIT(8)
+#define CONVRST			0x114		/* RGMII/RMII Converter RST */
+#define  PHYIF_RST(x)			BIT(x)
+
+static void rzn1_rin_prot_writel(struct udevice *dev, u32 reg, u32 val)
+{
+	struct rzn1_miic_plat *plat = dev_get_plat(dev);
+	struct regmap *regmap = plat->regmap;
+
+	/* RIN: Unprotect register writes */
+	regmap_write(regmap, PRCMD, 0x00a5);
+	regmap_write(regmap, PRCMD, 0x0001);
+	regmap_write(regmap, PRCMD, 0xfffe);
+	regmap_write(regmap, PRCMD, 0x0001);
+
+	/* Do the write */
+	regmap_write(regmap, reg, val);
+
+	/* Re-enable protection */
+	regmap_write(regmap, PRCMD, 0x0000);
+}
+
+/*
+ * RIN RGMII/RMII Converter set speed
+ * RGMII/RMII Converter number: 0..4
+ * speed: 10, 100, 1000
+ */
+void rzn1_rgmii_rmii_conv_speed(struct udevice *dev, int phy,
+				int full_duplex, int speed)
+{
+	struct rzn1_miic_plat *plat = dev_get_plat(dev);
+	struct regmap *regmap = plat->regmap;
+	u32 val = 0;
+
+	regmap_read(regmap, CONVCTRL(phy), &val);
+
+	val &= CONVCTRL_MII | CONVCTRL_RMII | CONVCTRL_RGMII |
+		CONVCTRL_REF_CLK_OUT;
+
+	/* The interface type and speed bits are somewhat intertwined */
+	if (val != CONVCTRL_MII) {
+		if (speed == SPEED_1000)
+			val |= CONVCTRL_1000_MBPS;
+		else if (speed == SPEED_100)
+			val |= CONVCTRL_100_MBPS;
+		else if (speed == SPEED_10)
+			val |= CONVCTRL_10_MBPS;
+	}
+
+	if (full_duplex)
+		val |= CONVCTRL_FULL_DUPLEX;
+
+	regmap_write(regmap, CONVCTRL(phy), val);
+}
+
+/*
+ * RIN RGMII/RMII Converter setup one
+ * RGMII/RMII Converter number: 0..4
+ * if_type: Type of PHY interface, see phy_interface_t
+ */
+void rzn1_rgmii_rmii_conv_setup(struct udevice *dev, int phy,
+				u32 if_type, int rmii_ref_clk_out)
+{
+	struct rzn1_miic_plat *plat = dev_get_plat(dev);
+	struct regmap *regmap = plat->regmap;
+	u32 val = 0;
+	int speed = SPEED_100;
+
+	switch (if_type) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val |= CONVCTRL_RGMII;
+		speed = SPEED_1000;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		val |= CONVCTRL_RMII;
+		break;
+	case PHY_INTERFACE_MODE_MII:
+		val |= CONVCTRL_MII;
+		break;
+	};
+
+	if (if_type == PHY_INTERFACE_MODE_RMII && rmii_ref_clk_out)
+		val |= CONVCTRL_REF_CLK_OUT;
+
+	regmap_write(regmap, CONVCTRL(phy), val);
+
+	rzn1_rgmii_rmii_conv_speed(dev, phy, DUPLEX_FULL, speed);
+
+	/* reset */
+	regmap_read(regmap, CONVRST, &val);
+	val &= ~PHYIF_RST(phy);
+	rzn1_rin_prot_writel(dev, CONVRST, val);
+	udelay(1000);
+	val |= PHYIF_RST(phy);
+	rzn1_rin_prot_writel(dev, CONVRST, val);
+}
+
+static int rzn1_miic_probe(struct udevice *dev)
+{
+	struct rzn1_miic_plat *plat = dev_get_plat(dev);
+	int ret;
+
+	dev_warn(dev, "%s:%d\n", __func__, __LINE__);
+
+	/* Enable clocks */
+	ret = clk_get_bulk(dev, &plat->bulk);
+	if (ret) {
+		dev_err(dev, "Failed to get clocks\n");
+		return ret;
+	}
+	ret = clk_enable_bulk(&plat->bulk);
+	if (ret) {
+		dev_err(dev, "Failed to enable clocks\n");
+		return ret;
+	}
+
+	/* Access the registers */
+	ret = regmap_init_mem(dev_ofnode(dev), &plat->regmap);
+	if (ret) {
+		dev_err(dev, "Failed to get regmap\n");
+		return ret;
+	}
+
+	/* Set PTP to use 125MHz PLL clock */
+	rzn1_rin_prot_writel(dev, PTP_MODE_CTRL, 0x2);
+
+	/* Setup RGMII/RMII Converters */
+	rzn1_rgmii_rmii_conv_setup(dev, 3, PHY_INTERFACE_MODE_RGMII_ID, 0);
+	rzn1_rgmii_rmii_conv_setup(dev, 4, PHY_INTERFACE_MODE_RGMII_ID, 0);
+
+	/* RIN: Mode Control - GMAC1 on all Switch ports */
+	rzn1_rin_prot_writel(dev, MODCTRL, 0x13);
+
+	return 0;
+}
+
+static const struct udevice_id rzn1_miic_ids[] = {
+	{ .compatible = "renesas,rzn1-miic" },
+	{ }
+};
+
+U_BOOT_DRIVER(rzn1_miic) = {
+	.name		= "rzn1_miic",
+	.id		= UCLASS_MISC,
+	.of_match	= rzn1_miic_ids,
+	.probe		= rzn1_miic_probe,
+	.plat_auto	= sizeof(struct rzn1_miic_plat),
+};

-- 
2.55.0

