Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D1BCDB466
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 09:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBB1284704;
	Thu, 25 Jun 2026 11:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="RSOq2OR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB929847C8; Thu, 25 Jun 2026 11:46:07 +0200 (CEST)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [45.157.188.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BD92846F4
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 11:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gmDT849Bzz10dn;
 Thu, 25 Jun 2026 11:46:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1782380764;
 bh=rJ0ezvmHas7hPmDJPUjEW1H2KUCrxVyyMnmh3cPa+Oo=;
 h=From:Date:Subject:To:Cc:From;
 b=RSOq2OR3kVhUdmcCw1BvycOUZPkqlEefKgrQO+ZmajTDEXs64vTZrsDn9jiBiyFqI
 aL33c8qJqd7wYg2jy9joMglcLqIqdQjnOLkTUEkQ6pQRsiIXB378FtYk1QwRhyFgtT
 w4DjzpX5joPwCSJOzqUDV8xk9vnEqQdahvKm+dOsD6RZH5UO0O9MeCsHxUDwC8jUhf
 t6xMp9nouI8UaSictJJEIWAbOLej7CUqyCQdSlexblUCDqpbmpYfDgPNXuCYIJmaV+
 lGU1BbivubOOBCgnEvL/aG6Z2LJOmsRV9QOzgOewemGF3ycfOeSFgHoK5dGyltH1dF
 8EYQXAL/M8now==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gmDT66BzGzYpv; Thu, 25 Jun 2026 11:46:02 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 25 Jun 2026 11:45:52 +0200
Subject: [PATCH] arm64: a37xx: pinctrl: fix info->dev used but never set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-pinctrl-armada-37xx-devm-v1-1-6850a91dd02a@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBA0auUWTsQ0yYBryIuxmTUERvLpJZA6
 d0bdfkW/69QWIULnLoVlBcp8s4Nx0MH8UH5ziipGayx3njrcJIcZ30h6UiJsA+1YuJlROd86od
 EwVCAlk/KN6m/9fnyd/lcnxzn7w+2bQcEElvTfAAAAA==
X-Change-ID: 20260625-pinctrl-armada-37xx-devm-556d34da70a7
To: Stefan Roese <sr@denx.de>, 
 Gregory CLEMENT <gregory.clement@free-electrons.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Ben Schneider <ben@bens.haus>
X-Mailer: b4 0.15-dev-47773
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

A bunch of code calls info->dev, mostly dev_* messages and devm_kzalloc.

The former can be passed a NULL device and _dev_printk handles this just
fine.
The latter ignores the dev argument whenever !CONFIG_IS_ENABLED(DEVRES)
which was true in most cases until we made CONFIG_DEVRES mandatory for
U-Boot proper in commit 217cf656e249 ("dm: core: Default to using DEVRES
outside of xPL"). Failing to set info->dev before it's used by
devm_kzalloc results in crashes, therefore let's set info->dev before it
can be used.

Reported-by: Ben Schneider <ben@bens.haus>
Closes: https://lore.kernel.org/u-boot/IRefanijM8fTzOXeGe-H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz-IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo=@bens.haus/
Fixes: 0871806629b5 ("pinctrl: armada-37xx: Add pin controller support for Armada 37xx")
Fixes: 217cf656e249 ("dm: core: Default to using DEVRES outside of xPL")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
This was apparently tested by Ben[1] but it'd be nice if you could test
again and give your Tested-by as I do not own any board with such
pinctrl device.

[1] https://lore.kernel.org/u-boot/kaJS2I2TlB5214mKzY5xXgpgeJRX1riXHuO0FSKHKdxcmBCJrnYmp7s-ebQd7mIbJBd1_yubQEd2bxBUMcUK02KgDudVPXcBIdlIZRMTxF8=@bens.haus/
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 884ed258d17..ea726b96f61 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -720,6 +720,8 @@ static int armada_37xx_pinctrl_probe(struct udevice *dev)
 		return -ENODEV;
 	}
 
+	info->dev = dev;
+
 	/*
 	 * we allocate functions for number of pins and hope there are
 	 * fewer unique functions than pins available

---
base-commit: 77a48fa272161df9b778ffc09af814eec11cddd2
change-id: 20260625-pinctrl-armada-37xx-devm-556d34da70a7

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

