Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8796C43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 08:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5968984A0E;
	Sun, 28 Jun 2026 10:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eaghu+Sw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05D1F848EB; Sun, 28 Jun 2026 10:28:20 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75CE784866
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 10:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box
 (dynamic-046-114-110-002.46.114.pool.telefonica.de [46.114.110.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D5786420B3; 
 Sun, 28 Jun 2026 08:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782635297;
 bh=Y7/IBoFwjJdW9DLlX8Qgl5fi72cc1vm65ZX8IQv8Xxw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=eaghu+SwDulqizxoG6Btn+mEdyM8i1Dx8dTJJiwgBjKArFXhXrRN+Ud+ehmOI9KwC
 84/C/9mU0IgRpuIZKlsc0ZUpBTp7NoiwcByj+IWrN+Pk1EpH/7D2r3o/4xx/B8eNXB
 AdOVk3IRI9S0rvMW/8SUlmBJ+4kjoV+nuJp+CmY8R1dRJ1f2RvbbtdiSxEc2ry/TZp
 Ydb6Q8hr5/SsNaHv4lFYd4ctxlZkCP6tdwdWiO5SKjn4CXKWOZIzhgFrpIzcOkyTYz
 q3vRfPgZVNXKq0bLNiOQL9WC5/VFSUTNrlUS8lUOXPUshMLvYj8fSUwDVfW5A85I8c
 9CCJZ62AQP/AzAJZBrud8MxInlOz0wSMLMMXhTnd04DAcGs0dwj2aGiHwr7qkZTG1g
 LDiJiQdP5oHopkDhE14rH3UGLMTkajw4DxKJJIbTSkszM7T3nUzPkfru+EfCW38GRu
 qUUdMa/v64MX//YhPJxXLSHqkbN5Tf/kD+h4QZHzVLeRvU1OmLwOeijfvL4pEJlOW/
 mVwHuAJo7vuwm6DWPnbdiAysLx5UFJb0yuSipWqBzpM4DX/jF6CY+Cq3lgmQ+T6zy6
 Wl9rBQ3EyQ8fzKRosKiAu2gPxThggD/ru9ylt6WQY9nnCo0ZRW4qv0SNnATp8QUsnj
 NE2sXDZg/lggyvfeuzL5z8VQ=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 09/11] efi_loader: move efi_main and command loop to
 efi_app_common
Date: Sun, 28 Jun 2026 10:28:07 +0200
Message-ID: <20260628082810.175862-10-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
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

Add the remaining shared code to efi_app_common to complete the
refactoring:

* efi_main() - common entry point; calls efi_app_init(), prints
  app_banner, calls command_loop(), then clears the screen on exit.
* struct efi_app_cmd - table entry holding the keyword, help text,
  and a handler of type void (*fn)(u16 *args).
* command_loop() - iterates app_cmds[], matches keywords with
  starts_with(), and falls back to efi_app_help() on no match.
* efi_app_help() - prints each table entry's help line plus the
  built-in "exit" line.

Each dump app is updated accordingly:
* efi_main is removed; command_loop becomes non-static.
* app_banner[] is defined at file scope with the application's
  title string.
* Per-app duplicate state (bs, handle, systable) is removed; apps
  now use the common module's state.
* do_help() and command_loop() are removed; each app instead provides
  a file-scope app_cmds[] dispatch table whose entries point directly
  to the do_* functions.

dbginfodump: the device-path-to-text protocol lookup is moved from
efi_main into command_loop so the protocol handle is local to the
function that uses it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	move external variable to efi_app_common.h
	remove printx comment (which is in 05/11 now)
	safely handle command with length 0 in command_loop()
	smbiosdump: don't remove check in do_save()
	dbginfodump: remove stray blank line
	dbginfodump: keep writing error if Device Path To Text protocol not found
	intirddump: use efi_status_t for status code
v2:
	new patch
---
 lib/efi_loader/dbginfodump.c    | 100 ++++++---------------------
 lib/efi_loader/dtbdump.c        | 109 ++++++------------------------
 lib/efi_loader/efi_app_common.c | 108 ++++++++++++++++++++++++++++-
 lib/efi_loader/efi_app_common.h |  38 ++++++++---
 lib/efi_loader/initrddump.c     |  95 +++++---------------------
 lib/efi_loader/smbiosdump.c     | 116 ++++++++------------------------
 7 files changed, 227 insertions(+), 344 deletions(-)

diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
index 06cb1a3850a..3c9710984dc 100644
--- a/lib/efi_loader/dbginfodump.c
+++ b/lib/efi_loader/dbginfodump.c
@@ -5,26 +5,16 @@
  * dbginfodump.efi prints out the content of the EFI_DEBUG_IMAGE_INFO_TABLE.
  */
 
-#include <efi_api.h>
 #include "efi_app_common.h"
 
-/**
- * BUFFER_SIZE - size of the command line input buffer
- */
-#define BUFFER_SIZE 64
-
-static struct efi_simple_text_output_protocol *cout;
-static efi_handle_t handle;
-static struct efi_system_table *systable;
-static struct efi_boot_services *bs;
+u16 app_banner[] = u"Debug Info Table Dump\r\n=====================\r\n\r\n";
 
 static efi_guid_t guid_device_path_to_text_protocol =
 	EFI_DEVICE_PATH_TO_TEXT_PROTOCOL_GUID;
 
 static struct efi_device_path_to_text_protocol *device_path_to_text;
 
-static const efi_guid_t dbg_info_guid =
-	EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
+static const efi_guid_t dbg_info_guid = EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
 
 /* EFI_DEBUG_IMAGE_INFO_NORMAL */
 struct dbg_info {
@@ -82,15 +72,6 @@ static void printp(void *p)
 	print(str);
 }
 
-/**
- * do_help() - print help
- */
-static void do_help(void)
-{
-	error(u"dump       - print debug info table\r\n");
-	error(u"exit       - exit the shell\r\n");
-}
-
 /**
  * print_info() - print loaded image protocol
  */
@@ -118,20 +99,30 @@ static void print_info(struct efi_loaded_image *info)
 
 /**
  * do_dump() - print debug info table
+ *
+ * @args:	unused command arguments
  */
-static efi_status_t do_dump(void)
+static void do_dump(u16 * __maybe_unused args)
 {
 	struct dbg_info_header *dbg;
 	u32 count;
+	efi_status_t ret;
+
+	ret = bs->locate_protocol(&guid_device_path_to_text_protocol,
+				  NULL, (void **)&device_path_to_text);
+	if (ret != EFI_SUCCESS)	{
+		error(u"No device path to text protocol\r\n");
+		device_path_to_text = NULL;
+	}
 
 	dbg = get_config_table(&dbg_info_guid);
 	if (!dbg) {
 		error(u"Debug info table not found\r\n");
-		return EFI_NOT_FOUND;
+		return;
 	}
 	if (dbg->status & 0x01) {
 		error(u"Update in progress\r\n");
-		return EFI_LOAD_ERROR;
+		return;
 	}
 	if (dbg->status & 0x02)
 		print(u"Modified\r\n");
@@ -163,62 +154,9 @@ static efi_status_t do_dump(void)
 		printp(info->handle);
 		print(u"\r\n");
 	}
-
-	return EFI_SUCCESS;
 }
 
