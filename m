Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCFBC3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 09:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1664780107;
	Fri, 16 May 2025 11:40:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="a4UrlZr9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B926803DF; Fri, 16 May 2025 11:40:30 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::731])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B75C580079
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 11:40:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyHfNid8O4HPiFl1vCBpScjR0sE8scFGDG8+GLGrohlsROVmqcHcQlW7I41CgnxbLuf7dssq33928ZxE91K+m+Mw6iBH8muiZPL88TeHXLQNrJ8eoMCUUL1a9vyuQIgj6jRL2JFxLhRUnXfqrA4I0N7o1O/VM7LgUzX9KTr3FTSq/VYRsg4Oa3ju4XznsC+Zu83xmUcblJn7ktl3z7sAWKjdbyDBmSoIQj6Mzu/A+QPYx050aTEm44TY8BUMzZDQQPOGl6LD0Ev7JtEHkESrthxOSEWQYTs87VKPPmjFli1mzpuDUsqyq4g4AytjJ+UIVpY9iwm3IqXdy6wJafI4tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28DDDnb1Lyc7woNwEjK4pFWbzm7PZ0UWsSYyHSgJPNU=;
 b=BbNYVfPvEe6w3fJZ6QxMwha4QZnDjuv7B/lJqg1yuOyP6b9Y+xzUhp7QEDTcC/PL2U75ZM3hwcgatyQ9oxEr1H47uGALj4TrPSkGwQuXbfTpklfQqEM4NJLo3w+AeJsB0YHWjfSXPwuswa/IUR6aCz6tWcSZDAbVSygotg0DLTfNiOcQWOZU9VtgjnZhIKlhA1WyFVRv6EK8SzfwT5UsJKyS5dIJ0UTMqZy1oshv2wOOGZNgnB/kWzcXjeuYZIahHLsc3wABakPo1loLtLwd79DOQhFiOz5TtqEQFmDP9OcwJpoDRM+Ah5ITmL+zEPSfKd8GN8wzGMqPn9SBJk2N7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28DDDnb1Lyc7woNwEjK4pFWbzm7PZ0UWsSYyHSgJPNU=;
 b=a4UrlZr9+9YV5u50rOjhuN/DF6/ls8Zkw7ShhMlX2XTroZ102G9vGGQ4f2nxMfBRf0+KbK7NwRl0PtJtwOx4fzQUg9CaWD7QCjaAU60REOZkmsLQAzUtEbLTAyYdX5ofNGnnXcN+NlBdexAr7hpa+gJWwnbdPLfbgMCkWmXlXxDAo7QYAXq0k4IS4JDWqkDNtloZCsg2iPFheBhCbCWt4obyNRlfWe24Tq8rAarDlh4ssanXjL9wNuQZU3wzTV8tjoG9MJrfiDUHgCXPnHp4J3u05daqrEyJ2/OH8GIPMk2tXFhMhUM1wJoTU0N1R3xrxX55sKVemxtngRQbIF4Ufw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by GVXP195MB2623.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 09:40:25 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 09:40:25 +0000
Message-ID: <b200d50f-8148-433f-8dcc-d7197531092f@phytec.de>
Date: Fri, 16 May 2025 12:40:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm: dts: k3-am625-phycore-r5*: Remove clocks from
 main_timer0
To: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>,
 Chandru Dhavamani <chandru@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>
References: <20250515-b4-upstream-k3-pll-miss-v1-0-e38b89f027b8@ti.com>
 <20250515-b4-upstream-k3-pll-miss-v1-2-e38b89f027b8@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250515-b4-upstream-k3-pll-miss-v1-2-e38b89f027b8@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0076.eurprd03.prod.outlook.com
 (2603:10a6:803:50::47) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|GVXP195MB2623:EE_
