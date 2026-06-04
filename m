Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F86CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB09084949;
	Thu,  4 Jun 2026 14:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RPPXnteV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AYoIoqrG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8B198486D; Thu,  4 Jun 2026 11:32:28 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EB1A84868
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 11:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548boal313666
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 09:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RtfhJDkeXNG
 nX44ZclM9Uf9GKc7HQuiLpZI18abcUZM=; b=RPPXnteVfPmsKd1PxvMgoxitclu
 RUGBJK84hMbNH2DvXiqSdupKTgCQWw1DGmAQL398Y9uNZKAyUOuHorz1S8tIMGXP
 wGhaVh7ssiBWfJl7Y/yRZSzuHPnRv8M+BtEpaPxxlYR4S4W7hSxNmCvDpKUxUJZc
 F8O6vdmgv4el12NI0pHvpVhmj5G5yPYzWu+fnRYOKERuqceP8rruIFUs8X3t3kqB
 X5fmJ3Pf7fwWEx5Lg8+yBH3WU1mS14Qu6uvxFHSdc7f+fBBZLKwPivq6nBlh0DxO
 AnBVtFzcMXzEDGQUO1gSLAhkCKRZaPiveY9tPedPpTrxyrqiGPOqIGf5yTw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejy5v1pc2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:32:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36d985df4cfso738079a91.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780565544; x=1781170344; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtfhJDkeXNGnX44ZclM9Uf9GKc7HQuiLpZI18abcUZM=;
 b=AYoIoqrGn5I0TfuS6Qa6uvOb/WBLCMEV7H4YArMO+axuq0MmifnX9V8byffN6Ilahq
 jxyQrYz/VQ1GP0SpSUS0PfCx33ng2dRWJe8eqWcIZfokPxKNMl+KPsLUl9iFtyL8pwLY
 MtzDlvFS8romWYEq/ykxojUrJTql4YsmUK7NQWUnPLiXVV63z6Aqz5u5ZgtK7gpdy/LW
 Gj0S+VmcWmPpoD+q0O7r8A6h+qVDg8/oGkNIJDLJPmTMzH8/pdMtox/4wYagTg9/c9Uu
 gv2V4IIh2jQAeOXsyzKJqKMwUgTrd5WnPHvKiwRCPlQYDoe1ooOlJMmxntH3rs8UK6fn
 S7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780565544; x=1781170344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RtfhJDkeXNGnX44ZclM9Uf9GKc7HQuiLpZI18abcUZM=;
 b=hkLFYUGhtFSj0Tu0v/3k7RCn5Bk5ApVNlWajnd0AaiYk/vqXMdTLB/cV2vb0RRMKCy
 UUsnbhfwEd4H6ptZo7ZzB/QSuiAPEaaXvbMI1bsQETZqKzw+NTkp+8IbUeYfSpjnJvYY
 D2YZHlWwgcmSLUsCJoweQAVeqhzyFAKQ6jnwusSqgJ46HCJdExRVWVfi1fNPhTnYu40N
 Uy9+6pMGXiijiIFiNfA0Clfwo9+3coNGMAh5PAG24zQZU5nAQHvcqJXcIKcA0xbtFnpT
 KjTpcgEutoKXUp+H9nzr/3TlzOeydP3h4J0kp/IrsIMzkbt4jM5TbgRouJ60D7841BNC
 I1Kw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zgznRLWKJS7fiiz9SQx5T6IgqHJqw+MIy/3axS/B/wx3uC8ccHfPUWrtycLsY6nB3ELPXuCg=@lists.denx.de
X-Gm-Message-State: AOJu0YyB7A17zqS1e53STNvVmOZ8nh5JkkMLOLemnB85R2Z/PagRsP2M
 2meItiUrtsDHk+mvABPiMncfvBVE1WHnrUQZR6tdEOUBXSgLb9smwF09XRWK4iihGHi8uVpOsFn
 8ZLAipur3re2LuDbTTYiOL97mmPDN93+loz54vxEh64WmYA1USNZVeWHV
X-Gm-Gg: Acq92OHJGq/b38VyWaSKak386ASdXIO7Bzoa22TWgiEjr7GDucdtyIJS31z5XJH7WM2
 ZR5y/dRpMan5XPrClEHVXi3uuTtVDWzjfoTysoKfOTPMjWYhDLYcREfxTZszQFYV+YU0inWEZSN
 EMG4sipNB5siQnXaJDouJUAQcoU/n6tKQKy1laY9Wh6Yi+qgKsYkzM75yihx5HtA0wsWOOItMCa
 UpqF+Oygyzfxp8gi6nzF3WX0P12siWwNT9hWZ6U3EGzLNuSNy9vAnZrVxS30zcV7TfL0OFYvM2r
 8tsjaUtM3/SczCGh+KOYljFIQhNPa88lsnJa4tU5eZzml682DFe96FQst/4tcuQhBRIzk/2JPWS
 CiFIs8GvGPmiUS0DsK1U8iQrmnNBLMXDLu2cTkmfTn95SL1jL2JnA2McXy6/YP1mHS71N+uJ1oc
 TuawN0ff+b/d0qobQSR3LYzEBhw27z/4vxD6c42K83ZtyJABRpwaUv9cKmCO1NQQ==
