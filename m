Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DCDC54E49
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B38B88028;
	Tue, 27 Feb 2024 17:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oK6GnZ4/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="A9wlR0Hk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF89188031; Tue, 27 Feb 2024 17:10:15 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FAAE8800E
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TkjBF2FzMz9spV;
 Tue, 27 Feb 2024 17:10:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ApGX2/NfpEHSim2oqbBf8IxcvK1kO+yi0yY6/lzCfsA=;
 b=oK6GnZ4/YFUWGf5e0xMA3mtFRcy6wPAz7u2W6VmSvJRKonNZXRZ3lLBwJ8LuTNbZwvvzhf
 fPvW5vN+6ybfuLB5+sncJ3PwkEJSbjOLB5f1H2JaD2sRXyFyT6cvkA3Pw1jLiRdyjoDmxB
 CmxIQBkOgn6qM/TZruySuwCRK0YNOgj24ktlfACcCQjznINya7Nm4+Fqg5CqpmQhdOD+8D
 0N7pU6dlHY2a4Q5WYpeBjUzhj6SIskZ31Mbvj3oK2jgENL4dtPaj8eynulvQbi2kuWLE4g
 eq6BgjmvJgG8mnkTpggU4UHGr1ZKuD1bQUAj6qAyCVN+oRG07fF9ApkSlu77IA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ApGX2/NfpEHSim2oqbBf8IxcvK1kO+yi0yY6/lzCfsA=;
 b=A9wlR0Hkzzqzy3sd6D2bKRILzsVDhPUBTg9KEr6YVskD1t4pDeo0nOEnFayIo6ShSonn1t
 mog5c+R6k9dTHhUB81TohQ6AL7O27NEzhfQuDdC3hk825QCNTb6IrlsuwAjYTt6oO7v6rf
 4pGxMv9FGIiHY/OOzxOjx0+Peu9UKomciq9Zwc2sysXyG30HKzNLks5EyEXEr9Q3uQH7TO
 cIE679v9H0pE4RVDMGPIIkiFBpdFVLS5NC+TCgocehm1Dy5gjbolxafMhRlnJTBqOIPDYd
 cdX7w/3g1lYgMa82/QeOTpimxF121iBf05vyEhQ52/O5O3zDNIFrVxc6fTjEfA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/19] ARM: renesas: Rename rmobile_get_cpu_rev_*() to
 renesas_get_cpu_rev_*()
Date: Tue, 27 Feb 2024 17:05:46 +0100
Message-ID: <20240227160912.412181-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3ea7f907e6f8d549795
X-MBO-RS-META: ds65pbs677m8x6owwmyhs14tut3p8q3c
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

Rename rmobile_get_cpu_rev_*() to renesas_get_cpu_rev_*() because
all the chips are made by Renesas, while only a subset of them is
from the R-Mobile line.

Use the following command to perform the rename:

"
$ git grep -l '\<rmobile_get_cpu_rev_\(integer\|fraction\)\>' | \
  xargs -I {} sed -i 's@\<rmobile_get_cpu_rev_\(integer\|fraction\)\>@renesas_get_cpu_rev_\1@g' {}
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-rmobile/cpu_info-rcar.c        |  4 +--
 arch/arm/mach-rmobile/cpu_info-rzg2l.c       |  4 +--
 arch/arm/mach-rmobile/cpu_info.c             | 12 ++++----
 arch/arm/mach-rmobile/include/mach/r8a7790.h |  2 +-
 arch/arm/mach-rmobile/include/mach/r8a7791.h |  2 +-
 arch/arm/mach-rmobile/include/mach/r8a7793.h |  2 +-
 arch/arm/mach-rmobile/include/mach/r8a7794.h |  2 +-
 arch/arm/mach-rmobile/include/mach/rmobile.h |  4 +--
 board/renesas/lager/lager.c                  |  2 +-
 board/renesas/lager/qos.c                    |  2 +-
 board/renesas/stout/qos.c                    |  2 +-
 board/renesas/stout/stout.c                  |  2 +-
 drivers/mmc/renesas-sdhi.c                   | 32 ++++++++++----------
 drivers/pinctrl/renesas/pfc-r8a7790.c        |  4 +--
 drivers/pinctrl/renesas/pfc-r8a7794.c        |  4 +--
 drivers/spi/renesas_rpc_spi.c                |  2 +-
 16 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-rmobile/cpu_info-rcar.c b/arch/arm/mach-rmobile/cpu_info-rcar.c
