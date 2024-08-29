Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9003C87FCE
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 18:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0946788C08;
	Thu, 29 Aug 2024 20:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ItSBZe0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0931288C4B; Thu, 29 Aug 2024 16:05:36 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B368B88B31
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7cd9e634ea9so444460a12.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724940332; x=1725545132; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M97tEVpJvJXWcWs8nf4avYNdd7+CJk8bxQgtHDXiOj4=;
 b=ItSBZe0qwGgtO2MyYX7nIg+j4TUfcMBdXDTc7oWpFU4dvPMv8pi9GZf7gwX75Da9pb
 Z1yerPUARHtMWkYAuwW2qsqOm86Xi1vNXy5Mr296yXGJoFh4PZLXRD4w3KIFZYOTjMfQ
 BnhmYrTB9D8SHle7mxzqNMyop+lkyNEY1fHpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940332; x=1725545132;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M97tEVpJvJXWcWs8nf4avYNdd7+CJk8bxQgtHDXiOj4=;
 b=u1OO7xn3wx3srr/AaFYB2ysDd4Tf2E9w7Ow6rEXmVWq+QfJ4nWYXWDXQmidJRTr6Ca
 B+WeVhSkieqfg+np9/HRk2gDouL7z2tlOZztR3dlApMD0gr7wPVQ/wiLZmNoogU9tHvA
 QhZt76XKHwssGJIViYhatIP9gj1NSuqPy0KAlqegw8miPzy3A+ol0LA4igwmetM/ZT66
 Qg0NsX1y3i+KCdUa8yEhV+GkjgtQCuVH/K48ohWSRAppvpkqZNPPwsjdzy7WKx6VG11l
 sbOWwmOt/3WNWd855G+emOhMx6920UKKFmU9giTQUByfBcNCbiTFJBT69d0k3B3Vpv3T
 HCig==
X-Gm-Message-State: AOJu0Yx0HQVbM7PFxr9BAQ2H5zuaX8hUSkHAwyoWcmd7VC1DJvsKHz32
 6XZa8nj0WBO1RvAUtUt7rHTC+NjigzHIwCxIfKEc1ueOKsDszhVDeNOFSr1lVniB0+5AaLs2v4T
 l+3GFxDeLcDoPAz2fjDToVrj3K+Ac0q04vR02
X-Google-Smtp-Source: AGHT+IF+/9sYtOeo6NgPRBiee3Fvuos2vIppEGQFgkJevquDRA21h6hZvcxiGBahl5QJ12O7+8ftOyoprjWCIVp5noI=
X-Received: by 2002:a05:6a21:4603:b0:1c4:919f:3675 with SMTP id
 adf61e73a8af0-1cce10b09b2mr2344455637.35.1724940331236; Thu, 29 Aug 2024
 07:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <36a13357261f734187444b48b74dec2540e73b86.1724419624.git.jerome.forissier@linaro.org>
In-Reply-To: <36a13357261f734187444b48b74dec2540e73b86.1724419624.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 08:05:03 -0600
Message-ID: <CAFLszTi3YRpf4krkAYE1u7Sex0=Dn_YscSKxE8mQEh9Mxcgjow@mail.gmail.com>
Subject: Re: [PATCH v9 20/37] net-lwip: add DHCP support and dhcp commmand
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Anton Antonov <Anton.Antonov@arm.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, Tom Rini <trini@konsulko.com>, 
 Gilles Talis <gilles.talis@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Nishanth Menon <nm@ti.com>, 
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Petr Zejdl <petr.zejdl@cern.ch>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Eddie James <eajames@linux.ibm.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Yang Xiwen <forbidden405@outlook.com>, 
 Gabor Juhos <j4g8y7@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Boon Khai Ng <boon.khai.ng@intel.com>, Robert Marko <robert.marko@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 29 Aug 2024 20:23:46 +0200
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

Hi Jerome,

On Fri, 23 Aug 2024 at 07:49, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add what it takes to enable NETDEVICES with NET_LWIP and enable DHCP as
> well as the dhcp command. CMD_TFTPBOOT is selected by BOOTMETH_EFI due
> to this code having an implicit dependency on do_tftpb().
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  board/engicam/imx8mp/icore_mx8mp.c            |   2 +-
>  .../imx8mp_debix_model_a.c                    |   2 +-
>  board/ti/am335x/board.c                       |   3 +-
>  board/xilinx/common/board.c                   |   3 +-
>  boot/Kconfig                                  |   3 +-
>  cmd/Kconfig                                   |  91 +++---
>  cmd/Makefile                                  |   6 +-
>  cmd/elf.c                                     |   2 +-
>  cmd/net-lwip.c                                |  13 +
>  common/board_r.c                              |   4 +-
>  common/usb_kbd.c                              |   2 +-
>  drivers/net/Kconfig                           |   2 +-
>  include/net-lwip.h                            |   3 +
>  lib/tiny-printf.c                             |   3 +-
>  net/Makefile                                  |  14 +-
>  net/lwip/Makefile                             |   5 +
>  net/lwip/dhcp.c                               | 125 ++++++++
>  net/lwip/eth_internal.h                       |  35 +++
>  net/lwip/net-lwip.c                           | 286 ++++++++++++++++++
>  net/lwip/tftp.c                               |  11 +
>  20 files changed, 560 insertions(+), 55 deletions(-)
>  create mode 100644 cmd/net-lwip.c
>  create mode 100644 net/lwip/Makefile
>  create mode 100644 net/lwip/dhcp.c
>  create mode 100644 net/lwip/eth_internal.h
>  create mode 100644 net/lwip/net-lwip.c
>  create mode 100644 net/lwip/tftp.c
>
> diff --git a/board/engicam/imx8mp/icore_mx8mp.c b/board/engicam/imx8mp/icore_mx8mp.c
> index e2ed70caa43..bfdc447c478 100644
> --- a/board/engicam/imx8mp/icore_mx8mp.c
> +++ b/board/engicam/imx8mp/icore_mx8mp.c
> @@ -33,7 +33,7 @@ static void setup_fec(void)
>         setbits_le32(&gpr->gpr[1], BIT(22));
>  }
>
> -#if CONFIG_IS_ENABLED(NET)
> +#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)

How about making NET mean 'net', rather than having two options?

Perhaps the existing NET needs to be renamed to NET_INTERNAL or
something like that?

>  int board_phy_config(struct phy_device *phydev)
>  {
>         if (phydev->drv->config)
> diff --git a/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c b/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
> index 112770ba493..c709d017483 100644
> --- a/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
> +++ b/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
> @@ -29,7 +29,7 @@ static void setup_fec(void)
>         setbits_le32(&gpr->gpr[1], BIT(22));
>  }
>
> -#if CONFIG_IS_ENABLED(NET)
> +#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
>  int board_phy_config(struct phy_device *phydev)
>  {

[..]

Regards,
Simon