-/**
- * efi_main() - entry point of the EFI application.
- *
- * @handle:	handle of the loaded image
- * @systab:	system table
- * Return:	status code
- */
-efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
-			     struct efi_system_table *systab)
-{
-	efi_status_t ret;
-
-	efi_app_init(systab, image_handle);
-
-	handle = image_handle;
-	systable = systab;
-	cout = systable->con_out;
-	bs = systable->boottime;
-
-	cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
-	cout->clear_screen(cout);
-	cout->set_attribute(cout, EFI_WHITE | EFI_BACKGROUND_BLACK);
-	print(u"Debug Info Table Dump\r\n=====================\r\n\r\n");
-	cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
-
-	ret = bs->locate_protocol(&guid_device_path_to_text_protocol,
-				  NULL, (void **)&device_path_to_text);
-	if (ret != EFI_SUCCESS)	{
-		error(u"No device path to text protocol\r\n");
-		device_path_to_text = NULL;
-	}
-
-	for (;;) {
-		u16 command[BUFFER_SIZE];
-		u16 *pos;
-		efi_uintn_t ret;
-
-		efi_drain_input();
-		print(u"=> ");
-		ret = efi_input(command, sizeof(command));
-		if (ret == EFI_ABORTED)
-			break;
-		pos = skip_whitespace(command);
-		if (starts_with(pos, u"exit"))
-			break;
-		else if (starts_with(pos, u"dump"))
-			do_dump();
-		else
-			do_help();
-	}
-
-	cout->set_attribute(cout, EFI_LIGHTGRAY | EFI_BACKGROUND_BLACK);
-	cout->clear_screen(cout);
-	return EFI_SUCCESS;
-}
+struct efi_app_cmd app_cmds[] = {
+	{ u"dump", u"dump - print debug info table\r\n", do_dump },
+	{ }
+};
diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
index 0d56a41ecf6..ba15c198b51 100644
--- a/lib/efi_loader/dtbdump.c
+++ b/lib/efi_loader/dtbdump.c
@@ -10,15 +10,13 @@
 #include <linux/libfdt.h>
 #include "efi_app_common.h"
 
