Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03195C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 16:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F95387F65;
	Fri, 22 Mar 2024 17:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="uXtgOPRD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17E55881BF; Fri, 22 Mar 2024 17:38:15 +0100 (CET)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEE11875FA
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 17:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
Message-ID: <c65a1d4e-94eb-4ee7-823d-c400bec57796@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1711125492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZhrtrBKVmEGRsiQ9lSuV6X2KWoF3pUifXdsVijbRdjQ=;
 b=uXtgOPRD2hYYiRviPpgWOrH8TsJXWUZhBw8YilrNvFHmK9fb2ASDXQoLmcKI4H7S9CMCxq
 MrWLvXvHhyh/P0nuqvh1VgeIJZkLtEVEhTQ4HNjNmfxSkGn+5u2mpapowBfNZrxDQvgU2Q
 xbU5Am+3zblwFAT060K+H2mxYgzVpRI=
Date: Fri, 22 Mar 2024 12:38:08 -0400
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: zynqmp: Also support JTAG as alternative boot mode
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <ed51a9d51948ab939a53e0b9dc6c2d2546f97a4f.1710933505.git.michal.simek@amd.com>
 <dcc310e3-fa22-4459-a0ab-b44176c4bd2e@linux.dev>
 <a727ac9f-3602-4b55-82f4-5e5696c92070@amd.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <a727ac9f-3602-4b55-82f4-5e5696c92070@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

On 3/22/24 07:53, Michal Simek wrote:
> 
> 
> On 3/21/24 17:20, Sean Anderson wrote:
>> On 3/20/24 07:18, Michal Simek wrote:
>>> if (reg >> BOOT_MODE_ALT_SHIFT) condition rules out alternative jtag boot
>>> mode which is 0. When 0 was used origin(HW) boot mode was used instead.
>>> That's why directly fill reg variable with requested boot mode and don't
>>> let code to read value back. "else" part of code remain unchanged.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>>   arch/arm/mach-zynqmp/spl.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
>>> index 5af735aa5cef..979ff3aef6c2 100644
>>> --- a/arch/arm/mach-zynqmp/spl.c
>>> +++ b/arch/arm/mach-zynqmp/spl.c
>>> @@ -91,13 +91,14 @@ u32 spl_boot_device(void)
>>>     #if defined(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE_ENABLED)
>>>       /* Change default boot mode at run-time */
>>> +    reg = CONFIG_SPL_ZYNQMP_ALT_BOOTMODE;
>>>       writel(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE << BOOT_MODE_ALT_SHIFT,
>>>              &crlapb_base->boot_mode);
>>> -#endif
>>> -
>>> +#else
>>>       reg = readl(&crlapb_base->boot_mode);
>>>       if (reg >> BOOT_MODE_ALT_SHIFT)
>>>           reg >>= BOOT_MODE_ALT_SHIFT;
>>> +#endif
>>>         bootmode = reg & BOOT_MODES_MASK;
>>>   
>>
>> Looks fine; can we change this to
>>
>> if (IS_ENABLED(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE_ENABLED)) {
>>     ...
>> } else {
>>     ...
>> }
> 
> Issue is that CONFIG_SPL_ZYNQMP_ALT_BOOTMODE symbol is not defined and depends on CONFIG_SPL_ZYNQMP_ALT_BOOTMODE_ENABLED. It means you get compilation error.
> That symbol can be setup and then what you have above can work.
> Is it worth? TBH I don't have preference. Please take a look at patch below.
> (And if v1 is fine then at least there should be added depends on SPL_ZYNQMP_ALT_BOOTMODE_ENABLED to SPL_ZYNQMP_ALT_BOOTMODE which is missing there now).
> 
> Thanks,
> Michal
> 
> diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
> index eee34380f0a0..75d3ec916a66 100644
> --- a/arch/arm/mach-zynqmp/Kconfig
> +++ b/arch/arm/mach-zynqmp/Kconfig
> @@ -145,7 +145,7 @@ config ZYNQ_SDHCI_MAX_FREQ
> 
>  config SPL_ZYNQMP_ALT_BOOTMODE
>         hex
> -       default 0x0 if JTAG_MODE
> +       default 0x0
>         default 0x1 if QSPI_MODE_24BIT
>         default 0x2 if QSPI_MODE_32BIT
>         default 0x3 if SD_MODE
> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
> index 979ff3aef6c2..bbbf684ae496 100644
> --- a/arch/arm/mach-zynqmp/spl.c
> +++ b/arch/arm/mach-zynqmp/spl.c
> @@ -89,16 +89,16 @@ u32 spl_boot_device(void)
>         u32 reg = 0;
>         u8 bootmode;
> 
> -#if defined(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE_ENABLED)
> -       /* Change default boot mode at run-time */
> -       reg = CONFIG_SPL_ZYNQMP_ALT_BOOTMODE;
> -       writel(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE << BOOT_MODE_ALT_SHIFT,
> -              &crlapb_base->boot_mode);
> -#else
> -       reg = readl(&crlapb_base->boot_mode);
> -       if (reg >> BOOT_MODE_ALT_SHIFT)
> -               reg >>= BOOT_MODE_ALT_SHIFT;
> -#endif
> +       if (IS_ENABLED(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE_ENABLED)) {
> +               /* Change default boot mode at run-time */
> +               reg = CONFIG_SPL_ZYNQMP_ALT_BOOTMODE;
> +               writel(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE << BOOT_MODE_ALT_SHIFT,
> +                      &crlapb_base->boot_mode);
> +       } else {
> +               reg = readl(&crlapb_base->boot_mode);
> +               if (reg >> BOOT_MODE_ALT_SHIFT)
> +                       reg >>= BOOT_MODE_ALT_SHIFT;
> +       }
> 
>         bootmode = reg & BOOT_MODES_MASK;
> 
> 
> 

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