index fe1795cec81..4c439adfdd6 100644
--- a/arch/arm/mach-rmobile/cpu_info-rcar.c
+++ b/arch/arm/mach-rmobile/cpu_info-rcar.c
@@ -26,7 +26,7 @@ u32 renesas_get_cpu_type(void)
 	return (rmobile_get_prr() & 0x00007F00) >> 8;
 }
 
-u32 rmobile_get_cpu_rev_integer(void)
+u32 renesas_get_cpu_rev_integer(void)
 {
 	const u32 prr = rmobile_get_prr();
 	const u32 rev = prr & PRR_MASK;
@@ -38,7 +38,7 @@ u32 rmobile_get_cpu_rev_integer(void)
 		return ((prr & 0x000000F0) >> 4) + 1;
 }
 
-u32 rmobile_get_cpu_rev_fraction(void)
+u32 renesas_get_cpu_rev_fraction(void)
 {
 	const u32 prr = rmobile_get_prr();
 	const u32 rev = prr & PRR_MASK;
diff --git a/arch/arm/mach-rmobile/cpu_info-rzg2l.c b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
index 6c0b50ffd40..ce7cc2a28db 100644
--- a/arch/arm/mach-rmobile/cpu_info-rzg2l.c
+++ b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
@@ -52,12 +52,12 @@ u32 renesas_get_cpu_type(void)
 	return get_tfa_info()->cpu_type;
 }
 
-u32 rmobile_get_cpu_rev_integer(void)
+u32 renesas_get_cpu_rev_integer(void)
 {
 	return (readl(SYSC_LSI_DEVID) >> 28) + 1;
 }
 
-u32 rmobile_get_cpu_rev_fraction(void)
+u32 renesas_get_cpu_rev_fraction(void)
 {
 	return 0;
 }
diff --git a/arch/arm/mach-rmobile/cpu_info.c b/arch/arm/mach-rmobile/cpu_info.c
index c7fbf39cedb..35cfef2e1ab 100644
--- a/arch/arm/mach-rmobile/cpu_info.c
+++ b/arch/arm/mach-rmobile/cpu_info.c
@@ -47,14 +47,14 @@ static u32 __rmobile_get_cpu_rev_integer(void)
 {
 	return 0;
 }
-u32 rmobile_get_cpu_rev_integer(void)
+u32 renesas_get_cpu_rev_integer(void)
 		__attribute__((weak, alias("__rmobile_get_cpu_rev_integer")));
 
 static u32 __rmobile_get_cpu_rev_fraction(void)
 {
 	return 0;
 }
-u32 rmobile_get_cpu_rev_fraction(void)
+u32 renesas_get_cpu_rev_fraction(void)
 		__attribute__((weak, alias("__rmobile_get_cpu_rev_fraction")));
 
 /* CPU information table */
@@ -122,15 +122,15 @@ int print_cpuinfo(void)
 	int i = rmobile_cpuinfo_idx();
 
 	if (rmobile_cpuinfo[i].cpu_type == RMOBILE_CPU_TYPE_R8A7796 &&
-	    rmobile_get_cpu_rev_integer() == 1 &&
-	    rmobile_get_cpu_rev_fraction() == 1) {
+	    renesas_get_cpu_rev_integer() == 1 &&
+	    renesas_get_cpu_rev_fraction() == 1) {
 		printf("CPU:   Renesas Electronics %s rev 1.1/1.2\n", get_cpu_name(i));
 		return 0;
 	}
 
 	printf("CPU:   Renesas Electronics %s rev %d.%d\n",
-		get_cpu_name(i), rmobile_get_cpu_rev_integer(),
-		rmobile_get_cpu_rev_fraction());
+		get_cpu_name(i), renesas_get_cpu_rev_integer(),
+		renesas_get_cpu_rev_fraction());
 
 	return 0;
 }
diff --git a/arch/arm/mach-rmobile/include/mach/r8a7790.h b/arch/arm/mach-rmobile/include/mach/r8a7790.h
index 485ea7e28d1..233531cb4ab 100644
--- a/arch/arm/mach-rmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-rmobile/include/mach/r8a7790.h
@@ -28,6 +28,6 @@
 
 #define R8A7790_CUT_ES2X	2
 #define IS_R8A7790_ES2()	\
