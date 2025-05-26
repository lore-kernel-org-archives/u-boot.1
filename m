Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C4FC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 09:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA3F082D34;
	Mon, 26 May 2025 11:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D1H/pl5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1418982D43; Mon, 26 May 2025 11:18:02 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B989D82CED
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C022EA4E8DE;
 Mon, 26 May 2025 09:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240CBC4CEE7;
 Mon, 26 May 2025 09:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748251078;
 bh=1bVYFWZf5bCd7xdNV5X6RU061fQ2CmUsLLowXS7vTFs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D1H/pl5dfNN9prt+xqJJUC8GPa/zh3Pz8T+u/kNlmJ4a5XD2C38PgMHkaC7fIZU21
 vEN99R5UHbBk0gbvpwcO48QYTZSXKVqlAzcNcuwiVvMcWb0pGLwqBO3IAZUXd0LJRz
 /4oGy/IvUM8CUmNomEtCmiupB1QtuWomTZTWciwHP6ZYTNipg+koBnzRgDN0I/NW9f
 F7wUjg2uLE1Pd+iHDcWJmRP423Op4OXp0Bi3+FcsjKZMNjQY1zumColXWnPwj6Lt8q
 3Tny2xTxSZ89P1PMPiIsm9OjKZur1sMY8pt2ecKRGFE3U6yJ5Z5x4GD5vsyf/Y4rBU
 Z5ncoClo9iEAA==
Date: Mon, 26 May 2025 10:17:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Yao Zi <ziyao@disroot.org>, Tom Rini <trini@konsulko.com>,
 Leo Liang <ycliang@andestech.com>, u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20250526-disband-cover-cdc6567452f2@spud>
References: <aC2hyzxwKzO4k1im@swlinux02>
 <174785279069.2062062.17616710293064147131.b4-ty@konsulko.com>
 <20250522-eradicate-clip-538f48710ad7@spud>
 <aC9TmaY7w2PL8lbn@pie.lan>
 <CAN37VV4y58GeqbviFaJDCr1vqLc5tKaTcBLg4_PmeHF-As6tAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PHAd/PYnbgnvqgvs"
Content-Disposition: inline
In-Reply-To: <CAN37VV4y58GeqbviFaJDCr1vqLc5tKaTcBLg4_PmeHF-As6tAw@mail.gmail.com>
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


--PHAd/PYnbgnvqgvs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 09:02:46AM +0530, Mayuresh Chitale wrote:
> On Thu, May 22, 2025 at 10:11=E2=80=AFPM Yao Zi <ziyao@disroot.org> wrote:
> >
> > On Thu, May 22, 2025 at 12:28:18PM +0100, Conor Dooley wrote:
> > > On Wed, May 21, 2025 at 12:39:50PM -0600, Tom Rini wrote:
> > > > On Wed, 21 May 2025 17:50:03 +0800, Leo Liang wrote:

