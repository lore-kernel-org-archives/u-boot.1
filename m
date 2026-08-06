Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0580C55174
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 02:21:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9836D4054D;
	Thu,  6 Aug 2026 02:21:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1bzsUy9-PFhF; Thu,  6 Aug 2026 02:21:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5FE6E4054C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785982889;
	bh=c7TDJZ+UNiksJ04onXQiXCRroiT819vE0WyP4ZsKh+M=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=AMMUEjghooWCNVpvVYQ8Vd+pAKfl5W5aguG2V9qW2NibqNW0MPsbOi+cZ0fZSSlUW
	 X/kAk/9zvu8BbVHIX8f4ebJVddGXtwgkiaeZgYFgUDtILvj6ZDptcjdZ+llYWVtIe/
	 F+Lk8QiJzKwwQxg9JumSXewM8/JB8rWrAKHT3qv9r5uV1QVVHALQNYu88cuectnRFZ
	 bkiOE4yQBMdDV5gNPy0WbcYmABW3shfO4ZJmwid4ZzEmC22yCSKs6xZRrY5Z/+54hX
	 S/JUJM+ITwMfdDjG9OQWH7OkpOTsUNw0oUTmq7uNSIQo7JISAfW2D1OfRZn/zelB+y
	 BTJYdAnqVLJ9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FE6E4054C;
	Thu,  6 Aug 2026 02:21:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F0283F9
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30F65607FF
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KprZF7xoNsZC for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 02:21:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E0A75606CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E0A75606CE
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0A75606CE
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:26 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675Nbhgd502944
 for <u-boot@lists.u-boot-project.org>; Thu, 6 Aug 2026 02:21:25 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv14wcjbc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 02:21:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbb467e56aaso1835220a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 19:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785982885; x=1786587685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c7TDJZ+UNiksJ04onXQiXCRroiT819vE0WyP4ZsKh+M=;
 b=QwrOU3r/qW+duoizYaep1ArufSgScLX2oiX2PDDL0yl7OHo8k1b1/5ILKnZa1aKW8r
 9pBzwou7yXyLZY95nhtoHrx5tEpZaIpfUo+c8I0XD/ahZI+OWjp5O1k2VCgD1hKO4cDV
 lmp0EPmQ2e9GelCmC1Uevum8WxBj3CweMNpK6rGiwr2wK0c7PaZ0jwNVKSNI8F/NUKAn
 ao+0yJrT7jVP1/ApkfwWcR5xiI/Bq8IZrp1ci0n/Zb8ZGmFvzNT9IburowM8I+U+VAob
 Xg6XQNZXRYz+CW1123LSTF/7F0b6lXLxv5UMP+WYDLcUq+pnC7zBkfFp+sA9DZwzFNgU
 LNXg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNGOdjmE6rQAqPMRqYZQ+7hlfXk+k2f8Gj0D7C41hPjsoSkjVspTlzwzTXQe+0gvlCCzuYHcU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxTZw1DiEfJEii2nLtSczAVqqe7g7N03fpuOqsRHmBqe2v9MjMk
 ki/d0OEMp6Wp+2EJcQqppevEdWR31DyaZVJdtaOzoC4x5qDqxP32tDeD+GwT+FYP/0A5bSvdCC/
 fw3WEaYm+DDFaOdX4MFuW9u4Mcy6MNpkKaPoExSzVnVj5xk10XrPItECbcwE+mdE02rp0uyM=
X-Gm-Gg: AR+sD13S8UTbGTJR4r0/hw3vu8gKUSHPtVoYTGERJhdYHROvB0+6QfTDGiBYPxO8p3d
 foirJtYt+Eefw8p4DlLMGQ0LiFipcW8Hjtb3uVqM6GW0fBDGvLWI5QH4Tq+kGWi8JVJ/MawIpjv
 KBoR7ypd7ouZhcO9qOOkdO1FYoc5WTHGlXOLgJwKaqQ8C2lVYMOKMUV5la809KlRfrPwyMmznwv
 JxpB1DyQW7l2I33RRvH0a3WK/bHXOHXfeMM/FwLwszLvCkix3cuo9vBP3vgkvQN3CWUjyarwf0m
 MQqFXsVKEXH9SihKHaVZ3O3cyjwNgn3O5EFc02PjLPDNch/weQ6XSczim/Kx6qlETXOfoC9cnvg
 gD2qHF7CputetpeilAQbcd6gAo9DAEO2m8CWhDl6Qx7aCt2VtSnpTf4TWEB4m9FH9WaDGEfRfmm
 LlI3J1/ZuQxNIaxryja0qgGzGxg/+f3w==
