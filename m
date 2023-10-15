Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564E4CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 18:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD7608656E;
	Sun, 15 Oct 2023 20:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A6B78657B; Sun, 15 Oct 2023 20:41:06 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id D5E198652F
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 20:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,226,1694703600"; 
 d="asc'?scan'208";a="179317584"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 16 Oct 2023 03:40:55 +0900
Received: from unknown (unknown [10.226.92.23])
 by relmlir5.idc.renesas.com (Postfix) with SMTP id A893C4003FC1;
 Mon, 16 Oct 2023 03:40:53 +0900 (JST)
Date: Sun, 15 Oct 2023 19:40:52 +0100
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] mmc: sh_sdhi: Drop unused driver
Message-ID: <20231015184052.ujdmqc47p5xizq3h@GBR-5CG2373LKG.adwin.renesas.com>
References: <20231014212739.92483-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a3i34spln46yfhxa"
Content-Disposition: inline
In-Reply-To: <20231014212739.92483-1-marek.vasut+renesas@mailbox.org>
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


--a3i34spln46yfhxa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 14, 2023 at 11:27:24PM +0200, Marek Vasut wrote:
> This driver is long superseded by renesas-sdhi.c and unused.
> Drop the driver.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Paul Barker <paul.barker.ct@bp.renesas.com>

--a3i34spln46yfhxa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZSwyJgAKCRDbaV4Vf/JG
vUsRAQCuVlh4CP23hJYM0FhYtC3E5EIFo8UfbDh3oW6rCec9MAEAvmBXywRP1a4n
5NIy+8xY6v8X/B/H/wjqRoRpgOfFzAk=
=i4xQ
-----END PGP SIGNATURE-----

--a3i34spln46yfhxa--
