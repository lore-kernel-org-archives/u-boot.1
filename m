Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A485C4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 781D987CC7;
	Sat, 16 Dec 2023 04:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uh59znsC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB9C587C84; Sat, 16 Dec 2023 04:15:29 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A1A87C36
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-35d72b72ff7so5527695ab.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696526; x=1703301326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XX6AN5eNzBKaBGdvjVTFoW79HXgCy08SlM642NEYE38=;
 b=Uh59znsCyac9VYdVZGdcAkjKtv7l3hB5/HCUl8JSfRXx+tRBmsBZdbX2s7d1AMyT8p
 T7nf4MZUhrLL9bG6qmpADT7Kjw9i9g6w4LQloLLXQB6CAgNKIQdv9Iyx2toyeLzFM2gf
 E7jQMUBgA20dU3GXma54H1511dtVLOoHArtY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696526; x=1703301326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XX6AN5eNzBKaBGdvjVTFoW79HXgCy08SlM642NEYE38=;
 b=OLqZYwE78erR3acour2p1reximsJO+1DahQWT6ULsxuf6m4YhVUtmnuWwSD6Sb84lE
 A9MutwTf4Q76XtNsmL4VQX2U9EjidLKcwUnemA7NCENsA3E301YLQyscvkpQq8sSCbXg
 lsajS+nThlADZc2MEBMKCTFmtIpsnHgxQBdkDGpmUfV3Zhl7lErCjqC9aTP2wYBZGmaY
 kMaWj6TsQtz0S6PffBefHSk9bQU7Ik9/3UlOuP6A3kA/D6qg8Ltg93ex7FPNRuv9hwph
 fykhmohJOO+9DOilyLmd7guuM8X6SlKTvrZ4zNz/qoffAaMB9Jd8yG9XDYhq14EGCV7G
 kO4A==
X-Gm-Message-State: AOJu0YzA5NhVJSRbGmCWL01Zw2UQOBuMjBkGf+/XIWJyrkZskHheThwn
 7ip0UCNohyt0Iaq29aZ3ujj3aGilf77yBaIbQroNeA==
X-Google-Smtp-Source: AGHT+IH1eVT6nRbFzCOTriA5UJu6kW0wFILghSGg8NDRDak/F1/JCUfmo62EnCzlq5CKN/zTa0bhkg==
X-Received: by 2002:a05:6e02:1cab:b0:35d:59a2:6465 with SMTP id
 x11-20020a056e021cab00b0035d59a26465mr15276909ill.56.1702696526351; 
 Fri, 15 Dec 2023 19:15:26 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 21/22] bootm: Create a function to run through the booti
 states
Date: Fri, 15 Dec 2023 20:14:25 -0700
Message-ID: <20231215201413.v3.21.I95fe77f4a7f3d6c3dba3ecb3aec30a48739198f9@changeid>
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

In a few places, the booti command is used to handle a boot. We want
these to be done without needing CONFIG_CMDLINE, so add a new
booti_run() function to handle this.

So far this is not used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Rework series to allow OS access to cmdline arguments for bootm

 boot/bootm.c    | 13 +++++++++++++
 include/bootm.h | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/boot/bootm.c b/boot/bootm.c
index 40751a4c6e6f..53236136f489 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1153,6 +1153,19 @@ int bootz_run(struct bootm_info *bmi)
 	return bootm_run_states(bmi, states);
 }
 
+int booti_run(struct bootm_info *bmi)
+{
+	int states;
+
+	bmi->cmd_name = "booti";
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
diff --git a/include/bootm.h b/include/bootm.h
index f7d6d27ecb0a..eba35b33b4e5 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -176,6 +176,19 @@ int bootm_run(struct bootm_info *bmi);
  */
 int bootz_run(struct bootm_info *bmi);
 
+/**
+ * booti_run() - Run the entire booti process
+ *
+ * This runs through the booti process from start to finish, using the default
+ * set of states.
+ *
+ * This uses bootm_run_states().
+ *
+ * @bmi: bootm information
+ * Return: 0 if ok, something else on error
+ */
+int booti_run(struct bootm_info *bmi);
+
 void arch_preboot_os(void);
 
 /*
-- 
2.43.0.472.g3155946c3a-goog

