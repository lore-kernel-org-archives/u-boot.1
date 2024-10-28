Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784F3D3E2C2
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 20:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F2F3890BF;
	Mon, 28 Oct 2024 21:00:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n+lTiXr9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34AB98909F; Mon, 28 Oct 2024 21:00:38 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2A97890BF
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 21:00:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e31af47681so3734854a91.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730145634; x=1730750434; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tb0LSW2I82PbyYA9VC8oRpFe3M/gSp46/aCLTEIn0J0=;
 b=n+lTiXr9J9QKfQBXPYYrITEAh+4AXBdZeMMfs77RrSV/vYsaqaSIMa3oeBcJw0G4XP
 JOdILEFyAZHklbGAeI5qX2zv1e7jZmF4Hk40D1C5OH55H/TWp2tuBNWvBOlKnl4phpXD
 PBakAHB2Gly/Xl5NSXqtWnTYm4lMLhXh0oH8NjpiD/1XzShJfrtORVZYcGI0vAPLyLsy
 Dn6/9dKbk/V/9mPsgHqj0acDCiqkOnGIZqr9lJ5KZbRgTp2p5Oumj6DggPbDvptaQUoW
 tpsrE1Ls5dv3xb3rp16bAVjBBwqch9A5rD6gtBjohK3sUJ+jcobATKvH/OTg4jj+r+tQ
 7nWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730145634; x=1730750434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tb0LSW2I82PbyYA9VC8oRpFe3M/gSp46/aCLTEIn0J0=;
 b=Ml/EoOwgOF/1GdPYQ0mzkz7+C5OlRLiSGSEaCjEHoIn9hQlA7Rw0zS+B22VLd0Xc72
 4YEILog4nN9SnJIIUITDKCx9aKmKs1an3EupjBio5tHUUpoOdB7U7kUNFrsXmciDodIz
 o3zvff0TD3NzUKh3kIbevTnO8y794nWfpYJH7c+bQaGOSGivtBoBhuCmPVmN2kC0jnFC
 svWvyGugL9PGIr7CzQa/JK17+Pf2t5b0sytt9oMS5gaFHcS0Lf3CZ3hfMCtR3L7i6ZQx
 x/TBOQJUZR7q8VpvbzUISgbkOrFWxg3G+jm+HsDYFuVZD3IJEe6p+K9o4fSnmsDDa19a
 VxnA==
X-Gm-Message-State: AOJu0YzqJ9BXOcGtupO4NMTtyl0HGHxZfQcaLZawafP84Y/tQ0CUrQxA
 1mc/GTCrNVqc+RutbJqBk/QQ045cpMPLawZpJLdr35eeQTcVJo4EaeYwY98SOEZhAXvmSKAwnhU
 ZtVrSyHre82QSWrtsw6XEd8TYsphCJySQ/z8PDcDH2ruQ7GttIdIgpA==
X-Google-Smtp-Source: AGHT+IGFodIL/lTti2AITjb1dSRNL105wsx6T1nUkJZWkURWO0Xd7/eDk9Qo7KUvEK1DfCD0MjhQHNzHGayZHAIw6xA=
X-Received: by 2002:a17:90a:ca07:b0:2e2:e597:6cdc with SMTP id
 98e67ed59e1d1-2e8f107c680mr11468917a91.22.1730145634058; Mon, 28 Oct 2024
 13:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241022200543.116343-7-raymond.mao@linaro.org>
 <CAFLszTjY=BwM8jUk_uRp-PnNu7=cXTdw0=znJwS4XDooWmNJjg@mail.gmail.com>
In-Reply-To: <CAFLszTjY=BwM8jUk_uRp-PnNu7=cXTdw0=znJwS4XDooWmNJjg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 28 Oct 2024 16:00:22 -0400
Message-ID: <CAEfUkULBfQNz5XwWU0oY4S9tPGrYf06yByaOj-tRiua0x7WfWQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] armv8: Add generic smbios information into the
 device tree
To: Simon Glass <sjg@chromium.org>
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

On Mon, 28 Oct 2024 at 13:05, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Tue, 22 Oct 2024 at 22:07, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Add common smbios information that can be used by all armv8
> > platforms and set it as default for qemu-arm64.
> > From now smbios library can load values from here for those fields
> > doesn't exist in the sysinfo driver.
> >
> > To run this with QEMU arm64, please dump the generated DTB
> > from QEMU first, merge it with the one we build and then re-run
> > QEMU with the merged DTB.
> > ```
> > qemu-system-arm -machine virt -machine dumpdtb=qemu.dtb
> > cat  <(dtc -I dtb qemu.dtb) <(dtc -I dtb ./dts/dt.dtb | \
> >   grep -v /dts-v1/) | dtc - -o merged.dtb
> > qemu-system-arm -machine virt -nographic -bios u-boot.bin \
> >   -dtb merged.dtb
>
> and please talk to Peter about accepting my patch[1]
>
>
> > ```
> > For details please take reference on dt_qemu.rst
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Initial patch.
> >
> >  arch/arm/dts/qemu-arm64.dts      |  4 ++
> >  arch/arm/dts/smbios_generic.dtsi | 82 ++++++++++++++++++++++++++++++++
> >  2 files changed, 86 insertions(+)
> >  create mode 100644 arch/arm/dts/smbios_generic.dtsi
> >
> > diff --git a/arch/arm/dts/qemu-arm64.dts b/arch/arm/dts/qemu-arm64.dts
> > index 096b3910728..95fcf53ed74 100644
> > --- a/arch/arm/dts/qemu-arm64.dts
> > +++ b/arch/arm/dts/qemu-arm64.dts
> > @@ -7,5 +7,9 @@
> >
> >  /dts-v1/;
> >
> > +#if defined(CONFIG_SYSINFO_SMBIOS) && !defined(QFW_SMBIOS)
> > +#include "smbios_generic.dtsi"
> > +#endif
> > +
> >  / {
> >  };
> > diff --git a/arch/arm/dts/smbios_generic.dtsi
> b/arch/arm/dts/smbios_generic.dtsi
> > new file mode 100644
> > index 00000000000..c9f07283403
> > --- /dev/null
> > +++ b/arch/arm/dts/smbios_generic.dtsi
> > @@ -0,0 +1,82 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Default SMBIOS information for Arm64 platforms
> > + *
> > + * Copyright (c) 2024 Linaro Limited
> > + * Author: Raymond Mao <raymond.mao@linaro.org>
> > + */
> > +#include <config.h>
> > +#include <smbios_def.h>
> > +
> > +/ {
> > +       smbios {
> > +               compatible = "u-boot,sysinfo-smbios";
> > +
> > +               smbios {
> > +                       system {
> > +                               manufacturer = CONFIG_SYS_VENDOR;
> > +                               product = CONFIG_SYS_BOARD;
> > +                               version = "Not Specified";
> > +                               serial = "Not Specified";
>
> Does it make sense to add these strings? Perhaps if the property is
> missing in the DT, it should be missing in the SMBIOS table? Is 'Not
> Specified' a special string in the SMBIO spec?
>

This is not defined in the spec and actually those strings can be anything.
As currently this is for qemu_arm64 only and we don't have real
vendor-defined values,
"Not Specified" is used as a placeholder to show an example for other
vendors if they
want to add similar properties.

Regards,
Raymond
