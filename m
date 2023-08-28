Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52895C83F15
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 16:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 239018650B;
	Mon, 28 Aug 2023 18:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C929utj8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A26846D2; Mon, 28 Aug 2023 18:20:17 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6759C864A7
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 18:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-52bca2e8563so480698a12.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693239614; x=1693844414;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ys0aCGSYSWNpZXc91sHH/lBDtdAuY+XC0w4WVZwuujU=;
 b=C929utj8SoJvbc3hO0xfUcU9Tir2e1jVQtH+uHWBTyHU8TKxFLz95eiNeHw2MhiQ0O
 /7QMjCBtKwXcNvrcVpzEQ/Gu2ixyAahvWBW083Y1imjb5cQJZ1+VcZrapI2H9KGx5Shu
 w5dYMXCafRGMZO4r49ZX3jRQ8nEUZV46DuEEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693239614; x=1693844414;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ys0aCGSYSWNpZXc91sHH/lBDtdAuY+XC0w4WVZwuujU=;
 b=ePyim1tXj1g2XGx7tuqxUnIEhj7nQDGmfuotWaAxjh5WI42+DG3LD8R9UdvTgPIlNu
 kE2YAJeWFaFVBffjJXM2Rfmq50sipxi2CUvUfkVo9T2oB64mAt2fqIOX5B0uBDLwWOmM
 RxbJm5OBgnuQ4rFYDMH5y2wSTJFB6m12RAAkSrytNV3iy7OuJOLGhAqqmljfRwTd7+Yt
 OYizROSzsfkpsIz/KJ2TwxkBGW5iAutWEi0hceqb/ST84YuJ93bO/TqyFVlWnnPO9pI8
 VkM7luZIh4+1fH+Ss/AmvC/nE2gP7byZOMwlPGvKdllulNCvQyD1M+duj4DNFdRj0n5I
 wKQw==
X-Gm-Message-State: AOJu0YwUSKGlpUyTkCw6fxQbBExu6LPdJozeRZOL2kjAdHq5nPi+Uuxy
 mp1zlamhqiPOTsubPH2hmikM+L7nqgoqCjyakE0gkg==
X-Google-Smtp-Source: AGHT+IHjLkiMOigZbWNa53jbsatAZxg9PTz2QqHwikAluFU4lAxthZQKxNipQU0syQ7hNZyxfLQyBIPoeD5boWcYoTM=
X-Received: by 2002:aa7:c648:0:b0:525:7e46:940 with SMTP id
 z8-20020aa7c648000000b005257e460940mr21786490edr.24.1693239613766; Mon, 28
 Aug 2023 09:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220530100013.3753780-1-ascull@google.com>
In-Reply-To: <20220530100013.3753780-1-ascull@google.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 10:20:02 -0600
Message-ID: <CAPnjgZ3KJS2PDorQVQYw47Pymq6VM0iMe-HEZ=dSGYeE9w6r+Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Fuzzing and ASAN for sandbox
To: Andrew Scull <ascull@google.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de, 
 jonbottarini@google.com, seanga2@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Andrew,

