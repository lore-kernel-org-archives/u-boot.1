Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93260C3ABC9
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 03:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8E4E82D6F;
	Wed, 21 May 2025 05:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QOIaUpZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96EAA82D88; Wed, 21 May 2025 05:53:53 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 338AD82D59
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 05:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KGdkLT024579
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 03:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QFlNHfXBnHC
 g0fUfHBJKmPEqBbCTepv5cPlPv24PLOg=; b=QOIaUpZpxHq+FJm02WLvy9hIqmT
 9478waWCpHrAMwb8SnJfWAH6KjOfiMstXHXJDalx7NFjdeu1kbMtxIHZQquuV1Xi
 +LGneisec1tIrOVcRIDjceDoq2AbkDcZOASUBVpYOY8C4sHp8FkMAs9PpjCCH5DY
 +0I92DoZ8bP56iUEdL5cyuGwMgbqd33sXgHvroLPPTTXC3OLdmVnu8rTGINRnWjA
 8kHqQndciFI05QdVKHN6dH9GiLQ8hNYGm6tJSz8hWp2oXrYx8qHRVKNq/8LPHRt9
 a2UmKjYgOWBNNebG9SGtKGMcyt4DUN2MdTIpvB2f8bWrKABtDb4OnOR6JeA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf31dny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 03:53:49 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b1ffc678adfso4103583a12.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 20:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747799624; x=1748404424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QFlNHfXBnHCg0fUfHBJKmPEqBbCTepv5cPlPv24PLOg=;
 b=YzQ3C1qt2j/Gd9BLFmD/gct3PPJa1ZMMfeJhbEmBayb8PkfCnxkL+m/hEKlkWKMl3i
 eUtBpabONRM8O+d1LhAXx2aucf2hM1LLqcZmsSeceOK9yXdtpSE8JVtoCupyXaITLB/O
 juwPXxCtxnPFszJdA8IS8bw/5pccMmg85LyB/dHiW5sfSGn2SftrFLY+v6eQp1mKiHYH
 XMw+8rkf/iw0VqaW7T6pZYchwBoccn5S76uzBF9/sNjq+1CMHZoVmuc9nos+A9POnXni
 bI3ItMcpqTZ07fB0LS4LjL2nLWjzD/ytuMKS41Z0ebWsKMCZBLx+JQorEaj/Je/E/Hpu
 5Yxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/qogckUAucPkiBJafsKDzuSU8UkKlYfaCumBMZdmw3xKmH4ullthUjOq8efZ73fxB0XNiMgc=@lists.denx.de
X-Gm-Message-State: AOJu0YwqcIAc5alQJEfY1/440m2MDpF9+ux5noMkLTgc1sifl+gwfPi0
 dHQCXqtxJ39zxGGrgFqSSxE/75MbxHTwpQYxBlRjld95l77xd3gdZI9NiUv5nAiTMebqKfrgm5x
 hOs+K3BnV7FFdSdLyPyitvZqtxDzMopVoOvRCNTQ3/yq4qp2ijG7Okuow
X-Gm-Gg: ASbGnctmuX6vwek1LZ22tCsTwjogongv4jcg2ExtAVtbLUlCHTtm6GH6Vl9rVBnGTsV
 thYFDiuI6Axj5n4CtUoxXgqgs480lcfUYJY9MX17KiEH+D+cBUeMDVIk3bGr7gyN/CCd8/6zHCi
 RDKcgUiqjywZnvbU6vstgZhsOnSJ+xHB+Z4nHAH64c9flzr0KwpTwiIWYWF1y7DtrDuPDS/lQvh
 hgRpLskiu14oWIco+Y2xlRn86prQvw3sWALYgFeZTvIdfB4se6dFVEBlEbBZSFToUzAkwWVm/5M
 FeOVMXsoxQAESc+e0DU1N0KXKexAxyLEjszjQuhiZPk3zPxch64VphahGG5CQ+xVCTvA4H3PIu9
 Qj8SSwrHetvkY4Le/DxkZ6QFQxVZLygQ=
X-Received: by 2002:a05:6a21:9006:b0:1ee:e655:97ea with SMTP id
 adf61e73a8af0-216219ece75mr28474787637.41.1747799623628; 
 Tue, 20 May 2025 20:53:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLCsQiUD01hW0RKlbhaje3zTJaSnSFHTfG1AiVGTV9uvWPAn4wTZF6jHEmTUld1qbxA4KCXQ==
X-Received: by 2002:a05:6a21:9006:b0:1ee:e655:97ea with SMTP id
 adf61e73a8af0-216219ece75mr28474749637.41.1747799623214; 
 Tue, 20 May 2025 20:53:43 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a97395adsm8601675b3a.75.2025.05.20.20.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 20:53:42 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 2/5] phy: qcom: Enable QMP UFS PHY driver for QCS615
Date: Wed, 21 May 2025 09:23:21 +0530
Message-Id: <20250521035324.1182833-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
References: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cp0_n_GBUGU454Oik9RbTLhAfeUo8MFn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAzNSBTYWx0ZWRfX27ET5oOxUgtL
 wJM2FjoPxrabu9Nxp7BFXvdPjCMLYceCeooz81hZ6qYT2+l9bUkgz5QCTeGuRuG2/yFy98Bk/Aj
 oKf7QGaC9EpIQoRPbbi6w92c/ZMU/I2pwcqbzeyxLHESjacP4fQaPo4uLnlBHOLBgY2oYdXRWN1
 YSZ0y3TZXNeQE9hyCceiDQ9Co1Upe91GziaPessp4Pnhar1d64ImP8paBSzFMtSkrWtcDCj5JPT
 FEmSrfFQw1XHzmDFQe/RG9QfK5ixd7RLRP5KefnEnbCJF0o3eY9EOkcBBdzEwS7YbdnMYN6ChC7
 P3S5k+062yby/e21W6ra/HX3hCEhS+Hpv+on9RViSnfgdGpirZ8qOCnt54QzL4T2scU4adh9X3M
 3AO0xE/EnQCfISefBBdNW04NNWEgC0TZwGyifhj1EobKBOJjULDlgd+cRGV6ptPpN3YQ3gSh
