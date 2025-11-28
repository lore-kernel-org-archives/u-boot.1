Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EA2D116F1
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A155583B4F;
	Fri, 28 Nov 2025 17:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mkxxWMDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3C9783B4F; Fri, 28 Nov 2025 17:36:18 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02C5983B5B
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-8b29ff9d18cso184569985a.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 08:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764347775; x=1764952575; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAf1a1bIpVzYORCKPM7g2yAR+Qjvkz1/wN0c7e0ezco=;
 b=mkxxWMDtiq87+x2xKiLyF4cJxgDRZq7Fxcqc9yH5MpQtWr2XcRd9qDdQNg8KfxJbFA
 x7vywlGECbTtxNVsiMK35W4SJZRP3bKN2GlJESb8iCw17pDqcXtm/9eZLxjg7eX8r9tA
 p71WhUcRlVFfc5CVG3JmQxlydlylDIcMj6XbRD9mXGlosB83iwJZKbrUq2yG9FF23BDo
 aRROT3SIaBpAVp7Xurpq+3AQT1Z13kNXyLuh3ogfkx0Cni8pYFUov+mY3YMS6bf2tHMw
 gZ/zpPYPQ+usXMhRIksyCTZQdeys9MZHRvXX8lPkHB5NrA5eC+NdRbWflRbmuTqCUPvM
 rmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764347775; x=1764952575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WAf1a1bIpVzYORCKPM7g2yAR+Qjvkz1/wN0c7e0ezco=;
 b=pHbxo9ftKBHaAw3InGkY1OTkGGJ8KR0RP2bg44CfPV6xTv4A1B3yg+uS34qRcZmU4h
 DP7Jf9I+2eR71gg6VV8fAX9qzVzbihsZrcTxhYYL/ti46NwTKksJex2cUds5O7zAT3na
 iI1jgz1tJTVa91U62ivfark5UcQmhMqpn+hmTgpZoITowwso0OJA04SC/orCxoVJ+qAZ
 ynSJUDqww86LDLOlim9wbNWBKaC6peZUDDgkJMRfn0HH80N8PJBSRGXqHM4Nux5ZOhJj
 PbByB5RGD/XhmJSvNNV1KZFZORPvfyn8GnYKh74T8gk8zS1HF7+PSB7AT2IU1DuGZyMM
 GbKw==
X-Gm-Message-State: AOJu0YypcyEGt7zF9qxgAY2vCL7oH2rVanqKfzX3PY0kWaiSO2l81lQ9
 5WUCx5TUYg5DK8PlzVe6pP5pZubVwWTtjyNay/yLDpvZuxI5o8zX1gShevarYAmTmLs=
X-Gm-Gg: ASbGncuLgdd95HubSg5KyVVMSTurX88ye+Z079iT9O1DVWP08JztUPf9rsvb9ld+ydC
 EX8AMCh6eM04jd8H7FpIe+8q5o6MpQRMZTHde6QQPGqCMyqNMa54GhxO9uUsALqpRB5Kuab8yxp
 5gmbn3PL70OUsc26UjSNjBxktwFp+GM9JUF1mElIgWLHhlvR6yJ+CuNsGPurpvE+cB/jlrDMtIp
 nt+VP3R0IzR3kLQXEXMcu92rFMkXedDjY9gHzmBv4LcMOSuyQmYKSMYcYSp5qk/vT9hpjVmhR71
 wXuh9RCtPTv0Paf4z2S94XnWYvBavvdQ3byXDKj+gaP5oCakvs/wh/JIz8q8grvtoN3ZlnRFFpt
 LZZsd0E364DbeuZ5RybFac44oQDNgmxL8l2pdHGYZ/J8V/NzDyZzp1L/MJZQtcBhnO7JUw6dPdy
 HwB6pKWMu5jOHSOOZyTcS39oM5h4VTJkw=
X-Google-Smtp-Source: AGHT+IGQGlM6C4hnZNJMEZmKCPIJZO+7XcaftdfTQAJUj1Fsc7fPlX1H69mIlVTEVDcfZUcwK0epXg==
X-Received: by 2002:a05:620a:25d1:b0:8b2:e87e:1097 with SMTP id
 af79cd13be357-8b33d46b1bbmr3517197685a.73.1764347773707; 
 Fri, 28 Nov 2025 08:36:13 -0800 (PST)
Received: from ubuntu.localdomain ([216.58.22.99])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1b75a9sm331227985a.25.2025.11.28.08.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 08:36:13 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>,
 Samuel Holland <samuel.holland@sifive.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v5 4/6] smbios: add support for dynamic generation of Type 17
 table
Date: Fri, 28 Nov 2025 08:35:21 -0800
Message-Id: <20251128163535.2301653-5-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128163535.2301653-1-raymondmaoca@gmail.com>
References: <20251128163535.2301653-1-raymondmaoca@gmail.com>
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

This commit implements SMBIOS Type 17 (Memory Device) generation with a
hybrid approach supporting both:

1. Explicit definition via Device Tree 'smbios' node:
   Child node under '/smbios/smbios/memory-device' will be used to
   populate as individual Type 17 structure directly.
   - Properties follow SMBIOS field names with lowercase letters and
     hyphen-separated words (e.g., 'physical-memory-array-handle',
     ' memory-error-information-handle', 'configured-memory-speed', etc.).
   - This method supports precise platform-defined overrides and system
     descriptions.

