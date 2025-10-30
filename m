Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1D9CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 15:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E194583642;
	Thu, 30 Oct 2025 16:35:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l2036fJN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53805836D3; Thu, 30 Oct 2025 16:35:53 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC1698334F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 16:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4710683a644so12117115e9.0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 08:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761838550; x=1762443350; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/gAYnCaT9rAjNVpvVrRs0jdMxOJRtsjqLFJf28bbH4Y=;
 b=l2036fJN0OYaV7WBP2Ov50StwdugBQHaDF/gyBW3DL2dtuNehoEKcVZju5sVbIioGJ
 OAVVwBWmH5gT1WovuXt78FWsS6xLRZ4N1ur/IkKaUNedduyGtTzbu5odB+FFtaW7h47U
 u98peOF/GJGIvMclOP7Dgwd2rIRNwj77+hWLvU+eQ7+VmrgrmGTl13Z2qHGY40r10uWh
 mD4i0k2gCn4j9UsHQjMdjbMVG9sv8J9TxOlORMvimUv2Hi1ctpmiI4AyxnnSH8VvJgaO
 /+iK6nv6ymqRVR7q4JIFDJbiB3TSx7WGPOT9zAVxR0DWJs9JUqKNU3clMaE4UxsoMIuR
 baPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761838550; x=1762443350;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/gAYnCaT9rAjNVpvVrRs0jdMxOJRtsjqLFJf28bbH4Y=;
 b=XD+flNl7pDeEFYPerJHGMzZn6c8GuXFET/H83xttNTmEkHiBZOfIVxu9Jb4BSyrPOH
 +Lhg/9BmH2P/IkgWLRsbkjwKoeWM8GI0OTuVxhlLpy32yPyi3FSlEV0hlLqt41fDyAz8
 /d+dOnnSGFTrpc6/s3d8EytzsssZ5erv8MVT1yUZU/C/WRI+UcHibSOKsPVEWeOIRC7x
 A83Rtowrt7qiV1zEHA6J0QhJEnkIka30wPG83/MOfiL84d3CFJ/TDVhy8mREiBNS1nxd
 dBsiNkLPoMq34t6MhynQ2mlLr1+w4u+0o6DMB9qtG0YzESKYIJ4cssNYxVkFTf2m7Jeh
 zBLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3CR4rUggLRHW/5YqQFPaaxg4Nnj0CvC3EtoH3DWtK/fGr6W/TBZ7etYF5eJECHd+2RySmUag=@lists.denx.de
X-Gm-Message-State: AOJu0Ywzn2EePPns5+F4uLaDaDMWTNkHDydQvRdEUHGquklt5K6d8vQb
 jRhl+MP/XskVSsfp4aiLefvaVGE4HG8yiqVvO8rpGMfSuzKm72tFZBmgH8sf5lfxJxEMGSlwb/8
 gFQSi
X-Gm-Gg: ASbGncuhPv4VYH32n61OhGJWeDhxB5lZi/wGPM+b5i2Kd1Bj6Obcy6x0N7DP8ARUX96
 6PJS0Q91dWY1N/ItkeCQ/Vhg5NEWu7KOphOxBjWQC4EEGBD/F4A58hD3JUO9eVAYPtuXED/EvpZ
 MEJGGdrGWGS63JeSkrGHSnM/8t4efTrJEExoDytB8ZDGqKqJmMA13ivveGJM1gIAj/s4Co3rWna
 lyqOaHcRPXohPSp2bzpijCeJk1UEo/0wb5ZMF5mZoBIMAxc9MumiOyGaPNHRYFkFU1md5po6f1Z
 uVrJTIrQQjQLopl4FcypfS/RPMHGDYYSU8FPe/vApiWB+S8rkdO5Zx1DmPb8MRXidn4GiZYgQYd
 N6/Dej8Kwi5lplL6M9abdouRAjLNHymaF45tIDHkMWZER9gvyx32a2T6N8PFmSI0KDLImtYXm73
 KEk4CF1lJVW5tYdR6jTMfh3cKRym31kbF7/geKcr9ZVp6VlR57IfhCveOdqMOZHyU=
