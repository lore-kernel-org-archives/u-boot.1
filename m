Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B45CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 12:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F1428384E;
	Fri, 17 Oct 2025 14:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wPtPhphq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A443D83655; Fri, 17 Oct 2025 10:20:24 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA701807B1
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 10:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXOQFrCz3hpeitDuxMwmeuKjIyKyvtPH7/RXmYp/s/40vzl1JHhmDzc9agsJ2XeRT0s4UPpew+9bKWmAbZi1mvJ+7f4mop2zDS+YGYsnlQk2Y3yiZROPIxs60aIlarqh9zS21+9sOcLOP/6mY+e/PcPaac3iSvxLdwxUv9Whhf7+JYGM97AMgHMLGM3jv3+4OM6gpdGCEm+obF9u3BbCMIxUP1wtO/sfzdKQpGp9t6DemAR5/Br7rejAffO7zzk3wLzPiMfgO4VxyAfOIScVpzNrhr+9RNvm0IRCYbikfg+o1hGuWhNKgXLgRGvbVCdyt/cEFuB86dHASjMWE+iMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pm1LoAhWanZP0r274nysqp2PhPqSCZMMpEQNrf6Ao6k=;
 b=j8uF5ul9dlL1CFRRmf+ykozQmFPCoHcTFwSxxBeO2FML5jzSsISo5sPvZdZEG6hXAfC99vIC45mT3Sywk/qfmBvQ62ZwUfDtQ5uuydiQhgztCL6XNLo5HLpu5eb3eqSM5zVGPsxZUW23lCdPlCK8kq5Am8TISlyj8zo0Rwbm71hEtB7HbbNy9Wc9JVEpEH6HgKISZVcje7rKn11FcMeMYAphLWEqhKX+E2NuqS8pYR1dEiVmGwEwhVeP0BB90Nha9cJ9JUCnBtKLLz9hEyUH0x3uFtrrgEkIRJM0fhlzOHj6SAEZsWEOylRAiMHSxtvnI4ons6D7+dZ3AJuR/On8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pm1LoAhWanZP0r274nysqp2PhPqSCZMMpEQNrf6Ao6k=;
 b=wPtPhphqy8MZpRAdo8Ja7gv1eM+1QY5YD51o1SIWCaZQL6l+xfVS5t3Uaxqn5v6V8+zLTaDOm6vS94y259scyaNpJxw7Ju0enEGZHgcLmLlMHVggExMTLdf16SLBN4ZDID7GMQxpSg7I9Jo5jnyIs1NWqPYeK+YXCewrhTWh1Heak74JmOGGVm6GlM1Oef/JcVlcm/MkBFVagQnIWOg81ED5I5mTmntc2v0UTG94nBUUcfyLxdrD9NQE2cRdkx/kEhwT1h6uZrQEwwy09AZD5sJa25+5ZNRUwyjwGrbGnNd9/jClxSF9q18UhCt7pDzjGnxrGGNxYJgpEXUG/RHpyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9988.eurprd04.prod.outlook.com (2603:10a6:102:38b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 08:20:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 08:20:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 17 Oct 2025 17:32:31 +0800
Subject: [PATCH 2/5] firmware: scmi: Cleanup the SCMI MISC ID
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-scmi-lmm-v1-2-9fd41e7a5ac0@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11c250c6-3005-4267-e167-08de0d56035d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVpDUFU4NDl6NENyTlhqdnlLSXA5ZHExa3Flcmg3RFV2ZlRKRllnTExMMkVZ?=
 =?utf-8?B?WTRPc0pLbHNQdG9jUFhBdTQ2UktkTUhJV1hJTnNlR3cyVlVyYzFWNW8rUnlm?=
 =?utf-8?B?QU1TN3QxQjVHaW91bE81K244bWRndFhvM3F6THpyWEF1ajdtcklVWEhteTFB?=
 =?utf-8?B?eEFiUFNIbm5WeW9rWHU1bVh0akswUStvaGlvVmJjRkxHWnJWTHdTU2piVElp?=
 =?utf-8?B?U2M4eWcwWUZjN1B5QjY1QldxalZpelE4QjljQ2kxK3FYUXFQNDlHd2cyQTk3?=
 =?utf-8?B?Wkg3ckJTdW5aTUszakJLaEl1aG94NUFYWnJrb3lGZk5HdzEvZzZrOHpScE9r?=
 =?utf-8?B?VmtRTUxRTExvR1h6KytxdkhER2FxTmxDSTNIWEoyTld4OTBQYXo2dGl3YjhC?=
 =?utf-8?B?SjJjWkdsOUdadDNEMHdaSDQvMmhDZDFzdWNPWHpDQUZwVlNhbW9uWjFxV0Fh?=
 =?utf-8?B?bHNyQTZFREQ3QXV5SVhxWXErWFBkaGN3eVN5c0FMODBTQ0NpRWVpM3dOWllZ?=
 =?utf-8?B?cm02VHZQZEgyL090b2JZQWhGMkZhK2l2SzRMRk5KU3lhdDBhaEJSLzdYYk9Q?=
 =?utf-8?B?VkxmSUhsYjlCbUp5VU56Wm1IVzdzWlZyS012UzdWWVQzK0hPbXEvbWFBTkdW?=
 =?utf-8?B?K3A3ajQ2eEVrMW9wSllRTDJwazQ1VnJSZG9HWFJINVM2WGl5MnhrZFhaQnJW?=
 =?utf-8?B?Zm9sdkJabTFjbjRIU014d01OVGYyYUJOenRGazM5eXloTndncFZOYkxiek56?=
 =?utf-8?B?ZmVIVSsvc2dHZ0pSSVhWdE42OEd6TVVLQ3cxLzlmK0U4a1pzM2srVmcwTVlB?=
 =?utf-8?B?ZStybllmK1IvNzIwaVF4SUpCamwrS09jcjJiSlZnRlE2aURZUEZ1Z0g3VEor?=
 =?utf-8?B?MFUya0xUTDhJWjgzRjJpbngxaXhIRUh5aGVFajY0T2JKOGJGY04zbTZ4c2Er?=
 =?utf-8?B?ZzZzb3llZXVJcTAvUFFIdkVQeUxTTG1KUENKNndCNXppTVRVTVNnRmorNEdP?=
 =?utf-8?B?Nmx6cWZLUEFYUlFIa29WNGoyMGs3dmcvYm9UTHd5SWEySlc5bWRidi9FS3RZ?=
 =?utf-8?B?aVdVZnBEQnE2bDZwU1VMakN1Qyt0Z1BNSFNYbTd3S0RFZWxGRm42ZUJXc1E5?=
 =?utf-8?B?YWxHTEI2aGxMR0ZzczZJVEdZamxrdi9EaFJScUtrYmp6NFFDMk1xT3dYaUxN?=
 =?utf-8?B?MzRFZVlwMVFaK0ZOazh3S1g0b1JUaTk4R25kb0F1TnhTSVdxTlFFdVowUFFn?=
 =?utf-8?B?MlhJOWFMNFlYcS94Vm1pVmU2YjFTOFRuZHRsZ1FMOGtKWE1pWXUzandLa2FC?=
 =?utf-8?B?elhyZlRwbFBjVDZsKzgzVHBnazdvTVNQVkhSUXQ1RzhSL2VzOVp2Um5Yb09C?=
 =?utf-8?B?K2ZkS2Z0dERzYzRCMWlWdG9CYjNZOS9lZ0hSZDJBQTI0Q3JqOUw2d3lDeCs3?=
 =?utf-8?B?ckw4c2pJc3hHTlcxNlpObEM1M1ExcVpMWGxkS0lPS1VFVVdQenBPZjVqS1Vr?=
 =?utf-8?B?emZOSlFqZ3ovM05xc3FkUUpPdk5rekVvUDZ4Mk5mVDIwYS9WditERDk1aVFY?=
 =?utf-8?B?YWFPY1dWNWFrbzNQWldJOW80VVRZYk5DckpXLzl2NFl1cUpFamk1V0F3Ynk4?=
 =?utf-8?B?eWFCVkdPNk4xNWJtTkMwemhrUGNCYjV3SE0wYjZ6eENoWllyaWFPV2REVlpu?=
 =?utf-8?B?dlp0dksrekU3Q3Z4dmE4blBzZ2VNQXcrQmp3WHBLYWU2bDEwMUZ2aHZrbGJt?=
 =?utf-8?B?VUZhR1pzYktPYWhUUFRZVU1KZXVrMzFsWjQ2NlJZclh1c1gzbkRkS0FrWW04?=
 =?utf-8?B?d243aG4zV0tUaWcrYW5iVmdPSnN1emhNbHRpWnA4Z0FkeFoyajJWdWdqa0RC?=
 =?utf-8?B?dlJQMWtVRXU5VURNY1lhVVJqYWFCRnB6dWgvdFNVblBaMC9YODhOcDRHOEhD?=
 =?utf-8?B?ZFlhUnJ1L1BONkxuY1NYMW9VZ2VVVDhpSE1KZDY1MlFia216TTZCVmlIV0Fu?=
 =?utf-8?B?anluUTJFVk5pT3NmODNBOUo5ZzVBd2RseHNxVmRjSW9hazZ4Q3daWnVaeGxU?=
 =?utf-8?Q?7B4nk0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkF3Tm5STHlxWjJHZFkwY0lEa2ZDWU9CTGZGeUhJK1JEdjBIOENiMllnbWhm?=
 =?utf-8?B?TWxZQmdORENPdXdYOStOVTR4bHJwNjcvTXBUTzBGd045eVlhQkluSzBuSFRa?=
 =?utf-8?B?bnRadnY4TFRrN1kzWlp0dk9KUkMwOW85dlJ2d0pOU2RrUzY3Qmd1S3gwQmQy?=
 =?utf-8?B?YStweEtHUk1jeThhaVl1eEdiVEhTNFBwbmRlYXhxNWNPa3preENGQm9oUXFF?=
 =?utf-8?B?aUdORjg5dlRjV1BHcGt2T29jV2F6eUw2WWNmWFViUmpOcHFxajc1UmpOSVdK?=
 =?utf-8?B?NXYzMHhTRXFraGhwbjhKK2lFTzlMNEw0UFlwLzZsNGg1Q1JLT2Q2SUR6Nlgz?=
 =?utf-8?B?dHhnbDkvZm1JVnBNYVUzOC9UM3dvR1JabkVmc0dXeFY3Tm4weXp2L0VUUE5m?=
 =?utf-8?B?eCtkcFRsL1VteVR0TGxpd0ttczNuMFdzQU4rcmR0eTZYN0hud2hXcC9BQU4x?=
 =?utf-8?B?TEFwTklyaGlRVDZ4bDQ3azNJa2Nvcm0xeTR6VThBZ09Bbk9SU2E2bWpweXkv?=
 =?utf-8?B?RWtLN1BUeUVtQS9FeHRlaEprTmZ1bWY0a3dOelVxWFR2S0JKQXNsVUhBRDJ1?=
 =?utf-8?B?V2o2c1RMTE52NklvQTVEakhMWWJqaWhkeTYxaDUxWnNQYTY5NG1hK1BkeXJ5?=
 =?utf-8?B?cmMvRlh0Snh4SGF6WHpQMmlwaTRmaWJKajc3aHZjMmNwQ0VkR09UWkFWdmkx?=
 =?utf-8?B?UVdxWCtkWjBpRlhtNE1ZSGhzV0hwdUhGbjRBRjJtV2dMSzlhYXUwOSt2Slhq?=
 =?utf-8?B?eUtUQWkrL3IyOUpxWmlhWUozTGRDUjAwUlFYa21MWXRQVS9JMy9mUHl6WExE?=
 =?utf-8?B?bGduZDJzUnQyY3ppK0piM2wzTVFuNUlFMFNTSzhqb2gvd0Y2V1ZFenRmdWdz?=
 =?utf-8?B?NlNSMCtCK0tSYkpGY3VDbzJpYWdZOU5tS0NuYW1hM1pEZXlZMjRYQlEzMmxp?=
 =?utf-8?B?OFhrYlFsZWRTemN6blJMQ3hPakxON0xNajFtemdxb1VJMzNZSUFWdFBuYUcx?=
 =?utf-8?B?RUlFM0FOOHhESittMTFjRW5zYzV2Ykg3MGZ6S2txcUoyMi9GZHVJempLUS9H?=
 =?utf-8?B?S3hZUytpclQ2Vm5tZUhKSXJacXRWZC9QQmRycW0rRDA0di9MZW9DcU1jbXQ2?=
 =?utf-8?B?Yk9NbzJzYkYyUVFmSEp5RnJPMndRRTk3UmhMcldRUDdFWmkxT3haN0ZldXhX?=
 =?utf-8?B?ZVdVSVNiajlBUXUreVVwVCtPclViVjZEV0xsbkp3amk3aS9IbDU3NFYyY2xV?=
 =?utf-8?B?dVl2czMvMGFPMlZOc0VqRzI3Tmc0Wmw0RWQydDlzdnEvckxsZmhTYVpwUmxX?=
 =?utf-8?B?Tkk5MC91ODA0Yi9Uc3RmVHBsUURNb3Z4bE5KK0VFRkc1V2xuTkJ0SmpHUnlv?=
 =?utf-8?B?b3p1c0xaOFNmTWlPTWllZmVsa2c2TFlPeDByTzdJYmVhRjZqSktrT2M2Qi9Q?=
 =?utf-8?B?MVlVbTA5MmtuWmF4ZXBjNm5mcmpKeHFhcEw2UHZTeGt0dFNoT0doV0dRc0tn?=
 =?utf-8?B?bkg3UXRWZXVGM2VKbWNrYnJDM0NYUmVtcTRYN0dVa0w5RjJGUXRFa3B3ZHUy?=
 =?utf-8?B?MzdyTFRHUG43SVQ5L2tKdUQzckpxOXpGdEFXOE1JaGlBWGhjeG8zR2RUSWh3?=
 =?utf-8?B?dDBxMjk4VThIckowT1lhRzlFVXNnRitPeS9wUlBxeGpObmRIOFptTlEraVVN?=
 =?utf-8?B?TVIrRjZQa0gyRVZZOERZcVY4cEJlT2R1YzlKRWt4UWdrTkRDRUJPaVVCcUVO?=
 =?utf-8?B?N0cwc3ZEejd2TlVsTEFlcXpoaVVNaVEwNzVLVDZnMGt2MGovdlptRmFIUnNB?=
 =?utf-8?B?cVl0YzRmMFUyNkpzOXZ6S1o3U0w1ZXJ3Ky9OQUsrMlU4Z0daSzNkL3JNWCtZ?=
 =?utf-8?B?VEVBOGFWdkJqOUJLTE51TkpaSU9pVlBWamFEQlF4VFFwQ3I4SCtMMlNsZzd2?=
 =?utf-8?B?OTcvMU52bmpseHQwRnBMd3U0Z0MrOC9DVWdtVkt4RDg1SkRobWdGNWhoWjIy?=
 =?utf-8?B?TGVlN2ZyZ3hyQ1I1M25uWjNvbXdvaGw2OHZ5T1o4RlhoNkRnSHZtZExpanhs?=
 =?utf-8?B?T0xiTjZXaXljVG1oNGFNZlE5UkRyQjlySG81b2JsaVRrNEtLWGlLdnlhMTdE?=
 =?utf-8?Q?Rruts5xaXuBs5VrcZG2Sc12+g?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c250c6-3005-4267-e167-08de0d56035d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:20:21.0205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFAL5/eiFkQYc6qGhsGQFxEyETShqYpbjbr7zM268p6tXyb3/m0MRTlJTJME5H0DbSQSLqA7XUuKGZyyHHDsWA==
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

SCMI_IMX_PROTOCOL_ID_MISC was never used, so drop it. And move
SCMI_PROTOCOL_ID_IMX_MISC out of enum scmi_std_protocol to
scmi_nxp_protocols.h, because it is i.MX specific and following Linux
Kernel style, use macro definition.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/scmi_nxp_protocols.h | 4 +---
 include/scmi_protocols.h     | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/scmi_nxp_protocols.h b/include/scmi_nxp_protocols.h
index fe6ecd6a7cf5a4fb37115a8cfecf38d1e41e156d..7e2143b16ead05a2662d9b88d2d348ab16a5750f 100644
--- a/include/scmi_nxp_protocols.h
+++ b/include/scmi_nxp_protocols.h
@@ -9,9 +9,7 @@
 #include <asm/types.h>
 #include <linux/bitops.h>
 
-enum scmi_imx_protocol {
-	SCMI_IMX_PROTOCOL_ID_MISC = 0x84,
-};
+#define SCMI_PROTOCOL_ID_IMX_MISC	0x84
 
 #define SCMI_PAYLOAD_LEN	100
 
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 95e0c3cce3b9d4430383bac0bcb0a541f4af13f6..5c9516d5595c2f39ee3223a6cffab2a91e1cd97e 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -25,7 +25,6 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
 	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
-	SCMI_PROTOCOL_ID_IMX_MISC = 0x84,
 };
 
 enum scmi_status_code {

-- 
2.35.3

