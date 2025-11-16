Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CB3CD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 10:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B6B3839D5;
	Sun, 16 Nov 2025 11:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="K0kx+P6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA1A83A32; Sun, 16 Nov 2025 11:41:56 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 987328399B
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 11:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763289713; x=1763894513; i=xypron.glpk@gmx.de;
 bh=tkPtuFT4u2D04Bi3hQQZQJ0Y62EsM5CMHBw0txgbMvM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=K0kx+P6d3j1M4eNQpdqo5WQ7HlShyQy0b4CO5f29AKH8aQKuJlc7KOVCQR3Uw9j2
 Q3ojmR/NM9/f9OWJOLnhnXGlZc+LGdLapLv9GRHu32dz8DTX/ZCOPQMvYLWhIX1KJ
 nZxLx3PXXt/wRRNaF2PxR+EhTxQh0IlzBrywQ0UF5jTZkWX3UtMigw8zbMNKG8pX6
 YsmaiwcB+nbM9i473OnoN/kzZZcNQLeyO/tf/81fd9f2rNEL1zaHr9jtuobfSlKsS
 XMCozYF7nTd5gDMGNcH2YwWcn/zuVr5P4uMpE1/sKCQU/1a2yaCEQiy+PtVieq4JW
 DoR+nZfFNCwFLRO32A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEV3C-1vNIx10JrO-006yHm; Sun, 16
 Nov 2025 11:41:53 +0100
Message-ID: <899c17bd-a3cc-4485-b408-bd4a097fe40c@gmx.de>
Date: Sun, 16 Nov 2025 11:41:51 +0100
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
X-Provags-ID: V03:K1:VrR0rhu/caNum+/OYY6OE3nglMMxA6glsB12Gw7ATMxeNWs+qvr
 FEgWkbVw6kP/PMXTrntmjJltPli5Rz/Oe6FGe2+ZI6FKbz7weMQDbTnXC3c7OHpkYC3so5t
 pg7EYdDOxDhQKFNLykujk/MFlEx+t2fqlNk4Sur1fq5VqG2HJPfL/arTGak5bJBHlIdy9IW
 1X2RAvX3/wYpe6OE9tamg==
UI-OutboundReport: notjunk:1;M01:P0:J6FsquZjHS4=;oZPbu5Ll4m2V4k78vN1+4LkKIeZ
 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
 Gn7eClAQoZfFA3FBmqr9
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

