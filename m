Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766C3C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2325D825A6;
	Mon, 28 Apr 2025 12:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="b0huYNNq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 752F582824; Mon, 28 Apr 2025 12:38:46 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4933C82786
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/A4muSlRVaNnPGxhUM+XyoAc3MfOUHsrVeYhBrk2RqaZDa4JyYhu1x7JorbtjvyvpsutPRtTvEpk6e40gOeYbopPgK5Q120Pps5NTELivvGFbsO5V6eWI19cvsyPHzIz/037DwrasSXr4Eqy2MelOiTIJufDTZwxVjQKEouyWHEfn26W3KxwgFDRhn9ordUWYblv5ErSVAXmsdZ4nfCT2EVX/mHueLn4Mz0v3A7bwNHUtWgnrADaPnpku8rltFafEyyN8HBFhwdbyJ19Q0NYGqLmVGlVtPT+ipEZtkAsjTcDY9BjIpJfY2S07Ojayvg4wA+keSPDDmv3qAvUAAvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnrUkUI9LmM9vPCUaVQJOuF5/781xPCWXFDWZ8D00CY=;
 b=kQikrGXqYXsy8B0X9xMEeHIGniFwmmES2cX6CSXRv5ZQsnANQ31OZHvdXyd0d3fZqYFAwUB257f97I9+jhUYaJdnRk4CwHXOC2cjlrFPUYWznbaHf+NiJiqKP3zzlnsGSCV0UpWbrUswvt/AS6n5Bf5LWDDVAwo56vUahJxBHRXXn8oXt0SKPG0E1CWFTAOafTF/z09Ra8SAITLhsiqhR7iLyM24RJMBFBF7UUYBobin0tV8Y1z0+p6jWM1dYDMfIuSJnB8XL1w/uazuCpOr2D23q75qNlyKfFWDWNNwHbPMW+ZRPM3ebiqeqFRhmqGw9O82m8Vt19PGaVjyHW6uMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnrUkUI9LmM9vPCUaVQJOuF5/781xPCWXFDWZ8D00CY=;
 b=b0huYNNqG+crEkHlcmbdzIL+OpH38fR59nlq2rqqVfGObju0A3Gn1Ysd7yuSQ7KfwmUoxsWKdtsZm/YfR5O+f6L2ke1hQtKmssXbXzSAIqlrx6NK8mQvUAQU3y/eClOy0jp37R2r+OGT43t7z6Qo/ckUngs8D3/15OUL5YqEmL78DIF65crdleM47OGVuM3qNbSY25iAOD8kaPpsq+3rOeBpXLsNjbi3GNW/TJ7e1pygKkjdwwSLz3viEDGequXS1HyAAv625Csd/JWSQj1gn7cLwNFeBSur+3VVN4cLEpp5xr+Q0zy/wNTQbtPsU3srEMRrI1h/4vx4fqbK63XFQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:38:39 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:38:39 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:27 +0800
