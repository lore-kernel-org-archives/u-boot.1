Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03251E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227628022B;
	Thu, 19 Dec 2024 16:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fYEuUizl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22265802B4; Thu, 19 Dec 2024 16:52:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD46C8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:52:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734623523; x=1735228323; i=xypron.glpk@gmx.de;
 bh=+B1m1eNVxdrKkGhZwFx0giYyHyceJJIj5/cnXIA6i4o=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=fYEuUizlyezqsiheC/+2UcWbG3JQUDVq+ctnx6BC4JMn3xv00VTUCRKQ6ljwedQ4
 5PAND3xX7KxeVk5+oJtApXxoR+XKNyu0ZAXYFYBcjRRoWtkODB8IANdHdXrjsddyk
 KoDipZK3ze4hMpQjMkU0MnhXifEYzd1QhWTXtlatvH1sK/d/E9dzDNgfi0PPs4QOh
 zuF3uA6H7reEpJ9Dk5rBliiH6mkR1H+UuBL3GiLE+p1jLD4p9NqL9oI+14bdrn7hv
 y9y90DlBtu210glB+7g4nhnKaEfEthLhC0Ls0VSW8fcTbK63SK3YHSxfxfXOyhiRU
 JfGAA4MG3qpd8ehF7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.111.103]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPokD-1tBsVV3zUp-00M8Er; Thu, 19
 Dec 2024 16:52:03 +0100
Message-ID: <5b317e3d-7c1c-414e-9070-b76e306cca7f@gmx.de>
Date: Thu, 19 Dec 2024 16:51:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] armv8: Add arch-specific sysinfo platform driver
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Stefan Roese <sr@denx.de>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Alexander Gendin <agendin@matrox.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20241206225438.13866-1-raymond.mao@linaro.org>
 <20241206225438.13866-8-raymond.mao@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241206225438.13866-8-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n5o3uYi+F8rQ3OphS8t/4MdvTUqX7Zd9arO0+4U5gi9GADG53rY
 HK34YHP8C8SOGujpAtdPXQ4IKPAhk8zTdwapBShV5kOmHnJVVL2aE/EUjefkmxnnSzDHEJI
 D3nM4bMthIMybLgcQsgmmIL9SjqRaXYoIc9XY5XI4fCwL9U4LCsZznU9QVYCG+/tVEy7qLE
 Ekw58OQbTMyBqtbcJWXug==
UI-OutboundReport: notjunk:1;M01:P0:tdrQrkFQVzo=;+EPvbd8V15aH/Zh/1KB+dKDfkfb
 4EYN91bVo0JUNbsLtQKyZjd2WFVw1+PZqX200XOA/1cBgYK7+WJ2Lu2h6vA6u2tz9de9rYJLr
 hGXWOvzSfQaVJHZPb3Twn/fbHlPfe4hJcFQI5iBJtcw3Sp6hQGl0lND4X6Zd+EckA2X7xsK+0
 do7RKrbgsy0iz1bVBjdY9p40rmKIY+EAgD4j9A475dttBc6IdgSio/vFP37IneMlK/xPNmRDF
 iPAiWmCUljXJe+ltf5AeMK29lNYgRbkYL9+Oyxxr7tDcQV1b54PzoiRCy6rl6nQgrAepiNygf
 84ToYahnh4EFrHpPihBSrYBMr1Z0UA+sFS/qJuffskXPRTjk5j74syKBz+GipGXlpiRbw+bzF
 OTbTJWpHe8Wn8jGPQcNhmOsKEhHhAR6p8hHjmHqyyLfN6tw17CCLlE1PL4+DArAfvu9aiWpHO
 nQ8nvpbiRQeJnk0KwFw92Q10s9lGxo3kA0gV97/A9DRLN4hotcZd61kDovyhxBo//DqSOC1J+
 ckaSg6h7AxPbWueg2tqpIlioYNd0NgtUw0Zqc57QJpyrdvxUFUeJfKzh/6dL7l6T854vUTjy/
 4lBZaBMWXxSo0SHEUe9Xg2V9yWQoIiNXCSR2T2r4ItP7uCO2MOS0uLvkuRVMHEI3asOLwk8kj
 dUk1Am5HT1PZNE5S5mqBf0bunLp2EnWOmYGgJvvgiC5rokySakXGUFDfw+cVUhLCTJWtMEmln
 lqsbep4w2rwCj/NFpIwnkmcpZ4Ae8R1uS1AhkrWD440YDrZGUChgn6nwFfbnX6Qzr/FupnSzl
 23mFXjoCIYVFCOoRlmG53K0E/jvySRE89MhUpRf/aaJwKP3IkzTGWq/yUIE7sRAqAHipSd4Jq
 TcOerVe/QynDZTSlxJOEzobzpJe8en/T0FLXfuUGpfYSjkr4qRdywNMygQ2QiRW1qylvuwdfg
 FRw7AVb3ytf9ma7IpTnchhqqbYm5KST5ITBXxkOzrXKh7OrJtIkFJIgCVwTTD3YlZMelshKos
 oN/OjQ6M183qK3u1rVaxILSFecqgGF2Xs56z9FELsVFZOeD6NzSODlcYWz+iAJgAKsh11Kf5g
 I6QAb0YZ3b1qXbiOAmR2SzujpvyevK
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

