Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E205C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 15:50:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30105820B0;
	Thu, 29 May 2025 17:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LrYH5vxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38AED820B0; Thu, 29 May 2025 17:49:56 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D7C81FFC
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 17:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TC1JpW024501
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 15:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4KS05pqVX58
 FRqplPi1YgOxfTsM4MZ1olTNyHlne7io=; b=LrYH5vxA/HtLoUcgQjzHSrIRI7N
 E2ysyhjaP8iDv70030G2TiihjHG2aw3UlxcIejhWI4cUayDX8Qc3PzWISy99N5jZ
 Z9tYU+P1zCgaRgBLZoitxP58Bce9yxoy0ePd8Up5tfZUhk97uKZ6p4aE4hTq46it
 XeYQX0B5n03RxDnla8GuUkD0+4Qf7u2SpD3Af1zPNLtofiyk2D1EVxzpjRRX2UR0
 5Z+MGgmwMacvUdPcnjIiA+BCxQXERipoLw7KQ9x7trVAV0YqzA38myd4x+ZDAR0e
 503heyxuXnZglkXtvgQop5hh2C3fPzUiFn0K79lZR8Kmpm2CQysZnRZ0Szg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46x03mvfvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 15:49:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-234aceaf591so8726305ad.1
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 08:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748533790; x=1749138590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4KS05pqVX58FRqplPi1YgOxfTsM4MZ1olTNyHlne7io=;
 b=GEqhXb3cM+FBzSoxQBAChS3Faix5NuVa9GQcwkEXCX3G1jgX4RKP/rHs31Yyb9gfKa
 KIyk4gzWo8em4ms4VL12fNvZeB0dTQZ7Q6dkHUFfGKOJ+e/jLBJKg9cvkNAS9wOy1JTq
 T15sSrRA1+A3P68iQ9CNhwDh3eKRzAgQZqajlaI2MTWdqJKznzJmGzwNHGMXvM9B1iQ7
 MGSW2sqSAbrj2dXs+aPuDl45xF7YM9uJT6PjAMPwqEhgguHtnr+tKKIW3muXwHnDgZop
 dXQADe1JpDA5CE/vnC6xaVgfPmPOhxqNI6bNFr4CCf7vGSHX41yRjvWf2LVphdd83jHy
 HsSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7ZY1fVgqQwYJJBeRBxTdGIpneMhXeANkiAn+EsoGi6o3mozrlx5hIb6BgmRxYdUzIzPK9tAc=@lists.denx.de
X-Gm-Message-State: AOJu0YxOMx2YCfjegtC9OoCAYUZlvZ1gcek/1TLrqmFM1dckbNHhhyo4
 7plUy/JSo9cmasMseLyf2/4wORvKv+9RArQEtbxr5nrRBdG8fz1zV5V9YTJjB/nrUHDmwwI3ZlE
 uT/NeuiKV2niF0i1oaorQ5dN2jyaHlCNcJ98FPOHF+zzYcdFoCiC/2a/K
X-Gm-Gg: ASbGncthpCktHpuiayhtnT1aYabjh578QWQVLsAu6BoU2xYpr2u374nzC6757TfALCd
 iWVTqGbv9mTeKbJPun+xRWmeHh4UcHwafKt9oS7fPqIDBUeAZsaXShlHZVDTJsFodkHyQR8jgqe
 vcgHc0ZVby7y54OcQ6tGKbeYGJfDqUUUCsByOGP5OYd0h0QDILzd27sBWSKHLgOtITi4PRRLhQi
 9wShNZIFN8dkorhN3CtHWwBpt8NZnF5TQlBYJUMrw+p30cXptgbRCxDavahdb93QeYXx6dEth5X
 eMoRBbif8p8bLsTublhebt/Wc6JdLi+pmuLwadOK6mmEwrExzwepJcNC7wSiKPNxSLIKkXp575n
 eu26lkrTD3MddUyvvondIc4/6OWw=
X-Received: by 2002:a17:902:e807:b0:234:db06:ad1 with SMTP id
 d9443c01a7336-23527b83ce0mr2686345ad.0.1748533789996; 
 Thu, 29 May 2025 08:49:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEidoD7Hs3kHXfhhfak4J/LHLs4EtP2Ex6tUdnb2ogCPWNmmARhjtQ05w6nUUnz0JRofrdadQ==
X-Received: by 2002:a17:902:e807:b0:234:db06:ad1 with SMTP id
 d9443c01a7336-23527b83ce0mr2685925ad.0.1748533789582; 
 Thu, 29 May 2025 08:49:49 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cf5448sm13879045ad.185.2025.05.29.08.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 08:49:48 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Google-Original-From: Balaji Selvanathan <quic_bselvana@quicinc.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 2/6] dts: qcs8300-ride-u-boot.dtsi: Add memory entry to
 bootup
Date: Thu, 29 May 2025 21:19:27 +0530
Message-Id: <20250529154931.1879976-3-quic_bselvana@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529154931.1879976-1-quic_bselvana@quicinc.com>
References: <20250529154931.1879976-1-quic_bselvana@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gem6CxR8WSRN9ORDM-iS4ROv8YHSZAf4
X-Authority-Analysis: v=2.4 cv=FuAF/3rq c=1 sm=1 tr=0 ts=68388220 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=bDQDORxSwlGoDRj4kdkA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: gem6CxR8WSRN9ORDM-iS4ROv8YHSZAf4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE1NCBTYWx0ZWRfX1iC2kYcsMJo9
 h0NAk4zVyvGrJxWKYC6gWV5OVlddrNgNHIBhKXrPgNm4RAebFtiWHXMZBzf77j+I4gHYQm49UxJ
 WefZtAkq2ZigRuEpcaHPRzCmNSP3OQdBh3S327zzwzOaRpouA4TM7b2Gx16LwveCMa8XXTJEzkM
 qZI2wpLNXQKskIYX8DupfS6K1rD6qj6xCQab39M1Qjf2k3mboBXq9y7Y6OceAcWrKB5G84/K+Ep
 tQl/V0eqmrAZ+TNDtauLqiMLCcWOukPfgi2ceTuO01+B6q8XWjknElUUP7f4khdtHpiDQgrKBMF
 HKIXBMdWknR236VI8xHz4gP8LkB1eLTAkipgBjTLknYvVGC3hw1sSUqe1O8k+ZpRx7mVQj8DwM+
 jrgAg+IkZpkNHPe7FSC6u/OTptrw/JFlchzyxSnblKlRMltYuo8XZjbOXZj9job2wuvl4Okb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 mlxlogscore=918 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290154
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

From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Added the memory entry to bootup.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
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

