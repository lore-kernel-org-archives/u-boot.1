Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C472DF43698
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 621D18426C;
	Fri, 17 Apr 2026 14:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ceIYi+aj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZJyIm8MR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22FB38426E; Fri, 17 Apr 2026 14:11:08 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C8683B99
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H7jep61092082
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=avlpq7oHPS3
 IA38gznl4EdpFS2TES0J3b3QJLodzb9o=; b=ceIYi+ajZ52lsaLcDumrziTlW3R
 YwK8aemNlUebQ1QPJ5vQTJw4aNSz78xK1esFxGCIvRZbvzsalMrP4QDXm1IDU6tj
 s5UsR8Cg8gEkKlPZ+iiI2tY0NoOhCIf0Z0YKN01sfKUIWBbGXD7yzlgd+xR9Nkq6
 1rS/pISmeqwAko54Uic0mg4isM1gOom7dx05HbqVIJoYIhb5mz7gGsYGUJ217Nty
 T/RhqBQ2KnAa7TFqdIfNJRFXBdcZNIfqVy55fPNeZgdDfEv8E7wjyheE5q0am6e2
 DJJ334zwsMBvxyuduqqH13/+SYI1zhiOVDUZe2OPIQ+kJqwOQOMFMKGIBIw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk227v3ea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:10:58 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f32d67ba7so361402b3a.0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 05:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776427857; x=1777032657; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=avlpq7oHPS3IA38gznl4EdpFS2TES0J3b3QJLodzb9o=;
 b=ZJyIm8MR6nRgA1l005AXIwJ4fiBMwkiUh0Rzc4ppoh8qTjnLnUh4mfAFCg+fFMOCH8
 pDgP11fX79Wkwud33jzqYB/chvMIwS2wkzWfoTT0PbVwc/ym00w/cZtxB8AaMNj0tLg3
 ENp62l1miYMqJvvviM30jZI3uEjxZRGQEOj1djeA8o4uyyC7ow/fDuY4belEH4MzjJDw
 Ic8EKHPYudDEvfZfjOWpFCY54SfGb68x/J/njIhS935rLa5Iu7QHnI9c+8e2Ejjcafwr
 zPc24pPZVrC+d+Ct7b37L7F+O+qPY4E9d071rZxunRNu5NKmzCC1GmBsNhDUYrtkMzUo
 82XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776427857; x=1777032657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=avlpq7oHPS3IA38gznl4EdpFS2TES0J3b3QJLodzb9o=;
 b=m8o3DSUrW3tL8JS0rUdivl/9TwOMTvmTj3o2T+Z6nF2Ll6ZnxxG3Y4+XwPWHLCMLp6
 /YR/ZchZXBEN8KvI4wyYrBFFiRXLD12y8Uwcg79vnmfwqq2gtHGIOsUiFVOQsURm561X
 8DVpIPatRQnlpcJfScoZGwLjiou/dS5o0bu7SHiaEfmOR9g8J4H/neRoFqFdLVDt0cxz
 BPZYmtW6LMGujj0YTd5mCXG6hd7oLNan3dFxeGwO0HNv9nMehit1+kFNhh83XCl+yWAT
 BxWHG9Lj6VpXtk7Il7nIOr4EpVKsQUVa4DHaEh8qY2dxyWrQ+6oEzGmskD5SqOWGRBz2
 3RqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Rn5dTUOjWzP8Z1TwINfm2yL92YAByR52bwvs/3rjGNo+B6OFqwZR+n8hwljtPqM4Z2FdMuXo=@lists.denx.de
X-Gm-Message-State: AOJu0YyBHCCCWgJluOmxsCupcfA41+5tgnyWcHmA9dfoo/PLBgxYxMm7
 WCOcG2kt8VUqHm/vAULaUAQgIGj+ZLIyz8L7STee53uG2mRVlhEhKwjwO9Wsl+bs98P9qw5MMH6
 4D5tjYxRFNBu+qM/DSqmgrLdZDfQCdt4OWjxNVVWjTU+3CBtQG03rxks4
X-Gm-Gg: AeBDiesRQrVmCgjaQSILtlkAiRF3Kr8boUXr/aX0EE01CfBkep1uakY5Yd7cCjEcgxO
 D+kGZbq1ztHA2sxssAwWzNHCCRfeNSEvHLSm5oHCA/GP+5lFdPLyqbPeXz4Gw/bgAZwtSFj78Wn
 zB18Pul858d8/9BQCPjncZZaRoW1S8Lj5JUuIOEFDhPhNhm3w6jkkzrPG2JneNa8sxTULGmgbZO
 QdgRPy7It/D3ziq9TVdEnSOWjBaN3D8wEtmeESXYhNQ7JQSJBNFwPmWSfNKWFQkNT/LPN1F4GOG
 L8CmcVphhsyTtr7zwXeTa2wVEzG07/MnLm5CCrsFzw9LuLV/ow3jzZS7u9OAMB7o127tLet9si0
 QIdLtKwKNlxM/nw7J4vmjcBYNuUGngu5qNLXddpHY7esgyhwJUuhyroO5Hd1Ywhe6DZl9vGR+Y0
 x5Jr7B9gK99Zcv4ZlxmZjYljgMhaxnUMKZQZY4MYK77eajAXHr/YA=
X-Received: by 2002:a05:6a00:2191:b0:82f:5726:be23 with SMTP id
 d2e1a72fcca58-82f8c9ed41emr2741384b3a.49.1776427856463; 
 Fri, 17 Apr 2026 05:10:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:2191:b0:82f:5726:be23 with SMTP id
 d2e1a72fcca58-82f8c9ed41emr2741316b3a.49.1776427855690; 
 Fri, 17 Apr 2026 05:10:55 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9cbb28sm1744641b3a.13.2026.04.17.05.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 05:10:55 -0700 (PDT)
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
Subject: [PATCH v3 2/7] mach-snapdragon: Add FIT multi-DTB selection support
Date: Fri, 17 Apr 2026 17:39:46 +0530
Message-Id: <20260417120951.3454249-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEyMiBTYWx0ZWRfXzx8JpeZWTh6c
 Zn4OgofIxOS/YvIu5IUxYmoHVcUemXdVSVr3VFmX/JOB/dsSgXP4eKwNE3UtG++IhL7q9jZi9oN
 ThpGrYZaJV72OpQDYunZn/KE3iRv2mP5AH/Y1xT6DMnw4u5TS+GXdahXMWniAqoKIWaKBIHAD+e
 3aSUvoRnIwiSiKxAwltMs7yjzhbPhMg9jUWgI5yEoTYBuzivTvoT/Oy+G4UFC1hNGbc/71t+76p
 aDvgN41KTTZulDXrvlmjl3XqB2qNx+OM9fnxnliOoYDckEmC4jT0pccyYVwrXlu3u38SNib7xwQ
 3A+qJPhgzFnHRCEuw4OpSnEJqyyEk33Ay1CyVT1bHi7L7ja6PFKcZnnpvSElSFeQGVBmQjynvIs
 rSyZaay00qY8LiuHzI+OV382cFIqXGPw49PnO1jyHe+aZJbX83Rc43ezUEu2SkNbt02VvsWZ2Py
 HUI45fow0eGmiBbfLmQ==
