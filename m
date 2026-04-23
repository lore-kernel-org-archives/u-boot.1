Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB00FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 19:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2CEE84378;
	Sat, 25 Apr 2026 21:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AfcWrkKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E513184474; Sat, 25 Apr 2026 21:38:43 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A788431E
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-c79467f11abso5993223a12.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 12:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777145918; x=1777750718; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p0nZb5WEhI/WppssbOi2GGAaBPDQE1WnRWJleNgTlTw=;
 b=AfcWrkKUOK/hymqGdW7ic5vHcp396yPEGelxEdf9fWWO7xWdo+67oi38SW3e5tSrIr
 zW5YUIAvySoWnWFXEI/h0ZwuwlAP0HSTtkTPKT2hA5kZjf5VmzEC/RzbQ/M+IYbUha28
 e2XECPIiAveuwphOEUu+aX56O/zGm0V7s9lRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777145918; x=1777750718;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p0nZb5WEhI/WppssbOi2GGAaBPDQE1WnRWJleNgTlTw=;
 b=r1ua1ofVe+Wy5Wu6Y9H6LBUBWQxMOS0qMsgyDBITT/0c7CIq4pRYNyyMWiXsz1RmCj
 on0r+qnJkYQttSZBYhThM7X7WO/8TbNE4lczqUsGCyu8xjy4I/PD1C3j/Qu0LExhCoUK
 8CZcuDwhqhkEYYFsPgEXZvkiqtskIXVb0Zrv5a1ymOVXzvtQuA936gbLUHjcHqVrJluA
 t5RAWC1ue8YfQzH/ofyIMkIZMQJvmbkVDXFMYFlCeGzRVB8igM2nItvGYHWKJKtGUJP5
 xOSPX+iMxSG0KKAmg5BDlI1biTWLWhuj6IWDAzY+EwIfw9pbHVRo1CaaFQPkX4O/GVKN
 NNzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vJjiR3eDuQlNxIPd+pJhXpuiN/YAU62ZOVVyRmqlIKOYZ46JrVzD7B4LKayQm6njgfFAiKkw=@lists.denx.de
X-Gm-Message-State: AOJu0YzkAE5maFb24325mJdLMa5XMgiNSnkhwDf9BcSalSHt++i8XJ2B
 h7iJzp96O6vbhm68aMkUKgQmsVCvQniovwMTM+Nc00The7FGczOhSywSst7ptWOYybWUb5ZYoeY
 w+jLEKip2vjcL
X-Gm-Gg: AeBDiesME0n4P2qVkFUbi8Z7i6Z7OXIFrctOTAugKHzxOQqhEjk7lsA0D9JVjdhEtjR
 7pf2RTjYxh4uinE19Czb6X7nnwU1q3Guto/wQyywbouVU3RclmCf4pkDefEJPKk0/m/Mp9vKiTV
 fE6RgDbxvI7tiTvhEU+ZZu22oWwWhGki3FcxgvWnQWryfiz4mAWtQ1DpujHlms1WyHb6D5Ho12c
 RFs8paEklDx6E3xVk14Q7Enj1S0SBXroI26b+4pCMiS9+VMJeUquGRzyp1oy85moSYXnMBl4ZN7
 miqhqFGPm6vd/f9S16pZc6v5G5HXImydIzB3yIS1P4sl0+ubjDeU5Z6fkYURvtekbaJrViDhia7
 +MJyYHdIkfyQfexwNf6i7LbKiK2MufJUubWFULmK5FUCh+cPSbAlprd39XVeaEPgQpU9MLF7Bo6
 zsPrh75EVacyty62njQiLwtGW815mu+C17O0qaHGV4STiIgfPuedo9eJOmm/jwO8cURPbH4RkS9
 u0K3ehVs+o2y65xIG4U5/4UVe6xkbpBeXV6BBnqS22C/fR3oqZPeJWV/ziBLA==
X-Received: by 2002:a05:6830:81c8:b0:7de:4ebe:e44 with SMTP id
 46e09a7af769-7de4ebe164dmr1851444a34.2.1776972017580; 
 Thu, 23 Apr 2026 12:20:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dcdd3fb6b4sm6827104a34.7.2026.04.23.12.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:20:16 -0700 (PDT)
