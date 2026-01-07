Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FE9CF6C17
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 09:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30CAB83AB8;
	Wed,  7 Jan 2026 10:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dkr7O2gm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UNn7gCzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E7FE83B03; Wed,  7 Jan 2026 10:14:18 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14A4783A57
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 10:14:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6077fo3G1692154
 for <u-boot@lists.denx.de>; Wed, 7 Jan 2026 09:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=4cPbeA8HxC86D3WUvlh49CgtMRQiuDrNOlg
 QeiHh0Pw=; b=Dkr7O2gmyfe+xvoO6p+2gpTXckgd+TNZSRnPNelteOQgN/BZ0rv
 gXWuUXdgX6SPRJdX4VHOBJ782vIl0bjTEM+r3kBmlQj5QHIkOyjn4nzehcOTTd0O
 yhEjFx5SGrbL44cC5JxGZwIYgMzY+oY0XHNOhjxNtjlOcLDS19dO2Gtiloc+5NeQ
 JkBBW6egTUJ56rQAyOueowoshWQzwZZKE4Na5ACdL90j2f9kQVUa/ESLL2iiWUjF
 MRQ7vfocfTdszJCASEABbtAo/E/vxgVRdRZiOopcT6ib+/VA+FypkbRMAGSTuOrF
 MkFiqbtZeSgjIegFG/Z6dxFs7ciZDv3CLGQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhayhsre1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 09:14:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34ea5074935so2268792a91.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 01:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767777253; x=1768382053; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4cPbeA8HxC86D3WUvlh49CgtMRQiuDrNOlgQeiHh0Pw=;
 b=UNn7gCzJGmlcYp0MVVPA7v/qIa6whSkV/yr+8lzwi+Ri/dr8bXlIMPQexohVUjMJOz
 WOt4BrOPkBz+GCGBQ7BW2s16LKax287wmA/9O9K0e3KMr1NKs5xPsXGO7ASZoITEXz9R
 5p/wne/4s/lSoJ/I6va0HM374ULj5OlQw9fAPLE7cjY/ShwhG4cpMFfBuB3w86nRfYn8
 FoG3t/dbil2YntYzXkM4mOmT/3dqA0WullfjQUnaTASwiXoR9PaaqsiT83VUDA+d0zGr
 45+uor57MDQXsjpFnFg5JdaSyixM8FD0Y4MCy7raFuH3+ym017p1RvJQ6kKqBkMnrFwf
 mf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767777253; x=1768382053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4cPbeA8HxC86D3WUvlh49CgtMRQiuDrNOlgQeiHh0Pw=;
 b=mulFHuR2rJ792OFlUuzDXegyry62ahQxyuTDOJNswT23p6LXI3fsvNyC3IWIujLONw
 RUzihXK4Fp5FJuGV4i2y8PLkUki65H/rqTX3luYztMV79Ob523hNq6W3iEHjabzD1dqr
 dnV0GuKR9JNO8ffdJhjY0gpZjldUnIhpDNWRpDUEO8FhzzuRsG8EFlpzNH+bdr3IdURD
 VV0axcqYa7ZGHnvTp8xPBfl8IH5D+GrOfHxOGcaLPzlMU/sdbRtoVwESscMNKvgS2+ev
 RTiUK8esv3W+IoPGxib3vqqtiCTtj1AJJhbviedj1snSqptK12HIui7mLVat32djdZdR
 0r1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSmpIdCFw+1hGKLfQjaeY3Ct6520nCcgJI58ThZ76wtK/RJRvzsQhee2CwOSqjUaWhBinvcFk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6GCgpS5/s4iLiDzjdbXm2TWEpSRmsyZtjhg4HOPW5zwCIub5q
 ap5aDpe894C3YiPz9dfrYivYFkPeS5Hwx86jyKdRj/1epay8IrltIQUo1N6Wnw1QvXkNNQbIpEO
 HrXqB6clrpSDIkMzjQeJod5+xrfGp/C2SJm7UVSgArCXMkyFAcSfOME+s
X-Gm-Gg: AY/fxX6kqs3hKJ8dql3Na0sVYf0KJoiKVTqgJ1vKUq2O/y3w8MOWJaGWDjDTEj6Xk/O
 DabcybHb7ZYtfjniTEmWc0hl5Cd7GwtK/HAhQvrL6lj4kTnR2p0UJPlRtXEssoKK76CAe+E2TPN
 pnb/0OWSjQcM+Gj4TxTIby5wGx8DEwo0WT+nSezKL8Ml+4EvVwj/g3r0YyHrprZijMFVMIAt9C4
 iDeb515Tc6fXhv9W1RjF+HI6Xg8jcfvOCJ2xyBYJfGk7jrsSrajzyKRiTD0Z9gXlgNiLI0mqNAW
 I5RyU8D2fehYNonzt7zuppNgxSIYMcIoLfLx9wWXMjgL/wqDaOkSSxa4RcKBz/yzTswIZmqi5rP
 gZk04pKEoW3BVDLNy43+D6ql4VcD+sCY6h+xYjUhb15uKzuy9h2JYldIA14iqE9xJnnWRFD5XDD
 loXwe0iy587r85vGCki47wzDuG01Grt5yxQkeJfg==
