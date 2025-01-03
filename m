Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5B1E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 09:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4A5F803DC;
	Fri,  3 Jan 2025 10:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eSuCtsqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F175803CC; Fri,  3 Jan 2025 10:26:03 +0100 (CET)
Received: from mail-m12746.qiye.163.com (mail-m12746.qiye.163.com
 [115.236.127.46])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70E080431
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 10:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79d1fb60;
 Fri, 3 Jan 2025 17:25:54 +0800 (GMT+08:00)
Message-ID: <dcfa8c87-b629-4c46-a4e8-349118342c79@rock-chips.com>
Date: Fri, 3 Jan 2025 17:25:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 09/12] rockchip: rk3399-gru: Enable dcache and signature
 validation in SPL
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-10-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20241212235735.164272-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHkIfVh4ZSUMZHklPSxhPHVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a942b7c4f0d03afkunm79d1fb60
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Phg6EBw6KjIRTCwVQjQcD0Mf
 EEoaCyFVSlVKTEhOQ0JNSE5NSEtLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlDQ0g3Bg++
DKIM-Signature: a=rsa-sha256;
 b=eSuCtsqfh2Yl1McDxch1ChO3HW/csliv8fkvy8Mv3Whjef35D6P3IcTTbctPsQu7gUld95FyXfNmWmOTpk7FuX7THJl5xz7WA5wNu+gUfyjoY6/75BoDGRXGrgF3os+xBGST8SC/ltg9U9qf5huliwZvPhvdBBB+BJ5ayo/hxKQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=uJSYr9XUgxgRi96cuDBt1nMwuNg6hV/7smfBMKOhI0Q=;
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
> With TPL being used to init DRAM, SPL being used to load FIT and the
> adjusted FIT payload offset it is now possible to increase the size
> limit of SPL to 256 KB and enable uses of dcache and FIT signature
> validation.
>
> Drop SPL_SYS_DCACHE_OFF=y to enable use of dcache in SPL.
>
> Drop SPL_FIT_SIGNATURE=n to enable signature validation of FIT in SPL.
>
> Change SPL_MAX_SIZE to 256 KB now that payload offset has moved in SPI
> and TF-A may be loaded to 0x40000 in DRAM.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/chromebook_bob_defconfig   | 4 +---
>   configs/chromebook_kevin_defconfig | 4 +---
>   2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index f13c4c1e7d63..9a0f7cf8236a 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -1,6 +1,5 @@
>   CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
> -CONFIG_SPL_SYS_DCACHE_OFF=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
> @@ -19,7 +18,6 @@ CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
>   CONFIG_SPL_SPI=y
>   CONFIG_DEBUG_UART=y
> -# CONFIG_SPL_FIT_SIGNATURE is not set
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-bob.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> @@ -27,7 +25,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
>   CONFIG_BLOBLIST=y
>   CONFIG_BLOBLIST_ADDR=0x100000
>   CONFIG_BLOBLIST_SIZE=0x1000
> -CONFIG_SPL_MAX_SIZE=0x1e000
> +CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_HANDOFF=y
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index 7a2b8e70fe69..d70ec74f7f87 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -1,6 +1,5 @@
>   CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
> -CONFIG_SPL_SYS_DCACHE_OFF=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
> @@ -20,7 +19,6 @@ CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
>   CONFIG_SPL_SPI=y
>   CONFIG_DEBUG_UART=y
> -# CONFIG_SPL_FIT_SIGNATURE is not set
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-kevin.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> @@ -28,7 +26,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
>   CONFIG_BLOBLIST=y
>   CONFIG_BLOBLIST_ADDR=0x100000
>   CONFIG_BLOBLIST_SIZE=0x1000
> -CONFIG_SPL_MAX_SIZE=0x1e000
> +CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_HANDOFF=y
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
