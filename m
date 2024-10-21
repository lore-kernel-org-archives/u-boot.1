Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C830D15DA9
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 15:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 214AB88EBB;
	Mon, 21 Oct 2024 17:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="CuDosAlw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 755C988F4F; Mon, 21 Oct 2024 17:13:42 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 875C0885D1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 17:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id D95CFFF802;
 Mon, 21 Oct 2024 15:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1729523620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDu/C0gQZJYsH7nv4G6bubm3VjoZNkgSWh/EnYQwVHc=;
 b=CuDosAlwqLV6yt3AM1GlLmQaMqDVOb4rtMmzAxJqAz3pDRjtl2d0EWuboxpwRXOzPMzckE
 Mtgk2Co5mROCi542RvqoLhriRECXm6OoHFY9RYWJ2eTSRQKK5SNAu3Cg1ltlOznTPwZmpv
 +lzwL/lIty63/opFvB9eHndzulI4oNq/9VO4Y7MLGVtySP6Y8FqP50jnpfpQ2SHjeppuRT
 XMASuFI3ATDP0GTVCZytVuGe3eXe90Sjr1rJw6EDZFqEidjB1/btEE4wJ7t4M1aOeUbFoL
 UCWLxKfHTJfUGTwuDD1cazYt6Qbj5i7n+0OKCN/YOrDJRO5yGr1gzFzkdT9vxQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Tom Rini <trini@konsulko.com>,
	Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 4/6] memory: ti-aemif: Wrap the CS configuration into a
 function
Date: Mon, 21 Oct 2024 17:13:28 +0200
Message-ID: <20241021151330.1860929-5-bastien.curutchet@bootlin.com>
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

Wrap the CS configuration into a aemif_configure_cs() to ease its
migration to another driver when adding DM support.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/memory/ti-aemif.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 82a9c8cf7b..5e9514713f 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -34,21 +34,10 @@
 		}						\
 	} while (0)
 
-static void aemif_configure(int cs, struct aemif_config *cfg)
+static void aemif_cs_configure(int cs, struct aemif_config *cfg)
 {
 	unsigned long tmp;
 
-	if (cfg->mode == AEMIF_MODE_NAND) {
-		tmp = __raw_readl(cfg->base + AEMIF_NAND_CONTROL);
-		tmp |= (1 << cs);
-		__raw_writel(tmp, cfg->base + AEMIF_NAND_CONTROL);
-
-	} else if (cfg->mode == AEMIF_MODE_ONENAND) {
-		tmp = __raw_readl(cfg->base + AEMIF_ONENAND_CONTROL);
-		tmp |= (1 << cs);
-		__raw_writel(tmp, cfg->base + AEMIF_ONENAND_CONTROL);
-	}
-
 	tmp = __raw_readl(cfg->base + AEMIF_CONFIG(cs));
 
 	set_config_field(tmp, SELECT_STROBE,	cfg->select_strobe);
@@ -65,6 +54,24 @@ static void aemif_configure(int cs, struct aemif_config *cfg)
 	__raw_writel(tmp, cfg->base + AEMIF_CONFIG(cs));
 }
 
+static void aemif_configure(int cs, struct aemif_config *cfg)
+{
+	unsigned long tmp;
+
+	if (cfg->mode == AEMIF_MODE_NAND) {
+		tmp = __raw_readl(cfg->base + AEMIF_NAND_CONTROL);
+		tmp |= (1 << cs);
+		__raw_writel(tmp, cfg->base + AEMIF_NAND_CONTROL);
+
+	} else if (cfg->mode == AEMIF_MODE_ONENAND) {
+		tmp = __raw_readl(cfg->base + AEMIF_ONENAND_CONTROL);
+		tmp |= (1 << cs);
+		__raw_writel(tmp, cfg->base + AEMIF_ONENAND_CONTROL);
+	}
+
+	aemif_cs_configure(cs, cfg);
+}
+
 void aemif_init(int num_cs, struct aemif_config *config)
 {
 	int cs;
-- 
2.47.0

