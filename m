Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB05FED2EB
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 08:37:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5A5983F2A;
	Thu, 12 Mar 2026 09:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kZHvh4kn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D9FA83F53; Thu, 12 Mar 2026 09:37:02 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C6483DA6
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 09:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXuaWigZYJTDcucdidOBYYjOVSOaiPQNYCOlHpI4qZOtD2VI59LB6pMGzo8dn7G3VbW3gsBSfNuT1cK6/v42R9z/rmpkcsBdywsuhhDb6q4sAhETcxBDNnn2jFV0YLn1HK3mbI8gQb8nM5UldC303aKRqPzb0HYp9PorvQ5S+GPnD3gMRXq+Jq5DlpHseFufR1yCboeZ7z51OhY8vO0zHH/XydlnLL4Qe+nSMIISkIyUC9P5omtSesc6GOhLt6LLakBZaYpCJhG28BgUcoeLHDTWwy93XbI9FnbFoXZG5DnB2H1C9UQYK1LdCKs5ga9oWt6GJ3l4jwZRJOoN8glAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFl/0gKCK6RBGKcA11RxHWLva/m0DwBDfEz+JNPjWF8=;
 b=pt2l/lsaeMV8mPcZPPUbyjJ1DoQNRFXdxq7mSZOvrKYe/7eEgNkZKODXo6Abaw/DUzFp/u4dtJfqyCbGvr4peGxEj8yC0GQhEFTHO/TuotdMgscgkRW5qAAFchLVt6LqEFhwYfea7FR4LhOL9Ag2Vr6BcCn0XMZeW+MkqKWTRS33sKxNCjA5oN6aeOWHVgF59nul+sl9kDsBrnbWpvQmMdKGYSRjJgjmurMQfepF+2WgM8a3NUawMMQHyFgmmlU6g9yJmIKKOZiKrMSJm7h2nurE9JMYmiNdVeuBCXNSjeQnItAmniMlS+y57rmiprXonoLxtfBkEA6Qn7m+jDUeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFl/0gKCK6RBGKcA11RxHWLva/m0DwBDfEz+JNPjWF8=;
 b=kZHvh4knbOiH6m5fhb2QYEEMB+teYMSHJu/4MiVHH2BGOcHxjyUj3J5nLilEotIIAub9RP69/AbOMqSsPhhA+74MZozGF04ikGKR3OgCskDtCGF632p+a3jZW7fY6jyvlzo15g2ygxdLaFfrMwdjm+Jd+ZTg/NQdvGfvphBRUrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 08:36:52 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 08:36:52 +0000
Message-ID: <315556e1-0ae0-416f-8c95-bda7f3fd0ba0@amd.com>
Date: Thu, 12 Mar 2026 09:36:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] efi_vars: Implement SPI Flash store
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Shantur Rathore <i@shantur.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, git@amd.com,
 u-boot@lists.denx.de
