Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB31EEAA59
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC12E870CC;
	Thu, 14 Sep 2023 18:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ex/m1eJf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1FFC8709C; Thu, 14 Sep 2023 18:56:50 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0570870D0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-34e12396f6fso3660685ab.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710607; x=1695315407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9ajpF/UmgFnMEzfs1NWX2nkWPdWGLIgC46IT+yL0kQ=;
 b=Ex/m1eJfW0ZJHQ3YgfpuxMnzc7VR2h1pat4J1Q26flkuoYU/9ky4Nov4xVPMMaVt7j
 Cz6N/A4Ai6CV8YXRjgZ+/f2AuwtVRE5yrmlSr3Tn55VkxXIDusaIEkc5jU3c85hSh4BZ
 WBgae7yoHBUjLA3LEqexp0xfPx29EmsbSdtoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710607; x=1695315407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z9ajpF/UmgFnMEzfs1NWX2nkWPdWGLIgC46IT+yL0kQ=;
 b=Amr/f7l1/REKtelRGcUCeumdGjBaUadeklrJQeSxSQBDS392z0QhA94ajSJPwMf8kz
 9PzeZES9fw95dXDqr5F8AtdggMWL527G6KwS7ByF8GWFNXCXOrsbWDg2iXVlRMD+Cjf3
 c48qk0SDzs2YAoLgkkBZtoNkb0L8r867r+uvAMOt8MBSKoKj760cCpa13skByCt+6k8N
 eVSA56Dfnp2fdVIhVNP/6UUlZ5VheMChrDcSNzQVBVEt6rOKjAUmNxHfyBR2fr68/g+q
 OnPa5bSKTmh2mVJghfcQAfIozgzLdkZHuYXBU2mLU9gJeHhWwd956Pc5QlcI253r6kWp
 gcxA==
X-Gm-Message-State: AOJu0YyNMreU4IAXPqs1WbrHcYjLhsBCS0tUFDC/ZR4ZaSxNJmYTkQea
 W4Vz7kxk+t0GvtJeQ+SIxfbS8yPkfv6F1hX/fEo=
X-Google-Smtp-Source: AGHT+IGJNveDx41NzOPdKJSZFakxTdsjL7vWCaSqETLt7+SvajI6W0Ilqsh+DzMisW6eEY3Q8MbFyw==
X-Received: by 2002:a05:6e02:1bc1:b0:34e:2be5:5ffd with SMTP id
 x1-20020a056e021bc100b0034e2be55ffdmr7779392ilv.11.1694710607474; 
 Thu, 14 Sep 2023 09:56:47 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hai Pham <hai.pham.ud@renesas.com>, Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v5 16/21] Kconfig: Move TEXT_BASE et al under general setup
Date: Thu, 14 Sep 2023 10:55:54 -0600
Message-ID: <20230914165615.1058529-16-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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
index 0a2e97578df..2d4b8214986 100644
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
index a885fea692f..4ebcf310911 100644
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
2.42.0.459.ge4e396fd5e-goog

