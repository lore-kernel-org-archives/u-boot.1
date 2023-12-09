Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C15BC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 18:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C45428744F;
	Sat,  9 Dec 2023 19:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Plqu1Stj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C9188753A; Sat,  9 Dec 2023 19:49:22 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 716E287215
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 19:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5df49931b4eso7175567b3.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 10:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702147758; x=1702752558; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=esaY8CLRRwjuhArDkpJAMjE21JZIpEQkk+HutMZXjXA=;
 b=Plqu1Stj8XYMjlmWdv4ZLwOvtYhHnH2WXcAPjuMDu9PXTVKxIPQQj452OH3gEDBXXw
 ikcBF1SftVegD+iC1xJNXbOKO8FoG8CQUzW7gIbIlK2WVVThgQohrUSQYnoCw13YDWD6
 +VIW46fXw1CkG0I45VbILHzhv03L7WqnQk/2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702147758; x=1702752558;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esaY8CLRRwjuhArDkpJAMjE21JZIpEQkk+HutMZXjXA=;
 b=QhQX0KH+bmqgtP8Iyqxdu9OPJmQdC7LUOib/aDgEX0WU1aMPsOJ7hfXvaeZl29JEt8
 ss/DDFQOdtU4tblKQjf196wg+VDNTlT2k+3ZfXddb3vcaMiE94xlfxIVRK0fSahvjaDr
 Eh2Uhm3JJH+yFjiZfkYq+9MduLv0zlDEDazho8VDrkEoHEsHqUHaAg18v8pOQ5ghZ8Ww
 9XmSutPlnDa/LGOimeg/5HmpH+egB6ql9eBedrZS0acJXhw1NVDXTxD4ffUoyOQ6WJHN
 ku/3aFoBOEvuIoLUDxq9jHaoC65wxHelwMkik2FHEFAp52NBHQoMIPS/tT8UUnBtLGwm
 PzIQ==
X-Gm-Message-State: AOJu0YzZHvsqZrHvmh5jxxcYR4CWHCEnEHqRSEbUHYiGuPaUaRDDkx76
 +D42QCflxVz7npRb6ifhm2jTeg==
X-Google-Smtp-Source: AGHT+IHV8kIqTvJz1HIvIcyPCaewZIr+pOGJXnDxcPgyA8hDlpE1UGe5Rnd64SHSsqlCdqHIEK/RRg==
X-Received: by 2002:a05:690c:3405:b0:5df:5d59:60bd with SMTP id
 fn5-20020a05690c340500b005df5d5960bdmr692763ywb.28.1702147758122; 
 Sat, 09 Dec 2023 10:49:18 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a81d249000000b005d72c7c1241sm1624226ywl.112.2023.12.09.10.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 10:49:17 -0800 (PST)
Date: Sat, 9 Dec 2023 13:49:15 -0500
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, sean.anderson@seco.com,
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com,
 mark.kettenis@xs4all.nl, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/2 v2] smbios: Fallback to the default DT if sysinfo
 nodes are missing
Message-ID: <20231209184915.GY2513409@bill-the-cat>
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2PtQQ81x-SqMs6NKSjMKFGShT65Rrtfc-CDOsdBxgJDQ@mail.gmail.com>
 <CAC_iWjJ52eK-v30T6XC1jHDDLvcuOX0p43PW8UCfakRPxMkQCw@mail.gmail.com>
 <CAPnjgZ2Ubr6kNfn+7bg+F_CV4H_wZMKaPq8F8njSfQNUF02+iA@mail.gmail.com>
 <CAC_iWj+X9Kw=1YOX0bny01JwkzCSyeZ6PB2-r_V-2TisgVG7WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qvls0D6tmIF4iOSv"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+X9Kw=1YOX0bny01JwkzCSyeZ6PB2-r_V-2TisgVG7WQ@mail.gmail.com>
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


