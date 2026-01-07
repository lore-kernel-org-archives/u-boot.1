Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8498CFD65A
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 15:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A676683AAC;
	Wed,  7 Jan 2026 16:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eUDmSo5S";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hmsUN/oO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B47983A47; Wed,  7 Jan 2026 16:48:49 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAFDD83A26
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 16:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60791Vmf1979976
 for <u-boot@lists.denx.de>; Wed, 7 Jan 2026 15:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=apdrL0kReCt
 7ClitjhSlesBpIzSEXwsw6/M7QTUcJ1Y=; b=eUDmSo5SGr7sjQtCArGacbVCcMy
 MAFIr4RKXmwyGcFgEy77pLF9ZWOeV22ktlvACnoC5uvdW6mWbwg7r1dnrYYJC4we
 gyKNKbzsxrIbNhomHID3JMQ1HMSm939zG2DZZJKGSkued/osER0txK3JFW7I9Tw7
 L2goXPP/d9+RwRqZ6ZUfsJXOp4vEaYbGTqR9sudaFCAjisfuHfOrbwjVjMY+chai
 N0uNaxtQdpEtbMIeo/BVU341l7ftpQS72SL7tOTlV460U+it0wCMrtGDdyAdr7gK
 hOQOl/5lRj8JsSo13DXZzf9532g+6doozqBJiujcfN1bAx5ETriJfOl9yTg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhdavjmua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 15:48:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a0e952f153so56371435ad.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 07:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767800924; x=1768405724; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=apdrL0kReCt7ClitjhSlesBpIzSEXwsw6/M7QTUcJ1Y=;
 b=hmsUN/oOjlyAB4UZ/HJ7OZ+2E5akv+OVFc/g7OGn9NANiirDqYCNYPIhehb9LIv/LW
 oksZAq78oKlZBrz9pbuaxjLqNj6Oqd6+Mzw5r3Hh6J2W9gSkpTFNoz5OXRI7Ngizevz8
 SsHKuH69fuWMcc33MijycXaSNZklR/c6v5BXvJhTkFj/UVa7RYw9XHt4IBu8BBFJccb/
 BeJqGVDYm+mS+nMSY61bQjRrEnh3RcyiNDPmsf5JPnAPYDM1HMMYOqkku3/z9rQbhvdy
 qX/Pzjn6/KkaTO5P/ytFxsGIYxCcc3cDihbu1xO/r+UXmP5xMYWTmwrEKHty9aigWG44
 IOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767800924; x=1768405724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=apdrL0kReCt7ClitjhSlesBpIzSEXwsw6/M7QTUcJ1Y=;
 b=d5kjT2JrdiiSYiws0DqU16OnqL8kdTDPcHi3mhhZC7Jf+xUzXz5APdjTjdNDS4gJdP
 0xf93KC4xGsUjT5DyEkuaidFb+7ZTMoVVV9IUReaG6Htdg3zqNFSKMiXgJy8r7NVq27V
 AK5yNwB4KpzsvT5CjE/qRg+AsPm9v8e8nXFt8XlTO8G+kIiLKd2W/jefFJYYFsEmStS+
 BiFb2Q/309A+caY+M5xOb8tekPrTS5DA1C04a0/CQKsY7U2LcPMv4MfcRI5DQepKbBrT
 JEhOztcrn6QKgEBsKdy3lJ1Dbw+fog8Vc7aYvp8Gj2Bb0RfSZwOoLsM2J+cpvdcsGxjK
 /O+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2vq82wI/wALI204m/r7J+JDqbhlTAht6VI5FvgLpCExtbZOSFRlm0YRncBmxS3PUriiw58a8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/BCwYGqqh+jUuTQmePJbvl6dI3QoW7qWMNcpRlwCDLQMCBaLi
 3ZGfcG/HoUWr6j6Tpsz7yjVwcEP3HRCjg8gMYyu7BOpBgp0z8hyFOjDVctyqr1AdsBPDDtxSXBr
 n8Lf5RUnjkl2tHYpeeAIpvFvg0PTiwjPTlM4CvCsEhtscj1/sYBSpXWczIsRRJCiT
