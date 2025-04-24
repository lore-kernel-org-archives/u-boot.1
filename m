Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70860C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAF138070C;
	Thu, 24 Apr 2025 08:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dyFP71K7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C8028082A; Thu, 24 Apr 2025 08:33:55 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0D45806FC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCUkMurbnB91Sr059wo7UfpaQAdo893gy0YwsvWhXY4+xfPNOZjvYJW/X3CtdKx96JKSym6sY3TtYk5vNAQNuP510Uuowv1cV6VcLvgRArQeunXHL2LFy/EM1v10bscBZIxoj96IGG4An++tXVyLv3acS+hTs2F2ijHQaa1T2RUwJ9ZR8Up1ebUrRhfArac6YqCKrYJ9OYefFDDrVD4SB14p/lApG+P5MLqXFLnMNFRcsgGWoW45zlOw3CPwzViI6yLZVXz2/maHT0Dc9ycJ/wlrRaO6F2EJWYPoWK0pgAHUIV7cpprSr2SEZBMoBb7/r9J12rePuk50Sg6QfqFndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiFdPnzydYnO5jt77igWDndQBokcUvsm88nVIuYliE4=;
 b=KyWWMnzexI1nadp5nlGfKapNyrpAeBNgF8Uo3x+XQuy8EEWpNuAOMfORzL9PchmVcgWb/DibCWS81RsdhbCi7kgs8fa04JuUo8EU4xgjBNuKBFJoq89xlxRt2kKvW3mw3b7ZmQtb2MMTCLNIE2zn4vmlVJm9FzRVj1J7eWK1PYCNAHQ1cY7GZlHRkumneHQs3C+2q1q23bGxyTbyayziEcDGz1bYAWKbsDH2Yy1p8aJzhGgr3TxVjB8wRxMUA8KcmxilrAJ9ZdmhHVCP/u2OrFtHM1o/ULQM4FX1S+2iZQXCoAWIlcQScIeEGUDDk2tZuiDhrwe16XeFE7dTIK3q+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiFdPnzydYnO5jt77igWDndQBokcUvsm88nVIuYliE4=;
 b=dyFP71K7hMQD4tS3sRU9XCucADNvtTn4hketQ63rU22cJMSqsg+EVS5HE/SbEeC/fsDgLe1KXgW6pBHk2LEovRyNqHA0HMWezG1uOHAcTEBAJi2ju2JlOxXMoNs/yZnsDr1pOSJDxguyzoeRsWMBBycGMrcEaJEi0vRqouuOREhsYZJuyv6/qfoi63MCzKsii8oKD/g2WVfRYTvp9jH97RugoS55CCW8aFrKdsMdqdPpGaQ9nqLpW0JoJEPb/G+E4cot4J6jbLOUp/iidrztwMG7MYENR19zuqcu1PmkcVyV++H0mN092W5KgAUojZP8pmyMJMhRrNMxmgGd2B+O7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBBPR04MB7738.eurprd04.prod.outlook.com (2603:10a6:10:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.24; Thu, 24 Apr
 2025 06:33:51 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:33:50 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: [PATCH v10 00/21] imx: add i.MX95 support
Date: Thu, 24 Apr 2025 14:32:56 +0800
Message-Id: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABjbCWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyMT3czcCktTXUujFCMzwyTjRMNkMyWg2oKi1LTMCrA50UplhgZKsbW
 1ALOibR1cAAAA
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Jindong Yue <jindong.yue@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DBBPR04MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 14638e48-bf0d-432d-c70e-08dd82f9f9c9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akc0MkhRNXIrSmFZTXBXNndQSVd0ajRWYk1GbFplZk93aldYU3JEeThKYXBP?=
 =?utf-8?B?WnNmckM3Q2V1V09YYUc1Z3p2S2pvOFFPMjJ4MHowbms0TG16TTg3M1I0TUZt?=
 =?utf-8?B?bkordGNBeTA3VzJFRURDcGx3M3hMamJwRjRyMkVPUXFlVTNTZDM5OUxqL25k?=
 =?utf-8?B?ekZ4b1Fmb0NTK09sMi8rZHJ3QkF1WFVoRlAzRVlZMHEvS0d6a21KYzZlZ2JM?=
 =?utf-8?B?Zm9CR3BXS01qYU94SDhYV1ZZK0VuOVFCUFhTS0sreWI2Y1BpTjNvRThCa3o3?=
 =?utf-8?B?RXBBa3ZvSjRYUHdJdm1QN1FoOVo4VzRQZzU2Sm8wazVqSy9ZM2RqbjhYRkh2?=
 =?utf-8?B?TzV3c0FYaEpwMCtIb28rUS9UNnFFbFRLNGRHNkx2NEJFV05IZml6ZGpMMHVt?=
 =?utf-8?B?WEQ3K2E1NkpyczlkaEZjZkxVSFM5NGRXakVQcHZwOUE5bGJIeVRqM2ViTEF6?=
 =?utf-8?B?WGlWMUczQXVPWk0zTGhQMS9Ec253TDVqcWtOU05MUlptRlZTcS9LY3Y4b1hM?=
 =?utf-8?B?QnFxZ0pGcmx4aXNleUZYSlE3Ymk1K0tBU3c4Y0NRSzJ2Yy8ydFA5akNDNCsv?=
 =?utf-8?B?U3ZPeFdpRWxZOEhEdGx2Y3ZtY00zZlorcVJjU3VZc1JmSkc2N1BmZ2g4SkE2?=
 =?utf-8?B?aHU2TXJQZURGZzNleG9XOGQ4QkNlU09lOWxCVXNvcjlEZDdXN0ZHWVFNem1N?=
 =?utf-8?B?MWh4S2FnTFV3ekF6ME5wdGhGVG8zNEZ5SWlLak1JOVRNc0VHTlUrZnNRTzVT?=
 =?utf-8?B?d1ZJZEhrKzFSNG9VVTdYVUFGbE93WldET1lUckQ1cVZpcW55amZ6bHZtMlhG?=
 =?utf-8?B?cllSdEI3b3NQK1ppRVpCUUU2SXVhRGttazdUQXNxckhkaUFOUUt1b0diMjdk?=
 =?utf-8?B?Lyt5MGRtVXVTTkhJS0JVekpCUllqY3lwS0RIS3FyVmJKbVpWaXNpMDB6MEZH?=
 =?utf-8?B?WlRQRlQrMzgvZ1kwRXRJcVdkY1JiNlVDMjZOWDVyTEY4dWwyN1MreTZWSmpE?=
 =?utf-8?B?eTF0cFhEVzRaRHpjUHRjSjNvUURFeUV2Y09IcS9ueUgxR1dmbzJ4RzdscFkz?=
 =?utf-8?B?TUJRZkNHWWQ2U1ErcTlFSEd1UmpnTTk5bDRDdjBuNkJueStKZ2cxQUF0Tm9U?=
 =?utf-8?B?d3Q4NzZDaHQrMWY4dHNtQlY4ZHpHVmZ6djhrcmdLQXc2VWxmQW8yRktXQUg5?=
 =?utf-8?B?T051Z00xQS92aWhFK1hCZ3MwZVIzWXR1YlVDeTZ4eDNHby9OQVpPa3B2OXZy?=
 =?utf-8?B?dUVPZ1J1N3VvOHhlYzlXdzNBRDVSUit6TXA0QWVEWUQ5RXRGYWE4emNHM1NR?=
 =?utf-8?B?emZ6Nnp0MG9mNno1aWJoZFNrek1PUXA4cVQwKy9BWE50VXZldUNXbzA2UkFk?=
 =?utf-8?B?V1Z4eGpGYjZQek9WVzlJTTh2NHJLVWpoVVQ5Tm9zUmUrckUzSWNiMWJiNTZX?=
 =?utf-8?B?eUhVTmVhTzRvUi81TzVIaWpkbytRZU9nM3Q1dm5ndTBlcXFiK1NyNk9KRHNz?=
 =?utf-8?B?UVpYTHBGN3VSUGpSb3JBV2FuajEwRlB5OEhCZ1ovcHI2VHJMZXNyMG1sWU5x?=
 =?utf-8?B?Ri9Ta0JIKzNnREJlcUNWZnlXdEhhSVBxLzFnN0lhNU53bjhtd0h4Y3VNQnJO?=
 =?utf-8?B?ZDBod0VnbCtSTWpzeUNPeU9zSmpWakMrdVBiR2Fvc1dYMTRYcjVLeVFpSVc4?=
 =?utf-8?B?eGwxVjBWWjluWnpCUE52SnhlRC9jekxaWnhHU2pLTTNySFo5NUVXVW1xSHY2?=
 =?utf-8?B?QmxJKy9GL1RsdXJRMmYvSWxZVEw3cWE0Ti90SmNqUUovYWhJb3hXSzhlK3BX?=
 =?utf-8?B?WUkzdHFzN0xuUElZS2RuM2czdHcySC9oNmJBTEl1b011WllkZ2tPQmJFUFp6?=
 =?utf-8?B?ZVdBcXlleDBZV2JtTjdZU25pL3BMekVFeDdXeXRsZ0x0Y3BXMUNQd0RWTDFE?=
 =?utf-8?B?a1VXbXR6Zk5OKzM1NGdXMThPRVhFajhMS1VOaExHeU1Ba240YzNPYU9kR3o1?=
 =?utf-8?Q?O0uISTwfHNxEXlZ3FdbqOg3Bqw8FL8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmJHb3lzR0krQStmYVlVcUU0MkY3VXdKZnJiRXhIUTlscm10R2xYWDY1VVZi?=
 =?utf-8?B?cUFDYXBKK2FGVEo1dHRIeTVIVUVGb0RCOFFzdFBldW16N1NOeGJWYVB2SzJF?=
 =?utf-8?B?RUVlZU1Ra05lWEZkVVJIbkhxN0Vmd2ZkQ0tQMFd2QWoxci9DTm0wOWc2UU4z?=
 =?utf-8?B?eWF2eXBMRHl5OEx0SDZGb1Vabi96TW5GbVVJSUgzNE9RalBqS2U0NzY2d3hB?=
 =?utf-8?B?dkltNkNMVFFRNzJIM3l0YlI3YkFtcjQwZjI0UURSNlFKMXBaZDVMMTZhc0FR?=
 =?utf-8?B?L2ZWRU1kUjNaVTVQd0hKQmlvOGJydGE4RTFpQVl3bVUyaE5pc3V1YzdHWkJI?=
 =?utf-8?B?YWtIeTh0eFNOakJDaXNXeVZrWGlVTkc3ZzJwaFNEcGxBeHRacDNYRGdZWmVo?=
 =?utf-8?B?cWd6VzN3WjIwaTZuWjZhb1ZoZWxiL2ZDYThLV0NHT21NcCtYamF5YUF3SkVX?=
 =?utf-8?B?RHBDSzVrNTBWY0xqK3paYThMbFJuQW0xVGxzY3hzRTBXS0laR3Y0R1RuL2Q2?=
 =?utf-8?B?bXJBK2Y4WFpqaGNJU3VJa29Nd1FXaUw4QXNuMzc4dFlReWRWSFh0d09QWDVt?=
 =?utf-8?B?Vll2ZEhaTi9yNzNMY2l3VEpuNE1xWVkyZHVrWENQWjZ3YTFxR0hRNXBVVU1V?=
 =?utf-8?B?ZXFQbVpXNzFDbE1DUS83a1lLUnIvY3p0eDBidU5Ya2E0MW5HUXg1ZDZ4OUZt?=
 =?utf-8?B?WGlydnBSRXlodjR4aWdQR3lKVkhwQTF5UHRkcnRPdERSS0tGaTNiaEFBNkVV?=
 =?utf-8?B?WFdoOGdsRDhqZWhORER0WTR2TzZFVzBLaUNGMGRzdTdveDA1YTZ3VWd3MjNZ?=
 =?utf-8?B?U2ppTFByMXpBV05TWFZqZHhBbUNLNUswM3F4aCsrUFV4a2hOdzEzMWgxdFRQ?=
 =?utf-8?B?SURHRXJIVzkzNTY3VW9lc1RxeUxmMW96M1RxaURmU2Q0cDNHTEJKOS92dkk3?=
 =?utf-8?B?QzAwSnpJQmV2b0hlNzNVaFhRTmpSSHdHS1J3cXQ3YnI3aEtWNnprUGQ0enJM?=
 =?utf-8?B?QnUzaU5adnBwUk11MTQwMkc2YWIvdGl0ZlRZVkxNRUNROVdqOEs1NVR5d256?=
 =?utf-8?B?TDZYbis0bGcvcXBLRXVLZllRK3lyZDRlQW02ekRxZVgyR2RDQ2hXSkFyRlFU?=
 =?utf-8?B?UFJlaDFlV0R3Q09FWFpZZ2pFWU1wSjZxd1lOQVB5MDlZTUlac2JkNkhaU0Fs?=
 =?utf-8?B?VnVKRGZUYWdvdURhTWZDaVoybnV0S1hSUHpsYlE4b1FOY004cTBCS0prSGtv?=
 =?utf-8?B?SUNQVkRMdEFYZmV5RnBKTzU0UWwwdzBzdXZyakQ4S2wvR0xSaVFETENZYmZX?=
 =?utf-8?B?cEFjaDNQMUszQVoxamFKSXVySktKakVzVmdsQ1pzZVpLOFJWYjRlZFVoRlcy?=
 =?utf-8?B?TVBiUFRpTHFiV1VrZm1vZkJXOXZ4cDBDUmFud1g2R0RQeXhEdmhBa3Y3Q3JU?=
 =?utf-8?B?QTdMZlErTnlkV1pGUHExM1NGUStDZzZYVURDUmNTdHYxRVVKaHJkaUZvWi96?=
 =?utf-8?B?STRaQkdYbEtDRHg4MUNJOTdsQmhjdmNKTldjOVpBM0tWS0dTZTg1cEZoUnRD?=
 =?utf-8?B?dmJXcC9qaG5zejNmdmpyZ2NlZjJXVzZRZzd3eExLVTgxWmRVeHdhTExRZG5p?=
 =?utf-8?B?WHFOUU1JV3U0dTFlKzdaellYUGhRYmFLcWcrczVoVWN5dm83Z1pEKy9vbW9Y?=
 =?utf-8?B?UkwzMjZKbUJBdGxoOVEyWW0vWWhvdjNQRHNaT1NYQVJ1RmE0T2FCbnpaelNk?=
 =?utf-8?B?a21EanczRW03NFZXeFk4dXpJd3cwQkZndUoxSVpPYmRkZmlkN3FNS0s0Nzl4?=
 =?utf-8?B?bW91eC92ZDNzOHpHOGpkMkhQSk82dkxqbFVyRVB0anpFY0JFK21vVFd0Mnpv?=
 =?utf-8?B?RHBCeTFnWVRoTzhZRkplT0RsZDIyTVFWOXIzcDlyM2ErRHVXZTZES2hzSVFa?=
 =?utf-8?B?a05qT2FZSlh3Y21idmZPZTY2Z0MvUHlQREJKaXhGSDRlZUlXak94T210NVMx?=
 =?utf-8?B?VE1JQW9mYVpSeG1UUHJJenhacEpVTXU0NzBiNXcxSDlOVHo0bkN5SlR2RXl6?=
 =?utf-8?B?eGdSdUZFL0d0a1Ryc2JyZTM5N1o0WkxqMEdxL2c2OS9laDNaeUFpSmZpSGZS?=
 =?utf-8?Q?IwVgtUJjRVku6cOy4oJJcLUiQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14638e48-bf0d-432d-c70e-08dd82f9f9c9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:33:50.8200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMVPndhUTieYHarNGk5V+pDyQZ2dFcmU9s/SXzhp4/skvowm7ATxMveQYaz+Eilip/ff29FD0thMYVWF9KhjJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7738
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

Changes for v10:
 - make firmware: scmi: support to manage SCMI protocol drivers with a
   linker-genetated array part of add i.MX95 support

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (12):
      firmware: scmi: support to manage SCMI protocol drivers with a linker-genetated array
      firmware: scmi: use scmi_proto_driver_get() function to get SCMI protocol driver
      pinctrl: nxp: add a pin controller driver based on SCMI pin control protocol
      firmware: scmi_agent: add SCMI pin control protocol support
      clk: scmi: check the clock state/parent/rate control permissions
      sandbox: add SCMI clock control permissions to sandbox
      cpu: imx95: add i.MX95 support
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

Ye Li (5):
      scmi_protocols: update struct scmi_base_discover_list_protocols_out
      spl: imx: use trampoline buffer to load images to secure region
      imx9: add i.MX95 Kconfig and Makefile
      imx: container: add V2X container support for i.MX95
      imx95_evk: add i.MX95 19x19 EVK board basic support

 Makefile                                      |   3 +-
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  62 +++
 arch/arm/dts/imx95-u-boot.dtsi                | 188 +++++++
 arch/arm/include/asm/arch-imx/cpu.h           |   2 +
 arch/arm/include/asm/arch-imx9/clock.h        |  10 +
 arch/arm/include/asm/arch-imx9/imx-regs.h     |   6 +
 arch/arm/include/asm/arch-imx9/sys_proto.h    |   1 +
 arch/arm/include/asm/mach-imx/sys_proto.h     |  39 ++
 arch/arm/mach-imx/Kconfig                     |   2 +-
 arch/arm/mach-imx/image-container.c           | 119 +++-
 arch/arm/mach-imx/imx9/Kconfig                |  15 +
 arch/arm/mach-imx/imx9/Makefile               |   9 +-
 arch/arm/mach-imx/imx9/scmi/Makefile          |   6 +
 arch/arm/mach-imx/imx9/scmi/clock.c           |  70 +++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c      | 133 +++++
 arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +
 arch/arm/mach-imx/imx9/scmi/soc.c             | 749 ++++++++++++++++++++++++++
 arch/sandbox/include/asm/scmi_test.h          |   4 +-
 board/freescale/imx95_evk/Kconfig             |  12 +
 board/freescale/imx95_evk/MAINTAINERS         |   6 +
 board/freescale/imx95_evk/Makefile            |  11 +
 board/freescale/imx95_evk/imx95_19x19_evk.env |  91 ++++
 board/freescale/imx95_evk/imx95_evk.c         |  36 ++
 board/freescale/imx95_evk/spl.c               |  69 +++
 common/spl/Kconfig                            |   6 +
 common/spl/spl_imx_container.c                |  41 +-
 configs/imx95_19x19_evk_defconfig             | 152 ++++++
 doc/board/nxp/imx95_evk.rst                   | 114 ++++
 doc/board/nxp/index.rst                       |   1 +
 doc/imx/imx95_container.txt                   | 136 +++++
 drivers/clk/clk_scmi.c                        | 204 ++++++-
 drivers/cpu/imx8_cpu.c                        |   2 +
 drivers/firmware/scmi/base.c                  |  24 +-
 drivers/firmware/scmi/sandbox-scmi_agent.c    |  56 +-
 drivers/firmware/scmi/scmi_agent-uclass.c     |  50 +-
 drivers/pinctrl/nxp/Kconfig                   |  13 +
 drivers/pinctrl/nxp/Makefile                  |   1 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c        | 162 ++++++
 drivers/power/domain/scmi-power-domain.c      |   8 +
 drivers/power/regulator/scmi_regulator.c      |   8 +
 drivers/reset/reset-scmi.c                    |   8 +
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
 52 files changed, 2947 insertions(+), 100 deletions(-)
---
base-commit: 233fda6af674736dbc6ff37a9ef003b9fa4b8074
change-id: 20250424-imx95-92d261b3a1c6

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

