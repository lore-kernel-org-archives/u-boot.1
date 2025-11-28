Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE4ED116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3587583B71;
	Fri, 28 Nov 2025 17:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RmJNVRoM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA7AB83B7F; Fri, 28 Nov 2025 17:36:31 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F54A838FA
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-8b2aa1ae006so266359485a.2
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 08:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764347788; x=1764952588; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lX+bcRs1hmYzw20ahsx4LOqTaP16ACjHDDSO7fJk7wo=;
 b=RmJNVRoMHi/k73HwHg0wMPjH+V/GPhvCswKlpRphfk0rEoByybCj7QH1BFmpIw/7KN
 9pRvDKjN4q8OUW3P+elOFywzp6m8QCocaRBYGGjfpQT6OigDyFu4jhN9ut/QU+FBw/XC
 eLw7bZqWsZ0kOmcmHPclf3VGVI/foMjkV2n4RjEtijaeKvZx0WVdSHISDSoh0h+S811i
 Jlt3/QD79/mIh2EUxcr6E7Ng0GT2FZkwZbM8WTTfLTpRqacC5xRuVdZwJZtcWSLisJlO
 Gj8XO6kprfdwfyU3NHVb0AfZJyG6tgQPA4tF40LYmHwdfOYjShNHf3WkM5bBAAYbVKgI
 rqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764347788; x=1764952588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lX+bcRs1hmYzw20ahsx4LOqTaP16ACjHDDSO7fJk7wo=;
 b=alQbcQFnCYL0RCvozlQ05jq3n9T2WXDbeRr8SqIhEtQVoRnHDu/oDC8fTx180CXmSl
 Yxr8nT+9aLgJ2Nwajr0rlJMMnBv0t5XCoAIUY3QySgk0+QufNgLMQKXolDKNnO1TRdng
 t8ipUe+PKojL8YJ5cEN9tG0CMxfkTwC3191uABSiYJN/SejHYZtxhLqhMVkDtgOOVsGT
 RDqnM+dYd+iuOgG+GYwohm32RkMS6V+aLHN2sa0K1AFz1I58p17kH+LwLw2w1kjuZ7zh
 sqV8sLdcGvmoD+LG0nluRzq0XIVl5xaGgPQU8Zss5RK5nAbKOzE9LwmqvYGTjJQx6nbC
 iBHw==
X-Gm-Message-State: AOJu0Yz4d3Bjmw8HvJ1jMpV4O+VuIMFl8XP7qv5kM0vFhnaxUn5vXeAe
 6L0VC3w+Dmby1vI1z38KsEi8lPj3GDXhTYWcjVwFNL16QZREITTofAPwazUqgWt2g28=
X-Gm-Gg: ASbGncsOFLetvQygLFUjatklDPOXXaFhlg1UvplKMaggTZG8amUxpp7JFFlcxXePy6B
 QDG/dsQZoaUNSavgaoSxTxFVMq1onVT51bosxuuiL/3PO27EzJbFnwcrga7E6gmQmHAVsn+rD/v
 6PC+pDvVFdk0OWZNijB7lswuM3h8O9CSA3+1Ml1p3PIXLEfzzhUF3KfTOA39OVMMM3HLSSPXWM9
 E2SntZik4zR0It9mYOwjUZ8CQ2AzhdGGBfI37gMc1IzulWpFx0PMR9usMCf14KFDQNeq37cSzC5
 6+8Bkkm2HWXrM6xqYzIV1bHiHiOo2Rs5TAeQiY1QeLtvdAAGdTwtDAsLgVHlgRZESfAe8vCEn0c
 GWygURptkYEndd0R1RvHgaClCQvL6widU/dZI43cT9YbmX6aGcwZ9ytOi2o3UrYIi1g5K1Dhlxa
 Tc1kDZmKRaiBCxJQGxxLtHlmOie058LSvIpv39Y6ATDw==
X-Google-Smtp-Source: AGHT+IEC4Qg3uH502KMD4VsnOX8CbrfTDKi2TlWXW/SFlb6tg7DJlN3vcThFNbzWOMRUhyE1WmGfng==
X-Received: by 2002:a05:620a:2a14:b0:8b1:8082:aec5 with SMTP id
 af79cd13be357-8b33d47825bmr3401434685a.58.1764347788067; 
 Fri, 28 Nov 2025 08:36:28 -0800 (PST)
Received: from ubuntu.localdomain ([216.58.22.99])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1b75a9sm331227985a.25.2025.11.28.08.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 08:36:27 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Samuel Holland <samuel.holland@sifive.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v5 6/6] smbios: print the properties only when they exist in a
 specified version of spec
Date: Fri, 28 Nov 2025 08:35:23 -0800
Message-Id: <20251128163535.2301653-7-raymondmaoca@gmail.com>
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

