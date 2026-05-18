Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAADCD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 10:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F9E83FEE;
	Mon, 18 May 2026 12:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WMzOsWmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A619A845E3; Mon, 18 May 2026 12:06:52 +0200 (CEST)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com
 [IPv6:2607:f8b0:4864:20::122f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC00D83EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 12:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-135200bc7d2so5541387c88.0
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 03:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779098808; cv=none;
 d=google.com; s=arc-20240605;
 b=SG8iUzsn/seUGwd4B3TbzTee7S3SBL5kIV1kzzNJP73ZV4vqsaxnm8VPxqphnnhMlH
 E3nDXjGhEeEWn3Gev2LHsb5ao1YB7yXuzvacDAiocvSFjBk3nwdnxKjdaZ/BUQQMUso/
 z9+zuoXESyLQ0TCz1gC7zaNtu3Rg98pg61DYp7BenwtUaPoy1sPqyXYNn0JFVXOoUo7A
 Gjo2EDtj4ZKWm1o77n+OwHZGxLzXbcphtNEwdrtCm+aFBUtAxOz8O7HKJUi7bowkD6u6
 NPBgphOj03kSLN61dQcf7bu3nvXnjpAlgMO5UebK+wjKLe/qS6HlAbJ55oMENIUuoEmb
 VnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W9tlVd3hpbmsb9SXZXGtmwiz6ss7RdziUqqNZjNA6v0=;
 fh=7zjHbVa74Af5FvdU+NOPWyRXBAFKhHZe/JcLOoXBe8I=;
 b=M9Laluvp4Ks7SmFrZc1yQiA7d7V38cMno9LpWFzmB1IOwJAvcpVIT/LatWiKLToDsA
 uu8kVCTLZyy0Nh7CieG51lMyX5uoEntyhqs5pqCOCr1WW7H2FALnmer5YMWNfosPpr8C
 xAxPHj4jU7fdXzfXugPm8xrv2NDl3Ud9Z2P69EX7nfe/Vm1WgKmy8Lk9eYP+A/BQHqcy
 eqiW+qdtCfxixGWFucVbdldmJksbWVtwBkFQWMIHpB2ZBiBMczOmNXcR6v1xRYV6UIDj
 KniA2WnAJZq6+EtPk4IBpLt69EOJiVE9XrHdl1GLoxMwwtsJHrxdWeuFquw3w2R3qJCr
 +otQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779098808; x=1779703608; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9tlVd3hpbmsb9SXZXGtmwiz6ss7RdziUqqNZjNA6v0=;
 b=WMzOsWmFitKoeSLoTWPjbu4z2MqtqZf/TjYHDEyHN0xhOjVsZAZCAEt3lFBn10Mf8y
 5Kto3OUs+Wj5zkVqXvq7eQrPanM6LxeWknZFJzVbOHyCfbbl1h7fXKf3eARUGnPKKT6s
 6SmfOUW8Mwz2b/AMFDEEqyBHcvbDmQQ/jX8IlYAXBfwM1PcKxzv9rXvoNKh7dMVhTRa2
 0oG0T5HyGf1LZUouGyplD4bYfL1egWlzc6XQWywChwbGGl2ggJGOPmzWzgHupAAGpob4
 wMTOulVctC7b3Bxy/R+ISTCmhe5ohKsjPJzmrqxtaHFNpW6VLrT2udLjTEFJFaOyA571
 R3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779098808; x=1779703608;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W9tlVd3hpbmsb9SXZXGtmwiz6ss7RdziUqqNZjNA6v0=;
 b=SKIYB+13vrrcN/fmV3bVRR0B8+C9kldhamemPii7qHT/BgYlAHkdAZwrARhdwocfq5
 AJwTOlUrQdTLvvvfXLnudbUkul3zIph6ijlx/g0vF+yTmb6wOVJuqIMH+laMWZLUWNw4
 1q26MheftRn+4zmYC6QRkLlXaNH1vHivfiR6RQr8Tr89U6Nqj5jeV5KlfY7XbIyOWe75
 oXjwVYCf3CqyWAu+lp4+mtA5KUkvNFmf5ReQiZwRz0FNUYaYSojyr5wahYJ3iqzfL8Q4
 /mdPzYORMIP+8N4K3HMQOifIvQ/GoxAdiqB4GmdtaJAfo476+5+FYq0SXSUjYCLCiHDP
 Y6jw==
X-Forwarded-Encrypted: i=1;
 AFNElJ85e7sJX94U7QjrfdXhR8Js/i5kHR+DfM3R5bL2jPQ+Q3W7fh8wHMQiz4IvK7mrsKj0SJgQ27g=@lists.denx.de
X-Gm-Message-State: AOJu0Yzer80a4y7d7kuFWhujvwVPYkFMMhBbBpB9pIEM0UXSL5yYPZE2
 kxArwgm1IlDEq+kghc5NXdgxl7whMom4kx+FFy8CYv0qw7CiATdz+oEUWCz1YcgL+AqvjI7Stq2
 PKGN9P2HC6ui7Ap04ap9uAPQz1zDnWUA=
X-Gm-Gg: Acq92OHiC8bFf//tuf6s5YxKylIgVpMGEbO5YK8oTua1u9/GQTym33qT6AtXb8n7mzc
 JkRs5xosc3r6p0lF/HNYvqn1jnoEWwTHJfkZoPeftnKEV6bK/f3dSTkmVhG+/Rse9p0myK29CGs
 //ydnwid3Wvpl78Pw0eVM9cU2OC0ZGe+SUnssu3TTxQ41G53q5MbtDcem+kyMnDo+l58z3wtv2z
 nPO9IkLZNP5zsuLK/m9Wfbc3W5jS/RednzMzIZl83MtiDxpsz2CIw3iswckGjaVYEnlm3rOmULX
 1fU1lHU=
X-Received: by 2002:a05:7022:f9d:b0:133:1ba6:f42d with SMTP id
 a92af1059eb24-1350451e2b2mr7175576c88.3.1779098808048; Mon, 18 May 2026
 03:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <ce82a3ab-0d89-4b1e-a598-b79f69e7ba5a@gmail.com>
In-Reply-To: <ce82a3ab-0d89-4b1e-a598-b79f69e7ba5a@gmail.com>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Mon, 18 May 2026 13:06:36 +0300
X-Gm-Features: AVHnY4K4TMpYb1ClnueNMvUKMOVXq8mQfZDOoUHQOaTUxuF9_YB-1sA_YSbL-vU
Message-ID: <CAJs94EbKaVN3d4bEi+BS4h2ej7bC-QcZrdBHEEQROH3+-R-fbw@mail.gmail.com>
Subject: Re: [PATCH v1] rockchip: MAINTAINERS: upstream devicetree update
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu, 
 trini@konsulko.com, jagan@edgeble.ai, jonas@kwiboo.se, 
 frattaroli.nicolas@gmail.com, tom@tom-fitzhenry.me.uk, ehristev@kernel.org, 
 chenjh@rock-chips.com, zhangzj@rock-chips.com, jjriek@verizon.net, 
 u-boot@lists.denx.de, andyshrk@163.com, me@0upti.me, zhihong@nzhnb.com, 
 jiehui.he@foxmail.com, maximmosk4@gmail.com, gajjar04akash@gmail.com, 
 jagan@amarulasolutions.com, Tianling Shen <cnsztl@gmail.com>, 
 Frank Wunderlich <frank-w@public-files.de>, nick@khadas.com,
 Chen-Yu Tsai <wens@csie.org>, mail@david-bauer.net, jacobe.zang@wesion.com
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

Acked-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>

=D0=BF=D0=BD, 18 =D0=BC=D0=B0=D1=8F 2026=E2=80=AF=D0=B3. =D0=B2 02:24, Joha=
n Jonker <jbx6244@gmail.com>:
>
> Most Rockchip boards are now using the upstream device tree.
> Some MAINTAINERS files still contain a reference to
> no longer available files. Update and where possible
> streamline with '*' ending.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../neural-compute-module-6/MAINTAINERS       |  8 +---
>  board/hardkernel/odroid_m1/MAINTAINERS        |  3 +-
>  board/khadas/khadas-edge2-rk3588s/MAINTAINERS |  2 +-
>  board/pine64/quartz64_rk3566/MAINTAINERS      | 21 ++--------
>  board/pine64/quartzpro64-rk3588/MAINTAINERS   |  3 +-
>  board/radxa/rock5a-rk3588s/MAINTAINERS        |  3 +-
>  board/rockchip/evb_rk3328/MAINTAINERS         | 14 ++-----
>  board/rockchip/evb_rk3399/MAINTAINERS         |  7 +---
>  board/rockchip/evb_rk3568/MAINTAINERS         | 38 +++++++------------
>  board/rockchip/evb_rk3588/MAINTAINERS         | 21 ++++------
>  board/rockchip/toybrick_rk3588/MAINTAINERS    |  3 +-
>  board/turing/turing-rk1-rk3588/MAINTAINERS    |  4 +-
>  .../orangepi-5-ultra-rk3588/MAINTAINERS       |  2 +-
>  13 files changed, 37 insertions(+), 92 deletions(-)
>
> diff --git a/board/edgeble/neural-compute-module-6/MAINTAINERS b/board/ed=
geble/neural-compute-module-6/MAINTAINERS
> index 42e5df506bf3..97d8c96ae628 100644
> --- a/board/edgeble/neural-compute-module-6/MAINTAINERS
> +++ b/board/edgeble/neural-compute-module-6/MAINTAINERS
> @@ -5,9 +5,5 @@ F:      board/edgeble/neural-compute-module-6
>  F:     include/configs/neural-compute-module-6.h
>  F:     configs/neu6a-io-rk3588_defconfig
>  F:     configs/neu6b-io-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-edgeble-neu6a.dtsi
> -F:     arch/arm/dts/rk3588-edgeble-neu6a-io.dts
> -F:     arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> -F:     arch/arm/dts/rk3588-edgeble-neu6b.dtsi
> -F:     arch/arm/dts/rk3588-edgeble-neu6b-io.dts
> -F:     arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-edgeble-neu6a-io*
> +F:     arch/arm/dts/rk3588-edgeble-neu6b-io*
> diff --git a/board/hardkernel/odroid_m1/MAINTAINERS b/board/hardkernel/od=
roid_m1/MAINTAINERS
> index 165d2d96741d..8686a552d1c6 100644
> --- a/board/hardkernel/odroid_m1/MAINTAINERS
> +++ b/board/hardkernel/odroid_m1/MAINTAINERS
> @@ -4,5 +4,4 @@ S:      Maintained
>  F:     board/hardkernel/odroid_m1/
>  F:     include/configs/odroid_m1.h
>  F:     configs/odroid-m1-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-odroid-m1.dts
> -F:     arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-odroid-m1*
> diff --git a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS b/board/khadas=
/khadas-edge2-rk3588s/MAINTAINERS
> index 3f16923b0f25..c43f469589dd 100644
> --- a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> +++ b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> @@ -3,4 +3,4 @@ M:      Jacobe Zang <jacobe.zang@wesion.com>
>  S:     Maintained
>  F:     configs/khadas-edge2-rk3588s_defconfig
>  F:     include/configs/khadas-edge2-rk3588s.h
> -F:     dts/upstream/src/arm64/rockchip/rk3588s-khadas-edge2.dts
> \ No newline at end of file
> +F:     arch/arm/dts/rk3588s-khadas-edge2*
> diff --git a/board/pine64/quartz64_rk3566/MAINTAINERS b/board/pine64/quar=
tz64_rk3566/MAINTAINERS
> index 37b8c1eb78b6..955cb5de0300 100644
> --- a/board/pine64/quartz64_rk3566/MAINTAINERS
> +++ b/board/pine64/quartz64_rk3566/MAINTAINERS
> @@ -9,26 +9,11 @@ F:    configs/quartz64-b-rk3566_defconfig
>  F:     configs/soquartz-blade-rk3566_defconfig
>  F:     configs/soquartz-cm4-rk3566_defconfig
>  F:     configs/soquartz-model-a-rk3566_defconfig
> -F:     arch/arm/dts/rk3566-quartz64-a.dts
> -F:     arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> -F:     arch/arm/dts/rk3566-quartz64-b.dts
> -F:     arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> -F:     arch/arm/dts/rk3566-soquartz.dtsi
> -F:     arch/arm/dts/rk3566-soquartz-u-boot.dtsi
> -F:     arch/arm/dts/rk3566-soquartz-blade.dts
> -F:     arch/arm/dts/rk3566-soquartz-blade-u-boot.dtsi
> -F:     arch/arm/dts/rk3566-soquartz-cm4.dts
> -F:     arch/arm/dts/rk3566-soquartz-cm4-u-boot.dtsi
> -F:     arch/arm/dts/rk3566-soquartz-model-a.dts
> -F:     arch/arm/dts/rk3566-soquartz-model-a-u-boot.dtsi
> +F:     arch/arm/dts/rk3566-quartz64*
> +F:     arch/arm/dts/rk3566-soquartz*
>
>  PINETAB2-RK3566
>  M:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/pinetab2-rk3566_defconfig
> -F:     arch/arm/dts/rk3566-pinetab2.dtsi
> -F:     arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
> -F:     arch/arm/dts/rk3566-pinetab2-v0.1.dts
> -F:     arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi
> -F:     arch/arm/dts/rk3566-pinetab2-v2.0.dts
> -F:     arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi
> +F:     arch/arm/dts/rk3566-pinetab2*
> diff --git a/board/pine64/quartzpro64-rk3588/MAINTAINERS b/board/pine64/q=
uartzpro64-rk3588/MAINTAINERS
> index a7e944b74781..ff3500a32fc0 100644
> --- a/board/pine64/quartzpro64-rk3588/MAINTAINERS
> +++ b/board/pine64/quartzpro64-rk3588/MAINTAINERS
> @@ -4,5 +4,4 @@ S:      Maintained
>  F:     board/pine64/quartzpro64-rk3588
>  F:     include/configs/quartzpro64-rk3588.h
>  F:     configs/quartzpro64-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-quartzpro64.dts
> -F:     arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-quartzpro64*
> diff --git a/board/radxa/rock5a-rk3588s/MAINTAINERS b/board/radxa/rock5a-=
rk3588s/MAINTAINERS
> index afc9bf5706c9..d4cd82139d51 100644
> --- a/board/radxa/rock5a-rk3588s/MAINTAINERS
> +++ b/board/radxa/rock5a-rk3588s/MAINTAINERS
> @@ -5,5 +5,4 @@ S:      Maintained
>  F:     board/radxa/rock5a-rk3588s
>  F:     include/configs/rock5a-rk3588s.h
>  F:     configs/rock5a-rk3588s_defconfig
> -F:     arch/arm/dts/rk3588s-rock-5a.dts
> -F:     arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> +F:     arch/arm/dts/rk3588s-rock-5a*
> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_r=
k3328/MAINTAINERS
> index 8c9b42fe2bbf..d8748c1c2a26 100644
> --- a/board/rockchip/evb_rk3328/MAINTAINERS
> +++ b/board/rockchip/evb_rk3328/MAINTAINERS
> @@ -4,8 +4,7 @@ S:      Maintained
>  F:      board/rockchip/evb_rk3328
>  F:      include/configs/evb_rk3328.h
>  F:      configs/evb-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-evb.dts
> -F:      arch/arm/dts/rk3328-evb-u-boot.dtsi
> +F:      arch/arm/dts/rk3328-evb*
>
>  GENERIC-RK3328
>  M:     Jonas Karlman <jonas@kwiboo.se>
> @@ -17,14 +16,12 @@ NANOPI-R2C-RK3328
>  M:      Tianling Shen <cnsztl@gmail.com>
>  S:      Maintained
>  F:      configs/nanopi-r2c-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-nanopi-r2c.dts
>  F:      arch/arm/dts/rk3328-nanopi-r2c-u-boot.dtsi
>
>  NANOPI-R2C-PLUS-RK3328
>  M:      Tianling Shen <cnsztl@gmail.com>
>  S:      Maintained
>  F:      configs/nanopi-r2c-plus-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-nanopi-r2c-plus.dts
>  F:      arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
>
>  NANOPI-R2S-RK3328
> @@ -32,7 +29,6 @@ M:      David Bauer <mail@david-bauer.net>
>  S:      Maintained
>  F:      configs/nanopi-r2s-rk3328_defconfig
>  F:      arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> -F:      arch/arm/dts/rk3328-nanopi-r2s.dts
>
>  NANOPI-R2S-PLUS-RK3328
>  M:      Jonas Karlman <jonas@kwiboo.se>
> @@ -44,14 +40,12 @@ ORANGEPI-R1-PLUS-RK3328
>  M:      Tianling Shen <cnsztl@gmail.com>
>  S:      Maintained
>  F:      configs/orangepi-r1-plus-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-orangepi-r1-plus.dts
>  F:      arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
>
>  ORANGEPI-R1-PLUS-LTS-RK3328
>  M:      Tianling Shen <cnsztl@gmail.com>
>  S:      Maintained
>  F:      configs/orangepi-r1-plus-lts-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-orangepi-r1-plus-lts.dts
>  F:      arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
>
>  ROC-RK3328-CC
> @@ -60,16 +54,14 @@ M:      Chen-Yu Tsai <wens@csie.org>
>  R:      Jonas Karlman <jonas@kwiboo.se>
>  S:      Maintained
>  F:      configs/roc-cc-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-roc-cc.dts
> -F:      arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> +F:      arch/arm/dts/rk3328-roc-cc*
>
>  ROCK64-RK3328
>  M:      Matwey V. Kornilov <matwey.kornilov@gmail.com>
>  R:      Jonas Karlman <jonas@kwiboo.se>
>  S:      Maintained
>  F:      configs/rock64-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-rock64.dts
> -F:      arch/arm/dts/rk3328-rock64-u-boot.dtsi
> +F:      arch/arm/dts/rk3328-rock64*
>
>  ROCKPIE-RK3328
>  M:      Banglang Huang <banglang.huang@foxmail.com>
> diff --git a/board/rockchip/evb_rk3399/MAINTAINERS b/board/rockchip/evb_r=
k3399/MAINTAINERS
> index 8319db2e976c..860dd0287597 100644
> --- a/board/rockchip/evb_rk3399/MAINTAINERS
> +++ b/board/rockchip/evb_rk3399/MAINTAINERS
> @@ -24,9 +24,7 @@ KHADAS-EDGE
>  M:     Nick Xie <nick@khadas.com>
>  S:     Maintained
>  F:     configs/khadas-edge-rk3399_defconfig
> -F:     arch/arm/dts/rk3399-khadas-edge.dts
> -F:     arch/arm/dts/rk3399-khadas-edge.dtsi
> -F:     arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
> +F:     arch/arm/dts/rk3399-khadas-edge*
>
>  KHADAS-EDGE-CAPTAIN
>  M:     Nick Xie <nick@khadas.com>
> @@ -56,8 +54,7 @@ NANOPI-M4
>  M:     Jagan Teki <jagan@amarulasolutions.com>
>  S:     Maintained
>  F:     configs/nanopi-m4-rk3399_defconfig
> -F:     arch/arm/dts/rk3399-nanopi-m4.dts
> -F:     arch/arm/dts/rk3399-nanopi-m4-u-boot.dtsi
> +F:     arch/arm/dts/rk3399-nanopi-m4*
>
>  NANOPI-M4-2GB
>  M:     Jagan Teki <jagan@amarulasolutions.com>
> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_r=
k3568/MAINTAINERS
> index 030cdbe6f3db..7e17a6a987a5 100644
> --- a/board/rockchip/evb_rk3568/MAINTAINERS
> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
> @@ -2,8 +2,7 @@ BANANAPI-BPI-R2-PRO
>  M:     Frank Wunderlich <frank-w@public-files.de>
>  S:     Maintained
>  F:     configs/bpi-r2-pro-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-bpi-r2-pro.dts
> -F:     arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-bpi-r2-pro*
>
>  EVB-RK3568
>  M:     Joseph Chen <chenjh@rock-chips.com>
> @@ -11,78 +10,67 @@ S:  Maintained
>  F:     board/rockchip/evb_rk3568
>  F:     include/configs/evb_rk3568.h
>  F:     configs/evb-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-evb-u-boot.dtsi
> -F:     arch/arm/dts/rk3568-evb.dts
> +F:     arch/arm/dts/rk3568-evb*
>
>  FASTRHINO-R66S-RK3568
>  M:     Tianling Shen <cnsztl@gmail.com>
>  R:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/fastrhino-r66s-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-fastrhino-r66s*
>
>  GENERIC-RK3568
>  M:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/generic-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-generic.dts
> -F:     arch/arm/dts/rk3568-generic-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-generic*
>
>  LUBANCAT-2
>  M:     Andy Yan <andyshrk@163.com>
>  S:     Maintained
>  F:     configs/lubancat-2-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-lubancat-2.dts
> -F:     arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-lubancat-2*
>
>  NANOPI-R3S
>  M:     Tianling Shen <cnsztl@gmail.com>
>  R:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/nanopi-r3s-rk3566_defconfig
> -F:     arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
> +F:     arch/arm/dts/rk3566-nanopi-r3s*
>
>  NANOPI-R5C
>  M:     Tianling Shen <cnsztl@gmail.com>
>  R:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/nanopi-r5c-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-nanopi-r5c.dts
> -F:     arch/arm/dts/rk3568-nanopi-r5c-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-nanopi-r5c*
>
>  NANOPI-R5S
>  M:     Tianling Shen <cnsztl@gmail.com>
>  R:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/nanopi-r5s-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-nanopi-r5s.dts
> -F:     arch/arm/dts/rk3568-nanopi-r5s.dtsi
> -F:     arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-nanopi-r5s*
>
>  RADXA-CM3-IO
>  M:     Jagan Teki <jagan@amarulasolutions.com>
>  R:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/radxa-cm3-io-rk3566_defconfig
> -F:     arch/arm/dts/rk3566-radxa-cm3.dtsi
> -F:     arch/arm/dts/rk3566-radxa-cm3-io.dts
> -F:     arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> +F:     arch/arm/dts/rk3566-radxa-cm3-io*
>
>  RADXA-E25
>  M:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/radxa-e25-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-radxa-cm3i.dtsi
> -F:     arch/arm/dts/rk3568-radxa-e25.dts
> -F:     arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-radxa-e25*
>
>  ROCK-3A
>  M:     Akash Gajjar <gajjar04akash@gmail.com>
>  R:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/rock-3a-rk3568_defconfig
> -F:     arch/arm/dts/rk3568-rock-3a.dts
> -F:     arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> +F:     arch/arm/dts/rk3568-rock-3a*
>
>  ROCK-3B
>  M:     Jonas Karlman <jonas@kwiboo.se>
> @@ -94,11 +82,11 @@ ROCK-3C
>  M:     Jonas Karlman <jonas@kwiboo.se>
>  M:     Maxim Moskalets <maximmosk4@gmail.com>
>  S:     Maintained
> -F:     arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
> +F:     arch/arm/dts/rk3566-rock-3c*
>  F:     configs/rock-3c-rk3566_defconfig
>
>  LCKFB-TaishanPi
>  M:     Jiehui He <jiehui.he@foxmail.com>
>  S:     Maintained
>  F:     configs/lckfb-tspi-rk3566_defconfig
> -F:     arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi
> +F:     arch/arm/dts/rk3566-lckfb-tspi*
> diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_r=
k3588/MAINTAINERS
> index 8b11db43f5f6..b64dd4947ee2 100644
> --- a/board/rockchip/evb_rk3588/MAINTAINERS
> +++ b/board/rockchip/evb_rk3588/MAINTAINERS
> @@ -2,16 +2,13 @@ COOLPI-4B-RK3588S
>  M:     Andy Yan <andyshrk@163.com>
>  S:     Maintained
>  F:     configs/coolpi-4b-rk3588s_defconfig
> -F:     arch/arm/dts/rk3588s-coolpi-4b.dts
> -F:     arch/arm/dts/rk3588s-coolpi-u-boot.dtsi
> +F:     arch/arm/dts/rk3588s-coolpi-4b*
>
>  COOLPI-CM5-EVB-RK3588
>  M:     Andy Yan <andyshrk@163.com>
>  S:     Maintained
>  F:     configs/coolpi-cm5-evb-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-coolpi-cm5.dtsi
> -F:     arch/arm/dts/rk3588-coolpi-cm5-evb.dts
> -F:     arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-coolpi-cm5-evb*
>
>  EVB-RK3588
>  M:     Kever Yang <kever.yang@rock-chips.com>
> @@ -19,15 +16,13 @@ S:  Maintained
>  F:     board/rockchip/evb_rk3588
>  F:     include/configs/evb_rk3588.h
>  F:     configs/evb-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-evb1-v10.dts
> -F:     arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-evb1-v10*
>
>  GENERIC-RK3588
>  M:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/generic-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-generic.dts
> -F:     arch/arm/dts/rk3588-generic-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-generic*
>
>  MNT-REFORM2-RK3588
>  M:     Peter Robinson <pbrobinson@gmail.com>
> @@ -38,24 +33,22 @@ ORANGEPI-5-RK3588
>  M:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/orangepi-5-rk3588s_defconfig
> -F:     arch/arm/dts/rk3588s-orangepi-5.dts
>  F:     arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
>
>  ORANGEPI-5-MAX-RK3588
>  M:     Ilya Katsnelson <me@0upti.me>
>  S:     Maintained
>  F:     configs/orangepi-5-max-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-orangepi-5-max*
>
>  ORANGEPI-5-PLUS-RK3588
>  M:     Jonas Karlman <jonas@kwiboo.se>
>  S:     Maintained
>  F:     configs/orangepi-5-plus-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-orangepi-5-plus.dts
> -F:     arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-orangepi-5-plus*
>
>  ORANGEPI-5-RK3588-ULTRA
>  M:     Niu Zhihong <zhihong@nzhnb.com>
>  S:     Maintained
>  F:     configs/orangepi-5-ultra-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-orangepi-5-ultra-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-orangepi-5-ultra*
> diff --git a/board/rockchip/toybrick_rk3588/MAINTAINERS b/board/rockchip/=
toybrick_rk3588/MAINTAINERS
> index cd4401c24f30..e2c76f80e9b8 100644
> --- a/board/rockchip/toybrick_rk3588/MAINTAINERS
> +++ b/board/rockchip/toybrick_rk3588/MAINTAINERS
> @@ -4,5 +4,4 @@ S:      Maintained
>  F:     board/rockchip/toybrick_rk3588
>  F:     include/configs/toybrick_rk3588.h
>  F:     configs/toybrick-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-toybrick-x0.dts
> -F:     arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-toybrick-x0*
> diff --git a/board/turing/turing-rk1-rk3588/MAINTAINERS b/board/turing/tu=
ring-rk1-rk3588/MAINTAINERS
> index 4f313732fa13..973ac68836cb 100644
> --- a/board/turing/turing-rk1-rk3588/MAINTAINERS
> +++ b/board/turing/turing-rk1-rk3588/MAINTAINERS
> @@ -4,6 +4,4 @@ S:      Maintained
>  F:     board/turing/turing-rk1-rk3588
>  F:     include/configs/turing-rk1-rk3588.h
>  F:     configs/turing-rk1-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-turing-rk1.dts
> -F:     arch/arm/dts/rk3588-turing-rk1.dtsi
> -F:     arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> +F:     arch/arm/dts/rk3588-turing-rk1*
> diff --git a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS b/board/xu=
nlong/orangepi-5-ultra-rk3588/MAINTAINERS
> index be9c93f6b9d9..79981aa43f13 100644
> --- a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
> +++ b/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
> @@ -3,4 +3,4 @@ M:      Niu Zhihong <zhihong@nzhnb.com>
>  S:     Maintained
>  F:     board/xunlong/orangepi-5-rk3588-ultra
>  F:     configs/orangepi-5-ultra-rk3588_defconfig
> -F:     arch/arm/dts/rk3588-orangepi-5-ultra.dts
> +F:     arch/arm/dts/rk3588-orangepi-5-ultra*
> --
> 2.39.5
>


--=20
With best regards,
Matwey V. Kornilov