On 06.12.24 23:54, Raymond Mao wrote:
> Add sysinfo platform driver for all armv8 platforms to retrieve
> hardware information on processor and cache.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes in v2
> - Combine with #8(v1) patch.
> - Remove the handling of the common strings and values.
> Changes in v3
> - None.
>
>   arch/arm/cpu/armv8/Makefile  |   2 +
>   arch/arm/cpu/armv8/sysinfo.c | 292 +++++++++++++++++++++++++++++++++++
>   2 files changed, 294 insertions(+)
>   create mode 100644 arch/arm/cpu/armv8/sysinfo.c
>
> diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
> index 2e71ff2dc97..b4126c61df1 100644
> --- a/arch/arm/cpu/armv8/Makefile
> +++ b/arch/arm/cpu/armv8/Makefile
> @@ -46,3 +46,5 @@ obj-$(CONFIG_TARGET_BCMNS3) +=3D bcmns3/
>   obj-$(CONFIG_XEN) +=3D xen/
>   obj-$(CONFIG_ARMV8_CE_SHA1) +=3D sha1_ce_glue.o sha1_ce_core.o
>   obj-$(CONFIG_ARMV8_CE_SHA256) +=3D sha256_ce_glue.o sha256_ce_core.o
> +
> +obj-$(CONFIG_SYSINFO_SMBIOS) +=3D sysinfo.o
> diff --git a/arch/arm/cpu/armv8/sysinfo.c b/arch/arm/cpu/armv8/sysinfo.c
> new file mode 100644
> index 00000000000..850142da37d
> --- /dev/null
> +++ b/arch/arm/cpu/armv8/sysinfo.c
> @@ -0,0 +1,292 @@
> +// SPDX-License-Identifier: GPL-2.0+

GPL-2.0-or-later
see https://spdx.org/licenses/LGPL-2.0-or-later.html

