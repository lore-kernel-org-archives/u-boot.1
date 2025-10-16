Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696ACCCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADE2983857;
	Thu, 16 Oct 2025 16:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="VA9mO0ya";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82CA383734; Thu, 16 Oct 2025 16:29:06 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 619FF8384E
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0F92D4E41104;
 Thu, 16 Oct 2025 14:29:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D23436062C;
 Thu, 16 Oct 2025 14:29:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 748AF102F2310; 
 Thu, 16 Oct 2025 16:28:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760624942; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=llUdRf+NPp9iYanjImz8/v+bBz/QavsTn82yZy7XNpA=;
 b=VA9mO0yau/+/o9ModHsrkoB+4JX5ZFPJmhU0zUv3bho0E1OB0GoNZ62yd8kdO77QU/BICd
 20KLEwL1XJyxK6DCwju1HMYwUwzlPCVt0jbT0oGIBgjWWLXqDnb5DU7bUM5015TVXCULLD
 Hi/25X6LFvQ4lG2H/JL9BgD5rF2K0qy9wV3aS0mvWmyXiBwRASq/xmUSlasZubGy3S1RE9
 ncBk6RuMO3BrD1yteECTN9Hp+CgXdfs7rnj2F07tOS/Y1cYQl8bnYJiiUUcEY0nR7CKo8a
 YJBVdlsTfpAoBiEQw1/cvEF4B+r//J7YQAq/ioaV3d3swQjJjBCrpbDF8rdbYw==
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
Subject: [PATCH 08/24] mtd: rawnand: sunxi: cosmetic: move ECC_ERR_CNT
 register offset in SoC caps
Date: Thu, 16 Oct 2025 16:27:31 +0200
Message-ID: <20251016142752.2627710-9-richard.genoud@bootlin.com>
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

ECC_ERR_CNT register offset moved in H616, so let's make it a SoC cap

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 3 ++-
 drivers/mtd/nand/raw/sunxi_nand.h | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 3f30077b3d15..359f6cdda08a 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -737,7 +737,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 		return 1;
 	}
 
-	ret = NFC_ECC_ERR_CNT(0, readl(nfc->regs + NFC_REG_ECC_ERR_CNT(0)));
+	ret = NFC_ECC_ERR_CNT(0, readl(nfc->regs + NFC_REG_ECC_ERR_CNT(nfc, 0)));
 
 	memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
 
@@ -1713,6 +1713,7 @@ static int sunxi_nand_probe(struct udevice *dev)
 
 static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.nstrengths = 9,
+	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 };
 
 static const struct udevice_id sunxi_nand_ids[] = {
diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index 80fbc8df0090..b961f2ef3bf2 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -41,7 +41,8 @@
 #define NFC_REG_ECC_CTL		0x0034
 #define NFC_REG_ECC_ST		0x0038
 #define NFC_REG_DEBUG		0x003C
-#define NFC_REG_ECC_ERR_CNT(x)	((0x0040 + (x)) & ~0x3)
+#define NFC_REG_A10_ECC_ERR_CNT	0x0040
+#define NFC_REG_ECC_ERR_CNT(nfc, x)	(((nfc)->caps->reg_ecc_err_cnt + (x)) & ~0x3)
 #define NFC_REG_USER_DATA(x)	(0x0050 + ((x) * 4))
 #define NFC_REG_SPARE_AREA	0x00A0
 #define NFC_REG_PAT_ID		0x00A4
@@ -158,9 +159,11 @@
  * for distinction between compatible strings.
  *
  * @nstrengths:		Number of element of ECC strengths array
+ * @reg_ecc_err_cnt:	ECC error counter register
  */
 struct sunxi_nfc_caps {
 	unsigned int nstrengths;
+	unsigned int reg_ecc_err_cnt;
 };
 
 #endif
