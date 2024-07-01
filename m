Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F171C30653
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 09:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9D0A883CD;
	Mon,  1 Jul 2024 11:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="FP9MtUsK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2131E87E13; Mon,  1 Jul 2024 11:38:35 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B0D8863E
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 11:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 586C2FF80B;
 Mon,  1 Jul 2024 09:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1719826712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0gkctbhyUo28b9TyAN50gAR0DAF+KTZo0MhRuf3QrQ=;
 b=FP9MtUsK5XlF1FsKusy4WQxZk0OptZPnK3dcIvkJnmZqBS9/PLBgius/aUh+jEnI47ZA31
 KBLU2+bGU2FOttVVKx505qJxGAK2Belcr99B4paGrb8pLwDLIO4SzEcTgVz+mUZkSpeEgq
 E6TIQDkzZqW7XPIQ+/Z6tSaTFwhOlqY6AvWm+UiQIQSvU0iDITtJNwfeA6IfCze7LePggN
 1QRvgQlm8r6Tg7TSz9K7MSKPB6m14hbEyySUgM3quCLfkChpUzMa0jOaHE4rE+JaQlZlDL
 IWKBPr4FcE9zJWqWjcnb2dn9oDx9Y+czaqykgVLBpojSvC8ZMQOCfOFGcCbZ1A==
Date: Mon, 1 Jul 2024 11:38:29 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Jagan Teki <jagan@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, Martin Kurbanov
 <mmkurbanov@sberdevices.ru>, Chuanhong Guo <gch981213@gmail.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>, Max Krummenacher
 <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 4/7] mtd: spinand: preparation for ecc engine adding
Message-ID: <20240701113829.74d628c7@xps-13>
In-Reply-To: <20240627112005.99375-4-mikhail.kshevetskiy@iopsys.eu>
References: <20240627112005.99375-1-mikhail.kshevetskiy@iopsys.eu>
 <20240627112005.99375-4-mikhail.kshevetskiy@iopsys.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

Hi Mikhail,

mikhail.kshevetskiy@iopsys.eu wrote on Thu, 27 Jun 2024 14:20:02 +0300:

A commit log would be welcome here as many things happen in this patch.

I'm fine overall, I didn't thoroughly review all the patches but they
look sensible to me.

> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/core.c | 259 +++++++++++++++++++++---------------
>  1 file changed, 151 insertions(+), 108 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 8664e882753..1b2eefc9041 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -156,20 +156,12 @@ int spinand_select_target(struct spinand_device *sp=
inand, unsigned int target)
>  	return 0;
>  }
> =20
> -static int spinand_init_cfg_cache(struct spinand_device *spinand)
> +static int spinand_read_cfg(struct spinand_device *spinand)
>  {
>  	struct nand_device *nand =3D spinand_to_nand(spinand);
> -	struct udevice *dev =3D spinand->slave->dev;
>  	unsigned int target;
>  	int ret;
> =20
> -	spinand->cfg_cache =3D devm_kzalloc(dev,
> -					  sizeof(*spinand->cfg_cache) *
> -					  nand->memorg.ntargets,
> -					  GFP_KERNEL);

...

Thanks,
Miqu=C3=A8l
