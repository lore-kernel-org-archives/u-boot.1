Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A55C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B504807B1;
	Wed,  5 Mar 2025 14:30:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MSWvubdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D30EF81276; Wed,  5 Mar 2025 14:30:15 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE3C1807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4ROeOiuFYM5YM+SOU8tSRPnDmJNmZSkm22oVXXx48wBRfcgm9NpKZ3O9JoCLOC7em5LS8AbnU6uAKxtatD+Uf7pHZ2yurjIHzn7/uagoazXKp2d7mMo7JIeo2GB6f85zaJu9itZJ4ErSCODc8L67ghVZ5Y87LtxbDDHXONJ5cY55wgZIavLVFuKMBJvoW2jW+FHCzNxj1UuixrEZaEgYHjskwj+jBlWU/j76eyaL8WlevMTyzxhQ/kAVXgKpPjQTmL4zfDoGZu/0iWAtXtAVtWyDq4U05ZS0B9askqe89sQhRuTdaXlGcKB5Y6Rk+G1UUeZY6x7SiquYMduKQGz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ME4kj2ycxj4YbGXpHBZmyHzkyztYw9L/EvWT8K98rw=;
 b=MALeRm3hlrVfJBrJOFY/rfwFu4xjlRJpBthmoOX3oH5zGllRzRpl3yYdXXNtPTdamV0ec3ImkKHax47O0PMGCGKBvAPPSW6TeoGvWDunsWFRgRxh3JBsNUYfUsMkEyxhUXVe5Fnhdt1lAokBlaHaS5ZeyL1l3bsIHogzn83XcYa2JnEAlAe3H2HyZ1NGMzJNrF/XYuXX4Ewk0i3fYJUOBH+2Df7ulFOhH3tg6WvBkR98mcws2HisHF3loOG1Due2inKjVq/OyzvXT1HUrlY7JtWV7JFeeoI9KM29uzr53ZUue1dOzrOb061RPwJYHdYd3Q4P/PmhEvEYHI2pPFTc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ME4kj2ycxj4YbGXpHBZmyHzkyztYw9L/EvWT8K98rw=;
 b=MSWvubdzYIk/hylptJ7k7Q9ftP5ybsTFx083yNS5vTjUvc718CNHTwkWWdW2QMqFwTRBiwjl1GWiddhmQpKehmYJLm6xNuPg80oyP9LSsZ+/RkZl8dSgq1AMMMTMBvKXi1s2yTa01Mjn74r2RFBXzCpRPGmEIBQ8/MVmxbSPoA7rH3wj0MoHmZh+lLsf0rl8osU5VDezIe7VwzW9TpN63dmT0Gv/asrM2enEe0FT+QpAxGBYxle6wZADngtddOTmxuZd0/56PylA62nf2JBF3g4zuq/0f3rE0EZKlenAEjHR2fb9iWFnTgQ0sPo8xgYDYLZelT4A5ZkMvcu6PuqRpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI2PR04MB11028.eurprd04.prod.outlook.com (2603:10a6:800:27e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 13:30:12 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:30:12 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:29 +0800
Subject: [PATCH v7 17/19] doc: imx: add document for i.MX95 Image Container
 Format
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250305-imx95-v1-17-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI2PR04MB11028:EE_
X-MS-Office365-Filtering-Correlation-Id: 452ced2a-deab-42f0-3ce4-08dd5be9db3a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHlaczZvNVVkUFVkcWNPdzV6OHBNQ2N6N0tORTdDS2EzdGlYcUNTZ3FBcGhx?=
 =?utf-8?B?ekhtMmxkd2R1VGxhLzRyQWpEMlA2K1JCMkY4ekxYYVRwcFoxOEtYbmVMZCtI?=
 =?utf-8?B?bVVFVFJaYytYemMzbk4vbDRwYnl4WmF3TzdYakl4UkU5anN4bFZiVXpWTGR0?=
 =?utf-8?B?Mk5qT3J2dGtVTkxqSmF6bWlEZUlPWXRXcUMycU8yR1hvSFByTHJldDdnL3ky?=
 =?utf-8?B?ZCtXbDRiOUdmYVF6c0c4N2J3NDdMSk1sdTZBZmdrMGZlMFkwRGhQOG1aZkpF?=
 =?utf-8?B?TktsbHNzZ281M2lzRHBzMzc0VDlCMjk0N3ZyMGpQaWVqTUUzVFZsUis2SlQ4?=
 =?utf-8?B?Q3p1cEFQWTVhK2dLU296YmJSUEsrVHg0cmZmOEZZL3VGWk1rbW9ZdjVxL2Jt?=
 =?utf-8?B?ZzJOWHpPTGVGcHNzL3UvWVUzU3kvK2RkUk5peTZteTdqTmlJd0FwNnhwSkZD?=
 =?utf-8?B?TXM2MkVBYkN5K0FBSVB5SjlXNGZUUk0yTXhYb1A5a2FKWkRUUWNwOThmdEJI?=
 =?utf-8?B?TFU0QWxsaVRDdXpRemxHSVdhd01ZdThTWnE3a0hINEt1MllsS1lGNS9oVnU5?=
 =?utf-8?B?alJTSkVYZEgzblVhcmh4UXdid0NJM20waUUrQVdHUXZhNFVJQWpwMHFmdVFq?=
 =?utf-8?B?V09zVUt0K3FLOHlGZ3lwRXZxRCtxSTFUdXluZlE1V1hhakxsbTJIeVU3T3Js?=
 =?utf-8?B?Y3VONXc3VlVneDZ4NGc1VU13M2lVdGVMT00yUmJ6MFQzVmMyMUdLYUZIbnp1?=
 =?utf-8?B?L0lQYVZtMlFqYlRCOXRHbWltVy9vekY5dXE3Wk4zaVpTTTFBbWUvQVl5ZWZz?=
 =?utf-8?B?NHZuODZ6Y3VVc2tVZmw2ZG8rRkRWTSt3RjhBNlRzQXI4T1ROZWpzZE9ucVdi?=
 =?utf-8?B?K0pEbkJrNlMvZjg3ODdEMHc5RVpkbytUajE3WFdZbW9nc3EyUGUzamF5OExQ?=
 =?utf-8?B?cFNJNTFna0Q0eU4veHNCeTRUQ3U3ZlBZRFlhRHJDdlcwWlQzaGM4UG9xWW9m?=
 =?utf-8?B?WWJPRGNQQ0hwSy90SElMWlM4U2RLYm40QkJBcnEvNmtBaTUxbjFzZm5FUWJH?=
 =?utf-8?B?YTBaYk1PZ25IWkFtZTVYRjA0bXRoYi80Vndvamg5L2pLbGQ5TjkzekpJblQx?=
 =?utf-8?B?R3JNU29wNXREbWJzSDhiOU9FYjJSZmxBWE1YN3E5YUdyMGtVaWx2UEUwWExW?=
 =?utf-8?B?d3U2S0lhbmhRQTFFMXppR0Y5SzZNbFRQQTdZU3FPbUZtM0s2ck4yZzg0UGtT?=
 =?utf-8?B?M05MMm11V0hNaWxqQVluODZ5UkhPekFFc2R1OUxIMWp3TlZLV1gwZnQ3RG1X?=
 =?utf-8?B?ZlpHMmlpamhBMVp0K00xSmQ0VWhtK0R4Tys1QXJRNDlTN3ZjWTdWYVZvNGpw?=
 =?utf-8?B?Q3lkcjlnWGxTTUdSNFZUOUZlRDVWSGoyM21GeFlXTmlMMVBpem40aW5NenhS?=
 =?utf-8?B?U29EN3pGMUcvNWNadmFmYitJN3RJckpXUXlObXY3Z2xKRlB3aGlZN1JVSVo1?=
 =?utf-8?B?NjUwWkFMU3pvRGJZTEVFSTNtUkFUM3VqY3dscEpUTXg3czJPWXdWYjEwMnBk?=
 =?utf-8?B?aTNsKy9RSy8wR3kwU0tXWUtvc1VuWklRanZpZXhBSWlsZW95WEwvV3JzOFh6?=
 =?utf-8?B?WFpMaWhlTGtrM240Z3BDYktCRzJNSXh3UE9TR0hpaGo5UHRWQWxwbGVxSFNw?=
 =?utf-8?B?L1dyejFqSzlQN0JybHlHeU9jZWY0QTZFcUtEbEJjbVU4amhwa1J6NUgwSG5Q?=
 =?utf-8?B?UW9LTytMSmI1cHdKYm5DVGFCL0doUnkxZ3pvTWhHSmt4VlJvUFlTdEwvd3Y2?=
 =?utf-8?B?ZmZHWHlYTG9ObzFvYmpWR2JPRVVtSGFaWUtqUlBlQU5kNFZkalE0S0IxUUt6?=
 =?utf-8?B?NlgzanE0Vk1QQm5yQ3BGTmg2OGJibnpBNjg5dTVxRVJlRXRsd0FXUEk2U2Jn?=
 =?utf-8?B?MXNmSytTNW13OTFQK2RuMVhBQy9ldkkxSURSZlRWa09scXJ4WVBYQUJYZTRY?=
 =?utf-8?B?UEhkUjVDU2lRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW44TDZxd21SNFUzUWZTUXN5YzhIaDM0NkJvK0JoTFpOQTRiL3lDY01MbjV0?=
 =?utf-8?B?bUhzZ01pM3RyWnRCMjRmeE8rUHBRSXNwQzgyZmlPbDZuM0tGRERJTHgwL2tk?=
 =?utf-8?B?MlRjTk5uMXdyckcwMXpIMXJNamNZUld6Rm9EUmo3Nnk0K3gzcXV2ci8yaW9a?=
 =?utf-8?B?SWxhTGM1aEVpaVNIYUJZOFJLRTFFZEFZOWpsNFZoQzR3RUlRMXAzaVpYSzRI?=
 =?utf-8?B?MmZZbEluS3dlREU1dlRIamYxWHBkQ2hyWWU2YW05RzdvNys4S3BhOWwvTFBz?=
 =?utf-8?B?OE15T21uQVNCZ3lKMnVoNVd2LzBweGF1VDJFWXQvSklaVzlaVlZFLzVHdnFM?=
 =?utf-8?B?a0hoemtHSkVYcnVuVmRSc2NtUDFLdWZtaFNVY1hrN2U3OElJbFcrK3JXVWto?=
 =?utf-8?B?UFpRTkxrVDV6STZkNFhGaUJaSkFhUjdvTG00VURINXA5MTNTZ3JvY3ZHNkFr?=
 =?utf-8?B?ZVdLU2pvQ0Z3eko3b0lEN1hSY09IeHFHSWtxYnhFa2lmT2JjVFNhOGFtUmpj?=
 =?utf-8?B?MXdsdGphaGN6anFDSURQV1RFMlNmbnVlV3RtY05UeHVJeUtDcVJJUE1vSEJ5?=
 =?utf-8?B?RkJyN2NlVjl5WWdhUlBaOURIUHJBSEcxbXExRDZVK2JaZm1kRmRiek05M1A3?=
 =?utf-8?B?WENTWlgzZGk5cEE3MGhsbWVKZHEyb0pvRjM5ZUZYR0YzclI0eE1GVnFKNVV2?=
 =?utf-8?B?ZHArT2x3MVlRSis0UXJRdFF0cGZpOHFKSVNOdkJrYVN5azI3c0lWYlhoanRP?=
 =?utf-8?B?eWhnbTlSQjc4dklrczBkTkhEQVF1cktaUi9OWmtsZGxEN01KeEZqR0VQck41?=
 =?utf-8?B?d0JkMFFOWHJtanNUU2tUaTZ5ajV3VmZBdW1nOVIzZ1VoR3JvVGVrL0ZoQkY5?=
 =?utf-8?B?VWlIZmRwWWprdkk1SlY2d3dwNTNPYzAyRnJMQjdvSnFPT0lCMERMT2lJK2J3?=
 =?utf-8?B?Wks0bXhpRURMcnlWQmZPbnVIUnJET01oakdhY1B4T21SNE9WTlpRMHdFWGZ1?=
 =?utf-8?B?SUlzSVpOTE5PTy92bmkzeGxKVlU2eWIrVEJoUG8vRFdhNnp5aUVITkpkS3k2?=
 =?utf-8?B?UjhVOEdleFJzQWdPbi85eng3MlhwQ0lMcm5CTjU5UUVBWURGdFVDQWxtNFdw?=
 =?utf-8?B?NTlQRmFONDh5RjNNTk9FemJVQUNhV3NFOS9MbDVmcU00azV4c3FMNVpjNWhH?=
 =?utf-8?B?d2RUckVBelBKN0NpdVhDRjVoUG1rKy9HaGpvRk5vbmIxRklLWjU2Tk5kMkxF?=
 =?utf-8?B?VDdEYUE3ME45T0krMzI4RkMyL2VaR1llSlMyN3RUM0srMVBmWFFQa3VBbkdu?=
 =?utf-8?B?T2RFaUdlQ1Z3alIxZEJ1WmRBejhPNG5Jb0tSQzhsZTFzajhGMjlkTEFxMzdN?=
 =?utf-8?B?UW5OL29Udkx1a2dneVMxRGVqNGs0NFJpZFRJVi8xS1I4QUNRVE9xVEFLUXpq?=
 =?utf-8?B?L2tDaFkzdHprNHZ5em82SGFLTkI1K1JIcG5DUW00eE5Lb2VpS1Y2ZzlSSVdI?=
 =?utf-8?B?eWFBSTZ1Mkg2Nk11S1lFVno2M2M0Nnc3L1ZuRzlOd1pQTjZveHVvNDM1MTdL?=
 =?utf-8?B?R1pYZk9Rb0RXZmxhTXlCckxvWUFSS2gwbEt2TjNCUEIxa2V2em0zK0RuTWJq?=
 =?utf-8?B?bVp2RVMzQmRNbi9BY2lTQXN4WHVJL2g4YWtXeWg4UytqTThVeWRFQVFMOFNm?=
 =?utf-8?B?L0gzb0Y5V09MU0tkR0N4VGlLRWtydHhYME81akhXMjZXYThJcEdDUkhRZ3BE?=
 =?utf-8?B?VkxIeUhENEpxY3c5SHl5TldNdGxraHR0cXlZNEJiUTRESjF2WmFLZFR1MG5B?=
 =?utf-8?B?Z1lSaFNWNVRnTmcya1UvekNRcFdPUURwQU5JL2RaVlRKa3g5dHJrL2ZQU3E2?=
 =?utf-8?B?UVFtdW5MZlVWbjJFenZta3NWRURBRzJBVTQ0RUpwUVNLOVNHUUxkOXJnakx1?=
 =?utf-8?B?bnczcFNtSkNQdEhLZWdSU0Nid2d2ZThhcWRkNWlyK05yWWljeW8vUFErS0F1?=
 =?utf-8?B?WU9SMklsSk5DVlNQNjdqam8xSm04RE8rK2NqeTd4VXNPdlZIQVk2eS9LVW9n?=
 =?utf-8?B?MnJlMGNVblBobHYvdmtteG9qY3hQZ2w3TVhwa29xRmpMbjhZL3ZpenJoRmFU?=
 =?utf-8?Q?RpfaGaTClL6Ah/ZJiHRW2I1iM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452ced2a-deab-42f0-3ce4-08dd5be9db3a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:30:12.1227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7yNdy799DQg9F61crTXo8sfqMRqckkEZF49VImRMsPa9FiMHvVesjOoSzJ/z1XwZNyQcfqDgr7arGYKKHX/Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11028
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
index 0000000000..2ad5734506
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
+Conatiner |         |Reserved                     |Signature Block Offset       |
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
+    Conatiner     | |                    2nd Container Header                   |
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

