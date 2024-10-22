Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB6ECDD0E1
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 20:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A4E588FE3;
	Tue, 22 Oct 2024 22:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zQO40Svw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4537891E9; Tue, 22 Oct 2024 22:07:25 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F97892B9
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 22:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cd7a2ed34bso33501076d6.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729627640; x=1730232440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6catIDMdrRtANtBvvtmI4SmXseS4+hKqlr4gmEAlu80=;
 b=zQO40SvwaueswnTdQTgQuTrlCszYky9Kfv28JrlSNFWXxam46tCrzMFQi2jCKRGy/x
 TkX1vSKVWBIwIYOdynBQvimBWkkjzNJwI4G1LRRRc9KSiXuEs63qudIejTKDjDDVjxUL
 LHa1/bUCJJO1RC6tOFvc6VB5TUf/l2YXWhZD8c/Fn3XAi6dr//P63KYrJKDoGfAqbeY9
 tmpmrdlmn4JuH0pJtOJT21QOf2I/0F1PyidHU1saEVg9CG9VlLcUgHsiIGpqkEEMEuNr
 PVkppigVaZX8HEyTjfOxmmfG3hVJOekidK/G9CM+J+XGm3+36JqypZy3tJBkvQf3MkqV
 sI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729627640; x=1730232440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6catIDMdrRtANtBvvtmI4SmXseS4+hKqlr4gmEAlu80=;
 b=F7+3yhatXj6xgFCQ3k4RxlVcjDk1HO6xlKZZMuaA1ur2JLSe15iHE0bnKROvmymHeo
 n+EVoDOlfA87NCO0LYfiZq3VH4cbKDJqij90Qhvu1nH0gY4lffADGkLT+dvADCKLnDNQ
 xOYZ8cMFUvidRnb4sBoq2z7ebl0JmO2aWqpLH9l4PX0zEUYS/+jaREuOcLoaVCX9FfCg
 i/vPhITi0w9VSWmleivsGVngv6FXdcwrqUawrkge36e2SaFgxqaCc2GkhNMQVLx1NHwE
 zdaG/lSjfUY+WQ3yWb3/2f+K3WBmFpbJf+BkZR/tW58Z0FWXjIYNMi4rhr95QuN6V5ua
 G73Q==
X-Gm-Message-State: AOJu0YwWn6i7INAgr5ONRU9g/63NcqMrDQwcm+wJY41jsw4MuTaoZN7d
 ZDtQK7wag106pIy1Tw3Fe8uzz2YsP5wZsX67A0q1jrSkYb2I4yow49JL6NbAtMIYv3gkUtVhyHI
 /eIE=
X-Google-Smtp-Source: AGHT+IH6bKPS8ExOEj4PPcZrWu1AgmnYHM6J8S9qOMx8Fn8Y4ceBHwGvBs1CVGENt1xI/qkGv0W9mQ==
X-Received: by 2002:a05:6214:4489:b0:6cb:4b70:8ead with SMTP id
 6a1803df08f44-6ce342864famr4466726d6.37.1729627640294; 
 Tue, 22 Oct 2024 13:07:20 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce0091a255sm32519956d6.59.2024.10.22.13.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 13:07:19 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: iwamatsu@nigauri.org, marek.vasut+renesas@mailbox.org,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 5/8] armv8: Add arch-specific sysinfo platform driver
Date: Tue, 22 Oct 2024 13:05:26 -0700
Message-Id: <20241022200543.116343-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022200543.116343-1-raymond.mao@linaro.org>
References: <20241022200543.116343-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add sysinfo platform driver for all armv8 platforms to retrieve
hardware information on processor and cache.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Combine with #8(v1) patch.
- Remove the handling of the common strings and values.

 arch/arm/cpu/armv8/Makefile  |   2 +
 arch/arm/cpu/armv8/sysinfo.c | 292 +++++++++++++++++++++++++++++++++++
 2 files changed, 294 insertions(+)
 create mode 100644 arch/arm/cpu/armv8/sysinfo.c

diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index bba4f570dbb..3eac8cd932b 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -45,3 +45,5 @@ obj-$(CONFIG_TARGET_BCMNS3) += bcmns3/
 obj-$(CONFIG_XEN) += xen/
 obj-$(CONFIG_ARMV8_CE_SHA1) += sha1_ce_glue.o sha1_ce_core.o
 obj-$(CONFIG_ARMV8_CE_SHA256) += sha256_ce_glue.o sha256_ce_core.o
