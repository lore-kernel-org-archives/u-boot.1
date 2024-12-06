Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EE8E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 22:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00F3A88815;
	Fri,  6 Dec 2024 23:56:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xh5QNdv5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 361EB8870D; Fri,  6 Dec 2024 23:56:35 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2D5D88815
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 23:56:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-46684744070so24779451cf.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 14:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733525791; x=1734130591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9dVPNhcK14F0dg2tmjpO+O+DWZ588ltnGQ5/nwjH4/w=;
 b=Xh5QNdv5kwspQm7TGX6X1i09sFv8ab+KSntD0UruJcIZ8vvfzsR4BM0kw5aAMPCfpP
 h9LZ80v+cYCE5UVWvO9MXkcyoLI6htPSB7ecn95fvutd5+lH3qjmYJinQ71ICuZQTlfr
 RSRPWTYxqfbxXVeGbwyqoWIPaBCM8CtEQSqClHdYl08wI/3PlD0EnhNh+ZBHEhNEUHwW
 lMchYVYBKbbN5b28eKbNYVOo9KYVPLciwNsaSdu/z3Z1tkOuG6LTGRTp8kL/awsxbjea
 xkGzP3FtrnebrbFRDDbne+yI1mZ9qW6y8xY65yCWRMRH9zyAoXTtHzV/Y0GeQCUjOdgD
 QnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525791; x=1734130591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9dVPNhcK14F0dg2tmjpO+O+DWZ588ltnGQ5/nwjH4/w=;
 b=oSHbjSI9c9Yb3dD4J9CEXrBeXioDC/sxkHknpBVg1hGfF/DSVNw1YndnO2u9OibRo/
 7BQDevcjcg67N3DYG5FFMhyiPd4+vj4+pMFMQoeGzc9kttDXhP/Qvba23rHSm3aFtgss
 uBIJy0aXFGfhckxYRliSH9ieyUnEW2xDOWHQ/VDjzW2Qqg1Wdtf2FuZ7R1ez9Qg2lTUD
 Zr4cKOfobpfLdwBmfPGN1ACnfovVT5zMYyRyNf831kICw1jRva3gFuA6J1EOY+R2tKT6
 Yfez3uZ58cf/MNk7zBIyDgFwpRdP5MwapPIVNiPSylASOkvHVBkw93o+l4yHgtHSdT/N
 Tbww==
X-Gm-Message-State: AOJu0YwGTGWaqi6TzfAcqlXZalPKhFO2a2E7BeUDQD5zaG2EqQM39uqA
 5aa1rTLxq37ubXCyvCQwx5GAX4ICGaFd3aP9boTGOofY/OFlqiOGjndxwIdaVqGcfdUMit6XTdP
 g
X-Gm-Gg: ASbGncvCkkhuFtu/NuO1BdwZ0meS3aYNmZ97jxeoJ0wEYDMnWq7zbGw6lLVcx9aoUge
 ULRuWuXYDmJn9fa4QA/0K/J+ADMh0xaCgTUhvsifUDZ95Wbwk+XfclIXPVXC/PCIK+dxw3ygQIw
 LhBnVKn+McY/6GoBfcOn239F0cClgfAvD+uudxvovTv02fUy5jKtUqDxFkr5nEAlNHutlXIHBAv
 JXT7POCiOLQ1Z/238Oue28JOFUMrrwxeKhpTdbeBcZxlnus3YgiS8ryBPswoZefECy2wM0j8ohY
 Ff8uY5TrIXquPf1VwLs/cHexrPOQJFPv4vCmDWn4boIYtx4/
X-Google-Smtp-Source: AGHT+IHPTKAaL/o3j1pSPjKrgX7Co0La2SEHDQSx9cu3JVbSFyBDOA0CEc2iMoJ/xxaPs5fuEwgyNA==
X-Received: by 2002:ac8:7d91:0:b0:466:9d0e:1920 with SMTP id
 d75a77b69052e-46734cd37ccmr92303471cf.24.1733525791166; 
 Fri, 06 Dec 2024 14:56:31 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296d4d7dsm26080871cf.34.2024.12.06.14.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:56:29 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Alexander Gendin <agendin@matrox.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 07/10] armv8: Add arch-specific sysinfo platform driver
Date: Fri,  6 Dec 2024 14:54:24 -0800
Message-Id: <20241206225438.13866-8-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206225438.13866-1-raymond.mao@linaro.org>
References: <20241206225438.13866-1-raymond.mao@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2
- Combine with #8(v1) patch.
- Remove the handling of the common strings and values.
Changes in v3
- None.

 arch/arm/cpu/armv8/Makefile  |   2 +
 arch/arm/cpu/armv8/sysinfo.c | 292 +++++++++++++++++++++++++++++++++++
 2 files changed, 294 insertions(+)
 create mode 100644 arch/arm/cpu/armv8/sysinfo.c

diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index 2e71ff2dc97..b4126c61df1 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -46,3 +46,5 @@ obj-$(CONFIG_TARGET_BCMNS3) += bcmns3/
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

