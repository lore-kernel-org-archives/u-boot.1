Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB8ACD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C2D838D7;
	Mon, 11 May 2026 14:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="IJ4eU7MU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B8E284836; Mon, 11 May 2026 10:49:47 +0200 (CEST)
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75F0984706
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1778489385; x=1810025385;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sSvNBgeE7r2JiH0CqzN3HMbJn9RbMp46qgcqh6IiQ9E=;
 b=IJ4eU7MUgneiXaHgEfXfI+Y3adjxOkb8rlknG/dCRrFemXnpq8rL+nSG
 qQX7IWrJP6f9Wmql7s5m1I7Kj3RGi9uWmonljwWzOYKSjywfn6ytWiRyK
 ZDtfWusJz66xaiVBzmDaT95B2y/HukNOfWgpSuecPSo7ozsxeI3r7ROi0 w=;
X-CSE-ConnectionGUID: M0mx8gNsRhetDF6p/WIQyA==
X-CSE-MsgGUID: 0PeASiB0SAiDTQ+mzk7dow==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="157058864"
X-IronPort-AV: E=Sophos;i="6.23,228,1770591600"; d="scan'208";a="157058864"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 10:49:44 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 10:49:43 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.037; Mon, 11 May 2026 10:49:43 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <vigneshr@ti.com>
Subject: RE: [PATCH] mtd: spi: bootstd: Staticize and constify driver ops
Thread-Topic: [PATCH] mtd: spi: bootstd: Staticize and constify driver ops
Thread-Index: AQHc3m4F6KbL0qLTGUmkBaQSHH3RFLYIiHTw
Date: Mon, 11 May 2026 08:49:43 +0000
Message-ID: <e9e05152495a4d9a984c9d7299615354@infineon.com>
References: <20260507220817.209253-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507220817.209253-1-marek.vasut+renesas@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 11 May 2026 14:50:48 +0200
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
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/mtd/spi/sf_bootdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/spi/sf_bootdev.c b/drivers/mtd/spi/sf_bootdev.c
> index 017a74a3016..6ace4ee0aed 100644
> --- a/drivers/mtd/spi/sf_bootdev.c
> +++ b/drivers/mtd/spi/sf_bootdev.c
> @@ -57,7 +57,7 @@ static int sf_bootdev_bind(struct udevice *dev)
>         return 0;
>  }
>=20
> -struct bootdev_ops sf_bootdev_ops =3D {
> +static const struct bootdev_ops sf_bootdev_ops =3D {
>         .get_bootflow   =3D sf_get_bootflow,
>  };
>=20
Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>

