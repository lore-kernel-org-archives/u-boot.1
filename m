Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E6AE6749C
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 11:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C05683C28;
	Mon, 22 Dec 2025 12:52:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jnch6ngS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZjTPxx4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93C9283EE2; Mon, 22 Dec 2025 12:52:19 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C3583981
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BM8O2VX3913339
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ylbS7AhbUqI
 tNGle/PWSFG52EqggMmVC3K6ZNUMCoMQ=; b=jnch6ngSge7bJwP8/v4RWaplp88
 Q7c4rTNg1lB1F1t6jV0kv30lAiEgp6ckDbe5iP9qCLad4pLiRa3B9Qe1VpyIGDPZ
 3jE/Ei+64q3CLR59b/1VlcQy2nE4rAI+oh4TXrVYrdG4LOlK84q/ND1G/PkGhAV/
 CTheRbFoPsyMSvBYjz8/p3bR2JdBD80rlgn1j4dgBCqPdAxdn+kTC3ATct5HQoot
 wQKB7yS8b0EJKGmcw9+befjiHv8GhNHY2UrS7KfrRrHjC9mA8k2YX/WAES3q0OmC
 S84oE7nAPdk7lDpJlzxMkAXo6VD9hq2fYd8mbTBSN32WCPYGNYo/QLXa0WA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mry4tsa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:52:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a0dabc192eso85884505ad.0
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 03:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766404334; x=1767009134; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ylbS7AhbUqItNGle/PWSFG52EqggMmVC3K6ZNUMCoMQ=;
 b=ZjTPxx4+4q+/weUSXKtck20GAh81VGHgVvufShtTMkUtHuknmOZuDM+YzHfo+3ctSa
 K3KcQIvpnCmb4In4LrE6x8QGIQz9REDlLddrkAa6pUze3YpQojiFg0GAk+60NiVmFTQA
 6wZHW5fN2mK5DcOukSgsh/bGFk7OuhPGbUz+0RwkrALrOVJBY18o40KZeSwgqSpkhQ/m
 itVtAogV/+Y1hUPiRwSHmGT3gvOFvJ8oZahw0zYnDgjzp9qECoA2NKHYQGnqN85Q20Kf
 nXJy31MSqGEZaHcskz7lznT+BHtiQN4PJ0wuE/xppafDTa4biVs9SZILx6i8OF+0LxDz
 FlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766404334; x=1767009134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ylbS7AhbUqItNGle/PWSFG52EqggMmVC3K6ZNUMCoMQ=;
 b=n0y/pDO44qHr2UkFTRNN88rT3Xr7c5Eb79SZM6cY1RHhzofr8rogUA1NuPPDC3uPa/
 ls5T0L6qxqILlMB+jKXKRaz3TLDn9LBe6ErK0RfZbEY6qCskFO3Str3mahzs9nvochcI
 UAcp6or23bvE9Q0yPgP0E61x3J0bPRF2k7k2sPmN2tgUu/RqQe3LklAnmk07ea8XXmDA
 +uK6lzQErv4H2G005RWoMKAfjZiraoaWLwIDq8J8logY9yTa0nX56yMBz98avBLZqZfd
 V9kQg1CxQbsNkdNV90ZV8/hzRNWI7Sg5mgFIUVYS7wmeqnbe0Q2W7KauyhxYTIoMNOjq
 t8RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0KEPZPT7ua+RRUsJZ0M1Ef+wY8rTRG6JT7ZeSLzO+jGligoNzHfjTmLk2DamR/IYco+4kwR4=@lists.denx.de
X-Gm-Message-State: AOJu0YxkLz40J/v5fXi17X5cptiQokB8FiCMImekQ/cZUi6F96Uvx/S4
 hEs8qeWXTNbgAzD9H3gjRFbQMzYoQcEvQnLodVpEo+1gLZGnu2W4wNLb0koLJmZVbOgwTjevVpw
 0AT/A8zeE8oRpbeOsDfCEySfT+fgdUbVXY0JzBgRg5KFMrsANp9IYeELF
