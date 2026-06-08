Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9453ACD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 06:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0579A83FEC;
	Mon,  8 Jun 2026 08:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="t2UKnECs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1230846A7; Mon,  8 Jun 2026 08:09:28 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B9B5807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 08:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3Nadt+U5vTANSaOzTSXHVmcX2cqcBx9763VhZw6t+v6KVv3bH6holrHHUJSw9ZOuW1yyk/ZEeXaOaG70EsHKP3Df38ROKRyly0P63m62qs5Q/HHS/PIctH5OmFsFM1m064rKuFKwbMzOukMThmG11lA57ulWOPvfxFMvCI+x14NUJA+RqLjwU+53C9t7lbWf2sWvRfEPghLZtNbk2fQ1nscEGDY7ZIE5wXHdbC2SdwcUsxOL1D4Shn76pWlGeCGOii4a2W79gJ+n6dmNMILJUc3buyiHZN55l1bKI4csSPjabyFp6at8NcFYhfGN8BukvVA1zZquc9cs8/gdJeamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIv9bfzRCLFSjN3Yvv2zE9nGMc+rBnzGyslgWty7nZc=;
 b=pKcarS7SN3T18XBgtiR14ielkErIfTnJ4wtxgd+WglWmdu0aL8L3zYS53UNIA23U2dbiwj5q/quD1Fewmeu9pLXyMuMEC7Y3jY50Aj2O4OO6O9v2R+myQYA9avO7PNAnwLUB1o+GIfXkz7UL3JkCH7/Gi0eCer6irQ97SJowmRrb+yJlJIWKXtTFvutN6upK+JGKSpL2QqdOQN+m05lkxE+p4fm+XjQ9mMsaX+3uQmbKynH4d7S2MGhd2qZPPsJZJmEKngO5ibzsuTa7vSQwUaMjmEkpL6quqq7ToJdfgXp9AfwQGSjB4QfJC4iwbCt/f2IYxULhStIsLRCWer6qug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIv9bfzRCLFSjN3Yvv2zE9nGMc+rBnzGyslgWty7nZc=;
 b=t2UKnECsTYbPuXOQeBmrx62Pqw3mXZkTGN1TfaXxs1jdj2HJhEPLtFkdntP18g2A5m+tUzvNn854rfHFBMhY5cdmvkPmsLzNlUJeDNAxIpZ3+Mhgp1DqFLDP8ScZfOatyFIcXBxgmU+BLWkkz6bY2JCK4gxP2xJHa3f6phYk+DsflI7/MKRxslEFC/9Knu1h89xsGMvKFI/19rFcEp4Z2306EqZq7j+MHmsY2g5wJlkCfMI2TEeCPEmE+17vmwu3PPa64jRhdIdbzTJrztgP8E0DSx5eij/EAxVkA0c8xtb7LOnF0IVHa6ZXjU8IHZrprCaeVIqy9qqusycCBxrY4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB6987.namprd03.prod.outlook.com (2603:10b6:a03:43b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 06:09:23 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Mon, 8 Jun 2026
 06:09:23 +0000
Message-ID: <02d016ff-ecda-4658-ac6b-ea1a4388f175@altera.com>
Date: Mon, 8 Jun 2026 14:09:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: socfpga: Add MDK support with external GPIO
 expander
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 "NG, TZE YEE" <tze.yee.ng@altera.com>,
 "MANIYAM, DINESH" <dinesh.maniyam@altera.com>
References: <20260521015313.19663-1-alif.zakuan.yuslaimi@altera.com>
 <3126232b-ee1e-4571-a068-3b02274b3833@altera.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <3126232b-ee1e-4571-a068-3b02274b3833@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ0PR03MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 159e19f5-c158-429b-83dd-08dec5247c83
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: JCKaqh5xL4lktUtntFYGjTz3FMrcfLIrYLyuVkq2zDOKskbFSvMkqGRRiDGek1jso+X8v0UI6R6iEbN+PqlaQ5oi+Br23mdx5a7NW/7xdqG0/h1aFJ7/P7Z6NO4o5GswgJfbVut5MM9i64Chxvs4/j5QfDuvIvUmwyrHGCwqKm3cJiWP0DOZOT6n24B0SBdyuBj4DtdkxH2H6ogZpmKZIFAQtIjAdOCCbKNvtzGAvSSUUDHcPezGZbPjnKYSsMFbjG19x9D9WFKhq6b8HO53MSAJYILWIDehTS88FMzuoUYqIYp8IjOU3P6/+AhkWSoDu2B9U23X0RQ3HodnYbBytQ8prpzmvITGTbIzpm9zcxsvkTrfdTu9ksR7WEjPuMQiIxgiM/jEKty/jfELAGdy0C1ZltD1Gc7bCEsv/PMDmRyv94BVKfFIFLvkuNxoFG5txMIi96ycgWRYPN8xvtNuG7RoIIuvKcYXlcftsUVMZodwAkxXZJ33Tzq9gQyK+sGAZUM7vPjo54kJ9d5XlF4SCkKrE3/T0LOOvnoLz4AdpInVUqsKcpYu2GpEzgtcVZI1ZKrVAiYYxRLmDDqlCjk7QNjIRjp/wrUm8Va/h48NDfvj8gx9qUituC5x7Q9zmun+YoowirLEBUgAt5sDMsfGMPg93tOScBK/uKEac5MH9fZLsNYZDpjwle4XmLB+oEaW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkFXejNDaDFmam83Rm9WNFBXakZza3N5ZGF2bFJpKzA2bE1ZekQ0VDNSU3g3?=
 =?utf-8?B?Mi9WNnZFd0NKWG5uWjFxcXNEdFZWODJWYXVaREFEODhnNm1XWnJqTFRMempC?=
 =?utf-8?B?RzZmVTZtV3lHNlpUR05DeHNPT2ZGMm9mNjVYNkdad08va010SENGVnMzbC9F?=
 =?utf-8?B?QytUdEVTQTN6dXVEdjFRNjFyeXc2OHl0QUpKVmc1TnlJOFY3SVpWQkp0TTRU?=
 =?utf-8?B?Rm9HbjFXSzE1WllEWWNtQ2xuQWVlakRvdGhhYkd3S2RqdXVVNWRlblZqbFRo?=
 =?utf-8?B?Ti9zNVY3Y2QwZjZuQWxSVk1ObUdOVms4MFRqUmJaelFrb2FEWDFuTllhZXRF?=
 =?utf-8?B?UXhFTHV5YUZMNGdPdFVGSjlFQ08xOHlFcWVLTFQ2SkdkbFVxQkx0VldtcHNu?=
 =?utf-8?B?V2NhTU9xdHNhcGVWWEZ0dlNiSVJiZDg0RTlWaURrc2gvRWpUcmYzRE5YQU9z?=
 =?utf-8?B?VG45OTBsbjVORmN5VDZXV09IQkRYejByR0E3QTkxaUhjUHdBUFdKM1k0U0V5?=
 =?utf-8?B?ZENIeHVzblV4OUxSSHJSN3BMMFZoMXVLRVcrdXdTSEFudHNhKzE0K0x6dFpo?=
 =?utf-8?B?dG9ENS9JNksrZ0VuejZvZ3Q3SUlyaVlndEprLzZYbmdXc1haYnlTSXFKQURE?=
 =?utf-8?B?Zm9UNCtCVW5SZkUxWS9mZDlwSEI5eWFpcEFuTzJyWE1HbkZIM3hmQTlaUlNF?=
 =?utf-8?B?Y3JSSWJFaUo4UlBOOE9BWTlCMmZqZ2lwUE9lWERvVUFKeGVkSkNiT0FhUmZh?=
 =?utf-8?B?cjhWcnJiN1pCVFRYOW1Bbmt5NzJZd25WM3lCaVZnN2lydFBhOFZTQ2N4a1hC?=
 =?utf-8?B?d3ZaVlU5Y3VFRHZvdmZoNzVSaTFXOS9TRVowWWUycnVUZFFoQmkxcDVmYkFD?=
 =?utf-8?B?dFdOcTVtbGdKLzNJTGFFNW9yck91K0Q2RGVHRnhxTXhoYVNEbkZLZjI2SlUx?=
 =?utf-8?B?aW5UbEVSMW1WL0w0QXlYMEpuQmU1OWxIMHFEeGltSFoxZUI5UlBWWWlJU2U2?=
 =?utf-8?B?MmVSOThRclQ5cG1LNklYTG1wN1hGUnZrSmFLOFhqMmNFWCtCMkhHam9QVWdw?=
 =?utf-8?B?b1ZJcmxJbUZGY2I1YW5CeFA5dU12WkJPMkpGNGlzVmczaSsxUlV0QnJNQ24z?=
 =?utf-8?B?d3VaVmtNcWNPaGdLWXoyS1gyN2ZRb3JFU2xGOWlPbzRGeHY1Z2krcFlBdkNG?=
 =?utf-8?B?cUMzbEMxUUVGaEt0STNnQzY1dTRWSHhZZjhWd3EraEd2VkRheGhGSFBQNTVu?=
 =?utf-8?B?OE11ZE9XdERTcy9MeHRJT2d2Mkd4RHpvOWYxUDJxOGRZWEo2R2dYTzY3cHUw?=
 =?utf-8?B?OGNuYXdtZkx3NFlQMUg4WlFDMDAweUtoalZDeFgwSzFGK2k3L2YyQTRkRitZ?=
 =?utf-8?B?KzdlZzBxR1Bvamxia0JRQnFkR0E5RGFMLzRrQ3JkbTNWMkU3TEMzTmNibkcw?=
 =?utf-8?B?Q09wOTFVTWZXVDJ3azM0RlVDdWZYQWt4Y3orVHhGMW1hcm5vNG9mUlJSbkVm?=
 =?utf-8?B?M2pWazVPVlY2Wkt0RnZRT0tCSzZ2aTZnc3ZHRVRBYm5lcGtTMmZMMGNXcjEr?=
 =?utf-8?B?TXBlOGRKQjVuOXhpbS9nWUNieGx3eUVjcWwyclhWTS9kTmxlaVZCMTVTRVlh?=
 =?utf-8?B?S3VNTjJDWllpaFo1TjZlV2JCSDZLaWduOHVNR0p1Q0tvWFdxTEhOUGxtM3la?=
 =?utf-8?B?K0xNdGhQWTZvK3NTWUJWY0VuNHB5bXlSZWhDcHMzUU1URmlZNVlrNS8remky?=
 =?utf-8?B?SG1EZjBKSjRoS3BjZVYwR1NkUGZoWDhZL3V2clEvajQ2NXV1akgrc0xud2FX?=
 =?utf-8?B?MDB4RGRsaldrNlM5SW5JZERxbkVqQkNCV1JBdGZxUGozZUJmTGlSVHJ0OFNP?=
 =?utf-8?B?VGZzekcxQnk4T2VpRWtlNGhlalFWMFZXbFZpMGQ4MFRrWTNaVGdFSzZBNW5T?=
 =?utf-8?B?UmpoNlhQaVc5VnlDY0R4OFJCQ1dzOG83QTdPc3pwdHdhTldXL1ArdmNBMXhu?=
 =?utf-8?B?MTA5MllibUtiUTZJSzdXRGd1Zk1GZlI2KzlhUVRyWGNFcEU2eVU3Nk5CdGM2?=
 =?utf-8?B?WGROOWl0MFd5VmVROUtZZjdnMU9rUHBDMm53WVJ0bG9XalBkRm1HZWpmNG1T?=
 =?utf-8?B?RGM5ZDBsUDd6cFVDMVJMOXJOYjMwVVprbVYzY0JjR0w4TXdEdmQ4V3ZzSGlx?=
 =?utf-8?B?YWFBcHY3UnlmcmZGWkNqZ2MxTmJnMFdDY3cvWU9MNjhCcXJ4Y3I2NzhLUGNl?=
 =?utf-8?B?emVMMTJ6QmdVSnA0Rm1xcTVhSFdqNFlqcTFKZ3Zya2RsZTN1V1hDQlFBL3RQ?=
 =?utf-8?B?SldtRnQ1NFcvaW5Zcm1keEJJWUJyN0p0NW1rVHEzV2JkMlhjOEZ0VDRHTGhH?=
 =?utf-8?Q?rVnxp1CkYPL6+0hE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 159e19f5-c158-429b-83dd-08dec5247c83
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 06:09:23.5031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcXehh/iCytFSTO63kwMnnqWuFV3OXmbvXrSLs3gfpLvhKRFR6hf+oEUyyvoZSRCiys9B+XCcaTamFS0WYClDi3XnjrRaImqpQy+0RPISRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6987
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

Hi Tien Fong,

On 3/6/2026 5:03 pm, Chee, Tien Fong wrote:
> Hi Alif,
> 
> 
> On 21/5/2026 9:53 am, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>
>> Add dedicated device tree and configuration support for Agilex5 Modular
>> DevKit which uses an external GPIO expander for 1.8V signaling control
>> instead of the onboard GPIO used in the Premium DevKit variant.
>>
>> New files added:
>> - socfpga_agilex5_socdk_modular.dts: Main device tree for modular board
>> - socfpga_agilex5_socdk_modular-u-boot.dtsi: U-Boot specific additions
>> - configs/socfpga_agilex5_modular_defconfig: Modular board configuration
>>
>> Key differences from Premium DevKit:
>> - Uses PCA9535 GPIO expander (I2C address 0x27) for voltage switching
>> - GPIO expander pin 1 controls the level shifter for SD I/O voltage
>> - Requires I2C3 and PCA953X driver support in SPL and main U-Boot
>> - Same SD timing configurations but different GPIO control mechanism
>>
>> Configuration changes:
>> - Enable CONFIG_SPL_I2C and CONFIG_SPL_SYS_I2C_DW for SPL I2C support
>> - Enable CONFIG_DM_PCA953X and CONFIG_SPL_DM_PCA953X for GPIO expander
>> - Enable CONFIG_DM_REGULATOR_GPIO and CONFIG_SPL_DM_REGULATOR_GPIO
>> - Add TARGET_SOCFPGA_AGILEX5_MODULAR Kconfig option
> 
> 
> commit message must not claim TARGET_SOCFPGA_AGILEX5_MODULAR, not in the
> diff
> 
> [...]
> 
> 
>> diff --git a/configs/socfpga_agilex5_modular_defconfig b/configs/socfpga_agilex5_modular_defconfig
>> new file mode 100644
>> index 00000000000..3f3a47f02ab
>> --- /dev/null
>> +++ b/configs/socfpga_agilex5_modular_defconfig
>> @@ -0,0 +1,9 @@
>> +#include <configs/socfpga_agilex5_defconfig>
>> +
>> +CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_modular"
> 
> 
> configs/socfpga_agilex5_modular_defconfig sets
> CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_modular", but
> arch/arm/dts/Makefile does not list socfpga_agilex5_socdk_modular.dtb
> 
> make socfpga_agilex5_modular_defconfig
> make arch/arm/dts/socfpga_agilex5_socdk_modular.dtb
> → No rule to make target 'arch/arm/dts/socfpga_agilex5_socdk_modular.dtb'
> 
> 
> Best regards,
> 
> Tien Fong
> 
Thank you for pointing this out. I will clean up the commit message as 
well as adding arch/arm/dts/socfpga_agilex5_socdk_modular.dtb in 
Makefile for arch-wide make dtb compilation.

Alif
