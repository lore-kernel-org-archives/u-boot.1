Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CA6EDE9AB
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 18:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6622A890FC;
	Tue, 10 Sep 2024 20:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nsIULyj1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0D2188F1A; Tue, 10 Sep 2024 20:52:48 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C6E98910F
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 20:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-846cdfbb153so1616231241.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725994361; x=1726599161; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kIM2A//rKPxyQV67rb2L+A6EOEn/opmMnEJG3gJlffQ=;
 b=nsIULyj18Wy3TmXHkFD0fOGenTc/fhfytuVYO0qJaPmXfAFHBpfqQJ4v18PiM8tb1P
 fwreR5nGXUh6vI1CoNNsraUYBdITc4rfPZebEPgjDpEZD9C55k+kFoDeR8GEM8nf/yE+
 Wt2zfRGyiBLK7ozfLQlbPGVs3CePBOsk4G3kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725994361; x=1726599161;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kIM2A//rKPxyQV67rb2L+A6EOEn/opmMnEJG3gJlffQ=;
 b=KAyMhnlws/xTXBGxVwzT12N7s0pEnJfEIDuY3LBfX2J/fthZa9WUIUF6rAv1rFmVmO
 +jxHRF3KnxXomBkEzjVGf7QgRJNQAxedA7Ds6iWVpxbPmahqHsRcnykj1OP8tLY+QcCp
 B0LqLfMGx5d7Fca1pGvCt9K46TI/e8NRwk4U2tjG8dWg4XzDwbbw85XTDQVBaQ1J1P4K
 Eg+6cXTkjsDYlPq6z0V1szFwNtTGqEvy2yp0cgMMFhZIhM1Wn4sCkz3yJiUQ1axXfx97
 o4gcA6wdpCg3tGqKvQV0lh6w35lSCryDpMZH3Hkwt+xNgEXMIqLSUPU/+OZX/oFC1YqR
 DRSA==
X-Gm-Message-State: AOJu0Yz8+oHk01RnWOdPVt/LAhUv6ux1hncnZ7Pi+VA+VEuGXr+mbZUZ
 xYw8Gp90C6+X1WUYW0TLjtYAiZWeSo+noQfl1T1Y5C3VobNNHE7/UwZp1oZohOo=
X-Google-Smtp-Source: AGHT+IGvrKwqsPh7LXqGCZFCO/1Lu3yCQ0+7hR1KtVh1Zdc5b9K6Vn44+o1D757Swa2uKiijVkL7LA==
X-Received: by 2002:a05:6102:3f44:b0:48f:89cc:dd2b with SMTP id
 ada2fe7eead31-49bde1960d3mr13165051137.11.1725994360905; 
 Tue, 10 Sep 2024 11:52:40 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a796cc87sm332349985a.46.2024.09.10.11.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 11:52:40 -0700 (PDT)
Date: Tue, 10 Sep 2024 12:52:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 2/3] buildman: Allow skipping the dtc build
Message-ID: <20240910185237.GM4252@bill-the-cat>
References: <20240815195746.749042-3-sjg@chromium.org>
 <20240816172237.GA1626301@bill-the-cat>
 <CAFLszTh1Nig-hs+Gtxzg8f-=vE1z4BvNSfEyUGtatZohj0pnuQ@mail.gmail.com>
 <CAFLszTgufCxvXjJupqDphcGwJ0gfvrYxQACK3kYRKaumpKgrYQ@mail.gmail.com>
 <20240822141013.GQ1626301@bill-the-cat>
 <CAFLszTiV8Nut06NeJFqT87y8qSTfzMYwxY6vc10+Q6NY6u2m-A@mail.gmail.com>
 <20240902153904.GX2479150@bill-the-cat>
 <CAFLszTi4_=n6SmfN8unNx6DgO+C4HQwpxG8gcWuOGUd4Lna_ug@mail.gmail.com>
 <20240910184242.GL4252@bill-the-cat>
 <CAFLszTjfU8m-dQyXXAHJ0FWGfAMdvF3yYDMOofN87qocY0mRyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qco56PJihI55cCoa"
Content-Disposition: inline
In-Reply-To: <CAFLszTjfU8m-dQyXXAHJ0FWGfAMdvF3yYDMOofN87qocY0mRyg@mail.gmail.com>
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


