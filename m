Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B11E6FE3D
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 18:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6992988D2F;
	Fri,  6 Sep 2024 20:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OtlUN0vq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56D1188D10; Fri,  6 Sep 2024 20:34:39 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 961BD88D2F
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 20:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a99de9beb2so48092485a.3
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725647675; x=1726252475; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XAEJFBDul/KKZljFLN6nLCuQBCKrCedDITgdtnEe2CE=;
 b=OtlUN0vqCWmhUxQZbLgYEATuPShAR6QEGdCRlOk5ffVbX37k77LIwIxJ8qVsSEcIM7
 v3TITlkEhIxgNpHtGUDYTQW/FqV+tjYOQ7RwSRc+0z7GQi54mLxZ/HXWMdQ09zKlHvgI
 qQIo/gC2ExR9h8+eGgcYCne+tbzi/1aMVmpoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725647675; x=1726252475;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAEJFBDul/KKZljFLN6nLCuQBCKrCedDITgdtnEe2CE=;
 b=ps4DUhj5avj8Gh6wpfRS38Vm+Tq7xoBIh5pP4ECaGR4g6y7gfiIeVvekJ0lg9cklV6
 bSVRiq0NDxsReJwpxsxOLlFIoQlWZ3PDdx4D3yFO0c/Y9judyHTdcjIhxBg/vRHqyxS1
 wY5zRD7xxjRD+GRPA5/+UBSJUMqJldI6x1hZYgMoFJ9T0zyVh4L8RGQmp/KkqPEu1kno
 zpQFk0zmZcTiHAiL4mf2fiQpl/32BfW6DBa7ezXBNA7ok7TDeDWSZYu5Ar+46RCqwHVX
 5PNlVMKPlOH0vqPats9gAKr+OphENVqVSCZ1fJvhT4N6/FRNCNOuzt86ZAyajF9/8p1m
 3z+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdy8x+YkrkDt7Z9bzA9/Z2RRrPWPkl1OgAoReDGb12isJLX1BuWyVDoycAHI7l3hf46uwVSLg=@lists.denx.de
X-Gm-Message-State: AOJu0YzZQeYl7vkoBYR3WxIojQogfrFKJIS1UupMTmWX4LgtcOn+d8pP
 Nx5vWShSfbIUeHb8tQtJ8mah8Tg+y/s2ZznzL9orIfDsAUXP8hTVNNC9n9nvO8o=
X-Google-Smtp-Source: AGHT+IFGXj++gvdReCOBCBvv88nDO1HZt+2QVNnW+4tzJ6JTBI2TpHTpnFQtDbUHC4S5YwxbxOZBjQ==
X-Received: by 2002:a05:620a:1b9b:b0:7a9:a1b5:2711 with SMTP id
 af79cd13be357-7a9a1b52948mr139798185a.54.1725647675380; 
 Fri, 06 Sep 2024 11:34:35 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a3971106sm714185a.91.2024.09.06.11.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 11:34:34 -0700 (PDT)
Date: Fri, 6 Sep 2024 12:34:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] video: Add parentheses around VNBYTES() macro
Message-ID: <20240906183432.GG3879073@bill-the-cat>
References: <1628fc37-2c9f-493d-82c2-9bf225f2645a@moroto.mountain>
 <20230809013930.GR3630934@bill-the-cat>
 <CAPnjgZ3cooZZGKryY5UwBpd7O2kL5W1z++QxQf-Z304eaKvzUg@mail.gmail.com>
 <20230919151456.GL305624@bill-the-cat>
 <20240902101759.3c4a3c64@xps-13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k4XZtCqjlttDKtak"
Content-Disposition: inline
In-Reply-To: <20240902101759.3c4a3c64@xps-13>
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


--k4XZtCqjlttDKtak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2024 at 10:17:59AM +0200, Miquel Raynal wrote:
> Hello,
>=20
> trini@konsulko.com wrote on Tue, 19 Sep 2023 11:14:56 -0400:
>=20
> > On Mon, Sep 18, 2023 at 07:04:41PM -0600, Simon Glass wrote:
> > > Hi Tom, Dan,
> > >=20
> > > On Tue, 8 Aug 2023 at 19:39, Tom Rini <trini@konsulko.com> wrote: =20
> > > >
> > > > On Wed, Jul 26, 2023 at 09:54:08AM +0300, Dan Carpenter wrote:
> > > > =20
> > > > > The VNBYTES() macro needs to have parentheses to prevent some (ha=
rmless)
> > > > > macro expansion bugs.  The VNBYTES() macro is used like this:
> > > > >
> > > > >       VID_TO_PIXEL(x) * VNBYTES(vid_priv->bpix)
> > > > >
> > > > > The * operation is done before the / operation.  It still ends up=
 with
> > > > > the same results, but it's not ideal.
> > > > >
> > > > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > > Reviewed-by: Simon Glass <sjg@chromium.org> =20
> > > >
> > > > In that this seems correct:
> > > >
> > > > Applied to u-boot/next, thanks!
> > > >
> > > > But I want to note that with gcc-13.1 (and binutils 2.40) or more
> > > > specifically the kernel.org arm/aarch64/etc toolchains, this causes=
 the
> > > > generated code to change:
> > > >    aarch64: (for 1/1 boards) all +8.0 text +8.0
> > > >             bananapi-m5    : all +8 text +8
> > > >                u-boot: add: 0/0, grow: 1/0 bytes: 8/0 (8)
> > > >                  function                                   old    =
 new   delta
> > > >                  video_post_probe                           248    =
 256      +8
> > > >
> > > > So I don't know that this was a harmless bug. =20
> > >=20
> > > Hmm I should have read the comment directly above...
> > >=20
> > > "Note we omit the outer brackets to allow multiplication by fractiona=
l pixels."
> > >=20
> > > Having said that, it doesn't seem to matter getting (if indeed we do)
> > > a less accurate result. =20
> >=20
> > But we should fix the comment then, or decide no, this is intentional.
>=20
> One year has passed and I just stumbled upon this incoherency. It would
> be nice to clarify the comment or otherwise to revert Dan's patch if
> judged irrelevant in the end.

I guess at this point I vote for fixing the comment.

--=20
Tom

--k4XZtCqjlttDKtak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbbSzQACgkQFHw5/5Y0
tyzBKgv+PvY2PtzyzIogLyPk9CrRWrfZqOhFBUh9aehAHFX31KyE221hHi6WWlrL
bmmqBwq6hSqS1+puVSQcLu/Eth5cerVTwgLEf+mEUh+kgutO48BnU6na+96AMFBp
r05idzx1/4OzRKErUTfzX5j/FmlAb55uC0a6J+lL4SbTHR36wT7eRNQZhgqrzMw8
zV0pAMrUX8x9EpZaXF16TM5SxrI49Us12od5YerO51aqYWSZjLAe7vaOiIANtJDL
EsBMRUh85HSES6NVCDlgy8882EzyWu72o0WUFzypvyH4SZ5+hsWhQo426K6CqLvS
uFlbKXRA2eaChPYO7nRb6X71O9gn0VuIlh72fvv1HT2l/Awwk8iUNxLVaifBz0IJ
3GDuHI93NsX0azt8nFPg34cATFEyHV4WY0IRPs7nFNa0h9eot6ZYO38Q9HTADniy
f3K1sfwsNwHC71Zfo6iFOrwnCCPTN/849cNOt7nVaBVT5JKNDeCQ0maZ28w1QjKC
3kWAQzB5
=QBBJ
-----END PGP SIGNATURE-----

--k4XZtCqjlttDKtak--
