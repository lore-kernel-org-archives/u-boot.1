Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95B0CFD36C
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 02:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FCA983F2B;
	Tue, 25 Nov 2025 03:43:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="X8lbfevZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2287983F2D; Tue, 25 Nov 2025 03:43:32 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9DA583EAE
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 03:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wb8F7MpDRMg9408d6lWJghqLUytgo7DPAxhUodDAthFNnQY6NTIDTP1uuH5HP0t8ctHaJXwGmq0zW38eg9d+/MrsgfQLqUG8fl7TTM2hO2k+gkpxrXGgWmJyQIov97Q/XUV49L0E7f9Os2Px3WLD/z/tl+o/UfBjWphTiDrDRgzRpPwAYS/nmgCWdRv3efG5tm5d+hRcMO+qZPLj4a9OJ66XQ7RJjsed0tP7p38qcufFdoOeBhOVUk0UpzRm91h9X9eqxvcwoyScVlL1SjLbC9/rxeTwg8M3Te12jGmyykzeI0ZFmJ9SjWJEu5bbAnEbrPiKOwY6PF/ZB8qGa/W5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSmhzhD2KnhiDFHqtUa6GSBwu8vywfXZk64croFeK2U=;
 b=HIRm1vYcCEpTkFwgkaKwcfo36RDU5Lhw/NtV+LtlWSmANG8hXHNxPKyE6ZVpr1pMAEVDpUrs0xuwsxHFGReakBPdE7OOcJ+/1DDX+T3aWGmDlc2a14fUxlvkB/HmhDC3y4BVVKQgw9qKd1bDBLwaqcGii6Jd8uEO/vV6jHu2WDRPvqjPaVYMBfNeLoQOTdwcvSeSYAr1Pg0DKQPqfOVxm3fdNCq0INkKFynn96vQb5fQXsQAvr6P+5VKZLXljYFdo/niYx/m7vcuIppbgs75wXkuqLeUYqMjnGlH3Ms8VKpDsB+lzXqua4cRh7nP640E9SJBfjQJhmjLSnSgcA45Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSmhzhD2KnhiDFHqtUa6GSBwu8vywfXZk64croFeK2U=;
 b=X8lbfevZMoGpP2nsZ7iBpfo1r2IoxCzj+pEAw8tseSG/70UbWqQAcQgWGjbc82B1gLWTSVyoBLUeeBTcYNOn7DuCxsYI1Ocqhb2B58TyVH6/jGxtWlW48VSZRuApVGh5x7gtZSg8+thY4imELbIMeM7mw14M9cgUj2sZuAjglCOJZCSzT9aVSrg+sYP1fxBljShH2gkp5H48NMvpjHR4w/KVwNJ+csQr4sln7Iuzz+TQRMoM+ql2+CLaHmNJL83Ah2ZoDeQquKJSlYAfxnLUXAfgIL42VKHV/fLcYtUNn0gIKg0PnYp/JcsN+6u+XJ95NLhr9tsorSwnJX1rDXyU7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH7PR03MB7906.namprd03.prod.outlook.com (2603:10b6:610:24c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 02:43:25 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9343.011; Tue, 25 Nov 2025
 02:43:25 +0000
Message-ID: <574382cf-fb6c-4e07-8dab-a70fe9f14689@altera.com>
Date: Tue, 25 Nov 2025 10:43:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Altera SoCFpga Boot Stall Fix
To: Brian Sune <briansune@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251114160423.1518-1-briansune@gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251114160423.1518-1-briansune@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:4:7c::19) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|CH7PR03MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fedd645-9114-41bd-e700-08de2bcc67e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1ZhMHlCMWVHbHJuVDV4a2U4NjExb1lEQkpsSEx6cTkvUm1MNXM1SU9tTGpG?=
 =?utf-8?B?cUlkZm1vT2pnZVdIeFNESGJiL2c0U0xIYW90KytGZHRJSWdlOUFsZUJjczJ0?=
 =?utf-8?B?WmpCaVBPakNhUzQrNTVBOWVFemUxbkd5dVNoZkF0S1Y5Si8zSjJreHQ4M01t?=
 =?utf-8?B?NStlYjdPQjB6aTRUVnVRQ3I1eW8reTJzaVMybDc5VU9iZXBFSWNlUWlPZ3BF?=
 =?utf-8?B?TnpvZVI4L3dzVmV3ZVBOUEdzbUFXUFBEekNEZFlCR1pTQ0ErVHZvWVE5VHF0?=
 =?utf-8?B?S0d3ZW5kbHViVWIzRlNCUXBFQmdMK3BvU1VDcUtWNER6cUpTVEdZRnYraDJq?=
 =?utf-8?B?eXJZTklSTzV3NHBoaUpBNE11UlpEUDk0ZnlRTGJGaTgwUlNqQzRFRVRnSk1Q?=
 =?utf-8?B?SG9EZXpsYjlxNzBLZmJXcU1XRnFWK0UxaXlVSWJrbzlIQTFBU2dnMUZHZEhr?=
 =?utf-8?B?eUhtZmtYeXB3blNPSWV5azI4OWoweDMrUC85NGpkTnZ1My9ZV1ZuRDB1SnVS?=
 =?utf-8?B?V0FOZGZEZ3ZRYTlZN3o1aCtERXdXK01kekFSMXhnQkZuTGFzbGVyT24rV0ZI?=
 =?utf-8?B?VlQ2bU5jZlJhcTZFRlVxV1gxbXpYV3B6SlA0cExSNlpHV3ltRTRmOXNWQ2Nq?=
 =?utf-8?B?NHJoTWt3Vkh5MlcyQnR2RWw5V3F4QXVYdnVZUzVKQStERER2TWZzMVhLNHhx?=
 =?utf-8?B?VGNlaGV3NGpsZ1ZLd0hLMTNuR3FOV2lDdXF5cTRWdmpFcXlJQTN1djlTRUZW?=
 =?utf-8?B?YXlCMEdUQWxyWnQwSzc1TzFTMmRSKzcvZnZPSGlZMHBqU1JUa2ZGM0JuZlp3?=
 =?utf-8?B?dlBYS2ljUndFRGZTTlB1bDMvUXhTaXl3d096N0FsU3lMM09KMXZNcTg1OTJU?=
 =?utf-8?B?UFZ1Ri9XeHYvSlhKeUpGT3FzVk9jMVVpWGdqKzN3MkhJM01RSDRPRUc3S2FS?=
 =?utf-8?B?b09XMVF3aWhEcVpkb3JtamZQMmhEai83Vm0vYW5EbkRKYlVLNHowcE9sN1My?=
 =?utf-8?B?MGJEanpSaE1ZNkNxQnZjQkdOTFhpTEtOTjBBTm1Gd0tadzRVcTRvZ0c3NTdl?=
 =?utf-8?B?WVhaRW9ueVhhZUtBT3BGemRHQmFyWGpmMFVFbG01dEpZcENvL0YrWXhlcGVU?=
 =?utf-8?B?NGNvM1IyTHg2UXhrUHhwUDVHdm5LcEt3VkUxNWxLSXhySFFBWXM2S3pwcXFs?=
 =?utf-8?B?cmpBSWN1dG80bzRUbUNyYXEyM0RwdDJrbWhpTEkxWTFaZEdLelNKaEN6UXpY?=
 =?utf-8?B?TkVEUjFGRWRKTTNnYmpmQVdDYk9yN3FKbGNSdkpFdDgrOXlrMmpFSEtjb1Nw?=
 =?utf-8?B?TGVTaUV3OVpZS0gxcDlmZmkxajk1dE9nSVRrSVBxc3lYQUZwTFM5ZlJOSG1X?=
 =?utf-8?B?VGhUcDlzTU1WQThGZDRrb3pvYTBSbStMQ2E5NWtmVWd4aVlNSGFPVEdPeXQ3?=
 =?utf-8?B?ZDB0Uy9QWXhGbHYvRXpTeFdGL3Fhc1ExUkhRZGJaK1R1OC93QnFFVXlHNmJo?=
 =?utf-8?B?dERUbVBOaStjeHY0SXFEZkdqSUFBVjE1WVJMaXI2M1VETndNUVd0bmJDOVZz?=
 =?utf-8?B?cWZ0c3BNNlVQcklEMXU3dWRCSWIvV1dRbjNxaDZaNHhYa3NtemJNVDJhQ3Br?=
 =?utf-8?B?V1FlQVU5WTZtOUE3NmxBNWc5Y2pyckFDd0l4N2cwbWpPYzg5RkdqUjVWNUdG?=
 =?utf-8?B?NUpOdVFUSGpvUVNFekNsUkVXdmo1ekRlTU85TGl3YmdIeEt3dDVIMk9rSEFi?=
 =?utf-8?B?SDBVZ0lJa1A5cEJIT1BnV09vWDBEVjEvUDUwb25ZK1BCYkQ4djBIeW1FaUhx?=
 =?utf-8?B?UW5yQUo1ekQyQ2QwVk9BeFh5b2ZDWjJPVmZLdks2R3lLNTJWcFJXanMyYzRL?=
 =?utf-8?B?c0NFKy9MRkFBc3VWTEpXL05sMHI5UTc0MFp6TWRYQUo2ZUlMS0lsVGhkQlZu?=
 =?utf-8?Q?qdbrM+lXVINMmUqi6RtxeL70kGTWFw/6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVB2dkNVcjg4ZUtTZzJJTVQ4a0tOK1g5YXVqTHEvMEtmUG5hbE9RYjdBUTJR?=
 =?utf-8?B?Rit5eVU2U2svWmJmUDJ6b1Q0Tm5KWElWN3I5bW5GcEQyOWlKMXdVeXg4MnRh?=
 =?utf-8?B?WVJGdGpjVmFoUFliWkRERWhTck5FOUt3bVV3dXVDb05GUnZaZk5GbDdjWTVp?=
 =?utf-8?B?eERRY21XRnQwYUlJdGNmSmVWb3E0NFhjNEJoeWszV0MzMmwwcHROSlZ3c2dX?=
 =?utf-8?B?RjRmNGwxTURFWW5GOW5GQTJsSlVLMEgxOTNnZDhwTiswK2pyNi9hZmVZWmZr?=
 =?utf-8?B?cEU0c2dJbTd3cFZrb2tuNlZrRjZkYTc5MEsrR3pTOWlETWVmbjB3UitOaEZu?=
 =?utf-8?B?cjUvNi80Vy9sMDlxcS9qRnlkc1RTc1lTQUdzZXR5RlU0NWJtbG1zT3l3UXUv?=
 =?utf-8?B?MnlFZEZKYUZPY0srSWRBZlBPRWJROHJGRmh3bGZhK1ljVmlyUUViTmlYVVlu?=
 =?utf-8?B?VWxsVUk2YjFQaE52VHpabHE5RlQvSDgvVEMzK3B0NjB5N0VjYkxjdTZEWDNv?=
 =?utf-8?B?dXBSQ1JLRjQ1RzNsUmdqalpvaU55MGdrQzNFSkExMVFrQm1VNWxWZUQvZk5m?=
 =?utf-8?B?Nzk4c2dpMlM0TXhtcnpScWpNMmxQR212cmwrVmhGVjUwTXkyQWM2RTVzemJw?=
 =?utf-8?B?VGV5alNWcTJmejQzOWd1YU55OFRoUHoxWFFhWjRkMnZQZGh6bmFzMTcvSHUv?=
 =?utf-8?B?VktsUzV6dGlWdGxKYTNFVkZRcTdmdkpLaWh4bzlMWjhja2xheFhQOEVQbkVN?=
 =?utf-8?B?SERKZDk2Z2d2OWJoOXplUFlzOHJXSTdaNTJLQnlZaWZwbzgyRlNXdUJuMWlR?=
 =?utf-8?B?S2t1cnk0VnVvUHNHN28rUVg0TG9lS2xvUVNIQlIzUWR3MVZsNzdTSzhlay8z?=
 =?utf-8?B?R0w5UGg1K21NWGhkWTFoRjltUDJ6YlpiS09yeTJDWE4wSnlmME1yQyswWWI0?=
 =?utf-8?B?S2F6Z214MmQ0U2VHUGhSd1ZSZkV3WTZPY3lyUHlrQVJ4cGU0YTJhSVB5NGd1?=
 =?utf-8?B?R1MyaE1lYzZDSDFYM1g1c2FBN01aalVod0lUNEZmSDJNSklYRkhhZnRVZ083?=
 =?utf-8?B?QUtYQ0NrZXZzSWxTdURKL0pSWnI4dUZFMWxCZWQycnhWeWViU1pjeElWYW9N?=
 =?utf-8?B?UVdEOUlFbTJUa2pSZUorRnMzbS9tMU40NUF3M0NxRTEyYk1aY2VJYWw3bFJu?=
 =?utf-8?B?cXdCSUl4OVo0T1hiM0lTcU93cWQ5cVJ1WjlFckR4L2t1L1dobXdZVHFldnhk?=
 =?utf-8?B?ZG5XSUVBWTI2aVlFOVRja3c5bEo1RDRTeTdNdW9wR2FzOGU4U2VnS2N2R2Nk?=
 =?utf-8?B?MGRaSWlhdFFKbjU2bnBGNkw2THBia244NGZaMy9CVlBWZElMZGlMSkhqM3Ja?=
 =?utf-8?B?R3Z5V0d5UEljVE0vMVNKSVVaNGZscGlYeXV1Yzg2azhBK2ZmRU1Eb29yU28y?=
 =?utf-8?B?NFltdi9NK296cGJTaFlabGJsTE9jRlFmdWs2MjRvdUhhTlBsNHBmT0IxSlpk?=
 =?utf-8?B?MUFHVHFRb3Q1dG5Fc3h6WUxZVDkzUWhlTDUzUXQ2QTY1cVZtNmxOM3VXT25q?=
 =?utf-8?B?WXhpdHljQkQwa2FtTUpySUlRVUVmWGFIS0tyMm4wZmo0OUN5VUNEQS8rdmRJ?=
 =?utf-8?B?cmNaVFIrQ0w5TDJuRFlhTTdKeVZwYkxzT2RkcGp2RXg2T2dzdlJZVVB4bDkr?=
 =?utf-8?B?YzZFZURFU3BYQmNoODBDTjJzRG1HZ0tYTGo4a2dwdFR0Q21TNVFRT2ZUWXh5?=
 =?utf-8?B?dXpTSFpZUVc4SjVvNW5lV2trV0NFUnVkVS94dFd0MU5CWlQ4KzYwbC9sajA1?=
 =?utf-8?B?cjg1RUZmYlJOM1l2a2s4ckVra3ppWUlxOUlCdzl5UWl0SXNQRkV5ODV1cytp?=
 =?utf-8?B?eHliem9ZT3hlYmdkOU5oV1hncGcrNlpjSjlvbUtsVzVnem04aUEwL0hQeFEx?=
 =?utf-8?B?ak9kVTBsc3M1SE1uNjBsQUY1QlRGU1lHR2tuVkExSTlQRWIzZFFpQ3BVVU5l?=
 =?utf-8?B?cjU3dnNQVXZKZWluZE9nZWJGMjYvVlhTaytBUFVxdlpENVBtS2lyMEJxVHRK?=
 =?utf-8?B?M1d2U2dVQVpUV2tlTSt4Rjl2TUdEY1RVcFJqTElhdDVob3JwcUlHLzFJM3BK?=
 =?utf-8?B?S0V3Q041WXZpaDZ6eUdTMkRnSm50aXZhOXZqcmdVV3krWXJmZ2lnd3grUURV?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fedd645-9114-41bd-e700-08de2bcc67e9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 02:43:25.4199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYDlgSs0Z15dG7CKIpkprhvTqxd1k+q2u8ShqoAOmXiLz7lnkknLjyTp8HUDYfpEhaVdrJL5/fp4tf45PHsj9w3tEfnsv88YA6EEsNlXy1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7906
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


