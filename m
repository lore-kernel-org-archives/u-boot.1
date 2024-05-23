Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD941C25B79
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 03:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3479188585;
	Thu, 23 May 2024 05:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XYw82rPg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6548C88542; Thu, 23 May 2024 05:49:54 +0200 (CEST)
Received: from mail-m49241.qiye.163.com (mail-m49241.qiye.163.com
 [45.254.49.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBEFD8857A
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 05:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=XYw82rPgjZujhp4ZnZ7iPwgoZ6W0WqpQEB0yg0I8U0so+aJbjvGfIo+AzWoiXCTaW4XlpU/G8XlYR2fJ5/MqfLyl6bX4dovsSlV5K57Fw4wf9tugKa4B7PVAUx6H9BrIqsIRkBDfFlYpNOm8MBJtnWa9abxChMniDE/XUqW4iZ0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=70EKtqUOIxJJ0B1jQ6Vw16PS8HoAokXsDoV+NIiF9qU=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 22DFC9002B5;
 Thu, 23 May 2024 11:49:18 +0800 (CST)
Message-ID: <70c33524-68a9-4451-9fe6-bf3e617c61c2@rock-chips.com>
Date: Thu, 23 May 2024 11:49:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] rockchip: evb-px30: make UART5 the debug UART
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
 <20240521-px30-2024-07-rc-v1-10-62109c84d44f@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240521-px30-2024-07-rc-v1-10-62109c84d44f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx8dSFZPQktKGhhKT0sYSh1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fa391497f03a9kunm22dfc9002b5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxg6DAw5DDNDHxxML04WGUJK
 TBRPFD5VSlVKTEpNT0hNSk5CSkJLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQk5CNwY+
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
> In the Device Tree, UART5 is the system UART, but in the defconfig it
> currently is UART2. Let's sync the two by making the defconfig use UART5
> as well.
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
> index a5833ad6d09..abe545625a5 100644
> --- a/configs/evb-px30_defconfig
> +++ b/configs/evb-px30_defconfig
> @@ -10,7 +10,7 @@ CONFIG_ROCKCHIP_PX30=y
>   CONFIG_TARGET_EVB_PX30=y
>   # CONFIG_TPL_LIBCOMMON_SUPPORT is not set
>   CONFIG_SPL_DRIVERS_MISC=y
> -CONFIG_DEBUG_UART_BASE=0xFF160000
> +CONFIG_DEBUG_UART_BASE=0xff178000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART=y
>
