Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37277EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 14:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B69258679C;
	Mon, 21 Aug 2023 16:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VTW45Qwv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D01687051; Mon, 21 Aug 2023 16:00:05 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02397807BC
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 16:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2bba6a9b565so52336161fa.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 07:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692626401; x=1693231201;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMaCd92uhFHwh3Zl5BaovKmJEd2JolrEuXaMt/DkfZw=;
 b=VTW45Qwvixqz3kat5H9py59/1l1Q05nKaXa+yKvLC5J7DeAPeBFOhnSuXmrm6N9XRS
 wJWvAQgChhRsG83kjCvHZJfSJs3K+o3jKXPuorerPMjVxdykCLJI0m8aJASqpf2GWI27
 9ysKqNSw5xIzcguXn5rQDr7ZMilC2KrhTUHFWEg8UsCwMooZY60J66rOUNF8k/WXuij1
 HWDSQDbDx3+bz3Ek5UDpzslZr+cKHaRooG+x1dsx9YJrU+DIygof6hmYp/dNtrOXTOde
 gPM0GjhqbE4NIUPzAA0jcxVjLDRDGCfEJL92zqBIcNhb8t0fDIPT234f/30NYpPBEqC2
 1Z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692626401; x=1693231201;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMaCd92uhFHwh3Zl5BaovKmJEd2JolrEuXaMt/DkfZw=;
 b=COKEyOQfe+Sfh/y1PCFf9vjflMdonHo420OCBTN82fIsMxw4NMkU50bpaVcEZ21MnW
 M+qbL9Vb2ryBmwIMEvOxU0PDD6g3Cf3I2rO9oiGNneoVZ0pcs3cGUch1SYGzkYUbZ8cB
 P19t1Rqv+VrtuvPCaVXeK2LWu22fYmwkLY1IkT3GSO/PpZN0vkCwGqlK4RBXKIyvlECE
 SnObcHiVviLBfBlzrRTsGk6Xm18cXKEIPmSAXaWnLxgqFvKHR6L7UKUaUNr1eXIWe+Tq
 Zu3R8jWsV5XQZrlqV86NxX/ThPji2nT9WSDTo4B2XOyv4ilsIYepw1Thv5M+TjAmrCye
 HrBQ==
X-Gm-Message-State: AOJu0Yz9LXBrqQFZtptmPKBqpuvx50j7bOpLVKiA37v5Vg6FPVjjXYQH
 AtGQDTIWxRuTkwr8SfTsjOQ=
X-Google-Smtp-Source: AGHT+IFhXs5M1vgjEfc1f8mczzYukAyh/4UMyw3hsD5hCVVQ6dBUsq/3NPqLJ8R6NOG0Cn0RvrlHfg==
X-Received: by 2002:ac2:5bd0:0:b0:4ff:8cf1:4242 with SMTP id
 u16-20020ac25bd0000000b004ff8cf14242mr3831632lfn.3.1692626400851; 
 Mon, 21 Aug 2023 07:00:00 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 h3-20020aa7c603000000b005256ae8494asm5991866edq.17.2023.08.21.07.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 07:00:00 -0700 (PDT)
Date: Mon, 21 Aug 2023 15:59:58 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [GIT PULL] ARM: tegra: Changes for v2023.10-rc1
Message-ID: <ZONt3v3Hb8foJdup@orome>
References: <20230818133923.286332-1-thierry.reding@gmail.com>
 <20230818164943.GZ1515023@bill-the-cat>
 <0C415156-B22C-4B86-94C6-1D03ED4287ED@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wwlnnbFDYsJpoIhS"
Content-Disposition: inline
In-Reply-To: <0C415156-B22C-4B86-94C6-1D03ED4287ED@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
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


