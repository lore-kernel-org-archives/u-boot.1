Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7EFC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE99B87B32;
	Thu, 14 Dec 2023 17:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l9K89wNd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F282187AF9; Thu, 14 Dec 2023 17:52:01 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7794587822
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-35f72db10f7so8484135ab.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572718; x=1703177518; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3CgKbv8WBntCcpAB+4Qo64AMPfzAAwQ5V73SFWjfA8=;
 b=l9K89wNdChMj0YB7gLnF8EENQaSldeYmTwE0g60y3XFGHGutdCRRAjbGjEwlK3OnUU
 GP5RF3WEbEHqttahgD7/PBGl9xr9sJVAO5FoD3OhQynTx3Tgc4K3s62JTuQ14ey6/Ikl
 VAwgIU0evj16X2yZkwcFq6401gN97XqiaiXWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572718; x=1703177518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3CgKbv8WBntCcpAB+4Qo64AMPfzAAwQ5V73SFWjfA8=;
 b=vFujivcFqH3fHiUcO4ZfU4q1Fga4Ysuk/5QF2cLJkO0uM6IRJ7S2mcWr7lLgNLgYT1
 TNgyGdCvfkSfi1dk0LWF+puTk+l+8i0GVgUenZVcbtpmdJK7rt5faX5N9Pl0WhXKL+KK
 JJCig5N1Pg698iXt073gDxAzW2HeSovX/x7ZuxZRUKgK/FW+fSfOgU6izK7xXd9YUWuD
 9J9tBOmt97e+Rbykv+q3MIAk5C47Gp4DiBIabT4z0KLoPBC65Mgri931b7d/D5Z/ezjg
 h3BES8MOAibJ7ULBUIi8c7vgMNJgnd7I1RRmPqYCIO1DJc3KEfI8VMqSmA1WEoCgaiDy
 8q2Q==
X-Gm-Message-State: AOJu0YysuLzIpPs7+uZxvEPO5Hu+wpQwfX9ovzH5IPSDI84JG69K5Fjh
 jC+iKRmBONw0gVRBhtmggblQH17wlousGzpgw5kufQ==
X-Google-Smtp-Source: AGHT+IF3Ia+6Iz+KZSvCnzQeKKDGyZHY8vTGSgrqqv1AKYhFg5oFc4Y8r57sqDG5gDkzsB4WC7brjA==
X-Received: by 2002:a05:6e02:1888:b0:35f:7ca7:c7b9 with SMTP id
 o8-20020a056e02188800b0035f7ca7c7b9mr3210976ilu.62.1702572718098; 
 Thu, 14 Dec 2023 08:51:58 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 17/21] bootm: Create a function to run through the bootm
 states
Date: Thu, 14 Dec 2023 09:50:26 -0700
Message-ID: <20231214165112.2182274-13-sjg@chromium.org>
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

In quite a few places, the bootm command is used to handle a boot. We
want these to be done without needing CONFIG_CMDLINE, so add a new
bootm_run() function to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootm.c    | 19 +++++++++++++++++++
 cmd/bootm.c     | 14 +-------------
 include/bootm.h | 13 +++++++++++++
 3 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index f9f0c9782e42..bd1022ada590 100644
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
index 4060800cb3b3..a193eb8913e7 100644
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
 		bmi.addr_fit = argv[0];
@@ -180,7 +168,7 @@ int do_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	bmi.argc = argc;
 	bmi.argv = argv;
 
-	ret = bootm_run_states(&bmi, states);
+	ret = bootm_run(&bmi);
 
 	return ret ? CMD_RET_FAILURE : 0;
 }
diff --git a/include/bootm.h b/include/bootm.h
index d0749dc5257a..871a44ab05c2 100644
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

