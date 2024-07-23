Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21939C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 14:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75AB588868;
	Tue, 23 Jul 2024 16:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l+SkN/e8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F9F888871; Tue, 23 Jul 2024 16:21:02 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AFB88811C
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 16:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7035c367c4cso2998661a34.2
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721744458; x=1722349258; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wq/2PoNqalacxaLYaogvyffSzPSn7gX5YOUUsC2qOTs=;
 b=l+SkN/e8cX9GmfmV0ivefqGwa4BMmnF84iMmSJ/R9N2VjgWPdhKtcMA08MEDuTuH+5
 3wOZSIU7JWhocjSdHH38cFmUpDZATOvuZqeq+Y7Rh6lgL4IpFgNlnoDFoBAVYXL3c3xh
 TkPqgCwxjv5JO9XCJlsJ0OFvLsUSAMovVRtuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721744458; x=1722349258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wq/2PoNqalacxaLYaogvyffSzPSn7gX5YOUUsC2qOTs=;
 b=W16ccS57X2kJrwcJD6w4vYZFvElYZje/pUCKCSfadYu+1Zbb0Mi0tgSROCOLB74MOC
 MVThsOPTVqmIXv+ehHrymTwDZe+9Si1XDCCve8XfUVJXOEewMFWYlI+zr+n4bt9jTSPa
 pJDZxj7URYG3RfsmNLTj2jREUH+fMVQBHp+sfEOl+eEHCs98IMfwq4DRnycKBeb/PhkC
 5q0/7L1Cl9lynuQKkSRMY1FPdra20eiOPCPOEU2IQxjmapGmZTIEYmYAO+14aB7CC0bI
 JdWRl3cgCH/+Fgbhngvnf/NBHAlA9V7ShN/iX/UXoGOYVrmFA9efd0RR7w4On6nVy+im
 OhEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURhxHhLLkVjlHwN0LtMhj9/LaCG65x03H/lWZUTBy/I0pg1zpmRSmOg7g2HgMYyHuf4+J0vnHJ+XH3zYrjtnBihj3pHA==
X-Gm-Message-State: AOJu0Yx1Xbty+zPWHpAUz0ymXsZ2/wTNg1yPNGsQ0WCcWs2+kz6T7Ky2
 P+rOckI99gIVOAEgDkhQYtvmhhx9tOgsKuP0LtxQn5e8ZI8yOOVo1ktB+AQ4kUN9cxnSv2t94+z
 9HJQ=
X-Google-Smtp-Source: AGHT+IGFibFJ4hFPUTutYkLlEE/Py5i9x0V9aFIafFTElbVQjOsvGdVDGTt9iCtI/M4+J+wwZL+Llw==
X-Received: by 2002:a05:6830:b87:b0:703:5e1f:8f8c with SMTP id
 46e09a7af769-7090092dedfmr13348213a34.18.1721744457865; 
 Tue, 23 Jul 2024 07:20:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f60ee136sm2060200a34.47.2024.07.23.07.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 07:20:57 -0700 (PDT)
Date: Tue, 23 Jul 2024 08:20:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH v2 38/48] lib: Kconfig: add a config symbol for
 getting lmb memory map updates
Message-ID: <20240723142055.GG989285@bill-the-cat>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-39-sughosh.ganu@linaro.org>
 <20240705195057.GP38804@bill-the-cat>
 <CAC_iWjJDwFLMaP=S=z_OMnnQb=q32QMEPoywxPWwjixMSbJ84Q@mail.gmail.com>
 <CADg8p946kVK_BfrSvEgFcvQh95MCRMBKJ+48syCnCSvrpJQ0-w@mail.gmail.com>
 <CAFLszTiYALCrgBUBJ=g_BoQtOzHGx2OhuTxCioCHdXNuJb850w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9227qXLFPLew9TDa"
Content-Disposition: inline
In-Reply-To: <CAFLszTiYALCrgBUBJ=g_BoQtOzHGx2OhuTxCioCHdXNuJb850w@mail.gmail.com>
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


--9227qXLFPLew9TDa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 01:42:59PM +0100, Simon Glass wrote:
> Hi Sughosh,
>=20
> On Mon, 22 Jul 2024 at 13:59, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >
> > On Mon, 22 Jul 2024 at 18:00, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Fri, 5 Jul 2024 at 22:51, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jul 04, 2024 at 01:05:34PM +0530, Sughosh Ganu wrote:
> > > >
> > > > > Add a Kconfig symbol to enable getting updates on any memory map
> > > > > changes that might be done by the LMB module. This notification
> > > > > mechanism can then be used to have a synchronous view of allocate=
d and
> > > > > free memory.
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > > Changes since V1:
> > > > > * Change the description to highlight only LMB notifications.
> > > > > * Add a separate line for dependencies.
> > > > >
> > > > >  lib/Kconfig | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > >
> > > > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > > > index 7eea517b3b..b422183a0f 100644
> > > > > --- a/lib/Kconfig
> > > > > +++ b/lib/Kconfig
> > > > > @@ -74,6 +74,16 @@ config HAVE_PRIVATE_LIBGCC
> > > > >  config LIB_UUID
> > > > >       bool
> > > > >
> > > > > +config MEM_MAP_UPDATE_NOTIFY
> > > > > +     bool "Get notified of any changes to the LMB memory map"
> > > > > +     depends on EVENT && LMB && EFI_LOADER
> > > > > +     default y
> > > > > +     help
> > > > > +       Enable this option to get notification on any changes to =
the
> > > > > +       memory that is allocated or freed by the LMB module. This=
 will
> > > > > +       allow different modules that allocate memory or maintain =
a memory
> > > > > +       map to have a synchronous view of available and allocated=
 memory.
> > > >
> > > > This needs to be select'd when it's going to be used, opting out of
> > > > making sure memory reservations are obeyed isn't a good idea.
> > >
> > > +1 which begs the question, do we need the config option at all ?
> >
> > The config symbol can be used for removing the code for platforms
> > which do not support EFI ?
>=20
> I am still of the so-far firm opinion that this can be done once,
> before booting, rather than maintaining two separate tables as we go.

Did you see the part in the thread where he explained the multiple entry
points that would need to be kept in sync?

--=20
Tom

--9227qXLFPLew9TDa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmafvEcACgkQFHw5/5Y0
tywz1QwAjL8PcFc0SixgOgU8C23D5Oo7pDLrv34iE9Cj57oYDbImupxg3jIYYMxV
r9p/dkQRE0g4xvIMrA7O1DN8L5+SUgaFVLSRFagEHr1RWq2faApZ820ADYjrGn0a
iPqS1eQE/m6ZGA1sBAcPCJwTfvslkGnQOCKuuZnbt9yqkhXa5KuwtOiK3SoUc6Kn
5de1Wu9Q9nvAew5dh68x4EQeztZ15r1+G2Uf/YXgahUPon3uXGXsJC4pnTi0Ar7y
2A8tQGo9IF/+6v/cQqNgy4v/jPz3+rbaW/t0of4t/5Dhi1wxNUw4Yfd9O2MVUaEf
nRtHj4hEP2Qom2hosWeea2sJfYxTHVsnwkzFtA6Fen40WMq54MEDEV/PSkayuMCV
5cTprgwHDhXHT9uKOF8QfRwQeyZjnrj4czNsXV1j6FTefoarbIAeGHOrHdjdp2RU
3hBUOVB2tKEr38HC6bMY6dMUH/CeM5voIuyKDrm8II3f3NRUa4YOHRd2rnn7rKUD
8OmlRpY2
=D3cq
-----END PGP SIGNATURE-----

--9227qXLFPLew9TDa--
