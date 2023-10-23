Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA2FCDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 10:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEA41878C7;
	Mon, 23 Oct 2023 12:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Y3gEKrZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62550878CC; Mon, 23 Oct 2023 12:02:38 +0200 (CEST)
Received: from mail-m12754.qiye.163.com (mail-m12754.qiye.163.com
 [115.236.127.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A38B87243
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 12:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Y3gEKrZFyI6nhQve6/0OKtLVOaErmpTWSOrgLxEoq/OaFJCrPcwDq1XmEEeK7e8Lhct9n5PJSQnRmciFv+QMk7DuoxVlL/YLfSWr69ipPFl/A8CzHwsYadTnDjrFwqGmzkogAlg3wZC+2w9ppwnOoqObrm7vqsNC+YBu53dxcIw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=UkiNDkC02G66hXp3Adf53yaJ/jnh6FD8bCwZAkQ56CA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id E560E4003BC;
 Mon, 23 Oct 2023 18:02:27 +0800 (CST)
Message-ID: <f267d504-eb96-4d92-86c3-68b10ffe15ae@rock-chips.com>
Date: Mon, 23 Oct 2023 18:02:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] rockchip: rk3588-rock-5a: Enable support for USB
 2.0 ports
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de
References: <20231017170216.1627789-1-jonas@kwiboo.se>
 <20231017170216.1627789-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231017170216.1627789-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhgaGVZDTx8fTR8fGkpPSB1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b5bfc5f882eb3kusne560e4003bc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Njo6Khw5VjwwNTgDFBgTQiEo
 LhUaChBVSlVKTUJDS05OSE9DTUtLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISUhMNwY+
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


On 2023/10/18 01:02, Jonas Karlman wrote:
> Enable Kconfig options for the two USB 2.0 ports and bottom USB 3.0 port
> on ROCK 5 Model A.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever

> ---
> v2:
> - New patch
>
>   configs/rock5a-rk3588s_defconfig | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
> index bccdb1e3ecd6..a6471a519514 100644
> --- a/configs/rock5a-rk3588s_defconfig
> +++ b/configs/rock5a-rk3588s_defconfig
> @@ -39,13 +39,16 @@ CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_ATF=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_CLK=y
> @@ -61,12 +64,23 @@ CONFIG_MMC_SDHCI_ROCKCHIP=y
>   CONFIG_PHY_REALTEK=y
>   CONFIG_DWC_ETH_QOS=y
>   CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
>   CONFIG_SPL_PINCTRL=y
> -CONFIG_REGULATOR_PWM=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_ERRNO_STR=y
