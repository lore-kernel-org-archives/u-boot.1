Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEA3ECE57A
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 15:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1B5088E14;
	Mon,  9 Sep 2024 17:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="e/dUOZ/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF02088DFA; Mon,  9 Sep 2024 17:31:34 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18BFC88ABE
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 17:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1725895863; x=1726500663; i=xypron.glpk@gmx.de;
 bh=/5qE3Ewa9NB7Ri4mR3rvWl6n0yjhIjhlZGskpNAC3UM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=e/dUOZ/lT9+a06tHGYNuh8zZ5A4HK6T+TdrrmnfrmMMkInNgHuW1SyAQuW/WCgqt
 1zLtz06nSYJgskm12sanASbBy2VaShvbsqI65q6iHtlFkCr6JVcBtcBF+Az8v6xYR
 4hz3po9LHf4caR5mY4Ck1BpZ+E5tKmOgT85gIFHJdAocTRy0VsGN97jfJjwa7JX9t
 4Z8gb3TQ+QGc9ZLlwFivrrQBIzcqP+nOZPAcRzo340GogBDGPXfRK+o1PUtm/FOcO
 VtDe/5XwPFk6kTvapNBxjxU+i9Wnt5sVvmjehSPSNbxMOoMGb2encS5LzqgfcrkBh
 5k6N+03547FJSR7jkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZCb5-1saIMA0UfB-00OEX0; Mon, 09
 Sep 2024 17:31:03 +0200
Message-ID: <cf966677-c64e-4b9e-9650-73ef5c8aecd2@gmx.de>
Date: Mon, 9 Sep 2024 17:30:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] smbios: Refactor SMBIOS library
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Alexander Gendin <agendin@matrox.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <20240816154658.1866186-4-raymond.mao@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240816154658.1866186-4-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gyemsGGJ+HrlaIFMxusysHnTL79qsAUdH8ka3rY4NbmLKVBk4T6
 pi28GYM/2VEoNRYxIT9TvASvduZjUOUnl6ZeLS98dDC635IaI9QmGhrcJtNulUC0YQayxQC
 +VMQmLGaN27LTxiky9SJaQuvQOIzj3ieAAU4e96FKWPDgzWaaO2QR3Bg7B4b+3WwUn7c07G
 8Y1nM+Dy4Fwf9cIYVGCnA==
UI-OutboundReport: notjunk:1;M01:P0:A/cQ/UuNE3c=;EZSlHvvXPB+RR6T+v04r1mBDlYv
 q+QW953bmE1MtPqOWsOW+YuFzfpzq4AB8z1NEVYy3W4Op0/iKb4d9rymYY2SlfWv4U61HLDyp
 nJB7kgEEzqRCn3TCw7cb0GCL3b5Yp3uSlq9gtZ+lajdJq3roOa243hsfGG8txlpXbMZzg2oqn
 DSsnvk4Pk/hjsESf0xC9afL/eG33uGGjVwBvT6WXzt0kE7W0P4dR+XnI900jk2lKNzVUnBF2a
 L69kd9jYLQg2bdU/FeF4Ca2A6dVvgwRb07okBZHwyIzUh3seTCp/AxYLr4182+m6SwV6QljLX
 M5IVwDPw+YoYzvCkrJ15dLbQgF+gnHjAp2MkX6LT+dYEfkl0jTpww8BBjSWT6r3BK4j/JC8sO
 1VycU4FQYnmNXybeAA4nCHNzZPVcYczyWWUfjar1+zpg87VHEYVz69UsF8unkjIBl1s2IqgiP
 /iAogY7A5rHQC/ox414mgr0hLc+0xORVB51VadSQBE75ZdqUvdn4TJBESUsZYA4Ao0fOn2Pyl
 OB3CEurBv6uIcHj/sO3z+KHcCchKkgKmXctVXlvcEJxMjuKi0egGmbnqhkRwUnBuNMvS8a0MM
 tsPvTJZeezLyOCQjM0oviPIwOblt0WoHYXHQzUk36ENnpRw2heRxRJVd5nrLx3mE19S6+esyf
 TVn5xr0GYFAC4NKIg+uc95lgAWdxR/q6zec7MrVjT06s40TSH72dycLFzwQQLYBICU0x2hwft
 yvAuu2y3vJC4ggW8sO2UipErYSruSDbhxdzdFl73zL1rJKfgnHYH+Xh0rdE4B5vJV31a24KGS
 x5/kQHdBy7G4XPXgCITBQzFQ==
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

