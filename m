Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CF0C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7C99820E1;
	Thu, 24 Apr 2025 08:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GyJhEX9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF5B982045; Thu, 24 Apr 2025 08:34:44 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31B6A82103
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFO5WbggHi18vX5I7EUQZUcIFWmrqgIDCdGQnCI9GsLk6O51LJtXoydZQspMkEvRw0HKglmuYbbP7YWQOdIEcAqKKRbCLR7HvQnaEErl4Pv1BLa0i8dARKikrl/7E/hzSvHKt9s9fn+VjCxcyVKrdQeL/fxN+faTiMjsB/s+JBcCHPPQhh4czEFGm+3MmTEq+ezWz5APEtAEMo1vpe+zFWVQ5ZX199TkvDpzeId2jM+8FeVXd2INMoeFqhILfCzfUH5oWyRL080ScZNXS39Tg4wwabqiMdiAGtFzFyTKPWq1yvTm8M5vlS8W2RjOocCm0TAMmkOpVPHaAyO3j6VglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zfK9EdTagTGkt2JU7wimI8dKrGiI0F7TX+Yjdexn0w=;
 b=ASRUPeRzGVjG0xU7h89calONJAc+GBphW+RO4wrRfLOndIWR9vk0lDe7KVlytU1A7YGocAUQrKi0LQoMmtKdZVMelDgmbs5B63R9my7ts/IiJEz1R5Nw70lZtE0G1qd6YdZ4JIsVbOw5kQBdvLIq8zIRHKBR08gfE+3FkNgbUiFu+2Esrd4n/we1qegaatI1KJ/IfbsqigsUwsAivIhrx2u82Mr31D3PBp255r05jfzc+tvTpVj4hqihvdXWJIZXPM28nfBRNXZpBxCVlwmcN2iJ57D9ImU0V8gBO7CeYc97qUN6Cu/g25NwAwdPoCqc2XyXv7auiMpTVcwZ3jnqcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zfK9EdTagTGkt2JU7wimI8dKrGiI0F7TX+Yjdexn0w=;
 b=GyJhEX9X5fkHijxpdW7DP0BSV49o1UCeAtKsM15hFeu8OJvO4+1HoAH7CSrr0F9yyuap9uMNeKaquZFuC+IUTn8JDwiXbJHxE10O2d8zOvC9tNsa0q0XnwDigash7vwPZs106ZwrbxWdXcmToRLYrISm7mrC3ltESqk8qcm58NlN5EV6wZoifeSMCSZ7nTKk5kfq2zsI1PBOPQH3C/r52U2PZB2tZt76786nkChe99fqo88B1R2CjfvWX37NCs00CFqvioF+YgWWLQl4vW1oop87D/Vk64B/QY87tloj8w1FQcAGkdLVgwAY4sgzyNqM9/NWvveqrzbdiJVZIEdZUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:34:39 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:34:39 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:33:08 +0800
