Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51D0D0C601
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 322CB89023;
	Fri, 25 Oct 2024 14:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hVipXjUP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAACE89023; Fri, 25 Oct 2024 14:04:43 +0200 (CEST)
Received: from mail-m3296.qiye.163.com (mail-m3296.qiye.163.com
 [220.197.32.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 618B189035
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ebe59cc;
 Fri, 25 Oct 2024 20:04:36 +0800 (GMT+08:00)
Message-ID: <d18f269f-68de-4ea9-ae92-31b71a47933d@rock-chips.com>
Date: Fri, 25 Oct 2024 20:04:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/4] board: rockchip: Remove ARM SCMI Support from RGxx3
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, dsimic@manjaro.org, quentin.schulz@cherry.de,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240919140022.511067-1-macroalpha82@gmail.com>
 <20240919140022.511067-4-macroalpha82@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240919140022.511067-4-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk1JQ1YdSh5CTh1ISUtMHhhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c390718209d6kunmebe59cc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NDo6MQw5FDIoFxdWA04sSiks
 TkwaCkNVSlVKTElCQ05MQ0xMTUpOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0pMNwY+
DKIM-Signature: a=rsa-sha256;
 b=hVipXjUPQSBF0Kdzs1BiT+rEx6bVPUl8RrE9D+SKccVFKdYzRk3XqH3aPSvNBOAbD+rAwUkSxUnIWY28FpSj97CtuQK18Mg8h5b/+pTHlyjCxkOcGXVe3aDTUIWOgMprIqBUV1Wmp+ONUDbjyHA4115LmbYeQvVXf3u6OodAJj4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=XphTDAibf2hSx9aOYDiii6D/Asy+f3jpWK2G+3+rr5w=;
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


On 2024/9/19 22:00, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Remove config options for ARM SCMI. It is not required to boot the
> board and when using the most recent mainline A-TF it actually causes
> the device to freeze during boot due to missing SCMI support.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/anbernic-rgxx3-rk3566_defconfig | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
> index f5e5470df8c..49d3766613e 100644
> --- a/configs/anbernic-rgxx3-rk3566_defconfig
> +++ b/configs/anbernic-rgxx3-rk3566_defconfig
> @@ -49,8 +49,6 @@ CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_ADC=y
>   CONFIG_SPL_CLK=y
> -CONFIG_ARM_SMCCC_FEATURES=y
> -CONFIG_SCMI_FIRMWARE=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