X-Gm-Gg: AY/fxX6OA5OvMmLthiv9nTzah8BE7t66C+fut2TDiqQCkyPcrfyTYHnNnEYOK0Vc8ch
 CqBUA/tQlu2+E0D5vl5fZ0d7k+eX6/uZf5Z4QqeIMkac/bRkfSgQ8Xa0TIqTANajncrQJ8imImc
 Rx9jtdkAmWeE3on2uHHVOZhRc5IRSbAMESo8ifwUPq0/a0XDwhg+dv+QpgHXVy3/eX0RaNJ68iq
 pbuO8Vukvx72eEVGuWwFKVr/67HBByzjlNFyA8Wci4ci3CvF63yKPbM8AzXSWVsTGm8t4yRR8zg
 jsQYxmWJLruTyUDWZstFmvEx8jUHDvPMb9qLP4IQ+kwp4GxrLTs2jLMuLkhty/MA8KT6YEXo3zy
 NtXTP5o1AI7NUViQE3BZYTnDlOjdvAAXBI2lk9Alw7UE5hGqKVkgGFWQooyHyWGbTDl3rF9AC/D
 n/YJHdJsdWpv6oyNuC54U/RAHdcsbj
X-Received: by 2002:a17:902:d481:b0:2a1:e19:ff4 with SMTP id
 d9443c01a7336-2a2f272b102mr102657925ad.29.1766404334248; 
 Mon, 22 Dec 2025 03:52:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR9+Kjnn8XpFeLB+QILL3VdZ4qd/dc69N4UjFusRgsyUm5Fx5C6NNGX70BuBWw8jkPn6oppA==
X-Received: by 2002:a17:902:d481:b0:2a1:e19:ff4 with SMTP id
 d9443c01a7336-2a2f272b102mr102657755ad.29.1766404333762; 
 Mon, 22 Dec 2025 03:52:13 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d20dsm96656055ad.67.2025.12.22.03.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 03:52:13 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, alexeymin@postmarketos.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v1 1/2] pinctrl: qcom: Make pinctrl drivers default y based on
 architecture
Date: Mon, 22 Dec 2025 17:21:43 +0530
Message-Id: <20251222115144.2146964-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251222115144.2146964-1-aswin.murugan@oss.qualcomm.com>
References: <20251222115144.2146964-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cbbfb3DM c=1 sm=1 tr=0 ts=694930ef cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=k-42gJp3AAAA:8 a=EUspDBNiAAAA:8 a=OjvXJ0Nzbs2VJeBY9bQA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwNyBTYWx0ZWRfXwMZGEQngSrC+
 5/GmaB/o7LKQkaBR0uYKY3qQ6mHbiXFesfWvW1/Fd4x+JE67vVXkUzxkDehfQtuROyMWwnH5T9P
 SoRMIuEsTtbL5/JFXXUttiIEeItVSeLg8WTQspp9nNKIlHSu1EU/MkVN41rPOKs9+8Hi+50WZU+
 OxnrVro14tnYVYp+Yg1EjlSG9S7q1WZi1/bfwmuENdi7tx4iBqAXEiQv67Sadlrl+1umrG8wtlA
 4Pm4VDN/zlck5x5xfydpQUAnALOgmgBCOYDNCfdP2hPTaFvtb8xgot42GUBwuukdyEWSW6AQy62
 t6MN4n4txpMEqEOAwr4w2kuEcRJCK/gkSMeYqtmye1BzNmdCu/iYpYm/n6mXe4ytzxcxSUWlqId
 BszYDcdDzBIDCATfHMJv3TiHzsrWlPtwl3rAh/1UfgwvlQvDcHsyriLV0gBfDvJLCJmWt/6bwWC
 Sw+dkBD9jZ8om4x4gAA==
X-Proofpoint-GUID: 8S-Eph9Ho68btw9o-tWst4pCP4BFBpWA
X-Proofpoint-ORIG-GUID: 8S-Eph9Ho68btw9o-tWst4pCP4BFBpWA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220107
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

All Qualcomm pinctrl drivers are already within a menu conditional on
ARCH_SNAPDRAGON || ARCH_IPQ40XX. Make them default y based on the
appropriate architecture to avoid having to manually enable each driver
in defconfig files.

Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 725200d94c8..283ca3c8813 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -8,6 +8,7 @@ menu "Qualcomm pinctrl drivers"
 
 config PINCTRL_QCOM_APQ8016
 	bool "Qualcomm APQ8016 Pinctrl"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the MSM8916 / APQ8016
@@ -15,6 +16,7 @@ config PINCTRL_QCOM_APQ8016
 
 config PINCTRL_QCOM_APQ8096
 	bool "Qualcomm APQ8096 Pinctrl"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the MSM8996 / APQ8096
