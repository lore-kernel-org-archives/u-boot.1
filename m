Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46345CCD195
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C640F836F0;
	Thu, 16 Oct 2025 16:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="oca7SyBO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E6C6836D1; Thu, 16 Oct 2025 16:28:38 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51F6180077
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id DC6B24E410EE;
 Thu, 16 Oct 2025 14:28:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B1F4D6062C;
 Thu, 16 Oct 2025 14:28:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CB8BC102F231B; 
 Thu, 16 Oct 2025 16:28:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760624914; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=UAAjnlykxWRs7bMTuXViEcfesVwjba32b58EQvO7Rz4=;
 b=oca7SyBOd8qyfXf9hl8SIcG6NXO13dzEomBA1DALncpzGDf/XtgpuMuck0w7xJGZFcI0+2
 qSuNZflGzlQaUX3xz7hNGl0fh5/UkGgffrlStfNGpIwetfu9Ulv4fdz0o3sM/wDpPm8Hsw
 twUfzY/AGfNjiY+JNFTY7iNFnLWwCRnnefHryU/UB2OWonBoKdpfhIaKX47Gz3f0LgsPJH
 hXaUH5Bw6qHA7yVE4CG9eeBteB2cZ/Vxx/AhngrU7ot2CL6cOfHkqzyiP/pD0RNO3VzCT9
 AHLgWKVVOktkkAikUuKQlCBxAhkY7hnNq9CZnMoH9ebJ+jbyvrCvtcs5rY4U9g==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Anand Gore <anand.gore@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 david regan <dregan@broadcom.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 01/24] mtd: rawnand: sunxi: cosmetic: remove needless comment
Date: Thu, 16 Oct 2025 16:27:24 +0200
Message-ID: <20251016142752.2627710-2-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016142752.2627710-1-richard.genoud@bootlin.com>
References: <20251016142752.2627710-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Remove 'complete' member from struct sunxi_nfc

The 'complete' member isn't part of the structure, let's remove it.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 1ce09b56b804..c6b9b2a4ebac 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -270,8 +270,6 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
  * @clk_rate:		NAND controller current clock rate
  * @chips:		a list containing all the NAND chips attached to
  *			this NAND controller
- * @complete:		a completion object used to wait for NAND
- *			controller events
  */
 struct sunxi_nfc {
 	struct nand_hw_control controller;
