Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE796C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 19:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3753486452;
	Mon, 28 Aug 2023 21:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yovx5JZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC3A586456; Mon, 28 Aug 2023 21:56:38 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE9986430
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 21:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bc9811558cso2665247a34.0
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 12:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693252594; x=1693857394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0JtnZ4bZ+HyMIO/Jjc+cdMWeMKjI1cd9Dy0qQiJL+dw=;
 b=Yovx5JZPe+V7gtlvZhHesKFOkTJfvYoEKcUCNygoTj4jJ2Ln0956k9baHkb0E/lzOz
 WM5J7HbuZh3BsSjtcJtwC0i/fYIhr/Rrno1RuqmGjqLROfmszOxxAVFkhL+nI0joozjL
 GcM4/m9WQL94Iai5Re/rw6VKAXcBcUeJz2x9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693252594; x=1693857394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JtnZ4bZ+HyMIO/Jjc+cdMWeMKjI1cd9Dy0qQiJL+dw=;
 b=kGnYohELAELByITF3az7064wZTE2UXV6qOjEQuwmVYlrDQZIEpyZLYMkQGCCUVYB95
 PPGp7cHewAStmp6/Bo3lCdyPpSQFCNZ5y2VHBV7vmanow2ooOfFnEP1ptyZFPTAUBNM4
 tQEZ+NbFe321iRjQE1FKrivqfcpHJwOUou083rg1b0voP4X8EGxqhZg1LY2cwTKuahkH
 mDa1kthCFzmQmNOLATcUlsQ4y9iqBdLzqDDCGjSQMHrl+w0epsbvVCrO6BZFQ8SLYGQ+
 +Qc8U5cWDTe+dDkTbdDq7eDgcrZUYxBgCSrSzqNDjwukvb01ApBNcHM0hq+8oxu1q4sv
 afdg==
X-Gm-Message-State: AOJu0Yx7Hgkvj9Rr/MKmATv2KRNwO1+dJsCqXHoZBroXN0+KKSqgbklp
 DzVqQRu58F4Kid7bFeaSedjw6Q==
X-Google-Smtp-Source: AGHT+IEVAZ2lbWN9BWKY8oOK51IvdtFK5cC0YCkMuWPLxLCLrVaStwIOAp8tkm53wUSz1LiwfyyMDA==
X-Received: by 2002:a05:6359:6784:b0:139:c75f:63eb with SMTP id
 sq4-20020a056359678400b00139c75f63ebmr20997134rwb.21.1693252593770; 
 Mon, 28 Aug 2023 12:56:33 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c01a-9a8d-1e42-2ea4.res6.spectrum.com.
 [2603:6081:7b00:6400:c01a:9a8d:1e42:2ea4])
 by smtp.gmail.com with ESMTPSA id
 v184-20020a8185c1000000b005837fe8dbe8sm2338815ywf.8.2023.08.28.12.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 12:56:33 -0700 (PDT)
Date: Mon, 28 Aug 2023 15:56:31 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Andrew Scull <ascull@google.com>, u-boot@lists.denx.de,
 xypron.glpk@gmx.de, jonbottarini@google.com, seanga2@gmail.com
Subject: Re: [PATCH v3 00/13] Fuzzing and ASAN for sandbox
Message-ID: <20230828195631.GQ3953269@bill-the-cat>
References: <20220530100013.3753780-1-ascull@google.com>
 <CAPnjgZ3KJS2PDorQVQYw47Pymq6VM0iMe-HEZ=dSGYeE9w6r+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="udO9yiqSFyopvPIG"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3KJS2PDorQVQYw47Pymq6VM0iMe-HEZ=dSGYeE9w6r+Q@mail.gmail.com>
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


