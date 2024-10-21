Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD874D15D84
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 12:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E858D8852D;
	Mon, 21 Oct 2024 14:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e1QcPftK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B34883D4; Mon, 21 Oct 2024 14:21:43 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61D9B88DB2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 14:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539e59dadebso5575487e87.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 05:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729513301; x=1730118101; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JFe1jcBYsa89QIdEVr1AkTZk3nSl2CMnT9mfWRAP2tk=;
 b=e1QcPftKcgg7cMxPnSD2unIxtkiee/oWBtAm/u1h1uyfG1K8WKqi8Dx1KqJ7YMKz+m
 auB/fE8ZCz1dLHXOw0r40rfS6LF5ZDyOt8SZDQSJXgFuppYu9BpYQK6WEl3jbPfRHjTa
 YtgzKWYlMWxnRM797S+9qNTr4wnv77zZIPG7V5rmxVRlNXavlbI5P7eA3r/G+MWO1/LX
 xINn8LfCmodMSeN2SpLQHgvs2ee/uUTo3HL1exk4eEmpZbE9xngixs297HbKdZuhPqCK
 bJZi703+y78jJW7GyHne6d4jDZ6Ww3py3ecxEqwiJIiw6fE8JwZrwxpTrvgLfel5VxYV
 37WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729513301; x=1730118101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JFe1jcBYsa89QIdEVr1AkTZk3nSl2CMnT9mfWRAP2tk=;
 b=ZA4UHaWjx3ZNu+ehUFqxx/IWz9kEWbCJKARHnppcr6r/+jdTlTbeqAc7SfseN51zbk
 XD8BPJkeqwQExaYXyJfFxSMP+7mU39UAk5LtbRaxwn0x2C15oyDtUlKGfW1Gu6eNYiYO
 aVv8zrWYP8EYefoVk8cHyddm2/W9GVjkW+Is3qI3PIKmYebESzAlu599/M8zqm5LbsVT
 jl+45ooFT/kZgY3ebuTOxmz22GD8wsAzmhQg3tcvkWNRQ0Z8XOhs8plOYLcZiT7ZQwpJ
 ASZ2qCzwRDHNM1Mt5UcnF3Skhxt5dWvw1Jp2aexWUjmOWCmevnhOWd5knoyJycGUrzcH
 mhew==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2OuAdKn0Osax7NoLbQzvLotDiCBOlC5VWUmKJU2OfygsMWDjTxpFVkZ4NAjC7bxmgx46vjJg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxdc0FjBhbbQZWK7gVIj6A7jaTJqGW0Be3T+MhL9OGBoHFRbav9
 MCQZ+PWCscK5vFf57HVNvhCTivVvzBECJgK42jU4cdwU/D8yyyPPipfemcR0WB5DpGXE0sE8O7X
 3C3a7dvcngff8OJwW4OXPIwvb5Hs=
X-Google-Smtp-Source: AGHT+IFC6VkB3LEfGQZtGSD+kqGkOsUUN5WWJEpRFbwdNBujW2xF35qL6oGVIl3jTUek5yeVP0hgAP3kI70x7b8RDHs=
X-Received: by 2002:a05:6512:31d3:b0:533:46cc:a71e with SMTP id
 2adb3069b0e04-53a15475391mr4666170e87.54.1729513300306; Mon, 21 Oct 2024
 05:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241020200818.278197-1-gilles.talis@gmail.com>
In-Reply-To: <20241020200818.278197-1-gilles.talis@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 21 Oct 2024 09:21:28 -0300
Message-ID: <CAOMZO5CZ80f+TefL_ndid_AeuEGntDwGFJj19ErR07YV-oRhVQ@mail.gmail.com>
Subject: Re: [PATCH] board: emcraft: Add support for Emcraft Systems NavQ+
To: Gilles Talis <gilles.talis@gmail.com>
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, uboot-imx@nxp.com
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

Hi Gilles,

On Sun, Oct 20, 2024 at 5:10=E2=80=AFPM Gilles Talis <gilles.talis@gmail.co=
m> wrote:

> +/ {
> +       wdt-reboot {
> +               compatible =3D "wdt-reboot";
> +               wdt =3D <&wdog1>;
> +               bootph-pre-ram;
> +       };

Please add a blank line here.

> +       firmware {
> +               optee {
> +                       compatible =3D "linaro,optee-tz";
> +                       method =3D "smc";
> +               };
> +       };
> +};

> +&usdhc3 {
> +       bootph-pre-ram;
> +       mmc-hs400-1_8v;
> +       mmc-hs400-enhanced-strobe;

Why are the 2 properties above only present in the U-Boot dtsi and not
in the kernel devicetree?

> +#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
> +int board_phy_config(struct phy_device *phydev)
> +{
> +
> +       /* enable rgmii rxc skew and phy mode select to RGMII copper */
> +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x1f);
> +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x8);
> +
> +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x00);
> +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x82ee);
> +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x05);
> +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x100);

Are these board code settings needed? Can't this be derived in the
devicetree instead?

> +int board_late_init(void)
> +{
> +       return 0;
> +}

This can be removed, along with CONFIG_BOARD_LATE_INIT=3Dy.

> diff --git a/board/emcraft/imx8mp_navqp/imximage-8mp-lpddr4.cfg b/board/e=
mcraft/imx8mp_navqp/imximage-8mp-lpddr4.cfg
> new file mode 100644
> index 0000000000..999cb630fe
> --- /dev/null
> +++ b/board/emcraft/imx8mp_navqp/imximage-8mp-lpddr4.cfg
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2021, 2024 NXP
> + */
> +
> +

Remove the double-blank line.

> +Get and Build the ARM Trusted Firmware (Trusted Firmware A)
> +-----------------------------------------------------------
> +
> +.. code-block:: bash
> +
> +    $ echo "Downloading and building TF-A..."
> +    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.=
git
> +    $ cd trusted-firmware-a

Please specify a specific branch of the trusted-firmware-a repo.

> +/* Initial environment variables */
> +#define CFG_EXTRA_ENV_SETTINGS         \
> +       BOOTENV \
> +       "scriptaddr=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
> +       "kernel_addr_r=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
> +       "image=3DImage\0" \
> +       "console=3Dttymxc1,115200 earlycon=3Dec_imx6q,0x30890000,115200\0=
" \
> +       "fdt_addr_r=3D0x43000000\0"                       \
> +       "boot_fdt=3Dtry\0" \
> +       "fdtfile=3D" CONFIG_DEFAULT_FDT_FILE "\0" \
> +       "initrd_addr=3D0x43800000\0"              \
> +       "bootm_size=3D0x10000000\0" \
> +       "mmcpart=3D1\0" \
> +       "mmcroot=3D/dev/mmcblk1p2 rootwait rw\0" \

Please move the above variables to
board/emcraft/imx8mp_navqp/imx8mp_navqp.env instead.
