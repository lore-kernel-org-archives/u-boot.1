Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F7AC48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 13:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD280880A3;
	Thu, 29 Feb 2024 14:42:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I1nvoUbo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1CD58808C; Thu, 29 Feb 2024 14:42:51 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7C1F880CA
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 14:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-607c5679842so9881477b3.2
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 05:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709214165; x=1709818965; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nbykGsPEjU+QYnY4uciOXDmXHKqwi7IS6izNazauT+4=;
 b=I1nvoUbotMQ/0YFbR5lt3PSBqBsQ4zcqTctFMm49xEc1aXpALkzkeJrq1hCnEq+mXV
 q0HF2PnpsDAw7hO/dVuyMXKQMUOEZAEE0ohnFwGwbHDiiJD5WddWNfzTvbCqUdbfT+Ll
 w/VItguvwjWX9O/8HTE+DAzZUHDEbdSitkxuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709214165; x=1709818965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbykGsPEjU+QYnY4uciOXDmXHKqwi7IS6izNazauT+4=;
 b=ZNqae7NRAVdUsPGh1XV1hUu6wND+x7rgjrVJ0Z0DffVfDsRX1az+9OINvPfu/BzxDO
 ulXvrkXkpWb4K0O3y8A9wsgRkQrr503EQjAKqAnSDQOzclWUsk5exp5d25c95GDSJlua
 XImhNBYsmgU17dcSW+R/WRRzO5fDQoNdTX9bDvsX8L6ApcfPKS0UGjiDw3RUDRRIjdCH
 RLZlBjm2zYiuHvvV8hr3SmbIW6NnR0Ws7FNTwtbo067VNcIeeWebK3v1iUbTdmuQvtnV
 EMNNYa8GiQUDwUEon/5DZVp+CzP6qj6o20ggt4hHrznsnuLueNpVl2Z5N2vbJfFG+2PT
 VFBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk1Gspe/AhVx7p08TiRZ9esb5OJFZJ2XI/2pTnQgDmLJXW4A2IOZH1SrDDLNjuYOcVFjAmSsy8F1eB9rsLj3t3DUtbeA==
X-Gm-Message-State: AOJu0YzmudqGViLqNTTI0L/Wv2yBhCzI1qsXW+t/4V4MlaXXZ4mADJzh
 47oZ7U4wTXP7tt7xr1+fRGN5/hAosCfYVYluJSvDHsdG3+0UU8T0sCwNC9Ufwr4=
X-Google-Smtp-Source: AGHT+IHc84lDh+6L4B3mndYh3li762jxsy0rupbpna6JRyUGhLqjIfWXsDlovhsZapW56W3AqZPBFw==
X-Received: by 2002:a81:8241:0:b0:609:4a87:bf8f with SMTP id
 s62-20020a818241000000b006094a87bf8fmr2362882ywf.51.1709214165324; 
 Thu, 29 Feb 2024 05:42:45 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 y14-20020a0dd60e000000b00608ba371690sm384548ywd.94.2024.02.29.05.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 05:42:44 -0800 (PST)
Date: Thu, 29 Feb 2024 08:42:42 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor@kernel.org>, shawnguo@kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>, Rob Herring <robh@kernel.org>,
 =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
 u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
Message-ID: <20240229134242.GR3040305@bill-the-cat>
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
 <47c12ca3-ea7c-4097-90b5-0333c74b05aa@moroto.mountain>
 <20240228131029.GM3040305@bill-the-cat>
 <CAFA6WYN4sCk9Q66i_n+aXxRkGEbh66dh+Sr_C5SbioQ_s5BBbQ@mail.gmail.com>
 <20240228152034.GN3040305@bill-the-cat>
 <CAFA6WYMkdjE6Vrd2_fV_6Rzj8MOiPhO4EJ4kkik1_9vQnhzMqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NPmvwbC17hPa+obp"
Content-Disposition: inline
In-Reply-To: <CAFA6WYMkdjE6Vrd2_fV_6Rzj8MOiPhO4EJ4kkik1_9vQnhzMqQ@mail.gmail.com>
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


