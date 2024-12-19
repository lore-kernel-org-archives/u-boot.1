Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EACE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C08880326;
	Thu, 19 Dec 2024 16:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lPoyx3eZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C96C98033A; Thu, 19 Dec 2024 16:08:26 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D80548021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so135867766b.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 07:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734620903; x=1735225703; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wx+uL7GHBHaiYhK3rWqbQdd6KXgDgxyMlyOta9t/pJg=;
 b=lPoyx3eZBLGuU+M+f6ZjheKyXCBs1rw/j0abwQpKkA2TVIb+l40DsN3W6xEdGhpdno
 4eKHV7WaRcaOZXGrJKVRZOLTBCH9/16crKVC4/rUy0MMUgdzh36YiUHfOViPA3GcrmGV
 0GbBS10OpLkmHRvuE4zgM65deTMhm3RILfnLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734620903; x=1735225703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wx+uL7GHBHaiYhK3rWqbQdd6KXgDgxyMlyOta9t/pJg=;
 b=bcV35JXKoi7HDRMuCxSRRviNYet4nW/VdWiVgQsyyShe0AV7tGbZwkjcnZAhhMutsM
 YEdn2WIvhKmwcemR0BfgnQyvU9roxw7YCE4jPHW3UdA/qQ7liUyg4fA3O2Z3HEIwOcxo
 eVTv40HWwK7Ytyx8cg6rsAcgiS0JHSYEUZe/4tl7xmuI6ElajE8Hhk/BpjCfNubU1L8m
 39W7wkBTgxjwGHZlsvZisTH7hf19ZM8sppI4uJszaTOv6+r72MqVFutjU3JyQ3OhRgXo
 AKY6oCVGjOvWMEz13mlCbGhm+kqkjLSDvsIgzNUiams2yPp91Chd0aNIPfe9zEyuQrwg
 Jtag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsmXbgIYjRmMFZghtOWPSBqpDdgzlj4iaSry4hF1SQ/C2DrUI2IgWSFMeOiis9sTnWpELJ8+o=@lists.denx.de
X-Gm-Message-State: AOJu0YwT6xa1REfH1iZfIxlxnZ1ixMoDkdvSADeowwxxhJAoqPIymYhw
 BjjrRl5EUf50cpUCOSNtHUqDko31/+AE2nSyPfcm0zmen3jEUWOGC3JK9y8FEFRwS66sK0WkTGj
 F+VV1wjCDPsjHlRGLVPQhzrqXB8Td9SMHHAAD
X-Gm-Gg: ASbGnctFXF2Q1k2c+uuSBmbwWnUl5+CxiZ9GCpJ8KhZvZdxDKWkhLkCkWhPqIANIWa6
 yf6OJ4l35YgyhA3q01ZaQM/bh38ugJLaku4qv+2c=
X-Google-Smtp-Source: AGHT+IGuI/PtaE3alhAts2yzISdmpwEBKSkRS/YV+AQE5hu1pM0i+1i+7H5DVrlpY4l7lvstqP/knhzUsgbbIrxlrdI=
X-Received: by 2002:a17:907:944a:b0:aa6:9fad:3c1d with SMTP id
 a640c23a62f3a-aabf490807fmr629662766b.39.1734620903050; Thu, 19 Dec 2024
 07:08:23 -0800 (PST)
MIME-Version: 1.0
References: <20241206225438.13866-1-raymond.mao@linaro.org>
 <CAFLszTjHzJXCHis8MTVJut2NV+4Agvi5RwyuNE7nxBctp5DotA@mail.gmail.com>
 <CAC_iWjLujinmfP-TL-zyaSoV87E5u3R4i9+dGjZSSSWFCUUKQA@mail.gmail.com>
In-Reply-To: <CAC_iWjLujinmfP-TL-zyaSoV87E5u3R4i9+dGjZSSSWFCUUKQA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Dec 2024 08:08:11 -0700
Message-ID: <CAFLszTgvj4XAg6Qvefv0tWSYQ9P+k=-yCvP8RmuSnGJVtZtDAg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] SMBIOS improvements
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Stefan Roese <sr@denx.de>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
 Michal Simek <michal.simek@amd.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Ilias,