X-Gm-Gg: AY/fxX5SqRlzBsdVfLoCp/iuADfIFs7Pi1lNAOBLBdXQB2EG1Xl2xxXNNXdCJfUgzVe
 4YM/MOl0pdT+GYbX/yHTgigJqJ2+AhT1WmNnSnnHL7K/8H88AOf0P9Wj6n2rnNWb3pYIEz/ADpn
 oqQzXdk/F2YC2ci6fUt5X2mx2beSRg22HRqH/MBEG8EAPslZER4ZuSKUGMJpGQSJWFm5i5oTpdv
 w0DXMG3x2JwsGru5+9OLnpm97BIJskJ6oANgAbonvnuiSpbMou9uW1tKUzec9G80IXWuLkQYlvr
 0Gx7LQ6IIuDPWDkPEj2WJzk1hulpsIG47LlbHmK1BGZ9mSOZaEGZHbMZfPG8chg6btOk54mhmTE
 k4NlOoal8GJ56g/rQ00wG+CrE1VbhiUZOJUcEF4buq6aU+Zsd8rD9R6UZ8qTVCS8KNkD1lrn4vp
 Y8U8JtKg/FftPA+yNi4WyNqesARvyT
X-Received: by 2002:a17:902:f64c:b0:299:e031:16d with SMTP id
 d9443c01a7336-2a3ee484c7amr30957075ad.33.1767800923957; 
 Wed, 07 Jan 2026 07:48:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQ7z8lIkUZvSvMDg5gErxHw7F3Mcn9oTe1j/yqwUS3ao4bsdVraw0mReAmFVvl0zjlA0whug==
X-Received: by 2002:a17:902:f64c:b0:299:e031:16d with SMTP id
 d9443c01a7336-2a3ee484c7amr30956735ad.33.1767800923436; 
 Wed, 07 Jan 2026 07:48:43 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c47221sm54219005ad.23.2026.01.07.07.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:48:43 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, alexeymin@minlexx.ru,
 danila@jiaxyga.com, david.wronek@mainlining.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v2 1/2] pinctrl: qcom: add PINCTRL_QCOM_GENERIC to enable all
 drivers by default
Date: Wed,  7 Jan 2026 21:17:44 +0530
Message-Id: <20260107154745.571319-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107154745.571319-1-aswin.murugan@oss.qualcomm.com>
References: <20260107154745.571319-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEyMyBTYWx0ZWRfXwDRGmqDsQtmW
 Tkdxe5QORHlwB/wAlEuiHDC8sm4TB8KG5wz/wBEakeGZrVGcL44xBRwajP0Lp0QGHhQQIiJ9CFB
 orCo1GSeD2zGTq37zs4692NMMWteHuh9ffvacrqgcNBbgQlQZtORNXyDQYponIrVgXfdc2rMzN1
 2cUGfFmOABC0jT8qNPpT4NKPpAIsXzgsOjrT/v/SwNGValtSRLR2bi20nALVfjCld1qkAOWWnAZ
 iggetvO+kf6sb8r/bgm6cgKWEKbGV9/xUf1TDfu7kpvymr6X/CTAlyWl8HZN0ffdLkyyAVWIQxU
 42N72QzOjwewGK2dL8GGgv8BbcgcPbpGBb40UgAAItq7vkVc5wPLDfhWAxd9VBM3AO8/bXSZDD/
 aSnX8BDLtM/F7ZSgNkDYfDdPEQEDeVwWLYjzPFzFjNzy4E4iHICU6aI1CyRl8ibzQ1vf4agiKuf
 D3rCPQvb2tXaDptVMcw==
X-Proofpoint-ORIG-GUID: cflBUBG-mdMHp_0XOwGTVj8oMzt4hjsu
X-Authority-Analysis: v=2.4 cv=comWUl4i c=1 sm=1 tr=0 ts=695e805d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=aoq_yZNqJhPG9x-hZ4UA:9 a=ONCtp0Zv864E1lls:21
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: cflBUBG-mdMHp_0XOwGTVj8oMzt4hjsu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070123
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

Introduce a new Kconfig option PINCTRL_QCOM_GENERIC that, when selected,
enables all Qualcomm pinctrl drivers by default. This simplifies defconfigs
for platforms supporting multiple SoCs and avoids manual driver selection.
Individual drivers can still be disabled if required.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v2:
- As per review comments made default y for pinctrl drivers
  based on PINCTRL_QCOM_GENERIC config 'default y if PINCTRL_QCOM_GENERIC' 
---
 drivers/pinctrl/qcom/Kconfig | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 725200d94c8..580308621b1 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -6,8 +6,17 @@ config PINCTRL_QCOM
 
 menu "Qualcomm pinctrl drivers"
 
