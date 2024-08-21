Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41ECEC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 15:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75FD888B82;
	Wed, 21 Aug 2024 17:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="FszrfVkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CA2088B82; Wed, 21 Aug 2024 17:57:24 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CEA988722
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 17:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6AF06240004;
 Wed, 21 Aug 2024 15:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1724255841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rqif0zEhs6VooFgQ7eOvglE0O+DHOB/dwpVfyNROYQY=;
 b=FszrfVkQxFP/0RjW0hQNquoOk1PNz52bmnRekDW26Q6Ninc9beskt3jH6S25lQTGowi+pW
 KO5tYLiClmiQjNYlFsgFeJ6HNUrQT+B+sTZ9c8+URM8uzA+xA3m+ccPNsBTFeiol6oWzpv
 +DUtzi8lxG4zfxjWk6TVXexund2YB69y8p9DlZAwpwH6zG7RkOLJpA5klCBI2FmbzNAmca
 CniPrlgi+ioxFRN3Th/NspxQr3eapoqi0lELMh6rttS+jPnzvWH727HbeVbcU9x5fIJkrn
 VWMcP2z+4nwDfi5maKxrCdfFuy8VkF3IZXa8BfeuR16UhcITz1++g9a1g5PNPQ==
Date: Wed, 21 Aug 2024 17:57:19 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
Cc: Simon Glass <sjg@chromium.org>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Tom Rini <trini@konsulko.com>, Dario
 Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Chuanhong Guo
 <gch981213@gmail.com>, Martin Kurbanov <mmkurbanov@sberdevices.ru>, Igor
 Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>, Max Krummenacher
 <max.krummenacher@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: Re: [RESEND PATCH v4 10/10] mtd: nand: add initial ecc engine support
Message-ID: <20240821175719.0c715a64@xps-13>
In-Reply-To: <581c5b3c-fe89-4828-8d60-d56b7e614c1c@genexis.eu>
References: <20240814101918.1347167-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814101918.1347167-11-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszThDQqaUofT2Jetw7bYc5M_+oBMswc9r8Vq2ZPhC-V9xYg@mail.gmail.com>
 <581c5b3c-fe89-4828-8d60-d56b7e614c1c@genexis.eu>
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

Hi Simon,

mikhail.kshevetskiy@genexis.eu wrote on Sat, 17 Aug 2024 23:25:31 +0400:

> On 8/17/24 19:58, Simon Glass wrote:
> > Hi Mikhail,
> >
> > On Wed, 14 Aug 2024 at 04:20, Mikhail Kshevetskiy
> > <mikhail.kshevetskiy@iopsys.eu> wrote: =20
> >> only spinand on_die ecc is supported for a moment
> >>
> >> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> >> ---
> >>  drivers/mtd/nand/Makefile       |   2 +-
> >>  drivers/mtd/nand/core.c         | 130 +++++++++++++++-
> >>  drivers/mtd/nand/ecc.c          | 249 ++++++++++++++++++++++++++++++
> >>  drivers/mtd/nand/spi/core.c     | 207 ++++++++++++++++++++-----
> >>  drivers/mtd/nand/spi/foresee.c  |   2 +-
> >>  drivers/mtd/nand/spi/macronix.c |   7 +-
> >>  drivers/mtd/nand/spi/micron.c   |   2 +-
> >>  drivers/mtd/nand/spi/toshiba.c  |  10 +-
> >>  drivers/mtd/nand/spi/winbond.c  |  10 +-
> >>  include/linux/mtd/nand.h        | 261 ++++++++++++++++++++++++++++++--
> >>  include/linux/mtd/spinand.h     |  13 +-
> >>  include/spi-mem.h               |   2 +
> >>  12 files changed, 830 insertions(+), 65 deletions(-)
> >>  create mode 100644 drivers/mtd/nand/ecc.c =20
> > Somehow this should use driver model (along with a suitable API) for
> > the ECC acceleration. =20
>=20
> It's just a necessary part of ECC engine. Other engines (not on_die)
> should be a separate modules.
>=20
> Maybe it could be shrink a bit more (by removing traces of other
> possible engines types). All what I want is:
> 1) get a working driver with on_die ECC support (it's actually a
> necessary part of spinand driver)
> 2) make the code as close to linux driver as possible
> 3)=C2=A0 add the possibility to add other engines in the future.

I would like to question the need to go through the DM API here.
Especially for the on-die situation. Simon, is there a particular area
which bothered you?

Thanks,
Miqu=C3=A8l
