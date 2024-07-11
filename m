Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584E9C3DA45
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 21:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 757BD87D07;
	Thu, 11 Jul 2024 23:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AIUZmkF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2563E88009; Thu, 11 Jul 2024 23:27:17 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCB4487B77
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 23:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7035e281970so1012967a34.0
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 14:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720733233; x=1721338033; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p4npsEqWrdw7CgOg8m29Ai2uy5PB4kVET0r7FNuzJQg=;
 b=AIUZmkF/ZO2IgXFY6yNkBxY2cxXtpFG2KNJTMxGrEYe/oZViy1WU3YDpAj3sRfrck4
 KBRTfBM89mVm7X4KRNj7Is54twxfS1U5wMHIoIp3hBJZ2ZgZqh8d/bOeMoHlfxXc0peB
 bRCu6Wk6YQxNM4IUJWZwcOHpSoxgphD4thVbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720733233; x=1721338033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p4npsEqWrdw7CgOg8m29Ai2uy5PB4kVET0r7FNuzJQg=;
 b=qnifR7dNN2fMpGmd8S2p6yjSKjzrnFHqx3mdIk+ML0Ac7l7oC2T/I3f1ubylNaoKhS
 t3Ow9lALMtqsXh8gBAH1nO0K2NJqXImDTCTnMrKo91fyC8S4om/MViOqixNcpkxM3hMj
 wOntICXvTCZ/fP8AnFyoCWuYr/jAyX4SElP39GwbGbJOjR7nNVLh5261nP5JxfT9PQMY
 mq9R2kuK18Oi7TNeYR/3S5KoZqGCzSiI5//OGd4FFllfd8xta3lunnTqfdgcpDIKUnqP
 pi9ZY+wakl5Abw/aCbcn7yA2ONm+Zp3MmM3C78m2bca2+n5nPxtYH8BXUtnTdkxJJnQO
 ZIYA==
X-Gm-Message-State: AOJu0YxTlYXR+FlnVTOjijVyEizz8mzWPO5+2zs1jm7vtB6iDVZP4jp8
 /fYNNoKXoD0EH3Cj9D1ettOdQy/VCkJz0QUc+4oI2s/UYbZdEIBmJGEpR6vOU00wuDYb2FIY08G
 DIew0oA==
X-Google-Smtp-Source: AGHT+IErPvx+c2JYcjNj7x5WyKX2IvgKRZAJvZLVBdsfjKaq3LWYqxly3KVHRcSdASa8mK50BTqEiw==
X-Received: by 2002:a9d:7695:0:b0:703:66bb:5a1 with SMTP id
 46e09a7af769-708b51fa37dmr417020a34.18.1720733233424; 
 Thu, 11 Jul 2024 14:27:13 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-100-45.totalplay.net. [189.203.100.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70374f882f0sm1340268a34.39.2024.07.11.14.27.12
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 14:27:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v2] bootstash: Do not provide a default address for all
Date: Thu, 11 Jul 2024 15:27:10 -0600
Message-Id: <20240711212710.2743991-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703212338.1436606-1-trini@konsulko.com>
References: <20240703212338.1436606-1-trini@konsulko.com>
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

A valid memory location to stash bootstage information at will be
architecture dependent. Move the existing defaults to the main Kconfig
file for this option and set 0x0 as the default only for sandbox.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Seeing that BOOTSTAGE_STASH_ADDR did not depend on BOOTSTAGE_STASH in
  turn lead to discovering that (minor) BOOTSTAGE_STASH_SIZE was also
  missing a depends on line and then that a number of places built code
  with BOOTSTAGE_STASH_ADDR=0x0 as a compiles-but-likely-fails option.
  Rework a number of spots to guard usage around BOOTSTAGE_STASH being
  enabled.
---
 arch/arm/mach-rockchip/tpl.c      |  4 ++--
 arch/arm/mach-stm32mp/Kconfig.13x |  3 ---
 arch/arm/mach-stm32mp/Kconfig.15x |  3 ---
 arch/arm/mach-stm32mp/Kconfig.25x |  3 ---
 arch/x86/cpu/cpu.c                |  2 ++
 boot/Kconfig                      |  6 +++++-
 cmd/bootstage.c                   |  8 +++++++-
 common/board_f.c                  |  2 ++
 common/bootstage.c                |  2 ++
 common/spl/spl.c                  |  2 ++
 include/bootstage.h               | 14 ++++++++------
 11 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
