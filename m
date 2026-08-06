Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B2AC5AC7C
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 16:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36B5880EC1;
	Thu,  6 Aug 2026 16:13:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fc5A7Let4Ti0; Thu,  6 Aug 2026 16:13:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 33AE480EA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786032791;
	bh=qFpjQ7N78Cc2207UvjfRmAu9QJ1NOABN6usa/lSdgcQ=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IhlpL6a8gWMdy61JLn/RGLZUtDia54flZYHXOb8wck6HJRiHE0223+sEUx4S67Sn2
	 lqwL/DJ0mdHJZZRHYq2+dD82OY2C7VsBsjsYSLc0cy62E7RtZ+FzG/PoUAr0vqBGAh
	 QXB9Zx2HO0MMfQrz4Y0fGPKKTTVRHbpmXbOHLlFA28OP6azd2YNmGlZVpwn3PU1ev6
	 f0tEk8xCNKNtkpT9t57NuqLRnHikfYFh2kT00RKLfNKSbrKHXhl60FQoAJRzu90Ofe
	 NMEM8b505IS3yeW/waZdQWdC6OfTGUU/C/mqusOmBotjtGvxr43qlHRT87mUdQsbmB
	 TcydVoSDxQq0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33AE480EA3;
	Thu,  6 Aug 2026 16:13:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3808F2B6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E9F260806
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9_YxIFmsP3Qh for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 16:13:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 17D7D60808
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 17D7D60808
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 17D7D60808
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:13:07 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676EmlSf2808250
 for <u-boot@lists.u-boot-project.org>; Thu, 6 Aug 2026 16:13:07 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvq73263q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 16:13:07 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-ca7c1e22995so3430554a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 09:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786032776; x=1786637576;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qFpjQ7N78Cc2207UvjfRmAu9QJ1NOABN6usa/lSdgcQ=;
 b=Vzf6cBBO3DnJxbMPT4WRRSPUdWhnMgVFH70MS6ZBB4Aj5ODPXuGnC3xQpDA0vtr/PG
 Piz/1OK0wwwhhepSIeKqjgbyBBtiHgNRY3TFP7R2BcdDWHqWVx/8uRSDLfrA2iESUQpk
 8diwZFasR1jEHIKV2MY5k8H545xkUdCAnOuhA78L+FEFSTzkECvWfP3RkM+rWb3cK346
 +Jcmqf1L9yd1hX5t7dwqvuFZUzGshLT3uJPEhn7TAbgYfQN8N7g3NeGHoN9ClA3zO78d
 mOWKhOra/rNiwe+JHtnOHEZZBofnc+7FTDQ4ubLCUl0Ac3moDNnxggzbE5hUGcZBHCLi
 OJfg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLRkt8FUWjcsrND0U67p2CeAIuV+ExQyaRoAJXYPS4cITchk/Zc6jnpOqLe103M3CPbNryYS4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwcPwsgSbcGRStJNTC2smGQq8AsZdEu5CaSlK6VJ2OfrY6W8xZV
 2RCdNxKraI5QbH22Qqp8oTzyFtQTrWY9XPLLX3AU6clzKYKxDDPdRQcDleTKkNjYWPvGMYewX3Y
 XrYNrCgC4nGzqZS+qAT8F2XI7e876e+z9DAUrOHT0SyYtg7/KCjn0QBquKkLGZcAuTB9Os9w=
X-Gm-Gg: AR+sD13nKJANTA+zzjYSBOSs43AFALXRXF6rdf2Wp9kqtu0J69LQXerlR+esrvknKoo
 sla42XLQc2e9mEGNv0u4Rsplh5ckaBHdPHalj/xHV+puqaqoxcLD99Mxm5QQwbXXv/Xu4R066ZU
 VvBbaCjIt0mkX65ztyPqwbGNlaGMVAqhCsUMTOxm2woIlz1ipAl39lV9MBROMkggIflb3BVSsHm
 2ssD+ADiFSL42nRzBxI2WCiu2+eIAv7QfKRIT2qu2S1CicvgmocUulWTr+ZfCktUdHNFcJIzWfL
 Dc4tePh2AZWgReeDdqTwx6jtnRMcPVA2JF5N2lP3CGygU4oTgimQjz/nMS2Om0xdXVP2mxEQ/Hg
 QNMNgG2wTnnu5rMiQ6X2KbnBE3fB7bP911bbLqgW0xRVBHFMAW3VVYelVh3m8aHts7eFruO2b0Z
 WIRfLhiC9AVVUaBesOHzLVfYNy0ETx