X-Received: by 2002:a05:6a20:4305:b0:3c3:c080:71ca with SMTP id
 adf61e73a8af0-3cb85bbf50fmr12323802637.0.1785982884417; 
 Wed, 05 Aug 2026 19:21:24 -0700 (PDT)
X-Received: by 2002:a05:6a20:4305:b0:3c3:c080:71ca with SMTP id
 adf61e73a8af0-3cb85bbf50fmr12323753637.0.1785982883929; 
 Wed, 05 Aug 2026 19:21:23 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158673be99sm36385067eec.15.2026.08.05.19.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 19:21:23 -0700 (PDT)
Date: Thu, 06 Aug 2026 07:51:05 +0530
Subject: [PATCH 2/5] phy: Add IPQ9574 support to Qualcomm QUSB2 phy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-fastboot-v1-2-cab7d64e592b@oss.qualcomm.com>
References: <20260806-fastboot-v1-0-cab7d64e592b@oss.qualcomm.com>
In-Reply-To: <20260806-fastboot-v1-0-cab7d64e592b@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 David Lechner <dlechner@baylibre.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAxNiBTYWx0ZWRfX//24enX9/QrM
 xiXcFFxwmI8vnd8E6lHJnHxNnP5gvW5GhKJd4AGQDfOljrlUWgOQjihp8UHHJRHxnBidAUCy5mV
 /K+BkhRTYW8kwmooZz6BEKFvDO+2rFw=
X-Proofpoint-ORIG-GUID: XqKLKFq9OfZZ8i-pAIOXPMkIkoFwr7TT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAxNiBTYWx0ZWRfX3A2lOGxWA3Yw
 LIHL4ygJ8n52aYGdSMWnQez0uX8fbz0i1gImAv1ZS2i7Ko91rQsSuXnumJWOoR8lo05fCfUNJPz
 19Hx4FEEGdDVRHJdJk68qO9KVFPelsn4oGYC8VwFB2ioKEOvqg6POFX0RkmMSvO2oBwNefjy/Ue
 gNTtGy6FwM8ULuM+cZir5WSUcBwUd5LYs1Loa0DXa3BIQ6eikAMqWzEM7tp5nD1uueC/QkLloIa
 Lh0T65EYcl75rqwj6g6ld2nrGuf5ngziQYyo9CvFkxFRAlXKgE/V1t2Btdxm8I0o5B3JZt3jEPN
 DpsWi15GMaI9TmJlOUYlijQIGeVHS5ujqrloO7/p3PLrUn+dBCyoM6yHqjNnN/T4qlunEB4A1K4
 tu/Feiz3kIb3S9YGIpf2+x026r5VR2rUQ3Lz4vLLZKVy3IJJXJ616RwV7DhTt7GttCOrqEtJQ7p
 fV+PaOIT18+gHew3/gw==
