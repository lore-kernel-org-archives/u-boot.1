Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4752AC369CB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 11:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAB5382E25;
	Fri, 18 Apr 2025 13:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VdiYpx++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63F5783118; Fri, 18 Apr 2025 13:28:29 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A4F82A31
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 13:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SI+y13+PQ77EVn5vv4fSBVuxtbG7d2za+EoQrTYhNUaknk35BsQxhlcVdDA8pfxCIoJ0fTG2GVNAbRWhaWEX8OTcTjPxRVXI6/YG8OSSxM6UYCcLsVJZclSK0het4KgaYOqu90abUSeSkWr3zip0cR7dpiLMncjodXNXHApqnOJxee+FpzHTr18GeN4JuBjhLVXK2j4kb1HbiREHA3Huvgv8xV9IBoXyDXWCrHtEQP/W/KTWbLwHFL4LYPJADEwx+M7ONxKz+TzLEPvXDuJaZyWJG38fBbK7nniLEIgmL6cPhcb1pHC+eUnc9v+PNnE4zz6eQOeDQuC3phBPqxwXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z20gIT4qLtFSoMDNT6zkPVxE7+YCFdhXeN/JR6bmWhY=;
 b=PZatVEoRMiK9/ySnDwpX9GinRHBTUCwBOZbLxRnI5Fo6UvZif7/RrJExbe/R8tjp9inf3xRF4mzEyxQhy40j6GDy1DzL/iYCGSXvHrxJU356BAYUn1CF1wAxeeuDksy7FVGDxGCOyCgA7pWQyL+/DkcKqxM0Mk9UGjGij8ZAESlYtDnviysbiT8/3F01ycwhonYO09wtpdDUJ5njwsddWJ3LLcu6ghNMOA6AJ3ATRKb+Dyv/Ctt+iaLe2kvcP+2Uzvqyjb6lDfwDeb2lTzVDWz/kuafDBZK83h4AnBQSbsG73nlVZ+VQX60akC0HqPZXpttVgARAjq5BMHvSqRU1wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z20gIT4qLtFSoMDNT6zkPVxE7+YCFdhXeN/JR6bmWhY=;
 b=VdiYpx++15qijxKxuFX8eg1o4lST0woYXxmTN6zl1V2Cs7KScJUCdF3wcj/62Mh+zbVB6QR3RNmR0pWxgnwJlF5VQjLBE7ujevGTPRDZoaSZ4AGAKTa82ulW6xOiG8G6/JtYm+RmGoO5083njSu9ah2fticrdoFw34ZF+hqoncs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VI0PR04MB10542.eurprd04.prod.outlook.com (2603:10a6:800:265::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 18 Apr
 2025 11:28:25 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%6]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 11:28:25 +0000
Message-ID: <b7ffc468-1970-4eba-85e1-47aaced0161a@cherry.de>
Date: Fri, 18 Apr 2025 13:28:23 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 2/3] sunxi: add "fake" FEL pin support
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Yixun Lan <dlan@gentoo.org>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
References: <20250417000539.3709-1-andre.przywara@arm.com>
 <20250417000539.3709-3-andre.przywara@arm.com>