Date: Thu, 23 Apr 2026 13:20:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: Couple of clang warnings for Rockchip boards
Message-ID: <20260423192013.GH41863@bill-the-cat>
References: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
 <CAFLszTjWZ9DBKVui_2EE-nSg8K+5eC9V8jvwp638dLeyp_p6vw@mail.gmail.com>
 <175e1198-2ac4-48de-b68a-c29f786832cc@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TlOEpmFBALg9eSmj"
Content-Disposition: inline
In-Reply-To: <175e1198-2ac4-48de-b68a-c29f786832cc@cherry.de>
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


--TlOEpmFBALg9eSmj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 12:24:13PM +0200, Quentin Schulz wrote:
> Hi Simon,
>=20
> On 4/22/26 11:57 PM, Simon Glass wrote:
> > Hi Quentin,
> >=20
> > On Thu, 23 Apr 2026 at 01:26, Quentin Schulz <quentin.schulz@cherry.de>=
 wrote:
> > >=20
> > > Hi all,
> > >=20
> > > I'm looking into force-enabling CONFIG_WERROR for all Rockchip SoCs.
> > > First, let me know if this is a bad idea :)
> >=20
> > I don't like it, as it makes development slower. I like to see all the
> > warnings created by a change and tend to fix them iteratively. We
> > already have a warning check in CI. A better approach is to
> >=20
> > Can you use: KCFLAGS=3D-Werror
> >=20
> > either in your environment or on the 'make' cmdline?
> >=20
>=20
> Well, if it's during development, you can always disable WERROR? The fact
> that I've never actually enabled -Werror locally in about a decade in U-B=
oot
> probably isn't a good sign. One of the things that make me wary though is
> compiler updates with new warnings. I've tested with clang 22, don't know
> when clang 23 is planned to be released. GCC 16 is about to be released as
> well.

Personally, I think -Werror being a pro or a con during development is
up to the developer. I'm very much a "turn this on, fail the build when
I transpose arguments, etc" kind of developer.

> By having the check in CI, we have a longer-than-necessary feedback loop =
for
> contributors. Has this been an issue in the past? /me shrugs

Yes, a not uncommon occurrence is patches, or even PRs, having to be
respun because of "variable unused" warnings. Which having typed that is
more likely what bothers Simon's flow.

> No defconfig seems to be setting this option, not sure exactly why that i=
s.
>=20
> Also, FYI, enabling CONFIG_WERROR doesn't apply the -Werror flag to the h=
ost
> tools, which I believe is an oversight. I see buildman sets
> HOSTCFLAGS=3D-Werror, maybe we should do that in the appropriate place ba=
sed
> on CONFIG_WERROR as well?

What does the linux kernel do here? We're just borrowing logic again.

[snip]
> So, looking a bit more into this, the kernel actually silences a bunch of
> warnings when not passing W=3DN to `make`, one of them being unaligned-ac=
cess,
> see https://elixir.bootlin.com/linux/v7.0/source/scripts/Makefile.warn#L1=
55.
> So maybe we need to sync some of those back to U-Boot as well?
>=20
> Our scripts/Makefile.extrawarn is claimed[1] to be loosely based on Linux
> 6.1's, but it is actually quite different. So not sure how much we should=
 be
> backporting and how.
>=20
> [1] bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")

We're likely a combination of mis-synced (assuming it's not inline with
6.1) and a case of needing to expand the new concept of
scripts/Makefile.XXX-u-boot for kbuild stuff to have a
Makefile.warn-u-boot for things we add.

--=20
Tom

--TlOEpmFBALg9eSmj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaepw6gAKCRAr4qD1Cr/k
Cm0FAQDTn7/mRczCCy8b9eH60xdXMZqwoAu0aSKskYRO9Iy1VgD/WNy2F6Rlhyyz
1jl8QvQo0bAXjYjRzRhW5qyEXUGnQws=
=UuQG
-----END PGP SIGNATURE-----

--TlOEpmFBALg9eSmj--
