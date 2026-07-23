Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7CFC4453E
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 06:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70436607B6;
	Thu, 23 Jul 2026 06:40:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FelmoZcUgkd6; Thu, 23 Jul 2026 06:40:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 231A460793
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784788806;
	bh=xGKtz1LW1C2J3ro5zE4NR0ynkkKO+3GMu+SxSN31xD8=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VM+r2scnOlcHaBvYnFOI1n85sj9IGNEgo3rh+COrxt6javuJ8BC+2ARfg9LZtem+l
	 oyqRQr2Zr0FxUUvziU59rYqlMr9Ah62qNY+twoEKAHoS+p3WQ1f2KbyQLryW7SQYXC
	 ir4Y4Yz0+7RfvGgRF4JQEXVLIg/NO1QwF/oStGYvEv1zoTXnKPPIKz+JG6MH+A/DFY
	 qONN9zvhnbNJrVhYohfQgOj6jF4bmqAr3RVPNqZSrvFax0UXlDMb8XnW9SqGzRl2nm
	 1TBIAjj/5vrHIpoZsCh2xVEOCXJHmPbyWz1RNOaNI6MuM5AvQJQguFzwCova86JD0p
	 Rq5rv4oCwwhXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 231A460793;
	Thu, 23 Jul 2026 06:40:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A09536E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:40:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 701F480E2B
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:40:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bNE6D0PQorOj for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 06:40:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 58B4080E26
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58B4080E26
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58B4080E26
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:40:03 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N6Aec33115881
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:40:02 GMT
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk28vjqxb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:40:02 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84a67b16217so603491b3a.3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 23:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784788801; x=1785393601;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xGKtz1LW1C2J3ro5zE4NR0ynkkKO+3GMu+SxSN31xD8=;
 b=pl62aM13LGFuDnt/A0hgLnoLrrQHtTv3jV4l24y5cW/LJw0u21+wER67z90JuTyhVv
 VoRY+oqWFnWyX7YTXOwqb+2alpSVJnQwNKHB3tBqcqvqreXRgPm1PVeh972r5Jg/aGRl
 KcfMq5Taye+/nt4t7ahVXBVJI9/AyKDjtZoEuuMM/3k9puir9VCrBhKg0wbWH5eWbIIj
 xEWB3k30BhQrOjtWHw3mMlpgMTMFij/ACP8G7iN5v9Hofbq7w1c/YK7GC+1OC2U+742w
 ZpIt2iczJQ9fy4BMxkhBZSMQOB6Xjj48DPy9PQ3nE/Sp+/oyru4T95fOsVGCYM79DBQq
 G8Iw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEMF7gjsuotCZ/GLnZGOg51LgmaTM96NRtfIRprDWgLUhAOpmw5oRsMEkr7WM24YNH0fdQoWM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy2Q9QiOIx0C7QqsREierGtE++jEuftzXPYJ9BvjLoulhWLiu1y
 PgN/xPfg15YlrPgpKhOGc9gDr6K7LdtBseIWgpaftlL9xzooQZiRTyGjK0P3spM1JOOAwPTchK9
 zwJLldary3rwuUAgwPNRPnWpXDhPG41dm3zGalfozOj71O2MUNiHLfyVTYRNUt3Gijgj+xbc=
X-Gm-Gg: AR+sD13hqfcK31R1DMLD3JQ5ps9fthapjrFV2xUdKKUj5ofsCAyUk//vUOfnp6KPtIX
 +GH6fsh/pcw3chf7jwMwkEBCjPvTCHGznwGkcTvQgNSTzz0FKYLO4GWJn+I7OHfJ+TVkeUGgnAl
 u6IMrwZcM+GCLSZKR2y6IJHlJyr88wf7XaW0BsNRa2/TKV1RzVPffONxcHi1X2ql0UR63Xvky91
 rFuPT6XkLV83ypiwgnZDZe8vE/6dgPIQxW5cto2UEyvWQblyGA5ZGHLF+2YZmjynII8m2VBhg4c
 mIe+6n7WVXY/6WNR977zVTMNeTluGzq7ilTf/uUeMHWvVQ5RehMWwmu/bfnx2KYcabAJe2LeJkc
 HiRSsIdFqFXvyrVdv05HXEABo8FjMMSZvaXgSh33Tb+H2qQ4V7aNxdBQnafJ0ro6QHDoRLimTYd
 LrmMpOXF+KuE/EKxUZx1YOprH9WLx6
