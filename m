Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14D5FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 17:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 403E08394E;
	Mon,  4 May 2026 19:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t9Ot/HGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C04B84653; Mon,  4 May 2026 19:35:53 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4012280F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 19:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7dcc9b506d9so4273942a34.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777916148; x=1778520948; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YU1ajWWHfedmhcESJpTiAcJCPqMgtxq+hbbLkD/JPjU=;
 b=t9Ot/HGC2P29ack2GFVxDc9ysghakXwEyB6gzlXNJRcxJjKI+5XiDNNBfMLa5V/uLq
 zCU+16OmAjFTAOeWe+79ZjGJPxyzW87iF37wSo3QTPN9UTlM2O1mJ9qYcawBajl2/W2v
 +/lNxr/dCSrQdg49QriTDxvzdgS2XZsXD5+bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777916148; x=1778520948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YU1ajWWHfedmhcESJpTiAcJCPqMgtxq+hbbLkD/JPjU=;
 b=r94w3tN8Jzt+KJGc3EfUSIVK5IdJ+6K/Jji8T2MhMvI1D5Z2GCn4yu+i5H2RYOuFRe
 ji+MZteeRRRug1+Ry4tHUZoETF5/jRUmiaBA6ViiZga9F1S1jmz4vjzrt1wxNsNvbB1T
 0cahoEOeXF2O5work4dg80byTvVoYpkgI33SEZF4IGz34dU9hiGJ9u/XC0O1yi26cwZ0
 yLUR512yu97g1LoG0DnuLk98COUWHuzashxda3FR5GiRGgdInDrG4dUui7dUnis0p9m7
 GXzWqipdSM7psKBIuZ7zP2Ap4Y7o3Gv40x4zAEa9/CMqnrslajq02bWKhMIQXTBVw7MT
 thTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Iwl/QpXAgsxmdE98+BLLxred4Dx4WyzjI+g+BhJw07Yo7dc+Ag7lAXl+8nGFMf5GsYfT1Xoo=@lists.denx.de
X-Gm-Message-State: AOJu0YyGHh+QRI4owcMGkyg9Q2CFQP8Z7AS/t0xd6XAEkpZozWPmud/0
 67zz1pjK1vuJPhx40cJ0z4gRp41Vrsu8dat++9awAMzLJbNKGWmdgM68lSlRwUPKOBw=
X-Gm-Gg: AeBDiesZRwBjbz0m4apLakEjAzrkv/6X7d/Jvq1wlkYvGHuMg+9Sy0eLRGMxwHaqQo3
 1zS8y+dFY67JtTqHC85DXaBdtYXr8tBTUJDuSV/gn5ifGsZidov6Y7ByJwQmzdTFQ/nSVCI6dIS
 CRyMHNFRllHpotPL/hVjLmw2SeJsijhsOt39w6o5zaTnB3lMqbbsAtxocKmAML9AHM3X5vwWRrz
 Ke6J/apjKDuQNAqefpaYgr8UcSUS7bkgDAP0RwHyNpw4uMFw36+Co0MBabu+fOiBTOXrwhjLC2+
 psNGFm4zRBJpBt3k7lg7u/KJ1G4BHi9jonza5l9OnXdZLOSkMYtIqUoyqOg8yXXlcRhqgQdNRIc
 PbUCWpAMw23fpd0sMLDXI2GDsuSk88S3tsuIQunmquVqZywdivD8WN7bRa2f+aLumquToBsiwZ2
 +/8Kk866c2UnhnTDCRDwn0rN5QveFveoJUHLre0FvFFuVJk9/GFOyhJeeX9dhrOD0Mx/5gGysN3
 Ekr5Z+GKm3eW2BHe8arT5qDMMUlayXYNp4sa0+TTAUKXjMD0gZ+dHvDgbKeOg==
X-Received: by 2002:a05:6820:99b:b0:694:8bfa:7817 with SMTP id
 006d021491bc7-69697db8330mr5571626eaf.53.1777916147907; 
 Mon, 04 May 2026 10:35:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696aacbb5bbsm2652123eaf.15.2026.05.04.10.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:35:47 -0700 (PDT)
