Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B65C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5770684A72;
	Tue, 30 Jun 2026 14:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="euD4PaUl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFBF484A49; Tue, 30 Jun 2026 13:46:01 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5471984979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 13:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49270caa5c0so34713585e9.3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 04:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782819959; x=1783424759; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8ZZKo3hTuZszeMOVh+DAa58xe8I35YMdB1AU7DJLAzM=;
 b=euD4PaUls02ucI2dZiykD09Ixcdh73b3dj/LstzgO/4NUfDo3o3a3HL2+JoSZbqv14
 BU/g3xF7+A4nx7p9mahAiY3BN0s+yUVSMyw5gI9pK7G4CO7p7fuco8vk2W3PwGkwzZqq
 6edW6sia5NterXr8bJcV2lBiMbG/BB95xz2mKKD8Hs5xaQLy1pBrDNMVRRS9TgSO2Rqe
 W8siW/PedWBcE+CeIqCg4S+e20wYjiAUFictxCl2ZB737LV8QyQxIj5+nvOF5iuHY2i6
 u0mkKcBupF1S4jI3mTQXKdjEW9WLddUdgzMn67DB91wTzgwUJrEOb7zD3nOhMmileYAM
 6tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782819959; x=1783424759;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ZZKo3hTuZszeMOVh+DAa58xe8I35YMdB1AU7DJLAzM=;
 b=kQddNdb1kvjadpo9351maAMIKJMrZQej642mKJn09ZFZ/ZXabU6Rmk88S9WIOItdOA
 s2WSZNo2oeltqdqPg5ZZ0yzLLUF9pE1y45XH/BknVrmAIH4ojcURn5pFdtB/NK6B+KtC
 0CVNLVkByw/+wblV0nDeOybLZSLzBnJ/3xJbEVkxcCBjKkhfi+WrkpvNXkQORHgVkwoo
 5gB1T2+5LvsPhqHufdbNEZIv+xZHtH/YQGvuSTrS/EJnq6p4KAAYvoqjYypknWIpwwge
 GD9L30/wE8Ogf1iuPmPh91MxelZKETvfbSE0H00vZX1eGBXUittp5waPk9m5whq3pljj
 NZIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ANHNxrHLB0tQC/Jm6Y5zfV65Cwsfgu4+Fj37aCiN09HM5MBDvihx8THA1xn+8M7fbRojhAzw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/9/HUg+OSK8KPspQ7lJlpn/m2yQf5t38V+ESpNvYD+Lz3t91x
 IZmTJrpvFQgFxSQCxtn6tO0Jqddulr32jMlI785LH0qP9SqYeHtorR+66zt9Vzew6kI=
X-Gm-Gg: AfdE7cmJ92ib2OrxspgddwY+tDaW96g1Z+qVTr3A91Qfw13TS6BAph+Hnl1o4EeN5JF
 bl6As8mmNGokPEX2cfcU4k2w8ftCEEvmheWwiraOGGmPXey0AwLwyK166ITTv0EyE7O7q/MMS1m
 ei/WKe+f9iuXHmlSIAld2DUEA6bwlRlEbHkgRNXWTqvjw60umCGV0tBAGazzJNLq6YMn+26ISG5
 C9Mins9OeBU29avPcWPQit537a0F46S/X2F56/igBNIkgP7DJg+GmYUbHH5cAv1wsIytmSa4I+e
 ranV9HCM+uzpgpqLeSJJQbzW1uzZgOxE6lWu4grC29yDZun/bPaIPMxSSjBXl9BUoBG12r9fTzn
 dF18fo4DvKgdfvD/R3ILmeuTvnS7fvESAB6vIHfnDZ/HSgavaS0t2G0/RMRYcB1MVkes/QYaJT1
 UjmT7ryhFRr/XWUDqUZ9tZmdO9oKU=
X-Received: by 2002:a05:600c:8b0d:b0:490:b294:c652 with SMTP id
 5b1f17b1804b1-493b82acfb1mr48047755e9.20.1782819958723; 
 Tue, 30 Jun 2026 04:45:58 -0700 (PDT)
