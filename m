Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DDEC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E22584B61;
	Fri, 10 Jul 2026 14:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="PBwZnbXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7ECA849F3; Fri, 10 Jul 2026 03:12:03 +0200 (CEST)
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1411F843B6
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 03:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1783645921; x=1815181921;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=o+Jw7oov4f+bcRfZmMJDMcQKDMx9XOkZoFhlQrdVyyU=;
 b=PBwZnbXgaevuExFo/oWUmHneJ7beN8MuXRnQZUhd7pPa9o9qq/lb3omz
 E/Il0Hou8KbnuhEneMmdsh9oMrlSW/kg6AQJz9ISyk5iS3GsFa2EF3EGY
 0Qm0lPbwECTbzQ8tk/l4j+h69tkmys0MgrayLCf2tLMl+ETRgFX0j6vIC 8=;
X-CSE-ConnectionGUID: pYbXOPdhT9afkEA5P4ou9w==
X-CSE-MsgGUID: 7CplJ1MJTECwVTjWF41xKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="100400103"
X-IronPort-AV: E=Sophos;i="6.25,154,1779141600"; d="scan'208";a="100400103"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
 by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:11:01 +0200
Received: from MUCSE818.infineon.com (172.23.29.44) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 10 Jul
 2026 03:11:00 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE818.infineon.com
 (172.23.29.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 10 Jul
 2026 03:11:00 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.043; Fri, 10 Jul 2026 03:10:59 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <ssunkkan@gmail.com>, <vigneshr@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: RE: [PATCH v2] mtd: spi-nor: Add Dosilicon DS25Q4BB support
Thread-Topic: [PATCH v2] mtd: spi-nor: Add Dosilicon DS25Q4BB support
Thread-Index: AQHdDuoJ3FapKXBGpEGZM11ofIx7BbZl86Dg
Date: Fri, 10 Jul 2026 01:10:59 +0000
Message-ID: <8552d3b0188e43fbb5cecdcea78e95ea@infineon.com>
References: <20260614134406.542-1-ssunkkan@gmail.com>
 <20260708145648.329-1-ssunkkan@gmail.com>
In-Reply-To: <20260708145648.329-1-ssunkkan@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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

>=20
> Add support for Dosilicon DS25Q4BB (256M-bit) SPI NOR flash.
>=20
> Link: https://www.dosilicon.com/resources/SPI%20NOR/DS25Q4BB-XXXXX_Rev03.=
pdf
> Signed-off-by: Ssunk <ssunkkan@gmail.com>
> ---
> Changes in v2:
> - Replace Google Drive datasheet link with the official Dosilicon link.
>=20
>  drivers/mtd/spi/spi-nor-ids.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index 31a2ba4..0a63e50 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -87,6 +87,8 @@ const struct flash_info spi_nor_ids[] =3D {
>                     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI=
_NOR_4B_OPCODES) },
>         { INFO("ds25q4dn", 0xe5301b, 0, 64 * 1024, 2048,
>                     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI=
_NOR_4B_OPCODES) },
> +       { INFO("ds25q4bb", 0xe53019, 0, 64 * 1024, 512,
> +                   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI=
_NOR_4B_OPCODES) },
>  #endif
>  #ifdef CONFIG_SPI_FLASH_EON            /* EON */
>         /* EON -- en25xxx */
> --
> 2.53.0.windows.2

Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>

