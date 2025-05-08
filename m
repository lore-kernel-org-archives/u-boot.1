Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82794C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 12:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73F85828BC;
	Thu,  8 May 2025 14:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DxPZSfaN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0F28294C; Thu,  8 May 2025 13:20:18 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E1798295C
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 13:20:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5484X8rg016151
 for <u-boot@lists.denx.de>; Thu, 8 May 2025 11:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4zVyehHooox
 /gY7Np8X03jgR5p4C0BpBtPl/gaksowA=; b=DxPZSfaNVdgt3jDVTktQu0dkQWc
 d0HyAJoPvvStHcmqheGRAzL3hCkuAy0UQgSGNKClY2FwInJiQ3t/qvwFz+TlQ3b3
 /myk9vM1HVmmtz/gbPcuD2n1mGf1KkW6IBuahFD5HmWboaKTCSEEsPvTclYV/GjY
 +q9xLMCJwAXjxk7TCQuNhiJ9lpsuE+7Qo5z77GbDObUg85xjKzzecFpWG4DSQj91
 FBMGs4IK/qys+sK9dAMIB9AcInjk67k71WU6Cps3Qg0y2hTUEHhd5etL1gN+qw6k
 XDjebqzCo2W1o8eBHPUZNR73J3EkNGPORlgX3+onA0aeIttcg/yMIPs3IHQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp8s3qj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 11:20:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-22651aca434so7737695ad.1
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 04:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746703213; x=1747308013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4zVyehHooox/gY7Np8X03jgR5p4C0BpBtPl/gaksowA=;
 b=FF8DiYvAjpfRxTAK1npnaQUqM3BdiWk7OHiSzy8j3xofgNSQKvAYg0wS3lBVQyKn14
 iRKKo9bTO29/bnDYWE0segfyqtPYAklQg5h5zOEhYDbnGVyMH/tcD809cS7PkyY/XXA2
 5NJaJgr5dlYidnhBAFXbCpsg0XVy5fzVfaVjzUYZvIv0UdbZ+aX2p596Xkgb2mnTzXbH
 NyG6h1cnEEB8YSo+S4Mxm7iRICTik4SL2egJZGu9w3F0YalH9p/Am7XD4xhckU0LdHpd
 nafzqGUVNmpqd9iXman8RGCfcFYG7NRTJzjug8dAjkmsZIV/n1jiMKE84cvZmV9QNhXD
 yVjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnM4YMze7co2ASO/liUOt7YqUi1EGJAkY/i1dWi8LiFo0kgTvngqa6vF5fScV47icPVI9jsuY=@lists.denx.de
X-Gm-Message-State: AOJu0YySUtCia1QRaLoHy5xeHE99fw2zHLA2y1OhQBh1zYv2U49ZEaZW
 GLng29J0mw+Nq3SB1UwhBgSCe/2oQBNE1LGYD9GNRQkj6GAh5hBUSgrL1AD4nh1V8ftBNW2YLxc
 6x/WRcLlvo/NCp6yjFgh/kA5bnKbxGFzdlinH8A/AfsLkkTgZQ99n
X-Gm-Gg: ASbGnctYwbVhvCIS8Ra6Koi0wfnrBCX1ExlwaQ5Klq9EjnBTqroxohLIeGPU6AG+gLz
 ZXIXvBSDK5KgOlW4poWoHn1EmU7gkiu6lNH0YeF0DVkw+k8RFNY99KxTk0jZvXZn+1rDSkqP5qc
 A3nj3kKFwnVa06+rnd8s7RYbI6OEh50Z+rNcqYGi8YlJJrfHwlClU/KUAI52yPeBAcix5aFm2og
 fomqi5lOKdXA2dexrIH/6UmGpeg3fcSsyG8JADoaWp67WIcSuwKztavkdolrHWPPoZjIqlmiLsK
 +nU3G9io/Wn5Fbu7YzDeEYe9HkOdHigjFtOsu7NZMzFHHHGgcCFj6Y6AAMPLuFsVHNWQaWa81KO
 yuHyi2KiDSYw9hwhSBJF1j3bvx26xxJb8Vqy2KXeY
