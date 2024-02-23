Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44920C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 09:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C64E587ABC;
	Fri, 23 Feb 2024 10:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 336468786A; Fri, 23 Feb 2024 10:06:06 +0100 (CET)
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch
 [83.166.143.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5F1887653
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 10:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Th3yf422LzDpq;
 Fri, 23 Feb 2024 10:06:02 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Th3yf01Zkz3h; Fri, 23 Feb 2024 10:06:01 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 23 Feb 2024 10:05:48 +0100
Subject: [PATCH v2 01/16] rockchip: spi: rk_spi: do not write bytes when in
 read-only mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-rk3588-saradc-v2-1-11c046b7e94a@theobroma-systems.com>
References: <20240223-rk3588-saradc-v2-0-11c046b7e94a@theobroma-systems.com>
In-Reply-To: <20240223-rk3588-saradc-v2-0-11c046b7e94a@theobroma-systems.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The read-only mode is currently supported but only for 16b-aligned
buffers. For unaligned buffers, the last byte will be read in RW mode
right now, which isn't what is desired. Instead, let's put the
controller back into RO mode for that last byte and skip any write in
the xfer loop.

This is required for 3-wire SPI mode where PICO/POCI lanes are shorted
on HW level. This incidentally the recommended design for RK806 PMIC for
RK3588 products.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/spi/rk_spi.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/rk_spi.c b/drivers/spi/rk_spi.c
index 7de943356ad..c8694fdff95 100644
--- a/drivers/spi/rk_spi.c
+++ b/drivers/spi/rk_spi.c
@@ -453,8 +453,17 @@ static int rockchip_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	 * case of read-only transfers by using the full 16bits of each
 	 * FIFO element.
 	 */
-	if (!out)
+	if (!out) {
 		ret = rockchip_spi_16bit_reader(dev, &in, &len);
+		/*
+		 * If "in" isn't 16b-aligned, we need to send the last byte
+		 * ourselves. We however need to have the controller in RO mode
+		 * which differs from the default.
+		 */
+		clrsetbits_le32(&regs->ctrlr0,
+				TMOD_MASK << TMOD_SHIFT,
+				TMOD_RO << TMOD_SHIFT);
+	}
 
 	/* This is the original 8bit reader/writer code */
 	while (len > 0) {
@@ -465,12 +474,13 @@ static int rockchip_spi_xfer(struct udevice *dev, unsigned int bitlen,
 		rkspi_enable_chip(regs, true);
 
 		toread = todo;
-		towrite = todo;
+		/* Only write if we have something to write */
+		towrite = out ? todo : 0;
 		while (toread || towrite) {
 			u32 status = readl(&regs->sr);
 
 			if (towrite && !(status & SR_TF_FULL)) {
-				writel(out ? *out++ : 0, regs->txdr);
+				writel(*out++, regs->txdr);
 				towrite--;
 			}
 			if (toread && !(status & SR_RF_EMPT)) {
@@ -501,6 +511,10 @@ static int rockchip_spi_xfer(struct udevice *dev, unsigned int bitlen,
 		spi_cs_deactivate(dev, slave_plat->cs);
 
 	rkspi_enable_chip(regs, false);
+	if (!out)
+		clrsetbits_le32(&regs->ctrlr0,
+				TMOD_MASK << TMOD_SHIFT,
+				TMOD_TR << TMOD_SHIFT);
 
 	return ret;
 }

-- 
2.43.2

