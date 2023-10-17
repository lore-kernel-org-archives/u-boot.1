Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02B6CDB482
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 08:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF0A986C6E;
	Tue, 17 Oct 2023 10:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B07AE86C6E; Tue, 17 Oct 2023 10:17:39 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 11A3D86C66
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 10:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,231,1694703600"; 
 d="asc'?scan'208";a="179556213"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 17 Oct 2023 17:17:33 +0900
Received: from unknown (unknown [10.226.93.55])
 by relmlir5.idc.renesas.com (Postfix) with SMTP id 87CC0400294E;
 Tue, 17 Oct 2023 17:17:32 +0900 (JST)
Date: Tue, 17 Oct 2023 09:17:31 +0100
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Ignatius Rivaldi <minecraft2048@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Understanding how .config for uboot is generated in buildroot
Message-ID: <20231017081731.2u7qdmvj4a6bd724@GBR-5CG2373LKG.adwin.renesas.com>
References: <CAJ1CVWj3zLjK=tJr=T73JzOyNbJgMjrPdchsxVk0bMsAPQ7d8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oksudiuhfvpwzoy5"
Content-Disposition: inline
In-Reply-To: <CAJ1CVWj3zLjK=tJr=T73JzOyNbJgMjrPdchsxVk0bMsAPQ7d8w@mail.gmail.com>
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


--oksudiuhfvpwzoy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 04:35:20PM +1100, Ignatius Rivaldi wrote:
> Hi all,
>=20
> When I edit the config file in BR2_TARGET_UBOOT_CUSTOM_CONFIG_FILE in a
> buildroot recipe, how does the config statements from that file got
> converted into .config file in u-boot?
>=20
> The background is that we're using a custom buildroot config file at here:
> https://github.com/kubos/kubos-linux-build/tree/master to build u-boot for
> a space grade computer. When I added a new config statement
> (CONFIG_SD_SWITCH=3Dy) in the BR2_TARGET_UBOOT_CUSTOM_CONFIG_FILE, it doe=
sn't
> write the config statement to the .config file in the uboot build repo.
>=20
>  Unfortunately the company that owns that has been acquired several times
> and all the engineers there already left, so I can't just ask them

You're probably better off asking this on the buildroot mailing list.
See https://lists.buildroot.org/mailman/listinfo/buildroot.

Best regards,
Paul

--oksudiuhfvpwzoy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZS5DEAAKCRDbaV4Vf/JG
vc+iAP4n4VrstZSZ+76irv+KNTxbBMdmnkp8RQ+9lEHJUmo+ogEAjX6UAfYMgSsh
UChhFtKavN4qRvsXmaFD5cLzTvSrWgY=
=YIxy
-----END PGP SIGNATURE-----

--oksudiuhfvpwzoy5--
