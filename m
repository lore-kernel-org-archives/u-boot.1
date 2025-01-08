Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D74CE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 07:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DEE48006D;
	Wed,  8 Jan 2025 08:50:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ijAgnmsM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC7D801E8; Wed,  8 Jan 2025 08:50:41 +0100 (CET)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0CB38005B
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 08:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4afde39e360so4502639137.0
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 23:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736322638; x=1736927438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MLPwG0OjBcsbwAgIGeHo2KVhONf3DSPRq4/QFiLBET0=;
 b=ijAgnmsMyjbXyPbGzXFx8f61iOWXQrllkW201fznqiEAE5WLG4shoByzcpkUYGNLBi
 TrlQnz1Jl8LDG+1vXPz9vL31g4cc9KNYP33iOeLyjlwLUPWVFKrDlXgpED7SE2RioG0x
 nDeqyIUFPALuPBd1oHiaH/BcoyjChp2uy6fx2Ia8ytqlW08C2EnKn5JS7VppNg9PtkDq
 vkMeJnBXUGi4/ZuRqtmgNMh+xFwyjBdLDkcibOzrxODUNsKDXP4rhKIB4sei9GIHasWw
 tgubrLZf7eIljj1VPmwuo4WZYas7tf1F5P56c9sJuEIuI5jd4p0Da0p7T9PserdnnL3O
 1nOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736322638; x=1736927438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MLPwG0OjBcsbwAgIGeHo2KVhONf3DSPRq4/QFiLBET0=;
 b=LpOqN+7s1Dz72PSHIbf/OHLe6mYjVJY2G5+Mf05/jb2s4iggBCxVHbrzXwW4lkP7rS
 DX66vx7cUqBllPrsKmBz7hLwMopAWWXUHkCJp36SHvzmEPYL1Eq49bwrpLcGSENTpn1p
 vzT7aszTaKQjP9OSdvYjUFoln/KwXtedc5YkZ6gBEut4EQmvB94CmYw06dXjCKZ+q5b9
 61agq6yAPAgU7PMMoyYY4rgWBSiv6eC0UzARbWo29F2PRj6abuO0NLkHLfm3I+S9DRkP
 ctOMZxawFu4znHPDwewVAVGxQMvIKL9wFaxCSft0B6AtNWRe7+nl1I8vf1voqhkFMvzc
 SEBQ==
X-Gm-Message-State: AOJu0YwaZM/lIkxM4Yq72PPIV/+wiOVCeFp3SisS3YYal6qmXT3oY1zI
 qFX3FEuK+dCSERrD5qeTfp8w2aOprygRMMRPZH/Qaf79qjgdcK4vTT0pveSK16DsKbRTAft8Rt/
 pGFZtBF1wA2+SDbO+9K+R5Ybz0rDfeRr3WcJeaw==
X-Gm-Gg: ASbGncvUJPYECqKUR+VfUfCDGIvOFOfK8erKbHLxNfVVsJ9hsDh9sIekOAP4u2/Dbiz
 8Q0RFupY1hn6GK80UuGoudQsMwyE3LrIrh6roVO6N
X-Google-Smtp-Source: AGHT+IEsvyA6Gynmx/v/gHGsQN2NW5eZMSHFEwRKdzIRPoue9vMgD4dH9uIla7SsLd0ZfBFojvo6WU20oV6j6bxn5xs=
X-Received: by 2002:a05:6102:4bc9:b0:4b1:3b91:a697 with SMTP id
 ada2fe7eead31-4b3d0dbf856mr1533821137.15.1736322638356; Tue, 07 Jan 2025
 23:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20250104015704.1238-1-naoki@radxa.com>
In-Reply-To: <20250104015704.1238-1-naoki@radxa.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 8 Jan 2025 13:20:27 +0530
X-Gm-Features: AbW1kvaxTyOG0a3f0QFmf7-FV5xw2CW5mEDTHFw5Kq7xVt1IrPzz7Z_WA6F-Jws
Message-ID: <CAFA6WYP17suAvm8RHgLzkqePTXbxgAAMQ7cNTvz16-artxYSuQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] rockchip: Add support for Radxa ROCK 5C
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu, 
 kever.yang@rock-chips.com, trini@konsulko.com, jonas@kwiboo.se, 
 eugen.hristev@linaro.org, quentin.schulz@cherry.de, michal.simek@amd.com, 
 seb-dev@mail.de, liujianfeng1994@gmail.com, heiko@sntech.de, 
 zhangzj@rock-chips.com, macromorgan@hotmail.com, dsimic@manjaro.org, 
 pbrobinson@gmail.com, cfsworks@gmail.com, sebastian.reichel@collabora.com, 
 alchark@gmail.com, didi.debian@cknow.org, cassel@kernel.org, 
 boris.brezillon@collabora.com, cristian.ciocaltea@collabora.com, 
 jing@jing.rocks
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

On Sat, 4 Jan 2025 at 07:28, FUKAUMI Naoki <naoki@radxa.com> wrote:
>
> Radxa ROCK 5C is a Rockchip RK3588S2 based single board computer.
>
> Changes in v5:
> - Rebase on top of latest next branch
> - Drop PATCH 1/5
>

For the series:

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> Cristian Ciocaltea (1):
>   arm64: dts: rockchip: Add HDMI0 node to rk3588
>
> FUKAUMI Naoki (2):
>   arm64: dts: rockchip: add Radxa ROCK 5C
>   rockchip: Add support for Radxa ROCK 5C
>
> Sam Edwards (1):
>   arm64: dts: rockchip: Split up RK3588's PCIe pinctrls
>
>  arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi      |  11 +
>  arch/arm/mach-rockchip/rk3588/Kconfig         |  21 +
>  board/radxa/rock-5c-rk3588s/Kconfig           |  12 +
>  board/radxa/rock-5c-rk3588s/MAINTAINERS       |   7 +
>  configs/rock-5c-rk3588s_defconfig             |  84 ++
>  doc/board/rockchip/rockchip.rst               |   1 +
>  .../arm64/rockchip/rk3588-base-pinctrl.dtsi   | 271 +++++-
>  .../src/arm64/rockchip/rk3588-base.dtsi       |  41 +
>  .../src/arm64/rockchip/rk3588s-rock-5a.dts    |   6 +-
>  .../src/arm64/rockchip/rk3588s-rock-5c.dts    | 920 ++++++++++++++++++
>  include/configs/rock-5c-rk3588s.h             |  15 +
>  11 files changed, 1340 insertions(+), 49 deletions(-)
>  create mode 100644 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
>  create mode 100644 board/radxa/rock-5c-rk3588s/Kconfig
>  create mode 100644 board/radxa/rock-5c-rk3588s/MAINTAINERS
>  create mode 100644 configs/rock-5c-rk3588s_defconfig
>  create mode 100644 dts/upstream/src/arm64/rockchip/rk3588s-rock-5c.dts
>  create mode 100644 include/configs/rock-5c-rk3588s.h
>
> --
> 2.43.0
>
