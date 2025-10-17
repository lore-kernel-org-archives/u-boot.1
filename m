Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604E7CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 12:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 213D18389E;
	Fri, 17 Oct 2025 14:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cAqaKwcO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED42C83710; Fri, 17 Oct 2025 10:20:34 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7A9A807B1
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 10:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8P5OeapCd4MzQzTRAtF5Pu7Gn0iuWrPuk5pFKiYDUHEsRH4t1uu/iILTbpbzJ6pUcUOmvGTrFVYvXHVEs2+pRkUQ6fqsVIJTUlR+QuqimWGPFg2+x8cDbbcdmQRiJqIFR6TwpODe43IkOrrA06LBg1lSEWzpDuwcAQ1Vp6bp2zPI0cIrjjNbSNeRiFt4qiNp1DkLN9ppfMgFZp9X1lJAw8hOXQ8EhoiMP8yU7DphkLb7SSpxczaRobeEqzV7aKv8uv5iPCTyXRm5+q9KlYEYolNhjJEqTZQ1I23Rzo2hGBG3HjQrJv1BJBnFFSHtxLTRWOVz0aopiPUJcaI79PWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ni2Y6769pWNWeRGL7GLEIPQtsVarXmCN2Y6IZKqH9bo=;
 b=NuQNxWVa5S+YoJGugqXoBmr3VC9ir+k8ngW75GG9Y1q7lvoDcSHn/1MXR3Dmh0bWGZcJzLSFjY1nE197Wj7PxsXRnI8+Y3XO2F/nPV1vRv+sC3JSxxVFjKOAPEflSBECVa4uvMZsNjdDujxmxFWnvj0+ySl+fHSWlgxRXgYzP+U/Sjkr68/xc/k0VU7bNP3PYgqZYHiYASIH6XlC7A7dCbY2P6x8UE6glc9L3xyf7xTI/EIjKN4n/WXCgg7Cuv8ABbA+jDa1FDpRPtWbZlGl75lpTLSG8bnFdDHlxWCXuzErPmMauuIqGU22T/NCuiyXJbvaULTrH6ueVy6aKqQl5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ni2Y6769pWNWeRGL7GLEIPQtsVarXmCN2Y6IZKqH9bo=;
 b=cAqaKwcOKy1PP4SPnpDeMwg2/keXDjHCM6PIQvOfEivl58+R4tfOBreXr1QrW9uzYER9/d3nzNSMzisMsKKXfq2wee6HGqrUv60IpCbuwbMq6o8VP1KnvLfKj2cmPbhk2G6IZIP4K/1XjeOiX6o6sYIbPktoWI1NlAR/SLBW9vpNZQ5s04y4aC735RRmksibhVbW1pCzVA7+2xUMmRtXploaJ1QHnEq6ZAx0w8WcP4E9ncUgDWYLPR4BN+aSWrxqzHRjl/u4RW0vuS6S8joLxZqMsx46qZz7kKjNNeCF2XaeDgSjrmCpaytvxt5j4dXpwXDL0anHasZ26/bsUnAIvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9988.eurprd04.prod.outlook.com (2603:10a6:102:38b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 08:20:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 08:20:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 17 Oct 2025 17:32:34 +0800
Subject: [PATCH 5/5] firmware: scmi: Add i.MX95 SCMI CPU Protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-scmi-lmm-v1-5-9fd41e7a5ac0@nxp.com>
References: <20251017-scmi-lmm-v1-0-9fd41e7a5ac0@nxp.com>
In-Reply-To: <20251017-scmi-lmm-v1-0-9fd41e7a5ac0@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9988:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d85adf-b55b-4450-af9c-08de0d560900
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0pTdzlFL2ViUmJJdVRCZEhDeVFpbEQ2T1ZZdXZ3WWxNK2x6UE5UQzJOUUxr?=
 =?utf-8?B?TUY2TFJCMkdQZ3h5TzNFeVB2blhIYlZ6VGNrQVpxbEhaVnoya1BGcGE3cTlG?=
 =?utf-8?B?VmlGT25JMUpxVjU1OCtwU2E1VzRRQ3ZZTHdERFIvdGdMOWVzcjlReXpKdFZy?=
 =?utf-8?B?b09WYThNQ0N4TkxucTRaWmlKTW02dmNaYmwvTDFnc052c1g1ei9aeE5KLzQz?=
 =?utf-8?B?d0dYOFN3QTVmdVQ0aFZXVExscU45WWhvTG12ZThRQThGMzZJY0pqMFltZnNx?=
 =?utf-8?B?VzdnUHRtUHdiaHJlWEFtQjR4UnNWeXpiY0QxdC91NlBDaWpkVGpqYmRXVjdy?=
 =?utf-8?B?djNoTkJ2aDZDUEFkL2Vmb1c0Sm9RaVIveU5pVjY5WGo0d2haZlZYOWc0V0pl?=
 =?utf-8?B?R0RTREF0dUZTeC9UdWlSRWo1dEpNUjZqdmluN21OdGdXVzd2cEF0V0FyU2o4?=
 =?utf-8?B?UGo1Z0hrcUcyUERHUVlvcXVTQVJKLzAzWnZSeWU2V29PTlQ5K3ZjeVplak8w?=
 =?utf-8?B?TmdrSit5KzNTSmcxMnBrdFpOb2ErL1p3aUJ0bjM5SDZYMnFNSVh5ampyQVdV?=
 =?utf-8?B?bTN3MHduYnllYjN5WllpUGF2Yk8vc2srd1lPS05hL2FtaXpCempkQzJPVm0r?=
 =?utf-8?B?WlVYYUp2OHNUd3RYY08xK2xwaXJZM0tZWGNYaFpVRVhVTktqckZka0s4SGRM?=
 =?utf-8?B?Zjgrai8wWVNDaWYrSGhpYmhDQkczRTVQZ1RnV1UwUXh1cnI5VXpMdlI1VU9a?=
 =?utf-8?B?b2YzSWNob1pVeXpBcEt4ckV4a3NyZHFLUFE0cmd5MCtyOXNhdXJ3Q3FPaDRF?=
 =?utf-8?B?TkdtazBYVGM5RzNXajBVa0pVQnovMkRmMUpmRmNBM0ZYbHRweGZFSHM5bjll?=
 =?utf-8?B?elpZdzdxMXRrY0dvSkI1SW9zZDFlSndFb3dEUndPQk5pTlpkRlpHb2JHWEN2?=
 =?utf-8?B?SlBPdHVlVy9ZUklOa3FsWDk4ZkxwSjUrRkZyMGxMb2xVTi83UkVsREpHV2xj?=
 =?utf-8?B?aGpwT09zOEc4OE9lUG0vSFNVWmdsUUY2MWVaT3d3aE9jdjdzazdUNDh1WWg4?=
 =?utf-8?B?RTNhSlhsaTRGOWNuNmM1ekQxbzkxRHFvajg5MlZRUEdjOU1iQXhpYUErZTFy?=
 =?utf-8?B?aUE1SjBLeFVDY1hxcGtOWEt5b2x1L0REb2M5alY0dlpWNU5hUWxpV0JySlIr?=
 =?utf-8?B?cEtxSXNtOWpGQkVNZER4VHNsQmNqZ0RadGQzU3RwWWJ4L285UktuU1FoWE9k?=
 =?utf-8?B?UGZ5NUJIcnlaa1hLSHJ3VFlCS2UwUWMyUURjbEUreWtuQkRRTnphbEwzRnhS?=
 =?utf-8?B?SUNCV0IwWGgyL1M2ZkxpZHJ4WFNmeFY5T2NVUDJ0L053TDRzb2EvTXlzeWFN?=
 =?utf-8?B?QWFqRHFqWnVnTzNkYXpXSFQ5WUhsQ1lVWURNdG9XcVI5YTZaRVowUHJSRDFj?=
 =?utf-8?B?dzNYTUJEVUF2VFhqa2M2YkRKOVdUT0p1MzdBOS9tSVF5d0tlY0RLRWtyNWk5?=
 =?utf-8?B?MDlXcHhsSCtxb2hOUmlWT2t5aW8wTGZScGNuT09BcUdMcmV3NFRHNFlKY1hx?=
 =?utf-8?B?T0gzbmxJQmpidENMd0xGTFhoMlpuU2E4ZHhDZ1RKY0ZWa2JpRU5FN2hxalFq?=
 =?utf-8?B?RGZUeDdGditRL3ZJbzVpajduS2RSSUk2QVNGRXBEQXJFZUVTR3N3dWN1YUFZ?=
 =?utf-8?B?ZWw5U2I4TXJ3RWFXeEJoQmlid1F1SzFDV2xGcWgydForMzhEZWNLSmRYRXJH?=
 =?utf-8?B?anhUbUplaUNwRUVDUGpPckJwUC9GcytvSDlnbUc1VTZ2Tkx0Y0w1bXpFbHBk?=
 =?utf-8?B?b0RManBSUndocjYrWDJPMFVZd3lZbHA2dkM0WW5tSGZ5MEl4N2tFNEtiTnI2?=
 =?utf-8?B?UDZkVjFLN0d1cUplb1dONEdCZ1ViOFJaMFJScEJoeG9yZC9ndTR6cXdhK3B3?=
 =?utf-8?B?MnlxOFZlbFVkOGw5eHB2c00ydUdqTGhwMjZGN0t0NzFLb1NjVy9uc1NBSWZ2?=
 =?utf-8?B?U0FHbnZHM2hQbTNkdjh4N09nNUJOa2EwUVUzSmF4Q1FvZXNqbFh1UXcyMjlp?=
 =?utf-8?Q?nCV0vH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlZUU1YvdUczaFRoSDB6YTQ1aytxelJyb3JialdYSlVkeUJDQVFjR2lhVjFv?=
 =?utf-8?B?eFA3UU9NcHJGQXg1K3FqWHFkcXNtQUt6cDBMTWhxLzdlOXlvVXZsNCt3QmQ3?=
 =?utf-8?B?MHlFM0piTXZHMnowWE1iWXlUQW5uSXB6MS8rK3o0YzIwTEVBWkRsUThWdDJI?=
 =?utf-8?B?c2Fiem0rQzBVYVd3bTJCc3dhdlhGa05JV0dVOEUyeElmVnE3d2FLR3hmaHR5?=
 =?utf-8?B?YWFYdU1OUm56K2J2WnlzTmk1bkpWMzU5eFU0MzJMblpveDEzTDU0OURzQ1Vx?=
 =?utf-8?B?N3A2bHA2T1IyRG02L2NwaVp0dkhJZXRXcmxDNXhSYmtqbk0zRHF6SDJOMHdr?=
 =?utf-8?B?Y1NGNzZjcm1zcEMzb1BsYy9TSEJwUTZ5Y3phQ0lCamNEajJnalRWT0psKy9S?=
 =?utf-8?B?Tml6dkc4d3QvTXR4ZkZRVHhqTjhHdTR0Z2Y0VFNvTnU0cFFYUEJZYUhkUTIz?=
 =?utf-8?B?ZVlDcU5iTUR0RU9adXR1bEVoZFU4ckk1MnVVYU84SVk2RUZ5QVRxaGVQV0M0?=
 =?utf-8?B?cVFsU3pyRzZ1THIzeFBFNXNWMmJMNU9QVnZjYTFwa09wOTVBaFhCQVMxekRJ?=
 =?utf-8?B?NjJ4TUI2QmtqbTFkYTFMVVhQSUhIZWo3cHNHVTc3bnBhNVZJR3Z1MFNJUGtv?=
 =?utf-8?B?YldBMTdmWnNlaWFUMW5Od2c5UkxMUW9sczVIWVovSGRPOVNWYzZ1WFJBaGRh?=
 =?utf-8?B?VUpwbzlTWXFqTmg4VFR3bnkzYmZZRXBiMjdvNHRIZ3NnanlReUNRUW1jYlNP?=
 =?utf-8?B?QXlwa3BJK05wb21xY2pBbWl3N21uUnJMeWcxd0l5VTUwaVArZEtxY3krZDVS?=
 =?utf-8?B?ZUVPTE0xUE9Nb1dzblpvNzVzY1d2QXV1TFJGOS9XNUxjVmE0TFp6akx1WVNQ?=
 =?utf-8?B?SlBxY1hIYUxmSUl4MFFjVld3bnFwNzZ0cDNYK2kyazdxWmdWMmtnZWpHTXAx?=
 =?utf-8?B?KzhjMG80dXFoWlg2d2l6RmhZS1RnRERYUjFXeWE1OEFGL2ZXcXdYY1NzYVBF?=
 =?utf-8?B?dXM2S211SUJLSERCZU1LV0ZmMHowR3Z3a095WEs3R3N3RzRFUU4xMTRiQlJJ?=
 =?utf-8?B?ZWlLekR3L0pKWDJGT2RTNEZBOEt2Qm5IT3Zia3h1UkFrbjFTS1JLbElEMXV4?=
 =?utf-8?B?OStubjFaNnpxN0FudXE0dHFLNzl1WGlHNGhKSkt4Z1VZR1I3elFhd0xGQTRH?=
 =?utf-8?B?ZHNnYWJhRVhocndiWXpmSzUzeGxXRlJFcE5wbTRSUWcyUFhiNFJuVVYxbS90?=
 =?utf-8?B?YkhDUDRqSVJoN2krd042c3NTN2FvSHNDSVNMS3NRblNTQjdlbEFTTjQ2VmZG?=
 =?utf-8?B?UUlqdXFSWnZZT3EvUE9MaVhlNlMrUjRkVjV5YzVITitpd3pNOVViUDRmOUlV?=
 =?utf-8?B?T2pMNFA4ZHBHQWJwUzVwM3A5RXNMOEpmTVFjVy8xNll1SkxvQjdDYy9sRjND?=
 =?utf-8?B?ZXpvWDFEclJ1YTdUYTIyNE8xZzhsZkQyTVQxNmJiWEp5VXFzdDNKejV3RThY?=
 =?utf-8?B?QkNTeVhScFRiTHlTaXZ2b2lIcmJrUjgzcnpnTWlLZEFBRVAvSlpwSnhtVmd1?=
 =?utf-8?B?Vllsdm1LQ3VQWEJDTUNwbzNlUSthaUZxMDVHV3NUWk85aDFhTUgrZGRkTnds?=
 =?utf-8?B?UFBVTmVGbG56OEV3RktCS25NcFBtTUhZeTdGQnIzcit5QWM3Yk9MdjQ5VkZq?=
 =?utf-8?B?WHlnZU9pcHY1aW9zQjJXVGlpeGQ4enNWdzk5SU1NUFUvZU9lc2F6NytVTFUr?=
 =?utf-8?B?NVFpVGVUYkVyZksyQm9uNmlzc1h5bUpHNG5WL3BQTkZDUnRXNEdkTE95T3Bp?=
 =?utf-8?B?SStxNGI0eHBBSFVDTGlla0RZRFFVTXpWZ3RaVVV6UXc2MlJCUEFFajgweUpa?=
 =?utf-8?B?V0ticUJwT3dSenFsMUVZTC9KRWZtRkhrdDdYQUY3Q2J4c1ZVcWRpY3dkWGth?=
 =?utf-8?B?VXZibkZBeUNhNi9EaWx5UEtPMzdmQWRMTXgzdCs3ZnUreEN6Z0xnNEp6dDBu?=
 =?utf-8?B?ZmN0WW1vbk5JVi9hcFRnZ29XZEZWZEZhcVBOcWFXVlBZcUZIZEhvWnQ3VDg4?=
 =?utf-8?B?VTFJb0hzTVZwcnpZaENLT2tyR08xTFlNM3R1d3UzSGw5QUp5U25VMnRYeWpl?=
 =?utf-8?Q?NnUJFQVHvWnfIph7XNu6v7Wd5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d85adf-b55b-4450-af9c-08de0d560900
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:20:30.5023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRW2HzKAQBpz/Hjz2aoco7DGKh8TfQ7gkoXQAHHilGfcHPh3v6dpAX/dS/VM2tOzMiE28iblpTSHvIkfwTi65A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9988
X-Mailman-Approved-At: Fri, 17 Oct 2025 14:40:46 +0200
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

This protocol allows an agent to start, stop a CPU or set reset vector.
It is used to manage auxiliary CPUs in an LM (e.g. additional cores in an
AP cluster).

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/scmi/vendors/imx/Kconfig      |   8 ++
 drivers/firmware/scmi/vendors/imx/Makefile     |   1 +
 drivers/firmware/scmi/vendors/imx/imx-sm-cpu.c | 179 +++++++++++++++++++++++++
 include/scmi_nxp_protocols.h                   |  24 ++++
 4 files changed, 212 insertions(+)

diff --git a/drivers/firmware/scmi/vendors/imx/Kconfig b/drivers/firmware/scmi/vendors/imx/Kconfig
index 211bb1f2244629096a50b06ee58006b5ee1a2dde..16850502bbbabf227b2c0d15f4d5bb8206721433 100644
--- a/drivers/firmware/scmi/vendors/imx/Kconfig
+++ b/drivers/firmware/scmi/vendors/imx/Kconfig
@@ -1,3 +1,11 @@
+config IMX_SM_CPU
+	bool "Enable i.MX System Manager CPU API"
+	depends on ARCH_IMX9 && SCMI_FIRMWARE
+	select SCMI_ID_VENDOR_82
+	help
+	  If you say Y here to enable i.MX System Manager CPU
+	  API to work on some NXP i.MX processors.
+
 config IMX_SM_LMM
 	bool "Enable i.MX System Manager Logical Machine API"
 	depends on ARCH_IMX9 && SCMI_FIRMWARE
diff --git a/drivers/firmware/scmi/vendors/imx/Makefile b/drivers/firmware/scmi/vendors/imx/Makefile
index 6031ad805209eda3313f53f9eee4ec96c9a4fe88..59ff8640dc1c5978a9bdceb85e83083957fd3a82 100644
--- a/drivers/firmware/scmi/vendors/imx/Makefile
+++ b/drivers/firmware/scmi/vendors/imx/Makefile
@@ -4,4 +4,5 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
+obj-$(CONFIG_IMX_SM_CPU) += imx-sm-cpu.o
 obj-$(CONFIG_IMX_SM_LMM) += imx-sm-lmm.o
diff --git a/drivers/firmware/scmi/vendors/imx/imx-sm-cpu.c b/drivers/firmware/scmi/vendors/imx/imx-sm-cpu.c
new file mode 100644
index 0000000000000000000000000000000000000000..28dfac642ec9174c1f90e0e4e503b7cf04f6083b
--- /dev/null
+++ b/drivers/firmware/scmi/vendors/imx/imx-sm-cpu.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * i.MX SCMI CPU protocol
+ *
+ * Copyright 2025 NXP
+ */
+
+#include <compiler.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <misc.h>
+#include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
+#include <scmi_protocols.h>
+#include <scmi_nxp_protocols.h>
+
+enum scmi_imx_cpu_protocol_cmd {
+	SCMI_IMX_CPU_ATTRIBUTES	= 0x3,
+	SCMI_IMX_CPU_START = 0x4,
+	SCMI_IMX_CPU_STOP = 0x5,
+	SCMI_IMX_CPU_RESET_VECTOR_SET = 0x6,
+	SCMI_IMX_CPU_INFO_GET = 0xC,
+};
+
+struct scmi_imx_cpu_priv {
+	u32 nr_cpu;
+};
+
+struct scmi_imx_cpu_reset_vector_set_in {
+	__le32 cpuid;
+#define	CPU_VEC_FLAGS_RESUME	BIT(31)
+#define	CPU_VEC_FLAGS_START	BIT(30)
+#define	CPU_VEC_FLAGS_BOOT	BIT(29)
+	__le32 flags;
+	__le32 resetvectorlow;
+	__le32 resetvectorhigh;
+};
+
+struct scmi_imx_cpu_info_get_out {
+	__le32 status;
+#define	CPU_RUN_MODE_START	0
+#define	CPU_RUN_MODE_HOLD	1
+#define	CPU_RUN_MODE_STOP	2
+#define	CPU_RUN_MODE_SLEEP	3
+	__le32 runmode;
+	__le32 sleepmode;
+	__le32 resetvectorlow;
+	__le32 resetvectorhigh;
+};
+
+int scmi_imx_cpu_start(struct udevice *dev, u32 cpuid, bool start)
+{
+	s32 status;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_VENDOR_82,
+		.message_id = SCMI_IMX_CPU_STOP,
+		.in_msg = (u8 *)&cpuid,
+		.in_msg_sz = sizeof(cpuid),
+		.out_msg = (u8 *)&status,
+		.out_msg_sz = sizeof(status),
+	};
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	if (start)
+		msg.message_id = SCMI_IMX_CPU_START;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+
+	if (status)
+		return scmi_to_linux_errno(status);
+
+	return 0;
+}
+
+int scmi_imx_cpu_reset_vector_set(struct udevice *dev, u32 cpuid, u32 flags, u64 vector,
+				  bool start, bool boot, bool resume)
+{
+	struct scmi_imx_cpu_reset_vector_set_in in;
+	s32 status;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_VENDOR_82,
+		.message_id = SCMI_IMX_CPU_RESET_VECTOR_SET,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&status,
+		.out_msg_sz = sizeof(status),
+	};
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	in.cpuid = cpu_to_le32(cpuid);
+	in.flags = cpu_to_le32(0);
+	if (start)
+		in.flags |= CPU_VEC_FLAGS_START;
+	if (boot)
+		in.flags |= CPU_VEC_FLAGS_BOOT;
+	if (resume)
+		in.flags |= CPU_VEC_FLAGS_RESUME;
+	in.resetvectorlow = cpu_to_le32(lower_32_bits(vector));
+	in.resetvectorhigh = cpu_to_le32(upper_32_bits(vector));
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+
+	if (status)
+		return scmi_to_linux_errno(status);
+
+	return 0;
+}
+
+int scmi_imx_cpu_started(struct udevice *dev, u32 cpuid, bool *started)
+{
+	struct scmi_imx_cpu_info_get_out out;
+	u32 mode;
+	s32 status;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_VENDOR_82,
+		.message_id = SCMI_IMX_CPU_INFO_GET,
+		.in_msg = (u8 *)&cpuid,
+		.in_msg_sz = sizeof(cpuid),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+
+	status = cpu_to_le32(out.status);
+	if (status)
+		return scmi_to_linux_errno(status);
+
+	mode = le32_to_cpu(out.runmode);
+	if (mode == CPU_RUN_MODE_START || mode == CPU_RUN_MODE_SLEEP)
+		*started = true;
+
+	return 0;
+}
+
+static int scmi_imx_cpu_probe(struct udevice *dev)
+{
+	int ret;
+
+	ret = devm_scmi_of_get_channel(dev);
+	if (ret) {
+		dev_err(dev, "failed to get channel (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(scmi_imx_cpu) = {
+	.name = "scmi_imx_cpu",
+	.id = UCLASS_SCMI_BASE,
+	.probe = scmi_imx_cpu_probe,
+	.priv_auto = sizeof(struct scmi_imx_cpu_priv),
+};
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_VENDOR_82},
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_imx_cpu, match);
diff --git a/include/scmi_nxp_protocols.h b/include/scmi_nxp_protocols.h
index 1c79bc2282b6efb02bcfc4843c1b4a0e83fe93fa..c17f3663eba28f8699b21658445d88e6e60456c2 100644
--- a/include/scmi_nxp_protocols.h
+++ b/include/scmi_nxp_protocols.h
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 
 #define SCMI_PROTOCOL_ID_IMX_LMM	0x80
+#define SCMI_PROTOCOL_ID_IMX_CPU	0x82
 #define SCMI_PROTOCOL_ID_IMX_MISC	0x84
 
 #define SCMI_PAYLOAD_LEN	100
@@ -95,4 +96,27 @@ static inline int scmi_imx_lmm_shutdown(struct udevice *dev, u32 lmid, bool flag
 	return -EOPNOTSUPP;
 }
 #endif
+
+#if IS_ENABLED(CONFIG_IMX_SM_CPU)
+int scmi_imx_cpu_started(struct udevice *dev, u32 cpuid, bool *started);
+int scmi_imx_cpu_reset_vector_set(struct udevice *dev, u32 cpuid, u32 flags, u64 vector,
+				  bool start, bool boot, bool resume);
+int scmi_imx_cpu_start(struct udevice *dev, u32 cpuid, bool start);
+#else
+static inline int scmi_imx_cpu_started(struct udevice *dev, u32 cpuid, bool *started)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_cpu_reset_vector_set(struct udevice *dev, u32 cpuid, u32 flags,
+						u64 vector, bool start, bool boot, bool resume)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_cpu_start(struct udevice *dev, u32 cpuid, bool start)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 #endif

-- 
2.35.3

