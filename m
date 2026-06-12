Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CBFCD98D9
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E0788498C;
	Fri, 12 Jun 2026 14:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="MrhD2UZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 578DA839A8; Fri, 12 Jun 2026 11:33:51 +0200 (CEST)
Received: from smtp11.infineon.com (smtp11.infineon.com
 [IPv6:2a00:18f0:1e00:4::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5284D8005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1781256830; x=1812792830;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gbS0Pr+K8VAhBV+GOVWUUlkuNxBer/mdKuVHdNqcgz8=;
 b=MrhD2UZSS2P9A9UxUnYrQSI6hVCH8hTIb1Mblbl8RxoKOGdfzt3mt+Q5
 +7fc1cTpp+9cghGRvVEP6p3en9sGSIw08eTXandlyi+GTe7NoGJ7E04lJ
 TMgVGxn+bJb0clxXowJ5Qd1Rvg7uhQDwaWnGUqJ3TOYUBsUysQ+4yLdVq s=;
X-CSE-ConnectionGUID: YjmLfjiVTe2s/wipsvn5ng==
X-CSE-MsgGUID: td8PgfmvQcyM7t141SpyVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="147011934"
X-IronPort-AV: E=Sophos;i="6.24,200,1774306800"; d="scan'208";a="147011934"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
 by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 11:33:49 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 11:33:48 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.037; Fri, 12 Jun 2026 11:33:48 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <padmarao.begari@amd.com>, <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: RE: [PATCH] mtd: spi-nor: fix dummy buswidth to use data bus width
Thread-Topic: [PATCH] mtd: spi-nor: fix dummy buswidth to use data bus width
Thread-Index: AQHc+ZCceRkf11LmN0qTbzddy+aC0LY6oKnA
Date: Fri, 12 Jun 2026 09:33:48 +0000
Message-ID: <5b3457f2ed784f93ab00e3067d5b95ca@infineon.com>
References: <20260611105339.1595098-1-padmarao.begari@amd.com>
In-Reply-To: <20260611105339.1595098-1-padmarao.begari@amd.com>
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

> In the current implementation, the dummy buswidth is set equal to the
> address buswidth. In case of quad SPI (mode 1-1-4), where the address
> width is 1, the dummy buswidth is also set to 1. Due to this, the
> controller driver introduces 8 dummy cycles on the data line (D0) only
> during a read operation.

Doesn't the controller driver introduce 8 dummy 'clock' cycles that
makes all data lines (D3..D0) idle (typically High-Z) before reading?

>=20
> Since 4 data lines are used in quad SPI mode, the dummy buswidth should
> be set to 4. The controller driver computes the number of dummy clock
> cycles as:
>=20
>   dummy_cycles =3D op->dummy.nbytes * 8 / op->dummy.buswidth;
>=20
> With dummy.buswidth corrected to 4, the controller produces 2 clock
> cycles of dummy spread across all 4 data lines (D0-D3), which is
> equivalent to 8 dummy bit-times, the same as before. This fix applies
> to all bus width configurations (single, dual, quad and octal).

MTD driver converts dummy cycles to dummy bytes by:

    op.dummy.nbytes =3D (nor->read_dummy * op.dummy.buswidth) / 8;

So, if you change the dummy.buswidth, the controller driver will get
same number of dummy_cycles.

>=20
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-cor=
e.c
> index 937d79af64e..19446265cd5 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -264,7 +264,7 @@ void spi_nor_setup_op(const struct spi_nor *nor,
>                 op->addr.buswidth =3D spi_nor_get_protocol_addr_nbits(pro=
to);
>=20
>         if (op->dummy.nbytes)
> -               op->dummy.buswidth =3D spi_nor_get_protocol_addr_nbits(pr=
oto);
> +               op->dummy.buswidth =3D spi_nor_get_protocol_data_nbits(pr=
oto);
>=20
>         if (op->data.nbytes)
>                 op->data.buswidth =3D spi_nor_get_protocol_data_nbits(pro=
to);
> --
> 2.34.1

Thanks,
Takahiro