X-MS-Office365-Filtering-Correlation-Id: c955e1ee-6344-4102-f8b3-08dd945daf79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THhKd0s1UllmZ2VUcjZPUHJLR0hLeEVwRVdGTE1JRHBLaGcwTnNmT2pqQUYv?=
 =?utf-8?B?aytwNVA1WmhiMUxlT2k4VUxWckdsTlpabldrNnpZZ1FMZjVyVitRcmJzSm1k?=
 =?utf-8?B?U0tOMGxzeEdXVkdndzczYk8ySnF6UXZnQk5jN1ZDdGtUUndFeTNZV0VGamM4?=
 =?utf-8?B?RU5rbWwyU012bzBzd1VjYStFV2NXS09GMEpMUTFOUzlCM2JsUVkxWUpCSFM4?=
 =?utf-8?B?MVlEcGVSMWduaTA5ZTRRN2gzZG1oeHI2M0J3VUVnRnhEcHdOdEhlL2JtVjFP?=
 =?utf-8?B?WEFuNWxEOFQxaXpQUlFwbXBlRTRzT2xWL1JJK2pGS2Z2REJGeGUvY002MlBi?=
 =?utf-8?B?SmdsWXB2M3RHaGViOHBMZFBLUjMvQWY0ZXphaEJ6NUpVbUoyYnNnY1AyQUVD?=
 =?utf-8?B?RXBKMHl4eVJtbWZocHJEZHErZzFYOTJ3R2ZYWE8xQnNlWmkrZ1pzanFtT3Yv?=
 =?utf-8?B?THFaT2ZnVmVSbDNGYVdFMnJIMHQwUGh6L2cvaFpnais1akpoRFNtUUViOWtH?=
 =?utf-8?B?dWpzOUlzb015ZjFCcWkyMFphZkNSR3lOVGVLelpNN3MyTGxLT21vM2ZiSG1x?=
 =?utf-8?B?MzllL0tjNjVUOG1sOWU1b0llS2VEV3FjMVZ6NTVuVVdCNzZDNWJIQys2a0xx?=
 =?utf-8?B?SWd4Y2VEYmdhSmVlMkJNRTB0WDNHUU9rU0hZTDNQWjd5em5TcmdrdkY3VzEw?=
 =?utf-8?B?VXBlbFFra21SN0JENENZY3ZvU0VWNWFEemFveThnVDZZc1BhdzlhR2NodlYz?=
 =?utf-8?B?SStmVmdTekFzeENMbU05dkRlTjZFQWhnSWdIeFROL1pzUFdyWm8wTGI0eE5B?=
 =?utf-8?B?QUwxSElRTEcrZTVGTFRlMWhoY1ZoSW5uN2kzTm1nUFBtUGtNemo1RVRGeHhX?=
 =?utf-8?B?R2RHb1ZTQnA5TGJZc2t2bzh5Z2pPUDBkVTc2cnFsakd1eXdwOE9iS1hVVnJD?=
 =?utf-8?B?Q0hVSEIxcXdYRUlFaVZabjBmT0J3N05iclRnaTlUUDJvdm45TVorRXZXTXNG?=
 =?utf-8?B?Vm1nWVlrbGFWL1g4a3UyQUVaenFJdG4xaU5zZXo4bmNVM1QzcnZSOERWc0Zr?=
 =?utf-8?B?OEFxVmZzVGdyc3NLQWIxK0NWdStlWXNUOGhHeEJ3dWEyY0lDSlBXUUxQNkJX?=
 =?utf-8?B?WEc5R1d1b0RpN3QxRHBhdC80ZFhsQ3kvYlZEeFdvTGRBOVFBczNwM0d1aHh4?=
 =?utf-8?B?SE1QUkFsY0FKL2xmNXRwVUNsdEtTVjdpQ1lSeXlQZ0F3VVBib0NwL1BVQ1JW?=
 =?utf-8?B?Vm96SC9YbFoxWFYyQ1pOT01LWnJERmlBaTF1ZlVNVmtzcXIwK3cvODk3dkZu?=
 =?utf-8?B?NlVRUzg4YnJqYTdyNDdJY2J5L1pybWo2THlFQjd6TDdoVTVpbEI0U3Vpa1RU?=
 =?utf-8?B?Z05JNkk5V1hKVy94bWErcmFWaEQ2Q09aWHJZS3N4MVY5VzBOMHdEdzh0M0xi?=
 =?utf-8?B?dEhGS2hDMUtoQm5kQTAxd04rdGJnUENMWTI5dWdYYUwveHdqLzh2bFpRalV3?=
 =?utf-8?B?V1RPWDNRYkZYZFF5SjFiUW41RUhmK1dlRVZjL2pNNDZiMEVZdTRCanRHMFhl?=
 =?utf-8?B?VDlDOVlQN0dFcCtQcENRQjJnM1RwQWFibUVGckZNbTdCMjdoZWxDTklNU0Ru?=
 =?utf-8?B?VUg0bVB0TUxiTlpYS0NhWE5sM3hOT0tMaDVrZTlsSnVrdTBxUWZEWHlJNlJk?=
 =?utf-8?B?bUlkOTVpS2xsQjU4bmxFUWhpakU2VmNuOURhWCtoTitQMG9GdUcrQWhzMGJG?=
 =?utf-8?B?czN5dXRCelByeTU5eUJaSUNSWUNJNUNSUmIwY2thS2F4TGQvT2pDaEZ1RUM1?=
 =?utf-8?B?OU94VDhmeXRqam1VdEpEN3d5QWZLL0gybUNDNFlSam8yVG96Y014MFRva3VJ?=
 =?utf-8?B?dGNPMnRwR1hTaHREdjdTUUNDYXp5SCtzTDJ4bDh1Mjh0bk5hK1dnWDFBZ0Mv?=
 =?utf-8?Q?afNnH3SQDDk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFBFdklHRWlNY1dhV2kwM2czZ044VURaTmRoSXhMSThrRWw5MVpYWmNUdmFw?=
 =?utf-8?B?T1R3NDJiM2VyakoyWXZCeVpSYU5BYnFRS3hQc0o4aDVwZXdnNVdrLzh4V0dM?=
 =?utf-8?B?VnVndnd5U2hzVDVjTVBUZnZBYnFjQnkvVFptWGlZUkVEVndGZThyMTZqaHZU?=
 =?utf-8?B?Z2FYTm5RbEorTzQvaVh0UkxGTTRmcDJvZUQ0ZElPV29NUy8reFYycjYvSHdp?=
 =?utf-8?B?b1BoUHJFeFRqeEVHSGd4aU0xL2R0Q2FaSklSUWV4U3Y5dDJCNndKUjRYbldr?=
 =?utf-8?B?cXduazBaUGwzSkdFNC9QWXA1eWRuODg1cTBQY0tNaTZrUmNRMFoxMVNxVGxP?=
 =?utf-8?B?VHpwOXhDN1JCK1E5bEV0ZkxjUWFlUGFOOFJubG1sc0ZFRXAwV2EyRjhjREZw?=
 =?utf-8?B?QkdNUTBrbTJ1SXcvSEtJSGp6LzQ5dVJyUTBoY3ZxYUlCbkNvMEdMdWpFcElw?=
 =?utf-8?B?WjJuZVZ6UWZJN2NZQmM0UkVhVlo1dUpoTFM4SGJxNG0zdXlNZWF2Z1VFN0dL?=
 =?utf-8?B?VEkxOTZpdWlkblErRklYQ2F2UWVMZGg5Q0dqcXpKTDhvU21zMFFPbFBmTW1G?=
 =?utf-8?B?TkRkamd6enJzY3hhZ3QvQlVoWm43ZFIvU1hkRitHRmY5M2xnVHJnWHF0UmRB?=
 =?utf-8?B?YVVVdEJEOEUzUGExbE02eUlnNGtKSUdxemlNcExXZGxiSGRuTlVNR0xqb016?=
 =?utf-8?B?ODFhQno4Z0RIUnExaHgrUnU5dDZZTG9qb1ZqdGh2MkEwZklNR0NhWnE2N1ND?=
 =?utf-8?B?M2h4a2grUVBVTXlNZ0VUVXpNODhTdlFZS2xkajVZamdqZnh1S2Zkdm1CNmd5?=
 =?utf-8?B?VjZEU3JMNjlRc2srRUFMcFVOVXFFOEdVck1pZU1kR1M2ZVUyaU1aRGc4bTlk?=
 =?utf-8?B?WCtjQzF0MWJ1bWVzVS9tRmo0NVdHZlU4S0puSmNQbHhsbGNuZE91d3ptYUZu?=
 =?utf-8?B?US84RDBWU1lHaUlhM2N1NTZ0N2YzWVNZbkdSWHJJYURoem5HZTdBWktWeHN1?=
 =?utf-8?B?UlpkQko3QUdaczlRNktHR1k3Z0x1b1BHYkxMbGJDYng1SlpXbUI3TXYxNXNo?=
 =?utf-8?B?RE9aajF1L0h4KzFaRnhsbmpnUWo1S3BvT0JlL2NHOStYOWJXWkdHL0VlTjhF?=
 =?utf-8?B?MlI0NS9NQjJUMDZlMUhwWlFWdHpTYklTRjJYMmY5TE9XcXkrOXlhQW91cUNy?=
 =?utf-8?B?cVNBTmhhK2hscks1N3MvK2dKRGZpdk9Hei9qc3FUbStlVjVndXpLK01aMjIr?=
 =?utf-8?B?ZzRBSEU5SGhLaFhaSEs1V0s2eEVNTFh4V2JsTS9LTlk1SU00SEgyWEF3d0xD?=
 =?utf-8?B?ZFhnSlN6SmNROG16d2JHTWptcXR4NlZCdEwzSk5ERXJidzJNVFRWRzBXMzZq?=
 =?utf-8?B?NTQ1SEMza05DTkdpdWcxalFWd1JoWEpRd1FMZ1JOdUNSY1FibFExMTU2Rk5k?=
 =?utf-8?B?N3lEZGxKNzBpdGVuS1lEYVBzY1lhaHZMTFhYYmFJQ0k0eTZzb3p4S2ZMdVV5?=
 =?utf-8?B?bHBDQXltL3YyQmNnQm1NUFUrNm5id3ppSDFRUTlsNTlxdEdXcG9tKzNLejl2?=
 =?utf-8?B?a0Ztb2F0TFZEQTBVQllHc1FCNVlaTy9LN2hzMnFGYUV4RzMxZVhmTklkZ3JL?=
 =?utf-8?B?YkwzbFVMSGFEalZhZllSMS92TzhqV0ZDNk9RM2l5Q1hxbVVHOGlid3BBMjcr?=
 =?utf-8?B?YXNBZVdsZXdjaFB6aFVGOU5QS2Y5VHArWWd4MmNCaGt3UmFsSk42WVNJYlZ3?=
 =?utf-8?B?RjJZRHJKemxscDBrMG1iQmZYR3JPclM5c1VhVEEzYXB2OWFUZmtuU0pYVXR0?=
 =?utf-8?B?MldLVkhNWmlGLy9WY3l0MU9SdlR2dHBNNXAxaEVqSmlIRmpzK1paeVRUeVNM?=
 =?utf-8?B?RExKbTZzZzhtUnN3dU9xdlhxbHUra01HaktpREI2SFczVGRidXJMc2c4L2s2?=
 =?utf-8?B?c3ZMMkJma1JCR25Tc1l3R2I2OWtUVzRzT2xzcmQwbUVudzdOTVVUUmM4TnBn?=
 =?utf-8?B?N2svQisxbnhBMnpEQTFKS21EUGwzOUoyN1ZRZmk5MVJXVk55L1M5VVN2QXBO?=
 =?utf-8?B?Q0tCVTU5a0xZaHNOQkxnRzAzZEVYNk5NNkFRKzV0UTc2WFNsZkpHYWhCZjJR?=
 =?utf-8?Q?PGHEf+GHjIKWAz/QGhGb0OTPC?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c955e1ee-6344-4102-f8b3-08dd945daf79
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 09:40:25.4993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8yZpGf5OWFCovgW5bnaEEuvUAtU5qrJVMwHp2sCfEWzeSGv84uupWXdFqF5eC5ASZk505rLLqFep3Neap7n2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB2623
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

