Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C36AD5B161
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 06:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94D93836AC;
	Tue, 16 Dec 2025 07:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="g0vTwqAM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 139798003E; Tue, 16 Dec 2025 07:40:06 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45A348334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 07:40:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmOGZeb5IiBj6SU4q7zAFZfkXqMl9szLsUGQTtryUB4zMTWbHiQQaHQAu5xx57iRVi0Pr979MWbOoGkTQYoDPTSH28tWUasAyufyMA+SXMEJbqsju6+DDKMx+yM04Y9CIlBs2U6LwcsO9tMRFUabdaHgk5Mh6TGuLpSjKkLoVJERbUgeFEMQE6s9SOllrp3QTfqdTAsLUCEH4KGueLUmqnWS2zO5vgxzea1LD3HHT3agNqzH42yenjFDtUgSi/Lzp15FoTgTeoiIrX8xUD3RCif7894kTZmYeu/YYDXI4TSkaVbScsLG0lB5KxY4IM8Ewf8oKwuELzY2TRNwlzv4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9IN1dzDYXI1HZlyaze1LVOvzQ8p3L8oc5Z62L0TIAo=;
 b=UT4Wu+aEUNLYdPBf2alASiOQnGNuXnb2B2NoJI9M9TnbJK5zIwFuyPrGY9TGPGfHsjHKUXVQi+NSU/iSniYJrE9lusGOxciIYFjVfeBJb75+fEYGNTHiswPsjEzGOrl1GWG4RoWqzlVXj4120cUv62ADnXX8SEapxpUkP8tf6uJAoNQRGHQNSM3fmFgpDkSdI8rAwbswIbNn5YTERKl42ZQ7LhzKlc7dW+suSxotMu6Ey4jEQYR2lRlby656qRQwm3/73HVwLO35sCS7QyTgOqPqUG+gqcBVMq+Hd5FQRWhaRxLIcVOrHWCR2an1TcgTsY3u4gnimG4OvYp4+36dRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9IN1dzDYXI1HZlyaze1LVOvzQ8p3L8oc5Z62L0TIAo=;
 b=g0vTwqAMzJvFwq8HG3vR6NQYbPWGkhh01MMmCQpP4bI+4T02koqOCRuL0McRez4e2AfGGofY6DB6cqXUoT45w7k+MVGLESfYV2WrL2xeglxvXLWZQkOubXSdkIRg7v1vb6iU6QAhgL/kr3x6z1M6fGQCq7lAfJEv21NJihSf4z8TsgKYkVA/c6msqzmddm1gE/QJt+n0t8dPnnsTOr0NPfjrOQ56Yp5GlnkviEUBYmj3ARYR914qjoi++yI3K8ExU8CKR8SbfHvBcWkdmwBByzE6SUW/D+MOBf2rcGsOhMPGYSR+zTKws67eiUluFbjx6m1uM3H57sz/YW8oJDA9LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7794.eurprd04.prod.outlook.com (2603:10a6:20b:247::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 06:39:59 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 06:39:59 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 16 Dec 2025 14:38:36 +0800
Subject: [PATCH v1 4/7] usb: ci_udc: Convert driver to DM_USB_GADGET
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-imx8ulp-v1-4-504115a53020@nxp.com>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
In-Reply-To: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 George Chan <gchan9527@gmail.com>, Simon Glass <sjg@chromium.org>, 
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 54750e7f-2492-47e7-0146-08de3c6def15
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dngvQTcybjdGUHVQSjdhazV1d2tTVGdqTFZnQWtjM29nSk5vOE1HOGgzUU1I?=
 =?utf-8?B?SHd0MUpDUVpqWWpZZ3RwNGFsVzRNN3A2V0hoTmdPVXc3dTRhbytYT3M2eGVI?=
 =?utf-8?B?WWY4MHZNdm1Kd3JWem1Ua0c1WFdNNXpnWmtuYUZZV2Z3NHhrNXNUdVNQZmpy?=
 =?utf-8?B?UEcxMUljZ09qcjJOS3lIeU5NdTF2TUZEYUZwMHdYK2tsMjFqYlNYZ3FwVDdM?=
 =?utf-8?B?QXJTY3RzbTBxZTNSSWd5Q0h3aldYR2RkT0F1L3BCVlo5ZlJTa2JLTzdOdERs?=
 =?utf-8?B?RHlsaWdpMUdBbENmQ0VFeG9oaFIxR0ZpSWUybDg4dVpPbms5VHZDV2lzenhX?=
 =?utf-8?B?a2lNQ1NOd2hhSncyVUQzNE1HUVFRS2dqNzNNVm84NmVqWEllTmxVUy9zVlBG?=
 =?utf-8?B?b0NuQkppaTl4K2VHcDhhTWZ6bTdrWnBRaHpaclBwSUFzOFR1UEpXZ3Zjc0Z4?=
 =?utf-8?B?UjVMeXg5bFBsQTcvbXVac0QyRW5NZ04yWWxPSkRaQU5PcE5tcTlDa213d3Nw?=
 =?utf-8?B?Z0RmU1IyTHBvazgrWXBZeVpqWDZPb3laYm5OeSsrNUZGeWhsa29aZktycVlt?=
 =?utf-8?B?SjREcldrRm9wc1o5V2QvcG1QVnBRR1B3SUtGK2pKUzN6QU05ODBTbXVvVlMw?=
 =?utf-8?B?aHpzTnY2N0lCd3orVG5PY2ZtOWJUZDg3Q0lrZFhDR0NuUFNBaE5yT2VZM2ZG?=
 =?utf-8?B?YTUzVDFYY2VGbnZUemRJMHlYbU10aDNYSC8xZ0RFcXJlMGJtNUZUdW40UXhN?=
 =?utf-8?B?WW1Lc245OGVRZWs2ekpMVGcrSUkzcnBSbjZvdGJSbTAvMjltU1VSa1NYWGpq?=
 =?utf-8?B?NVNkbEFOQXYxdmYvWlNEV1pNZnRZVldQYWlxWTllcEdTa0ZJVHVUUzNZSnVI?=
 =?utf-8?B?aWtiVWhmZ21yYmdzbDdNQU9WSVJDYUxDNGVITVpVK3pFVHRnWGNFMk9Laitj?=
 =?utf-8?B?ZkVCaUxDVWwzajBnUXlJZ2RteUU2SWIvWUhpWmdrblJpTFN6RGxCd043K3ll?=
 =?utf-8?B?RmZTZ1VzcnJJN21YZFkrSHBQT2VCZlhoMjhPYmdVYlNOZFM2QVZaRG5rZ3FO?=
 =?utf-8?B?a1lwMzk2WDNEbWRBaGV0dDZLUWFHZUtTb2Vod1F1UUtwUGpHQkVySjBwR0lW?=
 =?utf-8?B?Smo2b1hkd05YaS9JUjdxdXdDTHpzRmpMKzZySkk2NEJQdWt5ZEtXSmVwUDEz?=
 =?utf-8?B?S3g4bzhoRXhXc2NrVWk3dkpocVRCYjNlNldRVitoa2dhb2tNdnJDc002M0x5?=
 =?utf-8?B?N2RZMEw0MTFTY2xiR2R6WDFoZUh6enFXWXFXaXl5bWxvbU03R0FJV2NzeGwv?=
 =?utf-8?B?ZkZDeVAzcmw0THo2Mk5KVUI4S240MVBlVzNLd3crUVJQVU9nU1NyVzhSMitz?=
 =?utf-8?B?eXVEMjFDRVA3cUwvb0pDVnlaM2lSb3V2L2VEb3ZQZzF5OTZqYWRManZHUTU2?=
 =?utf-8?B?U0pVZnM3bnFadFljSmpKL0JtOW9iNnZlZjRUbTkyZ0d3OHlrWVR2ZlVqdkM1?=
 =?utf-8?B?Z0tETzF2Q1hoMFNEMnJ1NE1FbVFDeDVseDFuaDlVcXlTWWFPMUg4Vm1uUXlx?=
 =?utf-8?B?Ky96YlpPdnduakd3ZmpLYWFYeXR4RTIvUTRNT0FHdnRCYzhva2RWekpnMVZx?=
 =?utf-8?B?ak1EaERtb3I3a2hQb00yeWlLa2dYTWt6dno4aXB6WTNseTI1bVRDbEtnb1Ix?=
 =?utf-8?B?ZDZtVk1lc0ZZUFNWVWhRN3crWTlwUDUvSzRpY3p1UnJ4aVllS25FOXk4c2tu?=
 =?utf-8?B?UTZlZjVtY3pDeVZkZzV2eXM3d2VpN1BSQXMwaGlXbjlsdTNQMGZvUWd5T1Vj?=
 =?utf-8?B?eUNMOFVwZ2I2RFpNa3Jtc2hpK2JWZmY1MlQ5aWdtcFgyaW5YcFFNUDhrWUxP?=
 =?utf-8?B?eUI1cGFJN1RiN2xUa2NpdG5MczlUZytMczhzVUtaOThwQkZHejk1T2l5MWds?=
 =?utf-8?B?VXFiSlRLZDJuYzZVeWlKek1qWWVMNnZ5N1FSUExjK3pWUEs5dElhRC9Kc0FY?=
 =?utf-8?B?Z0lWSm9JWDQ3eUtrUmtnQ2NSbkRSNGRxZlVMbVdjdm0ydVNUNmFtSHV1bEUw?=
 =?utf-8?Q?cn5LRl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkROZlAzcGFWd2JVTjVJR2NGQTNIYnhGTmVHR1NRQVlVc2hCVnV0MDZzUTQ5?=
 =?utf-8?B?S2kyRFJsTjZxdWZMUDNucWZQN1NRbnBhd3VkQXVobXc0bVYzMkQ0eERORlJZ?=
 =?utf-8?B?VDFscFZlZ2ZmV3FvQmpzMWcyYzJDQS90OGJFUVl6MXdsU1RPSmo4MGZOSVhm?=
 =?utf-8?B?S1ZHUHNNYSt2M3ZCSyt5b0VJUHlFY1NQaTB0Z3orVHZrbWZxa0ZOTk9SRXF1?=
 =?utf-8?B?U0MwSEdrenFVUlJqRkptaXdZbUhzWXVyUHpjb0dneThjSWVpdlNDamhtMFRj?=
 =?utf-8?B?UEwrcUxSeW80bW1IWFFuM1ZQMnN6Zis3RGdFRWwycVEvWXFUWXBpdmxSUEhC?=
 =?utf-8?B?R2NwT1I1aWswaUhQQXY4L09DY2RWNlBSVkR0aWdPOEdQUmZzS1Z3bXNlU3h1?=
 =?utf-8?B?bDQwMUNUczRQM2lRcFNJRkxnSEZiRzJkanpkTVB6eVVpcExpQXJLbC9wN0NU?=
 =?utf-8?B?UW03dWRBNUdCaGkyTUlYZmNGdjNqRHBpb0k5eGprWU5raTRMcWF0cjU3clRJ?=
 =?utf-8?B?ZjlwS2Z2L1VDTWdSRzJORVpjNFA3YjM5K3Q5S0tKb3NWYWNRZjkxZE5pdVd3?=
 =?utf-8?B?RXNKLzlTNnQ3S1FyOE9seEEvVTBTVkVTLy95czVrUnFUMTltSzlwTEJDMDVM?=
 =?utf-8?B?NDlmRDk2VHdqUXk4ak1hQzVaNi95Qm1KVWRXbmdrY05MU1F2ajFGTSswQVkx?=
 =?utf-8?B?Q0N3M3VNM2czeU5DRExQRUNCTWJNY1JXdDFsTVBKSkxKdStCWisrMHVMVElE?=
 =?utf-8?B?SXNTdkdqeUk2MDc3QmRJQm54Tm00RU94Wmh2QVFxTlJUd2paYjJJTzlXREZw?=
 =?utf-8?B?SUwyMHJUcGhHSmRjbnlHRVFBaUdmRlpvNEhIWWllYkt3SDF6MkZkYndVNHox?=
 =?utf-8?B?VmxYL0FTMHBESndnak1BZC8yZlBsMWdBQ3ZPdDFQTkdvYkg3b1Z5V0E4Umx3?=
 =?utf-8?B?VFZyUnowZHpOM1JwU2YxQ0RoaVlGeXJndnRKbWd0VFNhR08vQlJ3UjNab0tJ?=
 =?utf-8?B?NklNdnZ6R2JNK3RFcGMwbHRXTmNtbUkxMm9XQk5YeGdUbm9ham5IUEFSeHRM?=
 =?utf-8?B?dXpickpZaVRNNjQ3T1M0dFM5SFJBS0wxMlozdWpHTkc0K2RmK05zQ2lKV3k5?=
 =?utf-8?B?ZXZlOXl5NCtLUFAzOTZseGxyMlhOS0hQREphajBicFJJU0pxS2JvK1IyWENV?=
 =?utf-8?B?dnNrdjNZUmczUkp4MUhnWWxmazJEOHQwNTQ0a3BnSTJIdmg4L0l5YXhXenRG?=
 =?utf-8?B?eG5KNGhOQ0Racmp2SUxLL1FCWWxFMWh6Vi9rUmQ2V2dvUDhaWTVrcE5NbEdD?=
 =?utf-8?B?V3BBV1R3eER5dTdSOUFuYlJJTDVoYkx6Z1BaQkZSbmgyc21pdURtNVUxNnM5?=
 =?utf-8?B?d0FkYjV4TWQrQXFXNmk0UEQ4YkFOSjl4TzFVTWtMQy9IZDlYQkFaRjUwQzFt?=
 =?utf-8?B?bC8zZzRTZlZxTDRkN1F0MjR6c3hSNFY0VlVNTHl4TXZ2bnN5WWtaNjdmSnBw?=
 =?utf-8?B?UU0zN21PME91TDAzTGJYdVdJb04xNVY5U2ZQZ2pDODB4am1vUjlveEFEdzNE?=
 =?utf-8?B?RHhzcU9ERnhveS92MHhGMnBJTnc2QldJY09MOVg0OVd0Z2VjRGhUaTlBeXky?=
 =?utf-8?B?ZFRqb3BWSGQzcjV2dmhVclAvSG1nWUZ4M0JlczF6V0RhaWE0dDNDdU1VRzlQ?=
 =?utf-8?B?ckRsdHR0TmFLcUNZTkpJTzJ3VmlOV1duZFJzRVBxZ0VCSEl2UFZ1eFdWSmtJ?=
 =?utf-8?B?Vy9RcFFtUjJiNXhydGVtZytPbEYxcEF3aHhKVVdUNTJFOTBjMVFXQjNEQWV6?=
 =?utf-8?B?N3ZCbk9hek5xZUNERjJZSFcxQ2JtMjA4TkFFVFU2WFV1eDk2MXFHWGQ5U0ds?=
 =?utf-8?B?VXA2SUV5ZWtlTU40bHJiMWlnQWRjY01jUURoeXBXV0FQY0cvWHpsM2MyZ2p4?=
 =?utf-8?B?K0Q5bWNDYlhoY0RyZUNrcnFZQ2Myb20vTC9BMVA4MjBWbGk3cERZK3BQWkRO?=
 =?utf-8?B?RUhzeXp3ekZKRUR6MG81a0lNOWhZby9RSTZOSnJKd2hpVytPVUhvNWVveWJy?=
 =?utf-8?B?Rm1sVjNJaTMvcXE2V3hzSmpTWU5XV0o0ek1BWlVVbHpOWUFHMWplb3JoakRl?=
 =?utf-8?Q?muCSsZ+hasleyDJIggn+dOmnM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54750e7f-2492-47e7-0146-08de3c6def15
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 06:39:59.5176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCQ/IJPTCBB9FfCgGCl0gjKzGFC0hfK650vrXF3XFdQH4qteufg4GhcrJhXAZygtlt4n8gq5fQZCStju1StD/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7794
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

From: Sherry Sun <sherry.sun@nxp.com>

Convert the ci_udc driver to driver model by using the uclass
UCLASS_USB_GADGET_GENERIC. The clk and power of USB controller and USB
PHY both are initialized by parsing the device tree nodes.

If CONFIG_DM_USB_GADGET is defined, we use the ci_udc driver in DM way,
if it does not defined, we can use ci_udc driver in its original Non-DM
way.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/usb/gadget/ci_udc.c | 352 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 348 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 4bff75da759..154a3ab7f22 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -7,9 +7,17 @@
  * Murray.Jensen@cmst.csiro.au, 27-Jan-01.
  */
 
+#include <asm/arch/sys_proto.h>
+#include <asm/arch/clock.h>
+#include <asm/mach-imx/regs-usbphy.h>
+#include <clk.h>
 #include <command.h>
 #include <config.h>
 #include <cpu_func.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/pinctrl.h>
+#include <power-domain.h>
 #include <net.h>
 #include <malloc.h>
 #include <wait_bit.h>
@@ -22,6 +30,8 @@
 #include <linux/types.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
+#include <linux/usb/otg.h>
+#include <usb/ehci-ci.h>
 #include <usb/ci_udc.h>
 #include "../host/ehci.h"
 #include "ci_udc.h"
@@ -93,9 +103,18 @@ static int ci_ep_dequeue(struct usb_ep *ep, struct usb_request *req);
 static struct usb_request *
 ci_ep_alloc_request(struct usb_ep *ep, unsigned int gfp_flags);
 static void ci_ep_free_request(struct usb_ep *ep, struct usb_request *_req);
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+static int ci_udc_gadget_start(struct usb_gadget *g,
+			       struct usb_gadget_driver *driver);
+static int ci_udc_gadget_stop(struct usb_gadget *g);
+#endif
 
 static const struct usb_gadget_ops ci_udc_ops = {
 	.pullup = ci_pullup,
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+	.udc_start		= ci_udc_gadget_start,
+	.udc_stop		= ci_udc_gadget_stop,
+#endif
 };
 
 static const struct usb_ep_ops ci_ep_ops = {
@@ -927,7 +946,7 @@ void udc_irq(void)
 	}
 }
 
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+int ci_udc_handle_interrupts(void)
 {
 	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
 	u32 value;
@@ -1072,6 +1091,19 @@ static int ci_udc_probe(void)
 	return 0;
 }
 