By checking the payload length, we can know the version of the spec and
skip the ones which are not expected to exist.

Signed-off-by: Raymond Mao <raymondmaoca@gmail.com>
---
Changes in v5:
- Initial patch.

 cmd/smbios.c     | 65 ++++++++++++++++++++++++++++++++++++++++--------
 include/smbios.h | 32 ++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 11 deletions(-)

diff --git a/cmd/smbios.c b/cmd/smbios.c
index 671c14e05b5..3fafa46d0a5 100644
--- a/cmd/smbios.c
+++ b/cmd/smbios.c
@@ -348,6 +348,8 @@ static void smbios_print_type0(struct smbios_type0 *table)
 	printf("\tBIOS ROM Size: 0x%02x\n", table->bios_rom_size);
 	printf("\tBIOS Characteristics: 0x%016llx\n",
 	       table->bios_characteristics);
+	if (table->hdr.length < SMBIOS_TYPE0_LENGTH_V24)
+		return;
 	printf("\tBIOS Characteristics Extension Byte 1: 0x%02x\n",
 	       table->bios_characteristics_ext1);
 	printf("\tBIOS Characteristics Extension Byte 2: 0x%02x\n",
@@ -360,6 +362,8 @@ static void smbios_print_type0(struct smbios_type0 *table)
 	       table->ec_major_release);
 	printf("\tEmbedded Controller Firmware Minor Release: 0x%02x\n",
 	       table->ec_minor_release);
+	if (table->hdr.length < SMBIOS_TYPE0_LENGTH_V31)
+		return;
 	printf("\tExtended BIOS ROM Size: 0x%04x\n",
 	       table->extended_bios_rom_size);
 }
@@ -371,17 +375,16 @@ static void smbios_print_type1(struct smbios_type1 *table)
 	smbios_print_str("Product Name", table, table->product_name);
 	smbios_print_str("Version", table, table->version);
 	smbios_print_str("Serial Number", table, table->serial_number);
-	if (table->hdr.length >= SMBIOS_TYPE1_LENGTH_V21) {
-		printf("\tUUID: %pUl\n", table->uuid);
-		smbios_print_lookup_str(wakeup_type_strings,
-					table->wakeup_type,
-					ARRAY_SIZE(wakeup_type_strings),
-					"Wake-up Type");
-	}
-	if (table->hdr.length >= SMBIOS_TYPE1_LENGTH_V24) {
-		smbios_print_str("SKU Number", table, table->sku_number);
-		smbios_print_str("Family", table, table->family);
-	}
+	if (table->hdr.length < SMBIOS_TYPE1_LENGTH_V21)
+		return;
+	printf("\tUUID: %pUl\n", table->uuid);
+	smbios_print_lookup_str(wakeup_type_strings, table->wakeup_type,
+				ARRAY_SIZE(wakeup_type_strings),
+				"Wake-up Type");
+	if (table->hdr.length < SMBIOS_TYPE1_LENGTH_V24)
+		return;
+	smbios_print_str("SKU Number", table, table->sku_number);
+	smbios_print_str("Family", table, table->family);
 }
 
 static void smbios_print_type2(struct smbios_type2 *table)
@@ -501,21 +504,31 @@ static void smbios_print_type4(struct smbios_type4 *table)
 	printf("\tL1 Cache Handle: 0x%04x\n", table->l1_cache_handle);
 	printf("\tL2 Cache Handle: 0x%04x\n", table->l2_cache_handle);
 	printf("\tL3 Cache Handle: 0x%04x\n", table->l3_cache_handle);
+	if (table->hdr.length < SMBIOS_TYPE4_LENGTH_V23)
+		return;
 	smbios_print_str("Serial Number", table, table->serial_number);
 	smbios_print_str("Asset Tag", table, table->asset_tag);
 	smbios_print_str("Part Number", table, table->part_number);
+	if (table->hdr.length < SMBIOS_TYPE4_LENGTH_V25)
+		return;
 	printf("\tCore Count: 0x%02x\n", table->core_count);
 	printf("\tCore Enabled: 0x%02x\n", table->core_enabled);
 	printf("\tThread Count: 0x%02x\n", table->thread_count);
 	printf("\tProcessor Characteristics: 0x%04x\n",
 	       table->processor_characteristics);
+	if (table->hdr.length < SMBIOS_TYPE4_LENGTH_V26)
+		return;
 	smbios_print_lookup_str(processor_family_strings,
 				table->processor_family2,
 				ARRAY_SIZE(processor_family_strings),
 				"Processor Family 2");
+	if (table->hdr.length < SMBIOS_TYPE4_LENGTH_V30)
+		return;
 	printf("\tCore Count 2: 0x%04x\n", table->core_count2);
 	printf("\tCore Enabled 2: 0x%04x\n", table->core_enabled2);
 	printf("\tThread Count 2: 0x%04x\n", table->thread_count2);