X-Proofpoint-GUID: XqKLKFq9OfZZ8i-pAIOXPMkIkoFwr7TT
X-Authority-Analysis: v=2.4 cv=Cu+PtH4D c=1 sm=1 tr=0 ts=6a73efa5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=auydS3RpSOvMw088S5gA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060016
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c7TDJZ+UNiksJ04onXQiXCRroiT819vE0WyP4ZsKh+M=; b=OGzgDh9u57wzjGWS
 CBtOjJmIBv2c7MwHGRzuo70jB70Dtlrfbx1ekxRDyqEwLFE5J4z6awqVZ6FJ27Gj
 R2w0GQqisGnf4QjfSypANUWsQVr7EiR1t4c+GKXXd7YeJMAaCFId7iCATV48lTWJ
 Qrv53G9JGxJkGUZ3u9drFiW95QpRfqVzxH+5OGnBaqM9ZlZQm4lWKbBFZAgGsnY1
 qdEQr1Ew2wPmn6zNLThC1LmBHBrFtlbPPhi31ayZtstePBwH6mKsVAeQJ++iLlU6
 DMk1kpVLRJXz9HCv7umLqBDhT97hYRrzfmWPzegYGWq2RKclciHhX936iDv+avTh
 ANsJ2Q==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785982885; x=1786587685;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c7TDJZ+UNiksJ04onXQiXCRroiT819vE0WyP4ZsKh+M=;
 b=Bx+9JlRN7KjVoqBAJViZPFXrgxzUjT6Xt3OkfW0pw+kUiDKGWLFF0yIFHWFTM/XhVy
 tVsSmRSkKyzGwMX13nogdv1grhVXBwKLlReCNc+JOPThUGW2vifbUcMPfCGK56FSaLJI
 GO2CdbG91APC0LJQsl/17r4Yv+UqjOqanj/rhMxonCHVUiq9X1bqnVUib+EJBSwuEEZf
 SC+K5YIVNoGfE0fLcYh1mebTW/x/89VM4qBUav7n75Xe4t8+gvb/KASd44xWo+kwmQNN
 D7vaBlHeOcLxoEPaT7IpzyeqdeKSYbw7aa4ituFLxwp+6Bx4y43fjkCEfE7rp4uBJx84
 yWug==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=OGzgDh9u; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Bx+9JlRN
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
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Imported from Linux (v7.2-rc4) driver.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/phy/qcom/phy-qcom-qusb2.c | 356 +++++++++++++++++++++++++++++++-------
 1 file changed, 294 insertions(+), 62 deletions(-)

diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
index 6278171b100..7a9cad7cacf 100644
--- a/drivers/phy/qcom/phy-qcom-qusb2.c
+++ b/drivers/phy/qcom/phy-qcom-qusb2.c
@@ -15,81 +15,81 @@
 
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 
-#define QUSB2PHY_PLL 0x0
-#define QUSB2PHY_PLL_TEST 0x04
-#define CLK_REF_SEL BIT(7)
+#define QUSB2PHY_PLL			0x0
+#define QUSB2PHY_PLL_TEST		0x04
+#define CLK_REF_SEL			BIT(7)
 
-#define QUSB2PHY_PLL_TUNE 0x08
-#define QUSB2PHY_PLL_USER_CTL1 0x0c
-#define QUSB2PHY_PLL_USER_CTL2 0x10
-#define QUSB2PHY_PLL_AUTOPGM_CTL1 0x1c
-#define QUSB2PHY_PLL_PWR_CTRL 0x18
+#define QUSB2PHY_PLL_TUNE		0x08
+#define QUSB2PHY_PLL_USER_CTL1		0x0c
+#define QUSB2PHY_PLL_USER_CTL2		0x10
+#define QUSB2PHY_PLL_AUTOPGM_CTL1	0x1c
+#define QUSB2PHY_PLL_PWR_CTRL		0x18
 
 /* QUSB2PHY_PLL_STATUS register bits */
-#define PLL_LOCKED BIT(5)
+#define PLL_LOCKED			BIT(5)
 
 /* QUSB2PHY_PLL_COMMON_STATUS_ONE register bits */
-#define CORE_READY_STATUS BIT(0)
+#define CORE_READY_STATUS		BIT(0)
 
 /* QUSB2PHY_PORT_POWERDOWN register bits */
-#define CLAMP_N_EN BIT(5)
-#define FREEZIO_N BIT(1)
-#define POWER_DOWN BIT(0)
+#define CLAMP_N_EN			BIT(5)
+#define FREEZIO_N			BIT(1)
+#define POWER_DOWN			BIT(0)
 
 /* QUSB2PHY_PWR_CTRL1 register bits */
