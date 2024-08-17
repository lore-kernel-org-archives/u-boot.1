Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89C4C52D7D
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 15:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66CAC88498;
	Sat, 17 Aug 2024 17:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OXV8uyEq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3A1988403; Sat, 17 Aug 2024 17:58:23 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7826D88498
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6bf7a2035d9so20916666d6.1
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910300; x=1724515100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bWmuRuHLO/mVMr4ixPMeHVzF7WmPrvfqAmYVFFOtNh8=;
 b=OXV8uyEqQJvOhyFnBZxKXh91QclisPxxv6oOCIDXhduZSsoBPx815pKgoEKygngtkY
 F/QeMy7mP5GOLbuDxj9yu0UiNhLUVzkVcGa6BAiIiTlOlSpvcBol6qy3q9LcIp7EF49t
 HFn8BA9f2sFkZfDcCwX7PuYltQfAymWPzyKLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910300; x=1724515100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bWmuRuHLO/mVMr4ixPMeHVzF7WmPrvfqAmYVFFOtNh8=;
 b=qDuFU0W3tCCOCoBYrkTMx3Vcz96wm6qKkOQ2/jBpaJ5zhRqa4kd7+jzKVTHvRvxWgt
 39nVeZLp6LbW5PsD+sNgcc8A2IjTgfz5a4WasVZR1Yz3xlCs06Jm4cJHis26Y8C39Mnc
 6tovJN+Xh1MB7hbwEhZz9imJ5JaG0v9vtW8zEKYiK2Mttr8mFdx2cyt2edyFj3wh43Nm
 E9BS0TdwjeQnbAP3ddy8aWCr7ZbKWXInBZgtvblaV1PbePzfN2jJQzMEifUVGuGAmacv
 TyZboMPx1RfCDLdacmWX6SaeNus19NXOUfIBuKGwpW57jgwkRl+ZRUaKlCgGB9x4tX8o
 DoAA==
X-Gm-Message-State: AOJu0YwVs46irXNiBn40EkY9Zk7wHYskXQ2XJ9wnr1mfKVxTsWkyfRxv
 Q3SEysdCJtNRCfuf5lGLEjnOv5CLJUZmc74VHUiE/1LAWzhiJR8xUwXxztHgO6USL4WGltc/lRY
 zxO0+sX0YQg0QJfQwsWslw5y1DSNXFd60TJVE
X-Google-Smtp-Source: AGHT+IFCRbG19TJDuCQLChJ+uKFZTiNTHNL04+c27V4SU8GGRH6HRW4K+j3EplP5K1etuygZNsF4/ncUTK9DMA35Av0=
X-Received: by 2002:a05:6214:2a3:b0:6bf:7bdd:176e with SMTP id
 6a1803df08f44-6bf7d5c47d0mr95547236d6.25.1723910300243; Sat, 17 Aug 2024
 08:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
In-Reply-To: <20240816154658.1866186-1-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:58:09 -0600
Message-ID: <CAFLszTjE+8BmdmtFXER94LmEYshNDEA4x_MDTqvyGhHYed2OCw@mail.gmail.com>
Subject: Re: [PATCH 00/10] SMBIOS improvements
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Stefan Roese <sr@denx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Michal Simek <michal.simek@amd.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
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

On Fri, 16 Aug 2024 at 09:47, Raymond Mao <raymond.mao@linaro.org> wrote:
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
>    SMBIOS private data from the device hardware.
> 3. Create a sysinfo driver to poppulate platform SMBIOS private data.
> 4. Put device tree SMBIOS node as a fallback solution when SMBIOS data is
>    missing from sysinfo driver.
> 5. Add support for Type #7 (Cache Information) and link its handles to
>    Type #4.
>
> Once this patch is acceptted, subsequent patch sets will add other missing
> types (#9, #16, #17, #19).
>
> Raymond Mao (10):
>   sysinfo: Add sysinfo API for accessing data area
>   sysinfo: Add sysinfo driver and data structure for SMBIOS
>   smbios: Refactor SMBIOS library
>   smbios: ignore the non-existence of platform sysinfo detect
>   armv8: Add arch-specific sysinfo driver
>   sysinfo: Add sysinfo driver for SMBIOS type 7
>   smbios: Add support to SMBIOS type 7
>   armv8: Add sysinfo driver for cache information
>   configs: Enable sysinfo for QEMU Arm64
>   tests: update smbios pytest
>
>  arch/arm/cpu/armv8/Makefile      |   5 +
>  arch/arm/cpu/armv8/sysinfo.c     | 391 ++++++++++++++++++++++++++
>  cmd/smbios.c                     | 350 ++++++++++++++++++++++-
>  configs/qemu_arm64_defconfig     |   2 +
>  drivers/misc/Kconfig             |   2 +-
>  drivers/sysinfo/Makefile         |   1 +
>  drivers/sysinfo/smbios_plat.c    | 442 +++++++++++++++++++++++++++++
>  drivers/sysinfo/smbios_plat.h    | 131 +++++++++
>  drivers/sysinfo/sysinfo-uclass.c |  20 ++
>  include/smbios.h                 | 240 ++++++++++++++--
>  include/sysinfo.h                | 124 ++++++++-
>  lib/Makefile                     |   2 +
>  lib/smbios.c                     | 461 ++++++++++++++++++++++++++-----
>  test/py/tests/test_smbios.py     |   2 +-
>  14 files changed, 2058 insertions(+), 115 deletions(-)
>  create mode 100644 arch/arm/cpu/armv8/sysinfo.c
>  create mode 100644 drivers/sysinfo/smbios_plat.c
>  create mode 100644 drivers/sysinfo/smbios_plat.h
>
> --
> 2.25.1
>

As a general comment, this is adding a load of code which is used by a
lot of platforms. As more and more aarch64 platforms are created, this
data grows. Why not use the devicetree for this hardware information?
That is what it is for.

Some of the information detected makes sense, such as cache setup, but
some of it seems like an approximation, or is missing, but suggests it
is authoritative.

Regards,
Simon