X-Received: by 2002:a17:903:1cf:b0:220:fb23:48df with SMTP id
 d9443c01a7336-22e865f758bmr43905675ad.36.1746703212828; 
 Thu, 08 May 2025 04:20:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfpIj0NHqJTD9ggzEUVhlcF71vNqzHQfzpqQeaGm35qZXYzOrWdim2txBdunCnd6wy15XabA==
X-Received: by 2002:a17:903:1cf:b0:220:fb23:48df with SMTP id
 d9443c01a7336-22e865f758bmr43905265ad.36.1746703212454; 
 Thu, 08 May 2025 04:20:12 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e6c3b6513sm27779765ad.220.2025.05.08.04.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 04:20:11 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 2/6] dts: qcs8300-ride-u-boot.dtsi: Add memory entry to
 bootup
Date: Thu,  8 May 2025 16:49:48 +0530
Message-Id: <20250508111952.2304578-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YnE0CzAMPtL1AVksFyODxSPfnKmfOaxH
X-Proofpoint-ORIG-GUID: YnE0CzAMPtL1AVksFyODxSPfnKmfOaxH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA5NCBTYWx0ZWRfX47FHDU+9GpHi
 SNDZ7sDXuobBWPwkPc1sl9tOaY7oi0bRDvDKPc/hAmrD4z9Fnxi3by1fk30tQqH2bFjXuh7ikyu
 0gDSoFLpMBcNSQbilE3nS3l3/NheUfrRvtQB5DGds1b9qgHol5kEBaC5TinRDdiBPVkhH2uIimF
 rk+PmJC3+7hPLpMdpaSPyAQ+FrDPlJiUNZuWLJ8mwIgoWKEql/728K4NQznQqOCySeQnit0jYqU
 jWjadpbZrlMScJr6F7FLduf5Bq4Xo0KKSqHX1KGMCq/pOc4bm11oQ4uGTZLIa8que+vmbG2yTyi
 MIw02R/IwWVmUbxBeZ9r1LP9SmSP3BFS0X24Bs+YroNXXr/FAZ9jBzeJCI04ZLfAwDCDIxL0T3h
 AF6hPxISs1CCwevILq4Jt5JQ6W1K6rdl6xJ4CwVHZLarGUSgdzbxHSRcRiyOR79o/axlaBxN
X-Authority-Analysis: v=2.4 cv=e/4GSbp/ c=1 sm=1 tr=0 ts=681c936e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=vEsacUY7Kv1kUMNOTT0A:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxlogscore=957 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080094
X-Mailman-Approved-At: Thu, 08 May 2025 14:49:28 +0200
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

Added the memory entry to bootup.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/dts/qcs8300-ride-u-boot.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 arch/arm/dts/qcs8300-ride-u-boot.dtsi

diff --git a/arch/arm/dts/qcs8300-ride-u-boot.dtsi b/arch/arm/dts/qcs8300-ride-u-boot.dtsi
new file mode 100644
index 00000000000..8c353ace71e
--- /dev/null
+++ b/arch/arm/dts/qcs8300-ride-u-boot.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/ {
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x11a80000>,
+		      <0x0 0xc0000000 0x0 0x10000000>,
+		      <0x0 0xd3100000 0x0 0x26b00000>,
+		      <0xe 0x80000000 0x1 0x00000000>,
+		      <0xa 0x80000000 0x1 0x80000000>,
+		      <0x0 0xb0800000 0x0 0x0f200000>,
+		      <0x0 0xd0100000 0x0 0x01800000>,
+		      <0x0 0x91b00000 0x0 0x1e500000>;
+	};
+};
+
-- 
2.34.1

