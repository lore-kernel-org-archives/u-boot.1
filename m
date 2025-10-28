Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC8BCCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 09:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A575483ACD;
	Tue, 28 Oct 2025 10:14:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="CA1XJnxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D633683AE4; Tue, 28 Oct 2025 10:14:24 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07AEA83ACA
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 10:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id B6A521A16F5;
 Tue, 28 Oct 2025 09:14:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8CB7C60704;
 Tue, 28 Oct 2025 09:14:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 99A3A102F4A63; Tue, 28 Oct 2025 10:14:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761642861; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=L805paAsADhmeTP+MKe80PJ6gHKIjNPLHH7GPF+AqCo=;
 b=CA1XJnxIRbwqFA+ZGMJvG0RXpAuz6jumSrBRlZSe2+qieGUONyigNeQ8YE/FlycULtUUnP
 Dk4XcukwEdsl5xY/ZzbkA2LvDk7YQarJ08CD6qHc7NzbtgGnoFYfbGsctUVM+B4N078Aik
 F5lDPogVqNcqPp+VTx/1FbFf8CaJfu0QecKTboLKNEoqi6Utlhh5xdZTi3dZgAlb9fTCT9
 HS0REfvMAgRbwQrvnV7ZiZchu/dzmn3cQAh6rVuHVn9eckvbpkTPkbMzNmAltyvU7Scx1s
 0sDfJMGOnIur1uRaJVDB/zV299PAE9iJptoRygjcZ/1RG9jy4Z8SzKgs+Touzg==
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
Subject: [PATCH v2 18/24] mtd: rawnand: sunxi_spl: increase max_oobsize for
 2KiB pages
Date: Tue, 28 Oct 2025 10:12:39 +0100
Message-ID: <20251028091256.600992-19-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028091256.600992-1-richard.genoud@bootlin.com>
References: <20251028091256.600992-1-richard.genoud@bootlin.com>
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

Increase max_oobsize to take into account bigger OOB on 2KiB pages

Some NAND chip (e.g. Kioxia TC58NVG1S3HTA00) have a 2KiB page size +
128 bytes OOB.
In order to detect them, the max_oobsize has to be increased from 64 to
128 bytes.

Tested on Kioxia TC58NVG1S3HTA00 NAND chip on Whatsminer H616 board.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 3f668e92728d..786c46254838 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -305,7 +305,7 @@ static int nand_max_ecc_strength(struct nfc_config *conf)
 	 */
 	switch (conf->page_size) {
 	case 2048:
-		max_oobsize = 64;
+		max_oobsize = 128;
 		break;
 	case 4096:
 		max_oobsize = 256;
-- 
2.47.3

