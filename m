Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17ED2CD37B1
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 00:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2629188B4B;
	Wed,  4 Sep 2024 02:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="dRvdF/4W";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="V6VTxDm1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 755F088C1D; Wed,  4 Sep 2024 02:03:30 +0200 (CEST)
Received: from a7-49.smtp-out.eu-west-1.amazonses.com
 (a7-49.smtp-out.eu-west-1.amazonses.com [54.240.7.49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB2488B4B
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 02:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=01020191ba57e28c-d386c206-8177-45b4-b573-a1abdf6e69c9-000000@amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725408207;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
 bh=NgrgIj5b8e8BnDNNOUVlaoD4tYblyjSmc6UgxkQvpzs=;
 b=dRvdF/4WmHT4ktFhmTJ8OtYS5T06s8IBlBRRkYtMRL3dRIYR2mPJib/wjBfHSQR2
 m21D0z/P9JBUAmX5ax41YoPUlcEzE2NGT+wDVMfsRuq5rzfjq7DNhF/7fpivKe/d5ir
 cev8uhKnKkGo/4isw/+r+pcxrE1Nxj/379DOJUeMVPk4a+EggkOocbS05GDKWY9FYIV
 cg2MArADfM8N+opzzJz9QdRqmG02RY2g7ebby/brGXZH9grjiH/8aDGNn25T9/WBjDg
 Ykp+vP7MZBsMvh1SCbs929x5/ObFxS3CfSQjGzHtxbNjZBm6A18d8vhh2pfs7JJKKG1
 SuI88bZXIg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725408207;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
 bh=NgrgIj5b8e8BnDNNOUVlaoD4tYblyjSmc6UgxkQvpzs=;
 b=V6VTxDm17lB8PWdJGR2QuJ32qdzTfjSAXqRI6dakJ81JZvsFBQVUwIc3xE/il4wr
 nBr6eUpfOHMHrUYtx6FfMd97UG2SGEta/nEoCbziSyOUxshIS5pWlLIKzhjYXgSNJI/
 DHWU3xHe3WevuTfvXDND1T+OcuZA0txENsa6LDG0=
Date: Wed, 4 Sep 2024 00:03:27 +0000
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Soeren Moch <smoch@web.de>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v5 0/6] FUSB302 USB-C controller support
Message-ID: <01020191ba57e28c-d386c206-8177-45b4-b573-a1abdf6e69c9-000000@eu-west-1.amazonses.com>
References: <20240903182136.153196-1-sebastian.reichel@collabora.com>
 <d17f96a6-8e24-41e6-900e-1e546b6bc42c@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5kmiqvpemycujzxa"
Content-Disposition: inline
In-Reply-To: <d17f96a6-8e24-41e6-900e-1e546b6bc42c@web.de>
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.04-54.240.7.49
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


--5kmiqvpemycujzxa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Soeren,

On Wed, Sep 04, 2024 at 12:26:43AM GMT, Soeren Moch wrote:
> >   * non PD capable (reports 5V 0A)
>
> With a dumb power supply (actually 12V w/o USB-PD) I see a error message
> (not really sure if that makes sense, but no strong opinion from my side)
> and 5V/1.5A reported with 'tcpm info', see below.
> Can we expect 1.5A as fallback supply w/o USB-PD negotiation? 5V OK, but
> I'm not sure if USB2/USB3 type A to type C cables are allowed according
> to the USB spec, with lower possible currents.
>=20
> I'm not sure what the 'right' thing is to report in this situation
> (also cable orientation makes no sense).
> Just want to mention that I see something different here.

USB-C sources, which are not PD capable can use pull-up resistors to
change source advertisement as follows:

    | advert.   | pull-up to 5V | pull-up to 3.3V |
    | --------- | ------------- | --------------- |
    | default   | 56K           | 36K             |
    | 1.5A @ 5V | 22K           | 12K             |
    | 3.0A @ 5V | 10K           | 4.7K            |

default means 500mA for USB2 or 900mA for USB3, which is reported as
0 in this series. Your setup seems to have pull resistors advertising
the 1.5A profile. If your setup includes an USB-A to USB-C cable the
pull resistors are in the cable, since the pull resistors are on the
CC pins, which do not exist for USB-A.

The same pull-up resistors should give away the cable orientation :)

> >   * RavPower 90W
> >   * UGREEN 100W
> >   * Anker 45W
> >   * RavPower PB
> >=20
> > Changes since PATCHv4:
> >   * Rebase to latest master (v2024.10-rc4)
> >   * Fix regression introduced in PATCHv3: The exit code for fusb302_set=
_vconn()
> >     when vconn stays the same should be 0 instead of undefined
> >   * Fix regression introduced in PATCHv3: tcpm_set_polarity() needs to =
update
> >     port->polarity when there is no driver specific set_polarity functi=
on
> I can confirm that these fixes indeed fix my reported regression from v2.
> Booting to Linux works perfectly fine when powering from simple USB-PD
> supplies (12V, 20V), as well as with power from my notebook computer.
>=20
> So for the v5 series:
> Tested-by: Soeren Moch <smoch@web.de>
>=20
> I also tested powering from a UGREEN USB-C dock (see boot log below).
> This also worked well. Only the data role was not switched correctly
> to host as required for the dock. At least we got this 'not supported'
> message probably related to that. Maybe that can be fixed later in
> follow-up patches.

Yes, this series focuses on getting sink power role working as this
is needed to enable USB-C support in Linux (or any other OS). Handling
for data role swapping can happen on top of this. Linux should be able
to swap the data role if it had been configured the wrong way around in
the bootloader without triggering a hard reset. So this should only be
needed to have the dock's USB ports working in U-Boot itself.

Also acting as USB-PD Source is not fully implemented and needs to be
added on top of this once it is required by anyone.

-- Sebastian

--5kmiqvpemycujzxa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbXo8UACgkQ2O7X88g7
+pr6DA//SzChcHy9QPBAhjCon2TiMXYUZ6bp4YxBAK7iQlBSxP07tdpnuPLDDFId
IFGsQVPGLm04Y6i6unGX7vjXR/6KbgyPvJEbILCdABMbtjao77foH9agm24kNL+B
6oUFfnehtnfm1KaQLZkdeYahaOGng/V8BPRY3WHDN7q5mijYzj83NrYsX0zsRQDP
nyHVIhMczv/IYn/PWZw+xkkDXCsBK3DrgYmk9s2Mg+YtM3ZcNlj+DMyu1WpBv5P+
P/sdPmg9WO9OzBMFp0n98jPZhvQIIkRjzoZbi9BiJEcQU7aOctl+eYt0lnLJKMWc
MLjGPWT7xRdrqphnVte7654VjT51aLg6ljGMJI+78ZdHv0acKJAbMv2a5k0pWKAe
Wm2qKijUp2VjkgnS8QiCYSqRCFpmxDj0lOcTcU6YPp4t01BulNmVMBYDiVsY1UDf
JrZ6meupVzEgeFsmSozdprOQDLDtLu4GYoilYO3S/8oIfFhZGXMLq579lOGb0C4C
mx0o/pKKFJdZHf/E3Q0tDhLAP1ovWdo6tmy7FYe9/xMGUkSGVMUl3ApGsd86Z4Jb
DqvN6fmqCwa0rY3SidWrDdyHmkr2z4joEewyyrzUHjYtn2/x6RKMcazefEVFWqrv
suqYsCs9WlgDvhvJf5tT7uyPlzq1+UCxIVJkPmbm3JixwRIKXOE=
=nECi
-----END PGP SIGNATURE-----

--5kmiqvpemycujzxa--
