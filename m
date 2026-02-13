Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB69EF48ED
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 09:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79EC183DAE;
	Fri, 13 Feb 2026 10:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YOKEvwtJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cEvrTkyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79AB983DCA; Fri, 13 Feb 2026 10:01:57 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEBFF83DAE
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 10:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D0CWef2734911
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5uN95rwVQ8WW1ZFFZBZh5KONNVz6t8E4damAFaDT02I=; b=YOKEvwtJXDWRJU9s
 VUNGlzqQsaUiLEjumRDYJnap/YWPSNWYgHRFHSnkgZTCF+aJg4lOs5ZLWG9M/+Qg
 0H6w/ZaLFjASRFgQ6sr+5oMu7SLMqmHyLJwMwdvJIqaDMXwgrZL+Dag10p+A2o3a
 5Sz8O3X0chyfjFL25/NfGDXbEkoMP+ZoshFA7KMRUaWqcb2X4vFmMVfkWllzqsct
 /Ui1I8ju546F3AwOqOiI70BKDBReTzf0GOOIPuK4MgCv6mf2KRWvWtYzYV8Dgp8e
 IgiRjt39G8af25cSTr7GWIUagAgEvk6ZbKOTXnzDjgGPylbyFM/xbVEjngAd573M
 PbpaXQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9s6wsnft-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:01:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2aaeafeadbcso9359045ad.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 01:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770973311; x=1771578111; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5uN95rwVQ8WW1ZFFZBZh5KONNVz6t8E4damAFaDT02I=;
 b=cEvrTkyVT1i090oLcmh6Ly9f5Rgfol5N28yvrOh/ezX7ntJ3weX6C/boAv22R32SHi
 FjuhAVu8GVdhqtJKcuhy62eBB22nlx069CRWoXHEZa/f8J/8WXtnTFPCJ5ttyUfK7/v+
 D5gp/ZrY4W7gfONECkt/G8ARwYvswBVAutLtmsPUCfrRJu+BPNEcQR/LKm1DiYYnrKX4
 z3uEZ2FYRG/z0WBurea3DCPNfztu1eSb6ueKCxnsTnc8aYQ+RMzhDcDkunIXjB8cW1sz
 IVPx0PDKnSw1TUmDSzC+6+EF4noGBv5uUo21y5F0e8gAaup3lGV/mvt4OpqCAIXcFwqD
 Or/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770973311; x=1771578111;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5uN95rwVQ8WW1ZFFZBZh5KONNVz6t8E4damAFaDT02I=;
 b=I7ehe0CQ/H/az8w2j21AwWm/OahqQnjRp2jH0XGppdCb45/GKNsPuuTf1VK+vnR5+C
 cmSqF7qHcKDchfCtw+ZRF0Nv2Co7ESm7HdlhiI/dwMoJyNtbl6pvLoPwl0S3wt+ppFDj
 skR3AbeabRhk6gbSfNfXzU7rtKTeJC7BgyqgRt66N1jEUwtmmirmuqKHt44dfSMDI94T
 fdKU109w65d9O2TklSs1P1ci6gxcLRvCriK0sDKTa3Vcc6IwTWIB6pxdn0XZ1d0L5z1A
 25aOC8/UQT2Fw4912jtdRI9Qd4ADWwC1v78Ng89iFPzB65Kk6Nw12QmxuQhZlLAnh33E
 blEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe6GWErsDw5qQzFzy5+vf3YteCcJrrZ4BaXJyjPQ6EG73kDC4gVn1ZKJ8W8YouczAKHrPeKSI=@lists.denx.de
X-Gm-Message-State: AOJu0YzDoi+rGy9DUGfaWbH921K4m/mWUXgoBYfql3bZmRihoW5sg5X4
 0KgtxN+2WyrO4eg36wHujYUnk4YK+txY/L+lIYMNmvY4yB5w4A9EFpsLo513ZnfEP/GbY2nrqtg
 xcVAatZI31tU0JkodikZ4i9orLKRkM+k/W5jYBbCVah6stl8YBrgZEBDS
