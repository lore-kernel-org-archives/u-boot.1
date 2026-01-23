Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237E3D7236C
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA6F83B21;
	Fri, 23 Jan 2026 12:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="0z4gh2N8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A747B83B21; Fri, 23 Jan 2026 12:45:46 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 067BF8397D
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 90A8C4E42216;
 Fri, 23 Jan 2026 11:45:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 65F0B6070A;
 Fri, 23 Jan 2026 11:45:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 300F1119A87BF; Fri, 23 Jan 2026 12:45:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168742; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=yes95cjRqP3lVau+BHtP6QulD7sbtaA2NDEIlpwDnjc=;
 b=0z4gh2N8CqrIJ39qOvu429v+TBNH7HLbQZyVd3U61iw3mflZgvGROzbR7ceW3HCIWSlzTE
 IctfNPAb25PdsWaLSV934NzRPe+bgpKc1pRb4FwjmVpw0oOqYOFbtBU+PyWAU1G5oYscSD
 XPjIhuH+pfS0g88p5SqJFvDA8YI8CKyMy4ZC88z6xOqIBDYRgJAPyPOFOvWw04uBIJ6NGE
 rTMMOyDSjMBlRAvJ7kr3aPVvi+7OVC28TnRxecABdWhp47ZfkhnX8JYGjlz2lx85FxkH03
 EGkpkcJ42CxAtm0pCxRCV4ZJQmV78WehHhrRECDQtybF5n6ijfPgOvUUbuR/YQ==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v3 02/26] mtd: rawnand: sunxi_spl: fix pointer from integer
 without a cast
Date: Fri, 23 Jan 2026 12:44:37 +0100
Message-ID: <20260123114507.1400918-3-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123114507.1400918-1-richard.genoud@bootlin.com>
References: <20260123114507.1400918-1-richard.genoud@bootlin.com>
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
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 4f1e2d9a5775..4441990dd938 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -251,6 +251,15 @@ static int nand_change_column(u16 column)
 
 static const int ecc_bytes[] = {32, 46, 54, 60, 74, 88, 102, 110, 116};
 
+static void nand_readlcpy(u32 *dest, u32 * __iomem src, size_t len)
+{
+	/* NB: len should be multiple of 4 (32bits access) */
+	len >>= 2;
+
+	while (len--)
+		*dest++ = readl(src++);
+}
+
 static int nand_read_page(const struct nfc_config *conf, u32 offs,
 			  void *dest, int len)
 {
@@ -310,7 +319,8 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 			return 1;
 
 		/* Retrieve the data from SRAM */
-		memcpy_fromio(data, SUNXI_NFC_BASE + NFC_RAM0_BASE,
+		nand_readlcpy((u32 *)data,
+			      (void *)(uintptr_t)SUNXI_NFC_BASE + NFC_RAM0_BASE,
 			      conf->ecc_size);
 
 		/* Stop the ECC engine */
-- 
2.47.3

