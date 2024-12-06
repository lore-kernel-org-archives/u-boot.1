Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1D0E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 22:57:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2FF588ACB;
	Fri,  6 Dec 2024 23:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lwBUH7hR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DFA58870D; Fri,  6 Dec 2024 23:57:03 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AC1088ACB
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 23:57:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-46686a258c2so24061971cf.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 14:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733525819; x=1734130619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jx5pICfHJmZwyNJdA82g06fbWvYJ824WZKEpNkwlfls=;
 b=lwBUH7hRV0IxwB3vUMJIFxXzUJbk64Y85k0KAWlin+8nvNe9KIqAkFLJr3JXP8DZMb
 G2X0hc73Kp3JpZbtoOTPcwH49tDFdUqlpYPldlm5zrRVzfOAqTX7x4RrSaIzKQScILln
 PahFJ8mq5d4nfiPrp0fAmqDYGpOWoYGWVVrl+mzeA+ZZi7Bj/wm9rRk41Mp74O4TmJpy
 ohb7IPeCZogYxV2ST2B/m0MxRkQJr3oxFqOW28SwftMTEStctTQGE+HMyykeuecn9sQa
 cSibVdQ2FpWRH48HkHBYQHhl9kwxw1vkOxSr+RmhD4JAMXUEVvNuNsmGUoA9uz9XTruf
 guyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525819; x=1734130619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jx5pICfHJmZwyNJdA82g06fbWvYJ824WZKEpNkwlfls=;
 b=YQ5yV6dxCjmoE2ayjU187PJzd1B3iwAHtyg/CMke23T+xsqwYzwsa92V2rXdNMA5De
 vps77kgIyJ+ZOAtbPxUkzc4DvxMwlirxc6Uh5sha+GC3v2ei+v/KJN8sgJkmNBntAcic
 BYHqdamLgy2eRiKs+lzZjykrF4vUiQC9SgMg978Yy/uuEKqaTMeLShmkkq+7qtS7T1Zi
 TUnTi9o+XKwVTvqmlyZf2JaJbfWIVm36k8h4JuznjVfE9jVvOe+Zdvoj2YqU0jwy7MIx
 NModAgEsw6kHixGGnRAXR3xXqMJgzc/WDhQiP13NykSKCnKXX8AAS9OIJwzLPWOqzpP1
 dSFQ==
X-Gm-Message-State: AOJu0YyGQ+iyqk0a3IByhIUHzQRSp5ZtJ4+AZ7TjvN4YA+TD8Ev1E7Ui
 dcFJik3zgN20V6D9qz35QGilBLhSfmpzF7MfLn+1Qt+AO1+hUTgpRoeQK7uSYguP7HtIEqNwpZe
 m
X-Gm-Gg: ASbGncsMNzr90NijF4p+VLTZNF0RMI4Cnh7XsxFNO30UPsdsQFFIf4aMQ4vzJcekuu0
 mdYGPkGvg7fe9lrPNX7PtQbk6XDid/y7O8uDxycqCUu8SoxqR+ja48DOYUBGJiO2Xf0w9fvSsE9
 aVayGyQyBnSxtAL0yGY8Rlp8IUHtblC6vH4VzfCESQADeMDVV8SOJBYcBt0YTuUDSGe/8vP5GMH
 O9CHidOUC2r1UD5ytDgK24VsDv7jjONqICYp4uGreIoDyBz3vIVJSla8qI91ZQDeEsSVdyNCmJn
 6o+ELVjaIyJHmVC9wjFJKoHUl6MbYrmufEggREodqL6Cw5xk
X-Google-Smtp-Source: AGHT+IFaU5jl7xgCp1loifw+/eSD1LZANRKLfFA82h5PZZ8ddNo4EmfOC1qOMyRCoE99QbbHLWNy/A==
X-Received: by 2002:a05:622a:18a1:b0:466:a584:69f8 with SMTP id
 d75a77b69052e-46734dbc98amr88297651cf.43.1733525818813; 
 Fri, 06 Dec 2024 14:56:58 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296d4d7dsm26080871cf.34.2024.12.06.14.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:56:57 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 09/10] cmd: update smbios cmd
Date: Fri,  6 Dec 2024 14:54:26 -0800
Message-Id: <20241206225438.13866-10-raymond.mao@linaro.org>
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

