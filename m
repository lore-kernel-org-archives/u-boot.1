Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702F4CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 15:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E701E83E4C;
	Mon, 24 Nov 2025 16:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YqRpyq8y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LO36TgQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B1B83E4C; Mon, 24 Nov 2025 16:55:32 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 297B783E48
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AO82B711683365
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=oRYvU0C8qLl
 TP8yuqFq986TNTXYCB4Yg33jJVjJsfi4=; b=YqRpyq8ypDZm9VGzT/wQEmmpsQu
 wa/KFW0LzpO7pKJvTR+tQIS+by7ffa2pAQTqQAmPu2HJJE1vMGOwvyqRSAxu9auf
 epzWxh/hvB1Y4UykefXIutPGpAE332f86jEVYdoeD7/pW2t2F1F59+1W4mihPczF
 QrxmxefzJMppEBSJKDO+9xREJV61ff7Vt264uUlmoB2suqHhQpaIhi1Dd6ERTVTV
 05Yx1IQHerVcETLxmHGs23ZUJLsaqTTwTKPuu3lRLu+qmNEHoKuG+gcTLMAOMZmp
 UMjv5QdrFnEYfKcm2EtMfCRUp81J2DnXSmO9Rfjv2RpJ9Zc/gEEQUxq81nQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ama09ahn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:55:22 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7a4c4eeeef2so10864117b3a.0
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 07:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763999721; x=1764604521; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oRYvU0C8qLlTP8yuqFq986TNTXYCB4Yg33jJVjJsfi4=;
 b=LO36TgQNhKXphZwr/Ur6DBuIK26wAZlzIN2fj3h0kYlZ55IuQCg99rYy1LEqbIAVHB
 oIm9QnsK1Gyv2KuwlTkfCgAtCloMamkA5T5FyMxLlOMgYx1thgPn2MUAn6A1vu3BlQB2
 eFgFNnWmcCH4GzASIzhMk0sNp9mGdqEf1BXUxT5HhPKJCRaa3F6x4yTf5tgaVpSOZx5Z
 xJzaWUvFr1VMNNG9ePGmF3i9hSamDlgvz7HqXiPAAuhQkHxlvlK233OEmnLBW6ls53vm
 S8k9vSSWh5C3WXuGTx+mLSoAsrACRfXMcYgJ3tm+KUyq7BnqNsykiPDazG714uL7YBQf
 TRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763999721; x=1764604521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oRYvU0C8qLlTP8yuqFq986TNTXYCB4Yg33jJVjJsfi4=;
 b=FXELYDT+nrzqouFYmIx1+yE1HW4yfTbsLqjPPCNMuzPP+Q/3UXYsfldXKns+e66281
 wMbnp5hEsqWA7xKvwQ1MwnvZOO6fVpwtPOrguFnr0KyIChrEdtcxhldgOw0ySuRCK8Cc
 g9yVXp8LtGXI1tk3Vstv1z1jP+iLDRDFUncabJK+m2HyH9w81pYO1TP5M9sbwHdxE/Lu
 ANHFRJffmExjnXms4IqkysCX++35gfFyGQ3qQ75w22cqj+nke1Aa4+mY7yDq2Od+Qskf
 Y72xMxXKXflWze3BS+QbdgCnOxYnlNdBTAY9rNwy0Yqgzi6ME4d5Ybu69Qm/69/Jx6HN
 YA9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhDh3gcOoZEhRD9JsbOsrcdPdl5K02UOICwqBMs8CntrQ6hv/qHnz4rxtKN88Q62g1BHbfI7U=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6Iv38Q0Ndo9O6I+1DSDzhAQpXlE3HxXqKJSu+k1ziEXzO2nyA
 G67xuIWU5TBg+KIswNCXyu90t+Vci44EqUlSBWtjzY/TzI6OnjLPqDeLwAHC2IzniINZaMQ5nnE
 YDJKCSX9VjIXb/wDNkR6+jBaVrTBf+Ca4ux0uTsw+Tqml54SXtd8WEZo1
