Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C08F43698
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2093A8422D;
	Fri, 17 Apr 2026 14:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IlpkJnzP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hTQxNksZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A018425F; Fri, 17 Apr 2026 14:10:54 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1061A83B99
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H8OaSu1981934
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4/qw9S3mytX
 qmmh5JEKX39M0VwMF9ugKQUu/6gLXV7Y=; b=IlpkJnzPyZsetQOusfCQ4DlqaVH
 B3XVFSOz9pSo6BB5NpL8/VdbSjFyBpEds0yX7ncrnX+k7zxyVCA/kVsEL8ek/DZN
 LKW4NIw1qj/IYy0YDUieHyXHwHRmSk+SgW76B6OTlrb5UA0RE5d9rj7ueYZCOSaT
 VQSyTJzu08ZG301wQkcgTALczAFprwGtSgSfmJ2QFvZ3fBjhZ+JuxvUOSjS528Z3
 97CMDtwY42Xl2bht9vDg36Am19/fPTt2At8CWd3YRzPgmYvO6mraVucmdf+00xLa
 j59pc4D++BRnk0k3kZRyr5BSRbYuWf9EkfnM9PFZ3g/wq7cuqBB0haAwcRg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk52jk8mr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:10:48 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82f74f0e3c6so485790b3a.0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 05:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776427848; x=1777032648; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4/qw9S3mytXqmmh5JEKX39M0VwMF9ugKQUu/6gLXV7Y=;
 b=hTQxNksZpLFopQTqfayAFh+VWywmGJPA8JyOZZJAEm98DTHao+Zl1ospq/TpvZCofD
 FzuUfZMngcZXXviFlvklYAv4HpydklA4Auvcr9ViW1bLEc31kAExja0shmCQl8Am1WUe
 GqRdpQxiG6LxD7HihouMOT13nlvheCNMMVz99Htbrx9rT/yPnrVMsnhX3qBcQd6UN+1i
 94XryRPWv6R7V5XScZo6ODsImk1Pho/BCBXQwM+o5DZc+EZUGsQ+sInv+4JnqIcjfqlj
 WvpSvZWOtO2cMNZJhDvHPNwPke7q5nCIMGWCXEAoO1nnqZ/gM2Mj4x9AaECk4NuEbWfT
 J4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776427848; x=1777032648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4/qw9S3mytXqmmh5JEKX39M0VwMF9ugKQUu/6gLXV7Y=;
 b=CnoWkeGC9Uurvblq8dmupLbZBdBCnWXSUptmP3w6J72M9iKjpXL3pG4C2D+ysWhVSS
 qVgiCy6MFfqpQcxlBTlKJ+PNkzYaAvSXCmKQL0zOwTPXAXy4uA+DVKUbYOIox4qDBlJW
 MjC8PDZL9NExtbAHYIW3T0bf19YxoqD5aP+JKRsch0+b0MCCbf+nfDicqsMSw9gFNfVg
 Ox21WXRcF98xhgl0l3HwrA5efvxOxXd5SnIPP1xXEv5+TPLcRWVH5FFdWda2LftVU9T0
 0k+rjD74NDd2D0BsGGekE/p+YwyLXVdnOxpXyLR9UXxhd/uJnYpb1ceSc+3zrW5agYS5
 yPuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eHy6yKME4vhoowgfRDkeZmilbfiKHdzBVLZYourHmMHtgrqBejUdKszUsN787WsUdUbIEcVE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw80ySvk/Wtx/VohxevLESvypWEGTZjemUWGoV+bEDF1Ds2az0s
 LmL0dDeaxIJY+E/igK0Ye2bukVOJAEkLBf0Un/9z2tNWUvqvjPU0e/XTuasK5eKO7z7aAGw1VrH
 bDCiiHPNsg25RRcZV/1OOZEpwt/1k6e+rNSedTUzCzmLdMsKVajwExF4z
