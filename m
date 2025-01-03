Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E48E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A060B803C6;
	Fri,  3 Jan 2025 07:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="H3/9Ygdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B07A803F0; Fri,  3 Jan 2025 07:44:04 +0100 (CET)
Received: from mail-m49219.qiye.163.com (mail-m49219.qiye.163.com
 [45.254.49.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC8F0803C6
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:44:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 7978ae10;
 Fri, 3 Jan 2025 14:43:56 +0800 (GMT+08:00)
Message-ID: <0a3c5307-4025-4162-841b-26af7e4413ac@rock-chips.com>
Date: Fri, 3 Jan 2025 14:43:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] rockchip: rk3399-gru: Move SPI flash payload offset
 for bob and kevin
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241212235735.164272-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk9LSVYdSkwaSx1NGhlPGEtWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942ae8080003afkunm7978ae10
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N1E6KDo4KTISISwJKgkwOQFJ
 QhhPCg9VSlVKTEhOQ0NNTUhCS0lPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTE9NNwY+
DKIM-Signature: a=rsa-sha256;
 b=H3/9YgdgI9gFTEZ31ZSA8sGacex23nLI1fXjYGd25E0zU7TXL+cnbwoAPTXxrAcW3SitCO5SnLRPR2fuCDsliDxtWhQJSasf1V7sseV0F+p68DkvP9AO5+XBLabWpaWQys/VeAUECc6QqJYODSbtyMLOQBlrpk0bpWYFs4kKZMg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=fOBtrT40aT+QEOvCRFu9yCW1d2zO3YsxzKxW3Q5D2Ds=;
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


On 2024/12/13 07:57, Jonas Karlman wrote:
> The BootROM on RK3399 only read the first 2 KB of each 4 KB page from
> SPI flash. With current FIT payload offset of 0x40000 this limits the
> supported TPL+SPL size to only 128 KB.
>
> Change to use 0xE0000 as FIT payload offset, similar to other RK3399
> boards, to allow a maximum size for TPL of 192 KB and SPL of 256 KB.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/chromebook_bob_defconfig   | 2 +-
>   configs/chromebook_kevin_defconfig | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index decac2e19352..69a07ef7e01e 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -44,7 +44,7 @@ CONFIG_HANDOFF=y
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_SPI_LOAD=y
> -CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPIO=y
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index 5bbea6c42a8b..d689eeaf2781 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -45,7 +45,7 @@ CONFIG_HANDOFF=y
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_SPI_LOAD=y
> -CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPIO=y
