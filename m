Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1445EA8542
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 03:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8E4983952;
	Mon,  9 Mar 2026 04:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DCtb35YJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ECA1839D5; Mon,  9 Mar 2026 04:02:45 +0100 (CET)
Received: from mail-m49239.qiye.163.com (mail-m49239.qiye.163.com
 [45.254.49.239])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1055D8063E
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 04:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [110.83.51.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 36304ab97;
 Mon, 9 Mar 2026 11:02:40 +0800 (GMT+08:00)
Message-ID: <b3fda56a-d146-4493-a947-acfaada89894@rock-chips.com>
Date: Mon, 9 Mar 2026 11:02:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v2 02/12] rockchip: board: qnap-ts433: drop DW_MMC config
 options
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: trini@konsulko.com, u-boot@lists.denx.de
References: <20260114082822.4007128-1-heiko@sntech.de>
 <20260114082822.4007128-3-heiko@sntech.de>
Content-Language: en-US
In-Reply-To: <20260114082822.4007128-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd08bf95a03afkunm1a416669162beaf
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaS0JLVkxJTE1DTB1PSEIeQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
DKIM-Signature: a=rsa-sha256;
 b=DCtb35YJX554wouEpJO0lSX7wj5kFq0Tr3EDcA4noX6Q9VXDyF+ov603tqhz3RzpOfxpUD0gl+l8/AKsd+h+Qt3eotcfbsPIPzQKubWXBXrvSEdExN1vL4N9ViHv7DRI4GTUD+b7w7iRDiRgizp1OzEZKotb7diPVSf1ZWfrgFM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=BH6Q5HqJwRzzFNOyxiJZXNE8JnXMLlAt69DB7NRrKJA=;
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


On 2026/1/14 16:28, Heiko Stuebner wrote:
> The TS433 does not have a SD-card slot, just the separate SDHCI-controlled
> EMMC on the board.
>
> So drop the 2 config options.
>
> Fixes: d3cacb79e706 ("board: rockchip: add support for Qnap TS433 devices")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/qnap-ts433-rk3568_defconfig | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/configs/qnap-ts433-rk3568_defconfig b/configs/qnap-ts433-rk3568_defconfig
> index 1e494073bc9..ebcd3b69e90 100644
> --- a/configs/qnap-ts433-rk3568_defconfig
> +++ b/configs/qnap-ts433-rk3568_defconfig
> @@ -51,8 +51,6 @@ CONFIG_LED=y
>   CONFIG_LED_GPIO=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> -CONFIG_MMC_DW=y
> -CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
