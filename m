Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DACEE77198
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 22:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 358B880601;
	Sun,  5 Jan 2025 23:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736115137;
	bh=jL0AL5KeOjhCCg5pH4a8ZlNHI4jXsLR1iaejfw2RYT8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0DC5V/T2aphGmKaKivkJ02w8EiXva+t48RwTBpEe7hzAVIOPgghiXgrshbs7s2Hx5
	 SDY1UWjNg1+pV24lrUJyOrJLHVlFKBhZ5d8lWbU6fwGiDQ/kJzQCXw5jEpFAeI96pD
	 vDOeuTCfcNHaRpRJW3Iw2MYb7B62d4ssu6wQ6TdEYq4h154s47Gg3J515RM7MCjSpU
	 KcJ7mURi937sIZ8KenvULMSuzAFghrHclIcsMJDWaMh06UmDZRJFIccTMU410n+rLH
	 ZlVy2GA04eGWkXMtltbN0PJ1QTSZapYVuT8eQpUYISr6T1y8boXEc2MF66m3nodqD2
	 IjPB2jPJK8caQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E829C805F4; Sun,  5 Jan 2025 23:12:15 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ECA4801CE
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 23:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="A5t/9Ha2"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C8249109403D2; Sun,  5 Jan 2025 23:12:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736115132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jL0AL5KeOjhCCg5pH4a8ZlNHI4jXsLR1iaejfw2RYT8=;
 b=A5t/9Ha2ylVBuIKQ1mKmxZcP7Hxej9aCDH22bYsKDTYJYMfi2rjAI6eWNbR9faq+RyDtcV
 OLqsUJbujA4dLzZ8btl8IobZTBWz+pHZqxvxt7VCFOGpAPjNCOsRQnP9AqN9Pmpg9dlhPC
 8bSpiiycr3cPs4uS1NBviKhsznkGQGvtx1CJ2mMaA1SNtBSdgJX1xSI1XLVAIPTDjA+LDU
 dVAaWdAbeymtPG6NMnlK7KifbjIq+7HCqOIQV+7qP49QpMwDr7IPYNdU0VYF4WBBBDLob8
 tF3b9KERY8jicGjaTO32vFp+Ly91GKDPwTbmI5zTdxHgLTXG6jXriDwW03l5AA==
Message-ID: <dd9b71d0-fb3f-4e5f-9c58-d570d1e3fc80@denx.de>
Date: Sun, 5 Jan 2025 22:29:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/17] imx9: scmi: add i.MX95 SoC and clock related code
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-9-6744df5dc020@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250103-imx95-v1-9-6744df5dc020@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/3/25 7:45 AM, Alice Guo wrote:

[...]

 > diff --git a/arch/arm/include/asm/arch-imx9/clock.h 
b/arch/arm/include/asm/arch-imx9/clock.h
> index 60d48b13b11f274c9e4c8caf20954de0431d9d6a..a64c18b28291553d47725d83cb748031faf64488 100644
> --- a/arch/arm/include/asm/arch-imx9/clock.h
> +++ b/arch/arm/include/asm/arch-imx9/clock.h
> @@ -1,8 +1,8 @@
>   /* SPDX-License-Identifier: GPL-2.0+ */
>   /*
> - * Copyright 2022 NXP
> + * Copyright 2024 NXP

2022-2024

> - * Peng Fan <peng.fan at nxp.com>
> + * Peng Fan <peng.fan@nxp.com>

Is the email update desirable ?

[...]

> diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
> index 109a806852ab42d018ce45a4e96af5b57adb6a9c..bcf33769ae5f45125bbf9377eb64d96473dc4996 100644
> --- a/arch/arm/include/asm/mach-imx/sys_proto.h
> +++ b/arch/arm/include/asm/mach-imx/sys_proto.h
> @@ -2,6 +2,7 @@
>   /*
>    * (C) Copyright 2009
>    * Stefano Babic, DENX Software Engineering, sbabic@denx.de.
> + * Copyright 2024 NXP
>    */
>   
>   #ifndef _SYS_PROTO_H_
> @@ -97,6 +98,8 @@ struct bd_info;
>   #define is_imx9302() (is_cpu_type(MXC_CPU_IMX9302))
>   #define is_imx9301() (is_cpu_type(MXC_CPU_IMX9301))
>   
> +#define is_imx95() (is_cpu_type(MXC_CPU_IMX95))
> +
>   #define is_imx9121() (is_cpu_type(MXC_CPU_IMX9121))
>   #define is_imx9111() (is_cpu_type(MXC_CPU_IMX9111))
>   #define is_imx9101() (is_cpu_type(MXC_CPU_IMX9101))
> @@ -216,6 +219,43 @@ ulong spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev);
>   u32 rom_api_download_image(u8 *dest, u32 offset, u32 size);
>   u32 rom_api_query_boot_infor(u32 info_type, u32 *info);
>   
> +#ifdef CONFIG_SCMI_FIRMWARE

