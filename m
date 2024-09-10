Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CEEEDE9AD
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 19:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C5C890F7;
	Tue, 10 Sep 2024 21:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kWLNkvFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 201D688FF9; Tue, 10 Sep 2024 21:20:23 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38D6C89119
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 21:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-718d962ad64so4287167b3a.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725996018; x=1726600818; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V3UonnV0qKqrSk7QxAUXVNQ+TyENIc+U0xeiKq14/DM=;
 b=kWLNkvFydQNHy8/okHKieDcwWLI8tJwmudZW9ryAo5W1pFcf8Yqowqv7S8noOFTbpz
 PHrvO8LbgMzcqfmHtfw0N2FZZsHev2Kt7rTPu+u7whdCCqfmvyqiuJXCqSaTrHe0dSI+
 1vz6oYGUXbUXKew1Uepx4PlghACKh9NkhGZh/1864gPO4KZ50BT0K7KWHxQH5yUtQENO
 CSrxJBdfNdGjrU3Vr3msS8kL22gzh9XVePKVGBY0HbJXvODGjTTceFn+Uvi94CQoIpEq
 aLG5HLzX4b93fQM1GoGCh5I9UOHPg2HRvQXiDcIzkZSTZdGT44yDb65M7e7Wumk/VnH8
 7DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725996019; x=1726600819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V3UonnV0qKqrSk7QxAUXVNQ+TyENIc+U0xeiKq14/DM=;
 b=hdAYDJOSfE2tM/p/GFNQs7Z2BBeIs2W+wcbLWjNoRYKVp958BtK4NIl/Z9bkyTFVUl
 0tBGb/MoaIeKKLcEEfgX/x1BdO9JNi4C2o9MMOexeTtaT83MyLVHhC9pt62hoqiGQdB4
 KdtqbKdYXVTygPIoJ9JuNDsrynZdMii7KP3f5jMXyMTR2xGarxHb9LHXWS1k71qY4L84
 aU7w0KEdjsb06zRkR/6IVP7Za+sMSzKENK2uRv+jVMEM/2WB5wXXsX2JpSJfWNLf1y5f
 Xm+wDazMBp3cAaqzTP5lcBB4hW/OlM6A6V9VVE1qBOhGwmdI0EsRJZDlPVC9HVGzlU9B
 SnrA==
X-Gm-Message-State: AOJu0Ywwvy4ZKnNRQmurHkpU+E+OfzZQESUYoFqfEefipBcETi8ONAtE
 f3iAI5AKVTRG/x8DzFlujvfBja4avFMQJsCpwkPLT4D8e6+r+jgv04XVw8cM3UnkJphM+7zW+x4
 Z4mfZsBghLztdTnjs84b58FIspXQPPrlnuoBI7g==
X-Google-Smtp-Source: AGHT+IG/Ws8OyfKweGncnhDHuyhWt7VNMttPHt3x35OgeioSc8xPiYrtHE+lj7eMGVzhbpRqJzTY5Zl6sWcCs90Lyv4=
X-Received: by 2002:a05:6a00:244e:b0:70d:2b95:d9c0 with SMTP id
 d2e1a72fcca58-718d5e55d73mr25341862b3a.14.1725996018476; Tue, 10 Sep 2024
 12:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <CAFLszTjE+8BmdmtFXER94LmEYshNDEA4x_MDTqvyGhHYed2OCw@mail.gmail.com>
 <CAEfUkU+mhmesTgXAO+iGwVdH7hsmY9iF78M4fyM6YciK9o3Dzw@mail.gmail.com>
 <CAFLszTg5pNV+bfy0T74hpM6xA2ix-PgSGR6SvennHh4hhXeu7g@mail.gmail.com>
In-Reply-To: <CAFLszTg5pNV+bfy0T74hpM6xA2ix-PgSGR6SvennHh4hhXeu7g@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 10 Sep 2024 15:20:06 -0400
Message-ID: <CAEfUkU+9Lp9S+bZC1LnHtE-C+jaQvb4iBB4mcCD0t28LMHRtVw@mail.gmail.com>
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

