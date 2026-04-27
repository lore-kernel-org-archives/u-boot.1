Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17CBFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 09:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0652842D7;
	Mon, 27 Apr 2026 11:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="k0MhkBai";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UpPNHqkg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB81A842C7; Mon, 27 Apr 2026 11:26:40 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75E3C83693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R8T7IL3639521
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1ldz+lKZwimUqsv2BS06TEnhvc2Cl3XCTDulgKEDAqw=; b=k0MhkBaiyFv8ZJo3
 /aiC/NmNkjbWcik8DhT4E4fUq6P3hiFc69D27D8Q8g7fWTPqVgetfln04mPSDz/T
 mqbLjv5Yy/q/KDW1UcGJxP/JD28wQnQBAQIq1abLKCbvCwVSDR2BTypCkWfWUtcV
 VAOiz0A88k7cdyn0EvSFYe3h6BbGVjKpAVCOqDMegZ6Wj3pb95jomjrvfQL58T8q
 sMTvVM+R0W5wiRAfsyC/+WtlNBEM0VybyDBLjCJ5lBBKf3WHkOXaoqHXGPKtlX7V
 N0r/Pe6lx6k23ITjrSaLwkdy75y/dni1Mq05INBVlVTEIh8+fU/gbckGj2KM4r98
 CqHRRA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dsya01epp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:26:36 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c79907d4c57so3185074a12.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777281995; x=1777886795; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1ldz+lKZwimUqsv2BS06TEnhvc2Cl3XCTDulgKEDAqw=;
 b=UpPNHqkgMvJlm0DvnQFSQ8CZUKSEnx0zPHd07E9Z/9lNpThsOCxDAoILkQbSlIFRdD
 61mTP6Qvm9bdey8yhm6BYHnyOJtD6Cis7LDCEKd1BKbtW2g4Zkt22pvdHsdmLV+0Iu0l
 GaV+b7z3bOMERtcWLJUMMT8NSlV0P8Mx00fgsD1m0ALnq/dfkFpmZOQFVY9/gAcnhqNT
 TRWlW0MN6r+KBvRud2RCpCQOTuzYJTT2xsD2IH3i4SdcghqeHl24iy/qPqJotJiWSaEq
 03kaLu20Ky6ZRfm9aF60aC2UzF/soo5GZVHotaIy7a/OkaEfg7I+AxRH0jae3K5g9hFn
 cnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777281995; x=1777886795;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1ldz+lKZwimUqsv2BS06TEnhvc2Cl3XCTDulgKEDAqw=;
 b=Xo7LLcupx7mZnOOkuTl84ORySmNGPMV0Oi54taQITohc8eamoXuDW4FTiLk7hMaZOf
 HQ2qKwu0bG/Rv/wCwf5a2AFkATM5Sl4w8N3pXhWlzZikQOflhNUA1jfM84ebRgOO9nYC
 sO8jq0RtOvXwj7cud5CaaUarIZBo6FYb/TCyNXq39wP96sNPkdAUqs8KVFJcd7YG8dEV
 00jvp3N0GCSwiIzyg3JXCvL6EYl6ClujY8lcbsk0zU3In2aof8l5sDU3RBhQga60ULuL
 GzXCUvNqmxiBjie8D2PUh91ntHvUFTr68rcVcrPDluRKTRi/nQ60LJWQFkTTBdkf6lpX
 ML+g==
X-Gm-Message-State: AOJu0Yy5g/182r5ZXgwQLzLJerytuolcpBmPmR5ONIxU/9FHVmyDswEB
 2w0YSKWdJwi2I/4JXZk3cgnndjHGkSkzWPT/TgLAUjvS1AKESpgpT1c8/VXBnExNu4m2uPVf7zC
 YE0bR/1jm/W6fEOgM7dMrScxkd09eysRKry4AE1LzU6U5UbfgTJ675ZVC
X-Gm-Gg: AeBDiet1Ao2cgm03+X8/MXKoeqSMwPlIQZKXUCeqbabvPK6QnKgplHweED3HuZF4TnX
 yLHbzv69hCQzrDKcmdoxWNCebAerdecLromryJzdApuY5C+KbgGdWthobBUQafBdMaNAYBBmJJR
 fog4IrRE3qg8K3W06o1q1yfM9FiFT3hzzxqse7prh00XRLH5+5XA4jvD1eo+HdiPpSYkdEv7JHi
 6q88zdjvc6B2vDH0a5++EknY445fTMF/VeD10pIEbdTcQSqDD6kaNDkkQn75eFC4l9OWAO9HZsY
 H3d1m7YMU6VWAEJ+DjyAURE/W6e02NIdL49We0Wbi1QRqaCuwqi1wItXQ7xTvk5QIHz7pmAqHSd
 gdMV43+i0oiR/W3nXgWjYyqB2cJKZlQVDQW9xgRl9ihPiJ4Uoda85ElQlPewTOg81vh+cYLNtFa
 GC8jNSuNh3xyiz9SIOgdqfhpbJ0ErH4aXEt6icDxIgRo9xenHL7pOld9lweF+/
X-Received: by 2002:a05:6a00:b87:b0:827:441a:c970 with SMTP id
 d2e1a72fcca58-82f8c87e33amr42006010b3a.6.1777281995278; 
 Mon, 27 Apr 2026 02:26:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:b87:b0:827:441a:c970 with SMTP id
 d2e1a72fcca58-82f8c87e33amr42005969b3a.6.1777281994669; 
 Mon, 27 Apr 2026 02:26:34 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9819fesm31903133b3a.4.2026.04.27.02.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:26:34 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:56:08 +0530
