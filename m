Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0D4C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3BB887EE7;
	Mon, 12 Feb 2024 14:57:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b7qJOUBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00AD387EF3; Mon, 12 Feb 2024 14:57:50 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC1F487808
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55790581457so4951035a12.3
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 05:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707746267; x=1708351067; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pGzaM0QxCqxFpz4goyb4tJkbfl7spCvd1vw+a8m2v7Y=;
 b=b7qJOUBXAcybIHzzwwxGJ9NQcYrYnlnH8MOXij2Nukjg42ZCRozRQbweBoUps4yV66
 JVw5xSf3e+V/j3AAZss8NSdKNoYUBF70AwpdMHxZcOumuUsEh5qxsy/6Ixkmb/ScbPeY
 FouLcbqb2EvuLNPngOd6IqrkfyojPiymt5WMmuHmaROgkzUCHKSAbI71aQxq/UCaEaVg
 7YVmQOyzqQ+EBH4Be4JxR/eU585TIOYXI+CWeAeMxem4wdWpp8s27l3hvG4RW9xie5IW
 RBToy53QUpAwDdNHbjw4XHJqaIKWYjwekvyMtCdlt138W6Fmoo6dNE6jQuFzzc22fzqh
 f/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707746267; x=1708351067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pGzaM0QxCqxFpz4goyb4tJkbfl7spCvd1vw+a8m2v7Y=;
 b=kAJtxpmt0CrAftZw2ynnlSpxu3OMiLJqpgwCWQmb07ZyNaCWsOgZZQ+oLFCLaPQ4ux
 ybofHXqlvXSo8BX5cc/Pb2Th8IAz8AMqA1G9lys4GHrdhJxMPpk3iepUvKzAWjqZkZpZ
 IK3lbCkVbVE8uClM6MbLzTsMKwjIQjTDSy1SabvZ8MFDEKtZY3sKy3+xoCLsGNRJ/eAf
 BshhDwX6lk7rN/itX5/bYdDIWa2L5gwdf1o0curxsMLVGMbaDytsVlUoTgBpHz/uB9dH
 VwqjQ7Nsq9TJyfU/2w6i2ToZza21iKSqXiwbyjqw9FzIynTPe0cdU/oQTcMssBGeN0bo
 c3vw==
X-Gm-Message-State: AOJu0YzzFQ/m4LXWgeYxBUAPGCnvAqXGxi5lIKuWmMUdammPojwEul7F
 uNoU9J1E0ORJIqg7WSZdhP2ecojQAkdO2JmXC0FiEkBzweKki3dalbeWj2NjjL+mjlSI/FgARGF
 h2hQ0mZlUpCS2xAYMxAnox953L6g=
X-Google-Smtp-Source: AGHT+IFeRZj6KgIWASVQeCIIBQzx9vKmOHYrO1zJeS5cyHNOtaHY9D5kUtGa6FqJkxwkNwLLo2jPUefFseRl0eoTAuU=
X-Received: by 2002:a05:6402:7c3:b0:561:a6f1:66e3 with SMTP id
 u3-20020a05640207c300b00561a6f166e3mr2546950edy.22.1707746267056; Mon, 12 Feb
 2024 05:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20240210063252.1065611-1-wens@kernel.org>
In-Reply-To: <20240210063252.1065611-1-wens@kernel.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 12 Feb 2024 13:57:35 +0000
Message-ID: <CALeDE9OUB6z=xLUPxEybFuEY5pHi1X8OmQC2h8ezCLu-E+i5TA@mail.gmail.com>
Subject: Re: [PATCH 0/4] rockchip: Read cpuid and generate MAC address from
 efuse for RK3328 and RK3399
To: Chen-Yu Tsai <wens@kernel.org>
Cc: u-boot@lists.denx.de, Chen-Yu Tsai <wens@csie.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>, 
 Xiaobo Tian <peterwillcn@gmail.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Loic Devulder <ldevulder@suse.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Levin Du <djw@t-chip.com.cn>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, FUKAUMI Naoki <naoki@radxa.com>, 
 Christopher Obbard <chris.obbard@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Banglang Huang <banglang.huang@foxmail.com>, 
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

On Sat, 10 Feb 2024 at 06:32, Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> Hi folks,
>
> This series enables ROCKCHIP_EFUSE and MISC_INIT_R by default for RK3328
> and RK3399 so that the cpuid is read from the efuse and used to generate
> a serial number and MAC addresses for all boards.

For the series:
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> This stacks on top of the recent defconfig update series [1] from Jonas.
>
> [1] https://lore.kernel.org/u-boot/20240207000301.3270722-1-jonas@kwiboo.se/
>
>
> Chen-Yu Tsai (4):
>   rockchip: rk3328: Read cpuid and generate MAC address from efuse
>   rockchip: rk3399: Read cpuid and generate MAC address from efuse
>   rockchip: rk3328: regenerate defconfigs
>   rockchip: rk3399: regenerate defconfigs
>
>  arch/arm/mach-rockchip/Kconfig                | 4 ++++
>  configs/chromebook_bob_defconfig              | 2 --
>  configs/chromebook_kevin_defconfig            | 2 --
>  configs/evb-rk3328_defconfig                  | 2 --
>  configs/firefly-rk3399_defconfig              | 2 --
>  configs/nanopi-r2c-plus-rk3328_defconfig      | 2 --
>  configs/nanopi-r2c-rk3328_defconfig           | 2 --
>  configs/nanopi-r2s-rk3328_defconfig           | 2 --
>  configs/nanopi-r4s-rk3399_defconfig           | 2 --
>  configs/orangepi-r1-plus-lts-rk3328_defconfig | 2 --
>  configs/orangepi-r1-plus-rk3328_defconfig     | 2 --
>  configs/pinebook-pro-rk3399_defconfig         | 2 --
>  configs/pinephone-pro-rk3399_defconfig        | 2 --
>  configs/puma-rk3399_defconfig                 | 2 --
>  configs/roc-cc-rk3328_defconfig               | 2 --
>  configs/roc-pc-mezzanine-rk3399_defconfig     | 2 --
>  configs/roc-pc-rk3399_defconfig               | 2 --
>  configs/rock-4c-plus-rk3399_defconfig         | 3 ---
>  configs/rock-4se-rk3399_defconfig             | 3 ---
>  configs/rock-pi-4-rk3399_defconfig            | 3 ---
>  configs/rock-pi-4c-rk3399_defconfig           | 3 ---
>  configs/rock-pi-e-rk3328_defconfig            | 2 --
>  configs/rock-pi-n10-rk3399pro_defconfig       | 1 -
>  configs/rock64-rk3328_defconfig               | 2 --
>  configs/rock960-rk3399_defconfig              | 1 -
>  configs/rockpro64-rk3399_defconfig            | 2 --
>  26 files changed, 4 insertions(+), 52 deletions(-)
>
> --
> 2.39.2
>