-#define PWR_CTRL1_VREF_SUPPLY_TRIM BIT(5)
-#define PWR_CTRL1_CLAMP_N_EN BIT(1)
+#define PWR_CTRL1_VREF_SUPPLY_TRIM	BIT(5)
+#define PWR_CTRL1_CLAMP_N_EN		BIT(1)
 
-#define QUSB2PHY_REFCLK_ENABLE BIT(0)
+#define QUSB2PHY_REFCLK_ENABLE		BIT(0)
 
-#define PHY_CLK_SCHEME_SEL BIT(0)
+#define PHY_CLK_SCHEME_SEL		BIT(0)
 
 /* QUSB2PHY_INTR_CTRL register bits */
-#define DMSE_INTR_HIGH_SEL BIT(4)
-#define DPSE_INTR_HIGH_SEL BIT(3)
-#define CHG_DET_INTR_EN BIT(2)
-#define DMSE_INTR_EN BIT(1)
-#define DPSE_INTR_EN BIT(0)
+#define DMSE_INTR_HIGH_SEL			BIT(4)
+#define DPSE_INTR_HIGH_SEL			BIT(3)
+#define CHG_DET_INTR_EN				BIT(2)
+#define DMSE_INTR_EN				BIT(1)
+#define DPSE_INTR_EN				BIT(0)
 
 /* QUSB2PHY_PLL_CORE_INPUT_OVERRIDE register bits */
-#define CORE_PLL_EN_FROM_RESET BIT(4)
-#define CORE_RESET BIT(5)
-#define CORE_RESET_MUX BIT(6)
+#define CORE_PLL_EN_FROM_RESET			BIT(4)
+#define CORE_RESET				BIT(5)
+#define CORE_RESET_MUX				BIT(6)
 
 /* QUSB2PHY_IMP_CTRL1 register bits */
-#define IMP_RES_OFFSET_MASK GENMASK(5, 0)
-#define IMP_RES_OFFSET_SHIFT 0x0
+#define IMP_RES_OFFSET_MASK			GENMASK(5, 0)
+#define IMP_RES_OFFSET_SHIFT			0x0
 
 /* QUSB2PHY_PLL_BIAS_CONTROL_2 register bits */
-#define BIAS_CTRL2_RES_OFFSET_MASK GENMASK(5, 0)
-#define BIAS_CTRL2_RES_OFFSET_SHIFT 0x0
+#define BIAS_CTRL2_RES_OFFSET_MASK		GENMASK(5, 0)
+#define BIAS_CTRL2_RES_OFFSET_SHIFT		0x0
 
 /* QUSB2PHY_CHG_CONTROL_2 register bits */
-#define CHG_CTRL2_OFFSET_MASK GENMASK(5, 4)
-#define CHG_CTRL2_OFFSET_SHIFT 0x4
+#define CHG_CTRL2_OFFSET_MASK			GENMASK(5, 4)
+#define CHG_CTRL2_OFFSET_SHIFT			0x4
 
 /* QUSB2PHY_PORT_TUNE1 register bits */
-#define HSTX_TRIM_MASK GENMASK(7, 4)
-#define HSTX_TRIM_SHIFT 0x4
-#define PREEMPH_WIDTH_HALF_BIT BIT(2)
-#define PREEMPHASIS_EN_MASK GENMASK(1, 0)
-#define PREEMPHASIS_EN_SHIFT 0x0
+#define HSTX_TRIM_MASK				GENMASK(7, 4)
+#define HSTX_TRIM_SHIFT				0x4
+#define PREEMPH_WIDTH_HALF_BIT			BIT(2)
+#define PREEMPHASIS_EN_MASK			GENMASK(1, 0)
+#define PREEMPHASIS_EN_SHIFT			0x0
 
 /* QUSB2PHY_PORT_TUNE2 register bits */
-#define HSDISC_TRIM_MASK GENMASK(1, 0)
-#define HSDISC_TRIM_SHIFT 0x0
+#define HSDISC_TRIM_MASK			GENMASK(1, 0)
+#define HSDISC_TRIM_SHIFT			0x0
 
