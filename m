Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEE0CD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5083A84987;
	Thu,  4 Jun 2026 14:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lDXwn+r2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iprW0mp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C7778486D; Thu,  4 Jun 2026 11:33:35 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4EE984868
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 11:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548SAML313888
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 09:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=In9uhJt3cHI
 UHmd7q2wgq2ZUP+c+Ocu9gn5koTU4dvE=; b=lDXwn+r219KWRQUq3vTOR3U1kwi
 GL10nGRzOdniWNZvFEm/d3thnTC3xMGu5J6pLWjEEBxtd+5lpK/Odr0mq1E/gRSH
 XC34d2RS6urQFQhpnsaBgJGHv5fI/wI52QR5dZVjedZ9Yh/oFYkz6JO0eg6vVEE+
 l2GL8PubnA9AhvECsXBF/ucQXYedbk7cfKZQbZtaQTuQtDXfuyeOsR773yFGxwRF
 gpD4784rkCRnlTu4XsaRYlsjpgr8Jg5LBWtSf/E/euL7d8U2JgreL+PJKGv9bb4d
 LVjsGMLrHo6GWFhAubTKAYt++mhO68vxCRsKpisUlNQ/CTIr2DXTkjPyCKA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejy5v1phf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:33:31 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c85a2f19558so354626a12.2
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 02:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780565610; x=1781170410; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=In9uhJt3cHIUHmd7q2wgq2ZUP+c+Ocu9gn5koTU4dvE=;
 b=iprW0mp7Z62PAz3Y48VYgnChqCGno9lcgmmaroI5HdPLdP1kysTzivp7L7sj2GQdmn
 aihF1VoicruX2dAOOPxn3WIjgSbRLEzy4X8vIqAKCihXCa5r7shdx/FtAEQaqP4Dbiop
 Hq5VKHgnV4oIJo6mJBt9J0N8RItXjBpSjQWwjdPrRcO5OC1AFZMwLN3RJ6kyAcvzXw8S
 P1HiYYMS7n4anVn+5GCAU8/PUTFEXl/b+oICSa+OHDeMRQyXXlDSacoBOtTFw7XcwRHd
 jVCPgBfEjUlHL5s/F9hXEeUPj5CT7o3ojHfOkXwtUilQJNPTdO4kxtI1VExLlvNzh8H3
 HKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780565610; x=1781170410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=In9uhJt3cHIUHmd7q2wgq2ZUP+c+Ocu9gn5koTU4dvE=;
 b=T2FblCt1mg8NfEB5dnZERNo/Zl2NgjqjjO6aPDNrTjr9M/bckGFFm6LZjC87PlDZk+
 NKuvdvmPRqpZEdwaWyjP36B15yaonyNxpaM0l4RoR7HUX9ytNZJFA5Pcm9Lps5393aia
 Z3s0EndfVmJbBZi19d/rqIgIaKu4pJfFCUNz0db+JZntSeE+EWqDAZ/gXaTpZVYM0PVR
 czYSRB44TrNR8a0fwpJ9QsKDrsiojNXS6gRV4bsRE9ErZRkvfu3o3ABDcK0pMLr3qZc0
 a2ztngLvunHv5vQZu4pljSEzTEs4R8upw2SvcKN2h1OUC67vOrcLCWNu+Uyate89Z7GA
 fD/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/25Qt77Wc6xgmh5EBZv9ipb+tO5dyMd4G+7fwNeZPYh6UL9cks2+154BDagCzX5KA6FoHuoxY=@lists.denx.de
X-Gm-Message-State: AOJu0YzNYInOtJxP5hLyc2l2KMBmhRMAaIG3yTm20psh3EcjaDvp6svs
 pj9h9HA5UIWblVLSI1pMyTBiaaTCbBqusMotDCCgNYwKIzs5Ljt9d1YWC8kbQYZsu5dEy63mi6w
 ibEQQgK76w6RTgOYoUrFHpa+eKQpS+iN88FooI5T14mR/dbUvtdatzeUV
X-Gm-Gg: Acq92OF18vfIzi4qf5qm87mITQuqEKjFcs+tuCpJ/Po6bHVup/pLZzGk8eosP4rRiXt
 Q4s4ZVqqmATubVA5RVu5YxAXrVzUY/Bq8BHrW/joPqriOoWTXinh0SMyZHTfEWFqQNFECYfGMQ1
 NPOt4KK+l+RqtoqEtf2L+CvBkrCbLLDST4GIT4liHPrckJxJZsOlBLBh8RkxIXSj33GoFe7k5eG
 7ZI7RCptYye5SWPgoK3/BWspxKNkjpJmZBHKzsrTze8nsZ6+Hsj8YIDAXb6tCzRyVitQ6TzR+Um
 RgQvryElkMtqtiZieeqqvrinNrHXNI+LjPH3P0WUQAgmFnOmjAu3E28xm9sTcsK2+ioceblWYny
 bXFXELNetfjPkqeCuGxRr1ANVvsGPu3JOPlnL+y5OImwbXIdEo+ADBZv7uncvCALxaM4mzw33dz
 7lVOI1O3iQwr0fPWZyaNMhHmb/9+pF2TQq9ABBPkmWALHtMOawLI91DUpCsh8C4g==
