Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EA1CD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 10:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C111E839D5;
	Sun, 16 Nov 2025 11:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rk5u4iKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58C52839A8; Sun, 16 Nov 2025 11:46:00 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73DE8839D5
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 11:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763289956; x=1763894756; i=xypron.glpk@gmx.de;
 bh=p5aqV9zrRDZg2fBqxBPaHAN7fQfZe3hRz8B6cwP2T3I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rk5u4iKrOTz3l1WYbHRnt0xng6h1LhiGdHP6YvQuypB2GNAMWErmVDqsrto2HEU8
 AM868rQPvC59qKHNXvvoPXT+m5qPTQz4i8lJJkzAi5e9Nxjzf24Iy+vhIDxnfleCJ
 SwEXDgf7pHj2r0A3rG/8iRzrbZP8eSc85sqylEbAEvOX3oYrfQB91NN+4UUfefmpK
 kYjnGa+yh+JOeWZcOXfxZSe3yxdQnVP44Mk0AT1bGeCM9iAw+2W5vJfsgwqzyJ60I
 PzZ+6IYF2ixESyLIV5x0JIk5dEVgxv7Iyrd0+Hiz3PUMsu3IO2HDfI6/gblMDJddv
 WRGmQKGpXZK2ftqzlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbEp-1vTcXf1b2R-0004b6; Sun, 16
 Nov 2025 11:45:56 +0100
Message-ID: <28fbbe20-4394-4640-9c20-da2107fb4c2a@gmx.de>
Date: Sun, 16 Nov 2025 11:45:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] smbios: add support for dynamic generation of Type
 17 table
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>,
 Simon Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Samuel Holland <samuel.holland@sifive.com>, u-boot@lists.denx.de
References: <20251114170615.17698-1-raymondmaoca@gmail.com>
 <20251114170615.17698-4-raymondmaoca@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251114170615.17698-4-raymondmaoca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:REZ1pkylqXsT1y/wc6qgYnH7GHdKkhsNckRLoQipPBJn1OM9RGu
 gLUPcZRx+6k/BlPrK7ZrJsaIAhfNFQnheGTO48XIEGK/5oJXmvTsjeHcHvY4NEi9Vq2M1r2
 qT/BHSSA2z/RqIZ2CSoSQQ8MozeTGsurGmtUQKXHub3QDEevTqrSOeVfVcLcrpMZyckvDTs
 PITK1WGaesntsBuer6Vrg==
UI-OutboundReport: notjunk:1;M01:P0:QK+IjW3v8l0=;G7ABA0QiHIbPXAf/EjfL4aPf12/
 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
 K04Cum4mtC9rlRY8oKW8
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

