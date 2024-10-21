Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4114BD15DA9
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 15:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E617C88F0A;
	Mon, 21 Oct 2024 17:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Uz6b2u7Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C49AD88F01; Mon, 21 Oct 2024 17:13:39 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 931CC88DC8
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 17:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E108FFF807;
 Mon, 21 Oct 2024 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1729523617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3aS245jpXzjptYM4R8EsxF0R6c+lSg28ampfVfO8Cu4=;
 b=Uz6b2u7YkCYwPNOQzglFxrxAmgWQrOWbuYV8HJvQnq7E7PEEFyRArPyFuQ9+ccelOKuGlg
 aArEyLbcVW3CIh0Y7Dtrd9H2wn0PuPfnZaIEZonoHF6B8QooRCEPdLvf6cFyiUXB7cIs0O
 HeUWsWPwNOzd+XiJjjBghoPD9do3eLgEzB8TY2QXpNSI8gINTQg4lodw9iG9YzT5eRtJ3g
 ENUi/JUwJBENJm7rhRyYJ8ZUiUX2j2IlEvzpujJEZHiyt4Oj3tKmnIUFjifCTmmrWdPJqc
 fPrzds7TScAbr89pZlnvolRyxLeEFEpDscBbLEOkLa5VvSVN2ZqVbDeL7Ithkw==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Tom Rini <trini@konsulko.com>,
	Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 2/6] memory: ti-aemif: Make AEMIF driver architecture agnostic
Date: Mon, 21 Oct 2024 17:13:26 +0200
Message-ID: <20241021151330.1860929-3-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021151330.1860929-1-bastien.curutchet@bootlin.com>
References: <20241021151330.1860929-1-bastien.curutchet@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com
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

AEMIF controller is present on other SoCs than the Keystone ones.

Remove Keystone specificities from the driver to be able to use it from
other architectures.
Adapt the ks2_evm/board.c to fit the new driver.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 arch/arm/include/asm/ti-common/ti-aemif.h |  1 +
 board/ti/ks2_evm/board.c                  |  4 +++-
 drivers/memory/ti-aemif.c                 | 20 ++++++++++----------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/ti-common/ti-aemif.h b/arch/arm/include/asm/ti-common/ti-aemif.h
index a77538673f..11a7384cec 100644
--- a/arch/arm/include/asm/ti-common/ti-aemif.h
+++ b/arch/arm/include/asm/ti-common/ti-aemif.h
@@ -16,6 +16,7 @@
 #define AEMIF_PRESERVE             -1
 
 struct aemif_config {
+	void *base;
 	unsigned mode;
 	unsigned select_strobe;
 	unsigned extend_wait;
diff --git a/board/ti/ks2_evm/board.c b/board/ti/ks2_evm/board.c
index c6735d37dd..b2f0dced67 100644
--- a/board/ti/ks2_evm/board.c
+++ b/board/ti/ks2_evm/board.c
@@ -49,8 +49,10 @@ int dram_init(void)
 	gd->ram_size = get_ram_size((long *)CFG_SYS_SDRAM_BASE,
 				    CFG_MAX_RAM_BANK_SIZE);
 #if defined(CONFIG_TI_AEMIF)
-	if (!(board_is_k2g_ice() || board_is_k2g_i1()))
+	if (!(board_is_k2g_ice() || board_is_k2g_i1())) {
+		aemif_configs->base = (void *)KS2_AEMIF_CNTRL_BASE;
 		aemif_init(ARRAY_SIZE(aemif_configs), aemif_configs);
+	}
 #endif
 
 	if (!(board_is_k2g_ice() || board_is_k2g_i1())) {
diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 127a262894..8e7ddde970 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -9,10 +9,10 @@
 #include <asm/arch/hardware.h>
 #include <asm/ti-common/ti-aemif.h>
 
-#define AEMIF_WAITCYCLE_CONFIG		(KS2_AEMIF_CNTRL_BASE + 0x4)
-#define AEMIF_NAND_CONTROL		(KS2_AEMIF_CNTRL_BASE + 0x60)
-#define AEMIF_ONENAND_CONTROL		(KS2_AEMIF_CNTRL_BASE + 0x5c)
-#define AEMIF_CONFIG(cs)		(KS2_AEMIF_CNTRL_BASE + 0x10 + ((cs) * 4))
+#define AEMIF_WAITCYCLE_CONFIG		(0x4)
+#define AEMIF_NAND_CONTROL		(0x60)
+#define AEMIF_ONENAND_CONTROL		(0x5c)
+#define AEMIF_CONFIG(cs)		(0x10 + ((cs) * 4))
 
 #define AEMIF_CFG_SELECT_STROBE(v)	((v) ? 1 << 31 : 0)
 #define AEMIF_CFG_EXTEND_WAIT(v)	((v) ? 1 << 30 : 0)
@@ -38,17 +38,17 @@ static void aemif_configure(int cs, struct aemif_config *cfg)
 	unsigned long tmp;
 
 	if (cfg->mode == AEMIF_MODE_NAND) {
-		tmp = __raw_readl(AEMIF_NAND_CONTROL);
+		tmp = __raw_readl(cfg->base + AEMIF_NAND_CONTROL);
 		tmp |= (1 << cs);
-		__raw_writel(tmp, AEMIF_NAND_CONTROL);
+		__raw_writel(tmp, cfg->base + AEMIF_NAND_CONTROL);
 
 	} else if (cfg->mode == AEMIF_MODE_ONENAND) {
-		tmp = __raw_readl(AEMIF_ONENAND_CONTROL);
+		tmp = __raw_readl(cfg->base + AEMIF_ONENAND_CONTROL);
 		tmp |= (1 << cs);
-		__raw_writel(tmp, AEMIF_ONENAND_CONTROL);
+		__raw_writel(tmp, cfg->base + AEMIF_ONENAND_CONTROL);
 	}
 
-	tmp = __raw_readl(AEMIF_CONFIG(cs));
+	tmp = __raw_readl(cfg->base + AEMIF_CONFIG(cs));
 
 	set_config_field(tmp, SELECT_STROBE,	cfg->select_strobe);
 	set_config_field(tmp, EXTEND_WAIT,	cfg->extend_wait);
@@ -61,7 +61,7 @@ static void aemif_configure(int cs, struct aemif_config *cfg)
 	set_config_field(tmp, TURN_AROUND,	cfg->turn_around);
 	set_config_field(tmp, WIDTH,		cfg->width);
 
-	__raw_writel(tmp, AEMIF_CONFIG(cs));
+	__raw_writel(tmp, cfg->base + AEMIF_CONFIG(cs));
 }
 
 void aemif_init(int num_cs, struct aemif_config *config)
-- 
2.47.0

