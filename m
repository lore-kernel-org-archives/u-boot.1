Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB386C46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 925E887CB5;
	Sat, 16 Dec 2023 04:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XSU/g0+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF3E87C9A; Sat, 16 Dec 2023 04:15:29 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8A8987C7E
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7b35d476d61so56225539f.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696525; x=1703301325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=piHy8oBmnmrhrPJFkod4gdNpKnDh4EQ03FhQvYR3eg0=;
 b=XSU/g0+DdLGWyJPcWpTPvcxaFwaglV6tWH6smHvWnGf7uIbZBfkszylTmbDJfNODWV
 p1Rn8Swesqr55fJrLJz4NQA5rabQSG0xmhaa4ek6TKTikG7EoghepMunyxO+HUWXvSCi
 JKOov2TmR1mTEsqnr6yaY6NsNtpbnWhuWzSgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696525; x=1703301325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=piHy8oBmnmrhrPJFkod4gdNpKnDh4EQ03FhQvYR3eg0=;
 b=TnKZPAgAALgocAsxMdSYUbrgKJXZH+rw1WhDWTXvb9QjIkJFScpWPildxW9lwuYaSL
 /1Zdp1IwXoxY7KqaxRyLOxd+SFFqV6zMJHdkpFo+dWdR9Ayi1ZvxXWJ4Cla7KXo3G7s+
 3p4IPl1/yr2QO4TNKmtMPrw48g7b2SM5Pbq1CZx0ubVkZrwef3ZvVGJs/VVrx2TE9dvE
 SGEauTfdMxdRPU90Nfl/p3IMfyPrwtZu++2t7/P10rHgqPEDy+xbrG4KueZbnLdtCT0W
 NalHAS3OqTjW2uHavi3oOCZFp+WA5Iz90COBNf75E3UGj7EIqhN7aXbw6Ki49LEU6ABQ
 fmCw==
X-Gm-Message-State: AOJu0YxFO/x6pmVlRYOW/4OYaL5eRPAonyfg7JXU6GBADIEJn0YsgPOB
 rgJOB63TT8l1WVQIq1U+IkfKVhKJV9EXtmiytIyrqA==
X-Google-Smtp-Source: AGHT+IFyDi27o080t6YwsuCan6p88NaQ2g/IexULcbToXe5oAa84qF4HG5uaffKYpmkuTAhDQf7LuQ==
X-Received: by 2002:a05:6e02:12c4:b0:35d:a911:4973 with SMTP id
 i4-20020a056e0212c400b0035da9114973mr16596253ilm.28.1702696524967; 
 Fri, 15 Dec 2023 19:15:24 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 19/22] bootm: Create a function to run through the bootz
 states
Date: Fri, 15 Dec 2023 20:14:23 -0700
Message-ID: <20231216031446.2222362-15-sjg@chromium.org>
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

In a few places, the bootz command is used to handle a boot. We want
these to be done without needing CONFIG_CMDLINE, so add a new
bootz_run() function to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootm.c    | 13 +++++++++++++
 cmd/bootz.c     |  9 ++-------
 include/bootm.h | 13 +++++++++++++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index cce8485f2d47..40751a4c6e6f 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1140,6 +1140,19 @@ int bootm_run(struct bootm_info *bmi)
 	return bootm_run_states(bmi, states);
 }
 
+int bootz_run(struct bootm_info *bmi)
+{
+	int states;
+
+	bmi->cmd_name = "bootz";
+	states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
+		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
+	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
+		states |= BOOTM_STATE_RAMDISK;
+
+	return bootm_run_states(bmi, states);
+}
+
 int bootm_boot_start(ulong addr, const char *cmdline)
 {
 	char addr_str[30];
diff --git a/cmd/bootz.c b/cmd/bootz.c
index 05b15eb4d761..b6bb4aae72d4 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -74,7 +74,7 @@ static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct bootm_info bmi;
-	int states, ret;
+	int ret;
 
 	/* Consume 'bootz' */
 	argc--; argv++;
@@ -99,12 +99,7 @@ int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		bmi.conf_fdt = argv[2];
 	bmi.cmd_name = "bootz";
 
-	states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
-		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
-	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
-		states |= BOOTM_STATE_RAMDISK;
-
-	ret = bootm_run_states(&bmi, states);
+	ret = bootz_run(&bmi);
 
 	return ret;
 }
diff --git a/include/bootm.h b/include/bootm.h
index 6e6b2ad8f7ef..f7d6d27ecb0a 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -163,6 +163,19 @@ int bootm_run_states(struct bootm_info *bmi, int states);
  */
 int bootm_run(struct bootm_info *bmi);
 
+/**
+ * bootz_run() - Run the entire bootz process
+ *
+ * This runs through the bootz process from start to finish, using the default
+ * set of states.
+ *
+ * This uses bootm_run_states().
+ *
+ * @bmi: bootm information
+ * Return: 0 if ok, something else on error
+ */
+int bootz_run(struct bootm_info *bmi);
+
 void arch_preboot_os(void);
 
 /*
-- 
2.43.0.472.g3155946c3a-goog

