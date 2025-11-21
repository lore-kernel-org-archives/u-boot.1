Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F13CFA76B
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 10:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3701580433;
	Fri, 21 Nov 2025 11:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="P6MfvBxs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D450A8312A; Fri, 21 Nov 2025 11:12:14 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA2A802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpbKZsxcp+TO9qJ3zBCN3bNzVtgV+p8wfCIrNFQJMsonq9QaoQnGGUxLzt+h52m6vqaSFInhhSdpmqF2WI6DG9Kmi0pEJrL7A0OGed7YRA7/0O9KT7U097uBdutRe0QdgSDLc2JLJXSqnvDdoqOUr6lrK/NUS8d/GZ0m6lC6sSwSMsNMufvwxMbKToGFOn+7Bwn2VxZG5kAHSlsQLLDpJW7gMVx/Tqs3CSZGSy0rZVBfwuYWL68OTMvOVIGkKO9zwLadUitpxmX0sRLUnXmP6oBBNSKtGmO5glzOty9xYR///Uy/LjJD/brkPArDzVzQk7pEanJ8yu1JoNuWASoZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bi3s13PPiD/oKbAS54K68PBpRV7zjGSpXwS/GaIrm9A=;
 b=xMOy/IDaRUWYFu/0or3vg7FQv6roGZ+ZwWpWjFC3HHDuPL1LFV4liZ7jEhqQJoGlrrjO2mWSvasiaZYH5YhFXoPkHU8dFv4G/EnX7KVA+XtoeJjKtdXf5VuO4ucXhPOzWKKKwsq6FxS9TVZioYgEpkTXSK8mHTvTIUTwCGbx3/8iM8/b1RRF+GD3+VhseebbgjyXJPdrx9YPREgNUX/b1zLD/KPlXxsUAnjVjcOLlARQk6cBk1r5pLuAxNkV7As0l/KCsKjtAMkUxdk+jIqUQ1ygLVPe7Hp6rinn5YgGw6ExwIuk8ZkFiljGN+sYXGSgnB58p21UI+8vZmRV723jqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi3s13PPiD/oKbAS54K68PBpRV7zjGSpXwS/GaIrm9A=;
 b=P6MfvBxsXrNILBmPwOTgQ5zoirHyMWWGkJJ8a6Uf05yI4ZSMJ+OeYYHIMQoeWpZ7sidshA6Xt1l1a08WJ5nXWgNPywGVvOItlKwV7MTEOFkw2UIigzbJc7y4eKaKmhq6iQ6UfT7fGsRy4U68r8cp+9SFgeWR1nSFvFtwbUkDhmK0LgTAuZKIWoz+lXPd+qn2hQFmJuggvM5qhRvHQaqEJFp2rCMZbz6Y1n1J8T9Zhosmnfmkqqo2kj+72jeNoJegVmeQIxGbzrdC5QScL4EZrdLSmsUhOhHmSXb9A8+yrHnDYO7Bl8mkU8iZ0ZB26ptXumLgPeo8Wgs9aaw75Y5zpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA1PR03MB6451.namprd03.prod.outlook.com (2603:10b6:806:1c2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 10:12:09 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 10:12:09 +0000
Message-ID: <a2305233-a086-4178-a1ab-e44225577eb2@altera.com>
Date: Fri, 21 Nov 2025 18:12:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] Add optimized Makefile support for SoCFPGA handoff
To: Sune Brian <briansune@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251104223023.1613-1-briansune@gmail.com>
 <7e31b494-1ce1-4fb5-af49-d203830add7e@altera.com>
 <CAN7C2SCBqEajYv8v+meudRN439MeiEGnW5c+eUbMWFL0rcVoWg@mail.gmail.com>
 <eed1e1f9-b07a-4dd2-a7e5-195778889a55@altera.com>
 <CAN7C2SAOM5pVqJfQZYAZRVqBXO0aR2z6vgpndYawznSOhEqhnQ@mail.gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <CAN7C2SAOM5pVqJfQZYAZRVqBXO0aR2z6vgpndYawznSOhEqhnQ@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA1PR03MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: c64ad30f-b4a8-454f-9617-08de28e66e4b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVdWK2ZaV2NGNEhFdzJ6SWgzYmpyN21MNmJrc2ptMVJ3a3dVYTFvRVlmUzMw?=
 =?utf-8?B?b0t6OUxweGJCajNYbDJaSWxpdG9KRGx2cFJqNXg3RmM1cjlhb3pLcUFSVnA0?=
 =?utf-8?B?SmhRbnA1cXpsV0ROS1FXdTZiNTVlRDdzaDdqZnV6MXJDcGZNdE4wUXpQNmN5?=
 =?utf-8?B?dElDQ3Z1dFdzQjBGVE9leUZ4T3dZQ0dtclA3U2lEcEk0cmlNZDk5a1NDSmVF?=
 =?utf-8?B?cmRub1gzUTMwOU1jNUtHZ0xtNzN4ZjRkN2hzTmpPdEZGZ3MyNkJLdHhlWUhO?=
 =?utf-8?B?UGs3YmNlaXE3eDRRaEpwZG1EWU9Id3h5Z1poZXNVaWlsSU1uME9KaldCZGdY?=
 =?utf-8?B?NG91eUpoRlVZZE1PbkVoWTUxcnU2azFLcFpwMnR1ME5rZ3dsOFhqM0t4UUlw?=
 =?utf-8?B?NEFKVE1IL0xDYURKZDhGdmUraHRzN2dPeWVxQXZ4VTZtZlVSWXpwRlIvMkZ2?=
 =?utf-8?B?TFd4Q1phUHFaNmc4eEZKc3VDQkh2ZUNEMTRrZXJQRVExcG9acWVmcEpUZm1s?=
 =?utf-8?B?WHQrQ3dxVkZac25nWFdHV3lFNzdYL29aUmJQMVpMMitWVDlTbDNBb2ZoblFz?=
 =?utf-8?B?QWx3VWUxVWFoeVAyOFVmRW8yR0VIR0s5djcyVncvdFFhN1N4cEEwbm1zLzZp?=
 =?utf-8?B?aVdWZkh0aHF1K0JTNkIxN3lWT09KUXJDMEowOTNtMGdlZHdVbG41YnFrTmov?=
 =?utf-8?B?cTN4a3daaXkrMWxpWFNubStJWEUwbkRTYW1OQytYV0lVMmVuTkw2Y0JFMCtm?=
 =?utf-8?B?eVRwc1U0N3JNZkptcnVqTkFyRENnaThLQ21TOUhuZERLUXdEYS8rTVV5cDhB?=
 =?utf-8?B?VWcxUTROOEhXcmlWTSsrTERBOEJ6YlNSSnVONkhVZWtxSjRzS1VyQzJGNVpE?=
 =?utf-8?B?ZDdGOUVJNjJEKzYvbnJYcExhQVkzc0thcTBHMWVqN0pSajJEN0FNM242UStQ?=
 =?utf-8?B?UDl2d1p6dE9VOWRZd2VpNGxOc0s1R0VqeGF1SzVtd1JKTlgvOUF5azROMUFG?=
 =?utf-8?B?TlRTTTJCdFZqSk16U3l3QWpUWm9LYVljMUdjcWlsSGh2TURCQmpjMEZxMThs?=
 =?utf-8?B?bGJtTlZqcVAxejFSWHBqM0lRUWNNWjBPcGpVZW1INDJZSUlhMWFWZFZPbXpD?=
 =?utf-8?B?NWpUUUZHK3gwb1JBZElRWXpHbTd2K2IzZ1llR2VTa01YajhXWHVNeGZ3b2F5?=
 =?utf-8?B?bEdLczVydnFYRXNCME9NT0hmQkdreUZUM1BuWjNVVDYvNFZLOFU0RHVUZ1pC?=
 =?utf-8?B?c0U3QWFxY2JSNHNJL0JLb2xGY0Y1VnJFWmdwSGR0amltKzFza0p0c3ZITGNq?=
 =?utf-8?B?TXdXOGlvUm00V0JrYWhIUlBJWDdQRklIT05XWXlCYkNZVXFWUVVIZzdrY29M?=
 =?utf-8?B?eEdnQnF4QVE1cE84Tm9OSlY5QjBIL09SbWY1Q09XVTVBNzZlK3pRUHFyNWFy?=
 =?utf-8?B?NHFjZlRRbnZRc0V2S2tHajU0T2hISXZyYi9lSDVwMldteEE0eFpYcE5Edmk4?=
 =?utf-8?B?dERHQXdQNVhYdXJpRFFBOGRLSXhlV2R4M3J0ZG5yT0RCQ2tNWE54aC9hdnQw?=
 =?utf-8?B?UG84TXkxU04wVVArMkw1M1UyZkRaN1AvRXN0NmJrY1RSWi9LR2lCSW94RVJO?=
 =?utf-8?B?YXN4TWZaYTArVElPcTRxdmZpYU5VajFHM0N5L1VXT2x6NUZjTm1IUXAzMXFQ?=
 =?utf-8?B?Rjg2aGZTZDlWaVVIay9tU25ISnQwakdudTR6QVBsOG83bmZtU1VoS3VQT3kr?=
 =?utf-8?B?N3NPVHk1cTUvcHpjbVowUDFScjFYUjkrTEtwZzRBbDhTYVhCMDBBTk5MMXVF?=
 =?utf-8?B?cGxRcE9XMWJscXYyc3BWUG1ieU11MDlkUFY5aUhtMXQrajI4ZVZyTjFraVlR?=
 =?utf-8?B?bjVWVmo3L29WUlRYek56NUVyWmd4MHBjaG5ZdXJ3NlByVUVuM05aK2dpUmE5?=
 =?utf-8?Q?JdevqltLOGUl0jBQYZvW5uFMMD77fRyX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0hTUDd3emk3OVdabVl0Y3JJc3crVExQa3MrU1UxYzM5a01oRHdtVnZYQzQz?=
 =?utf-8?B?eWVQc0xjamJlbFd3M2t1UnJRQTRsWmp2enNuaUR0VzJyWStlM2UvbDlOWFRS?=
 =?utf-8?B?Wmg1WEwvWTU1R3dmTUE1NFFpLzFsTkhUNXFkZFlWVjlQRDhrY1FTQk5UNGhR?=
 =?utf-8?B?TGJXb1RkeEJzYmozekdZUWM3c21pUTgxOWx5bmFtSFlWa2wzMFlVMnpiREJk?=
 =?utf-8?B?NHFObkZnSDJCb2crc3MyU0VTQnF2Q1loRlNYaWtxS3lBVnAwcTV2L0Q2dm1R?=
 =?utf-8?B?bnhRVTB2MFNGTWZ3TWczN2ovdjhKS0JvOVE4TXNnWXVKVG4xQTQxdmkyN1gw?=
 =?utf-8?B?VFNabnY5TWpuR2J3UFpoQ1NqQWljc1AwWHUyK1NjMTJ4aHh3T0RON2g3ajg2?=
 =?utf-8?B?UWYyU2daVWpjaEZqQ0l1bUs0TnlOeUswWW9WQmpYWnlndDFnU2J0U2xFQVFM?=
 =?utf-8?B?c0pXSFdzaTVTSkNod2ozSUxBTWhsZWRYUC9KcitvNFdlc0RpK2FqUkhHL1Mv?=
 =?utf-8?B?cWJ3ckdpUUlwNncwL25RY1JSbkloOEhJblRDcHFvT0JLaVVEa2xqWEFzdGd3?=
 =?utf-8?B?UXFSLytSbVMyV1RXQ2ZyclFMZGdFczg0WXYyKyt0MXFNR2lBWUJKcldjY0RG?=
 =?utf-8?B?RHN1MHJuWk4rT2o5NUhudjQ3b1AvRURUcldxMGpOL1FJSmhGcW8reWU1cTV0?=
 =?utf-8?B?clNidkMzTFBPQmVnWmJRZmd4Vmk1VUFvTytMaTVhVGxETGdQdm8zRjlkRkVN?=
 =?utf-8?B?endmQ2VBRjdoTElsWk9DTnNjWnM1UE9QQ0kxdmFUOENkMnRXNWJXb2ZBU1dl?=
 =?utf-8?B?eFRQWkN5SmRFMTlhdFppYTlWd1F6WFZ0ZUs3SEVHeWcwOGhpNFlVYWh0NVE4?=
 =?utf-8?B?WHVCNHJGaVFBTzRBMS9YT04rRk1VTmdhZ3I1NFFjcjJIYnExOTRsQ3VHZWdO?=
 =?utf-8?B?M1phdXBmMklSNjNrZEZaY1VIalNINm1tVWZ3cmZrK1lreFdnSU8zMlN0ZEdV?=
 =?utf-8?B?Mm5jQ0lOM0ZUN09ZM2g3eTNDS3lPcGJFdTBRdHBlaU0yZTRycW5qeDNzUGZ1?=
 =?utf-8?B?bE02UWVscWtVbXNOSndqQ0RCVjN4cHR6SmRhQ2lWbVE5MU1iOGhTMnBnNnlK?=
 =?utf-8?B?UDlvTXlRc21JbnNaN0tYdmpEYU43YmhaMEFXdDl4VCtVNW1IdjZQMDk5QkNY?=
 =?utf-8?B?eVoydGRWbEl0NTNPRWprR1hoZFRmWnc3a245OVNZQTlJLzVmRjZKcW9TRUY1?=
 =?utf-8?B?T0lOeEd1cFZ3NFBEVXlFeE43ZTRhVXJSRDM4endqcU9PdjRCQU04bzByMDZu?=
 =?utf-8?B?dWZ3VWNSaGs1T3FGTWREOWJQcTcxWmdRQkFKT1VmMm9vRDczUkNnWVFXTFpu?=
 =?utf-8?B?b052ZWh6TkJVM0UzVnNXb3Ewa3dJZmt5UkwzK1JEMU5vV0F6Y1oyVWJweGEz?=
 =?utf-8?B?S3FVUnFIdWFCRW90M3pQYTVNUnBuQUxNWEdpaXEyMytNRi9QL2dNQVJxbzNk?=
 =?utf-8?B?Tnh2NHE2eGp2OGpOMVBFcUZPdm02aGIrNXk4YVhGdEhweE9WMVpMS2wrWWcw?=
 =?utf-8?B?bmpYR3E0R1RQOUJPNUdxSEJOcmtqSkNBMm9OMUYzRVdTUjYyUkJSTVZUdzNW?=
 =?utf-8?B?a0kyQm5oRlhvaWpuUDZSbU04YWQ2OUJ3UmFkQWQ4QXJob2JraFFhdTJVc2VE?=
 =?utf-8?B?dWEvRGltR2FmMk9wWWt3bHJ3ZE1YQWIrc0lmL1gzUTdaR2lVdXh4SjV5VlYr?=
 =?utf-8?B?ak8walNGSWxJVTlsVjJGSSs0UXdKdXRWelF1SHRFMmFEbC95SDRmOHZ1c21m?=
 =?utf-8?B?eWZwVjVDa1BGaEQwSStTMk94RGhZRVgyOWVsRkwyNkMrdlFNaXF3L0Z3ZVRY?=
 =?utf-8?B?dWtzRlFDeWpzVWo2cTlVLzhmZk1UbzRxU1FXWW5qSWdHQlFLUGZqb25ia1R2?=
 =?utf-8?B?N1F1d2VBSGhzMEtrUDJNU2ppSllnS0E2SWozaXZGVzE4dTdYNWh3R0R5c1Jq?=
 =?utf-8?B?UmJuQ1FLdDArVVZ3UnByQU9saHMrN1FwZGM3bk5ZNHlGcnljNFRmaVNleTBi?=
 =?utf-8?B?TG5veFJ0c1pCL1g3TTZBaGlMVVJDVW9xL01nZmx6eXNYWWZPVzVLNmovQkQy?=
 =?utf-8?B?bi9aeUFRL3QwSk4vdEU5UDlLQ2krc0NZRjBoc3RwMXRvZzBXUE4vZ3RMM2hY?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64ad30f-b4a8-454f-9617-08de28e66e4b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 10:12:09.4739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5q+XId0zHkYF+BEQcJRtdxnQlCjnSPWEGycbaTtIeFMx5Y+qwSRl4y2cGjt133GU2GcHPDNYvXA1hnP4GWg3z6KkjGPJUd1wzlIbjIuX4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6451
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Brian,

On 20/11/2025 11:31 pm, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
>> Thanks for the clarification.
>>
>> Understood on the removal of Arria 10 from this flow, since its handoff mechanism is different and not based on the .hiof format.
>>
>> Noted on your point about keeping the tooling consistent. We can keep this in mind during future clean-ups.
>>
>> All good from my side. Thanks for the update.
>>
>> Tien Fong
> Hi T.F.
>
> Can try to convert to python script but don't have actual A10
> on hand. So may be a test folder with generated outputs
> to diff the new script for sanity check.


I don’t have any Arria 10 handoff samples or generated QTS output on my 
side either, so I’m unable to supply a test folder for diff-checking.

If there is any reference handoff or sample output provided in the 
future, we can help review or sanity-check, but for now it’s fine to 
leave the A10 part as-is.

Thanks,
Tien Fong



