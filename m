Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DDFC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 14:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A01788A13;
	Mon, 26 Aug 2024 16:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Teop85sf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669CC88A35; Mon, 26 Aug 2024 16:47:22 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA581889CA
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 16:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-44fe11dedb3so24468611cf.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724683639; x=1725288439; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P1KxKfCWL5IzU5OWQvscD3i9219GoPkjHkZbYW4Hp/g=;
 b=Teop85sf7mnZ44RN03uiw//39hb09sSitZ7MkqQdz37Y3IXy/jrBMBFzNUSLHp2A5m
 bfENSQJU8Khel6mYgrKuvDKUhpZHrNVakVBoUtyEd9NtgJyu66fo9CanvpqwC2y901Wq
 hV621SpvswkNohTnOvRixnaVE175BtBwO77ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724683639; x=1725288439;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1KxKfCWL5IzU5OWQvscD3i9219GoPkjHkZbYW4Hp/g=;
 b=W+8UhwcrtSDgzneYPk5YFgxlGcpqlVLznQxUmWluKqQjUJJVdq17pRSZrjH2CKQyCe
 uzDoSpbZFNGKYdACqgzddQZXzVNYYGAiS6gBV033jRFIrthWYjE/YKpf6oBKhVyPukTD
 3GJ5UqTCiR59J8SDBsjsCwW9IKnIqIrsB2//zyGj5tCseiHbD6HtvXIkezgi8XOsS4d6
 6I0YT7DnpA+p8sCvcbueCS94BcIGcePf4vsKJZHI7IR1yUtDmRds9qoOmJ9PrNSrG2eD
 JAbzy25zeM0nljIcJk053CNdbbQElPge6YXd4CUKjO+2GqDIcM4/nE3JaMa//VqtK+hH
 W+7A==
X-Gm-Message-State: AOJu0Ywg+/rBh/cu3hBTOTZGANcOxUJbRAGL0sqZdm5u4o3u7F7LCJfm
 iyCml3rhfYttQAZklY6vuFadELCSC9PwB9LwYWeKpcgSNP8EcTsEWKstuAuhP2g=
X-Google-Smtp-Source: AGHT+IG4CGln/ol8jccMfPg+P+EXRAuoAcwzBoskLcImGlNjdCTFFSD3QiPOqD0PRsF9pzCz+/GoIQ==
X-Received: by 2002:a05:6214:2d4a:b0:6bf:6934:d0bb with SMTP id
 6a1803df08f44-6c16dc6d6c2mr114915576d6.21.1724683638690; 
 Mon, 26 Aug 2024 07:47:18 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162de645dsm46913066d6.131.2024.08.26.07.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 07:47:18 -0700 (PDT)
Date: Mon, 26 Aug 2024 08:47:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
Subject: Re: [PATCH v9 00/23] Introduce the lwIP network stack
Message-ID: <20240826144714.GF2479150@bill-the-cat>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <20240823211825.GZ1626301@bill-the-cat>
 <12d558ef-6c76-4ae5-9aa3-7e34eb5e2a60@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0BO52E+poEEhO8Kq"
Content-Disposition: inline
In-Reply-To: <12d558ef-6c76-4ae5-9aa3-7e34eb5e2a60@linaro.org>
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


--0BO52E+poEEhO8Kq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 01:45:10PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 8/23/24 23:18, Tom Rini wrote:
> > On Fri, Aug 23, 2024 at 03:48:04PM +0200, Jerome Forissier wrote:
> >=20
> >> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> >> library for the network stack" [1]. The goal is to introduce the lwIP =
TCP/IP
> >> stack [2] [3] as an alternative to the current implementation in net/,
> >> selectable with Kconfig, and ultimately keep only lwIP if possible. So=
me
> >> reasons for doing so are:
> >> - Make the support of HTTPS in the wget command easier. Javier T. and
> >> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> >> so. With that it becomes possible to fetch and launch a distro install=
er
> >> such as Debian etc. using a secure, authenticated connection directly
> >> from the U-Boot shell. Several use cases:
> >>   * Authentication: prevent MITM attack (third party replacing the
> >> binary with a different one)
> >>   * Confidentiality: prevent third parties from grabbing a copy of the
> >> image as it is being downloaded
> >>   * Allow connection to servers that do not support plain HTTP anymore
> >> (this is becoming more and more common on the Internet these days)
> >> - Possibly benefit from additional features implemented in lwIP
> >> - Less code to maintain in U-Boot
> >=20
> > As an odd thing, the series leads to ethernut5 failing to build,
> > strangely over the RTC driver it uses, for me.
>=20
> Weird.
>=20
> > I did have to manually
> > merge the CMD_WGET related patch,=20
>=20
> Weird.
>=20
> > but I don't think that was what went
> > wrong here.
>=20
> Could you try to build from GitHub perhaps?
> Branch https://github.com/jforissier/u-boot/tree/to-upstream/v9 builds
> fine here:
>=20
> $ ./tools/buildman/buildman ethernut5
> Building current source for 1 boards (1 thread, 24 jobs per thread)
>        arm:  w+   ethernut5
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D WARNING =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +This board does not use CONFIG_DM_I2C (Driver Model
> +for I2C drivers). Please update the board to use
> +CONFIG_DM_I2C before the v2022.04 release. Failure to
> +update by the deadline may result in board removal.
> +See doc/develop/driver-model/migration.rst for more info.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>     0    1    0 /1              ethernut5

I think you weren't on latest next branch when you posted v9, and that's
at least the merge conflict. I see the platform builds on your branch as
well, but fails still, on mine.

--=20
Tom

--0BO52E+poEEhO8Kq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbMlWsACgkQFHw5/5Y0
tyyQxgwAqDf+RfMkp2NBtj5H9PVtUHN4v3psr6vw5s7yCy/FISQFdzGJWzBBgdoI
akFnUDO1ypMFofUiJDD9oNbpceo7uK00uS85X6YgPZOCPnLTL3b89O5XgGsf7hdz
p+fK68FOEEYAmSS7wUKVC0txqL64ZQICd5x+V0FWZRk/8/SEJJzz3O9koxQ8NptK
JeUc1ssAhnrQhWJ1DJx38rZ/8byEjph0r1PbbiRcJ7K0t9LGK7KqO550//8zQxRd
2DSmiHVrCrlFmJCi/aJeHfWD4lNNmuc+Z3bLU8IGYprORYDEHbP+VD4jheO9d8rP
UebKU5qOydeNu4Xo7lmRkcKTZ8DjWZnPUOEBFXJNqPW5iGqsCzWcIeBp6WAIi5or
GEVd60b0PRj38a3Uz/9ye/kwO5zy+31vo7cRL1wVSSVdEK7KPO1vbjZq5PS3jNo7
cGTuLdSCVJUWggcLGTotTQYJXzSxO9fedz8sGpSCoI6IsLkj88Eyr5ya3DrUFifj
IVTNMl6J
=8ess
-----END PGP SIGNATURE-----

--0BO52E+poEEhO8Kq--