X-Received: by 2002:a17:903:9cf:b0:295:5132:1a99 with SMTP id
 d9443c01a7336-2a3ee4aabdemr14550605ad.44.1767777252572; 
 Wed, 07 Jan 2026 01:14:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGNwYLaNzEVy4sMuzKb05bGsNHYi+OVLNOPnXzmFp1WWr20syahxMFJCbM1yslISndFCGQcA==
X-Received: by 2002:a17:903:9cf:b0:295:5132:1a99 with SMTP id
 d9443c01a7336-2a3ee4aabdemr14550365ad.44.1767777251956; 
 Wed, 07 Jan 2026 01:14:11 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a4f1sm43688165ad.8.2026.01.07.01.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 01:14:11 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, balaji.selvanathan@oss.qualcomm.com,
 me@samcday.com, sughosh.ganu@linaro.org, ilias.apalodimas@linaro.org,
 gchan9527@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1] arm: snapdragon: Add EFI reserved memory regions for
 QCS615/QCM6490
Date: Wed,  7 Jan 2026 14:44:06 +0530
Message-Id: <20260107091406.2428132-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA3NCBTYWx0ZWRfX5kmd+1iz2Zik
 tdnxUyF7NlSCKxb/2DVTWJdkhdV9OGq/AmDcbt6Wh3awmAv8oBSGXi5OFeQPKqkXoCgnttvnlur
 g7/aMp2TAsYm640EtuidqqcfvpFM/mEUGkQx8SqnCDMm9GzbHr4JN7ZVCnn2c1DCZoytQffCY7s
 trR1OjhC+pm3mjSsP2EtWUIXt94d61fkQV5SjzyFuuQzrMDAWF7Ag0MzDu2IoYyLxBczjantPIs
 b0YTYGMHvlytbFviYxN/am2krSsUN+f5BHGlBH+C//4DH7wAuNWBr0Dytma6BlTihu5hiw75ZgZ
 ABh1LgzEbocyadLx/Bh7nMULQLVagPkWyrhcsXgV17GbWJ4JgEf6nfuqgOM9rHxIsxiZbxM80ur
 uTfSlrXWKazLNziF4CugNyDhLIku5Ace7CRbvjo1oFEVt2GpGsmh9ZzKHhQWl1KthCgcJ9XhkGW
 TcK2X5tQoTqU0RZe5Fw==
X-Authority-Analysis: v=2.4 cv=VI7QXtPX c=1 sm=1 tr=0 ts=695e23e5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=6x-a-hmKG2out1TRoF8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: ogIbybU5XSSW_N1FnN2rMALaPmjD0pMJ
X-Proofpoint-ORIG-GUID: ogIbybU5XSSW_N1FnN2rMALaPmjD0pMJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070074
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

Implemented platform-specific reserved memory registration for EFI on
Qualcomm Snapdragon platforms. This adds SoC-specific memory regions
to the EFI memory map.

Added qcom_reserved_memory.c with predefined memory regions for QCS615
and QCM6490/SC7280 SoCs. The implementation detects the SoC type
from device tree and registers appropriate memory regions
via efi_add_memory_map().

Implemented efi_add_known_memory() in board.c to hook into the EFI
memory initialization.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Makefile             |   1 +
 arch/arm/mach-snapdragon/board.c              |  15 +++
 arch/arm/mach-snapdragon/qcom-priv.h          |  10 ++
 .../mach-snapdragon/qcom_reserved_memory.c    | 114 ++++++++++++++++++
 4 files changed, 140 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/qcom_reserved_memory.c

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 343e825c6fd..19820a075e8 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -4,4 +4,5 @@
 
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
+obj-$(CONFIG_EFI_LOADER) += qcom_reserved_memory.o
 obj-$(CONFIG_OF_LIVE) += of_fixup.o
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 5fb3240acc5..0259623d382 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -709,6 +709,21 @@ static void carve_out_reserved_memory(void)
 	}
 }
 
