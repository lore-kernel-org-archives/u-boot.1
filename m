Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507F8C83F2B
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D127D8669D;
	Thu, 31 Aug 2023 05:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GJcBU9/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FDD086576; Thu, 31 Aug 2023 05:53:47 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F9CC8657D
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-34ccc0fca24so1483475ab.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454023; x=1694058823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AjTsY+T0YJ/uKN0s7wAMcyrLcq33lCg+7wjmW62g53U=;
 b=GJcBU9/B8G56hMy/E6mCzzdinbYxZVaHU2y42J7TQAhYryCgqgqKYHHA9/LfzmOtWZ
 pY9XGW5Y0p9wC/QkygSfAOjLyT5l8vRJQj1j81+52dKV6K85lHOTNOknK2XB/gEoBlBh
 S8aJGhiQcjARxkokkiBCS3Qw5TH2C2QpKQMrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454023; x=1694058823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AjTsY+T0YJ/uKN0s7wAMcyrLcq33lCg+7wjmW62g53U=;
 b=XCtof68P1PcR4HqH8KxQF8NE97ZhG+8XQEvZNgEc9ssoDQPoB9MMElMyztNTRn5Zr0
 O81BSSJUNHI9r7/2eM5YoxtW1DVDgrT0SsWGb1bVBdRuK7mQl33bTNNeLaxhIuJPds0b
 +ZB7bJ1A8/bMAur7HbySYZt8AcV4vS/jbwzzFxpP7y5C2tShY9+I3KXo/53ZYR4Hd1BV
 ZLWCzP6FAK8XEhMGy1THFffnpEFfLBj8+G8HUv9Yo4gWTVFLXNmBs42YN6ACT4DlNWr9
 QQ19Mfu6KlnGr/FrTd1Y7B1ddKzrYWkn+PGM1+x98EZGhNXflv5bAWDDbMoiXRJVczTF
 wqfA==
X-Gm-Message-State: AOJu0Yz9q5cehEJoFlH2JIe406ZwFHr7TXXGb0fN68/fYrbnrl6icyho
 MP/A/ErP+2GdSir4EiEEJt5T/HHZ7j2qBZMBw8o=
X-Google-Smtp-Source: AGHT+IEjo7pAE323jywI/VSjaf0P9lZQVp9NlVN0+pIQMYhgaUeFrGz/3P56zJpUyPa7aHu+1FC26Q==
X-Received: by 2002:a05:6e02:d90:b0:34c:dbeb:a2a2 with SMTP id
 i16-20020a056e020d9000b0034cdbeba2a2mr4523369ilj.21.1693454022940; 
 Wed, 30 Aug 2023 20:53:42 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 16/19] Kconfig: Move TEXT_BASE et al under general setup
Date: Wed, 30 Aug 2023 21:53:10 -0600
Message-ID: <20230831035319.2316665-17-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831035319.2316665-1-sjg@chromium.org>
References: <20230831035319.2316665-1-sjg@chromium.org>
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

These don't relate to booting. Move them out of there and into the same
place as the other related settings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 Kconfig      | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 boot/Kconfig | 65 ----------------------------------------------------
 2 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/Kconfig b/Kconfig
index 0a2e97578dfc..2d4b82149860 100644
--- a/Kconfig
+++ b/Kconfig
@@ -585,6 +585,71 @@ config MP
 	  This provides an option to bringup different processors
 	  in multiprocessor cases.
 
