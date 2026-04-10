Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C48FF44857
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 12:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 883E184214;
	Fri, 10 Apr 2026 14:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KrOdd0P7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BJBzpX3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5409784106; Fri, 10 Apr 2026 11:13:40 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A99E383DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 11:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A8w6UU115016
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xUqERPFh5Tk
 4l/IxhLnuBGctYlsiYvEj04kGUjEeUJ8=; b=KrOdd0P7e3mYf2r73VNOowiPnyQ
 KvGjhFTx2iT2twpN3AMcZRRTbFOr4dtIkXCC+ONtE7XsOo9Ad1TiOU8kem84V1pN
 gdVhttbkFVbGiweDU/eJ3V2LbVsNKg7+CpaY07HVkg8otv1DpvOm4fERQ6EJFo1X
 o1wgPtcF7fJ5gvcNKrk8aZMfqeNqjcBbvbpBiBEmCamdfTKJeRE9lZMef7kiro8F
 /bjd/O7Btdc0iI7h4H89QWl3axIGSKFAW7VUC4odhKaLz2ABiZ4olQo8p5sRJ32W
 NTCWcusJ1G8prero+jZDjQ2KlsWrKCPPJYJETnakmQGuRVRZyTZNA2jf9+Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dee8xb6d6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:13:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b256ed2cc8so18905385ad.3
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 02:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775812415; x=1776417215; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xUqERPFh5Tk4l/IxhLnuBGctYlsiYvEj04kGUjEeUJ8=;
 b=BJBzpX3VCgB6Y+HujUcKxqSDd3DXYpcFVAxDUIwkRqRydQE0ForsAFcI+2qflsoere
 shfqFAhZ0Yi6NCjWgAHlB2OjMsGRDAQoev9cbB9p5+5Pi6srFAqkU5Vj3D/+f8iBZ3gX
 rlvEh9SIXvZ9lFL/GfcRB/cL9RDtWWdFCXIA4dO7DnIDU6u7cGFx+a41XXoYMi6CKtCm
 W849GDQhyaiT+VCAYWjCgweO938ZSAf4jTmDXSyZIAvgUxmpFYVBnEqj7YuC6Lb0EVg/
 GGSZVhNdIlsTu0+UaLRkaDS2n+u3zMfW7s1pp8Z2cqUc5noSZPo7JCecDoYll2uz7raJ
 62vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775812415; x=1776417215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xUqERPFh5Tk4l/IxhLnuBGctYlsiYvEj04kGUjEeUJ8=;
 b=W9BBlN8iNG59fFPe+30RUf6ZZDZAlQBMNqpoNnrnPk802WVojHIckZwBNsI5Fajx1H
 E2M/fb2+UdjIevt4I+bfiwVmh3MXZf7LHBRTg22KKiOxQdZ+4d1vfPPcfT8V20Tc6iv9
 HlO2lwl25w0JU1HYxJOtfo2AFE2GsodOZl1z/nfs2IVcTQh5QJm4StQ9v9BpN4kjpeE/
 kWo0aEPu/A+8oF0gdc3NiDlDqST3uNanlq+VRVY1HWQAuCNKbFPdsbRL2NglnmoDLg7t
 c1z8NZubWMnz0fprQOB7QF38fUo9AeOn5+pUfumeCwwf2moMHqcNiy0FJexhG4TozSy+
 nvoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPHzGMsTF6cXJUy8t4v028qkp04TOAtlT2lclOh6GQ05+U3iJa0PltIQEmeDxnHGFFbQbyics=@lists.denx.de
X-Gm-Message-State: AOJu0YwDmoRt2lIzNNHos3jRouvT60HpN7aaz9FsZaoMKHLSiBGzJN+Y
 Y5xe7jY2dzG0Kf8bBqKximm4gTQklTVdbP+u5DhTGQYtbBxLkyLri2BwRvNnUeeQzC4kavLmuhr
 dkN7N1qWjyo+Nv0cCx3/BakF9el6+Vc7m/gbDKvkDgD0OB4t6AfEKA15d