X-Gm-Gg: AZuq6aJH0HCpmHCRLPCb9jFg+wXD4nczHKm/ollSRULgQ6wC9pZWo9EIrbrAFXndLC5
 rQYn/nhOlaCSoNyK5SAxx20iUeSEq4BfHqZQE0+P3CDEjuwx+eA1RwIrBAju7RTMDjfdENEXftF
 Jh3eR0BPUbjm9fZSI9trp0VjXDcKKbFZjhFCID6f03OT4LxiYCgZlGzqpzHsdw5yQPO0p4mSHNO
 Qdh7T/qKBzqeZze8qYiUJjKDsRNG0L6B/n5Ph7nRfeACz0WqMXq6p3+byrPM2jkcp76/IrQ2seL
 fTBud/jFwx3GhQGtdOqfEjvpiAxb2secdrnnozq/dzOB2nXLodDMFuEoCZA+2MFzvVAN4/vXq3s
 vs79mg9448iprnr61RvehSmuJyQ/tYfCpKjXeol+o1K7H25EpXMMDt0uOB5ar+wEkBO1r3JOnEk
 uiEJHxDg2wG4zFSL+qoeeyunS9RKnPJRxKTliB1rslNgFSu4zofQ==
X-Received: by 2002:a17:903:4405:b0:2a0:d34f:aff3 with SMTP id
 d9443c01a7336-2ab5055ee65mr11479205ad.18.1770973311012; 
 Fri, 13 Feb 2026 01:01:51 -0800 (PST)
X-Received: by 2002:a17:903:4405:b0:2a0:d34f:aff3 with SMTP id
 d9443c01a7336-2ab5055ee65mr11478815ad.18.1770973310463; 
 Fri, 13 Feb 2026 01:01:50 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab29965055sm77524755ad.53.2026.02.13.01.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 01:01:50 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 13 Feb 2026 14:31:20 +0530
Subject: [PATCH 3/3] phy: qcom: qusb2: Add QCS615 QUSB2 PHY support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-talos_usb-v1-3-4c4355d61437@oss.qualcomm.com>
References: <20260213-talos_usb-v1-0-4c4355d61437@oss.qualcomm.com>
In-Reply-To: <20260213-talos_usb-v1-0-4c4355d61437@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770973294; l=3550;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Hs8uJF6yVvofSbx/TcZpADn0OHyi0Op8ojD2tpTfM+g=;
 b=Uw84D0Fwv3EWBaDMU6Vt3B4d8o6p19O7E4P1a3T3PYhUCof8QQNAB59uV9XU0Ef0QcFm/YVJC
 ObwakOwlsAMDGP7dSbV+xME0eq3s7HA7DRaZfzRXKTWFGdNQwwxp8z/
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: 0B7HnGSIH6TvPPjsFiSijLCsC9RimY8F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA2OSBTYWx0ZWRfX3R8o6rE3kCtS
 c+3QcLixMFKOfr9ThXpfm08NcnEwK3LMXrTotKg94i6bVYKleDKACfVI9vUpqImY/IYLFDORC1f
 KgIiS7sqdN7n9RRltR4sGrvthC3u0mPNySwx4MNVv1tivP7IpnKTTs1844lMGufMAzt7MwbkVPw
 z6+KGATEJRj9u/DJnPy+w8V5nZYex9kb9YG6NZwXEZoo9jnpGaQsCOd+Z9ik/tnZ2EYcMFM9ZPp
 aV2eiK5IBZ9prqBCxKQ+xTGSXY5k7h4/3WzVjz/aaUaagZNvbKO0sQcCGTFtVyRQdXgzL9yR4MY
 bFNPUpAzfCgg7mLEFpK+h8jaAKBKyGj2Xq2veIwI7C/KB0EJCvup7LCciwI5qhZEY6tz5qPaJJl
 3nUqqgecUQ7SUFucbAZOFJvq2T+jyFD5IK90kPAecH8nlYXtMLiiHExiAOJAHs23wt77+uam1D8
 ozVtHwhOEj4jWCterRw==
