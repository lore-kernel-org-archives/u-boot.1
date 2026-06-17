Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609FECD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CA18849F3;
	Wed, 17 Jun 2026 14:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SAk+orWg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lg0qzkkl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9799F841F2; Wed, 17 Jun 2026 12:19:08 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46B37838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8Ung71608102
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RtfhJDkeXNG
 nX44ZclM9Uf9GKc7HQuiLpZI18abcUZM=; b=SAk+orWgfjx39vT864fnXmW69NA
 sNDjUIyY9sl4asSkPBD8CRhDIEPfAWW0Ln+Cl+E2OyqlWx1O0FWmF+QKtQPer20f
 s9TuqPyQ1IiGHuq7sgxeXjTa50fWMbSu3kkr0YTYzKHG6J4haKGUO5XcBAXCx52T
 96vKLVK1iONgMJXPsqHw76H/gqHNyrNTgBhE1gr8Asa6OWC4Yq2cL8fTakNo+jSb
 9CDgBwYQOqOa7hSZWti6zaQ4pIMQbV46L9oDlzDIKO/9IsaSJNb6mcWFvfqEQcDg
 5F+lMgq5NyRjQZGpLWzvwuYLck0z4SnVidnuvkIbR43ehbp9Vrk3z0tcAIg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef22k0t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:19:04 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8423f544944so3930720b3a.3
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781691544; x=1782296344; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtfhJDkeXNGnX44ZclM9Uf9GKc7HQuiLpZI18abcUZM=;
 b=Lg0qzkklEKwFrDGx4RdQ/6B2yK/P1Isd1KP3b7ZsRH7J9s3dxdt2bDoEpUps94zXn6
 dnwhGkWwsHFVXUxlavMF4DWUg9uX9TpTNXEZ9VKxIloVVrrP/nHMDaFeP3QeelPIj1VM
 OJCaRO1JdLQYPO7XoX8j1EWFQwf6ZZK5dJwv5gMzmpPZgBLtHds1S9Xowf2JtInsb40Y
 D2QLS6wkl7ThWD8/cLN3uovTZo4sDB0e8nJIGd5IpQdUp4n9StgVkjMiONFCDq4s+Ijp
 hltC/rb3pWTuKspY3ZS4Btq3aKWDYCYYMuY/AXnk69JQcpC17cLD3RF85zqao2FWBOT7
 aNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781691544; x=1782296344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RtfhJDkeXNGnX44ZclM9Uf9GKc7HQuiLpZI18abcUZM=;
 b=m9h1t/bjno/zf49usxaTL8lffLuX0pqc2D25vbc5Tfp0P0xwf1aZkL7fU8Hl8m8LF8
 Ak5H2w2p8mr81W+VdoKBd6kFjvjXXKqCndwLXlM11jluvZWh2+ybvFxjxHUwATFVn85+
 bocajNTqSj4Q9VKyhqR/HZwOZRjxE6wXdgvLP+cBRA5vtMFlO7fAuk9vtTzk/KFrZ8WM
 qp3inJKeFWUdAqExHWNcBvwXxwKOzioHUfAHbmLaw1jLbvisIRPH6Out2i3NebUbgsM7
 nBIS2Ka1Aamz8GgDW5vAUmVUZWZJYvk/g+lIevS5VnYFOA3ZuOkzibSeJPTs9j6jVU3O
 EDNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ZTduRANiSDll/rDIvgT6hkjh+itCQn6iWMcNXKuwJ5OdaoXhi0cxx8aABO2kINwgH0uvz0OM=@lists.denx.de
X-Gm-Message-State: AOJu0YxSpT9EirLGA4H2tuiHMMPJnF3iKdjxRS+j9Ul70fLW+Swq68hp
 VWYoS5oMDKdpp7X5/g9rUauMzLE1CVAQYXj64+ZYsj6+5gv8Tx7MVKytCR0Xy5xPr5/7ZAi4+DQ
 lMIEITQuYtfewDkvUkMWOb0P2tVD8bhhyJN3CGv6iRkZvQgAPC5SCBlqc
