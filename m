Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696FAD609D1
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 10:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAA8B895E2;
	Wed, 27 Nov 2024 11:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RYaBUcQv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 993CB8970A; Wed, 27 Nov 2024 11:56:23 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 007E8895D2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 11:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNsFx7vkf0qRB3iLVtOq9Zb/Ou0SbPgIzQGp1EXqSA4q7pEq3qRkPjH64pN9JBsemZ6LpNV72+lY+iaUiF9nTR4b6oL2oqgijMCgnoCWXhTIjRYVtwIaALw1Z2lrJ0m4oqkKwMIwo8Rcj2qT16nKG/m5sMzB2W8tn24mqbjbWupek811MET0kFfcwXABg/69RbtjnMywRBEpTlR9kEZVV8JZl1qR+ZRMS4SLnTpiCdivspu08/HqtLrYfkrr/2AzJ/odWL1W2qHotVEW9aMj4+UljRcVIKrXg1Eg/088IH1eZp2YdA4qPa2NpUA2mPOS5gmXaMr7dpB2Cm9dIjvX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hky4mvVWGu27lATC/vuGdoqiPPO3+BklAVmLZ7WVs8I=;
 b=cd7/exWSYyuHknbJX/E8x1hdaMgnvtLM82qzoZ35oncAHqO4B7vuLYSH93uHCjrKBae+6R067yMNd0hE6gWJGXD5+A0X7UZdyohCUrAAnQcWjCQ2yYJAW5aOXgfRm0bZJClvxBRDlwD2gVq3MXyJP4ufP2VVzS/65TyMn2KWp7pMGwj5uGtb8PNh6P3uyaOTPsEIFiO4JrpBJ3sHb/v2Oi8wQ4kIsDegIW6IYrPWNfNrUeZoWtIyu9AAvu5EBqiz0yRdRmhMpZPnUb/fBbzJi0bHiUenobcD4xcjj8tBbfVJX/OfgGSQn4PTqdxPd8pwI0wsfxt04wGkn06qkm//Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hky4mvVWGu27lATC/vuGdoqiPPO3+BklAVmLZ7WVs8I=;
 b=RYaBUcQvJutozvSC0txa9QN2DM6p9Lx8LGQxRY81UlPxoMR9HKGlp/D4bxf6YVBg9yNtf8Rg9A7MWOUE/f2lvwE2Ff+MoU3w8Sqz4FuzwnEfiE4baVSSgdYyWHevY01s+y6GthczPOOll7Sbr2ezFEdKH1/ggpAm72VK+bUU4hE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 10:56:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 10:56:16 +0000
