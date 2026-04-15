Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D4CFA0C30
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 06:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54D8383936;
	Wed, 15 Apr 2026 08:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tss3t6xi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C64183B99; Wed, 15 Apr 2026 08:21:09 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AA5780086
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 08:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmulCUB8wHmVVvbLgNm5X5fnWxwz8pJcetBVm7xhkXjNrkOdLdHx5Gnje0xTyQZoYH3slMlAetLtNyqI4bI/lwb+bKvPzBTirkSj3hwUNw8ZwXLEeIY0iHHOK0pMu/Y/ETAxajmZ8AtCscH3fX2AKEInskZhTe30cQ9XcTTftVHIW4Ck16ALlZYUI0GWL5pukiU3RVZaXHR3H6GD36SkPr441vZ3zs0VvkV18SJAtGgcWQQPjd8VCd9DXrXwkbOdyiKjyezRbT63ivL67WYw1CZVoSq6GV5ezo0rCrq2zkZj2QP+rabeWmkCZZBRRuqcMIDeNtAh+Le704EJ2hWzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ceax5Dgfg+apGvatAOObtyvJZ4v25V6xyef3gX0ihEM=;
 b=RCbkffWSxhOi6A+QeSyCCWoyN21ZtWtt9SucXp2XG5iH+wBKAG53Q4bNQcl1ectGBcPVBZp34CBVtnIPFE7jYlNL3LQnOxDNnAalWBdTY5s6xOu9dqPG72SPbEP+J4gcvYK6Oh2SgVYLWofK2QhXFNaQUqfF53vilsTlXAt+pmyltIzWofQfznav2jOLP7O1Dedp/F/DraRjc9gT006aLhezbgXXWqCiswq0pqjMLVgLBSbUUaCT/UedEeZNlJkgHFT/JLHnRodmm6otXYANY3oC4LChqC0Jy8HYgRfGXkARNG7qmiI8FFVwwfKjs3b3YlWi8MO3jst2ypMEYdIunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ceax5Dgfg+apGvatAOObtyvJZ4v25V6xyef3gX0ihEM=;
 b=tss3t6xiRydTyfY5Ejo/b+rLLVCZb7b8kmM5Xlv8tFWfi9+PpwB1KDzA3RhWnPf386EbySK6xO+z9gd3rjpXkQoiogwGz+ndfWknWluPYhs27iGxTP69T7oMARCU6IxMvR7CyXoc3YQZFTj2VFZblyQrFxygI6ax6Ta9QLtUOp3wAGnjNpTyvAf3Uw2xHrUojjMRN1uP7uzaAAqf2LzkFaZZlq5q/XaH8sfmwCtXnqAgBbpP4tyMfIgQtuogEjO+TmyPuf8SAAeca4BXSM25yJi6rh4kNigPjC13qHhC5sCZL8VCpFiEUbRwENNMeguaOhpxqwDGShiVgMS/4zi5kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by CO6PR03MB6209.namprd03.prod.outlook.com (2603:10b6:5:355::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 06:21:03 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 06:21:01 +0000
Message-ID: <309b70f4-291c-4747-93e2-9302b9e9f8bd@altera.com>
Date: Wed, 15 Apr 2026 14:20:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: socfpga: Add NAND register address and data register
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
References: <20260304033734.28135-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260304033734.28135-1-dinesh.maniyam@altera.com>
X-ClientProxiedBy: SG2PR03CA0101.apcprd03.prod.outlook.com
 (2603:1096:4:7c::29) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|CO6PR03MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: aee16077-9f7c-4888-93df-08de9ab72a4e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|55112099003|8096899003|56012099003;
X-Microsoft-Antispam-Message-Info: smlOnrQHfrnk49Zdiae1AWDBi7x+Xc5Qt6Vyrt553EC7wtNHJHpSjh9IxZw/71+Zc42eDY5O+MimcYmKINxcDyMQ5Xa30XPgaQbvOZlp3ztkRldDjxeWP1PDqF01aU+2Q98rdxlzadwxnccWDg8PB1CngGxpgBCkFuEbI4Wzk18Z2Cv3RiZrsj2ML6TYVwSuiaCD2y/UP+Sa4q43Ux6+B8++BnNsg7+rn3vomQqUV5FD71OH4db9dCkjWZbaG71NAp4Hvs/8axeCNf4gU7wFLf8D1oeeZER905ouE/Rm9eEDMqc+dvs0RxmlwLWJjgNXfk9oJIXyD6+o4ZVX7kViBNd+6PF7AjXcXORPS0kMHe0tgDSaiiTFZQsAF1U+7kONHE3rKh3YQyLycTr4BkRjRSxOtE5g6WkRY772rI3Mqqgvjw1ZCgXtWyqleAZ5bgU1sSC/jv5l/vDGR6BGEU21FNkg578y+SHKE8N3siSeuZp/ShqdRTghYk0vwG+kW5wXKecRPTOTDxt90LjtvyaP7Sk/LZIFac3wawoFPu6xeys88ZiNCMGWF0wqmD1VBOmHE1KI+YKQJ2lFWOgMspZarppCmI43TRCMqw05JveasXTAumbwKaGehpUSD6JEKrtNp5adiTllm3O/S562uHY4b9trW8e5gf/WTSCNQufWP8Rg41E1RNxtixYz48E0nV5t0ojcKvf/WWW6dV5RzFNBQKXYUegw1f7kKJfepxDJm5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(55112099003)(8096899003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTR2MTZPbWszNVU2UTZtbEVuTVFOZTVCcmxXbkExclVuMW5yZC8ybmNGbWpB?=
 =?utf-8?B?dmhEdHdLQUg4M1RTV05tZEw5ZjgrM3dyWDgwQmU4cVRpdmE3aGJyc1FFVnRY?=
 =?utf-8?B?RmFxdWhQdjdkUnV6VjVwck5QZjRpMnhkeW9RcmZyUWRmRXRweGMxOGd0cTZ0?=
 =?utf-8?B?eldabmZOU0VxK0krUjI3SWNoTDl4RGU4akppOFE3S2thRUZKY3VyeVpKclF2?=
 =?utf-8?B?YXR1Wmg2enFSc2lqNG1MQ0JrTDZUdHZ6ZG1GTTFqL0hLUWF0Y3p2ZHdsK1ZW?=
 =?utf-8?B?b1FtT3NYZWpDdzVxNzJEYXZTUlZiRG04U1hheWx0QUU1cHp4UDZDWDhCU2p1?=
 =?utf-8?B?R0ZrbzNKMmNVME1qWjh1OU91bjczT2lOeXRjaEZXN0lQOSt3OXp2SUwvQ21R?=
 =?utf-8?B?c0ViOTRFMFVXNDNzVHY4VWdmMVlUT1pUSWdxbGVDL3pQenV5S0NQdllvOEJz?=
 =?utf-8?B?SDNLcXdtdk9hL2VOZmpucFFhUmRINTcrOXRKZkRaRTlWdUNQN3ptMnZJOEZL?=
 =?utf-8?B?NHp2R2YyUEczWTlISU5JdTF3Mm5RcTJpd1pMVVlWZGtZbnROMFlnL3NIbHl0?=
 =?utf-8?B?a0wvZmRHVElhSzYwM1VpWEk0cUYrcDFSdGg5Q1RLOUxMdWthOW5lSU9TQ1hY?=
 =?utf-8?B?ZUFJMndmcUdRZ2lNTVdSaFZ5YW52T3RTZjF5ZjB4SzFJQzV0SnVDZWNhKzZw?=
 =?utf-8?B?bkpRWFJPdXA5Z1J1SzN3b0IydUMrTmZlczlIa1p6SjRoTUZyckF2ZzZCWCsx?=
 =?utf-8?B?TWVHSk9ka1Q3MDFNRyt1Rnp1bnlLaERmWkJoZkxGZmFIRC9QZmxvdVlzOTFh?=
 =?utf-8?B?VFptdUllNVdCdXVOamFyM2RnWDkvRExCS1AzQjVpWjlJOGpHVnVaUFlOL1pB?=
 =?utf-8?B?ZWVqanZ6VkVRRE80am53OWdpc2krUFk5L1NnbDRuVnZ4dVJGYWcrSE45Q2dR?=
 =?utf-8?B?dWx0R2hzOEpETGt1Y2dHc3I5Ynk0Nmpic2diZUJ6VmM3UllzL1B6Qno2cXpU?=
 =?utf-8?B?ZHdoZnR0UXRpSmdYUHViRE1hdnBmL1pJK1RWeG1EZWxaMjk1S1RISDg2L211?=
 =?utf-8?B?czhGdHhJNnpsQ0Nkd0JQeW1FcFlmY1FjeTgxOFlWRllZUGFKSjF3OTM1SlRm?=
 =?utf-8?B?TkdmcVJVajBBQzE5K2hFWWNYTlZlVnVPMXdFL0hKV0tycXBsMjNBRFZmVmdJ?=
 =?utf-8?B?UUNEUERrM3UwcnJQeHNNTmlsVmlhT3pHaUMzNVZ1NkFtTFdieDRoWnJoYW5n?=
 =?utf-8?B?ZVhSWmVzaFVOc29ZRmxGenpzOXEvT0pTYXdtTFdEVTl2NFo4bzhveGZUcmlo?=
 =?utf-8?B?dmlmNG94UDZXTkZNbEhZRkY4WWlqZklpOWNMTE5KWk83TE4xa1dHUFhneWhq?=
 =?utf-8?B?RVUyN0lrZk1GNjN5VTBqY01YeVlXR2drdCtNdm4weExTb1p4Sms4N1VuNUdX?=
 =?utf-8?B?UVg5WkdVSTI0WjhiLzRuaWhpS1RrK2I1dklBTXU0UVE4dUl2d0pQYTd1TC95?=
 =?utf-8?B?WmVVV0VMSUk1dTZqTHJiN2tqODNjeGl0Mkw4WnlETjNwd0pzZ1A4YUJ6aTR5?=
 =?utf-8?B?THJuaGFneXplbW1UL3VyN0lUYnNwekxrd1VXOHIrcEgvaVkzNlZOUTV5UmJq?=
 =?utf-8?B?T09ERHZpVVFoT1ZCUGo5Z0FyT2h2eE11Y1R4STZDSHN3bms4bytiRkNybE9i?=
 =?utf-8?B?R1V1emJSbFlxY056NVNCUHpRK1huSitUbUxGOFU5MkVCMnJMcjZOR1ZXNEU2?=
 =?utf-8?B?U09sSmZHZzBkcUd1aVFDZmhHUWgvYng5dG1INjQxWlBtVi9sSFlMbGtVc2Iy?=
 =?utf-8?B?RlJuR3lhbHRyb3RHcWVycmNiazg0eldWMzkrS3BNSjZOM1B3UW1MYnB1THNq?=
 =?utf-8?B?aitUeTA2MjB5aThacGR4M3IwQzRVZ05QZmw0dS81bHIzVlo0dlBMN1crVWEv?=
 =?utf-8?B?bVBjYmRlMlBnWndaVmZwR0RRR0NNTkwxYUhlcGlFeCt6cElLbTFjOEk1aUlz?=
 =?utf-8?B?Qk91OHF0ZEQrVUpNakQ0Ym1Db1lmeC9wcXNvNCtSTnhnZlBHOW9la0dqYWNI?=
 =?utf-8?B?UW05ZFVIaEJMcmlsN04vV2dEVUw4VElleUhHQ2VINFhHWnpwVXRvSlhPUHFZ?=
 =?utf-8?B?TjVrQUV6MExkMFp2UjRnNThSeU9yWEpRZnA2YWZYTmJFN29xUHZwT3hzcmZV?=
 =?utf-8?B?WlIyZjdjT2o1Zm9tRmVsQ2RjSnAxN1F2NUtrN0hsYU5VT1ZseG1RNFh0T0Vx?=
 =?utf-8?B?N09pTW1yL2JkZ1RLclozY1hLOFJsa2hvZUVmb2hmbzArWFlMK2pwR0xLd0pt?=
 =?utf-8?B?Ni9kZ2M2ZEhLWi8zZFJReE0xUnFXc3JmR0VvQU9vaDQyLzJuRkpqZ09HckRr?=
 =?utf-8?Q?hclI721dlRkEFNuk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee16077-9f7c-4888-93df-08de9ab72a4e
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 06:21:01.7292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJoz/iH170lKIAW6ADGv3N6WmEfwxpS9dOJaFIcUoLkjwsJHH5D3IiHOUkBHNBcdMaadCHw9Aqvuk+MTNUS7DddYrMrdfunKzV6uhflbzTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR03MB6209
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 4/3/2026 11:37 am, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam<dinesh.maniyam@altera.com>
>
> These are required by denali_spl.c for Arria10. Pre-set nand base and
> data address will be used for spl nand read and write.
>
> Signed-off-by: Tien Fong Chee<tien.fong.chee@intel.com>
> Signed-off-by: Dinesh Maniyam<dinesh.maniyam@altera.com>
> ---
>   arch/arm/mach-socfpga/include/mach/base_addr_a10.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-socfpga/include/mach/base_addr_a10.h b/arch/arm/mach-socfpga/include/mach/base_addr_a10.h
> index b947cc07291..120cbfa23a5 100644
> --- a/arch/arm/mach-socfpga/include/mach/base_addr_a10.h
> +++ b/arch/arm/mach-socfpga/include/mach/base_addr_a10.h
> @@ -12,6 +12,8 @@
>   #define SOCFPGA_SDMMC_ADDRESS			0xff808000
>   #define SOCFPGA_QSPIREGS_ADDRESS		0xff809000
>   #define SOCFPGA_QSPIDATA_ADDRESS		0xffa00000
> +#define SOCFPGA_NANDREGS_ADDRESS		0xffb80000
> +#define SOCFPGA_NANDDATA_ADDRESS		0xffb90000
>   #define SOCFPGA_UART1_ADDRESS			0xffc02100
>   #define SOCFPGA_HMC_MMR_IO48_ADDRESS		0xffcfa000
>   #define SOCFPGA_FPGAMGRDATA_ADDRESS		0xffcfe400

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com> Best regards, 
Tien Fong
