Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E09C5DF86
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 09:48:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F028A80C04;
	Thu, 20 Aug 2026 09:48:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lpfGzVWj8U53; Thu, 20 Aug 2026 09:48:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787219321;
	bh=m2PHBouTkk7OweoNuza2Q5La4Re2K8VH2X3J3wKjLH4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aI4rmsIrEtc1Zs1m6xg30VSMclSP4VQTq0G3IPpkNISdhkiKyUdX7uepcrQEShvaU
	 CGgJoT8bWkqzYTwen23XhWkIvtBf4dQmOOWqcBhMoPkOBtMAQc5fDZl2W1J1eJ+Iot
	 hRaL2fpPZIpjmggcNjpu7yNZWLf9Im73k46ZdjwixIVf9BdlUEe/W8O00kVzokS7D/
	 E3nhJ11x1DHa8yzIonFfSVLQ3xGY5oribFA85ePAU5nB+VFKdh2BhxW5HsrT1ELOSj
	 0Vssb6dcBT17IHi0XjAdQubBWaOzkcFB1bwQih9ahk36XLcowiOYAqrPBv5juiew64
	 4Eod5SBmYPP0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC19480C12;
	Thu, 20 Aug 2026 09:48:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 148C140B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 062A1405AB
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:48:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TC_DhtZpOhOn for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 09:48:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=jHEM5MZH; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jQN9WF6/
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 938FD405AA
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:48:37 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K9JGQm2927192
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=m2PHBouTkk7OweoNuza2Q5
 La4Re2K8VH2X3J3wKjLH4=; b=jHEM5MZHwHnZGoXyDjWsuUpImh9bHY5j8K0dGO
 XHIqwhKsXedCWJ2J9S432YUBhj33waEW8WAWoA7OcCwTRJ3DD33a1A15seK8Le/7
 a+qoNrzS+9ND8cpQvMU6f7QKnADRsH3goYIJOrQsSgNUxLYj+GLmJLYlcERJelBs
 Wj9VP68dR79dtyZDhAxKT5CY9MygQK6OXx/CwahbxKbHJOT/4u9eSayaB+/H/yYS
 WtusZK4CAtjv1q3jwjTqHrgEF9elMrH2uHWewpwmGMHghAYFIz2w7dMJkb6zU6tM
 wH3CDQ2S+wOszog8FESsd5HhS5zrBzckUHRSdfy8vI7Wb66Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xuk03kp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:48:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so5143566a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787219315; x=1787824115;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m2PHBouTkk7OweoNuza2Q5La4Re2K8VH2X3J3wKjLH4=;
 b=jQN9WF6/3923IJvc9R4NPyZ3M6ekZL6ZrlaLoRr9K/hZCqlYwigZF8wAbI4tQROvcA
 BHxYUcqc6pLa+Om9Q1TyD0bsLoK8JQn3GzF3LOubKeSPmBStQBBtO98nCVCZJlVoZV8d
 YntaDH00Nsy14EFDAtYYgMuoW7nnKbbUB69SxDYPtreUEPUW41wnNj12yWl//z8ZuYLh
 4NuMAR7czHI/62kyaup7Bzp8JRgAOEYkdmTGzpl25S9AbeTqHtPSbQKPzFb/ftBh6HZq
 DJ8dvwhiUalalLpsyN8/JUEva4GVVDx0yCeiTytPwB8HrUx2fd0oejVBOkaYXY3hpATM
 MuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787219315; x=1787824115;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m2PHBouTkk7OweoNuza2Q5La4Re2K8VH2X3J3wKjLH4=;
 b=D9i+HFX9pQNAPy4NdZTpWW4pIzfIqShPJlnMTYltOByCxte5ORcm7R8hWza07GXbAB
 lSgXt3qxtX8nc8+Yst4AV3+xcg25NYgJbW/rHW3vGC9vZsDs9MtlhTMlzcz7aL7/rbB9
 UXJRjqmEuQRQan6k5b+FlYzDS+VM/xioNEZoAOHE7KGwWy8aI4tlNk2btW99/CAluJL5
 ETzopA62LizlJCenk1KqZZWIktsq7g4oKUpK7gw7i1zAYbVzNiLSz9JkfW8p+vv6eZYo
 DT64vIoHvWh/D3gjWGSMkBHNRgoJZEXp32d6zQowm7xnVGZGOfYk3qgUtUuuocq3slrH
 wS9g==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2KSLeAFrjmnVB2xLzNvXLTFQTzojVIYLjkqq78Cnfa5DJKvSw/WqPefZ87xf/9thfE12JZOk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lWMsF8epG25/vD6iZ2SZtRCaWERwebsq31DkIMVzGk4aAsoJuo
 DBKzyQ95Js/0olpU99nL5dHiDWYkn2nB/I+0HjYzPgCtEynzfKGyTZBY8j+y1o1l12Pl+DkcOw0
 be32mH361S1GXqjXhv7VolFB2PWRIzYzD/pLH5fkUvTyA4TBXpXbaXPyMWNU/jMKi6DMlyHB6jH
 U4fsQ=
X-Gm-Gg: AR+sD12xvnAZHXRokrSZ/WiUGxUdPTa3IIvxqrQa//f3gRcWu0aukv2plP9lpBg32oj
 yPHt/ZNJX04d/fRhUNySMcCHiRL9KbmLhU+FGwXbLFIKPkzOR0s0Nhetz5783Z6ig33yJ/TVKjF
 1NGBRCy7Fp6So6zzUWldnoXlg/RcDBcwnK9pe6ToR/Xd3wW7oWRDMRUZVA9gBFVCKsNxXw5T0Fa
 g9NVDGGQUlcuElVIioeNzjIEgqAE/kxb8yxKsH9TS6h8bjJAkQ74454qQ9MGaiqD+SliH56OZEk
 kjRlqQLs/p62uflVDFndsP8cf/Ml9yryJELiE9vt6B1Y9MI6GrfE3wbafy+mBoMqtO6LKiSItf2
 V2q5fG27fEfln99lq7A+sylBxcfN+YJ015u+xQSN21J6A7JUb/s0xNGSkc26yaA7c0c0cN0dq8w
 wno6on9hii/F9X8zNycQ+ctNwqHN3G
X-Received: by 2002:a17:90b:2e42:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-3958109a525mr22511965a91.13.1787219314118; 
 Thu, 20 Aug 2026 02:48:34 -0700 (PDT)
X-Received: by 2002:a17:90b:2e42:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-3958109a525mr22511771a91.13.1787219313238; 
 Thu, 20 Aug 2026 02:48:33 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf175399sm27086898eec.26.2026.08.20.02.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 02:48:32 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 15:18:27 +0530
Subject: [PATCH] interconnect: qcom: add SC7280 interconnect driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-interconnect-qcom-sc7280-v1-1-5997fa475e99@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGrNhmoC/x3MMQ6DMAxA0asgz1gygZaUqyAGMKb1UKdNEEJC3
 J2I8Q3/H5AkqiToigOibJo0WEZVFsCf0d6COmeDI/ck7wjVVokczIRX/HP4YuLWecLXwzcTtfX
 CYwU5/0VZdL/X/XCeFyOaLzVqAAAA