X-Received: by 2002:a05:6a20:7484:b0:3a2:c683:fa84 with SMTP id
 adf61e73a8af0-3b49798aa4amr8708924637.27.1780565610046; 
 Thu, 04 Jun 2026 02:33:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:7484:b0:3a2:c683:fa84 with SMTP id
 adf61e73a8af0-3b49798aa4amr8708878637.27.1780565609408; 
 Thu, 04 Jun 2026 02:33:29 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0b9b3fsm4263552a12.28.2026.06.04.02.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:33:28 -0700 (PDT)
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
Subject: [PATCH v4 09/13] mach-snapdragon: Add initial support for IPQ5210 SPL
Date: Thu,  4 Jun 2026 15:01:28 +0530
Message-Id: <20260604093132.757583-10-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MSBTYWx0ZWRfX5rmRGs2UQU8r
 JSlNZFjNG4xdSUkBEPTRJ6VcK5O10V/6m0CSjhYxvrnZEyX/taU+ulv200YqAPFKI42Jv2rVl7Y
 wWGN3RrU64Rq89vXaKERz9m/LWAet0SxoP2fN5OmVrieXGPxoOyQLAQ+8TbuewD/fcLJGFaN8gX
 PMP5h4FIJcQKQIFiKDLB4g6JFr1oREDfPaMTlKV4A9MHC5YGHOEfO9oXUpxxTnk3r/wjy0BSREY
 Fw0kMLQO6Sud0nLe3mV8c61SUQZ1jN8eO16IEPKbaPKl+y1n/PaEPD5UqZk0rW4cPEwCbHjJUgt
 bjoz1idjCnopZrwgoVoEz5R+mJsK+YOEBgwuAAVkN2V8mHQeBZFt0lO9llw60tQcEV7aos/BPCt
 El2cukZey7Wd9Msj1mjNUJZ/Forv76XrHxGIhP6wPfNYKKRZ+AcmhhL6sssmgtiRlyNXi7sa8z9
 YHmhiw2d8Y+KIyIGrYA==
X-Proofpoint-ORIG-GUID: o1VvCNAcQncTZ4lfqyti3hnSdWWMXgNZ
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a21466b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=g-06fDLb7QCACo7HVOcA:9 a=O6mRQTBPUV7GYTyk:21
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: o1VvCNAcQncTZ4lfqyti3hnSdWWMXgNZ
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

Add basic SPL infrastructure for IPQ5210 SoC. This handles basic serial
console init, identifying the boot media, loading the additional
firmware binaries to setup DDR, TFA and eventually jump to U-Boot.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v4: Move MMU disable to save_boot_params()
    Get PBL shared info to U-Boot and identify boot medium
    Move maybe unused symbol inside #if IS_ENABLED(...)

v3: Move SMEM updates to separate patch
    Loop upto if_tbl->num_entries instead of MAX_ENTRIES
    Remove invalid 'if (!fit)' check
    Return failure if qclib_post_process_from_spl fails

