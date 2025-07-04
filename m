Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41AEC83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 10:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4C0E806D8;
	Fri,  4 Jul 2025 12:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="h0IHtIgQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4DD38091A; Fri,  4 Jul 2025 12:42:11 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB245801BE
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 12:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=273a31b10=Conor.Dooley@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1751625729; x=1783161729;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Y/LEqnE6Wt061LjAoGPqdIF+82zAMRurQbHoZfZtPV4=;
 b=h0IHtIgQi/KlGr3pN+JHrvnVyB44OPxqobd00XEDX+IRlC1hmiNunPSc
 xJS5HKJF/+iEdUTv3cooOY4nLLVPYTjZztXBteOjvzRs0BYgqldw3N2Jq
 DLxN3BiTa/Hku32vxVjQY8ZptH1uYR4/jdiv/7N3JekHJFfQs4QUBxB0d
 uolsy7DYx0QJAXVqubjfX9VKy8ufWPCq+qOfJrJ77TgP49cnUzdM9A0tT
 2Ap7n8kESvhUaZ/YNbNn8F8ifbJWJgb9PkLlLA8Ac6+A4/ritM2LnasHM
 KPnViOrKKP5MMc3wHh5NCF3wDrOYVmGJn6tlRTiJoGTpwkQlGj+7vFF5g w==;
X-CSE-ConnectionGUID: WAdlLvIZTuic4wGP7RDhEg==
X-CSE-MsgGUID: 7jbIAo9ATvCagPDUGX1ciQ==
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
 d="asc'?scan'208";a="43584464"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 04 Jul 2025 03:42:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 4 Jul 2025 03:41:35 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44 via Frontend
 Transport; Fri, 4 Jul 2025 03:41:34 -0700
Date: Fri, 4 Jul 2025 11:40:21 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Leo Liang <ycliang@andestech.com>
CC: Conor Dooley <conor@kernel.org>, <u-boot@lists.denx.de>, Ivan Griffin
 <ivan.griffin@microchip.com>, Cyril Jean <cyril.jean@microchip.com>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Simon
 Glass" <sjg@chromium.org>, <Jamie.Gibbons@microchip.com>
Subject: Re: [PATCH v2] board: mpfs_icicle: implement
 board_fdt_blob_setup()/board_fit_config_name_match()
Message-ID: <20250704-mortified-defense-b100145ed06d@wendy>
References: <20250623115137.4017059-1-conor@kernel.org>
 <aGZW8cabMrd_76sw@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7itcylrr+DniMOEO"
Content-Disposition: inline
In-Reply-To: <aGZW8cabMrd_76sw@swlinux02>
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

--7itcylrr+DniMOEO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2025 at 06:09:53PM +0800, Leo Liang wrote:
> On Mon, Jun 23, 2025 at 12:51:36PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > The firmware on the Icicle is capable of providing a devicetree in a1 to
> > U-Boot, but until now the devicetree has been packaged in a "payload" [=
1]
> > alongside U-Boot (or other bootloaders/RTOSes) and appended to the imag=
e.
> > The address of this appended devicetree is placed in a1 by the firmware.
> > This meant that the mechanism used by OF_SEPARATE to locate the
> > devicetree at the end of the image would pick up the one provided by the
> > firmware when u-boot-nodtb.bin was in the payload and U-Boot's devicetr=
ee
> > when u-boot.bin was.
> >=20
> > The firmware is now going to be capable of providing a minimal devicetr=
ee
> > (quite cut down due to severe space constraints), but this devicetree is
> > linked into the firmware that runs out of the L2 rather than at the end
> > of the U-Boot image.
> >=20
> > Implement board_fdt_blob_setup() so that this devicetree can be
> > optionally used, and the devicetree provided in the "payload" can be
> > used without relying on "happening" to implement the same strategy as
> > OF_SEPARATE expects in combination with u-boot-nodtb.bin.
> > Unlike other RISC-V boards, the firmware provided devicetree is only
> > used when OF_BOARD is set, so that the almost certainly more complete
> > devicetree in U-Boot will be used unless explicitly requested otherwise.
> >=20
> > Implement board_fit_config_name_match(), so that, using the firmware
> > provided cut-down/minimal dtb, U-Boot can select one of several
> > devicetrees when MULTI_DTB_FIT is enabled.
> >=20
> > Enabling both MULTI_DTB_FIT and OF_BOARD will lead to a conflict
> > between the two options, with the latter taking priority due to
> > board_fdt_blob_setup() being executed before board_fit_config_name_matc=
h(),
> > which causes gd->fdt_blob to be overwritten with a pointer to the
> > minimal devicetree rather than the location of the fit image containing
> > the multiple dtbs. Let MULTI_DTB_FIT take priority in this case, by
> > explicitly blocking the override when MULTI_DTB_FIT is enabled.
> >=20
> > Link: https://github.com/polarfire-soc/hart-software-services/blob/mast=
er/tools/hss-payload-generator/README.md [1]
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >=20
> > v2:
> > - implement MULTI_DTB_FIT too
> >=20
> > v1 was a year ago here:
> > https://lore.kernel.org/u-boot/20240625090806.1787287-2-conor.dooley@mi=
crochip.com/
> >=20
> > There was some discussion on that thread, but ultimately I didn't find
> > what was mentioned to be worth implementing. Heinrich suggested to me, I
> > guess on IRC or something since it's not in that thread, implementing
> > MULTI_DTB_FIT, which I have done. A lot of the reason for the patch when
> > I wrote it was speculative, but we have some actual users for OF_BOARD
> > now - hence the v2 after about a year's gap.
> >=20
> > CC: Ivan Griffin <ivan.griffin@microchip.com>
> > CC: Cyril Jean <cyril.jean@microchip.com>
> > CC: Tom Rini <trini@konsulko.com>
> > CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > CC: Simon Glass <sjg@chromium.org>
> > CC: Jamie.Gibbons@microchip.com
> > CC: u-boot@lists.denx.de
> > ---
> >  board/microchip/mpfs_icicle/mpfs_icicle.c | 63 +++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
>=20
> Acked-by: Leo Yu-Chi Liang <ycliang@andestech.com>

Hmm, I made a mistake in the MULTI_DTB_FIT portion of this, and the
strtok() is causing problems (I forgot about the modification in place,
and the testcases I had used didn't catch it). Have you sent this in a
PR yet? If you have, I'll send a fix otherwise a v3.

Cheers,
Conor.

--7itcylrr+DniMOEO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaGevlQAKCRB4tDGHoIJi
0mdJAPwL/Cw4okVKYysZ/hXcHkrdXY07MrAKjf40z//85eFCcgD/ZupsVU7BZMKV
apnCAE+z1JUUwoYFpCoc8jD1l2038wo=
=k7p6
-----END PGP SIGNATURE-----

--7itcylrr+DniMOEO--
