Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88971C3DA4B
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 02:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC8B28813A;
	Tue, 16 Jul 2024 04:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="X3fwg3CL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B987D8880F; Tue, 16 Jul 2024 04:15:28 +0200 (CEST)
Received: from mail-m11876.qiye.163.com (mail-m11876.qiye.163.com
 [115.236.118.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE37687D87
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 04:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=X3fwg3CLxI/iWKe3eT/8155d3DUDM746yDCv8NOEB7roqi9VHuH5yn0ly+xpPh7ENx5RhPDBADuNooiw/0XHZDPTHt2IX8LARpmjNcDjh/q+qd1SGWIZxENW+t1KPv96g7yLeTi44hUSNE3hByySZQqnTypw87Sx33S/XEXgvt8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=wCQa2IqDRKtFi6Q85s34DnX1/aQ2BVf4LTWzn88Pc8o=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 3486F900208;
 Tue, 16 Jul 2024 10:15:14 +0800 (CST)
Message-ID: <5d6b6a36-b1b5-444d-af13-0b23ecec6051@rock-chips.com>
Date: Tue, 16 Jul 2024 10:15:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2] rockchip: puma-rk3399: increase Ethernet PHY
 timeout to 30s
To: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger
 <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240619-puma-eth-timeout-v2-1-a01c443d4445@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240619-puma-eth-timeout-v2-1-a01c443d4445@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU0fHlZJGUNISEkdTEhDGBpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b952911b03a9kunm3486f900208
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NDI6EDo4FDI0KhhWTggqTxQK
 CQ0wCzZVSlVKTElKS0JNSkpPQ0lJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTE9KNwY+
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


On 2024/6/19 23:44, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> On Puma v2.1 with a KSZ9031, the Ethernet PHY often doesn't detect the
> link in the 4-second default timeout.
>
> After some boot-loop test for about a thousand boots, 70% were below
> 10s, 90% below 15s and 100% below 30s. Let's play it safe and make it
> 30s so that hopefully all links that should be detected are.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v2:
> - rebase on next
> - use Kconfig symbol instead of constant in include/configs/
> - Link to v1: https://lore.kernel.org/r/20240619-puma-eth-timeout-v1-1-db5c17153f82@cherry.de
> ---
>   configs/puma-rk3399_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index 5319239f989..4293cf0ae44 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -69,6 +69,7 @@ CONFIG_MMC_SDHCI_ROCKCHIP=y
>   CONFIG_SF_DEFAULT_BUS=1
>   CONFIG_SPI_FLASH_GIGADEVICE=y
>   CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_PHY_ANEG_TIMEOUT=30000
>   CONFIG_PHY_MICREL=y
>   CONFIG_PHY_MICREL_KSZ90X1=y
>   CONFIG_ETH_DESIGNWARE=y
>
> ---
> base-commit: 01a5d7547ed3a51a8ac5837c31a150f85bc475f8
> change-id: 20240619-puma-eth-timeout-41be9c243ed7
>
> Best regards,
