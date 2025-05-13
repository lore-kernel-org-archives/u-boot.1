Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28560C3ABCC
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 11:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B730A829E4;
	Tue, 13 May 2025 13:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kZSaoTWB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67C3982A65; Tue, 13 May 2025 13:02:59 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E1D8295C
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 13:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D9HTFd029278
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1AqIpPTLrTf
 ycbANRL6owYkdV+86HRPPbzDgMiX4Hfs=; b=kZSaoTWBebPR2TNr1c34tQxvCGc
 8KkxdHZwnKbYDCRrZ3AZYAcIaEPh9rkXnUPuJ7HrKFq4oQtXezXpyM0vwvcYx4In
 La6NhhZS/FPAps8ohNvukZFRXZ4HnVwunmeYxiitbRR/9gDP6DeYkkbqNeTIF7Td
 C/4BYO52sN/ge37ZxdQNm6pRziubPNCsZUHU1iv7mYH+0KVIFdlZeNOd4hDZCSPn
 hDbWOIgljOfIyc+5iavXwyrTUezJprHdHmNOYPHnJienmGp1BbY/U0KlWkF8K47A
 y87dJYBPz4AUt00xMJdAzLF3Mizz7F1LtdGf9dW+LFNbv2UISGW6daJ7QwA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hxvxff52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:02:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b0ae9e87fe2so5058273a12.0
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 04:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747134174; x=1747738974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1AqIpPTLrTfycbANRL6owYkdV+86HRPPbzDgMiX4Hfs=;
 b=pbFgQbwgMvpgxhjKg836Er+eQk6vf8Y61vf7GN6ZEyUeWwb/qd2LXkFYAKCXMnxmIc
 VjiQQzfS4tALIXgsxnOY7VTRJvBDrlLZmImQJtCV92WGUHJ5zcvPKNrKycdQBq1fr3hL
 ZX1JCHBkTfFGjymnxGm3uQKy9tk0BOWzi0nFOZFN+ZWOVH9lk5J/+pZ0jkj0UJLNoL/u
 5ZZEsxX9fa+Oxy72jJgfJA0BAlWJwNB3BWYKqSrhZUSnB+AEszW+uOLMY5TWMx/JWxL0
 gdIsQX1MYltmT7yd4m5ymfQP8E/MAtpxWTqseVCu2rqS5B8wbNZ5sKo6yPPXvpunROxq
 bbCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnzFMvbiedonpRlrLdkRcQSHBVvKGNMJH6JRnwvK7SiHwC11J7eCVkcNmBx+h/zFVNgYCTLsI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7eZekrwjER40QyF1w+bDy0+V0966HeEt3ycQfACJB0kWj+Cj3
 gh6kKF3rGsr5bx1GvfqsXGAS/0OnKeJf5KBtdNnJ59B9ZLjPwIMgC2VISAVigiSoibnjQDmrYN3
 opte7z9clpj2Y3H4gUhhJNizkzFRpGqq3cRV0Ib5i0QATSO0XX3sB
X-Gm-Gg: ASbGncsQH5DbARZkxUUPfKdr9s1no124nBPBUBLvLBDzLrMsNwU4Ouxut/SbobidN/v
 OEkdYZ3WTyDLqA7Ha+or50FyTikJAbWKNVvlsp/NaxOj61ttDOMpYry3MtabmvGE46eQJUtR6Z2
 SVY343aKPj+NLh4YyKArr942poSpOmBYwavRCt5XiMk71kTtSCbzGdXJqadA24LHX8fEc8gW4bk
 jiZWdaE9N+lgOPfVx0BBmkETrzkH0kjmoUY9qAviRyn+YCHD+qAVdbaBLDUhFEsH4OL5wq22vZx
 Z/jW7khci5kl5zks6mUoJIbd4iLlVfI5igp6pkyM6g5Xb4UmZ0FqRj7nI4Pjr4MZw98+nlwxqNI
 PUmReAnDjiZYfBf/3cSMO+6WHjBWKLvg=
X-Received: by 2002:a17:902:ce06:b0:21f:98fc:8414 with SMTP id
 d9443c01a7336-2317cb66509mr45514085ad.26.1747134174499; 
 Tue, 13 May 2025 04:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmEVqjPToDq1Ibc4H5r0Co59s1QTz9vJI+zV+lN/aH2HSArkAPR24+3XNHSQe+R8geJ/vIDQ==
X-Received: by 2002:a17:902:ce06:b0:21f:98fc:8414 with SMTP id
 d9443c01a7336-2317cb66509mr45513535ad.26.1747134174047; 
 Tue, 13 May 2025 04:02:54 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82bfa11sm78362135ad.254.2025.05.13.04.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 04:02:53 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 5/5] configs: add qcs615_defconfig
Date: Tue, 13 May 2025 16:32:13 +0530
Message-Id: <20250513110213.330495-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513110213.330495-1-aswin.murugan@oss.qualcomm.com>
References: <20250513110213.330495-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEwNSBTYWx0ZWRfX2tTJFrg8L+cV
 5NAjuIhHGne4ZhZ0jZ1/9TV00HWhv8a+SpD9wvKwI3O0WAuvEb9ZCvm5LxPqv1qwXf2iYDFtf0a
 e5yKh9p9jF7jCXS1OyhauuUzgm2JGulDwqXkFiGCl1Uj2v1EAaE/jDRJ0brZEu51kjL3mwUKBVw
 58r/48bMwgjiD8ZGDIJ4o3O0Dx3J182E/LZ3r6foiViofMEFeRl2QysEvJlEHT00PVGbJTG5p/g
 y59YGcVac+qZQEE7EqzPa37oPaEane21aqAimpxTGiR1W4/J7HiWE4t/HhI2Ck7Lelx5FPxO0CK
 zxvs+cMHqLtMApsz60g0MFm1JiutSzBILk1DYntqGXiNonAK9kgGQZL7W5EYqtHddHUbcJ+uHEv
 Q44FJZSPVJXd9HLmLCMEWfG1obwgjzdXCrkP30P5FC5BKGGN3k4HY+myIiELmRr8K0dz0fzJ
X-Proofpoint-GUID: BZO4TgHGFggu52Rak3MFlHIJbOJcn4fz
X-Authority-Analysis: v=2.4 cv=WMV/XmsR c=1 sm=1 tr=0 ts=682326df cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=R2VVY1Wf7TWBXLlSVHsA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: BZO4TgHGFggu52Rak3MFlHIJbOJcn4fz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=841 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505130105
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

Introduce a defconfig for QCS615 based boards.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_qcs615_defconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 configs/qcom_qcs615_defconfig

diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
new file mode 100644
index 00000000000..c3822d392ef
--- /dev/null
+++ b/configs/qcom_qcs615_defconfig
@@ -0,0 +1,22 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of QCS615 dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x880000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs615-ride"
+
+CONFIG_REMAKE_ELF=y
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0x9fc00000
-- 
2.34.1