--udO9yiqSFyopvPIG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 10:20:02AM -0600, Simon Glass wrote:
> Hi Andrew,
>=20
> On Mon, 30 May 2022 at 04:00, Andrew Scull <ascull@google.com> wrote:
> >
> > This series introduces ASAN and a basic fuzzing infrastructure that
> > works with sandbox. The example fuzz test towards the end of the series
> > will find something pretty quickly. That something is fixed by the
> > series "virtio: Harden and test vring" that needs to be applied for the
> > final patch in this series.
> >
> > There is some refactoring to stop using '.' prefixed sections. ELF
> > defines sections with names that contain anything that isn't
> > alphanumeric or an underscore as being for system use which means
> > clang's ASAN instrumentation happily add redzones between the contained
> > objects. That's not what we want for things like linker lists where the
> > linker script has carefully placed the sections contiguously. By
> > renaming the sections, clang sees them as user sections and doesn't add
> > instrumentation.
> >
> > ASAN is left disabled by default as there are still some tests that it
> > triggers on and will need some more investigation to fix. It can be
> > enabled with CONFIG_ASAN or passing `-a ASAN` to buildman.
> >
> > I abandonded the previous attempts to refactor sandbox EFI and getopt
> > declaration as the changes resulted in problems out of the scope of this
> > CL. I haven't tried to understand what EFI on sandbox should look like,
> > but I have found that the linker list implementation is very brittle
> > when up against compiler optimisation since ef123c5253 started to use
> > static, zero-length arrays to mark the beginning and end of lists but
> > the compiler see this as something it can get rid of.
> >
> > From v1:
> >  - corrected handling of EFI symbols by sandbox linker script
> >  - per comments, some renaming and explaining
> >  - dropped RFC for dlmalloc ASAN instrumentation (work required to impr=
ove it)
> >  - added patch to reduce logging noise in fuzzer
> >
> > From v2:
> >  - remove sandbox EFI and getopt refactoring, they obstruct the series
> >  - resolve a couple more ASAN errors
> >  - fix LTO, xtensa and MIPS builds
> >  - add ASAN build targets for CI
> >
> > Andrew Scull (13):
> >   serial: sandbox: Fix buffer underflow in puts
> >   sandbox: Rename EFI runtime sections
> >   sandbox: Rename getopt sections
> >   linker_lists: Rename sections to remove . prefix
> >   sandbox: Add support for Address Sanitizer
> >   test/py: test_stackprotector: Disable for ASAN
> >   CI: Azure: Build with ASAN enabled
> >   fuzzing_engine: Add fuzzing engine uclass
> >   test: fuzz: Add framework for fuzzing
> >   sandbox: Decouple program entry from sandbox init
> >   sandbox: Add libfuzzer integration
> >   sandbox: Implement fuzzing engine driver
> >   fuzz: virtio: Add fuzzer for vring
> >
> >  .azure-pipelines.yml                          |  6 ++
> >  Kconfig                                       | 16 ++++
> >  arch/Kconfig                                  |  2 +
> >  arch/arc/cpu/u-boot.lds                       |  4 +-
> >  arch/arm/config.mk                            |  4 +-
> >  arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds   |  4 +-
> >  arch/arm/cpu/armv7/sunxi/u-boot-spl.lds       |  4 +-
> >  arch/arm/cpu/armv8/u-boot-spl.lds             |  4 +-
> >  arch/arm/cpu/armv8/u-boot.lds                 |  4 +-
> >  arch/arm/cpu/u-boot-spl.lds                   |  4 +-
> >  arch/arm/cpu/u-boot.lds                       |  6 +-
> >  arch/arm/mach-at91/arm926ejs/u-boot-spl.lds   |  2 +-
> >  arch/arm/mach-at91/armv7/u-boot-spl.lds       |  2 +-
> >  arch/arm/mach-omap2/u-boot-spl.lds            |  4 +-
> >  arch/arm/mach-orion5x/u-boot-spl.lds          |  4 +-
> >  arch/arm/mach-rockchip/u-boot-tpl-v8.lds      |  4 +-
> >  arch/arm/mach-zynq/u-boot-spl.lds             |  4 +-
> >  arch/arm/mach-zynq/u-boot.lds                 |  4 +-
> >  arch/m68k/cpu/u-boot.lds                      |  4 +-
> >  arch/microblaze/cpu/u-boot-spl.lds            |  4 +-
> >  arch/microblaze/cpu/u-boot.lds                |  4 +-
> >  arch/mips/config.mk                           |  2 +-
> >  arch/mips/cpu/u-boot-spl.lds                  |  4 +-
> >  arch/mips/cpu/u-boot.lds                      |  4 +-
> >  arch/nios2/cpu/u-boot.lds                     |  4 +-
> >  arch/powerpc/cpu/mpc83xx/u-boot.lds           |  4 +-
> >  arch/powerpc/cpu/mpc85xx/u-boot-spl.lds       |  4 +-
> >  arch/powerpc/cpu/mpc85xx/u-boot.lds           |  4 +-
> >  arch/riscv/cpu/u-boot-spl.lds                 |  4 +-
> >  arch/riscv/cpu/u-boot.lds                     |  4 +-
> >  arch/sandbox/config.mk                        | 21 ++++-
> >  arch/sandbox/cpu/os.c                         | 76 +++++++++++++++++
> >  arch/sandbox/cpu/start.c                      |  2 +-
> >  arch/sandbox/cpu/u-boot-spl.lds               | 10 +--
> >  arch/sandbox/cpu/u-boot.lds                   | 32 ++++----
> >  arch/sandbox/dts/test.dts                     |  4 +
> >  arch/sandbox/include/asm/fuzzing_engine.h     | 25 ++++++
> >  arch/sandbox/include/asm/getopt.h             |  2 +-
> >  arch/sandbox/include/asm/main.h               | 18 ++++
> >  arch/sandbox/include/asm/sections.h           |  4 +-
> >  arch/sandbox/lib/sections.c                   |  8 +-
> >  arch/sh/cpu/u-boot.lds                        |  4 +-
> >  arch/x86/cpu/u-boot-64.lds                    |  6 +-
> >  arch/x86/cpu/u-boot-spl.lds                   |  6 +-
> >  arch/x86/cpu/u-boot.lds                       |  6 +-
> >  arch/x86/lib/elf_ia32_efi.lds                 |  4 +-
> >  arch/x86/lib/elf_x86_64_efi.lds               |  4 +-
> >  arch/xtensa/cpu/u-boot.lds                    |  4 +-
> >  arch/xtensa/include/asm/ldscript.h            | 13 ++-
> >  board/compulab/cm_t335/u-boot.lds             |  4 +-
> >  board/cssi/MCR3000/u-boot.lds                 |  4 +-
> >  .../davinci/da8xxevm/u-boot-spl-da850evm.lds  |  2 +-
> >  board/qualcomm/dragonboard820c/u-boot.lds     |  4 +-
> >  board/samsung/common/exynos-uboot-spl.lds     |  4 +-
> >  board/synopsys/iot_devkit/u-boot.lds          |  4 +-
> >  board/ti/am335x/u-boot.lds                    |  4 +-
> >  board/vscom/baltos/u-boot.lds                 |  4 +-
> >  doc/api/linker_lists.rst                      | 22 ++---
> >  doc/develop/commands.rst                      |  4 +-
> >  doc/develop/driver-model/of-plat.rst          |  4 +-
> >  drivers/Kconfig                               |  2 +
> >  drivers/Makefile                              |  1 +
> >  drivers/fuzz/Kconfig                          | 17 ++++
> >  drivers/fuzz/Makefile                         |  8 ++
> >  drivers/fuzz/fuzzing_engine-uclass.c          | 28 +++++++
> >  drivers/fuzz/sandbox_fuzzing_engine.c         | 35 ++++++++
> >  drivers/serial/sandbox.c                      |  2 +-
> >  include/dm/uclass-id.h                        |  1 +
> >  include/fuzzing_engine.h                      | 51 ++++++++++++
> >  include/linker_lists.h                        | 18 ++--
> >  include/test/fuzz.h                           | 51 ++++++++++++
> >  test/Makefile                                 |  1 +
> >  test/fuzz/Makefile                            |  8 ++
> >  test/fuzz/cmd_fuzz.c                          | 82 +++++++++++++++++++
> >  test/fuzz/virtio.c                            | 72 ++++++++++++++++
> >  test/py/tests/test_stackprotector.py          |  1 +
> >  tools/mips-relocs.c                           |  9 +-
> >  77 files changed, 673 insertions(+), 151 deletions(-)
> >  create mode 100644 arch/sandbox/include/asm/fuzzing_engine.h
> >  create mode 100644 arch/sandbox/include/asm/main.h
> >  create mode 100644 drivers/fuzz/Kconfig
> >  create mode 100644 drivers/fuzz/Makefile
> >  create mode 100644 drivers/fuzz/fuzzing_engine-uclass.c
> >  create mode 100644 drivers/fuzz/sandbox_fuzzing_engine.c
> >  create mode 100644 include/fuzzing_engine.h
> >  create mode 100644 include/test/fuzz.h
> >  create mode 100644 test/fuzz/Makefile
> >  create mode 100644 test/fuzz/cmd_fuzz.c
> >  create mode 100644 test/fuzz/virtio.c
>=20
> Could you please add some documentation about this in doc/ ? I also
> wonder if we can make the fuzz test run in CI? Finally, can the azure
> stuff work in gitlab too?
>=20
> I am interested in using fuzzing to test a new 'Universal Payload'
> feature which basically converts data from a C struct to a devicetree
> and back.