On 16.08.24 17:46, Raymond Mao wrote:
> Current SMBIOS library does not fully match to the specification.
> It hardcodes values instead of exposing values from the device.
> It does not support dynamic length for contained object handles
> or elements and misses the handling of a few fields.
>
> The refactoring of this patch includes:
> 1. Expose values from device via sysinfo interface.
> 2. Replace smbios_add_prop with smbios_add_prop_si to allow getting
>     string values from sysinfo.
> 3. Add smbios_get_val_si to get int values from sysinfo.
> 4. Use sysinfo_get_data to get data area like contained object
>     handles, elements or processor id.
> 5. Refactor SMBIOS cmd print functions to match the command output
>     with the specification
> 6. Add new print functions for Type 0, 3 and 4.
> 7. Miscellaneous fixes in SMBIOS.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>   cmd/smbios.c     | 268 +++++++++++++++++++++++++++++++++--
>   include/smbios.h | 116 +++++++++++----
>   lib/smbios.c     | 358 ++++++++++++++++++++++++++++++++++++++---------
>   3 files changed, 632 insertions(+), 110 deletions(-)
>
> diff --git a/cmd/smbios.c b/cmd/smbios.c
> index d3bd8b12a67..8e2bf46a09c 100644
> --- a/cmd/smbios.c
> +++ b/cmd/smbios.c
> @@ -26,6 +26,71 @@ static const char * const wakeup_type_strings[] =3D {
>   	"AC Power Restored",	/* 0x08 */
>   };
>
> +static const char * const boardtype_strings[] =3D {
> +	"Reserved",			/* 0x00 */

0x00 is not in the spec. For all values that are not in the spec just
print the hexadecimal number.

> +	"Unknown",			/* 0x01 */
> +	"Other",			/* 0x02 */
> +	"Server Blade",			/* 0x03 */
> +	"Connectivity Switch",		/* 0x04 */
> +	"System Management Module",	/* 0x05 */
> +	"Processor Module",		/* 0x06 */
> +	"I/O Module",			/* 0x07 */
> +	"Memory Module",		/* 0x08 */
> +	"Daughter board",		/* 0x09 */
> +	"Motherboard",			/* 0x0a */
> +	"Processor/Memory Module",	/* 0x0b */
> +	"Processor/IO Module",		/* 0x0c */
> +	"Interconnect board",		/* 0x0d */
> +};
> +
> +static const char * const chassis_state_strings[] =3D {
> +	"Reserved",			/* 0x00 */

ditto

> +	"Other",			/* 0x01 */
> +	"Unknown",			/* 0x02 */
> +	"Safe",				/* 0x03 */
> +	"Warning",			/* 0x04 */
> +	"Critical",			/* 0x05 */
> +	"Non-recoverable",		/* 0x06 */
> +};
> +
> +static const char * const chassis_security_strings[] =3D {
> +	"Reserved",			/* 0x00 */

ditto

> +	"Other",			/* 0x01 */
> +	"Unknown",			/* 0x02 */
> +	"None",				/* 0x03 */
> +	"External interface locked out",/* 0x04 */
> +	"External interface enabled",	/* 0x05 */
> +};
> +
> +static const char * const processor_type_strings[] =3D {
> +	"Reserved",			/* 0x00 */

ditto

> +	"Other",			/* 0x01 */
> +	"Unknown",			/* 0x02 */
> +	"Central Processor",		/* 0x03 */
> +	"Math Processor",		/* 0x04 */
> +	"DSP Processor",		/* 0x05 */
> +	"Video Processor",		/* 0x06 */
> +};
> +
> +static const char * const processor_family_strings[] =3D {
> +	[0] =3D "Other",
> +	[1] =3D "Unknown",
> +	[2 ... 253] =3D "Other", /* skip these definitions from now */

"Other" should only be used for 0x01. In all other cases print the
hexadecimal number.

As we have hundreds of unused strings we should use a structure which
contains only used values to reduce the structure size, e.g.

struct processor_family_str {
	u16 index;
	const char *str;
};

const struct processor_family_str processor_family_strings;

> +	[254] =3D "Refer to 'Processor Family 2'",

This string should never be printed. Instead use the 'Processor Family
2' field to identify the family.

> +	[255] =3D "Reserved",
> +	[256] =3D "ARMv7",
> +	[257] =3D "ARMv8",

Please, add:

0x200 512 RISC-V RV32
0x201 513 RISC-V RV64

and the LoongArch values that we support.

Best regards

Heinrich

> +};
> +
> +static const char * const processor_upgrade_strings[] =3D {
> +	[0] =3D "Reserved",
> +	[1] =3D "Other",
> +	[2] =3D "Unknown",
> +	[3 ... 5] =3D "Other", /* skip these definitions from now */
> +	[6] =3D "None",
> +	[7 ... 80] =3D "Other", /* skip these definitions from now */
> +};
> +
>   /**
>    * smbios_get_string() - get SMBIOS string from table
>    *
> @@ -92,6 +157,32 @@ const char *smbios_wakeup_type_str(u8 wakeup_type)
>   	return wakeup_type_strings[wakeup_type];
>   }
>
> +static void smbios_print_type0(struct smbios_type0 *table)
> +{
> +	printf("BIOS Information\n");
> +	smbios_print_str("Vendor", table, table->vendor);
> +	smbios_print_str("BIOS Version", table, table->bios_ver);
> +	/* Keep table->bios_start_segment as 0 for UEFI-based systems */
> +	smbios_print_str("BIOS Release Date", table, table->bios_release_date)=
;
> +	printf("\tBIOS ROM Size: 0x%02x\n", table->bios_rom_size);
> +	printf("\tBIOS Characteristics: 0x%016llx\n",
> +	       table->bios_characteristics);
> +	printf("\tBIOS Characteristics Extension Byte 1: 0x%02x\n",
> +	       table->bios_characteristics_ext1);
> +	printf("\tBIOS Characteristics Extension Byte 2: 0x%02x\n",
> +	       table->bios_characteristics_ext2);
> +	printf("\tSystem BIOS Major Release: 0x%02x\n",
> +	       table->bios_major_release);
> +	printf("\tSystem BIOS Minor Release: 0x%02x\n",
> +	       table->bios_minor_release);
> +	printf("\tEmbedded Controller Firmware Major Release: 0x%02x\n",
> +	       table->ec_major_release);
> +	printf("\tEmbedded Controller Firmware Minor Release: 0x%02x\n",
> +	       table->ec_minor_release);
> +	printf("\tExtended BIOS ROM Size: 0x%04x\n",
> +	       table->extended_bios_rom_size);
> +}
> +
>   static void smbios_print_type1(struct smbios_type1 *table)
>   {
>   	printf("System Information\n");
> @@ -99,38 +190,180 @@ static void smbios_print_type1(struct smbios_type1=
 *table)
>   	smbios_print_str("Product Name", table, table->product_name);
>   	smbios_print_str("Version", table, table->version);
>   	smbios_print_str("Serial Number", table, table->serial_number);
> -	if (table->length >=3D 0x19) {
> +	if (table->hdr.length >=3D SMBIOS_TYPE1_LENGTH_V21) {
>   		printf("\tUUID: %pUl\n", table->uuid);
>   		printf("\tWake-up Type: %s\n",
>   		       smbios_wakeup_type_str(table->wakeup_type));
>   	}
> -	if (table->length >=3D 0x1b) {
> +	if (table->hdr.length >=3D SMBIOS_TYPE1_LENGTH_V24) {
>   		smbios_print_str("SKU Number", table, table->sku_number);
>   		smbios_print_str("Family", table, table->family);
>   	}
>   }
>
> +const char *smbios_baseboard_type_str(u8 borad_type)
> +{
> +	if (borad_type >=3D ARRAY_SIZE(boardtype_strings))
> +		borad_type =3D 0;
> +	return boardtype_strings[borad_type];
> +}
> +
>   static void smbios_print_type2(struct smbios_type2 *table)
>   {
> -	u16 *handle;
> +	int i;
> +	u8 *addr =3D (u8 *)table + offsetof(struct smbios_type2, eos);
>
> -	printf("Base Board Information\n");
> +	printf("Baseboard Information\n");
>   	smbios_print_str("Manufacturer", table, table->manufacturer);
>   	smbios_print_str("Product Name", table, table->product_name);
>   	smbios_print_str("Version", table, table->version);
>   	smbios_print_str("Serial Number", table, table->serial_number);
>   	smbios_print_str("Asset Tag", table, table->asset_tag_number);
> -	printf("\tFeature Flags: 0x%04x\n", table->feature_flags);
> +	printf("\tFeature Flags: 0x%02x\n", table->feature_flags);
>   	smbios_print_str("Chassis Location", table, table->chassis_location);
>   	printf("\tChassis Handle: 0x%04x\n", table->chassis_handle);
> -	smbios_print_str("Board Type", table, table->board_type);
> -	printf("\tContained Object Handles: ");
> -	handle =3D (void *)table->eos;
> -	for (int i =3D 0; i < table->number_contained_objects; ++i)
> -		printf("0x%04x ", handle[i]);
> +	printf("\tBoard Type: %s\n",
> +	       smbios_baseboard_type_str(table->board_type));
> +	printf("\tNumber of Contained Object Handles: 0x%02x\n",
> +	       table->number_contained_objects);
> +	if (!table->number_contained_objects)
> +		return;
> +
> +	printf("\tContained Object Handles:\n");
> +	for (i =3D 0; i < table->number_contained_objects; i++) {
> +		printf("\t\tObject[%03d]:\n", i);
> +		if (CONFIG_IS_ENABLED(HEXDUMP))
> +			print_hex_dump("\t\t", DUMP_PREFIX_OFFSET, 16, 1, addr,
> +				       sizeof(u16), false);
> +		addr +=3D sizeof(u16);
> +	}
>   	printf("\n");
>   }
>
> +const char *smbios_chassis_state_str(u8 state)
> +{
> +	if (state >=3D ARRAY_SIZE(chassis_state_strings))
> +		state =3D 0;
> +	return chassis_state_strings[state];
> +}
> +
> +const char *smbios_chassis_security_str(u8 status)
> +{
> +	if (status >=3D ARRAY_SIZE(chassis_security_strings))
> +		status =3D 0;
> +	return chassis_security_strings[status];
> +}
> +
> +static void smbios_print_type3(struct smbios_type3 *table)
> +{
> +	int i;
> +	u8 *addr =3D (u8 *)table + offsetof(struct smbios_type3, sku_number);
> +
> +	printf("Baseboard Information\n");
> +	smbios_print_str("Manufacturer", table, table->manufacturer);
> +	printf("\tType: 0x%02x\n", table->chassis_type);
> +	smbios_print_str("Version", table, table->version);
> +	smbios_print_str("Serial Number", table, table->serial_number);
> +	smbios_print_str("Asset Tag", table, table->asset_tag_number);
> +
> +	printf("\tBoot-up State: %s\n",
> +	       smbios_chassis_state_str(table->bootup_state));
> +	printf("\tPower Supply State: %s\n",
> +	       smbios_chassis_state_str(table->power_supply_state));
> +	printf("\tThermal State: %s\n",
> +	       smbios_chassis_state_str(table->thermal_state));
> +	printf("\tSecurity Status: %s\n",
> +	       smbios_chassis_security_str(table->security_status));
> +
> +	printf("\tOEM-defined: 0x%08x\n", table->oem_defined);
> +	printf("\tHeight: 0x%02x\n", table->height);
> +	printf("\tNumber of Power Cords: 0x%02x\n",
> +	       table->number_of_power_cords);
> +	printf("\tContained Element Count: 0x%02x\n", table->element_count);
> +	printf("\tContained Element Record Length: 0x%02x\n",
> +	       table->element_record_length);
> +	if (table->element_count) {
> +		printf("\tContained Elements:\n");
> +		for (i =3D 0; i < table->element_count; i++) {
> +			printf("\t\tElement[%03d]:\n", i);
> +			if (CONFIG_IS_ENABLED(HEXDUMP))
> +				print_hex_dump("\t\t", DUMP_PREFIX_OFFSET, 16,
> +					       1, addr,
> +					       table->element_record_length,
> +					       false);
> +			printf("\t\tContained Element Type: 0x%02x\n", *addr);
> +			printf("\t\tContained Element Minimum: 0x%02x\n",
> +			       *(addr + 1));
> +			printf("\t\tContained Element Maximum: 0x%02x\n",
> +			       *(addr + 2));
> +			addr +=3D table->element_record_length;
> +		}
> +	}
> +	smbios_print_str("SKU Number", table, *addr);
> +}
> +
> +const char *smbios_processor_type_str(u8 type)
> +{
> +	if (type >=3D ARRAY_SIZE(processor_type_strings))
> +		type =3D 0;
> +	return processor_type_strings[type];
> +}
> +
> +const char *smbios_processor_family_str(u16 family)
> +{
> +	if (family >=3D ARRAY_SIZE(processor_family_strings))
> +		family =3D 0;
> +
> +	return processor_family_strings[family];
> +}
> +
> +const char *smbios_processor_upgrade_str(u16 upgrade)
> +{
> +	if (upgrade >=3D ARRAY_SIZE(processor_upgrade_strings))
> +		upgrade =3D 0;
> +
> +	return processor_upgrade_strings[upgrade];
> +}
> +
> +static void smbios_print_type4(struct smbios_type4 *table)
> +{
> +	printf("Processor Information:\n");
> +	smbios_print_str("Socket Designation", table, table->socket_design);
> +	printf("\tProcessor Type: %s\n",
> +	       smbios_processor_type_str(table->processor_type));

u16 family =3D table->processor_family;
if (family =3D=3D 0xfe)
	family =3D table->processor_family2;

For values above 0xfe we must evaluate the table->processor_family2 field.

Best regards

Heinrich

> +	printf("\tProcessor Family: %s\n",
> +	       smbios_processor_family_str(table->processor_family));

smbios_processor_family_str(family));

> +	smbios_print_str("Processor Manufacturer", table,
> +			 table->processor_manufacturer);
> +	printf("\tProcessor ID word 0: 0x%08x\n", table->processor_id[0]);
> +	printf("\tProcessor ID word 1: 0x%08x\n", table->processor_id[1]);
> +	smbios_print_str("Processor Version", table, table->processor_version)=
;
> +	printf("\tVoltage: 0x%02x\n", table->voltage);
> +	printf("\tExternal Clock: 0x%04x\n", table->external_clock);
> +	printf("\tMax Speed: 0x%04x\n", table->max_speed);
> +	printf("\tCurrent Speed: 0x%04x\n", table->current_speed);
> +	printf("\tStatus: 0x%02x\n", table->status);
> +	printf("\tProcessor Upgrade: %s\n",
> +	       smbios_processor_upgrade_str(table->processor_upgrade));
> +	printf("\tL1 Cache Handle: 0x%04x\n", table->l1_cache_handle);
> +	printf("\tL2 Cache Handle: 0x%04x\n", table->l2_cache_handle);
> +	printf("\tL3 Cache Handle: 0x%04x\n", table->l3_cache_handle);
> +	smbios_print_str("Serial Number", table, table->serial_number);
> +	smbios_print_str("Asset Tag", table, table->asset_tag);
> +	smbios_print_str("Part Number", table, table->part_number);
> +	printf("\tCore Count: 0x%02x\n", table->core_count);
> +	printf("\tCore Enabled: 0x%02x\n", table->core_enabled);
> +	printf("\tThread Count: 0x%02x\n", table->thread_count);
> +	printf("\tProcessor Characteristics: 0x%04x\n",
> +	       table->processor_characteristics);
> +	printf("\tProcessor Family 2: %s\n",
> +	       smbios_processor_family_str(table->processor_family2));
> +	printf("\tCore Count 2: 0x%04x\n", table->core_count2);
> +	printf("\tCore Enabled 2: 0x%04x\n", table->core_enabled2);
> +	printf("\tThread Count 2: 0x%04x\n", table->thread_count2);
> +	printf("\tThread Enabled: 0x%04x\n", table->thread_enabled);
> +}
> +
>   static void smbios_print_type127(struct smbios_type127 *table)
>   {
>   	printf("End Of Table\n");
> @@ -192,13 +425,22 @@ static int do_smbios(struct cmd_tbl *cmdtp, int fl=
ag, int argc,
>   		       pos->handle, pos->type, pos->length,
>   		       (unsigned long long)map_to_sysmem(pos));
>   		switch (pos->type) {
> -		case 1:
> +		case SMBIOS_BIOS_INFORMATION:
> +			smbios_print_type0((struct smbios_type0 *)pos);
> +			break;
> +		case SMBIOS_SYSTEM_INFORMATION:
>   			smbios_print_type1((struct smbios_type1 *)pos);
>   			break;
> -		case 2:
> +		case SMBIOS_BOARD_INFORMATION:
>   			smbios_print_type2((struct smbios_type2 *)pos);
>   			break;
> -		case 127:
> +		case SMBIOS_SYSTEM_ENCLOSURE:
> +			smbios_print_type3((struct smbios_type3 *)pos);
> +			break;
> +		case SMBIOS_PROCESSOR_INFORMATION:
> +			smbios_print_type4((struct smbios_type4 *)pos);
> +			break;
> +		case SMBIOS_END_OF_TABLE:
>   			smbios_print_type127((struct smbios_type127 *)pos);
>   			break;
>   		default:
> diff --git a/include/smbios.h b/include/smbios.h
> index 60e28a89af8..f2269642268 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -80,19 +80,24 @@ struct __packed smbios3_entry {
>   	u64 struct_table_address;
>   };
>
> +struct __packed smbios_header {
> +	u8 type;
> +	u8 length;
> +	u16 handle;
> +};
> +
>   /* BIOS characteristics */
> -#define BIOS_CHARACTERISTICS_PCI_SUPPORTED	(1 << 7)
> -#define BIOS_CHARACTERISTICS_UPGRADEABLE	(1 << 11)
> -#define BIOS_CHARACTERISTICS_SELECTABLE_BOOT	(1 << 16)
>
> -#define BIOS_CHARACTERISTICS_EXT1_ACPI		(1 << 0)
> -#define BIOS_CHARACTERISTICS_EXT2_UEFI		(1 << 3)
> -#define BIOS_CHARACTERISTICS_EXT2_TARGET	(1 << 2)
> +#define BIOS_CHARACTERISTICS_PCI_SUPPORTED	BIT(7)
> +#define BIOS_CHARACTERISTICS_UPGRADEABLE	BIT(11)
> +#define BIOS_CHARACTERISTICS_SELECTABLE_BOOT	BIT(16)
> +
> +#define BIOS_CHARACTERISTICS_EXT1_ACPI		BIT(0)
> +#define BIOS_CHARACTERISTICS_EXT2_UEFI		BIT(3)
> +#define BIOS_CHARACTERISTICS_EXT2_TARGET	BIT(2)
>
>   struct __packed smbios_type0 {
> -	u8 type;
> -	u8 length;
> -	u16 handle;
> +	struct smbios_header hdr;
>   	u8 vendor;
>   	u8 bios_ver;
>   	u16 bios_start_segment;
> @@ -136,10 +141,12 @@ enum smbios_wakeup_type {
>   	SMBIOS_WAKEUP_TYPE_AC_POWER_RESTORED,
>   };
>
> +#define SMBIOS_TYPE1_LENGTH_V20		0x08
> +#define SMBIOS_TYPE1_LENGTH_V21		0x19
> +#define SMBIOS_TYPE1_LENGTH_V24		0x1b
> +
>   struct __packed smbios_type1 {
> -	u8 type;
> -	u8 length;
> -	u16 handle;
> +	struct smbios_header hdr;
>   	u8 manufacturer;
>   	u8 product_name;
>   	u8 version;
> @@ -151,8 +158,19 @@ struct __packed smbios_type1 {
>   	char eos[SMBIOS_STRUCT_EOS_BYTES];
>   };
>
> -#define SMBIOS_BOARD_FEATURE_HOSTING	(1 << 0)
> +#define SMBIOS_BOARD_UNKNOWN		1
> +#define SMBIOS_BOARD_OTHER		2
> +#define SMBIOS_BOARD_SERVER_BLADE	3
> +#define SMBIOS_BOARD_CON_SWITCH		4
> +#define SMBIOS_BOARD_SM_MODULE		5
> +#define SMBIOS_BOARD_PROCESSOR_MODULE	6
> +#define SMBIOS_BOARD_IO_MODULE		7
> +#define SMBIOS_BOARD_MEM_MODULE		8
> +#define SMBIOS_BOARD_DAUGHTER_BOARD	9
>   #define SMBIOS_BOARD_MOTHERBOARD	10
> +#define SMBIOS_BOARD_PROC_MEM_MODULE	11
> +#define SMBIOS_BOARD_PROC_IO_MODULE	12
> +#define SMBIOS_BOARD_INTERCON		13
>
>   union baseboard_feat {
>   	struct {
> @@ -167,9 +185,7 @@ union baseboard_feat {
>   };
>
>   struct __packed smbios_type2 {
> -	u8 type;
> -	u8 length;
> -	u16 handle;
> +	struct smbios_header hdr;
>   	u8 manufacturer;
>   	u8 product_name;
>   	u8 version;
> @@ -180,17 +196,29 @@ struct __packed smbios_type2 {
>   	u16 chassis_handle;
>   	u8 board_type;
>   	u8 number_contained_objects;
> +	/*
> +	 * Dynamic bytes will be inserted here to store the objects.
> +	 * length is equal to 'number_contained_objects'.
> +	 */
>   	char eos[SMBIOS_STRUCT_EOS_BYTES];
>   };
>
>   #define SMBIOS_ENCLOSURE_DESKTOP	3
>   #define SMBIOS_STATE_SAFE		3
>   #define SMBIOS_SECURITY_NONE		3
> +#define SMBIOS_ENCLOSURE_OEM_UND	0
> +#define SMBIOS_ENCLOSURE_HEIGHT_UND	0
> +#define SMBIOS_POWCORD_NUM_UND		0
> +#define SMBIOS_ELEMENT_TYPE_SELECT	BIT(7)
>
> -struct __packed smbios_type3 {
> +struct __packed elem_hdr {
>   	u8 type;
> -	u8 length;
> -	u16 handle;
> +	u8 minimum; /* 0 - 254 */
> +	u8 maximum; /* 1 - 255 */
> +};
> +
> +struct __packed smbios_type3 {
> +	struct smbios_header hdr;
>   	u8 manufacturer;
>   	u8 chassis_type;
>   	u8 version;
> @@ -205,21 +233,52 @@ struct __packed smbios_type3 {
>   	u8 number_of_power_cords;
>   	u8 element_count;
>   	u8 element_record_length;
> +	/*
> +	 * Dynamic bytes will be inserted here to store the elements.
> +	 * length is equal to 'element_record_length' * 'element_record_length=
'
> +	 */
> +	u8 sku_number;
>   	char eos[SMBIOS_STRUCT_EOS_BYTES];
>   };
>
> +#define SMBIOS_PROCESSOR_TYPE_OTHER	1
> +#define SMBIOS_PROCESSOR_TYPE_UNKNOWN	2
>   #define SMBIOS_PROCESSOR_TYPE_CENTRAL	3
> -#define SMBIOS_PROCESSOR_STATUS_ENABLED	1
> +#define SMBIOS_PROCESSOR_TYPE_MATH	4
> +#define SMBIOS_PROCESSOR_TYPE_DSP	5
> +#define SMBIOS_PROCESSOR_TYPE_VIDEO	6
> +
> +#define SMBIOS_PROCESSOR_STATUS_UNKNOWN		0
> +#define SMBIOS_PROCESSOR_STATUS_ENABLED		1
> +#define SMBIOS_PROCESSOR_STATUS_DISABLED_USER	2
> +#define SMBIOS_PROCESSOR_STATUS_DISABLED_BIOS	3
> +#define SMBIOS_PROCESSOR_STATUS_IDLE		4
> +#define SMBIOS_PROCESSOR_STATUS_OTHER		7
> +
>   #define SMBIOS_PROCESSOR_UPGRADE_NONE	6
>
>   #define SMBIOS_PROCESSOR_FAMILY_OTHER	1
>   #define SMBIOS_PROCESSOR_FAMILY_UNKNOWN	2
> +#define SMBIOS_PROCESSOR_FAMILY_ARMV7	256
> +#define SMBIOS_PROCESSOR_FAMILY_ARMV8	257
> +
> +#define SMBIOS_PROCESSOR_FAMILY_EXT	0xfe
> +
> +/* Processor Characteristics */
> +#define SMBIOS_PROCESSOR_RSVD		BIT(0)
> +#define SMBIOS_PROCESSOR_UND		BIT(1)
> +#define SMBIOS_PROCESSOR_64BIT		BIT(2)
> +#define SMBIOS_PROCESSOR_MULTICORE	BIT(3)
> +#define SMBIOS_PROCESSOR_HWTHREAD	BIT(4)
> +#define SMBIOS_PROCESSOR_EXEC_PROT	BIT(5)
> +#define SMBIOS_PROCESSOR_ENH_VIRT	BIT(6)
> +#define SMBIOS_PROCESSOR_POW_CON	BIT(7)
> +#define SMBIOS_PROCESSOR_128BIT		BIT(8)
> +#define SMBIOS_PROCESSOR_ARM64_SOCID	BIT(9)
>
>   struct __packed smbios_type4 {
> -	u8 type;
> -	u8 length;
> -	u16 handle;
> -	u8 socket_designation;
> +	struct smbios_header hdr;
> +	u8 socket_design;
>   	u8 processor_type;
>   	u8 processor_family;
>   	u8 processor_manufacturer;
> @@ -245,9 +304,12 @@ struct __packed smbios_type4 {
>   	u16 core_count2;
>   	u16 core_enabled2;
>   	u16 thread_count2;
> +	u16 thread_enabled;
>   	char eos[SMBIOS_STRUCT_EOS_BYTES];
>   };
>
> +#define SMBIOS_CACHE_HANDLE_NONE 0xffff
> +
>   struct __packed smbios_type32 {
>   	u8 type;
>   	u8 length;
> @@ -264,12 +326,6 @@ struct __packed smbios_type127 {
>   	char eos[SMBIOS_STRUCT_EOS_BYTES];
>   };
>
> -struct __packed smbios_header {
> -	u8 type;
> -	u8 length;
> -	u16 handle;
> -};
> -
>   /**
>    * fill_smbios_header() - Fill the header of an SMBIOS table
>    *
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 7c24ea129eb..8e481365165 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -8,6 +8,8 @@
>   #define LOG_CATEGORY	LOGC_BOARD
>
>   #include <dm.h>
> +#include <dm/device-internal.h>
> +#include <dm/lists.h>
>   #include <env.h>
>   #include <linux/stringify.h>
>   #include <linux/string.h>
> @@ -206,6 +208,26 @@ void get_str_from_dt(const struct map_sysinfo *npro=
p, char *str, size_t size)
>   	}
>   }
>
> +/**
> + * smbios_get_val_si() - Get value from sysinfo
> + *
> + * @ctx:	context of SMBIOS
> + * @sysinfo_id: unique identifier for the value to be read
> + * Return:	0 if not found, else value from sysinfo
> + */
> +static int smbios_get_val_si(struct smbios_ctx *ctx, int sysinfo_id)
> +{
> +	int val;
> +
> +	if (!sysinfo_id || !ctx->dev)
> +		return 0;
> +
> +	if (!sysinfo_get_int(ctx->dev, sysinfo_id, &val))
> +		return val;
> +
> +	return 0;
> +}
> +
>   /**
>    * smbios_add_prop_si() - Add a property from the devicetree or sysinf=
o
>    *
> @@ -225,8 +247,7 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx=
, const char *prop,
>   	if (!dval || !*dval)
>   		dval =3D NULL;
>
> -	if (!prop)
> -		return smbios_add_string(ctx, dval);
> +	log_debug("smbios: %s, sysinfo id: %d\n", prop, sysinfo_id);
>
>   	if (sysinfo_id && ctx->dev) {
>   		char val[SMBIOS_STR_MAX];
> @@ -235,6 +256,9 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx=
, const char *prop,
>   		if (!ret)
>   			return smbios_add_string(ctx, val);
>   	}
> +	if (!prop)
> +		return smbios_add_string(ctx, dval);
> +
>   	if (IS_ENABLED(CONFIG_OF_CONTROL)) {
>   		const char *str =3D NULL;
>   		char str_dt[128] =3D { 0 };
> @@ -247,6 +271,8 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx=
, const char *prop,
>   		} else {
>   			const struct map_sysinfo *nprop;
>
> +			log_debug("no smbios node, try the entire DT\n");
> +
>   			nprop =3D convert_sysinfo_to_dt(ctx->subnode_name, prop);
>   			get_str_from_dt(nprop, str_dt, sizeof(str_dt));
>   			str =3D (const char *)str_dt;
> @@ -330,15 +356,18 @@ static int smbios_write_type0(ulong *current, int =
handle,
>   			      struct smbios_ctx *ctx)
>   {
>   	struct smbios_type0 *t;
> -	int len =3D sizeof(struct smbios_type0);
> +	int len =3D sizeof(*t);
>
>   	t =3D map_sysmem(*current, len);
> -	memset(t, 0, sizeof(struct smbios_type0));
> +	memset(t, 0, len);
>   	fill_smbios_header(t, SMBIOS_BIOS_INFORMATION, len, handle);
>   	smbios_set_eos(ctx, t->eos);
> -	t->vendor =3D smbios_add_prop(ctx, NULL, "U-Boot");
> +	t->vendor =3D smbios_add_prop_si(ctx, NULL, SYSINFO_ID_SMBIOS_BIOS_VEN=
DOR,
> +				       "U-Boot");
>
> -	t->bios_ver =3D smbios_add_prop(ctx, "version", PLAIN_VERSION);
> +	t->bios_ver =3D smbios_add_prop_si(ctx, "version",
> +					 SYSINFO_ID_SMBIOS_BIOS_VER,
> +					 PLAIN_VERSION);
>   	if (t->bios_ver)
>   		gd->smbios_version =3D ctx->last_str;
>   	log_debug("smbios_version =3D %p: '%s'\n", gd->smbios_version,
> @@ -347,7 +376,9 @@ static int smbios_write_type0(ulong *current, int ha=
ndle,
>   	print_buffer((ulong)gd->smbios_version, gd->smbios_version,
>   		     1, strlen(gd->smbios_version) + 1, 0);
>   #endif
> -	t->bios_release_date =3D smbios_add_prop(ctx, NULL, U_BOOT_DMI_DATE);
> +	t->bios_release_date =3D
> +		smbios_add_prop_si(ctx, NULL, SYSINFO_ID_SMBIOS_BIOS_REL_DATE,
> +				   U_BOOT_DMI_DATE);
>   #ifdef CONFIG_ROM_SIZE
>   	if (CONFIG_ROM_SIZE < SZ_16M) {
>   		t->bios_rom_size =3D (CONFIG_ROM_SIZE / 65536) - 1;
> @@ -374,7 +405,7 @@ static int smbios_write_type0(ulong *current, int ha=
ndle,
>   	t->ec_major_release =3D 0xff;
>   	t->ec_minor_release =3D 0xff;
>
> -	len =3D t->length + smbios_string_table_len(ctx);
> +	len =3D t->hdr.length + smbios_string_table_len(ctx);
>   	*current +=3D len;
>   	unmap_sysmem(t);
>
> @@ -385,16 +416,18 @@ static int smbios_write_type1(ulong *current, int =
handle,
>   			      struct smbios_ctx *ctx)
>   {
>   	struct smbios_type1 *t;
> -	int len =3D sizeof(struct smbios_type1);
> +	int len =3D sizeof(*t);
>   	char *serial_str =3D env_get("serial#");
>
>   	t =3D map_sysmem(*current, len);
> -	memset(t, 0, sizeof(struct smbios_type1));
> +	memset(t, 0, len);
>   	fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, handle);
>   	smbios_set_eos(ctx, t->eos);
> -	t->manufacturer =3D smbios_add_prop_si(ctx, "manufacturer",
> -					     SYSINFO_ID_SMBIOS_SYSTEM_MANUFACTURER,
> -					     NULL);
> +
> +	t->manufacturer =3D
> +		smbios_add_prop_si(ctx, "manufacturer",
> +				   SYSINFO_ID_SMBIOS_SYSTEM_MANUFACTURER,
> +				   NULL);
>   	t->product_name =3D smbios_add_prop_si(ctx, "product",
>   					     SYSINFO_ID_SMBIOS_SYSTEM_PRODUCT,
>   					     NULL);
> @@ -403,19 +436,21 @@ static int smbios_write_type1(ulong *current, int =
handle,
>   					NULL);
>   	if (serial_str) {
>   		t->serial_number =3D smbios_add_prop(ctx, NULL, serial_str);
> -		strncpy((char *)t->uuid, serial_str, sizeof(t->uuid));
> +		strlcpy((char *)t->uuid, serial_str, sizeof(t->uuid));
>   	} else {
> -		t->serial_number =3D smbios_add_prop_si(ctx, "serial",
> -						      SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
> -						      NULL);
> +		t->serial_number =3D
> +			smbios_add_prop_si(ctx, "serial",
> +					   SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
> +					   NULL);
>   	}
> -	t->wakeup_type =3D SMBIOS_WAKEUP_TYPE_UNKNOWN;
> +	t->wakeup_type =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_SYSTEM_WAKEUP);
>   	t->sku_number =3D smbios_add_prop_si(ctx, "sku",
>   					   SYSINFO_ID_SMBIOS_SYSTEM_SKU, NULL);
>   	t->family =3D smbios_add_prop_si(ctx, "family",
>   				       SYSINFO_ID_SMBIOS_SYSTEM_FAMILY, NULL);
>
> -	len =3D t->length + smbios_string_table_len(ctx);
> +	len =3D t->hdr.length + smbios_string_table_len(ctx);
>   	*current +=3D len;
>   	unmap_sysmem(t);
>
> @@ -426,33 +461,80 @@ static int smbios_write_type2(ulong *current, int =
handle,
>   			      struct smbios_ctx *ctx)
>   {
>   	struct smbios_type2 *t;
> -	int len =3D sizeof(struct smbios_type2);
> +	int len =3D sizeof(*t);
> +	size_t obj_hdl_size =3D 0;
> +	u8 *obj_hdl =3D NULL;
> +	u8 *obj_addr, *eos_addr;
> +
> +	if (!sysinfo_get_data(ctx->dev, SYSINFO_ID_SMBIOS_BASEBOARD_OBJS_HANDL=
E,
> +			      &obj_hdl, &obj_hdl_size))
> +		len +=3D obj_hdl_size; /* Add the dynamic part */
>
>   	t =3D map_sysmem(*current, len);
> -	memset(t, 0, sizeof(struct smbios_type2));
> +	memset(t, 0, len);
> +
> +	/* Verify the contained object handles */
> +	t->number_contained_objects =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_BASEBOARD_OBJS_NUM);
> +
> +	if ((t->number_contained_objects * sizeof(u16) !=3D obj_hdl_size) ||
> +	    (!obj_hdl && (t->number_contained_objects || obj_hdl_size)) ||
> +	    (obj_hdl && (!t->number_contained_objects || !obj_hdl_size))) {
> +		/*
> +		 * Error with returning 0-length when any of below rules does
> +		 * not match:
> +		 * 1. Contained Object Handles length must be equal to (Object
> +		 *    Handle Length * Object Number).
> +		 * 2. If no Contained Object Handles exist, Object Number must
> +		 *    be 0, and versa vice.
> +		 */
> +		unmap_sysmem(t);
> +		return 0;
> +	}
> +
>   	fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, handle);
> +
> +	obj_addr =3D (u8 *)t + offsetof(struct smbios_type2, eos);
> +	/* eos is at the end of the structure */
> +	eos_addr =3D (u8 *)t + len - sizeof(t->eos);
>   	smbios_set_eos(ctx, t->eos);
> -	t->manufacturer =3D smbios_add_prop_si(ctx, "manufacturer",
> -					     SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
> -					     NULL);
> -	t->product_name =3D smbios_add_prop_si(ctx, "product",
> -					     SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
> -					     NULL);
> -	t->version =3D smbios_add_prop_si(ctx, "version",
> -					SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
> -					NULL);
> +	t->manufacturer =3D
> +		smbios_add_prop_si(ctx, "manufacturer",
> +				   SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
> +				   NULL);
> +	t->product_name =3D
> +		smbios_add_prop_si(ctx, "product",
> +				   SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
> +				   NULL);
> +	t->version =3D
> +		smbios_add_prop_si(ctx, "version",
> +				   SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
> +				   NULL);
> +	t->serial_number =3D
> +		smbios_add_prop_si(ctx, "serial",
> +				   SYSINFO_ID_SMBIOS_BASEBOARD_SERIAL,
> +				   NULL);
> +	t->asset_tag_number =3D
> +		smbios_add_prop_si(ctx, "asset-tag",
> +				   SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
> +				   NULL);
> +	t->feature_flags =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_BASEBOARD_FEATURE);
> +
> +	t->chassis_location =3D
> +		smbios_add_prop_si(ctx, "chassis-location",
> +				   SYSINFO_ID_SMBIOS_BASEBOARD_CHASSIS_LOCAT,
> +				   NULL);
> +	t->board_type =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_BASEBOARD_TYPE);
> +
> +	/* Get the objs from driver */
> +	if (obj_hdl)
> +		memcpy(obj_addr, obj_hdl, obj_hdl_size);
>
> -	t->serial_number =3D smbios_add_prop_si(ctx, "serial",
> -					      SYSINFO_ID_SMBIOS_BASEBOARD_SERIAL,
> -					      NULL);
> -	t->asset_tag_number =3D smbios_add_prop_si(ctx, "asset-tag",
> -						 SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
> -						 NULL);
> -	t->feature_flags =3D SMBIOS_BOARD_FEATURE_HOSTING;
> -	t->board_type =3D SMBIOS_BOARD_MOTHERBOARD;
>   	t->chassis_handle =3D handle + 1;
>
> -	len =3D t->length + smbios_string_table_len(ctx);
> +	len =3D t->hdr.length + smbios_string_table_len(ctx);
>   	*current +=3D len;
>   	unmap_sysmem(t);
>
> @@ -463,20 +545,94 @@ static int smbios_write_type3(ulong *current, int =
handle,
>   			      struct smbios_ctx *ctx)
>   {
>   	struct smbios_type3 *t;
> -	int len =3D sizeof(struct smbios_type3);
> +	int len =3D sizeof(*t);
> +	u8 *elem =3D NULL;
> +	u8 *elem_addr, *eos_addr, *sku_num_addr;
> +	size_t elem_size =3D 0;
> +
> +	if (!sysinfo_get_data(ctx->dev, SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENTS,
> +			      &elem, &elem_size))
> +		len +=3D elem_size; /* Add the dynamic part */
>
>   	t =3D map_sysmem(*current, len);
> -	memset(t, 0, sizeof(struct smbios_type3));
> +	memset(t, 0, len);
> +
> +	/* Verify the contained elements */
> +	t->element_count =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENT_CNT);
> +
> +	t->element_record_length =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENT_LEN);
> +
> +	if ((elem_size !=3D t->element_record_length * t->element_count) ||
> +	    (!elem && (t->element_count || t->element_record_length ||
> +		       elem_size)) ||
> +	    (elem && (t->element_record_length < sizeof(struct elem_hdr) ||
> +		       !elem_size))) {
> +		/*
> +		 * Error with returning 0-length when any of below rules does
> +		 * not match:
> +		 * 1. Contained Elements length must be equal to (Element
> +		 *    Record Length * Element Count).
> +		 * 2. If no Contained Elements exist, Element Count and Element
> +		 *    Record Length must be 0.
> +		 * 3. If Contained Elements exist, Element Record Length must
> +		 *    be at least the size of the Element Record Header.
> +		 */
> +		unmap_sysmem(t);
> +		return 0;
> +	}
> +
>   	fill_smbios_header(t, SMBIOS_SYSTEM_ENCLOSURE, len, handle);
> -	smbios_set_eos(ctx, t->eos);
> -	t->manufacturer =3D smbios_add_prop(ctx, "manufacturer", NULL);
> -	t->chassis_type =3D SMBIOS_ENCLOSURE_DESKTOP;
> -	t->bootup_state =3D SMBIOS_STATE_SAFE;
> -	t->power_supply_state =3D SMBIOS_STATE_SAFE;
> -	t->thermal_state =3D SMBIOS_STATE_SAFE;
> -	t->security_status =3D SMBIOS_SECURITY_NONE;
> -
> -	len =3D t->length + smbios_string_table_len(ctx);
> +
> +	elem_addr =3D (u8 *)t + offsetof(struct smbios_type3, sku_number);
> +	sku_num_addr =3D elem_addr + elem_size;
> +
> +	/* eos is at the end of the structure */
> +	eos_addr =3D (u8 *)t + len - sizeof(t->eos);
> +	smbios_set_eos(ctx, eos_addr);
> +
> +	t->manufacturer =3D
> +		smbios_add_prop_si(ctx, "manufacturer",
> +				   SYSINFO_ID_SMBIOS_ENCLOSURE_MANUFACTURER,
> +				   NULL);
> +
> +	t->chassis_type =3D smbios_get_val_si(ctx,
> +					    SYSINFO_ID_SMBIOS_ENCLOSURE_TYPE);
> +	t->version =3D smbios_add_prop_si(ctx, "version",
> +					SYSINFO_ID_SMBIOS_ENCLOSURE_VERSION,
> +					NULL);
> +	t->serial_number =3D
> +		smbios_add_prop_si(ctx, "serial",
> +				   SYSINFO_ID_SMBIOS_ENCLOSURE_SERIAL,
> +				   NULL);
> +	t->asset_tag_number =3D
> +		smbios_add_prop_si(ctx, "asset-tag",
> +				   SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
> +				   NULL);
> +	t->bootup_state =3D smbios_get_val_si(ctx,
> +					    SYSINFO_ID_SMBIOS_ENCLOSURE_BOOTUP);
> +	t->power_supply_state =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_ENCLOSURE_POW);
> +	t->thermal_state =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_ENCLOSURE_THERMAL);
> +	t->security_status =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_ENCLOSURE_SECURITY);
> +	t->oem_defined =3D smbios_get_val_si(ctx,
> +					   SYSINFO_ID_SMBIOS_ENCLOSURE_OEM);
> +	t->height =3D smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_ENCLOSURE_HEIGH=
T);
> +	t->number_of_power_cords =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_ENCLOSURE_POWCORE_NUM);
> +
> +	/* Get the elements from driver */
> +	if (elem)
> +		memcpy(elem_addr, elem, elem_size);
> +
> +	*sku_num_addr =3D
> +		smbios_add_prop_si(ctx, "sku", SYSINFO_ID_SMBIOS_ENCLOSURE_SKU,
> +				   NULL);
> +
> +	len =3D t->hdr.length + smbios_string_table_len(ctx);
>   	*current +=3D len;
>   	unmap_sysmem(t);
>
> @@ -489,6 +645,8 @@ static void smbios_write_type4_dm(struct smbios_type=
4 *t,
>   	u16 processor_family =3D SMBIOS_PROCESSOR_FAMILY_UNKNOWN;
>   	const char *vendor =3D NULL;
>   	const char *name =3D NULL;
> +	u8 *id_data =3D NULL;
> +	size_t id_size =3D 0;
>
>   #ifdef CONFIG_CPU
>   	char processor_name[49];
> @@ -511,31 +669,97 @@ static void smbios_write_type4_dm(struct smbios_ty=
pe4 *t,
>   	}
>   #endif
>
> -	t->processor_family =3D 0xfe;
> +	if (processor_family =3D=3D SMBIOS_PROCESSOR_FAMILY_UNKNOWN)
> +		processor_family =3D
> +			smbios_get_val_si(ctx,
> +					  SYSINFO_ID_SMBIOS_PROCESSOR_FAMILY2);
> +
> +	t->processor_family =3D SMBIOS_PROCESSOR_FAMILY_EXT;
>   	t->processor_family2 =3D processor_family;
> -	t->processor_manufacturer =3D smbios_add_prop(ctx, NULL, vendor);
> -	t->processor_version =3D smbios_add_prop(ctx, NULL, name);
> +
> +	t->processor_manufacturer =3D
> +		smbios_add_prop_si(ctx, NULL,
> +				   SYSINFO_ID_SMBIOS_PROCESSOR_MANUFACT,
> +				   vendor);
> +	t->processor_version =3D
> +		smbios_add_prop_si(ctx, NULL,
> +				   SYSINFO_ID_SMBIOS_PROCESSOR_VERSION,
> +				   name);
> +
> +	if (t->processor_id[0] || t->processor_id[1])
> +		return;
> +
> +	if (sysinfo_get_data(ctx->dev, SYSINFO_ID_SMBIOS_PROCESSOR_ID,
> +			     &id_data, &id_size) ||
> +	    id_size !=3D sizeof(t->processor_id))
> +		return;
> +	if (id_data)
> +		memcpy((u8 *)t->processor_id, id_data, id_size);
> +
>   }
>
>   static int smbios_write_type4(ulong *current, int handle,
>   			      struct smbios_ctx *ctx)
>   {
>   	struct smbios_type4 *t;
> -	int len =3D sizeof(struct smbios_type4);
> +	int len =3D sizeof(*t);
>
>   	t =3D map_sysmem(*current, len);
> -	memset(t, 0, sizeof(struct smbios_type4));
> +	memset(t, 0, len);
>   	fill_smbios_header(t, SMBIOS_PROCESSOR_INFORMATION, len, handle);
>   	smbios_set_eos(ctx, t->eos);
> -	t->processor_type =3D SMBIOS_PROCESSOR_TYPE_CENTRAL;
> +	t->socket_design =3D
> +		smbios_add_prop_si(ctx, NULL,
> +				   SYSINFO_ID_SMBIOS_PROCESSOR_SOCKET,
> +				   NULL);
> +	t->processor_type =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_TYPE);
>   	smbios_write_type4_dm(t, ctx);
> -	t->status =3D SMBIOS_PROCESSOR_STATUS_ENABLED;
> -	t->processor_upgrade =3D SMBIOS_PROCESSOR_UPGRADE_NONE;
> -	t->l1_cache_handle =3D 0xffff;
> -	t->l2_cache_handle =3D 0xffff;
> -	t->l3_cache_handle =3D 0xffff;
>
> -	len =3D t->length + smbios_string_table_len(ctx);
> +	t->voltage =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_VOLTAGE);
> +	t->external_clock =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_EXT_CLOCK);
> +	t->max_speed =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_MAX_SPEED);
> +	t->current_speed =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_CUR_SPEED);
> +	t->status =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_STATUS);
> +	t->processor_upgrade =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_UPGRADE);
> +
> +	t->l1_cache_handle =3D SMBIOS_CACHE_HANDLE_NONE;
> +	t->l2_cache_handle =3D SMBIOS_CACHE_HANDLE_NONE;
> +	t->l3_cache_handle =3D SMBIOS_CACHE_HANDLE_NONE;
> +
> +	t->serial_number =3D smbios_add_prop_si(ctx, NULL,
> +					      SYSINFO_ID_SMBIOS_PROCESSOR_SN,
> +					      NULL);
> +	t->asset_tag =3D smbios_add_prop_si(ctx, NULL,
> +					  SYSINFO_ID_SMBIOS_PROCESSOR_ASSET_TAG,
> +					  NULL);
> +	t->part_number =3D smbios_add_prop_si(ctx, NULL,
> +					    SYSINFO_ID_SMBIOS_PROCESSOR_PN,
> +					    NULL);
> +	t->core_count =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT);
> +	t->core_enabled =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN);
> +	t->thread_count =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT);
> +	t->processor_characteristics =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_CHARA);
> +	t->core_count2 =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT2);
> +	t->core_enabled2 =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN2);
> +	t->thread_count2 =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT2);
> +	t->thread_enabled =3D
> +		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_EN);
> +
> +	len =3D t->hdr.length + smbios_string_table_len(ctx);
>   	*current +=3D len;
>   	unmap_sysmem(t);
>
> @@ -546,10 +770,10 @@ static int smbios_write_type32(ulong *current, int=
 handle,
>   			       struct smbios_ctx *ctx)
>   {
>   	struct smbios_type32 *t;
> -	int len =3D sizeof(struct smbios_type32);
> +	int len =3D sizeof(*t);
>
>   	t =3D map_sysmem(*current, len);
> -	memset(t, 0, sizeof(struct smbios_type32));
> +	memset(t, 0, len);
>   	fill_smbios_header(t, SMBIOS_SYSTEM_BOOT_INFORMATION, len, handle);
>   	smbios_set_eos(ctx, t->eos);
>
> @@ -563,10 +787,10 @@ static int smbios_write_type127(ulong *current, in=
t handle,
>   				struct smbios_ctx *ctx)
>   {
>   	struct smbios_type127 *t;
> -	int len =3D sizeof(struct smbios_type127);
> +	int len =3D sizeof(*t);
>
>   	t =3D map_sysmem(*current, len);
> -	memset(t, 0, sizeof(struct smbios_type127));
> +	memset(t, 0, len);
>   	fill_smbios_header(t, SMBIOS_END_OF_TABLE, len, handle);
>
>   	*current +=3D len;
> @@ -598,7 +822,7 @@ ulong write_smbios_table(ulong addr)
>   	int i;
>
>   	ctx.node =3D ofnode_null();
> -	if (IS_ENABLED(CONFIG_OF_CONTROL) && CONFIG_IS_ENABLED(SYSINFO)) {
> +	if (CONFIG_IS_ENABLED(SYSINFO)) {
>   		uclass_first_device(UCLASS_SYSINFO, &ctx.dev);
>   		if (ctx.dev) {
>   			int ret;

