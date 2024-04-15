Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34205C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:09:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79D2A881F8;
	Mon, 15 Apr 2024 08:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C79B088206; Mon, 15 Apr 2024 08:08:14 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D593C88189
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4VHxYS4h2Sz9t2V;
 Mon, 15 Apr 2024 08:08:12 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zr2SA_PplQjQ; Mon, 15 Apr 2024 08:08:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4VHxYK2PJjz9t2s;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E9AF8B775;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id qORxg18MRGNa; Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2B9638B770;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>,
 DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>, florent.trinh-thai@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH v2 07/17] spi: mpc8xx: Fix transfert when input or output
 buffer is NULL
Date: Mon, 15 Apr 2024 08:07:20 +0200
Message-ID: <42dff816b493d4edd8a1fe5e6ab3c4071b447121.1713160866.git.christophe.leroy@csgroup.eu>
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

xfer ops can be passed a NULL input or output buffer. At the
time being the driver ignores it and overwrites memory at 0.

Define a dummy buffer and use it when either input or output
buffer is NULL. Bail out when both are NULL as it shouldn't.

Also increase MAX_BUFFER len to 32k as the current is pretty
low.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/spi/mpc8xx_spi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/mpc8xx_spi.c b/drivers/spi/mpc8xx_spi.c
index 5c8d760935..2aa9c7d5df 100644
--- a/drivers/spi/mpc8xx_spi.c
+++ b/drivers/spi/mpc8xx_spi.c
@@ -29,7 +29,7 @@
 #define CPM_SPI_BASE_RX	CPM_SPI_BASE
 #define CPM_SPI_BASE_TX	(CPM_SPI_BASE + sizeof(cbd_t))
 
-#define MAX_BUFFER	0x104
+#define MAX_BUFFER	0x8000 /* Max possible is 0xffff. We want power of 2 */
 
 struct mpc8xx_priv {
 	spi_t __iomem *spi;
@@ -37,6 +37,8 @@ struct mpc8xx_priv {
 	int max_cs;
 };
 
+static char dummy_buffer[MAX_BUFFER];
+
 static int mpc8xx_spi_set_mode(struct udevice *dev, uint mod)
 {
 	return 0;
@@ -154,6 +156,8 @@ static int mpc8xx_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	int tm;
 	size_t count = (bitlen + 7) / 8;
 
+	if (!din && !dout)
+		return -EINVAL;
 	if (count > MAX_BUFFER)
 		return -EINVAL;
 
@@ -165,12 +169,12 @@ static int mpc8xx_spi_xfer(struct udevice *dev, unsigned int bitlen,
 		mpc8xx_spi_cs_activate(dev);
 
 	/* Setting tx bd status and data length */
-	out_be32(&tbdf->cbd_bufaddr, (ulong)dout);
+	out_be32(&tbdf->cbd_bufaddr, dout ? (ulong)dout : (ulong)dummy_buffer);
 	out_be16(&tbdf->cbd_sc, BD_SC_READY | BD_SC_LAST | BD_SC_WRAP);
 	out_be16(&tbdf->cbd_datlen, count);
 
 	/* Setting rx bd status and data length */
-	out_be32(&rbdf->cbd_bufaddr, (ulong)din);
+	out_be32(&rbdf->cbd_bufaddr, din ? (ulong)din : (ulong)dummy_buffer);
 	out_be16(&rbdf->cbd_sc, BD_SC_EMPTY | BD_SC_WRAP);
 	out_be16(&rbdf->cbd_datlen, 0);	 /* rx length has no significance */
 
-- 
2.43.0

