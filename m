Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8FFCCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 04:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D5AD83C6D;
	Fri,  7 Nov 2025 05:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lUSPZEOJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A7583C08; Fri,  7 Nov 2025 01:39:59 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3285D83BDD
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 01:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWjXEdort0wqj+0KJqO0YOfmh5V20zthGsV92y22+ydTH1cF7DJrSCmucWzuN3Ka/0W5dpJKjhDkvfzrXWXv3wrYc2S9tIuLkt4b14ABGnzkoalHJ6UMJn76yXT6Nf8J3D1R/etG8VhF1WnLlAP9wgdihRSlrIk5ZMTNHlvZhSAgPxUqLmpHWZLtHZ81YwNFjnaWZ8Wep8UX/7bJ6AcxrzPUsHi7T3a57aoIBs9zSvW0p/KHtR9hdqr/7lNkyPoKM366pwJaj5XakLe8hHxLj2ZXtlp+RujvgroNRyh3jkakCa1VsWAdKVue6847XUkAp4XHoOZTCXIRPaSfC67n1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQ1vGFbrV6wlOR1Eh9sWQnSiNKErdSy4q9X9Na8bMrc=;
 b=JbkAR5+V4pSdOXCFcb/knr7fFWpYBKYVaBpFhnzkPuvhbhpI+UisfrTV1sF1ELguS11iDonRgdixj7E5DznaH4hf33ZVfraZiIMKGsLThGy1b+QnRfP7Awbp0rZ7Gci8ciYIfbgfZIw7uENSzrm6l/3TBrm4ksdVMP1XHZCQAI6C/CjSMV9Hbt5ZglyELClOx/shE+WrpR9bkmCNTOcKZ8nTlF/guSiksa8ASlbiiWVKz7VYS4a2DUQ1BPGIwkev/ElKSu2+PZ/giK9A17BaqBu8puuFiFyMsbBsxFeqTJ53+OudS6snRAPPuilYusk1xuM9T5ID1/dsTtk2RSE2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQ1vGFbrV6wlOR1Eh9sWQnSiNKErdSy4q9X9Na8bMrc=;
 b=lUSPZEOJGypW6zdz1c2m1cM0rPFmQ5ouUll/cJGn8KReAkcJPsPLRX7EWr/C+Mdz4HKsopgIIMxl7ys3oOqzqimnSHVmg4gVlbYCzWiDZ6Geoc8S54ehEeT3GqziMHxr+edcReKaaKybOEiDiDaVE/zED9k8fUsth696RBPUKPFMB5lojSqO4rq+kVGEqQDuZOs/ky1HHXSrjop4ESO76Ppo36JVGaQrpzhnCGQMGfH+eqLhfgUAnCMuo+KRxj/UBP+D4iuj7VVpBDBylIjoPNOrh3HdFetQQXEc+Dkmp+QZZT2rLsAjtCUhFXo4k3SXbmCHLYCcdy5A7Beb3sKRsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8398.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 00:39:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 00:39:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Minkyu Kang <mk7.kang@samsung.com>,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Kaustabh Chakraborty <kauschluss@disroot.org>,
 Simon Glass <sjg@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Lukas Timmermann <uboot@timmermann.space>
