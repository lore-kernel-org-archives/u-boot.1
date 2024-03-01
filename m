Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D21C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 13:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEC2687DB1;
	Fri,  1 Mar 2024 14:33:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="P40GbJ3n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A05A87D9C; Fri,  1 Mar 2024 14:33:54 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0B587DB1
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 14:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Conor.Dooley@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1709300030; x=1740836030;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=rwaWdq22D1D08vcaLRupAJJFGR+FLw5VOQ8RDWQPokU=;
 b=P40GbJ3nkObNMwxfwC51fCJtUUEim6VvPNkAOb5VrN7xTMVLnM+RClfd
 53HOBZQSpsfVtL7IvomNwy4faAA3tLTTBu3PTr5geFnNosDVQeP2LFAFf
 csY6939CC6IW9UZglyjhXgo1fp6bFOtw3VF+tEcXDtwx+X0CKEtiS3dCT
 Ubjy9CTEh8usdCbbPIXpwL+dJJEz3XLkkhFRBOvLKrxjAuFI0rwqCNlLp
 I6K7ZrS/zTTny6xSJq9Pr3KVbnTqa4y84D0j+F3thRvWHPSBu/WgsS2SD
 n7ZRe82XP75S3nULfcQwSSErP8VobNGQylhRuU0Un0WDGAsd1kdk4MOlg Q==;
X-CSE-ConnectionGUID: ISGyRnTiQ9aBhAgLfUzybA==
X-CSE-MsgGUID: L3ID/KuDQcKqmiHzqCbh7Q==
X-IronPort-AV: E=Sophos;i="6.06,196,1705388400"; 
 d="asc'?scan'208";a="17603279"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Mar 2024 06:33:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 06:33:38 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Mar 2024 06:33:36 -0700
Date: Fri, 1 Mar 2024 13:32:53 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
CC: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, Rob Herring
 <robh@kernel.org>, <u-boot@lists.denx.de>, Stefano Babic <sbabic@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Anatolij Gustschin
 <agust@denx.de>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
Message-ID: <20240301-unstuffed-sixtyfold-0a875a031043@wendy>
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
 <47c12ca3-ea7c-4097-90b5-0333c74b05aa@moroto.mountain>
 <20240228131029.GM3040305@bill-the-cat>
 <CAFA6WYN4sCk9Q66i_n+aXxRkGEbh66dh+Sr_C5SbioQ_s5BBbQ@mail.gmail.com>
 <20240228152034.GN3040305@bill-the-cat>
 <CAFA6WYMkdjE6Vrd2_fV_6Rzj8MOiPhO4EJ4kkik1_9vQnhzMqQ@mail.gmail.com>
 <20240229134242.GR3040305@bill-the-cat>
 <20240229140140.GS3040305@bill-the-cat>
 <CAFA6WYPkSd=roYiZrK-9oKOse+zTsbtBj8mrgV=HHFVHtCwHGg@mail.gmail.com>
 <3f6e7fef-b1ee-4c1a-9ca6-fad4959631b3@armadeus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jUbsZ8zn4IPGoYG7"
Content-Disposition: inline
In-Reply-To: <3f6e7fef-b1ee-4c1a-9ca6-fad4959631b3@armadeus.com>
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

--jUbsZ8zn4IPGoYG7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

Replying here because this is only version of this in my inbox atm.

