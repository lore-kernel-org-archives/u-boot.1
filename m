Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEA8C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94EAD88B9E;
	Fri,  9 Aug 2024 11:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="RuL+C5BA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 649ED88B9F; Fri,  9 Aug 2024 11:25:10 +0200 (CEST)
Received: from mail-m12759.qiye.163.com (mail-m12759.qiye.163.com
 [115.236.127.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0337088B81
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=RuL+C5BAEaWSV+9gYpCX9vVEgX8XajueSBLv2b1SD4oRgkEX22ayqy0Z8YIiYGdtsxGvEbdAffBgzB+9zn3WKG/EykWvNvJMX3qJptXdFfI9srFEG93duYWl/r+FaoQs73/6cxj5qnH/Y1ez4JYCdq8EonDwlYBH1YxXpstqCA8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Z3y6cLX2c4BqOe6imdPOO3S9bce4ehp7SHQOGgN7ux0=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 884F790060A;
 Fri,  9 Aug 2024 17:25:00 +0800 (CST)
Message-ID: <1708cc5b-d94f-4117-8862-105bf6d44f93@rock-chips.com>
Date: Fri, 9 Aug 2024 17:24:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] rockchip: rock5b-rk3588: Enable USB-C PD support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Tim Harvey <tharvey@gateworks.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
 <20240802180027.139193-7-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802180027.139193-7-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSUJDVhoZS0MaHUxPTkpJTlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a913674ac3c03a9kunm884f790060a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBw6Vgw4LzIxCw4hP04oDCNR
 EkMwFBJVSlVKTElISkJOTktJSk9NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlDS0I3Bg++
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


On 2024/8/3 01:59, Sebastian Reichel wrote:
> Now that all code has been prepared update the default configuration to
> make use of it.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/rock5b-rk3588_defconfig | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index fc118cea7bae..f056728d338b 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -23,6 +23,7 @@ CONFIG_FIT_VERBOSE=y
>   CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
>   CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_OF_BOARD_SETUP=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> @@ -102,3 +103,7 @@ CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DOWNLOAD=y
>   CONFIG_USB_FUNCTION_ROCKUSB=y
>   CONFIG_ERRNO_STR=y
> +CONFIG_TYPEC_TCPM=y
> +CONFIG_TYPEC_FUSB302=y
> +CONFIG_MISC_INIT_R=y
> +CONFIG_CMD_TCPM=y
