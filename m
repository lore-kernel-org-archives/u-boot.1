Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ABFC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23B558823C;
	Mon, 15 Apr 2024 08:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A98088235; Mon, 15 Apr 2024 08:08:20 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F6B188220
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4VHxYZ2B3Kz9t2k;
 Mon, 15 Apr 2024 08:08:18 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uoIyM7iaR3rf; Mon, 15 Apr 2024 08:08:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4VHxYK6yQzz9tBG;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EAA2D8B778;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Twzc-gUS9N17; Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BB6F58B764;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>,
 DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>, florent.trinh-thai@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH v2 13/17] spi: mpc8xx: Use 16 bit mode for large transfers
 with even size
Date: Mon, 15 Apr 2024 08:07:26 +0200
Message-ID: <9195d08a754418254471b313d9390bc8773a163b.1713160866.git.christophe.leroy@csgroup.eu>
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

On CPM, the RISC core is a lot more efficiant when doing transfers
in 16-bits chunks than in 8-bits chunks, but unfortunately the
words need to be byte swapped.

So, for large tranfers with an even size, allocate a temporary
buffer and byte-swap data before and after transfer.

This change allows setting higher speed for transfer. For instance
on an MPC 8xx (CPM1 comms RISC processor), the documentation tells
that transfer in byte mode at 1 kbit/s uses 0.200% of CPM load
at 25 MHz while a word transfer at the same speed uses 0.032%
of CPM load. This means the speed can be 6 times higher in
word mode for the same CPM load.

For small transfers, the load reduction is not worth the CPU load
required to allocate the temporary buffer, so do it only when data
size is over 64 bytes.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/spi/mpc8xx_spi.c | 44 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/mpc8xx_spi.c b/drivers/spi/mpc8xx_spi.c
index a193ac711b..b1abfbf4fc 100644
--- a/drivers/spi/mpc8xx_spi.c
+++ b/drivers/spi/mpc8xx_spi.c
@@ -18,6 +18,7 @@
 
 #include <common.h>
 #include <dm.h>
+#include <malloc.h>
 #include <mpc8xx.h>
 #include <spi.h>
 #include <linux/delay.h>
@@ -30,6 +31,7 @@
 #define CPM_SPI_BASE_TX	(CPM_SPI_BASE + sizeof(cbd_t))
 
 #define MAX_BUFFER	0x8000 /* Max possible is 0xffff. We want power of 2 */
+#define MIN_HWORD_XFER	64	/* Minimum size for 16 bits transfer */
 
 struct mpc8xx_priv {
 	spi_t __iomem *spi;
@@ -149,23 +151,46 @@ static int mpc8xx_spi_xfer_one(struct udevice *dev, size_t count,
 	immap_t __iomem *immr = (immap_t __iomem *)CONFIG_SYS_IMMR;
 	cpm8xx_t __iomem *cp = &immr->im_cpm;
 	cbd_t __iomem *tbdf, *rbdf;
+	void *bufout, *bufin;
+	u16 spmode_len;
 	int tm;
 
 	tbdf = (cbd_t __iomem *)&cp->cp_dpmem[CPM_SPI_BASE_TX];
 	rbdf = (cbd_t __iomem *)&cp->cp_dpmem[CPM_SPI_BASE_RX];
 
+	if (!(count & 1) && count >= MIN_HWORD_XFER) {
+		spmode_len = SPMODE_LEN(16);
+		if (dout) {
+			int i;
+
+			bufout = malloc(count);
+			for (i = 0; i < count; i += 2)
+				*(u16 *)(bufout + i) = swab16(*(u16 *)(dout + i));
+		} else {
+			bufout = NULL;
+		}
+		if (din)
+			bufin = malloc(count);
+		else
+			bufin = NULL;
+	} else {
+		spmode_len = SPMODE_LEN(8);
+		bufout = (void *)dout;
+		bufin = din;
+	}
+
 	/* Setting tx bd status and data length */
-	out_be32(&tbdf->cbd_bufaddr, dout ? (ulong)dout : (ulong)dummy_buffer);
+	out_be32(&tbdf->cbd_bufaddr, bufout ? (ulong)bufout : (ulong)dummy_buffer);
 	out_be16(&tbdf->cbd_sc, BD_SC_READY | BD_SC_LAST | BD_SC_WRAP);
 	out_be16(&tbdf->cbd_datlen, count);
 
 	/* Setting rx bd status and data length */
-	out_be32(&rbdf->cbd_bufaddr, din ? (ulong)din : (ulong)dummy_buffer);
+	out_be32(&rbdf->cbd_bufaddr, bufin ? (ulong)bufin : (ulong)dummy_buffer);
 	out_be16(&rbdf->cbd_sc, BD_SC_EMPTY | BD_SC_WRAP);
 	out_be16(&rbdf->cbd_datlen, 0);	 /* rx length has no significance */
 
 	clrsetbits_be16(&cp->cp_spmode, ~SPMODE_LOOP, SPMODE_REV | SPMODE_MSTR |
-			SPMODE_EN | SPMODE_LEN(8) | SPMODE_PM(0x8));
+			SPMODE_EN | spmode_len | SPMODE_PM(0x8));
 	out_8(&cp->cp_spim, 0);		/* Mask  all SPI events */
 	out_8(&cp->cp_spie, SPI_EMASK);	/* Clear all SPI events	*/
 
@@ -188,6 +213,19 @@ static int mpc8xx_spi_xfer_one(struct udevice *dev, size_t count,
 	if (tm >= 1000)
 		return -ETIMEDOUT;
 
+	if (!(count & 1) && count > MIN_HWORD_XFER) {
+		if (dout)
+			free(bufout);
+		if (din) {
+			int i;
+
+			bufout = malloc(count);
+			for (i = 0; i < count; i += 2)
+				*(u16 *)(din + i) = swab16(*(u16 *)(bufin + i));
+			free(bufin);
+		}
+	}
+
 	return 0;
 }
 
-- 
2.43.0

