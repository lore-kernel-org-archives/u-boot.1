Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46900C35FF3
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 14:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B35E080F70;
	Mon, 17 Mar 2025 15:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JHFk7rFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6043B810F4; Mon, 17 Mar 2025 15:33:49 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 111CE80F4C
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 15:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so2568581f8f.3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742222025; x=1742826825; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ckJ3lzBHXdzYH7Gl54A6naS8CUMb4EBPv1mer5Fmzs=;
 b=JHFk7rFk6PiMDpoGMcSeWADCsTYeEbhb79IejsdbGp5BHMQO55cbjThFNdpaDfZzss
 GWXq9rG+ipjHHSQZ2t4mClq6ACRNZ+6Z+nGjOACyHrpY6RlqFZQdmY9FH0U9z6FaRj1z
 Dv1T1U4EFEBModVB/nL6BaLd572wPe0HwDMdwfR4nX534sj1XzGhWwtnLF4aAi+jN0Tm
 PH+cvXb7IGMWrjxgJ+d9hqhdw+qWa33TX5rhuDNSvQ9qAFtDrRw0FNrphDoAIMaOLah0
 2Hdk18P+u2X1Z92yTqI16a3VTbQvRRjs/K7R0My/dX/GFK/ggUv0ZPZSEqF1KAOANGn4
 lIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742222025; x=1742826825;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8ckJ3lzBHXdzYH7Gl54A6naS8CUMb4EBPv1mer5Fmzs=;
 b=q1g4u0qLqY/j1tb8q9sSuMZMxM2OEti0YNGJlKY/Gm6q3Ie8dv6+jhOlFYu0qxSpsY
 UbjfAGxDd7aXSrQOh6HCcp3Jxbp1Ty50RCPHnHTIwJicI1iVZLCvGzaIcXhSpxBkYBB9
 Z0Og4v3vTV1b6j2I9r4gGgndfcWp02QEC+ewjfW1KEAddABPaCwWWuCrVD/cXeCAsIz0
 cM5I6Qx9NRM9TSscCc4etgNdEfBCMPql5O34wufqfBZS5+oUOLkJVcQkT4vLkUQw/CJJ
 Tw8cEGmgn/ujotqxn86ShDZlJafYnebl0tIvJnFHLbs4+GsP4LBJvztwMZfJCFcnpdWf
 euiQ==
X-Gm-Message-State: AOJu0YxH8Jd08CNBjWITaxDY/xYlMAbmoJGexEPGeBe20SiX/ZWNDsF8
 eWM7qvNwjO4cCVmn9MdA3Ysgu6MImXvCdF+UuY94UMF+BBtQ+7GexoVYAgZMZus=
X-Gm-Gg: ASbGncuAU5GiXaf5nGe23pdp3P9NPdx/Spxf1qEVKOPKg67eP7KKglFuZan5hnnFPfg
 OM3ZMKZ3ANlp42r2Vf6/S/P5tdg0mEJfJrdtp4jXID9FTLnx+8BRPr9w09xSt2RKxLXSDjx3Z9h
 w4t4I88MK3WjjNgE+EgwhXlBOqA848hiCVbVJ8KinjIh/c66HHo5LH8EKsDHm2jRL6R9iRZmkW1
 6aK9LqAGJqhdrZztiXR8Bfsf8jkEKsdhI4Rdz6KfTtwJ5YNSiW6oPRkNXEQUKkmk2kgIVap/0Q7
 RLfKTgtEvYDHNx3ZxWv1yUeEoAu982yFqH0cimMY6RcVNB+df5DY3fg1MNCVRN9V7HIi36DFyqp
 NDhh8mwgU/K8lY0h7LKlTfgkTPA==
X-Google-Smtp-Source: AGHT+IGHP0hWnFUTgQ6tE/Q+YgyAjld4JXFT74UC3EfV1q0jDhbMKIgF6hpZg+DXm98QPmMaWVh4TQ==
X-Received: by 2002:a5d:5f49:0:b0:390:fb37:1bd with SMTP id
 ffacd0b85a97d-3971f7f8fccmr15046109f8f.46.1742222025191; 
 Mon, 17 Mar 2025 07:33:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9?
 ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ebe4bsm15502531f8f.98.2025.03.17.07.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 07:33:44 -0700 (PDT)
Message-ID: <9e1833dc-ef35-4d96-9e4a-9714b6630ff7@linaro.org>
Date: Mon, 17 Mar 2025 14:33:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] misc: introduce Qcom GENI wrapper
To: neil.armstrong@linaro.org, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250314-geni-load-fw-v1-0-587f25f2812f@linaro.org>
 <20250314-geni-load-fw-v1-2-587f25f2812f@linaro.org>
 <1e8f7d84-d6a9-44df-ab28-afe8c6ef00fc@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <1e8f7d84-d6a9-44df-ab28-afe8c6ef00fc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 3/17/25 14:12, Neil Armstrong wrote:
> On 14/03/2025 17:09, Caleb Connolly wrote:
>> Qualcomm peripherals like UART, SPI, I2C, etc are all exposed under a
>> common GENI Serial Engine wrapper device. Replace the stub driver we use
>> for this currently with a full-on misc device and implement support for
>> loading peripheral firmware.
>>
>> Each of the peripherals has it's own protocol-specific firmware, this is
>> stored on the internal storage of the device with a well-known partition
>> type GUID.
>>
>> To support this, GENI will bind peripherals in two stages. First the
>> ones that already have firmware loaded (such as the serial port) are
>> bound in the typical way. But devices that require firmware loading are
>> deferred until EVT_LAST_STAGE_INIT. At this point we can be sure that
>> the storage device is available, so we load the firmware and then bind
>> and probe the remaining children.
>>
>> Child devices are expected to determine if firmware loading is necessary
>> and call qcom_geni_load_firmware().
>>
>> Since Linux currently doesn't support loading firmware (and firmware may
>> not be available), we probe all GENI peripherals to ensure that they
>> always load firmwaree if necessary.
> -------------/\ firmwares
> 
> Hmm binding all QUP serial engines seems quite brutal, and this is really
> only needed when fws are not loaded by previous bootloader.

In the best-case where no firmware loading is needed this should behave 
almost the same as before, except for reading the GENI_FW_REVISION_RO 
register for each (enabled) SE, so I don't think it's too bad.

I do wonder if there's a case where reading GENI_FW_REVISION_RO would 
fail due to missing resources (like if GCC_QUPV3_WRAP_0_M_AHB_CLK is 
disabled). But testing with the AHB clocks off doesn't seem to cause any 
issues, so I guess it's fine??

