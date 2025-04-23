Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370D4C369D1
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73CA3812BC;
	Wed, 23 Apr 2025 16:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="q8rXXjWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CB480FA8; Wed, 23 Apr 2025 16:56:53 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B4BD807AE
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 16:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3tNVIYQdFDIo4zTmHJL8391Eo9JStVosoEmi6ly7xscMyxAPJOlOJvCBHhlf4Af/VhFuchdzU/C8C/2PhxGsU4huxIm/snDbKEzTePHcXU/sfqE5J4yPSDMOMOLVi0AKoxD7lrTVLKznF+Z6LEyjbOWI/mW1sbWQKevCOnAB7R2U5TRz4KqPt5ZV5PxUs/VjJk9qNVB/AFksNg2ND77Qy8uIhrnsLRO38+bwYrHzqSG4rxtOw4NMSbg6QYYrsfAr++NYBkyJXE2I1r2W2WOx9lOIEe4Xld2I3g1Y0saCNypYY+GiYBUj2VQ1wigQDd9eZBHHYG+QrBt6B+OPvj1pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2fxF54NreINeYnN8cvExW2HtU80bQiPGByUxVdB6Ks=;
 b=phusKB0Q7QfPhmYitcug495Odrxyz8yWBZWMzjoE+7cdfkyCsH9jDPIkASncTQwkqvF0pIv6blERzj5Oxb903FUbbDZcsPCjtO37xewNxGTanGm4QBIylJpYcS7SFtrIYl5TIhg9jafwO+x+a46MoW52EnfZl08cASkOZBIaNn5BTFAn6QM/alG5+wTu1x4rRMIAUdqkxaHbV+BxdUu/rBjYxTzAKXS0S08IBnuCHsj/JLT9fHCNKeDiPEQahjmTkFN0KYylMgrxdIyXvDwqtTl67U2/cy6P8Q4qd076mwLi1VNF/d6Ku/EPqlXCPZxS3vuHMLbmeVUeH0re5of/KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2fxF54NreINeYnN8cvExW2HtU80bQiPGByUxVdB6Ks=;
 b=q8rXXjWKwQrtn9q33g/b3KtWXlHhIO+kZnfAB0i4LptpsXk/uwAmOZqz1IN6VQSG3hXLaCF0knkDU2nwWb/xftph35BSuzj5of81BWZmMVlq/VO7mNY9N3Qm5OgwIwuu5QWHJM1WYYocGsacCo3kNU7oZ9DXnyt6/kfYc2hExAZApKALi2VDjOzS0j1IFWEcSGUnH2S5WDPKzBPmqksPkz1U3xlawZleUPhXKGG9Uz/1OcktAIdjqaV0a4QI+WJUde9YG3lIvQ4epUozJt90sBV166VprbOjBv3SQ8BuZqtcsKmAzrQcfpb+DTKzmvNh5m/Jt/ESPfaNgPZH96pECA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 14:56:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 14:56:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/1] mmc: type 'Relatvie'
