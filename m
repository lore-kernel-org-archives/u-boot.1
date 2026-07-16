Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0310C44514
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 19:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8BBE84D2A;
	Thu, 16 Jul 2026 21:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iYaiXnaH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7536484D55; Thu, 16 Jul 2026 21:38:50 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8A5584D17
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 21:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784230727; x=1784835527; i=xypron.glpk@gmx.de;
 bh=yZnJBnkZfwosiG1Q7IzaoovXz/qlUV9AHIzyQLgdOyI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=iYaiXnaHQGEcDkOug1regrzeWDDhMOKyt5SlNt4nIGtFsqp5ALlNj1Uv3M/FKVc7
 cxVlpQgdSg1XaMKf3fcZNFYjx5xhnUZjFPa5vi2ZlEj+POTLbXt94nCc0nme4LLE6
 jQrczvJG5JHURnFgdu1wIk0JtoiAVWeNtb0Sx7tQVx79sXeR8FjXAS6ZwCZ4eqcEc
 zwsrxXV6nJSPlnlOxZhA8oLPjFzYHgnpG1HUb7LivvrAP2KwY9P0AWHUqq6mMOLiG
 BzAbssl2m17dbtVpFz+zb/BzvXzNlUoNhuXe1wJuSRf/1EaJT3jcAUrN0/N4bDdqD
 kbcnL5Y9x/t/2BQVyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKKX-1wmKXm0aqH-00Eakl; Thu, 16
 Jul 2026 21:38:47 +0200
Message-ID: <fea71de5-8572-4b4c-96da-1b201f72097b@gmx.de>
Date: Thu, 16 Jul 2026 21:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] efi: Unify memory map type and attribute names
To: Aristo Chen <aristo.chen@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
References: <20260711091559.1842381-1-aristo.chen@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260711091559.1842381-1-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BXHreI663KbimIyzZoZU073yzU/6gyHtur/Ff6LX0bDToNwUlbJ
 LltTODX+5ckuSrH/vSS/i4IgnoKEth6R91nUqFx4mucqNhILDEp40hjFwGoojTEznwO3z4m
 m1FPxVrfwgniV0scCP2tWMOckRKrz8FePqrIto+Xfm0H9OqYmPga8OepIXioQkwNglGC20o
 cz6p29lFEEhZziHrMzFCg==
UI-OutboundReport: notjunk:1;M01:P0:FMR4R48HhxA=;M6Gp4Ok1IZDNc5HSybHOKsKnqTt
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

