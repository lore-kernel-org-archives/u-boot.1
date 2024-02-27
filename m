Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0156C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE1B88053;
	Tue, 27 Feb 2024 17:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NWKM+720";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ItXFNosy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 744A988027; Tue, 27 Feb 2024 17:10:25 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 029BC88045
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TkjBP50F1z9stG;
 Tue, 27 Feb 2024 17:10:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B207M/SSqsLXGBPHqbTWaTjMnIE30/KCPkJpkS1vS/s=;
 b=NWKM+720aTdJAhQ0u8YdlFyp92Wat4o05I3+whQKbM/Ec8PpAlivn51i4OAE7HVJzZUBw0
 ffaS/CunA4sKfRGy5JDAxKBhZ97CrE9XOMu9d4tSAP6H81XGCisfyMvgMBE8BR+WPEEe35
 lRHsLpaekY9VvP+YmuJhefrZ8J4r5re9Jt9uoEOobyyGn3WiGtSZ1z926i52na8+gX+I1f
 rvCmQz73VXLkYvbt63igxAQmyqkyCCTY5gywjCDGAL/kW+urzbkMiVoSYGROoozbkpQygg
 P7OmBVsO98fRxT+90ZLbCe/fJbLlrZhR3Ol772NCdi+5UZBMbcuOAcy1s+fYdg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B207M/SSqsLXGBPHqbTWaTjMnIE30/KCPkJpkS1vS/s=;
 b=ItXFNosyLDgT5IUZ/XxdaBgbj+CURJeJkOkWwGLTAcgAGIGVfhRWC2tFeuh7qUWcP3zW+s
 8Tat3y3fynI1rbdeikzi/ZYOMiZQdBZnLSPLadYIDiNFldq4RYqO+nyK8epE+3V6rVsOW6
 XiWC6FhwUNz4JmGTZ8eKwEw+FE/tBzvs8LGuPThYGvQRUl2mQroZlKjrZruK5dtiZ0+mn9
 1bEa6IF+jaPZP2ayJ1bso7sj7kKipKMcyy1ObR23vr9Wjk0NlNwiOhyIz4rDSK7gq5Fq7h
 etp52U2MrsJ1W+kw5jWYhPcl/w1iPEBnhQXWS5LtKjcmxkAjWpE/a6D89ne39A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/19] ARM: renesas: Rename ARCH_RMOBILE to ARCH_RENESAS
Date: Tue, 27 Feb 2024 17:05:55 +0100
Message-ID: <20240227160912.412181-16-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ywby7qksudxdck5xcq45pijsop1nmj8r
X-MBO-RS-ID: ac987c476cf2627803f
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

Rename ARCH_RMOBILE to ARCH_RENESAS because all the chips are made
by Renesas, while only a subset of them is from the R-Mobile
line.

Use the following command to perform the rename:

"
$ git grep -l 'ARCH_RMOBILE' | xargs -I {} sed -i 's@ARCH_RMOBILE@ARCH_RENESAS@g' {}
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/Kconfig                             |  2 +-
 arch/arm/Makefile                            |  2 +-
 arch/arm/mach-rmobile/Kconfig                |  4 ++--
 arch/arm/mach-rmobile/include/mach/renesas.h | 10 +++++-----
 arch/sh/lib/time.c                           |  2 +-
 configs/alt_defconfig                        |  2 +-
 configs/blanche_defconfig                    |  2 +-
 configs/gose_defconfig                       |  2 +-
 configs/grpeach_defconfig                    |  2 +-
 configs/hihope_rzg2_defconfig                |  2 +-
 configs/koelsch_defconfig                    |  2 +-
 configs/lager_defconfig                      |  2 +-
 configs/porter_defconfig                     |  2 +-
 configs/r8a77970_eagle_defconfig             |  2 +-
 configs/r8a77970_v3msk_defconfig             |  2 +-
 configs/r8a77980_condor_defconfig            |  2 +-
 configs/r8a77980_v3hsk_defconfig             |  2 +-
 configs/r8a77990_ebisu_defconfig             |  2 +-
 configs/r8a77995_draak_defconfig             |  2 +-
 configs/r8a779a0_falcon_defconfig            |  2 +-
 configs/r8a779f0_spider_defconfig            |  2 +-
 configs/r8a779g0_whitehawk_defconfig         |  2 +-
 configs/r8a779h0_grayhawk_defconfig          |  2 +-
 configs/rcar3_salvator-x_defconfig           |  2 +-
 configs/rcar3_ulcb_defconfig                 |  2 +-
 configs/renesas_rzg2l_smarc_defconfig        |  2 +-
 configs/rzg2_beacon_defconfig                |  2 +-
 configs/rzn1_snarc_defconfig                 |  2 +-
 configs/silinux_ek874_defconfig              |  2 +-
 configs/silk_defconfig                       |  2 +-
 configs/stout_defconfig                      |  2 +-
 drivers/clk/renesas/Kconfig                  |  2 +-
 drivers/gpio/Kconfig                         |  2 +-
 drivers/i2c/Kconfig                          |  2 +-
 drivers/mmc/Kconfig                          |  4 ++--
 drivers/mmc/sh_mmcif.h                       |  2 +-
 drivers/pinctrl/Makefile                     |  2 +-
 drivers/pinctrl/renesas/Kconfig              |  4 ++--
 drivers/ram/Makefile                         |  2 +-
 drivers/serial/Kconfig                       |  4 ++--
 drivers/usb/host/Kconfig                     |  2 +-
 41 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fde85dc0d53..dbd7e014245 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1071,7 +1071,7 @@ config ARCH_QEMU
 	imply USB_KEYBOARD
 	imply CMD_USB
 
