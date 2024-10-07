Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2962CFB446
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 15:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5423C88D9B;
	Mon,  7 Oct 2024 17:24:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gt6VVC79";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BC3488D63; Mon,  7 Oct 2024 17:24:00 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBFE088D86
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 17:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cb2ad51162so41572196d6.3
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 08:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728314637; x=1728919437; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rCEiPxgAeWQV+tXdWpwd+T+F3mbv20gdYUhlQ5nWnok=;
 b=Gt6VVC79hMEqd7jccoD6MZAj5bGXu9xsMfol2+WMIn9MQYlcU09fFqMEsCqDtgpk3G
 bxf2gSuTgvuiEPQbunEboame4oJJglfXUp69b2AmEzeyMfySlhFmfN5cyy5meymCq0cE
 or2/wZVZDxQTw8rqBpHD2IZJrQSH0RTIUM/W0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728314637; x=1728919437;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rCEiPxgAeWQV+tXdWpwd+T+F3mbv20gdYUhlQ5nWnok=;
 b=uHAsIeo++tFOh9l0e+2feqtrwQbN93Lsh/yIiZsggqZDHQZi6m/BX7C+d1PblNDPvd
 byd1FokkHvD0KlWmJbsFVwVb1fG65/AgwUxC1HCM0fARMZaF7ZwPq6UdC4/jzmQs4iWl
 0r5n7KBdrt4ALRv9Uv4tN90wuOLEwpSSXg6wrDzGjB7Z1q4TVtJZjbexYKn/UY9Eueb6
 tLKONx1j+qB0RpNj2bxPu34X9XK4IScthr262apcucxePXUe5GUrPwmmnhB9Pakkpb8x
 uRM2rtdOR+U0XzwgHUcnz9IRF0KQNEqxBhNYVnI4vfOrHiOsNPu/umVm2IhxAxSTa5L3
 pEOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAA0Q+WMsvmB13YxM3uEG2lhC0VGj6/Qy2lByvea4SoKiS4P2UL0EA0w0n1vD0POITlHKXHVM=@lists.denx.de
X-Gm-Message-State: AOJu0YykhEyiy8/DWBkF0q9aVJTpa1eIbXQcl8CwOfpAQyBHfD6qWurt
 gxJ7y4RQTNMtHroY+bdScfpHkmpdaAWMXt3lfrq/ftwABNCT0j3baKOSnuFMXtnQPj9MWMqPKWG
 5E9HHzOs5Pp9+R8MhGij1/orDtuO+W9hHd00X
X-Google-Smtp-Source: AGHT+IEeZYVq1ymEtEC42NAcRYnIwXoDSozCX6Hu8JJby+UTSU+FaRvIoJIjKgi/Qi4AJHKR6jWFNyRq8u7/xAbdQoc=
X-Received: by 2002:a05:6214:5541:b0:6cb:48de:1df3 with SMTP id
 6a1803df08f44-6cb9a1ef806mr171965276d6.11.1728314636666; Mon, 07 Oct 2024
 08:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
In-Reply-To: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Oct 2024 09:23:46 -0600
Message-ID: <CAFLszThMT+kN_u=ch-6m+3Ja615PwYjHd_La2KRhOzktXD21jg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Add AVS support for J721S2
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de, 
 Neha Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, 
 Aniket Limaye <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
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

Hi Manorit,

On Fri, 4 Oct 2024 at 00:24, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> This series adds support for AVS on J721S2.

What is AVS? You should write an abbreviation out in full at least
once in the series.

>
> AVS Test for J721S2: https://gist.github.com/manorit2001/b2fd9f6764a863294d4aa0755c83c84f
> Boot Test results: https://gist.github.com/manorit2001/15e45f6c421aeeb93effde023a537762
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
> Changes in v4:
>
> * Udit
> - Use the compatible for finding the node rather than alias.
> - Remove debug print
> - Add ret value in error prints
>
> - Link to v3: https://lore.kernel.org/r/20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com
>
> ---
> Manorit Chawdhry (7):
>       power: pmic: tps65941: Add DM_PMIC dependency
>       drivers: misc: k3_avs: Check return code while programming AVS
>       arm: dts: k3-j7*-r5: Add MPU clock in clocks property
>       drivers: misc: k3_avs: Extract MPU clk and dev ID from DT
>       arm: mach-k3: j721s2_init: Initialize AVS Class 0
>       arm: dts: j721s2: Add VTM node in R5
>       configs: j721s2_evm_r5_defconfig: Add AVS Configs
>
>  arch/arm/dts/k3-am69-r5-sk.dts                  |  3 +-
>  arch/arm/dts/k3-j7200-r5-common-proc-board.dts  |  3 +-
>  arch/arm/dts/k3-j721e-r5.dtsi                   |  3 +-
>  arch/arm/dts/k3-j721s2-r5-common-proc-board.dts |  9 ++++++
>  arch/arm/dts/k3-j721s2-r5.dtsi                  |  3 +-
>  arch/arm/dts/k3-j784s4-r5-evm.dts               |  3 +-
>  arch/arm/mach-k3/j721s2/j721s2_init.c           | 10 +++++++
>  configs/am68_sk_r5_defconfig                    |  4 +++
>  configs/j721s2_evm_r5_defconfig                 |  6 ++++
>  drivers/misc/k3_avs.c                           | 40 ++++++++++++++++++++++++-
>  drivers/power/pmic/Kconfig                      |  1 +
>  11 files changed, 79 insertions(+), 6 deletions(-)
> ---
> base-commit: 3a0b829efc35227b1079a444f00e0729502197ad
> change-id: 20240130-b4-upstream-j721s2-avs-8c187d3fe26a
>
> Best regards,
> --
> Manorit Chawdhry <m-chawdhry@ti.com>
>

Regards,
Simon
