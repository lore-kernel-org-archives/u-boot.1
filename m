Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094E1C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F08608801D;
	Tue, 27 Feb 2024 17:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="o1RC/VOY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="n22/evUo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0FBF8802C; Tue, 27 Feb 2024 17:10:14 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C59288005
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TkjBD0zp5z9stN;
 Tue, 27 Feb 2024 17:10:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TXLmLJsoaf4GgCpHPPhseqLOAl8chh5P6Q8p7g6qRPE=;
 b=o1RC/VOY1E03q9ni7bBRbKdvmaRaxsdzHd0yzK56RA2vVmmktnnlgFYrj5WynMFhK0PbkG
 m7r42Hcrae97j/S/sbYFHAVNYeVXtsAv9uu0M71aU1v6siKyYDytWqK10oKvZilG2ttqQR
 yepyD3TWHb7qDvGd0sZ2wUSCAQnTCZXI6nS3JQVJQ6+zA5J6ST9qM83FqzvErq2L5BGcDN
 FN95EV16GReGogWjOP6qWALY8Xt36bVj6IfSgKGevebPujyxA+sE7E+j9sdUACQtvjiQyn
 koyiVYiT06brB+ogEBJIeRYdTT0CY27MB3avhdy4mrGgdClS64X4NNjnMPvkWA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TXLmLJsoaf4GgCpHPPhseqLOAl8chh5P6Q8p7g6qRPE=;
 b=n22/evUocCK+o3IfO+y3xHmBgasVwd7YJiiae7Rw7+ytiELsAWhk/qKSMwvwgrbNHVaqqK
 2p6ECOIPBH6rO4Vcp+/gYHy3OsW4c5zAlqqc4JUlVkq5zdim52v7B99edzhkPk0GTL/xBS
 8snSUA+rNqfcSPHhCWoO+6HNIp23yXVjzqepCigduqONFN0lbjLuZgsaoha4hwdCDpXRxv
 FvN5HJs0cbSqoiils7BQm2gbHc/CJVFDEPNycBQQO9wxPgYPphjFYAVC/MSGv0c6Z7VG+W
 kGmagPilHPvEOznyZCTzTANLNyGYq9Kow5zsjKzoerhfyfossB+P/qtcqt1IAA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/19] ARM: renesas: Rename rmobile_get_cpu_type() to
 renesas_get_cpu_type()
Date: Tue, 27 Feb 2024 17:05:45 +0100
Message-ID: <20240227160912.412181-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9350aa87ac880fd6d46
X-MBO-RS-META: fft7mx9tcz7oe91tj4n8nygghzgnxgwu
X-Rspamd-Queue-Id: 4TkjBD0zp5z9stN
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

Rename rmobile_get_cpu_type() to renesas_get_cpu_type() because
all the chips are made by Renesas, while only a subset of them
is from the R-Mobile line.

Use the following command to perform the rename:

"
$ git grep -l '\<rmobile_get_cpu_type\>' | \
  xargs -I {} sed -i 's@\<rmobile_get_cpu_type\>@renesas_get_cpu_type@g' {}
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-rmobile/cpu_info-rcar.c        |  2 +-
 arch/arm/mach-rmobile/cpu_info-rzg2l.c       |  2 +-
 arch/arm/mach-rmobile/cpu_info.c             |  4 +--
 arch/arm/mach-rmobile/include/mach/rmobile.h |  2 +-
 board/renesas/blanche/blanche.c              |  2 +-
 board/renesas/salvator-x/salvator-x.c        |  2 +-
 board/renesas/ulcb/ulcb.c                    |  2 +-
 drivers/mmc/renesas-sdhi.c                   | 34 ++++++++++----------
 drivers/net/ravb.c                           |  4 +--
 drivers/spi/renesas_rpc_spi.c                |  2 +-
 10 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-rmobile/cpu_info-rcar.c b/arch/arm/mach-rmobile/cpu_info-rcar.c
index b9d8b5e57b5..fe1795cec81 100644
--- a/arch/arm/mach-rmobile/cpu_info-rcar.c
+++ b/arch/arm/mach-rmobile/cpu_info-rcar.c
@@ -21,7 +21,7 @@ static u32 rmobile_get_prr(void)
 	return readl(0xFF000044);
 }
 
-u32 rmobile_get_cpu_type(void)
+u32 renesas_get_cpu_type(void)
 {
 	return (rmobile_get_prr() & 0x00007F00) >> 8;
 }
diff --git a/arch/arm/mach-rmobile/cpu_info-rzg2l.c b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
index bd3146fb011..6c0b50ffd40 100644
--- a/arch/arm/mach-rmobile/cpu_info-rzg2l.c
+++ b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
@@ -47,7 +47,7 @@ const u8 *rzg_get_cpu_name(void)
 	return get_tfa_info()->cpu_name;
 }
 