Fuzzing fails on a number of tests, which is why I've moved it to just
run the version test here:
https://patchwork.ozlabs.org/project/uboot/patch/20230820173129.781985-2-tr=
ini@konsulko.com/

There's not much point in running it in GitLab too until we get the
errors fixed.

--=20
Tom

--udO9yiqSFyopvPIG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTs++cACgkQFHw5/5Y0
tywmrwv7BaW/FE52Xb5YUGeAhEVOIFgEHDo7V7JjziSh8wtyEHzqKuUUQeu9JMMw
XFc0zgabtCJP8iR1/5HisIa/Lsk5Z2qboAKwGBA+BitcfJXFNM6mxPoP39gvb6Jy
iNOVXhesPQo4rVd+wg1dGEEqZTg60Vs3+yqaooK3t8sAiXIt0lAapU0XILvM+7Th
Es4vdnRkgGFGSfywB80OTe+zUrE9+HrGu3/TlSxa42t6vgSdPLEdB48WmBSGNA1/
nakvhysqms4Qo1Q5sI+C6UtkJhnoOgiommeLHP+BUf5iptt02Otm1AU6EWVsY1Tw
XI1IPRgPqazxkK2dpCQLvG1WNdK/qeOJa9zSndNrzHcTlGvVqrkMUXLlMXa3VZ7p
MN6K+oSVriqMDucvjEByIVISkDnLbPlhhXFXuAHyBAXzRWlpOTYbUO+VBXj3fQry
YpGg50uLEVj88sqHx3SzWQ5hGHH1pkuz0210oTOZ/yPsh2SRdjAtQqWFIFOwJhGa
UjLrxsX9
=ZteO
-----END PGP SIGNATURE-----

--udO9yiqSFyopvPIG--
