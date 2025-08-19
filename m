Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA83CA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:42:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAF0A81FEE;
	Tue, 19 Aug 2025 09:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="HikKLxTy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B71E81FEE; Tue, 19 Aug 2025 09:42:05 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A5F80FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1mikxaVVkb305jrweZ3VaevlIDpLJAxfipukQrl2KdVIV5buTiXSFqfG4ofUlrq0APRWrxyu1n6LvpE0d4id+cuYaB6R8lKfZetW6f7rH5Z8ylKqqjFJvlXH30guFyRFqSiLTjSVHPytNJ7w4FQHLZZDX9sc6CIZ0gE6VuikXSa/emea0Py8EIAP7l7v7JropY64dO1Mi98FLJF+Njm96oAE7C9CfljgxcS7XhqABrNLN79Dvh3CYZsJcDABlHGGGxnZoD4YX9C3SGNC7IH3J+EPo44tfpttF9pGzCvOWkB+y+WS6cwZ04OQDtj9xOZyttUuKsreWi6IMFX6+oWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifSGOHrYQd/AQJ8SCFSIT6/eiyhuwYTuVUFrpQUALhI=;
 b=GIlu2bRAvm1L5Gs1hYmp5MAL2YnewyNzVwEskyqhrUFKF53S11a21+9vR+35coGqd6vt2yonwGP9fM/p1BwaXyAzZwhcQTocND+bm2S3db1zKa/bqSpZjF+C7dUcwmTljJm/TfUZUFFPY7vjMSoUyWOfgL9RRO92ggmp4XdmUsw04Bygh93bnSeusxsYrevoH5+nhajodagWdX/btO0DTic2OQPCFp7IExsLgMNHjDM08vRC9PK1Dxq8qUyW0WkDWu1cxZ0sawQD2dq+R2tsj6TDKC6ywLnnjUU0LqgnisNVngABf/IOOYjyGTWVzz6UlSLE4vVUW4jlfukdBltlow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifSGOHrYQd/AQJ8SCFSIT6/eiyhuwYTuVUFrpQUALhI=;
 b=HikKLxTy++aBTnoBW1C0kzkow2GnrehajowIJUsRKsaQC5To6RZyfloyFdZAMeXsvKI1Sefsim7n4kJRDQWJfMi/Lqzgr63nGHBrGvhVmUj58X0vQlA93pdpL+8BsXKISC7fZ0QMu2rUexaCEEjKYI93FNpK3L3o182iMfT+RBHb92ZohRzitClYOi3eMpVipGiKJRA53Cu5xnhGleXOauJj4Za81T5m9AFA7BqPVV99rTLg9shycJWO4CDNy2JNeNDRC3fbUIxFoWpr8sBMaIGcseuK4LABfu7PQ6bKSaqG35P6S46RSrljipJ7i74O9yy2URpGarSpo5i/Xzpymw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB9263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5c9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 07:42:01 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 07:42:01 +0000
