Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3EFF01822
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 10:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 249A483F2E;
	Fri,  6 Mar 2026 11:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="j43JVY7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F23F83F75; Fri,  6 Mar 2026 07:36:40 +0100 (CET)
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9748081E18
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 07:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1772778999; x=1804314999;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BEfonpQIHcxUm+15ee0IYNjzdu6tha2DeIS+ZsLyG+g=;
 b=j43JVY7Wf2jOS8PGcdwXr/7qEJZu8ETAePepG0v7pob+86oUd8jIheze
 VHX3fOkz1EctqBgWywPedW7KOgtyfhpIDuav3D1c1I3tKpr+xm5gV4qKz
 ZlUpcaGvNjnO3Cl/hWkHeJrYyptynxKvzAKgWOKkvi/xAQZtlAyaAoPqb w=;
X-CSE-ConnectionGUID: ytdBAMCaTtqUAPRh7NXSTw==
X-CSE-MsgGUID: LrCHaXNrR/S1YQnvcTEcfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="146897882"
X-IronPort-AV: E=Sophos;i="6.23,104,1770591600"; d="scan'208";a="146897882"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 07:36:38 +0100
Received: from MUCSE811.infineon.com (172.23.29.37) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 6 Mar
 2026 07:36:38 +0100
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE811.infineon.com
 (172.23.29.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 6 Mar
 2026 07:36:37 +0100
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.037; Fri, 6 Mar 2026 07:36:37 +0100
From: <Takahiro.Kuwano@infineon.com>
To: <flaviu.nistor@gmail.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <tudor.ambarus@linaro.org>, <trini@konsulko.com>,
 <venkatesh.abbarapu@amd.com>, <jeyu@issi.com>, <miquel.raynal@bootlin.com>,
 <christoph.reiter@evk.biz>, <yangshiji66@outlook.com>,
 <marek.vasut+renesas@mailbox.org>
Subject: RE: [PATCH] mtd: spi-nor: Add gd25lx128j chip
Thread-Topic: [PATCH] mtd: spi-nor: Add gd25lx128j chip
Thread-Index: AQHcpjYb/ODlyZoBXk65crlxcyQ8+7WhGU/w
Date: Fri, 6 Mar 2026 06:36:37 +0000
Message-ID: <44d8d5c78d914c27affafd8a32107bca@infineon.com>
References: <20260225090651.25912-1-flaviu.nistor@gmail.com>
In-Reply-To: <20260225090651.25912-1-flaviu.nistor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 06 Mar 2026 11:20:36 +0100
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

> Add gd25lx128j GIGADEVICE chip to spi-nor id table.
>=20
> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index 3bcb0d7b7ba..b79cbcb2858 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -202,6 +202,8 @@ const struct flash_info spi_nor_ids[] =3D {
>         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
>         {INFO("gd55lt02g", 0xc8661C, 0, 64 * 1024, 4096,        SECT_4K |
>         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
> +       {INFO("gd25lx128j", 0xc86818, 0, 64 * 1024, 256,        SECT_4K |
> +       SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},

This device is 128Mb (16MB) that doesn't require 4-byte addressing.
Is 'SPI_NOR_4B_OPCODES' really needed?

>         {
>                 INFO("gd25lx256e", 0xc86819, 0, 64 * 1024, 512,
>                      SECT_4K | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)
> --
> 2.43.0

Thanks,
Takahiro


