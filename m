Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B30AC531DC
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 15:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CD2788BC3;
	Fri, 16 Aug 2024 17:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FVF1NbqT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78C2F889A6; Fri, 16 Aug 2024 17:47:47 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6628488BBF
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 17:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5d5c324267aso1265690eaf.0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723823259; x=1724428059; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kWUsSVB+iYVty6kyrIMC5/K5UUHbb2SESXh61mtkNjg=;
 b=FVF1NbqTYWeYonlu/0aYkpvW5aZPbg/NKDSCJfWTXjbg9Nxqw3Oeo9cWDHk5eklezi
 mgxG+y2TnjjjhvLUiBB9Hy89FXQcfd5wsYULB6IOha6A7y4eGaBJ9W05uIaUNK/OfwCd
 kMeMClKDl1tWy7tQPqeXfz89mBiXQU6uBnOzi3MPI2ILg9FFXiGLvPDl89Vnm9821HiF
 OJ4q3AS8HBWSsdtKSxVCjf30x4Vx3veo4fzmEfzrwTBrSke/c7vtmBk2O67opqIO8ZDI
 Z2r2jZI3r/YAG4oJPWMnHmtFNMT1cJuSIF19fwV56NYHMGAhbw6gOo1zGbbKsna7XtmG
 Rffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723823259; x=1724428059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kWUsSVB+iYVty6kyrIMC5/K5UUHbb2SESXh61mtkNjg=;
 b=mHFAbI/dZ1rytl96jn7+jV96RAGX/XaHLU0xpl6/D+eOwJs8EJGPDjLYKZ6akoIA9q
 6Vu+53Dp0C0Mx9YqWJ5CY7K40ml0n+SJxRbEbNFtD4uKYLXfDadB+TW8fKEU2pK1CnJO
 5iBx831ZoSvVT5JXm8bryLPjPAAEBNiaf/pyaBk5VVPXSuCkySMVkylHQ+7oKyCVOTSD
 sdik2eThZ3J1aijq+0WlQ2TJbRIugp4a4A4W869j2nR7XsDjDnVv5UPGdvZg4r0OkmyN
 GO4Hbt7lRJbwfoCXCaWMPjArnQxHpMr2d9gtgLQia4taKWCN7ebK1NKWDjNchKxQHOyp
 Mo6w==
X-Gm-Message-State: AOJu0YxCcAhs+0kGmwokQWxk6LRdJqz4ePt4vIsa2FqeNdxGNr9qQTux
 C4EFaZmnhlcK4ht6+RhSNOUMk3eKZ6wG9PF0qD0Be/Gp7Yaf/VJ8HN6wMJ2ZwF7z/vg/KehSJGF
 K8Es=
X-Google-Smtp-Source: AGHT+IGISYzLazI/0wLogDiNdi+qXJfSkDbFW8z+RjC7/S/h7WKJx23xr7IskMQ2I0bGfXRNEuELIw==
X-Received: by 2002:a05:6359:4c89:b0:1af:4626:7e42 with SMTP id
 e5c5f4694b2df-1b39330c7ecmr412590255d.25.1723823258825; 
 Fri, 16 Aug 2024 08:47:38 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff0e53d8sm187041185a.85.2024.08.16.08.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:47:38 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Alexander Gendin <agendin@matrox.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 03/10] smbios: Refactor SMBIOS library
Date: Fri, 16 Aug 2024 08:46:46 -0700
Message-Id: <20240816154658.1866186-4-raymond.mao@linaro.org>
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

Current SMBIOS library does not fully match to the specification.
It hardcodes values instead of exposing values from the device.
It does not support dynamic length for contained object handles
or elements and misses the handling of a few fields.

The refactoring of this patch includes:
1. Expose values from device via sysinfo interface.
2. Replace smbios_add_prop with smbios_add_prop_si to allow getting
   string values from sysinfo.
3. Add smbios_get_val_si to get int values from sysinfo.
4. Use sysinfo_get_data to get data area like contained object
   handles, elements or processor id.
5. Refactor SMBIOS cmd print functions to match the command output
   with the specification
6. Add new print functions for Type 0, 3 and 4.
7. Miscellaneous fixes in SMBIOS.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 cmd/smbios.c     | 268 +++++++++++++++++++++++++++++++++--
 include/smbios.h | 116 +++++++++++----
 lib/smbios.c     | 358 ++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 632 insertions(+), 110 deletions(-)

diff --git a/cmd/smbios.c b/cmd/smbios.c
index d3bd8b12a67..8e2bf46a09c 100644
--- a/cmd/smbios.c
+++ b/cmd/smbios.c
@@ -26,6 +26,71 @@ static const char * const wakeup_type_strings[] = {
 	"AC Power Restored",	/* 0x08 */
 };
 
