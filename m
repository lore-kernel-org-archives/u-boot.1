Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2445CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 12:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE88E83881;
	Fri, 17 Oct 2025 14:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gR54RaCZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0ADB83655; Fri, 17 Oct 2025 10:20:31 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A51F683631
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 10:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWBj/7BIcLAm8BR3vyYEmILCme5ZmQk8ndJh/c8Zu4q/ZKYbKqbCpLjhfmgUIbjMIkMKY7Cv56oB7tn+lVQucLiAv8yAo2HHFOvUfPl1e4vv1cxR0ICaGX8/Td2+Az93ptQB6is8tB7CYNYtNmH1sSk/5DHTSJ7QiKmm/NvbnhPKwo5wsQzxSlCw/gSD49w3x2cmLUatmB/u0kpAb+VTRr1iDt7GNuFkWJK8OPUocZOIDAD3BcIPQlao2VKy7shqleQ63n3qT7G6/RwaxrT8563cNff3yDBUVNkBxdyksYgWWgfVfsnONd4zMQkoLIrHe/+mph4cfERaBGTamzmc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdzfKN9lGj9NV92z0ge92B8Rz+TYEN8fvFsdvpHrh10=;
 b=cOPwrgPRbBQh1kYfC0Z2EqUStSi6ERXJtKIHiHyoXsTVKu0M2Y0RXTlF1uILaw0KlqSYnjOMoFlz6wvc49Za4Z16SB3tf5ObWj50qlJuR1ZUAtNCU0XGzmrMz4BMTIKBUC8X/EL58Bs6dsQOB763vn7a9NUq2CK1Wifsy/IceqHHJh/H4/VHLYSCXuP6qPFNcgIzG09HuxCdegYxD09YCisk23IvFJ5DTvsMRVNL/5k1jcbbkBDDZ+IKUg2oC89MAnSpw3wkfNquq6FIqHdzJjA3lS7cIBVkujtmJ5yhS/SDWQy6XjUTtHErhOKfSOdIcH3t1374ueONOZTtI375nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdzfKN9lGj9NV92z0ge92B8Rz+TYEN8fvFsdvpHrh10=;
 b=gR54RaCZAgGS5MMDVP1GKzpNi0tvB5l8KuuLsYDMVIuU+/W2N4PKMRwnTw9DTnFSOXPu8F2cENZDdffJEaHVkdOtiMmvRXUBfKdL2/FmlIZCmD24tuJ5rgwvQeCY9qsXKdvYsP1AVlu5KgCxzsbwf28JiyPZw+YUXtJzBdMGGiSrd0vsNQEh3G4jQtxrfbp29m4kIjbvXhkw58qtOqJiiZN/L1ZBRvZcnUfv7jwUAfEglDy0IVJy5ufUm8zlZAkeacPUdQE7xWHfmqqDWJs/4plhOq5uLs5jiaVjcy+qQ2Xl3uynsyou3UE/ApsldVShETezMlGQU6n1IaTymODdQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9988.eurprd04.prod.outlook.com (2603:10a6:102:38b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 08:20:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 08:20:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 17 Oct 2025 17:32:33 +0800
Subject: [PATCH 4/5] firmware: scmi: Add i.MX95 SCMI LMM protocol driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-scmi-lmm-v1-4-9fd41e7a5ac0@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 40e72022-5c52-45d5-1bc5-08de0d56072a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THFCcjVDcnU0ZnZBRW84SFhieVc0dlZEVjBRc0VQckVHZVdkRjVXWXZ2WnBL?=
 =?utf-8?B?UFlLQjNjWVBNdm4zdDdPTk4wNGEyNi9yQnJZaWwwT2FEMDhvOVlwYW15YWtW?=
 =?utf-8?B?N1BRL0J4cjRPOHhULzJ0L0dGRFpaU3c3eXdVbit0aFFvWXRwY0F3VmJLOU5n?=
 =?utf-8?B?TWdQZEMvMy9RSVdpV25GUnVMNHo2SHpIVHpSclljOXk2Si8wV0M3Sm04dTdH?=
 =?utf-8?B?dFZGb2NXb245d2Y3ai9mNzMwQUNiRElDNXB1Q0NHUGVkZzErWGp6Mlc0YUdM?=
 =?utf-8?B?OGNFeVpBa2pXcVpISHlOMVlqNmVaZG9DZjBrVzlMSmpPaUU4YlhPdVhQbUJT?=
 =?utf-8?B?cGYwMXYwUXl3U1RqOWZvdURzVmd0b0xzVkI5ZFR6NHZTTlFiUnp1VUtDZW1N?=
 =?utf-8?B?Q2ZaQk4yb3JndUtHWkdjQzJBdUg3dllEN29LZ1pqY0F5ZTdwSFhSRHhnVm1P?=
 =?utf-8?B?S0lKcGYvTTNFY3BocmprUXh4eUNWRFJ2TFI5ZHVJc0g1aWIyaHlhU0hJNkVi?=
 =?utf-8?B?cnltL0x2SlhoVUhldERlSXMyRE5xeDBaVVJVdXlya2diKzQyQzdQcXlNQTBL?=
 =?utf-8?B?MENkRXVHQ1A2cFVmYnlNYmxHSkk5bzhkWktpQ3pHV2MrRUdwVDBMOGtsYjNm?=
 =?utf-8?B?ZUNqOVFrUkxQUi9rNUR6eWhVcXBiWjhQVjZsVS9GN2lLUzBGL0RqeVZ5T0lG?=
 =?utf-8?B?eWtSb1Q3K2NzUGxCQVhrVkw2MVp4S0tLaXFFYlRUYmtWcGlTeUQydUVrQmhF?=
 =?utf-8?B?NGY5enpyOHp6RG8yYmQ5d1lEWUlCdDY5cmE1VEVORU50M1dLQm1VanNQT2Jv?=
 =?utf-8?B?UVhwVmcwRDJuMHQwVnN4eEtNQ3pQeGhhTG9PT29WUC9ybUU2citZK1E0V3Vh?=
 =?utf-8?B?cGFYK3VOVFd0TkJBeGF1OW1kcXZFMlFscFNPZEJpTC9JQi9PcUZKbjRvWU5t?=
 =?utf-8?B?SE5icC9YQ2Jya2pGUDNFa3Q4TlFERzRveXhQMDBtNUZHVUV5eFVrbWxkSEdj?=
 =?utf-8?B?c2orS2M3ejRVeUxBaTZyK0ZUcWF3RXFseVpBV0dNSzFlSlFzdmtuOG9lUVJD?=
 =?utf-8?B?RjVlTmZiRWdrbURZYXBJWmFRVTNCNWcvMUMyWmZhUnpqNERXT1FRWXY4bUtj?=
 =?utf-8?B?ZkJKVmkxakZndnNmeGVTa0xIeXQyNXNobVBuN2JDaEkyajdTK0d4dmN4Tlpk?=
 =?utf-8?B?dlBSWHB3S0dBTjUrdHVCSVNhUVFlNzRFTmw5WUxRemtwcGV2L1psUENlZzVB?=
 =?utf-8?B?K1NGRy9ZVWp4UEtiMytacG9lckRKQW93SFhpeG11RkUvcU04Wm5sMnB1R3Jz?=
 =?utf-8?B?NFpUM2xYbzBvQUNYVFV5Q0w4dWZCRmIyblJGQUdhblJsYzVhL293ek9zQjc1?=
 =?utf-8?B?K0s4N0pNdXdFbXpBVzhocVUvNDdiaVNtK044dGJDdEZVYTRzSTBnZGRXanhI?=
 =?utf-8?B?MUNaYWsvWDU2VGhCUzJmcnVVNW1RU2czaDZvUWdSQXdTcG0zRXJkb0hSNFpV?=
 =?utf-8?B?QVpZenB5SnpPaTZ3ZU1xQUNIc0cyTjJNN3BqVEpIUTJJU1BIMzRnRDlkdU1s?=
 =?utf-8?B?ZHdEM2RkTzlsdEdIQ1lJWkUrUzdweDMzRUd5ekJFNis3ZkJmODdmeG52TVVS?=
 =?utf-8?B?TnJsVHBLLzlZZFhEdEZ0bUc0M2VwbzliUkVWOTBjQm10UTQ5THVwVVBRR09n?=
 =?utf-8?B?UWtNUml0YWRWcjFydGFrU2wvcmhXdndZaU95RHRTSVZtTlRzYVN0WUdQdGlk?=
 =?utf-8?B?Rlp0bk5lTE51MkFaQkJ2YzZjS24vZmRucC9jbVhDdXdwRUsxNGdmTHB3TVdG?=
 =?utf-8?B?Z1RiN0gvTXU4U1RrbG1zUi9GTW15NjNHelZTcGxnc1pGb1o0V2FyWlRabkgx?=
 =?utf-8?B?OFhkS01SYnhtd3lkYVJEeWRmdjRuQXVNZmhpM0FsWmc0VTRqOUhBZWpKeVhz?=
 =?utf-8?B?Z0NKN2JKL3ZPUlJva0JMWTUxMk16bHN0aGloSE53TFJkNlFDcVE0VmpLRzlk?=
 =?utf-8?B?K3VTeDNyNHk1VUVJVXhid2RxK2JncStIM2MxTzhSd1czRTYwSjVkSFNjeS9q?=
 =?utf-8?Q?m2C6xO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUl5b0FZKzFFTFVSZ0Z4M0M1U1lSRHBCcHJRazI5ZUpsSzBQZ1NXSDFibW5w?=
 =?utf-8?B?OWExNk1xOWlxdTRBRk1meUVwVjJaSnAwdFhBOHp5UmZ3U3RYc3c4SFdBWjE0?=
 =?utf-8?B?SURRL0ppTVRwN1hPcVlFY3ZlTy85YmtpWkdKSXRYTnl6S2Yvb3phNTJoV2FX?=
 =?utf-8?B?bmN1cXM3clRoSDdtZGhEK0UyS0R3dU9GUnZSblhsOVpOcXRtN2lkVXVsQ2Zl?=
 =?utf-8?B?V3pTcCs4ZjJ6U1NlYUxGU2tqejhvOEhsa3NXSzVSS0RxMkJkaSsybm5QNGZJ?=
 =?utf-8?B?cXR6a3greVhwbzhLZE1WeHB2S2pTc2JyWnZOK1pRZnk4ZnRJV1NkYXpwcFg2?=
 =?utf-8?B?dDJsS2pwZzNhQTNDUlVzT0pKVUlPSG82VXA2Nm1qYy9MYWMrT3JuUUJQY2xr?=
 =?utf-8?B?ODI0N1lGOU1oZFVBZTN1eEhWaVIrSUZ6M3RUY094bWw0NDlhbi90b2ZQZEJH?=
 =?utf-8?B?eGIrdWNjaFMvcGZ1Qll6QVhab3N6djlPZFNaMjVXbWhrK0NXbUMrN0ZhWEUv?=
 =?utf-8?B?Q2tqYXU5ZFpoejUvRWszSzlIMFFxMVNMRzhxZC8vV3hpWXVmOHJwT0lXeWQ1?=
 =?utf-8?B?c0c1d2V2R1NaUXNzL0QxZ1dLcTRDTGh1V0V3cVU5NC80WC9BWEZ0dEwzbUV0?=
 =?utf-8?B?N1pWSnI0R2tVUUREcnVXMHBhY0pNK0s0NjNLa3BQd21ma2NKS0U2YTFOUjdJ?=
 =?utf-8?B?SnJVRzRPejcwRnU5TjdFck9lbDR1MXc5RTlNMkFYa3lodkRYcFc3T0E3ME9l?=
 =?utf-8?B?eWRsS2VVVTRwLzlLTlhubnBQcnNkdmNldk1uempTaWl6eDh3UVZkVmo1RllS?=
 =?utf-8?B?YVZwQkRaNDZWaEcrM3VyR2hsR0hyOHk3bTNxd1E2dTFMV05pZVROdjk2Zml5?=
 =?utf-8?B?QnNEdkJCSndpRVhxRlhpU3dqaUMxUUhOeEY1cVR1Yk1WUnZzZForMDNMOHdS?=
 =?utf-8?B?V3ZYNk1uQ3FKYWFWa3BFbExDQnRNOHNmNmthTHZ4M0Vub1plM0VQZkhPTmh0?=
 =?utf-8?B?c2h5TDdjZ0tKMGJJSDNlQW9hVlp5L2QxLzgrUXpObG05VDZzSnFLZjJaRjhn?=
 =?utf-8?B?a2wrMXl2T09LbUMyWHIraFBGRFcxSkpRUHRjbFpHYmtGRmh1czBxUldiMVhh?=
 =?utf-8?B?ZEphV01pRlAxdUJxN0p0S3NIQ0preUxDQmY2Yit4UHNrTFpjV2hWOEZzcmxS?=
 =?utf-8?B?ZWdlaFV5N2d1VlhscjE5NkFseWZLWVl5M3p2ZGorNTczaythSDF4QmxoR252?=
 =?utf-8?B?aVpGQWVXR3R4eExVQ20vU01ZQmFSYUZRSXBrTFg0UDVOTWVDbWgzUk84Tzhu?=
 =?utf-8?B?cWQxQWx2MXlDWncvTEhob2pINFZlQjNXNkxDTnUwMHliTHRYa1lPSzBUaDBS?=
 =?utf-8?B?N09BK1Faa0NXTFcxQy96RG5oM2pVQ1lPZGZTSnVNREUvNnlrV3hxcUd0dUZC?=
 =?utf-8?B?bkxtWXBFK0xJajkrTVVQUy9uN3BLRVBOS056Y1FxZ3RUYWZBUGtIYnVnOUND?=
 =?utf-8?B?R0RVUTQrWE5tZWpEY1l1MksxbFFoMzR5V0RXNC91VUNXdU5UeXpyREdxRzd5?=
 =?utf-8?B?N0pzcFNTanBmMlUwR0NYMUxhT0E0MFNLNUxUZEN0cHRFekdjUThSNUpiVWdH?=
 =?utf-8?B?TkhOQ204WUhXOEpMZUtxdURrSkQ4TjJIR25ZUkdXdkIyc29YdHVtemhOUkxQ?=
 =?utf-8?B?SjNvSkRXa2NQeWFwcFFKWFJaYzNpVXIyMndqazVPYnJWRjNGellvV1krWGNp?=
 =?utf-8?B?RWRpNGMrRHMzWkdrOE41MTFNeHQ2YUJkWmozVklXSHk2d1NKYVJYeUpIc05I?=
 =?utf-8?B?SFlkeVAzNDVOdG04UGJDeTlaRUh6Y0dTbXRnbGVGWHcrV2RsQjdDeGllaElu?=
 =?utf-8?B?bG1QUTcxNHR2aThkdjl1OVBFT0ttbHhzTUs5M2RxcGl6Y0ZHeldXSVFWSGVB?=
 =?utf-8?B?VGNhcUNsN3J6a2dJRHhBdi8zaHJxaGFBM3RyNXZaYjAvZ0grUE03ZWlrbFZC?=
 =?utf-8?B?WTVIQ2lCT2taNytLeFhDdStoNGRYU1IxZjE2MzlsRlNPNXVzdkxvYzcraEoy?=
 =?utf-8?B?bmM1eUQ0RGdTdWJNeTJaNXlxSkR3R0NqYWJ2b0JjRCt0MTRJWmlQOVAxbU55?=
 =?utf-8?Q?jCTvKw3FcnpreBi8vff2Fbq2l?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e72022-5c52-45d5-1bc5-08de0d56072a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:20:27.3582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UjubyHAVKSIX55OKMqYgYIjKeICgy/knTSORo63o+0WmoQEnGCIFjaU6miMCdJzl6KCopf1JPyeWKWcMOT9aA==
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

Add Logical Machine Management(LMM) protocol which is intended for boot,
shutdown, and reset of other logical machines (LM). It is usually used to
allow one LM to manager another used as an offload or accelerator engine.

Following Linux Kernel, created a separate folder for holding vendor
protocol drivers.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/scmi/Kconfig                  |   2 +
 drivers/firmware/scmi/Makefile                 |   1 +
 drivers/firmware/scmi/vendors/imx/Kconfig      |   7 +
 drivers/firmware/scmi/vendors/imx/Makefile     |   7 +
 drivers/firmware/scmi/vendors/imx/imx-sm-lmm.c | 213 +++++++++++++++++++++++++
 include/scmi_nxp_protocols.h                   |  45 ++++++
 6 files changed, 275 insertions(+)

diff --git a/drivers/firmware/scmi/Kconfig b/drivers/firmware/scmi/Kconfig
index dca8fed9bd25a0555233a7bead3a326ef2f05344..33e089c460ba74084507b023bb1dd5037b73b60d 100644
--- a/drivers/firmware/scmi/Kconfig
+++ b/drivers/firmware/scmi/Kconfig
@@ -47,3 +47,5 @@ config SCMI_ID_VENDOR_80
 
 config SCMI_ID_VENDOR_82
 	bool
+
+source "drivers/firmware/scmi/vendors/imx/Kconfig"
diff --git a/drivers/firmware/scmi/Makefile b/drivers/firmware/scmi/Makefile
index dae42863589a9b8a84c1789610b950837ff73db1..6129726f81735fd8a531af18f9099cd5e1ea487e 100644
--- a/drivers/firmware/scmi/Makefile
+++ b/drivers/firmware/scmi/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_SCMI_AGENT_MAILBOX)	+= mailbox_agent.o
 obj-$(CONFIG_SCMI_AGENT_OPTEE)	+= optee_agent.o
 obj-$(CONFIG_SCMI_POWER_DOMAIN)		+= pwdom.o
 obj-$(CONFIG_SANDBOX)		+= sandbox-scmi_agent.o sandbox-scmi_devices.o
