Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6035EC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 07:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E90CD88354;
	Mon, 22 Apr 2024 09:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Bboq06yH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB6088354; Mon, 22 Apr 2024 09:58:12 +0200 (CEST)
Received: from mail-m17220.xmail.ntesmail.com (mail-m17220.xmail.ntesmail.com
 [45.195.17.220])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA76D88356
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 09:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Bboq06yH/WZokbTwRhjtfxQ+tTmucQ5vPQOtHHPnUR8myuEM3Zzb0ZoJ+yvKsqyEYQniKcAC00LfnGZYA4opuQoY78osgEewNxkEg2/3E7EErU9x3xBMmLw95M6FkRRSqc37SxRbN8lipVIcnsglC3RqO3gl94OosrnZRQU81MI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=440wIo76LvFNmcJlUw4hPcJT2FbTEasjWvYM9becrtI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 9886A90029B;
 Mon, 22 Apr 2024 15:57:55 +0800 (CST)
Message-ID: <4ab7d1ec-80d2-44f0-bccb-4337951ce42e@rock-chips.com>
Date: Mon, 22 Apr 2024 15:57:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/28] rockchip: rk35xx: Drop USB_GADGET_PRODUCT_NUM
 Kconfig option
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh0aTFZDGh0aGkNPQx8fTUpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04cfc43c03a9kunm9886a90029b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NS46NBw4OjMCCDojTiEwASge
 Gh9PCg5VSlVKTEpITExJTUxNTklPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITEJKNwY+
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


On 2024/4/22 14:28, Jonas Karlman wrote:
> The commit 8c19275fdb13 ("rockchip: Update the default USB Product ID
> value") added default product id for all supported Rockchip SoCs.
>
> Remove USB_GADGET_PRODUCT_NUM options that match default value from
> RK35xx boards.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: Collect r-b tag
> v2: No change
> ---
>   configs/pinetab2-rk3566_defconfig   | 1 -
>   configs/rock5b-rk3588_defconfig     | 1 -
>   configs/turing-rk1-rk3588_defconfig | 1 -
>   3 files changed, 3 deletions(-)
>
> diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
> index bc7a77aa52fd..edeb1d89b993 100644
> --- a/configs/pinetab2-rk3566_defconfig
> +++ b/configs/pinetab2-rk3566_defconfig
> @@ -99,7 +99,6 @@ CONFIG_USB_ETHER_ASIX=y
>   CONFIG_USB_ETHER_ASIX88179=y
>   CONFIG_USB_ETHER_RTL8152=y
>   CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_PRODUCT_NUM=0x350a
>   CONFIG_USB_GADGET_DOWNLOAD=y
>   CONFIG_USB_FUNCTION_ROCKUSB=y
>   CONFIG_ERRNO_STR=y
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index 58c7c44fb4f7..ac4f1ebb4c13 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -102,7 +102,6 @@ CONFIG_USB_ETHER_MCS7830=y
>   CONFIG_USB_ETHER_RTL8152=y
>   CONFIG_USB_ETHER_SMSC95XX=y
>   CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_PRODUCT_NUM=0x350b
>   CONFIG_USB_GADGET_DOWNLOAD=y
>   CONFIG_USB_FUNCTION_ROCKUSB=y
>   CONFIG_ERRNO_STR=y
> diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
> index 07f7b848529e..e18ced721789 100644
> --- a/configs/turing-rk1-rk3588_defconfig
> +++ b/configs/turing-rk1-rk3588_defconfig
> @@ -109,7 +109,6 @@ CONFIG_USB_ETHER_MCS7830=y
>   CONFIG_USB_ETHER_RTL8152=y
>   CONFIG_USB_ETHER_SMSC95XX=y
>   CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_PRODUCT_NUM=0x350b
>   CONFIG_USB_GADGET_DOWNLOAD=y
>   CONFIG_USB_FUNCTION_ROCKUSB=y
>   CONFIG_ERRNO_STR=y