2. Fallback to automatic DT-based discovery:
   If child node under '/smbios/smbios/memory-device' does not exist,
   the implementation will:
   - Scan all top-level 'memory@' nodes to populate Type 17 structure with
     inferred size and location data.
   - Scan nodes named or marked as 'memory-controller' and parse
     associated 'dimm@' subnodes (if present) to extract DIMM sizes and
     map them accordingly.

This dual-mode support enables flexible firmware SMBIOS reporting while
aligning with spec-compliant naming and runtime-detected memory topology.

Type 17 support is under GENERATE_SMBIOS_TABLE_VERBOSE to avoid
increasing rom size for those platforms which only require basic SMBIOS
support.

Signed-off-by: Raymond Mao <raymondmaoca@gmail.com>
---
Changes in v4:
- Initial patch.
Changes in v5:
- None.

 arch/arm/dts/smbios_generic.dtsi |   3 +
 cmd/smbios.c                     | 126 +++++++++++
 include/smbios.h                 |  45 ++++
 include/smbios_def.h             | 127 +++++++++++
 lib/smbios.c                     | 377 +++++++++++++++++++++++++++++++
 5 files changed, 678 insertions(+)

diff --git a/arch/arm/dts/smbios_generic.dtsi b/arch/arm/dts/smbios_generic.dtsi
index 1a9adfaa409..fd2df8d02e0 100644
--- a/arch/arm/dts/smbios_generic.dtsi
+++ b/arch/arm/dts/smbios_generic.dtsi
@@ -83,6 +83,9 @@
 
 			memory-array {
 			};
+
+			memory-device {
+			};
 		};
 	};
 };
diff --git a/cmd/smbios.c b/cmd/smbios.c
index 3f7dd21f92e..39c9c44a28e 100644
--- a/cmd/smbios.c
+++ b/cmd/smbios.c
@@ -194,6 +194,74 @@ static const struct str_lookup_table ma_err_corr_strings[] = {
 	{ SMBIOS_MA_ERRCORR_CRC,	"CRC" },
 };
 
