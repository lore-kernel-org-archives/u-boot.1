Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A720E77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 19:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00BF18058A;
	Sat,  4 Jan 2025 20:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ML3MN6DE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CBBB805D5; Sat,  4 Jan 2025 20:31:08 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23A9F80585
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 20:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso69398666b.2
 for <u-boot@lists.denx.de>; Sat, 04 Jan 2025 11:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736019065; x=1736623865; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pPoQ/n0I7hscM4ax/HhtYsNnu3DOHcDBSqbLJCPOjr8=;
 b=ML3MN6DEjVcDYUc/8NYUyklwF02FoUdfq0BAWC1Ly99qUZfJf4cpS2UgsVohlYS9sR
 /wvD0OynImmx34NQRTdFeqoNd2Q8ROWYTkRqyKw2f8la0iENGnzbHfZEv+A27J6C+hqw
 3G8uj7PiygbmywM6qONIkRVU/U90hRpRqZaeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736019065; x=1736623865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pPoQ/n0I7hscM4ax/HhtYsNnu3DOHcDBSqbLJCPOjr8=;
 b=gAMuR3UnijvkWF3siAOB7GSaDTMfjyzRda0AZmg1qrukkdkYDjNQ04oTIbKK1lqXB3
 x766Aea7q+vtB38OgP6PYitAMVMQyD3Y6W1nazjGSL0J0pw3reu9W03f/YHrORp3sMO2
 zsD3o2qoBuempp3hpYIujjoCFaFHqeQmvuJmQ6Sb8EJ/OzcIs+0e+GwAgr5UAOgcvkFd
 /qhbYQChq45hRF6biXacaDNZv6SNnWOieMrJ/207jrbt0N9DcRc+YawZVEo8+OWU1kRJ
 RokoUhA/L1hqzp+s37rU39QZrI04jQvkx5Wu2FUqh7HVhNCfZ5ziDvBjTGjghiq6Zrfp
 RD7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv7Oj+vhQrIDoXi8GCWm5bvkS7Xdi9lORRW3eyMgYSC1n7vQLG0+gcXz5CI/64XZeBjeW6LDI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzfj4nJxLQKUQpf4drAR5OLcDPjaV3HyfFKSmFLE5zY4GLlh4b9
 iMor4gB0Ax7rmwY5gVhXql/O18eDg49RPJjVnvY2D1oaJ7YmOatiZvLIK8s0r6QwbxrFtRM/3yx
 kHpItCJXrTKol5++qoqponV+Yf+op6+R3xUx+
X-Gm-Gg: ASbGnct2+tyxRUI2FGWRH4ImEOeIqVkGLZKeUumXXgvNZHOYN81uXPL/T4zRmEO+xgi
 S1EtxcPDgQhfKeX2nHCTvboPXdAu6zpDWHtWaGcA/
X-Google-Smtp-Source: AGHT+IHmvVcV2Ym6W6vX3yE+tbypUbT704zgTohUSHSUkRbFLsjt+K6J1naaiFAdJdyj0nbSv4I0e52O2z/LKmzpn44=
X-Received: by 2002:a17:907:7da0:b0:aaf:ab71:69cd with SMTP id
 a640c23a62f3a-aafab716a1dmr615301066b.20.1736019065540; Sat, 04 Jan 2025
 11:31:05 -0800 (PST)
MIME-Version: 1.0
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
In-Reply-To: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Jan 2025 08:30:55 +1300
Message-ID: <CAFLszTi_px3qRGvpcC5WKLw+r5BqqQciOP-Vg1LEN+rt9876wQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1 EVK/QSB and
 i.MX8M EVK
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Peng,

