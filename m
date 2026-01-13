Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BE4D2D0E1
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 11:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 214E7836A3;
	Tue, 13 Jan 2026 12:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J1OuONag";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dXaFinU5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 118FA83642; Tue, 13 Jan 2026 12:54:42 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7B5B83642
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 12:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60D8Yx653727167
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oLESMg8zW4u6fd1hIvpO5DSOJ6CuIyXdE3XaUJPHF2U=; b=J1OuONagVXAL7EWT
 N5X0sw0Ef55ercedg0qE6EuNWHpeBM9HYoZ3D2GgaqB5pA/5MbyEc5OvAOn076Wd
 NvFiCEsljgPtkIOvHB+iCAYAtGS+Rc3wuIHK9U3cMnzN5OnPiNFAwsw24fUBKrdS
 er5rYeamA+dUpStFMrGtmDw+6UHaUBaLcNCDHeqKFMNNkGt1lOfj/HS5ENnOGZNZ
 /MBBdE1qYuteYMGfbYMoBwvgFj0/sPOM+w2X7H5euTgEeIyivEQC2P6ZV2YPMVWx
 9vFbDSog1FG75cyFOm74xu4Sb9LPNqjL004++wQkbBunusEXCJueqKr1kGIKR956
 c6RaGw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnjnu0pc6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:54:36 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c5269fcecdeso3003577a12.0
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 03:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768305276; x=1768910076; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oLESMg8zW4u6fd1hIvpO5DSOJ6CuIyXdE3XaUJPHF2U=;
 b=dXaFinU5w1SZ1UFh1z/DmBowhBGp8EuiWFHmDBLyLQYJSTF+K+7H8mShtws29q5R6b
 fx70kP4zKFsB4ccE2oWRQT3cmpLDyPTX+KjFBSIMk0n93h0rvLU2H0rR4qOY91TP2hfV
 Hg/9FvrXbYzUw7jLSo0tVIpO1fTarEV3L0ahiR4FdmYt+pmXAVoQWlzJ6+LiKKyS1QJ3
 Uv1zJ2kxM3Xln24EXgOtSDTW9Aqy6DSG84Nf/XVxOHZmOu4r73aWyWWbOO3M8KGc1+3W
 gk0W70BZP/2wlm/U8/oyx6vAMPuz+1qNIVkPA38B28wpX+2yRL+gnKFJbkmNL02uk/OP
 Epmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768305276; x=1768910076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oLESMg8zW4u6fd1hIvpO5DSOJ6CuIyXdE3XaUJPHF2U=;
 b=q1QAYoR1E+71QW964QCdHb9STvRgv8ErYRZyfpGIcO+B8zgrMZWeMkiPpRgnzdtsp3
 uMcBnYhpGIbGoU9DyY0u9FHmqeO5y9UG7QJF7OclCBcqIp9jpO0t3Z8M39qzJUNENR50
 VlWLD5kJkWuEYK0r4Hr7Qicsi5Ai/+wpYR/CnLxSgMhLP/2xnurgveDvNTt0OhVtXZx2
 fs3DmTv8ouN13Qs/vws6k+mjXFZY1uUBxXVxQWw8SeZke8sWuvoABpIiXG/oOokvoNOy
 3zDLN8Js15rnMmdcwz7RLcddW6TkWu2ftBQev7eKH/fRUIlXSu70pM5T45avV9jSJKNI
 O8zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKHZOcd3rLzygEmnFeECjCHQ+T2JMbL9QfevZgoF4IqW/E5FslAA+jjIEz9mPeBtrVOetRams=@lists.denx.de
X-Gm-Message-State: AOJu0YyK9oOpHBRc6F0KkOKoiuFSEBtoFvDKRG46PQIZiSHnDB3VnjhR
 rDjc4Ptlc870pozyua8GRHFMWMqJownmVIaFe9GLTLEefNPYur5uELft5uw9igzTucU3Nc4/V3t
 XkU/XFTms0Vl/icZlz3LLqLqLXptgHfA26VVHw+1xlgkN80X4R3TpTDkE
X-Gm-Gg: AY/fxX5pKItlUNKBngT4QCPE7Q494k6itOXyrezcyLnAJPdPzwDAaIyaveEoJXEODXc
 xLESm158WU3EeKlk5fiLbf7LkihmCt/PlGXGxFUX5uKREesryCF7PQL9RYLga2C5Y1YlpoBFUFy
 4Wf+GrRScgPdAqgHGKO77FI6+YIgTCEPCKcvwgAv5z5xYgDjgdzk6ZPxA//TFSKOxD4LKG8bjGT
 Y2yYNoUUlWTDkVZk/OT0gV0ndYZV8Ow2co3LBT93K7FbdcSJ3vDAS0VPPDu0L4pfTMCCbH7hehA
 EwtyWBrEvCuNhvSdyiH364mv+YwAphclzSltppwf5rEbdPwylSKrBF13cTb9nwGc9UZ/nQV86XE
 WdTjXNV0Gfi+2s9727Q/qnYTd0WpO1I4gIW93Vwij8nvjeDwTZ/6fLos8nSWB3s4KVVUQlbvkhh
 U4aDUkJi90ySzLc1bm3++hquXybNHl
X-Received: by 2002:a05:6a20:6a1e:b0:35e:1a80:448 with SMTP id
 adf61e73a8af0-3898f987568mr19023766637.49.1768305275567; 
 Tue, 13 Jan 2026 03:54:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm/a7gHn9OZm2Hqb3LHTWBSp/XSoS82kN41Z45ZqQq/5M3ynkqpEdSzS9inPel+uVEDq3/Gg==
