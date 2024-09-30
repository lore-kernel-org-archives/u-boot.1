Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA2BCF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32BBE88E6F;
	Mon, 30 Sep 2024 03:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HCmByWFa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F1D788E84; Mon, 30 Sep 2024 03:50:35 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5B0788E0F
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a0cad8a0a5so21954435ab.1
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661027; x=1728265827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ye/JEFP97938CJ+2T8zdpKE7kQdU1VE0ttCaR/9HDi8=;
 b=HCmByWFa0Vhb8sWgUg3fIBRSJw6Y/qa5xn3xYpHdPBNMnIrUka6gcskjTq8VN6V0ec
 8MYTphCQXP5EtNmD+qF4Yc3JBaewSMyAw8ZUz07ihuyg/7dFjQg4Hnwi+PSMXF6zhnWm
 vVSUZjNmHwUopOtkeh9W/kbvsYjdu4S3qBkRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661027; x=1728265827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ye/JEFP97938CJ+2T8zdpKE7kQdU1VE0ttCaR/9HDi8=;
 b=D2YihUpFBQhREvoD0+aCO6tjY+7sz7CEXCQTibsW7Ratovvs+6vVJ+IFjUGMqSssUG
 YsRqcBDOz0Icy/FLpEF6doKFe0Xmbo79+8Z084tIpFbS1zhpoY64bo3U1iCoiHHKh0C0
 rg24UQQv+jd0acDw6JD7cQFmUSlD/kyouVzB3y0OakNHkz5VmUpeCCzgDZbNmpB7GGCy
 Z/tj5qsgp+fMa07xC+mHHvVkJfaHp3joQle/CBeVw971gvrNyFs95H6Zl4+lbz+bXqS8
 6dFLBJPec+UB64gwym7mBtJN3Jq/p8GV9yU4zMPVizNDRhS/38d9VAeJemFrKATjIaKk
 M64g==
X-Gm-Message-State: AOJu0YykXIxnqVjNrj2vN6ISr70OSoFiTDNWqMBgtTxn5Xr2cQi++Jud
 gTRLf5fggy2khcMSbyK7p1Ek2msvKUtYZ1r/6BH57JOYqmsP44sZJLmFgUR/nndq1MAdQ5v5K+9
 Ziw==
X-Google-Smtp-Source: AGHT+IGAmbKd8ed81v+8nsI2/8kkrCQPHBJPYdRPw72gJmsBnuC8dIvOjMCrEZqoOxxZZgQfkK58ww==
X-Received: by 2002:a05:6e02:144e:b0:39f:6f8c:45f3 with SMTP id
 e9e14a558f8ab-3a3451aadf2mr88767585ab.16.1727661027255; 
 Sun, 29 Sep 2024 18:50:27 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:27 -0700 (PDT)
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
Subject: [PATCH v3 17/33] xpl: Rename spl_phase_prefix() and spl_phase_name()
Date: Sun, 29 Sep 2024 19:49:40 -0600
Message-Id: <20240930014956.1434060-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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
index ad5c309348b..9748a3fb3e9 100644
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
index 50ffe4f79f9..b2978d8bbaf 100644
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

