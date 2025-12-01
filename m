Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ADBD116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 10:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3B9E83AA7;
	Mon,  1 Dec 2025 11:32:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="n+Nydh20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A988883AAE; Mon,  1 Dec 2025 11:32:41 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9652583AA4
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 11:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmnu8RSUU7rGbcX681IKcr1rqKi6WrYxIrt9TNOino7YUHQVBtOJdVINFUUsR7kY2X+KaBcEjubQ9R8jJAKBJngA2eKBYVic3LPYFsDcxNI0QdbL+KkXsZQFw/dE5LoNiVHVzBfaNG/wJ8KxngPT423arxlYaQB7McgHgeSRDo32kAR0hTqXw/CABzPzNJv0ZONN8X1hjogTO/87/gmULV2ECMLplIw1743Ge7RNpdkuzJPyffph2tMaRJlMDr+fB30CXHsS7I+X0Ncm6qjZk0ce1Ut0OlDAXR+ptAdTUxJ5Laywlxjc6/Rb6eLfs6LsckCKVsb6vJkRKzZFSV8R8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Yal56luYVn46pNBS9nhjtjTc7DYRyl6kc15EBNs2zE=;
 b=euIqIb9xzccSdfUgV28flhzkhiClWQHfgUB4HkZTlwVw5rjoBDaWRF9hk6gaUzdLMsOjihcQnwk1WHEKq30zncAaJjr4+tlEbpAGNuzW9/afmM0PBboaLt3hnfmn6S/smpPpLluBHzPuPLi9QSJUY8kz2n+PXgv5GFUoB3BZzUhQfZwo6SPUV2DLuXEKFmbouRFcv2RBuG1WxtpNJ0cIol9z5F/oh188xGcLdEzDPIE8wYHyIUlCd8YfwuYjee4WFwGbAETyhSloKPrpxH9gNlkt3mPuvCMq8yLr6Is69oYOCbjHpeXmcIic0ECrNndWh0aOes6RHfDGzoZZs79Y0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Yal56luYVn46pNBS9nhjtjTc7DYRyl6kc15EBNs2zE=;
 b=n+Nydh20DfeSCcVGcFZrmzXssul7FjDvXzrn7It21Ei+Fgsgkq1vR4DZTsNtBSWZGtEn4eg3Bv1F4Us55jnfO10Oyn+W+xwZCBUKF7kowXxYBMd2fWUClrpwhIPBF79wkgihiR56kQ4Fh4nTt+gqDBEnHqPaae0cRR9cVAq/g4KtkpnC+k2ctqfKi63gkuyQQAAJsQHTRyU4qNbPSD8Dmop33YAwsNuiqWbkUmQ2dOHJV6UDKyYYKFjpoh3Lhq9jSHwmYS0gn7gldTXA9fnIrmUYi/0EiKewFOAFw8qxe7pJScEv39ZTV9xsYqZMlrHa3dyqLp0QiVh6kRyFoL8OwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BN8PR03MB5075.namprd03.prod.outlook.com (2603:10b6:408:df::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:32:35 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 10:32:35 +0000
Message-ID: <bf5ba5b6-e012-46cc-86de-805505c6bf34@altera.com>
Date: Mon, 1 Dec 2025 18:32:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch: arm: mach-socfpga: Fix non-Agilex targets
To: Jan Kiszka <jan.kiszka@siemens.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sune Brian <briansune@gmail.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
References: <99585fee-dd5d-4f9f-aa88-0ee34fe02181@siemens.com>
 <3682cf96-0cca-45ce-92ae-9fc33345e3ee@altera.com>
 <f9f6a5e1-266f-4814-9fef-fe39782a36f7@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <f9f6a5e1-266f-4814-9fef-fe39782a36f7@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BN8PR03MB5075:EE_
X-MS-Office365-Filtering-Correlation-Id: c66c9d94-3e25-4378-ce6d-08de30c4f10d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDlYMW1hQnhPajM1aHFHbXF5djV5KzBTTTd5RUY2V2JVMU02djJaeU5zdTdi?=
 =?utf-8?B?QlBtYjUrNDFscE9nMFBhWkQ1Z09VYmZCNEtTMXJMcXJTVFlRT1I1RC85blZw?=
 =?utf-8?B?ZWlCQjBZWTlzQ3pjWkhDQmUvdzdwN0FUTjFXTCtHeGlkVWZZbE8wMTU5c2gz?=
 =?utf-8?B?SnlHLzRhN2UrTWNaaXN1N3dhOUhQT0JYaWhYZW5zbkNLcmEycEl3RWl2Wmdr?=
 =?utf-8?B?Q29IZFk2N3l2MVBETHZkMjVWeDJGQnFnNnlVQ1lVck5EcFdEOFRmQmdwTXRr?=
 =?utf-8?B?VUJIZEh6SnVjTTZPZklKb1kzaFBFcVF0TzhhbE1GeFBzd2ZxYkU3STJ5RUdT?=
 =?utf-8?B?OHdLMFhybW1XOGdWZUVzUitZUzlVTWNZWHU4aEpVbThHZHBlNEZmOVBPZlNG?=
 =?utf-8?B?YUhpdmFJYWJzZFRYVDlaZDdTTmhkbFIxYnNjeWlWL056cVFmRElrQzR3czdF?=
 =?utf-8?B?cDNCcnZvbmRSeHZqYXZiVVhST2hUME1uamhtUnBnT0t1M0w0QnBDQWhNMVVV?=
 =?utf-8?B?ejNsVkE0SVlzdnBVeWJpdDlZY1IxQlQ0bEFCRzlJNlRvWW9HN0ZKcW1MUGdw?=
 =?utf-8?B?bTV5MUk3Ri85L0FheXB4THIyL3pZSjl0RUVuNE8rbVZublU3cDZYZDhrbnZj?=
 =?utf-8?B?YllqVkJJVmtFcktlZWt3QUFibWFqc3ZINzdjWmZTeER5SE0wZDRnU1BqSlFp?=
 =?utf-8?B?MCsrTURDUW1uRVlCZmMvM0xhakE1K1dDVmg0cWJSS0tPRjNPWkdOMnhrUGtV?=
 =?utf-8?B?L0RWRVZJQ1V3L3M5bC9CbVFmTjFqbGp3enY5NXQyWk5zc0t1ZkJKR29qOVIy?=
 =?utf-8?B?aklBUVdBL0FWZG5jckwrUmNtdDY2T3JYdVg2dUVJN21QMjk4MzZKWjI4eW1N?=
 =?utf-8?B?Y3lHQlJsV1drRnlrdzVlOFJEQTNwWWppQnlEMElMY1Mrb0I0VTRrelVnUzhM?=
 =?utf-8?B?VGtOMUgwZVJQb1lwb0hMOWI5VWxnaE5YKzA4Y2h3V0kyUUsrb0VlelNwVjFP?=
 =?utf-8?B?dW9BWEwwdTZGM0lLRm9zNEV1MWlwS0ZVNjFSVGhDSnpLdC9uRGRwMG4vcXFu?=
 =?utf-8?B?Nis1SjNCT1ZNWmVYUy9SWVFUZzEzL2g0cmFtWXdTeDdxRnd6REF2YTRydS9t?=
 =?utf-8?B?aFJMeElZNmFTSDE4SHRMTGEvRmdIcjNSUmdtNUZxWTNYcTU1Q0FQMkFNeXNZ?=
 =?utf-8?B?cFR6Q0plVU1pbGpQWExoYWNMUnJqTmxlcTFWUmpQTXJOTzZoN1o4VUEzaVhY?=
 =?utf-8?B?dDYyWUxvRERHbUt4KzNGb1NTV2RYNUR0MmNtd00vR1lGZVYvb3pjei9WUmhs?=
 =?utf-8?B?WGVIdkVCM1VUK3JTZnNKQnRoK09pdWdnakhlakppS1Q3d29iRlM2MTlnTy9U?=
 =?utf-8?B?VW51b0FiVmhZZ3dycmFqQis2emQrcFZsVTJjeTlxNEl3SWxabGRjMmZvMStG?=
 =?utf-8?B?N3EzVzhuaFFnMWlnd20rQTRNWEpyc24vUkxuV200dDNKeU5yMTlNS0NVRGRu?=
 =?utf-8?B?OXhuRG5OOXNwa214TWJ0N0JiVmRVNVRhT2F1a1ROL0NpcTEzT1hUY1N1TFQw?=
 =?utf-8?B?K0pqaXA1NmptY0FZWXQ0ZnRVUGJSMkdzNEFuZHRpWlJvSWUvUEg1ME5PZCtC?=
 =?utf-8?B?KzJ6d1VES21VbGtGOGcwazdSVEgwaVJYcE9iSFFaVTF6YnFxdmc5UHkvaGNG?=
 =?utf-8?B?RjBjTnVnanUwSlh2UUxzVkF5MHAwek02b0o2c2hPamN6QVFLY1hzSU9SZkFl?=
 =?utf-8?B?VXlwYkhBK1JmSGNTcTBacXRwWGFrSkpqazlYYWRkR0JYa3JZbG51RVhoK0tM?=
 =?utf-8?B?MkxBS1UvM0tKREhxQVBKb0lZdmNHTW1yWSswM09HZ2FMRFNIV3lYTUxVYTJH?=
 =?utf-8?B?UjZJT01vN1FXdVhGM0svY1Y2dzJ3cTR0RTVud1pZTFZoVEptQzRGMW9Ubmph?=
 =?utf-8?B?cENFc1NEbDNGYUlYWHByb1M4QWovVk95Qndlb1RmN3d0U1pXRTJyY1dyYW1x?=
 =?utf-8?B?Q3o5bzNxc2NnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGdiRDBQUVB1SG41VlQxbXZpd29qODA3cExWYm1NL3R6WnVXdHJ5eHljT1JI?=
 =?utf-8?B?SCtxMGV1aGtJWkxseVpVQWNUcG1GZlBxV0ZRQm93Z2JVQUt5d2NnWDlnM25z?=
 =?utf-8?B?QlBiMGxjTHdqdVk0SGRaOTBETnl6TGxNSVB1bCtHWWpVcUVIMlF1QkFPM056?=
 =?utf-8?B?eEJTTjRDZjhCWWJyRklUR1BPUkpQR2lRMEUwL1UzSDdadDBRVWhOaG9jblFU?=
 =?utf-8?B?YnNQQlRLOWlmUXpnMmtGOW81SnVRVElJQ2tZRmVYYzZPSlhvWC95eDJiMDlx?=
 =?utf-8?B?NUF6VW55MVFPNHdKcnN2UXYxODA5SFhTMWZsUDJUU2dXVXI1NDR6UCtWRXVu?=
 =?utf-8?B?NC9abkVZcVNEa1hLbzJta0RYSXpEenBiS1VPcTlXYTJzTHZYUEtxWitUd3hl?=
 =?utf-8?B?b1NrMVJLM01QQkpIZmRCL2JVWDRXRUllVmFkeHQyOTQxRloxa2FTcVJKVUlH?=
 =?utf-8?B?ZFFKYkxXa2o1T0NzcG52UU8zbVJPUU1Wb0tCL3RaLzdKZStzL3U3QU9QY0E4?=
 =?utf-8?B?YnRCRzl6WkRTYkMvaUdka0dEbTFBd2ZYVmphVWNlNGdDV2tTby9BVHRHVmUw?=
 =?utf-8?B?c3BzWFRVL2d4M1gvWk5zQWtvSkdXWklBS2htcmRCR3EvYjJ5U2FXeWl2b21j?=
 =?utf-8?B?dDVqWUszazVYN3AyTFJqUnBHYVJmMGp2ODA0UHJqU0VSUk1lbjhRU3VNbGZ6?=
 =?utf-8?B?dGVIZHY4Umc4TnVIVFBZbnd5TTlPY2lHZGxQK3d3Kys1L2M5dkZVaXZTeDNO?=
 =?utf-8?B?a2RNNlZianV5QmZBTHV5NHMxYkY4WURQcEhXTzVKSExrQ1BJZnl2Q1p5MUFR?=
 =?utf-8?B?Zm1GeWpMTlI5QXd1LzFnWlpMako2cnZIN1R6MmZId0wvMUNEMDR2S0Rzc2xD?=
 =?utf-8?B?SnhOeGZic3BKbWFmTzluVjA1RVlWNHJ5V0R6enpyZnhlMVFuZnNWNUppcUs3?=
 =?utf-8?B?SzZwNENDRnJZT2VKdi9zRERQYmwyUklJaXNIZ2lPQnpBTTUwUVl2cHI1RWVi?=
 =?utf-8?B?S09kRk5ac0xZMHQ0YW5lekwxTFN5eitNTFJ0NCtlNFlOTWlNb3pWK1MzNHVR?=
 =?utf-8?B?bGRzYllrSWNibXRyd0I0cUMyUWJ3andtZHFnMURrc3hLenVOK3M2WlVzSmg4?=
 =?utf-8?B?NFhPR1lFYmNXQXViU1VEeFkzTlByc09teVZqa3FkMVQ5VjVIcGNPTVBkYU9X?=
 =?utf-8?B?ejdTS05vRWpCMWVnM3JvRzVCeWlQUGdxMCtIM1J6ZURkS3lNOXBKNlB4L2xM?=
 =?utf-8?B?eXp3NnVyTThpZm5pd2ltaGNhY1JUd3lEaGZYL3JpWXRROXBYb0pRRU55UUpC?=
 =?utf-8?B?cUJ2TklJNUxoamdlaVdDSlk1QXc3eXFRNC95aERCdzJuWnQxQytYWnJxZkli?=
 =?utf-8?B?bXNDMlIvdm9HeW1RZlB5K1A2SllTcXRvQTU4aHhQajZSWC9VSjV1VU5HSm15?=
 =?utf-8?B?RVZMaThIM3BWQzF4Q1RHVkkrMzVHTnFLUnV3TmxUUGMvV3VwdG96dFhpV1B1?=
 =?utf-8?B?bjFYWWV4YS9MQjZVV1A3czhKWllKeGhlQk1BQm8rRDloU0RrMWxXbUF4cjVo?=
 =?utf-8?B?MkpCK0RCNGx6T0F6S0gyVW5OUWxxYUpndWVSUUdIT1F2czJwbjN3NXpVWks3?=
 =?utf-8?B?NUZ3cmUzQmwvZTB0Ni85NEZqNkpmNG4yeDdsdXRobWhhVVJhQlQrMUEvaGFj?=
 =?utf-8?B?QWpLc0JpbHBLWFlqTUlLRkwySHkyaDFJTUxmQ1JjUDhHVkxIQnpkdERFQTVa?=
 =?utf-8?B?QjcreUxhL1N4NEowcjdGeWVkZW1meWUxUitBK1ozMi93b28veUZrdUNHM2Rw?=
 =?utf-8?B?SnFVWjZXd3NpRFM4REZvcXJ5ZGwxTkIrZnJ1Vk1tMldrallCSDJOK2E2bXRE?=
 =?utf-8?B?OWl6cHFxNnZKaFEyQXJQb1BwMGQyMCs0K1YyV29ITmMrK1E1Nm1nVzJnM1h3?=
 =?utf-8?B?VGp2SUIxZ3FLbWJHUXFUOHltUmRCUFRFSHlkZ0J5cGVlQnkvdzQ1UHJXUHIx?=
 =?utf-8?B?L2cvbkF1Y2ovVStUQ0d2NlE0enc3OUx2ZVIzcU1zdSt5Q3NnUmdHSVR5eFVx?=
 =?utf-8?B?bEVWQTcxWEpTaUhFUGc2ZDZnbDJYVm1pMWtONm9FaFRkZDRkOGhpQUx1dmhZ?=
 =?utf-8?B?NkVqWlFZcDBsdWdwUE1ScXBZZ0NSbXN6S2hiSkRybWVyRWtBZktyRXAyVm1l?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66c9d94-3e25-4378-ce6d-08de30c4f10d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:32:35.4337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPgMggmmqVl+Wyt4sUx52S9Y1FRjc40kIc7p2mEE5Mvz0C95bPzNqJ+NKRyhZ7s0tRDVuZd7WryvtXGMXQD3r2Er0BTPFgvGA34hGRPsQpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5075
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

Hi Jan,

On 1/12/2025 5:48 pm, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> On 25.11.25 04:31, Chee, Tien Fong wrote:
>> Hi Jan,
>>
>> On 14/11/2025 8:07 pm, Jan Kiszka wrote:
>>> [CAUTION: This email is from outside your organization. Unless you
>>> trust the sender, do not click on links or open attachments as it may
>>> be a fraudulent email attempting to steal your information and/or
>>> compromise your computer.]
>>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> The Altera system manager device is only provided for the Agilex
>>> targets. All others were left with an uninitialized socfpga_sysmgr_base
>>> after that refactoring, breaking any boot attempts already in SPL.
>>>
>>> Tested only on Cyclone5 / DE0-Nano-SoC.
>>>
>>> Fixes: 35638172f99a ("arm: socfpga: agilex5: Add new driver model for
>>> system manager in Agilex5")
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>    arch/arm/mach-socfpga/misc.c     | 7 +++++++
>>>    arch/arm/mach-socfpga/spl_a10.c  | 1 +
>>>    arch/arm/mach-socfpga/spl_gen5.c | 1 +
>>>    arch/arm/mach-socfpga/spl_n5x.c  | 1 +
>>>    arch/arm/mach-socfpga/spl_s10.c  | 1 +
>>>    5 files changed, 11 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
>>> index 76747c2196a..f859d54dce4 100644
>>> --- a/arch/arm/mach-socfpga/misc.c
>>> +++ b/arch/arm/mach-socfpga/misc.c
>>> @@ -277,6 +277,8 @@ void socfpga_get_managers_addr(void)
>>>    void socfpga_get_sys_mgr_addr(void)
>>>    {
>>>           int ret;
>>> +#if defined(CONFIG_TARGET_SOCFPGA_AGILEX) || \
>>> +    defined(TARGET_SOCFPGA_AGILEX7M) || defined(TARGET_SOCFPGA_AGILEX5)
>>>           struct udevice *dev;
>>>
>>>           ofnode node = ofnode_get_aliases_node("sysmgr");
>>> @@ -293,6 +295,11 @@ void socfpga_get_sys_mgr_addr(void)
>>>           } else {
>>>                   socfpga_sysmgr_base = (phys_addr_t)dev_read_addr(dev);
>>>           }
>>> +#else
>>> +       ret = socfpga_get_base_addr("altr,sys-mgr",
>>> &socfpga_sysmgr_base);
>>> +       if (ret)
>>> +               hang();
>>> +#endif
>>>    }
>>>
>>>    phys_addr_t socfpga_get_rstmgr_addr(void)
>>> diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/
>>> spl_a10.c
>>> index c20376f7f8e..26828077c51 100644
>>> --- a/arch/arm/mach-socfpga/spl_a10.c
>>> +++ b/arch/arm/mach-socfpga/spl_a10.c
>>> @@ -250,6 +250,7 @@ void board_init_f(ulong dummy)
>>>           if (spl_early_init())
>>>                   hang();
>>>
>>> +       socfpga_get_sys_mgr_addr();
>>>           socfpga_get_managers_addr();
>>>
>>>           dcache_disable();
>>> diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/
>>> spl_gen5.c
>>> index df79cfe0f7f..f1c654e1566 100644
>>> --- a/arch/arm/mach-socfpga/spl_gen5.c
>>> +++ b/arch/arm/mach-socfpga/spl_gen5.c
>>> @@ -72,6 +72,7 @@ void board_init_f(ulong dummy)
>>>           if (ret)
>>>                   hang();
>>>
>>> +       socfpga_get_sys_mgr_addr();
>>>           socfpga_get_managers_addr();
>>>
>>>           /*
>>> diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/
>>> spl_n5x.c
>>> index 81283ef7162..ed4e6f38b31 100644
>>> --- a/arch/arm/mach-socfpga/spl_n5x.c
>>> +++ b/arch/arm/mach-socfpga/spl_n5x.c
>>> @@ -31,6 +31,7 @@ void board_init_f(ulong dummy)
>>>           if (ret)
>>>                   hang();
>>>
>>> +       socfpga_get_sys_mgr_addr();
>>>           socfpga_get_managers_addr();
>>>
>>>           /* Ensure watchdog is paused when debugging is happening */
>>> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/
>>> spl_s10.c
>>> index fa83ff96adc..460a6f88416 100644
>>> --- a/arch/arm/mach-socfpga/spl_s10.c
>>> +++ b/arch/arm/mach-socfpga/spl_s10.c
>>> @@ -33,6 +33,7 @@ void board_init_f(ulong dummy)
>>>           if (ret)
>>>                   hang();
>>>
>>> +       socfpga_get_sys_mgr_addr();
>>>           socfpga_get_managers_addr();
>>>
>>>           /* Ensure watchdog is paused when debugging is happening */
>> Thanks for the quick fix. I’ve reviewed your patch along with Brian’s fix
>> (https://patchwork.ozlabs.org/project/uboot/patch/20251114160423.1518-1-
>> briansune@gmail.com/).
>>
>> Both address the same issue, but Brian’s approach keeps the change local
>> to misc.c and avoids spreading SoC specific conditionals into SPL paths,
>> which fits better with the ongoing DM migration.
>>
>> Functionally they both work, but Brian’s version looks cleaner for long-
>> term maintenance.
>>
>>
>> Could you take a look at Brian’s patch as well and let us know if you
>> see any issues or corner cases we might have missed?
>>
> Sorry, think I forgot to reply back than: The difference is that my
> patch already prepares for having a driver model for the other boards as
> well, establishing that socfpga_get_sys_mgr_addr sets the address, only
> catching the differences in that function. That looks more invasive but
> should be design-wise in line with what you want to achieve, at least
> mid to long-term.

Thanks for the feedback. My intent is to keep socfpga_get_sys_mgr_addr() 
as the entry point for the sysmgr driver model.

That way, when we see it called on a platform, it clearly indicates the 
sysmgr driver is running under DM.

No cleanup will be needed for socfpga_get_sys_mgr_addr() later, since 
there’s no legacy method for accessing the sysmgr inside.

Best regards,
Tien Fong