X-Proofpoint-ORIG-GUID: Y0xCiDXiT9iQBkisKOxZJ1GMqac8zORW
X-Proofpoint-GUID: Y0xCiDXiT9iQBkisKOxZJ1GMqac8zORW
X-Authority-Analysis: v=2.4 cv=Iuoutr/g c=1 sm=1 tr=0 ts=69e22352 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=eWZCHF7YNRQTzhUL8lUA:9 a=0lg15e8vmr8byGcQ:21 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
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

Implement multi DTB selection from FIT images based on hardware
detection via SMEM.

The implementation provides:

1. Hardware Detection: Reads SoC parameters from SMEM including chip ID,
   version, platform ID, OEM variant, DDR size, and storage type from IMEM.

2. Metadata DTB Processing: Parses a metadata DTB (first image in FIT)
   to build a "bucket list" of hardware-specific node names that match
   the detected hardware parameters.

3. FIT Configuration Matching: Uses standard FIT mechanisms to find the
   configuration with the most matching tokens in its compatible string
   compared to the hardware-derived bucket list.

4. DTB Loading and Overlays: Loads the base DTB and applies any DTBOs
   specified in the selected configuration using standard FIT overlay
   application.

5. EFI Integration: Loads selected dtb from qclinux_fit.img and sets
   fdt_addr for use by the EFI boot flow.

This enables multi DTB selection across hardware variants.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v3:
1. Runtime IMEM address lookup via DT: Removed CONFIG_QCOM_IMEM_SIZE Kconfig option.
   Added qcom_imem_table[] mapping SoC compatible strings to IMEM addresses.

2. Split SoC version sources: SoC hardware version now read from TCSR register via
   qcom_read_tcsr_soc_version(). The soc_info->plat_ver from SMEM is stored separately
   as board_version. Added socver and boardrev metadata node matching for finer-grained DTB selection.

3. qcom_load_fit_image() returns int: Changed return type from efi_status_t to int,
   returning standard Linux error codes for consistency with the rest of the driver.

4. Code cleanup: strtok() replaced with strsep(); memcpy + manual null-termination replaced with strlcpy();
   DDR thresholds use SZ_* macros; compatible matching and FDT loading extracted into dedicated helpers.
---
 arch/arm/mach-snapdragon/Kconfig             |    8 +
 arch/arm/mach-snapdragon/Makefile            |    1 +
 arch/arm/mach-snapdragon/board.c             |    7 +
 arch/arm/mach-snapdragon/qcom_fit_multidtb.c | 1103 ++++++++++++++++++
 arch/arm/mach-snapdragon/qcom_fit_multidtb.h |  189 +++
 5 files changed, 1308 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.c
 create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.h

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index d3de8693b5a..0f03672ee6b 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -42,4 +42,12 @@ config SYS_CONFIG_NAME
 	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
 	  will be used for board configuration.
 
+config QCOM_FIT_MULTIDTB
+	bool "Enable FIT multi-DTB selection for Qualcomm platforms"
+	depends on FIT
+	help
+	  Enable FIT multi-DTB selection for Qualcomm platforms.
+	  This allows U-Boot to select the appropriate device tree
+	  from a FIT image.
+
 endif
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 343e825c6fd..76e285021a1 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -5,3 +5,4 @@
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
 obj-$(CONFIG_OF_LIVE) += of_fixup.o
+obj-$(CONFIG_QCOM_FIT_MULTIDTB) += qcom_fit_multidtb.o
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 6edb61b5b36..6a482ed186e 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -35,6 +35,7 @@
 #include <sort.h>
 #include <time.h>
 
+#include "qcom_fit_multidtb.h"
 #include "qcom-priv.h"
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -585,6 +586,12 @@ int board_late_init(void)
 	/* Configure the dfu_string for capsule updates */
 	qcom_configure_capsule_updates();
 