On 15/11/2025 12:04 am, Brian Sune wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> Since U-Boot 2025.07 pure SD Card
> boot no longer works. Now Altera released 2025.07
> shows the different on the u-boot files.
> After testing, the major root case is
> get_managers_addr. And this patch fix the
> SD boot stall via pulling from offical.
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>   arch/arm/mach-socfpga/misc.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
> index 76747c2196a..07694107c8a 100644
> --- a/arch/arm/mach-socfpga/misc.c
> +++ b/arch/arm/mach-socfpga/misc.c
> @@ -222,7 +222,7 @@ static int do_bridge(struct cmd_tbl *cmdtp, int flag, int argc,
>   }
>
>   U_BOOT_CMD(bridge, 3, 1, do_bridge,
> -          "SoCFPGA HPS FPGA bridge control",
> +          "GEN5 SoCFPGA HPS FPGA bridge control",
>             "enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
>             "bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
>             ""
> @@ -261,7 +261,16 @@ void socfpga_get_managers_addr(void)
>          if (ret)
>                  hang();
>
> -       else if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X))
> +       if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
> +           !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M) &&
> +           !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)) {
> +               ret = socfpga_get_base_addr("altr,sys-mgr",
> +                                           &socfpga_sysmgr_base);
> +               if (ret)
> +                       hang();
> +       }
> +
> +       if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X))
>                  ret = socfpga_get_base_addr("intel,n5x-clkmgr",
>                                              &socfpga_clkmgr_base);
>          else if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
> --
> 2.34.1


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong



>
