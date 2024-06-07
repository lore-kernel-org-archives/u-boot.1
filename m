Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA635C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 08:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24B338824C;
	Fri,  7 Jun 2024 10:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mwaUE+cv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 753DF88452; Fri,  7 Jun 2024 10:43:23 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::70d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5780688231
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 10:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZT3qPeLdWAvyDxlZywNTavMeND9JpaaxeL7sDjpsQc6TY7eQ14+teuosGt9a0c9Lg58Oej0vBzPKHAIWAXx6dCLXbyvlcmnugdn4+G667SRG+7EmJ1LWGYdoyTZl51wn16VxOcDn5OfhAoRMR8qZ5AD7KAKsEQlsoN56GFSx1FVRDK3GBuVI+nE87Puvq++IgyLU0qVHdxMteL1pfxQ14MmkO3uL5YiL5yzWT8B/yD6CAirtx/cCrvP9l8L8x2KxyWqA1BerOuCYZ6ZCUQTvcYKjGauJUa2rjYRThQnUcgIsv0hlfHLmmJcngrinlAc3sTlj1f4rlj0xd8ISI4APA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzsifR1mSIyWhrHq7rKUeuDv+G5+854L4zNdOz0JrUU=;
 b=jGC7Z7nOnikYHVvpkdZEYAnLyfS5oyRSIaOyzJhQC6Yq411J+w3n0r0lGo+vTbMExxSrk6y9d4Fe8e+BdrGHnLKHIb51ddc3gjCwyCgbOf2t8XoQlFwz5cYImVXVJEACyly1i0PUKc7YckiPwvCSLut25hE8Ielx2ReT5IQ9kxs4HEjo5vEC5R9weK1WJC8TD9I1S0MG+zq8YuqvGX9g/xmiBWNK21s1NQ7ePkoMIw1gJ7MXCQdk5DEgKrGVo3eM3ne1S9PGN3i9Px9k9fr6N+mdh5wWBHpllJG/v6FmD69IU/xG1dOuVfmGxr+rSJTQj8tPvOgthDElHJH1mzTNlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzsifR1mSIyWhrHq7rKUeuDv+G5+854L4zNdOz0JrUU=;
 b=mwaUE+cvpux0weFPC9uWtabeuhkEDXxmOuYXgTh1CzdFiI9yzZ/AbtG7nMo5hQSgz+eXZZw5icbOgoVMI+5QjR7C6OF+9bxk6dq96M3XfENh8CYPGwB3WGCvMnzT/1NEhRDnqmzSzHGhpRNAV9mEf4vTf0s/1I5Jm14NvGIX51Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by VI1PR04MB9932.eurprd04.prod.outlook.com (2603:10a6:800:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 08:43:17 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 08:43:17 +0000
Message-ID: <b1c17943-0bc1-49fa-a5f4-98025ff2dbaf@cherry.de>
Date: Fri, 7 Jun 2024 10:43:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] led: status_led: add new activity LED config and
 functions
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Stefan Bosch <stefan_b@posteo.net>, Eugene Uriev <eugeneuriev@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
References: <20240606143024.20024-1-ansuelsmth@gmail.com>
 <20240606143024.20024-5-ansuelsmth@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240606143024.20024-5-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::20) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|VI1PR04MB9932:EE_
