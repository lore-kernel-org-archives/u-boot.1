Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA39C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 07:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1754387FED;
	Thu,  6 Jun 2024 09:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pPI53XoE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94C078808B; Thu,  6 Jun 2024 09:07:02 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB258806A
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 09:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-80ada61ba68so328930241.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 00:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717657619; x=1718262419; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q2kt/hZ5zXCGB0H0UM0bh6a2MlE/3P5JmzDat0a/wTQ=;
 b=pPI53XoE8uF51hGJgcx/rRkIeRakYAdlHSqYojqmbt807xCtfSKVnf0yoHJAGfPWZR
 6ebTlziRkxuespUXWuBYvFkvOOS9WrP7Y1oU5toC9D6tAPc4xVTR4gyO2lrkMsXAPlEy
 zrB0O/dnrBDZFhNUvFhPbvOwwMneVawFowDB09zXjjI3WLxviXni//eywFKdJx5YlDD0
 SmNOCXymoL+kznnd00Vzz92wG8CIBpDUnJda+FVd5EtT4Ewm890YQJYMTmaUlz+xmNAb
 zOYyozEgYSB7mr89ZGAu2BQMovdSPm9iRi0GrQvchlKZFYgmtvzHL3WvuzlWuTDB4mK5
 FbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717657619; x=1718262419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q2kt/hZ5zXCGB0H0UM0bh6a2MlE/3P5JmzDat0a/wTQ=;
 b=qSUWOp+fdOE/M6BXsC3gw4dZfiopKq8PNUorfA4A8xpnBW7LmYxqRVGEIJJTJUUJZZ
 gTg3OkHdNMqWwX+DNx+dwOGaY3rpd+OKjoDR2XKqzuCqTLlPpQNNCmEGsRWoyUCiDsNH
 RN0fT1JVfV85dTvKia3PHxyzWs+iVS/Jg4OhAe8PdqOhz4h3na0zNoBMkf7y40iUZMxj
 OydzuqyJPOkmhdz8at9Z2LgOCFAosErS3RqsnEvxEGV1AKgqQchHywMYuCU/HfGT5AY0
 /ZDSZwNTD5QL+/mi/XJkWMtUX0an9dV15xJiOPb7VgFaQcdRf2JbEuyC5XWo6mIEemSa
 lyCA==
X-Gm-Message-State: AOJu0Yw5bO10khMhNCZoBlCc7R9PDikiFkBWixIZG+d1sLheFH7rRpm0
 iX+khG4T9/Nov566z4tp7b6QxtnYXhioIIvcRQTsfZTwa43u4Rxv7JxdoMiKPKY4cZPcrsGcsF4
 5PWgDdFIlPjE4y4DSk7R9VhNS01GeBrGyiRgmqQ==
X-Google-Smtp-Source: AGHT+IH2hGfoChHSR4e0NMzXI3XlqzUgHkBLaSokfL2AJmCVOzHJ0+K1kRKQOTDcm2yjYqkKz4p6L559JqqDzv3vEiQ=
X-Received: by 2002:a05:6102:485:b0:48c:51a:2619 with SMTP id
 ada2fe7eead31-48c16eedd65mr2059360137.2.1717657618724; Thu, 06 Jun 2024
 00:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240528170406.353616-1-liujianfeng1994@gmail.com>
In-Reply-To: <20240528170406.353616-1-liujianfeng1994@gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 6 Jun 2024 12:36:47 +0530
Message-ID: <CAFA6WYPfO4D3xz0w+vDjJhNRxWApWc6CTbv1pozDuDdYa0+SnA@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] add ArmSoM Sige7 Rk3588 board
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christopher Obbard <chris.obbard@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>, 
 Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, 
 FUKAUMI Naoki <naoki@radxa.com>, Heiko Stuebner <heiko@sntech.de>,
 Jagan Teki <jagan@edgeble.ai>, 
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joseph Chen <chenjh@rock-chips.com>, 
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marex@denx.de>, Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Niklas Cassel <cassel@kernel.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Sam Edwards <cfsworks@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Tom Rini <trini@konsulko.com>, 
 Weizhao Ouyang <weizhao.ouyang@arm.com>
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