+config HAVE_TEXT_BASE
+	bool
+	depends on !NIOS2 && !XTENSA
+	depends on !EFI_APP
+	default y
+
+config TEXT_BASE
+	depends on HAVE_TEXT_BASE
+	default 0x0 if POSITION_INDEPENDENT
+	default 0x80800000 if ARCH_OMAP2PLUS || ARCH_K3
+	default 0x81700000 if MACH_SUNIV
+	default 0x2a000000 if MACH_SUN9I
+	default 0x4a000000 if SUNXI_MINIMUM_DRAM_MB >= 256
+	default 0x42e00000 if SUNXI_MINIMUM_DRAM_MB >= 64
+	hex "Text Base"
+	help
+	  The address in memory that U-Boot will be running from, initially.
+
+config HAVE_SYS_MONITOR_BASE
+	bool
+	depends on ARC || MIPS || M68K || NIOS2 || PPC || XTENSA || X86 \
+		|| ENV_IS_IN_FLASH || MTD_NOR_FLASH
+	depends on !EFI_APP
+	default y
+
+config SYS_MONITOR_BASE
+	depends on HAVE_SYS_MONITOR_BASE
+	hex "Physical start address of boot monitor code"
+	default TEXT_BASE
+	help
+	  The physical start address of boot monitor code (which is the same as
+	  CONFIG_TEXT_BASE when linking) and the same as CFG_SYS_FLASH_BASE
+	  when booting from flash.
+
+config SPL_SYS_MONITOR_BASE
+	depends on MPC85xx && SPL && HAVE_SYS_MONITOR_BASE
+	hex "Physical start address of SPL monitor code"
+	default SPL_TEXT_BASE
+
+config TPL_SYS_MONITOR_BASE
+	depends on MPC85xx && TPL && HAVE_SYS_MONITOR_BASE
+	hex "Physical start address of TPL monitor code"
+
+config DYNAMIC_SYS_CLK_FREQ
+	bool "Determine CPU clock frequency at run-time"
+	help
+	  Implement a get_board_sys_clk function that will determine the CPU
+	  clock frequency at run time, rather than define it statically.
+
+config SYS_CLK_FREQ
+	depends on !DYNAMIC_SYS_CLK_FREQ
+	int "CPU clock frequency"
+	default 125000000 if ARCH_LS1012A
+	default 100000000 if ARCH_P2020 || ARCH_T1024 || ARCH_T1042 || \
+			     ARCH_LS1021A || FSL_LSCH2 || FSL_LSCH3
+	default 66666666 if ARCH_P1010 || ARCH_P1020 || ARCH_T4240
+	default 66660000 if ARCH_T2080
+	default 33333333 if RCAR_GEN3
+	default 24000000 if ARCH_EXYNOS
+	default 20000000 if RCAR_GEN2
+	default 0
+	help
+	  A static value for the CPU frequency.  Note that if not required
+	  for a given SoC, this can be left at 0.
+
 source "api/Kconfig"
 
 endmenu		# General setup
diff --git a/boot/Kconfig b/boot/Kconfig
index 17f54b926f05..458512a4ade2 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -693,71 +693,6 @@ config SUPPORT_RAW_INITRD
 	  address of the initrd must be augmented by it's size, in the following
 	  format: "<initrd address>:<initrd size>".
 
-config HAVE_TEXT_BASE
-	bool
-	depends on !NIOS2 && !XTENSA
-	depends on !EFI_APP
-	default y
-
-config TEXT_BASE
-	depends on HAVE_TEXT_BASE
-	default 0x0 if POSITION_INDEPENDENT
-	default 0x80800000 if ARCH_OMAP2PLUS || ARCH_K3
-	default 0x81700000 if MACH_SUNIV
-	default 0x2a000000 if MACH_SUN9I
-	default 0x4a000000 if SUNXI_MINIMUM_DRAM_MB >= 256
-	default 0x42e00000 if SUNXI_MINIMUM_DRAM_MB >= 64
-	hex "Text Base"
-	help
-	  The address in memory that U-Boot will be running from, initially.
-
-config HAVE_SYS_MONITOR_BASE
-	bool
-	depends on ARC || MIPS || M68K || NIOS2 || PPC || XTENSA || X86 \
-		|| ENV_IS_IN_FLASH || MTD_NOR_FLASH
-	depends on !EFI_APP
-	default y
-
-config SYS_MONITOR_BASE
-	depends on HAVE_SYS_MONITOR_BASE
-	hex "Physical start address of boot monitor code"
-	default TEXT_BASE
-	help
-	  The physical start address of boot monitor code (which is the same as
-	  CONFIG_TEXT_BASE when linking) and the same as CFG_SYS_FLASH_BASE
-	  when booting from flash.
-
-config SPL_SYS_MONITOR_BASE
-	depends on MPC85xx && SPL && HAVE_SYS_MONITOR_BASE
-	hex "Physical start address of SPL monitor code"
-	default SPL_TEXT_BASE
-
-config TPL_SYS_MONITOR_BASE
-	depends on MPC85xx && TPL && HAVE_SYS_MONITOR_BASE
-	hex "Physical start address of TPL monitor code"
-
-config DYNAMIC_SYS_CLK_FREQ
-	bool "Determine CPU clock frequency at run-time"
-	help
-	  Implement a get_board_sys_clk function that will determine the CPU
-	  clock frequency at run time, rather than define it statically.
-
-config SYS_CLK_FREQ
-	depends on !DYNAMIC_SYS_CLK_FREQ
-	int "CPU clock frequency"
-	default 125000000 if ARCH_LS1012A
-	default 100000000 if ARCH_P2020 || ARCH_T1024 || ARCH_T1042 || \
-			     ARCH_LS1021A || FSL_LSCH2 || FSL_LSCH3
-	default 66666666 if ARCH_P1010 || ARCH_P1020 || ARCH_T4240
-	default 66660000 if ARCH_T2080
-	default 33333333 if RCAR_GEN3
-	default 24000000 if ARCH_EXYNOS
-	default 20000000 if RCAR_GEN2
-	default 0
-	help
-	  A static value for the CPU frequency.  Note that if not required
-	  for a given SoC, this can be left at 0.
-
 config ARCH_FIXUP_FDT_MEMORY
 	bool "Enable arch_fixup_memory_banks() call"
 	default y
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