Avoid typedefs

> +typedef struct rom_passover {

Use uN types instead of uintN_t ...

> +	uint16_t tag;                   //!< Tag

u16

> +	uint8_t  len;                   //!< Fixed value of 0x80

u8 and so on ...

> +	uint8_t  ver;                   //!< Version
> +	uint32_t boot_mode;             //!< Boot mode
> +	uint32_t card_addr_mode;        //!< SD card address mode
> +	uint32_t bad_blks_of_img_set0;  //!< NAND bad block count skipped 1
> +	uint32_t ap_mu_id;              //!< AP MU ID
> +	uint32_t bad_blks_of_img_set1;  //!< NAND bad block count skipped 1
> +	uint8_t  boot_stage;            //!< Boot stage
> +	uint8_t  img_set_sel;           //!< Image set booted from
> +	uint8_t  rsv0[2];               //!< Reserved
> +	uint32_t img_set_end;           //!< Offset of Image End
> +	uint32_t rom_version;           //!< ROM version
> +	uint8_t  boot_dev_state;        //!< Boot device state
> +	uint8_t  boot_dev_inst;         //!< Boot device type
> +	uint8_t  boot_dev_type;         //!< Boot device instance
> +	uint8_t  rsv1;                  //!< Reserved
> +	uint32_t dev_page_size;         //!< Boot device page size
> +	uint32_t cnt_header_ofs;        //!< Container header offset
> +	uint32_t img_ofs;               //!< Image offset

What is that //!< in comments ^ ?

> +}  __attribute__ ((packed)) rom_passover_t;

__packed

[...]

> +++ b/arch/arm/mach-imx/imx9/scmi/clock.c
> @@ -0,0 +1,328 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <asm/arch/ccm_regs.h>
> +#include <asm/arch/clock.h>
> +#include <asm/arch/imx-regs.h>
> +#include <asm/arch/sys_proto.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <command.h>
> +#include <errno.h>
> +#ifdef CONFIG_CLK_SCMI
> +#include "../../../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
> +#include <dm/uclass.h>
> +#include <dm/uclass-internal.h>
> +#include <linux/clk-provider.h>
> +#include <scmi_agent.h>
> +#include <scmi_protocols.h>
> +#include <dm/device.h>
> +#include <dm/device-internal.h>
> +#endif
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +u32 get_arm_core_clk(void)
> +{
> +	u32 val;
> +
> +	/* TODO: */

To Do what ?

> +	val = imx_clk_scmi_get_rate(IMX95_CLK_SEL_A55C0);
> +	if (val)
> +		return val;
> +	return imx_clk_scmi_get_rate(IMX95_CLK_A55);
> +}
> +
> +void set_arm_core_max_clk(void)
> +{
> +	int ret;
> +	u32 arm_domain_id = 8;
> +
> +	struct scmi_perf_in in = {
> +		.domain_id = arm_domain_id,
> +		.perf_level = 3,
> +	};
> +	struct scmi_perf_out out;
> +	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PERF, SCMI_PERF_LEVEL_SET, in, out);
> +	struct udevice *dev;
> +
> +	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
> +	if (ret)
> +		printf("%s: %d\n", __func__, ret);

