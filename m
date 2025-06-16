Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D90DC71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 13:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EEB081760;
	Mon, 16 Jun 2025 15:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jP8A+1hb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FE9E81E18; Mon, 16 Jun 2025 15:36:24 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E05380C93
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 15:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55GDaICA3826101;
 Mon, 16 Jun 2025 08:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750080978;
 bh=96B9LEshDnGepG60GnxO/zV/Y5VANsjr8pSBXpvcftY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=jP8A+1hbJYswhZ+wfJ3gU5ki9kJejxaebVBKhWwwgVdvZCiesLgvfZH7DTLkCbZom
 n5dlVyZ7s0uO3AXuJmvnVt2tKY6i3qPMmoCiO3e7RRPD5B7iGqjX/H8pxxbntETR53
 RXPPJ4mgl60qV+rIHLjM4MS4q6mwIVmnd+iPb0RE=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55GDaILa992280
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 16 Jun 2025 08:36:18 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 16
 Jun 2025 08:36:17 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 16 Jun 2025 08:36:17 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55GDaHAZ162992;
 Mon, 16 Jun 2025 08:36:17 -0500
Date: Mon, 16 Jun 2025 08:36:17 -0500
From: Bryan Brattlof <bb@ti.com>
To: Yannic Moog <y.moog@phytec.de>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 0/6] Fix handling of optional blobs in binman
Message-ID: <20250616133617.j7uy2zduxdwrei4p@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="owh577r42oekrxel"
Content-Disposition: inline
In-Reply-To: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

--owh577r42oekrxel
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On June 13, 2025 thus sayeth Yannic Moog:
> This series solves a contradiction regarding ext blobs packaged in
> binman. When they are marked as optional, by default they are faked, two
> messages are emitted. One says the image is not functional the other
> says the image is still functional. Both concern the same binman
> entry/blob.
>=20
> Binman is set up to have fake external blobs in case they are missing.
> This is regardless on whether they are optional or not.
> The implementation does not allow different types of entries to override
> the faking decision; at least there wouldn't be much sense in doing so.
>=20
> Here is an example build output of a phycore-imx8mp:
>=20
>   BINMAN  .binman_stamp
> Image 'image' is missing optional external blobs but is still functional:=
 tee-os
>=20
> /binman/section/fit/images/tee/tee-os (tee.bin):
>    See the documentation for your board. You may need to build Open Porta=
ble
>    Trusted Execution Environment (OP-TEE) and build with TEE=3D/path/to/t=
ee.bin
>=20
> Image 'image' has faked optional external blobs and is still functional: =
tee.bin
>=20
>   OFCHK   .config
>=20
> The output stays to inform/warn the user, but in this case the tee-os
> entry will not be present in the final image.
>=20
> ---
> Changes in v3:
> - Fix all failing tests
>   - add commit that reworks bin.elf test
>   - add section data to failing tests. E.g. tee-os contains missing
>     tee.bin, but is still included in the image.
> - remove _entries -> GetEntries() refactor patch
> - reorder commits -> smaller fixes before refactor EDITME: use bulletpoin=
ts and terse descriptions.
> - squash commits so that for each commits all binman tests should pass now
> - rebase on next
> - Link to v2: https://lore.kernel.org/r/20250527-binman_faked_optional-v2=
-0-3362ab897581@phytec.de
>=20

Reviewed-by: Bryan Brattlof <bb@ti.com>

Thanks for fixing this. That error message has been on my todo list for=20
a while as well :)

~Bryan


--owh577r42oekrxel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE/Oiw75B1nI0/tSm+wPir0+IT1wwFAmhQHdEACgkQwPir0+IT
1wyDvAf9EAfM5zxfNefCJmJN5y/MSMHKLINaKfsaYilmgm1p43cWSKqa5quWhirw
d4gZNsCQQ4h0gIF2MutceaE0gbPt+qSXn+VSaQ1k4NrarrQEZ6btk4V8DppAPy2/
HMf46DiRKZKIlIiWBajDZCvLjAfqNA0Us648CR4gn45lLTALyW7u0GJP0LAqEKWy
foIygDMw65+umUiCsM4MJiRMrFBnus7WDWbbqUxvs1om5A/OWmvDwxhVYnHoqlFp
rFNfTnytUJhCfrHwW+c7jIddejMDpT+gfBzjfMgF8T+qb2oQzzaxgI2CtTdEygD1
0vKf9CVt+HopCQoY6RZ//4HEcNKZxQ==
=67Gf
-----END PGP SIGNATURE-----

--owh577r42oekrxel--
