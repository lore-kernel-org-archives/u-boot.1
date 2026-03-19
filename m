Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94391075286
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 09:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2CC583FE1;
	Thu, 19 Mar 2026 10:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JUZoXhIv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hu0EHewj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C38D583F00; Thu, 19 Mar 2026 10:38:04 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74FDA83BC8
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 10:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J74QRR1028676
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Mk5iZhS1n/y8PBvHlXmrg7Cvi8L8ewA9smQJwLOLQSY=; b=JUZoXhIvTe/q7jIi
 eNPNMSGPcno1CZTT6h6LevCZKZqjlm3tNhRHEdspql0CBNsd1bVabZPHWN4byNTA
 5cKNqP9Lg6M0zPRRGXaaFCqLUQ7rzLyz632wRpzwlmHNa7xsTRZ6EahZ3xq6Z9wR
 720jmHFhVgwyVecQvoi+GF2WSBoGgcG1FrREoJQYtx8CCTjMVekhO8umUJA1YHb4
 JsQT8912pBCQVH+bmm1QidyszYk4gIb+nOwF6ylMI8SoW7ofjWJuiChxzlxAXA2Y
 lkC7lwKj37QfRvjR0cIPncOPvY0bEk375rCNuk3HX1TAeqSB/U4Mzzd2o86rO47S
 rvw5UA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0032js0w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:37:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b079b4a8c3so50252415ad.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 02:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773913078; x=1774517878; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mk5iZhS1n/y8PBvHlXmrg7Cvi8L8ewA9smQJwLOLQSY=;
 b=Hu0EHewjZedcO+9kw3KJPXImCwPKrEGmT2EtSzmamJL1CGO4tpJu1Q7DkspYBon070
 Ar9N4jv/HXZ8Nics3V8qQYI/RSXDImZ05PLdv5KivV8YGJYvjbVn9eNm03cgM1D1biJH
 ubCU4G16Ow0TkbrAYE+OEJ+oUk/71/tyUX2ZMnnQoqVcTsRE19frxX0tRMB96zKwlkT3
 7tC5HiEHYRd1ZBLRRD3aO3LDcGIXTdT8N5AjzUNQoMEFs+8v6bd7WADyloe+Tme6rT1w
 p6cqI8YimXpGu0nT48J4A6eiQAjYFpC4mIziqhm4JFCQw1eWz4ZTHlAfNZzCgN+6uAF6
 vvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773913078; x=1774517878;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Mk5iZhS1n/y8PBvHlXmrg7Cvi8L8ewA9smQJwLOLQSY=;
 b=rfxnmiD8XWX5K+uG5Vf7ykeN2HETuarzgkNNyI5QjKgiIO2r/qT1KI73KMkpaFssKl
 pZC3kAjixvmnE7qnhv6wnF+iNHWO8gtCtlvbByh66E/MeL1gUpYIL9+P+bVwaV5sLxC/
 vH7T6Lk0cu94na8JJYLXGvg3A7oJpseryBSXD73xpDlElUUp/7tJAmDhBaNAgKE9GD6k
 EopoO7zUQW4lAFfRI49ffQ4IUhmI9oTXXeCVekPiJaEyIHIVsPV7mgw+Vd0j4SPYuEFJ
 mHYg2ylfPstiydaeBQ9v2+yCnMMURT45IlHhPJVP8Iv4f0xCIZ+XFmv5N8sby3aEGFaw
 LDtw==
X-Gm-Message-State: AOJu0YwPE7TuDfHdtsvh1Yazwbxxf8suIWjkgmyl3eaWgyyhJELM1qsi
 CLeWj9UY6iXMlpic0sUbnQVvjHlscg12XWcZaPIHeMJ+zI52rs9b2Kdhbr17RwD1DM+Ppr1XeUW
 6FnyKxn4rfyCQtFtQM85AicXWdLBAl6vmRkCFOt0mliY2dhD85FasoQ0z