--qvls0D6tmIF4iOSv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 06:03:14PM +0200, Ilias Apalodimas wrote:
> Hi Simon,
>=20
> On Sat, 2 Dec 2023 at 20:28, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 29 Nov 2023 at 23:50, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > [...]
> > >
> > >> > Changes since v1:
> > >> > - Tokenize the DT node entry and use the appropriate value instead=
 of
> > >> >   the entire string
> > >> > - Removed Peters tested/reviewed-by tags due to the above
> > >> >  lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++=
++---
> > >> >  1 file changed, 90 insertions(+), 4 deletions(-)
> > >> >
> > >>
> > >> Can this be put behind a Kconfig? It adds quite a bit of code which
> > >> punishes those boards which do the right thing.
> > >
> > >
> > > Sure but OTOH the code increase should be really minimal. But I don't=
 mind I can add a Kconfig
> > >
> > >>
> > >> > +
> > >> > +       dt_str =3D ofnode_read_string(ofnode_root(), nprop->dt_str=
);
> > >>
> > >> Could this use ofnode_read_string_index() ?
> > >
> > >
> > > Maybe, I'll have a look and change it if that works
>=20
> Unless I am missing something this doesn't work.
> This is designed to return a string index from a DT property that's defin=
ed as
> foo_property =3D "value1", "value2" isn't it?
>=20
> The code above is trying to read an existing property (e.g compatible)
> and get the string after the comma delimiter.
> Perhaps I should add this in drivers/core/ofnode.c instead?
>=20
> > >
> > > [...]
> > >
> > >>
> > >> Any chance of a test for this code?
> > >
> > >
> > > Sure, but any suggestions on where to add the test?
> > > SMBIOS tables are populated on OS booting, do we have a test somewher=
e that boots an OS?
> >
> > They are written on startup, right? They should certainly be in place
> > before U-Boot enters the command line.
>=20
> Not always.  I am not sure if x86 does that, but on the rest of the
> architectures, they are only initialized when the efi smbios code
> runs. Wasn't this something you were trying to change?

One of those things I keep repeating is that we don't know for sure what
the right values here are until we load the DT the OS _will_ use. It's
quite valid to start U-Boot and pass it a generic "good enough" DT at
run time until U-Boot can see (GPIOs, EEPROM, whatever) what it's on and
what the real DT to load before passing to the OS is. Since U-Boot
doesn't need SMBIOS tables itself, we should make these "late" not
"early".

--=20
Tom

--qvls0D6tmIF4iOSv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0tqsACgkQFHw5/5Y0
tyz89QwAgH1FUxkOb7hs7vo/pvthn3ucDbVwsGkQHsSZDbo2j/ECSzaTWZjtQdO8
so0aZpNQkj11+WqYQnxzRKtJ4QHbaDGxibx6nUFCSTJZB0oPUoQFFhTWysRa/1ai
fSiCypodqU41w2iUk8R/YZBNaso9PSldgtwCuoln42KOMuWnt7na+xQTlARdOwEX
OAGsU5TM73rrQQH5S45QPgkyWltfB1EAPfVMlnxUdhG/bWIsWRWlbmpTCVrHDhhJ
9MwsyfF2WgMHjoO9DjT0cZpResbwPySmtlNagxBU9KzbGLI0nmExsnnzHd3EDcQM
HDQmXsx11mcS7ERMHgZjuE2Gii5BifLEpxZF6U4K4/ajJ4Pv+ypPGZ7nH8yPawTN
J59FAXIPObs5FRir3v2AXhrbdiHjmxbCGxTy5ebcHfJ/cugzloohBa1rrMn53jrH
Dqje42mnZ8BIX5QBZCL2AlVezEDm0LCbQ5Y8gjSj+JshOK2Qm4xmkiD7D8JjmpdC
gidgrL/N
=5L2F
-----END PGP SIGNATURE-----

--qvls0D6tmIF4iOSv--
