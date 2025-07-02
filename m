Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F976C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 07:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8851082EB8;
	Wed,  2 Jul 2025 09:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OxIP7mKA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E3448206E; Wed,  2 Jul 2025 09:40:15 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F6D481E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 09:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiDk6wu1CYA99rExkUuptudp8LHlMJcsXr/RP68TtHOIRpmbpAXRuMSCvPdnWUREgyfgcjsmhgIxAPnSU09rMoFhWjimspZqbb+xxW2D8k+Pb6l+zwFkaHwsP3FwHSu998b0O9vwl25W3M5z3HshBeaX/46Dbe0kRY167xueWxlvZVYLSbHW0e1X6Y51tnN9rTj/+QYDXV6flv0flZwD/LPI45psAGvpW5Dai6f4NGioaBVhF9/HA78KzRHM8wWz6888+S+HOAakvYZ/AvavnWmwerTeCODMMW7KiHicbTnIjqdVW4KFsZLFrkWXC3s7KKuJvrPYB8LlEc1Zorzrhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VitYBUjXomZ/h+Ej/GWj6r9VL2AF7c/kZIWUgCUYW0=;
 b=sKkQ9SAKxlKCpA4/IpyNjA+yWxeTvkBocmKhKAi3bgrJ3sEy0EwG/Iuqd+JqpHdFAbS456Frzsn0Bdn5iWko6lkIWsmNedVSXA+n0Q7O5rBvhwNnU7Cys2ZXt9fFZEV3H2UPGLyYkLfNjWFz3GooGL0Em+Jk/YCG3e+zkXHAj12sV/Si34wCO9+ARMf7XIqLoE6gepVChzfkRc3fnqDLIjNtznONfXrOcK3exw8aSxZkcX7AFOnV4lgY8ZE+D0vmyjAyTnH96hu8g+PWCJoPZHQEB8XJdFnadCyPDeQtBfB+BMR7oPH77sdu2ul9v+abnuwnd4KOz0ywMKEhUTH+RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VitYBUjXomZ/h+Ej/GWj6r9VL2AF7c/kZIWUgCUYW0=;
 b=OxIP7mKAKra8Si3CQlhFhWdDsU5gX4hmul3JcvlbR/4sL1pVXTEv5zzx8wKpolkIl1eioofZYduMHdt5x1yauW9RGQz0z3h0NDg7h2kr6fs/2VD+m9jixeZNzuYST/e3PtBK4s2RXx9sgEL5B8d+HedjbHio2PHnugmw5i0SEzYOrWBpCxVoKkktNXduYSaOVUWb99l57Qq7AKZRkEx9VUKIZvI7qmEyfsaC4FeOecn6kpNvlVnLxeLfMvVdHx6/upJK+60JkXCeuFHnOLwQ9Jww/aflWa3vpR9WzqnLHHX81bicebs98qQSzKqgFUEraj1YrvbAzYrMJPOkgFZS4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Wed, 2 Jul
 2025 07:40:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 07:40:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	alif.zakuan.yuslaimi@altera.com
Cc: Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1] mmc: socfpga_dw_mmc: Retrieve clock manager address
 via DT
