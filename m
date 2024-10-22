Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7D2CDD0E1
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 20:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 955558919D;
	Tue, 22 Oct 2024 22:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VXp09aRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81CD7892E0; Tue, 22 Oct 2024 22:07:47 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 035A688FD6
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 22:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cbd00dd21cso37412466d6.3
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729627664; x=1730232464; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWOSWxeG4qeusWp+tRZNQtY+psUQ18rx6NOLEKCAl2s=;
 b=VXp09aRtVUz3RlSQ2LyNCl36bI56IFu0BJvDSRy2vSTS7JQMPb3Otg47ouVmhpeHoK
 WmLwAa9sGTNb6aqYs//A5q59Nk47upSP6sGAMRYRezk0VP4i3ikJsbwfWOF3ZxcemhcF
 V4jZuLrqNeKq1S1VvfZf+FObqMjB2FwHkNYpIotq9h87wdmEcCsRpJrK75yTxokcNgcv
 6w7kD0BEMS4p61WqqcRCEh9Vi3RWDVNRULEszHHIutxTv3nLCkH4Gxiu43PR6dYUQfel
 HNtWgkUj5lMufG/iiE8I/DqcEx6t7jsEX9zUgwXwxI7a0fiHYx8rr1m6V066mC6x1Pdp
 CX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729627664; x=1730232464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWOSWxeG4qeusWp+tRZNQtY+psUQ18rx6NOLEKCAl2s=;
 b=YpNntM/hWdm+Rdn8jVJ75ZfhWvNgtzyZarvv5mCqoLN2MZv2cWQZ9K7jdQTG2FbeKe
 XY9mOHQv0eaj8h8LcjSAEp3Adi2pvkdcaFNW2Rc/bLIjstB5lbu+PH9THqD1MVxj6Bmr
 /ozvcHjcgIy2MBWja98UOCA/CVX8/Kb8RbdrACQRAX2UO7nNoXFMVytvDE7AwySBH9Nx
 aZzmmm+If04NwqahPnThqSoCOd3CcVRmwTi7orOLgp3Zvzk2xoSOIMOMuu9vFCJnCJKM
 2Ec6vaVYenf29vHMYA9+VsrX1Sk1RcaqJbqJhisIx3WV69rWXEw03Q+VrkIboE0IwEwO
 cPTg==
X-Gm-Message-State: AOJu0Yz2wV9p/WmwEEP8ROJTUpPLZL5QyB1gOSWB2FnFCgHHPjbtf4xC
 mM8CwUGkNVQSMsJQfX4a0xhhvAQjCIJBW3utEyoOWgyMu1osVy+LWg3ww5HT2DCI7mVw4gtiOO7
 KK34=
X-Google-Smtp-Source: AGHT+IHGSnnv8GTAhK3cuJKSK9sCloTLRVfLWYrEhYLZwKZ8KZlz9HqVvz+JiwVQJEwRFSOmX+0+gA==
X-Received: by 2002:a05:6214:5705:b0:6cb:c994:160b with SMTP id
 6a1803df08f44-6ce3417ed6dmr4756346d6.18.1729627663553; 
 Tue, 22 Oct 2024 13:07:43 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce0091a255sm32519956d6.59.2024.10.22.13.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 13:07:42 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: iwamatsu@nigauri.org, marek.vasut+renesas@mailbox.org,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Michal Simek <michal.simek@amd.com>, Jonas Karlman <jonas@kwiboo.se>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 7/8] cmd: update smbios cmd
Date: Tue, 22 Oct 2024 13:05:28 -0700
Message-Id: <20241022200543.116343-8-raymond.mao@linaro.org>
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

Update the cmd according to the changes of the smbios library:
1. Refactor smbios cmd print functions to match the content defined
   by the specification.
2. Add new print functions for Type 0, 3, 4 and 7.
3. Update the expected pytest result to align with the smbios
   library changes.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Initial patch. Move all changes related to cmd/smbios into this patch.
- Combine with #9(v1) patch.

 cmd/smbios.c                 | 342 ++++++++++++++++++++++++++++++++---
 include/smbios.h             |   5 +
 test/py/tests/test_smbios.py |   2 +-
 3 files changed, 319 insertions(+), 30 deletions(-)

diff --git a/cmd/smbios.c b/cmd/smbios.c
index 2122ac04e55..9839f6f6690 100644
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
index 82b0b689830..ffa4ea795ec 100644
--- a/test/py/tests/test_smbios.py
+++ b/test/py/tests/test_smbios.py
@@ -32,7 +32,7 @@ def test_cmd_smbios_sandbox(u_boot_console):
     """Run the smbios command on the sandbox"""
     output = u_boot_console.run_command('smbios')
     assert 'DMI type 0,' in output
-    assert 'String 1: U-Boot' in output
+    assert 'Vendor: U-Boot' in output
     assert 'DMI type 1,' in output
     assert 'Manufacturer: sandbox' in output
     assert 'DMI type 2,' in output
-- 
2.25.1

