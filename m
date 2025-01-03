Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA02E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EDFF8036E;
	Fri,  3 Jan 2025 07:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="keNJjPAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00C7D8036E; Fri,  3 Jan 2025 07:41:27 +0100 (CET)
Received: from mail-m12757.qiye.163.com (mail-m12757.qiye.163.com
 [115.236.127.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98CED803C6
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79758930;
 Fri, 3 Jan 2025 14:41:18 +0800 (GMT+08:00)
Message-ID: <560baffe-fe1e-4eee-97bb-adcd5be9674b@rock-chips.com>
Date: Fri, 3 Jan 2025 14:41:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] rockchip: rk3288-firefly: Drop use of silent
 console and late boardinfo
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212221000.94501-1-jonas@kwiboo.se>
 <20241212221000.94501-8-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241212221000.94501-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUoaHVYdThoZSkpMSExDQh5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942ae59d1503afkunm79758930
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pzo6NQw4CzITISwwHC0YIioz
 Sg0wCg5VSlVKTEhOQ0NNT0xCTUtMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSklPNwY+
DKIM-Signature: a=rsa-sha256;
 b=keNJjPAZV6l/qlgO8aBoIn9iXi2Aci/s6N0b0oWB3urMMd/BpNW4hCCVppal0RsU5/B06Mt2iweWh9qMP8YjXxBbDM+km0phEI2XPAD0N35x4LYG/djrTHkyYvMoqdAL/dGYkr1wESU2zpd36QvWcazXuVnDplQJ3FYxTB5+jvE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=g2d+cqH0IYzf2nV9ZsCmmu+5VV95uUatqn0GTwP/VLw=;
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


On 2024/12/13 06:09, Jonas Karlman wrote:
> Current use of SILENT_CONSOLE hide valuable information when something
> goes wrong during boot, drop this Kconfig option to allow user to see
> e.g. from what media U-Boot proper is loaded from.
>
> A second Model line is printed on console due to DISPLAY_BOARDINFO_LATE,
> drop this Kconfig option to remove the second redundant line.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/firefly-rk3288_defconfig | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
> index 2160474fe0f3..6e395f5c450d 100644
> --- a/configs/firefly-rk3288_defconfig
> +++ b/configs/firefly-rk3288_defconfig
> @@ -20,8 +20,6 @@ CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
>   CONFIG_USE_PREBOOT=y
>   CONFIG_DEFAULT_FDT_FILE="rk3288-firefly.dtb"
> -CONFIG_SILENT_CONSOLE=y
> -CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_CMD_GPIO=y
