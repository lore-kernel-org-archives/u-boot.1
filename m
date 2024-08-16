Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9979DC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 15:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BEF488C01;
	Fri, 16 Aug 2024 17:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WuFEu6US";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47C8D88BFC; Fri, 16 Aug 2024 17:47:57 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDDA688BDE
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 17:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a1dcba8142so251863085a.0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723823273; x=1724428073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKS8aI0ut0ARYtUzwOAb/abU1ODhRJZ/MxSoDAGoRnY=;
 b=WuFEu6USGR0edmodKLC5iqHpDxETCedj+PRZ30cTkGFNTGCAJ16HdRt1VpyAciUWjj
 U7rhP02Wa6wAJp1A74+dgLGqDE603QydXKkztNMinZyPtNdFd9vPGov2rn//AFq51kaI
 yTdalFkqlbjZGR58jK6HNC70o4ezMOkrZt5Hu5bxwIyxtTCxWYEV18LuBXk/gekh6sWT
 kf77YFtl28eqkI1v8i/ksWczAOtbpj+DLEolFuj0CbRw9OHP6WoT2Mhvyt7a95rNff/g
 kNaw96KvYeC5HIRNRU3hYEZOBSYQr/SmHU+sfBObrnbJrhcE9AQMGIeF2tWzkVWPnEBg
 rdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723823273; x=1724428073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KKS8aI0ut0ARYtUzwOAb/abU1ODhRJZ/MxSoDAGoRnY=;
 b=BIIfd6Vz/7NmNA5cdfMloCkvMHOsDMe3Fh0AR0PHqzcevQ0tsKIj3vSu1OqJ2HlAyv
 OMToDzfV8VjtRMMKZVibRyOYI+koN94fUZzQWxZ9cYjcFp+OEeZ2CxoSM7zhiKl2Ww5T
 7+EPZ0ZmBdBFQ+tqBZ/48Oc/xt3mDCwC1rlH+ZCqNoXCpGMVOpoMccVAMPPoZ5wKi07i
 wr5qpvIknNGZVGBaG2qfiZnKiZYyR+y1YdO7gOGc1ap+e7E0hR3eLNMWkgQ18yn9bNmF
 y4fTipx0Q5y+tGK6WaZpn4YaxRyiUuIEB8Dnp3CmTC9hfvXwDOVPMoStrBWTesQ5Jaix
 G8FA==
X-Gm-Message-State: AOJu0YyyO+ul9bIALZ8abSZwuxJZekcqtOcX/f4Om7bYC9qtIGUpD0az
 mQjwdkBW21y75mzAVv0sM76X/8LJaMX7+ACfpMMR4B+py3pIuslvxNH30y1HseV54fLB+YJvw/3
 OFa0=
X-Google-Smtp-Source: AGHT+IHqR/8DlrjKwxv+kAzwGwJ1rfNIwQVGJnXYYGkZbBjTfpEt+ngTiZMOMCCPQmI6CZ1krmyPhw==
X-Received: by 2002:a05:620a:2441:b0:79f:1352:8318 with SMTP id
 af79cd13be357-7a507473d53mr445160985a.4.1723823272648; 
 Fri, 16 Aug 2024 08:47:52 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff0e53d8sm187041185a.85.2024.08.16.08.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:47:52 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Stefan Roese <sr@denx.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Michal Simek <michal.simek@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 05/10] armv8: Add arch-specific sysinfo driver
Date: Fri, 16 Aug 2024 08:46:48 -0700
Message-Id: <20240816154658.1866186-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816154658.1866186-1-raymond.mao@linaro.org>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
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

Add common sysinfo driver for armv8 platforms containing all
necessary SMBIOS information (Type 1 to 4).

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 arch/arm/cpu/armv8/Makefile  |   5 +
 arch/arm/cpu/armv8/sysinfo.c | 203 +++++++++++++++++++++++++++++++++++
 2 files changed, 208 insertions(+)
 create mode 100644 arch/arm/cpu/armv8/sysinfo.c

diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index bba4f570dbb..374f20d455d 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -45,3 +45,8 @@ obj-$(CONFIG_TARGET_BCMNS3) += bcmns3/
 obj-$(CONFIG_XEN) += xen/
 obj-$(CONFIG_ARMV8_CE_SHA1) += sha1_ce_glue.o sha1_ce_core.o
 obj-$(CONFIG_ARMV8_CE_SHA256) += sha256_ce_glue.o sha256_ce_core.o
