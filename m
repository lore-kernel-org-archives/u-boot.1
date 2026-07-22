Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD4DC4453E
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F51D80DC1;
	Wed, 22 Jul 2026 07:43:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 82--CgNiln2B; Wed, 22 Jul 2026 07:43:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D7D480D82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784706187;
	bh=15IYHa1YNbRjLAfe1c8m9UFgxktBG9UiRTJh0uMQi2c=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YVBm40Bg2uVR1bQrxiIp41xTPA5btIVfHN45eCIh01KRn3xUIUSA88dEtkAg5nOdk
	 8bR6cBxWz5RMpYjM+6GbgTN1Rl+ihxZSV/myUyzOafOzeEN8klqkNs04Ds4B/UttXr
	 H6kr42YCR5TuZjo91Gr5u7zHeYwGPwkZTcs7GYT/SKP+Z5seqqCKClzBf6/co0eIG8
	 dqK89Eq4Amaa/A4fmPjibat4hFyl+wOMxmx4MOcuaX0c3j8PLgIof/oW3gCQ8eSNqD
	 AKs28kZ4eax5lzW8eEU0n4bE+6r+GWd01IwI11kG731Z2MdkHCNIu+eYUoC684PCI/
	 II5zz3uyxoyGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D7D480D82;
	Wed, 22 Jul 2026 07:43:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B99D642A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 20E9080D82
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x3boTVKlVXmC for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:43:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E87DE80D7C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E87DE80D7C
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E87DE80D7C
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:04 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53bhO4054875
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:03 GMT
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjpxdgpq6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cca3673560so211765925ad.1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706182; x=1785310982;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=15IYHa1YNbRjLAfe1c8m9UFgxktBG9UiRTJh0uMQi2c=;
 b=ddz1DMb6RJRfcWtz+HwzzCZsEYDXFkyo5/CIubVmsjOquZRJhDE7coabnC7Z6KMGDw
 WvWHS/tAKUuz9Y0q+UQ4W/FHHVG/kUXj1Qyha6OAsycOw1lszKucxqLpamP0Qad0tRNQ
 1oQy6ytkUCopu6/XppymV/yeYylBa+9XpYWU4B3et1yuZlOkZZ50GI+JManpqcOaOogJ
 cgTrhwJhA/aSf85P+O7WghFO1xcv5uirYLbyjTM7abyCFVzJlOEYpfyvbOK0/BJmey2Y
 LT7aYyl6spnyfJAOJuT5x7P1GUUQXTkBpeOnotXglXpm7156BJp8846g8/h6fuqfW2P8
 6TMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoD3xUkcYYqhlTt3E2aqy7cd7xa3T0fuevxm5NwbU5ky10yTOPdprsUZHPO6Ud/wV88iikcCcU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwCAASLlke34STuoN0qj0Wn8JoP8ucSQ97ucFSPMMIXOc6tAYNz
 DZoPXlwXIStrMtZc6RblULsdTUaEFJ6KM06aBKVK3mcxSMn+YQroZ9BepI57JQdXfhFZGv364N0
 8RW7IvQF26UvN1M0nSIUck4zkZpSh2mswpLRGs7KJsL2T119u/RzvwY0iBH7mIaUu/6MQ9MA=
X-Gm-Gg: AR+sD12NDOhlt0c2ZwY0LCf5PW6/UPDm3eTSwKTXNMa94qi62hRZtbhggohQzfGBeNM
 CvMW90uhox+0mrQswdJ7rAmqTzd74XeXnOy7cW67O9E+OhABZPEKy76Rs/zkplhFsLjtcmMvccj
 lCThc9aRqniTDE9I71D+cxe2l8vGi+1EgfcT9I7duq9gyftgBVR4XgUji6sWzhqA4uAo8v5FCq5
 a8kI9CtIVNyY94YSraJCCp9HCh3pvlBblnd7Wl2urRLVWvVAd5AEQ0M+PXmJ4zLushagLHuHhif
 VxEa4gnLD9fW71m9bK3irIzO1qW3ABliliJhzTd9z9K0S7BMcvczeHtLZXrHuh5CV4510SI+F4T
 7Bg/eHBPt9l38GHyRcpTcTyYg7q80ROG/Tuz5WENiCRz8gM9I83MqOob8UdwKHtna+E7XYWipay
 AZHXI9trIkv5nDjz3JgcytAiGAe2NKWA==
X-Received: by 2002:a17:903:1987:b0:2ca:c411:78a with SMTP id
 d9443c01a7336-2cf3489526bmr242323635ad.3.1784706182406; 
 Wed, 22 Jul 2026 00:43:02 -0700 (PDT)
X-Received: by 2002:a17:903:1987:b0:2ca:c411:78a with SMTP id
 d9443c01a7336-2cf3489526bmr242323365ad.3.1784706182016; 
 Wed, 22 Jul 2026 00:43:02 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm5572577eec.16.2026.07.22.00.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:43:01 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:11:21 +0530
