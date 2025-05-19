Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70894C3DA6D
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 09:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 808C381FEE;
	Mon, 19 May 2025 11:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="HpimUmB5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3618482A76; Mon, 19 May 2025 11:57:31 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED54D81E72
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 11:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7234638148=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J9Krnk006605;
 Mon, 19 May 2025 11:57:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Pg/12hQngtmTV8OXAQJrLcgRmWk6cIuDXCGxViOGFfc=; b=HpimUmB5IaHMrcNi
 GSQXlAG7ZsrQUzijHuPZTgjCDJ0m5LxJq7AvUHjkKulnEKI9pWwXJfzY1okq4a8D
 niBcsrBztiG1uyGy6bw2YnqCgFACGA2wjyzLcIWrKEjj9yUuzGZX/Q3WTw891H+0
 KHYjUdgU/PkuFZq9QfkymAJRaWgBqraXDOmgEwVahci3bxJD5pvyJtRc/QTRWbZb
 AmbGCh618nhP1OtvgC07yAKhdp2OhXchOAotl7z9s1zvf696isvK2MusX+HSXwde
 x+eINETwN7gq1YIfDviOqasb7N+kG0vs3mvcILyrPsVgGaDdebEvnpHBsjYylzyF
 XL5Jhw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46phbgeap1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 11:57:23 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1C71F4004C;
 Mon, 19 May 2025 11:56:17 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 61FA0AB62BE;
 Mon, 19 May 2025 11:55:30 +0200 (CEST)
Received: from [10.48.86.182] (10.48.86.182) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 11:55:29 +0200
Message-ID: <9d8fe91a-bb27-4fda-a3e3-c7af2eb184fc@foss.st.com>
Date: Mon, 19 May 2025 11:55:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] lib/uuid.c: restore support of system partition type
 for ESP
To: Jerome Forissier <jerome.forissier@linaro.org>, <u-boot@lists.denx.de>
CC: <ilias.apalodimas@linaro.org>, <patrice.chotard@foss.st.com>,
 <caleb.connolly@linaro.org>, Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250519090421.470942-1-patrick.delaunay@foss.st.com>
 <20250519110417.1.Ie741b1ca358414a1d718dca0667ac44eefc9227b@changeid>
 <71947acc-d77c-4cd2-9a15-d679a0e53a8c@linaro.org>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <71947acc-d77c-4cd2-9a15-d679a0e53a8c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
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

Hi,

