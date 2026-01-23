Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7215CD7237B
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 306AA83BF1;
	Fri, 23 Jan 2026 12:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="RPd5JtxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BC3E83BE1; Fri, 23 Jan 2026 12:46:06 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A65AC83B97
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 94FB3C21ABE;
 Fri, 23 Jan 2026 11:46:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5C0B56070A;
 Fri, 23 Jan 2026 11:46:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 60A4A119A87C2; Fri, 23 Jan 2026 12:45:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168762; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=s0Cq0b4BAkWSpFihEj09Q0tvVHFZfGZ1TY9I8k2p4Qc=;
 b=RPd5JtxARk+6d1MHFtZdcgJ5GqoSEmfnL8A4bf9Le4B5UMe0/Jhv7cwhfDbPIpor2M2LZ+
 jBPpwr5WqxGeq1LSHD94Hr5eUwqtPLt1Pxmlp4hqFRJwdCLgkuM3i/WrOsaakBDmIrC49o
 egB+TB/BhkYvzwduO8geym8GhT0/jM5djsEcX/silUqwhfinhqOOUj0gEE64lOVsu2Wxdu
 iZ4qX60Xi0LshMmmUG96PqzYJu9JBA3kqEvQQ6/MOm3eh7tYRK2Hi5PPEIHvm01q/hQx13
 ezruz5NcmC397xqEX6P2WB/yt1FSLnNL1t1eD1W0ZkK9gaw+r1iXaKB2IxxpzQ==
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
Subject: [PATCH v3 09/26] mtd: rawnand: sunxi: move USER_DATA register offset
 in SoC caps
Date: Fri, 23 Jan 2026 12:44:44 +0100
Message-ID: <20260123114507.1400918-10-richard.genoud@bootlin.com>
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

USER_DATA register offset moved in H616, so let's make it a SoC cap

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 7 ++++---
 drivers/mtd/nand/raw/sunxi_nand.h | 5 ++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 6699a577958f..942789569e18 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -766,7 +766,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 		 * Retrieve the corrected OOB bytes.
 		 */
 		sunxi_nfc_user_data_to_buf(readl(nfc->regs +
-						 NFC_REG_USER_DATA(0)),
+						 NFC_REG_USER_DATA(nfc, 0)),
 					   oob);
 
 		/* De-randomize the Bad Block Marker. */
@@ -837,10 +837,10 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 		memcpy(user_data, oob, 4);
 		sunxi_nfc_randomize_bbm(mtd, page, user_data);
 		writel(sunxi_nfc_buf_to_user_data(user_data),
-		       nfc->regs + NFC_REG_USER_DATA(0));
+		       nfc->regs + NFC_REG_USER_DATA(nfc, 0));
 	} else {
 		writel(sunxi_nfc_buf_to_user_data(oob),
-		       nfc->regs + NFC_REG_USER_DATA(0));
+		       nfc->regs + NFC_REG_USER_DATA(nfc, 0));
 	}
 
 	if (data_off + ecc->size != oob_off)
@@ -1713,6 +1713,7 @@ static int sunxi_nand_probe(struct udevice *dev)
 static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.nstrengths = 9,
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
+	.reg_user_data = NFC_REG_A10_USER_DATA,
 };
 
 static const struct udevice_id sunxi_nand_ids[] = {
diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index b961f2ef3bf2..1977d1bd8eaf 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -43,7 +43,8 @@
 #define NFC_REG_DEBUG		0x003C
 #define NFC_REG_A10_ECC_ERR_CNT	0x0040
 #define NFC_REG_ECC_ERR_CNT(nfc, x)	(((nfc)->caps->reg_ecc_err_cnt + (x)) & ~0x3)
-#define NFC_REG_USER_DATA(x)	(0x0050 + ((x) * 4))
+#define NFC_REG_A10_USER_DATA	0x0050
+#define NFC_REG_USER_DATA(nfc, x)	((nfc)->caps->reg_user_data + ((x) * 4))
 #define NFC_REG_SPARE_AREA	0x00A0
 #define NFC_REG_PAT_ID		0x00A4
 #define NFC_RAM0_BASE		0x0400
@@ -160,10 +161,12 @@
  *
  * @nstrengths:		Number of element of ECC strengths array
  * @reg_ecc_err_cnt:	ECC error counter register
+ * @reg_user_data:	User data register
  */
 struct sunxi_nfc_caps {
 	unsigned int nstrengths;
 	unsigned int reg_ecc_err_cnt;
+	unsigned int reg_user_data;
 };
 
 #endif
-- 
2.47.3

