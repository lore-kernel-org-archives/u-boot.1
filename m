Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F259F94CC1
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 04:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9F9D83936;
	Wed, 22 Apr 2026 06:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QMlRZAvD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q2dyN9uJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE66483BC8; Wed, 22 Apr 2026 06:11:28 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 759338352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 06:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LIaEhQ2936073
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 04:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=J5EkYDnUWV58DGNFLWTOtK
 NwbI18smpS4cLIqhTmEyc=; b=QMlRZAvDX62JY6dllq6jAm3vazwWzJQ0ObXkap
 OiwkFMecXWBJMLRXpsY3ZzqMS4ua431DJEVuT/hXvjVwFuYEmeSK/Ag/LGUCDCqF
 jLosrT0inf7GxakxrgsEyrl+AciZbQG6KkU4UsiHfh8NnjJjuHzYWGQoV7xa4/hj
 Cv1NfrSPQ5/3my0cmOq/XSZou7W+t3RvC4/MhuDUe8TezwnVGv2SGeAFuKVdyJKP
 0flOJ9bJ5F8DB5X/Q3KVULi/9luGuybhuLwXtJFmVrZBlG/mPdAuIE7qPAkE6Vn2
 C4h66ULo6aeuCUEVi+qHLKLNLxQcQjQcneYg0MlDaFCgzJcg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenk9jmk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 04:11:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b24cd2e2b3so46864045ad.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 21:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776831084; x=1777435884; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J5EkYDnUWV58DGNFLWTOtKNwbI18smpS4cLIqhTmEyc=;
 b=Q2dyN9uJbjTGNpaK6UzU2fwo/p92MDPiIH6OOAgJoz201pnaQOsEmVD0jnyr/DFcd6
 MwwxRS8fX5TbAbhU3ks/Ud26JLSqKLQOxCi2RBtDVz77FyqAwItFSvoL6Pe8/arSbgKU
 6+k6JejwndnzyiZuEKDWWBaNNpxiwhBGOhvR7dKkPWsooXGQbS0oyVUXqJ/kGT/Lgpe8
 Dwe+2AxzaAl1ViWHHQqKwqt1+oROv3XGOrWlDP/LH8bnOAU8Fe5KiLY91EWogZmrky2c
 U0u36GJ7tjeJMXdJf6x0nyatDCOGJ1DY8hGV1lXVbx0pqhViWGapK3OiZEqYThRFZMfc
 kE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776831084; x=1777435884;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5EkYDnUWV58DGNFLWTOtKNwbI18smpS4cLIqhTmEyc=;
 b=XgpuqB0oOXApzI/9Ltp3EuDBNWPZTkVfgZHbJsi4qQkWl0y8lpkGjtF4jKiU8Dg+jA
 af1bK8XLo0zNmG6Q2YvOnfhgdtKGuPbAzEfg1vh7+GsVLqx6YLRjxKOr8MGDBiWAQmnI
 Te5HMxX2fyJYayAvaXlXujNbfA8bGJJEUCtvcVB8kAD5uM0zrHxLYKvoC6kxdmfmbODU
 EZ1GHbJV6bjJFfFbuMbtIsXJZiixzUBbLVW0+SRr8zgkamn8/NwqgmvzpGIY+hzhTiyg
 K463FATEUHAZIIhdd+Ebkd4K/RMcuZsdfRwfgO4XMlOhtwQfIJKaSVPCcMM8ufG5hqZX
 odvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XQl7d0eZ6wRtjV6yg0ZmDyt6SjIgyZgeEh6ZpwRWI9BGQAALRa9GT3p8t+F0RU9i1oMPAJNg=@lists.denx.de
X-Gm-Message-State: AOJu0YwljfTrx8kww8zOVFlkFW2I6mMvE+Oh6XweJj/40G36FVzqoozF
 WwsC5rPk8N3AfL9bSJx5trOss9FdQFw6MjAh0tjFrPLMgQ6u2ask58oypEtBGkvj33K4Ru4zfAV
 pgcbQjqHRIdeRLQJQvRGVedCYQRybdL9tBnbComjLq2qM5D3DmedEdfB8
X-Gm-Gg: AeBDieu8DEa9c11dx1nZpQLAkSk3mEZSDGtLSnQBLtcZSLr7Ujn3fycJyslC9rWjxdP
 ei42KMWlEEMklLa8Rb4cHLp1Kerx+zRrCM8DltzWa1q8dNNCdcYx3M+mwGDaEhJher2rDPhtDPe
 sVRRg2xFyOU9oeTrwOcH0DPCz+eHUofcsnlQ+FsnJkhlyI4vva7su3+92vD2Bfp5f/uczU9DiG7
 4h6zxLkIep49zVI0Vi9O17AUsAbQK7ZgUDX9S3oq8j1Vu7MVD42E8iHL880Qbo7LzQjuBJmFZIP
 zIJ5PIcuTKX7YdkuSMGmlui9TN2CSolm2MA7sAnHwrRfyNOmexxPB5v4g8cz3mAZeN98Hq6xTp1
 ASG/dsDwDkcKKakr4T6owEXUBZMXhCl2Amp7ky0cP6Du5TD/vEsWXKVonGk9IF0/KR4k2XTb24m
 /qFSqwg/7ndSX9bXWxuVcYGbDR/1FUUhQSwg2XixGLghxattBj7J8RZag3le3V