Subject: Re: [PATCH 0/6] mmc: exynos_dw_mmc: Disable FMP for Exynos850
Date: Fri,  7 Nov 2025 09:52:15 +0800
Message-ID: <176247978655.799411.13821530298297772450.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026010658.19271-1-semen.protsenko@linaro.org>
References: <20251026010658.19271-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: 534001e1-07c5-49b5-95c5-08de1d962bb6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEsvOUFIaEtwdmVBb3k2K2N6QlVEQVZJNzV1dmU5WnRvVHhDSkRneEZjN2E4?=
 =?utf-8?B?aXZtQjlQU3laSkgwbHh0L2p0Y1NiT0pSZ082aVprUldPZmlpV1FQQXZTd2x6?=
 =?utf-8?B?U2VFMXoyaDlVR3BXYWpTdUpzY29IM3NweHFNQUZObVFVdVdmRzhCTE12ZG9S?=
 =?utf-8?B?dmcrb29CS0ZvWEhRT0ZMcFNmTlcwSG9qUC9hcHZ2aEZ0amQwNitaRExyWjlS?=
 =?utf-8?B?c0sxdlNQZlo4bTZURm9kSkozUU1Ic0NpYTg4blVVbi82VFcyRHJ2UnB5VDZ0?=
 =?utf-8?B?Tmp4ekdQcWU4dGlVZFlrT1EvNVVMU0R6SEc0dUkwclNsUDREVVhJY3BxTG50?=
 =?utf-8?B?VmExWUNiTGR5UVRuRkF4bHg4YjMyWVVhbHRHYlZ3ODNlKzdGNUU1bXc1emVM?=
 =?utf-8?B?b09oWWV3aXY3YXM0SmVieGpsOWE4Wk4xSGozMnpUdHMyNzJLN0I0MkZBaVFW?=
 =?utf-8?B?aGtlbVFTeXJoWFhIK1pXSVV1SEJtVXY5bTNIWkwwY0NGMzA5a3ZGM2ZJWWFN?=
 =?utf-8?B?WkRQNmFpRVE1YmRXSjhKQStIL3JWQnZ4TEpjQTRmSlVUVmJza0xPSVFxYzJz?=
 =?utf-8?B?RUdod3pacXJyQ0hnaHZ0RUx3MnRyQUM5QnZuZS9DeE5WSXVlMkQ1aEgrdkYv?=
 =?utf-8?B?V0tKRUUvTFIxeTJYUkRaUUlOb1RyUmNVVHF0emQyaTZUblgvYXl1SUV2Z2dG?=
 =?utf-8?B?cFJETjJBRXhHSnhLYjNHMThKdVdOWUtJL0oySVVFdXFrVVJFYWFsSzN1SlpT?=
 =?utf-8?B?Q1pIWFZIenA4c1l4K2NKU3BYVmMxM2E3aVh5NTNXNlFpTEpWRXZBTWlGTlhj?=
 =?utf-8?B?L0c3dkhvdkI5Z0cvMWVpOVl6aERENXFVYlFBVklwYlFKWSsxWTJkOU1qemFo?=
 =?utf-8?B?ZDFQcUE4dDVQNmNkZWFua2swdzlGaTI2NkVOODhFdjJCTGU1Y3VtczlUWjMz?=
 =?utf-8?B?aVc1TzJRVmlia1pqVDR1bXpPemRjTkk2VCt4R2pvcFZvN2s5aG1NMXhxay9y?=
 =?utf-8?B?WEFXQ25qL1owT2UxV2ZkSm9WcXBGNnJVKy9FQ3RxSG4ycm1rdTR3ZWYxZmtQ?=
 =?utf-8?B?WXJ2N2d3MlhJL3FuckNXTnFmUmVZcko1NmQyeDFRb2xFMzN2cVVPYkh1YzRQ?=
 =?utf-8?B?Smg2YmFCWGJrWlozTm5PNnFDR2VncTh3dVZDa0hMcVhhNXEwS0NqK3pCUSs0?=
 =?utf-8?B?QXd4S3NNV1h6bU0zd2FJNHJsNWJwWE9YOGtacXNVUFFnM0NRTURDWXNqTVgx?=
 =?utf-8?B?UCtZZTh3NXRQMXRnN2NLenlML044Ym1OWk5reXJBOE1uYmRONnhsUGg2dmV6?=
 =?utf-8?B?cm5MenlpRUVMOFN1NmRYOVJxWEJTU1FZSWdrdHd2R0tqSmxEU2k0VDlDUStJ?=
 =?utf-8?B?K3docDJ4bm02K29MSy80b0Y0a2RtMFFCVW5qU1FBNWpISWNuc3ZYaGsvVGhO?=
 =?utf-8?B?bmlYa2FzMWdBZ1BpNFhjaDBiZ0hmb0NJSnNtL3QzQ0kxVmdPWnphWEtESnVy?=
 =?utf-8?B?RXhPbE40bUo5L0FOT3l2MnQ5cHk2UndVeGlTN0xld1cyOGVFdncwN0g2MTFU?=
 =?utf-8?B?cHFBaU4zdzRaaGt4c3c0VzNEQTNncTI3TEpEc1RwdEIxYm4vUkVhQzhUOGcy?=
 =?utf-8?B?RnFYRE5GRThRNkJndTFlVkQ1eS8vSk93N1JIODJDZ1dPMVBBZHkrTDdnQ1ZH?=
 =?utf-8?B?ZHlhT3NaeXZJTGVNVzZGOVpaS2JpTjR4ZzZCVVBnUGxaWlFsS0RESXpIYXFp?=
 =?utf-8?B?aDNtNlI4QyttS3pmekV0RmV2cHZxMDJJd1AzUEFlemRqUXNkMGplMkJsYTd0?=
 =?utf-8?B?UmVEK0RUUGkrR2EvWnJTZDcyYmpQVGVDakthU1YzWlNoZUJtY1k2bDhEeXBt?=
 =?utf-8?B?N05SeUc4NXlFaElEOW85Q0NFS3FiTmE5V0h1MWVDc1dzczI0NStaaHA4K1py?=
 =?utf-8?B?VUh1MEtxZnVCZG1abHppZlVLWnBCdlZPMFhaTGFyalNBQ2RPc3lnOFhUcjZM?=
 =?utf-8?B?Zmp3dnNlYXg4NUZrVVZMalI2N1hxb0xRenlrczVnSU1tbnJYYWZEOWVETGpQ?=
 =?utf-8?Q?5Lbeyi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGdyTmFnTVoxRWhFbjFoMlVRelBQSHlkdXZqSDkxd1l4aTQzUjcvaGtlMFFO?=
 =?utf-8?B?QURINTNpMGtiMkhZMEQzVEtaRHlxMWFwbXdvZlJXZFg2TXpSNzdibGptY1R1?=
 =?utf-8?B?NTg3Qm52SWxVbTBrRzVvaG5BejgzcjkrUzRLczRPTzFQWXZybThXQ2ZFZWxk?=
 =?utf-8?B?WVlDUkY4ZS92d2x0UUdTaENZS2xPempUVkpRUHdQUzlOVUJ1WjY5VWRzTkQz?=
 =?utf-8?B?QTNPODNMTXZoM0pTQ3lnWG5vSTZDVmtSbEFSNnhxdHFtOVF3R1hOdTRCS1Zp?=
 =?utf-8?B?aXZNeittM24wb05Ia05iYk1YOXA5ekY5KzFlRStlQzNEdGVJZ1lGQ1hzQjlT?=
 =?utf-8?B?eFYyM3JQaU5IM2tBUmJhV3hYa0VPcVkrY0haRE5nZTMzNy9kRkYyUUQrNjYw?=
 =?utf-8?B?TFZFbXBLNkNDb2JYUjNiZ0R1QlcwRGs5bnlaNUo4THF1RWZ6Ni9kZ0Z1S2l2?=
 =?utf-8?B?OFZONkhzSmV2aGprYUN1Q3hPc05EaEFtQVRnNnBaUy84VEg2dlhoL3VXNnJW?=
 =?utf-8?B?ME83OTIrUTMvUWl6UlBmOVJyNkQwa2trUWVjd3luMWxBSUowMjJaYnJQcUNr?=
 =?utf-8?B?MXlyUE5aSEM5bFIzVlMzN1psRzZaRFQzNzFpZkR3K0E4OGpaNzk0a1F6MmNi?=
 =?utf-8?B?VkEvQ2kzRDBHT1FST0xNTGRiSzhlczVHL1VsN2tpcEh1YjZFa2hNam50SjFv?=
 =?utf-8?B?ZUZrVVN6UUg3SHhNbnplamRXb3NiU3M0SjhPODVjZkZxVnFENEhPamJoNHB2?=
 =?utf-8?B?dWM1TkpJLzZObTNMcERxUVBqK1A2QjBiL3hBV2lxdnIxMnNDaXNGK0Y5Y0ZI?=
 =?utf-8?B?OTZiNGNhc241Q2hPZ3U4NXdvd2xuZXFsNU9LRW5iTnNWOHJmUTJSemZ6Mlcw?=
 =?utf-8?B?WUtDMnVOVFhpZUY0SjZ0R05oSFE4aHNrQmNRNUI4Z3pWYitxWm1QdS9FRXZE?=
 =?utf-8?B?azhYZlh4dE5JZ09rT0ZmMnk5akpjL3U1dWc0aFZHZTQyODZKb3ppVVNmZU1j?=
 =?utf-8?B?Q2FyZjhIUzdhdEhic1Rvem9sbDllejl1eUZ5TFY1aklvdHY2MHFXdnlmZFBt?=
 =?utf-8?B?MG9pVDVtKy95WjVtUHFJMEI1c3Y5Yk9ya0FZckxYY1QzL0JrMUtKbGI0bi9B?=
 =?utf-8?B?aFl0b2llVEpzejBMVHB0R3k2R0dwU1YxdmF6VG9VOHJxNlg2WVQ4eDFQUWlD?=
 =?utf-8?B?N1ZpTHVoVWRLUGhyS0g3Wk9aVzlFS0FRVUhSdkNzSDNRczBRVmREbTdZMVRS?=
 =?utf-8?B?N2s5VnFnRnpwSHlnZ3h3T0ZCdHFYdWtVOVdud3NEcFhscnNqZCtlRlZDOHlO?=
 =?utf-8?B?VGJmek1oT0tjVTBJSnArOWtOMGFBZ1Z2MkhjaFRndDUrTk1rWEg4bjJ1TCtZ?=
 =?utf-8?B?MzljMEltaHpJUFhSNnFibnphOVVBUElBdkZCWkVjWElKbTRoMHIzUi9nckI1?=
 =?utf-8?B?NTFUbTZ3TC9mQW1mQkl3dU9NYmhLUFJaU0NKTFo4OXAvVmpZNk5NL0N3bzN3?=
 =?utf-8?B?dnZlTjN5RGRRMnBaUjg3T2dWWlRZNWJVME1VNnJobGErWTVrUUhqZk9BK3dx?=
 =?utf-8?B?V2R5aEh4VzVPb1VHd2ROYlh0SGt4NUxDdm9KOWdUWHJGK0lndjVnVm9xeVJ5?=
 =?utf-8?B?VGsvUFUydVVVTGpJMlBsa0tvMmFFT3B3bTJhMndLZ2dCVTM4dnp5UUdkRUZC?=
 =?utf-8?B?bW5LZVV5RkNOR1MxQ0pZSnFkbTRwMVFIZmthSWo3RFIrZkxIVnVFakJ1UnNr?=
 =?utf-8?B?T2ZTMDVmdmRER2dkS1dmR1hqRk83WlF1bkJJSWNIMXRmbmJYcld6R2U3RXYw?=
 =?utf-8?B?dkc2WmZOTk4zSEI0RUhSandCNGpOU3lKY2s4TXZCV2tka3ROdHg5NlB5b1B0?=
 =?utf-8?B?L3VrTHpjZW9xOWdwdUxLVGZQN1A4WWlsS2dTZ3Nab3Z3S3BiY0xocEkrMXhv?=
 =?utf-8?B?WFNqZFU2ZGIyT2dWVVRxd1YxUEFjMWErb1NsMEVjc3c4NGsrVEVDOExrWGZV?=
 =?utf-8?B?dWRVeUVwY2k2emk5Zmg3eks4Y0hVZ0tLZStyMmpEemxGcUhtdVdDU0VVSkZM?=
 =?utf-8?B?bXRZU0IreGtpRFFBVnpsZGpQQ3hEQTB6MHRxbHVtdFBtTENMQkJFTk5ZT0Vz?=
 =?utf-8?Q?AyU/q1RFVkFGpbIMRKwF8HxTH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534001e1-07c5-49b5-95c5-08de1d962bb6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 00:39:55.5831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vtdz8djTClPqdXRvPdN7zVPhPMuKFDuIXhC+QDr/MnNlrqwnB3FVM/Z4H2EXwoZwQW0DAfLQrbmNebNdlg5bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8398
