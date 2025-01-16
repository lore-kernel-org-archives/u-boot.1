Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6D7C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 19:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7259C8033D;
	Thu, 16 Jan 2025 20:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="DhBlVwBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE89D8069D; Thu, 16 Jan 2025 20:42:20 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60F8F8022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 20:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e53c9035003so2222348276.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1737056537; x=1737661337; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/LA0S8I4a4XdixVIUZdiX9FSt3S0VXI7PxykTA5apWg=;
 b=DhBlVwBVr10qNQTlx/1GkVGXPONc9DD+MVBZh0oVL+4gjV2klzFYrFOZg8Ddx9Th/i
 A+amQfbYR/71hLH9tB0Ut9BVmbynkF/VBK1m9TKZtsmIaFoC11+/nkvzetJbeCwZ7zwd
 luRfquasPRkjQuihxQ8eFhlOVlWvwWcB/j3+LO2hYlHa/FEaF1IBq+zv1wOHXtxO3StK
 DS+Vskp4Vmq5XwzZ2LTl6pm0XhSt1vlMwBik6QpioH6s+Ntg/qukt7rubMrijgvU7PPm
 H/3zG5flqyFslMLC4Nykz4U54MzSth0mKo9CDcoSH4Gy6idOL0NqFIhLUYdJkt7/z+Eo
 P0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737056537; x=1737661337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/LA0S8I4a4XdixVIUZdiX9FSt3S0VXI7PxykTA5apWg=;
 b=KyElXBG3T9cif3Ht3kh0b14xm+weIxYTYAixbsI15zPdL/PLnloZ1qpBY94AXKx9hb
 BiUgpR4Lw3a/YImr1jstwfBpGHIsJVmfOs8uVlvTth1vx4AtQCYKrdKRFdzepEp+cW/u
 D14bLrcAUZSo5wp127s79EtKpMBnSCvsWNAo8cgjHW0eChN9VURB6HY7/jmM3iaZf619
 pFmt5L9eclEUghG4Qobj4em7WI2xnqxcguOPU+Fzfm3LBHfWhOxj/X7JOm+q8Yt+NXqj
 epwiOtTIH++vK8B90Nv6MCpjuzgcaHmFfzXNyg3LnIgFwaPmNuFjVr76W3mhMSfOwb21
 LHNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAkBIo9NMyGi0Xx8y8O8DhfwoFmmBHVmsQJgO1/U1/xgBnxcNgmHMIZQ/oORrgjkYKc4X8qek=@lists.denx.de
X-Gm-Message-State: AOJu0Yymx5SmDVZYZ5djOr3nltacUfhi33T2NzraAvh5bieNdDPPvDdf
 o3cKWhyQ8wj8u6szAEUYS1Cik1L2y2g7P59MkSiRh4rRGOiGLYKsHZIzvhEJDpsHvyGOlqGhsRk
 FeXZTjke2eYCZUBMWFISJgpMxp86ySr/E0CQNQg==
X-Gm-Gg: ASbGnctYzHgzqyRT102Jaqcj4Fa9bfRcgo1jWhFmbf834ZJq8ZZdELjdS0ovO1+SvDe
 W44CD36YFEdTB48DgJjNmlV+jMkIlAJqb6d9gEg==
X-Google-Smtp-Source: AGHT+IGV4/ru8Kaus0C1Rd7jB6itxpEOkpmRgLXPZm8P0AWXcUldcpbfaVDWn1uVN/xsuGwoJ5P4i9DZybqZHF0PBhY=
X-Received: by 2002:a05:6902:10c6:b0:e57:89cf:775 with SMTP id
 3f1490d57ef6-e5789cf1db0mr7339968276.30.1737056537132; Thu, 16 Jan 2025
 11:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-20-93b28a514dea@oss.nxp.com>
 <CAJ+vNU0_GWaVtwiWw3Mt1J6jc57XgDWOehdzrPhfTAg+gJq4oA@mail.gmail.com>
In-Reply-To: <CAJ+vNU0_GWaVtwiWw3Mt1J6jc57XgDWOehdzrPhfTAg+gJq4oA@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 16 Jan 2025 11:42:06 -0800
X-Gm-Features: AbW1kvby_Q55I9LA1N_Nu_lYtNxEy5VFVRaAt2-V25qpfq3zlS353mqfs-Bcu_M
Message-ID: <CAJ+vNU2QytTfGuHcnY8QfoLBvxCxcMP4fKqvPYaM8w_rX-czkA@mail.gmail.com>
Subject: Re: [PATCH v4 20/20] imx95_evk: add i.MX95 19x19 EVK board basic
 support
To: Alice Guo <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de,
 u-boot@lists.denx.de, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jan 16, 2025 at 11:38=E2=80=AFAM Tim Harvey <tharvey@gateworks.com>=
 wrote:
>
> On Wed, Jan 15, 2025 at 5:30=E2=80=AFAM Alice Guo <alice.guo@oss.nxp.com>=
 wrote:
> >
> > From: Ye Li <ye.li@nxp.com>
> >
> > This patch adds i.MX95 19x19 EVK board basic support.
> >
> > Messaging unit for EdgeLock Secure Enclave, messaging unit for System
> > Manager, uSDHC for SD Card, gpio, lpuart are supported now.
> >
> > Signed-off-by: Ye Li <ye.li@nxp.com>
> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > ---
> <snip...>
> > diff --git a/board/freescale/imx95_evk/imx95_evk.c b/board/freescale/im=
x95_evk/imx95_evk.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..1ed15ca47b157067a7376b0=
b32101dc7f9899f4f
> > --- /dev/null
> > +++ b/board/freescale/imx95_evk/imx95_evk.c
> > @@ -0,0 +1,54 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2025 NXP
> > + */
> > +
> > +#include <env.h>
> > +#include <init.h>
> > +#include <asm/global_data.h>
> > +#include <asm/arch-imx9/ccm_regs.h>
> > +#include <asm/arch/clock.h>
> > +#include <fdt_support.h>
> > +#include <asm/io.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <miiphy.h>
> > +#include <netdev.h>
> > +#include <asm/gpio.h>
> > +#include <asm/mach-imx/sys_proto.h>
> > +#include <scmi_agent.h>
> > +#include <scmi_protocols.h>
> > +#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
> > +#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"
>
> Hi Alice,
>
> Most of the above are not needed (and should be alphabetized anyway)
>
> The only ones needed are:
> #include <asm/arch/clock.h>
> #include <asm/gpio.h>
> #include <asm/mach-imx/sys_proto.h>
>
> > +
> > +DECLARE_GLOBAL_DATA_PTR;
>
> not needed as you don't use gd
>
> Best Regards,
>
> Tim

Hi Alic,

One more thing to do for next series. Refresh your
imx95_19x19_evk_defconfig as its very out of sync:

make imx95_19x19_evk_defconfig
make savedefconfig
cp defconfig configs/imx95_19x19_evk_defconfig

Best Regards,

Tim
