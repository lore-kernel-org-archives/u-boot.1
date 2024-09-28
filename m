Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032C9CF6493
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE89188DC6;
	Sat, 28 Sep 2024 22:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YON7YoGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E90A88CBF; Sat, 28 Sep 2024 22:01:24 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A79BF88CB8
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a0cc384a85so16723745ab.1
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553676; x=1728158476; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTtkBGd5s4+YWTHD4xJAVZSLAYO0yo46Yw9b8n5LrI4=;
 b=YON7YoGk5KQOdVNiPSBw9hhi0g52Gzlkahr6YoYCg0MJdS8ZyUoUh/8YOoo7qXoeD+
 Pl8GwHRxFhv20VmTkD9aMpopj09KHHoaDpkh95Otoc31VqwJw7XYVmN85/saudtmSI8v
 WUZ5bPkGFmVROb+R2waREQt0MK35xI2lFbX9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553676; x=1728158476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eTtkBGd5s4+YWTHD4xJAVZSLAYO0yo46Yw9b8n5LrI4=;
 b=eBivBrm3aQghq2Lj2YZ2idB7WEQQIvwevaSG6D3quGEMgfMsrKKgnWpaJN7Dtd3AHO
 G950phCDfj/6umBArDB34mvsXwgOQFDqBjl9+yZPOII5vIy5J++AQ4vQ21nU/4O/TP0n
 zItcoSEitOnXifnpsbxIbeyuKGXXpq93Q6l0nH7fZy/gX+aspTjaFPyjq+Fo4L32sN11
 /BMMzYVJ4Ib9pnpFv4l0ZSU2AJ25pSjsD4LuZ30QDDoEe6FXiDw4VpWpCHQbldzyBmT5
 NVviYowJs9tZdLacI5dtrEFpkALBEU5fq5/8KO5Tq4YjKxp2Ho8KVmCwW5wOhQxy4vQo
 X+KQ==
X-Gm-Message-State: AOJu0YyFLzgyaa5WoZ5HnnpZZrt5VjfUeFXc4rJvjFBXzIgtOk9gEPmI
 oLfGPdnk1LE7UVO7eIRxXYrCgWGyMECU8QWylLENQ/rYUhrkdUJN3QZiSGUtq5iN97DakJNlr78
 nVg==
X-Google-Smtp-Source: AGHT+IES1SqQKKV0uWeLHZKVve7YUOjsL/Jg42yoCndUS6VZFRR6VCah+f2ter5k+BPUL5c7U2xorg==
X-Received: by 2002:a05:6e02:154c:b0:39f:5d96:1fde with SMTP id
 e9e14a558f8ab-3a34516009dmr55540825ab.3.1727553676208; 
 Sat, 28 Sep 2024 13:01:16 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:01:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>
Subject: [PATCH v2 27/30] xpl: Rename spl_phase_prefix() and spl_phase_name()
Date: Sat, 28 Sep 2024 14:00:27 -0600
Message-Id: <20240928200030.194546-28-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

Use simpler names for these functions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/spl.c | 4 ++--
 arch/x86/lib/tpl.c     | 2 +-
 cmd/vbe.c              | 2 +-
 common/spl/spl.c       | 5 ++---
 include/spl.h          | 8 ++++----
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 71d785f4c3e..c50df5f9179 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -27,8 +27,8 @@ int sandbox_find_next_phase(char *fname, int maxlen, bool use_img)
 	const char *cur_prefix, *next_prefix;
 	int ret;
 
-	cur_prefix = spl_phase_prefix(xpl_phase());
-	next_prefix = spl_phase_prefix(xpl_next_phase());
+	cur_prefix = xpl_prefix(xpl_phase());
+	next_prefix = xpl_prefix(xpl_next_phase());
 	ret = os_find_u_boot(fname, maxlen, use_img, cur_prefix, next_prefix);
 	if (ret)
 		return log_msg_ret("find", ret);
diff --git a/arch/x86/lib/tpl.c b/arch/x86/lib/tpl.c
index 0606b4a1c67..f7df7e03621 100644
--- a/arch/x86/lib/tpl.c
+++ b/arch/x86/lib/tpl.c
@@ -103,7 +103,7 @@ int spl_spi_load_image(void)
 
 void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 {
-	debug("Jumping to %s at %lx\n", spl_phase_name(xpl_next_phase()),
+	debug("Jumping to %s at %lx\n", xpl_name(xpl_next_phase()),
 	      (ulong)spl_image->entry_point);
 #ifdef DEBUG
 	print_buffer(spl_image->entry_point, (void *)spl_image->entry_point, 1,
diff --git a/cmd/vbe.c b/cmd/vbe.c
index 423d9e5f8f0..186f6e6860d 100644
--- a/cmd/vbe.c
+++ b/cmd/vbe.c
@@ -93,7 +93,7 @@ static int do_vbe_state(struct cmd_tbl *cmdtp, int flag, int argc,
 	printf("Phases:");
 	for (i = PHASE_NONE; i < PHASE_COUNT; i++) {
 		if (handoff->phases & (1 << i))
-			printf(" %s", spl_phase_name(i));
+			printf(" %s", xpl_name(i));
 
 	}
 	if (!handoff->phases)
diff --git a/common/spl/spl.c b/common/spl/spl.c
index a221b64f81d..94657d00591 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -475,8 +475,7 @@ static int spl_common_init(bool setup_malloc)
 		if (ret)
 			log_debug("Failed to unstash bootstage: ret=%d\n", ret);
 	}
-	bootstage_mark_name(get_bootstage_id(true),
-			    spl_phase_name(xpl_phase()));
+	bootstage_mark_name(get_bootstage_id(true), xpl_name(xpl_phase()));
 #if CONFIG_IS_ENABLED(LOG)
 	ret = log_init();
 	if (ret) {
@@ -762,7 +761,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 
 	os = spl_image.os;
 	if (os == IH_OS_U_BOOT) {
-		debug("Jumping to %s...\n", spl_phase_name(xpl_next_phase()));
+		debug("Jumping to %s...\n", xpl_name(xpl_next_phase()));
 	} else if (CONFIG_IS_ENABLED(ATF) && os == IH_OS_ARM_TRUSTED_FIRMWARE) {
 		debug("Jumping to U-Boot via ARM Trusted Firmware\n");
 		spl_fixup_fdt(spl_image_fdt_addr(&spl_image));
diff --git a/include/spl.h b/include/spl.h
index d66c6cdd24a..fcf1313b8ae 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -194,11 +194,11 @@ static inline enum xpl_phase_t xpl_next_phase(void)
 }
 
 /**
- * spl_phase_name() - Get the name of the current phase
+ * xpl_name() - Get the name of a phase
  *
  * Return: phase name
  */
-static inline const char *spl_phase_name(enum xpl_phase_t phase)
+static inline const char *xpl_name(enum xpl_phase_t phase)
 {
 	switch (phase) {
 	case PHASE_TPL:
@@ -216,12 +216,12 @@ static inline const char *spl_phase_name(enum xpl_phase_t phase)
 }
 
 /**
- * spl_phase_prefix() - Get the prefix  of the current phase
+ * xpl_prefix() - Get the prefix  of the current phase
  *
  * @phase: Phase to look up
  * Return: phase prefix ("spl", "tpl", etc.)
  */
-static inline const char *spl_phase_prefix(enum xpl_phase_t phase)
+static inline const char *xpl_prefix(enum xpl_phase_t phase)
 {
 	switch (phase) {
 	case PHASE_TPL:
-- 
2.34.1

