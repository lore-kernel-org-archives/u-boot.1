Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415DBC04FFE
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0852886C3;
	Thu, 18 Apr 2024 19:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tidylabs.app
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.app header.i=@tidylabs.app header.b="IaSMbzPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1756488688; Thu, 18 Apr 2024 17:48:03 +0200 (CEST)
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A184488662
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 17:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tidylabs.app
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.app
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
 by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4VL2H31nVbz3x6f
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 17:47:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tidylabs.app; s=key2;
 t=1713455279; bh=fCJzLEbLBWBPjZ1wLlIpe9yd0rbq3m6cE8/2yYOw2Zs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=IaSMbzPdaC7w/83gucfV5ZQEV++D3BdBBsg5QfyaCZBOtOHO4O1/GvRe1tTQSpNQU
 XeFFXt5m01qGq+3yj+xK83jrQfOw4qRtd0rnOlmAO8ZzRWMXWhZHDWdhY6lwoIKzSw
 KwhqQXV0+jct6snKT0v8+BtXs8BElzqI7k/2chwEmsSfr4omFCT+4c232svPagLqwV
 Dw9THtH2486jAzKNBc4XVgwVL8VRXN/WNN7fNbe1xhupkdLfDxjeJNCOAv295GTzs1
 8EIc6qwBzj9hm1NZ7LI4eYlH+FOFW5wGhSNLKDgZhu7R0+J0RPlZ6Ug6xKOrxICh8K
 vRPjHw/SOuyAw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4VL2H313qNz3x4Y
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 17:47:59 +0200 (CEST)
Received: from mx2ecc.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4VL2H26PxWz8sgS
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 17:47:58 +0200 (CEST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by mx2ecc.netcup.net (Postfix) with ESMTPSA id 74E331A003D
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 17:47:54 +0200 (CEST)
Authentication-Results: mx2ecc;
 spf=pass (sender IP is 209.85.218.50) smtp.mailfrom=justin@tidylabs.app
 smtp.helo=mail-ej1-f50.google.com
Received-SPF: pass (mx2ecc: connection is authenticated)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-a555b203587so110290166b.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 08:47:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXSBRwvqNMXY0PUlLX9NOn1fqU0ycwo4GQ2C6P5Zg8hcSBuuKDvWdF5aD1CXZHncWBbvYFHAQdczIHpxDkvIJGRNqfLrA==
X-Gm-Message-State: AOJu0Yxnb/dYiAEpNUQSVT67muGWYvjm5joty2wYOc1RaMV+yVGzppFx
 uDC4yoM39rhREO6bf+S0STmgf5IvgcSPuSyZRKNuT4zfJ9xSlsxfeLz6MztlyyuWnZIVoCMNidr
 OyNXa8LKZ6HRpYKRAGRHvrirICDg=
X-Google-Smtp-Source: AGHT+IE/bmH+/UNqnPkCLYWpKw6OtNVlINDk4tD4gILP3ILzyyLbTpgF/YgdPQbUx0H3DP0nQ7tNoNwjkWCjQ48XqAk=
X-Received: by 2002:a17:906:a190:b0:a51:c7ec:fa42 with SMTP id
 s16-20020a170906a19000b00a51c7ecfa42mr2614182ejy.73.1713455274299; Thu, 18
 Apr 2024 08:47:54 -0700 (PDT)
Received: from 1064022179695 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Apr 2024 15:47:53 +0000
Received: from 1064022179695 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Apr 2024 15:47:52 +0000
MIME-Version: 1.0 (Mimestream 1.2.6)
References: <20240418014552.5773-1-justin@tidylabs.app>
 <bb92e94b-bb01-47ea-8df5-5e4cf4f5bb2c@kwiboo.se>
In-Reply-To: <bb92e94b-bb01-47ea-8df5-5e4cf4f5bb2c@kwiboo.se>
From: Justin Klaassen <justin@tidylabs.app>
Date: Thu, 18 Apr 2024 15:47:53 +0000
X-Gmail-Original-Message-ID: <CAK2wXtmBaHv6xaY1fPvTmpUMrFECXbF-E95xBemoyzf-FxKORA@mail.gmail.com>
Message-ID: <CAK2wXtmBaHv6xaY1fPvTmpUMrFECXbF-E95xBemoyzf-FxKORA@mail.gmail.com>
Subject: Re: [PATCH] rockchip: nanopi-r4s: Fix ehci usb error
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
X-Rspamd-Queue-Id: 74E331A003D
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: 1XWksLyqO8TL47q5JiNSIzcurEwDnwNiJPpFYF//bZftE8Y=
X-Mailman-Approved-At: Thu, 18 Apr 2024 19:33:17 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

 Hi Jonas,

On Apr 18, 2024 at 07:52:03, Jonas Karlman <jonas@kwiboo.se> wrote:

> Hi Justin,
>
> On 2024-04-18 03:45, Justin Klaassen wrote:
>
> The ehci_generic driver always failed with the error:
>
> Bus usb@fe380000: ehci_generic usb@fe380000:
>
> ... Failed to get clocks (ret=-19)
>
> Port not available.
>
> Bus usb@fe3c0000: ehci_generic usb@fe3c0000:
>
> ... Failed to get clocks (ret=-19)
>
> Port not available.
>
>
> This error is resolved by enabling the CONFIG_PHY_ROCKCHIP_INNO_USB2
>
> and CONFIG_PHY_ROCKCHIP_TYPEC driver options.
>
>
> Is your issue also fixed with my series "rockchip: rk3399: Sync DT with
> linux v6.8 and update defconfigs" [1] containing patch [2]? A v2 of that
> series should hit the mailing list sometime tomorrow.
>
> [1] https://patchwork.ozlabs.org/cover/1918319/
> [2] https://patchwork.ozlabs.org/patch/1918346/
>
>
It looks like your patch does include all the necessary config changes from
my patch, so that should resolve the issue.


> The CONFIG_DM_RESET option must also be enabled, otherwise the
>
> ehci_generic driver will fail with the error:
>
> Bus usb@fe380000: ehci_generic usb@fe380000:
>
> ... Failed to get resets (err=-524)
>
> probe failed, error -524
>
> Bus usb@fe3c0000: ehci_generic usb@fe3c0000:
>
> ... Failed to get resets (err=-524)
>
> probe failed, error -524
>
>
> Additionally the u2phy1_host device was previously disabled in the
>
> nanopi-r4s device tree and must be enabled to avoid a crash in the
>
> ehci_generic driver:
>
> Bus usb@fe380000: USB EHCI 1.00
>
> Bus usb@fe3c0000: "Synchronous Abort" handler, esr 0x96000010, far 0x0
>
>
> With these changes the usb ports can now be initialized correctly by
>
> both the ehci_generic and xhci_generic drivers:
>
> Bus usb@fe380000: USB EHCI 1.00
>
> Bus usb@fe3c0000: USB EHCI 1.00
>
> Bus usb@fe800000: Register 2000140 NbrPorts 2
>
> Starting the controller
>
> USB XHCI 1.10
>
> Bus usb@fe900000: Register 2000140 NbrPorts 2
>
> Starting the controller
>
> USB XHCI 1.10
>
> scanning bus usb@fe380000 for devices... 1 USB Device(s) found
>
> scanning bus usb@fe3c0000 for devices... 1 USB Device(s) found
>
> scanning bus usb@fe800000 for devices... 1 USB Device(s) found
>
> scanning bus usb@fe900000 for devices... 1 USB Device(s) found
>
>        scanning usb for storage devices... 0 Storage Device(s) found
>
>
> Signed-off-by: Justin Klaassen <justin@tidylabs.app>
>
> Cc: Simon Glass <sjg@chromium.org>
>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
>
> Cc: Kever Yang <kever.yang@rock-chips.com>
>
> ---
>
>  arch/arm/dts/rk3399-nanopi-r4s.dts  | 2 +-
>
>  configs/nanopi-r4s-rk3399_defconfig | 3 +++
>
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
>
> diff --git a/arch/arm/dts/rk3399-nanopi-r4s.dts
> b/arch/arm/dts/rk3399-nanopi-r4s.dts
>
> index cef4d18b599..a992a6ac5e9 100644
>
> --- a/arch/arm/dts/rk3399-nanopi-r4s.dts
>
> +++ b/arch/arm/dts/rk3399-nanopi-r4s.dts
>
> @@ -117,7 +117,7 @@
>
>  };
>
>
>
>  &u2phy1_host {
>
> - status = "disabled";
>
> + phy-supply = <&vdd_5v>;
>
>
> This does not match upstream linux device tree file. If this change is
> needed please submit a change to linux kernel, else make a U-Boot
> specific change in rk3399-nanopi-r4s-u-boot.dtsi.
>

I tested your patch (without this change) and it does result in the same
crash:

Bus usb@fe380000: USB EHCI 1.00
Bus usb@fe3c0000: "Synchronous Abort" handler, esr 0x96000010, far 0x0
elr: 0000000000241c7c lr : 0000000000241c68 (reloc)
elr: 00000000f3f72c7c lr : 00000000f3f72c68
x0 : 0000000000000000 x1 : 0000000000007d08
x2 : 0000000000007d0c x3 : 0000000000007d40
x4 : 000000000000f6c4 x5 : 0000000000010ab0
x6 : 0000000000007d0c x7 : 00000000f1f182e0
x8 : 0000000000007d08 x9 : 00000000f1f179dc
x10: 0000000000000002 x11: 0000000000007c8c
x12: 00000000f1f17aac x13: 00000000f1f182e0
x14: 0000000000000002 x15: 00000000f1f17684
x16: 00000000f3f71b94 x17: 00000000409ff249
x18: 00000000f1f28da0 x19: 00000000f1f5b2a0
x20: 0000000000000000 x21: 00000000f1f5b100
x22: 00000000f1f5b280 x23: 00000000f1f5b290
x24: 00000000f1f5b2a0 x25: 0000000000000000
x26: 00000000f3fd2d3d x27: 0000000000000001
x28: 0000000000000000 x29: 00000000f1f17ac0

While this change should probably be upstreamed to the linux device tree
file, I think we need something more immediate to prevent this crash/boot
loop once your change lands.

Do you prefer to incorporate this change into your patch or do you want me
to update this patch?

Thanks,
Justin


> Regards,
> Jonas
>
>  };
>
>
>
>  &uart0 {
>
> diff --git a/configs/nanopi-r4s-rk3399_defconfig
> b/configs/nanopi-r4s-rk3399_defconfig
>
> index ea01d323541..d8c34dc48cb 100644
>
> --- a/configs/nanopi-r4s-rk3399_defconfig
>
> +++ b/configs/nanopi-r4s-rk3399_defconfig
>
> @@ -5,6 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>
>  CONFIG_NR_DRAM_BANKS=1
>
>  CONFIG_ENV_OFFSET=0x3F8000
>
>  CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-r4s"
>
> +CONFIG_DM_RESET=y
>
>  CONFIG_ROCKCHIP_RK3399=y
>
>  CONFIG_TARGET_EVB_RK3399=y
>
>  CONFIG_DEBUG_UART_BASE=0xFF1A0000
>
> @@ -36,6 +37,8 @@ CONFIG_MMC_SDHCI=y
>
>  CONFIG_MMC_SDHCI_ROCKCHIP=y
>
>  CONFIG_ETH_DESIGNWARE=y
>
>  CONFIG_GMAC_ROCKCHIP=y
>
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>
> +CONFIG_PHY_ROCKCHIP_TYPEC=y
>
>  CONFIG_PMIC_RK8XX=y
>
>  CONFIG_REGULATOR_PWM=y
>
>  CONFIG_REGULATOR_RK8XX=y
>
>
>