On 7/11/26 11:15, Aristo Chen wrote:
> The efi and efidebug commands each carry their own table of EFI memory
> type names and memory attribute names. The two copies have drifted:
> efidebug knows EFI_PERSISTENT_MEMORY_TYPE while 'efi mem' prints it as
> '<invalid>', and neither table knows EFI_UNACCEPTED_MEMORY_TYPE.
>=20
> Move a single copy of both tables into efi_common.c, which is already
> linked into both commands, and provide efi_mem_type_name() and
> efi_print_mem_attrs() accessors. Add the two missing memory types.
>=20
> The output of 'efi mem' now uses the same names as efidebug, for
> example PAL instead of pal_code, and its attributes key now lists the
> attribute mnemonics instead of long names. The efidebug memmap name
> ACPI RECLAIM MEM becomes ACPI RECLAIM so that the shared name also fits
> the narrower column of 'efi mem'. Update the examples in the efi
> command documentation accordingly.
>=20
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>   cmd/efi.c             |  53 +---------
>   cmd/efi_common.c      |  64 ++++++++++++
>   cmd/efidebug.c        |  69 +-----------
>   doc/usage/cmd/efi.rst | 238 +++++++++++++++++++++---------------------
>   include/efi.h         |  19 ++++
>   5 files changed, 207 insertions(+), 236 deletions(-)
>=20
> diff --git a/cmd/efi.c b/cmd/efi.c
> index 687ccb52042..fc8f1d511c0 100644
> --- a/cmd/efi.c
> +++ b/cmd/efi.c
> @@ -16,42 +16,6 @@
>  =20
>   DECLARE_GLOBAL_DATA_PTR;
>  =20
> -static const char *const type_name[] =3D {
> -	"reserved",
> -	"loader_code",
> -	"loader_data",
> -	"bs_code",
> -	"bs_data",
> -	"rt_code",
> -	"rt_data",
> -	"conv",
> -	"unusable",
> -	"acpi_reclaim",
> -	"acpi_nvs",
> -	"io",
> -	"io_port",
> -	"pal_code",
> -};
> -
> -static struct attr_info {
> -	u64 val;
> -	const char *name;
> -} mem_attr[] =3D {
> -	{ EFI_MEMORY_UC, "uncached" },
> -	{ EFI_MEMORY_WC, "write-coalescing" },
> -	{ EFI_MEMORY_WT, "write-through" },
> -	{ EFI_MEMORY_WB, "write-back" },
> -	{ EFI_MEMORY_UCE, "uncached & exported" },
> -	{ EFI_MEMORY_WP, "write-protect" },
> -	{ EFI_MEMORY_RP, "read-protect" },
> -	{ EFI_MEMORY_XP, "execute-protect" },
> -	{ EFI_MEMORY_NV, "non-volatile" },
> -	{ EFI_MEMORY_MORE_RELIABLE, "higher reliability" },
> -	{ EFI_MEMORY_RO, "read-only" },
> -	{ EFI_MEMORY_SP, "specific purpose" },
> -	{ EFI_MEMORY_RUNTIME, "needs runtime mapping" }
> -};
> -
>   /* Maximum different attribute values we can track */
>   #define ATTR_SEEN_MAX	30
>  =20
> @@ -175,8 +139,7 @@ static void efi_print_mem_table(struct efi_mem_desc =
*desc, int desc_size,
>   		}
>   		size =3D desc->num_pages << EFI_PAGE_SHIFT;
>  =20
> -		name =3D desc->type < ARRAY_SIZE(type_name) ?
> -				type_name[desc->type] : "<invalid>";
> +		name =3D efi_mem_type_name(desc->type) ?: "<invalid>";
>   		printf("%2d  %x:%-12s  %010llx  %010llx  %010llx  ", upto,
>   		       desc->type, name, desc->physical_start,
>   		       desc->virtual_start, size);
> @@ -197,20 +160,10 @@ static void efi_print_mem_table(struct efi_mem_des=
c *desc, int desc_size,
>   	printf("\nAttributes key:\n");
>   	for (i =3D 0; i < attr_seen_count; i++) {
>   		u64 attr =3D attr_seen[i];
> -		bool first;
> -		int j;
>  =20
> -		printf("%c%llx: ", (attr & EFI_MEMORY_RUNTIME) ? 'r' : ' ',
> +		printf("%c%llx:", (attr & EFI_MEMORY_RUNTIME) ? 'r' : ' ',
>   		       attr & ~EFI_MEMORY_RUNTIME);
> -		for (j =3D 0, first =3D true; j < ARRAY_SIZE(mem_attr); j++) {
> -			if (attr & mem_attr[j].val) {
> -				if (first)
> -					first =3D false;
> -				else
> -					printf(", ");
> -				printf("%s", mem_attr[j].name);
> -			}
> -		}
> +		efi_print_mem_attrs(attr);
>   		putc('\n');
>   	}
>   	if (skip_bs)
> diff --git a/cmd/efi_common.c b/cmd/efi_common.c
> index d2f2b59e9e3..8df2369add6 100644
> --- a/cmd/efi_common.c
> +++ b/cmd/efi_common.c
> @@ -10,6 +10,46 @@
>   #include <efi_api.h>
>   #include <u-boot/uuid.h>
>  =20
> +static const char *const efi_mem_type_string[] =3D {
> +	[EFI_RESERVED_MEMORY_TYPE] =3D "RESERVED",
> +	[EFI_LOADER_CODE] =3D "LOADER CODE",
> +	[EFI_LOADER_DATA] =3D "LOADER DATA",
> +	[EFI_BOOT_SERVICES_CODE] =3D "BOOT CODE",
> +	[EFI_BOOT_SERVICES_DATA] =3D "BOOT DATA",
> +	[EFI_RUNTIME_SERVICES_CODE] =3D "RUNTIME CODE",
> +	[EFI_RUNTIME_SERVICES_DATA] =3D "RUNTIME DATA",
> +	[EFI_CONVENTIONAL_MEMORY] =3D "CONVENTIONAL",
> +	[EFI_UNUSABLE_MEMORY] =3D "UNUSABLE MEM",
> +	[EFI_ACPI_RECLAIM_MEMORY] =3D "ACPI RECLAIM",
> +	[EFI_ACPI_MEMORY_NVS] =3D "ACPI NVS",
> +	[EFI_MMAP_IO] =3D "IO",
> +	[EFI_MMAP_IO_PORT] =3D "IO PORT",
> +	[EFI_PAL_CODE] =3D "PAL",
> +	[EFI_PERSISTENT_MEMORY_TYPE] =3D "PERSISTENT",
> +	[EFI_UNACCEPTED_MEMORY_TYPE] =3D "UNACCEPTED",

Thank you for looking into code deduplication.

Do we want to keep the strict upper casing?

These are the strings from the EFI spec:

EfiReservedMemoryType
EfiLoaderCode
EfiLoaderData
EfiBootServicesCode
EfiBootServicesData
EfiRuntimeServicesCode
EfiRuntimeServicesData
EfiConventionalMemory
EfiUnusableMemory
EfiACPIReclaimMemory
EfiACPIMemoryNVS
EfiMemoryMappedIO
EfiMemoryMappedIOPortSpace
EfiPalCode
EfiPersistentMemory
EfiUnacceptedMemoryType

Should we use excacly these strings after stripping the leading 'Efi'=20
and trailing 'Type'?

> +};
> +
> +static const struct efi_mem_attrs {
> +	const u64 bit;
> +	const char *text;
> +} efi_mem_attrs[] =3D {
> +	{EFI_MEMORY_UC, "UC"},
> +	{EFI_MEMORY_WC, "WC"},
> +	{EFI_MEMORY_WT, "WT"},
> +	{EFI_MEMORY_WB, "WB"},
> +	{EFI_MEMORY_UCE, "UCE"},
> +	{EFI_MEMORY_WP, "WP"},
> +	{EFI_MEMORY_RP, "RP"},
> +	{EFI_MEMORY_XP, "XP"},
> +	{EFI_MEMORY_NV, "NV"},
> +	{EFI_MEMORY_MORE_RELIABLE, "REL"},
> +	{EFI_MEMORY_RO, "RO"},
> +	{EFI_MEMORY_SP, "SP"},
> +	{EFI_MEMORY_CPU_CRYPTO, "CRYPT"},
> +	{EFI_MEMORY_HOT_PLUGGABLE, "HOTPL"},
> +	{EFI_MEMORY_RUNTIME, "RT"},
> +};
> +
>   void efi_show_tables(struct efi_system_table *systab)
>   {
>   	int i;
> @@ -21,3 +61,27 @@ void efi_show_tables(struct efi_system_table *systab)
>   		       uuid_guid_get_str(tab->guid.b) ?: "(unknown)");
>   	}
>   }
> +
> +const char *efi_mem_type_name(u32 type)
> +{
> +	if (type >=3D ARRAY_SIZE(efi_mem_type_string))
> +		return NULL;
> +
> +	return efi_mem_type_string[type];
> +}
> +
> +void efi_print_mem_attrs(u64 attributes)
> +{
> +	int sep, i;
> +
> +	for (sep =3D 0, i =3D 0; i < ARRAY_SIZE(efi_mem_attrs); i++)
> +		if (attributes & efi_mem_attrs[i].bit) {
 > +			if (sep) {> +				putc('|');
> +			} else {
> +				putc(' ');
> +				sep =3D 1;
> +			}
> +			puts(efi_mem_attrs[i].text);

How should we handle invalid bits?
How about EFI_MEMORY_ISA_VALID?
How about the bits in EFI_MEMORY_ISA_MASK?

> +		}
> +}
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index a6faa36b500..7d0c56ce265 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -574,68 +574,6 @@ static int do_efi_show_ecpt(struct cmd_tbl *cmdtp, =
int flag, int argc,
>   }
>   #endif /* CONFIG_IS_ENABLED(EFI_ECPT) */
>  =20
> -static const char * const efi_mem_type_string[] =3D {
> -	[EFI_RESERVED_MEMORY_TYPE] =3D "RESERVED",
> -	[EFI_LOADER_CODE] =3D "LOADER CODE",
> -	[EFI_LOADER_DATA] =3D "LOADER DATA",
> -	[EFI_BOOT_SERVICES_CODE] =3D "BOOT CODE",
> -	[EFI_BOOT_SERVICES_DATA] =3D "BOOT DATA",
> -	[EFI_RUNTIME_SERVICES_CODE] =3D "RUNTIME CODE",
> -	[EFI_RUNTIME_SERVICES_DATA] =3D "RUNTIME DATA",
> -	[EFI_CONVENTIONAL_MEMORY] =3D "CONVENTIONAL",
> -	[EFI_UNUSABLE_MEMORY] =3D "UNUSABLE MEM",
> -	[EFI_ACPI_RECLAIM_MEMORY] =3D "ACPI RECLAIM MEM",
> -	[EFI_ACPI_MEMORY_NVS] =3D "ACPI NVS",
> -	[EFI_MMAP_IO] =3D "IO",
> -	[EFI_MMAP_IO_PORT] =3D "IO PORT",
> -	[EFI_PAL_CODE] =3D "PAL",
> -	[EFI_PERSISTENT_MEMORY_TYPE] =3D "PERSISTENT",
> -};
> -
> -static const struct efi_mem_attrs {
> -	const u64 bit;
> -	const char *text;
> -} efi_mem_attrs[] =3D {
> -	{EFI_MEMORY_UC, "UC"},
> -	{EFI_MEMORY_WC, "WC"},
> -	{EFI_MEMORY_WT, "WT"},
> -	{EFI_MEMORY_WB, "WB"},
> -	{EFI_MEMORY_UCE, "UCE"},
> -	{EFI_MEMORY_WP, "WP"},
> -	{EFI_MEMORY_RP, "RP"},
> -	{EFI_MEMORY_XP, "XP"},
> -	{EFI_MEMORY_NV, "NV"},
> -	{EFI_MEMORY_MORE_RELIABLE, "REL"},
> -	{EFI_MEMORY_RO, "RO"},
> -	{EFI_MEMORY_SP, "SP"},
> -	{EFI_MEMORY_CPU_CRYPTO, "CRYPT"},
> -	{EFI_MEMORY_HOT_PLUGGABLE, "HOTPL"},
> -	{EFI_MEMORY_RUNTIME, "RT"},
> -};
> -
> -/**
> - * print_memory_attributes() - print memory map attributes
> - *
> - * @attributes:	Attribute value
> - *
> - * Print memory map attributes
> - */
> -static void print_memory_attributes(u64 attributes)
> -{
> -	int sep, i;
> -
> -	for (sep =3D 0, i =3D 0; i < ARRAY_SIZE(efi_mem_attrs); i++)
> -		if (attributes & efi_mem_attrs[i].bit) {
> -			if (sep) {
> -				putc('|');
> -			} else {
> -				putc(' ');
> -				sep =3D 1;
> -			}
> -			puts(efi_mem_attrs[i].text);
> -		}
> -}
> -
>   #define EFI_PHYS_ADDR_WIDTH (int)(sizeof(efi_physical_addr_t) * 2)
>  =20
>   /**
> @@ -673,10 +611,7 @@ static int do_efi_show_memmap(struct cmd_tbl *cmdtp=
, int flag,
>   	 * populated by allocate_pool() above.
>   	 */
>   	for (i =3D 0, map =3D memmap; i < map_size / sizeof(*map); map++, i++=
) {
> -		if (map->type < ARRAY_SIZE(efi_mem_type_string))
> -			type =3D efi_mem_type_string[map->type];
> -		else
> -			type =3D "(unknown)";
> +		type =3D efi_mem_type_name(map->type) ?: "(unknown)";
>  =20
>   		printf("%-16s %.*llx-%.*llx", type,
>   		       EFI_PHYS_ADDR_WIDTH,
> @@ -687,7 +622,7 @@ static int do_efi_show_memmap(struct cmd_tbl *cmdtp,=
 int flag,
>   					  (map->physical_start +
>   					   map->num_pages * EFI_PAGE_SIZE)));


Why do we keep both efi_show_memmap() and efi_print_mem_table()?
They seem both to be printing the same type of information but in=20
different format.

efi_print_mem_table() seems to have bugs as described below. Let's=20
replace it by a common efi_show_memmap() version.

>  =20
> -		print_memory_attributes(map->attribute);
> +		efi_print_mem_attrs(map->attribute);
>   		putc('\n');
>   	}
>  =20
> diff --git a/doc/usage/cmd/efi.rst b/doc/usage/cmd/efi.rst
> index b19d36188a9..b8b029f4dd2 100644
> --- a/doc/usage/cmd/efi.rst
> +++ b/doc/usage/cmd/efi.rst
> @@ -74,139 +74,139 @@ Example
>       =3D> efi mem
>       EFI table at 0, memory map 000000001ad38b60, size 1260, key a79, v=
ersion 1, descr. size 0x30
>        #  Type              Physical     Virtual        Size  Attributes
> -     0  7:conv          0000000000  0000000000  00000a0000  f
> +     0  7:CONVENTIONAL  0000000000  0000000000  00000a0000  f
>           <gap>           00000a0000              0000060000
> -     1  7:conv          0000100000  0000000000  0000700000  f
> -     2  a:acpi_nvs      0000800000  0000000000  0000008000  f
> -     3  7:conv          0000808000  0000000000  0000008000  f
> -     4  a:acpi_nvs      0000810000  0000000000  00000f0000  f
> -     5  7:conv          0000900000  0000000000  001efef000  f
> -     6  6:rt_data       001f8ef000  0000000000  0000100000  rf
> -     7  5:rt_code       001f9ef000  0000000000  0000100000  rf
> -     8  0:reserved      001faef000  0000000000  0000080000  f
> -     9  9:acpi_reclaim  001fb6f000  0000000000  0000010000  f
> -    10  a:acpi_nvs      001fb7f000  0000000000  0000080000  f
> -    11  7:conv          001fbff000  0000000000  0000359000  f
> -    12  6:rt_data       001ff58000  0000000000  0000020000  rf
> -    13  a:acpi_nvs      001ff78000  0000000000  0000088000  f
> +     1  7:CONVENTIONAL  0000100000  0000000000  0000700000  f
> +     2  a:ACPI NVS      0000800000  0000000000  0000008000  f
> +     3  7:CONVENTIONAL  0000808000  0000000000  0000008000  f
> +     4  a:ACPI NVS      0000810000  0000000000  00000f0000  f
> +     5  7:CONVENTIONAL  0000900000  0000000000  001efef000  f
> +     6  6:RUNTIME DATA  001f8ef000  0000000000  0000100000  rf
> +     7  5:RUNTIME CODE  001f9ef000  0000000000  0000100000  rf
> +     8  0:RESERVED      001faef000  0000000000  0000080000  f
> +     9  9:ACPI RECLAIM  001fb6f000  0000000000  0000010000  f
> +    10  a:ACPI NVS      001fb7f000  0000000000  0000080000  f
> +    11  7:CONVENTIONAL  001fbff000  0000000000  0000359000  f
> +    12  6:RUNTIME DATA  001ff58000  0000000000  0000020000  rf
> +    13  a:ACPI NVS      001ff78000  0000000000  0000088000  f
>           <gap>           0020000000              0090000000
> -    14  0:reserved      00b0000000  0000000000  0010000000  1
> +    14  0:RESERVED      00b0000000  0000000000  0010000000  1
>  =20
>       Attributes key:
> -     f: uncached, write-coalescing, write-through, write-back
> -    rf: uncached, write-coalescing, write-through, write-back, needs ru=
ntime mapping
> -     1: uncached
> +     f: UC|WC|WT|WB
> +    rf: UC|WC|WT|WB|RT
> +     1: UC
>       *Some areas are merged (use 'all' to see)
>  =20
>  =20
>       =3D> efi mem  all
>       EFI table at 0, memory map 000000001ad38bb0, size 1260, key a79, v=
ersion 1, descr. size 0x30
>        #  Type              Physical     Virtual        Size  Attributes