References: <f49e4ac8da5bae9252c79031f1661f386d17895f.1771247847.git.michal.simek@amd.com>
 <82aa8024-e80f-4db8-b0be-c8558c953c1b@gmx.de>
 <92e98f1d-8a47-4889-a379-a0a670e102bc@canonical.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <92e98f1d-8a47-4889-a379-a0a670e102bc@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0421.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::25) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a4b6a2-dd95-4324-6d44-08de801282b3
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: zaqpCkSXxjV6c8odEnVzr06dQ7+Ix9YNYY2WcpkIEKTez5oR0ubzzea/QZ/Q1ZKPqOU+jXKENQOmsxbG+fVaMcKQL40NjfVVI04Ab54uy86ghqaclWGB91HjI+2U+i1Dn3zqqTzcrnsQa23PPRr4ysqNXSvk+4Lh2rd6sEebsn66DsOxfv8p1ua4X+1Nr5zTHvqc3te893joX5LvlwZHNh9WEuijkI7NGVNNP3TmugXYYVA4uvn+oufzmSqZ/67xKe6RaWohTtdobzn55/SVj2ctXWOYdp0/854ubf1mLLS4ebUlTe4JP49XSfx2euLUgE1c3cYB8tjwJ240mj+C/Qpv2NkXMV9jKUp0SNx8cWZ+5gUwhkNQ87PMyE9JemScyy/k+vaZF8OBhw8NcPYVugmpUsAHtMI2GEKvpPruLMCeyiCaa9eYk+gJErx71/ndDxClcAnohl02RCVXbEpLYMl+nO8I3Ap22tg3/dALsxk2hliTCM3EdHpLaEO185Pn5qFnDMf9AK1lsPE/+xbCvEUe69G7v844AxEw6lGhfKeq6wG/fKb2tMwpEYw+Bcayy5QCINGjtRr2L2IQWNQ5Ow/0tEsXShukW4QbesN4QobyUp/4PiK9JFHtwhOBePXvgFPYmEUsPzKU+fRjNON0L1j8QjVPS8rZSIDsVgNdMJNNDQWGeweOX5UG0sF1da+vvT3+TaWdU3+a1QkXsp5b5QbQ4ocOBaCxpp8kipKaxm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXZxdko2SGV2eFU4SXpLRHFhWlJHd2luTk1ia0VKdmFma3YwTHBWT3NYUU03?=
 =?utf-8?B?MC8zMnQxVWVHaDB1MmZBcGtYS0ZYQlFGejI5ekcrck4vSVJ3cDBrUGZGaHFK?=
 =?utf-8?B?d1MvVHV6d2RsZG9wUGZndjg3ejVqT1JXZnpwOWxQNU5tYjRFS1pzc3QydVJL?=
 =?utf-8?B?ZmJyUUYwampoR3ZUd21ZdjQ3WmNzbTVxUWNwN1pvZEhCek9KQjROY3N2NU0r?=
 =?utf-8?B?NkdaemNSbCs4RHRUZ2JTVjVmYjBMTHUzME5sNTZQUnNRMGdSR01yK2c1Tk1i?=
 =?utf-8?B?RXlVazZDeEtOcHUwM3pyd2tsSk1NOUwrLzIrRFl1eVlKaEhPOThTclpob3l1?=
 =?utf-8?B?aWhXL0svbC9hOXVtZSttM3lJVXltTkxYSGdhRFdISi9NU0lTZGlzNkQvalFa?=
 =?utf-8?B?Z1VXYmVETEJ0c2FlSXlSRytkWnlUZUNaQlZJRC9Gd1VRa1c1UnJBalh0RXlD?=
 =?utf-8?B?N0pRaHZyVkdWWlF4QWVlTUhZYUVGSENjcktuSFV0OW1hMThXQnQyUHNQQ3Ft?=
 =?utf-8?B?Z1o2S1hINmoyU1RTV3NWS29PTTRJNkc4bGlJRTVyTFJMMS83TElxNzArbmw2?=
 =?utf-8?B?dzNkRWdZSnpBTzZWTEJnb0FlTmVsYmdQZ0dXbk82QStjL0NCR3Z5empVc3Fq?=
 =?utf-8?B?Qk1uOGozRFVuVG9ZUks3STcrdlBtSnk0bDZpMk5BR2lobEdmV2F2bU9uQWFw?=
 =?utf-8?B?Y0I0K3htQ0FNRlBKSDhna2VvTFlodkdCNG5WajZmK1dwMG96UjN4eFljelQy?=
 =?utf-8?B?aTI0QUdwMkxUR0h3eHphanhWL3gzZGFvbEFHUWVlZmZtMlBJUHZ0T1JvYlJu?=
 =?utf-8?B?VUY3dHFwVmlLVzU2UEQ1cS9hSXRIS1ptclNKVHFRbk9DK1I3ekNxbnBPanZF?=
 =?utf-8?B?U2I4Y3NYZkRHS2djcHY2STBHcTZrNkVWbmhFa2VhdVZIOTFnb1NoVjB5NkdN?=
 =?utf-8?B?R0pWUGJOaE9tMERIWXB6QjB1NjJhU09hNmJwb1U3MHByV0RxRHdkYzZ4STRn?=
 =?utf-8?B?M2kycER1K2VuZEJIQ3BXVzViclo4bjNvRVBpOHlsOHdxV3JtTTZmUlBvY0Y0?=
 =?utf-8?B?Q2g3djNQMVJaenRkcFZSamhOTTAvTUNTQkMrY2hheWVVbE50aTkzS2d1MDA3?=
 =?utf-8?B?ZDNoSVJ5Wlp6NVVyVStJRWZoZkdUMTRoK093L2ZwVUp3S1JXclAvTXBQam5p?=
 =?utf-8?B?a2FqbDF5ZXJVa2VCY0ZLcFZUZVpqMWtMb2xKQldNODc0aExZWVVuZko0dHgz?=
 =?utf-8?B?TnBTeHZKRU9Zc1Z3Rjh1VjBId0lpZGt1RDRiYjFrSldxYXZXdGRnNTYvSUFH?=
 =?utf-8?B?aVhUSlJ1cTR5dDhlSVZURjRpNVhzVmRGVzZic0o2cElVazI2ZnlWZkdpNDFp?=
 =?utf-8?B?Qm9nTDBBZy9scXNkNmdFTVllek1BZG5RaUtVUlJqK3h4ZEErdGx6Ty9uT2Yv?=
 =?utf-8?B?KzFkYlRBSWNnNWoyRGYyWFlnUGlGdkhQNHZLSzNUVk9KRU11OWhWaGJsdmQ3?=
 =?utf-8?B?ZHkxcTVhM0JCY0t3S1VIRjMxay9lMEVIWVhqQk1YeHlvSmhvQ1BMMjMxNFl3?=
 =?utf-8?B?aEZiblBnWjRxOFpaYWdUT21BeGhFaWpMZDRQTngwenNLeHROZW1RUElVVnFG?=
 =?utf-8?B?Y3pFZ1BLbXRCaTJnNVE1TGFSWUdNRm1neEdkNTZmbVgxZ0drWEZJVnI1ZjlK?=
 =?utf-8?B?eGoyN2tYT2VFWUJ5eTExRUY0cEdSZFY5QnlEUWM3V2NHRk5xamNjaGFWdHNY?=
 =?utf-8?B?b0RBY295cUlyREYzUE1HOXk3WFRtdTBvOVM3d3luU2VuN2psMGpuUVEzdGpZ?=
 =?utf-8?B?aENMazhpMVlXdGI2RDlDbnlJd25USVZjNUFSRkhwOVNxZEtUd05TdzQzcVlT?=
 =?utf-8?B?Mm96SWxGTzlNdy9td2V3Z1pILzhWSW13aTlzRVgyeGFsVElGRW1aengrL085?=
 =?utf-8?B?ZndMeUhUVUZ1UUNVc3NjWTFlemJCYU03SlFtWjZyUkpRZGpnYk40SmFaV2Vs?=
 =?utf-8?B?SnJLY2JlaTZUZTBrenlUdzhUelhodHFpcjYzeExiYUE2bzBnaisxTG80TXRG?=
 =?utf-8?B?eWZxM1N0aXdhdnIxbU5RYjlEdEZYTzBlbHdqY2RtOGQ3aTRkUmJKNS90TTAv?=
 =?utf-8?B?bjFveGUyTXdWTGl6bTBpemx1VlN2ZjF6b0kveFZYVyszaStCRnQ0N2lORVN1?=
 =?utf-8?B?cjkxamJIQzhEbWVRTUVqeDdhQ3BwVkg1bGFBYktEL0pKVk1iTFdpMHZ1MXQ4?=
 =?utf-8?B?TnRJYXlKYVhwWkZGMC80UlQ0eDRTRllmSFF6ZDhXcUxrcWg3N0U4VjdtZ0I5?=
 =?utf-8?B?NFJ6YSsxaFpZTkJzK3lEcWZGSnU4R1Z1WUVWNjBpbCtGRjZ3cjNCZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a4b6a2-dd95-4324-6d44-08de801282b3
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:36:52.4525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zu9BlFtQOVMWqP4OaV3/xzrOY9T+MszqHH5wRx7Cv3qyWQvBAAttzXSuzMFoIlkW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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