> +/*
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +#include <dm.h>
> +#include <smbios_plat.h>
> +#include <stdio.h>
> +#include <sysinfo.h>
> +
> +union ccsidr_el1 {
> +	struct {
> +		u64 linesize:3;
> +		u64 associativity:10;
> +		u64 numsets:15;
> +		u64 unknown:4;
> +		u64 reserved:32;
> +	} no_ccidx;
> +	struct {
> +		u64 linesize:3;
> +		u64 associativity:21;
> +		u64 reserved1:8;
> +		u64 numsets:24;
> +		u64 reserved2:8;
> +	} ccidx_aarch64;
> +	struct {
> +		u64 linesize:3;
> +		u64 associativity:21;
> +		u64 reserved:8;
> +		u64 unallocated:32;
> +	} ccidx_aarch32;
> +	u64 data;
> +};
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
> +	CACHE_NONE,
> +	CACHE_INST_ONLY,
> +	CACHE_DATA_ONLY,
> +	CACHE_INST_WITH_DATA,
> +	CACHE_UNIFIED,
> +};
> +
> +enum {
> +	CACHE_ASSOC_DIRECT_MAPPED =3D 1,
> +	CACHE_ASSOC_2WAY =3D 2,
> +	CACHE_ASSOC_4WAY =3D 4,
> +	CACHE_ASSOC_8WAY =3D 8,
> +	CACHE_ASSOC_16WAY =3D 16,
> +	CACHE_ASSOC_12WAY =3D 12,
> +	CACHE_ASSOC_24WAY =3D 24,
> +	CACHE_ASSOC_32WAY =3D 32,
> +	CACHE_ASSOC_48WAY =3D 48,
> +	CACHE_ASSOC_64WAY =3D 64,
> +	CACHE_ASSOC_20WAY =3D 20,
> +};
> +
> +enum {
> +	VENDOR_RESERVED =3D 0,
> +	VENDOR_ARM =3D 0x41,
> +	VENDOR_BROADCOM =3D 0x42,
> +	VENDOR_CAVIUM =3D 0x43,
> +	VENDOR_DEC =3D 0x44,
> +	VENDOR_FUJITSU =3D 0x46,
> +	VENDOR_INFINEON =3D 0x49,
> +	VENDOR_FREESCALE =3D 0x4d,
> +	VENDOR_NVIDIA =3D 0x4e,
> +	VENDOR_AMCC =3D 0x50,
> +	VENDOR_QUALCOMM =3D 0x51,
> +	VENDOR_MARVELL =3D 0x56,
> +	VENDOR_INTEL =3D 0x69,
> +	VENDOR_AMPERE =3D 0xc0,
> +};
> +
> +/*
> + * TODO:
> + * To support ARMv8.3, we need to read "CCIDX, bits [23:20]" from
> + * ID_AA64MMFR2_EL1 to get the format of CCSIDR_EL1:
> + *
> + * 0b0000 - 32-bit format implemented for all levels of the CCSIDR_EL1.
> + * 0b0001 - 64-bit format implemented for all levels of the CCSIDR_EL1.
> + *
> + * Here we assume to use CCSIDR_EL1 in no CCIDX layout:
> + * NumSets, bits [27:13]: (Number of sets in cache) - 1
> + * Associativity, bits [12:3]: (Associativity of cache) - 1
> + * LineSize, bits [2:0]: (Log2(Number of bytes in cache line)) - 4
> + */
> +int sysinfo_get_cache_info(u8 level, struct cache_info *cinfo)
> +{
> +	u64 clidr_el1;
> +	u32 csselr_el1;
> +	u32 num_sets;
> +	union ccsidr_el1 creg;
> +	int cache_type;
> +
> +	sysinfo_cache_info_default(cinfo);
> +
> +	/* Read CLIDR_EL1 */
> +	asm volatile("mrs %0, clidr_el1" : "=3Dr" (clidr_el1));
> +	debug("CLIDR_EL1: 0x%llx\n", clidr_el1);
> +
> +	cache_type =3D (clidr_el1 >> (3 * level)) & 0x7;
> +	if (cache_type =3D=3D CACHE_NONE) /* level does not exist */
> +		return -1;
> +
> +	switch (cache_type) {
> +	case CACHE_INST_ONLY:
> +		cinfo->cache_type =3D SMBIOS_CACHE_SYSCACHE_TYPE_INST;
> +		break;
> +	case CACHE_DATA_ONLY:
> +		cinfo->cache_type =3D SMBIOS_CACHE_SYSCACHE_TYPE_DATA;
> +		break;
> +	case CACHE_UNIFIED:
> +		cinfo->cache_type =3D SMBIOS_CACHE_SYSCACHE_TYPE_UNIFIED;
> +		break;
> +	case CACHE_INST_WITH_DATA:
> +		cinfo->cache_type =3D SMBIOS_CACHE_SYSCACHE_TYPE_OTHER;
> +		break;
> +	default:
> +		cinfo->cache_type =3D SMBIOS_CACHE_SYSCACHE_TYPE_UNKNOWN;
> +		break;
> +	}
> +
> +	/* Select cache level */
> +	csselr_el1 =3D (level << 1);
> +	asm volatile("msr csselr_el1, %0" : : "r" (csselr_el1));
> +
> +	/* Read CCSIDR_EL1 */
> +	asm volatile("mrs %0, ccsidr_el1" : "=3Dr" (creg.data));
> +	debug("CCSIDR_EL1 (Level %d): 0x%llx\n", level + 1, creg.data);
> +
> +	/* Extract cache size and associativity */
> +	cinfo->line_size =3D 1 << (creg.no_ccidx.linesize + 4);
> +
> +	/* Map the associativity value */
> +	switch (creg.no_ccidx.associativity + 1) {
> +	case CACHE_ASSOC_DIRECT_MAPPED:
> +		cinfo->associativity =3D SMBIOS_CACHE_ASSOC_DMAPPED;
> +		break;
> +	case CACHE_ASSOC_2WAY:
> +		cinfo->associativity =3D SMBIOS_CACHE_ASSOC_2WAY;
> +		break;
> +	case CACHE_ASSOC_4WAY:
> +		cinfo->associativity =3D SMBIOS_CACHE_ASSOC_4WAY;
> +		break;
> +	case CACHE_ASSOC_8WAY:
> +		cinfo->associativity =3D SMBIOS_CACHE_ASSOC_8WAY;
> +		break;
> +	case CACHE_ASSOC_16WAY:
> +		cinfo->associativity =3D SMBIOS_CACHE_ASSOC_16WAY;
> +		break;
> +	case CACHE_ASSOC_12WAY:
> +		cinfo->associativity =3D SMBIOS_CACHE_ASSOC_12WAY;
> +		break;
> +	case CACHE_ASSOC_24WAY:
> +		cinfo->associativity =3D SMBIOS_CACHE_ASSOC_24WAY;
> +		break;
> +	case CACHE_ASSOC_32WAY:
> +		cinfo->associativity =3D SMBIOS_CACHE_ASSOC_32WAY;
> +		break;
> +	case CACHE_ASSOC_48WAY:
> +		cinfo->associativity =3D SMBIOS_CACHE_ASSOC_48WAY;
> +		break;
> +	case CACHE_ASSOC_64WAY:
> +		cinfo->associativity =3D SMBIOS_CACHE_ASSOC_64WAY;
> +		break;
> +	case CACHE_ASSOC_20WAY:
> +		cinfo->associativity =3D SMBIOS_CACHE_ASSOC_20WAY;
> +		break;
> +	default:
> +		cinfo->associativity =3D SMBIOS_CACHE_ASSOC_UNKNOWN;
> +		break;
> +	}
> +
> +	num_sets =3D creg.no_ccidx.numsets + 1;
> +	/* Size in KB */
> +	cinfo->max_size =3D (cinfo->associativity * num_sets * cinfo->line_siz=
e) /
> +			  1024;
> +
> +	debug("L%d Cache:\n", level + 1);
> +	debug("Number of bytes in cache line:%u\n", cinfo->line_size);
> +	debug("Associativity of cache:%u\n", cinfo->associativity);
> +	debug("Number of sets in cache:%u\n", num_sets);
> +	debug("Cache size in KB:%u\n", cinfo->max_size);
> +
> +	cinfo->inst_size =3D cinfo->max_size;
> +
> +	/*
> +	 * Below fields with common values are placed under DT smbios node

As I have seen nodes /smbios and /smbios/smbios, please, be specific. Do
you mean:

The following properties are provided in the /smbios device-tree node:

> +	 * socket-design, config
> +	 * Other fields are typically specific to the implementation of the AR=
M
> +	 * processor by the silicon vendor:
> +	 * supp_sram_type, curr_sram_type, speed, err_corr_type

It is not clear what you mean.

Don't these properties appear in the /smbios node? Where would they be
found?

> +	 */
> +
> +	return 0;
> +}
> +
> +int sysinfo_get_processor_info(struct processor_info *pinfo)
> +{
> +	u64 mpidr, core_count;
> +	union midr_el1 midr;
> +
> +	/* Read the MIDR_EL1 register */
> +	asm volatile("mrs %0, MIDR_EL1" : "=3Dr"(midr.data));
> +	/* Read the MPIDR_EL1 register */
> +	asm volatile("mrs %0, MPIDR_EL1" : "=3Dr"(mpidr));
> +
> +	debug("MIDR: 0x%016llx\n", midr.data);
> +	debug("MPIDR: 0x%016llx\n", mpidr);
> +	debug("CPU Implementer: 0x%02x\n", midr.fields.implementer);
> +
> +	switch (midr.fields.implementer) {
> +	case VENDOR_ARM:
> +		pinfo->manufacturer =3D "ARM Limited";
> +		break;
> +	case VENDOR_BROADCOM:
> +		pinfo->manufacturer =3D "Broadcom Corporation";
> +		break;
> +	case VENDOR_CAVIUM:
> +		pinfo->manufacturer =3D "Cavium Inc";
> +		break;
> +	case VENDOR_DEC:
> +		pinfo->manufacturer =3D "Digital Equipment Corporation";
> +		break;
> +	case VENDOR_FUJITSU:
> +		pinfo->manufacturer =3D "Fujitsu Ltd";
> +		break;
> +	case VENDOR_INFINEON:
> +		pinfo->manufacturer =3D "Infineon Technologies AG";
> +		break;
> +	case VENDOR_FREESCALE:
> +		pinfo->manufacturer =3D "Freescale Semiconductor Inc";
> +		break;
> +	case VENDOR_NVIDIA:
> +		pinfo->manufacturer =3D "NVIDIA Corporation";
> +		break;
> +	case VENDOR_AMCC:
> +		pinfo->manufacturer =3D
> +			"Applied Micro Circuits Corporation";
> +		break;
> +	case VENDOR_QUALCOMM:
> +		pinfo->manufacturer =3D "Qualcomm Inc";
> +		break;
> +	case VENDOR_MARVELL:
> +		pinfo->manufacturer =3D "Marvell International Ltd";
> +		break;
> +	case VENDOR_INTEL:
> +		pinfo->manufacturer =3D "Intel Corporation";
> +		break;
> +	case VENDOR_AMPERE:
> +		pinfo->manufacturer =3D "Ampere Computing";
> +		break;
> +	default:
> +		pinfo->manufacturer =3D "Unknown";

Should we write the numerical number to a string here? E.g.

'Manufacturer %d'

> +		break;
> +	}
> +	debug("CPU part number: 0x%x\n", midr.fields.partnum);
> +	debug("CPU revision: 0x%x\n", midr.fields.revision);
> +	debug("CPU architecture: 0x%x\n", midr.fields.architecture);
> +	debug("CPU variant: 0x%x\n", midr.fields.variant);
> +
> +	/* Extract number of cores */
> +	core_count =3D (mpidr >> 0) & 0xFF;
> +	pinfo->core_count =3D core_count + 1;
> +	debug("CPU Core Count: %d\n", pinfo->core_count);
> +
> +	pinfo->core_enabled =3D pinfo->core_count;
> +	pinfo->characteristics =3D SMBIOS_PROCESSOR_64BIT |
> +		SMBIOS_PROCESSOR_ARM64_SOCID;
> +	if (pinfo->core_count > 1)
> +		pinfo->characteristics |=3D SMBIOS_PROCESSOR_MULTICORE;
> +
> +	/*
> +	 * Below fields with common values are placed under DT smbios node
> +	 * version, processor-type, processor-status, upgrade, family2,
> +	 * socket-design, serial, asset-tag, part-number

The following properties are provided in the /smbios device-tree node:

Best regards

Heinrich

> +	 */
> +
> +	return 0;
> +}