-#define QUSB2PHY_PLL_ANALOG_CONTROLS_TWO 0x04
-#define QUSB2PHY_PLL_CLOCK_INVERTERS 0x18c
-#define QUSB2PHY_PLL_CMODE 0x2c
-#define QUSB2PHY_PLL_LOCK_DELAY 0x184
-#define QUSB2PHY_PLL_DIGITAL_TIMERS_TWO 0xb4
-#define QUSB2PHY_PLL_BIAS_CONTROL_1 0x194
-#define QUSB2PHY_PLL_BIAS_CONTROL_2 0x198
-#define QUSB2PHY_PWR_CTRL2 0x214
-#define QUSB2PHY_IMP_CTRL1 0x220
-#define QUSB2PHY_IMP_CTRL2 0x224
-#define QUSB2PHY_CHG_CTRL2 0x23c
+#define QUSB2PHY_PLL_ANALOG_CONTROLS_TWO	0x04
+#define QUSB2PHY_PLL_CLOCK_INVERTERS		0x18c
+#define QUSB2PHY_PLL_CMODE			0x2c
+#define QUSB2PHY_PLL_LOCK_DELAY			0x184
+#define QUSB2PHY_PLL_DIGITAL_TIMERS_TWO		0xb4
+#define QUSB2PHY_PLL_BIAS_CONTROL_1		0x194
+#define QUSB2PHY_PLL_BIAS_CONTROL_2		0x198
+#define QUSB2PHY_PWR_CTRL2			0x214
+#define QUSB2PHY_IMP_CTRL1			0x220
+#define QUSB2PHY_IMP_CTRL2			0x224
+#define QUSB2PHY_CHG_CTRL2			0x23c
 
 struct qusb2_phy_init_tbl {
 	unsigned int offset;
@@ -152,6 +152,35 @@ enum qusb2phy_reg_layout {
 		.offset = o, .val = v, .in_layout = 1, \
 	}
 
+static const struct qusb2_phy_init_tbl ipq6018_init_tbl[] = {
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL, 0x14),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xF8),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0xB3),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE3, 0x83),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE4, 0xC0),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_TUNE, 0x30),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL1, 0x79),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL2, 0x21),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE5, 0x00),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TEST2, 0x14),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_TEST, 0x80),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_AUTOPGM_CTL1, 0x9F),
+};
+
+static const unsigned int ipq6018_regs_layout[] = {
+	[QUSB2PHY_PLL_STATUS] = 0x38,
+	[QUSB2PHY_PORT_TUNE1] = 0x80,
+	[QUSB2PHY_PORT_TUNE2] = 0x84,
+	[QUSB2PHY_PORT_TUNE3] = 0x88,
+	[QUSB2PHY_PORT_TUNE4] = 0x8c,
+	[QUSB2PHY_PORT_TUNE5] = 0x90,
+	[QUSB2PHY_PORT_TEST1] = 0x98,
+	[QUSB2PHY_PORT_TEST2] = 0x9c,
+	[QUSB2PHY_PORT_POWERDOWN] = 0xb4,
+	[QUSB2PHY_INTR_CTRL] = 0xbc,
+};
+
 static const struct qusb2_phy_init_tbl sm6115_init_tbl[] = {
 	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xf8),
 	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0x53),
@@ -176,19 +205,6 @@ static const unsigned int sm6115_regs_layout[] = {
 	[QUSB2PHY_PORT_POWERDOWN] = 0xb4, [QUSB2PHY_INTR_CTRL] = 0xbc,
 };
 
-static const unsigned int ipq6018_regs_layout[] = {
-	[QUSB2PHY_PLL_STATUS] = 0x38,
-	[QUSB2PHY_PORT_TUNE1] = 0x80,
-	[QUSB2PHY_PORT_TUNE2] = 0x84,
-	[QUSB2PHY_PORT_TUNE3] = 0x88,
-	[QUSB2PHY_PORT_TUNE4] = 0x8C,
-	[QUSB2PHY_PORT_TUNE5] = 0x90,
-	[QUSB2PHY_PORT_TEST1] = 0x98,
-	[QUSB2PHY_PORT_TEST2] = 0x9C,
-	[QUSB2PHY_PORT_POWERDOWN] = 0xB4,
-	[QUSB2PHY_INTR_CTRL] = 0xBC,
-};
-
 static const struct qusb2_phy_init_tbl msm8996_init_tbl[] = {
 	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xf8),
 	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0xb3),
