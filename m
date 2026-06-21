Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EB7CDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 08:20:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DB38849EA;
	Sun, 21 Jun 2026 10:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gc4w9qe4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B5B849BB; Sun, 21 Jun 2026 10:19:26 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 500F584844
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 10:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-176-006-085-155.176.6.pool.telefonica.de
 [176.6.85.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A27E242081; 
 Sun, 21 Jun 2026 08:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782029962;
 bh=qDtvn/4uywnwpZEnftJiEuqHFjPrj2FaC0Aq3O7qYbQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=gc4w9qe4xjPjR9FGnpWLT22pGIDeyJBx94otPJ/ayl8S1zHeNXlg5bOx+l2l8UNwb
 BYruHE2O+OGZ0VBBybijAtxkXMnQMM5dC7ZTLu5JWH/0XHi1YxghSa7n320LGJkL6B
 ql4gAOx+4jIteeFI+miUWOKkTZPbCEKpzOKqiTCKZGv4XquhKJuOR61zCwFgK8cx++
 NR5LqYFTfXNgoXkWSLXqFqSJuk5IYGmA7A8R1u92yJEww1klyeYGQISwZZCaixZJfP
 8Cv21KNrbXyd53msz07YXNQHrNB3kxr/jizMzEsyv73BDkgtwl3ioM/cMLtAatZ95Y
 lshXvCFmnouyT1kYzJNfYnmHh+kfDKkTOEwG6Zy8Vh6ZFywap3dTGfTK0z/MWDJ7OW
 7DZ3hEw1Zd5zlZb9OeN0haAembYNRolvucsbVuTQ7uGzECyxCQzUrMkXJVBQl3YOjq
 NIqv1FWtg+r/yvw11xH+cp+WZdrLaOnvE/yhTIszeedwitqTGdZBBGJmwIqxWIEcg0
 rJHN7A7ErfDRG69c85YkBmn6aU5cboEG5Ue/ygjmdva2l6oF4SuiuQ4hV/PLt/nsx6
 BrXv+q3RY9/G7bu87FjciBT4iEfSyKEPZzLRTHo957UokZkpQK6cKFCQ8FeM6CPZ9v
 LihWczdQDiT2mBC+ESNCuXSI=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 06/11] efi_loader: move console-input helpers to
 efi_app_common
Date: Sun, 21 Jun 2026 10:19:10 +0200
Message-ID: <20260621081915.19154-7-heinrich.schuchardt@canonical.com>
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

Move the shared console-input helpers to efi_app_common:

* efi_drain_input() - drain the console input queue
* efi_input_yn()    - read a y/n/ESC key from the user
* efi_input()       - read a UTF-16 string from the console

The common efi_input_yn() calls efi_drain_input() once at entry,
replacing the open-coded cin->reset() calls that each application
previously duplicated.

dbginfodump and smbiosdump had no efi_drain_input() call in their
command loops; add the call so the console queue is drained before
each prompt, fixing a latent input-echo artefact.

The common state is extended with a cin pointer (initialized by
efi_app_init from sys_table->con_in) so the helpers can access the
console-input protocol without additional parameters.

Remove the now-duplicate static definitions from dtbdump, initrddump,
smbiosdump and dbginfodump.

smbiosdump: fix kernel-doc tag for command_loop() from "command_loop -"
to "command_loop() -" to follow the kernel-doc convention.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 lib/efi_loader/dbginfodump.c    |  61 ------------------
 lib/efi_loader/dtbdump.c        | 109 --------------------------------
 lib/efi_loader/efi_app_common.c |  88 ++++++++++++++++++++++++++
 lib/efi_loader/efi_app_common.h |  29 +++++++++
 lib/efi_loader/initrddump.c     | 109 --------------------------------
 lib/efi_loader/smbiosdump.c     | 108 +------------------------------
 6 files changed, 119 insertions(+), 385 deletions(-)

diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
index 2dcff2a11fe..8fa60a7f48e 100644
--- a/lib/efi_loader/dbginfodump.c
+++ b/lib/efi_loader/dbginfodump.c
@@ -14,7 +14,6 @@
 #define BUFFER_SIZE 64
 
 static struct efi_simple_text_output_protocol *cout;
-static struct efi_simple_text_input_protocol *cin;
 static efi_handle_t handle;
 static struct efi_system_table *systable;
 static struct efi_boot_services *bs;
@@ -83,65 +82,6 @@ static void printp(void *p)
 	print(str);
 }
 
