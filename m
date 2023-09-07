Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD72EC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFF6B86B2F;
	Thu,  7 Sep 2023 17:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fl/fo4oS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 834C086A82; Thu,  7 Sep 2023 17:59:58 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0105486A4B
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-794d98181f0so47850839f.2
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102393; x=1694707193; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUBEFc53V+gFjfqalNUOZTh7jSvvX+1ccHeHgcCDIsA=;
 b=fl/fo4oSMySe7fYLNgWH452tLn+oLpuZNNhgW5Cum6LMDFAZTwqdanNRxad247GM/m
 +KAIaU0fDHALwfJhHNRDUR4zXZ6Y91PcsT0mXPw1WmCz6P+mkW0J7CGUqNz40dxyPd26
 wtgtl+Qlv5EAnP64KEAHJ/fkXNuD1b05+halQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102393; x=1694707193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EUBEFc53V+gFjfqalNUOZTh7jSvvX+1ccHeHgcCDIsA=;
 b=cgiepFMxkjCxWGugPTzqqfk4ALRE/49vX5JJHVP+kN76/SoJGfPvRQp0M1DwJo4Maa
 e355h5Mts/c2B7SscLwBewx43guwL2ELKIvrMIT6wx5WyOlHUnnVlcCwGM2Ub7wso1cL
 JW4oZaOVvTJ2oMCAoyHnLZYbCxeGL7neD2Z4wWbtd6j2osIP+8F/gWPShgOmpAcqe+WF
 wfZHBLB1m0alAaK0NPpcc8c3S7SvwdrWGI2eUTq0g6jdUW7YDRoQytBIZahJdRQ50VRg
 5HHiAppe34O28vMVMVNULogaUAyktwSar1HnYbjpw2P5paSII1u9xvDTFyw5iaHtJihZ
 j/kA==
X-Gm-Message-State: AOJu0YyRhr23a1GivQGOqVxx3zyPNBPH8wf+J9Z0bWFcj/2J12BBsdLx
 PBPz6OCKKeEzRBedcm5ZJ+QOyrvnCb4O4ttT1/c=
X-Google-Smtp-Source: AGHT+IGg3IDN7xM6i/WI9Jxq6KYqBJ18+4CMqtrwdRjOyXvR9Cyz+n/cKIUVHBewgvF41kCNReQUzw==
X-Received: by 2002:a92:c26f:0:b0:34b:ba9f:679c with SMTP id
 h15-20020a92c26f000000b0034bba9f679cmr115032ild.16.1694102393533; 
 Thu, 07 Sep 2023 08:59:53 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 17/22] Kconfig: Move TEXT_BASE et al under general setup
Date: Thu,  7 Sep 2023 09:59:22 -0600
Message-ID: <20230907155933.48511-18-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155933.48511-1-sjg@chromium.org>
References: <20230907155933.48511-1-sjg@chromium.org>
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
index a885fea692f6..4ebcf3109113 100644
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
2.42.0.283.g2d96d420d3-goog

