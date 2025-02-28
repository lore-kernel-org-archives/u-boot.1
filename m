Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11BAC282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 555E2810F5;
	Fri, 28 Feb 2025 11:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ebsgWhku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A078810F5; Fri, 28 Feb 2025 11:54:56 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30108810FE
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ay2Tk+vY7kgCaEYj+dGZyTIxrbSB/Cdidl59XiBX0aTmqXv1ftLcomWpUqvGsTR8YNfQpGTpQcHISgDB/k9LlI2Si3Qg4rxd40kvDtO99i8YPtfdN4SIv5zOJkHhoQngZGg6DWeSY1W0lJmR+3zUP1tyF3LRXd4FQBtCVRgKeUNwYMs4rm2Mz3XLikDEJF88cduuwqip49oJieBmUC865D6r4HwW9Es0ybzAxp2Ngl0r5rkEUy3muoBFa/fdusvk3IdpiwyoPEn2LWTW5ssHyWnwYE4CM+NhnOyJQkZbqxdNVmX88p4KtuWBox6tseN37ISJtYggrqP9htnjW2pUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7s/VmubPqADPCUjrMAESckuCgRp0vRsLLFMesVlsMUs=;
 b=a27bags8/EEFJhrr902uVp82whtikXU0LdH1JgOhagKtF3rOVR77ENXwlq88PUQUIPhR1ayle6Nx5G1WDdupWfn8SyUC2VtcftvLHQpvZ3yio5Q+RkMo/Y9MeaDa9O2vWlPA/uo1eHX1oHlttzr8sWEHERn5oS/OWHBXa/Ay7yS4aOeZPVbGj+KlbOYOmwj0tGIPxiZcOReIDRsJi6+OlhBmDfBcYfxy0jemyBoElGYaPNKegDMDg/nWoUBUafqnOzZWESDewBaHlhGeAoDBiqaTOWe+OXM3nP5kBu/lSmlEHQ7rUBQ1efzYDkwmCioCICkDwboT7dKrqsWsXyBvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7s/VmubPqADPCUjrMAESckuCgRp0vRsLLFMesVlsMUs=;
 b=ebsgWhkup+kaqE6sYIroxx4/5mfoeFHBqTS3JL9W1hbdftTFmSQikha4t3x1zRcfZoXB+JIjdh6LE5WN44HxVQO0LCmgH6HUAFj3IGq2eTz+xqdJtnsLo74KLo/PMmHa/sXMYIh77V4Z56+xou4xRIZm5KdFu/gJaTGHrkcJj4szjcsnLlQyGJkujymsHKS19j/KZRWgE43nrEbBCPNBZGLNvyMuMqr+SFE2NslmhpKBokRrlJC+/FPbtyXbmh1rKMXM5Y4OoEmfJiZY6CiJYCL0SxcgBGvtwIGNINyzDTjdjEaWFVY2mijGTvkp3P+0OYw/pMbDZt8Rsy05R5KwQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 10:54:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:54:52 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:53:56 +0800
