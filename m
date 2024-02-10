Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C5DC4829A
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 18:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02C5987E52;
	Sat, 10 Feb 2024 19:12:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XDKr3HJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5368F879F3; Sat, 10 Feb 2024 19:12:50 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BF1087E5F
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 19:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29593a27fcaso422095a91.1
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 10:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707588765; x=1708193565; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7Fshp8+Cq2Wy2bb6D12oQRmEzR5Gl++dPgr2JXO7bw=;
 b=XDKr3HJSnvlVWX0hUrwgc+II1B7r0fvqXGYnsRrgU5qSyJgleHKIn+k4ItL1aPYSIu
 2suc2oRWGR6ofOBJTqYLRmVMB3mxYJJBBzwp73uHkrzvi0xODZcKLLLmL4e6k/KDsrrd
 NQHW2JYEIPAPnA1AwVOPYGQzzdaQT0K2rlqW531v1Wl6l1SCxfBFnUowLaGQ+qFR+Rbk
 PwLv25Lmy8fF7VZPmYpN7ldl9AIqYe9BLnF+R/FBp1+1WWZYal3gSNNErXsLHcbkNAcO
 dZ9avbu+kpejuFu8bSOYMoacBueMeJ/IMtWlIAGVl/aZIUTzPt9L6hV3P/aUk4Yd9zzu
 2vvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707588765; x=1708193565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z7Fshp8+Cq2Wy2bb6D12oQRmEzR5Gl++dPgr2JXO7bw=;
 b=hrrfGxrOX7jgzPaeB0P4OoWGA3Kaj9utiTU2Fq5iPRdEDGVapjl+Ki1+TrX6RVKYPC
 GYYYr8bzYJOugZZgesYrkv7iZgz/8AzgZ9Mi2IVFDULwBAQGBZgD8gEYwMo75UC3azxS
 l6+8LEFIfp9F6pATS7TUjKugdDzgXqDAjRjFuH4BuSZv7Qgeyrjm/CrybokAGBHazKe1
 6Y6QZOG7lIcFbntUTR/ItH1HZ85wPQLnQZp1+FgwlKRxrMcN+sYz3ggfFM4g66UaLp+G
 lEtoCCusR9noBrK4XjyYMLI7Lv4aEXYVWRfrbvGAFoSiNDu/JWtKO5C6pz6oCuGc2C0T
 GYjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq9J3wNCMhSD9vChiRNce+dM5ryvARxi4SPcHAQQ7Nxp/iPrIXu3WCotRkwkCQPgyi6WQwrvhDxqOJoI5UOwN8Gntw3w==
X-Gm-Message-State: AOJu0YyhqtHSoNaJnvI7D6BtvvhaJA2SZdQKOkmxAfI1Nlg248C6UwOm
 YKXQJkuf2Xba9y3GHuWR+vmkjA4M0KP4UtKzd31q2EqRkzxqcuZ/p/7DcSSZ/qOxPk71l2v9fuB
 N+zQLbPtxi4By/U+o13d499qUJww=
X-Google-Smtp-Source: AGHT+IFqsPl2Ro5NOBQFx3U+mOSb5Bt9WzP0T3/Ct+5l0P+kbrnL8yIfh+A4klKain4ne34ihIp8MvwO5CpEZauYXs0=
X-Received: by 2002:a17:90a:6f63:b0:296:f78b:d9f2 with SMTP id
 d90-20020a17090a6f6300b00296f78bd9f2mr1878488pjk.2.1707588765501; Sat, 10 Feb
 2024 10:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20240208165849.104787-1-frieder@fris.de>
 <20240208165849.104787-2-frieder@fris.de>
In-Reply-To: <20240208165849.104787-2-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 10 Feb 2024 15:12:32 -0300
Message-ID: <CAOMZO5C3JVhG4hfe3F6xfERJidDUt=Ow5eB+LNFx1EWp07wysw@mail.gmail.com>
Subject: Re: [PATCH 2/3] board: Add support for Sielaff i.MX6 Solo board
To: Frieder Schrempf <frieder@fris.de>
Cc: Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Christian Hewitt <christianshewitt@gmail.com>, 
 FUKAUMI Naoki <naoki@radxa.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tianling Shen <cnsztl@gmail.com>
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

Hi Frieder,

On Thu, Feb 8, 2024 at 1:59=E2=80=AFPM Frieder Schrempf <frieder@fris.de> w=
rote:

> +/ {
> +       binman: binman {
> +               filename =3D "flash.bin";
> +               pad-byte =3D <0x00>;
> +
> +               spl: blob-ext@1 {
> +                       offset =3D <0x0>;
> +                       filename =3D "SPL";
> +               };
> +
> +               uboot: blob-ext@2 {
> +                       offset =3D <0x11000>;
> +                       filename =3D "u-boot.img";
> +               };
> +       };

As mentioned in patch 3/3, please remove the binman entry and use
u-boot-with-spl.imx instead.

> +config TARGET_MX6S_SIELAFF
> +       bool "Sielaff i.MX6 Solo Board"
> +       depends on MX6S
> +       select BINMAN

Please drop it.

> +DECLARE_GLOBAL_DATA_PTR;
> +
> +iomux_v3_cfg_t nfc_pads[] =3D {

Make it static.

> --- /dev/null
> +++ b/board/sielaff/imx6dl-sielaff/imx6dl-sielaff.env
> @@ -0,0 +1,115 @@
> +blkloadfdt=3Dfatload ${device} ${devnum}:${partnum} ${fdt_addr} ${load_f=
dt_file}
> +blkloadimage=3Dfatload ${device} ${devnum}:${partnum} ${loadaddr} ${load=
_image}
> +boot_devices=3Dusb mmc ubi
> +bootargs_base=3Dvt.global_cursor_default=3D0 consoleblank=3D0 cma=3D200M=
 fbcon=3Drotate:1
> +bootdelay=3D3
> +bootdir=3D
> +console=3Dttymxc1,115200
> +ethact=3DFEC0
> +fdt_addr=3D0x18000000
> +fdt_file_legacy=3Dimx6dl_sielaff.dtb
> +fdt_file=3Dimx6dl-sielaff.dtb
> +fdt_high=3D0xffffffff
> +hostname=3Dmx6s-siline-hmi

Please remove it.

> +void reset_cpu(void)
> +{
> +}

Is this needed?

Does the 'reset' command work on this board?

> +++ b/configs/imx6dl_sielaff_defconfig
> @@ -0,0 +1,117 @@
> +CONFIG_ARM=3Dy
> +CONFIG_SPL_SYS_ICACHE_OFF=3Dy
> +CONFIG_SPL_SYS_DCACHE_OFF=3Dy

These options should be dropped.

> +#include <asm/arch/imx-regs.h>
> +#include <linux/sizes.h>
> +#include "mx6_common.h"
> +
> +#define CFG_MXC_UART_BASE              UART2_BASE

As you use DM_SERIAL, this can be dropped.