-config ARCH_RMOBILE
+config ARCH_RENESAS
 	bool "Renesas ARM SoCs"
 	select DM
 	select DM_SERIAL
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5ebe0619d39..d7ca8715a3f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -75,7 +75,7 @@ machine-$(CONFIG_ARCH_NPCM)             += npcm
 machine-$(CONFIG_ARCH_OMAP2PLUS)	+= omap2
 machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
 machine-$(CONFIG_ARCH_OWL)		+= owl
-machine-$(CONFIG_ARCH_RMOBILE)		+= rmobile
+machine-$(CONFIG_ARCH_RENESAS)		+= rmobile
 machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
 machine-$(CONFIG_ARCH_S5PC1XX)		+= s5pc1xx
 machine-$(CONFIG_ARCH_SNAPDRAGON)	+= snapdragon
diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
index 2bb96749fc0..c1db9531a3c 100644
--- a/arch/arm/mach-rmobile/Kconfig
+++ b/arch/arm/mach-rmobile/Kconfig
@@ -1,4 +1,4 @@
-if ARCH_RMOBILE
+if ARCH_RENESAS
 
 # Renesas ARM SoCs R-Car Gen3/Gen4 (64bit)
 config RCAR_64
@@ -88,7 +88,7 @@ config RZG2L
 endchoice
 
 config SYS_SOC
-	default "rmobile" if ARCH_RMOBILE
+	default "rmobile" if ARCH_RENESAS
 
 source "arch/arm/mach-rmobile/Kconfig.32"
 source "arch/arm/mach-rmobile/Kconfig.64"
diff --git a/arch/arm/mach-rmobile/include/mach/renesas.h b/arch/arm/mach-rmobile/include/mach/renesas.h
index 67c480048de..c69c764adb8 100644
--- a/arch/arm/mach-rmobile/include/mach/renesas.h
+++ b/arch/arm/mach-rmobile/include/mach/renesas.h
@@ -1,7 +1,7 @@
-#ifndef __ASM_ARCH_RMOBILE_H
-#define __ASM_ARCH_RMOBILE_H
+#ifndef __ASM_ARCH_RENESAS_H
+#define __ASM_ARCH_RENESAS_H
 
-#if defined(CONFIG_ARCH_RMOBILE)
+#if defined(CONFIG_ARCH_RENESAS)
 #if defined(CONFIG_R8A7790)
 #include <asm/arch/r8a7790.h>
 #elif defined(CONFIG_R8A7791)
@@ -22,7 +22,7 @@
 #else
 #error "SOC Name not defined"
 #endif
-#endif /* CONFIG_ARCH_RMOBILE */
+#endif /* CONFIG_ARCH_RENESAS */
 
 /* PRR CPU IDs */
 #define RENESAS_CPU_TYPE_R8A7740	0x40
@@ -53,4 +53,4 @@ u32 renesas_get_cpu_rev_integer(void);
 u32 renesas_get_cpu_rev_fraction(void);
 #endif /* __ASSEMBLY__ */
 