X-Gm-Gg: AeBDievAlnOBLU6xtalEXJGfUcGZGWC6Sfa4TAYsbHsKyUDaYCPFxnkpBhoiFB9L5pS
 CWsbIQTYd7geei1KFOx2miqi0QeStw2+zWmtFrcK3sdidMXkgwEtl0/1K1B29wts0JX0dMXw6EC
 jQowM5AxjOWZg9HoSJL8fe7GmMoOJS8HPFlooe6LAyYrAIn952fy0FMMd6Z7lRDH2zRu/No/MF2
 EyNMkYBrXfpuTadk7glDVzGNnNIU2sOIN8zpYHK0wpjj76zBM1KIT5QSF7PBEYOBe7Fr0YlD+eh
 51rkmtOqn23IoCQG+z1qgEadj49H7O7AmrAABnhm1k/ZG0tmFXT3Y+gz/4yyoDJhU2gmicQrN/V
 JOcgAfupzcB8NBVm/9bblyVjrKH166SC4LaJ+FecosVmbbpU9+Yo0mTXSq2ItprmeT0bo5l8no6
 rkGsnzxrOXr0HWqMlJhZXyEp7FJXp502vY6yr1qSMrbAa9J36W6TU=
X-Received: by 2002:a05:6a00:ba02:b0:82f:4cc9:1854 with SMTP id
 d2e1a72fcca58-82f8c93cffamr2660811b3a.49.1776427847882; 
 Fri, 17 Apr 2026 05:10:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:ba02:b0:82f:4cc9:1854 with SMTP id
 d2e1a72fcca58-82f8c93cffamr2660756b3a.49.1776427847239; 
 Fri, 17 Apr 2026 05:10:47 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9cbb28sm1744641b3a.13.2026.04.17.05.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 05:10:46 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com,
 mchitale@ventanamicro.com, maximmosk4@gmail.com, jonas@kwiboo.se,
 marek.vasut@mailbox.org, quentin.schulz@cherry.de, peng.fan@nxp.com,
 sajattack@postmarketos.org, balaji.selvanathan@oss.qualcomm.com,
 wolfgang.wallner@at.abb.com, e@freeshell.de, yangshiji66@outlook.com,
 jan.kiszka@siemens.com, funderscore@postmarketos.org, hs@nabladev.com,
 kory.maincent@bootlin.com, jj251510319013@gmail.com,
 carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v3 1/7] mach-snapdragon: Add generic SMEM cache infrastructure
Date: Fri, 17 Apr 2026 17:39:45 +0530
Message-Id: <20260417120951.3454249-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=buR8wkai c=1 sm=1 tr=0 ts=69e22348 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=682dY7r96GbnsSvmTqwA:9 a=z-cDqrtxhNcyntRm:21
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 6njLer37ayVwLm88EmuPO4hcW0jlHlUc
X-Proofpoint-ORIG-GUID: 6njLer37ayVwLm88EmuPO4hcW0jlHlUc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEyMiBTYWx0ZWRfX5982XLXtLNDL
 v47wDC6xPM1SbGY0LVy6dGYEX/0vdxgXZVFZc4bNsGVuo+Zcxgsy9s5kSvvxYFA0zvLYbAIkM4x
 xZ5RqDhRgM78RawWllFnTzQSvctCIN1z8u6EVLd/6ygdZvCoqe+b7YPXBsgIUYa2DpDrqrvsD5s
 6uZ95wlOhA1iXqzEQcwkpiXjDz4Ex4VaNrMCBfeEe+RE/wPkHOkZR4evlBP9jAusOMyE1DNQFey
 ktZe3vLjjkevjMEZEefT7x/ikeWOz3tG/hlFaDwT4Y3fLKbFYwc0OyoeqSbBdDLnBwtJNs0Z6m2
 38lnoh12QpY6mV7sYFICYeJwZ//A4HoLQWWaeJFRF5rPVcPqDeVBRL17qXnzuafUZcqIKtgvJWj
 4ycq9azQWDvKGa04ypgcDD/iwO9LqgK7j4QU8tugZK9vbMxi0CSZuvgL2jM8GfrocamVDVi5Qs/
 NgdW+p+/2RACywJgf6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170122
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

Add cached access functions for commonly used SMEM data to reduce
redundant SMEM lookups across the boot process.

This patch introduces three generic caching functions:
- qcom_get_smem_device(): Cached SMEM device access
- qcom_get_socinfo(): Cached socinfo structure access
- qcom_get_ram_partitions(): Cached RAM partition table access