X-Received: by 2002:a05:6a20:6a1e:b0:35e:1a80:448 with SMTP id
 adf61e73a8af0-3898f987568mr19023728637.49.1768305274632; 
 Tue, 13 Jan 2026 03:54:34 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbfc2f481sm19734073a12.10.2026.01.13.03.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 03:54:34 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com, me@samcday.com,
 sughosh.ganu@linaro.org, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 2/3] mach-snapdragon: Add OF_LIVE device tree fixup handlers
Date: Tue, 13 Jan 2026 17:24:03 +0530
Message-Id: <20260113115404.1448759-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113115404.1448759-1-aswin.murugan@oss.qualcomm.com>
References: <20260113115404.1448759-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zyVLkQZMUZz2bguUzcPpo9Q9jmzoTvYi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEwMCBTYWx0ZWRfX4DOV3O81jfIY
 m7IYGK/6DV/vJpgcc1+WuuAhjzwHg+k4muOlYTCrWAHbbITKU22B0dNMNnU03HhhhQVoVyP/nfq
 6kkkdrxOjkFaRC/PZmmJ1IW0pjsPMXKhPT5FI6UCkJIeDsL07yd5wDQ2AdepLfUl8Nl/xTnpvwM
 1bJOdbhxfwJcenITTWpxPXYEyz0h24UCtqC4ljD3I4tLIcQICBryzigvpel1Y8y0nkN7cprlCUQ
 iqQFZBRpLMZZIbdird10AU5Y278q0QNomcPGd5v/gib+z8fFRg6G5SmKz+PbOcuhRGkWmXp7y6+
 lBU4w9/7krBsogSIEHdKBkwie72VWH+nff8laKUW0VvtQ+4npO/ZSdXU3k1PEEPBD43tVTDKzQS
 zjoDHNVanZOyWFaDa+OEV3jrx3GCDgYgyZ6lPXtouRYA62lL/Q96UF8RcpZJvcnMY4PNDlIgx6r
 B5i0yU1y0ZZV9iIvRxA==
X-Authority-Analysis: v=2.4 cv=RMu+3oi+ c=1 sm=1 tr=0 ts=6966327c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=0n7jwilrXOtiGUHeW80A:9
 a=MhVkr-hnZjhVc9az:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: zyVLkQZMUZz2bguUzcPpo9Q9jmzoTvYi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130100
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

Add device tree fixup handler infrastructure to support runtime
modifications of board information, DDR configuration, and hardware
subset parts through the OF_LIVE interface.

This patch introduces three fixup handlers that modify the device tree
at runtime to provide platform-specific information from SMEM:

1. Board info fixup (qcom_fixup_boardinfo.c)
   - Adds board-specific information like serial number to the
     device tree

2. DDR info fixup (qcom_fixup_ddrinfo.c)
   - Adds DDR configuration information like DDR size & regions

3. Subset parts fixup (qcom_fixup_subsetparts.c)
   - Identifies & enables OS to adapt to available hardware subparts
     (GPU, video, camera, display, audio, modem, WLAN, compute,
     sensors, NPU, disabled CPU cores, etc.)

Supporting headers:
- qcom_fixup_handlers.h: Function prototypes and type definitions
- chipinfo_def.h: Chip identification and part definitions
- rampart.h: Platform-specific definitions

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Makefile             |   3 +
 arch/arm/mach-snapdragon/chipinfo_def.h       |  90 ++++++
 .../mach-snapdragon/qcom_fixup_boardinfo.c    | 217 ++++++++++++++
 arch/arm/mach-snapdragon/qcom_fixup_ddrinfo.c | 214 +++++++++++++
 .../arm/mach-snapdragon/qcom_fixup_handlers.h |  70 +++++
 .../mach-snapdragon/qcom_fixup_subsetparts.c  | 281 ++++++++++++++++++
 arch/arm/mach-snapdragon/rampart.h            | 236 +++++++++++++++
 7 files changed, 1111 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/chipinfo_def.h
 create mode 100644 arch/arm/mach-snapdragon/qcom_fixup_boardinfo.c
 create mode 100644 arch/arm/mach-snapdragon/qcom_fixup_ddrinfo.c
 create mode 100644 arch/arm/mach-snapdragon/qcom_fixup_handlers.h
 create mode 100644 arch/arm/mach-snapdragon/qcom_fixup_subsetparts.c
 create mode 100644 arch/arm/mach-snapdragon/rampart.h

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 343e825c6fd..62e390f2ca4 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -4,4 +4,7 @@
 
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
+obj-$(CONFIG_OF_LIVE) += qcom_fixup_boardinfo.o
+obj-$(CONFIG_OF_LIVE) += qcom_fixup_ddrinfo.o
+obj-$(CONFIG_OF_LIVE) += qcom_fixup_subsetparts.o
 obj-$(CONFIG_OF_LIVE) += of_fixup.o