X-Google-Smtp-Source: AGHT+IE5QqclupkcukQJwWwdPPcdV2Lz3Jj3q7jUHC16dibF1FyHItQ6vW+au8YDaqSJdCuODLjlUw==
X-Received: by 2002:a05:600c:a010:b0:45f:29eb:2148 with SMTP id
 5b1f17b1804b1-477300b9e59mr2498865e9.7.1761838549974; 
 Thu, 30 Oct 2025 08:35:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:fed:4601:ec33:cd66:338:ecc7?
 ([2a0a:ef40:fed:4601:ec33:cd66:338:ecc7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429ba699642sm2921733f8f.16.2025.10.30.08.35.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 08:35:49 -0700 (PDT)
Message-ID: <559f3632-9f66-4112-b97b-0c70f1df3d51@linaro.org>
Date: Thu, 30 Oct 2025 15:35:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/8] mach-k3: common: enable falcon mode from R5 SPL
To: Anshul Dalal <anshuld@ti.com>, Andrew Davis <afd@ti.com>
Cc: b-liu@ti.com, bb@ti.com, m-chawdhry@ti.com, n-francis@ti.com, nm@ti.com,
 trini@konsulko.com, u-boot@lists.denx.de, vigneshr@ti.com
References: <20251030051937.3659010-1-anshuld@ti.com>
 <20251030051937.3659010-4-anshuld@ti.com>
 <e6791dc8-45b5-458e-afdf-f96778b529af@ti.com>
 <DDVRFKCHCSJB.3HC7YUPKQQVDJ@ti.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <DDVRFKCHCSJB.3HC7YUPKQQVDJ@ti.com>
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

On 30/10/2025 15:25, Anshul Dalal wrote:
> On Thu Oct 30, 2025 at 7:16 PM IST, Andrew Davis wrote:
>> On 10/30/25 12:19 AM, Anshul Dalal wrote:
>>> We use the spl_board_prepare_for_boot hook to call k3_r5_falcon_prep
>>> which is ran after tispl is loaded but before jump_to_image.
>>>
>>> In k3_r5_falcon_prep, we find the boot media and load the kernel FIT
>>> just as standard secure falcon mode (since spl_start_uboot returns 0
>>> now). Once the kernel and args are loaded.
>>>
>>> Now when the flow goes to jump_to_image, we do the regular pre-jump
>>> procedure and jump to TFA which jumps to the kernel directly since we
>>> have already loaded the kernel and dtb at their respective addresses
>>> (PRELOADED_BL33_BASE and K3_HW_CONFIG_BASE).
>>>
>>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>>> ---
>>>    arch/arm/mach-k3/common.c    |  8 +++++++
>>>    arch/arm/mach-k3/common.h    |  4 ++++
>>>    arch/arm/mach-k3/r5/common.c | 45 ++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 57 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
>>> index 04a0f232d84..c446d1c47fd 100644
>>> --- a/arch/arm/mach-k3/common.c
>>> +++ b/arch/arm/mach-k3/common.c
>>> @@ -360,6 +360,14 @@ void spl_perform_arch_fixups(struct spl_image_info *spl_image)
>>>    
>>>    void spl_board_prepare_for_boot(void)
>>>    {
>>> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
>>> +	int ret;
>>> +
>>> +	ret = k3_r5_falcon_prep();
>>> +	if (ret)
>>> +		panic("%s: Failed to boot in falcon mode: %d\n", __func__, ret);
>>> +#endif /* falcon mode on R5 SPL */
>>> +
>>>    #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
>>>    	dcache_disable();
>>>    #endif
>>> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
>>> index 52d3faaab5c..5807d358464 100644
>>> --- a/arch/arm/mach-k3/common.h
>>> +++ b/arch/arm/mach-k3/common.h
>>> @@ -52,6 +52,10 @@ void do_board_detect(void);
>>>    void ti_secure_image_check_binary(void **p_image, size_t *p_size);
>>>    int shutdown_mcu_r5_core1(void);
>>>    
>>> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
>>> +int k3_r5_falcon_bootmode(void);
>>> +#endif
>>> +
>>>    #if (IS_ENABLED(CONFIG_K3_QOS))
>>>    void setup_qos(void);
>>>    #else
>>> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
>>> index 6269b33f66b..439dd92ef54 100644
>>> --- a/arch/arm/mach-k3/r5/common.c
>>> +++ b/arch/arm/mach-k3/r5/common.c
>>> @@ -376,3 +376,48 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
>>>    	}
>>>    }
>>>    #endif
>>> +
>>> +#ifdef CONFIG_SPL_OS_BOOT_SECURE
>>> +
>>> +static bool tifalcon_loaded;
>>
>> Not strictly needed as statics will default to 0, assigning false
>> here makes it more clear what the starting value should be,
>>
>> static bool tifalcon_loaded = false;
>>
>>> +
>>> +int spl_start_uboot(void)
>>> +{
>>> +	/* If tifalcon.bin is not loaded, proceed to regular boot */
>>> +	if (!tifalcon_loaded)
>>> +		return 1;
>>> +
>>> +	/* Boot to linux on R5 SPL with tifalcon.bin loaded */
>>> +		return 0;
>>
>> Extra indent tab here.
>>
>>> +}
>>> +
>>> +int k3_r5_falcon_prep(void)
>>> +{
>>> +	struct spl_image_loader *loader, *drv;
>>> +	struct spl_image_info kernel_image;
>>> +	struct spl_boot_device bootdev;
>>> +	int ret = -ENXIO, n_ents;
>>> +
>>> +	tifalcon_loaded = true;
>>
>> Should this be set down after we make sure loading doesn't fail?
>>
> 
> That wouldn't work actually, tifalcon_loaded is used to detect if
> tifalcon.bin has been loaded or not. We then in-turn use this
> information in our two step boot process to decide whether or not to do
> falcon boot.
> 
> The call to load_image below will internally calls spl_start_uboot to
> check for falcon mode status, which will return 0 now allowing us to
> load fitImage.
> 
> So, the overall boot flow looks as follows:
> 
> 	board_init_r
> 	|-> boot_from_devices
> 	|   +-> load_image (we load tifalcon.bin here since spl_start_uboot returns 1)
> 	|
> 	+-> spl_prepare_for_boot
> 	|   +-> k3_falcon_prep
> 	|       +-> load_image (we load fitImage here since spl_start_uboot returns 0 now)
> 	|
> 	+-> jump_to_image
> 
>>> +	memset(&kernel_image, '\0', sizeof(kernel_image));
>>> +	drv = ll_entry_start(struct spl_image_loader, spl_image_loader);
>>> +	n_ents = ll_entry_count(struct spl_image_loader, spl_image_loader);
>>> +	bootdev.boot_device = spl_boot_device();
>>> +
>>> +	for (loader = drv; loader != drv + n_ents; loader++) {
>>> +		if (bootdev.boot_device != loader->boot_device)
>>> +			continue;
>>> +		if (loader) {
>>
>> If loader is NULL, the if above containing loader->boot_device would have
>> already null pointer deref crashed. You might want to move this check up
>> into the if check above.
> 
> You're right, this needs to be fixed. I was following a similar
> structure to boot_from_devices (common/spl/spl.c) which also seems to
> have the same issue.

common/spl/spl.c was fixed by ae409a84e7bff ("spl: NULL check variable 
before dereference")

Andrew

> Regards,
> Anshul
> 
>>
>> Andrew
>>
>>> +			printf("Loading falcon payload from %s\n",
>>> +			       spl_loader_name(loader));
>>> +			ret = loader->load_image(&kernel_image, &bootdev);
>>> +			if (ret)
>>> +				continue;
>>> +
>>> +			return 0;
>>> +		}
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +#endif
> 

