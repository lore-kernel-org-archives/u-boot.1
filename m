Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A37C5474A
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 02:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9447F87FED;
	Wed, 28 Aug 2024 04:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=email.cz header.i=@email.cz header.b="Ag1S69AU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC0788A8E; Wed, 28 Aug 2024 04:13:49 +0200 (CEST)
Received: from mxe-1-afc.seznam.cz (mxe-1-afc.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:afc])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EA8887FA7
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 04:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomaspaukrt@email.cz
Received: from email.seznam.cz by smtpc-mxe-85b96b7dcc-nmbd7
 (smtpc-mxe-85b96b7dcc-nmbd7 [2a02:598:128:8a00::1000:afc])
 id 394a5312c7bee1b839c4dd0a; Wed, 28 Aug 2024 04:13:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
 s=szn20221014; t=1724811225;
 bh=+8Eg99/H3lOEbpkDr1h6Wq2DS9jUCb2b5X1Vg/RwqNA=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:Mime-Version:X-Mailer:
 Content-Type:Content-Transfer-Encoding;
 b=Ag1S69AUjVrjBB9MYM8umVP2C//gJ7q+wMSoirZdTN4Dr/ynKWbzp0LrBK90s7iRx
 acSxJa8GHBR8ao+YvjUxBiq9mR2CFBp4mJhjt8Msv4y4AVMRms4IRZ7Dc3HHREv24+
 +HXlIQ22f9SHJE6rq54WrmnYtJrlhok9zFlaztSfrFAMQE8vvWwX3rsf6y7RCE5D9z
 Yu/QZSvjt0dZfGYd3wQsoGL+pWDUJJHc4nkk5YogBq3V7GwM9GXBaZj2Xz2EZuLKzJ
 Hm4QxpZQpfDZyjr3E8o/M8p3adKgyRIrfJecZVB2fjbwdMgbQGPaXatiZ3UvstUf+W
 rRhe8+Y+5X4Pw==
Received: from 184-143.ktuo.cz (184-143.ktuo.cz [82.144.143.184])
 by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
 Wed, 28 Aug 2024 04:13:43 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <u-boot@lists.denx.de>
Cc: <festevam@gmail.com>,
	<trini@konsulko.com>
Subject: =?utf-8?q?=5BPATCH_v2=5D_gpio=3A_mxc=5Fgpio=3A_fix_reading_state_?=
 =?utf-8?q?of_GPIO_pins_in_output_mode_?=
Date: Wed, 28 Aug 2024 04:13:43 +0200 (CEST)
Message-Id: <Mn.Zbvh.7W8POzTA8pZ.1cpeVN@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.1.61)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

The PSR register works correctly for GPIO pins in input mode,
but always returns 0 for GPIO pins in output mode unless the SION
bit is set. The DR register works correctly in both modes without
the need to set the SION bit.

Please note that the Linux gpio-mxc driver already uses
the DR register for all GPIO pins in output mode:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D442b2494b17d1a4f0a14721580271eb23ebffd42

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 drivers/gpio/mxc_gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/mxc_gpio.c b/drivers/gpio/mxc_gpio.c
index cac6b32..5cd7681 100644
--- a/drivers/gpio/mxc_gpio.c
+++ b/drivers/gpio/mxc_gpio.c
@@ -133,7 +133,7 @@ int gpio_get_value(unsigned gpio)
 
 	regs =3D (struct gpio_regs *)gpio_ports[port];
 
-	val =3D (readl(&regs->gpio_psr) >> gpio) & 0x01;
+	val =3D (readl(&regs->gpio_dr) >> gpio) & 0x01;
 
 	return val;
 }
@@ -210,7 +210,7 @@ static void mxc_gpio_bank_set_value(struct gpio_regs *=
regs, int offset,
 
 static int mxc_gpio_bank_get_value(struct gpio_regs *regs, int offset)
 {
-	return (readl(&regs->gpio_psr) >> offset) & 0x01;
+	return (readl(&regs->gpio_dr) >> offset) & 0x01;
 }
 
 /* set GPIO pin 'gpio' as an input */
-- 
2.7.4
 
