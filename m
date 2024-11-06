Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C9CD44D48
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE1D88D51;
	Wed,  6 Nov 2024 11:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Q3oeBcYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD3D891D2; Wed,  6 Nov 2024 11:46:00 +0100 (CET)
Received: from mail-m1973190.qiye.163.com (mail-m1973190.qiye.163.com
 [220.197.31.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00B18891DD
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f8a3c9b;
 Wed, 6 Nov 2024 18:45:52 +0800 (GMT+08:00)
Message-ID: <fa15bb16-c69f-4974-8cf8-9e1cf92f17f2@rock-chips.com>
Date: Wed, 6 Nov 2024 18:45:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] rockchip: rk3288-miqi: Drop use of silent console
 and late boardinfo
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241105215202.1491441-1-jonas@kwiboo.se>
 <20241105215202.1491441-8-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105215202.1491441-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0NPT1ZDSh5KShofGUNIGElWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a930114ad2803afkunm1f8a3c9b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjY6DQw4AjIdNDEuTQoBEzIY
 DjVPFA5VSlVKTEhLQ0NCQk5ITk5CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0NINwY+
DKIM-Signature: a=rsa-sha256;
 b=Q3oeBcYklo1Y14Hm4J4V0yyj1r8STfndZ4F4RO1VDDZIr4TMqieomg54aSf+wMeV1JpoLwNhkdy04dkux28DQQ1LgHgXnJJHzi/LoCNc1K2ZJuTTgppmVYKQYruPsPRsfe+LFd3gwRTkTjhT43r6Ld4lT7WHo/MyruXxRKAMvBw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=ok8pep1PbTdJAkbrDZCGZOqfdEBiaO6U2Pvy3G591ew=;
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


On 2024/11/6 05:51, Jonas Karlman wrote:
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
>   configs/miqi-rk3288_defconfig | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
> index 87fd256c8a53..678d6fb33716 100644
> --- a/configs/miqi-rk3288_defconfig
> +++ b/configs/miqi-rk3288_defconfig
> @@ -20,8 +20,6 @@ CONFIG_DEBUG_UART=y
>   CONFIG_USE_PREBOOT=y
>   CONFIG_DEFAULT_FDT_FILE="rk3288-miqi.dtb"
>   CONFIG_MISC_INIT_R=y
> -CONFIG_SILENT_CONSOLE=y
> -CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
