Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278CCC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 14:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC1B88365;
	Tue, 23 Apr 2024 16:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X8HWCa0s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24FFE88399; Tue, 23 Apr 2024 16:23:59 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E189888360
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 16:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9C0A2614C8;
 Tue, 23 Apr 2024 14:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F344C116B1;
 Tue, 23 Apr 2024 14:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713882235;
 bh=b3BvabnVga0RJdXaDagkDnNpXHg6hUln2gdx0/anPvk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X8HWCa0sRcr3OdGgW6FeZf9tQv0w707nYqJ/kopQ7Sle7ZncclmzygvaQN+bZK8fh
 YL+zSFHWItMTa2Or72bhk4M64YPfITDNpRczA+NDqnKlVBdRboKP/Xeyp74Cg9GUzP
 nU0vC5Yr5ozYBz7r3h5mWoXptgCxM1B3zpKTPM20krg4QmU6U3eG9+hzXf8EHH+Eov
 duRQYEwWVnl1MtKxQe0FQNrN0YAobFgIPS/zP7C+hoKw50ahCnr2JyBGjZqqQSBIu4
 TRKDkBYssP+JdngBECF3Ud9Jh/6du/mEDxJ7V9n9jY1bOD32fVKCA6uEj6wKlUIfU3
 AFxc11ZXA2hRQ==
Date: Tue, 23 Apr 2024 15:23:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Leo Liang <ycliang@andestech.com>, u-boot@lists.denx.de,
 Andrew Jones <ajones@ventanamicro.com>
Subject: Re: RISC-V u-boot unable to boot QEMU using '-cpu max'
Message-ID: <20240423-unawake-trinity-cededc821014@spud>
References: <bed7e137-4613-4153-babc-3b8b7c911151@ventanamicro.com>
 <ZidIcgEPSb_vDQw7@swlinux02>
 <20240423-enzyme-book-1907217f891b@wendy>
 <0d320487-04d4-4be9-a885-854dadf04be7@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="R7BDuaBOGbAe9IDB"
Content-Disposition: inline
In-Reply-To: <0d320487-04d4-4be9-a885-854dadf04be7@ventanamicro.com>
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


--R7BDuaBOGbAe9IDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 09:52:06AM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 4/23/24 09:41, Conor Dooley wrote:
> > On Tue, Apr 23, 2024 at 01:34:42PM +0800, Leo Liang wrote:
> > > On Mon, Apr 22, 2024 at 04:43:59PM -0300, Daniel Henrique Barboza wro=
te:
> > > > [EXTERNAL MAIL]
> > > >=20
> > > > Hi,
> > > >=20
> > > > In QEMU we have a 'max' type CPU that implements (almost) all exten=
sions that QEMU
> > > > is able to emulate. Recently, in QEMU commit 249e0905d05, we bumped=
 the extensions
> > > > for this CPU.
> > > >=20
> > > > And after this commit this CPU is now unable to boot a guest using =
upstream
> > > > u-boot. Here's the error being thrown:
> > > >=20
> > > > qemu-system-riscv64 \
> > > >          -machine virt -nographic -m 8G -smp 8 \
> > > >          -cpu max -kernel uboot.elf (...)
> > > > (...)
> > > >=20
> > > > initcall sequence 000000008027c3e8 failed at call 000000008021259e =
(err=3D-28)
> > > > ### ERROR ### Please RESET the board ###
> > > >=20
> > > >=20
> > > > I can get the guest to boot if I disable the following extensions f=
rom the 'max' CPU:
> > > >=20
> > > >   -cpu max,zfbfmin=3Dfalse,zvfbfmin=3Dfalse,zvfbfwma=3Dfalse
> > > >=20
> > > > Due to QEMU extension dependencies I'm not able to disable these in=
dividually. What I can
> > > > say is that u-boot isn't playing ball to at least one of them.
> > > >=20
> > > > Is this an u-boot bug? Up to this point I was assuming that u-boot =
would silently ignore
> > > > hart extensions that it doesn't support.
> > >=20
> > > Hi Daniel,
> > >=20
> > > Which u-boot version are you using?
> > >=20
> > > I think this issue is fixed by the following patch set sent by Conor.
> > >=20
> > > 	f39b1b77d8 riscv: support extension probing using riscv, isa-extensi=
ons
> > > 	b90edde701 riscv: don't read riscv, isa in the riscv cpu's get_desc()
> > >=20
> > > I've tested and can reproduce the issue you mentioned if these two pa=
tches are reverted.
> > >=20
> > > Could you try with the lastest u-boot master branch again?
> > >=20
> > >=20
> > > For reference, my testing commands are as follows:
> > > 1. cd ${u-boot} && make qemu-riscv64_defconfig && make -j`nproc`
> > > 2. ./${qemu}/build/qemu-system-riscv64 -nographic -machine virt -cpu =
max -bios u-boot.bin -m 8G -smp 8
> > >=20
> > > - u-boot branch (commit): master (38ea74d6d5c0 "Prepare v2024.07-rc1")
> > > - qemu branch (commit): master (62dbe54c24db "Update version for v9.0=
=2E0-rc4 release")
> >=20
> > I'll go take a look at this, it's possible that my patches only hide the
> > problem due to the new property being prioritised.
>=20
>=20
> Don't bother. I just checked with most recent u-boot master and I can't r=
eproduce the
> problem, as Leo said.

My "fear" was that new QEMU + new U-Boot meant that the
riscv,isa-extensions codepath was in use and there was something lurking in
the riscv,isa parsing which had a problem. Fortunately, I think that's
not the case, as the fix seems to be b90edde701 "riscv: don't read riscv,isa
in the riscv cpu's get_desc()" rather than f39b1b77d8 "riscv: support
extension probing using riscv, isa-extensions".

I am, however, not going to look into why exactly it was failing before,
I'm satisfied once the riscv,isa parsing isn't broken in master.

>=20
> I apologize for the noise. I failed to fetch the latest upstream and do a=
 last
> test before posting it here.
>=20
> We were discussing here and there about disabling these extensions in the=
 'max'
> CPU in QEMU if u-boot wasn't able to handle them. I'm happy to see that u=
-boot
> is now able to do so and we can keep the 'max' CPU as is.
>=20
>=20
> Thanks for the help,
>=20
> Daniel
>=20

--R7BDuaBOGbAe9IDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZifEdgAKCRB4tDGHoIJi
0m9tAP4ij/hv6rtmlGjDPRom+24wyrJrgorKUb9sWl3mUmUIrwD+MHiN3JdRUgrM
4K/5vMovazisCDekmWEjiBJOCav9QAw=
=cZpW
-----END PGP SIGNATURE-----

--R7BDuaBOGbAe9IDB--
