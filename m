Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17295C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 15:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3ABA87B72;
	Wed, 17 Jan 2024 16:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CZ50Evjh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03ED387707; Wed, 17 Jan 2024 16:34:08 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DACF879F4
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 16:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3BB893F274
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705505638;
 bh=7Z0uuAe9C+bnxkBLrKDqqIaz78wny9RzW4yrDZRENO0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=CZ50EvjhUUFSNM4rIZIBcvA5CeR0LnfTRXqgTfQPOfAc3FTTOTIsUsJ/UaVd8qIyt
 16EMdSxusShGHkmnJRAp7ueh7gIMWDRR4tURyQYfakCk5u27SB0bAiHUriVWPr8LL7
 QqP3LC6FwedWcnTc09W6JiVS1LD/lCUCbZEMG8ZGC+34gT6IcAjpzu1/Hwrcf54zus
 WZliw44ghLUwRQWiDApMN11pxpJvpJ7brAGTutAw4alG60r1nUQkbvlIIcCYHq/XNx
 mfIpgMMiNPw4ID7eg3ns5ToNWGnB33LKmnhcQj6g0Q1+xE43y1VHYlw9vuyVuf/+YE
 CRDMa8C7ngu0g==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-337c79755eeso17604f8f.2
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 07:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705505638; x=1706110438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Z0uuAe9C+bnxkBLrKDqqIaz78wny9RzW4yrDZRENO0=;
 b=ZwPsMmawmSH4PCr5gICcyM39WhBkzMvmKu3MR7yB/wtTxs8+mqd7zEjDdWip/lddr7
 OBphldEiM5x13k3SP20k6nl1HhKQMgrCj2BjWCIMiRf5I6+wD6wnlpHzuUx6iJGj6rAx
 rrPnhUmCwkWT1grj03ZFUlCeXWqcmn8J3grBvrmyv5u6tJA5nH2u9ouUDN197HBIxIG8
 9lktgHI1y9d0YInUJ9DfVE8q2hXAG4P2g0K4ajSoqw9P2j0c+wLEY9wR/z9a9GcgZkgT
 +h9ffMt14GjcIpsKjqyllo4DYBZTQg7p61ZMx7VaVN8e5+FZjvCJKsuAYDLq6I6WWQE8
 mAhQ==
X-Gm-Message-State: AOJu0YxF67LNzYK/fnu2vj3mPdUWuaurhiFVw06P9VIV/TxYE6DjcBfq
 UQu8bwSq4sFJl1lGZeVjXYdWIyuL1Zlr3X17AmSC8LHcxZnMDdW7v1+azmGvF/t9/4f3lzOgI3K
 Idvdd6DEp+QxfVtLCvU8hD5F/Qkuza+E12WMBig==
X-Received: by 2002:a5d:50c9:0:b0:337:5bf0:d92f with SMTP id
 f9-20020a5d50c9000000b003375bf0d92fmr5480352wrt.73.1705505637787; 
 Wed, 17 Jan 2024 07:33:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAtvJiESXixVFgiL1Rm30qes54V5ZUztbxblVebfZLbqZmTbvn3Mq1SMOUiCp8pldmS6unjQ==
X-Received: by 2002:a5d:50c9:0:b0:337:5bf0:d92f with SMTP id
 f9-20020a5d50c9000000b003375bf0d92fmr5480343wrt.73.1705505637437; 
 Wed, 17 Jan 2024 07:33:57 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a5d4f07000000b00337876596d1sm1897499wru.111.2024.01.17.07.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 07:33:57 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/4] cmd: provide command to display SMBIOS information
Date: Wed, 17 Jan 2024 16:33:45 +0100
Message-ID: <20240117153347.85074-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
References: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
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

U-Boot can either generated an SMBIOS table or copy it from a prior boot
stage, e.g. QEMU.

Provide a command to display the SMBIOS information.

Currently only type 1 and 2 are translated to human readable text.
Other types may be added later. Currently only a hexdump and the list of
strings is provided for these.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
	email address updated