@Simon

Here are some issues I see with the output of `efi mem all`. Using the=20
same output as `efidebug memmap` should be adequate.

Some headers are right aligned though the values all have the same width.
he header is not even properly aligned to the columns.

> -     0  3:bs_code       0000000000  0000000000  0000001000  f

Memory is 1:1 mapped before SetVirtualAddressMap().
The column for VirtualAddress seems to be superfluous in this output.

EDK II sets the virtual address value to 0 in function CoreAddRange()=20
and asserts that it is 0 in CoreGetMemoryMap().

In U-Boot we set VirtualStart =3D=3D PhysicalStart.

The UEFI specification provides no guidance here.
The value of this field should be ignored before SetVirtualAddress().

> -     1  7:conv          0000001000  0000000000  000009f000  f
> +     0  3:BOOT CODE     0000000000  0000000000  0000001000  f
> +     1  7:CONVENTIONAL  0000001000  0000000000  000009f000  f
>           <gap>           00000a0000              0000060000

On 64bit systems using 16 digit numbers would be adequate.

There seems to be formatting issue with the '<gap>' line.

Best regards

Heinrich


> -     2  7:conv          0000100000  0000000000  0000700000  f
> -     3  a:acpi_nvs      0000800000  0000000000  0000008000  f
> -     4  7:conv          0000808000  0000000000  0000008000  f
> -     5  a:acpi_nvs      0000810000  0000000000  00000f0000  f
> -     6  4:bs_data       0000900000  0000000000  0000c00000  f
> -     7  7:conv          0001500000  0000000000  000aa36000  f
> -     8  2:loader_data   000bf36000  0000000000  0010000000  f
> -     9  4:bs_data       001bf36000  0000000000  0000020000  f
> -    10  7:conv          001bf56000  0000000000  00021e1000  f
> -    11  1:loader_code   001e137000  0000000000  00000c4000  f
> -    12  7:conv          001e1fb000  0000000000  000009b000  f
> -    13  1:loader_code   001e296000  0000000000  00000e2000  f
> -    14  7:conv          001e378000  0000000000  000005b000  f
> -    15  4:bs_data       001e3d3000  0000000000  000001e000  f
> -    16  7:conv          001e3f1000  0000000000  0000016000  f
> -    17  4:bs_data       001e407000  0000000000  0000016000  f
> -    18  2:loader_data   001e41d000  0000000000  0000002000  f
> -    19  4:bs_data       001e41f000  0000000000  0000828000  f
> -    20  3:bs_code       001ec47000  0000000000  0000045000  f
> -    21  4:bs_data       001ec8c000  0000000000  0000001000  f
> -    22  3:bs_code       001ec8d000  0000000000  000000e000  f
> -    23  4:bs_data       001ec9b000  0000000000  0000001000  f
> -    24  3:bs_code       001ec9c000  0000000000  000002c000  f
> -    25  4:bs_data       001ecc8000  0000000000  0000001000  f
> -    26  3:bs_code       001ecc9000  0000000000  000000c000  f
> -    27  4:bs_data       001ecd5000  0000000000  0000006000  f
> -    28  3:bs_code       001ecdb000  0000000000  0000014000  f
> -    29  4:bs_data       001ecef000  0000000000  0000001000  f
> -    30  3:bs_code       001ecf0000  0000000000  000005b000  f
> -    31  4:bs_data       001ed4b000  0000000000  000000b000  f
> -    32  3:bs_code       001ed56000  0000000000  0000024000  f
> -    33  4:bs_data       001ed7a000  0000000000  0000006000  f
> -    34  3:bs_code       001ed80000  0000000000  0000010000  f
> -    35  4:bs_data       001ed90000  0000000000  0000002000  f
> -    36  3:bs_code       001ed92000  0000000000  0000025000  f
> -    37  4:bs_data       001edb7000  0000000000  0000003000  f
> -    38  3:bs_code       001edba000  0000000000  0000011000  f
> -    39  4:bs_data       001edcb000  0000000000  0000008000  f
> -    40  3:bs_code       001edd3000  0000000000  000002d000  f
> -    41  4:bs_data       001ee00000  0000000000  0000201000  f
> -    42  3:bs_code       001f001000  0000000000  0000024000  f
> -    43  4:bs_data       001f025000  0000000000  0000002000  f
> -    44  3:bs_code       001f027000  0000000000  0000009000  f
> -    45  4:bs_data       001f030000  0000000000  0000005000  f
> -    46  3:bs_code       001f035000  0000000000  000002f000  f
> -    47  4:bs_data       001f064000  0000000000  0000001000  f
> -    48  3:bs_code       001f065000  0000000000  0000005000  f
> -    49  4:bs_data       001f06a000  0000000000  0000005000  f
> -    50  3:bs_code       001f06f000  0000000000  0000007000  f
> -    51  4:bs_data       001f076000  0000000000  0000007000  f
> -    52  3:bs_code       001f07d000  0000000000  000000d000  f
> -    53  4:bs_data       001f08a000  0000000000  0000001000  f
> -    54  3:bs_code       001f08b000  0000000000  0000006000  f
> -    55  4:bs_data       001f091000  0000000000  0000004000  f
> -    56  3:bs_code       001f095000  0000000000  000000d000  f
> -    57  4:bs_data       001f0a2000  0000000000  0000003000  f
> -    58  3:bs_code       001f0a5000  0000000000  0000026000  f
> -    59  4:bs_data       001f0cb000  0000000000  0000005000  f
> -    60  3:bs_code       001f0d0000  0000000000  0000019000  f
> -    61  4:bs_data       001f0e9000  0000000000  0000004000  f
> -    62  3:bs_code       001f0ed000  0000000000  0000024000  f
> -    63  4:bs_data       001f111000  0000000000  0000008000  f
> -    64  3:bs_code       001f119000  0000000000  000000b000  f
> -    65  4:bs_data       001f124000  0000000000  0000001000  f
> -    66  3:bs_code       001f125000  0000000000  0000002000  f
> -    67  4:bs_data       001f127000  0000000000  0000002000  f
> -    68  3:bs_code       001f129000  0000000000  0000009000  f
> -    69  4:bs_data       001f132000  0000000000  0000003000  f
> -    70  3:bs_code       001f135000  0000000000  0000005000  f
> -    71  4:bs_data       001f13a000  0000000000  0000003000  f
> -    72  3:bs_code       001f13d000  0000000000  0000005000  f
> -    73  4:bs_data       001f142000  0000000000  0000003000  f
> -    74  3:bs_code       001f145000  0000000000  0000011000  f
> -    75  4:bs_data       001f156000  0000000000  000000b000  f
> -    76  3:bs_code       001f161000  0000000000  0000009000  f
> -    77  4:bs_data       001f16a000  0000000000  0000400000  f
> -    78  3:bs_code       001f56a000  0000000000  0000006000  f
> -    79  4:bs_data       001f570000  0000000000  0000001000  f
> -    80  3:bs_code       001f571000  0000000000  0000001000  f
> -    81  4:bs_data       001f572000  0000000000  0000002000  f
> -    82  3:bs_code       001f574000  0000000000  0000017000  f
> -    83  4:bs_data       001f58b000  0000000000  0000364000  f
> -    84  6:rt_data       001f8ef000  0000000000  0000100000  rf
> -    85  5:rt_code       001f9ef000  0000000000  0000100000  rf
> -    86  0:reserved      001faef000  0000000000  0000080000  f
> -    87  9:acpi_reclaim  001fb6f000  0000000000  0000010000  f
> -    88  a:acpi_nvs      001fb7f000  0000000000  0000080000  f
> -    89  4:bs_data       001fbff000  0000000000  0000201000  f
> -    90  7:conv          001fe00000  0000000000  00000e8000  f
> -    91  4:bs_data       001fee8000  0000000000  0000020000  f
> -    92  3:bs_code       001ff08000  0000000000  0000026000  f
> -    93  4:bs_data       001ff2e000  0000000000  0000009000  f
> -    94  3:bs_code       001ff37000  0000000000  0000021000  f
> -    95  6:rt_data       001ff58000  0000000000  0000020000  rf
> -    96  a:acpi_nvs      001ff78000  0000000000  0000088000  f
> +     2  7:CONVENTIONAL  0000100000  0000000000  0000700000  f
> +     3  a:ACPI NVS      0000800000  0000000000  0000008000  f
> +     4  7:CONVENTIONAL  0000808000  0000000000  0000008000  f
> +     5  a:ACPI NVS      0000810000  0000000000  00000f0000  f
> +     6  4:BOOT DATA     0000900000  0000000000  0000c00000  f
> +     7  7:CONVENTIONAL  0001500000  0000000000  000aa36000  f
> +     8  2:LOADER DATA   000bf36000  0000000000  0010000000  f
> +     9  4:BOOT DATA     001bf36000  0000000000  0000020000  f
> +    10  7:CONVENTIONAL  001bf56000  0000000000  00021e1000  f
> +    11  1:LOADER CODE   001e137000  0000000000  00000c4000  f
> +    12  7:CONVENTIONAL  001e1fb000  0000000000  000009b000  f
> +    13  1:LOADER CODE   001e296000  0000000000  00000e2000  f
> +    14  7:CONVENTIONAL  001e378000  0000000000  000005b000  f
> +    15  4:BOOT DATA     001e3d3000  0000000000  000001e000  f
> +    16  7:CONVENTIONAL  001e3f1000  0000000000  0000016000  f
> +    17  4:BOOT DATA     001e407000  0000000000  0000016000  f
> +    18  2:LOADER DATA   001e41d000  0000000000  0000002000  f
> +    19  4:BOOT DATA     001e41f000  0000000000  0000828000  f
> +    20  3:BOOT CODE     001ec47000  0000000000  0000045000  f
> +    21  4:BOOT DATA     001ec8c000  0000000000  0000001000  f
> +    22  3:BOOT CODE     001ec8d000  0000000000  000000e000  f
> +    23  4:BOOT DATA     001ec9b000  0000000000  0000001000  f
> +    24  3:BOOT CODE     001ec9c000  0000000000  000002c000  f
> +    25  4:BOOT DATA     001ecc8000  0000000000  0000001000  f
> +    26  3:BOOT CODE     001ecc9000  0000000000  000000c000  f
> +    27  4:BOOT DATA     001ecd5000  0000000000  0000006000  f
> +    28  3:BOOT CODE     001ecdb000  0000000000  0000014000  f
> +    29  4:BOOT DATA     001ecef000  0000000000  0000001000  f
> +    30  3:BOOT CODE     001ecf0000  0000000000  000005b000  f
> +    31  4:BOOT DATA     001ed4b000  0000000000  000000b000  f
> +    32  3:BOOT CODE     001ed56000  0000000000  0000024000  f
> +    33  4:BOOT DATA     001ed7a000  0000000000  0000006000  f
> +    34  3:BOOT CODE     001ed80000  0000000000  0000010000  f
> +    35  4:BOOT DATA     001ed90000  0000000000  0000002000  f
> +    36  3:BOOT CODE     001ed92000  0000000000  0000025000  f
> +    37  4:BOOT DATA     001edb7000  0000000000  0000003000  f
> +    38  3:BOOT CODE     001edba000  0000000000  0000011000  f
> +    39  4:BOOT DATA     001edcb000  0000000000  0000008000  f
> +    40  3:BOOT CODE     001edd3000  0000000000  000002d000  f
> +    41  4:BOOT DATA     001ee00000  0000000000  0000201000  f
> +    42  3:BOOT CODE     001f001000  0000000000  0000024000  f
> +    43  4:BOOT DATA     001f025000  0000000000  0000002000  f
> +    44  3:BOOT CODE     001f027000  0000000000  0000009000  f
> +    45  4:BOOT DATA     001f030000  0000000000  0000005000  f
> +    46  3:BOOT CODE     001f035000  0000000000  000002f000  f
> +    47  4:BOOT DATA     001f064000  0000000000  0000001000  f
> +    48  3:BOOT CODE     001f065000  0000000000  0000005000  f
> +    49  4:BOOT DATA     001f06a000  0000000000  0000005000  f
> +    50  3:BOOT CODE     001f06f000  0000000000  0000007000  f
> +    51  4:BOOT DATA     001f076000  0000000000  0000007000  f
> +    52  3:BOOT CODE     001f07d000  0000000000  000000d000  f
> +    53  4:BOOT DATA     001f08a000  0000000000  0000001000  f
> +    54  3:BOOT CODE     001f08b000  0000000000  0000006000  f
> +    55  4:BOOT DATA     001f091000  0000000000  0000004000  f
> +    56  3:BOOT CODE     001f095000  0000000000  000000d000  f
> +    57  4:BOOT DATA     001f0a2000  0000000000  0000003000  f
> +    58  3:BOOT CODE     001f0a5000  0000000000  0000026000  f
> +    59  4:BOOT DATA     001f0cb000  0000000000  0000005000  f
> +    60  3:BOOT CODE     001f0d0000  0000000000  0000019000  f
> +    61  4:BOOT DATA     001f0e9000  0000000000  0000004000  f
> +    62  3:BOOT CODE     001f0ed000  0000000000  0000024000  f
> +    63  4:BOOT DATA     001f111000  0000000000  0000008000  f
> +    64  3:BOOT CODE     001f119000  0000000000  000000b000  f
> +    65  4:BOOT DATA     001f124000  0000000000  0000001000  f
> +    66  3:BOOT CODE     001f125000  0000000000  0000002000  f
> +    67  4:BOOT DATA     001f127000  0000000000  0000002000  f
> +    68  3:BOOT CODE     001f129000  0000000000  0000009000  f
> +    69  4:BOOT DATA     001f132000  0000000000  0000003000  f
> +    70  3:BOOT CODE     001f135000  0000000000  0000005000  f
> +    71  4:BOOT DATA     001f13a000  0000000000  0000003000  f
> +    72  3:BOOT CODE     001f13d000  0000000000  0000005000  f
> +    73  4:BOOT DATA     001f142000  0000000000  0000003000  f
> +    74  3:BOOT CODE     001f145000  0000000000  0000011000  f
> +    75  4:BOOT DATA     001f156000  0000000000  000000b000  f
> +    76  3:BOOT CODE     001f161000  0000000000  0000009000  f
> +    77  4:BOOT DATA     001f16a000  0000000000  0000400000  f
> +    78  3:BOOT CODE     001f56a000  0000000000  0000006000  f
> +    79  4:BOOT DATA     001f570000  0000000000  0000001000  f
> +    80  3:BOOT CODE     001f571000  0000000000  0000001000  f
> +    81  4:BOOT DATA     001f572000  0000000000  0000002000  f
> +    82  3:BOOT CODE     001f574000  0000000000  0000017000  f
> +    83  4:BOOT DATA     001f58b000  0000000000  0000364000  f
> +    84  6:RUNTIME DATA  001f8ef000  0000000000  0000100000  rf
> +    85  5:RUNTIME CODE  001f9ef000  0000000000  0000100000  rf
> +    86  0:RESERVED      001faef000  0000000000  0000080000  f
> +    87  9:ACPI RECLAIM  001fb6f000  0000000000  0000010000  f
> +    88  a:ACPI NVS      001fb7f000  0000000000  0000080000  f
> +    89  4:BOOT DATA     001fbff000  0000000000  0000201000  f
> +    90  7:CONVENTIONAL  001fe00000  0000000000  00000e8000  f
> +    91  4:BOOT DATA     001fee8000  0000000000  0000020000  f
> +    92  3:BOOT CODE     001ff08000  0000000000  0000026000  f
> +    93  4:BOOT DATA     001ff2e000  0000000000  0000009000  f
> +    94  3:BOOT CODE     001ff37000  0000000000  0000021000  f
> +    95  6:RUNTIME DATA  001ff58000  0000000000  0000020000  rf
> +    96  a:ACPI NVS      001ff78000  0000000000  0000088000  f
>           <gap>           0020000000              0090000000
> -    97  0:reserved      00b0000000  0000000000  0010000000  1
> +    97  0:RESERVED      00b0000000  0000000000  0010000000  1
>  =20
>       Attributes key:
> -     f: uncached, write-coalescing, write-through, write-back
> -    rf: uncached, write-coalescing, write-through, write-back, needs ru=
ntime mapping
> -     1: uncached
> +     f: UC|WC|WT|WB
> +    rf: UC|WC|WT|WB|RT
> +     1: UC
>  =20
>  =20
>       =3D> efi tables
> diff --git a/include/efi.h b/include/efi.h
> index b98871fedad..079ceae1eb1 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -681,6 +681,25 @@ int efi_get_mmap(struct efi_mem_desc **descp, int *=
sizep, uint *keyp,
>    */
>   void efi_show_tables(struct efi_system_table *systab);
>  =20
> +/**
> + * efi_mem_type_name() - get the name of an EFI memory type
> + *
> + * @type: memory type (enum efi_memory_type)
> + * Return: name of the memory type, or NULL if @type is unknown
> + */
> +const char *efi_mem_type_name(u32 type);
> +
> +/**
> + * efi_print_mem_attrs() - print the names of set EFI memory attributes
> + *
> + * Prints the set attribute bits as a '|'-separated list of names, e.g.
> + * ' UC|WB|RT', preceded by a space. Prints nothing if no known attribu=
te
> + * bit is set.
> + *
> + * @attributes: memory attributes (EFI_MEMORY_...)
> + */
> +void efi_print_mem_attrs(u64 attributes);
> +
>   /**
>    * efi_get_basename() - Get the default filename to use when loading
>    *

