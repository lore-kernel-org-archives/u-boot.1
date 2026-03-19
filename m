Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9515B1075289
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 09:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7614783FDE;
	Thu, 19 Mar 2026 10:38:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="orEbOZjF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CFl9zXl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 499F183BC8; Thu, 19 Mar 2026 10:38:13 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B3BE83FDE
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 10:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J74HE23369997
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hBev++fbyl4QADdxo4Dh0Vz2S4z+nIFJCjVwfyv1abI=; b=orEbOZjFnyUhgDLM
 Dx78/XzHjF8EnU6TMLPIuS1BG/Rv4POqx05bScTJwuFyKmoH14wfWVGekeHyKdrA
 GU13It1DUA7A0/p8ah6QZ/LUDGoHWeJM+7RIAlPAFBivktLPef/qxzahvsV43s/5
 gWmhx4nHWI4plLkjI3ZlX/uPKFjtWfZnRtvMq0fI6bIlUHybVssEPk2gIq912BJX
 TKjPpJCZpArOjyI4jj5yZzRTAxj/9Sv8PkYa0fGexgCXBJWI66UJG6s3XOAZp6rH
 RJjF4us2duLALia/R0UUkRrCdkOTBY84s/pG+J9FecIm3e+WnG/jhqIIeErsnNlm
 vVX8sw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d00f9jn1k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:38:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b05d170cadso16891765ad.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 02:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773913088; x=1774517888; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hBev++fbyl4QADdxo4Dh0Vz2S4z+nIFJCjVwfyv1abI=;
 b=CFl9zXl2NvrX/mLiWxiBjp6g3PdrVUuiviq33kNCSkwq+/Q6OzI1caFMtyPM+tAq+p
 Fdm3ZZX0hlL4Yf6z0w6BtVXH5lS0OxR3HiTIuhS9VhXs+SqPFUjO8964wW2mK7QCuf4i
 a86cJ02YABDxrA6b5vzllKAn3AXogz6iOkD9695szEj9aImFT3IxgyOYP9zuBPHyWzAS
 QqnYzVpNXy02f5cHmhE+DEfj8qcDKo7iKKSH6ByNVdD4ix+bi3iC95xRJ76dIB5gdy+o
 GqtOJUCX4VfHFfYoNkj5uFHKs4+pVXOZ/MCMmiKOQhG0r9ZjPyDKWLDM5WbBZ8CL5JCJ
 OpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773913088; x=1774517888;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hBev++fbyl4QADdxo4Dh0Vz2S4z+nIFJCjVwfyv1abI=;
 b=SCYijJt4nDtE0XrO9ZyVO2IWOG/UDuAq/rhQ00Yxbh9uZkcZoHxgaw+meHP+svKDRx
 gozYqS/o+YybYY1+XgJuWPttlJwXVwiUdIZG7AbiI9sd+cuTlny+XG9B00j5Vfgxmvmt
 NMg1+9cKaF+D+g8dTdTfJxR9dPTBNUeqITI+PPer1JwsPfMFp8hxzNd6xygu2v43kCpC
 UQWDlJ+uC/x9GSV8k6dl2VS60zf3fdJ1wY6BpyfKgCWcePuhMLr2GlsSt2wUi1VxFUqq
 VXggZYclpvJ6NfEjHJZ3KxARwYaSe2JM/Y7Y1vlaRGCONgcbitux9vmkXj7nDpcEB0oM
 ZV0g==
X-Gm-Message-State: AOJu0YwRxcTsMHQSn6pqxgRUVoU3kGO1I+1tv2smU7hn8RaPpaRF1AGv
 kVEXUSoXd8ob5GfrC0eLigBfxFtqn41aWfJXEloAJJQj4Cgrfsgpw36cTyIQPVLae3+bqYEGvQc
 DMaCkNZ75C15ScP8qlEbCddDekpsXyI9ECogpthvRCYJf+pKqegmYzoMp