Subject: [PATCH v11 04/21] firmware: scmi_agent: add SCMI pin control
 protocol support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-4-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 6442e06f-63a3-4aa0-2ddf-08dd8640d67c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWUxTmRmVzJ3Wk5BaGFLNUoxMXZyNlplZTlsUDRVajY5dFFicCtzdWxxaTRU?=
 =?utf-8?B?Njlld21iQUlqTG9CSGNQYms1cCtrbW9hV2lBS2JaQXJLQ0NpdExaVmZTa0FN?=
 =?utf-8?B?TCtGRW05UXZmbXJVSC9IdCtTdndwdFBXM1F1VkVjOXA2bHNNL202ekhrTksz?=
 =?utf-8?B?QXZxTW5qOEFnaE5IT1NiRGNOMXBncENjdTZaZUxXMWVGWUlhU0NzbFhrQXdx?=
 =?utf-8?B?bStCa2Y5VHU0YlhYNjN3aEVNekdHME9UQ3lZalNlOWVJUmhick80VG5nSHBO?=
 =?utf-8?B?ejhNVlhvZ2JGa3NqUGtWN0hwMW1uaWczR2laanRwNFF6RU1WZHZqdlFYN2F5?=
 =?utf-8?B?azlTUURrMjdNVDdFcHo1a1RxRXdDSWdRZG5IRk9ueVdDaEJGbFpGa0lIM1ll?=
 =?utf-8?B?dkZ3dXNQbk1xTFRTbEFYMHRRSSs2Q0gzb2U4aUF0d1pscjhHbFNkU3cwelJv?=
 =?utf-8?B?NHVIWmtmc0crQ1lXbEdPQituZWtpSmtKaHR0eElqenNBdjgxVElaVXdUQXNs?=
 =?utf-8?B?Nzh3aXlhalZSUmNXdHhBNjFHTFU5ZEMrTUtlYXdYK012aVR0ZitnSklVODFG?=
 =?utf-8?B?TjRweGlzZkdjclhQNmNjOXBFckZ1ZGJLWnZFbUtydjc5eEVlYTYxOVZsZ253?=
 =?utf-8?B?bW5HUTFIQWlBRXVNK3dqYmpLeENXVjBYQVhkMytuYk9VK0o1ejZGems4RHlx?=
 =?utf-8?B?aXUxZ2poT2c3QWQ5aGpBT1pvalEwTXlyYzJuM3RnTHAxamZrekNBRHRDVnlx?=
 =?utf-8?B?bW5HU2M2K0lramhsUTMwVDJZMnhlaGxzbEhTdVFEKzZJVG82dElxK2EzZy85?=
 =?utf-8?B?QmtpR3p2L1BwZVJPMzZKRVc3V3RVaXV6ZFhpVjJZcVcwU0NtMWV4QkN1SCtr?=
 =?utf-8?B?bWdrMXZVNVd4MVo5djVsUTVJa2czMGs4TXMwNVIxcFRGK3J6VmIwUlA2Smwr?=
 =?utf-8?B?dU13WGNrUWFncDdwSzV2SmNUYXltd1FCQ1BrNUJkamtPNXZOc1VmdFBMVTR3?=
 =?utf-8?B?K2gwNjVkZGRJQkVMUXpQUHNvTkNJMU56ZFNrSXZKKzRvSldNM2xNaWJVMTVs?=
 =?utf-8?B?VDZtRDBOS1d6eUhTc0JObzNxM3pMYUVCeFNJbDFoRi92MXRWelVkb3BNTXkz?=
 =?utf-8?B?NDUyeWVic3VWYW9YYzRhemxWSXBBcTlxSnpkK3ZlelRESDNwUGhkT2hCZENo?=
 =?utf-8?B?Y1dRN0pPV1I1NWNDcXpWZm43MmZORGR2aFN0enRLLzNVSDZ3OTBMUWNPVVJK?=
 =?utf-8?B?T3VHdTFJQTBjd0VxWEVlRHgrSzJxbVpSeFY3NUJKT2JSa1ZPb1dYTlp3OUU0?=
 =?utf-8?B?WEdFNEluenNwWWpLb3R5ZnpxRHZzdU5wa3pKOW1WU1pOTGtCanZJKzFVeStB?=
 =?utf-8?B?TmliYjNIdGNISThpYktIcDFvYnFTMTh4M3FQSm5wMHZUTTJRV2NVekU1Sk0w?=
 =?utf-8?B?UzRHQ3hVS0Z0YWVlTkRlYXVYZ3N5UVhVdXg1NXdTYndFUkJ6RTVEVU96Wjli?=
 =?utf-8?B?Z0s3c1I2WWtoZEVjUG9YTnZ2cHVtbzZhL3NRQzVpUVlrSmpVNFE2VTBKV3pS?=
 =?utf-8?B?MktJQWRkU28yUm4xeG1kQ3A3SkxKUG1WeThadFg5M0QyZzRmaDZ6YVZsTEV0?=
 =?utf-8?B?R1p4NjNEYlpWYUVJTmxhU0ZTUU5MY0NwOEdiN2YrZVBXVjJLWkpld3dLaVIv?=
 =?utf-8?B?THFuc0NmWjdJNTlTWWtlUm90Q0haSTdUUUZTZHB4VUltUG1mYmpFL2hoZHZR?=
 =?utf-8?B?M0M1U1pOVGYvbFNySmp2d2ZVZnh3WG1KbUpFbWwvakN6T2FCNTVaUTBwL3VM?=
 =?utf-8?B?TXVodFdoNHEwRTgxMXoxclBsSHpNU3VjZ1pPU0FQcmt5SEI4dlpZcEFlS3RC?=
 =?utf-8?B?OEF0dVRwWVNhQmd2SWZrMTZyVHFvdG4yOXIvOHNFQ1Y4bjFTQ2ZUNU9od3lH?=
 =?utf-8?B?cnAwVHRKUXd3Qm1vNlFhVkpSb0JYeHM2NGJOQXdtbHFWWE9hbEZNcjJOK3Yz?=
 =?utf-8?B?bmZ3dFFTQ2NnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZndmSnM5UDROaUpLRWQxVlRCMnM3eTNnenhZejdld3hkcHB0RFk4bmhUeW11?=
 =?utf-8?B?QnNScDNTTUNQN013QmFsZEJKR21BUHpIQm8zWGNNeFk2WlluRHprejI2alRM?=
 =?utf-8?B?Mjgxd1M0N1E2RFV1Tkp4dFV2QXpsUkQzNnBEV2NOdG5iZkczMVZKM0Z6T21Q?=
 =?utf-8?B?eXQvNVZET2xtK1c1cXB2NFAwaU55b3VsOU1EU3FPdFBxM01WWDIrRWNRSjhK?=
 =?utf-8?B?d2d1VXQ1dUhUenRuVi9odWprSGtqajJLaURKZ3Z0TWRhTkRPcHFCdnJVT2tt?=
 =?utf-8?B?YWZsdk5RdWFJT211UXd6T3N5SnpKNnBoMmRrS1JtVWJ5N2UwYUhyblVJcWx5?=
 =?utf-8?B?RWxUNjdhTE5INnVNaHYrdkhxcC85L1BSUTJPM2FMZGYrbWxJdW82TXRBcks5?=
 =?utf-8?B?OURiMG5ZKzNDem5sWDBzc2JwSEtMcG5BQjZCdzNqZ25HdnRPd3RKUUxjMG8y?=
 =?utf-8?B?ZFh5M1dlem1iMXA2d1RrKysyKzNVOWtKYjRNWTJTeUV4NDlKK25oRW9PUUEr?=
 =?utf-8?B?YUVQd2dWazdhbk40bUJQcURLRHllekJqY1ZTclNwWjc5OEI4SWxWaUdtS3I2?=
 =?utf-8?B?N1pGOHJXL005QjdTTmRsVC9KWUptVCtRd1R0VjZVbG93M0RvOHlvejdFTDJr?=
 =?utf-8?B?a0VNL0VwZlhKMkdCYlRWQVBVeGpqb1ZRYm1RalVqbkhkMTVGU1Qvb2xld1Bz?=
 =?utf-8?B?elRZOTNyaXZSUzNNVFdwSGRpeEFBOXYxSHJDQ3gveGNFOVRPQk5NMDljY3Ix?=
 =?utf-8?B?eUNYeEt6OFE4ZjVaLy9SMUpiUGJsNUlNZ3ZOTDErQlBGamY0M2k4MnZLL1M5?=
 =?utf-8?B?OC9wUnpBclhaaTdWSjE4L1hnWk0venRudk5RZkw3WHdDTXB1WEFDZ2pxc1Yw?=
 =?utf-8?B?OFJnVENwUzZFQ0NlR1pFQmIwKzVQcWd0WnBlL2hucG12YmhBbXNvc1QrVHJn?=
 =?utf-8?B?SHNac2JaVXozYThUMEJMS2Jock15VDE4dWRNVVRFT1pKVGRqa2hWV0laNUd0?=
 =?utf-8?B?TG1UN2REcFpiRWR1d3diNC9nUStUME1kY3o1bzMxSzdjMEt3MGs0a1dRbW8y?=
 =?utf-8?B?Z0N5c0VqeGN0WXFBcVBLMXk2akkzc3dKc0dkbFRRTVkyK1RRbEdVVzJ4bThQ?=
 =?utf-8?B?MVU0ck05OVZPeHFNT3VrZVFhUGs3bzEyN2p5bFExbWUzaHFFZ1ZPVHp1Y0xn?=
 =?utf-8?B?UGpnalVib1N3Y3JQU3RDZG5mTEVQUU9XTkVlNDJzVkdxMVdaSUdNQklCNmNs?=
 =?utf-8?B?QnIwRSs4cWN4QXFnejR3TlJrTW1Wd0ljczcwRDdFM2xLZ29HWHo1N1c5RFFE?=
 =?utf-8?B?bzBnV2lqUzNvRFYyWnAxZytlUFJzUFFQdnZNQ044SXhZK0kvYWJVUDRoUEtk?=
 =?utf-8?B?OEpQK3BrbklPcnBscTR0VjRSNFkxVVk1bkpTUGdFTVB0bUpnVTZUc1MzdHdT?=
 =?utf-8?B?dG5VZGtlc3ZZRkM5amlrWTJzdEwvZ1pRdXcwWUFuZmhJUm0zbDdRZXBkL3ZB?=
 =?utf-8?B?RzVWenVINnA2UE5yOVFwNDZnUndKSFRKMHBhT0RLMmY0NGljOHRrS3lVVHhU?=
 =?utf-8?B?cFg4QTJXU1hwNk9tcEYwZC8zVXkyYVZxK2NodlpXZGZBVXpnYXdFd044dlla?=
 =?utf-8?B?QWJxMzdDVkp1VmZqbTc5TTdpTkhDeS8vaDBGRTB1RFA4ZEF4NHhHczloQSsv?=
 =?utf-8?B?bjBWY3pKYm44OTZEZWpsN3licU84Ty9VQ1FZSXlRREFBcEJTVlJWVmdFZXdN?=
 =?utf-8?B?WUNXNUpER0Y1VHBpSTRHNWZzNWtrTit3cncybnl1bzlRV1RsZVdndE02ZTls?=
 =?utf-8?B?TGpDS2FSK1lyQzdWVWhqbmpHNER1SVEvTHdRTlgzdGJvZE9WTGJWaUNpUjRo?=
 =?utf-8?B?aW9SRWY1NVRjdTR0a1pZbHIvRSs2SHF1Y1dnWnZJUmZNbkNTSyt0WHp3cXcz?=
 =?utf-8?B?RkRVUEdoT3E0RHJHWG1Fd3N5aFR4THY0VVlDdTNiNkVCSi9YOHdkejVITkoy?=
 =?utf-8?B?UzQ2STVBQlI5Y0RYK0drVlZ2eTZXMEN5aWUxbzJ6a2hUTUNRdStBaWNramoy?=
 =?utf-8?B?M1B3ajUxMDV0a0s5MnpubWZJQVpMUnlicFQ5WkxBaXFOTHF2bkRnY2tEVnhw?=
 =?utf-8?Q?tKZpIL1T2SjuHInvAtr2fQT+O?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6442e06f-63a3-4aa0-2ddf-08dd8640d67c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:38:39.2785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCcx/t0nDf1KXtnNcNP2SCftL6GsPmXPuEFqTQX4Lsw7HPf/4jwdU6d1uqZ41+Kd0d/3rpHjWneZh0rCw4OFDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
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

