Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854A7CF3962
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 17:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17ED289236;
	Thu, 19 Sep 2024 19:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="EXj57LIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D77B988B6D; Thu, 19 Sep 2024 19:37:11 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFBC2892CE
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 19:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-374b5f27cf2so661093f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 10:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1726767427; x=1727372227; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5uidgW0Q1yc7Tx20JIxfVrnPcJg8AcuVfNoCNT71I7U=;
 b=EXj57LIVlWtKcOnGYG+1ocA1IOhoMi0CJCdVJGdokqPqjwA1L7QDHz3ux03MOvzd+J
 wF/IDN30lEi84gvc6uAiwP3ELC1+pWGgAqOWHOUhBFk/jJRDStiJL9j92+IldlSBVyjc
 YR+78xMHU2L56VgjnTqwqIx+Pco1JpidjWiRHyaw5KAziPMPQ4ha5iD6nLef3jLDoBHe
 tPZ9qWg6l1b6bXYXYxjYrdDMkYVQzmCxUW3Nt4wt5FqUNa0GEkkg/4D7kqX7euVr+6lP
 GU7VgRRMmzr9gkxQdDNbyd76cTrd7hat6RR548g0XNJa/8/52Moz+lhkfFP+PpKkfAk/
 g4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726767427; x=1727372227;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5uidgW0Q1yc7Tx20JIxfVrnPcJg8AcuVfNoCNT71I7U=;
 b=TjQn+iOgNEYBkPJ3nKRG+CecnrDElC1rPnKNl+uFFY4ss+FaO9PLwgDThdgswYuXmX
 RI8I5HVDYhnHd/UWC4n0Pd/ok1wXU+SebNN7iA3cDHvpEIig8DM3yfr40RfdfAq6fO2m
 Z1RkRiR+1gzHvP35tkWp2bnq5yxx76FDs2IFH2g3f4acb3Dh50Nu7pE75a+F9lndXUBy
 kosBepffBwOV7/0eQpgrqtYLLdwONT/fNfOFfFW0KHnYfA1dF4Ik3P7NVh3wOIELxUdB
 9gG3FoxhTlWY+kDehgr8uerqIjLJS5Az4A2E0rxaY0aGXjGeMJajTMtSBRAiXyubsL8M
 L6Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/8wAomnMZkwUndK+IOh9IMW2V6DK6OCCBaw0vf2+dVshOWra8+el3WtR48cyshL30Pb8kXk8=@lists.denx.de
X-Gm-Message-State: AOJu0YwGxx4e0ZqOBIQ4eD/s5PNvmXtLJkFZr0/HP/bTyS14CrcANMT/
 xrWDfjf0Zzngo/pBQpb412x8LPL4K8VOTITNhj8ZlO/3VcHceLExjshxsPtoMho=
X-Google-Smtp-Source: AGHT+IGn0MRgSSORkwYHqGJyfBpMxtYqWKtySaabgKp5GF+AaaUGjSllPymWwFcQ+KifbXynJ0pWLA==
X-Received: by 2002:a5d:6143:0:b0:374:c8d3:5f2f with SMTP id
 ffacd0b85a97d-37a422bdfa9mr48419f8f.31.1726767427069; 
 Thu, 19 Sep 2024 10:37:07 -0700 (PDT)
Received: from [192.168.0.31] (80.224.71.185.static.user.ono.com.
 [80.224.71.185]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e78002afsm15704862f8f.75.2024.09.19.10.37.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 10:37:06 -0700 (PDT)
Message-ID: <c7cfbc6e-af33-4e73-a393-f07a11e9a8b9@suse.com>
Date: Thu, 19 Sep 2024 19:37:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/35] arm: mach-bcm283x: Bring in some header files
 from tianocore
To: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 linux-kernel@vger.kernel.org
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-28-patrick.rudolph@9elements.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20240918152136.3395170-28-patrick.rudolph@9elements.com>
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



On 18/09/2024 17:20, Patrick Rudolph wrote:
> From: Simon Glass <sjg@chromium.org>>
> 
> These header files presumably duplicate things already in the U-Boot
> devicetree. For now, bring them in to get the ASL code and ACPI table
> code to compile.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>

Acked-by: Matthias Brugger <mbrugger@suse.com>