Message-ID: <55fa5455-4c89-483d-bb6e-5a50a89de050@amd.com>
Date: Wed, 27 Nov 2024 11:56:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: versal2: Enable OPTEE support
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20241127043745.249580-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241127043745.249580-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0027.eurprd03.prod.outlook.com
 (2603:10a6:803:118::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: 449302e5-4d3d-4f95-2447-08dd0ed21dda
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a24rcFJyelFCaDlNOGNWTVVIbUc5MndHNERxTXd0bUZ6cVMyL0I1WDhuZHc1?=
 =?utf-8?B?anhWR0VVSEIwYkpqU3Z4aDhOb2lab201WmNiMmlzVER3a29Dc1RwcE1BNE5w?=
 =?utf-8?B?Y29SZEU4RVlqc1djcWxqYm5yQ1lKeHNHY3kzU3VHYkZZVUlYQW5RTVU2YlhC?=
 =?utf-8?B?S2J4SDRmWldsMkp4MG8vRWRDYUVzSWJnMnZOK083cjA3NUdxbTV3RkFlNTJ1?=
 =?utf-8?B?bjJ5aHI5SEpZOTNSaTAxUkhHckVSeGtUQjRVMk5XV3N3bHFqZk5KUVcxUFlM?=
 =?utf-8?B?am5KSDI5T3RDblRPM09wMVFuQ3E1b1VqNkg5NjNyVmF3SFQzK3RiWi80Z3Rp?=
 =?utf-8?B?KzM4WjI1NnFyQTFSQ21hYk9pL2FabjQzY1QrYkhkRHUwN1dPdnA5NEhEUkxu?=
 =?utf-8?B?RHVOVS9MaU5URHJ1aHovcjlIMTdscjROZzFJRWp5TTJaWkZTNHRiTERzQmdn?=
 =?utf-8?B?SFBEL0oveFNiU0NjSC9PTzBDRE1mWEJiMW1kNFRUWlhUTWRiSStYeTU2RkdC?=
 =?utf-8?B?WXFUWk9kdFp5dlU3NkQraDY0QXgvY29KMXdKSUU3b2JvR0RDYng3YlRnQ1NT?=
 =?utf-8?B?RllpQ2hua0EyVWltLzRBb2x2Q1N4c3lEWGh4aXhWdEE5bTg1OC9CYXJiNGp0?=
 =?utf-8?B?cDIxOFM2MVFyMXYwQTJTMDhMRm1qbjZodmpVZWNlWXJuS2Qxd2diOTc0YWs3?=
 =?utf-8?B?dlZTNU42VFdFWlhGYTEzR2RYOEJtZjk4b3RsSUtOVXcyUzZtUmNsSE54R2hR?=
 =?utf-8?B?T0R1cnRGV3d3SGtKVEpSQTN0d0xlQ3VSWlc0eWpIN2xkWGtpbkFMVVZzRVV5?=
 =?utf-8?B?L1EyMGNmSndQTTJubmVaTGxBbWVZVGhoT0xjNGJjV3crZXJjYzFzakhkam5Y?=
 =?utf-8?B?bHNDOEJKSnE0RUZrRlpCNDNrRUE4alZtenBEZGlmRWZFQnQrZlpSUHkyWDh1?=
 =?utf-8?B?RGlHYUN5eVFyMWtseGFZcHRMS1lWL0s3NmdWWjYwejJzODBWSG0yVmJBcHJH?=
 =?utf-8?B?K0M5T3Y1THB5Y2hlRE1zOUdXSWJDVUdNMmkwbWJLRGJDenpTUWNQdzBMelFa?=
 =?utf-8?B?ajNKcEdkRWpOZHEvR3hVNkxLMjgzNEdiUUU2aWdnQ2J5TEN0Z2liSDU1Yldv?=
 =?utf-8?B?bmJqektvZG16ekt2cldLdzRTY3RORUtEMkZnakdYb2FjdUFNTlVtK01pOFd6?=
 =?utf-8?B?TEpQRXVUZGdvMVlQeklNK3QvNFBaYi90anZNNUd2VWpvSE5QTzNWQkRZZEhS?=
 =?utf-8?B?cHV4RW9LRDdmOEUrVWJYc25RYlVxYjdRS0RhZjNINUtqOXJFLzlyM1cyamlo?=
 =?utf-8?B?UE9xbTQ3MzdYUURGYmF1R3Qva1U2TzF1bHd2aHBxaVVueWZxeTJWRDFuV09h?=
 =?utf-8?B?S3ZiTTMyNzltaUdHemord25MbjJqbWlmQ3Y3ZWRBKyt6SWtIS0V4Snp6RURa?=
 =?utf-8?B?SlZnR1ExOUNBN0ZCWlM0WXREd1ZUdzFqZnh0N0paZ0ZuTFJnT0Fwc3JaSVVO?=
 =?utf-8?B?UG5Yc2RqRHhVTWNxSVlTcnZkL2VjZDlYMEdReHJUMFZKcU1GV1dPSEE3RURD?=
 =?utf-8?B?WWhKdFhibkdGdWFMVU5vSDhIWEdGRzdpNTd1NG9xMW1JTUhFMldOM3dDTTVz?=
 =?utf-8?B?aDZzSDA3RTVDUlpXOXYwQ2ZLVWIwNDNpSElISjdpemlhTmZVVEZnSkxUc0JH?=
 =?utf-8?B?M1hjMGNRdVB2QVVSZ0hzS1dwdnNBZzJrY0JyeTVmT09yRG94cWRRU25kN0NV?=
 =?utf-8?B?WklXbTJ5NVowQW9FeWtiejV4MlJFcGZkUmU1UkFwOXVLQUVIZVYwSnk1akVU?=
 =?utf-8?B?Yk8vV01FSEpSbzZMN1BpZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHprU2tWQzVMV2UwTEtLWUpHejAybDlEcFJVNm56RFZQdndmSHZzbDBlbEFj?=
 =?utf-8?B?cWJZRGtCNXMxdHhrSmFnK2gzY3dwRzZrOVFud3VBYldJNnBtdUY2M3JVcThV?=
 =?utf-8?B?cUFkVjRXWUVtSjRqS3EyNUlBMFZRY0xiVmlZUldLbnF2N3NIc3puRnhydU96?=
 =?utf-8?B?ZUFMeVBieXdqdDhWWHJKVmpCM1YxNTJhMWRJdmxDNEVBWlVuWjdsVjZzVWh5?=
 =?utf-8?B?akE1MGtjdmxxdmZEKzFpWDBGQnBmY1o0ams2Y2dnSS9GUXJiV0xrTWtsYVJU?=
 =?utf-8?B?NDE5d3pNMS9UTHBUSkNuOWVBYWVmUSt5eVpMS2lkVHZkc1JteWlIZFIydTNr?=
 =?utf-8?B?VU9kQ25JYVAzQnFidXZFQVV2b0RwZVV1OGhTdnJrcEpGRWt0RkpYTmZkN2RN?=
 =?utf-8?B?ZlVRZ0lwM052OVBKajRSdkJVSmQ3Y1RzUW9rMFRUaVo0ZVdJY3BobXZjV1dU?=
 =?utf-8?B?UTJqVkdoOWpOTmo2WjNrRnppNTlsUFJDUEMzSnNOOVlzNUJBRDN4ZEdRS09V?=
 =?utf-8?B?REU4WHYrajZNd0ZUVXhrRU1BbkY5QWdpdDVHUDVaRXFjaUlzaW9pUkJNZ3NM?=
 =?utf-8?B?RlcvY3ZkOGI2QjZKci9zcWNpMDNBWEoweXNsb3d0OStVb2VsN3hxTnFQTUli?=
 =?utf-8?B?YTg1c01sZTdhRytROFQzaHFUWExPMnNHOEg5L2JmVExlMlJSNEdROHY4Q3Mv?=
 =?utf-8?B?VXYvWGF6bnVtTW82aVZRSzVzWmhTdUw1WXZVeVBjNDFvb1g0V0FvMkNONmo1?=
 =?utf-8?B?bnk3Vzh4Z1FGcnRWYWRhQmxua2xYcDVrSkFWbG1lNjZrYkk5aCtoQ3dmSHJo?=
 =?utf-8?B?WjBMRTNsSmJCMkdjeFNJSFVvNUNHT3loV3hheFZnZDZ0ZlBFUDRFVnZTdnZM?=
 =?utf-8?B?TFMzUXFEc2ZUd3I1dWRmdzE0RlNQa0wyU2FuL0duOW95TFpRNFlQNlpqeVFL?=
 =?utf-8?B?TElHOXp1aXdwbEZoQklVdGoyVkhEMEJyb1ROdzNkeEdWNzdOTEJCT1hoYzdV?=
 =?utf-8?B?NFc5Zmc5MmxLUU5CTDFjc1YrUHVIcjNvYk9kemVXL0xMSlo2YVUrY2UyTXNr?=
 =?utf-8?B?OFhPSEdoRnRPS25EUlJTalo2UkFrVVlZYzllRy9ESDZ3NXVVOEttU01FazRM?=
 =?utf-8?B?aEhUL1h4NVJkckVDNTAxTnF6OEhsL2htZ3QrNGI3VTBtNWE0cUwzZVFhcWF6?=
 =?utf-8?B?UnBYMnhiVXk2YjF1OGQxNnZ1cUovRjhSZWc3dFJ3aWt0dkNOck9kellINEph?=
 =?utf-8?B?Q2hYYUJtZmw3RGQzbk1ZRkM0S2V1dGFoc2dBZWtKSUJRWE9OQm1KcGFHYTli?=
 =?utf-8?B?czF6T1E1a0VndE01OXo5NnVUVGZyUkM5SFp6bXo0MGpHMndyZGNlcXhLQVh3?=
 =?utf-8?B?MGJ1NWFnK0VXeHVhU3Yyby9DMSt3Z0pURjEzSTd0eXBZNmxnMHZ3NjFOOUVK?=
 =?utf-8?B?TUM2NGl6US9qdE00UEFhQWhmT3lKb0VONlgyMDlLMTVmbUk1bFU5OXNFaU1n?=
 =?utf-8?B?cXBld3R3a3lFVzJyZVJIQ0IxWUJDTEQwMDM3ZENYdE8xMWpNYnJVYXlXeHQ0?=
 =?utf-8?B?cFA3bzFEejlZRVhpZDIzSFZaVGdRQXoyL3BIZXVuT2xQczdIcFF6TFpxNUcz?=
 =?utf-8?B?TjExdk9RMk05aklRMksrY29od2EvWnd6VzI2Wm02QjJ1NjRucHVTOHBwVjhp?=
 =?utf-8?B?QlJmS09LU2FwL1lxWE1LWURBQVI5djJVS1Q0V3pzbjhLcjlLS1NFaFhHMFNF?=
 =?utf-8?B?cGxwcVdEazNjbXVKYmo2RFpPUTdhd1N5ZjZMZDA0QjAwRlF5V2l5YVFDOWRq?=
 =?utf-8?B?YmdtZDFnejlsbTNQSzUrYTd6eUpTeGVLKy8vZXh0ZFYrN3YwWnNEdndDWVFM?=
 =?utf-8?B?TzcxaHlVY05GT1RuWk5JNWxNQ0QzRXMrSkpDQ0J5V1QrTmJKM2JqR1VUaHRU?=
 =?utf-8?B?T2pvREQ5NzhYR1lUTks5V1FQTFhYTzlhRHFSUUcwdUx0dUVoUDFNNmhvQml1?=
 =?utf-8?B?RHFMUkFESm5IS1VTMk9RRmtPRC8vcWVGZEp2bFJXM2VpNk9ERXlsaTBzdzEw?=
 =?utf-8?B?L29ELzhhMnZmNnQreDkyOWdDRVhVREZpNlY0dndyTUt1dlgrVjRFU1JBNGdy?=
 =?utf-8?Q?EKPtTy7PgRY9+gRiTnVybEcuF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449302e5-4d3d-4f95-2447-08dd0ed21dda
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 10:56:16.5758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GWE7mxjmBlfkk5ipmgLUB4k/8eFPxDKTI+SGtjYasdlLvtOKu511YNgfQCdvt4j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091
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



On 11/27/24 05:37, Venkatesh Yadav Abbarapu wrote:
> Add OPTEE support for versal2 platform.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/amd_versal2_virt_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 08e607700c..b4aebf3e9f 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -130,6 +130,8 @@ CONFIG_CADENCE_QSPI=y
>   CONFIG_CADENCE_OSPI_VERSAL=y
>   CONFIG_ZYNQ_SPI=y
>   CONFIG_ZYNQMP_GQSPI=y
> +CONFIG_TEE=y
> +CONFIG_OPTEE=y
>   CONFIG_TPM2_TIS_SPI=y
>   CONFIG_USB=y
>   CONFIG_DM_USB_GADGET=y
> @@ -151,3 +153,4 @@ CONFIG_VIRTIO_MMIO=y
>   CONFIG_VIRTIO_NET=y
>   CONFIG_VIRTIO_BLK=y
>   CONFIG_TPM=y
> +# CONFIG_OPTEE_LIB is not set

Applied.
M
