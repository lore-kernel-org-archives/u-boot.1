Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23319CA1013
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 11:25:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8246783B8C;
	Fri,  5 Sep 2025 13:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="MMFKbtSX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6126883B8C; Fri,  5 Sep 2025 13:25:22 +0200 (CEST)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3427083B83
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 13:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail3; t=1757071518; x=1757330718;
 bh=c1+4obkJgVdNWwf2pOe11U0hgBP9GWI3IecY78fRhfQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=MMFKbtSXVhdslZbihE0jZjE+x3Nz8a+2WivD4jmeUPvQ1PosYeTDy0GYvlE1L4AuU
 402rF8AgV/yEqlXa6qa+zUECTIR9p5iHwV3bIfLngCHX62xrl+DTVhA47pT4JKreov
 d+TuKyUqmwfziPOxzacg51LuwiL11lDpQ5z4fVC4yOcjbWTkl+fB1wemfm7nXOwxfq
 yDJ2d+So7AhbaaAvcQLKL+/yWiioRqcT+ibph1ZaRTziyVKMh6J5vVSLVt8yJdVYx4
 n05suUigWjwTUKA+8kKMTVT/pG7jZdctdn5jT9mOo0Nd5Yj890XvUQ5ftrQY2KTdFL
 ep7/gaxlDsw3g==
Date: Fri, 05 Sep 2025 11:25:13 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Philip Molloy <philip@philipmolloy.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Tom Rini <trini@konsulko.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 adsp-linux@analog.com
Subject: [PATCH 1/1] gpio: adp5588: Add ADP5587 as compatible
Message-ID: <20250905112509.2443775-2-philip@philipmolloy.com>
In-Reply-To: <20250905112509.2443775-1-philip@philipmolloy.com>
References: <20250905112509.2443775-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: ee9001bd076e5c0e04fc186a8a6751bd43f4abae
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

The ADP5587 is a simpler version of the ADP5588. The ADP5588 can
configure two pins, C8 and C9, as GPIOs or light sensors. The ADP5587
does not include the light sensors.

Signed-off-by: Philip Molloy <philip@philipmolloy.com>
---
 drivers/gpio/adp5588_gpio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/adp5588_gpio.c b/drivers/gpio/adp5588_gpio.c
index d081e169897..36304e48893 100644
--- a/drivers/gpio/adp5588_gpio.c
+++ b/drivers/gpio/adp5588_gpio.c
@@ -168,7 +168,7 @@ static int adp5588_ofdata_platdata(struct udevice *dev)
=20
 =09revid =3D ret & ID_MASK;
=20
-=09printf("ADP5588 Detected: Rev %x, Rev ID %x\n", ret, revid);
+=09printf("ADP558x Detected: Rev %x, Rev ID %x\n", ret, revid);
=20
 =09for (i =3D 0, ret =3D 0; i <=3D ADP5588_BANK(ADP5588_MAXGPIO); i++) {
 =09=09plat->dat_out[i] =3D adp5588_gpio_read(dev, GPIO_DAT_OUT1 + i);
@@ -194,6 +194,7 @@ static const struct dm_gpio_ops adp5588_ops =3D {
=20
 static const struct udevice_id adp5588_of_match_list[] =3D {
 =09{ .compatible =3D "adi,adp5588"},
+=09{ .compatible =3D "adi,adp5587"},
 =09{ /* sentinel */ }
 };
=20
--=20
2.50.1