On Mon, 30 May 2022 at 04:00, Andrew Scull <ascull@google.com> wrote:
>
> This series introduces ASAN and a basic fuzzing infrastructure that
> works with sandbox. The example fuzz test towards the end of the series
> will find something pretty quickly. That something is fixed by the
> series "virtio: Harden and test vring" that needs to be applied for the
> final patch in this series.
>
> There is some refactoring to stop using '.' prefixed sections. ELF
> defines sections with names that contain anything that isn't
> alphanumeric or an underscore as being for system use which means
> clang's ASAN instrumentation happily add redzones between the contained
> objects. That's not what we want for things like linker lists where the
> linker script has carefully placed the sections contiguously. By
> renaming the sections, clang sees them as user sections and doesn't add
> instrumentation.
>
> ASAN is left disabled by default as there are still some tests that it
> triggers on and will need some more investigation to fix. It can be
> enabled with CONFIG_ASAN or passing `-a ASAN` to buildman.
>
> I abandonded the previous attempts to refactor sandbox EFI and getopt
> declaration as the changes resulted in problems out of the scope of this
> CL. I haven't tried to understand what EFI on sandbox should look like,
> but I have found that the linker list implementation is very brittle
> when up against compiler optimisation since ef123c5253 started to use
> static, zero-length arrays to mark the beginning and end of lists but
> the compiler see this as something it can get rid of.
>
> From v1:
>  - corrected handling of EFI symbols by sandbox linker script
>  - per comments, some renaming and explaining
>  - dropped RFC for dlmalloc ASAN instrumentation (work required to improve it)
>  - added patch to reduce logging noise in fuzzer
>
> From v2:
>  - remove sandbox EFI and getopt refactoring, they obstruct the series
>  - resolve a couple more ASAN errors
>  - fix LTO, xtensa and MIPS builds
>  - add ASAN build targets for CI
>
> Andrew Scull (13):
>   serial: sandbox: Fix buffer underflow in puts
>   sandbox: Rename EFI runtime sections
>   sandbox: Rename getopt sections
>   linker_lists: Rename sections to remove . prefix
>   sandbox: Add support for Address Sanitizer
>   test/py: test_stackprotector: Disable for ASAN
>   CI: Azure: Build with ASAN enabled
>   fuzzing_engine: Add fuzzing engine uclass
>   test: fuzz: Add framework for fuzzing
>   sandbox: Decouple program entry from sandbox init
>   sandbox: Add libfuzzer integration
>   sandbox: Implement fuzzing engine driver
>   fuzz: virtio: Add fuzzer for vring
>
>  .azure-pipelines.yml                          |  6 ++
>  Kconfig                                       | 16 ++++
>  arch/Kconfig                                  |  2 +
>  arch/arc/cpu/u-boot.lds                       |  4 +-
>  arch/arm/config.mk                            |  4 +-
>  arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds   |  4 +-
>  arch/arm/cpu/armv7/sunxi/u-boot-spl.lds       |  4 +-
>  arch/arm/cpu/armv8/u-boot-spl.lds             |  4 +-
>  arch/arm/cpu/armv8/u-boot.lds                 |  4 +-
>  arch/arm/cpu/u-boot-spl.lds                   |  4 +-
>  arch/arm/cpu/u-boot.lds                       |  6 +-
>  arch/arm/mach-at91/arm926ejs/u-boot-spl.lds   |  2 +-
>  arch/arm/mach-at91/armv7/u-boot-spl.lds       |  2 +-
>  arch/arm/mach-omap2/u-boot-spl.lds            |  4 +-
>  arch/arm/mach-orion5x/u-boot-spl.lds          |  4 +-
>  arch/arm/mach-rockchip/u-boot-tpl-v8.lds      |  4 +-
>  arch/arm/mach-zynq/u-boot-spl.lds             |  4 +-
>  arch/arm/mach-zynq/u-boot.lds                 |  4 +-
>  arch/m68k/cpu/u-boot.lds                      |  4 +-
>  arch/microblaze/cpu/u-boot-spl.lds            |  4 +-
>  arch/microblaze/cpu/u-boot.lds                |  4 +-
>  arch/mips/config.mk                           |  2 +-
>  arch/mips/cpu/u-boot-spl.lds                  |  4 +-
>  arch/mips/cpu/u-boot.lds                      |  4 +-
>  arch/nios2/cpu/u-boot.lds                     |  4 +-
>  arch/powerpc/cpu/mpc83xx/u-boot.lds           |  4 +-
>  arch/powerpc/cpu/mpc85xx/u-boot-spl.lds       |  4 +-
>  arch/powerpc/cpu/mpc85xx/u-boot.lds           |  4 +-
>  arch/riscv/cpu/u-boot-spl.lds                 |  4 +-
>  arch/riscv/cpu/u-boot.lds                     |  4 +-
>  arch/sandbox/config.mk                        | 21 ++++-
>  arch/sandbox/cpu/os.c                         | 76 +++++++++++++++++
>  arch/sandbox/cpu/start.c                      |  2 +-
>  arch/sandbox/cpu/u-boot-spl.lds               | 10 +--
>  arch/sandbox/cpu/u-boot.lds                   | 32 ++++----
>  arch/sandbox/dts/test.dts                     |  4 +
>  arch/sandbox/include/asm/fuzzing_engine.h     | 25 ++++++
>  arch/sandbox/include/asm/getopt.h             |  2 +-
>  arch/sandbox/include/asm/main.h               | 18 ++++
>  arch/sandbox/include/asm/sections.h           |  4 +-
>  arch/sandbox/lib/sections.c                   |  8 +-
>  arch/sh/cpu/u-boot.lds                        |  4 +-
>  arch/x86/cpu/u-boot-64.lds                    |  6 +-
>  arch/x86/cpu/u-boot-spl.lds                   |  6 +-
>  arch/x86/cpu/u-boot.lds                       |  6 +-
>  arch/x86/lib/elf_ia32_efi.lds                 |  4 +-
>  arch/x86/lib/elf_x86_64_efi.lds               |  4 +-
>  arch/xtensa/cpu/u-boot.lds                    |  4 +-
>  arch/xtensa/include/asm/ldscript.h            | 13 ++-
>  board/compulab/cm_t335/u-boot.lds             |  4 +-
>  board/cssi/MCR3000/u-boot.lds                 |  4 +-
>  .../davinci/da8xxevm/u-boot-spl-da850evm.lds  |  2 +-
>  board/qualcomm/dragonboard820c/u-boot.lds     |  4 +-
>  board/samsung/common/exynos-uboot-spl.lds     |  4 +-
>  board/synopsys/iot_devkit/u-boot.lds          |  4 +-
>  board/ti/am335x/u-boot.lds                    |  4 +-
>  board/vscom/baltos/u-boot.lds                 |  4 +-
>  doc/api/linker_lists.rst                      | 22 ++---
>  doc/develop/commands.rst                      |  4 +-
>  doc/develop/driver-model/of-plat.rst          |  4 +-
>  drivers/Kconfig                               |  2 +
>  drivers/Makefile                              |  1 +
>  drivers/fuzz/Kconfig                          | 17 ++++
>  drivers/fuzz/Makefile                         |  8 ++
>  drivers/fuzz/fuzzing_engine-uclass.c          | 28 +++++++
>  drivers/fuzz/sandbox_fuzzing_engine.c         | 35 ++++++++
>  drivers/serial/sandbox.c                      |  2 +-
>  include/dm/uclass-id.h                        |  1 +
>  include/fuzzing_engine.h                      | 51 ++++++++++++
>  include/linker_lists.h                        | 18 ++--
>  include/test/fuzz.h                           | 51 ++++++++++++
>  test/Makefile                                 |  1 +
>  test/fuzz/Makefile                            |  8 ++
>  test/fuzz/cmd_fuzz.c                          | 82 +++++++++++++++++++
>  test/fuzz/virtio.c                            | 72 ++++++++++++++++
>  test/py/tests/test_stackprotector.py          |  1 +
>  tools/mips-relocs.c                           |  9 +-
>  77 files changed, 673 insertions(+), 151 deletions(-)
>  create mode 100644 arch/sandbox/include/asm/fuzzing_engine.h
>  create mode 100644 arch/sandbox/include/asm/main.h
>  create mode 100644 drivers/fuzz/Kconfig
>  create mode 100644 drivers/fuzz/Makefile
>  create mode 100644 drivers/fuzz/fuzzing_engine-uclass.c
>  create mode 100644 drivers/fuzz/sandbox_fuzzing_engine.c
>  create mode 100644 include/fuzzing_engine.h
>  create mode 100644 include/test/fuzz.h
>  create mode 100644 test/fuzz/Makefile
>  create mode 100644 test/fuzz/cmd_fuzz.c
>  create mode 100644 test/fuzz/virtio.c

Could you please add some documentation about this in doc/ ? I also
wonder if we can make the fuzz test run in CI? Finally, can the azure
stuff work in gitlab too?

I am interested in using fuzzing to test a new 'Universal Payload'
feature which basically converts data from a C struct to a devicetree
and back.

Regards,
Simon
