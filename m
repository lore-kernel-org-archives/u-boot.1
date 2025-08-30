Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24985CA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A455F8388E;
	Sat, 30 Aug 2025 16:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XE2PgF4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B2FB8385B; Sat, 30 Aug 2025 16:56:45 +0200 (CEST)
Received: from mail-m4921.qiye.163.com (mail-m4921.qiye.163.com [45.254.49.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D15F083890
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123c4c5a;
 Sat, 30 Aug 2025 22:56:39 +0800 (GMT+08:00)
Message-ID: <8b83f854-399e-4ec5-b1d5-1713c3764545@rock-chips.com>
Date: Sat, 30 Aug 2025 22:56:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] rockchip: rk3576: Implement checkboard() to print
 SoC variant
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250801203255.2590535-1-jonas@kwiboo.se>
 <20250801203255.2590535-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250801203255.2590535-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb7b026703afkunm7118c6c340d496
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGklDVhlCHkoaT00ZSEIdGVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=XE2PgF4gwqBtLDgxO9+xJ8nUYDY43YAGSEdIVV9v6wQ/To1UGOhb0GuWg4qhEzs+92Fp09usLOPoRRqzh4LQyUHGBCy9UYAvOpGLM+T1PpFSnTr2p54j2soxmd8KMhdJjEbGoMTJwlyfWFPWXRVV1VKbHKZrQyOiUzNjPxMVf3o=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=y+xL7FEzSIRiYKUF4AlHadxdL4cHtRtlwbQtufgQvjc=;
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


On 2025/8/2 04:32, Jonas Karlman wrote:
> Implement checkboard() to print current SoC model used by a board when
> U-Boot proper is running.
>
>    U-Boot 2025.04 (Apr 22 2025 - 20:43:17 +0000)
>
>    Model: Generic RK3576
>    SoC:   RK3576
>    DRAM:  8 GiB
>
> Information about the SoC model and variant is read from OTP.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: No change
> ---
>   arch/arm/mach-rockchip/rk3576/rk3576.c | 48 ++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
> index dc53941ab2f5..a6c2fbdc4840 100644
> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
> @@ -3,6 +3,10 @@
>    * Copyright (c) 2024 Rockchip Electronics Co., Ltd
>    */
>   
> +#define LOG_CATEGORY LOGC_ARCH
> +
> +#include <dm.h>
> +#include <misc.h>
>   #include <asm/armv8/mmu.h>
>   #include <asm/arch-rockchip/bootrom.h>
>   #include <asm/arch-rockchip/hardware.h>
> @@ -159,3 +163,47 @@ int arch_cpu_init(void)
>   
>   	return 0;
>   }
> +
> +#define RK3576_OTP_CPU_CODE_OFFSET		0x02
> +#define RK3576_OTP_SPECIFICATION_OFFSET		0x08
> +
> +int checkboard(void)
> +{
> +	u8 cpu_code[2], specification;
> +	struct udevice *dev;
> +	char suffix[2];
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
> +		return 0;
> +
> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(rockchip_otp), &dev);
> +	if (ret) {
> +		log_debug("Could not find otp device, ret=%d\n", ret);
> +		return 0;
> +	}
> +
> +	/* cpu-code: SoC model, e.g. 0x35 0x76 */
> +	ret = misc_read(dev, RK3576_OTP_CPU_CODE_OFFSET, cpu_code, 2);
> +	if (ret < 0) {
> +		log_debug("Could not read cpu-code, ret=%d\n", ret);
> +		return 0;
> +	}
> +
> +	/* specification: SoC variant, e.g. 0xA for RK3576J */
> +	ret = misc_read(dev, RK3576_OTP_SPECIFICATION_OFFSET, &specification, 1);
> +	if (ret < 0) {
> +		log_debug("Could not read specification, ret=%d\n", ret);
> +		return 0;
> +	}
> +	specification &= 0x1f;
> +
> +	/* for RK3576J i.e. '@' + 0xA = 'J' */
> +	suffix[0] = specification > 1 ? '@' + specification : '\0';
> +	suffix[1] = '\0';
> +
> +	printf("SoC:   RK%02x%02x%s\n", cpu_code[0], cpu_code[1], suffix);
> +
> +	return 0;
> +}