+#ifdef CONFIG_EFI_LOADER
+/**
+ * efi_add_known_memory() - Add platform-specific reserved memory to EFI map
+ *
+ * This function is called by the EFI memory initialization code to allow
+ * platforms to add their reserved memory regions to the EFI memory map.
+ * For Qualcomm platforms, this delegates to qcom_add_reserved_memory_to_efi()
+ * which handles SoC-specific reserved memory regions.
+ */
+void efi_add_known_memory(void)
+{
+	qcom_add_reserved_memory_to_efi();
+}
+#endif /* CONFIG_EFI_LOADER */
+
 /* This function open-codes setup_all_pgtables() so that we can
  * insert additional mappings *before* turning on the MMU.
  */
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index b8bf574e8bb..b488516cfdb 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -17,6 +17,16 @@ enum qcom_boot_source {
 
 extern enum qcom_boot_source qcom_boot_source;
 
+#if IS_ENABLED(CONFIG_EFI_LOADER)
+/**
+ * qcom_add_reserved_memory_to_efi() - Add Qualcomm SoC reserved memory to EFI
+ *
+ * This function detects the SoC type and adds the appropriate reserved
+ * memory regions to the EFI memory map. Called from efi_add_known_memory().
+ */
+void qcom_add_reserved_memory_to_efi(void);
+#endif /* CONFIG_EFI_LOADER */
+
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 void qcom_configure_capsule_updates(void);
 #else
diff --git a/arch/arm/mach-snapdragon/qcom_reserved_memory.c b/arch/arm/mach-snapdragon/qcom_reserved_memory.c
new file mode 100644
index 00000000000..e670f74bc1f
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom_reserved_memory.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <efi_loader.h>
+#include <fdt_support.h>
+#include <log.h>
+#include <linux/sizes.h>
+#include <asm/global_data.h>
+#include "qcom-priv.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/**
+ * struct reserved_mem_region - Reserved memory region descriptor
+ * @start: Physical start address of the region
+ * @size: Size of the region in bytes
+ * @name: Human-readable name for logging
+ */
+struct reserved_mem_region {
+	u64 start;
+	u64 size;
+	const char *name;
+};
+
+/* QCS615 reserved memory regions */
+static const struct reserved_mem_region qcs615_reserved[] = {
+	{ 0x80000000, 0x600000,    "hyp" },
+	{ 0x85D00000, 0x200000,    "boot" },
+	{ 0x85F00000, 0x20000,     "aop" },
+	{ 0x85F40000, 0x30000,     "xbl_dt" },
+	{ 0x86200000, 0x100000,    "tz_stat" },
+	{ 0x86300000, 0x1200000,   "tags" },
+	{ 0x87500000, 0x500000,    "tz" },
+	{ 0x87A00000, 0x1C00000,   "tzapps" },
+	{ 0x8AB00000, 0xCC17000,   "pil" },
+	{ 0xA0000000, 0x1600000,   "secure_dsp" },
+};
+
+/* SC7280/QCM6490 reserved memory regions */
+static const struct reserved_mem_region sc7280_reserved[] = {
+	{ 0x80600000, 0x100000,    "axon_dma" },
+	{ 0x80894000, 0x40000,     "xbl_dt" },
+	{ 0x84300000, 0x16B00000,  "pil_reserved" },
+	{ 0xE1000000, 0x2400000,   "display" },
+};
+
+/**
+ * add_soc_reserved_memory() - Add SoC-specific reserved memory to EFI map
+ * @regions: Array of reserved memory regions
+ * @count: Number of regions in the array
+ * @soc_name: SoC name for logging
+ *
+ * This function iterates through the provided reserved memory regions and
+ * adds them to the EFI memory map with type EFI_RESERVED_MEMORY_TYPE.
+ */
+static void add_soc_reserved_memory(const struct reserved_mem_region *regions,
+				    int count, const char *soc_name)
+{
+	int i;
+
+	log_debug("Adding %s reserved memory to EFI map (%d regions)\n",
+		  soc_name, count);
+
+	for (i = 0; i < count; i++) {
+		efi_status_t ret;
+
+		ret = efi_add_memory_map(regions[i].start,
+					 regions[i].size,
+					 EFI_RESERVED_MEMORY_TYPE);
+
+		if (ret != EFI_SUCCESS) {
+			log_err("%s: Failed to reserve %s (0x%llx-0x%llx): %lu\n",
+				soc_name, regions[i].name,
+				regions[i].start,
+				regions[i].start + regions[i].size,
+				ret & ~EFI_ERROR_MASK);
+		} else {
+			log_debug("%s: Reserved %s: 0x%llx-0x%llx (%llu KB)\n",
+				  soc_name, regions[i].name,
+				  regions[i].start,
+				  regions[i].start + regions[i].size,
+				  regions[i].size / 1024);
+		}
+	}
+}
+
+/**
+ * qcom_add_reserved_memory_to_efi() - Add Qualcomm SoC reserved memory to EFI
+ *
+ * This function detects the SoC type from the device tree and adds the
+ * appropriate reserved memory regions to the EFI memory map.
+ *
+ * Supported SoCs:
+ * - QCS615 (Talos)
+ * - QCM6490/SC7280 (Kodiak)
+ */
+void qcom_add_reserved_memory_to_efi(void)
+{
+	/* Detect SoC and add appropriate reserved memory */
+	if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs615") == 0) {
+		add_soc_reserved_memory(qcs615_reserved,
+					ARRAY_SIZE(qcs615_reserved),
+					"QCS615");
+	} else if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcm6490") == 0 ||
+		   fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,sc7280") == 0) {
+		add_soc_reserved_memory(sc7280_reserved,
+					ARRAY_SIZE(sc7280_reserved),
+					"QCM6490/SC7280");
+	} else {
+		log_debug("No SoC-specific reserved memory to add\n");
+	}
+}
-- 
2.34.1

