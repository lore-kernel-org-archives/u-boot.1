Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D044C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 03:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9803287F2D;
	Tue, 12 Mar 2024 04:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dw3JQesZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB6087F1F; Tue, 12 Mar 2024 04:50:32 +0100 (CET)
Received: from mail-m6040.netease.com (mail-m6040.netease.com [210.79.60.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E75A87F28
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 04:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=dw3JQesZ9a1ui2fxwKFTrNy0onkOF9pcAY5fjiGQwo4Wj9aTQW5Zmm57ET+gI5jPWWmBJ0EyX0rB/eVot+lCq2Fqk0SjWPSV1N+HoTSAQiya5EuD3NMBckrvLAUuGu+euYgf8NzdaD+PcqvweRiTxiCZHqJFimy4sr4QjkL5iuQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=aWT81TaInU4wHAhzsM7fDAD+UsDrStLE+XOUlEziQKw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id C47D1900258;
 Tue, 12 Mar 2024 11:50:17 +0800 (CST)
Message-ID: <66a92677-79c7-40f2-bff6-1c83c39af12f@rock-chips.com>
Date: Tue, 12 Mar 2024 11:50:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/16] adc: add missing depends on ADC for controller
 drivers
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
 <20240304-rk3588-saradc-v3-14-7424e2ed5d3b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240304-rk3588-saradc-v3-14-7424e2ed5d3b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0NKT1ZMTx1LQ0lJHUpJGk5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e30c852bc03a9kunmc47d1900258
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTo6Cww*AjMNEjY4IjQcDw8a
 S0owCkJVSlVKTEpLSUpOT0pCS0xPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITUhNNwY+
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


On 2024/3/4 19:30, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> The ADC controller drivers are obviously all depending on ADC symbol
> being selected.
>
> While they don't seem to fail to build without, they won't be useful
> without that symbol selected, so let's make sure the options aren't
> shown in menuconfig when ADC isn't selected.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/adc/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/adc/Kconfig b/drivers/adc/Kconfig
> index a01d73846b7..c9cdbe6942d 100644
> --- a/drivers/adc/Kconfig
> +++ b/drivers/adc/Kconfig
> @@ -13,6 +13,7 @@ config ADC
>   
>   config ADC_EXYNOS
>   	bool "Enable Exynos 54xx ADC driver"
> +	depends on ADC
>   	help
>   	  This enables basic driver for Exynos ADC compatible with Exynos54xx.
>   	  It provides:
> @@ -22,6 +23,7 @@ config ADC_EXYNOS
>   
>   config ADC_SANDBOX
>   	bool "Enable Sandbox ADC test driver"
> +	depends on ADC
>   	help
>   	  This enables driver for Sandbox ADC device emulation.
>   	  It provides:
> @@ -31,6 +33,7 @@ config ADC_SANDBOX
>   
>   config SARADC_MESON
>   	bool "Enable Amlogic Meson SARADC driver"
> +	depends on ADC
>   	imply REGMAP
>   	help
>   	  This enables driver for Amlogic Meson SARADC.
> @@ -41,6 +44,7 @@ config SARADC_MESON
>   
>   config SARADC_ROCKCHIP
>   	bool "Enable Rockchip SARADC driver"
> +	depends on ADC
>   	help
>   	  This enables driver for Rockchip SARADC.
>   	  It provides:
>