On 5/19/25 11:23, Jerome Forissier wrote:
> Hi Patrick,
>
> On 5/19/25 10:04, Patrick Delaunay wrote:
>> Add support of shortname for type parameter and restore "system"
>> as short name for EFI System Partition (ESP) for filed "type" of the
>> "gpt write" command.
>>
>> Fixes: d54e1004b8b1 ("lib/uuid.c: use unique name for PARTITION_SYSTEM_GUID")
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>>
>>   lib/uuid.c | 148 +++++++++++++++++++++++++++--------------------------
>>   1 file changed, 76 insertions(+), 72 deletions(-)
>>
>> diff --git a/lib/uuid.c b/lib/uuid.c
>> index 6abbcf27b1f3..ee02fa4d600d 100644
>> --- a/lib/uuid.c
>> +++ b/lib/uuid.c
>> @@ -62,184 +62,185 @@ int uuid_str_valid(const char *uuid)
>>   	return 1;
>>   }
>>   
>> +/* List of known GUID for GPT partition type */
>>   static const struct {
>> -	const char *string;
>> +	const char *string;     /* name for type parameter of gpt command */
> const char *type?


yes it is possible...

I don't change existing name just to avoid to change too many part of 
the existing code.


>
>> +	const char *description;/* description used for %pUs */
>>   	efi_guid_t guid;
>>   } list_guid[] = {
>>   #ifndef USE_HOSTCC
>> -#if defined(CONFIG_PARTITION_TYPE_GUID) || defined(CONFIG_CMD_EFIDEBUG) || \
>> -	defined(CONFIG_EFI)
>> -	{"EFI System Partition", PARTITION_SYSTEM_GUID},
>> -#endif
>> -#ifdef CONFIG_PARTITION_TYPE_GUID
>> -	{"mbr",		LEGACY_MBR_PARTITION_GUID},
>> -	{"msft",	PARTITION_MSFT_RESERVED_GUID},
>> -	{"data",	PARTITION_BASIC_DATA_GUID},
>> -	{"linux",	PARTITION_LINUX_FILE_SYSTEM_DATA_GUID},
>> -	{"raid",	PARTITION_LINUX_RAID_GUID},
>> -	{"swap",	PARTITION_LINUX_SWAP_GUID},
>> -	{"lvm",		PARTITION_LINUX_LVM_GUID},
>> -	{"u-boot-env",	PARTITION_U_BOOT_ENVIRONMENT},
>> -	{"cros-kern",	PARTITION_CROS_KERNEL},
>> -	{"cros-root",	PARTITION_CROS_ROOT},
>> -	{"cros-fw",	PARTITION_CROS_FIRMWARE},
>> -	{"cros-rsrv",	PARTITION_CROS_RESERVED},
>> -#endif
>> +#if CONFIG_IS_ENABLED(EFI_PARTITION)
>> +	{"mbr",		NULL,	LEGACY_MBR_PARTITION_GUID},
>> +	{"msft",	NULL,	PARTITION_MSFT_RESERVED_GUID},
>> +	{"data",	NULL,	PARTITION_BASIC_DATA_GUID},
>> +	{"linux",	NULL,	PARTITION_LINUX_FILE_SYSTEM_DATA_GUID},
>> +	{"raid",	NULL,	PARTITION_LINUX_RAID_GUID},
>> +	{"swap",	NULL,	PARTITION_LINUX_SWAP_GUID},
>> +	{"lvm",		NULL,	PARTITION_LINUX_LVM_GUID},
>> +	{"u-boot-env",	NULL,	PARTITION_U_BOOT_ENVIRONMENT},
>> +	{"cros-kern",	NULL,	PARTITION_CROS_KERNEL},
>> +	{"cros-root",	NULL,	PARTITION_CROS_ROOT},
>> +	{"cros-fw",	NULL,	PARTITION_CROS_FIRMWARE},
>> +	{"cros-rsrv",	NULL,	PARTITION_CROS_RESERVED},
>>   #if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI)
>>   	{
>> -		"Device Path",
>> +		"system", "EFI System Partition",
>> +		PARTITION_SYSTEM_GUID,
>> +	},
> The patch adds quite many NULLs to the list_guid[] only for this very
> special case. We would be better off hardcoding the "system" case into
> uuid_guid_get_bin() I think.

I don't like the hardcoded solution in lib

or the other possible workaround:

#if defined(CONFIG_PARTITION_TYPE_GUID) || defined(CONFIG_CMD_EFIDEBUG) 
|| \
     defined(CONFIG_EFI)
       {"EFI System Partition", PARTITION_SYSTEM_GUID},
+    {"system",    PARTITION_SYSTEM_GUID},
#endif


     with this simple modification
     - first occurrence is used to display information (long name = 
uuid_guid_get_str)
     - second occurrence s used for gpt command parameter 'type=system'  
with ( uuid_str_to_bin => uuid_guid_get_bin)


And it is not ONLY for "system"....  but also for "mbr", "u-boot-env"...

my proposal avoids confusion for

- short name (with limited size and without SPACE) with can be used for 
short in 'type=' parameter

   also used as description when description is absent

- long description for partition (only used for information), without 
limitation (size, space).....


and prepare addition for new short name for other knwon type UID


PS: only the last added EFI partitions don't respected the first 
restriction...

      but someone can be added short name for EFI partitons, without 
change long description

      for example

+		"dtb", "device tree",
+		"dtbo", "Device-Tree Fixup",


We must have limited size in short name because in cmd/gpt.c:533 we have


#ifdef CONFIG_PARTITION_TYPE_GUID
         /* guid */
         val = extract_val(tok, "type");
         if (val) {
             /* 'type' is optional */
             if (extract_env(val, &p))
                 p = val;
             if (strnlen(p, max_str_part) >= sizeof(parts[i].type_guid)) {
                 printf("Wrong type guid format for partition %d\n",
                        i);
                 errno = -4;
                 goto err;
             }
             strncpy((char *)parts[i].type_guid, p, max_str_part);
             free(val);
         }
#endif


So for STRING parameter, used as short cut) in 'type=' is also copied in 
parts[i].type_guid

