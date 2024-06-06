Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C22C27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 08:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DB1488591;
	Thu,  6 Jun 2024 10:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IIMFEKGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1CA088582; Thu,  6 Jun 2024 10:15:46 +0200 (CEST)
Received: from mail-m12741.qiye.163.com (mail-m12741.qiye.163.com
 [115.236.127.41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABF7588468
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 10:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=IIMFEKGzMwhPDib2wUbbT9CE4wwbGxadXyXTtmZBx75Jy3E9ZaAYYBSCFOtdg1LvdS51WUjLVfvjLbSpYStz28uK09hGYpQKcAGenaj3206DXlemm+lt4HPXgPgAAOjnpq83ifN1w1nENXDu7C+ne78CkCIGvLXlCqCruZFUXrA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=tQgDGDIm/o84iNGkNTHAojHv2YSsfh/gGsPiTiL6MBw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id BCEC8900607;
 Thu,  6 Jun 2024 16:15:16 +0800 (CST)
Message-ID: <a48de1d9-9f4f-43d8-9e90-303b3833b18c@rock-chips.com>
Date: Thu, 6 Jun 2024 16:15:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH next v2 6/6] rockchip: ringneck-px30: fix TPL_MAX_SIZE
To: Quentin Schulz <foss+uboot@0leil.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240605-misc-tsd-v2-0-12479432c90f@cherry.de>
 <20240605-misc-tsd-v2-6-12479432c90f@cherry.de>
Content-Language: en-US
In-Reply-To: <20240605-misc-tsd-v2-6-12479432c90f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkodTlZOGU9KT0hCGR9NTEhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fec9dd35e03a9kunmbcec8900607
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBA6DSo5ITMDEjUjUU5MC1Yi
 EykwCzNVSlVKTEpMTU1KTEpMTEJJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQk9ONwY+
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


On 2024/6/5 23:56, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Ringneck was mistakenly set to allow up to 128KiB for the TPL code size
> while PX30 SoC only has 16KiB of SRAM.
>
> Therefore, let's use the default value of TPL_MAX_SIZE from the SoC
> (which is 10KiB) so that the max code size is actually checked and
> useful.
>
> Fixes: c925be73a0a8 ("rockchip: add support for PX30 Ringneck SoM on Haikou Devkit")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/ringneck-px30_defconfig | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
> index a22d25e0089..9965e55d611 100644
> --- a/configs/ringneck-px30_defconfig
> +++ b/configs/ringneck-px30_defconfig
> @@ -14,7 +14,6 @@ CONFIG_SPL_DRIVERS_MISC=y
>   CONFIG_DEBUG_UART_BASE=0xFF030000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0x800800
> -CONFIG_TPL_MAX_SIZE=0x20000
>   CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
>   CONFIG_FIT=y
>