On Sat, 4 Jan 2025 at 16:19, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> Switch to bootstd for NXP i.MX9/8M boards with a bsp_bootcmd as fallback.
>
> Patch 12 not related to bootstd, it is just one addon patch to cleanup
>
> CI: https://dev.azure.com/pengfan/uboot-ci/_build/results?buildId=15&view=results
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Peng Fan (12):
>       imx: imx93_evk: switch to BOOTSTD
>       imx: imx93_qsb: switch to BOOTSTD
>       imx: imx91_evk: switch to BOOTSTD
>       imx: imx8mp_evk: Enable dynamic settings to mmcdev and mmcroot
>       imx: imx8mp_evk: Switch to BOOTSTD
>       imx: imx8mn_evk: Enable dynamic settings to mmcdev and mmcroot
>       imx: imx8mn_evk: Switch to BOOTSTD
>       imx: imx8mm_evk: Enable dynamic settings to mmcdev and mmcroot
>       imx: imx8mm_evk: Switch to BOOTSTD
>       imx: imx8mq_evk: Enable dynamic settings to mmcdev and mmcroot
>       imx: imx8mq_evk: Switch to BOOTSTD
>       imx: imx93-11x11-evk: drop duplicated nodes
>
>  arch/arm/dts/imx93-11x11-evk-u-boot.dtsi     | 118 ---------------------------
>  arch/arm/mach-imx/imx8m/Kconfig              |   8 ++
>  arch/arm/mach-imx/imx9/Kconfig               |   6 ++
>  board/freescale/common/Makefile              |   2 +-
>  board/freescale/imx8mm_evk/imx8mm_evk.c      |   3 +
>  board/freescale/imx8mm_evk/imx8mm_evk.env    |  67 +++++++++++++++
>  board/freescale/imx8mn_evk/imx8mn_evk.c      |   9 +-
>  board/freescale/imx8mn_evk/imx8mn_evk.env    |  67 +++++++++++++++
>  board/freescale/imx8mp_evk/imx8mp_evk.c      |   5 ++
>  board/freescale/imx8mp_evk/imx8mp_evk.env    |  57 +++++++++++++
>  board/freescale/imx8mq_evk/imx8mq_evk.c      |  25 ++----
>  board/freescale/imx8mq_evk/imx8mq_evk.env    |  60 ++++++++++++++
>  board/freescale/imx91_evk/imx91_evk.env      |  29 ++++++-
>  board/freescale/imx93_evk/imx93_evk.env      |  88 ++++++++++++++++++++
>  board/freescale/imx93_qsb/imx93_qsb.env      |  29 ++++++-
>  configs/imx8mm_evk_defconfig                 |   4 +-
>  configs/imx8mm_evk_fspi_defconfig            |   4 +-
>  configs/imx8mn_evk_defconfig                 |   3 +-
>  configs/imx8mp_evk_defconfig                 |   3 +-
>  configs/imx8mq_evk_defconfig                 |   4 +-
>  configs/imx91_11x11_evk_defconfig            |   2 +-
>  configs/imx91_11x11_evk_inline_ecc_defconfig |   2 +-
>  configs/imx93_11x11_evk_defconfig            |   3 +-
>  configs/imx93_9x9_qsb_defconfig              |   2 +-
>  configs/imx93_9x9_qsb_inline_ecc_defconfig   |   2 +-
>  drivers/gpio/adp5585_gpio.c                  |   2 +-
>  include/configs/imx8mm_evk.h                 |  22 -----
>  include/configs/imx8mn_evk.h                 |  30 -------
>  include/configs/imx8mp_evk.h                 |  21 -----
>  include/configs/imx8mq_evk.h                 |  22 -----
>  include/configs/imx93_evk.h                  | 105 ------------------------
>  31 files changed, 448 insertions(+), 356 deletions(-)
> ---
> base-commit: a3d3d869b6f5860660718d05ee9b4d040d938e0f
> change-id: 20241231-imx-bootstd-abbf2e9e0d75
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>

This also switches to a text environment, great!

For bsp_bootcmd is it possible to create a bootmeth for your use case?
If you would like to take a look (separate from this series), I could
help with any issues that come up.

Regards,
Simon
