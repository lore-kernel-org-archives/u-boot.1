Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072C6E77180
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 15:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7853C800D2;
	Mon, 16 Dec 2024 16:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dMbRPKAx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 737FD800D7; Mon, 16 Dec 2024 16:43:39 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F6058005B
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 16:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6f27bbe8fc3so22226097b3.2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 07:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734363816; x=1734968616; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IhBSHYhfpbQsP1wd1JMFlUAV5XwbcMCVRpO+rTbGWPY=;
 b=dMbRPKAxRDJ0+uGpClvpHdcFwa4vTEvblrJstYoK+Hr/h6hyBmh6ND00DqVBDY/KeK
 JOQJUexABZF7Nvz/xYB0SJkhT5gzYooaBJ5jXbK+HUBXJBcMgTOoh2nQkFNzsvaUnuEP
 bKKZ/6m+fmZJJr+Zeqt+F3i3keVShMT8yDZy509DEtTNbPqBsfg964L325sM/0aTA8FK
 pik9OObA7SSAcRG/VyQ57ZwzOC3rTOnKblL7PyjLRBcssqx6NcNfHSmYRG1HGCu3RhPj
 RWFfkmO+6fp1U776TVfdyAFLgh2iwlN/WX5JEq+X5NaMeSwztTd8P7WWPqbDiWalLF+K
 pRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734363816; x=1734968616;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IhBSHYhfpbQsP1wd1JMFlUAV5XwbcMCVRpO+rTbGWPY=;
 b=WNM3smZZPO3ALO2X2vuoLyyfSULn8wLgYK+Ak0ZPbCV06ox0W0KznvqgiYH3oLYXPC
 btgOb5gxl8Qk+5NCBXgMAlRg3TNKNBESh6lutImrNa0QpFFmXeMBlSSV5twod/1jQmqf
 H1Y4NjF1Nk1jGMzC13gyZM2BOSK5VwhVQdy+QWJZUgmydcBxbcFq5aGsawqZGcfUE/Mk
 YHLWL35F5ZHiCnKxbs6Q2LqKc9wduHO74T35r8l5UvatjgwhPW8X1dOex6zDc0hEXDyR
 m6XWrvAzI7uvnBjmuLy1lRpCUB39hNEWA4tYQWUnrTFUkOEkMt03Skv2sQTuoT/FzA5I
 TpeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRkzkdrzhVLZcOPhclk+d6cL8018rSY5usNSvLO2hWXkMx81Smt5/yPMfSpyRJamFasqh2ji8=@lists.denx.de
X-Gm-Message-State: AOJu0YzQrZcEp4Y/RzV7YItYLp5gbMSEQ5V5+0l33nYRW+P+MvSIIyEK
 gd5ueYVQsoeW9wkYl3cjfehXGeKD42eUei+KOorsJDxC3Vir21+VVxJvVxSD3SzRRFIW0rtxkMB
 OU6t3Zgrgeai/gGeXQ9jHJamIk60Dyu/iqw6Z+w==
X-Gm-Gg: ASbGnctBprSiEs6Qr8ZfuQA5koJLxjvlt8XThaZgO8+BlWftWEETRatHEnvQQ9LdDiv
 wSQEH3m0Nxy9e8mGEOw9X8eRcL5kFBnwvUBAYUg==
X-Google-Smtp-Source: AGHT+IGGqVSMqPrvoTVp7EsToTWLOW5o+XAQ8HEgSAIredjqeGAShHaY82Dj2tzbqU0ugOmZyjyLTebohL5bG38K5BQ=
X-Received: by 2002:a05:690c:6303:b0:6ef:a187:f3a3 with SMTP id
 00721157ae682-6f279b7c873mr105483517b3.27.1734363815889; Mon, 16 Dec 2024
 07:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20241206225438.13866-1-raymond.mao@linaro.org>
 <CAFLszTjHzJXCHis8MTVJut2NV+4Agvi5RwyuNE7nxBctp5DotA@mail.gmail.com>
In-Reply-To: <CAFLszTjHzJXCHis8MTVJut2NV+4Agvi5RwyuNE7nxBctp5DotA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Dec 2024 17:43:00 +0200
Message-ID: <CAC_iWjLujinmfP-TL-zyaSoV87E5u3R4i9+dGjZSSSWFCUUKQA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] SMBIOS improvements
To: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de, 
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

Hi Simon,