Date: Thu, 24 Apr 2025 00:05:34 +0800
Message-Id: <174542428423.32054.9290105935377442471.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250414114943.55224-1-heinrich.schuchardt@canonical.com>
References: <20250414114943.55224-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: de9cf2ee-7565-4ad4-596f-08dd8277138b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alZqYUhwNVB1dlhwWXJuVkhIbnBReFdCaEo0Qk5MNmZuak83eFRHK2xzcWRN?=
 =?utf-8?B?S3VEa1VVcGh4Y3lBcDh4dzR5ZjUzUmt4TGRBV1JPTGxHcDhUeTJ6bTlWRFVi?=
 =?utf-8?B?cGZWeEdLRFhUOHEzSG9NUk1wQjI4TlJBbE9Wb3RVWVJ5cnV3S2xkUUJ3Z2xH?=
 =?utf-8?B?dWxLeGFiOFppeGlKQisxNHJ4cXBEdWo3M05qTXVoSzY2aDhySE5RMTFoOWNw?=
 =?utf-8?B?UjcwU3J1RlNkRytabHVPeHB2cTZEUHdXUWZCZkRHejZwYXI0NXJKL25wY243?=
 =?utf-8?B?eHJYOUp3aGZDTnZjZzNTZ1FRUi9CaGhXTUNHakhXNmV6ZURFQ1grTUJxdVZE?=
 =?utf-8?B?M1REZHExL0hMcXU5dGJINmRZdk9hOU9yYzViY2dGYUtCVVJSbHBIR0d3Zkph?=
 =?utf-8?B?OFhJZUFzUzBVUktNeVladmU0S241ZEtla3ZyN3M5OFNrcDQyUFZ5U0dFd3V6?=
 =?utf-8?B?YlVXZmowNmFINmFQV0hqbFQvNm11d28xQTZNQ0FKWVVGckowOE5qR1lueVhh?=
 =?utf-8?B?NzJKQzQ2dENJL1lQQUEvdTZmMGRUMHlHY0VJaXE3aSs4Q2JjMEVuYWJPZXFR?=
 =?utf-8?B?ZXBsN0lOZVN5Ukg0aFk0cU5iakFIWnZibkpKalFIMnZPc0tZaVZNcG5nQWJk?=
 =?utf-8?B?SDJvRW4wRnNTRHBhM1VMMUUwY1FwaU5tWDFEc2pqU1dOTDlGRHBiMmw4ckdL?=
 =?utf-8?B?dytzL0NBdGd6T0pKWk5YTXVOYk80UTJ1NjBQZTA3ZXcwKzhsYjgzWUFLT3A3?=
 =?utf-8?B?L0YzcDJGVVhrcURSQ1VIT2xOcmErNDRIYVJrUFlvWFFlMjlrZHYwTi92MjZW?=
 =?utf-8?B?bVdyc1RBT05KWkx2aXJPamZnNzJVbjV4cFZiNkhjQjY0d0o3VzRRNVBUTVZq?=
 =?utf-8?B?elRjVTlwNTRsUkxNc3lIUmpENlZaSDErVHdNZ3BqY2JMZ29GaW42ekFVT0Nh?=
 =?utf-8?B?SmtZRjRNTEo0VlNDMThhTWZaTnNnekJ5RTZyQWwzN0tPOU9JOUk2SkNqL09C?=
 =?utf-8?B?VXgzaHJFWFF0WExLZEZicVFaMVY0SnZVejN2a0lJNjRDL2tqdWZkYlhvS1o1?=
 =?utf-8?B?WG5SRVRhZzBuMitrdmxJUUJjQkxkdnhHZjZFcXlvcHpOVG0ya3BMN25aaHE1?=
 =?utf-8?B?cURmcHhsVjd6dVpVWG1rNjk2MDFpVkxEUmZOZlhWWVVXTXZTNDlXZkdLRmZy?=
 =?utf-8?B?RlNNRW91WmZDaGZNa29pQWZOVkpSTmRiL205eDYzSndqK1o3U3JmbXR3bVlk?=
 =?utf-8?B?RDFZMUtRcmhDRkNhaWJaV2sxYUJFUHFxc2pWMUI2MnFzMUwyUlNMWmh4YTRW?=
 =?utf-8?B?enZZZXVzUE1wZ3lrVmRGblhwYThuMDlGb0V4YzgvMzZvTDZRM3kwc0pTYlJk?=
 =?utf-8?B?c3JLUFdVUC95NW5VcnNaeVNUK29qMkdTcXYxVXdnbVg0Wk5FN1U2bVNLRHN3?=
 =?utf-8?B?b1AxaDl3N2JPMnp2U2hWWEsvWDB0KzhCQjNMOThRcDZBakxHUWFoV0VCbUdO?=
 =?utf-8?B?U1dVMlVhbDh4T1JxSng4Y1lWMTlHbmJGRXVhekhaL05RRGlsdHdSNzJScEZN?=
 =?utf-8?B?dXg2ZjlndFJXMnF2NnE4NGhsK0plZVE4eE5VLzN1SFh6SkRiM2hlZ29mNHZJ?=
 =?utf-8?B?RHYrVmdMb3U2c3BJM0lsLzJRNnFGVlhsTGpXNWJHdGV0QlZOWXdnbm9rVzd0?=
 =?utf-8?B?a3pHYU5PUDBrc2ZJSFVCL29DQkk3S1RLN3lad1lidlZKNUZzK2FiYnEwVHNI?=
 =?utf-8?B?YU1ONzhiUCtvVlg0a2E0WTE1dHltK3hNQkNEUzhsNjltWmhqVzhPb09lVHlv?=
 =?utf-8?B?cjl0Y0drMTJ0UWgwTS8ySzB5Qy9nOExrNHh3dnk4SHllUU50V0JjTWZlS3Zi?=
 =?utf-8?B?TmRscGNqTXRlK25acy9UZTFIUnkzS3RkTzhDMHN2R0pQUmNuQnVuaE1DRTZw?=
 =?utf-8?B?a2lZMVZjUEZTaDFlQ21RcnF6K2pPTkU0Y3NrUkpwdHFVZURNVElzaE9zZi9m?=
 =?utf-8?Q?bbaefbMO09nTN+b06bqN29kInRULmo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHR3ZlM5UmE3TmtJbVRQV1BqaEMzcGErR21RVUNyalVoTjc4b0pRSUVHaVNa?=
 =?utf-8?B?UDJuKzU5OWluRVNyc2t6YVc0Mk1QUjBUS0pqZEZiYzFIMXFZUHJLRU13QURq?=
 =?utf-8?B?dkVhK20wWG94bHlhekQ3dDhBMm9zM25ITzdNbWpQYXhmWE14ZVN3b3Z5R2tz?=
 =?utf-8?B?NUFvdHk0QVE3T00zVkRBRTlkVjB2NjVNSEhieUFOSlRvMi9Qd0ZaeG42MXhP?=
 =?utf-8?B?b0pPT0xxL3FxdTVOSUp3NmVkeEpyRUx4Ry8zME52MXRQeTNKOUM5aThjOU9E?=
 =?utf-8?B?YlA2WDgySmU4TGFYQlVaMFBqS2ZFc1hjNUVjblBBSlV0bmVqV21SamwyTjBP?=
 =?utf-8?B?K2trTGxzSDBYRThCTzBLcWxPNVV5MHVsTU9TOEpObFF6NWRLb2sxTkVtRFpm?=
 =?utf-8?B?b3RFbEhydy9CSkgzeDNJc1JwZ1MvbFlOYnhoMWJIZVN2UFFGaC9VUithQlht?=
 =?utf-8?B?clhrSkI1YURxNnEwd01hUEIrcTJuNlpnWWRrczg0UTJmUmdESDM3YllJQkFN?=
 =?utf-8?B?bUJDeXFvR1dJRUEzYVpraE1IYjl3SUd3SEZZOHBxcVpaSVBqenh2aEtKWDdz?=
 =?utf-8?B?cXA0bkZPRldQdXhMY1llTCtadkZCanQ5Q3doUHpUYlRsTHRQZzhGNXNNQi9R?=
 =?utf-8?B?czhqcm5CQXBtSjFZVnFPVCtyc3lkK0UyNmRzVGdUVm1lbW05KzMzTzA2czk2?=
 =?utf-8?B?Zk1aVTZEWGpoWllhbFFBUTZyTjRqVmRsZzVDMnhIQVpFd1pGRnBla25XTC8v?=
 =?utf-8?B?TEQzSEl1c3prYlByc2FCbExHVWN4SGlEMTlrdTY3Mjkvd0pIbkpNVWxteFpw?=
 =?utf-8?B?SXAxSTFHYVNYbkFzNFZXdDhVMnowZzZXSW5VR3Mzd0o3VXlaVjY5UlBoMElH?=
 =?utf-8?B?YjJRU2VtQU14K2Y4TXRDMmxqTmlVYTJCcXNMMDFNTFBwY3padjFsOWp1RlF3?=
 =?utf-8?B?MjFzOU5SRGVkenJHNmVpa0xmRXRMcWdxanVnQ1I4RXFrT1d6WTRzQWhZaU40?=
 =?utf-8?B?WDl1UEJRZUtVUUVqY0Z2TUZqNndwNWNwRTA1cmZvQzd2YXJUOThESm03UUo5?=
 =?utf-8?B?ODRnNjJxdUpPYWo1TGlUdC9uMVcwZ0YyYldiaS8wQVhzZUlmTUhHVnBXeG1t?=
 =?utf-8?B?UndBdjNQYXFSL0hHS3ZBQ1VUdGpKQ1Y1N1U2VUJJTzhlYVVXY2hadENYUVNN?=
 =?utf-8?B?dTc4VGlSbjJxZ3ZQb1czZjlRVC82QzZRWThDNTlrS0ErcWNsZHhENWR1ejBS?=
 =?utf-8?B?eVdsdHJsem1EUTFRWXlUNDd5RFVmYm4rU1pIS2V2TTY3TEx1dVZ4c1loeG13?=
 =?utf-8?B?S0VyL0pmb1lkdkFWK2krOFRCWWxXR0xGYWFyblpNSEhPZjg1ZTFEYmNuSTZ6?=
 =?utf-8?B?Tm5CcDFHSUlJaW44UjgyRmdhbGpvcVF3MmdDNmxiL0tHeFdiU2N1MFlDaDFQ?=
 =?utf-8?B?cEtPWlg3cXdsbEFncU04SmNIVWdaenZpUXBaVE9CUXYrV1pKSXVNSUxiZG9C?=
 =?utf-8?B?di9YTkVHUnQ5RnpHbEczYTlNUmlWNlAvWnZvazFYRnBBVVZYTUFsTGo5b1dn?=
 =?utf-8?B?ekE4MDZXZHNHWndPdnpwYkV0WWhlRTk2R0JBaEpZcEh5cEhjYTNtMmpSajJo?=
 =?utf-8?B?OFN6c1RNaStKZENBWmFka3E3K3k1QmNsYVhWdzQreWozYnZSZjVtUk9kVldN?=
 =?utf-8?B?amJSZ1RZZUcvR3J1clA2SG9nTlJCbGFGTW1zM2FXWXBubUVYR2N0WXEwWmNL?=
 =?utf-8?B?WXJBdVh4V21tdkx4d3hxQjI1SU1PZWJjSnV2TCt0U2RHeFJvQy9HYnRwczUv?=
 =?utf-8?B?bmsxZWZBZ2lQRldidXluWHBTK1EyMGlHZThiM3pzbTV3U2ZrV1k4blBKOXow?=
 =?utf-8?B?UUNlRmE0TUtvWkxaYjd6OU8vdzNjaTJ1NS9EWkZobXd0NTZ2aHkvYzg4S3lk?=
 =?utf-8?B?NWVMb2xKZU1YcDdzQU51cHBnN3QzdSsxNVlOTzluOXlDSWd2eXBvdEFtUDZu?=
 =?utf-8?B?NW5lL1lvdU1Wa0ptV0RaMlFLVnpxelNpaURPcS9CcjF0YU5TdHFZbDV2ZVhk?=
 =?utf-8?B?NDNHK3pvamhVZnVnamlnRlBoSm5mNjc2SFdVbHBQLzV1NHpZaDRzOEdOT1Ez?=
 =?utf-8?Q?urqKEnCoX0IQDZidEWn8VLI8i?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9cf2ee-7565-4ad4-596f-08dd8277138b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 14:56:50.0322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcomyiTTiocJ/DYlYjRNvAyva1mviYgPrwjTbKFEECLniKqO684UuraXW2Q0H3HP7dtxDU7GIKcDZ8wDAZhBzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013
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

From: Peng Fan <peng.fan@nxp.com>


On Mon, 14 Apr 2025 13:49:43 +0200, Heinrich Schuchardt wrote:
> %s/Relatvie/Relative'
> 
> 

Applied, thanks!

[1/1] mmc: type 'Relatvie'
      commit: 392a5860bd65c467696deb6c0713b488a66d1b28

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
