Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AB4CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 11:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B6E783D62;
	Fri,  7 Nov 2025 12:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BFD183D3D; Fri,  7 Nov 2025 12:39:36 +0100 (CET)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4120483D28
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 12:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d2xtD6vc0zw5c;
 Fri,  7 Nov 2025 12:39:32 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d2xtD2vzcz9sD; Fri,  7 Nov 2025 12:39:32 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 07 Nov 2025 12:39:19 +0100
Subject: [PATCH 3/3] rockchip: i2c: fix illegal I2C START/STOP condition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-rk-i2c-illegal-v1-3-3e5fea13a899@cherry.de>
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

In the last message sent in rockchip_i2c_xfer, the controller is
disabled (see rk_i2c_disable() in rk_i2c_read()/rk_i2c_write()), then
the STOP condition is sent (see rk_i2c_send_stop_bit() in
rockchip_i2c_xfer()) and the controller is disabled once again (see
rk_i2c_disable() right after).

The issue is that re-enabling the controller just to send the STOP
condition doesn't work. When, the controller is disabled, the SCL and
SDA lanes are not driven anymore and thus enter the idle mode where they
are kept high by the external HW pull-up. To send a STOP condition, one
needs to drive the SDA line so that a rising edge happens while SCL is
high. Experimentally (on PX30 and RK3399), when enabling the controller
to send a STOP condition after it's been disabled, the controller only
drives the SDA line to trigger the rising edge for the STOP condition,
leaving SCL undriven (and thus, high). This means, that because SDA is
high before this happens and that we need a rising edge, the controller
drives the SDA line low and then releases it, meaning we trigger a START
condition followed by a STOP condition:

SCL
        _________
_____...
        __  _____
_____...  \/
SDA
	    ^ STOP
	  ^ START

This is illegal in I2C protocol[1]:

 5. A START condition immediately followed by a STOP condition (void
    message) is an illegal format. Many devices however are designed to
    operate properly under this condition.

My guess is that the I2C controller IP knows that it makes only sense to
send a STOP condition after a START condition, meaning the controller is
already driving the SCL line low and neither the device nor controller
drive the SDA line after the last ACK/NACK as there's no need to, then
it needs to drive SDA, release SCL to make it high and then release the
SDA line. However, after it's been disabled, the SCL is already released
so the controller only essentially drives SDA and then releases it.

It happens that this seems to be breaking the SE050 Secure Element after
a few transfers in the middle of a transfer where it starts clock
stretching the bus forever. It may be related to Errata 3.2[2] but the
description of the setup isn't an exact match to the current situation.

It seems to be required to disable the I2C controller between messages
as the Linux kernel states that "The HW is actually not capable of
REPEATED START. But we can get the intended effect by resetting its
internal state and issuing an ordinary START.". Between messages, this
logic seems fine as I get an Sr (repeated START condition) before
starting the next message in the transfer without a STOP condition.
However, we should NOT disable the controller after the last message in
the transfer otherwise we do this illegal START condition followed by
the STOP condition, hence the added check.

[1] https://www.nxp.com/docs/en/user-guide/UM10204.pdf 3.1.10 The target address and R/W bit point 5
[2] https://www.nxp.com/docs/en/errata/SE050_Erratasheet.pdf

Fixes: c9fca5ec8849 ("rockchip: i2c: don't sent stop bit after each message")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/i2c/rk_i2c.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/rk_i2c.c b/drivers/i2c/rk_i2c.c
index 3c44d0e65f5..def07018148 100644
--- a/drivers/i2c/rk_i2c.c
+++ b/drivers/i2c/rk_i2c.c
@@ -255,8 +255,6 @@ static int rk_i2c_read(struct rk_i2c *i2c, uchar chip, uint reg, uint r_len,
 	}
 
 i2c_exit:
-	rk_i2c_disable(i2c);
-
 	return err;
 }
 
@@ -333,8 +331,6 @@ static int rk_i2c_write(struct rk_i2c *i2c, uchar chip, uint reg, uint r_len,
 	}
 
 i2c_exit:
-	rk_i2c_disable(i2c);
-
 	return err;
 }
 
@@ -359,6 +355,18 @@ static int rockchip_i2c_xfer(struct udevice *bus, struct i2c_msg *msg,
 			ret = -EREMOTEIO;
 			break;
 		}
+
+		/*
+		 * The HW is actually not capable of REPEATED START. But we can
+		 * get the intended effect by resetting its internal state
+		 * and issuing an ordinary START.
+		 *
+		 * Do NOT disable the controller after the last message (before
+		 * sending the STOP condition) as this triggers an illegal
+		 * START condition followed by a STOP condition.
+		 */
+		if (nmsgs > 1)
+			rk_i2c_disable(i2c);
 	}
 
 	rk_i2c_send_stop_bit(i2c);

-- 
2.51.1

