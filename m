Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA57D3A66B
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 15:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C6D89191;
	Tue, 29 Oct 2024 16:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HfmAIAZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DCA989191; Tue, 29 Oct 2024 16:46:02 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E97888EE1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so714501966b.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730216759; x=1730821559; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=96hyvaoLBSj0veUFqDGez7TllDUkIcB+heGROl3Th3M=;
 b=HfmAIAZI68GDoEE/SoDMlroPI4lRyY15awK3+kbugs2g8fJ2pXIcR6PgfwYmleU8Ab
 sMNzrrhW+IZ6F+Isb/sl8pT66DE664uy59AaSHPNLJQYX9R9CyM25wJPO8NhFX+w/0QW
 +c3jPKvwMNewcgNDdO2rGd0VZf+8phPSa+aow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730216759; x=1730821559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=96hyvaoLBSj0veUFqDGez7TllDUkIcB+heGROl3Th3M=;
 b=G1HDkX+JGPd1W/UrLUfRkUFpEHKQeBJdbvyhEMs1yZeqm0BF2VHUW5jiG0kFpi6AuZ
 tcPHKHr0AcKovweCg6Tnoe+NLbo/oiZVBrvLNsrvzz0txUmDgDZkB/vySl89dkPP1xY0
 LGjnp9k3xzM2lcGPwAdswtvvrZiRm0N+0prEWEc3JnCaHaCXF88ZwsksOCiTzFPY0Qah
 zy6dkzV+3frPgy/l1EiZJAExGXP/s88U16VCRbj6xx1zB98ZuO9jFyy9J54f0HUVJvTV
 rAEbfSLcUU57DBFaqVhHIh+8RPkEpemU90KW3x8NQ4pTfwE7DxrLaHyYIfbAiViRp/Dc
 I6+A==
X-Gm-Message-State: AOJu0Yw6NcyWk6QSmdfEts3dbjawGXczpmE5H8k2Aaijm+dNLxGkBuJS
 7HQKAGCxumx30ENa7P4uBCQYpp5eKnLDx8v4bWRA3u0MlC2wQi+X0oJJrw5+pIRGdoEnPa2qZta
 NqgYgh8ZRV+4tSgwL9PtJ/qGTkVpGhNFzuaF7
X-Google-Smtp-Source: AGHT+IEe0yQCT+h0qVTB2qwRCR3aPeAvOCbQybjwwPPLENaZplU06Mm1BS+QazYiAEpyCcb/gCgMs6Rp2jUXjauWgcE=
X-Received: by 2002:a17:907:3da8:b0:a99:4136:895f with SMTP id
 a640c23a62f3a-a9e3a6c7dc9mr18858166b.41.1730216759515; Tue, 29 Oct 2024
 08:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241022200543.116343-7-raymond.mao@linaro.org>
 <CAFLszTjY=BwM8jUk_uRp-PnNu7=cXTdw0=znJwS4XDooWmNJjg@mail.gmail.com>
 <CAEfUkULBfQNz5XwWU0oY4S9tPGrYf06yByaOj-tRiua0x7WfWQ@mail.gmail.com>
In-Reply-To: <CAEfUkULBfQNz5XwWU0oY4S9tPGrYf06yByaOj-tRiua0x7WfWQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Oct 2024 16:45:44 +0100
Message-ID: <CAFLszTijXQCcFo5k5y6G8KUYvQQOLGAYZzNe5GQkt9fpGBam1Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] armv8: Add generic smbios information into the
 device tree
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Stefan Roese <sr@denx.de>, Alexander Gendin <agendin@matrox.com>,
 Michal Simek <michal.simek@amd.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
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

On Mon, 28 Oct 2024 at 21:00, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Mon, 28 Oct 2024 at 13:05, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Raymond,
>>
>> On Tue, 22 Oct 2024 at 22:07, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > Add common smbios information that can be used by all armv8
>> > platforms and set it as default for qemu-arm64.
>> > From now smbios library can load values from here for those fields
>> > doesn't exist in the sysinfo driver.
>> >
>> > To run this with QEMU arm64, please dump the generated DTB
>> > from QEMU first, merge it with the one we build and then re-run
>> > QEMU with the merged DTB.
>> > ```
>> > qemu-system-arm -machine virt -machine dumpdtb=qemu.dtb
>> > cat  <(dtc -I dtb qemu.dtb) <(dtc -I dtb ./dts/dt.dtb | \
>> >   grep -v /dts-v1/) | dtc - -o merged.dtb
>> > qemu-system-arm -machine virt -nographic -bios u-boot.bin \
>> >   -dtb merged.dtb
>>
>> and please talk to Peter about accepting my patch[1]
>>
>>
>> > ```
>> > For details please take reference on dt_qemu.rst
>> >
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > ---
>> > Changes in v2
>> > - Initial patch.
>> >
>> >  arch/arm/dts/qemu-arm64.dts      |  4 ++
>> >  arch/arm/dts/smbios_generic.dtsi | 82 ++++++++++++++++++++++++++++++++
>> >  2 files changed, 86 insertions(+)
>> >  create mode 100644 arch/arm/dts/smbios_generic.dtsi
>> >
>> > diff --git a/arch/arm/dts/qemu-arm64.dts b/arch/arm/dts/qemu-arm64.dts
>> > index 096b3910728..95fcf53ed74 100644
>> > --- a/arch/arm/dts/qemu-arm64.dts
>> > +++ b/arch/arm/dts/qemu-arm64.dts
>> > @@ -7,5 +7,9 @@
>> >
>> >  /dts-v1/;
>> >
>> > +#if defined(CONFIG_SYSINFO_SMBIOS) && !defined(QFW_SMBIOS)
>> > +#include "smbios_generic.dtsi"
>> > +#endif
>> > +
>> >  / {
>> >  };
>> > diff --git a/arch/arm/dts/smbios_generic.dtsi b/arch/arm/dts/smbios_generic.dtsi
>> > new file mode 100644
>> > index 00000000000..c9f07283403
>> > --- /dev/null
>> > +++ b/arch/arm/dts/smbios_generic.dtsi
>> > @@ -0,0 +1,82 @@
>> > +// SPDX-License-Identifier: GPL-2.0+
>> > +/*
>> > + * Default SMBIOS information for Arm64 platforms
>> > + *
>> > + * Copyright (c) 2024 Linaro Limited
>> > + * Author: Raymond Mao <raymond.mao@linaro.org>
>> > + */
>> > +#include <config.h>
>> > +#include <smbios_def.h>
>> > +
>> > +/ {
>> > +       smbios {
>> > +               compatible = "u-boot,sysinfo-smbios";
>> > +
>> > +               smbios {
>> > +                       system {
>> > +                               manufacturer = CONFIG_SYS_VENDOR;
>> > +                               product = CONFIG_SYS_BOARD;
>> > +                               version = "Not Specified";
>> > +                               serial = "Not Specified";
>>
>> Does it make sense to add these strings? Perhaps if the property is missing in the DT, it should be missing in the SMBIOS table? Is 'Not Specified' a special string in the SMBIO spec?
>
>
> This is not defined in the spec and actually those strings can be anything.
> As currently this is for qemu_arm64 only and we don't have real vendor-defined values,
> "Not Specified" is used as a placeholder to show an example for other vendors if they
> want to add similar properties.

OK I see.

Reviewed-by: Simon Glass <sjg@chromium.org>
