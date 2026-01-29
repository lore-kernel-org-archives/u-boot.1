Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DE6D73E84
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 18:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB6DE840A2;
	Thu, 29 Jan 2026 19:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FykyzZdw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iXJkOzZ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E54383FFF; Thu, 29 Jan 2026 19:48:45 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57FD5840A2
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 19:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60THavvv2953199
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 18:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /cLwYSP5+bSvSz+vq5kg7l4I3bJJtDLx4gfLmX6JGlU=; b=FykyzZdwtXggTGX3
 AixVfh3Q09+jyYu0l7/BemkcV8abZn2+m0DCdIi23Z1r/r3zbkNQXnaNwC/4lQng
 zYWj1wudRMyHifCIH8UQU7HvwdR2uT0NF4834h33y+ORSHUE0v1pVt6QZVPFp+tR
 4U3Sz9Z8z7DqxSFqR1E6pc25q2mQ3d/qJ0W+9QwXDLJAkwA3Qq6JS62npkTyJVMe
 /6SuKXLltYp1fSW/SJwkYiT/wpo1QbEEEI1iscAI0GrUSONBiTOWWFQEqiF4sbDr
 /lMmlb6tBCcNZlharWk/YEphWYx2pQeAELy+INhkQELzAgFgbndwUf7U+d+K/Mdu
 YBTtdw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c06421n4m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 18:48:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a773db3803so14724335ad.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769712519; x=1770317319; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/cLwYSP5+bSvSz+vq5kg7l4I3bJJtDLx4gfLmX6JGlU=;
 b=iXJkOzZ5rPzqPW+Zd5szZGc0bakxHIa97Su9rvREwbtJcez91YFpXZ0ps/vLrX4GvD
 +b/VMG9vLrQATP1DHw09q9tUSwfDQFjUH/DACHDRWEg7gHg0A8Mbergr0s5OdZN5a0Hm
 3RIM/w6/5med3zVhtCkOI0tOB8xiJLCMEl1lp2arU5Fi4zqvDnALJ6S3hyDBNEo9biI4
 MvUddY0pR/OqXvl9Hkh6xlIq05h/kmd51nBAbVR7g9iWY8G90+HXvsnfu9czSZR3jmm5
 wTNoHiHVagwDj7CX11GzEAuqKnZVR1cyM9Q2U6NLw5E9AVt5CBjRUZtOUMnthxAJ6sO2
 5eDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769712519; x=1770317319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/cLwYSP5+bSvSz+vq5kg7l4I3bJJtDLx4gfLmX6JGlU=;
 b=CJMs7hDoe99T5+78IQGwIlexXXRq1pVUxek/uynkmyRwDGq94eqqD9z60L1HSJ+yGc
 Tv/agarvp3BvAkrRgNL0/PEatN5xzsH2SZn+sldVFZSDsCttHgG9n74jAcUgM3reNuH+
 wrg14QE0IhtKzPBKfbJJhwaNbF4Y7YS1OpvKujtKdJGhQbFUlo7f9z6eLFDcbKIDaBO0
 jot/S9RU5SYWMFYl770TmpSsn1K20+NauQ3Jt/SJcz4AP9K1Pg4ODWW86JOJv9DFZoq1
 +X/SaUN+mpNbITzm48WAHFs8LnN8A5dzt7OhQVpwYr9eEOXQkme0ko8bfPZnbFaUDgYS
 y7yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7TnKQ6eQxcQndh03DesZXr/gj7lLGxu7w9uMOyAhrmMJ4w814ec5C9FsA/bfuwhPMhwwx2eM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9aVndfu9W9/fZCmBcSjO0Z5BYo776iDnnnggJe0GtfrTGU83S
 69EmEeQnoVB9opFJ5b4jHbvpKUErUv8r2J4Jy1aZKU36DeIHpCqQ9d72NKs0d/ws5V6dm8mu3Wc
 HfWZ1vVYg6B8LbQJcH+VsyhKAHUKOPBcjub26ox4S4AdO51pBDaIqh1zpmkUqWjyd
