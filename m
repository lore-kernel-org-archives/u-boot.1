Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADBEE7BDBB
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 13:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82FDE80FA1;
	Mon, 16 Feb 2026 14:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jnHbWE3n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AA2A83C61; Mon, 16 Feb 2026 14:18:30 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 555A18063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 14:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGZ9PqPiGavbmCihbKCbFmqGJ+y4yEPg3LlGjn+9XzhneEAF3PLp5TtoCQ5tyA/AqOXaQoft6Dh3uFxtGMXw1P6dnrCBYImRIW+uZxpYft5K/3F2VHukApLM2p5ciab7XxHccDZ6Qkko5kSqoQddvp9BvKbkA9+sjDQo1UPOxbVuJxZzYcJYxinloin/6miZHcezWpVo1eXKIOlGVxYFcI+P4hHd3bhXGPZ6/NS0yRD5qzC4bLOJgO+OuC5WwvnM14MDb6ZmzfkRt4TgDVuLT23nmhlBjp/LFy3y6xRxUXJP50CbwEOAzpvst/1zuL9cYiaBHs5BALKuh0SXU0A7fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgr9jzAJJmhyQLgRvYiA6VF4UP8VEyzf7X1QggZeHRw=;
 b=gGXQlCdCjti2sq6pnZFgUJkRcJSzJGvLcRBxoLKL7bsgqiaAX0PjFDzIlsdKtKWuRPhGIqpIfnDO3EflbDZ5PCZjEFdRQ1RM8c+FXnx0Iqq9dIawzT7wSeZDAf6al4q8genlsD8tle0gS6nmiXZiZPuc+LsCllv5/0cA9hZ/2b0Ta51REOSkfoI1RKFSu2io0V9pDqv94+p/DkNoydoy+jTenvq0pfIIMu4RabXjrEi9qCMvcHuelOic3V7UtHS1K0CY105w1kYHSo7b7/s3dSUrcyEqznT2m9PJuWBCgyy1KI6uIt20T5HDpFkR6uQxlvb1UN4CyIS65WzuGSJLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgr9jzAJJmhyQLgRvYiA6VF4UP8VEyzf7X1QggZeHRw=;
 b=jnHbWE3nV0ABrosAZ8tHaqBajYcP19DFuv879ZNFxX3ONb4HKx7b6qUy8qyy13YhVGjQsdKk6wYszdLr0a3VLumCjrk9rYydAZl5mJJ4K9WsHT2uDUN31HeuMgmDaHoZceFRjHa58WCWaByrHrRd2xXmB3O2jnnSWa/zBLH/7s8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 13:18:20 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 13:18:19 +0000
Message-ID: <7526e8aa-99b1-4345-b717-24145847f550@amd.com>
Date: Mon, 16 Feb 2026 14:18:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] efi_vars: Implement SPI Flash store
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Shantur Rathore <i@shantur.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, git@amd.com,
 u-boot@lists.denx.de
