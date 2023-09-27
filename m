Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15699E7F153
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 02:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89DA086D62;
	Wed, 27 Sep 2023 04:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hMA3JIA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B91486D67; Wed, 27 Sep 2023 04:56:38 +0200 (CEST)
Received: from mail-m49239.qiye.163.com (mail-m49239.qiye.163.com
 [45.254.49.239])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF6586D5D
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 04:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=hMA3JIA7iHkmbHfVNSxPqIaN7JZzi+fUezd/kePa9CM8IvVGxkwwDyxpu5euBdvjQrB1p96IzHjLqcWpXSnOUgXDceU3baYbk9PXjoxymTPLrNWzAeo/cse4Z7k6K0wAjjEb4U1b3ZULPm0OD8dLPuCqpOTgxDHC0cGB/IvsAO8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=P7bBTA1eSLWBJQmx5sSIWsz5DFxQ5CP6z+a3GJbE1tI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id C9B46400291;
 Wed, 27 Sep 2023 10:56:26 +0800 (CST)
Message-ID: <69f7f4ed-0d3d-2255-a575-ccf25031bb23@rock-chips.com>
Date: Wed, 27 Sep 2023 10:56:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] rockchip: rk356x-u-boot: Add bootph-all to i2c0_xfer
 pinctrl node
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Chris Morgan <macromorgan@hotmail.com>
Cc: u-boot@lists.denx.de
References: <20230803210239.3998777-1-jonas@kwiboo.se>
 <20230803210239.3998777-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230803210239.3998777-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR5PHlYYT0hCTktJGBhOQ0hVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad490ff552eb3kusnc9b46400291
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MCI6Tio*IjwwOjZLIx4XQh0a
 FkowCjhVSlVKTUJOTENISENMTkhCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQkhONwY+
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


On 2023/8/4 05:02, Jonas Karlman wrote:
> A RK8XX PMIC is typically using i2c0 on RK356x devices. Add bootph-all
> to required pinctrl nodes to simplify use of the prevent booting on
> power plug-in option in SPL.
>
> With the following Kconfig options and nodes in u-boot.dtsi the prevent
> booting on power plug-in option can work in SPL.
>
>    CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
>    CONFIG_SPL_I2C=y
>    CONFIG_SPL_POWER=y
>    CONFIG_SPL_PINCTRL=y
>    CONFIG_SPL_PMIC_RK8XX=y
>
>    &i2c0 {
>    	bootph-pre-ram;
>    };
>    
>    &rk817 {
>    	bootph-pre-ram;
>    
>    	regulators {
>    		bootph-pre-ram;
>    	};
>    };
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk356x-u-boot.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> index d21b18205220..fe7de0dd4bc8 100644
> --- a/arch/arm/dts/rk356x-u-boot.dtsi
> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> @@ -64,6 +64,10 @@
>   	bootph-all;
>   };
>   
> +&pcfg_pull_none_smt {
> +	bootph-all;
> +};
> +
>   &pcfg_pull_none {
>   	bootph-all;
>   };
> @@ -100,6 +104,10 @@
>   	bootph-all;
>   };
>   
> +&i2c0_xfer {
> +	bootph-all;
> +};
> +
>   &sdmmc0_bus4 {
>   	bootph-all;
>   };