@@ -250,6 +266,17 @@ static const unsigned int qusb2_v2_regs_layout[] = {
 	[QUSB2PHY_INTR_CTRL] = 0x230,
 };
 
+static const struct qusb2_phy_cfg ipq6018_phy_cfg = {
+	.tbl            = ipq6018_init_tbl,
+	.tbl_num        = ARRAY_SIZE(ipq6018_init_tbl),
+	.regs           = ipq6018_regs_layout,
+
+	.disable_ctrl   = POWER_DOWN,
+	.mask_core_ready = PLL_LOCKED,
+	/* autoresume not used */
+	.autoresume_en   = BIT(0),
+};
+
 static const struct qusb2_phy_cfg msm8996_phy_cfg = {
 	.tbl = msm8996_init_tbl,
 	.tbl_num = ARRAY_SIZE(msm8996_init_tbl),
@@ -310,6 +337,34 @@ static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
 	.update_tune1_with_efuse = true,
 };
 
+/* struct override_param - structure holding qusb2 v2 phy overriding param
+ * set override true if the  device tree property exists and read and assign
+ * to value
+ */
+struct override_param {
+	bool override;
+	u8 value;
+};
+
+/*struct override_params - structure holding qusb2 v2 phy overriding params
+ * @imp_res_offset: rescode offset to be updated in IMP_CTRL1 register
+ * @hstx_trim: HSTX_TRIM to be updated in TUNE1 register
+ * @preemphasis: Amplitude Pre-Emphasis to be updated in TUNE1 register
+ * @preemphasis_width: half/full-width Pre-Emphasis updated via TUNE1
+ * @bias_ctrl: bias ctrl to be updated in BIAS_CONTROL_2 register
+ * @charge_ctrl: charge ctrl to be updated in CHG_CTRL2 register
+ * @hsdisc_trim: disconnect threshold to be updated in TUNE2 register
+ */
+struct override_params {
+	struct override_param imp_res_offset;
+	struct override_param hstx_trim;
+	struct override_param preemphasis;
+	struct override_param preemphasis_width;
+	struct override_param bias_ctrl;
+	struct override_param charge_ctrl;
+	struct override_param hsdisc_trim;
+};
+
 /**
  * struct qusb2_phy - structure holding qusb2 phy attributes
  *
@@ -317,6 +372,8 @@ static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
  * @base: iomapped memory space for qubs2 phy
  *
  * @cfg_ahb_clk: AHB2PHY interface clock
+ * @ref_clk: phy reference clock
+ * @iface_clk: phy interface clock
  * @phy_rst: phy reset control
  *
  * @cfg: phy config data
@@ -327,12 +384,56 @@ struct qusb2_phy {
 	void __iomem *base;
 
 	struct clk cfg_ahb_clk;
+	struct clk ref_clk;
+	struct clk iface_clk;
 	struct reset_ctl phy_rst;
 
+	struct override_params overrides;
+
 	const struct qusb2_phy_cfg *cfg;
 	bool has_se_clk_scheme;
+	bool phy_initialized;
+	enum phy_mode mode;
 };
 
+static inline void qusb2_write_mask(void __iomem *base, u32 offset,
+				    u32 val, u32 mask)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg &= ~mask;
+	reg |= val & mask;
+	writel(reg, base + offset);
+
+	/* Ensure above write is completed */
+	readl(base + offset);
+}
+
+static inline void qusb2_setbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg |= val;
+	writel(reg, base + offset);
+
+	/* Ensure above write is completed */
+	readl(base + offset);
+}
+
+static inline void qusb2_clrbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg &= ~val;
+	writel(reg, base + offset);
+
+	/* Ensure above write is completed */
+	readl(base + offset);
+}
+
 static inline void qusb2_phy_configure(void __iomem *base,
 				       const unsigned int *regs,
 				       const struct qusb2_phy_init_tbl tbl[],
@@ -348,6 +449,68 @@ static inline void qusb2_phy_configure(void __iomem *base,
 	}
 }
 
