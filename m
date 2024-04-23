Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C58C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 12:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08203885A5;
	Tue, 23 Apr 2024 14:42:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="aoNyI6rQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A40FA885A6; Tue, 23 Apr 2024 14:42:46 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 467D9884EC
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 14:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=836a311f1=Conor.Dooley@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1713876164; x=1745412164;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pETn2Ts3UkurndoAPghTE2CvU5dAax009FR1PCqoY7k=;
 b=aoNyI6rQJ7aIHVkij6kq96C1lPnwIScetOYTEURMyiK2hOdS1AChX3q9
 bZBWXxbwS9Eq7sC3s0AtEPf9U+5aKKGmlU+ZplwZwIyaKiw4njJCdM+Z5
 rVt720Q+6rt5+FergBBHvg0umqWDA27aQasicgFtU/wAbn2RUyoPr8YCq
 Jl1DrtR+rJorcZS47mr8JdRsUwumYieEnFinfJbKRrJwxkNSvxoo/uFuL
 M0fRyH8nxwTv9jf1IQGRMgBliRabRImmmoLSyzmcl5/a+VQgJU3hKwm6P
 Sie8iGtqCpvql4yxsRrOgCkQfV+/1l7qqJjQrFlNBpzwj/cWftmcbAQPr A==;
X-CSE-ConnectionGUID: FgCcA/FuTIquASkmbZMKMA==
X-CSE-MsgGUID: T4WDgxkQQjmKzziBDh/tfw==
X-IronPort-AV: E=Sophos;i="6.07,222,1708412400"; 
 d="asc'?scan'208";a="22251673"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Apr 2024 05:42:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 05:42:13 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 05:42:12 -0700
Date: Tue, 23 Apr 2024 13:41:56 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Leo Liang <ycliang@andestech.com>
CC: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 <u-boot@lists.denx.de>, Andrew Jones <ajones@ventanamicro.com>
Subject: Re: RISC-V u-boot unable to boot QEMU using '-cpu max'
Message-ID: <20240423-enzyme-book-1907217f891b@wendy>
References: <bed7e137-4613-4153-babc-3b8b7c911151@ventanamicro.com>
 <ZidIcgEPSb_vDQw7@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ioS+6aHcFVjLs5FU"
Content-Disposition: inline
In-Reply-To: <ZidIcgEPSb_vDQw7@swlinux02>
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

--ioS+6aHcFVjLs5FU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 01:34:42PM +0800, Leo Liang wrote:
> On Mon, Apr 22, 2024 at 04:43:59PM -0300, Daniel Henrique Barboza wrote:
> > [EXTERNAL MAIL]
> >=20
> > Hi,
> >=20
> > In QEMU we have a 'max' type CPU that implements (almost) all extension=
s that QEMU
> > is able to emulate. Recently, in QEMU commit 249e0905d05, we bumped the=
 extensions
> > for this CPU.
> >=20
> > And after this commit this CPU is now unable to boot a guest using upst=
ream
> > u-boot. Here's the error being thrown:
> >=20
> > qemu-system-riscv64 \
> >         -machine virt -nographic -m 8G -smp 8 \
> >         -cpu max -kernel uboot.elf (...)
> > (...)
> >=20
> > initcall sequence 000000008027c3e8 failed at call 000000008021259e (err=
=3D-28)
> > ### ERROR ### Please RESET the board ###
> >=20
> >=20
> > I can get the guest to boot if I disable the following extensions from =
the 'max' CPU:
> >=20
> >  -cpu max,zfbfmin=3Dfalse,zvfbfmin=3Dfalse,zvfbfwma=3Dfalse
> >=20
> > Due to QEMU extension dependencies I'm not able to disable these indivi=
dually. What I can
> > say is that u-boot isn't playing ball to at least one of them.
> >=20
> > Is this an u-boot bug? Up to this point I was assuming that u-boot woul=
d silently ignore
> > hart extensions that it doesn't support.
>=20
> Hi Daniel,
>=20
> Which u-boot version are you using?
>=20
> I think this issue is fixed by the following patch set sent by Conor.
>=20
> 	f39b1b77d8 riscv: support extension probing using riscv, isa-extensions
> 	b90edde701 riscv: don't read riscv, isa in the riscv cpu's get_desc()
>=20
> I've tested and can reproduce the issue you mentioned if these two patche=
s are reverted.
>=20
> Could you try with the lastest u-boot master branch again?
>=20
>=20
> For reference, my testing commands are as follows:
> 1. cd ${u-boot} && make qemu-riscv64_defconfig && make -j`nproc`
> 2. ./${qemu}/build/qemu-system-riscv64 -nographic -machine virt -cpu max =
-bios u-boot.bin -m 8G -smp 8
>=20
> - u-boot branch (commit): master (38ea74d6d5c0 "Prepare v2024.07-rc1")
> - qemu branch (commit): master (62dbe54c24db "Update version for v9.0.0-r=
c4 release")

I'll go take a look at this, it's possible that my patches only hide the
problem due to the new property being prioritised.

--ioS+6aHcFVjLs5FU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiesjAAKCRB4tDGHoIJi
0rLjAQCR2f1DNaEx3N0ilEHZu44OTF1CBdGCGW/QiT/SBiFDlwEA5C3o9a9InuU0
buJenevkgrXbml5lDfh71pugXQPUSAo=
=wd5i
-----END PGP SIGNATURE-----

--ioS+6aHcFVjLs5FU--
