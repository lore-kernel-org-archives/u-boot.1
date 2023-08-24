Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1653EC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93D9986AAF;
	Thu, 24 Aug 2023 21:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Okt7jUlF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC1A386A60; Thu, 24 Aug 2023 21:59:47 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82946868BB
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7927f36120cso1607839f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907183; x=1693511983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLC5TVhl2JkQsRDhsB9RbVp3cCJulKRJsnL7saf+eQw=;
 b=Okt7jUlFpL+9B9yML47iDXJxp5oyzdbnYN4DBEkwyG/xkYjmaBeN+yz5XcC87wT9b6
 funDGx2oPiKtLnNPseDruRwvO7Fipf2uNr8g+JO6IhJsx782mIGhsK2+86hpVFLEzGI+
 26Fnm6TCjuHrKQ4kBMSOFWd62mpLv+5q9yXZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907183; x=1693511983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qLC5TVhl2JkQsRDhsB9RbVp3cCJulKRJsnL7saf+eQw=;
 b=URWuvec+RaTolFhqGmkM646vF476SKG+jR+IiFuXdkHXRs2m/bc9kgRh0EwNJ6n4O9
 shJ63lZun/d59pcQhx9e7ASGSW2fhM13P2FKU/Kyzr0fFc8H8QrPhr8Ox1MrhV5fLaP3
 qxH12B78RSBdf118HLwRmDlwnxXloicL1R3Os5qD7o5rvO5U1NcsmiWyomSU5g+Z8jvn
 Nsn6U3PhhwueK6azANznxwDoEXVnDUolLgXVvNzo+1XRFYiy3KvI4x32gTWsuCXeI+IV
 OOf8EAsamx+qq/K9XSjb+Jo0MzRa2teemaYn6eyBMy6BrbmWY5lGmxHBG+7nqhlQMptE
 ViVw==
X-Gm-Message-State: AOJu0YwqsCuozvVhJt1FFLVOC0J0hdvefOHguF2O+ZmVaGUyXRF9Y2al
 oy2cY47+hs9tWVFddvKSwNIMpfx3H6oHO4coTws=
X-Google-Smtp-Source: AGHT+IEHIOUonOpDa/Pgn/Beo2ekpiw1JeE9CyvWWf/d/tgkG5nMzV3NZcg5HzXjP/27vY6Vy1b2pA==
X-Received: by 2002:a05:6602:22d0:b0:787:40a:56b3 with SMTP id
 e16-20020a05660222d000b00787040a56b3mr7733706ioe.12.1692907183162; 
 Thu, 24 Aug 2023 12:59:43 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Hai Pham <hai.pham.ud@renesas.com>, Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH 16/19] Kconfig: Move TEXT_BASE et al under general setup
Date: Thu, 24 Aug 2023 13:59:07 -0600
Message-ID: <20230824195917.1687886-17-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195917.1687886-1-sjg@chromium.org>
References: <20230824195917.1687886-1-sjg@chromium.org>
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
index 8343eba10531..02b33323d726 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -690,71 +690,6 @@ config SUPPORT_RAW_INITRD
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
2.42.0.rc1.204.g551eb34607-goog

