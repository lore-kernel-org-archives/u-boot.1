Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFF4E95A7E
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0298A86F4F;
	Sun,  8 Oct 2023 01:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AgQLl7dO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D976F86DDA; Sun,  8 Oct 2023 01:13:55 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF9FD86F0C
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7a2cc9ee64cso133594639f.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720397; x=1697325197; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BnIf55QgYF2oKjcC8nh/6+oYjz38GzbLKRsejGRdy6A=;
 b=AgQLl7dOOczElCu/j9rj9q6M61LzVe1XND1ld6hU6rwav1jpwYTbUahxg1id/b+ppB
 2YNv2HG6NKdd62vCL3t8A5BBJ4f4TH+eovTSJ4+JNK1WUtM92ZRCMVbkRSpmAjI7bZGj
 w+9bWJXmJormlRjzrycFyQZ61aVc5YcytqdS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720397; x=1697325197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BnIf55QgYF2oKjcC8nh/6+oYjz38GzbLKRsejGRdy6A=;
 b=psf97e3l4dPWGf6JZXNG7OEMe0TudynYXRSa76I/b9iN1b/9PSDEMfFOFTPTUGodJm
 itz2VbO+bkRFmUQUQpFbMP37Jcwud/M/46xLWX0Revi+zLK7KH6Gj8gWD97dLcZqVxII
 oNwcAZ/FnSfznDusy9e259fOmLg4sYkSFoqoBwlwEm/SCGQvWScmap20EqQStxHGz+hg
 +jR5CbR+mSUWSSY/WYI5HaZFpLpxLyx92S+87Tiu4/TlORrGn/avGYVCIbQUtm4cgJMN
 PEQNEiM0nLTcIfAMIidg7vYbI44PREAMWPWCYj2sY9loSVgnBfSqvB+WV3qnTCpCevSy
 u4+A==
X-Gm-Message-State: AOJu0YzF9DQ6tdPCacG6KcsvENxaym9T7wY8mpSPesJJKwFeJ4QTwBZ0
 oYRiBpWlFzwnrx4wUy9jzsTCpgLWqVSiEee8hUA=
X-Google-Smtp-Source: AGHT+IGGYJ+T5M3yQY/h2OVqpXfu1tVQ1ad1h/fMStFhsL/V2gNER3TyjXHc3MNRK7rUCg+UrdQwDg==
X-Received: by 2002:a05:6e02:11aa:b0:351:59db:a20e with SMTP id
 10-20020a056e0211aa00b0035159dba20emr10644774ilj.18.1696720397135; 
 Sat, 07 Oct 2023 16:13:17 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 16/27] bootm: Allow building when cleanup functions are
 missing
Date: Sat,  7 Oct 2023 17:12:35 -0600
Message-ID: <20231007231255.277623-17-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

There are two cleanup functions needed during boot which depend on
CMD_BOOTM: bootm_disable_interrupts() and board_quiesce_devices()

Provide static inline versions of these for when commands are not
enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/lib/bootm.c |  2 ++
 boot/bootm.c         | 10 ++++------
 include/bootm.h      | 15 +++++++++++++--
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index c56285738a26..db8df57cb56e 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -42,9 +42,11 @@ DECLARE_GLOBAL_DATA_PTR;
 
 static struct tag *params;
 
+#ifdef CONFIG_CMD_BOOTM
 __weak void board_quiesce_devices(void)
 {
 }
+#endif
 
 /**
  * announce_and_cleanup() - Print message and prepare for kernel boot
diff --git a/boot/bootm.c b/boot/bootm.c
index 8f96a80d4259..7deae058552a 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -47,9 +47,11 @@ static const void *boot_get_kernel(struct cmd_tbl *cmdtp, int flag, int argc,
 				   char *const argv[], struct bootm_headers *images,
 				   ulong *os_data, ulong *os_len);
 
+#ifdef CONFIG_CMD_BOOTM
 __weak void board_quiesce_devices(void)
 {
 }
+#endif
 
 #ifdef CONFIG_LMB
 static void boot_start_lmb(struct bootm_headers *images)
@@ -470,12 +472,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	return 0;
 }
 
-/**
- * bootm_disable_interrupts() - Disable interrupts in preparation for load/boot
- *
- * Return: interrupt flag (0 if interrupts were disabled, non-zero if they were
- *	enabled)
- */
+#ifdef CONFIG_CMD_BOOTM
 ulong bootm_disable_interrupts(void)
 {
 	ulong iflag;
@@ -505,6 +502,7 @@ ulong bootm_disable_interrupts(void)
 #endif
 	return iflag;
 }
+#endif
 
 #define CONSOLE_ARG		"console="
 #define NULL_CONSOLE		(CONSOLE_ARG "ttynull")
diff --git a/include/bootm.h b/include/bootm.h
index c3c7336207b1..17c740449efd 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -50,8 +50,6 @@ int bootm_host_load_images(const void *fit, int cfg_noffset);
 int boot_selected_os(int argc, char *const argv[], int state,
 		     struct bootm_headers *images, boot_os_fn *boot_fn);
 
-ulong bootm_disable_interrupts(void);
-
 /* This is a special function used by booti/bootz */
 int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 		      ulong size);
@@ -62,6 +60,15 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 
 void arch_preboot_os(void);
 
+#ifdef CONFIG_CMD_BOOTM
+/**
+ * bootm_disable_interrupts() - Disable interrupts, stop Ethernet and USB
+ *
+ * Return: interrupt flag (0 if interrupts were disabled, non-zero if they were
+ *	enabled)
+ */
+ulong bootm_disable_interrupts(void);
+
 /*
  * boards should define this to disable devices when EFI exits from boot
  * services.
@@ -69,6 +76,10 @@ void arch_preboot_os(void);
  * TODO(sjg@chromium.org>): Update this to use driver model's device_remove().
  */
 void board_quiesce_devices(void);
+#else
+static inline ulong bootm_disable_interrupts(void) { return 0; }
+static inline void board_quiesce_devices(void) {}
+#endif
 
 /**
  * switch_to_non_secure_mode() - switch to non-secure mode
-- 
2.42.0.609.gbb76f46606-goog

