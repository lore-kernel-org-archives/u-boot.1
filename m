Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4476BFF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 09:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34421842EF;
	Mon, 27 Apr 2026 11:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ERxshGxe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P3yJgFnV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1330842CE; Mon, 27 Apr 2026 11:26:45 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 715B5842EF
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R8TA181501431
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iniVKzhcpPyiZN7o5tUgItYQ+lNVZn6uv3VwDDI8Utg=; b=ERxshGxe/+oBjcjr
 +c7jso57T8QAgJhaHjqp5c+cnRKLlu6GvOMIXcNWL3XgqrOyBGHDZfQ0Df+0lMa+
 JNSbtBV/QupqoBNPZKs/0+EqgQSgHKQN95f1rI2pS4cAa/IdHZzQktSuUaHdgXDn
 Nq3gwU/81hvV01EIwneRvflDMvwwVDmtCxby5DAvO5x1i0F3N0dBmL+1jW+Co654
 HleviRGK3GtP9bI6xZGNEdrZRsEIpAZHYwq4Y4xTrGOB8UEHfbRkqn/g6yzbBTwF
 7Iusz91Ak5+Z0/vbAmHMjl3BkTyIQy0M/kGxlXFJvMm7RUXhqlXJHHNqFeZ3kNCY
 65VovA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnqrne0s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:26:41 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82fa2165c3eso6119431b3a.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777282001; x=1777886801; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iniVKzhcpPyiZN7o5tUgItYQ+lNVZn6uv3VwDDI8Utg=;
 b=P3yJgFnVTf1yXm+NkHn2Gg+QlMLB1o5lpZL5GS+8HTbC5pY1WeLKDomuciQyNe0Bo+
 O/Ugf1fYK4Qn4EjxV8cn9LFKkOodhGbG7xwwBe4GHGKDN0SwPgn19dMgTRWS/Z9kIZFi
 Xv2CJdyR2CCqQIUR6yOFV/wclezRYnL8G8qRxW43t6+38A8/Dypi3P1UNCAJTxhnuPDx
 WyRAameWMairwnUVN9IY3AoU6rWMDSKD7vIeQAQbbviJtDN+0Jqmr70YxT9ci5Rv/ZP9
 LFu1F6xT21zvqgRIcBvRHQgXUZUd8I0/Twnt1Cp+2uiOD3AJpaZfcJ33hebfgVJlr+GE
 ljjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777282001; x=1777886801;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iniVKzhcpPyiZN7o5tUgItYQ+lNVZn6uv3VwDDI8Utg=;
 b=G0OtiyzVNMKMRjVvSaRLOJ0aXzP43VP8MnhNfv+NPoFgOTfc2rmCpWRRgsAaPr3jc9
 lJyzWJaQZ4g5uuzxMfZtw++M9Szj/CvNFEHkD9jBEDJlo/LQFm2mjRfoIScI11HJ7kvF
 xPrhyvZUDPfq1a7qWUusL/M6pKWBOF/vIA1BqEKrSJPrUJlprYSlgRLgGR05YZD4cvIJ
 6O3g6qux53qq88IFCRcYO63W2M4Y42nh1ThpF0erLKdQBUfFF6QcKE6bHppFfYqhgIMP
 BZGeiYA1qks2u8CbnLZVJvxN1hvtkf/CjlyVwkAusGM3LsDmImQFYWJ+jCH2k4N/1nBn
 1r3w==
X-Gm-Message-State: AOJu0Yy1ejIGFSLUQBEIe0tCj2SQxg+xZ3eFzFY7jiJH7Q5pturzjdYy
 UNUYcVAMqQPArXvVC9HaANocWghveM0CYuVOCG9pBIidnle8kh86G5rqIvK0K+ezPkLlZERU/n0
 Ra+5UUZuCOC36tzWmnGhYHVZwnrDpwr170vJEUVotuwLvPmwc7O8LXy3D
X-Gm-Gg: AeBDiesbW573leXn/EO8TJ47ncdhem7vf1RB7oYKV0AfTL3yDXCVVmJbGOzdEJD8nzW
 oanCTs09ZME5pF3BOHbSfhq1e7k53oxDEi/vPw0Wnt4swKCEGwE+5wRAjiSRy6fpflnAS2JyjLn
 80FrOfuJ9pX5MlI1lyoi6gW/4V8Ij3Qxsck6w/Se9ai1bECDtX7LeoWTNvkxuLpMNfJ0Vrm5BiI
 CPiUno9ojgdP+j6fE57Q+nSdamE9k2IryNjIz2TjmFK92fVKdSC/M2B99WtBfw5KBi58sazcNsb
 WpzoNoJhXKJJQLezKDFZSBZyub3dGnVs6smD57qypfCBPcg1jC/FGLbC9pgeO2ZMeK5pqEHMEt9
 /tdrs4lfbKpSXL59OMQ8yYJQqc8hv26Jvi5ibHpUimvGhfx06aeL8EQjRkkDG6sOfz7lL3FP0k+
 fFI7RAxQjYbTVzgEnUMbNqyq7/3Lb0tRRoDbD/47e8lj00wMhpLRF3JrneXA0H
