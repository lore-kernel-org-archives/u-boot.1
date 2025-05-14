Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A49AC3ABCB
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 04:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFBAF82A39;
	Wed, 14 May 2025 06:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g8YyHLdm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E722B82A25; Wed, 14 May 2025 06:42:39 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0AF282162
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 06:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E2Re90008679
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 04:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=e0cdspJZtd+
 jzmG1w6tliJaS9NeLe0LeAwhptpSK3yg=; b=g8YyHLdmVWmM5gKXjXKZ4pJeIS9
 UhcgstVZ72bcRUA/l+usMI7yVDYAfArPk5d1h6fEMHAkZV/QXvnxQwkuQ7qNUObh
 I/3YET1D2koeAfhO2bTbEm1HIYbVgenHisN8odxiFvVGZmnachdjMBWzoCcfsKyj
 Br+6pCkDa5z7YKZyg0XOD9sM3uhJhWLs4RtfEydR8kmi2m9i09P1m4luAt/iZhqX
 8IQoJUU8yzfK6tP/v9LlakHHLiRrVXLQhFB9fzXg6hKKX7u7HRbFB61di8Y+f8kg
 J/abfTLtXa+76beIr+KJUZzvpI5pMRU4MA0ba7hEcVazfgekL3Q13X+hWDw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbex1c43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 04:42:35 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-74235ee893fso7784815b3a.1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 21:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747197753; x=1747802553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0cdspJZtd+jzmG1w6tliJaS9NeLe0LeAwhptpSK3yg=;
 b=sawTZI5vxD1ZZeMw8Qk1q/RhVnNbT2mv2U5CCWwyFidfplVgq+mpJ3YB+nKw9kdSSI
 h9c8zclBMgY2YVYkjxPJd55AYiH75Ti8uQNp00YXVlsdD+y7GYE6t0iTvtLXEcFhmYSe
 WUTnYJgm3vF2zhiNaPugOingu1xZqpYLCoLl/5iYdHIQ35UBM1AqqJIcFTqVY4xX7eiH
 MmnKg7kY0pE+emFw4AUEeEAGv0coAyJHMtLkWbd3bnYqiODz2Kb4n8M7xtMw6CgEe4Uz
 sNAWgWJjllwQBTlsMa6MuHa5QA1tdxAD9vSdAaFAR6QhATbIfNpzm55+62+M0npNnA8r
 6PFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOLfDVzyCJmwZyMYOnBk3jBbOgeweUt+C9dJBqHgXxnaINPvx5weA/+Y3znTH2Ob2Ak0gRO8s=@lists.denx.de
X-Gm-Message-State: AOJu0YzOP1FwgYHXrtnUHEMCEX7tY4KA+sTjcpswdS2G4zBHsHK073Hr
 Tv0NsEQ9zVOO/Zbs1g/FF6T8sHCTYUf5+2vJts3Nh3RLXkwkhp0s4P4nR8UP/RjHHQeegWUZzom
 I4yuRYjOookAXuD/IFw9gg1KL1mkEhTCUhkt/56TYMUVEF6HTdnlV
X-Gm-Gg: ASbGncvEqb93nuXGzXZeM9B7Vip+XdG2wzyhPbPw2vCo9CC2T8gqVsqsjpK1y2pqjmR
 U1PHC6Jtbl3EhAD9Yzdl/u39mxCKzAZHmAirjKkNUkfBbXECXRJhnWgKrgczfAeI5vynW8t2lC3
 hBUp7ldNWpLyFnDgZly3gJOm896nr9VLWggautn0b67pw6KBl9DzO3CnjLUygD6u3f+2BnBNg0j
 7zdb8HKfi3liMYAYhvlvWpWV8i6m71cQNrCRyuFnqOWDur+cwAlWwlhz+xSdPNZbFYmqvGwbBZx
 y8Cx4iDa93dfNcXh9mIGxL3yEhKJGqyp7MvIdxutvJnTEXnMAs/LVWFT3M3deJLoAF+c9daUUC4
 2DrSntSi+pWHVoGLc774qgfmxTk8/cQ/c8fUsG84E
X-Received: by 2002:a05:6a00:ac0a:b0:736:692e:129 with SMTP id
 d2e1a72fcca58-7428936236emr3058348b3a.24.1747197753397; 
 Tue, 13 May 2025 21:42:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpZLN8mfh7z51rWxBqjRBiczQBFSV8amUs/KkrLa2/Fcx7J14xeRmMrrhLVEbSCG4zVv6Zzw==
X-Received: by 2002:a05:6a00:ac0a:b0:736:692e:129 with SMTP id
 d2e1a72fcca58-7428936236emr3058324b3a.24.1747197753001; 
 Tue, 13 May 2025 21:42:33 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a3dbfesm8889588b3a.138.2025.05.13.21.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 21:42:32 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, sjg@chromium.org,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 2/6] dts: qcs8300-ride-u-boot.dtsi: Add memory entry to
 bootup
Date: Wed, 14 May 2025 10:12:08 +0530
Message-Id: <20250514044212.1422714-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514044212.1422714-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250514044212.1422714-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDAzOSBTYWx0ZWRfX9DWqoyG5hZbw
 A8GzXtr8MuAL3gXrNABfMm1FQG+32nyzyAzwTJR88/WIRVfT3Jq4Apppfbe5sV0aQcdlxBxE9If
 as211IDpo3d2WtDm1aRQXfTCKciuSekmpoVmoFgOcDPyEoPfGoJh7GLtSKvy0U+9COwjy7+/j6u
 w1WIJy/6kLHBTqGMQ1dA7e9ihDKb26MB2o6J7lv9TkSA7GJq3F8afqmuo2FwbfttTWzDtl0Ci+X
 UCpmgdfhQfnmC6Z2E4OVQ4bAQlVo5PXlLQ7QSJDg3cNBHqt1NAQFL0VVFXyEuLubMz0FoJpMC59
 TjRsHy8fcPQ0kq//Mm1+66lwZ5/fD1eTYWI/IoIBtf12CIRFcWzjfu6uM5U4Xaw1+xjQk3N3lvE
 eEr+IgpeRoH18fp5Le5HrwcRmGKkiGmbZYT8zPtoA1nIRoNPvxcwhDlzdPI0VILWZgLd/hd1
X-Proofpoint-ORIG-GUID: LYxmE1FbsJkbEC99wpmQWEQ3TXx5UfKJ
X-Proofpoint-GUID: LYxmE1FbsJkbEC99wpmQWEQ3TXx5UfKJ
X-Authority-Analysis: v=2.4 cv=IcuHWXqa c=1 sm=1 tr=0 ts=68241f3b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=bDQDORxSwlGoDRj4kdkA:9
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=911 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505140039
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

