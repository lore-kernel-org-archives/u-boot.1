Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B68C4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E65C987CCC;
	Sat, 16 Dec 2023 04:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vewxu8Vz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0180187CA0; Sat, 16 Dec 2023 04:15:31 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C24E687C99
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35d6c5f9579so5299205ab.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696527; x=1703301327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+DIrMp1VwzkeB6JHx0VVmxaXc+TEBLExWWkZimKOeg=;
 b=Vewxu8VzCvLRbqXGjMfLUYXEjkjAMNGlbfQ2nvY40sbBAgGx3xQT1mtCbPJ1IeP1b1
 SJxpWwHHHgimnW/W8qitTe4s828JzgdR4DWWetfwWhJ2S1FNEw0mdawk/mfyL0mU6Ljm
 tuE6nVyqzXVRxj3W1EKte45FKpq6PVvenTLz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696527; x=1703301327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+DIrMp1VwzkeB6JHx0VVmxaXc+TEBLExWWkZimKOeg=;
 b=DjsOjZGBPJpIbPLuNCU7dCa5wjUhKI6rLrNLgcFW1jAFRdZ1eTt1Fc+S1GuJ6X/p9q
 ctXNTNB0Ujh/qEXMnWZqOHYFWhQN63NBN/Vgfb9D9VWOiO2K9l9Cwlp6Hy2ZYBOtZg5D
 qAxtbK8mrn+HIjQlNi9qZCxX1dR9e/aLCJRLu4DK9gWjgQhEngB0SnyVqY4xLL5l2LmA
 1cGW31zohqlwftRHqJbGZWnuvWfYZfDCWk9TptDSL0niR1L27ZPSBtYmHxnEHIn2czjc
 OwO0zsXK/JscLUrj+oDeL6+c12xt/UOhmWOjacQ44aprDatcILO/HmQ5xUAtu6r3E89X
 709Q==
X-Gm-Message-State: AOJu0YygBHuNAa0FPJ2r06yvD7uA5UrLHRxFTi2SiuGtrG4Q3VFArVp8
 2Y3UbcE9A8A0fvhEVWGCA2nkU/4IhwWN6XTHDFjVUg==
X-Google-Smtp-Source: AGHT+IGZ5rpAKlcTQlOjyCFg/etwdvRvZVJtu8uXSFR5VjwEjX4YQJWQafqMxSQLAHrFJxpZUdZP1Q==
X-Received: by 2002:a05:6e02:1a61:b0:35f:7316:7c95 with SMTP id
 w1-20020a056e021a6100b0035f73167c95mr8346905ilv.50.1702696527317; 
 Fri, 15 Dec 2023 19:15:27 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 22/22] bootm: Create a new boot_run() function to handle
 booting
Date: Fri, 15 Dec 2023 20:14:26 -0700
Message-ID: <20231216031446.2222362-17-sjg@chromium.org>
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

Create a common function used by the three existing bootz/i/m_run()
functions, to reduce duplicated code.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

Changes in v3:
- Add new boot_run() function

 boot/bootm.c    | 40 ++++++++++++++--------------------------
 include/bootm.h | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 53236136f489..6a4cebcf7a08 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1123,47 +1123,35 @@ err:
 	return ret;
 }
 
-int bootm_run(struct bootm_info *bmi)
+int boot_run(struct bootm_info *bmi, const char *cmd, int extra_states)
 {
 	int states;
 
-	bmi->cmd_name = "bootm";
-	states = BOOTM_STATE_START | BOOTM_STATE_FINDOS | BOOTM_STATE_PRE_LOAD |
-		BOOTM_STATE_FINDOTHER | BOOTM_STATE_LOADOS |
-		BOOTM_STATE_OS_PREP | BOOTM_STATE_OS_FAKE_GO |
-		BOOTM_STATE_OS_GO | BOOTM_STATE_MEASURE;
+	bmi->cmd_name = cmd;
+	states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
+		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
 	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
 		states |= BOOTM_STATE_RAMDISK;
-	if (IS_ENABLED(CONFIG_PPC) || IS_ENABLED(CONFIG_MIPS))
-		states |= BOOTM_STATE_OS_CMDLINE;
+	states |= extra_states;
 
 	return bootm_run_states(bmi, states);
 }
 
-int bootz_run(struct bootm_info *bmi)
+int bootm_run(struct bootm_info *bmi)
 {
-	int states;
-
-	bmi->cmd_name = "bootz";
-	states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
-		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
-	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
-		states |= BOOTM_STATE_RAMDISK;
+	return boot_run(bmi, "bootm", BOOTM_STATE_START | BOOTM_STATE_FINDOS |
+			BOOTM_STATE_PRE_LOAD | BOOTM_STATE_FINDOTHER |
+			BOOTM_STATE_LOADOS);
+}
 
-	return bootm_run_states(bmi, states);
+int bootz_run(struct bootm_info *bmi)
+{
+	return boot_run(bmi, "bootz", 0);
 }
 
 int booti_run(struct bootm_info *bmi)
 {
-	int states;
-
-	bmi->cmd_name = "booti";
-	states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
-		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
-	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
-		states |= BOOTM_STATE_RAMDISK;
-
-	return bootm_run_states(bmi, states);
+	return boot_run(bmi, "booti", 0);
 }
 
 int bootm_boot_start(ulong addr, const char *cmdline)
diff --git a/include/bootm.h b/include/bootm.h
index eba35b33b4e5..9e0f8d60de0a 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -150,6 +150,24 @@ int bootm_measure(struct bootm_headers *images);
  */
 int bootm_run_states(struct bootm_info *bmi, int states);
 
+/**
+ * boot_run() - Run the entire bootm/booti/bootz process
+ *
+ * This runs through the boot process from start to finish, with a base set of
+ * states, along with the extra ones supplied.
+ *
+ * This uses bootm_run_states().
+ *
+ * Note that it is normally easier to use bootm_run(), etc. since they handle
+ * the extra states correctly.
+ *
+ * @bmi: bootm information
+ * @cmd: command being run, NULL if none
+ * @extra_states: Mask of extra states to use for the boot
+ * Return: 0 if ok, something else on error
+ */
+int boot_run(struct bootm_info *bmi, const char *cmd, int extra_states);
+
 /**
  * bootm_run() - Run the entire bootm process
  *
-- 
2.43.0.472.g3155946c3a-goog