X-Gm-Gg: AeBDietVYbx+L9FAdZ1xmn+i3f6l/0wYh8Q/Uf4CHuryDBYuB2+hyqokLdwuMcTrOht
 sJmpkNUiU1xIC+2r789mpNEXfwyMs+ge/zy6MFgBNZGasTrIOcZiL7PTwLCNW8KnIvIG27kJSAt
 UTOTOnha7RNrlTezJqKoQQgDgDnuYuwFGB3qO23BlACnrMKhiBA41OUjIJqRIfuFbZFqJS/6P4N
 eCru8OYDA7ncsSgGJwgCr5lS6QK4W0eJtjYkuSs0xwT5LmWPm1XGGq0Pw5bxZNIMgQqE267Lohk
 HXxI7+E+f6TMS8a4gfxXIIVwKKy5HWBDKmZsPq73aBqFxcVAi5HB9nq4+z+qV8wNT/Fko2qob/e
 nrdcR7odKcLVaAEuYS+K6I8h+SUvbnJy+JQNj3HhEguhi7z7UkW83j4tCCVkAKOQ3d5lAkDHANQ
 my4MiiIeFUe4IxDrx/Q+AMcuD2aOkCQlnq7Enq+ldJejsSU5835As=
X-Received: by 2002:a17:90b:2e8c:b0:35d:a3b4:2ef6 with SMTP id
 98e67ed59e1d1-35e4282eeecmr2568611a91.21.1775812414340; 
 Fri, 10 Apr 2026 02:13:34 -0700 (PDT)
X-Received: by 2002:a17:90b:2e8c:b0:35d:a3b4:2ef6 with SMTP id
 98e67ed59e1d1-35e4282eeecmr2568552a91.21.1775812413661; 
 Fri, 10 Apr 2026 02:13:33 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4123a29fsm2564871a91.8.2026.04.10.02.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:13:33 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, h-salunke@ti.com,
 alchark@gmail.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com,
 wens@kernel.org, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, alexeymin@postmarketos.org,
 james.hilliard1@gmail.com, michael@amarulasolutions.com,
 richard.genoud@bootlin.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 7/9] mach-snapdragon: Add initial support for IPQ5210 SPL
Date: Fri, 10 Apr 2026 14:41:52 +0530
Message-Id: <20260410091154.1001021-8-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MSBTYWx0ZWRfXz8JEBchHol1s
 gvhrWmo+CLyCRVJNSBQduhmkGa+0gp1CVWYtUzOFg3NCaSnDfd2cn0gUh+7d4JxZXkUSlIB9/fn
 nML0efWl23kVhARdQQl6jaCm+KLplnvT9wZvlfnrN4Qp9YdNUYGKmOj1XLrXdCup6tPlHTD8lkp
 NtW/G36B4P6OjqfV2WQsvNU+ssr+TcxqB8blavRlC+1mpNRHR1JW8p0x8JmHsTNX03seygkOrPS
 eKohUeFk4BO3ADdEntm6okYKI23WmHqV7enx3Km/T9NxT+UH/wrWeAmw0pUxknFwTT7OHEPtnuV
 Se2axlvD1AbO9PMM0rLx32XZOn5Dl21QWhkY9VspDW8RxJs0pD1wX3vbDCyOHKt/Q8CSs1Sv552
 66KlV3RoGIGHQcQNAsJ0MQkbOcoMgT3ktlmHIZnGyC/0OAVGi/Bg46JqqEK5u1SrepanmMd5Tpa
 jcaUieg2fA0WWdY/4bg==
X-Proofpoint-GUID: 5NBkkyQ0BLsd3iZmDkQPZv_iVyZ9M5sJ
X-Proofpoint-ORIG-GUID: 5NBkkyQ0BLsd3iZmDkQPZv_iVyZ9M5sJ
X-Authority-Analysis: v=2.4 cv=O7YJeh9W c=1 sm=1 tr=0 ts=69d8bf3f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=b2O72gnjNZcLiAo3fN4A:9 a=gKGqEOmO23dpcm9D:21
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100081
X-Mailman-Approved-At: Fri, 10 Apr 2026 14:54:22 +0200
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

