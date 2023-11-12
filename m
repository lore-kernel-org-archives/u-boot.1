Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C11C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 10:39:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A2987083;
	Sun, 12 Nov 2023 11:39:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TCWnchYU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1033187083; Sun, 12 Nov 2023 11:39:51 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4D2A87049
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 11:39:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=face=GZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1699785583;
 bh=5r3XKYbaXIyrBQee06N4xxBka8qu/Gr2JBQjfg/lTn0=;
 b=TCWnchYU1yRJRDeliGmqw0ivMs40pfa9/3hfYZv5TLEWlQdrcnOfEfGY1oAa6ol4WGWi4UHmU
 wKLtLH4rHapfxTo/itBUuBo5W85MJb0lLbZUlGhGGO8KqIVEZgcX4V4qIcGq71MNbbK36Xth36k
 qLaFJZdIu8eCy0BfYH5Y5Ri7D3gAQl6hZd5tEVWv9whgXQwSLoEaRku7fydcDziWk2mB8rhS0nQ
 mlX721+R+jJI+0gh/Oy6G36kpMIswXKZcD7wA0+azTVCDGlnZXXywKjlyOFEIKuHbmbpNoVgY52
 2mPuHj0wPaemX2BLLdd0Tblx2d8PD4N8XU/Gf1QeIy+A==
Message-ID: <d1e624f3-d761-4822-bcb4-f81ab4d78663@kwiboo.se>
Date: Sun, 12 Nov 2023 11:39:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockpro64: Enable SPI command and full BOOTSTD
To: Shantur Rathore <i@shantur.com>, kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
References: <20231111001329.537704-1-i@shantur.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20231111001329.537704-1-i@shantur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6550ab6f0ab7c055f71230c7
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

On 2023-11-11 01:13, Shantur Rathore wrote:
> RockPro64 has a 16MB onboard SPI chip and current u-boot takes
> around 2MB, we can enable more features.
> Updating config to enable SPI commands and full BootSTD support.
> ---
>  configs/rockpro64-rk3399_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
> index 4cd6b76665..cad0b8a5d7 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -46,10 +46,12 @@ CONFIG_CMD_BOOTZ=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_PCI=y
> +CONFIG_CMD_SPI=y

The CMD_SPI is not used to interact with the SPI flash.

CMD_SF is already enabled and you can use "sf probe" and any other sf
related action to interact with the SPI flash on this board.

>  CONFIG_CMD_USB=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_TIME=y
>  CONFIG_CMD_BOOTSTAGE=y
> +CONFIG_BOOTSTD_FULL=y

What is the reasoning behind enabling full bootstd commands? Especially
why just this board need it enabled by default.

Standard boot is already fully functional, it just does not have full
features commands enabled by default.

Regards,
Jonas

>  CONFIG_SPL_OF_CONTROL=y
>  CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>  CONFIG_ENV_IS_IN_SPI_FLASH=y

