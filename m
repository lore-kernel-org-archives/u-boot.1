Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2619CD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:30:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7947484942;
	Thu,  4 Jun 2026 14:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="p2gMjAzP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zqvc50jT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD9AD8486D; Thu,  4 Jun 2026 11:32:17 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 784CD84868
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 11:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6546ocRC1476963
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 09:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/x24QWp9Bqh
 ftk/N69Yfjaq3t2wwzuMb+IZK+r9D1uY=; b=p2gMjAzPbOfkAd39h1ngebRmLUR
 xP4WMSsIMxCRW3Ga2vqXXXT2O2GcqKo19HrFy934qk3lqCMzLPuMzil1tX8rcPFV
 Bm2YfSTAFfdzstb956NuQPriAIGkjOaptxECHEwwRiNYCQESj0/vJ4Un10cMeKUg
 Cv4hEYYUmkM8DsQheDDDeLLXXn9z2rGaPw85m5J19L83S+RCgFaCzeSh/vdoRkSZ
 NH04+VuVMsVOQgB1lex5UckYs6ET+sNDESXffpwwgDFiyk7YdyAlJrFRXbTnFvaK
 X8qU2oxJMf8roXwFRCS6qLbpGSflPP9IbNtrNEf041xiLX5RnvgF8B5KfbQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejp6nv1s8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:32:13 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c85a366b61fso329480a12.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 02:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780565533; x=1781170333; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/x24QWp9Bqhftk/N69Yfjaq3t2wwzuMb+IZK+r9D1uY=;
 b=Zqvc50jTe5QunFlDoIzbymgYzT/Unf9LTqBwe+6H3j0/r+tyTtv5Kd1lsv9IowZ3hI
 /lOs0NDa7RkE9LccI0EBWTpIOPKjLMmZwuMD/VlplnMNoQ7puGWpC+r9YSf5R+sDCj2G
 ZMnZsBdBOJSJ7OvTfVn61KO8imvxpjx5jINvLztBs9x9Ywde4Kn2laNBgScH407sTDPT
 1cT1UJKL7gmLgywR4Yro73h++oP62IuUOuDmDF53dsJjPHmn+mARcvrr7z9PWL6pucoh
 ZXV67zdlqmQHGkV6CVDYUcSGXAuqfIwJ+XMZu2Z5X65KoU0oZxYrfWGHCi/JmPOO5V45
 qNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780565533; x=1781170333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/x24QWp9Bqhftk/N69Yfjaq3t2wwzuMb+IZK+r9D1uY=;
 b=gAFK5VbeF9cvVaPhBik0kmgj4pq4/LkEjS7Fhji7ucu9gl/numGc2YT27qhES3DLxl
 MM52D4Cd8OYgvfBctiMBpH7+jGUQgELPNo2lzEkAv4ZuiNE+FseZ1yNXNP0gH3HV1UsB
 ODOH4wmNovTdhPz+UfvG+OerDED/kVZCp31DHpRatcpoXBNjWQp8Fh7cSO5UFmkQvCUu
 OHJ1hdvnzjbEMVSZ0RrFPNrE6oVQgj5Lt9s0HJnw3bT6oMUIQw7ZSBfqaSv4HZg3fM0W
 yb50de/kgaTs4jcVCyvMck5liTWDIzsOfIe41b44a6PYZvPeMoDzAcWXfKy9ZRV4cksT
 R5fQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dYQDw3uVAv9QNr3w6n928u+ObmPT7iyefl3O477cxOe5uxNO5ZyzAXVNIicV4Xt4f4Lg89sU=@lists.denx.de
X-Gm-Message-State: AOJu0YxAgPwefcSIZIVvcMNpoCxU5b/+CzFAQIpCws5c077a+6CHVOxZ
 XkigHE8TPVzOQV3JIGu5eMCwOqAJvRFq+0gumhmaLv+H70DPj+uYlAapclL32iNbJH9/nVxyLaA
 AZJc4tzqG8BY0O11cdVTyFibwmV+xXXS28SagoyRujBPLtZPCEFiWPm/W
X-Gm-Gg: Acq92OGA/dYceK1UpEnBOO/TtvBDTOLi+Sf0ipvIrJD6pXE5TG4L4Am50a5Zy259guk
 s17a0ERefyZF9ZZFpy91iZScp9C8eATeoLkS4Xf1YDU38Hmlwt/jqtjloU4bOHKofiQS7FPlHMk
 yIplD6KweIINM8NrStwtzaBp7KKualAnFhvAd5uUurspMbZAedE+HjbLcz4o/a9ywy+b6e4+PyC
 xlKe+Y1hmt7eCib1l/CuDlaArZ+BIHsVyfNMU2iGDBk2PNknrrV5ZUxAkVpZqIAHR7isi4sVk53
 g4eBiOvq3WtLkXWf8SKyia10Hi39bjjCTgBU9ryi1sgr/oO0H5r/5DG2IJja8CEief6lhb2/n/D
 mCKtaOQzIqD97VvvKcBBiPVKSf51ACcwpwJPFm2Q2KsGmmVV+CQbWXJzVHMJ7CxK/EsTm35BJs+
 CQzQo91igvRMD4Mnq7TomThrRYvDm5MQQZfOQf8AT2Lkxkac+c/OS8zWNVnDfAwA==