X-Received: by 2002:a05:6300:95:b0:3c3:64cc:c1fc with SMTP id
 adf61e73a8af0-3c44b27ec2fmr1862066637.73.1784788800988; 
 Wed, 22 Jul 2026 23:40:00 -0700 (PDT)
X-Received: by 2002:a05:6300:95:b0:3c3:64cc:c1fc with SMTP id
 adf61e73a8af0-3c44b27ec2fmr1862039637.73.1784788800582; 
 Wed, 22 Jul 2026 23:40:00 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc6781dsm17496758eec.9.2026.07.22.23.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 23:40:00 -0700 (PDT)
Date: Thu, 23 Jul 2026 12:09:47 +0530
Subject: [PATCH 2/3] clk: qcom: sc7280: use GATE_CLK_POLLED for CBCR-backed
 gate clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-clk_gate-v1-2-9549cad4d097@oss.qualcomm.com>
References: <20260723-clk_gate-v1-0-9549cad4d097@oss.qualcomm.com>
In-Reply-To: <20260723-clk_gate-v1-0-9549cad4d097@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ajit Singh <blfizzyy@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784788788; l=4999;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=rvZckUZwP+YuBN/cB4fUuKQcnBtbvDkXolHNF/iBqts=;
 b=0f6p2ARMMOpKjtw9+/410qEZVByFFJ+IbPuNrhM1iE3mfWShd6k/g9zOls4AlNeCTUX3YjhjH
 Y+tY8rkSTLiD/KZOrDsIDI3xDmmdt5o0lS6ucdMB6wkoEEF6Rov+XzB
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA2NSBTYWx0ZWRfX9AgYfB9/1Q2i
 9k6YlixEpV6HFoxZlogATwaTPex+ceqjR/elPtnA22f3G6WlfEdlpRCgq7yB1+vXcFxewMjRiKT
 M/BuQYqKAy9GOMMG6Vcw4afjGeNmCNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA2NSBTYWx0ZWRfXxBdttwMh6LlH
 kTibTiQu6bvBcGe63rBfcfj4I/Xen0G5ilDoULpRDgkhz/iiD/eVF+/5q/R29usrpY05jp3IbXz
 QOGVlvKrg9G9CfWd9i+SMDlywQkyJ3ZZ9btKLcwmDNKXikQVFa5YnvIjgLDaKhW6Rk25UnJuJO0
 Jj+tv7thSq8Ir5UYhNg0g0uTzy8mwKo1FKlWktg281kBBsTmK4IzWtVYuU5yEbIMsOn52KY8LHo
 r/NOQg6NO1Xj7MIW9ZaT0xJ5NOENUC9jvXpxOY0Ti+d0QZKz7aAMLpA4n4g2ALLY9UHGcrc8Tba
 GYZU00JQbeNe3aBzFsKp/rX/ejRFjE/rcGeRxKOm/HF0wZsSlZUn7XpeNRtJjqKGVBKK5PT96vv
 FzrJXJjyQDhhPP6GLR4ZcxFXlAnWGoAeNI0Ndktj/7KDFhMeYtreELG8zq82290vli/ugPHGoqf
 kArRJ6edTTZRdfeL+EQ==
