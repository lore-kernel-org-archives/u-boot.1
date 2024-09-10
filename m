Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF44EDE9B4
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 20:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDA0F890E6;
	Tue, 10 Sep 2024 22:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M2KMqNTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA4DF890E6; Tue, 10 Sep 2024 22:15:52 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA2D2890D2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 22:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6bf6606363fso38745836d6.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 13:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725999348; x=1726604148; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LmRqfnDw+brsUxe/kWQLrMDu7KgLHTaBSMOl6cEmKW0=;
 b=M2KMqNTDPc4CCeRf6NSAdFz/OvS2tmtHOmFLW3rOPy9Q2bhcblhyY5AtEM12kjyhk6
 zJHcWD7ZGDKzHW0YmTbVA1KsA3iN4jsgeaXEMIOzn2VgY9IFmVkGYDKpkfRd4kT2tatK
 2rB5QcyiF2ePlW2m2WCT3bFmEAeQ7ms/F4Nns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725999348; x=1726604148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LmRqfnDw+brsUxe/kWQLrMDu7KgLHTaBSMOl6cEmKW0=;
 b=nvWgV3mhY1nIFk+QHmdLhXi8bp6Gkcf7RtzJUYuA03XbHFyW3O3Jmaqg2XQtFqye9I
 yl1xXAsveko8utXXGJMuFaipd4EQiDucrGbNsiS3NEqTFLJkwq1j6I9/xtAejaIOOxkA
 1ljfuQSKiMXD2RSEA0dmPUL2edD2GtmIUIca8j6K10hK0N1feWbS9pN7RwKRIsuDxhM1
 Yk0Co2hyVMDsAHlE1MR6CuJP5IaiUVMXlKNEjrdvV0HGkNNuYN/h0RfdCbeZbKtGBF9p
 nKPMW3wgC+UKeGUTfQey69i8BSnWn0KBBH1t5mF8b+5FzRXrJvdTfnj9b/S/lKjpf8iy
 XUNQ==
X-Gm-Message-State: AOJu0YyO13T6GpsB/yAbF+qGlWzjaA25TmoWrsue1nQfJfsQeeIZ2bFL
 NJP/nZ0c5LNC6GXJJrvDGN+mGpO1TbubJ41s0lilVD5ejONy1JdfAD5/Yv83do8nP0B/wB4oSed
 7zdDParePmpMYZahJ2q+Q74ZHOkYjbAFTwA0l
X-Google-Smtp-Source: AGHT+IHuYC8eePuUGxxwZJ65r1EFWgap2IAN9LyI9j6mehRrfvrEzfPVh5oHS3R77gM1+vVzM2R/KL905xcOYnt3wcg=
X-Received: by 2002:a05:6214:570e:b0:6c3:6799:ddef with SMTP id
 6a1803df08f44-6c5283f6d21mr159984646d6.3.1725999348644; Tue, 10 Sep 2024
 13:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <CAFLszTjE+8BmdmtFXER94LmEYshNDEA4x_MDTqvyGhHYed2OCw@mail.gmail.com>
 <CAEfUkU+mhmesTgXAO+iGwVdH7hsmY9iF78M4fyM6YciK9o3Dzw@mail.gmail.com>
 <CAFLszTg5pNV+bfy0T74hpM6xA2ix-PgSGR6SvennHh4hhXeu7g@mail.gmail.com>
 <CAEfUkU+9Lp9S+bZC1LnHtE-C+jaQvb4iBB4mcCD0t28LMHRtVw@mail.gmail.com>
In-Reply-To: <CAEfUkU+9Lp9S+bZC1LnHtE-C+jaQvb4iBB4mcCD0t28LMHRtVw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Sep 2024 14:15:37 -0600
Message-ID: <CAFLszTjRkMZOnb4nV3SuU_3vW7tog5D8vuwkVPToPMy_V-hPaQ@mail.gmail.com>
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

