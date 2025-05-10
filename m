Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC70C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 12:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCE748283E;
	Sat, 10 May 2025 14:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WNZ/IUjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8A8782952; Sat, 10 May 2025 14:55:04 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 843F7826AA
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 14:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5fbeadf2275so5159919a12.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 05:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746881699; x=1747486499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J41z2DxcXL5coq0co94ZJQZt1Z8vab9bT0bkIAzQeMQ=;
 b=WNZ/IUjJbUyYTwCygkqQZFPX6Jzzh0oeg0WVHw+JcL7r3rMg0g4zXNY+7qSIh23lkC
 dTYPHIt0ybbm9wf3GiNQDw2iZU1xrELI07Fsb+yKh1aCdna0EMa2BnJLBejNw2RE+1CE
 KF5ZcA8kSFChZiiFzppmJl3HL+yHvrDdqtT84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746881699; x=1747486499;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J41z2DxcXL5coq0co94ZJQZt1Z8vab9bT0bkIAzQeMQ=;
 b=gUMm+7PFmykRz/j6Z/yyMKjO/MQcW60QXlJlEOFy0rquEsP69EZKzTLHjwaQqaJl+g
 TzGd5VBWYTzdQUgUK3XQIj1gxEFHRcyD+ZaOdoiyA6pDRTx3z9SvtM3FVW+N3XeYMVxW
 9y4Rbd05cjr7sYBVpVtR6FKKCCDiXH/TE1VvN7RKMRRb0lrPY3e1jG0aJyoP8NGwST6F
 HfQo952x7KnFpmmuDcjHJjkg/nH1Wsv9C+o6e7vo6pLpc6ioC2yi6kXEQyJ9t0YERk4+
 2/LKGO6Pss/X+05zJ/srvRtMlgZe9mH13XtL7qxyguB60Z/eLpAAp0sYMXssuZho2wHU
 GOHA==
X-Gm-Message-State: AOJu0YwLXgA3kZF1cHFAKfn8s2C0Xb5Gj3KIB5KehVhQJh5sSa8OfZkv
 hDXL7BFflnlgpO3ebtqxu9X20TS8NQHY+LfqwUINcCjxr78NEl4BHp5kf0bSPnRXq01zkiq4paD
 piq4AZZY7mQ==
X-Gm-Gg: ASbGncvf+pbW/ZgAirgNj+Y+5EfZBMttxBq0y8/nnPB1MQ3oehcQFYusrN34smJYw8m
 2T8O3wqqhhgSBEojUm5Ls3ylO43oQ0nRuObyyGSBMT4w8lQEAAcrGoz9GUuu0kfLSceFxdL2ICB
 CjF2OYGYOXU9GoYfvn2e/bWo5xW3A2pM1Sob36mh75onlTgXoGKI1lorT47Odsyyx6AbvnLxvLg
 RQeCs1yn8nsgPDhE1TGZKS9CMaz0qOgex5YtO0ogtWhJ0y+G2jQHlRVCo1U3JiJrKjSDyMwuMnZ
 anmCPslUZEpmHJdgzygNx0SSlb1V7mHwBrxBzi3xhMWJ7zM=
X-Google-Smtp-Source: AGHT+IHg7F3VEXlvR7BQvtuzb117bSZt/04fXnjBE/Ap7Z0LVzu8DHhwj0RXCF+zIjY+kDFq3PRzsw==
X-Received: by 2002:a17:907:97c2:b0:ace:3f00:25f5 with SMTP id
 a640c23a62f3a-ad218e53598mr734715266b.2.1746881699399; 
 Sat, 10 May 2025 05:54:59 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2197463d7sm310356666b.120.2025.05.10.05.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 05:54:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2] efi_loader: Disable ANSI output for tests
Date: Sat, 10 May 2025 14:54:38 +0200
Message-ID: <20250510125457.1571220-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

We don't want ANSI escape-sequences written in tests since it is a pain
to check the output with ut_assert_nextline() et al.

Provide a way to tests to request that these characters not be sent.

Add a proper function comment while we are here, to encourage others.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Use the term 'ANSI escape-sequences'

 include/efi_loader.h         | 21 ++++++++++++++++++++-
 lib/efi_loader/efi_console.c | 26 +++++++++++++++++---------
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 25a809c3d53..48b63c22c4b 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -532,8 +532,27 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index);
 efi_status_t efi_bootmgr_run(void *fdt);
 /* search the boot option index in BootOrder */
 bool efi_search_bootorder(u16 *bootorder, efi_uintn_t num, u32 target, u32 *index);
-/* Set up console modes */
+
+/**
+ * efi_setup_console_size() - update the mode table.
+ *
+ * By default the only mode available is 80x25. If the console has at least 50
+ * lines, enable mode 80x50. If we can query the console size and it is neither
+ * 80x25 nor 80x50, set it as an additional mode.
+ */
 void efi_setup_console_size(void);
+
+/**
+ * efi_console_set_ansi() - Set whether ANSI escape-characters should be emitted
+ *
+ * These characters mess up tests which use ut_assert_nextline(). Call this
+ * function to tell efi_loader not to emit these characters when starting up the
+ * terminal
+ *
+ * @allow_ansi: Allow emitting ANSI escape-characters
+ */
+void efi_console_set_ansi(bool allow_ansi);
+
 /* Set up load options from environment variable */
 efi_status_t efi_env_set_load_options(efi_handle_t handle, const char *env_var,
 				      u16 **load_options);
diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index 9d9f786a6db..e310f2f53ae 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -30,6 +30,17 @@ struct cout_mode {
 
 __maybe_unused static struct efi_object uart_obj;
 
+/*
+ * suppress emission of ANSI escape-characters for use by unit tests. Leave it
+ * as 0 for the default behaviour
+ */
+static bool no_ansi;
+
+void efi_console_set_ansi(bool allow_ansi)
+{
+	no_ansi = !allow_ansi;
+}
+
 static struct cout_mode efi_cout_modes[] = {
 	/* EFI Mode 0 is 80x25 and always present */
 	{
@@ -348,13 +359,6 @@ static int __maybe_unused query_vidconsole(int *rows, int *cols)
 	return 0;
 }
 
-/**
- * efi_setup_console_size() - update the mode table.
- *
- * By default the only mode available is 80x25. If the console has at least 50
- * lines, enable mode 80x50. If we can query the console size and it is neither
- * 80x25 nor 80x50, set it as an additional mode.
- */
 void efi_setup_console_size(void)
 {
 	int rows = 25, cols = 80;
@@ -362,8 +366,12 @@ void efi_setup_console_size(void)
 
 	if (IS_ENABLED(CONFIG_VIDEO))
 		ret = query_vidconsole(&rows, &cols);
-	if (ret)
-		ret = query_console_serial(&rows, &cols);
+	if (ret) {
+		if (no_ansi)
+			ret = 0;
+		else
+			ret = query_console_serial(&rows, &cols);
+	}
 	if (ret)
 		return;
 
-- 
2.43.0

base-commit: c5a631df96de7421d10ee03dceed1b79db213026
branch: ansi2
