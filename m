Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085E3E6F06C
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 16:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DA8B88E3C;
	Fri,  1 Nov 2024 17:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="odAsux8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F45F88DEA; Fri,  1 Nov 2024 17:23:48 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A27DA88E3C
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 17:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2ed59a35eso1717068a91.0
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730478224; x=1731083024; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gkw1Jjm93sAtReht/ioiasUx5Yzfff9nKnXwUXlP43Q=;
 b=odAsux8OYeVA8tQpA4GtVLOrj0FqiVD2r16jG9xqCPlPIEH3uzQlMPNnsmNsYY7AP2
 LZdQB3m5sajZ21ZB5j0X2wUo3v8uOG8/5GF4ICpRpBHXnmwe+h2uN1r00ACevmU2O29S
 1ntl/18ZsX5KF4rlZE/NOuU0oyU/Vv6BUo6RNRiu1hy0s1uOEACH0fZCzZgxeWMilUGD
 YwRqI52zwwand1m8MSdagFl10j0bcWxbpzqleLLUm393wZ7VP456KwFVZSJngsG4aYK4
 P6ORSjvQYLvU4yboFP9jUEE575ORQVHKYkAVo8tn7Id2qipqGiUA6IG0dSeR9WzMnT+f
 6BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730478224; x=1731083024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gkw1Jjm93sAtReht/ioiasUx5Yzfff9nKnXwUXlP43Q=;
 b=VyHC5Bi0QE7onixQoAJ6+gE5dIPbbBTHbJPlmkQ6tfPiZ+lQAnQ1P5+67Rq+XkMuWG
 swwyQmYioneVJruHjOxpk2cU6FCkZDTO0bqjA25rgRQQGFP4wLssbDaz2hMfSNXiFjsZ
 GOu9Aba0EFt22m1lJ46d4+72X4joTA3c/hHmPdSejcwWcvmsnHL41wPd99mDZMNKmyHo
 RuQCrKzEgbB26UiFxPokdhUh63LGmXJVVnVBE9zS6V0UcxqByddwdrDvIHxW82c7e2Ls
 5+2dy/bsID4e0rI/bsEwaU037VAAz5fY//KMnLyXk+ZvJ4owXJX+pOmuEIj+rL2nSUzy
 3GeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2oObTHdsDde137EXlkKUcaRzrgC2dsVMHBCEpzwsYfOXVs8HgRsM2dAdoRTuxCQNorZM6vJI=@lists.denx.de
X-Gm-Message-State: AOJu0YzvVj7dCOrPEi+yVtLyX8FV4vbLtfgsiQGmKmhZ2y4Xurw9hWAD
 jgykeUGlkOpCQdIU70wgCGiKajVUFsOR7XKM9N5UfWq/5L53yhmMc6KiU+X3bGOxW04d9rffJr7
 fWz7epovTACAzuw2dVFcq39hm/iZQoC4EYl0gTA==
X-Google-Smtp-Source: AGHT+IFub/G5QYowhrYQljkRBJdoSewC53gGC8K9Xo4j+qgeHh9S8XrrhFYKf8tQwz6C1C5STihqYTCCPdUY8Bj3hNc=
X-Received: by 2002:a17:90b:3e89:b0:2e2:c69b:669 with SMTP id
 98e67ed59e1d1-2e95dd7816bmr3503a91.27.1730478224067; Fri, 01 Nov 2024
 09:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241022200543.116343-7-raymond.mao@linaro.org>
 <CAFLszTjY=BwM8jUk_uRp-PnNu7=cXTdw0=znJwS4XDooWmNJjg@mail.gmail.com>
 <CAEfUkULBfQNz5XwWU0oY4S9tPGrYf06yByaOj-tRiua0x7WfWQ@mail.gmail.com>
 <CAFLszTijXQCcFo5k5y6G8KUYvQQOLGAYZzNe5GQkt9fpGBam1Q@mail.gmail.com>
 <6BCB1F10-588F-4BAB-9FED-1DBFF9273DB4@gmx.de>
In-Reply-To: <6BCB1F10-588F-4BAB-9FED-1DBFF9273DB4@gmx.de>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 1 Nov 2024 12:23:30 -0400
Message-ID: <CAEfUkUJgXATX0m8f9EvMxkoKW6C4QJX5XrR5=kojE+Vjp=3gdw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] armv8: Add generic smbios information into the
 device tree
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
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

Hi Heinrich,

On Fri, 1 Nov 2024 at 02:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