On 3/12/26 08:50, Heinrich Schuchardt wrote:
> On 3/11/26 16:08, Heinrich Schuchardt wrote:
>> On 2/16/26 14:17, Michal Simek wrote:
>>> From: Shantur Rathore <i@shantur.com>
>>>
>>> Currently U-Boot uses ESP as storage for EFI variables.
>>> Devices with SPI Flash are used for storing environment with this
>>> commit we allow EFI variables to be stored on SPI Flash.
>>>
>>> Signed-off-by: Shantur Rathore <i@shantur.com>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-CC
>>> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>
>>> ---
>>>
>>> Changes in v9:
>>> - Remove EFI_RT_VOLATILE_STORE enabling
>>> - Cleanup commit message
>>>
>>> Changes in v8:
>>> - Add missing EFI_VARIABLE_SF_STORE dependency to EFI_VARIABLE_SF_DEVICE_INDEX
>>>
>>> Changes in v7:
>>> - sed -i 's/efi_var_from/efi_var_from_storage/g'
>>>
>>> Changes in v6:
>>> - sed -i 's/efi_var_read/efi_var_from/g'
>>> - sed -i 's/efi_var_write/efi_var_to_storage/g'
>>>
>>> Changes in v4:
>>> - Extend Kconfig description
>>> - Extend commit message and describe efivar missing part
>>> - use unify methods for reading/writing variable
>>>
>>> Changes in v3:
>>> - Fixed compiler warnings.
>>>
>>> Changes in v2:
>>> - Refactored efi_var_file to move common parts out as requested
>>> - Changed ifdefs to use CONFIG_IS_DEFINED
>>> - Fixed typos
>>>
>>>   lib/efi_loader/Kconfig      | 33 +++++++++++++
>>>   lib/efi_loader/Makefile     |  1 +
>>>   lib/efi_loader/efi_var_sf.c | 92 +++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 126 insertions(+)
>>>   create mode 100644 lib/efi_loader/efi_var_sf.c
>>>
>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>> index 579eed658801..315dd4f3e794 100644
>>> --- a/lib/efi_loader/Kconfig
>>> +++ b/lib/efi_loader/Kconfig
>>> @@ -124,6 +124,24 @@ config EFI_VARIABLE_FILE_STORE
>>>         Select this option if you want non-volatile UEFI variables to be
>>>         stored as file /ubootefi.var on the EFI system partition.
>>> +config EFI_VARIABLE_SF_STORE
>>> +    bool "Store non-volatile UEFI variables in SPI Flash"
>>> +    depends on SPI_FLASH
>>> +    help
>>> +      Select this option if you want non-volatile UEFI variables to be
>>> +      stored in SPI Flash.
>>> +
>>> +      Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use as
>>> +      the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the space
>>> +      needed.
>>> +
>>> +      Note that SPI Flash devices have a limited number of program/erase
>>> +      cycles. Frequent updates to UEFI variables may cause excessive wear
>>> +      and can permanently damage the flash device, particularly on SPI NAND
>>> +      or low-end SPI NOR parts without wear leveling. This option should be
>>> +      used with care on such systems, and is not recommended for platforms
>>> +      where UEFI variables are updated frequently.
>>> +
>>>   config EFI_MM_COMM_TEE
>>>       bool "UEFI variables storage service via the trusted world"
>>>       depends on OPTEE
>>> @@ -194,6 +212,21 @@ config FFA_SHARED_MM_BUF_ADDR
>>>         the MM SP in secure world.
>>>         It is assumed that the MM SP knows the address of the shared MM 
>>> communication buffer.
>>> +config EFI_VARIABLE_SF_OFFSET
>>> +    hex "EFI variables in SPI flash offset"
>>> +    depends on EFI_VARIABLE_SF_STORE
>>> +    help
>>> +      Offset from the start of the SPI Flash where EFI variables will be 
>>> stored.
>>> +      This should be aligned to the sector size of SPI Flash.
>>> +
>>> +config EFI_VARIABLE_SF_DEVICE_INDEX
>>> +    int "Device Index for target SPI Flash"
>>> +    depends on EFI_VARIABLE_SF_STORE
>>> +    default 0
>>> +    help
>>> +      The index of SPI Flash device used for storing EFI variables. This 
>>> would be
>>> +      needed if there are more than 1 SPI Flash devices available to use.
>>> +
>>>   config EFI_VARIABLES_PRESEED
>>>       bool "Initial values for UEFI variables"
>>>       depends on !COMPILE_TEST
>>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>>> index ca1775eb03be..d73ad43951b1 100644
>>> --- a/lib/efi_loader/Makefile
>>> +++ b/lib/efi_loader/Makefile
>>> @@ -54,6 +54,7 @@ obj-y += efi_variable_tee.o
>>>   else
>>>   obj-y += efi_variable.o
>>>   obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) += efi_var_file.o
>>> +obj-$(CONFIG_EFI_VARIABLE_SF_STORE) += efi_var_sf.o
>>>   obj-$(CONFIG_EFI_VARIABLES_PRESEED) += efi_var_seed.o
>>>   endif
>>>   obj-y += efi_watchdog.o
>>> diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
>>> new file mode 100644
>>> index 000000000000..61d68f7c5c94
>>> --- /dev/null
>>> +++ b/lib/efi_loader/efi_var_sf.c
>>> @@ -0,0 +1,92 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * SPI Flash interface for UEFI variables
>>> + *
>>> + * Copyright (c) 2023, Shantur Rathore
>>> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
>>> + */
>>> +
>>> +#define LOG_CATEGORY LOGC_EFI
>>> +
>>> +#include <efi_loader.h>
>>> +#include <efi_variable.h>
>>> +#include <spi_flash.h>
>>> +#include <dm.h>
>>> +
>>> +efi_status_t efi_var_to_storage(void)
>>> +{
>>> +    efi_status_t ret;
>>> +    struct efi_var_file *buf;
>>> +    loff_t len;
>>> +    struct udevice *sfdev;
>>> +
>>> +    ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
>>> +    if (len > EFI_VAR_BUF_SIZE) {
>>> +        log_err("EFI var buffer length more than target SPI Flash size");
>>> +        ret = EFI_OUT_OF_RESOURCES;
>>> +        goto error;
>>> +    }
>>> +
>>> +    log_debug("%s - Got buffer to write buf->len : %d\n", __func__, buf- 
>>> >length);
>>
>> Hello Michal,
>>
>> Thank you for driving this.
>>
>> The log system is configurable to print file, line, function name if wanted. 
>> We should not duplicate this here. Please, remove __func__ throughout the patch.
>>
>>> +
>>> +    if (ret != EFI_SUCCESS)
>>> +        goto error;
>>> +
>>> +    ret = uclass_get_device(UCLASS_SPI_FLASH, 
>>> CONFIG_EFI_VARIABLE_SF_DEVICE_INDEX, &sfdev);
>>> +    if (ret)
>>
>> This is not an EFI return code. EFI_DEVICE_ERROR should be used.
>>
>>> +        goto error;
>>> +
>>> +    ret = spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, 
>>> EFI_VAR_BUF_SIZE);
>>> +    log_debug("%s - Erased SPI Flash offset %x\n", __func__, 
>>> CONFIG_EFI_VARIABLE_SF_OFFSET);
>>
>> A debug output if erasing failed would be more interesting.
>>
>>> +    if (ret)
>>
>> This is not an EFI return code. EFI_DEVICE_ERROR should be used.
>>
>>> +        goto error;
>>> +
>>> +    ret = spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len, buf);
>>> +    log_debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, ret);
>>
>> The uclass_get_device() return code should be saved in an int variable to 
>> avoid confusion.
>>
>>> +
>>> +    if (ret)
>>
>> This is not an EFI return code. EFI_DEVICE_ERROR should be used.
>>
>>> +        goto error;
>>> +
>>> +    ret = EFI_SUCCESS;
>>> +error:
>>> +    if (ret)
>>> +        log_err("Failed to persist EFI variables in SF\n");
>>> +    free(buf);
>>> +    return ret;
>>> +}
>>> +
>>> +efi_status_t efi_var_from_storage(void)
>>> +{
>>> +    struct efi_var_file *buf;
>>> +    efi_status_t ret;
>>> +    struct udevice *sfdev;
>>> +
>>> +    buf = calloc(1, EFI_VAR_BUF_SIZE);
>>> +    if (!buf) {
>>> +        log_err("%s - Unable to allocate buffer\n", __func__);
>>
>> This function may be called from an EFI GUI application. We should not output 
>> any strings to the console from API functions. It is task of the caller to 
>> take appropriate actions. E.g. show a pop-up if a failure occurs. log_debug() 
>> is ok.
> 
> I got this wrong. This function is called when initializing the EFI sub-system. 
> So writing errors to the console is ok. It is efi_var_to_storage() which is 
> invoked by EFI applications and where we should avoid console output.

I don't think it is a problem to keep it under debug. Error value will be 
propagated properly.

M

