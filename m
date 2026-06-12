Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B28CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 942A4849D2;
	Fri, 12 Jun 2026 14:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="kQoCRp4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1737783FEC; Fri, 12 Jun 2026 11:51:56 +0200 (CEST)
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B688056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1781257914; x=1812793914;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=m0EAvzPl+8JEKl3nAtpIaxz7aworI7dXDA8y7qVE1p4=;
 b=kQoCRp4bU4kMq2BpAu2XfJY5/h6oQShAIdXP5dg1nvm6zNmz7OkiJ/X2
 w2nI+H3ms/+BC9m4ciSaPxP3/fvZSZxQBnV7laQSHMGoPtbWFWo2vNiVi
 vlk/VqwsDGt0bV0+vMIJFR5J5CNQWZbSJgmYguOFNmclKVqk2cO0oQgtS w=;
X-CSE-ConnectionGUID: dAHO3J0gTTC15/7WkH2nRA==
X-CSE-MsgGUID: WSVJDI5kQ4mLoOuBG91QNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="162118077"
X-IronPort-AV: E=Sophos;i="6.24,200,1774306800"; d="scan'208";a="162118077"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 11:51:53 +0200
Received: from MUCSE813.infineon.com (172.23.29.39) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 11:51:53 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE813.infineon.com
 (172.23.29.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 11:51:52 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.037; Fri, 12 Jun 2026 11:51:52 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <marex@nabladev.com>, <u-boot@lists.denx.de>
CC: <akoch@initse.com>, <dlechner@baylibre.com>, <flaviu.nistor@gmail.com>,
 <miquel.raynal@bootlin.com>, <trini@konsulko.com>,
 <tudor.ambarus@linaro.org>, <vigneshr@ti.com>
Subject: RE: [PATCH] mtd: spi-nor: Add GigaDevice GD25LQ16 support
Thread-Topic: [PATCH] mtd: spi-nor: Add GigaDevice GD25LQ16 support
Thread-Index: AQHc+e1oIqA0iAOK0kSoF0hAoPRFjLY6qm3w
Date: Fri, 12 Jun 2026 09:51:52 +0000
Message-ID: <e19646ac03734dcc8f7e38243040f60e@infineon.com>
References: <20260611215808.177934-1-marex@nabladev.com>
In-Reply-To: <20260611215808.177934-1-marex@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:36:02 +0200
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

Hi Marek,

>=20
> From: Alexander Koch <akoch@initse.com>
>=20
> Add IDs for GigaDevice GD25LQ16 SPI NOR.
>=20
> Signed-off-by: Alexander Koch <akoch@initse.com>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Alexander Koch <akoch@initse.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Flaviu Nistor <flaviu.nistor@gmail.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index c0fa98424aa..d3a24b51daf 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -117,6 +117,11 @@ const struct flash_info spi_nor_ids[] =3D {
>                         SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>                         SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>         },
> +       {
> +               INFO("gd25lq16", 0xc86015, 0, 64 * 1024, 32,
> +                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +                       SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)

I could find a datasheet of GD25LQ16E that mentions the same ID (C8 60 15).
https://www.mouser.com/datasheet/2/870/gd25lq16e_datasheet_v1_2_20210108-23=
99660.pdf?srsltid=3DAfmBOopEr50lYWZuINw4geNljXqWZxHqvrYc-_HyJi7ISbOc_9RRaiC=
1

This chip has 4 BP bits (BP3..BP0) + TB (BP4).
The u-boot driver doesn't support 4-bit BP yet so locking feature shouldn't
work as expected.

> +       },
>         {
>                 INFO("gd25q32", 0xc84016, 0, 64 * 1024,  64,
>                         SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> --
> 2.53.0

