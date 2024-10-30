Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070E1D74963
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 05:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85FF9891CD;
	Wed, 30 Oct 2024 06:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730266115;
	bh=CJX+pe0oGudQwYXA6nR0XRuiKC9lXFiKSBfYO49/sNw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=m+XC9aRWOTD28OnNhE884cSZQrQdI2GVglKpCRLUNUIU2w4KbhNgiWtO7kX41ya1M
	 5vwG5v3hjmKr8dwGRe+jBNEWQH0clscD/ZOWcwW8RFdK27arcFiEZRfSpExchlowFT
	 cf3YmQwyQyZOJG1SH0QxCqrAtquJvE0a3FuHWIr9Udvo/RtpYbDBPXZEEDyhzRsqS6
	 unGkP9k1dwvPSavo33L7jJtmzYY1nqeQ/fv5D83w8hW4zxEcSKjJ/ROokWbw3/eAWR
	 WC10iFvl4HGXOMMdcQGBDcqLpBCpl0xS8INZ2iTgdYh1LdPguyB3WdIZRDQe187aAM
	 gBlFF3IsEbgGQ==
Received: from [192.168.1.107] (89-186-114-4.pool.digikabel.hu [89.186.114.4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9615189024;
 Wed, 30 Oct 2024 06:28:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730266114;
 bh=CJX+pe0oGudQwYXA6nR0XRuiKC9lXFiKSBfYO49/sNw=;
 h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
 b=G3IqYjqlE8VSKBVlttJbHAS23p6JzHeFvt2RncmzcjHkkNH8Mg+KM51xAjknFzAzf
 VN8Ch35sC0dHbS+WC7au503NIqYSNdeyjK66haaea8w6Eq8Kwm05vUVKy6hPVGgiB1
 tZ8CyYtNy2GAS/mgvrJqk5UEKif1aDfpO/+rd/IcbZjhAKrpQ2G3lm8WhUCmgFjN5Q
 wgDW3bW7JMKqx8V8SF0Ah101M1qMMzShWJf5l+ZMq1ihexiF7dEO3K7GHn5eeQG5Mk
 bW+udGgXTYwkx21BSa72LS1X/SeEU2N5YuooyxqykUupqjLpec09o2SbyeVvY0Pd2a
 /k05Jp9f8Mujw==
Message-ID: <04eec966-517f-fb4b-3082-155043a853f5@denx.de>
Date: Wed, 30 Oct 2024 06:26:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 1/1] drivers: bootcount: Add ZynqMP specific bootcount
 support
Content-Language: en-US
To: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 michal.simek@amd.com, pro@denx.de, sjg@chromium.org
Cc: vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
References: <20241029185814.7937-1-vassilisamir@gmail.com>
 <20241029185814.7937-2-vassilisamir@gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20241029185814.7937-2-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Vasileios,

On 29.10.24 19:58, Vasileios Amoiridis wrote:
> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> 
> Add native support of the bootcount mechanism in the ZynqMP by utilising internal
> PMU registers. The Persistent Global Storage Registers of the Platform Management
> Unit can keep their value during reboot cycles unless there is a POR reset, making
> them appropriate for the bootcount mechanism.
> 
> Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> ---
>   drivers/bootcount/Kconfig            |  4 ++++
>   drivers/bootcount/Makefile           |  1 +
>   drivers/bootcount/bootcount_zynqmp.c | 28 ++++++++++++++++++++++++++++
>   3 files changed, 33 insertions(+)
>   create mode 100644 drivers/bootcount/bootcount_zynqmp.c
> 
> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> index fa6d8e7128..95b6a9541a 100644
> --- a/drivers/bootcount/Kconfig
> +++ b/drivers/bootcount/Kconfig
> @@ -82,6 +82,10 @@ config BOOTCOUNT_AT91
>   	bool "Boot counter for Atmel AT91SAM9XE"
>   	depends on AT91SAM9XE
>   
> +config BOOTCOUNT_ZYNQMP
> +	bool "Boot counter for Zynq UltraScale+ MPSoC"
> +	depends on ARCH_ZYNQMP
> +
>   config DM_BOOTCOUNT
>           bool "Boot counter in a device-model device"
>   	help
> diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
> index 245f879633..487adc1212 100644
> --- a/drivers/bootcount/Makefile
> +++ b/drivers/bootcount/Makefile
> @@ -3,6 +3,7 @@
>   obj-$(CONFIG_BOOTCOUNT_GENERIC)	+= bootcount.o
>   obj-$(CONFIG_BOOTCOUNT_MEM)	+= bootcount.o
>   obj-$(CONFIG_BOOTCOUNT_AT91)	+= bootcount_at91.o
> +obj-$(CONFIG_BOOTCOUNT_ZYNQMP)  += bootcount_zynqmp.o
>   obj-$(CONFIG_BOOTCOUNT_AM33XX)	+= bootcount_davinci.o
>   obj-$(CONFIG_BOOTCOUNT_RAM)	+= bootcount_ram.o
>   obj-$(CONFIG_BOOTCOUNT_ENV)	+= bootcount_env.o
> diff --git a/drivers/bootcount/bootcount_zynqmp.c b/drivers/bootcount/bootcount_zynqmp.c
> new file mode 100644
> index 0000000000..9bb801e188
> --- /dev/null
> +++ b/drivers/bootcount/bootcount_zynqmp.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// SPDX-FileCopyrightText: 2024 CERN (home.cern)
> +
> +#include <bootcount.h>
> +#include <stdio.h>
> +#include <zynqmp_firmware.h>
> +
> +#define PMU_PERS_GLOB_GEN_STORAGE0 0x00FFD80050
> +
> +void bootcount_store(ulong a)
> +{
> +	int ret;
> +
> +	ret = zynqmp_mmio_write(PMU_PERS_GLOB_GEN_STORAGE0, 0xFF, a);
> +	if (ret)
> +		printf("Failed: mmio write\n");
> +}
> +
> +ulong bootcount_load(void)
> +{
> +	int ret;
> +	u32 val;
> +
> +	ret = zynqmp_mmio_read(PMU_PERS_GLOB_GEN_STORAGE0, &val);
> +	if (ret)
> +		printf("Failed: mmio read\n");
> +	return val;

Makes it sense to return val, when ret != 0 ? Maybe val is uninitialzed
in this case... at least please return ret.


just Nitpick: Also may at least add the function name to the printf,
that you have a chance to see on console output, that bootcount read
gone wrong... may the zynqmp_mmio_write/read functions have already an
error message on error?

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