-#define BUFFER_SIZE 64
 #define ESC 0x17
 
 #define efi_size_in_pages(size) ((size + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT)
 
-static struct efi_boot_services *bs;
+u16 app_banner[] = u"DTB Dump\r\n========\r\n\r\n";
+
 static const efi_guid_t fdt_guid = EFI_FDT_GUID;
-static efi_handle_t handle;
-static struct efi_system_table *systable;
 static const efi_guid_t efi_dt_fixup_protocol_guid = EFI_DT_FIXUP_PROTOCOL_GUID;
 static const efi_guid_t efi_file_info_guid = EFI_FILE_INFO_GUID;
 
@@ -61,24 +59,12 @@ static u32 f2h(fdt32_t val)
 	return *(u32 *)buf;
 }
 
-/**
- * do_help() - print help
- */
-static void do_help(void)
-{
-	error(u"dump       - print device-tree\r\n");
-	error(u"load <dtb> - load device-tree from file\r\n");
-	error(u"save <dtb> - save device-tree to file\r\n");
-	error(u"exit       - exit the shell\r\n");
-}
-
 /**
  * do_load() - load and install device-tree
  *
  * @filename:	file name
- * Return:	status code
  */
-static efi_status_t do_load(u16 *filename)
+static void do_load(u16 *filename)
 {
 	struct efi_dt_fixup_protocol *dt_fixup_prot;
 	struct efi_simple_file_system_protocol *file_system;
@@ -94,11 +80,9 @@ static efi_status_t do_load(u16 *filename)
 				  (void **)&dt_fixup_prot);
 	if (ret != EFI_SUCCESS) {
 		error(u"Device-tree fix-up protocol not found\r\n");
-		return ret;
+		return;
 	}
 
-	filename = skip_whitespace(filename);
-
 	ret = open_file_system(&file_system);
 	if (ret != EFI_SUCCESS)
 		goto out;
@@ -206,16 +190,14 @@ out:
 		if (ret2 != EFI_SUCCESS)
 			error(u"Can't close volume\r\n");
 	}
-	return ret;
 }
 
 /**
  * do_save() - save current device-tree
  *
  * @filename:	file name
- * Return:	status code
  */
-static efi_status_t do_save(u16 *filename)
+static void do_save(u16 *filename)
 {
 	struct fdt_header *dtb;
 	efi_uintn_t dtb_size;
@@ -224,23 +206,19 @@ static efi_status_t do_save(u16 *filename)
 	dtb = get_config_table(&fdt_guid);
 	if (!dtb) {
 		error(u"DTB not found\r\n");
-		return EFI_NOT_FOUND;
+		return;
 	}
 	if (f2h(dtb->magic) != FDT_MAGIC) {
 		error(u"Wrong device tree magic\r\n");
-		return EFI_NOT_FOUND;
+		return;
 	}
 	dtb_size = f2h(dtb->totalsize);
 
-	filename = skip_whitespace(filename);
-
 	ret = save_file(filename, dtb, dtb_size);
 	if (ret == EFI_SUCCESS) {
 		print(filename);
 		print(u" written\r\n");
 	}
-
-	return ret;
 }
 
 /**
@@ -357,8 +335,10 @@ static void print_mem_res_block(const struct fdt_reserve_entry *rsvblk)
 
 /**
  * do_dump() - print device-tree
+ *
+ * @args:	unused command arguments
  */
