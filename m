Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8EBC83F27
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 23:50:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67795836D3;
	Sun, 20 Jul 2025 01:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ae5SUJ1h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D250383700; Sun, 20 Jul 2025 01:50:11 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E71B9836AC
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 01:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQmLzRzHPSE2sNYwMQ8bXOsDGcRUJuDXaR+q58ws2lUauYr3DHSksrAqQPmPQ3e3dMoR59hCX4w70QQF6ILJA5/LyCqDgARffovVQlSqnzT8NLMyPWKuKZrP8rnEWbVdt1mdEl8SLXp5h80JKgoXYVfOLdTzz5rCB+UHCFvR6hfDG9OBoGrkiThRXkXH03gzYRhj97RxuZ6sBA+UGkGvlJWPYwAQsaTZMeSnEAH0KJX+1sCvAVCXRmgrZsjNX0rUbZKR+iTqsqmxX1hnm0pOe8RfXUVUg3kLx2tvEHvyWVrkx3tewsqDuR1Fk6rPV6ZC5dy9Qc/LfXaeWwyvHMbZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ0m6xWhxc0Ah4SHGvTaTd6mKSvAbhAXRa6d/iuiO3o=;
 b=ms8lyq+ygYKUWd+F6wRYGWmVtkp6uS8fvBkTBgjJsP/N4pnIxADh4gIvXFKgAEab3grYe9JsObvB1XdBxwBzGwQFp7Db3/65JcnkYX+KI6KjQ/Gq2FldpiGUqlStXm7e3SmWel99HHlOSnoXhNFNgQPvJJblN724JYWlA4Vfy29YHjMirXf37V94MGSdrLXMCLhnT9gb+fhUF90MeG34x0j1qvMtHLKGfj1fmyzI5iY5AONu0wyzLxM+Dee+iP3qQlCMa750km3nHRm21qqm+K1Kf0u/OFW7dxamQ3jXHRD3rCmy9hDiEfwrRtY9h0c95dS5cd1LfOYfQs0kguRMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ0m6xWhxc0Ah4SHGvTaTd6mKSvAbhAXRa6d/iuiO3o=;
 b=ae5SUJ1hsZSXVExnoAP6eCfhYULJGbI5g2HlJ2WXRA+hD9huQFU3zFO6oRMmt1GoQagAcy1rDlbnEpFHnaC3u46wsqyHOJCjk4/ONUIFAbXvWwgGr/9+HukwnYN+Ou5ZDF9URNXuO5/6oUETY890gC88CG5M+spoVtoFa1Thx+IUes4CU+8WHgcAECeFzQek526CiBbTijdPMCcWLke0gQKqkVQXzGQjDBndtlN3Z4nPJq2i2BTYNR/lGjWTAFN0AE+axIawav8NVH1bAxn7GNNcxnlPv+zCLOw4ooUpSMl0WY97oBilSME0morOgys5F0KE4Lbxhzl7rMPO5DEuGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6016.eurprd08.prod.outlook.com (2603:10a6:102:e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sat, 19 Jul
 2025 23:50:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8922.037; Sat, 19 Jul 2025
 23:50:03 +0000
Message-ID: <942692e8-8d45-47d1-ba63-411ff2e7866b@iopsys.eu>
Date: Sun, 20 Jul 2025 02:50:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] airoha/an7581: add CONFIG_TARGET_AN7581=y to the
 defconfig
