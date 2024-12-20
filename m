Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A59CE77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E14F080352;
	Fri, 20 Dec 2024 03:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hMZ9yzaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 633058021D; Fri, 20 Dec 2024 03:55:34 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69CF2803CA
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGf0u2LQ1PcSAsNaJ1FyfC2rob27hKtDlXDkUzmoN+xBblYT48wfkpavLmlW2XlEUpbVCcEGdimTz9hZRlSMDtAaKlgypJRHeJ6PLWZ8AbpWj5at7wPOoUsLID4LqFntlM3sO5S/RLWeBCSxv0mgaeWwSZzfbVkYxrooBNgrzaSCSSg2UAYMA3Sn+73SluJpVfacTc+PN+pmVMMybuMPmlrID0775T/1UEoj8VQQx8b8HyQ4MazU28LD6bgJdnHFuoVEhZDM3kOn+jHUOF+ccKD7OVDNLBPerjDkgfpcES7uD4WvTd2KBJnO+I2ApQDEb6vnFjtuL+Yh77QXqS2Qhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gsKhsohElbbGo6eurhrhnAhb1W66FkKf/flOs8ZIm0=;
 b=v8ElP6v89oirD3lFeuTNfHYKDsHUptSlJ/YXyNivP1/jUtGiiLeKM7KY7YV/pwRPgl5I/9xuUSxgX4awunkIfZxtvB+s6ZcaUgA2WSQEbS0pa1lYM5w1by/GovmxoPJFAMLTH3wz+g50e6KtrF0XrlAqPA69t0UAFMbotfs3KG93itD+mIRYl16QRmrgxVzdlR1rewmQYvowgnm3HsJt785v39M9nuBaSuAnLm58cf9uTTMfXuaa690/kX+wwXhdafDkVJDQLTTDDsfsgBtl4q2GjbLpIvSmsCBA0WdYP7hC1XoxsOciPvSa0AR0n85cb5IZw582lMFYrt//ndm61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gsKhsohElbbGo6eurhrhnAhb1W66FkKf/flOs8ZIm0=;
 b=hMZ9yzaTHS4D9Qcd3apN7Lbfk5Y3wDHJ1/xmB/NdkOpP2ZoSF2mrrq/c5WgVQbhsaVd7oBGWphDQP5mlcRPb6qQOUMOSR9jvhg5gwAA9boHC7YvScRe55/9zC2iE17d4uEUCrfUv7J1/PXBk6WiktNSQq2zFB3B7Wy4x/QsHVwrtZclZubIF+gWVFoO/TVAhxBEuDxuu419tflNOyprgFE4NehrlodceioWNrrubgktseb+iwnQsWJWl1hAInwRp8GkQck/wJMS4YltHv0yowCxXpro+aazbWjE6O5huQbTk6KzNbSomwXWVh51gLb8FNBoZ9Qjl1WWQ2sFUnP1Zwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 02:55:29 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:55:29 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 20 Dec 2024 10:55:04 +0800
