Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C1AC54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 09:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 447DA82E2D;
	Wed, 21 May 2025 11:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jiqsxZQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BB3182E28; Wed, 21 May 2025 11:45:08 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AF1482E08
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XNYZ029173
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ER4EnnJK6vQ
 XXLmqX4nQeVWQKj9woCn4tMrg4Y+3sts=; b=jiqsxZQIGTxbvMHznX8Ljv/Jnz1
 RHRc/WpjH6vz3i9nsZy2mJkz8ChxaMYAqw1U59h8b7OUJSHZeDW7jVKf2dqdKECL
 YTABcE0C98KZrIKUpcrc8ANdwlB54BilO9xuY+F70eUYW35lZhZCG8GSClA74I8o
 W+KocAekngmc1+zRzeMhdahG8l3A1Sj664TkC3m/7sFlINBXGPdDFUX7nxlLjvuQ
 rn4lByxiD86wHWdttlEyEaE50l1/6X3HlkVTrh1U38v/j6y2x04WHt+oqy62onSp
 Z9vQzZhu01FB6E6hG2B3SY72MH8aXf7nFN2I2ftHdAAvX/9A8eLBq6/rvAQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf42g1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:45:04 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-30f01e168b9so2511462a91.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820701; x=1748425501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ER4EnnJK6vQXXLmqX4nQeVWQKj9woCn4tMrg4Y+3sts=;
 b=ZlJOQyhZ0qP/CNziMponFZRkk5snAoTS7XHsfAyImg3ZAw/XYqgN8rUb3BVDxpLew8
 7gm/B8EqNbBfzqCfCR4ajEmG0Sv+ZZUXyAzkahdNznz7rJi2W+NOXzIBU10qjcb0p7kd
 5T0cFljMBjP8W3cICv7L+aAKBjYMj/x/52Lyskn+IEOvD29fuhfLQkA84MestjuIZo5T
 hLFYVY1rwP5GNrWdWgGSNyAKs3XRfkdffVZmIgM/losdZUNoO1Nr6KhXyI1lCH77wZ7B
 rdZs0Uj1YoT7FQfKyS/3QAoTSjQ8Aqs6kKBGS+5lbP1LXma6EE/KaLOIx9J8hlkVDNXb
 r83Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNO6nNLhC91jEA4Zv4VB9nzF+OHcJEJl/qecNvjOxwgZuAb5JZYfWEVYn0eoDQ9hgvEfK+nh4=@lists.denx.de
X-Gm-Message-State: AOJu0YzGAqiAlmsIaQPiapyZLits/nBGDZtn0feWoyHKA9aF4HCfVTob
 igQ8jVSiHaZ5hbs7G2htIZ1PB2CeaH2RWKxYl5FRt8xe3dpBuGMA4t5CG4+TQ/LcrmIMhFCC7uS
 KZGyFigEYj5PyIS8+bTT7JCIyB2ALHsTPcrXf/eTfUPfPu7QbB2OrFtZe
X-Gm-Gg: ASbGnctaLopsXwNOQY/uPeTQt8DmxnJtRnM8r07ZvZ4pfDoXuU/ZCxxywdbwfLoP38e
 qEFzehVdCYi9UiDqeo56Vjiepw0YHFOkBEeBIUkdVGCyHrRxxTsK78SvxQ1rkYAdxHdExhnL3RD
 yBlye/oZtafdqtYpu4wCQsK0mpzDnuT2L9sj3FA++CAWaZFELwG1u2MTjWv9aIwB+JzLGDgZRXf
 byDOdM9k4vs0voQfAB7Puo7bYsk830Xrjunst/tYqQesvcMsaBKrDfEp++8nkvJpBeY9WaBEdX2
 VOqJn8fa1V3Rc985qd8mb5a2y63KRFZG0wcDM4Xp2jvjv0wqdxZ4JdRsNEk4pSeI6JoV26tPBqJ
 /BqXaktkqbML4rK/MKESOpoUXkJGQReCG6VvO9Nfb
X-Received: by 2002:a17:90b:28c3:b0:2ee:8cbb:de28 with SMTP id
 98e67ed59e1d1-30e7dd430ddmr34157984a91.8.1747820701088; 
 Wed, 21 May 2025 02:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiAUawyFrY9blB+334ohS/m1ovvJVCBcoTAlTVMbrd2Une1oEgTlGlFzkxg+ftpX696at0Og==
X-Received: by 2002:a17:90b:28c3:b0:2ee:8cbb:de28 with SMTP id
 98e67ed59e1d1-30e7dd430ddmr34157945a91.8.1747820700670; 
 Wed, 21 May 2025 02:45:00 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f3650000csm3226367a91.37.2025.05.21.02.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:45:00 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 sjg@chromium.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 2/6] dts: qcs8300-ride-u-boot.dtsi: Add memory entry to
 bootup
Date: Wed, 21 May 2025 15:14:38 +0530
Message-Id: <20250521094442.3522036-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5NiBTYWx0ZWRfX6SIS/XHa0KZ6
 V3c9cZ2xl+3NTVR/J4pAeE9CY2xurRZwo29T4oZ7D3WJODn/89jCWiQomFzjBUS7r4Bq0d4y7U3
 sSUNZqrq/fxo35nhEIPcSgAHRfjv1KAQ7iX2QPJdRkVoST3r/oKAzjhIXTXQL/A7Kv1/BDL7ZGw
 SSnSKUz8HyNqBnF1RpN8zKxYyRxxMYKOtQDsxjMuTkqjhUouFEFYioRursgECWq9zc3GlJXHRKA
 hNlUt2/BcuK22hpEiKf2J78ncdHQ4wV3WGg/YZPtO5kqnMqJEwzPODNn9IhOa2XVETqm6vHUh39
 jvnnVxB38XZ3UcxhE1Nq8YIm6bqRUmSHGYoWDiKK/+LPXSHaV4ed2HBqyGB529yNXj2+VDZDU8s
 YcxZ6H2lMTclO5SgDra3l6TRyCR5vz+NFk8C8JsT5N8ms3WsXa8yEsqHM//3EoPiIOCaJX6a
X-Proofpoint-GUID: 7mRPvcMejP7k5u8SKcNvslpe7cLnJs4O
X-Authority-Analysis: v=2.4 cv=Ws8rMcfv c=1 sm=1 tr=0 ts=682da0a0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=bDQDORxSwlGoDRj4kdkA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 7mRPvcMejP7k5u8SKcNvslpe7cLnJs4O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=910 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505210096
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

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v3:
- No changes to this patch in v3

v2:
- No changes to this patch in v2
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

