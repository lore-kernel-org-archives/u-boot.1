Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18201C4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A00B787CA8;
	Sat, 16 Dec 2023 04:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SRvLu13U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC95287C7F; Sat, 16 Dec 2023 04:15:26 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71F9C87C73
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-35f89f18daeso5488915ab.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696523; x=1703301323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UymhUFvX0HaV4G8xvxt7baK11QtFalBjjthbg0Ib0pc=;
 b=SRvLu13Uf6qohnVW9wPd6TmDJkhIlmRlNnmFX/Ijdac2jZ8sQ2yDqBcnj1mjg27zS1
 pJqsc0xFPrJnyPtjxeyufT81orONSYLQppb7mgb+wbJ3HVfaSxZAsqzUjNaMHdAj2Doa
 mm8x1qRniJyAC0uAoXz+xYK/jIeF624FL9I0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696523; x=1703301323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UymhUFvX0HaV4G8xvxt7baK11QtFalBjjthbg0Ib0pc=;
 b=hxVyzu+HFkH4j+kqRHcKy51ThiAEIG4m8+PUZquxmWqsdP07+TK/E6V4N0+T0a2asI
 zB54McQw9tvvFHbla0un4xqcU6x0Y5peXRFf8jUhyBDy2vcHCCafSDlsEmaJJHs15AGL
 WHf9y7+lt62RWKkl3JPX7gv6ty11mNIUITlWRNDmCPYOcSt1a+rP/b5mbEIs1G5yQBc9
 wZZOBfHoUSn7yEqZ41ISkWKoBuFsJ5NRwaHFCyA9bTr2styyW4HJ7h6q+T/ufpx729JP
 TJ6sm5dxe52rDF99tXiXn0A+JXWKbAq8QWdjgBD5BgJHolaCb+34A1WcYuNqvdPmszKA
 JHBQ==
X-Gm-Message-State: AOJu0Yy2YAaUlmnPxulp8N82mrstoaQ0rGgCe3iwyID2GXNTxMMhJF2J
 T5ubUTjrfCDX75Vi/7HU/LS5LMzJF6OasYj1Hl1iIg==
X-Google-Smtp-Source: AGHT+IGND4tw3TAq1aU6iiwSGHX37eYvksHlt3Ooaw2IyIyup1t5IUMTLdgqmUNC1djiDrrLwn7i4w==
X-Received: by 2002:a05:6e02:12c4:b0:35d:a911:4973 with SMTP id
 i4-20020a056e0212c400b0035da9114973mr16596193ilm.28.1702696522927; 
 Fri, 15 Dec 2023 19:15:22 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 17/22] bootm: Create a function to run through the bootm
 states
Date: Fri, 15 Dec 2023 20:14:21 -0700
Message-ID: <20231216031446.2222362-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231216031446.2222362-1-sjg@chromium.org>
References: <20231216031446.2222362-1-sjg@chromium.org>
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

In quite a few places, the bootm command is used to handle a boot. We
want these to be done without needing CONFIG_CMDLINE, so add a new
bootm_run() function to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Enable CONFIG_MEASURED_BOOT always and rely on CONFIG_MEASURED_BOOT

 boot/bootm.c    | 17 +++++++++++++++++
 cmd/bootm.c     | 14 +-------------
 include/bootm.h | 13 +++++++++++++
 3 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 66b7e350aa86..cce8485f2d47 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1123,6 +1123,23 @@ err:
 	return ret;
 }
 
+int bootm_run(struct bootm_info *bmi)
+{
+	int states;
+
+	bmi->cmd_name = "bootm";
+	states = BOOTM_STATE_START | BOOTM_STATE_FINDOS | BOOTM_STATE_PRE_LOAD |
+		BOOTM_STATE_FINDOTHER | BOOTM_STATE_LOADOS |
+		BOOTM_STATE_OS_PREP | BOOTM_STATE_OS_FAKE_GO |
+		BOOTM_STATE_OS_GO | BOOTM_STATE_MEASURE;
+	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
+		states |= BOOTM_STATE_RAMDISK;
+	if (IS_ENABLED(CONFIG_PPC) || IS_ENABLED(CONFIG_MIPS))
+		states |= BOOTM_STATE_OS_CMDLINE;
+
+	return bootm_run_states(bmi, states);
+}
+
 int bootm_boot_start(ulong addr, const char *cmdline)
 {
 	char addr_str[30];
diff --git a/cmd/bootm.c b/cmd/bootm.c
index 26d20b9118d2..9737a2d28c03 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -136,7 +136,6 @@ static int do_bootm_subcommand(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct bootm_info bmi;
-	int states;
 	int ret;
 
 	/* determine if we have a sub command */
@@ -157,17 +156,6 @@ int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			return do_bootm_subcommand(cmdtp, flag, argc, argv);
 	}
 
-	states = BOOTM_STATE_START | BOOTM_STATE_FINDOS | BOOTM_STATE_PRE_LOAD |
-		BOOTM_STATE_FINDOTHER | BOOTM_STATE_LOADOS |
-		BOOTM_STATE_OS_PREP | BOOTM_STATE_OS_FAKE_GO |
-		BOOTM_STATE_OS_GO;
-	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
-		states |= BOOTM_STATE_RAMDISK;
-	if (IS_ENABLED(CONFIG_MEASURED_BOOT))
-		states |= BOOTM_STATE_MEASURE;
-	if (IS_ENABLED(CONFIG_PPC) || IS_ENABLED(CONFIG_MIPS))
-		states |= BOOTM_STATE_OS_CMDLINE;
-
 	bootm_init(&bmi);
 	if (argc)
 		bmi.addr_img = argv[0];
@@ -180,7 +168,7 @@ int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	bmi.argc = argc;
 	bmi.argv = argv;
 
-	ret = bootm_run_states(&bmi, states);
+	ret = bootm_run(&bmi);
 
 	return ret ? CMD_RET_FAILURE : 0;
 }
diff --git a/include/bootm.h b/include/bootm.h
index 628d3d3e83ff..6e6b2ad8f7ef 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -150,6 +150,19 @@ int bootm_measure(struct bootm_headers *images);
  */
 int bootm_run_states(struct bootm_info *bmi, int states);
 
+/**
+ * bootm_run() - Run the entire bootm process
+ *
+ * This runs through the bootm process from start to finish, using the default
+ * set of states.
+ *
+ * This uses bootm_run_states().
+ *
+ * @bmi: bootm information
+ * Return: 0 if ok, something else on error
+ */
+int bootm_run(struct bootm_info *bmi);
+
 void arch_preboot_os(void);
 
 /*
-- 
2.43.0.472.g3155946c3a-goog