Subject: [PATCH v6 05/20] scmi_protocols: add SCMI misc protocol
 protocol_id and message_id for getting the ROM passover data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-5-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfa7a3e-1264-4410-29e8-08dd57e65448
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXZwczZib29hOFI1NXhKVVJRYmtHWnRLOWJFZG5qREZPRmZIa25PbkpZMEN6?=
 =?utf-8?B?QmJYRkdrZWE0cXlnZlJpeWt2aDY5YlhINEs2UlRQUWdZeTd0dGVmUTVBNldS?=
 =?utf-8?B?bm1hZlVNTTRIUXVjWDBzL2ZQOENWNzB3a3o5UWF5b1hESGpOZ00zck40allm?=
 =?utf-8?B?S3pvMDFicjZjaWtTMFNZL0pWekFOOUl6R0hkLzFOc0xhYjZUQmFuVzJJL1RU?=
 =?utf-8?B?V2JPVXFWTngrdXdZelNZU2dvbTMraXExN0Z2RHI0Rk5MZTZzaVhBZ2VZVzNp?=
 =?utf-8?B?azErdU12QWp3WU54WFdyN291TVo5Q2c1UVdRc2tMVmY5cmJWTGRGdjRmbGdv?=
 =?utf-8?B?QmRPWVlpSi8yQW4yRjc4a0szcVF0bUErTlBZMkVnejFjdm1rQTBtTHZLanQz?=
 =?utf-8?B?cGJ2ZExSK3dWS3ErcHZPV2dmTGU4NnVWRDdZTXk1ODNIWDd1VUNkd3RvWDZy?=
 =?utf-8?B?ZHJGd0YxTjBmSVRSV3lSQzAwdVhGRkNyazZibGZEUlBQdE5scEhQUDdqbTNj?=
 =?utf-8?B?Wjc0M1dBaTNJaFVoYk5OMHRIQ2tIaUE2NlV4dCsxYTRGUjBFS2hhVm9ZS3B6?=
 =?utf-8?B?SS96dTZFWEp0TW5RK3E3RWJoOVpIOFI5alY3dUhHWUxod05jNkNIWmxiZ3d3?=
 =?utf-8?B?cnhmRTJGN2J5OTBJMTdjTWNZTW1qVGFTcUVrWW04WVJLK0F1VXUzVzVER0Rz?=
 =?utf-8?B?d3dIVXp6T1IzcFYxMGIrUHE5T0wwRmsvalA4U2R1RjBnK2R2dXhjT1lsb2hV?=
 =?utf-8?B?NUI3QTdoZ1VWSGNHaFRITCsyNnNObVg5aFNNVzJMQzZ4TndQTGV0TnNpU3ln?=
 =?utf-8?B?REY5a2lsMm55SHRBRHR0WCtOV25BR3hmblZYa21wSThmekZiMUhLREFyM1pS?=
 =?utf-8?B?ZERSRmNMRE1zK0U2N0FHNHVSNHpRNFVHT3BOelc1ZVBxNW92c2E4UG9razVR?=
 =?utf-8?B?SXZHTHJXbjBXK0xkZGtQQUFvSnorWG9NQnNQcUF1bXZtTTNHRkxvYnZEZGMr?=
 =?utf-8?B?bDhWVU41Nm5QQnFXNUhvQ2RUZDBxVTNadTNscmZWaUh2TWREVWRLVUxTUUNo?=
 =?utf-8?B?ZU4yMmVYY04wdDBsdFRjNStUR3RyQjVVKzdMWVoxWmc1YnFsbEhQVkJBQWIr?=
 =?utf-8?B?ZDBQanlwSW5BbmQ2K1Q3Y1lvNXZEUkZneGxFUFhjeWcvVGtKd21QY1JPZU50?=
 =?utf-8?B?V3RIQ202b0tpbDNGNDlxL2doYU9aOXVEdFRxdFBGNnZmT09kVkRSUTN4Q3pF?=
 =?utf-8?B?Y1ZhbHdzanQrZXFzS1hFWTVaL09SN2ZiVi9nMVpMNTMxSWFGeFkxY1R5b01X?=
 =?utf-8?B?R244ZFlsdUhEa1lPc2RtTjFWUCt6WWFTRSsyb0p6cUNncjQrQjJyYTJYNE1r?=
 =?utf-8?B?SUxVMHMrWEU4cDJUTzR4V3dHdlFYVk9QNVlrbDJBT2NjSmdXMlllRitBcUpu?=
 =?utf-8?B?VzR6TmJXSjkwaXYxOGRUdFhMVEVWL3FqSTY5RWdyN2s0blhyeitPYXl0N1lV?=
 =?utf-8?B?VFRpT3JCZzRPRktJL2pMdjJ5NDZtT2ZtekZnSTZKcXRlSnlGVG5PWXlyZXJ2?=
 =?utf-8?B?QWRZNWNUcVpham5KT1lyQlI5aDBLT21IejBGZzhNZElOWkNUKzFoVUJaaUlQ?=
 =?utf-8?B?dVY4Vnc2ZGc0R0NKWDNmV2Z6NmVxdm53MnRjcmZyY2pnM3BCVFRiSmtHdGRW?=
 =?utf-8?B?NHhtZDBEejlIbGIxMHQwRXVqRzc2VXpwaGNXQkxZK3h3STVtZ24xQmNEYzd2?=
 =?utf-8?B?UnJUMjNFQTR3S1p1Ky9JZ2pDVVBqV2NramZ2SnIxRVlyUWFKYXNhOE94bW1z?=
 =?utf-8?B?WlVEUnMrZUgxdnAvRkJCZFRKTWpwWjVIcnQxZkt4c3FiOVVhWkdYVS9BZUU5?=
 =?utf-8?B?QTFhUjVVMkYxMzljei9UYjBtdE9xTDM4TjMxNTdsZnJ6aWZoQit1TDIrb3B3?=
 =?utf-8?B?ZVAxUVFwb25rZmk0cnRSamFwaSs2YkI0dytlYk8rNnhib21TNXdMT1ZvVngv?=
 =?utf-8?B?NkNzWHZ1OXJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDBOQk56WXkxT09yWXJ0ZWZRZVJ0OFgzTkJjTklFRnNMZVBEOEpQNGpieC8y?=
 =?utf-8?B?SUR4bEJwdFpiNGpkVmZ1dXZkNkRybHdXVWx0VDlVTEhGRGtZOHFNMXhPd2hU?=
 =?utf-8?B?K3hRRWZsczJzMGFnRGtTUy9DZUR3TFdNZUhuZUNCakRxdXdSVjMxS1JhQmVE?=
 =?utf-8?B?WjFWMzdzMzRpQ1ZZaFZsRHdESFg1aTU5N3VWcW50RDNSL1dFeWpkalpHbDhw?=
 =?utf-8?B?ZStyZGNFam5kTTlZdHh6eGdsWEptb3cvT1dFYlR3dnhwUUkwdS8xNlBGNXpW?=
 =?utf-8?B?bnR6TFV2dHdKRDJ5UzJ1czVSVWdjdm45RnBBMTh4SU1ZRUdadUFJYjNqOC95?=
 =?utf-8?B?ME9HVlcreXVHdVFOMWRFaWk0UWtmS3hiTU56YnlycUNmNjJ5YkpUaytRK2w1?=
 =?utf-8?B?MGVVcC9FT082WnBqRE1XV0o4ZE5IWWJjMllaMXNpc28wL1N4QVROTlZGQUNF?=
 =?utf-8?B?b2RZM1FlU2h4OWV4dDRVQ0N6WjZtYWJaYitKNFk2VkFHNjBGOUVWdEFSc0xU?=
 =?utf-8?B?LzFoRmV6cndhSGdWeW81OUdKWHU1cUJrZnZkK05PZ0M5MW9Lc3FPV05takJa?=
 =?utf-8?B?Um5YWHhFUHpQNXFtVG40a0lad3ROL1ROY2lGM3RnUXp2cjRhQ2tnWjd5dGxL?=
 =?utf-8?B?SzJNeFBKcW92d3hEQ0lscnJGakxvV0I5dm0xV0xxUHhQZUhSKzNySlJ2SGt5?=
 =?utf-8?B?REd0Sngva0pxN2FWeTVNR2RiN09nZHBseTRuaUNRK245eEYyY1drTmowaHJW?=
 =?utf-8?B?b2xoVEIyREZFVy9pM2U2S0N2Ulh0VElsQVJSLzJQeTBtRDNhalhwb3d1czBG?=
 =?utf-8?B?bWhZenI0TzYzenFLbUdxZHA0RkV0Y0N0TGdMRlNaQzl3N2VSWFphRVdHZnFG?=
 =?utf-8?B?Tkd4ZGVtQnJNVUh4NERuaFVoOFZKUzZLeXA3Z1RJRFpmNVVNN2s0Yk1uY3R6?=
 =?utf-8?B?cE80b0J1YXR0VWdVWC85TCtGSFNrR0NmOFkzQ3hBTXlqZHJSM25KTlRNbHdN?=
 =?utf-8?B?NGlzbnQxbjZkU3BvYlRqcFlaMWcrT2lITDVTNlJBMEttc0lJWSs0REdjcWNC?=
 =?utf-8?B?Sktvam1uc0lhcnQrZ3I5RFhRRVQ4aGc2OVdQblM2RUg5OFEwWS90dmpWdDQ3?=
 =?utf-8?B?bThHdkhOQStyUlBYbjVobzNVOVpaZXZpUmNCcGxpMVRyb05keFFFQ0RXMDB6?=
 =?utf-8?B?OFU0Q1gycTQvSFRPb0JPWC9vZlU4dmxTUysrTlpoY1I4NGFmNlpTV2xWbGpm?=
 =?utf-8?B?dzVOSjVhOVdhaWdTdUNXS1lwZE00alZIa3RIeHpYMzI1eGdLY3A5N1BDdzJs?=
 =?utf-8?B?bVpwTmpnSXpPQWVtZGtKOGZraElQMm9Nd0VDT0ZxQ2NSbVpYaWVWQkkvNzhj?=
 =?utf-8?B?N0QraHQxV3RNZ052Nml5YnNpcWxmMVZ3YnhpU083aXpQWHlsL29mUjc3TWky?=
 =?utf-8?B?WW94MU1JMFBDWW1KZWlleHpqMmZ5WTQwZ1FvZmprSU5DVElpbWhvSnJTRWp6?=
 =?utf-8?B?ZzZYcTlMSzRwY2tYQ0ZyRXZidjRlbWY2UzFBb2ZQWlhFWXFnWEhsSlkwZ3Y4?=
 =?utf-8?B?c2F0N3paeDg5c3dZRlNsTnVzRGtjUUJoY2dSUG5lQVVuUy9RbXdaQ1ZvRndK?=
 =?utf-8?B?S29hVkZ6SU96T1RGTlNuclkrd3ljU3Y0TWtYWDRtRVcvajUvOXM5alVUdUlO?=
 =?utf-8?B?WW5ybkFuV3ltWmM5NjdqU05XdjNPaTJDMDhnRzc3dEllWjhWK2FBckVnYXV3?=
 =?utf-8?B?N2Yxa05ML3FEZnZIYmFqY1ByVjBkeEY4WjFheld5WXpWR2VSOHJ3K2phSzNF?=
 =?utf-8?B?WTBkcUlGVCtDdkNrRU45NWpaY3dvY2xjS290K2RpSkRxckJJUm9uZXBHb001?=
 =?utf-8?B?b0NPR0Qwb1Q0YXRPWWJkeUZIYy9kUUFjcGJESVlHWjgvWnJaWTBWck5RdmUw?=
 =?utf-8?B?NS9NbEd3YTlVTENpSk94Q0NnSHFGNWtNdklJY2JvWmlNMktPNWdvcUpjOFpZ?=
 =?utf-8?B?anYyY29PeGNWUFc4aTFBc1N0L29pRExqYUE5RGhlbHRjNEJQcWQvTVpONkov?=
 =?utf-8?B?M2lCLzlQRmhQUnFjWU14UnlFbW90dGFqb3EwaFR4bFlDeEE4ajFxVmJwVEU2?=
 =?utf-8?Q?AtaOoJMPUHRgWmRMv8tHxZFwy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfa7a3e-1264-4410-29e8-08dd57e65448
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:54:52.5933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkwTHgi/T8TQyy3J+ozMy4ewMz6RawrX1q7WeuEq6I4VMpaajtqmbna8mn5bBk1AqZGEM9LuTw0DV+d3IV/u0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845
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

SCMI misc protocol is intended for miscellaneous functions which are
device specific and are usually defined to access bit fields. It is i.MX
specific. This patch adds SCMI misc protocol protocol_id and message_id
for getting the ROM passover data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 279ebbad44..06de4a601f 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -25,6 +25,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
 	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
+	SCMI_PROTOCOL_ID_IMX_MISC = 0x84,
 };
 
 enum scmi_status_code {
@@ -50,6 +51,10 @@ enum scmi_discovery_id {
 	SCMI_PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
 };
 
+enum scmi_imx_misc_message_id {
+	SCMI_MISC_ROM_PASSOVER_GET = 0x7
+};
+
 /*
  * SCMI Base Protocol
  */

-- 
2.43.0

