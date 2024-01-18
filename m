Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F37C47077
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 07:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A53287B85;
	Thu, 18 Jan 2024 08:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="kTfm7Slo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64E6F877FE; Thu, 18 Jan 2024 08:04:33 +0100 (CET)
Received: from mail-m25483.xmail.ntesmail.com (mail-m25483.xmail.ntesmail.com
 [103.129.254.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1572B87B8F
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 08:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=kTfm7SloCZ3WAvqf0bTQ7Vl89Q5fEUS5qyEC/KLXxoh6RHhKe4hhEGjUR36vipTCHgZQKKwiI7D/O94YK1eLHu7AkopUxrYA3V4yaorbkWmCblutj5Lmn3XAJ2KqCbyYSeWmh1KbnJnNZcTW+dOpXRnCeRQmLjX2nwphPvWKUIg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=HWK1eCLgyckbv19KbV2jAkOkgq2V8cK2QJw09aFRNU0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11873.qiye.163.com (Hmail) with ESMTPA id CDC09900498;
 Thu, 18 Jan 2024 15:04:23 +0800 (CST)
Message-ID: <ec2869d5-5ee0-4a7c-b724-1e27ef563c65@rock-chips.com>
Date: Thu, 18 Jan 2024 15:04:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] rockchip: rk3588s-orangepi-5: Build SPI image
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: John Clark <inindev@gmail.com>, Slawomir Stepien <sst@poczta.fm>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20231117232442.1430276-1-jonas@kwiboo.se>
 <20231117232442.1430276-5-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231117232442.1430276-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx5MSVYaTB5JHxgZGEJMGkhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1b629cfe2eafkusncdc09900498
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRQ6PDo5PDwZCBBKIykxGEMf
 IkIKCzlVSlVKTEtOTk1KT01PT09DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0NLNwY+
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


On 2023/11/18 07:24, Jonas Karlman wrote:
> Enable building of the SPI image, u-boot-rockchip-spi.bin, now that we
> know what bootsource id values BootRom use for SPI flash on RK3588.
>
> Fixes: 28c5f941edf7 ("board: rockchip: Add Xunlong Orange Pi 5")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - No change
>
>   configs/orangepi-5-rk3588s_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
> index feb45a53853b..1e33c832ec67 100644
> --- a/configs/orangepi-5-rk3588s_defconfig
> +++ b/configs/orangepi-5-rk3588s_defconfig
> @@ -13,6 +13,7 @@ CONFIG_SF_DEFAULT_MODE=0x2000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588s-orangepi-5"
>   CONFIG_ROCKCHIP_RK3588=y
>   CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_SPL_SERIAL=y
>   CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_TARGET_EVB_RK3588=y