+
+obj-$(CONFIG_SYSINFO_SMBIOS) += sysinfo.o
diff --git a/arch/arm/cpu/armv8/sysinfo.c b/arch/arm/cpu/armv8/sysinfo.c
new file mode 100644
index 00000000000..850142da37d
--- /dev/null
+++ b/arch/arm/cpu/armv8/sysinfo.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#include <dm.h>
+#include <smbios_plat.h>
+#include <stdio.h>
+#include <sysinfo.h>
+
+union ccsidr_el1 {
+	struct {
+		u64 linesize:3;
+		u64 associativity:10;
+		u64 numsets:15;
+		u64 unknown:4;
+		u64 reserved:32;
+	} no_ccidx;
+	struct {
+		u64 linesize:3;
+		u64 associativity:21;
+		u64 reserved1:8;
+		u64 numsets:24;
+		u64 reserved2:8;
+	} ccidx_aarch64;
+	struct {
+		u64 linesize:3;
+		u64 associativity:21;
+		u64 reserved:8;
+		u64 unallocated:32;
+	} ccidx_aarch32;
+	u64 data;
+};
+
+union midr_el1 {
+	struct {
+		u64 revision:4;
+		u64 partnum:12;
+		u64 architecture:4;
+		u64 variant:4;
+		u64 implementer:8;
+		u64 reserved:32;
+	} fields;
+	u64 data;
+};
+
+enum {
+	CACHE_NONE,
+	CACHE_INST_ONLY,
+	CACHE_DATA_ONLY,
+	CACHE_INST_WITH_DATA,
+	CACHE_UNIFIED,
+};
+
+enum {
+	CACHE_ASSOC_DIRECT_MAPPED = 1,
+	CACHE_ASSOC_2WAY = 2,
+	CACHE_ASSOC_4WAY = 4,
+	CACHE_ASSOC_8WAY = 8,
+	CACHE_ASSOC_16WAY = 16,
+	CACHE_ASSOC_12WAY = 12,
+	CACHE_ASSOC_24WAY = 24,
+	CACHE_ASSOC_32WAY = 32,
+	CACHE_ASSOC_48WAY = 48,
+	CACHE_ASSOC_64WAY = 64,
+	CACHE_ASSOC_20WAY = 20,
+};
+
+enum {
+	VENDOR_RESERVED = 0,
+	VENDOR_ARM = 0x41,
+	VENDOR_BROADCOM = 0x42,
+	VENDOR_CAVIUM = 0x43,
+	VENDOR_DEC = 0x44,
+	VENDOR_FUJITSU = 0x46,
+	VENDOR_INFINEON = 0x49,
+	VENDOR_FREESCALE = 0x4d,
+	VENDOR_NVIDIA = 0x4e,
+	VENDOR_AMCC = 0x50,
+	VENDOR_QUALCOMM = 0x51,
+	VENDOR_MARVELL = 0x56,
+	VENDOR_INTEL = 0x69,
+	VENDOR_AMPERE = 0xc0,
+};
+
+/*
+ * TODO:
+ * To support ARMv8.3, we need to read "CCIDX, bits [23:20]" from
+ * ID_AA64MMFR2_EL1 to get the format of CCSIDR_EL1:
+ *
+ * 0b0000 - 32-bit format implemented for all levels of the CCSIDR_EL1.
+ * 0b0001 - 64-bit format implemented for all levels of the CCSIDR_EL1.
+ *
+ * Here we assume to use CCSIDR_EL1 in no CCIDX layout:
+ * NumSets, bits [27:13]: (Number of sets in cache) - 1
+ * Associativity, bits [12:3]: (Associativity of cache) - 1
+ * LineSize, bits [2:0]: (Log2(Number of bytes in cache line)) - 4
+ */
+int sysinfo_get_cache_info(u8 level, struct cache_info *cinfo)
+{
+	u64 clidr_el1;
+	u32 csselr_el1;
+	u32 num_sets;
+	union ccsidr_el1 creg;
+	int cache_type;
+
+	sysinfo_cache_info_default(cinfo);
+
+	/* Read CLIDR_EL1 */
+	asm volatile("mrs %0, clidr_el1" : "=r" (clidr_el1));
+	debug("CLIDR_EL1: 0x%llx\n", clidr_el1);
+
+	cache_type = (clidr_el1 >> (3 * level)) & 0x7;
+	if (cache_type == CACHE_NONE) /* level does not exist */
+		return -1;
+
+	switch (cache_type) {
+	case CACHE_INST_ONLY:
+		cinfo->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_INST;
+		break;
+	case CACHE_DATA_ONLY:
+		cinfo->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_DATA;
+		break;
+	case CACHE_UNIFIED:
+		cinfo->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_UNIFIED;
+		break;
+	case CACHE_INST_WITH_DATA:
+		cinfo->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_OTHER;
+		break;
+	default:
+		cinfo->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_UNKNOWN;
+		break;
+	}
+
+	/* Select cache level */
+	csselr_el1 = (level << 1);
+	asm volatile("msr csselr_el1, %0" : : "r" (csselr_el1));
+
+	/* Read CCSIDR_EL1 */
+	asm volatile("mrs %0, ccsidr_el1" : "=r" (creg.data));
+	debug("CCSIDR_EL1 (Level %d): 0x%llx\n", level + 1, creg.data);
+
+	/* Extract cache size and associativity */
+	cinfo->line_size = 1 << (creg.no_ccidx.linesize + 4);
+
+	/* Map the associativity value */
+	switch (creg.no_ccidx.associativity + 1) {
+	case CACHE_ASSOC_DIRECT_MAPPED:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_DMAPPED;
+		break;
+	case CACHE_ASSOC_2WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_2WAY;
+		break;
+	case CACHE_ASSOC_4WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_4WAY;
+		break;
+	case CACHE_ASSOC_8WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_8WAY;
+		break;
+	case CACHE_ASSOC_16WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_16WAY;
+		break;
+	case CACHE_ASSOC_12WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_12WAY;
+		break;
+	case CACHE_ASSOC_24WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_24WAY;
+		break;
+	case CACHE_ASSOC_32WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_32WAY;
+		break;
+	case CACHE_ASSOC_48WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_48WAY;
+		break;
+	case CACHE_ASSOC_64WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_64WAY;
+		break;
+	case CACHE_ASSOC_20WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_20WAY;
+		break;
+	default:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_UNKNOWN;
+		break;
+	}
+
+	num_sets = creg.no_ccidx.numsets + 1;
+	/* Size in KB */
+	cinfo->max_size = (cinfo->associativity * num_sets * cinfo->line_size) /
+			  1024;
+
+	debug("L%d Cache:\n", level + 1);
+	debug("Number of bytes in cache line:%u\n", cinfo->line_size);
+	debug("Associativity of cache:%u\n", cinfo->associativity);
+	debug("Number of sets in cache:%u\n", num_sets);
+	debug("Cache size in KB:%u\n", cinfo->max_size);
+
+	cinfo->inst_size = cinfo->max_size;
+
+	/*
+	 * Below fields with common values are placed under DT smbios node
+	 * socket-design, config
+	 * Other fields are typically specific to the implementation of the ARM
+	 * processor by the silicon vendor:
+	 * supp_sram_type, curr_sram_type, speed, err_corr_type
+	 */
+
+	return 0;
+}
+
+int sysinfo_get_processor_info(struct processor_info *pinfo)
+{
+	u64 mpidr, core_count;
+	union midr_el1 midr;
+
+	/* Read the MIDR_EL1 register */
+	asm volatile("mrs %0, MIDR_EL1" : "=r"(midr.data));
+	/* Read the MPIDR_EL1 register */
+	asm volatile("mrs %0, MPIDR_EL1" : "=r"(mpidr));
+
+	debug("MIDR: 0x%016llx\n", midr.data);
+	debug("MPIDR: 0x%016llx\n", mpidr);
+	debug("CPU Implementer: 0x%02x\n", midr.fields.implementer);
+
+	switch (midr.fields.implementer) {
+	case VENDOR_ARM:
+		pinfo->manufacturer = "ARM Limited";
+		break;
+	case VENDOR_BROADCOM:
+		pinfo->manufacturer = "Broadcom Corporation";
+		break;
+	case VENDOR_CAVIUM:
+		pinfo->manufacturer = "Cavium Inc";
+		break;
+	case VENDOR_DEC:
+		pinfo->manufacturer = "Digital Equipment Corporation";
+		break;
+	case VENDOR_FUJITSU:
+		pinfo->manufacturer = "Fujitsu Ltd";
+		break;
+	case VENDOR_INFINEON:
+		pinfo->manufacturer = "Infineon Technologies AG";
+		break;
+	case VENDOR_FREESCALE:
+		pinfo->manufacturer = "Freescale Semiconductor Inc";
+		break;
+	case VENDOR_NVIDIA:
+		pinfo->manufacturer = "NVIDIA Corporation";
+		break;
+	case VENDOR_AMCC:
+		pinfo->manufacturer =
+			"Applied Micro Circuits Corporation";
+		break;
+	case VENDOR_QUALCOMM:
+		pinfo->manufacturer = "Qualcomm Inc";
+		break;
+	case VENDOR_MARVELL:
+		pinfo->manufacturer = "Marvell International Ltd";
+		break;
+	case VENDOR_INTEL:
+		pinfo->manufacturer = "Intel Corporation";
+		break;
+	case VENDOR_AMPERE:
+		pinfo->manufacturer = "Ampere Computing";
+		break;
+	default:
+		pinfo->manufacturer = "Unknown";
+		break;
+	}
+	debug("CPU part number: 0x%x\n", midr.fields.partnum);
+	debug("CPU revision: 0x%x\n", midr.fields.revision);
+	debug("CPU architecture: 0x%x\n", midr.fields.architecture);
+	debug("CPU variant: 0x%x\n", midr.fields.variant);
+
+	/* Extract number of cores */
+	core_count = (mpidr >> 0) & 0xFF;
+	pinfo->core_count = core_count + 1;
+	debug("CPU Core Count: %d\n", pinfo->core_count);
+
+	pinfo->core_enabled = pinfo->core_count;
+	pinfo->characteristics = SMBIOS_PROCESSOR_64BIT |
+		SMBIOS_PROCESSOR_ARM64_SOCID;
+	if (pinfo->core_count > 1)
+		pinfo->characteristics |= SMBIOS_PROCESSOR_MULTICORE;
+
+	/*
+	 * Below fields with common values are placed under DT smbios node
+	 * version, processor-type, processor-status, upgrade, family2,
+	 * socket-design, serial, asset-tag, part-number
+	 */
+
+	return 0;
+}
-- 
2.25.1

