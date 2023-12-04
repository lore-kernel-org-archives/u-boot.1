Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698E1C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4893D877FF;
	Mon,  4 Dec 2023 01:28:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BxnwrLbd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12605877E5; Mon,  4 Dec 2023 01:28:02 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D09E8877FF
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5c673b01eeeso144447a12.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649678; x=1702254478; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eosPEb5Kd7huyXDizyg3yD6OEHcW0CeC/21cQiDivhY=;
 b=BxnwrLbd9db0OWN3mXnE5nKUNcQTTbZVUllgiJ1ZUhseVen9bWq15XpzkeCJIzgYo9
 b0x2JNSFGWznB8Y4VbgQbN/YUwfBIlpDNir2couk8TeH0zsHLBP8izA5h297UqMcyiIw
 VilLVyHZ8G7HYCNSlQMZDpuMMLEHwGE+nXseY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649678; x=1702254478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eosPEb5Kd7huyXDizyg3yD6OEHcW0CeC/21cQiDivhY=;
 b=ogcM1eRzxSlM7G/Y1bKeGpECkTC3Si50LALvZJdLO5NUNl4r5QEQGsUmXklH67ouoA
 cLmmpQscgGvXesjr0R9qdYqrvt4vnBU8euOuXe+QmtIZT1KDCI2sgnRNLElxCee6637F
 Qt/UnphQdmxAsg94UEf5QXwPtfc4VzaEmTnjeI6VaWMbkUHiIkv65mdfcodKt++dRCL9
 WyOKRq0do7V3gylUB5XHGt8tXN5OoO2f5N3e9TvXov/9TgCJ+oqaCikBbAWTDbOlF649
 cMmEIwR4z2jaMXjqBuDJJi/aL+JJS+q+u+O0TlUChNems+/8GK2LFcYDcsiwFmlJsvp+
 arVw==
X-Gm-Message-State: AOJu0Yz75pWE7t2MrGVrLwSzLnzvxEBls6HRmQW7wSkf+Tlzmzd4s60I
 9IxRg5DDV/4NskHYJpc2ncAIe2a85FOAXDeDviYx3g==
X-Google-Smtp-Source: AGHT+IGE8cAAFVJxoKJWsSdywpw9AsUCHzdB4OwzGoCYRI/PCuDKBSAHS1osHqAYqvuw13qb4c0STw==
X-Received: by 2002:a05:6a21:3989:b0:186:ae16:103 with SMTP id
 ad9-20020a056a21398900b00186ae160103mr27812912pzc.30.1701649678073; 
 Sun, 03 Dec 2023 16:27:58 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 14/18] bootm: Create a function to run through the bootm states
Date: Sun,  3 Dec 2023 17:26:30 -0700
Message-ID: <20231204002642.895926-8-sjg@chromium.org>
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

In quite a few places, the bootm command is used to handle a boot. We
want these to be done without needing CONFIG_CMDLINE, so add a new
bootm_run() function to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c    | 19 +++++++++++++++++++
 cmd/bootm.c     | 14 +-------------
 include/bootm.h | 13 +++++++++++++
 3 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 1f46bb88b38e..301ba480677d 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1123,6 +1123,25 @@ err:
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
+		BOOTM_STATE_OS_GO;
+	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
+		states |= BOOTM_STATE_RAMDISK;
+	if (IS_ENABLED(CONFIG_MEASURED_BOOT))
+		states |= BOOTM_STATE_MEASURE;
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
index 68fb48f77a90..744a84d6c394 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -132,7 +132,6 @@ static int do_bootm_subcommand(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct bootm_info bmi;
-	int states;
 	int ret;
 
 	/* determine if we have a sub command */
@@ -153,17 +152,6 @@ int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
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
 	memset(&bmi, '\0', sizeof(struct bootm_info));
 	if (argc)
 		bmi.addr_fit = argv[0];
@@ -173,7 +161,7 @@ int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		bmi.conf_fdt = argv[2];
 	bmi.boot_progress = true;
 	bmi.images = &images;
-	ret = bootm_run_states(&bmi, states);
+	ret = bootm_run(&bmi);
 
 	return ret ? CMD_RET_FAILURE : 0;
 }
diff --git a/include/bootm.h b/include/bootm.h
index a3bef1ab88f2..ef46c085b594 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -137,6 +137,19 @@ int bootm_measure(struct bootm_headers *images);
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
2.43.0.rc2.451.g8631bc7472-goog