X-Received: by 2002:a17:902:f645:b0:2ae:5163:c2aa with SMTP id
 d9443c01a7336-2b5f9f519e5mr206177455ad.20.1776831083784; 
 Tue, 21 Apr 2026 21:11:23 -0700 (PDT)
X-Received: by 2002:a17:902:f645:b0:2ae:5163:c2aa with SMTP id
 d9443c01a7336-2b5f9f519e5mr206177155ad.20.1776831083260; 
 Tue, 21 Apr 2026 21:11:23 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff3bfsm185539395ad.7.2026.04.21.21.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 21:11:22 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 09:41:18 +0530
Subject: [PATCH] arch: snapdragon: Improve serial number detection using
 SMEM interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-serial-v1-1-1f246885bd70@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGVK6GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyMjXZD6xBxdS2MjY8MkY6Mk8yRDJaDigqLUtMwKsEHRsbW1AOPQjK9
 YAAAA
X-Change-ID: 20260422-serial-93231b32b7b1
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776831079; l=2823;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=0lOy7NgBVY0VkqJzzGvWZSftethWiAvT2ufGxv/vtcA=;
 b=hE7La6Nz/m9LdmQTdyGpBltzp2sxIFk45HhCX1vZ6PA53jO1TDhiEoPWrJM/q/dp0KZp1U6QV
 DT6KIg0NLMFCAtU2MUhtIhpsNdnAGAmQlBkwTFqMJzXZg4BqG99HR6h
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: lhcElJzmZb8asKkCzrlTmmnK62PUPsuY
X-Authority-Analysis: v=2.4 cv=SONykuvH c=1 sm=1 tr=0 ts=69e84a6c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GqcJuMMKbsYl-prE61YA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: lhcElJzmZb8asKkCzrlTmmnK62PUPsuY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAzOSBTYWx0ZWRfX0eHum/jJQrvg
 oW88r0Us4pdXHE+/T/+15CTk2qx2vbFcHvmw9c8Zq4t/g+O1O2YGGZ8IyFeAYRGGa71KVxMofMS
 A1A6m9mwvX1PeOys+O0/qHODJ9HgH/8TvxDplIGj9zvxbspQTTsNMhOGSNyuB+/iP1i1PX9gjXP
 v0z46SPFTCfrdU96riF0zZpYBqqUU5eHmC0jE7dhS2F8W4fnPf6cZpwIj1V2aEDwwaUw6pgBQGi
 Ib4A/xwkrEYAcy4n4O1I/nbkE3UqV4TZb2RwmolWnChBdVEThdyaZa3NFeSmZd59HIcn18TUeI+
 MxAAUEiVenTYP95lThErLmSCZQdD8HmiJ37+fcbAExV10ur26oeGWBLnb8cmio9epZRSHhShP8Q
 Mtrqi+Nie7URiHDSNMjaTYmhDJy/HtfVjQt5gvAHlrK2JTWlA7Ph+cnXzWipwjWqPthWzoRJ2V5
 NneV0IahA96ELgBqmQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220039
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

Enhance serial number detection by prioritizing SMEM-based retrieval
over bootargs parsing for better reliability and consistency across
Qualcomm Snapdragon platforms.

Add board_serial_num() function to retrieve serial number directly
from SMEM using the socinfo interface. This provides access to the
hardware-stored serial number in shared memory, eliminating the
dependency on kernel command line parsing.

This patch depends on the following patch [1], which adds the
socinfo header file.

[1] https://lore.kernel.org/all/20260106122134.2047864-3-aswin.murugan@oss.qualcomm.com/

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board.c     | 31 +++++++++++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 5fb3240acc5..2f058038b25 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -32,6 +32,8 @@
 #include <usb.h>
 #include <sort.h>
 #include <time.h>
+#include <smem.h>
+#include <soc/qcom/socinfo.h>
 
 #include "qcom-priv.h"
 
@@ -363,10 +365,39 @@ static const char *get_cmdline(void)
 	return cmdline;
 }
 
+/**
+ * board_serial_num() - Retrieves the board serial number from SMEM
+ * @serial_num_ptr: Pointer to store the serial number
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int board_serial_num(u32 *serial_num_ptr)
+{
+	struct socinfo *soc_info_ptr;
+	struct udevice *dev_ptr;
+	size_t total_size;
+
+	if (uclass_get_device(UCLASS_SMEM, 0, &dev_ptr) != 0)
+		return -ENODEV;
+
+	soc_info_ptr = smem_get(dev_ptr, 0, SMEM_HW_SW_BUILD_ID, &total_size);
+	if (!soc_info_ptr)
+		return -ENODATA;
+
+	*serial_num_ptr = soc_info_ptr->serial_num;
+	return 0;
+}
+
 void qcom_set_serialno(void)
 {
 	const char *cmdline = get_cmdline();
 	char serial[32];
+	u32 serial_num;
+
+	if (board_serial_num(&serial_num) == 0) {
+		env_set_hex("serial#", serial_num);
+		return;
+	}
 
 	if (!cmdline) {
 		log_debug("Failed to get bootargs\n");
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index b8bf574e8bb..3da841b8cda 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -17,6 +17,8 @@ enum qcom_boot_source {
 
 extern enum qcom_boot_source qcom_boot_source;
 
+int board_serial_num(u32 *serial_num_ptr);
+
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 void qcom_configure_capsule_updates(void);
 #else

---
base-commit: 052988aa29bfd506d7ce207fbb3f5374a5dbecbb
change-id: 20260422-serial-93231b32b7b1

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

