Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F333C35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8249C807D7;
	Fri, 21 Mar 2025 08:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QWDrXlI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 550CF808A2; Fri, 21 Mar 2025 08:15:57 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07977805C8
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JczL5WU72s9Sj6Tk+N0P9qY7cgspB+o/ejaNVyCBIWNCQSN9aHHm9zWDBH4Nbrj028Zmu6k6MedutT/tlBOtyL4xDDi+xgQdWPONzuFF6WpShda6qLEBSQ18PV2PqfvqkdDXFQVkY/M88Ra6DOG1EgCrTZr3+luzkzM9Z88YswAs4fZPWMeSsFbU7gZPuR1aoKxzz9vwpVi69j/OG0DlJXIKDJQWUFXQwFEB+MFBUEql0d2yGWynmB5W+6EVtQl6+j6I6UvgPDvCJfGirv6Cb91kiK16BE02EJDOkpY4MUf9YtGQwWL2uY6Slq/qLhoQloS+Y6r+cOiR28CvThHrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KHvTkK4dbhqWWB2Ybwautmv6bxkhU6lEuoR7fpAGdQ=;
 b=vNmY3Z2x6wFcLSotNIPvEfRxi8FJ9F1NCAXIaWjFNTR3gScICGAhtC4/+X6VMpJz7F35vtQzCi58AqkOH8ZlcowRnj/R5QDU/nf4ATA04pl013bRfyMFymf3qXlAguDQhlyMq1M3rnmUFOQNWGRokw/58pyRM6giodOPF++YDClUiEaFD8e0o92mkCOzZWn6gGSKnNMYkBlAttfC9RJK6Wj+O/JTSl9gH3cHg72Na5ZbMAHOui4RqYvJhv2ZZS1zzJwfS5hNaanx69NRqpMSYLlFVLPsER5b+5XrLU6rfPHcp2b/hQgspZIF57FpypYKAtovxn+rxMmJR79jpm+sPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KHvTkK4dbhqWWB2Ybwautmv6bxkhU6lEuoR7fpAGdQ=;
 b=QWDrXlI+4/4ZrYV6uJ03OofcsXFHPaPzPqCC9dU5x5Qr8w02hinQxncLBns6gBBbynork/Hiz1LYv2oEqODjpltuiC9yxBY06LtYl+ZnbDWuxCnr2N6edj32s8qniSBdSzf4mRv6C+9vmPRD04jkOidDZzxwDpsk6BgoXr5ZeRI3ATiiWnUfK4jztaSyLiNElnMV2zCY3rUaL+Pc6xe/X2Ym1RdpE563LVCKsoSYT0dK2mo8YxK08v01RQFsmxBmvMMCrvtVL3HPr5gGJzlBjxaTZwECqBVjDrl96ZE+PfTtZALHByaB1LaBf7GJKpG5Eco7JtDFpUdMWimhAvQsnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM0PR04MB6836.eurprd04.prod.outlook.com (2603:10a6:208:187::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 07:15:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:15:52 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: [PATCH v8 00/19] imx: add i.MX95 support
Date: Fri, 21 Mar 2025 15:15:14 +0800
Message-Id: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAIS3WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyND3czcCktT3cTUZANDSwsDs8QkMyWg2oKi1LTMCrA50UplFkqxtbU
 AKce2TlsAAAA=
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Viorel Suman <viorel.suman@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM0PR04MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 796815e8-7866-474a-effa-08dd684836b0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2xKaWwxU05vbVRTV2JmZWtwYUl1VnU0SUFQamRoZUZIZFpNSi9TS2drK0RW?=
 =?utf-8?B?cER4OUszQStnTzFhelFQL3dnMGxNb1Vna3dmamJrSk1UYk9YdTkxY3Vjb082?=
 =?utf-8?B?TXh2ZEFzcVdtL0l5dGFXYUU3azR4emE2N2VOTktDc0hrUkExNnVmU1hvVktV?=
 =?utf-8?B?alhlZklhRldvY2U0K29sTXZabDQrTC9zMDVTUWVYUmI2MXI5MU5jeXBQWThm?=
 =?utf-8?B?L1VMaWxBdDZIbTgyd0hXL3JGdVYxa2hCT0NlTElBUU9SZk9mR3ZJRjB0QVk1?=
 =?utf-8?B?K2NTMER0U2NFK2NMNTV4Z0FycUQycHQ0Q0FYZ0x6WloxQkdVWHV6ekFnT2F0?=
 =?utf-8?B?Tm1WWGxPcmtPKy8yenFIN0t3TUZjNTEvQmlhTGhUL0h3R1dZMStjeUlrSzcr?=
 =?utf-8?B?MVRkVFc5VEtVMlRmR0tKVHNkR2VBTUd1bm5BdTQ5VDlPb2lnYUNMbGg2ZjJT?=
 =?utf-8?B?WVJlVWRHU0JXMXliR0hhbUVUcDlwU2E2ZmxqbXVKeStHT2U3UGVGSWFiV25m?=
 =?utf-8?B?d0NETjVyL0F1UXJ3azVEaW1qWDZySjN2cEp5T3lSRUV3NTFhMHE4eTdDd2c1?=
 =?utf-8?B?TUlIVFozVGw3dnNVUHh1Q0VhVElZZFBJelBROXFiQVNmWXVsazFmSml4eUxu?=
 =?utf-8?B?L1R4NnNsQ21lY1BNOTgzMU83RkF2WnY5MFhzRXRhZkZGcDB5NlR4RjdhVWJI?=
 =?utf-8?B?Z09Ua3N0L3huMitYeCsxbVZ6Q01naVlwQmxCU1FsUGFIQXdIaHh0L1RzcEd4?=
 =?utf-8?B?WUpSaDZqZzZVUXF5RjZUZW1FbWEzQmJUVHF0cG9reG82M2FWdUF4c1BadHRk?=
 =?utf-8?B?RFJiY2gzWlFJSCtDM01YcUVQSlZqK3hWeGxJZUR0dzhkdXdUWFlSTjVlL0Np?=
 =?utf-8?B?eVZTOHQyWXdiYVdaZ2Z3NURFRnBsYlJ5MVhiOXQyZ3ZoNm9VdzBQZnFMUEF0?=
 =?utf-8?B?Z0FpNE1PZGNKWkIrbjVTeWd1L25xenV1YWpFTWJrUWdVb2NOdUxzY21lUklo?=
 =?utf-8?B?cm83SElqTFFicDYrM3d0K21TVUdVanlNckcwMVgrQkFPamRMNkpDUGg2VUtP?=
 =?utf-8?B?ZEpMY1hwR09TZmtkTWZNV01PdkZwdEVvME1YNWhkNVdWUXdBTjE5dGZnNmNv?=
 =?utf-8?B?YWJBZ3lDT0RZOXYxbGpBZmpTcklFT21DU0FyanlaNjlMenRQbG1MVnJuSXpR?=
 =?utf-8?B?TXArWVlEQTBQWGZzSUxoT0JQdXl0TWxHUlZnVWdiZW4wWUIwNmpXMXRkRDVW?=
 =?utf-8?B?UTAyR053NlBYei9rY1BwdDZQdHpFR1IwV1MxNDVoYUhDaWJ6WWo2NmpZK1F0?=
 =?utf-8?B?WDRIMmtVS3FtQTJnT0JHTmdLWC9IM2dtbWp4NVVCRTNESXVXVmprYUR4cllp?=
 =?utf-8?B?RTBGcWgvTUVvUGg3d1dLeXo3d2dTU0UvaldTeXVlQVcycjlMNVhINkhNN2Ni?=
 =?utf-8?B?UlMwbXlHWFdEMnlFM0l3TVlzcmlNdmdLYVM1T2xjZ0dUazV4ZUhZcnJ4QS8r?=
 =?utf-8?B?UFZPcDhUWUgxWFp6SXREM0wzSFdUNDBUc2FpM0pEZWRVZFAwVENUMDE3YXVR?=
 =?utf-8?B?cEJjR1I1bzRjeStuSXJ2aTJJMnkxMTFnai80cXZPcjVjZ0dlK3RuN2xMQ2sv?=
 =?utf-8?B?VytncmNrR2hnS29oZVVDcjNqYkw1SHMxOUJybDQyQ3I3dC84RWxZbDY5THJF?=
 =?utf-8?B?c0FQU3BWSU5ST2p6dVR0cEZEOXM5ZDFxQzdsZDJpR1ZBY3BQMG9XWFFnNVc2?=
 =?utf-8?B?eEtsVFhHQ29WVlprd3NQb004RFZXTGp1OHlmYUs4Y3dld3dzQm5DQ1hORmJx?=
 =?utf-8?B?aElBR2kyR1F0OFV3U1Y0VHBXZ1lacG5hZXRBeFU5RmxvK3piQUxITGVnQ3NL?=
 =?utf-8?B?K1dSc1JQTFFVd2xudWRUZm9hU3JtcnhJZVVsUGhKUjAzM0R2Ui8zQVdDUk9m?=
 =?utf-8?B?Rmd3M29lRzFtNE9QbmtvZkpKcVkySEFzSVd4RkJmaExUS292UGV0cmRFTkFk?=
 =?utf-8?B?SWVVWHM2SXBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0ZhcjJhMUxCbjFEd2p4ZGNaNWJuUFJMK1BaV2RQbk9QTlZad1diazd0REFY?=
 =?utf-8?B?ejQvVzl6NzFnbEQzV0l5d0RUU3VYaWJacndTTkF6WFNsdGxuN3FJakd5RS92?=
 =?utf-8?B?Q0xqbC9rQURXc1VHbWxhMVpFMnJrTFk5cnUyOHh6UHhTOFMvTFVVSTIvSUZm?=
 =?utf-8?B?cGd5WEJFRW5rNCtxeGErN0ZibjY2cWNjODJNMWlYT1lNZXRoUmxsRjdYMzhV?=
 =?utf-8?B?c2lua0JnYnRKcTZTKzFTTVJ0VzYrWXNhczVHNkpnUnRXRU05NWtTUzFhdTZG?=
 =?utf-8?B?SzM5OU55akhoSXIvWkVBQ2NrWXVlckcxRE5mQUZKV2lLS2RiazZUSWJEYTdF?=
 =?utf-8?B?Q3JPVVpYbWVZVWNMVEgrOVh0eXNuMXJGVXg5SXhJNi96cWd1ZSt1RitUbzUr?=
 =?utf-8?B?YjlCTHNkZUhZT0E2QXdzcWNiWHJwWDRJcDVtck03T2N2b0NRa3BjZ0F3K1Bh?=
 =?utf-8?B?QmxMNEIrWGphcTRlY09PSEV1Q0s2WWRvMXJDajN3bkhXWW5nMmtNbVNuWERl?=
 =?utf-8?B?ZUljM2NwTVAweW9XNTV6QWVQa0p4YTV6OVZwWjZXeVQ0akNvYjF0WldxWi9U?=
 =?utf-8?B?S0xubjFEU2NTVFpUSVd6Rk1tVENqVDY3VDBPNWpqYVdEMm5lb0hZT1I4ODZR?=
 =?utf-8?B?OFhtbTNvdjE5Nmp2K1lOaFFqVnBmNExGaFNtdmExSzZkOHhSVmtqb1Q1WVQ5?=
 =?utf-8?B?L3hkalZWUVM5ajZSNmxZQW16R05jcUJyVG9HZHBhckN1WmtVVDZvQndsRHdP?=
 =?utf-8?B?dGhQQ29GYlYxUXR5OGVkY2gxcTRsMWcramJ1M0U0WnN3SWQ1cjJRVHdqbUt3?=
 =?utf-8?B?K25vZnNwK2I5VHFrci9oMDNmTlJQMmhaSlZUU0s2Y2lFNXpaZkp5bFpoUUtl?=
 =?utf-8?B?aTlIRTFjZ0RTblhyTlU2T2FkOTdXT3ZKcC8yMmVoMmJPejR3VG9ncXg4UnNV?=
 =?utf-8?B?bk9rNzB6UUszM2NvYmM2a29wZmc3N3hQS3Zld2Z6UXN6QStmOVRLN096VG5O?=
 =?utf-8?B?Qzl3dzZHWE1XVk1IaHdYdERvdVFEeVBySlQ1ckdUQTVlVkY0aWVqa2VZRWlo?=
 =?utf-8?B?S3JsdWNHdmJYRnN2aytaUnBsSjhsQy9yYUEwM3dQT2VIU3FlNHVrNVdoSnRU?=
 =?utf-8?B?REcvV21uZ3Y4a3pySEprbUkxcmRhNUdBZG1DV3Y3cEg1Qi9uNHVEL21zUkgz?=
 =?utf-8?B?OWp2enA2LzBEZ2QxUitzbTRVZmF5RkhnUlFrdnpzUkdmb3cwc0VxODU5bHRT?=
 =?utf-8?B?Q2tnRUdOUDFabmNFSlJYQ1V3UHNaMktrNUsvUGVuQnpPRStuK1NmR3JOT2t5?=
 =?utf-8?B?NkIvb2JyYlZQYk5pVVZ2K1A1Z3hiTXZTelFIZ08zLy9tSE9ma053Z281MVpI?=
 =?utf-8?B?d3RlUjR3ODVDWm9sNWlybjc0dFVUTytKdyt2RUJlVmh2enJSL0NBaHZBRnNF?=
 =?utf-8?B?UjhMREovTWxkMGtvK20yUEtxTDdBZnhtMG5HKy9wR2dsUkRmVlpkRnRqZlpL?=
 =?utf-8?B?ZXR4SHhZcXBhZGF6eHljM1UrbkNTSkNXVm5DQ1N6N0FzTUllb2xpb2dYRW9j?=
 =?utf-8?B?T0tILzdXUnorUGNnMTZBbGZCbHc3WHgyS1JTNFpqUVNUTklHZnh4THhWeFdl?=
 =?utf-8?B?RTZMSko4eGMrNVc4YmFNcENZS3lKdWw2eEY4Rkl5L0dNWVVPcUdGaEpKTHFt?=
 =?utf-8?B?clVDdjUvUHNrSVZUMFlLZTAyTnUrdWhrcW1nRFVUdm13NjJ4cU95eHc4Vm1w?=
 =?utf-8?B?L2hoTGc0U0RpYjdyN0hDa3o4MEFMTmZXREUvWm01eW9FVWoyL1VZRCtFalMz?=
 =?utf-8?B?L3VEQWUvQVBFOXJZY25LNGVXRW1ZeFdtS3Q5Y1lFZVlqYkJHT3FQbkpXRzBJ?=
 =?utf-8?B?Q2JpUXI5L21Jb3lWMUdEakdGSlhRS09OV1F2T01qNGhsb2h4dTk5KzZWdngx?=
 =?utf-8?B?MVlHSWdmbDRtR3F3SDI0blUwVzd2d3RzWUtYQi8vVlBDSzBWTWExT2QwMWZw?=
 =?utf-8?B?eHB4RXB0MWN5ZmNFWWRQWXlPb3UrTElzcHJ0bzlkNFRuY1NFQ0pPVElEUGhm?=
 =?utf-8?B?MEJSeU1kMGFCbXk1bTR6TjRicDVOVGFFRUI1bXBYZmdmWW9rZnN0ZFN0K1BI?=
 =?utf-8?Q?NeD5LyR+NYOSa+GUEmclbQO2M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796815e8-7866-474a-effa-08dd684836b0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:15:52.3780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOGP+f3iKBCj+LJ/Xw6TAq72KwLVLqbBUpKrzptnjqBAnrvXhCRd/64Lxictdpx1ShqzKn8QBiHuTtgnvVl7mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6836
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

Changes for v7:
 - separate i.MX Messaging Unit driver patch from this patch set
 - add U_BOOT_SCMI_PROTO_DRIVER() to avoid putting i.MX related code in scmi_agent-uclass.c.
 - update drivers/clk/clk_scmi.c according to comment
 - dynamically allocate the size of struct scmi_base_discover_list_protocols_out

Changes for v8:
 - add a comma to enum scmi_clock_message_id
 - use readl_poll_timeout instead of while to avoid to silent hang in
   disable_wdog()
 - use the format "%pM" to print a MAC address
 - use "%u" to match the data type u32
 - add a comma enum imx8image_cmd, enum imx8image_core_type and so on
 - add a line at end of container.cfg, imximage.cfg and imx95_19x19_evk.env
 - update arch/arm/mach-imx/imx9/scmi/soc.c

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (9):
      pinctrl: nxp: add a pin controller driver based on SCMI pin control protocol
      firmware: scmi_agent: add SCMI pin control protocol support
      clk: scmi: check the clock state/parent/rate control permissions
      sandbox: add SCMI clock control permissions to sandbox
      imx: Kconfig: IMX8_ROMAPI is not configured for i.MX95
      binman: add a new entry type for packing DDR PHY firmware images
      tools: imx8image: add i.MX95 support
      doc: imx: add document for i.MX95 Image Container Format
      Makefile: add some files to CLEAN_FILES

Peng Fan (4):
      scmi_protocols: add SCMI misc protocol protocol_id and message_id for getting the ROM passover data
      scmi_protocols: add SCMI Performance domain management protocol message IDs
      clk: scmi: add the command CLOCK_PARENT_SET
      imx9: scmi: add i.MX95 SoC and clock related code

Viorel Suman (1):
      firmware: scmi: smt: Interrupt communication enable

Ye Li (5):
      scmi_protocols: update struct scmi_base_discover_list_protocols_out
      spl: imx: use trampoline buffer to load images to secure region
      imx9: add i.MX95 Kconfig and Makefile
      imx: container: add V2X container support for i.MX95
      imx95_evk: add i.MX95 19x19 EVK board basic support

 Makefile                                      |   3 +-
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  62 ++
 arch/arm/dts/imx95-u-boot.dtsi                | 157 +++++
 arch/arm/include/asm/arch-imx/cpu.h           |   2 +
 arch/arm/include/asm/arch-imx9/clock.h        |  10 +
 arch/arm/include/asm/arch-imx9/imx-regs.h     |   6 +
 arch/arm/include/asm/arch-imx9/sys_proto.h    |   1 +
 arch/arm/include/asm/mach-imx/sys_proto.h     |  39 ++
 arch/arm/mach-imx/Kconfig                     |   2 +-
 arch/arm/mach-imx/image-container.c           | 119 +++-
 arch/arm/mach-imx/imx9/Kconfig                |  16 +
 arch/arm/mach-imx/imx9/Makefile               |   9 +-
 arch/arm/mach-imx/imx9/scmi/Makefile          |   6 +
 arch/arm/mach-imx/imx9/scmi/clock.c           |  70 +++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c      | 133 +++++
 arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +
 arch/arm/mach-imx/imx9/scmi/soc.c             | 793 ++++++++++++++++++++++++++
 arch/sandbox/include/asm/scmi_test.h          |   4 +-
 board/freescale/imx95_evk/Kconfig             |  12 +
 board/freescale/imx95_evk/MAINTAINERS         |   6 +
 board/freescale/imx95_evk/Makefile            |  11 +
 board/freescale/imx95_evk/imx95_19x19_evk.env |  91 +++
 board/freescale/imx95_evk/imx95_evk.c         |  36 ++
 board/freescale/imx95_evk/spl.c               |  69 +++
 common/spl/Kconfig                            |   6 +
 common/spl/spl_imx_container.c                |  41 +-
 configs/imx95_19x19_evk_defconfig             | 152 +++++
 doc/board/nxp/imx95_evk.rst                   | 114 ++++
 doc/board/nxp/index.rst                       |   1 +
 doc/imx/imx95_container.txt                   | 136 +++++
 drivers/clk/clk_scmi.c                        | 191 ++++++-
 drivers/firmware/scmi/Kconfig                 |   6 +
 drivers/firmware/scmi/base.c                  |  24 +-
 drivers/firmware/scmi/sandbox-scmi_agent.c    |  56 +-
 drivers/firmware/scmi/scmi_agent-uclass.c     |  25 +
 drivers/firmware/scmi/smt.c                   |  13 +
 drivers/pinctrl/nxp/Kconfig                   |  13 +
 drivers/pinctrl/nxp/Makefile                  |   1 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c        | 159 ++++++
 include/configs/imx95_evk.h                   |  24 +
 include/imx8image.h                           |  19 +-
 include/scmi_agent-uclass.h                   |  17 +
 include/scmi_protocols.h                      | 104 +++-
 tools/binman/entries.rst                      |  10 +
 tools/binman/etype/nxp_header_ddrfw.py        |  29 +
 tools/binman/ftest.py                         |  11 +
 tools/binman/test/346_nxp_ddrfw_imx95.dts     |  24 +
 tools/imx8image.c                             | 147 ++++-
 tools/imx9_image.sh                           |   8 +
 50 files changed, 2937 insertions(+), 76 deletions(-)
---
base-commit: 8543664bffdbc49d9fbd600131c21a7c4b5ca935
change-id: 20250321-imx95-aec019806ab6

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

