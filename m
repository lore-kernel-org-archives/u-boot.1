Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F39CD379F
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 16:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7241E88B59;
	Tue,  3 Sep 2024 18:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dlYohwa5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B616E88B4B; Tue,  3 Sep 2024 18:07:12 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 593AE8841E
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 18:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7d4c923a3d7so1114028a12.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379629; x=1725984429; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TPZ+fwc4uJPc1Ms46Ljckfx4pwVqyKN4kRjxlQupO9E=;
 b=dlYohwa51uME4VGqyaTbHQ2a8p2QlQfwKLfhQNzW73ZHbplj6v3PpTWVAEPu96qc/3
 wdoVljj54zdqna6SL8a/RSvBk0HLgRSXmRjYC1pztiZQAjWj+5/pi1rp8mzO/ryRURUK
 Fd8ALUp+NLM3zC0NoOdouzp0kWObCZ4OT6KVha48m2HkAFxKx68S3D+l6dIVww8Ramqx
 kjUAp6RYeA6UXzYZlYrk8myqFQzu4ZKdLawQjwVoIc3tBfvKTXHMlPTJXhP8WOMa8K2f
 Cl019RWNckZqyxa08c+mtwEP4FrUGYIJ3Hc6ZhVJ9c/sCm4ZHV+bHdCOOnVrsaQMofIm
 APlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379629; x=1725984429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TPZ+fwc4uJPc1Ms46Ljckfx4pwVqyKN4kRjxlQupO9E=;
 b=QCMCReHZyQdQ6tsTrxntQZCKq4ICZkr+W0KXux/ThgSWWieXWXhcN6BNpWu/TylK4j
 B0A2aWkm/mUvPS04JqvA5N0PJyQCEEf7ySOE+/DhmacEe5eNl+z807Dsm8w4mQIcgvp0
 xMEL+xifWuVTqsBuWssWOMlJB88tqkH1ffWyJeRqxhQmr9d3y/ggChp5cdJsJWRh4Qnl
 87CvBdOmIWX8fnwI+RIqoq7+hxio91F18zeTi3IdA5QpSSmbYRH8LFAUHD+oXi9W7hs+
 RMx/hFDGy1YZ38oz2CDzK/Xo1mQXb8uk8KHG0cIwqbv7w3tQ4NHEGfinKFnwABsafRHI
 pi5A==
X-Gm-Message-State: AOJu0YywXjhEeOhcsDKyok6lhgQJx7HZEAXbkNowcB6ZpiQLgDaz+B2G
 iH0njOLyANBxqjrN0acXoqmTl+vaE972cK6Z05fiMu3/rUkChlfDGUxfT7oWojeUsmOB8g57owg
 VWEofmuG/UW9PheMG+6Djpk9MJoutTQxrXdJvTg==
X-Google-Smtp-Source: AGHT+IF/ThVB47BbE8MCa2k5vuBiM1Fb7ourDYCVN0LqVmUevrpNf3i1g0Up7IkjxG7xTZ4+1Tn4rJULJP9vLqFVFTo=
X-Received: by 2002:a17:90b:1b11:b0:2d8:a9ca:17a4 with SMTP id
 98e67ed59e1d1-2da5597ab68mr3836081a91.21.1725379628684; Tue, 03 Sep 2024
 09:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <CAFLszTjE+8BmdmtFXER94LmEYshNDEA4x_MDTqvyGhHYed2OCw@mail.gmail.com>
In-Reply-To: <CAFLszTjE+8BmdmtFXER94LmEYshNDEA4x_MDTqvyGhHYed2OCw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 3 Sep 2024 12:06:57 -0400
Message-ID: <CAEfUkU+mhmesTgXAO+iGwVdH7hsmY9iF78M4fyM6YciK9o3Dzw@mail.gmail.com>
Subject: Re: [PATCH 00/10] SMBIOS improvements
To: Simon Glass <sjg@chromium.org>
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
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Sat, 17 Aug 2024 at 11:58, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Fri, 16 Aug 2024 at 09:47, Raymond Mao <raymond.mao@linaro.org> wrote:
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
> > 2. Create an arch-specific driver for all aarch64-based platforms to
> fetch
> >    SMBIOS private data from the device hardware.
> > 3. Create a sysinfo driver to poppulate platform SMBIOS private data.
> > 4. Put device tree SMBIOS node as a fallback solution when SMBIOS data is
> >    missing from sysinfo driver.
> > 5. Add support for Type #7 (Cache Information) and link its handles to
> >    Type #4.
> >
> > Once this patch is acceptted, subsequent patch sets will add other
> missing
> > types (#9, #16, #17, #19).
> >
> > Raymond Mao (10):
> >   sysinfo: Add sysinfo API for accessing data area
> >   sysinfo: Add sysinfo driver and data structure for SMBIOS
> >   smbios: Refactor SMBIOS library
> >   smbios: ignore the non-existence of platform sysinfo detect
> >   armv8: Add arch-specific sysinfo driver
> >   sysinfo: Add sysinfo driver for SMBIOS type 7
> >   smbios: Add support to SMBIOS type 7
> >   armv8: Add sysinfo driver for cache information
> >   configs: Enable sysinfo for QEMU Arm64
> >   tests: update smbios pytest
> >
> >  arch/arm/cpu/armv8/Makefile      |   5 +
> >  arch/arm/cpu/armv8/sysinfo.c     | 391 ++++++++++++++++++++++++++
> >  cmd/smbios.c                     | 350 ++++++++++++++++++++++-
> >  configs/qemu_arm64_defconfig     |   2 +
> >  drivers/misc/Kconfig             |   2 +-
> >  drivers/sysinfo/Makefile         |   1 +
> >  drivers/sysinfo/smbios_plat.c    | 442 +++++++++++++++++++++++++++++
> >  drivers/sysinfo/smbios_plat.h    | 131 +++++++++
> >  drivers/sysinfo/sysinfo-uclass.c |  20 ++
> >  include/smbios.h                 | 240 ++++++++++++++--
> >  include/sysinfo.h                | 124 ++++++++-
> >  lib/Makefile                     |   2 +
> >  lib/smbios.c                     | 461 ++++++++++++++++++++++++++-----
> >  test/py/tests/test_smbios.py     |   2 +-
> >  14 files changed, 2058 insertions(+), 115 deletions(-)
> >  create mode 100644 arch/arm/cpu/armv8/sysinfo.c
> >  create mode 100644 drivers/sysinfo/smbios_plat.c
> >  create mode 100644 drivers/sysinfo/smbios_plat.h
> >
> > --
> > 2.25.1
> >
>
> As a general comment, this is adding a load of code which is used by a
> lot of platforms. As more and more aarch64 platforms are created, this
> data grows. Why not use the devicetree for this hardware information?
> That is what it is for.
>
> Some of the information detected makes sense, such as cache setup, but
> some of it seems like an approximation, or is missing, but suggests it
> is authoritative.
>
> The idea is that precise information can still come from dt (if the node
exists,
but as a fact, not many platforms have it up to now).
When it does not exist, system drivers provides the information as much as
it can (some comes from registers, some comes from generic strings/enums).
So it is not assumed that each vendor to add their code but just uses the
arch-specific code in this series - if vendors want precise
information they can
still add into the dt.

Regards,
Raymond