Subject: [PATCH v2 06/17] clk: scmi: add the command CLOCK_PARENT_SET
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-imx95-v1-6-ba81dfd8e369@oss.nxp.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=2503;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=l71ScTKWtHtOdfZx9OnBCuYLXxuAQFWJgqyLe8SCfWo=;
 b=vkl7+vr6ZCRgLH1QAzj3XDmSFpFRdEOVLgKlb6FXcg2rjqULDtnYU3Shg4/+brMgaCCCHxed6
 OszRcsofuEeCUVBryxsjImzTRzhjtF6zlYpQF7h7SIJNeKHx0ep8LXk
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: d051ebc6-43e7-4a53-2b1a-08dd20a1c2f8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHFzTEVpSnZ1OUI2T0NGTHdCN0hncW9HcEIzV0VhY2l4MFNxQ211MGV1Sjlq?=
 =?utf-8?B?bHJHa0Z5eCtZMGVnUzRKTUM1VSt4cW9SUG1UYmFWbk1vVDAyd2RONUIvcExH?=
 =?utf-8?B?aGpzeWR2NFRRTVorQ1FPRThXV1p6cVJzdldXK0xTVFdxNENRRCtpTW1LWG9K?=
 =?utf-8?B?SlQxSnJNcGFIdTJtcmpTTXpjNE5xditicmpqS1RUZW4zSFh1U21vaWZKc2ZH?=
 =?utf-8?B?SVZDUjZzM1AvY29RWE5RdTlOWXozc1BZaWM5bjZNcWdkVmRrdjN1eGt6cno3?=
 =?utf-8?B?VHlENDBVZjNOdUhKcVp3cVdFZndWWHRaMlFHeDNaOVR5L09RYWQyY2d3Z1Nr?=
 =?utf-8?B?NHlYZE44MFlKT1d3M2NtZjJFS2dCaEhpRmltV04zcTNiL1dQYzZ2MjB3NjVK?=
 =?utf-8?B?WlJ4akNjS1hhZGp6MDZFSytwR1h6dkhaLzROTndyeXlPaWRzN2xDR1I1eWMz?=
 =?utf-8?B?NkZVcE9MOG5LSlQ3Z3Y1RjJtV3hPaWFFVHlvSWZQbTRsTHVrTFZNUW9QMHZq?=
 =?utf-8?B?Zzdxa1VsVTd0NHRxTnVhckhTRlNINnVMRHp2RmVSY21BaGc3c2VZeE9HZER3?=
 =?utf-8?B?cFVBMW1JUFBtNmJyaUg0Zm5QUWNxcXNVVjZONGRHMkZncWpCWjI2UHJkaFll?=
 =?utf-8?B?REhlbDFzbDFlaUV0U1dRT0FyTmthL2hya2g3SERTdm9YVG4zdU95anhzRDZu?=
 =?utf-8?B?UmE2ZW9OWS9Sa25xNEJFRENyOUZodWowaXhvUTJhdmYrRGcrT0hvMDNVM2V5?=
 =?utf-8?B?SWZMcENlRXUvL0lZaURBQWRVTDgvZHRwZm03aXpObVBxellYVEZYQWxLSmdY?=
 =?utf-8?B?NkhHc3FZTkg1SXMrNmVRTlNkN3Z5ak1DYStZQmR4NlhWVlVBbnZHYURodTdh?=
 =?utf-8?B?YlgyS3Z2REFDU0FucDY5aDZwNWVMc2pNSUJIQVNpOERhTGh1QnFKUFJmU1hG?=
 =?utf-8?B?TlYzREg5RmxMS2ZCU2xwZk1TWTlBaXZ4WTBOZkRtUW9leHVxT0dRdmZ2ckVo?=
 =?utf-8?B?TFVITFRKTU1Rb1QvR28vT1Z4cVEvcmM2eUdmQU9RaXF6U0ZnQTZaV1ZFTTAz?=
 =?utf-8?B?Zk1kQ0RSb2ZXSmFIb0RJd0I2NkFrejNmTWR4a3RHQWFFajR0Z1ZHR0RvRTJ0?=
 =?utf-8?B?YWtBZDBYSnJTZ0tVcThiVlpNdkJvWHFiMFQ0RW1XWFpOOHczM3hzb25aUmVm?=
 =?utf-8?B?TDJMOHNtYkg1cWg4ZVlHMk9IRlhmb0RJRk96TUNmZVJKS2dUZFZSZE40VGVr?=
 =?utf-8?B?cjNRWTBvSkFFMFcySFpSY3U5S3NHZmVTeUphSUNrQVlNbUcxTVdtU3cxWmN2?=
 =?utf-8?B?Z3EwblJTQWlwUFR6aVVoN1plbjkzVStSK3BOcXBKK1Fxck9oelprQXpFNGhx?=
 =?utf-8?B?UE9HS214TktjM3M3MUdKbWN4aTllbllCU3kzaC93SlhDWkUyRHdSUGZMdStx?=
 =?utf-8?B?S2NQbEFzOHhUMWg5MGFXMS9TRG5CNG9MWnBVVitPTlJ0L1d4TEttK0NOdHNm?=
 =?utf-8?B?Qjh6a2pWOTlvbWdScm05RHJEM3VrQjVRRHBQQytNRzlXa2JYRjRIa0JacmVW?=
 =?utf-8?B?TkRGS1NpbGdObjd2bnVjWmhHN2pzcGU0Y1FyejU5N1hwQlIxRFIwYVJxb0Z4?=
 =?utf-8?B?aktKdnZLWWNxRS91NlZLMFhGRTNwZS9wTzYwNFRYMzdZZUYzUzVuVzM5cW04?=
 =?utf-8?B?NTRmTm15bEdZaGFiOFQ1S2VsSzdhUGxJOVoxekRpT1E1VTdmQnBJeWRLSndh?=
 =?utf-8?B?Sk5tQlVCeWMrUlFyY2xhd2xZenZMMGpDWUEvUisvM3R4djV1NjcwYjZOWjJO?=
 =?utf-8?B?V2VWbmZMak9Sakl1emMxRUxWMFRuQU5DRHlyUG1DNHhueGI4WTI2dllLWENS?=
 =?utf-8?B?MDhPUmp0d09DeFZMVnBWMXR1V1VKVU9pM0E5VFlsbWdGOFBSVjMvUHZSenpX?=
 =?utf-8?Q?barsTF8AEycfX0x40/dqA5nXFhxZz7ZY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkF4SHpVZDRRdzM3QkxPb0gycldyK2xWdW90UWRmRkNzL2lHcXIxUTBRL2dG?=
 =?utf-8?B?R3cwNDJMTmdZb0M2bzI5TUxpQmFZdC85eGxvODUvbFk0WmVTQS9rWm9xMEc4?=
 =?utf-8?B?L1ZLNnR0WU1QaE1JdzNTZ1FhaHJ5U2V6bEplZ3NYbGdYSGpqeXZEelBEMita?=
 =?utf-8?B?UTZrK2NHVE1iaWV0Q2RhcmtrOVZPNHhPZm1nbk5qTFVPZEozbzZPSkR0aGRr?=
 =?utf-8?B?ampzTlRhc1h1WHNNdWpGK0xVVjhuL0JuMldBenlMdmg3ZXc4K0s5ajR0UEFy?=
 =?utf-8?B?alRuNUN2d2JiSVkvL0xVdkZ3S0JUcnlCeUFDcVJmOVk2d1pPdUx3MllDUExT?=
 =?utf-8?B?a2ZLWWpwcXlSeWRpQ080a2VZN1RWUlAydTNRLytadHg2SWZ0VFFQMlBtVWdM?=
 =?utf-8?B?cmUzdWJOSnVPTVJzZlpGcTRSMS9vSitlSXNuU0ZqdW14THBiVDJCekF4Tmw1?=
 =?utf-8?B?WktRMkh4RFpCUmJDbzN0eUNRYjVnejVhSFVqUzBaZjRFNXltVUxsUHZScWVI?=
 =?utf-8?B?ZEVMa3JySHdycVdWUkVJT2s3UTMwMFJUSXIweVhHaXBXbmhRMk5SSUlUSlFS?=
 =?utf-8?B?TDNjdVZ2RkRLazNVM3ZCNmVINy9ENXlkUUhUQzhyUEF3L3BxZzUrTXRUWGdz?=
 =?utf-8?B?K1BYcXZHS2FCWVhDdGw5OHpVdnJsbVlCUHdteDZiYUxLNjR0dHJ5RTdHeGlu?=
 =?utf-8?B?Q3V5cEUvMVl6aWNnMUtLSVJKaG90bjFQbUpTalVLV2VxRHFJRHdLWnAwZzBz?=
 =?utf-8?B?UzVSU3VwRjNTK3o1akw2SkVmYjA4VTM1cXlrbEQrOXVHSGNJRWdCc3ZpQlJI?=
 =?utf-8?B?cjJwMk8xempRTGQ1Z1hRRkE0TnhFTHl2MGJtTTBxQzNsVXVmdDNseFpkeHRk?=
 =?utf-8?B?RGNENXdRV3p6b1pSa1B4WDR5bUVqNGlQeDBmRFNZTnV0U2RHdUNpMDNQNXd6?=
 =?utf-8?B?NEpqZy85cXBFSExKa3hQejJqeWI0eTdEbjBVWVRUNCtTc2J3NU15WkNUcnAv?=
 =?utf-8?B?NVYrdXBjSm1GMnh0QStxYXFRa1l3NCtORHNaWUhFcXhzRnFjTlR0ZHUreGhT?=
 =?utf-8?B?NW5YNHF1aEJ0anF4OEw5Ujl3bU9nbnNSd3piSFR5SkZJemp1eDBONmpoWUlH?=
 =?utf-8?B?TWVPWkt2QmFUblNKL04rcXZRdTNzVkJTcWhlait2M0NzUXFxNVh2QlJ2cm92?=
 =?utf-8?B?VWFwVzZNQWJITVJidUVleWhXeFBoUThKZXVJaEpyU3hzaGpSM0Y3YmJHWmx6?=
 =?utf-8?B?STZaeW5jL0tJTXRBUkxXdHdKajhMb0VjMVBNVjVRbFVoRHowOHNPTXowTDVM?=
 =?utf-8?B?R1FWMVBkdWpFWXg5VkU4czhZMStYREdoSEtDNExzUVQ3aDRocUN2ZGNtRlBN?=
 =?utf-8?B?MFJIVllUNW94R2Z6elJOdzNjOS9CQlc3YnBiSzhEbTZkYWRuMUpQc1lOUkIx?=
 =?utf-8?B?b2hWOTVjNFFpeVE5NG1HSUphMWZKZkxtRzRUUUVvOThLTTBHSmMwRjdPR1FG?=
 =?utf-8?B?cmIrVEdpcVF4M1graXgwbzBlaFNOQzIwMmpKakdVMzlhUEg1V3dxdmNBbkVK?=
 =?utf-8?B?YjkwSU0zWmdTS3I2Q2c0L1Y0UXRaQzNZcEdOTzJ5Qm5uajJtcW5NNVd0OWgw?=
 =?utf-8?B?QWdET1dqOUlLbUxGVUo3R2pRTGI3NzNCS2VZSkFpU3d0dVRoa3RLVGx4dTIy?=
 =?utf-8?B?bmZzWmFKaytsbVRGYUlmN1hGdUg0RnRtZngxLy81b0pWamxxeEQyUzgyOWtx?=
 =?utf-8?B?NTRVZG4yMXRuZlJneXFPOCs1ZklSVTJYRldrRmhGS3puSjBEQldSQlpXTnl1?=
 =?utf-8?B?TkJQbS90UjlXVmtMM2psQVg3S2NpZHdMQko2ZWRLYVd4YTRQSGRCL05tWXlW?=
 =?utf-8?B?V0ZiWWRwZGZSejZtNDZtV2k0eWFKQ3hPb2pqcFU2dlhPaHJtcnFtOE04Y1lp?=
 =?utf-8?B?ZUxud2g5cG8rL2JlMUxUdUwyK3dHOWw5RUpWMTViYkU2UG5NVTduZ21uS3pq?=
 =?utf-8?B?cVBLOG1PTHF3bEtzWjVvN21FaExRZ0FPYjI5TUVnTWQ1UWY5OUFmSXdMZ1RW?=
 =?utf-8?B?dTZPYXhVTFRCYXJzZXdEK3RJRG1BNDJnbWgvZjdBd1d5Zm9ZaW8zczcvSDBt?=
 =?utf-8?Q?nViUvenXD6hmM1015iJEUnIqq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d051ebc6-43e7-4a53-2b1a-08dd20a1c2f8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:55:29.0337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hrol8Q5wURCP+RUSwXYDvG5YAPi2db9qu+Ms4Y9XK547J+yX3Wt6FsYJlHmz8AsezJQaXkvYTBtDBU5uXjIs7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981
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