--wwlnnbFDYsJpoIhS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 08:02:30PM +0300, Svyatoslav Ryhel wrote:
>=20
>=20
> 18 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 19:49:43 GMT+03:00, =
Tom Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=
=D0=BB=D0=B0):
> >On Fri, Aug 18, 2023 at 03:39:22PM +0200, Thierry Reding wrote:
> >
> >> From: Thierry Reding <treding@nvidia.com>
> >>=20
> >> Hi Tom,
> >>=20
> >> The following changes since commit 68c07fc5fdf34f0926cf06fc0c4ebd6f2f3=
afe19:
> >>=20
> >>   Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2023-06-2=
1 14:42:50 -0400)
> >>=20
> >> are available in the Git repository at:
> >>=20
> >>   git@source.denx.de:u-boot/custodians/u-boot-tegra.git tags/tegra-for=
-2023.10-rc1
> >
> >FYI, in your .git/config you can do:
> >	url =3D https://source.denx.de/u-boot/custodians/u-boot-tegra.git
> >	pushurl =3D git@source.denx.de:u-boot/custodians/u-boot-tegra.git
> >
> >And this part looks "nicer".  Not a big deal, just an FYI.
> >
> >> for you to fetch changes up to bdf9dead86f06c7d6980c399a4a6339430b531e=
c:
> >>=20
> >>   board: htc: endeavoru: add One X support (2023-06-30 15:20:37 +0200)
> >>=20
> >> This passes CI successfully:
> >>=20
> >>   https://source.denx.de/u-boot/custodians/u-boot-tegra/-/pipelines/17=
411
> >>=20
> >> Thanks,
> >> Thierry
> >>=20
> >> ----------------------------------------------------------------
> >> ARM: tegra: Changes for v2023.10-rc1
> >>=20
> >> This adds support for various new Tegra30 boards (ASUS, LG and HTC) and
> >> has some other minor enhancements, such as enabling the poweroff comma=
nd
> >> on several Tegra210 and Tegra186 boards.
> >>=20
> >> ----------------------------------------------------------------
> >> Jonas Schw=C3=B6bel (1):
> >>       configs: tegra-common-post: make PXE and DHCP boot targets optio=
nal
> >>=20
> >> Svyatoslav Ryhel (6):
> >>       configs: tegra-common-post: add GPIO keyboard as STDIN device
> >>       ARM: tegra: add SoC UID calculation function
> >>       board: asus: transformer: add ASUS Transformer T30 family support
> >>       board: asus: grouper: add Google Nexus 7 (2012) support
> >>       board: lg: x3: add Optimus 4X HD and Optimus Vu support
> >>       board: htc: endeavoru: add One X support
> >>=20
> >> Thierry Reding (2):
> >>       ARM: tegra: Enable poweroff command on Jetson TX1 and Jetson Nano
> >>       ARM: tegra: Enable poweroff command on Jetson TX2
> >>=20
> >> Tomasz Maciej Nowak (1):
> >>       ARM: dts: trimslice: sync SPI node with Linux dts
> >
> >Since I'm not sure if this is v8 or v9, given when v9 was posted, I've
> >applied this PR now, as I had said I wanted this in.  I do have two
> >requests for you Svyatoslav, however.  First, if there's changes that
> >are missing in master, please post those ASAP and we'll get them in, for
> >v2023.10.=20
>=20
> Patches Thierry applied are v8, while v9 has significant improvements.

I'm a little surprised by how this series developed. You've been urging
me since v6 to apply this, so I assumed this was mostly done. Having
another 3 versions with significant improvements come in after that
point indicates the opposite was true.

Thierry

--wwlnnbFDYsJpoIhS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTjbd4ACgkQ3SOs138+
s6E/aQ/+PQl1oFiwF3JckIosQO2Jz0rkcrN/KBIYj5Mn/wdhkOxeXPuWSvZQ4Rfz
DTsIYk3CUe0YS3zvW9QJJ1bp1GfhRPii1ktufhPFDi/Z+SnsTPNiH+zD1jaaNIkA
h//1yyf6MEorDHFi0/eBr/6AKgj3/BFYbKEeZko/7egO8qpGKnJWIOmzhtknVSzF
qdSP4RNtayzmqt0OUJkPVDtH6vYM3nQXOKNCO9fMzYr/BHHXy3GXJ8FhaFuktkAv
AJjjoI/tOmwu5npdKSBFRVhVhYCV+UW8XrRw+gR70fXY+7UVCQWc02aL3tXcoMXt
14zp+Foj4dmHRjjX9YA+6VJ0NxKS3kyYxsd6OyfJXQ9zPh8J5gHx61W2l3k+PtYu
hUwl7kUlC9i7Za4EvgvLZub6nwUQ51E9LJrId3wKszOY60NitbJBHiGm2tIN5kAE
uv/3nW0BY1VWQh1NoKj5e3jQ2rfD7SPXZZGlpD1U7Yj+3LUpyUpjTBDJiFFsLnL5
9mzlR1qNuzio6SgnO+M2LTE+jzMhczJv5qRKQQW7ZF74wXpYk1I4Oqz0SG1c9ZZ6
wITTbnxTAJ1X7gOjFyzHHXqAfTO5/mP1D3/4zb5WVvpTwgItf9dk9j7yPoMApXJ1
61ugB7pDJSIhZOEopbzwor0ihQDKPJz82kJBww2GkjITRH4QoJc=
=Rqml
-----END PGP SIGNATURE-----

--wwlnnbFDYsJpoIhS--