--qco56PJihI55cCoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 12:45:39PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 10 Sept 2024 at 12:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Sep 10, 2024 at 12:41:11PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 2 Sept 2024 at 09:39, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Sep 01, 2024 at 02:09:39PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 22 Aug 2024 at 08:10, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Aug 21, 2024 at 09:00:25PM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 16 Aug 2024 at 17:53, Simon Glass <sjg@chromium.org> =
wrote:
> > > > > > > >
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Fri, 16 Aug 2024 at 11:22, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Aug 15, 2024 at 01:57:45PM -0600, Simon Glass wro=
te:
> > > > > > > > >
> > > > > > > > > > For most boards, the device-tree compiler is built in-t=
ree, ignoring the
> > > > > > > > > > system version. Add a special option to skip this build=
=2E This can be
> > > > > > > > > > useful when the system dtc is up-to-date, as it speeds =
up the build.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > (no changes since v1)
> > > > > > > > > >
> > > > > > > > > >  tools/buildman/builder.py       | 27 +++++++++++++++++=
+++++++++-
> > > > > > > > > >  tools/buildman/builderthread.py |  4 ++--
> > > > > > > > > >  tools/buildman/buildman.rst     |  3 +++
> > > > > > > > > >  tools/buildman/cmdline.py       |  2 ++
> > > > > > > > > >  tools/buildman/control.py       |  3 ++-
> > > > > > > > > >  tools/buildman/test.py          | 31 +++++++++++++++++=
++++++++++++++
> > > > > > > > > >  6 files changed, 66 insertions(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > > We should probably do this more generically, outside of b=
uildman. We
> > > > > > > > > have scripts/dtc-version.sh and if the system version isn=
't new enough
> > > > > > > > > (and we just need to define whatever the minimum version =
is), then we
> > > > > > > > > build our (not currently that new anymore) dtc instead.
> > > > > > > >
> > > > > > > > Yes I think I did a patch for that ages ago [1], but it was=
 rejected.
> > > > > > > >
> > > > > > > > I'd be very happy for it to be applied as I think it is a b=
etter
> > > > > > > > solution than this one.
> > > > > > > >
> > > > > > > > I see that some poor sod tried to do this in Linux this mor=
ning.
> > > > > > >
> > > > > > > Any thoughts on that patch?
> > > > > >
> > > > > > I'm open to re-considering [1] again, but we need to handle the=
 warning
> > > > > > problem first. That means...
> > > > > >
> > > > > > > Also I do see one problem. Newer dtc version produce a lot of
> > > > > > > warnings, which causes CI to fail. So if we always use the ne=
west
> > > > > > > version, people are going to see a ton of warnings when they =
run
> > > > > > > locally. Am I missing something here?
> > > > > >
> > > > > > Well, it would be great to get our Kbuild logic anywhere close =
to
> > > > > > in-sync again with upstream. But syncing up the disabling warni=
ng flags
> > > > > > shouldn't be too hard.
> > > > >
> > > > > So, coming back to this patch, the nice thing about it is that it=
 is
> > > > > deterministic. So people who build U-Boot and don't want funky
> > > > > behaviour will be happy. It will use the internal dtc by default.=
 To
> > > > > use the external one, you must provide an option.
> > > > >
> > > > > This patch only affects buildman, but as you can see the mechanis=
m it
> > > > > uses is to set the DTC variable, which people can do without buil=
dman.
> > > > > It's just a convenience, but useful enough to have a flag, I beli=
eve.
> > > >
> > > > Wait, that's right, we have DTC as a thing that can be set in the
> > > > environment, so why do we need something for buildman at all?
> > >
> > > It's a convenience. I have found that it speeds things up quite a bit,
> > > so I want to enable it most of the time. But we can't do it by default
> > > and need it to be optional, I believe.
> >
> > I wasn't clear, sorry. Why is:
> > $ export DTC=3D/usr/local/bin/dtc
> > $ tools/buildman/buildman ...
> >
> > Enough?
>=20
> My patch is more equivalent to:
>=20
> DTC=3D`which dtc` buildman...
>=20
> As I said it is a convenience which I want to use all the time,
> including in CI. Are you worried about changing buildman? What is the
> issue here?

My question / concern is why do we need:

>  6 files changed, 66 insertions(+), 4 deletions(-)

When we can do it with zero code changes? And then similar to the
worries I set aside with the "venv" related changes, you're making one
tool be clever and work as exactly as expected (but perhaps in a "do
what I meant, not what I said" manner?) way. If we have "set DTC in
environment, it's always obeyed, can be passed directly to make" but
also "pass buildman a flag to say where dtc is" why do we need the
latter if it should already be working, and I think already is working?

--=20
Tom

--qco56PJihI55cCoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbglXUACgkQFHw5/5Y0
tyw/YQv+LXiUzFF7iSEtiqvEL6stRUuQ0+22ZSGw9YnlLaGiGdl8rKxBsMsfEGsn
LprbdGMr4mWX8k9+50LGTcHLSsRs67vDEt/S37WWTkhCfAnOJyU1E1urIoSs/SxM
IZ1B3LtNBtonKH2Y8Fk4SSwdABtGd/dIiE63p6CbrFWzlLl9OCLDFNKicETmY/ag
3FW+U4bmiw91S6Gb5LYG1EmQTQe6aZ/xgKXXINMGd1ngmXj54xH4Ni1SXEScV8BZ
dP8AQPxquH4HXr6xpHfHu937qpgRPpXLPab1MF81DBILrW70QwcfOXB9RgtLg8Yr
ElJCq9fb89Lmyy0gx2NZvyA0lzXW3IRSjra5voY1cqUCLZw5rAGylMvS1hiOHSUE
qLjqbl6HH/32hcWt3RmlfFr16ywgepo2cKLfGlR9n1ulkuYI5zF8gtLjRbGuQNl2
LQcO5A2DgflaOPoyFDlNc8nJWU48DJP1yuO0LoR3ZrtgKTP/jIl2AVY+Sb0WkfuG
GEmpgXnx
=5PBv
-----END PGP SIGNATURE-----

--qco56PJihI55cCoa--
