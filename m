Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D016CD1F9C5
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 19:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F34488770;
	Tue, 15 Oct 2024 21:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t4aTgh64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEB4B88916; Tue, 15 Oct 2024 21:16:12 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C7F788753
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 21:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-46040dadedfso59648051cf.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729019769; x=1729624569; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WCO7VLQp24/lnEVZbbk8YUMh3XUZCgoZaxBxiGnYnRI=;
 b=t4aTgh64bmmWfdJVitNZQtPiHuvsE343MiWjLBQcc7G0rqr+s95wDKt85SJi8L/OJc
 Rz+Ym0Pa7ZMJ/53jRP8aVWqWG3zjm353aDuefYsltggjS4LNLSzUx4ju81F0OI+Chr/i
 faNzJqVzoXckiJjz1hXTdRyAAsUy4YDN8iQTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729019769; x=1729624569;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WCO7VLQp24/lnEVZbbk8YUMh3XUZCgoZaxBxiGnYnRI=;
 b=hN1AxVHqk+KkzoAvhd84isQmG5atB2ghuH0lSVc+DajiqBW73CQop9ftHsRbI1kqqO
 8bJlb9gsgNcHqjspHxe2ReOF46YAD5pKa2NVn3B2/ZcafnRT0Ub0vg76RL7ul1/4V/gO
 d8qcp512KZy1Ocusc9FBNTUEcJG4/nvO+EePbG1iUzoE5qURjT/ul5VWf4hFHEBgbqbJ
 cjP+Ko7Xo3G40kIkJPTvf3J8NCnAeZe3YiaxhRP1yFEWuhzM+XbLXzoXn1wfdAaZLGOk
 SQih112hX5Vtm+TgluUw+DTU1YdnD6c6eN1LMuYDLh3+65OoHBwEA87mVOZI1Gtd/vdF
 +Ifw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDZ1TlqJTKsy8hdboIL3oswDsFdPmUPhukxt2yz1tEEk+X7O1X08eUu3qxy/fxCv5SY+e41rQ=@lists.denx.de
X-Gm-Message-State: AOJu0Ywf0vHCkrsBhgVl57YdG/LLr1AJ02hZUqgeiy4Kab+DMsuqBX1z
 v0HDRcNlYp/UFtF0qKP1LVOl+RoehNEi7VA+oa+3VC14t2YtNtqD/+YNOeyN8R4=
X-Google-Smtp-Source: AGHT+IHRm5Sif13ZBp5Cd5bjd8UzA8s0Rp0+IsqJUQnK076znTycsSKmnX1aQsw9aytlHcpMgs8Ovg==
X-Received: by 2002:a05:6214:3205:b0:6cb:d1a7:aa1c with SMTP id
 6a1803df08f44-6cc2b91989emr16524226d6.40.1729019769184; 
 Tue, 15 Oct 2024 12:16:09 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc229698fbsm9879726d6.126.2024.10.15.12.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 12:16:08 -0700 (PDT)
Date: Tue, 15 Oct 2024 13:16:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH v4 00/15] Make EFI memory allocations synchronous with LMB
Message-ID: <20241015191605.GS53053@bill-the-cat>
References: <20241015153717.401371-1-sughosh.ganu@linaro.org>
 <CAFLszThyzu=ADuijsLAamkhAfNGHE4WtssFwSKRBfU25EytbLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6ioaErXYTh54J7e5"
