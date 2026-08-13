Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B80C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 13:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B53B860B0F;
	Thu, 13 Aug 2026 13:52:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rimQbQMhISqP; Thu, 13 Aug 2026 13:52:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 95885606D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786629145;
	bh=HzfG6BTmhWE1fSEpznPEfl53nd2oIf68AO9cw9xT8ps=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hhgW8TVpC4z4lDx6y7NP8Spi6fxk5lygVupoW0kAXwF6sp4M5ZL4gEOMnl1Be2k3g
	 assocbzpOPBYeZ/ttbJDls6bvojvSP+vspQb9KH8HB6IXHd7TmBsQLyaXCaz7vpvPV
	 O5FCQqKcnBmnwsURD3zGXMG8Vt5f3JFALO0+Am4GYYWO0OtrP/YC3wS6ar76+UMMa+
	 qHWflpgibjUh6ljR8uqCDD4BWZwNSty5DAs4pT7QwTBZ2n9yEo1q51Oe7RqeVUxWSP
	 bOt+FnOBr1yAv8oXGFrY4zRsAbvU5KaKb/YRuVOBBtAscReoRXMZTIapg+cVN/022o
	 ZfNeC5oQddb6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95885606D3;
	Thu, 13 Aug 2026 13:52:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 27462198
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18A1E407A8
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PhN5nJ-1dZG8 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 13:52:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:b8b8::190b; helo=smtp-190b.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 94800407A4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94800407A4
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::190b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94800407A4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:52:21 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hLRcf6tkfzLSZ;
 Thu, 13 Aug 2026 15:52:18 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hLRcd5NQlzjv2; Thu, 13 Aug 2026 15:52:17 +0200 (CEST)
Message-ID: <e3bc74a3-d62d-4e3e-bd60-5a82c9508f1c@0leil.net>
Date: Thu, 13 Aug 2026 15:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] rockchip: rk3399: Add ROC-PC-PLUS board detection
To: Fabio Estevam <festevam@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260813114445.51640-1-festevam@gmail.com>
 <20260813114445.51640-3-festevam@gmail.com>
Content-Language: en-US
In-Reply-To: <20260813114445.51640-3-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786629138;
 bh=HzfG6BTmhWE1fSEpznPEfl53nd2oIf68AO9cw9xT8ps=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=do/ZtHDOgyHZ2Ys4cPtEtKbRKArQWTziPHgfI62q8prKqBAwo0NN/gZIuIiKgPWTe
 n5EGARY6Do5aRvBOYmQYAVjm5rhe2YFgv0fTaJ81bJxIe1fOnzPAfGgO72zITic3YK
 5hbgZgXKAoMMs7bA5Jt+p3Gmk7IzsSXb+ACHNK+1mfRS3H2BrOuN211wDDed2Y020z
 MVLI4CA3hUPAYD3YypLLX/2EQrnGnWes108rh51+hZ1eGeqcMvqEz5PTcH7U5bw6p5
 DpgEq/BXVpiGYO4UkvZ6x1QcWL9JdlHnX16uD7ne+6gArrpO7bCU3SDgZrct4vkT0i
 49Pbpev5gDntg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=do/ZtHDO
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Fabio,

On 8/13/26 1:44 PM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> The ROC-RK3399-PC has an MP8859 regulator on I2C7 at address 0x66,
> while the ROC-RK3399-PC-PLUS does not. Probe for the regulator in SPL
> and use the result to select the matching devicetree from the U-Boot
> FIT. Fall back to the original board if the I2C bus cannot be probed.
> 
> Build both devicetrees from the existing roc-pc-rk3399_defconfig and
> enable the XMC SPI NOR driver used by the Plus variant. Set fdtfile
> from the selected U-Boot devicetree so the matching Linux devicetree
> is used as well.
> 
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Changes since v4:
> - Fixed mezzanine build error.
> 
>   arch/arm/dts/rk3399-roc-pc-u-boot.dtsi      |  8 ++++
>   board/firefly/roc-pc-rk3399/roc-pc-rk3399.c | 42 +++++++++++++++++++++
>   configs/roc-pc-rk3399_defconfig             |  3 ++
>   doc/board/rockchip/rockchip.rst             |  2 +-
>   4 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> index a85e9549c83..e7e4a2c8907 100644
> --- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> @@ -12,6 +12,14 @@
>   	};
>   };
>   
> +&i2c7 {
> +	bootph-pre-ram;
> +};
> +
> +&i2c7_xfer {
> +	bootph-pre-ram;
> +};
> +
>   &gpio4 {
>   	bootph-pre-ram;
>   };
> diff --git a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> index 6937a27176f..8f54e526c19 100644
> --- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> +++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> @@ -5,14 +5,24 @@
>   
>   #include <dm.h>
>   #include <env.h>
> +#include <fdtdec.h>
> +#include <i2c.h>
> +#include <image.h>
>   #include <log.h>
>   #include <spl_gpio.h>
> +#include <asm/global_data.h>
>   #include <asm/io.h>
>   
>   #include <asm/arch-rockchip/cru.h>
>   #include <asm/arch-rockchip/gpio.h>
>   #include <asm/arch-rockchip/grf_rk3399.h>
>   
> +#define ROC_PC_MP8859_BUS	"i2c@ff160000"
> +#define ROC_PC_MP8859_ADDR	0x66
> +#define ROC_PC_PLUS_FDTFILE	"rockchip/rk3399-roc-pc-plus.dtb"
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
>   #ifdef CONFIG_XPL_BUILD
>   
>   #define PMUGRF_BASE	0xff320000
> @@ -54,4 +64,36 @@ void led_setup(void)
>   	spl_gpio_output(gpio0, GPIO(BANK_B, 5), 1);
>   }
>   
> +static bool is_roc_pc_plus(void)
> +{
> +	struct udevice *bus, *dev;
> +
> +	if (!(CONFIG_IS_ENABLED(I2C) && CONFIG_IS_ENABLED(DM_I2C)))
> +		return false;
> +
> +	if (uclass_get_device_by_name(UCLASS_I2C, ROC_PC_MP8859_BUS, &bus))
> +		return false;
> +
> +	return !dm_i2c_probe(bus, ROC_PC_MP8859_ADDR, 0, &dev);

Between v4 and v5, the exclamation point now inverts the result of 
dm_i2c_probe and I believe this is incorrect.

dm_i2c_probe returns 0 if a chip was found, -ve otherwise. The 
ROC-RK3399-PC-PLUS does NOT have this chip, therefore is_roc_pc_plus() 
should return false (0) when the chip is NOT detected, meaning we should 
NOT invert dm_i2c_probe(). Is this correct?

Cheers,
Quentin