Received: from [172.16.185.106] ([195.76.196.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8d0496csm57492195e9.10.2026.06.30.04.45.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 04:45:57 -0700 (PDT)
Message-ID: <e172e03e-76ba-4fb1-bdd7-ccaab0b76bd5@linaro.org>
Date: Tue, 30 Jun 2026 13:45:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/11] mach-snapdragon: Add commands to create wrapper
 ELF
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, lukma@denx.de, tien.fong.chee@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com, alchark@gmail.com,
 mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com, ycliang@andestech.com,
 n-francis@ti.com, mateuslima.ti@gmail.com, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 philip.molloy@analog.com, ravi@prevas.dk, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-10-varadarajan.narayanan@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260623064804.3988799-10-varadarajan.narayanan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:13 +0200
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



On 6/23/26 08:48, Varadarajan Narayanan wrote:
> The IPQ5210 boot ROM expects the SPL binary image to be embedded within
> an ELF along with additional binaries. Hence add the relevant commands
> and linker script needed to convert u-boot-spl.bin to the expected
> format.

I'm a bit confused why you would duplicate this work after there was 
agreement that this series would be rebased on Michael's SDM845 SPL 
bringup?>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
> v4: Use $(obj) for u-boot-spl.wrap-elf
> 
> v3: s/a image/an image/
>      Add SPDX header to linker script
>      Pre-process linker script to use IMAGE_TEXT_BASE instead of hard coding it
> ---
>   arch/arm/mach-snapdragon/Kconfig              |  7 ++++++
>   .../mach-snapdragon/ipq5210-spl-wrap-elf.lds  | 18 ++++++++++++++
>   scripts/Makefile.xpl                          | 24 +++++++++++++++++++
>   3 files changed, 49 insertions(+)
>   create mode 100644 arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index d3de8693b5a..d94cb6206e8 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -42,4 +42,11 @@ config SYS_CONFIG_NAME
>   	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
>   	  will be used for board configuration.
>   
> +config SPL_WRAPPER_ELF
> +	bool "Create wrapper ELF for applicable platforms"
> +	depends on SPL
> +	help
> +	  Some platforms embed the U-Boot SPL binary within an ELF as a segment.
> +	  Additional tools are used to convert this ELF into an image that is
> +	  usable for the boot ROM.
>   endif
> diff --git a/arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds b/arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
> new file mode 100644
> index 00000000000..5a582e65ca0
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
> @@ -0,0 +1,18 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +PHDRS {
> +	ptype PT_LOAD FLAGS(0x7);
> +}
> +
> +ENTRY(_entry)
> +
> +SECTIONS {
> +	. = IMAGE_TEXT_BASE;
> +	_entry = . ;
> +	data : {
> +		*(.data)
> +		. = ALIGN(4);
> +	} :ptype
> +}
> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index a3fd3e1375f..6e9f24b748a 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -256,6 +256,26 @@ MKIMAGEFLAGS_boot.bin = -T zynqmpimage -R $(srctree)/$(CONFIG_BOOT_INIT_FILE) \
>   	-n "$(shell cd $(srctree); readlink -f $(CONFIG_PMUFW_INIT_FILE))"
>   endif
>   
> +ifeq ($(CONFIG_SPL_WRAPPER_ELF),y)
> +# Convert ELF to object file
> +OBJCOPYFLAGS_$(SPL_BIN).bin.o = -I binary -O elf64-littleaarch64
> +
> +# Wrap the object file inside a ELF
> +QCOM_SPL_SOC = $(shell echo $(notdir "$(CONFIG_DEFAULT_DEVICE_TREE)") | cut -f1 -d-)
> +QCOM_SPL_WRAP_LDS = $(srctree)/arch/arm/mach-snapdragon/$(QCOM_SPL_SOC)-spl-wrap-elf.lds
> +LDFLAGS_$(SPL_BIN).wrap-elf = -T $(obj)/$(SPL_BIN).wrap-elf.lds

This definitely feels pretty gross to be hacking into a generic Makefile 
regardless, but yeah you can drop this in favour of Michael's 
implementation.

> +
> +$(obj)/$(SPL_BIN).wrap-elf.lds: $(QCOM_SPL_WRAP_LDS) FORCE
> +	$(call if_changed_dep,cpp_lds)
> +
> +$(obj)/$(SPL_BIN).bin.o: $(obj)/$(SPL_BIN).bin $(obj)/$(SPL_BIN).wrap-elf.lds FORCE
> +	$(call if_changed,objcopy)
> +
> +$(obj)/$(SPL_BIN).wrap-elf: $(obj)/$(SPL_BIN).bin.o FORCE
> +	$(call if_changed,ld)
> +
> +endif
> +
>   $(obj)/$(SPL_BIN)-align.bin: $(obj)/$(SPL_BIN).bin
>   	@dd if=$< of=$@ conv=sync bs=4 2>/dev/null;
>   
> @@ -302,6 +322,10 @@ INPUTS-$(CONFIG_ARCH_ZYNQMP)	+= $(obj)/boot.bin
>   
>   INPUTS-$(CONFIG_ARCH_MEDIATEK)	+= $(obj)/u-boot-spl-mtk.bin
>   
> +ifeq ($(CONFIG_ARCH_SNAPDRAGON),y)
> +INPUTS-$(CONFIG_SPL_WRAPPER_ELF) += $(obj)/u-boot-spl.wrap-elf
> +endif
> +
>   all:	$(INPUTS-y)
>   
>   quiet_cmd_cat = CAT     $@