+obj-y += vendors/imx/
diff --git a/drivers/firmware/scmi/vendors/imx/Kconfig b/drivers/firmware/scmi/vendors/imx/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..211bb1f2244629096a50b06ee58006b5ee1a2dde
--- /dev/null
+++ b/drivers/firmware/scmi/vendors/imx/Kconfig
@@ -0,0 +1,7 @@
+config IMX_SM_LMM
+	bool "Enable i.MX System Manager Logical Machine API"
+	depends on ARCH_IMX9 && SCMI_FIRMWARE
+	select SCMI_ID_VENDOR_80
+	help
+	  If you say Y here to enable i.MX System Manager Logical Machine
+	  API to work on some NXP i.MX processors.
diff --git a/drivers/firmware/scmi/vendors/imx/Makefile b/drivers/firmware/scmi/vendors/imx/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..6031ad805209eda3313f53f9eee4ec96c9a4fe88
--- /dev/null
+++ b/drivers/firmware/scmi/vendors/imx/Makefile
@@ -0,0 +1,7 @@
+#
+# Copyright 2025 NXP
+#
+# SPDX-License-Identifier:      GPL-2.0+
+#
+
+obj-$(CONFIG_IMX_SM_LMM) += imx-sm-lmm.o
diff --git a/drivers/firmware/scmi/vendors/imx/imx-sm-lmm.c b/drivers/firmware/scmi/vendors/imx/imx-sm-lmm.c
new file mode 100644
index 0000000000000000000000000000000000000000..2fd791ca85315090b2c4706c8a3ff05fcd1fad1f
--- /dev/null
+++ b/drivers/firmware/scmi/vendors/imx/imx-sm-lmm.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * i.MX SCMI LMM protocol
+ *
+ * Copyright 2025 NXP
+ */
+
+#include <compiler.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/types.h>
+#include <misc.h>
+#include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
+#include <scmi_protocols.h>
+#include <scmi_nxp_protocols.h>
+
+enum scmi_imx_lmm_protocol_cmd {
+	SCMI_IMX_LMM_ATTRIBUTES	= 0x3,
+	SCMI_IMX_LMM_BOOT = 0x4,
+	SCMI_IMX_LMM_RESET = 0x5,
+	SCMI_IMX_LMM_SHUTDOWN = 0x6,
+	SCMI_IMX_LMM_WAKE = 0x7,
+	SCMI_IMX_LMM_SUSPEND = 0x8,
+	SCMI_IMX_LMM_NOTIFY = 0x9,
+	SCMI_IMX_LMM_RESET_REASON = 0xA,
+	SCMI_IMX_LMM_POWER_ON = 0xB,
+	SCMI_IMX_LMM_RESET_VECTOR_SET = 0xC,
+};
+
+struct scmi_imx_lmm_priv {
+	u32 nr_lmm;
+};
+
+struct scmi_msg_imx_lmm_attributes_out {
+	__le32 status;
+	__le32 lmid;
+	__le32 attributes;
+	__le32 state;
+	__le32 errstatus;
+	u8 name[LMM_MAX_NAME];
+};
+
+struct scmi_imx_lmm_reset_vector_set_in {
+	__le32 lmid;
+	__le32 cpuid;
+	__le32 flags; /* reserved for future extension */
+	__le32 resetvectorlow;
+	__le32 resetvectorhigh;
+};
+
+struct scmi_imx_lmm_shutdown_in {
+	__le32 lmid;
+#define SCMI_IMX_LMM_SHUTDOWN_GRACEFUL  BIT(0)
+	__le32 flags;
+};
+
+int scmi_imx_lmm_info(struct udevice *dev, u32 lmid, struct scmi_imx_lmm_info *info)
+{
+	struct scmi_msg_imx_lmm_attributes_out out;
+	s32 status;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_VENDOR_80,
+		.message_id = SCMI_IMX_LMM_ATTRIBUTES,
+		.in_msg = (u8 *)&lmid,
+		.in_msg_sz = sizeof(lmid),
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
+	info->lmid = le32_to_cpu(out.lmid);
+	info->state = le32_to_cpu(out.state);
+	info->errstatus = le32_to_cpu(out.errstatus);
+	strcpy(info->name, out.name);
+	dev_dbg(dev, "i.MX LMM: Logical Machine(%d), name: %s\n",
+		info->lmid, info->name);
+
+	return ret;
+}
+
+int scmi_imx_lmm_power_boot(struct udevice *dev, u32 lmid, bool boot)
+{
+	s32 status;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_VENDOR_80,
+		.message_id = SCMI_IMX_LMM_POWER_ON,
+		.in_msg = (u8 *)&lmid,
+		.in_msg_sz = sizeof(lmid),
+		.out_msg = (u8 *)&status,
+		.out_msg_sz = sizeof(status),
+	};
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	if (boot)
+		msg.message_id = SCMI_IMX_LMM_BOOT;
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
+int scmi_imx_lmm_reset_vector_set(struct udevice *dev, u32 lmid, u32 cpuid, u32 flags, u64 vector)
+{
+	struct scmi_imx_lmm_reset_vector_set_in in;
+	s32 status;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_VENDOR_80,
+		.message_id = SCMI_IMX_LMM_RESET_VECTOR_SET,
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
+	in.lmid = lmid;
+	in.cpuid = cpuid;
+	in.flags = flags;
+	in.resetvectorlow = vector & 0xFFFFFFFF;
+	in.resetvectorhigh = vector >> 32;
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
+int scmi_imx_lmm_shutdown(struct udevice *dev, u32 lmid, bool flags)
+{
+	struct scmi_imx_lmm_shutdown_in in;
+	s32 status;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_VENDOR_80,
+		.message_id = SCMI_IMX_LMM_SHUTDOWN,
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
+	in.lmid = lmid;
+	if (flags & SCMI_IMX_LMM_SHUTDOWN_GRACEFUL)
+		in.flags = cpu_to_le32(SCMI_IMX_LMM_SHUTDOWN_GRACEFUL);
+	else
+		in.flags = cpu_to_le32(0);
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
+static int scmi_imx_lmm_probe(struct udevice *dev)
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
+U_BOOT_DRIVER(scmi_imx_lmm) = {
+	.name = "scmi_imx_lmm",
+	.id = UCLASS_SCMI_BASE,
+	.probe = scmi_imx_lmm_probe,
+	.priv_auto = sizeof(struct scmi_imx_lmm_priv),
+};
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_VENDOR_80},
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_imx_lmm, match);
diff --git a/include/scmi_nxp_protocols.h b/include/scmi_nxp_protocols.h
index 7e2143b16ead05a2662d9b88d2d348ab16a5750f..1c79bc2282b6efb02bcfc4843c1b4a0e83fe93fa 100644
--- a/include/scmi_nxp_protocols.h
+++ b/include/scmi_nxp_protocols.h
@@ -9,6 +9,7 @@
 #include <asm/types.h>
 #include <linux/bitops.h>
 
