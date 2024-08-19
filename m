Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8F5C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 17:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A36188CF4;
	Mon, 19 Aug 2024 19:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="USCpcFTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6A52889C3; Mon, 19 Aug 2024 19:38:14 +0200 (CEST)
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com
 [136.143.188.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F3BE889C3
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 19:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724089087; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MGqnHagUMWyKaYs8VcdbmnL46rQkZEtGhNf/A/byq3LtPEPqVz4BYvnPerSnrtxRTVsB5EY/gfgDwCGU627pTIRaa6x+psqDuC0U29ip4HAgCaqQYWv+GldDTrju8SFRL0MbW2hmXuMyp8tvxxtUIpmjl96ZyPGsElw0+BHDtdk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1724089087;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=AxmQg3DRwWR/JZyjjaaPtlH0wydhNrgNWNnoWqxd9+c=; 
 b=CfSbTdJ8dTgLOKQvGxpDHwltAqxvOkJXkvmCoHsqBuuVfrk5wxKvkmoJzmxojLnH5r0BzenMyo61/75tmsyZ9DXviDLGXaVzuEGPBHddgytzjFI8R2rCCRWKLmcefZf6/B/fzHfDHfjLRrJ2XdOdZv6WFyBrmpyo9ILRT9WFDhg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724089087; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=AxmQg3DRwWR/JZyjjaaPtlH0wydhNrgNWNnoWqxd9+c=;
 b=USCpcFTYXPSsqkcP1S6E4HchJJnnT/29bZzYtNJUFLt98XjI+FeMtpxqx2Eunj7H
 HlNnzn1UU3KhfGQYvk2HX8HGGJaT6+HDQe/oEwOTTVd+TA2uqCj8skTpNLPQtnJ/BYW
 bxEOyxFTGmIzqX5xW4zqMgS8qyz1eof08/V5DvWg=
Received: by mx.zohomail.com with SMTPS id 1724089086107495.4562928969556;
 Mon, 19 Aug 2024 10:38:06 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
 id A8A7F106045A; Mon, 19 Aug 2024 19:38:02 +0200 (CEST)
Date: Mon, 19 Aug 2024 19:38:02 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, 
 Eugen Hristev <eugen.hristev@collabora.com>, u-boot@lists.denx.de,
 Tim Harvey <tharvey@gateworks.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Simon Glass <sjg@chromium.org>, Soeren Moch <smoch@web.de>
Subject: Re: [PATCH v3 0/7] FUSB302 USB-C controller support
Message-ID: <yi6wmt52ro5wg7baydfn6hixmv5ctfzcdfs7rrxy73oht3rc54@mxzn67zhfglt>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
 <d3c80c56-ebb0-4b6f-ac92-15cd646feb27@denx.de>
 <6f42837e-6378-4ded-8120-d642a13e69df@kwiboo.se>
 <baf69a18-e19f-49e5-82d8-c6a128147672@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5no4oyvhn65j2n25"
Content-Disposition: inline
In-Reply-To: <baf69a18-e19f-49e5-82d8-c6a128147672@denx.de>
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


--5no4oyvhn65j2n25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 19, 2024 at 07:08:37PM GMT, Marek Vasut wrote:
> On 8/18/24 11:43 PM, Jonas Karlman wrote:
> > > > On ROCK 5B power is usually supplied via it's USB-C port. This port=
 has the
> > > > data lines connected to RK3588, VBUS connected to the input regulat=
or and
> > > > CC pins connected to FUSB302. FUSB302 is a USB-C controller, which =
can be
> > > > accessed via I2C from RK3588. The USB-C controller is needed to fig=
ure out
> > > > the USB-C cable orientation, but also to do USB PD communication. T=
hus it
> > > > would be great to enable support for it in the operating system.
> > > >=20
> > > > But the USB-PD specification requires, that a device reacts to USB-=
PD messages
> > > > send by the power-supply within around 5 seconds. If that does not =
happen the
> > > > power-supply assumes, that the device does not support USB-PD. If a=
 device
> > > > later starts sending USB-PD messages it is considered an error, whi=
ch is solved
> > > > by doing a hard reset. A USB-PD hard reset means, that all supply v=
oltages are
> > > > removed for a short period of time. For boards, which are solely po=
wered
> > > > through their USB-C port, like the Radxa Rock 5B, this results in a=
n machine
> > > > reset. This is currently worked around by not describing the FUSB30=
2 in the
> > > > kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This m=
eans
> > > >=20
> > > > 1. the USB-C port cannot be used at all
> > > > 2. the board will be running via fallback supply, which provides li=
mited
> > > >      power capabilities
> > > >=20
> > > > In order to avoid the hard reset, this adds FUSB302 support to U-Bo=
ot, so
> > > > that we react to the power-supply's queries in time. The code, whic=
h is
> > > > originally from the Linux kernel, consists of two parts:
> > > >=20
> > > > 1. the tcpm state machine, which implements the Type C port manager=
 state
> > > >      machine as described in the USB PD specification
> > > > 2. the fusb302 driver, which knows about specific registers
> > > >=20
> > > > Especially the first part has been heavily modified compared to the
> > > > kernel, which makes use of multiple delayed works and threads. For =
this
> > > > I used a priorly ported version from Rockchip, removed their hacks =
and
> > > > any states not necessary in U-Boot (e.g. audio accessory support).
> > > >=20
> > > > Sorry for the delay in getting PATCHv3 ready.
> > >=20
> > > I am the one who should be sorry here, really, sorry for the abysmal
> > > delay in my replies.
> > >=20
> > > So ... this series looks good to me. Thank you for working on this !
> > >=20
> > > Jonas, are your concerns resolved ?
> >=20
> > No, for ROCK 5B the full overwrite of the Rockchip common misc_init_r()
> > in mach-rockchip/board.c should be fixed, rockchip_early_misc_init_r()
> > could probably be used instead (or possible a PREBOOT cmd), see [1].
>=20
> Can you use DM_FLAG_PROBE_AFTER_BIND instead of misc_init_r for this ?
>=20
> drivers/led/led-uclass.c: dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>=20
> This will probe the driver after it got bound, and you won't have to hack
> around board files or arch files for this.

Jonas suggested the same. My response still applies:

Depending on the remote side (i.e. the power-supply) the TCPM state
machine can take quite some time to get it into the "final" state.
The worst I have seen was around 2 seconds.

Boards, which are not powered via their TCPM controller can survive
a USB hard reset and do not need any U-Boot support. I think we do
not want to add this penality to these boards.

Greetings,

-- Sebastian

--5no4oyvhn65j2n25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbDgukACgkQ2O7X88g7
+pog1Q//bLBYO7nJvfAnpZ8f7uo2h8t5f3jth+gWlEtccJX2BwqbOn1C+SJoTX21
ksqFoNVSr/FGbVxexS3Rc0PNffjzqAPcc0wpjK5e+9qOK4+Zlj3NeDZKblpxp69I
3HowCksl+s6eQhYLF+igtc/aQ4UKyiFXPYB+ARx9lH7L+WUeLu1WGngHLCqJOrm9
6aK3CRZyaHHzaKYo8bylHRM6sh94koywDUruV3yIZfHsKEt5j6aUb5VUMOUZ2bzk
gtaj8CsNP9xpu5ESzNVJXvZSB2iOggqCyD+sViSHj9dJjK1bCTBS8n1OC2irijgK
7VGKHPL1seKxEVhSBEbSuMMTUTA6KEVc/7S2SfJlbUODr/42jVBKHfPK4ckVwujc
hjRU+LfhTwJ6rtZ8IvqkZ/S+/eXl82KoCE6eZpBs8kTuX1xhA3fMp8XXBinMwy/h
JxphygzwjusICgu7z4nIcgevzk15vBalooTjE0kqAgq8vgWMNN29SWuZVD4ol2EN
SyTMFK5uxr8AVvZcs7Rh6cTQ+7d25k/VwhaHSr+B7VOQyFyK4tFpnNTd8PfVcoMY
gG/c8f+OndsokqtW/KoHK2EPRKbJIJP7Tdndwub3keJmXRCGhk/P+faqPV2zpIBe
jRIz1CF7n6Xvj1av46L5mz1knFMja1Swv1CVrkcZ5Vq4yBbvR9Y=
=f8BD
-----END PGP SIGNATURE-----

--5no4oyvhn65j2n25--