+
+ifndef CONFIG_SPL_BUILD
+obj-$(CONFIG_SYSINFO_SMBIOS) += sysinfo.o
+ccflags-$(CONFIG_SYSINFO_SMBIOS) += -I$(srctree)/drivers/sysinfo
+endif
\ No newline at end of file
diff --git a/arch/arm/cpu/armv8/sysinfo.c b/arch/arm/cpu/armv8/sysinfo.c
new file mode 100644
index 00000000000..a8e17d654be
--- /dev/null
+++ b/arch/arm/cpu/armv8/sysinfo.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#include <dm.h>
+#if CONFIG_IS_ENABLED(SYSINFO_SMBIOS)
+#include <smbios_plat.h>
+#endif
+#include <stdio.h>
+#include <sysinfo.h>
+
+#define ELEMENT_RECORD_DATA_LEN 8
+#define ELEMENT_RECORD_NUM 2
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
+struct __packed enclosure_element_record {
+	struct elem_hdr hdr;
+	u8 data[ELEMENT_RECORD_DATA_LEN];
+};
+
+struct processor_info processor_info_armv8;
+
+/* Default data for the enclosure contained elements */
+struct enclosure_element_record contained_elements[ELEMENT_RECORD_NUM] = {
+	{
+		.hdr.type = SMBIOS_BOARD_MOTHERBOARD,
+		.hdr.minimum = 0,
+		.hdr.maximum = 0xff,
+		.data = {0},
+	},
+	{
+		.hdr.type = SMBIOS_BOARD_MOTHERBOARD,
+		.hdr.minimum = 0,
+		.hdr.maximum = 0xff,
+		.data = {0},
+	},
+};
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
+	log_debug("MIDR: 0x%016llx\n", midr.data);
+	log_debug("MPIDR: 0x%016llx\n", mpidr);
+	log_debug("CPU Implementer: 0x%02x\n", midr.fields.implementer);
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
+	log_debug("CPU part number: 0x%x\n", midr.fields.partnum);
+	log_debug("CPU revision: 0x%x\n", midr.fields.revision);
+	log_debug("CPU architecture: 0x%x\n", midr.fields.architecture);
+	log_debug("CPU variant: 0x%x\n", midr.fields.variant);
+
+	pinfo->version = "Not Specified";
+
+	/* Extract number of cores */
+	core_count = (mpidr >> 0) & 0xFF;
+	pinfo->core_count = core_count + 1;
+	log_debug("CPU Core Count: %d\n", pinfo->core_count);
+
+	/* Other default processor information */
+	pinfo->type = SMBIOS_PROCESSOR_TYPE_CENTRAL;
+	pinfo->status = SMBIOS_PROCESSOR_STATUS_ENABLED;
+	pinfo->upgrade = SMBIOS_PROCESSOR_UPGRADE_NONE;
+	pinfo->family2 = SMBIOS_PROCESSOR_FAMILY_ARMV8;
+	pinfo->socket_design = "Not Specified";
+	pinfo->sn = "Not Specified";
+	pinfo->asset_tag = "Not Specified";
+	pinfo->pn = "Not Specified";
+	pinfo->core_enabled = pinfo->core_count;
+	pinfo->characteristics = SMBIOS_PROCESSOR_64BIT |
+		SMBIOS_PROCESSOR_ARM64_SOCID;
+	if (pinfo->core_count > 1)
+		pinfo->characteristics |= SMBIOS_PROCESSOR_MULTICORE;
+
+	return 0;
+}
+
+struct sysinfo_plat sysinfo_smbios_armv8 = {
+	/* System Information */
+	.sys.manufacturer = "arm",
+	.sys.prod_name = "arm",
+	.sys.version = "armv8",
+	.sys.sn = "Not Specified",
+	.sys.wakeup_type = SMBIOS_WAKEUP_TYPE_UNKNOWN,
+	.sys.sku_num = "Not Specified",
+	.sys.family = "arm",
+
+	/* Baseboard (or Module) Information */
+	.board.manufacturer = "arm",
+	.board.prod_name = "arm",
+	.board.version = "armv8",
+	.board.sn = "Not Specified",
+	.board.asset_tag = "Not Specified",
+	.board.feature.fields.hosting_board = 1, /* host board */
+	.board.chassis_locat = "Not Specified",
+	.board.type = SMBIOS_BOARD_MOTHERBOARD,
+
+	/* System Enclosure or Chassis Information */
+	.chassis.manufacturer = "arm",
+	.chassis.version = "armv8",
+	.chassis.sn = "Not Specified",
+	.chassis.asset_tag = "Not Specified",
+	.chassis.chassis_type = SMBIOS_ENCLOSURE_DESKTOP,
+	.chassis.bootup_state = SMBIOS_STATE_SAFE,
+	.chassis.power_supply_state = SMBIOS_STATE_SAFE,
+	.chassis.thermal_state = SMBIOS_STATE_SAFE,
+	.chassis.security_status = SMBIOS_SECURITY_NONE,
+	.chassis.oem_defined = SMBIOS_ENCLOSURE_OEM_UND,
+	.chassis.height = SMBIOS_ENCLOSURE_HEIGHT_UND,
+	.chassis.number_of_power_cords = SMBIOS_POWCORD_NUM_UND,
+	.chassis.element_count = ARRAY_SIZE(contained_elements),
+	.chassis.element_record_length = sizeof(contained_elements[0]),
+	.chassis.elements = &contained_elements[0],
+	.chassis.elements_size = sizeof(contained_elements),
+	.chassis.sku_num = "Not Specified",
+
+	/* Processor Information */
+	.processor = &processor_info_armv8,
+};
+
+U_BOOT_DRVINFO(sysinfo_smbios_plat) = {
+	.name = "sysinfo_smbios_plat",
+	.plat = &sysinfo_smbios_armv8,
+};
-- 
2.25.1

