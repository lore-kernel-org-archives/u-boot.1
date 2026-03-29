Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FE2FF492B
	for <u-boot@archiver.kernel.org>; Sun, 29 Mar 2026 23:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F0968394E;
	Mon, 30 Mar 2026 01:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="knvuBWjl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="A4LKmWAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A7DE83B48; Mon, 30 Mar 2026 01:24:28 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11C678063E
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 01:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fkVp14G6lz9sNb;
 Mon, 30 Mar 2026 01:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774826665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=I7zzR+L5Z20oUk85qBTXIAfMx0sVouEaf+5XZxYVzow=;
 b=knvuBWjlOh6hSH3VyBPcrZZ9Yijb1x6thXEsPmN3VA/snUTpGY6nZOm0q5i8VO5MPXHq0C
 /ccG1GPzEgc2BjLYz/Uwvozo2L8vlWq+SvEas1IRFEI2a67udf8Rk5lrEcsKPPuRxDvOZ5
 nGXMPznn5b2z2qwYmwspLi/BsoIjCyoFENmGKvsALq5OX0c4QaLTps4pwp/RdPHDJfcWjT
 PzCV90f6AsU2WzH2uTknBEs+2gS28RGqrjLiRxIG7T5Zgad9XZvGvMdmUP+2q4FWkNy9uK
 NOJ8oIyAAesmWe08ssemCRvBxy9EdkyA+jUoNk23s7yCY6FfkGNvnbMrJxmYOA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774826663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=I7zzR+L5Z20oUk85qBTXIAfMx0sVouEaf+5XZxYVzow=;
 b=A4LKmWAZIzbEhg4JM+gL0XhV24NlcMwwm999s0onh0PfflfzvKoKRjqhjbMon8bqtd8Th0
 i2WY4ORcohprKwHWHIlARTMB9lqUUrCGs0msRDdrzgDOdKEtDAmRDg/vOH/geztOdDJHW4
 joZyasPiPU9F4cgS5CxX7qRlh36A/hks1ZfTkAA/WsiIRh6Iu/NZsVHnJvTZk67/nb3mC7
 wAlvr2fMGP7zCorF2nvlsiZZjq6ypWQqILHpGhafg0cOX5SPt84ssy0bBbLKsbG3OmEWSy
 2GyIZPq1cHzbQGvVhHeGiPp9Qg3Q5lWUqSu88RQ2MZIvZWmHAp/OEnNlAF8ZQA==
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
Subject: [PATCH] arm64: renesas: Add Cortex-M33 build option to R-Car Gen5
Date: Mon, 30 Mar 2026 01:23:55 +0200
Message-ID: <20260329232419.352743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7dn58tuurhsdxpryo7gqcxmf7arswkoh
X-MBO-RS-ID: a7bef29c2501b1d7230
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
 Kconfig                                             |  2 ++
 arch/arm/mach-renesas/Kconfig                       | 11 ++++++++---
 arch/arm/mach-renesas/Kconfig.rcar5                 |  7 +++++++
 arch/arm/mach-renesas/include/mach/rcar-gen5-base.h |  6 ++++++
 include/configs/rcar-gen5-common.h                  |  6 ++++++
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Kconfig b/Kconfig
index 0bbdc0cbea6..7033a255675 100644
--- a/Kconfig
+++ b/Kconfig
@@ -476,6 +476,7 @@ config SKIP_RELOCATE
 
 config SKIP_RELOCATE_CODE
 	bool
+	default y if RCAR_64_CM
 	help
 	  Skips relocation of U-Boot code to the end of RAM, but still does
 	  relocate data to the end of RAM. This is mainly meant to relocate
@@ -485,6 +486,7 @@ config SKIP_RELOCATE_CODE
 
 config SKIP_RELOCATE_CODE_DATA_OFFSET
 	hex
+	default 0xa0000000 if RCAR_64_CM
 	default 0x0
 	depends on SKIP_RELOCATE_CODE
 	help
diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/Kconfig
index fa4e312a4dd..3f21755a226 100644
--- a/arch/arm/mach-renesas/Kconfig
+++ b/arch/arm/mach-renesas/Kconfig
@@ -1,15 +1,20 @@
 if ARCH_RENESAS
 
+config TMU_TIMER
+	bool
+
 # Renesas ARM SoCs R-Car Gen3/Gen4 (64bit)
 config RCAR_64
 	bool
-	select ARM64
+	select CPU_V8M if RCAR_64_CM
+	select ARM64 if !RCAR_64_CM
+	select TMU_TIMER if RCAR_64_CM
 	select CMD_CACHE
-	select OF_BOARD_SETUP
+	select OF_BOARD_SETUP if !RCAR_64_CM
 	select PHY
 	select PINCONF
 	select PINCTRL
-	select POSITION_INDEPENDENT
+	select POSITION_INDEPENDENT if !RCAR_64_CM
 	imply CMD_FS_UUID
 	imply CMD_GPT
 	imply CMD_MMC_SWRITE if MMC
diff --git a/arch/arm/mach-renesas/Kconfig.rcar5 b/arch/arm/mach-renesas/Kconfig.rcar5
index 528fc5aecc9..2e6d119a328 100644
--- a/arch/arm/mach-renesas/Kconfig.rcar5
+++ b/arch/arm/mach-renesas/Kconfig.rcar5
@@ -1,5 +1,12 @@
 if RCAR_GEN5
 
+config RCAR_64_CM
+	bool "Renesas ARM SoCs R-Car Gen5 (use Cortex-M33)"
+	default n
+	help
+	  Build U-Boot for the Cortex-M33 core present on selected SoC.
+	  The default is n, meaning U-Boot is built for the Cortex-A core.
+
 menu "Select Target SoC"
 
 config R8A78000
diff --git a/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h b/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
index f9af3ef885a..4cb9a1fbc42 100644
--- a/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
+++ b/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
@@ -9,7 +9,13 @@
 /*
  * R-Car (R8A78000) I/O Addresses
  */
+#if defined(CONFIG_RCAR_64_CM)
+/* Cortex-M33 address */
+#define TMU_BASE		0xC0680000
+#else
+/* Cortex-A720AE address */
 #define TMU_BASE		0x1C030000
+#endif
 
 /* Arm Generic Timer */
 #define CNTCR_BASE		0x1C000FFF /* Region 0 */
diff --git a/include/configs/rcar-gen5-common.h b/include/configs/rcar-gen5-common.h
index dc28d07c7f9..ed775da9087 100644
--- a/include/configs/rcar-gen5-common.h
+++ b/include/configs/rcar-gen5-common.h
@@ -17,6 +17,12 @@
 #define CFG_SYS_SDRAM_SIZE		(0x80000000u - DRAM_RSV_SIZE)
 #define CFG_MAX_MEM_MAPPED		(0x80000000u - DRAM_RSV_SIZE)
 
+/* Timer */
+#if defined(CONFIG_RCAR_64_CM)
+#define CFG_SYS_TIMER_COUNTER		(TMU_BASE + 0xc)	/* TCNT0 */
+#define CFG_SYS_TIMER_RATE		(133333333 / 4)
+#endif
+
 /* Environment setting */
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"bootm_size=0x10000000\0"
-- 
2.53.0

