Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA05AC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 04:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7164C60671;
	Thu, 20 Aug 2026 04:29:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Krh9Sla8g9e; Thu, 20 Aug 2026 04:29:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787200198;
	bh=bLtxwHHwGQTH3Mjwb5G08zSJ7EoeOkgpKm+T9H7QLNU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=drop/ptc+vxGtwcMENXJqrZkGBqx5onayne7ekBu0eDe4zYDmcE7oJiCmWSox+ZiC
	 hyplvP7Xbv8JeCDAdE7wwXWpDpsFg+DhlqIqA+5rvKcq/VdF2koH7Rth6IFuCOgbvR
	 nwXzXjkBEqhoDl+JHSW2v7o+N9u/IjvEN/xnJQ+6rfiwkT/jJlBXynSjYwgjIKHD2g
	 rdavj0+sAxKe81oovjMyQaGVOH8LkFyUWRXwxy6o/XTZzMurbl+9aY1I7d7fWKT6Io
	 TaWzF5YM0nL8xSpGY10+6pTU6EoK7HH3AQuHRxN8v+4s0e8mC5yj0xsd//np0L7UBG
	 TZ6q5CPWsfT1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C212B6060E;
	Thu, 20 Aug 2026 04:29:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4662E1B8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 04:29:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37DED40578
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 04:29:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hb4Eq_JkRUwt for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 04:29:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=H2E8IqKC; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HziiVxEJ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 573AF40571
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 04:29:55 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JL7p1k2492110
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 04:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=bLtxwHHwGQTH3Mjwb5G08z
 SJ7EoeOkgpKm+T9H7QLNU=; b=H2E8IqKCfoIkQwn1W/Qnl9NnDnVS+WsoQjWnDI
 tdE4/61ExSMnngyAeafoc/c5ornkxknMWbSFi65annqu8NjseUqQn543CSoJjPf2
 q0JRTXJ+c8o6+ZRf7ayN1DaGRFpaVDp6ZPHVX3Cj+9YF66DTZinbtOBqNzFIn/0p
 KwcogjiVOdQXAqQjUxf2/o5nUSb9D2tWgJs3fJ9C43k7/i26UZT6S7bkBbGvQjAO
 wkJlaYZyx9WxntGGWiDHhsUv//i4nZNNcYciwZCfLmC3YAyXNJ4zz9Kn9FdoAFG+
 V5E7ECwmmjghscZaCgUnn82c7NotxLZ2GsMfZyEY8My55zWg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5e83ua47-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 04:29:55 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso1285987a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 21:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787200195; x=1787804995;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bLtxwHHwGQTH3Mjwb5G08zSJ7EoeOkgpKm+T9H7QLNU=;
 b=HziiVxEJ9EzC7hyaKf5VB541FRpB/ifjRr2fahk2FCR6dWOhC1NfyJ1XCamRmFWfNy
 vXUBYDI68oPSXPR4XfwNfOk0Uxs5xrmPTt31fXjbJDBiQ8nBjxOpu5xoWlsHg5v7KFO0
 173Uuz+ZvxOUHNmaZuFOy1o3tfzHMjunTuyssbUsMjbNMac8q6Pz/SbtN2BRZ8tzE4U/
 L95pLW+7SogCHcJ8RNDg8qGV4uvP+xMD+Za3m/pmHdpm07q8/c2U22mbhYfYkYdWE3DR
 xbDA8G4XqZgruZIJ5EX0Tln2mmoivu3CRmcNPOOpGk/+v0mCpmzm3Mcvf98lR6NNBJaK
 1Jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787200195; x=1787804995;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bLtxwHHwGQTH3Mjwb5G08zSJ7EoeOkgpKm+T9H7QLNU=;
 b=oOL87zRU2In2orlTcU4xEuxrdvKNhyDluBqq2SiTTwY8KB/enbHf4QvFfb/+4viFrX
 xbJT7jNZgscRj3nUN+e2BNUA+So/Cpa4wEJQvqjK5UKEgi6ta0LLBkFTXRolMtwxnidt
 cG7odg7HGbXQgm/bZzrI6nqI3QJ6qOzr6ewHfEtSP9PgbWp+uDVbyEvHIwixjVlIZnyS
 JU8li3G/7naHNhz5J6a35iKqqh6j9FeZp9kuMPQF5Iuncn4kL1J4EtinqYN5wukDfXeU
 2USRcxNp4tE84Ickv/lY0CW7JlmpdJ4NVya2+qt7gg1KEuFOB3dHHdJ8U3idMiGBlHuz
 8o9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXMh6zjGSw7zFpG6ymgewGCUeVA3AxuwoE4nhAlfFqekY80asL8Ee0HRdS9+DBGnJTfVwK8c0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxeucXiebUQUvP4677M5o+ZrutH7vO4kA+ep2rjgl5maqgWt4JG
 5xjugnIraNUC+SZi6jIfkLuIFmzj8HGyOwhG70xuc5ie8G0tuv2MrXipwZeEWur4oUd5w4m/8UT
 Cu0zhGNdsu68lK7Oc2RkCma7alFiL8Jca8RbnJF3mKU2v6QL8qWWLmyiKBsqIhQ5MvjTMCk3PLo
 eg3ao=