X-Gm-Gg: ASbGncuaqU8FUhhcdAm/cPrCl/5axKDPORhpJ7EsOzuxuA+T6KRabl8pKtpj+CjkQJ8
 601yTRY0y2X/Eihp1HI648GzZ/vQYIwTkBhr7zMDOdrL9p2i058gIa3a8n46APU0w2f0eqlECT6
 ZDsgjPgXqc2y+ui7HcwhTtRhfnslIj+9VLavUoEKzLRt6NFRXynA5daJOLEksnx6PWuWkOOvaCV
 gcf83vKMrJosIqD2f9O1C7444mhr/sTkPjJVP/AdXRLrTTcbjQOb0xEmaHLO0g9R+1xMjKYpGA0
 GXnASqHTGyIxJ3JfH2b3+fwudFR7bxHFGtWHdlJ1FWXJg9crcQ3eyz/1CFXNiBaQVCTSYqgnEYE
 ozxSflM+Cnim+BaPQgJvcG0gJgVzQgPIF+i0jxFYt9T/mqt1PI2enfrXX+IfUypi4g7n8MoUc2t
 1kdk8a991H4XMZg+Fejb9eL3cz17lHk6M8L9FcSw==
X-Received: by 2002:a05:6a00:3e08:b0:7ad:c017:171e with SMTP id
 d2e1a72fcca58-7c58c0bd078mr12818365b3a.2.1763999721434; 
 Mon, 24 Nov 2025 07:55:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq91IJQsHdN3oww1OS842KM0iKGra3vJ9D++Vq1h4062xxRel0gIT0PM+qeuTN2XM4pZG5HQ==
X-Received: by 2002:a05:6a00:3e08:b0:7ad:c017:171e with SMTP id
 d2e1a72fcca58-7c58c0bd078mr12818322b3a.2.1763999720817; 
 Mon, 24 Nov 2025 07:55:20 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3f023fd82sm15254884b3a.42.2025.11.24.07.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 07:55:20 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, arturs.artamonovs@analog.com,
 utsav.agarwal@analog.com, vasileios.bimpikas@analog.com,
 ian.roberts@timesys.com, nathan.morrison@timesys.com, peng.fan@nxp.com,
 alif.zakuan.yuslaimi@altera.com, kory.maincent@bootlin.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 1/7] drivers: clk: qcom: sc7280: Add USB3 PHY pipe clock
Date: Mon, 24 Nov 2025 21:24:57 +0530
Message-Id: <20251124155503.2839766-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: B7vyfUvR5FE5aA19My1fO5D96f5Kqxdx
X-Authority-Analysis: v=2.4 cv=PdHyRyhd c=1 sm=1 tr=0 ts=69247fea cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=poeaOmuzvgfykHCmRdkA:9
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEzOSBTYWx0ZWRfX7s+9+FWmqWy6
 Z4xxQkwmdXMY+j9zUfQ52cZmandd1KGNNq0gGA51orFpkuTnxVDD7BttetyHQ70QxW6cDjjjCPh
 CsyDyEPZAQzqbV+SmXzFP1RmQ7PL/z8ZhZwocwOauvBQYnKW0CbPsVALSN5Lg/LKGOS/7SpHiXD
 b1dN4NzUdNnBENigdd3M+zpltj37ZzrQ0FWJ5FxbuIZ7JkXItbuqP3wGvapYUENFSquL2S2Vl7o
 kOBN8sY0xEeBpNZ10+LIH6BVHlr/u9ItxhFa88bumkfdMm5XoOghbtLKphUC5mGCc98JvV+AOfQ
 ZMxHw9GEz2Yeq07/5bGkay9BcJMPUwYMps55+RaEaYY3AzNFPALI5WB3wrjag8reKwjg+tarB1P
 G4TESgJKImcmL5TtPpNAyJtdDq4CvA==
X-Proofpoint-GUID: B7vyfUvR5FE5aA19My1fO5D96f5Kqxdx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240139
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

Add support for GCC_USB3_PRIM_PHY_PIPE_CLK which is required by
the USB3 PHY on SC7280/QCM6490 platforms.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/clock-sc7280.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 55a233df394..a2af73cd976 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -111,6 +111,7 @@ static const struct gate_clk sc7280_clks[] = {
 	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf01c, 1),
 	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf054, 1),
 	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf058, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf05c, 1),
 	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x9e07c, 1),
 	GATE_CLK(GCC_USB30_SEC_MASTER_CLK, 0x9e010, 1),
 	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x9e080, 1),
-- 
2.34.1

