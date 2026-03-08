Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A51EA852C
	for <u-boot@archiver.kernel.org>; Sun,  8 Mar 2026 15:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B650F80517;
	Sun,  8 Mar 2026 16:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="h7LlncMM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB8D583EEF; Sun,  8 Mar 2026 16:17:22 +0100 (CET)
Received: from mail-m49206.qiye.163.com (mail-m49206.qiye.163.com
 [45.254.49.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 627A380212
 for <u-boot@lists.denx.de>; Sun,  8 Mar 2026 16:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3] (unknown
 [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3625285b7;
 Sun, 8 Mar 2026 23:17:17 +0800 (GMT+08:00)
Message-ID: <dd07f73b-85b9-403c-a551-8f6c5275c951@rock-chips.com>
Date: Sun, 8 Mar 2026 23:17:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: tiger-rk3588: disable HS400
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Klaus Goger <klaus.goger@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260109-tiger-no-hs400-v1-1-94c0c17076d5@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260109-tiger-no-hs400-v1-1-94c0c17076d5@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cce062f6b03afkunmfeb6645f15bb468
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZS0tDVkpCGB5NQkhLSh8fT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJT0tCQUNCSE9BHh5BSUJNHUFCGEIeQUJPQ0tBGU5NT0FIQh1IWVdZFh
 oPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=h7LlncMM5gWj7RccSE6nygGgUzAJZ0FdhUosfTDJk3W13FaeiH0pYHCKuBQ/xqPM8xGiFbS8H9SGWpwLjWALru2UG1xaVv8WF1cmGoBzyrFmBgBcMufHJBB2O1+HPbim5MgCn0xSiBllOWM2LazzEgnv6ZmYqKym1uN4+z9Iwuw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=pHtQeKhoixxp+HuvNQrL5FPfSpU8XO0Hfaa37VvwD5w=;
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


On 2026/1/9 19:17, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Tiger suffers from eMMC signal integrity issues which means we can only
> run it at HS200 max.
>
> The Device Tree has these properties removed since v6.18 (commit
> baa18d577cd4 ("arm64: dts: rockchip: disable HS400 on RK3588 Tiger")),
> which has now merged in U-Boot.
>
> Since the controller side doesn't support HS400 anymore, let's not
> confuse users as to why HS400 is enabled in the config but not working
> as we know it cannot work (and won't be used anyway since the controller
> doesn't advertise support for it in the Device Tree).
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/tiger-rk3588_defconfig | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
> index 50a3b553a11..a545ec714b5 100644
> --- a/configs/tiger-rk3588_defconfig
> +++ b/configs/tiger-rk3588_defconfig
> @@ -76,10 +76,6 @@ CONFIG_MMC_IO_VOLTAGE=y
>   CONFIG_SPL_MMC_IO_VOLTAGE=y
>   CONFIG_MMC_UHS_SUPPORT=y
>   CONFIG_SPL_MMC_UHS_SUPPORT=y
> -CONFIG_MMC_HS400_ES_SUPPORT=y
> -CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
> -CONFIG_MMC_HS400_SUPPORT=y
> -CONFIG_SPL_MMC_HS400_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>
> ---
> base-commit: 141be72e2a9d43aa4e3d1a6a6e0ab8f9eb8784c6
> change-id: 20260108-tiger-no-hs400-445df94a6a6d
>
> Best regards,
