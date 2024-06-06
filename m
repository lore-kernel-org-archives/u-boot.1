Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E49C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 07:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 507FD883AA;
	Thu,  6 Jun 2024 09:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="K26Xkpi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79BF588199; Thu,  6 Jun 2024 09:00:56 +0200 (CEST)
Received: from mail-m49249.qiye.163.com (mail-m49249.qiye.163.com
 [45.254.49.249])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD2FB87947
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 09:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=K26Xkpi6DstG0hlC6xNCHe0uEzdZV9M19mT9oJXQX/pzK/G5Gv/hWNBI7NzonofAT/HB3cf8tK0PzR22qPZZwt4OgXMlR5xEg1vWvlAUPi5B1a5aFd4G+v6vAw0PbQZsNmRMWU/7IvckWzuTSKFNgtPS7Utc3+MDJlU4IUqcvfA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=MSjFN3YLziLaAZOiGgNZc/Zye8L4c9Zy3oo5LzRYMUU=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 37DE0900570;
 Thu,  6 Jun 2024 15:00:39 +0800 (CST)
Message-ID: <fac6fcda-ba6a-4128-a585-8dfee9e25d72@rock-chips.com>
Date: Thu, 6 Jun 2024 15:00:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 1/6] rockchip: jaguar-rk3588: use default env size
 for Rockchip on MMC
To: Quentin Schulz <foss+uboot@0leil.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240605-misc-tsd-v2-0-12479432c90f@cherry.de>
 <20240605-misc-tsd-v2-1-12479432c90f@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240605-misc-tsd-v2-1-12479432c90f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGklKSVZLS0hIH04ZQh8ZH0tVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fec59821d03a9kunm37de0900570
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pk06Gio*MjNJMDZJHh8ZFygD
 P09PFFZVSlVKTEpMTU5MSU9LTUJPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0NMNwY+
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


On 2024/6/5 23:56, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The default env size is 0x8000 when building for Rockchip SoCs with
> support for environment stored in MMC.
>
> Jaguar hasn't entered mass production just yet, so it's a breaking
> change we can afford in the name of consistency.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/jaguar-rk3588_defconfig | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
> index b69cf4cd057..36bf34d97c8 100644
> --- a/configs/jaguar-rk3588_defconfig
> +++ b/configs/jaguar-rk3588_defconfig
> @@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
>   CONFIG_SF_DEFAULT_SPEED=24000000
>   CONFIG_SF_DEFAULT_MODE=0x2000
> -CONFIG_ENV_SIZE=0x1f000
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-jaguar"
>   CONFIG_ROCKCHIP_RK3588=y
>   CONFIG_ROCKCHIP_BOOT_MODE_REG=0x0
>