X-Gm-Gg: Acq92OHRI+kyZ5ilQ2f4YmygxZ83Jnl939RQ/F9ofu1EYHtX7VdHrfurt9lN6mJW9q8
 noz0WHEdNNU/S875cGIhJzrb4uTCWNOSYaXlaJQB8SNdN7zSxqMP0r1ftMbOj2rkHPZ8IxgY0qu
 M0ZoEGkYa5SRpW1jOayDWsv+8fkhaL+kyB07Qms47lTnSZknwgV3+sjQ5SiELnaSeEZwvnbvodq
 UIaFqMuEsXNVmXyDB6LowdrwpA+f3RakvQekbj1mmSbhCvvunLzFze/wZEiLAZyd3oel6BzhydH
 wVsjhVc0gNaaZG0U7jLVFes1Nh88bn/dZWsI9bLjsnqBUFxf7Nqlf2jf+VI1Sr5ALIGooYjonRK
 d6FL+9O3u4LlC6W69JEqlOdaE3FHAdkzuqtBDNPEfa3Lt5ibpzQLM47ez/sYp7zjjcfKFEAjRo3
 RC2puJTiRuxCj8iNCg+bws8NnK2dDylTYr84qCZ1nk
X-Received: by 2002:a05:6a00:2e17:b0:842:6004:3fb9 with SMTP id
 d2e1a72fcca58-845245577f8mr3340942b3a.25.1781691543460; 
 Wed, 17 Jun 2026 03:19:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e17:b0:842:6004:3fb9 with SMTP id
 d2e1a72fcca58-845245577f8mr3340875b3a.25.1781691542887; 
 Wed, 17 Jun 2026 03:19:02 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c4c0sm14137413b3a.3.2026.06.17.03.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:19:02 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 marek.vasut+renesas@mailbox.org, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, mkorpershoek@kernel.org,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, dinesh.maniyam@altera.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, n-francis@ti.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 bdklingerman@gmail.com, richard.genoud@bootlin.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v5 03/13] dts: ipq5210-rdp504-u-boot: add override dtsi
Date: Wed, 17 Jun 2026 15:48:02 +0530
Message-Id: <20260617101812.299586-4-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX2gktThfwGEdw
 iOWrW4CLPxIf1g5WD31jOJeXyhStaf/4gSybBJ4bsXEnHPpMAuR0/qWXh58w2X7hZFtzk05xbTV
 xP16DZpNEqfYBThkKCGloPAUWaE2HZU=
X-Proofpoint-ORIG-GUID: qA5ujbE2zz_EwazAc-fbXrLc4c6ePTe9
X-Proofpoint-GUID: qA5ujbE2zz_EwazAc-fbXrLc4c6ePTe9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX3h8tED+SqItb
 L4I0ev+3qF5d+A/95DmqE/uqmze2QLWjxFgsMIO8G86l3cNYFb4w369BJ+dwJg0dqbdi60cai0u
 CDkzkYzSscQBYOEW5x6qiXKDxPSis+OyLeuAjxS1QF3y1szDI6ZKN6jjSae2aY8HiPKH3Isd2LC
 ZYtGDbEKuPRG4pvm7IApH6tPP7fCWXFUcVsOxntK74dZrdBLxbVeUNTmbAo/5BlGVOOtcz/gFwx
 NUYwVPeUdmT/HMk9+myX2mASrNZzmR2xmvkVj2zOHaHug7478K2ffEuFdwsHk7A2cAb2AVC/+qR
 k/tzxzun9xfwqWff+k063Q/W4qses/CgtyU+7ucLPh+ukIht7UkorU4ankW3NbpxxjAIWPLwe2i
 cVFhOCg4uKY3VafZmIQTWaW3MRI80wxtl/6dSp+iJvU09KcyP0ybnIiuB3UAZXFEiB4iKp17d/n
 YfhJs6PfYexn8qkOebA==
X-Authority-Analysis: v=2.4 cv=acpRWxot c=1 sm=1 tr=0 ts=6a327498 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=cm27Pg_UAAAA:8
 a=EUspDBNiAAAA:8 a=-Vm6e4HSz0gDw6bjX8oA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170097
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:30:36 +0200
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

