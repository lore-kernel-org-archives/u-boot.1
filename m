Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01460CED62A
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 08:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EDDD8901E;
	Wed,  9 Oct 2024 10:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pV4mWO0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F6FD8912B; Wed,  9 Oct 2024 10:11:40 +0200 (CEST)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E318905F
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 10:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9F071C0003;
 Wed,  9 Oct 2024 08:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1728461498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bcDXNjALMqDKbHK71tyPWkNMeRVOEi27ZlHB07aOuU=;
 b=pV4mWO0xnUk3ApfAV6A4KsMN2ICgTayopWw3OdKP1Au5714AQ9Vrgis3BRZyrFTpamiJ4X
 W+I0JddyVmz4FDfp70UwTRkUa3iHi8IASePcDJ6Ir6UouBmw9oCtYGwo3e+ZIq6SxH9+xp
 XKWzIYBOtFCYPJ1qrjKzmlx3MrbMQI5TJ2Lw2uLee6D0gm3o2d2IDtkzUbStHXlN6P4zSL
 DIFWrhkywUFhxvFucSRiTswJUmX1zsDmwiVyjFMKv+tdj9kQGxaC7/uevbyH5BCRckbJsE
 A3p3e0jQaxGKiu5Bz7vZ3adaDwMbwJ2u1GNgFQodiJgs8ZzE/kMFBCP/V+lpjQ==
Date: Wed, 9 Oct 2024 10:11:35 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, Tom Rini
 <trini@konsulko.com>, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Dmitry Rokosov
 <ddrokosov@sberdevices.ru>, Igor Prusov <ivprusov@salutedevices.com>, Bruce
 Suen <bruce_suen@163.com>, Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>, Martin Kurbanov
 <mmkurbanov@sberdevices.ru>, Max Krummenacher
 <max.krummenacher@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: Re: [RESEND PATCH v4 00/10] mtd: spinand: initial support of ecc
 engines
Message-ID: <20241009101135.6dfc657f@xps-13>
In-Reply-To: <CAFLszTiJMO+0+tMVPCM8Ho95TzvfqCgYvSLBJzmNbPJXJk-rYQ@mail.gmail.com>
References: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszTiJMO+0+tMVPCM8Ho95TzvfqCgYvSLBJzmNbPJXJk-rYQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Simon, Mikhail,

sjg@chromium.org wrote on Tue, 8 Oct 2024 19:50:59 -0600:

> Hi Mikhail,
>=20
> On Tue, 1 Oct 2024 at 14:45, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
> >
> > This patch series:
> >  * sync spinand driver code with linux-6.10
> >  * sync spinand flash support with linux-6.10
> >  * add initial support of ecc engines
> >
> > Up to now only software ecc is supported, but other engines can be add =
quite easily =20
>=20
> Is there a uclass for ECC?

Not that I am aware of. Indeed maybe a uclass for these engines might
make sense (maybe UCLASS_ECC_ENGINE). The uclass for them might be
simple enough just to match devices with drivers and drivers and perhaps
expose the few callbacks needed (like init/prepare/finish/cleanup).
Then in the NAND layer when looking for a suitable device you could do
a research by class ID.

Thanks,
Miqu=C3=A8l