X-Received: by 2002:a05:6a00:92a7:b0:827:4bca:f1a2 with SMTP id
 d2e1a72fcca58-82f8c87e27fmr41804644b3a.10.1777282000802; 
 Mon, 27 Apr 2026 02:26:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:92a7:b0:827:4bca:f1a2 with SMTP id
 d2e1a72fcca58-82f8c87e27fmr41804608b3a.10.1777282000328; 
 Mon, 27 Apr 2026 02:26:40 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9819fesm31903133b3a.4.2026.04.27.02.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:26:40 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:56:09 +0530
Subject: [PATCH v2 5/7] clk: qcom: sc7280: Add UFS clock support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-ufs_clk-v2-5-36e10a7c0ef6@oss.qualcomm.com>
References: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
In-Reply-To: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777281967; l=3878;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=nnSDAdUzhEYg5qXPlhXxxO5xcXi/9sOmp6rgKApLAA8=;
 b=xXBBa1lBVQOUAcgZ6dfAZqVbPGg4ZG8UUMFVw60iCTzLOv2glflmA8v97nJ6ZCRfeSjOoPDy3
 hK2z5RCldTLDDEY1srMDytmXXyHMyl0Ctqt2ghOX6p7VjrrkViJbCqw
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEwMCBTYWx0ZWRfX83EB6q+tZKH2
 Skg+/s43xmLYoDntplg2XHIUW8jrVjT+ZcSOsazXj4KmCeBn2yzetj/ddVB4pG1QkPArp+QQl4t
 PBDPZPO+QC13KDWXz20NgRYnwpLozsg2P5n7KeFAZG8+aPF+nLrzT7I90PCrrymkC7/5KkG819U
 9Qqgf4FenxTE7o+Do+dhHiX27J/wGp44d/SK79habpFGPZ7lcyb2L2uOkIO0L5L0DTrQ4uaYxoP
 +m4YguZrnqh8FOiYXFSSGiqlGfZDtuqx6lD6OGlk6IZ5/4h/gX/ChAh0P/slY6TjYWfV7rgCWVa
 KNYOtz5t6L55grwG2CHMIgnDHO/YSbvWWLYQzwebXXCtd0T16f/tV5EZzdPf+PqU8+fwJ6yyxW5
 GysYxKyZm97oLlh6P2oHRhhiCjjPw8Wt/hP6UpS88ocKUoFo1ylI66g+wGcbLuUC1trokP4r7qH
 AgM+6oJABNh97qZitlA==
X-Proofpoint-ORIG-GUID: 4rBX8wLFCEMmm0P1wZImL_wqkm6GNaEl
X-Proofpoint-GUID: 4rBX8wLFCEMmm0P1wZImL_wqkm6GNaEl
X-Authority-Analysis: v=2.4 cv=UcthjqSN c=1 sm=1 tr=0 ts=69ef2bd1 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=lctD2BjJw215xePkaksA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270100
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

Add UFS clock support for sc7280 including register definitions,
rate configuration, and gate clocks.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- No changes
---
 drivers/clk/qcom/clock-sc7280.c | 52 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 7b6ed826023..2c73c26484f 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -23,6 +23,10 @@
 #define PCIE_1_AUX_CLK_CMD_RCGR 0x8d058
 #define PCIE1_PHY_RCHNG_CMD_RCGR 0x8d03c
 #define PCIE_1_PIPE_CLK_PHY_MUX 0x8d054
+#define UFS_PHY_AXI_CLK_CMD_RCGR 0x77024
+#define UFS_PHY_ICE_CORE_CLK_CMD_RCGR 0x7706c
+#define UFS_PHY_PHY_AUX_CLK_CMD_RCGR 0x770a0
+#define UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR 0x77084
 
 static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
 	F(66666667, CFG_CLK_SRC_GPLL0_EVEN, 4.5, 0, 0),
@@ -54,6 +58,33 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s2_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(150000000, CFG_CLK_SRC_GPLL0_EVEN, 2, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_ufs_phy_ice_core_clk_src[] = {
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(150000000, CFG_CLK_SRC_GPLL0_EVEN, 2, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_ufs_phy_phy_aux_clk_src[] = {
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(150000000, CFG_CLK_SRC_GPLL0_EVEN, 2, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 0, 0),
+	{ }
+};
+
 static ulong sc7280_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -103,6 +134,26 @@ static ulong sc7280_set_rate(struct clk *clk, ulong rate)
 	case GCC_PCIE1_PHY_RCHNG_CLK:
 		clk_rcg_set_rate(priv->base, PCIE1_PHY_RCHNG_CMD_RCGR, 5, CFG_CLK_SRC_GPLL0_EVEN);
 		return 100000000;
+	case GCC_UFS_PHY_AXI_CLK:
+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_axi_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_AXI_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_UFS_PHY_ICE_CORE_CLK:
+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_ice_core_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_ICE_CORE_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_UFS_PHY_PHY_AUX_CLK:
+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_phy_aux_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_PHY_AUX_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_UFS_PHY_UNIPRO_CORE_CLK:
+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_unipro_core_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
 	default:
 		return rate;
 	}
@@ -147,6 +198,7 @@ static const struct gate_clk sc7280_clks[] = {
 	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0)),
 	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77018, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x77064, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x7705c, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x7709c, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x7701c, BIT(0)),

-- 
2.34.1