--NPmvwbC17hPa+obp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:17:28AM +0530, Sumit Garg wrote:
> On Wed, 28 Feb 2024 at 20:50, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Feb 28, 2024 at 07:44:42PM +0530, Sumit Garg wrote:
> > > + Shawn, Krzysztof, Conor
> > >
> > > Hi Tom,
> > >
> > > On Wed, 28 Feb 2024 at 18:40, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Feb 28, 2024 at 10:09:13AM +0300, Dan Carpenter wrote:
> > > > > On Tue, Feb 27, 2024 at 04:40:01PM +0100, S=E9bastien Szymanski w=
rote:
> > > > > > Commit 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees =
with
> > > > > > linux") removed the display timings from the board device tree =
whereas
> > > > > > they are still needed by the mxsfb driver.
> > > > > > Add the timings back (the correct ones) in the
> > > > > > imx6ul-opos6uldev-u-boot.dtsi file and remove them from the
> > > > > > opos6uldev.env file.
> > > > > >
> > > > > > Update the opos6uldev_defconfig file so that the LCD turns on a=
t boot.
> > > > > >
> > > > > > Fixes: 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees =
with linux")
> > > > > > Signed-off-by: S=E9bastien Szymanski <sebastien.szymanski@armad=
eus.com>
> > > > >
> > > > > Huh.  This is the commit that did that upstream.
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3Dd9aa4d4fca67823838fe9861456201430c545e69
> > > > >
> > > > > It's interesting how the timings in linux were always slightly di=
fferent
> > > > > from in u-boot.
> > > >
> > > > Thanks for tracking that down, Dan. I'm adding in Sumit and Rob here
> > > > because this is a recent (rather than ancient) example of one of the
> > > > concerns about OF_UPSTREAM.
> > >
> > > I rather think about this as an opportunity to improve with
> > > OF_UPSTREAM. We can feed these kinds of DT ABI breakages to
> > > corresponding Linux kernel sub-arch maintainers. Especially once we
> > > move to OF_UPSTREAM and a sub-arch maintainer profile in Linux kernel
> > > to keep them aware that U-Boot should be considered too.
> >
> > Yes, a more extensive check around when removing information from dts
> > files would be good.
> >
> > > > I think the commit in question can be
> > > > summarized as "remove a bunch of explicit HW information because th=
ere's
> > > > now a Linux Kernel driver that determines that dynamically". What d=
o we
> > > > do next? The old information is in a presumably valid binding still=
, can
> > > > we just put it back and comment that consumers outside of Linux use=
 this
> > > > still so it's not removed again later? Or am I just missing where w=
e can
> > > > instead get this information from the DT still and not need to come=
 up
> > > > with a new driver and subsystems?
> > >
> > > I can see following two paths forward:
> > >
> > > 1) Partially revert the Linux kernel commit to add back the display
> > > timings in DT.
> > > 2) Extend drivers/video/simple_panel.c in U-Boot to add support for
> > > compatible: "armadeus,st0700-adapt".
> > >
> > > If possible then I would be in favour of (2) rather than the current
> > > patch to do this properly.
> >
> > Well, looking at the kernel drivers/gpu/drm/panel/panel-simple.c driver
> > and then our drivers/video/simple_panel.c it sure would be nice if it's
> > just a matter of adding a compatible but I wouldn't be surprised if it
> > ends up needing more information being passed along too?
>=20
> Although I am not a LCD panel expert but looking at the kernel driver
> code [1], the display timings are rather taken from a static data
> structure matching the compatible "armadeus,st0700-adapt".
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/gpu/drm/panel/panel-simple.c#n901

Yes. My point is that it seems like the situation changed from "device
tree provides timings for the platform" to "driver has timing
information for N displays" and so we'll need to do something clever to
avoid including the structs for 5 panels when we'll only ever
(likely...) see one. And that also yes, we'll probably need to add data
for this panel rather than re-use the PANASONIC_VVX10F004B00 data.

> > And I'm going
> > assume there's good reasons for the design change in how the drivers
> > work in Linux now and note that it might make things more challenging
> > for us when we do care about space.
>=20
> I agree it is always going to be challenging to use DT during SPL
> stage which is mostly constrained by limited on-chip RAM.

Well, no. The DT way handled this more efficiently, I think I wasn't
clear enough in my reply.

--=20
Tom

--NPmvwbC17hPa+obp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXgic8ACgkQFHw5/5Y0
tyxQ/wv+INiv+HhYppkkebiVLVQy5tBUU7DAeOf/Q+YNJqu03m4E8SZv16btanYO
Qb0cCs457MVOWo81oi8U0TEoKP9V8GHndbeqoasVE/5M8ZqFPMBNYRAHJNUTEzng
q79odZE2XUj+uAPA6C3bA9d/T6eES7u5LgNkam5o5dQLV+QLsBvdoBkYfVGzIg8z
00DJhA2Rjs8zCFQ6C4FCFm1F/aSFgPkAeSgotZbx3hgQ99W91wF8VjpZEsBYmAjt
D5v041NUkI3XVsQJOYMTPQqrsEpOLJ7E6gJOttJrLAiYL8UJLWuEXdAvAn5dPKhS
57ICkIKi55LUqZ31SIPj521FazulKjNxkszF5FYLTajeTYrTEpn9CaUxTgeCqIXC
hIR4JzLeemgm2l+Xu2bkZQUTns4ESdIhaXAmJe4NkBW9Qe5bnpF3rtQv+94ER1En
0w1h3Tu9oFLl6V4NL69wnOhxONfmywo4Y1lB0YFyBLeukLEUp//I/eJHEEHmSAU2
c/mfrFl2
=1rve
-----END PGP SIGNATURE-----

--NPmvwbC17hPa+obp--
