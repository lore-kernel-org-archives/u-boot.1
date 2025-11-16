Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59B8CEBF61
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 10:45:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 594F7839D5;
	Sun, 16 Nov 2025 11:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="j6kYJidR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8491383A8A; Sun, 16 Nov 2025 11:45:12 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2D97839A8
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 11:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763289903; x=1763894703; i=xypron.glpk@gmx.de;
 bh=3dn5zpHbUwHddXsnaMnZSifKSMUXnbtxA4oLjl3dOOg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=j6kYJidRdqkLzB0QxUoNtY6FCoPOQPjK9d2UEf5ySJSraTf5P+Ew291Sa1V79q/P
 /elxGFIamxVnWOzy/mvBtQi9RbmfL9rKTgp34CXJ/ayLbF/u67bguSBfKRVb2SPQd
 9mltMvyRxwkhIrCmTdRTqRPse9/HLpx9nnS5RziqXBpm9NPDoeK71TkC4rDlbPawW
 lU1Bp6PhhTu1MyGVyKTrG4viOfWpJEfSd/NBQahDHqjN4hoUv1nSXqE4yy18AMOga
 Ycyb1z9CBwLEpF7XEY8LI0J0PX4WpmkIJkgLF8ZodzzWDPXfBBBDcaSLrDrtbJ68o
 8kh7zT9Oo6RXGhnb9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8ykg-1vHqxs2m9u-00EhBU; Sun, 16
 Nov 2025 11:45:02 +0100
Message-ID: <5a2b7016-32f7-4f17-9b98-dbe330ff862f@gmx.de>
Date: Sun, 16 Nov 2025 11:45:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] smbios: add support for dynamic generation of Type
 9 system slot tables
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Samuel Holland <samuel.holland@sifive.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de
References: <20251114170615.17698-1-raymondmaoca@gmail.com>
 <20251114170615.17698-2-raymondmaoca@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251114170615.17698-2-raymondmaoca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rslPi+JDTXErDsBhL7/EMA0KZG+lwwEluE4zphVE36O1FXCp8uM
 sjo6PoBqqENV3jUXcPnOAvqXroC2JNrwKlLloZi+/XwqrgVUKRexLNdu1wPdzhqRVTKK264
 o1JsOxyrDC+Qyitf1JhfhNjxQz5PXYSTibZHhRp9Xt/TnOgM96g22djfdOh5MWT1j1tEqQf
 usohSUk59d28oDwZFWZGg==
UI-OutboundReport: notjunk:1;M01:P0:K9fzfm1WW00=;Wj9mrH5g8pNnsoUquYn/wZNZEgo
 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
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

