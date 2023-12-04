Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDCEC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C4088787F;
	Mon,  4 Dec 2023 01:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GMJHUYgD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D6C187655; Mon,  4 Dec 2023 01:28:17 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 584CE8788F
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso1997897a12.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649693; x=1702254493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tskEZ9IhWCs6nsVHSL/hNFEW+B2h3ZE2AyrXo8ygh/k=;
 b=GMJHUYgD1Hnm3VT597lm6JsoHjcMulSMDaXq0EhmlHGVKY8OcLk3xIoLbvOmzWFiSF
 dBWeMWtwr5UcmPor/edJHPeoQ9fQLgKtsBQ3Om8BGI8ydFVWlHKxZHTBptGPVmF2Uian
 LMlLH+ATLyZ95rOLtgXm5cJnozIyyWxuhX/uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649693; x=1702254493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tskEZ9IhWCs6nsVHSL/hNFEW+B2h3ZE2AyrXo8ygh/k=;
 b=wydP16Pv4sqFYwqREvLEZb7Ztnm8FY3CsZBQsJP61jN3/X9f5lS1UgbFivTkrAAQDb
 B7wrlJZ17e5IMrGeFvAjrFxdYso0zq8MyMAw/0xGUXYN5B8z8Uu2pae5t0NpDmMBZCM9
 kWS7So4hVv17ekRyqT2IAuK+kXTDnhDkZqhoJqhquRygSbl6QuxATLin8bWIF+weD+Ny
 i2REwEpi/LSvhg3rzEdpcnvaPoRAPKDlhNS8Ac4EBegPIxOCin2Wa/Q7liTmp1BeFTCD
 aZhS+T5YjiNPI2XCEI0Iz6exA3+7ek0KxRKG6i5azjJXLDsQ3GtbVk4U7xo/vceACgbF
 D60A==
X-Gm-Message-State: AOJu0YybWpTMjQlD2U6muE0aPS8DH89fJz9ZDNqrQdDJLEo8cGqgRR8u
 t7/Ap+W6w82q8lkfmJ4NJ9ypuAde5dcEcw542Pd52A==
X-Google-Smtp-Source: AGHT+IHhNMJ+je0LosnsbfKzV81G3DD0iIWTniiZ+aHM8yZAOK9IHYKEpCwvGkFYtthgrG2n6odjig==
X-Received: by 2002:a17:902:ed42:b0:1cf:e9b5:90ea with SMTP id
 y2-20020a170902ed4200b001cfe9b590eamr3207031plb.36.1701649693490; 
 Sun, 03 Dec 2023 16:28:13 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:28:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 18/18] bootm: Create a function to run through the booti states
Date: Sun,  3 Dec 2023 17:26:34 -0700
Message-ID: <20231203172622.18.I95fe77f4a7f3d6c3dba3ecb3aec30a48739198f9@changeid>
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

In a few places, the booti command is used to handle a boot. We want
these to be done without needing CONFIG_CMDLINE, so add a new
booti_run() function to handle this.

So far this is not used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c    | 13 +++++++++++++
 include/bootm.h | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/boot/bootm.c b/boot/bootm.c
index 22c6d1604176..f630b8c1a9c3 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1155,6 +1155,19 @@ int bootz_run(struct bootm_info *bmi)
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
index d7c9486553e4..ce5298e4ed97 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -163,6 +163,19 @@ int bootm_run(struct bootm_info *bmi);
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
2.43.0.rc2.451.g8631bc7472-goog