X-Proofpoint-GUID: 0B7HnGSIH6TvPPjsFiSijLCsC9RimY8F
X-Authority-Analysis: v=2.4 cv=CLInnBrD c=1 sm=1 tr=0 ts=698ee87f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=32XPU3MRu1Wd0bsjkHcA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130069
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

Add support for QCS615 QUSB2 PHY by introducing platform-specific
initialization table and register layout. The implementation reuses
the IPQ6018 register layout and defines QCS615-specific tuning
parameters for proper USB PHY operation.

Taken from Linux commit 8adbf20e0502 ("phy: qcom-qusb2: Add support for QCS615")

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- No changes in v3

Changes in v2:
- Updated to the reference commit for the QCS615 QUSB2 PHY support
---
 drivers/phy/qcom/phy-qcom-qusb2.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
index 9e821365c15..6278171b100 100644
--- a/drivers/phy/qcom/phy-qcom-qusb2.c
+++ b/drivers/phy/qcom/phy-qcom-qusb2.c
@@ -176,6 +176,19 @@ static const unsigned int sm6115_regs_layout[] = {
 	[QUSB2PHY_PORT_POWERDOWN] = 0xb4, [QUSB2PHY_INTR_CTRL] = 0xbc,
 };
 
+static const unsigned int ipq6018_regs_layout[] = {
+	[QUSB2PHY_PLL_STATUS] = 0x38,
+	[QUSB2PHY_PORT_TUNE1] = 0x80,
+	[QUSB2PHY_PORT_TUNE2] = 0x84,
+	[QUSB2PHY_PORT_TUNE3] = 0x88,
+	[QUSB2PHY_PORT_TUNE4] = 0x8C,
+	[QUSB2PHY_PORT_TUNE5] = 0x90,
+	[QUSB2PHY_PORT_TEST1] = 0x98,
+	[QUSB2PHY_PORT_TEST2] = 0x9C,
+	[QUSB2PHY_PORT_POWERDOWN] = 0xB4,
+	[QUSB2PHY_INTR_CTRL] = 0xBC,
+};
+
 static const struct qusb2_phy_init_tbl msm8996_init_tbl[] = {
 	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xf8),
 	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0xb3),
@@ -189,6 +202,19 @@ static const struct qusb2_phy_init_tbl msm8996_init_tbl[] = {
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
 };
 
+static const struct qusb2_phy_init_tbl qcs615_init_tbl[] = {
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xc8),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0xb3),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE3, 0x83),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE4, 0xc0),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_TUNE, 0x30),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL1, 0x79),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL2, 0x21),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TEST2, 0x14),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_AUTOPGM_CTL1, 0x9f),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
+};
+
 static const struct qusb2_phy_init_tbl qusb2_v2_init_tbl[] = {
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_ANALOG_CONTROLS_TWO, 0x03),
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CLOCK_INVERTERS, 0x7c),
@@ -260,6 +286,16 @@ static const struct qusb2_phy_cfg sdm660_phy_cfg = {
 	.autoresume_en = BIT(3),
 };
 
+static const struct qusb2_phy_cfg qcs615_phy_cfg = {
+	.tbl = qcs615_init_tbl,
+	.tbl_num = ARRAY_SIZE(qcs615_init_tbl),
+	.regs = ipq6018_regs_layout,
+
+	.disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
+	.mask_core_ready = PLL_LOCKED,
+	.autoresume_en = BIT(0),
+};
+
 static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
 	.tbl = qusb2_v2_init_tbl,
 	.tbl_num = ARRAY_SIZE(qusb2_v2_init_tbl),
@@ -467,6 +503,8 @@ static const struct udevice_id qusb2phy_ids[] = {
 	{ .compatible = "qcom,qusb2-phy" },
 	{ .compatible = "qcom,qcm2290-qusb2-phy",
 	  .data = (ulong)&sm6115_phy_cfg },
+	{ .compatible = "qcom,qcs615-qusb2-phy",
+	  .data = (ulong)&qcs615_phy_cfg },
 	{ .compatible = "qcom,sdm660-qusb2-phy",
 	  .data = (ulong)&sdm660_phy_cfg },
 	{ .compatible = "qcom,sm6115-qusb2-phy",

-- 
2.34.1

