Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF546C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 04:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0AA9885E4;
	Wed,  3 Jul 2024 06:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="dLQ2c30v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99625887D5; Wed,  3 Jul 2024 03:29:59 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D5F388511
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 03:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqjbq9RXI6jgZ4tunw4747Z8FsY3nyU9Yu3yIVUGrnci/SC/AVs6RPV6A0xjCr97pyHttIyqVvzAaHr82aHCpG3PUgnJ7XUfIzfULFKxbWxSyMp24pSQEEpJQP+TTHYw0WXFWW8lod8P4BG2SncN4wnaKBFMizlFV6lKSOP7lY3L/9DbC6MQJgHykJlEp3RfqggnEl4vsYqQHKRB1Jh/QgDne6PxLzI6jkZilL7D8u9rD7iz1M1NmtTGD+pZaP27sdDJKpghbNPBzDnbXecBkrhh4e2e1I7B499TZmb1m5V1JRUu5FXDCv4/DNaq6FVIL70qy9kZ1rFqz8cwCC9+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jGH+sfkab5qmlY4jfjFrNKYAAlu4bEJICfNaD6mpHk=;
 b=lwYXCx07uSxRIYv7JNBXNnqT9m0IBxRYQBiEmzYj3fWm6KjaIx/dXlqJ9gcJul+Q+FZsvCym/nFZK3TQ4JKzJjW+VEkKxhizvj1YLfWbxBwC9JjCrdlse0M6nvd2MVOEjfNIkMSCbxtqF9G75NEpZhEF0GOiljIEd5IuPhKvPfISYNmc7SOEg1qhVukFSMJoQKpniDRh4EutopVPzbdo3QcBmdmoskdGCotyx1QKIwkPEh8QOiiKot5BIFLiC7oj1Qzhb8JEkISloJZENFWWbeDiC+BBmL3w1DxedxBmLsZVBeF+GN+lNfcTeNaeD5rZiFeG84w87jSbwLML4INr1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jGH+sfkab5qmlY4jfjFrNKYAAlu4bEJICfNaD6mpHk=;
 b=dLQ2c30vCVp9bJwEtjz0KecN/URi70qujKy1tp6QVLt2HVZUek2VLQ0SFQxArSx6FFD7GeDohqB1t8RQ7cGGjP9FdqyjL2V0I3gDcknS2yXRUV+6Dk/UHM6ejjEwBH1SH/61sis0/QRwt/qpsilr80xhKWBzNZijLZhWrM/oRKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB5954.eurprd08.prod.outlook.com (2603:10a6:20b:287::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 01:29:51 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 01:29:51 +0000
Message-ID: <e45f3b75-5ba0-4c43-a913-4ee545cc6bc9@genexis.eu>
Date: Wed, 3 Jul 2024 05:29:47 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpt: allow spaces in partition list
To: Simon Glass <sjg@chromium.org>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>, u-boot@lists.denx.de
References: <20240627112904.99969-1-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszThsS2oYVx3zxZhN6HSzHkA-NStydZfS=Jr25FpwRimJNA@mail.gmail.com>
 <dd3453b2-2ad6-473f-b419-88a7577fded9@genexis.eu>
 <CAFLszTgtOWNGQFwKnyAADXVgbpiBR3d8NcjaG3VpUQbnnhboeA@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <CAFLszTgtOWNGQFwKnyAADXVgbpiBR3d8NcjaG3VpUQbnnhboeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0247.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e31c63a-0ae3-48e4-3c51-08dc9affa267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGgyeEw5TWZtbWdTbzg3Z1VobVh3L3RBbWJvUncwdGdsdnJVRWxGNXhRcko5?=
 =?utf-8?B?cjMxMW9yem1NNWJzejY5Ui8vNVRxNkpZdUJMaGJJV0JKcFV4U2dWWHRoN2ZE?=
 =?utf-8?B?K3pvU2R6elU4Z1FmeHVZd3dSL255SEd3L25JUUtRQkQrVXRZUE5La3N0Rm5G?=
 =?utf-8?B?OERpZU0ya3d3MVNPMkVsS1RLbmcrYTdVTWJxOXNhc3dHdVpjL3VtR21OeTdQ?=
 =?utf-8?B?ZFFVdjRGTHlxVjMwSGhDZ25yUXRjWHk2bHZSTnlWSmZFejdJT0QxZ0JveHho?=
 =?utf-8?B?cm1JNWNXUGxkUXE5N1MrRFA4N0d4Y2dGNkR1Q2R3aUtHbXZZbXBoaU0zalN0?=
 =?utf-8?B?RldyUW00Y21aaTg0SC82QWorZ0YrL3VrZFhjWGIvZnU3SFhVV2FqWlJPalM4?=
 =?utf-8?B?N0s4VGdLMnhzaDRDWFNGSzZXbU92ekgzTk92V2o2T2dGaDhLeU9hTlJRL2E2?=
 =?utf-8?B?d3d3d3NyYnAycnhMZlFneUd0Wkp0TWNSTjkxMVdPTzhUZnhsYjFNUDZXd2Za?=
 =?utf-8?B?OUhhMnVXOUtDSTVqWVc3dVRnWlFPVXAvbnk3UnlFcEdGVWpNd01kbVhPNXVy?=
 =?utf-8?B?d0doZ3VNYmZEa0JiVEVySG5QWWZMdzdwc1lIRlEwb1ExMS8wY3JUSm5NeEFo?=
 =?utf-8?B?aE5wcmZNakhNOFNlRG1qNlozMDlTOWVVdVFsMkQ1b3RJOFdCU0lZUzUraTFp?=
 =?utf-8?B?T3ozeXgrR3V3QWNIemxVVk5NQ2RXQUNsdWxUQ0RyVnF1a1N1UXdrZkk5L1RS?=
 =?utf-8?B?eXJnU1o3R2NCc09JNGN0L3pqbFk5eTV3QWlGL1NaMUFndkdXc1ZhTEUyRHZu?=
 =?utf-8?B?Y3czTjIyZHN6amgwck9FUkZwZVloampHa3dJM0ljSWlFNng5eEQvTE9jeUE4?=
 =?utf-8?B?N2FoTFhEUjZjZVllODZiTCtwOTg1L2pyTUNuN1A4ZUNIYUNHNmhQRXU0dUIy?=
 =?utf-8?B?NU44aFU0L3lYNC8rOVFNUEZ6MzRsMzZXR1ZjYk9WMlJ1VmFvQ3lQeWxkQ1pT?=
 =?utf-8?B?OFU1TWZEWFpQekt0clJSRDY2ZEExRFFrQlFsYmFlVEVVTTlQMnBLbmhCSFdr?=
 =?utf-8?B?UzQzNkhkREVJYnd3M1RZay9lVTVTY1pHTVZvNWFnVXRhK3Vxc3lCcEowNWkz?=
 =?utf-8?B?bDY4K3Fsa2cvaWVvdTNvT01kUGhiOWJkQy9rS1JyMThCeEFHb1Z6bjVxY09C?=
 =?utf-8?B?RFdNRTFCVS9kclJlYmlsRUs0MnBtazRDK1czWENYam1DRXZzcnMrbzF0TFo1?=
 =?utf-8?B?R3I1aEw4Vm5qYlU1cjhVVmJ3eGhtbndkdmxVSkNBbTRQbnhKUmpjY0NzanhV?=
 =?utf-8?B?TmdaZmJkVmdhdld0b3MzZVRwa2p0ellicHFUQmFUMDB6eHVOQWdiRlVaRjhH?=
 =?utf-8?B?dEsxRzZORVZkSVl6YkRjL05xUmw2eDI0aVRSQ08wSW1UUHpTNDJQV0I4ZXlJ?=
 =?utf-8?B?WEJUdFdaSTFvYzREN05JTW9qWjRGTU9obG9GN2grZ0hhUUVTZ2tRdXZDTkVx?=
 =?utf-8?B?N2xmaW8wRGV0dHhPcDJ1TTYwTjgreVlINTZLdXJmdU9XQU8xeHdrSkV0bW9W?=
 =?utf-8?B?N0ZsOEFINkg1UEhyN3UzZFl0VkU5NUlyc1FkRFp2L09uL1FPdkFqMHQvV01M?=
 =?utf-8?B?djliR1lSRWxYZEt1UzExd2FMaTJPTTBaSS9xZlpicGZLaHE4b2k0REc4N1J3?=
 =?utf-8?B?cm9YaE9yM28ySFc5VlNzanlLS1Z6RUYvUkFQWHNEQ0xzeGY3cmpXRWtrNG5t?=
 =?utf-8?B?eGdQYlZaVzkybUJkRnBEdS94cThsVThwUGRmWTJlaUZtYUQwVmVqM3JBQksv?=
 =?utf-8?B?M0lKWWp4MXl1OGVoK1JaQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUFWNUh4MUI0ZXJxK3d4ZnYwT1l0Z2hqc2ZwU1BraHBxZjgvelh4U21ybTY2?=
 =?utf-8?B?b1hzQVdPUzJSVTc5QUtxc05jRXlMbHpRbHZhQVpHa0xmNWtBaW02RUNRbkxL?=
 =?utf-8?B?Z0ROVXdza2VwY01wQ25RMkFFQlp3N3VJMFZDbzBpODdOS21TM1FEV3VFb3pO?=
 =?utf-8?B?dGtoSG1CZnYzZ0VDTFgybkZFTXhwVU9CL0dnQzVYS2M3RWVocWxKOEpjSXkw?=
 =?utf-8?B?SXVIcTl4a3pUQVJmUTJLRm1FRFViblB1U3ErM3g1VWRrSVVLbWc0VklSdnMx?=
 =?utf-8?B?RWpPR3hKUG1aN0pZa1ZDd2tTYy8zczFCTW9ob1IzYW1Ua0Y3VU0xbS8rOUND?=
 =?utf-8?B?b0JDMjE2WTNmUjh1RnVYLzNmcTBvRitqRGtDNkY3aHVRZFcvRlAyNmEvNHNY?=
 =?utf-8?B?ZTIzSnE4enhCdE5lSDFyd1FMcmd5dnh0Z094MkZSMVBUWFpINFZjY2xLeC8v?=
 =?utf-8?B?dXI0djNDM1FGTjYxS3BSY2VqNTdDNEhTZWZwTkxUcWxUdmdDNXg1YnFUdnVa?=
 =?utf-8?B?VjJGdkhjVmU3d0krRmdOSktWbHlGeHdQYUpVcHhoUFhXUHVoYlBIMjlDQXJG?=
 =?utf-8?B?c0JUaEhtbjVQZERraEkrUXBuR0NiR29OWEdXT1g1eVY2T01xTDNUWWdTaEFs?=
 =?utf-8?B?SStFdnB6QWt2QnlmK2w0Uk9mR0dhRDR4WDJ1ME1kRVZwd292VGluTXI0QzFx?=
 =?utf-8?B?dk4xRk4wa1dwSUYyTEtGY0xVZ3dza3NmdmVvVVFGSzJOV2lYMUxiNFJRL0RM?=
 =?utf-8?B?QWFPNlFUR0QzR2hoaVdFaXNsdEZodUZHcnMzcVJoSUFwUjlZTm56Snk0R3Na?=
 =?utf-8?B?N2J6eUFzTmsxdmdkeWExMEZZOEVObTMvSG5vckthbk52ODl6T0o5aXhqeS9u?=
 =?utf-8?B?WW1JMnQ2Z0x6TnpkcktEbTV2ekNabW8xUVdjejFzclhoU2l6dEJ5WXVpWEF2?=
 =?utf-8?B?MGJwZEpvNE84L2RIMFBKeWg3NUExVXB3UUt0VHNEL2xiYTNIekpUcE5GM2Fp?=
 =?utf-8?B?Q3BvQ2hGRHUxcFJGNWFEcjVFVHRLeEQ0NW13dFZRcEVYSGJ6cTRWMWt4ckNv?=
 =?utf-8?B?Q2tsdGorUmZhbE9jTXkyRVIreDQ3bGJtM3o5N253Y0ppUHpmLzRlbmxLcEYx?=
 =?utf-8?B?WHBXME04Sm9zb0sza0R0UkdlMjdtT1B4N2xrS0k5M3ZtOFJaekNLN0RFOXdn?=
 =?utf-8?B?VkM3YTRPMGpjRi94eTlMdk9KbFdiU3JndmNMd0pMVzQ2b0pSQkNwT0dvSS9u?=
 =?utf-8?B?c3dvcW1qeEZRWlJWNXZEL2FaejAvTmpqR2dOcndZTCt6NkdHUFVSa0YvTVpl?=
 =?utf-8?B?UUQ3SFZzdW9zdGdzR2FBc3hOSThYV21aZitCRldPR25LR3duRUxkQjdaZDg1?=
 =?utf-8?B?aWI3NHNkOWlhS2d5SG1BbzQxUjdoNkVOTVh4WGhkR21sbElUZWdMTnVZS0xu?=
 =?utf-8?B?U2E4TmlLRU5ka3J5ZCtkUXRNaGZrRWlOLytFWWlZdjlJMWdXcExrODh1T25Q?=
 =?utf-8?B?Z0lTOU4wZXRaTVZ3T2dLdW1rSXFocGcyZXB6Rzh1bFpJV0lvcG9KLzViemRh?=
 =?utf-8?B?Y1E0Vi9pMWVUakFuQ1JmQnd3Rm96SHFUUFJ5V0pGbDFkMkxtQ3NEWVVuaEEv?=
 =?utf-8?B?M2VGU2NrbWI0VkFnOURLdWlvUCtoQ0V1MWsrMmdZc2lzeXgydXNHWVYzOFlU?=
 =?utf-8?B?VmNlK0hVOURIQTVvOUM0V0VKZCtGamQ2MjJVeEd4K0F2U0JhbUdVRnZkbFVV?=
 =?utf-8?B?ZDVUbnFESWpKNitWK3gvTHgxMkwzV1hFekFIT3F4WGlkalQ0NjhyQ1l0V09K?=
 =?utf-8?B?clVYRzVubjhrUHpKelAzOEQxcU5UTjBWemo0cmUrN0xtaWwzTmMza0FEeStW?=
 =?utf-8?B?MWZ1aWI1ZVUvZyszb3k0d2dHMzJRRDFIQW1ML1hYeVRlWmpPaHdyWDBKOVpl?=
 =?utf-8?B?WFRqODJGK2lxOU9PYWtNWTRPQmVRSlJpUERweXUrSy9tdVRPRnVpMldCSW5S?=
 =?utf-8?B?T1lSbWY3ZkJObjZ2cFdEL0t1ZFkvc1d0alNNb2FLYld0MzhuQll3eG1lTm1K?=
 =?utf-8?B?bGRjdWE5M0NOellxZzlPalVGcGIxVVBWSVI2Zy92RWxwd2tPN2pmbStyVGFo?=
 =?utf-8?B?Nk9ES0lDQ1k5SThFZHJGU1VIMzNGTUo3bmFSSzFYVmgzR2xhUC92V2JRdy9N?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e31c63a-0ae3-48e4-3c51-08dc9affa267
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 01:29:51.2988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKqQCv1LkyE8Jf3jshWVX9iOEVglRcwSEI2JqC22hywzUM/IO71EisYx1oTj7rmaxcBAuE6dXTsc1axQ3aRS8mM84wDbuv3zhlQGQOpS9dY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5954
X-Mailman-Approved-At: Wed, 03 Jul 2024 06:25:51 +0200
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


On 7/2/24 19:51, Simon Glass wrote:
> Hi Mikhail,
>
> On Tue, 2 Jul 2024 at 10:42, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@genexis.eu> wrote:
>>
>> On 27.06.2024 22:05, Simon Glass wrote:
>>> Hi Mikhail,
>>>
>>> On Thu, 27 Jun 2024 at 12:29, Mikhail Kshevetskiy
>>> <mikhail.kshevetskiy@iopsys.eu> wrote:
>>>> This allows spliting partition list to several lines in environment file
>>>>
>>>> ex:
>>>> --------------------
>>>> gpt_partition_list=
>>>>         name=boot1,size=5MiB,start=0x100000;
>>>>         name=boot2,size=5MiB;
>>>>         name=rootfs1,size=70MiB;
>>>>         name=rootfs2,size=70MiB;
>>>>         name=overlay1,size=20MiB;
>>>>         name=overlay2,size=20MiB;
>>>>         name=art,size=4MiB;
>>> Is this referring to a .env file, i.e. a text environment file? If so,
>>> I would hope that spaces at the start of a line would be automatically
>>> removed.
>> This is refer to a .env file, so starting space/tabs will be removed,
>> all '\n' will be replaced by spaces. Thus we will get a single line where
>> each partition divided from other with a single space (like below)
>>
>> gpt_partition_list=name=boot1,size=5MiB,start=0x100000; name=boot2,size=5MiB; ...
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> But I wonder if the \t is needed?

no, \t is not mandatory. Spaces can be used instead.

>
>>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>>>> ---
>>>>  cmd/gpt.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/cmd/gpt.c b/cmd/gpt.c
>>>> index 7aaf1889a5a..2b29ab98ccc 100644
>>>> --- a/cmd/gpt.c
>>>> +++ b/cmd/gpt.c
>>>> @@ -117,6 +117,7 @@ static char *extract_val(const char *str, const char *key)
>>>>                 k = strsep(&v, "=");
>>>>                 if (!k)
>>>>                         break;
>>>> +               k += strspn(k, " \t");
>>>>                 if  (strcmp(k, key) == 0) {
>>>>                         new = strdup(v);
>>>>                         break;
>>>> @@ -151,6 +152,7 @@ static bool found_key(const char *str, const char *key)
>>>>                 k = strsep(&s, ",");
>>>>                 if (!k)
>>>>                         break;
>>>> +               k += strspn(k, " \t");
>>>>                 if  (strcmp(k, key) == 0) {
>>>>                         result = true;
>>>>                         break;
>>>> --
>>>> 2.43.0
> Regards,
> Simon