v2: Remove couple of unused local variables
---
 arch/arm/Kconfig                  |   5 +-
 arch/arm/mach-snapdragon/Makefile |   3 +
 arch/arm/mach-snapdragon/spl.c    | 678 ++++++++++++++++++++++++++++++
 3 files changed, 684 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-snapdragon/spl.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 514bf2000b4..371916cf9b4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1147,12 +1147,13 @@ config ARCH_SNAPDRAGON
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
index 00000000000..73e8ca5d459
--- /dev/null
+++ b/arch/arm/mach-snapdragon/spl.c
@@ -0,0 +1,678 @@
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
+#include <atf_common.h>
+#include <linux/err.h>
+#include <dm/device-internal.h>
+#include <part.h>
+#include <blk.h>
+#include <dm/uclass.h>
+#include "qcom-priv.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define QCOM_SPL_TCSR_REG_ADDR		0x195c100
+#define QCOM_SPL_DLOAD_MASK		BIT(4)
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
+ * @fit:	 Pointer to the FIT image blob.
+ * @node:	 Node ID within the FIT image.
+ * @entry_point: Pointer to store the retrieved entry point.
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
+	uint uc_index;
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
+	for (uc_index = 0; uc_index < if_tbl->num_entries; uc_index++) {
+		if (!strcmp(if_tbl->if_table_entries[uc_index].entry_name, name)) {
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
+ * and finds the qcom-lib-1 node automatically.
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
+	 * Find "qcom-config-1" image node
+	 */
+	qcconfig_node = fdt_subnode_offset(fit, images_node, "qcom-config-1");
+	if (qcconfig_node < 0) {
+		pr_err("Failed to find qcom-config-1 node in FIT\n");
+		return -ENOENT;
+	}
+
+	/*
+	 * Find "qcom-lib-1" image node
+	 */
+	qclib_node = fdt_subnode_offset(fit, images_node, "qcom-lib-1");
+	if (qclib_node < 0) {
+		pr_err("Failed to find qcom-lib-1 node in FIT\n");
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
+		pr_err("Failed to get qcom-config-1 entry point (%d)\n", ret);
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
+	 * Get qcom-lib-1 entry point
+	 */
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit,
+					       qclib_node,
+					       &entry_point);
+	if (ret) {
+		pr_err("Failed to get qcom-lib-1 entry point (%d)\n", ret);
+		return ret;
+	}
+
+	qclib_entry = (qcom_spl_jump_img_entry_t)entry_point;
+
+	pr_info("Jumping to qcom-lib-1 at 0x%llx\n", entry_point);
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
+	return spl_get_load_buffer(0, sectors * bl_len);
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
+#if CONFIG_IS_ENABLED(MMC)
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
+static struct pbl_shared_data g_psd __section(".data");
+
+void save_boot_params(ulong r0, ulong r1, ulong r2, ulong r3)
+{
+	unsigned long sctlr;
+	struct pbl_shared_data *psd;
+
+	sctlr = get_sctlr();
+	set_sctlr(sctlr & ~(CR_M));	/* Disable MMU */
+
+	psd = (struct pbl_shared_data *)r0;
+
+	if (!psd || psd->num_of_entries < PBL_SHARED_DATA_PARAM_MAX)
+		goto out;
+
+	memcpy(&g_psd, psd, sizeof(g_psd));
+
+out:
+	save_boot_params_ret();
+}
+
+/**
+ * spl_boot_device() - Determine the boot device.
+ *
+ * Return: The mapped boot device type,
+ *	   or BOOT_DEVICE_NONE if the device is invalid.
+ */
+u32 spl_boot_device(void)
+{
+	struct pbl_shared_data *psd = &g_psd;
+
+#ifdef DEBUG
+	for (int i  = 0; psd && i < psd->num_of_entries; i++) {
+		printf("entry[0x%x] = %d 0x%08x %d\n", i,
+		       psd->entry[i].param_id, psd->entry[i].value,
+		       psd->entry[i].valid);
+	}
+#endif
+
+	if (psd->entry[PSD_ID_IS_EDL_MODE].valid &&
+	    psd->entry[PSD_ID_IS_EDL_MODE].value) {
+		printf("Selected boot device: DFU\n");
+		return BOOT_DEVICE_DFU;
+	}
+
+	if (psd->entry[PSD_ID_BOOT_MEDIA_TYPE].valid) {
+		switch (psd->entry[PSD_ID_BOOT_MEDIA_TYPE].value) {
+		case PSD_MMC_FLASH:
+			printf("Selected boot device: MMC\n");
+			return BOOT_DEVICE_MMC1;
+		case PSD_NOR_FLASH:
+			printf("Selected boot device: NOR\n");
+			return BOOT_DEVICE_NOR;
+		case PSD_NAND_FLASH:
+			printf("Selected boot device: NAND\n");
+			return BOOT_DEVICE_NAND;
+		case PSD_UFS_FLASH:
+			printf("Selected boot device: UFS\n");
+			return BOOT_DEVICE_UFS;
+		}
+	}
+
+	pr_err("No boot device configured\n");
+	return BOOT_DEVICE_NONE;
+}
+
+#if defined(CONFIG_SPL_BUILD)
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
+	ret = qclib_post_process_from_spl();
+	if (ret) {
+		pr_debug("qclib_post_process_from_spl() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	board_init_r(NULL, 0);
+
+fail:
+	if (ret)
+		qcom_spl_error_handler(NULL);
+}
+#endif /* CONFIG_SPL_BUILD */
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
+	/*
+	 * Empty placeholder for arch/arm/lib/reset.c:do_reset(),
+	 * to avoid "undefined reference to `reset_cpu'"
+	 */
+}
-- 
2.34.1

