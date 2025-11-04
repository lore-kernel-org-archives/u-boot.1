Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5106FCCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 17:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C62E8835B3;
	Tue,  4 Nov 2025 18:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="bdYqVGm2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7175B835FE; Tue,  4 Nov 2025 18:05:51 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC928003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 18:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJPAhrFhooqsWkirG4wWLCux/xuEHLoKo4TDeMt1FOD0ooQB/8rsZjfRIIbLSHrBorG0LSNmGDMhwLxOrnySWYmbfROZoaO2VqmOGZYBCv6zg+JOWle1MfJBanL49KM3BL9EO3e5uihYwAsk7WrWZT+1c60PSjUYqGp0nMntn8NP6G/JYZk78YJ2zCEXDWywqtKEDNEVVC81YEUUv+9wHQwOJ8z2KC9P9cRNKq+kB5mUHWgCqWya2zPBOqTO7o4Ynx3cEW5wCyIZdGg6rG5GJplYZM8AduVDPnSPddZga40Fogw+W5YyjAzuN4mC2JJqIKcAeAYAcgz/DSe5NzqbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=140ZzCBnywXt6FauH6osqGLy5817UY7bLRSQ5Zi8+hY=;
 b=pHFP8f/2iXSlYKKiR7l3w3zLZZbcnjmYXfwbBIKq3+u3eEXITSPhpyfbbqqdWmJ9LJ6i4dGsTRAy2WqFsiRCBOMKwpzFBNF3LN5FOXfopRntIb330/BnYagDeV4fDXPM6gQe74Nqr9jJpdju9dz1KFBLrNpvG5LEyP1tUzkXAmMH34nQ7oQsX2FSy5llnuL40fC+9ZGQy9fuAY047GDdh8CmJOaZCvse5/UP1myxwJWuZgSv0oNn857uqOdyQS2lCc3J30aH7mTvXH6TL8d39056pXVGDBCtberEnn9Vv8zKj8TL4BAVBVwD9v1aZeQkIxHCrlT3jne61PS+jd8J8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=140ZzCBnywXt6FauH6osqGLy5817UY7bLRSQ5Zi8+hY=;
 b=bdYqVGm25/TRepNd4E1wi/XYQfcJ1m4YVc8B58n2l1cGyiLA3guTDsS5tfDqRYFMC6MbPvKJCyFyF0v4yvnpvRWzRc2YAzGgBgfBVgWx2Lp/ejq7403d1O9pFnfc5JPg1+rS26xZSbVwPQhvPNwutYmSDkjPNZEU/myTVQ4uf7Uy9sap08mRGfnut3tQfHmFJoqMbVoFApLNuD0ZGwvGpBJsQ3P3k9skuEU6jLW1ZNsBg9dt+kNt6Djk6KRUt2vwhTEV1d+7nHGC8IFA3ulZoBW0AAJ0RCnKbKSu1ms1mLWkaPjoJP09kvAnRzBPFE9NsFNF+8dsjluf5xm/7s3/lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AM9P195MB1029.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 17:05:47 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%2]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 17:05:47 +0000
Message-ID: <11e9ea35-1dc9-42ae-8059-a7f5eca7e0b7@phytec.de>
Date: Tue, 4 Nov 2025 19:05:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm: mach-k3: Rework spl/get_boot_device()
To: Andrew Davis <afd@ti.com>, trini@konsulko.com, n-francis@ti.com,
 s-k6@ti.com, anshuld@ti.com, bb@ti.com, ggiordano@phytec.com, b-padhi@ti.com
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20251104152459.3648004-1-w.egorov@phytec.de>
 <20251104152459.3648004-2-w.egorov@phytec.de>
 <bf5c3446-7ce2-4835-b005-52e1b1b677ba@ti.com>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <bf5c3446-7ce2-4835-b005-52e1b1b677ba@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0060.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::49) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AM9P195MB1029:EE_
