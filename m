Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEDBF8FA71
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 13:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A4384258;
	Tue, 21 Apr 2026 15:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="do0VXhA5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f5Lx5Y0R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB3F83BC8; Tue, 21 Apr 2026 15:00:30 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0256841D6
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LB4H0t1011843
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UjVsbRTJ0wnR3Swf3d8c+oSGhRVPQFNE3pqvvd1EauY=; b=do0VXhA5gG/ucxpB
 wVGIeMzzjTYrrVJ1QypnBRdotp1ILW/nnOSN+apgpr+9f6sLd34Haft8Ac8KhSRs
 ed4EH4yrG/5I+ZLfsXuAklHG9RgEnToM7dSeRjD1yzhInG5dizbARFmiY9wMvWqs
 7AjwxgyuIAkHqP+UHQ7LqnlEY4hPTw+Nk/5Af52wR6joLHE2suT5v1FaHufvu/EW
 +0bk5+/D7812MwytSEuw8F2I2CtrPd9kCiot6YFSbrsluO58W6+dIDPq6ndJFNSs
 5GJEkGU4+K4RHHMyc/pRMn5R+4Mk0y05tmTmRIqOX/90GS4btemzQbvWzYRcUnaB
 R0C6Sw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnt9036kd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:00:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b4654f9bb6so44854175ad.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 06:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776776425; x=1777381225; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UjVsbRTJ0wnR3Swf3d8c+oSGhRVPQFNE3pqvvd1EauY=;
 b=f5Lx5Y0RPrZ16BrbI2Q28x9nzC6IRyoYNuHe+Lo49okrzFoIRvg2NJSxMQcvcd6XB4
 MGg4/i522TcFRbE7yQl52xrTjQZ9z4RrNi/ddHGpVhYEHC20CYsnZU83dzuczKf6935U
 8YPIL1mivsjbHVfpa+ZEeJOk/gdVFsTgBJxsJzrIIVjiUJB65cKkUYMLdG66iJwMVbNz
 Ibw1n9Bo+75+/LPnTXppkp70KNsW6KoLCuO72Ivz72A93NDAZYW2KZI17npf2XEoLmbh
 Fw7A6PIse+DYuULBHV0wr4SnQbwl+ncir+98FN3VX8p2/0VrSJpY9pqdbR81tDYdwBCL
 1Fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776425; x=1777381225;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UjVsbRTJ0wnR3Swf3d8c+oSGhRVPQFNE3pqvvd1EauY=;
 b=UyvXSismvXZVbh41C4of2eCNirELWeK1LzLqI3+cFuOkRYB3Jae11dbEHwirR8scGL
 uNOrBmJCBfXha+83PkgPNiwMCCpoUcbBkWj/MuRAAu9J+zsD2MhMUqDDFl4FapYEqCz0
 LeHz6orJufvn3uz2Oo8rIGJ2BVTir5/y/MYodT1vLI3UHGv/wH9R0DvyNFSz46b0Yx+V
 3WNZWoHt90CtT8zQLGf2uiyUd3k4dJp4ZfmIqSqNHsTZLN+QknCFu80CGJqnUJMS72m0
 aczC/q7pnm7WOSgav+06k4+r+SRZtvlE+e3MFoTrT4uXMMqWfRBwm8TI1mJXipjfxYqZ
 n5vQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8akgVOvjpisukDqx04ElPg/b1t0j37DDzXzWxjNG6Q1OBc7wU7svX5ZFUEcUdg8F6k4hj/sq8=@lists.denx.de
X-Gm-Message-State: AOJu0YyBO8jsDiKVRsOX2oiBb3TzVGboilGhcnbFVG6bV7NuYJYgEy8p
 A2bS/DRvQ/iD07S/DCjsG0tc4W/3AvL2BXbgEXguRjQeDawPJGDB0djUqA6Eame89ZBT0iAQgns
 TaiQ290n5PrVr3zlk5S2d79ycrKUU58Gx1UovedW9RJGQ90eLjVfgkaWu