+	/* Try FIT multi-DTB selection if enabled */
+	if (IS_ENABLED(CONFIG_QCOM_FIT_MULTIDTB)) {
+		if (!qcom_fit_multidtb_setup())
+			log_debug("FIT multi-DTB selection not available or failed\n");
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-snapdragon/qcom_fit_multidtb.c b/arch/arm/mach-snapdragon/qcom_fit_multidtb.c
new file mode 100644
index 00000000000..7bf4449ea03
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom_fit_multidtb.c
@@ -0,0 +1,1103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm FIT Multi-DTB Selection
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Automatic DTB selection from FIT images based on hardware detection via SMEM.
+ * Loads qclinux_fit.img from dtb partition, detects hardware parameters,
+ * and selects the best matching DTB configuration.
+ */
+
+#include <blk.h>
+#include <dm.h>
+#include <efi_api.h>
+#include <efi_loader.h>
+#include <env.h>
+#include <image.h>
+#include <lmb.h>
+#include <log.h>
+#include <malloc.h>
+#include <part.h>
+#include <smem.h>
+#include <asm/io.h>
+#include <linux/errno.h>
+#include <linux/libfdt.h>
+#include <linux/list.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+#include <soc/qcom/socinfo.h>
+
+#include "qcom_fit_multidtb.h"
+#include "qcom-priv.h"
+
+#define TCSR_SOC_HW_VERSION        0x01fc8000
+#define TCSR_MAJOR_VERSION_MASK    0x0000ff00
+#define TCSR_MAJOR_VERSION_SHIFT   8
+#define TCSR_MINOR_VERSION_MASK    0x000000ff
+#define TCSR_MINOR_VERSION_SHIFT   0
+
+#define lmb_alloc(size, addr) lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, addr, size, LMB_NONE)
+
+/* Maximum values to match (SOC needs 2) */
+#define MAX_MATCH_VALUES 2
+
+/* Metadata DTB node names */
+#define META_NODE_OEM          "oem"
+#define META_NODE_SOC          "soc"
+#define META_NODE_SOCVER       "socver"
+#define META_NODE_BOARD        "board"
+#define META_NODE_BOARDREV     "boardrev"
+#define META_NODE_SOC_SKU      "soc-sku"
+#define META_NODE_BOARD_SUBTYPE_PERIPHERAL "board-subtype-peripheral-subtype"
+#define META_NODE_BOARD_SUBTYPE_STORAGE    "board-subtype-storage-type"
+#define META_NODE_BOARD_SUBTYPE_DDR_SIZE   "board-subtype-memory-size"
+#define META_NODE_SOFTSKU      "softsku"
+
+/* Property names */
+#define PROP_OEM_ID            "oem-id"
+#define PROP_MSM_ID            "msm-id"
+#define PROP_SOCVER_ID         "socver-id"
+#define PROP_BOARD_ID          "board-id"
+#define PROP_BOARDREV_ID       "boardrev-id"
+#define PROP_BOARD_SUBTYPE     "board-subtype"
+#define PROP_SOFTSKU_ID        "softsku-id"
+#define PROP_COMPATIBLE        "compatible"
+#define PROP_FDT               "fdt"
+#define PROP_DATA              "data"
+
+/**
+ * add_to_bucket() - Add a node name to the bucket list
+ * @name: Node name to add
+ * @name_len: Length of the name
+ * @bucket_head: Head of the bucket list
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int add_to_bucket(const char *name, int name_len, struct list_head *bucket_head)
+{
+	struct bucket_node *node;
+
+	node = malloc(sizeof(*node));
+	if (!node)
+		return -ENOMEM;
+
+	node->name = malloc(name_len + 1);
+	if (!node->name) {
+		free(node);
+		return -ENOMEM;
+	}
+
+	strlcpy(node->name, name, name_len + 1);
+
+	list_add_tail(&node->list, bucket_head);
+
+	return 0;
+}
+
+/**
+ * search_in_bucket() - Check if a name exists in the bucket list
+ * @name: Name to search for
+ * @bucket_head: Head of the bucket list
+ *
+ * Return: true if found, false otherwise
+ */
+static bool search_in_bucket(const char *name, struct list_head *bucket_head)
+{
+	struct bucket_node *node;
+
+	list_for_each_entry(node, bucket_head, list) {
+		if (!strcmp(node->name, name))
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * free_bucket_list() - Free all nodes in the bucket list
+ * @bucket_head: Head of the bucket list
+ */
+static void free_bucket_list(struct list_head *bucket_head)
+{
+	struct bucket_node *node, *tmp;
+
+	list_for_each_entry_safe(node, tmp, bucket_head, list) {
+		list_del(&node->list);
+		free(node->name);
+		free(node);
+	}
+}
+
+/**
+ * qcom_get_ddr_size_type() - Get DDR size type from SMEM RAM partitions
+ * @ddr_type: Pointer to store DDR type
+ *
+ * This function reads RAM partition information from SMEM and calculates
+ * the total DDR size, then maps it to a DDR type constant (0-10).
+ *
+ * Return: 0 on success, negative on failure
+ */
+static int qcom_get_ddr_size_type(u32 *ddr_type)
+{
+	struct usable_ram_partition_table *rpt;
+	struct ram_partition_entry *rpe;
+	u64 total_ddr_size = 0;
+	int part;
+
+	rpt = qcom_get_ram_partitions();
+	if (!rpt) {
+		log_err("Failed to get RAM partition table\n");
+		return -ENOENT;
+	}
+
+	rpe = &rpt->ram_part_entry[0];
+	for (part = 0; part < rpt->num_partitions; part++, rpe++) {
+		if (rpe->partition_category == RAM_PARTITION_SDRAM &&
+		    rpe->partition_type == RAM_PARTITION_SYS_MEMORY) {
+			total_ddr_size += rpe->available_length;
+			log_debug("RAM partition %d: start=0x%llx size=0x%llx\n",
+				  part, rpe->start_address, rpe->available_length);
+		}
+	}
+
+	log_info("Total DDR Size: 0x%llx (%llu MB)\n",
+		 total_ddr_size, total_ddr_size / SZ_1M);
+
+	*ddr_type = 0;
+	if (total_ddr_size <= DDR_128MB)
+		*ddr_type = DDRTYPE_128MB;
+	else if (total_ddr_size <= DDR_256MB)
+		*ddr_type = DDRTYPE_256MB;
+	else if (total_ddr_size <= DDR_512MB)
+		*ddr_type = DDRTYPE_512MB;
+	else if (total_ddr_size <= DDR_1024MB)
+		*ddr_type = DDRTYPE_1024MB;
+	else if (total_ddr_size <= DDR_2048MB)
+		*ddr_type = DDRTYPE_2048MB;
+	else if (total_ddr_size <= DDR_3072MB)
+		*ddr_type = DDRTYPE_3072MB;
+	else if (total_ddr_size <= DDR_4096MB)
+		*ddr_type = DDRTYPE_4096MB;
+
+	log_debug("DDR Type: %u\n", *ddr_type);
+
+	return 0;
+}
+
+/**
+ * qcom_get_imem_address() - Look up shared IMEM cookie address for this SoC
+ *
+ * Reads the root node compatible string from the device tree and searches
+ * the qcom_imem_table for a matching entry.
+ *
+ * Return: Physical address of shared IMEM cookie, or 0 if not found
+ */
+static uintptr_t qcom_get_imem_address(void)
+{
+	const struct qcom_imem_info *entry;
+	const char *soc_compat;
+	int len;
+
+	soc_compat = fdt_getprop(gd->fdt_blob, 0, "compatible", &len);
+	if (!soc_compat) {
+		log_warning("Cannot read SoC compatible from DT\n");
+		return 0;
+	}
+
+	for (entry = qcom_imem_table; entry->compatible; entry++) {
+		if (fdt_stringlist_contains(soc_compat, len, entry->compatible))
+			return entry->shared_imem_addr;
+	}
+
+	log_warning("SoC not found in IMEM table\n");
+	return 0;
+}
+
+/**
+ * qcom_get_storage_type() - Detect storage type (UFS/EMMC/NAND)
+ *
+ * Reads the boot device type from the shared IMEM cookie structure populated
+ * by the bootloader. The shared IMEM address is looked up from a per-SoC
+ * table (qcom_imem_table) using the device tree compatible string.
+ *
+ * Falls back to UFS if the SoC is not in the table or if the IMEM cookie
+ * magic/version validation fails.
+ *
+ * Return: mem_card_type enum value (UFS/EMMC/NAND), or UFS as fallback
+ */
+static enum mem_card_type qcom_get_storage_type(void)
+{
+	struct boot_imem_cookie *imem;
+	uintptr_t shared_imem_addr;
+
+	shared_imem_addr = qcom_get_imem_address();
+	if (!shared_imem_addr) {
+		log_warning("SoC not in IMEM table, defaulting to UFS\n");
+		return UFS;
+	}
+
+	imem = (struct boot_imem_cookie *)shared_imem_addr;
+
+	if (imem->shared_imem_magic != BOOT_SHARED_IMEM_MAGIC_NUM) {
+		log_warning("Invalid shared IMEM magic: 0x%x, defaulting to UFS\n",
+			    imem->shared_imem_magic);
+		return UFS;
+	}
+
+	if (imem->shared_imem_version < BOOT_SHARED_IMEM_VERSION_NUM) {
+		log_warning("Invalid shared IMEM version: %u, defaulting to UFS\n",
+			    imem->shared_imem_version);
+		return UFS;
+	}
+
+	log_info("Shared IMEM: magic=0x%x, version=%u, boot_device_type=%u\n",
+		 imem->shared_imem_magic, imem->shared_imem_version,
+		 imem->boot_device_type);
+
+	switch (imem->boot_device_type) {
+	case UFS_FLASH:
+		return UFS;
+	case MMC_FLASH:
+	case SDC_FLASH:
+		return EMMC;
+	case NAND_FLASH:
+		return NAND;
+	default:
+		log_warning("Unknown shared IMEM boot device: %u, defaulting to UFS\n",
+			    imem->boot_device_type);
+		return UFS;
+	}
+}
+
+static u32 qcom_read_tcsr_soc_version(void)
+{
+	u32 reg_val = readl(TCSR_SOC_HW_VERSION);
+	u32 major = (reg_val & TCSR_MAJOR_VERSION_MASK) >> TCSR_MAJOR_VERSION_SHIFT;
+	u32 minor = (reg_val & TCSR_MINOR_VERSION_MASK) >> TCSR_MINOR_VERSION_SHIFT;
+
+	return (major << 4) | minor;
+}
+
+/**
+ * qcom_detect_hardware_params() - Detect all hardware parameters from SMEM
+ * @params: Pointer to hardware parameters structure
+ *
+ * This function reads hardware information from SMEM and populates the
+ * qcom_hw_params structure with all necessary data for DTB selection.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_detect_hardware_params(struct qcom_hw_params *params)
+{
+	struct socinfo *soc_info;
+	int ret;
+	u32 raw_version;
+
+	memset(params, 0, sizeof(*params));
+
+	soc_info = qcom_get_socinfo();
+	if (!soc_info) {
+		log_err("Failed to get SOC info from SMEM\n");
+		return -ENODEV;
+	}
+
+	params->chip_id = le32_to_cpu(soc_info->id) & 0xffff;
+
+	raw_version = le32_to_cpu(soc_info->plat_ver);
+	params->board_version = (SOCINFO_MAJOR(raw_version) << 4) | SOCINFO_MINOR(raw_version);
+
+	params->chip_version = qcom_read_tcsr_soc_version();
+
+	params->platform = le32_to_cpu(soc_info->hw_plat);
+	params->subtype = le32_to_cpu(soc_info->hw_plat_subtype);
+
+	if (le32_to_cpu(soc_info->fmt) >= 17)
+		params->oem_variant_id = le32_to_cpu(soc_info->oem_variant);
+
+	if (le32_to_cpu(soc_info->fmt) >= 9)
+		params->foundry_id = le32_to_cpu(soc_info->foundry_id);
+
+	ret = qcom_get_ddr_size_type(&params->ddr_size_type);
+	if (ret)
+		log_warning("Failed to get DDR size, defaulting to 0\n");
+
+	params->storage_type = qcom_get_storage_type();
+
+	log_info("Hardware Parameters:\n");
+	log_info("  Chip ID: 0x%x\n", params->chip_id);
+	log_info("  Chip Version: 0x%x\n", params->chip_version);
+	log_info("  Board Version: 0x%x\n", params->board_version);
+	log_info("  Platform: 0x%x\n", params->platform);
+	log_info("  Subtype: 0x%x\n", params->subtype);
+	log_info("  OEM Variant ID: 0x%x\n", params->oem_variant_id);
+	log_info("  DDR Size Type: %u\n", params->ddr_size_type);
+	log_info("  Storage Type: %u\n", params->storage_type);
+	log_info("  Foundry ID: 0x%x\n", params->foundry_id);
+
+	return 0;
+}
+
+/**
+ * log_match_values() - Log matched hardware parameter values
+ * @log_type: Type label for logging (e.g., "SOC", "Board")
+ * @subnode_name: Name of the matched node
+ * @num_match_values: Number of values to log
+ * @match_values: Array of matched values
+ */
+static void log_match_values(const char *log_type, const char *subnode_name,
+			     int num_match_values, const u32 *match_values)
+{
+	int i;
+
+	log_info("Matched %s: %s (", log_type, subnode_name);
+
+	for (i = 0; i < num_match_values; i++) {
+		if (i > 0)
+			log_info(", ");
+		log_info("val%d=0x%x", i + 1, match_values[i]);
+	}
+
+	log_info(")\n");
+}
+
+/**
+ * process_node() - Generic metadata node processor
+ * @type: Type of node to process
+ * @metadata: Metadata DTB pointer
+ * @root_offset: Root node offset
+ * @params: Hardware parameters
+ * @bucket_head: Bucket list head
+ *
+ * Processes different types of nodes in the metadata DTB. Handles matching
+ * hardware parameters against DTB properties, with support for bit masking/shifting
+ * and fallback values.
+ *
+ * Return: 0 on success, -ENOENT if no match, other negative on error
+ */
+static int process_node(enum node_process_type type,
+		       void *metadata,
+		       int root_offset,
+		       struct qcom_hw_params *params,
+		       struct list_head *bucket_head)
+{
+	const char *node_name, *prop_name, *log_type;
+	const char *fallback;
+	const char *subnode_name;
+	int node_offset, subnode, len, name_len;
+	int num_match_values, i;
+	u32 match_values[MAX_MATCH_VALUES];
+	u32 masks[MAX_MATCH_VALUES];
+	int shifts[MAX_MATCH_VALUES];
+	bool all_match;
+
+	fallback = NULL;
+	num_match_values = 1;
+	memset(shifts, 0, sizeof(shifts));
+	memset(masks, 0xff, sizeof(masks));
+
+	switch (type) {
+	case NODE_TYPE_OEM:
+		node_name = META_NODE_OEM;
+		prop_name = PROP_OEM_ID;
+		match_values[0] = params->oem_variant_id;
+		log_type = "OEM";
+		fallback = "qcom";
+		break;
+	case NODE_TYPE_SOC:
+		node_name = META_NODE_SOC;
+		prop_name = PROP_MSM_ID;
+		match_values[0] = params->chip_id;
+		masks[0] = 0xffff;
+		num_match_values = 1;
+		log_type = "SOC";
+		break;
+	case NODE_TYPE_SOCVER:
+		node_name = META_NODE_SOCVER;
+		prop_name = PROP_SOCVER_ID;
+		match_values[0] = params->chip_version;
+		num_match_values = 1;
+		log_type = "SOCVER";
+		break;
+	case NODE_TYPE_BOARD:
+		node_name = META_NODE_BOARD;
+		prop_name = PROP_BOARD_ID;
+		match_values[0] = params->platform;
+		log_type = "Board";
+		break;
+	case NODE_TYPE_BOARDREV:
+		node_name = META_NODE_BOARDREV;
+		prop_name = PROP_BOARDREV_ID;
+		match_values[0] = params->board_version;
+		num_match_values = 1;
+		log_type = "BoardRev";
+		break;
+	case NODE_TYPE_PERIPHERAL:
+		node_name = META_NODE_BOARD_SUBTYPE_PERIPHERAL;
+		prop_name = PROP_BOARD_SUBTYPE;
+		match_values[0] = params->subtype;
+		log_type = "Peripheral Subtype";
+		break;
+	case NODE_TYPE_STORAGE:
+		node_name = META_NODE_BOARD_SUBTYPE_STORAGE;
+		prop_name = PROP_BOARD_SUBTYPE;
+		match_values[0] = params->storage_type;
+		masks[0] = 0x7000;
+		shifts[0] = 12;
+		log_type = "Storage";
+		break;
+	case NODE_TYPE_DDR_SIZE:
+		node_name = META_NODE_BOARD_SUBTYPE_DDR_SIZE;
+		prop_name = PROP_BOARD_SUBTYPE;
+		match_values[0] = params->ddr_size_type;
+		masks[0] = 0xf00;
+		shifts[0] = 8;
+		log_type = "DDR Size";
+		break;
+	case NODE_TYPE_SOFTSKU:
+		node_name = META_NODE_SOFTSKU;
+		prop_name = PROP_SOFTSKU_ID;
+		match_values[0] = params->softsku_id;
+		log_type = "SoftSKU";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	node_offset = fdt_subnode_offset(metadata, root_offset, node_name);
+	if (node_offset < 0) {
+		log_debug("%s node not found\n", log_type);
+		return node_offset;
+	}
+
+	fdt_for_each_subnode(subnode, metadata, node_offset) {
+		const u32 *prop = fdt_getprop(metadata, subnode, prop_name, &len);
+
+		if (!prop || len < (int)(num_match_values * sizeof(u32)))
+			continue;
+
+		all_match = true;
+		for (i = 0; i < num_match_values; i++) {
+			u32 dtb_value = fdt32_to_cpu(prop[i]);
+
+			dtb_value = (dtb_value & masks[i]) >> shifts[i];
+
+			if (dtb_value != match_values[i]) {
+				all_match = false;
+				break;
+			}
+		}
+
+		if (!all_match)
+			continue;
+
+		subnode_name = fdt_get_name(metadata, subnode, &name_len);
+		if (subnode_name) {
+			log_match_values(log_type, subnode_name, num_match_values,
+					 match_values);
+			return add_to_bucket(subnode_name, name_len, bucket_head);
+		}
+	}
+
+	if (fallback) {
+		log_info("No %s match, using fallback '%s'\n", log_type, fallback);
+		return add_to_bucket(fallback, strlen(fallback), bucket_head);
+	}
+
+	log_debug("No %s match\n", log_type);
+
+	return -ENOENT;
+}
+
+/**
+ * qcom_build_bucket_list() - Build bucket list from metadata DTB
+ * @metadata: Metadata DTB pointer
+ * @params: Hardware parameters
+ * @bucket_head: Bucket list head
+ *
+ * This function parses the metadata DTB and builds a list of matching
+ * node names based on the detected hardware parameters.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_build_bucket_list(void *metadata,
+				  struct qcom_hw_params *params,
+				  struct list_head *bucket_head)
+{
+	int root_offset;
+	int ret;
+	struct bucket_node *node;
+
+	log_debug("Building bucket list from hardware parameters\n");
+
+	root_offset = fdt_path_offset(metadata, "/");
+	if (root_offset < 0) {
+		log_err("Failed to find root node in metadata DTB\n");
+		return root_offset;
+	}
+
+	ret = process_node(NODE_TYPE_OEM, metadata, root_offset,
+			   params, bucket_head);
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
+	ret = process_node(NODE_TYPE_SOC, metadata, root_offset,
+			   params, bucket_head);
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
+	ret = process_node(NODE_TYPE_SOCVER, metadata, root_offset,
+			   params, bucket_head);
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
+	ret = process_node(NODE_TYPE_BOARD, metadata, root_offset,
+			   params, bucket_head);
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
+	ret = process_node(NODE_TYPE_BOARDREV, metadata, root_offset,
+			   params, bucket_head);
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
+	process_node(NODE_TYPE_PERIPHERAL, metadata, root_offset,
+		     params, bucket_head);
+
+	process_node(NODE_TYPE_STORAGE, metadata, root_offset,
+		     params, bucket_head);
+
+	process_node(NODE_TYPE_DDR_SIZE, metadata, root_offset,
+		     params, bucket_head);
+
+	process_node(NODE_TYPE_SOFTSKU, metadata, root_offset,
+		     params, bucket_head);
+
+	log_debug("Bucket list: ");
+	list_for_each_entry(node, bucket_head, list)
+		log_debug("%s ", node->name);
+	log_debug("\n");
+
+	return 0;
+}
+
+/**
+ * qcom_load_fit_image() - Load FIT image from EFI partition
+ * @fitp: Pointer to store FIT image address
+ * @fit_sizep: Pointer to store FIT image size
+ *
+ * This function loads qclinux_fit.img from the EFI partition using the
+ * EFI Simple File System Protocol, matching the pattern from efi_fdt.c
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_load_fit_image(void **fitp, efi_uintn_t *fit_sizep)
+{
+	efi_status_t ret;
+	efi_handle_t *volume_handles = NULL;
+	efi_uintn_t count;
+	struct efi_handler *handler;
+	struct efi_simple_file_system_protocol *fs;
+	struct efi_file_handle *root = NULL;
+	struct efi_file_handle *file = NULL;
+	u16 fit_name[] = u"/qclinux_fit.img";
+	u32 i;
+
+	log_info("%s: Loading FIT image from EFI partition\n", __func__);
+
+	ret = efi_locate_handle_buffer_int(BY_PROTOCOL,
+					   &efi_simple_file_system_protocol_guid,
+					   NULL, &count, &volume_handles);
+	if (ret != EFI_SUCCESS) {
+		log_err("Failed to locate file system volumes: %lu\n", ret);
+		return -EIO;
+	}
+
+	for (i = 0; i < count; i++) {
+		ret = efi_search_protocol(volume_handles[i],
+					  &efi_simple_file_system_protocol_guid,
+					  &handler);
+		if (ret != EFI_SUCCESS)
+			continue;
+
+		ret = efi_protocol_open(handler, (void **)&fs, efi_root, NULL,
+					EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+		if (ret != EFI_SUCCESS)
+			continue;
+
+		ret = EFI_CALL(fs->open_volume(fs, &root));
+		if (ret != EFI_SUCCESS)
+			continue;
+
+		ret = EFI_CALL(root->open(root, &file, fit_name,
+					  EFI_FILE_MODE_READ, 0));
+		if (ret == EFI_SUCCESS) {
+			log_info("%s: %ls found!\n", __func__, fit_name);
+			break;
+		}
+
+		EFI_CALL(root->close(root));
+		root = NULL;
+	}
+
+	if (!file) {
+		log_err("FIT image not found on any volume\n");
+		efi_free_pool(volume_handles);
+		return -ENOENT;
+	}
+
+	ret = efi_file_size(file, fit_sizep);
+	if (ret != EFI_SUCCESS) {
+		log_err("Failed to get FIT file size: %lu\n", ret);
+		goto out;
+	}
+
+	log_info("FIT image size: %lu bytes\n", *fit_sizep);
+
+	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
+				 EFI_BOOT_SERVICES_DATA,
+				 efi_size_in_pages(*fit_sizep),
+				 (efi_physical_addr_t *)fitp);
+	if (ret != EFI_SUCCESS) {
+		log_err("Failed to allocate memory for FIT image: %lu\n", ret);
+		goto out;
+	}
+
+	ret = EFI_CALL(file->read(file, fit_sizep, *fitp));
+	if (ret != EFI_SUCCESS) {
+		log_err("Failed to read FIT image: %lu\n", ret);
+		efi_free_pages((uintptr_t)*fitp, efi_size_in_pages(*fit_sizep));
+		*fitp = NULL;
+	}
+
+out:
+	if (file)
+		EFI_CALL(file->close(file));
+	if (root)
+		EFI_CALL(root->close(root));
+	efi_free_pool(volume_handles);
+
+	return ret;
+}
+
+/**
+ * qcom_extract_metadata_dtb() - Extract metadata DTB from FIT image
+ * @fit: FIT image pointer
+ * @metadata: Pointer to store metadata DTB address
+ * @metadata_size: Pointer to store metadata DTB size
+ *
+ * The metadata DTB is the first image in the FIT (fdt-0).
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_extract_metadata_dtb(void *fit, void **metadata,
+				     size_t *metadata_size)
+{
+	int images_node, first_image;
+	const void *data;
+	size_t size;
+	int ret;
+
+	images_node = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images_node < 0) {
+		log_err("Cannot find /images node in FIT\n");
+		return images_node;
+	}
+
+	first_image = fdt_first_subnode(fit, images_node);
+	if (first_image < 0) {
+		log_err("Cannot find first image in FIT\n");
+		return first_image;
+	}
+
+	ret = fit_image_get_data(fit, first_image, &data, &size);
+	if (ret) {
+		log_err("Failed to get metadata DTB data\n");
+		return ret;
+	}
+
+	*metadata = malloc(size);
+	if (!*metadata) {
+		log_err("Failed to allocate memory for metadata DTB\n");
+		return -ENOMEM;
+	}
+
+	memcpy(*metadata, data, size);
+	*metadata_size = size;
+
+	log_info("Extracted metadata DTB: %zu bytes\n", size);
+
+	return 0;
+}
+
+/**
+ * qcom_count_compatible_matches() - Count matching tokens in compatible string
+ * @compatible: Compatible string from FIT configuration
+ * @compat_len: Length of compatible string
+ * @bucket_head: Bucket list head
+ *
+ * Parses the compatible string and counts how many tokens match entries
+ * in the bucket list. The compatible string format is typically:
+ * "vendor,device-variant-subtype" where tokens are separated by commas and dashes.
+ *
+ * Return: Number of matching tokens
+ */
+static int qcom_count_compatible_matches(const char *compatible, int compat_len,
+					 struct list_head *bucket_head)
+{
+	char *compat_copy;
+	char *str_ptr;
+	char *token;
+	int match_count = 0;
+
+	compat_copy = malloc(compat_len + 1);
+	if (!compat_copy)
+		return 0;
+
+	memcpy(compat_copy, compatible, compat_len);
+	compat_copy[compat_len] = '\0';
+
+	str_ptr = compat_copy;
+
+	/* First split by comma to get vendor prefix (e.g., "qcom") */
+	token = strsep(&str_ptr, ",");
+	if (token && search_in_bucket(token, bucket_head))
+		match_count++;
+
+	/* Then split remaining parts by dash */
+	token = strsep(&str_ptr, "-");
+	while (token) {
+		if (search_in_bucket(token, bucket_head))
+			match_count++;
+		token = strsep(&str_ptr, "-");
+	}
+
+	free(compat_copy);
+	return match_count;
+}
+
+/**
+ * qcom_find_matching_config() - Find matching FIT configuration
+ * @fit: FIT image pointer
+ * @bucket_head: Bucket list head
+ * @config_node: Pointer to store matching configuration node offset
+ *
+ * This function iterates through all FIT configurations and finds the one
+ * with the most matching tokens in its compatible string against the bucket list.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_find_matching_config(void *fit, struct list_head *bucket_head,
+				     int *config_node)
+{
+	int configs_node, cfg;
+	const char *compatible;
+	int compat_len;
+	const char *cfg_name;
+	int name_len;
+	int best_match_count = 0;
+	int best_config = -1;
+	int match_count;
+
+	configs_node = fdt_path_offset(fit, FIT_CONFS_PATH);
+	if (configs_node < 0) {
+		log_err("Cannot find /configurations node in FIT\n");
+		return configs_node;
+	}
+
+	fdt_for_each_subnode(cfg, fit, configs_node) {
+		cfg_name = fdt_get_name(fit, cfg, &name_len);
+		compatible = fdt_getprop(fit, cfg, PROP_COMPATIBLE, &compat_len);
+
+		if (!compatible || compat_len <= 0) {
+			log_debug("Config %s has no compatible property\n", cfg_name);
+			continue;
+		}
+
+		log_debug("Checking config: %s, compatible: %s\n",
+			  cfg_name, compatible);
+
+		match_count = qcom_count_compatible_matches(compatible, compat_len,
+							    bucket_head);
+
+		log_debug("Config %s: %d matches\n", cfg_name, match_count);
+
+		if (match_count > best_match_count) {
+			best_match_count = match_count;
+			best_config = cfg;
+		}
+	}
+
+	if (best_config < 0) {
+		log_err("No matching configuration found\n");
+		return -ENOENT;
+	}
+
+	cfg_name = fdt_get_name(fit, best_config, &name_len);
+	compatible = fdt_getprop(fit, best_config, PROP_COMPATIBLE, &compat_len);
+	log_info("Selected configuration: %s (compatible: %s, matches: %d)\n",
+		 cfg_name, compatible, best_match_count);
+
+	*config_node = best_config;
+	return 0;
+}
+
+/**
+ * qcom_get_fdt_image_data() - Get FDT image data from FIT
+ * @fit: FIT image pointer
+ * @images_node: Images node offset
+ * @fdt_name: FDT image name to load
+ * @fdt_datap: Pointer to store FDT data address
+ * @fdt_sizep: Pointer to store FDT data size
+ *
+ * Helper function to load an FDT image from the FIT by name.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_get_fdt_image_data(void *fit, int images_node,
+				   const char *fdt_name,
+				   const void **fdt_datap, size_t *fdt_sizep)
+{
+	int fdt_node;
+	int ret;
+
+	fdt_node = fdt_subnode_offset(fit, images_node, fdt_name);
+	if (fdt_node < 0) {
+		log_err("Cannot find FDT node: %s\n", fdt_name);
+		return fdt_node;
+	}
+
+	ret = fit_image_get_data(fit, fdt_node, fdt_datap, fdt_sizep);
+	if (ret) {
+		log_err("Failed to get FDT data for %s\n", fdt_name);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * qcom_load_dtb_with_overlays() - Load DTB and apply overlays
+ * @fit: FIT image pointer
+ * @config_node: Configuration node offset
+ * @final_dtb: Pointer to store final DTB address
+ * @final_dtb_size: Pointer to store final DTB size
+ *
+ * This function loads the base DTB and applies all DTBOs specified in the
+ * configuration's "fdt" property.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_load_dtb_with_overlays(void *fit, int config_node,
+				       void **final_dtb,
+				       size_t *final_dtb_size)
+{
+	int images_node;
+	const char *fdt_name;
+	int fdt_name_len;
+	const void *fdt_data;
+	size_t fdt_size;
+	void *base_dtb = NULL;
+	size_t base_dtb_size = 0;
+	phys_addr_t dtb_addr;
+	int i, ret;
+	int fixups_offset;
+
+	images_node = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images_node < 0)
+		return images_node;
+
+	fdt_name = fdt_stringlist_get(fit, config_node, PROP_FDT, 0, &fdt_name_len);
+	if (!fdt_name) {
+		log_err("No fdt property in configuration\n");
+		return -EINVAL;
+	}
+
+	printf("DTB: %s\n", fdt_name);
+
+	ret = qcom_get_fdt_image_data(fit, images_node, fdt_name,
+				      &fdt_data, &fdt_size);
+	if (ret)
+		return ret;
+
+	/* Allocate base DTB with extra space for overlays using LMB */
+	base_dtb_size = fdt_size + (8 * 1024); /* Add 8KB for overlays */
+	ret = lmb_alloc(base_dtb_size, &dtb_addr);
+	if (ret) {
+		log_err("Failed to allocate LMB memory for base DTB: %zu bytes\n", base_dtb_size);
+		return -ENOMEM;
+	}
+	base_dtb = (void *)dtb_addr;
+
+	memcpy(base_dtb, fdt_data, fdt_size);
+	ret = fdt_open_into(base_dtb, base_dtb, base_dtb_size);
+	if (ret) {
+		log_err("Failed to open DTB: %d\n", ret);
+		return ret;
+	}
+
+	/* Apply overlays (remaining fdt entries) */
+	for (i = 1; ; i++) {
+		fdt_name = fdt_stringlist_get(fit, config_node, PROP_FDT, i,
+					      &fdt_name_len);
+		if (!fdt_name)
+			break;
+
+		log_info("Applying overlay: %s\n", fdt_name);
+
+		ret = qcom_get_fdt_image_data(fit, images_node, fdt_name,
+					      &fdt_data, &fdt_size);
+		if (ret)
+			continue;
+
+		fixups_offset = fdt_path_offset(fdt_data, "/__fixups__");
+		if (fixups_offset == -FDT_ERR_NOTFOUND) {
+			log_warning("%s is not a valid overlay (no __fixups__)\n", fdt_name);
+			continue;
+		}
+
+		ret = fdt_overlay_apply_verbose(base_dtb, (void *)fdt_data);
+		if (ret)
+			log_err("Failed to apply overlay %s: %d\n", fdt_name, ret);
+	}
+
+	ret = fdt_pack(base_dtb);
+	if (ret) {
+		log_err("Failed to pack DTB: %d\n", ret);
+		return ret;
+	}
+
+	*final_dtb = base_dtb;
+	*final_dtb_size = fdt_totalsize(base_dtb);
+
+	log_info("Final DTB size: %zu bytes\n", *final_dtb_size);
+
+	return 0;
+}
+
+/**
+ * qcom_fit_multidtb_setup() - Main entry point for FIT multi-DTB selection
+ *
+ * This is the main function that orchestrates the entire DTB selection process:
+ * 1. Load qclinux_fit.img from EFI partition
+ * 2. Extract metadata DTB
+ * 3. Detect hardware parameters from SMEM
+ * 4. Build bucket list from metadata
+ * 5. Find matching FIT configuration
+ * 6. Load DTB and apply overlays
+ * 7. Install FDT for EFI
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qcom_fit_multidtb_setup(void)
+{
+	void *fit = NULL;
+	efi_uintn_t fit_size = 0;
+	void *metadata = NULL;
+	size_t metadata_size = 0;
+	struct qcom_hw_params hw_params;
+	LIST_HEAD(bucket_list);
+	int config_node;
+	void *final_dtb = NULL;
+	size_t final_dtb_size = 0;
+	int ret;
+
+	log_debug("=== FIT Multi-DTB Selection ===\n");
+
+	log_debug("Loading FIT image\n");
+	ret = qcom_load_fit_image(&fit, &fit_size);
+	if (ret) {
+		log_err("Failed to load FIT image\n");
+		goto cleanup_fit;
+	}
+
+	ret = fdt_check_header(fit);
+	if (ret) {
+		log_err("Invalid FIT header\n");
+		ret = -EINVAL;
+		goto cleanup_fit;
+	}
+
+	ret = fit_check_format(fit, IMAGE_SIZE_INVAL);
+	if (ret) {
+		log_err("Invalid FIT format\n");
+		ret = -EINVAL;
+		goto cleanup_fit;
+	}
+
+	log_debug("Extracting metadata DTB\n");
+	ret = qcom_extract_metadata_dtb(fit, &metadata, &metadata_size);
+	if (ret) {
+		log_err("Failed to extract metadata DTB\n");
+		goto cleanup_metadata;
+	}
+
+	log_debug("Detecting hardware parameters\n");
+	ret = qcom_detect_hardware_params(&hw_params);
+	if (ret) {
+		log_err("Failed to detect hardware parameters\n");
+		goto cleanup_metadata;
+	}
+
+	log_debug("Building bucket list\n");
+	ret = qcom_build_bucket_list(metadata, &hw_params, &bucket_list);
+	if (ret) {
+		log_err("Failed to build bucket list\n");
+		goto cleanup_bucket;
+	}
+
+	log_debug("Finding matching configuration\n");
+	ret = qcom_find_matching_config(fit, &bucket_list, &config_node);
+	if (ret) {
+		log_err("Failed to find matching configuration\n");
+		goto cleanup_bucket;
+	}
+
+	log_debug("Loading DTB and applying overlays\n");
+	ret = qcom_load_dtb_with_overlays(fit, config_node, &final_dtb,
+					  &final_dtb_size);
+	if (ret) {
+		log_err("Failed to load DTB with overlays\n");
+		goto cleanup_dtb;
+	}
+
+	log_debug("Setting fdt_addr to selected DTB address\n");
+
+	ret = fdt_check_header(final_dtb);
+	if (ret) {
+		log_err("Invalid final DTB header: %d\n", ret);
+		ret = -EINVAL;
+		goto cleanup_dtb;
+	}
+
+	/* Update fdt_addr environment variable to point to our DTB */
+	env_set_hex("fdt_addr", (ulong)final_dtb);
+	log_info("Updated fdt_addr=0x%lx, DTB size=%zu bytes\n", (ulong)final_dtb, final_dtb_size);
+	log_info("EFI boot flow will use DTB directly from this address\n");
+
+	/* Don't free final_dtb - LMB manages memory and EFI boot flow will use it */
+	final_dtb = NULL;
+
+	log_debug("=== FIT Multi-DTB Selection Complete ===\n");
+
+	ret = 0;
+	goto cleanup_success;
+
+cleanup_dtb:
+	if (ret && final_dtb)
+		final_dtb = NULL;
+
+cleanup_success:
+cleanup_bucket:
+	free_bucket_list(&bucket_list);
+
+cleanup_metadata:
+	if (metadata)
+		free(metadata);
+
+cleanup_fit:
+	if (fit)
+		efi_free_pages((uintptr_t)fit, efi_size_in_pages(fit_size));
+
+	return ret;
+}
diff --git a/arch/arm/mach-snapdragon/qcom_fit_multidtb.h b/arch/arm/mach-snapdragon/qcom_fit_multidtb.h
new file mode 100644
index 00000000000..b568d31777e
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom_fit_multidtb.h
@@ -0,0 +1,189 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm FIT Multi-DTB Selection
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * This implements automatic DTB selection from FIT images based on hardware
+ * detection via SMEM.
+ */
+
+#ifndef __QCOM_FIT_MULTIDTB_H__
+#define __QCOM_FIT_MULTIDTB_H__
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/sizes.h>
+
+/* DDR size thresholds */
+#define DDR_128MB      SZ_128M
+#define DDR_256MB      SZ_256M
+#define DDR_512MB      SZ_512M
+#define DDR_1024MB     SZ_1G
+#define DDR_2048MB     SZ_2G
+#define DDR_3072MB     (SZ_2G + SZ_1G)
+#define DDR_4096MB     SZ_4G
+
+/* DDR type enum */
+enum ddr_type {
+	DDRTYPE_256MB = 1,
+	DDRTYPE_512MB,		/* 2 */
+	DDRTYPE_1024MB,		/* 3 */
+	DDRTYPE_2048MB,		/* 4 */
+	DDRTYPE_3072MB,		/* 5 */
+	DDRTYPE_4096MB,		/* 6 */
+	DDRTYPE_128MB,		/* 7 */
+};
+
+/* Storage type enum */
+enum mem_card_type {
+	UFS = 0,
+	EMMC = 1,
+	NAND = 2,
+	STORAGE_UNKNOWN,
+};
+
+/* Boot device types from shared IMEM */
+enum boot_media_type {
+	NO_FLASH         = 0,
+	NOR_FLASH        = 1,
+	NAND_FLASH       = 2,
+	ONENAND_FLASH    = 3,
+	SDC_FLASH        = 4,
+	MMC_FLASH        = 5,
+	SPI_FLASH        = 6,
+	PCIE_FLASHLESS   = 7,
+	UFS_FLASH        = 8,
+	RESERVED_0_FLASH = 9,
+	RESERVED_1_FLASH = 10,
+	USB_FLASHLESS    = 11
+};
+
+/* Shared IMEM constants */
+#define BOOT_SHARED_IMEM_MAGIC_NUM    0xc1f8db40
+#define BOOT_SHARED_IMEM_VERSION_NUM  0x3
+
+/**
+ * struct qcom_imem_info - SoC-specific shared IMEM cookie address mapping
+ * @compatible: SoC compatible string (e.g., "qcom,qcs6490")
+ * @shared_imem_addr: Physical address of the boot shared IMEM cookie
+ *
+ * The shared IMEM cookie is populated by the bootloader and contains
+ * boot device type and other boot parameters. Its location varies per SoC
+ * and is calculated as: SCL_IMEM_BASE + IMEM_SIZE - 0x1000 (4KB cookie).
+ * Only SoCs with CONFIG_QCOM_FIT_MULTIDTB support are listed here.
+ */
+struct qcom_imem_info {
+	const char *compatible;
+	uintptr_t shared_imem_addr;
+};
+
+/*
+ * Per-SoC shared IMEM cookie address table.
+ * Address = SCL_IMEM_BASE(0x14680000) + IMEM_SIZE - 0x1000
+ *   QCM6490/QCS6490/QCS615: IMEM_SIZE=0x2B000 -> 0x146aa000
+ *   QCS9100:                IMEM_SIZE=0x59000 -> 0x146d8000
+ */
+static const struct qcom_imem_info qcom_imem_table[] = {
+	{ "qcom,qcm6490", 0x146aa000 },
+	{ "qcom,qcs6490", 0x146aa000 },
+	{ "qcom,qcs615",  0x146aa000 },
+	{ "qcom,qcs9100", 0x146d8000 },
+	{ }
+};
+
+/* Boot shared IMEM cookie structure */
+struct boot_imem_cookie {
+	u32 shared_imem_magic;
+	u32 shared_imem_version;
+	u64 etb_buf_addr;
+	u64 l2_cache_dump_buff_addr;
+	u32 a64_pointer_padding;
+	u32 uefi_ram_dump_magic;
+	u32 ddr_training_cookie;
+	u32 abnormal_reset_occurred;
+	u32 reset_status_register;
+	u32 rpm_sync_cookie;
+	u32 debug_config;
+	u64 boot_log_addr;
+	u32 boot_log_size;
+	u32 boot_fail_count;
+	u32 sbl1_error_type;
+	u32 uefi_image_magic;
+	u32 boot_device_type;
+	u64 boot_devtree_addr;
+	u64 boot_devtree_size;
+};
+
+/**
+ * struct qcom_hw_params - Hardware parameters detected from SMEM
+ * @chip_id: SoC chip ID (from socinfo->id)
+ * @chip_version: SoC version (from socinfo->plat_ver)
+ * @platform: Hardware platform ID (from socinfo->hw_plat)
+ * @subtype: Hardware platform subtype (from socinfo->hw_plat_subtype)
+ * @oem_variant_id: OEM variant ID (from socinfo->oem_variant)
+ * @ddr_size_type: DDR size type (0-10, calculated from RAM partitions)
+ * @storage_type: Storage type (UFS=1, EMMC=2, NAND=3)
+ * @foundry_id: Foundry ID (from socinfo->foundry_id)
+ * @softsku_id: Software SKU ID (if available)
+ *
+ * This structure holds all hardware parameters needed for DTB selection.
+ */
+struct qcom_hw_params {
+	u32 chip_id;
+	u32 chip_version;
+	u32 platform;
+	u32 board_version;
+	u32 subtype;
+	u32 oem_variant_id;
+	u32 ddr_size_type;
+	u32 storage_type;
+	u32 foundry_id;
+	u32 softsku_id;
+};
+
+/**
+ * struct bucket_node - Node in the bucket list
+ * @list: List head for linking nodes
+ * @name: Node name string (e.g., "qcom", "sa8775p-v2", "ride", "ufs", "8gb")
+ *
+ * The bucket list contains all matching node names from the metadata DTB.
+ * These are used to match against FIT configuration compatible strings.
+ */
+struct bucket_node {
+	struct list_head list;
+	char *name;
+};
+
+/* Node processing types for metadata DTB parsing */
+enum node_process_type {
+	NODE_TYPE_OEM,
+	NODE_TYPE_SOC,
+	NODE_TYPE_SOCVER,
+	NODE_TYPE_BOARD,
+	NODE_TYPE_BOARDREV,
+	NODE_TYPE_PERIPHERAL,
+	NODE_TYPE_STORAGE,
+	NODE_TYPE_DDR_SIZE,
+	NODE_TYPE_SOFTSKU,
+};
+
+/* Function prototypes */
+
+/**
+ * qcom_fit_multidtb_setup() - Main entry point for FIT multi-DTB selection
+ *
+ * This function:
+ * 1. Loads qclinux_fit.img from EFI partition
+ * 2. Extracts metadata DTB
+ * 3. Detects hardware parameters from SMEM
+ * 4. Builds bucket list from metadata
+ * 5. Finds matching FIT configuration
+ * 6. Loads DTB and applies overlays
+ * 7. Sets FDT for EFI
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qcom_fit_multidtb_setup(void);
+
+#endif /* __QCOM_FIT_MULTIDTB_H__ */
-- 
2.34.1

