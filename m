Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9483AEE4996
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F8DD870A2;
	Mon, 21 Aug 2023 15:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FuEr9lmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F304870A1; Mon, 21 Aug 2023 15:57:51 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84D84870A2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-579de633419so39274287b3.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 06:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692626267; x=1693231067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A2aOWGHDCgK7LVAobmaoj16Z/v7mK6zAZjXBC/4hk9Y=;
 b=FuEr9lmwZLClaIXA/+MKkiB2wKfMe38vnf3khOGrw+5tcbZrriNvkE4RVmVLPHu7hG
 ko0Okyi6G/V8wyqJHBNJKVyAFSWmPGFalYC+wbXD3HKhIyJwqjkAwpsRSxhWspIY0g+r
 pKgGwjYXUhRLYF9jRZghCZe3FOMso9OrlF48M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692626267; x=1693231067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2aOWGHDCgK7LVAobmaoj16Z/v7mK6zAZjXBC/4hk9Y=;
 b=KAcPWV1qep8LYzrLaTNYhqq6ZuXhkknReizzYLwxmENRlUu/SZK519QLOlltvkVn+R
 0D/W/M+eGFTf2lbUMUlrtqWHD3MZjp4BCCBSjjyiZHHaX8aBK6t6jLPeJ5t91gTXa1MQ
 gnPCd7C7QkYU0970iP2WF/qqL1P8LxyNSLS7C+lya1I/afDvd5OiDTP1jsNnU2N3dTJk
 DqAv8vPvl55AQtJytofPfCAz+kgWl7dlYTFjDaojbOz9PuO9CJQ5ucINCycIPvv9MEms
 fuwMf9AFW+FbWae8QlzKPrEAkBCTJ1q7YELh9fIvYnMHdKlsI4QwABQXSSBYzk9AvWpF
 UeuA==
X-Gm-Message-State: AOJu0Yy/8+rnl0J80kl+Dlff8Wo2mS81tXBKlf7tRBaZm1Rt/SAUrgLe
 ZfkzPFYVZXEVNM9dkVs8jutJbQ==
X-Google-Smtp-Source: AGHT+IF/xKb0E8HLy5kgg4N2/9Rgk1wONf9lpAX0r4IBtxZg7ABaJz9a9/BKk6LG5KGsiIyUN0tCmQ==
X-Received: by 2002:a0d:eb09:0:b0:577:2f3f:ddbb with SMTP id
 u9-20020a0deb09000000b005772f3fddbbmr7559532ywe.47.1692626267193; 
 Mon, 21 Aug 2023 06:57:47 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-49e5-7fcb-0da2-d03f.res6.spectrum.com.
 [2603:6081:7b00:6400:49e5:7fcb:da2:d03f])
 by smtp.gmail.com with ESMTPSA id
 t125-20020a0dd183000000b005837fe8dbe8sm2228832ywd.8.2023.08.21.06.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 06:57:46 -0700 (PDT)
Date: Mon, 21 Aug 2023 09:57:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>, Julien Panis <jpanis@baylibre.com>,
 "Bin Liu [EP]" <b-liu@ti.com>
Cc: Marek Vasut <marex@denx.de>, stephan@gerhold.net, u-boot@lists.denx.de,
 tony@atomide.com, vigneshr@ti.com, nm@ti.com
Subject: Re: [PATCH v4 1/2] musb-new: ti-musb: Handle usb dual-role feature
 as peripheral
Message-ID: <20230821135744.GA3953269@bill-the-cat>
References: <20230621-fix_usb_ether_init-v4-0-5f4977bb7678@baylibre.com>
 <20230621-fix_usb_ether_init-v4-1-5f4977bb7678@baylibre.com>
 <20230814171801.GC3630934@bill-the-cat>
 <500449e0-0d65-44b4-aa0b-3596292f79e3@baylibre.com>
 <927fff06-3474-080a-5d9e-3624e6f39d43@kernel.org>
 <d2bd9445-27a5-3424-bf92-d5e31d0acdde@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v4CVyIt28YJ5E5+W"