+#define SCMI_PROTOCOL_ID_IMX_LMM	0x80
 #define SCMI_PROTOCOL_ID_IMX_MISC	0x84
 
 #define SCMI_PAYLOAD_LEN	100
@@ -50,4 +51,48 @@ struct scmi_imx_misc_reset_reason_out {
 	u32 extInfo[MISC_MAX_EXTINFO];
 };
 
+#define LMM_ID_DISCOVER	0xFFFFFFFFU
+#define	LMM_MAX_NAME	16
+
+enum scmi_imx_lmm_state {
+	LMM_STATE_LM_OFF,
+	LMM_STATE_LM_ON,
+	LMM_STATE_LM_SUSPEND,
+	LMM_STATE_LM_POWERED,
+};
+
+struct scmi_imx_lmm_info {
+	u32 lmid;
+	enum scmi_imx_lmm_state state;
+	u32 errstatus;
+	u8 name[LMM_MAX_NAME];
+};
+
+#if IS_ENABLED(CONFIG_IMX_SM_LMM)
+int scmi_imx_lmm_info(struct udevice *dev, u32 lmid, struct scmi_imx_lmm_info *info);
+int scmi_imx_lmm_power_boot(struct udevice *dev, u32 lmid, bool boot);
+int scmi_imx_lmm_reset_vector_set(struct udevice *dev, u32 lmid, u32 cpuid, u32 flags, u64 vector);
+int scmi_imx_lmm_shutdown(struct udevice *dev, u32 lmid, bool flags);
+#else
+static inline int scmi_imx_lmm_info(struct udevice *dev, u32 lmid, struct scmi_imx_lmm_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_lmm_power_boot(struct udevice *dev, u32 lmid, bool boot)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int
+scmi_imx_lmm_reset_vector_set(struct udevice *dev, u32 lmid, u32 cpuid, u32 flags, u64 vector)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_lmm_shutdown(struct udevice *dev, u32 lmid, bool flags)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 #endif

-- 
2.35.3