-static efi_status_t do_dump(void)
+static void do_dump(u16 * __maybe_unused args)
 {
 	const unsigned char *fdt;
 	struct fdt_header *header;
@@ -370,14 +350,14 @@ static efi_status_t do_dump(void)
 	fdt = get_config_table(&fdt_guid);
 	if (!fdt) {
 		error(u"DTB not found\r\n");
-		return EFI_NOT_FOUND;
+		return;
 	}
 
 	header = (struct fdt_header *)fdt;
 	if (f2h(header->magic) != FDT_MAGIC) {
 		error(u"Wrong device tree magic\r\n");
 		error(u"Not a device-tree\r\n");
-		return EFI_LOAD_ERROR;
+		return;
 	}
 
 	pos = (u32 *)(fdt + f2h(header->off_dt_struct));
@@ -430,7 +410,7 @@ static efi_status_t do_dump(void)
 		case FDT_END_NODE:
 			if (!level) {
 				error(u"Extraneous end node\r\n");
-				return EFI_LOAD_ERROR;
+				return;
 			}
 
 			--level;
@@ -441,66 +421,21 @@ static efi_status_t do_dump(void)
 		case FDT_END:
 			if (level) {
 				error(u"Missing end node\r\n");
-				return EFI_LOAD_ERROR;
+				return;
 			}
 			print(u"\r\n");
-			return EFI_SUCCESS;
+			return;
 		default:
 			error(u"Invalid device tree token\r\n");
-			return EFI_LOAD_ERROR;
+			return;
 		}
 	}
 	error(u"Overrun\r\n");
-
-	return EFI_LOAD_ERROR;
 }
 
-/**
- * efi_main() - entry point of the EFI application.
- *
- * @handle:	handle of the loaded image
- * @systab:	system table
- * Return:	status code
- */
-efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
-			     struct efi_system_table *systab)
-{
-	efi_app_init(systab, image_handle);
-
-	handle = image_handle;
-	systable = systab;
-	bs = systable->boottime;
-
-	color(EFI_LIGHTBLUE);
-	cls();
-	color(EFI_WHITE);
-	print(u"DTB Dump\r\n========\r\n\r\n");
-	color(EFI_LIGHTBLUE);
-
-	for (;;) {
-		u16 command[BUFFER_SIZE];
-		u16 *pos;
-		efi_uintn_t ret;
-
-		efi_drain_input();
-		print(u"=> ");
-		ret = efi_input(command, sizeof(command));
-		if (ret == EFI_ABORTED)
-			break;
-		pos = skip_whitespace(command);
-		if (starts_with(pos, u"exit"))
-			break;
-		else if (starts_with(pos, u"dump"))
-			do_dump();
-		else if (starts_with(pos, u"load "))
-			do_load(pos + 5);
-		else if (starts_with(pos, u"save "))
-			do_save(pos + 5);
-		else
-			do_help();
-	}
-
-	color(EFI_LIGHTGRAY);
-	cls();
-	return EFI_SUCCESS;
-}
+struct efi_app_cmd app_cmds[] = {
+	{ u"dump",  u"dump - print device-tree\r\n", do_dump },
+	{ u"load ", u"load <dtb> - load device-tree from file\r\n", do_load },
+	{ u"save ", u"save <dtb> - save device-tree to file\r\n", do_save },
+	{ }
+};
diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
index 2bb71f4fc1a..0221cc22ee3 100644
--- a/lib/efi_loader/efi_app_common.c
+++ b/lib/efi_loader/efi_app_common.c
@@ -9,6 +9,8 @@
 #include <part.h>
 #include "efi_app_common.h"
 
+#define CMD_BUFFER_SIZE 64
+
 static efi_handle_t app_handle;
 static struct efi_simple_text_input_protocol *cin;
 static struct efi_simple_text_output_protocol *cout;
