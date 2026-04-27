Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869F7FF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 09:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 953858421D;
	Mon, 27 Apr 2026 11:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YuTmAouo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iBgmSsVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7617E83693; Mon, 27 Apr 2026 11:26:34 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4957E8421D
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R8TChH2913900
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WJN4BPXWKT4dl94kMTxZ4hSVOJOvfRGKX1GYBKhXu8I=; b=YuTmAouoQjGAe6V1
 8CMAaSXds2cESpq1F6VymE4Lkw3hfoP3odzZJPwKX6h4M+cJYg9xIO+ghfDrYxF+
 R0K2BqWm0Gk6RLyFA8z8d+bNOyq8we+fA46UZeVUQa2gxhAZuZHX7NeC5k48ayfG
 sp0sqfWlwqjLl+v1EC2KmfzUt8DWK92L95kNAlDO5htkicLd6LdrZHrg+TEkHD6g
 RaTbWA/Ndif04HZ8nnL9iLrICObMZdpGQhheoV4WWBoASqDmKt+lF+pxV76UOztU
 FcL5eDfSatL4m3D9hZKADjECGlO28x5qcZ1V8z4+NGp1VzOLFr70DVmAwmTY2THn
 NQF1qQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt26xgtp2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:26:30 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82f9429f49cso12508483b3a.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777281990; x=1777886790; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WJN4BPXWKT4dl94kMTxZ4hSVOJOvfRGKX1GYBKhXu8I=;
 b=iBgmSsVhzqhOpnHa9L4qMCPXkDQLnyg89M7T0QPwaRKuSSLVVp2rQCePOrxekLkDNB
 jKmH3OVP3W4PqG7nbImhI8rqhTBusC5GQc0j1oR/10aagj5YP3BkU1BiIJW1oe0iN7Sr
 Fi66t5KThcKGNM+HiSmZHcfrWQLmbf3zhGuq34i4hfNP6HFhC0tLxGZw62FhgGULjTDG
 KttFSTi4yx2w1Sp7SglXh7gpx79kb73vzLwiJL6pKybXkNU04hU6HTrjj4y8C19VfPgC
 +qSO6Zsol2LO+qM97BF8rENBdJMBm5SG/h0Jf4EVhfOqzHdmmf3+7E5E5X1ZItMkCRU9
 osmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777281990; x=1777886790;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WJN4BPXWKT4dl94kMTxZ4hSVOJOvfRGKX1GYBKhXu8I=;
 b=slQi3+vEZJX89oyb0SIIXGngVEUL6QlA5KheK7Au6TPPEKzdCO5gNDb/o5gR8kqK6V
 l54L+ECTjxMK/3G0OSEpgdf9MsY8ZFF6KUYnjaIcbE17oo108C3NWuCmak5lvCpG76IN
 0f2okO12WF65jObO6MPCZDl4tWGRvfwEdIUpnrxEb5uNaVvampFR1gHlTSVkWPZqUINo
 pVzCT8RxO5yqUuamS1KnRpESWNvYeqyd4kUtJue1/4Unv7sQ+KjXH1mT4g9G1an1XWWv
 5j6UikCPWvLigDa2E/CBlwyyiGeoCfsSn6Cz1pt6byL0ycXD+P5zpBaIuiySe6yZB4B9
 H6TA==
X-Gm-Message-State: AOJu0YwGwlL5ridGAvxILeqr6mXU497pS3yKcNYl/NBFM21J5n4noE0P
 +5a/ZHgrcp2CeAs2MLBkoWuT/rPr02U7Iox/c33YogjRG6TtSkrPBPM4TDrdRU/7YqdGUdSK7Tt
 bDYgG8+MHaHrAQqiWdsMUksQ/Ob98kkKXv6Df39Fv7sRkg875B4wgMJ/O
X-Gm-Gg: AeBDieuqCKdjbm6HXDF6KInBOX9BJMS52MzLHhsalsCRoSdrpi5E+aDXKe6t0pjnPSN
 +sEb7Wf2t8tPCm/Z0q2Pc/VR4bZ8yej6P15WZUbDisayMjFj+P0mbammm2Ad3Wikeydch4V6tXB
 MgDgmXxaKKI3tfOmjOou7Bp53TW9BNOrZkgd19GIpbXWPphiT58fDpQu9X4MOnkrd7lbtaEacR9
 dmQyxjpK1Fk+4fiZM7Pk4Oj7w4/QYq4s2M1mZ5ArpMQgvHecBWsWNkjHk2ptAZxTwNvBODg6+9k
 uuIyAc+/yKsJoXf8Y4XwogVbXjiNhGurjFX8cNoFrQhe2aSazUlW3VpFc8I/C6R0zEdrNF8/SSq
 5UiCd9yjw09lZvu2Atwwbrd/qZ4QZYQNO1c9PyDTo2nWh4AdgopQNVAm7XkvAB7AQJIySvurH85
 wRfmTiV9mzl10KAzl80PE9PsOtgTenECfYDBonQfwnLnn2piihN+cnJOklWOwI