>
>
> Am 29. Oktober 2024 16:45:44 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >On Mon, 28 Oct 2024 at 21:00, Raymond Mao <raymond.mao@linaro.org> wrote:
> >>
> >> Hi Simon,
> >>
> >> On Mon, 28 Oct 2024 at 13:05, Simon Glass <sjg@chromium.org> wrote:
> >>>
> >>> Hi Raymond,
> >>>
> >>> On Tue, 22 Oct 2024 at 22:07, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> >>> >
> >>> > Add common smbios information that can be used by all armv8
> >>> > platforms and set it as default for qemu-arm64.
> >>> > From now smbios library can load values from here for those fields
> >>> > doesn't exist in the sysinfo driver.
> >>> >
> >>> > To run this with QEMU arm64, please dump the generated DTB
> >>> > from QEMU first, merge it with the one we build and then re-run
> >>> > QEMU with the merged DTB.
> >>> > ```
> >>> > qemu-system-arm -machine virt -machine dumpdtb=qemu.dtb
> >>> > cat  <(dtc -I dtb qemu.dtb) <(dtc -I dtb ./dts/dt.dtb | \
> >>> >   grep -v /dts-v1/) | dtc - -o merged.dtb
> >>> > qemu-system-arm -machine virt -nographic -bios u-boot.bin \
> >>> >   -dtb merged.dtb
> >>>
> >>> and please talk to Peter about accepting my patch[1]
> >>>
> >>>
> >>> > ```
> >>> > For details please take reference on dt_qemu.rst
> >>> >
> >>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >>> > ---
> >>> > Changes in v2
> >>> > - Initial patch.
> >>> >
> >>> >  arch/arm/dts/qemu-arm64.dts      |  4 ++
> >>> >  arch/arm/dts/smbios_generic.dtsi | 82
> ++++++++++++++++++++++++++++++++
> >>> >  2 files changed, 86 insertions(+)
> >>> >  create mode 100644 arch/arm/dts/smbios_generic.dtsi
> >>> >
> >>> > diff --git a/arch/arm/dts/qemu-arm64.dts
> b/arch/arm/dts/qemu-arm64.dts
> >>> > index 096b3910728..95fcf53ed74 100644
> >>> > --- a/arch/arm/dts/qemu-arm64.dts
> >>> > +++ b/arch/arm/dts/qemu-arm64.dts
> >>> > @@ -7,5 +7,9 @@
> >>> >
> >>> >  /dts-v1/;
> >>> >
> >>> > +#if defined(CONFIG_SYSINFO_SMBIOS) && !defined(QFW_SMBIOS)
> >>> > +#include "smbios_generic.dtsi"
> >>> > +#endif
> >>> > +
> >>> >  / {
> >>> >  };
> >>> > diff --git a/arch/arm/dts/smbios_generic.dtsi
> b/arch/arm/dts/smbios_generic.dtsi
> >>> > new file mode 100644
> >>> > index 00000000000..c9f07283403
> >>> > --- /dev/null
> >>> > +++ b/arch/arm/dts/smbios_generic.dtsi
> >>> > @@ -0,0 +1,82 @@
> >>> > +// SPDX-License-Identifier: GPL-2.0+
> >>> > +/*
> >>> > + * Default SMBIOS information for Arm64 platforms
> >>> > + *
> >>> > + * Copyright (c) 2024 Linaro Limited
> >>> > + * Author: Raymond Mao <raymond.mao@linaro.org>
> >>> > + */
> >>> > +#include <config.h>
> >>> > +#include <smbios_def.h>
> >>> > +
> >>> > +/ {
> >>> > +       smbios {
> >>> > +               compatible = "u-boot,sysinfo-smbios";
> >>> > +
> >>> > +               smbios {
> >>> > +                       system {
> >>> > +                               manufacturer = CONFIG_SYS_VENDOR;
> >>> > +                               product = CONFIG_SYS_BOARD;
> >>> > +                               version = "Not Specified";
> >>> > +                               serial = "Not Specified";
> >>>
> >>> Does it make sense to add these strings? Perhaps if the property is
> missing in the DT, it should be missing in the SMBIOS table? Is 'Not
> Specified' a special string in the SMBIO spec?
> >>
>
> The spec says:
>
> "If a string field references no string, a null (0) is placed in  that
> string field."
>
> Please, remove the 'Not specified' values from the patch and do not
> provide any property value in the device-tree instead.
>
> OK, I will remove all 'Not specified' in the next version.

Regards,
Raymond