+static const struct str_lookup_table md_form_factor_strings[] = {
+	{ SMBIOS_MD_FF_OTHER,		"Other" },
+	{ SMBIOS_MD_FF_UNKNOWN,		"Unknown" },
+	{ SMBIOS_MD_FF_SIMM,		"SIMM" },
+	{ SMBIOS_MD_FF_SIP,		"SIP" },
+	{ SMBIOS_MD_FF_CHIP,		"Chip" },
+	{ SMBIOS_MD_FF_DIP,		"DIP" },
+	{ SMBIOS_MD_FF_ZIP,		"ZIP" },
+	{ SMBIOS_MD_FF_PROPCARD,	"Proprietary Card" },
+	{ SMBIOS_MD_FF_DIMM,		"DIMM" },
+	{ SMBIOS_MD_FF_TSOP,		"TSOP" },
+	{ SMBIOS_MD_FF_ROC,		"Row of chips" },
+	{ SMBIOS_MD_FF_RIMM,		"RIMM" },
+	{ SMBIOS_MD_FF_SODIMM,		"SODIMM" },
+	{ SMBIOS_MD_FF_SRIMM,		"SRIMM" },
+	{ SMBIOS_MD_FF_FBDIMM,		"FB-DIMM" },
+	{ SMBIOS_MD_FF_DIE,		"Die" },
+};
+
+static const struct str_lookup_table md_type_strings[] = {
+	{ SMBIOS_MD_TYPE_OTHER,		"Other" },
+	{ SMBIOS_MD_TYPE_UNKNOWN,	"Unknown" },
+	{ SMBIOS_MD_TYPE_DRAM,		"DRAM" },
+	{ SMBIOS_MD_TYPE_EDRAM,		"EDRAM" },
+	{ SMBIOS_MD_TYPE_VRAM,		"VRAM" },
+	{ SMBIOS_MD_TYPE_SRAM,		"SRAM" },
+	{ SMBIOS_MD_TYPE_RAM,		"RAM" },
+	{ SMBIOS_MD_TYPE_ROM,		"ROM" },
+	{ SMBIOS_MD_TYPE_FLASH,		"FLASH" },
+	{ SMBIOS_MD_TYPE_EEPROM,	"EEPROM" },
+	{ SMBIOS_MD_TYPE_FEPROM,	"FEPROM" },
+	{ SMBIOS_MD_TYPE_EPROM,		"EPROM" },
+	{ SMBIOS_MD_TYPE_CDRAM,		"CDRAM" },
+	{ SMBIOS_MD_TYPE_3DRAM,		"3DRAM" },
+	{ SMBIOS_MD_TYPE_SDRAM,		"SDRAM" },
+	{ SMBIOS_MD_TYPE_SGRAM,		"SGRAM" },
+	{ SMBIOS_MD_TYPE_RDRAM,		"RDRAM" },
+	{ SMBIOS_MD_TYPE_DDR,		"DDR" },
+	{ SMBIOS_MD_TYPE_DDR2,		"DDR2" },
+	{ SMBIOS_MD_TYPE_DDR2FBD,	"DDR2 FB-DIMM" },
+	{ SMBIOS_MD_TYPE_RSVD1,		"Reserved" },
+	{ SMBIOS_MD_TYPE_RSVD2,		"Reserved" },
+	{ SMBIOS_MD_TYPE_DSVD3,		"Reserved" },
+	{ SMBIOS_MD_TYPE_DDR3,		"DDR3" },
+	{ SMBIOS_MD_TYPE_FBD2,		"FBD2" },
+	{ SMBIOS_MD_TYPE_DDR4,		"DDR4" },
+	{ SMBIOS_MD_TYPE_LPDDR,		"LPDDR" },
+	{ SMBIOS_MD_TYPE_LPDDR2,	"LPDDR2" },
+	{ SMBIOS_MD_TYPE_LPDDR3,	"LPDDR3" },
+	{ SMBIOS_MD_TYPE_LPDDR4,	"LPDDR4" },
+	{ SMBIOS_MD_TYPE_LNVD,		"Logical non-volatile device" },
+	{ SMBIOS_MD_TYPE_HBM,		"HBM" },
+	{ SMBIOS_MD_TYPE_HBM2,		"HBM2" },
+	{ SMBIOS_MD_TYPE_DDR5,		"DDR5" },
+	{ SMBIOS_MD_TYPE_LPDDR5,	"LPDDR5" },
+	{ SMBIOS_MD_TYPE_HBM3,		"HBM3" },
+};
+
+static const struct str_lookup_table md_tech_strings[] = {
+	{ SMBIOS_MD_TECH_OTHER,		"Other" },
+	{ SMBIOS_MD_TECH_UNKNOWN,	"Unknown" },
+	{ SMBIOS_MD_TECH_DRAM,		"DRAM" },
+	{ SMBIOS_MD_TECH_NVDIMMN,	"NVDIMM-N" },
+	{ SMBIOS_MD_TECH_NVDIMMF,	"NVDIMM-F" },
+	{ SMBIOS_MD_TECH_NVDIMMP,	"NVDIMM-P" },
+	{ SMBIOS_MD_TECH_OPTANE,	"Intel Optane persistent memory" },
+};
+
 /**
  * smbios_get_string() - get SMBIOS string from table
  *
@@ -557,6 +625,61 @@ static void smbios_print_type16(struct smbios_type16 *table)
 	printf("\tExtended Maximum Capacity: 0x%016llx\n", table->ext_max_cap);
 }
 
+static void smbios_print_type17(struct smbios_type17 *table)
+{
+	printf("Memory Device:\n");
+	printf("\tPhysical Memory Array Handle: 0x%04x\n",
+	       table->phy_mem_array_hdl);
+	printf("\tMemory Error Information Handle: 0x%04x\n",
+	       table->mem_err_info_hdl);
+	printf("\tTotal Width: 0x%04x\n", table->total_width);
+	printf("\tData Width: 0x%04x\n", table->data_width);
+	printf("\tSize: 0x%04x\n", table->size);
+	smbios_print_lookup_str(md_form_factor_strings, table->form_factor,
+				ARRAY_SIZE(md_form_factor_strings),
+				"Form Factor");
+	printf("\tDevice Set: 0x%04x\n", table->dev_set);
+	smbios_print_str("Device Locator", table, table->dev_locator);
+	smbios_print_str("Bank Locator", table, table->bank_locator);
+	smbios_print_lookup_str(md_type_strings, table->mem_type,
+				ARRAY_SIZE(md_type_strings), "Memory Type");
+	printf("\tType Detail: 0x%04x\n", table->type_detail);
+	printf("\tSpeed: 0x%04x\n", table->speed);
+	smbios_print_str("Manufacturer", table, table->manufacturer);
+	smbios_print_str("Serial Number", table, table->serial_number);
+	smbios_print_str("Asset Tag", table, table->asset_tag);
+	smbios_print_str("Part Number", table, table->part_number);
+	printf("\tAttributes: 0x%04x\n", table->attributes);
+	printf("\tExtended Size: 0x%08x\n", table->ext_size);
+	printf("\tConfigured Memory Speed: 0x%04x\n", table->config_mem_speed);
+	printf("\tMinimum voltage: 0x%04x\n", table->min_voltage);
+	printf("\tMaximum voltage: 0x%04x\n", table->max_voltage);
+	printf("\tConfigured voltage: 0x%04x\n", table->config_voltage);
+	smbios_print_lookup_str(md_tech_strings, table->mem_tech,
+				ARRAY_SIZE(md_tech_strings),
+				"Memory Technology");
+	printf("\tMemory Operating Mode Capability: 0x%04x\n",
+	       table->mem_op_mode_cap);
+	smbios_print_str("Firmware Version", table, table->fw_ver);
+	printf("\tModule Manufacturer ID: 0x%04x\n", table->module_man_id);
+	printf("\tModule Product ID: 0x%04x\n", table->module_prod_id);
+	printf("\tMemory Subsystem Controller Manufacturer ID: 0x%04x\n",
+	       table->mem_subsys_con_man_id);
+	printf("\tMemory Subsystem Controller Product ID: 0x%04x\n",
+	       table->mem_subsys_con_prod_id);
+	printf("\tNon-volatile Size: 0x%016llx\n", table->nonvolatile_size);
+	printf("\tVolatile Size: 0x%016llx\n", table->volatile_size);
+	printf("\tCache Size: 0x%016llx\n", table->cache_size);
+	printf("\tLogical Size: 0x%016llx\n", table->logical_size);
+	printf("\tExtended Speed: 0x%04x\n", table->ext_speed);
+	printf("\tExtended Configured Memory Speed: 0x%04x\n",
+	       table->ext_config_mem_speed);
+	printf("\tPMIC0 Manufacturer ID: 0x%04x\n", table->pmic0_man_id);
+	printf("\tPMIC0 Revision Number: 0x%04x\n", table->pmic0_rev_num);
+	printf("\tRCD Manufacturer ID: 0x%04x\n", table->rcd_man_id);
+	printf("\tRCD Revision Number: 0x%04x\n", table->rcd_rev_num);
+}
+
 static void smbios_print_type127(struct smbios_type127 *table)
 {
 	printf("End Of Table\n");
@@ -642,6 +765,9 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
 		case SMBIOS_PHYS_MEMORY_ARRAY:
 			smbios_print_type16((struct smbios_type16 *)pos);
 			break;
+		case SMBIOS_MEMORY_DEVICE:
+			smbios_print_type17((struct smbios_type17 *)pos);
+			break;
 		case SMBIOS_END_OF_TABLE:
 			smbios_print_type127((struct smbios_type127 *)pos);
 			break;
diff --git a/include/smbios.h b/include/smbios.h
index 16438c059c7..45131416253 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -327,6 +327,51 @@ struct __packed smbios_type16 {
 	u64 ext_max_cap;
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
+
+struct __packed smbios_type17 {
+	struct smbios_header hdr;
+	u16 phy_mem_array_hdl;
+	u16 mem_err_info_hdl;
+	u32 total_width;
+	u32 data_width;
+	u16 size;
+	u8 form_factor;
+	u8 dev_set;
+	u8 dev_locator;
+	u8 bank_locator;
+	u8 mem_type;
+	u16 type_detail;
+	u16 speed;
+	u8 manufacturer;
+	u8 serial_number;
+	u8 asset_tag;
+	u8 part_number;
+	u8 attributes;
+	u32 ext_size;
+	u16 config_mem_speed;
+	u16 min_voltage;
+	u16 max_voltage;
+	u16 config_voltage;
+	u8 mem_tech;
+	u16 mem_op_mode_cap;
+	u8 fw_ver;
+	u16 module_man_id;
+	u16 module_prod_id;
+	u16 mem_subsys_con_man_id;
+	u16 mem_subsys_con_prod_id;
+	u64 nonvolatile_size;
+	u64 volatile_size;
+	u64 cache_size;
+	u64 logical_size;
+	u32 ext_speed;
+	u32 ext_config_mem_speed;
+	u16 pmic0_man_id;
+	u16 pmic0_rev_num;
+	u16 rcd_man_id;
+	u16 rcd_rev_num;
+	char eos[SMBIOS_STRUCT_EOS_BYTES];
+};
+
 struct __packed smbios_type32 {
 	u8 type;
 	u8 length;
diff --git a/include/smbios_def.h b/include/smbios_def.h
index c6850a5d6f5..ce913f2f32a 100644
--- a/include/smbios_def.h
+++ b/include/smbios_def.h
@@ -309,4 +309,131 @@
 #define SMBIOS_MA_ERRINFO_NONE		0xFFFE
 #define SMBIOS_MA_ERRINFO_NOERR		0xFFFF
 
+/* Memory Device */
+
+/* Size */
+
+#define SMBIOS_MD_SIZE_UNKNOWN	0xFFFF
+#define SMBIOS_MD_SIZE_EXT	0x7FFF
+
+/* Form Factor */
+#define SMBIOS_MD_FF_OTHER	1
+#define SMBIOS_MD_FF_UNKNOWN	2
+#define SMBIOS_MD_FF_SIMM	3
+#define SMBIOS_MD_FF_SIP	4
+#define SMBIOS_MD_FF_CHIP	5
+#define SMBIOS_MD_FF_DIP	6
+#define SMBIOS_MD_FF_ZIP	7
+#define SMBIOS_MD_FF_PROPCARD	8
+#define SMBIOS_MD_FF_DIMM	9
+#define SMBIOS_MD_FF_TSOP	10
+#define SMBIOS_MD_FF_ROC	11
+#define SMBIOS_MD_FF_RIMM	12
+#define SMBIOS_MD_FF_SODIMM	13
+#define SMBIOS_MD_FF_SRIMM	14
+#define SMBIOS_MD_FF_FBDIMM	15
+#define SMBIOS_MD_FF_DIE	16
+
+/* Device set */
+#define SMBIOS_MD_DEVSET_NONE		0
+#define SMBIOS_MD_DEVSET_UNKNOWN	0xFF
+
+/* Speed */
+#define SMBIOS_MD_SPEED_UNKNOWN	0
+#define SMBIOS_MD_SPEED_EXT	0xFFFF
+
+/* Attributes */
+#define SMBIOS_MD_ATTR_RANK_UNKNOWN	0
+
+/* Configured Memory Speed */
+#define SMBIOS_MD_CONFSPEED_UNKNOWN	0
+#define SMBIOS_MD_CONFSPEED_EXT		0xFFFF
+
+/* Voltage */
+#define SMBIOS_MD_VOLTAGE_UNKNOWN	0
+
+/* Type */
+#define SMBIOS_MD_TYPE_OTHER	1
+#define SMBIOS_MD_TYPE_UNKNOWN	2
+#define SMBIOS_MD_TYPE_DRAM	3
+#define SMBIOS_MD_TYPE_EDRAM	4
+#define SMBIOS_MD_TYPE_VRAM	5
+#define SMBIOS_MD_TYPE_SRAM	6
+#define SMBIOS_MD_TYPE_RAM	7
+#define SMBIOS_MD_TYPE_ROM	8
+#define SMBIOS_MD_TYPE_FLASH	9
+#define SMBIOS_MD_TYPE_EEPROM	10
+#define SMBIOS_MD_TYPE_FEPROM	11
+#define SMBIOS_MD_TYPE_EPROM	12
+#define SMBIOS_MD_TYPE_CDRAM	13
+#define SMBIOS_MD_TYPE_3DRAM	14
+#define SMBIOS_MD_TYPE_SDRAM	15
+#define SMBIOS_MD_TYPE_SGRAM	16
+#define SMBIOS_MD_TYPE_RDRAM	17
+#define SMBIOS_MD_TYPE_DDR	18
+#define SMBIOS_MD_TYPE_DDR2	19
+#define SMBIOS_MD_TYPE_DDR2FBD	20
+#define SMBIOS_MD_TYPE_RSVD1	21
+#define SMBIOS_MD_TYPE_RSVD2	22
+#define SMBIOS_MD_TYPE_DSVD3	23
+#define SMBIOS_MD_TYPE_DDR3	24
+#define SMBIOS_MD_TYPE_FBD2	25
+#define SMBIOS_MD_TYPE_DDR4	26
+#define SMBIOS_MD_TYPE_LPDDR	27
+#define SMBIOS_MD_TYPE_LPDDR2	28
+#define SMBIOS_MD_TYPE_LPDDR3	29
+#define SMBIOS_MD_TYPE_LPDDR4	30
+#define SMBIOS_MD_TYPE_LNVD	31
+#define SMBIOS_MD_TYPE_HBM	32
+#define SMBIOS_MD_TYPE_HBM2	33
+#define SMBIOS_MD_TYPE_DDR5	34
+#define SMBIOS_MD_TYPE_LPDDR5	35
+#define SMBIOS_MD_TYPE_HBM3	36
+
+/* Type Detail */
+#define SMBIOS_MD_TD_RSVD	1 /* BIT(0), set to 0 */
+#define SMBIOS_MD_TD_OTHER	2 /* BIT(1) */
+#define SMBIOS_MD_TD_UNKNOWN	4 /* BIT(2) */
+#define SMBIOS_MD_TD_FP		8 /* BIT(3) */
+#define SMBIOS_MD_TD_SC		0x10 /* BIT(4) */
+#define SMBIOS_MD_TD_PS		0x20 /* BIT(5) */
+#define SMBIOS_MD_TD_RAMBUS	0x40 /* BIT(6) */
+#define SMBIOS_MD_TD_SYNC	0x80 /* BIT(7) */
+#define SMBIOS_MD_TD_CMOS	0x100 /* BIT(8) */
+#define SMBIOS_MD_TD_EDO	0x200 /* BIT(9) */
+#define SMBIOS_MD_TD_WINDRAM	0x400 /* BIT(10) */
+#define SMBIOS_MD_TD_CACHEDRAM	0x800 /* BIT(11) */
+#define SMBIOS_MD_TD_NV		0x1000 /* BIT(12) */
+#define SMBIOS_MD_TD_RGSTD	0x2000 /* BIT(13) */
+#define SMBIOS_MD_TD_UNRGSTD	0x4000 /* BIT(14) */
+#define SMBIOS_MD_TD_LRDIMM	0x8000 /* BIT(15) */
+
+/* Technology */
+#define SMBIOS_MD_TECH_OTHER	1
+#define SMBIOS_MD_TECH_UNKNOWN	2
+#define SMBIOS_MD_TECH_DRAM	3
+#define SMBIOS_MD_TECH_NVDIMMN	4
+#define SMBIOS_MD_TECH_NVDIMMF	5
+#define SMBIOS_MD_TECH_NVDIMMP	6
+#define SMBIOS_MD_TECH_OPTANE	7
+
+/* Operating Mode Capability */
+#define SMBIOS_MD_OPMC_RSVD	1 /* BIT(0), set to 0 */
+#define SMBIOS_MD_OPMC_OTHER	2 /* BIT(1) */
+#define SMBIOS_MD_OPMC_UNKNOWN	4 /* BIT(2) */
+#define SMBIOS_MD_OPMC_VM	8 /* BIT(3) */
+#define SMBIOS_MD_OPMC_BYTEAPM	0x10 /* BIT(4) */
+#define SMBIOS_MD_OPMC_BLKAPM	0x20 /* BIT(5) */
+/* Bit 6:15 Reserved, set to 0 */
+
+/* Non-volatile / Volatile / Cache / Logical portion Size */
+#define SMBIOS_MD_PORT_SIZE_NONE	0
+#define SMBIOS_MD_PORT_SIZE_UNKNOWN_HI	0xFFFFFFFF
+#define SMBIOS_MD_PORT_SIZE_UNKNOWN_LO	0xFFFFFFFF
+#define SMBIOS_MS_PORT_SIZE_UNKNOWN	0xFFFFFFFFFFFFFFFF
+
+/* Error Information Handle */
+#define SMBIOS_MD_ERRINFO_NONE		0xFFFE
+#define SMBIOS_MD_ERRINFO_NOERR		0xFFFF
+
 #endif /* _SMBIOS_DEF_H_ */
