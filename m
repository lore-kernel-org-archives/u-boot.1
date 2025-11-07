Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DB3CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 11:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F07483D3D;
	Fri,  7 Nov 2025 12:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CDF383D18; Fri,  7 Nov 2025 12:39:36 +0100 (CET)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::42ac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD59483D18
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 12:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d2xtD32DCzy4y;
 Fri,  7 Nov 2025 12:39:32 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d2xtC6MjczvPW; Fri,  7 Nov 2025 12:39:31 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 07 Nov 2025 12:39:18 +0100
Subject: [PATCH 2/3] rockchip: i2c: move ACK comment where it applies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-rk-i2c-illegal-v1-2-3e5fea13a899@cherry.de>
References: <20251107-rk-i2c-illegal-v1-0-3e5fea13a899@cherry.de>
In-Reply-To: <20251107-rk-i2c-illegal-v1-0-3e5fea13a899@cherry.de>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Wadim Egorov <w.egorov@phytec.de>, Vasily Khoruzhick <anarsoul@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The I2C_CON_LASTACK is kind of a misnomer as setting it means sending a
NACK as last byte acknowledge when the controller is in receive mode. It
should therefore be used only when there's no more data to transfer
after this.

Move the comment in the proper if block.

Sync the comment with the Linux kernel's while at it so it's more
explicit.

Fixes: 5deaa530280f ("rockchip: i2c: fix >32 byte reads")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/i2c/rk_i2c.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/rk_i2c.c b/drivers/i2c/rk_i2c.c
index fe09e75d3fb..3c44d0e65f5 100644
--- a/drivers/i2c/rk_i2c.c
+++ b/drivers/i2c/rk_i2c.c
@@ -195,13 +195,14 @@ static int rk_i2c_read(struct rk_i2c *i2c, uchar chip, uint reg, uint r_len,
 
 	while (bytes_remain_len) {
 		if (bytes_remain_len > RK_I2C_FIFO_SIZE) {
+			/*
+			 * The hw can read up to 32 bytes at a time. If we need
+			 * more than one chunk, send an ACK after the last byte
+			 * of the current chunk.
+			 */
 			con = I2C_CON_EN;
 			bytes_xferred = 32;
 		} else {
-			/*
-			 * The hw can read up to 32 bytes at a time. If we need
-			 * more than one chunk, send an ACK after the last byte.
-			 */
 			con = I2C_CON_EN | I2C_CON_LASTACK;
 			bytes_xferred = bytes_remain_len;
 		}

-- 
2.51.1