+static const char * const boardtype_strings[] = {
+	"Reserved",			/* 0x00 */
+	"Unknown",			/* 0x01 */
+	"Other",			/* 0x02 */
+	"Server Blade",			/* 0x03 */
+	"Connectivity Switch",		/* 0x04 */
+	"System Management Module",	/* 0x05 */
+	"Processor Module",		/* 0x06 */
+	"I/O Module",			/* 0x07 */
+	"Memory Module",		/* 0x08 */
+	"Daughter board",		/* 0x09 */
+	"Motherboard",			/* 0x0a */
+	"Processor/Memory Module",	/* 0x0b */
+	"Processor/IO Module",		/* 0x0c */
+	"Interconnect board",		/* 0x0d */
+};
+
+static const char * const chassis_state_strings[] = {
+	"Reserved",			/* 0x00 */
+	"Other",			/* 0x01 */
+	"Unknown",			/* 0x02 */
+	"Safe",				/* 0x03 */
+	"Warning",			/* 0x04 */
+	"Critical",			/* 0x05 */
+	"Non-recoverable",		/* 0x06 */
+};
+
+static const char * const chassis_security_strings[] = {
+	"Reserved",			/* 0x00 */
+	"Other",			/* 0x01 */
+	"Unknown",			/* 0x02 */
+	"None",				/* 0x03 */
+	"External interface locked out",/* 0x04 */
+	"External interface enabled",	/* 0x05 */
+};
+
+static const char * const processor_type_strings[] = {
+	"Reserved",			/* 0x00 */
+	"Other",			/* 0x01 */
+	"Unknown",			/* 0x02 */
+	"Central Processor",		/* 0x03 */
+	"Math Processor",		/* 0x04 */
+	"DSP Processor",		/* 0x05 */
+	"Video Processor",		/* 0x06 */
+};
+
+static const char * const processor_family_strings[] = {
+	[0] = "Other",
+	[1] = "Unknown",
+	[2 ... 253] = "Other", /* skip these definitions from now */
+	[254] = "Refer to 'Processor Family 2'",
+	[255] = "Reserved",
+	[256] = "ARMv7",
+	[257] = "ARMv8",
+};
+
+static const char * const processor_upgrade_strings[] = {
+	[0] = "Reserved",
+	[1] = "Other",
+	[2] = "Unknown",
+	[3 ... 5] = "Other", /* skip these definitions from now */
+	[6] = "None",
+	[7 ... 80] = "Other", /* skip these definitions from now */
+};
+
 /**
  * smbios_get_string() - get SMBIOS string from table
  *
@@ -92,6 +157,32 @@ const char *smbios_wakeup_type_str(u8 wakeup_type)
 	return wakeup_type_strings[wakeup_type];
 }
 
+static void smbios_print_type0(struct smbios_type0 *table)
+{
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
+}
+
 static void smbios_print_type1(struct smbios_type1 *table)
 {
 	printf("System Information\n");
@@ -99,38 +190,180 @@ static void smbios_print_type1(struct smbios_type1 *table)
 	smbios_print_str("Product Name", table, table->product_name);
 	smbios_print_str("Version", table, table->version);
 	smbios_print_str("Serial Number", table, table->serial_number);
-	if (table->length >= 0x19) {
+	if (table->hdr.length >= SMBIOS_TYPE1_LENGTH_V21) {
 		printf("\tUUID: %pUl\n", table->uuid);
 		printf("\tWake-up Type: %s\n",
 		       smbios_wakeup_type_str(table->wakeup_type));
 	}
-	if (table->length >= 0x1b) {
+	if (table->hdr.length >= SMBIOS_TYPE1_LENGTH_V24) {
 		smbios_print_str("SKU Number", table, table->sku_number);
 		smbios_print_str("Family", table, table->family);
 	}
 }
 
+const char *smbios_baseboard_type_str(u8 borad_type)
+{
+	if (borad_type >= ARRAY_SIZE(boardtype_strings))
+		borad_type = 0;
+	return boardtype_strings[borad_type];
+}
+
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
+	printf("\tBoard Type: %s\n",
+	       smbios_baseboard_type_str(table->board_type));
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
 
+const char *smbios_chassis_state_str(u8 state)
+{
+	if (state >= ARRAY_SIZE(chassis_state_strings))
+		state = 0;
+	return chassis_state_strings[state];
+}
+
+const char *smbios_chassis_security_str(u8 status)
+{
+	if (status >= ARRAY_SIZE(chassis_security_strings))
+		status = 0;
+	return chassis_security_strings[status];
+}
+
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
+
+	printf("\tBoot-up State: %s\n",
+	       smbios_chassis_state_str(table->bootup_state));
+	printf("\tPower Supply State: %s\n",
+	       smbios_chassis_state_str(table->power_supply_state));
+	printf("\tThermal State: %s\n",
+	       smbios_chassis_state_str(table->thermal_state));
+	printf("\tSecurity Status: %s\n",
+	       smbios_chassis_security_str(table->security_status));
+
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
+const char *smbios_processor_type_str(u8 type)
+{
+	if (type >= ARRAY_SIZE(processor_type_strings))
+		type = 0;
+	return processor_type_strings[type];
+}
+
+const char *smbios_processor_family_str(u16 family)
+{
+	if (family >= ARRAY_SIZE(processor_family_strings))
+		family = 0;
+
+	return processor_family_strings[family];
+}
+
+const char *smbios_processor_upgrade_str(u16 upgrade)
+{
+	if (upgrade >= ARRAY_SIZE(processor_upgrade_strings))
+		upgrade = 0;
+
+	return processor_upgrade_strings[upgrade];
+}
+
+static void smbios_print_type4(struct smbios_type4 *table)
+{
+	printf("Processor Information:\n");
+	smbios_print_str("Socket Designation", table, table->socket_design);
+	printf("\tProcessor Type: %s\n",
+	       smbios_processor_type_str(table->processor_type));
+	printf("\tProcessor Family: %s\n",
+	       smbios_processor_family_str(table->processor_family));
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
+	printf("\tProcessor Upgrade: %s\n",
+	       smbios_processor_upgrade_str(table->processor_upgrade));
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
+	printf("\tProcessor Family 2: %s\n",
+	       smbios_processor_family_str(table->processor_family2));
+	printf("\tCore Count 2: 0x%04x\n", table->core_count2);
+	printf("\tCore Enabled 2: 0x%04x\n", table->core_enabled2);
+	printf("\tThread Count 2: 0x%04x\n", table->thread_count2);
+	printf("\tThread Enabled: 0x%04x\n", table->thread_enabled);
+}
+
 static void smbios_print_type127(struct smbios_type127 *table)
 {
 	printf("End Of Table\n");
@@ -192,13 +425,22 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
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
+		case SMBIOS_END_OF_TABLE:
 			smbios_print_type127((struct smbios_type127 *)pos);
 			break;
 		default:
diff --git a/include/smbios.h b/include/smbios.h
index 60e28a89af8..f2269642268 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -80,19 +80,24 @@ struct __packed smbios3_entry {
 	u64 struct_table_address;
 };
 
+struct __packed smbios_header {
+	u8 type;
+	u8 length;
+	u16 handle;
+};
+
 /* BIOS characteristics */
