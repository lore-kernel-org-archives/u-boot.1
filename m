Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE48CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 09:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED03283A3A;
	Tue, 28 Oct 2025 10:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="HWsvnpos";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7888383A1E; Tue, 28 Oct 2025 10:13:31 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B2EE839CC
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 10:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id CACD14E41392;
 Tue, 28 Oct 2025 09:13:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9E6F6606AB;
 Tue, 28 Oct 2025 09:13:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 140ED102F48E4; Tue, 28 Oct 2025 10:13:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761642807; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6lu9ILJTvfArXjTu1hv+uX710fiGdLRqbrSSrwB39HE=;
 b=HWsvnposAeET3XRCeRD7vUe72yjbbmw0OdFd/l1oSDweGCkeArCrXuiT0eh/DyVJv4xCwI
 08xblTq0U7ygDFpnlPfMWbkUBy1UFpSgg0KjK7BDBONPHb7xZEg+PH4BhjlIUto+du8kjq
 nzA+Pua1oB4nTsPbTAx5HoBb19uK3GQfPSBP8yBVOiP3CbpD47khrMRdv5meTNJcBxr9Hp
 5RXIIfgwxlLpr2U6DyQwrsA5d4Q4tidMOvsxJSbs3Rhc+L3H940/T4VwmC+Y2YnJSd23jN
 r9l8Fq9UpuQUzZ5//yOxKVG5UkNNfOeAW3k3DlS9A6owBEMytvE32t9Y9F9fHg==
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
Subject: [PATCH v2 02/24] mtd: rawnand: sunxi_spl: fix pointer from integer
 without a cast
Date: Tue, 28 Oct 2025 10:12:23 +0100
Message-ID: <20251028091256.600992-3-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028091256.600992-1-richard.genoud@bootlin.com>
References: <20251028091256.600992-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fix pointer from interget warning when compiling for ARM64

When compiling for arm64, we get this error:
error: passing argument 2 of ‘__memcpy_fromio’ makes pointer from
			integer without a cast [-Wint-conversion]

Moreover the copy should be made with dedicated readl(), like for any
register access on this peripheral, since they are 32bit wide.

So, instead of memcpy_fromio(), just use a readl() loop.
Introduce nand_readlcpy() to implement this loop.

Fixes: 6ddbb1e936c7 ("spl: nand: sunxi: use PIO instead of DMA")
Suggested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 4f1e2d9a5775..a15f54573df2 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -251,6 +251,17 @@ static int nand_change_column(u16 column)
 
 static const int ecc_bytes[] = {32, 46, 54, 60, 74, 88, 102, 110, 116};
 
+static void nand_readlcpy(u32 *dest, u32 * __iomem src, size_t len)
+{
+	if (len & 0x3)
+		printf("length should be multiple of 4 (32bits access), data will be incomplete.\n");
+
+	len >>= 2;
+
+	while (len--)
+		*dest++ = readl(src++);
+}
+
 static int nand_read_page(const struct nfc_config *conf, u32 offs,
 			  void *dest, int len)
 {
@@ -310,7 +321,8 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 			return 1;
 
 		/* Retrieve the data from SRAM */
-		memcpy_fromio(data, SUNXI_NFC_BASE + NFC_RAM0_BASE,
+		nand_readlcpy((u32 *)data,
+			      (void *)(uintptr_t)SUNXI_NFC_BASE + NFC_RAM0_BASE,
 			      conf->ecc_size);
 
 		/* Stop the ECC engine */
-- 
2.47.3

