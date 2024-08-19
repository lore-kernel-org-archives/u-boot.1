Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7035BC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 11:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DA9388744;
	Mon, 19 Aug 2024 13:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uAbxpyND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DE3488A3A; Mon, 19 Aug 2024 13:09:50 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ED5F88744
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 13:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5bec78c3f85so3241763a12.1
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724065787; x=1724670587; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oorFi5RRKewBbIPKwU/sAlS+5Dr0/zTe6U+O+ll3gs0=;
 b=uAbxpyNDop0bHu3gkLH+sKgug0NMfRB9krqicn6x9/2dgo0wRlZzt2O52pGSvZdi5x
 OuD+2baJMHkucKadG9HkmOM8SwnSDzIBpwfdmbAZZKESi0KwqmMmrrEhMSmNjMBzDnQp
 FZAYQYnLAmHY74PD+9M/5wh8pNEMxpN54+rsys59YObQfK/vkAtdvrFYUEOXZvo7v6Lf
 420mdjtYUaTHFsYYVUsyoTTWEK1KMxgW8n+tDuk67CbmE0VMgArGSb+exjgVwh5eNJH9
 Tx8Yu1teAdML7UVHSgYUfdERyMnJxjIGEtcofFSYXPNAOsCDuqxe1zuW9nQzXx7OX6PD
 TooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724065787; x=1724670587;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oorFi5RRKewBbIPKwU/sAlS+5Dr0/zTe6U+O+ll3gs0=;
 b=Lx/BxaPLdoawOhYAl3WSkDQ7KfqNLrIBN8WXutFgWOq2qsOyjLbdm71ROl00fU2FDH
 B1UrWdpymWkYyfvGqh4k0vgct+KwjSI6AhHa3iS7aMPF610uQ4sTaAPHl1l/Z2m8L4dc
 scmJqH21Boe6FoGmmIu+g0PUa01OJwi99u2FUcB5avn861HmxIsWfQ1We81N62EBCbjx
 +vptW6FjxiRX77rDpSEe0Paf5Eq6UoS8Nzmxd5aPppYn5IJpmqcp1/zFzGmvJCx95u+y
 eOOhQs86GjYGJADHSaONWvGSoDwvByDJ8+OORHsPKm43cLKCg8QctGwnbdHv+Bvl+/ne
 3riw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5ElrgXkj6cn72GQPM7kjb2R7fRWdtQI3QMKHiWA6bM9R9l3byPXdtFOE7BTRxJOZxA1mALA+TrejJxVOfCWfHUJj6vA==
X-Gm-Message-State: AOJu0YzUrczOhQfiPkw4lBK79oL5+tEVPez1IZ3XbWL+vYdkAhmBgA4g
 QNDyJmplnSxz5wdKpy8ynKaOBYTzCIhz3GzZaT68+PWqzt+kMkHPyGzd+I5isug=
X-Google-Smtp-Source: AGHT+IF07WMPcEIzlcVG+3W4Hc4bRlFkcU1N5JiaMphnB8baCWF4BNb6jJT+jgAnqiuBbAi8FKX4/Q==
X-Received: by 2002:a17:906:f591:b0:a7a:a30b:7b95 with SMTP id
 a640c23a62f3a-a83928a3559mr493397966b.2.1724065787332; 
 Mon, 19 Aug 2024 04:09:47 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::676e? ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cfb24sm620106466b.68.2024.08.19.04.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 04:09:46 -0700 (PDT)
Message-ID: <d2f9ed35-2798-4001-b891-ee08cf01079e@linaro.org>
Date: Mon, 19 Aug 2024 13:09:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] armv8: Add arch-specific sysinfo driver
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Stefan Roese <sr@denx.de>,
 Kever Yang <kever.yang@rock-chips.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Michal Simek <michal.simek@amd.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, Peter Robinson <pbrobinson@gmail.com>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <20240816154658.1866186-6-raymond.mao@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240816154658.1866186-6-raymond.mao@linaro.org>
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

Hi Raymond,