@@ -39,7 +41,18 @@ static u16 *get_load_options(void)
 	return loaded_image->load_options;
 }
 
-void efi_app_init(struct efi_system_table *sys_table, efi_handle_t image_handle)
+/**
+ * efi_app_init() - initialize the EFI application
+ *
+ * Sets up global pointers to the EFI system table, boot services,
+ * console I/O protocols, and the application handle. Processes
+ * load options (e.g. "nocolor").
+ *
+ * @sys_table:		EFI system table
+ * @image_handle:	image handle of the application
+ */
+static void efi_app_init(struct efi_system_table *sys_table,
+			 efi_handle_t image_handle)
 {
 	u16 *load_options;
 
@@ -305,3 +318,96 @@ efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
 
 	return ret;
 }
+
+/**
+ * efi_app_help() - print application command help
+ *
+ * Prints the help text for each entry in @cmds, then appends a fixed
+ * line for the built-in "exit" command.
+ *
+ * @cmds:	null-fn-terminated application command table
+ */
+static void efi_app_help(const struct efi_app_cmd *cmds)
+{
+	const struct efi_app_cmd *cmd;
+
+	for (cmd = cmds; cmd->fn; ++cmd)
+		error((u16 *)cmd->help);
+	error(u"exit - exit the shell\r\n");
+}
+
+/**
+ * command_loop() - read and dispatch application commands
+ *
+ * Reads commands from the console and dispatches them via the
+ * application's @app_cmds table.  Exits when the user types "exit"
+ * or presses Escape.
+ */
+static void command_loop(void)
+{
+	for (;;) {
+		u16 command[CMD_BUFFER_SIZE];
+		const struct efi_app_cmd *cmd;
+		u16 *pos;
+		bool found;
+		efi_uintn_t ret;
+
+		efi_drain_input();
+		print(u"=> ");
+		ret = efi_input(command, CMD_BUFFER_SIZE);
+		if (ret == EFI_ABORTED)
+			break;
+		pos = skip_whitespace(command);
+		if (starts_with(pos, u"exit"))
+			break;
+		found = false;
+		for (cmd = app_cmds; cmd->fn; ++cmd) {
+			if (starts_with(pos, (u16 *)cmd->cmd)) {
+				efi_uintn_t len;
+
+				for (len = 0; cmd->cmd[len]; ++len)
+					;
+				/*
+				 * If the keyword ends with a space the
+				 * command expects an argument.  Show help
+				 * when none is provided.
+				 */
+				if (len && cmd->cmd[len - 1] == ' ' &&
+				    !*skip_whitespace(pos + len)) {
+					efi_app_help(app_cmds);
+				} else {
+					cmd->fn(pos + len);
+				}
+				found = true;
+				break;
+			}
+		}
+		if (!found)
+			efi_app_help(app_cmds);
+	}
+}
+
+/**
+ * efi_main() - entry point of the EFI application
+ *
+ * @image_handle:	image handle
+ * @systab:	EFI system table
+ * Return:         status code
+ */
+efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
+			     struct efi_system_table *systab)
+{
+	efi_app_init(systab, image_handle);
+
+	color(EFI_WHITE);
+	cls();
+	print(app_banner);
+	color(EFI_LIGHTBLUE);
+
+	command_loop();
+
+	color(EFI_LIGHTGRAY);
+	cls();
+
+	return EFI_SUCCESS;
+}
diff --git a/lib/efi_loader/efi_app_common.h b/lib/efi_loader/efi_app_common.h
index 7cdc5ca0ca0..1adb1619292 100644
--- a/lib/efi_loader/efi_app_common.h
+++ b/lib/efi_loader/efi_app_common.h
@@ -11,15 +11,35 @@
 #include <efi_api.h>
 
 /**
- * efi_app_init() - initialize common EFI application state
+ * struct efi_app_cmd - entry in the application command table
  *
- * Must be called from efi_main() before any other common function.
+ * @fn == NULL marks the end of the table.
  *
- * @sys_table:          EFI system table
- * @image_handle:       image handle
+ * @cmd:	keyword; a trailing space indicates the command takes an argument
+ * @help:	help text line printed by the built-in help handler
+ * @fn:		handler; called with a pointer past the keyword
+ * 		(may be an empty string for no-argument commands)
  */