X-Received: by 2002:a05:6a20:cf8d:b0:3c3:94a8:7c18 with SMTP id
 adf61e73a8af0-3cb8603af1amr20866203637.37.1786032775479; 
 Thu, 06 Aug 2026 09:12:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:cf8d:b0:3c3:94a8:7c18 with SMTP id
 adf61e73a8af0-3cb8603af1amr20866139637.37.1786032775004; 
 Thu, 06 Aug 2026 09:12:55 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586777bcfsm43381878eec.21.2026.08.06.09.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:12:54 -0700 (PDT)
Date: Thu, 06 Aug 2026 21:42:21 +0530
Subject: [PATCH 4/7] interconnect: qcom: Add QCS8300 interconnect driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-monaco-v1-4-8d7b4e2f4fe1@oss.qualcomm.com>
References: <20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com>
In-Reply-To: <20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786032752; l=9448;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=PMUTkWRmnULvzBMpJ/6ci8abLeNLMNG20zIeR+sbjIE=;
 b=JrZNPM9IyKlHDF5h/R9SVxH2v31zeg3duMkN+UPVhNLKGTTwtGBPNJW9e+YGIO32lX9HHPPs/
 nTI+O3X6dvfBt3pYanPT1SDtIAn6FJbWHQn6GpAWA/VN8jH10rMV+am
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfX8ZHpyK7TAYOt
 yjg4irdNkk4xG6DWxb7GvZCHKnT1atISWXtiMh0fIRQSeiGnxCB92g3r337yHtKxCLGQr7hjClP
 vZC+FGW+UjigecCnnfHgBXfpoJWMW9vkH/NxXgyqWIN+Ei/ZUR03Lgq/rF3bN2fld1vT7edfytc
 castYzO9Ojg8Ms7EmRTroICH1Q/cg3hyixjtxXjqKx6FadyPBLNIa4dN8VJCA6mpdJDAdfme+Gl
 S37gqTamfbOyKuuEZYAQFbd4ujlMnsfznd8VMWAl7Rix+UkAd4R8+Os3NQN7fz0oDCiwUQTzxOP
 knI8e5Buyq1CKLIT+dmIFt5mbfpPVXWvClY2i0YPsPoNLQL9sgXzY2MwJGLT4/f40LrBmNx9x5z
 KpO1HrEYCV+KMjr1VeBoA0VquYD6SPMUCM2KwFbk/GKa7jOZSVSFMVuBKXhUysDwpeiA7psZ2Di
 zIZOSf/dDdghIz/L0wA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfX/sCY0qUXFOR1
 BbdpjKqz60pXdRxjixiiApNR67ez7Y2xZjye4qYIl6IX/srFPBihR9RQOCQSVEf0U3ju4eHI1Ni
 3VpR5ASnfuOVlSHVxwSpJJ1Jr4ENuP0=
