Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD73CEACF3
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 18:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E10AF88CFC;
	Wed,  2 Oct 2024 20:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="NHdE7BRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0463188E33; Wed,  2 Oct 2024 20:52:34 +0200 (CEST)
Received: from smtp052.goneo.de (smtp5.goneo.de [IPv6:2001:1640:5::8:30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A612288C60
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 20:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp5.goneo.de (Postfix) with ESMTPS id 593F9240E47;
 Wed,  2 Oct 2024 20:52:31 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id 7ABB0240562;
 Wed,  2 Oct 2024 20:52:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1727895149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bZGZ2cY9Fiji+PukDDuA1dZriKeThMq8xNheF5azpsU=;
 b=NHdE7BRfVlMdLmSHpnCFiUMidA0gs+ftaF0jR3lrDDyL1XX5Ci09QBZQPaV9e5U3/YVr4r
 ih6bUoT3wY0Dje4+8++JqFtKy35uw1CeKO3b43061uH7FpaCLdlVbPRuS9Us+kfhkJfKEl
 ymZlCOezriBW7dwnQS+Hj59KIp93C4BSDKeYPyxYL43D9IayKJi0INczejJMKbVyNLK0oA
 FahVDbpb5JNMjttqgG11bvdJcaxpP2HwJqHDwOz4duo42+RI0+SUHNJR1H0KYHlmPShT8g
 D08nHejvYlSFqh6IC9cxQDzWG2529T38z6SW0rnBlydjlaxIu80rF1+pEFJqmw==
Received: from p200300cbef3987100000000000000193.dip0.t-ipconnect.de
 (p200300cbef398710000000000000076d.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef39:8710::76d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id 2D2A62400E6;
 Wed,  2 Oct 2024 20:52:29 +0200 (CEST)
From: Julius Lehmann <lehmanju@devpi.de>
Date: Wed, 02 Oct 2024 20:52:17 +0200
Subject: [PATCH] phy: qcom: Add SM8150 to QMP UFS PHY driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-sm8150-qmp-phy-v1-1-719695ad2f1e@devpi.de>
X-B4-Tracking: v=1; b=H4sIAGCW/WYC/x3MMQqAMAxA0atIZgNJUbBeRRzURptBrS2IIt7d4
 viG/x9IElUStMUDUU5Num8ZXBYw+WFbBNVlgyFTMZHBtDZcEx5rwOBvdG60lhwPPE6QoxBl1us
 fdv37fpK7YABgAAAA
X-Change-ID: 20241002-sm8150-qmp-phy-ddb990d1a1bc
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Julius Lehmann <lehmanju@devpi.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4315; i=lehmanju@devpi.de;
 h=from:subject:message-id; bh=z4xUGdrSVw+4htX32tI+Ay2Ep7eUk2gKyW5KzQxvtUg=;
 b=owEBbQKS/ZANAwAKARK2S7xC0EEDAcsmYgBm/ZZtCkn+8hTqIPUdxMZUo46SO+5m/+DKoxbiD
 MFIBn7Ux/yJAjMEAAEKAB0WIQTCqoxFzEvlxm0XalUStku8QtBBAwUCZv2WbQAKCRAStku8QtBB
 A9nuD/9azTJsvgJOun2nb2FvxMws/pOkToh7b/GifFGeOo04gy5D/K9/rUp1SEQmXF+C/KwAhH0
 KIKQR6XFz54DNhKMbFVPzn3DxU5Du0jTDfGnQrlbfVS1V3vezcw3z6e665WpN8cPyTCDWErRzpG
 D8il8RivdXrjbUITQwoHYiJvqvEoTMOlePhSji40PF6Rf9afQ4N1Q6QQj2hrfstFw7YtT9dRnRU
 vpzygS0c9sIvRqltxgZbtYaUDOG1KnM4r0b7qMXZhkgLY4c9XEO8s2vwQULpJOwHGz4mCpwEkCP
 nJ/zodFXIFcA3jhjhI+DLPSGoP2EJon7QaWYp6jiD7dMz/Ppmsb9wabMARZBPu6Elnyt4YADo+Q
 4NoO7CY9knIjTZLeWgbxTCcvG6hKoWc/d2ovEJJiNaxPZe356RtCWWkW2rG/44jK5LSHMwje3Tz
 5JPK1erWYqhAbNOb0pBO0Ck1TOpMjnvEsd5OLkjrPIukQtvEWc5jZ2DuByjhg6VeUlkDNB34AGw
 b00RU1c5GxadpH0iglvxIMBB3F2NHa81/aas4iVGahXLKmzf+DOrKjpz7gj5Pj9CF1emxGU68pL
 cWdQFqIEVuXzE45VNsanjITGthT+x2+1kDVK8W+AmXEb68caA969EscH4lr1PiKu1IdsNoSo+xR
 ObRiPQtfJYoQWIQ==
X-Developer-Key: i=lehmanju@devpi.de; a=openpgp;
 fpr=C2AA8C45CC4BE5C66D176A5512B64BBC42D04103
X-Rspamd-UID: 219f3f
X-Rspamd-UID: 2ab45f
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

Copy PHY tables over from Linux to support SM8150

---
As the title suggests, this is really just a simple patch to add Qualcomm's SM8150 SoC to the QMP UFS PHY driver. It has been tested to work with https://lore.kernel.org/u-boot/20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org/ on a Xiaomi Mi Pad 5.

Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
---
 drivers/phy/qcom/phy-qcom-qmp-ufs.c | 62 +++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
index 8908a34df548340556d92ac8ca488dbbbd0e293a..11f92b8261aff48dddb63cd8de31db3716a45fb4 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
@@ -189,6 +189,29 @@ static const struct qmp_ufs_init_tbl sdm845_ufsphy_pcs[] = {
 	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
 };
 
+static const struct qmp_ufs_init_tbl sm8150_ufsphy_hs_g4_tx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0x75),
+};
+
+static const struct qmp_ufs_init_tbl sm8150_ufsphy_hs_g4_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CTRL2, 0x81),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_TERM_BW, 0x6f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_MEASURE_TIME, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x6c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xed),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x3c),
+};
+
 static const struct qmp_ufs_init_tbl sm8150_ufsphy_serdes[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0xd9),
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x11),
@@ -623,6 +646,44 @@ static const struct qmp_ufs_cfg sdm845_ufsphy_cfg = {
 	.no_pcs_sw_reset	= true,
 };
 
