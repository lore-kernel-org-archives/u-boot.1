Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39236CCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 19:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 890F183AAE;
	Sat, 11 Oct 2025 21:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="gM9Cvmaj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04FBE83A8C; Sat, 11 Oct 2025 21:11:27 +0200 (CEST)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7387A83A25
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 21:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=mentallysanemainliners.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=igor.belwon@mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256;
 b=gM9CvmajMZKerp6wFqV46oggqIY9pOuU3g9n5sWrHQyyGNlFdYRHWliMW58Y3rR3bDeRtqYGfsLKCPBZ6Z03RlaQJo4frBYMJBZEnlPl9mv9NQBo9gRVSSHKI9TVHGBmjEB75aIygnw/V6L3PF4p4M5UY7tnnphyvCEuUL6PHjqlheKEqFK2Us7/lHB83/Bd2fTffTfhbIzuZQJToN8ZkY4GeuNFUsOdD1JIG0vgKx+xtMMpaDvTScGFH9yuWhId4QFWX5jsaWdC/ly9uVGcnv4l7g7FfsVk0zsI07PvJZKt/4qdmI9zcYMMtBaFUKcSb0NYhc7TaZ9shqr6AG+k5g==;
 s=purelymail1; d=purelymail.com; v=1;
 bh=TPEtSDGKaguysYFkAaHLpDR4YdD0UV8V8HunYleLfUM=;
 h=Feedback-ID:Received:From:Date:Subject:To; 
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1058243981; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 11 Oct 2025 19:10:54 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Date: Sat, 11 Oct 2025 21:10:04 +0200
Subject: [PATCH 1/4] phy: Add MediaTek UFS PHY Driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-mtk-ufs-uboot-v1-1-a05f991ee150@mentallysanemainliners.org>
References: <20251011-mtk-ufs-uboot-v1-0-a05f991ee150@mentallysanemainliners.org>
In-Reply-To: <20251011-mtk-ufs-uboot-v1-0-a05f991ee150@mentallysanemainliners.org>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, Tim Harvey <tharvey@gateworks.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, Simon Glass <sjg@chromium.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <ziyao@disroot.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>, Heiko Schocher <hs@nabladev.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 ~postmarketos/upstreaming@lists.sr.ht
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760209845; l=7286;
 i=igor.belwon@mentallysanemainliners.org; s=20250908;
 h=from:subject:message-id; bh=TPEtSDGKaguysYFkAaHLpDR4YdD0UV8V8HunYleLfUM=;
 b=4WX7/iuU6ZQPirP04aAu+bl/GELF0iBgYnlJzf8aFA9GTpH5F57CdHZaz91L5JV5qKYQQYvn7
 vzYM40m2TtQDNcB0hYVP+DO7QogTDZQ168Ld9hS+FiUAVvaep74tQFk
X-Developer-Key: i=igor.belwon@mentallysanemainliners.org; a=ed25519;
 pk=t9Kz6B3jEwJD7YAKcp8XftfEz7SUSlGbrsfFlbrrFwA=
X-Mailman-Approved-At: Sat, 11 Oct 2025 21:17:18 +0200
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

This UFS M-PHY driver can be used on recent MediaTek SoCs as the
primary PHY for the UFS controller.

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
 drivers/phy/Kconfig       |  10 +++
 drivers/phy/Makefile      |   1 +
 drivers/phy/phy-mtk-ufs.c | 190 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index d36a5f00ef83e3bd6f216181df1a70c848bb11d4..46d02931f3534a1c396e79ab26ed1e03f86398ec 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -281,6 +281,16 @@ config PHY_MTK_TPHY
 	  multi-ports is first version, otherwise is second veriosn,
 	  so you can easily distinguish them by banks layout.
 
+config PHY_MTK_UFS
+	tristate "MediaTek UFS M-PHY driver"
+	depends on ARCH_MEDIATEK
+	depends on PHY
+	help
+	  Support for UFS M-PHY on MediaTek chipsets.
+	  Enable this to provide vendor-specific probing,
+	  initialization, power on and power off flow of
+	  specified M-PHYs.
+
 config PHY_NPCM_USB
 	bool "Nuvoton NPCM USB PHY support"
 	depends on PHY
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 98c1ef8683b7354ccb43426f32ba4dd2f2fcf6c6..8c1bcf72908135cf840d88caeee72bfd4b9270c5 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_MT76X8_USB_PHY) += mt76x8-usb-phy.o
 obj-$(CONFIG_PHY_DA8XX_USB) += phy-da8xx-usb.o
 obj-$(CONFIG_PHY_EXYNOS_USBDRD) += phy-exynos-usbdrd.o
 obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
