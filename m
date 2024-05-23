Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630A9C25B79
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 03:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D68128852E;
	Thu, 23 May 2024 05:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MuwVJ7yH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFDCE881C3; Thu, 23 May 2024 05:50:04 +0200 (CEST)
Received: from mail-m49214.qiye.163.com (mail-m49214.qiye.163.com
 [45.254.49.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EBFD8852E
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 05:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=MuwVJ7yHEXab9YTefXlef2Hxe3rVKMCYy+4hqGTA3D4LpdBVxgkYLBaqW3iwLU9QSIgNo2HIDvJGVTJ0R4M7Rx4lsmN8EiwUIHkPBpO7knU5DJPeYoE96+C6Et+80lCPurybFgj9WrYDKHQJolxqRyw2BIiYaePREnnq2LJdrMU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=E8eHEUX8RJsHBN5PBvPPEDsuG6j++XH+s0sbPfl+h14=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 1AFCB9002C6;
 Thu, 23 May 2024 11:49:11 +0800 (CST)
Message-ID: <532df25b-2688-4ab4-aa72-54a5b25f0946@rock-chips.com>
Date: Thu, 23 May 2024 11:49:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] rockchip: evb-px30: do not remove pinctrl nodes
 from SPL DTB
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: jonas@kwiboo.se, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de>
 <20240521-px30-2024-07-rc-v1-9-62109c84d44f@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240521-px30-2024-07-rc-v1-9-62109c84d44f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhOSFZMH0pDSx1DSEgZTk1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8fa391326f03a9kunm1afcb9002c6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6KAw5FjMCDxwiL0k3GQE0
 QihPCkNVSlVKTEpNT0hNSk5ISU5CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISkhONwY+
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


On 2024/5/22 01:40, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> In order to be able to properly mux UART on PX30 EVB, the pinmux needs
> to be done at runtime, so let's not remove the pinctrl nodes from the
> SPL DTB.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/evb-px30_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configs/evb-px30_defconfig b/configs/evb-px30_defconfig
> index 50ce1d7a9f3..a5833ad6d09 100644
> --- a/configs/evb-px30_defconfig
> +++ b/configs/evb-px30_defconfig
> @@ -51,7 +51,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
> -CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_REGMAP=y
>
