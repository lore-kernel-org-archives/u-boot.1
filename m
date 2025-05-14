Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3315C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 16:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0281482998;
	Wed, 14 May 2025 18:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="chexl445";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCCDA829E4; Wed, 14 May 2025 18:06:35 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40F6082162
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 18:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72b7a53ceb6so29492a34.0
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747238792; x=1747843592; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v2S+cVATBJYVmCb5EMvdGeYraVmp44v6PtDR6wsj2hk=;
 b=chexl445jl3CZ+0/sW4MQbMPdb9YagD2TmckC3X7DipUHA1UGPtuEv1QHjPDu19fi4
 vWqGvgWOZKfTb76W65inLf0Glz/F4InrsZgtfP1AsZ5tVrBOMmIUTDeb6mE2aQ2rLrdS
 zQ0hkQ4jT2Io0z+VJMtpDLcMTZ6bYm3gB8r4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747238792; x=1747843592;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2S+cVATBJYVmCb5EMvdGeYraVmp44v6PtDR6wsj2hk=;
 b=jac4lABZFI5vExr/UlYiHQWSlHYmFE8ykfbvOGxPhJrj6ub+8L/LlfU0qNxoBg/ax+
 m0NnQYu0/B2kanZ494RV+w2YDxh+xINwaoKjuPOCGPwZy0AuimAP00+gbr5HxPZrotFT
 wrBaCZSIEZ5sjzrFQpHWS/RmYESPaGWmDrS10IY3aKyDe0LsZtJbQ/zj19xsn9MAXT8H
 ibtnK2EGcwLRHKnxSEYtsew3J8VJUV9ERmoHi631z8TR2woyf1HqAXRC8dO+RtRJuQDM
 mw8fivy9+aJdB/+hXLuX4UpSvTFPd4LMJ5dvMAUP93qIskhLXMaJ6dqx+RSmaIcfWK5F
 Eonw==
X-Gm-Message-State: AOJu0Yw94bBThRs0P07z6hywc6iuONyEbYRSZMsVNjnJ2vp8awAErfEq
 ZMKXv+uVzYgUA/PvSVXr3PFzaPsGR8KxnpsDL49c7fGvOHvoql5zfKDSMb8FhE4=
X-Gm-Gg: ASbGnct5S1CfeP2IOUGzZv3ffDGrqYTqQ0nPx6X2EYN5KCHb/iXut92qoM49RGur6QJ
 RpiVJEQaGk8e2FH3D6IReTRwMtmfW21DnsFPR69LcfEHMHp0K/QIiD+4hF5iaC07ZaLk1/a25qu
 scNFuDMr5UHfm4lu4E0jlyDPUoYHO64OHXeR8IIULke23d+D1wTIpqyzDtqVvp0+Zw0dVhMFWWZ
 oBvuu2SIiRG0rCy011hmu3189Rfm7Rs0nOTzqe801PHsFRHCaxshXJUScOOz9dtCGRsaYjAuuFJ
 OLJInY08USjnXwHp9gK3bXuyHINzhFTsv3qyhiMi+Fav8p10oL/K2VA27r1nuA6iRjKRElV+GIf
 SUuWESRDSMt23
X-Google-Smtp-Source: AGHT+IEtd5kPvQfspecSUVF/4g90yPI8ode8P1rEcxU8DcQ3g09xyFlQph3nYK1BBr6rSQs+A5Pckg==
X-Received: by 2002:a05:6830:6213:b0:72b:9140:f6d9 with SMTP id
 46e09a7af769-734ec6e8c1fmr60540a34.4.1747238791865; 
 Wed, 14 May 2025 09:06:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7324e3cbc11sm2319391a34.28.2025.05.14.09.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 09:06:31 -0700 (PDT)
Date: Wed, 14 May 2025 10:06:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano =?iso-8859-1?Q?C=F3rdova?= <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH v2 3/3] py/tests/test_efi_loader.py: execute HTTP testing
Message-ID: <20250514160629.GY603748@bill-the-cat>
References: <20250514074513.3562063-1-adriano.cordova@canonical.com>
 <20250514074513.3562063-4-adriano.cordova@canonical.com>
 <20250514150454.GW603748@bill-the-cat>
 <CAMGU2hXFGEupnEdVRzD7Y-37+cyGbXRK6XKw3dNcECDkjh+6bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p/rRXPjb/9RMRT1A"