-void efi_app_init(struct efi_system_table *sys_table,
-		  efi_handle_t image_handle);
+struct efi_app_cmd {
+	const u16 *cmd;
+	const u16 *help;
+	void (*fn)(u16 *args);
+};
+
+/*
+ * var app_banner - UTF-16 string to be printed at start of app
+ */
+extern u16 app_banner[];
+
+/*
+ * var app_cmds - array of commands provided by an app
+ */
+extern struct efi_app_cmd app_cmds[];
+
+/*
+ * var bs - pointer to boot services table
+ */
+extern struct efi_boot_services *bs;
 
 /**
  * print() - print string
@@ -95,8 +115,8 @@ efi_status_t efi_input_yn(void);
 /**
  * efi_input() - read string from console
  *
- * @buffer:             input buffer
- * @buffer_size:        buffer size
+ * @buffer:	input buffer
+ * @buffer_size:	buffer size
  * Return:              status code
  */
 efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size);
@@ -104,7 +124,7 @@ efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size);
 /**
  * get_config_table() - get configuration table
  *
- * @guid:       GUID of the configuration table
+ * @guid:	GUID of the configuration table
  * Return:      pointer to configuration table or NULL
  */
 void *get_config_table(const efi_guid_t *guid);
diff --git a/lib/efi_loader/initrddump.c b/lib/efi_loader/initrddump.c
index c3e6f2b683f..fbdd44d6bcf 100644
--- a/lib/efi_loader/initrddump.c
+++ b/lib/efi_loader/initrddump.c
@@ -12,15 +12,11 @@
 #include <efi_load_initrd.h>
 #include "efi_app_common.h"
 
-#define BUFFER_SIZE 64
-#define ESC 0x17
-
 #define efi_size_in_pages(size) (((size) + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT)
 
-static struct efi_system_table *systable;
-static struct efi_boot_services *bs;
+u16 app_banner[] = u"INITRD Dump\r\n===========\r\n\r\n";
+
 static const efi_guid_t load_file2_guid = EFI_LOAD_FILE2_PROTOCOL_GUID;
-static efi_handle_t handle;
 
 /*
  * Device path defined by Linux to identify the handle providing the
@@ -42,16 +38,6 @@ static const struct efi_lo_dp_prefix initrd_dp = {
 	}
 };
 
-/**
- * do_help() - print help
- */
-static void do_help(void)
-{
-	error(u"load          - show length and CRC32 of initial RAM disk\r\n");
-	error(u"save <initrd> - save initial RAM disk to file\r\n");
-	error(u"exit          - exit the shell\r\n");
-}
-
 /**
  * get_initrd() - read initial RAM disk via EFI_LOAD_FILE2_PROTOCOL
  *
@@ -103,19 +89,18 @@ static efi_status_t get_initrd(void **initrd, efi_uintn_t *initrd_size)
 /**
  * do_load() - load initial RAM disk and display CRC32 and length
  *
- * @filename:	file name
- * Return:	status code
+ * @args:	unused command arguments
  */
-static efi_status_t do_load(void)
+static void do_load(u16 * __maybe_unused args)
 {
 	void *initrd;
 	efi_uintn_t initrd_size;
 	u32 crc32;
-	efi_uintn_t ret;
+	efi_status_t ret;
 
-	ret =  get_initrd(&initrd, &initrd_size);
+	ret = get_initrd(&initrd, &initrd_size);
 	if (ret != EFI_SUCCESS)
-		return ret;
+		return;
 	print(u"length: 0x");
 	printx(initrd_size, 1);
 	print(u"\r\n");
@@ -123,32 +108,27 @@ static efi_status_t do_load(void)
 	ret = bs->calculate_crc32(initrd, initrd_size, &crc32);
 	if (ret != EFI_SUCCESS) {
 		error(u"Calculating CRC32 failed\r\n");
-		return EFI_LOAD_ERROR;
+		return;
 	}
 	print(u"crc32: 0x");
 	printx(crc32, 8);
 	print(u"\r\n");
-
-	return EFI_SUCCESS;
 }
 
 /**
  * do_save() - save initial RAM disk
  *
  * @filename:	file name
- * Return:	status code
  */
