Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FDDD44D44
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:20:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B21F4891DB;
	Wed,  6 Nov 2024 11:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="c80HHf0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F28B891CE; Wed,  6 Nov 2024 11:20:23 +0100 (CET)
Received: from mail-m10130.netease.com (mail-m10130.netease.com
 [154.81.10.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C899188DB6
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f801015;
 Wed, 6 Nov 2024 18:20:17 +0800 (GMT+08:00)
Message-ID: <92c66e6a-025c-454b-be51-fdc1c5e5996b@rock-chips.com>
Date: Wed, 6 Nov 2024 18:20:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] rockchip: rk3288-tinker: Sync defconfig options
 from rk3288-tinker-s
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20241105160054.1373319-1-jonas@kwiboo.se>
 <20241105160054.1373319-8-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105160054.1373319-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9PHVZCQ0pCSU1OQh1ISE1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9300fd3fc403afkunm1f801015
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTo6MTo6GTIZLDE5GRZOSU0v
 KwMaChxVSlVKTEhLQ0NDT0pDSUNCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0JDNwY+
DKIM-Signature: a=rsa-sha256;
 b=c80HHf0DijPPQR8nQOiiZ2JfiFRat3rYRheWduzFN4JCU6qyq78KQOd9OZMbOr0Mqo912RM1wzDHRx96xAiwjhHigHT1e+V5HWsfyEOg4HVW0IXOsFkB8yR20cSpGUu5Edo9c9RxIsmwRVpXBnM5kMKYimtNsErSeTKL7yUPI70=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=LKXRS73qHES/sP/DTVA6/FaHAnAjHa9SGK5UF+kxsn8=;
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


On 2024/11/6 00:00, Jonas Karlman wrote:
> Add missing Kconfig options used by the rk3288-tinker-s variant.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/tinker-rk3288_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
> index 851c312d4db5..0c2fd573b67b 100644
> --- a/configs/tinker-rk3288_defconfig
> +++ b/configs/tinker-rk3288_defconfig
> @@ -41,6 +41,7 @@ CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
>   CONFIG_CMD_USB_MASS_STORAGE=y
>   # CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_BMP=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_TIME=y
>   CONFIG_CMD_PMIC=y
> @@ -92,8 +93,10 @@ CONFIG_USB_ETHER_SMSC95XX=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DWC2_OTG=y
>   CONFIG_VIDEO=y
> +# CONFIG_VIDEO_BPP8 is not set
>   CONFIG_DISPLAY=y
>   CONFIG_VIDEO_ROCKCHIP=y
>   CONFIG_DISPLAY_ROCKCHIP_HDMI=y
> +CONFIG_CONSOLE_SCROLL_LINES=10
>   CONFIG_CMD_DHRYSTONE=y
>   CONFIG_ERRNO_STR=y
