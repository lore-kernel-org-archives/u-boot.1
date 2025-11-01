Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6BDCCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 06:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FF1983A5E;
	Sat,  1 Nov 2025 07:29:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="R6BlAsTl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFA1A83A64; Sat,  1 Nov 2025 07:29:00 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C44583A1E
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 07:28:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLRFJNDtY4ycnX5qcfYLR9FjMveOuBrkXMGxy1dYjYX+LuVZRedXjhiL5okdWuiDhU7OIswHD85Es2lSJEQLRP3tzVOd10jralu45odPWiEpYe08KTQ8+KSLEJDu+8aFP/qxyaBVjxsbSC1ON76rTfiw5R+x0CFKfx4TfqTA81t2gAdyT22UwfshVjxE8qzzhSBHKi03k9znr8XohH/xnzLGQXy9qW/qbF6E5ilxKK1ewpsW+4ccGTydDYgkO4jp8kMcFDkxC7KD/B7E4HmbmyFI6rZewtbHex67A8zwL4uA2HvxXs74CWT3EHkGJMKV0bpudgVH8iSzWWyyQH+6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Os8k2RhPyhcKqOBQaHt3CN7eqdrou8brpayT2S/Gffg=;
 b=ZmsfRlr/CYh+guKx/p8Mw0ogZuRy0encYGGvfBG5ojda9DuXkv2oFz2G+n2KV+63OjEo5rxCIkqY7JhOa+0xUNkhVavrCNJuQvSpuV/EKIzfqVgI7wHAC5wr55sePS7oe4pTmOCSfpfNraZPQ9Uo1P85Pq7W34+UpW7VWagqbtglrzNT1/2iRJvyVDgw/fArXY2XfYPCtFqgFAIl7yL8BU2xFQGqyJ8r7zsahFWyAxwmrGMJ4HJpW2SWo9NjQ3bFCt0WcVt7yTW1WeaGN1AWzIqHv6Lnd2We2YgNamzjB0YRwPM3oE8fKHWXBqzYGdA5CecdU+D5QvO43GgP+Wt9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Os8k2RhPyhcKqOBQaHt3CN7eqdrou8brpayT2S/Gffg=;
 b=R6BlAsTlL8jA2JnvpSCM0O9vox1qzzWRUFmiWm1Npi/ax8zGoE+ECYRLxKPa46arqV57KZ3LpM73Kmp4DhnO3HXL6/w+AD/YobnO87bAinLpSViTsrWKiaF06dnXKFmWeVBXJDrfS62SiygX03qsmxqzqeZLN/sxXsTy6ZLOamsZzOmCqBlvVKPzuk/kJnhF+X6AIuIr+b8RwGr/3u/YoYlcU+vDnu7fm5/yNL1RWkfg10AAQ/sSfKFJrsGZOzx7Nz+MzCM/SIeTM5WDauaNWMaKjk8UGEqchCaVFRlC18hYDqiUhfNdh5Tlu/0ceJH6IJ/UHFBvKQRut46CjiAEaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10488.eurprd08.prod.outlook.com (2603:10a6:800:203::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 06:28:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 06:28:56 +0000
Message-ID: <6716ef2d-314c-4650-9bd9-d5497833ed32@iopsys.eu>
Date: Sat, 1 Nov 2025 09:28:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spinand: add support for FudanMicro FM25S01A
To: Tianling Shen <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: u-boot@lists.denx.de
References: <20251101051942.695907-1-cnsztl@gmail.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20251101051942.695907-1-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0000457E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::419) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10488:EE_
X-MS-Office365-Filtering-Correlation-Id: ce245561-2fac-49df-84dc-08de190fef7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3JkRHc1K1JveEVkZmUrVElUQWVmVWpHcUE3REcrM2FhNEhieEFrTkpNODZj?=
 =?utf-8?B?RXFnZWo1UUpkM3FwNUc0QjlUMGFOSSt0YTdpSDBwMENXZ3ZtdE4vbS9GZHlY?=
 =?utf-8?B?NEtHN0NXNkU5bE1RNlZFdm9VVTlUeGJOWERBZklsN2lxM0w2YWNnNXhvUnFq?=
 =?utf-8?B?Q2dIMVJuRzhJNlVQWnNnbHBPdmZKUFloOVRzQnFjalJvSzVJM2QvQVpucDVh?=
 =?utf-8?B?eVYwaSs2c0xoQ205YjU2KzltdXdURWF3K3FoclgwdHJNbWVZa2c1Y1dnVS9W?=
 =?utf-8?B?QW1vbXZsQjV6UTFBb0xwR0Qxb3A4SlFBTHh3S0hPajF5c1dkd2VIUWM0SlVF?=
 =?utf-8?B?TlI1Tm1OcTYvKzdKTmpHajhjU0I5U3MrTVR1RzQycFpTblk3NUdqT3lhM3FQ?=
 =?utf-8?B?WUYvN29vbkk3ZmpxSGF1TitCU2c0T0UyblBwOEs3OHVlZEszRmdoR2hyT3pq?=
 =?utf-8?B?dy9OUWp4Qzl0RzZtNnRsR0U1WlB0cXJaVXFvK2YvQktiZGVCbWQwVVdsNEY5?=
 =?utf-8?B?TnB5SS9peE8rNDZ5VTh1V3R5dUJlb2dZcUxUbnk1d0lYZVBrQno1Si9hY0FG?=
 =?utf-8?B?OHhzbDlIOWYrN2NwVXpjQzd5NFU1Y2RsOFhHeEhMejY2TzZxSmtncGRHRVht?=
 =?utf-8?B?K0FQbTNxZHBpVGl2WWlyTDV4L21wZS9LZGNzdkVBNTBzbEtDdE9jb3JqYlVy?=
 =?utf-8?B?RW9YZWhlK2NPNmd3ZjY2N2M1U3JScVFacTdOMGowdE5qekdKbnovTlpIM0dZ?=
 =?utf-8?B?REsrTEFCTWhzS1Y4eDhDZnVQMlk3WUZMalV6bmIyMVB2ZHFGY3VabHJ4Q1Fn?=
 =?utf-8?B?UjJBWHIzc1ZSYVJ5WHpxU3JkRVowdnBkYm5jSmdHUkNXbnJxZjgzNk5JZjQ2?=
 =?utf-8?B?S29LRXRDdXk0b01UWXgwVDl3b0puSDcrbmltWXR0UVJSZTZiZjZKdG9rU0lD?=
 =?utf-8?B?djRTTXhuOVVvVHR0ZGRJK1Y3M1k0OVZPaDFheHFKK0RBYkhxS0ZVNHljRnlJ?=
 =?utf-8?B?Q2dVYUUvRGlVUFo0am1Hdm04YnRRTDF4RTk2Kzh0Tnlzb2FmVEcwak1ESVZC?=
 =?utf-8?B?WWZSak5oWVM4YUxxWE1hcnNjTUd6V21STGNQbHI3Z3hnM0hwVGpNQWFySTFY?=
 =?utf-8?B?ZWsvVXo1SW9neWRyZFN3Smc3Q0FhTVlkSkNteCtBbGF1V1J2NXdrcXdQcVQr?=
 =?utf-8?B?eHNXanVTQUpCbHY3K0U2bDB2cEZndS9WdWQ0aUMreCtiZW0rdzBObnYrdTVC?=
 =?utf-8?B?TjV3QVZsN20xbDdXaE5xR2FHZWhEQ0dnalVUODA4UytnVEVQMng3V1VMSldW?=
 =?utf-8?B?dWZmb0psSDh1RUlYV05GbEEvYzdiWkZkU3ZRVTZJdFJWanRsSHNYTFZMTFo3?=
 =?utf-8?B?NXRYRkFZODRzUkRhRkhXMnR1UEs4OHZ6aVZSOUxPcXF3bEtoZFJZbVpXWVRp?=
 =?utf-8?B?TEp5aGJnZEk2VDNYZzNuU3VCdjhvdGdHZ0dZSUJLVDd5OHFnS1dMd0dxMlZ0?=
 =?utf-8?B?SEJFTkdSZE5RWTlwVDJwdzY4T0NvTmNXN0RQSVpZMi9uSThlWTFweFFWRTVi?=
 =?utf-8?B?MnMraytPcHF5UXVZY1EzWFkwSm9GWkd0Rm4vNkxtTWx1QytwdkYvQXlLZjN1?=
 =?utf-8?B?NzBhMmFvOXhRVElnazhEcEZTKzUxTEZBQllFTzZSK1FYbVZseTZvU0MrTjRq?=
 =?utf-8?B?aUpocW9DOVBvZkVSOEFNZHJrT2pjUUpvdmI5REdxM2RpbUdGR1NhZ1pQYW5q?=
 =?utf-8?B?SGw3VFlYSUYrdnpUdlg2V1VYQ0tkeWhkdStYaVJ6YVF3dGxROHVjSE5UVlFo?=
 =?utf-8?B?cEFNOUNjelF3dTFJMzR0bTJ6M1diSm95dHRFbXdkUCt6T1l2MEY5b29PUHBq?=
 =?utf-8?B?cFhLMjNFVmUyOEV4aEowTisvV295b1BoY203T3JLRUtybyt5a1I5eWhsRWZM?=
 =?utf-8?B?Zm4zcWlSck1JNkJJZTZrNHhrbVI0cEVVa2oyV1RFK0hxUlp3ZnltTWpGaDRB?=
 =?utf-8?B?enVvemJBZkNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTBFNGlDUHJWSEZIL3U0SnF6UURNTmtlbStXcUJudkZBZEFLNjBSTmhVbzNF?=
 =?utf-8?B?dDRNSGRuNVhwWFQxZmx6UUk5cHA3Z2lCUHlSVHBGMG1OZFdLNk1QcnRkME5Z?=
 =?utf-8?B?VFlUVlB2MkVsM1ZXd0F1V0hIb1BBWlFSd2R6NVFpdi9pTTN3QTJHQnR4Z0k5?=
 =?utf-8?B?TEN3Uk4wcU1NQ0ordTRBNytjRmpXRHM0MDRoZVZ4TkV3MDBzNVhWSW5oRVhi?=
 =?utf-8?B?cHRQdld4WlBLVU5kRDRJeEtncVB1bldENWU0WmcwUkRKZVdvYTNGUVp1MU9t?=
 =?utf-8?B?V3o2ejI0aWF3VEUwSElTeXZucXBvVFUrd0EyaUZXOXV4UUJwY20zL2g4YnJ3?=
 =?utf-8?B?TXQ5c3VsYlhKSVcxQ0xJWlJWVi9zblI4bHYzRnZ2azRJRDhScUMvVTIyMFRs?=
 =?utf-8?B?R0plN05xTzhpSXFxMVdXMjYrQy85bU9QaW5oQUdMWk9tZnVXZjJGV0ZLQ0hJ?=
 =?utf-8?B?cU9DWkwzVkhUbGVjSHl5UnBuS3dxdkpOakdiVEZaZHRVYnU0SnkyNThycUxi?=
 =?utf-8?B?U3FPTFpvK1VrNnBuTkJpS2YvcjEzWUNEdTJqZXRnRS96dktucSt5aEFTeUY4?=
 =?utf-8?B?dFhNY3JLQVJtSmZTZ0VGeVgwWXl3UDBsL1ZtaWtpbDVxRmhIRkJCSkpvMGRP?=
 =?utf-8?B?cFdueHgxNjNmTzVGZEJuVE9DYTc5anM1K3NPajJYRER0WGlTdVV1V2d6b0tV?=
 =?utf-8?B?SVp1YlBtNUNoRWZSRnl0eENrcFlJVFU1dnZZWG5BMFRVVlIvTW9WS09lRnov?=
 =?utf-8?B?cW5SQ1hPekMyMkRRYlRyTTRvY2F5UFRsMHphNE4xMWs3dThhbk9WblJsOWR4?=
 =?utf-8?B?Qm5JZnNkUnQ3VFl2bGNteExjRnRtR2hNWk53UzhrR2puMmk0OUsxVUExQXI4?=
 =?utf-8?B?SXNGS3NFeGVFTjdzT29BZDFWbTV3NDFsdHNpanhlWkhiK0t4L2NPOWJnUy9s?=
 =?utf-8?B?WHcxaFBhVDBLblRrS3h5R1UyeGVUTXY0Ym12Tjd5dzFEWFllTCs0M2VuNXVQ?=
 =?utf-8?B?amN1NGNHc29hS05LNTNDREM0ekRDeFdDc0V2WS9Oa0E1bFY1MmxoMTg1SGVE?=
 =?utf-8?B?S05ub3UzeWIyZGxEcnIvcGplZzB5SG0rNjhOV21TcVJPZnNNVWdHRDM5elNH?=
 =?utf-8?B?NVRXbC9FUm83RXJiNU1tQXFuakRCRnV6akxXRW9INm9PdDhNU2VRQ3ZFSGsv?=
 =?utf-8?B?YlRrcFVmTVJRRTFRSHJhQVc4TEYvT25qUU12T3BLTlY3T3ZSdlF6dGNxaVRa?=
 =?utf-8?B?Kzg5aC9BTU1jVWRVRDlkdlpLZjJUbHFiZXM1ZHB6dWJPTmVWbnJYZ1VZTmRp?=
 =?utf-8?B?eGtnU2Z5NmRyMmdYZnF2dElDRG92djZudUtmWkI1KzRxbUl6bTY2akRPTGVj?=
 =?utf-8?B?bXJJeHBVekI3SDk4VWliaWJ2OHZkQ2V1SExWT1ViTmkvT0tmT1lMY2Z3N0pt?=
 =?utf-8?B?ZENzTmtyRE5LYjRDb2E3SXZpS2NadXdjWFN6azk5aW1aL1h3MFFRNkNJeFFn?=
 =?utf-8?B?cmhjYnpwMDExNHZjNzJ4aTEyTmhZYkVxc3paV20yUCtYTmt2alhzcTVaRnF4?=
 =?utf-8?B?dXdnQkNJRGZtSGdvd0Q3WU5FSEFCNWxzSDZDZTN0YjJXTVJaOFBOay9vbmIv?=
 =?utf-8?B?UHZwd0krbTBQLzFhS01xNXJIRUZNa2U2enY2ZWFrZEgxVTJGN0tWZENaOTJi?=
 =?utf-8?B?aUNHOWQ1cUdhWGV0MHVxbkQ5ak5LMWZFTHFSS3JRMjMwYWdrVTh6RUIxczV3?=
 =?utf-8?B?b1NHTkgrV3VCa1E1cnl0ZHVLY1ZxbGxnQXdGUkRRY1RSeEFyZjNTZWUzcmxY?=
 =?utf-8?B?MnMzMlFoRHNGd1kxOGpQQTNFcE81TW9YbStSaXo4elA5TVZEVS9KNFBON0Vk?=
 =?utf-8?B?Q0wyTjVwUTJWd3h5eVBLR1VYcmQ1Vi8zaThqUzN0VE1JZXZDOVRMUWZkN0s0?=
 =?utf-8?B?UHREdE9UK0ViNmNtM2RMUlpESitCTVgzc0p4WllwVUhubnp4cGJZRmJSZ1Vk?=
 =?utf-8?B?aG5PcloxZHY5Mmt4eGUxY1FKaER3cHZ5VHdiY3AvV0l6ajZIN1U4cmFua1dH?=
 =?utf-8?B?d2xlN1l5UXlsUExzeVM2ejBZVTdUQzNYRGZhWk1IdS9JakdrVHNRbVAxY3V1?=
 =?utf-8?B?RkNuNDBRZkl0WkpzWmNSK1prbVVoS1hKYWgweklsSGdoK01vRzlpQmNFWnZN?=
 =?utf-8?Q?m0djlbauRjCyBb+ucsFe8LU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ce245561-2fac-49df-84dc-08de190fef7b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 06:28:56.7617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWULjUiEen2z0kSxsJOaAE0q5DpKX9288yCJWvUifhb3EggsO3tsvHOorkiFgLK1bzSE8OJoOB9iV+VpEJvomioVIngSd8OmRnTtdekPTXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10488
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