On Tue, 10 Sept 2024 at 14:44, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Tue, 3 Sept 2024 at 10:07, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Sat, 17 Aug 2024 at 11:58, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Raymond,
> >>
> >> On Fri, 16 Aug 2024 at 09:47, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> >> >
> >> > Motivations for changes:
> >> > Current SMBIOS library and command-line tool is not fully matching
> with
> >> > the requirements:
> >> > 1. Missing support for other mandatory types (#7, #9, #16, #17, #19).
> >> > 2. Only a few platforms support SMBIOS node from the device tree.
> >> > 3. Values of some fields are hardcoded in the library other than
> fetching
> >> >    from the device hardware.
> >> > 4. Embedded data with dynamic length is not supported (E.g. Contained
> >> >    Object Handles in Type #2 and Contained Elements in Type #3)
> >> >
> >> > Changes:
> >> > 1. Refactor the SMBIOS library and command-line tool to better align
> with
> >> >    the SMBIOS spec.
> >> > 2. Create an arch-specific driver for all aarch64-based platforms to
> fetch
> >> >    SMBIOS private data from the device hardware.
> >> > 3. Create a sysinfo driver to poppulate platform SMBIOS private data.
> >> > 4. Put device tree SMBIOS node as a fallback solution when SMBIOS
> data is
> >> >    missing from sysinfo driver.
> >> > 5. Add support for Type #7 (Cache Information) and link its handles to
> >> >    Type #4.
> >> >
> >> > Once this patch is acceptted, subsequent patch sets will add other
> missing
> >> > types (#9, #16, #17, #19).
> >> >
> >> > Raymond Mao (10):
> >> >   sysinfo: Add sysinfo API for accessing data area
> >> >   sysinfo: Add sysinfo driver and data structure for SMBIOS
> >> >   smbios: Refactor SMBIOS library
> >> >   smbios: ignore the non-existence of platform sysinfo detect
> >> >   armv8: Add arch-specific sysinfo driver
> >> >   sysinfo: Add sysinfo driver for SMBIOS type 7
> >> >   smbios: Add support to SMBIOS type 7
> >> >   armv8: Add sysinfo driver for cache information
> >> >   configs: Enable sysinfo for QEMU Arm64
> >> >   tests: update smbios pytest
> >> >
> >> >  arch/arm/cpu/armv8/Makefile      |   5 +
> >> >  arch/arm/cpu/armv8/sysinfo.c     | 391 ++++++++++++++++++++++++++
> >> >  cmd/smbios.c                     | 350 ++++++++++++++++++++++-
> >> >  configs/qemu_arm64_defconfig     |   2 +
> >> >  drivers/misc/Kconfig             |   2 +-
> >> >  drivers/sysinfo/Makefile         |   1 +
> >> >  drivers/sysinfo/smbios_plat.c    | 442 +++++++++++++++++++++++++++++
> >> >  drivers/sysinfo/smbios_plat.h    | 131 +++++++++
> >> >  drivers/sysinfo/sysinfo-uclass.c |  20 ++
> >> >  include/smbios.h                 | 240 ++++++++++++++--
> >> >  include/sysinfo.h                | 124 ++++++++-
> >> >  lib/Makefile                     |   2 +
> >> >  lib/smbios.c                     | 461
> ++++++++++++++++++++++++++-----
> >> >  test/py/tests/test_smbios.py     |   2 +-
> >> >  14 files changed, 2058 insertions(+), 115 deletions(-)
> >> >  create mode 100644 arch/arm/cpu/armv8/sysinfo.c
> >> >  create mode 100644 drivers/sysinfo/smbios_plat.c
> >> >  create mode 100644 drivers/sysinfo/smbios_plat.h
> >> >
> >> > --
> >> > 2.25.1
> >> >
> >>
> >> As a general comment, this is adding a load of code which is used by a
> >> lot of platforms. As more and more aarch64 platforms are created, this
> >> data grows. Why not use the devicetree for this hardware information?
> >> That is what it is for.
> >>
> >> Some of the information detected makes sense, such as cache setup, but
> >> some of it seems like an approximation, or is missing, but suggests it
> >> is authoritative.
> >>
> > The idea is that precise information can still come from dt (if the node
> exists,
> > but as a fact, not many platforms have it up to now).
> > When it does not exist, system drivers provides the information as much
> as
> > it can (some comes from registers, some comes from generic
> strings/enums).
> > So it is not assumed that each vendor to add their code but just uses the
> > arch-specific code in this series - if vendors want precise information
> they can
> > still add into the dt.
>
> I fully understand what you are doing. I just don't think it is a
> great idea. We should have a clear boundary between:
>
> 1. things which are part of the hardware (although not explicitly in
> the devicetree) and can be probed
> 2. things which we can only guess at
> 3. grey area
>
> I am very happy with 1). It is just 2) that I want to avoid.
>
> The grey area is where your series adds lots of strings for different
> hardware...that just seems like code-size bloat to me.
>
> How about working on a devicetree binding for this stuff? Or perhaps
> add the info to the boards you care about?
>
> What I planned to do is to have a general one for arm64, then all the
arm64 boards missing the dt
node can leverage it.
Regarding to 2) you pointed out, maybe we can leave them to the dt later,
my patch can go first with
those architectural common stuffs, for example, cache information.
I will think about it before posting the next version.

Regards,
Raymond
