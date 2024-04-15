Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB2DC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABFF488225;
	Mon, 15 Apr 2024 08:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABB8B8821B; Mon, 15 Apr 2024 08:08:19 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0C7688195
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4VHxYY44qkz9t2V;
 Mon, 15 Apr 2024 08:08:17 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AUQ-S8JRL3Wa; Mon, 15 Apr 2024 08:08:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4VHxYK5xFWz9t9W;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C7F528B770;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id bhz4YfV5UEOQ; Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A43808B775;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>,
 DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>, florent.trinh-thai@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH v2 12/17] spi: mpc8xx: Allow transfer of more than MAX_BUFFER
 len
Date: Mon, 15 Apr 2024 08:07:25 +0200
Message-ID: <0779c545b260b6c2bf1d357f18cc98811e2dcce3.1713160866.git.christophe.leroy@csgroup.eu>
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

Perform multiple transfer of size MAX_BUFFER when the data to be
transferred is longer than MAX_BUFFER.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/spi/mpc8xx_spi.c | 48 ++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/mpc8xx_spi.c b/drivers/spi/mpc8xx_spi.c
index 0d142f12e9..a193ac711b 100644
--- a/drivers/spi/mpc8xx_spi.c
+++ b/drivers/spi/mpc8xx_spi.c
@@ -143,27 +143,17 @@ static void mpc8xx_spi_cs_deactivate(struct udevice *dev)
 	dm_gpio_set_value(&priv->gpios[platdata->cs], 0);
 }
 
-static int mpc8xx_spi_xfer(struct udevice *dev, unsigned int bitlen,
-			    const void *dout, void *din, unsigned long flags)
+static int mpc8xx_spi_xfer_one(struct udevice *dev, size_t count,
+			       const void *dout, void *din)
 {
 	immap_t __iomem *immr = (immap_t __iomem *)CONFIG_SYS_IMMR;
 	cpm8xx_t __iomem *cp = &immr->im_cpm;
 	cbd_t __iomem *tbdf, *rbdf;
 	int tm;
-	size_t count = (bitlen + 7) / 8;
-
-	if (!din && !dout)
-		return -EINVAL;
-	if (count > MAX_BUFFER)
-		return -EINVAL;
 
 	tbdf = (cbd_t __iomem *)&cp->cp_dpmem[CPM_SPI_BASE_TX];
 	rbdf = (cbd_t __iomem *)&cp->cp_dpmem[CPM_SPI_BASE_RX];
 
-	/* Set CS for device */
-	if (flags & SPI_XFER_BEGIN)
-		mpc8xx_spi_cs_activate(dev);
-
 	/* Setting tx bd status and data length */
 	out_be32(&tbdf->cbd_bufaddr, dout ? (ulong)dout : (ulong)dummy_buffer);
 	out_be16(&tbdf->cbd_sc, BD_SC_READY | BD_SC_LAST | BD_SC_WRAP);
@@ -196,13 +186,43 @@ static int mpc8xx_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	}
 
 	if (tm >= 1000)
-		printf("*** spi_xfer: Time out while xferring to/from SPI!\n");
+		return -ETIMEDOUT;
+
+	return 0;
+}
 
+static int mpc8xx_spi_xfer(struct udevice *dev, unsigned int bitlen,
+			   const void *dout, void *din, unsigned long flags)
+{
+	size_t count = (bitlen + 7) / 8;
+	size_t offset = 0;
+	int ret = 0;
+
+	if (!din && !dout)
+		return -EINVAL;
+
+	/* Set CS for device */
+	if (flags & SPI_XFER_BEGIN)
+		mpc8xx_spi_cs_activate(dev);
+
+	while (count > 0 && !ret) {
+		size_t chunk = min(count, (size_t)MAX_BUFFER);
+		const void *out = dout ? dout + offset : NULL;
+		void *in = din ? din + offset : NULL;
+
+		ret = mpc8xx_spi_xfer_one(dev, chunk, out, in);
+
+		offset += chunk;
+		count -= chunk;
+	}
 	/* Clear CS for device */
 	if (flags & SPI_XFER_END)
 		mpc8xx_spi_cs_deactivate(dev);
 
-	return 0;
+	if (ret)
+		printf("*** spi_xfer: Time out while xferring to/from SPI!\n");
+
+	return ret;
 }
 
 static int mpc8xx_spi_ofdata_to_platdata(struct udevice *dev)
-- 
2.43.0