To: Tom Rini <trini@konsulko.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
 <20250719005717.113842-3-mikhail.kshevetskiy@iopsys.eu>
 <20250719145818.GZ193579@bill-the-cat>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20250719145818.GZ193579@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af1f7fa-66f4-495b-2fd6-08ddc71efad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDEwRStxM1luVStYNjB6ci9kWHU2aHh5UURqTEg5N0dWTkRHQ1pidG1hZ2lN?=
 =?utf-8?B?UVZwd1JDUmJySGtseGx0QUEyRnhEeFA5S0dOM29nTU45Nlp5cWhuVVdGTU5y?=
 =?utf-8?B?LzFXcm5ZbjZSc1FOUUhQbFo3ZG5NWG1oRm5teExieHFHa1RWZ3pra2ZwaVM2?=
 =?utf-8?B?U0dNRzJzbVVxZExDSWtPT0ZjWkUxYnJ3NUkrbXRFWDdCS1VoTlhCbjh0QkZ0?=
 =?utf-8?B?L1pNOVN6bTh0ZnZOdDRlTFg3b09Bc0lmMFJzTndiTytpbktOYjFRVzdWM1BL?=
 =?utf-8?B?dEhzSjNFSUVwNGlpWE4rTmwwSHpXQ1IwYm1jNHJBc2k3dzFaZUlrelRiS1F6?=
 =?utf-8?B?VzV5U2FGU09lS2k0S2RpYVdmdWpSWTI0NE1jd1F0WFFxNTcxWlZhOXVES0pi?=
 =?utf-8?B?UVZjSENYWU5tenliT2RRUkp0RWJhL1UvRm1wYWlRTTMrVmNwa25pRmhwVFNx?=
 =?utf-8?B?SkJaallPeHExRnozempTZ3YrWlJaakQ3eFJtZGJOV0xDUW9BYVBMS3NCMG84?=
 =?utf-8?B?ODdQV3NpempFYmNOMG1NNXkranM1b3pUM0tIRGhHOFBMckwvTE5VRVdMd1p4?=
 =?utf-8?B?cWJsQ0RqRWZEYnlxWUlYWmUrZnkyYlR3ZzlkMVJZWTBWb3BrUUxiWWwzSkht?=
 =?utf-8?B?Sk1vRnc4RHZ3TDRKbUNocmp4aUFpWmxUQTlSZExsOEIxMjJlTnZOK091bzRv?=
 =?utf-8?B?RTVob0dzdjVRb3pPVXlXL1AvYXVWQUhMa0VUZGhVMlcwa0pXOWdsR3pEekFi?=
 =?utf-8?B?T0dBQkNyUDFzOStHZVlmRm5rbXBLVlVkTElxaW5HVTNYazU2M1R1MkplK0Zj?=
 =?utf-8?B?ckV4L1dHbUlSLzNKdGxCdUJoS2p1YmNOQWEwRzNHUCtEdlJOZlE0OHFzRXZl?=
 =?utf-8?B?ZG9TYkx5TXoxRHRYeWNYK3AxdEN5N0lvd2lQWTJlemYvZUhKMG1hb3E5ODlK?=
 =?utf-8?B?dC92SXN0U0RaeFk2Z1lOV25kc0pPbmtvdEVISFFtckZXQWpxbEtFK1JFcVhv?=
 =?utf-8?B?TFJzV3JpVE01MVpHSzdUK3hReEdiTllZeE90d1dKeGJUNXVCZUo0SFRVVmVK?=
 =?utf-8?B?eVA0dHFzQ2ZoZ21NZThDUVR4dml0eFBPRHFVN1ZPZnlneWR0VVF3QUdIbVBP?=
 =?utf-8?B?VFRVN1ZYOVhEUnJ3VVQ5U3NHSHlzWWw1dTJSbjd5VTlYOHUxczE4QU5Ia3FY?=
 =?utf-8?B?S051UXBReXNidUE1WmJwR2htQnh0N1hvMmZoMFRCS2lIeTREYUMxSnd0WXNx?=
 =?utf-8?B?amVQcEZiNEtaL3BaMCt0REpUOWVDZmxDZTlHeVFaQ2JJSUY5c05qR0lSMVA5?=
 =?utf-8?B?ZmpueStvd2xYUWwyejFvWmFJNWtBRlIzR0lwdk00d3I1UzZsQ0oxUllmbFVL?=
 =?utf-8?B?eXRaTmU0NDlpVnlqLzRwcEJOTDJSM2p0eEZ5alE4NnZzZTJoM2tRRHUydUpB?=
 =?utf-8?B?L0Q0U2k2a2RzQ2xMeHVNbWppV1p0VE1rc0Z2L2UxWWhsY2NEa0Z5SmxJRnhP?=
 =?utf-8?B?RjcyVEl4VmNJalFkRDhYL2pwUlVtaHNKa1dRaUJONFFtU3crZjlzUGIzQzUr?=
 =?utf-8?B?ZVplbkx4R2RzVmdsRWNwK2oxWFZrVys5emQvVEVqcmxyL2FTeE44d0hsUkdx?=
 =?utf-8?B?R0tSL283Wk5FWlZ5QkpSSUdFditjMVVIZE8zN2txUzZMakVZaEFPZ3NGdG5L?=
 =?utf-8?B?V0d5dHd5dU04RUNFbG5qQ1VOOWYrTk8yMUh3cmN0Vk1IVGpYQ0lsTVVjTU01?=
 =?utf-8?B?T09EbmdjdTdFNnhML28vam9oYWx6ZVhuUXlnZlh3T1JweC9yV1pTYnFhZW9P?=
 =?utf-8?B?L3Q4YjA1LzJNQ0tWK3VTRFRuSjBDZXhqSStoTHA5NnRyY0Jib0pMQWJody9P?=
 =?utf-8?B?MjBDaUhkY2R1UFBhejlaU2R5bHlmNmQ0NVUwYkhYK1habzN2L1QvMnNzbUcz?=
 =?utf-8?Q?kJbdLaFEReY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akdrQlBBY0NIU0tXbjUrQ2xxb0I2bi9YYTNXNHRNT202NVJtMzI4eS9MaW9W?=
 =?utf-8?B?eU00a0puajR3YzNzNk41N09DcVRJQU1kT1RKNXdQdGQ2b2hDL3UzTzZETi8v?=
 =?utf-8?B?MndTS1AxMTBFSWorMjBwaE41YTVNZVhScVJEVHkrRGZqTjJqME4wMW1DYWFV?=
 =?utf-8?B?YWg3M2cvTkVLQTVUbFN2VW5LOWhjeVpFZGZ6QlBPZXB0aXNvc21YcnZNWlhU?=
 =?utf-8?B?TUtoQmR5SDc3d3pOVkQrMmcyUWNZb1cvUG0zTFIxbnl0bDd0NEdzQUswUE91?=
 =?utf-8?B?OWs4dlN5cG4ybVJlSjRWcFhROUQwM2dvSG9sR3J4ZUJDSHFCMXBpUnVTK2c3?=
 =?utf-8?B?TUkyR0RhY1NmNjcxdDNCcUlVaUpDTHVJZGpqbzk2K0dTRHpHV3FzOHJJeXcv?=
 =?utf-8?B?SDNEc0VWYk1uQTNBSjVCTzdJMnA3UWRvVmhYT1FuR1BWN0hBVHI5eEppN1hS?=
 =?utf-8?B?Z29PSER1cURtVXMwSlZ1RHFBZnYvRGt2dmY4b2tYbzYwWWF6S1REbzloSWFJ?=
 =?utf-8?B?VXNqK2lTeS9QZ2VkYlBsUkhxNmlLVGJvQldXYnhMNDRhTnRabmlVcCtDSG1y?=
 =?utf-8?B?R0dtbmV1SGlRTmpabmVpVWt3SUhOUmxuaTBJajBEeWdWRHV1R0MwclBwcFJN?=
 =?utf-8?B?dTlaZGc1TnNiRER5RW82SUwxV24vaDdOVkE1NzRMQlRKZWtBTCtyaktHei85?=
 =?utf-8?B?NXBEb3R1UDF6dDVxSldXNi9XVGFTbjUyR3l1Y256T05KZEtQb0RTSmlHbWJK?=
 =?utf-8?B?Z2tuTXFxWEJOQXphMkNjd1FCcFVmSTJneSswT3BsU2QrTVFvblZHSE1tV1Bv?=
 =?utf-8?B?N0dXZGdDcmQrYzlMOERkUmtUOUpDTlUwVTJRRFdsbGY2elpZOUkyRVN0WEtH?=
 =?utf-8?B?YTdrd3hjZzk1NFdEUkdkMTFUcnQ2TlAra0g2MllGWlF5NTY3TlU0UndnekhI?=
 =?utf-8?B?ZkFsOXdXUFVuNFRKREFreVpMWWZBQWpSWFQ0NHNrNC9KYVZrdXBKdzZ5MEtz?=
 =?utf-8?B?ZTF5Q3BBTWducXk3NVFsWDZYbExYT3BvYktVUTRhMmp5RldXbjQweWxpNkkx?=
 =?utf-8?B?OTBkQlZHMXBvRmkvclNjRjR4cWlDK2FQN0t5d3dPdTg4aHlVaWd0RklmL1hl?=
 =?utf-8?B?Yy9SZkFSdG05TDBpS2NMc1c2anR6WmorR3NVM2tibXJsKzduR3dDSjdWOHlW?=
 =?utf-8?B?dGlnNXU2ZUlBZU9CQ0NNcUlURVBpZklySjhsZmRoMnpWUFNDMk8wV3lOSUQ4?=
 =?utf-8?B?UDlRNGhzb3NCRVhSaFJEOWpncjFsbFgxUVRTam1CWXNoNncvT2xWa0lUWjUw?=
 =?utf-8?B?V2RwTjJyWDhVczJ3cThsb2MxTGxCTVpBdzFmRzIvQ1ZUOFJRc1YwUFkraElw?=
 =?utf-8?B?M1A5Z1kyeTVBTkJ0RXdJV2tzRjg1WnpTalJoaGpUS0JuZGlKUUp3S0xnT0Y2?=
 =?utf-8?B?Q3gySnhoZ29FMFAzSVFlU25lcm04NForTHhDUW1OaGdFT0N6bTFqeFdXYU9o?=
 =?utf-8?B?WG5YZXBWcDNhRjROSVdRZ1haakdwdkZBOHBzVDZISTkrNXZtbUgweFFkRmF2?=
 =?utf-8?B?V1lvU252aUJrTXI5OU9DOFpJOXV0QTdkWW42YnRrMjVXanR4Q3I2aFY2ZVJX?=
 =?utf-8?B?VFl1NnhPRUxzMmthMlhSWjFibFpDd0g2TGsxQ1BzNlUrU0RUSXJXaVRiaGx1?=
 =?utf-8?B?T2RhWlg1TDhWcXV4SmwwVWJFcjJEQi9GbDAxV1E5WlhzcVNtUW5obWE0RGRw?=
 =?utf-8?B?OExaMEk0cXgyQ2ZsOEJnZUJLVkF2NlFsS1JhV05RNXdWaC9LQktDUDFRbFFN?=
 =?utf-8?B?T1pINW1Hb2xEaWN5N3JFeWZleDl0TzBvemFWTVdENmYxRkZHc2VsMm5MRW1X?=
 =?utf-8?B?ak1JMm1obmpYVytFY3ZnVzRpRlIvRWoxZnB5OElQQmdFdHJIZ1NvSm1YWnVR?=
 =?utf-8?B?R0h0dzg4VDdOMk1FQUpWQWhpUzVDTHRXVTBVQ0pqeGFvYmZYbUs5ZWVzYjVF?=
 =?utf-8?B?ZGtPcVJRYWtrNU9mb1JQSUJIRnNZMWJlaHV4dGc1VFgzeENIYXVoNmxMV0N0?=
 =?utf-8?B?Ym9kTWV6NzcrT2ZtMEloL2QzUVFuNXJuMFM5dENTWUtJWWxzRjhtMkpMLytV?=
 =?utf-8?B?U3A5Y3hHbENHbVZPSWJsbU1RYlp0N0k3TlNMaUJVcFEyN1hZUlk1RXhYd1N2?=
 =?utf-8?Q?p4MwSimZOg/He0x1hRW8P4w=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af1f7fa-66f4-495b-2fd6-08ddc71efad0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 23:50:03.0682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Te/W9MYwKMgKhVSJJQbaKhthyyWR8opBuKeM2K6lbtRnkMuZG5BLI9xKKTBKNpy4iUUI/mW0Bntx78HzVxcUXhQnCxm0EsIZZnX8fWMuR+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6016
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


