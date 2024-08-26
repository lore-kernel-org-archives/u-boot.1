Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2E0C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 16:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88378888B4;
	Mon, 26 Aug 2024 18:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z82UWLza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B059A888B4; Mon, 26 Aug 2024 18:17:38 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BB0988009
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 18:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6bf6ea1d34aso24419466d6.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 09:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724689055; x=1725293855; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GbE1hGbUOU0Ap2gzWfPc2z1c6kbuyl70/YZgFQUDWm4=;
 b=Z82UWLzayyT2GsVjT84XCt2pgDMSruwJyKHVXW1mq9R2hCJM7nHuXALnZ9orideE5k
 DXJX/aL6ghdSWiQ/Ie0Yl+HrnE+R2e9/7nJFdgbdVe8WbdO4d4Os6suvnOtGn95ut/wp
 UPRb4tJHthTEbIyNSAE9d/QBTSD9pomEVsHts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724689055; x=1725293855;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GbE1hGbUOU0Ap2gzWfPc2z1c6kbuyl70/YZgFQUDWm4=;
 b=gPYkWu2b2649sxmsVADF/ZTAYktEgkPOw/Fo9CCIRH2+C3p/Z2MYfENFOE2b2gLykl
 rpB16k3drvYLbTtXIr9DZW+wnneQREPZuU+Jkn8pJ3EPSv8sxWgPBQ8vgPCyKOk+EmQl
 s2K0svYfztdgNZ83NbU/cIr8W3vZUrvjbEMIDYoPCN5zN7qHgEpB/mJqVuM9MYX6CUCF
 UL6QpS/v+1Cdkgacu0tAAo7jRf1uqdKRx1vZIVIUvoCU1hwM7AhcoRzbWfiwCSPActcW
 ML12EGyxZkkYJ614FvB0Ih7tZ7H+MJOQh0F5/4rzXhQeKIpzHQl7aiVmx/fr78o3rIzs
 EYmA==
X-Gm-Message-State: AOJu0YyskJM+3wS267g91w8BqMeDwCl1vUFmGZgyy+Lv56uqgm+JhYCW
 zOA5iQ9iQq3t9uKh9OTGJgchSwEgqobIZuKwfUDjJHKgsC0rE/v1KoTFjZ/Xur4=
X-Google-Smtp-Source: AGHT+IGp5Je21ev3ywtXSlUGy0xHdYptYyaVnQh6qo5DK9DefijoLi2db9Ih6UDbnNdHNZX2ur3Ogg==
X-Received: by 2002:a05:6214:4485:b0:6bf:9d70:a145 with SMTP id
 6a1803df08f44-6c16dcc90fcmr140946296d6.50.1724689054736; 
 Mon, 26 Aug 2024 09:17:34 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d2120bsm47628806d6.20.2024.08.26.09.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 09:17:34 -0700 (PDT)
Date: Mon, 26 Aug 2024 10:17:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
Subject: Re: [PATCH v9 00/23] Introduce the lwIP network stack
Message-ID: <20240826161731.GH2479150@bill-the-cat>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <20240823211825.GZ1626301@bill-the-cat>
 <12d558ef-6c76-4ae5-9aa3-7e34eb5e2a60@linaro.org>
 <20240826144714.GF2479150@bill-the-cat>
 <9e04c58d-1d34-4073-a4e4-db22311bfd44@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y6xlOAZ2soPNg+92"
Content-Disposition: inline
In-Reply-To: <9e04c58d-1d34-4073-a4e4-db22311bfd44@linaro.org>
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


