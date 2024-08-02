Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409C0C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 02:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91F24886B5;
	Fri,  2 Aug 2024 04:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P577hm29";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 748BA88717; Fri,  2 Aug 2024 04:16:12 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2403588617
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 04:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70d333d5890so7095143b3a.0
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 19:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722564968; x=1723169768; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3d5q1oTzH0HPAljmLxbzlxuYkdvcbYxBkM3Jt90AWVQ=;
 b=P577hm29BY/qOblVhnIWWLcGpcABjT9IODwYPsqKVGXVxThUR8iwOeBUfb2KfvXMah
 IXegKirjsGhdpDmxEjeMVQfYmbJgEIUPg8QN+xFOKo5WOa4OUi4iI9EeQqHwo0qVpN11
 qchTvgQps0ZNXczOZcqoubAEucawoDrH9w3b2P3Ptuc51G3/ykfxBVNKhgvuCROodN6B
 jOIUPclhQEeAHPidIWtM5/BmQfFipfNRHV87MkmLFkJ5sS7y9chJBBLeOSZHm9a9mPee
 MMGUD40UXG1wWYJzIjo/klMNzIjUEPlbJhWdKJn6rQ8SdVEiFMd8LP68C7FUvbo23AZT
 TF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722564968; x=1723169768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3d5q1oTzH0HPAljmLxbzlxuYkdvcbYxBkM3Jt90AWVQ=;
 b=Q3J+ipWzFlHzMRHqo8WV7gd5t8FbS5u7BeYXYcFkSJvSUl+2prQGVg/arZPscNL8Vh
 E1fAeQaCZxSp47B3rOtFKPEU1DoA7IATQXkFCDOeYYp+CELgyx8pXY8F1WYI5s8xjePv
 YiojvrRQPcPbnWMzlMwomUlBfwP5QYTVZBRQTWVGnjLVI9iMF1OQGvQdNCG0ccSyHUzW
 YUHv9UC27TI4xEsXJp1ELMrhOwCkaJYqd3vfwTaPmuAfO00Uk8oLCzCq+t6Y4KfBcUrB
 mvAeO3E4W9mKM1TRlWdhk0NuulrFkXdEt/9Y/lISxXqspGdYzECBgI5nTX9ZbH2Emdql
 mkpA==
X-Gm-Message-State: AOJu0YxY5XD2e7wzEM5V/5Lod374FTB2iRR8uhydqyFkYjoKtqhxEfKP
 QOyYSJbCMxBD60dtaLeuyXcym+sRocDnFb+RdR4707JWGDcRWkS0Diu+B0DQNSCZoqer4+vde+C
 R5gQ5Ntj75sQRCrlbTl1Do8UxsfY=
X-Google-Smtp-Source: AGHT+IGd0UYTgwGkvBIr/kzBJaCg+GWvAlcX7i15iek9+M1XQoDN3AeNoW0TV6xzByqYAVjsJ0tAvXsmy9mgOMm4m1g=
X-Received: by 2002:a05:6a20:3d89:b0:1c2:8d49:dc33 with SMTP id
 adf61e73a8af0-1c699681770mr2778154637.40.1722564968311; Thu, 01 Aug 2024
 19:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240728202501.3204905-1-paulk@sys-base.io>
 <20240728202501.3204905-2-paulk@sys-base.io>
In-Reply-To: <20240728202501.3204905-2-paulk@sys-base.io>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 1 Aug 2024 21:15:57 -0500
Message-ID: <CAHCN7xKER6LtOw5oOT3evjrpAPkwz1oKBEkwp+vEPXpzzm20KQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] omap3: Define common SPL text base in Kconfig
 instead of defconfigs
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>, 
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>, 
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 "Andrew F . Davis" <afd@ti.com>, 
 =?UTF-8?Q?Javier_Mart=C3=ADnez_Canillas?= <javier@dowhile0.org>, 
 Felix Brack <fb@ltec.ch>, Heiko Schocher <hs@denx.de>, 
 Enric Balletbo i Serra <enric.balletbo@collabora.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Nikita Kiryanov <nikita@compulab.co.il>, 
 Thomas Weber <weber@corscience.de>, Enrico Leto <enrico.leto@siemens.com>, 
 "Derald D . Woods" <woods.technical@gmail.com>, 
 "Matwey V . Kornilov" <matwey.kornilov@gmail.com>, Niel Fourie <lusus@denx.de>,
 Parthiban Nallathambi <parthiban@linumiz.com>,
 Paul Kocialkowski <contact@paulk.fr>
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

