Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8176CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 10:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D0B383B2C;
	Mon, 17 Nov 2025 11:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="pITzyaEp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FB8883B43; Mon, 17 Nov 2025 11:24:45 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A9A283A79
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 11:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmF3tKk4PBH2NK9ba7maeiyrJruMk0DkH+CLmsPhkYlcgd6pYtkpu+V0l/SvWPhFr9KfMh7v9qrnxD+NQolpZuZU1Z1Sd+6tQw8HBThHdR/2VS69yuzLj6qg8Rr2/bEc+5pz2eOeL5fv2e4H4MflSgyp6NiuEEpWFmR8oa/T8hry3yqQG6MpHTNq7gxxRJ5BLrbPK+GuCBl6nz/TeVgH/uZdSq4kxeiP82QOuAXNDracC+diGOGcbJr4LG1KkVET8zWVMp/ZsJrEUtoGihAdhRGDGtCMQqF7pr9Jwq59yvHuYB2XSK9TwOiPI5LKg6lRaapWcz3b1jnv3QgEYbkSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uC9XlvU4UoTjywIg0I7PwzVEUOxsyUqpiqvqALBmDk=;
 b=Z1gP5M20NFNpF2xJUXUQpKwKGroPN8Wvk8tCf6OB6bAzRpHBG20FjeTkYH+qZsnX73qFVg1FtB7vhz7wYsDYHY53yeo/4M//CcYNMkXKlDrdwUgui/RvW4fwcH/p8VHwXcvxgmlcAdAEQZX6Oj5LrqeB7ZZAgSncd1qu5fK4EL+5wqwHSFpDaXKDeAcG1MwSqDMG7FM83tc56IlUVaovKUPwpAuX/SKBZMI17GjNThFe0jmfOdJYBd0uN6yyc4iU8rvMFH+BM5+j2PezkqpXLIrwgUqp0FLNfTH6tlQw4+AKaj2hx8I2YcIikGLDjuxyPY7YuqD5PTXQj+MVIcCJEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uC9XlvU4UoTjywIg0I7PwzVEUOxsyUqpiqvqALBmDk=;
 b=pITzyaEpB62bX37dT0Q1RZ2zMP6ZwXfwASo9yBl0glQsrqpqww3h0oqBUjv/kiVLcEc/PjhdwKGAuRmLDhrsB7XQXecjivOlDtOuS7/h8tXMLLU7vowNjBZB/Y010/4EOkWbzD/jneUASLEq0qMgud+c8Gx3fZ+Mu0S+q0q2GIiaVHHcK1J1t56SN9lR9eZ9L+OgO4BkHijxIBP+JEFdYBAZwj+ikbJCDBem2jnDnm4rV/8LeHf0bJXnjUboTiPgKOuxLP7QssMG1dD5MWfq57ifOySmcsNHhV4/rGMdJWdsuO9vYjgbWXqOzHjSd8zt0bGAtWNRgDpbAjeOuX/l+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH0PR03MB6336.namprd03.prod.outlook.com (2603:10b6:510:bf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 10:24:39 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 10:24:39 +0000
Message-ID: <9a62d58a-d6c7-4844-9c71-7369375ad276@altera.com>
Date: Mon, 17 Nov 2025 18:24:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nand: denali: enable ONFI detection for SoCFPGA SoC64
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, david regan <dregan@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
References: <20251104171617.13432-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251104171617.13432-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0046.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::12) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|PH0PR03MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cad2f7b-faab-4297-f744-08de25c383c1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWdLckVZcURpR1FHZE9ySGdPRklGZXd0MkxGYWtMMHYrY2V0TE5UWS9XbSt1?=
 =?utf-8?B?c1cwSmdwY21DamFFem1Mb3JNckJoQTZDOHlhSHhnb3gySXZTMDZLTmxMMjdr?=
 =?utf-8?B?N3g3Vm51KzFBbXJmaVg1MWZoRFZMbHEzK3BHKzRsR0d3b0FFa3YrN1pFenRs?=
 =?utf-8?B?dHpTa2hGSFNtdGY3d2lLbFhwT3RFWTBjbUgzWmoyQXlUWlZQemlxTnRkWVky?=
 =?utf-8?B?ZEtiYkFEWFhTUXRjWDh0c1lBdTRuRExIMWpDanVENjFsRnk5WFBPNHJJTFlT?=
 =?utf-8?B?NWhGNmFtd21MTjFaTTBLcFMza0ZWSkhPUGRVdVBQVFpkMzFNZzhvYmVESmhV?=
 =?utf-8?B?WGJrTlFBc05NZGhyZnFudnNac3UxTDY3UXVZSEdKZ3FhTWJOOVdtTEdwUWE0?=
 =?utf-8?B?ZkxKazJLOW04a3BqZkF0RDE2THpLVmlVckwzV21PYTl6U2EvU2RMdm9aQldO?=
 =?utf-8?B?Z0pzbzNwZCthSjBZMHJ6Y2pGV01XN2d0ektPdklmcnZFalhxaVdUSDVSbTNa?=
 =?utf-8?B?L2g4czJBUWJ3QWhCWjF2emwxN0pRelg4U0ZlK2w2MUFJSFFtZVNiL2gzd3Bv?=
 =?utf-8?B?WWNucWdKQkdiQ256RXYzc3RmaFN3ZjNnS3NseldoajhqYnU0aUpXVXV1d21t?=
 =?utf-8?B?OVg4bHd2SElmWGpocWtVR2w2TjQramgxZFdud0NJYm5WNnMrMlRFdVIvSWZD?=
 =?utf-8?B?eUJzOVRXTTZNODF3Q0t0QlpESklYMktNYXExeTVGV0hHNDdRalJWdW9PYkdL?=
 =?utf-8?B?bnVpSHREdGREWUFMVStibmpsV1ZMenp0c0JyRXRJQTRsSnBRQzMwbWN3V0pv?=
 =?utf-8?B?aG4wKzZIQWlNQnFqb3dDdDUxcnYzZlM5Rkd5eTRNZnpSbm1Gc0ZOMFBzVldq?=
 =?utf-8?B?RDY2UnJCdWsrUmNZRnNJb1FkTVIrRk5XQmM3UVV0QjYxdmhkdDN6WTludUo1?=
 =?utf-8?B?LzFVNjZ3QkFYaCtjem5uaVFpOFR1WW40VWRoQWQxV1hXRVR6Z3VXc3ZXVUJL?=
 =?utf-8?B?dTd6dmR0TVh4cTBlK3R2b2V3YndHeGFCYzlaVEtxditJUjN4dVhmVzR3bmpR?=
 =?utf-8?B?ay80YUxaTzNyakNIQVpua2ZuVGMxdXZ4YUZmWTBlV2FkMUFZSEJNZkg1SnEv?=
 =?utf-8?B?c2plZ2s2NFVuMnVkeFV6czVBQ21ZSUVTdVlkRTlZcjFjR0VBazhKTUtxU0hX?=
 =?utf-8?B?bUR2NVRnRVlmZ0dFMUVwWjk4V20yOGpvdUpBMjNpcjNtWmd1MFRaaFVWQ2to?=
 =?utf-8?B?UzVlWnBpcmFlSnBhNVkwZFZIZDZ4VFFwSGJuWUZPRVVvSUtuWjRNMFRSeHY4?=
 =?utf-8?B?WmZBYkFOVDhSamxUR1k5ZU5lbUJHM0g2WXhWZVBRWWJBajN4V3R5cXEvWmdx?=
 =?utf-8?B?KzZCUWwzVEcyamJUdHpLSWdZMGg2eUEvOVVydjR1bmE5ZmNIdXo2RFVUbW9C?=
 =?utf-8?B?Uyt4dUJVK3oxcDNYTjBSVGdkRUFwekREMW1XbmVub3JlV3UrTDJTaUlYaXFr?=
 =?utf-8?B?ZmdQejEwRzhPNWozeUdwRG5tS3RpWklYVDA4UytoekNBQldETnh2MThDQTZQ?=
 =?utf-8?B?QlNQN0VhUTRIREJWR29zRmx5YzZ6WE5XMEhpS2d0MnRVQyt4OHpHa0o1VUlV?=
 =?utf-8?B?UkkzaWdZNUtZZGVTdnZNa3lieUVnOFZFbittVCtKWmNGVFFRUVUra25OL2xn?=
 =?utf-8?B?VU9JUXBMelIwYlRpRDMzbHlsMEtJbzZDVUc5RThUZzhlR3kxRWlHaVZGZGdn?=
 =?utf-8?B?TkVKdllkL01Nc0JqTEtlUlVvaGRKNjRTNFR6SEkxTy9rUDlGclc0SGw1SEEy?=
 =?utf-8?B?Z3ZvbDNmWmRDdjBweHBBS0Jyd2pMaTJKTDBNYjh5ck1QdWhLK1ZFUm9jajFy?=
 =?utf-8?B?QUFvWW1QaTUyN09MMTcwWXJMKzAwdW9YaE1yK3pndmFzS1dUcmNLRzBFOGhM?=
 =?utf-8?Q?NJ5pNmA7BN5IVP5yeauytwEN2TbtOSlN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjQ3Mk0zWFVtRVFsRUJ4TlIvSWlJTWVGN00wMVJIMjNkWjNteTVJVDdORWQv?=
 =?utf-8?B?eDRwQUZubVNxNXhWSHlJd1pENDFIZW9VMnYwNUFmVEF1aEFmTnJjRkREc3JV?=
 =?utf-8?B?ZldvVTlKOEx0UGpaSm5iNXFBZVplYjF4R0wyK3pJQ3N1b2YwUW1uTFNjZUNh?=
 =?utf-8?B?UTQ4MjBkQ3NEd1ZUOWZIa0s5dEdpQ1lFZHBIc0gwb1JSVko0WFN2OEF1c3I2?=
 =?utf-8?B?b29NdXhrNEVLTE9PUEJ1ckwyYmIwbFRWRVRlQkJ4TmplK1JBOTZSS1NtZFp0?=
 =?utf-8?B?R2Jvb3l2MklxVWl1a3VjY3VrWExFWG5yaEtIMEQ0Y3d0ODh4STJhTHF1bUV4?=
 =?utf-8?B?eFlNRld4YnRQTGJ5endHZlhnQzlpLzJDZ05jbENTaGxucVBpeXdQakRHak5z?=
 =?utf-8?B?d3ptQ2E2eFhicEl6WXJKK1NnaCs4RW5Ob2laM0RVZktlMkphMW1KT3VxVnBC?=
 =?utf-8?B?cEZScFYrZER5YTYrdTdvazc5bjM1YnFRZ3FPRnNxa1VtZXNyTWhkek1CR1Rv?=
 =?utf-8?B?TnhLZjVEeU56Mjc5QjZuTVlOQ3hGaFp6NE4wbWFBMUc4Y1FySHk5bnRZa2JR?=
 =?utf-8?B?WmlaL3ZCQ2o2WlVBSkM3Uk5xMGNmbXEzcHdSYzlkSlpTZW9aazRNN2RGaDZ3?=
 =?utf-8?B?NWtxTm5HRDA1aGpSVmcwM0E5TVJMMTFDbmhPRytHRmV4R3Z6amQzUFpGRGJL?=
 =?utf-8?B?WVcxNUt3VGVJZ0JVbGJCV0JROG5XUnVXTkQ0SHZ1enFJT242NVVXZzVKL1Vl?=
 =?utf-8?B?a2R5d3gvNHFCQmNwY2lPU1hsbUgwUXU3SWVPMTh1dk5uQnZyWGpteFZzYUo5?=
 =?utf-8?B?eVVEb05sWVgxdnovM3NOZXB1SVg5Uk5oN25EcXZZU0tsSk95QUZNdS91V0ww?=
 =?utf-8?B?d1lQYVBhWWovbVAwZHNJRUVLN0ZRQ1lQaEpmY1J3ZjZlcnlQMGloR3ZNYnpP?=
 =?utf-8?B?YW1pREo1VjU3QXNnSTIvdHdYTW9teHpxTnhpcG9PYmpKNGNkeWVKYlZNN05O?=
 =?utf-8?B?Y0RqeWFsNXlTa2Y5RWwrRkpaRmVKTUxrWVhYQldvTndoclk4Y09YN2J0eVoz?=
 =?utf-8?B?TEVONUR2VjJpMG5jTWgzTURUWW9xL2Vabkh1R0Mwak1iNjJja3hUQWtzcnFT?=
 =?utf-8?B?MVAxVEMwam9ubk1uN1lwNEpQRDBxSXJvTDJEanFFaVpOT2xqSE1EWUZROUF6?=
 =?utf-8?B?bjNlWDZqWVlJbTJSNnZWMVRtUXdSMjNqRi9YUFhjRGFqY1hLQzF0emxwUXRX?=
 =?utf-8?B?ckw3MHZKWVpKOUZ6OXg5K0QwQkdBQVhyd3M4WUxIMmlYWXN0TFA1Q3hWbnRq?=
 =?utf-8?B?cFV2WHA3WUdHL2tCbkpNeUttOU5YQnRZa0I1dUFmYXViTHdpcHFnYURZRXFo?=
 =?utf-8?B?b0lZTUU5QWJndjhPNDl4Zms4d2NqcE1yR0NGNlhkK0NJREQ5ajFVTG9RTmp4?=
 =?utf-8?B?c0tFeVdxdXp1QlQyQTJtS3g4UEgvOWE5ZkpwWjJQMHg3c1F2QjZyTXVOZCsz?=
 =?utf-8?B?V0hMeWNzNlJ4aEdlYVZPZHdFemljUDY1cGFhQU1FUFJDS2hQOFVrdy8zVHJw?=
 =?utf-8?B?TFJYYTFJSlloRTVkWVJNQlAxUlk2S2FzNlpWV0NLVTJFRFkvcDdwRVB3UDRw?=
 =?utf-8?B?cFZHY1dEZzJHMjk0RkQ5VHZZbXkrd2JJOWVzRjM4Q2p5ZG1vd3E1SDFsTEFK?=
 =?utf-8?B?Qm9BdlQwVWJLeHRTMzBna2F5RjNreGxOSVdxQi9iVkNGNEh4TXlSWFRBWXJ2?=
 =?utf-8?B?dUdYUDVNd3VOanVIb1A1b3B5dlYvaENQMU03cUF6OVhtOGZZVlkrcWkrdE5v?=
 =?utf-8?B?N0F4aTJtM1k1a3NvdENFYVVGMlpYbkhjRUJUYTh5VVdVUFdrTGJETHVQU3F6?=
 =?utf-8?B?cmJiYktHYzRjdDhKK2Zva0JRM2lNZ3lDZ0dkcjQrRzREUnRqZUdUSTJHOXJw?=
 =?utf-8?B?SWFvWWUwSVBUQXUzUE5wVVFpRWpYWDRyQVkzaWcxUGVSWFZMcFE3emcxdndy?=
 =?utf-8?B?SjB3WkozSFJJSDlJSWJMREhvZjQ0elc0NEFackZ5UCtsZld2eGFxWGdwOCtq?=
 =?utf-8?B?UDlaeXBKeGp2WFFpOVlCU25rZ2ZWQjZJdUI2ZjREcjBxQUxGcGx6c1JqQjIx?=
 =?utf-8?B?b3kxeWNySWVuRUJINWxQekJHRnRVNDRKSDJkU0cyWHR2QXd0aW04NVl1Q2tC?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cad2f7b-faab-4297-f744-08de25c383c1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 10:24:39.6158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7HLJcYTZb5SlotZugQmtS+w0wo4M8WNRQ2jmH3IgQmBwt2QKazlHgr7ZEx5wN1hclE2zD4zNIBQGTavw7kQMdHdpdSHlPQTUfOdGmEN6Oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6336
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


On 5/11/2025 1:16 am, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> Enable ONFI parameter page detection for SoCFPGA SoC64 devices by
> selecting SYS_NAND_ONFI_DETECTION in the NAND_DENALI Kconfig entry.
>
> This allows SoCFPGA SoC64 platforms using the Denali NAND controller
> to automatically detect NAND parameters via the ONFI interface instead
> of relying on hardcoded configuration values.
>
> The selection is limited to TARGET_SOCFPGA_SOC64 to avoid affecting
> non-SoC64 platforms that use legacy NAND handling.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   drivers/mtd/nand/raw/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 754b99bf3eb..a658defe794 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -213,6 +213,7 @@ config NAND_CADENCE
>   config NAND_DENALI
>   	bool
>   	select SYS_NAND_SELF_INIT
> +	select SYS_NAND_ONFI_DETECTION if TARGET_SOCFPGA_SOC64
>   	imply CMD_NAND
>   
>   config NAND_DENALI_DT


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