This patch adds the command CLOCK_PARENT_SET that can be used to set the
parent of a clock. ARM SCMI Version 3.2 supports to change the parent of
a clock device.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/clk/clk_scmi.c   | 20 ++++++++++++++++++++
 include/scmi_protocols.h | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index e42d2032d45e011b751c19b395b6f99d5c54e78e..84333cdd0ccfe566c269f776f39725c69883c25c 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -178,11 +178,31 @@ static int scmi_clk_probe(struct udevice *dev)
 	return 0;
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct scmi_clk_parent_set_in in = {
+		.clock_id = clk->id,
+		.parent_clk = parent->id,
+	};
+	struct scmi_clk_parent_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_PARENT_SET,
+					  in, out);
+	int ret;
+
+	ret = devm_scmi_process_msg(clk->dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	return scmi_to_linux_errno(out.status);
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
 	.get_rate = scmi_clk_get_rate,
 	.set_rate = scmi_clk_set_rate,
+	.set_parent = scmi_clk_set_parent,
 };
 
 U_BOOT_DRIVER(scmi_clock) = {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 08c86a642844570424dddbfcf9670d1e6757d8d1..d529f8e2697472e60d0cb9c275f34ef0ecaed3ca 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -737,6 +737,7 @@ enum scmi_clock_message_id {
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
+	SCMI_CLOCK_PARENT_SET = 0xD
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -839,6 +840,24 @@ struct scmi_clk_rate_set_out {
 	s32 status;
 };
 
+/**
+ * struct scmi_clk_parent_state_in - Message payload for CLOCK_PARENT_SET command
+ * @clock_id:		SCMI clock ID
+ * @parent_clk:		SCMI clock ID
+ */
+struct scmi_clk_parent_set_in {
+	u32 clock_id;
+	u32 parent_clk;
+};
+
+/**
+ * struct scmi_clk_parent_set_out - Response payload for CLOCK_PARENT_SET command
+ * @status:	SCMI command status
+ */
+struct scmi_clk_parent_set_out {
+	s32 status;
+};
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.34.1