+bool dfu_usb_get_reset(void)
+{
+	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
+
+	return !!(readl(&udc->usbsts) & STS_URI);
+}
+
+#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+{
+	return ci_udc_handle_interrupts();
+}
+
 int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 {
 	int ret;
@@ -1125,10 +1157,322 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 
 	return 0;
 }
+#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
 
-bool dfu_usb_get_reset(void)
+static int ci_udc_gadget_start(struct usb_gadget *g,
+			       struct usb_gadget_driver *driver)
 {
-	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
+	if (!driver)
+		return -EINVAL;
+	if (!driver->bind || !driver->setup || !driver->disconnect)
+		return -EINVAL;
 
-	return !!(readl(&udc->usbsts) & STS_URI);
+	controller.driver = driver;
+	return 0;
+}
+
+static int ci_udc_gadget_stop(struct usb_gadget *g)
+{
+	controller.driver = NULL;
+
+	ci_ep_free_request(&controller.ep[0].ep, &controller.ep0_req->req);
+	free(controller.items_mem);
+	free(controller.epts);
+	return 0;
+}
+
+struct ci_udc_priv_data {
+	struct ehci_ctrl ctrl;
+	struct udevice otgdev;
+	struct clk_bulk		clks;
+	int phy_off;
+	struct power_domain otg_pd;
+	struct clk phy_clk;
+	struct power_domain phy_pd;
+	struct ehci_mx6_phy_data phy_data;
+};
+
+static int ci_udc_gadget_handle_interrupts(struct udevice *dev)
+{
+	return ci_udc_handle_interrupts();
+}
+
+static int ci_udc_phy_setup(struct udevice *dev, struct ci_udc_priv_data *priv)
+{
+	void *__iomem addr;
+	int misc_off;
+	struct udevice __maybe_unused phy_dev;
+
+	priv->phy_off = fdtdec_lookup_phandle(gd->fdt_blob,
+					      dev_of_offset(dev),
+					      "fsl,usbphy");
+	if (priv->phy_off < 0) {
+		priv->phy_off = fdtdec_lookup_phandle(gd->fdt_blob,
+						      dev_of_offset(dev), "phys");
+		if (priv->phy_off < 0)
+			return -EINVAL;
+	}
+
+	addr = (void __iomem *)fdtdec_get_addr(gd->fdt_blob, priv->phy_off, "reg");
+	if ((fdt_addr_t)addr == FDT_ADDR_T_NONE)
+		addr = NULL;
+
+	priv->phy_data.phy_addr = addr;
+
+	misc_off = fdtdec_lookup_phandle(gd->fdt_blob, dev_of_offset(dev), "fsl,usbmisc");
+	if (misc_off < 0)
+		return -EINVAL;
+
+	addr = (void __iomem *)fdtdec_get_addr(gd->fdt_blob, misc_off, "reg");
+	if ((fdt_addr_t)addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	priv->phy_data.misc_addr = addr;
+
+#if defined(CONFIG_MX6)
+	int anatop_off;
+
+	/* Resolve ANATOP offset through USB PHY node */
+	anatop_off = fdtdec_lookup_phandle(gd->fdt_blob, priv->phy_off, "fsl,anatop");
+	if (anatop_off < 0)
+		return -EINVAL;
+
+	addr = (void __iomem *)fdtdec_get_addr(gd->fdt_blob, anatop_off, "reg");
+	if ((fdt_addr_t)addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	priv->phy_data.anatop_addr = addr;
+#endif
+
+	dev_set_ofnode(&phy_dev, offset_to_ofnode(priv->phy_off));
+
+#if CONFIG_IS_ENABLED(POWER_DOMAIN)
+	/* Need to power on the PHY before access it */
+	if (!power_domain_get(&phy_dev, &priv->phy_pd)) {
+		if (power_domain_on(&priv->phy_pd))
+			return -EINVAL;
+	}
+#endif
+
+#if CONFIG_IS_ENABLED(CLK)
+	int ret;
+
+	ret = clk_get_by_index(&phy_dev, 0, &priv->phy_clk);
+	if (ret) {
+		printf("Failed to get phy_clk\n");
+		return ret;
+	}
+
+	ret = clk_enable(&priv->phy_clk);
+	if (ret) {
+		printf("Failed to enable phy_clk\n");
+		return ret;
+	}
+#endif
+
+	return 0;
 }
+
+static int ci_udc_phy_shutdown(struct ci_udc_priv_data *priv)
+{
+	int ret = 0;
+
+#if CONFIG_IS_ENABLED(CLK)
+	if (priv->phy_clk.dev) {
+		ret = clk_disable(&priv->phy_clk);
+		if (ret)
+			return ret;
+	}
+#endif
+
+#if CONFIG_IS_ENABLED(POWER_DOMAIN)
+	ret = power_domain_off(&priv->phy_pd);
+	if (ret)
+		printf("Power down USB PHY failed! (error = %d)\n", ret);
+#endif
+	return ret;
+}
+
+static int ci_udc_otg_clk_init(struct udevice *dev,
+			       struct clk_bulk *clks)
+{
+#if CONFIG_IS_ENABLED(CLK)
+	int ret;
+
+	ret = clk_get_bulk(dev, clks);
+	if (ret == -ENOSYS)
+		return 0;
+
+	if (ret)
+		return ret;
+
+	ret = clk_enable_bulk(clks);
+	if (ret) {
+		clk_release_bulk(clks);
+		return ret;
+	}
+#else
+	enable_usboh3_clk(1);
+#endif
+
+	return 0;
+}
+
+static int ci_udc_otg_phy_mode(struct udevice *dev)
+{
+	struct ci_udc_priv_data *priv = dev_get_priv(dev);
+
+	void *__iomem phy_ctrl, *__iomem phy_status;
+	void *__iomem phy_base = (void *__iomem)devfdt_get_addr(&priv->otgdev);
+	u32 val;
+
+	if (is_mx6() || is_mx7ulp() || is_imx8()) {
+		phy_base = (void __iomem *)fdtdec_get_addr(gd->fdt_blob,
+							   priv->phy_off,
+							   "reg");
+		if ((fdt_addr_t)phy_base == FDT_ADDR_T_NONE)
+			return -EINVAL;
+
+		phy_ctrl = (void __iomem *)(phy_base + USBPHY_CTRL);
+		val = readl(phy_ctrl);
+		if (val & USBPHY_CTRL_OTG_ID)
+			return USB_INIT_DEVICE;
+		else
+			return USB_INIT_HOST;
+	} else if (is_mx7() || is_imx8mm() || is_imx8mn()) {
+		phy_status = (void __iomem *)(phy_base +
+					      USBNC_PHY_STATUS_OFFSET);
+		val = readl(phy_status);
+		if (val & USBNC_PHYSTATUS_ID_DIG)
+			return USB_INIT_DEVICE;
+		else
+			return USB_INIT_HOST;
+	} else {
+		return -EINVAL;
+	}
+}
+
+static int ci_udc_otg_ofdata_to_platdata(struct udevice *dev)
+{
+	struct ci_udc_priv_data *priv = dev_get_priv(dev);
+	int node = dev_of_offset(dev);
+	int usbotg_off;
+
+	if (usb_get_dr_mode(dev_ofnode(dev)) != USB_DR_MODE_PERIPHERAL) {
+		dev_dbg(dev, "Invalid mode\n");
+		return -ENODEV;
+	}
+
+	usbotg_off = fdtdec_lookup_phandle(gd->fdt_blob,
+					   node,
+					   "chipidea,usb");
+	if (usbotg_off < 0)
+		return -EINVAL;
+	dev_set_ofnode(&priv->otgdev, offset_to_ofnode(usbotg_off));
+	priv->otgdev.parent = dev->parent;
+
+	return 0;
+}
+
+static int ci_udc_otg_probe(struct udevice *dev)
+{
+	struct ci_udc_priv_data *priv = dev_get_priv(dev);
+	struct usb_ehci *ehci;
+	int ret;
+
+	ehci = (struct usb_ehci *)devfdt_get_addr(&priv->otgdev);
+
+	pinctrl_select_state(&priv->otgdev, "default");
+
+#if defined(CONFIG_MX6)
+	if (usb_fused((u32)ehci)) {
+		printf("USB@0x%x is fused, disable it\n", (u32)ehci);
+		return -ENODEV;
+	}
+#endif
+
+	ret = board_usb_init(dev_seq(dev), USB_INIT_DEVICE);
+	if (ret) {
+		printf("Failed to initialize board for USB\n");
+		return ret;
+	}
+
+#if CONFIG_IS_ENABLED(POWER_DOMAIN)
+	if (!power_domain_get(&priv->otgdev, &priv->otg_pd)) {
+		if (power_domain_on(&priv->otg_pd))
+			return -EINVAL;
+	}
+#endif
+
+	ret = ci_udc_phy_setup(&priv->otgdev, priv);
+	if (ret)
+		return ret;
+
+	ret = ci_udc_otg_clk_init(&priv->otgdev, &priv->clks);
+	if (ret)
+		return ret;
+
+	ehci_mx6_phy_init(ehci, &priv->phy_data, dev_seq(dev));
+
+	if (ci_udc_otg_phy_mode(dev) != USB_INIT_DEVICE)
+		return -ENODEV;
+
+	priv->ctrl.hccr = (struct ehci_hccr *)((ulong)&ehci->caplength);
+	priv->ctrl.hcor = (struct ehci_hcor *)((ulong)priv->ctrl.hccr +
+			HC_LENGTH(ehci_readl(&(priv->ctrl.hccr)->cr_capbase)));
+	controller.ctrl = &priv->ctrl;
+
+	ret = ci_udc_probe();
+	if (ret) {
+		DBG("udc probe failed, returned %d\n", ret);
+		return ret;
+	}
+
+	ret = usb_add_gadget_udc((struct device *)dev, &controller.gadget);
+
+	return ret;
+}
+
+static int ci_udc_otg_remove(struct udevice *dev)
+{
+	struct ci_udc_priv_data *priv = dev_get_priv(dev);
+
+	usb_del_gadget_udc(&controller.gadget);
+
+#if CONFIG_IS_ENABLED(CLK)
+	clk_release_bulk(&priv->clks);
+#endif
+	ci_udc_phy_shutdown(priv);
+#if CONFIG_IS_ENABLED(POWER_DOMAIN)
+	if (power_domain_off(&priv->otg_pd)) {
+		printf("Power down USB controller failed!\n");
+		return -EINVAL;
+	}
+#endif
+	board_usb_cleanup(dev_seq(dev), USB_INIT_DEVICE);
+
+	controller.ctrl = NULL;
+	return 0;
+}
+
+static const struct udevice_id ci_udc_otg_ids[] = {
+	{ .compatible = "fsl,imx27-usb-gadget" },
+	{ }
+};
+
+static const struct usb_gadget_generic_ops ci_udc_gadget_ops = {
+	.handle_interrupts	= ci_udc_gadget_handle_interrupts,
+};
+
+U_BOOT_DRIVER(ci_udc_otg) = {
+	.name	= "ci-udc-otg",
+	.id	= UCLASS_USB_GADGET_GENERIC,
+	.of_match = ci_udc_otg_ids,
+	.of_to_plat = ci_udc_otg_ofdata_to_platdata,
+	.probe = ci_udc_otg_probe,
+	.remove = ci_udc_otg_remove,
+	.ops	= &ci_udc_gadget_ops,
+	.priv_auto = sizeof(struct ci_udc_priv_data),
+};
+
+#endif /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */

-- 
2.43.0

