Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97366CD4F26
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 08:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E124283C51;
	Tue, 12 May 2026 10:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="As3UUCF8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BD6581E18; Tue, 12 May 2026 08:16:14 +0200 (CEST)
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23A12801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 08:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1778566571; x=1810102571;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vxa89uFSpTwbbLv7NoA5Ybhzzq4L85tvpQsxDYwVd5Q=;
 b=As3UUCF8ibOP3/E54NXwyMRUAsW2x4vEUDHIsN5VfPvxxzSkil4K3VH2
 sXLUPZ0Tg3KCbfG7gAmyEP2mVgoyTyKc3RTPBB44y/OQEYvvI4zg9xQ1I
 bkyFOUXJozwJlJ9FY+H0PurhTOaQYtp0JnwpUdVFObEmU024La/lpdoqB Q=;
X-CSE-ConnectionGUID: a75AMjq8R3OHApJcwY4jvQ==
X-CSE-MsgGUID: k42VU1vPTdm4zBSHNgB72Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="157215695"
X-IronPort-AV: E=Sophos;i="6.23,230,1770591600"; d="scan'208";a="157215695"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 08:16:10 +0200
Received: from MUCSE811.infineon.com (172.23.29.37) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 08:16:10 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE811.infineon.com
 (172.23.29.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 08:16:10 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.037; Tue, 12 May 2026 08:16:10 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <weijie.gao@mediatek.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Subject: RE: [PATCH v2 3/7] mtd: spi-nor-ids: Add support for GigaDevice
 GD25Q256
Thread-Topic: [PATCH v2 3/7] mtd: spi-nor-ids: Add support for GigaDevice
 GD25Q256
Thread-Index: AQHc1vLviysKWurMgUWWwU2UgWL4AbYJ99QQ
Date: Tue, 12 May 2026 06:16:10 +0000
Message-ID: <cc029112ea4a4e829ec628022b632221@infineon.com>
References: <cover.1777368885.git.weijie.gao@mediatek.com>
 <6558b4e914d6de3353af2728016b17e3736d4a6d.1777368885.git.weijie.gao@mediatek.com>
In-Reply-To: <6558b4e914d6de3353af2728016b17e3736d4a6d.1777368885.git.weijie.gao@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 12 May 2026 10:12:36 +0200
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

> This flash is tested on MediaTek's filogic platform.
>=20
> The datasheet can be found here:
> https://download.gigadevice.com/Datasheet/DS-00526-GD25Q256E-Rev1.3.pdf

Please add a quick introduction/description about the device in commit
message and use Link: tag for datasheet reference.

>=20
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
> v2: updated commit message
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index fcc546fb5ae..8b74fbd4946 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -147,6 +147,11 @@ const struct flash_info spi_nor_ids[] =3D {
>                         SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>                         SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>         },
> +       {
> +               INFO("gd25q256", 0xc84019, 0, 64 * 1024, 512,
> +                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +                       SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)

Did you test locking feature?
Per datasheet, this device has 4-bit BPs and TB at SR BIT(6), while current
u-boot supports 3-bit BPs and TB at SR BIT(5) only.

> +       },
>         /* adding these 3V QSPI flash parts */
>         {INFO("gd25b256", 0xc84019, 0, 64 * 1024, 512,  SECT_4K |
>         SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NO=
R_4B_OPCODES)  },
> --
> 2.45.2

Thanks,
Takahiro

