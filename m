Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F83FC02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 01:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C53F805C5;
	Tue, 14 Jan 2025 02:27:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iJkQwXyG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B044805DA; Tue, 14 Jan 2025 02:27:35 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC3480285
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 02:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6d92cd1e811so51548576d6.1
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 17:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736818051; x=1737422851; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IbOYZzLr5SYrjgR+UXwYrssv7Ju9mz6piCxzXvre7v4=;
 b=iJkQwXyGQda5F43ssyOhdagh2Jy66WCl5C4wV9OOpvXSlLJ74HEp4Xb0xMk0WbsO+P
 FNBrAzQqkEknBpFvwGxN/jN9K4jxi7KS1yA9YU4x+/DdqtGvfSXONftH3EkHM2jkL+8O
 QKjrSbyajUDAJdhE+hZKump+UbqrP5z8BbaA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736818051; x=1737422851;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IbOYZzLr5SYrjgR+UXwYrssv7Ju9mz6piCxzXvre7v4=;
 b=ljf9oWzeUxz96yIt7FgEHRXCTmtYeHcAqXA1NVzhphPJ3CE7po4D1ap94WB5o3bQNj
 IR1Qr+Kjj+SLSdUIn5XAxCkjYPyfdtnV8S/eRNZlzP0c2eJvVjXXEIhfr/krtHSSagcu
 ZUtSZRve1vPl/MW9SbQpVm/rCe45MeHD8obM2x0Btd1XCu7VuJBe3oFbHbdQrFuGFqAx
 r2FRVRbMi1U95hA6jY43Aok/Q6MVrH4jgaAPTtQC2DAsb29LyARNUWmeT39HSfgMxrJu
 A53+V8/30Tw6mt+Ff7aUCMJ8oPPuGD3g6E60KuIN1KRxH5iHcNla5/H/OVMsLpMj710H
 o81A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9zn6C9km4x365nN/Pi82msbdunn/j6Lot2qnqZNeGkf5pxpppoQl6EhKmq6OEOyFPWbMQxP8=@lists.denx.de
X-Gm-Message-State: AOJu0YykFagLykY3ASH8sZoz4pEA9uZEarZ+jsPvPIcMSGE8nEoJFUNk
 8fPYAzplsjecwKbJSp2wUpxbFC/nFObitrCGNm/Ha3t0gpGkPcQ6U4Ss9SrdfIw=
X-Gm-Gg: ASbGncuYz/7letpc+HyIOdQZiqQJuRPRR6OyJqpNS82JRFnb12Ycy1KEqSWPqjR/Gac
 cn9g4Y7wjZDAj/BkPxeNPGA/CWhyPS6gOA8hRJ5KYeWkYc/H+x48qIaRRlQ8xl/jkwlTvTSGD+z
 Bxy1pDklACNjcn3r5LDvUGqS8Ljo6ywzZZdrzcG4vP2cf+ci2xkkm0wtaUJdSn9Z2NUzeug79iz
 bMQAS+2e5Wa3PnsaBc4IXE4I2pG/3RTu3oU+3VU1OYvC4ZadHZcm2ZgbA==
X-Google-Smtp-Source: AGHT+IEazbbQ3miTSA2bwKT9vEOdjGtggopodRvv43wR5LgHEsmN6ScdWYuxaZKuOlRg87V3Wmkqog==
X-Received: by 2002:a05:6214:767:b0:6d8:ad76:497d with SMTP id
 6a1803df08f44-6dfba9f7e23mr177180016d6.10.1736818051428; 
 Mon, 13 Jan 2025 17:27:31 -0800 (PST)
Received: from bill-the-cat ([187.144.100.247])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c8732febasm47756791cf.20.2025.01.13.17.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 17:27:29 -0800 (PST)
Date: Mon, 13 Jan 2025 19:27:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 5/6] cmd: bootmenu: add parameter -e for UEFI boot
 options
Message-ID: <20250114012725.GH3476@bill-the-cat>
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
 <20241127070631.16412-6-heinrich.schuchardt@canonical.com>
 <20250110224554.GA2278614@bill-the-cat>
 <CAM=mAOmee=By9ErZrvk0hVbZyLH_viguu_wMfOsV3LzTwddArw@mail.gmail.com>
 <20250113015108.GT3476@bill-the-cat>
 <CAFLszTh7S=jmezZNwg=b+96+6ravY41iRbgJ_ssJ48nx4d=0QA@mail.gmail.com>
 <20250113192352.GZ3476@bill-the-cat>
 <CAFLszTht-DdniDnZDgMsf7F5oK3X19ahjcNsM6u1-sN-D_8kdQ@mail.gmail.com>
 <20250113203519.GD3476@bill-the-cat>
 <CAFLszTjWf546_gO9UEUzWkc1tFcf70dGw1Oxe=3UCvzgGsWgSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HDsjxRv8zg6lfxCT"
Content-Disposition: inline
In-Reply-To: <CAFLszTjWf546_gO9UEUzWkc1tFcf70dGw1Oxe=3UCvzgGsWgSA@mail.gmail.com>
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


