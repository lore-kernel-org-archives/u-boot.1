Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3922D38FEC
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 16:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E278803F5;
	Wed, 14 Jan 2026 17:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Obo9TFOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BC46803F5; Wed, 14 Jan 2026 17:53:08 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E048E80325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 17:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efQc6icoYfOzaS+cxB/YdPugBKBtTUqgNmNVCieEOzmRMGbLmKPQA+PahbTFtIQtEF4rMS2GOJtw0gilSUn9AxOkcRW6yhf/sqHbhqhujlaIWunqjnl0lNoU7MfujAQDrlXQB2BkTXmBDlS6HSFmgvPlu57iqcJa2rkvH94oIUNnemz2pzaQhYDwP87e8Gxt3kvZ3pHfSTjV2OLAMxSV0gJxfl/PNR5ybUkKohLNhqgbj6JMkNW4PTAFmoh5Er+GtmBefgU63eFxLjsVopXbD+ZMRkj7T+/DBBz6SQh/WtUU/bhGHYOD+3YXWPuQ8k52w4NAq1WYYjn1Hr33LaVqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKSbk7550l0avsGVseBhsSa+ifw0f/cBARnJsYu/SBQ=;
 b=J0Td739fyYh2K6TfHh/r8ccpyi7WiN8Jvs4SODh7Vacx1VVlM+qprCGyyASlAylivBx+dQwolXywozhyuCSeUIsPHXbYHOvSDCPZlegByP1O0OmP0DinvvU5gGBbvAdK43fzIf9qdDr8LoEnv2YIZbz/XNysXe4i7NVrdWLddmau8HxdF4eo8U6/TRItHIUL7XH5w+Zf3UKDfaeglXLFJW3fRPNJwdgoTShTrLIwIUVdzfu9YUYkDXT3wZ87rbC8cmN/vfybreBAailzak3P1jeXr3Gp7iOF7v8aSem2+PmntkzrXEZTO8zYPnZ3YkCm3Xz9Ua/j/KVXr5nz5uBcsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKSbk7550l0avsGVseBhsSa+ifw0f/cBARnJsYu/SBQ=;
 b=Obo9TFOAEnTRW36Okm7qnudknE6A8ILsnA6uMT2TjUadPOqJSk7gG1/23D3vBgEu5/2Lu0E1aD8VtEF8HWZ8tO+b2lwefTjc76Bwam7slOfDVQek8zDy/0F2Ailcff7TT2BhZFK79Q0iLz9KRSzOOzvqACHfqqfCw7Q7Lzlimhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU2PR04MB9145.eurprd04.prod.outlook.com (2603:10a6:10:2f4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:53:01 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 16:53:00 +0000
Message-ID: <d4e17b2d-ab26-400a-b49a-e054f54067d5@cherry.de>
Date: Wed, 14 Jan 2026 17:52:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: rockchip: Add FriendlyElec NanoPi R76S
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Tianling Shen <cnsztl@gmail.com>, u-boot@lists.denx.de
References: <20260108143551.4017839-1-jonas@kwiboo.se>
 <20260108143551.4017839-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260108143551.4017839-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU2PR04MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: f5081dcc-0a86-4d2a-09bf-08de538d6070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkdldDBXZ2svSVp0SDEzVGNxcVhvL2l5Q2J3cFZWUHU2dlFGbkp2eWxUb2ZN?=
 =?utf-8?B?YXp6VmtSMlg0WmRmc3RyRjFxNUNqZFNUajZ2aHFHNFNrMEpnYk53K3RmYUNv?=
 =?utf-8?B?R1hRenAyMzhWbnVTVlIza1g4ZTNzTEphV09jUDJaNm1qUzIvekg5ZTZKUS83?=
 =?utf-8?B?WEQ2RmlnSUZueHNlN01GNDZRazBhUysrd2RycU9qODB1UjFKMTVCYndjZjAy?=
 =?utf-8?B?YzM1SkJYUC9rQzJ3QTUyUEdkb3R4SzFRSHVJbTAybWZ0MEEvSzVZTVlJb2g3?=
 =?utf-8?B?ZUFiWGd2N01xb1lTUFVZLzZGaHhMQ3h6MWRmekZRNnl5YWRsa0VoOUE5MzNG?=
 =?utf-8?B?Qk5YZnE0K2lrU0NpM1RoWkxhdTNEZFR6M2xEdm1LaXRSckRqOE9KdVNDYzdF?=
 =?utf-8?B?QVlieklUQ3Q0UkdmSlFGaUNINWtyYmNlejRsQXVXRHBLRjZtdmg5bC9jSm4v?=
 =?utf-8?B?VjVzeEMxTytnQWFQV1BJb2RuSzJqSUdZZVhKRFlxNUdVUDZGcXBUd2lUMmUx?=
 =?utf-8?B?SjFrR1QycFRscDhtblY2V2xmQ1N2QzlaWWV6TndHUzhwU3NJY29Oc1cyZ1ha?=
 =?utf-8?B?cm9WMDA1TUlYeVloNW9vd2s1WnBOWmUwWUhodExPaEFUZ2dhWXY4RUFuMis3?=
 =?utf-8?B?K0VxYXlmUW9VRzdxcVk5NFVqVW8zNjRIRERqZ0lUYzFuRjlQR05VZWJWZDJI?=
 =?utf-8?B?Rms5bkR1MVB6aDZ2QWY5Y3pBVEJEbVE2SWs1ckV5amZtYUVoS044VlBaaFl6?=
 =?utf-8?B?MExGM1loT0JDVUg0MkNQV1FCdnFBQXk3TWVOa1JtSVJzcTF1ZnhGTW1nbGVT?=
 =?utf-8?B?VHdMRFZFeW9qR3BQUFJXK0JWUXpJVHM4a2daMitrcUxhWUNiUWJKTnhIcUhF?=
 =?utf-8?B?YzNIT1BQc21UZmdTWkV3dSt1SmVIUnFVbVVzRFMra3hteVM0TTVVWnNHSFVH?=
 =?utf-8?B?bldkZEpiK0FsOXJvcTRzaTVQc1hSTWZHRkdyNlB2UkZrUTdBTnpaMkRIajdR?=
 =?utf-8?B?NFBWVDYvVndMdU11bnB1dUFDSlBIZm9qaW5PK2Y1ZnJoQS9OZDE5dkkxUmtp?=
 =?utf-8?B?VTJjTDVxMi9xVHo5SURuRy9aZmNLcFk4SkQ1aWNidFhSaEErRVpwZE92TFlI?=
 =?utf-8?B?TmUyc3pJQVJiWVN5ZVhVS1BENWNXanc5aVdJZnVMZGxqdXNpZ0VnMkdYRVFl?=
 =?utf-8?B?UFN1a21qQUZ6VFpDZmoyRnZZbDhKN3hxOG9VWWhUK01FODMrZHd5TTJ1Uy9N?=
 =?utf-8?B?d1BTbGx0ckdvMFowcm5WWkJneHd1cUM1M1piUEZieUtDd3hFc1JPYmxrWERj?=
 =?utf-8?B?ZytmYnpyKzVmN3BzdStCNndZQ05RcVA0L3JIUS90bm9oaWhsa0M3MkN2amxW?=
 =?utf-8?B?WGpFcEtMY1NRYWIyRG01ZURRN1p3dHRVdEdRR1NWRDJXd0ZTU21wUUNJanVD?=
 =?utf-8?B?S1d3ZzZmRmNNeEtKem90bW9kUEJURTJiMGdHdjVyVTErd05zbG85eE1haFcy?=
 =?utf-8?B?L1VnRnJwZVFLQ1oxeUFKQXp5QU1BamRObVpBV1d3SkVTSUJNbVd3aklXRHFv?=
 =?utf-8?B?dExYemJzOVoxRHo1TG5WbWxYbUtCUXN5MHk4ZXpaaU9oS1JXTDFoKy9KUTc2?=
 =?utf-8?B?QndxdE52N1B5NWRRSnBvVmx6TVNaaGpPTDZ4a2FKT3d0eU1ib0wyYWN6T1BX?=
 =?utf-8?B?UHBjMWh3MXRLZ0pEeW1BOTNpRkZ5bzd0QjVCZzNTUU9xTm85WHluczdsT081?=
 =?utf-8?B?WkRCUWhLM2VMVUNjamJmUmpHRG1vakNHU05mM2lMdnhpNmdIalVnaXR1OFh6?=
 =?utf-8?B?ZkZMNzEwVGdPR1hJVDdaWTVmV2ZwS3E3UFVBcjdvTElKeEdjT2VKL3F6K0ti?=
 =?utf-8?B?K0Z2d2JRRmhFWmh4VW0waVZiUE9ublM1SUwwSTM2Q1hSQ1pZQ3hiOTVLZ0li?=
 =?utf-8?B?bEU0M1NKaUlMZXRGZGxvOHp6QWpINjhRc3lzUEFFRXl6VmRqRWVsUTl1WnVw?=
 =?utf-8?B?aHhETEV5VE9zVXFtTWo0TmV1VVhqSnA3V3FqRnYyRmFXOVN6R1IxTm5JTmhU?=
 =?utf-8?B?a3N1M1F5NDhlblF6NFVJTW5BYVQ3TGU5ejNvRWNuZUwxWWQ5Rm5uQzFVK1VZ?=
 =?utf-8?Q?ZSxY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2JCQUdEQ1g5d2NPeVJMT0RnTFMySGxjUHlIbTByU3Q4czFnQTNQcElyOWtN?=
 =?utf-8?B?djZOZGVYRCtsSnF1Mm9zVE84akQ2T3lTWFZKdkRHbjd3R3FNSUxDNFA4Rysr?=
 =?utf-8?B?emtWUDluVWNKUTY3VVMrclNTWkpTcmNQUjZQSk50UE0wUzVld1V6NFJySXR5?=
 =?utf-8?B?YXRVcWNCLzFuNkJOcmdweG1oNnYyRGtjQmppc3ByRGRRZFIxeU1td3lBclc0?=
 =?utf-8?B?aER5V3pRUkZ3S0dncFhma3ZRWTV1bVhLNnk0Skw0VHFmelJGdnRsR0RYTEJS?=
 =?utf-8?B?eEtRYlpCL293eVE4ekljRUF1ZkdONmlHQ21oaDIrb1I5emJrT0RVVDFPdndu?=
 =?utf-8?B?QnVXUGZrU1FOY2xoM0NSZnhaWDduZnhHbmVUYVBPVXRTWDNyV1Znd2p1QUdW?=
 =?utf-8?B?cUk4M2dleTZQVGY1UkRrRjUzOFA0cTBDck5LV3lnU0dDanNIelUzeUJIbGw2?=
 =?utf-8?B?V21YUzJkNWI2d2daMlY1YTI2Y2hMU0h4SUdaSGtPaWRnQ1Myb0VBVEttWTli?=
 =?utf-8?B?ZGtRcmthRnNWeklMaERYS0FSaGNsWjBWdHlPc1NrdStrYTBzYTZVQTg2NW5r?=
 =?utf-8?B?OXcxYi91MlIyc1dBNERlQlJlUjhkZTZXdkJBdEEzc29qZFVCMkNTamo3T2c1?=
 =?utf-8?B?c2dVZWJSUEFMaDVSbWptYUl5S1hTUUp4bUM2RzU3YnNPSTZjeFJqNk5uaW44?=
 =?utf-8?B?Tk44U2lyYmF4cVRoMVQ1OFJxSWVna1hQSm0rSnc0REZaNnBNaTkraUZGZFMr?=
 =?utf-8?B?ZWlJdERLT2VGWnQrWFlORCs3eUhRM0xpNWtGa2tGc1hDcmY0WmcyYVZWY213?=
 =?utf-8?B?M2xIRk1OczFHQ2F4bzZTRmZqNC82YWJ2RkhjbXVHZjdEbUNoU3FFbHAwWFhl?=
 =?utf-8?B?WEEvVW9GYUhEc3lVY2ZCVlBDV2Z6eno3Wk80bmlVbno1UjlhdDlWcUhnanJw?=
 =?utf-8?B?R2dobFYrNUJ6Z0FGbXk5NDBqNVZOSFZQa2k0MUFnZGhoUEdJbGNMRlZMYmp4?=
 =?utf-8?B?b3lCMjB6LyszZVlXcEJESXNZN3d2U2FxTGdqRktLQ0ZoNm1ldzczUE9UTndG?=
 =?utf-8?B?ZERldkJtU2p5V3RVZ21waklzbzhVQXdvVkNVZVRlWVNOZDBnS3Fha3JGM2c3?=
 =?utf-8?B?bGVxVE5sblNmZEFzVjFPaTVSL0g3UFlJajRFRStvQWY5WVNYYzZpMnNQcVFP?=
 =?utf-8?B?ZGk2QVBRQmRuVFJBWmE1RmFqNmcrczhCakJnZnJ6UXBqaTJMTUY1YWt0RmpV?=
 =?utf-8?B?cWpHUGczNTJMOW5QQm9DOHVYREVOMXVIMUhLUFQvWlRkZC9oUkUrZmU2bS91?=
 =?utf-8?B?aHJHUFlaMzBRUlRSNk1Eakh1alpCUW9lWmxrUjNyWndRS25QWTZYR3pmWkx6?=
 =?utf-8?B?d1JYWHV0aG0rZEtmelptY053bmluR2xMV3NQRm5VOFNlYkJnSjdOSWlYWDNX?=
 =?utf-8?B?cGJicDFtSzllSS9vWEFjVjlyS1ZvdTBwQ3lCSTF5dUkyMDVRb2hkdHEwcnNS?=
 =?utf-8?B?NzBXNExoYlk5Vm0zRmJ6eCt6R3MvUllOcG5qUkk2Q0xpRVlwZ1J1V0RxZGFC?=
 =?utf-8?B?bnRDcHlZME1JeDlRNFQrM1hXa2dlMHZhYlFXcmhrajF5WTRmdFF1RGtNMVJr?=
 =?utf-8?B?NzJXa1hPNWUwUU82Vmo0dENnZlBCUFphQmlWZU5mbDA3OXdhWE9pd0oybWNO?=
 =?utf-8?B?ZlFJcGQvallSRG1odjkrejkzQjlOY0hqR04xRXFuajdwSmlOUm9pNGNWMFkw?=
 =?utf-8?B?WUhuWXNta0JDOHdBVmJvNWtjWDJGYVloR3Urcm5qd3dJVC9aeWErTFQxNnJ4?=
 =?utf-8?B?NFBiYUQvaXdldXh1bHYyZ3Foam51NTdWa2tsSDkzMERpL2NpVUF6VFBHanc5?=
 =?utf-8?B?c2o2RGJ0OUtMRlFKQkVYOE92UHY0M2Ywc0pmQXpKR2MzRE4wcit4czJRM2tp?=
 =?utf-8?B?aHBKOHVvZUVZQW90K3pzR1FuN3NzTE1yc0xaT2dNV0VyVzNTZTlGc2JQQjA2?=
 =?utf-8?B?NFgybzd2aFZLdG92ZGFpS21oNHI0ZlV2dUIwZGRhV2t6eVhhL3FhRzlZeXli?=
 =?utf-8?B?UkV1UDBqSmRCbTRjODJuSE5rNE93MzYvb2F4QXlSVW9WQnJ4S2lKbUpDSjQ2?=
 =?utf-8?B?OHdFSmhUTFVUdVhlbGNCbzIvUkl4S3BETm5oa0dCTVdJbHVDeUNpWEJ5UHNO?=
 =?utf-8?B?WGRxMnZyb0diSVFramhGVDRwL0R4b2lJaUNMRDJVQm1ueVU5cDdKbWFDcFBL?=
 =?utf-8?B?VEFZcUZ4bVNqWUs1Vlo4MFJCYmxUdE5DeWZaWXdObWdqY3I0a2tCVUVTYlVW?=
 =?utf-8?B?Y0VyN25YWUZlejliYU1oNzhnU09CQk1mcGtqZ2tyNEJNMVRWci9yQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f5081dcc-0a86-4d2a-09bf-08de538d6070
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:53:00.7879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUAYhZG0wovhuqO94RJ/CDq1v/WZdp/RdIOfDhJvWELJ9xO8IUIcUfniOcK6QtMvxzC0UDuhNRZqVGbv/6kEbhGl8iDGM4t76OiAVtvt/I4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9145
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

Hi Jonas,

On 1/8/26 3:35 PM, Jonas Karlman wrote:
> The NanoPi R76S (as "R76S") is an open-sourced mini IoT gateway
> device with two 2.5G, designed and developed by FriendlyElec.
> 
> Features tested on a NanoPi R76S 2411:
> - SD-card boot
> - eMMC boot
> - LEDs and button
> - PCIe/Ethernet
> - USB host
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/dts/rk3576-nanopi-r76s-u-boot.dtsi |  3 ++
>   arch/arm/mach-rockchip/rk3576/MAINTAINERS   |  6 +++
>   configs/nanopi-r76s-rk3576_defconfig        | 60 +++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst             |  1 +
>   4 files changed, 70 insertions(+)
>   create mode 100644 arch/arm/dts/rk3576-nanopi-r76s-u-boot.dtsi
>   create mode 100644 configs/nanopi-r76s-rk3576_defconfig
> 
> diff --git a/arch/arm/dts/rk3576-nanopi-r76s-u-boot.dtsi b/arch/arm/dts/rk3576-nanopi-r76s-u-boot.dtsi
> new file mode 100644
> index 000000000000..632fabb6af56
> --- /dev/null
> +++ b/arch/arm/dts/rk3576-nanopi-r76s-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3576-u-boot.dtsi"

I don't think that should be necessary?

U-Boot should fallback to rj3576-u-boot.dtsi if there's no 
rk3576-nanopi-r76s-u-boot.dtsi, because SYS_SOC is rk3576 in 
arch/arm/mach-rockchip/rk3576/Kconfig and the wildcard list in 
u_boot_dtsi_options in scripts/Makefile.lib.

More comments below but they are definitely not blocker for merging this.

> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> index 393edd3984ce..79cf9e97f70b 100644
> --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> @@ -10,6 +10,12 @@ S:	Maintained
>   F:	arch/arm/dts/rk3576-nanopi-m5*
>   F:	configs/nanopi-m5-rk3576_defconfig
>   
> +NANOPI-R76S-RK3576
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	arch/arm/dts/rk3576-nanopi-r76s*
> +F:	configs/nanopi-r76s-rk3576_defconfig
> +
>   OMNI3576-RK3576
>   M:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
> diff --git a/configs/nanopi-r76s-rk3576_defconfig b/configs/nanopi-r76s-rk3576_defconfig
> new file mode 100644
> index 000000000000..af149dc4ba56
> --- /dev/null
> +++ b/configs/nanopi-r76s-rk3576_defconfig
> @@ -0,0 +1,60 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-nanopi-r76s"
> +CONFIG_ROCKCHIP_RK3576=y
> +CONFIG_SYS_LOAD_ADDR=0x40c00800

Should we think about adding a default value for various Rockchip SoCs 
in root Kconfig for SYS_LOAD_ADDR?

> +CONFIG_DEBUG_UART_BASE=0x2AD40000
> +CONFIG_DEBUG_UART_CLOCK=24000000

Same here. I'm assuming there's a reference design most people are 
basing their HW on, so having a default DEBUG_UART_BASE common for the 
SoC makes sense (and we could even then have a comment specifying which 
UART controller that is). As for the clock speed, I'm wondering if we 
ever had something different than that. And also wondering if it's 
related (should be in sync?) with &uart0/clock-frequency?

> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-nanopi-r76s.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set

Why not :)?

> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MISC=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_RNG=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_GPIO=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_RTL8169=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y

The two above also are always the same on Rockchip no?

By default, the expected baudrate is probably 1500000 on Rockchip, 
wondering if we shouldn't make that the default either?

> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y

I'm wondering whether we should think about setting WERROR on by default 
for new boards? What do you think?

Cheers,
Quentin
