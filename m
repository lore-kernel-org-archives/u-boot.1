Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325C4CD98F0
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 08:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D4C4849C5;
	Sun, 21 Jun 2026 10:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MwaHxnTb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC745849ED; Sun, 21 Jun 2026 10:19:25 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB7E0849BF
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 10:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-176-006-085-155.176.6.pool.telefonica.de
 [176.6.85.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 35E6742075; 
 Sun, 21 Jun 2026 08:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782029962;
 bh=Tz5Fe6uO/HdyfjSPX39H/qpNT5NvtOyLOtiyR7TNss0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=MwaHxnTbHowi6OdK4BmhIzmP5XXbFDn5bEOR1Pg+XnktK/Tw7uKBcvaUm+eIFlLeY
 ezx7l400IrqBYL/KpqJVXY34bccPQb2GXzOXF/J725mFbrCFZyPXiz/L1DBP7nZmvr
 2so37RQGtX7q+chD6Kiq/JwpUqLmXV8YS+AhUsj+Nboz/Mr6jll6VI0bhZqqjmGpjx
 VlrOMrRaY0Soo3aJOPm4xYGgaEttKEq1PLOVuhlEdxlaO1Z4/y/dYgZPe5jhw7c3j6
 38xgHzwLWOSTLZRPbaEti/PEqURqphda0rFJjbflRQ2ZVYZLsd3chJV1TnwC5TOVpa
 fIvo+cw/Dm01/Fc+SpWPZtC40M+HDekY3hp0juPQ524ueuPwM2XS0b38MbHRVExLJu
 bkoFASRbZLYUy51vwIk0y68XN61HHmWN0qP+kfjEcuXU7SDK+GXvnq4/BRICYWeep6
 gXYnFpS28auUz3BACq0LE+rRC72B1h9uKjlP65MGQcqv7ZqGj/4sN2KQjpL4YkL1NQ
 /MxnoCoPLwXEvAba/lKcDU9K/GUaG0HCACFJEz+ulHq9w5FPXVFwyS4TzNW3Hf8ja/
 hhmuDUqyXA9AOpeLW/mFNkid4OCA5QQMzxkO+jBcXQ2qifuIUoUDAl7NJwpStmzIgw
 VDxMvCIEm3GzOdxCGPbeMiaU=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 05/11] efi_loader: add efi_app_common skeleton
Date: Sun, 21 Jun 2026 10:19:09 +0200
Message-ID: <20260621081915.19154-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
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

The EFI dump applications (acpidump, dbginfodump, dtbdump, initrddump,
smbiosdump) each contain duplicate copies of the same output and
input helpers, and each has its own command loop. This patch series
deduplicates that code by introducing a shared module.

Create lib/efi_loader/efi_app_common.c and efi_app_common.h to hold
utilities shared across the EFI dump applications.

This first patch adds the module skeleton:

* State variables (app_handle, cout, bs, nocolor, systable) owned by
  the common module.
* efi_app_init() to initialize them from sys_table and image_handle,
  including detecting the 'nocolor' load option via get_load_options()
  and starts_with().
* Output helpers: print(), printx(), color(), cls(), error().
* starts_with() - test whether a UTF-16 string begins with a keyword.
* get_load_options() - retrieve the load options of the loaded image.

Eliminate the unused state variable cerr from all apps.

The Makefile is updated to compile efi_app_common.o with EFI CFLAGS
and link it into every dump application's .so so that later patches
can progressively remove duplicate code from the individual apps.

Each dump application is updated to call efi_app_init() at the start
of its efi_main(), wiring up the common module's state before any
common helper is invoked. The now-duplicate static definitions of
cerr, cout, nocolor, starts_with() and get_load_options() are removed
from all apps.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 lib/efi_loader/Makefile         |  13 +++-
 lib/efi_loader/dbginfodump.c    |  43 +----------
 lib/efi_loader/dtbdump.c        | 133 ++------------------------------
 lib/efi_loader/efi_app_common.c | 106 +++++++++++++++++++++++++
 lib/efi_loader/efi_app_common.h |  67 ++++++++++++++++
 lib/efi_loader/initrddump.c     | 126 +-----------------------------
 lib/efi_loader/smbiosdump.c     | 100 +-----------------------
 7 files changed, 196 insertions(+), 392 deletions(-)
 create mode 100644 lib/efi_loader/efi_app_common.c
 create mode 100644 lib/efi_loader/efi_app_common.h

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index d73ad43951b..94ad6721a70 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -94,10 +94,17 @@ $(obj)/efi_capsule.o: $(objtree)/capsule_esl_file FORCE
 asflags-y += -DCAPSULE_ESL_PATH=\"$(objtree)/capsule_esl_file\"
 endif
 
