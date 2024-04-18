Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D27C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 14:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D27A1885FA;
	Thu, 18 Apr 2024 16:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="oy6WjBaf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3917088648; Thu, 18 Apr 2024 16:52:28 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DB40885F8
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 16:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2b74=LY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1713451930;
 bh=XiggmLC636OV3sEcVWbicFh2Uc7yZIQ13tYUm2hpK/s=;
 b=oy6WjBafnyWrPDvn60/Ecf+XrcJMn25AFfmfy7hPZu+J7aGq1QaX1fAnaUzuWu+8v97QKbGf4
 /DNnDDKz5zREIqEsZrp6bEhMr28rioyfHkqUCv1DdKMawEDsYt+orT1aCxzGXxHihdNOBvRhoPA
 Z5r3xBriQsBV2JC2EldunBk6TNTi5/13/CWHlqI3qiHJZURXsndz4Gobui7tgbJvP+tIiOa4Yqz
 8iq5EpE4o9mNB78n71CXcqYizRDwizHWZgfhJCMgTDH2PG8ysET7l5HZCTFygOzKMwy6c1UNLP3
 PytM4PSqMP4Ovczb/PvcIAlhYUqa+UoakPjOkWwCLhcg==
Message-ID: <bb92e94b-bb01-47ea-8df5-5e4cf4f5bb2c@kwiboo.se>
Date: Thu, 18 Apr 2024 16:52:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: nanopi-r4s: Fix ehci usb error
To: Justin Klaassen <justin@tidylabs.app>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 u-boot@lists.denx.de
References: <20240418014552.5773-1-justin@tidylabs.app>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240418014552.5773-1-justin@tidylabs.app>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 662133988594af1e6267de94
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

Hi Justin,

On 2024-04-18 03:45, Justin Klaassen wrote:
> The ehci_generic driver always failed with the error:
> Bus usb@fe380000: ehci_generic usb@fe380000:
> ... Failed to get clocks (ret=-19)
> Port not available.
> Bus usb@fe3c0000: ehci_generic usb@fe3c0000:
> ... Failed to get clocks (ret=-19)
> Port not available.
> 
> This error is resolved by enabling the CONFIG_PHY_ROCKCHIP_INNO_USB2
> and CONFIG_PHY_ROCKCHIP_TYPEC driver options.

Is your issue also fixed with my series "rockchip: rk3399: Sync DT with
linux v6.8 and update defconfigs" [1] containing patch [2]? A v2 of that
series should hit the mailing list sometime tomorrow.

[1] https://patchwork.ozlabs.org/cover/1918319/
[2] https://patchwork.ozlabs.org/patch/1918346/

> 
> The CONFIG_DM_RESET option must also be enabled, otherwise the
> ehci_generic driver will fail with the error:
> Bus usb@fe380000: ehci_generic usb@fe380000:
> ... Failed to get resets (err=-524)
> probe failed, error -524
> Bus usb@fe3c0000: ehci_generic usb@fe3c0000:
> ... Failed to get resets (err=-524)
> probe failed, error -524
> 
> Additionally the u2phy1_host device was previously disabled in the
> nanopi-r4s device tree and must be enabled to avoid a crash in the
> ehci_generic driver:
> Bus usb@fe380000: USB EHCI 1.00
> Bus usb@fe3c0000: "Synchronous Abort" handler, esr 0x96000010, far 0x0
> 
> With these changes the usb ports can now be initialized correctly by
> both the ehci_generic and xhci_generic drivers:
> Bus usb@fe380000: USB EHCI 1.00
> Bus usb@fe3c0000: USB EHCI 1.00
> Bus usb@fe800000: Register 2000140 NbrPorts 2
> Starting the controller
> USB XHCI 1.10
> Bus usb@fe900000: Register 2000140 NbrPorts 2
> Starting the controller
> USB XHCI 1.10
> scanning bus usb@fe380000 for devices... 1 USB Device(s) found
> scanning bus usb@fe3c0000 for devices... 1 USB Device(s) found
> scanning bus usb@fe800000 for devices... 1 USB Device(s) found
> scanning bus usb@fe900000 for devices... 1 USB Device(s) found
>        scanning usb for storage devices... 0 Storage Device(s) found
> 
> Signed-off-by: Justin Klaassen <justin@tidylabs.app>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> ---
>  arch/arm/dts/rk3399-nanopi-r4s.dts  | 2 +-
>  configs/nanopi-r4s-rk3399_defconfig | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/rk3399-nanopi-r4s.dts b/arch/arm/dts/rk3399-nanopi-r4s.dts
> index cef4d18b599..a992a6ac5e9 100644
> --- a/arch/arm/dts/rk3399-nanopi-r4s.dts
> +++ b/arch/arm/dts/rk3399-nanopi-r4s.dts
> @@ -117,7 +117,7 @@
>  };
>  
>  &u2phy1_host {
> -	status = "disabled";
> +	phy-supply = <&vdd_5v>;

This does not match upstream linux device tree file. If this change is
needed please submit a change to linux kernel, else make a U-Boot
specific change in rk3399-nanopi-r4s-u-boot.dtsi.

Regards,
Jonas

>  };
>  
>  &uart0 {
> diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
> index ea01d323541..d8c34dc48cb 100644
> --- a/configs/nanopi-r4s-rk3399_defconfig
> +++ b/configs/nanopi-r4s-rk3399_defconfig
> @@ -5,6 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
>  CONFIG_NR_DRAM_BANKS=1
>  CONFIG_ENV_OFFSET=0x3F8000
>  CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-r4s"
> +CONFIG_DM_RESET=y
>  CONFIG_ROCKCHIP_RK3399=y
>  CONFIG_TARGET_EVB_RK3399=y
>  CONFIG_DEBUG_UART_BASE=0xFF1A0000
> @@ -36,6 +37,8 @@ CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_ROCKCHIP=y
>  CONFIG_ETH_DESIGNWARE=y
>  CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_TYPEC=y
>  CONFIG_PMIC_RK8XX=y
>  CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y

