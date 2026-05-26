Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3D2CD5BD1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 08:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03291844CF;
	Tue, 26 May 2026 10:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q9Q1J6KD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gvNSr3Au";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F047A846AA; Tue, 26 May 2026 10:59:00 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CCD58404D
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 10:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q8BIEE3604070
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=y7fwB5+4bLHZG5zJ5nXsLy
 MxJY0nMOcASxl3pFn0jYA=; b=Q9Q1J6KDYrMSYyzMmW2U+iEyiPdPxUqPBV1dzj
 kv41U1lWwP251TqlO82Tn6kVdOPOwDTIpthPxLF1Lw3IwIzvy9rKlyaqGMbeY00F
 Nub3p4cNFn2MUCAB+B8Mtg8UwQBQYTi/0n0v06ALWCTyM1yo5VxDiWFd8QnyHdMU
 zun2NkZLjpGa/DWaheVgwnb0tSQLoEWM3W3RXCLYvSVwSSy9yeJBKEQgdzpwliv+
 7vMmDCkCh/PCpkfr1h2n2SQ3Pee3hHcfAsOQhWaSGufa4NZORqgKH6F3afSC7EMv
 Eu1ptwpcJ/F9zUp1xfSFEDDLY5RExROHXo/Nm21AoMkpNg6Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpyqk6y4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:58:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b9b8137828so105551145ad.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 01:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779785936; x=1780390736; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y7fwB5+4bLHZG5zJ5nXsLyMxJY0nMOcASxl3pFn0jYA=;
 b=gvNSr3AukRa+FrHfPkMLLK0RViN4vwBM239o2SThgD/91odlf3fF4brP6blAZQwhnF
 H7SxT0MNA+SZ7uF5SSIYAdCg34k2gSd31jDUU5o/p9ikPPZR+I/Udzyvp0ImzqRciyOK
 LCriJg8Fu86pl3rnJJCkbouHr16YzaewtGH2Yj5kbChi3o/J8jIUbHBEE6Ra49Smlaej
 0mpxnIO3MFCgDdQjnR5xLDk9I1J21280LH6kNIA0Ow3S/tOeJ18TZezcTs9IWGL9y1uR
 t06T83nuWTcjGeLSe5QeUVtByAT+5phRYMy9Hex0b0lU/nFhTNNTCIC3qEUiZqRYjkaa
 ifeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779785936; x=1780390736;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7fwB5+4bLHZG5zJ5nXsLyMxJY0nMOcASxl3pFn0jYA=;
 b=Gtzj5P/9pY4vwxmP4CEghUjrgLrtfnSxrKTRdx+4nYFKZ8CC5LTruxmcNRO7eR745/
 4uw4uKBSypR2jmzAlbxHcm0Kd12nxekJsBvQQiClxldQmEzI5LzpAHfqwGdVKzUYBEeQ
 OBZfrES7ovjsBpfn24MCnpOPkSgcML7knawFmYF+2woUHkcftKB02RMGSrxGlJ10AtbC
 0P/Iu/8CBIYJRFWhdMLjxwsGYec/DkDcCz0SFrOrEsC+rQPqps2aqpXBEkd9GN8yQnyd
 ajBeIk3soQof131sZ/naysQQ/sK17CNnvJMzCk7VxEDIXMm/rmlVBTZKIhSY2dTVvGiY
 QKHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WZUVmPODKLcJR3GqRlJsV1R5xDdGQciXRN9qL+gKQHY1g1R/yy9dnz8qLGVmTcmYDHrsSDME=@lists.denx.de
X-Gm-Message-State: AOJu0Ywbb+wU60K3iNhggXhiMRyipdIIlIN+q99D2mh3FXpqDbzuH6A5
 Tj47PRoyiGWV2iRiIvud8fNwyFa4W2O4hYalYJBlw8Cdtic3chb5er5EKNxf2u4khRSm+RUMzL7
 smYXm0/+uwo4ZbbbCT8Rvt2T8Wqv+TvghJZ/Icqx0HM1zlSJmGFPW19LD
X-Gm-Gg: Acq92OE0p9+rPsduyFVkHEVmehkhXOYBeM8fQKJ7azwVvC1nbNz2vMySSavbtN6N8q2
 MfQnARQiKCedG0Da8ipOB4LHnktZZ3m1I8aQ37SUMNT61NB3V+/6/dJUdEIaV4D67YxKPXu9Jiu
 m85EdF7SS3NzhZMpITE7fPtCZcDmLzXq1ZALgwwAe5DljIpMxEcmPZTbWxigQigFMBl2s8QZvYw
 gs/NmbkLIVA1jFrqqFUDjAddZo7gIZ6kDHw6LkoDpAPHubrRyD42UsSuY6KJUkJ0mQ+BviQKGPQ
 Gld3OVLYCWRUjy0kl9byMaTZ0giWy1J1rOdzBByGg7NgfrGIINZq5WWgUvaQVHSdnm9BzJFn4eo
 9XuSw3+gAeL3mQn8iW5WnQg+c9kmwMfD9X0OgRc7xhhSuN2Suc45xI5d3SoUllRkb0u52MJQjHk
 bwtAv5M15GBYAKheTPYdjnM9FMsvM7SYVH4EaNhl2iknZxdBciMXjaCW3v08JC
