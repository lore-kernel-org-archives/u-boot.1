Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746A7C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 16:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D77A41140;
	Fri, 31 Jul 2026 16:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z-DjjXL93tky; Fri, 31 Jul 2026 16:35:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E350D410F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785515756;
	bh=GrH1R5xqBIkt+kFF9LCfzb9AUsYOtbc9vEcFV/FhfrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WMmzxL2anJQv1FgNYZgfvRTfPTBjMwPd23bMAopH7ibcRBVKxGkAk5iqcvoAqiNOQ
	 Ed5GY7IaCYRxBF5UEwzlUN9uTuNCoG9b41mBgc+XdOj5oyBbLxuVf9Nw7Imytc+yEu
	 hlnWzkIQxR66KVpO76v4A5anu64u3jPtql/Jv4bScWbVsr8cwztXDK0TsVr4UnfT3X
	 HjjOgq7i/xc5D28X8oOGu1XjrX7rk31S7wnNheKSo4QO3ZWZ83gHVRUUTxxqxPooF7
	 lOW6SPFt14uYr3SQaNQw9b+rc2B618qPs3Qmg8p4yMY0Y4DSxudsvX3O3CE+hHkOod
	 0WyAgqwAlXHHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E350D410F5;
	Fri, 31 Jul 2026 16:35:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B0A369
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D880406A7
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GoPxjEF-3WUl for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:34:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2b; helo=mail-vs1-xe2b.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4BDA64061C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4BDA64061C
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4BDA64061C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:05 +0000 (UTC)
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-73b909fbb6bso862783137.2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515644; x=1786120444;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GrH1R5xqBIkt+kFF9LCfzb9AUsYOtbc9vEcFV/FhfrM=;
 b=YoMioNzaInr1FzaodHJxadB/sS1YGNP7PazQGdhXJ+Eo+uIHMWwuTAXPPgUgbMHkik
 QKo/j6saHE1h23/gAzS1mra1HUxtp8c7gkVem/qr57FutaFVLP8L6fzbH7zuIFzssdTG
 gTv9fvBEOszsINGm69b3MtdK6p9l2PYHa8y1R1DpBKUcPDYqnn6vik/sluDbZfxw1jPX
 P6BjU4Zl8t/6JCRevto0mGSTNZAI9Wo1vN2w1MiYVWIDFJmkT0cF3rTdYLlWvB6kv//c
 9LN9RFkOrdIz7/xVRuuCZR5bc8PiBPW2AtICUVNIG8WgTFmwAqKw1OvI181lmTXSlAHJ
 nQ8w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWKfZ3Afm0uXnqstLz4rTcymAXi5xjdk9+6tlEf9oguwFodkR5Z8CjKsUCMhnWnCrHLIUWuRA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyVAY7P7rFYF4X/naaMULdnhT16yTAbCbosYCFTA4FQobZMf83q
 T4aD9orHtYs1+eEYoGls2NqcXfcmE4FW7BrPpLSBy7Mr1yL84oNuExRkoKEPCRr3XPM=
X-Gm-Gg: AR+sD12R/P+0qaVYsj+W5kzMgjQQPDdByNSJVF7yg1nvfjO1p/GOUQ7EXoEBfwpRMQ0
 8/C6q1DV3j2DAIT01w32bDi08G4KDYtbAwxvpPAoCBWogQJ776GILqUJOtkIu7loI0foDoSKo2n
 B3fGqRNJsJmHlC6Jv3yIalXj0N0ZS/WkJd3NBsw0Vg7Ve4LkgUHd4qrpyuY9wBD3XYdpXLYXoWo
 4v3q1Cpp2Qo2+q18XbcAVi0zUxlDykarApfzu4E9cHsrLs7oM6N41PF+L7xzvRTvcqTJy9i4w2H
 ppEXdEv+ouwXLW4AjHyETCzSgCF0bUe0e5o7idIeIjFHNFmgVyBm6wwPuRMCWvYCicK2uLC+XKe
 +TMvZDSRSIo2IHV57dryy5S0YEIm50dkTbjcZWvkOuttxWvTdMicjw3az9U/4YlS0ipGe68HHF8
 yphsk13DD1aFqlqfXJTOpqjNlr6OCDgTaf1f196N64M+XATmFyjyyHv3dST8IaHyKHkh18eCaxp
 gxT21ox4JWvFghdeAVrzROr0Ns7pDf08lbvZxLYAHwlftGa2YbXdO7SGj50
X-Received: by 2002:a05:6102:fa5:b0:745:31e9:f3d2 with SMTP id
 ada2fe7eead31-75b2335d007mr762202137.10.1785515643551; 
 Fri, 31 Jul 2026 09:34:03 -0700 (PDT)
Received: from maple.netwinder.org ([198.58.133.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e5eb9f77sm1084778241.0.2026.07.31.09.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:34:03 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 31 Jul 2026 12:33:35 -0400
Subject: [PATCH 06/17] net: add r9a06g032 MIIC driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-rzn1-2026-07-v1-6-af2ce80db9d8@linaro.org>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
In-Reply-To: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Stanley Chu <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>, 
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Phil Edworthy <phil.edworthy@renesas.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1785515625; l=7027;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=JSeVXe2CLC2QKTvvNM9u5dsKpbOyfwBuwvpe/SNP5Jo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFVhABaL++tKe1hg33HlGvgjI55Fvrpr1kHEYqIqT3TEe5pJoDk6CrR9DFRr76pnfDcQzNgwee7
 FYqdtqdm2Sgc=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-Mailman-Approved-At: Fri, 31 Jul 2026 16:35:45 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515644; x=1786120444;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GrH1R5xqBIkt+kFF9LCfzb9AUsYOtbc9vEcFV/FhfrM=;
 b=h2KJiMhZyCsQ72T0L99RO0xGPDpbk/DZiWV3SxWH1l5hTTMc3GIJqEXo/hh0/YVjws
 FDTSHicj2OGs3Rd7qmQFPjzTSDcUrCDFP+dk/B4hj/51NP3a3Ctljz7cTiJqQZ5aKRYc
 6NKRJ8Cg89OlDOKc1euIvsI05e7BliEpDZGLQBZsrpq5UPoyZaE1R1sk43e6rdVQGKZ3
 Y0zXMQVRq7W1fTXxMIbYJ9/Wl5Ch4k0n04RnTd5SI5xib5AYKJQmpg49dVBewEmd1DuJ
 Act1M8G83IC1Hp/pWF7a+eQHMGU8GrOlR9MH6onUB5rWUQlDtfCBpOYkQp4LjyhCnxxu
 jD2g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=h2KJiMhZ
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