-#endif /* __ASM_ARCH_RMOBILE_H */
+#endif /* __ASM_ARCH_RENESAS_H */
diff --git a/arch/sh/lib/time.c b/arch/sh/lib/time.c
index 366500d90be..19c8e3ca3e7 100644
--- a/arch/sh/lib/time.c
+++ b/arch/sh/lib/time.c
@@ -16,7 +16,7 @@
 #include <asm/io.h>
 #include <linux/bitops.h>
 
-#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_RMOBILE)
+#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_RENESAS)
 #define TSTR	0x4
 #define TCR0	0x10
 #endif /* CONFIG_CPU_SH4 */
diff --git a/configs/alt_defconfig b/configs/alt_defconfig
index ff2f7d22bbc..e4007ab8f71 100644
--- a/configs/alt_defconfig
+++ b/configs/alt_defconfig
@@ -3,7 +3,7 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
 # CONFIG_SPL_USE_ARCH_MEMCPY is not set
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
diff --git a/configs/blanche_defconfig b/configs/blanche_defconfig
index d8c0f784176..af7622a88af 100644
--- a/configs/blanche_defconfig
+++ b/configs/blanche_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x00000000
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
diff --git a/configs/gose_defconfig b/configs/gose_defconfig
index 6f2a015d3e9..1eadf7c14d3 100644
--- a/configs/gose_defconfig
+++ b/configs/gose_defconfig
@@ -3,7 +3,7 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
 # CONFIG_SPL_USE_ARCH_MEMCPY is not set
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
diff --git a/configs/grpeach_defconfig b/configs/grpeach_defconfig
index 6738424f2e8..eef3bad4e65 100644
--- a/configs/grpeach_defconfig
+++ b/configs/grpeach_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x18000000
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SYS_MALLOC_F_LEN=0x400
diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
index cad490eb240..c2d2e8ebae4 100644
--- a/configs/hihope_rzg2_defconfig
+++ b/configs/hihope_rzg2_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_ENV_SIZE=0x20000
diff --git a/configs/koelsch_defconfig b/configs/koelsch_defconfig
index 37511f8fe9a..963e02d6b54 100644
--- a/configs/koelsch_defconfig
+++ b/configs/koelsch_defconfig
@@ -3,7 +3,7 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
 # CONFIG_SPL_USE_ARCH_MEMCPY is not set
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
diff --git a/configs/lager_defconfig b/configs/lager_defconfig
index 30582bfa3b1..605909e812f 100644
--- a/configs/lager_defconfig
+++ b/configs/lager_defconfig
@@ -3,7 +3,7 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
 # CONFIG_SPL_USE_ARCH_MEMCPY is not set
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
diff --git a/configs/porter_defconfig b/configs/porter_defconfig
index 2f4f03d27f2..021e521745f 100644
--- a/configs/porter_defconfig
+++ b/configs/porter_defconfig
@@ -3,7 +3,7 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
 # CONFIG_SPL_USE_ARCH_MEMCPY is not set
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_defconfig
index 5af9d09d18b..6095825aa77 100644
--- a/configs/r8a77970_eagle_defconfig
+++ b/configs/r8a77970_eagle_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
diff --git a/configs/r8a77970_v3msk_defconfig b/configs/r8a77970_v3msk_defconfig
index 458e4cb1e44..c90efa1e6e8 100644
--- a/configs/r8a77970_v3msk_defconfig
+++ b/configs/r8a77970_v3msk_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
diff --git a/configs/r8a77980_condor_defconfig b/configs/r8a77980_condor_defconfig
index 8d30392ed98..f33dfefcc98 100644
--- a/configs/r8a77980_condor_defconfig
+++ b/configs/r8a77980_condor_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x40000
diff --git a/configs/r8a77980_v3hsk_defconfig b/configs/r8a77980_v3hsk_defconfig
index cb6800ef510..9e304f8d3d8 100644
--- a/configs/r8a77980_v3hsk_defconfig
+++ b/configs/r8a77980_v3hsk_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x40000
diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_defconfig
index 41a789da598..cb3816d4e01 100644
--- a/configs/r8a77990_ebisu_defconfig
+++ b/configs/r8a77990_ebisu_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_defconfig
index f7446b9e621..739ea4618d8 100644
--- a/configs/r8a77995_draak_defconfig
+++ b/configs/r8a77995_draak_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
diff --git a/configs/r8a779a0_falcon_defconfig b/configs/r8a779a0_falcon_defconfig
index f124dea66ce..6ffff2250b3 100644
--- a/configs/r8a779a0_falcon_defconfig
+++ b/configs/r8a779a0_falcon_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_ENV_SIZE=0x40000
diff --git a/configs/r8a779f0_spider_defconfig b/configs/r8a779f0_spider_defconfig
index 2d27dfeaa59..21b488a3f5a 100644
--- a/configs/r8a779f0_spider_defconfig
+++ b/configs/r8a779f0_spider_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xD00000
diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
index 727c33926f0..94f12ad1bde 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
diff --git a/configs/r8a779h0_grayhawk_defconfig b/configs/r8a779h0_grayhawk_defconfig
index 41aa0207086..d295bc899d1 100644
--- a/configs/r8a779h0_grayhawk_defconfig
+++ b/configs/r8a779h0_grayhawk_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index bc03bbc5140..89aa8b537d4 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
index d9f696b2a89..10a8492bb20 100644
--- a/configs/rcar3_ulcb_defconfig
+++ b/configs/rcar3_ulcb_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x20000
diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
index e45579ae6b9..c1dc3d7b89d 100644
--- a/configs/renesas_rzg2l_smarc_defconfig
+++ b/configs/renesas_rzg2l_smarc_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_SYS_INIT_SP_BSS_OFFSET=1048576
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x80000
diff --git a/configs/rzg2_beacon_defconfig b/configs/rzg2_beacon_defconfig
index c7cefb9d1dc..df0a8385b3e 100644
--- a/configs/rzg2_beacon_defconfig
+++ b/configs/rzg2_beacon_defconfig
@@ -1,5 +1,5 @@
 CONFIG_ARM=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