Date: Mon, 4 May 2026 11:35:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: Couple of clang warnings for Rockchip boards
Message-ID: <20260504173544.GI1614990@bill-the-cat>
References: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
 <CAFLszTjWZ9DBKVui_2EE-nSg8K+5eC9V8jvwp638dLeyp_p6vw@mail.gmail.com>
 <175e1198-2ac4-48de-b68a-c29f786832cc@cherry.de>
 <CAFLszThQ+kyCkojFm2=VNtLTtLDYT4iVmpqnto8awiMVqsct0Q@mail.gmail.com>
 <20260427144630.GG41863@bill-the-cat>
 <CAFLszTgga6eFp2aPF-MzJEqeqcEV-bMJhb4_ph_bE-1Dv4e_Cg@mail.gmail.com>
 <20260429142547.GT41863@bill-the-cat>
 <eab00828-0e87-4761-afc8-1a3295d18a26@cherry.de>
 <CAFLszTgKRS7xebQ0Y7+fOsTM7aUwnEH55L_H_NbaN_p=70THDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hyjXSlWeAlqtZ7AW"
Content-Disposition: inline
In-Reply-To: <CAFLszTgKRS7xebQ0Y7+fOsTM7aUwnEH55L_H_NbaN_p=70THDg@mail.gmail.com>
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


--hyjXSlWeAlqtZ7AW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2026 at 05:14:13AM -0600, Simon Glass wrote:
> Hi Quentin,
>=20
> On Wed, 29 Apr 2026 at 10:32, Quentin Schulz <quentin.schulz@cherry.de> w=
rote:
> >
> > On 4/29/26 4:25 PM, Tom Rini wrote:
> > > On Wed, Apr 29, 2026 at 08:18:14AM -0600, Simon Glass wrote:
> > >> Hi Tom,
> > >>
> > >> On Mon, 27 Apr 2026 at 08:46, Tom Rini <trini@konsulko.com> wrote:
> > >>>
> > >>> On Mon, Apr 27, 2026 at 11:54:09PM +1200, Simon Glass wrote:
> > >>>> Hi Quentin,
> > >>>>
> > >>>> On Thu, 23 Apr 2026 at 22:24, Quentin Schulz <quentin.schulz@cherr=
y.de> wrote:
> > >>>>>
> > >>>>> Hi Simon,
> > >>>>>
> > >>>>> On 4/22/26 11:57 PM, Simon Glass wrote:
> > >>>>>> Hi Quentin,
> > >>>>>>
> > >>>>>> On Thu, 23 Apr 2026 at 01:26, Quentin Schulz <quentin.schulz@che=
rry.de> wrote:
> > >>>>>>>
> > >>>>>>> Hi all,
> > >>>>>>>
> > >>>>>>> I'm looking into force-enabling CONFIG_WERROR for all Rockchip =
SoCs.
> > >>>>>>> First, let me know if this is a bad idea :)
> > >>>>>>
> > >>>>>> I don't like it, as it makes development slower. I like to see a=
ll the
> > >>>>>> warnings created by a change and tend to fix them iteratively. We
> > >>>>>> already have a warning check in CI. A better approach is to
> > >>>>>>
> > >>>>>> Can you use: KCFLAGS=3D-Werror
> > >>>>>>
> > >>>>>> either in your environment or on the 'make' cmdline?
> > >>>>>>
> > >>>>>
> > >>>>> Well, if it's during development, you can always disable WERROR? =
The
> > >>>>> fact that I've never actually enabled -Werror locally in about a =
decade
> > >>>>> in U-Boot probably isn't a good sign. One of the things that make=
 me
> > >>>>> wary though is compiler updates with new warnings. I've tested wi=
th
> > >>>>> clang 22, don't know when clang 23 is planned to be released. GCC=
 16 is
> > >>>>> about to be released as well.
> > >>>>>
> > >>>>> By having the check in CI, we have a longer-than-necessary feedba=
ck loop
> > >>>>> for contributors. Has this been an issue in the past? /me shrugs
> > >>>>
> > >>>> This is strange though, because people should see the warnings dur=
ing
> > >>>> development. I wonder if it is scrolling off the screen.
> > >>>>
> > >>>> One my bugbears is non-actionable output. When the build succeeds
> > >>>> (with no warnings) I see no output, using 'buildman -I --board xxx=
 -w
