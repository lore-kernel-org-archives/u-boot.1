Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB98C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 11:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15268869B6;
	Fri, 22 Dec 2023 12:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="NJ2EKHX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06F1886813; Fri, 22 Dec 2023 12:08:17 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E16E587831
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 12:08:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a234dc0984fso193491566b.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 03:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1703243292; x=1703848092; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F+CPaDcr/MH7D3eVID3dCMfvQ1G944MUhR0c4L9mVo8=;
 b=NJ2EKHX7oczzTl9fArgHzRrtz+5JaKqcjArcYRuF50ejleLgoO8V/sNXd2G6c5GUJZ
 DPMZTPTP0aJNx+WnELvOxeo1o7y/jDtd+pYg2up4gaACSgarZK7zgMC1wQXaas6junRA
 EMJnUrEDezj0PJLBAT62bcq9ag5iD1omgwEZzpvaK7Mcgpe3OqoO4t2r3Nwzy6K3/8oB
 cIRhaDZZTNbzZWVDisrW5MI5bXQXZe43a9h2xlVK2gH34FERYsXHjraaJOxLQDMav0Yw
 w+rf4Egv3jajbKBCWBDlH5eEbShJnoY0XfPR3wgPgPt/Oas+3d050fetJgr2Jy0QD6Lb
 LIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703243292; x=1703848092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F+CPaDcr/MH7D3eVID3dCMfvQ1G944MUhR0c4L9mVo8=;
 b=Fq7Lkz3DqosLvlBvJVGuj0EasYu5yVsUS9ayGq/x1fIJ2jf1YVCoWC8U9BYdzex+xg
 c1MFLBRDeP/sKCALJrD64b1YbMXe27+yD9RimO99RE+EomU3qNPdu02J8zDljeBMDOpJ
 VRa/mM4rbyF6Rv2n61cfl20LxRfUNPtizUExIzl6BYpyVluyyt/3SazWKMzT6h5g3qDo
 ZXGD5V9Ld+8BXh7nuKNzS6GvxFhZ7IwAMHMkCJkbXLvogQ0wiRMNpQ//uXu9EDbw9SH+
 JuATFerCNfENRJJxEjjFxWNZ8R45veQMJoE+Q+IDLeQP1KgTnvpjAZA/RlZNNtw5KEmT
 /hrQ==
X-Gm-Message-State: AOJu0Yy6q3MqIL6AscNWuphA7GMJjdjsqmxowJdPkLl1LTaC4f6M4Dkj
 cfQV3hYlE9x63/e2BCjW3y6+2VzQLDI42Q==
X-Google-Smtp-Source: AGHT+IFRIdkcRpypM04SGl/9+nSyI8T2BtSJLi1Sps2jqNl2r2p+4+Ei88xPV0BCO0L7XYahtQJC7w==
X-Received: by 2002:a17:906:1456:b0:a23:32bd:d166 with SMTP id
 q22-20020a170906145600b00a2332bdd166mr646317ejc.48.1703243292295; 
 Fri, 22 Dec 2023 03:08:12 -0800 (PST)
Received: from ?IPV6:2a02:810d:8400:17a8:8ea:59af:d317:9dff?
 ([2a02:810d:8400:17a8:8ea:59af:d317:9dff])
 by smtp.gmail.com with ESMTPSA id
 ge24-20020a170907909800b00a1c7b20e9e6sm1946003ejb.32.2023.12.22.03.08.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Dec 2023 03:08:11 -0800 (PST)
Message-ID: <0424792b-1472-4048-adb5-cf85a62d126f@suse.com>
Date: Fri, 22 Dec 2023 12:08:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] rpi5: Use devicetree as alternative way to read IO
 base addresses
Content-Language: en-US, ca-ES, es-ES
To: "Ivan T. Ivanov" <iivanov@suse.de>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de
References: <20231218210341.30073-1-iivanov@suse.de>
 <20231218210341.30073-3-iivanov@suse.de>