Hi Jianfeng,

On Tue, 28 May 2024 at 22:35, Jianfeng Liu <liujianfeng1994@gmail.com> wrote:
>
> This series also introduces dts commits of rk3588s.dtsi and rk3588.dtsi
> from v6.10-rc1-dts.
> Then dts of ArmSoM Sige7 is picked from upstream.
> I also remove obsolete usb3 nodes of rk3588-u-boot.dtsi and
> rk3588-u-boot.dtsi.
>
> Changes in v4:
> - Pick all commits of rk3588s.dtsi and rk3588.dtsi from v6.10-rc1-dts
> - Remove obsolete USB3 DRD nodes in u-boot.dtsi of rk3588s/rk3588
> - Remove sdhci and usb nodes from rk3588-armsom-sige7-u-boot.dtsi
>
> Changes in v3:
> - Use update-dts-subtree.sh to pick upstream dts
>
> Changes in v2:
> - Fix alphabetical order of MAINTAINERS
> - Use arch/arm/dts/rk3588-armsom-sige7* in board MAINTAINERS
> - Remove spi flash related config
> - Move kernel dts to dts/upstream/src/arm64/rockchip/
>
> Boris Brezillon (1):
>   arm64: dts: rockchip: Add rk3588 GPU node
>
> Diederik de Haas (1):
>   arm64: dts: rockchip: Fix ordering of nodes on rk3588s
>
> Jianfeng Liu (3):
>   arm64: dts: rockchip: Add ArmSom Sige7 board
>   rockchip: rk3588: Remove USB3 DRD nodes in u-boot.dtsi
>   board: rockchip: add ArmSoM Sige7 Rk3588 board
>
> Niklas Cassel (1):
>   arm64: dts: rockchip: add rk3588 pcie and php IOMMUs
>
> Sebastian Reichel (4):
>   arm64: dts: rockchip: fix usb2phy nodename for rk3588
>   arm64: dts: rockchip: reorder usb2phy properties for rk3588
>   arm64: dts: rockchip: add USBDP phys on rk3588
>   arm64: dts: rockchip: add USB3 DRD controllers on rk3588
>

Nice to see cherry pick from subtree worked as expected for you.

FWIW, for the series:

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>  MAINTAINERS                                   |   1 +
>  arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi  |   6 +
>  arch/arm/dts/rk3588-u-boot.dtsi               |  74 --
>  arch/arm/dts/rk3588s-u-boot.dtsi              |  85 ---
>  arch/arm/mach-rockchip/rk3588/Kconfig         |  26 +
>  board/armsom/sige7-rk3588/Kconfig             |  12 +
>  board/armsom/sige7-rk3588/MAINTAINERS         |   7 +
>  configs/sige7-rk3588_defconfig                |  93 +++
>  doc/board/rockchip/rockchip.rst               |   1 +
>  .../arm64/rockchip/rk3588-armsom-sige7.dts    | 721 ++++++++++++++++++
>  dts/upstream/src/arm64/rockchip/rk3588.dtsi   |  72 ++
>  dts/upstream/src/arm64/rockchip/rk3588s.dtsi  | 377 ++++++---
>  include/configs/sige7-rk3588.h                |  15 +
>  13 files changed, 1225 insertions(+), 265 deletions(-)
>  create mode 100644 arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
>  create mode 100644 board/armsom/sige7-rk3588/Kconfig
>  create mode 100644 board/armsom/sige7-rk3588/MAINTAINERS
>  create mode 100644 configs/sige7-rk3588_defconfig
>  create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-armsom-sige7.dts
>  create mode 100644 include/configs/sige7-rk3588.h
>
> --
> 2.34.1
>