Update the cmd according to the changes of the smbios library:
1. Refactor smbios cmd print functions to match the content defined
   by the specification.
2. Add new print functions for Type 3, 4 and 7.
3. Remove the fallback string "Not specified" from smbios_get_string,
   as the spec requires a NULL output for those undefined strings.
4. Update the test_cmd_smbios_sandbox pytest expected result to
   align with the smbios library changes and add new pytest
   test_cmd_smbios_sysinfo_verbose to test the verbose smbios
   output.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Initial patch. Move all changes related to cmd/smbios into this patch.
- Combine with #9(v1) patch.
Changes in v3
- Remove "Not specified" string from smbios_get_string.
- Update pytest for smbios.

 cmd/smbios.c                 | 344 ++++++++++++++++++++++++++++++++---
 include/smbios.h             |   5 +
 test/py/tests/test_smbios.py |  18 +-
 3 files changed, 336 insertions(+), 31 deletions(-)

diff --git a/cmd/smbios.c b/cmd/smbios.c
index 2122ac04e55..562dd7959be 100644
--- a/cmd/smbios.c
+++ b/cmd/smbios.c
@@ -14,16 +14,109 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-static const char * const wakeup_type_strings[] = {
-	"Reserved",		/* 0x00 */
-	"Other",		/* 0x01 */
-	"Unknown",		/* 0x02 */
-	"APM Timer",		/* 0x03 */
-	"Modem Ring",		/* 0x04 */
-	"Lan Remote",		/* 0x05 */
-	"Power Switch",		/* 0x06 */
-	"PCI PME#",		/* 0x07 */
-	"AC Power Restored",	/* 0x08 */
+static const struct str_lookup_table wakeup_type_strings[] = {
+	{ SMBIOS_WAKEUP_TYPE_RESERVED,		"Reserved" },
+	{ SMBIOS_WAKEUP_TYPE_OTHER,		"Other" },
+	{ SMBIOS_WAKEUP_TYPE_UNKNOWN,		"Unknown" },
+	{ SMBIOS_WAKEUP_TYPE_APM_TIMER,		"APM Timer" },
+	{ SMBIOS_WAKEUP_TYPE_MODEM_RING,	"Modem Ring" },
+	{ SMBIOS_WAKEUP_TYPE_LAN_REMOTE,	"Lan Remote" },
+	{ SMBIOS_WAKEUP_TYPE_POWER_SWITCH,	"Power Switch" },
+	{ SMBIOS_WAKEUP_TYPE_PCI_PME,		"PCI PME#" },
+	{ SMBIOS_WAKEUP_TYPE_AC_POWER_RESTORED,	"AC Power Restored" },
+};
+
+static const struct str_lookup_table boardtype_strings[] = {
+	{ SMBIOS_BOARD_TYPE_UNKNOWN,		"Unknown" },
+	{ SMBIOS_BOARD_TYPE_OTHER,		"Other" },
+	{ SMBIOS_BOARD_TYPE_SERVER_BLADE,	"Server Blade" },
+	{ SMBIOS_BOARD_TYPE_CON_SWITCH,		"Connectivity Switch" },
+	{ SMBIOS_BOARD_TYPE_SM_MODULE,		"System Management Module" },
+	{ SMBIOS_BOARD_TYPE_PROCESSOR_MODULE,	"Processor Module" },
+	{ SMBIOS_BOARD_TYPE_IO_MODULE,		"I/O Module" },
+	{ SMBIOS_BOARD_TYPE_MEM_MODULE,		"Memory Module" },
+	{ SMBIOS_BOARD_TYPE_DAUGHTER_BOARD,	"Daughter board" },
+	{ SMBIOS_BOARD_TYPE_MOTHERBOARD,	"Motherboard" },
+	{ SMBIOS_BOARD_TYPE_PROC_MEM_MODULE,	"Processor/Memory Module" },
+	{ SMBIOS_BOARD_TYPE_PROC_IO_MODULE,	"Processor/IO Module" },
+	{ SMBIOS_BOARD_TYPE_INTERCON,		"Interconnect board" },
+};
+
+static const struct str_lookup_table chassis_state_strings[] = {
+	{ SMBIOS_STATE_OTHER,		"Other" },
+	{ SMBIOS_STATE_UNKNOWN,		"Unknown" },
+	{ SMBIOS_STATE_SAFE,		"Safe" },
+	{ SMBIOS_STATE_WARNING,		"Warning" },
+	{ SMBIOS_STATE_CRITICAL,	"Critical" },
+	{ SMBIOS_STATE_NONRECOVERABLE,	"Non-recoverable" },
+};
+
+static const struct str_lookup_table chassis_security_strings[] = {
+	{ SMBIOS_SECURITY_OTHER,	"Other" },
+	{ SMBIOS_SECURITY_UNKNOWN,	"Unknown" },
+	{ SMBIOS_SECURITY_NONE,		"None" },
+	{ SMBIOS_SECURITY_EXTINT_LOCK,	"External interface locked out" },
+	{ SMBIOS_SECURITY_EXTINT_EN,	"External interface enabled" },
+};
+
+static const struct str_lookup_table processor_type_strings[] = {
+	{ SMBIOS_PROCESSOR_TYPE_OTHER,		"Other" },
+	{ SMBIOS_PROCESSOR_TYPE_UNKNOWN,	"Unknown" },
+	{ SMBIOS_PROCESSOR_TYPE_CENTRAL,	"Central Processor" },
+	{ SMBIOS_PROCESSOR_TYPE_MATH,		"Math Processor" },
+	{ SMBIOS_PROCESSOR_TYPE_DSP,		"DSP Processor" },
+	{ SMBIOS_PROCESSOR_TYPE_VIDEO,		"Video Processor" },
+};
+
+static const struct str_lookup_table processor_family_strings[] = {
+	{ SMBIOS_PROCESSOR_FAMILY_OTHER,	"Other" },
+	{ SMBIOS_PROCESSOR_FAMILY_UNKNOWN,	"Unknown" },
+	{ SMBIOS_PROCESSOR_FAMILY_RSVD,		"Reserved" },
+	{ SMBIOS_PROCESSOR_FAMILY_ARMV7,	"ARMv7" },
+	{ SMBIOS_PROCESSOR_FAMILY_ARMV8,	"ARMv8" },
+	{ SMBIOS_PROCESSOR_FAMILY_RV32,		"RISC-V RV32" },
+	{ SMBIOS_PROCESSOR_FAMILY_RV64,		"RISC-V RV64" },
+};
+
+static const struct str_lookup_table processor_upgrade_strings[] = {
+	{ SMBIOS_PROCESSOR_UPGRADE_OTHER,	"Other" },
+	{ SMBIOS_PROCESSOR_UPGRADE_UNKNOWN,	"Unknown" },
+	{ SMBIOS_PROCESSOR_UPGRADE_NONE,	"None" },
+};
+
+static const struct str_lookup_table err_corr_type_strings[] = {
+	{ SMBIOS_CACHE_ERRCORR_OTHER,	"Other" },
+	{ SMBIOS_CACHE_ERRCORR_UNKNOWN,	"Unknown" },
+	{ SMBIOS_CACHE_ERRCORR_NONE,	"None" },
+	{ SMBIOS_CACHE_ERRCORR_PARITY,	"Parity" },
+	{ SMBIOS_CACHE_ERRCORR_SBITECC,	"Single-bit ECC" },
+	{ SMBIOS_CACHE_ERRCORR_MBITECC,	"Multi-bit ECC" },
+};
+
+static const struct str_lookup_table sys_cache_type_strings[] = {
+	{ SMBIOS_CACHE_SYSCACHE_TYPE_OTHER,	"Other" },
+	{ SMBIOS_CACHE_SYSCACHE_TYPE_UNKNOWN,	"Unknown" },
+	{ SMBIOS_CACHE_SYSCACHE_TYPE_INST,	"Instruction" },
+	{ SMBIOS_CACHE_SYSCACHE_TYPE_DATA,	"Data" },
+	{ SMBIOS_CACHE_SYSCACHE_TYPE_UNIFIED,	"Unified" },
+};
+
+static const struct str_lookup_table associativity_strings[] = {
+	{ SMBIOS_CACHE_ASSOC_OTHER,	"Other" },
+	{ SMBIOS_CACHE_ASSOC_UNKNOWN,	"Unknown" },
+	{ SMBIOS_CACHE_ASSOC_DMAPPED,	"Direct Mapped" },
+	{ SMBIOS_CACHE_ASSOC_2WAY,	"2-way Set-Associative" },
+	{ SMBIOS_CACHE_ASSOC_4WAY,	"4-way Set-Associative" },
+	{ SMBIOS_CACHE_ASSOC_FULLY,	"Fully Associative" },
+	{ SMBIOS_CACHE_ASSOC_8WAY,	"8-way Set-Associative" },
+	{ SMBIOS_CACHE_ASSOC_16WAY,	"16-way Set-Associative" },
+	{ SMBIOS_CACHE_ASSOC_12WAY,	"12-way Set-Associative" },
+	{ SMBIOS_CACHE_ASSOC_24WAY,	"24-way Set-Associative" },
+	{ SMBIOS_CACHE_ASSOC_32WAY,	"32-way Set-Associative" },
+	{ SMBIOS_CACHE_ASSOC_48WAY,	"48-way Set-Associative" },
+	{ SMBIOS_CACHE_ASSOC_64WAY,	"64-way Set-Associative" },
+	{ SMBIOS_CACHE_ASSOC_20WAY,	"20-way Set-Associative" },
+
 };
 
 /**
@@ -37,7 +130,7 @@ static const char *smbios_get_string(void *table, int index)
 {
 	const char *str = (char *)table +
 			  ((struct smbios_header *)table)->length;
-	static const char fallback[] = "Not Specified";
+	static const char fallback[] = "";
 
 	if (!index)
 		return fallback;
@@ -79,17 +172,53 @@ static void smbios_print_generic(struct smbios_header *table)
 	}
 }
 
-void smbios_print_str(const char *label, void *table, u8 index)
+static void smbios_print_str(const char *label, void *table, u8 index)
 {
 	printf("\t%s: %s\n", label, smbios_get_string(table, index));
 }
 
-const char *smbios_wakeup_type_str(u8 wakeup_type)
+static void smbios_print_lookup_str(const struct str_lookup_table *table,
+				    u16 index, u16 array_size,
+				    const char *prefix)
+{
+	int i;
+	const char *str = NULL;
+
+	for (i = 0; i < array_size; i++) {
+		if ((table + i)->idx == index)
+			str = (table + i)->str;
+	}
+
+	if (str)
+		printf("\t%s: %s\n", prefix, str);
+	else
+		printf("\t%s: [%04x]\n", prefix, index);
+}
+
+static void smbios_print_type0(struct smbios_type0 *table)
 {
-	if (wakeup_type >= ARRAY_SIZE(wakeup_type_strings))
-		/* Values over 0x08 are reserved. */
-		wakeup_type = 0;
-	return wakeup_type_strings[wakeup_type];
+	printf("BIOS Information\n");
+	smbios_print_str("Vendor", table, table->vendor);
+	smbios_print_str("BIOS Version", table, table->bios_ver);
+	/* Keep table->bios_start_segment as 0 for UEFI-based systems */
+	smbios_print_str("BIOS Release Date", table, table->bios_release_date);
+	printf("\tBIOS ROM Size: 0x%02x\n", table->bios_rom_size);
+	printf("\tBIOS Characteristics: 0x%016llx\n",
+	       table->bios_characteristics);
+	printf("\tBIOS Characteristics Extension Byte 1: 0x%02x\n",
+	       table->bios_characteristics_ext1);
+	printf("\tBIOS Characteristics Extension Byte 2: 0x%02x\n",
+	       table->bios_characteristics_ext2);
+	printf("\tSystem BIOS Major Release: 0x%02x\n",
+	       table->bios_major_release);
+	printf("\tSystem BIOS Minor Release: 0x%02x\n",
+	       table->bios_minor_release);
+	printf("\tEmbedded Controller Firmware Major Release: 0x%02x\n",
+	       table->ec_major_release);
+	printf("\tEmbedded Controller Firmware Minor Release: 0x%02x\n",
+	       table->ec_minor_release);
+	printf("\tExtended BIOS ROM Size: 0x%04x\n",
+	       table->extended_bios_rom_size);
 }
 
 static void smbios_print_type1(struct smbios_type1 *table)
