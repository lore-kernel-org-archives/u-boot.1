Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46897CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B3EA86F79;
	Tue, 17 Oct 2023 00:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R7LoLCbU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C4F4803AE; Tue, 17 Oct 2023 00:33:02 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0764D86DE6
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7740aa4b545so343610685a.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495549; x=1698100349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+/GPz9OHpCzTtjXcfC3UFckfJh1DsJSGo9tpNks8mnU=;
 b=R7LoLCbUxGN7rRuosMqCoogZ+UvhBue0fw0GCSDcn+jg4Ib4XSNojqpV3aHl2V9aQ9
 iLL/4PV5xPEGosfY0kmBl+9rEZcL9qcfS9HoRT6sMjFYg0d5GF5f61mwDpFOolaESlFE
 Hh7XOrmfvhVKawHYFJ0ShiPofaQOiwL+cniVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495549; x=1698100349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+/GPz9OHpCzTtjXcfC3UFckfJh1DsJSGo9tpNks8mnU=;
 b=L3aQOmGGhLHCsNxVB81QxfVWWgMJqFsdevxNtGNijR+k4vTiL4MQc13ZnYGZWFM9Nk
 Kd2//mXJYDxs3+IodTL+IFk4+ZOA+m9ptMO2MTQJB37QFot82ZyQSp0EcXsDeWWCfWPe
 XCP3X1rcF/7NbAmpoIdMYJOcpG0qiBwXMLcraLNypeQSg5dpu6QoRHagP33xeCyD4Jn+
 Kf67wqrzHDJX1z2yDJg1MplgqbENBBEcRfFI3jG1ySDTV6tfhy78DShaGfL3hE5JYb0i
 iwMFn09KIAYSiZGB1E/iYqDVpbd8gdGi4J8CdIzjiUyaAD4/FEkP0H8CVnm6YXBqgukl
 Hg4w==
X-Gm-Message-State: AOJu0YyrXGujZwjBHi0n6UIMZp/T89uSl3QdSz3FnZyltN0tk2F7JEGU
 neTHxxLiFbXgQ8MjUh0tcVQI6rLrTjHccprWSHoJhQ==
X-Google-Smtp-Source: AGHT+IEc6oBlBkj9qBqx4fY+C5WCo5+12ln11j3eazefk9aCEY+3S+revvkX3DVaghMDPUoniITu0Q==
X-Received: by 2002:a05:620a:29d4:b0:76d:984c:9d01 with SMTP id
 s20-20020a05620a29d400b0076d984c9d01mr583419qkp.33.1697495549355; 
 Mon, 16 Oct 2023 15:32:29 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:32:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 25/32] Add a new Kconfig for command-line history
Date: Mon, 16 Oct 2023 16:28:16 -0600
Message-ID: <20231016222835.596572-26-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

At present EXPO requires CMDLINE since it uses cli_readline, which
needs history enabled. It should be possible to enter lines of text
into an expo without having history available.

Fix this dependency by creating a new Kconfig for cmdline history.
Adjust the code to use the correct condiition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch with a Kconfig for command-line entry

 cmd/Kconfig        | 15 +++++++++++++--
 common/cli_cread.c | 24 ++++++++++++++----------
 include/cli.h      |  3 ++-
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5cb45f9c025e..491737ca8ba7 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -29,8 +29,19 @@ config CMDLINE_EDITING
 	depends on CMDLINE
 	default y
 	help
-	  Enable editing and History functions for interactive command line
-	  input operations
+	  Enable an editing function for interactive, command-line-input
+	  operations. This allows moving the cursor back and forth within
+	  the line, inserting and deleting characters, etc.
+
+config CMDLINE_HISTORY
+	bool "Enable command-line history"
+	depends on CMDLINE_EDITING
+	default y
+	help
+	  Enable a history function for interactive, command-line-input
+	  operations. This maintains a small buffer of previously entered
+	  commands, allowing the user to enter or edit old commands without
+	  having to retype them.
 
 config CMDLINE_PS_SUPPORT
 	bool "Enable support for changing the command prompt string at run-time"
diff --git a/common/cli_cread.c b/common/cli_cread.c
index 19af27303cfc..33c678e89f3d 100644
--- a/common/cli_cread.c
+++ b/common/cli_cread.c
@@ -28,11 +28,12 @@ DECLARE_GLOBAL_DATA_PTR;
 #define CTL_BACKSPACE		('\b')
 #define DEL			((char)255)
 #define DEL7			((char)127)
-#define CREAD_HIST_CHAR		('!')
 
 #define getcmd_putch(ch)	putc(ch)
 #define getcmd_cbeep()		getcmd_putch('\a')
 
+#define CREAD_HIST_CHAR		('!')
+
 #ifdef CONFIG_SPL_BUILD
 #define HIST_MAX		3
 #define HIST_SIZE		32
@@ -41,14 +42,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define HIST_SIZE		CONFIG_SYS_CBSIZE
 #endif
 
-static int hist_max;
-static int hist_add_idx;
-static int hist_cur = -1;
-static uint hist_num;
-
-static char *hist_list[HIST_MAX];
-static char hist_lines[HIST_MAX][HIST_SIZE + 1];	/* Save room for NULL */
-
 static void getcmd_putchars(int count, int ch)
 {
 	int i;
@@ -57,6 +50,16 @@ static void getcmd_putchars(int count, int ch)
 		getcmd_putch(ch);
 }
 
+#ifdef CONFIG_CMDLINE_HISTORY
+
+static int hist_max;
+static int hist_add_idx;
+static int hist_cur = -1;
+static uint hist_num;
+
+static char *hist_list[HIST_MAX];
+static char hist_lines[HIST_MAX][HIST_SIZE + 1];	/* Save room for NULL */
+
 void hist_init(void)
 {
 	int i;
@@ -150,6 +153,7 @@ void cread_print_hist_list(void)
 		i++;
 	}
 }
+#endif /* CMDLINE_HISTORY */
 
 #define BEGINNING_OF_LINE() {			\
 	while (cls->num) {			\
@@ -325,7 +329,7 @@ int cread_line_process_ch(struct cli_line_state *cls, char ichar)
 		break;
 	case CTL_CH('p'):
 	case CTL_CH('n'):
-		if (cls->history) {
+		if (IS_ENABLED(CONFIG_CMDLINE_HISTORY) && cls->history) {
 			char *hline;
 
 			if (ichar == CTL_CH('p'))
diff --git a/include/cli.h b/include/cli.h
index bca24c8c565f..45a338f709f7 100644
--- a/include/cli.h
+++ b/include/cli.h
@@ -294,6 +294,7 @@ char *hist_prev(void);
  */
 char *hist_next(void);
 
+#ifdef CONFIG_CMDLINE_HISTORY
 /**
  * cread_add_to_hist() - Add a line to the history buffer
  *
@@ -304,10 +305,10 @@ char *hist_next(void);
  */
 void cread_add_to_hist(char *line);
 
-#ifdef CONFIG_CMDLINE_EDITING
 void hist_init(void);
 #else
 static inline void hist_init(void) {}
+static inline void cread_add_to_hist(char *line) {}
 #endif
 
 #endif
-- 
2.42.0.655.g421f12c284-goog