X-Gm-Gg: ATEYQzwFKrahESg+jsdkh1h4XBP2aKIrh9rWKqzSbZCzw3gHqNUj2xnmMqxqai6o9eZ
 cdNddDvxXxKes1y9xwOl2Wly+RzqTdhaxrV1pwVwyC3LpaWaHDQknrfVQtHBy38sQThvwb1CEhL
 QzEy0rwKU7KsAuD1p1jCFV9A33cX3bb8SF8pXhkA78z7nDaukAuR7j275dXGAYEgVF+gZIGxipW
 Y+YypxeeiA4bGDlj0iq8Z9K7ZGEh50G6OivHMAuSHCsGLYFMeQw9w/vGhe17u+qhWBqdBSARJzf
 CEzcIJ5e6VaONhUYIau+o/2ya8IQ3nT522mOb4HL0MVJWwuteKW1RiSRCy+08SVSkLRL6ZFeQJ7
 U9crxmHAJlI3HvZEnkdusvBDnIL2aAr7LnL6yjniJELFlTL1t7/zSQlSyXOBHgaw0jAGLPxNmUr
 Q9VWdE/VzEjQTWmWLODQ2ejdWgLK47GQTXHEItzBGs/IoFGTrfNw==
X-Received: by 2002:a17:903:984:b0:2ae:5e75:3821 with SMTP id
 d9443c01a7336-2b06e32be1dmr62780905ad.18.1773913088373; 
 Thu, 19 Mar 2026 02:38:08 -0700 (PDT)
X-Received: by 2002:a17:903:984:b0:2ae:5e75:3821 with SMTP id
 d9443c01a7336-2b06e32be1dmr62780755ad.18.1773913087859; 
 Thu, 19 Mar 2026 02:38:07 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e441374sm52098825ad.29.2026.03.19.02.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 02:38:07 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 15:07:41 +0530
Subject: [PATCH 4/5] clk: qcom: sc7280: Add UFS clock support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-ufs_probe_clk-v1-4-08c085d6b15d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773913061; l=3788;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=ME1E2apw089MKHnpuwuntfSkatQhRv5WY8AL2SrYswk=;
 b=F7d6LIwyv36pT7dhWYpqs6a/7QFIHksFHE2i21JzNgfCf+4+sjlj47INEOyqeIu4j0EwgleZI
 SbF6V5X6nAHBcIQLx+I8UZ9GqfnHzkM+iQTJ9yfE+f8fGoFkyspJh+b
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA3NiBTYWx0ZWRfX18iPJCClwq0H
 2uH3sJv2FHAvaQAIgepfZEu9U9okm4qCI7QVflOrqco9aVIOfdIREp1qLIeW+IYq9WHsdkeYe41
 CR3UMBWdJVewUsVm7fJtYz9mKLITD2O7B+xUz3bTv5KYA6w46qklTvr8JWB0X9TklHHh/qreyIP
 wnkuxBx8NPHbJQmqTEfeyVWOCALL/Au4m8erEUrPXxtHFApnY/BFwrZACOp9zRUWDnQROj7brbm
 +nT/Q1qic7XdVdzeoH4L/LW9x07ZMt8PSeVuglXxh/1an0XVASIKSG6GnHQ/aEJwXnk5ETHjJGn
 ceK3zsBu1eKPLF5v2X1TI5Qia/pUHfIdE7VIe5PwMLYkVgRdl9dzYdJTOIFlGtvG06uiFgyGKUR
 s5Ro9381R3LlzVSOogiMxeUNS3RBd2SYYBOmoS4KLHe2lov7dzIS15f28aSjwgmsK16MbpW9WEu
 JRbGi/LxyrFuvY0hVLw==
X-Proofpoint-GUID: oUvoyN4rDsygHOc7jDidn1OcSJghAM0k
X-Proofpoint-ORIG-GUID: oUvoyN4rDsygHOc7jDidn1OcSJghAM0k
X-Authority-Analysis: v=2.4 cv=MJttWcZl c=1 sm=1 tr=0 ts=69bbc401 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=lctD2BjJw215xePkaksA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190076
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

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
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