--HDsjxRv8zg6lfxCT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 05:15:08PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 13 Jan 2025 at 13:35, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jan 13, 2025 at 01:09:16PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 13 Jan 2025 at 12:24, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Jan 13, 2025 at 12:01:45PM -0700, Simon Glass wrote:
> > > > > Hi,
> > > > >
> > > > > On Sun, 12 Jan 2025 at 18:51, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sun, Jan 12, 2025 at 08:08:13PM +0100, Heinrich Schuchardt w=
rote:
> > > > > > > Tom Rini <trini@konsulko.com> schrieb am Fr., 10. Jan. 2025, =
23:46:
> > > > > > >
> > > > > > > > On Wed, Nov 27, 2024 at 08:06:30AM +0100, Heinrich Schuchar=
dt wrote:
> > > > > > > >
> > > > > > > > > The bootmenu command can display
> > > > > > > > >
> > > > > > > > > * menu entries defined by environment variables
> > > > > > > > > * menu entries defined by UEFI boot options
> > > > > > > > >
> > > > > > > > > Not in all cases showing the UEFI boot options is desired.
> > > > > > > > > Provide a new parameter '-e' to select the display of UEF=
I boot options.
> > > > > > > > >
> > > > > > > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.or=
g>
> > > > > > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@c=
anonical.com>
> > > > > > > >
> > > > > > > > Very strangely, this leads to the EFI selftest "Executing '=
random number
> > > > > > > > generator'" test failing on Pi 4, where was was passing pre=
viously (and
> > > > > > > > Pi 4 has an RNG, unlike Pi 3), and this is
> > > > > > >
> > > > > > > Do you have a link to the log?
> > > > > >
> > > > > > Here's the failing part:
> > > > > > Setting up 'random number generator'
> > > > > > ESC[0;37;40mESC[1;32;40mSetting up 'random number generator' su=
cceeded
> > > > > > ESC[0;37;40mESC[1;34;40m
> > > > > > Executing 'random number generator'
> > > > > > ESC[0;37;40mESC[1;31;40mlib/efi_selftest/efi_selftest_rng.c(52):
> > > > > > ERROR: ESC[0;37;40mESC[1;31;40mRandom number generator protocol=
 not
> > > > > > available
> > > > > > ESC[0;37;40mESC[1;31;40mlib/efi_selftest/efi_selftest.c(114):
> > > > > > ERROR: ESC[0;37;40mESC[1;31;40mExecuting 'random number generat=
or'
> > > > > > failed
> > > > > > ESC[0;37;40mESC[1;34;40m
> > > > >
> > > > > This might help make the log more intelligible.
> > > > >
> > > > > https://patchwork.ozlabs.org/project/uboot/patch/20240811145209.4=
191404-37-sjg@chromium.org/
> > > >
> > > > Shrug, it's the age old problem of sending raw stdout to a file. It
> > > > looks fine on console as it happens, I was just grabbing from an
> > > > existing log.
> > >
> > > Oh well. I would probably suggest only writing this junk to log files
> > > if we actually need it in there (i.e. something is programmatically
> > > checking), but it seems like this is a different situation from the
> > > one my patch fixes.
> >
> > I mean, yes? The problem here is that the random number generator test
> > now fails, when it didn't before. As far as I know (and I think the rest
> > of us understood?) your problem was that the ANSI sequences exist.
>=20
> Yes, I want them to be controlled, so we can have them when needed
> (e.g. for user benefit, getting the terminal size) but not when not
> needed (CI output, log files, testing that ANSI works, etc.)

Yes, and Heinrich said for the test he wrote he finds having color
sequences to them (and not just the color sequence tests) helpful. That
is literally the only place we have them when not strictly needed AFAIK.
So using one of the countless "strip ansi color sequences from my log"
tool seems the best option here, when bothered by them.

--=20
Tom

--HDsjxRv8zg6lfxCT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeFvX0ACgkQFHw5/5Y0
tyyJTgwAony1cs0Q19/c1sb9UTr+ER0wIywVUlNlvnPHsQaN1PEId/uew+xcSAOJ
D3J7sN6xRWYQj+t50i94cZci0uuTAoZbMssvYO7j1GB+hSwD0IHeDZcCytbbCxN+
U3S87dcPuhOCmLvnZTdf4PuUm4DUTFd/OSKs/O1RUaPNFWth/7E8TDwapPuxFm2D
cMnbZnjOTJZLfGiqFotxAp5CBDLjISpjhfHvaiX3DpBzXpHq+bauMNYCv3NOiOrb
94ztPuEhRWu9ZbTb7ECt5fHv0vADUGYKIZOu2SvM+BGtVu28ymVAYAYo83LUq9Qs
HPSEOVwy9e357m9jrYPoIFs9RJBvkcfnQONJUsnZamWRduc+Xm4BHRd5GJFTnS6L
JGKZjeGSNTsGnnb9cXzE/dY45BSjORBsxwOZxsFZwhsLgwupBQ9yflhwWIaKCz7z
EKndKH3fB5D1+EYgB8a7nwdkWk+wd7nfjbJdi956QTTy8Vs4AhUR433Ay/HvW4LK
psBxfyHw
=S698
-----END PGP SIGNATURE-----

--HDsjxRv8zg6lfxCT--