On 19.07.2025 17:58, Tom Rini wrote:
> On Sat, Jul 19, 2025 at 03:57:12AM +0300, Mikhail Kshevetskiy wrote:
>
>> This is required because airoha/en7523 will be added with the following
>> patches. Without this line config for en7523 will be created instead of
>> an7581.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  configs/an7581_evb_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
>> index baa3fc3f5de..73af30cd693 100644
>> --- a/configs/an7581_evb_defconfig
>> +++ b/configs/an7581_evb_defconfig
>> @@ -1,5 +1,6 @@
>>  CONFIG_ARM=y
>>  CONFIG_ARCH_AIROHA=y
>> +CONFIG_TARGET_AN7581=y
>>  CONFIG_TEXT_BASE=0x81E00000
>>  CONFIG_SYS_MALLOC_F_LEN=0x4000
>>  CONFIG_NR_DRAM_BANKS=1
> This needs to be in the patch that adds the symbol.
Could you explain?
Up to now we have a single airoha 64-bit board. This patch series adds
support of 32-bit SoC.
Previously CONFIG_ARCH_AIROHA=y was enough to properly select SoC &
board, but now we have two. Thus if CONFIG_TARGET_AN7581=yis missed,
than an7581_evb_defconfig will select 32-bit SoC instead of 64-bit
