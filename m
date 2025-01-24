Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ABFC02182
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 02:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C11F80780;
	Fri, 24 Jan 2025 03:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="EWpT1sRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3125807C0; Fri, 24 Jan 2025 03:18:01 +0100 (CET)
Received: from mail-m1973174.qiye.163.com (mail-m1973174.qiye.163.com
 [220.197.31.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 600008076E
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 03:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 98d8ff80;
 Fri, 24 Jan 2025 10:17:51 +0800 (GMT+08:00)
Message-ID: <2ef496a1-43bd-40cc-8430-80d5a70884a0@rock-chips.com>
Date: Fri, 24 Jan 2025 10:17:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: sdram: Allow the first bank to extend
 beyond 4 GiB
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250123220222.3089386-1-jonas@kwiboo.se>
 <20250123220222.3089386-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250123220222.3089386-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHklKVk4eGR0YHxpCTkhIT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lCTUpKVUpLS1
 VLWQY+
X-HM-Tid: 0a949619f8ca03afkunm98d8ff80
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pww6Dgw*LDIVKCIZPh0CMj4w
 CyoKCihVSlVKTEhMTUNOS0xISENJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpLT0s3Bg++
DKIM-Signature: a=rsa-sha256;
 b=EWpT1sRIZVhB0ZA6XmT8dJ3Bi1mxpBEBPTga9aMc0sybq5Z2YXU9wXrP0OSGD2xb264owZtEYFd2bTGT/uABsgH1+TWVW12QnzQYD/Mgod8hQz0hdTkHmQ/YRh9G0x4/9pbkYBzKrCK/lcN9l0u3etCAZnnXxp2UpDYicAp2gdw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=GaxHmDuXwPwcji4y/95wLzD98PDZNJ+xFo2xq/lTz44=;
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


On 2025/1/24 06:02, Jonas Karlman wrote:
> Allow the first bank to extend beyond 4 GiB when the blob of space for
> peripheral is located before start of DRAM, e.g. when start of DRAM
> is 0x40000000 and continue beyond the 4 GiB mark.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/sdram.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 7c21ae8efc44..3d3fc327234f 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -310,6 +310,8 @@ int dram_init_banksize(void)
>   	if (ram_top > SZ_4G && top < SZ_4G) {
>   		gd->bd->bi_dram[1].start = SZ_4G;
>   		gd->bd->bi_dram[1].size = ram_top - gd->bd->bi_dram[1].start;
> +	} else if (ram_top > SZ_4G && top == SZ_4G) {
> +		gd->bd->bi_dram[0].size = ram_top - gd->bd->bi_dram[0].start;
>   	}
>   #else
>   #ifdef CONFIG_SPL_OPTEE_IMAGE
