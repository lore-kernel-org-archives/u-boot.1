Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE4DC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 12:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CC01877F2;
	Tue, 12 Dec 2023 13:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ry4yudSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E904F87732; Tue, 12 Dec 2023 13:34:10 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308C6877F8
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 13:34:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5d3644ca426so54657577b3.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 04:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702384447; x=1702989247; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AeILVhWGoK7Bh7S4uBJJXAMNK4U3GJ4VTSqycTsKJmc=;
 b=Ry4yudSVq8QRmKqC/3hRGikKJ53/O5VQuRp0iOxlrOvJOaQqCWWss+jy1IUcLTY85p
 TCxJo9LPZCMUZL+bRLWbNE2nPpWsgLOf7Tcymq3G2+1l2sJ3FE+ibRomJk5G/0jaVI6d
 ungrzp3/j4Xj0YRRQaPGr3PFoDeNxzVoP2mwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384447; x=1702989247;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AeILVhWGoK7Bh7S4uBJJXAMNK4U3GJ4VTSqycTsKJmc=;
 b=arh7AHNLacz/6iGW1lWpWWLP+JoGVy8uUmQvUSqbgEHsa/c7a7GdP5G4aHC9pei+7E
 yPd9uK5Ab954IAkQ0I6i7xIUXwhEZhUlMhTnZc+MemD8A6f0idDTwLS9oji6cs5v0NRs
 rAew7hxEs2bbm0/rcPFBG3BY6w2cX6xkFvEItV6KUIdivZuhtoH2Wf2XJB/b9LT1XOF4
 cq6IlbFaOJTETPd183w6o1xNZ+oywc4eiNIUpLLYtMbzeBNj/AKMIC8HsnxlINjQafwI
 Ch55OCB6xyketT//Q0DcknmMOENbJii5g6AqZsHcXHV/E1PikjHUsFQGdjJHz9zLIcrc
 6hJA==
X-Gm-Message-State: AOJu0YyENPxK6aPkDz/iOSTtJEkdWUPFuhLGFXaCs49rkIUa7QVW7xvP
 89RGKX8UAOMSh45zbKWG+V2nMbBZnNWiWUqujd8=
X-Google-Smtp-Source: AGHT+IHb3QivZxdgFt7Cec/hJXUN68zW1UjYpHoUKPqtplmlBUvMEAu10i5ujh3MnFVq5fztuU737Q==
X-Received: by 2002:a25:76cb:0:b0:db7:dad0:76ca with SMTP id
 r194-20020a2576cb000000b00db7dad076camr4067092ybc.102.1702384446753; 
 Tue, 12 Dec 2023 04:34:06 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4e19-645a-5f86-e6ef.res6.spectrum.com.
 [2603:6081:7b00:6400:4e19:645a:5f86:e6ef])
 by smtp.gmail.com with ESMTPSA id
 g93-20020a25a4e6000000b00da10d9e96cesm3230147ybi.35.2023.12.12.04.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 04:34:06 -0800 (PST)
Date: Tue, 12 Dec 2023 07:34:04 -0500
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 vigneshr@ti.com, sjg@chromium.org, git@amd.com
Subject: Re: [PATCH 0/7] spi-nor: Add parallel and stacked memories support
Message-ID: <20231212123404.GY2513409@bill-the-cat>
References: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
 <CAMty3ZDF4aGNmrQe1FBJQs3AZo+8kWVBPFwUMJFCrrbcXBot7Q@mail.gmail.com>
 <4f7abda1-5069-44c3-9552-1ddd0c6cd263@amd.com>
 <CAMty3ZDfaiTKMv4od52Czmha8=10V44iROx-PA=Mh3L6OeB7SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uziGA38AWA4lhtSC"
Content-Disposition: inline
In-Reply-To: <CAMty3ZDfaiTKMv4od52Czmha8=10V44iROx-PA=Mh3L6OeB7SQ@mail.gmail.com>
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


