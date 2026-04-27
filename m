Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873A7FF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 14:46:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09BA183AA9;
	Mon, 27 Apr 2026 16:46:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bh2fGfIA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C524C84106; Mon, 27 Apr 2026 16:46:36 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F6CC83693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 16:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7de431da8fbso4407666a34.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 07:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777301193; x=1777905993; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AuylRELqdAAyfomp+uHk0st22r2WIpqVPWhNmCzbDqg=;
 b=Bh2fGfIA8T9AvuOMTrHEDAIK7tXTtpZRfoEZcIsNkWzT+SF7TbELqM4gTMbPM640GA
 BMJb2o7yR4/FrFpMFpWNNrrn+3fLoh7xLv8tueJ7EAiHawXFuSNeZdGk7Wjtzu2XLgqg
 4KhIPoHrCRDG6rin3oZ41JjH5J+wyYTFqJ9AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777301193; x=1777905993;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AuylRELqdAAyfomp+uHk0st22r2WIpqVPWhNmCzbDqg=;
 b=Ie7SNvAREqu7RXmJBLUrCFGiZAH0Xk2ZVw5tfww5YTAPh2RsJ9OC0KMAxoSOfjn92P
 UmJVueJWEGI8EePdZbhXM+5evLwW9w75hpDqIK9+lOU5lTfHe5L27NPIzy80E4Gl4hw9
 LKG3ii/0cVKbAsDQUs+vFV9kb0iX3wGocqZKe8WWZO/xqjNd9ZvcXXhCDOBkqy4pfU9E
 rwvcutPsywdAS7fNAt7e4+6uYoAv5FL8iX3D8VCzGX1H+PFJcuP7E4jUpSH627arzxLP
 b+ez0PduvkXBX/h2Qp8KwH72JYcUFZL6AhsFPjjyEZLWdxvT2R1fFszr3V9D7h51x3U1
 0zuA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mJcXR0UFAg/KnDKuUkD3zO4xg/VGqBPBWCg+ggdUIEMoUraD/nP/5M+3y+GNHY6cpVFX8KkQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwZTbS65zsqH0qDBEUTH3aQll5roWJlq8gbKcSZ4gJelKx8c3ru
 65oI+Je5e3PJWTJ5EUil4g/tgtH/PByCw5P7ZOQMEaFpsk3CRO57gsb5slWKBxHSDgs=
X-Gm-Gg: AeBDiesrYmP06awEHh/x1NkHHidxFZYUmnbHFB1I3gMdzsZ3pikWmVKDlWJHngwd/PS
 aES56GFosfSOUPBZ6AXUyr00dgy9LU44OHDL+PrXZ52WJK4HXqD7SJIqkOSnYUeYCx3Vrhm4ZZx
 b1Vt1mk0b2HnE55b+XVY3li1KIfl7o2HU6HAqjX4OCjKndpXbw+Dz0+eKu/C0IJkiEp5kvr6wKi
 5iL0GRmtiZtz82nFsDq98zKIjm/8c56hZ0V8n5WRIYlaRsuP8KzwHAq5bDJ8yq6SaOvDKiu+lwn
 scGO/dqWDerzowk3dZEq3RLaFXQ+zgY7kExSwJb3vwUKIDuKweRt2n13U6sYMsi+bDHx8xWy8al
 jL5Eztp4gp54V0PGeKfs4u4UgjRmjgV0jAP5JKTFvbM5Je1et/ie4eV5DqY9XDDYDDDHYxIHijQ
 whyq9lp+BQNMzFltbqV0vvPF7r94orBoEfyMHHxTQvf0ir2gWqtURb7DK2VmgB2+YTzE9w1bV+K
 WZxgpT7q8rpD1VxpxdqwIjJPFB3/sT+gx9yDpLTQczX81GdPFkzVFyVW+E6dw==
X-Received: by 2002:a05:6830:25cc:b0:7dc:e090:68a with SMTP id
 46e09a7af769-7dce0900edfmr16040288a34.0.1777301193330; 
 Mon, 27 Apr 2026 07:46:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dcd56bd0e4sm20734960a34.2.2026.04.27.07.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 07:46:32 -0700 (PDT)
