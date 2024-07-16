Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B62C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 01:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B815488939;
	Tue, 16 Jul 2024 03:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="c5rSpoa0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32F1E88939; Tue, 16 Jul 2024 03:57:50 +0200 (CEST)
Received: from mail-m127215.xmail.ntesmail.com
 (mail-m127215.xmail.ntesmail.com [115.236.127.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93C6E8887A
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 03:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=c5rSpoa0pEzsqn2HNOxyBQYd+KalfpBBUNXTI6xWo1caifiDI8lEsUw2ggnEQmSS3CX4kgZcjtW8cN5cMX9Ae5BiRnz331esO1kFz/d4D9f8KnWieGI6z12Ew4LMcz3Jsl+LT+45IEJbX1YRTPW0yr0h5MRE5CgVRQx2i13biR4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=WtRgDhVhsZEj2Ki0wWoM4yZytIf8GoFMqXB6W0DWbyA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 392409003B4;
 Tue, 16 Jul 2024 09:57:32 +0800 (CST)
Message-ID: <020d9842-0fb9-4fdb-b518-1c6e662517df@rock-chips.com>
Date: Tue, 16 Jul 2024 09:57:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 3/3] rockchip: ringneck-px30: enable IO domain
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240614-px30-io-domain-v1-0-9552966d3911@cherry.de>
 <20240614-px30-io-domain-v1-3-9552966d3911@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240614-px30-io-domain-v1-3-9552966d3911@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkwdQlYZS0gaSU1ISEJMGUpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b9425d4e03a9kunm392409003b4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhw6Dio*PDI6KhgeMCgfMDEP
 SEkKCx5VSlVKTElKS0JOS05JQkJIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTkhDNwY+
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


On 2024/6/15 00:54, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Enable the IO domain on Ringneck. Based on the current HW design, this
> should do nothing else than making sure vccio6 iodomain is controlled by
> the GRF and not GPIO0B6.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/ringneck-px30_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
> index e7594b7a67b..52a4c9710a9 100644
> --- a/configs/ringneck-px30_defconfig
> +++ b/configs/ringneck-px30_defconfig
> @@ -80,6 +80,7 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_ROCKCHIP_OTP=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>
