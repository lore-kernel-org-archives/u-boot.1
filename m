Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA8CC3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 14:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD2C388498;
	Thu, 22 Aug 2024 16:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bMkVIF85";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4477F884CC; Thu, 22 Aug 2024 16:10:20 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02C0A88216
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 16:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5dca9cc71b2so570862eaf.2
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724335817; x=1724940617; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SnXxv5aZtBOLdfBQ/CB6vjufsEnOoikoedhvlo1ST90=;
 b=bMkVIF851jkoDN/rQ535dJo331Ku/8USddwPeEwHTemT06nJahVo9gDBB9/hkODyZT
 2A+P+LdERJRSROccAmhK3enjdyI69+sShb/dPbD5kaKTuHGVG82AOBjCpm6d92ALIZnG
 AF93EqdDwb/Qz0PXjfPiwTmIigIzQ9BAtQfnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335817; x=1724940617;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SnXxv5aZtBOLdfBQ/CB6vjufsEnOoikoedhvlo1ST90=;
 b=If3jkOuzb47hCWNWYpMOCVXQkwCE9O4dO452y2ODV0v5NGPA3CJL5EXOimFTzrQtDr
 zKEECirweLmVcNc/H+NfocACbXCpWaKmjgN1ee5F5InaeqlQBKdCqiIyCkKyZo8+Yerm
 28Epp5da6ghh5z0TDrZ3N9rhZoCLPpekP/tvD704hUkg3fR5OBCLzxCdDU2PRtBJswR0
 sfhhIiaYoBxiDllGhoRZywQH3h/hdSmJM79vSB3FqNI+KR6eVdsgWpe5KOTZPjm3u43d
 yYyQWL4uHNx/HgR8Pa2Cq3syG/BEuVbsZFN1AAbBNrP5T9bh9X1Qufi6V/lYOa2Uy22w
 ZuwQ==
X-Gm-Message-State: AOJu0YxPsJ9AZTqZnkIHBGzXnM1WYhAjO7RK09Rmhc98kxD/k8SarIyI
 rKM45WMPtsi0V4zubhC0nXovdbaYWJtIRXGvWlzj0Ws7zEH4dwPXbDNfW4eRYPo=
X-Google-Smtp-Source: AGHT+IHeddxGp71hEACbulnvwXuD9tHMc5pGaGm3maEYdBKG9Sl5cWMEFHOaiOeAhlsBZb0pC5z8iw==
X-Received: by 2002:a05:6820:2298:b0:5d5:b49c:b6f7 with SMTP id
 006d021491bc7-5dca06877e8mr7773153eaf.7.1724335816236; 
 Thu, 22 Aug 2024 07:10:16 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-236.totalplay.net.
 [187.190.197.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5dcb5e68643sm280631eaf.32.2024.08.22.07.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 07:10:15 -0700 (PDT)
Date: Thu, 22 Aug 2024 08:10:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 2/3] buildman: Allow skipping the dtc build
Message-ID: <20240822141013.GQ1626301@bill-the-cat>
References: <20240815195746.749042-1-sjg@chromium.org>
 <20240815195746.749042-3-sjg@chromium.org>
 <20240816172237.GA1626301@bill-the-cat>
 <CAFLszTh1Nig-hs+Gtxzg8f-=vE1z4BvNSfEyUGtatZohj0pnuQ@mail.gmail.com>
 <CAFLszTgufCxvXjJupqDphcGwJ0gfvrYxQACK3kYRKaumpKgrYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MSmtpBbrgiVSaJqh"
Content-Disposition: inline
In-Reply-To: <CAFLszTgufCxvXjJupqDphcGwJ0gfvrYxQACK3kYRKaumpKgrYQ@mail.gmail.com>
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


--MSmtpBbrgiVSaJqh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 09:00:25PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 16 Aug 2024 at 17:53, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Tom,
> >
> > On Fri, 16 Aug 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Aug 15, 2024 at 01:57:45PM -0600, Simon Glass wrote:
> > >
> > > > For most boards, the device-tree compiler is built in-tree, ignorin=
g the
> > > > system version. Add a special option to skip this build. This can be
> > > > useful when the system dtc is up-to-date, as it speeds up the build.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  tools/buildman/builder.py       | 27 ++++++++++++++++++++++++++-
> > > >  tools/buildman/builderthread.py |  4 ++--
> > > >  tools/buildman/buildman.rst     |  3 +++
> > > >  tools/buildman/cmdline.py       |  2 ++
> > > >  tools/buildman/control.py       |  3 ++-
> > > >  tools/buildman/test.py          | 31 +++++++++++++++++++++++++++++=
++
> > > >  6 files changed, 66 insertions(+), 4 deletions(-)
> > >
> > > We should probably do this more generically, outside of buildman. We
> > > have scripts/dtc-version.sh and if the system version isn't new enough
> > > (and we just need to define whatever the minimum version is), then we
> > > build our (not currently that new anymore) dtc instead.
> >
> > Yes I think I did a patch for that ages ago [1], but it was rejected.
> >
> > I'd be very happy for it to be applied as I think it is a better
> > solution than this one.
> >
> > I see that some poor sod tried to do this in Linux this morning.
>=20
> Any thoughts on that patch?

I'm open to re-considering [1] again, but we need to handle the warning
problem first. That means...

> Also I do see one problem. Newer dtc version produce a lot of
> warnings, which causes CI to fail. So if we always use the newest
> version, people are going to see a ton of warnings when they run
> locally. Am I missing something here?

Well, it would be great to get our Kbuild logic anywhere close to
in-sync again with upstream. But syncing up the disabling warning flags
shouldn't be too hard.

--=20
Tom

--MSmtpBbrgiVSaJqh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbHRr4ACgkQFHw5/5Y0
tyys/gv8CdLTrahWiMB6kLZl+YAk3hXqC0+fMyQQyQJIoEaVSJgj7FFYkNRdejqn
KXEGkeUDaiFd/58KOqL+NjkPVqJhFgfyu7qiT6RwGxgda3AzKblIsIOG+NXrjQAy
xAl6b6TDH41e3B+qax6xdOXLpbU5OS6xx8A8xcdyFBrpLv8ZaD4vVRjwNhQXpAqZ
vwonLGENLNIqRJXxumeOSWCHbEq1Dn4kwUG2D2SmjNL2kgoFwc7/dge2iDah/uE9
qgoaKHu6Fex/sXLfmI2tjVURbQ7clNsMWNb5a6AZqTURKvsZV+7NAFjRgGlnTfik
l0M0GXNfSlN5KtmWTRJGYLPruljV+WjdgaVro6cVIDU/inzIbaRARuRxYS9HntU3
EpfQCf0ch16+Y5TLDTHtu0Vf/p9ZE9XD/J+dEP+Gzs37I/usV2b/LaDVR78cb0kE
EsoCpMtf8Nj+e9oJNskd/BaNOlVV8KMRxyVkkcGwM94xJ/wPzub3sU023sIESnRZ
9zMidZi8
=GKYL
-----END PGP SIGNATURE-----

--MSmtpBbrgiVSaJqh--