-	(rmobile_get_cpu_rev_integer() == R8A7790_CUT_ES2X)
+	(renesas_get_cpu_rev_integer() == R8A7790_CUT_ES2X)
 
 #endif /* __ASM_ARCH_R8A7790_H */
diff --git a/arch/arm/mach-rmobile/include/mach/r8a7791.h b/arch/arm/mach-rmobile/include/mach/r8a7791.h
index 2006ad58a52..78a910cfdd2 100644
--- a/arch/arm/mach-rmobile/include/mach/r8a7791.h
+++ b/arch/arm/mach-rmobile/include/mach/r8a7791.h
@@ -65,6 +65,6 @@
 
 #define R8A7791_CUT_ES2X	2
 #define IS_R8A7791_ES2()	\
-	(rmobile_get_cpu_rev_integer() == R8A7791_CUT_ES2X)
+	(renesas_get_cpu_rev_integer() == R8A7791_CUT_ES2X)
 
 #endif /* __ASM_ARCH_R8A7791_H */
diff --git a/arch/arm/mach-rmobile/include/mach/r8a7793.h b/arch/arm/mach-rmobile/include/mach/r8a7793.h
index 02f4286ef1a..4cb064731ca 100644
--- a/arch/arm/mach-rmobile/include/mach/r8a7793.h
+++ b/arch/arm/mach-rmobile/include/mach/r8a7793.h
@@ -71,6 +71,6 @@
 
 #define R8A7793_CUT_ES2X	2
 #define IS_R8A7793_ES2() \
-	(rmobile_get_cpu_rev_integer() == R8A7793_CUT_ES2X)
+	(renesas_get_cpu_rev_integer() == R8A7793_CUT_ES2X)
 
 #endif /* __ASM_ARCH_R8A7793_H */
diff --git a/arch/arm/mach-rmobile/include/mach/r8a7794.h b/arch/arm/mach-rmobile/include/mach/r8a7794.h
index a2a949d4d61..6d0d729bb12 100644
--- a/arch/arm/mach-rmobile/include/mach/r8a7794.h
+++ b/arch/arm/mach-rmobile/include/mach/r8a7794.h
@@ -28,6 +28,6 @@
 
 #define R8A7794_CUT_ES2		2
 #define IS_R8A7794_ES2()	\
-	(rmobile_get_cpu_rev_integer() == R8A7794_CUT_ES2)
+	(renesas_get_cpu_rev_integer() == R8A7794_CUT_ES2)
 
 #endif /* __ASM_ARCH_R8A7794_H */
diff --git a/arch/arm/mach-rmobile/include/mach/rmobile.h b/arch/arm/mach-rmobile/include/mach/rmobile.h
index 464a67f78d2..d41b737d6b1 100644
--- a/arch/arm/mach-rmobile/include/mach/rmobile.h
+++ b/arch/arm/mach-rmobile/include/mach/rmobile.h
@@ -49,8 +49,8 @@
 
 const u8 *rzg_get_cpu_name(void);
 u32 renesas_get_cpu_type(void);
-u32 rmobile_get_cpu_rev_integer(void);
-u32 rmobile_get_cpu_rev_fraction(void);
+u32 renesas_get_cpu_rev_integer(void);
+u32 renesas_get_cpu_rev_fraction(void);
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_ARCH_RMOBILE_H */
diff --git a/board/renesas/lager/lager.c b/board/renesas/lager/lager.c
index d9d460834b2..ab06078c511 100644
--- a/board/renesas/lager/lager.c
+++ b/board/renesas/lager/lager.c
@@ -46,7 +46,7 @@ void s_init(void)
 	writel(0xA5A5A500, &swdt->swtcsra);
 
 	/* CPU frequency setting. Set to 1.4GHz */
