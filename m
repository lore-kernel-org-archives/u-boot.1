Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8843E77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 23:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE54E8031D;
	Fri,  3 Jan 2025 00:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="PXh2Jsxk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A32A8034E; Fri,  3 Jan 2025 00:13:11 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A233802EF
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 00:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e545c1e8a15so3658685276.1
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 15:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1735859587; x=1736464387; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AjqZ14zlrHhwfL+qEM3HEbmvT5pSZ9uipuIOIXKbLys=;
 b=PXh2Jsxk/Zppi64cQzvadION0tyhE6HhyXoc+FbBRqs/ktagdlBKlaaqg9rRznxSDi
 dhb5NpOj6vUomaq/WHh0YLzBzvEK0CPNio+/KN5AEC1pb+fZ8l9FiJtGEG0etBPoa3CA
 jmmHsF0xOwGMDEFn3FkYByf5V3HTe/4P3Amn0rPVzOKvCyEgTxD125CY4LAcus2aVrba
 5ma4bCIAvbOvyPNMFsNP8Q9ke2CR/qRdvNfF8QkzbXR/CibpxT3bIPb1uL2c0Ccnahnf
 yOwHoR65OMOl9/Hpx9KBc13QzFiCufYqKBCNxhvpl1vX1XxGqAXUR/fGpfzCusquww45
 wrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735859587; x=1736464387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AjqZ14zlrHhwfL+qEM3HEbmvT5pSZ9uipuIOIXKbLys=;
 b=FHYnNQRgMbBoLq2Zjdidac5I9V+6rLZIXa3q+7dWIlU98/p5m2glhEFJXi1tQjr81e
 3MHBooTZaFkWP03k/TNzomoLvDdsbVapKsx84EJiP9NUg5T7SmDj8qxGy8UBb4bJmxzu
 zIW8kenmzDShKAxtPENJJ6A61UO75f7JhFKn0UBGvZ7WUkKTumJwxMsQD7+ds8btwIrA
 efHXVdhPrRMw15TWgANML4kFVHGeOTaa69arsM1qO5qxAPPKcMS6+th346oz4g/R4Foh
 38+Ww/kn8p1oVKJztddb0g0pU8yW38BZjQ1IjB6QmG4dR+FMDRCBsi71O7zn8qjH/47D
 8bwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm8UNR98L/7OXJJPjwf3tfCiqg88XLdAa3pSX00JYYPApglLy2X/kFfNeAPizVEHOBYphcxSE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+3utc2cf7x+ffs/XDnM4L3I8QX7CAHlKb94cPjwnfTg5siGsf
 nwat3FV6QjUIETTy2qbbZK+ok7RUo4rnqS57tmAsvp4txBpw2bH/LpWTre6SMk9N+prq0FF7sKL
 7NGN/VJTWMqIcOywdbJFFPNl/Azz8D8XP7sqjrg==
X-Gm-Gg: ASbGnctsYqYdD+8xPxv7RhZ/jLo3lE/9N2W8qrjxfo8mLtGkFZ8nJnEHpaDM5nBY6U1
 SKZu8m+nz510W10dsLUqhwJpkuhgiK19+b+vZTw==
X-Google-Smtp-Source: AGHT+IHn6ibhha9rZCi4EiidCnYX3qb9NL43gq6qO3/jKK8BP441FI5kYbwYhj40Ujca4kscEkRRw54hkpbavhnbG9g=
X-Received: by 2002:a05:690c:883:b0:6ee:988b:16d4 with SMTP id
 00721157ae682-6f3f82199fbmr384856267b3.29.1735859587233; Thu, 02 Jan 2025
 15:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
 <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 2 Jan 2025 15:12:56 -0800
Message-ID: <CAJ+vNU3p8T5VDoRcxuxvM_dzLK0dRzixUsb1nQp-WoN89VMhkg@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] imx95_evk: add i.MX95 19x19 EVK board basic
 support
To: Alice Guo <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de,
 marex@denx.de, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
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

On Thu, Dec 19, 2024 at 6:57=E2=80=AFPM Alice Guo <alice.guo@oss.nxp.com> w=
rote:
>
> From: Ye Li <ye.li@nxp.com>
>
> This patch adds i.MX95 19x19 EVK board basic support.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      | 224 ++++++++++++++++++++=
++++++
>  arch/arm/mach-imx/imx9/Kconfig                |   6 +
>  arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 ++
>  arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 ++
>  arch/arm/mach-imx/imx9/scmi/soc.c             |   1 +
>  board/freescale/imx95_evk/Kconfig             |  12 ++
>  board/freescale/imx95_evk/MAINTAINERS         |   6 +
>  board/freescale/imx95_evk/Makefile            |  11 ++
>  board/freescale/imx95_evk/imx95_19x19_evk.env |  95 +++++++++++
>  board/freescale/imx95_evk/imx95_evk.c         |  54 +++++++
>  board/freescale/imx95_evk/spl.c               | 117 ++++++++++++++
>  configs/imx95_19x19_evk_defconfig             | 178 ++++++++++++++++++++
>  doc/board/nxp/imx95_evk.rst                   | 109 +++++++++++++
>  doc/board/nxp/index.rst                       |   1 +
>  include/configs/imx95_evk.h                   |  36 +++++
>  15 files changed, 875 insertions(+)
>

Hi Alice,

I found some issues with imx95_19x19_evk.env (see below)

<snip>
> diff --git a/board/freescale/imx95_evk/imx95_19x19_evk.env b/board/freesc=
ale/imx95_evk/imx95_19x19_evk.env
> new file mode 100644
> index 0000000000000000000000000000000000000000..27e09d3d70a068efb97d69b27=
089d1f213f39ee9
> --- /dev/null
> +++ b/board/freescale/imx95_evk/imx95_19x19_evk.env
> @@ -0,0 +1,95 @@
> +sec_boot=3Dno
> +initrd_addr=3D0x93800000
> +emmc_dev=3D0
> +sd_dev=3D1
> +prepare_mcore=3Dsetenv mcore_clk clk-imx95.mcore_booted

I see where mcore_clk is used but nothing uses prepare_mcore. Also
there is no upstream Linux clk-imx95 driver yet so this really doesn't
do anything useful. Has a clk-imx95 driver been submitted?

> +scriptaddr=3D0x93500000
> +kernel_addr_r=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "

for a .env file you can't use stringify. Just use the config without quotes=
:
kernel_addr_r=3DCONFIG_SYS_LOAD_ADDR

> +image=3DImage
> +splashimage=3D0xA0000000
> +console=3DttyLP0,115200 earlycon
> +fdt_addr_r=3D0x93000000
> +fdt_addr=3D0x93000000
> +cntr_addr=3D0xA8000000
> +cntr_file=3Dos_cntr_signed.bin
> +boot_fit=3Dno
> +fdtfile=3D" CONFIG_DEFAULT_FDT_FILE "

fdtfile=3DCONFIG_DEFAULT_FDT_FILE

> +bootm_size=3D0x10000000
> +mmcdev=3D" __stringify(CONFIG_SYS_MMC_ENV_DEV)"

mmcdev=3DCONFIG_SYS_MMC_ENV_DEV

but you should probably just eliminate this one as its set at runtime
in board_late_mmc_env_init()

> +mmcpart=3D1
> +mmcroot=3D/dev/mmcblk1p2 rootwait rw

This is also redundant as its set at runtime in board_late_mmc_env_init()

Best Regards,

Tim
