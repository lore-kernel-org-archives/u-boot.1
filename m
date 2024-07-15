Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BED1C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 11:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C1A885EE;
	Mon, 15 Jul 2024 13:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JF+URgTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2910488765; Mon, 15 Jul 2024 13:42:08 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00BE7885E7
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 13:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52eafa1717bso4409683e87.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 04:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721043725; x=1721648525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OHRuVL/SzHDkjlN5wjJn3HOZ3SDhsAFa36kQmMpGDbM=;
 b=JF+URgTviBHZm54z0An9smmOqjGhptvr+bU4vKRdXFy5iqW1R7+Hw9pG84u8J7v3Kw
 A3Dgx1gebzlSfAwDgYJPembwSWflNAPQUOsjgIgHqnRBnBQfaA7eyoAsqmTWFY1Jn6cJ
 zoYaSzn4oK5g9R7eO4FMDXB5x0+9j/3n+Bj9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721043725; x=1721648525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OHRuVL/SzHDkjlN5wjJn3HOZ3SDhsAFa36kQmMpGDbM=;
 b=rz9A87AP9l029jPF1IRe0Pph2gVXMPwvI4OWrRSYMeuFDCOfgUrIisgxAq8x/r7PrW
 0J+gvEZJB0XlqFoL+PT+4S7Bn0OU+QZlVeV80ihtP5kP4Y/Eo2TJLd5HLX450/O23/RT
 3UQwVkgKc+gtRaZkwl83vbobzC9gzGHv0VqU49/IuKkAtm8S9/ZTqAvcGd3MAOEyT4gT
 Cj2Wht3zTq+lIWiTLwjrG3bbCm7qgS6nT4VBgOCQEp1rYZH+ZqlqbfFOwJh9nMPEyAFx
 2N4Sc3ZNkCVdAkFgdLjCjZ3tG6FAgqZoqGahndxlTeO7FEm3WCtMuaezhnqtA5+2Ew4D
 /Gzw==
X-Gm-Message-State: AOJu0YyA4MBn9js1icch5TbDgyyDXYRh7bWmlRbgCcLFA4Y0bYDOFUu0
 FVkrKtXjAGzNZEgsAZXeKpbuOz1MKGWNwDoNHqGvzyLNFNBtk05R1C2rEZP8A+vRN2t11MsKgvU
 =
X-Google-Smtp-Source: AGHT+IHPHwArg/iIupMo/1Gm3BS0HxQ3UcF/pW5Ns8eC5s9svoVFeBkbAEz92gdbseNTNjYRzSynoQ==
X-Received: by 2002:a05:6512:281d:b0:52c:80f6:d384 with SMTP id
 2adb3069b0e04-52eb9990d0emr13893461e87.3.1721043724872; 
 Mon, 15 Jul 2024 04:42:04 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e9a814sm83289025e9.27.2024.07.15.04.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 04:42:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3] bootstash: Do not provide a default address for all
Date: Mon, 15 Jul 2024 12:42:00 +0100
Message-Id: <20240715114200.817719-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

From: Tom Rini <trini@konsulko.com>

A valid memory location to stash bootstage information at will be
architecture dependent. Move the existing defaults to the main Kconfig
file for this option and set 0x0 as the default only for sandbox.

Signed-off-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Use stub functions to avoid unnecessary #ifdefs

Changes in v2:
- Seeing that BOOTSTAGE_STASH_ADDR did not depend on BOOTSTAGE_STASH in
  turn lead to discovering that (minor) BOOTSTAGE_STASH_SIZE was also
  missing a depends on line and then that a number of places built code
  with BOOTSTAGE_STASH_ADDR=0x0 as a compiles-but-likely-fails option.
  Rework a number of spots to guard usage around BOOTSTAGE_STASH being
  enabled.

 arch/arm/mach-rockchip/tpl.c      | 6 ++----
 arch/arm/mach-stm32mp/Kconfig.13x | 3 ---
 arch/arm/mach-stm32mp/Kconfig.15x | 3 ---
 arch/arm/mach-stm32mp/Kconfig.25x | 3 ---
 arch/x86/cpu/cpu.c                | 3 +--
 boot/Kconfig                      | 6 +++++-
 cmd/bootstage.c                   | 8 +++++++-
 common/board_f.c                  | 5 +----
 common/bootstage.c                | 2 ++
 9 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
index 50f04f9474a..597a5caa84b 100644
--- a/arch/arm/mach-rockchip/tpl.c
+++ b/arch/arm/mach-rockchip/tpl.c
@@ -92,15 +92,13 @@ void board_init_f(ulong dummy)
 int board_return_to_bootrom(struct spl_image_info *spl_image,
 			    struct spl_boot_device *bootdev)
 {
-#ifdef CONFIG_BOOTSTAGE_STASH
 	int ret;
 
 	bootstage_mark_name(BOOTSTAGE_ID_END_TPL, "end tpl");
-	ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
-			      CONFIG_BOOTSTAGE_STASH_SIZE);
+	ret = bootstage_stash_default();
 	if (ret)
 		debug("Failed to stash bootstage: err=%d\n", ret);
-#endif
+
 	back_to_bootrom(BROM_BOOT_NEXTSTAGE);
 
 	return 0;
diff --git a/arch/arm/mach-stm32mp/Kconfig.13x b/arch/arm/mach-stm32mp/Kconfig.13x
index 4d74b35055b..bc8b3f8cf77 100644
--- a/arch/arm/mach-stm32mp/Kconfig.13x
+++ b/arch/arm/mach-stm32mp/Kconfig.13x
@@ -28,9 +28,6 @@ config PRE_CON_BUF_ADDR
 config PRE_CON_BUF_SZ
 	default 4096
 
