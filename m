Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D3CC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 13:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C23D884A90;
	Fri,  3 Jul 2026 14:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="TfTqCiHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A6C1846F8; Fri,  3 Jul 2026 11:03:36 +0200 (CEST)
Received: from smtp14.infineon.com (smtp14.infineon.com
 [IPv6:2a00:18f0:1e00:4::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26F988469D
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 11:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1783069413; x=1814605413;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AHCVGumrzr6hG5eq+VugOjuTLaiUutcUfOIcBwaybek=;
 b=TfTqCiHqraeo/aD/GqhqUJ0wZALFXoN91tDsAc7cxS45T5GKxSh9ppKb
 67XXY0QpH18LoXVAg+IPzZ3eO04vfw+IFOkP6dN8TT3PKOOKuESCGjVtz
 x+EnvdTvuUL5i2l2Iw/04x6lAKktTbG78yTdOubBTzzBIJEmnmRMltOzh 4=;
X-CSE-ConnectionGUID: o48dloVMRWqnshROzm0c/g==
X-CSE-MsgGUID: 6lSvP+NQQ8musrgiY1MFdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="136528067"
X-IronPort-AV: E=Sophos;i="6.25,145,1779141600"; d="scan'208";a="136528067"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
 by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 11:03:32 +0200
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 3 Jul
 2026 11:03:32 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE817.infineon.com
 (172.23.29.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 3 Jul
 2026 11:03:32 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.043; Fri, 3 Jul 2026 11:03:32 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <weijie.gao@mediatek.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Subject: RE: [PATCH v6 1/7] mtd: spi-nor-ids: Correct flash flags for ESMT/EON
 flashes
Thread-Topic: [PATCH v6 1/7] mtd: spi-nor-ids: Correct flash flags for
 ESMT/EON flashes
Thread-Index: AQHc/Jlf2JBwehz5N06ixsn9vXvgT7ZbmczQ
Date: Fri, 3 Jul 2026 09:03:31 +0000
Message-ID: <d8dfad96296b4654b206e08dc2156600@infineon.com>
References: <cover.1781508530.git.weijie.gao@mediatek.com>
 <3facbb0d047ffeab20aacee385ce137bb8894716.1781508530.git.weijie.gao@mediatek.com>
In-Reply-To: <3facbb0d047ffeab20aacee385ce137bb8894716.1781508530.git.weijie.gao@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 03 Jul 2026 14:59:42 +0200
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

> All currently supported ESMT/EON flashes supports 4KB sector and dual rea=
d.
> EN25Q80B also supports 1-1-4 quad read.
>=20
> Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25Q80B.pdf
> Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25QH128A%20(2T=
C).pdf
> Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25S64A(2SC).pd=
f
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
> v6: removed SPI_NOR_QUAD_READ from incompatible flashes
> v5: not changed
> v3-v4: updated commit message
> v2: not changed
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index c0fa98424aa..0dacb4abdbc 100644
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
NOR_DUAL_READ) },
> +       { INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K | SPI_=
NOR_DUAL_READ) },
> +       { INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, SECT_4K | SPI_=
NOR_DUAL_READ) },
> +       { INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, SECT_4K | SPI_=
NOR_DUAL_READ) },
> +       { INFO("en25s64",    0x1c3817, 0, 64 * 1024,  128, SECT_4K | SPI_=
NOR_DUAL_READ) },

In our discussion in previous revision [1], only en25qh128 supports 1-1-4
read and program, but you set QUAD_READ flag in en25q80b instead. Please fi=
x.

Thanks,
Takahiro

[1]
https://patchwork.ozlabs.org/project/uboot/patch/64ce1a920dc067717de2b39d2e=
7a5098e6853aab.1781164951.git.weijie.gao@mediatek.com/

