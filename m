Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B9CC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CC68884F1;
	Tue, 23 Apr 2024 13:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JLhGxu1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BAED88503; Tue, 23 Apr 2024 13:00:25 +0200 (CEST)
Received: from mail-m12785.qiye.163.com (mail-m12785.qiye.163.com
 [115.236.127.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA73884F0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=JLhGxu1XnzFNSygwhzr9qULerGuDbbCZJlbu68XNTocxFePkp6f/siPz0NotoMlO4VnWDEAQQeldNq7Otn5yniXPw3uY2Ilwkwi0BQ3tQSgf3xqZgUAKk/I/Q+uXAfSCXRojkaM68elQEhKXSx11XIkHB4SWY3XqoTfk52/gS7M=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=I/epSLnjVkbraq4UacwJlg5aB6Gl4boGN4acYQldAKQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id DD5CA900343;
 Tue, 23 Apr 2024 18:59:59 +0800 (CST)
Message-ID: <c1a9210b-8582-4f8c-8b5b-466609010597@rock-chips.com>
Date: Tue, 23 Apr 2024 18:59:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/31] rockchip: rk3399-gru: Fix max SPL size on bob and
 kevin
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkwfTVZMHUoaGBpNTkNJQxpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f0a9cd03e03a9kunmdd5ca900343
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRg6AQw*TTNWUT1ROQEiDVED
 HCoKCh1VSlVKTEpIQ0xLS0tLTk1MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIT0pKNwY+
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


On 2024/4/1 04:28, Jonas Karlman wrote:
> Chromebook bob and kevin only use SPL and not TPL+SPL like other RK3399
> boards, this mean that SPL is loaded to and run from SRAM instead of
> DRAM. The SPL and U-Boot payload is loaded from SPI flash.
>
> The U-Boot payload is located at 0x40000 (256 KiB) offset in SPI flash
> and because the BROM only read first 2 KiB for each 4 KiB page, the size
> of SPL (idbloader.img) is limited to max 128 KiB.
>
> The chosen bss start address further limits the size of SPL to 120 KiB.
>
>    0xff8e0000 (SPL_BSS_START_ADDR) - 0xff8c2000 (SPL_TEXT_BASE) = 0x1e000
>
> Update SPL_MAX_SIZE to reflect the 120 KiB max size limitation.
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
> index d0321948697b..58e76f11472c 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -30,7 +30,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
>   CONFIG_BLOBLIST=y
>   CONFIG_BLOBLIST_ADDR=0x100000
>   CONFIG_BLOBLIST_SIZE=0x1000
> -CONFIG_SPL_MAX_SIZE=0x2e000
> +CONFIG_SPL_MAX_SIZE=0x1e000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>   CONFIG_SPL_BSS_START_ADDR=0xff8e0000
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index 120c11c04972..5adc276a746a 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -31,7 +31,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
>   CONFIG_BLOBLIST=y
>   CONFIG_BLOBLIST_ADDR=0x100000
>   CONFIG_BLOBLIST_SIZE=0x1000
> -CONFIG_SPL_MAX_SIZE=0x2e000
> +CONFIG_SPL_MAX_SIZE=0x1e000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>   CONFIG_SPL_BSS_START_ADDR=0xff8e0000