> > >>>> -o /tmp/b/xxx' or in fact these days 'um build xxx'. This uses 'ma=
ke
> > >>>> -s' under the hood, so that it doesn't print a huge list of filena=
mes,
> > >>>> etc. I also sometimes do a 'fresh' build with 'um build -F xxx' to
> > >>>> check everything is clean ('buildman -m' does something similar).
> > >>>>
> > >>>> Note that buildman returns exit code 101 if there are any warnings=
, so
> > >>>> the build basically fails.
> > >>>>
> > >>>>>
> > >>>>> No defconfig seems to be setting this option, not sure exactly wh=
y that is.
> > >>>>
> > >>>> To me this is a difference between 'functionality' options and
> > >>>> development options. Putting development options in Kconfig makes =
it
> > >>>> harder to turn them on and off, since you must either edit the
> > >>>> defconfig or edit the .config file. It is easier to just pass an
> > >>>> environment variable.
> > >>>
> > >>> The point of a configuration is that it configures the build. Stuff=
 in
> > >>> environment (directly or make FOO=3Dbar) is a workaround and anti-p=
attern.
> > >>> Having to run one of the config front-end to change the config is a
> > >>> feature, and good thing.
> > >>
> > >> To give an example, we have boards which enable LTO, but it is
> > >> sometimes useful to disable it during development - it used to be a
> > >> huge time sync but something seems to have changed recently, as I
> > >> don't see much of a performance gap now. We don't want people
> > >> disabling LTO in the defconfig, though. The same applies for things
> > >> like V=3D1
> > >>
> > >> So I think there are build features which are of no use to end-users,
> > >> but are helpful for development. That is the distinction we have had
> > >> for a while and it would be a shame to lose it.
> > >
> > > Yes, the LTO thing is a good example of something we shouldn't have d=
one
> > > really. Outside of sandbox you cannot just disable it.
>=20
> Are you sure about that?

Yes. Outside of sandbox LTO is enabled because the platform binaries
will exceed their non-optional size constraints.

> I seldom build with LTO, except for CI. For
> an incremental build the non-LTO is often twice as fast. Most of the
> time when developing new features I am just trying to make things
> work, so it is big time-saver in the IDE. To some extent this is
> changing, though (LSPs and AI tools). The main impact for me is with
> sandbox incremental builds.

We could maybe just drop LTO from sandbox, now that it's enabled more
widely on hardware.

> > >
> >
> > FYI, the Linux kernel defaults to CONFIG_WERROR=3Dy. See commit
> > 3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")
> > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D3fe617ccafd6f5bb33c2391d6f4eeb41c1fd0151).
>=20
> Do we suffer from this same problem?
>=20
> >
> > I wouldn't necessarily recommend to switch it on right now, but I think
> > it could be a good idea in the mid-term. We're also very far behind in
> > terms of warn flags compared to the kernel. Syncing will take some time
> > though. For now I'm looking into enabling -Werror for host tools and
> > this resulted in (so far) 21 patches.
>=20
> I must be misunderstanding what you are referring to here. I don't see
> any warnings when building tools-only - certainly I would not put up
> with that. Do you mean that you are enabling additional warnings?
>=20
> We already have CI checking (which fails on the first warning) and we
> already show the warnings for normal builds. Importantly, without
> -Werror, we show *all* the warnings rather than just stopping at the
> first one depending on -j, etc.
>=20
> So forcing this option seems to be a tax on people who fix warnings,
> imposed by those who don't. It really should be the other way around
> :-)
>=20
> BTW we do have KCFLAGS which can be used to set Werror (and also
> perhaps other things).

I'll note that I just had to request changes on another patch because
they didn't realize warnings had to be fixed. It's quite likely that
making CONFIG_WERROR=3Dy will save more people more time (maybe document
make -k? I don't know what people don't know about these days, but I do
"make -kj" a lot when doing the randconfig stuff for example) than what
we do today.

--=20
Tom

--hyjXSlWeAlqtZ7AW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafjY7AAKCRAr4qD1Cr/k
CuC5AQDdMwKkRzwXTjX10XqdARId2IgGbbRcTRmYEEft5619PQD/fJXKOxy1GuwH
UybDwyRZMZ7caF1LzHM935qMH15jXwE=
=b6M2
-----END PGP SIGNATURE-----

--hyjXSlWeAlqtZ7AW--