On Mon, 16 Dec 2024 at 17:16, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Fri, 6 Dec 2024 at 15:54, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Motivations for changes:
> > Current SMBIOS library and command-line tool is not fully matching with
> > the requirements:
> > 1. Missing support for other mandatory types (#7, #9, #16, #17, #19).
> > 2. Only a few platforms support SMBIOS node from the device tree.
> > 3. Values of some fields are hardcoded in the library other than fetching
> >    from the device hardware.
> > 4. Embedded data with dynamic length is not supported (E.g. Contained
> >    Object Handles in Type #2 and Contained Elements in Type #3)
> >
> > Changes:
> > 1. Refactor the SMBIOS library and command-line tool to better align with
> >    the SMBIOS spec.
> > 2. Create an arch-specific driver for all aarch64-based platforms to fetch
> >    SMBIOS private data from the device hardware (processor and cache).
> > 3. Create a sysinfo driver to poppulate platform SMBIOS private data.
> > 4. Add generic SMBIOS DTS file for arm64 platforms for those common strings
> >    and values which cannot be retrieved from the system registers.
> >    Vendors can create their own SMBIOS node using this as an example.
> >    For those boards without SMBIOS nodes, this DTS file can be included to
> >    have a generic SMBIOS information of the system.
> > 5. Add support for Type #7 (Cache Information) and link its handles to
> >    Type #4.
> > 6. To minimize size-growth for those platforms which have not sufficient
> >    ROM spaces or the platforms which don't need detailed SMBIOS
> >    information, new added fields are only being built when kconfig
> >    GENERATE_SMBIOS_TABLE_VERBOSE is selected.
> >
> > Once this patch is acceptted, subsequent patch sets will add other missing
> > types (#9, #16, #17, #19).
> >
> > Tests:
> > To test this with QEMU arm64, please follow the guide on dt_qemu.rst to
> > get a merged DT to run with.
> > ```
> > qemu-system-aarch64 -machine virt -machine dumpdtb=qemu.dtb
> > cat  <(dtc -I dtb qemu.dtb) <(dtc -I dtb ./dts/dt.dtb | grep -v /dts-v1/) \
> >   | dtc - -o merged.dtb
> > qemu-system-aarch64 -machine virt -nographic -bios u-boot.bin \
> >   -dtb merged.dtb
> > ```
> >
> > Raymond Mao (10):
> >   smbios: Refactor the smbios headfile
> >   sysinfo: Add sysinfo API for accessing data area
> >   test/dm: add sandbox test for sysinfo_get_data
> >   sysinfo: Add sysinfo driver and data structure for smbios
> >   smbios: Refactor smbios library
> >   smbios: add detailed smbios information
> >   armv8: Add arch-specific sysinfo platform driver
> >   armv8: Add generic smbios information into the device tree
> >   cmd: update smbios cmd
> >   configs: Enable sysinfo for QEMU Arm64
> >
> >  arch/arm/cpu/armv8/Makefile      |   2 +
> >  arch/arm/cpu/armv8/sysinfo.c     | 292 ++++++++++++++++++++
> >  arch/arm/dts/qemu-arm64.dts      |   4 +
> >  arch/arm/dts/smbios_generic.dtsi |  82 ++++++
> >  cmd/smbios.c                     | 348 +++++++++++++++++++++---
> >  configs/qemu_arm64_defconfig     |   3 +
> >  drivers/misc/Kconfig             |   2 +-
> >  drivers/sysinfo/sandbox.c        |  19 ++
> >  drivers/sysinfo/sandbox.h        |   1 +
> >  drivers/sysinfo/smbios.c         | 228 ++++++++++++++++
> >  drivers/sysinfo/sysinfo-uclass.c |  20 ++
> >  include/smbios.h                 | 158 ++++++-----
> >  include/smbios_def.h             | 194 ++++++++++++++
> >  include/smbios_plat.h            |  79 ++++++
> >  include/sysinfo.h                | 125 ++++++++-
> >  lib/Kconfig                      |   6 +
> >  lib/smbios.c                     | 445 ++++++++++++++++++++++++++-----
> >  test/dm/sysinfo.c                |   6 +
> >  test/py/tests/test_smbios.py     |  18 +-
> >  19 files changed, 1863 insertions(+), 169 deletions(-)
> >  create mode 100644 arch/arm/cpu/armv8/sysinfo.c
> >  create mode 100644 arch/arm/dts/smbios_generic.dtsi
> >  create mode 100644 include/smbios_def.h
> >  create mode 100644 include/smbios_plat.h
> >
> > --
> > 2.25.1
> >
>
> I'm going to leave this series to you and Ilias as I don't really
> support bringing all this SMBIOS info in, just so we can run ACPI on
> ARM.

I don't think the current patchset has anything to do with ACPI. I do
not like revising SMBIOS any more than you do but....
With systemready etc, we are now easily booting distros. Distros rely
on smbios tooling for some of their bug reports, so we are just trying
to make their lives easier. I hope that we can completely disable it
when distros move forward

Since Peter used to work for a distro, he can fill up anything I've missed


Thanks
/Ilias

> Please just avoid code-size increase and breaking any x86
> platforms.
>
> Regards
>
> Simon
