Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC8DCD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 13:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 239A6846E2;
	Fri, 22 May 2026 15:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="Mf4LxPw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 631758482F; Fri, 22 May 2026 09:55:45 +0200 (CEST)
Received: from smtp14.infineon.com (smtp14.infineon.com
 [IPv6:2a00:18f0:1e00:4::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05514846AD
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 09:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1779436543; x=1810972543;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hTeEZXuY6DirV/vuJFk5gJPMx6m0gj0ndKtWl0Bhozc=;
 b=Mf4LxPw0xNQ7EKWmrHYOlXCWQ3xfrjqKShGxYjkfHfbC4X9/ThfpatbD
 zM/lIjAdpRvGuv116Wus4hLReq65t9JAHj3I61ouqj/6MGhirBryt54g5
 OXtAxCGTZOM7p2ayVrQqguSONyBcYiB9cf8N3nkt1iDYJ39VMU7z4saXj 8=;
X-CSE-ConnectionGUID: A/Y13q2SR9Ouez3Bx1lZGQ==
X-CSE-MsgGUID: a9lpImfLRUGBwltL5GJNpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="130992586"
X-IronPort-AV: E=Sophos;i="6.24,161,1774306800"; d="scan'208";a="130992586"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
 by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 09:55:42 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 09:55:42 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.037; Fri, 22 May 2026 09:55:42 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <weijie.gao@mediatek.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Subject: RE: [PATCH v3 3/7] mtd: spi-nor-ids: Add support for GigaDevice
 GD25Q256
Thread-Topic: [PATCH v3 3/7] mtd: spi-nor-ids: Add support for GigaDevice
 GD25Q256
Thread-Index: AQHc4qmD/Di8U6/3Q06O/0PQP/c4NbYZjrRg
Date: Fri, 22 May 2026 07:55:42 +0000
Message-ID: <db34ba7dcb6b442fbcc137b6d790964f@infineon.com>
References: <cover.1778655692.git.weijie.gao@mediatek.com>
 <906583fc7f1055d6c86c85802d04c2c92f3183b0.1778655692.git.weijie.gao@mediatek.com>
In-Reply-To: <906583fc7f1055d6c86c85802d04c2c92f3183b0.1778655692.git.weijie.gao@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 22 May 2026 15:09:24 +0200
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

> GD25Q256 ia 256Mb flash device with Quad interface at max 80MHz clock rat=
e.
ia -> is

The datasheet says it's up-to 133MHz. If you tested at 80MHz, please mentio=
n
that.

> This flash supports 2.7-3.6V voltage range.
>=20
> Tested on MediaTek's filogic platform.
>=20
> Link: https://download.gigadevice.com/Datasheet/DS-00526-GD25Q256E-Rev1.3=
.pdf
>=20
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>

Please remove blank line between the tags.

> ---
> v3: removed locking flags. updated commit message
> v2: updated commit message
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index fcc546fb5ae..9271cefc759 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -147,6 +147,10 @@ const struct flash_info spi_nor_ids[] =3D {
>                         SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>                         SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>         },
> +       {
> +               INFO("gd25q256", 0xc84019, 0, 64 * 1024, 512,
> +                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> +       },

Same ID but different name entry below (I overlooked this in previous revie=
w).
Both 'Q' and 'B' are available in GigaDevice website. What's the difference=
?

>         /* adding these 3V QSPI flash parts */
>         {INFO("gd25b256", 0xc84019, 0, 64 * 1024, 512,  SECT_4K |
>         SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NO=
R_4B_OPCODES)  },

Thanks,
Takahiro

