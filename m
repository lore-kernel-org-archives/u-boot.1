Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B1FC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9246E88245;
	Mon, 15 Apr 2024 08:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF1188225; Mon, 15 Apr 2024 08:08:21 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 060B888195
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4VHxYb5j7Gz9t1J;
 Mon, 15 Apr 2024 08:08:19 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Qedpq8BOfiL; Mon, 15 Apr 2024 08:08:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4VHxYL04sPz9tC6;
 Mon, 15 Apr 2024 08:08:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EDE368B77A;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id jMTc3pCREOEi; Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D3CF18B770;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>,
 DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>, florent.trinh-thai@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH v2 14/17] spi: mpc8xx: Set up speed as requested
Date: Mon, 15 Apr 2024 08:07:27 +0200
Message-ID: <ccfa222beff47168bded2d05be8611644662eaf9.1713160866.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713160866.git.christophe.leroy@csgroup.eu>
References: <cover.1713160866.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Set the speed requested through mpc8xx_spi_set_speed() instead
of hardcoding a fixed speed.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/spi/mpc8xx_spi.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/mpc8xx_spi.c b/drivers/spi/mpc8xx_spi.c
index b1abfbf4fc..e1448cc619 100644
--- a/drivers/spi/mpc8xx_spi.c
+++ b/drivers/spi/mpc8xx_spi.c
@@ -48,6 +48,21 @@ static int mpc8xx_spi_set_mode(struct udevice *dev, uint mod)
 
 static int mpc8xx_spi_set_speed(struct udevice *dev, uint speed)
 {
+	immap_t __iomem *immr = (immap_t __iomem *)CONFIG_SYS_IMMR;
+	cpm8xx_t __iomem *cp = &immr->im_cpm;
+	u8 pm = (gd->arch.brg_clk - 1) / (speed * 16);
+
+	if (pm > 16) {
+		setbits_be16(&cp->cp_spmode, SPMODE_DIV16);
+		pm /= 16;
+		if (pm > 16)
+			pm = 16;
+	} else {
+		clrbits_be16(&cp->cp_spmode, SPMODE_DIV16);
+	}
+
+	clrsetbits_be16(&cp->cp_spmode, SPMODE_PM(0xf), SPMODE_PM(pm));
+
 	return 0;
 }
 
@@ -189,8 +204,8 @@ static int mpc8xx_spi_xfer_one(struct udevice *dev, size_t count,
 	out_be16(&rbdf->cbd_sc, BD_SC_EMPTY | BD_SC_WRAP);
 	out_be16(&rbdf->cbd_datlen, 0);	 /* rx length has no significance */
 
-	clrsetbits_be16(&cp->cp_spmode, ~SPMODE_LOOP, SPMODE_REV | SPMODE_MSTR |
-			SPMODE_EN | spmode_len | SPMODE_PM(0x8));
+	clrsetbits_be16(&cp->cp_spmode, ~(SPMODE_LOOP | SPMODE_PM(0xf) | SPMODE_DIV16),
+			SPMODE_REV | SPMODE_MSTR | SPMODE_EN | spmode_len);
 	out_8(&cp->cp_spim, 0);		/* Mask  all SPI events */
 	out_8(&cp->cp_spie, SPI_EMASK);	/* Clear all SPI events	*/
 
-- 
2.43.0

