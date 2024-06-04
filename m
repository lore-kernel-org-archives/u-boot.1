Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C85CC25B75
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 01:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C46E87BCB;
	Tue,  4 Jun 2024 03:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JKojbF27";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC7AD883D8; Tue,  4 Jun 2024 03:26:27 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE85C87BCB
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 03:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1717464385;
 bh=iRkzly7eOZQsWBJLhxu6xkKFTiNVFS2RssWAtfB888E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JKojbF27lulk5Prw9wWJPIhLa1ZjCRMlgK4IzfKBfBd7Akc/z9W08mzgkFlXWnb3e
 POThfWjcgQgDafUc4kuWqa1vlxYq2YhaxyNBLKzntAHYHKoeG/YCf/pzOsEc3AdFcB
 rLqhH3XCGuAjXTXnhU6cMXcH0WXeCvAbtWGcor6ki2U3wGU1+im4OSmYFaxs54Jaza
 hN0guM4/rqVNAY6k67A0BwzUWbefjQaJgYGREotAKhh8iH41kmjh/X4Leob5pS3kRP
 /le31P87Q2oh1f1YLJHkGEaSZxV9xAZ+U9U0ZgZR1/uhe8aSUNAbD+/AKojNqUmPT3
 O2xgToVPDhmKg==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4C5653782182;
 Tue,  4 Jun 2024 01:26:25 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
 id DA77510611D2; Tue, 04 Jun 2024 03:26:24 +0200 (CEST)
Date: Tue, 4 Jun 2024 03:26:24 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Eugen Hristev <eugen.hristev@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v1 0/5] FUSB302 USB-C controller support
Message-ID: <twxbgtfgv7alel7z5tqs4wmd7rdtbyuu2kqd3w3hmdmyrgmko6@2vqvuzxh22di>
References: <20240531151026.84846-1-sebastian.reichel@collabora.com>
 <7ace6636-54ed-477e-9fb2-a9aac6ec4e7b@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u5rfc24teh3z6mwq"
Content-Disposition: inline
In-Reply-To: <7ace6636-54ed-477e-9fb2-a9aac6ec4e7b@kwiboo.se>
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


--u5rfc24teh3z6mwq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jonas,

On Mon, Jun 03, 2024 at 11:58:07AM +0200, Jonas Karlman wrote:
> Some initial quick feedback is that the tcpm uclass and driver should
> probably take more advantage of the u-boot driver model.
>=20
> Few quick thoughts:
> - Split out uclass/driver api parts into tcpm-uclass.c
> - Take advantage of uclass_driver ops such as post_probe and
>   per_device_auto/per_device_plat_auto to e.g. handle tcpm_port_init and
>   tcpm_port/tcpm_dev
> - udevice should probably be passed to tcpm_ functions instead of a
>   tcpm_port, dev_get_uclass_plat/priv could possible be used to get
>   the tcpm_port data for the udevice
>=20
> I have not yet had time to runtime test this but will do and get back
> with a more in depth review later this week.

Thanks for the quick thoughts. They do sound very sensible, so I
gave them a go. The diff turned out to be quite big (about 20% of
all lines changed). It's currently one big cleanup commit, which I
still need to split and merge into the tcpm and fusb302 commits.
After doing that and some more testing on my side I will send
PATCHv2. I expect this to happen within the next 48h, so it might be
sensible to wait with further testing / review until that happened.

Greetings,

-- Sebastian

--u5rfc24teh3z6mwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZebTYACgkQ2O7X88g7
+ppnaQ/8DKf3/qp7zj9peRCissC9GE5WxHXEnB9tNHxX9hgGTBHsStWWilVVJJ+v
78w1tTk6PmrquzH3ZvJncXW9qHlqqXCAFOvr9dMSlWsWVQHbysUfk3uDPfTpirJm
ElVsYPdkX5xDMqcKuti4NPoJqgT4/6A2ZWhhv1JMSHAFPPOoLMnNiQaUpN7Nd0nx
Y5Z+AMOz5Fmu3h59nVjgta7y/5q7GjWbPShKcu7aiqpkhfUiY+GJEmidagKuVn14
sqwFXFhsvUF6qgROvm1gHCVwN2pQzmec8PiPot89bSI61edIpBSTSvnuN04yH3DJ
cL5FFJBXqkcta437FfB+T5aD5PtU1JwCw5z+OHU5JbY7OlK9QO/eOz2UQY3xBjW7
T9lrQB0Z/fMgx4XTmQiEkEymtXeofXiBgYEvVknyCDkhIDiIC0zEMXFGsLGKj4bK
A6jtZx1a4PjrkZ0avv4nb78FdKOtcB870/4TyXQmhOY9JqUjmoZmriD3CDG/78q5
eTlyf0YXwn9vv3Q7Gp1fFEjStYobIw92pp6yMZ5to75lF8lSFvPus2HCsPyQBpbP
BB3nAAPc+Jk2xZmr04M09TIqz+xxaD9MRUy6oSUOQP6FCV5stv6peie4apLjSFzY
0Exlvji/hLxdAfMqQndRmFyD0FBWKzDj8wo2MpfHfxlcSxufCkM=
=sTmG
-----END PGP SIGNATURE-----

--u5rfc24teh3z6mwq--
