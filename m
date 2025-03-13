Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF14CC282EC
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 16:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3052380F9C;
	Thu, 13 Mar 2025 17:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="BY7fEngP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12FFE80FF7; Thu, 13 Mar 2025 17:06:43 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C7FF80540
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 17:06:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXZY9zCJuPXdSh9ZsjgXsjUGroahMenh9Kt+oF1kTsl5fI0zA9T9trcFrIS7OZeohthToq25bWBsL3by4NgsU9s8HRJrVt//FISAHrrkiEkaqLNevGxtE4q5r/LDwLRTCULzkFuXfKavOTpBvoikAOwh4jWUkHf4JSNq5e/qTUCS6pfF5zTLLWkMqiIjrzyubODnDoLThvi0yZ0Z8uMQIM/gmaqN+t9clyrglNUtGxAwilYzW/JhXHOWUUgM8xsRFGRE6cgsiYFb2i3O8SIQxwPRajJ6mswbYs+0tbDZybGc3uZEhx+E2WhevvUq/ZCpfQPjtC5E+03tkbgXDEUkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDgWh9Ad0SzCcuDxGWdJLIuXBQq/FfuqPAPYbzahTUM=;
 b=OFee1zMai2HLo5Hgk/YtU+43fPbuCD6KZNy+KKkSKDD1EJRi+ytHN1hvrMeouKaSdhJwXHjtu/i2pAnGmODDnlY2m9+JaW1pLWJoisQoJgxW99+wARXL9I1gvCmuZg+f9o7zUah4ONJW6r9U5p/1LJ+vWhLwi/OqqbkmrMPC3k9LGz4IsqneQV6Ua3nkFeiXdh5rZiTkNBKRQx7tufy7gk7aHRjf9qT6OUW3xPrs/DzuZKf52rodMw1nu7vQuv4igQ6Cw1CiDl2Vt6KjQw8Lz7GkgsvJhMXuGUmilcgLhOzXk+Go30qB4XzpO6/un84D7RaetAcoaqA1GAyiJs4SGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDgWh9Ad0SzCcuDxGWdJLIuXBQq/FfuqPAPYbzahTUM=;
 b=BY7fEngPP7IQqDxHr2y0qJSbXho26nMNQbKdAqfhAIhW5Mx+EeDbFPtZggZc2kf5Zlb9Ixs9XpbflKU0tf8MXSG6boT9vzvR6VnHuwPq+CTRQWBODvie2JQYQ4vl/kk8u6xoA/Jr3Rzw3zOyq1msByrhg3plrsxzp+zdWH6JsKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VI0PR04MB11069.eurprd04.prod.outlook.com (2603:10a6:800:266::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 16:06:37 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 16:06:36 +0000
Message-ID: <dcc8b763-d1c9-44b6-ab95-8f2c4ac3d8fb@cherry.de>
Date: Thu, 13 Mar 2025 17:06:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] doc/develop/codingstyle.rst: Expand to include
 CONFIG_IS_ENABLED and PHASE_
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250312010021.1671010-1-trini@konsulko.com>
 <20250312010021.1671010-3-trini@konsulko.com>
 <33389606-0c16-4d26-b7e6-44e4f973d29e@cherry.de>
 <20250313160300.GC2640854@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250313160300.GC2640854@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::16) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VI0PR04MB11069:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc4e149-0bde-45f2-cc52-08dd624907b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkVwUFRkRzB3R2RNVGhEZW8vKzIvVTMwbHByMElqVVIvNks0aXREU0R3dmha?=
 =?utf-8?B?NnFpS2YyREh4NllhdUVYS2xNYnEvVUVSWitNaFM5di9oVkdLeTkwRk5sVDJk?=
 =?utf-8?B?eUNDZ1VDeFNROUMwN0FLWUkvaWNkOERNMXpEaEpzbEZ2UkZ6ekRQUmt0aVJY?=
 =?utf-8?B?cFZkU1BScXlaVzV4TmVvSlRNTGpKTUYwamlZSVVQbDVVN0ZRNHFzaStXTjY2?=
 =?utf-8?B?bUxmbXpCYVVlRysrVDMzVmVjQUw2SFlPWXVYREliTGMwaFUwUzlxSFp2WUxP?=
 =?utf-8?B?MzQwR2FGTzBXVDZMNnRHdGN5Tjd2RXpnbEVjVFU0NTkwUmVERmlKZml2aEpL?=
 =?utf-8?B?dlBNQU1mbkhCSWx0aEhFMUF1VzNrNzFxT0ovVW9JSEg1azJKeGw5eHlrSmcw?=
 =?utf-8?B?UmI3Tk1YNnBKK1VvQVdiSzhXZk5Lb2xoeGh5NFVKcGFVUC80bWNsSEtmM0Jv?=
 =?utf-8?B?VDl4NXRCRkRzQ1BJS2pYaEtmdm9JWk95TDU5L2t5YjVKZmhFN1k0ZHM2Z203?=
 =?utf-8?B?aWxKRUtxTXFnQWU5M09jR1BsUTJGMXJFWXFiaWRkK0lsR1ZUdEJ6Z2o2RTRu?=
 =?utf-8?B?MTYvV010Zk8vRWxWZmM4MG5LaXA4Yjc4TkdYamFyd1VyZlRiWkg4bDNFYVJr?=
 =?utf-8?B?OTRWUUp6dU85c3crMEpNemQyVUhIZ0xYZEgrWkVkVUpqQ2dIQjZDWStoZysx?=
 =?utf-8?B?cU5BTlh4OXhaNDZlSlpWOCtCZlNXakRVamhpMmx5empjUVk4b21ST0JWU0wz?=
 =?utf-8?B?MXFTTWErcEpvdzRPTjliRzZySDlNSU0yeUJiQ2dkNUFFd3hGZEpzNEx5U1JC?=
 =?utf-8?B?TFZTL0Z3WHE4V3FRQnE0K055V0Z0YWVGdExjNTNYZlhWM1QyWGY2QjNDT280?=
 =?utf-8?B?K0tMSnBITFpnOUdybFVRNTZaMHJuNk5RVm1Jb2ZQVllJVVQ5anV4anMyMFB6?=
 =?utf-8?B?T0FxdTFLQlFONTUvY1F2NktiMlZzRlhIRGVxQnliOGo1dGNJeG1Ba2dSWGpm?=
 =?utf-8?B?V3IxeTQ5SVNua0pTOXIrZ0V3WkNaMnU5K2g5U05RcitBOVVqQ0RxOHg5c282?=
 =?utf-8?B?NzBQNTlqdVNtYzErQnBSWEozWWhKZXdkTUZSYURnc0FuNFoxQ2xzaWVsbzEy?=
 =?utf-8?B?YzZCSERQcUhidlZzWjhHNmZjSXJnMUdWK0xOZ1Qrd2xTV3FVZUZ5L0x0VkNm?=
 =?utf-8?B?SDh0Wld0ZkxXSVQ5SXg1NXJ0Rmc3TEI2VlZaSEg4bU9FM01jMC8xYURIaUNj?=
 =?utf-8?B?Y0J2L0x0c1R2SjRNaUFwUXlRRS9DV3dCVG0vZ1FPOGVZbkFHVytia0tETTRH?=
 =?utf-8?B?SERIQ21OT050NlpOejVFVUx1STFzd3plUS9jYVpXb0psZXgwdnBSK2VwV2xv?=
 =?utf-8?B?RGZVU21Ld1FLTmY0amR3MWhTYWZaalFVSmxueWFvdkkvcW96dENyYmVnL2FI?=
 =?utf-8?B?UjZYUFBmYXFEM2tRcVI4Sy95TU5yeXJLUk52U2JNTjlIYVo5ODBUNzJ6OEdT?=
 =?utf-8?B?MlhtQy9Vc1FEdFJOLzVZc2JjYmw3bTU4VEtnbXRKTWxTTXhqMjRoSVNPM0V5?=
 =?utf-8?B?WU1UOVc2SnlneEtjb2NES2lKN2lGQU9HcnR0TjkxZzZQV1RPRTJJOVUzNkpt?=
 =?utf-8?B?OUlvVGlPaVZnM0VKNFcybVlYVGxxTTJYa20wQ09sMkNLTERrM1Eyc1RHUWRB?=
 =?utf-8?B?VEVKSFovc0J3MDNSdWRPdFptVGNpYVMyK09KSkF0ZmgzYVhxN1NmNUU2czVh?=
 =?utf-8?B?aTVGa3NYcWxhZmIwK1VydzNCc01sTVJuRmxha1A0RzF5OG9rNDdvYkpyZjlp?=
 =?utf-8?B?b2s1emdXZFphbDU5YWZOSGMzZGxvOHN4NXIxdFNJdFZMaDQ1ZitsYzZ3amRw?=
 =?utf-8?Q?+91Izm0QCgEk2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXBuVkplK3hyYzVDczB5SkNta3JMMGdHZDF0YXY2R05oMEErcE1HS1ZWMitG?=
 =?utf-8?B?bkZmdWdPUEZJcHllaFFLUFBsa25CdXJJT0praDRLUXBZV3ZQUEV0WTJiOXZU?=
 =?utf-8?B?cDc2TEZCYVBUa0ZkbHlEOGxQbDdDQlM0Tlh2eVFqemk0RWtDTk0yLzdZSWRh?=
 =?utf-8?B?ei9xZ2tvbkZJd1lDd3VrZ3k1RHQrR3lJTUF2aTRLRTdsdklLU05JdGtHbnNV?=
 =?utf-8?B?dHhKTzhYYlNOU3RSelZjZkxwUmZCV3lBcGZUMzdkVjBia05RUUlmSUhzK3NZ?=
 =?utf-8?B?c2RITGtCY1JYTUZCRE1ZRkVrckpaQXo3czd2a2NQWm51WUpJTExwOUsvcFNZ?=
 =?utf-8?B?Y3BXeC9JTnZKVUVIWVNQRnlCOEZTb3g5a0hBTklQM2Z1bHFQemVDOWh0ellK?=
 =?utf-8?B?VkIrQmxuT1B3WVJ4Njc1MXArYnEyQnNESUM4RXkrZWRISGYvekNKa2t3V1pG?=
 =?utf-8?B?RjhqeWphNGlKdmlUYU82aVgxSXJEMHY3OFhOSjlMNG1lNDVCaE5LT3pwSFFv?=
 =?utf-8?B?Z3c4NkZuRGU2dzJ1OFNvQzhaZ3daanJxT3k0LzVYQ1g1YkZLQW53d0FsNTF5?=
 =?utf-8?B?WWdhUVVXUTNPczlyYU5SUmxxWitDb2ZWRjBXeHpHdGx3U1dwVTRja0FFbExl?=
 =?utf-8?B?Mk1NSENNVi9sOTF1c0ZrMmhpNE1WbXAvMEpUR1JNa3RhTDVzM2ZRcFBQYjdT?=
 =?utf-8?B?YXVYU092WTJvWnErTklkZWhOb0R1emVKSnlrR3drU0Q4NHRkOFk4MGJGRXRU?=
 =?utf-8?B?eG91SHBzOURmZWI5ZTZHUlg5UXN3MVNrY2FuTDA3Um9OSjAvblNZaUpML1BJ?=
 =?utf-8?B?V0JXR3BmR2xHZWt1b29wZmZINDVqSm9iRCs3ZmlRQ2wydm5IWkJzbGpCM1ZL?=
 =?utf-8?B?dk5VcjZEQTV1MmxnbEkrakY2ZlphZDYveVBYZzhFbnd0NWJLOGkwejJQUmJ6?=
 =?utf-8?B?RU4vR2ZES0QrSGgzcnZIRzYwYnFkTUpydEZ1WHF5dWFXM3hiek4yc3k1UDkr?=
 =?utf-8?B?TFNoaDMvQTBxc0hkcys5cm9LZVp5WTdlMXJDMmpxeEVJd2dsb3lLNm5wWXhB?=
 =?utf-8?B?TUkvWE44V1hRMGR4T2dMdkQ3eExZT2pnN2JYNFRvUXlCc1ZhTnFMK0RYbkZ6?=
 =?utf-8?B?Ti9DNHFKVTUvZnpad0E1a0hlVi9oOTYzRUdqUE5HSEpSRmhiUlk3b0pHZDN5?=
 =?utf-8?B?TFphMWhEVG9iSkkzdG83cVJVdW4xeC9RNFR0MDBRaHZiN0JYbFBBYndtK3Bn?=
 =?utf-8?B?eElrZWdsRVE2aWtFTWNCOWQ1VVZrbUVmNXZNTGdMaVFqWm9jNURuTE0wV1Bn?=
 =?utf-8?B?SlR3RzBiWTVvNmh6cnl1blEyNjMrTi9vVUMvTks3eXlYVjVVZm52c3NudUYv?=
 =?utf-8?B?TzFmK25aZG5LaDRKQlNqYUNwUEZEbWZzMnhpb0hlbk4weHM0Q1dTVDJuV09U?=
 =?utf-8?B?WHVyb2RUakRMaFdKRXZDS0duSDA5UERoSFkxbHR5S1lkalF1ejJjcXJMTVgx?=
 =?utf-8?B?R1B3emk1TUpkRXVXRkZ6bTN5Zi9WYTFJN1NnUlJVa0taMFpJUUZXZDNTZUVF?=
 =?utf-8?B?UUplZWM3b2I4YjJpVVBpZzArQnhjQmdhdm9TQkgySllTSTFGdGtNeDVHN096?=
 =?utf-8?B?QkpyMnY1aVJPbFB3aS9MZkFWNC9LT3lKTlR5TDluOUxiYmVVS2ZmQUNyWDhs?=
 =?utf-8?B?RGMrNUNqbmFZQ0JVUTR0dEZhMFYzUjJGL2FkS3M0bHVCUmhiRHN6Z1hndXY0?=
 =?utf-8?B?VDkyYWVDYitGZStyOFFhcnJvYmNhNzFyWGRqUW1tSjZXUjVaWklOSWpDVkFz?=
 =?utf-8?B?bE9tMmdZTzNqd3J6YWxidFBsZTY1NGtYK2psbWRndk9DcmNVWUlSTFFlSlQw?=
 =?utf-8?B?UGlGVFRvNVZNeUQvMWJQcTFoTkg1aEJueC9lNnIwdzBGdkR3Um1JOGhMV2g2?=
 =?utf-8?B?ZWRRNlJzajM3NFgydEFNSDg5T2xndnFZUU9YQS9sQVBQL1BGZTh6RjN3VUhN?=
 =?utf-8?B?QTlWREkwVzB3Nmt5MmVFeUFuSVp5MTNtOW0vMDM1UXMrM0g4VTB0WUlkcmFn?=
 =?utf-8?B?L3pFTm8rd0NOVDJ5TnpsSko4YjhtVk5jazd6bUtuNXhCSEFvZHRSaTQwQ09B?=
 =?utf-8?B?N0g0YU9uRmptL2Zvd1dnMGlJRk5EL3pIdlNmM2pndEV6Nk1aeUgzYUtyaHlZ?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc4e149-0bde-45f2-cc52-08dd624907b0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 16:06:35.9141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pb1mO7kaLODbDfpudmpFATyqEcfUhH9CI/WurS0oFbSgu2DKs7u/RcjXb46OpFTZ4XD67lxlePx8FGdYGhjdNaAVezez9r8Fdv3SaJwqCJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11069
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