+static const struct qmp_ufs_cfg sm8150_ufsphy_cfg = {
+	.lanes			= 2,
+
+	.offsets		= &qmp_ufs_offsets,
+
+	.tbls = {
+		.serdes		= sm8150_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_serdes),
+		.tx		= sm8150_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sm8150_ufsphy_tx),
+		.rx		= sm8150_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sm8150_ufsphy_rx),
+		.pcs		= sm8150_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_pcs),
+	},
+	.tbls_hs_b = {
+		.serdes		= sm8150_ufsphy_hs_b_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
+	},
+	.tbls_hs_g4 = {
+		.tx		= sm8150_ufsphy_hs_g4_tx,
+		.tx_num		= ARRAY_SIZE(sm8150_ufsphy_hs_g4_tx),
+		.rx		= sm8150_ufsphy_hs_g4_rx,
+		.rx_num		= ARRAY_SIZE(sm8150_ufsphy_hs_g4_rx),
+		.pcs		= sm8150_ufsphy_hs_g4_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
+	},
+	.clk_list		= sdm845_ufs_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
+	.vreg_list		= qmp_ufs_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_ufs_vreg_l),
+	.reset_list		= qmp_ufs_reset_l,
+	.num_resets		= ARRAY_SIZE(qmp_ufs_reset_l),
+	.regs			= ufsphy_v4_regs_layout,
+
+	.no_pcs_sw_reset	= false,
+};
+
 static const struct qmp_ufs_cfg sm8250_ufsphy_cfg = {
 	.lanes			= 2,
 
@@ -1100,6 +1161,7 @@ static struct phy_ops qmp_ufs_ops = {
 
 static const struct udevice_id qmp_ufs_ids[] = {
 	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
+	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },
 	{ .compatible = "qcom,sm8250-qmp-ufs-phy", .data = (ulong)&sm8250_ufsphy_cfg },
 	{ .compatible = "qcom,sm8550-qmp-ufs-phy", .data = (ulong)&sm8550_ufsphy_cfg },
 	{ .compatible = "qcom,sm8650-qmp-ufs-phy", .data = (ulong)&sm8650_ufsphy_cfg },

---
base-commit: 2d21dd440e052bb2c8ccc9fa3137ab40c8f87f14
change-id: 20241002-sm8150-qmp-phy-ddb990d1a1bc

Best regards,
-- 
Julius Lehmann <lehmanju@devpi.de>

