Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8BAECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81C6088FEB;
	Tue, 10 Sep 2024 11:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Pw3zgxRP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F148888FE4; Tue, 10 Sep 2024 11:51:57 +0200 (CEST)
Received: from mail-m12772.qiye.163.com (mail-m12772.qiye.163.com
 [115.236.127.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3F6888C1B
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Pw3zgxRPI5SeqEskpElu+QpcQMK1YeBRjRgZ8MjJm25E+sNL075epn4YYGvPiSKqc7wpnyxiYzeFZnR+WHjeD87wTRGEKFtS7kmco9zobZNOzqhQrMFTCBdgzyOUu5EsVm6UGB2W1RCmRaSS8g+R0sS2vWwZPpypxXOJDDDT4II=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=gkNEB2yUt4zIw+rXngzPreoGERpARaTSQ5PWfwpKZVw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 1496090048C;
 Tue, 10 Sep 2024 17:51:37 +0800 (CST)
Message-ID: <16398000-4614-489c-9dbf-cf38f4c9db4a@rock-chips.com>
Date: Tue, 10 Sep 2024 17:51:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] rockchip: px30: Fix hard dependency to
 DEBUG_UART_BOARD_INIT
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 quentin.schulz@cherry.de
References: <20240903163858.1155218-1-lukasz.czechowski@thaumatec.com>
 <20240903163858.1155218-6-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240903163858.1155218-6-lukasz.czechowski@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk5CTlZOHU8eTE5MGBlNTR5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a91db5885a603a3kunm1496090048c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxg6OTo6AzI8LyszIT8jHQor
 Fh5PCThVSlVKTElOQk1KQ0JMQ0lJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTkhNNwY+
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


On 2024/9/4 00:38, Lukasz Czechowski wrote:
> Because DEBUG_UART_BOARD_INIT depends on DEBUG_UART, hard dependency
> to DEBUG_UART_BOARD_INIT in ROCKCHIP_PX30 can cause warnings if
> DEBUG_UART is disabled.
> The DEBUG_UART_BOARD_INIT is already implied by ARCH_ROCKCHIP entry.
> Remove hard dependency from ROCKCHIP_PX30, so that it will be
> consistent with other rockchip boards.
>
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 47a6275d45f..c9aaf6d3476 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -13,7 +13,6 @@ config ROCKCHIP_PX30
>   	imply SPL_SEPARATE_BSS
>   	imply SPL_SERIAL
>   	imply TPL_SERIAL
> -	select DEBUG_UART_BOARD_INIT
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply SPL_ROCKCHIP_COMMON_BOARD
>   	imply ARMV8_CRYPTO