Add basic SPL infrastructure for IPQ5210 SoC. This handles basic serial
console init, identifying the boot media, loading the additional
firmware binaries to setup DDR, TFA and eventually jump to U-Boot.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v2: Remove couple of unused local variables
---
 arch/arm/Kconfig                  |   5 +-
 arch/arm/mach-snapdragon/Makefile |   3 +
 arch/arm/mach-snapdragon/spl.c    | 701 ++++++++++++++++++++++++++++++
 include/smem.h                    |   3 +
 4 files changed, 710 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-snapdragon/spl.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 03416c55265..54fa4cb2dac 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1135,12 +1135,13 @@ config ARCH_SNAPDRAGON
 	select SPMI
 	select BOARD_LATE_INIT
 	select OF_BOARD
-	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
-	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
+	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL
+	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL
 	select SYSRESET
 	select SYSRESET_PSCI
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
 	select MMU_PGPROT
+	select SUPPORT_SPL
 	imply OF_UPSTREAM
 	imply CMD_DM
 	imply DM_USB_GADGET
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 343e825c6fd..70a2ce585f2 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -2,6 +2,9 @@
 #
 # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 
+ifndef CONFIG_XPL_BUILD
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
 obj-$(CONFIG_OF_LIVE) += of_fixup.o
+endif
+obj-$(CONFIG_SPL_BUILD) += spl.o
diff --git a/arch/arm/mach-snapdragon/spl.c b/arch/arm/mach-snapdragon/spl.c
new file mode 100644
index 00000000000..4c36ac5d5df
--- /dev/null
+++ b/arch/arm/mach-snapdragon/spl.c
@@ -0,0 +1,701 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <hang.h>
+#include <cpu_func.h>
+#include <init.h>
+#include <image.h>
+#include <spl.h>
+#include <spl_load.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/sections.h>
+#include <smem.h>
+#include <atf_common.h>
+#include <linux/err.h>
+#include <dm/device-internal.h>
+#include <part.h>
+#include <blk.h>
+#include <dm/uclass.h>
+
+#define QCOM_SPL_TCSR_REG_ADDR		0x195c100
+#define QCOM_SPL_DLOAD_MASK		GENMASK(4, 4)
+#define QCOM_SPL_DLOAD_SHFT		0x4
+
+#define QCOM_SPL_IS_DLOAD_BIT_SET	((readl(QCOM_SPL_TCSR_REG_ADDR) & \
+					QCOM_SPL_DLOAD_MASK) >> \
+					QCOM_SPL_DLOAD_SHFT)
+
+#define QCOM_SPL_FIT_IMG_PARTITION	"0:BOOTLDR"
+
+#define MAGIC_KEY			"QCLIB_CB"
+#define MAX_ENTRIES			0xF
+#define IF_TABLE_VERSION		0x1
+#define QCCONFIG			"qc_config"
+#define QCSDI				"qcsdi"
+
+/**
+ * struct interface_table_entry - Meta data for blobs in QCLIB interface
+ * @entry_name:	Name of the data blob (e.g., "dcb_settings").
+ * @address:	Address of the data blob.
+ * @size:	Size of the data blob.
+ * @attributes:	Attributes for the blob (e.g., save to storage).
+ */
+struct interface_table_entry {
+	char entry_name[24];
+	u64 address;
+	u32 size;
+	u32 attributes;
+};
+
+/**
+ * struct interface_table - QCLIB Interface table header
+ * @magic_key:		Magic key for validation ("QCLIB_CB").
+ * @version:		Interface table version.
+ * @num_entries:	Number of valid entries.
+ * @max_entries:	Maximum allowable entries.
+ * @global_attributes:	Flags for global attributes (e.g., SDI path).
+ * @reserved1:		Reserved for future use.
+ * @reserved2:		Reserved for future use.
+ * @if_table_entries:	Array of interface table entries.
+ */
+struct interface_table {
+	char magic_key[8];
+	u32 version;
+	u32 num_entries;
+	u32 max_entries;
+	u32 global_attributes;
+	u32 reserved1;
+	u32 reserved2;
+	struct interface_table_entry if_table_entries[MAX_ENTRIES];
+};
+
+/**
+ * qcom_spl_jump_img_entry_t - Type definition for image entry point functions.
+ * @arg1:	First argument passed to the entry point.
+ * @arg2:	Second argument passed to the entry point.
+ */
+typedef void (*qcom_spl_jump_img_entry_t)(void *arg1, void *arg2);
+
+/*
+ * Global QCSDI address populated by qclib_post_process_from_spl
+ * Placed in .data section to ensure it persists
+ */
+static u64 g_qcsdi_address __section(".data");
+
+/**
+ * lowlevel_init() - Early low-level initialization.
+ *
+ * This function performs very early hardware initialization,
+ * specifically disabling the MMU if enabled by PBL.
+ */
+void lowlevel_init(void)
+{
+	unsigned long sctlr;
+
+	sctlr = get_sctlr();
+	set_sctlr(sctlr & ~(CR_M));	/* Early disable the MMU */
+}
+
+/**
+ * qcom_spl_error_handler() - Centralized SPL error handler.
+ * @arg:	Generic argument (unused).
+ *
+ * This function is invoked upon critical errors during the SPL boot process.
+ */
+void qcom_spl_error_handler(void *arg)
+{
+	pr_err("Entered the SPL Error Handler\n");
+	hang();
+}
+
+/**
+ * qcom_spl_malloc_init_f() - Initialize malloc for SPL.
+ *
+ * This function initializes the malloc subsystem using the memory region
+ */
+void qcom_spl_malloc_init_f(void)
+{
+	if (!CONFIG_IS_ENABLED(SYS_MALLOC_F))
+		return;
+	/*
+	 * Set up by crt0.S
+	 */
+	assert(gd->malloc_base);
+	gd->malloc_limit = CONFIG_VAL(SYS_MALLOC_F_LEN);
+	gd->malloc_ptr = 0;
+
+	mem_malloc_init(gd->malloc_base, gd->malloc_limit);
+	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
+}
+
+/**
+ * qcom_spl_get_fit_img_entry_point() - Get entry point from FIT image node.
+ * @fit:	Pointer to the FIT image blob.
+ * @node:	Node ID within the FIT image.
+ * @entry_point:Pointer to store the retrieved entry point.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int qcom_spl_get_fit_img_entry_point(void *fit, int node,
+					    u64 *entry_point)
+{
+	int ret;
+
+	if (!fit) {
+		pr_err("FIT image blob is NULL\n");
+		return -EINVAL;
+	}
+	if (node <= 0) {
+		pr_err("Invalid FIT node ID %d\n", node);
+		return -EINVAL;
+	}
+	if (!entry_point) {
+		pr_err("Entry point pointer is NULL\n");
+		return -EINVAL;
+	}
+
+	ret = fit_image_get_entry(fit, node, (ulong *)entry_point);
+	if (ret) {
+		pr_debug("No entry point for node %d, trying load address\n",
+			 node);
+		ret = fit_image_get_load(fit, node, (ulong *)entry_point);
+		if (ret)
+			pr_err("No load address for node %d (%d)\n", node, ret);
+	}
+
+	return ret;
+}
+
+#if IS_ENABLED(CONFIG_SPL_SMEM)
+/**
+ * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
+ * @ctx:	Pointer to the global SPL context.
+ *
+ * This function initializes and populates various SMEM items with boot-related
+ * information, such as flash type, try-mode status, and ATF enable status.
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int qcom_spl_populate_smem(void *ctx)
+{
+	int ret;
+	size_t size;
+	struct udevice *smem;
+	u32 *fltype;
+
+	ret = uclass_get_device(UCLASS_SMEM, 0, &smem);
+	if (ret) {
+		pr_err("Failed to find SMEM node (%d)\n", ret);
+		return ret;
+	}
+
+	size = sizeof(u32);
+	ret = smem_alloc(smem, -1, SMEM_BOOT_FLASH_TYPE, size);
+	if (ret) {
+		pr_err("Failed to alloc item: SMEM_BOOT_FLASH_TYPE (%d)\n", ret);
+		return ret;
+	}
+
+	fltype = (u32 *)smem_get(smem, -1, SMEM_BOOT_FLASH_TYPE, &size);
+	if (!fltype) {
+		pr_err("Failed to get item: SMEM_BOOT_FLASH_TYPE\n");
+		return -ENOENT;
+	}
+
+	if (IS_ENABLED(CONFIG_SPL_MMC))
+		*fltype = SMEM_BOOT_MMC_FLASH;
+	return 0;
+}
+#endif /* IS_ENABLED(CONFIG_SPL_SMEM) */
+/**
+ * qcom_spl_get_iftbl_entry_by_name() - Get an interface table entry by name.
+ * @if_tbl:	Pointer to the QCLIB interface table.
+ * @name:	Name of the entry to find.
+ * @entry:	Pointer to a buffer where the found entry will be copied.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int qcom_spl_get_iftbl_entry_by_name(struct interface_table *if_tbl,
+					    char *name,
+					    struct interface_table_entry *entry)
+{
+	u8 uc_index;
+
+	if (!if_tbl) {
+		pr_err("Invalid interface table\n");
+		return -EINVAL;
+	}
+	if (!name) {
+		pr_err("Invalid name\n");
+		return -EINVAL;
+	}
+	if (!entry) {
+		pr_err("Invalid entry pointer\n");
+		return -EINVAL;
+	}
+
+	for (uc_index = 0; uc_index < MAX_ENTRIES; uc_index++) {
+		if (strcmp(if_tbl->if_table_entries[uc_index].entry_name,
+			   name) == 0) {
+			memcpy(entry,
+			       &if_tbl->if_table_entries[uc_index],
+			       sizeof(struct interface_table_entry));
+			return 0;
+		}
+	}
+	pr_err("Interface table entry '%s' not found\n", name);
+
+	return -ENOENT;
+}
+
+/**
+ * qclib_post_process_from_spl() - Post-process QCLIB image from SPL FIT address
+ *
+ * This function performs the same operations as qclib_post_process() but
+ * takes no arguments. It gets the FIT image from CONFIG_SPL_LOAD_FIT_ADDRESS
+ * and finds the qclib_1 node automatically.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qclib_post_process_from_spl(void)
+{
+	int ret;
+	int entry_idx;
+	int images_node;
+	int qcconfig_node;
+	int qclib_node;
+	const void *fit;
+	struct interface_table if_tbl;
+	struct interface_table_entry qcsdi_entry;
+	qcom_spl_jump_img_entry_t qclib_entry;
+	u64 entry_point;
+
+	/* Get FIT image from SPL load address */
+	fit = (const void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
+
+	if (!fit) {
+		pr_err("FIT image not found at CONFIG_SPL_LOAD_FIT_ADDRESS\n");
+		return -EINVAL;
+	}
+
+	pr_debug("QCLIB post-processing from SPL: fit=%p\n", fit);
+
+	/*
+	 * Find "images" node in FIT (get it once and reuse)
+	 */
+	images_node = fdt_subnode_offset(fit, 0, "images");
+	if (images_node < 0) {
+		pr_err("Failed to find images node in FIT\n");
+		return -ENOENT;
+	}
+
+	/*
+	 * Find "qcconfig_1" image node
+	 */
+	qcconfig_node = fdt_subnode_offset(fit, images_node, "qcconfig_1");
+	if (qcconfig_node < 0) {
+		pr_err("Failed to find qcconfig_1 node in FIT\n");
+		return -ENOENT;
+	}
+
+	/*
+	 * Find "qclib_1" image node
+	 */
+	qclib_node = fdt_subnode_offset(fit, images_node, "qclib_1");
+	if (qclib_node < 0) {
+		pr_err("Failed to find qclib_1 node in FIT\n");
+		return -ENOENT;
+	}
+
+	/*
+	 * Initialize the local interface table
+	 */
+	memset(&if_tbl, 0, sizeof(struct interface_table));
+	memcpy(if_tbl.magic_key, MAGIC_KEY, strlen(MAGIC_KEY));
+
+	if_tbl.version = IF_TABLE_VERSION;
+	if_tbl.num_entries = 0;
+	if_tbl.max_entries = MAX_ENTRIES;
+
+	/*
+	 * Add QCCONFIG entry to the interface table
+	 */
+	entry_idx = 0;
+	memcpy(if_tbl.if_table_entries[entry_idx].entry_name,
+	       QCCONFIG, strlen(QCCONFIG));
+
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit,
+					       qcconfig_node,
+					       &if_tbl.if_table_entries[entry_idx].address);
+	if (ret) {
+		pr_err("Failed to get qcconfig_1 entry point (%d)\n", ret);
+		return ret;
+	}
+	if_tbl.if_table_entries[entry_idx].attributes = 0;
+	if_tbl.num_entries = entry_idx + 1;
+
+	/*
+	 * Add QCSDI entry to the interface table
+	 */
+	entry_idx++;
+	memcpy(if_tbl.if_table_entries[entry_idx].entry_name,
+	       QCSDI, strlen(QCSDI));
+
+	if_tbl.if_table_entries[entry_idx].address = 0;
+	if_tbl.if_table_entries[entry_idx].attributes = 0;
+	if_tbl.num_entries = entry_idx + 1;
+
+	/*
+	 * Get qclib_1 entry point
+	 */
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit,
+					       qclib_node,
+					       &entry_point);
+	if (ret) {
+		pr_err("Failed to get qclib_1 entry point (%d)\n", ret);
+		return ret;
+	}
+
+	qclib_entry = (qcom_spl_jump_img_entry_t)entry_point;
+
+	pr_info("Jumping to qclib_1 at 0x%llx\n", entry_point);
+	qclib_entry(&if_tbl, NULL);
+
+	/* Parse the interface table to extract QCSDI address */
+	ret = qcom_spl_get_iftbl_entry_by_name(&if_tbl, QCSDI, &qcsdi_entry);
+	if (ret) {
+		pr_err("Failed to get QCSDI entry from interface table (%d)\n", ret);
+		return ret;
+	}
+
+	g_qcsdi_address = qcsdi_entry.address;
+	pr_info("QCSDI address: 0x%llx\n", g_qcsdi_address);
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_SPL_SMEM)
+/**
+ * spl_board_prepare_for_boot() - Prepare board for boot
+ *
+ * This function is called by SPL before jumping to the next stage.
+ * It populates SMEM during coldboot.
+ */
+void spl_board_prepare_for_boot(void)
+{
+	int ret;
+
+	/*
+	 * Populate SMEM in coldboot (Dload bit not set)
+	 */
+	if (!QCOM_SPL_IS_DLOAD_BIT_SET) {
+		printf("Populating SMEM\n");
+		ret = qcom_spl_populate_smem(NULL);
+		if (ret) {
+			pr_err("Failed to populate SMEM (%d)\n", ret);
+			qcom_spl_error_handler(NULL);
+		}
+	}
+}
+#endif /* IS_ENABLED(CONFIG_SPL_SMEM) */
+
+/**
+ * spl_get_load_buffer() - Allocate a cache-aligned buffer for image loading.
+ * @offset:	Offset (unused, typically 0 for SPL).
+ * @size:	Size of the buffer to allocate.
+ *
+ * Return: Pointer to the allocated buffer, or NULL on failure.
+ */
+struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
+{
+	return (void *)(CONFIG_SPL_LOAD_FIT_ADDRESS);
+}
+
+/**
+ * board_spl_fit_buffer_addr() - Get the address of the FIT image buffer.
+ * @fit_size:	Size of the FIT image.
+ * @sectors:	Number of sectors.
+ * @bl_len:	Block length.
+ *
+ * Return: Address of the FIT image buffer.
+ */
+void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
+{
+	void *buffer = spl_get_load_buffer(0, sectors * bl_len);
+
+	if (!buffer) {
+		pr_err("Failed to get FIT load buffer\n");
+		qcom_spl_error_handler(NULL);
+	}
+
+	return buffer;
+}
+
+/**
+ * bl2_plat_get_bl31_params_v2() - Retrieve and fixup BL31 parameters.
+ * @bl32_entry:	Entry point for BL32 (OP-TEE).
+ * @bl33_entry:	Entry point for BL33 (U-Boot/kernel).
+ * @fdt_addr:	Address of the Device Tree Blob (FDT).
+ *
+ * Return: Pointer to the populated BL31 parameters structure.
+ */
+struct bl_params *bl2_plat_get_bl31_params_v2(uintptr_t bl32_entry,
+					      uintptr_t bl33_entry,
+					      uintptr_t fdt_addr)
+{
+	struct bl_params *bl_params;
+	struct bl_params_node *node;
+
+	/*
+	 * Populate the bl31 params with default values.
+	 */
+	bl_params = bl2_plat_get_bl31_params_v2_default(bl32_entry, bl33_entry,
+							fdt_addr);
+
+	/*
+	 * Fixup the bl31 params based on platform requirements.
+	 */
+	for_each_bl_params_node(bl_params, node) {
+		if (node->image_id == ATF_BL31_IMAGE_ID) {
+			/*
+			 * Pass QCSDI address to BL31 via arg0
+			 * This address was populated by qclib_post_process()
+			 */
+			if (g_qcsdi_address == 0)
+				pr_warn("QCSDI address not set, BL31 may not function correctly\n");
+
+			node->ep_info->args.arg0 = g_qcsdi_address;
+			pr_debug("Setting BL31 arg0 to QCSDI address: 0x%llx\n", g_qcsdi_address);
+		}
+	}
+
+	return bl_params;
+}
+
+/**
+ * qcom_spl_loader_pre_ddr() - SPL loader for pre-DDR stage.
+ * @boot_device:Type of boot device.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int qcom_spl_loader_pre_ddr(u8 boot_device)
+{
+	struct spl_image_loader *loader, *drv;
+	struct spl_image_info spl_image = { 0 };
+	struct spl_boot_device boot_dev = { .boot_device = boot_device, };
+	int ret = -ENODEV, n_ents;
+
+	drv = ll_entry_start(struct spl_image_loader, spl_image_loader);
+	n_ents = ll_entry_count(struct spl_image_loader, spl_image_loader);
+
+	for (loader = drv; loader && (loader != drv + n_ents); loader++) {
+		if (boot_device != loader->boot_device)
+			continue;
+
+		ret = loader->load_image(&spl_image, &boot_dev);
+		if (!ret)
+			break;
+
+		printf("%s: Error: %d\n", __func__, ret);
+	}
+
+	return ret;
+}
+
+/**
+ * spl_find_partition_info() - Find partition information by name
+ * @uclass_id: Device class ID (UCLASS_MMC)
+ * @device_num: Device number within the class
+ * @part_name: Name of the partition to find
+ * @info: Pointer to store partition information
+ *
+ * This function provides partition lookup logic for MMC.
+ * Return: Partition number on success, negative error code on failure
+ */
+static int spl_find_partition_info(enum uclass_id uclass_id, int device_num,
+				   const char *part_name,
+				   struct disk_partition *info)
+{
+	int ret;
+	struct blk_desc *desc;
+
+	if (!part_name || !info) {
+		printf("Invalid parameters for partition lookup\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Get block device descriptor
+	 */
+	desc = blk_get_devnum_by_uclass_id(uclass_id, device_num);
+	if (!desc) {
+		printf("Block device not found for class %d, device %d\n",
+		       uclass_id, device_num);
+		return -ENODEV;
+	}
+
+	/*
+	 * Initialize partition table if needed
+	 */
+	if (desc->part_type == PART_TYPE_UNKNOWN) {
+		printf("Initializing partition table\n");
+		/*
+		 * Prefer EFI/GPT
+		 */
+		desc->part_type = PART_TYPE_EFI;
+	}
+
+	/*
+	 * Find partition by name
+	 */
+	ret = part_get_info_by_name(desc, part_name, info);
+	if (ret < 0) {
+		printf("Partition '%s' not found\n", part_name);
+		return -ENOENT;
+	}
+
+	printf("Found partition '%s' at partition number %d\n", part_name, ret);
+	return ret;
+}
+
+#if CONFIG_IS_ENABLED(MMC)
+/**
+ * spl_mmc_boot_mode() - Determine the boot mode for MMC
+ * @mmc:	Pointer to the MMC device
+ * @boot_device:	Boot device ID
+ *
+ * Return: MMCSD_MODE_RAW to use raw partition access
+ */
+u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
+{
+	return MMCSD_MODE_RAW;
+}
+
+/**
+ * spl_mmc_boot_partition() - Determine which partition to boot from
+ * @boot_device:	Boot device ID
+ *
+ * Return: Partition number to boot from, or default partition on error
+ */
+int spl_mmc_boot_partition(const u32 boot_device)
+{
+	int ret;
+	struct disk_partition info;
+
+	/*
+	 * Use common partition lookup function
+	 */
+	ret = spl_find_partition_info(UCLASS_MMC, 0, QCOM_SPL_FIT_IMG_PARTITION, &info);
+	if (ret < 0) {
+		printf("Using default MMC partition %d\n",
+		       CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION);
+		return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION;
+	}
+
+	return ret;
+}
+
+/**
+ * spl_mmc_get_uboot_raw_sector() - Find the raw sector offset
+ * @mmc:	Pointer to the MMC device
+ * @raw_sect:	Sector
+ *
+ * Return: 0 if the image is at the starting of the partition without any offset.
+ */
+unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc, ulong raw_sect)
+{
+	return 0;
+}
+#endif /* CONFIG_IS_ENABLED(MMC) */
+
+/**
+ * spl_boot_device() - Determine the boot device.
+ *
+ * Return: The mapped boot device type,
+ *	   or BOOT_DEVICE_NONE if the device is invalid.
+ */
+u32 spl_boot_device(void)
+{
+	if (IS_ENABLED(CONFIG_SPL_MMC)) {
+		printf("Selected boot device: MMC\n");
+		return BOOT_DEVICE_MMC1;
+	}
+
+	pr_err("No boot device configured\n");
+	return BOOT_DEVICE_NONE;
+}
+
+#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_SPL_FRAMEWORK_BOARD_INIT_F)
+/**
+ * board_init_f() - Main entry point for SPL.
+ * @dummy:	Dummy argument (unused).
+ */
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	memset(__bss_start, 0, __bss_end - __bss_start); /* Clear BSS */
+
+	qcom_spl_malloc_init_f();
+
+	ret = spl_early_init();
+	if (ret) {
+		pr_debug("spl_early_init() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	preloader_console_init();
+
+	ret = qcom_spl_loader_pre_ddr(spl_boot_device());
+	if (ret) {
+		pr_debug("qcom_spl_loader_pre_ddr() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	qclib_post_process_from_spl();
+
+	board_init_r(NULL, 0);
+
+fail:
+	if (ret)
+		qcom_spl_error_handler(NULL);
+}
+#endif /* CONFIG_SPL_BUILD && !defined(CONFIG_SPL_FRAMEWORK_BOARD_INIT_F) */
+
+int board_fit_config_name_match(const char *name)
+{
+	/*
+	 * SPL loads the pre-HLOS images from bootldr FIT image
+	 * as below
+	 *
+	 * In board_init_f() - Matches "pre-ddr" configuration node and
+	 * load the images mentioned in its <loadables>
+	 *
+	 * In board_init_r() - Matches "post-ddr" configuration node and
+	 * load the images mentioned in its <loadables>
+	 *
+	 */
+	if (!(gd->flags & GD_FLG_SPL_INIT)) {
+		if (!strcmp(name, "pre-ddr")) {
+			printf("Selected FIT Config: %s\n", name);
+			return 0;
+		}
+	} else {
+		if (!strcmp(name, "post-ddr")) {
+			printf("Selected FIT Config: %s\n", name);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+int board_fdt_blob_setup(void **fdtp)
+{
+	return 0;
+}
+
+void reset_cpu(void)
+{
+}
diff --git a/include/smem.h b/include/smem.h
index b19c534ebc4..f16ba7d63dc 100644
--- a/include/smem.h
+++ b/include/smem.h
@@ -87,4 +87,7 @@ void *smem_get(struct udevice *dev, unsigned int host, unsigned int item, size_t
  */
 int smem_get_free_space(struct udevice *dev, unsigned int host);
 
+#define SMEM_BOOT_FLASH_TYPE			498
+#define SMEM_BOOT_MMC_FLASH			5
+
 #endif /* _smem_h_ */
-- 
2.34.1