X-Gm-Gg: AeBDieuj4KdsTbyDgXgwY/0PvKrmZrYUwyPVP0iCNY+MNowyzF0dlbjMRz5t26ubqdy
 0QETrtEE9JnHOuyCFXoDJUCSiZA6n5b4DE/7h44URvOa1hnT2v5qwCdDUJeRD8FN8jnzS5CD9F+
 b4n0XHDd42FbdamCkyqiRxYWeSAUiKHX/C1+NnHAMohEoSh5htfug4NPDOb5RwYZR7G9ot/sqaB
 m6jCtXksHRTxmkDPO0uAV2F2bgwoBO8Aepkvgix41gcZmcMGBWfuUupxXLejkZGBcJN+V1xz1C3
 lLFTSp8XKa1tP5dmUetE3YxUhnegpUbbP3rXU8rb3GLPXZbo6N3PCLNxe0wxuyYv4HhUysvSXwZ
 U3Wj+KhhCVM4VtCYq2Ox24JQxT5VVKl4Qe7buFTKH0keNp6p7wNQHMUUEu63zRwOdIZcdW/c9Sj
 cjwoHswdNUJanMJ0aeSX3LeaNS4fq4W+87LV/IPylmQoIL5lCvgx/JJ1QtwKsG
X-Received: by 2002:a17:902:8603:b0:2ae:6092:8d93 with SMTP id
 d9443c01a7336-2b5f9f9469cmr143443765ad.28.1776776423410; 
 Tue, 21 Apr 2026 06:00:23 -0700 (PDT)
X-Received: by 2002:a17:902:8603:b0:2ae:6092:8d93 with SMTP id
 d9443c01a7336-2b5f9f9469cmr143443055ad.28.1776776422706; 
 Tue, 21 Apr 2026 06:00:22 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cb92sm130117335ad.50.2026.04.21.06.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 06:00:22 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 18:30:08 +0530
Subject: [PATCH v2 1/3] clk: qcom: qcs615: Add SDCC1 and SDCC2 clock
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-emmc-v2-1-0ebd3322b676@oss.qualcomm.com>
References: <20260421-emmc-v2-0-0ebd3322b676@oss.qualcomm.com>
In-Reply-To: <20260421-emmc-v2-0-0ebd3322b676@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Sajna <sajattack@postmarketos.org>,
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776776410; l=4189;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=aWdB2kOdltK8fJk1fuNu+3JdzsDLfpQppzReixdVvJE=;
 b=4UdgUfzgSy+ptJIjStBxz4L5Opw04d2Bsdl2QKE7k+HTvC5tMSK2j0w3w/RRUEtkNVLxGao5F
 eKv3oLNyXdhC1Xjl2RWNtZ1pdXTjSidPMQOSHR+NihkBGr40+OBgkhp
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=KfbidwYD c=1 sm=1 tr=0 ts=69e774e9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=3G7GMa2Rz-pWoXbLxsYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: ImCBj26Leqp0NTs3NEabd63wGQl32her
X-Proofpoint-GUID: ImCBj26Leqp0NTs3NEabd63wGQl32her
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEyOSBTYWx0ZWRfXwgQ7auqYzeSv
 CIXm5DXN9n66bYGa9D+y7Ip2lEVC/RmNM2P9zC3zBva7QQc6FsiDckobQjw3Q4+wf4fB/L/b/5O
 KAeOm3xBqz+rc9nq9pyTBshK4wX/z0QPmS7bkWZJ5p6AvZ+dfyYOguirUTNKfm+DYxeGMKCFIn1
 IW4PxS/FS+9vKNLRGg9mdQnEZZDgKG6u779QamIxTtC1UfZxdIa/boDtFBX3HQMNY5bv/dPflb4
 QmEr7r9fj4Yg8ObtZ/9scBfVepPapk+30Bf1H/ReoBPnBH6QGfyB3KphaSMGIcJPB1YKwtuaMSL
 4zwofr6G8FAlLVxH160w16payMm8ZNUc4IVxvSDDlHJdKu7QeagBM2kAlO182WtD2s9JGcoCWTO
 YZ9IEJdMGCj6NNupmb54MFdbo6DA3MpXP7EZuY+SmaW6IBA26g8eeQQqLQtWuZ4YLKohnqOWU4G
 jQkprEU3ww74uEytk/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210129
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

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- No changes
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
index 2087fc38f63..094155e2034 100644
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
@@ -81,7 +120,12 @@ static const struct gate_clk qcs615_clks[] = {
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