On Sun, Jul 28, 2024 at 3:25=E2=80=AFPM Paul Kocialkowski <paulk@sys-base.i=
o> wrote:
>
> From: Paul Kocialkowski <contact@paulk.fr>
>
> The SPL text base was defined to the same value in each OMAP3 board
> defconfig. Move the common definition to the Kconfig option
> declaration instead.

Thanks for doing this.
>
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

For the series,

Tested-by: Adam Ford <aford173@gmail.com> #am3517-evm

> ---
>  common/spl/Kconfig                   | 1 +
>  configs/am3517_evm_defconfig         | 1 -
>  configs/devkit8000_defconfig         | 1 -
>  configs/igep00x0_defconfig           | 1 -
>  configs/omap35_logic_defconfig       | 1 -
>  configs/omap35_logic_somlv_defconfig | 1 -
>  configs/omap3_evm_defconfig          | 1 -
>  configs/omap3_logic_defconfig        | 1 -
>  configs/omap3_logic_somlv_defconfig  | 1 -
>  configs/sniper_defconfig             | 1 -
>  10 files changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 6f56ca911c1e..6fc97f4ccbd8 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -261,6 +261,7 @@ config SPL_LDSCRIPT
>
>  config SPL_TEXT_BASE
>         hex "SPL Text Base"
> +       default 0x40200000 if OMAP34XX
>         default 0x402F4000 if AM43XX
>         default 0x402F0400 if AM33XX
>         default 0x40301350 if OMAP54XX
> diff --git a/configs/am3517_evm_defconfig b/configs/am3517_evm_defconfig
> index 3236f1dd672f..129ffa28d272 100644
> --- a/configs/am3517_evm_defconfig
> +++ b/configs/am3517_evm_defconfig
> @@ -10,7 +10,6 @@ CONFIG_ENV_SOURCE_FILE=3D"am3517evm"
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x4020ff00
>  CONFIG_DEFAULT_DEVICE_TREE=3D"ti/omap/am3517-evm"
> -CONFIG_SPL_TEXT_BASE=3D0x40200000
>  CONFIG_TARGET_AM3517_EVM=3Dy
>  CONFIG_EMIF4=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D262144
> diff --git a/configs/devkit8000_defconfig b/configs/devkit8000_defconfig
> index 7653fbbe7e5a..db6e9386cf5f 100644
> --- a/configs/devkit8000_defconfig
> +++ b/configs/devkit8000_defconfig
> @@ -7,7 +7,6 @@ CONFIG_NR_DRAM_BANKS=3D2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x4020ff00
>  CONFIG_DEFAULT_DEVICE_TREE=3D"omap3-devkit8000"
> -CONFIG_SPL_TEXT_BASE=3D0x40200000
>  CONFIG_TARGET_DEVKIT8000=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D262144
>  CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x400
> diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
> index 473891607b0f..90ef2635c899 100644
> --- a/configs/igep00x0_defconfig
> +++ b/configs/igep00x0_defconfig
> @@ -9,7 +9,6 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x4020ff00
>  CONFIG_ENV_SIZE=3D0x8000
>  CONFIG_DEFAULT_DEVICE_TREE=3D"ti/omap/omap3-igep0020"
> -CONFIG_SPL_TEXT_BASE=3D0x40200000
>  CONFIG_TARGET_OMAP3_IGEP00X0=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D262144
>  CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x400
> diff --git a/configs/omap35_logic_defconfig b/configs/omap35_logic_defcon=
fig
> index 23b2e503385d..3b66af079c59 100644
> --- a/configs/omap35_logic_defconfig
> +++ b/configs/omap35_logic_defconfig
> @@ -10,7 +10,6 @@ CONFIG_NR_DRAM_BANKS=3D2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x4020ff00
>  CONFIG_DEFAULT_DEVICE_TREE=3D"ti/omap/logicpd-torpedo-35xx-devkit"
> -CONFIG_SPL_TEXT_BASE=3D0x40200000
>  CONFIG_TARGET_OMAP3_LOGIC=3Dy
>  # CONFIG_SPL_OMAP3_ID_NAND is not set
>  CONFIG_SYS_MONITOR_LEN=3D262144
> diff --git a/configs/omap35_logic_somlv_defconfig b/configs/omap35_logic_=
somlv_defconfig
> index a5f242ff40cf..1b1d3dcfb203 100644
> --- a/configs/omap35_logic_somlv_defconfig
> +++ b/configs/omap35_logic_somlv_defconfig
> @@ -10,7 +10,6 @@ CONFIG_NR_DRAM_BANKS=3D2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x4020ff00
>  CONFIG_DEFAULT_DEVICE_TREE=3D"ti/omap/logicpd-som-lv-35xx-devkit"
> -CONFIG_SPL_TEXT_BASE=3D0x40200000
>  CONFIG_TARGET_OMAP3_LOGIC=3Dy
>  # CONFIG_SPL_OMAP3_ID_NAND is not set
>  CONFIG_SYS_MONITOR_LEN=3D262144
> diff --git a/configs/omap3_evm_defconfig b/configs/omap3_evm_defconfig
> index 3c8d974fbd09..4ccb9b65c8bb 100644
> --- a/configs/omap3_evm_defconfig
> +++ b/configs/omap3_evm_defconfig
> @@ -7,7 +7,6 @@ CONFIG_NR_DRAM_BANKS=3D2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x4020ff00
>  CONFIG_DEFAULT_DEVICE_TREE=3D"omap3-evm"
> -CONFIG_SPL_TEXT_BASE=3D0x40200000
>  CONFIG_TARGET_OMAP3_EVM=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D262144
>  CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x400
> diff --git a/configs/omap3_logic_defconfig b/configs/omap3_logic_defconfi=
g
> index d081d4e0fb46..1fa5873a42d5 100644
> --- a/configs/omap3_logic_defconfig
> +++ b/configs/omap3_logic_defconfig
> @@ -10,7 +10,6 @@ CONFIG_NR_DRAM_BANKS=3D2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x4020ff00
>  CONFIG_DEFAULT_DEVICE_TREE=3D"ti/omap/logicpd-torpedo-37xx-devkit"
> -CONFIG_SPL_TEXT_BASE=3D0x40200000
>  CONFIG_TARGET_OMAP3_LOGIC=3Dy
>  # CONFIG_SPL_OMAP3_ID_NAND is not set
>  CONFIG_SYS_MONITOR_LEN=3D262144
> diff --git a/configs/omap3_logic_somlv_defconfig b/configs/omap3_logic_so=
mlv_defconfig
> index 68e89d245eee..642d2121ceda 100644
> --- a/configs/omap3_logic_somlv_defconfig
> +++ b/configs/omap3_logic_somlv_defconfig
> @@ -10,7 +10,6 @@ CONFIG_NR_DRAM_BANKS=3D2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x4020ff00
>  CONFIG_DEFAULT_DEVICE_TREE=3D"ti/omap/logicpd-som-lv-37xx-devkit"
> -CONFIG_SPL_TEXT_BASE=3D0x40200000
>  CONFIG_TARGET_OMAP3_LOGIC=3Dy
>  # CONFIG_SPL_OMAP3_ID_NAND is not set
>  CONFIG_SYS_MONITOR_LEN=3D262144
> diff --git a/configs/sniper_defconfig b/configs/sniper_defconfig
> index 0243b15f31ce..72634db607bf 100644
> --- a/configs/sniper_defconfig
> +++ b/configs/sniper_defconfig
> @@ -7,7 +7,6 @@ CONFIG_SYS_MALLOC_F_LEN=3D0x400
>  CONFIG_NR_DRAM_BANKS=3D2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x4020ff00
> -CONFIG_SPL_TEXT_BASE=3D0x40200000
>  CONFIG_TARGET_SNIPER=3Dy
>  CONFIG_SPL_STACK=3D0x4020fffc
>  CONFIG_SPL_BSS_START_ADDR=3D0x80000000
> --
> 2.45.2
>
