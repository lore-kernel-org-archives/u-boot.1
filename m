Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920DFD41D74
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 05:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D8FE80077;
	Mon, 15 Dec 2025 06:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tyfMB7y6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28A9580081; Mon, 15 Dec 2025 06:02:22 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1457A80050
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 06:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StKeOFv8blZ9dP23GK5b97o/5fw1psUwOiWAq3XKd5Xua8WqOO4w0qBlgSMyvqQkaY7L61h+WW4n6935N8c1HN17a10mtcSaaXKO+rUea6l43T6FjYSaEdx2PeldiTAc7g/2VTxRAadrJ/Nu7wbWAJl6MVuXA0AOlZKJJK3u4CK43H0jxDbUApPRzE66wQNvD1bw7QjezsFPpTEDqeRZTDxnqhDwRfuky8E9DMinP3iBSuCEHggaflHioP1+/lr4KZ37ZnHMcZtSLb96iEGjnYF/fLwOB9pARvAkMfI7xak13RAwLHU9Irv2wrBKWFZSlTXmULbOs9uJiZetB+AJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZBF7adZhfYUjaai8jlP4dMqLUw5D3dZDqnc/HoPijA=;
 b=FvL1RpgP8FjFUTq40W8PubNNqWughd/oEyPyaJJqBba1D1TsYU0qTtRlbDB7MZZNd+bdF0ZFzI3aBEdsAbolcNqhctwm1lNQYujDCWxA/ni/v4Pu8EmzUNeqNWEECeUI5gvrKvFMNDPrzl+fwTD4l2D/UdoO2J4DEm07m1hIQXRUNhDLLtKU8QZE9KxSjv3KQb6vg/Xe3QhU7rFYAfqYz13HDb5juJw4kTNemRmXaCDu1Pgb0N7Nh5XOQTlBycW1omXP5xIjcLIEVYPgbrt/fxORbpfbp3+/xYk2XfIgapWn7kNu29culjw15T4A2IoFHU8URWH/eTL0NQ4WMe2v/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZBF7adZhfYUjaai8jlP4dMqLUw5D3dZDqnc/HoPijA=;
 b=tyfMB7y6v8z1ug+LLmq1rr91zGYEsnLTl6Xbp+Bk0QQq7bngL6DKryS7I8/f9tWuNtPkakM+gTDC7Jtv1yI3hPR+QoZOygzfY8BorotB2ltC5VqP0isP15vv8JAOoNUP48tf4678pXEQb1o82qPPM7CI/qdjpy+5yeJumJ86Otdw0KjisgvMOqL3bDx+Yxps7L11G37BI8BEu6NbsXN2JJj7ngr0mGeoltlMJ6zylk/1OHG6jVSFrs8Ig0y7b4VGCtGVsR02DKZfKhHQKwscDaeCpwNmUyWr6s6sjtjsYydf7W3tlQlqWPfXH/AjO+nFXI/B+DrkQR+f9EPOEh6dCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SJ0PR03MB6598.namprd03.prod.outlook.com (2603:10b6:a03:38a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 05:02:16 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%3]) with mapi id 15.20.9412.005; Mon, 15 Dec 2025
 05:02:16 +0000