X-MS-Office365-Filtering-Correlation-Id: 9018230c-2a4c-484a-e835-08de1bc46602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUhla0VTWkt6L2UxMGQ0VDFGYmtkazhYQnVJVGhQSVNBc3BKZ1dibVVYWUlM?=
 =?utf-8?B?cEZ1czNKTklla1B6U0FXMkc4SGl2WmU5UVhCMnlYQnh1WitIOHFXcUNYaGVv?=
 =?utf-8?B?WDZYTTB5RGk1WGJkclBPTDA1YTZZWncrU2pPbk4vNjVvODcxWjcySTRvbitj?=
 =?utf-8?B?eldPK0JhR00xOVNIbkk1cUhaYzZIY2RFTHNUekorNGVpenQ1dURDSHU4N2dX?=
 =?utf-8?B?VnBhQ3M5NTh5OEp4WVRmYWJuRkdYek9xTE1FaDhqQXNVNGtYK1JWdGI5WjNX?=
 =?utf-8?B?ckNFRUhkTjBrZkhaVFpNNDc3WjR0K2lYQUNxZG5oUWxuVERGbGdmMGxkcTcv?=
 =?utf-8?B?a3FGZWkra1pqVDlJZGFEcDB3YmNGcFI0UXlKaklQVWhZZ3BZMGdyRjIzSWY1?=
 =?utf-8?B?ajJuZXNaOWZaYXNLeDdIcXV5dWFXM1VMVDh3Vk9oMTZ6TDJmYjFZb3dCajFi?=
 =?utf-8?B?UWFYbFRiVm5ERzFRcERZYm9wK0VpdDUzQkNGeXNiUlpiL2pEQTgvaDZ5M3Fp?=
 =?utf-8?B?WFhhazRBeHlVRUVqUVhxb2VNaDk4aWNpWmhjMjhZWUJ0MHJGdU1helM4WUJv?=
 =?utf-8?B?WUZOdjlQUE94Z0hTZWxWN2lTbXNwYTlhRlduV0VCQTkzSFJJR2pQYk9rY1lk?=
 =?utf-8?B?TStTalZ5dU5ZK0ZGWTBLdGRPaExDazZTc3RYSC81MmI1c2xPbjJ2QWxnMjFw?=
 =?utf-8?B?cGNhbFgwNTV5NW92bGdvekRGTmRGaW1RREtjczRYc3lMK01CZ3poWWZSQm51?=
 =?utf-8?B?MnVlL2JOR0JoT2pkdVFXcVI3cUYwWGVFSVVjM0VkTVlDaFp3VXVMQkdyM2JF?=
 =?utf-8?B?Y3hxbEV6Uk9maXdldndqNDBrNkMydm9BcEMvVFFpSXV0UkRNU2lHSU1OTVZ0?=
 =?utf-8?B?VGJFU1NDWFhpTEtVRHpxOXNLYUpXRzMvdW5YTExXWXhwaUhITUNUUUprTnEz?=
 =?utf-8?B?SWlGRFlxYkt5MXZxT3VPY25Ba0R3NDB3ZkcrTzNIbW1kNDE4Y2s5cEg4akVn?=
 =?utf-8?B?b3NSem9ZZjFUQlExMnpWdzJFaHBPNVllRXp0dUlFdHZXREIxSUtqdS9JZnhk?=
 =?utf-8?B?ZWRtN1QvOWd2T2lsOFJ3aGNrMHVOV1JqSWp4TVVSUWV3aC9FbzBvSEhXMy9O?=
 =?utf-8?B?YnRXVjVZc3lsZFdDUEw3NTROM3huaHdwZTVTaEc0dXZmczkxSW05aWl0ZzVO?=
 =?utf-8?B?S2FLdzdXV01OZTN0QlFFdWtiTlF1a2IzYkhMZlkzY1ZKNXYvc3hKaEVqN0hy?=
 =?utf-8?B?UitFYVlWeEtXNWJvS0RpSDYrcXlHM0ZqVXMwdllYR0hXaTduWXU5Uk5QdkpM?=
 =?utf-8?B?bkE3YnQvSGNhc2JCWi9lc2R2SXdXU2ZoTkExejNIb2NEUzB3cDR4a0pCdnN5?=
 =?utf-8?B?Ti8vZkpyRWxUanVPbDFPSWx1Mkw2Q0NsUHlhQVYwcm5TdXhxdkhpQUlsd2p1?=
 =?utf-8?B?K0VRMUd3OW5BdS84ZUFYbGluTW5JQkpqMVZxUTMwZVh0MC9jdmhSY20zenRV?=
 =?utf-8?B?NjkyNXdwaGhyTHpRajZVNkF0dFh6UjF3NlJSZlU3N09uVkpteG1nMGp2bTQ1?=
 =?utf-8?B?K21NWEs4VzBXTDVkZkFUbElhWktLZk9QQUdHWWM1cEdBM1ZNOWdYWHFZN2xs?=
 =?utf-8?B?QjFnOFo1NVk4SDEzRDE0aWtSaUtUcXNHVzdzc3RFdWxvMzdYdWpFc3d5cm9U?=
 =?utf-8?B?Q2tnVXhydmhub1JqWTQ3M3RRQUJuV2JqNGZhd1Z1KzJxMkRvSVJKcEQ2UFFK?=
 =?utf-8?B?TzFqVnI0b1oyb21rTWxtQlhJNGdxMU9zcllVY1hWZG84Uk1ZMWZEenRycnEy?=
 =?utf-8?B?bUFEWit0dHFIci9mcm9TNE1qVEx2cldrcENrWXdYUWowTHdNSEVSMlFJNnBr?=
 =?utf-8?B?Slk4VXdJZG9TQmx2c0xuQWtmeHlpNE5paTdmVXRRVmI0SXpLWVEvSDVxaFdq?=
 =?utf-8?Q?FsDjWJvGyp0DJ8BJPwwHpTIF/tu3VdlS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk5kZ1M2VHpmdHdmbHpTRzhwbGUyS2l5N0JXZG9ySlJJaVlXRWZkTkMwTzEy?=
 =?utf-8?B?RVk5eTNaWXJRWjRxOTlDZmdpU0lmV3E4K1BMUXM2UFZEbGxPSlpPZEg2aTNz?=
 =?utf-8?B?RXkzaXZpTG5HcWZQZnNJNnpjWDRPRzJFTVZ1eUpZRFFqcU1TZWpKTFljcVF6?=
 =?utf-8?B?SDhXazk3cDBocFgzOUFPaGJWWXhhWG9pR3B3c1dIbVBhTktWQlUvNGtrUmlC?=
 =?utf-8?B?bTVkVnRmTFhjQzRXNW5HeFFqYnVXdGhqbXlHSVZPbEV2OHQwVTkwNXVaa0M0?=
 =?utf-8?B?MkpodkZPRjZxSFB5VTNYSkpMaXFaV2pnbkE0VEoyREVFR0FHeDlrQ1VWazFY?=
 =?utf-8?B?bEVSR0JoVWpQcmlqSkhpdG8rbDZtdlp0d04weS9PTzV3S1kwZUhWRUkxd1JL?=
 =?utf-8?B?ZUE4TmNhTDQyQUpwZStUeUxEb1B5SmRvL3A3UUhUeDZQdHcyYk5SaGNaMGxI?=
 =?utf-8?B?NmRqMk43VHliL0JyNWYyVFU3ZWFLT0tZRFJHV0lxbEVmbFFLdEYyaUpwTDhG?=
 =?utf-8?B?elhaaTBvTlBHeFV3SFRwZWtwaWMxZDA1NXFHSUd2eThMS2RQNnBUVVQ1NFp0?=
 =?utf-8?B?ajR0VmwzTFI5clkwdU81UGZUZmtlTklXSDZzbFNQWnl0V2QzVHh1a2lwRHdF?=
 =?utf-8?B?Zm8vQTlKd3NoS3JQVmZJbGRJMmFiUlNyMEhhTHlNVVFLR3dxSFBYeHZYTmVP?=
 =?utf-8?B?eDR5ZVhuL0l0OUEvT2liRWVXSkc5Zk10QVFIbURaQllPQ3Y2K09jRDFDYWY3?=
 =?utf-8?B?Z1lvT0pMb25WcEtUdVRqaDI2ck1RMjhuREJjRHp5RVVrTFhLckQ1RG9veDZl?=
 =?utf-8?B?NlovdmdMSGM1SnNKNEExUHczcXE2ZFV2SFZubzJ1SUpDTjZ5QldSSExaWVRS?=
 =?utf-8?B?cmFYdjJRRFZiMXdrcGE2dmd2aHpMSFRwanZUK3hXbnErOUkyZmRHYmVFWXkv?=
 =?utf-8?B?UFVGUkFiK0Eya3V5U25nS3VyTXp1bXM3aUhOeTNLWmp2MEpwMGhPbXJjejVL?=
 =?utf-8?B?N1JPU3NlVWxxekkzSGtpS2RWNVA0Vyszbk9vZUdiK3Bic3JScm0yWjhYN3Yz?=
 =?utf-8?B?a1l5L1dnS1VZekYrM0hhU1JHUStMajdERWgxcG81b2RJK2FhMStTdDRZV29v?=
 =?utf-8?B?MStveURXMG9LTnN0MEtmNDM2NVo2SzdBenlIbmhPUUJHcXRiUmI5R2ZNOUhI?=
 =?utf-8?B?MlVuUXI4Qkp0Qnpacm9MZHpDWVRDbkE4ejNzcXdJVVNUMHFCSWxmSkZMU091?=
 =?utf-8?B?NmdYL0dXVW1aT2U0Q1VWanhUa0lkQUFqMzFhM0xWR3crOGVZRFNZMnVTdnNN?=
 =?utf-8?B?V0JtM3lTWFVwdlAyUXlSbXpRSXA4dlRYTXNTMXhpQzZlUzBxVmk4SlBWZERT?=
 =?utf-8?B?bzI0YmM2c0J1SDljbTM5NjVyaE5iVVJsNUVGL3dBK3g2aThVT0V2dDhhMG9V?=
 =?utf-8?B?cnZPVXA0VEh1OHRCREZ0b0dRSjhuc0pRMlFTdnlVeWZmaXMyOTMxTkZkR3Y4?=
 =?utf-8?B?QnpGS09lM0FvalU4VThFNnhac3NrV295Y0FuWXh1UEhOS2MwU2hTNS94enIz?=
 =?utf-8?B?a2xHQnpReFl6eElENDZPNlVZRXF4c2QzS1cwZEIrbHFmRlllaFpza1pad2ZJ?=
 =?utf-8?B?ODk2RWhpS0lzam51b28ybHp2NnY0WUxleDhFSHAvSzFxMDdHVkZSWGg1QnNU?=
 =?utf-8?B?eDJ4N1Jib2NOQU8wdVo4a2NTSE1xOHZMN0tHU2JBWmF4R2VYU1ZkQkd2SkJw?=
 =?utf-8?B?bEFjNHlUQ3hxWVFIUDVIS3dNbHo5NnBtZXpYam1GYUdVc05pMzYwU1dJb3Z6?=
 =?utf-8?B?dnNyOEJYRUxEa1JVR2h4eVlPcFVxNGoyZjZpSSttUE5ENmN6VGtybEwydXdO?=
 =?utf-8?B?V0ZyVlhYV3IzNVdqSHJMY2xhWWNXaFhzRWpzWlc4MC9aaE8vUGxNN3dlZUlH?=
 =?utf-8?B?eXNyUzhDdSt4ZmtCNkZiZU5pUmMvR2RuQWtDZHZQMmtrT1poUXAvRTdLQnhR?=
 =?utf-8?B?K3ZLNHF4aFVodUZMNnNjM1poYTV3Rm1GWVk1YUkwck1QQ3VGM0Z1eG1YQVNH?=
 =?utf-8?B?TWxlcmV0QS8zMjZ0UVJIV0xjYVZGbWptZmw5KzUxT2ZGVEF6WDI2Qjd6cXFP?=
 =?utf-8?Q?G5qJAou+AtxOTiN9qiR08X4gK?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9018230c-2a4c-484a-e835-08de1bc46602
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:05:47.3877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpMWMEB7Q2UyTYqHvS97rdXe6KDgqzH11wUW8S5a3/4+ZFTWLq30G+kB9gAmvy6C2IzaeliC6IBJuui5EQeLGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1029
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