X-Authority-Analysis: v=2.4 cv=EeH4hvmC c=1 sm=1 tr=0 ts=6a74b293 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=dgP1Qy9_uxgTXmFQ1VAA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: v0ijmK8c5uCAl_cl5zSFIPHTZZLSOUxo
X-Proofpoint-GUID: v0ijmK8c5uCAl_cl5zSFIPHTZZLSOUxo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060126
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qFpjQ7N78Cc2207UvjfRmAu9QJ1NOABN6usa/lSdgcQ=; b=lBloqFk5LIpxSE13
 hf27bceWyQ52IddnYKv0d2KGPT8B7tzVb+RNA3n+WS3wbHEvtkDJvWZuFZE7Rwo0
 1yu35Nf8/yMvBMRN4to+r95p3pNL8YOee6hkMIa+jLfFcK07bt5epzsvfFybA1pB
 UH+CrqU3VJd/9iGkDesWP+OVffr06lgIKhAlTUtGJG3E6XrlRaQoAom4Vcipp3re
 DCymy+upQF9tWoLZYa77YgrgHvGrgUe4o1uNxmKlQOIHqxaW4nkoEey2bm2VcdP5
 mJwbj9wMVhw+GGju82CAZb/cFdDlWA+1DE3KYe0smeh5C0Degm/4hXcO2hgrLJm0
 eTXC9A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786032776; x=1786637576;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qFpjQ7N78Cc2207UvjfRmAu9QJ1NOABN6usa/lSdgcQ=;
 b=ezIB0fuaUHDW5NLq8q8p7kdfOBWPjJaava7utyU7QKOhtsN4LZCQ8N2QfdvVP+sEn9
 6s2p6HT193ACNAy+3ZG6ku53G1ErUv9iiLGe2h3BQxn75591q9MYYnKIy7rn8kz1nDYf
 4sSC6Y+/0EKtMteyNSM9pKIuW/Z2DHKWsxVso+PGZCJBOOfVQGaqMw3ZdGgqqEAgk5us
 42taHAPbPmn0nO6cq3XM6lSAO1PINHT9d66Upw9zWi8qs8PeecoW+vRjyeNXhdPcBu9+
 jr6cYdtEKW1NnsWMfmo5G/emw0TpHYoJgExvOB9bPHdddNB6kgscLt9QZiDiYQNFF9Lg
 y5Iw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=lBloqFk5; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ezIB0fua
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add the interconnect (NoC) driver for QCS8300.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig   |   6 +
 drivers/interconnect/qcom/Makefile  |   1 +
 drivers/interconnect/qcom/qcs8300.c | 269 ++++++++++++++++++++++++++++++++++++
 drivers/interconnect/qcom/qcs8300.h |  24 ++++
 4 files changed, 300 insertions(+)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index b105c3a1f9a..906f2fa604a 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -5,6 +5,12 @@ config INTERCONNECT_QCOM_RPMH
 	  Enable support for the interconnect helpers to vote with
 	  the RPMh subsystems in Qualcomm SoCs
 
+config INTERCONNECT_QCOM_QCS8300
+	bool "Enable interconnect support for QCS8300 SoC"
+	depends on INTERCONNECT_QCOM_RPMH
+	help
+	  Enable support for the interconnect driver for the QCS8300 SoC.
+
 config INTERCONNECT_QCOM_SM8650
 	bool "Enable interconnect support for SM8650 SoC"
 	depends on INTERCONNECT_QCOM_RPMH
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index a33a65bd82e..6ba69269621 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -4,4 +4,5 @@
 #
 
 obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_RPMH) += icc-rpmh.o bcm-voter.o
+obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_QCS8300) += qcs8300.o
 obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_SM8650) += sm8650.o