Subject: [PATCH v10 12/21] cpu: imx95: add i.MX95 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-12-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU2PR04MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 547dd20c-1f5e-44e3-5519-08dd82fa16f6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXpNaXRXMktTV0dDY0NxRDVacndqTkpvR08wYkR0cTJUU25rOHlPb1RmTCtq?=
 =?utf-8?B?NEJyQlZVRTlhQUNPR2thWDBEQmRpL0VXRmpRa29iVG9IYy9lNzB1bm1vY0Mw?=
 =?utf-8?B?aWpuTTh5MStYZGNxZEtyQzl2eEd5dzkwOEZIYndOaWprMkI2OVBrdU1XUlVt?=
 =?utf-8?B?QlBDdVN5ZEZnL3NUL2tmUTZvQ1FMQ25SNEJOWjRsU3c4YXl2NlBYVC8xK2Zr?=
 =?utf-8?B?S1kralc0VTRoOVhLYU5XanhOUDFQZDRDeWE2OGZMZUwrOGliaGdxSUxmd0R0?=
 =?utf-8?B?VG56ZmhUOHFvRWNMZWJFMTh6ZFZKMDA4QTdLTW9wN0Y1QnNiYWdUNzVxamd2?=
 =?utf-8?B?Y2ZEaHpDaUpWUnNTdXF3RDc4MXFYbEJvbHp2aFRhVmVEN2FRODNCMzhLRCtW?=
 =?utf-8?B?RmNySnkrc2xkc0dPRm1hNk5PTTBLak4zQzFmZ3l0VC9TdXpZOE5wdFlTSmpH?=
 =?utf-8?B?MXdxVGlKYVRacy9aQmpocWhZdk9RL3A0SDFPd3lQS1ptWHRwUlZiaVVnNmRy?=
 =?utf-8?B?T09SR2RYWXFNNmxmdXYwQTJyU1NtYVFRVVRhaVhGdDROV05HeTkwTHYrU3pG?=
 =?utf-8?B?M0J4MFpSM1VuTzg3WGZCcFhTaEQyeVAxZlJUSUhic3BCVlp5NE5OZllXaVRL?=
 =?utf-8?B?WjdhUUp6dmk1MlhuTWFicnpKSUNMUmhHVkNjeGJFRmIwZmZtcE91clo1dXZZ?=
 =?utf-8?B?a3Z1MDlEMktBYnF4eXRWSmNEU2NaKy9DMk1LK0prcy9YQ2dyNHRLb2w1RUUx?=
 =?utf-8?B?VUJYUGdpMTNjZExqbmtaYUcrMWl2UTA1N05BRXEya0F0T284VmlkWDJoVXk1?=
 =?utf-8?B?SzIyeVlXMjZSN3Jhc2g0WEdvNUVqSDYzaThCUldYaGFLKzM0RUFTZUZLQ2RX?=
 =?utf-8?B?b3R2cDFKZHpna0owNUN1M0hJY1I2cVl0Vk5CSVpJV1h1WUdBdndtZW9UTlJl?=
 =?utf-8?B?dUUyTlpySjc5cTdvOVFOUGZHOW80TWlIOVJTWTFXZENoeTczQXJVRnBTbEVE?=
 =?utf-8?B?NmhRVzdxdXNZbVNCTkI0R1duc25NeWZTQ0NEcXRWdEhZNEhBbm8xM0pyUEUr?=
 =?utf-8?B?Z2RJbWozcC9IWWJPRkdLeFlBb0pSR2dyc1ZsNjBSd3RCQ0RkcWx1SGtxaWVB?=
 =?utf-8?B?ZS9MZTZVaUpqMHB4TlNHa0h2SzkvanlqaXBuaktQSXlBa04vM2Y5ZlRhbVdx?=
 =?utf-8?B?cngrZTM2RXpWTmg0SWMwMnVDR0VYYVFWcDRpei85dkhCVXZNNlFrMVNRVDhS?=
 =?utf-8?B?K2lNV3NHR3lqZmIxOGJ5THJqaU9zQXRsZFZ3ODVoVkozN3ZRdnBnQkJKUUp5?=
 =?utf-8?B?SWZkY0J0NzJXcWhETkZ3MitHbi9hK3c4RnNJOFFydTlpS2x5eXMzTlh2SldX?=
 =?utf-8?B?K0QycnhFQlZ1ZStydEFQQk5zV3pKMllXWlNqUE5vaC9sUm1JZEJFT3V0K3Np?=
 =?utf-8?B?a0N3NHNIczF3M1RkK3BSS2dhOXMwdEoxNVYxMjhpdzE5aG41Umt0NU5CZ213?=
 =?utf-8?B?SkdFV3ljY3lOY3pmRXovL0VXNGdvRUEzZ2h2SU8xMW1TaVZUNlRsNkpjYUZj?=
 =?utf-8?B?bjhOUTZ1V1NsSHg4a1lQa2QwdzB1OXZGd1o4VVhqckFjeHVwbkhMVWtJdVRE?=
 =?utf-8?B?MmQrNHpNUlpSaC93TlJsVmZxbmd0QzBld244YnVsS0FLS2owa1UxVDJCdGd3?=
 =?utf-8?B?RFEzQjZSSUd3dXc1OGg5b1J2MHgyNXpCSUQ4R2ZURE13L0ZkN0hzWDhzbFVl?=
 =?utf-8?B?a0VKZUhjRG1ESW1aMm9DKy9BcWlyTk5LK05xMENicUhRbWR6cGJubkxyRWVQ?=
 =?utf-8?B?MkNad2VOY1kwNGxITEVMYTIwazVwdHI2WUhhbTY3Rzh0MEFNK0NQZTVXRmM3?=
 =?utf-8?B?WWpuMnQ1MXJpd05jb1hOY1M4WUZlSFVVbk9rNVVPNHdQc2tGUEJOT3pXWHlX?=
 =?utf-8?B?elJEVjNQMEkwN2FoK0hzblB3VmtTMnlaMEhMbGhLeVJsQURrQTRkbGN4SEVE?=
 =?utf-8?B?bVBUQ0xVZjRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTl3OGdsajBaVWFVRks1UTRhVnZ1YVUwNWdxdFB4R3BUWFBaNk1FVDNKOEx2?=
 =?utf-8?B?NUx3dk9GTWFYK3NjU05wWFNCWWhTNGoyVVljdTN3MU9LZ3ZsbkJKeTluZUwx?=
 =?utf-8?B?bmdxSUNBSGZBRE5YR0FZd1VydUtHdHdteGkzdzUyc1pXVjJ1dThrMW0wd1Vv?=
 =?utf-8?B?NW0wMk9FRHl5YTl2bDB2ZlFuVU95MStZL3J5bUhDNHFwSVNaYy9RV01Yb1lm?=
 =?utf-8?B?OFB5Q3RRWHBsVlJLQVZOeW8xSHlNWVVWWkpobTFGQUNWVm9PTllxNUJvQkN3?=
 =?utf-8?B?aFZLOGxYOHlwN3lmQXRYNS94cEJDbU1RZCtGQXZnOVY5WVBiUG9WTkdxWnMz?=
 =?utf-8?B?U1VPcU9GTFZEdFFDdGR3RTc4dzZiNEF6OTZNdjRKNVh5cDd1VHV2LzcvRSsx?=
 =?utf-8?B?dnJtSjhZUXE5SmIwQytTbHcySlVRK0pMNCs2RXBDYW1MYkY4MFE5ODBTL0JU?=
 =?utf-8?B?c21ZNFJ4N3VvMTNSV3M1dXEwTXE2ZVJJOVlhY2JqTDdPekd3THVUQktOQXZl?=
 =?utf-8?B?cGQ0UjNjeG1yMVNBeVp5R2NjRmlNbVN2Zi9YVERpOTV2enpEeDI4a1QrbGkx?=
 =?utf-8?B?eEJEWm9sU0dpUTFwS0lGRUZJVGp1akYyRk9qKzJNYW5ZZWRpZFpobEhvQXU1?=
 =?utf-8?B?RTZZU2RhdTNVSVRhbjU0Q2JIb1NnbU1UQmRmbGh1MmdsdkdKc1NWaldkYUli?=
 =?utf-8?B?QmZZZ2ptdTUwRlQ0QzJGd05DNk5mL0ZOZTBiY1FGcXVDTWVCb2ljRFVoS2g5?=
 =?utf-8?B?dUpQd05Sa2hKUkZ1MnBFZzl3OFovb0N4elZCQ0ZmL1ovMFZ6RVlVMWpSZ1hm?=
 =?utf-8?B?L3JCTkl1TU9Kalk1bkM5RHRuWlREQjhwOWo0R2RuWDNBUFBsdDBqRHVOR2VS?=
 =?utf-8?B?R2lBUEp0bFVKNGFHZ3FxWE10RmpUOEJHbTluSHRsRmxlK2NadVdBdldISzhH?=
 =?utf-8?B?SzY4K2lmMVZ1bDY1RERrSHkxWVU2RE9MZ0ZjcDJaeUpvYXdvbnBsN29wUmI1?=
 =?utf-8?B?SjJNb29XTGVUMzl0S1FsYVdXQ0QrdnY1b0hHQkIwU2V0d29lZnJ5SFBhQ2pi?=
 =?utf-8?B?QXhFZjZYV29DY1VWc0NhVHVMNEpGYWFsVzNmY3RZSEtvMUNORXNGaFZvN3Vm?=
 =?utf-8?B?Uk8wNmRXSjROcWwyRTdqM3ZTSGxZMXN0MlZJYlFqK1N2TUZYVEZsOWdTL0px?=
 =?utf-8?B?RGRoeGZ4RjhSMWRMY1k0a2FkNzNTaUxqckVqWDdpZHJtUTRYbm5VQ3gxZUly?=
 =?utf-8?B?WjZOK3FRUy95ZnhaVXNRWUhDQVVHZnNvSDVzTnZSK0s1WDg0enVFYThZVmRm?=
 =?utf-8?B?alA0VWZGeld0dVBBYUdnWnNsMHdSZjNlK2s1STkzWWdoYWJqNWlITWRERjcv?=
 =?utf-8?B?N0lHSEFVcHhpd0VGMTFEMWZaRFZyelRsdjV3azM1R0hVSUQzMExzekVQLy9Q?=
 =?utf-8?B?WDBZUEhyZ1l5TjJ3RmtkQ2djZW81Y282a1dLMTdGc1U2OXVuMzdEN25veitO?=
 =?utf-8?B?SXNBZGVENHRISGdQK3hNc0p6dFEyc1NrZFkwMTE3cmIxSDM5RUxZbW5aNEVp?=
 =?utf-8?B?VU1zY3dUbXhTL3F5YkliMGYrczFlWC9EcXBod2lIYU9LSXlBTWVzbitOc0Zi?=
 =?utf-8?B?NGdycVcvd2FIT2tEaUxzUHIyV0wvZDdFT1BEbnFZamFCZUlVTFN2amZzZEQ3?=
 =?utf-8?B?Ry9RUkRqR25TdkozSVY3eUt3RjdIaGU5a3V0SERnTE8yQzRyQ1h4bGd2VnZl?=
 =?utf-8?B?RkYzblNxTm9aVmphZE1Od0xqcjArclAvbFlrN0JEOFNJR295TkhreHdrVFdp?=
 =?utf-8?B?WnFPdEl0MnpLaEFJc01NOWJRK0tMY2VTc1BWek9wQUx5Ri9FZFlUb1o3QktO?=
 =?utf-8?B?d0ZHVlRhU3NOZUZGZ3hqL0RJYzR0TWpVWDl4bGovckZ1VUFlUkEyZzVKYS9T?=
 =?utf-8?B?dU4zNm5McHVyYmNlQWk5eExBb3JFa1ZwSVRiMVhrYjZVM1NXblFVaVlMYjVJ?=
 =?utf-8?B?dkxuY2laeDgzVGtPYjZmUlNwaXQ0ZEpxV3NvNnZaNkRpREhiNE9hSzFHRGpv?=
 =?utf-8?B?eG0rVERsNlFRSzJKQkNHak1sdjdwQ2VHTFZ5WjR1NXZscUlqbE1hM0xSREo5?=
 =?utf-8?Q?GpT8w1OCuLtsakR3Z1mq2mXlM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547dd20c-1f5e-44e3-5519-08dd82fa16f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:34:39.6926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kp5fom3xZD/uyO/kZ6IL2nm1BtN+w73m7bSIxz+db3LlkkzsCrZCcjq57yr1n5ldbv6XnMPSLW3nfwe5LX8v5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965
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

This patch is used to add the imx type string of i.MX95 ao that the
i.MX95 CPU info can be printed.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/cpu/imx8_cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 4e1eccaa5b0..4836bddd93b 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -111,6 +111,8 @@ static const char *get_imx_type_str(u32 imxtype)
 		return "91(11)";/* iMX91 9x9 Reduced feature */
 	case MXC_CPU_IMX9101:
 		return "91(01)";/* iMX91 9x9 Specific feature */
+	case MXC_CPU_IMX95:
+		return "95";
 	default:
 		return "??";
 	}

-- 
2.43.0