+	if (table->hdr.length < SMBIOS_TYPE4_LENGTH_V36)
+		return;
 	printf("\tThread Enabled: 0x%04x\n", table->thread_enabled);
 }
 
@@ -529,6 +542,8 @@ static void smbios_print_type7(struct smbios_type7 *table)
 	printf("\tInstalled Size: 0x%04x\n", table->inst_size.data);
 	printf("\tSupported SRAM Type: 0x%04x\n", table->supp_sram_type.data);
 	printf("\tCurrent SRAM Type: 0x%04x\n", table->curr_sram_type.data);
+	if (table->hdr.length < SMBIOS_TYPE7_LENGTH_V21)
+		return;
 	printf("\tCache Speed: 0x%02x\n", table->speed);
 	smbios_print_lookup_str(err_corr_type_strings,
 				table->err_corr_type,
@@ -542,6 +557,8 @@ static void smbios_print_type7(struct smbios_type7 *table)
 				table->associativity,
 				ARRAY_SIZE(associativity_strings),
 				"Associativity");
+	if (table->hdr.length < SMBIOS_TYPE7_LENGTH_V31)
+		return;
 	printf("\tMaximum Cache Size 2: 0x%08x\n", table->max_size2.data);
 	printf("\tInstalled Cache Size 2: 0x%08x\n", table->inst_size2.data);
 }
@@ -574,8 +591,12 @@ static void smbios_print_type9(struct smbios_type9 *table)
 	printf("\tSlot ID: 0x%04x\n", table->slot_id);
 	printf("\tSlot Characteristics 1: 0x%04x\n",
 	       table->slot_characteristics_1);
+	if (table->hdr.length < SMBIOS_TYPE9_LENGTH_V21)
+		return;
 	printf("\tSlot Characteristics 2: 0x%04x\n",
 	       table->slot_characteristics_2);
+	if (table->hdr.length < SMBIOS_TYPE9_LENGTH_V26)
+		return;
 	printf("\tSegment Group Number (Base): 0x%04x\n",
 	       table->segment_group_number);
 	printf("\tBus Number (Base): 0x%04x\n", table->bus_number);
