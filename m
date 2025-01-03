Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BE9E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 09:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 123C2802EF;
	Fri,  3 Jan 2025 10:25:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="HSI0pJbM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E478B802EF; Fri,  3 Jan 2025 10:25:56 +0100 (CET)
Received: from mail-m11879.qiye.163.com (mail-m11879.qiye.163.com
 [115.236.118.79])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE53801A0
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 10:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79d1fb3f;
 Fri, 3 Jan 2025 17:25:49 +0800 (GMT+08:00)
Message-ID: <06ba8b12-55f7-470c-8252-4ac607f4f7f5@rock-chips.com>
Date: Fri, 3 Jan 2025 17:25:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 10/12] rockchip: rk3399-gru: Use SDMA mode to read from
 eMMC
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-11-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20241212235735.164272-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ0waVh8eH01JGkgfHklCHVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a942b7c3bac03afkunm79d1fb3f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mww6Lzo4IzILEyw1KzQyD00#
 DywKCzxVSlVKTEhOQ0JNSE5KSEJKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpJQkw3Bg++
DKIM-Signature: a=rsa-sha256;
 b=HSI0pJbMk555RqYOIpqCw5GXCGkVMXfdVkgyMg6tng7/wImrstpw6lOQsYlI+FAYGWt/uyjA9W2oJfV7eQYO+ZahQweaSOIaVV46mAAfiHPdNs12N5gKXReHxOvpPpixfjsXQm+kbj6KmvL54hwjeZzEou6QFtX81PiVYpiUCMY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Nd/XQxmZwLeefzB1p2EyFUAWys0Lzw+uzeUkeB1MaYU=;
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
> Enable use of SDMA mode when reading from eMMC to speed up boot.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/chromebook_bob_defconfig   | 1 +
>   configs/chromebook_kevin_defconfig | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index 9a0f7cf8236a..af9df4700e35 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -63,6 +63,7 @@ CONFIG_MMC_PWRSEQ=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
>   CONFIG_SPI_FLASH_GIGADEVICE=y
>   CONFIG_SPI_FLASH_WINBOND=y
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index d70ec74f7f87..cc51722b521b 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -64,6 +64,7 @@ CONFIG_MMC_PWRSEQ=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
>   CONFIG_SPI_FLASH_GIGADEVICE=y
>   CONFIG_SPI_FLASH_WINBOND=y