Date: Mon, 27 Apr 2026 08:46:30 -0600
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
Message-ID: <20260427144630.GG41863@bill-the-cat>
References: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
 <CAFLszTjWZ9DBKVui_2EE-nSg8K+5eC9V8jvwp638dLeyp_p6vw@mail.gmail.com>
 <175e1198-2ac4-48de-b68a-c29f786832cc@cherry.de>
 <CAFLszThQ+kyCkojFm2=VNtLTtLDYT4iVmpqnto8awiMVqsct0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L+McFpjxfr50XXSF"
Content-Disposition: inline
In-Reply-To: <CAFLszThQ+kyCkojFm2=VNtLTtLDYT4iVmpqnto8awiMVqsct0Q@mail.gmail.com>
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


--L+McFpjxfr50XXSF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 11:54:09PM +1200, Simon Glass wrote:
> Hi Quentin,
>=20
> On Thu, 23 Apr 2026 at 22:24, Quentin Schulz <quentin.schulz@cherry.de> w=
rote:
> >
> > Hi Simon,
> >
> > On 4/22/26 11:57 PM, Simon Glass wrote:
> > > Hi Quentin,
> > >
> > > On Thu, 23 Apr 2026 at 01:26, Quentin Schulz <quentin.schulz@cherry.d=
e> wrote:
> > >>
> > >> Hi all,
> > >>
> > >> I'm looking into force-enabling CONFIG_WERROR for all Rockchip SoCs.
> > >> First, let me know if this is a bad idea :)
> > >
> > > I don't like it, as it makes development slower. I like to see all the
> > > warnings created by a change and tend to fix them iteratively. We
> > > already have a warning check in CI. A better approach is to
> > >
> > > Can you use: KCFLAGS=3D-Werror
> > >
> > > either in your environment or on the 'make' cmdline?
> > >
> >
> > Well, if it's during development, you can always disable WERROR? The
> > fact that I've never actually enabled -Werror locally in about a decade
> > in U-Boot probably isn't a good sign. One of the things that make me
> > wary though is compiler updates with new warnings. I've tested with
> > clang 22, don't know when clang 23 is planned to be released. GCC 16 is
> > about to be released as well.
> >
> > By having the check in CI, we have a longer-than-necessary feedback loop
> > for contributors. Has this been an issue in the past? /me shrugs
>=20
> This is strange though, because people should see the warnings during
> development. I wonder if it is scrolling off the screen.
>=20
> One my bugbears is non-actionable output. When the build succeeds
> (with no warnings) I see no output, using 'buildman -I --board xxx -w
> -o /tmp/b/xxx' or in fact these days 'um build xxx'. This uses 'make
> -s' under the hood, so that it doesn't print a huge list of filenames,
> etc. I also sometimes do a 'fresh' build with 'um build -F xxx' to
> check everything is clean ('buildman -m' does something similar).
>=20
> Note that buildman returns exit code 101 if there are any warnings, so
> the build basically fails.
>=20
> >
> > No defconfig seems to be setting this option, not sure exactly why that=
 is.
>=20
> To me this is a difference between 'functionality' options and
> development options. Putting development options in Kconfig makes it
> harder to turn them on and off, since you must either edit the
> defconfig or edit the .config file. It is easier to just pass an
> environment variable.

The point of a configuration is that it configures the build. Stuff in
environment (directly or make FOO=3Dbar) is a workaround and anti-pattern.
Having to run one of the config front-end to change the config is a
feature, and good thing.

--=20
Tom

--L+McFpjxfr50XXSF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCae92xgAKCRAr4qD1Cr/k
CvslAP4z5wBdz338c5h3mbfaxxqKWgavYLXx6HsyIqoksRUGqwD+Mjp4+mD6/76f
CzOFfcKC/WNuwFY5IxEekh3TeBnL2wg=
=X5Ad
-----END PGP SIGNATURE-----

--L+McFpjxfr50XXSF--
