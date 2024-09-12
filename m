Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C35BEED601
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 13:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72E9A88FBF;
	Thu, 12 Sep 2024 15:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=motor-comm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45FBE88F96; Thu, 12 Sep 2024 14:02:48 +0200 (CEST)
Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com
 [115.124.28.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57BE488F9C
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 14:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=motor-comm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Frank.Sae@motor-comm.com
Received: from ubuntu.localdomain(mailfrom:Frank.Sae@motor-comm.com
 fp:SMTPD_---.ZHPh8iP_1726142557) by smtp.aliyun-inc.com;
 Thu, 12 Sep 2024 20:02:40 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 trini@konsulko.com, Frank.Sae@motor-comm.com, ycliang@andestech.com,
 tekieli.lukasz@gmail.com, frattaroli.nicolas@gmail.com
Cc: yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
 xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com,
 jie.han@motor-comm.com
Subject: [PATCH v1 2/2] net: phy: motorcomm: Add driver for Motorcomm YT8821
 2.5G ethernet phy
Date: Thu, 12 Sep 2024 05:02:25 -0700
Message-Id: <20240912120225.28884-3-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912120225.28884-1-Frank.Sae@motor-comm.com>
References: <20240912120225.28884-1-Frank.Sae@motor-comm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Sep 2024 15:11:43 +0200
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

Add a driver for the motorcomm YT8821 2.5G ethernet phy which works in
2500base-x mode.

Verify the driver on BPI-R3(with MediaTek MT7986(Filogic 830) SoC) evb.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 drivers/net/phy/motorcomm.c | 491 ++++++++++++++++++++++++++++++++++++
 1 file changed, 491 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 070de0645d..4d67203ee7 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -12,6 +12,7 @@
 
 #define PHY_ID_YT8511				0x0000010a
 #define PHY_ID_YT8531				0x4f51e91b
+#define PHY_ID_YT8821				0x4f51ea19
 #define PHY_ID_MASK				GENMASK(31, 0)
 
 /* Extended Register's Address Offset Register */
@@ -106,6 +107,8 @@
 #define YTPHY_SPEED_10M				((0x0 << 14))
 #define YTPHY_SPEED_100M			((0x1 << 14))
 #define YTPHY_SPEED_1000M			((0x2 << 14))
+#define YTPHY_SPEED_10G				((0x3 << 14))
+#define YTPHY_SPEED_2500M			((0x0 << 14) | BIT(9))
 
 #define YT8531_EXTREG_SLEEP_CONTROL1_REG	0x27
 #define YT8531_ESC1R_SLEEP_SW			BIT(15)
@@ -133,6 +136,91 @@
 #define TX_CLK_100_INVERTED			BIT(4)
 #define TX_CLK_1000_INVERTED			BIT(5)
 
+#define YT8821_SDS_EXT_CSR_CTRL_REG		0x23
+#define YT8821_SDS_EXT_CSR_VCO_LDO_EN		BIT(15)
+#define YT8821_SDS_EXT_CSR_VCO_BIAS_LPF_EN	BIT(8)
+
+#define YT8821_UTP_EXT_PI_CTRL_REG		0x56
+#define YT8821_UTP_EXT_PI_RST_N_FIFO		BIT(5)
+#define YT8821_UTP_EXT_PI_TX_CLK_SEL_AFE	BIT(4)
+#define YT8821_UTP_EXT_PI_RX_CLK_3_SEL_AFE	BIT(3)
+#define YT8821_UTP_EXT_PI_RX_CLK_2_SEL_AFE	BIT(2)
+#define YT8821_UTP_EXT_PI_RX_CLK_1_SEL_AFE	BIT(1)
+#define YT8821_UTP_EXT_PI_RX_CLK_0_SEL_AFE	BIT(0)
+
+#define YT8821_UTP_EXT_VCT_CFG6_CTRL_REG	0x97
+#define YT8821_UTP_EXT_FECHO_AMP_TH_HUGE	GENMASK(15, 8)
+
+#define YT8821_UTP_EXT_ECHO_CTRL_REG		0x336
+#define YT8821_UTP_EXT_TRACE_LNG_GAIN_THR_1000	GENMASK(14, 8)
+
+#define YT8821_UTP_EXT_GAIN_CTRL_REG		0x340
+#define YT8821_UTP_EXT_TRACE_MED_GAIN_THR_1000	GENMASK(6, 0)
+
+#define YT8821_UTP_EXT_RPDN_CTRL_REG		0x34E
+#define YT8821_UTP_EXT_RPDN_BP_FFE_LNG_2500	BIT(15)
+#define YT8821_UTP_EXT_RPDN_BP_FFE_SHT_2500	BIT(7)
+#define YT8821_UTP_EXT_RPDN_IPR_SHT_2500	GENMASK(6, 0)
+
+#define YT8821_UTP_EXT_TH_20DB_2500_CTRL_REG	0x36A
+#define YT8821_UTP_EXT_TH_20DB_2500		GENMASK(15, 0)
+
+#define YT8821_UTP_EXT_TRACE_CTRL_REG		0x372
+#define YT8821_UTP_EXT_TRACE_LNG_GAIN_THE_2500	GENMASK(14, 8)
+#define YT8821_UTP_EXT_TRACE_MED_GAIN_THE_2500	GENMASK(6, 0)
+
+#define YT8821_UTP_EXT_ALPHA_IPR_CTRL_REG	0x374
+#define YT8821_UTP_EXT_ALPHA_SHT_2500		GENMASK(14, 8)
+#define YT8821_UTP_EXT_IPR_LNG_2500		GENMASK(6, 0)
+
+#define YT8821_UTP_EXT_PLL_CTRL_REG		0x450
+#define YT8821_UTP_EXT_PLL_SPARE_CFG		GENMASK(7, 0)
+
+#define YT8821_UTP_EXT_DAC_IMID_CH_2_3_CTRL_REG	0x466
+#define YT8821_UTP_EXT_DAC_IMID_CH_3_10_ORG	GENMASK(14, 8)
+#define YT8821_UTP_EXT_DAC_IMID_CH_2_10_ORG	GENMASK(6, 0)
+
+#define YT8821_UTP_EXT_DAC_IMID_CH_0_1_CTRL_REG	0x467
+#define YT8821_UTP_EXT_DAC_IMID_CH_1_10_ORG	GENMASK(14, 8)
+#define YT8821_UTP_EXT_DAC_IMID_CH_0_10_ORG	GENMASK(6, 0)
+
+#define YT8821_UTP_EXT_DAC_IMSB_CH_2_3_CTRL_REG	0x468
+#define YT8821_UTP_EXT_DAC_IMSB_CH_3_10_ORG	GENMASK(14, 8)
+#define YT8821_UTP_EXT_DAC_IMSB_CH_2_10_ORG	GENMASK(6, 0)
+
+#define YT8821_UTP_EXT_DAC_IMSB_CH_0_1_CTRL_REG	0x469
+#define YT8821_UTP_EXT_DAC_IMSB_CH_1_10_ORG	GENMASK(14, 8)
+#define YT8821_UTP_EXT_DAC_IMSB_CH_0_10_ORG	GENMASK(6, 0)
+
+#define YT8821_UTP_EXT_MU_COARSE_FR_CTRL_REG	0x4B3
+#define YT8821_UTP_EXT_MU_COARSE_FR_F_FFE	GENMASK(14, 12)
+#define YT8821_UTP_EXT_MU_COARSE_FR_F_FBE	GENMASK(10, 8)
+
+#define YT8821_UTP_EXT_MU_FINE_FR_CTRL_REG	0x4B5
+#define YT8821_UTP_EXT_MU_FINE_FR_F_FFE		GENMASK(14, 12)
+#define YT8821_UTP_EXT_MU_FINE_FR_F_FBE		GENMASK(10, 8)
+
+#define YT8821_UTP_EXT_VGA_LPF1_CAP_CTRL_REG	0x4D2
+#define YT8821_UTP_EXT_VGA_LPF1_CAP_OTHER	GENMASK(7, 4)
+#define YT8821_UTP_EXT_VGA_LPF1_CAP_2500	GENMASK(3, 0)
+
+#define YT8821_UTP_EXT_VGA_LPF2_CAP_CTRL_REG	0x4D3
+#define YT8821_UTP_EXT_VGA_LPF2_CAP_OTHER	GENMASK(7, 4)
+#define YT8821_UTP_EXT_VGA_LPF2_CAP_2500	GENMASK(3, 0)
+
+#define YT8821_UTP_EXT_TXGE_NFR_FR_THP_CTRL_REG	0x660
+#define YT8821_UTP_EXT_NFR_TX_ABILITY		BIT(3)
+
+#define YT8821_CHIP_MODE_FORCE_BX2500		1
+
+/* chip config register */
+#define YTPHY_CCR_MODE_SEL_MASK			GENMASK(2, 0)
+
+#define YTPHY_REG_SPACE_SELECT_REG		0xA000
+#define YTPHY_RSSR_SPACE_MASK			BIT(1)
+#define YTPHY_RSSR_FIBER_SPACE			(0x1 << 1)
+#define YTPHY_RSSR_UTP_SPACE			(0x0 << 1)
+
 struct ytphy_plat_priv {
 	u32 rx_delay_ps;
 	u32 tx_delay_ps;
@@ -634,6 +722,398 @@ static int yt8531_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int ytphy_save_page(struct phy_device *phydev)
+{
+	int old_page;
+
+	old_page = ytphy_read_ext(phydev, YTPHY_REG_SPACE_SELECT_REG);
+	if (old_page < 0)
+		return old_page;
+
+	if ((old_page & YTPHY_RSSR_SPACE_MASK) == YTPHY_RSSR_FIBER_SPACE)
+		return YTPHY_RSSR_FIBER_SPACE;
+
+	return YTPHY_RSSR_UTP_SPACE;
+};
+
+static int ytphy_restore_page(struct phy_device *phydev, int page,
+			      int ret)
+{
+	int mask = YTPHY_RSSR_SPACE_MASK;
+	int set;
+	int r;
+
+	if ((page & YTPHY_RSSR_SPACE_MASK) == YTPHY_RSSR_FIBER_SPACE)
+		set = YTPHY_RSSR_FIBER_SPACE;
+	else
+		set = YTPHY_RSSR_UTP_SPACE;
+
+	r = ytphy_modify_ext(phydev, YTPHY_REG_SPACE_SELECT_REG, mask,
+			     set);
+	if (ret >= 0 && r < 0)
+		ret = r;
+
+	return ret;
+};
+
+static int ytphy_write_ext(struct phy_device *phydev, u16 regnum,
+			   u16 val)
+{
+	int ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE,
+			YTPHY_PAGE_SELECT, regnum);
+	if (ret < 0)
+		return ret;
+
+	return phy_write(phydev, MDIO_DEVAD_NONE, YTPHY_PAGE_DATA, val);
+}
+
+static int yt8821_probe(struct phy_device *phydev)
+{
+	phydev->advertising = PHY_GBIT_FEATURES |
+				SUPPORTED_2500baseX_Full |
+				SUPPORTED_Pause |
+				SUPPORTED_Asym_Pause;
+	phydev->supported = phydev->advertising;
+
+	return 0;
+}
+
+static int yt8821_serdes_init(struct phy_device *phydev)
+{
+	int old_page;
+	u16 mask;
+	u16 set;
+	int ret;
+
+	old_page = ytphy_save_page(phydev);
+	if (old_page < 0)
+		return old_page;
+
+	ret = ytphy_modify_ext(phydev, YTPHY_REG_SPACE_SELECT_REG,
+			       YTPHY_RSSR_SPACE_MASK,
+			       YTPHY_RSSR_FIBER_SPACE);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = phy_modify(phydev, MDIO_DEVAD_NONE, MII_BMCR,
+			 BMCR_ANENABLE, 0);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_SDS_EXT_CSR_VCO_LDO_EN |
+		YT8821_SDS_EXT_CSR_VCO_BIAS_LPF_EN;
+	set = YT8821_SDS_EXT_CSR_VCO_LDO_EN;
+	ret = ytphy_modify_ext(phydev, YT8821_SDS_EXT_CSR_CTRL_REG, mask,
+			       set);
+
+err_restore_page:
+	return ytphy_restore_page(phydev, old_page, ret);
+}
+
+static int yt8821_utp_init(struct phy_device *phydev)
+{
+	int old_page;
+	u16 mask;
+	u16 save;
+	u16 set;
+	int ret;
+
+	old_page = ytphy_save_page(phydev);
+	if (old_page < 0)
+		return old_page;
+
+	ret = ytphy_modify_ext(phydev, YTPHY_REG_SPACE_SELECT_REG,
+			       YTPHY_RSSR_SPACE_MASK,
+			       YTPHY_RSSR_UTP_SPACE);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_RPDN_BP_FFE_LNG_2500 |
+		YT8821_UTP_EXT_RPDN_BP_FFE_SHT_2500 |
+		YT8821_UTP_EXT_RPDN_IPR_SHT_2500;
+	set = YT8821_UTP_EXT_RPDN_BP_FFE_LNG_2500 |
+		YT8821_UTP_EXT_RPDN_BP_FFE_SHT_2500;
+	ret = ytphy_modify_ext(phydev, YT8821_UTP_EXT_RPDN_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_VGA_LPF1_CAP_OTHER |
+		YT8821_UTP_EXT_VGA_LPF1_CAP_2500;
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_VGA_LPF1_CAP_CTRL_REG,
+			       mask, 0);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_VGA_LPF2_CAP_OTHER |
+		YT8821_UTP_EXT_VGA_LPF2_CAP_2500;
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_VGA_LPF2_CAP_CTRL_REG,
+			       mask, 0);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_TRACE_LNG_GAIN_THE_2500 |
+		YT8821_UTP_EXT_TRACE_MED_GAIN_THE_2500;
+	set = FIELD_PREP(YT8821_UTP_EXT_TRACE_LNG_GAIN_THE_2500, 0x5a) |
+		FIELD_PREP(YT8821_UTP_EXT_TRACE_MED_GAIN_THE_2500, 0x3c);
+	ret = ytphy_modify_ext(phydev, YT8821_UTP_EXT_TRACE_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_IPR_LNG_2500;
+	set = FIELD_PREP(YT8821_UTP_EXT_IPR_LNG_2500, 0x6c);
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_ALPHA_IPR_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_TRACE_LNG_GAIN_THR_1000;
+	set = FIELD_PREP(YT8821_UTP_EXT_TRACE_LNG_GAIN_THR_1000, 0x2a);
+	ret = ytphy_modify_ext(phydev, YT8821_UTP_EXT_ECHO_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_TRACE_MED_GAIN_THR_1000;
+	set = FIELD_PREP(YT8821_UTP_EXT_TRACE_MED_GAIN_THR_1000, 0x22);
+	ret = ytphy_modify_ext(phydev, YT8821_UTP_EXT_GAIN_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_TH_20DB_2500;
+	set = FIELD_PREP(YT8821_UTP_EXT_TH_20DB_2500, 0x8000);
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_TH_20DB_2500_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_MU_COARSE_FR_F_FFE |
+		YT8821_UTP_EXT_MU_COARSE_FR_F_FBE;
+	set = FIELD_PREP(YT8821_UTP_EXT_MU_COARSE_FR_F_FFE, 0x7) |
+		FIELD_PREP(YT8821_UTP_EXT_MU_COARSE_FR_F_FBE, 0x7);
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_MU_COARSE_FR_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_MU_FINE_FR_F_FFE |
+		YT8821_UTP_EXT_MU_FINE_FR_F_FBE;
+	set = FIELD_PREP(YT8821_UTP_EXT_MU_FINE_FR_F_FFE, 0x2) |
+		FIELD_PREP(YT8821_UTP_EXT_MU_FINE_FR_F_FBE, 0x2);
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_MU_FINE_FR_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* save YT8821_UTP_EXT_PI_CTRL_REG's val for use later */
+	ret = ytphy_read_ext(phydev, YT8821_UTP_EXT_PI_CTRL_REG);
+	if (ret < 0)
+		goto err_restore_page;
+
+	save = ret;
+
+	mask = YT8821_UTP_EXT_PI_TX_CLK_SEL_AFE |
+		YT8821_UTP_EXT_PI_RX_CLK_3_SEL_AFE |
+		YT8821_UTP_EXT_PI_RX_CLK_2_SEL_AFE |
+		YT8821_UTP_EXT_PI_RX_CLK_1_SEL_AFE |
+		YT8821_UTP_EXT_PI_RX_CLK_0_SEL_AFE;
+	ret = ytphy_modify_ext(phydev, YT8821_UTP_EXT_PI_CTRL_REG,
+			       mask, 0);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* restore YT8821_UTP_EXT_PI_CTRL_REG's val */
+	ret = ytphy_write_ext(phydev, YT8821_UTP_EXT_PI_CTRL_REG, save);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_FECHO_AMP_TH_HUGE;
+	set = FIELD_PREP(YT8821_UTP_EXT_FECHO_AMP_TH_HUGE, 0x38);
+	ret = ytphy_modify_ext(phydev, YT8821_UTP_EXT_VCT_CFG6_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_NFR_TX_ABILITY;
+	set = YT8821_UTP_EXT_NFR_TX_ABILITY;
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_TXGE_NFR_FR_THP_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_PLL_SPARE_CFG;
+	set = FIELD_PREP(YT8821_UTP_EXT_PLL_SPARE_CFG, 0xe9);
+	ret = ytphy_modify_ext(phydev, YT8821_UTP_EXT_PLL_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_DAC_IMID_CH_3_10_ORG |
+		YT8821_UTP_EXT_DAC_IMID_CH_2_10_ORG;
+	set = FIELD_PREP(YT8821_UTP_EXT_DAC_IMID_CH_3_10_ORG, 0x64) |
+		FIELD_PREP(YT8821_UTP_EXT_DAC_IMID_CH_2_10_ORG, 0x64);
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_DAC_IMID_CH_2_3_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_DAC_IMID_CH_1_10_ORG |
+		YT8821_UTP_EXT_DAC_IMID_CH_0_10_ORG;
+	set = FIELD_PREP(YT8821_UTP_EXT_DAC_IMID_CH_1_10_ORG, 0x64) |
+		FIELD_PREP(YT8821_UTP_EXT_DAC_IMID_CH_0_10_ORG, 0x64);
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_DAC_IMID_CH_0_1_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_DAC_IMSB_CH_3_10_ORG |
+		YT8821_UTP_EXT_DAC_IMSB_CH_2_10_ORG;
+	set = FIELD_PREP(YT8821_UTP_EXT_DAC_IMSB_CH_3_10_ORG, 0x64) |
+		FIELD_PREP(YT8821_UTP_EXT_DAC_IMSB_CH_2_10_ORG, 0x64);
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_DAC_IMSB_CH_2_3_CTRL_REG,
+			       mask, set);
+	if (ret < 0)
+		goto err_restore_page;
+
+	mask = YT8821_UTP_EXT_DAC_IMSB_CH_1_10_ORG |
+		YT8821_UTP_EXT_DAC_IMSB_CH_0_10_ORG;
+	set = FIELD_PREP(YT8821_UTP_EXT_DAC_IMSB_CH_1_10_ORG, 0x64) |
+		FIELD_PREP(YT8821_UTP_EXT_DAC_IMSB_CH_0_10_ORG, 0x64);
+	ret = ytphy_modify_ext(phydev,
+			       YT8821_UTP_EXT_DAC_IMSB_CH_0_1_CTRL_REG,
+			       mask, set);
+
+err_restore_page:
+	return ytphy_restore_page(phydev, old_page, ret);
+}
+
+static int yt8821_auto_sleep_config(struct phy_device *phydev,
+				    bool enable)
+{
+	int old_page;
+	int ret;
+
+	old_page = ytphy_save_page(phydev);
+	if (old_page < 0)
+		return old_page;
+
+	ret = ytphy_modify_ext(phydev, YTPHY_REG_SPACE_SELECT_REG,
+			       YTPHY_RSSR_SPACE_MASK,
+			       YTPHY_RSSR_UTP_SPACE);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_modify_ext(phydev,
+			       YT8531_EXTREG_SLEEP_CONTROL1_REG,
+			       YT8531_ESC1R_SLEEP_SW,
+			       enable ? 1 : 0);
+
+err_restore_page:
+	return ytphy_restore_page(phydev, old_page, ret);
+}
+
+static int yt8821_soft_reset(struct phy_device *phydev)
+{
+	return ytphy_modify_ext(phydev, YT8531_CHIP_CONFIG_REG,
+				YT8531_CCR_SW_RST, 0);
+}
+
+static int yt8821_config(struct phy_device *phydev)
+{
+	u8 mode = YT8821_CHIP_MODE_FORCE_BX2500;
+	int ret;
+	u16 set;
+
+	set = FIELD_PREP(YTPHY_CCR_MODE_SEL_MASK, mode);
+	ret = ytphy_modify_ext(phydev,
+			       YT8531_CHIP_CONFIG_REG,
+			       YTPHY_CCR_MODE_SEL_MASK,
+			       set);
+	if (ret < 0)
+		return ret;
+
+	ret = yt8821_serdes_init(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = yt8821_utp_init(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = yt8821_auto_sleep_config(phydev, false);
+	if (ret < 0)
+		return ret;
+
+	return yt8821_soft_reset(phydev);
+}
+
+static void yt8821_parse_status(struct phy_device *phydev, int val)
+{
+	int speed_mode;
+	int speed;
+
+	speed_mode = val & YTPHY_SPEED_MASK;
+	switch (speed_mode) {
+	case YTPHY_SPEED_2500M:
+		speed = SPEED_2500;
+		break;
+	case YTPHY_SPEED_1000M:
+		speed = SPEED_1000;
+		break;
+	case YTPHY_SPEED_100M:
+		speed = SPEED_100;
+		break;
+	case YTPHY_SPEED_10M:
+		speed = SPEED_10;
+		break;
+	}
+
+	phydev->speed = speed;
+	phydev->duplex = FIELD_GET(YTPHY_DUPLEX_MASK, val);
+}
+
+static int yt8821_startup(struct phy_device *phydev)
+{
+	u16 val;
+	int ret;
+
+	ret = ytphy_modify_ext(phydev, YTPHY_REG_SPACE_SELECT_REG,
+			       YTPHY_RSSR_SPACE_MASK,
+			       YTPHY_RSSR_UTP_SPACE);
+	if (ret)
+		return ret;
+
+	ret = genphy_update_link(phydev);
+	if (ret)
+		return ret;
+
+	ret = phy_read(phydev, MDIO_DEVAD_NONE,
+		       YTPHY_SPECIFIC_STATUS_REG);
+	if (ret < 0)
+		return ret;
+
+	val = ret;
+
+	if (phydev->link)
+		yt8821_parse_status(phydev, val);
+
+	return 0;
+}
+
 U_BOOT_PHY_DRIVER(motorcomm8511) = {
 	.name          = "YT8511 Gigabit Ethernet",
 	.uid           = PHY_ID_YT8511,
@@ -654,3 +1134,14 @@ U_BOOT_PHY_DRIVER(motorcomm8531) = {
 	.startup       = &yt8531_startup,
 	.shutdown      = &genphy_shutdown,
 };
+
+U_BOOT_PHY_DRIVER(motorcomm8821) = {
+	.name		= "YT8821 2.5G Ethernet",
+	.uid		= PHY_ID_YT8821,
+	.mask		= PHY_ID_MASK,
+	.mmds		= (MDIO_MMD_PMAPMD | MDIO_MMD_PCS | MDIO_MMD_AN),
+	.probe		= &yt8821_probe,
+	.config		= &yt8821_config,
+	.startup	= &yt8821_startup,
+	.shutdown	= &genphy_shutdown,
+};
-- 
2.34.1

