Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08F5FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64179848AA;
	Wed, 29 Apr 2026 16:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kyXDtug8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C9EB848AA; Wed, 29 Apr 2026 16:25:54 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29541848A0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7de4e6c5a30so4866276a34.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777472751; x=1778077551; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QRF2WWzCoVODPZLfnTpyCFyx+tAwSbsNdvSluyYyuak=;
 b=kyXDtug8pximWOdYQgw6/SUB3OtFs+q+Kf/V7uO3W0dhZSdp63TF6Qt+vZgbxE+e2X
 wGb4UF/Mo8al+IezxM4haJuu+yLZqexb4yK42Y1ToE4ye+wcja4tqX2+QA5+zQ9ucvQT
 AV9KojHW5GuyS559xKLcTSP7Hb+BrztFnMm7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472751; x=1778077551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QRF2WWzCoVODPZLfnTpyCFyx+tAwSbsNdvSluyYyuak=;
 b=nH0GD+/CBqr39cRGFCykHPBUuujGj2PD9vY81J8SzrzKf28CqY8QH1DJ+5+jp1FbE7
 E/HQYbSA+r4GjNbOdICDzJ6YqdHMCzB7d9y392PsgfjRMi7euG7Wz1v9TYp/60anhnxv
 zXphCDz3LmtwT0gJmCKxS5KtCx/pQUWng4u2s2uXlEORHUOqX5UtjleNbwauk5xcprZa
 IOH3C1tumEZZOYuRB8FRM0jM9z+p/Thh7aDpaiVro7YsMN/y44OVcQecvSkdS8R55xDW
 2pxQimuMDctXFUgoAJiD8CRrHIos4rJFQQZ6uFdYjKyy3ghm4+XEFUnnmJfwAIi4Wx0t
 M9+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wyUhzNKs0mitcP5Av4lHiR56wrTKRE4/qNKLaQytcyMZM9pK2KNC/J8BIFxTp1roAjuv7p3g=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3SNXNsIvqLXwH+3xwPXGugfHut+zipHmDkpIDavN8JtKcIe3M
 jCKRKE2blZKJmT42hZVMKlJ5vZ+2uGjQLSe0NKnWUVjPXsZiU0l3fwcsura84OSQUgY=
X-Gm-Gg: AeBDievNSHmmYw+5ib6M497J3LUmKUTZqhnHumG/q2HE56qwN4/pefuH8QdoGCSs8bA
 a8EngaRl7XiCFNphQ1XKxC+/kVjCQOEhI68PZAxW2/fnS06FlMLOIVAY5flCVYaU445RY1SEOEe
 /QMBEAl/wNrz3bx/qgk63L4wpB3SzqDCxP2acP41+wZ5mWvpjcAuUdkTBpx5N6S+uj2/X/5bCNo
 wtUgkIb8qGzl66BI34PDyU7uIARz6inrpk++fHPTOeiVF1DJld6J7ltVRwFYcA6JBrlEFMRl/AD
 P5cUjZwuV+Fu60MYATeObZ7EIhZQ1IEqvLYY24hGd6iC/VnNRsNOPyY7y6SqMzrWw9d/1Gn0Fss
 jLSik4NBFpKgP2eD6rC0p3BoUSflt30a/04fN0c3hvZG///JXzIwUzM2dVnFE8u5n7eYpL2KRo8
 ymdZFLULuxRg8CVAtbMFCHqq5Ced/hBl7OYXrQ0xSnNzg/Ecu5g5K7R2TtezUA9YbWhchqKJg7u
 F2nBrx2OTYH9SAal/RSL3wUqeS7BMOtJiuIc53w6ZenZFO8wOLtr/92fFk8TQ==
X-Received: by 2002:a05:6820:160c:b0:694:9fa0:aa4a with SMTP id
 006d021491bc7-696684da3b9mr1869460eaf.44.1777472750771; 
 Wed, 29 Apr 2026 07:25:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966be5fa1fsm1249313eaf.12.2026.04.29.07.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:25:49 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:25:47 -0600
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
Message-ID: <20260429142547.GT41863@bill-the-cat>
References: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
 <CAFLszTjWZ9DBKVui_2EE-nSg8K+5eC9V8jvwp638dLeyp_p6vw@mail.gmail.com>
 <175e1198-2ac4-48de-b68a-c29f786832cc@cherry.de>
 <CAFLszThQ+kyCkojFm2=VNtLTtLDYT4iVmpqnto8awiMVqsct0Q@mail.gmail.com>
 <20260427144630.GG41863@bill-the-cat>
 <CAFLszTgga6eFp2aPF-MzJEqeqcEV-bMJhb4_ph_bE-1Dv4e_Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VQnliRVCy5ueKvE/"
