Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8671075289
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 09:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA9983F00;
	Thu, 19 Mar 2026 10:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZKLZyagD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e3uTlLbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9722583FED; Thu, 19 Mar 2026 10:38:08 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A102D83FDB
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 10:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J742t51027199
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mCCzqzKBAxYLIDeDEgqh0xmS0Qts8gDosxTbonnKd9s=; b=ZKLZyagDY8Z8k6dO
 zbsolYSvb1XFIL4dOiM85lZxwfIFpDizi2uIhWlIokLafbieFbOWXkyg+2NkLeZT
 CFpiy5RH9ZvF316ZLLirocxyQ4gPzHaOkpYnQJbdDVMlgwkEfh/ddrFCn/64ElPH
 QEjjMrA6SDx/EHV3D1C7VObl3ZojkK9FrfwTur8CHPrEUS5TbWK8HLZ7b7IUTy2C
 IxG4ETAfUqDCaf1Pjiv1cQq2TPizQo+nNBNmQK6e4LMSSxibogY4IuozzrT//0CJ
 7YpLmWxA5QMfaCMpVu+Ya4fV7FYxlN9ZfCm1lVR4I6AboU13xCAOKvZtQRasvnXW
 qXqcZw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0032js17-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:38:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aec07e8aafso5877105ad.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 02:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773913083; x=1774517883; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mCCzqzKBAxYLIDeDEgqh0xmS0Qts8gDosxTbonnKd9s=;
 b=e3uTlLbw0grPTFHCCNKzzWzS7fVbcPMX9myWrw+EkgIM0HTpHOMKGBzS+omaFGKv0S
 hHSMK1MfB2JzypwieGVLJ7Y7zDWVHf/E1Pd55CsgPIQxpbpo7J+qd4qyCqBwI4TpK6u2
 3Mv92ehOWDa2w76j1lW9aliVHyFHOnGXZjdA0yPF+WdmOP4L+yqyYLJnSu3B5A66aHWc
 l/RJnGU9DlIfEnOO5x4FXeYWzEp4jUDrr5N8bsyaScsw7vq//o0yn8pQd7k/HIW8YDyG
 z9/FCusBSYBI2VBKDBWq8ECDbvL2uqsgFHo8Zrm79rfRrAOeODqxU9cSbuppj+8NLAw2
 4d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773913083; x=1774517883;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mCCzqzKBAxYLIDeDEgqh0xmS0Qts8gDosxTbonnKd9s=;
 b=WVUT+sLrMPYID4gv1sFCW49firv3Q3Oykv2IGCLeqX4IY1XqLs6UsZiXPUnY821lEX
 qDXZErR5qQ0keJRYZujJ3aE9q/CUSL+CJafkSx7bGVRjE29CZdlgNR2jQOw+EqdPYuBm
 mx+kRKJANQn+gBFin40My01JOEx90v3hM9H+RejFaK61dB7T+dEfsIqQ6ieIDz4NkQv7
 IPuafpeAfi3/I72V/O+V3Ah+YOVoq1eBeXDwE0DF92Vf2X4PooCLLmCFppXXntCqFPq0
 muanzb6Hp2d6AdSEWS1r+C2YtCX8CyvS/9U/v3mWXvmrRudPl1gpnZYs1rWEv1uq7Km4
 hWKQ==
X-Gm-Message-State: AOJu0YzAqyvBRCkEzmX0ki11ebMcPYG9E35vmwa+vCbyA/W7Nw8652Cr
 449aQtcSiZUw3uJOX4TMkIRdRXCH7QjFr+BYy5QTzTTR/5VzjXLvj5y916eOR0zVZyzyioVkzhb
 MmL+L1saDXDGPSGYVhDkPMKWw+6G10nNGkgext3BsQJ7qOZoHgQq9j+Rv