X-Gm-Gg: AR+sD11Vm9dkH7OQ8EU9T3SL+7jWmP0FRWWE6wmSUmjN4c1+15Axbp+4BLS/wAAmg/A
 ZXUAuUT8DCxhYoKlzBhpVIalhRx4ncOZJ2LQMjYeDez539Qh4BNNjMVtgbL23fMm50tbUjo/nRd
 HLmCZU/3LKMLC+CtcZytrzw28SyZfPEXFWgEcfj61aj44QKSYETG+6QZvHSFBJU0daGw0kcFSl0
 fwWW2YU8gly5xOz8+xOBBH6QzDW2wHFZMKTtCzd8AFbXq3TNJMCgp2gY4TekcbPAsd/MuKwWMcX
 zDSHPL42YDdZ8ZAY1iio3+BJahYriB6DhWs5xDukvMK2+yB5tBjTeXJsruoMWR/BXATXtIrbneI
 PQZRX6yAaNfJ3R/LernH4Q5qMo4L+8HlPACKWBz76JVdfQ/I2tYv0uhzg2n+u5V0WmZnTbUnsVA
 XQUtRKF9W+3JGbGPUYIbmzjwZRagKd
X-Received: by 2002:a05:6a21:998a:b0:3c3:6928:8b25 with SMTP id
 adf61e73a8af0-3cd0127c279mr16522226637.17.1787200194603; 
 Wed, 19 Aug 2026 21:29:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:998a:b0:3c3:6928:8b25 with SMTP id
 adf61e73a8af0-3cd0127c279mr16522148637.17.1787200194109; 
 Wed, 19 Aug 2026 21:29:54 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ae48761sm11091614c88.12.2026.08.19.21.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 21:29:53 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 09:59:49 +0530
Subject: [PATCH] clk: qcom: sc7280: add SDCC2 apps clock support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-sc7280-sdcc2-clk-v1-1-ef3227e4e49b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALyChmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0NL3eJkcyMLA93ilORkI93knGxdgySLNENjS1MDizRzJaC2gqLUtMw
 KsJHRsbW1AFFc60xiAAAA
X-Change-ID: 20260819-sc7280-sdcc2-clk-0b8f139508f7
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ajit Singh <blfizzyy@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787200190; l=2703;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=YPD0VIM9tOfrigyzgLXNZmYoS8XrRotEXeYIsxsIa1Y=;
 b=CUkdEMqE7isH2I5nu+dFFIOEjgUfye5hZ6fqOenAsg2Qg4k7iuyhogsxpAaJbfN9TNUpYpM+T
 6IuMND3g/BfCrY6mkIuY/eUAkecQX8muBRamN1kP7qid9X/HQlfObgV
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAyOSBTYWx0ZWRfX7HzZhFsFnN1M
 IULjQfAU+wdpcqL4lcONu7yxUmfmwUygsfBIOYX63E+VlHpQ21JT50v2HMdc2Jo/x+2jbd27G5X
 5AfljVBqg69tlp+u2yNhNKzIV0gQRVo=