X-Received: by 2002:a05:6a21:4cc2:b0:3b4:9124:ae14 with SMTP id
 adf61e73a8af0-3b4973d547fmr8135696637.11.1780565544017; 
 Thu, 04 Jun 2026 02:32:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cc2:b0:3b4:9124:ae14 with SMTP id
 adf61e73a8af0-3b4973d547fmr8135653637.11.1780565543551; 
 Thu, 04 Jun 2026 02:32:23 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0b9b3fsm4263552a12.28.2026.06.04.02.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:32:23 -0700 (PDT)
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
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v4 03/13] dts: ipq5210-rdp504-u-boot: add override dtsi
Date: Thu,  4 Jun 2026 15:01:22 +0530
Message-Id: <20260604093132.757583-4-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MSBTYWx0ZWRfXwRS/2GeXkNz9
 2m2/9OoJQnyR/LDRA1nUQelkQtF161d/qghM/n+mAFZ35FPTzlcszN7DBqiV1ZXhzOYW2reYuU7
 8xjZlEroUtY2jNkDWOqXDsNyXwDhXKMpZF63pBMH3nPWzfOu6B54KRclPQrCmWLhuLf0KZMAK+L
 nd+d7ne3KmU2ZDASd/nl+1FETW+tcpu/zOUxne+MTXxxfNh/wsBChMIYZh4kehVAi2rjSt36fB8
 dcK2Z79mxzfYkqclynuAKvGeLg6vSws2CEf/zndk3OayUd0ZVYW1a7Ng7sLbUYaprU5Su1qHKpS
 S47ENg89xwkuFJnVWhoFo9QSLifRgYnAEVPeoFT7T8ciKdNVlQpS314EktVMoQh2T8I2GEUqxM2
 cz5cf1R3pUlDpNAOTi5rra7PhnRviJGU3s9oDODDQdMEQ7e2VEjg5dMmQYueAaxonKHL8hIdwrD
 YgCb8anGc8mYxyL0wug==
X-Proofpoint-ORIG-GUID: cn-09eX5v5qelmOfZrw5twjzWRUV2M5M
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a214629 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=cm27Pg_UAAAA:8
 a=EUspDBNiAAAA:8 a=-Vm6e4HSz0gDw6bjX8oA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: cn-09eX5v5qelmOfZrw5twjzWRUV2M5M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
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

* Add initial support for the IPQ5210 MMC based RDP platforms.
* Define memory layout statically.
* Mark the nodes that would be needed for SPL.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v4: Add binman details
---
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi | 128 ++++++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi

diff --git a/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
new file mode 100644
index 00000000000..5f19915047b
--- /dev/null
+++ b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IPQ5210 RDP504 board device tree source
+ *
+ * Copyright (c) 2026 The Linux Foundation. All rights reserved.
+ */
+
+/ {
+	/* Will be removed when SMEM parsing is updated */
+	memory@80000000 {
+		bootph-all;
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+
+	binman: binman {
+		description = "IPQ5210 boot loader";
+		fit {
+			description = "IPQ5210 Boot Loader FIT";
+			fit,fdt-list = "of-list";
+			fit,external-offset = <0x0>;
+
+			images {
+				@qcom-config-SEQ {
+					fit,operation = "split-elf";
+					description = "QC Config";
+					type = "qcom-config";
+					arch = "arm64";
+					os = "elf";
+					compression = "none";
+					fit,load;
+					fit,entry;
+					fit,data;
+
+					qcom-config {
+					};
+				};
+
+				@qcom-lib-SEQ {
+					fit,operation = "split-elf";
+					description = "QC Lib";
+					arch = "arm64";
+					os = "elf";
+					type = "qcom-lib";
+					compression = "none";
+					fit,load;
+					fit,entry;
+					fit,data;
+
+					qcom-lib {
+					};
+				};
+
+				@atf-SEQ {
+					fit,operation = "split-elf";
+					description = "ARM Trusted Firmware";
+					type = "atf_bl31";
+					arch = "arm64";
+					os = "arm-trusted-firmware";
+					compression = "none";
+					fit,load;
+					fit,entry;
+					fit,data;
+
+					atf-bl31 {
+					};
+				};
+
+				@qcom-appsbl-SEQ {
+					fit,operation = "split-elf";
+					type = "qcom-appsbl";
+					os = "U-Boot";
+					arch = "arm64";
+					compression = "none";
+					fit,load;
+					fit,entry;
+					fit,data;
+
+					qcom-appsbl {
+					};
+				};
+
+				@tee-SEQ {
+					fit,operation = "split-elf";
+					description = "TEE";
+					type = "tee_os";
+					arch = "arm64";
+					os = "tee";
+					compression = "none";
+					fit,load;
+					fit,entry;
+					fit,data;
+
+					tee-os {
+					};
+				};
+			};
+
+			configurations {
+				default = "pre-ddr";
+
+				pre-ddr {
+					description = "pre-ddr";
+					loadables = "qcom-config-1",
+						    "qcom-config-2",
+						    "qcom-config-3",
+						    "qcom-config-4",
+						    "qcom-lib-1",
+						    "qcom-lib-2",
+						    "qcom-lib-3",
+						    "qcom-lib-4";
+				};
+
+				post-ddr {
+					description = "post-ddr";
+					loadables = "atf-1",
+						    "atf-2",
+						    "atf-3",
+						    "atf-4",
+						    "atf-5",
+						    "atf-6",
+						    "qcom-appsbl-1",
+						    "tee-1";
+				};
+			};
+		};
+	};
+};
-- 
2.34.1

