Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55779C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 12:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02CF184A63;
	Fri,  3 Jul 2026 14:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="QyaV219f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61796846A4; Fri,  3 Jul 2026 10:11:52 +0200 (CEST)
Received: from smtp14.infineon.com (smtp14.infineon.com
 [IPv6:2a00:18f0:1e00:4::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5446843B6
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 10:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1783066310; x=1814602310;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U8/wFXNndzHfe0h/MatgLEdu/7L4PmkNcR8tQCmxSnE=;
 b=QyaV219fWElma9Xfz7yplzbMb1/up1Z+8WDX6Ibz7jb6QBR3xTyAfzvv
 ikC0u4votO1qdZ7LoxQcPbu/bvk6+2Y+qT0PmBiOsmodyFkR6a3JOHXRV
 zZL/d54KrKdT0Nm+EwvKhHhdyOEbQjSKJDDr2P9P5B2Ep7pWZNLn0V7na Q=;
X-CSE-ConnectionGUID: 8aI3WBjySYiJrtoJpNTBNw==
X-CSE-MsgGUID: hKLohnK6QEaiIYpohMVlJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="136520802"
X-IronPort-AV: E=Sophos;i="6.25,145,1779141600"; d="scan'208";a="136520802"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
 by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 10:11:49 +0200
Received: from MUCSE811.infineon.com (172.23.29.37) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 3 Jul
 2026 10:11:49 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE811.infineon.com
 (172.23.29.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 3 Jul
 2026 10:11:48 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.043; Fri, 3 Jul 2026 10:11:48 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <ssunkkan@gmail.com>, <vigneshr@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: RE: [PATCH] mtd: spi-nor: Add Dosilicon DS25Q4BB support
Thread-Topic: [PATCH] mtd: spi-nor: Add Dosilicon DS25Q4BB support
Thread-Index: AQHc/APmUW/o4KdHWESmEKE4zUuI/rZbiSfQ
Date: Fri, 3 Jul 2026 08:11:48 +0000
Message-ID: <5787d9d649b34f74b66a56a067da9760@infineon.com>
References: <20260614134406.542-1-ssunkkan@gmail.com>
In-Reply-To: <20260614134406.542-1-ssunkkan@gmail.com>
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

> Add support for dosilicon ds25q4bb (256M-bit) SPI NOR flash.
>=20
> Datasheet:
> https://drive.google.com/file/d/17UFJa5_3imH0YmWlRGTQYhO2JBXf4Klk/view

Do you have a link to vendor's site? If you have, use Link: tag just above
your Signed-off-by: tag. If not, please write this after the '---' separato=
r.
I don't think it's good to add a link to share drive in commit description.

>=20
> Signed-off-by: Ssunk <ssunkkan@gmail.com>

Could you sign with full name?

> ---
>  drivers/mtd/spi/spi-nor-ids.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index c0fa98424aa..b370e782627 100644
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
> 2.43.0

Thanks,
Takahiro

