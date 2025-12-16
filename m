Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D647D609BB
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 16:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D917B83106;
	Tue, 16 Dec 2025 17:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="I/LmtEuE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F9468334F; Tue, 16 Dec 2025 17:12:02 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 250378042F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 17:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8106=6X=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1765901517;
 bh=XsVHxK9N23BrzlF2RrHC55BPsZIGm57lc3Ai7n+j944=;
 b=I/LmtEuElm/pMJo1BZ37IJv1103MqNmNzyo+NGvHzc+eeMGnGnt4D+elIay2dOsq9W5mqNl/0
 vqCKUDgbhW2JI4dNqh2H2VMiFYIVnULXLFwbXq+N+Ho+AuZGhdntubuV325gxCsORsHBgNC3QK9
 9vz62Dkxv3getdlnFeOROUtj1CZD9dQ/X6C1Gxg0+sjeKYYgjggoH/+2SfmJ7imLfeda0a+lI6M
 gYoCqk6WwQ+gVh6f7mf3FV9+ffGa/kALDDuUeydlxbsqlWRy2kOPc/1dh5D992LFFFPTjnSCusV
 wm7cKiHVtSByzSopbKOZLo/+33go4XMS4kg0vdq72wfw==
X-Forward-Email-ID: 694184c5fc3bc9a5657cf9d8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b729be6e-3091-4aa1-af7b-266a94bbcc66@kwiboo.se>
Date: Tue, 16 Dec 2025 17:11:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: make rksd the default format for SPI
 images
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20251216-rockchip-more-template-v2-0-6372e27fc689@cherry.de>
 <20251216-rockchip-more-template-v2-2-6372e27fc689@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20251216-rockchip-more-template-v2-2-6372e27fc689@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Quentin,

On 12/16/2025 12:26 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> I believe (hope) that the new SoCs should now have this fixed and not
> require the "hack" implemented in rkspi format which almost doubles the
> size of TPL+SPL (idbloader.img).
> 
> It's known to be fixed on RK3566/RK3568, RK3576 and RK3588(S) (according
> to the DTS setting the mkimage format for the SPI's idbloader.img to
> rksd explicitly).
> 
> Since I do not have any board with a bootable SPI flash except on RK3399
> where this work-around is required, I simply invert the logic by having
> rkspi explicitly set for all SoCs that didn't and remove rksd from SoCs
> that did. It doesn't mean that the SoC actually requires rkspi format,
> just that it's been the case until now (maybe because nobody tested).
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  arch/arm/dts/px30-u-boot.dtsi     | 12 ++++++++++++
>  arch/arm/dts/rk3036-u-boot.dtsi   | 13 +++++++++++++
>  arch/arm/dts/rk3066a-u-boot.dtsi  | 12 ++++++++++++
>  arch/arm/dts/rk3128-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rk3188-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rk322x-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rk3288-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rk3308-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rk3326-u-boot.dtsi   |  1 -
>  arch/arm/dts/rk3328-u-boot.dtsi   |  1 -
>  arch/arm/dts/rk3368-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rk3399-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rk3528-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rk356x-u-boot.dtsi   |  1 -
>  arch/arm/dts/rk3576-u-boot.dtsi   |  1 -
>  arch/arm/dts/rk3588s-u-boot.dtsi  |  1 -
>  arch/arm/dts/rockchip-u-boot.dtsi |  1 -
>  arch/arm/dts/rv1108-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rv1126-u-boot.dtsi   | 12 ++++++++++++
>  19 files changed, 157 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/dts/px30-u-boot.dtsi b/arch/arm/dts/px30-u-boot.dtsi
> index 2f726b0aaba..7385de7d6ae 100644
> --- a/arch/arm/dts/px30-u-boot.dtsi
> +++ b/arch/arm/dts/px30-u-boot.dtsi
> @@ -27,6 +27,18 @@
>  	};
>  };
>  
> +#ifdef CONFIG_SPL
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
> +		};
> +	};
> +};
> +#endif
> +#endif

This is probably wrong, rk3326 use rksd format.

Also seeing how the rk3308 has a later model number than PX30/RK3326
I would guess that this also applies to RK3308.

See USB_GADGET_PRODUCT_NUM:

	default 0x330a if ROCKCHIP_RK3368
	default 0x330c if ROCKCHIP_RK3399
	default 0x330d if ROCKCHIP_PX30
	default 0x330e if ROCKCHIP_RK3308
	default 0x350a if ROCKCHIP_RK3568
	default 0x350b if ROCKCHIP_RK3588
	default 0x350c if ROCKCHIP_RK3528
	default 0x350e if ROCKCHIP_RK3576

> +
>  &otp {
>  	bootph-some-ram;
>  };

[snip]

> diff --git a/arch/arm/dts/rk3528-u-boot.dtsi b/arch/arm/dts/rk3528-u-boot.dtsi
> index a18d33b3d36..f21d76b0e6e 100644
> --- a/arch/arm/dts/rk3528-u-boot.dtsi
> +++ b/arch/arm/dts/rk3528-u-boot.dtsi
> @@ -30,6 +30,18 @@
>  	};
>  };
>  
> +#ifdef CONFIG_SPL
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
> +		};
> +	};
> +};
> +#endif
> +#endif

This is wrong, please drop for rk3528. I have commits pending for adding
proper SPI flash boot support on RK3528 once the E24C model lands in
upstream linux, see commits at [1].

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528

Regards,
Jonas

> +
>  &cru {
>  	bootph-all;
>  };

[snip]
