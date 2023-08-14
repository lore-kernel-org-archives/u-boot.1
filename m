Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DABC001E0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 17:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3994B8697B;
	Mon, 14 Aug 2023 19:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TZ9OK9zP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E5CC8696D; Mon, 14 Aug 2023 19:18:07 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B378696C
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 19:18:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-58c4e337357so6133217b3.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692033483; x=1692638283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DjmY/jqTxtlxSAV/W5GQhhpu5Pfvz9MaO0Awkv3y9kg=;
 b=TZ9OK9zPOyzpJ+wlA4HU7UmVmO1Strozps9nVATetM1/9s50Upd6WnDXpXlUVRj9OP
 w8IasxVtpDXxx0xrr03P6jN2pO5oVqTRtc5+dsI595WmFbzlAy0W3QziUbMPTyXfXTOQ
 7jDfwwuPIaIWCcu5fJZtJ6Jyn2zg4RChtwy68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692033483; x=1692638283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjmY/jqTxtlxSAV/W5GQhhpu5Pfvz9MaO0Awkv3y9kg=;
 b=Vw9TJr7mw1TZKrfpSdQDnLFJ0ZwY5Jlj4pC/YJEhx2GC7ty9dHzNs9iNuAVu0/Xvcz
 XD7T1x08OxcCeqSE+u31UKOwiYcBhdGvoHNSxX9qJUtHPsMQu3kWDKoupiFBKGxv62Hv
 /IYertGVNJlgqrdoBmU68Wt7ReD4RYJY7w6MwVjHyp18C5bl3PqS1qwI52KxdM0vN0X5
 49hXdmKD/63sKF+sGnayg/6qy6u+lcrCSVhskHS2KeOim0HFLu0cKHimZEmX79TMAXld
 wDeEeusA/x4VbPp+5kyVkKwwTAZJZQwo4Kneb9tw8Aq7A/9RCXaoL2VbIPhL2KKDfF88
 qzJA==
X-Gm-Message-State: AOJu0Yxtbe/zsr3/FSsMQygNzs2LVxHBXgYy3+jjYUOrUWAHGwxG4pAm
 xANY5rcmBt2hchG0WkGgCuluBfATH6wtqGOAe7ndSw==
X-Google-Smtp-Source: AGHT+IHDGqc5Gz94/Ztc+SnsBHONoHHEAenHVpqeVtAwTIGzn76oS2JMf4C00Ujk+lcTtLKck05ZkQ==
X-Received: by 2002:a81:7b05:0:b0:586:9f6c:41a0 with SMTP id
 w5-20020a817b05000000b005869f6c41a0mr11263287ywc.14.1692033483309; 
 Mon, 14 Aug 2023 10:18:03 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1d1b-2873-dbaa-7ea0.res6.spectrum.com.
 [2603:6081:7b00:6400:1d1b:2873:dbaa:7ea0])
 by smtp.gmail.com with ESMTPSA id
 w187-20020a8162c4000000b0057a918d6644sm2886934ywb.128.2023.08.14.10.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 10:18:02 -0700 (PDT)
Date: Mon, 14 Aug 2023 13:18:01 -0400
From: Tom Rini <trini@konsulko.com>
To: Julien Panis <jpanis@baylibre.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, tony@atomide.com,
 rogerq@kernel.org, vigneshr@ti.com, nm@ti.com
Subject: Re: [PATCH v4 1/2] musb-new: ti-musb: Handle usb dual-role feature
 as peripheral
Message-ID: <20230814171801.GC3630934@bill-the-cat>
References: <20230621-fix_usb_ether_init-v4-0-5f4977bb7678@baylibre.com>
 <20230621-fix_usb_ether_init-v4-1-5f4977bb7678@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8R/mcT614Qsdntpi"
Content-Disposition: inline
In-Reply-To: <20230621-fix_usb_ether_init-v4-1-5f4977bb7678@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--8R/mcT614Qsdntpi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2023 at 12:40:22PM +0200, Julien Panis wrote:

> This prevents from getting some 'No USB device found' error,
> in usb_ether_init() function for instance.
>=20
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>
> ---
>  drivers/usb/musb-new/ti-musb.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-mus=
b.c
> index 3be3f93dd85d..44697dc31387 100644
> --- a/drivers/usb/musb-new/ti-musb.c
> +++ b/drivers/usb/musb-new/ti-musb.c
> @@ -302,6 +302,7 @@ static int ti_musb_wrapper_bind(struct udevice *paren=
t)
>  		dr_mode =3D usb_get_dr_mode(node);
>  		switch (dr_mode) {
>  		case USB_DR_MODE_PERIPHERAL:
> +		case USB_DR_MODE_OTG:
>  			/* Bind MUSB device */
>  			ret =3D device_bind_driver_to_node(parent,
>  							 "ti-musb-peripheral",

Julien, why don't we support OTG mode here instead?

--=20
Tom

--8R/mcT614Qsdntpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTaYckACgkQFHw5/5Y0
tyw+Zgv/ffO7ttTY1TXn2gnRdnyhwtZXRkDLeqir9Ka1+I4Q9g/cEDqo1mi98PGC
Ktivk0Se7XxzTpLm8Dz62l6qcuRWJT+muLui3WoD30uTn+0BfTLRVFRgPVPiEdvU
XvqgUH31BLdP69k3NQ3zdmFCI/1Q+nGQaAUTENKVwVJuOgWVlqai/dSmkKoP1gtG
ltXSFr6zy75t2uDA8WNecsitEQFWCB2zi6dMRf3TjITjgZ8i5irWc7Te3PqOq7B1
EC+yik51xolBsrZR/dcCdTwGJLWycdPLaQEAxsz2pH28LPJfa7plwZN0lGFx+STQ
qn5FJ7RaLZNlWRncp26r1vFXjO+BqyRspsfEywR2871nY+Cn3UitPkpfgQmTgzsg
jqVUeTgB4gaGfgA93s22XXKZBN6N6FbOqpW5gyf+afmtpLrR2w5h+gn1MNZkXRn/
Q/FnxjxEEwLz1Dv+xJz/S8a3/YHqCb2eKms/ZMTEtyJR6ZW4wKWBtO1kbmByEYU9
voZmDOie
=jn2q
-----END PGP SIGNATURE-----

--8R/mcT614Qsdntpi--