-/**
- * efi_input() - read string from console
- *
- * @buffer:		input buffer
- * @buffer_size:	buffer size
- * Return:		status code
- */
-static efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
-{
-	struct efi_input_key key = {0};
-	efi_uintn_t index;
-	efi_uintn_t pos = 0;
-	u16 outbuf[2] = u" ";
-	efi_status_t ret;
-
-	/* Drain the console input */
-	ret = cin->reset(cin, true);
-	*buffer = 0;
-	for (;;) {
-		ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
-		if (ret != EFI_SUCCESS)
-			continue;
-		ret = cin->read_key_stroke(cin, &key);
-		if (ret != EFI_SUCCESS)
-			continue;
-		switch (key.scan_code) {
-		case 0x17: /* Escape */
-			print(u"\r\nAborted\r\n");
-			return EFI_ABORTED;
-		default:
-			break;
-		}
-		switch (key.unicode_char) {
-		case 0x08: /* Backspace */
-			if (pos) {
-				buffer[pos--] = 0;
-				print(u"\b \b");
-			}
-			break;
-		case 0x0a: /* Linefeed */
-		case 0x0d: /* Carriage return */
-			print(u"\r\n");
-			return EFI_SUCCESS;
-		default:
-			break;
-		}
-		/* Ignore surrogate codes */
-		if (key.unicode_char >= 0xD800 && key.unicode_char <= 0xDBFF)
-			continue;
-		if (key.unicode_char >= 0x20 &&
-		    pos < buffer_size - 1) {
-			*outbuf = key.unicode_char;
-			buffer[pos++] = key.unicode_char;
-			buffer[pos] = 0;
-			print(outbuf);
-		}
-	}
-}
-
 /**
  * skip_whitespace() - skip over leading whitespace
  *
@@ -277,7 +217,6 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
 	handle = image_handle;
 	systable = systab;
 	cout = systable->con_out;
-	cin = systable->con_in;
 	bs = systable->boottime;
 
 	cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
index 1468955eb8c..716daf4a90f 100644
--- a/lib/efi_loader/dtbdump.c
+++ b/lib/efi_loader/dtbdump.c
@@ -16,7 +16,6 @@
 
 #define efi_size_in_pages(size) ((size + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT)
 
-static struct efi_simple_text_input_protocol *cin;
 static struct efi_boot_services *bs;
 static const efi_guid_t fdt_guid = EFI_FDT_GUID;
 static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
@@ -50,113 +49,6 @@ static void print_char(unsigned char c)
 	print(out);
 }
 
-/**
- * efi_drain_input() - drain console input
- */
-static void efi_drain_input(void)
-{
-	cin->reset(cin, true);
-}
-
-/**
- * efi_input_yn() - get answer to yes/no question
- *
- * Return:
- * y or Y
- *     EFI_SUCCESS
- * n or N
- *     EFI_ACCESS_DENIED
- * ESC
- *     EFI_ABORTED
- */
-static efi_status_t efi_input_yn(void)
-{
-	struct efi_input_key key = {0};
-	efi_uintn_t index;
-	efi_status_t ret;
-
-	for (;;) {
-		ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
-		if (ret != EFI_SUCCESS)
-			continue;
-		ret = cin->read_key_stroke(cin, &key);
-		if (ret != EFI_SUCCESS)
-			continue;
-		switch (key.scan_code) {
-		case 0x17: /* Escape */
-			return EFI_ABORTED;
-		default:
-			break;
-		}
-		/* Convert to lower case */
-		switch (key.unicode_char | 0x20) {
-		case 'y':
-			return EFI_SUCCESS;
-		case 'n':
-			return EFI_ACCESS_DENIED;
-		default:
-			break;
-		}
-	}
-}
-
-/**
- * efi_input() - read string from console
- *
- * @buffer:		input buffer
- * @buffer_size:	buffer size
- * Return:		status code
- */
-static efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
-{
-	struct efi_input_key key = {0};
-	efi_uintn_t index;
-	efi_uintn_t pos = 0;
-	u16 outbuf[2] = u" ";
-	efi_status_t ret;
-
-	*buffer = 0;
-	for (;;) {
-		ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
-		if (ret != EFI_SUCCESS)
-			continue;
-		ret = cin->read_key_stroke(cin, &key);
-		if (ret != EFI_SUCCESS)
-			continue;
-		switch (key.scan_code) {
-		case 0x17: /* Escape */
-			print(u"\r\nAborted\r\n");
-			return EFI_ABORTED;
-		default:
-			break;
-		}
-		switch (key.unicode_char) {
-		case 0x08: /* Backspace */
-			if (pos) {
-				buffer[pos--] = 0;
-				print(u"\b \b");
-			}
-			break;
-		case 0x0a: /* Linefeed */
-		case 0x0d: /* Carriage return */
-			print(u"\r\n");
-			return EFI_SUCCESS;
-		default:
-			break;
-		}
-		/* Ignore surrogate codes */
-		if (key.unicode_char >= 0xD800 && key.unicode_char <= 0xDBFF)
-			continue;
-		if (key.unicode_char >= 0x20 &&
-		    pos < buffer_size - 1) {
-			*outbuf = key.unicode_char;
-			buffer[pos++] = key.unicode_char;
-			buffer[pos] = 0;
-			print(outbuf);
-		}
-	}
-}
-
 /*
  * Convert FDT value to host endianness.
  *
@@ -702,7 +594,6 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
 
 	handle = image_handle;
 	systable = systab;
-	cin = systable->con_in;
 	bs = systable->boottime;
 
 	color(EFI_LIGHTBLUE);
diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
index e9e9334acc7..406cd236f6f 100644
--- a/lib/efi_loader/efi_app_common.c
+++ b/lib/efi_loader/efi_app_common.c
@@ -9,6 +9,7 @@
 #include "efi_app_common.h"
 
 static efi_handle_t app_handle;
+static struct efi_simple_text_input_protocol *cin;
 static struct efi_simple_text_output_protocol *cout;
 struct efi_boot_services *bs;
 static bool nocolor;
@@ -40,6 +41,7 @@ void efi_app_init(struct efi_system_table *sys_table, efi_handle_t image_handle)
 
 	app_handle = image_handle;
 	systable = sys_table;
+	cin = sys_table->con_in;
 	cout = sys_table->con_out;
 	bs = sys_table->boottime;
 
@@ -104,3 +106,89 @@ bool starts_with(u16 *string, u16 *keyword)
 	}
 	return true;
 }
+
+void efi_drain_input(void)
+{
+	cin->reset(cin, true);
+}
+
+efi_status_t efi_input_yn(void)
+{
+	struct efi_input_key key = { 0 };
+	efi_uintn_t index;
+	efi_status_t ret;
+
+	efi_drain_input();
+	for (;;) {
+		ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
+		if (ret != EFI_SUCCESS)
+			continue;
+		ret = cin->read_key_stroke(cin, &key);
+		if (ret != EFI_SUCCESS)
+			continue;
+		switch (key.scan_code) {
+		case 0x17: /* Escape */
+			return EFI_ABORTED;
+		default:
+			break;
+		}
+		/* Convert to lower case */
+		switch (key.unicode_char | 0x20) {
+		case 'y':
+			return EFI_SUCCESS;
+		case 'n':
+			return EFI_ACCESS_DENIED;
+		default:
+			break;
+		}
+	}
+}
+
+efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
+{
+	struct efi_input_key key = { 0 };
+	efi_uintn_t index;
+	efi_uintn_t pos = 0;
+	u16 outbuf[2] = u" ";
+	efi_status_t ret;
+
+	*buffer = 0;
+	for (;;) {
+		ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
+		if (ret != EFI_SUCCESS)
+			continue;
+		ret = cin->read_key_stroke(cin, &key);
+		if (ret != EFI_SUCCESS)
+			continue;
+		switch (key.scan_code) {
+		case 0x17: /* Escape */
+			print(u"\r\nAborted\r\n");
+			return EFI_ABORTED;
+		default:
+			break;
+		}
+		switch (key.unicode_char) {
+		case 0x08: /* Backspace */
+			if (pos) {
+				buffer[pos--] = 0;
+				print(u"\b \b");
+			}
+			break;
+		case 0x0a: /* Linefeed */
+		case 0x0d: /* Carriage return */
+			print(u"\r\n");
+			return EFI_SUCCESS;
+		default:
+			break;
+		}
+		/* Ignore surrogate codes */
+		if (key.unicode_char >= 0xD800 && key.unicode_char <= 0xDBFF)
+			continue;
+		if (key.unicode_char >= 0x20 && pos < buffer_size - 1) {
+			*outbuf = key.unicode_char;
+			buffer[pos++] = key.unicode_char;
+			buffer[pos] = 0;
+			print(outbuf);
+		}
+	}
+}
diff --git a/lib/efi_loader/efi_app_common.h b/lib/efi_loader/efi_app_common.h
index 45c17a8ed99..4498607ef07 100644
--- a/lib/efi_loader/efi_app_common.h
+++ b/lib/efi_loader/efi_app_common.h
@@ -64,4 +64,33 @@ void error(u16 *string);
  */
 bool starts_with(u16 *string, u16 *keyword);
 
