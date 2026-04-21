Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167EDEA71BA
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 04:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C63483FFA;
	Tue, 21 Apr 2026 06:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EABCD8419C; Tue, 21 Apr 2026 06:48:13 +0200 (CEST)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A704980433
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 06:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.124.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id E8773342020;
 Tue, 21 Apr 2026 04:48:05 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 21 Apr 2026 04:47:50 +0000
Subject: [PATCH] spi: sunxi: wait for TX/RX fifo reset done
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-02-spi-fifo-reset-v1-1-e2cdd4bd474d@gentoo.org>
X-B4-Tracking: v=1; b=H4sIAHUB52kC/x3MPQqAMAxA4auUzAba1B/wKuIgmmqWtjQignh3i
 +M3vPeAchFWGM0DhS9RSbHCNQbWY4k7o2zVQJZ6S2TREmoWDBISFlY+kTr2g/OuXX2A2uXCQe7
 /Oc3v+wH0nO7WYwAAAA==
X-Change-ID: 20260220-02-spi-fifo-reset-25e371314c3f
To: u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1942; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=HQ8gi3qkGDAytzDkMpwdgUvUWfOgiVivh5rYb7fjdrc=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBp5wGChkbAlN8OK0lV/mPLuSACAPd5BqFV5zmzk
 BGA+AoKQdaJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaecBghsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1x0Q/9HaxhtYzaHKO+PAlwGgyrBOrOKnyX2nQ3WozR0ltqr125Hau+SRAPq
 9OCVmvKUpxbmx6IqB772GfabuVrr9F7GkRL1NHRCCB/gdj40B408YzYRc1vsK/4/xDlLEvEyZx4
 9yEuMHvlrJCqACl9zfGVFzCHxurbmxWhIvo2O25DqPt+zON0SLB1QHnmZDLSyVn46EOKSAIxI6g
 ltMAucSg6UUKg9AIMbmjg/nJ9EG5kRbRKZcpWvGOvX8hvllsQIOu5W9CYGsheQbrmHdSgOH87Qc
 1y1zp1MypRdmf14BKNYpyUxmpX0oDiw+uD2Y/W7UEiDtsSVueQsnofySASUwRn1ecFx+5Ex3QP/
 l8vjSDWpFxnUIVNKWFeA5tkmRRTdxQJyCXvRtbrJiYeaSPkWxnv9ICEHeoNTRt5DUYFRJydAfW5
 GlYQNOWt1NAQgu92ujg9Z772WNwq4x1ga6jSVwvD/TC+oa2yNk2MGPxCTfGNIhnFCzxHueIHUgh
 4DVMBYgdZmH7OqasNZi+QrUV16BuqFua3xLGW2np9sZOFvaV2djNTXr70fgHoOogKp0S3Pa4Gx0
 0j2gDBVX7c1GJeGh11e1D+t8b14nCxTcDiwzxpPeMRfPqD1A3PrxV45DoYixZgUxp7zD2hvzk+L
 piQzVEb2hRRBPeKLo4cu+1gkjeWoF0=
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Once reset SPI TX or RX fifo, the underlying hardware need to take
some time to actually settle down, the two bits will automatically
clear to 0, so use a poll mechanism to check status bits to make sure
it's done correctly.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
On Cubie A7A board which using A733 SoC, we encoutered a SPI nor flash
timeout issue, it turns out that the SPI fifo reset take a few time to
settle down, Add a loop to poll the status.

This was the error message shows on A7A board once this issue happened.

=> sf probe
ERROR: sun4i_spi: Timeout transferring data
Failed to initialize SPI flash at 0:0 (error -2)
---
 drivers/spi/spi-sunxi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
index e00532a371b..cf41905c7b7 100644
--- a/drivers/spi/spi-sunxi.c
+++ b/drivers/spi/spi-sunxi.c
@@ -347,7 +347,7 @@ static int sun4i_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	struct sun4i_spi_priv *priv = dev_get_priv(bus);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 
-	u32 len = bitlen / 8;
+	u32 rst, val, len = bitlen / 8;
 	u8 nbytes;
 	int ret;
 
@@ -363,8 +363,11 @@ static int sun4i_spi_xfer(struct udevice *dev, unsigned int bitlen,
 		sun4i_spi_set_cs(bus, slave_plat->cs[0], true);
 
 	/* Reset FIFOs */
-	setbits_le32(SPI_REG(priv, SPI_FCR), SPI_BIT(priv, SPI_FCR_RF_RST) |
-		     SPI_BIT(priv, SPI_FCR_TF_RST));
+	rst = SPI_BIT(priv, SPI_FCR_RF_RST) | SPI_BIT(priv, SPI_FCR_TF_RST);
+	setbits_le32(SPI_REG(priv, SPI_FCR), rst);
+	ret = readl_poll_timeout(SPI_REG(priv, SPI_FCR), val, !(rst & val), 20);
+	if (ret)
+		return -EBUSY;
 
 	while (len) {
 		/* Setup the transfer now... */

---
base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
change-id: 20260220-02-spi-fifo-reset-25e371314c3f

Best regards,
-- 
Yixun Lan <dlan@gentoo.org>