-#define BIOS_CHARACTERISTICS_PCI_SUPPORTED	(1 << 7)
-#define BIOS_CHARACTERISTICS_UPGRADEABLE	(1 << 11)
-#define BIOS_CHARACTERISTICS_SELECTABLE_BOOT	(1 << 16)
 
-#define BIOS_CHARACTERISTICS_EXT1_ACPI		(1 << 0)
-#define BIOS_CHARACTERISTICS_EXT2_UEFI		(1 << 3)
-#define BIOS_CHARACTERISTICS_EXT2_TARGET	(1 << 2)
+#define BIOS_CHARACTERISTICS_PCI_SUPPORTED	BIT(7)
+#define BIOS_CHARACTERISTICS_UPGRADEABLE	BIT(11)
+#define BIOS_CHARACTERISTICS_SELECTABLE_BOOT	BIT(16)
+
+#define BIOS_CHARACTERISTICS_EXT1_ACPI		BIT(0)
+#define BIOS_CHARACTERISTICS_EXT2_UEFI		BIT(3)
+#define BIOS_CHARACTERISTICS_EXT2_TARGET	BIT(2)
 
 struct __packed smbios_type0 {
-	u8 type;
-	u8 length;
-	u16 handle;
+	struct smbios_header hdr;
 	u8 vendor;
 	u8 bios_ver;
 	u16 bios_start_segment;
@@ -136,10 +141,12 @@ enum smbios_wakeup_type {
 	SMBIOS_WAKEUP_TYPE_AC_POWER_RESTORED,
 };
 
+#define SMBIOS_TYPE1_LENGTH_V20		0x08
+#define SMBIOS_TYPE1_LENGTH_V21		0x19
+#define SMBIOS_TYPE1_LENGTH_V24		0x1b
+
 struct __packed smbios_type1 {
-	u8 type;
-	u8 length;
-	u16 handle;
+	struct smbios_header hdr;
 	u8 manufacturer;
 	u8 product_name;
 	u8 version;
@@ -151,8 +158,19 @@ struct __packed smbios_type1 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
-#define SMBIOS_BOARD_FEATURE_HOSTING	(1 << 0)
+#define SMBIOS_BOARD_UNKNOWN		1
+#define SMBIOS_BOARD_OTHER		2
+#define SMBIOS_BOARD_SERVER_BLADE	3
+#define SMBIOS_BOARD_CON_SWITCH		4
+#define SMBIOS_BOARD_SM_MODULE		5
+#define SMBIOS_BOARD_PROCESSOR_MODULE	6
+#define SMBIOS_BOARD_IO_MODULE		7
+#define SMBIOS_BOARD_MEM_MODULE		8
+#define SMBIOS_BOARD_DAUGHTER_BOARD	9
 #define SMBIOS_BOARD_MOTHERBOARD	10
+#define SMBIOS_BOARD_PROC_MEM_MODULE	11
+#define SMBIOS_BOARD_PROC_IO_MODULE	12
+#define SMBIOS_BOARD_INTERCON		13
 
 union baseboard_feat {
 	struct {
@@ -167,9 +185,7 @@ union baseboard_feat {
 };
 
 struct __packed smbios_type2 {
-	u8 type;
-	u8 length;
-	u16 handle;
+	struct smbios_header hdr;
 	u8 manufacturer;
 	u8 product_name;
 	u8 version;
@@ -180,17 +196,29 @@ struct __packed smbios_type2 {
 	u16 chassis_handle;
 	u8 board_type;
 	u8 number_contained_objects;
+	/*
+	 * Dynamic bytes will be inserted here to store the objects.
+	 * length is equal to 'number_contained_objects'.
+	 */
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
 #define SMBIOS_ENCLOSURE_DESKTOP	3
 #define SMBIOS_STATE_SAFE		3
 #define SMBIOS_SECURITY_NONE		3
+#define SMBIOS_ENCLOSURE_OEM_UND	0
+#define SMBIOS_ENCLOSURE_HEIGHT_UND	0
+#define SMBIOS_POWCORD_NUM_UND		0
+#define SMBIOS_ELEMENT_TYPE_SELECT	BIT(7)
 
-struct __packed smbios_type3 {
+struct __packed elem_hdr {
 	u8 type;
-	u8 length;
-	u16 handle;
+	u8 minimum; /* 0 - 254 */
+	u8 maximum; /* 1 - 255 */
+};
+
+struct __packed smbios_type3 {
+	struct smbios_header hdr;
 	u8 manufacturer;
 	u8 chassis_type;
 	u8 version;
@@ -205,21 +233,52 @@ struct __packed smbios_type3 {
 	u8 number_of_power_cords;
 	u8 element_count;
 	u8 element_record_length;
+	/*
+	 * Dynamic bytes will be inserted here to store the elements.
+	 * length is equal to 'element_record_length' * 'element_record_length'
+	 */
+	u8 sku_number;
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
+#define SMBIOS_PROCESSOR_TYPE_OTHER	1
+#define SMBIOS_PROCESSOR_TYPE_UNKNOWN	2
 #define SMBIOS_PROCESSOR_TYPE_CENTRAL	3
-#define SMBIOS_PROCESSOR_STATUS_ENABLED	1
+#define SMBIOS_PROCESSOR_TYPE_MATH	4
+#define SMBIOS_PROCESSOR_TYPE_DSP	5
+#define SMBIOS_PROCESSOR_TYPE_VIDEO	6
+
+#define SMBIOS_PROCESSOR_STATUS_UNKNOWN		0
+#define SMBIOS_PROCESSOR_STATUS_ENABLED		1
+#define SMBIOS_PROCESSOR_STATUS_DISABLED_USER	2
+#define SMBIOS_PROCESSOR_STATUS_DISABLED_BIOS	3
+#define SMBIOS_PROCESSOR_STATUS_IDLE		4
+#define SMBIOS_PROCESSOR_STATUS_OTHER		7
+
 #define SMBIOS_PROCESSOR_UPGRADE_NONE	6
 
 #define SMBIOS_PROCESSOR_FAMILY_OTHER	1
 #define SMBIOS_PROCESSOR_FAMILY_UNKNOWN	2
+#define SMBIOS_PROCESSOR_FAMILY_ARMV7	256
+#define SMBIOS_PROCESSOR_FAMILY_ARMV8	257
+
+#define SMBIOS_PROCESSOR_FAMILY_EXT	0xfe
+
+/* Processor Characteristics */
+#define SMBIOS_PROCESSOR_RSVD		BIT(0)
+#define SMBIOS_PROCESSOR_UND		BIT(1)
+#define SMBIOS_PROCESSOR_64BIT		BIT(2)
+#define SMBIOS_PROCESSOR_MULTICORE	BIT(3)
+#define SMBIOS_PROCESSOR_HWTHREAD	BIT(4)
+#define SMBIOS_PROCESSOR_EXEC_PROT	BIT(5)
+#define SMBIOS_PROCESSOR_ENH_VIRT	BIT(6)
+#define SMBIOS_PROCESSOR_POW_CON	BIT(7)
+#define SMBIOS_PROCESSOR_128BIT		BIT(8)
+#define SMBIOS_PROCESSOR_ARM64_SOCID	BIT(9)
 
 struct __packed smbios_type4 {
-	u8 type;
-	u8 length;
-	u16 handle;
-	u8 socket_designation;
+	struct smbios_header hdr;
+	u8 socket_design;
 	u8 processor_type;
 	u8 processor_family;
 	u8 processor_manufacturer;
@@ -245,9 +304,12 @@ struct __packed smbios_type4 {
 	u16 core_count2;
 	u16 core_enabled2;
 	u16 thread_count2;
+	u16 thread_enabled;
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
+#define SMBIOS_CACHE_HANDLE_NONE 0xffff
+
 struct __packed smbios_type32 {
 	u8 type;
 	u8 length;
@@ -264,12 +326,6 @@ struct __packed smbios_type127 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
-struct __packed smbios_header {
-	u8 type;
-	u8 length;
-	u16 handle;
-};
-
 /**
  * fill_smbios_header() - Fill the header of an SMBIOS table
  *
diff --git a/lib/smbios.c b/lib/smbios.c
index 7c24ea129eb..8e481365165 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -8,6 +8,8 @@
 #define LOG_CATEGORY	LOGC_BOARD
 
 #include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
 #include <env.h>
 #include <linux/stringify.h>
 #include <linux/string.h>
@@ -206,6 +208,26 @@ void get_str_from_dt(const struct map_sysinfo *nprop, char *str, size_t size)
 	}
 }
 
+/**
+ * smbios_get_val_si() - Get value from sysinfo
+ *
+ * @ctx:	context of SMBIOS
+ * @sysinfo_id: unique identifier for the value to be read
+ * Return:	0 if not found, else value from sysinfo
+ */
+static int smbios_get_val_si(struct smbios_ctx *ctx, int sysinfo_id)
+{
+	int val;
+
+	if (!sysinfo_id || !ctx->dev)
+		return 0;
+
+	if (!sysinfo_get_int(ctx->dev, sysinfo_id, &val))
+		return val;
+
+	return 0;
+}
+
 /**
  * smbios_add_prop_si() - Add a property from the devicetree or sysinfo
  *
@@ -225,8 +247,7 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
 	if (!dval || !*dval)
 		dval = NULL;
 
-	if (!prop)
-		return smbios_add_string(ctx, dval);
+	log_debug("smbios: %s, sysinfo id: %d\n", prop, sysinfo_id);
 
 	if (sysinfo_id && ctx->dev) {
 		char val[SMBIOS_STR_MAX];
@@ -235,6 +256,9 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
 		if (!ret)
 			return smbios_add_string(ctx, val);
 	}
+	if (!prop)
+		return smbios_add_string(ctx, dval);
+
 	if (IS_ENABLED(CONFIG_OF_CONTROL)) {
 		const char *str = NULL;
 		char str_dt[128] = { 0 };
@@ -247,6 +271,8 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
 		} else {
 			const struct map_sysinfo *nprop;
 
+			log_debug("no smbios node, try the entire DT\n");
+
 			nprop = convert_sysinfo_to_dt(ctx->subnode_name, prop);
 			get_str_from_dt(nprop, str_dt, sizeof(str_dt));
 			str = (const char *)str_dt;
@@ -330,15 +356,18 @@ static int smbios_write_type0(ulong *current, int handle,
 			      struct smbios_ctx *ctx)
 {
 	struct smbios_type0 *t;
-	int len = sizeof(struct smbios_type0);
+	int len = sizeof(*t);
 
 	t = map_sysmem(*current, len);
-	memset(t, 0, sizeof(struct smbios_type0));
+	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_BIOS_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->vendor = smbios_add_prop(ctx, NULL, "U-Boot");
+	t->vendor = smbios_add_prop_si(ctx, NULL, SYSINFO_ID_SMBIOS_BIOS_VENDOR,
+				       "U-Boot");
 
-	t->bios_ver = smbios_add_prop(ctx, "version", PLAIN_VERSION);
+	t->bios_ver = smbios_add_prop_si(ctx, "version",
+					 SYSINFO_ID_SMBIOS_BIOS_VER,
+					 PLAIN_VERSION);
 	if (t->bios_ver)
 		gd->smbios_version = ctx->last_str;
 	log_debug("smbios_version = %p: '%s'\n", gd->smbios_version,
@@ -347,7 +376,9 @@ static int smbios_write_type0(ulong *current, int handle,
 	print_buffer((ulong)gd->smbios_version, gd->smbios_version,
 		     1, strlen(gd->smbios_version) + 1, 0);
 #endif
-	t->bios_release_date = smbios_add_prop(ctx, NULL, U_BOOT_DMI_DATE);
+	t->bios_release_date =
+		smbios_add_prop_si(ctx, NULL, SYSINFO_ID_SMBIOS_BIOS_REL_DATE,
+				   U_BOOT_DMI_DATE);
 #ifdef CONFIG_ROM_SIZE
 	if (CONFIG_ROM_SIZE < SZ_16M) {
 		t->bios_rom_size = (CONFIG_ROM_SIZE / 65536) - 1;
@@ -374,7 +405,7 @@ static int smbios_write_type0(ulong *current, int handle,
 	t->ec_major_release = 0xff;
 	t->ec_minor_release = 0xff;
 
-	len = t->length + smbios_string_table_len(ctx);
+	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
 	unmap_sysmem(t);
 
@@ -385,16 +416,18 @@ static int smbios_write_type1(ulong *current, int handle,
 			      struct smbios_ctx *ctx)
 {
 	struct smbios_type1 *t;
-	int len = sizeof(struct smbios_type1);
+	int len = sizeof(*t);
 	char *serial_str = env_get("serial#");
 
 	t = map_sysmem(*current, len);
-	memset(t, 0, sizeof(struct smbios_type1));
+	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->manufacturer = smbios_add_prop_si(ctx, "manufacturer",
-					     SYSINFO_ID_SMBIOS_SYSTEM_MANUFACTURER,
-					     NULL);
+
+	t->manufacturer =
+		smbios_add_prop_si(ctx, "manufacturer",
+				   SYSINFO_ID_SMBIOS_SYSTEM_MANUFACTURER,
+				   NULL);
 	t->product_name = smbios_add_prop_si(ctx, "product",
 					     SYSINFO_ID_SMBIOS_SYSTEM_PRODUCT,
 					     NULL);
@@ -403,19 +436,21 @@ static int smbios_write_type1(ulong *current, int handle,
 					NULL);
 	if (serial_str) {
 		t->serial_number = smbios_add_prop(ctx, NULL, serial_str);
-		strncpy((char *)t->uuid, serial_str, sizeof(t->uuid));
+		strlcpy((char *)t->uuid, serial_str, sizeof(t->uuid));
 	} else {
-		t->serial_number = smbios_add_prop_si(ctx, "serial",
-						      SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
-						      NULL);
+		t->serial_number =
+			smbios_add_prop_si(ctx, "serial",
+					   SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
+					   NULL);
 	}
-	t->wakeup_type = SMBIOS_WAKEUP_TYPE_UNKNOWN;
+	t->wakeup_type =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_SYSTEM_WAKEUP);
 	t->sku_number = smbios_add_prop_si(ctx, "sku",
 					   SYSINFO_ID_SMBIOS_SYSTEM_SKU, NULL);
 	t->family = smbios_add_prop_si(ctx, "family",
 				       SYSINFO_ID_SMBIOS_SYSTEM_FAMILY, NULL);
 
-	len = t->length + smbios_string_table_len(ctx);
+	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
 	unmap_sysmem(t);
 
@@ -426,33 +461,80 @@ static int smbios_write_type2(ulong *current, int handle,
 			      struct smbios_ctx *ctx)
 {
 	struct smbios_type2 *t;
-	int len = sizeof(struct smbios_type2);
+	int len = sizeof(*t);
+	size_t obj_hdl_size = 0;
+	u8 *obj_hdl = NULL;
+	u8 *obj_addr, *eos_addr;
+
+	if (!sysinfo_get_data(ctx->dev, SYSINFO_ID_SMBIOS_BASEBOARD_OBJS_HANDLE,
+			      &obj_hdl, &obj_hdl_size))
+		len += obj_hdl_size; /* Add the dynamic part */
 
 	t = map_sysmem(*current, len);
-	memset(t, 0, sizeof(struct smbios_type2));
+	memset(t, 0, len);
+
+	/* Verify the contained object handles */
+	t->number_contained_objects =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_BASEBOARD_OBJS_NUM);
+
+	if ((t->number_contained_objects * sizeof(u16) != obj_hdl_size) ||
+	    (!obj_hdl && (t->number_contained_objects || obj_hdl_size)) ||
+	    (obj_hdl && (!t->number_contained_objects || !obj_hdl_size))) {
+		/*
+		 * Error with returning 0-length when any of below rules does
+		 * not match:
+		 * 1. Contained Object Handles length must be equal to (Object
+		 *    Handle Length * Object Number).
+		 * 2. If no Contained Object Handles exist, Object Number must
+		 *    be 0, and versa vice.
+		 */
+		unmap_sysmem(t);
+		return 0;
+	}
+
 	fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, handle);
+
+	obj_addr = (u8 *)t + offsetof(struct smbios_type2, eos);
+	/* eos is at the end of the structure */
+	eos_addr = (u8 *)t + len - sizeof(t->eos);
 	smbios_set_eos(ctx, t->eos);
-	t->manufacturer = smbios_add_prop_si(ctx, "manufacturer",
-					     SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
-					     NULL);
-	t->product_name = smbios_add_prop_si(ctx, "product",
-					     SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
-					     NULL);
-	t->version = smbios_add_prop_si(ctx, "version",
-					SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
-					NULL);
+	t->manufacturer =
+		smbios_add_prop_si(ctx, "manufacturer",
+				   SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
+				   NULL);
+	t->product_name =
+		smbios_add_prop_si(ctx, "product",
+				   SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
+				   NULL);
+	t->version =
+		smbios_add_prop_si(ctx, "version",
+				   SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
+				   NULL);
+	t->serial_number =
+		smbios_add_prop_si(ctx, "serial",
+				   SYSINFO_ID_SMBIOS_BASEBOARD_SERIAL,
+				   NULL);
+	t->asset_tag_number =
+		smbios_add_prop_si(ctx, "asset-tag",
+				   SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
+				   NULL);
+	t->feature_flags =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_BASEBOARD_FEATURE);
+
+	t->chassis_location =
+		smbios_add_prop_si(ctx, "chassis-location",
+				   SYSINFO_ID_SMBIOS_BASEBOARD_CHASSIS_LOCAT,
+				   NULL);
+	t->board_type =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_BASEBOARD_TYPE);
+
+	/* Get the objs from driver */
+	if (obj_hdl)
+		memcpy(obj_addr, obj_hdl, obj_hdl_size);
 
-	t->serial_number = smbios_add_prop_si(ctx, "serial",
-					      SYSINFO_ID_SMBIOS_BASEBOARD_SERIAL,
-					      NULL);
-	t->asset_tag_number = smbios_add_prop_si(ctx, "asset-tag",
-						 SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
-						 NULL);
-	t->feature_flags = SMBIOS_BOARD_FEATURE_HOSTING;
-	t->board_type = SMBIOS_BOARD_MOTHERBOARD;
 	t->chassis_handle = handle + 1;
 
-	len = t->length + smbios_string_table_len(ctx);
+	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
 	unmap_sysmem(t);
 
@@ -463,20 +545,94 @@ static int smbios_write_type3(ulong *current, int handle,
 			      struct smbios_ctx *ctx)
 {
 	struct smbios_type3 *t;
-	int len = sizeof(struct smbios_type3);
+	int len = sizeof(*t);
+	u8 *elem = NULL;
+	u8 *elem_addr, *eos_addr, *sku_num_addr;
+	size_t elem_size = 0;
+
+	if (!sysinfo_get_data(ctx->dev, SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENTS,
+			      &elem, &elem_size))
+		len += elem_size; /* Add the dynamic part */
 
 	t = map_sysmem(*current, len);
-	memset(t, 0, sizeof(struct smbios_type3));
+	memset(t, 0, len);
+
+	/* Verify the contained elements */
+	t->element_count =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENT_CNT);
+
+	t->element_record_length =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENT_LEN);
+
+	if ((elem_size != t->element_record_length * t->element_count) ||
+	    (!elem && (t->element_count || t->element_record_length ||
+		       elem_size)) ||
+	    (elem && (t->element_record_length < sizeof(struct elem_hdr) ||
+		       !elem_size))) {
+		/*
+		 * Error with returning 0-length when any of below rules does
+		 * not match:
+		 * 1. Contained Elements length must be equal to (Element
+		 *    Record Length * Element Count).
+		 * 2. If no Contained Elements exist, Element Count and Element
+		 *    Record Length must be 0.
+		 * 3. If Contained Elements exist, Element Record Length must
+		 *    be at least the size of the Element Record Header.
+		 */
+		unmap_sysmem(t);
+		return 0;
+	}
+
 	fill_smbios_header(t, SMBIOS_SYSTEM_ENCLOSURE, len, handle);
-	smbios_set_eos(ctx, t->eos);
-	t->manufacturer = smbios_add_prop(ctx, "manufacturer", NULL);
-	t->chassis_type = SMBIOS_ENCLOSURE_DESKTOP;
-	t->bootup_state = SMBIOS_STATE_SAFE;
-	t->power_supply_state = SMBIOS_STATE_SAFE;
-	t->thermal_state = SMBIOS_STATE_SAFE;
-	t->security_status = SMBIOS_SECURITY_NONE;
-
-	len = t->length + smbios_string_table_len(ctx);
+
+	elem_addr = (u8 *)t + offsetof(struct smbios_type3, sku_number);
+	sku_num_addr = elem_addr + elem_size;
+
+	/* eos is at the end of the structure */
+	eos_addr = (u8 *)t + len - sizeof(t->eos);
+	smbios_set_eos(ctx, eos_addr);
+
+	t->manufacturer =
+		smbios_add_prop_si(ctx, "manufacturer",
+				   SYSINFO_ID_SMBIOS_ENCLOSURE_MANUFACTURER,
+				   NULL);
+
+	t->chassis_type = smbios_get_val_si(ctx,
+					    SYSINFO_ID_SMBIOS_ENCLOSURE_TYPE);
+	t->version = smbios_add_prop_si(ctx, "version",
+					SYSINFO_ID_SMBIOS_ENCLOSURE_VERSION,
+					NULL);
+	t->serial_number =
+		smbios_add_prop_si(ctx, "serial",
+				   SYSINFO_ID_SMBIOS_ENCLOSURE_SERIAL,
+				   NULL);
+	t->asset_tag_number =
+		smbios_add_prop_si(ctx, "asset-tag",
+				   SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
+				   NULL);
+	t->bootup_state = smbios_get_val_si(ctx,
+					    SYSINFO_ID_SMBIOS_ENCLOSURE_BOOTUP);
+	t->power_supply_state =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_ENCLOSURE_POW);
+	t->thermal_state =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_ENCLOSURE_THERMAL);
+	t->security_status =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_ENCLOSURE_SECURITY);
+	t->oem_defined = smbios_get_val_si(ctx,
+					   SYSINFO_ID_SMBIOS_ENCLOSURE_OEM);
+	t->height = smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_ENCLOSURE_HEIGHT);
+	t->number_of_power_cords =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_ENCLOSURE_POWCORE_NUM);
+
+	/* Get the elements from driver */
+	if (elem)
+		memcpy(elem_addr, elem, elem_size);
+
+	*sku_num_addr =
+		smbios_add_prop_si(ctx, "sku", SYSINFO_ID_SMBIOS_ENCLOSURE_SKU,
+				   NULL);
+
+	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
 	unmap_sysmem(t);
 
@@ -489,6 +645,8 @@ static void smbios_write_type4_dm(struct smbios_type4 *t,
 	u16 processor_family = SMBIOS_PROCESSOR_FAMILY_UNKNOWN;
 	const char *vendor = NULL;
 	const char *name = NULL;
+	u8 *id_data = NULL;
+	size_t id_size = 0;
 
 #ifdef CONFIG_CPU
 	char processor_name[49];
@@ -511,31 +669,97 @@ static void smbios_write_type4_dm(struct smbios_type4 *t,
 	}
 #endif
 
-	t->processor_family = 0xfe;
+	if (processor_family == SMBIOS_PROCESSOR_FAMILY_UNKNOWN)
+		processor_family =
+			smbios_get_val_si(ctx,
+					  SYSINFO_ID_SMBIOS_PROCESSOR_FAMILY2);
+
+	t->processor_family = SMBIOS_PROCESSOR_FAMILY_EXT;
 	t->processor_family2 = processor_family;
-	t->processor_manufacturer = smbios_add_prop(ctx, NULL, vendor);
-	t->processor_version = smbios_add_prop(ctx, NULL, name);
+
+	t->processor_manufacturer =
+		smbios_add_prop_si(ctx, NULL,
+				   SYSINFO_ID_SMBIOS_PROCESSOR_MANUFACT,
+				   vendor);
+	t->processor_version =
+		smbios_add_prop_si(ctx, NULL,
+				   SYSINFO_ID_SMBIOS_PROCESSOR_VERSION,
+				   name);
+
+	if (t->processor_id[0] || t->processor_id[1])
+		return;
+
+	if (sysinfo_get_data(ctx->dev, SYSINFO_ID_SMBIOS_PROCESSOR_ID,
+			     &id_data, &id_size) ||
+	    id_size != sizeof(t->processor_id))
+		return;
+	if (id_data)
+		memcpy((u8 *)t->processor_id, id_data, id_size);
+
 }
 
 static int smbios_write_type4(ulong *current, int handle,
 			      struct smbios_ctx *ctx)
 {
 	struct smbios_type4 *t;
-	int len = sizeof(struct smbios_type4);
+	int len = sizeof(*t);
 
 	t = map_sysmem(*current, len);
-	memset(t, 0, sizeof(struct smbios_type4));
+	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_PROCESSOR_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->processor_type = SMBIOS_PROCESSOR_TYPE_CENTRAL;
+	t->socket_design =
+		smbios_add_prop_si(ctx, NULL,
+				   SYSINFO_ID_SMBIOS_PROCESSOR_SOCKET,
+				   NULL);
+	t->processor_type =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_TYPE);
 	smbios_write_type4_dm(t, ctx);
-	t->status = SMBIOS_PROCESSOR_STATUS_ENABLED;
-	t->processor_upgrade = SMBIOS_PROCESSOR_UPGRADE_NONE;
-	t->l1_cache_handle = 0xffff;
-	t->l2_cache_handle = 0xffff;
-	t->l3_cache_handle = 0xffff;
 
-	len = t->length + smbios_string_table_len(ctx);
+	t->voltage =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_VOLTAGE);
+	t->external_clock =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_EXT_CLOCK);
+	t->max_speed =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_MAX_SPEED);
+	t->current_speed =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_CUR_SPEED);
+	t->status =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_STATUS);
+	t->processor_upgrade =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_UPGRADE);
+
+	t->l1_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
+	t->l2_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
+	t->l3_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
+
+	t->serial_number = smbios_add_prop_si(ctx, NULL,
+					      SYSINFO_ID_SMBIOS_PROCESSOR_SN,
+					      NULL);
+	t->asset_tag = smbios_add_prop_si(ctx, NULL,
+					  SYSINFO_ID_SMBIOS_PROCESSOR_ASSET_TAG,
+					  NULL);
+	t->part_number = smbios_add_prop_si(ctx, NULL,
+					    SYSINFO_ID_SMBIOS_PROCESSOR_PN,
+					    NULL);
+	t->core_count =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT);
+	t->core_enabled =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN);
+	t->thread_count =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT);
+	t->processor_characteristics =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_CHARA);
+	t->core_count2 =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT2);
+	t->core_enabled2 =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN2);
+	t->thread_count2 =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT2);
+	t->thread_enabled =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_EN);
+
+	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
 	unmap_sysmem(t);
 
