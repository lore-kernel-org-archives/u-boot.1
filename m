Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A73C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 01:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71121888FB;
	Tue, 16 Jul 2024 03:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DeM4/Vxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1422888FB; Tue, 16 Jul 2024 03:56:16 +0200 (CEST)
Received: from mail-m17241.xmail.ntesmail.com (mail-m17241.xmail.ntesmail.com
 [45.195.17.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20E738887A
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 03:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=DeM4/VxjN/2AYwwlp8G7UrwVppdxtywPK0wDtWgfTmzjHP/cJW9u7B86vvPRv10MVxNy0Yg0hGw22HV16H/vqn+WpyL8fxZYS/9kl6x0KFOiDulRGTBdYhUrA27HIDkYG3AMsd0FvZIH1wo9k355wRxncUaXw92Ea0ztIWqLumQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=LxQnrmvb88DwfLL0gleNH73oHBjf485++9rDDku3C74=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 1B8629003A5;
 Tue, 16 Jul 2024 09:56:00 +0800 (CST)
Message-ID: <5a6600fa-63f6-49f2-9ba2-f0ca60d61367@rock-chips.com>
Date: Tue, 16 Jul 2024 09:55:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 4/4] rockchip: puma-rk3399: add button support
To: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger
 <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240614-ringneck-no-gadget-v1-0-d3bc6e5088de@cherry.de>
 <20240614-ringneck-no-gadget-v1-4-d3bc6e5088de@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240614-ringneck-no-gadget-v1-4-d3bc6e5088de@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRlDTVYZThhDQh5DGRpJGUNWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b940f55603a9kunm1b8629003a5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTI6Mxw4VjIyPhgyMD5MEQo3
 VhwaCwFVSlVKTElKS0JPQk1LQk9JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0JPNwY+
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


On 2024/6/14 19:04, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The Haikou Devkit exposes 4 buttons over GPIO so let's enable their
> support so their status can be queried from the `button` command from
> the CLI.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/puma-rk3399_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index 5319239f989..bc9a79107e0 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -56,6 +56,8 @@ CONFIG_ENV_SPI_MAX_HZ=50000000
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_SYS_MMC_ENV_DEV=1
>   CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_GPIO=y
>   CONFIG_GPIO_HOG=y
>   CONFIG_SPL_GPIO_HOG=y
>   CONFIG_ROCKCHIP_GPIO=y
>
