Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418D4E77180
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 15:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 917AD80141;
	Mon, 16 Dec 2024 16:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AoLRp9rO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 116CD80216; Mon, 16 Dec 2024 16:16:41 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D63A9800D7
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 16:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa679ad4265so988442966b.0
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 07:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734362198; x=1734966998; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PNfNGXLYu5wVOYB+6AAYySLjLSIfgZUh6uKRezSgji8=;
 b=AoLRp9rO+HRTyr4Z0LC/d7bAOsghXsU/HfGszM8qoEXsbAWYa2RVNsu2gUaTJikjVO
 mJPQKxmvVYZ8Iu/8KbpW2MvKx5yCPtM8mAH0iKpiMfCgMZaZBSjGGFIaNnpuNmmplN95
 ontxuIWUw5BKTHvIM10+gaQ4NvzwCnREOCh/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734362198; x=1734966998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PNfNGXLYu5wVOYB+6AAYySLjLSIfgZUh6uKRezSgji8=;
 b=LzzS+4FkdVpXYtbxnE4oN40dUNmkvttvZjxWhKlJ0k/ODaOEPi8V+bM/nhcidzQckn
 HcS0ZmqccuJqQ075qkKD+qAwqVgMqJZO8ucvAi6v1qUPWQ9wq+RiKnhLxcL8/KMAIp10
 YFXNYz5wj1u5wGRhZMGcauysPT6KmX6bvyavpyo3GlE4o8cVnna+7djMVyr7UFC5Zldt
 cIwCHj4e26w111sKFYJKli1lFP6T/tSPk1dPyrjVGa+Bza5ZQsRSnMlSeY4ldDSvgVht
 0lwhqwLBjaA7YXIzcSO6rHd4UiwB/dNk6/o5urUBclUJxXyKvSAtTrk02OjXPMDKyDHe
 gMeQ==
X-Gm-Message-State: AOJu0Yw9oYHOjTRMAiJaYa2AbWpWU4KtR/PHrSkUOgZBQcvcuuJ/CSR7
 +mSs8Qxw4B0ekEhiLnewr+xSp6zKC+9NaqKHhY+F/+Nj6t6Xp2r0apToWt3mQCf1Hmtd5NyNLwx
 WRiXgSu2XNpHWYcTir4t9R4clb59FQb2YRN0Z
X-Gm-Gg: ASbGnctAOi2i/ITmihgJMKgjbU+VML7NdWhsnIJ5hBoabuo7BGxNW5kH3aR+FW5x7DZ
 zCri68m7MPVK83g7rN5/EEVXJ/Wc6+Q7ZD/Dxy3k=
X-Google-Smtp-Source: AGHT+IHmlMlJWbwv1DlQlYw9o8b+ejRwxRoJAAcq8dGy4MSspl5E8blmxl8eZU5ueNOC+FBA/BVQiDCuK2ZOhcDveWQ=
X-Received: by 2002:a17:907:7e92:b0:aab:a02c:764e with SMTP id
 a640c23a62f3a-aaba02d7266mr742962466b.14.1734362198204; Mon, 16 Dec 2024
 07:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20241206225438.13866-1-raymond.mao@linaro.org>
In-Reply-To: <20241206225438.13866-1-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Dec 2024 08:16:26 -0700
Message-ID: <CAFLszTjHzJXCHis8MTVJut2NV+4Agvi5RwyuNE7nxBctp5DotA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] SMBIOS improvements
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefan Roese <sr@denx.de>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
 Michal Simek <michal.simek@amd.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Raymond,

