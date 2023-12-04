Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA81C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9F6F8787C;
	Mon,  4 Dec 2023 01:28:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JdSKH76r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FE6387888; Mon,  4 Dec 2023 01:28:09 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F94E87655
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:28:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d0a5422c80so3215995ad.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649686; x=1702254486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJUIOHFw06mhWl0gdv6qYQvk9P+lzV6E7i4IYmQfGnY=;
 b=JdSKH76rtZso4BXmSI2WNTdNhxMF2tEvzi5Pic8rFyar9VJaX6D30B5bf20P5Zk3Df
 YQrX+uJIXtEhz0EtkFVXrx62hZ/DSYEqmF6Nbqc9Klx3xygVGqB6Gj9oHxqg26Wd3dRm
 fhmfCZ/5f8ILNPljvgW7HFf/FpLzw8AgaIn38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649686; x=1702254486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lJUIOHFw06mhWl0gdv6qYQvk9P+lzV6E7i4IYmQfGnY=;
 b=vDVz1M7TX0Ske4NUaxptD8wkX3GNOrlFGIZ6/An5p9xlQD0dO7eTJ5SNO9rcDbvuYn
 bzsx5dPrqQo4xr+nLvcQ4Z9uRfzlp85ntGufTQaDA2HYeQUaxXN8V3DUWzvXNy5Lwx5R
 oPSCmy0lf4aako4NDNNccqc51Y+BfNtMcIhjnOsPoQEoZ8I0XQ8h5vwpwYXH1PRAcykX
 Lqq+xdKrcA/jPsXp0meWbHax/sNf4B903+Zc4sQKyXEj7igCAdsR4gkXuTjzfcDSS4tv
 ygMclFvlu6PM6NwFZeFdxzfNT/dl+HvTmaz5Bi01Kysvp8fF0CX+PamPjPB9dZn+7Ztx
 aX/A==
X-Gm-Message-State: AOJu0Ywsn4/G/H1/26J+YcwETOjwzxKXjb98KaaUf/IbMfAECqR7RNYe
 2sICX6j9PRaaO00ZootWYtGtZwCqgnXtsxAt5Pe0OA==
X-Google-Smtp-Source: AGHT+IGAXjGSfxFBbJQ3oF+P2PcyRQOlN/aqUnCjHW89ft2vSu4W4RyIucT0lhgu0wMP1A1Tcg1uOw==
X-Received: by 2002:a17:902:f38b:b0:1d0:6ffe:9f6 with SMTP id
 f11-20020a170902f38b00b001d06ffe09f6mr2364094ple.84.1701649685784; 
 Sun, 03 Dec 2023 16:28:05 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:28:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 16/18] bootm: Create a function to run through the bootz states
Date: Sun,  3 Dec 2023 17:26:32 -0700
Message-ID: <20231204002642.895926-10-sjg@chromium.org>
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

In a few places, the bootz command is used to handle a boot. We want
these to be done without needing CONFIG_CMDLINE, so add a new
bootz_run() function to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c    | 13 +++++++++++++
 cmd/bootz.c     |  9 ++-------
 include/bootm.h | 13 +++++++++++++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 301ba480677d..22c6d1604176 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1142,6 +1142,19 @@ int bootm_run(struct bootm_info *bmi)
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
index fa6743a71170..f03062f1cf75 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -75,7 +75,7 @@ static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct bootm_info bmi;
-	int states, ret;
+	int ret;
 
 	/* Consume 'bootz' */
 	argc--; argv++;
@@ -102,12 +102,7 @@ int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	bmi.images = &images;
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
index ef46c085b594..d7c9486553e4 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -150,6 +150,19 @@ int bootm_run_states(struct bootm_info *bmi, int states);
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
2.43.0.rc2.451.g8631bc7472-goog

