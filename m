Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36274F532DD
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 05:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 353A58063E;
	Tue, 24 Mar 2026 06:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KIEzlxuf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OAobTc8a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D5DE805D7; Tue, 24 Mar 2026 06:52:53 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2F83838FA
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 06:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O4JZM4943509
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 05:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JZSHdeTHZz3a7En4Wa3AizJNJHu6ex6julfPGXojFvg=; b=KIEzlxufaOi9bzFo
 mEQX/KMa46TdqCnfDoGMRuXxwb1y5u/jvXdtHRyY5xr2KPT/1uEUoaxH+NLUqWBh
 pYqrfFn2e4lt+K2GU+nxq9dwMe5o2qKOeESCuvxKfRIp/dOGE1Mul3Zcp2I0FwqG
 XBKln5MKwpQcW8Qh0DG568ipcqfTO7Hn/SzyhhPp6jlkzdwV9GBiUibkv+luMl+H
 pg7BSLRXtgUXNo/n5/ADjmxyXTWqFTk3eT6Zjr7IsKXDJFajr+aqE5XJlMvvmU5Y
 8lBNh0LZjVVIzvCVifu6CgNSEVcggoiSiSKZSlyhnO3xVwddtCO45WaHNUglttic
 76uzvg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34vkudwf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 05:52:49 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-829b8bb5211so13691021b3a.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 22:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774331568; x=1774936368; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JZSHdeTHZz3a7En4Wa3AizJNJHu6ex6julfPGXojFvg=;
 b=OAobTc8a6wz8UVEiMRNWJezqlIxQTcS6RCBi/CKprptEMYj5HTeSiU6ueJUyORoUHN
 NN2avo46x4fHlkJgQ4HgPh0CHzKVZdLNSEmOjs57pTyLElIhm6OABkujC/PPkhXhgeCD
 3Ok3hAkyOe1MwFlboX5GL5S8qnYnaqKp+DGK6xpN5n6p8jaYsGp6VmvfMjr8RDF8p94w
 mjgk0cahmckp3o51WNE8ebROfYJxPk61lwB45zK+FtTLcPH+MQ1tA/uT/ymyosP3eYWV
 CNuIZngqFUiGItJebjeVAagndXZLXtvrqU5mjdV3e8RCp8uRSpSNOheWvmBib2itUXbt
 cy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774331568; x=1774936368;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JZSHdeTHZz3a7En4Wa3AizJNJHu6ex6julfPGXojFvg=;
 b=SN4w632xcBH88Q0HRwy5uoipCQFWbnxfKRg9JEMUGq9ZjJrtgvp95YyX2js0q2Sgxl
 DQX7sjF17Lvd8/8q2OlWIhjFskxCOSIes2kg0rSRn1OVLm6aGNB8ouKqlDjYrs6GxOnm
 uNPDaoZ8mQfIJ8Cy/VaORQRWv8ATJ44Z8tPJukjdn+zQtnqunRsVmnr61Cpr5PjcFJb6
 NqkiWxASo6x2PQS420+Ul2SkIydJrOBhzIZ7Ta5+4VFaDwLYCgU2kDd+7YwS4sy9qyb+
 Xtjsg1GZUQNUceMnxl4dENSiCq4zS/8JiOfqAqGWSOh0u5kcE0G2zNwOeDGsHoL+w+5L
 CxqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZSxYycK9KkvW4MyPtFyZlfcvlu2n09PubvOVKY9beqFmZjLTsXFpHZYPQnncZFyDhshTopxs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8dRwAENqxyT3ryW8yUBG1qZ5vU7MNIjUWrFgV9x6nYLnOvCTh
 QyY/ML6H7JtTFBBMHFX5fojMBUlbMNxLk4sYwhtGMmgRsQn+EbWneBOlL2gP9GjqIYYNpZuvcLO
 ++wx+E4ChSkEFmx5m38Lj8yYMwVXxj3Kt94I9rl5I3PHy8/wUD5rCVkNr
X-Gm-Gg: ATEYQzyPcU3YAMluSS+IfFWJlG0jTt7nrPNQP4JWHMvLTQheyhBqbX1PZSv0n6WShA2
 hmCk7LvIDqOEH7+3QEfhDcETk16KxxUQF1bEJD4yrf2ohClDFdrjCy9uJHeQZofF34m5wLaA1eX
 5CoOBuud6w5pvMwxGZX1nmY/7jgH+G0gFT98/OMcGmmtQh18Z7Iu5e5HmVDtv1hiDvB/j2zeFp+
 nCQC2POGEB+32lm5RjkKsbckYl6vWL5zkMD/CZL0AlhmFovFYojr1cunW1f3ym5e5Dh5wI8Quj+
 8hao9wqYRMCPGka7tXCqUVs8RpHOfk2MuKXgVGxBO3zsVRrb6XcsbEIUnu5D2LirdPUUj84cbCs
 rnZtwYF6r72BmXD8iMirtpm3TQLi5Jbxd3JUFDZOpfV+feBgU4rnr3ZCW6xzJysLlm0noRMJdIO
 shLqLiJb2SocJPhm8VyMVJnXv35dlKkEnYuHaxhEMR23fgsPdEzg==
X-Received: by 2002:a05:6a00:10c9:b0:81b:1a87:9eb9 with SMTP id
 d2e1a72fcca58-82a8c28c9demr11855250b3a.25.1774331568369; 
 Mon, 23 Mar 2026 22:52:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:10c9:b0:81b:1a87:9eb9 with SMTP id
 d2e1a72fcca58-82a8c28c9demr11855235b3a.25.1774331567818; 
 Mon, 23 Mar 2026 22:52:47 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c212ac8a2sm12874783b3a.17.2026.03.23.22.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 22:52:47 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 11:22:34 +0530
