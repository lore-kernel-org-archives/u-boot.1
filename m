Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB00CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A290083E36;
	Mon, 11 May 2026 14:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="ABHj19KO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C62A38485A; Mon, 11 May 2026 12:28:34 +0200 (CEST)
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1651183A91
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 12:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1778495310; x=1810031310;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Py6HPE7MJvW94WcgaRWM5uE/2PILz1bS1cRwU/b2G8k=;
 b=ABHj19KORAKnrit9IZnXf9lkqwVJU84k2PMyTu9XQwMm/PChBZgIa5S7
 nogNEeu1X0Sv4o2G1IeUrduko3nzD9RyOMkNl+JPozlxh/ZplurEBSSlL
 iAURcwdEXH8Ffi0mLniCQ4swN9yEZTS2WEtI0VDhos/hroE1tEQeEVMSB Y=;
X-CSE-ConnectionGUID: eJe+4BNUTWeY7LxqbQ1P1A==
X-CSE-MsgGUID: v22Cm222SviqWlJF2QaqYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="157076752"
X-IronPort-AV: E=Sophos;i="6.23,228,1770591600"; d="scan'208";a="157076752"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 12:28:29 +0200
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 12:28:29 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE817.infineon.com
 (172.23.29.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 12:28:29 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.037; Mon, 11 May 2026 12:28:29 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <vjardin@free.fr>, <u-boot@lists.denx.de>
CC: <christoph.reiter@evk.biz>, <dlechner@baylibre.com>,
 <flaviu.nistor@gmail.com>, <jeyu@issi.com>,
 <marek.vasut+renesas@mailbox.org>, <miquel.raynal@bootlin.com>,
 <yangshiji66@outlook.com>, <ssunkkan@gmail.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>
Subject: RE: [PATCH v1] mtd: spi-nor: Add gd55lb02gf chips
Thread-Topic: [PATCH v1] mtd: spi-nor: Add gd55lb02gf chips
Thread-Index: AQHc4Mt1nus7H+92dk68A3upwZMt9bYIkXXQ
Date: Mon, 11 May 2026 10:28:29 +0000
Message-ID: <77e1b83ec3d549d0a2fe2816241446c7@infineon.com>
References: <20260510222140.603755-1-vjardin@free.fr>
In-Reply-To: <20260510222140.603755-1-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 11 May 2026 14:50:48 +0200
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

Hi,
>=20
> Add GigaDevice GD55LB02GF (256 MiB, JEDEC 0xc8 0x60 0x1c) to the
> spi-nor ID table.
>=20
> Same die family as the existing gd55lb02g entry but a distinct memtype
> byte (0x60 versus 0x67), so the existing entry does not match.
>=20
0xc8671c is for GD55LB02GE and there is duplicate entry appears in the last
part of GigaDevice entries. Besides SPI_NOR_HAS_TB flag is missing in the
"gd55lb02g" entry...

> Signed-off-by: Vincent Jardin <vjardin@free.fr>
>=20
> ---
>=20
>  drivers/mtd/spi/spi-nor-ids.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index c0fa98424aa..50f6dd3e5c4 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -191,6 +191,8 @@ const struct flash_info spi_nor_ids[] =3D {
>         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
>         {INFO("gd55lb02g", 0xc8671C, 0, 64 * 1024, 4096,        SECT_4K |
>         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
> +       {INFO("gd55lb02gf", 0xc8601C, 0, 64 * 1024, 4096,       SECT_4K |
> +       SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},

Could you create a new entry just after "gd55lb02ge" with the same flags wi=
th
it? GD55LB02G'F' should be a successor chip of GD55LB02G'E'.

Thanks,
Takahiro

>         {INFO("gd25lf80", 0xc86314, 0, 64 * 1024, 16,   SECT_4K |
>         SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
>         {INFO("gd25lf16", 0xc86315, 0, 64 * 1024, 32,   SECT_4K |
> --
> 2.43.0
>=20
> base-commit: bfe90a308a94caa9d855440683521ff04122ae2a
> branch: for-upstream/spi-nor-gd55lb02gf
