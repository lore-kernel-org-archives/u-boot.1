Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C940C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34F9A88986;
	Wed, 24 Jul 2024 17:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XtIH1Ts1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC29488962; Wed, 24 Jul 2024 17:09:53 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3872E889B7
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-39641271f2aso24699235ab.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833789; x=1722438589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JCdJIh1KBkpwg5C5QqO/2lObq9Q95Hkp+KSH33APUwg=;
 b=XtIH1Ts1OGv59CochMtfWbZ8me3ZQjF0vXgrKcva/vZOqD6V+IjArwIC6Cb44LgWa7
 jRctr0XiP8UMavblOGGxr1xrguYzlOGC9QhsjyfZu8FZ021InAE8fexn/A8fT4+CZ6pK
 2D/qFzKllrzj2EaNvyfC6+CFEciz67GGzMnlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833789; x=1722438589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JCdJIh1KBkpwg5C5QqO/2lObq9Q95Hkp+KSH33APUwg=;
 b=wc1XNIo6C28xvxwqc6FFjDb7NQG8Klv6QgRXRF/kq+lEwapSPkOgmZrBzgEq2WRrW/
 MAI/RCumA0F35FHT1vAnSfSsvXZR5Re5QpsVtxPis2qWmtXEl32Dzf/XloX2UiU1HX/W
 YNcEMLngYn+aXa9FMO/7UnpixpGoXwJZehBi3Qq6liPTRexowOEtDHcM36Vgxdz35+DB
 xtOPTN7gVCEA8XFgXwnX2Ox8yaGFiVDHBWauEcrACWhcBhOdeRUyBWBrT+9XFNkmnXuZ
 k4fdzH+Xx3EbnkUxYZf4aM3NGACRnRxZ90l1K6pnoCBLDr+3hmURu3l6W0L2Q2fQPrj0
 Qatw==
X-Gm-Message-State: AOJu0YzTLd0qNiRBgW69WVEuCs7YmWwjHy1/2cwh57820JuLqEqQlv79
 A71mTo7T35/QE3+OwL5iLpblUD+eV6o3NzvXPV9vvKajh+I4tDm2jHX4z+veaEl4GyhU37Zp3to
 =
X-Google-Smtp-Source: AGHT+IE9ROPAhQfmqF9wVCiN8yXuBwnD1DcWgomTaUiI9ikUcOXioQJsZqZddCjlTVkbZ8HQ3JtZHA==
X-Received: by 2002:a05:6e02:1786:b0:397:75a:39b9 with SMTP id
 e9e14a558f8ab-39a1926862fmr28350385ab.16.1721833788735; 
 Wed, 24 Jul 2024 08:09:48 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH 13/35] global_data: Remove pci_ram_top
Date: Wed, 24 Jul 2024 09:09:00 -0600
Message-Id: <20240724150922.2343249-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

This field is set but not used. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/mach-tegra/board2.c      |  4 ----
 arch/arm/mach-tegra/cboot.c       |  4 ----
 arch/x86/cpu/i386/cpu.c           |  8 --------
 include/asm-generic/global_data.h | 10 ----------
 4 files changed, 26 deletions(-)

diff --git a/arch/arm/mach-tegra/board2.c b/arch/arm/mach-tegra/board2.c
index 479137e457c..7971e3b68d5 100644
--- a/arch/arm/mach-tegra/board2.c
+++ b/arch/arm/mach-tegra/board2.c
@@ -423,10 +423,6 @@ int dram_init_banksize(void)
 	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
 	gd->bd->bi_dram[0].size = usable_ram_size_below_4g();
 
-#ifdef CONFIG_PCI
-	gd->pci_ram_top = gd->bd->bi_dram[0].start + gd->bd->bi_dram[0].size;
-#endif
-
 #ifdef CONFIG_PHYS_64BIT
 	if (gd->ram_size > SZ_2G) {
 		gd->bd->bi_dram[1].start = 0x100000000;
diff --git a/arch/arm/mach-tegra/cboot.c b/arch/arm/mach-tegra/cboot.c
index c12543d71ac..e2342b2aece 100644
--- a/arch/arm/mach-tegra/cboot.c
+++ b/arch/arm/mach-tegra/cboot.c
@@ -189,10 +189,6 @@ int cboot_dram_init_banksize(void)
 		gd->bd->bi_dram[i].size = tegra_mem_map[1 + i].size;
 	}
 
-#ifdef CONFIG_PCI
-	gd->pci_ram_top = ram_top;
-#endif
-
 	return 0;
 }
 
diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index db2727d7485..934e98ac582 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -412,12 +412,6 @@ int cpu_phys_address_size(void)
 	return 32;
 }
 
-/* Don't allow PCI region 3 to use memory in the 2-4GB memory hole */
-static void setup_pci_ram_top(void)
-{
-	gd_set_pci_ram_top(0x80000000U);
-}
-
 static void setup_mtrr(void)
 {
 	u64 mtrr_cap;
@@ -469,7 +463,6 @@ int x86_cpu_init_f(void)
 		setup_cpu_features();
 	setup_identity();
 	setup_mtrr();
-	setup_pci_ram_top();
 
 	/* Set up the i8254 timer if required */
 	if (IS_ENABLED(CONFIG_I8254_TIMER))
@@ -483,7 +476,6 @@ int x86_cpu_reinit_f(void)
 	long addr;
 
 	setup_identity();
-	setup_pci_ram_top();
 	addr = locate_coreboot_table();
 	if (addr >= 0) {
 		gd->arch.coreboot_table = addr;
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index f98d821e085..d014beb2617 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -302,10 +302,6 @@ s	 * @timer: timer instance for Driver Model
 	 * @hose: PCI hose for early use
 	 */
 	struct pci_controller *hose;
-	/**
-	 * @pci_ram_top: top of region accessible to PCI
-	 */
-	phys_addr_t pci_ram_top;
 #endif
 #ifdef CONFIG_PCI_BOOTDELAY
 	/**
@@ -558,12 +554,6 @@ static_assert(sizeof(struct global_data) == GD_SIZE);
 #define gd_set_malloc_start(val)
 #endif
 
-#if CONFIG_IS_ENABLED(PCI)
-#define gd_set_pci_ram_top(val)	gd->pci_ram_top = val
-#else
-#define gd_set_pci_ram_top(val)
-#endif
-
 #if CONFIG_VAL(SYS_MALLOC_F_LEN)
 #define gd_malloc_ptr()		gd->malloc_ptr
 #else
-- 
2.34.1