+config PINCTRL_QCOM_GENERIC
+	bool "Enable all Qualcomm pinctrl drivers by default"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable all Qualcomm pinctrl drivers by default.
+	  This is useful for generic Qualcomm defconfigs that support
+	  multiple SoCs. Individual drivers can still be disabled if needed.
+
 config PINCTRL_QCOM_APQ8016
 	bool "Qualcomm APQ8016 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the MSM8916 / APQ8016
@@ -15,6 +24,7 @@ config PINCTRL_QCOM_APQ8016
 
 config PINCTRL_QCOM_APQ8096
 	bool "Qualcomm APQ8096 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the MSM8996 / APQ8096
@@ -22,6 +32,7 @@ config PINCTRL_QCOM_APQ8096
 
 config PINCTRL_QCOM_IPQ4019
 	bool "Qualcomm IPQ4019 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
@@ -29,6 +40,7 @@ config PINCTRL_QCOM_IPQ4019
 
 config PINCTRL_QCOM_IPQ5424
 	bool "Qualcomm IPQ5424 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the IPQ5424 SoC,
@@ -36,6 +48,7 @@ config PINCTRL_QCOM_IPQ5424
 
 config PINCTRL_QCOM_IPQ9574
 	bool "Qualcomm IPQ9574 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the IPQ9574 SoC,
@@ -43,6 +56,7 @@ config PINCTRL_QCOM_IPQ9574
 
 config PINCTRL_QCOM_QCM2290
 	bool "Qualcomm QCM2290 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon QCM2290 SoC,
@@ -50,6 +64,7 @@ config PINCTRL_QCOM_QCM2290
 
 config PINCTRL_QCOM_QCS404
 	bool "Qualcomm QCS404 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon QCS404 SoC,
@@ -57,6 +72,7 @@ config PINCTRL_QCOM_QCS404
 
 config PINCTRL_QCOM_QCS615
         bool "Qualcomm QCS615 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
         select PINCTRL_QCOM
         help
           Say Y here to enable support for pinctrl on the Snapdragon QCS615 SoC,
@@ -64,6 +80,7 @@ config PINCTRL_QCOM_QCS615
 
 config PINCTRL_QCOM_SA8775P
 	bool "Qualcomm SA8775P Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SA8775P SoC,
@@ -71,12 +88,14 @@ config PINCTRL_QCOM_SA8775P
 
 config PINCTRL_QCOM_SC7280
 	bool "Qualcomm SC7280/QCM6490 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SC7280 SoC,
 
 config PINCTRL_QCOM_SDM670
 	bool "Qualcomm SDM670 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SDM670 SoC,
@@ -84,6 +103,7 @@ config PINCTRL_QCOM_SDM670
 
 config PINCTRL_QCOM_SDM660
 	bool "Qualcomm SDM630/660 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon 630/636/660
@@ -91,6 +111,7 @@ config PINCTRL_QCOM_SDM660
 
 config PINCTRL_QCOM_SDM845
 	bool "Qualcomm SDM845 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon 845 SoC,
@@ -98,6 +119,7 @@ config PINCTRL_QCOM_SDM845
 
 config PINCTRL_QCOM_SM6115
 	bool "Qualcomm SM6115 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM6115 SoC,
@@ -105,12 +127,14 @@ config PINCTRL_QCOM_SM6115
 
 config PINCTRL_QCOM_SM6350
 	bool "Qualcomm SM6350 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM6350 SoC,
 
 config PINCTRL_QCOM_SM7150
 	bool "Qualcomm SM7150 GCC"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM7150 SoC,
@@ -118,6 +142,7 @@ config PINCTRL_QCOM_SM7150
 
 config PINCTRL_QCOM_SM8150
 	bool "Qualcomm SM8150 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8150 SoC,
@@ -125,6 +150,7 @@ config PINCTRL_QCOM_SM8150
 
 config PINCTRL_QCOM_SM8250
 	bool "Qualcomm SM8250 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8250 SoC,
@@ -132,6 +158,7 @@ config PINCTRL_QCOM_SM8250
 
 config PINCTRL_QCOM_SM8550
 	bool "Qualcomm SM8550 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8550 SoC,
@@ -139,6 +166,7 @@ config PINCTRL_QCOM_SM8550
 
 config PINCTRL_QCOM_SM8650
 	bool "Qualcomm SM8650 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8650 SoC,
@@ -146,6 +174,7 @@ config PINCTRL_QCOM_SM8650
 
 config PINCTRL_QCOM_X1E80100
 	bool "Qualcomm X1E80100 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon X1E80100 SoC,
-- 
2.34.1