@@ -546,10 +770,10 @@ static int smbios_write_type32(ulong *current, int handle,
 			       struct smbios_ctx *ctx)
 {
 	struct smbios_type32 *t;
-	int len = sizeof(struct smbios_type32);
+	int len = sizeof(*t);
 
 	t = map_sysmem(*current, len);
-	memset(t, 0, sizeof(struct smbios_type32));
+	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_SYSTEM_BOOT_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
 
@@ -563,10 +787,10 @@ static int smbios_write_type127(ulong *current, int handle,
 				struct smbios_ctx *ctx)
 {
 	struct smbios_type127 *t;
-	int len = sizeof(struct smbios_type127);
+	int len = sizeof(*t);
 
 	t = map_sysmem(*current, len);
-	memset(t, 0, sizeof(struct smbios_type127));
+	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_END_OF_TABLE, len, handle);
 
 	*current += len;
@@ -598,7 +822,7 @@ ulong write_smbios_table(ulong addr)
 	int i;
 
 	ctx.node = ofnode_null();
-	if (IS_ENABLED(CONFIG_OF_CONTROL) && CONFIG_IS_ENABLED(SYSINFO)) {
+	if (CONFIG_IS_ENABLED(SYSINFO)) {
 		uclass_first_device(UCLASS_SYSINFO, &ctx.dev);
 		if (ctx.dev) {
 			int ret;
-- 
2.25.1

