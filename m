Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D037FC54FAD
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 13:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21B5888800;
	Wed, 28 Aug 2024 15:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=email.cz header.i=@email.cz header.b="p+HoD11c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B97A88884F; Wed, 28 Aug 2024 15:10:00 +0200 (CEST)
Received: from mxe-1-afc.seznam.cz (mxe-1-afc.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:afc])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A500887B4
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomaspaukrt@email.cz
Received: from email.seznam.cz by smtpc-mxe-85b96b7dcc-nmbd7
 (smtpc-mxe-85b96b7dcc-nmbd7 [2a02:598:128:8a00::1000:afc])
 id 756ad59b8b9e673175e45b83; Wed, 28 Aug 2024 15:09:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
 s=szn20221014; t=1724850592;
 bh=oYlB+eBcWaRlPM3rkWZdDcWELraGhWncZOhiATylKUQ=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:Mime-Version:X-Mailer:
 Content-Type:Content-Transfer-Encoding;
 b=p+HoD11cCBT/mQoM8A4mNEPLNkbDERVBxhvSs/gHa6cUySUTo6eL15y02ISZjWrFh
 AT0Ry1FRXEfjuZn5rTFot8lgF0K+QNaR9nwfj6sSl40K2x7n0sCE82s7FxozGbAA0e
 l8RGwkxiOEsS5l7VWfKECIDfxle7qF2PovzgRYmNgIJXWpkK5CpfgdbF4eEa3tsRDP
 xMuXB+ETlseS5K7mWE0R1zQL2RatIaRJN4SkIj4Xf/HmVRi5Mp8BTh4W/utKR6AHz3
 qq3fbGkr6MIgao16cwQ6mMJ5LSbhTTO1hdYDEXL0e/HbpWqzrdgR2g9fLBYH7BxhSr
 Mssxe/j2fFYtg==
Received: from 215-143.ktuo.cz (215-143.ktuo.cz [82.144.143.215])
 by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
 Wed, 28 Aug 2024 15:09:48 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <u-boot@lists.denx.de>
Cc: <marex@denx.de>, <festevam@gmail.com>, <trini@konsulko.com>,
 <francesco.dolcini@toradex.com>, <tharvey@gateworks.com>,
 <aford173@gmail.com>, <peng.fan@nxp.com>, <ye.li@nxp.com>,
 <michael@amarulasolutions.com>
Subject: =?utf-8?q?=5BPATCH_v4=5D_gpio=3A_mxc=5Fgpio=3A_fix_reading_state_?=
 =?utf-8?q?of_GPIO_pins_in_output_mode?=
Date: Wed, 28 Aug 2024 15:09:48 +0200 (CEST)
Message-Id: <py.Zbyp.4iSBCzZ4lgW.1cpo6S@seznam.cz>
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
bit is set.

The DR register should be used for GPIO pins in output mode
to allow correct getting of previously set output value.

Please note that the Linux gpio-mxc driver and the NXP U-Boot mxc_gpio
driver already use the DR register for all GPIO pins in output mode:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D442b2494b17d1a4f0a14721580271eb23ebffd42
https://github.com/nxp-imx/uboot-imx/commit/4afc3f90943c6b117f79b66d2cd04e=
64f437b0c2

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 drivers/gpio/mxc_gpio.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/mxc_gpio.c b/drivers/gpio/mxc_gpio.c
index cac6b32..28176e1 100644
--- a/drivers/gpio/mxc_gpio.c
+++ b/drivers/gpio/mxc_gpio.c
@@ -133,7 +133,10 @@ int gpio_get_value(unsigned gpio)
 
 	regs =3D (struct gpio_regs *)gpio_ports[port];
 
-	val =3D (readl(&regs->gpio_psr) >> gpio) & 0x01;
+	if ((readl(&regs->gpio_dir) >> gpio) & 0x01)
+		val =3D (readl(&regs->gpio_dr) >> gpio) & 0x01;
+	else
+		val =3D (readl(&regs->gpio_psr) >> gpio) & 0x01;
 
 	return val;
 }
@@ -210,7 +213,10 @@ static void mxc_gpio_bank_set_value(struct gpio_regs =
*regs, int offset,
 
 static int mxc_gpio_bank_get_value(struct gpio_regs *regs, int offset)
 {
-	return (readl(&regs->gpio_psr) >> offset) & 0x01;
+	if ((readl(&regs->gpio_dir) >> offset) & 0x01)
+		return (readl(&regs->gpio_dr) >> offset) & 0x01;
+	else
+		return (readl(&regs->gpio_psr) >> offset) & 0x01;
 }
 
 /* set GPIO pin 'gpio' as an input */
-- 
2.7.4
 
