Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5877EC36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EC21828B3;
	Mon, 28 Apr 2025 12:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OdQePSov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D37482145; Mon, 28 Apr 2025 12:39:50 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C87C828B3
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCL7qLnR0OBx1/RF2S5Sfuyp3qN/S0wfKweplcZdwQLdPTiRiP4itPI+80W0UeVyMvwP+X03Gh+eRkXeixKjVdvlnVUJwdM84dkvB859qj2RO4MiBZyYsmR0/+vP6Qyy7eZrctOFaVJTTddtpXLUNPpVon+Mj0ZUch6e4T7SsqCqwQ3ID+7WZIRVjXVsnfiXKE8jlAp+DZNRsYL9bReh6flUskL5lJdbIJ2VByx5BS0wACre6/tiKwhv5TH/a9NSdo0s7Ws6YK9Sg747j1J08Ve1edcznMU7C5S9zxteMjMd4H+LXn1HAtyYFlC7Wv8ddZ1oC/zSNCODveNxSCTa0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HslbAn+srlVzbEZSM//zoDicGH9XSnmA4V586C6hE6o=;
 b=T31Zm1Cme+jl3cHHzg7qgXb83MF+rRbV/kULRQeK+b+xMZO5MQDhrmRwE1n/qqF0CA1gXD104vVClc6T3UcEydypr+3C9FLgjEXMCw2glwAtmRHjhM3eHRO0fdxbuuiwWeG/Y51gfXwer7l2iyHCpfjVadLSE4mpOmMtU7gYJUajYLWHEwapcKW1W2H1qPP2HMxDxV9RVoWdUX3Am0l2QwRZJQYmIz3SfDfRHOuod7ZLNIFSs8QOaCIXQXDsTtyUnKsoC2A7CbYR852xhhPFZLvKly+QJrDVDARqyw8Y08uTVaKt1imclb2oRkWTOWShyRKs5PXzwFMlFCCQhYgutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HslbAn+srlVzbEZSM//zoDicGH9XSnmA4V586C6hE6o=;
 b=OdQePSovEKxn8saf3qYFFYFWuhWbkqnKiu+t4V0qyWNh1X92SKJHjJ+1521rE3Ob5E3eNsH/OWpl/myxijZHgXUryMgGqKALgemF13lg8qXUu4Ri0IrfkFxJ4i3EoqjYnc69Rm9HThoEpXZ8+h5RHuicPXbmkBBVGixLgFDFhnV/3RO3VtKYP60740UqgBk/p2HkZwzsaJyVtGf0d8LVP0/ouggpb8zH67WoppnMNCbhLJ/5ZVpIweSqiksVIg31lcPecrmIcuXsZ1HnW9oRdZL/dAwsrIlcwIVh0ULYIfIRcZCAGTPVW1E0QNohgaBT0YCLc/QDBpv+8TsPkkl2XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10393.eurprd04.prod.outlook.com (2603:10a6:150:1c9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 10:39:46 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:39:46 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:42 +0800
Subject: [PATCH v11 19/21] doc: imx: add document for i.MX95 Image
 Container Format
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-imx95-v1-19-a3df9c340ace@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB10393:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1180a5-b670-464d-747a-08dd8640fed1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vm5jZG03WXR5ZWdQTXdYUEo3dmdYdTY4UklieStvMUZ4M3ZxOUxJeGgyYlVD?=
 =?utf-8?B?ZE5Wc3BkSVdNVGZiSDA1MlYyTHVFemViY0dNcU5YREZoVG40aEtKWS9xc0FL?=
 =?utf-8?B?NlJaaUFZZHhVMFVMZzhtdEtJRjBXUk9ZWmJrcFFJSWxvSTg1ZG5zZFI2R3Vt?=
 =?utf-8?B?U1Brb0hOZGVaYkRHczRUSnJGekRVeVJKUU1tMEMyUGJSYWJZNWNnUDVqcm1t?=
 =?utf-8?B?K1ExRXRKRVVpUmlvQWs0bEJBeHFXQmlDNWZ3ekV3Z3RFWUlWWXRrRUxsNXhZ?=
 =?utf-8?B?aFZybTE4NlJSRDdpdnNxdWFPQUd3a09sWnFobmkxSkFyQ2tOR0s4SUdTWXpI?=
 =?utf-8?B?S1BzQXAwbjlCYkw3ZFFXNW1QQlFCVTJZTncxQkxYMjVxaTZWMUhEcGJSaGpF?=
 =?utf-8?B?Smlob2diNC9uT0xHVVk1aVBzL3RsVnR5TzVQM0RHdmZHeGlTdVpPZ0lpclhL?=
 =?utf-8?B?S05lMkZLd2VLeXRNQnRkT2VjUWJycjQ3MWt6SkV1VVVNSmJCWkdDb0JNc1Vt?=
 =?utf-8?B?TWdlVFIvV0lqb1RLY1k5Sy9ubkRXbmNIR2tpUGFYNEczYy9nbXBPUXpHM25B?=
 =?utf-8?B?cHVqb2QwVGRrWFdzenRjaEhIVzlERVRXcTRRalRRM0F5Qm5IL01kYnVRZXVh?=
 =?utf-8?B?dTlZbUsxOFlCMVpZMGNxVGdJN3NFbGhLcXc0bCsvMHdQQjZadjBobkV3Y0Mw?=
 =?utf-8?B?MGtxMHdkdnNkb3VlS0R3NmF1WS9NNHNwcGh5ZytiWFRDWEdyTWxiR2pldFBE?=
 =?utf-8?B?cEZFQXdBVGpxRjdtdXpvNG5jR3NZV3NQRlZ3d2h2MG5DSkpBOUNsR29NNWJm?=
 =?utf-8?B?RUNkN01scUFlVW03enRlMlJKMk9ZSldNN3UxcUhtVWJrVGRmZXp5MUx3WUxW?=
 =?utf-8?B?WWcwejNBT1pQUm9KQURWaXJ4QWxBVDhCVUpOVHFuUzlGazhTU0NIS2k5Lytz?=
 =?utf-8?B?VWF3TDl3OTIxWGNVa3d4YW1VaUVTRXBVSTV1UE80am5MY1pqa3BSN29vSDNw?=
 =?utf-8?B?SHlDeHR2SDRBV3hDZ2xBV0krcmlYSHFWNHdBM0hhd3FNZnE3d25udnROT3dL?=
 =?utf-8?B?VWdFZ2p0VCtyRkdTbU5VV2V3WTJXUHpnWHp2d0JmY3U1dFhpV25ZU2FuT0N1?=
 =?utf-8?B?ZzFNbmVHNGt5bWdYNVVLUDg4TjBvRDgxd3dCQlJVNkorNVdEUlhVcnZkNG85?=
 =?utf-8?B?bFIwMnRHbGhabVo3UXdoekY4RFliSjc5dGEwZ2dkLzF6bVB1Z1RHZ2RiOVUr?=
 =?utf-8?B?Z0VCUlMrR3RWN2loOWFjUlZKNHlwemJ5bkswWmc1c1k1QW5wQUFuOVE0Z1k2?=
 =?utf-8?B?U0lQcG1HTy81bUpQR2xzYk9IQzZHRDVvRWlGbmNsMHRPUFVBK2F0ODlKT2JY?=
 =?utf-8?B?UUJBUDk0bU14UitpZVltQU5JcG9FN2hILzlKbkI2WUJBYStBUDB2WTBDcS9y?=
 =?utf-8?B?clNiem9saTJGZERXSFpBKzYzbzFPRVZzcTVSNTdncjB3YnN3SUpEY0Q2N1dK?=
 =?utf-8?B?WnVOUE1OcGtlMzNnUWJPMzY3UFg0MDJGK0J1c2ZXbE4zdTBldHN6cGFQLzQ1?=
 =?utf-8?B?bzFZenorVHBWdXAreWVNYVFRTVRua3E1R3BaSUZXcGsrcVgvMnJmbEpocUJB?=
 =?utf-8?B?cWxLeHU2bVoxbldmUkdiaVVJZE5kdXNBV0ZvQzhPNVM0R09JN0kyLy9Eclc1?=
 =?utf-8?B?eU9uR2JYckpyN1dESFR0bVBhWjIzeHRpMkJ1NCtXcTBRTUNzay9kaVZ4aGNB?=
 =?utf-8?B?QUo3TU5PalhkUFhQbFRXS2k2VXBOV1RHb3Z6NHQ0dlZwMmJzZ0JJWktzbUpa?=
 =?utf-8?B?bzlvVEtCcGVISTRQcFlQZ0w1bnBZZXNVb1NCRURNaGEyR21yMHh1ZnFCc0pC?=
 =?utf-8?B?eERIM0JxL3M3Z2txNk1PTWs3RmNFc0tPS3Z2aDZxZUwyKzBTNW1ic3gxbk9m?=
 =?utf-8?B?TW5GMU1uOVd5VUFmZExQbDk0U3VMcWJPYmY2NnZHd09kL0RManh5eHFRamxk?=
 =?utf-8?B?ckkzZ2c3a0RBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEhVSmhod2Rkbzluc2FJN3ZmcmYvZjltSUFSL0tFRmp3dXU3WXpUZDYwRjhi?=
 =?utf-8?B?Y0pFanNZd05WV0N0TENqVERyTUhQb3RMZWdKaFBFcmpwcTdXWXYrd2lMMFZE?=
 =?utf-8?B?c3UxbjB4R3VUQnlNK3dsM091ZVNlaTBpMFRIZEVWNUJuZUpSZTBSN214VS93?=
 =?utf-8?B?aXhpNFlsY0E1NUF6VzlFRm1qWkdrWGhKNDNpY2dXQTRWYUVjbnh2TUh6NHlk?=
 =?utf-8?B?dEpCTFJMMlVBQWZ5d2V2azVDQXBIaWl3ekhOSWhnVFhZUFFVZzZBbU90Q1ox?=
 =?utf-8?B?UDFDZ2tXTG9XbDlDaXlnMVV2c0dRQ3J1M3QxdUFJRURVRnU2NTBRWityS3hL?=
 =?utf-8?B?ZG8xNjBVQ1poQklkQkozbkhkeFY3eWRQU2tEa3c1ZFgzTFJwd09LR1ZBRGdM?=
 =?utf-8?B?MXM0Vk03OXI2TWVnKzRHTU1xd1IxcXN1QjYzaWNubWx3SUIzNFRvVDNpQnBU?=
 =?utf-8?B?ZnJkcGk5QW9yRWFQcU9wZG9ON2g1OUlPNEF5cC84MXhqQi9qdlEwOEkxN1FN?=
 =?utf-8?B?d3JJa3N1bkxKQVo0M3NyWEp3QjJIQUVRc0x1NHh3azE2ZkJRQStsQloxNkJW?=
 =?utf-8?B?TVlNL1RlazQxWW9QMXZ0Y3NnZnlMRFFLUVZHT2R3Rm5oTGFyTWw0bzlvcWNh?=
 =?utf-8?B?S0FUaG9BZzNSZ1BOR3JVdmRRR1dCVGRZM3NoVkJWczVweXFjZ1A0b0k4NWxP?=
 =?utf-8?B?TXArcDVvdE5Td1JTaEVhOThJaWZrRk5wYnpqMG1VcHhmb2Qyb0NZMk1weFh2?=
 =?utf-8?B?MURwek5IR2UxQkZXMGJPRGswSXl0MythYTQ1Q1BhVDg1OVB0QkFpM0QvY1Ir?=
 =?utf-8?B?S09NZzBEaExXWUVqQitHeVppTkpEeXl0V2hwTGJGZ21mN3ZNdExkWUMyampq?=
 =?utf-8?B?ZDNUSzdlT0NYa1JLMXhVSm9mc3pOZUZtSjhGdmE3a3NPNSthUzlIWXNRZTBv?=
 =?utf-8?B?M1F2ejludzNWR3JtcThGTHlpQlhFL3FQWFZDSnBPblVuZ1VWZWwzaWh5czR4?=
 =?utf-8?B?QmY5V1pZejk2MUVpaGEvVXdCM2p0dVdpVlEvNEpUVVZIeG9oWjBsdkZ1NlRP?=
 =?utf-8?B?WGN1ZUszQ2VOSCtiSzBDRTU2ZlVLZnFSWW9GWVFlWWdQT0R6MjloR3NFWGNu?=
 =?utf-8?B?Y0I3cHBWT3YwTnRZM1kwaS9Xd0FOV1A3aDRRZFBhamNHSzJBaTJnamFhYitU?=
 =?utf-8?B?VFFKNjVkeW55MEdqUllDSVdIQjZSL3RyRTRWTFFkRUZvUjBHTTJTbEZ6QjN0?=
 =?utf-8?B?SlJmVEtWbk4yUVJPcHhId0ZId3UzeWFpUjNiV2NrbVk5L3p4Mmh2YmFEOUcw?=
 =?utf-8?B?Rm5ZdFhJaXI3aTF2SUlzbUUyd2hQYkdseC92Tm9SVEVuNkNvNHQrQ3FLK1lt?=
 =?utf-8?B?T0pYQ0hDVGp3RHI4NnBSVFJtMWhER3ZoSWZRaTB6S2hIWWxZNXhGM0p6bTEw?=
 =?utf-8?B?a0VaU1VheWJUU05BeGJvS2NBdFRjZnV3MlhtZXlESEQ0b2l5M21sM1JoTC9Q?=
 =?utf-8?B?dmU3ZFMvZ2o4eDV0cWRNT2JtazJrL0lyTUZvOEM4Z05mbi80MWo4Nis4RzVy?=
 =?utf-8?B?MEVMRUtOM3NkRVd1Si9zNlVEM3pmaThpdGdvTXBFdGxremZYQlNhdFhiWmJH?=
 =?utf-8?B?T1FyTnB0NG4vSTA4NFBTa2ptZVZQL09QWGZ6R003aVRQUjRlYThSN3pOMG9n?=
 =?utf-8?B?QVpIK1VJZzJ0RzlkT2JDSUlscGEwbkU0YWFHcU40N2tqMU9hbHRLVzhXekZV?=
 =?utf-8?B?L0oyMEthdDRUNUx6NE0wVlN3YnEvdFZXOXFEMVZYTkFKaVFPNzUxQnl6aE9o?=
 =?utf-8?B?cGplcVptT0dXZ0N6VDlobnY0NjlYTDZFSG5XeTZTRjl3ZmN0WXR0d21oME1q?=
 =?utf-8?B?N3M0a0I1empMN2thdUJ3UnNNOE83TVh3YjU2UXcrM21jL1o1NUlKRkwyanlw?=
 =?utf-8?B?YlBEUDgweHl3bExQMVduSVhSRGpraFNqcTZjaGFTUWdBK09ZYkpxMVp1Y2Fp?=
 =?utf-8?B?V3g4YUxmYkJsMXJ4MWR0UnByajRGWk9NbFNkdVFxaHg3OTFBc1h3RlVseXZw?=
 =?utf-8?B?RlBoODIvNjFVWU5QY0JXQ3J5dTFpZXp6YlNadG43dml5ZHdwbFpZMWxLQ2Uw?=
 =?utf-8?Q?KsJuJ+1HhkQ7tzeMZwFGP0qzG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1180a5-b670-464d-747a-08dd8640fed1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:39:46.8730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOg1KC6TnQlcbfkbphV5fWGatgnH3RcnbPWkS95oJy+yWipXvPYA282TnqiT7oBaXCl4NijE+hQ36gNuePRdvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10393
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

This patch add a document for i.MX95 Image Container Format.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 doc/imx/imx95_container.txt | 136 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/doc/imx/imx95_container.txt b/doc/imx/imx95_container.txt
new file mode 100644
index 00000000000..05f223d962a
--- /dev/null
+++ b/doc/imx/imx95_container.txt
@@ -0,0 +1,136 @@
+i.MX95 Image Container Format
+-----------------------------
+
+The image container set consists of some image containers, and image container
+contains boot images. Each image container has its own container header which is
+defined in Figure 1. All container headers are placed together in a continuous
+8KB space at the beginning of the image container set - image container set header.
+
+ROM code addresses image containers in image container set one by one based on
+their headers’ order in image container set header.
+
+If ELE container exists, its container header must be the 1st one in the image
+container set header.
+
+If V2X container exists, its container header must be the 2nd one in the image
+container set header. V2X must be combined with ELE container.
+
+The information of boot images are recorded in image container header. System
+ROM code needs to retrieve the information from the image container header, like
+the offset on boot source, the target address in RAM, the length of boot image.
+The order of ROM code handling these boot images is based on the order of each
+boot image information present in image container header.
+
+Figure 1:
+------------------- +--------------+--------------+--------------+--------------+
+          ^         |Tag           |Length        |Length        |Version       |
+          |         +--------------+--------------+--------------+--------------+
+          |         |                           Flags                           |
+          |         +--------------+--------------+--------------+--------------+
+          |         |# of Images   |Fuse version  |SW version                   |
+Image     |         +--------------+--------------+--------------+--------------+
+Container |         |Reserved                     |Signature Block Offset       |
+Header    | ------- +--------------+--------------+--------------+--------------+
+          |       ^ |Image0: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+          |       | +--------------+--------------+--------------+--------------+
+          | Image | |Image1: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+          | Array | +--------------+--------------+--------------+--------------+
+          |       | |                            ...                            |
+          |       | +--------------+--------------+--------------+--------------+
+          v       v |ImageN: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+------------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+        ----------- +--------------+--------------+--------------+--------------+ <-- SignOffset
+                  ^ |Tag           |Length        |Length        |Version       |
+                  | +--------------+--------------+--------------+--------------+
+                  | |SRK table offset             |Certificate Offset           |
+                  | +--------------+--------------+--------------+--------------+
+                  | |Blob Offset                  |Signature Offset             |
+                  | +--------------+--------------+--------------+--------------+
+        Signature | |                         SRK Table                         |
+        Block     | +--------------+--------------+--------------+--------------+
+                  | |                         Signature                         |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                   Certificate (optional)                  |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                      Blob (optional)                      |
+        ----------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+ <-- Image0Offset
+                    |                           Image0                          |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+ <-- ImageNOffset
+                    |                           ImageN                          |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+
+i.MX95 Low Power Boot Image Sets Layout
+---------------------------------------
+
+    Image container sets are handled by M33 ROM.
+
+    --------------- +--------------+--------------+--------------+--------------+
+                  ^ |                    1st Container Header                   |
+                  | +--------------+--------------+--------------+--------------+
+    ELE +         | |                 Padding for 1KB alignment                 |
+    OEM           | +--------------+--------------+--------------+--------------+
+    Container     | |                    2nd Container Header                   |
+    Set           | +--------------+--------------+--------------+--------------+
+    Header        | |                 Padding for 1KB alignment                 |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                    3rd Container Header                   |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                 Padding for 1KB alignment                 |
+    --------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                 mx95a0-ahab-container.img                 |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+------------------- +--------------+--------------+--------------+--------------+
+                  ^ |                      oei-m33-ddr.bin                      |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                      ddrfw-header.bin                     |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                  lpddr5_imem_v202311.bin                  |
+                  | +--------------+--------------+--------------+--------------+
+m33-oei-ddrfw.bin | |                  lpddr5_dmem_v202311.bin                  |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                     ddrfw-qb-header.bin                   |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                 lpddr5_imem_qb_v202311.bin                |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                 lpddr5_dmem_qb_v202311.bin                |
+------------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                      oei-m33-tcm.bin                      |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                       m33_image.bin                       |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                      u-boot-spl.bin                       |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+
+    --------------- +--------------+--------------+--------------+--------------+
+    u-boot-atf    ^ |                    1st Container Header                   |
+    Container     | +--------------+--------------+--------------+--------------+
+    Header        v |                 Padding for 1KB alignment                 |
+    --------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                          bl31.bin                         |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                         u-boot.bin                        |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+

-- 
2.43.0

