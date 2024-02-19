Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A308BC48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 13:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A25CD87E0B;
	Mon, 19 Feb 2024 14:18:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nrr4ztJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B389287CE8; Mon, 19 Feb 2024 14:18:40 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C87F87F62
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 14:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29936dd174cso352552a91.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 05:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708348706; x=1708953506; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6CAiNAFqByo/jgd3Sg4gnc/FBzVMFUZmwOxQD/vDEkw=;
 b=nrr4ztJdQPCW1gOVDQNRQ6d5+MDQXNwxf8JEbZaMaVAY2EYN+sftqLbuwr2f4vHAL1
 PNzLXBWPxjhPl/wD9KqUr/BxlUdhnFhCulwEXT7s2O+EX1OVxvEOQGC9wRSIAlIy1mvv
 Th9t0ug8/+HOQf1FyIgpQoUu00+S0szS/Y1wtDuPCGf67qkMUETwQhD2RijSB2KaOpw5
 rTcVQkiY/kBQXcq8BROt1xeF6MuVdoN0rkEPdICYzol/PCKsvfPmGNTwjlgFjYf2zFlb
 XS/kPJNJNv9kfOpSkGRla9Cmv+OI4YIGtzSDmU+cnHRIwTQN4PyOWlM9rfjTOridJl9E
 7qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708348706; x=1708953506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6CAiNAFqByo/jgd3Sg4gnc/FBzVMFUZmwOxQD/vDEkw=;
 b=TTu4ejk8+TkkoQbHKoanounIzRuaAi4vEVg/6m2tIA9IC9LxWuxzMLoK80fYRp+d+S
 ZYgnVFOqW3goXqMEWVufQeEPP5+sJPe4RPMSOBgUJAsUwPqjDxyYEuFLYEXeHIK84gIS
 DPxvtp/xlerUNnxYxMXQ5nMEduxhx45MmsaPOFPiGJpIeuggvyIrQsNQiOgOkatwRm4g
 RmdNVTsO2LKUQEPXmJAMshIjde3ELx5uYWHJMQbbhYnTQjMnDpeTy+arR033YdwnirMt
 JAK63ijFOzK8OE9W+4pcsFE6v+0vKlhZi4IHyxxcdE/WrF6KrTwxpxZO6xpgz6fQM9Vg
 8ivQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMRs79k105f1DqrkyvagoXKtQw7sesNAlYVmtqRovtgyDKsoEuJSqTzIRvDIq2qwn7wjdySWK98JGlxduu/7AdCFYw5Q==
X-Gm-Message-State: AOJu0YzHhQ6SPQ7qfU9KuASWSW6WbupRddrX9a62Ai8btym9bN0ohCZJ
 lZxZQCf+XrJgag2ulQIk4fy9mANBTmP+jC/YC4Emv9SDhH7Pq5blUXhSPkWpl7L/i0NxRkRM7op
 UoNXN0NvIfa9+PKYGgefmAlQm30g=
X-Google-Smtp-Source: AGHT+IF+1PSW+5uGB0tH7yHt3VUaWr4w77mScOUitbPklLvjJJpuhZZSLRYfOy0lbJuIn3yLh/1RnV3DTOAWjlAOGnw=
X-Received: by 2002:a17:90a:9903:b0:299:1ae1:51ae with SMTP id
 b3-20020a17090a990300b002991ae151aemr8991027pjp.3.1708348705738; Mon, 19 Feb
 2024 05:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20240219084300.8228-1-othacehe@gnu.org>
In-Reply-To: <20240219084300.8228-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 19 Feb 2024 10:18:15 -0300
Message-ID: <CAOMZO5D2rMX+7RH+8Fs0o+bXv+a0BLb9=g09rCnodrXf-O43ng@mail.gmail.com>
Subject: Re: [PATCH] usb: ehci-mx6: Add i.MX93 support
To: Mathieu Othacehe <othacehe@gnu.org>, Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>, 
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Simon Glass <sjg@chromium.org>, Mathieu Othacehe <m.othacehe@gmail.com>,
 u-boot@lists.denx.de
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

Hi Mathieu,

On Mon, Feb 19, 2024 at 5:43=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:
>
> i.MX93 uses the same USB IP as i.MX8MM. It can then reuse the ehci-mx6
> driver.
>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

You missed copying Marek Vasut, who is the USB maintainer.

> ---
>  drivers/usb/host/Kconfig    | 6 +++---
>  drivers/usb/host/ehci-mx6.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 0dd5736433c..f96027d7bd2 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -210,10 +210,10 @@ config USB_EHCI_MX6
>
>  config USB_EHCI_MX7
>         bool "Support for i.MX7 on-chip EHCI USB controller"
> -       depends on ARCH_MX7 || IMX8M
> +       depends on ARCH_MX7 || IMX8M || IMX93
>         select EHCI_HCD_INIT_AFTER_RESET if ARCH_MX7
> -       select PHY if IMX8M
> -       select NOP_PHY if IMX8M
> +       select PHY if IMX8M || IMX93
> +       select NOP_PHY if IMX8M || IMX93
>         default y
>         ---help---
>           Enables support for the on-chip EHCI controller on i.MX7 SoCs.
> diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
> index a9ed5e7a0d5..a35fcca43a2 100644
> --- a/drivers/usb/host/ehci-mx6.c
> +++ b/drivers/usb/host/ehci-mx6.c
> @@ -538,7 +538,7 @@ static int ehci_usb_phy_mode(struct udevice *dev)
>                         plat->init_type =3D USB_INIT_DEVICE;
>                 else
>                         plat->init_type =3D USB_INIT_HOST;
> -       } else if (is_mx7() || is_imx8mm() || is_imx8mn()) {
> +       } else if (is_mx7() || is_imx8mm() || is_imx8mn() || is_imx93()) =
{
>                 phy_status =3D (void __iomem *)(addr +
>                                               USBNC_PHY_STATUS_OFFSET);
>                 val =3D readl(phy_status);
> --
> 2.41.0
>