X-Received: by 2002:a05:6a20:b598:b0:3aa:f9cb:d438 with SMTP id
 adf61e73a8af0-3b49786771fmr8136421637.21.1780565532505; 
 Thu, 04 Jun 2026 02:32:12 -0700 (PDT)
X-Received: by 2002:a05:6a20:b598:b0:3aa:f9cb:d438 with SMTP id
 adf61e73a8af0-3b49786771fmr8136367637.21.1780565532006; 
 Thu, 04 Jun 2026 02:32:12 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0b9b3fsm4263552a12.28.2026.06.04.02.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:32:11 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, afd@ti.com,
 marek.vasut+renesas@mailbox.org, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, andre.przywara@arm.com,
 h-salunke@ti.com, alchark@gmail.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, danila@jiaxyga.com, n-francis@ti.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, bdklingerman@gmail.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 02/13] binman: qcom: Add type definitions for Qualcomm
 binaries
Date: Thu,  4 Jun 2026 15:01:21 +0530
Message-Id: <20260604093132.757583-3-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dqn3fCDdaJRWDRQsxZPjaaH10SwcaLdN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MSBTYWx0ZWRfX0m1vOgwIVUXM
 +0aGfZlUyCfp6b+fB2nCFEj6n0R89SN+Fpib1leaKMRsooJUiICcnSgY6vHyojHk/XgVed/ABAc
 +GBAeThzLJbFXxDPYF82ZiNNkSXzLQnfADIDOiLfj4Zlm/N2vQQSz/HQsoMmzD71Bk2+GlLH2eQ
 5LJQFaWMlzx6jAJfWeNMVcerAjTX0tLaHmFtXs1OdYMS5VZTLSVzskcf3uCg1ksF/989MaeID+M
 8fSEkMj9Omvxm6TBE0gZOUGIu4nksinolaQVDc5hvaEzkA0+BxwJeKX49Lau6Q1MPJDup0GHyyj
 h6jKbPVuOQnE4S5bxXVj8xaIYnrWYno+0thCX/mOyhekAK8vR26Fw8nWqGLUhiZG0Aw1pdCjrnT
 K0132eCj2LvmrShL6mkFOVuksnJlK+kp28kXrWuiicA+uZ7z0vB/W15kiyeV6WVyEid9TZLFwRY
 +e6fR/Hr6tUMzvc9aag==
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a21461d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=dzUh2ppR8F7ShpQMaCIA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: dqn3fCDdaJRWDRQsxZPjaaH10SwcaLdN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040091
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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

Add type definitions for Qualcomm's

	appsbl	-> APPS Boot Loader (U-Boot)
	config	-> Board/DDR related configuration
	lib	-> Library of proprietary routines

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/binman/etype/qcom_appsbl.py | 18 ++++++++++++++++++
 tools/binman/etype/qcom_config.py | 21 +++++++++++++++++++++
 tools/binman/etype/qcom_lib.py    | 21 +++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 tools/binman/etype/qcom_appsbl.py
 create mode 100644 tools/binman/etype/qcom_config.py
 create mode 100644 tools/binman/etype/qcom_lib.py

diff --git a/tools/binman/etype/qcom_appsbl.py b/tools/binman/etype/qcom_appsbl.py
new file mode 100644
index 00000000000..e308ebd2fca
--- /dev/null
+++ b/tools/binman/etype/qcom_appsbl.py
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#
+# Entry-type module for U-Boot MBN image
+#
+
+from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
+
+class Entry_qcom_appsbl(Entry_blob_named_by_arg):
+    """U-Boot mbn image
+
+    Properties / Entry arguments:
+        - filename: Filename of u-boot MBN (default 'u-boot.mbn')
+
+    This is the U-Boot MBN image.
+    """
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node, 'qcom-appsbl')
diff --git a/tools/binman/etype/qcom_config.py b/tools/binman/etype/qcom_config.py
new file mode 100644
index 00000000000..a1787c97b34
--- /dev/null
+++ b/tools/binman/etype/qcom_config.py
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#
+# Entry-type module for QC Config ELF
+#
+
+from binman.entry import Entry
+from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
+
+class Entry_qcom_config(Entry_blob_named_by_arg):
+    """QC Config ELF
+
+    Properties / Entry arguments:
+        - qcom-config-path: Filename of QC Config ELF (typically 'qcconfig.elf')
+
+    This will be part of the Qualcomm SPL based bootloader image
+
+    """
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node, 'qcom-config')
+        self.external = True
diff --git a/tools/binman/etype/qcom_lib.py b/tools/binman/etype/qcom_lib.py
new file mode 100644
index 00000000000..ca7666fe6e6
--- /dev/null
+++ b/tools/binman/etype/qcom_lib.py
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#
+# Entry-type module for QC LIB ELF
+#
+
+from binman.entry import Entry
+from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
+
+class Entry_qcom_lib(Entry_blob_named_by_arg):
+    """QC LIB ELF
+
+    Properties / Entry arguments:
+        - qcom-lib-path: Filename of QC LIB ELF (typically 'QCLib.elf')
+
+    This will be part of the Qualcomm SPL based bootloader image
+
+    """
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node, 'qcom-lib')
+        self.external = True
-- 
2.34.1

