Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D13C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 310A78295C;
	Sat, 10 May 2025 13:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nlIQ/3iZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DD8582977; Sat, 10 May 2025 13:36:34 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F013B82952
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ad1b94382b8so406844466b.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876990; x=1747481790; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUsokmnpgtnrR7Vzl7VHS+BU2WsM9NaBvqMUGcNyX+M=;
 b=nlIQ/3iZGRthV9fXsAx6eIRAzBUxgd4jZbdL7MhMdN1/CY7bJSQklRW1ju4mJ0GjVs
 EPkBv72tCWPnFHrlC1nUp+tNBErUOqns9w3FVYbiUk7HZfj7bfhNl1MW6PDGxb8NRSCr
 1xcBs0ZO6po5tKetjewP9hng+HKppvClyc46I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876990; x=1747481790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZUsokmnpgtnrR7Vzl7VHS+BU2WsM9NaBvqMUGcNyX+M=;
 b=esJMdSWiBh/LIRW38/6RWPLKCqbQYQ6e/tipVBDvTx2swZIaLdbBAcUU28QBIxH+ix
 cMI/3/BTioqsIL3KVx3sW+5fON80zCMI0WHWUsbHOLGNiwknFQXuJDG4iU+kAGbHYJZo
 LdbQLgzY+nSFaDJYkghxed9xvk48m/n+VQkmlxn9zHZhzQH+0CRxrLvzPHNH4h6WRrtE
 5ol8zTw4ZNiVMiI2A12zBOHHFQH+W2O7FEyVCKPyiqZy0X3D3U8u2HZjCbuGQ1NHPuNU
 ATa0uuiFqkjlsMLSZXHH4JQv6uaGTiMBWcs3Dh4sGUaIkEP6PrM399dG6efcrj7wM0nr
 fBcw==
X-Gm-Message-State: AOJu0YyN9TMk81PqHh02w8le+d6fBIwph2U3fUF3QzlEwxbwX5Fs4a6Z
 7ktS+Azl2uU7WfWOs3hwBt7POjo1rS3sxT+K24UFIpE2x+OnFlwGis811J6KF72GYmgElWAW5wg
 7IH7LBz8USg==
X-Gm-Gg: ASbGncvn7L3Sr3KWyl3ql1eecu0KeOEyfDhkM4zcUkp6XalNgwgmAOxe7eavOOJM5/A
 LRF3/QZG22kwm8cTkJDlGIveBXFgZoYtSocXjh1HBvWvw+6OD2vPxE2xwKFphel1/xBlRIgnJaY
 qfwbyaNMcZ9FUYtAwgf9gqjFWmQtTyi//d8R1rGbABAPaozjjQ0YwhVCVWuCX8RCfmzEypc2NIy
 M1XYYqFbNU6TtjNH4NeODaqz86w1uj8/LFilEnLY0t/nse1IGa/Dv+vJQRbscHSUBsC8ODx5OwK
 dVswtbd0WAPkgbqwTZyOGIm0lNPeBes+EpxxDrdu4/WtYDQ=
X-Google-Smtp-Source: AGHT+IHOrqvoV1EBKgXtbqTdTVUZyhaEZVudsj8jtuiaKYga3UIgNhoOtsFXz/eOryI2wqPukZ6BYw==
X-Received: by 2002:a17:907:d16:b0:ad2:3616:8c37 with SMTP id
 a640c23a62f3a-ad236169015mr249013666b.30.1746876990410; 
 Sat, 10 May 2025 04:36:30 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2197bd2a8sm303350266b.145.2025.05.10.04.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:36:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH] efi_loader: Disable ANSI output for tests
Date: Sat, 10 May 2025 13:36:24 +0200
Message-ID: <20250510113627.1476467-1-sjg@chromium.org>
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

We don't want ANSI characters written in tests since it is a pain to
check the output with ut_assert_nextline() et al.

Provide a way to tests to request that ANSI characters not be sent.

Add a proper function comment while we are here, to encourage others.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/efi_loader.h         | 21 ++++++++++++++++++++-
 lib/efi_loader/efi_console.c | 26 +++++++++++++++++---------
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 25a809c3d53..b699479f346 100644
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
+ * efi_console_set_ansi() - Set whether ANSI characters should be emitted
+ *
+ * These characters mess up tests which use ut_assert_nextline(). Call this
+ * function to tell efi_loader not to emit these characters when starting up the
+ * terminal
+ *
+ * @allow_ansi: Allow emitting ANSI characters
+ */
+void efi_console_set_ansi(bool allow_ansi);
+
 /* Set up load options from environment variable */
 efi_status_t efi_env_set_load_options(efi_handle_t handle, const char *env_var,
 				      u16 **load_options);
diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index 9d9f786a6db..28687d678c3 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -30,6 +30,17 @@ struct cout_mode {
 
 __maybe_unused static struct efi_object uart_obj;
 
+/*
+ * suppress emission of ANSI codes for use by unit tests. Leave it as 0 for the
+ * default behaviour
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
branch: ansi
