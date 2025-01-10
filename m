Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57EAE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 07:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D2B580613;
	Fri, 10 Jan 2025 08:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="HZOIoZnx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8621680657; Fri, 10 Jan 2025 08:17:23 +0100 (CET)
Received: from mail-m49214.qiye.163.com (mail-m49214.qiye.163.com
 [45.254.49.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B9C88067D
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 08:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 85062dd6;
 Fri, 10 Jan 2025 15:17:14 +0800 (GMT+08:00)
Message-ID: <cc77ef2a-0c14-49b0-a54d-877ebab4ca0d@rock-chips.com>
Date: Fri, 10 Jan 2025 15:17:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] rockchip: rk3308: Implement checkboard() to print
 SoC variant
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20241110005622.1515100-1-jonas@kwiboo.se>
 <20241110005622.1515100-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241110005622.1515100-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGBlPVkMZH08eGEJCSUgdQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a944f13078f03afkunm85062dd6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KyI6Aww6HDIPCw8yUQ0eFQ8V
 TR8wFB9VSlVKTEhNT0JIT0hNSkhIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpIQ0k3Bg++
DKIM-Signature: a=rsa-sha256;
 b=HZOIoZnx6kIlFVb/S4ReJ+bDlTA3F0P64Q3+QZoF2any5/SQu7IuKfZBgH98qvkM66kiO0Mvv52zJY7rdiDbhM9NYCqP+qOZ5/8eq4PO9siQRENVHDwBhkW3gPK8hjjvQG/eXGug0Eb7e0cisrv5LF+Rc5bnW+tg9H1syW5pyjI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=/wboxADqwepmbLz6RHgbzKDLsx8i3FWuSrfqdABpAO8=;
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


On 2024/11/10 08:56, Jonas Karlman wrote:
> Implement checkboard() to print current SoC variant used by a board,
> e.g. one of:
>
>    SoC:   RK3308
>    SoC:   RK3308B
>    SoC:   RK3308B-S
>
> when U-Boot proper is running.
>
>    U-Boot 2025.01-rc1 (Nov 02 2024 - 20:26:25 +0000)
>
>    Model: Radxa ROCK Pi S
>    SoC:   RK3308B
>    DRAM:  512 MiB (effective 510 MiB)
>
> Information about the SoC variant is read from GRF.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: No change
> v2: New patch
> ---
>   arch/arm/mach-rockchip/rk3308/rk3308.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c b/arch/arm/mach-rockchip/rk3308/rk3308.c
> index c6b1a35f47e6..03d97e1d7460 100644
> --- a/arch/arm/mach-rockchip/rk3308/rk3308.c
> +++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
> @@ -216,3 +216,19 @@ int arch_cpu_init(void)
>   	return 0;
>   }
>   #endif
> +
> +#define RK3308_GRF_CHIP_ID	0xFF000800
> +
> +int checkboard(void)
> +{
> +	u32 chip_id = readl(RK3308_GRF_CHIP_ID);
> +
> +	if (chip_id == 0x3308)
> +		printf("SoC:   RK3308B\n");
> +	else if (chip_id == 0x3308c)
> +		printf("SoC:   RK3308B-S\n");
> +	else
> +		printf("SoC:   RK3308\n");
> +
> +	return 0;
> +}
