Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE33FC30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 04:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29536885F2;
	Fri,  5 Jul 2024 06:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="M+oEjA1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A473A83333; Fri,  5 Jul 2024 04:20:59 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::720])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70CB9841BC
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 04:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/ph+deRY095U/dycFbN6IOWpLQi2lXz5hq03k3XMU94/zK+nJpksAc0GXsKMPbFmxBsaQ3pH8cOIpDhI66dWW+aS0Z2iD2jW00pH+zUp8+OcrNBToBlTlavOIhoVmDt1QgTU0q+SuQpQt7qjZND04nJgarQMg12TNO23NUrExVW7rIZSIL1xAv2WqlsFkwV/QVVuXWVq1n9ZJSbIggMxL0yYAQePLtcj5N9CiZe4pBsnY6z7fMO/s+MMDtJ9k1v4YRGkOhohb5xbTyL+9yHpu3QQtEC6UiAWH9iQSh5u1IarjIta2NxTBmPOUewtBLnyp9drWIYulR0xOvzDrVGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCM07xBpQyDWyvRz+ln+OG+WWrhaPDoVjVQ8rxRLqYc=;
 b=L2ABKv6YzYgS/320LSsXfHqmLL82s/iEwbAyAjW6+GRV9E6WYErgqLcuwUlj8L2HY66S/NRAKR+2qVC1vHkoOo6eu0+7RN2yAQbYETIwcag8qWuyrYmQnmWZW8HSXpFe78sS9YBmZJ82VadXK7i4RsQaRaJytNzEcyKlF6WsWT+35grlt6/XtW+SCZM9CnrElbKiBgNaQ6GCcvWwvrz94eMjOxsEScFy1k/dFoh2VsNkC784W9qLkbGqLpLzsfFT2SqOb7eKa0lWt0HIcAxfPn/ksptcmcUEthkRzW9Sn/M7JNHbIClvLucRM5zltA68/iU02zCdoqOqtx5bjxR2XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCM07xBpQyDWyvRz+ln+OG+WWrhaPDoVjVQ8rxRLqYc=;
 b=M+oEjA1zUkU+Bx/SyoNCY6DSig5fkvSlsfBJC2SFrarQtL/QoAVEsqCnabqXKLb78Vf0AjxF3Z6bLnOpxA+XEl+hE2rSqrbgTCJ9N1YXavcDRWKkiyvVxy7VilfNco8P8WFJe3wYLlPZmhKIe5Pe/sle+i8EwHUKWTUGzV+SsQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8488.eurprd08.prod.outlook.com (2603:10a6:150:b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 02:20:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 02:20:53 +0000
Message-ID: <8490d918-ff9d-47c4-acf4-5f18a2699a57@genexis.eu>
Date: Fri, 5 Jul 2024 06:20:49 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] led: Add dts property to specify blinking of the led
To: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>
References: <CAFLszTihEQVMW==2V2Vq9GY_JffKWFgmarshmXSJFkCFyg4pXg@mail.gmail.com>
 <20240703010131.1735100-1-mikhail.kshevetskiy@iopsys.eu>
 <20240703010131.1735100-3-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszTh-ACEnnR2t11aVrog_wAn1Zxt6GF99MBZo6vMK1M+n_A@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <CAFLszTh-ACEnnR2t11aVrog_wAn1Zxt6GF99MBZo6vMK1M+n_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0450.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::30) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 0897ae33-33c6-4ef4-f802-08dc9c991823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d21FdzRzMVRuZXZudEhoaXl4TlQvODlsSDFCQ0VJZEpuRVpZSnlSV3lwVVZC?=
 =?utf-8?B?SFhXTzRZODM4WWZWRXJWdDRCR2ZRekt1Q3BZZjdDZW9QUisxQXROZ1F6d2lY?=
 =?utf-8?B?ZERqQytJdkNCMmY5MjJuSHJFaGxVcU1VZ2xPYndlYS80M0gvTm53akhXN1g5?=
 =?utf-8?B?VnN6eVJzRTE0Z0NEL0tJaXQvWElsc2k4SW50MTFZSVV6c3lxVVJVRk1GRktj?=
 =?utf-8?B?R0xUc25BenJVTWdJUWpEdWVzT3FKUlJjU1kwcGFhU0VXa3dMMlNKZkJpU1pJ?=
 =?utf-8?B?dGwxQitYNnllTjBaeFlUVjI3MkJuWGZDOUUzT1ppK2Z5cUxLZk42Zjk2eWta?=
 =?utf-8?B?bUxWazl1dGdKMHB2bzN2b2xwUHI0cEVyOE1ocCtmYlcvYU54TnNMZ3ptakJ1?=
 =?utf-8?B?NEpvZGxpS0pORzVWTkExbVFnNmFtUG82aEtHRTNUM1NKODFYRTRNRDlFekFZ?=
 =?utf-8?B?OGdCaGVYOGZIUzRPY0xBd1pDSHFDTWdxMkg3YjNZcXEvNC9uZ2dMejB2VXAy?=
 =?utf-8?B?ZEE3R1VlajJzVkxpZk1kRnpxMlR1dE52MHBGOFZveTNld3JQYmk5NnN5aDgy?=
 =?utf-8?B?MC9BaWhGRTNDR0pkWnBHV3FGd2ZzZEtnbm5wMklaTjJPVmFxN21vOWs2YmtX?=
 =?utf-8?B?TGJEMkpKUnB0ZXhaWi80L2o4Q3VCRXorWW5PV2hUMDBpbTJQajZPNUxleVNs?=
 =?utf-8?B?NnBEQkJpWGkwektCSmY5TER4eFZVdURZUURSTnNjaVZraTJHVWVDbmNWMkUz?=
 =?utf-8?B?TmdOSFMyTno2dURla3VMZzRWNE85enVVMXdHTVNPc2FOR29vTEFwSHpsdzN0?=
 =?utf-8?B?THEwUGY4YWErZk4rcC9zNjUwMWoxaWQySFJuOU5mam14R0xnaFdzbGVDeXJL?=
 =?utf-8?B?SVdUeDBsdy9LejRyMFc0OEI2YmtYSDU2VC9BODdoMWlMbGp3VTFQTDZMMmx3?=
 =?utf-8?B?cS9yNkpXRmZHK1RzVTlFNXk0VGtFZFpWOGF6cUY1T2p3M3BvNkx1VEc3V21v?=
 =?utf-8?B?amMzcVhNTDRWSmNJRkZ1dm1RRFhXWm1tR1JHdjBrM29zN1FKRkNyR2tPNC9l?=
 =?utf-8?B?NjdIbkV5QTFsZXN5S2NvY2Y2enh6Nkh5eDBsWUFSMko1TUZCcVA1MHRTcGZU?=
 =?utf-8?B?S09ielFLMlhRMVFNcDlta3I5Z21leHh5YkRpazk5dFBBcUNQcEJiYTZ4OVpH?=
 =?utf-8?B?RW5sazR3a2JzSU9uYXg4clUxYWN3TllqQkVKbzJCdDhvV0lLcmdDOGcxQlo4?=
 =?utf-8?B?OGdRZ1N3UU9wVysxKzJvYWRHaWJJWDJyVkRSZ1Z6ay9iS094eXY4QlNzVk9v?=
 =?utf-8?B?SWlaSjFqMDBWT3oxOStFaGN5ckEyWGRKMVVXaHhKTzNtWVhwL1pUYUhNWG1V?=
 =?utf-8?B?NndwOWx3Q0RaaExnUlpmR2pMZ1BHaFJUbU9tSVZPZ3RvNDB3ZHdPM3NrRUxJ?=
 =?utf-8?B?MUZIMUsrZURmc3B3TzdJbGRjd2dIcTE5NFRUUWdaeUhJTDZUelJQY3lTTEJX?=
 =?utf-8?B?SUE5WmJ4dmpRL2g0Z3QwcTN1ZU5icTdYR0NpWnFENGNPV010RFdlK0xHbFlM?=
 =?utf-8?B?SGpFRjRERDdUSFRENkdLL0c1UjZTMkpCUmhMWWozRFFLNjZLOTJmeHArWjNs?=
 =?utf-8?B?ODVvMGhJQmRCeXZ2c0UvdUNQcGFPWksxa1FqclhsdEJzTUtCZURJMzBheWti?=
 =?utf-8?B?MkJRTTRPZ29BbldlZ01kOWRYaU9nYTIvcE9mYm5zS3lKMUkwbHdNVUFsZGhv?=
 =?utf-8?B?eXVQaDNUbWRhc0lZYXNDSUxtd3ZLVERibVA4KzdSQklZN3o0NDVsbnhoNWlr?=
 =?utf-8?B?b0JiWE5TdDg1UkRNQnIzQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1Z1cy9GZVNLRHhmdEc2eERTNmxWNSt5bTljajh2dkFBc25Md0pDL2VTc3Bk?=
 =?utf-8?B?UTVCR1RTRmlmSmxqeGFHdWp3amE4M3RCQ1g1RU5VbmZVTWp2UG1EbEFEZjhP?=
 =?utf-8?B?VjlhZWRTbFRGOXJUWkQ3OS9KUnUrTkZxTjJkK2xQQzZBM2x0RWc3Y2hFS1Zw?=
 =?utf-8?B?WFZ0WWNadVJyUkdYSEtVd2hZUzg5aWdIbjNXaURPUVh4cjVkWWtkOGZMYU90?=
 =?utf-8?B?UEVmRXI5WWRKK05EdzYvcmg1Ukt2T0lOZDBTR3dNM25GTW0xanVFVkJFVHhG?=
 =?utf-8?B?QUxkQmlrOE5xZzRNc1d5RGJ5c09tUkhtaFdrcHpNdG1kNTUyNHBaVnFRTksy?=
 =?utf-8?B?SE1jVkJhZnJFdlpaQUpJYVltNE5TclRubXhJR08veVphZlIzMHRiNjBkS1NN?=
 =?utf-8?B?aS9PZkZlVnRSbWx6MGRyaXJhOGhJWHNtMG5saHpiOFNXNXoySWZpRVpYZkVy?=
 =?utf-8?B?V3d0WmEvR0hSdVltZi9TZGl1QTBXdmdZZU5HeTJPR21Sd0NTTW5HOTE5N09L?=
 =?utf-8?B?Z0NjVmpnNDNhLzVxejRkZDJyTFE4clcwdnRyVmhBNkJkR2E5eUtWaFNocG1F?=
 =?utf-8?B?T29DdFh0RzBlT0R3cUxHRUE3dTVDblU1aGwxM0xkQlE5dFlWWHlueFkvbW8r?=
 =?utf-8?B?TVdqMUlscEFKeG9Ub1RjYVE3Wmx4Y2pNZXN4eU5DaDd6VERNbjhwMzhBS2tr?=
 =?utf-8?B?ZTdqaGQ4aXc4Nk5Ca2x0MEplRENQTTNNRkhaMU1QK2Z5NC8rWVU3UHFCRjA4?=
 =?utf-8?B?ZXBKWVpISys2Kzl3bGxaWmZxUnh4dHZzOXBndEFWSDJIeHo0aGJVWTFQTmFu?=
 =?utf-8?B?ajY3TTJReUhVNVBTTElnbGRuQmNEWEVDZ0crYytnZ1pYeDNya09yeEdJUmtq?=
 =?utf-8?B?MHdsMGtZV1RmUmlaMk5PYlB3eTFJUEJRekxMQzl6N3ZTMm5GZklQU3g0OTNy?=
 =?utf-8?B?Y210cVRQOVZSUkhKY2ppYjBibjlpYi9QV20vMDNsWkRsNDlmbXdLbERtODdL?=
 =?utf-8?B?Zld2d2pFb3FJVTZlUWI4RmUvYUpEaDhnYWEzUE5SZlA1dExzNVdZUGx5SFpo?=
 =?utf-8?B?VmlyUHNUdWxhS0VudGt6eDljTkdGNGZjckl6NXd6QkxDMWN2MVExTW9uOHh3?=
 =?utf-8?B?MStBR05BckFXVUVzSUlpNldzVWQ5VTdiQkVZQVZBMUNvMW1nVmNxeVNxUWdF?=
 =?utf-8?B?SkNDRWE3ZlVid1NMNkhTajVQL1NNMWduU1l0NzVnc0VDWUt2MW04QnlIM3RN?=
 =?utf-8?B?L1UyelFZYWZKUE55NzJFOGdqY0VmRGg1SnVBS213SDBjN3dtd1J6bHBIRy9T?=
 =?utf-8?B?a0RzeGYyS2R6cnlrL1RQMXdxZ0N1TmduOStEZVhSUW8rQ21nRmZuYXlnMUEx?=
 =?utf-8?B?Y0FQK2VsZnluSmQwV0wzZWNMNlRZd2dDYVdtOVJrZWJHZzhWUzJMNk9ITWp1?=
 =?utf-8?B?NWQ2K0VDaER2YkdDb1ZiRExwVWdNeDQxMzk5NHZhUXk3VkU4dkVhZ0RqbVJj?=
 =?utf-8?B?elUrSFhnM3hXbVFTTXNjcnQwdEkxd0xTa093L2M5S0MwVjF4dFFWM1dzOVBs?=
 =?utf-8?B?aWxHTEc4K1JXRUp6Z1l4YlptLy8yaFJEL0YwNFFXS3BDQjV0SnZ1SEZZdFYv?=
 =?utf-8?B?eElTc1JmNlpBMms2dm9lN0JtRklxWHdnSmJaSjRjUVBINm1SQ1N1QjFEMDZk?=
 =?utf-8?B?a0RNRXM1SmdoSklycmV3U0JDS3RJRHJYU1FNNUZHQWVIMlFLYkN3NFAvdGR6?=
 =?utf-8?B?TkZkNXQzQ1R4UjJrWDhsbWRCMmxZK0V1cnBrZDlabWNXZWxNcnRlRU5ZOGxs?=
 =?utf-8?B?b1dwS0ZDNC9ZR1IrQ2JuRGd4b1A0ZlppRkI5QzVudkcxb3EvRndIOGdSeWxO?=
 =?utf-8?B?Q2ZVdHBvWUYvdzVMQUtGS05RUUkyZVVJUHVtYVFYWkxrbGxNMVhjdy80Mndx?=
 =?utf-8?B?UWdBR2tuL2ZWOVlvMHA1V1lucmRqZVZxR3FsY2ZCMGJhR2xXNWJaQlZteE8x?=
 =?utf-8?B?OGVBV2NPTHhiallEMW16Yjh3LzlPYisrTTFleG5FbytaQndTSWRNK1hMcysw?=
 =?utf-8?B?a2NVWkRZWTQ1MVJVZEZKaWNTb2hBM3RucjNxSk9PU0hickRpZXpBVDFUbnFS?=
 =?utf-8?B?WWZPSmk5bWJkMWtHUW0zc0NjRDJZeXJ0UW81R1Q0dkVHQWZ3QUtyakRpWUpv?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0897ae33-33c6-4ef4-f802-08dc9c991823
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 02:20:52.9981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EH9ESwy/ESN8OT0h0Yibc/psPQ1qLeqXWotPNEiy2nzs4jrAqrhvB25py0UzivgeRU5ZwQcRHU9O0Tn7u2H6lI3YGaZQtTFkGcErFI6a2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8488
X-Mailman-Approved-At: Fri, 05 Jul 2024 06:10:05 +0200
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