X-Proofpoint-GUID: cp0_n_GBUGU454Oik9RbTLhAfeUo8MFn
X-Authority-Analysis: v=2.4 cv=a9kw9VSF c=1 sm=1 tr=0 ts=682d4e4d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=-KtapgylDENPCd9WzicA:9
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210035
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

Enable QMP phy for QCS615, referenced from Linux.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v2:
- No changes to this patch in v2
---
 drivers/phy/qcom/phy-qcom-qmp-ufs.c | 127 ++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
index 449b9767778..175f55e8113 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
@@ -86,6 +86,12 @@ enum qphy_reg_layout {
 	QPHY_LAYOUT_SIZE
 };
 
+static const unsigned int ufsphy_v2_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_START_CTRL]		= QPHY_V2_PCS_UFS_PHY_START,
+	[QPHY_PCS_READY_STATUS]		= QPHY_V2_PCS_UFS_READY_STATUS,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V2_PCS_UFS_POWER_DOWN_CONTROL,
+};
+
 static const unsigned int ufsphy_v3_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_START_CTRL]		= QPHY_V3_PCS_UFS_PHY_START,
 	[QPHY_PCS_READY_STATUS]		= QPHY_V3_PCS_UFS_READY_STATUS,
@@ -715,6 +721,98 @@ static const struct qmp_ufs_init_tbl sc7280_ufsphy_hs_g4_rx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x0f),
 };
 
+static const struct qmp_ufs_init_tbl sm6115_ufsphy_serdes[] = {
+	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CORECLK_DIV, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CORECLK_DIV_MODE1, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_EN, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_CTRL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_RESETSM_CNTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_CFG, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_TIMER1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_TIMER2, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE1_MODE0, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE2_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE1, 0x98),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE1, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE1, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE1, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN1_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE1_MODE1, 0xd6),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE2_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE1, 0x32),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE1, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TRIM, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_INITVAL1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_INITVAL2, 0x00),
+};
+
+static const struct qmp_ufs_init_tbl sm6115_ufsphy_hs_b_serdes[] = {
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x44),
+};
+
+static const struct qmp_ufs_init_tbl sm6115_ufsphy_tx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
+	QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x06),
+};
+
+static const struct qmp_ufs_init_tbl sm6115_ufsphy_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_LVL, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_RX_RX_INTERFACE_MODE, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_RX_RX_TERM_BW, 0x5b),
+	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_GAIN1_LSB, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_GAIN1_MSB, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_GAIN2_LSB, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_GAIN2_MSB, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SVS_SO_GAIN_HALF, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SVS_SO_GAIN_QUARTER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SVS_SO_GAIN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5b),
+};
+
+static const struct qmp_ufs_init_tbl sm6115_ufsphy_pcs[] = {
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_RX_PWM_GEAR_BAND, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_RX_SIGDET_CTRL2, 0x6d),
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_RX_MIN_STALL_NOCONFIG_TIME_CAP, 0x28),
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_RX_SYM_RESYNC_CTRL, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_TX_LARGE_AMP_POST_EMP_LVL, 0x12),
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_TX_SMALL_AMP_POST_EMP_LVL, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_RX_MIN_HIBERN8_TIME, 0x9a), /* 8 us */
+};
+
 struct qmp_ufs_offsets {
 	u16 serdes;
 	u16 pcs;
@@ -1079,6 +1177,34 @@ static const struct qmp_ufs_cfg sa8775p_ufsphy_cfg = {
 	.regs			= ufsphy_v5_regs_layout,
 };
 
+static const struct qmp_ufs_cfg sm6115_ufsphy_cfg = {
+	.lanes			= 1,
+
+	.offsets		= &qmp_ufs_offsets,
+
+	.tbls = {
+		.serdes		= sm6115_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sm6115_ufsphy_serdes),
+		.tx		= sm6115_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sm6115_ufsphy_tx),
+		.rx		= sm6115_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sm6115_ufsphy_rx),
+		.pcs		= sm6115_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sm6115_ufsphy_pcs),
+	},
+	.tbls_hs_b = {
+		.serdes		= sm6115_ufsphy_hs_b_serdes,
+		.serdes_num	= ARRAY_SIZE(sm6115_ufsphy_hs_b_serdes),
+	},
+	.clk_list		= sdm845_ufs_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
+	.vreg_list		= qmp_ufs_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_ufs_vreg_l),
+	.regs			= ufsphy_v2_regs_layout,
+
+	.no_pcs_sw_reset	= true,
+};
+
 static void qmp_ufs_configure_lane(void __iomem *base,
 					const struct qmp_ufs_init_tbl tbl[],
 					int num,
@@ -1472,6 +1598,7 @@ static const struct udevice_id qmp_ufs_ids[] = {
 	{ .compatible = "qcom,sm8550-qmp-ufs-phy", .data = (ulong)&sm8550_ufsphy_cfg },
 	{ .compatible = "qcom,sm8650-qmp-ufs-phy", .data = (ulong)&sm8650_ufsphy_cfg },
 	{ .compatible = "qcom,sc7280-qmp-ufs-phy", .data = (ulong)&sc7280_ufsphy_cfg, },
+	{ .compatible = "qcom,qcs615-qmp-ufs-phy", .data = (ulong)&sm6115_ufsphy_cfg, },
 	{ }
 };
 
-- 
2.34.1