+/**
+ * efi_drain_input() - drain console input
+ */
+void efi_drain_input(void);
+
+/**
+ * efi_input_yn() - get answer to yes/no question
+ *
+ * Drains the console input before reading.
+ *
+ * Return:
+ * y or Y
+ *     EFI_SUCCESS
+ * n or N
+ *     EFI_ACCESS_DENIED
+ * ESC
+ *     EFI_ABORTED
+ */
+efi_status_t efi_input_yn(void);
+
+/**
+ * efi_input() - read string from console
+ *
+ * @buffer:             input buffer
+ * @buffer_size:        buffer size
+ * Return:              status code
+ */
+efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size);
+
 #endif /* _EFI_APP_COMMON_H */
diff --git a/lib/efi_loader/initrddump.c b/lib/efi_loader/initrddump.c
index 60f8a020e8c..52562be048d 100644
--- a/lib/efi_loader/initrddump.c
+++ b/lib/efi_loader/initrddump.c
@@ -19,7 +19,6 @@
 
 static struct efi_system_table *systable;
 static struct efi_boot_services *bs;
-static struct efi_simple_text_input_protocol *cin;
 static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
 static const efi_guid_t guid_simple_file_system_protocol =
 					EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
@@ -46,113 +45,6 @@ static const struct efi_lo_dp_prefix initrd_dp = {
 	}
 };
 