Content-Language: en-US
In-Reply-To: <20250417000539.3709-3-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::14) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VI0PR04MB10542:EE_
X-MS-Office365-Filtering-Correlation-Id: 69aa8276-df60-4f3f-7eac-08dd7e6c2238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUx1MmZaV1ZwM1RzVGNqN3plWkhiUm1rV0ticm1WUjl3S2J0L1RyOWNTSmdL?=
 =?utf-8?B?eTYra3FVaWZHRmcrcW9lWWlYdkdWTTRENnM4ZmtlbTdaa1E2amtDRkdoQWZq?=
 =?utf-8?B?YlJCNzNpNXpqWXl0RlVFSUxaQ2dwNkhWNmhudjVOUTBwaVVqQVdlQ2x2SWhF?=
 =?utf-8?B?cFBXM2VOdWNkMUo5bGRNeU5uTHlqOThRb3dkaVNwOW1YQzdpdHFURElFMnlD?=
 =?utf-8?B?VE9XL3lUOFR2OG5FaGJ4SHZqUDlrY1NzelgxeHMzck1DMURhMFNsU3pLa2Z5?=
 =?utf-8?B?RVZhakkwQVJzOUpuQ2RWcmRsYXJnY3RXK1JpdHAwOVAzelk5SzVHSUdwNlYy?=
 =?utf-8?B?azIwaFFUSzdhNkRXZjdmdDBwK2xiZEk4YTNsdlUwT3ZCUEtPR2VCUUhNLzFp?=
 =?utf-8?B?Ny9BSGRoZWg1YWd5TlFKclpMMVZGK3VWYUdCbkppSHlrRTA1aXEyQnFWd0NK?=
 =?utf-8?B?N3o5aVpaN3V0emJVOEllR29EVElLN0VabDAyZU9zZHhsdU43WEpUOUF2NlFS?=
 =?utf-8?B?L1BZVTkyTWxCdVVXalJNbXJiMjUyWjdUaWVjNWhYL2I2R1o1eUgxeUprcnBP?=
 =?utf-8?B?MjBSaHVjMElFcXVYay9NUmFibWwwQXJUNzB3eUNIVXg3c1JSQkFReE9RbjBj?=
 =?utf-8?B?dGhwM25GMVVwdVpDQm11RG8rUkJDUlB5Z1plMk9QMGtkcjRQYjNyenprMy82?=
 =?utf-8?B?b3pxOHJSSGZYTVdYaWEzL0hzK3VuQkZrUzE3eWJQeGZhbWY5UVZKMm1rQXJU?=
 =?utf-8?B?QWRndktES1BMVmdxdjBJVGkwdHBwYnNhcXlnOUVvRGt5aTlxWU1UUzhsTVNl?=
 =?utf-8?B?VG8yUmVhK1JhNlZFL2pkcWtUN2w5bEVYQ3JJVnpMMWFPNUdFVTNYQ2dBMHdB?=
 =?utf-8?B?eW1RM25nOXlxZkFYRWtxQk5nb1BNKzRRVmpLeXpXYXhDZEFTa3h3Mkc4RTZY?=
 =?utf-8?B?dy9PYlMwc1NyRHI3MW8vNGpwMmVnRTh6UjlpS2JuNU5hVGUxV0VOVW5LUEpF?=
 =?utf-8?B?RlFGME9NaGNDOHlGSG5QcWRHVWpBb0NjdElJeFZ2Yno0bStoUllYcjB6c01M?=
 =?utf-8?B?MzRtam9Od0xFanVhcTJleTJyN3dpdnU2Tis2Sy9mamxuelIwdkZ4MGR5V1lw?=
 =?utf-8?B?L1NnQ3NxZitpNGRtM0JDcWRLdGpUVy85YWtkVCt0bndBdGZncHlNUUp1SUp1?=
 =?utf-8?B?ZGRGSFFjNjlrb0ZqNzZWUUgwN0VGQWNyRTVsSktQR2JscFN3VjE3Qnp1S3lF?=
 =?utf-8?B?MDc4VTlwWlJnNHRXSm5QaFY1MWVBUElHK1d4b2ZtUmRPdlpOSkdkOUZSdXdO?=
 =?utf-8?B?ZzVuTlY2aUpOVGpsNy9RNmVIZUdsTGhQRmVnVE8yZkIrNFVYbUN1Um5COXM1?=
 =?utf-8?B?YnlTbjlVVW8zcFhoclZGcTZHTzJYUXcySEVzSnFXc0NBTWl0Q3lCK3Q1RllH?=
 =?utf-8?B?UEZsbE41SldSVGpCWHMxVDFMVVNqT25JRG1WNDlpdDZxck1OK1RWcUJnZ29v?=
 =?utf-8?B?cXZSWE5VTU1SZGtzUDg5N3FwQ1ZQdGp3SnVHeVptUmZTUGVUelhIT3FFLzRK?=
 =?utf-8?B?RXg3QWt2QzFKeDZJdWF1Vm1qQmRxclpkcXZwVVU1V09KWW8yS0hPOFhjbS9k?=
 =?utf-8?B?bzJLWE1wOXA4SlpKemNWK0lLNEdPUWRmdnREbFdKc2l5aU5yelRmTURJTlFX?=
 =?utf-8?B?c09LQllKYlV5WTFCNmJRWUJZeFk0N3dWekd5Mmx1N2tWdHA2NFBZMmZiS2Jt?=
 =?utf-8?B?cjIrZ2tMSmc4NEZjem1rOVlTWXI1RUQ3d05CcG1tU3ZxZFRySHFGeU40eDJO?=
 =?utf-8?B?QnluS0NrbUZhek5YMkc4eXd4UCswS2FRMUdYSUxBN2NVeHc2VE1nMS8xTFRP?=
 =?utf-8?B?bDVodmVQZFlTaHdoUUFqU2tOUVlLSDJOTU95MmdZajY0My9La1B6Unl5SWla?=
 =?utf-8?Q?rsHogR4FovI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTRsU2s2N1ZnQmMvYjZCd29DTjh4bUpjTXgzanltcU4ydmRWMCtRcmYwM05G?=
 =?utf-8?B?eWtuMzBzNjhNOVJSd2g4blM0cDVMYmNBakRmK0o0MHNxZHcrVHE0UUd2dHpt?=
 =?utf-8?B?ZGVqUVBhSGd1dmpkNUVEZnZlUWxMZGR3UlgyOHFVYkNDU2F2Y2phV2JFTzQv?=
 =?utf-8?B?UXU0d24zL1hBQmtVTU55N2JTRnFWWWVKdXFIUzAvL05UWGIzYlcxdHV3a3ZT?=
 =?utf-8?B?Y3BiOHI5SHNPeE9qZWRaWXBQazU4RkZPQ3hac3pJcmNWQkFtWHpORE5hanlz?=
 =?utf-8?B?OHZDK21GZmprUXkyRGpzUkZjaGE4NnN1dG0xTUhlbkxXK1VCWlMzaFIzWFls?=
 =?utf-8?B?ak1USWtNYnI1Mm85SWFhRklIMkU3aFZBUlhma0xwNndFK2RNSEJ4d0V0aVdn?=
 =?utf-8?B?RVc1YWJueTA3U05INnR4OVpqZGI5Z3BscmpBZUt1OXVOTmxuaU1DRzd6NnZz?=
 =?utf-8?B?YnN2OURCVktIK3lxMTN6TTZLMDdXTmljZUhGOWpXSU9RNUJmWTV6R0dlZ0c0?=
 =?utf-8?B?RzF4Uk9ldDFseW1HaTh2NWJKVkNyVHp1WHNrS2VPMTNvTjlKeEZRS3dBejJs?=
 =?utf-8?B?MnVhSnRLcnNzZXNySUR3dVV0djNHOVEvYjNJY2d3R1FuWVdrdDA5YUd6SjNO?=
 =?utf-8?B?SXN5eFNUVk8xZHB0YkU2K0l5T2xwTGp0cnJQcXdwT2NSN1hFVVBSM2Z3VkRM?=
 =?utf-8?B?dU9pU3JsTzdZbkhjZG45SHozNlNIcVd5eTNoNk1tNjl4QUNGUFNkVWEvSyt4?=
 =?utf-8?B?SUVOd3pQYjh1Nksvc2RjZ1ZRYkNzaDcxbXZVYXVLYTgxbm1kMzhTak8vQnV0?=
 =?utf-8?B?eWp2Y0hHb3VFc1VoOEg0OENWT1NwaGJIWnVGTW0wSm5OU1hpcDlvbkhLNll5?=
 =?utf-8?B?UUxLWTRYbTVqNHFkaTZyd2IvRjIzYnhJbkwyZEJhY1RkQ1dubm42MzVGMkJJ?=
 =?utf-8?B?UlRtdmo5Wk9rdUFIR0JhQm1xa1BkdjlhREdXblFLa0RtWGYxc3ZlaXhMQU8v?=
 =?utf-8?B?dUxoOUZhYVAzZHJtbDNKVFNMWUhsNHFUaUltai9pc2d6c0I5ZG81MmFZK1lX?=
 =?utf-8?B?c0JrcUpxU0lJTzFXNVU1L0Z1K0JCcDNsVDhVcG11eGJYcWZzbVYzZXV4UTBJ?=
 =?utf-8?B?ODQ4Z2hkWHU1dlpPUzFnVS9YMTdIMTJ3WXlsaXVzM2hUZ0dySHNvQkpGNjlH?=
 =?utf-8?B?MUQ3YUswV25sMXRnbVhISGNKb1R6emJKdmJPZUxHNytNbE5PbDRLcStBUitw?=
 =?utf-8?B?V0Q0QWlJNUpYNFpBRDY1UTEyTk52OWswMEJzeDdOSGpNN3V0RjFwZGFjamsx?=
 =?utf-8?B?RVAzME9PQ0JSSlRYVFM0cDNaMkRxOG5TN0FCZTJ4dGRheEVnVTZNNFk4OCtt?=
 =?utf-8?B?ZUcvTzAwdHZkYmF3Y1pNWnRmS2M5OXRwNm9tL1h6V0w2cFlzaHFWVFUvcFBB?=
 =?utf-8?B?L2lGZFhqTmR4bGpSaXRDT1BNbEJnaE9DcTR5ZDNjYy8wV29Sek9lYkpZK0FT?=
 =?utf-8?B?bHQyOVJLUGFvR1ZiUHhicTZOV3p3eXBnSGEraEhYME5PNGlrNERwMFRweVdr?=
 =?utf-8?B?ZTFKZzJqUER6S0x0Rzc2ZGM0QkJMajhQbURETHBKZG9aVkdkZWFVUmVCcEoz?=
 =?utf-8?B?TDZocjNhaisxOTRiKy9xOWVsd3dKNW5jTGU2TnR6bk05KzJ1NkFsYS90SDN3?=
 =?utf-8?B?VGJ1MDVwRFNzYmFlWDNzd2RlZGplb3kvUWs4QkhsN0pIcm41VE1zMFZBYmVE?=
 =?utf-8?B?UU1uZDl5Zisrb09VbVM2VTZrZi9kUW92N2YvWmprNGhrQXIrbnhJc0IydmpH?=
 =?utf-8?B?NXkwa0s1SXRPVUVUTXdLNVNaR1RPdGI5dkJ6cXF1Z1hwd3JJOHoyZXFaaXZV?=
 =?utf-8?B?SVQvYjN2TFJlbzFWOVBjNTFKM21rdjlyUjhnTTQ2b3hrUG9obWhrSFVYUFJ6?=
 =?utf-8?B?cWN4Yjd1YlNwRGxHbWoyVmhrbGJBRmdwM2gzTlY0TFU0NHpYdWsvdzhMZXFV?=
 =?utf-8?B?aU9nUEZ1RXdSVlhnM2dvdlBxbFZaMkd6NGI1QVVMSmxuc0tyeFZMSTMyWGNv?=
 =?utf-8?B?b1dBMzBJNWhoNjhKOXE1V3pINnJBR1lPNXZWcFEyWHVBN0R5d09TSUd6TERE?=
 =?utf-8?B?WWdCQ0ZPbXN4NllpNjFJdERCQXhaYWp0Yk1vMUREVy9ScC9EY3dLT3lXYmQw?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 69aa8276-df60-4f3f-7eac-08dd7e6c2238
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 11:28:25.5648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZJ/Tax4qLqjuPnE/6sZhEy8TlVPxXkeeAT7EJxobeDL4ieLUEUaX107GiqvcYQmB1m7ReDVEUQqfQOhEnRAwgJorBJMHMRRduASCxfp1xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10542
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