Content-Disposition: inline
In-Reply-To: <CAMGU2hXFGEupnEdVRzD7Y-37+cyGbXRK6XKw3dNcECDkjh+6bQ@mail.gmail.com>
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


--p/rRXPjb/9RMRT1A
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 05:33:59PM +0200, Adriano C=F3rdova wrote:
> Il mer 14 mag 2025, 17:04 Tom Rini <trini@konsulko.com> ha scritto:
>=20
> > On Wed, May 14, 2025 at 03:45:13AM -0400, Adriano Cordova wrote:
> >
> > > Execute test_efi_helloworld_net_http
> > >
> > > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> > > ---
> > >
> > > v2:
> > >  - remove --httpserver option
> > >
> > >  test/py/tests/test_efi_loader.py | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/test/py/tests/test_efi_loader.py
> > b/test/py/tests/test_efi_loader.py
> > > index 91f151d09cd..e19920b4fce 100644
> > > --- a/test/py/tests/test_efi_loader.py
> > > +++ b/test/py/tests/test_efi_loader.py
> > > @@ -195,7 +195,7 @@ def test_efi_helloworld_net_http(ubman):
> > >
> > >      Call the do_test_efi_helloworld_net function to execute the test
> > via HTTP.
> > >      """
> > > -    if ubman.config.env.get('env__efi_helloworld_net_http_test_skip',
> > True):
> > > +    if ubman.config.env.get('env__efi_helloworld_net_http_test_skip',
> > False):
> > >          pytest.skip('helloworld.efi HTTP test is not enabled!')
> > >
> > >      do_test_efi_helloworld_net(ubman, PROTO_HTTP);
> >
> > Is this test inverted, or were you unaware of the u-boot-test-hooks side
> > at for example:
> >
> > https://source.denx.de/u-boot/u-boot-test-hooks/-/blob/master/py/travis=
-ci/u_boot_boardenv_qemu_arm64_na.py?ref_type=3Dheads
> >
> > --
> > Tom
> >
>=20
> I am aware, but as the http server is enabled by 1/3 of this series I
> thought this test could default to enabled. Alternatively, or if this
> breaks tests where the http server ip is not correctly picked up, this
> patch 3/3 can be disregarded and instead selectively enable the test in
> u-boot-test-hooks via
> env__efi_helloworld_net_http_test_skip =3D False for at least some boards
> (e.g. the ones with qemu with dhcp).
>=20
> I cared mostly about 1/3 and 2/3 of this series as this would let us test
> the EFI_HTTP_PROTOCOL.

Yes, I'd like to keep this being opt-in on the configuration side. It's
trickier on the real hardware part to also have an HTTP server going
depending on lab setup and restrictions. Thanks!

--=20
Tom

--p/rRXPjb/9RMRT1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgkv38ACgkQFHw5/5Y0
tyzu5gwArUeOV7d85njWKzl6sLapM9jzpWIAfiXVosGpja7hIrH7APzxC/UyF5fC
+rNg5OlHMLnFtZqeCmZphJglmUqeaGfedbMRdHNuUKHt3+chWTAdw/Bhrp6xLcz5
VI4wwUYmxzj6puJgWWhEauZ9wss8TMWIAa1T2pDExvDhjBcSs/H4vjFxOFMF0EUZ
/5AaJyzspUVrNLB+wiP1yYIlQ8cXIFmAvDfb2wUg5FKY7DqK35fHUcVMWeXTkc7N
BXh9VwRr/gQzVzDSOhcF8qBUDqlvAtgIpzjI4ADMvbnhQKwolONRcObdKUSxWhYC
kxYNEaw9hLkJz52Bq01Ztop+nKEMQV8zJXhNwKaGACIsqs8MPcYW1M9hO8BmzU2w
J5DuMLwJkFkPNX6BINbMFXu4PyLFU6OPy0JkjSfMCQ9IM0ccZ8MotnT+ymIoG1yB
8A5/3MDf00uWm4hZwSiWuet6kvo2qAwk5gJ7jITDcac8Rcnn5F5AxwwmrJXahugJ
3wFV4z0u
=PvbK
-----END PGP SIGNATURE-----

--p/rRXPjb/9RMRT1A--
