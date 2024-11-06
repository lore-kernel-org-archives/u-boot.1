Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1E7D29FB8
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 08:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB87A88DB6;
	Wed,  6 Nov 2024 09:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DTGk2W5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA91C8900E; Wed,  6 Nov 2024 09:02:14 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 834E188C4A
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 09:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaxZure/ETvbqBR5zluLUAVeT0sNUTSeJouk7m0/4xpHWwuG4a5nhsGrtYIJELlPu+/PVqarITbco5ADqrECOQ0XCZMdiQbJcmaWWzUa+CiWE3qck4VxjWKyvc93qLuSuge7tuA/+RnrX1KAsqEjL65JblDfiew1uoX9cbc++eO2kuAQaaOlbnuo4MAD44usVd8sEO9phMgbHzUg+rd2EH3kuAaAmnqxqr+mPZp6lnyI67mOZIdre4P9KRrJHZtPuEnYxa/m154X2oISn5Yh5sdjsbbjK9ZF8cjAKnGlX6SJo08nmVnrE9XVqLhoXNO1dKHkPBu06skzKwIcfnEUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OgndMRL9/7kY39vTrug0ZRC8Kt8t1ZBXsijDfw9foQ=;
 b=HA/74xVr166kC+KF1p8u3NPXtF6/11jKoTR6hqZSVe8GA/t7NsAQ2Hjt8xIaz2HkqE2LRFGPVG0MD+F4YnFk9euvnd7P92xGrXtl+uQxxfjF761JvtaGIiehabqY83uvwXemZPXAxUyDDH0ZJ7oH+bAm/FlQK69OwOwgpK2fz/gvFRKMZ8MJUD1408njV4i5wU29TX2TCxvyKbkuyCJr4PDOmP6XJ7edlODHkJCJ6zsrcTxfHIbsfg1HzUsQZTp1C4CftyffN8hZcx2xjuKencT7ts0hp2cTK8Yv+AMPrbhgTOfbc4ZRRJP+2KR999rZRa5CYeyULktV1zCImI5/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OgndMRL9/7kY39vTrug0ZRC8Kt8t1ZBXsijDfw9foQ=;
 b=DTGk2W5k5puBILNB35IdhUzLnb69rWJJAb/Wk8P+irrfDHaUxDughHovN0ICidYkYQ3cOCfEvBIBv8shNWJrSWSV1VFL2Ir6i8Ac8ZKeRNIiFNpQO/Wpif1Pz8cKyohQeVxJuOxP9A/aRKGynRmC9si6+QbACm5cpSKeBhDNUjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 08:02:07 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 08:02:07 +0000