-static efi_status_t do_save(u16 *filename)
+static void do_save(u16 *filename)
 {
 	void *initrd;
 	efi_uintn_t initrd_size;
-	efi_uintn_t ret;
+	efi_status_t ret;
 
 	ret = get_initrd(&initrd, &initrd_size);
 	if (ret != EFI_SUCCESS)
-		return ret;
-
-	filename = skip_whitespace(filename);
+		return;
 
 	ret = save_file(filename, initrd, initrd_size);
 	if (ret == EFI_SUCCESS) {
@@ -157,53 +137,10 @@ static efi_status_t do_save(u16 *filename)
 	}
 
 	bs->free_pages((uintptr_t)initrd, efi_size_in_pages(initrd_size));
-	return ret;
 }
 
-/**
- * efi_main() - entry point of the EFI application.
- *
- * @handle:	handle of the loaded image
- * @systab:	system table
- * Return:	status code
- */
-efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
-			     struct efi_system_table *systab)
-{
-	efi_app_init(systab, image_handle);
-
-	handle = image_handle;
-	systable = systab;
-	bs = systable->boottime;
-
-	color(EFI_WHITE);
-	cls();
-	print(u"INITRD Dump\r\n===========\r\n\r\n");
-	color(EFI_LIGHTBLUE);
-
-	for (;;) {
-		u16 command[BUFFER_SIZE];
-		u16 *pos;
-		efi_uintn_t ret;
-
-		efi_drain_input();
-		print(u"=> ");
-		ret = efi_input(command, sizeof(command));
-		if (ret == EFI_ABORTED)
-			break;
-		pos = skip_whitespace(command);
-		if (starts_with(pos, u"exit"))
-			break;
-		else if (starts_with(pos, u"load"))
-			do_load();
-		else if (starts_with(pos, u"save "))
-			do_save(pos + 5);
-		else
-			do_help();
-	}
-
-	color(EFI_LIGHTGRAY);
-	cls();
-
-	return EFI_SUCCESS;
-}
+struct efi_app_cmd app_cmds[] = {
+	{ u"load",  u"load - show length and CRC32 of initial RAM disk\r\n", do_load },
+	{ u"save ", u"save <initrd> - save initial RAM disk to file\r\n", do_save },
+	{ }
+};
diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
index 8aa6f594a07..de6f7514979 100644
--- a/lib/efi_loader/smbiosdump.c
+++ b/lib/efi_loader/smbiosdump.c
@@ -12,24 +12,11 @@
 #include <string.h>
 #include "efi_app_common.h"
 
-#define BUFFER_SIZE 64
+u16 app_banner[] = u"SMBIOS Dump\r\n===========\r\n\r\n";
 
-static struct efi_boot_services *bs;
-static efi_handle_t handle;
-static struct efi_system_table *systable;
 static const efi_guid_t smbios_guid = SMBIOS_TABLE_GUID;
 static const efi_guid_t smbios3_guid = SMBIOS3_TABLE_GUID;
 
-/**
- * do_help() - print help
- */
-static void do_help(void)
-{
-	error(u"check       - check SMBIOS table\r\n");
-	error(u"save <file> - save SMBIOS table to file\r\n");
-	error(u"exit        - exit the shell\r\n");
-}
-
 /**
  * checksum() - calculate checksum
  *
@@ -48,11 +35,11 @@ static u8 checksum(void *buf, int len)
 }
 
 /**
- * do_check() - check SMBIOS table
+ * check() - check SMBIOS table
  *
  * Return:	status code
  */
-static efi_status_t do_check(void)
+static efi_status_t check(void)
 {
 	struct smbios3_entry *smbios3_anchor;
 	void *table, *table_end;
@@ -142,22 +129,35 @@ static efi_status_t do_check(void)
 	return EFI_SUCCESS;
 }
 