-u32 rmobile_get_cpu_type(void)
+u32 renesas_get_cpu_type(void)
 {
 	return get_tfa_info()->cpu_type;
 }
diff --git a/arch/arm/mach-rmobile/cpu_info.c b/arch/arm/mach-rmobile/cpu_info.c
index adb7fff0c48..c7fbf39cedb 100644
--- a/arch/arm/mach-rmobile/cpu_info.c
+++ b/arch/arm/mach-rmobile/cpu_info.c
@@ -40,7 +40,7 @@ static u32 __rmobile_get_cpu_type(void)
 {
 	return 0x0;
 }
-u32 rmobile_get_cpu_type(void)
+u32 renesas_get_cpu_type(void)
 		__attribute__((weak, alias("__rmobile_get_cpu_type")));
 
 static u32 __rmobile_get_cpu_rev_integer(void)
@@ -83,7 +83,7 @@ static const struct {
 
 static int rmobile_cpuinfo_idx(void)
 {
-	u32 cpu_type = rmobile_get_cpu_type();
+	u32 cpu_type = renesas_get_cpu_type();
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(rmobile_cpuinfo) - 1; i++)
diff --git a/arch/arm/mach-rmobile/include/mach/rmobile.h b/arch/arm/mach-rmobile/include/mach/rmobile.h
index bed91f07ad4..464a67f78d2 100644
--- a/arch/arm/mach-rmobile/include/mach/rmobile.h
+++ b/arch/arm/mach-rmobile/include/mach/rmobile.h
@@ -48,7 +48,7 @@
 #include <asm/types.h>
 
 const u8 *rzg_get_cpu_name(void);
-u32 rmobile_get_cpu_type(void);
+u32 renesas_get_cpu_type(void);
 u32 rmobile_get_cpu_rev_integer(void);
 u32 rmobile_get_cpu_rev_fraction(void);
 #endif /* __ASSEMBLY__ */
diff --git a/board/renesas/blanche/blanche.c b/board/renesas/blanche/blanche.c
index faaf42ee901..80faae62624 100644
--- a/board/renesas/blanche/blanche.c
+++ b/board/renesas/blanche/blanche.c
@@ -49,7 +49,7 @@ static void blanche_init_sys(void)
 	struct rcar_swdt *swdt = (struct rcar_swdt *)SWDT_BASE;
 	u32 cpu_type;
 
-	cpu_type = rmobile_get_cpu_type();
+	cpu_type = renesas_get_cpu_type();
 	if (cpu_type == 0x4A) {
 		writel(0x4D000000, CPG_PLL1CR);
 		writel(0x4F000000, CPG_PLL3CR);
diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvator-x/salvator-x.c
index 71b168893f3..01571625e71 100644
--- a/board/renesas/salvator-x/salvator-x.c
+++ b/board/renesas/salvator-x/salvator-x.c
@@ -76,7 +76,7 @@ void reset_cpu(void)
 int board_fit_config_name_match(const char *name)
 {
 	/* PRR driver is not available yet */
-	u32 cpu_type = rmobile_get_cpu_type();
+	u32 cpu_type = renesas_get_cpu_type();
 
 	if ((cpu_type == RMOBILE_CPU_TYPE_R8A7795) &&
 	    !strcmp(name, "r8a77950-salvator-x-u-boot"))
diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
index 3c2f7c5e815..5d7ebbd922f 100644
--- a/board/renesas/ulcb/ulcb.c
+++ b/board/renesas/ulcb/ulcb.c
@@ -67,7 +67,7 @@ int board_init(void)
 int board_fit_config_name_match(const char *name)
 {
 	/* PRR driver is not available yet */
-	u32 cpu_type = rmobile_get_cpu_type();
+	u32 cpu_type = renesas_get_cpu_type();
 
 	if ((cpu_type == RMOBILE_CPU_TYPE_R8A7795) &&
 	    !strcmp(name, "r8a77950-ulcb-u-boot"))
diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index a74559ca686..4b7cf773243 100644
--- a/drivers/mmc/renesas-sdhi.c
+++ b/drivers/mmc/renesas-sdhi.c
@@ -885,28 +885,28 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 	struct tmio_sd_plat *plat = dev_get_plat(dev);
 
 	/* HS400 is not supported on H3 ES1.x, M3W ES1.[012], V3M, V3H ES1.x, D3 */
-	if (((rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7795) &&
+	if (((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7795) &&
 	    (rmobile_get_cpu_rev_integer() <= 1)) ||
-	    ((rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
+	    ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
 	    (rmobile_get_cpu_rev_integer() == 1) &&
 	    (rmobile_get_cpu_rev_fraction() <= 2)) ||
-	    (rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77970) ||
-	    ((rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77980) &&
+	    (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77970) ||
+	    ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77980) &&
 	    (rmobile_get_cpu_rev_integer() <= 1)) ||
-	    (rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77995))
+	    (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77995))
 		plat->cfg.host_caps &= ~MMC_MODE_HS400;
 
 	/* H3 ES2.0, ES3.0 and M3W ES1.2 and M3N bad taps */
-	if (((rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7795) &&
+	if (((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7795) &&
 	    (rmobile_get_cpu_rev_integer() >= 2)) ||
-	    ((rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
+	    ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
 	    (rmobile_get_cpu_rev_integer() == 1) &&
 	    (rmobile_get_cpu_rev_fraction() == 2)) ||
-	    (rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77965))
+	    (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77965))
 		priv->hs400_bad_tap = BIT(2) | BIT(3) | BIT(6) | BIT(7);
 
 	/* M3W ES1.x for x>2 can use HS400 with manual adjustment and taps */
-	if ((rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
+	if ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
 	    (rmobile_get_cpu_rev_integer() == 1) &&
 	    (rmobile_get_cpu_rev_fraction() > 2)) {
 		priv->adjust_hs400_enable = true;
@@ -917,12 +917,12 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 	}
 
 	/* M3W+ bad taps */
-	if ((rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
+	if ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
 	    (rmobile_get_cpu_rev_integer() == 3))
 		priv->hs400_bad_tap = BIT(1) | BIT(3) | BIT(5) | BIT(7);
 
 	/* M3N can use HS400 with manual adjustment */
-	if (rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77965) {
+	if (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77965) {
 		priv->adjust_hs400_enable = true;
 		priv->adjust_hs400_offset = 3;
 		priv->adjust_hs400_calib_table =
@@ -930,7 +930,7 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 	}
 
 	/* E3 can use HS400 with manual adjustment */
-	if (rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77990) {
+	if (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77990) {
 		priv->adjust_hs400_enable = true;
 		priv->adjust_hs400_offset = 3;
 		priv->adjust_hs400_calib_table =
@@ -938,9 +938,9 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 	}
 
 	/* H3 ES1.x, ES2.0 and M3W ES1.[0123] uses 4 tuning taps */
-	if (((rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7795) &&
+	if (((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7795) &&
 	    (rmobile_get_cpu_rev_integer() <= 2)) ||
-	    ((rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
+	    ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
 	    (rmobile_get_cpu_rev_integer() == 1) &&
 	    (rmobile_get_cpu_rev_fraction() <= 3)))
 		priv->nrtaps = 4;
@@ -948,9 +948,9 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 		priv->nrtaps = 8;
 #endif
 	/* H3 ES1.x and M3W ES1.0 uses bit 17 for DTRAEND */
-	if (((rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7795) &&
+	if (((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7795) &&
 	    (rmobile_get_cpu_rev_integer() <= 1)) ||
-	    ((rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
+	    ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
 	    (rmobile_get_cpu_rev_integer() == 1) &&
 	    (rmobile_get_cpu_rev_fraction() == 0)))
 		priv->read_poll_flag = TMIO_SD_DMA_INFO1_END_RD;
@@ -958,7 +958,7 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 		priv->read_poll_flag = TMIO_SD_DMA_INFO1_END_RD2;
 
 	/* V3M handles SD0H differently than other Gen3 SoCs */
-	if (rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77970)
+	if (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77970)
 		priv->needs_clkh_fallback = true;
 	else
 		priv->needs_clkh_fallback = false;
diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 0bcd6cfd3f3..733f08ad4ea 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -392,8 +392,8 @@ static int ravb_dmac_init(struct udevice *dev)
 	writel(0x00222210, eth->iobase + RAVB_REG_TGC);
 
 	/* Delay CLK: 2ns (not applicable on R-Car E3/D3) */
-	if ((rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77990) ||
-	    (rmobile_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77995))
+	if ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77990) ||
+	    (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77995))
 		return 0;
 
 	if (!dev_read_u32(dev, "rx-internal-delay-ps", &delay)) {
diff --git a/drivers/spi/renesas_rpc_spi.c b/drivers/spi/renesas_rpc_spi.c
index 3eb14061c81..8a93d1b1bfd 100644
--- a/drivers/spi/renesas_rpc_spi.c
+++ b/drivers/spi/renesas_rpc_spi.c
@@ -203,7 +203,7 @@ static void rpc_spi_flush_read_cache(struct udevice *dev)
 static u32 rpc_spi_get_strobe_delay(void)
 {
 #ifndef CONFIG_RZA1
-	u32 cpu_type = rmobile_get_cpu_type();
+	u32 cpu_type = renesas_get_cpu_type();
 
 	/*
 	 * NOTE: RPC_PHYCNT_STRTIM value:
-- 
2.43.0

