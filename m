Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EA8C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 13:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E422D807F3;
	Tue, 11 Feb 2025 14:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VZRI9eWe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF59380842; Tue, 11 Feb 2025 14:23:52 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D886803CC
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDB5VHjrUxamLscwCiDP+LSlNESYctT2EjUWwZrSiVTtu1ttORRWEWvwmOJJfKET5iwUHG3Rli5SHf8wFEymZxzxFBMmns4ilozmWB44jLS/e0HxtM/rOl8KePe/14I1TddGdb0Y+gqpHl8r4BYnXK5k0wv69LCuTCIUeZOOjJg4pB0Z3BZRfkIOITLWi4lTpyeuysmoLi+bE2iL/l+2y7GZd/ToSkgeCZOOSOOVsh+AF+Dxi6zDUnSsCvK1RK4I2FWctnne7CnjC2JTV+doaHfvXdNq3R2Kwx6UH8DLGxCa+DxBKSIOoIgiNmE1ZQpIfyZRRWkAIsCW+l6cqYIWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFwOqoEPkToGzAoyJsqB21onJfz5DsR6Wuuy7iXt6e0=;
 b=gSm97WQeKGpcxMrVPBZdbqOJSDTSaj+/f4TpfL8nF5DOScfBb0Y6E5nPMuv8lJmSXry+BXrXWUUnHHnbQkGrjuk0LQto7PtYuqE2NS7rRkVZmd+euue3nhwhQN9olgZHoSQ0+AyfbCZCUSjry78zFpwaEH25ngRq4c32uGTT4MXu9SvQEdLEA30TnWKHjJQvCbszIpDGpsmDF+c8qyzx8yxpHYF0pH1snOgjzajz50hnHZQTsCv5q+X4/FTb+Vjwt06GYP9m3cLlYZBntjdipX95cNWIBFqwQhibCray1vrKiRhuqPzi60LQ/uhGP2wZ7SA9w911Z2NxZk5FWsnPww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFwOqoEPkToGzAoyJsqB21onJfz5DsR6Wuuy7iXt6e0=;
 b=VZRI9eWeSq7prfohT6fu4c6glLrfA6H3agm8SPD8yK9GUUoq8WoPXElgS7ksk/HwjNFlK7ObGyvSeXxTV82i6aMahe4MkXv4+6ivyrUK2zwPSrmvcz8XAPKQ/02DI3zMOplh1//4+cZ1jhsG/fYi4MSdPr2+qDuqAl5zqy8fssc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8996.eurprd04.prod.outlook.com (2603:10a6:20b:42f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 13:23:48 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 13:23:47 +0000
Message-ID: <bff6e88d-ddce-4c5a-93dc-c05a7dfa3d8f@cherry.de>
Date: Tue, 11 Feb 2025 14:23:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rockchip: Fix TPL link error
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 marex@denx.de, dsimic@manjaro.org, jonas@kwiboo.se, benwolsieffer@gmail.com,
 a-dutta@ti.com, mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, jan.kiszka@siemens.com, s-vadapalli@ti.com,
 bb@ti.com, ian.roberts@timesys.com, sumit.garg@linaro.org