On 11/14/25 18:06, Raymond Mao wrote:
> This commit implements SMBIOS Type 17 (Memory Device) generation with a
> hybrid approach supporting both:
>=20
> 1. Explicit definition via Device Tree 'smbios' node:
>     Child node under '/smbios/smbios/memory-device' will be used to
>     populate as individual Type 17 structure directly.
>     - Properties follow SMBIOS field names with lowercase letters and
>       hyphen-separated words (e.g., 'physical-memory-array-handle',
>       ' memory-error-information-handle', 'configured-memory-speed', etc=
.).
>     - This method supports precise platform-defined overrides and system
>       descriptions.
>=20
> 2. Fallback to automatic DT-based discovery:
>     If child node under '/smbios/smbios/memory-device' does not exist,
>     the implementation will:
>     - Scan all top-level 'memory@' nodes to populate Type 17 structure w=
ith
>       inferred size and location data.
>     - Scan nodes named or marked as 'memory-controller' and parse
>       associated 'dimm@' subnodes (if present) to extract DIMM sizes and
>       map them accordingly.
>=20
> This dual-mode support enables flexible firmware SMBIOS reporting while
> aligning with spec-compliant naming and runtime-detected memory topology=
.
>=20
> Type 17 support is under GENERATE_SMBIOS_TABLE_VERBOSE to avoid
> increasing rom size for those platforms which only require basic SMBIOS
> support.
>=20
> Signed-off-by: Raymond Mao <raymondmaoca@gmail.com>
> ---
> Changes in v4:
> - Initial patch.
>=20
>   arch/arm/dts/smbios_generic.dtsi |   3 +
>   cmd/smbios.c                     | 126 +++++++++++
>   include/smbios.h                 |  45 ++++
>   include/smbios_def.h             | 127 +++++++++++
>   lib/smbios.c                     | 377 +++++++++++++++++++++++++++++++
>   5 files changed, 678 insertions(+)
>=20
> diff --git a/arch/arm/dts/smbios_generic.dtsi b/arch/arm/dts/smbios_gene=
ric.dtsi
> index 1a9adfaa409..fd2df8d02e0 100644
> --- a/arch/arm/dts/smbios_generic.dtsi
> +++ b/arch/arm/dts/smbios_generic.dtsi
> @@ -83,6 +83,9 @@
>  =20
>   			memory-array {
>   			};
> +
> +			memory-device {
> +			};
>   		};
>   	};
>   };
> diff --git a/cmd/smbios.c b/cmd/smbios.c
> index 3f7dd21f92e..39c9c44a28e 100644
> --- a/cmd/smbios.c
> +++ b/cmd/smbios.c
> @@ -194,6 +194,74 @@ static const struct str_lookup_table ma_err_corr_st=
rings[] =3D {
>   	{ SMBIOS_MA_ERRCORR_CRC,	"CRC" },
>   };
>  =20
> +static const struct str_lookup_table md_form_factor_strings[] =3D {
> +	{ SMBIOS_MD_FF_OTHER,		"Other" },
> +	{ SMBIOS_MD_FF_UNKNOWN,		"Unknown" },
> +	{ SMBIOS_MD_FF_SIMM,		"SIMM" },
> +	{ SMBIOS_MD_FF_SIP,		"SIP" },
> +	{ SMBIOS_MD_FF_CHIP,		"Chip" },
> +	{ SMBIOS_MD_FF_DIP,		"DIP" },
> +	{ SMBIOS_MD_FF_ZIP,		"ZIP" },
> +	{ SMBIOS_MD_FF_PROPCARD,	"Proprietary Card" },
> +	{ SMBIOS_MD_FF_DIMM,		"DIMM" },
> +	{ SMBIOS_MD_FF_TSOP,		"TSOP" },
> +	{ SMBIOS_MD_FF_ROC,		"Row of chips" },
> +	{ SMBIOS_MD_FF_RIMM,		"RIMM" },
> +	{ SMBIOS_MD_FF_SODIMM,		"SODIMM" },
> +	{ SMBIOS_MD_FF_SRIMM,		"SRIMM" },
> +	{ SMBIOS_MD_FF_FBDIMM,		"FB-DIMM" },
> +	{ SMBIOS_MD_FF_DIE,		"Die" },
> +};
> +
> +static const struct str_lookup_table md_type_strings[] =3D {
> +	{ SMBIOS_MD_TYPE_OTHER,		"Other" },
> +	{ SMBIOS_MD_TYPE_UNKNOWN,	"Unknown" },
> +	{ SMBIOS_MD_TYPE_DRAM,		"DRAM" },
> +	{ SMBIOS_MD_TYPE_EDRAM,		"EDRAM" },
> +	{ SMBIOS_MD_TYPE_VRAM,		"VRAM" },
> +	{ SMBIOS_MD_TYPE_SRAM,		"SRAM" },
> +	{ SMBIOS_MD_TYPE_RAM,		"RAM" },
> +	{ SMBIOS_MD_TYPE_ROM,		"ROM" },
> +	{ SMBIOS_MD_TYPE_FLASH,		"FLASH" },
> +	{ SMBIOS_MD_TYPE_EEPROM,	"EEPROM" },
> +	{ SMBIOS_MD_TYPE_FEPROM,	"FEPROM" },
> +	{ SMBIOS_MD_TYPE_EPROM,		"EPROM" },
> +	{ SMBIOS_MD_TYPE_CDRAM,		"CDRAM" },
> +	{ SMBIOS_MD_TYPE_3DRAM,		"3DRAM" },
> +	{ SMBIOS_MD_TYPE_SDRAM,		"SDRAM" },
> +	{ SMBIOS_MD_TYPE_SGRAM,		"SGRAM" },
> +	{ SMBIOS_MD_TYPE_RDRAM,		"RDRAM" },
> +	{ SMBIOS_MD_TYPE_DDR,		"DDR" },
> +	{ SMBIOS_MD_TYPE_DDR2,		"DDR2" },
> +	{ SMBIOS_MD_TYPE_DDR2FBD,	"DDR2 FB-DIMM" },
> +	{ SMBIOS_MD_TYPE_RSVD1,		"Reserved" },
> +	{ SMBIOS_MD_TYPE_RSVD2,		"Reserved" },
> +	{ SMBIOS_MD_TYPE_DSVD3,		"Reserved" },
> +	{ SMBIOS_MD_TYPE_DDR3,		"DDR3" },
> +	{ SMBIOS_MD_TYPE_FBD2,		"FBD2" },
> +	{ SMBIOS_MD_TYPE_DDR4,		"DDR4" },
> +	{ SMBIOS_MD_TYPE_LPDDR,		"LPDDR" },
> +	{ SMBIOS_MD_TYPE_LPDDR2,	"LPDDR2" },
> +	{ SMBIOS_MD_TYPE_LPDDR3,	"LPDDR3" },
> +	{ SMBIOS_MD_TYPE_LPDDR4,	"LPDDR4" },
> +	{ SMBIOS_MD_TYPE_LNVD,		"Logical non-volatile device" },
> +	{ SMBIOS_MD_TYPE_HBM,		"HBM" },
> +	{ SMBIOS_MD_TYPE_HBM2,		"HBM2" },
> +	{ SMBIOS_MD_TYPE_DDR5,		"DDR5" },
> +	{ SMBIOS_MD_TYPE_LPDDR5,	"LPDDR5" },
> +	{ SMBIOS_MD_TYPE_HBM3,		"HBM3" },
> +};
> +
> +static const struct str_lookup_table md_tech_strings[] =3D {
> +	{ SMBIOS_MD_TECH_OTHER,		"Other" },
> +	{ SMBIOS_MD_TECH_UNKNOWN,	"Unknown" },
> +	{ SMBIOS_MD_TECH_DRAM,		"DRAM" },
> +	{ SMBIOS_MD_TECH_NVDIMMN,	"NVDIMM-N" },
> +	{ SMBIOS_MD_TECH_NVDIMMF,	"NVDIMM-F" },
> +	{ SMBIOS_MD_TECH_NVDIMMP,	"NVDIMM-P" },
> +	{ SMBIOS_MD_TECH_OPTANE,	"Intel Optane persistent memory" },
> +};
> +
>   /**
>    * smbios_get_string() - get SMBIOS string from table
>    *
> @@ -557,6 +625,61 @@ static void smbios_print_type16(struct smbios_type1=
6 *table)
>   	printf("\tExtended Maximum Capacity: 0x%016llx\n", table->ext_max_cap=
);
>   }
>  =20
> +static void smbios_print_type17(struct smbios_type17 *table)
> +{
> +	printf("Memory Device:\n");
> +	printf("\tPhysical Memory Array Handle: 0x%04x\n",
> +	       table->phy_mem_array_hdl);
> +	printf("\tMemory Error Information Handle: 0x%04x\n",
> +	       table->mem_err_info_hdl);
> +	printf("\tTotal Width: 0x%04x\n", table->total_width);
> +	printf("\tData Width: 0x%04x\n", table->data_width);
> +	printf("\tSize: 0x%04x\n", table->size);
> +	smbios_print_lookup_str(md_form_factor_strings, table->form_factor,
> +				ARRAY_SIZE(md_form_factor_strings),
> +				"Form Factor");
> +	printf("\tDevice Set: 0x%04x\n", table->dev_set);
> +	smbios_print_str("Device Locator", table, table->dev_locator);
> +	smbios_print_str("Bank Locator", table, table->bank_locator);
> +	smbios_print_lookup_str(md_type_strings, table->mem_type,
> +				ARRAY_SIZE(md_type_strings), "Memory Type");
> +	printf("\tType Detail: 0x%04x\n", table->type_detail);
> +	printf("\tSpeed: 0x%04x\n", table->speed);
> +	smbios_print_str("Manufacturer", table, table->manufacturer);
> +	smbios_print_str("Serial Number", table, table->serial_number);
> +	smbios_print_str("Asset Tag", table, table->asset_tag);
> +	smbios_print_str("Part Number", table, table->part_number);
> +	printf("\tAttributes: 0x%04x\n", table->attributes);
> +	printf("\tExtended Size: 0x%08x\n", table->ext_size);
> +	printf("\tConfigured Memory Speed: 0x%04x\n", table->config_mem_speed)=
;
> +	printf("\tMinimum voltage: 0x%04x\n", table->min_voltage);
> +	printf("\tMaximum voltage: 0x%04x\n", table->max_voltage);
> +	printf("\tConfigured voltage: 0x%04x\n", table->config_voltage);


When using QFW QEMU provides the SMBIOS table. It currently uses SMBIOS=20
version 3.0. The fields below where introduced with version 3.2. So you=20
are causing a buffer overrun here.

[PATCH 1/1] cmd: smbios: correct output for table type 4
https://lists.denx.de/pipermail/u-boot/2025-November/603413.html
starts introducing version checks to avoid buffer overruns.

Best regards

Heinrich


> +	smbios_print_lookup_str(md_tech_strings, table->mem_tech,
> +				ARRAY_SIZE(md_tech_strings),
> +				"Memory Technology");
> +	printf("\tMemory Operating Mode Capability: 0x%04x\n",
> +	       table->mem_op_mode_cap);
> +	smbios_print_str("Firmware Version", table, table->fw_ver);
> +	printf("\tModule Manufacturer ID: 0x%04x\n", table->module_man_id);
> +	printf("\tModule Product ID: 0x%04x\n", table->module_prod_id);
> +	printf("\tMemory Subsystem Controller Manufacturer ID: 0x%04x\n",
> +	       table->mem_subsys_con_man_id);
> +	printf("\tMemory Subsystem Controller Product ID: 0x%04x\n",
> +	       table->mem_subsys_con_prod_id);
> +	printf("\tNon-volatile Size: 0x%016llx\n", table->nonvolatile_size);
> +	printf("\tVolatile Size: 0x%016llx\n", table->volatile_size);
> +	printf("\tCache Size: 0x%016llx\n", table->cache_size);
> +	printf("\tLogical Size: 0x%016llx\n", table->logical_size);
> +	printf("\tExtended Speed: 0x%04x\n", table->ext_speed);
> +	printf("\tExtended Configured Memory Speed: 0x%04x\n",
> +	       table->ext_config_mem_speed);
> +	printf("\tPMIC0 Manufacturer ID: 0x%04x\n", table->pmic0_man_id);
> +	printf("\tPMIC0 Revision Number: 0x%04x\n", table->pmic0_rev_num);
> +	printf("\tRCD Manufacturer ID: 0x%04x\n", table->rcd_man_id);
> +	printf("\tRCD Revision Number: 0x%04x\n", table->rcd_rev_num);
> +}
> +
>   static void smbios_print_type127(struct smbios_type127 *table)
>   {
>   	printf("End Of Table\n");
> @@ -642,6 +765,9 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag=
, int argc,
>   		case SMBIOS_PHYS_MEMORY_ARRAY:
>   			smbios_print_type16((struct smbios_type16 *)pos);
>   			break;
> +		case SMBIOS_MEMORY_DEVICE:
> +			smbios_print_type17((struct smbios_type17 *)pos);
> +			break;
>   		case SMBIOS_END_OF_TABLE:
>   			smbios_print_type127((struct smbios_type127 *)pos);
>   			break;
> diff --git a/include/smbios.h b/include/smbios.h
> index 16438c059c7..45131416253 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -327,6 +327,51 @@ struct __packed smbios_type16 {
>   	u64 ext_max_cap;
>   	char eos[SMBIOS_STRUCT_EOS_BYTES];
>   };
> +
> +struct __packed smbios_type17 {
> +	struct smbios_header hdr;
> +	u16 phy_mem_array_hdl;
> +	u16 mem_err_info_hdl;
> +	u32 total_width;
> +	u32 data_width;
> +	u16 size;
> +	u8 form_factor;
> +	u8 dev_set;
> +	u8 dev_locator;
> +	u8 bank_locator;
> +	u8 mem_type;
> +	u16 type_detail;
> +	u16 speed;
> +	u8 manufacturer;
> +	u8 serial_number;
> +	u8 asset_tag;
> +	u8 part_number;
> +	u8 attributes;
> +	u32 ext_size;
> +	u16 config_mem_speed;
> +	u16 min_voltage;
> +	u16 max_voltage;
> +	u16 config_voltage;
> +	u8 mem_tech;
> +	u16 mem_op_mode_cap;
> +	u8 fw_ver;
> +	u16 module_man_id;
> +	u16 module_prod_id;
> +	u16 mem_subsys_con_man_id;
> +	u16 mem_subsys_con_prod_id;
> +	u64 nonvolatile_size;
> +	u64 volatile_size;
> +	u64 cache_size;
> +	u64 logical_size;
> +	u32 ext_speed;
> +	u32 ext_config_mem_speed;
> +	u16 pmic0_man_id;
> +	u16 pmic0_rev_num;
> +	u16 rcd_man_id;
> +	u16 rcd_rev_num;
> +	char eos[SMBIOS_STRUCT_EOS_BYTES];
> +};
> +
>   struct __packed smbios_type32 {
>   	u8 type;
>   	u8 length;
> diff --git a/include/smbios_def.h b/include/smbios_def.h
> index c6850a5d6f5..ce913f2f32a 100644
> --- a/include/smbios_def.h
> +++ b/include/smbios_def.h
> @@ -309,4 +309,131 @@
>   #define SMBIOS_MA_ERRINFO_NONE		0xFFFE
>   #define SMBIOS_MA_ERRINFO_NOERR		0xFFFF
>  =20
> +/* Memory Device */
> +
> +/* Size */
> +
> +#define SMBIOS_MD_SIZE_UNKNOWN	0xFFFF
> +#define SMBIOS_MD_SIZE_EXT	0x7FFF
> +
> +/* Form Factor */
> +#define SMBIOS_MD_FF_OTHER	1
> +#define SMBIOS_MD_FF_UNKNOWN	2
> +#define SMBIOS_MD_FF_SIMM	3
> +#define SMBIOS_MD_FF_SIP	4
> +#define SMBIOS_MD_FF_CHIP	5
> +#define SMBIOS_MD_FF_DIP	6
> +#define SMBIOS_MD_FF_ZIP	7
> +#define SMBIOS_MD_FF_PROPCARD	8
> +#define SMBIOS_MD_FF_DIMM	9
> +#define SMBIOS_MD_FF_TSOP	10
> +#define SMBIOS_MD_FF_ROC	11
> +#define SMBIOS_MD_FF_RIMM	12
> +#define SMBIOS_MD_FF_SODIMM	13
> +#define SMBIOS_MD_FF_SRIMM	14
> +#define SMBIOS_MD_FF_FBDIMM	15
> +#define SMBIOS_MD_FF_DIE	16
> +
> +/* Device set */
> +#define SMBIOS_MD_DEVSET_NONE		0
> +#define SMBIOS_MD_DEVSET_UNKNOWN	0xFF
> +
> +/* Speed */
> +#define SMBIOS_MD_SPEED_UNKNOWN	0
> +#define SMBIOS_MD_SPEED_EXT	0xFFFF
> +
> +/* Attributes */
> +#define SMBIOS_MD_ATTR_RANK_UNKNOWN	0
> +
> +/* Configured Memory Speed */
> +#define SMBIOS_MD_CONFSPEED_UNKNOWN	0
> +#define SMBIOS_MD_CONFSPEED_EXT		0xFFFF
> +
> +/* Voltage */
> +#define SMBIOS_MD_VOLTAGE_UNKNOWN	0
> +
> +/* Type */
> +#define SMBIOS_MD_TYPE_OTHER	1
> +#define SMBIOS_MD_TYPE_UNKNOWN	2
> +#define SMBIOS_MD_TYPE_DRAM	3
> +#define SMBIOS_MD_TYPE_EDRAM	4
> +#define SMBIOS_MD_TYPE_VRAM	5
> +#define SMBIOS_MD_TYPE_SRAM	6
> +#define SMBIOS_MD_TYPE_RAM	7
> +#define SMBIOS_MD_TYPE_ROM	8
> +#define SMBIOS_MD_TYPE_FLASH	9
> +#define SMBIOS_MD_TYPE_EEPROM	10
> +#define SMBIOS_MD_TYPE_FEPROM	11
> +#define SMBIOS_MD_TYPE_EPROM	12
> +#define SMBIOS_MD_TYPE_CDRAM	13
> +#define SMBIOS_MD_TYPE_3DRAM	14
> +#define SMBIOS_MD_TYPE_SDRAM	15
> +#define SMBIOS_MD_TYPE_SGRAM	16
> +#define SMBIOS_MD_TYPE_RDRAM	17
> +#define SMBIOS_MD_TYPE_DDR	18
> +#define SMBIOS_MD_TYPE_DDR2	19
> +#define SMBIOS_MD_TYPE_DDR2FBD	20
> +#define SMBIOS_MD_TYPE_RSVD1	21
> +#define SMBIOS_MD_TYPE_RSVD2	22
> +#define SMBIOS_MD_TYPE_DSVD3	23
> +#define SMBIOS_MD_TYPE_DDR3	24
> +#define SMBIOS_MD_TYPE_FBD2	25
> +#define SMBIOS_MD_TYPE_DDR4	26
> +#define SMBIOS_MD_TYPE_LPDDR	27
> +#define SMBIOS_MD_TYPE_LPDDR2	28
> +#define SMBIOS_MD_TYPE_LPDDR3	29
> +#define SMBIOS_MD_TYPE_LPDDR4	30
> +#define SMBIOS_MD_TYPE_LNVD	31
> +#define SMBIOS_MD_TYPE_HBM	32
> +#define SMBIOS_MD_TYPE_HBM2	33
> +#define SMBIOS_MD_TYPE_DDR5	34
> +#define SMBIOS_MD_TYPE_LPDDR5	35
> +#define SMBIOS_MD_TYPE_HBM3	36
> +
> +/* Type Detail */
> +#define SMBIOS_MD_TD_RSVD	1 /* BIT(0), set to 0 */
> +#define SMBIOS_MD_TD_OTHER	2 /* BIT(1) */
> +#define SMBIOS_MD_TD_UNKNOWN	4 /* BIT(2) */
> +#define SMBIOS_MD_TD_FP		8 /* BIT(3) */
> +#define SMBIOS_MD_TD_SC		0x10 /* BIT(4) */
> +#define SMBIOS_MD_TD_PS		0x20 /* BIT(5) */
> +#define SMBIOS_MD_TD_RAMBUS	0x40 /* BIT(6) */
> +#define SMBIOS_MD_TD_SYNC	0x80 /* BIT(7) */
> +#define SMBIOS_MD_TD_CMOS	0x100 /* BIT(8) */
> +#define SMBIOS_MD_TD_EDO	0x200 /* BIT(9) */
> +#define SMBIOS_MD_TD_WINDRAM	0x400 /* BIT(10) */
> +#define SMBIOS_MD_TD_CACHEDRAM	0x800 /* BIT(11) */
> +#define SMBIOS_MD_TD_NV		0x1000 /* BIT(12) */
> +#define SMBIOS_MD_TD_RGSTD	0x2000 /* BIT(13) */
> +#define SMBIOS_MD_TD_UNRGSTD	0x4000 /* BIT(14) */
> +#define SMBIOS_MD_TD_LRDIMM	0x8000 /* BIT(15) */
> +
> +/* Technology */
> +#define SMBIOS_MD_TECH_OTHER	1
> +#define SMBIOS_MD_TECH_UNKNOWN	2
> +#define SMBIOS_MD_TECH_DRAM	3
> +#define SMBIOS_MD_TECH_NVDIMMN	4
> +#define SMBIOS_MD_TECH_NVDIMMF	5
> +#define SMBIOS_MD_TECH_NVDIMMP	6
> +#define SMBIOS_MD_TECH_OPTANE	7
> +
> +/* Operating Mode Capability */
> +#define SMBIOS_MD_OPMC_RSVD	1 /* BIT(0), set to 0 */
> +#define SMBIOS_MD_OPMC_OTHER	2 /* BIT(1) */
> +#define SMBIOS_MD_OPMC_UNKNOWN	4 /* BIT(2) */
> +#define SMBIOS_MD_OPMC_VM	8 /* BIT(3) */
> +#define SMBIOS_MD_OPMC_BYTEAPM	0x10 /* BIT(4) */
> +#define SMBIOS_MD_OPMC_BLKAPM	0x20 /* BIT(5) */
> +/* Bit 6:15 Reserved, set to 0 */
> +
> +/* Non-volatile / Volatile / Cache / Logical portion Size */
> +#define SMBIOS_MD_PORT_SIZE_NONE	0
> +#define SMBIOS_MD_PORT_SIZE_UNKNOWN_HI	0xFFFFFFFF
> +#define SMBIOS_MD_PORT_SIZE_UNKNOWN_LO	0xFFFFFFFF
> +#define SMBIOS_MS_PORT_SIZE_UNKNOWN	0xFFFFFFFFFFFFFFFF
> +
> +/* Error Information Handle */
> +#define SMBIOS_MD_ERRINFO_NONE		0xFFFE
> +#define SMBIOS_MD_ERRINFO_NOERR		0xFFFF
> +
>   #endif /* _SMBIOS_DEF_H_ */
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 27c9c975cf2..8a3fa42cef5 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -135,6 +135,14 @@ typedef int (*smbios_write_subnode)(ulong *current,=
 int handle,
>   				   struct smbios_ctx *ctx, int idx,
>   				   int type);
>  =20
> +typedef int (*smbios_write_memnode)(ulong *current, int handle,
> +				    struct smbios_ctx *ctx, int idx,
> +				    int type);
> +
> +typedef int (*smbios_write_memctrlnode)(ulong *current, int handle,
> +				      struct smbios_ctx *ctx, int idx,
> +				      u64 base, u64 sz);
> +
>   /**
>    * Function prototype to write a specific type of SMBIOS structure
>    *
> @@ -1432,6 +1440,374 @@ static int smbios_write_type16(ulong *current, i=
nt *handle,
>   	return len;
>   }
>  =20
> +static void smbios_pop_type17_general_si(struct smbios_ctx *ctx,
> +					 struct smbios_type17 *t)
> +{
> +	t->mem_err_info_hdl =3D
> +		smbios_get_val_si(ctx, "memory-error-information-handle",
> +				  SYSID_NONE, SMBIOS_MD_ERRINFO_NONE);
> +	t->total_width =3D smbios_get_val_si(ctx, "total-width", SYSID_NONE, 0=
);
> +	t->data_width =3D smbios_get_val_si(ctx, "data-width", SYSID_NONE, 0);
> +	t->form_factor =3D smbios_get_val_si(ctx, "form-factor",
> +					   SYSID_NONE, SMBIOS_MD_FF_UNKNOWN);
> +	t->dev_set =3D smbios_get_val_si(ctx, "device-set", SYSID_NONE,
> +				       SMBIOS_MD_DEVSET_UNKNOWN);
> +	t->data_width =3D smbios_get_val_si(ctx, "data-width", SYSID_NONE, 0);
> +	t->dev_locator =3D smbios_add_prop_si(ctx, "device-locator", SYSID_NON=
E,
> +					    NULL);
> +	t->bank_locator =3D smbios_add_prop_si(ctx, "bank-locator", SYSID_NONE=
,
> +					     NULL);
> +	t->mem_type =3D smbios_get_val_si(ctx, "memory-type",
> +					SYSID_NONE, SMBIOS_MD_TYPE_UNKNOWN);
> +	t->type_detail =3D smbios_get_val_si(ctx, "type-detail",
> +					   SYSID_NONE, SMBIOS_MD_TD_UNKNOWN);
> +	t->speed =3D smbios_get_val_si(ctx, "speed", SYSID_NONE,
> +				     SMBIOS_MD_SPEED_UNKNOWN);
> +	t->manufacturer =3D smbios_add_prop_si(ctx, "manufacturer", SYSID_NONE=
,
> +					     NULL);
> +	t->serial_number =3D smbios_add_prop_si(ctx, "serial-number", SYSID_NO=
NE,
> +					      NULL);
> +	t->asset_tag =3D smbios_add_prop_si(ctx, "asset-tag", SYSID_NONE, NULL=
);
> +	t->part_number =3D smbios_add_prop_si(ctx, "part-number", SYSID_NONE,
> +					    NULL);
> +	t->attributes =3D smbios_get_val_si(ctx, "attributes", SYSID_NONE,
> +					  SMBIOS_MD_ATTR_RANK_UNKNOWN);
> +	t->config_mem_speed =3D smbios_get_val_si(ctx, "configured-memory-spee=
d",
> +						SYSID_NONE,
> +						SMBIOS_MD_CONFSPEED_UNKNOWN);
> +	t->min_voltage =3D smbios_get_val_si(ctx, "minimum-voltage", SYSID_NON=
E,
> +					   SMBIOS_MD_VOLTAGE_UNKNOWN);
> +	t->max_voltage =3D smbios_get_val_si(ctx, "maximum-voltage", SYSID_NON=
E,
> +					   SMBIOS_MD_VOLTAGE_UNKNOWN);
> +	t->config_voltage =3D smbios_get_val_si(ctx, "configured-voltage",
> +					      SYSID_NONE,
> +					      SMBIOS_MD_VOLTAGE_UNKNOWN);
> +	t->mem_tech =3D smbios_get_val_si(ctx, "memory-technology",
> +					SYSID_NONE, SMBIOS_MD_TECH_UNKNOWN);
> +	t->mem_op_mode_cap =3D
> +		smbios_get_val_si(ctx, "memory-operating-mode-capability",
> +				  SYSID_NONE, SMBIOS_MD_OPMC_UNKNOWN);
> +	t->fw_ver =3D smbios_add_prop_si(ctx, "firmware-version", SYSID_NONE,
> +				       NULL);
> +	t->module_man_id =3D smbios_get_val_si(ctx, "module-manufacturer-id",
> +					     SYSID_NONE, 0);
> +	t->module_prod_id =3D smbios_get_val_si(ctx, "module-product-id",
> +					      SYSID_NONE, 0);
> +	t->mem_subsys_con_man_id =3D
> +		smbios_get_val_si(ctx,
> +				  "memory-subsystem-controller-manufacturer-id",
> +				  SYSID_NONE, 0);
> +	t->mem_subsys_con_prod_id =3D
> +		smbios_get_val_si(ctx,
> +				  "memory-subsystem-controller-product-id",
> +				  SYSID_NONE, 0);
> +	t->nonvolatile_size =3D smbios_get_u64_si(ctx, "non-volatile-size",
> +						SYSID_NONE,
> +						SMBIOS_MS_PORT_SIZE_UNKNOWN);
> +	t->volatile_size =3D smbios_get_u64_si(ctx, "volatile-size",
> +					     SYSID_NONE,
> +					     SMBIOS_MS_PORT_SIZE_UNKNOWN);
> +	t->cache_size =3D smbios_get_u64_si(ctx, "cache-size",
> +					  SYSID_NONE,
> +					  SMBIOS_MS_PORT_SIZE_UNKNOWN);
> +	t->logical_size =3D smbios_get_u64_si(ctx, "logical-size",
> +					    SYSID_NONE,
> +					    SMBIOS_MS_PORT_SIZE_UNKNOWN);
> +	t->ext_speed =3D smbios_get_val_si(ctx, "extended-speed", SYSID_NONE, =
0);
> +	t->ext_config_mem_speed =3D
> +		smbios_get_val_si(ctx, "extended-configured-memory-speed",
> +				  SYSID_NONE, 0);
> +	t->pmic0_man_id =3D smbios_get_val_si(ctx, "pmic0-manufacturer-id",
> +					    SYSID_NONE, 0);
> +	t->pmic0_rev_num =3D smbios_get_val_si(ctx, "pmic0-revision-number",
> +					     SYSID_NONE, 0);
> +	t->rcd_man_id =3D smbios_get_val_si(ctx, "rcd-manufacturer-id",
> +					  SYSID_NONE, 0);
> +	t->rcd_rev_num =3D smbios_get_val_si(ctx, "rcd-revision-number",
> +					   SYSID_NONE, 0);
> +}
> +
> +static void
> +smbios_pop_type17_size_from_memory_node(ofnode node, struct smbios_type=
17 *t)
> +{
> +	const fdt32_t *reg;
> +	int len;
> +	u64 sz;
> +	u32 size_mb;
> +
> +	/* Read property 'reg' from the node */
> +	reg =3D ofnode_read_prop(node, "reg", &len);
> +	if (!reg || len < sizeof(fdt32_t) * 4 || len % sizeof(fdt32_t))
> +		return;
> +
> +	/* Combine hi/lo for size (typically 64-bit) */
> +	sz =3D ((u64)fdt32_to_cpu(reg[2]) << 32) | fdt32_to_cpu(reg[3]);
> +
> +	/* Convert size to MB */
> +	size_mb =3D (u32)(sz >> 20); /* 1 MB =3D 2^20 */
> +	if (size_mb < SMBIOS_MD_SIZE_EXT) {
> +		t->size =3D cpu_to_le16(size_mb);
> +		t->ext_size =3D 0;
> +		return;
> +	}
> +
> +	t->size =3D cpu_to_le16(SMBIOS_MD_SIZE_EXT); /* Signal extended used *=
/
> +	t->ext_size =3D cpu_to_le32((u32)(sz >> 10)); /* In KB */
> +}
> +
> +static void smbios_pop_type17_size_si(struct smbios_ctx *ctx,
> +				      struct smbios_type17 *t)
> +{
> +	t->size =3D smbios_get_val_si(ctx, "size", SYSID_NONE,
> +				    SMBIOS_MD_SIZE_UNKNOWN);
> +	t->ext_size =3D smbios_get_val_si(ctx, "extended-size", SYSID_NONE, 0)=
;
> +}
> +
> +static int
> +smbios_scan_memctrl_subnode(ulong *current, int *handle, struct smbios_=
ctx *ctx,
> +			    int idx, smbios_write_memctrlnode cb)
> +{
> +	int total_len =3D 0;
> +	ofnode child;
> +	int i =3D 0;
> +	int hdl_base =3D *handle;
> +	u64 base =3D 0;
> +
> +	/*
> +	 * Enumerate all subnodes of 'memory-controller' that contain 'size'
> +	 * property and generate one instance for each.
> +	 */
> +	for (child =3D ofnode_first_subnode(ctx->node); ofnode_valid(child);
> +	     child =3D ofnode_next_subnode(child)) {
> +		u64 sz =3D 0;
> +		const fdt32_t *size;
> +		int proplen;
> +
> +		size =3D ofnode_read_prop(child, "size", &proplen);
> +		if (!size || proplen < sizeof(fdt32_t) ||
> +		    proplen % sizeof(fdt32_t))
> +			continue;
> +
> +		/* 64-bit size: <hi lo> or 32-bit size */
> +		if (proplen >=3D sizeof(fdt32_t) * 2)
> +			sz =3D ((u64)fdt32_to_cpu(size[0]) << 32) |
> +			     fdt32_to_cpu(size[1]);
> +		else
> +			sz =3D fdt32_to_cpu(size[0]);
> +
> +		*handle =3D hdl_base + i;
> +		total_len +=3D cb(current, *handle, ctx, idx, base, sz);
> +		base +=3D sz;
> +		i++;
> +	}
> +
> +	return total_len;
> +}
> +
> +static int
> +smbios_write_type17_from_memctrl_node(ulong *current, int handle,
> +				      struct smbios_ctx *ctx, int idx,
> +				      u64 __maybe_unused base, u64 sz)
> +{
> +	struct smbios_type17 *t;
> +	int len;
> +	u8 *eos_addr;
> +	u32 size_mb;
> +	void *hdl;
> +	size_t hdl_size;
> +
> +	len =3D sizeof(*t);
> +	t =3D map_sysmem(*current, len);
> +	memset(t, 0, len);
> +
> +	fill_smbios_header(t, SMBIOS_MEMORY_DEVICE, len, handle);
> +
> +	/* eos is at the end of the structure */
> +	eos_addr =3D (u8 *)t + len - sizeof(t->eos);
> +	smbios_set_eos(ctx, eos_addr);
> +
> +	/* Read the memory array handles */
> +	if (!sysinfo_get_data(ctx->dev, SYSID_SM_MEMARRAY_HANDLE, &hdl,
> +			      &hdl_size) &&
> +		hdl_size =3D=3D SYSINFO_MEM_HANDLE_MAX * sizeof(u16))
> +		t->phy_mem_array_hdl =3D *((u16 *)hdl + idx);
> +
> +	/* Convert to MB */
> +	size_mb =3D (u32)(sz >> 20);
> +	if (size_mb < SMBIOS_MD_SIZE_EXT) {
> +		/* Use 16-bit size field */
> +		t->size =3D cpu_to_le16(size_mb);  /* In MB */
> +		t->ext_size =3D cpu_to_le32(0);
> +	} else {
> +		/* Signal use of extended size field */
> +		t->size =3D cpu_to_le16(SMBIOS_MD_SIZE_EXT);
> +		t->ext_size =3D cpu_to_le32((u32)(sz >> 10)); /* In KB */
> +	}
> +
> +	/* Write other general fields */
> +	smbios_pop_type17_general_si(ctx, t);
> +
> +	len =3D t->hdr.length + smbios_string_table_len(ctx);
> +	*current +=3D len;
> +	unmap_sysmem(t);
> +
> +	return len;
> +}
> +
> +static int smbios_write_type17_mem(ulong *current, int handle,
> +				   struct smbios_ctx *ctx, int idx,
> +				   int type)
> +{
> +	struct smbios_type17 *t;
> +	int len;
> +	u8 *eos_addr;
> +	void *hdl;
> +	size_t hdl_size;
> +
> +	len =3D sizeof(*t);
> +	t =3D map_sysmem(*current, len);
> +	memset(t, 0, len);
> +
> +	fill_smbios_header(t, SMBIOS_MEMORY_DEVICE, len, handle);
> +
> +	/* eos is at the end of the structure */
> +	eos_addr =3D (u8 *)t + len - sizeof(t->eos);
> +	smbios_set_eos(ctx, eos_addr);
> +
> +	if (type =3D=3D SMBIOS_MEM_CUSTOM) {
> +		smbios_pop_type17_size_si(ctx, t);
> +
> +		t->phy_mem_array_hdl =3D
> +			smbios_get_val_si(ctx, "physical-memory-array-handle",
> +					  SYSID_NONE, 0);
> +	} else if (type =3D=3D SMBIOS_MEM_FDT_MEM_NODE) {
> +		smbios_pop_type17_size_from_memory_node(ctx->node, t);
> +
> +		/* Read the memory array handles */
> +		if (!sysinfo_get_data(ctx->dev, SYSID_SM_MEMARRAY_HANDLE, &hdl,
> +				      &hdl_size) &&
> +		    hdl_size =3D=3D SYSINFO_MEM_HANDLE_MAX * sizeof(u16))
> +			t->phy_mem_array_hdl =3D *((u16 *)hdl + idx);
> +	}
> +
> +	/* Write other general fields */
> +	smbios_pop_type17_general_si(ctx, t);
> +
> +	len =3D t->hdr.length + smbios_string_table_len(ctx);
> +	*current +=3D len;
> +	unmap_sysmem(t);
> +
> +	return len;
> +}
> +
> +static int smbios_scan_mem_nodes(ulong *current, int *handle,
> +				 struct smbios_ctx *ctx,
> +				 smbios_write_memnode mem_cb,
> +				 int *idx)
> +{
> +	int len =3D 0;
> +	struct smbios_ctx ctx_bak;
> +	ofnode child;
> +	int hdl_base =3D *handle;
> +
> +	memcpy(&ctx_bak, ctx, sizeof(ctx_bak));
> +
> +	for (child =3D ofnode_first_subnode(ofnode_root());
> +	     ofnode_valid(child); child =3D ofnode_next_subnode(child)) {
> +		const char *str;
> +
> +		/* Look up for 'device_type =3D "memory"' */
> +		str =3D ofnode_read_string(child, "device_type");
> +		if (!str || strcmp(str, "memory"))
> +			continue;
> +
> +		ctx->node =3D child;
> +		*handle =3D hdl_base + *idx;
> +		/* Generate one instance for each 'memory' node */
> +		len +=3D mem_cb(current, *handle, ctx, *idx,
> +			      SMBIOS_MEM_FDT_MEM_NODE);
> +		memcpy(ctx, &ctx_bak, sizeof(*ctx));
> +		(*idx)++;
> +	}
> +
> +	return len;
> +}
> +
> +static int smbios_scan_mctrl_subnodes(ulong *current, int *handle,
> +				      struct smbios_ctx *ctx,
> +				      smbios_write_memctrlnode mctrl_wcb,
> +				      int *idx)
> +{
> +	int len =3D 0;
> +	struct smbios_ctx ctx_bak;
> +	ofnode child;
> +
> +	memcpy(&ctx_bak, ctx, sizeof(ctx_bak));
> +
> +	for (child =3D ofnode_first_subnode(ofnode_root());
> +	     ofnode_valid(child); child =3D ofnode_next_subnode(child)) {
> +		const char *compat;
> +		const char *name;
> +
> +		/*
> +		 * Look up for node with name or property 'compatible'
> +		 * containing 'memory-controller'.
> +		 */
> +		name =3D ofnode_get_name(child);
> +		compat =3D ofnode_read_string(child, "compatible");
> +		if ((!compat || !strstr(compat, "memory-controller")) &&
> +		    (!name || !strstr(name, "memory-controller")))
> +			continue;
> +
> +		(*handle)++;
> +		ctx->node =3D child;
> +		/*
> +		 * Generate one instance for each subnode of
> +		 * 'memory-controller' which contains property 'size'.
> +		 */
> +		len +=3D smbios_scan_memctrl_subnode(current, handle, ctx,
> +						   *idx, mctrl_wcb);
> +		memcpy(ctx, &ctx_bak, sizeof(*ctx));
> +		(*idx)++;
> +	}
> +	return len;
> +}
> +
> +static int smbios_write_type1719(ulong *current, int *handle,
> +				 struct smbios_ctx *ctx,
> +				 smbios_write_memnode mem_cb,
> +				 smbios_write_memctrlnode mctrl_wcb)
> +{
> +	int len =3D 0;
> +	int idx;
> +
> +	if (!IS_ENABLED(CONFIG_OF_CONTROL))
> +		return 0;	/* Error, return 0-length */
> +
> +	/* Step 1: Scan any subnode exists */
> +	len =3D smbios_scan_subnodes(current, ctx, handle, mem_cb,
> +				   SMBIOS_MEM_CUSTOM);
> +	if (len)
> +		return len;
> +
> +	/* Step 2: Scan 'memory' node from the entire FDT */
> +	idx =3D 0;
> +	len +=3D smbios_scan_mem_nodes(current, handle, ctx, mem_cb, &idx);
> +
> +	/* Step 3: Scan 'memory-controller' node from the entire FDT */
> +	len +=3D smbios_scan_mctrl_subnodes(current, handle, ctx, mctrl_wcb, &=
idx);
> +
> +	return len;
> +}
> +
> +static int smbios_write_type17(ulong *current, int *handle,
> +			       struct smbios_ctx *ctx)
> +{
> +	return smbios_write_type1719(current, handle, ctx,
> +				     smbios_write_type17_mem,
> +				     smbios_write_type17_from_memctrl_node);
> +}
> +
>   #endif /* #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE) */
>  =20
>   static int smbios_write_type32(ulong *current, int *handle,
> @@ -1481,6 +1857,7 @@ static struct smbios_write_method smbios_write_fun=
cs[] =3D {
>   #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
>   	{ smbios_write_type9, "system-slot"},
>   	{ smbios_write_type16, "memory-array"},
> +	{ smbios_write_type17, "memory-device"},
>   #endif
>   	{ smbios_write_type32, },
>   	{ smbios_write_type127 },

