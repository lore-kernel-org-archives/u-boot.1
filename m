Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041BBD7237B
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF7BF83B82;
	Fri, 23 Jan 2026 12:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="N8TSSnGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB3DD83C14; Fri, 23 Jan 2026 12:46:16 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5126483B63
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 40CA8C20308;
 Fri, 23 Jan 2026 11:46:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 061716070A;
 Fri, 23 Jan 2026 11:46:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D5CB3119A87C9; Fri, 23 Jan 2026 12:46:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168773; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=5EIhSBMP63aH7QPsDS9/KFiOoTRh/i2w9ozvieqmCYU=;
 b=N8TSSnGGrcf1BArPcCymsjtULg207KWASQjqEVNqcl0tJlO+7bmGlNltrZ7sVRv6GZ7Euy
 VFlUnrWH/OLk1ZQVYso4O8MAc3SpY352ceYcEEyRkYImiBASMM2qUSGSGytqXOI0e5d7hf
 qCX+7d6OMkfadi72RM2vy/CbIpB5BAtpz9lS7NdD6TsBfOwdpRXfqA10J8Od0DonQ99Ier
 vdQsweBgF1kZiZMj/vr6R1v+NY0y9KqC69/Tjg8KoL19SFoI+qmZeVSoS/9Y2NxtG11enr
 d2TXT9s+nM51hXw3BUF0w0ZMN+QwjMS/M1SpQd8Cr2GT5dQtJuRvKERpreO/QQ==
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
Subject: [PATCH v3 13/26] mtd: rawnand: sunxi: introduce reg_pat_id in
 sunxi_nfc_caps
Date: Fri, 23 Jan 2026 12:44:48 +0100
Message-ID: <20260123114507.1400918-14-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123114507.1400918-1-richard.genoud@bootlin.com>
References: <20260123114507.1400918-1-richard.genoud@bootlin.com>
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

Introduce NDFC Pattern ID Register in capability structure

The H6/H616 pattern ID register is not at the same offset as the
A10/A23 one, so move its offset into sunxi_nfc_caps.

No functional change.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 3 ++-
 drivers/mtd/nand/raw/sunxi_nand.h | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index c5efafa2414c..c032cabb4dc9 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -731,7 +731,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	if (pattern_found & NFC_ECC_PAT_FOUND(0)) {
 		u8 pattern = 0xff;
 
-		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID) & 0x1)))
+		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & 0x1)))
 			pattern = 0x0;
 
 		memset(data, pattern, ecc->size);
@@ -1727,6 +1727,7 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
 	.reg_pat_found = NFC_REG_ECC_ST,
+	.reg_pat_id = NFC_REG_A10_PAT_ID,
 	.pat_found_mask = GENMASK(31, 16),
 	.ecc_mode_mask = GENMASK(15, 12),
 };
diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index 3b155b0c8f3e..e18feb77c93c 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -50,7 +50,8 @@
 #define NFC_REG_A10_USER_DATA	0x0050
 #define NFC_REG_USER_DATA(nfc, x)	((nfc)->caps->reg_user_data + ((x) * 4))
 #define NFC_REG_SPARE_AREA	0x00A0
-#define NFC_REG_PAT_ID		0x00A4
+#define NFC_REG_PAT_ID(nfc)	((nfc)->caps->reg_pat_id)
+#define NFC_REG_A10_PAT_ID	0x00A4
 #define NFC_RAM0_BASE		0x0400
 #define NFC_RAM1_BASE		0x0800
 
@@ -173,6 +174,7 @@
  * @nstrengths:		Number of element of ECC strengths array
  * @reg_ecc_err_cnt:	ECC error counter register
  * @reg_user_data:	User data register
+ * @reg_pat_id:		Pattern ID Register
  * @reg_pat_found:	Data Pattern Status Register
  * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
  * @ecc_mode_mask:	ECC_MODE mask in NFC_ECC_CTL register
@@ -182,6 +184,7 @@ struct sunxi_nfc_caps {
 	unsigned int nstrengths;
 	unsigned int reg_ecc_err_cnt;
 	unsigned int reg_user_data;
+	unsigned int reg_pat_id;
 	unsigned int reg_pat_found;
 	unsigned int pat_found_mask;
 	unsigned int ecc_mode_mask;
-- 
2.47.3