index 50f04f9474a0..a47cba5163ab 100644
--- a/arch/arm/mach-rockchip/tpl.c
+++ b/arch/arm/mach-rockchip/tpl.c
@@ -92,10 +92,10 @@ void board_init_f(ulong dummy)
 int board_return_to_bootrom(struct spl_image_info *spl_image,
 			    struct spl_boot_device *bootdev)
 {
-#ifdef CONFIG_BOOTSTAGE_STASH
-	int ret;
+	int __maybe_unused ret;
 
 	bootstage_mark_name(BOOTSTAGE_ID_END_TPL, "end tpl");
+#if IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
 	ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
 			      CONFIG_BOOTSTAGE_STASH_SIZE);
 	if (ret)
diff --git a/arch/arm/mach-stm32mp/Kconfig.13x b/arch/arm/mach-stm32mp/Kconfig.13x
index 4d74b35055b8..bc8b3f8cf77f 100644
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
index d99aa9fd694a..42da36a73e85 100644
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
index 2c0f691f8b54..7d2d8171845b 100644
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
index c8433360f28e..7ce6443cc77e 100644
--- a/arch/x86/cpu/cpu.c
+++ b/arch/x86/cpu/cpu.c
@@ -75,8 +75,10 @@ int __weak x86_cleanup_before_linux(void)
 	ret = mp_park_aps();
 	if (ret)
 		return log_msg_ret("park", ret);
+#if IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
 	bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
 			CONFIG_BOOTSTAGE_STASH_SIZE);
+#endif
 
 	return 0;
 }
diff --git a/boot/Kconfig b/boot/Kconfig
index ffcae840a506..ba8bddd14219 100644
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
index 5246924f39a4..4ae09a6fd03d 100644
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
index 212ffb3090b2..37ae1641f1f0 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -809,6 +809,7 @@ static int initf_bootstage(void)
 	ret = bootstage_init(!from_spl);
 	if (ret)
 		return ret;
+#if IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
 	if (from_spl) {
 		const void *stash = map_sysmem(CONFIG_BOOTSTAGE_STASH_ADDR,
 					       CONFIG_BOOTSTAGE_STASH_SIZE);
@@ -819,6 +820,7 @@ static int initf_bootstage(void)
 			return ret;
 		}
 	}
+#endif
 
 	bootstage_mark_name(BOOTSTAGE_ID_START_UBOOT_F, "board_init_f");
 
diff --git a/common/bootstage.c b/common/bootstage.c
index fb6befcbc4a8..5e6462cd0a34 100644
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
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 7794ddccade1..47db4ead5050 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -472,11 +472,13 @@ static int spl_common_init(bool setup_malloc)
 		      ret);
 		return ret;
 	}
+#if CONFIG_IS_ENABLED(BOOTSTAGE)
 	if (!u_boot_first_phase()) {
 		ret = bootstage_unstash_default();
 		if (ret)
 			log_debug("Failed to unstash bootstage: ret=%d\n", ret);
 	}
+#endif
 	bootstage_mark_name(get_bootstage_id(true),
 			    spl_phase_name(spl_phase()));
 #if CONFIG_IS_ENABLED(LOG)
diff --git a/include/bootstage.h b/include/bootstage.h
index f4e77b09d747..2d4987f31414 100644
--- a/include/bootstage.h
+++ b/include/bootstage.h
@@ -462,18 +462,20 @@ int _bootstage_unstash_default(void);
 
 static inline int bootstage_stash_default(void)
 {
-	if (CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE_STASH))
-		return _bootstage_stash_default();
-
+#if CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
+	return _bootstage_stash_default();
+#else
 	return 0;
+#endif
 }
 
 static inline int bootstage_unstash_default(void)
 {
-	if (CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE_STASH))
-		return _bootstage_unstash_default();
-
+#if CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
+	return _bootstage_unstash_default();
+#else
 	return 0;
+#endif
 }
 
 /* Helper macro for adding a bootstage to a line of code */
-- 
2.34.1

