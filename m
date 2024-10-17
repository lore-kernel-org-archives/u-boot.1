Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1527D3C526
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 17:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86FD48909B;
	Thu, 17 Oct 2024 19:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qgCQcL/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 768F488FE4; Thu, 17 Oct 2024 19:55:06 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 476E688E32
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 19:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-46041d86566so8375461cf.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729187701; x=1729792501; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qrq+8UKNGQ3tcjt/J6JjYySiNDAmGpuY+eE+oLTa2rY=;
 b=qgCQcL/RHtUbJzr7h+FvSi7zVOiXGDYRXd+xqMEzD0P3aisbteHFbrpISTcFwbsbAY
 YCEXkXif0PNGnjXv3Y+VE+Wizd6Y4k/DBu1KBs+rIjjxSZPxfJRwPr99FDe0sncCUy6C
 UN1zVd4dGumy3yjG5nchQVsrXNy9cBLYNQKTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729187701; x=1729792501;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qrq+8UKNGQ3tcjt/J6JjYySiNDAmGpuY+eE+oLTa2rY=;
 b=C0uYH8QY/cHpyMkijwqmiMI1Jah40no+WN5ORBRhVTGdIkw6YN8tGWwFpp18tMn5ht
 qR4J1+tMdWTn4aMysDmDPQmO6HRKR/FJdAYgkaGWq+PD2rYCr0ADyzBWRtvUwsKIQb2G
 6nd8Htv4dvP39sRSOyMeGaqR+0NCZsAseC3j3kpcV4auT6ofYaa6thT6hV3EPNRJxgvP
 L8nyH77gAqDLOhkDvbDA7a6AKnKR42i4m1UVgthD4GZTyvDYfTfg1y1QTiO9H/cxXBRj
 A/YiExMKQdQ1Pk7Ft2qTkCWDsIXmKJ+p/roCn0TgilYNKdRCuGbqFJClEI/AcmSiaSHb
 8SGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNE1mjpNV6TGpl783shhe617NgZyIjT1JFCmSGeW8uPtQD7LXZHUQFopJQdCMjFEw9bg1rDnQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzZgiATGf4pjqrZfhU1Ttap2Rh3+KgOi12XWIYUDdOEPSGYv8Jf
 9iH9MYupjz+wWkYFwnnXaFKAtCAv9NZbO6n+4qLOTuu13hzjnSxVqjRjh9hY0y4=
X-Google-Smtp-Source: AGHT+IFBEr4Wp9jRFbMSRgLWHfru1AXXsT4xycNVz5JA1BGIV6WvujqHYBaa5Dcg9907VWvqey3qlw==
X-Received: by 2002:a05:6214:5d08:b0:6cb:7e48:5b60 with SMTP id
 6a1803df08f44-6cc2b8cbf1emr94208346d6.17.1729187699566; 
 Thu, 17 Oct 2024 10:54:59 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc22959b04sm30185616d6.96.2024.10.17.10.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 10:54:58 -0700 (PDT)
Date: Thu, 17 Oct 2024 11:54:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, git@xilinx.com,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH] binman: Add option for pointing to external description
Message-ID: <20241017175455.GP4959@bill-the-cat>
References: <fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com>
 <CAFLszTiBHjqc-xeqsC51hFUed8bigv8+WsC9hUnv_tEC2RahcQ@mail.gmail.com>
 <d2a8f534-a983-4092-8fc2-ce45b54de476@amd.com>
 <CAFLszTjYOoNcMc7MTA-RdR_mKwM+8t=yKRpuYZSfqOvVBA1_PA@mail.gmail.com>
 <a0077320-9c92-44ec-9614-3de1fc1d36a6@amd.com>
 <CAFLszTjt6rrHUzg=evPS5-FyvMrZ1DocwyVc9x1Pq2K9XMokCg@mail.gmail.com>
 <6e7f9046-2e7f-479a-80e1-59e7b20c48f7@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+bOdzak5Qogu0vt3"
Content-Disposition: inline
In-Reply-To: <6e7f9046-2e7f-479a-80e1-59e7b20c48f7@amd.com>
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