Date: Wed,  2 Jul 2025 16:50:41 +0800
Message-Id: <175144621273.27323.2629745808481218141.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250620062840.6553-1-alif.zakuan.yuslaimi@altera.com>
References: <20250620062840.6553-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::29) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: cf15204a-beb9-4050-bfc6-08ddb93babc5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDg4M2FMUnFqRHppVWVjR1J5bUs2YS9ONVI1VEYxaDR5R2h2K094Um9Db1Z6?=
 =?utf-8?B?T3JVZW80Si9iaW9TY0toYUNzMTA4ZnJHUW1NYXRPWXp3bEoxaDZOL1VqaEs0?=
 =?utf-8?B?K1VuaFl5UFgzdXZXdXRlcDA3WWVBTDJxKzZzZ3NKRjhaQjVpMDVKOUVGU2Mr?=
 =?utf-8?B?ZDA3NXFBYWswdGFweUlVRDlTWWNwMm5Gd3B5Lzh4c3JUZ1hnR0F5RmFpSnlQ?=
 =?utf-8?B?SjhIeVoyRDFsdlQ4TGptWnhoT0tsYlNjSkNwWjlvcDZUNUYxSk16cG5QdGNj?=
 =?utf-8?B?K01FUHZBbGpmQ2xMKzlOUEFVdkRVSVFpU2R2NG1HNEUwS3lRZ1JvYjFpam55?=
 =?utf-8?B?WEpLaDl4UENzeHN5WWI0QkdqSk1qaE1kU3dQNHVZVEU3MGo4RDYrMTA3LzF6?=
 =?utf-8?B?eGdkRzd2UFBlaWxxNHk0Y3BBT0pNVTlqbjJXd2NjblNJZG5NREFOam8ydUhq?=
 =?utf-8?B?NHc3dXhEUS9YTHBvOFlrOThtMlJEVzZhbzcrWUtZTGdGMVUzbHg1M2N6ZStB?=
 =?utf-8?B?UWpZelNYRHhLNDNwdEI4c2JJblRnc0VJV2l3VVZYYi8xVUNhdXFwUHBqU0ly?=
 =?utf-8?B?SW1ScUNMclJHU25XdFB1dTJnYU5iZGJWRmNpVWJid2xRMkNoUWxJR1kvc0hK?=
 =?utf-8?B?enhPNzZrNkFDVnZ4UUV5cFVxMldCdk1zS0Z3V0szRWd2RzlBcE9SVjNiZjdB?=
 =?utf-8?B?S1g5bUIyZzBwSjN1aWNxSGtHNTRrbGFqTzZUcFZuT3JQc0Y1cS9leXlYZ01H?=
 =?utf-8?B?Q3loRWJhdDhmUHVSSGhucEFNWVNpbjY5YW44ZlhJbWRId2N0NW4vWTFodUFM?=
 =?utf-8?B?NXY0VkNvcXlaWHRCYkRZVlpuMU5qSTRFMG5nSUY4QVBPaW9QYUptWE8rWnNs?=
 =?utf-8?B?U0p0VjN6NFp2WW5GelhCLy80a3dteUdMaWlNSFgzcUFxenI3MTBOTHh3RmRi?=
 =?utf-8?B?aXlyVU1XQ0JRejVMRGVjUTgzRDh0UVNYa0RKSlVLQnduWllvbXUyRVJ3TkEx?=
 =?utf-8?B?WTdybHY0MzZTVGFKeGRsbVR2ZjdNRGg3WE5wSFIxdGxQb0hwa1VUMjVSUnFn?=
 =?utf-8?B?NEFLSmphaGRHcXFGWXdieFQwc3hOc1k1UkxWTUkxSzhBSCtBcTBhVFk5MldU?=
 =?utf-8?B?NkhyUnVWTDR6MEtSbEpOTk9RVmQvdURVN0pyb0JYcUw5YWZ2OWZUUUN2WjhB?=
 =?utf-8?B?SlJjdlFkellRTTJ1RDhvek94THFoekQ3aFlORXoveEVySWl6S3cxM3M4dkY3?=
 =?utf-8?B?ZytRRmNXWDVYeW9LUEk3SGVSejA0azVrMk5Uc1pIWWFjcE90c3JESThYTWE4?=
 =?utf-8?B?SDg3cFc1ZWdBNzc2VkVDWllBL1RuSmRaMmw1aW5JK0h4UVQ5VUhiSnJWTVR1?=
 =?utf-8?B?WG1kYmlQa3FkdFZGd3ZwQUhzUWQwbkVUaDdPcHRwbitPR3JHMnRicTN1Z1hq?=
 =?utf-8?B?eGF1dDNUZllpNlcxbTAwOGtRM215emJWNmNRc1BmYSs0NGFKZFFmMktNS0RD?=
 =?utf-8?B?RFNvdnNKVTdQSThUZlJra01GRDM3NFdidHZIcTM1Mm8wUHNFT0VLak1oMHZu?=
 =?utf-8?B?a3RlelNPUzlMQkJTQXBpUDBLNXA2VFJPS2kvMzI5YUhuWXQ4MVl0TitNLzls?=
 =?utf-8?B?M2FKMUZqcnVGbk1Cc0JYQi9PTWVUdWtvU0FYNVgwYm5HOWlhQXB0QTZERUNl?=
 =?utf-8?B?VmJiMzZXNDI5bHlORVIwckhGVnFadTdsNnc5WDZLSTJ4a1hZM3JHNHlYK0VK?=
 =?utf-8?B?aXJhMGY0Wnh0MkFWeW1DODN1SndFMVQ0RFVHQUQ2Z2lwWDFEcHpiWkI1cWE1?=
 =?utf-8?B?elJDaXVPZ3NiaElIV0ZXVUVZV1puK0wzYmdCc3JBS2ZNdzhjYVV4SGNMbXdk?=
 =?utf-8?B?NEdOK29NYytLdjZuUFFjVWswc0J4Tkk0eFI3SVhtcnFNTktQTXJqMC9WL2Vi?=
 =?utf-8?B?eEp1eHhRZE9kdVJvSVZheUhqcmFjYU1PNW1pRHMwcWo4L1VaazZMV2FQeG52?=
 =?utf-8?B?SkxQb1FvRFR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUJXSEU0L1Zrb085L25TcnVxaVdwd1MxZ21jeWJoSkxMN2ZseC9wVW1maUFj?=
 =?utf-8?B?N1VVOXRjTTFyTUxaN0pPL0hKamUyRG54RjR6anRnd241TFI2OVE0OS9DQVd3?=
 =?utf-8?B?bWdnUzJ2MW92Wm5jSFN1K0pvRzFaeHU4QTlCMGIvaW1LM3RpdXRodEdsV1Zy?=
 =?utf-8?B?aVVYczFJYk05VFJGY0pCQ2F4OXVUYUhOeXp2RENLWUgrdjhWajU3czU1SFlI?=
 =?utf-8?B?eUN5Vmc5R3lZY3dXWXVWL1k3K2M4b2ZLVmRndmdCVmhLL09BSURJTHYrdWU3?=
 =?utf-8?B?d0xhOEw5S2NFNWJpNEhaemtzaXllZTVaaWRaUmw5QW44WWNabjlDcjMxejBH?=
 =?utf-8?B?SU9HSXdyQy91a3NnbXpoelFFNmIyZ0hsb1ZRbnJtTUxzNUhIUGVEOG5VaEJC?=
 =?utf-8?B?UTZSWkYxKy9zN3hTb1J5V3VMdEJ0aUdVZno2dXpMVW1TcmlKdEdWYXlobFpr?=
 =?utf-8?B?c3BRdTRURDJpcTVPS3IwRkc3VGl6YVFXR3NEU1VCUXM4SVAxd2l1MmxBUHhK?=
 =?utf-8?B?VjlJd0dLTysvVENScVh0WFRFMkIzclBBMG52VDZqRVlGbmRQSUp2N3ZielAr?=
 =?utf-8?B?SlVyc2NHQmZzYzAvcU9NeTVJd3E2QXN3b2p6aVpLdnhHNmFqMTB2VGlINGlN?=
 =?utf-8?B?RmZwUVpZaVFwTkxKT3Z6eVZsaEd6TEVTZGpybk9tbVErbDZlZ2ZJNkYxR1N6?=
 =?utf-8?B?ZVk2bFVZWFp3TnRsR2VvZDVDSXpKRDcxNWc4aEs2Y29IUDhBNFB2NXgrcThS?=
 =?utf-8?B?ZWtBajlTeVFnWmxoa2hFQ3RTUlJMZXpiQ0JzTWFzVzVxdnpOYkQrUVNqODRL?=
 =?utf-8?B?TkEvU01kQzBpUmNkQndMWEhDbVNpUllMNjJvejNjeUw3YUJENkdPdjA3amJu?=
 =?utf-8?B?WXZXaXF4dnBLM2ZhZmpnKy9IL2ZaMUE5dFVmMkU5RDN4bW1FSzdzZVJKc3F2?=
 =?utf-8?B?Z282R2ZaaTQvQWM5VTRNTzRGNE1Nbis5bmplLzc5RXRJaDhlbXJDclJMTVNK?=
 =?utf-8?B?WEhZU2Q1TW5ZcE4ySjA4ZnQ5VEh6b2pqdGNQWDZDMXQvcUdzQi9mZ3lYa3cy?=
 =?utf-8?B?WGFVOXNnNUFpQ0Y5Q3V6ZlFYSVZjZS9ZeHUyTkZFTmFFaFJJaWxlZHZVNEdT?=
 =?utf-8?B?QzFUVFpLOFlHaDV4ajd2TjU2d3U3YXRmcWZlMGRPa1NLRHBoTDIxVXczbWNv?=
 =?utf-8?B?SWYrZGIyMWYwamlSQmxoWXJvREpoNWN6MnoyRisvOEowOGQvOStPODYxQkkr?=
 =?utf-8?B?WUIva0psNk5pazNXOUdOYWlJWU5nZnc2T2F1YXhVNTMwS2lJSGo3dTNtaFU1?=
 =?utf-8?B?WTQ2WVlCSjZSeXpyS0IvWlBHWndkaVFvUGRuRk1pbk1LRDVnR0UrNlNsL1Zh?=
 =?utf-8?B?b1Q0bUkyZXZtbFBhSmV5SmpCeVdHQnUrVmsvdUlJKzNiK1RBTk1LbFY3MWlS?=
 =?utf-8?B?RjhmZGt6Ri9rRmF2NEE1cG1Gb2JMVEptSEsvVE1pQjFrVU44YmdBZ09QV1Bx?=
 =?utf-8?B?N05nOHJvaFZrME1jc1dIajBzTys4c0NaZ3A1aTgwKzVXZXF3ejlEYmliNDI4?=
 =?utf-8?B?UE5mcWtpRU9SZFFtNHkvUUJqbXRJUFN3S2RhZ1YrNWZYdFFKRUZ4TWJXSHBt?=
 =?utf-8?B?RmlQeHJTSWlPaGlrbW5pV3VReUx2YzdEWUZzMzVEK3lTVU9jdW9heGcyODQ4?=
 =?utf-8?B?MTdZRzVWVWNPU1NGMC9OOTB5empWbHg4bEFtN2Z4UEpVdWVMM3ZKRW5YUGVj?=
 =?utf-8?B?MC9tUElCUjBUbW1HbGk5Q1lvYVhiSFp4UmVoV3F2blV3VXc5QnNvOEFKWnkr?=
 =?utf-8?B?UzgwT0N6VC91TXdpaDJOMWtNdGE1ZzNWK2h3N2pWaWF0VHRpMWxzTHJFTGhS?=
 =?utf-8?B?cmlmUnR0VHhjNXh3SzFhRWRvRWF1YU94R0svOVkvOSt5RnZtQTJiZ3JNV29J?=
 =?utf-8?B?YXVDMjhHUnh0c0RudGpGVUo5LzhTZmdPSCtnbmdjYmtaWXJTTUhPbm1wQ1Vy?=
 =?utf-8?B?ZEdCVm1uWUJ4engxejZxdkxpMVpPdWI5RXp0MW91Qng2Q2syaFdCT2FnbXd0?=
 =?utf-8?B?SHVBdno4RmE4eTBWTGFBRTh2Wk4vZURmaTIvSXByeWdacG4yR1J1d1FQOU5w?=
 =?utf-8?Q?UBwlEShSBoBK5z3LA4mG3giUB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf15204a-beb9-4050-bfc6-08ddb93babc5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 07:40:09.6613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VM7zmEXcHEJBOlVLqRBcTWEoxYP1Pigj494E0M5YcZQNIczHA+Oy091e8hqelpWj8MYWQ4y928h6naAhx/662A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371
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


On Thu, 19 Jun 2025 23:28:40 -0700, alif.zakuan.yuslaimi@altera.com wrote:
> Update the MMC driver to retrieve the clock manager base address via
> probing the clock manager node in the device tree.
> 
> 

Applied, thanks!

[1/1] mmc: socfpga_dw_mmc: Retrieve clock manager address via DT
      commit: be7fc8f331d5da68f54a241f08206e49236649d9

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
