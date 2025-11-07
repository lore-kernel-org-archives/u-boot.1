Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D1BCCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 11:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10BE383D1A;
	Fri,  7 Nov 2025 12:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7562D83D13; Fri,  7 Nov 2025 12:39:34 +0100 (CET)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch
 [83.166.143.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD41983B8B
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 12:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d2xtC1kNZzw7y;
 Fri,  7 Nov 2025 12:39:31 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d2xtB2SQMzx67; Fri,  7 Nov 2025 12:39:30 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/3] rockchip: i2c: fix illegal I2C format
Date: Fri, 07 Nov 2025 12:39:16 +0100
Message-Id: <20251107-rk-i2c-illegal-v1-0-3e5fea13a899@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBtQqYyuEi38GWtILBQiiO6et
 PwW7z1QKDMVmJoHMl1c+EgVsm3AbSathOyrQQnVSyk05h1ZOeQYaTURKejgbWfHcfBQozNT4Ps
 fzsv7fsk+ngZgAAAA
X-Change-ID: 20251107-rk-i2c-illegal-ef7fdb4b886d
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

This fixes an illegal I2C format of a START condition immediately
followed by a STOP condition which is illegal in the I2C protocol[1].
This only happens for the last message in a transfer (the one after
which a STOP condition should occur). While the I2C spec says "Many
devices however are designed to operate properly under this condition",
one of the devices that doesn't seem to operate properly under this
condition is an SE050 Secure Element which stops in the middle of a
message after a few transfers. Might be related to Errata 3.2[2] but it
isn't exactly the same setup as the one for the illegal format here.

This fixes the setup for sending the STOP condition so that the illegal
format doesn't exist anymore and the multi-messages transfers still work
as expected (tested with SYR828 on RockPro64).

While at it, fix a bitfield typo to enable the "controller finished
sending the STOP" interrupt which has no impact on the HW (likely
because U-Boot doesn't actually make use of interrupts and the interrupt
status register of the IP always being up-to-date regardless of the
interrupt enabling).

Finally, fix the location of the last ACK/NACK comment when receiving
multi-word messages.

[1] https://www.nxp.com/docs/en/user-guide/UM10204.pdf 3.1.10 The target address and R/W bit point 5
[2] https://www.nxp.com/docs/en/errata/SE050_Erratasheet.pdf

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      rockchip: i2c: fix incorrect STOP flag for the interrupt enable register
      rockchip: i2c: move ACK comment where it applies
      rockchip: i2c: fix illegal I2C START/STOP condition

 drivers/i2c/rk_i2c.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)
---
base-commit: c2637036b8f0c90a2cfc59900f7da31eae646b03
change-id: 20251107-rk-i2c-illegal-ef7fdb4b886d

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