=> shor name size is limited at 36


>
>> +	{
>> +		NULL, "Device Path",
>>   		EFI_DEVICE_PATH_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Device Path To Text",
>> +		NULL, "Device Path To Text",
>>   		EFI_DEVICE_PATH_TO_TEXT_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Device Path Utilities",
>> +		NULL, "Device Path Utilities",
>>   		EFI_DEVICE_PATH_UTILITIES_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Unicode Collation 2",
>> +		NULL, "Unicode Collation 2",
>>   		EFI_UNICODE_COLLATION_PROTOCOL2_GUID,
>>   	},
>>   	{
>> -		"Driver Binding",
>> +		NULL, "Driver Binding",
>>   		EFI_DRIVER_BINDING_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Simple Text Input",
>> +		NULL, "Simple Text Input",
>>   		EFI_SIMPLE_TEXT_INPUT_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Simple Text Input Ex",
>> +		NULL, "Simple Text Input Ex",
>>   		EFI_SIMPLE_TEXT_INPUT_EX_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Simple Text Output",
>> +		NULL, "Simple Text Output",
>>   		EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Block IO",
>> +		NULL, "Block IO",
>>   		EFI_BLOCK_IO_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Disk IO",
>> +		NULL, "Disk IO",
>>   		EFI_DISK_IO_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Simple File System",
>> +		NULL, "Simple File System",
>>   		EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Loaded Image",
>> +		NULL, "Loaded Image",
>>   		EFI_LOADED_IMAGE_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Loaded Image Device Path",
>> +		NULL, "Loaded Image Device Path",
>>   		EFI_LOADED_IMAGE_DEVICE_PATH_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Graphics Output",
>> +		NULL, "Graphics Output",
>>   		EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"HII String",
>> +		NULL, "HII String",
>>   		EFI_HII_STRING_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"HII Database",
>> +		NULL, "HII Database",
>>   		EFI_HII_DATABASE_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"HII Config Access",
>> +		NULL, "HII Config Access",
>>   		EFI_HII_CONFIG_ACCESS_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"HII Config Routing",
>> +		NULL, "HII Config Routing",
>>   		EFI_HII_CONFIG_ROUTING_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Load File",
>> +		NULL, "Load File",
>>   		EFI_LOAD_FILE_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Load File2",
>> +		NULL, "Load File2",
>>   		EFI_LOAD_FILE2_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Random Number Generator",
>> +		NULL, "Random Number Generator",
>>   		EFI_RNG_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Simple Network",
>> +		NULL, "Simple Network",
>>   		EFI_SIMPLE_NETWORK_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"PXE Base Code",
>> +		NULL, "PXE Base Code",
>>   		EFI_PXE_BASE_CODE_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Device-Tree Fixup",
>> +		NULL, "Device-Tree Fixup",
>>   		EFI_DT_FIXUP_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"TCG2",
>> +		NULL, "TCG2",
>>   		EFI_TCG2_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"Firmware Management",
>> +		NULL, "Firmware Management",
>>   		EFI_FIRMWARE_MANAGEMENT_PROTOCOL_GUID
>>   	},
>>   #if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
>>   	{
>> -		"HTTP",
>> +		NULL, "HTTP",
>>   		EFI_HTTP_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"HTTP Service Binding",
>> +		NULL, "HTTP Service Binding",
>>   		EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID,
>>   	},
>>   	{
>> -		"IPv4 Config2",
>> +		NULL, "IPv4 Config2",
>>   		EFI_IP4_CONFIG2_PROTOCOL_GUID,
>>   	},
>>   #endif
>>   	/* Configuration table GUIDs */
>>   	{
>> -		"ACPI table",
>> +		NULL, "ACPI table",
>>   		EFI_ACPI_TABLE_GUID,
>>   	},
>>   	{
>> -		"EFI System Resource Table",
>> +		NULL, "EFI System Resource Table",
>>   		EFI_SYSTEM_RESOURCE_TABLE_GUID,
>>   	},
>>   	{
>> -		"device tree",
>> +		NULL, "device tree",
>>   		EFI_FDT_GUID,
>>   	},
>>   	{
>> -		"SMBIOS table",
>> +		NULL, "SMBIOS table",
>>   		SMBIOS_TABLE_GUID,
>>   	},
>>   	{
>> -		"SMBIOS3 table",
>> +		NULL, "SMBIOS3 table",
>>   		SMBIOS3_TABLE_GUID,
>>   	},
>>   	{
>> -		"Runtime properties",
>> +		NULL, "Runtime properties",
>>   		EFI_RT_PROPERTIES_TABLE_GUID,
>>   	},
>>   	{
>> -		"TCG2 Final Events Table",
>> +		NULL, "TCG2 Final Events Table",
>>   		EFI_TCG2_FINAL_EVENTS_TABLE_GUID,
>>   	},
>>   	{
>> -		"EFI Conformance Profiles Table",
>> +		NULL, "EFI Conformance Profiles Table",
>>   		EFI_CONFORMANCE_PROFILES_TABLE_GUID,
>>   	},
>>   #ifdef CONFIG_EFI_RISCV_BOOT_PROTOCOL
>>   	{
>> -		"RISC-V Boot",
>> +		NULL, "RISC-V Boot",
>>   		RISCV_EFI_BOOT_PROTOCOL_GUID,
>>   	},
>>   #endif
>> @@ -247,35 +248,36 @@ static const struct {
>>   #ifdef CONFIG_CMD_NVEDIT_EFI
>>   	/* signature database */
>>   	{
>> -		"EFI_GLOBAL_VARIABLE_GUID",
>> +		NULL, "EFI_GLOBAL_VARIABLE_GUID",
>>   		EFI_GLOBAL_VARIABLE_GUID,
>>   	},
>>   	{
>> -		"EFI_IMAGE_SECURITY_DATABASE_GUID",
>> +		NULL, "EFI_IMAGE_SECURITY_DATABASE_GUID",
>>   		EFI_IMAGE_SECURITY_DATABASE_GUID,
>>   	},
>>   	/* certificate types */
>>   	{
>> -		"EFI_CERT_SHA256_GUID",
>> +		NULL, "EFI_CERT_SHA256_GUID",
>>   		EFI_CERT_SHA256_GUID,
>>   	},
>>   	{
>> -		"EFI_CERT_X509_GUID",
>> +		NULL, "EFI_CERT_X509_GUID",
>>   		EFI_CERT_X509_GUID,
>>   	},
>>   	{
>> -		"EFI_CERT_TYPE_PKCS7_GUID",
>> +		NULL, "EFI_CERT_TYPE_PKCS7_GUID",
>>   		EFI_CERT_TYPE_PKCS7_GUID,
>>   	},
>>   #endif
>>   #if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI)
>> -	{ "EFI_LZMA_COMPRESSED", EFI_LZMA_COMPRESSED },
>> -	{ "EFI_DXE_SERVICES", EFI_DXE_SERVICES },
>> -	{ "EFI_HOB_LIST", EFI_HOB_LIST },
>> -	{ "EFI_MEMORY_TYPE", EFI_MEMORY_TYPE },
>> -	{ "EFI_MEM_STATUS_CODE_REC", EFI_MEM_STATUS_CODE_REC },
>> -	{ "EFI_GUID_EFI_ACPI1", EFI_GUID_EFI_ACPI1 },
>> +	{ NULL, "EFI_LZMA_COMPRESSED", EFI_LZMA_COMPRESSED },
>> +	{ NULL, "EFI_DXE_SERVICES", EFI_DXE_SERVICES },
>> +	{ NULL, "EFI_HOB_LIST", EFI_HOB_LIST },
>> +	{ NULL, "EFI_MEMORY_TYPE", EFI_MEMORY_TYPE },
>> +	{ NULL, "EFI_MEM_STATUS_CODE_REC", EFI_MEM_STATUS_CODE_REC },
>> +	{ NULL, "EFI_GUID_EFI_ACPI1", EFI_GUID_EFI_ACPI1 },


here we can use existing as short name/description as string have no 
space and size < 36....

+	{ "EFI_LZMA_COMPRESSED", NULL, EFI_LZMA_COMPRESSED },
+	{ "EFI_DXE_SERVICES", NULL, EFI_DXE_SERVICES },
+	{ "EFI_HOB_LIST", NULL,  EFI_HOB_LIST },
+	{ "EFI_MEMORY_TYPE", NULL,  EFI_MEMORY_TYPE },
+	{ "EFI_MEM_STATUS_CODE_REC", NULL, EFI_MEM_STATUS_CODE_REC },
+	{ "EFI_GUID_EFI_ACPI1", NULL,  EFI_GUID_EFI_ACPI1 },



>>   #endif
>> +#endif /* EFI_PARTITION */
>>   #endif /* !USE_HOSTCC */
>>   };
>>   
>> @@ -284,7 +286,8 @@ int uuid_guid_get_bin(const char *guid_str, unsigned char *guid_bin)
>>   	int i;
>>   
>>   	for (i = 0; i < ARRAY_SIZE(list_guid); i++) {
>> -		if (!strcmp(list_guid[i].string, guid_str)) {
>> +		if (list_guid[i].string &&
>> +		    !strcmp(list_guid[i].string, guid_str)) {
>>   			memcpy(guid_bin, &list_guid[i].guid, 16);
>>   			return 0;
>>   		}
>> @@ -298,6 +301,8 @@ const char *uuid_guid_get_str(const unsigned char *guid_bin)
> Should this be called uuid_guid_get_type() instead? 'str' or 'string' are confusing.
> We should have 'type' and 'decription' IMO.
>
>>   
>>   	for (i = 0; i < ARRAY_SIZE(list_guid); i++) {
>>   		if (!memcmp(list_guid[i].guid.b, guid_bin, 16)) {
>> +			if (list_guid[i].description)
>> +				return list_guid[i].description;
>>   			return list_guid[i].string;
> .description is never (or should never be) NULL. No need to return .string as a fallback.


it is the case for ALL the known type with only short description ....

not need to have long description if short string is enough....

+	{"mbr",		NULL,	LEGACY_MBR_PARTITION_GUID},
+	{"msft",	NULL,	PARTITION_MSFT_RESERVED_GUID},
+	{"data",	NULL,	PARTITION_BASIC_DATA_GUID},
+	{"linux",	NULL,	PARTITION_LINUX_FILE_SYSTEM_DATA_GUID},
+	{"raid",	NULL,	PARTITION_LINUX_RAID_GUID},
+	{"swap",	NULL,	PARTITION_LINUX_SWAP_GUID},
+	{"lvm",		NULL,	PARTITION_LINUX_LVM_GUID},
+	{"u-boot-env",	NULL,	PARTITION_U_BOOT_ENVIRONMENT},
+	{"cros-kern",	NULL,	PARTITION_CROS_KERNEL},
+	{"cros-root",	NULL,	PARTITION_CROS_ROOT},
+	{"cros-fw",	NULL,	PARTITION_CROS_FIRMWARE},
+	{"cros-rsrv",	NULL,	PARTITION_CROS_RESERVED},


>
>>   		}
>>   	}
>> @@ -312,10 +317,9 @@ int uuid_str_to_bin(const char *uuid_str, unsigned char *uuid_bin,
>>   	uint64_t tmp64;
>>   
>>   	if (!uuid_str_valid(uuid_str)) {
>> -#ifdef CONFIG_PARTITION_TYPE_GUID
>> -		if (!uuid_guid_get_bin(uuid_str, uuid_bin))
>> +		if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) &&
>> +		    !uuid_guid_get_bin(uuid_str, uuid_bin))
>>   			return 0;
>> -#endif
>>   		return -EINVAL;
>>   	}
>>   
> Thanks,


Regards

