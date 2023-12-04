Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A50AC07E97
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC1B2877B6;
	Mon,  4 Dec 2023 01:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KgVX63uB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 010858779D; Mon,  4 Dec 2023 01:27:31 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF7358763E
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7b389399dfdso247612139f.2
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649647; x=1702254447; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMGua4u6hRx+xIMVVX1CYKzGpKI724mm/yI7HWqIWy4=;
 b=KgVX63uB/nf7BFfwFxMp21j9TQVhMWiYYFLEZ3ljIZRBmM7RWBYXdCJYv2t/+zNOtf
 e+BmqJj18/3HaoV7Khd8Hgf6yox88ok8lCABO3w/FKn1ScCjW8AKT4IpNBAGP+mu0nNF
 xq7NK6v0JLGwhBZtA2xQ+zR54T6vQP0HJvkgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649647; x=1702254447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMGua4u6hRx+xIMVVX1CYKzGpKI724mm/yI7HWqIWy4=;
 b=tBI/SDrynct3tGaLJ3rPthi+srFzVUPVGhVpi3BX/n5zsxAJ49N2QbCl913lNzw0NN
 pId7iKQ0qgYtHgznQysQ5qKOFmIO+qhRlG1gCVlhBw0ZMzOmjde0RPRRW4h5oaS1R9sf
 GrfB9ChrwWiyY4kqtvcjiySuPtlWtuUlj4yK/HNJOqHPmbvEciyTzNgNGGMKlUZns+Ae
 PAtlw8p8Ts6788ZITCz2kbrmwbMSHxNVyhWqBmaJmkwlaNTVNAq3OliNJkCfvOgHapG1
 o1SVfLzhcXOydPtACGmnBzUnHL2wNIQKlhkOJn0tLQcBH7kS3tu6OXtwDkjYWK4sQJ+U
 idzw==
X-Gm-Message-State: AOJu0YwD7iS//oehaLwMjiroTepXm5lkDq3sbr/XdF/sgum+JZ6wjci2
 XwGeATt7Uet+74+9lYyxnb2jdizsZ5rtuEL45kySiQ==
X-Google-Smtp-Source: AGHT+IGJlmDbvBhtjp0n7/w4NtOul/uv0NL4Zo12U34Cd9XqFuCfQSEDDLe3XMTO455JkeyEz7nLzw==
X-Received: by 2002:a92:d0d2:0:b0:35d:59a2:2c2 with SMTP id
 y18-20020a92d0d2000000b0035d59a202c2mr4592120ila.98.1701649647450; 
 Sun, 03 Dec 2023 16:27:27 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 06/18] bootm: Drop arguments from boot_selected_os()
Date: Sun,  3 Dec 2023 17:26:22 -0700
Message-ID: <20231204002642.895926-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002642.895926-1-sjg@chromium.org>
References: <20231204002642.895926-1-sjg@chromium.org>
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

The argc and argv parameters are not used now, so drop them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c    | 6 ++----
 boot/bootm_os.c | 4 ++--
 include/bootm.h | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index c343f313e80a..d2448f6306dc 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1117,8 +1117,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (!ret && (states & BOOTM_STATE_OS_FAKE_GO)) {
 		char *cmd_list = env_get("fakegocmd");
 
-		ret = boot_selected_os(argc, argv, BOOTM_STATE_OS_FAKE_GO,
-				images, boot_fn);
+		ret = boot_selected_os(BOOTM_STATE_OS_FAKE_GO, images, boot_fn);
 		if (!ret && cmd_list)
 			ret = run_command_list(cmd_list, -1, flag);
 	}
@@ -1132,8 +1131,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* Now run the OS! We hope this doesn't return */
 	if (!ret && (states & BOOTM_STATE_OS_GO))
-		ret = boot_selected_os(argc, argv, BOOTM_STATE_OS_GO,
-				images, boot_fn);
+		ret = boot_selected_os(BOOTM_STATE_OS_GO, images, boot_fn);
 
 	/* Deal with any fallout */
 err:
diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index df1aab4b3e4d..22ff62e5fb65 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -527,8 +527,8 @@ __weak void board_preboot_os(void)
 	/* please define board specific board_preboot_os() */
 }
 
-int boot_selected_os(int argc, char *const argv[], int state,
-		     struct bootm_headers *images, boot_os_fn *boot_fn)
+int boot_selected_os(int state, struct bootm_headers *images,
+		     boot_os_fn *boot_fn)
 {
 	arch_preboot_os();
 	board_preboot_os();
diff --git a/include/bootm.h b/include/bootm.h
index 0e4662485006..b8d74d03a8c4 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -42,8 +42,8 @@ boot_os_fn *bootm_os_get_boot_func(int os);
 int bootm_host_load_images(const void *fit, int cfg_noffset);
 #endif
 
-int boot_selected_os(int argc, char *const argv[], int state,
-		     struct bootm_headers *images, boot_os_fn *boot_fn);
+int boot_selected_os(int argc, struct bootm_headers *images,
+		     boot_os_fn *boot_fn);
 
 ulong bootm_disable_interrupts(void);
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

