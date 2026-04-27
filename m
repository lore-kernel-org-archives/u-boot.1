Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75451FF885D
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 01:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9430D83693;
	Mon, 27 Apr 2026 03:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Rk0C3oMQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="l5urSnEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 344E7839D9; Mon, 27 Apr 2026 03:11:23 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18F1C80077
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 03:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g3lrR4l62z9v8T;
 Mon, 27 Apr 2026 03:11:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777252279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LEoCDBmEORqz9bCIdiV0T8r35sk9YrfUY1J8+qQscmo=;
 b=Rk0C3oMQJ/r3LoHBnfnEQbbDIYaEWXRnlOWTyjEGRWyKF+gXwcCfm9I1x0Ghf+r4FJuB8r
 4FJeOiniky8DGK1BiMPfvKrCc8RSUr+PsBHmJhHvyBwpKd//BBxA8E8IVb5S+qsMENkzPq
 DxJHE8SOpZqdYxbc1n6YRQhE4w5kpJQqH5o9IPiZCgGCsLiEpNm1QJN1XX+pUBogQffT27
 wHBlSIY+ZHclhsLEGPq42bpjzXozOAFf4y9q6UT2Wlqb2yvXtmPn5rcP0BIEITBTGu9+UB
 W95joylg9MCIRaTLv6ktFzqndKf11Kfp/wkbh8sfgXkqaY/kyeTVXGOSqLDjjQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777252278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LEoCDBmEORqz9bCIdiV0T8r35sk9YrfUY1J8+qQscmo=;
 b=l5urSnEfJdejTc/DKSGCaA5wg327GQgyphmP6MWwh5W+xxavZwmnCOnFjJR/IcxMXYqDBy
 2a/I3PE4eQynpBUeJY2vTHizByADgAn1P+s+21rDUFZvCqJZ9HpBREw6kDkqDZwg8J8hYh
 cZVKgRRXpIje2Q+IuqhTZ2x2bxjbxes9u2C3ekldDmEdVPOkpuQwhpXqzhdjLxPYqAtMIJ
 2roYK/gL5HoF2D6yp851GU0RvyrHXPjHbXfUNVcShKvzx8Q5cKZlfbugD3+NtquRU3ND6R
 ZuSltUfcQZB7XHvEuwtGe5XlRpgelnzR4rAGUsSPNJD0dzhgDjTYo35J+XLXQQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anshul Dalal <anshuld@ti.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v3] arm64: renesas: Add Cortex-M33 build option to R-Car Gen5
Date: Mon, 27 Apr 2026 03:10:15 +0200
Message-ID: <20260427011113.259065-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: j3fzjj5x5e37st8tjcw1x7ba9jzptnqb
X-MBO-RS-ID: db53440ad4928504d48
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

The R-Car Gen5 SoCs contains Cortex-M33, Cortex-R52 and Cortex-A720AE
cores. Add U-Boot build options for the Cortex-M33 core.

Since the Cortex-M33 core is a 32bit core, select V8M and ARM64 for
RCAR64 accordingly. Select TMU timer on the 32bit core, where it is
used instead of the ARMv8 timer. Adjust TMU timer base address to match
the address map of the Cortex-M33 core. Disable unused OF_BOARD_SETUP
as well as unavailable POSITION_INDEPENDENT configuration options.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jesse Taube <mr.bossman075@gmail.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: u-boot@lists.denx.de
---
V2: - Move Kconfig defaults from common to Kconfig.rcar5
    - Rename RCAR_64_CM to RCAR_64_RSIP
    - Select TMU_TIMER in RCAR_64_RSIP
    - Add R-Car Gen5 into RCAR_64 code comment
V3: - Update RCAR_64 code comment
    - Select TMU in RCAR_64_RSIP