-/**
- * efi_drain_input() - drain console input
- */
-static void efi_drain_input(void)
-{
-	cin->reset(cin, true);
-}
-
-/**
- * efi_input_yn() - get answer to yes/no question
- *
- * Return:
- * y or Y
- *     EFI_SUCCESS
- * n or N
- *     EFI_ACCESS_DENIED
- * ESC
- *     EFI_ABORTED
- */
-static efi_status_t efi_input_yn(void)
-{
-	struct efi_input_key key = {0};
-	efi_uintn_t index;
-	efi_status_t ret;
-
-	for (;;) {
-		ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
-		if (ret != EFI_SUCCESS)
-			continue;
-		ret = cin->read_key_stroke(cin, &key);
-		if (ret != EFI_SUCCESS)
-			continue;
-		switch (key.scan_code) {
-		case 0x17: /* Escape */
-			return EFI_ABORTED;
-		default:
-			break;
-		}
-		/* Convert to lower case */
-		switch (key.unicode_char | 0x20) {
-		case 'y':
-			return EFI_SUCCESS;
-		case 'n':
-			return EFI_ACCESS_DENIED;
-		default:
-			break;
-		}
-	}
-}
-
-/**
- * efi_input() - read string from console
- *
- * @buffer:		input buffer
- * @buffer_size:	buffer size
- * Return:		status code
- */
-static efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
-{
-	struct efi_input_key key = {0};
-	efi_uintn_t index;
-	efi_uintn_t pos = 0;
-	u16 outbuf[2] = u" ";
-	efi_status_t ret;
-
-	*buffer = 0;
-	for (;;) {
-		ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
-		if (ret != EFI_SUCCESS)
-			continue;
-		ret = cin->read_key_stroke(cin, &key);
-		if (ret != EFI_SUCCESS)
-			continue;
-		switch (key.scan_code) {
-		case 0x17: /* Escape */
-			print(u"\r\nAborted\r\n");
-			return EFI_ABORTED;
-		default:
-			break;
-		}
-		switch (key.unicode_char) {
-		case 0x08: /* Backspace */
-			if (pos) {
-				buffer[pos--] = 0;
-				print(u"\b \b");
-			}
-			break;
-		case 0x0a: /* Linefeed */
-		case 0x0d: /* Carriage return */
-			print(u"\r\n");
-			return EFI_SUCCESS;
-		default:
-			break;
-		}
-		/* Ignore surrogate codes */
-		if (key.unicode_char >= 0xD800 && key.unicode_char <= 0xDBFF)
-			continue;
-		if (key.unicode_char >= 0x20 &&
-		    pos < buffer_size - 1) {
-			*outbuf = key.unicode_char;
-			buffer[pos++] = key.unicode_char;
-			buffer[pos] = 0;
-			print(outbuf);
-		}
-	}
-}
-
 /**
  * skip_whitespace() - skip over leading whitespace
  *
@@ -356,7 +248,6 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
 
 	handle = image_handle;
 	systable = systab;
-	cin = systable->con_in;
 	bs = systable->boottime;
 
 	color(EFI_WHITE);
diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
index e19214d798f..100e03294e5 100644
--- a/lib/efi_loader/smbiosdump.c
+++ b/lib/efi_loader/smbiosdump.c
@@ -15,7 +15,6 @@
 
 #define BUFFER_SIZE 64
 
-static struct efi_simple_text_input_protocol *cin;
 static struct efi_boot_services *bs;
 static efi_handle_t handle;
 static struct efi_system_table *systable;
@@ -26,109 +25,6 @@ static const efi_guid_t guid_simple_file_system_protocol =
 					EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
 static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
 
-/**
- * efi_input_yn() - get answer to yes/no question
- *
- * Return:
- * y or Y
- *     EFI_SUCCESS
- * n or N
- *     EFI_ACCESS_DENIED
- * ESC
- *     EFI_ABORTED
- */
-static efi_status_t efi_input_yn(void)
-{
-	struct efi_input_key key = {0};
-	efi_uintn_t index;
-	efi_status_t ret;
-
-	/* Drain the console input */
-	ret = cin->reset(cin, true);
-	for (;;) {
-		ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
-		if (ret != EFI_SUCCESS)
-			continue;
-		ret = cin->read_key_stroke(cin, &key);
-		if (ret != EFI_SUCCESS)
-			continue;
-		switch (key.scan_code) {
-		case 0x17: /* Escape */
-			return EFI_ABORTED;
-		default:
-			break;
-		}
-		/* Convert to lower case */
-		switch (key.unicode_char | 0x20) {
-		case 'y':
-			return EFI_SUCCESS;
-		case 'n':
-			return EFI_ACCESS_DENIED;
-		default:
-			break;
-		}
-	}
-}
-
-/**
- * efi_input() - read string from console
- *
- * @buffer:		input buffer
- * @buffer_size:	buffer size
- * Return:		status code
- */
-static efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
-{
-	struct efi_input_key key = {0};
-	efi_uintn_t index;
-	efi_uintn_t pos = 0;
-	u16 outbuf[2] = u" ";
-	efi_status_t ret;
-
-	/* Drain the console input */
-	ret = cin->reset(cin, true);
-	*buffer = 0;
-	for (;;) {
-		ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
-		if (ret != EFI_SUCCESS)
-			continue;
-		ret = cin->read_key_stroke(cin, &key);
-		if (ret != EFI_SUCCESS)
-			continue;
-		switch (key.scan_code) {
-		case 0x17: /* Escape */
-			print(u"\r\nAborted\r\n");
-			return EFI_ABORTED;
-		default:
-			break;
-		}
-		switch (key.unicode_char) {
-		case 0x08: /* Backspace */
-			if (pos) {
-				buffer[pos--] = 0;
-				print(u"\b \b");
-			}
-			break;
-		case 0x0a: /* Linefeed */
-		case 0x0d: /* Carriage return */
-			print(u"\r\n");
-			return EFI_SUCCESS;
-		default:
-			break;
-		}
-		/* Ignore surrogate codes */
-		if (key.unicode_char >= 0xD800 && key.unicode_char <= 0xDBFF)
-			continue;
-		if (key.unicode_char >= 0x20 &&
-		    pos < buffer_size - 1) {
-			*outbuf = key.unicode_char;
-			buffer[pos++] = key.unicode_char;
-			buffer[pos] = 0;
-			print(outbuf);
-		}
-	}
-}
-
 /**
  * skip_whitespace() - skip over leading whitespace
  *
@@ -467,7 +363,7 @@ static efi_status_t do_save(u16 *filename)
 }
 
 /**
- * command_loop - process user commands
+ * command_loop() - process user commands
  */
 static void command_loop(void)
 {
@@ -476,6 +372,7 @@ static void command_loop(void)
 		u16 *pos;
 		efi_uintn_t ret;
 
+		efi_drain_input();
 		print(u"=> ");
 		ret = efi_input(command, sizeof(command));
 		if (ret == EFI_ABORTED)
@@ -509,7 +406,6 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
 
 	handle = image_handle;
 	systable = systab;
-	cin = systable->con_in;
 	bs = systable->boottime;
 
 	color(EFI_WHITE);
-- 
2.53.0