Subject: [PATCH v2 4/7] clk: qcom: qcs615: Add UFS clock support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-ufs_clk-v2-4-36e10a7c0ef6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777281967; l=4466;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=ApvX5oxbW193N7g7RQwftGNDgSWQ7gsidjI39j9wC18=;
 b=Z0enYSrwN1JcczPqEa03/venBCxckJ3DP7ejlP5O/tyuTwAhh8ZsA/Bjnrjn32i3l7kDLBub3
 gBjZggqyFq+DG/JGwDrWDE9/8uSHG5XnncB16OPQsErj5B/lngFmAay
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: HCVBJMctz7KhwjTfeKFiaL-jyhycAyiD
X-Proofpoint-ORIG-GUID: HCVBJMctz7KhwjTfeKFiaL-jyhycAyiD
X-Authority-Analysis: v=2.4 cv=DZEnbPtW c=1 sm=1 tr=0 ts=69ef2bcc cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=4zqVPMvxyRdUz9D30doA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEwMCBTYWx0ZWRfX1FtN8E05hh8c
 VkOAZGrrJgne8wTJDquqRjD7OenFBRJ7CqOOm1k1clGvubnZ5wRHWrjJCCcDXR2DErScMbgkoqe
 zNoRV7kmBAb1NHyWAtv9ah3PVklfi2q8oTfyFDLqOu5cCZbn0LTTOJ1fqugD/sW34vNLzEzbk8R
 wa/o/Mch6vfauiiRsdHHvsmn54WyxEhidifFseW0ZVwQmy2SPrVxYr94VWpOrkhz7KZpv8OQ+TQ
 UfK9Q5fi/MDC50JX8QkN8/b4CbN2eS/NFJ4WjHMCOudfc/3NOX2EUy+cqNvirr5W1hfC7QsMMY7
 swLGXODceDpFxwJU+2Jl6t6zGaLwMwHMkNWp6VjqdAtzA2dQ5FuGgbV7nlcrEPbWQmHkqJYET+x
 H6qXcT2/VypuTLNMdsCpZrsTgNnBYKPydEAwlvv6LpJgNQI74hpNes/zcKuRZybFb4YVSf30JKa
 AV260cx3QdpqhgO7a9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270100
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

Add UFS clock support for qcs615 including register definitions,
rate configuration, and gate clocks.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- No changes
---
 drivers/clk/qcom/clock-qcs615.c | 63 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
index 2087fc38f63..7b3fe49de9c 100644
--- a/drivers/clk/qcom/clock-qcs615.c
+++ b/drivers/clk/qcom/clock-qcs615.c
@@ -19,6 +19,11 @@
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0xf01c
 #define USB3_PRIM_PHY_AUX_CMD_RCGR		0xf060
 
+#define UFS_PHY_AXI_CLK_CMD_RCGR		0x77020
+#define UFS_PHY_ICE_CORE_CLK_CMD_RCGR		0x77048
+#define UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR	0x77060
+#define UFS_PHY_PHY_AUX_CLK_CMD_RCGR		0x7707c
+
 #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
 #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
 #define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
@@ -33,9 +38,37 @@
 #define GCC_QUPV3_WRAP1_S4_CLK_ENA_BIT BIT(26)
 #define GCC_QUPV3_WRAP1_S5_CLK_ENA_BIT BIT(27)
 
+/* UFS PHY AXI clock frequency table */
+static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
+	{ }
+};
+
+/* UFS PHY ICE CORE clock frequency table */
+static const struct freq_tbl ftbl_gcc_ufs_phy_ice_core_clk_src[] = {
+	F(37500000, CFG_CLK_SRC_GPLL0_EVEN, 8, 0, 0),
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
+	{ }
+};
+
+/* UFS PHY UNIPRO CORE clock frequency table */
+static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
+	F(37500000, CFG_CLK_SRC_GPLL0_EVEN, 8, 0, 0),
+	F(75000000, CFG_CLK_SRC_GPLL0, 8, 0, 0),
+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	{ }
+};
+
 static ulong qcs615_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
 
 	if (clk->id < priv->data->num_clks)
 		debug("%s: %s, requested rate=%ld\n", __func__,
@@ -52,6 +85,24 @@ static ulong qcs615_set_rate(struct clk *clk, ulong rate)
 				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
 		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
 		return rate;
+	case GCC_UFS_PHY_AXI_CLK:
+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_axi_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_AXI_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_UFS_PHY_UNIPRO_CORE_CLK:
+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_unipro_core_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_UFS_PHY_ICE_CORE_CLK:
+		freq = qcom_find_freq(ftbl_gcc_ufs_phy_ice_core_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_ICE_CORE_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_UFS_PHY_PHY_AUX_CLK:
+		clk_rcg_set_rate(priv->base, UFS_PHY_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return 19200000;
 	default:
 		return 0;
 	}
@@ -81,7 +132,17 @@ static const struct gate_clk qcs615_clks[] = {
 	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK, 0x5200c, GCC_QUPV3_WRAP1_S4_CLK_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK, 0x5200c, GCC_QUPV3_WRAP1_S5_CLK_ENA_BIT),
 	GATE_CLK(GCC_DISP_HF_AXI_CLK, 0xb038, BIT(0)),
-	GATE_CLK(GCC_DISP_AHB_CLK, 0xb032, BIT(0))
+	GATE_CLK(GCC_DISP_AHB_CLK, 0xb032, BIT(0)),
+	/* UFS clocks */
+	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0)),
+	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770c0, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77014, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x77040, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x77044, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x77018, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x7701c, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x77078, BIT(0)),
+	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK, 0x8c000, BIT(0)),
 };
 
 static int qcs615_enable(struct clk *clk)

-- 
2.34.1

