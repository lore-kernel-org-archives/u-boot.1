Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A31FC27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 09:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD20C88998;
	Fri, 14 Jun 2024 11:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PCvglxkp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0567C88962; Fri, 14 Jun 2024 11:30:57 +0200 (CEST)
Received: from mail-m127224.xmail.ntesmail.com
 (mail-m127224.xmail.ntesmail.com [115.236.127.224])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54F7B88993
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 11:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=PCvglxkpmQUeJNQ/FcDobV4vfV8tS28RfVYVpprH9H9Z16xhv/83KtEgfXbKMfe8YMbYKL3dy3wpe+FyovZjaYOhqKBuPwbdOsvAIhvwkiV2dyv4stYDpF/HeO+z6LnYeFVEnKbjTeTd9iFjxGm1XPoB2nZ9CLYLMMgUEnoPMP8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=RJE2hHwLQLgPP+NIpXzyGyFNirn077bRwxBd5PjAseM=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 8D748900720;
 Fri, 14 Jun 2024 17:30:13 +0800 (CST)
Message-ID: <9595fb4f-0d79-49a9-8c5e-014051c1b778@rock-chips.com>
Date: Fri, 14 Jun 2024 17:30:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: puma-rk3399: get closer to other Theobroma
 defconfigs
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, heiko@sntech.de
References: <20240612-ringneck-bootd-v1-0-f0bc3816b822@cherry.de>
 <20240612-ringneck-bootd-v1-2-f0bc3816b822@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240612-ringneck-bootd-v1-2-f0bc3816b822@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGRlKVk5ITEpKTBpNT0oaSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a90161552bd03a9kunm8d748900720
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MSI6SCo5FDNOGhQrGA0hURMy
 ITVPFA9VSlVKTEpDSE5MT0pOS05MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhLTk43Bg++
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


On 2024/6/12 22:40, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Disable support for unused OSes as Linux is the primary target.
>
> Disable support for bootz as zImage isn't a format compatible with
> Aarch64 machines so it should never be attempted to be booted.
>
> Enable a bunch of commands:
>   - erofs
>   - gpio
>   - squashfs
>
> that could be useful and are also found in Jaguar and Tiger defconfigs.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/puma-rk3399_defconfig | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index 34a0b575991..3196b5e24b1 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -29,7 +29,12 @@ CONFIG_SPL_I2C=y
>   CONFIG_SPL_POWER=y
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_TPL=y
> -CONFIG_CMD_BOOTZ=y
> +# CONFIG_BOOTM_NETBSD is not set
> +# CONFIG_BOOTM_PLAN9 is not set
> +# CONFIG_BOOTM_RTEMS is not set
> +# CONFIG_CMD_VBE is not set
> +# CONFIG_BOOTM_VXWORKS is not set
> +CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
> @@ -41,6 +46,8 @@ CONFIG_CMD_CACHE=y
>   CONFIG_CMD_TIME=y
>   CONFIG_CMD_PMIC=y
>   CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_EROFS=y
> +CONFIG_CMD_SQUASHFS=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_OVERWRITE=y
>
