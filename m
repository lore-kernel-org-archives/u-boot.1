Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75803FF8869
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 14:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D391883AA9;
	Mon, 27 Apr 2026 16:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uGGBORN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7DE783C14; Mon, 27 Apr 2026 16:44:12 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68E8F83BC4
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 16:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4779b2497b4so5920544b6e.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777301049; x=1777905849; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5p7Q1zdkFjUylQ6zSSCmO0cbBzicHdag3FByVgq65yA=;
 b=uGGBORN1wGxIiDPx5YYlAqYDzah9fDofK93oTTWhOFWeNiZRfCMU0OgK7KBCPDABj+
 y75tmbOAFGwsfoPliUyZn8Vzy+Fb1LK5/07GpZR9ecTh5lc069OapUHoFnajewUc8bph
 jvdsDL4OLHmQOLilNWN/S/IS5yjbJowyr4R9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777301049; x=1777905849;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5p7Q1zdkFjUylQ6zSSCmO0cbBzicHdag3FByVgq65yA=;
 b=NsLc7TP9LLamuqu2G89nGUx0rQoUxB8s8ye1gYXLBCVMiIQg9LNinlpf3faNbN7MB4
 ftPk9oqMjrzjz7MTkSGqdCWB4ytAsnFibh7zYRlvQpVhFHIlEjNUKEc9mcrwdOT8gnYj
 aD+tK8MzCe9/7bB0GYB4/KdfvEjJB+K9XDBoOJuhN2X1iVm7khEq9MqN+bjb2xaai1l7
 NQTe/LWmB4uOIi6Z7Bp112Y21gSPOeQOGGU9s776pRXnWBR+BVnVwsp6pZ32ZqnGOXS4
 KFPY5RTyxzZvmID2Zh9wYugntD3n4j5efat+po7eBp5i60M7w28jnoEDvDugPjfuJcqP
 jTuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gFbPwsCC3EOIU2JXu57BBHaFY14C7yaorJH5kH5o8E0Ugkloi+r3w1JqDvK4n5szxtY47nrU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6j0Nq2cK+6xCKNyVVf0AFCjEz0M3ebs477faZ2rQf8jHPV3xO
 8NlNUx+/l46QfTX/C99NQ/n70iGHnWVoAjjY7HZ2d3rfiapbjrl8PJDwgRy45Zm1QIA=
X-Gm-Gg: AeBDieu2lvH5qDeHYE4PMLHLGpzDwdVqssinxscQP6N0z5qLZwhTuvTTVDzXHFhHAbh
 oX52dPdcQ+xL/PQO8XocPF5gM3F11blMn8heIwXIw1F+PHEgvQCOij4e93uAqj8Rt1lNbIG2Qp/
 3eya4cqU/P66/5/wNf+/R7f05YDVYX+TVrLx5q7bwqaQH6VJfruGKPRxJTBhf4fu5+W6Tw35+Ig
 iwz2HvJNIxoctxe/MpB3uZCJlYQkRsLOkpcOYIoWE/t0VgGKJoNF8hefBD+hB8tdVvEB7rFZRzH
 qKKg4YmQeWQvK8CUE35/nziHc2quW7LyPZ/DJOw4uD2eB1JgXGYd3U7JA7tdANYR6DvhACwZDDZ
 +AjAySOw8ykH2Gk0rDrfZd0e1eR4g/dBl10wTfgmocC0esqwPANuzTN1mHzRS1poc+A06zfIXL1
 eiwEtIIG62TetOh0beuNtWLmEEL24V++8P7fx0jjBA9fCgj54lOmzGelKXbrEgAYeuwirHcQhT3
 NMj/qELyjDTnTCQ9xyOs37HtUoO+tYj8o5PmG7aHzb+8S5FNH99u08r5WXgpw==
X-Received: by 2002:a05:6808:f06:b0:467:1462:a9a0 with SMTP id
 5614622812f47-4799c8f26e1mr27948157b6e.15.1777301049032; 
 Mon, 27 Apr 2026 07:44:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47bfe593d22sm3202365b6e.11.2026.04.27.07.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 07:44:08 -0700 (PDT)
Date: Mon, 27 Apr 2026 08:44:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: Couple of clang warnings for Rockchip boards
Message-ID: <20260427144406.GF41863@bill-the-cat>
References: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
 <CAFLszTjWZ9DBKVui_2EE-nSg8K+5eC9V8jvwp638dLeyp_p6vw@mail.gmail.com>
 <175e1198-2ac4-48de-b68a-c29f786832cc@cherry.de>
 <20260423192013.GH41863@bill-the-cat>
 <46bdc381-d2b5-4fef-8b2e-50f0fa1cfb05@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MvEFESrUvbuFC7Jy"
Content-Disposition: inline
In-Reply-To: <46bdc381-d2b5-4fef-8b2e-50f0fa1cfb05@cherry.de>
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


--MvEFESrUvbuFC7Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 01:51:10PM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 4/23/26 9:20 PM, Tom Rini wrote:
> > On Thu, Apr 23, 2026 at 12:24:13PM +0200, Quentin Schulz wrote:
> > > Hi Simon,
> > >=20
> > > On 4/22/26 11:57 PM, Simon Glass wrote:
> > > > Hi Quentin,
> > > >=20
> > > > On Thu, 23 Apr 2026 at 01:26, Quentin Schulz <quentin.schulz@cherry=
=2Ede> wrote:
> [...]
> > > Also, FYI, enabling CONFIG_WERROR doesn't apply the -Werror flag to t=
he host
> > > tools, which I believe is an oversight. I see buildman sets
> > > HOSTCFLAGS=3D-Werror, maybe we should do that in the appropriate plac=
e based
> > > on CONFIG_WERROR as well?
> >=20
> > What does the linux kernel do here? We're just borrowing logic again.
> >=20
>=20
> 27758d8c2583 ("kbuild: enable -Werror for hostprogs") and 7ded7d37e5f5
> ("scripts/Makefile.extrawarn: Respect CONFIG_WERROR / W=3De for hostprogs=
")
> (available in v6.18), set
>=20
> ifneq ($(findstring e, $(KBUILD_EXTRA_WARN))$(CONFIG_WERROR),)
> [...]
> # While hostprog flags are used during build bootstrapping (thus should n=
ot
> # depend on CONFIG_ symbols), -Werror is disruptive and should be opted
> into.
> # Only apply -Werror to hostprogs built after the initial Kconfig stage.
> KBUILD_HOSTCFLAGS       +=3D -Werror
> KBUILD_HOSTLDFLAGS      +=3D -Wl,--fatal-warnings
> KBUILD_HOSTRUSTFLAGS    +=3D -Dwarnings
> endif
>=20
> so they do it.

OK, so it's just part of being so behind. I'd be fine with
cherry-picking that logic now, if it's easy.

--=20
Tom

--MvEFESrUvbuFC7Jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCae92MgAKCRAr4qD1Cr/k
CtLJAQDWtW2NB+NOwnYAnoMwxkZqDV/1ySrlhD4zmkP2j1qQMwD9GaxD4H9afy3i
kOTDODm6+OzlkOLShB6P2r3aT6+iIgM=
=0C5R
-----END PGP SIGNATURE-----

--MvEFESrUvbuFC7Jy--
