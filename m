Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E464CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 11:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBDFC83CB1;
	Fri,  7 Nov 2025 12:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22B4E83D39; Fri,  7 Nov 2025 12:39:34 +0100 (CET)
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8fac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 355FF83D13
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 12:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d2xtC6Vl2zw80;
 Fri,  7 Nov 2025 12:39:31 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d2xtC1djmzvnM; Fri,  7 Nov 2025 12:39:31 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 07 Nov 2025 12:39:17 +0100
Subject: [PATCH 1/3] rockchip: i2c: fix incorrect STOP flag for the
 interrupt enable register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-rk-i2c-illegal-v1-1-3e5fea13a899@cherry.de>
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

I2C_CON_STOP is a flag to be used for the con register, where it is bit
4 to send the STOP condition.

To enable the interrupt the controller sends to tell it's finished
sending the STOP condition, it's the ien register at bit 5.

Let's use the proper offset.

My hunch is that enabling the interrupt is useless as the interrupt
status register is always up-to-date and enabling the interrupt is just
so that the interrupt is available via the GIC. However, U-Boot has no
interrupt support and the logic was working well before this patch. This
is just so people aren't side-tracked when debugging I2C issues on
Rockchip by checking all writes are proper.

Fixes: 3437469985df ("rockchip: Add I2C driver")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/i2c/rk_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/rk_i2c.c b/drivers/i2c/rk_i2c.c
index fa167268ae7..fe09e75d3fb 100644
--- a/drivers/i2c/rk_i2c.c
+++ b/drivers/i2c/rk_i2c.c
@@ -137,7 +137,7 @@ static int rk_i2c_send_stop_bit(struct rk_i2c *i2c)
 	writel(I2C_IPD_ALL_CLEAN, &regs->ipd);
 
 	writel(I2C_CON_EN | I2C_CON_STOP, &regs->con);
-	writel(I2C_CON_STOP, &regs->ien);
+	writel(I2C_STOPIEN, &regs->ien);
 
 	start = get_timer(0);
 	while (1) {

-- 
2.51.1

