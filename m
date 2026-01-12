Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B29D2505E
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 09:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A85B83CBD;
	Mon, 12 Jan 2026 10:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UZeKF0lQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECA0383CB9; Mon, 12 Jan 2026 10:42:48 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E28183CB9
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imVkxztTZi4PDm3jnjFH328iRwfyBgzexN+eU8E+gw3suicDZcKfRg2PtWyre1yhW8/GN1ztNT7Ee2bHcLmeiCAXnxX/b0Pz6Ra+TKdPU3fIuSnrM4Ut7bpYqu30pvdzJzEz2pBKF0xDbGWuFYO+L4KpjMdOBOCz6gvO1F9koDHyedg+9TG2zVmlgB4hjMYSyYJ0a7a9Eu6oWfT/PCHHqROIX9TSU2Qev0ObOnoNpgn6bccP0bcRTYDibqV/g0JG3nZsIf2lPlf1ZSKlijPW4YeeSJpFrj0wKB77hz98eazJ8BI6DNJ3DJ2EnF0/IjNjYWxOF6LjzoGjDA/1Qxhi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ln9DaU0C3+H6clrSEgXv8PrK5e6Xv+ZDjyBXkh8AtD4=;
 b=ZlUpS+Jr30qfR41FRScZMiSkOZpuiBAy2z+DMTB8FcZmpVD17s6f10Lfevcvs09n56g43sUU/gRVFkHkxM4Wk/g/PWM8BwP5vKTfuqgPZFf8sDoraQMhI2N2+R1EqrxWMp24GIlex5OFmyQoAA55lUup+ercQp7AyDW2r++TDov6UEZQmecHhh2/IXF9WwGHep6mlx9KxfstQS6dha8E/pr7gMxbOPeB6qAPYA2Zthmk8rFkgrdFXtY5yjlYjSkHTfYyb0FuyHfcpknEunPccWHS0sivaJ8tRk4jjVQfN+zgJcjXgfIguNB2t5rExUzoIBZLkO4HXqTq/Ll/Fprk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln9DaU0C3+H6clrSEgXv8PrK5e6Xv+ZDjyBXkh8AtD4=;
 b=UZeKF0lQmiW45054NQLQ/JNE1UcMvDLDetEX3E8BupA4CL8o1p5DUXd/oGbkiigNbLFfzA6/Xc9bWpazlSDvBXLlq6ctaTSfu/VSXbYBhglQvlf800v6wwkeef7ZKh6OV2vAjOmwdN+xB+g8iOf47Bp3B7Ht24phL9kz5h+deAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB8915.eurprd04.prod.outlook.com (2603:10a6:20b:42e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Mon, 12 Jan
 2026 09:42:42 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 09:42:41 +0000
Message-ID: <ee56e793-1f37-490d-9ca4-c62cfc2524b1@cherry.de>
Date: Mon, 12 Jan 2026 10:41:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mmc: sdhci-cadence6: Fix the license to GPL-2.0+
To: Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Leo <ycliang@andestech.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, oliver Fendt
 <ofendt@googlemail.com>, Kuan Lim Lee <kuanlim.lee@starfivetech.com>,
 Wei Liang Lim <weiliang.lim@starfivetech.com>
Cc: u-boot@lists.denx.de, Tanmay Kathpalia <tanmay.kathpalia@altera.com>
References: <20260112023948.46008-1-hal.feng@starfivetech.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260112023948.46008-1-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: f2248ce6-d524-469d-2df5-08de51beee53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEYrMG5OWmVMd1Z1T0o5blhTdnhTSU81ak90YTZpSVc5UkhNWElUb3JQa0pW?=
 =?utf-8?B?dk5sZHg1M0hTUXQ1RTdPQ1YvNmg5eWJGS1J2Z29YQ0xBYUF1Ui8yT3V6SkZt?=
 =?utf-8?B?MVlBSTdpNlUwVXlDdVhVU0R0cEdGVjE0ZklFeTVFaDNwK0x0TjdhRXNadjRs?=
 =?utf-8?B?cDFFNnNHU0pIb2V5SldoMGppeS9qcGVLK2ZYeWIzZktTUFpWMXNEODJhUkxC?=
 =?utf-8?B?Vko2VTh6dWtlUUZTWXRlVkxwV3FtWUNSbS9ER0ZKZXNld3IveEpGQlhvcGd1?=
 =?utf-8?B?SVY3bU4xOWFrVTA3b09KOENnOVRMVTlYYlFKRTZFa2duT0tTWWthR1d5UTZn?=
 =?utf-8?B?b2NsUVR2Q2k3NVNCSVg0UURDR3NXUDhEVHUzYnFjQmc1QTY2RmJsS2pGWDlI?=
 =?utf-8?B?U0RLSmJJUGhyZXRMcVZESm9TZ04yK3oyd21JSlV1VmY3UkE3WXRscHBpQmRW?=
 =?utf-8?B?aU1wWk5mN1M5cEV6a3M2VEpGS1lFOGZxQUR1OEJkQTJOSlJJbSt3b0R3SWYv?=
 =?utf-8?B?ZmdoM0lFYVFuOGxqUVFUOVpoWXcwd3NUNG9CVHRwUFhza1dvMTF5eGYxR204?=
 =?utf-8?B?ZCt3L01yUzNBSld1bnZHQTdBNzBQYXpFSFdDcGJWVGRGQnFqRTJTc2FBcnVP?=
 =?utf-8?B?SXgxL21FNFhPZ2haMXRPMjJWMHBpeUFZZ2JxSVBxWjB0ZFQ1Vks3M1NQc2Q2?=
 =?utf-8?B?dGx1MHBCOTc4b2F2UDR1Wi91aDF1RXIwTkVsN1ZvQjFCbHV3TS96ZWlocGJD?=
 =?utf-8?B?OHJQMXdJUUl3Rmg5U2ZrTFh4OE94VGlsRlN5OHNVeTl5d0dNQldvZ29RSWdi?=
 =?utf-8?B?QWpuNVBteGpqWUJ6UXdBOFVnN1JxZWdIQnphd2NIWDVuejgrQWxlWmR6WlVh?=
 =?utf-8?B?ZHY4RFJrUzJyTG4xRitaMHVObUxSLy9BRFBkRmQ4TU1OK2JiMk8xbWUwSXQv?=
 =?utf-8?B?bkFHRWhINjVwWjJyZUpUNFJhRlVWNlJZSnowZTdpcWJ3aEFLMnJTWitUd3hM?=
 =?utf-8?B?VmNtQ3lDQ3N4WlVxeXdnZ3ErMHZKQkhCMHQ3T2UwMSt1Z2FxbXdXWHFIVUFy?=
 =?utf-8?B?QzdkYjk3d01IQmwvbTNQN1Uxb0d2dTVNbG9jSTRXdHQreFp4U0tJR1JSZDFl?=
 =?utf-8?B?amVUSkh4UklLZ2JqNDB4YlJ4SXZOMlVyWmx3Ry9YQUxoQ0d1QWE5a3RWMERM?=
 =?utf-8?B?MjVqQk9lZHpIckNHM1hveGlTZmljZm5zdi9yWWxPenJhQ1c1bjltS3lVRmRM?=
 =?utf-8?B?WUdwQUE5S1R1bEtkVEFZeUNlOUp0eGNNdEtkK3dQRG9WZzhkcStkdnhEWXZq?=
 =?utf-8?B?WjRleHRQYXd3dnI1QWNoUllVU2JQeWJpOTFrdEl3YnpnZHZaaUFHUFo0RVQv?=
 =?utf-8?B?ZG5PajJZaGdBNWpjTVowTm1iM3dkNGdVRUtyYWRjaUhTNGtGcnM1dkxFYWVM?=
 =?utf-8?B?bEpaUCttRm9Pbks0bUFDVXlHdm5ZSVdlN2FnWXJJQU1Yc0ZKNG4zMzE0VVpI?=
 =?utf-8?B?c2RhT1pEWWYyUmZ6NkpNY2dyZzBRTEg2OXREL2tJV3EwYWZkRjVadDlxcGo1?=
 =?utf-8?B?aUxrdWFRL1ZENEpxaCtXU1RJMU1tUUdRWnNIOGtVaENjUCtiaFhKeDdKSStO?=
 =?utf-8?B?TThYR3pPVDFiU21ZaVhwSXYzaVZoSU15YWVQT2xxMHk4TzZGNThHdmVsQWlY?=
 =?utf-8?B?SVpaOVo1dk51SERkYWI3cVBKbzQ0dTQ0QmM2RG9SSi9MRVdBc0F3WHNJTWQy?=
 =?utf-8?B?bFpuUVpoMWt0ekF6TEZEZ21IeGVVS0lqTUtjc2ZiMWd5OU5lUTBINTV1V2Vx?=
 =?utf-8?B?ZkVBcURIWW1oaDJLRFc1Tk5ZVnZpeDhjaDl6Y2V2dzN4Z2RUS2RBU2VTQkxC?=
 =?utf-8?B?czZQT2NZOW43azcyK0pJVUtBaS9zOEdlb2JEZ1FMekZwOXcrclkyWVpnNjJq?=
 =?utf-8?Q?xT0ocAHrX1pEwpKaY9F3kwMhDpD+AONj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b09NdUI1TGVMWS95NjBrOWJoL1BkSDIzVmd6Qzc1Y0lTTVJYUlVhSlVLY2lT?=
 =?utf-8?B?aCs3M2pkbkNtbTZKS21DNG5IWnlmUG5TYmg3VGhBSkxLUmtFQ29FSEF3b1hm?=
 =?utf-8?B?UXJsVUtRcHdvLzc2S3hVTWhBK3pGWnZDcFEweTg0bWJ5bWM5SUR2TlRlTCt2?=
 =?utf-8?B?Sm9YbUNuQnk3SXNIRUM0Q09TUlNGemx3MjhMZjJ1YzU5ZmJjVmt6a1JQS1Ju?=
 =?utf-8?B?YnArMEYyK0lQM3dVVis0aUkvT2JtaUlya1N2dTYyRzkweUMxMkxCSkZ2Tmxa?=
 =?utf-8?B?aUFubmhlV3QwUzFiV00vb0JQVHM3SUg0MjBoeUpjSnIrcGJGdUt4MjVETmoz?=
 =?utf-8?B?alBnT2w5Ny9FTEtUZDlkQWlSRkdZaU9TeU5KYStTYXdsVU55Wi81b1BNUW5K?=
 =?utf-8?B?blRtaENSSlR1T1NydmpaRjNiSVVsK0lzazJMVFhZR29wY0ExMWVuUlc0NXFK?=
 =?utf-8?B?ZnpDQkdnbmd1YnBKd2pzMzFmYzRTa3VOcXFvQzUwWkdQenFaTGZhMSttcUln?=
 =?utf-8?B?UTIzZkQ4SVNuaENxZWlKUkpnOFpMYWozb3hoeC9Cdlh3cjdrbEN3ZS9oK0li?=
 =?utf-8?B?SE82eTkrbnREcC9NRjRUYXhJWW93cTJvNWUvZHpxOG9mMzdNWDBqaC9Jdm9v?=
 =?utf-8?B?TURLcUp0Mi9zbzFsNTlUOEl5VllRTWFXSGVGVFdLMXBKVXF2bFd6ZytCbkJN?=
 =?utf-8?B?V0x5Wi9TdnFnLzVEUHhzcEh6Vy9uL2N5YkM0b1J6dy9lSVk2dlRwcWxjRWFm?=
 =?utf-8?B?anFNY210VEE3SDljL0ZuZExlQUhnQTF4MjBTRDgzZ3Vtc3RNU1pwVFFDQzUv?=
 =?utf-8?B?b1pOVTljN0RhQ1hqdmh2WUsrVm9QYWxJL3A0L2VCSEtYcHd6ODlWV0tMVS8v?=
 =?utf-8?B?ZVNyTmtBeTQrSTkvUUJZMklOK0d6cHdNa2JXM1dxWGpvRlYzQ3haNnhISUcy?=
 =?utf-8?B?UkVlWlZLMVVuNHNNY3hKNzBoWDZ3amRXZi9CUVJWd1BNc2tDMmNDc1drWGhH?=
 =?utf-8?B?cjZ3Z1ErVjdCNGtuSXFGYVhHOW45Qmo0bDB6dDRmaEJNanFsM3dRQWJSblpv?=
 =?utf-8?B?MDN5MXNZLzh2VU8yYU5heE4wajV1cGdjd2JqTzljZTd5ZHZLSjN6SENmMThG?=
 =?utf-8?B?L0R4b25WMnJvaDBVaHdtZ2srdzhDeU9FL3hoOTFsNmhETGJZaU8zdERUREpN?=
 =?utf-8?B?cEJwcjRqTVdvTnhBbDhGdndMdXIyU1dGOEgzZmRzQWVMN2svZmtBblN3T2Rn?=
 =?utf-8?B?WkUzc3VjLzA5RE9FUS81a1hMUGM0cURVbjgxUm1WWkFuck94R1NRM0RRRHFH?=
 =?utf-8?B?aDdKMDhXLzNsZ3luejc1WUR3WVJhUE5TUXRYZkpVekRLVkRSNC9VaWRQdUhR?=
 =?utf-8?B?NTQxTDQwbTIwTnlRNm42bEFkSXBuV3NjVWdkTEliK0dGNE5mSFJEams5S2VE?=
 =?utf-8?B?STR3VGkxSi9TWk9aVWlRVE5kT0IvaXRQNkpuYzVyVExDQjlyMXdLaDE4VExQ?=
 =?utf-8?B?dU9pb2V3TzVsZ2Z1ZGNNbmYya1c4Qlg3QWlpN2Y1TVNvZysvK05HZlN2aTNj?=
 =?utf-8?B?UXNwRTcrVVRsS28vcW9HRWl4ejJJSGRwQ0loOVFkZVI4RWp6UHBNOThFQjNy?=
 =?utf-8?B?S0lPdFM0VTZlQzhHajh5M0Y1TCtKY016NEhNZHlyMFJ6VTdWWHJpdTJ2Wm1w?=
 =?utf-8?B?Njl4eEl4K3BONkF1OW53Z2xySEltTmxzcmFTcnl4TEt5YWZEY3JNQWFmaXNG?=
 =?utf-8?B?OCt3bnh0VjBXOFNoc3FETk82LzhRNG8zK0lmS2NMSU9uTkpzZmdRbW81dEJx?=
 =?utf-8?B?OEFsZU9BOW9OaWVLUFpEU2dvdThicVZYQTU0b3VNTEdvQnJIVkl3ZG9CVFpY?=
 =?utf-8?B?cklLRVNNbGVJOFRsUGJKdVJWZk5LVFVxUTRTOXdmbWRacy9EdHdBLzVVV2Fq?=
 =?utf-8?B?bENKNkdKWERRelhabHhDTmpPeDVPaWpmT0xoazR3aWhaVVNBenAzYm5wUDJK?=
 =?utf-8?B?WmE2TmVZU20yTXd2ZnNQR2pTL0ZLbi9Ed1A5UUFkd2xCdjNZcnpzTVUyTHpE?=
 =?utf-8?B?dVRGOStUMCtpMUd6OG9ZYk5GaS8rL3hvZ01QRkNXeXZpallENGh1ZVRGak8v?=
 =?utf-8?B?Z3NIUHFkcUpRU3E1c1c4QW5qL3ZDa1FxeXM2eDJrQUVjcmRlbWhVc2p6Yk5H?=
 =?utf-8?B?YU51Vk5aaUo1WldUZnduc2w4MWt3bHVaRVc2YTNEOXVObkQ3L2xJNVVrN1ov?=
 =?utf-8?B?UHhPL0RETk5tQzhxcDN3U1ZzVzVUSTZjUWE1eDI1R0hKTVIxQjl2dG5JU1J3?=
 =?utf-8?B?bEhzOWw5NWprNVErQkREcDVKWU5xemVkelNrVmFGYW9UcnpXaWxOQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f2248ce6-d524-469d-2df5-08de51beee53
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:42:41.8285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GP2Er8JqSrLpIFj+v37nVdSGKRPrC8TBvRZi67HyjrsRCEcgR+73e3Bo+WEP1Sz64mewDZbVGhl4Xjw52HCqcB6iesDa1doT8JLclGrQ+KA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8915
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

Hi Hal,

On 1/12/26 3:39 AM, Hal Feng wrote:
> The license of the file is not valid. Fix it to GPL-2.0+.
> 

This matches the license used in the header file added in the same 
commit (see Fixes trailer).

> Fixes: fe11aa0b8ca3 ("mmc: sdhci-cadence: Add support for Cadence sdmmc v6")
> Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> Reported-by: oliver Fendt <ofendt@googlemail.com>
> Closes: https://lore.kernel.org/all/CAFoF8fC4foffYJgYm9CkViET83gDu05noVRxLxgs+KWXN_-LBQ@mail.gmail.com/
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>   drivers/mmc/sdhci-cadence6.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
> index 91a245aa490..ca1086e2359 100644
> --- a/drivers/mmc/sdhci-cadence6.c
> +++ b/drivers/mmc/sdhci-cadence6.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0-or-platform_driver
> +// SPDX-License-Identifier: GPL-2.0+

Would have preferred the canonical version (GPL-2.0-or-later) but that's 
good enough here.

IANAL, so I don't know if we need approval from all contributors to the 
file. Fortunately, there's only been one outside of the two starfivetech 
contributors (whose mails bounce), so adding this contributor (Tanmay 
Kathpalia) in Cc so they can just provide their Acked-by/Reviewed-by so 
we don't have to find out.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