Message-ID: <64c18910-266f-4f9a-b580-d97ff1c70dfc@altera.com>
Date: Mon, 15 Dec 2025 13:02:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] spl: mmc: Respect sector value passed to
 mmc_load_image_raw_partition
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Sune Brian <briansune@gmail.com>, Ralph Siemsen <ralph.siemsen@linaro.org>
References: <cover.1765470899.git.jan.kiszka@siemens.com>
 <39d7cdd266cec136e4cb62e236866402a39514c6.1765470899.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <39d7cdd266cec136e4cb62e236866402a39514c6.1765470899.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SJ0PR03MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: bfadee68-c762-4bf5-0cd0-08de3b971dfc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bU5oMnFyVHYwYXNCcU1RNnJUNXBOaE1mZEdhOTV6Z1dBUnM3OXJQV1RhTUJH?=
 =?utf-8?B?NEMvV3AvVEs5ZnVTMWhoTWh6UXlNQ2xzOXVJNHZneWZQVXB1QWFJcmdCcUVQ?=
 =?utf-8?B?eWxzRWxpK0dkV0FXUnNXOGhhWWJqL2FXdklWYnArSmlPVHhqVVZHbmg0MENE?=
 =?utf-8?B?UzlKRlprR1VMaVQ3cUVJUk9TSXhiZ3Q4eUl5bVhSQmZwZVQyZWRqS0hmcHhH?=
 =?utf-8?B?Sm5VOFdqb1lndnBHNTN1SDQ3NzBINTVYQ1ZyMnIvam4yQndXSkFsN2tRS1FR?=
 =?utf-8?B?eGZpaWYwQndWWmlURnJQdHhiT0ROM0lkQ1VjbXFqMVAybFRKbGR4V2FTUE1q?=
 =?utf-8?B?YUtsYm5pcFMvMHZvVWI0QVJrbFFIZkpYUkhOVG82ckJuc3ZibzA2S2NvZVg1?=
 =?utf-8?B?Vk05Qk1ZUW5FbEpLNmpJLzQ3TFJ0Y2dVcXRCNHE5aFN6cEtZODhKRlN4STk2?=
 =?utf-8?B?QnUweHRqN0hyWlZEdEh6K21HSittcWhYSmtvRTROVTIydWxMV1NET01aTWJC?=
 =?utf-8?B?R3hMZlV3UGQ4d0l1Ky84NmRMa3lwbDdEWDFjcmtvbCtjbWg3ZkhqY3N4Tnl0?=
 =?utf-8?B?SHV3ZmxOdmhocFA4blFDaGRKUDc5YVBjVWR1TnlHM3JqcklLQi9Cajl1Y0Vh?=
 =?utf-8?B?OVBxVm93TzJITGdZL1ZaaGpyVUYvSHhhNXZPYzJtSG5Ib3d5bUFZR2VGZnBz?=
 =?utf-8?B?Y2RvNmN4ZGJJcjkwSTBndjNzSU9JNXhYUFZYWk5McTdESVBSeW5VNU8zSHpU?=
 =?utf-8?B?SVMwc0hoU0srVDlVckxrZ1JKNHFSNlNORVI3MzlLM0kyeG9RTndSU0RPL0xU?=
 =?utf-8?B?aGF0WWxuNkEwUW4vbE0vVVQ4MmNKUnVzWENxYm9pOHEzd2JCN0RiekZWYWM3?=
 =?utf-8?B?MHhHTlEwWXBiTnNBV2xJaEd5SDVpQk1WdG50MlBxTWtvbVVycXh6YzBGNFZ0?=
 =?utf-8?B?cnQ3VmFSY05DQjdpYzNqbWlTcVVwaTBUNjJ2amwvc2orajdTUTZVSGZLM2I2?=
 =?utf-8?B?OG1tQWc4R013bzlwTUVjeTZWUThUUjd2OUhDTFU4TExkOEFYTCtZVWtKT01B?=
 =?utf-8?B?Zk44VHVldFUyb3dOWS83WWFnaHlSNGhUVVdneE5Lek5HbnVoWXJ4eHpGbktJ?=
 =?utf-8?B?dWRUcjk1RzY0dFF2RWhWcVFEc2pRdkZCR0c1QWMvTW1wWEZsVDlEMEJoZXpW?=
 =?utf-8?B?L1lhUG1CV21DT21zWnF2b0U0S29Dbmw0Q1ZJNkxDNDNwaDF6M01JT2JvcXVr?=
 =?utf-8?B?MFl2WGYvY3I4QkRkOE9JY2h1RHl2WS9BakhrNU5YdmJSbVJtejlYS2pkejJi?=
 =?utf-8?B?dG0yb09aY1pkYnFWdFpZZzl5UUNPU3VaY0dQMmpRMEN3bHNwUGR3KzlUN3lC?=
 =?utf-8?B?dFJxcTFFQ2ZYcWdwd05lNUlTN2p4MzZobmJTcDNtZmxpNkVPUTRxZ3hWMzlU?=
 =?utf-8?B?VkhMUTg0b2ZCYlo4TzJwUkJSNloyWWVNUzEvWEtGWW8rdWFmV1h5cXVBZ0ZF?=
 =?utf-8?B?V3JSWnBVb2JtMUxqTGxhMUQzb01FRE5HVGxWLytoQ2FGWWpxWFQvV2NqYmFx?=
 =?utf-8?B?ZXJlY1U1S05OZWVjTUFYRjBaNmliYW92d2l2YlVwcXpMWnFWdmliYkMzZXY5?=
 =?utf-8?B?UXNoTk1NWUFBMGRHczFVZ2NRSkRoa2RIaUMxRVovU1ZFcHovZTI4clJiOVVE?=
 =?utf-8?B?WWV6VUg2cmg1S0hJQXhCQ0krbGhRajNGZkZCZC9YTDBRd000dTF4SzViZG1S?=
 =?utf-8?B?VHE4WjdGeVFpcnZJOHNsRm5qK2tJK1hYUmF4MVdxTGt4MjB0bVBibytYeTA2?=
 =?utf-8?B?T3E1R2tiSy8wWHM3ekdTOEc5Q1pqZHhnbVE4M2hTZVNNaDhmNnpweVMrUlhx?=
 =?utf-8?B?MnBsZEwwRC9vWGRxaWt4bVlwclRDbHZJV1dmajhFNkhZYzdVbnZLTkhrME10?=
 =?utf-8?Q?JZu9m/k/bvoBiIHtPufvB7eA7ugeocsi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1RpQlpieHh0YlJRYlBlcjJsZk9oMUhVNGtiRVRDbFEvVzJLRkZNbUl4U0U1?=
 =?utf-8?B?TktaVmtwVEZUQTlzbTJqWUpKSWNLazVUWVdnQm5Uc0hRWlVnK3o5VUd6RXlz?=
 =?utf-8?B?TTJWUnMwc1F0U1hyOGJvTmNvc2dnd3cxdDF4MVFMeHhheEFvOUJaaWVlanAr?=
 =?utf-8?B?eXFKQldOYVJFWDQzak43Q21laElBdXFxNGR0TS9uOGc3c0tPTTF3NmU4TFpY?=
 =?utf-8?B?bXpOUnVCMGNRR0FKZjJCYzViRnRlSkptaUs3V3VrOEl0WWloTHljV3pCdkhr?=
 =?utf-8?B?RXczVnB5alcvM0QxNDlVYytWNEZLa0tXZitZUFlGVWQ4MHNaNUpaaTRzVWdJ?=
 =?utf-8?B?OHlJbHNiN2ROSWUybDByV2NvRWR0ZGdiOU0rN3hlOU1mL2s5d0gyRmNXeWRC?=
 =?utf-8?B?d1IvWDBhZzk5WFNodW1zb01zWU4vdzh3MHNtZGlROU9HUC90NnhyaG5iUGdO?=
 =?utf-8?B?ZHhyKzBhUW1HdmlHbjUyQ2d5VWFsSjdtWHowenJaWFRQQXdoYU1DbXpreGVD?=
 =?utf-8?B?MDgvc1NqR3BQTkV3aU9jS29EbHV6ay8vajZuWCtISWJQaHlreHZpZ2VSelBM?=
 =?utf-8?B?SmhSMnNLSXVnZlEreEFMc2hydkZobXcrK1dVU3pQWng5UnlDNm1rVkluTmJS?=
 =?utf-8?B?MGYwM3ppUjNwV1hxdS9tRnF2UUhacWFUb1BOdk5YckQ2ZXA0clg2OXhuNTJZ?=
 =?utf-8?B?d1c2eldKTktHdjVoSmZZRjhQRG5meUg2ck9Taml1Q3NhU21uU1RHUEtNelUv?=
 =?utf-8?B?Z0hrUmhjQkhaWXVOaVZOa3hraGM3ZDBXc3NQeUJOcmVqK3JnNXZPZjdMQ0Ft?=
 =?utf-8?B?UjgvWm50UjdYUmkrTGlWcVNMZnBWaEg5TXdCVlh6V1dnZlFja1NQeGxXWFVL?=
 =?utf-8?B?eEdtSEVOYlFYNUhLWmFhVXNiWmhzQnRjQ2JHTGFIdDlLQXVKQlByTTJubWFU?=
 =?utf-8?B?NG5DTWZnK2ZDdjUzRGVjV0xKYlVwbDVXT1cxWThRd1l5RDNmWGVHTFNlY0tV?=
 =?utf-8?B?RWpqRmQ5TzhaT29SUnBrR0EyaDV3VXpEOEU5SjdjTHNLOTN4dFBUWGpXQmNz?=
 =?utf-8?B?NURRb2U1U0E5UFJ3aUVJKzkzUkZsZnhlZzNhaDcwSjdhNjc5ZjlLRldDSXlM?=
 =?utf-8?B?OUVrVWp4RThzM0RKZ05JdGM4U1Z5MjNVcVJ6OGx5Qi9CU1FGRkdRVXo3VUhm?=
 =?utf-8?B?eW1pTjVoK0M0Y01DQ0M0aWhPd0hXeDlqK2FLQW5EVGRBY3hLZTZ3YldRalhB?=
 =?utf-8?B?SFFPWEd1QlNGa1I3ZnNabnc5NkYyUE1TcHF6UWVvcmRVblFKV2VMZnhXelRT?=
 =?utf-8?B?L1V6L0MvbVpnUXJ5T1lMZDU2c2hsL0NXR0IyU01DWU52ZTVvQVBpem4vUkY1?=
 =?utf-8?B?dkJQS0xReE1XOG9JcWN3TUk1SHVlczZGQWtTbWZZajhpL2YxTks5ck85YVZT?=
 =?utf-8?B?U0FXS3hXLzk3RE5yNExBTzNlK25ORnl4MDk1VmN1cG96TTArNlIwMFB4YTVS?=
 =?utf-8?B?bWZpWTJnZnNxYmdOY2JkQVd2TGRqQUdjSlNpbndza1JDZThjak1CZDZCZGxl?=
 =?utf-8?B?TVBhakk4ZGRHUU5aMlk1aGFoWElUWWdNZDBRL1FIMEYyNGltdjcyQlF6K1Zp?=
 =?utf-8?B?N0FSSUFxeVJRWHZISHBKc0ZzUkZUT3R2RnNDYTNBZDJBKytKamZpM0szcHpy?=
 =?utf-8?B?SUlqYTd0Q3U0TlpXMU1Ueld1VHVlbVI1T0JKVExPaU9yRjRpR00rYVRBZDBQ?=
 =?utf-8?B?aExmTk1uSUR5UEUyemtMRnZKdHlJZk5RRFp5VXYvalJ0ZEFOZGVCNTgydzQr?=
 =?utf-8?B?dWhXMXEvVUE3aWpna3dIZDNwUFY3aGZJci9SWUlubzZJL3ZQUXhmb053VlQ3?=
 =?utf-8?B?YzIzWjZ1UzJnems2ZzNRTkVPVVRxQXFEYVJWNVI3cTh4UjIyYXBQQlJ6aTM5?=
 =?utf-8?B?dDZtMFlFYTJQbVhlSEdLQzFDNTZZK1FwUSt4VlpSYVNkQy9KN3BxbFZUYUNs?=
 =?utf-8?B?b0ZhY0hubGNzcVE4QUw2Skk1S0ErRWYxMXZZcjdCcW14cE5HeTB5MnEyQ0hN?=
 =?utf-8?B?THprbHAvVk5CcjNWV0dmRlRHMzF5R2lIWnFFWkhtWmlPd3pXWFpCTWVtUHlM?=
 =?utf-8?B?ZXN1QXVRWXFhbEdGa0dzUGVBTCt3a0NTcXZxY3JSendIWHBWWHRqMTBTMHNR?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfadee68-c762-4bf5-0cd0-08de3b971dfc
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 05:02:16.8076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlKhNMY2cL6vBuZ0OTD6kgL0owW2J+X6UU6BvCrUQsCYIED+eW/04Mpo6dKwh3ISf3A5vJCBcywd0BuUfVd2J8YTJ8dLrnEXWW8CxDrWsc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6598
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


On 12/12/2025 12:34 am, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This function and the sector parameter evolved over the time. By now,
> sector is influenced by spl_mmc_get_uboot_raw_sector which allows to
> adjust the read sector with an offset that U-Boot proper may have inside
> the partition. That used to work by chance if both
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR and
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION were enabled. Since
> 2a00d73d081a they are a choice, and we need to drop the condition to
> maintain this feature.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   common/spl/spl_mmc.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index 1942e417075..47cfe4aef58 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -137,11 +137,7 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
>                  return ret;
>          }
>
> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>          return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.start + sector);
> -#else
> -       return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.start);
> -#endif
>   }
>   #endif
>
> --
> 2.51.0


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