What happens on failure ?

> +	ret = devm_scmi_process_msg(dev, &msg);
> +	if (ret)
> +		printf("%s: %d\n", __func__, ret);
> +}
> +
> +void enable_usboh3_clk(unsigned char enable)

Is this needed ?

> +{
> +}
> +
> +int clock_init_early(void)
> +{
> +	return 0;
> +}
> +
> +/* Set bus and A55 core clock per voltage mode */
> +int clock_init_late(void)
> +{
> +	set_arm_core_max_clk();
> +
> +	return 0;
> +}
> +
> +u32 get_lpuart_clk(void)
> +{
> +	return imx_clk_scmi_get_rate(IMX95_CLK_LPUART1);
> +}
> +
> +void init_uart_clk(u32 index)
> +{
> +	u32 clock_id;
> +
> +	switch (index) {
> +	case 0:
> +		clock_id = IMX95_CLK_LPUART1;
> +		break;
> +	case 1:
> +		clock_id = IMX95_CLK_LPUART2;
> +		break;
> +	case 2:
> +		clock_id = IMX95_CLK_LPUART3;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	/* 24MHz */
> +	imx_clk_scmi_enable(clock_id, false);
> +	imx_clk_scmi_set_parent(clock_id, IMX95_CLK_24M);
> +	imx_clk_scmi_set_rate(clock_id, 24000000);
> +	imx_clk_scmi_enable(clock_id, true);
> +}
> +
> +/* I2C check */
> +u32 imx_get_i2cclk(u32 i2c_num)
> +{
> +	if (i2c_num > 7)
> +		return -EINVAL;
> +	switch (i2c_num) {
> +	case 0:
> +		return imx_clk_scmi_get_rate(IMX95_CLK_LPI2C1);

Can this switch-case statement be turned into some

return imx_clk_scmi_get_rate(IMX95_CLK_LPI2C1 + i2c_num);

?


> +int enable_i2c_clk(unsigned char enable, u32 i2c_num)
> +{
> +	u32 clock_id;
> +
> +	if (i2c_num > 7)
> +		return -EINVAL;
> +
> +	switch (i2c_num) {
> +	case 0:
> +		clock_id = IMX95_CLK_LPI2C1;

Can this switch-case statement be turned into some

clock_id = IMX95_CLK_LPI2C1 + i2c_num;

?

> +		break;
> +	case 1:
> +		clock_id = IMX95_CLK_LPI2C2;
> +		break;

DTTO for all the other switch-case statements.

> +void dram_enable_bypass(ulong clk_val)
> +{
> +	u64 rate;
> +
> +	switch (clk_val) {
> +	case MHZ(625):
> +		imx_clk_scmi_set_parent(IMX95_CLK_DRAMALT, IMX95_CLK_SYSPLL1_PFD2);
> +		rate = imx_clk_scmi_set_rate(IMX95_CLK_DRAMALT, clk_val);
> +		break;
> +	case MHZ(400):
> +		imx_clk_scmi_set_parent(IMX95_CLK_DRAMALT, IMX95_CLK_SYSPLL1_PFD1);
> +		rate = imx_clk_scmi_set_rate(IMX95_CLK_DRAMALT, clk_val);
> +		break;
> +	case MHZ(333):
> +		imx_clk_scmi_set_parent(IMX95_CLK_DRAMALT, IMX95_CLK_SYSPLL1_PFD0);
> +		rate = imx_clk_scmi_set_rate(IMX95_CLK_DRAMALT, 333333333);

Why is this rate special with hard-coded 333333333 value , while the 
other rates use clk_val ?

[...]

> +void dram_disable_bypass(void)
> +{
> +	u64 rate;
> +	/* Set DRAM APB to 133Mhz */
> +	imx_clk_scmi_set_parent(IMX95_CLK_DRAMAPB, IMX95_CLK_SYSPLL1_PFD1_DIV2);
> +	rate = imx_clk_scmi_set_rate(IMX95_CLK_DRAMAPB, 133333333);
> +
> +	/*Set the DRAM_GPR_SEL to be sourced from DRAM_PLL.*/

/*[+SPACE+]Set the ...

Add the missing spaces into comments globally .

> +	imx_clk_scmi_set_parent(IMX95_CLK_SEL_DRAM, IMX95_CLK_DRAMPLL);
> +	rate = imx_clk_scmi_get_rate(IMX95_CLK_SEL_DRAM);
> +	printf("%s:SEL_DRAM: %llu\n", __func__, rate);
> +}
> +
> +#endif
> +
> +unsigned int mxc_get_clock(enum mxc_clock clk)
> +{
> +	switch (clk) {
> +	case MXC_ARM_CLK:
> +		return get_arm_core_clk();
> +	case MXC_IPG_CLK:
> +		return imx_clk_scmi_get_rate(IMX95_CLK_BUSWAKEUP);
> +	case MXC_CSPI_CLK:
> +		return imx_clk_scmi_get_rate(IMX95_CLK_LPSPI1);
> +	case MXC_ESDHC_CLK:
> +		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC1);
> +	case MXC_ESDHC2_CLK:
> +		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC2);
> +	case MXC_ESDHC3_CLK:
> +		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC3);
> +	case MXC_UART_CLK:
> +		return imx_clk_scmi_get_rate(IMX95_CLK_LPUART1);
> +	case MXC_FLEXSPI_CLK:
> +		return imx_clk_scmi_get_rate(IMX95_CLK_FLEXSPI1);
> +	default:
> +		return -1;
> +	};
> +
> +	return -1;
> +};

Can this clock stuff be finally moved into drivers/clk/ ?

> diff --git a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..543abe9fed481c796602b2b2eeeec6c8f9a94862
> --- /dev/null
> +++ b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c

[...]

> +int imx_clk_scmi_enable(u32 clock_id, bool enable)
> +{
> +	struct scmi_clk_state_in in = {
> +		.clock_id = clock_id,
> +		.attributes = (enable) ? 1 : 0,
> +	};
> +	struct scmi_clk_state_out out;
> +	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
> +					  SCMI_CLOCK_CONFIG_SET,
> +					  in, out);
> +	int ret;
> +	struct udevice *dev;
> +
> +	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);

It seems this pattern of

uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
devm_scmi_process_msg(dev, &msg);
scmi_to_linux_errno(out.status);

is repeated in multiple functions here. Can this be deduplicated ?

Also, should devm_scmi_process_msg(dev, &msg); be used here ? Who is 
deallocating the devm_ allocated memory ?

[...]

> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c

[...]

> +DECLARE_GLOBAL_DATA_PTR;
> +
> +rom_passover_t rom_passover_data = {0};

Should this variable be static ?

> +uint32_t scmi_get_rom_data(rom_passover_t *rom_data)
> +{
> +	/* Read ROM passover data */
> +	struct scmi_rom_passover_get_out out;
> +	struct scmi_msg msg = SCMI_MSG(SCMI_PROTOCOL_ID_IMX_MISC, SCMI_MISC_ROM_PASSOVER_GET, out);
> +	int ret;
> +	struct udevice *dev;
> +
> +	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
> +	if (ret)
> +		return ret;

Seems like another duplicate pattern (see above).

> +	ret = devm_scmi_process_msg(dev, &msg);
> +	if (ret == 0 && out.status == 0) {
> +		memcpy(rom_data, (struct rom_passover_t *)out.passover, sizeof(rom_passover_t));
> +	} else {

Invert the conditional here, check for error and bail on error.

> +		printf("Failed to get ROM passover data, scmi_err = %d, size_of(out) = %ld\n",
> +		       out.status, sizeof(out));
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_ENV_IS_IN_MMC
> +__weak int board_mmc_get_env_dev(int devno)
> +{
> +	return devno;
> +}
> +
> +int mmc_get_env_dev(void)
> +{
> +	int ret;
> +	u16 boot_type;
> +	u8 boot_instance;
> +
> +	volatile gd_t *pgd = gd;
> +	rom_passover_t *rdata;
> +#ifdef CONFIG_SPL_BUILD

That would be XPL now . Also use if IS_ENABLED or CONFIG_IS_ENABLED .

> +	rdata = &rom_passover_data;
> +#else
> +	rom_passover_t rom_data = {0};
> +
> +	if (!pgd->reloc_off)
> +		rdata = &rom_data;
> +	else
> +		rdata = &rom_passover_data;
> +#endif
> +	if (rdata->tag == 0) {
> +		ret = scmi_get_rom_data(rdata);
> +		if (ret != 0) {
> +			puts("SCMI: failure at rom_boot_info\n");
> +			return CONFIG_SYS_MMC_ENV_DEV;
> +		}
> +	}
> +	boot_type = rdata->boot_dev_type;
> +	boot_instance = rdata->boot_dev_inst;
> +	set_gd(pgd);
> +
> +	debug("boot_type %d, instance %d\n", boot_type, boot_instance);
> +
> +	/* If not boot from sd/mmc, use default value */
> +	if (boot_type != BOOT_TYPE_SD && boot_type != BOOT_TYPE_MMC)
> +		return env_get_ulong("mmcdev", 10, CONFIG_SYS_MMC_ENV_DEV);
> +
> +	return board_mmc_get_env_dev(boot_instance);
> +}
> +#endif
> +
> +u32 get_cpu_speed_grade_hz(void)
> +{
> +	u32 speed, max_speed;
> +	int ret;
> +	u32 val, word, offset;
> +
> +	word = 17;
> +	offset = 14;
> +
> +	ret = fuse_read((word / 8), (word % 8), &val);

No need for the parenthesis inside fuse_read() , fix globally.

> +	if (ret)
> +		val = 0; /* If read fuse failed, return as blank fuse */
> +
> +	val >>= offset;
> +	val &= 0xf;
> +
> +	max_speed = 2300000000;
> +	speed = max_speed - val * 100000000;
> +
> +	if (is_imx95())
> +		max_speed = 2000000000;
> +
> +	/* In case the fuse of speed grade not programmed */
> +	if (speed > max_speed)
> +		speed = max_speed;
> +
> +	return speed;
> +}
> +
> +u32 get_cpu_temp_grade(int *minc, int *maxc)
> +{
> +	int ret;
> +	u32 val, word, offset;
> +
> +	word = 17;
> +	offset = 12;
> +
> +	ret = fuse_read((word / 8), (word % 8), &val);
> +	if (ret)
> +		val = 0; /* If read fuse failed, return as blank fuse */
> +
> +	val >>= offset;
> +	val &= 0x3;
> +
> +	if (minc && maxc) {
> +		if (val == TEMP_AUTOMOTIVE) {
> +			*minc = -40;
> +			*maxc = 125;
> +		} else if (val == TEMP_INDUSTRIAL) {
> +			*minc = -40;
> +			*maxc = 105;
> +		} else if (val == TEMP_EXTCOMMERCIAL) {
> +			*minc = -20;
> +			*maxc = 105;
> +		} else {
> +			*minc = 0;
> +			*maxc = 95;
> +		}
> +	}
> +	return val;
> +}

Can at least some of this be moved into some thermal driver in 
drivers/thermal/ ?

> +static void set_cpu_info(struct ele_get_info_data *info)
> +{
> +	gd->arch.soc_rev = info->soc;
> +	gd->arch.lifecycle = info->lc;
> +	memcpy((void *)&gd->arch.uid, &info->uid, 4 * sizeof(u32));
> +}
> +
> +u32 get_cpu_rev(void)
> +{
> +	u32 rev = (gd->arch.soc_rev >> 24) - 0xa0;
> +
> +	return (MXC_CPU_IMX95 << 12) | (CHIP_REV_1_0 + rev);
> +}
> +
> +#define UNLOCK_WORD 0xD928C520 /* unlock word */
> +#define REFRESH_WORD 0xB480A602 /* refresh word */
> +
> +static void disable_wdog(void __iomem *wdog_base)
> +{
> +	u32 val_cs = readl(wdog_base + 0x00);

Can this be moved to drivers/watchdog/ ?

> +	if (!(val_cs & 0x80))
> +		return;
> +
> +	/* default is 32bits cmd */
> +	writel(REFRESH_WORD, (wdog_base + 0x04)); /* Refresh the CNT */
> +
> +	if (!(val_cs & 0x800)) {
> +		writel(UNLOCK_WORD, (wdog_base + 0x04));
> +		while (!(readl(wdog_base + 0x00) & 0x800))
> +			;
> +	}
> +	writel(0x0, (wdog_base + 0x0C)); /* Set WIN to 0 */
> +	writel(0x400, (wdog_base + 0x08)); /* Set timeout to default 0x400 */
> +	writel(0x2120, (wdog_base + 0x00)); /* Disable it and set update */
> +
> +	while (!(readl(wdog_base + 0x00) & 0x400))
> +		;
> +}

[...]

> +int ft_system_setup(void *blob, struct bd_info *bd)
> +{
> +	return 0;
> +}
> +
> +#if defined(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)
> +void get_board_serial(struct tag_serialnr *serialnr)
> +{
> +	printf("UID: 0x%x 0x%x 0x%x 0x%x\n",
> +	       gd->arch.uid[0], gd->arch.uid[1], gd->arch.uid[2], gd->arch.uid[3]);
> +
> +	serialnr->low = gd->arch.uid[0];
> +	serialnr->high = gd->arch.uid[3];
> +}
> +#endif
> +
> +static void gpio_reset(ulong gpio_base)
> +{
> +	writel(0, gpio_base + 0x10);
> +	writel(0, gpio_base + 0x14);
> +	writel(0, gpio_base + 0x18);
> +	writel(0, gpio_base + 0x1c);

This should be in drivers/gpio in the GPIO driver probe, if needed at all.

> +}
> +
> +int arch_cpu_init(void)
> +{
> +	if (IS_ENABLED(CONFIG_SPL_BUILD)) {

if (!IS_ENABLED(CONFIG_SPL_BUILD))
	return 0;

> +		disable_wdog((void __iomem *)WDG3_BASE_ADDR);
> +		disable_wdog((void __iomem *)WDG4_BASE_ADDR);
> +
> +		clock_init_early();
> +
> +		gpio_reset(GPIO2_BASE_ADDR);
> +		gpio_reset(GPIO3_BASE_ADDR);
> +		gpio_reset(GPIO4_BASE_ADDR);
> +		gpio_reset(GPIO5_BASE_ADDR);
> +	}
> +
> +	return 0;
> +}
> +
> +int imx9_probe_mu(void)
> +{
> +	struct udevice *dev;
> +	int node, ret;
> +	u32 res;
> +	struct ele_get_info_data info;
> +
> +	ret = uclass_get_device_by_driver(UCLASS_SCMI_AGENT, DM_DRIVER_GET(scmi_mbox), &dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_scmi_of_get_channel(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = uclass_get_device_by_name(UCLASS_PINCTRL, "protocol@19", &dev);
> +	if (ret)
> +		return ret;

Is this really needed ? MU would be probed on first use automatically 
somewhere else.

[...]
