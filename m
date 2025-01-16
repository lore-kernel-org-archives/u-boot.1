Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5A3C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 22:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D85F8033D;
	Thu, 16 Jan 2025 23:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="FjQgWMZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FD7C8069D; Thu, 16 Jan 2025 23:47:58 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3AC68022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 23:47:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so2676025276.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 14:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1737067675; x=1737672475; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Ts9u7wtAGb7SfeGnYQx7ESCA2DC/iC6d0nlUfQ+Vtc=;
 b=FjQgWMZgr0AQv+YLGLFnCGYbNOdWeIeIykXtdAfg8acZJBG38CEHAMA4amK9ql35jK
 Wbi6HGEzWT/xapI6VRy93A9wArvoM7Quyu1wo6C3ybbHK4o7QqEycuZ1rbL1sCfS4cSr
 5XyeNEwuSIKukevUnUcIbdjNdamJUfexkGhuW/bYxN9k7k+YyyGWSTjBeRgtZ1sh7IiZ
 lEFkVv5l/PIqWYrknEbpYbFrx5h1ckmPSwQBeI6Tm1UuFr7Qwq+ML0b8Yq79tUQD7cfY
 7yqDkuj5SVKvPl0bL+zms3x7eF/YGfQLu7atgVnH+qDSwh9oGjw9BfAOFn5ABYeJWvfi
 whZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737067675; x=1737672475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Ts9u7wtAGb7SfeGnYQx7ESCA2DC/iC6d0nlUfQ+Vtc=;
 b=LP7A3MOZKodCbUMp5JFl3Ug+RUJABs5Z401Bd7G33wAUrQrr5gkhsAjYAQEkt6A0tt
 gX6I9fXofy9x/aq3s5Keug7PgeNbQPq6nq+QLhlqFDo10NkiKVcXJn2ZUfIBhLMeNqHU
 Sn3y3TuBYykeObg+giHPJ/o1Er+X/xCmhO+s5bNMi1WxCyW34ihpb/te1rfcqJ9f7ZwB
 2pfnGM8x7/jvk51EOX+uU4KGdHLthC+fiZCpeLmHPLsGDHGa+6kr9uDPoTns7sx/o5B1
 QIi1ujAVIP1IqWRiN8WlN9Er8JC8x2l+XpPWjn/gVDgRjEn2B7Ff59OHOU6GV2gnMkVI
 DSVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwmafo9ek+oePjjzJ9OMwid+1jMJw9ujiZTQVa2iS2wlmIxjZxu1JRFIWWqb/DCHpHJVQa9eI=@lists.denx.de
X-Gm-Message-State: AOJu0YxizS2nJMi4tMjbytabnmuom6y1qjndnMjjy+LcXDP+hJHomeD7
 KKKokf5VFModR1B31O8wmHF1qU0BdAr913s8EL6SULllp6nX/Ptu1CKp4pORyskPMVCYXKy6TvR
 wU0eb+dpF0HPlqs1ech2Mqv6UiDw82c4eUQDq0g==
X-Gm-Gg: ASbGnctPT63hQlCKuzQVkPJ8HUlcjgP3D4jvzDUHfaPJ3ZQa5W/3k9lLSOOEQDkKvOY
 YLllhLAgRP4kM41c6indlNIKyl7I6xp+qXMnd1A==
X-Google-Smtp-Source: AGHT+IF0OYQ2PfxwBL2coDlKeL4vHpwmA+Bowis6mbQhBINxg/nvwB/djJscodNRMxz9+IQEHfzMIMeblVm3kP/nDsM=
X-Received: by 2002:a05:6902:2b8d:b0:e57:879b:2b2d with SMTP id
 3f1490d57ef6-e57b1047493mr206018276.8.1737067674724; Thu, 16 Jan 2025
 14:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-20-93b28a514dea@oss.nxp.com>
 <CAJ+vNU0_GWaVtwiWw3Mt1J6jc57XgDWOehdzrPhfTAg+gJq4oA@mail.gmail.com>
 <CAJ+vNU2QytTfGuHcnY8QfoLBvxCxcMP4fKqvPYaM8w_rX-czkA@mail.gmail.com>