Hi Tom,

On 3/13/25 5:03 PM, Tom Rini wrote:
> On Thu, Mar 13, 2025 at 11:20:09AM +0100, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 3/12/25 2:00 AM, Tom Rini wrote:
>>> Expand the conditional compilation section to explain when to use
>>> CONFIG_IS_ENABLED rather than IS_ENABLED and provide an example. Next,
>>> note what the PHASE_ macro is supposed to be used for as well.
>>>
>>
>> Ah! Then ignore my comment on Patch 2/3 about the missing CONFIG_IS_ENABLED
>> :)
>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Changes in v2:
>>> - New patch.
>>> ---
>>>    doc/develop/codingstyle.rst | 17 +++++++++++++++++
>>>    1 file changed, 17 insertions(+)
>>>
>>> diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
>>> index 7211e4e4eed1..3303fff165de 100644
>>> --- a/doc/develop/codingstyle.rst
>>> +++ b/doc/develop/codingstyle.rst
>>> @@ -192,6 +192,23 @@ inside the block, and check it for correctness (syntax, types, symbol
>>>    references, etc).  Thus, you still have to use an #ifdef if the code inside the
>>>    block references symbols that will not exist if the condition is not met.
>>> +In the case where a symbol may be referenced with an xPL-specific Kconfig
>>
>> Please provide some information about what xPL means (maybe a link to
>> somewhere it's already explained? doc/develop/init.rst:Board Initialisation
>> Flow could be a start? Or maybe rather doc/develop/spl.rst which seems to
>> better match what this is referring to?
> 
> A problem is that, ah yes, doc/develop/spl.rst exists but needs to be
> renamed to xpl.rst and expanded on too. How about for this patch I
> change this to something like:
> 
> When working with xPL (see :doc:`spl` for more information) we need to
> take further care to use the right macro. In the case where a symbol may
> be referenced with an xPL-specific Kconfig...
> 

Ack.

> And in a follow-up patch start addressing spl.rst. And that may get
> slightly blocked on splitting out the patch that allows the HTML code to
> have redirects automatically. I figured that out for the pytest docs
> RFC, so it's just a matter of making that part standalone and posting
> it, I know how to do it.
> 

Not sure what's the issue with the HTML code you're talking about but I 
have a hunch I'm going to figure this out with the soon-to-be-posted 
patch :)

>>> +symbol, use the CONFIG_IS_ENABLED macro instead, in a similar manner:
>>> +
>>> +.. code-block:: c
>>> +
>>> +	if (CONIG_IS_ENABLED(SOMETHING)) {
>>> +		...
>>> +	}
>>> +
>>> +When dealing with a Kconfig symbol that has both a normal name and one or more
>>> +xPL-prefixed names, the Makefile needs special consideration as well. The
>>> +PHASE\_ macro helps us in this situation thusly:
>>> +
>>> +.. code-block:: make
>>> +
>>> +        obj-$(CONFIG_$(PHASE_)SOMETHING) += something.o
>>> +
>>
>> Please highlight non-English words with double tick quotes, that also remove
>> the need to escape special characters like _, e.g.
>>
>> ``PHASE_``
>>
>> Looks good to me otherwise,
> 
> OK, will do.
> 

Depends if you want to keep the import from the kernel verbatim without 
adding tick quotes and all, then I guess consistency will be better and 
just not have tick quotes at all?

Up to you.

Cheers,
Quentin
