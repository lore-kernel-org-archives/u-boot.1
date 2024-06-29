Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B80C2BD09
	for <u-boot@archiver.kernel.org>; Sat, 29 Jun 2024 00:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4178859F;
	Sat, 29 Jun 2024 02:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="k5n3siM2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C12D9885A2; Sat, 29 Jun 2024 02:51:38 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A20CF8785E
 for <u-boot@lists.denx.de>; Sat, 29 Jun 2024 02:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-041-025.um47.pools.vodafone-ip.de
 [178.202.41.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 000E73F0FE; 
 Sat, 29 Jun 2024 00:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1719622296;
 bh=Vr28eezZakESFm5zbSL86JCk5jVRavkfOJV+uLolvP4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=k5n3siM2NL7W9fEw6HH+1uBRO+PDHjkDJ0DnWpXs9pZ2yVRcmqTRl00QhZqcFSTEi
 fgSjnFVRdjujJfjHaBP5+roj/M2U623JoeJPB/7Gsk8btkbQ1XQ9XtJrz5Jia+cGg9
 bbPNzVBgZD+Fp3ofDByvguSyY+uEpAM48AtGjX48EvJglfr1LzzRcG7ee/8o+sqnF0
 0Gg6djgh+XJrBD7d95x08mjKu/7LFPrWfH6R3krNQzS7lrk8+X5ylQYUfFPAU5eNhk
 DMqr3rohpfjxxxgk9gX0owTCb92c6hOpDqlVsOaYAhiAunPuowK4KGeCrLDzlONZA5
 zEyuqyfv3mdGA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: print device-tree in dtbdump.efi
Date: Sat, 29 Jun 2024 02:51:09 +0200
Message-ID: <20240629005109.172390-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

The dtbdump.efi binary can be used for testing the EFI_DT_FIXUP_PROTOCOL.
It provides a command to load a file and have it fixed up and a
command to save the resulting file.

Add a command 'dump' for displaying the device-tree.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/dtbdump.c | 228 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
index 5f39cf22da7..8dbd69a56ef 100644
--- a/lib/efi_loader/dtbdump.c
+++ b/lib/efi_loader/dtbdump.c
@@ -40,6 +40,53 @@ static void print(u16 *string)
 	cout->output_string(cout, string);
 }
 
+/**
+ * print_char() - print character
+ *
+ * 0x00 is replaced by '", "'.
+ *
+ * @c:	- character
+ */
+static void print_char(unsigned char c)
+{
+	u16 out[2] = u"?";
+
+	if (!c) {
+		print(u"\", \"");
+		return;
+	}
+
+	if (c > 0x1f && c < 0x80)
+		out[0] = c;
+
+	print(out);
+}
+
+/**
+ * print_hex_digit() - print hexadecimal digit
+ *
+ * @digit:	digit to print
+ */
+static void print_hex_digit(unsigned char digit)
+{
+	if (digit < 10)
+		digit += '0';
+	else
+		digit += 'a' - 10;
+	print_char(digit);
+}
+
+/**
+ * printx() - print hexadecimal byte
+ *
+ * @val:	value to print
+ */
+static void printx(unsigned char val)
+{
+	print_hex_digit(val >> 4);
+	print_hex_digit(val & 0xf);
+}
+
 /**
  * error() - print error string
  *
@@ -227,6 +274,7 @@ bool starts_with(u16 *string, u16 *keyword)
  */
 void do_help(void)
 {
+	error(u"dump       - print device-tree\r\n");
 	error(u"load <dtb> - load device-tree from file\r\n");
 	error(u"save <dtb> - save device-tree to file\r\n");
 	error(u"exit       - exit the shell\r\n");
@@ -489,6 +537,184 @@ efi_status_t do_save(u16 *filename)
 	return ret;
 }
 
