Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED39C27C53
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 15:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAD65870AB;
	Wed,  5 Jun 2024 17:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NAnR7mQq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA6F08704E; Wed,  5 Jun 2024 17:38:04 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4597F87BF4
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 17:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 213D8CE182A;
 Wed,  5 Jun 2024 15:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE0FC2BD11;
 Wed,  5 Jun 2024 15:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717601877;
 bh=o4k87sRWNcpblrBVQQGsabSON6rOvCp3L5k4V0JS6aU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NAnR7mQqY6acYUnb27sgspebG6LAAp6H5L9EWJ19EHfqC1Q+j0ePyypMnDe795+BT
 OyYG1laj0BNKT5vZ4oOLlQczXe/0tsfn1ubpBL+bb2gIawi7TX2PlC4+ddBZzf5yVX
 EUHLuNcdaw2JHnJN7z2pFAO+9fdBxwU85NL5PYJdCuIsEPXZqg/dTUpSUhjJHIO2Ka
 /mDGj4wNavZyWm0GBLDBeIUvnpwcJdg73+FIh555XmUlv7fnKyADoWFPoPox7q/ubs
 WppIJYbNTrpl95cE7d08VJSBDbGWDTpv3TmJAkyckoXV96UdB4URxmXiggjParOLFK
 +LiLL6qdLN6cw==
Date: Wed, 5 Jun 2024 16:37:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Hal Feng <hal.feng@starfivetech.com>, E Shattow <lucent@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 0/4] Sync StarFive JH7110 clock and reset dt-bindings
 with Linux
Message-ID: <20240605-process-thinner-9ceb66006959@spud>
References: <20240603132721.6522-1-hal.feng@starfivetech.com>
 <CANV2PTPjbYEWr67bMSM_fg3kSS4Q2kDYdcHTLVp0CrQyeT=dbA@mail.gmail.com>
 <ZQ2PR01MB13070E142612139A6D955820E6F92@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <20240605143515.GP68077@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fWFRAqRvK0wUUmaf"
Content-Disposition: inline
In-Reply-To: <20240605143515.GP68077@bill-the-cat>
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


--fWFRAqRvK0wUUmaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 08:35:15AM -0600, Tom Rini wrote:
> On Wed, Jun 05, 2024 at 01:56:13AM +0000, Hal Feng wrote:
> > > On 04.06.24 04:32, E Shattow wrote:
> > > Hi Hal,
> > >=20
> > > Instead of manual dt-bindings sync can we please adopt OF_UPSTREAM for
> > > JH7110 ?
> >=20
> > Yeah, I will try to do it recently, although I am not sure whether the =
U-Boot
> > drivers and Linux drivers are compatible so that they can use the same =
DT.
>=20
> They must be compatible so that they can use the same DT, U-Boot needs
> updating if it doesn't match.

Other than the naming, I think they are compatible. IIRC there were some
issues where U-Boot originally used different numbers to linux, but this
was fixed in commit 9a12e304dd ("dt-bindings: clock: jh7110: Modify clock
id to be same with Linux").

--fWFRAqRvK0wUUmaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmCGUAAKCRB4tDGHoIJi
0ilDAQDdxRcuDAkiu5PspnWOdrHjqxbKwjeTlmLzSRo5YK/ihQEA3p4EMKH7wYli
xb8r/Bk93lCoRuLmXottAmdV/PD4agg=
=So9W
-----END PGP SIGNATURE-----

--fWFRAqRvK0wUUmaf--
