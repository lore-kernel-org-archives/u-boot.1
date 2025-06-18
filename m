Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43268C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AFB182D6F;
	Wed, 18 Jun 2025 09:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tXq3+Nsp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF25382D6F; Wed, 18 Jun 2025 09:30:47 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C408E82D39
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LexVi+mNyFxMJa6DMUEIpFmDqGwnz97kXovwrNlFAgJxb39Xek63zsnAkvAwAi0RhVHS3Dpvy6gTvAsNKsHHtwMhePPmXqdfrJxLDVWj7Zhh8ODWXsTHIXGW9MK0gN2GdpCmNOLub7zuyhs/IvZiTwVEm1RYlpJ1wNgKzBQcN9z3LPomCofaOT57SDQbQsIqJv6aH8+p9GYO33Vl96kI4hhbjAKmYF8b4BVAONFf860VmpxZUqYRWgf1RKyS2b5Q4JK06ocfdseUn6nSxWEHwYEsorIXWCOvF+Oik8W0dN/8ef1F005lydPC8hWozTJQfWUuMg0WJGXNey31QFzS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmlLLq5kKg1X/crfKLZU2Rhc/24uxOnAPWxEX2i5wuI=;
 b=j1zQUV3J7q7x+jVxSrFUyJ/sZfpyFg7flzhONJxqCvtwd9P7pTvovqjem9DkQ9I+MfLNKEFbzZ/JzXp11fnrc7kIg4ZJ0ZGFDPY+9cRs435FofDGr5kIBXyPmcNdbdQ4aF1/ON28Jo3Vv6SaYIbQoXaksdGldKuTbSSomLCwmwjl0uLobXjEY8TQ3SYPBCy1wfPv+OWPkrg2rq8n65mWO2dcCsKnlNH/HmUmkWD1SmAWzrWLaz5Aq0F7WxxuhgHJyjCCHf00DHGBYPyznDeVqZ5O/hhJkf3g6Qy9UCQMWDWBOHov1hpGE/+dgHP/1CLBdZJVWagfrxxUsYmSal7nCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmlLLq5kKg1X/crfKLZU2Rhc/24uxOnAPWxEX2i5wuI=;
 b=tXq3+Nsp5KyJjDwrsNdG6TlADN9xlqnbBfKTE9HonF5xo0mPJJSS1TrYJBuSP2qz6B3ASpmOcStEA0kcolcRzv7me5K40OQNRIJV2z1rZXVAPYAiSZWa5z3P90uH3BR2oExFdizV4gLwSsFrzSp/z15Js4ib0FWmsMRzda4NtIx+k5UA2V5yZvBdM54Yk3iR2ExSqsstBSDAKCKEb6zmyiq9Sb1CQiBbSicGlFezuUl2h4GRU7BNFQP1PEkCx3gI9OQnKyoV6WwhKtuiCEESGaF+XOu3cmMzbL+REbdnlE6AejPdPrAWrkjRXFvRPKWOGazPMEye/PQ/Vs5URiV8XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10928.eurprd04.prod.outlook.com (2603:10a6:800:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 07:30:42 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 07:30:42 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 18 Jun 2025 15:30:20 +0800
Subject: [PATCH v1 7/8] spl: imx: Add support for new PQC container
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-binman-v1-7-373e66c7a51f@oss.nxp.com>
References: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
In-Reply-To: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>, 
 Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10928:EE_
X-MS-Office365-Filtering-Correlation-Id: 032aba16-6fe2-4177-fb21-08ddae3a07ae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVppRC9RMXVRQzZGOGtQK1E3d3pnSmlpRmt4YkN2bEdEODRHL0RsOWRvQ0pV?=
 =?utf-8?B?dmFaN3A0SmQ0SkNSRStuT2hrLzErWXRuUmpkUFZYQkwwa3BrZmN2QWRRMENW?=
 =?utf-8?B?SlBUSXl0d25HdExSMTU5TlRFNnFkbFNoOStHZnFZSjlSMWxmTEVUeXpGem5P?=
 =?utf-8?B?dS9Lc2U5WWpDSmtlbEsxQUl4SDdEK2ltdGpZNU9xMllMV2FTdHNlQTlTQjdM?=
 =?utf-8?B?T0xUY1U2bHB6L0VQSEhybkNvdGNtN1R0OHplL3dWWTlLSFczSWh3bzhwVEF1?=
 =?utf-8?B?MndCNGJLc3VWaFB4eEJOeU1PcFg3S1pISkI4UWJBa3BTWWh3MHpUZEFYSVdI?=
 =?utf-8?B?b1FwNExIek94aVUzbHZHell5R29ldGdiRWVmcFhMd004elVjWnpRK0JvQTFo?=
 =?utf-8?B?VWMxQ29nUTNmT3dSK043enFZSVVYQmd6dExnZzZyczdkQTJGa0lCZ1VnMmVi?=
 =?utf-8?B?a2tWNWgzUHdLRFhoNUk1d2NRbFNiQ2JDYlJEVEpaUTc4eVVsajY0ajc4OUVR?=
 =?utf-8?B?S3dFV1A2ekc1Z0RmWXJCcEJLWUFlZWJoSitSenZZT3Z6SWVMdkJqVmFuMnRh?=
 =?utf-8?B?cmxZZXdNYXI2UVhVbnZXejVldTF0R0piTjlpTFk5cWsvVGx3ekJtdUhGWjdU?=
 =?utf-8?B?Ny9wejFpdU5EZ2RlRTVPbU03OWNjSmNwV2ZiUDdYdHpVajIybS9nWW10cHcv?=
 =?utf-8?B?MXJ5cU5vWEVBeThpRGtTNHEwbnJ1L1JSTmhZTUY2RTNuSnFwNmF3WFhacXA2?=
 =?utf-8?B?QzIySGJCQ0RscTRQOXF3cHNXV1N2MHN5RENKK1l2cmxRMC8vOXY3MjJTa1Q2?=
 =?utf-8?B?NjFhSitHMkI2bEhaOXQ3RVNwdjZMbGZWa3krZFB6N0JMV2NscnRoZ3ByelVL?=
 =?utf-8?B?WVB4OUJEdU1BMHhyUDJVRmk3RGM1RDJHdjFvak41Ti9LaVU4NG1rMGI1VDlh?=
 =?utf-8?B?SlI5Y1dGNVl0THBwQ0svb05xakpUbnRsa0lPUzdrVkg1b2IwV1JBRzNGVzJU?=
 =?utf-8?B?Qnc0YmhCUnJlbFBxZVIwclZXVklnVmRWMk1XKzVwdDF0QU14dTBmWUN6ekNN?=
 =?utf-8?B?ekZxNnNmM3cyM1BYU013M2hSNldRZ2QyZmt4NHc5Q2ZUMlRNUDRjY1dhU3Np?=
 =?utf-8?B?QVIrVHRLWUZnTkRMNXVwa0lJU3FVeDB5azlsVHNOdCsxTFkwVGtCOHU2bkJU?=
 =?utf-8?B?eDBjWjFONW1LY2x5ZDFST3BEelYxV0ZrYkNGSk9CcnFNRG5oU2NodCt0WE5o?=
 =?utf-8?B?ZjMxZE1sOWx1bUVOV0NGU0YwNXNiaHVrcGVEeURQOXdVeVFQZnBDL0Jtc2tY?=
 =?utf-8?B?N1RxcEN0MmhwaUErVXIrUy92a1lCcko0cTVkS2RNU0Y3STNPc0JWYUw3WVNa?=
 =?utf-8?B?QWNKZlJJUGVWZ2RrMXRpeTBBRVVOWElNNzhrd3J5cjV6WWY4bnVLT0xSN25O?=
 =?utf-8?B?RjM0TjhtV3FjUWJmaGRoNUFrL05jekp6UnpMRkw1VlZ3Yk9HYS9aN1ZvQ0VI?=
 =?utf-8?B?QmxrS3dDNm9NbEZsSGpRZ05NSVJRMXhITGdYTmhzYXRVR3VxSEE4ZkxLNDdQ?=
 =?utf-8?B?T0dJNmkvVkVjVlNuNUxSRXQzRzRCRjBBd0NnTDdMNDFWWkRJSlNidXhoVFh6?=
 =?utf-8?B?ZCtOUW5UYzYwS1VzMEd4ek5xaWIrQXEwRzNDWWFnaXVCQUlwc2NBWUpFV1VM?=
 =?utf-8?B?WGNJdnJoY010RUl5V3l1OUxFN2paOWR3V0xMQjBHM1lDOXN1TnVvRnVKNHlH?=
 =?utf-8?B?cDZwV0xTUmpvN0ZwczFZUyszWVNoOFA2RmFDdFV5OFlGL0FOMW52b1NNVnJk?=
 =?utf-8?B?dDFzOUVtMFFqN0pXOC8wejRlYXVDQ1ZnS3RPbUxrbVd0VXpDQk80Uk00TkRj?=
 =?utf-8?B?cEpybnB5cFRtdlpRYi80T20vay9GTm5OWUI0M21LRzVPZ2Ria2I3OG02TzB1?=
 =?utf-8?B?YmYzSys5MVVNQXFYYStSN3N6Z1FxUzdXSjJqVHBwQnNuVncvTDYveHd3L1pB?=
 =?utf-8?B?YjNJcmJVODlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWpPWnFDZ0RnWGQxYU1Ma2ZodHp3RklrZ0c0dHFtamhTYTFQajhzejZ0a3FP?=
 =?utf-8?B?TzQ4RzZ4ZURZTG02akFPNmdWd1Bla2c4dkh1d1ZwYU13and6VmE2L2t0bFhs?=
 =?utf-8?B?TlMxY0Fwa0c2VDVJWHpWUDUzYi9RbTRtdFo2QmVCMWxWMFMzZ3k0UXJ4cjBB?=
 =?utf-8?B?eHZTZ3JuOGVRc2Q1MklCVEdtQTVEODlUT3BZTVlVRW9BYUlYZzV0NEVVNFpE?=
 =?utf-8?B?b2dIRFFTTzgyUy9CeHVqTURtODgyNlhla3RTcE9OOVAvWko4UVlNNnBLTm9m?=
 =?utf-8?B?UVh4d2pJUjB0T1l6eHNGSnBQQUtMcGIwaVJaUENoZUYyRmEvNmxxVHZQaTFm?=
 =?utf-8?B?UGFvV2Uyamo5N1pTODVVNXJPUVZwdHR6R3BzV0NyZjJuUFQ5cDFwajFCTE5C?=
 =?utf-8?B?dllXcHpUeEJmZ2lBUlJkdHNQb25mSGxGMHV4ZWxneUQyQjZ0c1VBampCZkVS?=
 =?utf-8?B?ZTl1MzBlT1l0djZMNmVTcTF2ZHZyd1FtekhuSDJ3TXBNUEFEeGdTd1NqbU8x?=
 =?utf-8?B?azR0a0V3d21DSStWa3N4bCswL1hOSDhicng4cnRlL0xsT0ZBMmFTSHNkSHZP?=
 =?utf-8?B?OXZER1VsSkRDMEd4S0xWWENuU3ZHNDVLSnZEaW84eitqSzhpcEhnODhEVFlI?=
 =?utf-8?B?UU9jSUpWbCtObnAzZ3pOTEpDdDEzVjJqWlAwMlJDYzUrc1pKOFJnQmNEUE1W?=
 =?utf-8?B?MlhxaHZQdFg0N2NIc3Jobk9aeUU4azRBWElYTU5leWhtbEZEb2tpUUtuWXZU?=
 =?utf-8?B?dkgrdis2Rmt5VE1Oc3VZN29Ub1MwdlA2UjI3TWxEUkl6WjhQZmM3YWJqTUtP?=
 =?utf-8?B?YWt6S0UzL3dmWHd5ZUYzNWxtVGdMSWwyRkNjZGh2TzdnRkNFVm5LRWNkb3U5?=
 =?utf-8?B?L0d1NDRyL3d6YlRIaTNNS1hZQVd5MzBoa00yM3JYc2Q2U0EyQmR6RmxCQ1Z4?=
 =?utf-8?B?dVEyYWJFU0xqU2JaVENkMUxWTmR5MEs0RG9kZkozS1J2TWpHNm9hTkJGMHd0?=
 =?utf-8?B?ak1haEtGZ2xkdWs5SFdNaVNLcFlneUI2bE9ZbUtwY0dxejlBVllOYkR1QUdO?=
 =?utf-8?B?UzZhUTZvalVyNkQzYXZLblhKS0pXMGFjZlVFZnlydHVpNHowRjZCTDhMNlA3?=
 =?utf-8?B?dU1HQ0pIbTVPKzlnM2p3ZXBPKzdYcTNUN29hQkxiS1Rjd1JxR1BmUmV4ZXRp?=
 =?utf-8?B?VE5PTFlFUVR3WnpLMEVpb3o3TStsNkY3R2tLdythTGRrL2h6b2Z1ZWM1aHpu?=
 =?utf-8?B?SVFDTTJMTWIzcUZ3Vi9jWXR3Vi9uZ1k0dzZmWnBTVFFMWXBlc2JjTVd0U21X?=
 =?utf-8?B?aFBrM2JXaTZ3dDFjK3V1c3VtU2N4VTJiN0RCcnJrT2M4aDJPdUR6RlBBZDFv?=
 =?utf-8?B?R1QrYm1VQzhTSFlzM1d4YTJxUzVNV01lSUZVZTFyTE1nTlk4TmdnWkpGZThN?=
 =?utf-8?B?K1d6NHEzOEVIRVlLYytqYURjb0RpdlJwdWtYclIrQTBnN2Vja0F5WWJqemNX?=
 =?utf-8?B?NTdVcjhJUXQ1UC91TkxSNHQ3dlcyMC9FbWtXbGRzMnAzVXZpRlkwM2RQY2Mv?=
 =?utf-8?B?S21xZ1BpK1J3Yk5PcmlvQjF2ME5jWFM2Y0ZvbHR0TlhEMmVnQVUwOGgzd2dT?=
 =?utf-8?B?R0wrY3B4bVFiS1BRdTlKaWM2RHB6Ty9TL3l0ZFQrcHBCdm9kTGNYV0t2RnVO?=
 =?utf-8?B?WUVqc2tocnhhN2FQNjBoODZwRThOTENVN0s0M1lxeXZwMjdjQmZzN3hneXR5?=
 =?utf-8?B?YW9rZWhkMy9SU29hME5nS1duY2swSEJKTXhHZVZabWdLb093b3B3R2VvczR1?=
 =?utf-8?B?TVFFWWM3L1B6ZEQxckUrY21ET3NsUndQSkVzbzN4R1lmR2pjeFQ5Rm4yYWFJ?=
 =?utf-8?B?WjJMRDFyOG9GcGUxZ2NrTElSbTArWU1qSmRNcWV2RkRGV2pOQStKa0x6MXlQ?=
 =?utf-8?B?c1hIK2pvQWFsTEkyUk5yMmVtNW9Wc25WaFVlRTN2R1NYbUVBVlFrRW5iUDBP?=
 =?utf-8?B?eFc0SUJObFVBenZrN0FpNktoRG1QZURTblZYY1A4R3BkeVFhRHk2YXBRVGRT?=
 =?utf-8?B?RGhDNlZ3ZnZwRC8rb0gyTnhqZGVqUWtLOHlkcWkvU0JVQW5CZ0xja1RWY3Y4?=
 =?utf-8?Q?HiCnOfV4VZST175GuECYZS+uC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032aba16-6fe2-4177-fb21-08ddae3a07ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 07:30:41.9612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAxsUKxYsfpe2ZDY2iUluVvciuQCD8qjQSQeOm1F78QBpq+YvQXHmP1I3scw3ooOlpKe2YGDiY6racScz0WyRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10928
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

From: Ye Li <ye.li@nxp.com>

To support PQC container format which is used for post quantum
authentication on new i.MX parts like i.MX94

The major changes compared to legacy container format is in
signature block, new container tag and version, and new alignment
of container header.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/image-container.c |  2 +-
 common/spl/Kconfig                  |  7 +++++++
 include/imx_container.h             | 11 +++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index f84e23f4b2a..3a9e6dcf225 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -66,7 +66,7 @@ static bool is_v2x_fw_container(ulong addr)
 	struct boot_img_t *img_entry;
 
 	phdr = (struct container_hdr *)addr;
-	if (phdr->tag != 0x87 || phdr->version != 0x0) {
+	if ((phdr->tag != 0x87 && phdr->tag != 0x82) || phdr->version != 0x0) {
 		debug("Wrong container header\n");
 		return false;
 	}
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 77cf04d38ed..5d2e0b4ec4b 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -370,6 +370,13 @@ config SPL_IMX_CONTAINER_USE_TRAMPOLINE
 	help
 	  Enable SPL load reader to load data to a trampoline buffer.
 
+config IMX_PQC_SUPPORT
+	bool "Enable to support i.MX ROM PQC Container"
+	depends on SPL && SPL_LOAD_IMX_CONTAINER
+	help
+	  Support i.MX ROM new PQC container format. If your chip does not use
+	  PQC container, say 'n'.
+
 config IMX_CONTAINER_CFG
 	string "i.MX8 Container config file"
 	depends on SPL && SPL_LOAD_IMX_CONTAINER
diff --git a/include/imx_container.h b/include/imx_container.h
index 691c764b3e5..684fc3bc988 100644
--- a/include/imx_container.h
+++ b/include/imx_container.h
@@ -12,7 +12,11 @@
 #define IV_MAX_LEN			32
 #define HASH_MAX_LEN			64
 
+#if IS_ENABLED(CONFIG_IMX_PQC_SUPPORT)
+#define CONTAINER_HDR_ALIGNMENT 0x4000
+#else
 #define CONTAINER_HDR_ALIGNMENT 0x400
+#endif
 #define CONTAINER_HDR_EMMC_OFFSET 0
 #define CONTAINER_HDR_MMCSD_OFFSET SZ_32K
 #define CONTAINER_HDR_QSPI_OFFSET SZ_4K
@@ -72,7 +76,14 @@ int get_container_size(ulong addr, u16 *header_length);
 
 static inline bool valid_container_hdr(struct container_hdr *container)
 {
+#if IS_ENABLED(CONFIG_IMX_PQC_SUPPORT)
+	return (container->tag == CONTAINER_HDR_TAG ||
+		container->tag == 0x82) &&
+		(container->version == CONTAINER_HDR_VERSION ||
+		 container->version == 0x2);
+#else
 	return container->tag == CONTAINER_HDR_TAG &&
 	       container->version == CONTAINER_HDR_VERSION;
+#endif
 }
 #endif

-- 
2.43.0