diff --git a/configs/rzn1_snarc_defconfig b/configs/rzn1_snarc_defconfig
index 5c657271355..29a96d1aefe 100644
--- a/configs/rzn1_snarc_defconfig
+++ b/configs/rzn1_snarc_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SYS_ARCH_TIMER=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_SYS_MALLOC_LEN=0xb0000
 CONFIG_SYS_MALLOC_F_LEN=0x800
 CONFIG_NR_DRAM_BANKS=1
diff --git a/configs/silinux_ek874_defconfig b/configs/silinux_ek874_defconfig
index e74fbb892c8..000bc261732 100644
--- a/configs/silinux_ek874_defconfig
+++ b/configs/silinux_ek874_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
diff --git a/configs/silk_defconfig b/configs/silk_defconfig
index e0ed90fa7e1..939ccc9c478 100644
--- a/configs/silk_defconfig
+++ b/configs/silk_defconfig
@@ -3,7 +3,7 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
 # CONFIG_SPL_USE_ARCH_MEMCPY is not set
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
diff --git a/configs/stout_defconfig b/configs/stout_defconfig
index 9f5c61d0e1d..1022ee9e71a 100644
--- a/configs/stout_defconfig
+++ b/configs/stout_defconfig
@@ -3,7 +3,7 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
 # CONFIG_SPL_USE_ARCH_MEMCPY is not set
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
-CONFIG_ARCH_RMOBILE=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index e9296ed9fe2..a093027eb0e 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -1,6 +1,6 @@
 config CLK_RENESAS
 	bool "Renesas clock drivers"
-	depends on CLK && ARCH_RMOBILE
+	depends on CLK && ARCH_RENESAS
 	help
 	  Enable support for clock present on Renesas SoCs.
 
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 27df5d88d40..2df3dc42d0f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -333,7 +333,7 @@ config PCF8575_GPIO
 
 config RCAR_GPIO
 	bool "Renesas RCar GPIO driver"
-	depends on DM_GPIO && ARCH_RMOBILE
+	depends on DM_GPIO && ARCH_RENESAS
 	help
 	  This driver supports the GPIO banks on Renesas RCar SoCs.
 
diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 4f42200f392..5f919f201b3 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -544,7 +544,7 @@ config SPL_SYS_I2C_SANDBOX
 
 config SYS_I2C_SH
 	bool "Legacy SuperH I2C interface"
-	depends on ARCH_RMOBILE && SYS_I2C_LEGACY
+	depends on ARCH_RENESAS && SYS_I2C_LEGACY
 	help
 	  Enable the legacy SuperH I2C interface.
 
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 17618c3bdcc..cef05790dd9 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -393,7 +393,7 @@ config HSMMC2_8BIT
 
 config SH_MMCIF
 	bool "SuperH/Renesas ARM SoCs on-chip MMCIF host controller support"
