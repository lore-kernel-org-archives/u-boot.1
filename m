Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD9DC52D6F
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 17:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 690C588CF5;
	Mon, 19 Aug 2024 19:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="I8krOnSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E8D882F0; Mon, 19 Aug 2024 19:20:53 +0200 (CEST)
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com
 [136.143.188.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 924A188CF4
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 19:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724088046; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PY0YGtuiOa9VLf1f1uACtYfnZyUs+vDMVZnwslyavmeLLnhnHXIeQAYHPs0h5F+K0o/nFQBeqq//CLtLE6eOneuIGDdwdkRWnoj4dTwoRzQYDKVoaaqG9gp/K7Tc8hXo5jeR0EgOnAcbqfZufNr4pzVR+Wnof7Lh2D8e0BjSZzU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1724088046;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=faSmEAFki+/eoQqhioiTiirrQuzOrpJMBBMQ55qrrgM=; 
 b=MROfczkYM45Nu5v2AgKzbrIM3YQKdIryxlAZBfVettHmGlucqEut1OOb5nYyagP+7oIMD4SFQ5tQcfTofV6+Ve6G298tk4jGQAfwRMZoRAK7J5LNVsKyVus17XZ5MF2HUfZMhU+9cpKMAMb3L7EKlRH8cUwdxYYD4sZZXN2zx3A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724088046; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=faSmEAFki+/eoQqhioiTiirrQuzOrpJMBBMQ55qrrgM=;
 b=I8krOnSUSnoFF2TcXsbwWwgBaUbjeWtBykfBJ6RvJaNteZkFI/VKsGEyRNMbhvH6
 Ta1usO2HLqwxdNVZzMmZ7oR1qiJ/tTtR6bs4mOLOesa3XwwoZRELMmcIYem4eEGZ+Z1
 pPFn5KQWsNjVaeDn5JKSIqpGpIFCpu7Wv5qIkOew=
Received: by mx.zohomail.com with SMTPS id 172408804389569.91039116834042;
 Mon, 19 Aug 2024 10:20:43 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
 id 758FC106045A; Mon, 19 Aug 2024 19:20:40 +0200 (CEST)
Date: Mon, 19 Aug 2024 19:20:40 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Marek Vasut <marex@denx.de>, 
 Eugen Hristev <eugen.hristev@collabora.com>, u-boot@lists.denx.de,
 Tim Harvey <tharvey@gateworks.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Simon Glass <sjg@chromium.org>, Soeren Moch <smoch@web.de>
Subject: Re: [PATCH v3 0/7] FUSB302 USB-C controller support
Message-ID: <qi62b7gz4xr32zxr72i5sx4mblzdovrqo7pt66x3ykg7zcwfew@buih72k7ugd7>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
 <d3c80c56-ebb0-4b6f-ac92-15cd646feb27@denx.de>
 <6f42837e-6378-4ded-8120-d642a13e69df@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rmhakxbkiogv777w"
Content-Disposition: inline
In-Reply-To: <6f42837e-6378-4ded-8120-d642a13e69df@kwiboo.se>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/224.60.1
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


--rmhakxbkiogv777w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 18, 2024 at 11:43:36PM GMT, Jonas Karlman wrote:
> Hi Marek and Sebastian,
>=20
> On 2024-08-18 22:35, Marek Vasut wrote:
> > On 8/2/24 7:59 PM, Sebastian Reichel wrote:
> >> Hi,
> >=20
> > Hello everyone,
> >=20
> >> On ROCK 5B power is usually supplied via it's USB-C port. This port ha=
s the
> >> data lines connected to RK3588, VBUS connected to the input regulator =
and
> >> CC pins connected to FUSB302. FUSB302 is a USB-C controller, which can=
 be
> >> accessed via I2C from RK3588. The USB-C controller is needed to figure=
 out
> >> the USB-C cable orientation, but also to do USB PD communication. Thus=
 it
> >> would be great to enable support for it in the operating system.
> >>
> >> But the USB-PD specification requires, that a device reacts to USB-PD =
messages
> >> send by the power-supply within around 5 seconds. If that does not hap=
pen the
> >> power-supply assumes, that the device does not support USB-PD. If a de=
vice
> >> later starts sending USB-PD messages it is considered an error, which =
is solved
> >> by doing a hard reset. A USB-PD hard reset means, that all supply volt=
ages are
> >> removed for a short period of time. For boards, which are solely power=
ed
> >> through their USB-C port, like the Radxa Rock 5B, this results in an m=
achine
> >> reset. This is currently worked around by not describing the FUSB302 i=
n the
> >> kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This means
> >>
> >> 1. the USB-C port cannot be used at all
> >> 2. the board will be running via fallback supply, which provides limit=
ed
> >>     power capabilities
> >>
> >> In order to avoid the hard reset, this adds FUSB302 support to U-Boot,=
 so
> >> that we react to the power-supply's queries in time. The code, which is
> >> originally from the Linux kernel, consists of two parts:
> >>
> >> 1. the tcpm state machine, which implements the Type C port manager st=
ate
> >>     machine as described in the USB PD specification
> >> 2. the fusb302 driver, which knows about specific registers
> >>
> >> Especially the first part has been heavily modified compared to the
> >> kernel, which makes use of multiple delayed works and threads. For this
> >> I used a priorly ported version from Rockchip, removed their hacks and
> >> any states not necessary in U-Boot (e.g. audio accessory support).
> >>
> >> Sorry for the delay in getting PATCHv3 ready.
> >=20
> > I am the one who should be sorry here, really, sorry for the abysmal=20
> > delay in my replies.
> >=20
> > So ... this series looks good to me. Thank you for working on this !
> >=20
> > Jonas, are your concerns resolved ?
>=20
> No, for ROCK 5B the full overwrite of the Rockchip common misc_init_r()
> in mach-rockchip/board.c should be fixed, rockchip_early_misc_init_r()
> could probably be used instead (or possible a PREBOOT cmd), see [1].
> Also the check for MISC_INIT_R symbol does not make sense and should be
> dropped, see [2].

I have a local change using PREBOOT cmd instead of misc_init_r()
and it works. I'm currently looking into the issue reported by
S=F6ren Moch before sending a new version.

Greetings,

-- Sebastian

--rmhakxbkiogv777w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbDftwACgkQ2O7X88g7
+prvXQ//Qpol6UpqnGAwVp2yufZ5W66095yA2FO5MKI/eSMCFkukapg/OeTpqFOZ
9yyS12T94+KXfjOIL1yVKhf6JhZ1ucthXw4sOd+M2DN0643+Jd36OtxBcl3FthfP
LG2BKegJNODd2SDEOY7qkEufJX4iFE4gKFitpHnuT9/BhiLn7JmWSbbBPhWz5f9Y
4H1TWG3PGkjft5Ad0boIep5HMkFK9gLwkgvLOGq17xCspLQLKVG4FkhHkKl2ihaJ
t0ib69hvyj6sSRb22X5ngUpjraLUumoZvfUy9o5IfEmdYf7dQ1udO4g2sN0uhxLQ
NYlRBtTeOfSiHWtBS+2UkeLaAko36vzgCoaR/2AfCbi7qEigbXyvX8uM2itOepa9
mWfdjBi62IdjxThqMn9kIg+z1EYJhnGM7hy79uY/XCEwkjNTsXsaFY35+XJS1uwa
lLgDr6jMusQ88B8HPDtP0yok6JP7ebO3Z22Nr8geJyXwRZD/Kx7cg0wzX05IUaEH
6w18rucbChttY/x13AM6W20ZII9YbLtQZFX3cmWLaXsIJAOXfCndZupUn4xmvGwr
Dra10NMRA/O0aZ5dijClmUVtS4CYqzQ2cIETYoZ/u/IsJrEanRlGGyieujm2Qezy
VpQJ+L8EjpdqKHSJeExWeQ+P+5SBk9zsHOdqSCpK9AzlvJALpyQ=
=9i53
-----END PGP SIGNATURE-----

--rmhakxbkiogv777w--
