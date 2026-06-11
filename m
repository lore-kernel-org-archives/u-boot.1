Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26330CD8C9D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 04:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 215E7838BB;
	Thu, 11 Jun 2026 06:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="SDXPRl2M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79DDF84974; Thu, 11 Jun 2026 05:02:46 +0200 (CEST)
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A378489D
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 05:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1781146964; x=1812682964;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=299pltuurisjpN+tlZlbq28dHu7hNu6ksIzJOyN4aA4=;
 b=SDXPRl2MIcuQ/zOCos9wzQ5fmibQ6Ln43Lq5TIp5aDg0IJd/Dgoj8bgb
 gJdHxtLQajDgPJNHHw5+aIOmC1sZPxoD86Bm9cXrdszNa9qT+X8QtEiHT
 bMzNvfV+RSmZBhmSdFty91fRuen0Xrwc+QoeX+eXEu0TfVrryc0Mw4HZO k=;
X-CSE-ConnectionGUID: twOLHxjNSW2ECp//FM1zCw==
X-CSE-MsgGUID: jKOWVJlfQkOnGRn8NZ1nlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="96590352"
X-IronPort-AV: E=Sophos;i="6.24,198,1774306800"; d="scan'208";a="96590352"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
 by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 05:01:43 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 05:01:42 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.037; Thu, 11 Jun 2026 05:01:42 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <weijie.gao@mediatek.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Subject: RE: [PATCH v4 7/7] mtd: spi-nor-ids: Add support for Winbond
 W25Q256JV-M/W25Q512JV-M
Thread-Topic: [PATCH v4 7/7] mtd: spi-nor-ids: Add support for Winbond
 W25Q256JV-M/W25Q512JV-M
Thread-Index: AQHc6/VG04ekCBKXfk2J6oETfjkPH7Y4wuCQ
Date: Thu, 11 Jun 2026 03:01:42 +0000
Message-ID: <d65a58e9c28f421397933994341e52b8@infineon.com>
References: <cover.1779678003.git.weijie.gao@mediatek.com>
 <8d3e9a4b2106b82d9aa15c2abf8b93b3638c11b4.1779678003.git.weijie.gao@mediatek.com>
In-Reply-To: <8d3e9a4b2106b82d9aa15c2abf8b93b3638c11b4.1779678003.git.weijie.gao@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 11 Jun 2026 06:59:54 +0200
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
> W25Q256JV-M/W25Q512JV-M are 256Mb/512Mb flash devices with Quad interface=
 at
> max 104MHz clock rate. DTR is not supported.
> These flashes supports 2.7-3.6V voltage range.
>=20
> Both tested on MediaTek's filogic platform.
>=20
> Link: https://www.winbond.com/resource-files/W25Q256JV%20DTR%20RevK%20102=
02025%20Plus.pdf
> Link: https://www.winbond.com/resource-files/W25Q512JV%20DTR%20RevD%20062=
92020%20133.pdf
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
> v3-v4: updated commit message
> v2: refactored with previous patch. updated commit message
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index 3c183650229..dcb217f2401 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -585,6 +585,10 @@ const struct flash_info spi_nor_ids[] =3D {
>                SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_=
HAS_LOCK | SPI_NOR_HAS_TB) },
>         { INFO("w25q128jv-m", 0xef7018, 0, 64 * 1024, 256,
>                SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_=
HAS_LOCK | SPI_NOR_HAS_TB) },
> +       { INFO("w25q256jv-m", 0xef7019, 0, 64 * 1024, 512,
> +              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_=
HAS_LOCK | SPI_NOR_HAS_TB) },
> +       { INFO("w25q512jv-m", 0xef7020, 0, 64 * 1024, 1024,
> +              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_=
HAS_LOCK | SPI_NOR_HAS_TB) },

Same as EON chip case in another patch.
Looks like this issue existed in the first place. We need to rework lock
feature to support other vendors' chips.

>         { INFO("w25q01jv-m", 0xef7021, 0, 64 * 1024, 2048,
>                SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_=
HAS_LOCK | SPI_NOR_HAS_TB) },
>         { INFO("w25q02jv-m", 0xef7022, 0, 64 * 1024, 4096,
> --
> 2.45.2

Thanks,
Takahiro