> > > This PR seems to have made my CI blow up, and I'm not entirely sure if
> > > that's something intentional or not. I've not yet bisected, but since
> > > the error is "Image arch not compatible with host arch", I can only
> > > imagine the patch in question is:
> > > | Subject: [PATCH v2 1/3] riscv: image: Add new image type for RV64
> > > | Date: Fri,  4 Apr 2025 14:48:55 +0000       [thread overview]
> > > | Message-ID: <20250404144859.112313-2-mchitale@ventanamicro.com> (ra=
w)
> > > | In-Reply-To: <20250404144859.112313-1-mchitale@ventanamicro.com>
> > > |
> > > | Similar to ARM and X86, introduce a new image type which allows u-b=
oot
> > > | to distinguish between images built for 32-bit vs 64-bit Risc-V CPU=
s.
> > > |
> > > | Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > > | Reviewed-by: Maxim Moskalets <maximmosk4@gmail.com>
> > > | ---
> > > |  boot/image.c    | 3 ++-
> > > |  include/image.h | 3 ++-
> > > |  2 files changed, 4 insertions(+), 2 deletions(-)
> > > |
> > > | diff --git a/boot/image.c b/boot/image.c
> > > | index 139c5bd035a..45299a7dc33 100644
> > > | --- a/boot/image.c
> > > | +++ b/boot/image.c
> > > | @@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[] =3D {
> > > |     {       IH_ARCH_ARC,            "arc",          "ARC",         =
 },
> > > |     {       IH_ARCH_X86_64,         "x86_64",       "AMD x86_64",  =
 },
> > > |     {       IH_ARCH_XTENSA,         "xtensa",       "Xtensa",      =
 },
> > > | -   {       IH_ARCH_RISCV,          "riscv",        "RISC-V",      =
 },
> > > | +   {       IH_ARCH_RISCV,          "riscv",        "RISC-V 32 Bit"=
,},
> > > | +   {       IH_ARCH_RISCV64,        "riscv64",      "RISC-V 64 Bit"=
,},
> > > |     {       -1,                     "",             "",            =
 },
> > > |  };
> > > |
> > > | diff --git a/include/image.h b/include/image.h
> > > | index 07912606f33..411bfcd0877 100644
> > > | --- a/include/image.h
> > > | +++ b/include/image.h
> > > | @@ -138,7 +138,8 @@ enum {
> > > |     IH_ARCH_ARC,                    /* Synopsys DesignWare ARC */
> > > |     IH_ARCH_X86_64,                 /* AMD x86_64, Intel and Via */
> > > |     IH_ARCH_XTENSA,                 /* Xtensa       */
> > > | -   IH_ARCH_RISCV,                  /* RISC-V */
> > > | +   IH_ARCH_RISCV,                  /* RISC-V 32 bit*/
> > > | +   IH_ARCH_RISCV64,                /* RISC-V 64 bit*/
> > > |
> > > |     IH_ARCH_COUNT,
> > > |  };
> > > | --
> > > | 2.43.0
> > > |
> > > since it is changing the existing "riscv" image type to be the 32-bit
> > > image and requiring the new entry for 64-bit. My CI job uses the syst=
em
> > > mkimage to create the image that U-Boot is loading, so it doesn't know
> > > about the new define etc. Maybe it's not considered a problem if a new
> > > U-Boot cannot boot an old image, but the comment above the enum reads:
> > > |/*
> > > | * CPU Architecture Codes (supported by Linux)
> > > | *
> > > | * The following are exposed to uImage header.
> > > | * New IDs *MUST* be appended at the end of the list and *NEVER*
> > > | * inserted for backward compatibility.
> > > | */
> > > The overwhelming majority of existing supported boards in U-Boot are
> > > 64-bit platforms, and the 64-bit platforms are the ones that have been
> > > supported for longer, so my thought would be that the compatibility of
> > > 64-bit platforms should be prioritised over 32-bit? Or even add expli=
cit
> > > 32-bit and 64-bit entries and the existing one is a catch-all for
> > > compatibility reasons?
> >
> > I've mentioned entries with bitwidth explicitly specified in my previous
> > reply (and there hasn't been any response).
> >
> > > I'll consider IH_ARCH_RISCV32 a better idea, instead of implying 32bit
> > > when no suffix attached. We (and the Linux kernel) mix 32-bit and 64-=
bit
> > > variants of RISC-V together, thus it's hard to tell the exact bitwidth
> > > of "IH_ARCH_RISCV" without inspecting the code around. To me, it soun=
ds
> > > more like "RISC-V, but no bitwidth specified".
> > >
> > > It will be nice if we could avoid this kind of ambiguity.
> >
> > (referring my own reply[1])
> >
> > I'll second explicit 32-bit and 64-bit entries, and keeping
> > IH_ARCH_RISCV for compatibility consideration.
> >
> Are you suggesting something like this :
>=20
> { IH_ARCH_RISCV, "riscv", "RISC-V",},
> { IH_ARCH_RISCV32, "riscv32", "RISC-V 32 Bit",},
> { IH_ARCH_RISCV64, "riscv64", "RISC-V 64 Bit",},
>=20
> I tried to implement it like on ARM64. However the problem is that
> while on ARM64 it switches to aarch32 if it encounters an IH_ARCH_ARM
> kernel image, there is no equivalent mechanism for Risc-V yet.

But we don't even want that, since the current behaviour on a 64-bit
system is not to do anything 32-bit related, right? My 64-bit images
created with my system mkimage use IH_ARCH_RISCV.

> Another
> option could be to disable this check in the bootm flow for now until
> a similar mechanism is implemented on Risc-V.

Why not just allow IH_ARCH_RISCV to retain the current "dumb" behaviour
permanently, and only implement the strict checking when the explicit
width types are detected?


--PHAd/PYnbgnvqgvs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDQxvwAKCRB4tDGHoIJi
0pHIAP9MS9NWOliTeDztBPq4eXOvhbes/03WW9YRDeIlzNw47AD+PQOELnPnzoMp
L3uD1clibhmuN+HiF02MGGrE7LqNUQY=
=/IhB
-----END PGP SIGNATURE-----

--PHAd/PYnbgnvqgvs--