+/**
+ * do_check() - check SMBIOS table
+ *
+ * @args:	unused command arguments
+ */
+static void do_check(u16 * __maybe_unused args)
+{
+	efi_status_t ret;
+
+	ret = check();
+	if (ret == EFI_SUCCESS)
+		print(u"OK\r\n");
+}
+
 /**
  * do_save() - save SMBIOS table
  *
  * @filename:	file name
- * Return:	status code
  */
-static efi_status_t do_save(u16 *filename)
+static void do_save(u16 *filename)
 {
 	struct smbios3_entry *smbios3_anchor;
 	u8 *buf;
 	efi_uintn_t size;
-	efi_uintn_t ret;
+	efi_status_t ret;
 
-	ret = do_check();
+	ret = check();
 	if (ret != EFI_SUCCESS)
-		return ret;
+		return;
 
 	smbios3_anchor = get_config_table(&smbios3_guid);
 	if (smbios3_anchor) {
@@ -165,7 +165,7 @@ static efi_status_t do_save(u16 *filename)
 		ret = bs->allocate_pool(EFI_LOADER_DATA, size, (void **)&buf);
 		if (ret != EFI_SUCCESS) {
 			error(u"Out of memory\n");
-			return ret;
+			return;
 		}
 
 		memset(buf, 0, size);
@@ -183,9 +183,8 @@ static efi_status_t do_save(u16 *filename)
 
 		smbios_anchor = get_config_table(&smbios_guid);
 		if (!smbios_anchor) {
-			/* Should not be reached after successful do_check() */
 			error(u"No SMBIOS table\n");
-			return EFI_NOT_FOUND;
+			return;
 		}
 
 		size = 0x20 + smbios_anchor->struct_table_length;
@@ -193,7 +192,7 @@ static efi_status_t do_save(u16 *filename)
 		ret = bs->allocate_pool(EFI_LOADER_DATA, size, (void **)&buf);
 		if (ret != EFI_SUCCESS) {
 			error(u"Out of memory\n");
-			return ret;
+			return;
 		}
 
 		memset(buf, 0, size);
@@ -210,8 +209,6 @@ static efi_status_t do_save(u16 *filename)
 			checksum(smbios_anchor, smbios_anchor->length);
 	}
 
-	filename = skip_whitespace(filename);
-
 	ret = save_file(filename, buf, size);
 
 	if (ret == EFI_SUCCESS) {
@@ -220,65 +217,10 @@ static efi_status_t do_save(u16 *filename)
 	}
 
 	bs->free_pool(buf);
-
-	return ret;
 }
 
-/**
- * command_loop() - process user commands
- */
-static void command_loop(void)
-{
-	for (;;) {
-		u16 command[BUFFER_SIZE];
-		u16 *pos;
-		efi_uintn_t ret;
-
-		efi_drain_input();
-		print(u"=> ");
-		ret = efi_input(command, sizeof(command));
-		if (ret == EFI_ABORTED)
-			break;
-		pos = skip_whitespace(command);
-		if (starts_with(pos, u"exit")) {
-			break;
-		} else if (starts_with(pos, u"check")) {
-			ret = do_check();
-			if (ret == EFI_SUCCESS)
-				print(u"OK\n");
-		} else if (starts_with(pos, u"save ")) {
-			do_save(pos + 5);
-		} else {
-			do_help();
-		}
-	}
-}
-
-/**
- * efi_main() - entry point of the EFI application.
- *
- * @handle:	handle of the loaded image
- * @systab:	system table
- * Return:	status code
- */
-efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
-			     struct efi_system_table *systab)
-{
-	efi_app_init(systab, image_handle);
-
-	handle = image_handle;
-	systable = systab;
-	bs = systable->boottime;
-
-	color(EFI_WHITE);
-	cls();
-	print(u"SMBIOS Dump\r\n===========\r\n\r\n");
-	color(EFI_LIGHTBLUE);
-
-	command_loop();
-
-	color(EFI_LIGHTGRAY);
-	cls();
-
-	return EFI_SUCCESS;
-}
+struct efi_app_cmd app_cmds[] = {
+	{ u"check", u"check - check SMBIOS table\r\n", do_check },
+	{ u"save ", u"save <file> - save SMBIOS table to file\r\n", do_save },
+	{ }
+};
-- 
2.53.0

