Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23993C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 09:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 566CF81FEE;
	Mon, 19 May 2025 11:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZipAAA8w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD9B682998; Mon, 19 May 2025 11:23:27 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70ED481E72
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 11:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so33279065e9.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 02:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747646604; x=1748251404; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cmGDh7Quf7paBrFEK/LEdlFZm+7VMbs02wnac/NAITI=;
 b=ZipAAA8wz1DwAB3GJla6hVqiJjhTk0sc4z4PD1ILUq3Y455V/5B3A1Cx7jFbXzSO2g
 FdQ2jzPry2uJPBXN7PBgxdBovFPN6aN9/ANHKY9PhTjC8dhsrE82KyjT+/wwg8mfKYng
 QkrU5QfF4R9KUaWspQ14H9QUBU6Apc28tA20MSMj0TtA/UqHmuvh0LrgxM2NLmXvf3Zq
 4c6zxp1fsDyJQewfp3Srq8gPVNp9mgeDtM9qsVXP7af0J9R8lp80ynRhMYpvdJjPEfSf
 8i7yL2beyro/vy7+pX+cEUYO5ZIldlBl2uXwNW1UxaQSVulDod7sh+QqZ5SZ7wMzfLP1
 fmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747646604; x=1748251404;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cmGDh7Quf7paBrFEK/LEdlFZm+7VMbs02wnac/NAITI=;
 b=NCCOSf9/tvQpDUIpBV4V6Z4p9uV41tmjQ7im135WGLNuPOFbb20stn2UtlGbMk/ros
 64TAhLM/Z2xzha4j0coTPpgyOhtmxDUBojvy1xObOMgetowKss5Yi+ecurOFiOBxNLsh
 uDGcaYItpT/wcyThgSIOPXI6eA5Go0Np3cHJnOElP8MPUjG0pWgS3ENbPd+fOFHoKXOD
 YCPHxH1HvuUja4VoM5Mksqvau9qk9ETT3ioQX2cR20xhL/dWoKMk4alYqKpHKFEuAlGd
 CKcdr4BsBaYVsmr7tV4k6lRyNq9Bx1iuqlE/4GQhaI8x1l+ZcZzzJnyApKvAZzMSUmjI
 ZtlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxkEZZjz4DuQZWQd6kONXNXUaRnChJ3yw4VqdCDinYPifr4Zv/9GmuPAfR340T1d6l82ZFeJc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzk6JqvS7JQr2dWGNkALlCaUxDvn06dxZr9DOr99lawm1v2sRCJ
 4jev4lyIBoVuTA9IxsBj7woYpSOLFHpc8rFym5+293kIHoPTNL1CHfL+BcXOZrVFzag=
X-Gm-Gg: ASbGncscbgtJPw0UTqDBRqZXm7PCFEzm5mAF74MjcJTunGs9/u6mhO7IQTgdMVUpkOZ
 YSC+M9KRGcs6lrIYsQ1swIs6f5/r54v7K7pITFR/wg96UinTkrAufl2TPuyGV4yLfqH29jvNuYy
 5CF205Jt+k3mgoquXW/ofDaou23BWOvfuhTBEUuIn4C9Qs/k34TjIZmliyWqxmV1Wq1KA8HegoF
 PPaHA299uzZAZouIyYJZv1Ud7DNgw1cu7b1iQ2wv0BQWKZXINo0+TRMWkulqw59CFCYdSVe8MuC
 wWLui7Krh5LLP4AcPdACVbjM4S3E8uK7h4BNM6cztuWnQejebK+PTvT6CUUsmwKsL3UFPMeZIs2
 CmKz1upFfa5d0lw8q6ZcEuiX74K2nqjQ=