X-Mailman-Approved-At: Fri, 07 Nov 2025 05:40:31 +0100
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


On Sat, 25 Oct 2025 20:06:52 -0500, Sam Protsenko wrote:
> When doing USB boot [1,2] on E850-96 board (based on Exynos850 SoC) it
> was found the eMMC becomes non-functional. The reason why it happens is
> that the FMP (Flash Memory Protector) is enabled in FMPSECURITY register
> (eMMC block) during USB boot.
> 
> In regular boot from eMMC the FMP is disabled by some early bootloader:
> 
> [...]

Applied to mmc/next, thanks!

[1/6] mmc: exynos_dw_mmc: Extend dm_dwmci_ops without code duplication
      commit: f391a1158f3db496ce994b613f76b389ef275552
[2/6] mmc: dw_mmc: Do not export dwmci_send_cmd() and dwmci_set_ios()
      commit: 20b19639cdf86f4fb1289443bc47866a8047b619
[3/6] mmc: exynos_dw_mmc: Improve coding style
      commit: 6f0845fcb2ca687e346b74caae62c5ad418b1879
[4/6] mmc: exynos_dw_mmc: Add quirk for disabling FMP
      commit: 1e665e543c51d665f3fe1f8dc428f86198812ead
[5/6] mmc: exynos_dw_mmc: Add exynos850 compatible
      commit: cd7b26a254c1685f2519b78f6fa11577cdcfc114
[6/6] mmc: exynos_dw_mmc: Disable FMP for Exynos850 chip
      commit: e11db644884242795b01ea10e2949f2f56005b0b

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