X-MS-Office365-Filtering-Correlation-Id: 6957419c-7e07-4ba3-a907-08dc86cde09d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|7416005|366007|921011; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlpXaTFsTmlOanZOSnBDOENUd3JYQSsyMytsdGtnaDllN3dSUWlMQXF6b1ZX?=
 =?utf-8?B?T0k4dU9hNHMzNEsvTzVBV1lXN0U2OWVpTW1ZZ1B6QkNCVzEzYmZETFdXaGgr?=
 =?utf-8?B?clBpLzRGRnREZzM5bGFaRmV4U0lpRmJYT2kwVHNBZStWdlRWc1ZlWUc1Uzd4?=
 =?utf-8?B?ampvNDlzamhhcC84aWU0UUdPWHlZTGR6S2xYa3FXdmVvTUllVlVub0tKOWhp?=
 =?utf-8?B?S0JnOGo3dTY2YXNxaG5qZEI2aEh6MUw1UnhHS1N3Y01vTmZac3JrNjREcnhT?=
 =?utf-8?B?YlNNTGpSaGp0dHo1aFBZVVQzQlplcFZWc0ZZRzI1eEh3ajB1bzF5YUhDRURO?=
 =?utf-8?B?WGZvdis2Um9FaWZYVmJMc2VMSGNmeWd1VWJuZ0ptUmszMFdUSnpxSUFrM3BR?=
 =?utf-8?B?U3c1eGVqcm02aFhGZFhIQ2FMdFVUSzN1emQvb1gveUZOSE8wZTcxM2habEZp?=
 =?utf-8?B?K1luOUtseks0SWNoVm9WbnpzZ0h5V2tFRzZkMFM0MjZxY3NWWU5Oc3VyWDM1?=
 =?utf-8?B?cGZBaFVxdjl2cHFXaTlYaXdjWVZnVThTdEhHK0taYzZSWFRNVG5OTlVCTVBY?=
 =?utf-8?B?enBCMXZvZzJ2TTNzWDJ3OEZ5VkxDQmFFMzIvM2NpZnY4UDh3Z1JGY21hcWxq?=
 =?utf-8?B?U3JUdC9PRWlrMGhENTVZczliT2xSZkEwTHFJMDN0T09Zd2RyTVVrM3ppcUxv?=
 =?utf-8?B?dDRBNDJHSVhNb1RzaDhSaTZ4UHBlK3k4RlUrSjUrOWNMRXNyWEw2a3NmRnE2?=
 =?utf-8?B?R3I2UkdwL3dUS0JmTTdSVVRaWnJMUXNocTYvNmNXN2dLMkRsT0t3elZVMnNm?=
 =?utf-8?B?bU9CYUpsSEJJMDZWbElITDN0dFBTTkpweldPRWJ2dDhaNXZ4WTBIa05Oc0Zx?=
 =?utf-8?B?T2tueWZNOUVTTytoRWRGOXg2OHFtV0dua0pZdGxqcUhQMFVkNHJrdFpSVi9j?=
 =?utf-8?B?UEF5NkdUWFNJTmFxaUtCa1pvRTdHVmRmU3k2S3NSand3dndTbDJJZFlTcXFG?=
 =?utf-8?B?SFNjR0Z3UENYbFNwVFNzb3VKQW5QUzd3d1lDaURySUdKV0VDWksrZnRPUTJC?=
 =?utf-8?B?WEdKMU9Xcy9vRE5NNXd5NHU3cjhsTDdiSHdQZ1FtTG1ybWlaQU1GaGYzRFEv?=
 =?utf-8?B?aUY2cVZ6aWY2RnA1VnNzdjdlbmVFZ3VVSWdXMG9CQjRteVVMWkNHazh5c1Aw?=
 =?utf-8?B?ZkNkU2ttVnFuUWphUG5SdTlLcDhUQ0J3S3BXNGdMaDJhMVRjZExNQXpEb2Q4?=
 =?utf-8?B?ck55SWQxU3N5Tms4L0l1enRGSU1HWGVLYUtoOG5GSlAyd1FWRGVnUVRYMGJp?=
 =?utf-8?B?aUZkRmtEN0hFVkhybU8vSDY1c3lnREYrY3hDcFA5Vnkwd0FmTWlZeStXSUly?=
 =?utf-8?B?SkxnaHpqU1Z4RTNOK2tZMHFVRlpDQWI2YjhnWTY4NWFPT25IZm4xenVRcnJC?=
 =?utf-8?B?dGcyeDZUTXlYVTUrd2NacEZsK1RNbXBWRFJ0RHFQdnBuZGExdExjam1MbVBz?=
 =?utf-8?B?Mk0xeWVveE5OUDQ4VUpaclJ5MjAvcFdYNHc2N0Q0Z0dxQ2Y3SWdnN3Q3MktS?=
 =?utf-8?B?b21pY1p1OHJyWm9yY2Y1NDN2bDRNbUpVV3FHVlVPZFhzemxOTUxTbTkxMG92?=
 =?utf-8?B?QXVEOUtGK2pmNnhOWkJ3MDBmU2YvZDlOcEdHcWlmdnNacmRPQkpzOEp1REhZ?=
 =?utf-8?B?T0paUHFGdGxOZ2RXN1JQSnFFaDJ3SElYejhUd0pLM2I1Q3ZKQzNjbkdqeEI0?=
 =?utf-8?B?aWZoaWN6ZlB0YngwN3Vabjc2Y3lXRm5WMU1nMnlWay9UR00yQ2dKTStFUUJm?=
 =?utf-8?Q?g0/DSHGDJX/5yAvaDRDfX5L4qVSj392rDIMhY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejh5ZmhNdncvTk9oR3YyS213a2VSUkNHNlpoeVJBZ21YbGdsQ0hESnd6NjZv?=
 =?utf-8?B?SElzblRXTGhqcXNCRTRUVnRZOTVDc2FvRVNvQzluMjRITUNRTFpOdWlRL0wz?=
 =?utf-8?B?VmhwMnc5UEFzc1B5cUlOQmw1NjNSTG8weHBIVXRHczZGQitaMzY3TGx3MVZW?=
 =?utf-8?B?V1Yrc0FaVVg5d3RnU1psZUZwYTVpdVpSSHphc3d1aXMzRHE2S2REVGFqZ21l?=
 =?utf-8?B?V1pzeGRMaXVqRndXNUhPejdCUC9td0FRTlZ6WkJ6b2FKSDJrZGdHdGhqUUh2?=
 =?utf-8?B?Y1lzazl5Y1FQYVVRZStZbi9menZKVXFxOTVnVnY1OTNTQmxobnpSNFdnUVdk?=
 =?utf-8?B?cFRnODczaTFYTlBwOFFIWGZHZG1XNVlYRldwTGpPajA3eGFyZHR6TFdicGNo?=
 =?utf-8?B?T0pqamVyZ3JUOThoK05aUDJoMGJacjJMVGJGV2xJSm9mV3dQb0VKSDB6eDI5?=
 =?utf-8?B?c21IN25Scm5wRWFHWDJhanZ3dm5idEU2dUplWDJUeCs0cFQ5bGJEWjhId1FM?=
 =?utf-8?B?S0h1N1hkV0E0ckF1OUwrdGVpSEt3NWhUMWJQRVhNMndGL2d2eTUxS3NGa3Fm?=
 =?utf-8?B?ZnlNNEtPUDFwRE0yeGQ4ekVrZXB3S2E4eGVYZldaR2tSUEI1VkJNcUFnSnQy?=
 =?utf-8?B?ZjMzT09RVFJEYWJNTWxrQnRJYjFDa1VVemREYis3b0MyeTRTK211eTdRdS91?=
 =?utf-8?B?cWpMVjA4dHQzd1pXMjd6Ly9HRm11U2RONXNDdFFCRWJpaW83Uy9tNlErSStQ?=
 =?utf-8?B?U1hWcVhLdTRPenlrUVJrWEhYclE1eXBaUkh0RTBPdkVhVVFlaXJBU013bXJI?=
 =?utf-8?B?YUdva055cHdFcmRzSHNmcTRxdnJqZGtCOUZ1dmNUeUtGaHJzazFqUHZIM3U2?=
 =?utf-8?B?T29wY0d0QW5EbTd6OHJHcTZ1ZTJMOUNMRTFkaTNKNGhYbERyb3hqL2ltWk9N?=
 =?utf-8?B?aHpQTWg0RjdiQVB3cDdXTWJOOU05U29GNXh4bXZ6ek45dUczaGE2eHJtY0ow?=
 =?utf-8?B?SytqUEhTTUZ6ak9MM0diRXVaUHlRRllFR1JTdm1JWnNaTWliSmRBK1Q2ZEIv?=
 =?utf-8?B?aEpzSEVkSEZNM2N1aVBLbElsbHR2RzRmU0NGNHBKWWo0QXlYNGdFYWc0VHhQ?=
 =?utf-8?B?UFh4UGxQMFdtVElBbk1QeWVQS09jT0MwYmkrcndxQU5ETDRyTVYzT2Ntajcv?=
 =?utf-8?B?bjdiekhkWU5qYS9hUDBJV0lyenZoZ2cxQ0JMY0tUTzhwbU5BTmRLZWphUEti?=
 =?utf-8?B?TEdrY3hDNkkvY29kY1gvQnhJOW5kNUZRYWQ2cUNFa1VnWXJlRTE4Q01HNGpU?=
 =?utf-8?B?akc4eEcxem5MSGs1UDUwbGhiTGVLUjRwZjhqNUd4WHpMMUhvb3F5ZkRYTmdy?=
 =?utf-8?B?QnU1d2d1M25DMlZrQW5uaHA3eEhEclpQQjV0ek9NWHR4RU9VeUJaZHZmcWN3?=
 =?utf-8?B?QlY5UFM0Tk1EcDVSN0RCQ0N2VmUvK0lLYXVnaG9WM25kVStXdnV6M2IzWk5M?=
 =?utf-8?B?T3B2MUcwSnB3WXcxNVhseEllK04wSGp5bFdUNXpJL2hlT1MwRlRNc09XZVVP?=
 =?utf-8?B?Uy9Ed2FhTkZJM0tPTFdUZVJrQzRiVFJyTUI1RXlTZ2t5RFZlc2I0Y0hKK3VO?=
 =?utf-8?B?dnp4cnE5cVZ4TnVjL2MyU0xZVEpkbW0wSGdFWkVYVURaUXM4Q1ZHN1hYUmd4?=
 =?utf-8?B?MEsyd25QVkdmTEhyM214TFNrY3BrK2w4U1dCYzZkYVN5dmFDY3dwYThiT1dy?=
 =?utf-8?B?MnVnVnpmOHBaYzVOSXVRbHE2c09URVNhRzhxaHRJOW1KU1k0U0JRVVlBS3hi?=
 =?utf-8?B?bWE5eW52L0E3R0Z0Y1o2NS84c0lrL0c3dng5T2cxRGI4NVBncTJqVElBNEVx?=
 =?utf-8?B?K24xaXN3aVZEM3FJNEJZQmVQb3BSSFZwQ1psdVVpVGRCR3h1RTBEdGpFU2lk?=
 =?utf-8?B?TW1WMjBybzA4M05KaHNFTERBbzBzTUU0OStZSWVCZmVzSElMMS91T3M5bk5C?=
 =?utf-8?B?bmkwdGgvY1NHemZCRFpPSzJURHpMUFI2S2c3VEt2LzFDQzlweEFlZUVCTmRl?=
 =?utf-8?B?Y2RtZU9XRzZiT0pPYUkvNDFpYklXcklXMlZYallKaXh3T3VsRHNLZDFPYjdD?=
 =?utf-8?B?ZFhtZ29nMWdTTjJrVnRDZHlyc0IxcjlNejI4UW84dnV3ejB5OUxJMWR5TGxU?=
 =?utf-8?Q?GbOEAVkaaMwA5/Rt6H6M5mY=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6957419c-7e07-4ba3-a907-08dc86cde09d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 08:43:17.5814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjrBCQXZ/CWWTafIC4/wypoucV2MLQvCRluZMmvO4Et13oZEELmZTUkFJEmeRj3f/WZTN1euFZMehQEU0UR9rrW6hjjb1wob3u2xj748v4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9932
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

