Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F28CD98C6
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 02:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E6548491C;
	Thu, 11 Jun 2026 04:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="kVX7mQv5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BE0D848DC; Thu, 11 Jun 2026 04:45:55 +0200 (CEST)
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9409B8489D
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 04:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1781145951; x=1812681951;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zhtYNSBRrTceQPcdcBeyLSTwXReRKskaLImpTcEiidc=;
 b=kVX7mQv5is+FYc/c3ElTtFxJo20Jvo9cJB+Gvb9UkIGz//XgM+cawF7Y
 gZ/tOSC21NUJaMzhvqSQXdsBFSkjwTLwmDFdVJYhpPkCbHmokx9Zwu+9C
 J0daJUzxjZzS13ysV6McfEPqwIhxxuxc94UG0zmBo0U7Lb2Bf/tTN+Ut2 4=;
X-CSE-ConnectionGUID: ajFpwnSDQ+2j0IOCom3hZg==
X-CSE-MsgGUID: GpvS23ypQvKJ6ITwbvi6dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="161840797"
X-IronPort-AV: E=Sophos;i="6.24,198,1774306800"; d="scan'208";a="161840797"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 04:45:51 +0200
Received: from MUCSE816.infineon.com (172.23.29.42) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 04:45:50 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE816.infineon.com
 (172.23.29.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 04:45:50 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.037; Thu, 11 Jun 2026 04:45:50 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <weijie.gao@mediatek.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Subject: RE: [PATCH v4 2/7] mtd: spi-nor-ids: Add support for ESMT/EON
 EN25QX128A/EN25QH256/EN25QX256A
Thread-Topic: [PATCH v4 2/7] mtd: spi-nor-ids: Add support for ESMT/EON
 EN25QX128A/EN25QH256/EN25QX256A
Thread-Index: AQHc6/Uy3DNbgECqLkmdkgUlciZBOLY4u5IA
Date: Thu, 11 Jun 2026 02:45:50 +0000
Message-ID: <73f99433f3844d498e2343b601b5dfc7@infineon.com>
References: <cover.1779678003.git.weijie.gao@mediatek.com>
 <92f133108a19a9fc360d04baa47ef441c91743f3.1779678003.git.weijie.gao@mediatek.com>
In-Reply-To: <92f133108a19a9fc360d04baa47ef441c91743f3.1779678003.git.weijie.gao@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 11 Jun 2026 04:54:05 +0200
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
> EN25QX128A/EN25QX256A are 128Mb/256Mb flash devices with Quad interface a=
t
> max 104MHz clock rate.
> EN25QH256 is 256Mb flash device with Quad interface at max 50MHz clock ra=
te.
> Both flashes supports 2.7-3.6V voltage range.
>=20
> These flashes are tested on MediaTek's filogic platform.
>=20
> Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25QX128A(2V).p=
df
> Link: https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25QH256A(2R).p=
df
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
> v2-v4: updated commit message
> ---
>  drivers/mtd/spi/spi-nor-core.c | 1 +
>  drivers/mtd/spi/spi-nor-ids.c  | 5 +++++
>  include/linux/mtd/spi-nor.h    | 1 +
>  3 files changed, 7 insertions(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-cor=
e.c
> index 937d79af64e..e4f78e740ba 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -758,6 +758,7 @@ static int set_4byte(struct spi_nor *nor, const struc=
t flash_info *info,
>         case SNOR_MFR_ISSI:
>         case SNOR_MFR_MACRONIX:
>         case SNOR_MFR_WINBOND:
> +       case SNOR_MFR_EON:
>                 if (need_wren)
>                         write_enable(nor);
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index 7d96adab4fd..fcc546fb5ae 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -95,6 +95,11 @@ const struct flash_info spi_nor_ids[] =3D {
>         { INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +       { INFO("en25qx128a", 0x1c7118, 0, 64 * 1024,  256,
> +              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_=
HAS_LOCK | SPI_NOR_HAS_TB) },

I have noticed that lock feature is only available for ST/Micron/SST chips =
now.
(please double-check, sorry if I missed something...)
If you need lock feature for EON chips, please test it and add EON to lock
support.

> +       { INFO("en25qh256",  0x1c7019, 0, 64 * 1024,  512, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +       { INFO("en25qx256a", 0x1c7119, 0, 64 * 1024,  512,
> +              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_=
HAS_LOCK | SPI_NOR_HAS_TB) },

Same here.

>         { INFO("en25s64",    0x1c3817, 0, 64 * 1024,  128, SECT_4K | SPI_=
NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  #endif
>  #ifdef CONFIG_SPI_FRAM_FUJITSU
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 4eef4ab0488..02fa72fb401 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -33,6 +33,7 @@
>  #define SNOR_MFR_SST           CFI_MFR_SST
>  #define SNOR_MFR_WINBOND       0xef /* Also used by some Spansion */
>  #define SNOR_MFR_CYPRESS       0x34
> +#define SNOR_MFR_EON           CFI_MFR_EON
>=20
>  /*
>   * Note on opcode nomenclature: some opcodes have a format like
> --
> 2.45.2

Thanks,
Takahiro