> 
> Apart this, the design looks good :-)
> 
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   arch/arm/Kconfig                 |   1 +
>>   drivers/misc/Kconfig             |   9 +
>>   drivers/misc/Makefile            |   1 +
>>   drivers/misc/qcom_geni.c         | 576 +++++++++++++++++++++++++++++ 
>> ++++++++++
>>   drivers/serial/serial_msm_geni.c |  13 -
>>   include/soc/qcom/geni-se.h       |  36 +++
>>   include/soc/qcom/qup-fw-load.h   | 178 ++++++++++++
>>   7 files changed, 801 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 
>> cf08fe63f1e7dc73480b2ba0b707a7e891073d53..6149f284596641689407e076af5ad020176bd7dc 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1116,8 +1116,9 @@ config ARCH_SNAPDRAGON
>>       select BOARD_LATE_INIT
>>       select OF_BOARD
>>       select SAVE_PREV_BL_FDT_ADDR
>>       select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
>> +    select QCOM_GENI
>>       imply OF_UPSTREAM
>>       imply CMD_DM
>>   config ARCH_SOCFPGA
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 
>> da84b35e8043bcef71ce78e03d1da2c445bf3af5..415832c73e2cb5a85ae8378977d597e5aedb5fb8 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -82,8 +82,17 @@ config GATEWORKS_SC
>>         Enable access for the Gateworks System Controller used on 
>> Gateworks
>>         boards to provide a boot watchdog, power control, temperature 
>> monitor,
>>         voltage ADCs, and EEPROM.
>> +config QCOM_GENI
>> +    bool "Qualcomm Generic Interface (GENI) driver"
>> +    depends on MISC
>> +    select PARTITION_TYPE_GUID
>> +    help
>> +      Enable support for Qualcomm GENI and it's peripherals. GENI is 
>> responseible
> 
> -------------------------------------------------------------------------/\ responsible
> 
>> +      for providing a common interface for various peripherals like 
>> UART, I2C, SPI,
>> +      etc.
>> +
>>   config ROCKCHIP_EFUSE
>>           bool "Rockchip e-fuse support"
>>       depends on MISC
>>       help
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index 
>> dac805e4cdd48a8127f37d68d9fb5ba0bd17ab15..6866edbd8119268c0cc03abdc8529bd191f1c2d8 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -67,8 +67,9 @@ obj-$(CONFIG_QFW_PIO) += qfw_pio.o
>>   obj-$(CONFIG_QFW_MMIO) += qfw_mmio.o
>>   obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
>>   obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
>>   endif
>> +obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
>>   obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
>>   obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
>>   obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
>>   obj-$(CONFIG_SANDBOX) += syscon_sandbox.o misc_sandbox.o
>> diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..2b652765aa310b5a21d4aa99b50842c2e17e5942
>> --- /dev/null
>> +++ b/drivers/misc/qcom_geni.c
>> @@ -0,0 +1,576 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + * Copyright (c) 2025, Linaro Ltd.
>> + */
>> +
>> +#include <blk.h>
>> +#include <part.h>
>> +#include <dm/device.h>
>> +#include <dm/read.h>
>> +#include <dm/device-internal.h>
>> +#include <dm/lists.h>
>> +#include <elf.h>
>> +#include <linux/bitops.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/ioport.h>
>> +#include <misc.h>
>> +#include <linux/printk.h>
>> +#include <soc/qcom/geni-se.h>
>> +#include <soc/qcom/qup-fw-load.h>
>> +#include <dm/device_compat.h>
>> +
>> +struct qup_se_rsc {
>> +    phys_addr_t base;
>> +    phys_addr_t wrapper_base;
>> +    struct udevice *dev;
>> +
>> +    enum geni_se_xfer_mode mode;
>> +    enum geni_se_protocol_type protocol;
>> +};
>> +
>> +struct geni_se_plat {
>> +    bool need_firmware_load;
>> +};
>> +
>> +/**
>> + * geni_enable_interrupts() Enable interrupts.
>> + * @rsc: Pointer to a structure representing SE-related resources.
>> + *
>> + * Enable the required interrupts during the firmware load process.
>> + *
>> + * Return: None.
>> + */
>> +static void geni_enable_interrupts(struct qup_se_rsc *rsc)
>> +{
>> +    u32 reg_value;
>> +
>> +    /* Enable required interrupts. */
>> +    writel_relaxed(M_COMMON_GENI_M_IRQ_EN, rsc->base + 
>> GENI_M_IRQ_ENABLE);
>> +
>> +    reg_value = S_CMD_OVERRUN_EN | S_ILLEGAL_CMD_EN |
>> +                S_CMD_CANCEL_EN | S_CMD_ABORT_EN |
>> +                S_GP_IRQ_0_EN | S_GP_IRQ_1_EN |
>> +                S_GP_IRQ_2_EN | S_GP_IRQ_3_EN |
>> +                S_RX_FIFO_WR_ERR_EN | S_RX_FIFO_RD_ERR_EN;
>> +    writel_relaxed(reg_value, rsc->base + GENI_S_IRQ_ENABLE);
>> +
>> +    /* DMA mode configuration. */
>> +    reg_value = DMA_TX_IRQ_EN_SET_RESET_DONE_EN_SET_BMSK |
>> +            DMA_TX_IRQ_EN_SET_SBE_EN_SET_BMSK |
>> +            DMA_TX_IRQ_EN_SET_DMA_DONE_EN_SET_BMSK;
>> +    writel_relaxed(reg_value, rsc->base + DMA_TX_IRQ_EN_SET);
>> +    reg_value = DMA_RX_IRQ_EN_SET_FLUSH_DONE_EN_SET_BMSK |
>> +            DMA_RX_IRQ_EN_SET_RESET_DONE_EN_SET_BMSK |
>> +            DMA_RX_IRQ_EN_SET_SBE_EN_SET_BMSK |
>> +            DMA_RX_IRQ_EN_SET_DMA_DONE_EN_SET_BMSK;
>> +    writel_relaxed(reg_value, rsc->base + DMA_RX_IRQ_EN_SET);
>> +}
>> +
>> +/**
>> + * geni_flash_fw_revision() - Flash the firmware revision.
>> + * @rsc: Pointer to a structure representing SE-related resources.
>> + * @hdr: Pointer to the ELF header of the Serial Engine.
>> + *
>> + * Flash the firmware revision and protocol into the respective 
>> register.
>> + *
>> + * Return: None.
>> + */
>> +static void geni_flash_fw_revision(struct qup_se_rsc *rsc, struct 
>> elf_se_hdr *hdr)
>> +{
>> +    u32 reg_value;
>> +
>> +    /* Flash firmware revision register. */
>> +    reg_value = (hdr->serial_protocol << FW_REV_PROTOCOL_SHFT) |
>> +            (hdr->fw_version & 0xFF << FW_REV_VERSION_SHFT);
>> +    writel_relaxed(reg_value, rsc->base + SE_GENI_FW_REVISION);
>> +
>> +    reg_value = (hdr->serial_protocol << FW_REV_PROTOCOL_SHFT) |
>> +            (hdr->fw_version & 0xFF << FW_REV_VERSION_SHFT);
>> +
>> +    writel_relaxed(reg_value, rsc->base + SE_S_FW_REVISION);
>> +}
>> +
>> +/**
>> + * geni_configure_xfer_mode() - Set the transfer mode.
>> + * @rsc: Pointer to a structure representing SE-related resources.
>> + *
>> + * Set the transfer mode to either FIFO or DMA according to the mode 
>> specified by the protocol
>> + * driver.
>> + *
>> + * Return: 0 if successful, otherwise return an error value.
>> + */
>> +static int geni_configure_xfer_mode(struct qup_se_rsc *rsc)
>> +{
>> +    /* Configure SE FIFO, DMA or GSI mode. */
>> +    switch (rsc->mode) {
>> +    case GENI_GPI_DMA:
>> +        geni_setbits32(rsc->base + QUPV3_SE_GENI_DMA_MODE_EN,
>> +                   GENI_DMA_MODE_EN_GENI_DMA_MODE_EN_BMSK);
>> +        writel_relaxed(0x0, rsc->base + SE_IRQ_EN);
>> +        writel_relaxed(SE_GSI_EVENT_EN_BMSK, rsc->base + 
>> SE_GSI_EVENT_EN);
>> +        break;
>> +
>> +    case GENI_SE_FIFO:
>> +        geni_clrbits32(rsc->base + QUPV3_SE_GENI_DMA_MODE_EN,
>> +                   GENI_DMA_MODE_EN_GENI_DMA_MODE_EN_BMSK);
>> +        writel_relaxed(SE_IRQ_EN_RMSK, rsc->base + SE_IRQ_EN);
>> +        writel_relaxed(0x0, rsc->base + SE_GSI_EVENT_EN);
>> +        break;
>> +
>> +    case GENI_SE_DMA:
>> +        geni_setbits32(rsc->base + QUPV3_SE_GENI_DMA_MODE_EN,
>> +                   GENI_DMA_MODE_EN_GENI_DMA_MODE_EN_BMSK);
>> +        writel_relaxed(SE_IRQ_EN_RMSK, rsc->base + SE_IRQ_EN);
>> +        writel_relaxed(0x0, rsc->base + SE_GSI_EVENT_EN);
>> +        break;
>> +
>> +    default:
>> +        dev_err(rsc->dev, "invalid se mode: %d\n", rsc->mode);
>> +        return -EINVAL;
>> +    }
>> +    return 0;
>> +}
>> +
>> +/**
>> + * geni_config_common_control() - Configure common CGC and disable 
>> high priority interrupt.
>> + * @rsc: Pointer to a structure representing SE-related resources.
>> + *
>> + * Configure the common CGC and disable high priority interrupts 
>> until the current low priority
>> + * interrupts are handled.
>> + *
>> + * Return: None.
>> + */
>> +static void geni_config_common_control(struct qup_se_rsc *rsc)
>> +{
>> +    /*
>> +     * Disable high priority interrupt until current low priority 
>> interrupts are handled.
>> +     */
>> +    geni_setbits32(rsc->wrapper_base + QUPV3_COMMON_CFG,
>> +               FAST_SWITCH_TO_HIGH_DISABLE_BMASK);
>> +
>> +    /*
>> +     * Set AHB_M_CLK_CGC_ON to indicate hardware controls se-wrapper 
>> cgc clock.
>> +     */
>> +    geni_setbits32(rsc->wrapper_base + QUPV3_SE_AHB_M_CFG,
>> +               AHB_M_CLK_CGC_ON_BMASK);
>> +
>> +    /* Let hardware to control common cgc. */
>> +    geni_setbits32(rsc->wrapper_base + QUPV3_COMMON_CGC_CTRL,
>> +               COMMON_CSR_SLV_CLK_CGC_ON_BMASK);
>> +}
>> +
>> +static int load_se_firmware(struct qup_se_rsc *rsc, struct elf_se_hdr 
>> *hdr)
>> +{
>> +    const u32 *fw_val_arr, *cfg_val_arr;
>> +    const u8 *cfg_idx_arr;
>> +    u32 i, reg_value, mask, ramn_cnt;
>> +    int ret;
>> +
>> +    fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
>> +    cfg_idx_arr = (const u8 *)hdr + hdr->cfg_idx_offset;
>> +    cfg_val_arr = (const u32 *)((u8 *)hdr + hdr->cfg_val_offset);
>> +
>> +    geni_config_common_control(rsc);
>> +
>> +    /* Allows to drive corresponding data according to hardware 
>> value. */
>> +    writel_relaxed(0x0, rsc->base + GENI_OUTPUT_CTRL);
>> +
>> +    /* Set SCLK and HCLK to program RAM */
>> +    geni_setbits32(rsc->base + GENI_CGC_CTRL, 
>> GENI_CGC_CTRL_PROG_RAM_SCLK_OFF_BMSK |
>> +               GENI_CGC_CTRL_PROG_RAM_HCLK_OFF_BMSK);
>> +    writel_relaxed(0x0, rsc->base + SE_GENI_CLK_CTRL);
>> +    geni_clrbits32(rsc->base + GENI_CGC_CTRL, 
>> GENI_CGC_CTRL_PROG_RAM_SCLK_OFF_BMSK |
>> +               GENI_CGC_CTRL_PROG_RAM_HCLK_OFF_BMSK);
>> +
>> +    /* Enable required clocks for DMA CSR, TX and RX. */
>> +    reg_value = DMA_GENERAL_CFG_AHB_SEC_SLV_CLK_CGC_ON_BMSK |
>> +        DMA_GENERAL_CFG_DMA_AHB_SLV_CLK_CGC_ON_BMSK |
>> +        DMA_GENERAL_CFG_DMA_TX_CLK_CGC_ON_BMSK |
>> +        DMA_GENERAL_CFG_DMA_RX_CLK_CGC_ON_BMSK;
>> +
>> +    geni_setbits32(rsc->base + DMA_GENERAL_CFG, reg_value);
>> +
>> +    /* Let hardware control CGC by default. */
>> +    writel_relaxed(DEFAULT_CGC_EN, rsc->base + GENI_CGC_CTRL);
>> +
>> +    /* Set version of the configuration register part of firmware. */
>> +    writel_relaxed(hdr->cfg_version, rsc->base + 
>> GENI_INIT_CFG_REVISION);
>> +    writel_relaxed(hdr->cfg_version, rsc->base + 
>> GENI_S_INIT_CFG_REVISION);
>> +
>> +    /* Configure GENI primitive table. */
>> +    for (i = 0; i < hdr->cfg_size_in_items; i++)
>> +        writel_relaxed(cfg_val_arr[i],
>> +                   rsc->base + GENI_CFG_REG0 + (cfg_idx_arr[i] * 
>> sizeof(u32)));
>> +
>> +    /* Configure condition for assertion of RX_RFR_WATERMARK 
>> condition. */
>> +    reg_value = readl_relaxed(rsc->base + QUPV3_SE_HW_PARAM_1);
>> +    mask = (reg_value >> RX_FIFO_WIDTH_BIT) & RX_FIFO_WIDTH_MASK;
>> +    writel_relaxed(mask - 2, rsc->base + GENI_RX_RFR_WATERMARK_REG);
>> +
>> +    /* Let hardware control CGC */
>> +    geni_setbits32(rsc->base + GENI_OUTPUT_CTRL, 
>> DEFAULT_IO_OUTPUT_CTRL_MSK);
>> +
>> +    ret = geni_configure_xfer_mode(rsc);
>> +    if (ret) {
>> +        dev_err(rsc->dev, "failed to configure xfer mode: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    geni_enable_interrupts(rsc);
>> +
>> +    geni_flash_fw_revision(rsc, hdr);
>> +
>> +    ramn_cnt = hdr->fw_size_in_items;
>> +    if (hdr->fw_size_in_items % 2 != 0)
>> +        ramn_cnt++;
>> +
>> +    if (ramn_cnt >= MAX_GENI_CFG_RAMn_CNT) {
>> +        dev_err(rsc->dev, "firmware size is too large\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* Program RAM address space. */
>> +    for (i = 0; i < hdr->fw_size_in_items; i++)
>> +        writel_relaxed(fw_val_arr[i], rsc->base + SE_GENI_CFG_RAMN + 
>> i * sizeof(u32));
>> +
>> +    /* Put default values on GENI's output pads. */
>> +    writel_relaxed(0x1, rsc->base + GENI_FORCE_DEFAULT_REG);
>> +
>> +    /* High to low SCLK and HCLK to finish RAM. */
>> +    geni_setbits32(rsc->base + GENI_CGC_CTRL, 
>> GENI_CGC_CTRL_PROG_RAM_SCLK_OFF_BMSK |
>> +            GENI_CGC_CTRL_PROG_RAM_HCLK_OFF_BMSK);
>> +    geni_setbits32(rsc->base + SE_GENI_CLK_CTRL, 
>> GENI_CLK_CTRL_SER_CLK_SEL_BMSK);
>> +    geni_clrbits32(rsc->base + GENI_CGC_CTRL, 
>> GENI_CGC_CTRL_PROG_RAM_SCLK_OFF_BMSK |
>> +            GENI_CGC_CTRL_PROG_RAM_HCLK_OFF_BMSK);
>> +
>> +    /* Serial engine DMA interface is enabled. */
>> +    geni_setbits32(rsc->base + SE_DMA_IF_EN, DMA_IF_EN_DMA_IF_EN_BMSK);
>> +
>> +    /* Enable or disable FIFO interface of the serial engine. */
>> +    if (rsc->mode == GENI_SE_FIFO)
>> +        geni_clrbits32(rsc->base + SE_FIFO_IF_DISABLE, FIFO_IF_DISABLE);
>> +    else
>> +        geni_setbits32(rsc->base + SE_FIFO_IF_DISABLE, FIFO_IF_DISABLE);
>> +
>> +    return 0;
>> +}
>> +
>> +/**
>> + * elf_phdr_valid() - Validate an ELF header.
>> + * @phdr: Pointer to the ELF header.
>> + *
>> + * Validate the ELF header by comparing the fields stored in p_flags 
>> and the payload type.
>> + *
>> + * Return: true if the validation is successful, false otherwise.
>> + */
>> +static bool elf_phdr_valid(const Elf32_Phdr *phdr)
>> +{
>> +    if (phdr->p_type != PT_LOAD || !phdr->p_memsz)
>> +        return false;
>> +
>> +    if (MI_PBT_PAGE_MODE_VALUE(phdr->p_flags) == 
>> MI_PBT_NON_PAGED_SEGMENT &&
>> +        MI_PBT_SEGMENT_TYPE_VALUE(phdr->p_flags) != 
>> MI_PBT_HASH_SEGMENT &&
>> +        MI_PBT_ACCESS_TYPE_VALUE(phdr->p_flags) != 
>> MI_PBT_NOTUSED_SEGMENT &&
>> +        MI_PBT_ACCESS_TYPE_VALUE(phdr->p_flags) != 
>> MI_PBT_SHARED_SEGMENT)
>> +        return true;
>> +
>> +    return false;
>> +}
>> +
>> +/**
>> + * valid_seg_size() - Validate the segment size.
>> + * @pelfseg: Pointer to the ELF header.
>> + * @p_filesz: Pointer to the file size.
>> + *
>> + * Validate the ELF segment size by comparing the file size.
>> + *
>> + * Return: true if the segment is valid, false if the segment is 
>> invalid.
>> + */
>> +static bool valid_seg_size(struct elf_se_hdr *pelfseg, Elf32_Word 
>> p_filesz)
>> +{
>> +    if (p_filesz >= pelfseg->fw_offset + pelfseg->fw_size_in_items * 
>> sizeof(u32) &&
>> +        p_filesz >= pelfseg->cfg_idx_offset + pelfseg- 
>> >cfg_size_in_items * sizeof(u8) &&
>> +        p_filesz >= pelfseg->cfg_val_offset + pelfseg- 
>> >cfg_size_in_items * sizeof(u32))
>> +        return true;
>> +    return false;
>> +}
>> +
>> +/**
>> + * read_elf() - Read an ELF file.
>> + * @rsc: Pointer to the SE resources structure.
>> + * @fw: Pointer to the firmware buffer.
>> + * @pelfseg: Pointer to the SE-specific ELF header.
>> + * @phdr: Pointer to one of the valid headers from the list in the 
>> firmware buffer.
>> + *
>> + * Read the ELF file and output a pointer to the header data, which 
>> contains the firmware data and
>> + * any other details.
>> + *
>> + * Return: 0 if successful, otherwise return an error value.
>> + */
>> +static int read_elf(struct qup_se_rsc *rsc, const void *fw,
>> +            struct elf_se_hdr **pelfseg)
>> +{
>> +    Elf32_Phdr *phdr;
>> +    const Elf32_Ehdr *ehdr = (const Elf32_Ehdr *)fw;
>> +    Elf32_Phdr *phdrs = (Elf32_Phdr *)(ehdr + 1);
>> +    const u8 *addr;
>> +    int i;
>> +
>> +    ehdr = (Elf32_Ehdr *)fw;
>> +
>> +    if (ehdr->e_phnum < 2)
>> +        return -EINVAL;
>> +
>> +    for (i = 0; i < ehdr->e_phnum; i++) {
>> +        phdr = &phdrs[i];
>> +        if (!elf_phdr_valid(phdr))
>> +            continue;
>> +
>> +        if (phdr->p_filesz >= sizeof(struct elf_se_hdr)) {
>> +            addr =  fw + phdr->p_offset;
>> +            *pelfseg = (struct elf_se_hdr *)addr;
>> +
>> +            if ((*pelfseg)->magic == MAGIC_NUM_SE &&
>> +                (*pelfseg)->version == 1 &&
>> +                valid_seg_size(*pelfseg, phdr->p_filesz) &&
>> +                (*pelfseg)->serial_protocol == rsc->protocol &&
>> +                (*pelfseg)->serial_protocol != GENI_SE_NONE)
>> +                return 0;
>> +        }
>> +    }
>> +    return -EINVAL;
>> +}
>> +
>> +int qcom_geni_load_firmware(phys_addr_t qup_base,
>> +                struct udevice *dev)
>> +{
>> +    struct qup_se_rsc rsc;
>> +    struct elf_se_hdr *hdr;
>> +    int ret;
>> +    void *fw;
>> +
>> +    rsc.dev = dev;
>> +    rsc.base = qup_base;
>> +    rsc.wrapper_base = dev_read_addr(dev->parent);
>> +
>> +    /* FIXME: GSI DMA mode if device has property qcom,gsi-dma- 
>> allowed */
>> +    rsc.mode = GENI_SE_FIFO;
>> +
>> +    switch (device_get_uclass_id(dev)) {
>> +    case UCLASS_I2C:
>> +        rsc.protocol = GENI_SE_I2C;
>> +        break;
>> +    case UCLASS_SPI:
>> +        rsc.protocol = GENI_SE_SPI;
>> +        break;
>> +    case UCLASS_SERIAL:
>> +        rsc.protocol = GENI_SE_UART;
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* The firmware blob is the private data of the GENI wrapper 
>> (parent) */
>> +    fw = dev_get_priv(dev->parent);
>> +
>> +    ret = read_elf(&rsc, fw, &hdr);
>> +    if (ret) {
>> +        dev_err(dev, "Failed to read ELF: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    printf("Loading firmware for %s\n", dev->name);
>> +
>> +    return load_se_firmware(&rsc, hdr);
>> +}
>> +
>> +/*
>> + * We need to determine if firmware loading is necessary. Best way to 
>> do that is to check the FW
>> + * revision of each QUP and see if it has already been loaded.
>> + */
>> +static int geni_se_of_to_plat(struct udevice *dev)
>> +{
>> +    ofnode child;
>> +    struct resource res;
>> +    u32 proto;
>> +    struct geni_se_plat *plat = dev_get_plat(dev);
>> +
>> +    plat->need_firmware_load = false;
>> +
>> +    dev_for_each_subnode(child, dev) {
>> +        if (!ofnode_is_enabled(child))
>> +            continue;
>> +
>> +        if (ofnode_read_resource(child, 0, &res))
>> +            continue;
>> +
>> +        proto = readl(res.start + GENI_FW_REVISION_RO);
>> +        proto &= FW_REV_PROTOCOL_MSK;
>> +        proto >>= FW_REV_PROTOCOL_SHFT;
>> +
>> +        if (proto == GENI_SE_INVALID_PROTO) {
>> +            plat->need_firmware_load = true;
>> +        } else {
>> +            /* Bind any devices that don't need firmware loading now. */
>> +            lists_bind_fdt(dev, child, NULL, NULL, false);
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +#define QUPFW_PART_TYPE_GUID "21d1219f-2ed1-4ab4-930a-41a16ae75f7f"
>> +
>> +static int find_qupfw_part(struct udevice **blk_dev, struct 
>> disk_partition *part_info)
>> +{
>> +    struct blk_desc *desc;
>> +    int ret, partnum;
>> +
>> +    uclass_foreach_dev_probe(UCLASS_BLK, *blk_dev) {
>> +        if (device_get_uclass_id(*blk_dev) != UCLASS_BLK)
>> +            continue;
>> +
>> +        desc = dev_get_uclass_plat(*blk_dev);
>> +        if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
>> +            continue;
>> +        for (partnum = 1;; partnum++) {
>> +            ret = part_get_info(desc, partnum, part_info);
>> +            if (ret)
>> +                break;
>> +            if (!strcmp(part_info->type_guid, QUPFW_PART_TYPE_GUID))
>> +                return 0;
>> +        }
>> +    }
>> +
>> +    return -ENOENT;
>> +}
>> +
>> +static int probe_children_load_firmware(struct udevice *dev)
>> +{
>> +    struct geni_se_plat *plat;
>> +    ofnode child;
>> +    struct udevice *child_dev;
>> +    struct resource res;
>> +    u32 proto;
>> +
>> +    plat = dev_get_plat(dev);
>> +
>> +    dev_for_each_subnode(child, dev) {
>> +        if (!ofnode_is_enabled(child))
>> +            continue;
>> +
>> +        if (ofnode_read_resource(child, 0, &res))
>> +            continue;
>> +
>> +        proto = readl(res.start + GENI_FW_REVISION_RO);
>> +        proto &= FW_REV_PROTOCOL_MSK;
>> +        proto >>= FW_REV_PROTOCOL_SHFT;
>> +
>> +        if (proto != GENI_SE_INVALID_PROTO)
>> +            continue;
>> +
>> +        /*
>> +         * Now we're ready, bind and probe the child, this will 
>> trigger firmware loading.
>> +         */
>> +        lists_bind_fdt(dev, child, &child_dev, NULL, false);
>> +        debug("Probing child %s for fw loading\n", child_dev->name);
>> +        device_probe(child_dev);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +#define MAX_FW_BUF_SIZE (128 * 1024)
>> +
>> +/*
>> + * Load firmware for QCOM GENI peripherals from the dedicated 
>> partition on storage and bind/probe
>> + * all the peripheral devices that need firmware to be loaded.
>> + */
>> +static int qcom_geni_fw_initialise(void)
>> +{
>> +    debug("Loading firmware for QCOM GENI SE\n");
>> +    struct udevice *geni_wrapper, *blk_dev;
>> +    struct disk_partition part_info;
>> +    int ret;
>> +    void *fw_buf;
>> +    size_t fw_size = MAX_FW_BUF_SIZE;
>> +    struct geni_se_plat *plat;
>> +
>> +    /* Find the first GENI SE wrapper that needs fw loading */
>> +    for (uclass_first_device(UCLASS_MISC, &geni_wrapper);
>> +         geni_wrapper;
>> +         uclass_next_device(&geni_wrapper)) {
>> +        if (device_get_uclass_id(geni_wrapper) == UCLASS_MISC &&
>> +            !strcmp(geni_wrapper->driver->name, "geni-se-qup")) {
>> +            plat = dev_get_plat(geni_wrapper);
>> +            if (plat->need_firmware_load)
>> +                break;
>> +        }
>> +    }
>> +    if (!geni_wrapper) {
>> +        printf("GENI SE wrapper not found\n");
>> +        return 0;
>> +    }
>> +
>> +    ret = find_qupfw_part(&blk_dev, &part_info);
>> +    if (ret) {
>> +        printf("QUP firmware partition not found\n");
>> +        return 0;
>> +    }
>> +
>> +    if (part_info.size * part_info.blksz > MAX_FW_BUF_SIZE) {
>> +        printf("Firmware partition too large\n");
>> +        return -EINVAL;
>> +    }
>> +    fw_size = part_info.size * part_info.blksz;
>> +
>> +    fw_buf = malloc(fw_size);
>> +    if (!fw_buf) {
>> +        printf("Failed to allocate buffer for firmware\n");
>> +        return -ENOMEM;
>> +    }
>> +    memset(fw_buf, 0, fw_size);
>> +
>> +    ret = blk_read(blk_dev, part_info.start, part_info.size, fw_buf);
>> +    if (ret < 0) {
>> +        printf("Failed to read firmware from partition\n");
>> +        free(fw_buf);
>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * OK! Firmware is loaded, now bind and probe remaining children. 
>> They will attempt to load
>> +     * firmware during probe. Do this for each GENI SE wrapper that 
>> needs firmware loading.
>> +     */
>> +    for (; geni_wrapper;
>> +         uclass_next_device(&geni_wrapper)) {
>> +        if (device_get_uclass_id(geni_wrapper) == UCLASS_MISC &&
>> +            !strcmp(geni_wrapper->driver->name, "geni-se-qup")) {
>> +            plat = dev_get_plat(geni_wrapper);
>> +            if (plat->need_firmware_load) {
>> +                dev_set_priv(geni_wrapper, fw_buf);
>> +                probe_children_load_firmware(geni_wrapper);
>> +            }
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, qcom_geni_fw_initialise);
>> +
>> +static const struct udevice_id geni_ids[] = {
>> +    { .compatible = "qcom,geni-se-qup" },
>> +    {}
>> +};
>> +
>> +U_BOOT_DRIVER(sifive_otp) = {
> 
> Bad copy paste !
> 
>> +    .name = "geni-se-qup",
>> +    .id = UCLASS_MISC,
>> +    .of_match = geni_ids,
>> +    .of_to_plat = geni_se_of_to_plat,
>> +    .plat_auto = sizeof(struct geni_se_plat),
>> +    .flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
>> +};
>> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/ 
>> serial_msm_geni.c
>> index 
>> cb6c09fdd09eecdcbdc7a9f6b53ce14e97a1919b..44603ead77cd9f7948a2bf52ebddfebbfeb9f1c2 100644
>> --- a/drivers/serial/serial_msm_geni.c
>> +++ b/drivers/serial/serial_msm_geni.c
>> @@ -604,21 +604,8 @@ U_BOOT_DRIVER(serial_msm_geni) = {
>>       .ops = &msm_serial_ops,
>>       .flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
>>   };
>> -static const struct udevice_id geniqup_ids[] = {
>> -    { .compatible = "qcom,geni-se-qup" },
>> -    { }
>> -};
>> -
>> -U_BOOT_DRIVER(geni_se_qup) = {
>> -    .name = "geni-se-qup",
>> -    .id = UCLASS_NOP,
>> -    .of_match = geniqup_ids,
>> -    .bind = dm_scan_fdt_dev,
>> -    .flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
>> -};
>> -
>>   #ifdef CONFIG_DEBUG_UART_MSM_GENI
>>   static struct msm_serial_data init_serial_data = {
>>       .base = CONFIG_VAL(DEBUG_UART_BASE)
>> diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
>> index 
>> 698a9256d2656d3fd207cb48a9f4918afc365a1b..fc9a8e82cd88a63cd50dcfb0647fa28b53adad37 100644
>> --- a/include/soc/qcom/geni-se.h
>> +++ b/include/soc/qcom/geni-se.h
>> @@ -5,16 +5,24 @@
>>   #ifndef _QCOM_GENI_SE
>>   #define _QCOM_GENI_SE
>> +enum geni_se_xfer_mode {
>> +    GENI_SE_INVALID,
>> +    GENI_SE_FIFO,
>> +    GENI_SE_DMA,
>> +    GENI_GPI_DMA,
>> +};
>> +
>>   /* Protocols supported by GENI Serial Engines */
>>   enum geni_se_protocol_type {
>>       GENI_SE_NONE,
>>       GENI_SE_SPI,
>>       GENI_SE_UART,
>>       GENI_SE_I2C,
>>       GENI_SE_I3C,
>>       GENI_SE_SPI_SLAVE,
>> +    GENI_SE_INVALID_PROTO = 255,
>>   };
>>   #define QUP_HW_VER_REG            0x4
>> @@ -28,8 +36,9 @@ enum geni_se_protocol_type {
>>   #define GENI_SER_M_CLK_CFG        0x48
>>   #define GENI_SER_S_CLK_CFG        0x4c
>>   #define GENI_IF_DISABLE_RO        0x64
>>   #define GENI_FW_REVISION_RO        0x68
>> +#define GENI_DFS_IF_CFG            0x80
>>   #define SE_GENI_CLK_SEL            0x7c
>>   #define SE_GENI_CFG_SEQ_START        0x84
>>   #define SE_GENI_BYTE_GRAN        0x254
>>   #define SE_GENI_DMA_MODE_EN        0x258
>> @@ -56,17 +65,26 @@ enum geni_se_protocol_type {
>>   #define SE_GENI_RX_RFR_WATERMARK_REG    0x814
>>   #define SE_GENI_IOS            0x908
>>   #define SE_DMA_TX_IRQ_STAT        0xc40
>>   #define SE_DMA_TX_IRQ_CLR        0xc44
>> +#define SE_DMA_TX_IRQ_EN_SET        0xc4c
>>   #define SE_DMA_TX_FSM_RST        0xc58
>>   #define SE_DMA_RX_IRQ_STAT        0xd40
>>   #define SE_DMA_RX_IRQ_CLR        0xd44
>> +#define SE_DMA_RX_IRQ_EN_SET        0xd4c
>>   #define SE_DMA_RX_LEN_IN        0xd54
>>   #define SE_DMA_RX_FSM_RST        0xd58
>>   #define SE_GSI_EVENT_EN            0xe18
>>   #define SE_IRQ_EN            0xe1c
>>   #define SE_HW_PARAM_0            0xe24
>>   #define SE_HW_PARAM_1            0xe28
>> +#define SE_DMA_GENERAL_CFG        0xe30
>> +
>> +/* GENI_DFS_IF_CFG fields */
>> +#define DFS_IF_EN BIT(0)
>> +
>> +/* SE_DMA_RX_IRQ_EN_SET fields */
>> +#define RESET_DONE_EN_SET BIT(3)
>>   /* GENI_FORCE_DEFAULT_REG fields */
>>   #define FORCE_DEFAULT    BIT(0)
>> @@ -261,5 +279,23 @@ enum geni_se_protocol_type {
>>   /* QUP SE VERSION value for major number 2 and minor number 5 */
>>   #define QUP_SE_VERSION_2_5                  0x20050000
>> +/* SE_DMA_GENERAL_CFG */
>> +#define DMA_RX_CLK_CGC_ON        BIT(0)
>> +#define DMA_TX_CLK_CGC_ON        BIT(1)
>> +#define DMA_AHB_SLV_CFG_ON        BIT(2)
>> +#define AHB_SEC_SLV_CLK_CGC_ON        BIT(3)
>> +#define DUMMY_RX_NON_BUFFERABLE        BIT(4)
>> +#define RX_DMA_ZERO_PADDING_EN        BIT(5)
>> +#define RX_DMA_IRQ_DELAY_MSK        GENMASK(8, 6)
>> +#define RX_DMA_IRQ_DELAY_SHFT        6
>> +
>> +#define GENI_SE_DMA_DONE_EN    BIT(0)
>> +#define GENI_SE_DMA_EOT_EN    BIT(1)
>> +#define GENI_SE_DMA_AHB_ERR_EN    BIT(2)
>> +
>> +#define GENI_SE_DMA_EOT_BUF    BIT(0)
>> +
>> +#define GENI_DMA_MODE_EN    BIT(0)
>> +
>>   #endif
>> diff --git a/include/soc/qcom/qup-fw-load.h b/include/soc/qcom/qup-fw- 
>> load.h
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..a67a93c72a4b705eff5bd29b185a4172c19ae1d7
>> --- /dev/null
>> +++ b/include/soc/qcom/qup-fw-load.h
>> @@ -0,0 +1,178 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +#ifndef _LINUX_QCOM_QUP_FW_LOAD
>> +#define _LINUX_QCOM_QUP_FW_LOAD
>> +
>> +#include <linux/kernel.h>
>> +
>> +/*Magic numbers*/
>> +#define MAGIC_NUM_SE            0x57464553
>> +
>> +/* Common SE registers*/
>> +#define GENI_INIT_CFG_REVISION        0x0
>> +#define GENI_S_INIT_CFG_REVISION    0x4
>> +#define GENI_FORCE_DEFAULT_REG        0x20
>> +#define GENI_CGC_CTRL            0x28
>> +#define GENI_CFG_REG0            0x100
>> +
>> +#define QUPV3_SE_HW_PARAM_1        0xE28
>> +#define RX_FIFO_WIDTH_BIT        24
>> +#define RX_FIFO_WIDTH_MASK        0x3F
>> +
>> +/*Same registers as GENI_DMA_MODE_EN*/
>> +#define QUPV3_SE_GENI_DMA_MODE_EN    0x258
>> +#define GENI_M_IRQ_ENABLE        0x614
>> +#define GENI_S_IRQ_ENABLE        0x644
>> +#define GENI_RX_RFR_WATERMARK_REG    0x814
>> +#define DMA_TX_IRQ_EN_SET        0xC4C
>> +#define DMA_RX_IRQ_EN_SET        0xD4C
>> +#define DMA_GENERAL_CFG            0xE30
>> +#define SE_GENI_FW_REVISION        0x1000
>> +#define SE_S_FW_REVISION        0x1004
>> +#define SE_GENI_CFG_RAMN        0x1010
>> +#define SE_GENI_CLK_CTRL        0x2000
>> +#define SE_DMA_IF_EN            0x2004
>> +#define SE_FIFO_IF_DISABLE        0x2008
>> +
>> +#define MAX_GENI_CFG_RAMn_CNT        455
>> +
>> +#define MI_PBT_NON_PAGED_SEGMENT    0x0
>> +#define MI_PBT_HASH_SEGMENT        0x2
>> +#define MI_PBT_NOTUSED_SEGMENT        0x3
>> +#define MI_PBT_SHARED_SEGMENT        0x4
>> +#define MI_PBT_FLAG_PAGE_MODE_MASK    0x100000
>> +#define MI_PBT_FLAG_PAGE_MODE_SHIFT    0x14
>> +#define MI_PBT_FLAG_SEGMENT_TYPE_MASK    0x7000000
>> +#define MI_PBT_FLAG_SEGMENT_TYPE_SHIFT    0x18
>> +#define MI_PBT_FLAG_ACCESS_TYPE_MASK    0xE00000
>> +#define MI_PBT_FLAG_ACCESS_TYPE_SHIFT    0x15
>> +
>> +#define MI_PBT_PAGE_MODE_VALUE(x) \
>> +    (((x) & MI_PBT_FLAG_PAGE_MODE_MASK) >> \
>> +      MI_PBT_FLAG_PAGE_MODE_SHIFT)
>> +
>> +#define MI_PBT_SEGMENT_TYPE_VALUE(x) \
>> +    (((x) & MI_PBT_FLAG_SEGMENT_TYPE_MASK) >> \
>> +        MI_PBT_FLAG_SEGMENT_TYPE_SHIFT)
>> +
>> +#define MI_PBT_ACCESS_TYPE_VALUE(x) \
>> +    (((x) & MI_PBT_FLAG_ACCESS_TYPE_MASK) >> \
>> +      MI_PBT_FLAG_ACCESS_TYPE_SHIFT)
>> +
>> +/* GENI_FORCE_DEFAULT_REG fields */
>> +#define FORCE_DEFAULT            BIT(0)
>> +
>> +/* FW_REVISION_RO fields */
>> +#define FW_REV_PROTOCOL_SHFT        8
>> +#define FW_REV_VERSION_SHFT        0
>> +
>> +#define GENI_FW_REVISION_RO        0x68
>> +#define GENI_S_FW_REVISION_RO        0x6C
>> +
>> +/* SE_GENI_DMA_MODE_EN */
>> +#define GENI_DMA_MODE_EN        BIT(0)
>> +
>> +/* GENI_M_IRQ_EN fields */
>> +#define M_CMD_DONE_EN            BIT(0)
>> +#define M_IO_DATA_DEASSERT_EN        BIT(22)
>> +#define M_IO_DATA_ASSERT_EN        BIT(23)
>> +#define M_RX_FIFO_RD_ERR_EN        BIT(24)
>> +#define M_RX_FIFO_WR_ERR_EN        BIT(25)
>> +#define M_RX_FIFO_WATERMARK_EN        BIT(26)
>> +#define M_RX_FIFO_LAST_EN        BIT(27)
>> +#define M_TX_FIFO_RD_ERR_EN        BIT(28)
>> +#define M_TX_FIFO_WR_ERR_EN        BIT(29)
>> +#define M_TX_FIFO_WATERMARK_EN        BIT(30)
>> +#define M_COMMON_GENI_M_IRQ_EN    (GENMASK(6, 1) | \
>> +                M_IO_DATA_DEASSERT_EN | \
>> +                M_IO_DATA_ASSERT_EN | M_RX_FIFO_RD_ERR_EN | \
>> +                M_RX_FIFO_WR_ERR_EN | M_TX_FIFO_RD_ERR_EN | \
>> +                M_TX_FIFO_WR_ERR_EN)
>> +
>> +/* GENI_S_IRQ_EN fields */
>> +#define S_CMD_OVERRUN_EN        BIT(1)
>> +#define S_ILLEGAL_CMD_EN        BIT(2)
>> +#define S_CMD_CANCEL_EN            BIT(4)
>> +#define S_CMD_ABORT_EN            BIT(5)
>> +#define S_GP_IRQ_0_EN            BIT(9)
>> +#define S_GP_IRQ_1_EN            BIT(10)
>> +#define S_GP_IRQ_2_EN            BIT(11)
>> +#define S_GP_IRQ_3_EN            BIT(12)
>> +#define S_RX_FIFO_RD_ERR_EN        BIT(24)
>> +#define S_RX_FIFO_WR_ERR_EN        BIT(25)
>> +#define S_COMMON_GENI_S_IRQ_EN    (GENMASK(5, 1) | GENMASK(13, 9) | \
>> +                 S_RX_FIFO_RD_ERR_EN | S_RX_FIFO_WR_ERR_EN)
>> +
>> +#define GENI_CGC_CTRL_PROG_RAM_SCLK_OFF_BMSK        0x00000200
>> +#define GENI_CGC_CTRL_PROG_RAM_HCLK_OFF_BMSK        0x00000100
>> +
>> +#define GENI_DMA_MODE_EN_GENI_DMA_MODE_EN_BMSK        0x00000001
>> +
>> +#define DMA_TX_IRQ_EN_SET_RESET_DONE_EN_SET_BMSK    0x00000008
>> +#define DMA_TX_IRQ_EN_SET_SBE_EN_SET_BMSK        0x00000004
>> +#define DMA_TX_IRQ_EN_SET_DMA_DONE_EN_SET_BMSK        0x00000001
>> +
>> +#define DMA_RX_IRQ_EN_SET_FLUSH_DONE_EN_SET_BMSK    0x00000010
>> +#define DMA_RX_IRQ_EN_SET_RESET_DONE_EN_SET_BMSK    0x00000008
>> +#define DMA_RX_IRQ_EN_SET_SBE_EN_SET_BMSK        0x00000004
>> +#define DMA_RX_IRQ_EN_SET_DMA_DONE_EN_SET_BMSK        0x00000001
>> +
>> +#define DMA_GENERAL_CFG_AHB_SEC_SLV_CLK_CGC_ON_BMSK    0x00000008
>> +#define DMA_GENERAL_CFG_DMA_AHB_SLV_CLK_CGC_ON_BMSK    0x00000004
>> +#define DMA_GENERAL_CFG_DMA_TX_CLK_CGC_ON_BMSK        0x00000002
>> +#define DMA_GENERAL_CFG_DMA_RX_CLK_CGC_ON_BMSK        0x00000001
>> +
>> +#define GENI_CLK_CTRL_SER_CLK_SEL_BMSK            0x00000001
>> +#define DMA_IF_EN_DMA_IF_EN_BMSK            0x00000001
>> +#define SE_GSI_EVENT_EN_BMSK                0x0000000f
>> +#define SE_IRQ_EN_RMSK                    0x0000000f
>> +
>> +#define QUPV3_COMMON_CFG                0x0120
>> +#define FAST_SWITCH_TO_HIGH_DISABLE_BMASK        0x00000001
>> +
>> +#define QUPV3_SE_AHB_M_CFG                0x0118
>> +#define AHB_M_CLK_CGC_ON_BMASK                0x00000001
>> +
>> +#define QUPV3_COMMON_CGC_CTRL                0x021C
>> +#define COMMON_CSR_SLV_CLK_CGC_ON_BMASK            0x00000001
>> +
>> +/* access ports */
>> +#define geni_setbits32(_addr, _v) writel_relaxed(readl_relaxed(_addr) 
>> |  (_v), (_addr))
>> +#define geni_clrbits32(_addr, _v) writel_relaxed(readl_relaxed(_addr) 
>> & ~(_v), (_addr))
>> +
>> +/**
>> + * struct elf_se_hdr - firmware configurations
>> + *
>> + * @magic: set to 'SEFW'
>> + * @version: A 32-bit value indicating the structure’s version number
>> + * @core_version: QUPV3_HW_VERSION
>> + * @serial_protocol: Programmed into GENI_FW_REVISION
>> + * @fw_version: Programmed into GENI_FW_REVISION
>> + * @cfg_version: Programmed into GENI_INIT_CFG_REVISION
>> + * @fw_size_in_items: Number of (uint32_t) GENI_FW_RAM words
>> + * @fw_offset: Byte offset of GENI_FW_RAM array
>> + * @cfg_size_in_items: Number of GENI_FW_CFG index/value pairs
>> + * @cfg_idx_offset: Byte offset of GENI_FW_CFG index array
>> + * @cfg_val_offset: Byte offset of GENI_FW_CFG values array
>> + */
>> +struct elf_se_hdr {
>> +    u32 magic;
>> +    u32 version;
>> +    u32 core_version;
>> +    u16 serial_protocol;
>> +    u16 fw_version;
>> +    u16 cfg_version;
>> +    u16 fw_size_in_items;
>> +    u16 fw_offset;
>> +    u16 cfg_size_in_items;
>> +    u16 cfg_idx_offset;
>> +    u16 cfg_val_offset;
>> +};
>> +
>> +struct udevice;
>> +
>> +int qcom_geni_load_firmware(phys_addr_t qup_base, struct udevice *dev);
>> +
>> +#endif /* _LINUX_QCOM_QUP_FW_LOAD */
>>
> 
> Thx,
> Neil

-- 
Caleb (they/them)