X-Proofpoint-ORIG-GUID: j-cFnjdNZXS9eEuNGOtBD3k1cBolbnQu
X-Proofpoint-GUID: j-cFnjdNZXS9eEuNGOtBD3k1cBolbnQu
X-Authority-Analysis: v=2.4 cv=D4V37PRj c=1 sm=1 tr=0 ts=6a61b742 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=HgK0oHn9HBBShhAVJREA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230065
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xGKtz1LW1C2J3ro5zE4NR0ynkkKO+3GMu+SxSN31xD8=; b=DfCnfkuz/DQAesnM
 YRO/DBiAvR4VJMX8PrUCMtcNy2eHyoEYbJae+Im0fVSu6k6Y6fZFlQhcYLB2Cq/2
 02zdhaKcZbi7bBaM0SJuo3XUg85xNzHAVvG22VpttSKZRrwZhS4rTnS2NvSgOZm5
 q9WW3TmU3sDU6gClInPOTj2gGpljqGinjn4gd9zmO/oSZKI8LyD8xtH+0xjzWzqZ
 xDQ2guqgS/z8of1CliMDM6e0RWVrek5IgKOVTU/G6t2JUEH5acs2S+DiYjjpywu3
 mFJIsniLLqSybnl+vR6wgeknolJWXVfHHSwewZYgPg45Rbo4Ea5vMMqmjP6dAz9Q
 9HhQ9g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784788801; x=1785393601;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xGKtz1LW1C2J3ro5zE4NR0ynkkKO+3GMu+SxSN31xD8=;
 b=Ns66d1zDLbLdLLSq8ljZUxzMIBmTMia6fcAc9ki/zviO6d5pnCwgyzQPfQnpiXvyR/
 o8mVshutilud7JbeGjCLgV0Dm66GBkCS1/APftBOwxVWr1R8WOa+Yrrl/NhDByUk51dN
 pRBeZI1LCB6xtwRX740kHLC/khZJ82qZbSCT8vRJnOqDADVrRyJSCk25QI3FS5avxu1Z
 W1M0042yp2fSg+/V8Y6taULP7NYLcXnseGArgjHS/jzDpgwnQn2bFKzcY8mTRix442I3
 xG4WSRL64lNlwjTJPA1TdPnsOM6JVhYhdSZriBQZIhE2Lp2LESXIJhtmQTI5FPfe+SGb
 SW+Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=DfCnfkuz; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ns66d1zD
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Convert the USB3, UFS PHY, and SDCC gate clocks in
the sc7280 gate clock table from GATE_CLK() to GATE_CLK_POLLED(), so
their enable status is polled against the per-clock CBCR register
instead of assuming the enable write completed immediately.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-sc7280.c | 62 +++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 91e3fcc27cb..4520bf9ceca 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -160,22 +160,23 @@ static ulong sc7280_set_rate(struct clk *clk, ulong rate)
 }
 
 static const struct gate_clk sc7280_clks[] = {
-	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0xf07c, 1),
-	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0xf010, 1),
-	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0xf080, 1),
-	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0xf018, 1),
-	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf01c, 1),
-	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf054, 1),
-	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf058, 1),
-	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf05c, 1),
-	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x9e07c, 1),
-	GATE_CLK(GCC_USB30_SEC_MASTER_CLK, 0x9e010, 1),
-	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x9e080, 1),
-	GATE_CLK(GCC_USB30_SEC_SLEEP_CLK, 0x9e018, 1),
-	GATE_CLK(GCC_USB30_SEC_MOCK_UTMI_CLK, 0x9e01c, 1),
-	GATE_CLK(GCC_USB3_SEC_PHY_AUX_CLK, 0x9e054, 1),
-	GATE_CLK(GCC_USB3_SEC_PHY_COM_AUX_CLK, 0x9e058, 1),
-	GATE_CLK(GCC_PCIE_CLKREF_EN, 0x8c004, 1),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0xf07c, BIT(0), 0xf07c),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MASTER_CLK, 0xf010, BIT(0), 0xf010),
+	GATE_CLK_POLLED(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0xf080, BIT(0), 0xf080),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_SLEEP_CLK, 0xf018, BIT(0), 0xf018),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf01c, BIT(0), 0xf01c),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf054, BIT(0), 0xf054),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf058, BIT(0), 0xf058),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf05c, BIT(0), 0xf05c),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x9e07c, BIT(0), 0x9e07c),
+	GATE_CLK_POLLED(GCC_USB30_SEC_MASTER_CLK, 0x9e010, BIT(0), 0x9e010),
+	GATE_CLK_POLLED(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x9e080, BIT(0), 0x9e080),
+	GATE_CLK_POLLED(GCC_USB30_SEC_SLEEP_CLK, 0x9e018, BIT(0), 0x9e018),
+	GATE_CLK_POLLED(GCC_USB30_SEC_MOCK_UTMI_CLK, 0x9e01c, BIT(0), 0x9e01c),
+	GATE_CLK_POLLED(GCC_USB3_SEC_PHY_AUX_CLK, 0x9e054, BIT(0), 0x9e054),
+	GATE_CLK_POLLED(GCC_USB3_SEC_PHY_COM_AUX_CLK, 0x9e058, BIT(0), 0x9e058),
+	GATE_CLK_POLLED(GCC_PCIE_CLKREF_EN, 0x8c004, BIT(0), 0x8c004),
+
 	GATE_CLK(GCC_PCIE_1_PIPE_CLK, 0x52000, BIT(30)),
 	GATE_CLK(GCC_PCIE_1_AUX_CLK, 0x52000, BIT(29)),
 	GATE_CLK(GCC_PCIE_1_CFG_AHB_CLK, 0x52000, BIT(28)),