The implementation includes new header files for data structures:
- include/soc/qcom/socinfo.h: Added socinfo header from Linux [1]
  Provides socinfo structure definitions for SoC identification
  and hardware parameters
- arch/arm/mach-snapdragon/rampart.h: Provides RAM partition table
  structures for memory layout information

The caching mechanism initializes SMEM data on first access and
returns cached pointers on subsequent calls, avoiding expensive
SMEM lookups during boot. This infrastructure is designed to be
reusable by other Qualcomm-specific features that require hardware
information from SMEM.

The functions provide a clean API for accessing:
- SoC information (chip ID, version, platform details)
- RAM partition layout for memory size calculations
- Hardware parameters needed for device-specific configurations

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/soc/qcom/socinfo.h?id=7dcc1dfaa3d1cd3aafed2beb7086ed34fdb22303

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v3:
1. Addressed the review comments
---
 arch/arm/mach-snapdragon/board.c     |  95 +++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h |  24 +++
 arch/arm/mach-snapdragon/rampart.h   | 225 +++++++++++++++++++++++++++
 include/soc/qcom/socinfo.h           | 114 ++++++++++++++
 4 files changed, 458 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/rampart.h
 create mode 100644 include/soc/qcom/socinfo.h

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 5fb3240acc5..6edb61b5b36 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -16,6 +16,7 @@
 #include <asm/system.h>
 #include <dm/device.h>
 #include <dm/pinctrl.h>
+#include <dm/uclass.h>
 #include <dm/uclass-internal.h>
 #include <dm/read.h>
 #include <power/regulator.h>
@@ -30,6 +31,7 @@
 #include <malloc.h>
 #include <fdt_support.h>
 #include <usb.h>
+#include <smem.h>
 #include <sort.h>
 #include <time.h>
 
@@ -39,6 +41,16 @@ DECLARE_GLOBAL_DATA_PTR;
 
 enum qcom_boot_source qcom_boot_source __section(".data") = 0;
 
+/**
+ * struct smem_cache - Cached SMEM device and data pointers
+ * @soc_info: Pointer to the SoC info structure
+ * @ram_part: Pointer to the RAM partition table
+ */
+static struct {
+	struct socinfo *soc_info;
+	struct usable_ram_partition_table *ram_part;
+} smem_cache;
+
 static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;
@@ -749,3 +761,86 @@ void enable_caches(void)
 	}
 	dcache_enable();
 }
+
+/**
+ * qcom_get_smem_device() - Get cached SMEM device
+ *
+ * This function provides cached access to the SMEM device.
+ * On first call, it initializes the SMEM device.
+ * Subsequent calls return the cached pointer.
+ *
+ * Return: Pointer to SMEM device on success, NULL on failure
+ */
+struct udevice *qcom_get_smem_device(void)
+{
+	struct udevice *dev;
+
+	if (uclass_first_device_err(UCLASS_SMEM, &dev)) {
+		log_err("Failed to get SMEM device\n");
+		return NULL;
+	}
+
+	return dev;
+}
+
+/**
+ * qcom_get_socinfo() - Get cached socinfo from SMEM
+ *
+ * This function provides cached access to the socinfo structure from SMEM.
+ * On first call, it initializes the SMEM device and retrieves the socinfo.
+ * Subsequent calls return the cached pointer.
+ *
+ * Return: Pointer to socinfo structure on success, NULL on failure
+ */
+struct socinfo *qcom_get_socinfo(void)
+{
+	size_t size;
+	struct udevice *dev;
+
+	if (smem_cache.soc_info)
+		return smem_cache.soc_info;
+
+	dev = qcom_get_smem_device();
+	if (!dev)
+		return NULL;
+
+	smem_cache.soc_info = smem_get(dev, 0, SMEM_HW_SW_BUILD_ID, &size);
+	if (!smem_cache.soc_info) {
+		log_err("Failed to get socinfo from SMEM\n");
+		return NULL;
+	}
+
+	return smem_cache.soc_info;
+}
+
+/**
+ * qcom_get_ram_partitions() - Get cached RAM partition table from SMEM
+ *
+ * This function provides cached access to the RAM partition table from SMEM.
+ * On first call, it retrieves the partition table from SMEM.
+ * Subsequent calls return the cached pointer.
+ *
+ * Return: Pointer to RAM partition table on success, NULL on failure
+ */
+struct usable_ram_partition_table *qcom_get_ram_partitions(void)
+{
+	size_t size;
+	struct udevice *dev;
+
+	if (smem_cache.ram_part)
+		return smem_cache.ram_part;
+
+	dev = qcom_get_smem_device();
+	if (!dev)
+		return NULL;
+
+	smem_cache.ram_part = smem_get(dev, 0,
+				       SMEM_USABLE_RAM_PARTITION_TABLE,
+				       &size);
+	if (!smem_cache.ram_part) {
+		log_err("Failed to get RAM partition table from SMEM\n");
+		return NULL;
+	}
+
+	return smem_cache.ram_part;
+}
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index b8bf574e8bb..ae426c9512d 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -3,6 +3,9 @@
 #ifndef __QCOM_PRIV_H__
 #define __QCOM_PRIV_H__
 