On 16/08/2024 17:46, Raymond Mao wrote:
> Add common sysinfo driver for armv8 platforms containing all
> necessary SMBIOS information (Type 1 to 4).
> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>   arch/arm/cpu/armv8/Makefile  |   5 +
>   arch/arm/cpu/armv8/sysinfo.c | 203 +++++++++++++++++++++++++++++++++++
>   2 files changed, 208 insertions(+)
>   create mode 100644 arch/arm/cpu/armv8/sysinfo.c
> 
> diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
> index bba4f570dbb..374f20d455d 100644
> --- a/arch/arm/cpu/armv8/Makefile
> +++ b/arch/arm/cpu/armv8/Makefile
> @@ -45,3 +45,8 @@ obj-$(CONFIG_TARGET_BCMNS3) += bcmns3/
>   obj-$(CONFIG_XEN) += xen/
>   obj-$(CONFIG_ARMV8_CE_SHA1) += sha1_ce_glue.o sha1_ce_core.o
>   obj-$(CONFIG_ARMV8_CE_SHA256) += sha256_ce_glue.o sha256_ce_core.o
> +
> +ifndef CONFIG_SPL_BUILD
> +obj-$(CONFIG_SYSINFO_SMBIOS) += sysinfo.o
> +ccflags-$(CONFIG_SYSINFO_SMBIOS) += -I$(srctree)/drivers/sysinfo
> +endif
> \ No newline at end of file
> diff --git a/arch/arm/cpu/armv8/sysinfo.c b/arch/arm/cpu/armv8/sysinfo.c
> new file mode 100644
> index 00000000000..a8e17d654be
> --- /dev/null
> +++ b/arch/arm/cpu/armv8/sysinfo.c
> @@ -0,0 +1,203 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +#include <dm.h>
> +#if CONFIG_IS_ENABLED(SYSINFO_SMBIOS)
> +#include <smbios_plat.h>
> +#endif
> +#include <stdio.h>
> +#include <sysinfo.h>
> +
> +#define ELEMENT_RECORD_DATA_LEN 8
> +#define ELEMENT_RECORD_NUM 2
> +
> +union midr_el1 {
> +	struct {
> +		u64 revision:4;
> +		u64 partnum:12;
> +		u64 architecture:4;
> +		u64 variant:4;
> +		u64 implementer:8;
> +		u64 reserved:32;
> +	} fields;
> +	u64 data;
> +};
> +
> +enum {
> +	VENDOR_RESERVED = 0,
> +	VENDOR_ARM = 0x41,
> +	VENDOR_BROADCOM = 0x42,
> +	VENDOR_CAVIUM = 0x43,
> +	VENDOR_DEC = 0x44,
> +	VENDOR_FUJITSU = 0x46,
> +	VENDOR_INFINEON = 0x49,
> +	VENDOR_FREESCALE = 0x4d,
> +	VENDOR_NVIDIA = 0x4e,
> +	VENDOR_AMCC = 0x50,
> +	VENDOR_QUALCOMM = 0x51,
> +	VENDOR_MARVELL = 0x56,
> +	VENDOR_INTEL = 0x69,
> +	VENDOR_AMPERE = 0xc0,
> +};
> +
> +struct __packed enclosure_element_record {
> +	struct elem_hdr hdr;
> +	u8 data[ELEMENT_RECORD_DATA_LEN];
> +};
> +
> +struct processor_info processor_info_armv8;
> +
> +/* Default data for the enclosure contained elements */
> +struct enclosure_element_record contained_elements[ELEMENT_RECORD_NUM] = {
> +	{
> +		.hdr.type = SMBIOS_BOARD_MOTHERBOARD,
> +		.hdr.minimum = 0,
> +		.hdr.maximum = 0xff,
> +		.data = {0},
> +	},
> +	{
> +		.hdr.type = SMBIOS_BOARD_MOTHERBOARD,
> +		.hdr.minimum = 0,
> +		.hdr.maximum = 0xff,
> +		.data = {0},
> +	},
> +};
> +
> +int sysinfo_get_processor_info(struct processor_info *pinfo)
> +{
> +	u64 mpidr, core_count;
> +	union midr_el1 midr;
> +
> +	/* Read the MIDR_EL1 register */
> +	asm volatile("mrs %0, MIDR_EL1" : "=r"(midr.data));
> +	/* Read the MPIDR_EL1 register */
> +	asm volatile("mrs %0, MPIDR_EL1" : "=r"(mpidr));
> +
> +	log_debug("MIDR: 0x%016llx\n", midr.data);

Maybe an unreasonable request, but I think it would make more sense to 
use debug() here rather than log_debug() so as not to contribute to the 
logspam unless someone actually wants to log this file.

Or another option, maybe you could combined these prints into a single line?

Kind regards,
Caleb
> +	log_debug("MPIDR: 0x%016llx\n", mpidr);
> +	log_debug("CPU Implementer: 0x%02x\n", midr.fields.implementer);
> +
> +	switch (midr.fields.implementer) {
> +	case VENDOR_ARM:
> +		pinfo->manufacturer = "ARM Limited";
> +		break;
> +	case VENDOR_BROADCOM:
> +		pinfo->manufacturer = "Broadcom Corporation";
> +		break;
> +	case VENDOR_CAVIUM:
> +		pinfo->manufacturer = "Cavium Inc";
> +		break;
> +	case VENDOR_DEC:
> +		pinfo->manufacturer = "Digital Equipment Corporation";
> +		break;
> +	case VENDOR_FUJITSU:
> +		pinfo->manufacturer = "Fujitsu Ltd";
> +		break;
> +	case VENDOR_INFINEON:
> +		pinfo->manufacturer = "Infineon Technologies AG";
> +		break;
> +	case VENDOR_FREESCALE:
> +		pinfo->manufacturer = "Freescale Semiconductor Inc";
> +		break;
> +	case VENDOR_NVIDIA:
> +		pinfo->manufacturer = "NVIDIA Corporation";
> +		break;
> +	case VENDOR_AMCC:
> +		pinfo->manufacturer =
> +			"Applied Micro Circuits Corporation";
> +		break;
> +	case VENDOR_QUALCOMM:
> +		pinfo->manufacturer = "Qualcomm Inc";
> +		break;
> +	case VENDOR_MARVELL:
> +		pinfo->manufacturer = "Marvell International Ltd";
> +		break;
> +	case VENDOR_INTEL:
> +		pinfo->manufacturer = "Intel Corporation";
> +		break;
> +	case VENDOR_AMPERE:
> +		pinfo->manufacturer = "Ampere Computing";
> +		break;
> +	default:
> +		pinfo->manufacturer = "Unknown";
> +		break;
> +	}
> +	log_debug("CPU part number: 0x%x\n", midr.fields.partnum);
> +	log_debug("CPU revision: 0x%x\n", midr.fields.revision);
> +	log_debug("CPU architecture: 0x%x\n", midr.fields.architecture);
> +	log_debug("CPU variant: 0x%x\n", midr.fields.variant);
> +
> +	pinfo->version = "Not Specified";
> +
> +	/* Extract number of cores */
> +	core_count = (mpidr >> 0) & 0xFF;
> +	pinfo->core_count = core_count + 1;
> +	log_debug("CPU Core Count: %d\n", pinfo->core_count);
> +
> +	/* Other default processor information */
> +	pinfo->type = SMBIOS_PROCESSOR_TYPE_CENTRAL;
> +	pinfo->status = SMBIOS_PROCESSOR_STATUS_ENABLED;
> +	pinfo->upgrade = SMBIOS_PROCESSOR_UPGRADE_NONE;
> +	pinfo->family2 = SMBIOS_PROCESSOR_FAMILY_ARMV8;
> +	pinfo->socket_design = "Not Specified";
> +	pinfo->sn = "Not Specified";
> +	pinfo->asset_tag = "Not Specified";
> +	pinfo->pn = "Not Specified";
> +	pinfo->core_enabled = pinfo->core_count;
> +	pinfo->characteristics = SMBIOS_PROCESSOR_64BIT |
> +		SMBIOS_PROCESSOR_ARM64_SOCID;
> +	if (pinfo->core_count > 1)
> +		pinfo->characteristics |= SMBIOS_PROCESSOR_MULTICORE;
> +
> +	return 0;
> +}
> +
> +struct sysinfo_plat sysinfo_smbios_armv8 = {
> +	/* System Information */
> +	.sys.manufacturer = "arm",
> +	.sys.prod_name = "arm",
> +	.sys.version = "armv8",
> +	.sys.sn = "Not Specified",
> +	.sys.wakeup_type = SMBIOS_WAKEUP_TYPE_UNKNOWN,
> +	.sys.sku_num = "Not Specified",
> +	.sys.family = "arm",
> +
> +	/* Baseboard (or Module) Information */
> +	.board.manufacturer = "arm",
> +	.board.prod_name = "arm",
> +	.board.version = "armv8",
> +	.board.sn = "Not Specified",
> +	.board.asset_tag = "Not Specified",
> +	.board.feature.fields.hosting_board = 1, /* host board */
> +	.board.chassis_locat = "Not Specified",
> +	.board.type = SMBIOS_BOARD_MOTHERBOARD,
> +
> +	/* System Enclosure or Chassis Information */
> +	.chassis.manufacturer = "arm",
> +	.chassis.version = "armv8",
> +	.chassis.sn = "Not Specified",
> +	.chassis.asset_tag = "Not Specified",
> +	.chassis.chassis_type = SMBIOS_ENCLOSURE_DESKTOP,
> +	.chassis.bootup_state = SMBIOS_STATE_SAFE,
> +	.chassis.power_supply_state = SMBIOS_STATE_SAFE,
> +	.chassis.thermal_state = SMBIOS_STATE_SAFE,
> +	.chassis.security_status = SMBIOS_SECURITY_NONE,
> +	.chassis.oem_defined = SMBIOS_ENCLOSURE_OEM_UND,
> +	.chassis.height = SMBIOS_ENCLOSURE_HEIGHT_UND,
> +	.chassis.number_of_power_cords = SMBIOS_POWCORD_NUM_UND,
> +	.chassis.element_count = ARRAY_SIZE(contained_elements),
> +	.chassis.element_record_length = sizeof(contained_elements[0]),
> +	.chassis.elements = &contained_elements[0],
> +	.chassis.elements_size = sizeof(contained_elements),
> +	.chassis.sku_num = "Not Specified",
> +
> +	/* Processor Information */
> +	.processor = &processor_info_armv8,
> +};
> +
> +U_BOOT_DRVINFO(sysinfo_smbios_plat) = {
> +	.name = "sysinfo_smbios_plat",
> +	.plat = &sysinfo_smbios_armv8,
> +};

-- 
// Caleb (they/them)
