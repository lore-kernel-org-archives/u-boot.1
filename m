Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BF0D1269D
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 11:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DAA283F6C;
	Wed,  3 Dec 2025 12:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jZut2fmg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IgTJiBEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3C4883F39; Wed,  3 Dec 2025 12:08:06 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DEAA83F85
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 12:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3B3DCW1374603
 for <u-boot@lists.denx.de>; Wed, 3 Dec 2025 11:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8B3q+Opee8F
 AzBokShhJJZPa7BYAKTBe1aL/WRpBPeQ=; b=jZut2fmgOXEEM7DOSWatlNvNN42
 NZX8BlZ7LEbuoSvnjkxcZ8P9wSffpQNQNhHCXsROeLqrAJLu7DsIgCk6Jg0aJm7r
 5POMhMOH8BCDXiv0aiTIHhNWiKxzo3dV7xVOFa39Pvy6ZzIL4/J5MNtjKCatiaLb
 brmVv9Sl9Fwv/ajXCFTg8E4BmnkRmc09svLTdza8Bn6WULjolcPtblxDUXXYUgMY
 tHQLg3hKavP/qPXvA7ErqfpxZWnHpeCeRGlR0nBVtr4Oko2zZX+iwC3soaOINhnQ
 toDzFuRwOFEPZB+rHg4tG+ZK8aZ3sCiToFskgPDOZx5CY1raTU/0FQ3dmOQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atm0b80h6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 11:08:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-299ddb0269eso80006175ad.0
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 03:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764760082; x=1765364882; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8B3q+Opee8FAzBokShhJJZPa7BYAKTBe1aL/WRpBPeQ=;
 b=IgTJiBEaysFIvrcAayEGqk5HWYPzktFnOdqoOM9+px7w1voZTPTHvxR9YWKBOkIGZr
 khby4cuOrBmL1MnkfmCNf/KoqSwzd8awX3Px7wnrlDGoWOZkPkij2t9Ejt6B8U64DPWK
 n3ztFCRZW0XGhgDs3pyRmzQu/RPnAlIFIwux6mzZeYAFkQVOHcAqe8eXUaKGkBxjWwCJ
 /WgPNBFcRLEYg5JvKAFDfq08AqWK5r0TLLBFN7bPO/PdFaTh78sja5/j9voWx3ZAsetb
 ch6keE5i1PN4ZCgo4OXWqWSwpPZZOcEsTMCawLkVCD1A7Gsu7ebXQUezy4rOHf9Ozww7
 F2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764760082; x=1765364882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8B3q+Opee8FAzBokShhJJZPa7BYAKTBe1aL/WRpBPeQ=;
 b=iZJsO8BcZmL//c8Z2UmLdhtl77HfaC9XqtGYnrkuuKZMkoMQY6xXspLXYjHI4GOsUR
 o9n9RQzBz5N9s9kq81+MdJEfTe3r40ggXSCo92jBTf/fFWS07O33I5TSiK32dMEdqNyS
 sJ7td1h6u9WouXFREpvxojwOmk6V978xd93jGxrk9RgYTSF8hTEOTczPlj3FzGFH8NjG
 h9iSRUby90Hq7LTtRXRdRoF9G4P+FhJ+5FOnwGMpYhHD/dkc6nhlVJk7QIlPYFcBUeK8
 GeCj4W6ZxkYHg3DHhcu0UoSRI0QpFhIcfknb1THBwaAi5Lvfgtiuox9yH1HZXhz7IbGB
 DKcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiDPzzUebOqGTve2qSL3rB594bC7M4L722aZJOxuyHzXlA7dzd14VhDA8+8ocqhmtSwFmE70U=@lists.denx.de
X-Gm-Message-State: AOJu0YycXThwDEpzq/WMCIlOCeT9F4SCFxQ2hs7aD9v3D2tJtCxostWh
 Qn5pIULEWnoC7QaKmFYxr2hcMuR6buHT/YkVtzq+6f/bTzNnIO1YWu1vdUYgcp4UT5RY3oaITV9
 hoqnTadtIargIslVlzGmkHhn3xdAvXhrJFZvUe5+rLQSI8dAidkwuAZ/E