Subject: [PATCH 1/3] clk: qcom: qcs615: Add SDCC1 and SDCC2 clock support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-emmc_sd-v1-1-883a45538b6e@oss.qualcomm.com>
References: <20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com>
In-Reply-To: <20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Simon Glass <sjg@chromium.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774331557; l=4022;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=hiQ4IUn6aDfPG0gnOmEzs2HCCnGj5L0okQfcBrICdEg=;
 b=w1KIXtV6WRyW3B8hp1HKrR1rlO4rOSvZXZ/iI7lQOVQwYFLPoRWLe48DpLXYZXkw09HGNwLCb
 fNMDmjT1O9eAYXEJy9CAAlPCnUQw4izhcyKLBdHay8820CRKzqTQtwc
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA0NiBTYWx0ZWRfXwXg1nS5w9ozn
 85j8GIzkU4VwjyDP27yjVgU7Wa93S0RzK50wDs0k+rrlwk1t+D4OhBwneS3zU69yjn1C+uIDNAc
 6FKLvbCJWsBtFo9+l7k50GAn0x1vMpinFfjYhKDQtm5zL8/FYb1QRpL9lX4Lu72Od01Zf3T1DRU
 wtH3TOHEHmAyybM/JCwly44QsHV56GbdmSR/QJVpV70BuehcThG7QM8Y+pWR59lXh9DSKDXvFlN
 Zw29SXWyEYng8azmnopl41l8MzGAPmLCQtaBqgN+UckyzAWzha7G7dDu/UgzrpXI/bV9AtT/iRQ
 1RsL/fagjcWuiHIkwHUewcwgjiUtZmHx82rwnNGLSzDX3LXq6KVJ8krGTrxSwaQm5c075HDmRvs
 n9vAa4Uo7c2N02jxBJRnOsWwxcruthEopsW3RpWfn+Ar2A+lPj75HEUnnDBlg30/shKae6LmLAd
 217uHiG86YDolFV5pgw==
X-Authority-Analysis: v=2.4 cv=eMoeTXp1 c=1 sm=1 tr=0 ts=69c226b1 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=_2zeb9R0JovByABKeEEA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: rjzobFKQGrG_gl4axY3_Y5nBnVONw2bH
X-Proofpoint-ORIG-GUID: rjzobFKQGrG_gl4axY3_Y5nBnVONw2bH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240046
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

Add clock support for SDCC1 (eMMC) and SDCC2 (SD card) controllers
on QCS615 platform. This enables proper clock configuration for both
storage interfaces.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcom.h   |  2 ++
 drivers/clk/qcom/clock-qcs615.c | 46 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 3a4550d8536..9899cd28aad 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -14,6 +14,8 @@
 #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
 #define CFG_CLK_SRC_GPLL2 (2 << 8)
 #define CFG_CLK_SRC_GPLL2_MAIN (2 << 8)
+#define CFG_CLK_SRC_GPLL6_OUT_MAIN (2 << 8)
+#define CFG_CLK_SRC_GPLL8 (2 << 8)
 #define CFG_CLK_SRC_GPLL9 (2 << 8)
 #define CFG_CLK_SRC_GPLL0_ODD (3 << 8)
 #define CFG_CLK_SRC_GPLL6 (4 << 8)
diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
index 4700baba8c9..cea7e7f43f3 100644
--- a/drivers/clk/qcom/clock-qcs615.c
+++ b/drivers/clk/qcom/clock-qcs615.c
@@ -19,6 +19,34 @@
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0xf01c
 #define USB3_PRIM_PHY_AUX_CMD_RCGR		0xf060
 
+#define SDCC1_APPS_CLK_CMD_RCGR			0x12028
+#define SDCC2_APPS_CLK_CMD_RCGR			0x1400c
+
+/*
+ * Frequency tables for SDCC clocks
+ */
+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(20000000, CFG_CLK_SRC_GPLL0_AUX2, 5, 1, 3),
+	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 1, 2),
+	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(192000000, CFG_CLK_SRC_GPLL6_OUT_MAIN, 2, 0, 0),
+	F(384000000, CFG_CLK_SRC_GPLL6_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(202000000, CFG_CLK_SRC_GPLL8, 2, 0, 0),
+	{ }
+};
+
 #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
 #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
 #define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
@@ -36,6 +64,7 @@
 static ulong qcs615_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
 
 	if (clk->id < priv->data->num_clks)
 		debug("%s: %s, requested rate=%ld\n", __func__,
@@ -52,6 +81,16 @@ static ulong qcs615_set_rate(struct clk *clk, ulong rate)
 				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
 		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
 		return rate;
+	case GCC_SDCC1_APPS_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_SDCC2_APPS_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC2_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
 	default:
 		return 0;
 	}
@@ -79,7 +118,12 @@ static const struct gate_clk qcs615_clks[] = {
 	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK, 0x5200c, GCC_QUPV3_WRAP1_S4_CLK_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK, 0x5200c, GCC_QUPV3_WRAP1_S5_CLK_ENA_BIT),
 	GATE_CLK(GCC_DISP_HF_AXI_CLK, 0xb038, BIT(0)),
-	GATE_CLK(GCC_DISP_AHB_CLK, 0xb032, BIT(0))
+	GATE_CLK(GCC_DISP_AHB_CLK, 0xb032, BIT(0)),
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x12008, BIT(0)),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x12004, BIT(0)),
+	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK, 0x1200c, BIT(0)),
+	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, BIT(0)),
+	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, BIT(0))
 };
 
 static int qcs615_enable(struct clk *clk)

-- 
2.34.1

