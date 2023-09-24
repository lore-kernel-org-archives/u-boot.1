Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6400ACE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:43:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CD3D86C08;
	Sun, 24 Sep 2023 22:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bsyiEumG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0A5F86B74; Sun, 24 Sep 2023 22:40:37 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8410186B98
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-79545e141c7so145436539f.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588034; x=1696192834; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDLWvFiHMvaLMW5g3lEIz8suVuy1i5qCK1pfIbAwiyc=;
 b=bsyiEumGeOMPG4263OitvsI8kdYNgQqiBZjDrneNhZJwAc3yin5TcPO1pnd5hLIGoQ
 CKhrTPYMUev1k+nC1BMPbWpE48z9+IZ7etEtHdWhZ2DX9QhxgWXz7+72q5qIkp2sxU1T
 VV+Skld80LTPnSmhn0/G+nxIbp/yWJepxD7nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588034; x=1696192834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDLWvFiHMvaLMW5g3lEIz8suVuy1i5qCK1pfIbAwiyc=;
 b=aTyVd8VAAGzKbHXHKtWfRfnNgwfhkLgzkQ80E9rbvF+Vz9JWZVqPJvDYZbPPuHTb6o
 T5eQdBFZKHuCwNsfhigMA1pDjoIcTmsHJF69pycJ+tIIv4jVaiSdpknrQKBU8pdYruaG
 dJN1w3LqiEwMTCVdMp8iPSULr92JFjqKGQbKABIZY3laWwXhz+5haPS8OyKSI0PRekaX
 QGpHMhOH7ZV4NyIDD+unI/c1NqaWJprVMApNI+KxicfvPWZM0WpsLQ8PT3CreTMUDu1D
 oIiLTqt9EnZtI3Gn6YufMR5HCAMVgfaWREXAqI5b9NZvA2m+MOyIfx7KKeYhYOiP3RSA
 qPAw==
X-Gm-Message-State: AOJu0Yy0+3RnXOXnK9jDFheVAkZzGe6FORC56CVkX1BUIltHifsK3Wvo
 I7iz0XffB/EOaFLIcUGf11HLCgFTFzMXqFK8Vmo=
X-Google-Smtp-Source: AGHT+IHvxyCHXN+/OgCCXULAAldN9urHQiijEupfe76sEyOxg1o1JGsBBPCkdn9I7BrgPUnSH0mPxA==
X-Received: by 2002:a05:6602:2bf3:b0:79d:1b4e:fb8a with SMTP id
 d19-20020a0566022bf300b0079d1b4efb8amr7285663ioy.9.1695588034127; 
 Sun, 24 Sep 2023 13:40:34 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 16/25] bootm: Allow building when cleanup functions are missing
Date: Sun, 24 Sep 2023 14:39:34 -0600
Message-ID: <20230924203953.1829820-17-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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
index b1c3afe0a3ad..ee8c79a650c2 100644
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
2.42.0.515.g380fc7ccd1-goog