X-Change-ID: 20260820-interconnect-qcom-sc7280-9584b073fca1
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Biswapriyo Nath <nathbappai@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787219309; l=55916;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=/VqOslHLgiT9XHc2wPFAZmOJwmgOcifWtpHHHaH+1tI=;
 b=c7nbPjBm31OE4Nm0kLMFO3VsPi7EW0GIp89EBAYq1CuDOhOeTPRQe3ouAbAhEk9bcdiw88yo3
 LLFKHN0f0FcB/W2B0C8yXbkcIbi6NRhUnikVDq8QgDkXrU/62gHuXaI
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: NMBMZ3_6Kxx0i72_eYDOTWUcB5iej7_M
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3MiBTYWx0ZWRfXwTq3SGdGChKs
 Dfc1TgUj6mgWTmE01eaW2iqqprmicfKWaWwh1UDCh6AT4Eqh/cwARXhVkdULfEeaqXR34F04wCw
 nc3g4lK4qy1IM9aYNJ8bxl0HlE4Z9Y0=
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a86cd73 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=rY-0gul9p_gc7jP5mKQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3MiBTYWx0ZWRfX4oVfB3rDrxn6
 nIgVpv/H2AXhJ+dZ5M46iJtm2bjV4f/BDLheJaxLCkW/TUskfhqYGP+n7/vrRq6ly91cjET+TKx
 cIirpRg0JaOwaMnmAS46aYk6HuKwPi80u68lkjEF7xUj+KV9WEhQizT2clKIbG6hMAyFd/LPbVC
 rzqSyRd1l4Ln4vkxrtyFbuTP/JzV91zWK0ZsAnnVfgsOawngU8fV1hXQyWGhVlLdOo+T/sryvFo
 BCXbGSFVa7mBkVA/+XbY6mMldasNP7nLAhqgzP8PB5BWdW4rCiDRHP1CGZkMVVyZlpqjBVhDHJH
 5YgObEIT7XZafICx4fao7e+jZHvZPDMddgS+3rrViFPCFjVMIXEbwqsVgIey453HzcQqNrTb8nx
 YYiMATS5ex08fBkqqKs0MbVpeArWCI+GHDLND6tFIbOb8m4a5buGbCXGNIEmOS0vaLv3f+dOpUI
 rVpu7tUxKBklFCySvag==
X-Proofpoint-ORIG-GUID: NMBMZ3_6Kxx0i72_eYDOTWUcB5iej7_M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200072
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Port the SC7280 NoC provider from the Linux kernel. It describes NoC
instances and their BCMs, and reuses the existing
qcom icc-rpmh helpers for probe, bind and voting.

Taken from Linux commit 46bdcac533cc ("interconnect: qcom: Add SC7280
interconnect provider driver").

Enable it for the qcom board via CONFIG_INTERCONNECT_QCOM_SC7280, which
covers the SC7280/QCS6490 (RB3 Gen2) platform.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_defconfig             |    1 +
 drivers/interconnect/qcom/Kconfig  |    6 +
 drivers/interconnect/qcom/Makefile |    1 +
 drivers/interconnect/qcom/sc7280.c | 1903 ++++++++++++++++++++++++++++++++++++
 drivers/interconnect/qcom/sc7280.h |  154 +++
 5 files changed, 2065 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index c52f619850d..58e4b5917e1 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -93,6 +93,7 @@ CONFIG_DM_KEYBOARD=y
 CONFIG_BUTTON_KEYBOARD=y
 CONFIG_INTERCONNECT=y
 CONFIG_INTERCONNECT_QCOM_RPMH=y
+CONFIG_INTERCONNECT_QCOM_SC7280=y
 CONFIG_INTERCONNECT_QCOM_SM8650=y
 CONFIG_IOMMU=y
 CONFIG_QCOM_HYP_SMMU=y
diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index b105c3a1f9a..430bb3743d4 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -5,6 +5,12 @@ config INTERCONNECT_QCOM_RPMH
 	  Enable support for the interconnect helpers to vote with
 	  the RPMh subsystems in Qualcomm SoCs
 
+config INTERCONNECT_QCOM_SC7280
+	bool "Enable interconnect support for SC7280 SoC"
+	depends on INTERCONNECT_QCOM_RPMH
+	help
+	  Enable support for the interconnect driver for the SC7280 SoC.
+
 config INTERCONNECT_QCOM_SM8650
 	bool "Enable interconnect support for SM8650 SoC"
 	depends on INTERCONNECT_QCOM_RPMH
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index a33a65bd82e..3a34f6e9ba8 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -4,4 +4,5 @@
 #
 
 obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_RPMH) += icc-rpmh.o bcm-voter.o
+obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_SC7280) += sc7280.o
 obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_SM8650) += sm8650.o
diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
new file mode 100644
index 00000000000..3a9f0f2b74d
--- /dev/null
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -0,0 +1,1903 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dm.h>
+#include <interconnect-uclass.h>
+#include <dt-bindings/interconnect/qcom,sc7280.h>
+
+#include "icc-rpmh.h"
+#include "sc7280.h"
+
+static struct qcom_icc_node qhm_qspi = {
+	.name = "qhm_qspi",
+	.id = SC7280_MASTER_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup0 = {
+	.name = "qhm_qup0",
+	.id = SC7280_MASTER_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.id = SC7280_MASTER_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_a1noc_cfg = {
+	.name = "qnm_a1noc_cfg",
+	.id = SC7280_MASTER_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_SERVICE_A1NOC },
+};
+
+static struct qcom_icc_node xm_sdc1 = {
+	.name = "xm_sdc1",
+	.id = SC7280_MASTER_SDCC_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.id = SC7280_MASTER_SDCC_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc4 = {
+	.name = "xm_sdc4",
+	.id = SC7280_MASTER_SDCC_4,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = SC7280_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb2 = {
+	.name = "xm_usb2",
+	.id = SC7280_MASTER_USB2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.id = SC7280_MASTER_USB3_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SC7280_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_a2noc_cfg = {
+	.name = "qnm_a2noc_cfg",
+	.id = SC7280_MASTER_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_SERVICE_A2NOC },
+};
+
+static struct qcom_icc_node qnm_cnoc_datapath = {
+	.name = "qnm_cnoc_datapath",
+	.id = SC7280_MASTER_CNOC_A2NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SC7280_MASTER_CRYPTO,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.id = SC7280_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_pcie3_0 = {
+	.name = "xm_pcie3_0",
+	.id = SC7280_MASTER_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie3_1 = {
+	.name = "xm_pcie3_1",
+	.id = SC7280_MASTER_PCIE_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr = {
+	.name = "xm_qdss_etr",
+	.id = SC7280_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qup0_core_master = {
+	.name = "qup0_core_master",
+	.id = SC7280_MASTER_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_QUP_CORE_0 },
+};
+
+static struct qcom_icc_node qup1_core_master = {
+	.name = "qup1_core_master",
+	.id = SC7280_MASTER_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_QUP_CORE_1 },
+};
+
+static struct qcom_icc_node qnm_cnoc3_cnoc2 = {
+	.name = "qnm_cnoc3_cnoc2",
+	.id = SC7280_MASTER_CNOC3_CNOC2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 44,
+	.links = { SC7280_SLAVE_AHB2PHY_SOUTH,
+		   SC7280_SLAVE_AHB2PHY_NORTH,
+		   SC7280_SLAVE_CAMERA_CFG,
+		   SC7280_SLAVE_CLK_CTL,
+		   SC7280_SLAVE_CDSP_CFG,
+		   SC7280_SLAVE_RBCPR_CX_CFG,
+		   SC7280_SLAVE_RBCPR_MX_CFG,
+		   SC7280_SLAVE_CRYPTO_0_CFG,
+		   SC7280_SLAVE_CX_RDPM,
+		   SC7280_SLAVE_DCC_CFG,
+		   SC7280_SLAVE_DISPLAY_CFG,
+		   SC7280_SLAVE_GFX3D_CFG,
+		   SC7280_SLAVE_HWKM,
+		   SC7280_SLAVE_IMEM_CFG,
+		   SC7280_SLAVE_IPA_CFG,
+		   SC7280_SLAVE_IPC_ROUTER_CFG,
+		   SC7280_SLAVE_LPASS,
+		   SC7280_SLAVE_CNOC_MSS,
+		   SC7280_SLAVE_MX_RDPM,
+		   SC7280_SLAVE_PCIE_0_CFG,
+		   SC7280_SLAVE_PCIE_1_CFG,
+		   SC7280_SLAVE_PDM,
+		   SC7280_SLAVE_PIMEM_CFG,
+		   SC7280_SLAVE_PKA_WRAPPER_CFG,
+		   SC7280_SLAVE_PMU_WRAPPER_CFG,
+		   SC7280_SLAVE_QDSS_CFG,
+		   SC7280_SLAVE_QSPI_0,
+		   SC7280_SLAVE_QUP_0,
+		   SC7280_SLAVE_QUP_1,
+		   SC7280_SLAVE_SDCC_1,
+		   SC7280_SLAVE_SDCC_2,
+		   SC7280_SLAVE_SDCC_4,
+		   SC7280_SLAVE_SECURITY,
+		   SC7280_SLAVE_TCSR,
+		   SC7280_SLAVE_TLMM,
+		   SC7280_SLAVE_UFS_MEM_CFG,
+		   SC7280_SLAVE_USB2,
+		   SC7280_SLAVE_USB3_0,
+		   SC7280_SLAVE_VENUS_CFG,
+		   SC7280_SLAVE_VSENSE_CTRL_CFG,
+		   SC7280_SLAVE_A1NOC_CFG,
+		   SC7280_SLAVE_A2NOC_CFG,
+		   SC7280_SLAVE_CNOC_MNOC_CFG,
+		   SC7280_SLAVE_SNOC_CFG },
+};
+
+static struct qcom_icc_node xm_qdss_dap = {
+	.name = "xm_qdss_dap",
+	.id = SC7280_MASTER_QDSS_DAP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 45,
+	.links = { SC7280_SLAVE_AHB2PHY_SOUTH,
+		   SC7280_SLAVE_AHB2PHY_NORTH,
+		   SC7280_SLAVE_CAMERA_CFG,
+		   SC7280_SLAVE_CLK_CTL,
+		   SC7280_SLAVE_CDSP_CFG,
+		   SC7280_SLAVE_RBCPR_CX_CFG,
+		   SC7280_SLAVE_RBCPR_MX_CFG,
+		   SC7280_SLAVE_CRYPTO_0_CFG,
+		   SC7280_SLAVE_CX_RDPM,
+		   SC7280_SLAVE_DCC_CFG,
+		   SC7280_SLAVE_DISPLAY_CFG,
+		   SC7280_SLAVE_GFX3D_CFG,
+		   SC7280_SLAVE_HWKM,
+		   SC7280_SLAVE_IMEM_CFG,
+		   SC7280_SLAVE_IPA_CFG,
+		   SC7280_SLAVE_IPC_ROUTER_CFG,
+		   SC7280_SLAVE_LPASS,
+		   SC7280_SLAVE_CNOC_MSS,
+		   SC7280_SLAVE_MX_RDPM,
+		   SC7280_SLAVE_PCIE_0_CFG,
+		   SC7280_SLAVE_PCIE_1_CFG,
+		   SC7280_SLAVE_PDM,
+		   SC7280_SLAVE_PIMEM_CFG,
+		   SC7280_SLAVE_PKA_WRAPPER_CFG,
+		   SC7280_SLAVE_PMU_WRAPPER_CFG,
+		   SC7280_SLAVE_QDSS_CFG,
+		   SC7280_SLAVE_QSPI_0,
+		   SC7280_SLAVE_QUP_0,
+		   SC7280_SLAVE_QUP_1,
+		   SC7280_SLAVE_SDCC_1,
+		   SC7280_SLAVE_SDCC_2,
+		   SC7280_SLAVE_SDCC_4,
+		   SC7280_SLAVE_SECURITY,
+		   SC7280_SLAVE_TCSR,
+		   SC7280_SLAVE_TLMM,
+		   SC7280_SLAVE_UFS_MEM_CFG,
+		   SC7280_SLAVE_USB2,
+		   SC7280_SLAVE_USB3_0,
+		   SC7280_SLAVE_VENUS_CFG,
+		   SC7280_SLAVE_VSENSE_CTRL_CFG,
+		   SC7280_SLAVE_A1NOC_CFG,
+		   SC7280_SLAVE_A2NOC_CFG,
+		   SC7280_SLAVE_CNOC2_CNOC3,
+		   SC7280_SLAVE_CNOC_MNOC_CFG,
+		   SC7280_SLAVE_SNOC_CFG },
+};
+
+static struct qcom_icc_node qnm_cnoc2_cnoc3 = {
+	.name = "qnm_cnoc2_cnoc3",
+	.id = SC7280_MASTER_CNOC2_CNOC3,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 9,
+	.links = { SC7280_SLAVE_AOSS,
+		   SC7280_SLAVE_APPSS,
+		   SC7280_SLAVE_CNOC_A2NOC,
+		   SC7280_SLAVE_DDRSS_CFG,
+		   SC7280_SLAVE_BOOT_IMEM,
+		   SC7280_SLAVE_IMEM,
+		   SC7280_SLAVE_PIMEM,
+		   SC7280_SLAVE_QDSS_STM,
+		   SC7280_SLAVE_TCU },
+};
+
+static struct qcom_icc_node qnm_gemnoc_cnoc = {
+	.name = "qnm_gemnoc_cnoc",
+	.id = SC7280_MASTER_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 9,
+	.links = { SC7280_SLAVE_AOSS,
+		   SC7280_SLAVE_APPSS,
+		   SC7280_SLAVE_CNOC3_CNOC2,
+		   SC7280_SLAVE_DDRSS_CFG,
+		   SC7280_SLAVE_BOOT_IMEM,
+		   SC7280_SLAVE_IMEM,
+		   SC7280_SLAVE_PIMEM,
+		   SC7280_SLAVE_QDSS_STM,
+		   SC7280_SLAVE_TCU },
+};
+
+static struct qcom_icc_node qnm_gemnoc_pcie = {
+	.name = "qnm_gemnoc_pcie",
+	.id = SC7280_MASTER_GEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SC7280_SLAVE_PCIE_0, SC7280_SLAVE_PCIE_1 },
+};
+
+static struct qcom_icc_node qnm_cnoc_dc_noc = {
+	.name = "qnm_cnoc_dc_noc",
+	.id = SC7280_MASTER_CNOC_DC_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { SC7280_SLAVE_LLCC_CFG, SC7280_SLAVE_GEM_NOC_CFG },
+};
+
+static struct qcom_icc_node alm_gpu_tcu = {
+	.name = "alm_gpu_tcu",
+	.id = SC7280_MASTER_GPU_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node alm_sys_tcu = {
+	.name = "alm_sys_tcu",
+	.id = SC7280_MASTER_SYS_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.id = SC7280_MASTER_APPSS_PROC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC, SC7280_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qnm_cmpnoc = {
+	.name = "qnm_cmpnoc",
+	.id = SC7280_MASTER_COMPUTE_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_gemnoc_cfg = {
+	.name = "qnm_gemnoc_cfg",
+	.id = SC7280_MASTER_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 5,
+	.links = { SC7280_SLAVE_MSS_PROC_MS_MPU_CFG,
+		   SC7280_SLAVE_MCDMA_MS_MPU_CFG,
+		   SC7280_SLAVE_SERVICE_GEM_NOC_1,
+		   SC7280_SLAVE_SERVICE_GEM_NOC_2,
+		   SC7280_SLAVE_SERVICE_GEM_NOC },
+};
+
+static struct qcom_icc_node qnm_gpu = {
+	.name = "qnm_gpu",
+	.id = SC7280_MASTER_GFX3D,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = SC7280_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = SC7280_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.id = SC7280_MASTER_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 2,
+	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SC7280_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SC7280_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC, SC7280_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qhm_config_noc = {
+	.name = "qhm_config_noc",
+	.id = SC7280_MASTER_CNOC_LPASS_AG_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 6,
+	.links = { SC7280_SLAVE_LPASS_CORE_CFG,
+		   SC7280_SLAVE_LPASS_LPI_CFG,
+		   SC7280_SLAVE_LPASS_MPU_CFG,
+		   SC7280_SLAVE_LPASS_TOP_CFG,
+		   SC7280_SLAVE_SERVICES_LPASS_AML_NOC,
+		   SC7280_SLAVE_SERVICE_LPASS_AG_NOC },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SC7280_MASTER_LLCC,
+	.channels = 2,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_EBI1 },
+};
+
+static struct qcom_icc_node qnm_mnoc_cfg = {
+	.name = "qnm_mnoc_cfg",
+	.id = SC7280_MASTER_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_SERVICE_MNOC },
+};
+
+static struct qcom_icc_node qnm_video0 = {
+	.name = "qnm_video0",
+	.id = SC7280_MASTER_VIDEO_P0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video_cpu = {
+	.name = "qnm_video_cpu",
+	.id = SC7280_MASTER_VIDEO_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf = {
+	.name = "qxm_camnoc_hf",
+	.id = SC7280_MASTER_CAMNOC_HF,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_icp = {
+	.name = "qxm_camnoc_icp",
+	.id = SC7280_MASTER_CAMNOC_ICP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf = {
+	.name = "qxm_camnoc_sf",
+	.id = SC7280_MASTER_CAMNOC_SF,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_mdp0 = {
+	.name = "qxm_mdp0",
+	.id = SC7280_MASTER_MDP0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qhm_nsp_noc_config = {
+	.name = "qhm_nsp_noc_config",
+	.id = SC7280_MASTER_CDSP_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_SERVICE_NSP_NOC },
+};
+
+static struct qcom_icc_node qxm_nsp = {
+	.name = "qxm_nsp",
+	.id = SC7280_MASTER_CDSP_PROC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_CDSP_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = SC7280_MASTER_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.id = SC7280_MASTER_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_snoc_cfg = {
+	.name = "qnm_snoc_cfg",
+	.id = SC7280_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_SERVICE_SNOC },
+};
+
+static struct qcom_icc_node qxm_pimem = {
+	.name = "qxm_pimem",
+	.id = SC7280_MASTER_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_SNOC_GEM_NOC_GC },
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = SC7280_MASTER_GIC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_SLAVE_SNOC_GEM_NOC_GC },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = SC7280_SLAVE_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC7280_MASTER_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node srvc_aggre1_noc = {
+	.name = "srvc_aggre1_noc",
+	.id = SC7280_SLAVE_SERVICE_A1NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.id = SC7280_SLAVE_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC7280_MASTER_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_pcie_mem_noc = {
+	.name = "qns_pcie_mem_noc",
+	.id = SC7280_SLAVE_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC7280_MASTER_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node srvc_aggre2_noc = {
+	.name = "srvc_aggre2_noc",
+	.id = SC7280_SLAVE_SERVICE_A2NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qup0_core_slave = {
+	.name = "qup0_core_slave",
+	.id = SC7280_SLAVE_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qup1_core_slave = {
+	.name = "qup1_core_slave",
+	.id = SC7280_SLAVE_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy0 = {
+	.name = "qhs_ahb2phy0",
+	.id = SC7280_SLAVE_AHB2PHY_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy1 = {
+	.name = "qhs_ahb2phy1",
+	.id = SC7280_SLAVE_AHB2PHY_NORTH,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = SC7280_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SC7280_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_compute_cfg = {
+	.name = "qhs_compute_cfg",
+	.id = SC7280_SLAVE_CDSP_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_MASTER_CDSP_NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.id = SC7280_SLAVE_RBCPR_CX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_mx = {
+	.name = "qhs_cpr_mx",
+	.id = SC7280_SLAVE_RBCPR_MX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SC7280_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cx_rdpm = {
+	.name = "qhs_cx_rdpm",
+	.id = SC7280_SLAVE_CX_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_dcc_cfg = {
+	.name = "qhs_dcc_cfg",
+	.id = SC7280_SLAVE_DCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.id = SC7280_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = SC7280_SLAVE_GFX3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_hwkm = {
+	.name = "qhs_hwkm",
+	.id = SC7280_SLAVE_HWKM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SC7280_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SC7280_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ipc_router = {
+	.name = "qhs_ipc_router",
+	.id = SC7280_SLAVE_IPC_ROUTER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_lpass_cfg = {
+	.name = "qhs_lpass_cfg",
+	.id = SC7280_SLAVE_LPASS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_MASTER_CNOC_LPASS_AG_NOC },
+};
+
+static struct qcom_icc_node qhs_mss_cfg = {
+	.name = "qhs_mss_cfg",
+	.id = SC7280_SLAVE_CNOC_MSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_mx_rdpm = {
+	.name = "qhs_mx_rdpm",
+	.id = SC7280_SLAVE_MX_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie0_cfg = {
+	.name = "qhs_pcie0_cfg",
+	.id = SC7280_SLAVE_PCIE_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie1_cfg = {
+	.name = "qhs_pcie1_cfg",
+	.id = SC7280_SLAVE_PCIE_1_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SC7280_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pimem_cfg = {
+	.name = "qhs_pimem_cfg",
+	.id = SC7280_SLAVE_PIMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pka_wrapper_cfg = {
+	.name = "qhs_pka_wrapper_cfg",
+	.id = SC7280_SLAVE_PKA_WRAPPER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pmu_wrapper_cfg = {
+	.name = "qhs_pmu_wrapper_cfg",
+	.id = SC7280_SLAVE_PMU_WRAPPER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SC7280_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qspi = {
+	.name = "qhs_qspi",
+	.id = SC7280_SLAVE_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup0 = {
+	.name = "qhs_qup0",
+	.id = SC7280_SLAVE_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.id = SC7280_SLAVE_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc1 = {
+	.name = "qhs_sdc1",
+	.id = SC7280_SLAVE_SDCC_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.id = SC7280_SLAVE_SDCC_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc4 = {
+	.name = "qhs_sdc4",
+	.id = SC7280_SLAVE_SDCC_4,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_security = {
+	.name = "qhs_security",
+	.id = SC7280_SLAVE_SECURITY,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SC7280_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.id = SC7280_SLAVE_TLMM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = SC7280_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb2 = {
+	.name = "qhs_usb2",
+	.id = SC7280_SLAVE_USB2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3_0 = {
+	.name = "qhs_usb3_0",
+	.id = SC7280_SLAVE_USB3_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = SC7280_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.id = SC7280_SLAVE_VSENSE_CTRL_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_a1_noc_cfg = {
+	.name = "qns_a1_noc_cfg",
+	.id = SC7280_SLAVE_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_MASTER_A1NOC_CFG },
+};
+
+static struct qcom_icc_node qns_a2_noc_cfg = {
+	.name = "qns_a2_noc_cfg",
+	.id = SC7280_SLAVE_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_MASTER_A2NOC_CFG },
+};
+
+static struct qcom_icc_node qns_cnoc2_cnoc3 = {
+	.name = "qns_cnoc2_cnoc3",
+	.id = SC7280_SLAVE_CNOC2_CNOC3,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_MASTER_CNOC2_CNOC3 },
+};
+
+static struct qcom_icc_node qns_mnoc_cfg = {
+	.name = "qns_mnoc_cfg",
+	.id = SC7280_SLAVE_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_MASTER_CNOC_MNOC_CFG },
+};
+
+static struct qcom_icc_node qns_snoc_cfg = {
+	.name = "qns_snoc_cfg",
+	.id = SC7280_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_MASTER_SNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SC7280_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.id = SC7280_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_cnoc3_cnoc2 = {
+	.name = "qns_cnoc3_cnoc2",
+	.id = SC7280_SLAVE_CNOC3_CNOC2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_MASTER_CNOC3_CNOC2 },
+};
+
+static struct qcom_icc_node qns_cnoc_a2noc = {
+	.name = "qns_cnoc_a2noc",
+	.id = SC7280_SLAVE_CNOC_A2NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_MASTER_CNOC_A2NOC },
+};
+
+static struct qcom_icc_node qns_ddrss_cfg = {
+	.name = "qns_ddrss_cfg",
+	.id = SC7280_SLAVE_DDRSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_MASTER_CNOC_DC_NOC },
+};
+
+static struct qcom_icc_node qxs_boot_imem = {
+	.name = "qxs_boot_imem",
+	.id = SC7280_SLAVE_BOOT_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SC7280_SLAVE_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qxs_pimem = {
+	.name = "qxs_pimem",
+	.id = SC7280_SLAVE_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_0 = {
+	.name = "xs_pcie_0",
+	.id = SC7280_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_1 = {
+	.name = "xs_pcie_1",
+	.id = SC7280_SLAVE_PCIE_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SC7280_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SC7280_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_llcc = {
+	.name = "qhs_llcc",
+	.id = SC7280_SLAVE_LLCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gemnoc = {
+	.name = "qns_gemnoc",
+	.id = SC7280_SLAVE_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC7280_MASTER_GEM_NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
+	.name = "qhs_mdsp_ms_mpu_cfg",
+	.id = SC7280_SLAVE_MSS_PROC_MS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_modem_ms_mpu_cfg = {
+	.name = "qhs_modem_ms_mpu_cfg",
+	.id = SC7280_SLAVE_MCDMA_MS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gem_noc_cnoc = {
+	.name = "qns_gem_noc_cnoc",
+	.id = SC7280_SLAVE_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC7280_MASTER_GEM_NOC_CNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SC7280_SLAVE_LLCC,
+	.channels = 2,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC7280_MASTER_LLCC },
+};
+
+static struct qcom_icc_node qns_pcie = {
+	.name = "qns_pcie",
+	.id = SC7280_SLAVE_MEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_MASTER_GEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node srvc_even_gemnoc = {
+	.name = "srvc_even_gemnoc",
+	.id = SC7280_SLAVE_SERVICE_GEM_NOC_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node srvc_odd_gemnoc = {
+	.name = "srvc_odd_gemnoc",
+	.id = SC7280_SLAVE_SERVICE_GEM_NOC_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node srvc_sys_gemnoc = {
+	.name = "srvc_sys_gemnoc",
+	.id = SC7280_SLAVE_SERVICE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_lpass_core = {
+	.name = "qhs_lpass_core",
+	.id = SC7280_SLAVE_LPASS_CORE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_lpass_lpi = {
+	.name = "qhs_lpass_lpi",
+	.id = SC7280_SLAVE_LPASS_LPI_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_lpass_mpu = {
+	.name = "qhs_lpass_mpu",
+	.id = SC7280_SLAVE_LPASS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_lpass_top = {
+	.name = "qhs_lpass_top",
+	.id = SC7280_SLAVE_LPASS_TOP_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node srvc_niu_aml_noc = {
+	.name = "srvc_niu_aml_noc",
+	.id = SC7280_SLAVE_SERVICES_LPASS_AML_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node srvc_niu_lpass_agnoc = {
+	.name = "srvc_niu_lpass_agnoc",
+	.id = SC7280_SLAVE_SERVICE_LPASS_AG_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SC7280_SLAVE_EBI1,
+	.channels = 2,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = SC7280_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7280_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf = {
+	.name = "qns_mem_noc_sf",
+	.id = SC7280_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7280_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.id = SC7280_SLAVE_SERVICE_MNOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_nsp_gemnoc = {
+	.name = "qns_nsp_gemnoc",
+	.id = SC7280_SLAVE_CDSP_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC7280_MASTER_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node service_nsp_noc = {
+	.name = "service_nsp_noc",
+	.id = SC7280_SLAVE_SERVICE_NSP_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gemnoc_gc = {
+	.name = "qns_gemnoc_gc",
+	.id = SC7280_SLAVE_SNOC_GEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC7280_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = SC7280_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC7280_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_snoc = {
+	.name = "srvc_snoc",
+	.id = SC7280_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.enable_mask = BIT(3),
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.num_nodes = 2,
+	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie },
+};
+
+static struct qcom_icc_bcm bcm_cn1 = {
+	.name = "CN1",
+	.num_nodes = 47,
+	.nodes = { &qnm_cnoc3_cnoc2,
+		   &xm_qdss_dap,
+		   &qhs_ahb2phy0,
+		   &qhs_ahb2phy1,
+		   &qhs_camera_cfg,
+		   &qhs_clk_ctl,
+		   &qhs_compute_cfg,
+		   &qhs_cpr_cx,
+		   &qhs_cpr_mx,
+		   &qhs_crypto0_cfg,
+		   &qhs_cx_rdpm,
+		   &qhs_dcc_cfg,
+		   &qhs_display_cfg,
+		   &qhs_gpuss_cfg,
+		   &qhs_hwkm,
+		   &qhs_imem_cfg,
+		   &qhs_ipa,
+		   &qhs_ipc_router,
+		   &qhs_mss_cfg,
+		   &qhs_mx_rdpm,
+		   &qhs_pcie0_cfg,
+		   &qhs_pcie1_cfg,
+		   &qhs_pimem_cfg,
+		   &qhs_pka_wrapper_cfg,
+		   &qhs_pmu_wrapper_cfg,
+		   &qhs_qdss_cfg,
+		   &qhs_qup0,
+		   &qhs_qup1,
+		   &qhs_security,
+		   &qhs_tcsr,
+		   &qhs_tlmm,
+		   &qhs_ufs_mem_cfg,
+		   &qhs_usb2,
+		   &qhs_usb3_0,
+		   &qhs_venus_cfg,
+		   &qhs_vsense_ctrl_cfg,
+		   &qns_a1_noc_cfg,
+		   &qns_a2_noc_cfg,
+		   &qns_cnoc2_cnoc3,
+		   &qns_mnoc_cfg,
+		   &qns_snoc_cfg,
+		   &qnm_cnoc2_cnoc3,
+		   &qhs_aoss,
+		   &qhs_apss,
+		   &qns_cnoc3_cnoc2,
+		   &qns_cnoc_a2noc,
+		   &qns_ddrss_cfg },
+};
+
+static struct qcom_icc_bcm bcm_cn2 = {
+	.name = "CN2",
+	.num_nodes = 6,
+	.nodes = { &qhs_lpass_cfg, &qhs_pdm, &qhs_qspi, &qhs_sdc1, &qhs_sdc2, &qhs_sdc4 },
+};
+
+static struct qcom_icc_bcm bcm_co0 = {
+	.name = "CO0",
+	.num_nodes = 1,
+	.nodes = { &qns_nsp_gemnoc },
+};
+
+static struct qcom_icc_bcm bcm_co3 = {
+	.name = "CO3",
+	.num_nodes = 1,
+	.nodes = { &qxm_nsp },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_mm0 = {
+	.name = "MM0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.num_nodes = 2,
+	.nodes = { &qxm_camnoc_hf, &qxm_mdp0 },
+};
+
+static struct qcom_icc_bcm bcm_mm4 = {
+	.name = "MM4",
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_bcm bcm_mm5 = {
+	.name = "MM5",
+	.num_nodes = 3,
+	.nodes = { &qnm_video0, &qxm_camnoc_icp, &qxm_camnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup0_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup1 = {
+	.name = "QUP1",
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup1_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh2 = {
+	.name = "SH2",
+	.num_nodes = 2,
+	.nodes = { &alm_gpu_tcu, &alm_sys_tcu },
+};
+
+static struct qcom_icc_bcm bcm_sh3 = {
+	.name = "SH3",
+	.num_nodes = 1,
+	.nodes = { &qnm_cmpnoc },
+};
+
+static struct qcom_icc_bcm bcm_sh4 = {
+	.name = "SH4",
+	.num_nodes = 1,
+	.nodes = { &chm_apps },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_gc },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.num_nodes = 1,
+	.nodes = { &qxs_pimem },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.num_nodes = 1,
+	.nodes = { &xs_qdss_stm },
+};
+
+static struct qcom_icc_bcm bcm_sn5 = {
+	.name = "SN5",
+	.num_nodes = 1,
+	.nodes = { &xm_pcie3_0 },
+};
+
+static struct qcom_icc_bcm bcm_sn6 = {
+	.name = "SN6",
+	.num_nodes = 1,
+	.nodes = { &xm_pcie3_1 },
+};
+
+static struct qcom_icc_bcm bcm_sn7 = {
+	.name = "SN7",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn8 = {
+	.name = "SN8",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn14 = {
+	.name = "SN14",
+	.num_nodes = 1,
+	.nodes = { &qns_pcie_mem_noc },
+};
+
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
+	&bcm_sn5,
+	&bcm_sn6,
+	&bcm_sn14,
+};
+
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
+	[MASTER_QSPI_0] = &qhm_qspi,
+	[MASTER_QUP_0] = &qhm_qup0,
+	[MASTER_QUP_1] = &qhm_qup1,
+	[MASTER_A1NOC_CFG] = &qnm_a1noc_cfg,
+	[MASTER_PCIE_0] = &xm_pcie3_0,
+	[MASTER_PCIE_1] = &xm_pcie3_1,
+	[MASTER_SDCC_1] = &xm_sdc1,
+	[MASTER_SDCC_2] = &xm_sdc2,
+	[MASTER_SDCC_4] = &xm_sdc4,
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[MASTER_USB2] = &xm_usb2,
+	[MASTER_USB3_0] = &xm_usb3_0,
+	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
+	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
+	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
+};
+
+static const struct qcom_icc_desc sc7280_aggre1_noc = {
+	.nodes = aggre1_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms = aggre1_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
+	&bcm_ce0,
+};
+
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
+	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
+	[MASTER_A2NOC_CFG] = &qnm_a2noc_cfg,
+	[MASTER_CNOC_A2NOC] = &qnm_cnoc_datapath,
+	[MASTER_CRYPTO] = &qxm_crypto,
+	[MASTER_IPA] = &qxm_ipa,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr,
+	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
+	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
+};
+
+static const struct qcom_icc_desc sc7280_aggre2_noc = {
+	.nodes = aggre2_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
+	.bcms = aggre2_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const clk_virt_bcms[] = {
+	&bcm_qup0,
+	&bcm_qup1,
+};
+
+static struct qcom_icc_node * const clk_virt_nodes[] = {
+	[MASTER_QUP_CORE_0] = &qup0_core_master,
+	[MASTER_QUP_CORE_1] = &qup1_core_master,
+	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
+	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
+};
+
+static const struct qcom_icc_desc sc7280_clk_virt = {
+	.nodes = clk_virt_nodes,
+	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
+	.bcms = clk_virt_bcms,
+	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc2_bcms[] = {
+	&bcm_cn1,
+	&bcm_cn2,
+};
+
+static struct qcom_icc_node * const cnoc2_nodes[] = {
+	[MASTER_CNOC3_CNOC2] = &qnm_cnoc3_cnoc2,
+	[MASTER_QDSS_DAP] = &xm_qdss_dap,
+	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
+	[SLAVE_AHB2PHY_NORTH] = &qhs_ahb2phy1,
+	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_CDSP_CFG] = &qhs_compute_cfg,
+	[SLAVE_RBCPR_CX_CFG] = &qhs_cpr_cx,
+	[SLAVE_RBCPR_MX_CFG] = &qhs_cpr_mx,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_CX_RDPM] = &qhs_cx_rdpm,
+	[SLAVE_DCC_CFG] = &qhs_dcc_cfg,
+	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
+	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
+	[SLAVE_HWKM] = &qhs_hwkm,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_IPA_CFG] = &qhs_ipa,
+	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
+	[SLAVE_LPASS] = &qhs_lpass_cfg,
+	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
+	[SLAVE_MX_RDPM] = &qhs_mx_rdpm,
+	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
+	[SLAVE_PCIE_1_CFG] = &qhs_pcie1_cfg,
+	[SLAVE_PDM] = &qhs_pdm,
+	[SLAVE_PIMEM_CFG] = &qhs_pimem_cfg,
+	[SLAVE_PKA_WRAPPER_CFG] = &qhs_pka_wrapper_cfg,
+	[SLAVE_PMU_WRAPPER_CFG] = &qhs_pmu_wrapper_cfg,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QSPI_0] = &qhs_qspi,
+	[SLAVE_QUP_0] = &qhs_qup0,
+	[SLAVE_QUP_1] = &qhs_qup1,
+	[SLAVE_SDCC_1] = &qhs_sdc1,
+	[SLAVE_SDCC_2] = &qhs_sdc2,
+	[SLAVE_SDCC_4] = &qhs_sdc4,
+	[SLAVE_SECURITY] = &qhs_security,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+	[SLAVE_USB2] = &qhs_usb2,
+	[SLAVE_USB3_0] = &qhs_usb3_0,
+	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
+	[SLAVE_A1NOC_CFG] = &qns_a1_noc_cfg,
+	[SLAVE_A2NOC_CFG] = &qns_a2_noc_cfg,
+	[SLAVE_CNOC2_CNOC3] = &qns_cnoc2_cnoc3,
+	[SLAVE_CNOC_MNOC_CFG] = &qns_mnoc_cfg,
+	[SLAVE_SNOC_CFG] = &qns_snoc_cfg,
+};
+
+static const struct qcom_icc_desc sc7280_cnoc2 = {
+	.nodes = cnoc2_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc2_nodes),
+	.bcms = cnoc2_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc2_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc3_bcms[] = {
+	&bcm_cn0,
+	&bcm_cn1,
+	&bcm_sn3,
+	&bcm_sn4,
+};
+
+static struct qcom_icc_node * const cnoc3_nodes[] = {
+	[MASTER_CNOC2_CNOC3] = &qnm_cnoc2_cnoc3,
+	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
+	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_APPSS] = &qhs_apss,
+	[SLAVE_CNOC3_CNOC2] = &qns_cnoc3_cnoc2,
+	[SLAVE_CNOC_A2NOC] = &qns_cnoc_a2noc,
+	[SLAVE_DDRSS_CFG] = &qns_ddrss_cfg,
+	[SLAVE_BOOT_IMEM] = &qxs_boot_imem,
+	[SLAVE_IMEM] = &qxs_imem,
+	[SLAVE_PIMEM] = &qxs_pimem,
+	[SLAVE_PCIE_0] = &xs_pcie_0,
+	[SLAVE_PCIE_1] = &xs_pcie_1,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+static const struct qcom_icc_desc sc7280_cnoc3 = {
+	.nodes = cnoc3_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc3_nodes),
+	.bcms = cnoc3_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc3_bcms),
+};
+
+static struct qcom_icc_bcm * const dc_noc_bcms[] = {
+};
+
+static struct qcom_icc_node * const dc_noc_nodes[] = {
+	[MASTER_CNOC_DC_NOC] = &qnm_cnoc_dc_noc,
+	[SLAVE_LLCC_CFG] = &qhs_llcc,
+	[SLAVE_GEM_NOC_CFG] = &qns_gemnoc,
+};
+
+static const struct qcom_icc_desc sc7280_dc_noc = {
+	.nodes = dc_noc_nodes,
+	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
+	.bcms = dc_noc_bcms,
+	.num_bcms = ARRAY_SIZE(dc_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh2,
+	&bcm_sh3,
+	&bcm_sh4,
+};
+
+static struct qcom_icc_node * const gem_noc_nodes[] = {
+	[MASTER_GPU_TCU] = &alm_gpu_tcu,
+	[MASTER_SYS_TCU] = &alm_sys_tcu,
+	[MASTER_APPSS_PROC] = &chm_apps,
+	[MASTER_COMPUTE_NOC] = &qnm_cmpnoc,
+	[MASTER_GEM_NOC_CFG] = &qnm_gemnoc_cfg,
+	[MASTER_GFX3D] = &qnm_gpu,
+	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
+	[MASTER_ANOC_PCIE_GEM_NOC] = &qnm_pcie,
+	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[SLAVE_MSS_PROC_MS_MPU_CFG] = &qhs_mdsp_ms_mpu_cfg,
+	[SLAVE_MCDMA_MS_MPU_CFG] = &qhs_modem_ms_mpu_cfg,
+	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
+	[SLAVE_SERVICE_GEM_NOC_1] = &srvc_even_gemnoc,
+	[SLAVE_SERVICE_GEM_NOC_2] = &srvc_odd_gemnoc,
+	[SLAVE_SERVICE_GEM_NOC] = &srvc_sys_gemnoc,
+};
+
+static const struct qcom_icc_desc sc7280_gem_noc = {
+	.nodes = gem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
+	.bcms = gem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
+};
+
+static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
+	[MASTER_CNOC_LPASS_AG_NOC] = &qhm_config_noc,
+	[SLAVE_LPASS_CORE_CFG] = &qhs_lpass_core,
+	[SLAVE_LPASS_LPI_CFG] = &qhs_lpass_lpi,
+	[SLAVE_LPASS_MPU_CFG] = &qhs_lpass_mpu,
+	[SLAVE_LPASS_TOP_CFG] = &qhs_lpass_top,
+	[SLAVE_SERVICES_LPASS_AML_NOC] = &srvc_niu_aml_noc,
+	[SLAVE_SERVICE_LPASS_AG_NOC] = &srvc_niu_lpass_agnoc,
+};
+
+static const struct qcom_icc_desc sc7280_lpass_ag_noc = {
+	.nodes = lpass_ag_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
+	.bcms = lpass_ag_noc_bcms,
+	.num_bcms = ARRAY_SIZE(lpass_ag_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
+	&bcm_acv,
+	&bcm_mc0,
+};
+
+static struct qcom_icc_node * const mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+};
+
+static const struct qcom_icc_desc sc7280_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
+	&bcm_mm0,
+	&bcm_mm1,
+	&bcm_mm4,
+	&bcm_mm5,
+};
+
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
+	[MASTER_CNOC_MNOC_CFG] = &qnm_mnoc_cfg,
+	[MASTER_VIDEO_P0] = &qnm_video0,
+	[MASTER_VIDEO_PROC] = &qnm_video_cpu,
+	[MASTER_CAMNOC_HF] = &qxm_camnoc_hf,
+	[MASTER_CAMNOC_ICP] = &qxm_camnoc_icp,
+	[MASTER_CAMNOC_SF] = &qxm_camnoc_sf,
+	[MASTER_MDP0] = &qxm_mdp0,
+	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
+	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
+	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
+};
+
+static const struct qcom_icc_desc sc7280_mmss_noc = {
+	.nodes = mmss_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
+	.bcms = mmss_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const nsp_noc_bcms[] = {
+	&bcm_co0,
+	&bcm_co3,
+};
+
+static struct qcom_icc_node * const nsp_noc_nodes[] = {
+	[MASTER_CDSP_NOC_CFG] = &qhm_nsp_noc_config,
+	[MASTER_CDSP_PROC] = &qxm_nsp,
+	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
+	[SLAVE_SERVICE_NSP_NOC] = &service_nsp_noc,
+};
+
+static const struct qcom_icc_desc sc7280_nsp_noc = {
+	.nodes = nsp_noc_nodes,
+	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
+	.bcms = nsp_noc_bcms,
+	.num_bcms = ARRAY_SIZE(nsp_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_sn0,
+	&bcm_sn2,
+	&bcm_sn7,
+	&bcm_sn8,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
+	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
+	[MASTER_SNOC_CFG] = &qnm_snoc_cfg,
+	[MASTER_PIMEM] = &qxm_pimem,
+	[MASTER_GIC] = &xm_gic,
+	[SLAVE_SNOC_GEM_NOC_GC] = &qns_gemnoc_gc,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
+};
+
+static const struct qcom_icc_desc sc7280_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static const struct udevice_id qnoc_of_match[] = {
+	{ .compatible = "qcom,sc7280-aggre1-noc", .data = (ulong)&sc7280_aggre1_noc },
+	{ .compatible = "qcom,sc7280-aggre2-noc", .data = (ulong)&sc7280_aggre2_noc },
+	{ .compatible = "qcom,sc7280-clk-virt", .data = (ulong)&sc7280_clk_virt },
+	{ .compatible = "qcom,sc7280-cnoc2", .data = (ulong)&sc7280_cnoc2 },
+	{ .compatible = "qcom,sc7280-cnoc3", .data = (ulong)&sc7280_cnoc3 },
+	{ .compatible = "qcom,sc7280-dc-noc", .data = (ulong)&sc7280_dc_noc },
+	{ .compatible = "qcom,sc7280-gem-noc", .data = (ulong)&sc7280_gem_noc },
+	{ .compatible = "qcom,sc7280-lpass-ag-noc", .data = (ulong)&sc7280_lpass_ag_noc },
+	{ .compatible = "qcom,sc7280-mc-virt", .data = (ulong)&sc7280_mc_virt },
+	{ .compatible = "qcom,sc7280-mmss-noc", .data = (ulong)&sc7280_mmss_noc },
+	{ .compatible = "qcom,sc7280-nsp-noc", .data = (ulong)&sc7280_nsp_noc },
+	{ .compatible = "qcom,sc7280-system-noc", .data = (ulong)&sc7280_system_noc },
+	{ }
+};
+
+U_BOOT_DRIVER(qnoc_sc7280) = {
+	.name = "qnoc-sc7280",
+	.id = UCLASS_INTERCONNECT,
+	.of_match = qnoc_of_match,
+	.probe = qcom_icc_rpmh_probe,
+	.bind = qcom_icc_rpmh_bind,
+	.unbind = qcom_icc_rpmh_unbind,
+	.ops = &qcom_icc_rpmh_ops,
+	.plat_auto = sizeof(struct qcom_icc_provider),
+};
diff --git a/drivers/interconnect/qcom/sc7280.h b/drivers/interconnect/qcom/sc7280.h
new file mode 100644
index 00000000000..d1e88763dc9
--- /dev/null
+++ b/drivers/interconnect/qcom/sc7280.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SC7280 interconnect IDs
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SC7280_H
+#define __DRIVERS_INTERCONNECT_QCOM_SC7280_H
+
+#define SC7280_MASTER_QSPI_0			0
+#define SC7280_MASTER_QUP_0			1
+#define SC7280_MASTER_QUP_1			2
+#define SC7280_MASTER_A1NOC_CFG			3
+#define SC7280_MASTER_SDCC_1			4
+#define SC7280_MASTER_SDCC_2			5
+#define SC7280_MASTER_SDCC_4			6
+#define SC7280_MASTER_UFS_MEM			7
+#define SC7280_MASTER_USB2			8
+#define SC7280_MASTER_USB3_0			9
+#define SC7280_MASTER_QDSS_BAM			10
+#define SC7280_MASTER_A2NOC_CFG			11
+#define SC7280_MASTER_CNOC_A2NOC		12
+#define SC7280_MASTER_CRYPTO			13
+#define SC7280_MASTER_IPA			14
+#define SC7280_MASTER_PCIE_0			15
+#define SC7280_MASTER_PCIE_1			16
+#define SC7280_MASTER_QDSS_ETR			17
+#define SC7280_MASTER_QUP_CORE_0		18
+#define SC7280_MASTER_QUP_CORE_1		19
+#define SC7280_MASTER_CNOC3_CNOC2		20
+#define SC7280_MASTER_QDSS_DAP			21
+#define SC7280_MASTER_CNOC2_CNOC3		22
+#define SC7280_MASTER_GEM_NOC_CNOC		23
+#define SC7280_MASTER_GEM_NOC_PCIE_SNOC		24
+#define SC7280_MASTER_CNOC_DC_NOC		25
+#define SC7280_MASTER_GPU_TCU			26
+#define SC7280_MASTER_SYS_TCU			27
+#define SC7280_MASTER_APPSS_PROC		28
+#define SC7280_MASTER_COMPUTE_NOC		29
+#define SC7280_MASTER_GEM_NOC_CFG		30
+#define SC7280_MASTER_GFX3D			31
+#define SC7280_MASTER_MNOC_HF_MEM_NOC		32
+#define SC7280_MASTER_MNOC_SF_MEM_NOC		33
+#define SC7280_MASTER_ANOC_PCIE_GEM_NOC		34
+#define SC7280_MASTER_SNOC_GC_MEM_NOC		35
+#define SC7280_MASTER_SNOC_SF_MEM_NOC		36
+#define SC7280_MASTER_CNOC_LPASS_AG_NOC		37
+#define SC7280_MASTER_LLCC			38
+#define SC7280_MASTER_CNOC_MNOC_CFG		39
+#define SC7280_MASTER_VIDEO_P0			40
+#define SC7280_MASTER_VIDEO_PROC		41
+#define SC7280_MASTER_CAMNOC_HF			42
+#define SC7280_MASTER_CAMNOC_ICP		43
+#define SC7280_MASTER_CAMNOC_SF			44
+#define SC7280_MASTER_MDP0			45
+#define SC7280_MASTER_CDSP_NOC_CFG		46
+#define SC7280_MASTER_CDSP_PROC			47
+#define SC7280_MASTER_A1NOC_SNOC		48
+#define SC7280_MASTER_A2NOC_SNOC		49
+#define SC7280_MASTER_SNOC_CFG			50
+#define SC7280_MASTER_PIMEM			51
+#define SC7280_MASTER_GIC			52
+#define SC7280_SLAVE_A1NOC_SNOC			53
+#define SC7280_SLAVE_SERVICE_A1NOC		54
+#define SC7280_SLAVE_A2NOC_SNOC			55
+#define SC7280_SLAVE_ANOC_PCIE_GEM_NOC		56
+#define SC7280_SLAVE_SERVICE_A2NOC		57
+#define SC7280_SLAVE_QUP_CORE_0			58
+#define SC7280_SLAVE_QUP_CORE_1			59
+#define SC7280_SLAVE_AHB2PHY_SOUTH		60
+#define SC7280_SLAVE_AHB2PHY_NORTH		61
+#define SC7280_SLAVE_CAMERA_CFG			62
+#define SC7280_SLAVE_CLK_CTL			63
+#define SC7280_SLAVE_CDSP_CFG			64
+#define SC7280_SLAVE_RBCPR_CX_CFG		65
+#define SC7280_SLAVE_RBCPR_MX_CFG		66
+#define SC7280_SLAVE_CRYPTO_0_CFG		67
+#define SC7280_SLAVE_CX_RDPM			68
+#define SC7280_SLAVE_DCC_CFG			69
+#define SC7280_SLAVE_DISPLAY_CFG		70
+#define SC7280_SLAVE_GFX3D_CFG			71
+#define SC7280_SLAVE_HWKM			72
+#define SC7280_SLAVE_IMEM_CFG			73
+#define SC7280_SLAVE_IPA_CFG			74
+#define SC7280_SLAVE_IPC_ROUTER_CFG		75
+#define SC7280_SLAVE_LPASS			76
+#define SC7280_SLAVE_CNOC_MSS			77
+#define SC7280_SLAVE_MX_RDPM			78
+#define SC7280_SLAVE_PCIE_0_CFG			79
+#define SC7280_SLAVE_PCIE_1_CFG			80
+#define SC7280_SLAVE_PDM			81
+#define SC7280_SLAVE_PIMEM_CFG			82
+#define SC7280_SLAVE_PKA_WRAPPER_CFG		83
+#define SC7280_SLAVE_PMU_WRAPPER_CFG		84
+#define SC7280_SLAVE_QDSS_CFG			85
+#define SC7280_SLAVE_QSPI_0			86
+#define SC7280_SLAVE_QUP_0			87
+#define SC7280_SLAVE_QUP_1			88
+#define SC7280_SLAVE_SDCC_1			89
+#define SC7280_SLAVE_SDCC_2			90
+#define SC7280_SLAVE_SDCC_4			91
+#define SC7280_SLAVE_SECURITY			92
+#define SC7280_SLAVE_TCSR			93
+#define SC7280_SLAVE_TLMM			94
+#define SC7280_SLAVE_UFS_MEM_CFG		95
+#define SC7280_SLAVE_USB2			96
+#define SC7280_SLAVE_USB3_0			97
+#define SC7280_SLAVE_VENUS_CFG			98
+#define SC7280_SLAVE_VSENSE_CTRL_CFG		99
+#define SC7280_SLAVE_A1NOC_CFG			100
+#define SC7280_SLAVE_A2NOC_CFG			101
+#define SC7280_SLAVE_CNOC2_CNOC3		102
+#define SC7280_SLAVE_CNOC_MNOC_CFG		103
+#define SC7280_SLAVE_SNOC_CFG			104
+#define SC7280_SLAVE_AOSS			105
+#define SC7280_SLAVE_APPSS			106
+#define SC7280_SLAVE_CNOC3_CNOC2		107
+#define SC7280_SLAVE_CNOC_A2NOC			108
+#define SC7280_SLAVE_DDRSS_CFG			109
+#define SC7280_SLAVE_BOOT_IMEM			110
+#define SC7280_SLAVE_IMEM			111
+#define SC7280_SLAVE_PIMEM			112
+#define SC7280_SLAVE_PCIE_0			113
+#define SC7280_SLAVE_PCIE_1			114
+#define SC7280_SLAVE_QDSS_STM			115
+#define SC7280_SLAVE_TCU			116
+#define SC7280_SLAVE_LLCC_CFG			117
+#define SC7280_SLAVE_GEM_NOC_CFG		118
+#define SC7280_SLAVE_MSS_PROC_MS_MPU_CFG	119
+#define SC7280_SLAVE_MCDMA_MS_MPU_CFG		120
+#define SC7280_SLAVE_GEM_NOC_CNOC		121
+#define SC7280_SLAVE_LLCC			122
+#define SC7280_SLAVE_MEM_NOC_PCIE_SNOC		123
+#define SC7280_SLAVE_SERVICE_GEM_NOC_1		124
+#define SC7280_SLAVE_SERVICE_GEM_NOC_2		125
+#define SC7280_SLAVE_SERVICE_GEM_NOC		126
+#define SC7280_SLAVE_LPASS_CORE_CFG		127
+#define SC7280_SLAVE_LPASS_LPI_CFG		128
+#define SC7280_SLAVE_LPASS_MPU_CFG		129
+#define SC7280_SLAVE_LPASS_TOP_CFG		130
+#define SC7280_SLAVE_SERVICES_LPASS_AML_NOC	131
+#define SC7280_SLAVE_SERVICE_LPASS_AG_NOC	132
+#define SC7280_SLAVE_EBI1			133
+#define SC7280_SLAVE_MNOC_HF_MEM_NOC		134
+#define SC7280_SLAVE_MNOC_SF_MEM_NOC		135
+#define SC7280_SLAVE_SERVICE_MNOC		136
+#define SC7280_SLAVE_CDSP_MEM_NOC		137
+#define SC7280_SLAVE_SERVICE_NSP_NOC		138
+#define SC7280_SLAVE_SNOC_GEM_NOC_GC		139
+#define SC7280_SLAVE_SNOC_GEM_NOC_SF		140
+#define SC7280_SLAVE_SERVICE_SNOC		141
+
+#endif

---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260820-interconnect-qcom-sc7280-9584b073fca1

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

