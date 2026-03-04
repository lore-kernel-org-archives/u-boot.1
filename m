Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5006EF8FEE
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 14:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FEAF838BB;
	Wed,  4 Mar 2026 15:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T5vav0gP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A398839A8; Wed,  4 Mar 2026 15:58:45 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D2583642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 15:58:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1CB9860097;
 Wed,  4 Mar 2026 14:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDB6C4CEF7;
 Wed,  4 Mar 2026 14:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772636321;
 bh=dZVugjyBVa3dWf+6Den9zx19iIPKH/wmFSVW1hrzONQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T5vav0gPfm50X/2YN/T09ORRZ/FYTioYagn6nP0eHkPdkPGpI9pdjX3m5GbKaCgjh
 sBWmK/SGGQs//pjuwkdP82d+/++pDWkjMNe2nuQdDgGRtVsWWCQu9crTB7LI/RGxzv
 GwDraDQx9HYmt2wURF7sxUCnXjfdbVn/X9oDYs5vNP0qqCdOIF1OXjYjHyidzFTUOM
 f6qUcqJKIMGrxnsgSZzQTIO3rgh9DJu6yRvZ0VO3qDPnthnsydtqhexLxHjTy6q0xm
 TmS14FJDLT5qMkCCjifkaUTmOLzys8Qzp/BVykEYhqh8/Sjkh9zdkWPRSwxM88NBjS
 wUOrafpeNGuAw==
Date: Wed, 4 Mar 2026 14:58:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: "Ng, Boon Khai" <boon.khai.ng@altera.com>,
 U-boot Openlist <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] spi: designware: add support for bits-per-word DT
 binding
Message-ID: <20260304-purify-activate-7bb0d1447dbd@spud>
References: <20260227110434.5058-1-boon.khai.ng@altera.com>
 <20260227140756.GP1593142@bill-the-cat>
 <a66c8ed7-0f88-4e1f-a212-30e39f675df2@altera.com>
 <20260303143721.GM1388590@bill-the-cat>
 <20260303-choosing-chivalry-6f892a14eaef@spud>
 <ca14a108-6308-4b48-981a-a0d20b716ded@altera.com>
 <20260303170554.GR1388590@bill-the-cat>
 <09b4a249-15f5-4e0a-ae51-b248aa57bcdd@altera.com>
 <20260304143817.GS1388590@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BYZJcM1FVOwHsVGS"
Content-Disposition: inline
In-Reply-To: <20260304143817.GS1388590@bill-the-cat>
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


--BYZJcM1FVOwHsVGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 08:38:17AM -0600, Tom Rini wrote:
> On Wed, Mar 04, 2026 at 10:41:57AM +0800, Ng, Boon Khai wrote:
> >=20
> > >=20
> > > Thanks. And can we reasonably follow what Linux does here instead?
> > >=20
> >=20
> > We don't have ACPI in our devices, instead, i think that can be replaced
> > with DTS.
>=20
> I thought Conor said it could be auto-detected still, without ACPI, in
> Linux?

The controller capabilities are auto-detected. This has nothing to do
with ACPI AFAICT, I don't know why that was brought up. What it detects
is not an exact value though, the detected capability is the max of a
range. On Linux, the spi controller driver advertises the range it
supports. The spi device struct carries the bits_per_word that it wants
to use, and the controller driver looks into that struct to figure out
what supported bits_per_word setting to use in the transfer function.
It's not as simple as just reading the register in the controller and
setting the U-Boot drivers bits_per_word to the value, but I don't see
why U-Boot couldn't do what Linux does here.

If you search in spi-dw-core for bits_per_word, you should be able to
get a grasp of how it works.

--BYZJcM1FVOwHsVGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaahInQAKCRB4tDGHoIJi
0t0WAQC4WlHea9AfTjnCbPbKm4PaZnvPY8WrPQjLB1Yem6o9YwD+LPjXVLSUVuZg
kv4arEeJN4gsWhyJnEzAZxQL2Wg7Ngg=
=hXYB
-----END PGP SIGNATURE-----

--BYZJcM1FVOwHsVGS--