Message-ID: <ec6e3701-aed2-4e6f-acc5-6cdf0db22bc9@amd.com>
Date: Wed, 6 Nov 2024 09:01:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Configure SoC RTC on SOM
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Srinivas Goud <srinivas.goud@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Alvin <alvin.paulp@amd.com>, Prasad Kummari <prasad.kummari@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vishal Patel <vishal.patel@amd.com>
References: <9b684faeec85381b9b8fe796aaebc2ee79f17b8e.1729663761.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <9b684faeec85381b9b8fe796aaebc2ee79f17b8e.1729663761.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0186.eurprd09.prod.outlook.com
 (2603:10a6:800:120::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: ce89f79c-73e9-4486-cd6a-08dcfe394ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0xTeGFsUUd5U1NDUUR1WHNuS3R0OXEzdm43dW1zbzlrdnMvYi9XZStEYWp1?=
 =?utf-8?B?Vk9hdVo2MmZnMHY1MGVhL2tYWjBhaWo3ZlRrTExueW1qRjIyN0RVOGQwT1RC?=
 =?utf-8?B?WGY2aEhuSlpPeWxJUGpheUc2QWhBdDBPbVZwYWNZQ2diNDFZbWh3RWtiTkdm?=
 =?utf-8?B?b01teE5kbFRZS3lLRytUVWd2S3NKenVOZCsrQm5DM2NuUDJiUEJCZ1NEUkZU?=
 =?utf-8?B?TnhyRy9UTzZyS29tcjBXQlU0cFdGdlZhUXJ1bmZYbkNuTUttVktibGVMUDRm?=
 =?utf-8?B?c2VYSGVhSnplWnJVSGZBL3c1Y2N3NC9RU0NLdCswNE1uaFhubzFLZjQ1MktE?=
 =?utf-8?B?clhrTE9qRnJSYnhQU3BSWGc1ZEI4MUwwZWMrUXUwVGQ5N0thOXlkM2x2dElV?=
 =?utf-8?B?TFhsWjZNRjcrWSs0RjlIUEFNaVIyL2FsQTM2TDUwa3c4WVhHQmtMTExtVnhY?=
 =?utf-8?B?TndiMVJUNmVEZFdnQTVzQlh2c1B3d1JuN2REcHRiMDBEL2tReC9uT0YwWjVR?=
 =?utf-8?B?clh0WTVzRjJ1VDN6bXB0b3ZrdUR6Q0xBSS9BcmVUWnU5emdDNWxuNk1IMy9H?=
 =?utf-8?B?Z1ZYZFU2NjVXWHRZOCtFMkUzcWE1cFhya21PTGVnb0FDY3o4ZG5GSERvUTlU?=
 =?utf-8?B?bjVDdGZXYkszWkJXREJTT1RWMGJ6czl6RjhUWU9lem9HblJRenJmVm5UQWtN?=
 =?utf-8?B?T0RvazhKcWYwWEpMbStNR3VUaTVOazBENE8zMnVUdk9wdVlPQmVweXhJSXV3?=
 =?utf-8?B?NUo2U2NBL0RzSnU1WW5lWFkrUFZhZUhnSXBvdk1GaW4zaUJwNnpqODYrYmRh?=
 =?utf-8?B?SHh4QzNIZUs0VUk3R3c1VWtxcjJxenMxaHNWWm1pY1E0czI2RDRBTkp6VUV0?=
 =?utf-8?B?YURFWjVhZDR5anlwUmZUU0ZMME1TMFBiK3kzbEU2ejRzWXhhRmJheGZZMVR1?=
 =?utf-8?B?VjNmUm04TnZhd1BBVnBvNlBkOXVJYm1XK1Zva1A4d1I2UkpveUZYTCt0TVVM?=
 =?utf-8?B?RGtUN3hVNS9ZZG9weDNQR2FQQzNOL3J3TTdGbngwQ1dhOUVyZ3Q0ekk5bUlK?=
 =?utf-8?B?cnFSSmhPaUROUVpXQTBQMGdWaUorSlhkNVM0QjIzZ3NYbzFqUUpyTWlUQkI1?=
 =?utf-8?B?TXdKN043bHpkVVNFdGtZdzZydHhpQStmVUN1QnNaaWY4dEpBRVVZbTdkR2J1?=
 =?utf-8?B?WTJ6K0dGUkF3QTljcTBGNDZ5UkZBbU1vbVJWdHlzcCt5NG1UTVpGWlFVR2Jj?=
 =?utf-8?B?cDBiSWJBQWp2RFRxNEJVQS8raXJ2QnVLQTFGcTE3ZnlsRHZpTERqYmM5MmNO?=
 =?utf-8?B?VU8xSTYzYklUU0w2dCtFVHNTbUx0MktNT2IxSllodHBmM3pRcDlhUkg4L3p2?=
 =?utf-8?B?VG9pSlhkSTNtTTJYTDBQQjI3Zkc3T3o4ZnVwZ21PTXVxNjdncStGN2dNTWVG?=
 =?utf-8?B?ckJESDZrQ25kblloNUVnWjhNeXRTMkZkMkNlYkVmVk9nMC9WNWJoaTJZb0l4?=
 =?utf-8?B?d21IVkF0LzFVdjN1dElkR0diSndmSmhBMGZlK1FZNXVhMGhpN1BuZUNvRE5C?=
 =?utf-8?B?ckR6K2ZlSjFERkd5aDRSTXd1V2RueTFPTS9HVlhaS0tkN3RBeENoWFAwR1hv?=
 =?utf-8?B?WWJwd2RyMjBzVnNjeE9mTVR3N3gvd1dvVnZHS29rQ0xzcjdkZGp0SHNXRElt?=
 =?utf-8?B?UVUxM3JxQzZOUHR2clEwTjF0RFBNRFNQbWVNMjA3eHkzUW8wQktRc1pyNW5s?=
 =?utf-8?Q?o8/hilELItFmkNOiDb8328eYVJnm5wBF5iMpcUI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUZWMTVDY1J6alM2cjRxOWtBbktlV3hieXp2VTR1TnQzeVlRRnlHcXR3UFY5?=
 =?utf-8?B?QnhZNlBlSHFyVm1MeFZKb2VrTGN0dzJDeG5jdFFYMzRCY25Da3BTNW96aUI3?=
 =?utf-8?B?dm5JWEUvYjU0VUJvWUJLN0VFTGdIODJWMC91bUhCZWlxMkkzYXNPbkJmeC84?=
 =?utf-8?B?SlE5SXEreDBXZXRhME1tV0xaOGpkTDhqak1tTWJMem1VQzhIMnQvTDkrTU9a?=
 =?utf-8?B?MG1vTGZmNU5JUzdsZHpzblFhdUQ4NUZoYytUaHlmYjJockRZZm9JelVXeDFR?=
 =?utf-8?B?ZG4yZ1RCemh6TlpqSUJ5S2NxRHN0cWRvQytlYncwNTVvOEEzMVBkQ0dMSjd0?=
 =?utf-8?B?U0U1aEpZRXZsV0dXYUt6UjE3M1Q5cmJiL1FPek14eTVPTmdoR256M0FOb0RX?=
 =?utf-8?B?WUF4WFFCNWVQRGRTRUFXVXRmWUhBZ0ZNeTNEK2xKbW80UnZaaSt4Ni9NL0Jz?=
 =?utf-8?B?UHVxaFlJM1dMN0tabGFDNEhPTVhTajdsV2FuV0FNRGJYcGg5bFpLWk15YkNl?=
 =?utf-8?B?WU81MFAwUUpxMVdBTFdxQ24vdmtERExwOUhlbE4xTmVyVGNSNzFVVkFxM1ZO?=
 =?utf-8?B?UzNvRWtEcHVRZUc4RkMwZWJ4dmJnM2ZZYzhvU0JwVEIzd2o3NDVRc1BnTFFK?=
 =?utf-8?B?UVU4VnJ2MllKNzMyd0lGTWtaaFVuWHVjQmpBWjdZYlRqTklJUnVTZHkzbi9Z?=
 =?utf-8?B?ZWIrN2VXcTFiUGt4cmRacmJMcTkycytydmppQk9LOHM3UzB0WDJvdEx1WW9W?=
 =?utf-8?B?ZlNpeSs0K3RDdnNJSVBKRkl4eXF3cmVhK05NMHVpNlY5TTJ6WkhXb0Y5NUJT?=
 =?utf-8?B?aDZJbFg5VWI2SU4zWjk1RFcwbEhDdVFyL2QreTZaV0pkcU5hK0JiVytLcjRX?=
 =?utf-8?B?bGs1ai9SY1VuWlBhZHFEcGh2VWMwK3MxSkcyQnJjaVV4b2V1czRobnViUmNj?=
 =?utf-8?B?SCtQOHNIM29KNno0MC9OMXNuNTEydkxVaVZ1TE94d0VQbXAvcmxvMVRLM04z?=
 =?utf-8?B?OTZEMGpucWw0R29tcjl6dHFMM3VTNm5vWkN2bzRYdlVoUm9hL2hFRGl1djRH?=
 =?utf-8?B?SmNSUDBOUGhsY1pMeTJqWlp3VllQMENKTUd1aGJYdUVpWUphdkdtMUdRaVV0?=
 =?utf-8?B?YU8wemoxclJwOUhGRW52M0tRTXVFZWlwWVBMZGlmVzM0OE1oMTB6NzlQYzFZ?=
 =?utf-8?B?cXBtUERhK0FQai9YSDNBZ1Q3TVRXb0FWRDBocHVka0ZOQzB1em8wQ1dXeC96?=
 =?utf-8?B?LzIvenQ5U3BWT0VhdFFMRG5VZ0FKY1lkR3VPaXVmOVkxTnlQNGU0WmpXRVlq?=
 =?utf-8?B?cy9PRGFTaU1HeS9vOHIwNFNydmc3NWozY3JYOG84V2pCSXRHRiszdW1ZWWs5?=
 =?utf-8?B?OVlkeUlQaDJ2ZFg5UEluejVYb2U4N253MmFSd3pqdkprSXVoTDlOZk5KZGw1?=
 =?utf-8?B?cTRvR2tJdU90U3U0N3JSdDdaRWhYenFQckFUWmtXNHN4NVdrMXRHMGRCeGZN?=
 =?utf-8?B?YW5tNWFZSlRUU0pwT2JORDJtczVhRFp3QkEyaFhOc0w1ZThHVUdacitKZkZB?=
 =?utf-8?B?ZS9iTHZCYnpoQTJuS1lGRzVJbmQ1RkJtbmpkcWU5NmMraVd2QTNRRDhiZE5o?=
 =?utf-8?B?MUk1NGcydVI3YVNOZDBiZWxIL3dpbmh3ZkdUS3l6TTlyemN4WG9nbE9RZ0E5?=
 =?utf-8?B?Tm42S2UwaFNLY1FzZU9UR29zd2ozSVlwRVU5L0dla2NWNDk5R0JtU0FuV1Fq?=
 =?utf-8?B?bThIUWxGYnFsUTh0Y0JGMElSeTBhVThDUXlqdGFGd1JHemUyQmY2bEp0QkhI?=
 =?utf-8?B?OHpRZS9HT3o4L1VVYTJVdVJWdWgrQVFYaG9aNzg4OXQxd1dFQ0JCNU1QdjRm?=
 =?utf-8?B?MXhpMGpkYWRnajY1ZVhxbGpEaldjNEJMTkFSV1RSVWdMQkxCMDVBNHN1TmxB?=
 =?utf-8?B?bkNxc0FlRlZQNGl6SmQrRnRxU1NwZDlyUVEwODF1Y3NqZytvRVZKRXpkRVBk?=
 =?utf-8?B?RXhKQ1B3L3NJVkZzWWZ2WU9tRXI5T1JKQmN5czFLek4vZHZXWjFLSmpaSGRN?=
 =?utf-8?B?dFBFR2pNRUpIOGxPUUg3VHVuNTlTdGQ0Qk0rM2xjNHNZQm5QNkwzTk9LbHJx?=
 =?utf-8?Q?KET8XCfSYZSwb7Ynngfpyfv4i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce89f79c-73e9-4486-cd6a-08dcfe394ebb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 08:02:07.0019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXtgEeARbODVJxU0xJsAVOfFTs6eFMM/PGl0eiwNhoTgp9yI18unoNtoaxD0Lq7W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
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



On 10/23/24 08:09, Michal Simek wrote:
> Use RTC available in HW on Kria SOM without using emulation that's why
> configure it properly and disable emulated one.
> Power on reset value of RTC Calibration register without battery backup is
> not matching with crystal frequency which leads to RTC time drift. That's
> why write CALIB_WRITE register with crystal frequency (0x7FFF). There is
> also an option to write zero so that Linux will set default value (0x7FFF)
> in driver probe but calibration 0 is not permited by DT schema.
> 
> Co-developed-by: Srinivas Goud <srinivas.goud@amd.com>
> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sm-k26-revA.dts  | 1 +
>   configs/xilinx_zynqmp_kria_defconfig | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)

Applied.
M
