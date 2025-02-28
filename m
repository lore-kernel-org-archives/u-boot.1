Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DAAC282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 11:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE7B81111;
	Fri, 28 Feb 2025 12:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JmGrI22J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EAAE81197; Fri, 28 Feb 2025 12:20:27 +0100 (CET)
Received: from mail-m49232.qiye.163.com (mail-m49232.qiye.163.com
 [45.254.49.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2094380FE2
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 12:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id c85fc5c7;
 Fri, 28 Feb 2025 19:20:21 +0800 (GMT+08:00)
Message-ID: <e9df06d0-c88d-4b4a-a921-25f98af73aff@rock-chips.com>
Date: Fri, 28 Feb 2025 19:20:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: nanopi-r3s-rk3566: disable unneeded
 CONFIG_NVME_PCI
To: Tianling Shen <cnsztl@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
References: <20250115053705.911296-1-cnsztl@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250115053705.911296-1-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxhLSFZOGU1JGh5NSE4fS0NWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a954c4936c403afkunmc85fc5c7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjY6PBw4QjISSgELLRoQH0IN
 AxUKCjZVSlVKTE9LTE9KTUlJSE9CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCS003Bg++
DKIM-Signature: a=rsa-sha256;
 b=JmGrI22JLlVSmb82jlXN0wJ52zpTDKOSIfOmYC7Zt7WpoXReMl+J/msE4WFm76BtO5YyHw35mO9eQzl2wZRmJ6fScGq49jOrrxPCwZNxXsWNlx98lXlvWymBgSTnmNRvO+FmO1IYzeJVnNdEPBjSfstFQ7AxurhIwGt59t/6o5Y=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=LPFVWP2xXXb9bOoFHumMFC9bePAor7AB8Oa9uuBN+PM=;
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


On 2025/1/15 13:37, Tianling Shen wrote:
> This board does not have any NVMe slot, so disable unneeded
> CONFIG_NVME_PCI option.
>
> Fixes: bf4a33e725ae ("board: rockchip: add FriendlyElec NanoPi R3S")
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/nanopi-r3s-rk3566_defconfig | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/configs/nanopi-r3s-rk3566_defconfig b/configs/nanopi-r3s-rk3566_defconfig
> index 870613f690af..16e09753a72d 100644
> --- a/configs/nanopi-r3s-rk3566_defconfig
> +++ b/configs/nanopi-r3s-rk3566_defconfig
> @@ -54,7 +54,6 @@ CONFIG_PHY_REALTEK=y
>   CONFIG_DWC_ETH_QOS=y
>   CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_RTL8169=y
> -CONFIG_NVME_PCI=y
>   CONFIG_PCIE_DW_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
