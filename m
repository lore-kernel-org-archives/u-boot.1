Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1375FCAC581
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 13:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 437A682AE9;
	Mon,  8 Sep 2025 15:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ZrPa2n/7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B4E82C84; Mon,  8 Sep 2025 15:41:54 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3629809A5
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 15:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhI/6eBaNUYNsTjiBSkN7CXq8bW25qX6Rf8sRkErEmLwY+QU1ikNu54VfBnJVqgF3TjoT+U4s+Jr2TsTFdMWgmZ1RvN0XntjSLVZTv1+tx6+KdC7khgzO+MmUB1+9ceIbtJkAezxF/V8z30a6dqSqjpXQJh9nw3ovQRDc2OkK8pgrKB64DdxMQ3ojOh0yhPbAijBVfsJLWYx17ju3aran5OQYH16rdLLVB37rr5lkDBpUvqiCCvp6Ut1riIRVL1ukwLyUgOJc6n+YYkBCk0T9ZSf2QwUmXHulx1s6raVvO/pXBCmeh+pmyG8EdmMz3hA9rmleCOIvVqpBXawKZOzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irb3SX3swYZpOZlWKsXPjlzi9aUObIjuPFzmcMY5CBo=;
 b=oFsVl2IXLi5N/E4e7DSOLg9u6++HZ1pyq9OsUw7UKJCM16TI4y58HEBpT6QaPuu/03HigZNeI7ahAthYQg1HRbeY+9wc57LnF7govWWbrLAY9bUyMM/9r2pyEjjVRRiMvj5XRArxVtayOgmmYmGpTbmmO2KNWUrOwDwZIMlJEQz75hn+pdRBbP8WTMAAGP1Bv3Kxga0TnbXqBOyYdxGKzvKbHnh+kp5JwskyS2U0dNha1Xs+5XUr/dqDy8Zv5K59p8y+fchHiOwIKrlv2IDK92OX0XDD4FSuWjJNlt5CCqTHuKEMzpttlSpH4E+tie8dLS4oFOr7rn1FBgcvUHzs1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irb3SX3swYZpOZlWKsXPjlzi9aUObIjuPFzmcMY5CBo=;
 b=ZrPa2n/7HVxqJslQ4SbF4a1Bsezj+s9kt7q+p/HDJSUk1o5PcCOfZzOfaHNUNQ7h4AGwOlOXB3hpbdpNlCh481ujOLl3eyLBI0KgS8/dP2gtzlmjDho7f7vCXa1pAiO26qaSdg+OEJH1vtHZuXx2LnhEZ6WFxzzSI9NWNfv+S1aFgvqc05eEDrty+Y4oy39ZE7Fr6JcSpqnrHJGXfkjmNMEqwS3sbErUgG6/uNiH2aZ3VDW2N531f2tbyPTpAsinwI5+ygfcB7lIETBKqf2sXLff4wWMe9/9KgtFoJ5TXD8JzCBtObgBFDxUE4vXkYva7HlaQKFRfNLFXuyY622Xlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by MN2PR03MB4960.namprd03.prod.outlook.com (2603:10b6:208:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Mon, 8 Sep
 2025 13:41:48 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 13:41:45 +0000
Message-ID: <0c103ea7-07af-4d01-a1e4-3d4d4819657c@altera.com>
Date: Mon, 8 Sep 2025 19:11:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] configs: Increase USB Hub debounce timeout in Agilex5
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
 <20250808100412.9320-4-nareshkumar.ravulapalli@altera.com>
 <7cfaf6cb-38b9-4932-8904-ce7be12a5098@mailbox.org>
 <69597595-6c7e-441a-952b-16b80fd60aca@altera.com>
 <e3107726-6980-4330-aabf-aef1ec9f5562@mailbox.org>
 <bff0c320-35bd-4129-9e19-4ef4103ba923@altera.com>
 <ea637053-8f40-40c5-b257-e582dbbc3c1b@mailbox.org>
 <3168323f-8cd4-45a9-914e-fb79cd346d67@altera.com>
 <c5b7a8b4-2674-4857-a9f0-0576c1602f86@mailbox.org>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <c5b7a8b4-2674-4857-a9f0-0576c1602f86@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::7) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|MN2PR03MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd06a8d-916d-4c5c-3430-08ddeedd71cf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnJVQ2M0SVorVktyUXQvaENxUEhUaG53NXMwUlIyVlh1d3BOMmpaNEJVQkNj?=
 =?utf-8?B?ZkVZRnRvOUY5UUh1cjV1WnUyU2ltNUYrQjUyK3R6MWJXVmxEZW5IMmR2djhX?=
 =?utf-8?B?VkNDSHdhU1ZUbTI4NjdQalU2Njc5WTg0TFBDaldQSWc0SXhOejA4U3VvOUhB?=
 =?utf-8?B?a3JWaXhmRmozdFRSK3lCdnBIV2Ryb3F1RzkrZTFveXVVd0dydW83NHo1NHIz?=
 =?utf-8?B?ZkU1a05EY1J5TFVWa1Fodi9ZWmc1eUNudjI5YkhZR1I3UTh5bE1pSVhUdVlr?=
 =?utf-8?B?eTNHWTZHV3h6dm8yTWJFWThLMTNOaHVUNnZ3akQyQlF1Zkp0SkhkUXZhSnlF?=
 =?utf-8?B?R05EOXc4MkVZTjM2ei9Db0RoTkRTR25sV0JheG5BK0k0V21jZEZiWDFFdExI?=
 =?utf-8?B?aWtmM0JrS1BlRjR6WHl1VmFXekhiRDUyYzJKbWJ4Wi9EblczcHpvdVlKb1BR?=
 =?utf-8?B?YitSMm1wVDBxdmRhV0lUSVFDNTlyQjJGM050bjNVWkFIWVB1ekh0ZWU3VDZF?=
 =?utf-8?B?OFhObmF0OE90VFV3L0JlemRXanRuSTYzS21CTDFWZDNPMkJVM1A4QVNQODhS?=
 =?utf-8?B?eG1vOEdzTkR3ZlZhRDN3bW1sdUhRbW9VUjFCSEJGSUFRT3dFazhpbm91Unh2?=
 =?utf-8?B?bE4yR2V5dGpPTkNOQk5OM2kvdWl1Q2hTcGFKRFdTTjU2QjZWbGsvM0pGRDdh?=
 =?utf-8?B?M1hFWlJ5VGV2dFlzcUtWSVhiTlhHdlVrVFltZW9IT2dRVS9Kd2hzdnVFKzBK?=
 =?utf-8?B?K2ZSdGxpdW1CVHNyOWY2QnZ2dHV4SFNOellKaWZBQXl0dWxGb3Z2ZjFsVUdj?=
 =?utf-8?B?aDM1QWxPbFFXM0lYalpxYUJIT0JURHpyRGZ1OHRhTEVuaDdpZWc2NUdLOUhW?=
 =?utf-8?B?aS9sNjhNbUs5bUM2V2tRVFlBS0lwRzFsMXJYTDc1RGF2Y1hvN1dWaHlHTjRC?=
 =?utf-8?B?TTRPRnNTbW0wYmdnaGgvSnFyR0h1WUliQ2dSeG1sbmF0Q1A1Sk11bkpLK2Vv?=
 =?utf-8?B?N2gyVjZUb2FIdEcrcGhMcWYrVkVES0sxclpESVJ2MS9lZDhlbk1ESFhrR2Vj?=
 =?utf-8?B?dVlWcHZJZmx1WjNXdWlienNsUnJDaE5nQy9FSXprR2pBY3I1M21Ia2dPN3p5?=
 =?utf-8?B?S3VUQnJVMXF2ajBkbGE5ajkvbENBTjdUZFAzcnUrbVZ6WUtGNHRTLzBUU1VT?=
 =?utf-8?B?MnUwVnNVWTIvU0VnNmdxTVNhbUZuem1EMCtNZ2pFcEVvMUZUR09iQ0UvWmVn?=
 =?utf-8?B?M1dUZmdhMnd0cWtQVW0yU0IyR3FpL0daTFppSW9adFdXQlIyeUxuSGlmWlRW?=
 =?utf-8?B?RDlaNXdXSTZMbG1zbkJhMzU4dUxpa1ExNXpyaGMyeWNmN1J2K1pDS0FkSVlS?=
 =?utf-8?B?aG1kRzZYUU9wWGx5NVhpcnBZeTlUQzA4b2hEeWtNSmhheDdYVis1STFBQWFp?=
 =?utf-8?B?NWEzRDZ1UndycGFjNTZQUXZ2K1JGbmRiYlN1RnFrZHgwMSt3SnIvUHI3aG1O?=
 =?utf-8?B?SEtuajBYdW1ZRTVFMVhMWEFtQ1lBajBUcDBNY1JTS0lldjZHRjNiaDFYTE0x?=
 =?utf-8?B?cXpPeStIVzRRUHdTMHk3eEZvRjdjRm9hYlJsS0VCK29meThERGI5U3RMU1Fs?=
 =?utf-8?B?RFVJUEhmNjhzaG9FY2NRUGVEQ1NnNFl4WFNYdmM5T21KZEpGQUxaR3FnQnY0?=
 =?utf-8?B?YzFrbkZxMGc3d0RHRkExWkxYRXlVZkVEa0J3blpaVXI1RjhaZk5rOTI1OTJE?=
 =?utf-8?B?V1M2eWhmeGNBR1dhUXJVZjBsN3Exc1VkZ3Z6djBacEY4OWtJZE1ibkt6N0lL?=
 =?utf-8?Q?llkkfUHiE62aq/t1u+mK1KL0yKgIoIw+Y3BCs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnN4ZHBVaG1QQlUveWhlZ3h2aVZyY1A0Mlo1SEx5YW5pSDBFc0hZMDVCdE83?=
 =?utf-8?B?cHBsYnFyN2tkK1h3SXh0WXQ2YTRvVHUxajEra0QvMXk1K24vZThWMEV3WnQ0?=
 =?utf-8?B?eENBM3Y3aklmZUh1TEd1ajhZcWVoa01UcThXVFFnOHN5dlg0S3hMbnV5bWNS?=
 =?utf-8?B?WDQ5LytUWVBOU2l6Z3lVWmYvdmJ1aktwWXUxUW90RG16S0FNaFp6c1FyYktQ?=
 =?utf-8?B?a25QMTFlZnZBVWQ0enphZzZIWlEzMUxCSGtlRVpHckRMS3d6aVA1Q1k5T3Zv?=
 =?utf-8?B?NmJzKzZ3MXcvYkhWT1hkMUZyRm95a0FvdExVMkJORG5ucjhpZDljMXFMbm1U?=
 =?utf-8?B?WDM0dmhMNCtMSHJiZ0lXVy83ZW8xUURCdng4NlR0UEhURTljWDNQS0lLZGRU?=
 =?utf-8?B?eEFraUUrSEpmTFZHQVVEQXlyRU1Ib2dMMjBseUhyQS95b0VQcEl3dG9Va0tW?=
 =?utf-8?B?amtQQ21FTXdYRW1ZamdSYitLVnZuZFJadHZST0llR05sLzQ2ZEY4N0FhcVNK?=
 =?utf-8?B?YmZOVXdFd3BDUXFlYmlxTXdZeUdDcGo0MGs1SG1uTzFKaXVmQ0dVczhTM1VN?=
 =?utf-8?B?MUhFaitmRVFNOFFNcUhHZ2dDdlczUGlKUDExTklaYXdMV0V3KzZnQnZ2Yk9j?=
 =?utf-8?B?RUJqZHlyUWVIZ2d5TjZrbll2eHI5Q3FhZUlGWVQ0b3B3WUxBdndqMkZjNFlP?=
 =?utf-8?B?MzZWMXdWWWtBbzEzTTA2NnBlK0FtL1dZR3h2bllGYmZPM2pqdUhtVkIydDZ4?=
 =?utf-8?B?Qzd4a0xrdW5ydkNVNHoyVVpaSEhkVTg1Q3R4NmE2Sk9vdXFTdG9RYWh4QldP?=
 =?utf-8?B?dm11dEgxZlk3dVlFcFhkTHRtVmswc2R1NEtNTkU0cDVnMmxvNVdwMlBPb1dQ?=
 =?utf-8?B?YlNxTVZVSllqWm5DekJBNXFsZTU2bWErUlFEcHNPemdUN2lLYm5SZ1ZzY2NF?=
 =?utf-8?B?WUhqOGlyRzArVGY1ZDhBeitwSjlmOUJRVDV2NWI2UUpCWHJrcFZiZnJHOTFq?=
 =?utf-8?B?NHN3MllhTUxvblhoYjZrKytLVXpZM0xWeEd6dWdPQXdVSmpPU0xpbVB3d2VP?=
 =?utf-8?B?aVVqTkxyZlcrdUpDN0pPb1NBeDdkR0NSdXdwbWlWWk1CdjNnTWpDcWZsN1Np?=
 =?utf-8?B?ckNDa1BUazR2S0VKekg5My9ZVithT2hKZmJRaDdpL1hkdzFIb0MzZ3Y1NzdK?=
 =?utf-8?B?NTJrSzZSK0ZtK0RPNHBPdWNIU25veHZlVUtBSnNaQVNzUmZ1eUlTUFdZejlC?=
 =?utf-8?B?OFR6WmVVY1J5QjlGaTRFRFZzeFRIRlJUWnIwS0hmYkFQSlYvVlIyb3U2YW1S?=
 =?utf-8?B?c1c4TlRpeHRGMEFCY1hqZ3R4YTJMWmszSUE3dVByc0JqVTJzMGs3OWFQZnFv?=
 =?utf-8?B?ZC9aZjAydUE3c0dzU1JENkN4LysrU081b08wVHBEcG5Ob2hDTDAydDhhZTZy?=
 =?utf-8?B?S2tqZzAyZ0N6ZTJjTGdjOGQ5ZmVhNmtBUnZ3Zkl5UTBiaTFib0F4TFJVOGJO?=
 =?utf-8?B?MjFHcVFIUkNzZEJpQWlhdkR4OFZNbXV2Vk9TNFRyaTYrSllaTENtTE9ONG9M?=
 =?utf-8?B?K0VmOHhiYXFzZ1dWaURXd2NtdTRCRXBoMVcvVmRCODl3VHpOQ001ZGtXMmRE?=
 =?utf-8?B?RUhZTjFEUVlzUm5FL21DcEd1TmtGTmFhWVlVaWZYOUYzZTNtRlpsWDFVUFJi?=
 =?utf-8?B?d0NSSzdlNHRCaGVXbnhIdXVSd3cvbHJhaGRxMEJsUlNMSkxxV0VwZXlweW5P?=
 =?utf-8?B?YzVOcVg3QW1qSEIxWWphbFpQdHBlaXd4aHpNZklSRE5HMy9EVEZmemJoTzhX?=
 =?utf-8?B?MkRFcWY1S1pqblYzcUVkaXJ3OUhwSnBjZkxjbkFtbElUTHZmbGRtbm0rZXFx?=
 =?utf-8?B?YU1saHh3SHNocjQwY2o5dlZxaksxR3NGQmdYSTNrdVNYWGVMUTlSZlJJN0E4?=
 =?utf-8?B?LzZheUtSSjRreE5MbW4yTmhtak9pLzBwOEk5N0dDeGJsZkxac2IwdStZNFJr?=
 =?utf-8?B?bWUrMHl3RHRTaExsaSs4K3BvVXJscUY5QWQ2bUt0azF6RGs2dEhPOXZGNlY1?=
 =?utf-8?B?WGdGc2JYTWo2M1piQnhmMFEzUlZocitrUHVQQ2wzc1hXOHhFbzBWM1J6TWRF?=
 =?utf-8?B?bVlVQjVBTVhiYmx3VEN0MUZWc1Z4UUJXSWZTRVZXbWtYVUxCWkx3NXJMendy?=
 =?utf-8?Q?TZTaTbEOJHIyTo4vI5cjpvs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd06a8d-916d-4c5c-3430-08ddeedd71cf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:41:45.2290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2+cIANjUzB2Ue6S9AH+4eXQjhynAcU5nelwqciAMjWBhlPoAh2u+iEEdxNV1HyTCZpjEWmnr7nQoqtz29FJs6U7dLm007P/3F90pJmeBuAl3sLYh6JZ2yny33JFVJur
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4960
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