diff --git a/arch/arm/mach-snapdragon/chipinfo_def.h b/arch/arm/mach-snapdragon/chipinfo_def.h
new file mode 100644
index 00000000000..fc497da825c
--- /dev/null
+++ b/arch/arm/mach-snapdragon/chipinfo_def.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Type and enum definitions for the Chip Info driver
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+enum chip_info_result {
+	CHIPINFO_SUCCESS = 0,
+	CHIPINFO_ERROR = -1,
+	CHIPINFO_ERROR_INVALID_PARAMETER = -2,
+	CHIPINFO_ERROR_INSUFFICIENT_MEMORY = -3,
+	CHIPINFO_ERROR_NOT_FOUND = -4,
+	CHIPINFO_ERROR_INTERNAL = -5,
+	CHIPINFO_ERROR_NOT_ALLOWED = -6,
+	CHIPINFO_ERROR_NOT_SUPPORTED = -7,
+	CHIPINFO_ERROR_NOT_INITIALIZED = -8,
+	CHIPINFO_ERROR_OUT_OF_RANGE_PARAMETER = -9,
+	CHIPINFO_ERROR_INVALID_ADDRESS = -10,
+	CHIPINFO_ERROR_INSUFFICIENT_BUFFER_LENGTH = -11,
+};
+
+/**
+ * Supported parts by the chipinfo_get_disabled_features API.
+ * New parts should be appended to this enum (i.e. not inserted)
+ * to preserve backwards compatibility.
+ *
+ * For targets that have multiple instances of a specific part,
+ * a new part with a _N suffix should be added. On these targets,
+ * part enums without the _N suffix are for the 0th instance,
+ * e.g. CHIPINFO_PART_DISPLAY is for MDSS_0 on Makena.
+ */
+enum chip_info_Part_type {
+	CHIPINFO_PART_UNKNOWN = 0,
+	CHIPINFO_PART_GPU = 1,
+	CHIPINFO_PART_VIDEO = 2,
+	CHIPINFO_PART_CAMERA = 3,
+	CHIPINFO_PART_DISPLAY = 4,
+	CHIPINFO_PART_AUDIO = 5,
+	CHIPINFO_PART_MODEM = 6,
+	CHIPINFO_PART_WLAN = 7,
+	CHIPINFO_PART_COMP = 8, // For both CDSP and NSP
+	CHIPINFO_PART_SENSORS = 9,
+	CHIPINFO_PART_NPU = 10,
+	CHIPINFO_PART_SPSS = 11,
+	CHIPINFO_PART_NAV = 12,
+	CHIPINFO_PART_COMPUTE_1 = 13,
+	CHIPINFO_PART_DISPLAY_1 = 14,
+	CHIPINFO_PART_NSP = 15,
+	CHIPINFO_PART_EVA = 16,
+	CHIPINFO_PART_PCIE = 17,
+	CHIPINFO_PART_CPU = 18,
+	CHIPINFO_PART_DDR = 19,
+
+	CHIPINFO_NUM_PARTS,
+	CHIPINFO_PART_32BITS = 0x7FFFFFFF
+};
+
+/**
+ * SKU_IDs logical mapping.
+ * See ChipInfo_GetSKU for more details.
+ */
+enum chip_info_skuid_type {
+	CHIPINFO_SKU_UNKNOWN = 0,
+
+	CHIPINFO_SKU_AA = 0x01,
+	CHIPINFO_SKU_AB = 0x02,
+	CHIPINFO_SKU_AC = 0x03,
+	CHIPINFO_SKU_AD = 0x04,
+	CHIPINFO_SKU_AE = 0x05,
+	CHIPINFO_SKU_AF = 0x06,
+	// Reserved for future use
+
+	CHIPINFO_SKU_Y0 = 0xf1,
+	CHIPINFO_SKU_Y1 = 0xf2,
+	CHIPINFO_SKU_Y2 = 0xf3,
+	CHIPINFO_SKU_Y3 = 0xf4,
+	CHIPINFO_SKU_Y4 = 0xf5,
+	CHIPINFO_SKU_Y5 = 0xf6,
+	CHIPINFO_SKU_Y6 = 0xf7,
+	CHIPINFO_SKU_Y7 = 0xf8,
+	// Reserved for future use
+
+};
+
diff --git a/arch/arm/mach-snapdragon/qcom_fixup_boardinfo.c b/arch/arm/mach-snapdragon/qcom_fixup_boardinfo.c
new file mode 100644
index 00000000000..67a0aeccbb0
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom_fixup_boardinfo.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Board Info FDT Fixup
+ *
+ * Copyright (c) 2015-2018, 2020-2021, The Linux Foundation. All rights reserved.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * This file contains code to fix up the device tree blob (DTB) for the board.
+ * It is responsible for adding or modifying nodes, properties, and values as
+ * necessary to ensure the DTB is in a valid state for the board.
+ *
+ * The fixups are applied in the following order:
+ * 1. Add any necessary nodes or properties
+ * 2. Modify existing nodes or properties
+ * 3. Remove any unnecessary nodes or properties
+ *
+ * Each fixup is documented with a comment explaining its purpose and any
+ * relevant details.
+ */
+
+#include <dm.h>
+#include <fdt_support.h>
+#include <smem.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/libfdt.h>
+#include <soc/qcom/socinfo.h>
+#include "chipinfo_def.h"
+#include "qcom_fixup_handlers.h"
+#include "qcom-priv.h"
+
+static const char *const feature_code_names_external[] = {
+	[CHIPINFO_SKU_UNKNOWN] = "Unknown",
+	[CHIPINFO_SKU_AA] = "AA",
+	[CHIPINFO_SKU_AB] = "AB",
+	[CHIPINFO_SKU_AC] = "AC",
+	[CHIPINFO_SKU_AD] = "AD",
+	[CHIPINFO_SKU_AE] = "AE",
+	[CHIPINFO_SKU_AF] = "AF",
+};
+
+static int add_serialnum_platinfo_prop(void *fdt_ptr, u32 node_offset);
+static int add_sku_prop(void *fdt_ptr, u32 node_offset);
+static int add_platforminfo_node(void *fdt_ptr);
+static void add_platforminfo_properties(void *fdt_ptr);
+
+/**
+ * board_serial_num() - Retrieves the board serial number from the SMEM.
+ * @serial_num_ptr: Pointer to a u32 variable to store the board
+ * serial number.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int board_serial_num(u32 *serial_num_ptr)
+{
+	struct socinfo *soc_info_ptr;
+
+	soc_info_ptr = qcom_get_socinfo();
+	if (!soc_info_ptr)
+		return log_msg_ret("Error: Failed to get socinfo\n", -1);
+
+	*serial_num_ptr = soc_info_ptr->serial_num;
+
+	return 0;
+}
+
+/**
+ * add_serialnum_platinfo_prop() - Adds the serial number property to the platform information node.
+ * @fdt_ptr: Pointer to the device tree.
+ * @node_offset: Offset of the platform information node in the device tree.
+ *
+ * This function adds the serial number property to the platform information
+ * node in the device tree. The serial number is retrieved from the SMEM using
+ * the board_serial_num function.
+ *
+ * Return: 0 on success, negative on failure.
+ */
+static int add_serialnum_platinfo_prop(void *fdt_ptr, u32 node_offset)
+{
+	u32 serial_num;
+	int ret;
+
+	ret = board_serial_num(&serial_num);
+	if (ret)
+		return log_msg_ret("ERROR: Could not find serial number to populate\n",
+				   ret);
+	log_debug("Serial Number: 0x%x\n", serial_num);
+
+	ret = fixup_dt_node(fdt_ptr, node_offset, "serial-number",
+			    (void *)&serial_num, SET_PROP_U32);
+	if (ret)
+		log_err("ERROR: Cannot update Platform info node with SerialNumber - %d\n",
+			ret);
+
+	return ret;
+}
+
+static int add_sku_prop(void *fdt_ptr, u32 node_offset)
+{
+	u32 pcode;
+	char feature_code[24];
+	int ret;
+	static const char feature_code_prop[] = "feature-code";
+	struct socinfo *soc_info_ptr;
+
+	soc_info_ptr = qcom_get_socinfo();
+	if (!soc_info_ptr)
+		return log_msg_ret("Error: Failed to get socinfo\n", -1);
+
+	strlcpy(feature_code,
+		feature_code_names_external[soc_info_ptr->feature_code],
+		sizeof(feature_code));
+	if (soc_info_ptr->pcode == 0)
+		pcode = 0xFFFFFFFF;
+	else
+		pcode = soc_info_ptr->pcode;
+
+	ret = fixup_dt_node(fdt_ptr, node_offset, "pcode", (void *)&pcode,
+			    SET_PROP_U32);
+	if (ret)
+		return log_msg_ret("ERROR: Cannot update Platform info node with Pcode\n",
+				   ret);
+	ret = fixup_dt_node(fdt_ptr, node_offset, feature_code_prop,
+			    (void *)feature_code, SET_PROP_STRING);
+	if (ret)
+		log_err("ERROR: Cannot update Platform info node with feature code - %d\n",
+			ret);
+
+	return ret;
+}
+
+/**
+ * add_platforminfo_node() - Adds the platform info node to the device tree.
+ * @fdt_ptr: The device tree to add the platform info node to.
+ *
+ * This function adds the platform info node to the device tree, including the
+ * serial number, SKU information, and other relevant properties.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int add_platforminfo_node(void *fdt_ptr)
+{
+	int node_offset;
+
+	node_offset = fdt_path_offset(fdt_ptr, "/firmware/qcom,platform-parts-info");
+	if (node_offset >= 0)
+		return node_offset;
+
+	node_offset = fdt_path_offset(fdt_ptr, "/firmware");
+	if (node_offset < 0) {
+		node_offset = fixup_dt_node(fdt_ptr, 0, "firmware", NULL,
+					    ADD_SUBNODE);
+		if (node_offset < 0)
+			return log_msg_ret("Error creating firmware node\n",
+					   node_offset);
+	}
+
+	node_offset = fixup_dt_node(fdt_ptr, node_offset, "qcom,platform-parts-info",
+				    NULL, ADD_SUBNODE);
+	if (node_offset < 0) {
+		log_err("Error adding qcom,platform-parts-info, Error: %d\n",
+			node_offset);
+		node_offset = fdt_path_offset(fdt_ptr,
+					      "/firmware/qcom,platform-parts-info");
+		if (node_offset < 0)
+			log_err("Retry getting qcom,platform-parts-info offset, Error: %d\n",
+				node_offset);
+	}
+
+	return node_offset;
+}
+
+/**
+ * add_platforminfo_properties() - Adds platform information properties to the device tree.
+ * @fdt_ptr: The device tree to update.
+ *
+ * This function populates the device tree with platform information properties,
+ * including the serial number, SKU information, and platform parts information.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static void add_platforminfo_properties(void *fdt_ptr)
+{
+	int ret = 0;
+	int node_offset;
+
+	node_offset = add_platforminfo_node(fdt_ptr);
+	if (node_offset < 0) {
+		log_err("Failed to add qcom,platform-parts-info\n");
+		return;
+	}
+
+	ret = add_serialnum_platinfo_prop(fdt_ptr, node_offset);
+	if (ret)
+		log_err("Failed to add Serial Number property\n");
+
+	ret = add_sku_prop(fdt_ptr, node_offset);
+	if (ret)
+		log_err("Failed to add SKU properties\n");
+}
+
+/**
+ * boardinfo_fixup_handler() - Board info fixup handler.
+ * @fdt_ptr: Pointer to the device tree.
+ *
+ * This function is called to fix up the device tree blob (DTB) for the board.
+ * It adds or modifies nodes, properties, and values as necessary to ensure the
+ * DTB is in a valid state for the board.
+ */
+void boardinfo_fixup_handler(struct fdt_header *fdt_ptr)
+{
+	add_platforminfo_properties(fdt_ptr);
+}
diff --git a/arch/arm/mach-snapdragon/qcom_fixup_ddrinfo.c b/arch/arm/mach-snapdragon/qcom_fixup_ddrinfo.c
new file mode 100644
index 00000000000..99d2d12ac33
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom_fixup_ddrinfo.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DDRInfo Fixup
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <dm.h>
+#include <fdt_support.h>
+#include <smem.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/libfdt.h>
+#include "qcom_fixup_handlers.h"
+#include "rampart.h"
+
+/* With the new SMEM architecture, SMEM IDs need to be defined in individual
+ * driver files
+ */
+#define SMEM_ID_DDRINFO 0x25B // 603
+#define MAX_IDX_CH 8
+
+struct ddr_freq_table {
+	u32 freq_khz;
+	u8 enable;
+};
+
+struct ddr_freq_plan_entry {
+	struct ddr_freq_table ddr_freq[14];
+	u8 num_ddr_freqs;
+	u32 *clk_period_address;
+	u32 max_nom_ddr_freq;
+};
+
+struct ddr_part_details {
+	u8 revision_id1[2];
+	u8 revision_id2[2];
+	u8 width[2];
+	u8 density[2];
+};
+
+struct ddr_details_entry {
+	u8 manufacturer_id;
+	u8 device_type;
+	struct ddr_part_details ddr_params[MAX_IDX_CH];
+	struct ddr_freq_plan_entry ddr_freq_tbl;
+	u8 num_channels;
+	u8 num_ranks[2]; /* number of ranks per channel */
+	u8 hbb[2][2];
+	/* Highest Bank Bit per rank per channel */ /*Reserved for Future use*/
+};
+
+static int get_ddr_details(struct ddr_details_entry *ddr_detail);
+
+/**
+ * get_ddr_details() - Retrieves the DDR details entry from the SMEM.
+ * @ddr_detail: The DDR details entry to retrieve.
+ *
+ * This function retrieves the DDR details entry from the SMEM and prints it
+ * out.
+ *
+ * Return: 0 on success, -1 on failure
+ */
+static int get_ddr_details(struct ddr_details_entry *ddr_detail)
+{
+	void *ddr_table_ptr;
+	struct udevice *dev;
+	size_t size;
+
+	if (uclass_get_device(UCLASS_SMEM, 0, &dev) != 0)
+		return log_msg_ret("Error: uclass_get_device\n", -1);
+	ddr_table_ptr = smem_get(dev, 0, SMEM_ID_DDRINFO, &size);
+
+	if (!ddr_table_ptr)
+		return log_msg_ret("Error: invalid DDR Entry\n", -1);
+	memcpy((void *)ddr_detail, ddr_table_ptr, sizeof(struct ddr_details_entry));
+
+	return 0;
+}
+
+/**
+ * set_mem_reg_node() - Sets the ram partition info to memory node
+ * @fdt_ptr: Pointer to the device tree
+ * @path_offset: Offset to the memory node
+ * @start_addr: Start address of the mem partition
+ * @mem_size: Size of the mem partition
+ *
+ * This function is responsible for setting the reg property of memory node
+ * in the device tree
+ *
+ * Return: 0 on success, -1 on failure
+ */
+static int set_mem_reg_node(struct fdt_header *fdt_ptr, u32 path_offset,
+			    u64 start_addr, u64 mem_size)
+{
+	int ret;
+
+	log_debug("Mem info start addr: %llx ,size %llx\n", start_addr, mem_size);
+	ret = fixup_dt_node(fdt_ptr, path_offset, "reg",
+			    (void *)(&start_addr), APPEND_PROP_U64);
+	if (ret)
+		return log_msg_ret("Failed to append start_addr details in Reg prop\n", -1);
+
+	ret = fixup_dt_node(fdt_ptr, path_offset, "reg",
+			    (void *)(&mem_size), APPEND_PROP_U64);
+	if (ret)
+		return log_msg_ret("Failed to append mem_size details in Reg prop\n", -1);
+
+	return 0;
+}
+
+/**
+ * set_ram_part_info() - Gets the ram partition info from smem and sets
+ * it to memory node
+ * @fdt_ptr: Pointer to the device tree
+ * @path_offset: Offset to the memory node
+ *
+ * This function is responsible for obtaining ram partition information info
+ * from smem and sets it to the device tree
+ * tree.
+ *
+ * Return: 0 on success, -1 on failure
+ */
+static int set_ram_part_info(struct fdt_header *fdt_ptr, u32 path_offset)
+{
+	int ret = 0, res, part;
+	size_t size;
+	struct udevice *dev;
+	struct usable_ram_partition_table *rpt;
+	struct ram_partition_entry *rpe;
+
+	uclass_get_device(UCLASS_SMEM, 0, &dev);
+	rpt = smem_get(dev, 0, SMEM_USABLE_RAM_PARTITION_TABLE, &size);
+	if (!rpt)
+		return -1;
+	rpe = &rpt->ram_part_entry[0];
+
+	for (part = 0; part < rpt->num_partitions; part++, rpe++)
+		if (rpe->partition_category == RAM_PARTITION_SDRAM &&
+		    rpe->partition_type == RAM_PARTITION_SYS_MEMORY) {
+			res = set_mem_reg_node(fdt_ptr, path_offset,
+					       rpe->start_address,
+					       rpe->available_length);
+			if (res) {
+				log_err("Failed to set Mem info start addr: %llx ,size %llx\n",
+					rpe->start_address, rpe->available_length);
+				ret = -1;
+			}
+		}
+
+	return ret;
+}
+
+/**
+ * ddrinfo_fixup_handler() - DDRInfo Fixup handler function
+ * @fdt_ptr: Pointer to the device tree
+ *
+ * This function is responsible for updating the DDR information in the device
+ * tree.
+ */
+void ddrinfo_fixup_handler(struct fdt_header *fdt_ptr)
+{
+	u32 path_offset, chan, ret;
+	u64 prop_value;
+	char fdt_rank_prop[] = "ddr_device_rank_ch  ";
+	struct ddr_details_entry ddr_details;
+
+	ret = get_ddr_details(&ddr_details);
+	if (ret) {
+		log_err("Error getting DDR details\n");
+		return;
+	}
+
+	path_offset = fdt_path_offset(fdt_ptr, "/memory");
+	if (path_offset < 0) {
+		log_err("Error getting memory offset: %d\n", path_offset);
+		return;
+	}
+	prop_value = (u64)ddr_details.device_type;
+	ret = fixup_dt_node(fdt_ptr, path_offset, "ddr_device_type",
+			    (void *)(&prop_value), APPEND_PROP_U64);
+	if (ret)
+		log_err("Failed to append DDR device type data : %d\n", ret);
+
+	prop_value = (u64)ddr_details.num_channels;
+	ret = fixup_dt_node(fdt_ptr, path_offset, "ddr_device_channel",
+			    (void *)(&prop_value), APPEND_PROP_U64);
+	if (ret)
+		log_err("Failed to append DDR Channels data : %d\n", ret);
+
+	for (chan = 0; chan < ddr_details.num_channels; chan++) {
+		snprintf(fdt_rank_prop, sizeof(fdt_rank_prop),
+			 "ddr_device_rank_ch%d", chan);
+		prop_value = (u64)ddr_details.num_ranks[chan];
+		ret = fixup_dt_node(fdt_ptr, path_offset,
+				    (const char *)fdt_rank_prop,
+				    (void *)(&prop_value),
+				    APPEND_PROP_U64);
+		if (ret)
+			log_err("Failed to append DDR ranks data : %d\n", ret);
+	}
+	ret = fdt_delprop(fdt_ptr, path_offset, "reg");
+	if (!ret) {
+		ret = set_ram_part_info(fdt_ptr, path_offset);
+		if (ret)
+			log_err("set_ram_part_info failed");
+	}
+}
+
+/* End of File */
diff --git a/arch/arm/mach-snapdragon/qcom_fixup_handlers.h b/arch/arm/mach-snapdragon/qcom_fixup_handlers.h
new file mode 100644
index 00000000000..06ad2e86a10
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom_fixup_handlers.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SUBSET Parts Fixup: A tool for fixing up subset parts in a system
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/libfdt.h>
+
+enum fdt_fixup_type {
+	APPEND_PROP_U32 = 0,
+	APPEND_PROP_U64 = 1,
+	SET_PROP_U32 = 2,
+	SET_PROP_U64 = 3,
+	SET_PROP_STRING = 4,
+	ADD_SUBNODE = 5,
+};
+
+/**
+ * boardinfo_fixup_handler() - Board info fixup handler.
+ * @fdt_ptr: Pointer to the device tree.
+ *
+ * This function is called to fix up the device tree blob (DTB) for the board.
+ * It adds or modifies nodes, properties, and values as necessary to ensure
+ * the DTB is in a valid state for the board.
+ *
+ * Return: None
+ */
+void boardinfo_fixup_handler(struct fdt_header *fdt_ptr);
+
+/**
+ * subsetparts_fixup_handler() - This function is the entry point for the
+ * Subset Parts fixup handler.
+ * @fdt_ptr: The firmware DT node to update.
+ *
+ * It reads the SOC info from the SMEM, extracts the disabled subset parts, and
+ * exports them to the firmware DT node.
+ *
+ * Return: None
+ */
+void subsetparts_fixup_handler(struct fdt_header *fdt_ptr);
+
+/**
+ * ddrinfo_fixup_handler() - DDRInfo Fixup handler function
+ * @fdt_ptr: Pointer to the device tree
+ *
+ * This function is responsible for updating the DDR information in
+ * the device tree.
+ *
+ * Return: None
+ */
+void ddrinfo_fixup_handler(struct fdt_header *fdt_ptr);
+
+/**
+ * fixup_dt_node() - Exports a property to the firmware DT node.
+ * @fdt_ptr: The firmware DT node to update.
+ * @node_offset: The offset in the DT node where the property should be set.
+ * @property_name: The name of the property to set.
+ * @property_value: The value of the property to set.
+ * @type: Fixup type
+ * This function sets a property in the firmware DT node with the given name and
+ * value.
+ *
+ * Return: 0 on success, negative on failure.
+ */
+int fixup_dt_node(void *fdt_ptr, int node_offset,
+		  const char *property_name,
+		  void *property_value,
+		  enum fdt_fixup_type type);
diff --git a/arch/arm/mach-snapdragon/qcom_fixup_subsetparts.c b/arch/arm/mach-snapdragon/qcom_fixup_subsetparts.c
new file mode 100644
index 00000000000..6f1af977572
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom_fixup_subsetparts.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* SUBSET Parts Fixup: A tool for fixing up subset parts in a system
+ *
+ * Copyright (c) 2017,2019, 2020 The Linux Foundation. All rights reserved.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <dm.h>
+#include <fdt_support.h>
+#include <smem.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <linux/libfdt.h>
+#include <soc/qcom/socinfo.h>
+#include "chipinfo_def.h"
+#include "qcom_fixup_handlers.h"
+#include "qcom-priv.h"
+
+static const unsigned char *const part_names[] = {
+	[CHIPINFO_PART_GPU] = "gpu",
+	[CHIPINFO_PART_VIDEO] = "video",
+	[CHIPINFO_PART_CAMERA] = "camera",
+	[CHIPINFO_PART_DISPLAY] = "display",
+	[CHIPINFO_PART_AUDIO] = "audio",
+	[CHIPINFO_PART_MODEM] = "modem",
+	[CHIPINFO_PART_WLAN] = "wlan",
+	[CHIPINFO_PART_COMP] = "compute",
+	[CHIPINFO_PART_SENSORS] = "sensors",
+	[CHIPINFO_PART_NPU] = "npu",
+	[CHIPINFO_PART_SPSS] = "spss",
+	[CHIPINFO_PART_NAV] = "nav",
+	[CHIPINFO_PART_COMPUTE_1] = "compute1",
+	[CHIPINFO_PART_DISPLAY_1] = "display1",
+	[CHIPINFO_PART_NSP] = "nsp",
+	[CHIPINFO_PART_EVA] = "eva",
+	[CHIPINFO_PART_PCIE] = "pcie",
+};
+
+static int chipinfo_get_disabled_cpus(u32 *value_ptr);
+static int read_cpu_subset_parts(u32 *value);
+static int chipinfo_get_disabled_features(u32 chip_info_type_idx,
+					  u32 *disabled_feature_ptr);
+static int read_mm_subset_parts(u32 *value_ptr);
+static void read_and_export_parts_disabled_features(void *fdt_ptr,
+						    int node_offset);
+static int add_platform_info_node(void *fdt_ptr);
+
+/**
+ * chipinfo_get_disabled_cpus() - Retrieves the disabled CPUs from the SOC info.
+ * @value_ptr: A pointer to a u32 variable to store the disabled CPUs.
+ *
+ * This function reads the SOC info from the SMEM and extracts the disabled
+ * CPUs.
+ *
+ * Return: 0 on success, negative on failure.
+ */
+static int chipinfo_get_disabled_cpus(u32 *value_ptr)
+{
+	u32 *subset_ptr;
+	struct socinfo *soc_info_ptr;
+
+	soc_info_ptr = qcom_get_socinfo();
+	if (!soc_info_ptr)
+		return log_msg_ret("Error: Failed to get socinfo\n", -1);
+
+	if (soc_info_ptr->num_clusters == 0x0) {
+		*value_ptr = 0x0;
+	} else {
+		subset_ptr = (u32 *)(soc_info_ptr
+			     + soc_info_ptr->ncluster_array_offset);
+		*value_ptr = (u32)(subset_ptr[0]);
+	}
+
+	return 0;
+}
+
+/**
+ * read_cpu_subset_parts() - Retrieves the disabled CPUs from the SOC info.
+ * @value: A pointer to a u32 variable to store the disabled CPUs.
+ *
+ * This function reads the SOC info from the SMEM and extracts the disabled
+ * CPUs.
+ *
+ * Return: 0 on success, negative on failure.
+ */
+static int read_cpu_subset_parts(u32 *value)
+{
+	int ret;
+
+	ret = chipinfo_get_disabled_cpus(value);
+	if (ret)
+		log_err("Failed to get subset[0] CPU. %d\n", ret);
+
+	return ret;
+}
+
+/**
+ * chipinfo_get_disabled_features() - Retrieves the disabled features from the SOC info.
+ * @chip_info_type_idx: The index of the chip info type to retrieve the
+ * disabled features for.
+ * @disabled_feature_ptr: A pointer to a u32 variable to store the disabled features.
+ *
+ * This function reads the SOC info from the SMEM and extracts the disabled
+ * features.
+ *
+ * Return: CHIPINFO_SUCCESS on success, CHIPINFO_ERROR_INVALID_PARAMETER on
+ * failure.
+ */
+static int chipinfo_get_disabled_features(u32 chip_info_type_idx,
+					  u32 *disabled_feature_ptr)
+{
+	u32 *subset_ptr;
+	struct socinfo *soc_info_ptr;
+
+	if (chip_info_type_idx >= CHIPINFO_NUM_PARTS)
+		return CHIPINFO_ERROR_INVALID_PARAMETER;
+
+	soc_info_ptr = qcom_get_socinfo();
+	if (!soc_info_ptr)
+		return log_msg_ret("Error: Failed to get socinfo\n", -1);
+
+	subset_ptr = (u32 *)(soc_info_ptr
+		     + soc_info_ptr->nsubset_parts_array_offset);
+	*disabled_feature_ptr = (u32)(subset_ptr[chip_info_type_idx]);
+
+	return CHIPINFO_SUCCESS;
+}
+
+/**
+ * read_mm_subset_parts() - Retrieves the disabled MM subset parts from the SOC info.
+ * @value_ptr: A pointer to a u32 variable to store the disabled MM
+ * subset parts.
+ *
+ * This function reads the SOC info from the SMEM and extracts the disabled MM
+ * subset parts.
+ *
+ * Return: 0 on success, negative on failure.
+ */
+static int read_mm_subset_parts(u32 *value_ptr)
+{
+	u32 idx;
+	u32 subset_val;
+	int ret;
+	*value_ptr = 0;
+
+	for (idx = 1; idx < CHIPINFO_NUM_PARTS; idx++) {
+		subset_val = 0;
+		ret = chipinfo_get_disabled_features(idx, &subset_val);
+		if (ret) {
+			log_err("Failed to get MM subset[%d] part. %d\n",
+				idx, ret);
+			continue;
+		}
+		*value_ptr |= ((subset_val & 0x01) << idx);
+	}
+	return ret;
+}
+
+/**
+ * read_and_export_parts_disabled_features() - Reads and exports the disabled
+ * features for each part.
+ * @fdt_ptr: The firmware DT node to update.
+ * @node_offset: The offset in the DT node where the features should be set.
+ *
+ * This function reads the SOC info from the SMEM and extracts the disabled
+ * features for each part. It then exports these features to the firmware DT
+ * node.
+ */
+static void read_and_export_parts_disabled_features(void *fdt_ptr, int node_offset)
+{
+	u32 mask, n_idx = 0, n_parts = 1;
+	int offset_child;
+	char str_buffer[24];
+	int ret, part;
+
+	for (part = CHIPINFO_PART_GPU; part <= CHIPINFO_PART_PCIE; part++) {
+		mask = 0;
+		ret = chipinfo_get_disabled_features(n_idx, &mask);
+		if (ret) {
+			log_err("Failed to get Part %s information. %d\n",
+				part_names[part], ret);
+			mask = UINT32_MAX;
+			n_parts = UINT32_MAX;
+		}
+		snprintf(str_buffer, sizeof(str_buffer), "subset-%s",
+			 part_names[part]);
+		offset_child = fixup_dt_node(fdt_ptr, node_offset,
+					     str_buffer, NULL, ADD_SUBNODE);
+		if (offset_child < 0) {
+			log_err("Error adding %s, Error: %d\n", str_buffer,
+				offset_child);
+			continue;
+		}
+		ret = fixup_dt_node(fdt_ptr, offset_child, "part-info",
+				    (void *)&mask, SET_PROP_U32);
+		if (ret)
+			log_err("ERROR: Cannot update part-info prop\n");
+
+		ret = fixup_dt_node(fdt_ptr, offset_child, "part-count",
+				    (void *)&n_parts, SET_PROP_U32);
+		if (ret)
+			log_err("ERROR: Cannot update part-count prop\n");
+	}
+}
+
+/**
+ * add_platform_info_node() - Adds the platform info node to the firmware DT.
+ * @fdt_ptr: The firmware DT to update.
+ *
+ * This function creates the platform info node in the firmware DT and sets its
+ * properties.
+ *
+ * Return: The offset of the platform info node on success, negative on failure.
+ */
+static int add_platform_info_node(void *fdt_ptr)
+{
+	int offset;
+
+	offset = fdt_path_offset(fdt_ptr, "/firmware/qcom,platform-parts-info");
+	if (offset >= 0)
+		return offset;
+	offset = fdt_path_offset(fdt_ptr, "/firmware");
+	if (offset < 0) {
+		offset = fixup_dt_node(fdt_ptr, 0, "firmware", NULL, ADD_SUBNODE);
+		if (offset < 0)
+			return log_msg_ret("Error creating firmware node\n",
+				offset);
+	}
+	offset = fixup_dt_node(fdt_ptr, offset, "qcom,platform-parts-info", NULL,
+			       ADD_SUBNODE);
+	if (offset < 0)
+		log_err("Error adding qcom,platform-parts-info, Error: %d\n",
+			offset);
+
+	return offset;
+}
+
+/**
+ * subsetparts_fixup_handler() - This function is the entry point for the
+ * Subset Parts fixup handler.
+ * @fdt_ptr: The firmware DT node to update.
+ *
+ * It reads the SOC info from the SMEM, extracts the disabled subset parts, and
+ * exports them to the firmware DT node.
+ */
+void subsetparts_fixup_handler(struct fdt_header *fdt_ptr)
+{
+	u32 subset_parts_mm_value;
+	u32 subset_parts_cpu_value;
+	int offset;
+	int ret;
+
+	offset = add_platform_info_node(fdt_ptr);
+	if (offset < 0) {
+		log_err("Failed to add qcom,platform-parts-info node in %s\n",
+			__func__);
+		return;
+	}
+	ret = read_mm_subset_parts(&subset_parts_mm_value);
+	if (ret) {
+		log_err("No mm Subset parts found\n");
+	} else {
+		ret = fixup_dt_node(fdt_ptr, offset, "subset-parts",
+				    (void *)&subset_parts_mm_value, SET_PROP_U32);
+		if (ret)
+			log_err("ERROR: Cannot update subset-parts prop\n");
+	}
+	ret = read_cpu_subset_parts(&subset_parts_cpu_value);
+	if (ret) {
+		log_err("No Subset parts for cpu ss found\n");
+	} else {
+		ret = fixup_dt_node(fdt_ptr, offset, "subset-cores",
+				    (void *)&subset_parts_cpu_value, SET_PROP_U32);
+		if (ret)
+			log_err("ERROR: Cannot update subset-cores prop\n");
+	}
+	read_and_export_parts_disabled_features(fdt_ptr, offset);
+}
diff --git a/arch/arm/mach-snapdragon/rampart.h b/arch/arm/mach-snapdragon/rampart.h
new file mode 100644
index 00000000000..58b3c6ecc1c
--- /dev/null
+++ b/arch/arm/mach-snapdragon/rampart.h
@@ -0,0 +1,236 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
-- 
2.34.1