---
 arch/arm/mach-renesas/Kconfig                       | 12 ++++++++----
 arch/arm/mach-renesas/Kconfig.rcar5                 | 11 +++++++++++
 arch/arm/mach-renesas/include/mach/rcar-gen5-base.h |  6 ++++++
 include/configs/rcar-gen5-common.h                  |  6 ++++++
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/Kconfig
index fa4e312a4dd..f86acc31039 100644
--- a/arch/arm/mach-renesas/Kconfig
+++ b/arch/arm/mach-renesas/Kconfig
@@ -1,15 +1,19 @@
 if ARCH_RENESAS
 
-# Renesas ARM SoCs R-Car Gen3/Gen4 (64bit)
+config TMU_TIMER
+	bool
+
+# Renesas ARM SoCs R-Car Gen3/Gen4/Gen5 (64bit Cortex-A / 32bit Cortex-M/R)
 config RCAR_64
 	bool
-	select ARM64
+	select CPU_V8M if RCAR_64_RSIP
+	select ARM64 if !RCAR_64_RSIP
 	select CMD_CACHE
-	select OF_BOARD_SETUP
+	select OF_BOARD_SETUP if !RCAR_64_RSIP
 	select PHY
 	select PINCONF
 	select PINCTRL
-	select POSITION_INDEPENDENT
+	select POSITION_INDEPENDENT if !RCAR_64_RSIP
 	imply CMD_FS_UUID
 	imply CMD_GPT
 	imply CMD_MMC_SWRITE if MMC
diff --git a/arch/arm/mach-renesas/Kconfig.rcar5 b/arch/arm/mach-renesas/Kconfig.rcar5
index 528fc5aecc9..0e0e43c08e4 100644
--- a/arch/arm/mach-renesas/Kconfig.rcar5
+++ b/arch/arm/mach-renesas/Kconfig.rcar5
@@ -1,5 +1,13 @@
 if RCAR_GEN5
 
+config RCAR_64_RSIP
+	bool "Renesas ARM SoCs R-Car Gen5 (use Cortex-M33 RSIP)"
+	select SKIP_RELOCATE_CODE
+	select TMU_TIMER
+	help
+	  Build U-Boot for the Cortex-M33 RSIP core present on selected SoC.
+	  The default is n, meaning U-Boot is built for the Cortex-A core.
+
 menu "Select Target SoC"
 
 config R8A78000
@@ -23,4 +31,7 @@ endchoice
 
 source "board/renesas/ironhide/Kconfig"
 
+config SKIP_RELOCATE_CODE_DATA_OFFSET
+	default 0xa0000000 if RCAR_64_RSIP
+
 endif
diff --git a/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h b/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
index f9af3ef885a..35b0d00e45c 100644
--- a/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
+++ b/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
@@ -9,7 +9,13 @@
 /*
  * R-Car (R8A78000) I/O Addresses
  */
+#if defined(CONFIG_RCAR_64_RSIP)
+/* Cortex-M33 address */
+#define TMU_BASE		0xC0680000
+#else
+/* Cortex-A720AE address */
 #define TMU_BASE		0x1C030000
+#endif
 
 /* Arm Generic Timer */
 #define CNTCR_BASE		0x1C000FFF /* Region 0 */
diff --git a/include/configs/rcar-gen5-common.h b/include/configs/rcar-gen5-common.h
index dc28d07c7f9..81b5e2aa5bb 100644
--- a/include/configs/rcar-gen5-common.h
+++ b/include/configs/rcar-gen5-common.h
@@ -17,6 +17,12 @@
 #define CFG_SYS_SDRAM_SIZE		(0x80000000u - DRAM_RSV_SIZE)
 #define CFG_MAX_MEM_MAPPED		(0x80000000u - DRAM_RSV_SIZE)
 
+/* Timer */
+#if defined(CONFIG_RCAR_64_RSIP)
+#define CFG_SYS_TIMER_COUNTER		(TMU_BASE + 0xc)	/* TCNT0 */
+#define CFG_SYS_TIMER_RATE		(133333333 / 4)
+#endif
+
 /* Environment setting */
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"bootm_size=0x10000000\0"
-- 
2.53.0

