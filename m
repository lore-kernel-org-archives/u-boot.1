Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEA6CA1000
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9C10836B2;
	Sat, 30 Aug 2025 17:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="G7/WVoRT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E82838C2; Sat, 30 Aug 2025 17:25:33 +0200 (CEST)
Received: from mail-m3272.qiye.163.com (mail-m3272.qiye.163.com
 [220.197.32.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 210C1836B2
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123f98b6;
 Sat, 30 Aug 2025 23:25:26 +0800 (GMT+08:00)
Message-ID: <17d83e11-871c-4096-a548-f1122a480c1a@rock-chips.com>
Date: Sat, 30 Aug 2025 23:25:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] rockchip: rk3528-radxa-e20c: Enable USB gadget
 Kconfig options
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250730235301.1774089-1-jonas@kwiboo.se>
 <20250730235301.1774089-9-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250730235301.1774089-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb955b8103afkunmbba21694415967
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSEofVklJQ09DTB5KTh9MTVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lCTUpKVUpLS1
 VLWQY+
DKIM-Signature: a=rsa-sha256;
 b=G7/WVoRTpoOxSUWCAJj8f1d9phjVdAjCKo5uJd+R+tbIlFkbbKKpNXVZZZKs/HY/WNgDgHCraeKHguGtiSG2Fwj4Dww0JXqd8k6b87+Xl+1Pjzpxd5jwPRld7cc6qL/fZhGu6srKrceVvmdZaNIDkXqHcia4tDMlTNf5IjoO4hw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=G776UG3Ka76Vj6jpaTMilAGIKUrlVWf8XtmkfQoHThI=;
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


On 2025/7/31 07:52, Jonas Karlman wrote:
> Radxa E20C has a USB OTG Type-C port for Debug and Data.
>
> Add required Kconfig options to use USB gadget features once pending
> USB nodes finally lands in dts/upstream by a future sync.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> USB nodes for RK3528 has not yet landed in linux-rockchip maintainer
> tree, however USB features have been verified working in U-Boot using
> current pending DT patches.
> ---
>   configs/radxa-e20c-rk3528_defconfig | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/configs/radxa-e20c-rk3528_defconfig b/configs/radxa-e20c-rk3528_defconfig
> index f5e097f3edf8..0941d1b9be81 100644
> --- a/configs/radxa-e20c-rk3528_defconfig
> +++ b/configs/radxa-e20c-rk3528_defconfig
> @@ -20,6 +20,8 @@ CONFIG_CMD_GPT=y
>   CONFIG_CMD_MISC=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_CMD_RNG=y
>   CONFIG_CMD_REGULATOR=y
> @@ -28,6 +30,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
>   CONFIG_BUTTON=y
>   CONFIG_BUTTON_ADC=y
>   CONFIG_BUTTON_GPIO=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y
> @@ -43,6 +46,7 @@ CONFIG_DM_MDIO=y
>   CONFIG_DWC_ETH_QOS=y
>   CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>   CONFIG_REGULATOR_PWM=y
>   CONFIG_DM_REGULATOR_GPIO=y
>   CONFIG_PWM_ROCKCHIP=y
> @@ -50,6 +54,12 @@ CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
>   CONFIG_ERRNO_STR=y
