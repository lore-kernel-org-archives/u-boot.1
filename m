Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF54CCD192
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 09:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51C8F88EEC;
	Wed, 18 Sep 2024 11:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="WcYp31mf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1451888EE4; Wed, 18 Sep 2024 11:41:39 +0200 (CEST)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F3DC88D75
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 11:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726652493; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MXnSXXoP1mY5ghE5WOKsclJihemPgUgSbukWhBOTNRwo/b2HyjAICu1FLc7wMD9mae375yUOqYzN0rVQy26fFOOqfZ7effU5z4IPXFjmSaT1hfwDaynzew94zlFr0d1cQ2wCFD8YC6Bm2ZsHgy2S5z6gVAjj5hoMV1Zo90ntWlc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1726652493;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=NU5yJj1yfAPJkWlPvHFZwuA0wfW5FXAaBGdGQveF6P0=; 
 b=jHAViGOP+l+ujllwbrZ2sQlXzMCVV5Ele/pUiMwJnoCYmz1PRgBCUkP/zmDyHiuVGbZvPN/YUFH1Fk5LZNbh5uKGbXY8FVqM2bSsMjxmyaXqFo7mJY1NtWqr3XP6D5BgY6Q3w7jwrXYvf0UHdmesjTmXJMaVOskXa/0H0BaZBKM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726652493; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=NU5yJj1yfAPJkWlPvHFZwuA0wfW5FXAaBGdGQveF6P0=;
 b=WcYp31mfGHSc8f/9g4tMpHJzEF5kDxEem1QPI6LIvS2QAcgRX3M/GuBzskfMzdRv
 wNC09XYTZkDIZYX/IaJl/lkT6mWuUFOz9SASZLNxsDbcWycIfpkfbNVLLgDJ/jLE8/T
 T8n5FLgLNCtr6Uz4+tAGSR+vmyyAF1DGbgWhegbM=
Received: by mx.zohomail.com with SMTPS id 172665249261088.01393887883103;
 Wed, 18 Sep 2024 02:41:32 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
 id 0DAFA1060335; Wed, 18 Sep 2024 11:41:28 +0200 (CEST)
Date: Wed, 18 Sep 2024 11:41:28 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Soeren Moch <smoch@web.de>, Eugen Hristev <eugen.hristev@collabora.com>, 
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v6 0/6] FUSB302 USB-C controller support
Message-ID: <3kyh6fd4edev55q3e63ixaa4f6vgf4moqfxqdpvyrxt26x6xvy@yvk4boehfing>
References: <20240905151707.59101-1-sebastian.reichel@collabora.com>
 <c208f28d-86e0-41b2-9d37-45de423e30b3@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yifwsz4amhmfrmbj"
Content-Disposition: inline
In-Reply-To: <c208f28d-86e0-41b2-9d37-45de423e30b3@kwiboo.se>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External
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


--yifwsz4amhmfrmbj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Wed, Sep 18, 2024 at 09:56:35AM GMT, Jonas Karlman wrote:
> On 2024-09-05 17:08, Sebastian Reichel wrote:
> > On ROCK 5B power is usually supplied via it's USB-C port. This port has=
 the
> > data lines connected to RK3588, VBUS connected to the input regulator a=
nd
> > CC pins connected to FUSB302. FUSB302 is a USB-C controller, which can =
be
> > accessed via I2C from RK3588. The USB-C controller is needed to figure =
out
> > the USB-C cable orientation, but also to do USB PD communication. Thus =
it
> > would be great to enable support for it in the operating system.
> >=20
> > But the USB-PD specification requires, that a device reacts to USB-PD m=
essages
> > send by the power-supply within around 5 seconds. If that does not happ=
en the
> > power-supply assumes, that the device does not support USB-PD. If a dev=
ice
> > later starts sending USB-PD messages it is considered an error, which i=
s solved
> > by doing a hard reset. A USB-PD hard reset means, that all supply volta=
ges are
> > removed for a short period of time. For boards, which are solely powered
> > through their USB-C port, like the Radxa Rock 5B, this results in an ma=
chine
> > reset. This is currently worked around by not describing the FUSB302 in=
 the
> > kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This means
> >=20
> > 1. the USB-C port cannot be used at all
> > 2. the board will be running via fallback supply, which provides limited
> >    power capabilities
> >=20
> > In order to avoid the hard reset, this adds FUSB302 support to U-Boot, =
so
> > that we react to the power-supply's queries in time. The code, which is
> > originally from the Linux kernel, consists of two parts:
> >=20
> > 1. the tcpm state machine, which implements the Type C port manager sta=
te
> >    machine as described in the USB PD specification
> > 2. the fusb302 driver, which knows about specific registers
> >=20
> > Especially the first part has been heavily modified compared to the
> > kernel, which makes use of multiple delayed works and threads. For this
> > I used a priorly ported version from Rockchip, removed their hacks and
> > any states not necessary in U-Boot (e.g. audio accessory support).
> >=20
> > This version has been tested on Radxa Rock 5B using the open source TF-A
> > (patches recently got merged into master branch) using the following po=
wer
> > supplies:
> >=20
> >  * non PD capable (reports 5V 0A)
> >  * RavPower 90W
> >  * UGREEN 100W
> >  * Anker 45W
> >  * RavPower PB
> >=20
>=20
> [snip]
>=20
> This series look good and works great on my ROCK 5B, tested using two
> different PD capable power supplies, so this entire series is:
>=20
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Thanks.

> I did notice that trying to hook up the ROCK 5B from my computer to use
> UMS in U-Boot there is a slight delay at boot and following is shown:
>=20
>   fusb302 usb-typec@22: TCPM: PD transmit data failed: -110
>=20
> I suspect this work as intended, so nothing blocking.

Yes. These potential delays are the reason why I only wanted to
enable this for affected boards.

I suppose we can try to get rid of the error message for the case
of not having PD at all. Note, that a standard compliant USB port
(limited to 500mA [USB2] or 900mA [USB3]) is not good enough to
power the Rock 5B since cpufreq got enabled. the Rock 5Bs in
Collabora's KernelCI farm were originally powered through a USB
hub and the hub powered the port off during boot after applying
the cpufreq patches. So the error might be useful to understand
why there are boot issues.

Greetings,

-- Sebastian

--yifwsz4amhmfrmbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbqoEQACgkQ2O7X88g7
+pqUsw/+I+jSbASlllCJiafsFHS/h9tFttfwuwAsQHThiqsBqsULm4UK5wPr9Rq6
repuJf0hyz5FW8TPjdoCC1P9eGKZPDewT71VXoeZbNRS1t5vIqoeg4xzY/NjTuDG
bx/e0r5KAOJZK5Dt5pYZjY4UTGOhG3yU9EN1SII/hl8/JglVQNWSKIWABixsN7xw
/Amh2NWHRTEdofg0opRdJc6jSTRvCEp3h6Aa+i9u3wtxIq7e55Z0OY3pOtVP+xJc
maqVrEMmmR/Gm0//WGG6LXeA8+6vJzsS8PlYlN1ORJs88jhRbm08Eh6exy287l8u
uzRwEze8qq3Ixj3vefMEMvF1t890jmFan6Sc66oD8OTb4hKsqH8kgZEx6m4QF3/H
Tyh7LP9spr66RsMoP8t7bUslhG2IK7wd2YGCVTPUMTeh6J43+tatiToEmNsduLyV
l/rxFwzz+WNW//JOWGniHPA5Uav0lwLm6gWlrn9SMm+usdgqdUXSTVgvipJ9ZXS8
ew07SA8IOGZgoZ1A8oGw0y2rSpNVBEj6SyU6cmCqy1pEo8HmqFNRPiKj3uanhYPT
K3YLM+K8lBDGpesk8yjgC0mlQH4TbejVUDX+URGNoY0/ytbOkc2SNeDnxcE6sMPs
j9hN86KPFfNH8i6BN7JR6H5iBt1dQnK3MqiYLcP5LnP/HPb2WS8=
=buEK
-----END PGP SIGNATURE-----

--yifwsz4amhmfrmbj--