--+bOdzak5Qogu0vt3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 07:59:59AM +0200, Michal Simek wrote:
> Hi Simon,
>=20
> On 10/15/24 14:48, Simon Glass wrote:
> > Hi Michal,
> >=20
> > On Thu, 10 Oct 2024 at 07:03, Michal Simek <michal.simek@amd.com> wrote:
> > >=20
> > >=20
> > >=20
> > > On 10/9/24 23:14, Simon Glass wrote:
> > > > Hi Michal,
> > > >=20
> > > > On Wed, 9 Oct 2024 at 07:21, Michal Simek <michal.simek@amd.com> wr=
ote:
> > > > >=20
> > > > > Hi,
> > > > >=20
> > > > > On 10/9/24 03:55, Simon Glass wrote:
> > > > > > Hi Michal,
> > > > > >=20
> > > > > > On Mon, 7 Oct 2024 at 07:05, Michal Simek <michal.simek@amd.com=
> wrote:
> > > > > > >=20
> > > > > > > Adding binman node with target images description can be unwa=
nted feature
> > > > > > > but as of today there is no way to disable it.
> > > > > > > Also on size constrained systems it is not useful to add binm=
an description
> > > > > > > to DTB.
> > > > > > > Introduce BINMAN_EXTERNAL_DTB Kconfig symbol which allows sep=
arate DTB for
> > > > > > > target from DTB for binman itself.
> > > > > > >=20
> > > > > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > > > > ---
> > > > > > >=20
> > > > > > >     Makefile    |  2 +-
> > > > > > >     lib/Kconfig | 10 ++++++++++
> > > > > > >     2 files changed, 11 insertions(+), 1 deletion(-)
> > > > > > >=20
> > > > > >=20
> > > > > > Doesn't this defeat one of the purposes of Binman, i.e. to docu=
ment
> > > > > > images? We do want the .dts to include the image description. W=
hat
> > > > > > sort of problem is this causing?
> > > > >=20
> > > > > We have two boot flows.
> > > > > The first one (default one) is using Xilinx FSBL for SOM initiali=
zation with fit
> > > > > image (DTBS) + u-boot.elf + tfa.
> > > > >=20
> > > > > The second one is using U-Boot SPL instead of FSBL. This flow is =
used by
> > > > > buildroot for example.
> > > > >=20
> > > > > In perfect world I should describe both of these flows. I sent de=
scription for
> > > > > the second as RFC here.
> > > > > https://lore.kernel.org/r/de1b8dbabd5ab7f20d7aac217ec4f5074d39f1d=
a.1728462767.git.michal.simek@amd.com
> > > >=20
> > > > OK I'll take a look.
> > > >=20
> > > > >=20
> > > > > but it is also reasonable to describe the first flow but I really=
 don't want
> > > > > both descriptions ends up in the target image.
> > > >=20
> > > > Why not? Knowing what is in the firmware is one of the goals of Bin=
man.
> > >=20
> > > If this is single binary composition with clear layout then likely fi=
ne.
> > > In our case where we target evaluation boards which can boot out of d=
ifferent
> > > boot devices it will be more confusing.
> > > For these I want to generated all images also for testing purpose not=
 only
> > > images which you will burn to qspi.
> > >=20
> > > > >=20
> > > > > The second part is if you look at RFC and how fit-dtb.blob is com=
posed. It is
> > > > > one DTB + DTBS which are composed from overlays.
> > > > >=20
> > > > > xilinx_zynqmp_kria_defconfig has
> > > > > CONFIG_DEFAULT_DEVICE_TREE=3D"zynqmp-smk-k26-revA"
> > > > >=20
> > > > > That's why binman node should go to this DTB but because other im=
ages are
> > > > > composed with overlays binman node is spread to all DTBs inside F=
IT image.
> > > > >=20
> > > > > It means one binman description is in fit-dtb.blob 14 times which=
 is far from
> > > > > ideal.
> > > >=20
> > > > Yes, but I think what you are saying is that U-Boot doesn't need the
> > > > description, so you don't need it to appear in the dtbs in the FIT.=
 Is
> > > > that right?
> > >=20
> > > Yes.
> > > I know that there is a code around it but as of now I don't want to u=
se any of
> > > this feature.
> > >=20
> > > > If so, then I think we should add a way to remove it, in Binman,
> > > > perhaps with a property in the top-level binman image.
> > >=20
> > > Works for me but keep in your mind that for SOM this should be remove=
d from all
> > > combinations and for me it is easier not to add that description ther=
e instead
> > > of adding it and removing it.
> >=20
> > OK, I think you are saying that the description is repeated in each
> > .dtb since each is built by U-Boot's build system and then they are
> > added to the FIT.
>=20
> yep
>=20
> >=20
> > But what is to stop people from not bothering to fill in the binman
> > description in U-Boot? I worry that vendors will have instructions
> > like 'build U-Boot with the in-tree devicetree, which has no binman
> > node, but pass this option to use this other file (not in mainline,
> > just our special vendor branch), just for Binman's use',
> >=20
> > Where do you plan to keep this other file?
>=20
> In u-boot repo of course. And all configurations which makes sense.
> And pretty much if vendors wants to hide it they can no matter of this pa=
tch.
> I understand your concern but vendors can do it today.

Will resolving this let us finally remove SPL_FIT_GENERATOR as well?

--=20
Tom

--+bOdzak5Qogu0vt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcRT28ACgkQFHw5/5Y0
tyzYaAwAnUn/CJ8Hf1eHo5lCC4reLv9GcWb4aQ19ldWYkAQBCYQiVtFDqO52eWKf
6o2N/RgBGdKEQhN3C7mwc7GQBi+E2uUiForh8WyfUH3AdljLlH7NIprKZo10D2jj
EJYboyAPDS4cfXdl3UQLDVWn1n6PgyHI7jZ765UKrTH4O4rWHe/Yu0jl/f3cv9Xp
xALsFTEIv/8AMjcN/cEG8G0xGBpBB7+bxBHtT0fRQ0bLCArN1KtHMw6sPVYWeqSM
Wt4O4imHjg0uhuoZVaqTbxSpiUWtMlMGwXQglE45F01OzQXEEBb/GkCCc9mXXzE5
vs82kVIztF8iS2hL0BblhkEG9sypKDRBjNMUzxdZj7Westg67hXGaAfRobdNSEBh
8lHTCUXTk/T9eM1HYuULq3Aq9fzsRgSTGFUrslK9i8XphtLaSIltlK4T/pY0Hn7+
xfQQ9KV+r0rWhylyJsiSDnIfE7JDZRJeeuzupB21tPg8hv8QMBxYc+kA5y4wBBpn
xhMNgLt4
=E+tq
-----END PGP SIGNATURE-----

--+bOdzak5Qogu0vt3--
