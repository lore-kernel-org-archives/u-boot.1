Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF0BCF649D
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 09:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D39CC88CA3;
	Mon, 30 Sep 2024 11:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mwxFf0Dq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB56F88CC8; Mon, 30 Sep 2024 11:03:22 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C2EE88A29
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 11:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c896b9b3e1so1409964a12.2
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 02:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727687000; x=1728291800; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I7lRyiHXlyHzUh95kgEidni6UiDFmAjoM/Ba1pnLmdk=;
 b=mwxFf0Dqf6Dg/OPAIoyaK6EP8CGDejz1h/OchOWLoh1zY+/EkGQ65gRey+qU8B1GjD
 SbEkhwLJ0NxvjYKmlc76Yj55P1MQQWu4c8x6XwfUcggt89DZTrPnSee6IC8CMHFmH1Ci
 b3KqzMIp894leBFpaQdFBCbXnogCx9iLGTOyIg5Lmcb4StOX04vBy4MQBCg+JuoMu9d9
 8r6JZCAjvhg6C2dxayCPhdQDGlfjM1B9mOGLxtgYaKRU/ZNybDsQt5emcCWGaTzzOPeJ
 A7imZNJ5DJIgxrq8qm6SuH6qUmMCy2OxcdIKEkpqZrWbcU2xu7rHHh4rLNX2RSqho2Su
 dO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727687000; x=1728291800;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I7lRyiHXlyHzUh95kgEidni6UiDFmAjoM/Ba1pnLmdk=;
 b=hAQxefjPVEqivuONoOeqBn54x/HZqLwV1ryV4Y4+XwdWQj1nJzL+Kh7RGBUeatb2cK
 GVjfzq9qMQhXP4Clx8iOGpx6rZKLjnsRnwM0HqE7lKxht3lxvjEdONVJbeDxmQ4DLbVw
 7qoqm5wHkkYDNCEA+T2TympPI9Wd7FjxfnWdUja9JZFcHn/G8tjaS7sc1CdxOgFM/qLt
 n9jRFfgyWJ1SL2M4bFoOFwI+k2l8ayoVUSvNL0tQ8QCUNF5SmnKGcWgdq0lOgcZ1dLz1
 kvhm7L8Bx4kWf3Q5AUOmAvx2GZgYP+H0WbvGwytS+V31ozIUiRIalzwG7sKniWTHI8Nc
 dGtg==
X-Gm-Message-State: AOJu0YyuYB6j9u4dvTXGfFACVjzU1Hy1IE77FuIC5k4H6aMpF6UMdGZx
 YXH25b9RCF0T17m2LvaIM16v/gN7OYtYGsZ+mGMng+IHnKegmzy0zuNX7blo/r+M1Xob4sk15iP
 xG/Acit1tlHdbX5QCn7U575oD8G0=
X-Google-Smtp-Source: AGHT+IGCbCMAtLGWHtWEa0vXxqzRwWHE+Nq/rt74xT/kGGKsWghcRC/Lj8E79CQFzXzoV95meP/t5eEjV3YECaR8aUM=
X-Received: by 2002:a05:6402:34c6:b0:5c2:5438:6ea with SMTP id
 4fb4d7f45d1cf-5c8824eb2aamr9673754a12.19.1727687000192; Mon, 30 Sep 2024
 02:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240926183111.1324284-1-paulk@sys-base.io>
 <20240926183111.1324284-3-paulk@sys-base.io>
In-Reply-To: <20240926183111.1324284-3-paulk@sys-base.io>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 30 Sep 2024 10:01:08 +0100
Message-ID: <CALeDE9NkpxES=SRKxH6=xk_94rRK9Y0gwuj=C-d+eddjOd_gkg@mail.gmail.com>
Subject: Re: [PATCH 3/4] rockchip: rk3399-rockpro64: Disable bootstage
 instrumentation config
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Chris Morgan <macromorgan@hotmail.com>, Tim Lunn <tim@feathertop.org>, 
 Paul Kocialkowski <contact@paulk.fr>
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

On Thu, 26 Sept 2024 at 19:32, Paul Kocialkowski <paulk@sys-base.io> wrote:
>
> From: Paul Kocialkowski <contact@paulk.fr>
>
> The boot timing and reporting (bootstage) infrastructure is useful for
> performance analysis and debug but adds overhead and console noise when
> using the device normally. Remove it from the device config.
>
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

This makes sense, for those that want this information will know how
to build it for testing.
> ---
>  configs/rockpro64-rk3399_defconfig | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
> index fc0804a0b80d..095d27ffaa04 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -19,8 +19,6 @@ CONFIG_SPL_SPI=y
>  CONFIG_SYS_LOAD_ADDR=0x800800
>  CONFIG_PCI=y
>  CONFIG_DEBUG_UART=y
> -CONFIG_BOOTSTAGE=y
> -CONFIG_BOOTSTAGE_REPORT=y
>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rockpro64.dtb"
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_SPL_MAX_SIZE=0x40000
> @@ -38,7 +36,6 @@ CONFIG_CMD_POWEROFF=y
>  CONFIG_CMD_USB=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_TIME=y
> -CONFIG_CMD_BOOTSTAGE=y
>  CONFIG_SPL_OF_CONTROL=y
>  CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>  CONFIG_ENV_IS_IN_SPI_FLASH=y
> --
> 2.46.2
>