+#include <soc/qcom/socinfo.h>
+#include "rampart.h"
+
 /**
  * enum qcom_boot_source - Track where we got loaded from.
  * Used for capsule update logic.
@@ -17,6 +20,27 @@ enum qcom_boot_source {
 
 extern enum qcom_boot_source qcom_boot_source;
 
+/**
+ * qcom_get_smem_device() - Get cached SMEM device
+ *
+ * Return: Pointer to SMEM device on success, NULL on failure
+ */
+struct udevice *qcom_get_smem_device(void);
+
+/**
+ * qcom_get_socinfo() - Get cached socinfo from SMEM
+ *
+ * Return: Pointer to socinfo structure on success, NULL on failure
+ */
+struct socinfo *qcom_get_socinfo(void);
+
+/**
+ * qcom_get_ram_partitions() - Get cached RAM partition table from SMEM
+ *
+ * Return: Pointer to RAM partition table on success, NULL on failure
+ */
+struct usable_ram_partition_table *qcom_get_ram_partitions(void);
+
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 void qcom_configure_capsule_updates(void);
 #else
diff --git a/arch/arm/mach-snapdragon/rampart.h b/arch/arm/mach-snapdragon/rampart.h
new file mode 100644
index 00000000000..b6f056af2d0
--- /dev/null
+++ b/arch/arm/mach-snapdragon/rampart.h
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RAM partition table definitions
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#define SMEM_USABLE_RAM_PARTITION_TABLE		402
+
+#define RAM_PARTITION_H_MAJOR  03
+#define RAM_PARTITION_H_MINOR  00
+
+
+/**
+ * Total length of zero filled name string. This is not a C
+ * string, as it can occupy the total number of bytes, and if
+ * it does, it does not require a zero terminator. It cannot
+ * be manipulated with standard string handling library functions.
+ */
+#define RAM_PART_NAME_LENGTH 16
+
+/**
+ * Number of RAM partition entries which are usable by APPS.
+ */
+#define RAM_NUM_PART_ENTRIES 32
+
+/**
+ * @name: Magic numbers
+ * Used in identifying valid RAM partition table.
+ */
+#define RAM_PART_MAGIC1     0x9da5e0a8
+#define RAM_PART_MAGIC2     0xaf9ec4e2
+
+/**
+ * Must increment this version number whenever RAM structure of
+ * RAM partition table changes.
+ */
+#define RAM_PARTITION_VERSION   0x3
+
+/*
+ * Value which indicates the partition can grow to fill the
+ * rest of RAM. Must only be used on the last partition.
+ */
+#define RAM_PARTITION_GROW  0xffffffff
+
+/**
+ * RAM partition API return types.
+ */
+enum  ram_partition_return_type {
+	RAM_PART_SUCCESS = 0,             /* Successful return from API */
+	RAM_PART_NULL_PTR_ERR,            /* Partition table/entry null pointer */
+	RAM_PART_OUT_OF_BOUND_PTR_ERR,    /* Partition table pointer is not in SMEM */
+	RAM_PART_TABLE_EMPTY_ERR,         /* Trying to delete entry from empty table */
+	RAM_PART_TABLE_FULL_ERR,          /* Trying to add entry to full table */
+	RAM_PART_CATEGORY_NOT_EXIST_ERR,  /* Partition doesn't belong to any memory category */
+	RAM_PART_OTHER_ERR,               /* Unknown error */
+	RAM_PART_RETURN_MAX_SIZE = 0x7fffffff
+};
+
+/**
+ * RAM partition attributes.
+ */
+enum ram_partition_attribute_t {
+	RAM_PARTITION_DEFAULT_ATTRB = ~0,  /* No specific attribute definition */
+	RAM_PARTITION_READ_ONLY = 0,       /* Read-only RAM partition */
+	RAM_PARTITION_READWRITE,           /* Read/write RAM partition */
+	RAM_PARTITION_ATTRIBUTE_MAX_SIZE = 0x7fffffff
+};
+
+/**
+ * RAM partition categories.
+ */
+enum ram_partition_category_t {
+	RAM_PARTITION_DEFAULT_CATEGORY = ~0,  /* No specific category definition */
+	RAM_PARTITION_IRAM = 4,                   /* IRAM RAM partition */
+	RAM_PARTITION_IMEM = 5,                   /* IMEM RAM partition */
+	RAM_PARTITION_SDRAM = 14,                  /* SDRAM type without specific bus information**/
+	RAM_PARTITION_CATEGORY_MAX_SIZE = 0x7fffffff
+};
+
+/**
+ * RAM Partition domains.
+ * @note: For shared RAM partition, domain value would be 0b11:\n
+ * RAM_PARTITION_APPS_DOMAIN | RAM_PARTITION_MODEM_DOMAIN.
+ */
+enum ram_partition_domain_t {
+	RAM_PARTITION_DEFAULT_DOMAIN = 0,  /* 0b00: No specific domain definition */
+	RAM_PARTITION_APPS_DOMAIN = 1,     /* 0b01: APPS RAM partition */
+	RAM_PARTITION_MODEM_DOMAIN = 2,    /* 0b10: MODEM RAM partition */
+	RAM_PARTITION_DOMAIN_MAX_SIZE = 0x7fffffff
+};
+
+/**
+ * RAM Partition types.
+ * @note: The RAM_PARTITION_SYS_MEMORY type represents DDR rams that are attached
+ * to the current system.
+ */
+enum ram_partition_type_t {
+	RAM_PARTITION_SYS_MEMORY = 1,        /* system memory */
+	RAM_PARTITION_BOOT_REGION_MEMORY1,   /* boot loader memory 1 */
+	RAM_PARTITION_BOOT_REGION_MEMORY2,   /* boot loader memory 2, reserved */
+	RAM_PARTITION_APPSBL_MEMORY,         /* apps boot loader memory */
+	RAM_PARTITION_APPS_MEMORY,           /* apps usage memory */
+	RAM_PARTITION_TOOLS_FV_MEMORY,       /* tools usage memory */
+	RAM_PARTITION_QUANTUM_FV_MEMORY,     /* quantum usage memory */
+	RAM_PARTITION_QUEST_FV_MEMORY,       /* quest usage memory */
+	RAM_PARTITION_TYPE_MAX_SIZE = 0x7fffffff
+};
+
+/* Holds information for an entry in the RAM partition table */
+struct ram_partition_entry {
+	char name[RAM_PART_NAME_LENGTH];  /* Partition name, unused for now */
+	u64 start_address;                /* Partition start address in RAM */
+	u64 length;                       /* Partition length in RAM in Bytes */
+	u32 partition_attribute;          /* Partition attribute */
+	u32 partition_category;           /* Partition category */
+	u32 partition_domain;             /* Partition domain */
+	u32 partition_type;               /* Partition type */
+	u32 num_partitions;               /* Number of partitions on device */
+	u32 hw_info;                      /* hw information such as type and frequency */
+	u8 highest_bank_bit;              /* Highest bit corresponding to a bank */
+	u8 reserve0;                      /* Reserved for future use */
+	u8 reserve1;                      /* Reserved for future use */
+	u8 reserve2;                      /* Reserved for future use */
+	u32 min_pasr_size;                /* Minimum PASR size in MB */
+	u64 available_length;             /* Available Partition length in RAM in Bytes */
+};
+
+/*
+ * Defines the RAM partition table structure
+ *
+ * Do not change the placement of the first four elements so that future
+ * compatibility will always be guaranteed at least for the identifiers.
+ *
+ * The other portion of the structure may be changed as necessary to accommodate
+ * new features. Be sure to increment version number if you change it.
+ */
+struct usable_ram_partition_table {
+	u32 magic1;          /* Magic number to identify valid RAM partition table */
+	u32 magic2;          /* Magic number to identify valid RAM partition table */
+	u32 version;         /* Version number to track structure definition changes */
+	u32 reserved1;       /* Reserved for future use */
+
+	u32 num_partitions;  /* Number of RAM partition table entries */
+
+	u32 reserved2;       /* Added for 8 bytes alignment of header */
+
+	/* RAM partition table entries */
+	struct ram_partition_entry ram_part_entry[RAM_NUM_PART_ENTRIES];
+};
+
+/* Version 1 structure 32 Bit - Holds information for an entry in the RAM partition table */
+struct ram_partition_entry_v1 {
+	char name[RAM_PART_NAME_LENGTH];  /* Partition name, unused for now */
+	u64 start_address;                /* Partition start address in RAM */
+	u64 length;                       /* Partition length in RAM in Bytes */
+	u32 partition_attribute;          /* Partition attribute */
+	u32 partition_category;           /* Partition category */
+	u32 partition_domain;             /* Partition domain */
+	u32 partition_type;               /* Partition type */
+	u32 num_partitions;               /* Number of partitions on device */
+	u32 hw_info;                      /* hw information such as type and frequency */
+	u32 reserved4;                    /* Reserved for future use */
+	u32 reserved5;                    /* Reserved for future use */
+};
+
+/*
+ * Defines the RAM partition table structure (Version 1)
+ *
+ * Do not change the placement of the first four elements so that future
+ * compatibility will always be guaranteed at least for the identifiers.
+ *
+ * The other portion of the structure may be changed as necessary to accommodate
+ * new features. Be sure to increment version number if you change it.
+ */
+struct usable_ram_partition_table_v1 {
+	u32 magic1;          /* Magic number to identify valid RAM partition table */
+	u32 magic2;          /* Magic number to identify valid RAM partition table */
+	u32 version;         /* Version number to track structure definition changes */
+	u32 reserved1;       /* Reserved for future use */
+
+	u32 num_partitions;  /* Number of RAM partition table entries */
+
+	u32 reserved2;       /* Added for 8 bytes alignment of header */
+
+	/* RAM partition table entries */
+	struct ram_partition_entry_v1 ram_part_entry_v1[RAM_NUM_PART_ENTRIES];
+};
+
+/* Version 0 structure 32 Bit - Holds information for an entry in the RAM partition table */
+struct ram_partition_entry_v0 {
+	char name[RAM_PART_NAME_LENGTH];  /* Partition name, unused for now */
+	u32 start_address;                /* Partition start address in RAM */
+	u32 length;                       /* Partition length in RAM in Bytes */
+	u32 partition_attribute;          /* Partition attribute */
+	u32 partition_category;           /* Partition category */
+	u32 partition_domain;             /* Partition domain */
+	u32 partition_type;               /* Partition type */
+	u32 num_partitions;               /* Number of partitions on device */
+	u32 reserved3;                    /* Reserved for future use */
+	u32 reserved4;                    /* Reserved for future use */
+	u32 reserved5;                    /* Reserved for future use */
+};
+
+/*
+ * Defines the RAM partition table structure (Version 0)
+ *
+ * Do not change the placement of the first four elements so that future
+ * compatibility will always be guaranteed at least for the identifiers.
+ *
+ * The other portion of the structure may be changed as necessary to accommodate
+ * new features. Be sure to increment version number if you change it.
+ */
+struct usable_ram_partition_table_v0 {
+	u32 magic1;          /* Magic number to identify valid RAM partition table */
+	u32 magic2;          /* Magic number to identify valid RAM partition table */
+	u32 version;         /* Version number to track structure definition changes */
+	u32 reserved1;       /* Reserved for future use */
+
+	u32 num_partitions;  /* Number of RAM partition table entries */
+
+	/* RAM partition table entries */
+	struct ram_partition_entry_v0 ram_part_entry_v0[RAM_NUM_PART_ENTRIES];
+};
diff --git a/include/soc/qcom/socinfo.h b/include/soc/qcom/socinfo.h
new file mode 100644
index 00000000000..1bb6e200e1f
--- /dev/null
+++ b/include/soc/qcom/socinfo.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QCOM_SOCINFO_H__
+#define __QCOM_SOCINFO_H__
+
+#include <linux/types.h>
+
+/*
+ * SMEM item id, used to acquire handles to respective
+ * SMEM region.
+ */
+#define SMEM_HW_SW_BUILD_ID		137
+
+#define SMEM_SOCINFO_BUILD_ID_LENGTH	32
+#define SMEM_SOCINFO_CHIP_ID_LENGTH	32
+
+/*
+ * SoC version type with major number in the upper 16 bits and minor
+ * number in the lower 16 bits.
+ */
+#define SOCINFO_MAJOR(ver) (((ver) >> 16) & 0xffff)
+#define SOCINFO_MINOR(ver) ((ver) & 0xffff)
+#define SOCINFO_VERSION(maj, min)  ((((maj) & 0xffff) << 16) | ((min) & 0xffff))
+
+/* Socinfo SMEM item structure */
+struct socinfo {
+	__le32 fmt;
+	__le32 id;
+	__le32 ver;
+	char build_id[SMEM_SOCINFO_BUILD_ID_LENGTH];
+	/* Version 2 */
+	__le32 raw_id;
+	__le32 raw_ver;
+	/* Version 3 */
+	__le32 hw_plat;
+	/* Version 4 */
+	__le32 plat_ver;
+	/* Version 5 */
+	__le32 accessory_chip;
+	/* Version 6 */
+	__le32 hw_plat_subtype;
+	/* Version 7 */
+	__le32 pmic_model;
+	__le32 pmic_die_rev;
+	/* Version 8 */
+	__le32 pmic_model_1;
+	__le32 pmic_die_rev_1;
+	__le32 pmic_model_2;
+	__le32 pmic_die_rev_2;
+	/* Version 9 */
+	__le32 foundry_id;
+	/* Version 10 */
+	__le32 serial_num;
+	/* Version 11 */
+	__le32 num_pmics;
+	__le32 pmic_array_offset;
+	/* Version 12 */
+	__le32 chip_family;
+	__le32 raw_device_family;
+	__le32 raw_device_num;
+	/* Version 13 */
+	__le32 nproduct_id;
+	char chip_id[SMEM_SOCINFO_CHIP_ID_LENGTH];
+	/* Version 14 */
+	__le32 num_clusters;
+	__le32 ncluster_array_offset;
+	__le32 num_subset_parts;
+	__le32 nsubset_parts_array_offset;
+	/* Version 15 */
+	__le32 nmodem_supported;
+	/* Version 16 */
+	__le32  feature_code;
+	__le32  pcode;
+	__le32  npartnamemap_offset;
+	__le32  nnum_partname_mapping;
+	/* Version 17 */
+	__le32 oem_variant;
+	/* Version 18 */
+	__le32 num_kvps;
+	__le32 kvps_offset;
+	/* Version 19 */
+	__le32 num_func_clusters;
+	__le32 boot_cluster;
+	__le32 boot_core;
+};
+
+/* Internal feature codes */
+enum qcom_socinfo_feature_code {
+	/* External feature codes */
+	SOCINFO_FC_UNKNOWN = 0x0,
+	SOCINFO_FC_AA,
+	SOCINFO_FC_AB,
+	SOCINFO_FC_AC,
+	SOCINFO_FC_AD,
+	SOCINFO_FC_AE,
+	SOCINFO_FC_AF,
+	SOCINFO_FC_AG,
+	SOCINFO_FC_AH,
+};
+
+/* Internal feature codes */
+/* Valid values: 0 <= n <= 0xf */
+#define SOCINFO_FC_Yn(n)		(0xf1 + (n))
+#define SOCINFO_FC_INT_MAX		SOCINFO_FC_Yn(0xf)
+
+/* Product codes */
+#define SOCINFO_PC_UNKNOWN		0
+#define SOCINFO_PCn(n)			((n) + 1)
+#define SOCINFO_PC_RESERVE		(BIT(31) - 1)
+
+#endif
-- 
2.34.1

