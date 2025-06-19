Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DC9C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 09:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B56C82CFD;
	Thu, 19 Jun 2025 11:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pn0E/i0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8F5482B18; Thu, 19 Jun 2025 11:13:19 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4E4082B18
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 11:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUvAY3mutPsS1rfMpaBRexizLSCal/RIoakruGY63iTKcJ/kztPzt/uNOAR87SMNapooxVAUnUdNijk4Ckvs6yaO/antflCh/fUhMVZbR62J0xqGX24467XeRXZ8nxhss6mAsM+kcd+nZbXronW8Pa3qMlUGYNiyFrkYRteNORzNs6EmeATXzObF/m7gYASBq/H+AM2XojfllFgfhQKWiwTbtOSRtxh1+OY9iNMvzy0bPpPhHG7HNDLnluIoO9m3d+UmNnGsnTknu5OlGvMg49KGbzoMTZfsL3j5U1COQ6Ck9Uw3+tt12jXizyA0hGf7ekjYhyqWOxcA8MJE/jTWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1cZiOVvk1Ye8Zb/qnbaDKoaHHkSRIJZRMbGL4Jh6xk=;
 b=uszqNbmVuceHgmjKOyzEomfTTHa0bY+jGOpiaVv54a/lzWlH9z01hbIc/3IOe3d2Oe+EELemvLyV0zUJg6dDGwEe7YRdvZLjU3CZsNjsNjR9BsLUoqTd3YQuDOiTg8neeznkX05lD8WcmEDDSs6mB+Ff55wrVFiS3Yn3C7pBpRulr/rQKbFYIlf603OcVhVFlfHByfRZ56sDqtPIRFiI3+BiZLO6g3Qd/12tjx6braZsu3LYjLalXmJYowxUSyhSv1H4YK8vlVJsQaDqGFi2QnwtYynjZ0G50ElIGBSWVIFmwcZXnt6OBVFv1Q2SHK46hqtAA6zqfiSHlTv1MGeMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1cZiOVvk1Ye8Zb/qnbaDKoaHHkSRIJZRMbGL4Jh6xk=;
 b=pn0E/i0ErMypTf93GuEimkLQS5W52tGMKOABOg/muC7pK/l/9Cw6LryFc+8yKFhd6DbuIwZl5A2Q2jecmd3ObqZp9GIol53mI9C1nCxvQ9DTLRAtCle7VV364xZA2EzUklYbplcjBwq5635s5hl7RMSerUZM1Vltz1KBgFsg0upqWZ9CIsBVw6+0kDw+inOscLfOYPKv3FjvRk5mOjC+ezunjuo8zxwmbsh1a/0GCJC+oU5ttZxSdkNjiqTa5OcmfkbYrwB4PsjyXfqV8vuKywpV+HDAde07yFPtbHyFNNF87Tw8dmq1/pxakBwa47M03nQBd6yqLpZhpXG8/kWZfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10888.eurprd04.prod.outlook.com (2603:10a6:10:585::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 19 Jun
 2025 09:13:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.021; Thu, 19 Jun 2025
 09:13:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Jun 2025 18:23:35 +0800
Subject: [PATCH 1/5] imx8mp: evk: Add support for capsule update
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-sr-v1-1-631100a113a5@nxp.com>
References: <20250619-sr-v1-0-631100a113a5@nxp.com>
In-Reply-To: <20250619-sr-v1-0-631100a113a5@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10888:EE_
X-MS-Office365-Filtering-Correlation-Id: 37536b07-55e3-4d5c-059b-08ddaf1185af
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SElrZVRTV2lLZDZ4cFZSd1JPMEFRbjZSMHRsVENHMWQ3R1dnN1hzYU5Oa0NT?=
 =?utf-8?B?WERqL3pJWGd0Q0lnMmxVUWdvWkNXTkRGcElVdlBONUhUd2dyK3E5YzBiNjUz?=
 =?utf-8?B?enR3d2FkYmJkZGV2YU1WVlNkdTl2Zng5NE5ha3dyYVViSkVONjhxK0hsaEZo?=
 =?utf-8?B?a2JRLzVVREplaFd5aDZWbmdQaXIrYU5CZVBjeDNRYjNmby9ZRjRRYTYwclpF?=
 =?utf-8?B?dzVBWGNKcEUvR0dkMmc3QjZ3aGJwV1JRWllXTHN0c0RtVmwrYVF6U2s4b1dQ?=
 =?utf-8?B?eU41TlVlaFNOcUlmS1dGeUptakovSk5DbFpuZm1yRTVNM29oUUhRTC9CK0V0?=
 =?utf-8?B?TzFXZThZRlFKVGpjWDhMUXZVcEpuMUdiSTA5SXlWOWM5dHM2S2lKbUhRaXh0?=
 =?utf-8?B?dVpRczZwRHE0YXExTTNsa0pyWDJQNHp3NGZZOHFkNVNhMHJ1bVkrMEZYN1Zm?=
 =?utf-8?B?dU9hN2s1RjFrcndDdytnRmVvYmw2SWtQdW4xK3lWSnF4MENYRmQzYWVPMysw?=
 =?utf-8?B?SVhDOERRZ3QzUEZ5ZFVQcEMxejNyOFJiUWJIUm8wTzVIeEtDU2U2eDdQcTFt?=
 =?utf-8?B?ZTduemJUV0VrVllMVTBRUjFLMjBEd2tDZFA1dHFrNS91T2I5N2NIZFhnOFh3?=
 =?utf-8?B?UG0wWmU0SVNONGwzYWNmL3RFTThBUGEvcTZEUE5TWUI1WDlhZXM0ckdiUXF6?=
 =?utf-8?B?TW9saHhYaUswbWZUNkttVnJ3WW9ORG5mcHNlbVh1K2s0RWpncCs3di9oWkxi?=
 =?utf-8?B?SUltOG9Mc3gwaWtpTVd6eDdrSERQYVNXRTNZMzRaZmRlNVlPaFVSUjZ0TVcv?=
 =?utf-8?B?MDFCcldtWFF6Q1lvV3VLU0lHVlpQcXJJczVZL3hRM3NBRlJublNJdHMwSzBs?=
 =?utf-8?B?cjY4cnREVzA4ZXBjWXJtSjZQRC9FUzZWZ1gvdHF4NDFsMkVsamhTVDRPU3pJ?=
 =?utf-8?B?elVabHdQTE9kOEZpRU8xNDhGTnpNYVJWSzBVc1BHOHBLQkp5RU4rbExUSDBQ?=
 =?utf-8?B?a0lLdFh4WEgxcHpsNGtOMHdUcDBIbG54YWxmNmZxR1lNeXNRa3JsRWRTaWNu?=
 =?utf-8?B?bDJSMm5aL0Y5RjFib01ZMFllNThPVmFaUDBqb3VQUy9acFlwY2RuVEQzUFZz?=
 =?utf-8?B?cHEzeTdiczVIZDJ1UWR3MXZWWWhnWS8zcThkeXlMV1dNTVpuR0hvWVAyaFFJ?=
 =?utf-8?B?NDlXOWhhcEN5TFpyUzFHMzJYOHRQRndCRjN5eEhBR0x3dGl2SzBlRzZHQUps?=
 =?utf-8?B?Y2YxMmd3OCtGVWZZZ0tRUVRNV2VnYVJKeUJSVHpKWitkZVd1SENoYWxGdUdP?=
 =?utf-8?B?dENSc0VPbW13QlY2V2VLcUkvWnVqekFnYnU4MVJCajhVUllqM1R5aENrdEFQ?=
 =?utf-8?B?N0lqeFdVUUt3Y0h0Tmcydk9ScWdaSHJFUS8yb20vL2tOVllpZUFwY1RaZ0E1?=
 =?utf-8?B?b3VFZVozV0ZqWXJCUWUwdDREY0ZzVkh2bU1kNkczTzNnZFFTeWF3M05wS01I?=
 =?utf-8?B?c084Q2MyRmdnclJOMWZacERGUTNnNUp2SnRudW9ZbjJ6TXdrMUVkNHUwMWJE?=
 =?utf-8?B?Vlc4ZmhpV3EyeVNPeEJXQXVGTlo2UUVDYklPSlRFck1IMUdHNlg1S1cyUjZS?=
 =?utf-8?B?YkZaZkZyQnBiRUNDY2hhZFpYWFQxM3o1TzZVK2FPaW1vWVM3M1dIQlhJakhK?=
 =?utf-8?B?QmM2ckNLTzMyKyt2N3JWK2lyME9obGhrbXZKWnFTaFNleXl0WlcwRDNwSEk0?=
 =?utf-8?B?bUJkdWhPRFFDZTB4VkUvR0lLVk1IanFHeGJOT1JpdFUvS0JaRWlHeXJ4UVFD?=
 =?utf-8?B?YmNiSUJLblJQWGJWL3JoNkZqa202WW1hVGhPeE9ObkRBK2JmLzl6aWh2cVpR?=
 =?utf-8?B?Y3hobTNIRWMxcVZocjZmcFRmUnpXTFVGU2VBakNrSThScW1KNXltcGo1cVox?=
 =?utf-8?B?MHZsMjNjWjM5QitDUHd3YXNMbk13RnVSaXp2ZERESzVxSW1ja1BSSEJPN05y?=
 =?utf-8?B?RmVFYkRQMnBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVhGR3BnSVhveGRleXhYeDQ1NyszUGZuVmtYTmFDclpoWFpuTURLUmVpNThv?=
 =?utf-8?B?SkZycmF3R2dFaWxPUnNabzFOQ1ZrWUw5MUhWUkEya1p0bklYOExPbmU3LzhU?=
 =?utf-8?B?R0pIMVVQWllBQU9mM2NYYkdPQ21Ldk5zSXNySExFZEJKcU1WV213a2VKbGM4?=
 =?utf-8?B?L0VUUFlIQjVzZVVVTU5jcUVTa01KNTdUeFFrSVVVVTROZklJVEpoZ2JUUEpG?=
 =?utf-8?B?ekp4MXdEZExhb1BCMHhSNmJ0Zi9CemJjVS9nemlxb09EOUdaWWN5T0xqbjZM?=
 =?utf-8?B?TVlyUVg2QkZzZE56ZjFsMCtPeGUrNkIxNG1SM0VLaE0vOUtxRDFkbUJUN2xn?=
 =?utf-8?B?Tk1iQ096YURYcHNxYkw3THR4czhNMUhHdjZURXN4b0dhUnpzSzJBa2VhNndx?=
 =?utf-8?B?djRTUlZ2ZmZGaDRnTG1EdmRsUVJZbWk1MTZWcHl4aTQxNG8wM2FESjJhcDVh?=
 =?utf-8?B?MUtZc3RPTUVqUFZEd1RrWHBuTEM4TTJ0UDlORkV1R29GSEZkQkJUOG9hRU1Y?=
 =?utf-8?B?clhwM1lBYzZ4NGQvbUcvZkdrUlE2c291VTA1OUY3bEJXRTBGbGc3MnQ3OEh5?=
 =?utf-8?B?b2k5bWhZSTVra05HclErVS9oVTNiYXBoc2UvZEJrOTY4dDRHMWEzT2lsNWhH?=
 =?utf-8?B?dElvZm9VS0lGckRNVXZCLzE4MFFUTmVTSTY0ZG9BMGw5cmE3MS80ZGpuQVNT?=
 =?utf-8?B?RDRmUVNsdi8vaGpmSWIrc0VUYk43dURpRGwvV3pqd0dKYWlranZ2N0F1Q2xL?=
 =?utf-8?B?TTZhd3BBTzZKNy8rVHhpWkxCYzFEaXcza2owYXBWdlNPeHdqdnVBaEpJZzFR?=
 =?utf-8?B?U1NvbVlwVTNTQXZSYjVGdWRMMUZMOWJCNXA5bjM4RlJqUkRUemxvdGdZbkxj?=
 =?utf-8?B?bzV5TzlXUmVYSXR2bmpwb2tPSXRmRWZqNVVGR2t0cU1RWXlWVW5EV1JLU1RG?=
 =?utf-8?B?TWZLQ0JCTVJyanR3dm5pWUg2MUZiOW5SNlIzMVdsSG11anVJZGdWeENFb2ow?=
 =?utf-8?B?TElPWHk5ZkdLMm1nYkUvQWxDUzNMVDlPVGlBTjFKcnZyYk9TMXdFeGV1R0Z4?=
 =?utf-8?B?WTVvN09TYnJJMDMzL0xneElmMndpTHVlYm91SmlJRWkzRTdYTjN3dGpzZ2U4?=
 =?utf-8?B?TmxRYlZUWTFIcnRwa3lFVFZqNFBxenR6QUpIMC9hSjJvalBqeEV5MnFxYjdF?=
 =?utf-8?B?U29lN2kyOFZwT05sMmRBcW9FTG5uYWJZRDdEaTU3UUtnUkNoZURpdmxTTDUx?=
 =?utf-8?B?Z0ZqdVVIZUh1N0dNcE92SVV1S0RHWEx3K1QyZFgzZ0Zkci9acjZaQldhUG96?=
 =?utf-8?B?WVpSK1had2lOY2xVREk4b0JFd2JieVV3SkpBS2JuTlZXVVJwUjA2U0V0QWgw?=
 =?utf-8?B?UFowSXY1Y3ZtdmRCdFVBYnBXTWoxSGNxcndLM1BwcnoxbllGcmdkMXhDdmhx?=
 =?utf-8?B?SU1MZVJTUXY2eFBZU1lxeGNSUWQ1eU55ckt6OVpBK1pZZlZYeEtyN0NIeXcz?=
 =?utf-8?B?bTR2ekUzc0taUit1U1N6ZkdBUHlZQXczYS8vZmVoMmxnZkM5cERjMCt4TjRx?=
 =?utf-8?B?YTZISUdBcTM3bDh3bmh2U20xL3ZVUnBweFdqbGo4QXhSUzUxK3ZQandaRnYx?=
 =?utf-8?B?M2s4T1lMTytaZ25jR2xYa09nelN0bHI3RnljS1M4WU9DaGh0WUJKd2gxdy9W?=
 =?utf-8?B?REM3cHZjR1I2VEg5ckdKRVdhQTYzeDc5YlFnWnhTWDNJUWx4eE5Gb0dhUjly?=
 =?utf-8?B?NnpGeVFzVjBOUmRiMVNsd0hDL0ZOdnZaVmtiK0k3blZBNFI5ak5LbWMyTDR1?=
 =?utf-8?B?a0RZdWZ1czF2UGVDUkpMR3V3Rmhld29JKytOMkkrRFEzZHd4ak1pYi9YVnpK?=
 =?utf-8?B?V3FCMlNDNUdXT1Y5UTRmY2FSUzgrNitaR1Qyd0dCWWxNMWh6QTljSWJQTVU1?=
 =?utf-8?B?QS91cHlIbC8xRXNwa1lmUzE1OVFkT1RzcnlycFcweVp3cFJPL2lmZDdpRS9N?=
 =?utf-8?B?a2RFazNkanlBL0RTc0gzNXlwR0lUb2Z0M2ZMQnkxUG1pT0pITTNJL3NFdnZv?=
 =?utf-8?B?YkN4N3M1TU1zTTREeEF3UzNNQmtxaUd1N0p6MmtHdURONnU0RnlJdWNXS3Mr?=
 =?utf-8?Q?bDP/laxxcoFvTEMxe4ASr9Wqi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37536b07-55e3-4d5c-059b-08ddaf1185af
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:13:15.1019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcXRlDXXIlWo9aZXehN5WRxSKUX10f1pxdGmwl9jDj6Jv0XsNbyHxODM6tzNpWTK8Z0EXIsOi943JKI+dHDtlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10888
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

Define image array and GUID
Select configs for EFI Capsule update

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mp_evk/imx8mp_evk.c | 23 +++++++++++++++++++++++
 configs/imx8mp_evk_defconfig            | 15 +++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.c b/board/freescale/imx8mp_evk/imx8mp_evk.c
index 2ff067bc6752135f323398e620e37ef11d1b91bb..2a9ba7df2bb35d9daeaf9e7e4cf3c82c097e23a3 100644
--- a/board/freescale/imx8mp_evk/imx8mp_evk.c
+++ b/board/freescale/imx8mp_evk/imx8mp_evk.c
@@ -4,8 +4,31 @@
  */
 
 #include <asm/arch/sys_proto.h>
+#include <config.h>
+#include <efi_loader.h>
 #include <env.h>
 
+#if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
+#define IMX_BOOT_IMAGE_GUID \
+	EFI_GUID(0x928b33bc, 0xe58b, 0x4247, 0x9f, 0x1d, \
+		 0x3b, 0xf1, 0xee, 0x1c, 0xda, 0xff)
+
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = IMX_BOOT_IMAGE_GUID,
+		.fw_name = u"IMX8MP-EVK-RAW",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 2=flash-bin raw 0 0x2000 mmcpart 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+#endif /* EFI_HAVE_CAPSULE_SUPPORT */
+
+
 int board_init(void)
 {
 	return 0;
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 5b2c977edf8d7ff5e89e9a29de18603c14c7f3df..351d24657324a00ff040d80aa796a20c3daed947 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -23,6 +23,11 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_SPL=y
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
+CONFIG_EFI_MM_COMM_TEE=y
+CONFIG_EFI_VAR_BUF_SIZE=139264
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
@@ -51,16 +56,20 @@ CONFIG_SYS_PROMPT="u-boot=> "
 CONFIG_CMD_CPU=y
 # CONFIG_CMD_EXPORTENV is not set
 # CONFIG_CMD_IMPORTENV is not set
+CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_OPTEE=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
@@ -76,6 +85,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_IMX8MP=y
+CONFIG_DFU_MMC=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x42800000
 CONFIG_FASTBOOT_BUF_SIZE=0x20000000
@@ -89,6 +99,7 @@ CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
@@ -124,6 +135,8 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_DM_USB_GADGET=y
@@ -139,3 +152,5 @@ CONFIG_USB_GADGET_MANUFACTURER="FSL"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_IMX_WATCHDOG=y
+CONFIG_SPL_RSA=y
+CONFIG_SHA384=y

-- 
2.35.3

