Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F31C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 04:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DFAD870EF;
	Tue,  7 Nov 2023 05:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ewiFrdGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D0F486CB1; Tue,  7 Nov 2023 05:03:50 +0100 (CET)
Received: from mail-m17235.xmail.ntesmail.com (mail-m17235.xmail.ntesmail.com
 [45.195.17.235])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B2A887098
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 05:03:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ewiFrdGmwfFQhQjIuqtkeIQzpYC94lSSx5QxdiIbvkC2zttitfbVHgsQb1VCwQjBc12O89VxrWjXQoSGd09e6o2eK3WNi0tm4WsxzgbF7h4vWhrbArSvLMMAmy+AOfk5uDr5VhXw6fjtPgHKvHpfDqQ7Qb5Dnad13di9N6WFPqQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=e7cy0Dyy76/LOhCw9sW/L7PaIVTfoLZzmNS9EdvTWfI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 32EEB4002C9;
 Tue,  7 Nov 2023 12:03:37 +0800 (CST)
Message-ID: <dcc8287b-cc55-411d-9997-006eb7a9d8aa@rock-chips.com>
Date: Tue, 7 Nov 2023 12:03:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rv1126: Read cpuid from otp and set ethaddr
Content-Language: en-US
To: Tim Lunn <tim@feathertop.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
References: <20231031020715.684460-1-tim@feathertop.org>
 <20231031020715.684460-3-tim@feathertop.org>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231031020715.684460-3-tim@feathertop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh9NS1ZOSEkZThpDSENMHktVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8ba7f33b0f2eb3kusn32eeb4002c9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MU06ERw6FjwwHxUNES4yMRcM
 ARIKCw1VSlVKTUJCSElCQ0pMQkpKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTUxLNwY+
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


On 2023/10/31 10:07, Tim Lunn wrote:
> Provide configuration to read cpuid and generate a persistant
> MAC address in ethaddr
>
> Signed-off-by: Tim Lunn <tim@feathertop.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rv1126-u-boot.dtsi | 12 ++++++++++++
>   arch/arm/mach-rockchip/Kconfig  |  2 ++
>   2 files changed, 14 insertions(+)
>
> diff --git a/arch/arm/dts/rv1126-u-boot.dtsi b/arch/arm/dts/rv1126-u-boot.dtsi
> index 5e348278f2..811a3cee98 100644
> --- a/arch/arm/dts/rv1126-u-boot.dtsi
> +++ b/arch/arm/dts/rv1126-u-boot.dtsi
> @@ -15,6 +15,18 @@
>   		compatible = "rockchip,rv1126-dmc";
>   		bootph-all;
>   	};
> +
> +	otp: otp@ff5c0000 {
> +		compatible = "rockchip,rv1126-otp";
> +		reg = <0xff5c0000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		status = "okay";
> +
> +		cpu_id: id@7 {
> +			reg = <0x07 0x10>;
> +		};
> +	};
>   };
>   
>   &gpio0 {
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index a6c69c300d..5e993383cf 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -359,6 +359,8 @@ config ROCKCHIP_RV1126
>   	select BOARD_LATE_INIT
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply OF_LIBFDT_OVERLAY
> +	imply ROCKCHIP_OTP
> +	imply MISC_INIT_R
>   	imply TPL_DM
>   	imply TPL_LIBCOMMON_SUPPORT
>   	imply TPL_LIBGENERIC_SUPPORT