@@ -196,20 +197,21 @@ static const struct gate_clk sc7280_clks[] = {
 	GATE_CLK(GCC_QUPV3_WRAP0_S6_CLK, 0x52008, BIT(16)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S7_CLK, 0x52008, BIT(17)),
 	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK, 0x52008, BIT(23)),
-	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0)),
-	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77018, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x77064, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x7705c, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x7709c, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x7701c, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x77020, BIT(0)),
-	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x770b8, BIT(0)),
-	GATE_CLK(GCC_UFS_1_CLKREF_EN, 0x8c000, BIT(0)),
-	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, BIT(0)),
-	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, BIT(0)),
-	GATE_CLK(GCC_SDCC1_AHB_CLK,  0x75004, BIT(0)),
-	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x75008, BIT(0)),
+
+	GATE_CLK_POLLED(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0), 0x77010),
+	GATE_CLK_POLLED(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, BIT(0), 0x770cc),
+	GATE_CLK_POLLED(GCC_UFS_PHY_AHB_CLK, 0x77018, BIT(0), 0x77018),
+	GATE_CLK_POLLED(GCC_UFS_PHY_ICE_CORE_CLK, 0x77064, BIT(0), 0x77064),
+	GATE_CLK_POLLED(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x7705c, BIT(0), 0x7705c),
+	GATE_CLK_POLLED(GCC_UFS_PHY_PHY_AUX_CLK, 0x7709c, BIT(0), 0x7709c),
+	GATE_CLK_POLLED(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x7701c, BIT(0), 0x7701c),
+	GATE_CLK_POLLED(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x77020, BIT(0), 0x77020),
+	GATE_CLK_POLLED(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x770b8, BIT(0), 0x770b8),
+	GATE_CLK_POLLED(GCC_UFS_1_CLKREF_EN, 0x8c000, BIT(0), 0x8c000),
+	GATE_CLK_POLLED(GCC_SDCC2_AHB_CLK, 0x14008, BIT(0), 0x14008),
+	GATE_CLK_POLLED(GCC_SDCC2_APPS_CLK, 0x14004, BIT(0), 0x14004),
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK,  0x75004, BIT(0), 0x75004),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK, 0x75008, BIT(0), 0x75008),
 };
 
 static int sc7280_enable(struct clk *clk)

-- 
2.34.1