@@ -611,6 +632,8 @@ static void smbios_print_type9(struct smbios_type9 *table)
 static void smbios_print_type16(struct smbios_type16 *table)
 {
 	printf("Physical Memory Array:\n");
+	if (table->hdr.length < SMBIOS_TYPE16_LENGTH_V21)
+		return;
 	smbios_print_lookup_str(ma_location_strings, table->location,
 				ARRAY_SIZE(ma_location_strings), "Location");
 	smbios_print_lookup_str(ma_use_strings, table->use,
@@ -622,12 +645,16 @@ static void smbios_print_type16(struct smbios_type16 *table)
 	printf("\tMemory Error Information Handle: 0x%04x\n",
 	       table->mem_err_info_hdl);
 	printf("\tNumber of Memory Devices: 0x%04x\n", table->num_of_mem_dev);
+	if (table->hdr.length < SMBIOS_TYPE16_LENGTH_V27)
+		return;
 	printf("\tExtended Maximum Capacity: 0x%016llx\n", table->ext_max_cap);
 }
 
 static void smbios_print_type17(struct smbios_type17 *table)
 {
 	printf("Memory Device:\n");
+	if (table->hdr.length < SMBIOS_TYPE17_LENGTH_V21)
+		return;
 	printf("\tPhysical Memory Array Handle: 0x%04x\n",
 	       table->phy_mem_array_hdl);
 	printf("\tMemory Error Information Handle: 0x%04x\n",
@@ -644,17 +671,27 @@ static void smbios_print_type17(struct smbios_type17 *table)
 	smbios_print_lookup_str(md_type_strings, table->mem_type,
 				ARRAY_SIZE(md_type_strings), "Memory Type");
 	printf("\tType Detail: 0x%04x\n", table->type_detail);
+	if (table->hdr.length < SMBIOS_TYPE17_LENGTH_V23)
+		return;
 	printf("\tSpeed: 0x%04x\n", table->speed);
 	smbios_print_str("Manufacturer", table, table->manufacturer);
 	smbios_print_str("Serial Number", table, table->serial_number);
 	smbios_print_str("Asset Tag", table, table->asset_tag);
 	smbios_print_str("Part Number", table, table->part_number);
+	if (table->hdr.length < SMBIOS_TYPE17_LENGTH_V26)
+		return;
 	printf("\tAttributes: 0x%04x\n", table->attributes);
+	if (table->hdr.length < SMBIOS_TYPE17_LENGTH_V27)
+		return;
 	printf("\tExtended Size: 0x%08x\n", table->ext_size);
 	printf("\tConfigured Memory Speed: 0x%04x\n", table->config_mem_speed);
+	if (table->hdr.length < SMBIOS_TYPE17_LENGTH_V28)
+		return;
 	printf("\tMinimum voltage: 0x%04x\n", table->min_voltage);
 	printf("\tMaximum voltage: 0x%04x\n", table->max_voltage);
 	printf("\tConfigured voltage: 0x%04x\n", table->config_voltage);
+	if (table->hdr.length < SMBIOS_TYPE17_LENGTH_V32)
+		return;
 	smbios_print_lookup_str(md_tech_strings, table->mem_tech,
 				ARRAY_SIZE(md_tech_strings),
 				"Memory Technology");
@@ -671,6 +708,8 @@ static void smbios_print_type17(struct smbios_type17 *table)
 	printf("\tVolatile Size: 0x%016llx\n", table->volatile_size);
 	printf("\tCache Size: 0x%016llx\n", table->cache_size);
 	printf("\tLogical Size: 0x%016llx\n", table->logical_size);
+	if (table->hdr.length < SMBIOS_TYPE17_LENGTH_V33)
+		return;
 	printf("\tExtended Speed: 0x%04x\n", table->ext_speed);
 	printf("\tExtended Configured Memory Speed: 0x%04x\n",
 	       table->ext_config_mem_speed);
@@ -683,10 +722,14 @@ static void smbios_print_type17(struct smbios_type17 *table)
 static void smbios_print_type19(struct smbios_type19 *table)
 {
 	printf("Memory Array Mapped Address:\n");
+	if (table->hdr.length < SMBIOS_TYPE19_LENGTH_V21)
+		return;
 	printf("\tStarting Address: 0x%08x\n", table->start_addr);
 	printf("\tEnding Address: 0x%08x\n", table->end_addr);
 	printf("\tMemory Array Handle: 0x%04x\n", table->mem_array_hdl);
 	printf("\tPartition Width: 0x%04x\n", table->partition_wid);
+	if (table->hdr.length < SMBIOS_TYPE19_LENGTH_V27)
+		return;
 	printf("\tExtended Starting Address: 0x%016llx\n", table->ext_start_addr);
 	printf("\tExtended Ending Address: 0x%016llx\n", table->ext_end_addr);
 }
diff --git a/include/smbios.h b/include/smbios.h
index a0e47d51852..14a7d8e6c30 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -110,10 +110,42 @@ struct __packed smbios_type0 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
+#define SMBIOS_TYPE0_LENGTH_V24		0x18
+#define SMBIOS_TYPE0_LENGTH_V31		0x1a
+
 #define SMBIOS_TYPE1_LENGTH_V20		0x08
 #define SMBIOS_TYPE1_LENGTH_V21		0x19
 #define SMBIOS_TYPE1_LENGTH_V24		0x1b
 
+#define SMBIOS_TYPE4_LENGTH_V20		0x1a
+#define SMBIOS_TYPE4_LENGTH_V23		0x23
+#define SMBIOS_TYPE4_LENGTH_V25		0x28
+#define SMBIOS_TYPE4_LENGTH_V26		0x2a
+#define SMBIOS_TYPE4_LENGTH_V30		0x30
+#define SMBIOS_TYPE4_LENGTH_V36		0x32
+
+#define SMBIOS_TYPE7_LENGTH_V20		0x0f
+#define SMBIOS_TYPE7_LENGTH_V21		0x13
+#define SMBIOS_TYPE7_LENGTH_V31		0x1b
+
+#define SMBIOS_TYPE9_LENGTH_V20		0x0c
+#define SMBIOS_TYPE9_LENGTH_V21		0x0d
+#define SMBIOS_TYPE9_LENGTH_V26		0x11
+
+#define SMBIOS_TYPE16_LENGTH_V21	0x0f
+#define SMBIOS_TYPE16_LENGTH_V27	0x17
+
+#define SMBIOS_TYPE17_LENGTH_V21	0x15
+#define SMBIOS_TYPE17_LENGTH_V23	0x1b
+#define SMBIOS_TYPE17_LENGTH_V26	0x1c
+#define SMBIOS_TYPE17_LENGTH_V27	0x22
+#define SMBIOS_TYPE17_LENGTH_V28	0x28
+#define SMBIOS_TYPE17_LENGTH_V32	0x54
+#define SMBIOS_TYPE17_LENGTH_V33	0x5c
+
+#define SMBIOS_TYPE19_LENGTH_V21	0x0f
+#define SMBIOS_TYPE19_LENGTH_V27	0x1f
+
 struct __packed smbios_type1 {
 	struct smbios_header hdr;
 	u8 manufacturer;
-- 
2.25.1