X-Received: by 2002:a05:6a00:8510:b0:82f:9e98:136b with SMTP id
 d2e1a72fcca58-82f9e98218amr25978022b3a.19.1777281989619; 
 Mon, 27 Apr 2026 02:26:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:8510:b0:82f:9e98:136b with SMTP id
 d2e1a72fcca58-82f9e98218amr25977990b3a.19.1777281989086; 
 Mon, 27 Apr 2026 02:26:29 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9819fesm31903133b3a.4.2026.04.27.02.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:26:28 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:56:07 +0530
Subject: [PATCH v2 3/7] clk: qcom: sa8775p: Add UFS clock support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-ufs_clk-v2-3-36e10a7c0ef6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777281967; l=4187;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=NjbNyT4G64RajSzfnmoJw7JlyCD8amDeMxakxwyy39s=;
 b=4yf5HP+eTScmwK1FNBBHmIONKcgOQoL8rdSfQEqeXoyROOTt4KOFMf/cAx+vcaNUOt1RjWcCT
 YjZK4fi1EGgCH4cVRfEvGPGOPurriYUjuuc0v5sA7mpAgoF1vKmuR1R
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: FWCZF5EvQMkxdy_VhAf_7tPjJfkxRYgF
X-Proofpoint-ORIG-GUID: FWCZF5EvQMkxdy_VhAf_7tPjJfkxRYgF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEwMCBTYWx0ZWRfX3pP6yLRl6hiX
 3/araOPOl4WG5fIfca/8eewgBUoqoAzcjvAISBXMZKhnTcn1wYtD3iZ7QQZcLeT4xiWE25KFpm3
 6JvJzwp00KjrpWycq7j7PmHkLs3rgtuXdEzJFxdZEjZKEwDSw9A/Q+lkapySNrZOJiGVa3u1rRD
 83hZ7TDACojtSF7gk3rRP0Cw3BrycO/B2q7+oteF1owpzURA6C+CjUNu6ZCfSr3eYs1XnpTqvyM
 XmvH5TX5GeX2XG5p8HwuPADdDZ5UvKzjcHhoCHzDPuw6e+ze5KA3+gzRMQwyX8wl5YmI5Z980z7
 2rpNRxLvloI7lrWR0l10ljMTx01JPkSHtJfJfzC5fKwJqN7mVPPzFYDwfvi6w24ask0vmUXF7Ry
 zQiQ7MWA4lDmaBmy+CLzc44cqO4S3i0KRaBczCVV5qXe4NVmHQm+qV2uqr6IGHk2hUIh8DcNdxf
 EIw2SunZC+WrytzgZTg==
X-Authority-Analysis: v=2.4 cv=FM8rAeos c=1 sm=1 tr=0 ts=69ef2bc6 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=e2EsdUj_rZYBD8UlxuwA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
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

Add UFS clock support for SA8775P including register definitions,
rate configuration, and gate clocks.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- No changes
---
 drivers/clk/qcom/clock-sa8775p.c | 63 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index 4957abf6f58..7eec4aeae48 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -19,6 +19,11 @@
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1b028
 #define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1b06c
 
+#define UFS_PHY_AXI_CLK_CMD_RCGR		0x8302c
+#define UFS_PHY_ICE_CORE_CLK_CMD_RCGR		0x83074
+#define UFS_PHY_PHY_AUX_CLK_CMD_RCGR		0x830a8
+#define UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR	0x8308c
+
 #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
 #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
 #define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
@@ -44,9 +49,35 @@
 
 #define GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT BIT(25)
 
+/* UFS AXI clock frequency table */
+static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
+	{ }
+};
+
+/* UFS ICE CORE clock frequency table */
+static const struct freq_tbl ftbl_gcc_ufs_phy_ice_core_clk_src[] = {
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
+	{ }
+};
+
+/* UFS UNIPRO CORE clock frequency table */
+static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
+	{ }
+};
+
 static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
 
 	if (clk->id < priv->data->num_clks)
 		debug("%s: %s, requested rate=%ld\n", __func__,
@@ -63,6 +94,24 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
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
@@ -106,6 +155,20 @@ static const struct gate_clk sa8775p_clks[] = {
 
 	/* QUP Wrapper 3 clocks */
 	GATE_CLK(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT),
+
+	/* UFS PHY clocks */
+	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x83018, 1),
+	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, 1),
+	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x83020, 1),
+	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, 1),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x83024, 1),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x83028, 1),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x830c0, 1),
+	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x830a4, 1),
+	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x8306c, 1),
+
+	/* EDP reference clock (used by UFS PHY) */
+	GATE_CLK(GCC_EDP_REF_CLKREF_EN, 0x97448, 1),
 };
 
 static int sa8775p_enable(struct clk *clk)

-- 
2.34.1