+/**
+ * indent() - print a number of tabstops
+ *
+ * @level:	indentation level
+ */
+static void indent(u32 level)
+{
+	for (; level; --level)
+		print(u"\t");
+}
+
+/**
+ * is_string_value() - determine if property is a string
+ *
+ * If a property is a string, an x-string, or a u32 cannot be deducted
+ * from the device-tree. Therefore a heuristic is used.
+ *
+ * @str:	pointer to device-tree property
+ * @len:	length of the device-tree property
+ * Return:	1 for string, 0 otherwise
+ */
+static int is_string_value(const unsigned char *str, u32 len)
+{
+	int nonzero_flag = 0;
+
+	/* Zero length or not ending with 0x00 */
+	if (!len || str[len - 1])
+		return 0;
+
+	for (u32 i = 0; i < len; ++i) {
+		if (!str[i]) {
+			/* Zero length string or two consecutive 0x00 */
+			if (!nonzero_flag)
+				return 0;
+
+			nonzero_flag = 0;
+
+			continue;
+		}
+		/* Space or non-printable */
+		if (str[i] <= ' ' || str[i] >= 0x80)
+			return 0;
+
+		nonzero_flag = 1;
+	}
+
+	return 1;
+}
+
+/**
+ * print_property() - print device-tree property
+ *
+ * If a property is a string, an x-string, or a u32 cannot be deducted
+ * from the device-tree. Therefore a heuristic is used.
+ *
+ * @str:	property value
+ * @len:	length of property value
+ */
+static void print_property(const unsigned char *val, u32 len)
+{
+	if (is_string_value(val, len)) {
+		print(u"\"");
+		for (int i = 0; i < len - 1; ++i)
+			print_char(val[i]);
+		print(u"\"");
+	} else if (len & 0x3) {
+		print(u"<0x");
+		for (int i = 0; i < len; ++i)
+			printx(val[i]);
+		print(u">\"");
+	} else {
+		print(u"<");
+		for (u32 i = 0; i < len; ++i) {
+			if ((i & 0x3) == 0) {
+				if (i > 0)
+					print(u" ");
+				print(u"0x");
+			}
+			printx(val[i]);
+		}
+		print(u">");
+	}
+}
+
+/**
+ * do_dump() - print device-tree
+ */
+static efi_status_t do_dump(void)
+{
+	const char *fdt;
+	struct fdt_header *header;
+	const u32 *end;
+	const u32 *pos;
+	const char *strings;
+	u32 level = 0;
+
+	fdt = get_dtb(systable);
+	if (!fdt) {
+		error(u"DTB not found\r\n");
+		return EFI_NOT_FOUND;
+	}
+
+	header = (struct fdt_header *)fdt;
+	if (f2h(header->magic) != FDT_MAGIC) {
+		error(u"Wrong device tree magic\r\n");
+		error(u"Not a device-tree\r\n");
+		return EFI_LOAD_ERROR;
+	}
+
+	pos = (u32 *)(fdt + f2h(header->off_dt_struct));
+	end = &pos[f2h(header->totalsize) >> 2];
+	strings = fdt + f2h(header->off_dt_strings);
+
+	print(u"/");
+	for (; pos < end;) {
+		switch (f2h(pos[0])) {
+		case FDT_BEGIN_NODE: {
+			const char *c = (char *)&pos[1];
+			size_t i;
+
+			indent(level);
+			for (i = 0; c[i]; ++i)
+				print_char(c[i]);
+			print(u" {\n\r");
+
+			++level;
+			pos = &pos[2 + (i >> 2)];
+			break;
+		}
+		case FDT_PROP: {
+			struct fdt_property *prop = (struct fdt_property *)pos;
+			const unsigned char *label = &strings[f2h(prop->nameoff)];
+			u32 len = f2h(prop->len);
+			const unsigned char *str = (unsigned char *)&pos[3];
+
+			indent(level);
+			for (int i = 0; label[i]; ++i)
+				print_char(label[i]);
+
+			if (len) {
+				print(u" = ");
+				print_property(str, len);
+			}
+			print(u";\r\n");
+
+			pos = &pos[3 + ((f2h(prop->len) + 3) >> 2)];
+			break;
+		}
+		case FDT_NOP:
+			++pos;
+			break;
+		case FDT_END_NODE:
+			if (!level) {
+				error(u"Extraneous end node\r\n");
+				return EFI_LOAD_ERROR;
+			}
+
+			--level;
+			indent(level);
+			print(u"};\n\r");
+			++pos;
+			break;
+		case FDT_END:
+			if (level) {
+				error(u"Missing end node\r\n");
+				return EFI_LOAD_ERROR;
+			}
+			return EFI_SUCCESS;
+		default:
+			error(u"Invalid device tree token\r\n");
+			return EFI_LOAD_ERROR;
+		}
+	}
+	error(u"Overrun\r\n");
+
+	return EFI_LOAD_ERROR;
+}
+
 /**
  * efi_main() - entry point of the EFI application.
  *
@@ -524,6 +750,8 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
 		pos = skip_whitespace(command);
 		if (starts_with(pos, u"exit"))
 			break;
+		else if (starts_with(pos, u"dump"))
+			do_dump();
 		else if (starts_with(pos, u"load "))
 			do_load(pos + 5);
 		else if (starts_with(pos, u"save "))
-- 
2.45.2

