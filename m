Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE58C5B549
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 03:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5284382C7D;
	Sat, 31 May 2025 05:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ecwC49Zw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1471282B6B; Sat, 31 May 2025 05:20:32 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC31D82C30
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 05:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UMvUMN018969
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AFc3tqRyoka
 S7B5wDQoe+D4WjwDCKr1qO5QiD7xWytk=; b=ecwC49ZwmQ/0I9SmwfXru6sOFsa
 cwiKjmFcptPhCFaz68cdUsjROYPWmw27EKzfIyqe7IkDYb7diCey07/mi4FYcCIk
 FebyND8oekO/D1AdHlHIheFMYv6pg4fOA98GDU5re/8mKm7ehvfNA6ikItOvzwJq
 SNUoYqzzadVlQad01QJ6FezZ8mobvAzQmr2qNnO0GQzSYPx1YwIX1A39To3QHDqV
 ql5Qp13AEQdy3+HpC3jLOJb1z4mh2/fO6MNT0DRsvvwR8IQmmefbMspoMcawQSX3
 bykO67+QDZlrXnBFn6ICvlnsiH2ajNiLfRutqtJ5cnRRw9QIAjNsdX1yOvw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46yc4yt450-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:20:28 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7391d68617cso2876727b3a.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 20:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748661625; x=1749266425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AFc3tqRyokaS7B5wDQoe+D4WjwDCKr1qO5QiD7xWytk=;
 b=qtmcs/h11sKkCoTs1GcsKhLvOpwuNd4BvP1Ca11bwqGA6X0bRkNURTxtl3RtSs4Ug2
 3hViysJI11yunNVf2vlaiXseTQnrsgLSytHZTQp0XUaM+/B12wgs36nztxmkQKN6OfBy
 BSpCVVKlCYYKv7ZmxN/irYdJ49ecxNdIHmWH2jB/nmXUGLfPQbwpMylxtokp1nS8jZjc
 Y222Pted84mtOl4j6/DozOf3CfwunP4edHZfq5oYQDQroZ/R1yBLYiM0o+xub9jlvZ3s
 kGMbmuuwFn+FT7NOU+1EuuwQ9yi0NniAr1yd80rKS1D9qi8OIMkkFQCYF+ufqdcEpvoS
 SDmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCAhvEt4qRtYYtPcNdPFe5FMNBZN1qSv9GR1GO8fChpiPkj8VRApmRYfF0YC4rggFav6mEF/w=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9IYv4G/FxaXZ7lIMj0S+5Y95noMLUGiB/dvXtjkgeZoD02NYH
 v9IAB43540/6qmbf+wtOqEfSEbJYZhhXPuoC2R6fAwpr2N+DndbKpxgK+pHp0DU+KR/PefH1HUl
 jiK12CVkegg7WNjeCmxhhZwE3TPdX4d0RKK3KfovagrIEs/4SEMCQ727x
X-Gm-Gg: ASbGncvI3mhwE7Trajf/kJK1YTOxJfXV6GBeFeAR3WSE3+9ajE+wBIc4kUDHd3Uvkug
 892sYrWQyCz2EJjZ6PPaqqTwJuFVSoGJ0YpKZeLPWywhGD4BcKYfnNnMMjc1AWfa1RFdIuo7P4x
 dqR0Q56Hg7VsKStOPzneua1HAI52Jl4gQkqtcwjSgEdi9aGTISo2C8BRL/b9ZGyArxfRqC/tau4
 67I0zV26mj++5/4X6kCso0QnTPFBdNDWHt98BFtr34UZcsQUEt0AYY8ew92FPT+OkTXhmvhcqXQ
 70NYhIiQt0edhG72wDod4QRDwwuJiKgTPJ2XcPOpn1nhqxVDZ+WEzp3clkv2qwKXctk2mX2gd/z
 c1AOes5HTU8+eiHRnpW9837kUz9hZa/1ubLykX+SrMACw5ppzO2w=
X-Received: by 2002:a05:6a21:6d9e:b0:1f0:e6db:b382 with SMTP id
 adf61e73a8af0-21ac5bd41b1mr14264952637.8.1748661625294; 
 Fri, 30 May 2025 20:20:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGXe3+bosKG/GzGGTGWEJ+NCgSbHV1hUup+oO42LP+8VCDdtzcs6hFcc1G+faSJVmNnAF9rA==
X-Received: by 2002:a05:6a21:6d9e:b0:1f0:e6db:b382 with SMTP id
 adf61e73a8af0-21ac5bd41b1mr14264928637.8.1748661624922; 
 Fri, 30 May 2025 20:20:24 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2ecebb49d4sm1856794a12.64.2025.05.30.20.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 20:20:24 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 2/6] dts: qcs8300-ride-u-boot.dtsi: Add memory entry to
 bootup
Date: Sat, 31 May 2025 08:50:04 +0530
Message-Id: <20250531032008.3083716-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250531032008.3083716-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250531032008.3083716-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMxMDAyNiBTYWx0ZWRfX5qKNQPEPImFq
 eBNU0pvNGccv3e/nVjgJG8ovVJlZIH1HsVhLJW+/xopdK4wju7E2DM1BDteFw8m1JKP2Bn3iOUg
 F0uvR5/p4Gh97JEbYsLsfEcH8FbivtL5BVXvYnbIMeVXyJxym7gfwO3hCUC92QEevht12+GbUtg
 7DJuqHLNSmDLp8Yry0b3Io6B7IBFMvKhByanI90F/JZCS52KencAol/FvYQMsQ0R6+WGdJyJ+38
 YfL29Pn2Du29t9CArtBMXqrlL95v6uU+b12Sr9a1+lXXaLLBB3ngDJ0/mjHHmGjlWNpkp3ewG8Z
 UsGEQMdS/J/zPxFUJE2WqlxlJOyyBLq+ykkPOh9QJGm/PCSB9cs6ynEb4sh2hFV2eXM70f61L9s
 KzBrcLcg3L81VrKzQbjAxykHE4IT/tK42JZl7nzAuMhLZPlYJP+Ahvmoy1PaXdLZJtIAijt4
X-Authority-Analysis: v=2.4 cv=Ybe95xRf c=1 sm=1 tr=0 ts=683a757c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=bDQDORxSwlGoDRj4kdkA:9
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mkpyJ2JnSrzflc32DriJl58Eb_n2lapX
X-Proofpoint-ORIG-GUID: mkpyJ2JnSrzflc32DriJl58Eb_n2lapX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-31_02,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 mlxlogscore=911 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505310026
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
v5:
- No changes to this patch in v5

v4:
- No changes to this patch in v4

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