On Fri, 6 Dec 2024 at 15:54, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Motivations for changes:
> Current SMBIOS library and command-line tool is not fully matching with
> the requirements:
> 1. Missing support for other mandatory types (#7, #9, #16, #17, #19).
> 2. Only a few platforms support SMBIOS node from the device tree.
> 3. Values of some fields are hardcoded in the library other than fetching
>    from the device hardware.
> 4. Embedded data with dynamic length is not supported (E.g. Contained
>    Object Handles in Type #2 and Contained Elements in Type #3)
>
> Changes:
> 1. Refactor the SMBIOS library and command-line tool to better align with
>    the SMBIOS spec.
> 2. Create an arch-specific driver for all aarch64-based platforms to fetch
>    SMBIOS private data from the device hardware (processor and cache).
> 3. Create a sysinfo driver to poppulate platform SMBIOS private data.
> 4. Add generic SMBIOS DTS file for arm64 platforms for those common strings
>    and values which cannot be retrieved from the system registers.
>    Vendors can create their own SMBIOS node using this as an example.
>    For those boards without SMBIOS nodes, this DTS file can be included to
>    have a generic SMBIOS information of the system.
> 5. Add support for Type #7 (Cache Information) and link its handles to
>    Type #4.
> 6. To minimize size-growth for those platforms which have not sufficient
>    ROM spaces or the platforms which don't need detailed SMBIOS
>    information, new added fields are only being built when kconfig
>    GENERATE_SMBIOS_TABLE_VERBOSE is selected.
>
> Once this patch is acceptted, subsequent patch sets will add other missing
> types (#9, #16, #17, #19).
>
> Tests:
> To test this with QEMU arm64, please follow the guide on dt_qemu.rst to
> get a merged DT to run with.
> ```
> qemu-system-aarch64 -machine virt -machine dumpdtb=qemu.dtb
> cat  <(dtc -I dtb qemu.dtb) <(dtc -I dtb ./dts/dt.dtb | grep -v /dts-v1/) \
>   | dtc - -o merged.dtb
> qemu-system-aarch64 -machine virt -nographic -bios u-boot.bin \
>   -dtb merged.dtb
> ```
>
> Raymond Mao (10):
>   smbios: Refactor the smbios headfile
>   sysinfo: Add sysinfo API for accessing data area
>   test/dm: add sandbox test for sysinfo_get_data
>   sysinfo: Add sysinfo driver and data structure for smbios
>   smbios: Refactor smbios library
>   smbios: add detailed smbios information
>   armv8: Add arch-specific sysinfo platform driver
>   armv8: Add generic smbios information into the device tree
>   cmd: update smbios cmd
>   configs: Enable sysinfo for QEMU Arm64
>
>  arch/arm/cpu/armv8/Makefile      |   2 +
>  arch/arm/cpu/armv8/sysinfo.c     | 292 ++++++++++++++++++++
>  arch/arm/dts/qemu-arm64.dts      |   4 +
>  arch/arm/dts/smbios_generic.dtsi |  82 ++++++
>  cmd/smbios.c                     | 348 +++++++++++++++++++++---
>  configs/qemu_arm64_defconfig     |   3 +
>  drivers/misc/Kconfig             |   2 +-
>  drivers/sysinfo/sandbox.c        |  19 ++
>  drivers/sysinfo/sandbox.h        |   1 +
>  drivers/sysinfo/smbios.c         | 228 ++++++++++++++++
>  drivers/sysinfo/sysinfo-uclass.c |  20 ++
>  include/smbios.h                 | 158 ++++++-----
>  include/smbios_def.h             | 194 ++++++++++++++
>  include/smbios_plat.h            |  79 ++++++
>  include/sysinfo.h                | 125 ++++++++-
>  lib/Kconfig                      |   6 +
>  lib/smbios.c                     | 445 ++++++++++++++++++++++++++-----
>  test/dm/sysinfo.c                |   6 +
>  test/py/tests/test_smbios.py     |  18 +-
>  19 files changed, 1863 insertions(+), 169 deletions(-)
>  create mode 100644 arch/arm/cpu/armv8/sysinfo.c
>  create mode 100644 arch/arm/dts/smbios_generic.dtsi
>  create mode 100644 include/smbios_def.h
>  create mode 100644 include/smbios_plat.h
>
> --
> 2.25.1
>

I'm going to leave this series to you and Ilias as I don't really
support bringing all this SMBIOS info in, just so we can run ACPI on
ARM. Please just avoid code-size increase and breaking any x86
platforms.

Regards

Simon
