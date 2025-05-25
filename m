Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4427C54ED0
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 18:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17C9B82B48;
	Sun, 25 May 2025 20:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="E+WZaNw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C83C782C38; Sun, 25 May 2025 20:56:59 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D0182B37
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 20:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=671e=YK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1748199415;
 bh=vP6CsQYJsUn0iffnkKZpsJphDepoWaUtX36DbG1htJI=;
 b=E+WZaNw+IJUF88w2zwa2fJtc39SOKpwgO6/43HRLnjydCL+S98yTOjGtvjDx4h5FNvaulsoOr
 fNNeMpGmEdMzANlCdLZ41iSCzR23UO8+rdKYcuH9negyAB8qZ3WbpgQodBJfeHozbTShLA9J1cn
 5p6QtjxVxq8MEU1TqZ7BUnA0gcIIA8QbHUkVJ2aPPoC3YtksB2/VSEXn6TmlTTn0+8sdq8XmvyW
 d//g/mfSowE2rOAq+zzBdnipkcrNdcZ4RFjZlaPVZ+w5QkcX6d0moNJQ5oJQdkRkdHxiq6Mi6Zk
 04W1fvHTUmQ6QcsHnCalSW99G/mnfI1UnbAdD0gZLJhA==
X-Forward-Email-ID: 683367f4a0e3f2dd0ce22e15
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <bec7b0ff-139d-43eb-99aa-8348f444a932@kwiboo.se>
Date: Sun, 25 May 2025 20:56:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/25] rockchip: Add TPL alternatives
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250525104801.1440260-1-sjg@chromium.org>
 <20250525104801.1440260-12-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250525104801.1440260-12-sjg@chromium.org>
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

Hi Simon,

On 2025-05-25 12:47, Simon Glass wrote:
> The TPL image must be built for each board we need to support. It is the
> only part of the image which is board-specific.

This is most likely only a must for VBE/VPL use, make it clear that
these changes are related to VBE/VPL in the commit message.

> 
> This helps to save space and reduce the size of TPL, so that it can fit
> within the internal 192K IRAM of the RK3399 SoC.
> 
> As with other phases, the TPL devicetree is run through fdtgrep to
> remove unwanted nodes and properties and reduce its size.
> 
> Update the fdtmap so it is at the end of the image, since templates are
> added after existing nodes.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v4:
> - Put the fdtmap at the end of the image
> - Update the comment at the end of the '#ifndef CONFIG_VPL' block
> 
> Changes in v2:
> - Mention RK3399 with respect to the memory limit
> - Move VPL things into a separate file
> 
>  arch/arm/dts/rockchip-u-boot.dtsi     |  3 ++-
>  arch/arm/dts/rockchip-vpl-u-boot.dtsi | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 18669f73402..905706c68e7 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -171,6 +171,7 @@
>  		filename = "u-boot-rockchip.bin";
>  		pad-byte = <0xff>;
>  
> +#ifndef CONFIG_VPL
>  		mkimage {
>  			filename = "idbloader.img";
>  			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> @@ -196,10 +197,10 @@
>  #endif
>  			offset = <CONFIG_SPL_PAD_TO>;
>  		};
> -#endif

This was wrongly added in a prior patch.

>  
>  		fdtmap {
>  		};
> +#endif /* !VPL */

Since you are replacing everything inside simple-bin I think it would be
better to wrap the entire node and re-declare your own vpl/vbe variant
inside rockchip-vpl-u-boot.dtsi.

Regards,
Jonas

>  	};
>  
>  #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
> index 0d767113408..c5d55b87164 100644
> --- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
> @@ -111,6 +111,22 @@
>  	};
>  
>  	simple-bin {
> +		alternates-fdt {
> +			fdt-list-dir = "dts/upstream/src/arm64/rockchip";
> +			filename-pattern = "alt-NAME.bin";
> +			fdt-phase = "tpl";
> +
> +			mkimage {
> +				filename = "idbloader.img";
> +				args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> +				multiple-data-files;
> +
> +				u-boot-tpl {
> +					symbols-base = <0>;
> +				};
> +			};
> +		};
> +
>  		vpl {
>  			type = "fit";
>  			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200 + 0x8000)>;
> @@ -199,5 +215,7 @@
>  			insert-template = <&fit_template>;
>  		};
>  # endif /* VBE method */
> +		fdtmap {
> +		};
>  	};
>  };

