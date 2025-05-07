Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01960C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 14:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB42D8291D;
	Wed,  7 May 2025 16:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IRB44KwJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 183C18288D; Wed,  7 May 2025 16:45:42 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8013D82162
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 16:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b03bc416962so4928219a12.0
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 07:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746629138; x=1747233938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GUWA0dOPP2t1LaF6HB2aEND6HWdmGoMCy1tHhTUpEt0=;
 b=IRB44KwJzLIqgvy4sIHcWMI+XJFc2JeTWAEHAf0zMAd3Ytgyx/v2WULDxEz+UwoQUA
 GXFycKZVfmRLVoF1r1kMqIF9xh4E0y2FrdzVwCJFGHlDaFzjkY2Xhb12zeZDE131lax1
 DY/7r7lKPWIXreSY+SMDz7Ci/4Se67krseaqepoIDmDd0UsGPnvRkQ9JsFSJujiXS0f6
 6mHaQ29pAFJtIfT4fLb79PLYSpd27UHPKHNyB+HFyqqrNmTwaBhKEyxdMyXz80jTWD1t
 H5X+YGkAq5mkV9ZpPLk2vpRBHZUx+FD1EZihug5JO0BRtCnxGM3OcvM9rIawId07XL7k
 TLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746629138; x=1747233938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GUWA0dOPP2t1LaF6HB2aEND6HWdmGoMCy1tHhTUpEt0=;
 b=MhR6jflGGHdG5+p5Z+U64EwASa8XSfJBLq4jhrvA02BRth6miAq/9UjASZYcwOJzb7
 9mCPGGO38wuRo/s7cKILL6s65wIuYKeFON7mruNfl5tW3IaESuHdojouVlg4urXdeoM/
 GV30HxE3MCrsXlJ8cuxMjQNc9HyVMtsc576k60TOwg8gbJdZwC23A8phkZRhh+o+78Ke
 MfT23Dad3KwSUKezMeVE+EuPyq+kN1TXNhlwITEuf7/0dN/CRiciLsOXJWb4+b9XUCb8
 v9iOIU4ymtImLu4Yvk9vH+M0zz+cMdbmns5pPV23Flszw5Lw7RqwIIBx4fuBaCJe04pF
 PnQA==
X-Gm-Message-State: AOJu0YyBNhQbuieD8ZDRjBZCV/q0HvPE2SOtt4vETR3wAI7Hs3TYliPX
 wvpFnW5Vyr1HUcYAOxENoSL3KX6mn5lFfnUyB+iIS1z592Oxuar4vFtmRiPy6R8=
X-Gm-Gg: ASbGncsXbs+CMvW0jkHWqdPHG8cw00FIWjyvlOht2x4l1Glm7jhTnwtBSOexaifmnja
 crxqcKFTAe35V/yhxfOT9tflnI1+QlfmRK749sxzA80e+y4ZJDfqvGuYa2pphsQxl3eX1VaBfvj
 coNKFgf01BrodqvbyZp/sG8hTsBa1ldZamGN9pgVLBCtyyAwUyGYfZutaPbLT1uOFD1PkQmebR4
 qXe2BCYhfK2jHxOc8uo2uVKbpyj8+MrfzTrNS2jZYZ2y1WEkDNbk5g21ZpLwIK70kXEbPmi9vJm
 OGARJI6UKjL2N3IaaH/+daWPVD6ZOLMhRZG6Hoeu7kzMVmtaArJGsOE+asyZ
X-Google-Smtp-Source: AGHT+IG9DCcuG5QH4mUNqTsYtyzGQ7Lx04WnHVVWV8R7cgtovBLoAZ9JcPcr4JGilDPkkfjnSLsutA==
X-Received: by 2002:a05:6a21:329d:b0:206:a9fe:a4c with SMTP id
 adf61e73a8af0-2148cd2f0b2mr5205942637.28.1746629137929; 
 Wed, 07 May 2025 07:45:37 -0700 (PDT)
Received: from adriano.. ([190.215.87.40]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7a30esm11710235b3a.13.2025.05.07.07.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 07:45:37 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 2/3] efi_loader: fix dtbdump output color and format
Date: Wed,  7 May 2025 10:46:18 -0400
Message-ID: <20250507144619.3288456-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250507144619.3288456-1-adriano.cordova@canonical.com>
References: <20250507144619.3288456-1-adriano.cordova@canonical.com>
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

Imitate in dtbdump what initrddump does for color,
newlines and input handling. The output parsing in
the CI is strict and with the current output the CI
is not recongnizing the prompt '=>'.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/dtbdump.c | 86 ++++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 12 deletions(-)

diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
index a3d59a2fd3b..1e72404ecc1 100644
--- a/lib/efi_loader/dtbdump.c
+++ b/lib/efi_loader/dtbdump.c
@@ -29,6 +29,18 @@ static struct efi_system_table *systable;
 static const efi_guid_t efi_dt_fixup_protocol_guid = EFI_DT_FIXUP_PROTOCOL_GUID;
 static const efi_guid_t efi_file_info_guid = EFI_FILE_INFO_GUID;
 static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
+static bool nocolor;
+
+/**
+ * color() - set foreground color
+ *
+ * @color:	foreground color
+ */
+static void color(u8 color)
+{
+	if (!nocolor)
+		cout->set_attribute(cout, color | EFI_BACKGROUND_BLACK);
+}
 
 /**
  * print() - print string
@@ -87,6 +99,17 @@ static void printx(unsigned char val)
 	print_hex_digit(val & 0xf);
 }
 
+/**
+ * cls() - clear screen
+ */
+static void cls(void)
+{
+	if (nocolor)
+		print(u"\r\n");
+	else
+		cout->clear_screen(cout);
+}
+
 /**
  * error() - print error string
  *
@@ -94,9 +117,17 @@ static void printx(unsigned char val)
  */
 static void error(u16 *string)
 {
-	cout->set_attribute(cout, EFI_LIGHTRED | EFI_BACKGROUND_BLACK);
+	color(EFI_LIGHTRED);
 	print(string);
-	cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
+	color(EFI_LIGHTBLUE);
+}
+
+/**
+ * efi_drain_input() - drain console input
+ */
+static void efi_drain_input(void)
+{
+	cin->reset(cin, true);
 }
 
 /**
@@ -116,8 +147,6 @@ static efi_status_t efi_input_yn(void)
 	efi_uintn_t index;
 	efi_status_t ret;
 
-	/* Drain the console input */
-	ret = cin->reset(cin, true);
 	for (;;) {
 		ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
 		if (ret != EFI_SUCCESS)
@@ -158,8 +187,6 @@ static efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
 	u16 outbuf[2] = u" ";
 	efi_status_t ret;
 
-	/* Drain the console input */
-	ret = cin->reset(cin, true);
 	*buffer = 0;
 	for (;;) {
 		ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
@@ -262,6 +289,9 @@ static u16 *skip_whitespace(u16 *pos)
  */
 static bool starts_with(u16 *string, u16 *keyword)
 {
+	if (!string || !keyword)
+		return false;
+
 	for (; *keyword; ++string, ++keyword) {
 		if (*string != *keyword)
 			return false;
@@ -737,6 +767,7 @@ static efi_status_t do_dump(void)
 				error(u"Missing end node\r\n");
 				return EFI_LOAD_ERROR;
 			}
+			print(u"\r\n");
 			return EFI_SUCCESS;
 		default:
 			error(u"Invalid device tree token\r\n");
@@ -748,6 +779,30 @@ static efi_status_t do_dump(void)
 	return EFI_LOAD_ERROR;
 }
 
+/**
+ * get_load_options() - get load options
+ *
+ * Return:	load options or NULL
+ */
+static u16 *get_load_options(void)
+{
+	efi_status_t ret;
+	struct efi_loaded_image *loaded_image;
+
+	ret = bs->open_protocol(handle, &loaded_image_guid,
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
 /**
  * efi_main() - entry point of the EFI application.
  *
@@ -758,24 +813,31 @@ static efi_status_t do_dump(void)
 efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
 			     struct efi_system_table *systab)
 {
+	u16 *load_options;
+
 	handle = image_handle;
 	systable = systab;
 	cerr = systable->std_err;
 	cout = systable->con_out;
 	cin = systable->con_in;
 	bs = systable->boottime;
+	load_options = get_load_options();
+
+	if (starts_with(load_options, u"nocolor"))
+		nocolor = true;
 
-	cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
-	cout->clear_screen(cout);
-	cout->set_attribute(cout, EFI_WHITE | EFI_BACKGROUND_BLACK);
+	color(EFI_LIGHTBLUE);
+	cls();
+	color(EFI_WHITE);
 	print(u"DTB Dump\r\n========\r\n\r\n");
-	cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
+	color(EFI_LIGHTBLUE);
 
 	for (;;) {
 		u16 command[BUFFER_SIZE];
 		u16 *pos;
 		efi_uintn_t ret;
 
+		efi_drain_input();
 		print(u"=> ");
 		ret = efi_input(command, sizeof(command));
 		if (ret == EFI_ABORTED)
@@ -793,7 +855,7 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
 			do_help();
 	}
 
-	cout->set_attribute(cout, EFI_LIGHTGRAY | EFI_BACKGROUND_BLACK);
-	cout->clear_screen(cout);
+	color(EFI_LIGHTGRAY);
+	cls();
 	return EFI_SUCCESS;
 }
-- 
2.48.1

