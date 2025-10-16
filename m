Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E26CCD195
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A57EE83771;
	Thu, 16 Oct 2025 16:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Ts+BX31P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE2583734; Thu, 16 Oct 2025 16:28:49 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39B36837E4
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id E763F1A1433;
 Thu, 16 Oct 2025 14:28:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BCACD6062C;
 Thu, 16 Oct 2025 14:28:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 14B10102F231B; 
 Thu, 16 Oct 2025 16:28:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760624925; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=rmIqTba+UxEVs2nN54+MbGWcXmjM6jREfXyZuc19zZo=;
 b=Ts+BX31PwP9ErV6+7Ae4g46nr5Aklkdre/orRWURRtsquq5nIMyjlFuNqT+t3JKCfJAxv9
 mL/fb/X2EfB/meK8nq8HvYUwjBB94EmH6oYvrOE1ayyN8k3okwtMSXu9Yfrn7ls5fO7xbx
 oqpPksB+kZ00j2UrsknSm5dX8DlZ1EO795CYZeL4FN4r+3XRciZf37lHlLBtywSxTsY1Wk
 HQC2gKMzq+xnb5YKFT5DKSmOJj4FEKEGad66BxKjHcMWGVNfhXk//Lp1S8agf7OMmlgUoR
 ft5aYtyY6OCvNnQiWft0jJGfWTKv0EBzCcK7DjzrigQvtokhXjUsPejLCIVhOA==
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
Subject: [PATCH 04/24] mtd: rawnand: sunxi_spl: cosmetic: use definitions from
 linux/mtd/rawnand.h
Date: Thu, 16 Oct 2025 16:27:27 +0200
Message-ID: <20251016142752.2627710-5-richard.genoud@bootlin.com>
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

Remove unneeded definitions NFC_CMD_R* in sunxi_nand_spl.c

No need to define NFC_CMD_RNDOUTSTART, NFC_CMD_RNDOUT and
NFC_CMD_READSTART here since they are already in linux/mtd/rawnand.h

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 3ccf716b99ac..306c1c0d0989 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -62,10 +62,6 @@
 #define NFC_RND_READ_CMD0_OFFSET    8
 #define NFC_RND_READ_CMD1_OFFSET    16
 
-#define NFC_CMD_RNDOUTSTART        0xE0
-#define NFC_CMD_RNDOUT             0x05
-#define NFC_CMD_READSTART          0x30
-
 struct nfc_config {
 	int page_size;
 	int ecc_strength;
@@ -199,9 +195,9 @@ static int nand_load_page(const struct nfc_config *conf, u32 offs)
 {
 	int page = offs / conf->page_size;
 
-	writel((NFC_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
-	       (NFC_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
-	       (NFC_CMD_READSTART << NFC_READ_CMD_OFFSET),
+	writel((NAND_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
+	       (NAND_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
+	       (NAND_CMD_READSTART << NFC_READ_CMD_OFFSET),
 	       SUNXI_NFC_BASE + NFC_REG_RCMD_SET);
 	writel(((page & 0xFFFF) << 16), SUNXI_NFC_BASE + NFC_REG_ADDR_LOW);
 	writel((page >> 16) & 0xFF, SUNXI_NFC_BASE + NFC_REG_ADDR_HIGH);
@@ -215,15 +211,15 @@ static int nand_change_column(u16 column)
 {
 	int ret;
 
-	writel((NFC_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
-	       (NFC_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
-	       (NFC_CMD_RNDOUTSTART << NFC_READ_CMD_OFFSET),
+	writel((NAND_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
+	       (NAND_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
+	       (NAND_CMD_RNDOUTSTART << NFC_READ_CMD_OFFSET),
 	       SUNXI_NFC_BASE + NFC_REG_RCMD_SET);
 	writel(column, SUNXI_NFC_BASE + NFC_REG_ADDR_LOW);
 
 	ret = nand_exec_cmd(NFC_SEND_CMD1 | NFC_SEND_CMD2 | NFC_NORMAL_OP |
 			    (1 << NFC_ADR_NUM_OFFSET) | NFC_SEND_ADR |
-			    NFC_CMD_RNDOUT);
+			    NAND_CMD_RNDOUT);
 	if (ret)
 		return ret;
 