X-Proofpoint-GUID: isThYCI3W50jQLehVgz7Jst_UzjHCSKB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAyOSBTYWx0ZWRfX78OQHsBrEiGS
 N7UR1Ed9D9EpspJNduZfoVmq+mLwqRvsfDdQRWX/LseYr1Qu7fjQTlvGEorTXl0QjYgGd/6sB+z
 8CqstYSLIDDgtXprih6ykwmot3I0ns4OTw1W6k+/ybiEw8EWTIozjjXUTERT3WXjbPNeSQYcDWL
 uPkGuufrgnkAEYYC/f3dRwgD9i4U9Cim5kGXaQj7X/uXGjEv01VVRNTiFyupNU+/kRzd3l18Qwf
 D7ne5o0sC9nGvMQYaJvXlYbLDZZMQofC1cYyGDMJCPG/rrQyQebZfD1SLPhWkJ0mF9D5iwep83c
 vodRB9NS+YJpTttDLr6duhafXy/H6tlI0TotXQGWcDYkeP4UoxaLMHPxy0UVx76Dymov9qTKygB
 3bm05Zns3qbhSKYLoWKxS7UMBFji/lckASpQS8HB1pKVOjqfBXy4rvEQSRd64jdSVVHg2udcVAe
 BQ7nzu4UJOLcdnZMqgw==
X-Authority-Analysis: v=2.4 cv=cvmrVV4i c=1 sm=1 tr=0 ts=6a8682c3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ZqYSpsCgWxaAGRear48A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: isThYCI3W50jQLehVgz7Jst_UzjHCSKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200029
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add the SDCC2 apps clock used by the external SD card port on sc7280.
The frequency table covers the standard SD rates up to 202 MHz.

The 202 MHz rate sources from GPLL9, which the earlier boot stages
leave disabled. Vote GPLL9 on before programming the RCG whenever the
selected frequency uses it, reusing clk_enable_gpll0() with a GPLL9
vote descriptor.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-sc7280.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 91e3fcc27cb..8005946d713 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -27,6 +27,10 @@
 #define UFS_PHY_ICE_CORE_CLK_CMD_RCGR 0x7706c
 #define UFS_PHY_PHY_AUX_CLK_CMD_RCGR 0x770a0
 #define UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR 0x77084
+#define SDCC2_APPS_CLK_CMD_RCGR 0x1400c
+
+#define APCS_GPLL9_STATUS 0x1c000
+#define APCS_GPLLX_ENA_REG 0x52010
 
 static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
 	F(66666667, CFG_CLK_SRC_GPLL0_EVEN, 4.5, 0, 0),
@@ -85,6 +89,23 @@ static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	F(202000000, CFG_CLK_SRC_GPLL9, 4, 0, 0),
+	{ }
+};
+
+static const struct pll_vote_clk gpll9_vote_clk = {
+	.status = APCS_GPLL9_STATUS,
+	.status_bit = BIT(31),
+	.ena_vote = APCS_GPLLX_ENA_REG,
+	.vote_bit = BIT(8),
+};
+
 static ulong sc7280_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -154,6 +175,13 @@ static ulong sc7280_set_rate(struct clk *clk, ulong rate)
 		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_UNIPRO_CORE_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
+	case GCC_SDCC2_APPS_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL9)
+			clk_enable_gpll0(priv->base, &gpll9_vote_clk);
+		clk_rcg_set_rate_mnd(priv->base, SDCC2_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
 	default:
 		return rate;
 	}

---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260819-sc7280-sdcc2-clk-0b8f139508f7

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