--uziGA38AWA4lhtSC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 06:58:14PM +0530, Jagan Teki wrote:
> On Wed, Dec 6, 2023 at 6:11=E2=80=AFPM Michal Simek <michal.simek@amd.com=
> wrote:
> >
> >
> >
> > On 12/6/23 13:24, Jagan Teki wrote:
> > > On Fri, Aug 18, 2023 at 9:51=E2=80=AFAM Ashok Reddy Soma
> > > <ashok.reddy.soma@amd.com> wrote:
> > >>
> > >> This series adds support for Xilinx qspi parallel and stacked memeor=
ies.
> > >>
> > >> In parallel mode, the current implementation assumes that a maximum =
of
> > >> two flashes are connected. The QSPI controller splits the data evenly
> > >> between both the flashes so, both the flashes that are connected in
> > >> parallel mode should be identical.
> > >> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1=
 in
> > >> nor->flags.
> > >>
> > >> In stacked mode the current implementation assumes that a maximum of=
 two
> > >> flashes are connected and both the flashes are of same make but can
> > >> differ in sizes. So, except the sizes all other flash parameters of =
both
> > >> the flashes are identical
> > >>
> > >> Spi-nor will pass on the appropriate flash select flag to low level
> > >> driver, and it will select pass all the data to that particular flas=
h.
> > >>
> > >> Write operation in parallel mode are performed in page size * 2 chun=
ks as
> > >> each write operation results in writing both the flashes. For doubli=
ng
> > >> the address space each operation is performed at addr/2 flash offset,
> > >> where addr is the address specified by the user.
> > >>
> > >> Similarly for read and erase operations it will read from both flash=
es,
> > >> so size and offset are divided by 2 and send to flash.
> > >>
> > >>
> > >>
> > >> Ashok Reddy Soma (7):
> > >>    dm: core: support reading a single indexed u64 value
> > >>    mtd: spi-nor: Add parallel and stacked memories support
> > >>    mtd: spi-nor: Add parallel memories support for read_sr and read_=
fsr
> > >>    mtd: spi-nor: Add parallel and stacked memories support in read_b=
ar
> > >>      and write_bar
> > >>    spi: spi-uclass: Read chipselect and restrict capabilities
> > >>    spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
> > >>    spi: zynq_qspi: Add parallel memories support in QSPI driver
> > >
> > > This set is a bit hard to go. We need to Sync the Linux SPI-NOR tree
> > > and let Linux approve the parallel and stacked otherwise it is very
> > > difficult to maintain.
> >
> > Linux thread is here and it is pretty close to be merged.
> > https://lore.kernel.org/all/20231125092137.2948-1-amit.kumar-mahapatra@=
amd.com/
> >
> > DT binding is already approved but have no clue how big effort is to sy=
nchronize
> > it. When was it synchronized last time?
>=20
> It wasn't. U-Boot spinor has its own and makes changes accordingly. It
> would be better to sync the Linux. This is what I'm referring to here.

Is anyone actively working on that? Under the assumption that no one is,
I really don't want to block all progress in this subsystem until a new
person steps up to start reworking everything.

--=20
Tom

--uziGA38AWA4lhtSC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV4UzIACgkQFHw5/5Y0
tyzgpAv/fp6xu3LttgXeIGgrNHFXjgfguxTWk1E70kLXIrqumwI+7npxOrYbGTnA
QLCLnNZFl1YWMGY43V+XQ6O8mRkR7DieTFIScnicde8UTm4jLDATbhGErRpw1oQt
Qh2w+gorgnRaQ4oqLxhCfgM13rS8zNAhco1Tfde4gd2t8srBIoQrFD9ykvm1BfOc
u4yTFRnZF/5tHuSYMhY00ZLlp1iDVVTG1sAuVE2A7/vJhoOYWo93yG9WUkHBr4O7
m08zaX16cNw5U37JVU1+9A2V2rd2AiMeHL5LXWijZq9KlDX585JC0Wxqe6ygd4+v
cgXDAyOeEbe4ZBbeaID1PRBK/4KXOEBPUweC4iS/QwwCq6VwbVEwteLGlIBUIeS+
2yt753Tk6ZmbnwZ577+VGvTtiRQwMOBNgfIHSZ2c+4xAv+wyZ5Wpk9w0B2DHrpMS
gdXeGRgJqx9mTFUj6O93eIcVRkBz9U0KrjvnsLuAjRHowAKHO1oduj8PT3GDQWgF
XPXiv72O
=hew2
-----END PGP SIGNATURE-----

--uziGA38AWA4lhtSC--