X-Gm-Gg: AZuq6aKKwMD1JcffK+xyM6qSykIrpt+XXhipqb4nGLaiD9n6nSKEQZMGw2wi4TobIFU
 NAqh1NHjnj2OSallRrIvoTRK820ozrCG2sF5a74dToRQNlQ5cvQcptrYNg6E8G2ZDUKJ3WDBNMn
 c7mErgnxnOaGc/1VoKkwF1KGuwJSx77cmxXb+SFPbXWB2nQHnuAWukdwddxr34GiusCUVl2opM8
 f/GDP3oGmK3+HvFQq1PbzS+OVO9bzYBhS+kHkNQydP864Ad9BADD0mVuzCWTfh3AWVTmnimtuDg
 SHwEyBIyW+pCYuj/F++5cZ403yM6LxNtmEc8Ygv0R3poAebPCS+fq/74HyL7MzrnpIvrTHKWJEx
 3TfAr/KE0SVwD8+W8+043Li2ib7MLmR/TDjf2c4r1JfoVoRsRWbw1y8NhurDEsCW/td5TrpZTyQ
 Qj1bdoZBAHZo5uGmXjUZN8MJaQDK6B
X-Received: by 2002:a17:903:f06:b0:2a0:b438:fc15 with SMTP id
 d9443c01a7336-2a8d959c4b1mr1522995ad.11.1769712519140; 
 Thu, 29 Jan 2026 10:48:39 -0800 (PST)
X-Received: by 2002:a17:903:f06:b0:2a0:b438:fc15 with SMTP id
 d9443c01a7336-2a8d959c4b1mr1522655ad.11.1769712518498; 
 Thu, 29 Jan 2026 10:48:38 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b4c3deasm58837295ad.57.2026.01.29.10.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 10:48:38 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 quic_varada@quicinc.com, me@samcday.com, sughosh.ganu@linaro.org,
 ilias.apalodimas@linaro.org, balaji.selvanathan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v2 1/3] mach-snapdragon: Add generic SMEM cache infrastructure
Date: Fri, 30 Jan 2026 00:18:15 +0530
Message-Id: <20260129184817.224101-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129184817.224101-1-aswin.murugan@oss.qualcomm.com>
References: <20260129184817.224101-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzNCBTYWx0ZWRfX53AtORN59YCv
 sY+3oT3A6Fpyf/prDPPZji16PNenV/WdHM1mc+H+PEQ2b9Sa1sc0EcnrfStsJtoJUHv5bqn2QMX
 n2DfvbfRvWrBOdwEfjzLTTxJ1My5yICJXrZ5k5xDPNZIUs/OPd19P6O0wGyib0m+K+YMyU2JLEi
 /6UxqHpQ8EjXq2A6CQIjuo4XsCPIPEOzt6kEJ2pWtpJGkTOj5GDLCmPAONVaal+cLRM93qyycHu
 0VYrJXib1eOaMGXOuCzHXyFV/OeUmOLTFSQmDlStpFxX4sHyVUc5IJt8/gIg2MYGvm7YEkq67zd
 057kUqltihIUOyrsr4v9IqgZLGOhK81ghHh2F0+zOYDuYjdz/j1DtYZV0ILS+Oa4Q326+c9Esc2
 PG5tHepFRs5RJ7WzdKDHNYTZZaAeV22RggkRkkGreZvF1cw+s2NraJsSlRgmY0c8G06YpUrAH/x
 +ZA89QGG5kZo4Hf+F5Q==
X-Proofpoint-GUID: i_diHKWGNIVMvzfb_4ZZio99QZAvlW_g
X-Proofpoint-ORIG-GUID: i_diHKWGNIVMvzfb_4ZZio99QZAvlW_g
X-Authority-Analysis: v=2.4 cv=dpTWylg4 c=1 sm=1 tr=0 ts=697bab88 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=eG-IqVDFviqFBOC7P58A:9 a=wbauRzXKhYkvNCE1:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290134
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
 arch/arm/mach-snapdragon/board.c     |  92 +++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h |  10 ++
 arch/arm/mach-snapdragon/rampart.h   | 236 +++++++++++++++++++++++++++
 include/soc/qcom/socinfo.h           | 114 +++++++++++++
 4 files changed, 452 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/rampart.h
 create mode 100644 include/soc/qcom/socinfo.h

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 5fb3240acc5..cbe2aaeba6e 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -30,6 +30,7 @@
 #include <malloc.h>
 #include <fdt_support.h>
 #include <usb.h>
+#include <smem.h>
 #include <sort.h>
 #include <time.h>
 
@@ -39,6 +40,13 @@ DECLARE_GLOBAL_DATA_PTR;
 
 enum qcom_boot_source qcom_boot_source __section(".data") = 0;
 
+/* SMEM cache structure */
+static struct {
+	struct udevice *smem_dev;
+	struct socinfo *soc_info;
+	struct usable_ram_partition_table *ram_partition_table;
+} smem_cache;
+
 static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;
