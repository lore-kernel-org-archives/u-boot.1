Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC75D5E124
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 03:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB17F88C66;
	Fri,  8 Nov 2024 04:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BVkyBTSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7293288C75; Fri,  8 Nov 2024 04:28:55 +0100 (CET)
Received: from mail-m3289.qiye.163.com (mail-m3289.qiye.163.com
 [220.197.32.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02F3388B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 227617c2;
 Fri, 8 Nov 2024 11:28:45 +0800 (GMT+08:00)
Message-ID: <154c9c85-caa9-4d80-9fdc-2587851758c6@rock-chips.com>
Date: Fri, 8 Nov 2024 11:28:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 1/4] pinctrl: rockchip: allow to build for TPL
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Paul Kocialkowski <paulk@sys-base.io>,
 Paul Kocialkowski <contact@paulk.fr>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20241106-rk3399-sysreset-gpio-tpl-v2-0-22aa82189eb6@cherry.de>
 <20241106-rk3399-sysreset-gpio-tpl-v2-1-22aa82189eb6@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241106-rk3399-sysreset-gpio-tpl-v2-1-22aa82189eb6@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ05JTFYZTxkeHk5PSh5OS0xWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9309d133ff03afkunm227617c2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAw6Lgw5EzIYHitJPA5MTj4a
 CjAKFD9VSlVKTEhKS0hNTklNQkNKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS0pMNwY+
DKIM-Signature: a=rsa-sha256;
 b=BVkyBTSVx+PSX/TUNGFp4aknkYTbE0jmsTVZVG55pb2ROobjp7akrqADNOzqsHRHBeZChfvakj+0vpLFs4mSRsOInfGmfhaax2HAqLRUMXWKsuFcGKmLn9yTpHyniEecRMuiXqy/dEdObZDqra5ubFYnw+z1Qu/nwoERTxiST8E=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=2ADuVhLtWZ9F0B13CF72AhXd+PWhG6ypjgkahlLlqIg=;
 h=date:mime-version:subject:message-id:from;
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


On 2024/11/6 19:29, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> A later commit will make use of the pinctrl driver in TPL so let's add
> the ability to build the Rockchip pinctrl driver in TPL.
>
> Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/pinctrl/Kconfig          | 8 ++++++++
>   drivers/pinctrl/rockchip/Kconfig | 7 +++++++
>   2 files changed, 15 insertions(+)
>
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index a1d53cfbdbed5ef1030fff04715e1436f167554b..6ee7dc1cce8da08e13b898c541d047bad9e3c89b 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -127,6 +127,14 @@ config SPL_PINCTRL_GENERIC
>   	  This option is an SPL-variant of the PINCTRL_GENERIC option.
>   	  See the help of PINCTRL_GENERIC for details.
>   
> +config TPL_PINCTRL_GENERIC
> +	bool "Support generic pin controllers in TPL"
> +	depends on TPL_PINCTRL_FULL
> +	default y
> +	help
> +	  This option is a TPL-variant of the PINCTRL_GENERIC option.
> +	  See the help of PINCTRL_GENERIC for details.
> +
>   config SPL_PINMUX
>   	bool "Support pin multiplexing controllers in SPL"
>   	depends on SPL_PINCTRL_GENERIC
> diff --git a/drivers/pinctrl/rockchip/Kconfig b/drivers/pinctrl/rockchip/Kconfig
> index dc4ba34ae5d581be76786fd05d679d26397fd467..8aa9dcac35873d99f9dd28ed18232b52a9f4343a 100644
> --- a/drivers/pinctrl/rockchip/Kconfig
> +++ b/drivers/pinctrl/rockchip/Kconfig
> @@ -14,4 +14,11 @@ config SPL_PINCTRL_ROCKCHIP
>   	help
>   	  This option is an SPL-variant of the PINCTRL_ROCKCHIP option.
>   
> +config TPL_PINCTRL_ROCKCHIP
> +	bool "Support Rockchip pin controllers in TPL"
> +	depends on ARCH_ROCKCHIP && TPL_PINCTRL_GENERIC
> +	default y
> +	help
> +	  This option is a TPL-variant of the PINCTRL_ROCKCHIP option.
> +
>   endif
>