-config BOOTSTAGE_STASH_ADDR
-	default 0xC3000000
-
 if BOOTCOUNT_GENERIC
 config SYS_BOOTCOUNT_SINGLEWORD
 	default y
diff --git a/arch/arm/mach-stm32mp/Kconfig.15x b/arch/arm/mach-stm32mp/Kconfig.15x
index d99aa9fd694..42da36a73e8 100644
--- a/arch/arm/mach-stm32mp/Kconfig.15x
+++ b/arch/arm/mach-stm32mp/Kconfig.15x
@@ -86,9 +86,6 @@ config PRE_CON_BUF_ADDR
 config PRE_CON_BUF_SZ
 	default 4096
 
-config BOOTSTAGE_STASH_ADDR
-	default 0xC3000000
-
 if BOOTCOUNT_GENERIC
 config SYS_BOOTCOUNT_SINGLEWORD
 	default y
diff --git a/arch/arm/mach-stm32mp/Kconfig.25x b/arch/arm/mach-stm32mp/Kconfig.25x
index 2c0f691f8b5..7d2d8171845 100644
--- a/arch/arm/mach-stm32mp/Kconfig.25x
+++ b/arch/arm/mach-stm32mp/Kconfig.25x
@@ -24,9 +24,6 @@ config PRE_CON_BUF_ADDR
 config PRE_CON_BUF_SZ
 	default 4096
 
-config BOOTSTAGE_STASH_ADDR
-	default 0x87000000
-
 if DEBUG_UART
 
 config DEBUG_UART_BOARD_INIT
diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
index c8433360f28..ad21fdb457a 100644
--- a/arch/x86/cpu/cpu.c
+++ b/arch/x86/cpu/cpu.c
@@ -75,8 +75,7 @@ int __weak x86_cleanup_before_linux(void)
 	ret = mp_park_aps();
 	if (ret)
 		return log_msg_ret("park", ret);
-	bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
-			CONFIG_BOOTSTAGE_STASH_SIZE);
+	bootstage_stash_default();
 
 	return 0;
 }
diff --git a/boot/Kconfig b/boot/Kconfig
index 95300b008c5..05993743971 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1002,13 +1002,17 @@ config BOOTSTAGE_STASH
 
 config BOOTSTAGE_STASH_ADDR
 	hex "Address to stash boot timing information"
-	default 0x0
+	depends on BOOTSTAGE_STASH
+	default 0xC3000000 if STM32MP13X || STM32MP15X
+	default 0x87000000 if STM32MP25X
+	default 0x0 if SANDBOX
 	help
 	  Provide an address which will not be overwritten by the OS when it
 	  starts, so that it can read this information when ready.
 
 config BOOTSTAGE_STASH_SIZE
 	hex "Size of boot timing stash region"
+	depends on BOOTSTAGE_STASH
 	default 0x1000
 	help
 	  This should be large enough to hold the bootstage stash. A value of
diff --git a/cmd/bootstage.c b/cmd/bootstage.c
index 5246924f39a..4ae09a6fd03 100644
--- a/cmd/bootstage.c
+++ b/cmd/bootstage.c
@@ -15,6 +15,7 @@ static int do_bootstage_report(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
 static int get_base_size(int argc, char *const argv[], ulong *basep,
 			 ulong *sizep)
 {
@@ -58,11 +59,14 @@ static int do_bootstage_stash(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	return 0;
 }
+#endif
 
 static struct cmd_tbl cmd_bootstage_sub[] = {
 	U_BOOT_CMD_MKENT(report, 2, 1, do_bootstage_report, "", ""),
+#if IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
 	U_BOOT_CMD_MKENT(stash, 4, 0, do_bootstage_stash, "", ""),
 	U_BOOT_CMD_MKENT(unstash, 4, 0, do_bootstage_stash, "", ""),
+#endif
 };
 
 /*
@@ -91,6 +95,8 @@ U_BOOT_CMD(bootstage, 4, 1, do_boostage,
 	"Boot stage command",
 	" - check boot progress and timing\n"
 	"report                      - Print a report\n"
+#if IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
 	"stash [<start> [<size>]]    - Stash data into memory\n"
-	"unstash [<start> [<size>]]  - Unstash data from memory"
+	"unstash [<start> [<size>]]  - Unstash data from memory\n"
+#endif
 );
diff --git a/common/board_f.c b/common/board_f.c
index 22c180b2187..29e185137ad 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -810,10 +810,7 @@ static int initf_bootstage(void)
 	if (ret)
 		return ret;
 	if (from_spl) {
-		const void *stash = map_sysmem(CONFIG_BOOTSTAGE_STASH_ADDR,
-					       CONFIG_BOOTSTAGE_STASH_SIZE);
-
-		ret = bootstage_unstash(stash, CONFIG_BOOTSTAGE_STASH_SIZE);
+		ret = bootstage_stash_default();
 		if (ret && ret != -ENOENT) {
 			debug("Failed to unstash bootstage: err=%d\n", ret);
 			return ret;
diff --git a/common/bootstage.c b/common/bootstage.c
index fb6befcbc4a..5e6462cd0a3 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -501,6 +501,7 @@ int bootstage_unstash(const void *base, int size)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
 int _bootstage_stash_default(void)
 {
 	return bootstage_stash(map_sysmem(CONFIG_BOOTSTAGE_STASH_ADDR, 0),
@@ -514,6 +515,7 @@ int _bootstage_unstash_default(void)
 
 	return bootstage_unstash(stash, CONFIG_BOOTSTAGE_STASH_SIZE);
 }
+#endif
 
 int bootstage_get_size(void)
 {
-- 
2.34.1