Content-Disposition: inline
In-Reply-To: <d2bd9445-27a5-3424-bf92-d5e31d0acdde@denx.de>
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


--v4CVyIt28YJ5E5+W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 03:40:42PM +0200, Marek Vasut wrote:
> On 8/21/23 14:16, Roger Quadros wrote:
> > Hi Julien,
> >=20
> > On 21/08/2023 11:28, Julien Panis wrote:
> > > On 8/14/23 19:18, Tom Rini wrote:
> > > > On Thu, Jul 06, 2023 at 12:40:22PM +0200, Julien Panis wrote:
> > > >=20
> > > > > This prevents from getting some 'No USB device found' error,
> > > > > in usb_ether_init() function for instance.
> > > > >=20
> > > > > Signed-off-by: Julien Panis <jpanis@baylibre.com>
> > > > > Reviewed-by: Tony Lindgren <tony@atomide.com>
> > > > > Reviewed-by: Nishanth Menon <nm@ti.com>
> > > > > ---
> > > > >  =A0 drivers/usb/musb-new/ti-musb.c | 1 +
> > > > >  =A0 1 file changed, 1 insertion(+)
> > > > >=20
> > > > > diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-ne=
w/ti-musb.c
> > > > > index 3be3f93dd85d..44697dc31387 100644
> > > > > --- a/drivers/usb/musb-new/ti-musb.c
> > > > > +++ b/drivers/usb/musb-new/ti-musb.c
> > > > > @@ -302,6 +302,7 @@ static int ti_musb_wrapper_bind(struct udevic=
e *parent)
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 dr_mode =3D usb_get_dr_mode(node);
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 switch (dr_mode) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 case USB_DR_MODE_PERIPHERAL:
> > > > > +=A0=A0=A0=A0=A0=A0=A0 case USB_DR_MODE_OTG:
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Bind MUSB device */
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D device_bind_driv=
er_to_node(parent,
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 "ti-musb-peripheral",
> > > > Julien, why don't we support OTG mode here instead?
> > > >=20
> > >=20
> > > Roger, can this be achieved with this controller ?
> >=20
> > The Controller supports OTG mode but I'm not sure of the u-boot driver.
> >=20
> > Bin / Stephan might know.
>=20
> Surely the controller supports both Host and Peripheral mode.

And perhaps the other half of the disconnect here is that DWC2/DWC3 at
least behave in U-Boot as Marek is asking.

--=20
Tom

--v4CVyIt28YJ5E5+W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTjbVUACgkQFHw5/5Y0
tyxlaAv7BgI4VPR52UaYsGDn7sQlbhbZifbX2p5XFOHy+y4+U+xyR8Mll7HSzu1c
OXClkIhN8wC8F/4y/T3cWEFXbV6clBdmnZmW4lNx4kJDjwtfSB0j0lZybT9I01tF
+NzYB2/uDx45yYcruAAt69DTYnHfjvODjOkvluZ2RHrKKASo+oCyUPLp3fzNbPHY
XBmvF0/1nMo/u5isO7FWPka2exXv7K+OopHeIuuEDYnj3fwWgkJ6/zeyJ+qgusTw
ZEw5d7etleLVgfbzmVg5QBVWF4KDxESJaOro0EAXKxiWUL2M6ouKgX1v8MK8S67z
xVqkO0VkKYEIjMgcBtHA8OnLNUJtc+tTM0w5+UINy54B3sz2oQRd2TVbVQ1S8XRz
+vcLpK5BLjWzBXaBTesIBykLk7VBpWBjSItvTv0UGE0EOEicmdtq//Tn6pHT0DQJ
Jgny+mxKuqeAaB0/xxPgcQ/FT1W3qS2f2p7SetGqxAXw8aIrL8RId9kpMNuUsRbX
HmliQnAk
=3/7a
-----END PGP SIGNATURE-----

--v4CVyIt28YJ5E5+W--