X-Gm-Gg: ATEYQzz4hdbok86WI+aeZITPuFFmWF9lcIMXZ+1cLKIV6hXbuQaEJByZvxbLuPB4BCb
 bk64+gR5/o/qeLevCgvzns22q6v/2w+B+3bAGC0zz5SZuSuJojyHewFtC/3bDdqYjFwKRrYel56
 d7ZNFwAAqv8CUKvXDfIdueM3W5adlsls2w5AYsp0Cf4cavngdksquOwGenzbs0NtWlUP9T9l+WL
 zq4B/PbfSO0JrTkx6bfA/wn6DNrGgyNoQFveHMYjnGDMiHEb+Qm/mp6hsjIHao8vpENGiOeXwED
 5yDgvAFuWNpuLFdPrj8nfz1TwoQCsCFaJClhMkwlTFoLr95ueEu+8BE74bUDoVlN5eAWnhMLQcL
 lzXW48+X2OmHXoWGVzX1Nez86S6tbGDI8xMjkaPloR8FQQJXJyz5XlCSyjw8Qik/WDIPUmFZ3BT
 LeS2pzTi2lH44HS2QKrh8tRgmxqyZvr37eMET2UGiyg7TBd15Zkg==
X-Received: by 2002:a17:902:d4ca:b0:2b0:5923:515f with SMTP id
 d9443c01a7336-2b06e3ed605mr65110675ad.35.1773913077696; 
 Thu, 19 Mar 2026 02:37:57 -0700 (PDT)
X-Received: by 2002:a17:902:d4ca:b0:2b0:5923:515f with SMTP id
 d9443c01a7336-2b06e3ed605mr65110305ad.35.1773913077140; 
 Thu, 19 Mar 2026 02:37:57 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e441374sm52098825ad.29.2026.03.19.02.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 02:37:56 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 15:07:39 +0530
Subject: [PATCH 2/5] clk: qcom: sa8775p: Add UFS clock support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-ufs_probe_clk-v1-2-08c085d6b15d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773913061; l=4097;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=j8kkCLmnM5mOUXgx0qkyfvEhUH2JneHpm6lTblnQIMc=;
 b=+5PBXh4QHVRzT6Q3JLqhtt81Ek3EEOvGQkoI/y+oNbrB71BRdlIpILTL/JkIIO5wirdZZwGYF
 lhEfXJpKly4DD7N26FeyRrj43PX/gFM3LWvkX0HEDXZUhr05yPKMNXv
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: MBqIQpRMHzcx_4X6F41l3VU9NhVSq2EF
X-Proofpoint-GUID: MBqIQpRMHzcx_4X6F41l3VU9NhVSq2EF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA3NiBTYWx0ZWRfX6c0utri/ERxO
 dN+hKDOOb3VWiyZ5AxSkGcq1Zc74ffcBPxdRnQIWvJyLPBgKbO4pdk3km1z9ovxaCw0Fto0lf5a
 tcz5G85pXP5p/Quft7ODaNiYZtAB5LtO6Ll9FJytS/Om73eS3dp4Ra4eWykJAKGFHbYjv7ORY1j
 2BNGFN7OL0WjqrLxEo7I1dbayG29uFP4vTZn7OnbLvmaMOIqiPtjEZiHBJTNMZYzEbNQkTL2yzd
 BKiswfoXt1lETU646cQI9cIWHlMmW5/AhJedQBQKiXXmdYjBxBcKeBDEM6KOsOSLtUujC0G/7Ec
 A1iPDdHNfbanaZsPyY9pshNvrB5B+N3hswZp5CMj1Zl/CJobTIvUN94EMH64+r5r3sc92Hhrh68
 y3J8/sNDatdkw1EbVDttHJBuZ2XKiqexTLXHmEkRRbxFFfTlxkhVfw6d81ABJ1uUbbo+IeAQZKS
 YnFaVXkgeZHURq7o0uA==
X-Authority-Analysis: v=2.4 cv=WO9yn3sR c=1 sm=1 tr=0 ts=69bbc3f6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=oRI4zqn8YJRHaAlGja8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
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

Add UFS clock support for SA8775P including register definitions,
rate configuration, and gate clocks.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
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

