Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425A9C43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 13:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EE72846F8;
	Sat, 11 Jul 2026 15:24:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GMYHumnh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AB8D841F2; Sat, 11 Jul 2026 11:16:19 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3EBD83EEF
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 11:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0FC413F129
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 09:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783761375;
 bh=vMpVBpKVGY3O+IUcpyIS0dEG+UHHTPEdTTviCkiHyNE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=GMYHumnhBkvHmCG70Y9448Uzcgbf+CleUviSDv2nbRMt8d/lN9gcOnxOao4/cGfz8
 BTghDqJpj5P90Sc+3j9Pwt2LjC1pstOHua0k0/AwN6yBp7xU/1s/v2IUWcvLnFDaPo
 kIbxVr+PfYrGLAYKENWsy2EwAj/KBaA4I3qkKpDn50N60PGNbAw4yEqmR+mim/kTrV
 dZPxdVwnr+06GrauoQfw2Zb4zwhfl44RXwVYwszptJoUOkDmUe3YZmOZ7eKsPTJSRN
 3cjhNHORl9+GSwCDXt7RpIBrawc/iwDeDhhEl7WX20kuTXPS4IiVdY52x+bKQXxRf6
 O5WHzxP4SjLFZA4KShwyGVH8ImNXtI9rQtqIOrVB57UJZ0VlkmOynMXmZsbpAtgIYw
 JUImPYqurbVVncfpcSRsWhLRsxuDaRhB6nVTtvCBtrxpUrr+tu4E+jhgDhTuYrOxWh
 9kxZ6J3bJ/rhJEf2y1F1wTrWw7CldpKBMEeipawMK33eWJYZH2YsT9Ne92qeOEQPdU
 06zuZRxw8/XjtJDlmQxawBJPyWwBmI/uyXDepyz6/hJfN2V2viV9CE2ac1VYcu8rVm
 mMKSIq5HDJh0bh4YcMpKi3SCbARQJADXPicZx4eWol1Tej5LnF8M6PQMsBrz7cmxw0
 aqe8xh37K/qKgtm1IOcXcmT4=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc6dd43737so36196035ad.2
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 02:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783761373; x=1784366173;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vMpVBpKVGY3O+IUcpyIS0dEG+UHHTPEdTTviCkiHyNE=;
 b=mh/MX403XAVCCC0gY4oUb6nRn2w+u20cd5rn/Al0z9k17uZXI7lbCAmj4dZU6PMyho
 4qKI0GZNdPKXk7NMRw3q0W2bpKC7/0coIe26KNvy6xvH/OXvBYhOk08C2JLZxbx2uDHs
 rJbCqHi+9/lbp8LqhbtvRi4EBgTfGRPFAQVDywr8YMsMXdY5R8fKxlQeVMaZSDB5NS9g
 6Ifgp1UGbE5FEUVN5x0CuTCPcc5l+9yOVtQ/FdyQAM3z6uaclCjSKYch38XbIDsRjZ/g
 BLGCAMuMyE7a3eavYQpDpokYagEIsVmpmkzLqg76C/UZnV6vbdMod1o/vBtnbrmoXTBD
 7Uhg==
X-Gm-Message-State: AOJu0Yy+59jG1ssHpFqw22KJ15woZ1mt4mUKWgMSyE1CRvLIJ6FjfSfW
 cjdOzORwB2yNWr5sK9Qdv5Y9tRvygvJGesTdwgtTryq6N2PP55qy4au1jV/Zscoibexr5hZ0l5m
 6vXvkV+0pR/9TP3I134p76TZftdL7DXRB8ted9bVcptFRuVC74Pc+MCg5G6mEMnxRCB3oTbvJEW
 bxHvd2SQ==
X-Gm-Gg: AfdE7cnWr6evJRqBws1/tHlOXawEiU3cTOjlZwMSllipYtEPMNSe3IrHpJb9DsTSAYp
 91MyStavV2TPqojGr4Fq5r7K2a92WUq/nNXkYf1k6dBkHwfl7raEdicFkvR4KVUnY19cYslAABB
 Wbjcaa1rK0OpLlkr5hAqmIYMtNqloJw2p27LmH4saRUJUFdHqAA827q5cITjG2nab1xTmIvT07q
 NxM/mx2k9sjWFcftV7papeJHHu+IM4Nbu398DoxR6OfjY+ynX+b9E5eLQLiflmm4kfyWQXG/jgJ
 R3T8afupNZuKkbr6W+LE4PFtmhtUMkE+tjR5bIQyd59rfRkLlQJ0I6TV845omg+cXGCXGF9w+xt
 zTeEyNdPYxa/vXuBBqOWIM9MlXO4sDNDpUoDnz8n9RNrudKIpq7ZsioKnboSpjXl05wt2M0Zi/5
 /FmxZz