X-Google-Smtp-Source: AGHT+IFLfrdzgB3M6ko8RQD9Es7eT5NBE0s8mORUScAmdX6qrG9KPdSkrKdVjGn1EsNu5iZ3yBFmuQ==
X-Received: by 2002:a05:600c:474a:b0:442:f44f:65b with SMTP id
 5b1f17b1804b1-442fd675a33mr96374135e9.32.1747646604380; 
 Mon, 19 May 2025 02:23:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:f675:6612:8685:2dab?
 ([2a01:e0a:3cb:7bb0:f675:6612:8685:2dab])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd583fb7sm132268895e9.32.2025.05.19.02.23.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 02:23:24 -0700 (PDT)
Message-ID: <71947acc-d77c-4cd2-9a15-d679a0e53a8c@linaro.org>
Date: Mon, 19 May 2025 10:23:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] lib/uuid.c: restore support of system partition type
 for ESP
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, patrice.chotard@foss.st.com,
 caleb.connolly@linaro.org, Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250519090421.470942-1-patrick.delaunay@foss.st.com>
 <20250519110417.1.Ie741b1ca358414a1d718dca0667ac44eefc9227b@changeid>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250519110417.1.Ie741b1ca358414a1d718dca0667ac44eefc9227b@changeid>
Content-Type: text/plain; charset=UTF-8
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

Hi Patrick,