X-Gm-Gg: ASbGncuE/IxX2dr2JDjAQ0OF1WaVuM/bxBWwuaGt4+K9E8YCCrkkjOGy/gU4lxbModL
 3CaJzaccZbV6wLGx3VOXcLBWRob1Tm+yD/+JZrsiZgrYHWa6XyTvKMQE3ydZ61jmZPkpsfGVB+p
 FJ2WHVcQCOoPY4l+GCqi03PmaC9VhfUaJmhAEmWmTmO+gq5NMBjVS6dDsACftuUgwaqy/y0R7Nr
 qa2oXiOG32JuEJ3o3TxUfvM55xWysVtvPMAuBQR3en9PfGfm5LcXKHi8YSXE38CZQeWU8FNCr/N
 v4HynmlG6tWJp5WEn72Vc1Ys2npxiicQa+JEzXoL6kH6hMQzh8Hjwf8uzvdL1hc1UDK1HaDqLLE
 dILRBQCrrgs9yDv1/nDKW2KXycx2yw14XGdwc0who32NZifIljTQwRLegQ1ZJHXRohP9Q/ld6v1
 2XQigajsT6mYEaR9LiivkyUyqlGuC1NYa5mVtvwA==
X-Received: by 2002:a17:902:e790:b0:295:3e80:9aa4 with SMTP id
 d9443c01a7336-29d68317c87mr22760735ad.22.1764760081857; 
 Wed, 03 Dec 2025 03:08:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKasENi8yfOUIDTGz+g1Bw4zTnuh0DGm2K/KwcGl3yzd44IoGxTLS+LXPo/O9ENqhhJH4tRA==
X-Received: by 2002:a17:902:e790:b0:295:3e80:9aa4 with SMTP id
 d9443c01a7336-29d68317c87mr22760215ad.22.1764760081213; 
 Wed, 03 Dec 2025 03:08:01 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29d7b6ba774sm10132925ad.83.2025.12.03.03.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 03:08:00 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, vasileios.bimpikas@analog.com,
 utsav.agarwal@analog.com, arturs.artamonovs@analog.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 kory.maincent@bootlin.com, patrice.chotard@foss.st.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 alif.zakuan.yuslaimi@altera.com, hs@nabladev.com, rui.silva@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 2/6] drivers: usb: dwc3: Add delay after core soft reset
Date: Wed,  3 Dec 2025 16:37:31 +0530
Message-Id: <20251203110735.1959862-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GMMF0+NK c=1 sm=1 tr=0 ts=69301a12 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=cPnCvOdxr6JbFHfFCUIA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: d_LrAFyYuVbxYOUH0f_VCb6wqT3BJLm7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA4NyBTYWx0ZWRfX/5Tgyw5cxECy
 GYhnSHj5fGn3xTfSkERWOscPhCvuAgW8VAK+7MB8ye6MlM9AU2oe1C3wfQupMWzBIGJgb1PryBV
 GwR7QylgiW2jlfMFRcfxz234q+MYWbyFyF5E/z+Gfcj9iIIEc8gNP5yS+xmhcm3oQMyKW1BYUFd
 CZtrxHZBpWAg0iIHjGq85Lwhg0av/yNkim7U2XWZUWwyVy8ucm+r47vqY37BveJ/vUB4oNoE4mw
 m3EHCPRuYHfHeDKQl1V4CQRDcMRBwPJOZpz6AvuvNyrJ0NWx5iHgCgy1gDtbdYnCUVi/jxS+FA7
 aOrQpJ3ZFpCkz3oxl1tYAic2B1rBJVxBD2jf+mIHZhroOPtt32AeVkPBEU3ui93L+8LGMiWJwNv
 7r0eCL10JWVCRJdwG3JcP9DSXh+61Q==
X-Proofpoint-GUID: d_LrAFyYuVbxYOUH0f_VCb6wqT3BJLm7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512030087
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

Add a 100 ms delay after clearing the core soft reset bit to ensure
the DWC3 controller has sufficient time to complete its reset
sequence before subsequent register accesses.

Without this delay, USB initialization can fail on some Qualcomm
platforms, particularly when using super-speed capable PHYs like
the QMP USB3-DP Combo PHY on SC7280/QCM6490.

Taken from Linux commit f88359e1588b ("usb: dwc3: core: Do core softreset when switch mode")

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v2:
- Gave correct commit id for linux implementation
---
 drivers/usb/dwc3/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 847fa1f82c3..ff0bca0dd8e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -94,6 +94,8 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	reg &= ~DWC3_GCTL_CORESOFTRESET;
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 
+	mdelay(100);
+
 	return 0;
 }
 
-- 
2.34.1

