Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4065CA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7916C8383A;
	Sat, 30 Aug 2025 17:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XgbEiOWA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9051E83857; Sat, 30 Aug 2025 17:35:10 +0200 (CEST)
Received: from mail-m49235.qiye.163.com (mail-m49235.qiye.163.com
 [45.254.49.235])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99B768380E
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123f99e5
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 23:35:04 +0800 (GMT+08:00)
Message-ID: <bdb0a18f-a3aa-4f0e-9378-37a6fa759367@rock-chips.com>
Date: Sat, 30 Aug 2025 23:35:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3568-nanopi-r5s: Enable ROCKUSB on NanoPi R5S
To: u-boot@lists.denx.de
References: <20250731125108.184224-1-didi.debian@cknow.org>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250731125108.184224-1-didi.debian@cknow.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb9e2c9303afkunm293e4a2e4184a1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHU5OVk4eTxpJSxgZHk4YT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0hKSkJMVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=XgbEiOWAY819eWyQEeq1LUrUGIaz8A0r/ckEz53Y13ch5nDKxYOMyEwj29DY1z5hYKW68aZDGNZmfgQ4Z5h6TxF63uWB1sjKsrly6taq9V0g3MbeDgqPQpwMmVd/9POj4e1XqDLw5cQh0BEgvX+ALntck0YhPTriymCdOyDUGCs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=n3wM8NcHE4pP9ZnFX32QdcBNYSqImNX6cfVQcVT/SeU=;
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


On 2025/7/31 20:47, Diederik de Haas wrote:
> Enable the needed modules so that ROCKUSB can be used to update the
> NanoPi R5S.
>
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> The needed DeviceTree parts landed in Linus' tree here:
> https://git.kernel.org/linus/07e04c071a35abe12957b575cd1453ccafc02eb6
>
> and will be part of upstream kernel 6.17.
>
>   configs/nanopi-r5s-rk3568_defconfig | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
> index 8e5e7e3e1e5..1653ab8b44f 100644
> --- a/configs/nanopi-r5s-rk3568_defconfig
> +++ b/configs/nanopi-r5s-rk3568_defconfig
> @@ -28,6 +28,8 @@ CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_PCI=y
>   CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_CMD_PMIC=y
>   CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
> @@ -38,6 +40,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_CLK=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
> @@ -73,4 +76,8 @@ CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
>   CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
>   CONFIG_ERRNO_STR=y