This patch adds SCMI pin control protocol support to make the pin
controller driver based on SCMI, such as
drivers/pinctrl/nxp/pinctrl-imx-scmi.c, can be bound to the SCMI agent
device whose protocol id is 0x19.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 6 ++++++
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c    | 8 ++++++++
 include/scmi_agent-uclass.h               | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index cc3f31d881e..e7ec2c108e6 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -97,6 +97,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		proto = priv->voltagedom_dev;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		proto = priv->pinctrl_dev;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		proto = NULL;
@@ -147,6 +150,9 @@ static int scmi_add_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		priv->voltagedom_dev = proto;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		priv->pinctrl_dev = proto;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		return -EPROTO;
diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
index 5b7122b08a5..aed47be337d 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -10,6 +10,7 @@
 #include <dm/devres.h>
 #include <dm/pinctrl.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 
 #include "pinctrl-imx.h"
@@ -155,3 +156,10 @@ U_BOOT_DRIVER(scmi_pinctrl_imx) = {
 	.ops = &imx_scmi_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_PINCTRL },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_pinctrl_imx, match);
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 842c56858af..d6586eb3ff9 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -27,6 +27,7 @@ struct scmi_channel;
  * @clock_dev:		SCMI clock protocol device
  * @resetdom_dev:	SCMI reset domain protocol device
  * @voltagedom_dev:	SCMI voltage domain protocol device
+ * @pinctrl_dev:	SCMI pin control protocol device
  */
 struct scmi_agent_priv {
 	u32 version;
@@ -43,6 +44,7 @@ struct scmi_agent_priv {
 	struct udevice *clock_dev;
 	struct udevice *resetdom_dev;
 	struct udevice *voltagedom_dev;
+	struct udevice *pinctrl_dev;
 };
 
 static inline u32 scmi_version(struct udevice *dev)

-- 
2.43.0