@@ -101,8 +230,10 @@ static void smbios_print_type1(struct smbios_type1 *table)
 	smbios_print_str("Serial Number", table, table->serial_number);
 	if (table->hdr.length >= SMBIOS_TYPE1_LENGTH_V21) {
 		printf("\tUUID: %pUl\n", table->uuid);
-		printf("\tWake-up Type: %s\n",
-		       smbios_wakeup_type_str(table->wakeup_type));
+		smbios_print_lookup_str(wakeup_type_strings,
+					table->wakeup_type,
+					ARRAY_SIZE(wakeup_type_strings),
+					"Wake-up Type");
 	}
 	if (table->hdr.length >= SMBIOS_TYPE1_LENGTH_V24) {
 		smbios_print_str("SKU Number", table, table->sku_number);
@@ -112,25 +243,166 @@ static void smbios_print_type1(struct smbios_type1 *table)
 
 static void smbios_print_type2(struct smbios_type2 *table)
 {
-	u16 *handle;
+	int i;
+	u8 *addr = (u8 *)table + offsetof(struct smbios_type2, eos);
 
-	printf("Base Board Information\n");
+	printf("Baseboard Information\n");
 	smbios_print_str("Manufacturer", table, table->manufacturer);
 	smbios_print_str("Product Name", table, table->product_name);
 	smbios_print_str("Version", table, table->version);
 	smbios_print_str("Serial Number", table, table->serial_number);
 	smbios_print_str("Asset Tag", table, table->asset_tag_number);
-	printf("\tFeature Flags: 0x%04x\n", table->feature_flags);
+	printf("\tFeature Flags: 0x%02x\n", table->feature_flags);
 	smbios_print_str("Chassis Location", table, table->chassis_location);
 	printf("\tChassis Handle: 0x%04x\n", table->chassis_handle);
-	smbios_print_str("Board Type", table, table->board_type);
-	printf("\tContained Object Handles: ");
-	handle = (void *)table->eos;
-	for (int i = 0; i < table->number_contained_objects; ++i)
-		printf("0x%04x ", handle[i]);
+	smbios_print_lookup_str(boardtype_strings,
+				table->board_type,
+				ARRAY_SIZE(boardtype_strings),
+				"Board Type");
+	printf("\tNumber of Contained Object Handles: 0x%02x\n",
+	       table->number_contained_objects);
+	if (!table->number_contained_objects)
+		return;
+
+	printf("\tContained Object Handles:\n");
+	for (i = 0; i < table->number_contained_objects; i++) {
+		printf("\t\tObject[%03d]:\n", i);
+		if (CONFIG_IS_ENABLED(HEXDUMP))
+			print_hex_dump("\t\t", DUMP_PREFIX_OFFSET, 16, 1, addr,
+				       sizeof(u16), false);
+		addr += sizeof(u16);
+	}
 	printf("\n");
 }
 
+static void smbios_print_type3(struct smbios_type3 *table)
+{
+	int i;
+	u8 *addr = (u8 *)table + offsetof(struct smbios_type3, sku_number);
+
+	printf("Baseboard Information\n");
+	smbios_print_str("Manufacturer", table, table->manufacturer);
+	printf("\tType: 0x%02x\n", table->chassis_type);
+	smbios_print_str("Version", table, table->version);
+	smbios_print_str("Serial Number", table, table->serial_number);
+	smbios_print_str("Asset Tag", table, table->asset_tag_number);
+	smbios_print_lookup_str(chassis_state_strings,
+				table->bootup_state,
+				ARRAY_SIZE(chassis_state_strings),
+				"Boot-up State");
+	smbios_print_lookup_str(chassis_state_strings,
+				table->power_supply_state,
+				ARRAY_SIZE(chassis_state_strings),
+				"Power Supply State");
+	smbios_print_lookup_str(chassis_state_strings,
+				table->thermal_state,
+				ARRAY_SIZE(chassis_state_strings),
+				"Thermal State");
+	smbios_print_lookup_str(chassis_security_strings,
+				table->security_status,
+				ARRAY_SIZE(chassis_security_strings),
+				"Security Status");
+	printf("\tOEM-defined: 0x%08x\n", table->oem_defined);
+	printf("\tHeight: 0x%02x\n", table->height);
+	printf("\tNumber of Power Cords: 0x%02x\n",
+	       table->number_of_power_cords);
+	printf("\tContained Element Count: 0x%02x\n", table->element_count);
+	printf("\tContained Element Record Length: 0x%02x\n",
+	       table->element_record_length);
+	if (table->element_count) {
+		printf("\tContained Elements:\n");
+		for (i = 0; i < table->element_count; i++) {
+			printf("\t\tElement[%03d]:\n", i);
+			if (CONFIG_IS_ENABLED(HEXDUMP))
+				print_hex_dump("\t\t", DUMP_PREFIX_OFFSET, 16,
+					       1, addr,
+					       table->element_record_length,
+					       false);
+			printf("\t\tContained Element Type: 0x%02x\n", *addr);
+			printf("\t\tContained Element Minimum: 0x%02x\n",
+			       *(addr + 1));
+			printf("\t\tContained Element Maximum: 0x%02x\n",
+			       *(addr + 2));
+			addr += table->element_record_length;
+		}
+	}
+	smbios_print_str("SKU Number", table, *addr);
+}
+
+static void smbios_print_type4(struct smbios_type4 *table)
+{
+	printf("Processor Information:\n");
+	smbios_print_str("Socket Designation", table, table->socket_design);
+	smbios_print_lookup_str(processor_type_strings,
+				table->processor_type,
+				ARRAY_SIZE(processor_type_strings),
+				"Processor Type");
+	smbios_print_lookup_str(processor_family_strings,
+				table->processor_family,
+				ARRAY_SIZE(processor_family_strings),
+				"Processor Family");
+	smbios_print_str("Processor Manufacturer", table,
+			 table->processor_manufacturer);
+	printf("\tProcessor ID word 0: 0x%08x\n", table->processor_id[0]);
+	printf("\tProcessor ID word 1: 0x%08x\n", table->processor_id[1]);
+	smbios_print_str("Processor Version", table, table->processor_version);
+	printf("\tVoltage: 0x%02x\n", table->voltage);
+	printf("\tExternal Clock: 0x%04x\n", table->external_clock);
+	printf("\tMax Speed: 0x%04x\n", table->max_speed);
+	printf("\tCurrent Speed: 0x%04x\n", table->current_speed);
+	printf("\tStatus: 0x%02x\n", table->status);
+	smbios_print_lookup_str(processor_upgrade_strings,
+				table->processor_upgrade,
+				ARRAY_SIZE(processor_upgrade_strings),
+				"Processor Upgrade");
+	printf("\tL1 Cache Handle: 0x%04x\n", table->l1_cache_handle);
+	printf("\tL2 Cache Handle: 0x%04x\n", table->l2_cache_handle);
+	printf("\tL3 Cache Handle: 0x%04x\n", table->l3_cache_handle);
+	smbios_print_str("Serial Number", table, table->serial_number);
+	smbios_print_str("Asset Tag", table, table->asset_tag);
+	smbios_print_str("Part Number", table, table->part_number);
+	printf("\tCore Count: 0x%02x\n", table->core_count);
+	printf("\tCore Enabled: 0x%02x\n", table->core_enabled);
+	printf("\tThread Count: 0x%02x\n", table->thread_count);
+	printf("\tProcessor Characteristics: 0x%04x\n",
+	       table->processor_characteristics);
+	smbios_print_lookup_str(processor_family_strings,
+				table->processor_family2,
+				ARRAY_SIZE(processor_family_strings),
+				"Processor Family 2");
+	printf("\tCore Count 2: 0x%04x\n", table->core_count2);
+	printf("\tCore Enabled 2: 0x%04x\n", table->core_enabled2);
+	printf("\tThread Count 2: 0x%04x\n", table->thread_count2);
+	printf("\tThread Enabled: 0x%04x\n", table->thread_enabled);
+}
+
+static void smbios_print_type7(struct smbios_type7 *table)
+{
+	printf("Cache Information:\n");
+	smbios_print_str("Socket Designation", table,
+			 table->socket_design);
+	printf("\tCache Configuration: 0x%04x\n", table->config.data);
+	printf("\tMaximum Cache Size: 0x%04x\n", table->max_size.data);
+	printf("\tInstalled Size: 0x%04x\n", table->inst_size.data);
+	printf("\tSupported SRAM Type: 0x%04x\n", table->supp_sram_type.data);
+	printf("\tCurrent SRAM Type: 0x%04x\n", table->curr_sram_type.data);
+	printf("\tCache Speed: 0x%02x\n", table->speed);
+	smbios_print_lookup_str(err_corr_type_strings,
+				table->err_corr_type,
+				ARRAY_SIZE(err_corr_type_strings),
+				"Error Correction Type");
+	smbios_print_lookup_str(sys_cache_type_strings,
+				table->sys_cache_type,
+				ARRAY_SIZE(sys_cache_type_strings),
+				"System Cache Type");
+	smbios_print_lookup_str(associativity_strings,
+				table->associativity,
+				ARRAY_SIZE(associativity_strings),
+				"Associativity");
+	printf("\tMaximum Cache Size 2: 0x%08x\n", table->max_size2.data);
+	printf("\tInstalled Cache Size 2: 0x%08x\n", table->inst_size2.data);
+}
+
 static void smbios_print_type127(struct smbios_type127 *table)
 {
 	printf("End Of Table\n");
@@ -192,13 +464,25 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
 		       pos->handle, pos->type, pos->length,
 		       (unsigned long long)map_to_sysmem(pos));
 		switch (pos->type) {
-		case 1:
+		case SMBIOS_BIOS_INFORMATION:
+			smbios_print_type0((struct smbios_type0 *)pos);
+			break;
+		case SMBIOS_SYSTEM_INFORMATION:
 			smbios_print_type1((struct smbios_type1 *)pos);
 			break;
-		case 2:
+		case SMBIOS_BOARD_INFORMATION:
 			smbios_print_type2((struct smbios_type2 *)pos);
 			break;
-		case 127:
+		case SMBIOS_SYSTEM_ENCLOSURE:
+			smbios_print_type3((struct smbios_type3 *)pos);
+			break;
+		case SMBIOS_PROCESSOR_INFORMATION:
+			smbios_print_type4((struct smbios_type4 *)pos);
+			break;
+		case SMBIOS_CACHE_INFORMATION:
+			smbios_print_type7((struct smbios_type7 *)pos);
+			break;
+		case SMBIOS_END_OF_TABLE:
 			smbios_print_type127((struct smbios_type127 *)pos);
 			break;
 		default:
diff --git a/include/smbios.h b/include/smbios.h
index 18f568f9b0d..b5fed57aba2 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -38,6 +38,11 @@ enum {
 #define SMBIOS_INTERMEDIATE_OFFSET	16
 #define SMBIOS_STRUCT_EOS_BYTES		2
 
+struct str_lookup_table {
+	u16 idx;
+	const char *str;
+};
+
 struct __packed smbios_entry {
 	u8 anchor[4];
 	u8 checksum;
diff --git a/test/py/tests/test_smbios.py b/test/py/tests/test_smbios.py
index 82b0b689830..0405a9b9d38 100644
--- a/test/py/tests/test_smbios.py
+++ b/test/py/tests/test_smbios.py
@@ -32,10 +32,26 @@ def test_cmd_smbios_sandbox(u_boot_console):
     """Run the smbios command on the sandbox"""
     output = u_boot_console.run_command('smbios')
     assert 'DMI type 0,' in output
-    assert 'String 1: U-Boot' in output
+    assert 'Vendor: U-Boot' in output
     assert 'DMI type 1,' in output
     assert 'Manufacturer: sandbox' in output
     assert 'DMI type 2,' in output
     assert 'DMI type 3,' in output
     assert 'DMI type 4,' in output
     assert 'DMI type 127,' in output
+
+@pytest.mark.buildconfigspec('cmd_smbios')
+@pytest.mark.buildconfigspec('sysinfo_smbios')
+@pytest.mark.buildconfigspec('generate_smbios_table_verbose')
+def test_cmd_smbios_sysinfo_verbose(u_boot_console):
+    """Run the smbios command"""
+    output = u_boot_console.run_command('smbios')
+    assert 'DMI type 0,' in output
+    assert 'Vendor: U-Boot' in output
+    assert 'DMI type 1,' in output
+    assert 'Manufacturer: linux' in output
+    assert 'DMI type 2,' in output
+    assert 'DMI type 3,' in output
+    assert 'DMI type 7,' in output
+    assert 'DMI type 4,' in output
+    assert 'DMI type 127,' in output
-- 
2.25.1