On 11/14/25 18:05, Raymond Mao wrote:
> This commit introduces support for generating SMBIOS Type 9 (System Slot=
)
> tables using a hybrid approach:
>=20
> 1. Explicit Device Tree definitions:
>     Child node under '/smbios/smbios/system-slot' will be interpreted as
>     individual slot definitions.
>     - Each child represents a slot (e.g., isa, pcmcia, etc.).
>     - Properties follow the SMBIOS specification using lowercase
>       hyphen-separated names such as 'slot-type', 'slot-id',
>       'segment-group-number', 'bus-number', 'slot-information', etc.
>     - This approach allows full customization of each system slot and is
>       especially suitable for platforms with well-defined slot topology.
>=20
> 2. Automatic detection fallback:
>     If child node under '/smbios/smbios/system-slot' does not exist, the
>     implementation will scan the entire device tree for nodes whose
>     'device_type' matches known slot-related types ("pci", "isa", "pcmci=
a",
>     etc.).
>     - When a match is found, default values or heuristics are applied to
>       populate to the System Slot table.
>     - This mode is useful for platforms that lack explicit SMBIOS nodes
>       but still expose slot topology via standard DT conventions.
>=20
> Together, two approaches ensure that SMBIOS Type 9 entries are available
> whether explicitly described or automatically derived.
>=20
> Signed-off-by: Raymond Mao <raymondmaoca@gmail.com>
> ---
> Changes in v2:
> - Reuse sysinfo_to_dt and convert_sysinfo_to_dt() for mapping SMBIOS pro=
perties to DT.
> Changes in v3:
> - Update subject and commit message.
> - Abstract helper functions and add callback for writing subnodes.
> Changes in v4:
> - Refine the commit message.
>=20
>   arch/arm/dts/smbios_generic.dtsi |   3 +
>   cmd/smbios.c                     | 114 ++++++++++++
>   include/smbios.h                 |  45 +++++
>   include/smbios_def.h             |  89 +++++++++
>   lib/smbios.c                     | 301 ++++++++++++++++++++++++++++++-
>   5 files changed, 549 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/dts/smbios_generic.dtsi b/arch/arm/dts/smbios_gene=
ric.dtsi
> index fc168317c9e..4463dade217 100644
> --- a/arch/arm/dts/smbios_generic.dtsi
> +++ b/arch/arm/dts/smbios_generic.dtsi
> @@ -77,6 +77,9 @@
>   						   SMBIOS_CACHE_OP_WB)>;
>   				};
>   			};
> +
> +			system-slot {
> +			};
>   		};
>   	};
>   };
> diff --git a/cmd/smbios.c b/cmd/smbios.c
> index ed419f19028..f9b62e66229 100644
> --- a/cmd/smbios.c
> +++ b/cmd/smbios.c
> @@ -119,6 +119,55 @@ static const struct str_lookup_table associativity_=
strings[] =3D {
>  =20
>   };
>  =20
> +static const struct str_lookup_table slot_type_strings[] =3D {
> +	{ SMBIOS_SYSSLOT_TYPE_OTHER,		"Other" },
> +	{ SMBIOS_SYSSLOT_TYPE_UNKNOWN,		"Unknown" },
> +	{ SMBIOS_SYSSLOT_TYPE_ISA,		"ISA" },
> +	{ SMBIOS_SYSSLOT_TYPE_PCI,		"PCI" },
> +	{ SMBIOS_SYSSLOT_TYPE_PCMCIA,		"PC Card (PCMCIA)" },
> +	{ SMBIOS_SYSSLOT_TYPE_PCIE,		"PCI Express" },
> +	{ SMBIOS_SYSSLOT_TYPE_PCIEGEN2,		"PCI Express Gen 2" },
> +	{ SMBIOS_SYSSLOT_TYPE_PCIEGEN3,		"PCI Express Gen 3" },
> +	{ SMBIOS_SYSSLOT_TYPE_PCIEGEN3X16,	"PCI Express Gen 3 x16" },
> +	{ SMBIOS_SYSSLOT_TYPE_PCIEGEN4,		"PCI Express Gen 4" },
> +	{ SMBIOS_SYSSLOT_TYPE_PCIEGEN4X8,	"PCI Express Gen 4 x8" },
> +	{ SMBIOS_SYSSLOT_TYPE_PCIEGEN4X16,	"PCI Express Gen 4 x16" },
> +};
> +
> +static const struct str_lookup_table slot_bus_width_strings[] =3D {
> +	{ SMBIOS_SYSSLOT_WIDTH_OTHER,	"Other" },
> +	{ SMBIOS_SYSSLOT_WIDTH_UNKNOWN,	"Unknown" },
> +	{ SMBIOS_SYSSLOT_WIDTH_8BIT,	"8 bit" },
> +	{ SMBIOS_SYSSLOT_WIDTH_16BIT,	"16 bit" },
> +	{ SMBIOS_SYSSLOT_WIDTH_32BIT,	"32 bit" },
> +	{ SMBIOS_SYSSLOT_WIDTH_64BIT,	"64 bit" },
> +	{ SMBIOS_SYSSLOT_WIDTH_128BIT,	"128 bit " },
> +	{ SMBIOS_SYSSLOT_WIDTH_1X,	"1x or x1" },
> +	{ SMBIOS_SYSSLOT_WIDTH_2X,	"2x or x2" },
> +	{ SMBIOS_SYSSLOT_WIDTH_4X,	"4x or x4" },
> +	{ SMBIOS_SYSSLOT_WIDTH_8X,	"8x or x8" },
> +	{ SMBIOS_SYSSLOT_WIDTH_12X,	"12x or x12" },
> +	{ SMBIOS_SYSSLOT_WIDTH_16X,	"16x or x16" },
> +	{ SMBIOS_SYSSLOT_WIDTH_32X,	"32x or x32" },
> +};
> +
> +static const struct str_lookup_table slot_usage_strings[] =3D {
> +	{ SMBIOS_SYSSLOT_USAGE_OTHER,		"Other" },
> +	{ SMBIOS_SYSSLOT_USAGE_UNKNOWN,		"Unknown" },
> +	{ SMBIOS_SYSSLOT_USAGE_AVAILABLE,	"Available" },
> +	{ SMBIOS_SYSSLOT_USAGE_INUSE,		"In use" },
> +	{ SMBIOS_SYSSLOT_USAGE_NA,		"Unavailable" },
> +};
> +
> +static const struct str_lookup_table slot_length_strings[] =3D {
> +	{ SMBIOS_SYSSLOT_LENG_OTHER,	"Other" },
> +	{ SMBIOS_SYSSLOT_LENG_UNKNOWN,	"Unknown" },
> +	{ SMBIOS_SYSSLOT_LENG_SHORT,	"Short Length" },
> +	{ SMBIOS_SYSSLOT_LENG_LONG,	"Long Length" },
> +	{ SMBIOS_SYSSLOT_LENG_2_5INDRV,	"2.5 inch drive form factor" },
> +	{ SMBIOS_SYSSLOT_LENG_3_5INDRV,	"3.5 inch drive form factor" },
> +};
> +
>   /**
>    * smbios_get_string() - get SMBIOS string from table
>    *
> @@ -403,6 +452,68 @@ static void smbios_print_type7(struct smbios_type7 =
*table)
>   	printf("\tInstalled Cache Size 2: 0x%08x\n", table->inst_size2.data);
>   }
>  =20
> +static void smbios_print_type9(struct smbios_type9 *table)
> +{
> +	int i;
> +	u8 *addr =3D (u8 *)table +
> +		   offsetof(struct smbios_type9, slot_information);
> +
> +	printf("System Slots:\n");
> +	smbios_print_str("Socket Designation", table,
> +			 table->socket_design);
> +	smbios_print_lookup_str(slot_type_strings,
> +				table->slot_type,
> +				ARRAY_SIZE(slot_type_strings),
> +				"Slot Type");
> +	smbios_print_lookup_str(slot_bus_width_strings,
> +				table->slot_data_bus_width,
> +				ARRAY_SIZE(slot_bus_width_strings),
> +				"Slot Data Bus Width");
> +	smbios_print_lookup_str(slot_usage_strings,
> +				table->current_usage,
> +				ARRAY_SIZE(slot_usage_strings),
> +				"Current Usage");
> +	smbios_print_lookup_str(slot_length_strings,
> +				table->slot_length,
> +				ARRAY_SIZE(slot_length_strings),
> +				"Slot Length");
> +	printf("\tSlot ID: 0x%04x\n", table->slot_id);
> +	printf("\tSlot Characteristics 1: 0x%04x\n",
> +	       table->slot_characteristics_1);
> +	printf("\tSlot Characteristics 2: 0x%04x\n",
> +	       table->slot_characteristics_2);
> +	printf("\tSegment Group Number (Base): 0x%04x\n",
> +	       table->segment_group_number);
> +	printf("\tBus Number (Base): 0x%04x\n", table->bus_number);
> +	printf("\tDevice/Function Number (Base): 0x%04x\n",
> +	       table->device_function_number.data);


When using QFW QEMU provides the SMBIOS table. It currently uses SMBIOS=20
version 3.0. The fields below where introduced with version 3.2 or=20
later. So you are causing a buffer overrun here.

[PATCH 1/1] cmd: smbios: correct output for table type 4
https://lists.denx.de/pipermail/u-boot/2025-November/603413.html
starts introducing version checks to avoid buffer overruns.

Best regards

Heinrich


> +	printf("\tData Bus Width (Base): 0x%04x\n",
> +	       table->electrical_bus_width);
> +	printf("\tPeer (S/B/D/F/Width) grouping count: 0x%04x\n",
> +	       table->peer_grouping_count);
> +	printf("\tPeer (S/B/D/F/Width) groups:\n");
> +	for (i =3D 0; i < table->peer_grouping_count; i++) {
> +		printf("\t\tPeer group[%03d]:\n", i);
> +		if (CONFIG_IS_ENABLED(HEXDUMP))
> +			print_hex_dump("\t\t", DUMP_PREFIX_OFFSET, 16, 1, addr,
> +				       SMBIOS_TYPE9_PGROUP_SIZE, false);
> +		addr +=3D SMBIOS_TYPE9_PGROUP_SIZE;
> +	}
> +	printf("\n");
> +
> +	/* table->slot_information */
> +	printf("\tSlot Information: 0x%04x\n", *addr);
> +	/* table->slot_physical_width */
> +	addr +=3D sizeof(table->slot_information);
> +	printf("\tSlot Physical Width: 0x%04x\n", *addr);
> +	/* table->slot_pitch */
> +	addr +=3D sizeof(table->slot_physical_width);
> +	printf("\tSlot Pitch: 0x%04x\n", *(u16 *)addr);
> +	/* table->slot_height */
> +	addr +=3D sizeof(table->slot_pitch);
> +	printf("\tSlot Height: 0x%04x\n", *addr);
> +}
> +
>   static void smbios_print_type127(struct smbios_type127 *table)
>   {
>   	printf("End Of Table\n");
> @@ -482,6 +593,9 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag=
, int argc,
>   		case SMBIOS_CACHE_INFORMATION:
>   			smbios_print_type7((struct smbios_type7 *)pos);
>   			break;
> +		case SMBIOS_SYSTEM_SLOTS:
> +			smbios_print_type9((struct smbios_type9 *)pos);
> +			break;
>   		case SMBIOS_END_OF_TABLE:
>   			smbios_print_type127((struct smbios_type127 *)pos);
>   			break;
> diff --git a/include/smbios.h b/include/smbios.h
> index b5fed57aba2..d885285ea41 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -264,6 +264,51 @@ struct __packed smbios_type7 {
>   	char eos[SMBIOS_STRUCT_EOS_BYTES];
>   };
>  =20
> +#define SMBIOS_TYPE9_PGROUP_SIZE 5
> +
> +struct pci_attr_lookup_table {
> +	const char *str;
> +	u8 slot_type;
> +	u8 data_bus_width;
> +	u8 slot_length;
> +	u8 chara1;
> +	u8 chara2;
> +};
> +
> +union dev_func_num {
> +	struct {
> +		u8 dev_num:5;
> +		u8 func_num:3;
> +	} fields;
> +	u8 data;
> +};
> +
> +struct __packed smbios_type9 {
> +	struct smbios_header hdr;
> +	u8 socket_design;
> +	u8 slot_type;
> +	u8 slot_data_bus_width;
> +	u8 current_usage;
> +	u8 slot_length;
> +	u16 slot_id;
> +	u8 slot_characteristics_1;
> +	u8 slot_characteristics_2;
> +	u16 segment_group_number;
> +	u8 bus_number;
> +	union dev_func_num device_function_number;
> +	u8 electrical_bus_width;
> +	u8 peer_grouping_count;
> +	/*
> +	 * Dynamic bytes will be inserted here to store peer_groups.
> +	 * length is equal to 'peer_grouping_count' * 5
> +	 */
> +	u8 slot_information;
> +	u8 slot_physical_width;
> +	u16 slot_pitch;
> +	u8 slot_height;
> +	char eos[SMBIOS_STRUCT_EOS_BYTES];
> +};
> +
>   struct __packed smbios_type32 {
>   	u8 type;
>   	u8 length;
> diff --git a/include/smbios_def.h b/include/smbios_def.h
> index 81c5781217f..ef9cb02ed25 100644
> --- a/include/smbios_def.h
> +++ b/include/smbios_def.h
> @@ -191,4 +191,93 @@
>   #define SMBIOS_CACHE_ASSOC_64WAY	13
>   #define SMBIOS_CACHE_ASSOC_20WAY	14
>  =20
> +/*
> + * System Slot
> + */
> +
> +/* Slot Type */
> +#define SMBIOS_SYSSLOT_TYPE_OTHER	1
> +#define SMBIOS_SYSSLOT_TYPE_UNKNOWN	2
> +#define SMBIOS_SYSSLOT_TYPE_ISA		3	/* ISA */
> +#define SMBIOS_SYSSLOT_TYPE_PCI		6	/* PCI */
> +#define SMBIOS_SYSSLOT_TYPE_PCMCIA	7	/* PCMCIA */
> +#define SMBIOS_SYSSLOT_TYPE_PCIE	0xa5	/* PCI Express */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEX1	0xa6	/* PCI Express x1 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEX2	0xa7	/* PCI Express x2 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEX4	0xa8	/* PCI Express x4 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEX8	0xa9	/* PCI Express x8 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEX16	0xaa	/* PCI Express x16 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2	0xab	/* PCI Express Gen 2 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X1	0xac	/* PCI Express Gen 2 x1 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X2	0xad	/* PCI Express Gen 2 x2 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X4	0xae	/* PCI Express Gen 2 x4 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X8	0xaf	/* PCI Express Gen 2 x8 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X16	0xb0	/* PCI Express Gen 2 x16 *=
/
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3	0xb1	/* PCI Express Gen 3 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X1	0xb2	/* PCI Express Gen 3 x1 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X2	0xb3	/* PCI Express Gen 3 x2 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X4	0xb4	/* PCI Express Gen 3 x4 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X8	0xb5	/* PCI Express Gen 3 x8 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X16	0xb6	/* PCI Express Gen 3 x16 *=
/
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4	0xb8	/* PCI Express Gen 4 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X1	0xb9	/* PCI Express Gen 4 x1 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X2	0xba	/* PCI Express Gen 4 x2 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X4	0xbb	/* PCI Express Gen 4 x4 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X8	0xbc	/* PCI Express Gen 4 x8 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X16	0xbd	/* PCI Express Gen 4 x16 *=
/
> +
> +/* Slot Data Bus Width */
> +#define SMBIOS_SYSSLOT_WIDTH_OTHER	1
> +#define SMBIOS_SYSSLOT_WIDTH_UNKNOWN	2
> +#define SMBIOS_SYSSLOT_WIDTH_8BIT	3
> +#define SMBIOS_SYSSLOT_WIDTH_16BIT	4
> +#define SMBIOS_SYSSLOT_WIDTH_32BIT	5
> +#define SMBIOS_SYSSLOT_WIDTH_64BIT	6
> +#define SMBIOS_SYSSLOT_WIDTH_128BIT	7
> +#define SMBIOS_SYSSLOT_WIDTH_1X		8
> +#define SMBIOS_SYSSLOT_WIDTH_2X		9
> +#define SMBIOS_SYSSLOT_WIDTH_4X		10
> +#define SMBIOS_SYSSLOT_WIDTH_8X		11
> +#define SMBIOS_SYSSLOT_WIDTH_12X	12
> +#define SMBIOS_SYSSLOT_WIDTH_16X	13
> +#define SMBIOS_SYSSLOT_WIDTH_32X	14
> +
> +/* Current Usage */
> +#define SMBIOS_SYSSLOT_USAGE_OTHER	1
> +#define SMBIOS_SYSSLOT_USAGE_UNKNOWN	2
> +#define SMBIOS_SYSSLOT_USAGE_AVAILABLE	3
> +#define SMBIOS_SYSSLOT_USAGE_INUSE	4
> +#define SMBIOS_SYSSLOT_USAGE_NA		5
> +
> +/* Slot Length */
> +#define SMBIOS_SYSSLOT_LENG_OTHER	1
> +#define SMBIOS_SYSSLOT_LENG_UNKNOWN	2
> +#define SMBIOS_SYSSLOT_LENG_SHORT	3
> +#define SMBIOS_SYSSLOT_LENG_LONG	4
> +#define SMBIOS_SYSSLOT_LENG_2_5INDRV	5
> +#define SMBIOS_SYSSLOT_LENG_3_5INDRV	6
> +
> +/*  Slot Characteristics 1 */
> +#define SMBIOS_SYSSLOT_CHAR_UND		1 /* BIT(0) */
> +#define SMBIOS_SYSSLOT_CHAR_5V		2 /* BIT(1) */
> +#define SMBIOS_SYSSLOT_CHAR_3_3V	4 /* BIT(2) */
> +#define SMBIOS_SYSSLOT_CHAR_SHARED	8 /* BIT(3) */
> +#define SMBIOS_SYSSLOT_CHAR_PCCARD16	16 /* BIT(4) */
> +#define SMBIOS_SYSSLOT_CHAR_PCCARDBUS	32 /* BIT(5) */
> +#define SMBIOS_SYSSLOT_CHAR_PCCARDZV	64 /* BIT(6) */
> +#define SMBIOS_SYSSLOT_CHAR_PCCARDMRR	0x80 /* BIT(7) */
> +
> +/* Slot Characteristics 2 */
> +#define SMBIOS_SYSSLOT_CHAR_PCIPME	1 /* BIT(0) */
> +#define SMBIOS_SYSSLOT_CHAR_HOTPLUG	2 /* BIT(1) */
> +#define SMBIOS_SYSSLOT_CHAR_PCISMB	4 /* BIT(2) */
> +#define SMBIOS_SYSSLOT_CHAR_PCIBIF	8 /* BIT(3) */
> +#define SMBIOS_SYSSLOT_CHAR_ASYNCRM	16 /* BIT(4) */
> +#define SMBIOS_SYSSLOT_CHAR_FBCXL1	32 /* BIT(5) */
> +#define SMBIOS_SYSSLOT_CHAR_FBCXL2	64 /* BIT(6) */
> +#define SMBIOS_SYSSLOT_CHAR_FBCXL3	0x80 /* BIT(7) */
> +
> +/* Slot segment group number */
> +#define SMBIOS_SYSSLOT_SGGNUM_UND	0
> +
>   #endif /* _SMBIOS_DEF_H_ */
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 85508c06547..caeb309294d 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -66,11 +66,47 @@ struct map_sysinfo {
>  =20
>   static const struct map_sysinfo sysinfo_to_dt[] =3D {
>   	{ .si_node =3D "system", .si_str =3D "product", .dt_str =3D "model", =
2 },
> -	{ .si_node =3D "system", .si_str =3D "manufacturer", .dt_str =3D "comp=
atible", 1 },
> -	{ .si_node =3D "baseboard", .si_str =3D "product", .dt_str =3D "model"=
, 2 },
> -	{ .si_node =3D "baseboard", .si_str =3D "manufacturer", .dt_str =3D "c=
ompatible", 1 },
> +	{ .si_node =3D "system", .si_str =3D "manufacturer",
> +	  .dt_str =3D "compatible", 1 },
> +	{ .si_node =3D "baseboard", .si_str =3D "product",
> +	  .dt_str =3D "model", 2 },
> +	{ .si_node =3D "baseboard", .si_str =3D "manufacturer",
> +	  .dt_str =3D "compatible", 1 },
> +	{ .si_node =3D "system-slot", .si_str =3D "slot-type",
> +	  .dt_str =3D "device_type", 0},
> +	{ .si_node =3D "system-slot", .si_str =3D "segment-group-number",
> +	  .dt_str =3D "linux,pci-domain", 0},
>   };
>  =20
> +#if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
> +static const struct pci_attr_lookup_table pci_attr[] =3D {
> +	{ "pci-host-ecam-generic", SMBIOS_SYSSLOT_TYPE_PCIE,
> +	  SMBIOS_SYSSLOT_WIDTH_8X, SMBIOS_SYSSLOT_LENG_LONG,
> +	  SMBIOS_SYSSLOT_CHAR_3_3V, SMBIOS_SYSSLOT_CHAR_PCIPME },
> +	{ "pci-host-cam-generic", SMBIOS_SYSSLOT_TYPE_PCI,
> +	  SMBIOS_SYSSLOT_WIDTH_32BIT, SMBIOS_SYSSLOT_LENG_SHORT,
> +	  SMBIOS_SYSSLOT_CHAR_5V | SMBIOS_SYSSLOT_CHAR_3_3V,
> +	  SMBIOS_SYSSLOT_CHAR_PCIPME },
> +	{ "pci-host-thunder-ecam", SMBIOS_SYSSLOT_TYPE_PCIEGEN3,
> +	  SMBIOS_SYSSLOT_WIDTH_8X, SMBIOS_SYSSLOT_LENG_LONG,
> +	  SMBIOS_SYSSLOT_CHAR_3_3V,
> +	  SMBIOS_SYSSLOT_CHAR_PCIPME | SMBIOS_SYSSLOT_CHAR_HOTPLUG },
> +	{ "pci-host-octeontx-ecam", SMBIOS_SYSSLOT_TYPE_PCIEGEN3X16,
> +	  SMBIOS_SYSSLOT_WIDTH_16X, SMBIOS_SYSSLOT_LENG_LONG,
> +	  SMBIOS_SYSSLOT_CHAR_3_3V,
> +	  SMBIOS_SYSSLOT_CHAR_PCIPME | SMBIOS_SYSSLOT_CHAR_HOTPLUG },
> +	{ "pci-host-thunder-pem", SMBIOS_SYSSLOT_TYPE_PCIEGEN4X8,
> +	  SMBIOS_SYSSLOT_WIDTH_8X, SMBIOS_SYSSLOT_LENG_LONG,
> +	  SMBIOS_SYSSLOT_CHAR_3_3V,
> +	  SMBIOS_SYSSLOT_CHAR_PCIPME | SMBIOS_SYSSLOT_CHAR_HOTPLUG },
> +	{ "pci-host-octeontx2-pem", SMBIOS_SYSSLOT_TYPE_PCIEGEN4X16,
> +	  SMBIOS_SYSSLOT_WIDTH_16X, SMBIOS_SYSSLOT_LENG_LONG,
> +	  SMBIOS_SYSSLOT_CHAR_3_3V,
> +	  SMBIOS_SYSSLOT_CHAR_PCIPME | SMBIOS_SYSSLOT_CHAR_HOTPLUG |
> +	  SMBIOS_SYSSLOT_CHAR_PCIBIF },
> +};
> +#endif
> +
>   /**
>    * struct smbios_ctx - context for writing SMBIOS tables
>    *
> @@ -95,6 +131,10 @@ struct smbios_ctx {
>   	char *last_str;
>   };
>  =20
> +typedef int (*smbios_write_subnode)(ulong *current, int handle,
> +				   struct smbios_ctx *ctx, int idx,
> +				   int type);
> +
>   /**
>    * Function prototype to write a specific type of SMBIOS structure
>    *
> @@ -222,6 +262,7 @@ static int smbios_get_val_si(struct smbios_ctx * __m=
aybe_unused ctx,
>   {
>   #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
>   	int val;
> +	const struct map_sysinfo *nprop;
>  =20
>   	if (!ctx->dev)
>   		return val_def;
> @@ -240,6 +281,11 @@ static int smbios_get_val_si(struct smbios_ctx * __=
maybe_unused ctx,
>   	 */
>   	if (!ofnode_read_u32(ofnode_root(), prop, &val))
>   		return val;
> +
> +	/* If the node is still missing, try with the mapping values */
> +	nprop =3D convert_sysinfo_to_dt(ctx->subnode_name, prop);
> +	if (!ofnode_read_u32(ofnode_root(), nprop->dt_str, &val))
> +		return val;
>   #endif
>   	return val_def;
>   }
> @@ -859,6 +905,252 @@ static int smbios_write_type7(ulong *current, int =
*handle,
>   	return len;
>   }
>  =20
> +static int smbios_scan_subnodes(ulong *current, struct smbios_ctx *ctx,
> +				int *handle, smbios_write_subnode cb, int type)
> +{
> +	ofnode child;
> +	int i;
> +	int hdl_base =3D *handle;
> +	int len =3D 0;
> +	struct smbios_ctx ctx_bak;
> +
> +	memcpy(&ctx_bak, ctx, sizeof(ctx_bak));
> +
> +	for (i =3D 0, child =3D ofnode_first_subnode(ctx->node);
> +	     ofnode_valid(child); child =3D ofnode_next_subnode(child), i++) {
> +		ctx->node =3D child;
> +		*handle =3D hdl_base + i;
> +		len +=3D cb(current, *handle, ctx, i, type);
> +		memcpy(ctx, &ctx_bak, sizeof(*ctx));
> +	}
> +
> +	return len;
> +}
> +
> +static void smbios_lookup_pci_attr(struct smbios_ctx *ctx,
> +				   struct smbios_type9 *t)
> +{
> +	const char *compatible;
> +	u32 addr_cells, size_cells, total_cells;
> +	const fdt32_t *reg;
> +	int reglen;
> +	int i;
> +
> +	/* default attributes */
> +	t->slot_type =3D SMBIOS_SYSSLOT_TYPE_PCI;
> +	t->slot_data_bus_width =3D SMBIOS_SYSSLOT_WIDTH_UNKNOWN;
> +	t->slot_characteristics_1 =3D SMBIOS_SYSSLOT_CHAR_UND;
> +	t->current_usage =3D SMBIOS_SYSSLOT_USAGE_UNKNOWN;
> +	t->slot_length =3D SMBIOS_SYSSLOT_LENG_UNKNOWN;
> +	t->segment_group_number =3D smbios_get_val_si(ctx, "segment-group-numb=
er",
> +						    SYSID_NONE,
> +						    SMBIOS_SYSSLOT_SGGNUM_UND);
> +
> +	/*
> +	 * Get #address-cells and #size-cells dynamically
> +	 * Default 3 for #address-cells and 2 for #size-cells
> +	 */
> +	addr_cells =3D ofnode_read_u32_default(ctx->node, "#address-cells", 3)=
;
> +	size_cells =3D ofnode_read_u32_default(ctx->node, "#size-cells", 2);
> +	total_cells =3D addr_cells + size_cells;
> +
> +	/* Read property 'reg' from the node */
> +	reg =3D ofnode_read_prop(ctx->node, "reg", &reglen);
> +	if (reg && reglen > addr_cells * sizeof(*reg)) {
> +		/* First address-cell: Bus Number */
> +		if (addr_cells >=3D 1)
> +			t->bus_number =3D fdt32_to_cpu(reg[0]);
> +		/* Second address-cell: Device/Function */
> +		if (addr_cells >=3D 2)
> +			t->device_function_number.data =3D fdt32_to_cpu(reg[1]);
> +		/*
> +		 * Third address-cell 'Register Offset' and the following
> +		 * size-cell bytes are not useful for SMBIOS type 9, just
> +		 * ignore them.
> +		 */
> +		/*
> +		 * As neither PCI IRQ Routing Table ($PIRQ) nor FDT
> +		 * property to represent a Slot ID, try to derive a
> +		 * Slot ID programmatically.
> +		 */
> +		t->slot_id =3D t->device_function_number.fields.dev_num |
> +			     (t->bus_number << 5);
> +	}
> +
> +	/* Read 'compatible' property */
> +	compatible =3D ofnode_read_string(ctx->node, "compatible");
> +	if (!compatible)
> +		return;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(pci_attr); i++) {
> +		if (strstr(compatible, pci_attr[i].str)) {
> +			t->slot_type =3D pci_attr[i].slot_type;
> +			t->slot_data_bus_width =3D pci_attr[i].data_bus_width;
> +			t->slot_length =3D pci_attr[i].slot_length;
> +			t->slot_characteristics_1 =3D pci_attr[i].chara1;
> +			t->slot_characteristics_2 =3D pci_attr[i].chara2;
> +			/* mark it as in-use arbitrarily */
> +			t->current_usage =3D SMBIOS_SYSSLOT_USAGE_INUSE;
> +			return;
> +		}
> +	}
> +}
> +
> +static void smbios_write_type9_fields(struct smbios_ctx *ctx,
> +				      struct smbios_type9 *t)
> +{
> +	t->slot_type =3D smbios_get_val_si(ctx, "slot-type", SYSID_NONE,
> +					 SMBIOS_SYSSLOT_TYPE_UNKNOWN);
> +	t->slot_data_bus_width =3D
> +		smbios_get_val_si(ctx, "data-bus-width",
> +				  SYSID_NONE, SMBIOS_SYSSLOT_WIDTH_UNKNOWN);
> +	t->current_usage =3D smbios_get_val_si(ctx, "current-usage", SYSID_NON=
E,
> +					     SMBIOS_SYSSLOT_USAGE_UNKNOWN);
> +	t->slot_length =3D smbios_get_val_si(ctx, "slot-length", SYSID_NONE,
> +					   SMBIOS_SYSSLOT_LENG_UNKNOWN);
> +	t->slot_id =3D smbios_get_val_si(ctx, "slot-id", SYSID_NONE, 0);
> +	t->slot_characteristics_1 =3D
> +		smbios_get_val_si(ctx, "slot-characteristics-1", SYSID_NONE,
> +				  SMBIOS_SYSSLOT_CHAR_UND);
> +	t->slot_characteristics_2 =3D smbios_get_val_si(ctx,
> +						      "slot-characteristics-2",
> +						      SYSID_NONE, 0);
> +	t->segment_group_number =3D smbios_get_val_si(ctx, "segment-group-numb=
er",
> +						    SYSID_NONE, 0);
> +	t->bus_number =3D smbios_get_val_si(ctx, "bus-number", SYSID_NONE, 0);
> +	t->device_function_number.data =3D
> +		smbios_get_val_si(ctx, "device-function-number", SYSID_NONE, 0);
> +}
> +
> +static int smbios_write_type9_1slot(ulong *current, int handle,
> +				    struct smbios_ctx *ctx,
> +				    int __maybe_unused idx, int devtype)
> +{
> +	struct smbios_type9 *t;
> +	int len =3D sizeof(*t);
> +	u8 pgroups_cnt;
> +	u8 *eos_addr;
> +	size_t pgroups_size;
> +	void *wp;
> +
> +	pgroups_cnt =3D smbios_get_val_si(ctx, "peer-grouping-count",
> +					SYSID_NONE, 0);
> +	pgroups_size =3D pgroups_cnt * SMBIOS_TYPE9_PGROUP_SIZE;
> +
> +	/*
> +	 * reserve the space for the dynamic bytes of peer_groups.
> +	 * TODO:
> +	 * peer_groups =3D <peer_grouping_count> * SMBIOS_TYPE9_PGROUP_SIZE
> +	 */
> +	len +=3D pgroups_size;
> +
> +	t =3D map_sysmem(*current, len);
> +	memset(t, 0, len);
> +
> +	fill_smbios_header(t, SMBIOS_SYSTEM_SLOTS, len, handle);
> +
> +	/* eos is at the end of the structure */
> +	eos_addr =3D (u8 *)t + len - sizeof(t->eos);
> +	smbios_set_eos(ctx, eos_addr);
> +
> +	/* Write the general fields */
> +	t->peer_grouping_count =3D pgroups_cnt;
> +	t->socket_design =3D smbios_add_prop_si(ctx, "socket-design", SYSID_NO=
NE,
> +					      NULL);
> +	t->electrical_bus_width =3D smbios_get_val_si(ctx, "data-bus-width",
> +						    SYSID_NONE, 0);
> +
> +	/* skip the reserved peer groups and write the following fields from e=
os */
> +	/* t->slot_height */
> +	wp =3D eos_addr - sizeof(t->slot_height);
> +	*((u8 *)wp) =3D smbios_get_val_si(ctx, "slot-height", SYSID_NONE, 0);
> +	/* t->slot_pitch */
> +	wp -=3D sizeof(t->slot_pitch);
> +	*((u16 *)wp) =3D smbios_get_val_si(ctx, "slot-pitch", SYSID_NONE, 0);
> +	/* t->slot_physical_width */
> +	wp -=3D sizeof(t->slot_physical_width);
> +	*((u8 *)wp) =3D smbios_get_val_si(ctx, "slot-physical-width", SYSID_NO=
NE, 0);
> +	/* t->slot_information */
> +	wp -=3D sizeof(t->slot_information);
> +	*((u8 *)wp) =3D smbios_get_val_si(ctx, "slot-information", SYSID_NONE,=
 0);
> +
> +	/* For PCI, some fields can be extracted from FDT node */
> +	if (devtype =3D=3D SMBIOS_SYSSLOT_TYPE_PCI)
> +		/* Populate PCI attributes from existing PCI properties */
> +		smbios_lookup_pci_attr(ctx, t);
> +	else if (devtype =3D=3D SMBIOS_SYSSLOT_TYPE_UNKNOWN) {
> +		/* Properties that expected in smbios subnode 'system-slot' */
> +		smbios_write_type9_fields(ctx, t);
> +	}
> +	len =3D t->hdr.length + smbios_string_table_len(ctx);
> +	*current +=3D len;
> +	unmap_sysmem(t);
> +
> +	return len;
> +}
> +
> +static int smbios_scan_slot_type(ulong *current, int *handle,
> +				 struct smbios_ctx *ctx)
> +{
> +	int i =3D 0;
> +	struct smbios_ctx ctx_bak;
> +	ofnode child;
> +	const struct map_sysinfo *prop;
> +	int hdl_base =3D *handle;
> +	int len =3D 0;
> +
> +	memcpy(&ctx_bak, ctx, sizeof(ctx_bak));
> +	prop =3D convert_sysinfo_to_dt(ctx->subnode_name, "slot-type");
> +	for (child =3D ofnode_first_subnode(ofnode_root()); ofnode_valid(child=
);
> +	     child =3D ofnode_next_subnode(child)) {
> +		const char *dev_type_str;
> +		u8 dev_type =3D SMBIOS_SYSSLOT_TYPE_UNKNOWN;
> +
> +		dev_type_str =3D ofnode_read_string(child, prop->dt_str);
> +		if (!dev_type_str)
> +			continue;
> +
> +		if (!strcmp(dev_type_str, "pci"))
> +			dev_type =3D SMBIOS_SYSSLOT_TYPE_PCI;
> +		else if (!strcmp(dev_type_str, "isa"))
> +			dev_type =3D SMBIOS_SYSSLOT_TYPE_ISA;
> +		else if (!strcmp(dev_type_str, "pcmcia"))
> +			dev_type =3D SMBIOS_SYSSLOT_TYPE_PCMCIA;
> +		else
> +			continue;
> +
> +		*handle =3D hdl_base + i;
> +		ctx->node =3D child;
> +		len +=3D smbios_write_type9_1slot(current, *handle, ctx, 0,
> +						dev_type);
> +		memcpy(ctx, &ctx_bak, sizeof(*ctx));
> +		i++;
> +	}
> +
> +	return len;
> +}
> +
> +static int smbios_write_type9(ulong *current, int *handle,
> +			      struct smbios_ctx *ctx)
> +{
> +	int len;
> +
> +	/* TODO: Get system slot information via pci subsystem */
> +	if (!IS_ENABLED(CONFIG_OF_CONTROL))
> +		return 0;	/* Error, return 0-length */
> +
> +	len =3D smbios_scan_subnodes(current, ctx, handle,
> +				   smbios_write_type9_1slot,
> +				   SMBIOS_SYSSLOT_TYPE_UNKNOWN);
> +	if (len)
> +		return len;
> +
> +	/* if no subnode under 'system-slot', try scan the entire FDT */
> +	len =3D smbios_scan_slot_type(current, handle, ctx);
> +
> +	return len;
> +}
> +
>   #endif /* #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE) */
>  =20
>   static int smbios_write_type32(ulong *current, int *handle,
> @@ -905,6 +1197,9 @@ static struct smbios_write_method smbios_write_func=
s[] =3D {
>   	{ smbios_write_type7, "cache", },
>   #endif
>   	{ smbios_write_type4, "processor"},
> +#if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
> +	{ smbios_write_type9, "system-slot"},
> +#endif
>   	{ smbios_write_type32, },
>   	{ smbios_write_type127 },
>   };

