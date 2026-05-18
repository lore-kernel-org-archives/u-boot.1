Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE67BCD4F48
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 07:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F9FA84676;
	Mon, 18 May 2026 09:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="BKUPItis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82AD084150; Mon, 18 May 2026 09:10:50 +0200 (CEST)
Received: from smtp11.infineon.com (smtp11.infineon.com
 [IPv6:2a00:18f0:1e00:4::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72D3683EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 09:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1779088249; x=1810624249;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xfRHfUPdTFUblS+B4QaxQD/px4Bmy0lz1C6fyrlR/90=;
 b=BKUPItis2oJzWhxr5ctI2DqEZia7lQ8Poo42nCEVl5LJuF4nz9BUHf3y
 edV5Bx5mC4BZXT5qq5p9QJmTxGm7D6eNen2Tdg6cGfEx+FKPaCjaAyBC+
 Z1tyczyirmpRxxu4kR57T1dMJAN6JRFWM+vdrBQpeuMK0QMma8Rnvceo/ c=;
X-CSE-ConnectionGUID: JLPxV4npQzGSgWCtucWmLA==
X-CSE-MsgGUID: mt3FsLNXSkOSaKodcdUimQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="143592297"
X-IronPort-AV: E=Sophos;i="6.23,241,1770591600"; d="scan'208";a="143592297"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
 by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 09:10:49 +0200
Received: from MUCSE811.infineon.com (172.23.29.37) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 09:10:48 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE811.infineon.com
 (172.23.29.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 09:10:48 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.037; Mon, 18 May 2026 09:10:47 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <vjardin@free.fr>, <u-boot@lists.denx.de>
CC: <christoph.reiter@evk.biz>, <dlechner@baylibre.com>,
 <flaviu.nistor@gmail.com>, <jeyu@issi.com>, <miquel.raynal@bootlin.com>,
 <yangshiji66@outlook.com>, <ssunkkan@gmail.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>
Subject: RE: [PATCH v2] mtd: spi-nor: Add gd55lb02gf chips
Thread-Topic: [PATCH v2] mtd: spi-nor: Add gd55lb02gf chips
Thread-Index: AQHc5dwlD838/R5nf0SUzPfs8u2CAbYTVusw
Date: Mon, 18 May 2026 07:10:47 +0000
Message-ID: <5a74856d806a4dabad4055498c2c1420@infineon.com>
References: <"<20260510222140.603755-1-vjardin@free.fr>">
 <20260520150032.1904130-1-vjardin@free.fr>
In-Reply-To: <20260520150032.1904130-1-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 18 May 2026 09:24:19 +0200
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

> Add the GigaDevice GD55LB02GF (256 Mo) similar to gd55lb02ge with
> the same read path flags.
>=20
> SPI_NOR_HAS_LOCK and SPI_NOR_HAS_TB do not match this chip's
> status register layout: the GD55LB02GF uses a 5-bit block protect
> field BP0..BP4 plus a CMP bit in SR2 for direction (see datasheet
> "Status Register Block Protection").
>=20
> The generic stm-lock helpers drive only BP0..BP2 and assume SR1
> bit 5 is TB, but on this part SR1 bit 5 is BP3.
> Enabling either flag would leave BP3..BP4 unmanaged or corrupt
> BP3 on every lock op.
> A proper support needs a vendor specific lock callback, it is out
> of scope for this table update.
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> Suggested-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>=20
> ---
>=20
> Changes in v2:
> - Place the new entry next to gd55lb02ge with style matching the
>   neighbour.
> - Drop SPI_NOR_HAS_LOCK. Did not adopt SPI_NOR_HAS_TB from
>   gd55lb02ge: neither flag matches this chip's SR layout (see
>   comments for the BP0..BP4 / CMP rationale).
>=20
>  drivers/mtd/spi/spi-nor-ids.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index c0fa98424aa..31a2ba49a87 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -231,6 +231,10 @@ const struct flash_info spi_nor_ids[] =3D {
>                      SECT_4K | SPI_NOR_QUAD_READ |
>                      SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>         },
> +       {
> +               INFO("gd55lb02gf", 0xc8601c, 0, 64 * 1024, 4096,
> +                    SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES)
> +       },
>  #endif
>  #ifdef CONFIG_SPI_FLASH_ISSI           /* ISSI */
>         /* ISSI */
> --
> 2.43.0
>=20
> base-commit: bfe90a308a94caa9d855440683521ff04122ae2a
> branch: for-upstream/spi-nor-gd55lb02gf

Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>

Thanks!