References: <cover.1770825377.git.michal.simek@amd.com>
 <35ddf2fe394ee55c66f349dc5cc33fe1dda8f864.1770825377.git.michal.simek@amd.com>
 <1508c7be-0700-43ec-adfa-29ea16081b2f@gmx.de>
 <e5c63fcb-c88b-4550-bf5c-de46a66db0a2@amd.com>
 <E2042B0B-0842-4FC0-B4A8-49D195E5A532@gmx.de>
 <CAC_iWjLuCLQ7qNajbY_i-sVZdc2J+8rNPgsA56A7q1O8x3EEaw@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWjLuCLQ7qNajbY_i-sVZdc2J+8rNPgsA56A7q1O8x3EEaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::22) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa85ab8-ec78-4b8f-a1ed-08de6d5dda4b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWlEbnBqTUZGWkErVDZUSGRudFdYZTkrajNLcXd3RGtmZUtHd0FaWHBCQW5l?=
 =?utf-8?B?YTBNcGhTeG1qeVVlVUNQRHFGcHZESEpIZDdZQ3BsSno4THlna1lFQ0pPQlB3?=
 =?utf-8?B?L3JSd2MvSExCb01XVy9malF0d0tGMmYxeHRtUnR4RHdVVU5aa0RQRWdVZ2ZO?=
 =?utf-8?B?T0c3RXJyeUdNcGJKak5FdDQ0TU1qbHRsVnFocEN0QzJnRG16aVNGdEZYUE5W?=
 =?utf-8?B?SGJJdVhHQkJaMzY5UHhYMU5pYjBmUzFOUEtZMENML0c4VWljZXNSTDQ1dC9Y?=
 =?utf-8?B?OHVqZGFrc3lyT2RFa1BsNytzN2tvZUVQUHE2NVVzaklUSk1xdk9kcVQ4SkhE?=
 =?utf-8?B?ZWN0c3ZMaSs4RnNJV0J6TEw0VFZxcDJEMm8xdGU1QS9jVU81c0RoM1pvQWZH?=
 =?utf-8?B?Y3BTbHNIWUlPcXBtbTZlbEkvbnoybVV4K0UxaEx4TUkvUitBTFYyNjhaK1F4?=
 =?utf-8?B?SGxYQjIrR1dLRFZUT3RKcUo1Ykw5NEZlZWFmRUxxWTErU2RqYzg4ZzJBOU5E?=
 =?utf-8?B?SEZBaDR0dUhJMXhPaThXYjUxWVRUbkF6NnluMGYvMSs4ZTcyeEI2cFFUdjBa?=
 =?utf-8?B?cWN1Yk5RRGNyYngxamxTbWZCKzArNld2YmNOdkxmU0gyWSt1dGdnSnRUakpO?=
 =?utf-8?B?OVorMU9XM2hlMXNrcXhFZFM4RlE3eUJ5Y2t2VVRtcUI3MjJGS2lLZjJHMWhm?=
 =?utf-8?B?amMzcXRFRU9WLzNSRThjUmJHNllLOXRhcEdYZXlVZXhpUEgyUXFhbDdsUERP?=
 =?utf-8?B?TmtEUmZ3N3VNdzJ3VlRub09xSGM2OUV5dEtiNW55MmVuME9KK2VRRWttNHR5?=
 =?utf-8?B?bXVKUEFPQ1dJam4xakJmYXZMM2dYVU1WTWRwMHN3c0NKcEI3OUFuLzdHMXAv?=
 =?utf-8?B?TTZENlJGajZKRitSRUFzYyszOXpIc01pcDdPbU5rVTA1V2RlYTBNSlQ0cCs3?=
 =?utf-8?B?dU1VcDZNTVJ4TnVyaGVkZVBNYzVCckZDcmtVenU2T2lmcXZoUDF2SFZKRWFs?=
 =?utf-8?B?a3haYUd4OFF5RFNLZU9QOFZEckhDNjFBbEtOZkpBeTlGbjlhb3dvclI2cldV?=
 =?utf-8?B?WlN1dGIzT3pGZSsyNmw3WU9qUjhLRDNkc1hEZmw4MEJQZ2Z0NEdRV3FLWkNC?=
 =?utf-8?B?eHg2L2trR25qSVlWc0NmVkRaZC9BMjdOM254QmVjVnh4SnI4Z202ZzJsMTRv?=
 =?utf-8?B?ZnJleU5EbEFlMGIvQzZBaDRWaUl6ZWNUY3BMQk0vbHZaZnJhb2JveXBwYWtG?=
 =?utf-8?B?c0lxbHlBY21neFEyMnNOZ2JXMzQwcjd3Wldzc3pXS0NhS0EzZHB0c2dIMkkx?=
 =?utf-8?B?OG0vSmh5SW4yV3paZzdSY0VBY3R4WlBLd3lKL0tWRnhuVndhSW0vWjVDZlpH?=
 =?utf-8?B?Wm90c080eG9VcXo1QlZRZXE0aVBPeG1iMVY0VmNFNG1oTERaMmswSEU3MGhN?=
 =?utf-8?B?ek0wNWZwSUdVMWdYTnFzME11M2R3dFRCalRHWkJvN1BobTgxNW9zR0U3a2ZH?=
 =?utf-8?B?RjJpVWI2eVVBWDVGbElXOXNwV0lmRFBFZ2ZOMDVPSnAvOHUvcmlkNWZIN1lx?=
 =?utf-8?B?U2YvMW81L2haSEdmUzhZOHlwUG1uQWtsV0Y5WjlIMTRTY0ZMVk1XdFRzanFZ?=
 =?utf-8?B?Y1lVRzE4aERjL2g2dnhiMWdvM2xrSFYxNG5mYS9QOHp2YXRYbGF4d081VVR3?=
 =?utf-8?B?YlpobDZhTzl5NjRaemo1cUFzMHVGdmd0T0MxQ0ZJam5TdHBacm8xeElzVUx4?=
 =?utf-8?B?ZTdWWHVZNEUveWU4eTRERDRIMXJ1dXhpaVZ2ZWRkcnp6SGhaNGtkL1QvcGFG?=
 =?utf-8?B?cE5wOXhuamRpRjVLa1NzcHhMaTJyeCtReUx1MG1udEROaFpnV1RzMVFQR1l0?=
 =?utf-8?B?QzV5NmZqRldFdTRmZXl4VUtnQUUxVWt1WUNTdG05Z0ZFNTFXWTlXYlg0eE41?=
 =?utf-8?B?bExZWHZRK2hhQkEveFVUOGpIcEZoelNSZHFmOW5tL1BBaXFsV2FLMll3Tm0x?=
 =?utf-8?B?NW1CdXNoaHQ0VHB3eFlORFVZU2YzRzdySVVMNlR0MGQ4TWFzTmRlNU02QUZj?=
 =?utf-8?B?Q0hpYkR6aFdVT1o2cG9XQXlEenFvT0tPNTd2MXB0dEJJbDN0NWtvcFJRQXo5?=
 =?utf-8?Q?wftajm0i3L+8OpMTTIWSyLDR6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWJLYXlZRStBNGVRRFVCMWhIRUJoZGhuNUpEVWZOU1ZvSWVZRURXNUlrSm9B?=
 =?utf-8?B?T2RjNzEyTXFiV3NjVW93Q2NhWXgxY2NsbGhoNHZMVDllNXNNa2M3VmhYTnZl?=
 =?utf-8?B?dW5WY2JMem9UUlJHQ2xJWm1Fb2JVRi80MnhrTmFwbElhTXlzZ1hzNEJEVHU0?=
 =?utf-8?B?MVZ2L3lCZ2ZId1lPaytJMjYxSXhkb29jbGlNa1pDV3AzTkZHdWFBb1VpOHA1?=
 =?utf-8?B?YUlSeTVXYjZkTWo5ZmNqWENYUHN1ME5OcGFZejIwU3RZZG9LZVlmbWJ0cTV5?=
 =?utf-8?B?RCthM0U5KzJDbHpFdERibWsvaCtHL2k1WXloY2QxN3B6dlJrYjlPSnMrU0g3?=
 =?utf-8?B?cTNMRTdaMEM3TlVlNFRKTnJ2Z3BGVEVmSGZUSDQ0WW5JNlNGenhtR0JKS3lK?=
 =?utf-8?B?Z2tkL0xjQmlCd3dXTXF4ejhVc2pxdXRuM3RSVzVIRVE4SENPNEo2SzVZQkVz?=
 =?utf-8?B?ZnU2VjY0aXNVeGFXMkFwUGc1cjVXNG05Ym1iZ3VoUjlVaFphQ1A2RmhNT2ZL?=
 =?utf-8?B?djF0Z0RaWVNYM2NtUThqWXVLUENDSDhkVXFJaXd5NnMxblM2aEpWUWtxWndN?=
 =?utf-8?B?bUFDRG45ZjUvem1Fcm1sVDd6M2pqaG5PWUszT2IzbklqUWRIYVluWTR5Z25Q?=
 =?utf-8?B?a2swbEdLZ21qWHJMQnNIdVdZTm5wRTl3cFQ3d3F5ZlR3WXFpeFpMUFQ3cWNX?=
 =?utf-8?B?c215NFl2RVVReEVzbUlBRG9qWGcvbXhUTWhzQmRySUQzUWJsNXJ2cEZHdHhv?=
 =?utf-8?B?RlEvU3VBZVU0U216eDQ1QStScTFTcmVsMHlxem9HYVJjVDQxSmFFWUFJdEJn?=
 =?utf-8?B?UkY5cmkrVk45Qkh5enNDb3NHbUF3ak9rdWhGVmxHazgxTWpwcEZzME81NmR6?=
 =?utf-8?B?bVZIeDV0bUNMbnk4MUhQc0xGZXA1dmJSUXRiRzFWbExuSXFNa2R0TkhuVm42?=
 =?utf-8?B?SEgzZFI5UTFVVlZCdjBISnNNRG1CU0tTSWpPeWo5T0tVZXRZVnBtK1BZa21a?=
 =?utf-8?B?eTJsRU85QlVIS085K010K3ZwMjk5N1M1c3JIenA0WW40a3ZxTExaUU1NbUtE?=
 =?utf-8?B?SHVyWm0wS25ZMW9zZmZLN3NBTjZNRUxVaXI5Qk5IWG9QY2hNczliUVlWWGpH?=
 =?utf-8?B?UzZvTjA1ZHFFb2JVTXdHK0dMZ2trYlBTdVlRVTEwbjVEaVVJREVabmptRWx4?=
 =?utf-8?B?L3lzdTBPaVFoMHBqMWJCMHdkYnFaZEdHaVVsZkJEaUc3bkxRMnUvZXlWMjBP?=
 =?utf-8?B?bnB0VEt2VHJUWDVub1FqeGJiODhUdXMyNlc4a09JTnJyY0xkVHN1UFBmRW5Z?=
 =?utf-8?B?RWNtaEJEVncxQjd1SFVERUhvVUtTZ1h0cUVVc0NIM3hSK3BUaTRHOGFCbXFS?=
 =?utf-8?B?NXhOa3duKzA4MjBhbkdGcUxCVzB3cGxNTjAvS1ZCeW1ldFUvbnIwYmVWQWVq?=
 =?utf-8?B?QzhJOWxBR0JydldJdDlQaEUrUVBZN1FhY0oxam1TSHh5VWFzYVhUays4Q1dr?=
 =?utf-8?B?OFl2V0x2QXNPTWI2dTgvZ2dQbmFDMVVqaVl4S0RlNmxlcVhQQ1R5R25pSEpH?=
 =?utf-8?B?M09IODlOL3dlcjFKbUNmWGRNUi9iOGdYNWliak5ydFMzNjRpK2lkRE12ZHFX?=
 =?utf-8?B?RGRwUUpnVkQ4TThmM0tWNTJ0VGtYcTNnMW52THRyNkhqUi9hMlRiVzM3NWQy?=
 =?utf-8?B?bkVWM29nR0pndkYrTm1NanpmeE84RTFKdmk4YzBCR1lDMTllK1Yva1lqWTdU?=
 =?utf-8?B?c0kwYytlS0FSVGdWVDFrR1VYR0xtQW5zSUw2QmdkMzFCNXExdUMyVURWd01x?=
 =?utf-8?B?TkdCZVRyNUp0TjY5dG9TU2o3QTE3RnlKT2RXWGlqL0VZNFpKc3dXYXBGMGVz?=
 =?utf-8?B?dldWTkZSbGZwR1FRWHdjbFB1NDA4RFRrRVZRV1BBbHlmc1NDQXhBL1piTjZU?=
 =?utf-8?B?Y1Vzb0xCWWJYd0lXeXcyZU5UZUlSaDlTeUZjdjR4NElmUG04TEVXUWE3M2Rs?=
 =?utf-8?B?SzY5WHJlVjkzSW1uWXdjbjhQZEVsazgwNEY5TERrNHpGSXFLQ216NFpDZDFo?=
 =?utf-8?B?cjdDbU1wQWpEVTFTQjdxdHhVVGg2dGhDa1J1WUVQRURuZjJ1NXo3SkwzcGxP?=
 =?utf-8?B?QjJMdG0xVHY5emh2T2h1R0FFSExPeHRlMXgzbzl0VnZYRjNHcnBVS1ZLcklp?=
 =?utf-8?B?QjQrZEYyU1lLQnhGYjBEQkRSRCtTMTdJZ1Q4eVcvVmpRT1NkdW5RRTFLS3hp?=
 =?utf-8?B?YWVvY3lSVDdURGtXWGRSbWo4ZU1hREJvb1F1Qmx5TFp4RmxBMG8rQ0lrRVd0?=
 =?utf-8?Q?YJfX65zjqiwjcOTglg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa85ab8-ec78-4b8f-a1ed-08de6d5dda4b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 13:18:19.7317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaK/Rhg2RsaqvUFGZASCnQOguhcJVCTRB3Fs6N0EsL2AtPK9bGZ495EiRzRmUC/W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194
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



