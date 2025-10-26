Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE0FCCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F774838D2;
	Sun, 26 Oct 2025 16:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OI9z7pMD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 407DA838D7; Sun, 26 Oct 2025 16:46:25 +0100 (CET)
Received: from mail-m3273.qiye.163.com (mail-m3273.qiye.163.com
 [220.197.32.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4B8A832AD
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 273749046;
 Sun, 26 Oct 2025 23:46:19 +0800 (GMT+08:00)
Message-ID: <41c22d50-d162-413c-b790-356ec50dacde@rock-chips.com>
Date: Sun, 26 Oct 2025 23:46:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/18] rockchip: odroid-go2: Enable more commands
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250831165001.2749711-1-jonas@kwiboo.se>
 <20250831165001.2749711-17-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250831165001.2749711-17-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2132f7c303afkunmad89d6ab4d358c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEgZVkIfTh9NT0hITx0YGVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lIQkhCVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=OI9z7pMDZgpr1bSTpuxexRD3Z8ikSIEQl+4nncXv4tm2B1l9rNScZTpIKJ8sGsvV8RI0raALEPj1Nz4BdPDrojtPP1ZnqrsxM2ljGB2gD8O7PvyYu4ecWCs/sVyEEWmBzcIabRryOa80PZePIeDLHJLkgj9znBVSG+UbaH6RFd8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=2ViMk3nR0fS0hLqEFfB2nQs+tXIZJ8W+UxwMZ4QD6nY=;
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


On 2025/9/1 00:49, Jonas Karlman wrote:
> Enable the default commands and some more useful commands that can be
> useful to determin the state of the board from U-Boot CLI.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   configs/odroid-go2_defconfig | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
> index 70d74c65a2f3..512ffefc70f6 100644
> --- a/configs/odroid-go2_defconfig
> +++ b/configs/odroid-go2_defconfig
> @@ -42,22 +42,21 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
>   CONFIG_SPL_ATF=y
>   # CONFIG_TPL_FRAMEWORK is not set
>   # CONFIG_TPL_BANNER_PRINT is not set
> -# CONFIG_CMD_BOOTD is not set
> -# CONFIG_CMD_ELF is not set
> -# CONFIG_CMD_IMI is not set
> -# CONFIG_CMD_XIMG is not set
> -# CONFIG_CMD_LZMADEC is not set
> -# CONFIG_CMD_UNZIP is not set
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_PWM=y
>   CONFIG_CMD_GPT=y
> -# CONFIG_CMD_LOADB is not set
> -# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MISC=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_POWEROFF=y
>   CONFIG_CMD_USB=y
>   CONFIG_CMD_ROCKUSB=y
>   CONFIG_CMD_USB_MASS_STORAGE=y
> -# CONFIG_CMD_ITEST is not set
> -# CONFIG_CMD_SLEEP is not set
> +CONFIG_CMD_RNG=y
> +CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_ISO_PARTITION is not set
>   CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

