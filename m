Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D83FCDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:37:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC0C286F2B;
	Tue, 17 Oct 2023 00:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G58VqdP+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7C2886E7C; Tue, 17 Oct 2023 00:31:27 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7687803AE
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7740729ae12so349359185a.1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495454; x=1698100254; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTUMJLDV8nw50l5ysq5oOxl26SGsMcZWTpxU5FFTW0U=;
 b=G58VqdP+R7k1ptxOJ49shornIymtZYNt7+/5W2ctVTl9j5TUmUJLbH+GM5FMtOdCXB
 yQDbR8TmthRHSmM5cLed6pG0bgPozF+pO897tiYrKrog2ac1VGqZJ+2Z9pmIw2ob64VS
 OTT18pp2xviEAZmGpZt9wEo0g4YsyuE4pIqBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495454; x=1698100254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FTUMJLDV8nw50l5ysq5oOxl26SGsMcZWTpxU5FFTW0U=;
 b=kZApW6B0ow+k0vAFHD2qeZyCA1cXVaxGAHjDIODm7vKikJr21KzviqC+Fysucm8ZIn
 orB9vXawxpCHP7EUnBnvQdBG4jfWnwTl7vtDFUEvZDAjNbIjhj4lMoRjRuYLmC1ffY4P
 fjs8jt0HpY45DK2fqNNPcnhsz8Ll1N2QASLAiBqSGnxjvTlVmPV46D4h+55ohAVkIqG+
 82Qv4VOa/8QAr9Yx4sofQ6XyJQRR4AvLEXuYPbzBK9JBIlzXueoLrHq+rsxOy4geU+Pt
 iWtmaxssTtXiB3xCEE5x1jh/a+tj3KGHmNp3biNPGgQ1LeiM4o26QP8c3TjeDMdmXdKg
 Bfww==
X-Gm-Message-State: AOJu0YyGvtMcGh7YHiFWBGkKm10rIbS5IB1ENo07JaOI+jBeMa9tYmce
 0VNH2jTjfRr5cOqoaxFtPkglEkewYa4Vmqj1P+MyCA==
X-Google-Smtp-Source: AGHT+IHKLsVZZXW8DQ/yxuSQYZTLNCSDIvpQTQz5wf+iVmEgH+8Tg3APpW+pqr+vJvpfmH4wzSk1AA==
X-Received: by 2002:a05:620a:4008:b0:774:c7e:4306 with SMTP id
 h8-20020a05620a400800b007740c7e4306mr607809qko.68.1697495454705; 
 Mon, 16 Oct 2023 15:30:54 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:30:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 14/32] bootm: Allow building when cleanup functions are
 missing
Date: Mon, 16 Oct 2023 16:28:05 -0600
Message-ID: <20231016222835.596572-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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
2.42.0.655.g421f12c284-goog

