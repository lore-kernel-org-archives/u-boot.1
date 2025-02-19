Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAE5C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 14:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1C1B80F18;
	Wed, 19 Feb 2025 15:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="CI7x4Ksk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A6B80F42; Wed, 19 Feb 2025 15:53:39 +0100 (CET)
Received: from mail-m49245.qiye.163.com (mail-m49245.qiye.163.com
 [45.254.49.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C74A08001F
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 15:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.169])
 by smtp.qiye.163.com (Hmail) with ESMTP id b8f40794;
 Wed, 19 Feb 2025 22:53:33 +0800 (GMT+08:00)
Message-ID: <2a9601f5-c94c-4d9e-a03e-044029eb33c9@rock-chips.com>
Date: Wed, 19 Feb 2025 22:53:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: rk3399-gru: Enable TPL_GPIO for bob and
 kevin
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de
References: <20250208224945.2641933-1-jonas@kwiboo.se>
 <20250208224945.2641933-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250208224945.2641933-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTEIeVkkfT01JTR4eSR1OT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk1CWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a951eb32b1f03afkunmb8f40794
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mk06Dgw5HjIUSi4QAhABNjlC
 LEtPCTRVSlVKTEhCQkxNQ0pPS0pJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTElVSk1CWVdZCAFZQUpOS0g3Bg++
DKIM-Signature: a=rsa-sha256;
 b=CI7x4Ksk40EduSOIc5GBqj0m71bI5Dr5UmJbux3Orl9M12f2aqZs9fqdWpKjRX+B84mzVn1YFcsCmsEVt4z7m2q/+iBZT0kNqJOCuePbUj623plx3coNawFocELt9g0jP1CI56DfyZIOYJAUGuPvZw743x3ph+usRtJVxoqLox8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=qOEvyic1AeibrKss1vn/WlafATsoxeV5iFL5WoW+F6g=;
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


On 2025/2/9 06:49, Jonas Karlman wrote:
> The PP1500 and PP3000 power rails must be on very early for the U-Boot
> TPL banner to be shown on debug UART.
>
> Enable TPL_GPIO Kconfig option for bob and kevin to allow use of
> spl_gpio.h functions in TPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> This fixes a linking issue that otherwise would happen with next patch.
> ---
>   configs/chromebook_bob_defconfig   | 1 +
>   configs/chromebook_kevin_defconfig | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index 1b018ef4d7c8..5b8c0d35de6d 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -35,6 +35,7 @@ CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_TPL=y
> +CONFIG_TPL_GPIO=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index 1ee0c0e6c9d8..a29a04aaddef 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -36,6 +36,7 @@ CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_TPL=y
> +CONFIG_TPL_GPIO=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