Message-ID: <dd503e25-a0d7-4c4a-81d1-45a28e65e730@kontron.de>
Date: Tue, 19 Aug 2025 09:41:59 +0200
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
 <46de0ac5-1777-4f05-a951-ea3cc80bfe26@kontron.de>
 <00e93439-e47a-4ca3-b309-1400b54d8bfa@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <00e93439-e47a-4ca3-b309-1400b54d8bfa@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::13) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: b86dd162-9c29-46f9-ff0f-08dddef3e23b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NStaMjFnQ2xocmFaclJMUzQ5Q2NFL2kzOG9HWStsT0xMdGE4dFFycmdWYWR5?=
 =?utf-8?B?dm1naDJwTmZiN2MrWVRWN2hhR24zbGRtWHlhdUpweFliTmZLRUNMUWJpd2gv?=
 =?utf-8?B?K2ZNZkg1cWtZWEh1WStuT2JyVUYvb2psMTVDcFlyNlBUVWppZTZMQkJEOEY5?=
 =?utf-8?B?ZGV2dXAvN1FFYWp6N005YzY1ZjhuaHIzMlBPMWxzRTFMTm12NDFjVW1tRkpz?=
 =?utf-8?B?S3djTktaSmRQSWpoVCtwRkUxNFZBRDBLVXRJb3F3OVRRWGlqNTJsMzBlUm5k?=
 =?utf-8?B?MndFNW1yS0s5b0pBdlZwU3E0ZGlhTFRmRW1mQW9sNW1ZUlJOR09xalNrZ2Er?=
 =?utf-8?B?Uy81R2hkYkhPSDJ3L3ZXcm9wd3p0Z3ZiUnVkbzZRSWRHUmxPYUpxdHY1VFJH?=
 =?utf-8?B?VmIwWktwMnRRQkhlWjBnR3M3Zi9lMDcvWVR3Zm5TVmhYZmVkd1o3RDVNQzdr?=
 =?utf-8?B?c1Z1TGNZZHpRdVp0bU9TemxUSlU0STNuMnRSNnpsQUx3L2JMMUc5R0NkK290?=
 =?utf-8?B?WGl2djh6aUJwUTZZcnRRbVZuTGQ2WlIzYmVNbEVCT1MrdTd3ZjZPV2J0VnR5?=
 =?utf-8?B?c2dBNVRYM2VsZThCY05FQWlDeVh5NStodVcwaTJIMFJVYThWNzRvU0E0RzVH?=
 =?utf-8?B?RTA2SjhFT2R6Q2x4ajlIc0psbHkzRmRhVktKNHJtR2pKdDc2K2U1enRjSlJk?=
 =?utf-8?B?bFllZnEyUVlaM0dTamdkYjc1OFV5MUJpYStoVmZLU0phOFVzcGszbENkTXA2?=
 =?utf-8?B?V3FwZHVaMEVFRnJkeVlIRndkYkd3YVZSZXZ0dVBKSkV0TzhPYnBBOW9GKzRB?=
 =?utf-8?B?VGNzY0txSmlUOFlueE1jT2hsWUU3ZFhHVDB1ZGxOZ2xGc29ROUhNemgvNzN4?=
 =?utf-8?B?Nm5Fb1FaaEwzMlFOK2l4bmhQcDlGVEFMaklmT1c3WjdwQlNJUmRodGd6b0FB?=
 =?utf-8?B?SXViOXRJNEkwQ2VPZmV3UTVkMU1xN3FvR2dKKzVMTGYrVFFXeUEyUFlmOEhQ?=
 =?utf-8?B?aUszcCsyWUZ2OUEwbmZ4TjlZNzBxcXdzWkVLcTU0TjdLeHl0cjkxQXYwaFpu?=
 =?utf-8?B?R3prUEFoeG9wQjZNQk5SRWNLOC9aNzBtZ1NTS3FySFFRMk95VFZLTU5HKzFH?=
 =?utf-8?B?TmdPV3g3RGtYM0tlczNGOXE3dG9HTVpiWU00bWlqYlFVa2ZZS0hoT1hNTnha?=
 =?utf-8?B?MzhaYStmdzdVVGRGRm9abW9UQXpyc2pUeXJEUm54dy85aXBUcjR0UGZlbDBh?=
 =?utf-8?B?VEZ5SFcxalpYdnNaVEgrSVU0MEU3dVFueUt4VEpIV2VxVndxeXFlTC9Gb010?=
 =?utf-8?B?T1B4NFBiOE5adU9lWFp1OVJieEh5YjlFME1DRXRxTG9QNElQdTBiLy9sWllM?=
 =?utf-8?B?SWhzelhscDdGdkxkQnhIVFdielhzZmliMFlUclZ0b1ptamNwK1lwMTZxUnVx?=
 =?utf-8?B?ODh4b3NLNi9jMkhOc3BKKzN6QVdyUTdBMi9LNW1iaGVwZkNTWVlOc2FhcXlo?=
 =?utf-8?B?eHpxU2RDMFZmSDRnOFZGNVFSL2FoWCthM09VS09adDdwUHVjd1UvanE5R01S?=
 =?utf-8?B?RytITXpkcFRRb0c4Ynp5aWs4RUc2REMwTlZzSUJtYUxZNlpvQVZzRk8wdlA2?=
 =?utf-8?B?cjYzS1RPN05YNDN1OFFBSFFRVWJrL1hOVVp2eHlMTEVhdm8vQTJlR2tVazVG?=
 =?utf-8?B?dGdmWlMyN2RVb21KR2VnNGNCd2lycVJucUpQUzFDTXJhLzBYK0FySnh4d2lL?=
 =?utf-8?B?ZnRZZExXVXVBd1ZmSUtINWJqRjhkYzNVZEdwNVhoSndtQjY5ZmE2dTdIY0Vz?=
 =?utf-8?B?c0dQS25nMlRxbHFDYkJSMUNDVE9XaGFzRFhVaU14K2RDT1lEYTBPN2NNelIx?=
 =?utf-8?B?NVVZK0dVSG5KVXlpS25BSE9IeXdlL1dKbHRQTzA3bG14Z3oyRWVYNm1OQWVO?=
 =?utf-8?B?OHhYWUZOQ2xCMzFORVlzdUJQUnYyeURCdGs1N1dPSVA4NjUwdGZJc3hvNGl3?=
 =?utf-8?B?ci9qMElwT1VBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGhYZW45RXlzOUdHMmdQWkg1MmxKS2tmak5OMWFJS0EzMW9TNjBOVTQ5Z2xQ?=
 =?utf-8?B?bmlndzU5NHRlenhkZzVxWmRNVzB3VjgrQU5zQlBySHJMYjhoVHlIQy9wYTZL?=
 =?utf-8?B?dkhYRXJ6OXNNYVZ5K1U4MGxhd1V2bWRySFJwZlJMMkMwcWZOQzBPb2d0NmJw?=
 =?utf-8?B?aVFzcnpOMDZGcXhWcWdwWFBkS25NemxjeTJZUWJYR1o4dUNodWpIMVljOTY4?=
 =?utf-8?B?eGwrbmJWckRVN0J6VlhEVW82bnRBeURPVUM5VFNCU1owajBnYnBuUGJ2TmRL?=
 =?utf-8?B?aHRobXBEQmpzV0gvTlMzQnY2MmpmUmprUmRvbnN1Y1FjWkN4eGpQdmhaaVc3?=
 =?utf-8?B?c2RyeGZzNmMwTkN1cE0zdG4wazBrRTBzWk9uYndXTTVBcmtUdHNzSC9HM3Ux?=
 =?utf-8?B?UnVoZ3dLcFNNSUtSV2Z3aktrdHN6aERvN3VDOTRMajE0ZmlFTVh1NjZsUGNo?=
 =?utf-8?B?R2lyMHNIaVFWbXE5dGhPVWxGZU9UZnJBdlBTbEJRbFNHVTdSMWg4enplbTBF?=
 =?utf-8?B?dVE4Z2FialhvdS85Z1dMNWZqWnhOWk9GRFU3dEE1RHNPdzF1S0NyYzQvMXc0?=
 =?utf-8?B?c2FlZVJHclNxYlorVjRLQ1Q1blJ5OFVubjVueXVSUmdqeXdKdVZZUXZ6NWU3?=
 =?utf-8?B?dWRVRENIZmVsaFIzTlFrWUxsclNVR3pDMC9lcmJ6M3B5UlU2eGNIQmdJT0x6?=
 =?utf-8?B?RWl2QXNPLzRidFJDcXB2K21JRm5oUHlMZWVMazA5QW9QRnRja284alFpMnMx?=
 =?utf-8?B?RFBJd3NRcG1tTTNBMWtuQ2d2c2p6YVh4bXVUMDkzQ0xlNE1ubkE0amgwWXJE?=
 =?utf-8?B?dW9iVXJaQnNmWlB1eDVpa1dSa0FCUzdkNzRGKzg5ekxVV25ldUFKWkcraVd4?=
 =?utf-8?B?MEwwTU82ZG1RamhkU0hMalppNS9wOWdETGdxS3lSRTRTeitBeERhRXNIcGlU?=
 =?utf-8?B?eWxmSzdlME5SZ0ZhQlVHS01uK05ERDQzK01pOU5vUWM5YW92VjE5V3hHV1pp?=
 =?utf-8?B?Mno4dEdhVmVmRmJJRlY0SXNsZUNLaXJ5TW5SOHpwWmRWRXc4OUdhT2E1aXFR?=
 =?utf-8?B?R0VVWVB4bHpyVmZmbEo0Y0Y4VHhpNDNqZmx2eFdpU21BVG5Vb3I5cFdqdkVW?=
 =?utf-8?B?ckI3MDlaZGprV1g2N0pzNlM0cmVrOTYzOVhoNytHSHpTZ2RGRE9OR3JsR0dG?=
 =?utf-8?B?dWdQRDd6QVJORm8zMHBleVVBSzBZbWdvaGhtb3Jrd2k3T205bXNDSEc4eDhT?=
 =?utf-8?B?N0dDM3FxS3FBSjh0eGpRSzErV1B2VDZONzVnNzNrM3NQSlNUYm1sWUFIWXlG?=
 =?utf-8?B?Mnc5dVBRV1ZOZ1VGU3QxQ3hhVlBBSkF4TnFyV09GNytiNDNQM0FlOXNUWnJU?=
 =?utf-8?B?eDdKK0hVTnZ0elJZcCtQNW41MEVjUGFyWTdpdU8vYk9LNWRFeDhabWZBenJM?=
 =?utf-8?B?S2pKWXdIR1kvNUh6MHlOdEs4V3dJM0ttRytvS09tRFErY2ZwSXQyUjAwZ3ZC?=
 =?utf-8?B?U1Y3Q3hSZTc2YlNpdkFxY3o3YzdhOWlYY1RIR2dJZTcyNllOZkFYSTB4VmFV?=
 =?utf-8?B?L1JBUUc5ZG5leVViSU5BTUwwbFVBM21RM0VUNGFONDZkaFA0cjZXSVgyKzlC?=
 =?utf-8?B?VDZJNTFXaTRTbkk2RUZhOERQYTg4YUxUdkRlZU5NMmlQYnowOWl0ZlZxSE5J?=
 =?utf-8?B?U2luZTBsRHc0ZVR0bWh5bHBBdUtqalRkcWpFb0d4dSsrZldHTkduUElNNUpv?=
 =?utf-8?B?b1BrQURHZjdsa2F2cTR4R3RjKzRuNFJHWXk1eHI2OElwb2R4WWpsMHZvYzF5?=
 =?utf-8?B?dlBOUWxEU1N4Zm1RT1JXcXFwM0ZRZ1ZPSWxoTkIxbURNMG0xRU5CR2UxMUc4?=
 =?utf-8?B?K3FxS0tnQUFUZk10SVAzd2YwaXYvNTJTZnY3bWxwb0NMU1daNmVLYXU4aHYx?=
 =?utf-8?B?cHk5SFdCSXY4L2FJNTAwd0pEdmFJZ2tTWVlXM3dTRjNNenRMTmg5VjJhS3BE?=
 =?utf-8?B?T1NDSFhJVWQydVBaTUhNZ0RZYjFOQWRFY3NkZmhsVUVVMmlMN1JDdWtTRkU1?=
 =?utf-8?B?NnNqMnQwSU41OHV2K3kvVHRMN1lZZlRjMnZqWjl3TWVLL241N2F0RHpFSU94?=
 =?utf-8?B?MGRZUEpwUzlxeXBVbnRDQUhWSWZTU2lLOTA3ZUxOMUV3bTIyTUhlWjdYZlA3?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b86dd162-9c29-46f9-ff0f-08dddef3e23b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:42:01.2266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLLA/Y6CVddqrjCYi1BfTM4ssW+/19Sg0peG/lmr7aDyEmrQDe4n36aaJZbEkJOBQN1MpxegAfHEaS7QtZLrUI5H/K0zYfEO9CBlgx6N28w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB9263
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

Am 18.08.25 um 22:00 schrieb Mikhail Kshevetskiy:
> Hello Frieder, is there any comments on patches 3, 4, 11, 12, 13, 14,
> 15, 16, 17, 19, 20 ?

I reviewed everything now. Patch 11 already has my Rb tag from Linux.
For patch 19 I would propose to fold it into patch 10.

Please note that I'm not a maintainer. Dario or Michael might request
further changes.

Thanks again for your work!
