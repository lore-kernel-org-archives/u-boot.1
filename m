Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EA0E784A8
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF8EB8744C;
	Mon,  2 Oct 2023 03:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="em9FT1RD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B2F87236; Mon,  2 Oct 2023 03:18:04 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F17B87242
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-351574aca7bso27037625ab.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209376; x=1696814176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ef+FG1laRf6GpXs0zPc0HbqvD3FXNBHO3i/3EhSvTp8=;
 b=em9FT1RDRo2V2ijZdaQbrSKMiqdAXVQmlzIx0qqwIS566rn2dhD3buy+63IwjnADq5
 tCVlpfi3Uips1Tq65w2m5qEOSzO3CdhUUxfbFt1E7DeKfj56krFgKyb7kY/POLInYj+s
 duEGzCPoQUrXdZPVTrJTtKJL1F/YyUIJH+1fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209376; x=1696814176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ef+FG1laRf6GpXs0zPc0HbqvD3FXNBHO3i/3EhSvTp8=;
 b=U55mI53i9qwzXEGg6ahNiIvg5f/4qTW5gtrnKn9iPu4VE4flyPYrOaxwJZwFIt9074
 zi+9lkfbc+D/ZkTzCCRDjKFwFsesG4OAsaex6Pf7nQ16iOB1BSFRSJHmVSGVzN6qLres
 cy2p+UME5AHXn+HVt+I/acitJKcLhTLuFjYML8FRWVoVGOWZ9RcUZwFNHBKfAJQm6R0k
 d+Eadk7oAdGerPYsAutMvSQwvUuIpdkO2VlWid912b/XnRGNzPlBqj0Ka110oe09y/n0
 hll1VNze8JefTPOuKA2r/+SdaT8j463JEjQ5NlKurUq0u3F8ih4azipzEDSyVXXquVTr
 bjrQ==
X-Gm-Message-State: AOJu0YyEJD+KFVLxgWDtfGWqnXLVdcyMkw3eDVPH2cMh+kom0SaIaQmx
 3lOO892JdYiulHj1oF7RzIV0IeaDpVsJBFhRmGU=
X-Google-Smtp-Source: AGHT+IF8WR7+6uE6LkO3YTEPhw8mHxCHgA33zVEw59vuChLhXlXhUwyJvbK51RsqjW3RZWtw44qj8g==
X-Received: by 2002:a05:6e02:1bc9:b0:34b:aa34:a5c4 with SMTP id
 x9-20020a056e021bc900b0034baa34a5c4mr11963622ilv.30.1696209376554; 
 Sun, 01 Oct 2023 18:16:16 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng@tinylab.org>, Harald Seiler <hws@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 13/34] video: Add a function to clear the display
Date: Sun,  1 Oct 2023 19:15:23 -0600
Message-ID: <20231002011553.463514-14-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

Move the code from the 'cls' command into the console file, so it can
be called from elsewhere.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/cls.c         | 25 +++----------------------
 common/console.c  | 31 +++++++++++++++++++++++++++++++
 include/console.h | 10 ++++++++++
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/cmd/cls.c b/cmd/cls.c
index 1125a3f81bbb..80d0558d4679 100644
--- a/cmd/cls.c
+++ b/cmd/cls.c
@@ -7,33 +7,14 @@
  */
 #include <common.h>
 #include <command.h>
+#include <console.h>
 #include <dm.h>
-#include <video_console.h>
-
-#define CSI "\x1b["
 
 static int do_video_clear(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[])
 {
-	__maybe_unused struct udevice *dev;
-
-	/*
-	 * Send clear screen and home
-	 *
-	 * FIXME(Heinrich Schuchardt <xypron.glpk@gmx.de>): This should go
-	 * through an API and only be written to serial terminals, not video
-	 * displays
-	 */
-	printf(CSI "2J" CSI "1;1H");
-	if (IS_ENABLED(CONFIG_VIDEO_ANSI))
-		return 0;
-
-	if (IS_ENABLED(CONFIG_VIDEO)) {
-		if (uclass_first_device_err(UCLASS_VIDEO_CONSOLE, &dev))
-			return CMD_RET_FAILURE;
-		if (vidconsole_clear_and_reset(dev))
-			return CMD_RET_FAILURE;
-	}
+	if (console_clear())
+		return CMD_RET_FAILURE;
 
 	return CMD_RET_SUCCESS;
 }
diff --git a/common/console.c b/common/console.c
index 98c3ee6ca6b8..1ffda49c87e0 100644
--- a/common/console.c
+++ b/common/console.c
@@ -19,12 +19,15 @@
 #include <stdio_dev.h>
 #include <exports.h>
 #include <env_internal.h>
+#include <video_console.h>
 #include <watchdog.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define CSI "\x1b["
+
 static int on_console(const char *name, const char *value, enum env_op op,
 	int flags)
 {
@@ -1010,6 +1013,34 @@ int console_init_f(void)
 	return 0;
 }
 
+int console_clear(void)
+{
+	/*
+	 * Send clear screen and home
+	 *
+	 * FIXME(Heinrich Schuchardt <xypron.glpk@gmx.de>): This should go
+	 * through an API and only be written to serial terminals, not video
+	 * displays
+	 */
+	printf(CSI "2J" CSI "1;1H");
+	if (IS_ENABLED(CONFIG_VIDEO_ANSI))
+		return 0;
+
+	if (IS_ENABLED(CONFIG_VIDEO)) {
+		struct udevice *dev;
+		int ret;
+
+		ret = uclass_first_device_err(UCLASS_VIDEO_CONSOLE, &dev);
+		if (ret)
+			return ret;
+		ret = vidconsole_clear_and_reset(dev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static void stdio_print_current_devices(void)
 {
 	char *stdinname, *stdoutname, *stderrname;
diff --git a/include/console.h b/include/console.h
index ceb733b5cb69..e29817e57b00 100644
--- a/include/console.h
+++ b/include/console.h
@@ -156,6 +156,16 @@ int console_announce_r(void);
  */
 void console_puts_select_stderr(bool serial_only, const char *s);
 
+/**
+ * console_clear() - Clear the console
+ *
+ * Uses an ANSI sequence to clear the display, failing back to clearing the
+ * video display directly if !CONFIG_VIDEO_ANSI
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int console_clear(void);
+
 /*
  * CONSOLE multiplexing.
  */
-- 
2.42.0.582.g8ccd20d70d-goog