Content-Disposition: inline
In-Reply-To: <CAFLszTgga6eFp2aPF-MzJEqeqcEV-bMJhb4_ph_bE-1Dv4e_Cg@mail.gmail.com>
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


--VQnliRVCy5ueKvE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 08:18:14AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 27 Apr 2026 at 08:46, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Apr 27, 2026 at 11:54:09PM +1200, Simon Glass wrote:
> > > Hi Quentin,
> > >
> > > On Thu, 23 Apr 2026 at 22:24, Quentin Schulz <quentin.schulz@cherry.d=
e> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On 4/22/26 11:57 PM, Simon Glass wrote:
> > > > > Hi Quentin,
> > > > >
> > > > > On Thu, 23 Apr 2026 at 01:26, Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
> > > > >>
> > > > >> Hi all,
> > > > >>
> > > > >> I'm looking into force-enabling CONFIG_WERROR for all Rockchip S=
oCs.
> > > > >> First, let me know if this is a bad idea :)
> > > > >
> > > > > I don't like it, as it makes development slower. I like to see al=
l the
> > > > > warnings created by a change and tend to fix them iteratively. We
> > > > > already have a warning check in CI. A better approach is to
> > > > >
> > > > > Can you use: KCFLAGS=3D-Werror
> > > > >
> > > > > either in your environment or on the 'make' cmdline?
> > > > >
> > > >
> > > > Well, if it's during development, you can always disable WERROR? The
> > > > fact that I've never actually enabled -Werror locally in about a de=
cade
> > > > in U-Boot probably isn't a good sign. One of the things that make me
> > > > wary though is compiler updates with new warnings. I've tested with
> > > > clang 22, don't know when clang 23 is planned to be released. GCC 1=
6 is
> > > > about to be released as well.
> > > >
> > > > By having the check in CI, we have a longer-than-necessary feedback=
 loop
> > > > for contributors. Has this been an issue in the past? /me shrugs
> > >
> > > This is strange though, because people should see the warnings during
> > > development. I wonder if it is scrolling off the screen.
> > >
> > > One my bugbears is non-actionable output. When the build succeeds
> > > (with no warnings) I see no output, using 'buildman -I --board xxx -w
> > > -o /tmp/b/xxx' or in fact these days 'um build xxx'. This uses 'make
> > > -s' under the hood, so that it doesn't print a huge list of filenames,
> > > etc. I also sometimes do a 'fresh' build with 'um build -F xxx' to
> > > check everything is clean ('buildman -m' does something similar).
> > >
> > > Note that buildman returns exit code 101 if there are any warnings, so
> > > the build basically fails.
> > >
> > > >
> > > > No defconfig seems to be setting this option, not sure exactly why =
that is.
> > >
> > > To me this is a difference between 'functionality' options and
> > > development options. Putting development options in Kconfig makes it
> > > harder to turn them on and off, since you must either edit the
> > > defconfig or edit the .config file. It is easier to just pass an
> > > environment variable.
> >
> > The point of a configuration is that it configures the build. Stuff in
> > environment (directly or make FOO=3Dbar) is a workaround and anti-patte=
rn.
> > Having to run one of the config front-end to change the config is a
> > feature, and good thing.
>=20
> To give an example, we have boards which enable LTO, but it is
> sometimes useful to disable it during development - it used to be a
> huge time sync but something seems to have changed recently, as I
> don't see much of a performance gap now. We don't want people
> disabling LTO in the defconfig, though. The same applies for things
> like V=3D1
>=20
> So I think there are build features which are of no use to end-users,
> but are helpful for development. That is the distinction we have had
> for a while and it would be a shame to lose it.

Yes, the LTO thing is a good example of something we shouldn't have done
really. Outside of sandbox you cannot just disable it.

--=20
Tom

--VQnliRVCy5ueKvE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafIU5wAKCRAr4qD1Cr/k
ClzRAP9ezjtknLNjFpWXxS+jFCSlDdBP5uRxpzTZWvwv5QaW7wEAiXOY+4oFdKfg
3mU37FbckHMjSSMuGY28/qcc0IpEHgU=
=Ztui
-----END PGP SIGNATURE-----

--VQnliRVCy5ueKvE/--
