Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D830C52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51B3588B80;
	Fri,  9 Aug 2024 11:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jxKCQu6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D5988BC8; Fri,  9 Aug 2024 11:34:07 +0200 (CEST)
Received: from mail-m12771.qiye.163.com (mail-m12771.qiye.163.com
 [115.236.127.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 093DA881C3
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=jxKCQu6Z46HIvLXyJEYTUYa9TBoy/Ebd09Z89xthw+csKlHz1mYVcBf6qDUcj1QBIDq756T5+qnK0FPyKz11yOombDWLUIcStOrHYDc2wErjh0Vca8v53iVoMXHJUPCdUYcfSthoybqWvYbRKg9yqu4i0tcmCkKhajFNScneNOs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Gb+lrN2n9pCNa6r43C2jAtFQ7e1YBV8nPvJE9ZHF/8U=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 895F19004AB;
 Fri,  9 Aug 2024 17:33:53 +0800 (CST)
Message-ID: <0d9e9936-bdec-4e68-b3d4-462377c16bd7@rock-chips.com>
Date: Fri, 9 Aug 2024 17:33:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] dm: adc: Add SPL_ADC Kconfig symbol for use of ADC
 in SPL
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20240802221231.2629416-1-jonas@kwiboo.se>
 <20240802221231.2629416-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802221231.2629416-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHR5NVh8eSB5MSxhMTh4aQ1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a91367ccc8503a9kunm895f19004ab
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pi46STo6NzI2MQ4NEA40Mhwe
 GkIaCxJVSlVKTElISkJNS0hPTE5CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhDQk83Bg++
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


On 2024/8/3 06:12, Jonas Karlman wrote:
> What model of Radxa ZERO 3W/3E board can be identified using ADC at
> runtime, add a Kconfig symbol to allow use of ADC in SPL.
>
> This will be used to identify board model in SPL to allow loading
> correct FIT configuration and FDT for U-Boot proper at SPL phase.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - Drop depends on ADC and instead use $(SPL_TPL_) for adc-uclass.o
> - Add depends on DM/SPL_DM to ADC/SPL_ADC
> ---
>   drivers/Makefile     | 2 +-
>   drivers/adc/Kconfig  | 5 +++++
>   drivers/adc/Makefile | 2 +-
>   3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 9195dafd37e0..1acd94f3c17e 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   
> +obj-$(CONFIG_$(SPL_TPL_)ADC) += adc/
>   obj-$(CONFIG_$(SPL_TPL_)BIOSEMU) += bios_emulator/
>   obj-$(CONFIG_$(SPL_TPL_)BLK) += block/
>   obj-$(CONFIG_$(SPL_TPL_)BOOTCOUNT_LIMIT) += bootcount/
> @@ -81,7 +82,6 @@ endif
>   
>   ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
>   
> -obj-y += adc/
>   obj-y += ata/
>   obj-$(CONFIG_DM_DEMO) += demo/
>   obj-y += block/
> diff --git a/drivers/adc/Kconfig b/drivers/adc/Kconfig
> index c9cdbe6942de..37235f557a3c 100644
> --- a/drivers/adc/Kconfig
> +++ b/drivers/adc/Kconfig
> @@ -1,5 +1,6 @@
>   config ADC
>   	bool "Enable ADC drivers using Driver Model"
> +	depends on DM
>   	help
>   	  This enables ADC API for drivers, which allows driving ADC features
>   	  by single and multi-channel methods for:
> @@ -11,6 +12,10 @@ config ADC
>   	  - support supply's phandle with auto-enable
>   	  - supply polarity setting in fdt
>   
> +config SPL_ADC
> +	bool "Enable ADC drivers using Driver Model in SPL"
> +	depends on SPL_DM
> +
>   config ADC_EXYNOS
>   	bool "Enable Exynos 54xx ADC driver"
>   	depends on ADC
> diff --git a/drivers/adc/Makefile b/drivers/adc/Makefile
> index 5336c820973a..dca0b39c2e27 100644
> --- a/drivers/adc/Makefile
> +++ b/drivers/adc/Makefile
> @@ -4,7 +4,7 @@
>   # Przemyslaw Marczak <p.marczak@samsung.com>
>   #
>   
> -obj-$(CONFIG_ADC) += adc-uclass.o
> +obj-$(CONFIG_$(SPL_TPL_)ADC) += adc-uclass.o
>   obj-$(CONFIG_ADC_EXYNOS) += exynos-adc.o
>   obj-$(CONFIG_ADC_SANDBOX) += sandbox.o
>   obj-$(CONFIG_SARADC_ROCKCHIP) += rockchip-saradc.o