On 08-Sep-25 6:32 PM, Marek Vasut wrote:
> 
> On 9/8/25 10:44 AM, Ravulapalli, Naresh Kumar wrote:
>> Hi Marek
>>
>> On 02-Sep-25 11:48 PM, Marek Vasut wrote:
>>> [CAUTION: This email is from outside your organization. Unless you
>>> trust the sender, do not click on links or open attachments as it may
>>> be a fraudulent email attempting to steal your information and/or
>>> compromise your computer.]
>>>
>>> On 9/2/25 9:52 AM, Ravulapalli, Naresh Kumar wrote:
>>>>
>>>>
>>>> On 30-Aug-25 5:30 AM, Marek Vasut wrote:
>>>>>
>>>>> On 8/29/25 6:19 PM, Ravulapalli, Naresh Kumar wrote:
>>>>>> Hi Marek
>>>>>>
>>>>>> On 29-Aug-25 2:11 PM, Marek Vasut wrote:
>>>>>>>
>>>>>>> On 8/8/25 12:04 PM, Naresh Kumar Ravulapalli wrote:
>>>>>>>> Some USB devices need more time to be initialized. Hence,
>>>>>>>> increasing the default USB Hub debounce timeout value for
>>>>>>>> devices to be discovered, connected to Agilex5 boards.
>>>>>>> Is this really hub debounce timeout or usb_pgood_delay ?
>>>>>>>
>>>>>>> Which devices are those, include that in the commit message.
>>>>>>
>>>>>> Yes, timeout is related to USB connect/disconnect signal bounces not
>>>>>> about bus stability during init.
>>>>>>
>>>>>> Issue was mainly observed with legacy flash drives. Maybe I will
>>>>>> change
>>>>>> commit text from "Some USB devices need more time to be
>>>>>> initialized..."
>>>>>> to "Some old USB flash drives need more time to be initialized during
>>>>>> connect or disconnect events ..."?
>>>>>>
>>>>>> Note that I am not modifying the default Kconfig value in general;
>>>>>> change is only made for an SoCFPGA devkit we tested.
>>>>> Does this same issue go away if you set usb_pgood_delay to 2000 or
>>>>> higher too ?
>>>>
>>>> No, changing USB HUB debounce timeout is working for us.
>>> Look at this code:
>>>
>>> https://source.denx.de/u-boot/u-boot/-/blob/master/common/usb_hub.c?
>>> ref_type=heads#L199
>>>
>>> "
>>> #if CONFIG_IS_ENABLED(ENV_SUPPORT)
>>>         env = env_get("usb_pgood_delay");
>>>         if (env)
>>>                 pgood_delay = max(pgood_delay,
>>>                                   (unsigned)simple_strtol(env, NULL, 
>>> 0));
>>> #endif
>>>         debug("pgood_delay=%dms\n", pgood_delay);
>>>
>>>         /*
>>>          * Do a minimum delay of the larger value of 100ms or 
>>> pgood_delay
>>>          * so that the power can stablize before the devices are queried
>>>          */
>>>         hub->query_delay = get_timer(0) + max(100, (int)pgood_delay);
>>>
>>>         /*
>>>          * Record the power-on timeout here. The max. delay (timeout)
>>>          * will be done based on this value in the USB port loop in
>>>          * usb_hub_configure() later.
>>>          */
>>>         hub->connect_timeout = hub->query_delay + HUB_DEBOUNCE_TIMEOUT;
>>>         debug("devnum=%d poweron: query_delay=%d connect_timeout=%d\n",
>>>               dev->devnum, max(100, (int)pgood_delay),
>>>               max(100, (int)pgood_delay) + HUB_DEBOUNCE_TIMEOUT);
>>> "
>>>
>>> Changing both usb_pgood_delay or (CONFIG_USB_)HUB_DEBOUNCE_TIMEOUT
>>> should have the same effect. How come it does not ?
>>
>> CONFIG_USB_HUB_DEBOUNCE_TIMEOUT and pgood_delay are used for different
>> purposes. If I am not mistaken I think I explained this in my earlier
>> comments.
>>
>> Anyway, to further elaborate, CONFIG_USB_HUB_DEBOUNCE_TIMEOUT is used
>> for debounce timeouts during device connect events and pgood_delay is
>> used during initial VBus stabilization.
>>
>> You would be able to see this difference in the link below, where
>> pgood_delay which is populated into "hub->query_delay" is used for
>> voltages to stabilize before initiating communication and "hub-
>>  >connect_timeout" where "HUB_DEBOUNCE_TIMEOUT" is populated is used
>> after getting the port status.
>>
>> https://github.com/u-boot/u-boot/blob/328747974a0620d0996113fe2b3906b06e96de00/common/usb_hub.c#L455
>>
>> Also, the change made as part of the comment is not applicable to the
>> USB stack in general; it is only for our devkit defconfig.
> But none of this answers my question, looking at the aforementioned code
> -- Changing both usb_pgood_delay or (CONFIG_USB_)HUB_DEBOUNCE_TIMEOUT
> should have the same effect. How come it does not in your case ?

Maybe I wasn't explicit in my earlier comment, "No, changing USB HUB 
debounce timeout is working for us."

What I meant is I didn't want to modify usb_pgood_delay as my issue was 
with HUB_DEBOUNCE_TIMEOUT, so modifying this value worked for us.
