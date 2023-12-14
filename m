Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BA9C4167B
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB4BD87B0B;
	Thu, 14 Dec 2023 17:52:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zm3JWpB+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED60987B06; Thu, 14 Dec 2023 17:52:00 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F04BB87B07
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7b435966249so361609939f.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572716; x=1703177516; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Y390aiLshbhilk20KQ52m+paVmnLWT0e5b/ztwLZMw=;
 b=Zm3JWpB+0NQaqdkfI1Ue0bXzii+sLma8Mx4WoexN2qpTCeMQNjA3ZJb9p7txtkNuCK
 QytQSxIPTOB8ne5ALQUy9Q1lwBg7c6G4WX5bWt96Rsj+2+GUXuS5l3SejFfVTYgDVj9+
 fnF/KgvVEmQ0BCsGWebmPKB8X6LG2QsWbI0uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572716; x=1703177516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Y390aiLshbhilk20KQ52m+paVmnLWT0e5b/ztwLZMw=;
 b=g26Eb0ORzE1i4PtaID+PRJ8ACQ/3NqR1SYhSjo0mj0cFrlzShd8R/5HZN3LTzdQrd8
 SPzLVsIPbfjugZu3NIMfI4+VjXLTZCrk35kn6Odtu0UPxyN0WTXNXcMCZcGMQ7cxSjon
 3ykCtfRaR30ZVZKmiGSdssSi0XUWPUbYT7kXE7fd5PfIuDYoUn77VOtnYT+BwSj0qeZ+
 8AjRbqEudeGGV2YzUwvgh1LWttEy2JrBj+NPZuEbA1JtRkG2sXq+ZFeKQGFIIiPb2r9J
 TC8ZNHKa5ZLrOdm/FaBdiuXASfU2lCYRyhd+0qDm9lIns4L/oqcDEok66NKb1Y1q8Eg3
 XlHA==
X-Gm-Message-State: AOJu0YxTDX1KgJZDLQe0kG8YZ60WBniwUdUdwALl6+F6QDHmD90wI8ZG
 GYahe3wtkXUQtvIHuLCqA71uGlM/cOD9TgMNHdlmVg==
X-Google-Smtp-Source: AGHT+IGEjER0/Z9oRw1trmhfpYZcw4TXNOz4+ADpncqh2HtpLaTT6PegoslUNlhmeStC+4cQM1dybA==
X-Received: by 2002:a05:6e02:1a61:b0:35f:7316:7c95 with SMTP id
 w1-20020a056e021a6100b0035f73167c95mr4543654ilv.50.1702572716355; 
 Thu, 14 Dec 2023 08:51:56 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 15/21] bootm: Rename do_bootm_states() to bootm_run_states()
Date: Thu, 14 Dec 2023 09:50:24 -0700
Message-ID: <20231214165112.2182274-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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

