Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079D4D3B7E2
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 02:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C4983C29;
	Tue,  9 Dec 2025 03:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xTvR46q/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3D9783C28; Tue,  9 Dec 2025 03:48:32 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3EE083C4B
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 03:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxtEh+7sh9xvpE81SXZ9la62fRscW6VtO0Vy6sFRpeJ50k4veEmDYENUrXn4DKJJywyWRX+JE8kjHE9aCYLhq0/ZPzsTgOoIf3+U/aLZUxBib2g9GhGFbDKDHxt6o5AkoCuezoEaD/EZ2pZbJVvyJTquo25Gi3zEs36kD0ZScpMKZWlLLVeySNwEu//Q24tKBOxIVYJuDxhaKaiTZXeaVVGFYMgLwT0PLUBC1PES71SFgdCFPlyO4sjHX4763XZ6XMGq9hwPrMz+KqpevhALkHxRQUTGzQYRWL4Nwhgyw5NGkTqBIuB8WZ+ncnZ2EVIFoZQwnSvnoqKTQLrGELbEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaM7uBHDip57qTjt2fxcGSVVoHq7BvQR3Q6/m0kpEGM=;
 b=OUCmbaz70Kp1v1YlhG3ePd/XI09I4zAZpC9s4+yVDUmadcqVzpyOGxCfJBZYzjdR8rR5v0WF+onof2gcNl+eTzpGmJmXyH4Ch600jzqHxCfJm0V4HgKkEa382Ib8a+cqrVItVAyIsgmaDfX9n8cI9V7xrPnzi+oOlQD5qsuFYHKs7dbOHu8zYs1YWRl9ARA+R6oXd7KPWZzcySckiUnTsXDZrFPR/fWYHKxeJvrVpO3rDsDt/RfaTsfZHGt5tFyxCBEOo75McRU1jK1IoUi9s8Wd+3f2BP31uba82RHfXA9/f0gU+wq1N5K1rsOhgAghhMxfojGRyRSvovXjxLDjNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaM7uBHDip57qTjt2fxcGSVVoHq7BvQR3Q6/m0kpEGM=;
 b=xTvR46q/tQ2NU3KkInejrh3uR7iZMU1zGuWGtTK+IsEonB7T1J/qaP9Sij+Fsri1iLQN9D0ruUvPh3HWA9hnh36BIj9GFJgy7kFDpKOEv4KTrSwFa9GQE5lDx+thsmqPaHFW5eYpkTCOiKctGypJopQET0qoq3+UDZ05tIJ4lUYSAo+zNOrjJJ5BOcgfG5ICTe8Qh0Yl/gyGrhCTe+hxA8exyb+8ITy/i3M+Cn5Zl5mYtKZ+58zqXfakTNtmM27l2g9PorLONQpmeAaoSgKylT8MiPh5HKV5sr9Esv7jZGpYXCm+5VQv2KPhDe/utT8jH0XwP1Cste90e9/FytSHpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11897.eurprd04.prod.outlook.com (2603:10a6:10:61d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Tue, 9 Dec
 2025 02:48:29 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 02:48:28 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 09 Dec 2025 10:47:12 +0800
Subject: [PATCH v2 5/5] imx8ulp_evk: Enable USB controller at 0x29920000 in
 host mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-imx8ulp-v1-5-97e76ed1d967@nxp.com>
References: <20251209-imx8ulp-v1-0-97e76ed1d967@nxp.com>
In-Reply-To: <20251209-imx8ulp-v1-0-97e76ed1d967@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>, Marek Vasut <marek.vasut@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Stefano Babic <sbabic@nabladev.com>, Lukasz Majewski <lukma@denx.de>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11897:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd11f66-83c9-42ea-d978-08de36cd6eb9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0hyNmxHSy9UVDdMMWpwYU02RzJSYk5NcGdnR01aVlVzempYWlRzWXc2R05K?=
 =?utf-8?B?Z1JhZHRqTEx3TlZVeGlLTzRsbTRLeEllTWpuN2lXbnlGR2FBaDVhbS9YQ2N3?=
 =?utf-8?B?MVlkN1p3cFhhQUlDekp4dnc3WlM2cENlVkZMRW9lYTZ0RHBBSWl5eDgvT3I3?=
 =?utf-8?B?bW1YOGJYUVo1MXpodjB3SEQ2TGs2TFVOSzVLQUpXVFIxbUJ2SGlUS2lJMUh1?=
 =?utf-8?B?M0czMUVSNE9wRENmbDF1Z1I0RDZ6N0JlaEpuWUJlbEFaRDBicTBvZ2oxektG?=
 =?utf-8?B?M3RyVHlDaURkVzl5QjY0TG1lYWh6T0FQaC8rUnViUlozdi9Nd1hLRWZ1QVRJ?=
 =?utf-8?B?amxRUFJRMjBJWUxWN01RZENneUZ2QnpVc3BwY3AwczBPTkcwOXdGVkxlT2U0?=
 =?utf-8?B?cWZ5d1p3RDFsR0dMVnMybEJJWHZlb2k4dzZKQjRFOFhiUnBKZHhsQVZybk1z?=
 =?utf-8?B?NHhJUEJnQW43M01qU3BraGd0N1BITnV1czdha1RXZVpWTDc2T2FuelhvOTBP?=
 =?utf-8?B?U2pVUXkyQ280WGFYL1llV1l1eTZidURGanRiQUEzeTJHNW9GaWdJQmVhTWIr?=
 =?utf-8?B?cjBzNFJ5NTRiOEF5WXJKcnEwU0pqMWNhSzRJaGUrNWFSTVZ0My9wdHZNa3dD?=
 =?utf-8?B?azBnTFgwcXk4Qm1tRjk2alNWeW9wVVIySVNsVCsxaVJtc1VCSWpyL0tYVVY5?=
 =?utf-8?B?S3drSHkwNDI5Y1pweDArTnlXdDJVN2VLNkZjWTRUNEkwaVNGeWlaSDJXYVFG?=
 =?utf-8?B?UW5uQ2h2UlpuTFlpdkljdGtTMGU2cVYrYjVaa0FDTjhaZlE1Tlp5djRoQjVS?=
 =?utf-8?B?bzR3LytUNjBXalUvSEU0Z0dzWVBETlZUcGtlNjJ4WTN1NjBEN3Fqd2RiaHpi?=
 =?utf-8?B?WkEwbzBETmhWUktqSFROU1o1d29WSlFjeGpkWDNBRlMzOStTUGREb2xGei8x?=
 =?utf-8?B?Wm5QS3hWdlcwQjhhRG10d2xoajVlNVN6dDQ2a0docU9aaHQ5QmhQZGV2ay9s?=
 =?utf-8?B?QkNKTTVUaW1idXVlZ3lMWnFYK0ZWaWZEWHM0c1RHNmcyR0VlSXBYTVlVVVo1?=
 =?utf-8?B?NTFtN2hKNFlrSUgrR2h2U1BlSnUxVlhzbzQwT3lmRDR0YTJLRGZEQXhXamNk?=
 =?utf-8?B?T2xWN2FIK3BneUxlVlgyb0lhK0VoR2t5cEhkS3JMUk9ZVHlqRWMwYUl4RGdN?=
 =?utf-8?B?RlJ4aHJHamxvZVlNS3M1dlFnbmQ2bWJZNGFOUUNqNkJuZ3RhaktpUWlvckdh?=
 =?utf-8?B?d0NWLzJwd0gvVXMrckJ2M29SZEJMclFaZWtvNVo3L2hCemNQQnBUQ1NYYit5?=
 =?utf-8?B?V3RtZUhkREE1NEVodzVZN1ExbVhrZDNnaEFoSllSNzB0eFpBUktIekhhZEVr?=
 =?utf-8?B?OFowSVg2SzdRRmNpTDYwZkNBcnZXSjByK01WS1A5NEp3aWVaVnRWTUNVODBz?=
 =?utf-8?B?amU3Wmg3eEw4cFhqb2FvQXozcXNpanoxL1VOQUtlVG01SXpNRnJSeDZuT1VH?=
 =?utf-8?B?UFJ5eW05VHFNT1FoWEduRGs1REdoUDREN3hwdVBTTCtqTm9FaXhiR2R2WG4y?=
 =?utf-8?B?cnV3MU9YcjYwa0YwNkVudGJKOWNkeGEwbmN5SHNwTzBqRDZXVlZWSkxuaW5G?=
 =?utf-8?B?d29PTkNYckppalhuRzM4TkQxUDFSbjdTcXYyRFVJOUJ5MmIzbEV0dFc1UFAv?=
 =?utf-8?B?ZUJiWUN4bGo5b0Z5dWNDTEU1NmJEMUxFd1hOejg4K2J1dFRaNVFlVmhQaHl2?=
 =?utf-8?B?Tm16U1lSelhXaXhpRTZlL3hkWkRGVFUyVzF5MGFYNU1zMllOVnpLbzMwYlRY?=
 =?utf-8?B?bzJ6c1BpQy9PTXdlbWtXN1JwemtPaWhBQUwxMExiV3JVaDdmNmVpV0xkZkov?=
 =?utf-8?B?VDJyclVtV0hVcktYUnVsdFhVRjVVYWErT3lHTitTUnJWZUZGdVZvSHdnaDhs?=
 =?utf-8?B?QSswQjVhSi9vWnowdjVMWFhUNSt3SHRyOXBEL3JQa1BtVHdyUTJ1WDhMc2Jq?=
 =?utf-8?B?bmhadUJQa05QU1hWUjMxSUZTZkVNcmNrcjBNRk5jYVBRK1MxbDByVzZ0YWRS?=
 =?utf-8?Q?bundtK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDQ5V2ZtSWtMQlR2ejhxa0dybkZxa3p1YUs2cmdTOGNUWFhBZXhFSGdaSEhL?=
 =?utf-8?B?VzBOVmRDcm1ickFwdi9SNGZVb2s0dnR6Wmlmc3IvV3hlaXkrRFkxQzZOQVF1?=
 =?utf-8?B?V0N1c3FWQWNYQWZ0SDdubHNqWnpST1NtNnF6eDhUTXVUUDlUdEVQZm51czM4?=
 =?utf-8?B?WWlSOEtubVpDYk8wbFBHR3BBMFBmT09oWkk5WndhZ1kxb2xjeklPbG1PblNk?=
 =?utf-8?B?TzlqRWhKUWwyMjRtT2VtQ2pMQm8yYnFCWk01YU1sdm9ma3JpMVY0ZmFPZWRo?=
 =?utf-8?B?YittMjdNQjVWOWc3Q0pCS2I4WkM4cFBsN3RQN2Z4azJVWFBmZUFZYURhZVA4?=
 =?utf-8?B?eFJPc3hrNEhNblFEbG5mNlFveVRqTlJmVmlZcUxLN244K0NDOXBNcCtxV3ZX?=
 =?utf-8?B?M2dKZisyMVZDUFVMK1RQOUFqdXFDRW1lREdxeUVzSjNNWmpCK1pSK2NFL2RL?=
 =?utf-8?B?TmFPaVVEVHBzOTMyRHNYa3NhTGE5N2hiWEZJLzFMbzI2YWc4Y1I5dkFkUDJU?=
 =?utf-8?B?UDEyRmpjUHFyRGJJc3J5S0hhTDh0dlBDL0tTNEJnL29UMjU5bmk0ZTFDWUNV?=
 =?utf-8?B?MW5mQlYvZWN2YjhBQ05HRzZrNHpaTjAveFRxVDBpajFBL3YzcERFZWtkVE1n?=
 =?utf-8?B?ZHIrSFRTRnBMbU5aV0Qyb1NBdlQ0OFVvc21aSXgvNUM2d3g4eUFiVnJDUjZr?=
 =?utf-8?B?emUrVlp6cmlxbmRUM0RDL0tnOG45S1ZjekY4dUFQL0V6cVovdnpWYlA1Wkgw?=
 =?utf-8?B?TUY3S21COG5mUWFkamczSHpmYU5ScTNHcHUzMXl2Nld3OXJZYVpBbE9iN2dJ?=
 =?utf-8?B?RTd0dDJGY3dlR09wQmR6dkhHMHNGQ0JNY3lTRGJoOGpVaVB1V0RGbnJPNU1O?=
 =?utf-8?B?TVRHT0RyTjdNRHZ0VXZFU04zeXY2QW1vcUlSWEEyNjhoS3craHZ6R00vZUg4?=
 =?utf-8?B?ZzBIWUZoaWNYbjZTTGkvcGdVTU9qSWgyM3gwcTlEVjEwRlNwcnh3RHVzMWUz?=
 =?utf-8?B?bW5nRklTd29yOFdNQVhGRzdaQmc5NWFFQzZiWlEyMXpSQllnQStZU3cwL0tM?=
 =?utf-8?B?SFRNWERJalhNTHhFYndMV05DMjV6Z0ZtWDdZRU00SE4wcHUyRjN4V0VWRmJm?=
 =?utf-8?B?NXExWDhtaklNWkZiTFZvUW5DT1BIR01ld2l1aUZraFRiUFFub2JBYzVDUVFk?=
 =?utf-8?B?Q1d1NzRSc1VvSjd5Q0pvYmZ5SG9FNjRPaTE0bzY3ejJTNS92Sm9vZ01pQmpW?=
 =?utf-8?B?OFVMMVF5WUJnZHdobFpyZytiRVhLTmNCa3RjVW1ZcGVkRDRlc0hod3lpcWtY?=
 =?utf-8?B?T2I1UEpCM0ptQUpXUzl1UWdLT3N4SFRNdHc2MDVEKzA2VHlmbUg1Q3dOajI4?=
 =?utf-8?B?WDNCa3FFV1Rlam1UV3VGai9WOHhweEdzNW1FOXliL1VJUlZLMzlsNDV2Q09p?=
 =?utf-8?B?STlwVkNuYlFkaExTaXBsUWs4OGd6Q1FIeTkyWHVYMmlBRlhGeURSaStGaW1n?=
 =?utf-8?B?bk5GWWVBcGprbUFCSGJGdnFxNDVuMDhWcFRrWXQzVEJ5K1N1TGtTZXVBNUhL?=
 =?utf-8?B?c2tRVm1WY2I2Vm10SUxVVDNuQ3Y5akxLcGxrdEdIcGx1RnBwb1pFVjlrbk52?=
 =?utf-8?B?V3crTEloSFdRdmEvcVY1N0ZtZExZQlRZVTBvV2s1V01WL0pMdzJQL2NoQ0xr?=
 =?utf-8?B?MzFKb0FrM0hReWFEcEpmTWZYZklLNlRHNHJyb253eGhLaURHUmFBaWdQb2xR?=
 =?utf-8?B?YTFwRnBtUDJ1TXFWajBvaVc4V1ZhcGNhclBCUTJ6K09wZlgvVFBaVVgrT0Na?=
 =?utf-8?B?dlFsN0tUcGMxNlJNR3pvbm1NS3pObnNTWURPVWN6V0EzeGZVNzgzTGVXVUtE?=
 =?utf-8?B?TEk1K3B3NVRRVEtvK0tndUZvc0VxbWdWb3pzR3hDSFR0WnBQVlc3QTNNb3Ju?=
 =?utf-8?B?N2ZFeXZHQ3VodjIwS0FJRUtjWFpLU0R5Q2EveDArLyszWHZCeVJ1bm5NODBQ?=
 =?utf-8?B?NjJaWDZRbnNnL1E2Y0VaVHg1UkxNRkxxSG1SZmozRDZqV2d6UnF4RmJoaXN2?=
 =?utf-8?B?SjM4M2tMZW02czNHcHBIY2FaK2pDbjAwaXVlL2VmazBXNzlSYXpPeXV4L3lu?=
 =?utf-8?Q?avnKdjr+nHlXTOOalLyiYOd4r?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd11f66-83c9-42ea-d978-08de36cd6eb9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 02:48:28.8449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XS0lrbJzndmGKnnQO9I2QVgWpnCPct/hZzIusDkKK2UOaaIyqnh1/IVcYtVbuvduEZhUHnpV2rQGC6E3R6Ngyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11897
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

From: Alice Guo <alice.guo@nxp.com>

Update the i.MX8ULP EVK device tree files and defconfig to enable the
second USB controller (base address 0x29920000) on i.MX8ULP EVK in host
mode.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi | 4 ++++
 configs/imx8ulp_evk_defconfig        | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
index 860994129ae..e35653edc29 100644
--- a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
@@ -34,6 +34,10 @@
 	bootph-pre-ram;
 };
 
+&usbotg2 {
+	compatible = "fsl,imx8ulp-usb", "fsl,imx7ulp-usb", "fsl,imx27-usb";
+};
+
 &iomuxc1 {
 	bootph-all;
 };
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index ff6cd8e6c98..5fd73ce4ae9 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -54,6 +54,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_READ=y
+CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
@@ -92,4 +93,6 @@ CONFIG_FSL_LPUART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_NXP_FSPI=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
 CONFIG_ULP_WATCHDOG=y

-- 
2.43.0