---
 cmd/Kconfig  |   7 ++
 cmd/Makefile |   1 +
 cmd/smbios.c | 191 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 cmd/smbios.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 26aeeeed03b..43c9c20c8fa 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -227,6 +227,13 @@ config CMD_SBI
 	help
 	  Display information about the SBI implementation.
 
+config CMD_SMBIOS
+	bool "smbios"
+	depends on SMBIOS
+	default y
+	help
+	  Display the SMBIOS information.
+
 endmenu
 
 menu "Boot commands"
diff --git a/cmd/Makefile b/cmd/Makefile
index e2a2b16ab25..87133cc27a8 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -168,6 +168,7 @@ obj-$(CONFIG_CMD_SETEXPR) += setexpr.o
 obj-$(CONFIG_CMD_SETEXPR_FMT) += printf.o
 obj-$(CONFIG_CMD_SPI) += spi.o
 obj-$(CONFIG_CMD_STRINGS) += strings.o
+obj-$(CONFIG_CMD_SMBIOS) += smbios.o
 obj-$(CONFIG_CMD_SMC) += smccc.o
 obj-$(CONFIG_CMD_SYSBOOT) += sysboot.o
 obj-$(CONFIG_CMD_STACKPROTECTOR_TEST) += stackprot_test.o
diff --git a/cmd/smbios.c b/cmd/smbios.c
new file mode 100644
index 00000000000..63f908e92ce
--- /dev/null
+++ b/cmd/smbios.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * The 'smbios' command displays information from the SMBIOS table.
+ *
+ * Copyright (c) 2023, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+ */
+
+#include <command.h>
+#include <hexdump.h>
+#include <mapmem.h>
+#include <smbios.h>
+#include <tables_csum.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/**
+ * smbios_get_string() - get SMBIOS string from table
+ *
+ * @table:	SMBIOS table
+ * @index:	index of the string
+ * Return:	address of string, may point to empty string
+ */
+static const char *smbios_get_string(void *table, int index)
+{
+	const char *str = (char *)table +
+			  ((struct smbios_header *)table)->length;
+
+	if (!*str)
+		++str;
+	for (--index; *str && index; --index)
+		str += strlen(str) + 1;
+
+	return str;
+}
+
+static struct smbios_header *next_table(struct smbios_header *table)
+{
+	const char *str;
+
+	if (table->type == SMBIOS_END_OF_TABLE)
+		return NULL;
+
+	str = smbios_get_string(table, 0);
+	return (struct smbios_header *)(++str);
+}
+
+static void smbios_print_generic(struct smbios_header *table)
+{
+	char *str = (char *)table + table->length;
+
+	if (CONFIG_IS_ENABLED(HEXDUMP)) {
+		printf("Header and Data:\n");
+		print_hex_dump("\t", DUMP_PREFIX_OFFSET, 16, 1,
+			       table, table->length, false);
+	}
+	if (*str) {
+		printf("Strings:\n");
+		for (int index = 1; *str; ++index) {
+			printf("\tString %u: %s\n", index, str);
+			str += strlen(str) + 1;
+		}
+	}
+}
+
+void smbios_print_str(const char *label, void *table, u8 index)
+{
+	printf("\t%s: %s\n", label, smbios_get_string(table, index));
+}
+
+static void smbios_print_type1(struct smbios_type1 *table)
+{
+	printf("System Information\n");
+	smbios_print_str("Manufacturer", table, table->manufacturer);
+	smbios_print_str("Product Name", table, table->product_name);
+	smbios_print_str("Version", table, table->version);
+	smbios_print_str("Serial Number", table, table->serial_number);
+	if (table->length >= 0x19) {
+		printf("\tUUID %pUl\n", table->uuid);
+		smbios_print_str("Wake Up Type", table, table->serial_number);
+	}
+	if (table->length >= 0x1b) {
+		smbios_print_str("Serial Number", table, table->serial_number);
+		smbios_print_str("SKU Number", table, table->sku_number);
+	}
+}
+
+static void smbios_print_type2(struct smbios_type2 *table)
+{
+	u16 *handle;
+
+	printf("Base Board Information\n");
+	smbios_print_str("Manufacturer", table, table->manufacturer);
+	smbios_print_str("Product Name", table, table->product_name);
+	smbios_print_str("Version", table, table->version);
+	smbios_print_str("Serial Number", table, table->serial_number);
+	smbios_print_str("Asset Tag", table, table->asset_tag_number);
+	printf("\tFeature Flags: 0x%2x\n", table->feature_flags);
+	smbios_print_str("Chassis Location", table, table->chassis_location);
+	printf("\tChassis Handle: 0x%2x\n", table->chassis_handle);
+	smbios_print_str("Board Type", table, table->board_type);
+	printf("\tContained Object Handles: ");
+	handle = (void *)table->eos;
+	for (int i = 0; i < table->number_contained_objects; ++i)
+		printf("0x%04x ", handle[i]);
+	printf("\n");
+}
+
+static void smbios_print_type127(struct smbios_type127 *table)
+{
+	printf("End Of Table\n");
+}
+
+static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[])
+{
+	ulong addr;
+	void *entry;
+	u32 size;
+	char version[12];
+	struct smbios_header *table;
+	static const char smbios_sig[] = "_SM_";
+	static const char smbios3_sig[] = "_SM3_";
+	size_t count = 0;
+	u32 max_struct_size;
+
+	addr = gd_smbios_start();
+	if (!addr) {
+		log_warning("SMBIOS not available\n");
+		return CMD_RET_FAILURE;
+	}
+	entry = map_sysmem(addr, 0);
+	if (!memcmp(entry, smbios3_sig, sizeof(smbios3_sig) - 1)) {
+		struct smbios3_entry *entry3 = entry;
+
+		table = (void *)(uintptr_t)entry3->struct_table_address;
+		snprintf(version, sizeof(version), "%d.%d.%d",
+			 entry3->major_ver, entry3->minor_ver, entry3->doc_rev);
+		table = (void *)(uintptr_t)entry3->struct_table_address;
+		size = entry3->length;
+		max_struct_size = entry3->max_struct_size;
+	} else if (!memcmp(entry, smbios_sig, sizeof(smbios_sig) - 1)) {
+		struct smbios_entry *entry2 = entry;
+
+		snprintf(version, sizeof(version), "%d.%d",
+			 entry2->major_ver, entry2->minor_ver);
+		table = (void *)(uintptr_t)entry2->struct_table_address;
+		size = entry2->length;
+		max_struct_size = entry2->max_struct_size;
+	} else {
+		log_err("Unknown SMBIOS anchor format\n");
+		return CMD_RET_FAILURE;
+	}
+	if (table_compute_checksum(entry, size)) {
+		log_err("Invalid anchor checksum\n");
+		return CMD_RET_FAILURE;
+	}
+	printf("SMBIOS %s present.\n", version);
+
+	for (struct smbios_header *pos = table; pos; pos = next_table(pos))
+		++count;
+	printf("%zd structures occupying %d bytes\n", count, max_struct_size);
+	printf("Table at 0x%llx\n", (unsigned long long)map_to_sysmem(table));
+
+	for (struct smbios_header *pos = table; pos; pos = next_table(pos)) {
+		printf("\nHandle 0x%04x, DMI type %d, %d bytes at 0x%llx\n",
+		       pos->handle, pos->type, pos->length,
+		       (unsigned long long)map_to_sysmem(pos));
+		switch (pos->type) {
+		case 1:
+			smbios_print_type1((struct smbios_type1 *)pos);
+			break;
+		case 2:
+			smbios_print_type2((struct smbios_type2 *)pos);
+			break;
+		case 127:
+			smbios_print_type127((struct smbios_type127 *)pos);
+			break;
+		default:
+			smbios_print_generic(pos);
+			break;
+		}
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_LONGHELP(smbios, "- display SMBIOS information");
+
+U_BOOT_CMD(smbios, 1, 0, do_smbios, "display SMBIOS information",
+	   smbios_help_text);
-- 
2.43.0