-	depends on ARCH_RMOBILE || SH
+	depends on ARCH_RENESAS || SH
 	help
 	  Support for the on-chip MMCIF host controller on SuperH/Renesas ARM SoCs platform
 
@@ -408,7 +408,7 @@ config MMC_UNIPHIER
 
 config RENESAS_SDHI
 	bool "Renesas R-Car SD/MMC Host Controller support"
-	depends on ARCH_RMOBILE
+	depends on ARCH_RENESAS
 	depends on BLK && DM_MMC
 	depends on OF_CONTROL
 	select BOUNCE_BUFFER
diff --git a/drivers/mmc/sh_mmcif.h b/drivers/mmc/sh_mmcif.h
index 66341e51d26..b131b8c2833 100644
--- a/drivers/mmc/sh_mmcif.h
+++ b/drivers/mmc/sh_mmcif.h
@@ -195,7 +195,7 @@ struct sh_mmcif_regs {
 #define SOFT_RST_OFF		(0 << 31)
 
 #define CLKDEV_EMMC_DATA	52000000	/* 52MHz */
-#ifdef CONFIG_ARCH_RMOBILE
+#ifdef CONFIG_ARCH_RENESAS
 #define MMC_CLK_DIV_MIN(clk)	(clk / (1 << 9))
 #define MMC_CLK_DIV_MAX(clk)	(clk / (1 << 1))
 #else
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 0e929d8ca04..6d7b7cd9051 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_PINCTRL_INTEL) += intel/
 obj-$(CONFIG_ARCH_MTMIPS) += mtmips/
 obj-$(CONFIG_ARCH_NPCM)         += nuvoton/
 obj-$(CONFIG_PINCTRL_QCOM) += qcom/
-obj-$(CONFIG_ARCH_RMOBILE) += renesas/
+obj-$(CONFIG_ARCH_RENESAS) += renesas/
 obj-$(CONFIG_ARCH_RZN1) += renesas/
 obj-$(CONFIG_PINCTRL_SANDBOX)	+= pinctrl-sandbox.o
 obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 171cd374b81..57e88604aa2 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -1,8 +1,8 @@
-if ARCH_RMOBILE
+if ARCH_RENESAS
 
 config PINCTRL_PFC
 	bool "Renesas pin control drivers"
-	depends on DM && ARCH_RMOBILE
+	depends on DM && ARCH_RENESAS
 	default n if CPU_RZA1
 	help
 	  Support pin multiplexing control on Renesas SoCs.
diff --git a/drivers/ram/Makefile b/drivers/ram/Makefile
index 985990ab5ac..c9c46cc17a8 100644
--- a/drivers/ram/Makefile
+++ b/drivers/ram/Makefile
@@ -28,5 +28,5 @@ obj-$(CONFIG_DRAM_SUN20I_D1) += sunxi/
 
 obj-$(CONFIG_ARCH_OCTEON) += octeon/
 
-obj-$(CONFIG_ARCH_RMOBILE) += renesas/
+obj-$(CONFIG_ARCH_RENESAS) += renesas/
 obj-$(CONFIG_CADENCE_DDR_CTRL) += cadence/
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 26460c4e0ca..88d678654e7 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -433,7 +433,7 @@ config DEBUG_UART_SEMIHOSTING
 
 config DEBUG_UART_SCIF
 	bool "Renesas SCIF UART"
-	depends on SH || ARCH_RMOBILE
+	depends on SH || ARCH_RENESAS
 	help
 	  Select this to enable a debug UART using the serial_sh driver. You
 	  will need to provide parameters to make this work. The driver will
@@ -893,7 +893,7 @@ config SANDBOX_SERIAL
 
 config SCIF_CONSOLE
 	bool "Renesas SCIF UART support"
-	depends on SH || ARCH_RMOBILE
+	depends on SH || ARCH_RENESAS
 	help
 	  Select this to enable Renesas SCIF UART. To operate serial ports
 	  on systems with RCar or SH SoCs, say Y to this option. If unsure,
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index f96027d7bd2..6e10b629a3c 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -97,7 +97,7 @@ config USB_XHCI_PCI
 config USB_XHCI_RCAR
 	bool "Renesas RCar USB 3.0 support"
 	default y
-	depends on ARCH_RMOBILE
+	depends on ARCH_RENESAS
 	help
 	  Choose this option to add support for USB 3.0 driver on Renesas
 	  RCar Gen3 SoCs.
-- 
2.43.0

