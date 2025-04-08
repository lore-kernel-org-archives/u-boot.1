Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618A6C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 00:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC65B83032;
	Tue,  8 Apr 2025 02:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NNLGRgCt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86A9D8307F; Tue,  8 Apr 2025 02:49:52 +0200 (CEST)
Received: from mail-m32117.qiye.163.com (mail-m32117.qiye.163.com
 [220.197.32.117])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 143B483028
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 02:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10fbbe9a8;
 Tue, 8 Apr 2025 08:49:45 +0800 (GMT+08:00)
Message-ID: <e95a9076-9381-4487-9e10-52a0d923585f@rock-chips.com>
Date: Tue, 8 Apr 2025 08:49:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] rockchip: Make ROCKCHIP_COMMON_STACK_ADDR depend
 on TPL
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alex Bee <knaerzche@gmail.com>, u-boot@lists.denx.de
References: <20250220215709.407413-1-jonas@kwiboo.se>
 <20250220215709.407413-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250220215709.407413-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGRhJVkpMHkwdT0lLH0hJSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9612dfe5f603afkunm10fbbe9a8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRA6ATo*CjJDTEMYURUcSTcy
 SkhPC0JVSlVKTE9PS0xISENNTkNDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpCT0s3Bg++
DKIM-Signature: a=rsa-sha256;
 b=NNLGRgCtEztIOSCk4MKt9Wn5yvUCTmNaFXHUyVYKZBulKvQwomtMIExoOcRbtKn1je+vmWKh0SxP6MFbtIFYak4mR0fvofzgkE3XbpGkxaMhwjhMkrFjOTOVZoxGqCXP4+1MQWTa8jXVwE9TtK6ayPama1VnsCkWrOQiro2hP1I=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=GMEl0vqb5XE4xNxSc3FOXHRdc/OU+EjQj5xSnnnIyWE=;
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


On 2025/2/21 05:56, Jonas Karlman wrote:
> The stack-pointer addresses used with ROCKCHIP_COMMON_STACK_ADDR expect
> that DRAM is initialized by TPL or ROCKCHIP_EXTERNAL_TPL, that SPL has
> access to full DRAM and SPL is loaded to/executed from start of DRAM.
>
> Add depends on to ensure use of the ROCKCHIP_COMMON_STACK_ADDR symbol
> does not cause problem for any board not using TPL and back-to-BROM
> loading of SPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch
> ---
>   arch/arm/mach-rockchip/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index bb5d009a1c34..a44fdddd46ab 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -605,6 +605,7 @@ config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>   config ROCKCHIP_COMMON_STACK_ADDR
>   	bool
>   	depends on SPL_SHARES_INIT_SP_ADDR
> +	depends on TPL || ROCKCHIP_EXTERNAL_TPL
>   	select HAS_CUSTOM_SYS_INIT_SP_ADDR
>   	imply SPL_LIBCOMMON_SUPPORT if SPL
>   	imply SPL_LIBGENERIC_SUPPORT if SPL
