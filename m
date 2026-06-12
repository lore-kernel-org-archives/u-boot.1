Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DF5CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0743684954;
	Fri, 12 Jun 2026 14:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="BvZ/5ezO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0AB584717; Fri, 12 Jun 2026 09:57:11 +0200 (CEST)
Received: from smtp11.infineon.com (smtp11.infineon.com
 [IPv6:2a00:18f0:1e00:4::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 511708005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 09:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1781251029; x=1812787029;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ku4GWdRruysPopz9qmOOAmkp7LZJxC6O5Z+B/1lIsBw=;
 b=BvZ/5ezOkstdsAoREfF+KYX/Q7Qho7gL1nJ2zB67PkSWt6TQgPtHAzd4
 ASkQ8Ik6oMklkdyYxvOh2Q0OZMKAWwIcYVTHWDQdCnPl4nkYnxyvtBmiP
 cqW93yaY4Ck1cIxz4KmRA3ZsBmxDWKrNB5zhv1UrsPgboFkhH4T7hYrgs I=;
X-CSE-ConnectionGUID: CSJEE+AxRDmS4fWvKU2rgg==
X-CSE-MsgGUID: UH44QSEORAachD6LlC7OKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="146996921"
X-IronPort-AV: E=Sophos;i="6.24,200,1774306800"; d="scan'208";a="146996921"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
 by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 09:57:08 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 09:57:08 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.037; Fri, 12 Jun 2026 09:57:08 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <weijie.gao@mediatek.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Subject: RE: [PATCH v5 1/7] mtd: spi-nor-ids: Correct flash flags for ESMT/EON
 flashes
Thread-Topic: [PATCH v5 1/7] mtd: spi-nor-ids: Correct flash flags for
 ESMT/EON flashes
Thread-Index: AQHc+XpCcpgAaEuKrESE2niT6yo2XbY6gmIw
Date: Fri, 12 Jun 2026 07:57:08 +0000
Message-ID: <c2c8f27ffce4428cb3637eeaec973785@infineon.com>
References: <cover.1781164951.git.weijie.gao@mediatek.com>
 <64ce1a920dc067717de2b39d2e7a5098e6853aab.1781164951.git.weijie.gao@mediatek.com>
In-Reply-To: <64ce1a920dc067717de2b39d2e7a5098e6853aab.1781164951.git.weijie.gao@mediatek.com>
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

Hi,

>=20
> All currently supported ESMT/EON flashes supports 4KB sector and dual/qua=
d
> read.
>=20
> Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25Q80B.pdf
> Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25QH128A%20(2T=
C).pdf
> Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25S64A(2SC).pd=
f
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
> v5: not changed
> v3-v4: updated commit message
> v2: not changed
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index c0fa98424aa..7d96adab4fd 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -90,12 +90,12 @@ const struct flash_info spi_nor_ids[] =3D {
>  #endif
>  #ifdef CONFIG_SPI_FLASH_EON            /* EON */
>         /* EON -- en25xxx */
> -       { INFO("en25q80b",   0x1c3014, 0, 64 * 1024,   16, SECT_4K) },
> -       { INFO("en25q32b",   0x1c3016, 0, 64 * 1024,   64, 0) },
> -       { INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K) },
> -       { INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, 0) },
> -       { INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, 0) },
> -       { INFO("en25s64",    0x1c3817, 0, 64 * 1024,  128, SECT_4K) },
> +       { INFO("en25q80b",   0x1c3014, 0, 64 * 1024,   16, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +       { INFO("en25q32b",   0x1c3016, 0, 64 * 1024,   64, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +       { INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +       { INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +       { INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +       { INFO("en25s64",    0x1c3817, 0, 64 * 1024,  128, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ) },

If SPI_NOR_QUAD_READ is given, the driver assumes the chip supports
Quad Output Read (1-1-4, 6Bh) and Quad Page Program (1-1-4, 32h).
Except en25qh128, those chips don't support 1-1-4 read/program per datashee=
ts.
They do support Quad I/O Read (1-4-4, EBh). If you want to enable it,
write fixup otherwise just drop the SPI_NOR_QUAD_READ flag, please.

Thanks,
Takahiro