X-Received: by 2002:a17:903:3c6b:b0:2ba:6ffa:bded with SMTP id
 d9443c01a7336-2beb0707cefmr198565345ad.37.1779785935650; 
 Tue, 26 May 2026 01:58:55 -0700 (PDT)
X-Received: by 2002:a17:903:3c6b:b0:2ba:6ffa:bded with SMTP id
 d9443c01a7336-2beb0707cefmr198564935ad.37.1779785935136; 
 Tue, 26 May 2026 01:58:55 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56f4343sm156627715ad.36.2026.05.26.01.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 01:58:54 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 26 May 2026 14:28:50 +0530
Subject: [PATCH] clk: qcom: sa8775p: Add SDCC1 clock support with frequency
 table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-mmc-v1-1-5a76de90e792@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMlgFWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMz3dzcZF1jI4tkkxSjZEsDU1MloMqCotS0zAqwKdGxtbUAa0ekjFU
 AAAA=
X-Change-ID: 20260526-mmc-328c4d2c9055
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779785931; l=2217;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=f9FkWX44th22VBfW1thiQpcFBTlMgXz9iG9cDZsQKmQ=;
 b=t3G6AU23tVp7Dr6GgaVXrzUivD4GGNNsKwedRmcwe+Znv2qfXlztCwUMdcVZNR6iDx2uzB1BZ
 NmYGSzG7j6dDxYNNHELQdLBDvA3o9hI8IXcAVqkQa1p0DhlPFSqAHEL
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=dtfrzVg4 c=1 sm=1 tr=0 ts=6a1560d0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=526cBOim7ay0EJGWx88A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: S_3zLXVVX-e0oK9MLpj818Zy4YhVCgxz
X-Proofpoint-ORIG-GUID: S_3zLXVVX-e0oK9MLpj818Zy4YhVCgxz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA3OCBTYWx0ZWRfX8fh6yrDxHTlq
 zhEeInuFe9qPWJLzjXyRI/eZOBwCZLh1HsWA8RcYIzkTuSJvLZVfi6+X/820dNLAOzWfBMd7bW4
 JPJJcqY8SFvgZPCvcZCE0kJf5/8v0E356YXtjIU1L2QUrehfUQQEDHOPBkZdyAq35uJI78S9kAd
 hjoj3XGHqnBdHiViB0okNgxGre/pJJEOCnbXgpx8bliIH7xvF7dLE5dSA+u0yoNcEFjASxzhTDZ
 LmprEqvJ/2gUWRlURsSfuDiJSACINa92qzhhwBAw9fuYMyXstarcYKMvpNQTMV6IrNaoy12WFuO
 MJ779uSRmIwImtSXxe2fZ3PLvZZQ0P+ZvDIdsvHErTUZ0EocRLxZPjioCiq5WaN1XKBMTDc/pY4
 bOIdE3OG44A6hrkpewLjeWi8gpCwxZ1GaHzKsdbWRCIFEGMiyjxw0ULcNfNnIGTAnxC1F2W1LFR
 yDVcoZ3vopAbxg3CU/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260078
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

Add support for SDCC1 (eMMC) clock on SA8775P platform.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-sa8775p.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index 4957abf6f58..0ec4ad041c6 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -44,6 +44,22 @@
 
 #define GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT BIT(25)
 
+#define SDCC1_APPS_CLK_CMD_RCGR			0x20014
+
+/* SDCC1 APPS clock frequency table */
+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(20000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 1, 3),
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	F(192000000, CFG_CLK_SRC_GPLL9, 4, 0, 0),
+	F(384000000, CFG_CLK_SRC_GPLL9, 2, 0, 0),
+	{ }
+};
+
 static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -63,6 +79,11 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
 		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
 		return rate;
+	case GCC_SDCC1_APPS_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
 	default:
 		return 0;
 	}
@@ -106,6 +127,10 @@ static const struct gate_clk sa8775p_clks[] = {
 
 	/* QUP Wrapper 3 clocks */
 	GATE_CLK(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT),
+
+	/* SDCC1 clocks */
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x2000c, 1),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x20004, 1),
 };
 
 static int sa8775p_enable(struct clk *clk)

---
base-commit: 76d62273bc8a5dc126ed79ed0fb65e5a97359577
change-id: 20260526-mmc-328c4d2c9055

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