Rename the function to bootm_run_states() to better indicate ts
purpose. The 'do_' prefix is used to indicate a command processor,
which this is now not.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Split do_bootm_states() rename to a separate patch

 arch/mips/lib/bootm.c | 2 +-
 boot/bootm.c          | 4 ++--
 cmd/booti.c           | 4 ++--
 cmd/bootm.c           | 4 ++--
 cmd/bootz.c           | 4 ++--
 include/bootm.h       | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index 286dbd5c4581..adb6b6cc229e 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -217,7 +217,7 @@ static int boot_reloc_fdt(struct bootm_headers *images)
 {
 	/*
 	 * In case of legacy uImage's, relocation of FDT is already done
-	 * by do_bootm_states() and should not repeated in 'bootm prep'.
+	 * by bootm_run_states() and should not repeated in 'bootm prep'.
 	 */
 	if (images->state & BOOTM_STATE_FDT) {
 		debug("## FDT already relocated\n");
diff --git a/boot/bootm.c b/boot/bootm.c
index 7156149dfae9..bd208c0493ca 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -990,7 +990,7 @@ unmap_image:
 	return ret;
 }
 
-int do_bootm_states(struct bootm_info *bmi, int states)
+int bootm_run_states(struct bootm_info *bmi, int states)
 {
 	struct bootm_headers *images = bmi->images;
 	boot_os_fn *boot_fn;
@@ -1152,7 +1152,7 @@ int bootm_boot_start(ulong addr, const char *cmdline)
 	bootm_init(&bmi);
 	bmi.addr_fit = addr_str;
 	bmi.cmd_name = "bootm";
-	ret = do_bootm_states(&bmi, states);
+	ret = bootm_run_states(&bmi, states);
 
 	return ret;
 }
diff --git a/cmd/booti.c b/cmd/booti.c
index 3fa153eb5e54..55f7ba67611f 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -34,7 +34,7 @@ static int booti_start(struct bootm_info *bmi)
 	unsigned long decomp_len;
 	int ctype;
 
-	ret = do_bootm_states(bmi, BOOTM_STATE_START);
+	ret = bootm_run_states(bmi, BOOTM_STATE_START);
 
 	/* Setup Linux kernel Image entry point */
 	if (!bmi->addr_fit) {
@@ -141,7 +141,7 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
 		states |= BOOTM_STATE_RAMDISK;
 
-	ret = do_bootm_states(&bmi, states);
+	ret = bootm_run_states(&bmi, states);
 
 	return ret;
 }
diff --git a/cmd/bootm.c b/cmd/bootm.c
index 42a5cf2fa987..4060800cb3b3 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -118,7 +118,7 @@ static int do_bootm_subcommand(struct cmd_tbl *cmdtp, int flag, int argc,
 	bmi.argc = argc;
 	bmi.argv = argv;
 
-	ret = do_bootm_states(&bmi, state);
+	ret = bootm_run_states(&bmi, state);
 
 #if defined(CONFIG_CMD_BOOTM_PRE_LOAD)
 	if (!ret && (state & BOOTM_STATE_PRE_LOAD))
@@ -180,7 +180,7 @@ int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	bmi.argc = argc;
 	bmi.argv = argv;
 
-	ret = do_bootm_states(&bmi, states);
+	ret = bootm_run_states(&bmi, states);
 
 	return ret ? CMD_RET_FAILURE : 0;
 }
diff --git a/cmd/bootz.c b/cmd/bootz.c
index 9aa07b682d1c..aa8339318413 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -40,7 +40,7 @@ static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
 		bmi.conf_fdt = argv[2];
 	/* do not set up argc and argv[] since nothing uses them */
 
-	ret = do_bootm_states(&bmi, BOOTM_STATE_START);
+	ret = bootm_run_states(&bmi, BOOTM_STATE_START);
 
 	/* Setup Linux kernel zImage entry point */
 	if (!argc) {
@@ -104,7 +104,7 @@ int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
 		states |= BOOTM_STATE_RAMDISK;
 
-	ret = do_bootm_states(&bmi, states);
+	ret = bootm_run_states(&bmi, states);
 
 	return ret;
 }
diff --git a/include/bootm.h b/include/bootm.h
index 1f83c160767f..45109f96695d 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -132,7 +132,7 @@ int bootm_find_images(ulong img_addr, const char *conf_ramdisk,
 int bootm_measure(struct bootm_headers *images);
 
 /**
- * do_bootm_states() - Execute selected states of the bootm command.
+ * bootm_run_states() - Execute selected states of the bootm command.
  *
  * Note that if states contains more than one flag it MUST contain
  * BOOTM_STATE_START, since this handles the addr_fit, conf_ramdisk and conf_fit
@@ -149,7 +149,7 @@ int bootm_measure(struct bootm_headers *images);
  *	then the intent is to boot an OS, so this function will not return
  *	unless the image type is standalone.
  */
-int do_bootm_states(struct bootm_info *bmi, int states);
+int bootm_run_states(struct bootm_info *bmi, int states);
 
 void arch_preboot_os(void);
 
-- 
2.43.0.472.g3155946c3a-goog