In-Reply-To: <CAJ+vNU2QytTfGuHcnY8QfoLBvxCxcMP4fKqvPYaM8w_rX-czkA@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 16 Jan 2025 14:47:43 -0800
X-Gm-Features: AbW1kvbZK4PICuh4QnJiBP7drnIVNTl_JZSPcvjg9_HbcxBrDUTjBtsPZRUYchU
Message-ID: <CAJ+vNU1tUEvcFQdcEsdmuTiNe=J3=C1pqum=qvmKnstNz7Ci6g@mail.gmail.com>
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

On Thu, Jan 16, 2025 at 11:42=E2=80=AFAM Tim Harvey <tharvey@gateworks.com>=
 wrote:
>
> On Thu, Jan 16, 2025 at 11:38=E2=80=AFAM Tim Harvey <tharvey@gateworks.co=
m> wrote:
> >
> > On Wed, Jan 15, 2025 at 5:30=E2=80=AFAM Alice Guo <alice.guo@oss.nxp.co=
m> wrote:
> > >
> > > From: Ye Li <ye.li@nxp.com>
> > >
> > > This patch adds i.MX95 19x19 EVK board basic support.
> > >
> > > Messaging unit for EdgeLock Secure Enclave, messaging unit for System
> > > Manager, uSDHC for SD Card, gpio, lpuart are supported now.
> > >
> > > Signed-off-by: Ye Li <ye.li@nxp.com>
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > <snip...>
> > > diff --git a/board/freescale/imx95_evk/imx95_evk.c b/board/freescale/=
imx95_evk/imx95_evk.c
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..1ed15ca47b157067a7376=
b0b32101dc7f9899f4f
> > > --- /dev/null
> > > +++ b/board/freescale/imx95_evk/imx95_evk.c
> > > @@ -0,0 +1,54 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright 2025 NXP
> > > + */
> > > +
> > > +#include <env.h>
> > > +#include <init.h>
> > > +#include <asm/global_data.h>
> > > +#include <asm/arch-imx9/ccm_regs.h>
> > > +#include <asm/arch/clock.h>
> > > +#include <fdt_support.h>
> > > +#include <asm/io.h>
> > > +#include <linux/bitfield.h>
> > > +#include <linux/bitops.h>
> > > +#include <linux/delay.h>
> > > +#include <miiphy.h>
> > > +#include <netdev.h>
> > > +#include <asm/gpio.h>
> > > +#include <asm/mach-imx/sys_proto.h>
> > > +#include <scmi_agent.h>
> > > +#include <scmi_protocols.h>
> > > +#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
> > > +#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"
> >
> > Hi Alice,
> >
> > Most of the above are not needed (and should be alphabetized anyway)
> >
> > The only ones needed are:
> > #include <asm/arch/clock.h>
> > #include <asm/gpio.h>
> > #include <asm/mach-imx/sys_proto.h>
> >
> > > +
> > > +DECLARE_GLOBAL_DATA_PTR;
> >
> > not needed as you don't use gd
> >
> > Best Regards,
> >
> > Tim
>
> Hi Alic,
>
> One more thing to do for next series. Refresh your
> imx95_19x19_evk_defconfig as its very out of sync:
>
> make imx95_19x19_evk_defconfig
> make savedefconfig
> cp defconfig configs/imx95_19x19_evk_defconfig
>

Hi Alice,

I'm also seeing the following files left around after a build that are
also not removed after a clean/distclean:
        mkimage-out.imx-boot.spl
        mkimage-out.imx-boot.u-boot
        mkimage.imx-boot.spl
        mkimage.imx-boot.u-boot

Best Regards,

Tim