+/*
+ * Update board specific PHY tuning override values if specified from
+ * device tree.
+ */
+static void qusb2_phy_override_phy_params(struct qusb2_phy *qphy)
+{
+	const struct qusb2_phy_cfg *cfg = qphy->cfg;
+	struct override_params *or = &qphy->overrides;
+
+	if (or->imp_res_offset.override)
+		qusb2_write_mask(qphy->base, QUSB2PHY_IMP_CTRL1,
+		or->imp_res_offset.value << IMP_RES_OFFSET_SHIFT,
+			     IMP_RES_OFFSET_MASK);
+
+	if (or->bias_ctrl.override)
+		qusb2_write_mask(qphy->base, QUSB2PHY_PLL_BIAS_CONTROL_2,
+		or->bias_ctrl.value << BIAS_CTRL2_RES_OFFSET_SHIFT,
+			   BIAS_CTRL2_RES_OFFSET_MASK);
+
+	if (or->charge_ctrl.override)
+		qusb2_write_mask(qphy->base, QUSB2PHY_CHG_CTRL2,
+		or->charge_ctrl.value << CHG_CTRL2_OFFSET_SHIFT,
+			     CHG_CTRL2_OFFSET_MASK);
+
+	if (or->hstx_trim.override)
+		qusb2_write_mask(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE1],
+		or->hstx_trim.value << HSTX_TRIM_SHIFT,
+				 HSTX_TRIM_MASK);
+
+	if (or->preemphasis.override)
+		qusb2_write_mask(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE1],
+		or->preemphasis.value << PREEMPHASIS_EN_SHIFT,
+				PREEMPHASIS_EN_MASK);
+
+	if (or->preemphasis_width.override) {
+		if (or->preemphasis_width.value ==
+		    QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT)
+			qusb2_setbits(qphy->base,
+				      cfg->regs[QUSB2PHY_PORT_TUNE1],
+				      PREEMPH_WIDTH_HALF_BIT);
+		else
+			qusb2_clrbits(qphy->base,
+				      cfg->regs[QUSB2PHY_PORT_TUNE1],
+				      PREEMPH_WIDTH_HALF_BIT);
+	}
+
+	if (or->hsdisc_trim.override)
+		qusb2_write_mask(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE2],
+		or->hsdisc_trim.value << HSDISC_TRIM_SHIFT,
+				 HSDISC_TRIM_MASK);
+}
+
+static int qusb2_phy_set_mode(struct phy *phy,
+			      enum phy_mode mode, int submode)
+{
+	struct qusb2_phy *qphy = dev_get_priv(phy->dev);
+
+	qphy->mode = mode;
+
+	return 0;
+}
+
 static int qusb2phy_do_reset(struct qusb2_phy *qphy)
 {
 	int ret;
@@ -387,6 +550,9 @@ static int qusb2phy_power_on(struct phy *phy)
 
 	qusb2_phy_configure(qphy->base, cfg->regs, cfg->tbl, cfg->tbl_num);
 
+	/* Override board specific PHY tuning values */
+	qusb2_phy_override_phy_params(qphy);
+
 	/* Enable the PHY */
 	clrbits_le32(qphy->base + cfg->regs[QUSB2PHY_PORT_POWERDOWN],
 		     POWER_DOWN);
@@ -401,6 +567,12 @@ static int qusb2phy_power_on(struct phy *phy)
 	 */
 	qphy->has_se_clk_scheme = cfg->se_clk_scheme_default;
 
+	if (!qphy->has_se_clk_scheme) {
+		ret = clk_enable(&qphy->ref_clk);
+		if (ret)
+			return ret;
+	}
+
 	if (cfg->has_pll_test) {
 		if (!qphy->has_se_clk_scheme)
 			val &= ~CLK_REF_SEL;
@@ -437,6 +609,8 @@ static int qusb2phy_power_off(struct phy *phy)
 	reset_assert(&qphy->phy_rst);
 
 	clk_disable(&qphy->cfg_ahb_clk);
+	clk_disable(&qphy->ref_clk);
+	clk_disable(&qphy->iface_clk);
 
 	return 0;
 }
@@ -454,6 +628,22 @@ static int qusb2phy_clk_init(struct udevice *dev, struct qusb2_phy *qphy)
 	if (ret)
 		return ret;
 
+	ret = clk_get_by_name(dev, "ref", &qphy->ref_clk);
+	if (ret == -ENOSYS || ret == -ENOENT)
+		return 0;
+	if (ret)
+		return ret;
+
+	ret = clk_get_by_name(dev, "iface", &qphy->iface_clk);
+	if (ret == -ENOSYS || ret == -ENOENT)
+		return 0;
+	if (ret)
+		return ret;
+
+	ret = clk_enable(&qphy->iface_clk);
+	if (ret)
+		return ret;
+
 	ret = clk_enable(&qphy->cfg_ahb_clk);
 	if (ret)
 		return ret;
@@ -464,6 +654,8 @@ static int qusb2phy_clk_init(struct udevice *dev, struct qusb2_phy *qphy)
 static int qusb2phy_probe(struct udevice *dev)
 {
 	struct qusb2_phy *qphy = dev_get_priv(dev);
+	struct override_params *or;
+	u32 value;
 	int ret;
 
 	qphy->base = (void __iomem *)dev_read_addr(dev);
@@ -488,6 +680,43 @@ static int qusb2phy_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
+	or = &qphy->overrides;
+
+	if (!dev_read_u32(dev, "qcom,imp-res-offset-value", &value)) {
+		or->imp_res_offset.value = (u8)value;
+		or->imp_res_offset.override = true;
+	}
+
+	if (!dev_read_u32(dev, "qcom,bias-ctrl-value", &value)) {
+		or->bias_ctrl.value = (u8)value;
+		or->bias_ctrl.override = true;
+	}
+
+	if (!dev_read_u32(dev, "qcom,charge-ctrl-value", &value)) {
+		or->charge_ctrl.value = (u8)value;
+		or->charge_ctrl.override = true;
+	}
+
+	if (!dev_read_u32(dev, "qcom,hstx-trim-value", &value)) {
+		or->hstx_trim.value = (u8)value;
+		or->hstx_trim.override = true;
+	}
+
+	if (!dev_read_u32(dev, "qcom,preemphasis-level", &value)) {
+		or->preemphasis.value = (u8)value;
+		or->preemphasis.override = true;
+	}
+
+	if (!dev_read_u32(dev, "qcom,preemphasis-width", &value)) {
+		or->preemphasis_width.value = (u8)value;
+		or->preemphasis_width.override = true;
+	}
+
+	if (!dev_read_u32(dev, "qcom,hsdisc-trim-value", &value)) {
+		or->hsdisc_trim.value = (u8)value;
+		or->hsdisc_trim.override = true;
+	}
+
 	debug("%s success qusb phy cfg %p\n", __func__, qphy->cfg);
 	return 0;
 }
@@ -495,6 +724,7 @@ static int qusb2phy_probe(struct udevice *dev)
 static struct phy_ops qusb2phy_ops = {
 	.power_on = qusb2phy_power_on,
 	.power_off = qusb2phy_power_off,
+	.set_mode = qusb2_phy_set_mode,
 };
 
 static const struct udevice_id qusb2phy_ids[] = {
@@ -507,6 +737,8 @@ static const struct udevice_id qusb2phy_ids[] = {
 	  .data = (ulong)&qcs615_phy_cfg },
 	{ .compatible = "qcom,sdm660-qusb2-phy",
 	  .data = (ulong)&sdm660_phy_cfg },
+	{ .compatible = "qcom,ipq9574-qusb2-phy",
+	  .data = (ulong)&ipq6018_phy_cfg },
 	{ .compatible = "qcom,sm6115-qusb2-phy",
 	  .data = (ulong)&sm6115_phy_cfg },
 	{ .compatible = "qcom,qusb2-v2-phy", .data = (ulong)&qusb2_v2_phy_cfg },

-- 
2.34.1