Content-Disposition: inline
In-Reply-To: <CAFLszThyzu=ADuijsLAamkhAfNGHE4WtssFwSKRBfU25EytbLQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--6ioaErXYTh54J7e5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 12:45:59PM -0600, Simon Glass wrote:
> Hi,
>=20
> On Tue, 15 Oct 2024 at 09:37, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >
> >
> > This is part two of the series to have the EFI and LMB modules have a
> > coherent view of memory. Part one of this goal was to change the LMB
> > module to have a global and persistent memory map. Those patches have
> > now been applied to the next branch.
> >
> > These patches are changing the EFI memory allocation API's such that
> > they rely on the LMB module to allocate RAM memory. This fixes the
> > current scenario where the EFI memory module has no visibility of the
> > allocations/reservations made by the LMB module. One thing to note
> > here is that this is limited to the RAM memory region, i.e. the
> > EFI_CONVENTIONAL_MEMORY type. Any other memory type that is to be
> > added to the EFI memory map, still gets handled by the EFI memory
> > module.
> >
> >
> > Changes since V3:
> > * Add comments for the LMB_NOOVERWRITE and LMB_NONOTIFY flags
> > * Drop use of is_addr_in_ram() function
> > * Drop use of CONFIG_MEM_MAP_UPDATE_NOTIFY symbol to check if the
> >   notification needs to be sent.
> > * s/lmb_notify/lmb_should_notify
> > * Put a check for EFI_LOADER in the lmb_should_notify() function
> >
> >
> > Some test logs to highlight the issue that is being fixed by the series.
> >
> > Without patch series
> > --------------------
> >
> > lmb_dump_all:
> >  memory.count =3D 0x1
> >  memory[0]      [0x40000000-0x820fffff], 0x42100000 bytes flags: none
> >  reserved.count =3D 0x3
> >  reserved[0]    [0xe100000-0xeffffff], 0x00f00000 bytes flags: no-map
> >  reserved[1]    [0x42000000-0x421fffff], 0x00200000 bytes flags: no-map
> >  reserved[2]    [0x7f77da00-0x820fffff], 0x02982600 bytes flags: no-ove=
rwrite
> >
> >
> > =3D> efidebug memmap -- does not show regions allocated by lmb
> >
> > Missing TPMv2 device for EFI_TCG_PROTOCOL
> > Type             Start            End              Attributes
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > CONVENTIONAL     0000000040000000-000000007f751000 WB
> > BOOT DATA        000000007f751000-000000007f756000 WB
> > RUNTIME DATA     000000007f756000-000000007f757000 WB|RT
> > BOOT DATA        000000007f757000-000000007f758000 WB
> > RUNTIME DATA     000000007f758000-000000007f77a000 WB|RT
> > BOOT DATA        000000007f77a000-000000007f781000 WB
> > BOOT CODE        000000007f781000-00000000807b5000 WB
> > RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
> > BOOT CODE        00000000807b6000-00000000817c0000 WB
> > RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> > BOOT CODE        00000000817d0000-0000000082100000 WB
> > =3D>
> >
> >
> > Trying to allocate EFI memory with already allocated region succeeds(sh=
ould fail)
> > -----------------------------------------------------------------------=
----------
> >
> > =3D> efi_mem alloc 2000 42000000
> > Address returned 0x42000000
> >
> > =3D> efidebug memmap
> > Type             Start            End              Attributes
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > CONVENTIONAL     0000000040000000-0000000042000000 WB
> > BOOT DATA        0000000042000000-0000000042002000 WB
> > CONVENTIONAL     0000000042002000-000000007f751000 WB
> > BOOT DATA        000000007f751000-000000007f756000 WB
> > RUNTIME DATA     000000007f756000-000000007f757000 WB|RT
> > BOOT DATA        000000007f757000-000000007f758000 WB
> > RUNTIME DATA     000000007f758000-000000007f77a000 WB|RT
> > BOOT DATA        000000007f77a000-000000007f781000 WB
> > BOOT CODE        000000007f781000-00000000807b5000 WB
> > RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
> > BOOT CODE        00000000807b6000-00000000817c0000 WB
> > RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> > BOOT CODE        00000000817d0000-0000000082100000 WB
> > =3D>
> >
> >
> > With patch series
> > -----------------
> >
> > lmb_dump_all:
> >  memory.count =3D 0x1
> >  memory[0]      [0x40000000-0x820fffff], 0x42100000 bytes flags: none
> >  reserved.count =3D 0x4
> >  reserved[0]    [0xe100000-0xeffffff], 0x00f00000 bytes flags: no-map
> >  reserved[1]    [0x42000000-0x421fffff], 0x00200000 bytes flags: no-map
> >  reserved[2]    [0x7f74f000-0x7f77dfff], 0x0002f000 bytes flags: no-not=
ify, no-overwrite
> >  reserved[3]    [0x7f77ea00-0x820fffff], 0x02981600 bytes flags: no-ove=
rwrite
> >
> >
> > =3D> efidebug memmap
> > Type             Start            End              Attributes
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BOOT DATA        000000000e100000-000000000f000000 WB
> > CONVENTIONAL     0000000040000000-0000000042000000 WB
> > BOOT DATA        0000000042000000-0000000042200000 WB
> > CONVENTIONAL     0000000042200000-000000007f74e000 WB
> > BOOT DATA        000000007f74e000-000000007f753000 WB
> > RUNTIME DATA     000000007f753000-000000007f754000 WB|RT
> > BOOT DATA        000000007f754000-000000007f755000 WB
> > RUNTIME DATA     000000007f755000-000000007f777000 WB|RT
> > BOOT DATA        000000007f777000-00000000807b6000 WB
> > RUNTIME DATA     00000000807b6000-00000000807b7000 WB|RT
> > BOOT DATA        00000000807b7000-00000000817c0000 WB
> > RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> > BOOT DATA        00000000817d0000-0000000082100000 WB
> >
> >
> > Trying to allocate EFI memory with already allocated region fails
> > -----------------------------------------------------------------
> >
> > =3D> efi_mem alloc 2000 42000000
> > efi_allocate_pages failed 800000000000000e
> > =3D>
> >
> > Trying to allocate EFI memory with non-allocated region succeeds
> > ----------------------------------------------------------------
> >
> > =3D> efi_mem alloc 2000 42200000
> > Address returned 0x42200000
> >
> > =3D> efidebug memmap
> > Type             Start            End              Attributes
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BOOT DATA        000000000e100000-000000000f000000 WB
> > CONVENTIONAL     0000000040000000-0000000042000000 WB
> > BOOT DATA        0000000042000000-0000000042202000 WB
> > CONVENTIONAL     0000000042202000-000000007f74d000 WB
> > BOOT DATA        000000007f74d000-000000007f752000 WB
> > RUNTIME DATA     000000007f752000-000000007f753000 WB|RT
> > BOOT DATA        000000007f753000-000000007f754000 WB
> > RUNTIME DATA     000000007f754000-000000007f776000 WB|RT
> > BOOT DATA        000000007f776000-00000000807b5000 WB
> > RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
> > BOOT DATA        00000000807b6000-00000000817c0000 WB
> > RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> > BOOT DATA        00000000817d0000-0000000082100000 WB
> > =3D>
> >
> > lmb_dump_all:
> >  memory.count =3D 0x1
> >  memory[0]      [0x40000000-0x820fffff], 0x42100000 bytes flags: none
> >  reserved.count =3D 0x5
> >  reserved[0]    [0xe100000-0xeffffff], 0x00f00000 bytes flags: no-map
> >  reserved[1]    [0x42000000-0x421fffff], 0x00200000 bytes flags: no-map
> >  reserved[2]    [0x42200000-0x42201fff], 0x00002000 bytes flags: no-not=
ify, no-overwrite
> >  reserved[3]    [0x7f74e000-0x7f77cfff], 0x0002f000 bytes flags: no-not=
ify, no-overwrite
> >  reserved[4]    [0x7f77da00-0x820fffff], 0x02982600 bytes flags: no-ove=
rwrite
> >
> >
> > Sughosh Ganu (15):
> >   lmb: add versions of the lmb API with flags
> >   lmb: add a flag to allow suppressing memory map change notification
> >   lmb: add and reserve memory above ram_top
> >   efi: memory: use the lmb API's for allocating and freeing memory
> >   lmb: notify of any changes to the LMB memory map
> >   efi_memory: do not add U-Boot memory to the memory map
> >   ti: k3: remove efi_add_known_memory() function definition
> >   stm32mp: remove efi_add_known_memory() function definition
> >   lmb: allow for boards to specify memory map
> >   layerscape: use the lmb API's to add RAM memory
> >   x86: e820: use the lmb API for adding RAM memory
> >   efi_memory: do not add RAM memory to the memory map
> >   lmb: remove call to efi_lmb_reserve()
> >   efi_memory: rename variable to highlight overlap with free memory
> >   lmb: replace the double-underscore with single-underscore for all
> >     functions
> >
> >  arch/arm/cpu/armv8/fsl-layerscape/cpu.c |   8 +-
> >  arch/arm/mach-k3/common.c               |  11 --
> >  arch/arm/mach-stm32mp/dram_init.c       |  11 --
> >  arch/x86/lib/e820.c                     |  47 +++--
> >  include/efi_loader.h                    |  27 ++-
> >  include/lmb.h                           |  63 ++++++
> >  lib/Kconfig                             |  19 ++
> >  lib/efi_loader/Kconfig                  |   1 +
> >  lib/efi_loader/efi_memory.c             | 217 ++++++---------------
> >  lib/lmb.c                               | 242 ++++++++++++++++++------
> >  10 files changed, 389 insertions(+), 257 deletions(-)
>=20
> I have stated my objections and won't repeat them here. With -master
> currently broken for EFI, and many of the patches in this series being
> required even with my view of the world, I think the best thing is to
> apply this series now, and move on.