On Mon, 16 Dec 2024 at 08:43, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Mon, 16 Dec 2024 at 17:16, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Fri, 6 Dec 2024 at 15:54, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Motivations for changes:
> > > Current SMBIOS library and command-line tool is not fully matching with
> > > the requirements:
> > > 1. Missing support for other mandatory types (#7, #9, #16, #17, #19).
> > > 2. Only a few platforms support SMBIOS node from the device tree.
> > > 3. Values of some fields are hardcoded in the library other than fetching
> > >    from the device hardware.
> > > 4. Embedded data with dynamic length is not supported (E.g. Contained
> > >    Object Handles in Type #2 and Contained Elements in Type #3)
> > >
> > > Changes:
> > > 1. Refactor the SMBIOS library and command-line tool to better align with
> > >    the SMBIOS spec.
> > > 2. Create an arch-specific driver for all aarch64-based platforms to fetch
> > >    SMBIOS private data from the device hardware (processor and cache).
> > > 3. Create a sysinfo driver to poppulate platform SMBIOS private data.
> > > 4. Add generic SMBIOS DTS file for arm64 platforms for those common strings
> > >    and values which cannot be retrieved from the system registers.
> > >    Vendors can create their own SMBIOS node using this as an example.
> > >    For those boards without SMBIOS nodes, this DTS file can be included to
> > >    have a generic SMBIOS information of the system.
> > > 5. Add support for Type #7 (Cache Information) and link its handles to
> > >    Type #4.
> > > 6. To minimize size-growth for those platforms which have not sufficient
> > >    ROM spaces or the platforms which don't need detailed SMBIOS
> > >    information, new added fields are only being built when kconfig
> > >    GENERATE_SMBIOS_TABLE_VERBOSE is selected.
> > >
> > > Once this patch is acceptted, subsequent patch sets will add other missing
> > > types (#9, #16, #17, #19).
> > >
> > > Tests:
> > > To test this with QEMU arm64, please follow the guide on dt_qemu.rst to
> > > get a merged DT to run with.
> > > ```
> > > qemu-system-aarch64 -machine virt -machine dumpdtb=qemu.dtb
> > > cat  <(dtc -I dtb qemu.dtb) <(dtc -I dtb ./dts/dt.dtb | grep -v /dts-v1/) \
> > >   | dtc - -o merged.dtb
> > > qemu-system-aarch64 -machine virt -nographic -bios u-boot.bin \
> > >   -dtb merged.dtb
> > > ```
> > >
> > > Raymond Mao (10):
> > >   smbios: Refactor the smbios headfile
> > >   sysinfo: Add sysinfo API for accessing data area
> > >   test/dm: add sandbox test for sysinfo_get_data
> > >   sysinfo: Add sysinfo driver and data structure for smbios
> > >   smbios: Refactor smbios library
> > >   smbios: add detailed smbios information
> > >   armv8: Add arch-specific sysinfo platform driver
> > >   armv8: Add generic smbios information into the device tree
> > >   cmd: update smbios cmd
> > >   configs: Enable sysinfo for QEMU Arm64
> > >
> > >  arch/arm/cpu/armv8/Makefile      |   2 +
> > >  arch/arm/cpu/armv8/sysinfo.c     | 292 ++++++++++++++++++++
> > >  arch/arm/dts/qemu-arm64.dts      |   4 +
> > >  arch/arm/dts/smbios_generic.dtsi |  82 ++++++
> > >  cmd/smbios.c                     | 348 +++++++++++++++++++++---
> > >  configs/qemu_arm64_defconfig     |   3 +
> > >  drivers/misc/Kconfig             |   2 +-
> > >  drivers/sysinfo/sandbox.c        |  19 ++
> > >  drivers/sysinfo/sandbox.h        |   1 +
> > >  drivers/sysinfo/smbios.c         | 228 ++++++++++++++++
> > >  drivers/sysinfo/sysinfo-uclass.c |  20 ++
> > >  include/smbios.h                 | 158 ++++++-----
> > >  include/smbios_def.h             | 194 ++++++++++++++
> > >  include/smbios_plat.h            |  79 ++++++
> > >  include/sysinfo.h                | 125 ++++++++-
> > >  lib/Kconfig                      |   6 +
> > >  lib/smbios.c                     | 445 ++++++++++++++++++++++++++-----
> > >  test/dm/sysinfo.c                |   6 +
> > >  test/py/tests/test_smbios.py     |  18 +-
> > >  19 files changed, 1863 insertions(+), 169 deletions(-)
> > >  create mode 100644 arch/arm/cpu/armv8/sysinfo.c
> > >  create mode 100644 arch/arm/dts/smbios_generic.dtsi
> > >  create mode 100644 include/smbios_def.h
> > >  create mode 100644 include/smbios_plat.h
> > >
> > > --
> > > 2.25.1
> > >
> >
> > I'm going to leave this series to you and Ilias as I don't really
> > support bringing all this SMBIOS info in, just so we can run ACPI on
> > ARM.
>
> I don't think the current patchset has anything to do with ACPI. I do
> not like revising SMBIOS any more than you do but....
> With systemready etc, we are now easily booting distros. Distros rely
> on smbios tooling for some of their bug reports, so we are just trying
> to make their lives easier. I hope that we can completely disable it
> when distros move forward
>
> Since Peter used to work for a distro, he can fill up anything I've missed

If you would like to move on from legacy stuff, I advise you to do it
in baby steps. A good time to break free is when you find yourself
implementing something to 'just make things easier for the existing
programs, etc.' Failing that, $10 says SMBIOS becomes entrenched on
ARM.

> > Please just avoid code-size increase and breaking any x86
> > platforms.

Regards,
Simon
