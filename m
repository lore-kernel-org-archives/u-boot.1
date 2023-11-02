Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7B4C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 08:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A0FB87678;
	Thu,  2 Nov 2023 09:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DBDF87678; Thu,  2 Nov 2023 09:05:10 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id A10AC875CC
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 09:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,270,1694703600"; 
 d="asc'?scan'208";a="181529691"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 02 Nov 2023 17:05:03 +0900
Received: from unknown (unknown [10.226.93.54])
 by relmlir6.idc.renesas.com (Postfix) with SMTP id 9FF9441CEAFC;
 Thu,  2 Nov 2023 17:05:01 +0900 (JST)
Date: Thu, 2 Nov 2023 08:05:00 +0000
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Subject: Re: [PATCH 2/8] arm: mach-rmobile: Drop <common.h>
Message-ID: <20231102080406.beyq65joj6jprmeg@GBR-5CG2373LKG.adwin.renesas.com>
References: <20231101200600.119507-1-paul.barker.ct@bp.renesas.com>
 <20231101200600.119507-2-paul.barker.ct@bp.renesas.com>
 <TYCPR01MB11269318ABD0588D031AF46BF86A6A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="o6kjt2bhfthycqtz"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB11269318ABD0588D031AF46BF86A6A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
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


--o6kjt2bhfthycqtz
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6ezzxlomdth3thnf"
Content-Disposition: inline


--6ezzxlomdth3thnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 07:54:37AM +0000, Biju Das wrote:
> Hi Paul,
>=20
> Thanks for the patch.
>=20
> > Subject: [PATCH 2/8] arm: mach-rmobile: Drop <common.h>
> >=20
> > For most source files we can just drop <common.h>. We need to add an
> > include for <asm/u-boot.h> in a couple of places. Also sort the include
> > list in memmap-gen3.c while we're here.
>=20
> Why only sorting memmap-gen3.c? why not sorting all the files touching he=
re?

That was the only file where I needed to add a new include and it wasn't
already sorted.

Thanks,
Paul

--6ezzxlomdth3thnf--

--o6kjt2bhfthycqtz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZUNYLAAKCRDbaV4Vf/JG
vVq0AP921Z7yQsIVi85t9ZcnqWAZRulSqFTlj7Rc3rpaTnR69gD/bldrB+XmovVV
gWQmUd/KJdwG7uaaZLSbuo4vMYYnmQs=
=wD84
-----END PGP SIGNATURE-----

--o6kjt2bhfthycqtz--
