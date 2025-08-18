Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63937CA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7F468313B;
	Mon, 18 Aug 2025 12:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="c26rurfx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50A27831C2; Mon, 18 Aug 2025 12:11:40 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 104E9803DF
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1ST/BmIaY14ARwQeG3mHeFMGyeCv/K+f+K8ezllcqYuIhzRWhfkpIagpJVhT2RQy4lGTMgWv9aepV0N2YzzuZ4EwEuNjmAcTYv+LcbGgljho++jqt/Jl7mWZX2vIC7YbFH0knu/Yev1Xhp6F4T4DoWgj6w+uApwOtaZcO13x2UZsE1SOIUG8Vjo4CXAI2YOUpsf3M6JpqEyGP0o0LAGPE+O8maHQ7sGOdjL+fFsXPNrhdnW6civSC1wKfwdh+j2y37qmJj/vE+9No+fDKUswd+3JoBeTLbO6rm07FHRoAJsHf064GopLY6NW9w63dCA+oOujR+Vg6W7rw9uvBxhxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQUJSX1KTDBXNO/HniS0Rvg+FNSlNaSeUyaWu+tzhu4=;
 b=S5RlFrtGwd8dLjQlDIUdGyzOHHvbvwjM4f0tF1hdNzjCC6xRK1xLOEU55kgPm9/a3MHhYIaU5K6W2QaG4yLeOCpqg43TbSd1vYuspgWv6rBv1KKv6qt3XNY+o9aN9tiwf1F4P2pGAMmi4Ywgqap02b/yEZe+6d69Yc542U0ooBKcVBM45oNrNh+F7ozp5h2CGETOVIBuTn7mkzKujj8uJE4LIB5WlpthYwpmSy14beEbXiS52BcX4rApIYJGP8JAL2g+N6Y1jPn3/5FbA6fIgUMbKaudwTKa3TFAIHoltFshUlQ/yZ95Trm5jtljQRW2yMyBZjYteYcqaBOsxzrdvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQUJSX1KTDBXNO/HniS0Rvg+FNSlNaSeUyaWu+tzhu4=;
 b=c26rurfxwhqa9vaIGOWn3t3Q6eIirAT9wpf7Siv9VKIQ3gWFteaHzZzA+phBeOGnw3huKsPYiebwbLv3B5pNcF8EzrmowfgN5pxHyfr/tn1l2fRaOLPxwP15gost2KmC3nIntvLKTXualpXzn8C876RKtSFkR83GXmYx0ryZrgwXV5K4w5Qt9nlLwA6DKnnXOYMTzQP5yh3iehw267RQbgtQKJ+dAhy7DnvMbAoYz4jJlJk2bJjCjnWbIf1QkBNGY86/L/pfyq2uKAJjMD8v5pNBil/h+cWsH6qOBdR4BxIDyEss47fcpaXV9/BtpE/IRK7QxJl9nvhDCVPhfzefpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PAVPR10MB7057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:302::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:11:36 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:11:36 +0000
