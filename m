Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B31C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 18:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51DA088084;
	Tue,  5 Mar 2024 19:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B3WeZz61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CBF188084; Tue,  5 Mar 2024 19:38:59 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8A2688060
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 19:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A3EBDCE1D8B;
 Tue,  5 Mar 2024 18:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F0BC433F1;
 Tue,  5 Mar 2024 18:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709663933;
 bh=yNiW/2cIe8JPfL1OsQURF8o5Jz2Vk8q0iSDhCZ8Qb6k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B3WeZz61YX/pJMVKMlIS8G7AFzmG60MTFl/oCW59r+1YTgkzEO+BYFBXKAz2kQL7+
 PIk8KLXS2yzaePAndEWb0S0UYB9l+B1Y/7WM8CditjB8l2THV5iMK39NsHkRKbxDH5
 gQAvgIYxJr2uzp10i5KoNQvKLdd48CG9lfCXL4/vsGQAyDwq9zti8OSXN9k4wbB5G6
 dbfmfkOCBu1Dz6P8qO+DhSF2J5y/SBF80+egt7oSVdV8EuSeEmsVzmafMyBO4Q/tle
 d3OZxM0UyNuYhnurkNVyHbnqNxeB9ipNI7ARGsmumnSX2odCjkksv74qNdSvpo1qEa
 xC+2Qn5+Z9EXA==
Date: Tue, 5 Mar 2024 18:38:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Bin Meng <bmeng.cn@gmail.com>, palmer@dabbelt.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1] riscv: cpu: improve multi-letter extension detection
 in supports_extension()
Message-ID: <20240305-squire-musty-bbd192df3780@spud>
References: <20240304232835.3076533-2-conor@kernel.org>
 <da2c1e6b-95c6-4326-a353-3ed32c524b40@gmx.de>
 <20240305-expulsion-pastrami-0a1ca34d96d7@wendy>
 <41a27290-5b44-4e8a-8718-8bbe945fd456@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xBcaIWmWNf3TV4gk"
Content-Disposition: inline
In-Reply-To: <41a27290-5b44-4e8a-8718-8bbe945fd456@canonical.com>
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


--xBcaIWmWNf3TV4gk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 09:10:59AM +0100, Heinrich Schuchardt wrote:
> On 3/5/24 08:54, Conor Dooley wrote:
> > On Tue, Mar 05, 2024 at 08:34:20AM +0100, Heinrich Schuchardt wrote:
> > > On 3/5/24 00:28, Conor Dooley wrote:
> > > > From: Conor Dooley <conor.dooley@microchip.com>
> > > According to
> > > https://github.com/riscv/riscv-isa-manual/blob/main/src/naming.adoc t=
he
> > > ISA string is case insensitive. Why can we assume here that it is low=
er
> > > case?
> >=20
> > The binding does not allow upper-case.
>=20
> Ok. That is in Linux'
> Documentation/devicetree/bindings/riscv/extensions.yaml.

Right. I should've linked to that, sorry.

--xBcaIWmWNf3TV4gk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZedmuQAKCRB4tDGHoIJi
0jE0AQCq0Nmgl/KQg7eaWJkXZrAlBHKzqFAMvP8rmPD8jaTfJAD/dMcv1DSYSnPV
Y7XYK3EW04zKmJWS8kJnmh6mycLNYAk=
=ppiU
-----END PGP SIGNATURE-----

--xBcaIWmWNf3TV4gk--