Hi Christian,

On 6/6/24 4:29 PM, Christian Marangi wrote:
> Add a new activity LED config and additional functions to implement a
> simple software blink feature to signal activity of any kind.
> 
> Usual activity might be a file transfer with TFTP, a flash write...
> 
> User of this API will call status_led_activity_start/stop() on each
> activity and LED will be toggled based on the defined FREQ config value.
> 
> With this enabled, cyclic API are also enabled as this makes use of
> cyclic API to handle LED blink.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/led/Kconfig       | 16 +++++++++++++++
>   drivers/misc/status_led.c | 41 +++++++++++++++++++++++++++++++++++++++
>   include/status_led.h      |  2 ++
>   3 files changed, 59 insertions(+)
> 
> diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
> index 6c4f02d71f2..869ed78e87f 100644
> --- a/drivers/led/Kconfig
> +++ b/drivers/led/Kconfig
> @@ -359,6 +359,22 @@ config LED_STATUS_BOOT
>   
>   endif # LED_STATUS_BOOT_ENABLE
>   
> +config LED_STATUS_ACTIVITY_ENABLE
> +	bool "Enable BOOT LED"
> +	select CYCLIC
> +	help
> +	  Enable to turn an LED on when the board is doing some
> +	  activity (flash write, file download).
> +
> +if LED_STATUS_ACTIVITY_ENABLE
> +
> +config LED_STATUS_ACTIVITY
> +	int "LED to light when the board is doing some activity"
> +	help
> +	  Valid enabled LED device number.
> +
> +endif # LED_STATUS_ACTIVITY_ENABLE
> +
>   config LED_STATUS_RED_ENABLE
>   	bool "Enable red LED"
>   	help
> diff --git a/drivers/misc/status_led.c b/drivers/misc/status_led.c
> index 93bfb410662..5ee68c7c77d 100644
> --- a/drivers/misc/status_led.c
> +++ b/drivers/misc/status_led.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #include <common.h>
> +#include <cyclic.h>
>   #include <status_led.h>
>   
>   /*
> @@ -23,6 +24,7 @@ typedef struct {
>   	int state;
>   	int period;
>   	int cnt;
> +	struct cyclic_info *cyclic;
>   } led_dev_t;
>   
>   led_dev_t led_dev[] = {
> @@ -140,3 +142,42 @@ void status_led_toggle(int led)
>   
>   	__led_toggle(ld->mask);
>   }
> +
> +static void status_led_activity_toggle(void *ctx)
> +{
> +	__led_toggle(*(led_id_t *)ctx);
> +}
> +
> +void status_led_activity_start(int led)
> +{
> +	led_dev_t *ld;
> +
> +	ld = status_get_led_dev(led);
> +	if (!ld)
> +		return;

Should we print an error here as well? This seems to mean we are calling 
this function with an LED that doesn't exist?

> +
> +	if (ld->cyclic) {
> +		printf("Cyclic for activity status LED already registered. THIS IS AN ERROR.\n");

What about giving the info of which activity status LED is problematic? 
So that if somehow we have multiple activity status LED, we have some 
idea where to look in the code already without adding more debug code to 
get started?

> +		cyclic_unregister(ld->cyclic);
> +	}
> +
> +	status_led_set(led, CONFIG_LED_STATUS_BLINKING);
> +
> +	ld->cyclic = cyclic_register(status_led_activity_toggle,
> +				     ld->period * 500, "activity", &ld->mask);
> +	if (!ld->cyclic)
> +		printf("Registering of cyclic function for activity status LED failed\n");

Ditto.

> +}
> +
> +void status_led_activity_stop(int led)
> +{
> +	led_dev_t *ld;
> +
> +	ld = status_get_led_dev(led);
> +	if (!ld)
> +		return;

Ditto.

Cheers,
Quentin
