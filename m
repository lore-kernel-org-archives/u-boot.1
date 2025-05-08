Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A061BC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 18:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41B6C82A1C;
	Thu,  8 May 2025 20:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GBGwmgq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BCBF82A1C; Thu,  8 May 2025 20:29:58 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3D358269F
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 20:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-30a452d3b38so1293661a91.3
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 11:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746728994; x=1747333794; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QRInZxIIU/PEehWhaLTeMxzfVkYyWYebiM0VQyuUOc=;
 b=GBGwmgq4e0iCooN536mt5rkmyq4xLfnqF6XMl07Im25p/CanBtGnicAAurli9zCxsu
 tXPhmAybFqxFstQlgVhqWG51lfdkaGYubWH4u/kZ+QvMCrEGSGfFD6iBMVr2L0qQyeNr
 B8ircigN4s4XKyReiwPS8+rhhJGk6HliPcuoGNiqKApALKdGnLbbqgeo/06jS0pDCaqC
 p0zsfhEE5SjHDbe8B0YKu+l6g4ULP7c7GqK867Kqcb46kkHzSGtXXoE+cRVKOaW6kMNW
 zZMmH6lm+/Piwh/xawpLs5tpoBOck42TE0G0UfooPX0T8VuvQtg+JqykdORiLwvC4E8z
 Flvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746728994; x=1747333794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4QRInZxIIU/PEehWhaLTeMxzfVkYyWYebiM0VQyuUOc=;
 b=smOxz5ah8epZZS3KzN1VlJ188KeDrp6gezVi+/bpbsz4C+fy72RYc1ZoOS/PBfUcMY
 UHU005kNwAE4o4H6eRcJbPhbwXVgJE6XIru0onQA85rp5TZUlpEs4vcB7WKsIih3gNAD
 U+nfvhf866de4lJv0JyF27eD9VVf68Q6D/ZcyFtVuprojoJV39RHUDXxcaE6RCVSj4vf
 EFXwvoh7awU48qCUzZ+7vaSQl8rOLGLlwxN3qgZRvfUAExckqoSxzTU8i/6Qu6AaweB4
 fX91ZMBS4M5SAnvXM5rlx7xCb4JrmRw0hUOK2DAuVbBoIPgBJjaG/0K7gLm7IE2dqHye
 n+MQ==
X-Gm-Message-State: AOJu0Yzs1mdSxRUgNLyD+QY+wcR5qqQQIig60gQHfZbf08ZedkTeD4xH
 dRa5cCTFXm66VAkDh3vv6Tp60/jo/F0JG6oWtrohrqE0Q/fhKMCRT5ktKBzVZrY=
X-Gm-Gg: ASbGncvma9qd0TtdbyJoP+uxL8iqfIJjwd7XPClkRMWa6CEsEwVZM7bEVMM3CYU8RBA
 QJ3H5zQsAyj723mCg6bisE79aROZzX/ysJAigxahPg4QIxGLf2Ecgxjdzez9rPzZjWX01GCw0T+
 mRXkYaKRLofqkCYhvPMRJnAife0huF9usC56FWcj1t2+6gq79HZa5aACc8fR7m5Urlf1P4Z0HpP
 oAkuKRCgtI6FPXow0prtwS9iiECtrtiK0D54Z68o5y8CTwMJkJUo4aN6cgQKygdxavtao6Po7ck
 59LHFg4rDeD1iV0qtSkzJ2z2R27Es5VHu6+/fqUIGkNijJZKxA3f
X-Google-Smtp-Source: AGHT+IGuFSj3Ec88dyCMYyrXj/XKISCOMQG1WxvDgL5cMOke58mLHEkajN5GXGxf9EikDsTn2CBH2A==
X-Received: by 2002:a17:90b:1e53:b0:2fc:3264:3666 with SMTP id
 98e67ed59e1d1-30c3d64d90amr736167a91.30.1746728994242; 
 Thu, 08 May 2025 11:29:54 -0700 (PDT)
Received: from adriano.. ([186.175.203.217]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad4d56981sm2495031a91.28.2025.05.08.11.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 11:29:53 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/3] efi_loader: fix dtbdump output color and format
Date: Thu,  8 May 2025 14:30:33 -0400
Message-ID: <20250508183034.3439777-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250508183034.3439777-1-adriano.cordova@canonical.com>
References: <20250508183034.3439777-1-adriano.cordova@canonical.com>
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
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---

(no changes since v1)

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