Am 15.05.25 um 14:38 schrieb Manorit Chawdhry:
> The commit 79d91e77f4c2 ("clk: ti: clk-k3-pll: Add additional robustness
> steps to the PLL sequence") introduced a change which requires the
> main_timer0 to not rely on it's own clocks which anyways was wrong.
> 
> Fix it by removing the clock dependency for it, also while at it, move
> it from u-boot.dtsi to R5 as that is the only entity that should require
> it as DM isn't up.
> 
> Fixes: 5d1aac358f3c ("arm: dts: k3-*-r5: Remove clocks from mcu_timer0")
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Tested-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi | 5 -----
>   arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts        | 8 ++++++++
>   2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
> index c001e2c96e8c18f6de79190eda8468f60f1a0b8a..ee273563e8346b89ccefef60d2d72d3ba0304c7f 100644
> --- a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
> @@ -13,7 +13,6 @@
>   / {
>   	chosen {
>   		stdout-path = "serial2:115200n8";
> -		tick-timer = &main_timer0;
>   	};
>   
>   	aliases {
> @@ -96,10 +95,6 @@
>   	bootph-all;
>   };
>   
> -&main_timer0 {
> -	clock-frequency = <25000000>;
> -};
> -
>   &main_uart0 {
>   	bootph-all;
>   };
> diff --git a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
> index 70154409b1275c01ea8722d5bd233ad3fac79078..7132fae36faa40266d573ece7d031b67ee0a507b 100644
> --- a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
> +++ b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
> @@ -54,6 +54,14 @@
>   	};
>   };
>   
> +&main_timer0 {
> +	/delete-property/ clocks;
> +	/delete-property/ clocks-names;
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-parents;
> +	clock-frequency = <25000000>;
> +};
> +
>   &secure_proxy_sa3 {
>   	/* We require this for boot handshake */
>   	status = "okay";
> 