On 7/3/24 12:08, Simon Glass wrote:
> Hi Mikhail,
>
> On Wed, 3 Jul 2024 at 02:02, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> From: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>>
>> The standard property
>>
>>     linux,default-trigger = "pattern";
>>
>> used to get an effect. No blinking parameters can be set yet.
>>
>> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/led/led-uclass.c | 34 ++++++++++++++++++++++++++++++----
>>  1 file changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
>> index d021c3bbf20..78d1a3d152b 100644
>> --- a/drivers/led/led-uclass.c
>> +++ b/drivers/led/led-uclass.c
>> @@ -190,6 +190,9 @@ static int led_post_bind(struct udevice *dev)
>>  {
>>         struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>>         const char *default_state;
>> +#ifdef CONFIG_LED_BLINK
>> +       const char *trigger;
> It looks like this is not used, so you can drop it and use a local
> variable here?

Unfortunately no, see below.

>
>> +#endif
>>
>>         if (!uc_plat->label)
>>                 uc_plat->label = dev_read_string(dev, "label");
>> @@ -210,6 +213,13 @@ static int led_post_bind(struct udevice *dev)
>>         else
>>                 return 0;
>>
>> +#ifdef CONFIG_LED_BLINK
> if (IS_ENABLED(CONFIG_LED_BLINK)

This is not so easy. The definition of LEDST_BLINK depends on
CONFIG_LED_BLINK, thus this code will not compile if  CONFIG_LED_BLINK
is not defined. We can define LEDST_BLINK unconditionally, but it will
cause an issue in the cmd/led.c.

>> +       trigger = dev_read_string(dev, "linux,default-trigger");
>> +       if (trigger && !strncmp(trigger, "pattern", 7)) {
>> +               uc_plat->default_state = LEDST_BLINK;
>> +       }
> No {} around single lines. You can use patman to send patches and it
> will check this for you (I hope!).
>
>> +#endif
>> +
>>         /*
>>          * In case the LED has default-state DT property, trigger
>>          * probe() to configure its default state during startup.
>> @@ -222,12 +232,28 @@ static int led_post_bind(struct udevice *dev)
>>  static int led_post_probe(struct udevice *dev)
>>  {
>>         struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>> +       int rc = 0;
>>
>> -       if (uc_plat->default_state == LEDST_ON ||
>> -           uc_plat->default_state == LEDST_OFF)
>> -               led_set_state(dev, uc_plat->default_state);
>> +       switch (uc_plat->default_state) {
>> +       case LEDST_ON:
>> +       case LEDST_OFF:
>> +               rc = led_set_state(dev, uc_plat->default_state);
>> +               break;
>> +#ifdef CONFIG_LED_BLINK
>> +       case LEDST_BLINK: {
> Here again you can use if IS_ENABLED(CONFIG_LED_BLINK) inside the case
> which should produce very similar code size, hopefully the same.
Do you suggest an if inside the handling of "default:" case?
Also see above notes about dependency of LEDST_BLINK on CONFIG_LED_BLINK.
>> +               const int default_period_ms = 1000;
>>
>> -       return 0;
>> +               rc = led_set_period(dev, default_period_ms);
>> +               if (rc == 0)
>> +                       rc = led_set_state(dev, uc_plat->default_state);
>> +               break;
>> +       }
>> +#endif
>> +       default:
>> +               break;
>> +       }
>> +
>> +       return rc;
>>  }
>>
>>  UCLASS_DRIVER(led) = {
>> --
>> 2.39.2
>>
> Regards,
> Simon
