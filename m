Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA32C52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:40:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA76A88859;
	Fri,  9 Aug 2024 11:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="WMdLHoXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2196D88BB6; Fri,  9 Aug 2024 11:40:36 +0200 (CEST)
Received: from mail-m3297.qiye.163.com (mail-m3297.qiye.163.com
 [220.197.32.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A051588581
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=WMdLHoXYtHj5bs8znHOQeXLbJhkuS5xEPlfVVZ8ec2uMjJObv/o8C6vWsYsWAf48CHTR7AOYAU7fvQKLcCJmHilHBR8sy4MBZrTFLwNXkJLdRC/aGJlo8TLT3pEevJOeroSWSYAE2WHQ+ICNBvSLytwSlPFMMOoT3rwC/18DMMY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=PMIdiWJ/iEuFkB4HfMoYpfbAUk+FtKSI0Yknziwj5R4=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D453D9005D5;
 Fri,  9 Aug 2024 17:40:18 +0800 (CST)
Message-ID: <f0e5b7ec-f194-4372-9d24-62710cc829b6@rock-chips.com>
Date: Fri, 9 Aug 2024 17:40:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3568-nanopi-r5: Disable SPL_DM_WARN Kconfig
 option
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tianling Shen
 <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240802234846.2654274-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802234846.2654274-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQx4aVkNPTBlPGklDQ0kaTlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a913682ad3203a9kunmd453d9005d5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PSo6KSo5EzIyHw4vPSoPMR8j
 PS5PCUJVSlVKTElISkJNT0lLS0NMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlCT0M3Bg++
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


On 2024/8/3 07:48, Jonas Karlman wrote:
> With the commit 6afdb1585112 ("dm: core: migrate debug() messages to use
> dm_warn") use of DM_WARN/SPL_DM_WARN print a lot of debug messages.
>
> Disable the SPL_DM_WARN Kconfig option to remove verbose logging and
> restore normal serial console output during boot.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/nanopi-r5c-rk3568_defconfig | 1 -
>   configs/nanopi-r5s-rk3568_defconfig | 1 -
>   2 files changed, 2 deletions(-)
>
> diff --git a/configs/nanopi-r5c-rk3568_defconfig b/configs/nanopi-r5c-rk3568_defconfig
> index 4a6c320faf5c..8e30093ed9dc 100644
> --- a/configs/nanopi-r5c-rk3568_defconfig
> +++ b/configs/nanopi-r5c-rk3568_defconfig
> @@ -35,7 +35,6 @@ CONFIG_CMD_REGULATOR=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> -CONFIG_SPL_DM_WARN=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
> diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
> index 7ab12e619acf..e1865b2e1714 100644
> --- a/configs/nanopi-r5s-rk3568_defconfig
> +++ b/configs/nanopi-r5s-rk3568_defconfig
> @@ -35,7 +35,6 @@ CONFIG_CMD_REGULATOR=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> -CONFIG_SPL_DM_WARN=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