Subject: [PATCH v8 10/15] dts: ipq5210-rdp504-u-boot: add override dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spl-v8-v8-10-cbfa79e85a9d@oss.qualcomm.com>
References: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
In-Reply-To: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Johan Jonker <jbx6244@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Erikas Bitovtas <xerikasxx@gmail.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX/U8l/jgxnog2
 KhrI04FRRD+iEG4YcEn4YDQA8rq03hDkdvBDg9qIpid/JrJHhWNJdEwxVgTeggV/Zgeg+Sra/z2
 QDxUplE36+zzxf3EegLq/cXvoy+n+CiysSXmLSTcziO8OrnWkS6vFpXeb3ixwNTyP+m3MCDROy1
 pGpNSDzjHabwj9AO6wVZF9YtPhpWnvFBl3NfSSJwKoFK2rQDcuTRGhTUzk1V3ej6CMnJTIzLsCM
 /bhK2RFmil91wQyprik2DgjH/MQVIXVSPHY8xhuepV+bg/mZuNl0p0lnkIv3w2spvdP4WAWoUIo
 LXMqeS2/iLStfC2Hd5SEhOrT/62XSR0zw09LYnkuH3E2306Zq/zeN4nHyhGjKf1R29jsqxFSD+s
 NkgIylXfCXNLR5He1Epwcdvminl44oTNOOD8iNZjsit207iqsguX9d3YHSQtp3+LCpX6bEeb6qv
 Ndg9NtDUbK1pRw3bchA==
X-Proofpoint-GUID: vN89Z8umS4omh65ZHetSvxXEa7sD9eJt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfXyDZmLTBUuWvh
 A67TokKaNyX1kxTU6yV0Xynr95VMR/ftmHvuMTEGkGW9VlSaWxz7UdE1zB164UT3nH1nQdNIDXR
 3+mndzSdPShyKzS2Xq1fIsBfsOZmrE4=
X-Authority-Analysis: v=2.4 cv=b7iCJNGx c=1 sm=1 tr=0 ts=6a607487 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=p0qKAmUI73xSM1QPZ4kA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: vN89Z8umS4omh65ZHetSvxXEa7sD9eJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 15IYHa1YNbRjLAfe1c8m9UFgxktBG9UiRTJh0uMQi2c=; b=Xoxds+CYf3+XGkL9
 cT8/MGSefzIXBXL9L61dERNiJ6WE0VJPfghG2gsnWlRQMJyv+w1Nbg6zhGCw9RAS
 77Siex3T2PrBTn/jHd/+D6TEDOoSUXNkZuysO+OBEHK2TJm3F8jmDs1VW9GusObL
 q/NZH87FLUZ+Cmdt+zltUohAXx20++VorUR0HM3bKlRwLKAfFvpiFQDP0hwYp/Dp
 kYEFOvu0yDfxzgZkm5xdK3jaRAaF9k427+wou3XzU6htTYOrcOOEtnxcPUZhq2HV
 Jo3wiVK57b6OffoO/M9zlWOT2+OtMOyR9MWFPPGNw5XiybXRtOo5PvQgMz1gvNBq
 EW/RBQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706182; x=1785310982;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=15IYHa1YNbRjLAfe1c8m9UFgxktBG9UiRTJh0uMQi2c=;
 b=dgXY6wxb7ZsWjB4OfQFdbBKpFtqyANbyvKvvkWkyFyfbe/qV1KCW/3A5qg9FfYSTzF
 drxmhwEysyYPfflQMJsT9jxa0rYG7VXefbAM9K/k7AXDD5417RK3xwb/JB3EJjKd87dG
 hgk6mmtz3x4trf+lnTgjDRETla2C7kc7aRJjVLgxprD238F6UHgPd6npVw8PNOGRRKJQ
 yX2naPzLJiBqiKdAQYdSZfFOxaik0d/kXWIptK+MG4FO2BYSfOYJqPoOUuqKP3ixcp2O
 JUMKyim+A3Xm0GRdZOTNSsyf5Lh1Lw8n2DiQRm1kAFWqp3SVD3bBeLJlNvHtrx14PaEr
 eMFg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xoxds+CY; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dgXY6wxb
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

Add initial support for the IPQ5210 MMC based RDP platforms. Remove the
bootloader@87800000 reserved memory node. U-Boot proper is built to run in this
address range. However, configure_reserved_memory() unmaps this address range
since no-map is set in bootloader@87800000 resulting in a crash later, when
default_environment is accessed in env_set_default().

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
new file mode 100644
index 00000000000..5582de9bebb
--- /dev/null
+++ b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IPQ5210 RDP504 board device tree source
+ *
+ * Copyright (c) 2026 The Linux Foundation. All rights reserved.
+ */
+
+/ {
+	reserved-memory {
+		/delete-node/ bootloader@87800000;
+	};
+};

-- 
2.34.1