Message-ID: <46de0ac5-1777-4f05-a951-ea3cc80bfe26@kontron.de>
Date: Mon, 18 Aug 2025 12:11:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/21] mtd: spinand: Enhance the logic when picking a
 variant
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-19-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250818100614.432931-19-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0390.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::15) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PAVPR10MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: 431c795f-4f58-4c0d-bc8b-08ddde3f9d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2hrc20yVklXREovN3djb09RdzdQNXFOeVQrQzlHNFVqS29jcWJQaFFiSzBw?=
 =?utf-8?B?QlJFWEpERzlNUlMyUWMveWhPVVlUWUMvNy95UVdBbjMybXFOT2FYL29hd20z?=
 =?utf-8?B?MFBxdGRHS05WMTFpQVNLaTVwSXhISlg1dGI2QUVQa3FBT0pyZTV1L3ZtRXAx?=
 =?utf-8?B?YTgwMEYyM0pCTVJ1dHkrZThDNWovVlVQTzVSeVdtM3k4QUQ0NjR5Rk8yYWdV?=
 =?utf-8?B?K2ovNG0ybWV2K3hJKzBLYmU1UGsxeGlCWWpmeGdyc01ONUM0SDJyZU1DbXd1?=
 =?utf-8?B?NDRkSkZZeFhPZXZtOGJpOXJaM25FaUg0VFZpcWV6cVVmdmNDUkxLTVdKUXBl?=
 =?utf-8?B?ZkJwMG9QVkVSUXMzamhSOUJiYk02cHZiMkFEKzJ4cGNCMVJjVVJEOHVBSXJN?=
 =?utf-8?B?UUdsMXQzNnpxU2FxTlhwSWFuL29KYlp2QXAxbDRFaVY4aTdoaldkWENEd0xS?=
 =?utf-8?B?aXlVd2Ztdzl3R0tUVWJzZ3QyRHZFSjlTcndBL3ZkdXAyUFJmM1VqL2tQeGph?=
 =?utf-8?B?bEk1aDU5Umo0TW85NFJ2N09TWmJQMm5WZVB1U2hoeFlYYUtzWGVCbkc4cWpP?=
 =?utf-8?B?VXM0MHk5dXh1dERSb0lJN2ZXeCtjRG5rdDV2SHVtMmdwU01iTVBqUHE5S1pM?=
 =?utf-8?B?UXlkNDhDNnNtNzNmcmoyWHk5SkFYNXJqenlPU1h3MlZrSmx3V21QdHh4R3k0?=
 =?utf-8?B?MHZadTV3Mm4veTFmQ2RiaEpVd0hRem5VQjJ5QW9NN09PUVNoRVdIOWZtRWdi?=
 =?utf-8?B?TFlTeTlZKzRBVGtJNHBNYnF5UUxsWHYrWEpBOGZRUjg4czhibGY0RjlQeS9v?=
 =?utf-8?B?c2ZleDRIR0RXbkRLVzVMRFlqTkRqMFIrNjdhcitwOExSZ3ZzNllsRkxNdGts?=
 =?utf-8?B?dEVoaFJPVVdvdW9qWlFYcTEyd1BLL1FEQVJoZTI5cUlmblhCSGxBbzV2bzVB?=
 =?utf-8?B?UzBNUWdudU9qbGJJUzFGL3g4NkgyS0dlVnVLS1VrRVA5SnVxZzE0Yk9sSlBF?=
 =?utf-8?B?S28yNVN2UjNTRVhqR1lZb0haTGNZeDVkSCtQZkdBcUNDT2pvajhoMHhzdmRl?=
 =?utf-8?B?b0tNVjBBa3RZYTZEazJNZjR5bHpmdFNvbnBENFJqSEN2bHFkYWFJQ0Z1a0J4?=
 =?utf-8?B?OTdaYlBWUDlTb2dDNXpZY2M1OVpGNmtkWFRCY1F3eDhnY0xuLzhPL2RjdHp5?=
 =?utf-8?B?VUFtd0N2REtMWWdxa25rbHJzZll5M1pKTUZoVFA4V0t2T2JJaE4xTnoxYmNJ?=
 =?utf-8?B?Y2xUYnh2MTcvK1hBMnRIWDhhQmg4SEdYMUFUOTV6bnhmTFVTMUZJTmhzYkVw?=
 =?utf-8?B?eU81NEJVM2xyUjZFd1Q2ZW8va1JCWU5OUGJESWlWYmFGR3MyRFZha3FhOEhW?=
 =?utf-8?B?SDBoeENOWG1ORW5xSWNNK2hxN29UUlFKY21IdEkwcUY3MmMzL1MvMTE0WVQr?=
 =?utf-8?B?aTd1UGlNZkp4UURGZU5vd29LZ3hRZDFZVkwyRThSUkJDd2RWNFVReU9NdE9w?=
 =?utf-8?B?czNuUytkN1FVTjluRzdQYkdsd2FFMmRzaCs3KzU1cVZ6eGpTRjZFaHBnKzZ1?=
 =?utf-8?B?bFl3Q21SRnFmRFBJLzBqejlZelJHU3loUVErS25lZytZSlY3S1kzMTloZXhl?=
 =?utf-8?B?MzZrWTBtdG5LaWNjbHBmMjE1U2RpdldPYUFwWVhXeEJGNEZHbjNkMEVYM2Z5?=
 =?utf-8?B?NVRVd3ZrTWN1U28raFJ0cFJNRm9US0srVUpGbjRValN3WStJVmx2OUs1dXJw?=
 =?utf-8?B?SjVodnRLMkFoSjJ4Y04xYzBWay9hRVRQaXlTd1VhWXhsSG1teWFLeExoVVZj?=
 =?utf-8?B?SGJXSHhWTnpuN21aVlZTYVhmTXNTakl1M1JvRW1wZ1VLS1hhdU1vLzdZbU5m?=
 =?utf-8?B?cE1YNmZMS2VHZitydk9LRHdiWWZwS2lvaXR4aEVwcVBTY0REdEg3Z3Q0dlNP?=
 =?utf-8?B?a014L0VYSVNzSWtzWE1LeW1GYUdQOWZTeE04ZjE1dC9jU09NNUd6ODdKdDds?=
 =?utf-8?B?bjNqem96SEhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXRpUktuR2NxdW9pMDlGamVpaVhqYWE5RzgvK2dwWWpGeUNHTzMvdENoQTM2?=
 =?utf-8?B?aXNER3Boa3JrQVBLSkI4N0RuV0hpZDNIT2JrUElOSXJYVkZQM2FoUW1CMUdS?=
 =?utf-8?B?dUhqcWxncnA0UEFYZThwWEE0ZEE4R0JJRnR3K3dNV2I4aVJLWUJNb0ZoYi8v?=
 =?utf-8?B?UVg0WnVyQ3dFbWlIYUE4WGhkbEtmM253dU9BUjhSMW5takpUb2hJaHJTaWZ4?=
 =?utf-8?B?TmdnanNlWjF5akQrekFGOCtxbFEySWhHRlJNdmJNRXNCZEdNT0k0Q3pONFJQ?=
 =?utf-8?B?OExSRkJyQ28zbUIwSnRlVXRQR0xJVXFIdTZ6VFBkMUxzU3JOV1BDNmV0U0hz?=
 =?utf-8?B?UitkWmhwSk5lajAzYUtrSVF3NnFlOS84US9XMkxTWWUwQjE5dFRnS01IVzNB?=
 =?utf-8?B?TFNKb2grU3hQTVZDeXQ4TGg0b3ZCS0JQS3M0SmFUc3NudjVZdDNiRzcvdksr?=
 =?utf-8?B?NUNzRVJENTg5S09wSUFZR2hGOG9kamRtdHZTaEVlbmpUbFJsRTVQTm9pSWJH?=
 =?utf-8?B?VTd3VHh2elJOdDhQaHlZUG9HR1JQZWYxRHpDd0EvZFcxR2Y3eW9ieTkyOWlU?=
 =?utf-8?B?QStwdjE2MWRvcGRjYjFrb1hhUkdkQkQyNGYzckRwRE5tNTBBUXhmTXRzRFpK?=
 =?utf-8?B?WEFCUDRBcGJTNG5HSzE5eng1aXd4QTJHcERTZXd4ck1XLzZ1QWowUzd6Wm9X?=
 =?utf-8?B?a0tjZUxtUyt2ei9MYzczZGdCeHlmTnFCSGZrQjNueDB1c01yTGNYQm9vVjc4?=
 =?utf-8?B?M0g4ekhPMjkxakU4RTQyS3ZlSlQ5WGxJNmN2T3dMZFV6T2tYT2xZNnF4eDFN?=
 =?utf-8?B?MnlmZDJnbW5WL2RxYnVubXorTVRoR25XQmd6RnFWOTdXRDNjODMzZ251OTgw?=
 =?utf-8?B?YUZBUTFzZkVxUnlTSVk3M2ZyS3NVRnF3dVZtajVuYS9hYnowVFFUemdYK1h6?=
 =?utf-8?B?cWFpc1FiNnhROVh6ZmNuMTNuWm8vbXh2TkR4dXNpM2pEYXBFUGdFYjc4bUdN?=
 =?utf-8?B?OVM5akUrRHhnUFB5WVg4bllZMEhsRDZzOUVvckdIUXlpT0JJREc1TXZaSmRZ?=
 =?utf-8?B?dCtOYkZHeTl6VXVoUTM1K0NOSHdNNGo5VjJSTWtlcDhiMVZhZ0thT1RhWFVS?=
 =?utf-8?B?QmI0eWJXbWlzZkgxSFZSSERQU2hnMHdWUHp0dWVBYzMyK1NPZjBjQXRkMlBS?=
 =?utf-8?B?bWlxY3NTdjQydXk5UFNHNVR5ZWNYMUlxbGRCc3dPa20wQ1lXa1lJUy9vcmVw?=
 =?utf-8?B?Wmw0djdwRFlUN04xbVRJcjlHOW9pSmtKQlR6ZTgrRUMyb2MwZXRZd2ZVNExB?=
 =?utf-8?B?NUUrQ1FRdGtRUVBOcFRici9OSitucGVOMG9XZStNdGxKL1QxMDR2a1RybFU5?=
 =?utf-8?B?b3dQQ1FGREViYUVndlJmak11NDU5M21KNjlZVTVhaTNKOTVwdDdoUzlrWlhU?=
 =?utf-8?B?dUxrTldaVVhraTBvZjJlRGJxT0MxM1doaWh5L0dGRGtEcjBZT2lMVUlQcE1O?=
 =?utf-8?B?aHJGdjNRLzNqTjZlT1czdmN1b3FydGk1Vnd3YmN5ZzRIUVcveUJmcldmVEZE?=
 =?utf-8?B?ZWl5SDlHZ25HL01hUDViVUR6QnYzWVk1NGJSajA0SGVMcFBxSzFBUjB6NmJY?=
 =?utf-8?B?eS9KbFpnNmVtK21zMXJKUjlJNkhWZUFncFlmY0w2Wjk1ODhmS05xUDRiRTVp?=
 =?utf-8?B?eUdkZjNRSk9XbDBJdTZLRFMwQVMyODlhQmdUL3VIV0l2cVhReUF5VW5RRWY5?=
 =?utf-8?B?c251MW1ZNGRrdGswVFJzQnFYaGx4dFZ0UjYzZmEzcEw2Um9zcElJOE5iSUky?=
 =?utf-8?B?U0hGa0xuQ3hOT096NHVxU1daaG9rSWdnWjdtOUxLMyszNVBqMEN5U2tBZ0Nk?=
 =?utf-8?B?ZWhYazczRWsxVVYzWTRjVGVwc0pKYVlsS1l0dFFkdkN5eXc0N2Y1dnE4eEN3?=
 =?utf-8?B?ODBicUVEMVNpTGNaZEhBTHF6TFB4RlArRXlZd2s1em84VUd0Z0JyRUNSL1o5?=
 =?utf-8?B?ODh1N0p4TGY1c3FaUXU0VkFEaEl0TVN6ZDJXeEJCT1pSQUdhemRiSDdLaEd0?=
 =?utf-8?B?SDViK09yeVRxRG8zckwzUWJDU085MWMvUlBVb3U2SVh5MTM3ZHRDRlQ2UzBi?=
 =?utf-8?B?cEJ3ZTJid1ZGbUprbzNXL0czWDlabmsxT0w4bFhTaVk4djV4MkxHZ3c5bjhC?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 431c795f-4f58-4c0d-bc8b-08ddde3f9d96
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:11:36.5874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwYjnuj6FWizzGvS+2l299DnS9AbWUFgNTaDbSowGnuJb+XkwYcn5X+vtlRwwv/SOjTGglSDquQbp+mBnpFbgpDqgiaZwwjoz0dfX2j89Cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7057
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

Am 18.08.25 um 12:06 schrieb Mikhail Kshevetskiy:
> Currently the best variant picked in the first one in the list provided
> in the manufacturer driver. This worked well while all operations where
> performed at the same speed, but with the introduction of DTR transfers
> this no longer works correctly.
> 
> Let's continue iterating over all the alternatives, even if we find a
> match, keeping a reference over the theoretically fastest
> operation. Only at the end we can tell which variant is the best.
> 
> This logic happening only once at boot.
> 
> The patch is based on linux commit
> 666c299be696 (mtd: spinand: Enhance the logic when picking a variant)
> created by Miquel Raynal <miquel.raynal@bootlin.com>
> 
> The code was a bit restricted in the functionality since not all
> required functionality is supported in the u-boot.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