-	if (rmobile_get_cpu_rev_integer() >= R8A7790_CUT_ES2X) {
+	if (renesas_get_cpu_rev_integer() >= R8A7790_CUT_ES2X) {
 		u32 stat = 0;
 		u32 stc = ((1400 / CLK2MHZ(get_board_sys_clk())) - 1)
 			<< PLL0_STC_BIT;
diff --git a/board/renesas/lager/qos.c b/board/renesas/lager/qos.c
index ddc831c0c21..f7eade2ed11 100644
--- a/board/renesas/lager/qos.c
+++ b/board/renesas/lager/qos.c
@@ -2419,7 +2419,7 @@ static void qos_init_es2(void)
 
 void qos_init(void)
 {
-	if (rmobile_get_cpu_rev_integer() >= R8A7790_CUT_ES2X)
+	if (renesas_get_cpu_rev_integer() >= R8A7790_CUT_ES2X)
 		qos_init_es2();
 	else
 		qos_init_es1();
diff --git a/board/renesas/stout/qos.c b/board/renesas/stout/qos.c
index 9030ba7f61f..8a878123a5d 100644
--- a/board/renesas/stout/qos.c
+++ b/board/renesas/stout/qos.c
@@ -2421,7 +2421,7 @@ static void qos_init_es2(void)
 
 void qos_init(void)
 {
-	if (rmobile_get_cpu_rev_integer() >= R8A7790_CUT_ES2X)
+	if (renesas_get_cpu_rev_integer() >= R8A7790_CUT_ES2X)
 		qos_init_es2();
 	else
 		qos_init_es1();
diff --git a/board/renesas/stout/stout.c b/board/renesas/stout/stout.c
index 46c48dff0a0..109e19a292d 100644
--- a/board/renesas/stout/stout.c
+++ b/board/renesas/stout/stout.c
@@ -46,7 +46,7 @@ void s_init(void)
 	writel(0xA5A5A500, &swdt->swtcsra);
 
 	/* CPU frequency setting. Set to 1.4GHz */
-	if (rmobile_get_cpu_rev_integer() >= R8A7790_CUT_ES2X) {
+	if (renesas_get_cpu_rev_integer() >= R8A7790_CUT_ES2X) {
 		u32 stat = 0;
 		u32 stc = ((1400 / CLK2MHZ(get_board_sys_clk())) - 1)
 			<< PLL0_STC_BIT;
diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index 4b7cf773243..03e360ec1a2 100644
--- a/drivers/mmc/renesas-sdhi.c
+++ b/drivers/mmc/renesas-sdhi.c
@@ -886,29 +886,29 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 
 	/* HS400 is not supported on H3 ES1.x, M3W ES1.[012], V3M, V3H ES1.x, D3 */
 	if (((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7795) &&
-	    (rmobile_get_cpu_rev_integer() <= 1)) ||
+	    (renesas_get_cpu_rev_integer() <= 1)) ||
 	    ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
-	    (rmobile_get_cpu_rev_integer() == 1) &&
-	    (rmobile_get_cpu_rev_fraction() <= 2)) ||
+	    (renesas_get_cpu_rev_integer() == 1) &&
+	    (renesas_get_cpu_rev_fraction() <= 2)) ||
 	    (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77970) ||
 	    ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77980) &&
-	    (rmobile_get_cpu_rev_integer() <= 1)) ||
+	    (renesas_get_cpu_rev_integer() <= 1)) ||
 	    (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77995))
 		plat->cfg.host_caps &= ~MMC_MODE_HS400;
 
 	/* H3 ES2.0, ES3.0 and M3W ES1.2 and M3N bad taps */
 	if (((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7795) &&
-	    (rmobile_get_cpu_rev_integer() >= 2)) ||
+	    (renesas_get_cpu_rev_integer() >= 2)) ||
 	    ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
-	    (rmobile_get_cpu_rev_integer() == 1) &&
-	    (rmobile_get_cpu_rev_fraction() == 2)) ||
+	    (renesas_get_cpu_rev_integer() == 1) &&
+	    (renesas_get_cpu_rev_fraction() == 2)) ||
 	    (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77965))
 		priv->hs400_bad_tap = BIT(2) | BIT(3) | BIT(6) | BIT(7);
 
 	/* M3W ES1.x for x>2 can use HS400 with manual adjustment and taps */
 	if ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
-	    (rmobile_get_cpu_rev_integer() == 1) &&
-	    (rmobile_get_cpu_rev_fraction() > 2)) {
+	    (renesas_get_cpu_rev_integer() == 1) &&
+	    (renesas_get_cpu_rev_fraction() > 2)) {
 		priv->adjust_hs400_enable = true;
 		priv->adjust_hs400_offset = 3;
 		priv->hs400_bad_tap = BIT(1) | BIT(3) | BIT(5) | BIT(7);
@@ -918,7 +918,7 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 
 	/* M3W+ bad taps */
 	if ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
-	    (rmobile_get_cpu_rev_integer() == 3))
+	    (renesas_get_cpu_rev_integer() == 3))
 		priv->hs400_bad_tap = BIT(1) | BIT(3) | BIT(5) | BIT(7);
 
 	/* M3N can use HS400 with manual adjustment */
