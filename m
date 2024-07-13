Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCFDC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4317A88877;
	Sat, 13 Jul 2024 15:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ERfUNkfi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eiqzaYjQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A77088875; Sat, 13 Jul 2024 15:21:27 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31B84887E3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WLpyD6sC4z9spD;
 Sat, 13 Jul 2024 15:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ALMgM5yryIVvl2wySQP5cWfScbSCVgpGp6zK/hMn0Zs=;
 b=ERfUNkfikatOxSgJiJQCuW7clS9lugqTgUfFl8pQPgR9/M2Q1MPnDq73Xk4cp9nMTZX/o0
 mgsdiag6jjdMz4cZCepbzGlV7pm4BFyrzAP66F9623KP1BIVbiJWAc9Zwl67Cf4ls14xsn
 b8fwxwUVG/X8zD9w9rnGu2PKnf8PsLy1kGqRdzmXHKbrjG47/SlGefpPvqZgtb00GTUf3s
 nKcJ0386Ou7IwMCYEv/rfcjlFOit8P6pz/55vx4tgsF4zMAw8Z+sAu56PKV6YISAcN5xbY
 t2hw+tOjk2FKTaBEHgo7tZiutC9DZmrwORVcPzcovC5z8SeG/ECpP2/4oL1FLg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ALMgM5yryIVvl2wySQP5cWfScbSCVgpGp6zK/hMn0Zs=;
 b=eiqzaYjQS8BGBwD8gxzbQz+CQDJdkxT3CsUCV0vomywxbEKHLMhrkpCHPdXNY/yDJLvnWP
 Qk3RRtxGYO1P/Tj7MzRSHq1+MUzyk9BJgUarhFru0VMXeG+H1WGlp/Xtl2zLxi24YGNhcq
 bWD8lMaKP7Og6/LnvpHSY7+wqlrgr20/tIx+nuE++tAkQo5kq5onFeyrc5/IwBPEY9c7/u
 zzGEAasdv9kjE4UDMrZMIcVYdCffGByWY56n56fcxbfp9vVpgNgDKv0sdxflfr73x62Gba
 1Jniv2J8CRLh718iXAqc0FQcvhXLCRAbi1cCIv7wyTZuX74EjXdQDklkpPu1EA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/45] arm: mach: exynos: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:08 +0200
Message-ID: <20240713132021.57650-17-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1d8e362a7cd6af927e1
X-MBO-RS-META: 3eox3y8zys7k7t8qwfy1pu966u3byu4w
X-Rspamd-Queue-Id: 4WLpyD6sC4z9spD
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-exynos/common_setup.h         | 1 -
 arch/arm/mach-exynos/exynos4_setup.h        | 2 --
 arch/arm/mach-exynos/exynos5_setup.h        | 4 ----
 arch/arm/mach-exynos/include/mach/cpu.h     | 1 -
 arch/arm/mach-exynos/include/mach/dp_info.h | 1 -
 arch/arm/mach-exynos/include/mach/power.h   | 1 -
 arch/arm/mach-exynos/include/mach/sound.h   | 1 -
 arch/arm/mach-exynos/pinmux.c               | 1 -
 arch/arm/mach-exynos/power.c                | 2 --
 arch/arm/mach-s5pc1xx/include/mach/cpu.h    | 1 -
 10 files changed, 15 deletions(-)

diff --git a/arch/arm/mach-exynos/common_setup.h b/arch/arm/mach-exynos/common_setup.h
index 4f56160ee50..a3fc7d9fbeb 100644
--- a/arch/arm/mach-exynos/common_setup.h
+++ b/arch/arm/mach-exynos/common_setup.h
@@ -61,7 +61,6 @@ enum l2_cache_params {
 	CACHE_ENABLE_FORCE_L2_LOGIC = (1 << 27)
 };
 
-
 #if !defined(CONFIG_SYS_L2CACHE_OFF) && defined(CONFIG_EXYNOS5420)
 /*
  * Configure L2CTLR to get timings that keep us from hanging/crashing.
diff --git a/arch/arm/mach-exynos/exynos4_setup.h b/arch/arm/mach-exynos/exynos4_setup.h
index 23c9011fbc6..1a287a4ef6a 100644
--- a/arch/arm/mach-exynos/exynos4_setup.h
+++ b/arch/arm/mach-exynos/exynos4_setup.h
@@ -284,7 +284,6 @@
 #define MFC_0_SEL		MFC_SEL_MPLL
 #define CLK_SRC_MFC_VAL		((MFC_SEL << 8) | (MFC_0_SEL))
 
-
 /* CLK_DIV_MFC */
 #define MFC_RATIO		3
 #define CLK_DIV_MFC_VAL		(MFC_RATIO)
@@ -498,7 +497,6 @@ struct mem_timings {
 				| ADD_LAT_PALL | MEM_TYPE_DDR3 | MEM_WIDTH_32\
 				| NUM_CHIP_2 | BL_8)
 
-
 #define CHIP_BANK_8		(0x3 << 0)
 #define CHIP_ROW_14		(0x2 << 4)
 #define CHIP_COL_10		(0x3 << 8)
diff --git a/arch/arm/mach-exynos/exynos5_setup.h b/arch/arm/mach-exynos/exynos5_setup.h
index 4e508edba0c..6fa80221c8d 100644
--- a/arch/arm/mach-exynos/exynos5_setup.h
+++ b/arch/arm/mach-exynos/exynos5_setup.h
@@ -685,7 +685,6 @@
 #define PWM_RATIO		8
 #define CLK_DIV_PERIC3_VAL	(PWM_RATIO << 0)
 
