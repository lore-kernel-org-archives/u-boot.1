Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC3CC3ABCC
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 11:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D6A782A1C;
	Tue, 13 May 2025 13:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uy6U6X9Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A4FE829E4; Tue, 13 May 2025 13:02:45 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B1F82A0A
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 13:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D6fGYj019935
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3B7Mi9MDOL2
 dSxT9XlC0fh51EMvARKELbrROinIXIpk=; b=Uy6U6X9ZmCYCFyY/CStyXDs4QK+
 5RO1kDcvRhqiNwWEF0SGtWdPkMWGc1TCZFqbDFGdGKdw1N4xSwpv1JZCXUOxbA7C
 b/O27HI72Jy6oKO6UpIZjPRrjnDU+e2r9RC+5b2i5qZ4plpDhgxuvpTo/Us7ZLYd
 zCDPwppyKxlW31VcOEa05xLEiiauDnwFGp5Tv57tpool2Prb6GPcLfuc8JVH2/gF
 lJehC17NZIaPhhs497F6sZWihxS2Sc+gppOP2VLevYR1GLbUxTVwj9tRpQQ/U1Nj
 WMMj1rzPIZVuwDiu4z+05BOdMfglci8tdvj7nEZ6Uh/l0U8A9bvSR32GrDg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hv5qfsf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:02:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-22e68e50f80so38690765ad.1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 04:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747134160; x=1747738960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3B7Mi9MDOL2dSxT9XlC0fh51EMvARKELbrROinIXIpk=;
 b=XIiaJWmjEjirAuvC4zPgJZhiWSlBUV7rTkoTBPo/c4hzHpobySxX9kHbGS2Pq2c6Cj
 vx60p5aMn8ILttoHBRE4eytFVtJ0ZKdCRsN0yNFISPrn8zCbixINAitFUGzriaLrHM+3
 t/pTySiIjEfpWpCWOyfv6XccUA53lxeemTf5yOjQ8AIX8ZxYJxPs+z8UNLOqYAOL0f3y
 nzv8m5d/PHKySvALqZF3U7fNX/BLBUG07j5k/eCOWJ61TkRu8hvuxSk7voo86al6vQfM
 RoHDB0fJlolr7ill4qcZpugDdyYfb3cUT3p4S+CYoE6WsgAsuS0IuK1ZA8GVurgtbSpj
 xHSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIZyEBc+tvp6vMY4sVtZB71l/q7LQ6hpdusfoaNoDP85pr5Z2wav3RjhUwUE1P2Ut2DheCDw8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9PnUNFb3nrWYuX8N23YDW8w61pDRH7fMUUDe4VmGhWpEcJScV
 ZKQPzVPpMsPYsBtVGyRs++60aCD3+KPntG2Z3Or89ykWiZdha3KE2SnMCy57KtFYpiBq/ZueUWN
 s+kz8NENmzzPr0T5lYyqqVOQhpD31D3kDZPzRS+7nyKRvzohvT5iB
X-Gm-Gg: ASbGncuGbAjrQMA6fLQObwdHWJl8eqWHXcv8ZAJY1FPhWXwoi3xnBBn7O0E92gaZgBB
 AaS4DaXBecxoNkii/vrZdt1lrSKZXMy+T8FdTJz3tCSRHoMDQlP/DJO7uEvENRb+QogXtcKVEYo
 ynBailiIfw7aQmTYLP4Duj3316zZ48AM6w/QGYkhYaLVVnbw7vBwitRV2+Vksle93gv6dR5Dybs
 srS8WLquHLNDJNr/wQyCeOKn3UTsnsSwdBJB9XKae1W2tnwx8txCkiK1lL47KWBweRHNIezxJUO
 kC1esEgq1ToiCdty+N0dc9dcT/CFoWp3EqQ8mp0sohGU0SlL7jUnQjb7d74Tms1sEq267osfOXR
 8b5kPcMIDWT8sqlj/ODM6TaK3z3O2WMg=
X-Received: by 2002:a17:903:988:b0:22e:5abd:7133 with SMTP id
 d9443c01a7336-22fc917f836mr213164945ad.45.1747134160096; 
 Tue, 13 May 2025 04:02:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXWPAqw4cpbnASQRzITMabvn+lTYMl4n44BwavufPJkGb3CTGv4cB1RttXbHhwckZpfQO2Ig==
X-Received: by 2002:a17:903:988:b0:22e:5abd:7133 with SMTP id
 d9443c01a7336-22fc917f836mr213163835ad.45.1747134158846; 
 Tue, 13 May 2025 04:02:38 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82bfa11sm78362135ad.254.2025.05.13.04.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 04:02:37 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 2/5] phy: qcom: Enable QMP UFS PHY driver for QCS615
Date: Tue, 13 May 2025 16:32:10 +0530
Message-Id: <20250513110213.330495-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513110213.330495-1-aswin.murugan@oss.qualcomm.com>
References: <20250513110213.330495-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DqtW+H/+ c=1 sm=1 tr=0 ts=682326d1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=-KtapgylDENPCd9WzicA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: nxKJN-rxvQjTv_5BS6ewM79VYFA6mzOV
X-Proofpoint-GUID: nxKJN-rxvQjTv_5BS6ewM79VYFA6mzOV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEwNSBTYWx0ZWRfX2Yl/wyABp9se
 K1CDWeHW9mT6tOW27YYoLT42vOHnAz/0/src7sP1xuVKfp+Ru2sGbpXatVGvkgsZJmjMZ6P4dIq
 pojf/bXdQZBjThuPYw8Q+4h5dSjV+BhYREvmbzQjH5Y+wFo06QFX14f3Zn1j8k01rjnapnZ+3mL
 loRfDTZie0dLqqLgA4DvSUy0R/JSMAP4gI7A5sinSwRMafxHleXZNZ8izxbMdtZKlJ6fzewCRyS
 VhIW9+43RbhTB5pL7+tzMlzwB9mfdBUCj+Z8mdQlo7OKO8Tku6povw5roWp29fCI5TSA9v0xark
 YesLTZJWJLzJoVvnyVQZvJ0OKIbiNy4wqYeMQZMY9nyvp1RmTGLkP6IiFxVDzeFO8V/zZDW4tR1
 Tq6txCra24/X4rQcPjv2lmO5g8MvxGkSkIMmV6gqIgjx/f3e/BGqyKiU1yvUDltmomWa+FzD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505130105
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

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
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

