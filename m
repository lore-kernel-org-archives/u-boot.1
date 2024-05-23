Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9805CC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 03:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7FAC8852F;
	Thu, 23 May 2024 05:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DqI7NBKm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DF4C8852F; Thu, 23 May 2024 05:49:39 +0200 (CEST)
Received: from mail-m127204.xmail.ntesmail.com
 (mail-m127204.xmail.ntesmail.com [115.236.127.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9B9088542
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 05:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=DqI7NBKm3IhMy9d5i/n3pYG2KhNzcBysPq0dqm3xF6ZEc5JQbS3VMxfhgwLuK8dwSzwHnpfqjJ4XS9Hlg9xTkSQjUL3FX5+oIJtRdbmN8D1XOngp3CKvdZjDcxqBfoccYd7QTv1FUXAQgsakETQhfFJ2W2XvSXmPU7biOrtfVpg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=nCZFGymYW74nelMHty2Xb32Ahcg8lDSw0sfgwny+eqY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id EDBDF9002EF;
 Thu, 23 May 2024 11:49:03 +0800 (CST)
Message-ID: <48aceb81-72a7-4d7c-9b97-8aebf8a2dc67@rock-chips.com>
Date: Thu, 23 May 2024 11:49:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] rockchip: px30: make UART pinmux accessible to
 TPL/SPL DTB
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
 <20240521-px30-2024-07-rc-v1-8-62109c84d44f@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240521-px30-2024-07-rc-v1-8-62109c84d44f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU9NSlZLHkgYH0tDSU1CQx9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8fa391125303a9kunmedbdf9002ef
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxQ6SCo4LTNCExwWP0kwGUMu
 T1YaFDhVSlVKTEpNT0hNSk9OSklPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS0NJNwY+
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
> This adds the default pinmux for UART2 and UART5 to the TPL/SPL DTB (if
> not removed through the CONFIG_OF_SPL_REMOVE_PROPS symbol) as those two
> controllers are always made available to all boards.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/px30-u-boot.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/dts/px30-u-boot.dtsi b/arch/arm/dts/px30-u-boot.dtsi
> index 046da022ffe..59fa9f43a97 100644
> --- a/arch/arm/dts/px30-u-boot.dtsi
> +++ b/arch/arm/dts/px30-u-boot.dtsi
> @@ -33,11 +33,27 @@
>   	bootph-all;
>   };
>   
> +&uart2m0_xfer {
> +	bootph-all;
> +};
> +
>   &uart5 {
>   	clock-frequency = <24000000>;
>   	bootph-all;
>   };
>   
> +&uart5_cts {
> +	bootph-all;
> +};
> +
> +&uart5_rts {
> +	bootph-all;
> +};
> +
> +&uart5_xfer {
> +	bootph-all;
> +};
> +
>   &sdmmc {
>   	bootph-all;
>   
>
