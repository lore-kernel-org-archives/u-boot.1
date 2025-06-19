Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEEFC7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 16:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36BF782D60;
	Thu, 19 Jun 2025 18:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="R1h9ILXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E563380C83; Thu, 19 Jun 2025 18:39:33 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89BD482D60
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 18:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oABwYQdkTaAgfKjZUyPV16oNEheqBFMxYyOwW27zV3xgJmtEEmNz+TWiMtG3Y7BtAf6D6sXpH1035uqIk+0vFpMhIJczrLoEFPAxx9cY/0xkfH++NZ9f9d6hjdtBC42vVig1QTe58jZ4GC7t4vTQJsyxHtij3BopHZE3COoZrZahtZgNRqrp1FngkndBi08PnAYRVingVzaUoDKlUKIg7mXoacgBeBtbDGG4se467z03W/2l2A7JUvEv8igcrcag2B3N0nEoveF/a8wApP3xdqsa+GA58mk4qZ5GtIc8fQxy69mmju4S4KI7w7+dqq4V97uw2n6eJB+cuEG7ww94Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ1T6PvAHAYIW+Cxv7/1Qcx9fPV1iVxFk2c0XotKSAc=;
 b=tfrQJ5sV4/7MtU4JaA+ncCwacAxQmvgzhWfGH6Z9AExSDDcLInAt5qJhYO2+7NntMvsndEtqxi1UfJq62XYzp+Nwj6XdqF8YbL4uDmXg/59NTnEvATl5dX+OHVCldCMllBjq6lNf3Yb0a7wOCWn/M8UU/+fKLQsJJYo+T+6yDQ3pXBzHnIzwbYMo2TNka6fuOVyJIDoxjaphjdTUyDTiTDtBXIWLQh4kmcjAmFZvsNOFjmdbkkELz+r5X0RPINZuvSnQRLalGt3bor8OrMTbpUzLXJX7HRjnnhwVZl++/olg9e9LTh0DVNHP/qFdWVSxNA1nqLIpzKFodoBkWZj4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ1T6PvAHAYIW+Cxv7/1Qcx9fPV1iVxFk2c0XotKSAc=;
 b=R1h9ILXM1cjjrmMyNTukGy7x57rQx6t/tL8Q89ghxJlZN3V0KZ4UGrv3QJN+waZA/GIhKIMvravW0H4BvWLWPVPU4fula/NWjKnIk4UqwbzhBD+Zd2AyJIZ0SAdj0gF6HSpqX0RQ4J3XDOOfEuiOtGbveScip1v2aJZG9Jq6RLjH2vueApaxdky9hyDT1XTDVd8D6NTGqbxym4ZHDjUgCFwtgQZi6z9mpRKHveMQcjwlK8hG4cJgpvPObk0fxF5649MDGDMPhcd7R4uPXgb8kldfCq3VfDkbaJIvDC8taFw9L10MP1y9qgW6aiSkSB16NOYiz8RAAfX7h74bpyxf7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6432.eurprd08.prod.outlook.com (2603:10a6:102:154::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 16:39:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8835.023; Thu, 19 Jun 2025
 16:39:29 +0000
Message-ID: <1779cc0a-0433-4d67-994f-2dfacfcccb36@iopsys.eu>
Date: Thu, 19 Jun 2025 19:39:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm/airoha: reset_cpu() does not take any params
To: Tom Rini <trini@konsulko.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
References: <20250606210805.GE1382132@bill-the-cat>
 <20250606223923.503086-1-mikhail.kshevetskiy@iopsys.eu>
 <20250607140948.GG1382132@bill-the-cat>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20250607140948.GG1382132@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0238.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: fa17ec7c-056c-425f-e819-08ddaf4fdc2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzFKSUg4eFd2cE8rTGppNkREQk8xczRzK3lCRVpETTd6OS9MWTBtZWVoemJM?=
 =?utf-8?B?SFpLZHhNSHc5TXhSTXM0azVDbHhDNDAzejN6bEl3ZzljeGZiN2VCY0oydEdp?=
 =?utf-8?B?L0J1dlZTcE9JRWs1dUNsNTdxTjREYkk2QzJqS1JsUHF5RkpuY3BLMm9INkF0?=
 =?utf-8?B?bndPMU0wY3JFd3Bma0RhaU5nRmdYQ0xVYmpKL1gvTnFLTmkweVU2WFBraVNq?=
 =?utf-8?B?TVprZ2FoK2o2d25PczJjUmhudVhkWkZoUTNOM2xHOU8ySW5naXJFbkhHNTF1?=
 =?utf-8?B?NGE1VFZ5Ymt0aUFWZENRczRkUzFRalN6b3RPV2F0Z2ZyWXBEMGw4TmdYaDFD?=
 =?utf-8?B?YnJJaE53NUgxdkI1L0s5MXNKR0pFWGY4Zkxlb01nMTBXYzgyUXIzYVJVZUEy?=
 =?utf-8?B?QkE4ZDloUTFsYm5rRWZmU1Bqd09NWmI1cjVBQ2ljSzZySFhEcnc4RzdMQ1hK?=
 =?utf-8?B?Yk1EbU9NWU0yUFVYK29NRHR2b1FjSGd1MzlzcTVYVFNYNVdZTE1kR2IrOFd0?=
 =?utf-8?B?SUZ1N0xBTER1RkU5SUxQLzVNZXhqSVNRNGUvMUZnSGRuOXVSbkkvbGY5R0FI?=
 =?utf-8?B?NkZhMXBlM0QwV0pET2Z2Z1ZubTVXcU94em9sZ0d5bTluM3I5MDFRN1VWNERE?=
 =?utf-8?B?cm0xUTNLN3h6a012QzBJeStLNlR2VzFmSVVrc2cwQWkyRExCdDhXY1gzVnBj?=
 =?utf-8?B?YUY3RG56b0dETFFjUVVsM2diY3JLVm1icHhKaVV3R3VFQXdXaVV1UFVla28x?=
 =?utf-8?B?QlEyOXZ2M0VsNkhZWDk2WlR0UlpoVE1iS1d3eW1mN0xjUzBkb2k1SDFrenh3?=
 =?utf-8?B?c0tsQy8rL3BVQi9YN2w0NWptTVRjMExKOEZtc1B3M3FQVEl6cWd2SEdRdHZk?=
 =?utf-8?B?ckQ0b211enpLN2ZpcGtzSURzNkIzd3ZJNmtHWWwvRUhLMWVoMzd6UHpvOTlx?=
 =?utf-8?B?aXF2WmZYUUhpeEdqUmdiUlRzbk1NQm0yaWxLdVNPVVpHZmZUWG04eTI4eVY5?=
 =?utf-8?B?YUR4S3Y5MHNWSlowOUpjWGt2VXZNd3gyU0RnZ1I3UU9IN2ZzaFdKYVJldmMz?=
 =?utf-8?B?bVV5bU9HNVpMWCtXRWYyQm9KMy84SzgvRFZ5TmRyeEIvb0I5WHo4NUFIUHVF?=
 =?utf-8?B?cUpNeDhaS2JtM3RHaXpuMmtNZ1hYZk8rUXVKRFR0bDJxT2MxRElSWjJyMGQw?=
 =?utf-8?B?aHpVZnl1QUFTTUdpOGJscWRVT0VlR2hDYXlDYmdHcVVTdW02OEZYMEI4dG9l?=
 =?utf-8?B?SENxSHVvcUxOVm54cnRtaDVDWExTQXZiQ3B1eHRjWGhvZWtMZmFQQmZJc3RQ?=
 =?utf-8?B?ei9qb1VNbnFGUU9jZVpDdG0yK3NFVlhuc25DWGErY050cUxDQW43VHZPSEFh?=
 =?utf-8?B?dzdtc24wbGNTaUl2N0NPdjRpd0p1aFp6RmNqb2YrZ1haN0x0UVRFeVdzMWZI?=
 =?utf-8?B?K28ydUpZNXhFUlZiUUNZSXQ1ZFlEZFhnaGV2RUtsdkRiZStoU3J4dzJvZVND?=
 =?utf-8?B?dG9OY0pHbVpEMjFwOTZBN0xjMHpzeVpGY29aMFpzN28yVWtDTFJWNGxWOFN2?=
 =?utf-8?B?SUoyam1iTUpCUHVvNEF2MnRlRjhCaFhrekQ1TDZ5Q2lGb0hsbkZaRW1KSWNm?=
 =?utf-8?B?YmJtd3p4OWYrbzJSV3dzWktwYzFDRnJHNEY4US9JWjUwZkErdFluZlc2RHZy?=
 =?utf-8?B?d3Q4bzBvR0VzMWJMaTR2UmhsdEJaWk9DYmdvelFRRDdWOUxYbS9JRSt4TmVM?=
 =?utf-8?B?QkhhVWI2ZmJSckdrNnJYaElEVHZzVzc3UkhWYllDQnhBV0RuOXhqVzlSVEkw?=
 =?utf-8?B?N3RJVWdUd1RFL2RLNXFkY3M2L29DK0RJZU1GLy9Kays5MFVRWmNkQ2NKUzRk?=
 =?utf-8?B?aHNzMFlzLzlBYzRJelNYa3ZkUUZ2SFo4aUpkWFZLREZjYVhPSFFFUXhpR1pJ?=
 =?utf-8?Q?KZuVmI9oMlo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnFIRmF5Y0o2MUhTcjZTMTZyQVNmTXJzZmVmWUlLR05VMzdqb29pczZicDNr?=
 =?utf-8?B?WDZPbzNjTTFmRmJ2dlJvbDBXRm96UWE2UVJpdkQzYVkzUG0zSDNzakNCczZD?=
 =?utf-8?B?dFJkNDA1NXVqYWxiZ0VIVkY2eHNMb2l3WjVGQllyM3Mzb2R4eHcyVmdYMHdJ?=
 =?utf-8?B?RWYwR3J3V0t0MTA5WHNCc3dFZUNLZ1djYjVLKzcrMUEvMTNqMjZlTHViVjJG?=
 =?utf-8?B?MEtIMCt5aWxhdytBN1U2aHJHdXcySk5yWUUyR2J4SnBKMVhIUEhrV1p1NzRw?=
 =?utf-8?B?WGZtYmhGallpaUw4a1lUZ0hJVUpyZ3RuYW1rVDFBenpxNlRaUjg2RGhNcndV?=
 =?utf-8?B?NTVQUHA3Q0sxVFhuTENqc2ZvK3EwY1NKZElpZEpPdUNpeW8rTXYyUEcrTHNC?=
 =?utf-8?B?R08vSExjMis3WFh1RWU3NGpmdzM4VXRyOEdmcXlLSFd4SkgxdXVldEpUQW1j?=
 =?utf-8?B?UlBrU2kwbUlYTWwxcUNJc0dJK3lxUWRCMnRZT2EvTlF3SEYxUTJJaEFTY2xq?=
 =?utf-8?B?N2RrNXdTdGtHdkdCeC9ObjV2bk9iQ3hKaUJyQ2tRbVpLS2loN1ArY0kzaTdB?=
 =?utf-8?B?RnZyMnVsTlE4RkFLT0x3YU1vQVhHcEF0dnZEWk5LbS9USEtiUUU4ckJVcUtn?=
 =?utf-8?B?MVQ2cTdSWkVrL1A2QVFVNmpWNnUyWnhpZEJsMW9IZTBuOFlFNWI3S0F3ZW5v?=
 =?utf-8?B?eU03ZzRvWmU2d0dlSXJaeHpUb0JscnRRL0VGZ1l3M2MyRzlwSWczamp3VERC?=
 =?utf-8?B?VFhhQVlCTTk4UnVkQmZrQ2xuSm5kR3ZYR1RhODZJSHFaUDNrNUErWWtwL3Bh?=
 =?utf-8?B?N0J1dEtrUmxRWFhKM3Fsckl6N1E2VS9HRDRoNlFDYnVrbHZPZjRWNXduMlhU?=
 =?utf-8?B?R01yUXR4NVlDREdJdjhLdytkU08rMjV3TkliczJzenNMT29ad1pFQUN6aFA3?=
 =?utf-8?B?TzNCUzZGQzQwby8rZHY5WDJMck9GNFpnRC9jeFdLc09TdFZpb2hnUGx1dksy?=
 =?utf-8?B?UGFBRG45VWhiUTNQckpsbkpOUkFjbDRFdDNPaTQ2Vk95eGFramkyVk8zUzBW?=
 =?utf-8?B?KzVHdUVzNFZjd3ZoZlpwVEZ2c3FsWDdGOTJ0SlFNbjY5QjI0UUtiMGQ5VU1t?=
 =?utf-8?B?YjlBSGpwb0I1WDJxekFRZ0J6VjFjbGdjdE9TWURMUzRxWGdTTmllMGZBVndi?=
 =?utf-8?B?azFNazhxTDJFd2NrWnovK1o5am9uK3lEWWRWaGhXMXhJSGY5SkRFYlc3MU5Y?=
 =?utf-8?B?dCswbHBENEVsVHAyZzNtMC8vazZzVDJKZDQ0cmxrYTczN0ttK3gxOWpZTGd1?=
 =?utf-8?B?ZDBvMWM2eER0b3NuQzFuQlpxd3A5c24ybjlwZmx5Mmx2VktkZ0h0Y1laOGRq?=
 =?utf-8?B?eVVGQWxBVW93NE1EZldoYzFyZFUrUy9UWGwxQ3ZwdmZ6TEhOTlQ3MDlrVDln?=
 =?utf-8?B?WnlCaHBwNHh3MFJqQWFHUjVOMWVJZUJ2MnNUOTZoZ1BqcUw0SUNzdGlHMUxX?=
 =?utf-8?B?V2pRVklUU0dBTkdvd2RUeDBIVVZ2d3paeU5CM3NYOVVxYjE3dEV5Um1SajRN?=
 =?utf-8?B?MndkWnE4amUyRDNaK2pNbm1YeDU5L0ZmcGs5eTVoYWtscEdYWHNlaFpJSGVy?=
 =?utf-8?B?dUlNMThDYXJqWDZVMUJ1b0lMNFlXVWljUXRIZjIydERkbmZwOFhtOEpmWnVO?=
 =?utf-8?B?d2lsN0VVSXZONi9XZW15cUdwb2JVN04rMHhmVlZYRkgzd3BPekYzK3JKNEZQ?=
 =?utf-8?B?NmxVb0lGcE5BQUlqSzVHa0t2WnNjOHBMbzZYa0xMN0hva0xreVZncnlpYXAz?=
 =?utf-8?B?Vy9rL3JrZzhZZW9XeHVlMFBEaXRPanM0Z0Rod1BrWnoxbytOb0U3Ui9HL3Fx?=
 =?utf-8?B?YzRxNEN6bXJ4WHMwNWJhYnJHYSt6QVlMMjJIK0hlL3hmWVVGKzNIMEFyNVAy?=
 =?utf-8?B?YlduN3RkU2FLUTVaajBFUmFWdzkxU0pDaFJDSUNNQWxya3JQUGFYYWx2S2lv?=
 =?utf-8?B?ZFRweFUzcE4vTFFwMXNRMTBlN1VSVVJIdS9pVzN1ZDFqSEhmbWdGMXRzYitK?=
 =?utf-8?B?Vkt5dGZyWEdJNWdwMUtLelJPRGs2ZEQveENoSWhYUUdmb0ViTW9lVllsVGRM?=
 =?utf-8?B?bDQ4VzFObmpzV29sRi9qMnZtN08rQ1JXd0k4TUhhem0wTTZacnRrNklWY2Rq?=
 =?utf-8?Q?LzFBqOp0SWwHNpZscOzMlIM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fa17ec7c-056c-425f-e819-08ddaf4fdc2a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 16:39:29.0928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xI7sc0o7LGZfVUEZG3FDW/f3KY1+6d/Ep5xNcjHF9mYQdkfN1wj0mhB7u5lkclS+O7OHs2xWJAtsG+Esbtgqz5RJkg+CIz5ZOwXB0o6Rc0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6432
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

is there any news?

On 07.06.2025 17:09, Tom Rini wrote:
> On Sat, Jun 07, 2025 at 01:39:23AM +0300, Mikhail Kshevetskiy wrote:
>
>> According to include/sysreset.h the reset_cpu() function does not take any args
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
