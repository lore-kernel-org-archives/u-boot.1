Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2832AF41807
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D93D683FD9;
	Mon,  9 Mar 2026 16:23:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="nZj5XBeo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDA3783BC8; Mon,  9 Mar 2026 16:23:08 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCAF283FA3
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 053B91A2D82
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 15:23:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D04965FFB8;
 Mon,  9 Mar 2026 15:23:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1E00310369BFC; Mon,  9 Mar 2026 16:23:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773069783; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=9QLKowyY578g63F0Ab650p/jnUXnEVMxYAtikV/S6x8=;
 b=nZj5XBeon1HIESgnWG8TDrCPcQPGNEG2sPgKGLXa68WRaCFNSp3zlPClh81d92DIBX4LM2
 nsgr0aG2vPnYR2b+KPpkkk3g7bxKgdTKkhFodHFVV0FnTR5TcrlTmajZANFCI8mlnC3va9
 SObOPZeLuH2bNavCN4cr4gkBfMksnLB+ezyZ5lYBg834Vys+kexNDPCqziTF0h3WnRi88Y
 hWmbl/cTtxs1PwaERzdD+81A8FGF39a4FwLIj+VV33w+QlJxkKUVaqjzthpoFGeqqW7QXO
 CjcPciHy7/lZZgKz1f1lSAeJbHdMYjjGnOTOf7+/BJDAJVPVCD/QynkFyBsFHw==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 4/4] mtd: nand: raw: sunxi_spl: remove user data length reset
Date: Mon,  9 Mar 2026 16:22:51 +0100
Message-ID: <20260309152251.70837-5-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309152251.70837-1-richard.genoud@bootlin.com>
References: <20260309152251.70837-1-richard.genoud@bootlin.com>
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

No need to reset user data length registers in SPL.

In SPL, only the first user data length register is used, so we don't
need to reset all of them.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 7dd7a7b44427..2497a964b1ee 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -225,22 +225,6 @@ static int nand_change_column(u16 column)
 	return 0;
 }
 
-/*
- * On H6/H616 the user_data length has to be set in specific registers
- * before writing.
- */
-static void sunxi_nfc_reset_user_data_len(const struct nfc_config *nfc)
-{
-	int loop_step = NFC_REG_USER_DATA_LEN_CAPACITY;
-
-	/* not all SoCs have this register */
-	if (!NFC_REG_USER_DATA_LEN(nfc, 0))
-		return;
-
-	for (int i = 0; i < nfc->caps->max_ecc_steps; i += loop_step)
-		writel_nfc(0, NFC_REG_USER_DATA_LEN(nfc, i));
-}
-
 static void sunxi_nfc_set_user_data_len(const struct nfc_config *nfc,
 					int len, int step)
 {
@@ -348,7 +332,6 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 		 */
 		nand_change_column(oob_off);
 
-		sunxi_nfc_reset_user_data_len(conf);
 		sunxi_nfc_set_user_data_len(conf, user_data_sz, nfc_step);
 
 		nand_exec_cmd(NFC_DATA_TRANS | NFC_ECC_OP);