diff --git a/lib/smbios.c b/lib/smbios.c
index 27c9c975cf2..8a3fa42cef5 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -135,6 +135,14 @@ typedef int (*smbios_write_subnode)(ulong *current, int handle,
 				   struct smbios_ctx *ctx, int idx,
 				   int type);
 
+typedef int (*smbios_write_memnode)(ulong *current, int handle,
+				    struct smbios_ctx *ctx, int idx,
+				    int type);
+
+typedef int (*smbios_write_memctrlnode)(ulong *current, int handle,
+				      struct smbios_ctx *ctx, int idx,
+				      u64 base, u64 sz);
+
 /**
  * Function prototype to write a specific type of SMBIOS structure
  *
@@ -1432,6 +1440,374 @@ static int smbios_write_type16(ulong *current, int *handle,
 	return len;
 }
 
+static void smbios_pop_type17_general_si(struct smbios_ctx *ctx,
+					 struct smbios_type17 *t)
+{
+	t->mem_err_info_hdl =
+		smbios_get_val_si(ctx, "memory-error-information-handle",
+				  SYSID_NONE, SMBIOS_MD_ERRINFO_NONE);
+	t->total_width = smbios_get_val_si(ctx, "total-width", SYSID_NONE, 0);
+	t->data_width = smbios_get_val_si(ctx, "data-width", SYSID_NONE, 0);
+	t->form_factor = smbios_get_val_si(ctx, "form-factor",
+					   SYSID_NONE, SMBIOS_MD_FF_UNKNOWN);
+	t->dev_set = smbios_get_val_si(ctx, "device-set", SYSID_NONE,
+				       SMBIOS_MD_DEVSET_UNKNOWN);
+	t->data_width = smbios_get_val_si(ctx, "data-width", SYSID_NONE, 0);
+	t->dev_locator = smbios_add_prop_si(ctx, "device-locator", SYSID_NONE,
+					    NULL);
+	t->bank_locator = smbios_add_prop_si(ctx, "bank-locator", SYSID_NONE,
+					     NULL);
+	t->mem_type = smbios_get_val_si(ctx, "memory-type",
+					SYSID_NONE, SMBIOS_MD_TYPE_UNKNOWN);
+	t->type_detail = smbios_get_val_si(ctx, "type-detail",
+					   SYSID_NONE, SMBIOS_MD_TD_UNKNOWN);
+	t->speed = smbios_get_val_si(ctx, "speed", SYSID_NONE,
+				     SMBIOS_MD_SPEED_UNKNOWN);
+	t->manufacturer = smbios_add_prop_si(ctx, "manufacturer", SYSID_NONE,
+					     NULL);
+	t->serial_number = smbios_add_prop_si(ctx, "serial-number", SYSID_NONE,
+					      NULL);
+	t->asset_tag = smbios_add_prop_si(ctx, "asset-tag", SYSID_NONE, NULL);
+	t->part_number = smbios_add_prop_si(ctx, "part-number", SYSID_NONE,
+					    NULL);
+	t->attributes = smbios_get_val_si(ctx, "attributes", SYSID_NONE,
+					  SMBIOS_MD_ATTR_RANK_UNKNOWN);
+	t->config_mem_speed = smbios_get_val_si(ctx, "configured-memory-speed",
+						SYSID_NONE,
+						SMBIOS_MD_CONFSPEED_UNKNOWN);
+	t->min_voltage = smbios_get_val_si(ctx, "minimum-voltage", SYSID_NONE,
+					   SMBIOS_MD_VOLTAGE_UNKNOWN);
+	t->max_voltage = smbios_get_val_si(ctx, "maximum-voltage", SYSID_NONE,
+					   SMBIOS_MD_VOLTAGE_UNKNOWN);
+	t->config_voltage = smbios_get_val_si(ctx, "configured-voltage",
+					      SYSID_NONE,
+					      SMBIOS_MD_VOLTAGE_UNKNOWN);
+	t->mem_tech = smbios_get_val_si(ctx, "memory-technology",
+					SYSID_NONE, SMBIOS_MD_TECH_UNKNOWN);
+	t->mem_op_mode_cap =
+		smbios_get_val_si(ctx, "memory-operating-mode-capability",
+				  SYSID_NONE, SMBIOS_MD_OPMC_UNKNOWN);
+	t->fw_ver = smbios_add_prop_si(ctx, "firmware-version", SYSID_NONE,
+				       NULL);
+	t->module_man_id = smbios_get_val_si(ctx, "module-manufacturer-id",
+					     SYSID_NONE, 0);
+	t->module_prod_id = smbios_get_val_si(ctx, "module-product-id",
+					      SYSID_NONE, 0);
+	t->mem_subsys_con_man_id =
+		smbios_get_val_si(ctx,
+				  "memory-subsystem-controller-manufacturer-id",
+				  SYSID_NONE, 0);
+	t->mem_subsys_con_prod_id =
+		smbios_get_val_si(ctx,
+				  "memory-subsystem-controller-product-id",
+				  SYSID_NONE, 0);
+	t->nonvolatile_size = smbios_get_u64_si(ctx, "non-volatile-size",
+						SYSID_NONE,
+						SMBIOS_MS_PORT_SIZE_UNKNOWN);
+	t->volatile_size = smbios_get_u64_si(ctx, "volatile-size",
+					     SYSID_NONE,
+					     SMBIOS_MS_PORT_SIZE_UNKNOWN);
+	t->cache_size = smbios_get_u64_si(ctx, "cache-size",
+					  SYSID_NONE,
+					  SMBIOS_MS_PORT_SIZE_UNKNOWN);
+	t->logical_size = smbios_get_u64_si(ctx, "logical-size",
+					    SYSID_NONE,
+					    SMBIOS_MS_PORT_SIZE_UNKNOWN);
+	t->ext_speed = smbios_get_val_si(ctx, "extended-speed", SYSID_NONE, 0);
+	t->ext_config_mem_speed =
+		smbios_get_val_si(ctx, "extended-configured-memory-speed",
+				  SYSID_NONE, 0);
+	t->pmic0_man_id = smbios_get_val_si(ctx, "pmic0-manufacturer-id",
+					    SYSID_NONE, 0);
+	t->pmic0_rev_num = smbios_get_val_si(ctx, "pmic0-revision-number",
+					     SYSID_NONE, 0);
+	t->rcd_man_id = smbios_get_val_si(ctx, "rcd-manufacturer-id",
+					  SYSID_NONE, 0);
+	t->rcd_rev_num = smbios_get_val_si(ctx, "rcd-revision-number",
+					   SYSID_NONE, 0);
+}
+
+static void
+smbios_pop_type17_size_from_memory_node(ofnode node, struct smbios_type17 *t)
+{
+	const fdt32_t *reg;
+	int len;
+	u64 sz;
+	u32 size_mb;
+
+	/* Read property 'reg' from the node */
+	reg = ofnode_read_prop(node, "reg", &len);
+	if (!reg || len < sizeof(fdt32_t) * 4 || len % sizeof(fdt32_t))
+		return;
+
+	/* Combine hi/lo for size (typically 64-bit) */
+	sz = ((u64)fdt32_to_cpu(reg[2]) << 32) | fdt32_to_cpu(reg[3]);
+
+	/* Convert size to MB */
+	size_mb = (u32)(sz >> 20); /* 1 MB = 2^20 */
+	if (size_mb < SMBIOS_MD_SIZE_EXT) {
+		t->size = cpu_to_le16(size_mb);
+		t->ext_size = 0;
+		return;
+	}
+
+	t->size = cpu_to_le16(SMBIOS_MD_SIZE_EXT); /* Signal extended used */
+	t->ext_size = cpu_to_le32((u32)(sz >> 10)); /* In KB */
+}
+
+static void smbios_pop_type17_size_si(struct smbios_ctx *ctx,
+				      struct smbios_type17 *t)
+{
+	t->size = smbios_get_val_si(ctx, "size", SYSID_NONE,
+				    SMBIOS_MD_SIZE_UNKNOWN);
+	t->ext_size = smbios_get_val_si(ctx, "extended-size", SYSID_NONE, 0);
+}
+
+static int
+smbios_scan_memctrl_subnode(ulong *current, int *handle, struct smbios_ctx *ctx,
+			    int idx, smbios_write_memctrlnode cb)
+{
+	int total_len = 0;
+	ofnode child;
+	int i = 0;
+	int hdl_base = *handle;
+	u64 base = 0;
+
+	/*
+	 * Enumerate all subnodes of 'memory-controller' that contain 'size'
+	 * property and generate one instance for each.
+	 */
+	for (child = ofnode_first_subnode(ctx->node); ofnode_valid(child);
+	     child = ofnode_next_subnode(child)) {
+		u64 sz = 0;
+		const fdt32_t *size;
+		int proplen;
+
+		size = ofnode_read_prop(child, "size", &proplen);
+		if (!size || proplen < sizeof(fdt32_t) ||
+		    proplen % sizeof(fdt32_t))
+			continue;
+
+		/* 64-bit size: <hi lo> or 32-bit size */
+		if (proplen >= sizeof(fdt32_t) * 2)
+			sz = ((u64)fdt32_to_cpu(size[0]) << 32) |
+			     fdt32_to_cpu(size[1]);
+		else
+			sz = fdt32_to_cpu(size[0]);
+
+		*handle = hdl_base + i;
+		total_len += cb(current, *handle, ctx, idx, base, sz);
+		base += sz;
+		i++;
+	}
+
+	return total_len;
+}
+
+static int
+smbios_write_type17_from_memctrl_node(ulong *current, int handle,
+				      struct smbios_ctx *ctx, int idx,
+				      u64 __maybe_unused base, u64 sz)
+{
+	struct smbios_type17 *t;
+	int len;
+	u8 *eos_addr;
+	u32 size_mb;
+	void *hdl;
+	size_t hdl_size;
+
+	len = sizeof(*t);
+	t = map_sysmem(*current, len);
+	memset(t, 0, len);
+
+	fill_smbios_header(t, SMBIOS_MEMORY_DEVICE, len, handle);
+
+	/* eos is at the end of the structure */
+	eos_addr = (u8 *)t + len - sizeof(t->eos);
+	smbios_set_eos(ctx, eos_addr);
+
+	/* Read the memory array handles */
+	if (!sysinfo_get_data(ctx->dev, SYSID_SM_MEMARRAY_HANDLE, &hdl,
+			      &hdl_size) &&
+		hdl_size == SYSINFO_MEM_HANDLE_MAX * sizeof(u16))
+		t->phy_mem_array_hdl = *((u16 *)hdl + idx);
+
+	/* Convert to MB */
+	size_mb = (u32)(sz >> 20);
+	if (size_mb < SMBIOS_MD_SIZE_EXT) {
+		/* Use 16-bit size field */
+		t->size = cpu_to_le16(size_mb);  /* In MB */
+		t->ext_size = cpu_to_le32(0);
+	} else {
+		/* Signal use of extended size field */
+		t->size = cpu_to_le16(SMBIOS_MD_SIZE_EXT);
+		t->ext_size = cpu_to_le32((u32)(sz >> 10)); /* In KB */
+	}
+
+	/* Write other general fields */
+	smbios_pop_type17_general_si(ctx, t);
+
+	len = t->hdr.length + smbios_string_table_len(ctx);
+	*current += len;
+	unmap_sysmem(t);
+
+	return len;
+}
+
+static int smbios_write_type17_mem(ulong *current, int handle,
+				   struct smbios_ctx *ctx, int idx,
+				   int type)
+{
+	struct smbios_type17 *t;
+	int len;
+	u8 *eos_addr;
+	void *hdl;
+	size_t hdl_size;
+
+	len = sizeof(*t);
+	t = map_sysmem(*current, len);
+	memset(t, 0, len);
+
+	fill_smbios_header(t, SMBIOS_MEMORY_DEVICE, len, handle);
+
+	/* eos is at the end of the structure */
+	eos_addr = (u8 *)t + len - sizeof(t->eos);
+	smbios_set_eos(ctx, eos_addr);
+
+	if (type == SMBIOS_MEM_CUSTOM) {
+		smbios_pop_type17_size_si(ctx, t);
+
+		t->phy_mem_array_hdl =
+			smbios_get_val_si(ctx, "physical-memory-array-handle",
+					  SYSID_NONE, 0);
+	} else if (type == SMBIOS_MEM_FDT_MEM_NODE) {
+		smbios_pop_type17_size_from_memory_node(ctx->node, t);
+
+		/* Read the memory array handles */
+		if (!sysinfo_get_data(ctx->dev, SYSID_SM_MEMARRAY_HANDLE, &hdl,
+				      &hdl_size) &&
+		    hdl_size == SYSINFO_MEM_HANDLE_MAX * sizeof(u16))
+			t->phy_mem_array_hdl = *((u16 *)hdl + idx);
+	}
+
+	/* Write other general fields */
+	smbios_pop_type17_general_si(ctx, t);
+
+	len = t->hdr.length + smbios_string_table_len(ctx);
+	*current += len;
+	unmap_sysmem(t);
+
+	return len;
+}
+
+static int smbios_scan_mem_nodes(ulong *current, int *handle,
+				 struct smbios_ctx *ctx,
+				 smbios_write_memnode mem_cb,
+				 int *idx)
+{
+	int len = 0;
+	struct smbios_ctx ctx_bak;
+	ofnode child;
+	int hdl_base = *handle;
+
+	memcpy(&ctx_bak, ctx, sizeof(ctx_bak));
+
+	for (child = ofnode_first_subnode(ofnode_root());
+	     ofnode_valid(child); child = ofnode_next_subnode(child)) {
+		const char *str;
+
+		/* Look up for 'device_type = "memory"' */
+		str = ofnode_read_string(child, "device_type");
+		if (!str || strcmp(str, "memory"))
+			continue;
+
+		ctx->node = child;
+		*handle = hdl_base + *idx;
+		/* Generate one instance for each 'memory' node */
+		len += mem_cb(current, *handle, ctx, *idx,
+			      SMBIOS_MEM_FDT_MEM_NODE);
+		memcpy(ctx, &ctx_bak, sizeof(*ctx));
+		(*idx)++;
+	}
+
+	return len;
+}
+
+static int smbios_scan_mctrl_subnodes(ulong *current, int *handle,
+				      struct smbios_ctx *ctx,
+				      smbios_write_memctrlnode mctrl_wcb,
+				      int *idx)
+{
+	int len = 0;
+	struct smbios_ctx ctx_bak;
+	ofnode child;
+
+	memcpy(&ctx_bak, ctx, sizeof(ctx_bak));
+
+	for (child = ofnode_first_subnode(ofnode_root());
+	     ofnode_valid(child); child = ofnode_next_subnode(child)) {
+		const char *compat;
+		const char *name;
+
+		/*
+		 * Look up for node with name or property 'compatible'
+		 * containing 'memory-controller'.
+		 */
+		name = ofnode_get_name(child);
+		compat = ofnode_read_string(child, "compatible");
+		if ((!compat || !strstr(compat, "memory-controller")) &&
+		    (!name || !strstr(name, "memory-controller")))
+			continue;
+
+		(*handle)++;
+		ctx->node = child;
+		/*
+		 * Generate one instance for each subnode of
+		 * 'memory-controller' which contains property 'size'.
+		 */
+		len += smbios_scan_memctrl_subnode(current, handle, ctx,
+						   *idx, mctrl_wcb);
+		memcpy(ctx, &ctx_bak, sizeof(*ctx));
+		(*idx)++;
+	}
+	return len;
+}
+
+static int smbios_write_type1719(ulong *current, int *handle,
+				 struct smbios_ctx *ctx,
+				 smbios_write_memnode mem_cb,
+				 smbios_write_memctrlnode mctrl_wcb)
+{
+	int len = 0;
+	int idx;
+
+	if (!IS_ENABLED(CONFIG_OF_CONTROL))
+		return 0;	/* Error, return 0-length */
+
+	/* Step 1: Scan any subnode exists */
+	len = smbios_scan_subnodes(current, ctx, handle, mem_cb,
+				   SMBIOS_MEM_CUSTOM);
+	if (len)
+		return len;
+
+	/* Step 2: Scan 'memory' node from the entire FDT */
+	idx = 0;
+	len += smbios_scan_mem_nodes(current, handle, ctx, mem_cb, &idx);
+
+	/* Step 3: Scan 'memory-controller' node from the entire FDT */
+	len += smbios_scan_mctrl_subnodes(current, handle, ctx, mctrl_wcb, &idx);
+
+	return len;
+}
+
+static int smbios_write_type17(ulong *current, int *handle,
+			       struct smbios_ctx *ctx)
+{
+	return smbios_write_type1719(current, handle, ctx,
+				     smbios_write_type17_mem,
+				     smbios_write_type17_from_memctrl_node);
+}
+
 #endif /* #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE) */
 
 static int smbios_write_type32(ulong *current, int *handle,
@@ -1481,6 +1857,7 @@ static struct smbios_write_method smbios_write_funcs[] = {
 #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
 	{ smbios_write_type9, "system-slot"},
 	{ smbios_write_type16, "memory-array"},
+	{ smbios_write_type17, "memory-device"},
 #endif
 	{ smbios_write_type32, },
 	{ smbios_write_type127 },
-- 
2.25.1

