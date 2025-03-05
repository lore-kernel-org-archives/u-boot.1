Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A7EC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38D118083E;
	Wed,  5 Mar 2025 14:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wmZjvsEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1C198083E; Wed,  5 Mar 2025 14:29:29 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CED3A807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:29:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRh/CMQPBUhcxJCmr2JvSR+n/7kKQSrnF4WBO7EAORcg4XagbCq4DXFM/91S91elEh/nDwUyDw7BBiQaw4U6yrmB6Gm5iwG0tb4df7E+/mGNhcD7dx9IMbkD4JLd8yWP9a1OEu58SJ2lWB6z3VL/xWabs+DSOrtPqAvl+HlWU/6InE7WJPdYofu//YyQcdXGg+HHiN7yyiLjruTwXGn3hzY9PDD/HRJRfjW3l+A/L/LHIXuBDUg8XqJ7E6ZdkIqIjYhM4nuUpJcnhJYk+yJedRHnWJNP9W9WqpPFE+IaPIwKVCvrzsB9UUnUIoqdKtIsoTC6NjbNqHMRFEqJCzGpkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSnL/iQIbYrwOwF+4ROgujtIlhV2jVeejcdY7hRn4qE=;
 b=t7fOghIjskwO1qrs4bHx0rtlhTZCSaCLiPNWQs9ferba7RoqJL7ihF5beesw54q//AI2Uen9KSsAjxiLRP9KUzDPKi6+nwA9E0JR7Tw8kqvOfHqICnEvR3I+T7mVZXJTgGCAmENB47adHemOlR0ricx0yA2Ri2Z12cMsgMPUF88e4IexaBdyRsig+3fwSrXd17HV8Nl57UTcFa0O4JNoVQSr9tphclHEihLDR/O/hmJmQWRVL29ZniKFTzmotNWBavHCqOJP3Ogc1CAaEgN1Ch63RtKpP0hrAij7tjujHxdgfBQeuHnwMfZdFL32bB0r9u+CFBuC2765tZC6hotedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSnL/iQIbYrwOwF+4ROgujtIlhV2jVeejcdY7hRn4qE=;
 b=wmZjvsEnA9eN2vCiR+33yJr9jYzormh2DAYWCEP2mywh6G6xyVubQ9viRnbq16/qP5GaB3PXosbOl3iLdq0TKuKLJ7yzZ2oqz25MJl8KwvJZOUJSLAmdujuEgoSpCuC42J1T/2/3QF7sBLuauR/ldOiRr+VcUSNk/qsLYs4cRR6jrYexmq3G7EQL7F3ea+yDw8f18iUig1z9kikZ+VcNldRCLVDIu1m+v8YUPtMHIiaeqlZWyYkQjWylZtfffbfFXHlavhKJVGVGObHdzplCaCLB4+/QkUHbN8ks6+BHpYAqMkzHtacWvdDfK/fWbwF8fwcvuoBGKwmk4ArRbLpdxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS5PR04MB10000.eurprd04.prod.outlook.com (2603:10a6:20b:682::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 13:29:26 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:29:26 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:20 +0800
Subject: [PATCH v7 08/19] sandbox: add SCMI clock control permissions to
 sandbox
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-8-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS5PR04MB10000:EE_
X-MS-Office365-Filtering-Correlation-Id: da1f6b3b-3a04-4295-5cdd-08dd5be9bfd8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkR4OGlwM1p2enYvcFJ3SzZwdEF4SytaeWtrdVVnaHFXUWNadXZHVytHSm94?=
 =?utf-8?B?Sk02VWoxend2VjVFMmZNZ0VOM3ZVMXR4RWhrWEM2bnlsazZKZGN6bnluYnYr?=
 =?utf-8?B?RUJDSTh0QjZmSDBYb2JianJqVTN0RitBTTNKaFlTN1R0RytCL3U3U0VjaERC?=
 =?utf-8?B?UlcvMTNpeGFMYlgyR2drZEluOGVHUjVSWFJaVFBWOWFnRW0yZmNRbVhaSmhq?=
 =?utf-8?B?MXZoZDUwQ3UwUndnaUFLRSszY0RKRFp2N2JSY2lJRjVuNUFVT2xtcnNBYkhi?=
 =?utf-8?B?SU9KMVhHZXRQSGpvUHJ4RVFrd0hURndpZU0wS2RqMGswWm5RcldEMCtSOGxZ?=
 =?utf-8?B?S2UyN3NTT0FRYlBVREZPbWlWQkJxa2R5Q0NHdVhaNDc4c3N1TjVKenJJQm50?=
 =?utf-8?B?V2ZCY1Qvb1haQVI1SjMvSGYwbGRUWTZEWDkwdGYyK2QzNmhSZEVEMGFlVXRI?=
 =?utf-8?B?L3Z3SDYvU2ZwVnphNUhTSE5kKzQ2RFQybUlDdkZOY1c2RExReENHRDFWN0N0?=
 =?utf-8?B?bC8rUlBIdGNNYjhiREpFRTZMenJXVUFyZVVMaE55dkVrMkZidi9LVFlGK001?=
 =?utf-8?B?bllPRHJ3VEFBMVZ1S0N0OFBzL3dCeUpqSHo5T3h2K2pFRE5xOW1xeHMvVFND?=
 =?utf-8?B?S0U3aHErM1hwMlg2QmcxcTdKcXlmTjZxMnFmbnhadHFYTVY1RkZmR3NBeTh2?=
 =?utf-8?B?a0Y3Nk11cGhVYitwYmw3TDhkREN6UUxEM2lpNjVUYXdDcmNuTmp6M1dmOWhK?=
 =?utf-8?B?N3B4aTBMc0trQkFmeWx4eEJFdEgvaEJNVm5vQmVuN3FzWTA1NVUwaWNFSVFO?=
 =?utf-8?B?QWlJK1IvbVpYc2J4dUNxOWxHeFA3WG8xb3hId3N6b3NCc1JtTG5BN3dtU1JF?=
 =?utf-8?B?QjdqRXVpUEJlOHlUT0xSWlcvQnordnZCUFZ1UHNYUSs5dExmakdVVnRDcWVO?=
 =?utf-8?B?YTlVeGNKaUIzSVdZaGdER1BGc3l1NDJsYkxrSzhJUFJLZlViK1E5SlRxTWps?=
 =?utf-8?B?amVxbjZtZjlXTDBYUzZxdm13SHEybU9aOGN4blZrRHAxY3hYOVVmNmprcTFh?=
 =?utf-8?B?M1AwTlZieGh4Q3hTOU5CbXNiTkEyRnkwSWIzb1hIdGJ3YzE3dlZGdlVUbm1x?=
 =?utf-8?B?YVNPVHVRRm94K2o3dDB6SFlNSVNVdDViUDluU1lnRVBGa21TczgwcXU3VFlV?=
 =?utf-8?B?azg1dUtkMktNOGV6R1hOZWc2Ty9Zci9IUnIvdVNwWlQyU2hYQVo0Q1RPeTVG?=
 =?utf-8?B?Z05ySnJGOU5xODRGejh2a3VsR1pJZjA5SFB4VW9PNVFzVUlKZ0x3MkRJN3RL?=
 =?utf-8?B?L0w5MVEwNXN1T0ZBNE0xeHRKcU1CS3VFc05xTzVrK2RMTjFDRm01QlRIRFB1?=
 =?utf-8?B?cEZDT3JreFpCTFluZUFlUHNubm9zd05wd2ZORGlOSVBOVFI1a2dTVmRwcTcz?=
 =?utf-8?B?aXY4akdWaHRoRVZHcU9PVFJnMzUyZERKOWlYL2k1TUlGcE00RzJhVnI1ekU2?=
 =?utf-8?B?UTh4OThLL25WOFdTRERLbGcvUkpMcElBUE5OeUhIUnpOeG5CN3V6YmtZVU5q?=
 =?utf-8?B?b3REcGRkdXE0aU1WV0hWSnl3VmJIckU0dDBFUTNlWE1YMEh2Sk9ZVDZlY2pI?=
 =?utf-8?B?WklTNUs1Sm1IWmZrM2QzZEhIMVlVbmdscGkrbC93WUFDL2t2c0JHVFNqYnVK?=
 =?utf-8?B?SU1ZN3loRm45d2FZemFlNjh1a3JDVjdIVkJvc1BsVXE5OW1VaGFaWG9tMmE5?=
 =?utf-8?B?UWk3OFBPUXFvWmlLaURQM3QxNDVhL3d4akNVbmx0UWRwbmVtMkNNNGM3ajh5?=
 =?utf-8?B?TXk4NEl5SXF2akJZWlNobEpON2FtVlVkUXk0L0pnQXZZZzRjYW9oa3hpT0kv?=
 =?utf-8?B?WENCVUpsY3JkbkJWV0pNY2ZEYmpqNEFzT1IvRjdvT1p2cUh4ajRYNGVrMTA1?=
 =?utf-8?B?b0pYZFZMekxveGttSUZBWi9FZVM0bWpGakN3N0lmd1NUYkZjbHNQcHo0NHVG?=
 =?utf-8?B?Ny9HbDRZUlN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUlFdVZzeTlRRlQrbWtJeHA1eW96UEsvcVh1OU1xVGlWTHRxcExxNCtnZ09w?=
 =?utf-8?B?K2RwWk1meXVDcnREMWlDcXpPcTI3emNndlBFd0FnQStoZTNhbmZHWXNwOHRj?=
 =?utf-8?B?cHNxcG1qdGVXMExORHFmY3JPbXphNFI4ZGZNemJjVzNQSUd2UmFGd2FseWVu?=
 =?utf-8?B?SGJRUDhQbGRzcGlqRlNGalF2ekp3ekp6WG51MzFpQ1VwbTdkMmxmL05CNE9E?=
 =?utf-8?B?ZVdacmloWkhYZ0ZZUmk3WU1jNExmZXNsQUNocnhDMG1mTlNSKzFYNFYwWUJj?=
 =?utf-8?B?YVBqYmVIQ2NLMnc4dUxZcURqOWxZUTdSbncyRVJ0amx5VlRuTERhVloxcDdh?=
 =?utf-8?B?cy9yZWpJL1UzamRkQS9pdzZGSnlqRDBYbENJUEVkS2hPZ3JkN1laSjFpR2sz?=
 =?utf-8?B?THRXcStNUmdMZ3UwNDArSGQrUWYrSnFtdk0xdG8wYm5GN1hObXFhZmVVLzli?=
 =?utf-8?B?d1RwYU9RTm1WNEcxVi9DMkdhNU1TY1BJeTVldEM5SHZaSGphd3FKck5NMVNr?=
 =?utf-8?B?czdEN0I2NXFMZXhqMWxHMVF6Zis4SkhtREN1anljeWtXcUc4VFJDZTVobFJs?=
 =?utf-8?B?MmdRQ2V6UnNoUVpUSXo0Z0NHL1NQaUJXNGxMcEhncTRMVklXUVV2NmEzZnpY?=
 =?utf-8?B?ejZnbW5MRXJxS1d6N0pBWVRqdlMrZjBHQkEweTFrSXp0RHdCWjJ1MDBKT3ps?=
 =?utf-8?B?Q2t6eGZWc3VCMDFCL2FEMENaNVBJN1BBUnhBRkxNSEN2dlQ5S09zNVNyaFUw?=
 =?utf-8?B?TTVzV0NyeFVIRGw2T2greGRVZWt0YStsZ0NOcmQ1QmRaVVJNeUhoOWR6V1lB?=
 =?utf-8?B?amo3N2lDWTJNZzNoRXhsL1JzYjJiVWNKYnhsTzVROExHSDdXKzJmSVJKVGlz?=
 =?utf-8?B?ZmZRdzI0dVBEVlF4TXZxdlZzK3c4YjExVFgxaDJHdjFHd0lqSG8rbWpucFY3?=
 =?utf-8?B?MzVLK2xCamt0cG9uQmozOENXc1YraVZyZUMyRzdzMllFM0o1Rkk0Y0RwYlI4?=
 =?utf-8?B?OWk1UU01T2kwKzB1eUR1VzJZbDJscndZQWhCU0lQQXdlSncrdW8zN0k3WXo4?=
 =?utf-8?B?NDhDa2pKdUdNdzllQlNaVHFmd0Fsc2NuUk50cU41MHRmeDJJVXJaRGdSUXZ1?=
 =?utf-8?B?OCs4ckpFMnJ4Q0VHUFJQUUNmL00rWncyTzhEUVJobm04ei9IUkJzdGdYUlFM?=
 =?utf-8?B?S21YMXBzS2FlejdRQlVSM0RGZXFkeUUwNjRKT1hRTVE0VlltVjUveTJ1c055?=
 =?utf-8?B?NUhBSUdyOHhrNXFDazV1RzFoY3FjZjdONEc2WWpxcGpYbUU4bzhKSXpMUDVL?=
 =?utf-8?B?VEN6VHpUMmZrSENLMDhkTVZDclJualRCZFZNTFJVN1RUWXUyTi9mZDFGbktC?=
 =?utf-8?B?aGVnTUtrOG5ZWnY0VUwzVkhmNnY1VmNnQ0lEYTVKQU50S0E0MFdPNVZuYWhJ?=
 =?utf-8?B?Rkc0LzliaUxtWTYyQUZ4Tmp0b0R4NkF4TXhDV2Zqd0FTWlo4eFVrdmJIWk9L?=
 =?utf-8?B?NlBlblc4elQzWDZaOHdlS3NnMEtyZjZWREE2RDFJS0VQcG9lVVc5K2s0NzM2?=
 =?utf-8?B?ejUvZkFLM3JqYm5uK1VCcXpyTW5yWmpQQnIzT1V6L1M5M3F1aFowTUtYSmRE?=
 =?utf-8?B?RkZxSXZlRnF5S1UrWlpxMDBFTm1ibmI4SHY0d0dzRjNEcitjVGo3bjYvYzFa?=
 =?utf-8?B?UysxaTdpQnNKc0g5R2hOdHBORzhnakJJUTQrTEs1NXQwVWZ5N0ZMMmpKTVRs?=
 =?utf-8?B?YWJFZkRPL2pBUWM2b0MvcTNta3FHRWxjQkhiZDdHZ1ZQc0lMRWV0ZFI1cGlI?=
 =?utf-8?B?STVWQVJ5bVpkMHdQUWdKWHFyV3lrQjJGVDU3bU4yUGJEVTdvc1VocnhTaGdE?=
 =?utf-8?B?aWFJZ1k4VHdFS3lOL3R5THpHaGJBVU83U1hBRGhpTldLcmFRdkVmWnhhZXg3?=
 =?utf-8?B?ZUZvY003R3hPYlJtem1xK2JJRitLb3pmYU9LWHlIL0tiYm51QkU2Z1k5a05H?=
 =?utf-8?B?NEpxVHY2MEpxMmRkZ2h1d0h4ZEVwYzZmdnU0TWVoUlp2OWRkN3ZyYzZyV0Zh?=
 =?utf-8?B?dTRUYloxYnB1SS83ZVZFcjNWS1J5cXRKWE12b0Q4aER6c09lY1dXVW16aUJ6?=
 =?utf-8?Q?bPYhKrLZ5OMWLaX1i/ZqdrLfV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1f6b3b-3a04-4295-5cdd-08dd5be9bfd8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:29:26.1986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWBTAv+K3EV07ETVb4PTl784zIPqSE/yzlblyL/+ld5+Z3tObD29HYv1PWMTL08Dd2cjfA3hzLn4nXaGh8iT3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10000
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

This patch is used to add SCMI clock control permissions to sandbox for
testing.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/sandbox/include/asm/scmi_test.h       |  2 ++
 drivers/firmware/scmi/sandbox-scmi_agent.c | 56 ++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index 619f8f5098..b30e536a35 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -27,10 +27,12 @@ struct sandbox_scmi_pwd {
  * @id:		Identifier of the clock used in the SCMI protocol
  * @enabled:	Clock state: true if enabled, false if disabled
  * @rate:	Clock rate in Hertz
+ * @perm:	Indicating state/parent/rate permission
  */
 struct sandbox_scmi_clk {
 	bool enabled;
 	ulong rate;
+	u32 perm;
 };
 
 /**
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 19be280ec4..74a87832dc 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -80,9 +80,9 @@ static struct sandbox_scmi_pwd scmi_pwdom[] = {
 };
 
 static struct sandbox_scmi_clk scmi_clk[] = {
-	{ .rate = 333 },
-	{ .rate = 200 },
-	{ .rate = 1000 },
+	{ .rate = 333, .perm = 0xE0000000 },
+	{ .rate = 200, .perm = 0xE0000000 },
+	{ .rate = 1000, .perm = 0xE0000000 },
 };
 
 static struct sandbox_scmi_reset scmi_reset[] = {
@@ -700,6 +700,21 @@ static int sandbox_scmi_pwd_name_get(struct udevice *dev, struct scmi_msg *msg)
 
 /* Clock Protocol */
 
+static int sandbox_scmi_clock_protocol_version(struct udevice *dev,
+					       struct scmi_msg *msg)
+{
+	struct scmi_protocol_version_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_protocol_version_out *)msg->out_msg;
+	out->version = 0x30000;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
 static int sandbox_scmi_clock_protocol_attribs(struct udevice *dev,
 					       struct scmi_msg *msg)
 {
@@ -740,6 +755,9 @@ static int sandbox_scmi_clock_attribs(struct udevice *dev, struct scmi_msg *msg)
 		if (clk_state->enabled)
 			out->attributes = 1;
 
+		/* Restricted clock */
+		out->attributes |= BIT(1);
+
 		ret = snprintf(out->clock_name, sizeof(out->clock_name),
 			       "clk%u", in->clock_id);
 		assert(ret > 0 && ret < sizeof(out->clock_name));
@@ -837,6 +855,34 @@ static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
 	return 0;
 }
 
+static int sandbox_scmi_clock_permissions_get(struct udevice *dev,
+					      struct scmi_msg *msg)
+{
+	struct scmi_clk_get_permissions_in *in = NULL;
+	struct scmi_clk_get_permissions_out *out = NULL;
+	struct sandbox_scmi_clk *clk_state = NULL;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	in = (struct scmi_clk_get_permissions_in *)msg->in_msg;
+	out = (struct scmi_clk_get_permissions_out *)msg->out_msg;
+
+	clk_state = get_scmi_clk_state(in->clock_id);
+	if (!clk_state) {
+		dev_err(dev, "Unexpected clock ID %u\n", in->clock_id);
+
+		out->status = SCMI_NOT_FOUND;
+	} else {
+		out->permissions = clk_state->perm;
+
+		out->status = SCMI_SUCCESS;
+	}
+
+	return 0;
+}
+
 static int sandbox_scmi_rd_attribs(struct udevice *dev, struct scmi_msg *msg)
 {
 	struct scmi_rd_attr_in *in = NULL;
@@ -1193,6 +1239,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_proto_not_supported(msg);
 
 		switch (msg->message_id) {
+		case SCMI_PROTOCOL_VERSION:
+			return sandbox_scmi_clock_protocol_version(dev, msg);
 		case SCMI_PROTOCOL_ATTRIBUTES:
 			return sandbox_scmi_clock_protocol_attribs(dev, msg);
 		case SCMI_CLOCK_ATTRIBUTES:
@@ -1203,6 +1251,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_scmi_clock_rate_get(dev, msg);
 		case SCMI_CLOCK_CONFIG_SET:
 			return sandbox_scmi_clock_gate(dev, msg);
+		case SCMI_CLOCK_GET_PERMISSIONS:
+			return sandbox_scmi_clock_permissions_get(dev, msg);
 		default:
 			break;
 		}

-- 
2.43.0