Hi Andre,

On 4/17/25 2:05 AM, Andre Przywara wrote:
> Some boards with Allwinner SoCs feature a "FEL" key, sometimes also
> labelled "uboot", which triggers the BootROM FEL mode, when pressed upon
> power-on or reset. This allows to access the SoC's memory via USB OTG,
> and to upload and execute code. There is a tool to upload our U-Boot image
> and immediately boot it, when the SoC is in FEL mode.
> 
> To mimic this convenient behaviour on boards without such a dedicated key,
> we can query a GPIO pin very early in the SPL boot, then trigger the
> BootROM FEL routine.  There has not been much of a SoC or board setup at
> this point, so we enter the BROM in a rather pristine state still. On
> 64-bit SoCs the required AArch32 reset guarantees a clean CPU state anyway.
> 
> Any GPIO can be used for that, the signal is expected to be active low,
> consequently we enable the pull-up resistors for that pin. A board (or a
> user) is expected to specify the GPIO name using the
> CONFIG_SUNXI_FAKE_FEL_PIN Kconfig variable. When this variable is not set,
> the compiler will optimise away the call.
> 
> Call the code first thing in board_init_f(), which is the first sunxi
> specific C routine.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   arch/arm/mach-sunxi/Kconfig | 10 ++++++++++
>   arch/arm/mach-sunxi/board.c | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 41 insertions(+)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index ab432390d3c..f1cfdb548bc 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -825,6 +825,16 @@ config USB3_VBUS_PIN
>   	---help---
>   	See USB1_VBUS_PIN help text.
>   
> +config SUNXI_FAKE_FEL_PIN
> +	string "fake FEL GPIO pin"
> +	default ""
> +	---help---
> +	Define a GPIO that shall force entering FEL mode when a button
> +	connected to this pin is pressed at boot time. This must be an
> +	active low signal, the internal pull-up resistors are activated.
> +	This takes a string in the format understood by sunxi_name_to_gpio,
> +	e.g. PH1 for pin 1 of port H.
> +

Why not use the DT for that? Then you wouldn't even need to assume the 
polarity of the signal or whether pull-up/downs need to be activated, etc.

You can have the property in the -u-boot.dtsi then if you want?

While the FEL button on the X96 is "fake", it does what it says, just in 
software, maybe that is close enough to "hardware definition" which 
would make it suitable for the DT (well, we also store binman nodes in 
the DT, which aren't strictly speaking hardware definition either :) ).

Cheers,
Quentin