-# Set the C flags to add and remove for each app
-$(foreach f,$(apps-y),\
+# Shared EFI objects (compiled with EFI flags, but not standalone apps)
+efi-obj-y += efi_app_common
+
+# Set the C flags to add and remove for each app and shared EFI object
+$(foreach f,$(apps-y) $(efi-obj-y),\
 	$(eval CFLAGS_$(f).o := $(CFLAGS_EFI) -Os -ffreestanding)\
 	$(eval CFLAGS_REMOVE_$(f).o := $(CFLAGS_NON_EFI)))
 
+# Link efi_app_common.o into each dump app
+$(obj)/dbginfodump_efi.so $(obj)/dtbdump_efi.so \
+$(obj)/initrddump_efi.so $(obj)/smbiosdump_efi.so: $(obj)/efi_app_common.o
+
 always-y += $(foreach f,$(apps-y),$(f).efi)
-targets += $(foreach f,$(apps-y),$(f).o)
+targets += $(foreach f,$(apps-y) $(efi-obj-y),$(f).o)
diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
index 55186bd03f4..2dcff2a11fe 100644
--- a/lib/efi_loader/dbginfodump.c
+++ b/lib/efi_loader/dbginfodump.c
@@ -6,13 +6,13 @@
  */
 
 #include <efi_api.h>
+#include "efi_app_common.h"
 
 /**
  * BUFFER_SIZE - size of the command line input buffer
  */
 #define BUFFER_SIZE 64
 
-static struct efi_simple_text_output_protocol *cerr;
 static struct efi_simple_text_output_protocol *cout;
 static struct efi_simple_text_input_protocol *cin;
 static efi_handle_t handle;
@@ -41,28 +41,6 @@ struct dbg_info_header {
 	struct dbg_info **info;
 };
 
-/**
- * print() - print string
- *
- * @string:	text
- */
-static void print(u16 *string)
-{
-	cout->output_string(cout, string);
-}
-
-/**
- * error() - print error string
- *
- * @string:	error text
- */
-static void error(u16 *string)
-{
-	cout->set_attribute(cout, EFI_LIGHTRED | EFI_BACKGROUND_BLACK);
-	print(string);
-	cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
-}
-
 /**
  * printu() - print unsigned
  *
@@ -177,22 +155,6 @@ static u16 *skip_whitespace(u16 *pos)
 	return pos;
 }
 
-/**
- * starts_with() - check if @string starts with @keyword
- *
- * @string:	string to search for keyword
- * @keyword:	keyword to be searched
- * Return:	true fi @string starts with the keyword
- */
-static bool starts_with(u16 *string, u16 *keyword)
-{
-	for (; *keyword; ++string, ++keyword) {
-		if (*string != *keyword)
-			return false;
-	}
-	return true;
-}
-
 /**
  * do_help() - print help
  */
@@ -310,9 +272,10 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
 {
 	efi_status_t ret;
 
+	efi_app_init(systab, image_handle);
+
 	handle = image_handle;
 	systable = systab;
-	cerr = systable->std_err;
 	cout = systable->con_out;
 	cin = systable->con_in;
 	bs = systable->boottime;
diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
index 865edc33a97..1468955eb8c 100644
--- a/lib/efi_loader/dtbdump.c
+++ b/lib/efi_loader/dtbdump.c
@@ -6,18 +6,16 @@
  * to a file.
  */
 
-#include <efi_api.h>
 #include <efi_dt_fixup.h>
 #include <part.h>
 #include <linux/libfdt.h>
+#include "efi_app_common.h"
 
 #define BUFFER_SIZE 64
 #define ESC 0x17
 
 #define efi_size_in_pages(size) ((size + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT)
 
-static struct efi_simple_text_output_protocol *cerr;
-static struct efi_simple_text_output_protocol *cout;
 static struct efi_simple_text_input_protocol *cin;
 static struct efi_boot_services *bs;
 static const efi_guid_t fdt_guid = EFI_FDT_GUID;
@@ -29,28 +27,6 @@ static struct efi_system_table *systable;
 static const efi_guid_t efi_dt_fixup_protocol_guid = EFI_DT_FIXUP_PROTOCOL_GUID;
 static const efi_guid_t efi_file_info_guid = EFI_FILE_INFO_GUID;
 static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
-static bool nocolor;
-
-/**
- * color() - set foreground color
- *
- * @color:	foreground color
- */
-static void color(u8 color)
-{
-	if (!nocolor)
-		cout->set_attribute(cout, color | EFI_BACKGROUND_BLACK);
-}
-
-/**
- * print() - print string
- *
- * @string:	text
- */
-static void print(u16 *string)
-{
-	cout->output_string(cout, string);
-}
 
 /**
  * print_char() - print character
@@ -74,54 +50,6 @@ static void print_char(unsigned char c)
 	print(out);
 }
 
-/**
- * print_hex_digit() - print hexadecimal digit
- *
- * @digit:	digit to print
- */
-static void print_hex_digit(unsigned char digit)
-{
-	if (digit < 10)
-		digit += '0';
-	else
-		digit += 'a' - 10;
-	print_char(digit);
-}
-
-/**
- * printx() - print hexadecimal byte
- *
- * @val:	value to print
- */
-static void printx(unsigned char val)
-{
-	print_hex_digit(val >> 4);
-	print_hex_digit(val & 0xf);
-}
-
-/**
- * cls() - clear screen
- */
-static void cls(void)
-{
-	if (nocolor)
-		print(u"\r\n");
-	else
-		cout->clear_screen(cout);
-}
-
-/**
- * error() - print error string
- *
- * @string:	error text
- */
-static void error(u16 *string)
-{
-	color(EFI_LIGHTRED);
-	print(string);
-	color(EFI_LIGHTBLUE);
-}
-
 /**
  * efi_drain_input() - drain console input
  */
@@ -280,25 +208,6 @@ static u16 *skip_whitespace(u16 *pos)
 	return pos;
 }
 
-/**
- * starts_with() - check if @string starts with @keyword
- *
- * @string:	string to search for keyword
- * @keyword:	keyword to be searched
- * Return:	true fi @string starts with the keyword
- */
-static bool starts_with(u16 *string, u16 *keyword)
-{
-	if (!string || !keyword)
-		return false;
-
-	for (; *keyword; ++string, ++keyword) {
-		if (*string != *keyword)
-			return false;
-	}
-	return true;
-}
-
 /**
  * do_help() - print help
  */
@@ -639,7 +548,7 @@ static void print_property(const unsigned char *val, u32 len)
 		for (int i = 0; i < len; ++i) {
 			if (i)
 				print(u" ");
-			printx(val[i]);
+			printx(val[i], 2);
 		}
 		print(u"]\"");
 	} else {
@@ -651,7 +560,7 @@ static void print_property(const unsigned char *val, u32 len)
 					print(u" ");
 				print(u"0x");
 			}
