Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E414C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2573088350;
	Mon, 22 Apr 2024 10:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Mb106dC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC8B788374; Mon, 22 Apr 2024 10:24:16 +0200 (CEST)
Received: from mail-m32101.qiye.163.com (mail-m32101.qiye.163.com
 [220.197.32.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6391688350
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Mb106dC6/fImna/OILgk4gEeWuWHrBrW51g3u6036C/XMrNRw5e1ke+rAkaETuWOfYOrQzYIjP4c3Nzj3tiiol99yks6FjV+XDlqLtXpCvwG7XARyHfn6K9pEbrG1JIneb4ivG/c87Y1RZD61m1hAx15NA4c3FNfSJrMMxxNVtg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=6YLWtdKXbF0YX2I1GOpPMFG++MYRgA/koQindkdXV/A=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 64E0D9002BC;
 Mon, 22 Apr 2024 16:24:05 +0800 (CST)
Message-ID: <8a7d2337-442d-48f3-a7df-a097ecf4aa29@rock-chips.com>
Date: Mon, 22 Apr 2024 16:24:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: rk3328: Enable ARMv8 crypto extensions
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240421200908.518855-1-jonas@kwiboo.se>
 <20240421200908.518855-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240421200908.518855-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUkaH1YYQx1DGE1JHUpJSk5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04e7b71b03a9kunm64e0d9002bc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ohw6LCo*LTMMCDozTBdJCS1C
 NTwKCwtVSlVKTEpITExPSU9NSktPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0xMNwY+
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


On 2024/4/22 04:09, Jonas Karlman wrote:
> The RK3328 SoC support ARMv8 Cryptography Extensions and use of the
> ARMv8 crypto extensions help speed up FIT checksum validation in SPL.
>
> Imply ARMV8_SET_SMPEN and ARMV8_CRYPTO to take advantage of the crypto
> extensions for SHA256 when validating checksum of FIT images.
>
> Also imply OF_LIVE to help speed up init of U-Boot proper.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever

> ---
> v2: No change, rebase on latest master bransh
> ---
>   arch/arm/mach-rockchip/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index ee0f338995b9..651ecfe9b8fd 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -180,8 +180,11 @@ config ROCKCHIP_RK3328
>   	select SUPPORT_TPL
>   	select TPL
>   	select TPL_NEEDS_SEPARATE_STACK if TPL
> +	imply ARMV8_CRYPTO
> +	imply ARMV8_SET_SMPEN
>   	imply MISC
>   	imply MISC_INIT_R
> +	imply OF_LIVE
>   	imply PRE_CONSOLE_BUFFER
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply ROCKCHIP_EFUSE