On Fri, Mar 01, 2024 at 10:17:35AM +0100, S=E9bastien Szymanski wrote:
> On 3/1/24 07:02, Sumit Garg wrote:
> > On Thu, 29 Feb 2024 at 19:31, Tom Rini <trini@konsulko.com> wrote:
> > > On Thu, Feb 29, 2024 at 08:42:42AM -0500, Tom Rini wrote:
> > > > On Thu, Feb 29, 2024 at 11:17:28AM +0530, Sumit Garg wrote:
> > > > > On Wed, 28 Feb 2024 at 20:50, Tom Rini <trini@konsulko.com> wrote:
> > > > > > On Wed, Feb 28, 2024 at 07:44:42PM +0530, Sumit Garg wrote:
> > > > > > > On Wed, 28 Feb 2024 at 18:40, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >=20
> > > > > > > > On Wed, Feb 28, 2024 at 10:09:13AM +0300, Dan Carpenter wro=
te:
> > > > > > > > > On Tue, Feb 27, 2024 at 04:40:01PM +0100, S=E9bastien Szy=
manski wrote:
> > > > > > > > > > Commit 5d7a95f49999 ("imx6ul/imx6ull: synchronise devic=
e trees with
> > > > > > > > > > linux") removed the display timings from the board devi=
ce tree whereas
> > > > > > > > > > they are still needed by the mxsfb driver.
> > > > > > > > > > Add the timings back (the correct ones) in the
> > > > > > > > > > imx6ul-opos6uldev-u-boot.dtsi file and remove them from=
 the
> > > > > > > > > > opos6uldev.env file.
> > > > > > > > > >=20
> > > > > > > > > > Update the opos6uldev_defconfig file so that the LCD tu=
rns on at boot.
> > > > > > > > > >=20
> > > > > > > > > > Fixes: 5d7a95f49999 ("imx6ul/imx6ull: synchronise devic=
e trees with linux")
> > > > > > > > > > Signed-off-by: S=E9bastien Szymanski <sebastien.szymans=
ki@armadeus.com>
> > > > > > > > >=20
> > > > > > > > > Huh.  This is the commit that did that upstream.
> > > > > > > > >=20
> > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git/commit/?id=3Dd9aa4d4fca67823838fe9861456201430c545e69
> > > > > > > > >=20
> > > > > > > > > It's interesting how the timings in linux were always sli=
ghtly different
> > > > > > > > > from in u-boot.
> > > > > > > >=20
> > > > > > > > Thanks for tracking that down, Dan. I'm adding in Sumit and=
 Rob here
> > > > > > > > because this is a recent (rather than ancient) example of o=
ne of the
> > > > > > > > concerns about OF_UPSTREAM.
> > > > > > >=20
> > > > > > > I rather think about this as an opportunity to improve with
> > > > > > > OF_UPSTREAM. We can feed these kinds of DT ABI breakages to
> > > > > > > corresponding Linux kernel sub-arch maintainers. Especially o=
nce we
> > > > > > > move to OF_UPSTREAM and a sub-arch maintainer profile in Linu=
x kernel
> > > > > > > to keep them aware that U-Boot should be considered too.
> > > > > >=20
> > > > > > Yes, a more extensive check around when removing information fr=
om dts
> > > > > > files would be good.

Whenever people remove things from bindings (or from being required) we
do ask them "have you checked that there's no users for this outside of
linux" - but for me at least I don't apply that scrutiny for most (read
arm{,64}) devicetrees. There's just too much volume if I went asking
those questions on every removal, it's up to the platform maintainers to
keep an eye on that.

That said, modifications to a devicetree are fixable with a revert,
while modifications to a binding may not really be fixable in a way that
isn't disruptive for some user, so I think that I am spending my time
wisely.

> > > > > > > > I think the commit in question can be
> > > > > > > > summarized as "remove a bunch of explicit HW information be=
cause there's
> > > > > > > > now a Linux Kernel driver that determines that dynamically"=
=2E What do we
> > > > > > > > do next? The old information is in a presumably valid bindi=
ng still, can
> > > > > > > > we just put it back and comment that consumers outside of L=
inux use this
> > > > > > > > still so it's not removed again later? Or am I just missing=
 where we can
> > > > > > > > instead get this information from the DT still and not need=
 to come up
> > > > > > > > with a new driver and subsystems?

I don't think this is an accurate summary. The "explict hw information"
was never allowed for an imx6ul, only for some older devices, so "the
old information is in a presumably valid binding" is not accurate.
See 7b920aae917d ("dt-bindings: mxsfb: Add new bindings for the MXSFB
driver") for when doing things that way was deprecated. The imx6ul was
only documented several years after it was introduced (so likely several
years after it started incorrectly using that binding).

Seeing that, I am not sure that I would even question the kernel patch
cited above, the change was done for binding compliance and I would not
be inclined to think twice, given the bindings are the ABI.

Cheers,
Conor.

--jUbsZ8zn4IPGoYG7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeHZBQAKCRB4tDGHoIJi
0uK/APsHFL51GX4crJQ1oL/Jq5CtQYFSy8euf4w7gddMX4VC/gEA8vIrJJ4wBTf+
46PPILKko3DhS8e5hlexIpx3gCP4qgg=
=nHw/
-----END PGP SIGNATURE-----

--jUbsZ8zn4IPGoYG7--
