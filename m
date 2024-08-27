Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49374C54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 17:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A99C488A2F;
	Tue, 27 Aug 2024 19:52:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=email.cz header.i=@email.cz header.b="oJ61YDnc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 885788641A; Tue, 27 Aug 2024 19:36:47 +0200 (CEST)
Received: from mxc-1-9a4.seznam.cz (mxc-1-9a4.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:9a4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78CCD88A27
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 19:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomaspaukrt@email.cz
Received: from email.seznam.cz by smtpc-mxc-7895797957-z6j4l
 (smtpc-mxc-7895797957-z6j4l [2a02:598:128:8a00::1000:9a4])
 id 5715e760a9e155ca579b6978; Tue, 27 Aug 2024 19:36:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
 s=szn20221014; t=1724780204;
 bh=GMtjFNqm1IM1saWO/WHCsSEAEwK3GqHm4jK7DzySPsk=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:Mime-Version:X-Mailer:
 Content-Type:Content-Transfer-Encoding;
 b=oJ61YDncLV32lbbQC0Tq0veZz8gYs+dALZVd/jHwDRsJ9a6NL6CYcV96vLJTqtoYI
 IF7PPVyWbnJ6j9SXpadgyC53Yz2h19z5CY2S10Nld4alMYNdQnHC8GgPwCuVEfzxX4
 Z44LibUc/sBuEd74eOGLjX/cD77tFCFFCRumyvJtNVkcP0BQz/9iSSHTNOfKn1Rz48
 oyKkWWYNW5a9NohihgI2GVnpSITu/esOFHlCVY1K/KYcnABi6Mch/A6jp3aAUhk3cd
 c/kh4BjYdoXAY9/mXUt8iQ2pwMbPEXZIvuhROj5re6Y52jpgQrfuVzXsmjMvCc+q5f
 o5kXOG+nmPdZA==
Received: from 184-143.ktuo.cz (184-143.ktuo.cz [82.144.143.184])
 by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
 Tue, 27 Aug 2024 19:36:43 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <u-boot@lists.denx.de>
Cc: "Tom Rini" <trini@konsulko.com>
Subject: =?utf-8?q?=5BPATCH=5D_gpio=3A_mxc=5Fgpio=3A_fix_reading_state_of_?=
 =?utf-8?q?GPIO_pins_in_output_mode_?=
Date: Tue, 27 Aug 2024 19:36:43 +0200 (CEST)
Message-Id: <GI.Za6b.48b6UC5Rsur.1cpWwh@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.1.61)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 27 Aug 2024 19:52:05 +0200
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
but always returns 0 for GPIO pins in output mode.
The DR register works correctly in both modes.

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
 