On Tue, 10 Sept 2024 at 13:20, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Tue, 10 Sept 2024 at 14:44, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Raymond,
>>
>> On Tue, 3 Sept 2024 at 10:07, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > Hi Simon,
>> >
>> > On Sat, 17 Aug 2024 at 11:58, Simon Glass <sjg@chromium.org> wrote:
>> >>
>> >> Hi Raymond,
>> >>
>> >> On Fri, 16 Aug 2024 at 09:47, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >> >
>> >> > Motivations for changes:
>> >> > Current SMBIOS library and command-line tool is not fully matching with
>> >> > the requirements:
>> >> > 1. Missing support for other mandatory types (#7, #9, #16, #17, #19).
>> >> > 2. Only a few platforms support SMBIOS node from the device tree.
>> >> > 3. Values of some fields are hardcoded in the library other than fetching
>> >> >    from the device hardware.
>> >> > 4. Embedded data with dynamic length is not supported (E.g. Contained
>> >> >    Object Handles in Type #2 and Contained Elements in Type #3)
>> >> >
>> >> > Changes:
>> >> > 1. Refactor the SMBIOS library and command-line tool to better align with
>> >> >    the SMBIOS spec.
>> >> > 2. Create an arch-specific driver for all aarch64-based platforms to fetch
>> >> >    SMBIOS private data from the device hardware.
>> >> > 3. Create a sysinfo driver to poppulate platform SMBIOS private data.
>> >> > 4. Put device tree SMBIOS node as a fallback solution when SMBIOS data is
>> >> >    missing from sysinfo driver.
>> >> > 5. Add support for Type #7 (Cache Information) and link its handles to
>> >> >    Type #4.
>> >> >
>> >> > Once this patch is acceptted, subsequent patch sets will add other missing
>> >> > types (#9, #16, #17, #19).
>> >> >
>> >> > Raymond Mao (10):
>> >> >   sysinfo: Add sysinfo API for accessing data area
>> >> >   sysinfo: Add sysinfo driver and data structure for SMBIOS
>> >> >   smbios: Refactor SMBIOS library
>> >> >   smbios: ignore the non-existence of platform sysinfo detect
>> >> >   armv8: Add arch-specific sysinfo driver
>> >> >   sysinfo: Add sysinfo driver for SMBIOS type 7
>> >> >   smbios: Add support to SMBIOS type 7
>> >> >   armv8: Add sysinfo driver for cache information
>> >> >   configs: Enable sysinfo for QEMU Arm64
>> >> >   tests: update smbios pytest
>> >> >
>> >> >  arch/arm/cpu/armv8/Makefile      |   5 +
>> >> >  arch/arm/cpu/armv8/sysinfo.c     | 391 ++++++++++++++++++++++++++
>> >> >  cmd/smbios.c                     | 350 ++++++++++++++++++++++-
>> >> >  configs/qemu_arm64_defconfig     |   2 +
>> >> >  drivers/misc/Kconfig             |   2 +-
>> >> >  drivers/sysinfo/Makefile         |   1 +
>> >> >  drivers/sysinfo/smbios_plat.c    | 442 +++++++++++++++++++++++++++++
>> >> >  drivers/sysinfo/smbios_plat.h    | 131 +++++++++
>> >> >  drivers/sysinfo/sysinfo-uclass.c |  20 ++
>> >> >  include/smbios.h                 | 240 ++++++++++++++--
>> >> >  include/sysinfo.h                | 124 ++++++++-
>> >> >  lib/Makefile                     |   2 +
>> >> >  lib/smbios.c                     | 461 ++++++++++++++++++++++++++-----
>> >> >  test/py/tests/test_smbios.py     |   2 +-
>> >> >  14 files changed, 2058 insertions(+), 115 deletions(-)
>> >> >  create mode 100644 arch/arm/cpu/armv8/sysinfo.c
>> >> >  create mode 100644 drivers/sysinfo/smbios_plat.c
>> >> >  create mode 100644 drivers/sysinfo/smbios_plat.h
>> >> >
>> >> > --
>> >> > 2.25.1
>> >> >
>> >>
>> >> As a general comment, this is adding a load of code which is used by a
>> >> lot of platforms. As more and more aarch64 platforms are created, this
>> >> data grows. Why not use the devicetree for this hardware information?
>> >> That is what it is for.
>> >>
>> >> Some of the information detected makes sense, such as cache setup, but
>> >> some of it seems like an approximation, or is missing, but suggests it
>> >> is authoritative.
>> >>
>> > The idea is that precise information can still come from dt (if the node exists,
>> > but as a fact, not many platforms have it up to now).
>> > When it does not exist, system drivers provides the information as much as
>> > it can (some comes from registers, some comes from generic strings/enums).
>> > So it is not assumed that each vendor to add their code but just uses the
>> > arch-specific code in this series - if vendors want precise information they can
>> > still add into the dt.
>>
>> I fully understand what you are doing. I just don't think it is a
>> great idea. We should have a clear boundary between:
>>
>> 1. things which are part of the hardware (although not explicitly in
>> the devicetree) and can be probed
>> 2. things which we can only guess at
>> 3. grey area
>>
>> I am very happy with 1). It is just 2) that I want to avoid.
>>
>> The grey area is where your series adds lots of strings for different
>> hardware...that just seems like code-size bloat to me.
>>
>> How about working on a devicetree binding for this stuff? Or perhaps
>> add the info to the boards you care about?
>>
> What I planned to do is to have a general one for arm64, then all the arm64 boards missing the dt
> node can leverage it.
> Regarding to 2) you pointed out, maybe we can leave them to the dt later, my patch can go first with
> those architectural common stuffs, for example, cache information.
> I will think about it before posting the next version.

OK. Let's try to avoid tables of strings.

Regards,
Simon