On 11/4/25 6:41 PM, Andrew Davis wrote:
> On 11/4/25 9:24 AM, Wadim Egorov wrote:
>> Introduce a shared boot-device helper that translates DEVSTAT boot
>> modes via SoC-specific lookup tables. This replaces the per SoC
>> get_boot_device()/get_*_bootmedia() implementations and centralizes
>> the logic in boot-device.c while keeping the mapping data SoC-owned.
>>
>> Start with am62x as a reference implementation.
>>
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>> Acked-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>   arch/arm/mach-k3/Makefile      |   2 +-
>>   arch/arm/mach-k3/am62x/boot.c  | 141 ++++++++++-----------------------
>>   arch/arm/mach-k3/boot-device.c |  90 +++++++++++++++++++++
>>   arch/arm/mach-k3/boot-device.h |  41 ++++++++++
>>   4 files changed, 175 insertions(+), 99 deletions(-)
>>   create mode 100644 arch/arm/mach-k3/boot-device.c
>>   create mode 100644 arch/arm/mach-k3/boot-device.h
>>
>> diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
>> index b2fd5810b67..7dc77328e5c 100644
>> --- a/arch/arm/mach-k3/Makefile
>> +++ b/arch/arm/mach-k3/Makefile
>> @@ -6,7 +6,7 @@
>>   obj-$(CONFIG_ARM64) += arm64/
>>   obj-$(CONFIG_CPU_V7R) += r5/
>>   obj-$(CONFIG_OF_LIBFDT) += common_fdt.o
>> -obj-y += common.o security.o k3-ddr.o
>> +obj-y += common.o security.o k3-ddr.o boot-device.o
>>   obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
>>   obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
>>   obj-$(CONFIG_SOC_K3_AM625) += am62x/
>> diff --git a/arch/arm/mach-k3/am62x/boot.c b/arch/arm/mach-k3/am62x/ 
>> boot.c
>> index a3a6cda6bdb..06bd04da99f 100644
>> --- a/arch/arm/mach-k3/am62x/boot.c
>> +++ b/arch/arm/mach-k3/am62x/boot.c
>> @@ -3,104 +3,7 @@
>>   #include <asm/arch/hardware.h>
>>   #include <asm/arch/am62_spl.h>
>> -static u32 __get_backup_bootmedia(u32 devstat)
>> -{
>> -    u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
>> -                MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
>> -    u32 bkup_bootmode_cfg =
>> -            (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
>> -                MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
>> -
>> -    switch (bkup_bootmode) {
>> -    case BACKUP_BOOT_DEVICE_UART:
>> -        return BOOT_DEVICE_UART;
>> -
>> -    case BACKUP_BOOT_DEVICE_USB:
>> -        return BOOT_DEVICE_USB;
>> -
>> -    case BACKUP_BOOT_DEVICE_ETHERNET:
>> -        return BOOT_DEVICE_ETHERNET;
>> -
>> -    case BACKUP_BOOT_DEVICE_MMC:
>> -        if (bkup_bootmode_cfg)
>> -            return BOOT_DEVICE_MMC2;
>> -        return BOOT_DEVICE_MMC1;
>> -
>> -    case BACKUP_BOOT_DEVICE_SPI:
>> -        return BOOT_DEVICE_SPI;
>> -
>> -    case BACKUP_BOOT_DEVICE_I2C:
>> -        return BOOT_DEVICE_I2C;
>> -
>> -    case BACKUP_BOOT_DEVICE_DFU:
>> -        if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
>> -            return BOOT_DEVICE_USB;
>> -        return BOOT_DEVICE_DFU;
>> -    };
>> -
>> -    return BOOT_DEVICE_RAM;
>> -}
>> -
>> -static u32 __get_primary_bootmedia(u32 devstat)
>> -{
>> -    u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
>> -                MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
>> -    u32 bootmode_cfg = (devstat & 
>> MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
>> -                MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
>> -
>> -    switch (bootmode) {
>> -    case BOOT_DEVICE_OSPI:
>> -        fallthrough;
>> -    case BOOT_DEVICE_QSPI:
>> -        fallthrough;
>> -    case BOOT_DEVICE_XSPI:
>> -        fallthrough;
>> -    case BOOT_DEVICE_SPI:
>> -        return BOOT_DEVICE_SPI;
>> -
>> -    case BOOT_DEVICE_ETHERNET_RGMII:
>> -        fallthrough;
>> -    case BOOT_DEVICE_ETHERNET_RMII:
>> -        return BOOT_DEVICE_ETHERNET;
>> -
>> -    case BOOT_DEVICE_EMMC:
>> -        return BOOT_DEVICE_MMC1;
>> -
>> -    case BOOT_DEVICE_MMC:
>> -        if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
>> -                MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
>> -            return BOOT_DEVICE_MMC2;
>> -        return BOOT_DEVICE_MMC1;
>> -
>> -    case BOOT_DEVICE_DFU:
>> -        if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
>> -            MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
>> -            return BOOT_DEVICE_USB;
>> -        return BOOT_DEVICE_DFU;
>> -
>> -    case BOOT_DEVICE_NOBOOT:
>> -        return BOOT_DEVICE_RAM;
>> -    }
>> -
>> -    return bootmode;
>> -}
>> -
>> -u32 get_boot_device(void)
>> -{
>> -    u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
>> -    u32 bootmode = *(u32 *)(K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
>> -    u32 bootmedia;
>> -
>> -    if (bootmode == K3_PRIMARY_BOOTMODE)
>> -        bootmedia = __get_primary_bootmedia(devstat);
>> -    else
>> -        bootmedia = __get_backup_bootmedia(devstat);
>> -
>> -    debug("%s: devstat = 0x%x bootmedia = 0x%x bootmode = %d\n",
>> -          __func__, devstat, bootmedia, bootmode);
>> -
>> -    return bootmedia;
>> -}
>> +#include "../boot-device.h"
>>   const char *get_reset_reason(void)
>>   {
>> @@ -141,3 +44,45 @@ const char *get_reset_reason(void)
>>       return "UNKNOWN";
>>   }
>> +
>> +static const struct k3_boot_map am62_boot_device_primary_table[] = {
>> +    { BOOT_DEVICE_OSPI, 0, 0, 0, BOOT_DEVICE_SPI },
>> +    { BOOT_DEVICE_QSPI, 0, 0, 0, BOOT_DEVICE_SPI },
>> +    { BOOT_DEVICE_XSPI, 0, 0, 0, BOOT_DEVICE_SPI },
>> +    { BOOT_DEVICE_SPI, 0, 0, 0, BOOT_DEVICE_SPI },
>> +    { BOOT_DEVICE_ETHERNET_RGMII, 0, 0, 0, BOOT_DEVICE_ETHERNET },
>> +    { BOOT_DEVICE_ETHERNET_RMII, 0, 0, 0, BOOT_DEVICE_ETHERNET },
>> +    { BOOT_DEVICE_EMMC, 0, 0, 0, BOOT_DEVICE_MMC1 },
>> +    { BOOT_DEVICE_MMC, MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK, 
>> MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT, 1, BOOT_DEVICE_MMC2 },
>> +    { BOOT_DEVICE_MMC, MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK, 
>> MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT, 0, BOOT_DEVICE_MMC1 },
>> +    { BOOT_DEVICE_DFU, MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK, 
>> MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT, 1, BOOT_DEVICE_USB },
>> +    { BOOT_DEVICE_DFU, MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK, 
>> MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT, 0, BOOT_DEVICE_DFU },
>> +    { BOOT_DEVICE_NOBOOT, 0, 0, 0, BOOT_DEVICE_RAM },
>> +};
>> +
>> +static const struct k3_boot_map am62_boot_device_backup_table[] = {
>> +    { BACKUP_BOOT_DEVICE_UART, 0, 0, 0, BOOT_DEVICE_UART },
>> +    { BACKUP_BOOT_DEVICE_USB, 0, 0, 0, BOOT_DEVICE_USB },
>> +    { BACKUP_BOOT_DEVICE_ETHERNET, 0, 0, 0, BOOT_DEVICE_ETHERNET },
>> +    { BACKUP_BOOT_DEVICE_MMC, 1, 0, 1, BOOT_DEVICE_MMC2 },
>> +    { BACKUP_BOOT_DEVICE_MMC, 1, 0, 0, BOOT_DEVICE_MMC1 },
>> +    { BACKUP_BOOT_DEVICE_SPI, 0, 0, 0, BOOT_DEVICE_SPI },
>> +    { BACKUP_BOOT_DEVICE_I2C, 0, 0, 0, BOOT_DEVICE_I2C },
>> +    { BACKUP_BOOT_DEVICE_DFU, MAIN_DEVSTAT_BACKUP_USB_MODE_MASK, 0, 
>> 0, BOOT_DEVICE_DFU },
>> +    { BACKUP_BOOT_DEVICE_DFU, MAIN_DEVSTAT_BACKUP_USB_MODE_MASK, 0, 
>> 1, BOOT_DEVICE_USB },
>> +};
>> +
>> +static const struct k3_boot_device_info am62_boot_device_info = {
>> +    .boot_device_primary_table = am62_boot_device_primary_table,
>> +    .boot_device_primary_count = 
>> ARRAY_SIZE(am62_boot_device_primary_table),
>> +    .boot_device_backup_table = am62_boot_device_backup_table,
>> +    .boot_device_backup_count = 
>> ARRAY_SIZE(am62_boot_device_backup_table),
>> +    .main_devstat_reg = (void __iomem *)CTRLMMR_MAIN_DEVSTAT,
>> +    .wkup_devstat_reg = NULL,
>> +    .bootmode_addr = (void __iomem *)K3_BOOT_PARAM_TABLE_INDEX_OCRAM,
>> +};
>> +
>> +const struct k3_boot_device_info *k3_get_boot_device_info(void)
>> +{
>> +    return &am62_boot_device_info;
>> +}
>> diff --git a/arch/arm/mach-k3/boot-device.c b/arch/arm/mach-k3/boot- 
>> device.c
>> new file mode 100644
>> index 00000000000..4c3f2da3269
>> --- /dev/null
>> +++ b/arch/arm/mach-k3/boot-device.c
>> @@ -0,0 +1,90 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + *  Copyright (C) 2025 PHYTEC Messtechnik GmbH
>> + *  Author: Wadim Egorov <w.egorov@phytec.de>
>> + */
>> +
>> +#include "boot-device.h"
>> +
>> +#include <asm/io.h>
>> +#include <asm/arch/hardware.h>
>> +#include <spl.h>
>> +
>> +__weak const struct k3_boot_device_info *k3_get_boot_device_info(void)
>> +{
>> +    return NULL;
>> +}
>> +
>> +static u32 __get_backup_bootmedia(const struct k3_boot_device_info 
>> *info, u32 devstat)
>> +{
>> +    u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
>> +                 MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
>> +    u32 bkup_bootmode_cfg = (devstat & 
>> MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
>> +                 MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
>> +    unsigned int i;
>> +
>> +    for (i = 0; i < info->boot_device_backup_count; i++) {
>> +        const struct k3_boot_map *m = &info- 
>> >boot_device_backup_table[i];
>> +
>> +        if (bkup_bootmode != m->mode)
>> +            continue;
>> +
>> +        if (m->cfg_mask == 0)
>> +            return m->result;
>> +
>> +        if (((bkup_bootmode_cfg & m->cfg_mask) >> m->cfg_shift) == m- 
>> >cfg_value)
>> +            return m->result;
>> +    }
>> +
>> +    return BOOT_DEVICE_RAM;
>> +}
>> +
>> +static u32 __get_primary_bootmedia(const struct k3_boot_device_info 
>> *info, u32 devstat)
>> +{
>> +    u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
>> +            MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
> 
> So this won't work for J7x devices as they have the primary bootmode in the
> wakeup devstat (WKUP_DEVSTAT_*).
> 
> Since you already have a k3_boot_device_info table, instead of storing
> "main_devstat_reg" and "wkup_devstat_reg" store whichever reg contains the
> primary and backup boot modes. No need to label them "main" or "wkup" as
> you don't actually care what domain they are in, you care about what
> each contains (bootmode). That plus the shift needed to extract that
> value would make a table that would work across all mach-k3 platforms.

I have not thought much about the Jacinto part yet. But you are right. 
That would make it generic. Thanks, will update in the next version.

Regards,
Wadim

> 
> Andrew
> 
>> +    u32 bootmode_cfg = (devstat & 
>> MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
>> +            MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
>> +    unsigned int i;
>> +
>> +    for (i = 0; i < info->boot_device_primary_count; i++) {
>> +        const struct k3_boot_map *m = &info- 
>> >boot_device_primary_table[i];
>> +
>> +        if (bootmode != m->mode)
>> +            continue;
>> +
>> +        if (m->cfg_mask == 0)
>> +            return m->result;
>> +
>> +        if (((bootmode_cfg & m->cfg_mask) >> m->cfg_shift) == m- 
>> >cfg_value)
>> +            return m->result;
>> +    }
>> +
>> +    return bootmode;
>> +}
>> +
>> +u32 __weak get_boot_device(void)
>> +{
>> +    const struct k3_boot_device_info *info = k3_get_boot_device_info();
>> +    u32 bootmode;
>> +    u32 main_devstat;
>> +    u32 bootmedia;
>> +
>> +    if (!info) {
>> +        pr_err("%s: no boot-device info for this SoC\n", __func__);
>> +        return BOOT_DEVICE_NOBOOT;
>> +    }
>> +
>> +    bootmode = readl(info->bootmode_addr);
>> +    main_devstat = readl(info->main_devstat_reg);
>> +
>> +    if (bootmode == K3_PRIMARY_BOOTMODE)
>> +        bootmedia = __get_primary_bootmedia(info, main_devstat);
>> +    else
>> +        bootmedia = __get_backup_bootmedia(info, main_devstat);
>> +
>> +    debug("%s: devstat = 0x%x bootmedia = 0x%x bootmode = %d\n",
>> +          __func__, main_devstat, bootmedia, bootmode);
>> +
>> +    return bootmedia;
>> +}
>> diff --git a/arch/arm/mach-k3/boot-device.h b/arch/arm/mach-k3/boot- 
>> device.h
>> new file mode 100644
>> index 00000000000..04951deafb3
>> --- /dev/null
>> +++ b/arch/arm/mach-k3/boot-device.h
>> @@ -0,0 +1,41 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + *  Copyright (C) 2025 PHYTEC Messtechnik GmbH
>> + *  Author: Wadim Egorov <w.egorov@phytec.de>
>> + */
>> +
>> +#ifndef _K3_BOOT_DEVICE_H
>> +#define _K3_BOOT_DEVICE_H
>> +
>> +#include <linux/types.h>
>> +#include <asm/io.h>
>> +
>> +/**
>> + * struct k3_boot_map - Descriptor to map a raw boot mode to 
>> normalized device
>> + * @mode:       Raw PRIMARY_BOOTMODE value
>> + * @cfg_mask:   Bits in devstat-cfg to test (0 if none)
>> + * @cfg_shift:  Shift right before comparing
>> + * @cfg_value:  Desired value after mask+shift
>> + * @result:     Normalized device to return
>> + */
>> +struct k3_boot_map {
>> +    u32 mode;
>> +    u32 cfg_mask;
>> +    u32 cfg_shift;
>> +    u32 cfg_value;
>> +    u32 result;
>> +};
>> +
>> +struct k3_boot_device_info {
>> +    const struct k3_boot_map *boot_device_primary_table;
>> +    unsigned int boot_device_primary_count;
>> +    const struct k3_boot_map *boot_device_backup_table;
>> +    unsigned int boot_device_backup_count;
>> +    void __iomem *main_devstat_reg;
>> +    void __iomem *wkup_devstat_reg;
>> +    void __iomem *bootmode_addr;
>> +};
>> +
>> +const struct k3_boot_device_info *k3_get_boot_device_info(void);
>> +
>> +#endif /* _K3_BOOT_DEVICE_H */
> 