From: Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20231218210341.30073-3-iivanov@suse.de>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 18/12/2023 22:03, Ivan T. Ivanov wrote:
> From: Dmitry Malkin <dmitry@bedrocksystems.com>
> 
> MBOX and Watchdog on RPi5/bcm2712 has a different base IO offsets.
> Find them via devicetree blob passed by bootloader.
> 
> Signed-off-by: Dmitry Malkin <dmitry@bedrocksystems.com>
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   arch/arm/mach-bcm283x/include/mach/base.h  |  5 ++-
>   arch/arm/mach-bcm283x/include/mach/mbox.h  |  3 +-
>   arch/arm/mach-bcm283x/include/mach/sdhci.h |  3 +-
>   arch/arm/mach-bcm283x/include/mach/timer.h |  3 +-
>   arch/arm/mach-bcm283x/include/mach/wdog.h  |  3 +-
>   arch/arm/mach-bcm283x/init.c               | 43 ++++++++++++++++++----
>   6 files changed, 43 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/mach-bcm283x/include/mach/base.h b/arch/arm/mach-bcm283x/include/mach/base.h
> index 4ccaf69693..6de99e7ea1 100644
> --- a/arch/arm/mach-bcm283x/include/mach/base.h
> +++ b/arch/arm/mach-bcm283x/include/mach/base.h
> @@ -6,7 +6,10 @@
>   #ifndef _BCM283x_BASE_H_
>   #define _BCM283x_BASE_H_
>   
> -extern unsigned long rpi_bcm283x_base;
> +extern unsigned long rpi_mbox_base;
> +extern unsigned long rpi_timer_base;
> +extern unsigned long rpi_sdhci_base;
> +extern unsigned long rpi_wdog_base;
>   
>   #ifdef CONFIG_ARMV7_LPAE
>   #ifdef CONFIG_TARGET_RPI_4_32B
> diff --git a/arch/arm/mach-bcm283x/include/mach/mbox.h b/arch/arm/mach-bcm283x/include/mach/mbox.h
> index 490664f878..35d4e2f075 100644
> --- a/arch/arm/mach-bcm283x/include/mach/mbox.h
> +++ b/arch/arm/mach-bcm283x/include/mach/mbox.h
> @@ -38,8 +38,7 @@
>   
>   /* Raw mailbox HW */
>   
> -#define BCM2835_MBOX_PHYSADDR ({ BUG_ON(!rpi_bcm283x_base); \
> -				 rpi_bcm283x_base + 0x0000b880; })
> +#define BCM2835_MBOX_PHYSADDR	rpi_mbox_base
>   
>   struct bcm2835_mbox_regs {
>   	u32 read;
> diff --git a/arch/arm/mach-bcm283x/include/mach/sdhci.h b/arch/arm/mach-bcm283x/include/mach/sdhci.h
> index 7323690687..e837c679c4 100644
> --- a/arch/arm/mach-bcm283x/include/mach/sdhci.h
> +++ b/arch/arm/mach-bcm283x/include/mach/sdhci.h
> @@ -8,8 +8,7 @@
>   
>   #include <asm/arch/base.h>
>   
> -#define BCM2835_SDHCI_PHYSADDR ({ BUG_ON(!rpi_bcm283x_base); \
> -				  rpi_bcm283x_base + 0x00300000; })
> +#define BCM2835_SDHCI_PHYSADDR	rpi_sdhci_base
>   
>   int bcm2835_sdhci_init(u32 regbase, u32 emmc_freq);
>   
> diff --git a/arch/arm/mach-bcm283x/include/mach/timer.h b/arch/arm/mach-bcm283x/include/mach/timer.h
> index 5567dbd7f3..60500a256d 100644
> --- a/arch/arm/mach-bcm283x/include/mach/timer.h
> +++ b/arch/arm/mach-bcm283x/include/mach/timer.h
> @@ -11,8 +11,7 @@
>   #include <linux/bug.h>
>   #endif
>   
> -#define BCM2835_TIMER_PHYSADDR ({ BUG_ON(!rpi_bcm283x_base); \
> -				  rpi_bcm283x_base + 0x00003000; })
> +#define BCM2835_TIMER_PHYSADDR	rpi_timer_base
>   
>   #define BCM2835_TIMER_CS_M3	(1 << 3)
>   #define BCM2835_TIMER_CS_M2	(1 << 2)
> diff --git a/arch/arm/mach-bcm283x/include/mach/wdog.h b/arch/arm/mach-bcm283x/include/mach/wdog.h
> index 9942666720..b950560674 100644
> --- a/arch/arm/mach-bcm283x/include/mach/wdog.h
> +++ b/arch/arm/mach-bcm283x/include/mach/wdog.h
> @@ -8,8 +8,7 @@
>   
>   #include <asm/arch/base.h>
>   
> -#define BCM2835_WDOG_PHYSADDR ({ BUG_ON(!rpi_bcm283x_base); \
> -				 rpi_bcm283x_base + 0x00100000; })
> +#define BCM2835_WDOG_PHYSADDR	rpi_wdog_base
>   
>   struct bcm2835_wdog_regs {
>   	u32 unknown0[7];
> diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> index af23b9711a..1c5c748484 100644
> --- a/arch/arm/mach-bcm283x/init.c
> +++ b/arch/arm/mach-bcm283x/init.c
> @@ -151,7 +151,11 @@ static void rpi_update_mem_map(void)
>   static void rpi_update_mem_map(void) {}
>   #endif
>   
> -unsigned long rpi_bcm283x_base = 0x3f000000;
> +/* Default bcm283x devices addresses */
> +unsigned long rpi_mbox_base  = 0x3f00b880;
> +unsigned long rpi_sdhci_base = 0x3f300000;
> +unsigned long rpi_wdog_base  = 0x3f100000;
> +unsigned long rpi_timer_base = 0x3f003000;
>   
>   int arch_cpu_init(void)
>   {
> @@ -162,22 +166,45 @@ int arch_cpu_init(void)
>   
>   int mach_cpu_init(void)
>   {
> -	int ret, soc_offset;
> +	int ret, soc, offset;
>   	u64 io_base, size;
>   
>   	rpi_update_mem_map();
>   
>   	/* Get IO base from device tree */
> -	soc_offset = fdt_path_offset(gd->fdt_blob, "/soc");
> -	if (soc_offset < 0)
> -		return soc_offset;
> +	soc = fdt_path_offset(gd->fdt_blob, "/soc");
> +	if (soc < 0)
> +		return soc;
>   
> -	ret = fdt_read_range((void *)gd->fdt_blob, soc_offset, 0, NULL,
> -				&io_base, &size);
> +	ret = fdt_read_range((void *)gd->fdt_blob, soc, 0, NULL,
> +			     &io_base, &size);
>   	if (ret)
>   		return ret;
>   
> -	rpi_bcm283x_base = io_base;
> +	rpi_mbox_base  = io_base + 0x00b880;
> +	rpi_sdhci_base = io_base + 0x300000;
> +	rpi_wdog_base  = io_base + 0x100000;
> +	rpi_timer_base = io_base + 0x003000;
> +
> +	offset = fdt_node_offset_by_compatible(gd->fdt_blob, soc,
> +					       "brcm,bcm2835-mbox");
> +	if (offset > soc)
> +		rpi_mbox_base = fdt_get_base_address(gd->fdt_blob, offset);
> +
> +	offset = fdt_node_offset_by_compatible(gd->fdt_blob, soc,
> +					       "brcm,bcm2835-sdhci");
> +	if (offset > soc)
> +		rpi_sdhci_base = fdt_get_base_address(gd->fdt_blob, offset);
> +
> +	offset = fdt_node_offset_by_compatible(gd->fdt_blob, soc,
> +					       "brcm,bcm2835-system-timer");
> +	if (offset > soc)
> +		rpi_timer_base = fdt_get_base_address(gd->fdt_blob, offset);
> +
> +	offset = fdt_node_offset_by_compatible(gd->fdt_blob, soc,
> +					       "brcm,bcm2712-pm");
> +	if (offset > soc)
> +		rpi_wdog_base = fdt_get_base_address(gd->fdt_blob, offset);
>   
>   	return 0;
>   }