X-Received: by 2002:a17:903:b0c:b0:2cc:5fae:cc56 with SMTP id
 d9443c01a7336-2ce9ef14e00mr24253525ad.27.1783761373264; 
 Sat, 11 Jul 2026 02:16:13 -0700 (PDT)
X-Received: by 2002:a17:903:b0c:b0:2cc:5fae:cc56 with SMTP id
 d9443c01a7336-2ce9ef14e00mr24253195ad.27.1783761372611; 
 Sat, 11 Jul 2026 02:16:12 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ce8f5183b9sm19650495ad.5.2026.07.11.02.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 02:16:12 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v1 1/1] efi: Unify memory map type and attribute names
Date: Sat, 11 Jul 2026 09:15:36 +0000
Message-ID: <20260711091559.1842381-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Jul 2026 15:24:10 +0200
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

The efi and efidebug commands each carry their own table of EFI memory
type names and memory attribute names. The two copies have drifted:
efidebug knows EFI_PERSISTENT_MEMORY_TYPE while 'efi mem' prints it as
'<invalid>', and neither table knows EFI_UNACCEPTED_MEMORY_TYPE.

Move a single copy of both tables into efi_common.c, which is already
linked into both commands, and provide efi_mem_type_name() and
efi_print_mem_attrs() accessors. Add the two missing memory types.

The output of 'efi mem' now uses the same names as efidebug, for
example PAL instead of pal_code, and its attributes key now lists the
attribute mnemonics instead of long names. The efidebug memmap name
ACPI RECLAIM MEM becomes ACPI RECLAIM so that the shared name also fits
the narrower column of 'efi mem'. Update the examples in the efi
command documentation accordingly.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 cmd/efi.c             |  53 +---------
 cmd/efi_common.c      |  64 ++++++++++++
 cmd/efidebug.c        |  69 +-----------
 doc/usage/cmd/efi.rst | 238 +++++++++++++++++++++---------------------
 include/efi.h         |  19 ++++
 5 files changed, 207 insertions(+), 236 deletions(-)

diff --git a/cmd/efi.c b/cmd/efi.c
index 687ccb52042..fc8f1d511c0 100644
--- a/cmd/efi.c
+++ b/cmd/efi.c
@@ -16,42 +16,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-static const char *const type_name[] = {
-	"reserved",
-	"loader_code",
-	"loader_data",
-	"bs_code",
-	"bs_data",
-	"rt_code",
-	"rt_data",
-	"conv",
-	"unusable",
-	"acpi_reclaim",
-	"acpi_nvs",
-	"io",
-	"io_port",
-	"pal_code",
-};
-
-static struct attr_info {
-	u64 val;
-	const char *name;
-} mem_attr[] = {
-	{ EFI_MEMORY_UC, "uncached" },
-	{ EFI_MEMORY_WC, "write-coalescing" },
-	{ EFI_MEMORY_WT, "write-through" },
-	{ EFI_MEMORY_WB, "write-back" },
-	{ EFI_MEMORY_UCE, "uncached & exported" },
-	{ EFI_MEMORY_WP, "write-protect" },
-	{ EFI_MEMORY_RP, "read-protect" },
-	{ EFI_MEMORY_XP, "execute-protect" },
-	{ EFI_MEMORY_NV, "non-volatile" },
-	{ EFI_MEMORY_MORE_RELIABLE, "higher reliability" },
-	{ EFI_MEMORY_RO, "read-only" },
-	{ EFI_MEMORY_SP, "specific purpose" },
-	{ EFI_MEMORY_RUNTIME, "needs runtime mapping" }
-};
-
 /* Maximum different attribute values we can track */
 #define ATTR_SEEN_MAX	30
 
@@ -175,8 +139,7 @@ static void efi_print_mem_table(struct efi_mem_desc *desc, int desc_size,
 		}
 		size = desc->num_pages << EFI_PAGE_SHIFT;
 
-		name = desc->type < ARRAY_SIZE(type_name) ?
-				type_name[desc->type] : "<invalid>";
+		name = efi_mem_type_name(desc->type) ?: "<invalid>";
 		printf("%2d  %x:%-12s  %010llx  %010llx  %010llx  ", upto,
 		       desc->type, name, desc->physical_start,
 		       desc->virtual_start, size);