--y6xlOAZ2soPNg+92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 05:08:10PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 8/26/24 16:47, Tom Rini wrote:
> > On Mon, Aug 26, 2024 at 01:45:10PM +0200, Jerome Forissier wrote:
> >>
> >>
> >> On 8/23/24 23:18, Tom Rini wrote:
> >>> On Fri, Aug 23, 2024 at 03:48:04PM +0200, Jerome Forissier wrote:
> >>>
> >>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add l=
wip
> >>>> library for the network stack" [1]. The goal is to introduce the lwI=
P TCP/IP
> >>>> stack [2] [3] as an alternative to the current implementation in net=
/,
> >>>> selectable with Kconfig, and ultimately keep only lwIP if possible. =
Some
> >>>> reasons for doing so are:
> >>>> - Make the support of HTTPS in the wget command easier. Javier T. and
> >>>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to =
do
> >>>> so. With that it becomes possible to fetch and launch a distro insta=
ller
> >>>> such as Debian etc. using a secure, authenticated connection directly
> >>>> from the U-Boot shell. Several use cases:
> >>>>   * Authentication: prevent MITM attack (third party replacing the
> >>>> binary with a different one)
> >>>>   * Confidentiality: prevent third parties from grabbing a copy of t=
he
> >>>> image as it is being downloaded
> >>>>   * Allow connection to servers that do not support plain HTTP anymo=
re
> >>>> (this is becoming more and more common on the Internet these days)
> >>>> - Possibly benefit from additional features implemented in lwIP
> >>>> - Less code to maintain in U-Boot
> >>>
> >>> As an odd thing, the series leads to ethernut5 failing to build,
> >>> strangely over the RTC driver it uses, for me.
> >>
> >> Weird.
> >>
> >>> I did have to manually
> >>> merge the CMD_WGET related patch,=20
> >>
> >> Weird.
> >>
> >>> but I don't think that was what went
> >>> wrong here.
> >>
> >> Could you try to build from GitHub perhaps?
> >> Branch https://github.com/jforissier/u-boot/tree/to-upstream/v9 builds
> >> fine here:
> >>
> >> $ ./tools/buildman/buildman ethernut5
> >> Building current source for 1 boards (1 thread, 24 jobs per thread)
> >>        arm:  w+   ethernut5
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D WARNI=
NG =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +This board does not use CONFIG_DM_I2C (Driver Model
> >> +for I2C drivers). Please update the board to use
> >> +CONFIG_DM_I2C before the v2022.04 release. Failure to
> >> +update by the deadline may result in board removal.
> >> +See doc/develop/driver-model/migration.rst for more info.
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >>     0    1    0 /1              ethernut5
> >=20
> > I think you weren't on latest next branch when you posted v9, and that's
> > at least the merge conflict. I see the platform builds on your branch as
> > well, but fails still, on mine.
>=20
> I was on latest master as recommended by the documentation [1] but perhaps
> I missed an announcement that next should be used instead?
> Anyway I'm looking into the issues now. Thanks!
>=20
> [1] https://docs.u-boot.org/en/latest/develop/sending_patches.html

Ah, OK. Yeah, so
https://docs.u-boot.org/en/latest/develop/release_cycle.html was updated
to reflect when next opens, but sending_patches needs to be clarified.
I'll go look at that now. When the next branch is open, new work should
be based on that.

--=20
Tom

--y6xlOAZ2soPNg+92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbMqpcACgkQFHw5/5Y0
tyyleAv+KUdwAH8AeR+g0F74ovS0hQgb25YrlpzhboCOrejz001b/COrynxEr2gP
edF3emJfs/BkSBqGpcPCdwilSHVJDdtUYTX7qGcd1K5lb4CeEMLjNp23cgjzil3X
Ps1wVAXnWBGbKCBZJfcj9SyKWqmGXmS5eSMaPcYrxuKecYjTsEG6GpB6aBR3UduT
aL/RKVmOnWorCjgsyPmZPo2mSC4r7ZvkjiORRkpRgZvQLG2mTKqA4QnrKDLGwa+4
GbBzwtw1Iq5YgyQje6V5Gy/nBCreJpFAq/+gug68QLkdUMIAuAV8DhJ2qLPPL6iX
9tR9dhrOzwEe2sDUCa3lqNGD3QlztPDPqe9eN26BpkAYLWQa73AVGjyRaiWb3DaI
t+E9a68xS16/qBAQKuTl2ptOrEW5jVM3Y90hLvKVIQdKJ6JvObu70i0Gy2Gb6LDK
tAESVPIbOArj90P0Xpjwt+MePG59lITSuQSmFBVzqyjFb0p1dvKc5aiiuVRnNhUr
DX76rjIZ
=5Zlh
-----END PGP SIGNATURE-----

--y6xlOAZ2soPNg+92--