X-Gm-Gg: ATEYQzyeUfDI1VVB7HcW/qTfoUf91VOKrwg3bTChy9sJLShAq5LWUlQAF4PxAfnWfRk
 29m+wLcrJp+kxCa5IPmUXNBJmA4xHrZwDMrbAvwwfXuSsrCcNy4T1aNyb/UJoweDPuVkyYREtSW
 u+IcJR3s4KrDfL7JCozS1PdrdixIUjkTWmjJBTCZyE/gft4CMgST88wmi0Cy+uRtQfHXb6MZwJI
 fwidOnEw+0ldtn2cw1N31mfO6nLyIhpYoaFQOtGlSuF9jSgL7sPoTnBqE8mvYdfAHgdm2GARD1c
 YKjphl8SSwMUDBElL6JZhO+Q2dVkn5pIR/Km0vApYt+wClge6G1jgYXAWBfifGb1L46OMUcrHC9
 HwHiO39qvaPWihttP6wgIBChDbA6Hv8A4+mM0bX4hr9UNm7Uu+1ddugo7ArNPdzPRtXE5lVDx0W
 xlqG/k9+mU5BkeLfhFF+/P48WAoyHA4Vnhace5ZWYf0WUu2bhM0Q==
X-Received: by 2002:a17:902:e752:b0:2b0:6885:f1d4 with SMTP id
 d9443c01a7336-2b06e402a26mr70267775ad.39.1773913083029; 
 Thu, 19 Mar 2026 02:38:03 -0700 (PDT)
X-Received: by 2002:a17:902:e752:b0:2b0:6885:f1d4 with SMTP id
 d9443c01a7336-2b06e402a26mr70267365ad.39.1773913082519; 
 Thu, 19 Mar 2026 02:38:02 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e441374sm52098825ad.29.2026.03.19.02.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 02:38:02 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 15:07:40 +0530
Subject: [PATCH 3/5] clk: qcom: qcs615: Add UFS clock support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-ufs_probe_clk-v1-3-08c085d6b15d@oss.qualcomm.com>
References: <20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com>
In-Reply-To: <20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773913061; l=4376;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=3yMdIArcRrz729wc8i1yA1WEoCULzkjpZmzZ/VfSdDs=;
 b=T16oGmBEEq63bu5qcx43B5vdpdYdSaL/7fRCZxU+cUsLvAEgrHZ6my5n7tT+8Ef6wBqNKN9Ax
 wCAGjFkasaOD05yncohQhB6PgIg2d53pJIflddRxBC5e2zBQiyK+g4z
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: 9gSFV1RIYXxx4M_tEtHfOMwDPHPFTQ5B
X-Proofpoint-GUID: 9gSFV1RIYXxx4M_tEtHfOMwDPHPFTQ5B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA3NiBTYWx0ZWRfX3IN3+ouAPEYr
 w67pUdi1ApVCliX7dw8uRj/ta+8ea/ikaVqIPH7Q4TrqP5sPa5XnfMKiP1hwyGDat/cLhhvTNKU
 PTRx4cG7JSA/uKshflFiy6B6xWo+ojYmldPi9AarTIqrIhxhGDaCEzuTdD++XIMrjjTKY/pY3xV
 wQpUIwQv1W1EVb+uH5vKINO370L3A6rDQUjlBoJ5E6otZ/OKGKegxxZnIQgefOkdyfyapqexJ5E
 8r3jqqGy7106ud26RBuJXaEDM4UwgwhRFjfWGD+bAfzOaZp17lSuHXuDCbnJ7OnO/R9F3ABbYT8
 sgzWXaH8mJrNuQ9JNYgyE23sU+SzsVmuCj2ksj4yx42qAgAcxDmhBOgz9a3/zcl6wC4jy8K1A7l
 VFyAYuU9gYPHuRzlcwCeXE/YLRtM7vTlpO6lPwRnXULSu+78HDSl+Ur0dEnFnGLbws0ssDtNjY0
 5kvbfoveFTKx6DXdr1A==
X-Authority-Analysis: v=2.4 cv=WO9yn3sR c=1 sm=1 tr=0 ts=69bbc3fc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=4zqVPMvxyRdUz9D30doA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190076
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

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcs615.c | 63 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
index 4700baba8c9..cd097a3cf36 100644
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
@@ -79,7 +130,17 @@ static const struct gate_clk qcs615_clks[] = {
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