@@ -197,20 +160,10 @@ static void efi_print_mem_table(struct efi_mem_desc *desc, int desc_size,
 	printf("\nAttributes key:\n");
 	for (i = 0; i < attr_seen_count; i++) {
 		u64 attr = attr_seen[i];
-		bool first;
-		int j;
 
-		printf("%c%llx: ", (attr & EFI_MEMORY_RUNTIME) ? 'r' : ' ',
+		printf("%c%llx:", (attr & EFI_MEMORY_RUNTIME) ? 'r' : ' ',
 		       attr & ~EFI_MEMORY_RUNTIME);
-		for (j = 0, first = true; j < ARRAY_SIZE(mem_attr); j++) {
-			if (attr & mem_attr[j].val) {
-				if (first)
-					first = false;
-				else
-					printf(", ");
-				printf("%s", mem_attr[j].name);
-			}
-		}
+		efi_print_mem_attrs(attr);
 		putc('\n');
 	}
 	if (skip_bs)
diff --git a/cmd/efi_common.c b/cmd/efi_common.c
index d2f2b59e9e3..8df2369add6 100644
--- a/cmd/efi_common.c
+++ b/cmd/efi_common.c
@@ -10,6 +10,46 @@
 #include <efi_api.h>
 #include <u-boot/uuid.h>
 
+static const char *const efi_mem_type_string[] = {
+	[EFI_RESERVED_MEMORY_TYPE] = "RESERVED",
+	[EFI_LOADER_CODE] = "LOADER CODE",
+	[EFI_LOADER_DATA] = "LOADER DATA",
+	[EFI_BOOT_SERVICES_CODE] = "BOOT CODE",
+	[EFI_BOOT_SERVICES_DATA] = "BOOT DATA",
+	[EFI_RUNTIME_SERVICES_CODE] = "RUNTIME CODE",
+	[EFI_RUNTIME_SERVICES_DATA] = "RUNTIME DATA",
+	[EFI_CONVENTIONAL_MEMORY] = "CONVENTIONAL",
+	[EFI_UNUSABLE_MEMORY] = "UNUSABLE MEM",
+	[EFI_ACPI_RECLAIM_MEMORY] = "ACPI RECLAIM",
+	[EFI_ACPI_MEMORY_NVS] = "ACPI NVS",
+	[EFI_MMAP_IO] = "IO",
+	[EFI_MMAP_IO_PORT] = "IO PORT",
+	[EFI_PAL_CODE] = "PAL",
+	[EFI_PERSISTENT_MEMORY_TYPE] = "PERSISTENT",
+	[EFI_UNACCEPTED_MEMORY_TYPE] = "UNACCEPTED",
+};
+
+static const struct efi_mem_attrs {
+	const u64 bit;
+	const char *text;
+} efi_mem_attrs[] = {
+	{EFI_MEMORY_UC, "UC"},
+	{EFI_MEMORY_WC, "WC"},
+	{EFI_MEMORY_WT, "WT"},
+	{EFI_MEMORY_WB, "WB"},
+	{EFI_MEMORY_UCE, "UCE"},
+	{EFI_MEMORY_WP, "WP"},
+	{EFI_MEMORY_RP, "RP"},
+	{EFI_MEMORY_XP, "XP"},
+	{EFI_MEMORY_NV, "NV"},
+	{EFI_MEMORY_MORE_RELIABLE, "REL"},
+	{EFI_MEMORY_RO, "RO"},
+	{EFI_MEMORY_SP, "SP"},
+	{EFI_MEMORY_CPU_CRYPTO, "CRYPT"},
+	{EFI_MEMORY_HOT_PLUGGABLE, "HOTPL"},
+	{EFI_MEMORY_RUNTIME, "RT"},
+};
+
 void efi_show_tables(struct efi_system_table *systab)
 {
 	int i;
@@ -21,3 +61,27 @@ void efi_show_tables(struct efi_system_table *systab)
 		       uuid_guid_get_str(tab->guid.b) ?: "(unknown)");
 	}
 }