@@ -22,6 +24,7 @@ config PINCTRL_QCOM_APQ8096
 
 config PINCTRL_QCOM_IPQ4019
 	bool "Qualcomm IPQ4019 Pinctrl"
+	default y if ARCH_IPQ40XX
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
@@ -29,6 +32,7 @@ config PINCTRL_QCOM_IPQ4019
 
 config PINCTRL_QCOM_IPQ5424
 	bool "Qualcomm IPQ5424 Pinctrl"
+	default y if ARCH_IPQ40XX
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the IPQ5424 SoC,
@@ -36,6 +40,7 @@ config PINCTRL_QCOM_IPQ5424
 
 config PINCTRL_QCOM_IPQ9574
 	bool "Qualcomm IPQ9574 Pinctrl"
+	default y if ARCH_IPQ40XX
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the IPQ9574 SoC,
@@ -43,6 +48,7 @@ config PINCTRL_QCOM_IPQ9574
 
 config PINCTRL_QCOM_QCM2290
 	bool "Qualcomm QCM2290 Pinctrl"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon QCM2290 SoC,
@@ -50,6 +56,7 @@ config PINCTRL_QCOM_QCM2290
 
 config PINCTRL_QCOM_QCS404
 	bool "Qualcomm QCS404 Pinctrl"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon QCS404 SoC,
@@ -57,6 +64,7 @@ config PINCTRL_QCOM_QCS404
 
 config PINCTRL_QCOM_QCS615
         bool "Qualcomm QCS615 Pinctrl"
+        default y if ARCH_SNAPDRAGON
         select PINCTRL_QCOM
         help
           Say Y here to enable support for pinctrl on the Snapdragon QCS615 SoC,
@@ -64,6 +72,7 @@ config PINCTRL_QCOM_QCS615
 
 config PINCTRL_QCOM_SA8775P
 	bool "Qualcomm SA8775P Pinctrl"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SA8775P SoC,
@@ -71,12 +80,14 @@ config PINCTRL_QCOM_SA8775P
 
 config PINCTRL_QCOM_SC7280
 	bool "Qualcomm SC7280/QCM6490 Pinctrl"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SC7280 SoC,
 
 config PINCTRL_QCOM_SDM670
 	bool "Qualcomm SDM670 Pinctrl"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SDM670 SoC,
@@ -84,6 +95,7 @@ config PINCTRL_QCOM_SDM670
 
 config PINCTRL_QCOM_SDM660
 	bool "Qualcomm SDM630/660 Pinctrl"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon 630/636/660
@@ -91,6 +103,7 @@ config PINCTRL_QCOM_SDM660
 
 config PINCTRL_QCOM_SDM845
 	bool "Qualcomm SDM845 Pinctrl"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon 845 SoC,
@@ -98,6 +111,7 @@ config PINCTRL_QCOM_SDM845
 
 config PINCTRL_QCOM_SM6115
 	bool "Qualcomm SM6115 Pinctrl"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM6115 SoC,
@@ -105,12 +119,14 @@ config PINCTRL_QCOM_SM6115
 
 config PINCTRL_QCOM_SM6350
 	bool "Qualcomm SM6350 Pinctrl"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM6350 SoC,
 
 config PINCTRL_QCOM_SM7150
 	bool "Qualcomm SM7150 GCC"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM7150 SoC,
@@ -118,6 +134,7 @@ config PINCTRL_QCOM_SM7150
 
 config PINCTRL_QCOM_SM8150
 	bool "Qualcomm SM8150 Pinctrl"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8150 SoC,
@@ -125,6 +142,7 @@ config PINCTRL_QCOM_SM8150
 
 config PINCTRL_QCOM_SM8250
 	bool "Qualcomm SM8250 Pinctrl"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8250 SoC,
@@ -132,6 +150,7 @@ config PINCTRL_QCOM_SM8250
 
 config PINCTRL_QCOM_SM8550
 	bool "Qualcomm SM8550 Pinctrl"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8550 SoC,
@@ -139,6 +158,7 @@ config PINCTRL_QCOM_SM8550
 
 config PINCTRL_QCOM_SM8650
 	bool "Qualcomm SM8650 Pinctrl"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SM8650 SoC,
@@ -146,6 +166,7 @@ config PINCTRL_QCOM_SM8650
 
 config PINCTRL_QCOM_X1E80100
 	bool "Qualcomm X1E80100 Pinctrl"
+	default y if ARCH_SNAPDRAGON
 	select PINCTRL_QCOM
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon X1E80100 SoC,
-- 
2.34.1