@@ -749,3 +757,87 @@ void enable_caches(void)
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
+	if (smem_cache.smem_dev)
+		return smem_cache.smem_dev;
+
+	if (uclass_get_device(UCLASS_SMEM, 0, &smem_cache.smem_dev)) {
+		log_err("Failed to get SMEM device\n");
+		return NULL;
+	}
+
+	return smem_cache.smem_dev;
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
+	if (smem_cache.ram_partition_table)
+		return smem_cache.ram_partition_table;
+
+	dev = qcom_get_smem_device();
+	if (!dev)
+		return NULL;
+
+	smem_cache.ram_partition_table = smem_get(dev, 0,
+						  SMEM_USABLE_RAM_PARTITION_TABLE,
+						  &size);
+	if (!smem_cache.ram_partition_table) {
+		log_err("Failed to get RAM partition table from SMEM\n");
+		return NULL;
+	}
+
+	return smem_cache.ram_partition_table;
+}
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index b8bf574e8bb..ca1363514ae 100644
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
@@ -17,6 +20,13 @@ enum qcom_boot_source {
 
 extern enum qcom_boot_source qcom_boot_source;
 
+/*
+ * SMEM Cache API - Provides cached access to SMEM data structures
+ */
+struct udevice *qcom_get_smem_device(void);
+struct socinfo *qcom_get_socinfo(void);
+struct usable_ram_partition_table *qcom_get_ram_partitions(void);
+
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 void qcom_configure_capsule_updates(void);
 #else
diff --git a/arch/arm/mach-snapdragon/rampart.h b/arch/arm/mach-snapdragon/rampart.h
new file mode 100644
index 00000000000..cfddaca0d5f
--- /dev/null
+++ b/arch/arm/mach-snapdragon/rampart.h
@@ -0,0 +1,236 @@
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
+typedef u8 uint8;
+typedef u32 uint32;
+typedef u64 uint64;
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
+#define RAM_PART_MAGIC1     0x9DA5E0A8
+#define RAM_PART_MAGIC2     0xAF9EC4E2
+
+/**
+ * Must increment this version number whenever RAM structure of
+ * RAM partition table changes.
+ */
+#define RAM_PARTITION_VERSION   0x3
+
+/**
+ * Value which indicates the partition can grow to fill the
+ * rest of RAM. Must only be used on the last partition.
+ */
+#define RAM_PARTITION_GROW  0xFFFFFFFF
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
+	RAM_PART_RETURN_MAX_SIZE = 0x7FFFFFFF
+};
+
+/**
+ * RAM partition attributes.
+ */
+enum ram_partition_attribute_t {
+	RAM_PARTITION_DEFAULT_ATTRB = ~0,  /* No specific attribute definition */
+	RAM_PARTITION_READ_ONLY = 0,       /* Read-only RAM partition */
+	RAM_PARTITION_READWRITE,           /* Read/write RAM partition */
+	RAM_PARTITION_ATTRIBUTE_MAX_SIZE = 0x7FFFFFFF
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
+	RAM_PARTITION_CATEGORY_MAX_SIZE = 0x7FFFFFFF
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
+	RAM_PARTITION_DOMAIN_MAX_SIZE = 0x7FFFFFFF
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
+	RAM_PARTITION_QUANTUM_FV_MEMORY,     /* quantum usage memory */
+	RAM_PARTITION_QUEST_FV_MEMORY,       /* quest usage memory */
+	RAM_PARTITION_TYPE_MAX_SIZE = 0x7FFFFFFF
+};
+
+/**
+ * @brief: Holds information for an entry in the RAM partition table.
+ */
+struct ram_partition_entry {
+	char name[RAM_PART_NAME_LENGTH];  /* Partition name, unused for now */
+	uint64 start_address;             /* Partition start address in RAM */
+	uint64 length;                    /* Partition length in RAM in Bytes */
+	uint32 partition_attribute;       /* Partition attribute */
+	uint32 partition_category;        /* Partition category */
+	uint32 partition_domain;          /* Partition domain */
+	uint32 partition_type;            /* Partition type */
+	uint32 num_partitions;            /* Number of partitions on device */
+	uint32 hw_info;                   /* hw information such as type and frequency */
+	uint8 highest_bank_bit;           /* Highest bit corresponding to a bank */
+	uint8 reserve0;                   /* Reserved for future use */
+	uint8 reserve1;                   /* Reserved for future use */
+	uint8 reserve2;                   /* Reserved for future use */
+	uint32 min_pasr_size;             /* Minimum PASR size in MB */
+	uint64 available_length;          /* Available Partition length in RAM in Bytes */
+};
+
+/**
+ * @brief: Defines the RAM partition table structure
+ * @note: No matter how you change the structure, do not change the placement of the
+ * first four elements so that future compatibility will always be guaranteed
+ * at least for the identifiers.
+ *
+ * @note: The other portion of the structure may be changed as necessary to accommodate
+ * new features. Be sure to increment version number if you change it.
+ */
+struct usable_ram_partition_table {
+	uint32 magic1;          /* Magic number to identify valid RAM partition table */
+	uint32 magic2;          /* Magic number to identify valid RAM partition table */
+	uint32 version;         /* Version number to track structure definition changes */
+	uint32 reserved1;       /* Reserved for future use */
+
+	uint32 num_partitions;  /* Number of RAM partition table entries */
+
+	uint32 reserved2;       /* Added for 8 bytes alignment of header */
+
+	/* RAM partition table entries */
+	struct ram_partition_entry ram_part_entry[RAM_NUM_PART_ENTRIES];
+};
+
+/**
+ * Version 1 structure 32 Bit
+ * @brief: Holds information for an entry in the RAM partition table.
+ */
+struct ram_partition_entry_v1 {
+	char name[RAM_PART_NAME_LENGTH];  /* Partition name, unused for now */
+	uint64 start_address;             /* Partition start address in RAM */
+	uint64 length;                    /* Partition length in RAM in Bytes */
+	uint32 partition_attribute;       /* Partition attribute */
+	uint32 partition_category;        /* Partition category */
+	uint32 partition_domain;          /* Partition domain */
+	uint32 partition_type;            /* Partition type */
+	uint32 num_partitions;            /* Number of partitions on device */
+	uint32 hw_info;                   /* hw information such as type and frequency */
+	uint32 reserved4;                 /* Reserved for future use */
+	uint32 reserved5;                 /* Reserved for future use */
+};
+
+/**
+ * @brief: Defines the RAM partition table structure
+ * @note: No matter how you change the structure, do not change the placement of the
+ * first four elements so that future compatibility will always be guaranteed
+ * at least for the identifiers.
+ *
+ * @note: The other portion of the structure may be changed as necessary to accommodate
+ * new features. Be sure to increment version number if you change it.
+ */
+struct usable_ram_partition_table_v1 {
+	uint32 magic1;          /* Magic number to identify valid RAM partition table */
+	uint32 magic2;          /* Magic number to identify valid RAM partition table */
+	uint32 version;         /* Version number to track structure definition changes */
+	uint32 reserved1;       /* Reserved for future use */
+
+	uint32 num_partitions;  /* Number of RAM partition table entries */
+
+	uint32 reserved2;       /* Added for 8 bytes alignment of header */
+
+	/* RAM partition table entries */
+	struct ram_partition_entry_v1 ram_part_entry_v1[RAM_NUM_PART_ENTRIES];
+};
+
+/**
+ * Version 0 structure 32 Bit
+ * @brief: Holds information for an entry in the RAM partition table.
+ */
+struct ram_partition_entry_v0 {
+	char name[RAM_PART_NAME_LENGTH];  /* Partition name, unused for now */
+	uint32 start_address;             /* Partition start address in RAM */
+	uint32 length;                    /* Partition length in RAM in Bytes */
+	uint32 partition_attribute;       /* Partition attribute */
+	uint32 partition_category;        /* Partition category */
+	uint32 partition_domain;          /* Partition domain */
+	uint32 partition_type;            /* Partition type */
+	uint32 num_partitions;            /* Number of partitions on device */
+	uint32 reserved3;                 /* Reserved for future use */
+	uint32 reserved4;                 /* Reserved for future use */
+	uint32 reserved5;                 /* Reserved for future use */
+};
+
+/**
+ * @brief: Defines the RAM partition table structure
+ * @note: No matter how you change the structure, do not change the placement of the
+ * first four elements so that future compatibility will always be guaranteed
+ * at least for the identifiers.
+ *
+ * @note: The other portion of the structure may be changed as necessary to accommodate
+ * new features. Be sure to increment version number if you change it.
+ */
+struct usable_ram_partition_table_v0 {
+	uint32 magic1;          /* Magic number to identify valid RAM partition table */
+	uint32 magic2;          /* Magic number to identify valid RAM partition table */
+	uint32 version;         /* Version number to track structure definition changes */
+	uint32 reserved1;       /* Reserved for future use */
+
+	uint32 num_partitions;  /* Number of RAM partition table entries */
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