On 5/19/25 10:04, Patrick Delaunay wrote:
> Add support of shortname for type parameter and restore "system"
> as short name for EFI System Partition (ESP) for filed "type" of the
> "gpt write" command.
> 
> Fixes: d54e1004b8b1 ("lib/uuid.c: use unique name for PARTITION_SYSTEM_GUID")
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
>  lib/uuid.c | 148 +++++++++++++++++++++++++++--------------------------
>  1 file changed, 76 insertions(+), 72 deletions(-)
> 
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 6abbcf27b1f3..ee02fa4d600d 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -62,184 +62,185 @@ int uuid_str_valid(const char *uuid)
>  	return 1;
>  }
>  
> +/* List of known GUID for GPT partition type */
>  static const struct {
> -	const char *string;
> +	const char *string;     /* name for type parameter of gpt command */

const char *type?

> +	const char *description;/* description used for %pUs */
>  	efi_guid_t guid;
>  } list_guid[] = {
>  #ifndef USE_HOSTCC
> -#if defined(CONFIG_PARTITION_TYPE_GUID) || defined(CONFIG_CMD_EFIDEBUG) || \
> -	defined(CONFIG_EFI)
> -	{"EFI System Partition", PARTITION_SYSTEM_GUID},
> -#endif
> -#ifdef CONFIG_PARTITION_TYPE_GUID
> -	{"mbr",		LEGACY_MBR_PARTITION_GUID},
> -	{"msft",	PARTITION_MSFT_RESERVED_GUID},
> -	{"data",	PARTITION_BASIC_DATA_GUID},
> -	{"linux",	PARTITION_LINUX_FILE_SYSTEM_DATA_GUID},
> -	{"raid",	PARTITION_LINUX_RAID_GUID},
> -	{"swap",	PARTITION_LINUX_SWAP_GUID},
> -	{"lvm",		PARTITION_LINUX_LVM_GUID},
> -	{"u-boot-env",	PARTITION_U_BOOT_ENVIRONMENT},
> -	{"cros-kern",	PARTITION_CROS_KERNEL},
> -	{"cros-root",	PARTITION_CROS_ROOT},
> -	{"cros-fw",	PARTITION_CROS_FIRMWARE},
> -	{"cros-rsrv",	PARTITION_CROS_RESERVED},
> -#endif
> +#if CONFIG_IS_ENABLED(EFI_PARTITION)
> +	{"mbr",		NULL,	LEGACY_MBR_PARTITION_GUID},
> +	{"msft",	NULL,	PARTITION_MSFT_RESERVED_GUID},
> +	{"data",	NULL,	PARTITION_BASIC_DATA_GUID},
> +	{"linux",	NULL,	PARTITION_LINUX_FILE_SYSTEM_DATA_GUID},
> +	{"raid",	NULL,	PARTITION_LINUX_RAID_GUID},
> +	{"swap",	NULL,	PARTITION_LINUX_SWAP_GUID},
> +	{"lvm",		NULL,	PARTITION_LINUX_LVM_GUID},
> +	{"u-boot-env",	NULL,	PARTITION_U_BOOT_ENVIRONMENT},
> +	{"cros-kern",	NULL,	PARTITION_CROS_KERNEL},
> +	{"cros-root",	NULL,	PARTITION_CROS_ROOT},
> +	{"cros-fw",	NULL,	PARTITION_CROS_FIRMWARE},
> +	{"cros-rsrv",	NULL,	PARTITION_CROS_RESERVED},
>  #if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI)
>  	{
> -		"Device Path",
> +		"system", "EFI System Partition",
> +		PARTITION_SYSTEM_GUID,
> +	},

The patch adds quite many NULLs to the list_guid[] only for this very
special case. We would be better off hardcoding the "system" case into
uuid_guid_get_bin() I think.

> +	{
> +		NULL, "Device Path",
>  		EFI_DEVICE_PATH_PROTOCOL_GUID,
>  	},
>  	{
> -		"Device Path To Text",
> +		NULL, "Device Path To Text",
>  		EFI_DEVICE_PATH_TO_TEXT_PROTOCOL_GUID,
>  	},
>  	{
> -		"Device Path Utilities",
> +		NULL, "Device Path Utilities",
>  		EFI_DEVICE_PATH_UTILITIES_PROTOCOL_GUID,
>  	},
>  	{
> -		"Unicode Collation 2",
> +		NULL, "Unicode Collation 2",
>  		EFI_UNICODE_COLLATION_PROTOCOL2_GUID,
>  	},
>  	{
> -		"Driver Binding",
> +		NULL, "Driver Binding",
>  		EFI_DRIVER_BINDING_PROTOCOL_GUID,
>  	},
>  	{
> -		"Simple Text Input",
> +		NULL, "Simple Text Input",
>  		EFI_SIMPLE_TEXT_INPUT_PROTOCOL_GUID,
>  	},
>  	{
> -		"Simple Text Input Ex",
> +		NULL, "Simple Text Input Ex",
>  		EFI_SIMPLE_TEXT_INPUT_EX_PROTOCOL_GUID,
>  	},
>  	{
> -		"Simple Text Output",
> +		NULL, "Simple Text Output",
>  		EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL_GUID,
>  	},
>  	{
> -		"Block IO",
> +		NULL, "Block IO",
>  		EFI_BLOCK_IO_PROTOCOL_GUID,
>  	},
>  	{
> -		"Disk IO",
> +		NULL, "Disk IO",
>  		EFI_DISK_IO_PROTOCOL_GUID,
>  	},
>  	{
> -		"Simple File System",
> +		NULL, "Simple File System",
>  		EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID,
>  	},
>  	{
> -		"Loaded Image",
> +		NULL, "Loaded Image",
>  		EFI_LOADED_IMAGE_PROTOCOL_GUID,
>  	},
>  	{
> -		"Loaded Image Device Path",
> +		NULL, "Loaded Image Device Path",
>  		EFI_LOADED_IMAGE_DEVICE_PATH_PROTOCOL_GUID,
>  	},
>  	{
> -		"Graphics Output",
> +		NULL, "Graphics Output",
>  		EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID,
>  	},
>  	{
> -		"HII String",
> +		NULL, "HII String",
>  		EFI_HII_STRING_PROTOCOL_GUID,
>  	},
>  	{
> -		"HII Database",
> +		NULL, "HII Database",
>  		EFI_HII_DATABASE_PROTOCOL_GUID,
>  	},
>  	{
> -		"HII Config Access",
> +		NULL, "HII Config Access",
>  		EFI_HII_CONFIG_ACCESS_PROTOCOL_GUID,
>  	},
>  	{
> -		"HII Config Routing",
> +		NULL, "HII Config Routing",
>  		EFI_HII_CONFIG_ROUTING_PROTOCOL_GUID,
>  	},
>  	{
> -		"Load File",
> +		NULL, "Load File",
>  		EFI_LOAD_FILE_PROTOCOL_GUID,
>  	},
>  	{
> -		"Load File2",
> +		NULL, "Load File2",
>  		EFI_LOAD_FILE2_PROTOCOL_GUID,
>  	},
>  	{
> -		"Random Number Generator",
> +		NULL, "Random Number Generator",
>  		EFI_RNG_PROTOCOL_GUID,
>  	},
>  	{
> -		"Simple Network",
> +		NULL, "Simple Network",
>  		EFI_SIMPLE_NETWORK_PROTOCOL_GUID,
>  	},
>  	{
> -		"PXE Base Code",
> +		NULL, "PXE Base Code",
>  		EFI_PXE_BASE_CODE_PROTOCOL_GUID,
>  	},
>  	{
> -		"Device-Tree Fixup",
> +		NULL, "Device-Tree Fixup",
>  		EFI_DT_FIXUP_PROTOCOL_GUID,
>  	},
>  	{
> -		"TCG2",
> +		NULL, "TCG2",
>  		EFI_TCG2_PROTOCOL_GUID,
>  	},
>  	{
> -		"Firmware Management",
> +		NULL, "Firmware Management",
>  		EFI_FIRMWARE_MANAGEMENT_PROTOCOL_GUID
>  	},
>  #if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
>  	{
> -		"HTTP",
> +		NULL, "HTTP",
>  		EFI_HTTP_PROTOCOL_GUID,
>  	},
>  	{
> -		"HTTP Service Binding",
> +		NULL, "HTTP Service Binding",
>  		EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID,
>  	},
>  	{
> -		"IPv4 Config2",
> +		NULL, "IPv4 Config2",
>  		EFI_IP4_CONFIG2_PROTOCOL_GUID,
>  	},
>  #endif
>  	/* Configuration table GUIDs */
>  	{
> -		"ACPI table",
> +		NULL, "ACPI table",
>  		EFI_ACPI_TABLE_GUID,
>  	},
>  	{
> -		"EFI System Resource Table",
> +		NULL, "EFI System Resource Table",
>  		EFI_SYSTEM_RESOURCE_TABLE_GUID,
>  	},
>  	{
> -		"device tree",
> +		NULL, "device tree",
>  		EFI_FDT_GUID,
>  	},
>  	{
> -		"SMBIOS table",
> +		NULL, "SMBIOS table",
>  		SMBIOS_TABLE_GUID,
>  	},
>  	{
> -		"SMBIOS3 table",
> +		NULL, "SMBIOS3 table",
>  		SMBIOS3_TABLE_GUID,
>  	},
>  	{
> -		"Runtime properties",
> +		NULL, "Runtime properties",
>  		EFI_RT_PROPERTIES_TABLE_GUID,
>  	},
>  	{
> -		"TCG2 Final Events Table",
> +		NULL, "TCG2 Final Events Table",
>  		EFI_TCG2_FINAL_EVENTS_TABLE_GUID,
>  	},
>  	{
> -		"EFI Conformance Profiles Table",
> +		NULL, "EFI Conformance Profiles Table",
>  		EFI_CONFORMANCE_PROFILES_TABLE_GUID,
>  	},
>  #ifdef CONFIG_EFI_RISCV_BOOT_PROTOCOL
>  	{
> -		"RISC-V Boot",
> +		NULL, "RISC-V Boot",
>  		RISCV_EFI_BOOT_PROTOCOL_GUID,
>  	},
>  #endif
> @@ -247,35 +248,36 @@ static const struct {
>  #ifdef CONFIG_CMD_NVEDIT_EFI
>  	/* signature database */
>  	{
> -		"EFI_GLOBAL_VARIABLE_GUID",
> +		NULL, "EFI_GLOBAL_VARIABLE_GUID",
>  		EFI_GLOBAL_VARIABLE_GUID,
>  	},
>  	{
> -		"EFI_IMAGE_SECURITY_DATABASE_GUID",
> +		NULL, "EFI_IMAGE_SECURITY_DATABASE_GUID",
>  		EFI_IMAGE_SECURITY_DATABASE_GUID,
>  	},
>  	/* certificate types */
>  	{
> -		"EFI_CERT_SHA256_GUID",
> +		NULL, "EFI_CERT_SHA256_GUID",
>  		EFI_CERT_SHA256_GUID,
>  	},
>  	{
> -		"EFI_CERT_X509_GUID",
> +		NULL, "EFI_CERT_X509_GUID",
>  		EFI_CERT_X509_GUID,
>  	},
>  	{
> -		"EFI_CERT_TYPE_PKCS7_GUID",
> +		NULL, "EFI_CERT_TYPE_PKCS7_GUID",
>  		EFI_CERT_TYPE_PKCS7_GUID,
>  	},
>  #endif
>  #if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI)
> -	{ "EFI_LZMA_COMPRESSED", EFI_LZMA_COMPRESSED },
> -	{ "EFI_DXE_SERVICES", EFI_DXE_SERVICES },
> -	{ "EFI_HOB_LIST", EFI_HOB_LIST },
> -	{ "EFI_MEMORY_TYPE", EFI_MEMORY_TYPE },
> -	{ "EFI_MEM_STATUS_CODE_REC", EFI_MEM_STATUS_CODE_REC },
> -	{ "EFI_GUID_EFI_ACPI1", EFI_GUID_EFI_ACPI1 },
> +	{ NULL, "EFI_LZMA_COMPRESSED", EFI_LZMA_COMPRESSED },
> +	{ NULL, "EFI_DXE_SERVICES", EFI_DXE_SERVICES },
> +	{ NULL, "EFI_HOB_LIST", EFI_HOB_LIST },
> +	{ NULL, "EFI_MEMORY_TYPE", EFI_MEMORY_TYPE },
> +	{ NULL, "EFI_MEM_STATUS_CODE_REC", EFI_MEM_STATUS_CODE_REC },
> +	{ NULL, "EFI_GUID_EFI_ACPI1", EFI_GUID_EFI_ACPI1 },
>  #endif
> +#endif /* EFI_PARTITION */
>  #endif /* !USE_HOSTCC */
>  };
>  
> @@ -284,7 +286,8 @@ int uuid_guid_get_bin(const char *guid_str, unsigned char *guid_bin)
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(list_guid); i++) {
> -		if (!strcmp(list_guid[i].string, guid_str)) {
> +		if (list_guid[i].string &&
> +		    !strcmp(list_guid[i].string, guid_str)) {
>  			memcpy(guid_bin, &list_guid[i].guid, 16);
>  			return 0;
>  		}
> @@ -298,6 +301,8 @@ const char *uuid_guid_get_str(const unsigned char *guid_bin)

Should this be called uuid_guid_get_type() instead? 'str' or 'string' are confusing.
We should have 'type' and 'decription' IMO.

>  
>  	for (i = 0; i < ARRAY_SIZE(list_guid); i++) {
>  		if (!memcmp(list_guid[i].guid.b, guid_bin, 16)) {
> +			if (list_guid[i].description)
> +				return list_guid[i].description;
>  			return list_guid[i].string;

.description is never (or should never be) NULL. No need to return .string as a fallback.

>  		}
>  	}
> @@ -312,10 +317,9 @@ int uuid_str_to_bin(const char *uuid_str, unsigned char *uuid_bin,
>  	uint64_t tmp64;
>  
>  	if (!uuid_str_valid(uuid_str)) {
> -#ifdef CONFIG_PARTITION_TYPE_GUID
> -		if (!uuid_guid_get_bin(uuid_str, uuid_bin))
> +		if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) &&
> +		    !uuid_guid_get_bin(uuid_str, uuid_bin))
>  			return 0;
> -#endif
>  		return -EINVAL;
>  	}
>  

Thanks,
-- 
Jerome