On 2/16/26 13:08, Ilias Apalodimas wrote:
> On Mon, 16 Feb 2026 at 13:39, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>>
>> Am 16. Februar 2026 08:24:19 MEZ schrieb Michal Simek <michal.simek@amd.com>:
>>>
>>>
>>> On 2/15/26 09:48, Heinrich Schuchardt wrote:
>>>> On 2/11/26 16:56, Michal Simek wrote:
>>>>> From: Shantur Rathore <i@shantur.com>
>>>>>
>>>>> Currently U-Boot uses ESP as storage for EFI variables.
>>>>> Devices with SPI Flash are used for storing environment with this
>>>>> commit we allow EFI variables to be stored on SPI Flash.
>>>>>
>>>>> https://github.com/rhboot/efivar
>>>>> is not updated to support this location that's why you can mimic it by
>>>>> running:
>>>>> dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c \
>>>>>      of=/tmp/vars skip=4 bs=1
>>>>> flashcp /tmp/vars /dev/mtdX
>>>>>
>>>>> where mtdX should match location defined by
>>>>> CONFIG_EFI_VARIABLE_SF_OFFSET/CONFIG_EFI_VAR_BUF_SIZE.
>>>>>
>>>>> Signed-off-by: Shantur Rathore <i@shantur.com>
>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-CC
>>>>> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>>>
>>>>> ---
>>>>>
>>>>> Changes in v8:
>>>>> - Add missing EFI_VARIABLE_SF_STORE dependency to EFI_VARIABLE_SF_DEVICE_INDEX
>>>>>
>>>>> Changes in v7:
>>>>> - sed -i 's/efi_var_from/efi_var_from_storage/g'
>>>>>
>>>>> Changes in v6:
>>>>> - sed -i 's/efi_var_read/efi_var_from/g'
>>>>> - sed -i 's/efi_var_write/efi_var_to_storage/g'
>>>>>
>>>>> Changes in v4:
>>>>> - Extend Kconfig description
>>>>> - Extend commit message and describe efivar missing part
>>>>> - use unify methods for reading/writing variable
>>>>>
>>>>> Changes in v3:
>>>>> - Fixed compiler warnings.
>>>>>
>>>>> Changes in v2:
>>>>> - Refactored efi_var_file to move common parts out as requested
>>>>> - Changed ifdefs to use CONFIG_IS_DEFINED
>>>>> - Fixed typos
>>>>>
>>>>>    lib/efi_loader/Kconfig      | 35 +++++++++++++-
>>>>>    lib/efi_loader/Makefile     |  1 +
>>>>>    lib/efi_loader/efi_var_sf.c | 92 +++++++++++++++++++++++++++++++++++++
>>>>>    3 files changed, 127 insertions(+), 1 deletion(-)
>>>>>    create mode 100644 lib/efi_loader/efi_var_sf.c
>>>>>
>>>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>>>> index 579eed658801..0f6f927ddaf1 100644
>>>>> --- a/lib/efi_loader/Kconfig
>>>>> +++ b/lib/efi_loader/Kconfig
>>>>> @@ -124,6 +124,24 @@ config EFI_VARIABLE_FILE_STORE
>>>>>          Select this option if you want non-volatile UEFI variables to be
>>>>>          stored as file /ubootefi.var on the EFI system partition.
>>>>> +config EFI_VARIABLE_SF_STORE
>>>>> +    bool "Store non-volatile UEFI variables in SPI Flash"
>>>>> +    depends on SPI_FLASH
>>>>> +    help
>>>>> +      Select this option if you want non-volatile UEFI variables to be
>>>>> +      stored in SPI Flash.
>>>>> +
>>>>> +      Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use as
>>>>> +      the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the space
>>>>> +      needed.
>>>>> +
>>>>> +      Note that SPI Flash devices have a limited number of program/erase
>>>>> +      cycles. Frequent updates to UEFI variables may cause excessive wear
>>>>> +      and can permanently damage the flash device, particularly on SPI NAND
>>>>> +      or low-end SPI NOR parts without wear leveling. This option should be
>>>>> +      used with care on such systems, and is not recommended for platforms
>>>>> +      where UEFI variables are updated frequently.
>>>>> +
>>>>>    config EFI_MM_COMM_TEE
>>>>>        bool "UEFI variables storage service via the trusted world"
>>>>>        depends on OPTEE
>>>>> @@ -153,7 +171,7 @@ endchoice
>>>>>    config EFI_RT_VOLATILE_STORE
>>>>>        bool "Allow variable runtime services in volatile storage (e.g RAM)"
>>>>> -    depends on EFI_VARIABLE_FILE_STORE
>>>>> +    depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
>>>>
>>>> Hello Michal,
>>>>
>>>> If the backend store is SPI flash, we should not publish the variable "RTStorageVolatile" at runtime as currently defined.
>>>>
>>>> For the background see this commit for the efivar library:
>>>>
>>>> https://github.com/rhboot/efivar/commit/68daa04654acbe1bbaa17ebfc23c371b39e69c6b
>>>>
>>>> The first three patches look correct to me and I will add them to a merge request for efi-next.
>>>
>>> Do I read it that when I don't allow to select EFI_RT_VOLATILE_STORE you will be fine with the patch itself?
>>
>> This was my only concern.
> 
> Thinking about it again, this is the right thing to do right now.
> efivar will try to create a file in the ESP if the speacial variables
> in linux are found. So we are better off disabling this option for SPI
> variables atm

I have sent v9 with removing EFI_RT_VOLATILE_STORE and we can deal with efivar 
separately.

M