@@ -939,20 +939,20 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 
 	/* H3 ES1.x, ES2.0 and M3W ES1.[0123] uses 4 tuning taps */
 	if (((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7795) &&
-	    (rmobile_get_cpu_rev_integer() <= 2)) ||
+	    (renesas_get_cpu_rev_integer() <= 2)) ||
 	    ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
-	    (rmobile_get_cpu_rev_integer() == 1) &&
-	    (rmobile_get_cpu_rev_fraction() <= 3)))
+	    (renesas_get_cpu_rev_integer() == 1) &&
+	    (renesas_get_cpu_rev_fraction() <= 3)))
 		priv->nrtaps = 4;
 	else
 		priv->nrtaps = 8;
 #endif
 	/* H3 ES1.x and M3W ES1.0 uses bit 17 for DTRAEND */
 	if (((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7795) &&
-	    (rmobile_get_cpu_rev_integer() <= 1)) ||
+	    (renesas_get_cpu_rev_integer() <= 1)) ||
 	    ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
-	    (rmobile_get_cpu_rev_integer() == 1) &&
-	    (rmobile_get_cpu_rev_fraction() == 0)))
+	    (renesas_get_cpu_rev_integer() == 1) &&
+	    (renesas_get_cpu_rev_fraction() == 0)))
 		priv->read_poll_flag = TMIO_SD_DMA_INFO1_END_RD;
 	else
 		priv->read_poll_flag = TMIO_SD_DMA_INFO1_END_RD2;
diff --git a/drivers/pinctrl/renesas/pfc-r8a7790.c b/drivers/pinctrl/renesas/pfc-r8a7790.c
index e1811c4c908..acd6b01f497 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7790.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7790.c
@@ -6117,8 +6117,8 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 static int r8a7790_pinmux_soc_init(struct sh_pfc *pfc)
 {
 	/* Initialize TDSEL on old revisions */
-	if ((rmobile_get_cpu_rev_integer() == 1) &&
-	    (rmobile_get_cpu_rev_fraction() == 0))
+	if ((renesas_get_cpu_rev_integer() == 1) &&
+	    (renesas_get_cpu_rev_fraction() == 0))
 		sh_pfc_write(pfc, 0xe6060088, 0x00155554);
 
 	return 0;
diff --git a/drivers/pinctrl/renesas/pfc-r8a7794.c b/drivers/pinctrl/renesas/pfc-r8a7794.c
index 29eab2610c1..2f550218182 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7794.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7794.c
@@ -5818,8 +5818,8 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 static int r8a7794_pinmux_soc_init(struct sh_pfc *pfc)
 {
 	/* Initialize TDSEL on old revisions */
-	if ((rmobile_get_cpu_rev_integer() == 1) &&
-	    (rmobile_get_cpu_rev_fraction() == 0))
+	if ((renesas_get_cpu_rev_integer() == 1) &&
+	    (renesas_get_cpu_rev_fraction() == 0))
 		sh_pfc_write(pfc, 0xe6060068, 0x55555500);
 
 	return 0;
diff --git a/drivers/spi/renesas_rpc_spi.c b/drivers/spi/renesas_rpc_spi.c
index 8a93d1b1bfd..165c0a1351a 100644
--- a/drivers/spi/renesas_rpc_spi.c
+++ b/drivers/spi/renesas_rpc_spi.c
@@ -212,7 +212,7 @@ static u32 rpc_spi_get_strobe_delay(void)
 	 *       7: On other R-Car Gen3
 	 *      15: On R-Car Gen4
 	 */
-	if (cpu_type == RMOBILE_CPU_TYPE_R8A7796 && rmobile_get_cpu_rev_integer() == 1)
+	if (cpu_type == RMOBILE_CPU_TYPE_R8A7796 && renesas_get_cpu_rev_integer() == 1)
 		return RPC_PHYCNT_STRTIM(6);
 	else if (cpu_type == RMOBILE_CPU_TYPE_R8A779F0 ||
 		 cpu_type == RMOBILE_CPU_TYPE_R8A779G0 ||
-- 
2.43.0