Thank you, Simon, for saying this. I will be applying this shortly.

--=20
Tom

--6ioaErXYTh54J7e5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcOv20ACgkQFHw5/5Y0
tywxnwv9H3wxrCpFVfvGhd08dovaAIu2Vg0RAjiP7+IDmP6X4S+xruNXFHWs19Kc
gUq16QSvQTgeQeA5/Ys7IlnXAti6mmwqZqaCbzix67leIy+uK2CsFRmRlIaX0wQ1
GeNzdf6vwBif3sCSyAgjCaJ/pCfCSfsmexI93JBD902a9MgAKaxJ50vJTKf6JlZG
5KwORVJiRwQf7j5z6Q6fGv6URkm0C6hntlBUhUDwmCueo63j2gKBNTFF/rDUPbVC
MEcGEcWsWPLTZL0w2R3Rv7rtf5/mBZHE/F59OPJBAEU4Xoi/IlnzRVST/Kq4QE2G
aRZnEbIvqcGZBVYZ+pJ9ypHNNIzIXM0q8zmtmyFvApzzdUHfXNuevQMoGeu3a3g6
7vARXI+QEjDyDnVrPf6dDk736YHO9rxtdu8GQcwwJ5qsFNvy0JNn3UNc1uVOZFlr
M0XPyAv4lE3/gC94i/h53/CrF7XSJG/IIuX97PkOEsuBO2wnwLrns0kXTJp/bbWI
eGXh6/FP
=RITC
-----END PGP SIGNATURE-----

--6ioaErXYTh54J7e5--