> ---
>   .../mach-bcm283x/include/mach/acpi/bcm2711.h  | 152 ++++++++++++++++++
>   .../mach-bcm283x/include/mach/acpi/bcm2836.h  | 127 +++++++++++++++
>   .../include/mach/acpi/bcm2836_gpio.h          |  19 +++
>   .../include/mach/acpi/bcm2836_gpu.h           |  47 ++++++
>   .../include/mach/acpi/bcm2836_pwm.h           |  33 ++++
>   .../include/mach/acpi/bcm2836_sdhost.h        |  18 +++
>   .../include/mach/acpi/bcm2836_sdio.h          |  21 +++
>   drivers/pci/pcie_brcmstb.c                    | 101 ++----------
>   8 files changed, 427 insertions(+), 91 deletions(-)
>   create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
>   create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836.h
>   create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpio.h
>   create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpu.h
>   create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_pwm.h
>   create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdhost.h
>   create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdio.h
> 
> diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
> new file mode 100644
> index 0000000000..a86875b183
> --- /dev/null
> +++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
> @@ -0,0 +1,152 @@
> +/* SPDX-License-Identifier: BSD-2-Clause-Patent */
> +/**
> + *
> + *  Copyright (c) 2019, Jeremy Linton
> + *  Copyright (c) 2019, Pete Batard <pete@akeo.ie>.
> + *
> + **/
> +
> +#ifndef BCM2711_H__
> +#define BCM2711_H__
> +
> +#define BCM2711_SOC_REGISTERS              0xfc000000
> +#define BCM2711_SOC_REGISTER_LENGTH        0x02000000
> +
> +#define BCM2711_ARM_LOCAL_REGISTERS        0xfe000000
> +#define BCM2711_ARM_LOCAL_REGISTER_LENGTH  0x02000000
> +
> +/* arm local addresses */
> +#define BCM2711_ARMC_OFFSET                0x0000b000
> +#define BCM2711_ARMC_BASE_ADDRESS          (BCM2711_ARM_LOCAL_REGISTERS + BCM2711_ARMC_OFFSET)
> +#define BCM2711_ARMC_LENGTH                0x00000400
> +
> +#define BCM2711_ARM_LOCAL_OFFSET           0x01800000
> +#define BCM2711_ARM_LOCAL_BASE_ADDRESS     (BCM2711_ARM_LOCAL_REGISTERS + BCM2711_ARM_LOCAL_OFFSET)
> +#define BCM2711_ARM_LOCAL_LENGTH           0x00000080
> +
> +#define BCM2711_GIC400_OFFSET              0x01840000
> +#define BCM2711_GIC400_BASE_ADDRESS        (BCM2711_ARM_LOCAL_REGISTERS + BCM2711_GIC400_OFFSET)
> +#define BCM2711_GIC400_LENGTH              0x00008000
> +
> +/* Generic PCI addresses */
> +#define PCIE_TOP_OF_MEM_WIN                0xf8000000
> +#define PCIE_CPU_MMIO_WINDOW               0x600000000
> +#define PCIE_BRIDGE_MMIO_LEN               0x3ffffff
> +
> +/* PCI root bridge control registers location */
> +#define PCIE_REG_BASE                      0xfd500000
> +#define PCIE_REG_LIMIT                     0x9310
> +
> +/* PCI root bridge control registers */
> +#define BRCM_PCIE_CAP_REGS                        0x00ac
> +#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1   0x0188
> +#define  VENDOR_SPECIFIC_REG1_LITTLE_ENDIAN          0x0
> +#define PCIE_RC_CFG_PRIV1_ID_VAL3                 0x043c
> +#define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY         0x04dc
> +#define  LINK_CAPABILITY_ASPM_SUPPORT_MASK         0xc00
> +
> +#define PCIE_RC_DL_MDIO_ADDR                      0x1100
> +#define PCIE_RC_DL_MDIO_WR_DATA                   0x1104
> +#define PCIE_RC_DL_MDIO_RD_DATA                   0x1108
> +
> +#define PCIE_MISC_MISC_CTRL                       0x4008
> +#define  MISC_CTRL_SCB_ACCESS_EN_MASK             0x1000
> +#define  MISC_CTRL_CFG_READ_UR_MODE_MASK          0x2000
> +#define  MISC_CTRL_MAX_BURST_SIZE_MASK            0x300000
> +#define  MISC_CTRL_MAX_BURST_SIZE_128             0x0
> +#define  MISC_CTRL_SCB0_SIZE_MASK                 0xf8000000
> +
> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO          0x400c
> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI          0x4010
> +#define PCIE_MEM_WIN0_LO(win)	\
> +		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 4)
> +
> +#define PCIE_MEM_WIN0_HI(win)	\
> +		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 4)
> +#define PCIE_MISC_RC_BAR1_CONFIG_LO               0x402c
> +#define  RC_BAR1_CONFIG_LO_SIZE_MASK                0x1f
> +#define PCIE_MISC_RC_BAR2_CONFIG_LO               0x4034
> +#define  RC_BAR2_CONFIG_LO_SIZE_MASK                0x1f
> +#define PCIE_MISC_RC_BAR2_CONFIG_HI               0x4038
> +#define PCIE_MISC_RC_BAR3_CONFIG_LO               0x403c
> +#define  RC_BAR3_CONFIG_LO_SIZE_MASK                0x1f
> +#define PCIE_MISC_PCIE_STATUS                     0x4068
> +#define  STATUS_PCIE_PORT_MASK                      0x80
> +#define  STATUS_PCIE_PORT_SHIFT                        7
> +#define  STATUS_PCIE_DL_ACTIVE_MASK                 0x20
> +#define  STATUS_PCIE_DL_ACTIVE_SHIFT                   5
> +#define  STATUS_PCIE_PHYLINKUP_MASK                 0x10
> +#define  STATUS_PCIE_PHYLINKUP_SHIFT                   4
> +#define PCIE_MISC_REVISION                        0x406c
> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT  0x4070
> +#define  MEM_WIN0_BASE_LIMIT_LIMIT_MASK           0xfff00000
> +#define  MEM_WIN0_BASE_LIMIT_BASE_MASK            0xfff0
> +#define  MEM_WIN0_BASE_LIMIT_BASE_HI_SHIFT        12
> +#define PCIE_MEM_WIN0_BASE_LIMIT(win)	\
> +	 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT + ((win) * 4)
> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI     0x4080
> +#define  MEM_WIN0_BASE_HI_BASE_MASK               0xff
> +#define PCIE_MEM_WIN0_BASE_HI(win)	\
> +	 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI + ((win) * 8)
> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI    0x4084
> +#define  PCIE_MEM_WIN0_LIMIT_HI_LIMIT_MASK        0xff
> +#define PCIE_MEM_WIN0_LIMIT_HI(win)	\
> +	 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
> +
> +#define PCIE_MISC_HARD_PCIE_HARD_DEBUG            0x4204
> +#define  PCIE_HARD_DEBUG_SERDES_IDDQ_MASK         0x08000000
> +
> +#define PCIE_INTR2_CPU_STATUS                 0x4300
> +#define PCIE_INTR2_CPU_SET                    0x4304
> +#define PCIE_INTR2_CPU_CLR                    0x4308
> +#define PCIE_INTR2_CPU_MASK_STATUS            0x430c
> +#define PCIE_INTR2_CPU_MASK_SET               0x4310
> +#define PCIE_INTR2_CPU_MASK_CLR               0x4314
> +
> +#define PCIE_MSI_INTR2_CLR                    0x4508
> +#define PCIE_MSI_INTR2_MASK_SET               0x4510
> +
> +#define PCIE_RGR1_SW_INIT_1                   0x9210
> +#define PCIE_EXT_CFG_INDEX                    0x9000
> +/* A small window pointing at the ECAM of the device selected by CFG_INDEX */
> +#define PCIE_EXT_CFG_DATA                     0x8000
> +
> +#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK 0xc
> +#define PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK                     0xffffff
> +
> +#define PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK                  0x1000
> +#define PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK               0x2000
> +#define PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK                 0x300000
> +#define PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK                      0xf8000000
> +#define PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK                      0x7c00000
> +#define PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK                      0x1f
> +#define PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK                   0x1f
> +
> +#define PCIE_RGR1_SW_INIT_1_INIT_MASK                           0x2
> +#define PCIE_RGR1_SW_INIT_1_PERST_MASK                          0x1
> +
> +#define PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK         0x08000000
> +
> +#define PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK 0x2
> +
> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_MASK     0xfff00000
> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_BASE_MASK      0xfff0
> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI_BASE_MASK         0xff
> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI_LIMIT_MASK       0xff
> +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_MASK_BITS                 0xc
> +
> +#define PCIE_MISC_REVISION_MAJMIN_MASK                          0xffff
> +
> +#define BURST_SIZE_128          0
> +#define BURST_SIZE_256          1
> +#define BURST_SIZE_512          2
> +
> +#define BCM2711_THERM_SENSOR_OFFSET           0x015d2200
> +#define BCM2711_THERM_SENSOR_BASE_ADDRESS     (BCM2711_SOC_REGISTERS + BCM2711_THERM_SENSOR_OFFSET)
> +#define BCM2711_THERM_SENSOR_LENGTH           0x00000008
> +
> +#define BCM2711_GENET_BASE_OFFSET             0x01580000
> +#define BCM2711_GENET_BASE_ADDRESS            (BCM2711_SOC_REGISTERS + BCM2711_GENET_BASE_OFFSET)
> +#define BCM2711_GENET_LENGTH                  0x10000
> +
> +#endif /* BCM2711_H__ */
> diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836.h
> new file mode 100644
> index 0000000000..64cec36a94
> --- /dev/null
> +++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836.h
> @@ -0,0 +1,127 @@
> +/* SPDX-License-Identifier: BSD-2-Clause-Patent */
> +/**
> + *
> + *  Copyright (c) 2019, ARM Limited. All rights reserved.
> + *  Copyright (c) 2017, Andrei Warkentin <andrey.warkentin@gmail.com>
> + *  Copyright (c) 2016, Linaro Limited. All rights reserved.
> + *
> + **/
> +
> +#ifndef __BCM2836_H__
> +#define __BCM2836_H__
> +
> +/*
> + * Both "core" and SoC perpherals (1M each).
> + */
> +#define BCM2836_SOC_REGISTERS                 0xfe000000
> +#define BCM2836_SOC_REGISTER_LENGTH           0x02000000
> +
> +/*
> + * Offset between the CPU's view and the VC's view of system memory.
> + */
> +#define BCM2836_DMA_DEVICE_OFFSET             0xc0000000
> +
> +/* watchdog constants */
> +#define BCM2836_WDOG_OFFSET                   0x00100000
> +#define BCM2836_WDOG_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_WDOG_OFFSET)
> +#define BCM2836_WDOG_PASSWORD                 0x5a000000
> +#define BCM2836_WDOG_RSTC_OFFSET              0x0000001c
> +#define BCM2836_WDOG_WDOG_OFFSET              0x00000024
> +#define BCM2836_WDOG_RSTC_WRCFG_MASK          0x00000030
> +#define BCM2836_WDOG_RSTC_WRCFG_FULL_RESET    0x00000020
> +
> +/* clock manager constants */
> +#define BCM2836_CM_OFFSET                     0x00101000
> +#define BCM2836_CM_BASE                       (BCM2836_SOC_REGISTERS + BCM2836_CM_OFFSET)
> +#define BCM2836_CM_GEN_CLOCK_CONTROL          0x0000
> +#define BCM2836_CM_GEN_CLOCK_DIVISOR          0x0004
> +#define BCM2836_CM_VPU_CLOCK_CONTROL          0x0008
> +#define BCM2836_CM_VPU_CLOCK_DIVISOR          0x000c
> +#define BCM2836_CM_SYSTEM_CLOCK_CONTROL       0x0010
> +#define BCM2836_CM_SYSTEM_CLOCK_DIVISOR       0x0014
> +#define BCM2836_CM_H264_CLOCK_CONTROL         0x0028
> +#define BCM2836_CM_H264_CLOCK_DIVISOR         0x002c
> +#define BCM2836_CM_PWM_CLOCK_CONTROL          0x00a0
> +#define BCM2836_CM_PWM_CLOCK_DIVISOR          0x00a4
> +#define BCM2836_CM_UART_CLOCK_CONTROL         0x00f0
> +#define BCM2836_CM_UART_CLOCK_DIVISOR         0x00f4
> +#define BCM2836_CM_SDC_CLOCK_CONTROL          0x01a8
> +#define BCM2836_CM_SDC_CLOCK_DIVISOR          0x01ac
> +#define BCM2836_CM_ARM_CLOCK_CONTROL          0x01b0
> +#define BCM2836_CM_ARM_CLOCK_DIVISOR          0x01b4
> +#define BCM2836_CM_EMMC_CLOCK_CONTROL         0x01c0
> +#define BCM2836_CM_EMMC_CLOCK_DIVISOR         0x01c4
> +
> +/* mailbox interface constants */
> +#define BCM2836_MBOX_OFFSET                   0x0000b880
> +#define BCM2836_MBOX_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_MBOX_OFFSET)
> +#define BCM2836_MBOX_LENGTH                   0x00000024
> +#define BCM2836_MBOX_READ_OFFSET              0x00000000
> +#define BCM2836_MBOX_STATUS_OFFSET            0x00000018
> +#define BCM2836_MBOX_CONFIG_OFFSET            0x0000001c
> +#define BCM2836_MBOX_WRITE_OFFSET             0x00000020
> +
> +#define BCM2836_MBOX_STATUS_FULL              0x1f
> +#define BCM2836_MBOX_STATUS_EMPTY             0x1e
> +
> +#define BCM2836_MBOX_NUM_CHANNELS             16
> +
> +/* interrupt controller constants */
> +#define BCM2836_INTC_TIMER_CONTROL_OFFSET     0x00000040
> +#define BCM2836_INTC_TIMER_PENDING_OFFSET     0x00000060
> +
> +/* usb constants */
> +#define BCM2836_USB_OFFSET                    0x00980000
> +#define BCM2836_USB_BASE_ADDRESS              (BCM2836_SOC_REGISTERS + BCM2836_USB_OFFSET)
> +#define BCM2836_USB_LENGTH                    0x00010000
> +
> +/* serial based protocol constants */
> +#define BCM2836_PL011_UART_OFFSET             0x00201000
> +#define BCM2836_PL011_UART_BASE_ADDRESS       (BCM2836_SOC_REGISTERS + BCM2836_PL011_UART_OFFSET)
> +#define BCM2836_PL011_UART_LENGTH             0x00001000
> +
> +#define BCM2836_MINI_UART_OFFSET              0x00215000
> +#define BCM2836_MINI_UART_BASE_ADDRESS        (BCM2836_SOC_REGISTERS + BCM2836_MINI_UART_OFFSET)
> +#define BCM2836_MINI_UART_LENGTH              0x00000070
> +
> +#define BCM2836_I2C0_OFFSET                   0x00205000
> +#define BCM2836_I2C0_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_I2C0_OFFSET)
> +#define BCM2836_I2C0_LENGTH                   0x00000020
> +
> +#define BCM2836_I2C1_OFFSET                   0x00804000
> +#define BCM2836_I2C1_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_I2C1_OFFSET)
> +#define BCM2836_I2C1_LENGTH                   0x00000020
> +
> +#define BCM2836_I2C2_OFFSET                   0x00805000
> +#define BCM2836_I2C2_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_I2C2_OFFSET)
> +#define BCM2836_I2C2_LENGTH                   0x00000020
> +
> +#define BCM2836_SPI0_OFFSET                   0x00204000
> +#define BCM2836_SPI0_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_SPI0_OFFSET)
> +#define BCM2836_SPI0_LENGTH                   0x00000020
> +
> +#define BCM2836_SPI1_OFFSET                   0x00215080
> +#define BCM2836_SPI1_LENGTH                   0x00000040
> +#define BCM2836_SPI1_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_SPI1_OFFSET)
> +
> +#define BCM2836_SPI2_OFFSET                   0x002150C0
> +#define BCM2836_SPI2_LENGTH                   0x00000040
> +#define BCM2836_SPI2_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_SPI2_OFFSET)
> +
> +#define BCM2836_SYSTEM_TIMER_OFFSET           0x00003000
> +#define BCM2836_SYSTEM_TIMER_LENGTH           0x00000020
> +#define BCM2836_SYSTEM_TIMER_ADDRESS          (BCM2836_SOC_REGISTERS + BCM2836_SYSTEM_TIMER_OFFSET)
> +
> +/* dma constants */
> +#define BCM2836_DMA0_OFFSET                   0x00007000
> +#define BCM2836_DMA0_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_DMA0_OFFSET)
> +
> +#define BCM2836_DMA15_OFFSET                  0x00E05000
> +#define BCM2836_DMA15_BASE_ADDRESS            (BCM2836_SOC_REGISTERS + BCM2836_DMA15_OFFSET)
> +
> +#define BCM2836_DMA_CTRL_OFFSET               0x00007FE0
> +#define BCM2836_DMA_CTRL_BASE_ADDRESS         (BCM2836_SOC_REGISTERS + BCM2836_DMA_CTRL_OFFSET)
> +
> +#define BCM2836_DMA_CHANNEL_LENGTH            0x00000100
> +
> +#endif /*__BCM2836_H__ */
> diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpio.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpio.h
> new file mode 100644
> index 0000000000..c5b858b412
> --- /dev/null
> +++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpio.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: BSD-2-Clause-Patent */
> +/**
> + *
> + *  Copyright (c) 2020, Pete Batard <pete@akeo.ie>
> + *  Copyright (c) 2018, Andrei Warkentin <andrey.warkentin@gmail.com>
> + *  Copyright (c) Microsoft Corporation. All rights reserved.
> + *
> + **/
> +
> +#include <asm/arch/acpi/bcm2836.h>
> +
> +#ifndef __BCM2836_GPIO_H__
> +#define __BCM2836_GPIO_H__
> +
> +#define GPIO_OFFSET        0x00200000
> +#define GPIO_BASE_ADDRESS  (BCM2836_SOC_REGISTERS + GPIO_OFFSET)
> +#define GPIO_LENGTH        0x000000B4
> +
> +#endif /* __BCM2836_GPIO_H__ */
> diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpu.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpu.h
> new file mode 100644
> index 0000000000..5857d7581a
> --- /dev/null
> +++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpu.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: BSD-2-Clause-Patent */
> +/**
> + *
> + *  Copyright (c) 2020, Pete Batard <pete@akeo.ie>
> + *
> + **/
> +
> +#include <asm/arch/acpi/bcm2836.h>
> +
> +#ifndef __BCM2836_GPU_H__
> +#define __BCM2836_GPU_H__
> +
> +/* VideoCore constants */
> +
> +#define BCM2836_VCHIQ_OFFSET                  0x0000B840
> +#define BCM2836_VCHIQ_BASE_ADDRESS            (BCM2836_SOC_REGISTERS + BCM2836_VCHIQ_OFFSET)
> +#define BCM2836_VCHIQ_LENGTH                  0x00000010
> +
> +#define BCM2836_V3D_BUS_OFFSET                0x00C00000
> +#define BCM2836_V3D_BUS_BASE_ADDRESS          (BCM2836_SOC_REGISTERS + BCM2836_V3D_BUS_OFFSET)
> +#define BCM2836_V3D_BUS_LENGTH                0x00001000
> +
> +#define BCM2836_HVS_OFFSET                    0x00400000
> +#define BCM2836_HVS_BASE_ADDRESS              (BCM2836_SOC_REGISTERS + BCM2836_HVS_OFFSET)
> +#define BCM2836_HVS_LENGTH                    0x00006000
> +
> +#define BCM2836_PV0_OFFSET                    0x00206000
> +#define BCM2836_PV0_BASE_ADDRESS              (BCM2836_SOC_REGISTERS + BCM2836_PV0_OFFSET)
> +#define BCM2836_PV0_LENGTH                    0x00000100
> +
> +#define BCM2836_PV1_OFFSET                    0x00207000
> +#define BCM2836_PV1_BASE_ADDRESS              (BCM2836_SOC_REGISTERS + BCM2836_PV1_OFFSET)
> +#define BCM2836_PV1_LENGTH                    0x00000100
> +
> +#define BCM2836_PV2_OFFSET                    0x00807000
> +#define BCM2836_PV2_BASE_ADDRESS              (BCM2836_SOC_REGISTERS + BCM2836_PV2_OFFSET)
> +#define BCM2836_PV2_LENGTH                    0x00000100
> +
> +#define BCM2836_HDMI0_OFFSET                  0x00902000
> +#define BCM2836_HDMI0_BASE_ADDRESS            (BCM2836_SOC_REGISTERS + BCM2836_HDMI0_OFFSET)
> +#define BCM2836_HDMI0_LENGTH                  0x00000600
> +
> +#define BCM2836_HDMI1_OFFSET                  0x00808000
> +#define BCM2836_HDMI1_BASE_ADDRESS            (BCM2836_SOC_REGISTERS + BCM2836_HDMI1_OFFSET)
> +#define BCM2836_HDMI1_LENGTH                  0x00000100
> +
> +#endif /* __BCM2836_MISC_H__ */
> diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_pwm.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_pwm.h
> new file mode 100644
> index 0000000000..78a8486673
> --- /dev/null
> +++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_pwm.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: BSD-2-Clause-Patent */
> +/**
> + *
> + *  Copyright (c) 2020, Pete Batard <pete@akeo.ie>
> + *
> + **/
> +
> +#include <asm/arch/acpi/bcm2836.h>
> +
> +#ifndef __BCM2836_PWM_H__
> +#define __BCM2836_PWM_H__
> +
> +/* PWM controller constants */
> +
> +#define BCM2836_PWM_DMA_OFFSET                 0x00007B00
> +#define BCM2836_PWM_DMA_BASE_ADDRESS           (BCM2836_SOC_REGISTERS + BCM2836_PWM_DMA_OFFSET)
> +#define BCM2836_PWM_DMA_LENGTH                 0x00000100
> +
> +#define BCM2836_PWM_CLK_OFFSET                 0x001010A0
> +#define BCM2836_PWM_CLK_BASE_ADDRESS           (BCM2836_SOC_REGISTERS + BCM2836_PWM_CLK_OFFSET)
> +#define BCM2836_PWM_CLK_LENGTH                 0x00000008
> +
> +#define BCM2836_PWM_CTRL_OFFSET                0x0020C000
> +#define BCM2836_PWM_CTRL_BASE_ADDRESS          (BCM2836_SOC_REGISTERS + BCM2836_PWM_CTRL_OFFSET)
> +#define BCM2836_PWM_CTRL_LENGTH                0x00000028
> +
> +#define BCM2836_PWM_BUS_BASE_ADDRESS           0x7E20C000
> +#define BCM2836_PWM_BUS_LENGTH                 0x00000028
> +
> +#define BCM2836_PWM_CTRL_UNCACHED_BASE_ADDRESS 0xFF20C000
> +#define BCM2836_PWM_CTRL_UNCACHED_LENGTH       0x00000028
> +
> +#endif /* __BCM2836_PWM_H__ */
> diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdhost.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdhost.h
> new file mode 100644
> index 0000000000..9b1afe8440
> --- /dev/null
> +++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdhost.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: BSD-2-Clause-Patent */
> +/**
> + *
> + *  Copyright (c) 2017, Andrei Warkentin <andrey.warkentin@gmail.com>
> + *  Copyright (c) Microsoft Corporation. All rights reserved.
> + *
> + **/
> +
> +#include <asm/arch/acpi/bcm2836.h>
> +
> +#ifndef __BCM2836_SDHOST_H__
> +#define __BCM2836_SDHOST_H__
> +
> +#define SDHOST_OFFSET               0x00202000
> +#define SDHOST_BASE_ADDRESS         (BCM2836_SOC_REGISTERS + SDHOST_OFFSET)
> +#define SDHOST_LENGTH               0x00000100
> +
> +#endif /*__BCM2836_SDHOST_H__ */
> diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdio.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdio.h
> new file mode 100644
> index 0000000000..48d073d434
> --- /dev/null
> +++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdio.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: BSD-2-Clause-Patent */
> +/**
> + *
> + *  Copyright (c) Microsoft Corporation. All rights reserved.
> + *
> + **/
> +
> +#include <asm/arch/acpi/bcm2836.h>
> +
> +#ifndef __BCM2836_SDIO_H__
> +#define __BCM2836_SDIO_H__
> +
> +// MMC/SD/SDIO1 register definitions.
> +#define MMCHS1_OFFSET     0x00300000
> +#define MMCHS2_OFFSET     0x00340000
> +#define MMCHS1_BASE       (BCM2836_SOC_REGISTERS + MMCHS1_OFFSET)
> +#define MMCHS2_BASE       (BCM2836_SOC_REGISTERS + MMCHS2_OFFSET)
> +#define MMCHS1_LENGTH     0x00000100
> +#define MMCHS2_LENGTH     0x00000100
> +
> +#endif /* __BCM2836_SDIO_H__ */
> diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
> index f978c64365..f089c48f02 100644
> --- a/drivers/pci/pcie_brcmstb.c
> +++ b/drivers/pci/pcie_brcmstb.c
> @@ -12,6 +12,7 @@
>    * Copyright (C) 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>    */
>   
> +#include <asm/arch/acpi/bcm2711.h>
>   #include <errno.h>
>   #include <dm.h>
>   #include <dm/ofnode.h>
> @@ -21,88 +22,6 @@
>   #include <linux/log2.h>
>   #include <linux/iopoll.h>
>   
> -/* Offset of the mandatory PCIe capability config registers */
> -#define BRCM_PCIE_CAP_REGS				0x00ac
> -
> -/* The PCIe controller register offsets */
> -#define PCIE_RC_CFG_VENDOR_SPECIFIC_REG1		0x0188
> -#define  VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK	0xc
> -#define  VENDOR_SPECIFIC_REG1_LITTLE_ENDIAN		0x0
> -
> -#define PCIE_RC_CFG_PRIV1_ID_VAL3			0x043c
> -#define  CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK		0xffffff
> -
> -#define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
> -#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
> -
> -#define PCIE_RC_DL_MDIO_ADDR				0x1100
> -#define PCIE_RC_DL_MDIO_WR_DATA				0x1104
> -#define PCIE_RC_DL_MDIO_RD_DATA				0x1108
> -
> -#define PCIE_MISC_MISC_CTRL				0x4008
> -#define  MISC_CTRL_SCB_ACCESS_EN_MASK			0x1000
> -#define  MISC_CTRL_CFG_READ_UR_MODE_MASK		0x2000
> -#define  MISC_CTRL_MAX_BURST_SIZE_MASK			0x300000
> -#define  MISC_CTRL_MAX_BURST_SIZE_128			0x0
> -#define  MISC_CTRL_SCB0_SIZE_MASK			0xf8000000
> -
> -#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
> -#define PCIE_MEM_WIN0_LO(win)	\
> -		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 4)
> -
> -#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI		0x4010
> -#define PCIE_MEM_WIN0_HI(win)	\
> -		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 4)
> -
> -#define PCIE_MISC_RC_BAR1_CONFIG_LO			0x402c
> -#define  RC_BAR1_CONFIG_LO_SIZE_MASK			0x1f
> -
> -#define PCIE_MISC_RC_BAR2_CONFIG_LO			0x4034
> -#define  RC_BAR2_CONFIG_LO_SIZE_MASK			0x1f
> -#define PCIE_MISC_RC_BAR2_CONFIG_HI			0x4038
> -
> -#define PCIE_MISC_RC_BAR3_CONFIG_LO			0x403c
> -#define  RC_BAR3_CONFIG_LO_SIZE_MASK			0x1f
> -
> -#define PCIE_MISC_PCIE_STATUS				0x4068
> -#define  STATUS_PCIE_PORT_MASK				0x80
> -#define  STATUS_PCIE_PORT_SHIFT				7
> -#define  STATUS_PCIE_DL_ACTIVE_MASK			0x20
> -#define  STATUS_PCIE_DL_ACTIVE_SHIFT			5
> -#define  STATUS_PCIE_PHYLINKUP_MASK			0x10
> -#define  STATUS_PCIE_PHYLINKUP_SHIFT			4
> -
> -#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT	0x4070
> -#define  MEM_WIN0_BASE_LIMIT_LIMIT_MASK			0xfff00000
> -#define  MEM_WIN0_BASE_LIMIT_BASE_MASK			0xfff0
> -#define  MEM_WIN0_BASE_LIMIT_BASE_HI_SHIFT		12
> -#define PCIE_MEM_WIN0_BASE_LIMIT(win)	\
> -	 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT + ((win) * 4)
> -
> -#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI		0x4080
> -#define  MEM_WIN0_BASE_HI_BASE_MASK			0xff
> -#define PCIE_MEM_WIN0_BASE_HI(win)	\
> -	 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI + ((win) * 8)
> -
> -#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI		0x4084
> -#define  PCIE_MEM_WIN0_LIMIT_HI_LIMIT_MASK		0xff
> -#define PCIE_MEM_WIN0_LIMIT_HI(win)	\
> -	 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
> -
> -#define PCIE_MISC_HARD_PCIE_HARD_DEBUG			0x4204
> -#define  PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
> -
> -#define PCIE_MSI_INTR2_CLR				0x4508
> -#define PCIE_MSI_INTR2_MASK_SET				0x4510
> -
> -#define PCIE_EXT_CFG_DATA				0x8000
> -
> -#define PCIE_EXT_CFG_INDEX				0x9000
> -
> -#define PCIE_RGR1_SW_INIT_1				0x9210
> -#define  RGR1_SW_INIT_1_PERST_MASK			0x1
> -#define  RGR1_SW_INIT_1_INIT_MASK			0x2
> -
>   /* PCIe parameters */
>   #define BRCM_NUM_PCIE_OUT_WINS				4
>   
> @@ -447,7 +366,7 @@ static int brcm_pcie_probe(struct udevice *dev)
>   	 * This will need to be changed when support for other SoCs is added.
>   	 */
>   	setbits_le32(base + PCIE_RGR1_SW_INIT_1,
> -		     RGR1_SW_INIT_1_INIT_MASK | RGR1_SW_INIT_1_PERST_MASK);
> +		     PCIE_RGR1_SW_INIT_1_INIT_MASK | PCIE_RGR1_SW_INIT_1_PERST_MASK);
>   	/*
>   	 * The delay is a safety precaution to preclude the reset signal
>   	 * from looking like a glitch.
> @@ -455,7 +374,7 @@ static int brcm_pcie_probe(struct udevice *dev)
>   	udelay(100);
>   
>   	/* Take the bridge out of reset */
> -	clrbits_le32(base + PCIE_RGR1_SW_INIT_1, RGR1_SW_INIT_1_INIT_MASK);
> +	clrbits_le32(base + PCIE_RGR1_SW_INIT_1, PCIE_RGR1_SW_INIT_1_INIT_MASK);
>   
>   	clrbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG,
>   		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
> @@ -508,7 +427,7 @@ static int brcm_pcie_probe(struct udevice *dev)
>   
>   	/* Unassert the fundamental reset */
>   	clrbits_le32(pcie->base + PCIE_RGR1_SW_INIT_1,
> -		     RGR1_SW_INIT_1_PERST_MASK);
> +		     PCIE_RGR1_SW_INIT_1_PERST_MASK);
>   
>   	/*
>   	 * Wait for 100ms after PERST# deassertion; see PCIe CEM specification
> @@ -552,7 +471,7 @@ static int brcm_pcie_probe(struct udevice *dev)
>   	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
>   	 */
>   	clrsetbits_le32(base + PCIE_RC_CFG_PRIV1_ID_VAL3,
> -			CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK, 0x060400);
> +			PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK, 0x060400);
>   
>   	if (pcie->ssc) {
>   		ret = brcm_pcie_set_ssc(pcie->base);
> @@ -570,8 +489,8 @@ static int brcm_pcie_probe(struct udevice *dev)
>   	       nlw, ssc_good ? "(SSC)" : "(!SSC)");
>   
>   	/* PCIe->SCB endian mode for BAR */
> -	clrsetbits_le32(base + PCIE_RC_CFG_VENDOR_SPECIFIC_REG1,
> -			VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK,
> +	clrsetbits_le32(base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1,
> +			PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK,
>   			VENDOR_SPECIFIC_REG1_LITTLE_ENDIAN);
>   
>   	/*
> @@ -584,7 +503,7 @@ static int brcm_pcie_probe(struct udevice *dev)
>   	 * let's instead just unadvertise ASPM support.
>   	 */
>   	clrbits_le32(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY,
> -		     PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
> +		     LINK_CAPABILITY_ASPM_SUPPORT_MASK);
>   
>   	return 0;
>   }
> @@ -595,14 +514,14 @@ static int brcm_pcie_remove(struct udevice *dev)
>   	void __iomem *base = pcie->base;
>   
>   	/* Assert fundamental reset */
> -	setbits_le32(base + PCIE_RGR1_SW_INIT_1, RGR1_SW_INIT_1_PERST_MASK);
> +	setbits_le32(base + PCIE_RGR1_SW_INIT_1, PCIE_RGR1_SW_INIT_1_PERST_MASK);
>   
>   	/* Turn off SerDes */
>   	setbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG,
>   		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
>   
>   	/* Shutdown bridge */
> -	setbits_le32(base + PCIE_RGR1_SW_INIT_1, RGR1_SW_INIT_1_INIT_MASK);
> +	setbits_le32(base + PCIE_RGR1_SW_INIT_1, PCIE_RGR1_SW_INIT_1_INIT_MASK);
>   
>   	return 0;
>   }