+obj-$(CONFIG_PHY_MTK_UFS) += phy-mtk-ufs.o
 obj-$(CONFIG_PHY_NPCM_USB) += phy-npcm-usb.o
 obj-$(CONFIG_PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
 obj-$(CONFIG_PHY_IMX8M_PCIE) += phy-imx8m-pcie.o
diff --git a/drivers/phy/phy-mtk-ufs.c b/drivers/phy/phy-mtk-ufs.c
new file mode 100644
index 0000000000000000000000000000000000000000..1eda3df858d820fd6f080cac9d58492ce98f19ee
--- /dev/null
+++ b/drivers/phy/phy-mtk-ufs.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 MediaTek Inc.
+ * Author: Stanley Chu <stanley.chu@mediatek.com>
+ *
+ * Copyright (c) 2025, Igor Belwon <igor.belwon@mentallysanemainliners.org>
+ */
+
+#include "dm/ofnode.h"
+#include "dm/read.h"
+#include <clk.h>
+#include <dm.h>
+#include <generic-phy.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+
+#include <dt-bindings/phy/phy.h>
+
+/* mphy register and offsets */
+#define MP_GLB_DIG_8C               0x008C
+#define FRC_PLL_ISO_EN              BIT(8)
+#define PLL_ISO_EN                  BIT(9)
+#define FRC_FRC_PWR_ON              BIT(10)
+#define PLL_PWR_ON                  BIT(11)
+
+#define MP_LN_DIG_RX_9C             0xA09C
+#define FSM_DIFZ_FRC                BIT(18)
+
+#define MP_LN_DIG_RX_AC             0xA0AC
+#define FRC_RX_SQ_EN                BIT(0)
+#define RX_SQ_EN                    BIT(1)
+
+#define MP_LN_RX_44                 0xB044
+#define FRC_CDR_PWR_ON              BIT(17)
+#define CDR_PWR_ON                  BIT(18)
+#define FRC_CDR_ISO_EN              BIT(19)
+#define CDR_ISO_EN                  BIT(20)
+
+#define UFSPHY_CLKS_CNT    2
+
+struct mtk_ufs_phy {
+	struct udevice *dev;
+	void __iomem *mmio;
+
+	struct clk *unipro_clk;
+	struct clk *mp_clk;
+};
+
+static void ufs_mtk_phy_set_active(struct mtk_ufs_phy *phy)
+{
+	/* release DA_MP_PLL_PWR_ON */
+	setbits_le32(phy->mmio + MP_GLB_DIG_8C, PLL_PWR_ON);
+	clrbits_le32(phy->mmio + MP_GLB_DIG_8C, FRC_FRC_PWR_ON);
+
+	/* release DA_MP_PLL_ISO_EN */
+	clrbits_le32(phy->mmio + MP_GLB_DIG_8C, PLL_ISO_EN);
+	clrbits_le32(phy->mmio + MP_GLB_DIG_8C, FRC_PLL_ISO_EN);
+
+	/* release DA_MP_CDR_PWR_ON */
+	setbits_le32(phy->mmio + MP_LN_RX_44, CDR_PWR_ON);
+	clrbits_le32(phy->mmio + MP_LN_RX_44, FRC_CDR_PWR_ON);
+
+	/* release DA_MP_CDR_ISO_EN */
+	clrbits_le32(phy->mmio + MP_LN_RX_44, CDR_ISO_EN);
+	clrbits_le32(phy->mmio + MP_LN_RX_44, FRC_CDR_ISO_EN);
+
+	/* release DA_MP_RX0_SQ_EN */
+	setbits_le32(phy->mmio + MP_LN_DIG_RX_AC, RX_SQ_EN);
+	clrbits_le32(phy->mmio + MP_LN_DIG_RX_AC, FRC_RX_SQ_EN);
+
+	/* delay 1us to wait DIFZ stable */
+	udelay(1);
+
+	/* release DIFZ */
+	clrbits_le32(phy->mmio + MP_LN_DIG_RX_9C, FSM_DIFZ_FRC);
+}
+
+static int mtk_phy_power_on(struct phy *phy)
+{
+	struct mtk_ufs_phy *ufs_phy = dev_get_priv(phy->dev);
+	int ret;
+
+	ret = clk_enable(ufs_phy->mp_clk);
+	if (ret < 0) {
+		dev_err(phy->dev, "failed to enable mp_clk\n");
+		return ret;
+	}
+
+	ret = clk_enable(ufs_phy->unipro_clk);
+	if (ret < 0) {
+		dev_err(phy->dev, "failed to enable unipro_clk %d\n", ret);
+		clk_disable(ufs_phy->unipro_clk);
+		return ret;
+	}
+
+	ufs_mtk_phy_set_active(ufs_phy);
+
+	return 0;
+}
+
+static int mtk_phy_power_off(struct phy *phy)
+{
+	struct mtk_ufs_phy *ufs_phy = dev_get_priv(phy->dev);
+
+	/* Set PHY to Deep Hibernate mode */
+	setbits_le32(ufs_phy->mmio + MP_LN_DIG_RX_9C, FSM_DIFZ_FRC);
+
+	/* force DA_MP_RX0_SQ_EN */
+	setbits_le32(ufs_phy->mmio + MP_LN_DIG_RX_AC, FRC_RX_SQ_EN);
+	clrbits_le32(ufs_phy->mmio + MP_LN_DIG_RX_AC, RX_SQ_EN);
+
+	/* force DA_MP_CDR_ISO_EN */
+	setbits_le32(ufs_phy->mmio + MP_LN_RX_44, FRC_CDR_ISO_EN);
+	setbits_le32(ufs_phy->mmio + MP_LN_RX_44, CDR_ISO_EN);
+
+	/* force DA_MP_CDR_PWR_ON */
+	setbits_le32(ufs_phy->mmio + MP_LN_RX_44, FRC_CDR_PWR_ON);
+	clrbits_le32(ufs_phy->mmio + MP_LN_RX_44, CDR_PWR_ON);
+
+	/* force DA_MP_PLL_ISO_EN */
+	setbits_le32(ufs_phy->mmio + MP_GLB_DIG_8C, FRC_PLL_ISO_EN);
+	setbits_le32(ufs_phy->mmio + MP_GLB_DIG_8C, PLL_ISO_EN);
+
+	/* force DA_MP_PLL_PWR_ON */
+	setbits_le32(ufs_phy->mmio + MP_GLB_DIG_8C, FRC_FRC_PWR_ON);
+	clrbits_le32(ufs_phy->mmio + MP_GLB_DIG_8C, PLL_PWR_ON);
+
+	return 0;
+}
+
+static const struct phy_ops mtk_ufs_phy_ops = {
+	.power_on	= mtk_phy_power_on,
+	.power_off	= mtk_phy_power_off,
+};
+
+static int mtk_ufs_phy_probe(struct udevice *dev)
+{
+	struct mtk_ufs_phy *phy = dev_get_priv(dev);
+	fdt_addr_t addr;
+	int ret;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE)
+		return -ENOMEM;
+
+	phy->dev = dev;
+	phy->mmio = map_sysmem(addr, 0);
+
+	phy->mp_clk = devm_clk_get(dev, "mp");
+	if (IS_ERR(phy->mp_clk)) {
+		ret = PTR_ERR(phy->mp_clk);
+		dev_err(dev, "Failed to get mp clock (ret=%d)\n", ret);
+		return ret;
+	}
+
+	phy->unipro_clk = devm_clk_get(dev, "unipro");
+	if (IS_ERR(phy->unipro_clk)) {
+		ret = PTR_ERR(phy->unipro_clk);
+		dev_err(dev, "Failed to get unipro clock (ret=%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id mtk_ufs_phy_id_table[] = {
+	{.compatible = "mediatek,mt8183-ufsphy"},
+	{},
+};
+
+U_BOOT_DRIVER(mtk_ufs_phy) = {
+	.name		= "mtk-ufs_phy",
+	.id		= UCLASS_PHY,
+	.of_match	= mtk_ufs_phy_id_table,
+	.ops		= &mtk_ufs_phy_ops,
+	.probe		= mtk_ufs_phy_probe,
+	.priv_auto	= sizeof(struct mtk_ufs_phy),
+};

-- 
2.51.0

