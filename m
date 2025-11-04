Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8811CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 20:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 067A7800B6;
	Tue,  4 Nov 2025 21:56:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZGV7+T8Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3CEF8389A; Tue,  4 Nov 2025 21:56:52 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98F7C8004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 21:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C241240958; 
 Tue,  4 Nov 2025 20:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762289808;
 bh=rTDVboI66VlaDixJZl7TcARNRiyZtOeZd1F3QaDL2jk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ZGV7+T8QcPNLNj2G9VS8ey25IfD2Y1ObvWLqOb9DaXYpqWgH9BTwOIoB7aINwRjG3
 MrHaNH51FMf4WKK0W5W5sdTfxqRKT6lNemxxayU4tV2ABz3//bg+qDwHhDZ29Cz8bE
 Xm2I9f1AbgcOnsXfkt/pzZDHgAmlleKv3pFjIpYwBStFskTwy3QM1gj4DOHPaWIVsd
 o4Km+DsntEdhtxK5ioQY0xJE06tANOWHzeniLmrlbeCey5KcnY7uy5RKyiAUMT//Kb
 FJrKP5VQU9vXIVlObYJXXmKpRfEIH6P+q+DwaUsppBy0094CkkFsPqvFv8rYoDXJxs
 AbMHb/o988vLEerRXWGWc7es+DBsn4sD1xakJyHEmxzEbIoVICHA98a5+h1sgx3y90
 X6/s3HvF0grj7RnzgKL7THuVSooaQprdDAmcPP/NY86B/KvrvQC5EEc+kG7MTKaR8q
 9CNG/xxrQX7kL1CV3QPdddar+6QfDZhM59OZPyTq4sbjfqLVZTQ7YVRBNwWC2j/V5i
 lhIIjSMnTumVxmSF9XzM1pXz6wsu/YbD0wBvgcEO+e+ki9Gox5jQBPivahWfTMSUXC
 9yF34q9n6/RQdZWnr/qV9VFoX+gfrC1U+ZlrVbRm0Sx0KzQ9dkSm00XJqm1xPgIbe5
 +icvMM4a8PqeC/2SWMA4Plnc=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_selftest: use Sphinx style comments in efi_console.c
Date: Tue,  4 Nov 2025 21:56:46 +0100
Message-ID: <20251104205646.14454-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Convert function comments in efi_selftest_console.c to match
Sphinx style.

Correct function name in print_uuid() comment.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_selftest/efi_selftest_console.c | 44 ++++++++++++-------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_console.c b/lib/efi_selftest/efi_selftest_console.c
index fd2b3d09abc..0f8e9d28ef4 100644
--- a/lib/efi_selftest/efi_selftest_console.c
+++ b/lib/efi_selftest/efi_selftest_console.c
@@ -12,12 +12,12 @@
 struct efi_simple_text_output_protocol *con_out;
 struct efi_simple_text_input_protocol *con_in;
 
-/*
- * Print a MAC address to an u16 string
+/**
+ * mac() - print a MAC address to an u16 string
  *
- * @pointer: mac address
- * @buf: pointer to buffer address
- * on return position of terminating zero word
+ * @pointer:	mac address
+ * @buf:	pointer to buffer address,
+ *		on return position of terminating zero word
  */
 static void mac(void *pointer, u16 **buf)
 {
@@ -43,7 +43,7 @@ static void mac(void *pointer, u16 **buf)
 	*buf = pos;
 }
 
-/*
+/**
  * printx() - print hexadecimal number to an u16 string
  *
  * @p:		value to print
@@ -71,7 +71,7 @@ static void printx(u64 p, int prec, u16 **buf)
 }
 
 /**
- * print_guid() - print GUID to an u16 string
+ * print_uuid() - print GUID to an u16 string
  *
  * @p:		GUID to print
  * @buf:	pointer to buffer address,
@@ -92,12 +92,12 @@ static void print_uuid(u8 *p, u16 **buf)
 	}
 }
 
-/*
- * Print an unsigned 32bit value as decimal number to an u16 string
+/**
+ * uint2dec() - print an unsigned 32bit value as decimal number to an u16 string
  *
  * @value:	value to be printed
  * @prec:	minimum number of digits to display
- * @buf:	pointer to buffer address
+ * @buf:	pointer to buffer address,
  *		on return position of terminating zero word
  */
 static void uint2dec(u32 value, int prec, u16 **buf)
@@ -132,13 +132,13 @@ static void uint2dec(u32 value, int prec, u16 **buf)
 	*buf = pos;
 }
 
-/*
- * Print a signed 32bit value as decimal number to an u16 string
+/**
+ * int2dec() - print a signed 32bit value as decimal number to an u16 string
  *
  * @value:	value to be printed
  * @prec:	minimum number of digits to display
- * @buf:	pointer to buffer address
- * on return position of terminating zero word
+ * @buf:	pointer to buffer address,
+ *		on return position of terminating zero word
  */
 static void int2dec(s32 value, int prec, u16 **buf)
 {
@@ -155,12 +155,12 @@ static void int2dec(s32 value, int prec, u16 **buf)
 	*buf = pos;
 }
 
-/*
- * Print a colored formatted string to the EFI console
+/**
+ * efi_st_printc() - print a colored message
  *
- * @color	color, see constants in efi_api.h, use -1 for no color
- * @fmt		format string
- * @...		optional arguments
+ * @color:	color, see constants in efi_api.h, use -1 for no color
+ * @fmt:	printf style format string
+ * @...:	arguments to be printed
  */
 void efi_st_printc(int color, const char *fmt, ...)
 {
@@ -271,10 +271,10 @@ void efi_st_printc(int color, const char *fmt, ...)
 		con_out->set_attribute(con_out, EFI_LIGHTGRAY);
 }
 
-/*
- * Reads an Unicode character from the input device.
+/**
+ * efi_st_get_key() - read an Unicode character from the input device
  *
- * Return: Unicode character
+ * Return:	Unicode character
  */
 u16 efi_st_get_key(void)
 {
-- 
2.51.0

