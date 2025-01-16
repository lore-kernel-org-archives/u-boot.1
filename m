Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BD2C02188
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 19:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 670188033D;
	Thu, 16 Jan 2025 20:38:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Vt1PndFx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEB978069D; Thu, 16 Jan 2025 20:38:44 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E46D98022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 20:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso2264313276.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1737056320; x=1737661120; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyzfJrbvY6bT3T8AlQy3hqNq+sty85MyvomFHv1oKsc=;
 b=Vt1PndFxRu5Nsn93iEROoE0GoLY480j+uNyjP4Xgeyx9O2BlVo21u1jv1buTRp7rat
 VUipQNkJicYFQ/fSRyuu6KoviPIpJGxQ+H/avXf7dwwdrCOo7DI9coqsKAwNld9H9ZKv
 3nKv3UfVp65NA3CD7v6Twn1t/NDziLfdXat7v5Nk/4PlRO3bwVx7oLz6IHLit9sHZG+v
 uZpZejVnvj2pcSHgJy2u8KXRfCXyFpX79A0nGs5Er8P9DK6+3vKZTp2gbXe91Zjhvec2
 AkTYaXrXUY09RyxA+SEkXYYRh/Xvgxz4i0ROY0+6dIx1e95bL2wq5qqIeyjmck0XmoA0
 EWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737056320; x=1737661120;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyzfJrbvY6bT3T8AlQy3hqNq+sty85MyvomFHv1oKsc=;
 b=OJW1bo2567fkhUcRTI7np5Yjh2zMdS+6onRMYxURM2kwWy0fxCxEABJraad3aRQP+q
 qnnssrPZNW7VRrDAx3pGj2fK4IOIkzGg4wuVR18K2Utd7sv7EfB98DegsLYphuQk08V4
 3AUWAJFbwrz38WNIbFffUe2O6gjKD/uWo4iFErawH6wLiMud8TRLx5tHoMaAoi/0oCdw
 3UjRNnnFyS7PKA0ds+TSDXX4TN2XH2lnJnmAzLnAw8EHWQEVRe5LCA22vYGQHTz4w8Ro
 sthvq3xBuhn9m4+1ubZCWvu3rXcGunIEzu9Uzp1AK1jl2o1p9vv9TI3xnmqXSHm+4sJO
 6+zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTLZsrkJfY6RY/t2qxKbk1MjoUIISzbbwR7jsRfTZPj/yrFu4aBaILlsbWr5BmA5EugGL742A=@lists.denx.de
X-Gm-Message-State: AOJu0Yyhgo3FiHiX+qF5J60KXvKQI5U8Hu4hg2lM/mdu9SmVcluF3M5M
 cuGkm4D5wAK+FleTSZm/4FF2HG+g7eR/gLllMv6tEnP/ad0/8oa6/S6L+6N1ApSUm1m6pe6aVGD
 E8eTRC2Z04tnoNauFCa5OgCCmhFLBzFygKEPQIA==
X-Gm-Gg: ASbGnctkjzJhPbk5l6ODR49OxifcfZiAVSQQsX+WSZyI5Rn2z+N0mXr0rpQvd/mE/yV
 4VIYpvRpCrU7mq2TaYo49bA97xWUQyKPVxV4CKQ==
X-Google-Smtp-Source: AGHT+IGPAkY4+3joDXJKX1vT/qXa9tyYau8KtsFITrLbJNrac+7iVCPF2idGMMowCPgMDczCSg3SX4Lwn9B4waMYkUA=
X-Received: by 2002:a25:6d57:0:b0:e4b:cf66:8968 with SMTP id
 3f1490d57ef6-e54ee2348demr19531632276.45.1737056320464; Thu, 16 Jan 2025
 11:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-20-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-20-93b28a514dea@oss.nxp.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 16 Jan 2025 11:38:29 -0800
X-Gm-Features: AbW1kvZZtsK3o63qd7ldbs8wI0y37Aok4BhGzEo9TF3xL6xefKe_Ngsp4tz8pkk
Message-ID: <CAJ+vNU0_GWaVtwiWw3Mt1J6jc57XgDWOehdzrPhfTAg+gJq4oA@mail.gmail.com>
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

On Wed, Jan 15, 2025 at 5:30=E2=80=AFAM Alice Guo <alice.guo@oss.nxp.com> w=
rote:
>
> From: Ye Li <ye.li@nxp.com>
>
> This patch adds i.MX95 19x19 EVK board basic support.
>
> Messaging unit for EdgeLock Secure Enclave, messaging unit for System
> Manager, uSDHC for SD Card, gpio, lpuart are supported now.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
<snip...>
> diff --git a/board/freescale/imx95_evk/imx95_evk.c b/board/freescale/imx9=
5_evk/imx95_evk.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..1ed15ca47b157067a7376b0b3=
2101dc7f9899f4f
> --- /dev/null
> +++ b/board/freescale/imx95_evk/imx95_evk.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <env.h>
> +#include <init.h>
> +#include <asm/global_data.h>
> +#include <asm/arch-imx9/ccm_regs.h>
> +#include <asm/arch/clock.h>
> +#include <fdt_support.h>
> +#include <asm/io.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <miiphy.h>
> +#include <netdev.h>
> +#include <asm/gpio.h>
> +#include <asm/mach-imx/sys_proto.h>
> +#include <scmi_agent.h>
> +#include <scmi_protocols.h>
> +#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
> +#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"

Hi Alice,

Most of the above are not needed (and should be alphabetized anyway)

The only ones needed are:
#include <asm/arch/clock.h>
#include <asm/gpio.h>
#include <asm/mach-imx/sys_proto.h>

> +
> +DECLARE_GLOBAL_DATA_PTR;

not needed as you don't use gd

Best Regards,

Tim