Reviewed-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>


On 11/1/25 08:19, Tianling Shen wrote:
> Add support for FudanMicro FM25S01A SPI NAND.
>
> This driver is ported from linux v6.18 and tested on a MT7981 board.
>
> Link: https://lore.kernel.org/linux-mtd/20250824170013.3328777-1-cnsztl@gmail.com/
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>
> Changes in v2:
> - add fmsh manufacturer to core files
>
> ---
>  drivers/mtd/nand/spi/Makefile |  2 +-
>  drivers/mtd/nand/spi/core.c   |  1 +
>  drivers/mtd/nand/spi/fmsh.c   | 76 +++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h   |  1 +
>  4 files changed, 79 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/nand/spi/fmsh.c
>
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 152aa1a3783c..a7a0b2cb4b9e 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  spinand-objs := core.o otp.o
> -spinand-objs += alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
> +spinand-objs += alliancememory.o ato.o esmt.o fmsh.o foresee.o gigadevice.o macronix.o
>  spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 0c4350595469..14af42646122 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1227,6 +1227,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
>  	&alliancememory_spinand_manufacturer,
>  	&ato_spinand_manufacturer,
>  	&esmt_c8_spinand_manufacturer,
> +	&fmsh_spinand_manufacturer,
>  	&foresee_spinand_manufacturer,
>  	&gigadevice_spinand_manufacturer,
>  	&macronix_spinand_manufacturer,
> diff --git a/drivers/mtd/nand/spi/fmsh.c b/drivers/mtd/nand/spi/fmsh.c
> new file mode 100644
> index 000000000000..84a567919ebb
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/fmsh.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020-2021 Rockchip Electronics Co., Ltd.
> + *
> + * Author: Dingqiang Lin <jon.lin@rock-chips.com>
> + */
> +
> +#ifndef __UBOOT__
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#endif
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_FMSH		0xA1
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
> +
> +static int fm25s01a_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				  struct mtd_oob_region *region)
> +{
> +	return -ERANGE;
> +}
> +
> +static int fm25s01a_ooblayout_free(struct mtd_info *mtd, int section,
> +				   struct mtd_oob_region *region)
> +{
> +	if (section)
> +		return -ERANGE;
> +
> +	region->offset = 2;
> +	region->length = 62;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops fm25s01a_ooblayout = {
> +	.ecc = fm25s01a_ooblayout_ecc,
> +	.rfree = fm25s01a_ooblayout_free,
> +};
> +
> +static const struct spinand_info fmsh_spinand_table[] = {
> +	SPINAND_INFO("FM25S01A",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xE4),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(1, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&fm25s01a_ooblayout, NULL)),
> +};
> +
> +static const struct spinand_manufacturer_ops fmsh_spinand_manuf_ops = {
> +};
> +
> +const struct spinand_manufacturer fmsh_spinand_manufacturer = {
> +	.id = SPINAND_MFR_FMSH,
> +	.name = "Fudan Micro",
> +	.chips = fmsh_spinand_table,
> +	.nchips = ARRAY_SIZE(fmsh_spinand_table),
> +	.ops = &fmsh_spinand_manuf_ops,
> +};
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index cf9b9656d054..e9561c0a3956 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -361,6 +361,7 @@ struct spinand_manufacturer {
>  extern const struct spinand_manufacturer alliancememory_spinand_manufacturer;
>  extern const struct spinand_manufacturer ato_spinand_manufacturer;
>  extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
> +extern const struct spinand_manufacturer fmsh_spinand_manufacturer;
>  extern const struct spinand_manufacturer foresee_spinand_manufacturer;
>  extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
>  extern const struct spinand_manufacturer macronix_spinand_manufacturer;
