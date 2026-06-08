Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F47CD8CA7
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 21:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7829783FEC;
	Mon,  8 Jun 2026 23:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hwzbGa29";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DB46847B0; Mon,  8 Jun 2026 23:13:55 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1070B839A8
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 23:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D08E434C8;
 Mon,  8 Jun 2026 21:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554C91F00893;
 Mon,  8 Jun 2026 21:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780953231;
 bh=eL7+6hZzv3Zu521Ucm1xKMtvhH18OtAdoQg8vdDaW2I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hwzbGa29rpxryTTxnDsiBcl26UE5dVjEdEK/TQG6AatUbcWPCTzp/k/tRSIVnoa0e
 YTW9x3s1SN/pBjN9QdpSLzI3aSwh31ICfQtrEld8P0F8LMl4V6YQHLe3iX3BQNSOGX
 nYRDdpwAnrJyYwfOWzYf9Et3w4wAdWEtZGaotQOjTVB7ijmfJZj/pkTIjSZPYfI85u
 KvccBn5llMBWSg/tBBABhv4vF9P/ydq6hCeoft3tJkuRLMkQXc2KifbxBzrZ8vv/bK
 r89mrgWVkCzj+zZHguXTGz1F0nj48mFE5Kbmb57x1oRv70Ljpk08USrzewAq/4EFB5
 yPvRjeQXQQqBQ==
Date: Mon, 8 Jun 2026 22:13:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Jamie Gibbons <jamie.gibbons@microchip.com>
Cc: u-boot@lists.denx.de, Conor Dooley <conor.dooley@microchip.com>,
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>
Subject: Re: [PATCH 0/4] mailbox: mpfs-mbox: fixes and syscon support
Message-ID: <20260608-booting-borrowing-19b9684919c5@spud>
References: <20260518141712.3597880-1-jamie.gibbons@microchip.com>
 <20260519-broadness-platypus-e4f17dcc42d9@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9kEgXGvRUm8FH1SY"
Content-Disposition: inline
In-Reply-To: <20260519-broadness-platypus-e4f17dcc42d9@spud>
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


--9kEgXGvRUm8FH1SY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Tom,

On Tue, May 19, 2026 at 05:24:30PM +0100, Conor Dooley wrote:
> On Mon, May 18, 2026 at 03:17:08PM +0100, Jamie Gibbons wrote:
> > Hi all,
> >=20
> > This series updates the Microchip PolarFire SoC (MPFS) mailbox driver in
> > U-Boot.
> >=20
> > The first three patches contain a set of bug fixes and cleanups to the
> > existing driver, fixing MMIO size calculations, and removing invalid
> > mailbox channel and private-data handling. These changes are independent
> > of any devicetree updates and fix issues present in the legacy driver.
> >=20
> > The final patch adds support for the corrected, syscon-based devicetree
> > bindings for the MPFS mailbox. Linux has moved to this binding to more
> > accurately model the hardware, and U-Boot already supports the same
> > approach for the MPFS clock controller. This patch updates the mailbox
> > driver accordingly, while retaining support for the legacy binding for
> > backwards compatibility.
> >=20
> > The final patch is required ASAP as boot is currently broken on master
> > for MPFS generic boards.
> >=20
> > Tested on a PolarFire SoC Icicle Kit ES.
> >=20
> > Thanks,
> > Jamie
> >=20
> > Jamie Gibbons (4):
> >   mailbox: mpfs-mbox: fix MMIO mapping calculation
> >   mailbox: mpfs-mbox: fix Driver Model private data handling
> >   mailbox: mpfs-mbox: fix driver bug and cleanup
> >   mailbox: mpfs-mbox: support new syscon based devicetree configuration
>=20
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Would you be able to grab this please? Your current mainline branch is
failing to boot because the last dt-rebasing version jump brought in a
changed dts from linux that requires the syscon-based devicetree setup.

Thanks,
Conor.

--9kEgXGvRUm8FH1SY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaicwigAKCRB4tDGHoIJi
0iC9AQCtXljs6BigCCxQ3VyS/Rs+JPc8W/G3LamM8w31nwIcaQEApvSaWg8bRhxA
We/w1dMWQGuKLFiXGDnbnZoJc+t+IQU=
=DHwF
-----END PGP SIGNATURE-----

--9kEgXGvRUm8FH1SY--