-
 /* CLK_DIV_PERIC4 */
 #define CLK_DIV_PERIC4_VAL	NOT_AVAILABLE
 
@@ -710,7 +709,6 @@
 /* MPLL_CON1 */
 #define MPLL_CON1_VAL   (0x0020F300)
 
-
 /* CPLL_CON1 */
 #define CPLL_CON1_VAL	0x0020f300
 
@@ -720,7 +718,6 @@
 /* GPLL_CON1 */
 #define GPLL_CON1_VAL	(NOT_AVAILABLE)
 
-
 /* EPLL_CON1, CON2 */
 #define EPLL_CON1_VAL	0x00000000
 #define EPLL_CON2_VAL	0x00000080
@@ -750,7 +747,6 @@
 #define CLK_DIV_ISP0_VAL	0x13131300
 #define CLK_DIV_ISP1_VAL	0xbb110202
 
-
 /* CLK_FSYS */
 #define CLK_SRC_FSYS0_VAL              0x33033300
 #define CLK_DIV_FSYS0_VAL	       0x0
diff --git a/arch/arm/mach-exynos/include/mach/cpu.h b/arch/arm/mach-exynos/include/mach/cpu.h
index dab148e3320..cf4580be189 100644
--- a/arch/arm/mach-exynos/include/mach/cpu.h
+++ b/arch/arm/mach-exynos/include/mach/cpu.h
@@ -190,7 +190,6 @@
 #define EXYNOS5420_MODEM_BASE		DEVICE_NOT_AVAILABLE
 #define EXYNOS5420_USB_HOST_XHCI_BASE	DEVICE_NOT_AVAILABLE
 
-
 #ifndef __ASSEMBLY__
 #include <asm/io.h>
 /* CPU detection macros */
diff --git a/arch/arm/mach-exynos/include/mach/dp_info.h b/arch/arm/mach-exynos/include/mach/dp_info.h
index 3226eb95f01..a7f7667afd6 100644
--- a/arch/arm/mach-exynos/include/mach/dp_info.h
+++ b/arch/arm/mach-exynos/include/mach/dp_info.h
@@ -183,7 +183,6 @@ enum {
 	VIDEO_TIMING_FROM_REGISTER
 };
 
-
 struct exynos_dp_platform_data {
 	struct exynos_dp_priv *edp_dev_info;
 };
diff --git a/arch/arm/mach-exynos/include/mach/power.h b/arch/arm/mach-exynos/include/mach/power.h
index 757e1586bde..32534116cf8 100644
--- a/arch/arm/mach-exynos/include/mach/power.h
+++ b/arch/arm/mach-exynos/include/mach/power.h
@@ -1752,7 +1752,6 @@ void set_xclkout(void);
  */
 uint32_t get_reset_status(void);
 
-
 /* Read the resume function and call it */
 void power_exit_wakeup(void);
 
diff --git a/arch/arm/mach-exynos/include/mach/sound.h b/arch/arm/mach-exynos/include/mach/sound.h
index 1a40e35f0b5..9672e977f07 100644
--- a/arch/arm/mach-exynos/include/mach/sound.h
+++ b/arch/arm/mach-exynos/include/mach/sound.h
@@ -4,7 +4,6 @@
  * Rajeshwari Shinde <rajeshwari.s@samsung.com>
  */
 
-
 #ifndef __SOUND_ARCH_H__
 #define __SOUND_ARCH_H__
 
diff --git a/arch/arm/mach-exynos/pinmux.c b/arch/arm/mach-exynos/pinmux.c
index 4061dd4aafa..07d19fd17ba 100644
--- a/arch/arm/mach-exynos/pinmux.c
+++ b/arch/arm/mach-exynos/pinmux.c
@@ -391,7 +391,6 @@ static void exynos5420_i2s_config(int peripheral)
 	}
 }
 
-
 void exynos5_spi_config(int peripheral)
 {
 	int cfg = 0, pin = 0, i;
diff --git a/arch/arm/mach-exynos/power.c b/arch/arm/mach-exynos/power.c
index 599d3ccff60..1b61da6dc1a 100644
--- a/arch/arm/mach-exynos/power.c
+++ b/arch/arm/mach-exynos/power.c
@@ -20,7 +20,6 @@ static void exynos4_mipi_phy_control(unsigned int dev_index,
 	else
 		addr = (unsigned int)&pmu->mipi_phy1_control;
 
-
 	cfg = readl(addr);
 	if (enable)
 		cfg |= (EXYNOS_MIPI_PHY_MRESETN | EXYNOS_MIPI_PHY_ENABLE);
@@ -174,7 +173,6 @@ void set_ps_hold_ctrl(void)
 		exynos5_set_ps_hold_ctrl();
 }
 
-
 static void exynos5_set_xclkout(void)
 {
 	struct exynos5_power *power =
diff --git a/arch/arm/mach-s5pc1xx/include/mach/cpu.h b/arch/arm/mach-s5pc1xx/include/mach/cpu.h
index 78c905b866b..4b1b7118268 100644
--- a/arch/arm/mach-s5pc1xx/include/mach/cpu.h
+++ b/arch/arm/mach-s5pc1xx/include/mach/cpu.h
@@ -45,7 +45,6 @@
 #define S5PC110_PHY_BASE	0xEC100000
 #define S5PC110_USB_PHY_CONTROL 0xE010E80C
 
-
 #ifndef __ASSEMBLY__
 #include <asm/io.h>
 /* CPU detection macros */
-- 
2.43.0