diff --git a/drivers/interconnect/qcom/qcs8300.c b/drivers/interconnect/qcom/qcs8300.c
new file mode 100644
index 00000000000..db5316af2cb
--- /dev/null
+++ b/drivers/interconnect/qcom/qcs8300.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <dm.h>
+#include <interconnect-uclass.h>
+#include <dt-bindings/interconnect/qcom,qcs8300-rpmh.h>
+
+#include "icc-rpmh.h"
+#include "qcs8300.h"
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = QCS8300_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS8300_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = QCS8300_SLAVE_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS8300_MASTER_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = QCS8300_MASTER_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS8300_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = QCS8300_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { QCS8300_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = QCS8300_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { QCS8300_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.id = QCS8300_MASTER_APPSS_PROC,
+	.channels = 4,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS8300_SLAVE_GEM_NOC_CNOC },
+};
+
+static struct qcom_icc_node qns_gem_noc_cnoc = {
+	.name = "qns_gem_noc_cnoc",
+	.id = QCS8300_SLAVE_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { QCS8300_MASTER_GEM_NOC_CNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = QCS8300_SLAVE_LLCC,
+	.channels = 4,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { QCS8300_MASTER_LLCC },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = QCS8300_MASTER_LLCC,
+	.channels = 8,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { QCS8300_SLAVE_EBI1 },
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = QCS8300_SLAVE_EBI1,
+	.channels = 8,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qnm_gemnoc_cnoc = {
+	.name = "qnm_gemnoc_cnoc",
+	.id = QCS8300_MASTER_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { QCS8300_SLAVE_UFS_MEM_CFG },
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = QCS8300_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.num_nodes = 2,
+	.nodes = { &qns_a1noc_snoc, &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
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
+	.num_nodes = 1,
+	.nodes = { &chm_apps },
+};
+
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.enable_mask = BIT(3),
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qnm_gemnoc_cnoc },
+};
+
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
+	&bcm_sn3,
+};
+
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
+};
+
+static const struct qcom_icc_desc qcs8300_aggre1_noc = {
+	.nodes = aggre1_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms = aggre1_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_sn0,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+};
+
+static const struct qcom_icc_desc qcs8300_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh2,
+};
+
+static struct qcom_icc_node * const gem_noc_nodes[] = {
+	[MASTER_APPSS_PROC] = &chm_apps,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
+	[SLAVE_LLCC] = &qns_llcc,
+};
+
+static const struct qcom_icc_desc qcs8300_gem_noc = {
+	.nodes = gem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
+	.bcms = gem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
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
+static const struct qcom_icc_desc qcs8300_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const config_noc_bcms[] = {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node * const config_noc_nodes[] = {
+	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+};
+
+static const struct qcom_icc_desc qcs8300_config_noc = {
+	.nodes = config_noc_nodes,
+	.num_nodes = ARRAY_SIZE(config_noc_nodes),
+	.bcms = config_noc_bcms,
+	.num_bcms = ARRAY_SIZE(config_noc_bcms),
+};
+
+static const struct udevice_id qnoc_of_match[] = {
+	{ .compatible = "qcom,qcs8300-aggre1-noc", .data = (ulong)&qcs8300_aggre1_noc },
+	{ .compatible = "qcom,qcs8300-system-noc", .data = (ulong)&qcs8300_system_noc },
+	{ .compatible = "qcom,qcs8300-gem-noc", .data = (ulong)&qcs8300_gem_noc },
+	{ .compatible = "qcom,qcs8300-mc-virt", .data = (ulong)&qcs8300_mc_virt },
+	{ .compatible = "qcom,qcs8300-config-noc", .data = (ulong)&qcs8300_config_noc },
+	{ }
+};
+
+U_BOOT_DRIVER(qnoc_qcs8300) = {
+	.name = "qnoc-qcs8300",
+	.id = UCLASS_INTERCONNECT,
+	.of_match = qnoc_of_match,
+	.probe = qcom_icc_rpmh_probe,
+	.bind = qcom_icc_rpmh_bind,
+	.unbind = qcom_icc_rpmh_unbind,
+	.ops = &qcom_icc_rpmh_ops,
+	.plat_auto = sizeof(struct qcom_icc_provider),
+};
diff --git a/drivers/interconnect/qcom/qcs8300.h b/drivers/interconnect/qcom/qcs8300.h
new file mode 100644
index 00000000000..2dc523d127e
--- /dev/null
+++ b/drivers/interconnect/qcom/qcs8300.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * QCS8300 interconnect IDs
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_QCS8300_H
+#define __DRIVERS_INTERCONNECT_QCOM_QCS8300_H
+
+#define QCS8300_MASTER_UFS_MEM			0
+#define QCS8300_SLAVE_A1NOC_SNOC		1
+#define QCS8300_MASTER_A1NOC_SNOC		2
+#define QCS8300_SLAVE_SNOC_GEM_NOC_SF		3
+#define QCS8300_MASTER_SNOC_SF_MEM_NOC		4
+#define QCS8300_SLAVE_LLCC			5
+#define QCS8300_MASTER_APPSS_PROC		6
+#define QCS8300_SLAVE_GEM_NOC_CNOC		7
+#define QCS8300_MASTER_GEM_NOC_CNOC		8
+#define QCS8300_MASTER_LLCC			9
+#define QCS8300_SLAVE_EBI1			10
+#define QCS8300_SLAVE_UFS_MEM_CFG		11
+
+#endif

-- 
2.34.1