References: <20250211043335.92538-1-naoki@radxa.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250211043335.92538-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0289.eurprd07.prod.outlook.com
 (2603:10a6:800:130::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f12d481-64ce-44fe-f591-08dd4a9f50f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXA3ZnF0ZGp1NzA2WUJJZ21VbHBadnU0Wnlsdk5WNThZMlJ5VVVNbTdCNjBT?=
 =?utf-8?B?K2JwUGN1ZnJTTGtWZ2NFZU1HMHp0SERCNWlQZ2paQ2NHRmZEMm45Um81VGV1?=
 =?utf-8?B?ODRVZWRod2I1cHJnaGNnY0h0N1ZIanZMSk95VGFWZkFQSUphZ1M4QU1haUJH?=
 =?utf-8?B?REZCbDFNTlBCOTJ1V1lQUW5QTEI0RlR6UUU4WlNucXRkZXBDaDQ1OGpTUCtz?=
 =?utf-8?B?a1IwVmdTNFVvbUh6dTBqTHRNa0o5WndsWkQzaEEyT2hIZk5yRCtxdVdYL0hl?=
 =?utf-8?B?SlVXS0pTWjlwZ0ExRWJ1QjNLbThjekJRRWN3RUV0VExaWDg0Y1hBME52YVlK?=
 =?utf-8?B?Z0lsaXRzejBaZUVxQ0FBdEpuSStKakpXM0RUYXU4cnRac2x2UnBqR0xvalV5?=
 =?utf-8?B?anh1TmViZWVjbGVWWXY5dk5FTkpLL1pPODR0QndiVzM4VjVyQU1HcDhQcjhi?=
 =?utf-8?B?aFJmU2lkSndTYmszR3lRd1dFNVdNUjU0Q0VBaUx5dnFCR2xDU0lXQXh0aEZM?=
 =?utf-8?B?RFg3MGhZUnhoalJLRG5CeklYZGVWQzdNOEhJRVV5aTQyMWFNUmZMalFqU09D?=
 =?utf-8?B?dDBFY0FFTFdua1pIUWM5UWxnMVJvOFVJWEVmaWtGL0FGaFpkNDc1RllxZlBZ?=
 =?utf-8?B?TTFvSXVrVUd2YnlZTWVac3VaaGc0WWhuTy9EQVBhL1lSMEFiNnZYZjJBbHUw?=
 =?utf-8?B?eXdWQUhKN2cwd21WQXdTSU5YbG5iMnB4Z2wyR2Vud1k2MEJZWHZaQ2ZmMGZ6?=
 =?utf-8?B?c3dUaVpDNDBHejZiMmlwS24yV3RvR0xBNGJRaTNHM1VTTVVDdU1wUlUrV0NN?=
 =?utf-8?B?UjhaaG50blpzLzJEQzNZV2Z4QlpzTUxwaGpQb2pqbnlob1RMeEtwNVh2TW8v?=
 =?utf-8?B?MFpyNHd6T1psb0pUemR5aGFmb1pCWXUvZ0Rzc0VBUmE4dytHaVNtQzR5SnJT?=
 =?utf-8?B?d1gxMzZlODZEK29aTXR5ZVo5UFpzTEFFUXJPTW1XUStaWmN4aDdVNUtGYnFN?=
 =?utf-8?B?Q2ZzeUsxemt5a1pFU1NmSmVNQjV5Sk1UQTNmV1REVlFSZWVRYWg2amJPQ1Yz?=
 =?utf-8?B?d1hUR1Fsd2dtM2hqSUpGLzgyMEtac3BYcHVlSEJ3OEZoWElCSjhhaWpGYXpz?=
 =?utf-8?B?N0JEclM5Ti9xZGlGVkxndzNIcktoa0JBVytLVnI3RzNiYldXWG1sRmRzUG5u?=
 =?utf-8?B?TXJUWUxDL0VheWJqTkdFL3FZY0FUa0JKaFlCekFhQXczVkl6Q0tRNVNIdWkz?=
 =?utf-8?B?azBVZmdrbjAyT1VTNmtzWTAvMGJFOVVaY1luOHlnMzVqVUxFME5XcE9wdkFS?=
 =?utf-8?B?QytNMmViRjBSY01ZTVQ0NDN4WlNkbnNaVE9wQzJ0SFBWVHJYbjRjRzRpOWts?=
 =?utf-8?B?cnlLZFZqOFFjYnpmOUxUeDk5ZXQzbEtFejhtZmlGOXJsWmI2anAxcHB1TURP?=
 =?utf-8?B?UnJvYkRaYi9HWW5TUmxvR1V1SERXUzhYM1l5S1NjTU5UZy9GZTRTQStPbW13?=
 =?utf-8?B?Tjhsblp3azlDMXNSMG1yVzRZNXZqMCtobGlyOHBhOGlGaGdLZ0VQMzZJcVRw?=
 =?utf-8?B?QmM0NUJiZUR4QmJETnJsT240WEtSZUUwZ3VJeC9UVzlOOTJOb3dNTlZkbXF4?=
 =?utf-8?B?MjlWd1FMTEpienNCaUpYTXFON0hyVVhmVFcxUm8xVmFDRDVvL2xJYjU3Nm9K?=
 =?utf-8?B?Q1g5K3B6SmU1RFhoT0F0N0svd0IwQkdvbHVENnRpTW5vZnNwZEdZZDJtNTRV?=
 =?utf-8?B?MVJDOStydjVWVEwxcTFLcjRLc2dlMjg4eE9xZE9waEtGdkJMa0YwdlRsYkd3?=
 =?utf-8?B?NmovTEdEeTlNNGE0WlRybHlqbFl1NkxUWGxGTUM0VnJMc2ZWSXMwUVRuOUxT?=
 =?utf-8?Q?yARP517kYjJUH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7416014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG5TT1BCZXR5dEt3bCtPc2Y3eWU5MFc3UHhrVjI1Rk1YYVJOOGt2MldleUtV?=
 =?utf-8?B?Z0FkT3ZGU3lKOHAyd202SVRWTWJEbHd0eFN1T0JHVVF5R0d2QVB4bE84Mi9x?=
 =?utf-8?B?c3BlUWxYUzNqNEZLNnF1cC90ODRHVHdQN04wZnVLQ2thUVdFNW1rMUhPTXZL?=
 =?utf-8?B?blE4bjZiRHVSR1FRcG0zTlBSZDF5cmY4ZWpvM21qM3A2TFhVWjhpaWc2ZWZK?=
 =?utf-8?B?dFF5WnlOa01TRkhkcFZ5d2NOZjhmN2hzblBUSndXMlhNWmNpaVJEek41ZlFH?=
 =?utf-8?B?RFVqWjg3dmU0eFNrYmFSWVlsZjlkVGdFUFVmSUVPcEVwNHBNNGRRcHlYNDVu?=
 =?utf-8?B?U0RmWndWQjJYblVIUXpRcURQSW1Kbnc0UGpDYzNpT25CSDFTQlRmRUNpR3lo?=
 =?utf-8?B?S2xjSFJMbklOZFZCdVJvWjNpRHBhOUhUMk9sbzRkeldIZEFTL2lETTh5WklP?=
 =?utf-8?B?NVg5WFlsWE1Sb1IwREJVUUJNYjZvU1UyNEFDdmtpbUVETEFvZ09Cb1dkMDlI?=
 =?utf-8?B?ZkI3T01vSm1CcTFNU0xIS2E3T0xRRFN1TUtLVDRsVkJiRllMNTRML2NqSVVZ?=
 =?utf-8?B?Z2plbXFsaCtudVNjMGdKRVJrN09yckhCZ0VUdmVGd0hnSWwwQ2pVSkVPZUl1?=
 =?utf-8?B?Y2g5MzZyRDNtb0NNR3NrM01hbTJhQ1h4bG44VzRSUnZ2VUQwZ2x2Y2tlL3JC?=
 =?utf-8?B?cVg0dnFYTkZhOVJ4dzdvYzFJRFR4WDIvbzVyOTVCbFpuR2pMWGxPS0U0cVA5?=
 =?utf-8?B?eFM3V1dObzl5dEQySHBralZDVHlucnEwOFo3bXZraUxMRlhBTnFlcnVKTGpT?=
 =?utf-8?B?NFV3dG1BYVpnellzTDVsYUZnT253ZXlUY0syNkdvdGlNREoxR1JSM0dMNzZa?=
 =?utf-8?B?ZHgzL1k0enFTcWppTnVXZGpXUFFFbUNhMU5JN012V1dsSG11c3VWcnRLOGh3?=
 =?utf-8?B?enRVVVRDekZQOEFkL2NQTjBncHZYVkxGdWZidW0zcEM4Qk9qbG12STFlQU5H?=
 =?utf-8?B?TnNnZ0c4VDB4NW1tNVdHdlhkQzhBL2F4WWtVQkJWWWJFbWYrTlo5YmltOG5L?=
 =?utf-8?B?aCtnUjM1a2FIOWVTcDBmbjlXZFFsNU9rVEdiRFZCQlowcFFlaDAwNlMwcERK?=
 =?utf-8?B?VlkyTThiWkxIQ1hTRmw5U0MzbTRXSEpKWXVnMU5ETFFESnlKOXUrL2VzWlBE?=
 =?utf-8?B?UjFhQWE2WksvUXB4cXFud0RFY2Q5QjZzb3AxOTB3dGkrTHRPbGJya3pkRVhC?=
 =?utf-8?B?QjRTZjQ1YzA2V1R1MkFKRVFTeHNVQnNDTzBKditmaDJMT3RRd1RWaCtINXg0?=
 =?utf-8?B?NDUra0FoTjQ0L1pjaFJudjJDbFMvcDlkK2RwOFRWRFhNU3hwb1FKOGttRDMx?=
 =?utf-8?B?VkNZelRWS3Y3Uk4za08wdTlLT29ZWWl3RytraWxRdUtCWHdjQjBuVDc1SC9s?=
 =?utf-8?B?QzBPZHhJb2NadFcwam94UHllSXNFYm5ZdXJmSnVJMmlTdlk1UWN5R2NaV3h4?=
 =?utf-8?B?dkdSMTBoM3NaQm9oNzR0MEkySUtkYUg5QXRWNUpBYXpMaUYvWlhLVndDNjRz?=
 =?utf-8?B?SzljUE1wVG9DU0F1OXBDQnhoV1BoY3AxQm8xS09CV3ZYR1NkN01KQldRYnlK?=
 =?utf-8?B?SkkxNmRlVHk5WE5TVldzd1Y0UFN0Zk9nUVdGM1Y2Qk0xa3RiT3ovZ2FPdzMz?=
 =?utf-8?B?TE1SNFdlTm9MQUgrdnNWMmJlQlhJcTdlUGJzcGJqNnMycjR2dUl2ZmY2a25D?=
 =?utf-8?B?dnR1TnpRMURSdEJSdmFFSXBlTk9yRU5jNG9rU0ZxQy9QVUlySDNlc1F3UGl1?=
 =?utf-8?B?U3NUOWd0emZHRjZlTUNSdUM0T3FnY0Nndk8rU2tmRkhaV05yWW4yM2hnQTdv?=
 =?utf-8?B?YUhuSW1yS21VbVFqTTZ6R0pOOXlMZCtGa3B1b0FDV2tMRVp5VERIQUFlSVph?=
 =?utf-8?B?TmVVcVg4dHFWcER1V0FEeDQvYm4wUHc0b1ZveWwxaXh6dW9CYVptNy8yVEZK?=
 =?utf-8?B?UlNPbjZJSnQwbnNTTUhvd1F1ZTREdEllNVZCZzNXTjJyTDA3ckZ5cjlEWFNJ?=
 =?utf-8?B?Z0VrbmtNaS9maXN5WiswUVB5WjMvOHRFQkVCSk9qOUhXeEE2dG00OEJMOVdS?=
 =?utf-8?B?NHNoVkJBdkQ3WVlMVkdvZ3BnWUJRWDVJU3d0anhpR05OVlBIakExeTYyLzZv?=
 =?utf-8?Q?bqa0Up24PmTqHHf5rEPlovA=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f12d481-64ce-44fe-f591-08dd4a9f50f9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 13:23:47.6538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +P31dVzngxNjN2cl5KYngm1t0Ou4Bmdvq/6FiWIgyLZD+oHFXlliIgGvJ5xN9SZaZTTzXNcHzs35fPOqrD/QKC4HrLqeIawO5nvQAau8HY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8996
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

Hi Naoki,

On 2/11/25 5:33 AM, FUKAUMI Naoki wrote:
> Rockchip RK3399 targets build TPL. If CONFIG_SPL_USB_DWC3_GENERIC and
> CONFIG_SPL_USB_GADGET are enabled, linking u-boot-tpl will fail.
> 
>    LD      tpl/u-boot-tpl
> ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `dwc3_glue_bind_common':
> /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:527:(.text.dwc3_glue_bind_common+0x20): undefined reference to `usb_get_dr_mode'
> /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:527:(.text.dwc3_glue_bind_common+0x20): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_get_dr_mode'
> ld.bfd: /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:529:(.text.dwc3_glue_bind_common+0x2c): undefined reference to `usb_get_dr_mode'
> /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:529:(.text.dwc3_glue_bind_common+0x2c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_get_dr_mode'
> ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `dwc3_glue_probe':
> /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:683:(.text.dwc3_glue_probe+0xb0): undefined reference to `usb_get_dr_mode'
> /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:683:(.text.dwc3_glue_probe+0xb0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_get_dr_mode'
> 
> Do not compile drivers/usb/ for TPL.
> 

You should provide more info here because we do not get this information 
from the diff in this patch. Indeed it is compiled only for SPL, because 
the rules are added in a

ifndef CONFIG_TPL_BUILD
ifndef CONFIG_VPL_BUILD
ifdef CONFIG_XPL_BUILD

block which is essentially if stage == SPL.

> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
> Changes in v2:
> - Move drivers/usb/{dwc,cdns}3 from scripts/Makefeile.xpl to drivers/Makefile
> - Suppress unused warnings
> ---
>   drivers/Makefile                | 2 ++
>   drivers/usb/dwc3/dwc3-generic.c | 2 ++
>   scripts/Makefile.xpl            | 2 --
>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 0e1f58c515b..3ec05b942de 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -62,6 +62,8 @@ obj-$(CONFIG_ARCH_IMX9) += ddr/imx/imx9/
>   obj-$(CONFIG_DRAM_SUN20I_D1) += ram/
>   obj-$(CONFIG_SPL_DM_RESET) += reset/
>   obj-$(CONFIG_SPL_MUSB_NEW) += usb/musb-new/
> +obj-$(CONFIG_SPL_USB_GADGET) += usb/dwc3/
> +obj-$(CONFIG_SPL_USB_GADGET) += usb/cdns3/

Please have a separate patch for moving the rule from 
scripts/Makefile.xpl to drivers/Makefile.

>   obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/
>   obj-$(CONFIG_SPL_USB_GADGET) += usb/common/
>   obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/udc/
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 55e62b35c61..8c2545bc2ec 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -50,6 +50,7 @@ struct dwc3_generic_host_priv {
>   	struct udevice *vbus_supply;
>   };
>   
> +#if !CONFIG_IS_ENABLED(SPL_BUILD) || CONFIG_IS_ENABLED(SPL_USB_DWC3_GENERIC)

It's not entirely clear what this should be fixing...

The users of that function are actually ifdef'ed by

CONFIG_IS_ENABLED(DM_USB_GADGET)

and

CONFIG_IS_ENABLED(USB_HOST)

so maybe just replace this with

#if CONFIG_IS_ENABLED(DM_USB_GADGET) || CONFIG_IS_ENABLED(USB_HOST)

instead? But please explain why this is needed?

Cheers,
Quentin
