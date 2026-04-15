Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6037FFA0C22
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 04:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D244C83936;
	Wed, 15 Apr 2026 06:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="fr1ajPlA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A751E839D5; Wed, 15 Apr 2026 02:59:22 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDD6E80086
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 02:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ly64Ol/IHRzxp/C4DYC/W+LHnRaXNVsC0Ucl3Ncx4bYf3fOTfKnXzkdhw8GowoGt4C3mCw9EBYizLNnjB0B6ILWE8gjTlg8zbD8UfJmvnRdHGUv7/o3HuRQBZL9mSckP6zkPZRT/Ojzkdh5sBaZICV2plSHbpNP+DBFzHte7DrNaY1ck/fdUrarJx/829qcT9KJy5mXVSGJoLMIQxkBQfCmqHCZM0NNbtEBOEMgNsDaJiRrXRD1V0DTAT9FCUMcwQnOvECu7tz58+XQJ40hMr0My39hccxLqKIoDXnOTVm9n6A2MOt/MuEREY1qJZ0Y+UC8UtLzcK/lfuNDIXEu2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07ANEuJF5HOQEPGvW7xeXRbLFxJaCqRXNb0Klbjn0lE=;
 b=lbt9yL9DLjI85KBz6N6qy+g20llkWisCNyzd+utduETtREqDTUnc1jxAs543eHgoYh+jIlfiKMNFRuXj+e+gsIvjNJ+GkyEJiXTeV1x7Yw+zk4JuWCpt06sQUcmYyQy4WwQDJViuEiM6blCByluzaBme71Ak73eyRZEkHWy1+dSz7v7r8g9USm0k//C4s8yrHjHpAdeLWOJXssIYVR7j6MZNTPMxU028bz7zn1QcAb0Qh+kZFcPK52RLU7Nge3dS+NeyrSucnl510ua62Vg50tNhpgBn7iMzifdO3z7yyuJQGWKoEZCqVAW/vQG7USUpyWAtH5dDuZ+C38qVNPt46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07ANEuJF5HOQEPGvW7xeXRbLFxJaCqRXNb0Klbjn0lE=;
 b=fr1ajPlARWZic4tMEiJckv3zpBL3XJga9kXuwG8ixpFgccMZzcIzzN0ogkcyxiJ6zUaAY0m3W62LbaQi5XfPjE2Hvd+ckWWlWholMSR5cbltudqyjJ51pzmRbuZlBGWkCOpSMbvThRIKJyFQQd00tE6zxNAmDEFhgHC0pp2Wa/B4QOqTh/Uar2hN6B5X/BA9cPF+PgkVmCqyD0ZonyLH9biVFJNaLsDywzgB0zZp3rO6WTAGjOH+5hrCPqV2ca7QSFowC8n3xaUauuvh88TsfcJEuMNVe09GZ3KKPwuCIuCcunTogALg5Cy3KrZJNzUCLUMGoEHuu7Zkw+brbeHRKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SJ0PR03MB7051.namprd03.prod.outlook.com (2603:10b6:a03:4d7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 00:59:16 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 00:59:15 +0000
Message-ID: <bab16085-c839-4542-a0aa-64feceb97d7b@altera.com>
Date: Wed, 15 Apr 2026 08:59:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: socfpga: soc64: separate reset manager into
 common and platform-family parts
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 "Rosdi, Danish Ahmad" <danish.ahmad.rosdi@altera.com>,
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>,
 "MANIYAM, DINESH" <dinesh.maniyam@altera.com>,
 "NG, BOON KHAI" <boon.khai.ng@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
References: <20260210052359.2644-1-chen.huei.lok@altera.com>
 <LV8PR03MB8137BA02FC8E03F7218A1C62A7242@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Language: en-US
From: "Lok, Chen Huei" <chen.huei.lok@altera.com>
In-Reply-To: <LV8PR03MB8137BA02FC8E03F7218A1C62A7242@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:4:91::13) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SJ0PR03MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa4eba4-ae7d-49b0-d104-08de9a8a36e6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: W4hfeI6nu1ilKRgX4tik3qn3eFmaswz6+UN/GW4ZOzvrdaGjgIpfrm58oJrUo/3/bROxGVSiBHa500S1se7Xn2Awofj4aVmUqnWxceVD6W+nxT3gnkEz0xO9+1CYy3/eir6erjVSr95PLms7BllnaRteH/fAdELaDN6dBbcX/Z6XJktp0rcZuemmCaJCAar2OGnuXB8yYFCjeAdY05ojJqfZR9UpUWl878a7msJedIU5kd+37671WHIyMhDGNweuM1qWrkmIg3cbbsT2lrr0HWJw1MpGwcUyojIm4qNMfcAZi1oZLNQNEXKDysoBZNd+6DuRblR5CrIJ/RUEnRH/I0Ym+mIcoPRJak4yZCil3D9ndZZSmj0/YIAzpI4EGx6QaQWJUEL0wWc8z2+kZQXT6nq/upZHHXtdxkUQBlj7dvVxkhrOcvFT/s6bpJ0dxSYfFn40nAcDK0C83a6bgFdYKNjj02bBu80tnGW3M08maAfYtnPlUriIh8fxFz7Cy+yfVsfnu8xC4IVPjSgLChX6dnmH/tfk7VytqUqp0mjvziqzG5SRBAx0xITk5GKgta5F86z0+uPZBM/Cv+jidHbO3q//i5Ii0PAJlIrvxXWV6L3SHSfmaxyA2G7Qdo6/N+Lvqd0s5ysQYRd39Zacyk/IPLchsIaAjaIszzKvzGRQSkzltEERI4CpX6hsibRG7Ag2uzJh+UBHNB7PXCFlR5YGjnC8sM2j/cxGC81TVko9NCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWJyc3A3VzlxWGgvMnZKSmlaS3k3cnUyZTFnZjc1SnArOUp3cGZkVFRJazJ4?=
 =?utf-8?B?cGFObjF1dEU3K1NTejh1dzFLb2dsN0VvRklwOE5wU2lPRUZKaEYrTEFKQnNn?=
 =?utf-8?B?dExlQWl1Ky81dzE3Z1lMTTZMZVgybEhxVE1IWElmR3cwSjZxZHo1eTlIeUlh?=
 =?utf-8?B?WWY5aDhiOGo2bGNaN2g1Mk5mUmQxejFWYnMzSmluRVZYNXlNcGJGVGpXZFp1?=
 =?utf-8?B?VWxBSTRHdjZhQVJManpxQXEydXR1RUJOZUIzZEtQWDZWbTF1ay9xRmlDTDlG?=
 =?utf-8?B?eFhSSEtjSXE5cE1Fc1BJTzRMZEdJTWR0RHlvOVRKQVM1LzB3eDdRVFNUTWRr?=
 =?utf-8?B?dkxLckw4eUNUMk9KcU5mNHRIRDhKcjlaUVkvTEFCSFpxR0x4SzhuVy96Tzh0?=
 =?utf-8?B?QVBDT3ZLTS9VWTQvelpSMy96dkUxY1RPY3F2dEhuaHJVUlA5bnFNc1JrTFlB?=
 =?utf-8?B?Q1VMNnM3TmNUZG92UEFrVm44cG9DcWpjcG42S0VqYkZlVHRGbmRLNkJ3ZWYr?=
 =?utf-8?B?VVJUbnJhRDZvRGZTcjd5dDVjWGk0RW52cDBLaEJjRUlrd0NlL3Rjd1dqRWZG?=
 =?utf-8?B?WldpUXA5TmNQMllwTnE2Ym10S1dWREV6YmlvTmxNV2UzMGYvSms1WlVpRUFv?=
 =?utf-8?B?TU9Ncm1wdHFCK2xnemhYUHFzVm13YnNQN1QxRS9raXFXVm04Z1pHWkRSRzZ1?=
 =?utf-8?B?YVpjOG42MUk1dy9MLzB5SDlGNTljSWo0V3ZvMnMwQkhuUFBBM2xYb1hwWnNW?=
 =?utf-8?B?VS9HbDlBY2xVWFZ3MjgxWVFCNEdxekJBZGV6NW5DYkpLMWxMcWJyQkx5eStk?=
 =?utf-8?B?N1N4TDV4cXBVVlJvNkRHV095bGtOc01TZjRHa1ZYR1ZLU0FPZHBnUFE5amR2?=
 =?utf-8?B?KzdDTXFYR0NZT2pCUTZiODlXSmdxMFhoYWUyMUFBRjdFaXU2a0c5TGNDdjRB?=
 =?utf-8?B?a3p4bjBHUFVOYVI3TGlXL2gvNENscnRycGE0dTJPUytTSDQ5cnVmZUw3WE1o?=
 =?utf-8?B?L1ZLeWprSDU3UDJWSXdqbmZoNHU5ZFFpWWRQQldHdnRmZWZLOVdYWVpXTXNV?=
 =?utf-8?B?azg5ZFJsVU1sS1FsMnJNTVRhMExlTmdxUkpjR1NRWk5HT0ZPOHF4MFdpaHBY?=
 =?utf-8?B?QXp2UkdPN0pLV29LV1V6eXU1dHhNbUdCeWVITFU5RW51Z2pvTDRlSDgrYXVH?=
 =?utf-8?B?cjEvZ3lDcStTSTNSZUwyRzlENjZEYWlza2hTOFl4TEJmRHNNOFZOaVMyaEk5?=
 =?utf-8?B?OTlhSXN5MGpXUUVseDc5K1IwOE4rbWt0WGJUV3BWUXk0NzFiQ0dyM3I2Sjlj?=
 =?utf-8?B?NFhBam5DSkpPVjdrTTRrZlNuNDNWaGI2UldYUWtNd054dmNFVTd2RGozWm9U?=
 =?utf-8?B?bW5NTnY2NG84enNVMDdxMjhJTXNOWVFyYzI3bUZNbE9KVktvVi83ZmZpZE1Z?=
 =?utf-8?B?Y2ZxWktNc1BiTzVabXRyMGZhNUtTK0lQbnRPV3BWR2dUZ0toRU5USGh1NEp4?=
 =?utf-8?B?NUNQdVI4ZzdxVWtTUGNFWSsvQ2V4aXM5cVZtOUd1NmhwUkQ1dndYVnY3R05F?=
 =?utf-8?B?MjVHT1N3Zi92NWxFRWFnWkdWdWNQcGJxMzRRNXVBRVU2MC9lN3NEUmVmQzFW?=
 =?utf-8?B?bitIaDVTc01XY1RkTXk3VVMyaW1wd3RXdjdmMGZQazYxYVd0bnZITHNnVXMx?=
 =?utf-8?B?cWl1WWR2RFV6WkZJZnVSeldqL3k5OFBnaXFEQnlDeG5uUFk3QjFpTDVpWjRK?=
 =?utf-8?B?THppMHVxTG1qdmE0aEY4d0ZVWkRWS0VXaUU3VW5keXBmOW4xcjI5ZDhsdWRs?=
 =?utf-8?B?SW1odnZIY2FLTzN0N2FBRGRoWS9XMDBBSG1Ga2VvQ2xnOEU4SWorNjNhOE9w?=
 =?utf-8?B?LzArMkdLWjZreUl1VStqNElFcDY3Mkc4emhQZVcwc0pnN01SemxGOUdqQXdP?=
 =?utf-8?B?bDNYcjMrTXVwV2RlZkdnaWJRZVVRQ3lCS3NWdDlBc0tMVEI2dmc1OEZZVWdv?=
 =?utf-8?B?aDFzaVd1NGEvc0RGZ0NrUXdzc2MvVDJLb2RJV0dmMWZlZzZqREJjTi9hME5M?=
 =?utf-8?B?NldHVThHSmR4b2Z3N2xDMGE4U0RoTi9CMDg5WEFrV1VFN3ZGK2ZjMERvUGl4?=
 =?utf-8?B?NnNXQUk4R3pTWUhKSnBrS2J1QXRSdjY3RVBMcjZ3bVZzVHlkd1hsdlNOeFNL?=
 =?utf-8?B?ZHZMZ1BldlRvRUxPeWg4bEYwV0FHSzlaVm1OWld2TTBTRjlvWHhWamtIZlVK?=
 =?utf-8?B?UDFFWjdlenBIalNmRXhuc3VnT3BGMUdUS1p6TnZMS28xeU85aFEvSDdHelBG?=
 =?utf-8?B?VEVkMWxDYWJia3ZJUE92M2NOQXRMeUZiTXhMVlVTaEJSOE1TWHJlRkVsK29X?=
 =?utf-8?Q?GPrCO/3E558uL0Wg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa4eba4-ae7d-49b0-d104-08de9a8a36e6
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 00:59:15.4797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gL3QAuE9CUW7OgDTAk0k1HvIhpiWOuPva34PMa76aODO+W5Z3idV/F66omcKxzrrEQmmyl1ABmzyRfdqqJySHihyg+jMEy1alPQD1JcYYvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7051
X-Mailman-Approved-At: Wed, 15 Apr 2026 06:10:26 +0200
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

Thanks for the review.
I agree with both points and will fold them into v2:
>> The SoCFPGA SoC64 reset manager code is currently built as
>> reset_manager_s10.o even though it is shared across multiple SoC64
>> families.
>> Split the implementation into:
>> - reset_manager_soc64.o for common SoC64 logic
>> - reset_manager_soc64_platform_families.o for platform-family-specific
> Consider a shorter/more conventional name than reset_manager_soc64_platform_families.c
> e.g. reset_manager_soc64_families.c
Rename reset_manager_soc64_platform_families.c to 
reset_manager_soc64_families.c (and update the Makefile accordingly).
>> +#include <errno.h>
>> +#include <exports.h>
>> +#include <hang.h>
>> +#include <asm/global_data.h>
>> +#include <asm/io.h>
>> +#include <asm/secure.h>
>> +#include <asm/arch/reset_manager.h>
>> +#include <asm/arch/smc_api.h>
> Includes SMC + secure headers, but the functions shown don’t use them.
> Prefer minimal includes. This improves compile times and reduces coupling

Trim reset_manager_soc64.c & reset_manager_soc64_families.c to only the 
includes that are actually used.

Best regards,
Lok