-			printx(val[i]);
+			printx(val[i], 2);
 		}
 		print(u">");
 	}
@@ -670,11 +579,11 @@ static void print_mem_res_block(const struct fdt_reserve_entry *rsvblk)
 		print(u"/memreserve/ 0x");
 		val = (const unsigned char *)&rsvblk->address;
 		for (u32 i = 0; i < sizeof(u64); ++i)
-			printx(val[i]);
+			printx(val[i], 2);
 		print(u" 0x");
 		val = (const unsigned char *)&rsvblk->size;
 		for (u32 i = 0; i < sizeof(u64); ++i)
-			printx(val[i]);
+			printx(val[i], 2);
 		print(u";\r\n");
 	}
 }
@@ -779,30 +688,6 @@ static efi_status_t do_dump(void)
 	return EFI_LOAD_ERROR;
 }
 
-/**
- * get_load_options() - get load options
- *
- * Return:	load options or NULL
- */
-static u16 *get_load_options(void)
-{
-	efi_status_t ret;
-	struct efi_loaded_image *loaded_image;
-
-	ret = bs->open_protocol(handle, &loaded_image_guid,
-				(void **)&loaded_image, NULL, NULL,
-				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
-	if (ret != EFI_SUCCESS) {
-		error(u"Loaded image protocol not found\r\n");
-		return NULL;
-	}
-
-	if (!loaded_image->load_options_size || !loaded_image->load_options)
-		return NULL;
-
-	return loaded_image->load_options;
-}
-
 /**
  * efi_main() - entry point of the EFI application.
  *
@@ -813,18 +698,12 @@ static u16 *get_load_options(void)
 efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
 			     struct efi_system_table *systab)
 {
-	u16 *load_options;
+	efi_app_init(systab, image_handle);
 
 	handle = image_handle;
 	systable = systab;
-	cerr = systable->std_err;
-	cout = systable->con_out;
 	cin = systable->con_in;
 	bs = systable->boottime;
-	load_options = get_load_options();
-
-	if (starts_with(load_options, u"nocolor"))
-		nocolor = true;
 
 	color(EFI_LIGHTBLUE);
 	cls();
diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
new file mode 100644
index 00000000000..e9e9334acc7
--- /dev/null
+++ b/lib/efi_loader/efi_app_common.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Common utilities for EFI dump applications
+ *
+ * Copyright 2026, Heinrich Schuchardt <xypron.glpk@gmx.de>
+ */
+
+#include <efi_api.h>
+#include "efi_app_common.h"
+
+static efi_handle_t app_handle;
+static struct efi_simple_text_output_protocol *cout;
+struct efi_boot_services *bs;
+static bool nocolor;
+static struct efi_system_table *systable;
+static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
+
+static u16 *get_load_options(void)
+{
+	efi_status_t ret;
+	struct efi_loaded_image *loaded_image;
+
+	ret = bs->open_protocol(app_handle, &loaded_image_guid,
+				(void **)&loaded_image, NULL, NULL,
+				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+	if (ret != EFI_SUCCESS) {
+		error(u"Loaded image protocol not found\r\n");
+		return NULL;
+	}
+
+	if (!loaded_image->load_options_size || !loaded_image->load_options)
+		return NULL;
+
+	return loaded_image->load_options;
+}
+
+void efi_app_init(struct efi_system_table *sys_table, efi_handle_t image_handle)
+{
+	u16 *load_options;
+
+	app_handle = image_handle;
+	systable = sys_table;
+	cout = sys_table->con_out;
+	bs = sys_table->boottime;
+
+	load_options = get_load_options();
+	if (starts_with(load_options, u"nocolor"))
+		nocolor = true;
+}
+
+void print(u16 *string)
+{
+	cout->output_string(cout, string);
+}
+
+void printx(u64 val, u32 prec)
+{
+	int i;
+	u16 c;
+	u16 buf[16];
+	u16 *pos = buf;
+
+	for (i = 2 * sizeof(val) - 1; i >= 0; --i) {
+		c = (val >> (4 * i)) & 0x0f;
+		if (c || pos != buf || !i || i < prec) {
+			c += '0';
+			if (c > '9')
+				c += 'a' - '9' - 1;
+			*pos++ = c;
+		}
+	}
+	*pos = 0;
+	print(buf);
+}
+
+void color(u8 c)
+{
+	if (!nocolor)
+		cout->set_attribute(cout, c | EFI_BACKGROUND_BLACK);
+}
+
+void cls(void)
+{
+	if (nocolor)
+		print(u"\r\n");
+	else
+		cout->clear_screen(cout);
+}
+
+void error(u16 *string)
+{
+	color(EFI_LIGHTRED);
+	print(string);
+	color(EFI_LIGHTBLUE);
+}
+
+bool starts_with(u16 *string, u16 *keyword)
+{
+	if (!string)
+		return false;
+	for (; *keyword; ++string, ++keyword) {
+		if (*string != *keyword)
+			return false;
+	}
+	return true;
+}
diff --git a/lib/efi_loader/efi_app_common.h b/lib/efi_loader/efi_app_common.h
new file mode 100644
index 00000000000..45c17a8ed99
--- /dev/null
+++ b/lib/efi_loader/efi_app_common.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Common utilities for EFI dump applications
+ *
+ * Copyright 2026, Heinrich Schuchardt <xypron.glpk@gmx.de>
+ */
+
+#ifndef _EFI_APP_COMMON_H
+#define _EFI_APP_COMMON_H
+
+#include <efi_api.h>
+
+/**
+ * efi_app_init() - initialize common EFI application state
+ *
+ * Must be called from efi_main() before any other common function.
+ *
+ * @sys_table:          EFI system table
+ * @image_handle:       image handle
+ */
+void efi_app_init(struct efi_system_table *sys_table,
+		  efi_handle_t image_handle);
+
+/**
+ * print() - print string
+ *
+ * @string:	text
+ */
+void print(u16 *string);
+
+/**
+ * printx() - print hexadecimal number
+ *
+ * @val:	value to print
+ * @prec:	minimum number of digits to print
+ */
+void printx(u64 val, u32 prec);
+
+/**
+ * color() - set foreground color
+ *
+ * @c:	foreground color
+ */
+void color(u8 c);
+
+/**
+ * cls() - clear screen
+ */
+void cls(void);
+
+/**
+ * error() - print error string
+ *
+ * @string:	error text
+ */
+void error(u16 *string);
+
+/**
+ * starts_with() - check if string starts with keyword
+ *
+ * @string:	UTF-16 string to check (may be NULL)
+ * @keyword:	UTF-16 keyword
+ * Return:      true if string starts with keyword
+ */
+bool starts_with(u16 *string, u16 *keyword);
+
+#endif /* _EFI_APP_COMMON_H */
diff --git a/lib/efi_loader/initrddump.c b/lib/efi_loader/initrddump.c
index 615119043d1..60f8a020e8c 100644
--- a/lib/efi_loader/initrddump.c
+++ b/lib/efi_loader/initrddump.c
@@ -9,8 +9,8 @@
  * clearing of the screen.
  */
 
-#include <efi_api.h>
 #include <efi_load_initrd.h>
+#include "efi_app_common.h"
 
 #define BUFFER_SIZE 64
 #define ESC 0x17
@@ -19,15 +19,12 @@
 
 static struct efi_system_table *systable;
 static struct efi_boot_services *bs;
-static struct efi_simple_text_output_protocol *cerr;
-static struct efi_simple_text_output_protocol *cout;
 static struct efi_simple_text_input_protocol *cin;
 static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
 static const efi_guid_t guid_simple_file_system_protocol =
 					EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
 static const efi_guid_t load_file2_guid = EFI_LOAD_FILE2_PROTOCOL_GUID;
 static efi_handle_t handle;
-static bool nocolor;
 
 /*
  * Device path defined by Linux to identify the handle providing the
@@ -49,76 +46,6 @@ static const struct efi_lo_dp_prefix initrd_dp = {
 	}
 };
 
-/**
- * color() - set foreground color
- *
- * @color:	foreground color
- */
-static void color(u8 color)
-{
-	if (!nocolor)
-		cout->set_attribute(cout, color | EFI_BACKGROUND_BLACK);
-}
-
-/**
- * print() - print string
- *
- * @string:	text
- */
-static void print(u16 *string)
-{
-	cout->output_string(cout, string);
-}
-
-/**
- * cls() - clear screen
- */
-static void cls(void)
-{
-	if (nocolor)
-		print(u"\r\n");
-	else
-		cout->clear_screen(cout);
-}
-
-/**
- * error() - print error string
- *
- * @string:	error text
- */
-static void error(u16 *string)
-{
-	color(EFI_LIGHTRED);
-	print(string);
-	color(EFI_LIGHTBLUE);
-}
-
-/*
- * printx() - print hexadecimal number
- *
- * @val:	value to print;
- * @prec:	minimum number of digits to print
- */
-static void printx(u64 val, u32 prec)
-{
-	int i;
-	u16 c;
-	u16 buf[16];
-	u16 *pos = buf;
-
-	for (i = 2 * sizeof(val) - 1; i >= 0; --i) {
-		c = (val >> (4 * i)) & 0x0f;
-		if (c || pos != buf || !i || i < prec) {
-			c += '0';
-			if (c > '9')
-				c += 'a' - '9' - 1;
-			*pos++ = c;
-		}
-	}
-	*pos = 0;
-	print(buf);
-}
-
 /**
  * efi_drain_input() - drain console input
  */
@@ -239,25 +166,6 @@ static u16 *skip_whitespace(u16 *pos)
 	return pos;
 }
 
-/**
- * starts_with() - check if @string starts with @keyword
- *
- * @string:	string to search for keyword
- * @keyword:	keyword to be searched
- * Return:	true if @string starts with the keyword
- */
-static bool starts_with(u16 *string, u16 *keyword)
-{
-	if (!string || !keyword)
-		return false;
-
-	for (; *keyword; ++string, ++keyword) {
-		if (*string != *keyword)
-			return false;
-	}
-	return true;
-}
-
 /**
  * do_help() - print help
  */
@@ -434,30 +342,6 @@ out:
 	return ret;
 }
 
