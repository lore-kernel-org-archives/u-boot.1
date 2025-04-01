Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A88AC36018
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 10:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1908581FBC;
	Tue,  1 Apr 2025 12:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="V5tp32QF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF3F82040; Tue,  1 Apr 2025 12:45:29 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::70e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DF13801FB
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 12:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.gnau@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0BEb2OwX3CCglNeGsXCEhEkvkiLhpD1MSATQZ5tqQa3yv4Jrs9BGbfoHHDFmZAob6FbhYw7EQm+AgMn47xaCnqAbi4MX8eFSIM54rJiK/oJ8Qi3I5GKLNcqHabRgJj5T5xFpKl8zwq6LjAzijUhqWFKcrv8p74qjJF3h/pAI0Tv4ZXQk3RtDmySUHR7p6PndY6KctPo8+qQ5l5gKK4AtST6MLzno3uy0zU03b9NvKHnF0QBMotIe79uIAC6nawmRrUt82iIUCglswi7Jq/AVxqE76Vri05WmMuJVwd8Sd6gkYDIvKXWKICdO3AyrQPFZ1dn8jjEHtAo8RKznhVXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6Ggbv1mCbtushFIr/oa0/nXGzruczGaFsP4J/l2Oik=;
 b=Q2lYsec3rEpPi2SpiNjRs5GOIZMatx8c1hax5k2pwKdunbt1SirFdzVeeQUm6BDEJ0DZrnrmBBd6J+QTO4TeCNwNmD4XDeNbGaSy3nM+O+5EGk3P6fQRq7pIMK0I+IT52oT3a1AO6KMi2+I3AgETHPfUlktnwBlpF2aX2Qp0CutnIvxk8LznExIKPNTRv/exukCQug1cxue9yole51CaerXMBYodV3Hnv9JVm7ksnL29aUF8waLwTHhMFSKEptVNj1vhQWZr+miVpBXgyN3mV4no0BQXW0D1LRIQP4EsE3Pu5/Q+v3yb60c+rsINlFmsjDgtr1ts2oMxy0jew3W6Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6Ggbv1mCbtushFIr/oa0/nXGzruczGaFsP4J/l2Oik=;
 b=V5tp32QFYl2PeBSYe2Ervy/S/JhFk+5kvkikpPSAPDz3BuDJ3gWyg5TvtJMtYe+i/0O8Ac0JQYynfnY08ySptxabRnoqeiJ+L1Z4yk7fRe9/yqVKtSAWGtMwy/IXZl3OacDYbJwIiZQPNyDVMNSwoC04Hu+d7Gx5nP1OJJmZbrNYiReXKlZX75uv5IENsc2raizUIyHIxTLeuamfhuKJ7TVKqOmlzfWmDm3Qti8tkhOd79OjPc3TF4XyZphveIdm6RR5bVTYUdSNmMGk9aHucPyf5E2Nm+qfb/DEx7XwZAT+CAxDWoHtOW10ukQFVRg7ELpRLQm3wdXxR18FyS0m4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DB9PR08MB7512.eurprd08.prod.outlook.com (2603:10a6:10:303::14)
 by GV1PR08MB11147.eurprd08.prod.outlook.com (2603:10a6:150:1ec::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 10:45:23 +0000
Received: from DB9PR08MB7512.eurprd08.prod.outlook.com
 ([fe80::fd8d:f047:ac4f:6d6]) by DB9PR08MB7512.eurprd08.prod.outlook.com
 ([fe80::fd8d:f047:ac4f:6d6%7]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 10:45:23 +0000
Message-ID: <522de79f-276c-446b-bb71-f407e26ecdf3@iopsys.eu>
Date: Tue, 1 Apr 2025 12:45:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] airoha: Add initial support AN7581
To: Christian Marangi <ansuelsmth@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
From: Andreas Gnau <andreas.gnau@iopsys.eu>
Content-Language: en-US
In-Reply-To: <20250314185941.27834-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00003854.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:a) To DB9PR08MB7512.eurprd08.prod.outlook.com
 (2603:10a6:10:303::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB7512:EE_|GV1PR08MB11147:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f4d738-aa5b-4126-177c-08dd710a4e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REMzMXJqOGtVT2dXL3ZDelpyQVdvOEVJTHh1Q21rSk1EY0ViZkNHYzIxVXlp?=
 =?utf-8?B?MVRXWm5SUnBLazBGb0xVaWJkTko4ZURIS3NkNVpzR0srdjRjNW9pV2xRK0tZ?=
 =?utf-8?B?SEpDUUxTVmt0bnJmcnJMV2wxWnlhbXRjMHB3blBCeENXN1dURENsQ3FGaWgw?=
 =?utf-8?B?WGVveVZrZHJTQzY0ZTUzYkQvYUlFeHIxTnZNRk8relVrSlRBS0pTcElEc3p1?=
 =?utf-8?B?TkVSNWNpY0tNTEFQZlBVM29tMWZKNWs3cWdiRmZhSWhxZURkNFJYYlVHOEN5?=
 =?utf-8?B?Y0FDc2d6cndBUkpudUxXdzNBYzFyTWh2MW9zcmZ1Rk44cDFmT1M3Q2ZGVmhG?=
 =?utf-8?B?TnhaQUtFcmRMbEhLS2FCRWtRWDI1VlQ5SzJrcGJxNno4a2hwUUswQjh3dlJR?=
 =?utf-8?B?d1FML3VEdTl1ZzF6WS94S1ZFSERiVDBaUVVmeXB4dlhiaXNZSndNL0tPMGd2?=
 =?utf-8?B?QmpHbVpVcVkwNDc3MCtsdTVXaVh3MjhrKzBEdnowdWErallLV09rZC9CTHpz?=
 =?utf-8?B?QnFvbnp4bmZWY2RxbXBQR1lSdXRCaXBOeE1BQ1hITm54bWtUVE5pWmJFNUVy?=
 =?utf-8?B?bmFtV0lEMU4vZWlwMHI1ZkpaNVRLOW00SldLQmx4SS9CMEYyZnpkb2xnUG9r?=
 =?utf-8?B?UWo1VTFrN0FSK3Y5MC9lY3R1VjQ1VDAwQ2xINTFuL0RqMzhseXNQb3Ivd01y?=
 =?utf-8?B?d0tGY1RLODNVM293M3llVUw2bXIvU0cwUWlMYW9oNTRLTUt5b2wrakI1a0lq?=
 =?utf-8?B?dFhZVFJjME8rWDJQUEx0ak9CMTRvNkV5cmM0WEp2NkhORW5HZmpRYlZ0T1hl?=
 =?utf-8?B?OWdBZXB5V3NQWEhIVXArQ3B1VjdCNnkwVmN2OHJ6UkxkL1JIMUQyVlU1YkRz?=
 =?utf-8?B?QlpoQ3l5RlAzNFJZUGVNRHdWU1NpV1FlOUpOMEJSMzZzSU5IeE5LRGNMbzc1?=
 =?utf-8?B?Wm81d2Z1My9YVTExSndCKzZZZHlBWmVxYWdINHRSMUY1cG1EdkZWZWd2dWZl?=
 =?utf-8?B?WC9OQ2tOcmR4ODg2VytGZ29SL3dsVkZhMDhBOGZmQnk5cVM3YU43RVdtbDU5?=
 =?utf-8?B?bVpDUzBNSElJTUpGYTBNR0kwdmxuTDI1b3EwZXhYbmZjaE4xRnBaM3ZpTUZ0?=
 =?utf-8?B?S1BuREFiK3V0dnBoUllEbnlIeUlCWW9zSE44RFdzZXJPeUx3TXIwd3JzZmlu?=
 =?utf-8?B?eXdjaDExNGtKY1RCVDdwRnZINTJ2Z3Uvc3Uva2FHek8yb3FZNjlQSFBob1Z2?=
 =?utf-8?B?Yzd1MDBWaUZ2WXhndVRhNTZLR1F1ZmRhcFFnb2ZNcHZ1WnVoZDYyQmZZRWow?=
 =?utf-8?B?T2p0VWorSVNpZElBT0s5dVl1VGo2VjMydGZSU2dCMTVTQzNQU0c5OUF1ajlH?=
 =?utf-8?B?Ulp1azIya1BCMWJFblNzL1pjb09VVFM4V0VvYXpVQktHb2lHZFQrVnpCb0Rv?=
 =?utf-8?B?UmttSFF6UVN3WWxrNk8weXFoSmR6UTAxMlZ4UUN1bE51K0VPcnNTaEluem01?=
 =?utf-8?B?SG5MVy93MytZQU9CTVBqNHZoaUVwQmtsRFVlYmh4M1NtczRzNDVVN3czVkNX?=
 =?utf-8?B?bFFEcFF4YWkzbnErYnIzUGNMOG1VblozN1huUUlKWTRRdEJDU3ZZampyV3ZU?=
 =?utf-8?B?Y2pWOXRGbmQ2T08xbGRsQldJa04zTW53TjBzN0ZRNnNSVXRjM1hwNGxoV1h3?=
 =?utf-8?B?MmYwZ2svM1BCck5Nb2JrVHZOLzhPWGI4Sm56ZG5jU2RnZTg2dlRxOFZpRW1s?=
 =?utf-8?B?cURuc2tCUHpHSE1wbTFCTUxNMTRXWTZaQjRsZWNsUzFPRG1xODlNYklvYU5k?=
 =?utf-8?B?NkI0OWthd21mVTNHQ2tpcVJlZlczUkZnMzVxK1hBNGJKK1NBU1lzcWYxSWRo?=
 =?utf-8?B?VnpkWlFxYjN4TldMTkx6WUJIZ0M5TDgvWlhhUFRjUE9wMXVBckQyWjlEUzNJ?=
 =?utf-8?Q?c67hvnXJsZ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR08MB7512.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXYzSzRYUnExQTNTYXdSU0hockllS0ZQOHFPL3ZLTVhlRWpmdlg4YmlqbFhW?=
 =?utf-8?B?SnpKVDFDdHJvc2VDUG9qb2pWdk9POHFpeHZXTGpaQ2dqSkhEM3JXYmg1bG1G?=
 =?utf-8?B?T1EyQjN1Qldqd3E3T1kwL2pPaVNiZEtTNnlQN3VPRUFzb3p3VWx2a0NoZ1g1?=
 =?utf-8?B?WGtwdDFCd1NIR3hMWUxQWUZWWmJsVU5xTSs1VlNYWVc2OFZlcEVNYm1aYkN5?=
 =?utf-8?B?Q3pLUFVlSEVyYjllNkh1Z1M5NlYzamljRzFDMENLd2RCWTlkRHg0ekFTemxF?=
 =?utf-8?B?WU4rQ3ovbEc4YmNRNldqNldEbFYwVmhVbW02OG1BNjBJT3V6K0t3cXZtSzdu?=
 =?utf-8?B?NmdwWkgvNzNSU2E5V3JlLzRUcDZEYU5vZW1IUWF1TEpoQTA3cXpMQ0Zxcll1?=
 =?utf-8?B?Y283VWJIdC9CeFJ5cURpNitkK2V0d0FQMlNMUGRiZTZRWGVseXVBUDFFOGJO?=
 =?utf-8?B?b0hCNUtMYllrMWxEM2N5ZFZWNWxKQkZRUytjQ3VpbENadkdIbEpjNDBucjdx?=
 =?utf-8?B?ejFoTVA5VXBHc05lQzJlWGtYQXhZWXVQL2VWWVR3MjNXR0VkUTZKdU9SeDBW?=
 =?utf-8?B?RzZLSzN6N2t3bDBVYjZoOGxTcDRtblRRcVpEejlTQ1R4Yys0akljMVh2MlJ0?=
 =?utf-8?B?dDJIaVhld1FqNldYZ1NoZU9kVk5NWEp6WkVEM0pLVXoxcnBwTmNEb1piM3JZ?=
 =?utf-8?B?WnBhTENQM3NqZDIvcUEyNzRZa0dvUTlFSkQyYnhiczNhMHpNaHBxU0UxY0FP?=
 =?utf-8?B?OGJnWUJMdWZUUDR4alcwaTZNWk0xelU0MVh0TzlqbnFUYmZWQS9zS00wem1r?=
 =?utf-8?B?SUZyS0VvbUtzVjB6aVpVeE9kdXYzQXhkTmtJN25EZ25DY0RNTU9PdnpHZzVy?=
 =?utf-8?B?cktYdloyZ2Q1bmcrYWF4Q2t6cDkwcXh1K28zeDJ1c1g0WmlEZVBBM0doNFVJ?=
 =?utf-8?B?VGRQeUlSdGRGbWN1bUxRU1NEL1ZQczZmYlNxeERuSUdUNmVMdks0MXJiTHIw?=
 =?utf-8?B?M3plUnM3ZDZrTWtOa1Y2dnRrcEV0cEFVakJZUkVGcTd6UGhTY0NJK2VId1RQ?=
 =?utf-8?B?djhoa1hvQTNHRytuamU1QUdmQmlGZnhJZ0J2WVl1MDkrTCtkekhFaTJnYVBX?=
 =?utf-8?B?NHN1STBkMHBKcmRYaHZXMUVIZTR5ZW1WVEJFUjRYV2p3c2F0K0hZRU1CWFBH?=
 =?utf-8?B?elMrUHAxREhlNjhkeExmTHNtL2kvcVdGalZNdWV0N1BFQ3plMHJ0NE9EVUZQ?=
 =?utf-8?B?WXA2MC9sVDgraWZGKzkwcnJwdS9temYwUVpNT3E3a1RESmhOWkdxSnNjUmMr?=
 =?utf-8?B?T1o1azVKWjNkWCsxVEMwZW1OWmRFdUVreWZuRjNqT0t4MnRiSGowWFowZmpl?=
 =?utf-8?B?bHNHcXd4V2NZaHRaSGI1WnVWcGs4RnNVVnhXZitaa3F2emlUbnJtOWIrbU9o?=
 =?utf-8?B?aExuK1JZdVRHdlV3VjZvQ1Z0OW9CeGpMZWk0YXhwd2lTcDNlZDV3QktYZ0VX?=
 =?utf-8?B?dXdjSUVxSm5mOXVvWjlmZnVDRERTSlI3UnUxSTRPa1NkcEw1OCs4V2d5Ny81?=
 =?utf-8?B?dlNyTWpka0JqRFUrdkpOQjJ5NVFSbFlZZ2I5QkJqa2NyT3lDVXlCakVaYUZB?=
 =?utf-8?B?REllZTVSOWg4Ry9PQ09aTXVQUkNRUkpEdmNpaVJzRzV3aW9uQms1cHA3RnBo?=
 =?utf-8?B?L0RWSFRtL2ZVaWZrUkJPYnl5MXY3d0ladkNudkhrZHB0bXZEV1ZHemhucVAz?=
 =?utf-8?B?emo5Z2czUWIrVHdmcVNzR2xjWHN3d2VvU0FhdzNvK0E2ZVg0YVVMb2plWjlV?=
 =?utf-8?B?ZTlIUE5sZDNGb05ZbEhZZ0Z3dlRJR2FLa3JWR3BtL0pwamxJeEUyVlFHTVJK?=
 =?utf-8?B?UWdJSXZHaGVVOHF5bndLNGVBWHJkQnBvUjhRUnhOK2JDQklrZ09WTHB3NTBJ?=
 =?utf-8?B?SStkRU5YalF4VW5Kd3MxVUV1RlJZUVhvSXFITmpGeDdSMmh0cjZTckM3VCtD?=
 =?utf-8?B?eGttbFZVSkJxTDFBeVhVdEtBM3pwK2NyRG9oR3piWW5HY1VjQ2ZzU3NwOExL?=
 =?utf-8?B?OGRDRzVaTFZTdDU0L050bndvZTY0R1VYWjFGMHovOGNsRTU5OUtSak9Uc2k3?=
 =?utf-8?Q?WbxiFTVMLfQyaS424li7BoAIH?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f4d738-aa5b-4126-177c-08dd710a4e11
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB7512.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 10:45:23.2604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyhHVHt6Wom9oJGCokiqSKouharx2nYw1qNHBiqQ+aDmr+1r0usKQmdXq9VORqvY3A/Hv572LlnuydUAS6aJDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11147
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

On 2025-03-14 19:59, Christian Marangi wrote:
> This little series adds initial support for Airoha AN7581 SoC.

Very nice. Will you (or someone else) upstream or at least open-source 
ATF parts as well, similar to how Mediatek does it?