+
+const char *efi_mem_type_name(u32 type)
+{
+	if (type >= ARRAY_SIZE(efi_mem_type_string))
+		return NULL;
+
+	return efi_mem_type_string[type];
+}
+
+void efi_print_mem_attrs(u64 attributes)
+{
+	int sep, i;
+
+	for (sep = 0, i = 0; i < ARRAY_SIZE(efi_mem_attrs); i++)
+		if (attributes & efi_mem_attrs[i].bit) {
+			if (sep) {
+				putc('|');
+			} else {
+				putc(' ');
+				sep = 1;
+			}
+			puts(efi_mem_attrs[i].text);
+		}
+}
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index a6faa36b500..7d0c56ce265 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -574,68 +574,6 @@ static int do_efi_show_ecpt(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 #endif /* CONFIG_IS_ENABLED(EFI_ECPT) */
 
-static const char * const efi_mem_type_string[] = {
-	[EFI_RESERVED_MEMORY_TYPE] = "RESERVED",
-	[EFI_LOADER_CODE] = "LOADER CODE",
-	[EFI_LOADER_DATA] = "LOADER DATA",
-	[EFI_BOOT_SERVICES_CODE] = "BOOT CODE",
-	[EFI_BOOT_SERVICES_DATA] = "BOOT DATA",
-	[EFI_RUNTIME_SERVICES_CODE] = "RUNTIME CODE",
-	[EFI_RUNTIME_SERVICES_DATA] = "RUNTIME DATA",
-	[EFI_CONVENTIONAL_MEMORY] = "CONVENTIONAL",
-	[EFI_UNUSABLE_MEMORY] = "UNUSABLE MEM",
-	[EFI_ACPI_RECLAIM_MEMORY] = "ACPI RECLAIM MEM",
-	[EFI_ACPI_MEMORY_NVS] = "ACPI NVS",
-	[EFI_MMAP_IO] = "IO",
-	[EFI_MMAP_IO_PORT] = "IO PORT",
-	[EFI_PAL_CODE] = "PAL",
-	[EFI_PERSISTENT_MEMORY_TYPE] = "PERSISTENT",
-};
-
-static const struct efi_mem_attrs {
-	const u64 bit;
-	const char *text;
-} efi_mem_attrs[] = {
-	{EFI_MEMORY_UC, "UC"},
-	{EFI_MEMORY_WC, "WC"},
-	{EFI_MEMORY_WT, "WT"},
-	{EFI_MEMORY_WB, "WB"},
-	{EFI_MEMORY_UCE, "UCE"},
-	{EFI_MEMORY_WP, "WP"},
-	{EFI_MEMORY_RP, "RP"},
-	{EFI_MEMORY_XP, "XP"},
-	{EFI_MEMORY_NV, "NV"},
-	{EFI_MEMORY_MORE_RELIABLE, "REL"},
-	{EFI_MEMORY_RO, "RO"},
-	{EFI_MEMORY_SP, "SP"},
-	{EFI_MEMORY_CPU_CRYPTO, "CRYPT"},
-	{EFI_MEMORY_HOT_PLUGGABLE, "HOTPL"},
-	{EFI_MEMORY_RUNTIME, "RT"},
-};
-
-/**
- * print_memory_attributes() - print memory map attributes
- *
- * @attributes:	Attribute value
- *
- * Print memory map attributes
- */
-static void print_memory_attributes(u64 attributes)
-{
-	int sep, i;
-
-	for (sep = 0, i = 0; i < ARRAY_SIZE(efi_mem_attrs); i++)
-		if (attributes & efi_mem_attrs[i].bit) {
-			if (sep) {
-				putc('|');
-			} else {
-				putc(' ');
-				sep = 1;
-			}
-			puts(efi_mem_attrs[i].text);
-		}
-}
-
 #define EFI_PHYS_ADDR_WIDTH (int)(sizeof(efi_physical_addr_t) * 2)
 
 /**
@@ -673,10 +611,7 @@ static int do_efi_show_memmap(struct cmd_tbl *cmdtp, int flag,
 	 * populated by allocate_pool() above.
 	 */
 	for (i = 0, map = memmap; i < map_size / sizeof(*map); map++, i++) {
-		if (map->type < ARRAY_SIZE(efi_mem_type_string))
-			type = efi_mem_type_string[map->type];
-		else
-			type = "(unknown)";
+		type = efi_mem_type_name(map->type) ?: "(unknown)";
 
 		printf("%-16s %.*llx-%.*llx", type,
 		       EFI_PHYS_ADDR_WIDTH,
@@ -687,7 +622,7 @@ static int do_efi_show_memmap(struct cmd_tbl *cmdtp, int flag,
 					  (map->physical_start +
 					   map->num_pages * EFI_PAGE_SIZE)));
 
-		print_memory_attributes(map->attribute);
+		efi_print_mem_attrs(map->attribute);
 		putc('\n');
 	}
 
diff --git a/doc/usage/cmd/efi.rst b/doc/usage/cmd/efi.rst
index b19d36188a9..b8b029f4dd2 100644
--- a/doc/usage/cmd/efi.rst
+++ b/doc/usage/cmd/efi.rst
@@ -74,139 +74,139 @@ Example
     => efi mem
     EFI table at 0, memory map 000000001ad38b60, size 1260, key a79, version 1, descr. size 0x30
      #  Type              Physical     Virtual        Size  Attributes
-     0  7:conv          0000000000  0000000000  00000a0000  f
+     0  7:CONVENTIONAL  0000000000  0000000000  00000a0000  f
         <gap>           00000a0000              0000060000
-     1  7:conv          0000100000  0000000000  0000700000  f
-     2  a:acpi_nvs      0000800000  0000000000  0000008000  f
-     3  7:conv          0000808000  0000000000  0000008000  f
-     4  a:acpi_nvs      0000810000  0000000000  00000f0000  f
-     5  7:conv          0000900000  0000000000  001efef000  f
-     6  6:rt_data       001f8ef000  0000000000  0000100000  rf
-     7  5:rt_code       001f9ef000  0000000000  0000100000  rf
-     8  0:reserved      001faef000  0000000000  0000080000  f
-     9  9:acpi_reclaim  001fb6f000  0000000000  0000010000  f
-    10  a:acpi_nvs      001fb7f000  0000000000  0000080000  f
-    11  7:conv          001fbff000  0000000000  0000359000  f
-    12  6:rt_data       001ff58000  0000000000  0000020000  rf
-    13  a:acpi_nvs      001ff78000  0000000000  0000088000  f
+     1  7:CONVENTIONAL  0000100000  0000000000  0000700000  f
+     2  a:ACPI NVS      0000800000  0000000000  0000008000  f
+     3  7:CONVENTIONAL  0000808000  0000000000  0000008000  f
+     4  a:ACPI NVS      0000810000  0000000000  00000f0000  f
+     5  7:CONVENTIONAL  0000900000  0000000000  001efef000  f
+     6  6:RUNTIME DATA  001f8ef000  0000000000  0000100000  rf
+     7  5:RUNTIME CODE  001f9ef000  0000000000  0000100000  rf
+     8  0:RESERVED      001faef000  0000000000  0000080000  f
+     9  9:ACPI RECLAIM  001fb6f000  0000000000  0000010000  f
+    10  a:ACPI NVS      001fb7f000  0000000000  0000080000  f
+    11  7:CONVENTIONAL  001fbff000  0000000000  0000359000  f
+    12  6:RUNTIME DATA  001ff58000  0000000000  0000020000  rf
+    13  a:ACPI NVS      001ff78000  0000000000  0000088000  f
         <gap>           0020000000              0090000000
-    14  0:reserved      00b0000000  0000000000  0010000000  1
+    14  0:RESERVED      00b0000000  0000000000  0010000000  1
 
     Attributes key:
-     f: uncached, write-coalescing, write-through, write-back
-    rf: uncached, write-coalescing, write-through, write-back, needs runtime mapping
-     1: uncached
+     f: UC|WC|WT|WB
+    rf: UC|WC|WT|WB|RT
+     1: UC
     *Some areas are merged (use 'all' to see)
 
 
     => efi mem  all
     EFI table at 0, memory map 000000001ad38bb0, size 1260, key a79, version 1, descr. size 0x30
      #  Type              Physical     Virtual        Size  Attributes
-     0  3:bs_code       0000000000  0000000000  0000001000  f
-     1  7:conv          0000001000  0000000000  000009f000  f
+     0  3:BOOT CODE     0000000000  0000000000  0000001000  f
+     1  7:CONVENTIONAL  0000001000  0000000000  000009f000  f
         <gap>           00000a0000              0000060000
-     2  7:conv          0000100000  0000000000  0000700000  f
-     3  a:acpi_nvs      0000800000  0000000000  0000008000  f
-     4  7:conv          0000808000  0000000000  0000008000  f
-     5  a:acpi_nvs      0000810000  0000000000  00000f0000  f
-     6  4:bs_data       0000900000  0000000000  0000c00000  f
-     7  7:conv          0001500000  0000000000  000aa36000  f
-     8  2:loader_data   000bf36000  0000000000  0010000000  f
-     9  4:bs_data       001bf36000  0000000000  0000020000  f
-    10  7:conv          001bf56000  0000000000  00021e1000  f
-    11  1:loader_code   001e137000  0000000000  00000c4000  f
-    12  7:conv          001e1fb000  0000000000  000009b000  f
-    13  1:loader_code   001e296000  0000000000  00000e2000  f
-    14  7:conv          001e378000  0000000000  000005b000  f
-    15  4:bs_data       001e3d3000  0000000000  000001e000  f
-    16  7:conv          001e3f1000  0000000000  0000016000  f
-    17  4:bs_data       001e407000  0000000000  0000016000  f
-    18  2:loader_data   001e41d000  0000000000  0000002000  f
-    19  4:bs_data       001e41f000  0000000000  0000828000  f
-    20  3:bs_code       001ec47000  0000000000  0000045000  f
-    21  4:bs_data       001ec8c000  0000000000  0000001000  f
-    22  3:bs_code       001ec8d000  0000000000  000000e000  f
-    23  4:bs_data       001ec9b000  0000000000  0000001000  f
-    24  3:bs_code       001ec9c000  0000000000  000002c000  f
-    25  4:bs_data       001ecc8000  0000000000  0000001000  f
-    26  3:bs_code       001ecc9000  0000000000  000000c000  f
-    27  4:bs_data       001ecd5000  0000000000  0000006000  f
-    28  3:bs_code       001ecdb000  0000000000  0000014000  f
-    29  4:bs_data       001ecef000  0000000000  0000001000  f
-    30  3:bs_code       001ecf0000  0000000000  000005b000  f
-    31  4:bs_data       001ed4b000  0000000000  000000b000  f
-    32  3:bs_code       001ed56000  0000000000  0000024000  f
-    33  4:bs_data       001ed7a000  0000000000  0000006000  f
-    34  3:bs_code       001ed80000  0000000000  0000010000  f
-    35  4:bs_data       001ed90000  0000000000  0000002000  f
-    36  3:bs_code       001ed92000  0000000000  0000025000  f
-    37  4:bs_data       001edb7000  0000000000  0000003000  f
-    38  3:bs_code       001edba000  0000000000  0000011000  f
-    39  4:bs_data       001edcb000  0000000000  0000008000  f
-    40  3:bs_code       001edd3000  0000000000  000002d000  f
-    41  4:bs_data       001ee00000  0000000000  0000201000  f
-    42  3:bs_code       001f001000  0000000000  0000024000  f
-    43  4:bs_data       001f025000  0000000000  0000002000  f
-    44  3:bs_code       001f027000  0000000000  0000009000  f
-    45  4:bs_data       001f030000  0000000000  0000005000  f
-    46  3:bs_code       001f035000  0000000000  000002f000  f
-    47  4:bs_data       001f064000  0000000000  0000001000  f
-    48  3:bs_code       001f065000  0000000000  0000005000  f
-    49  4:bs_data       001f06a000  0000000000  0000005000  f
-    50  3:bs_code       001f06f000  0000000000  0000007000  f
-    51  4:bs_data       001f076000  0000000000  0000007000  f
-    52  3:bs_code       001f07d000  0000000000  000000d000  f
-    53  4:bs_data       001f08a000  0000000000  0000001000  f
-    54  3:bs_code       001f08b000  0000000000  0000006000  f
-    55  4:bs_data       001f091000  0000000000  0000004000  f
-    56  3:bs_code       001f095000  0000000000  000000d000  f
-    57  4:bs_data       001f0a2000  0000000000  0000003000  f
-    58  3:bs_code       001f0a5000  0000000000  0000026000  f
-    59  4:bs_data       001f0cb000  0000000000  0000005000  f
-    60  3:bs_code       001f0d0000  0000000000  0000019000  f
-    61  4:bs_data       001f0e9000  0000000000  0000004000  f
-    62  3:bs_code       001f0ed000  0000000000  0000024000  f
-    63  4:bs_data       001f111000  0000000000  0000008000  f
-    64  3:bs_code       001f119000  0000000000  000000b000  f
-    65  4:bs_data       001f124000  0000000000  0000001000  f
-    66  3:bs_code       001f125000  0000000000  0000002000  f
-    67  4:bs_data       001f127000  0000000000  0000002000  f
-    68  3:bs_code       001f129000  0000000000  0000009000  f
-    69  4:bs_data       001f132000  0000000000  0000003000  f
-    70  3:bs_code       001f135000  0000000000  0000005000  f
-    71  4:bs_data       001f13a000  0000000000  0000003000  f
-    72  3:bs_code       001f13d000  0000000000  0000005000  f
-    73  4:bs_data       001f142000  0000000000  0000003000  f
-    74  3:bs_code       001f145000  0000000000  0000011000  f
-    75  4:bs_data       001f156000  0000000000  000000b000  f
-    76  3:bs_code       001f161000  0000000000  0000009000  f
-    77  4:bs_data       001f16a000  0000000000  0000400000  f
-    78  3:bs_code       001f56a000  0000000000  0000006000  f
-    79  4:bs_data       001f570000  0000000000  0000001000  f
-    80  3:bs_code       001f571000  0000000000  0000001000  f
-    81  4:bs_data       001f572000  0000000000  0000002000  f
-    82  3:bs_code       001f574000  0000000000  0000017000  f
-    83  4:bs_data       001f58b000  0000000000  0000364000  f
-    84  6:rt_data       001f8ef000  0000000000  0000100000  rf
-    85  5:rt_code       001f9ef000  0000000000  0000100000  rf
-    86  0:reserved      001faef000  0000000000  0000080000  f
-    87  9:acpi_reclaim  001fb6f000  0000000000  0000010000  f
-    88  a:acpi_nvs      001fb7f000  0000000000  0000080000  f
-    89  4:bs_data       001fbff000  0000000000  0000201000  f
-    90  7:conv          001fe00000  0000000000  00000e8000  f
-    91  4:bs_data       001fee8000  0000000000  0000020000  f
-    92  3:bs_code       001ff08000  0000000000  0000026000  f
-    93  4:bs_data       001ff2e000  0000000000  0000009000  f
-    94  3:bs_code       001ff37000  0000000000  0000021000  f
-    95  6:rt_data       001ff58000  0000000000  0000020000  rf
-    96  a:acpi_nvs      001ff78000  0000000000  0000088000  f
+     2  7:CONVENTIONAL  0000100000  0000000000  0000700000  f
+     3  a:ACPI NVS      0000800000  0000000000  0000008000  f
+     4  7:CONVENTIONAL  0000808000  0000000000  0000008000  f
+     5  a:ACPI NVS      0000810000  0000000000  00000f0000  f
+     6  4:BOOT DATA     0000900000  0000000000  0000c00000  f
+     7  7:CONVENTIONAL  0001500000  0000000000  000aa36000  f
+     8  2:LOADER DATA   000bf36000  0000000000  0010000000  f
+     9  4:BOOT DATA     001bf36000  0000000000  0000020000  f
+    10  7:CONVENTIONAL  001bf56000  0000000000  00021e1000  f
+    11  1:LOADER CODE   001e137000  0000000000  00000c4000  f
+    12  7:CONVENTIONAL  001e1fb000  0000000000  000009b000  f
+    13  1:LOADER CODE   001e296000  0000000000  00000e2000  f
+    14  7:CONVENTIONAL  001e378000  0000000000  000005b000  f
+    15  4:BOOT DATA     001e3d3000  0000000000  000001e000  f
+    16  7:CONVENTIONAL  001e3f1000  0000000000  0000016000  f
+    17  4:BOOT DATA     001e407000  0000000000  0000016000  f
+    18  2:LOADER DATA   001e41d000  0000000000  0000002000  f
+    19  4:BOOT DATA     001e41f000  0000000000  0000828000  f
+    20  3:BOOT CODE     001ec47000  0000000000  0000045000  f
+    21  4:BOOT DATA     001ec8c000  0000000000  0000001000  f
+    22  3:BOOT CODE     001ec8d000  0000000000  000000e000  f
+    23  4:BOOT DATA     001ec9b000  0000000000  0000001000  f
+    24  3:BOOT CODE     001ec9c000  0000000000  000002c000  f
+    25  4:BOOT DATA     001ecc8000  0000000000  0000001000  f
+    26  3:BOOT CODE     001ecc9000  0000000000  000000c000  f
+    27  4:BOOT DATA     001ecd5000  0000000000  0000006000  f
+    28  3:BOOT CODE     001ecdb000  0000000000  0000014000  f
+    29  4:BOOT DATA     001ecef000  0000000000  0000001000  f
+    30  3:BOOT CODE     001ecf0000  0000000000  000005b000  f
+    31  4:BOOT DATA     001ed4b000  0000000000  000000b000  f
+    32  3:BOOT CODE     001ed56000  0000000000  0000024000  f
+    33  4:BOOT DATA     001ed7a000  0000000000  0000006000  f
+    34  3:BOOT CODE     001ed80000  0000000000  0000010000  f
+    35  4:BOOT DATA     001ed90000  0000000000  0000002000  f
+    36  3:BOOT CODE     001ed92000  0000000000  0000025000  f
+    37  4:BOOT DATA     001edb7000  0000000000  0000003000  f
+    38  3:BOOT CODE     001edba000  0000000000  0000011000  f
+    39  4:BOOT DATA     001edcb000  0000000000  0000008000  f
+    40  3:BOOT CODE     001edd3000  0000000000  000002d000  f
+    41  4:BOOT DATA     001ee00000  0000000000  0000201000  f
+    42  3:BOOT CODE     001f001000  0000000000  0000024000  f
+    43  4:BOOT DATA     001f025000  0000000000  0000002000  f
+    44  3:BOOT CODE     001f027000  0000000000  0000009000  f
+    45  4:BOOT DATA     001f030000  0000000000  0000005000  f
+    46  3:BOOT CODE     001f035000  0000000000  000002f000  f
+    47  4:BOOT DATA     001f064000  0000000000  0000001000  f
+    48  3:BOOT CODE     001f065000  0000000000  0000005000  f
+    49  4:BOOT DATA     001f06a000  0000000000  0000005000  f
+    50  3:BOOT CODE     001f06f000  0000000000  0000007000  f
+    51  4:BOOT DATA     001f076000  0000000000  0000007000  f
+    52  3:BOOT CODE     001f07d000  0000000000  000000d000  f
+    53  4:BOOT DATA     001f08a000  0000000000  0000001000  f
+    54  3:BOOT CODE     001f08b000  0000000000  0000006000  f
+    55  4:BOOT DATA     001f091000  0000000000  0000004000  f
+    56  3:BOOT CODE     001f095000  0000000000  000000d000  f
+    57  4:BOOT DATA     001f0a2000  0000000000  0000003000  f
+    58  3:BOOT CODE     001f0a5000  0000000000  0000026000  f
+    59  4:BOOT DATA     001f0cb000  0000000000  0000005000  f
+    60  3:BOOT CODE     001f0d0000  0000000000  0000019000  f
+    61  4:BOOT DATA     001f0e9000  0000000000  0000004000  f
+    62  3:BOOT CODE     001f0ed000  0000000000  0000024000  f
+    63  4:BOOT DATA     001f111000  0000000000  0000008000  f
+    64  3:BOOT CODE     001f119000  0000000000  000000b000  f
+    65  4:BOOT DATA     001f124000  0000000000  0000001000  f
+    66  3:BOOT CODE     001f125000  0000000000  0000002000  f
+    67  4:BOOT DATA     001f127000  0000000000  0000002000  f
+    68  3:BOOT CODE     001f129000  0000000000  0000009000  f
+    69  4:BOOT DATA     001f132000  0000000000  0000003000  f
+    70  3:BOOT CODE     001f135000  0000000000  0000005000  f
+    71  4:BOOT DATA     001f13a000  0000000000  0000003000  f
+    72  3:BOOT CODE     001f13d000  0000000000  0000005000  f
+    73  4:BOOT DATA     001f142000  0000000000  0000003000  f
+    74  3:BOOT CODE     001f145000  0000000000  0000011000  f
+    75  4:BOOT DATA     001f156000  0000000000  000000b000  f
+    76  3:BOOT CODE     001f161000  0000000000  0000009000  f
+    77  4:BOOT DATA     001f16a000  0000000000  0000400000  f
+    78  3:BOOT CODE     001f56a000  0000000000  0000006000  f
+    79  4:BOOT DATA     001f570000  0000000000  0000001000  f
+    80  3:BOOT CODE     001f571000  0000000000  0000001000  f
+    81  4:BOOT DATA     001f572000  0000000000  0000002000  f
+    82  3:BOOT CODE     001f574000  0000000000  0000017000  f
+    83  4:BOOT DATA     001f58b000  0000000000  0000364000  f
+    84  6:RUNTIME DATA  001f8ef000  0000000000  0000100000  rf
+    85  5:RUNTIME CODE  001f9ef000  0000000000  0000100000  rf
+    86  0:RESERVED      001faef000  0000000000  0000080000  f
+    87  9:ACPI RECLAIM  001fb6f000  0000000000  0000010000  f
+    88  a:ACPI NVS      001fb7f000  0000000000  0000080000  f
+    89  4:BOOT DATA     001fbff000  0000000000  0000201000  f
+    90  7:CONVENTIONAL  001fe00000  0000000000  00000e8000  f
+    91  4:BOOT DATA     001fee8000  0000000000  0000020000  f
+    92  3:BOOT CODE     001ff08000  0000000000  0000026000  f
+    93  4:BOOT DATA     001ff2e000  0000000000  0000009000  f
+    94  3:BOOT CODE     001ff37000  0000000000  0000021000  f
+    95  6:RUNTIME DATA  001ff58000  0000000000  0000020000  rf
+    96  a:ACPI NVS      001ff78000  0000000000  0000088000  f
         <gap>           0020000000              0090000000
-    97  0:reserved      00b0000000  0000000000  0010000000  1
+    97  0:RESERVED      00b0000000  0000000000  0010000000  1
 
     Attributes key:
-     f: uncached, write-coalescing, write-through, write-back
-    rf: uncached, write-coalescing, write-through, write-back, needs runtime mapping
-     1: uncached
+     f: UC|WC|WT|WB
+    rf: UC|WC|WT|WB|RT
+     1: UC
 
 
     => efi tables
diff --git a/include/efi.h b/include/efi.h
index b98871fedad..079ceae1eb1 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -681,6 +681,25 @@ int efi_get_mmap(struct efi_mem_desc **descp, int *sizep, uint *keyp,
  */
 void efi_show_tables(struct efi_system_table *systab);
 
+/**
+ * efi_mem_type_name() - get the name of an EFI memory type
+ *
+ * @type: memory type (enum efi_memory_type)
+ * Return: name of the memory type, or NULL if @type is unknown
+ */
+const char *efi_mem_type_name(u32 type);
+
+/**
+ * efi_print_mem_attrs() - print the names of set EFI memory attributes
+ *
+ * Prints the set attribute bits as a '|'-separated list of names, e.g.
+ * ' UC|WB|RT', preceded by a space. Prints nothing if no known attribute
+ * bit is set.
+ *
+ * @attributes: memory attributes (EFI_MEMORY_...)
+ */
+void efi_print_mem_attrs(u64 attributes);
+
 /**
  * efi_get_basename() - Get the default filename to use when loading
  *
-- 
2.43.0