-/**
- * get_load_options() - get load options
- *
- * Return:	load options or NULL
- */
-static u16 *get_load_options(void)
-{
-	efi_status_t ret;
-	struct efi_loaded_image *loaded_image;
-
-	ret = bs->open_protocol(handle, &loaded_image_guid,
-				(void **)&loaded_image, NULL, NULL,
-				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
-	if (ret != EFI_SUCCESS) {
-		error(u"Loaded image protocol not found\r\n");
-		return NULL;
-	}
-
-	if (!loaded_image->load_options_size || !loaded_image->load_options)
-		return NULL;
-
-	return loaded_image->load_options;
-}
-
 /**
  * efi_main() - entry point of the EFI application.
  *
@@ -468,18 +352,12 @@ static u16 *get_load_options(void)
 efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
 			     struct efi_system_table *systab)
 {
-	u16 *load_options;
+	efi_app_init(systab, image_handle);
 
 	handle = image_handle;
 	systable = systab;
-	cerr = systable->std_err;
-	cout = systable->con_out;
 	cin = systable->con_in;
 	bs = systable->boottime;
-	load_options = get_load_options();
-
-	if (starts_with(load_options, u"nocolor"))
-		nocolor = true;
 
 	color(EFI_WHITE);
 	cls();
diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
index 494c3d18945..e19214d798f 100644
--- a/lib/efi_loader/smbiosdump.c
+++ b/lib/efi_loader/smbiosdump.c
@@ -8,15 +8,13 @@
  * clearing of the screen.
  */
 
-#include <efi_api.h>
 #include <part.h>
 #include <smbios.h>
 #include <string.h>
+#include "efi_app_common.h"
 
 #define BUFFER_SIZE 64
 
-static struct efi_simple_text_output_protocol *cerr;
-static struct efi_simple_text_output_protocol *cout;
 static struct efi_simple_text_input_protocol *cin;
 static struct efi_boot_services *bs;
 static efi_handle_t handle;
@@ -27,51 +25,6 @@ static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
 static const efi_guid_t guid_simple_file_system_protocol =
 					EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
 static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
-static bool nocolor;
-
-/**
- * color() - set foreground color
- *
- * @color:	foreground color
- */
-static void color(u8 color)
-{
-	if (!nocolor)
-		cout->set_attribute(cout, color | EFI_BACKGROUND_BLACK);
-}
-
-/**
- * print() - print string
- *
- * @string:	text
- */
-static void print(u16 *string)
-{
-	cout->output_string(cout, string);
-}
-
-/**
- * cls() - clear screen
- */
-static void cls(void)
-{
-	if (nocolor)
-		print(u"\r\n");
-	else
-		cout->clear_screen(cout);
-}
-
-/**
- * error() - print error string
- *
- * @string:	error text
- */
-static void error(u16 *string)
-{
-	color(EFI_LIGHTRED);
-	print(string);
-	color(EFI_LIGHTBLUE);
-}
 
 /**
  * efi_input_yn() - get answer to yes/no question
@@ -189,25 +142,6 @@ static u16 *skip_whitespace(u16 *pos)
 	return pos;
 }
 
-/**
- * starts_with() - check if @string starts with @keyword
- *
- * @string:	string to search for keyword
- * @keyword:	keyword to be searched
- * Return:	true fi @string starts with the keyword
- */
-static bool starts_with(u16 *string, u16 *keyword)
-{
-	if (!string || !keyword)
-		return false;
-
-	for (; *keyword; ++string, ++keyword) {
-		if (*string != *keyword)
-			return false;
-	}
-	return true;
-}
-
 /**
  * open_file_system() - open simple file system protocol
  *
@@ -532,30 +466,6 @@ static efi_status_t do_save(u16 *filename)
 	return ret;
 }
 
-/**
- * get_load_options() - get load options
- *
- * Return:	load options or NULL
- */
-static u16 *get_load_options(void)
-{
-	efi_status_t ret;
-	struct efi_loaded_image *loaded_image;
-
-	ret = bs->open_protocol(handle, &loaded_image_guid,
-				(void **)&loaded_image, NULL, NULL,
-				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
-	if (ret != EFI_SUCCESS) {
-		error(u"Loaded image protocol not found\r\n");
-		return NULL;
-	}
-
-	if (!loaded_image->load_options_size || !loaded_image->load_options)
-		return NULL;
-
-	return loaded_image->load_options;
-}
-
 /**
  * command_loop - process user commands
  */
@@ -595,18 +505,12 @@ static void command_loop(void)
 efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
 			     struct efi_system_table *systab)
 {
-	u16 *load_options;
+	efi_app_init(systab, image_handle);
 
 	handle = image_handle;
 	systable = systab;
-	cerr = systable->std_err;
-	cout = systable->con_out;
 	cin = systable->con_in;
 	bs = systable->boottime;
-	load_options = get_load_options();
-
-	if (starts_with(load_options, u"nocolor"))
-		nocolor = true;
 
 	color(EFI_WHITE);
 	cls();
-- 
2.53.0

