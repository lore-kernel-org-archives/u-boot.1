Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7080D1048925
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 01:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6735F83EF9;
	Sat, 28 Feb 2026 02:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aNr1yua6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3B9983EEF; Sat, 28 Feb 2026 02:42:58 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42E6283EEF
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 02:42:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulptwuj3sIwnJ6/EwTvOYZ8DiGSvmfL03wrTB2Hn3nKCwB9YdJzBCwqcv6YVb+NYEcVSB4OPRPnCT12e6++8AVvN7MAAXlWXwaDPumDt878qLl8zDDNoyXVnxlXbo/gxGparJszH5CJGw15Rub8mo4C6VJS3mWimCJ9IuWLZSXaxLYe98YfmjKbCmYQsjqMcMoFFNn9lPKtC2P1AguNQyf3bOwo71cLY2e+GxqNurlHutvoTUc3GBo7O+n/qbnud01b4b91XVW7LXu5/biGg4cYOwrEF8n2GeKu8S43F7g/JjTj+FlCrTGa/VP1b570S+3NtRxY1o/jd1BQY0jOwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jooZTkGYL0HyEvUYxNg94UbLq2Z9wCIb23sbVwgynKA=;
 b=ZsPEjW4UIQb9WiHubxNcpOhxweKpf8lY0S6Kso3y9EL99cpsf38jK1BWWwqFRUkFKBAqbsWmgtIhh5sIqr7mRkHOHWAPYdBYXi4CuaAOyu1eu8N3LrK/TB7MyZSTCrTyD/vJ0N9I6RfpwmjWbwqv5hwzqllcVgJI5xjWvKpSikg9Wbsjhjz9FRfXZ7jE+nFJUvx43/jX4AVDr6rWz8o1Gli/GR4SflYZoYhctqalyejdGo0pTB4QGaCfq1AFOSdqDeZyRE2/a+s3w7iT8Yq0X+GSVkRPsw0bKQ8VDEo70h912ndi9W4KOdhVLJTt7Q4/dFK9PrfCX57OKLAr7Hezdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jooZTkGYL0HyEvUYxNg94UbLq2Z9wCIb23sbVwgynKA=;
 b=aNr1yua6SIIcONLdjF0aq7RQPNr0lEihLY3pt14n/iDYjdp9RnOT6WCsOpXqdicUMjuyjsoEXrY+XAlu85utumw61oQAN5mhGZlw0ml3H/Qh0f834AetOjsGrHnatFdEkG32/tEvKzcv4DmpC+yaRHaUYF39LgB0O0acyt5qrST1emVf6k/1vL1uMz4adDkNh+s5vDwuPUnz14Bw64Ncb0HvO2iG049gZJs0GRyiBRMTN2eKF9H3xNyKXj7YK6jX+jM4CaLWjUEgxLNcSehz+Xpd1udTKFyaESzE5gXFRywvgACjZb+Hygf3ew5uKnpJe0wwQ6JAcda1Cgc/qpjROg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by MI3PR04MB12440.eurprd04.prod.outlook.com (2603:10a6:290:75::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 01:42:54 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 01:42:54 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 28 Feb 2026 08:22:20 +0800
Subject: [PATCH v2 02/13] imx95/imx94: Remove board_phys_sdram_size from
 each board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-imx952-v1-2-0a360e7e8cb7@nxp.com>
References: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
In-Reply-To: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jacky Bai <ping.bai@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Jindong Yue <jindong.yue@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|MI3PR04MB12440:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df85e95-a39d-496d-4937-08de766ab0d5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: rnowICYTVW60OniMT3rW1l9D1dTbSeWPnfzV82jrlL8M60WDRR7lyMPKeaSd78USlOM3LGYbUF3zwqKF0gylgYBf0eu2rwnjBCDiw3869UaW8PtEEdL5Og7j+L0ELGeUBzR1pYemzadGC0Hr+5st5pFam0ZPMZSamSXwch5NO0t5ZFORFeODqZvo8PnvZCeDVzN2AkYPGqwEBVjpWmdLJEtxsFdD5iwEHpsD6IXpLctDwDu3tKbw+DEr+ggO0ld+XKRiPIQZerJbktEm7YpLwNoCykMA7myZZ0Igc3epMBQXcnxojVyS++xjVjjPpDzWBw2rCDjIwINJg804iWTApcw+Tudk0RLYL2y8oFtCF3zDsZnJb7yPEpoRNtMdmhtxyslYB2uUx5h7/l+SZeZTc88r8jl1q7MJ3axQEkVP/8VIEOcD5s/FsP6L309S4h2ZI5mcTjy2qizLioymu+wa0m3EYTWztDzNz33jT3Lodbuuh+JFbRENF/osc8ZDIK0nGIUteUCZb8fqSNDLdsoHqrSSVnhbxNFLXQ+eQNxBNozRxK2vKig2XMjqjiwV/8WZ9QuZxA7g4TDQA7h3rg0vZLe57nFtD0Ajjd3Qq9IGCg3+zFZzo8W7I0ARjdUbruzRW8YyreLTIlVCwGoousZ4jcEeF8RNczQwJKgIXPgtsOwPxZe8RoCYM4FOuRxuVIe7+MoIG07zPMIlzLolOhOKBrDxEMp5HO+Il5PCMnXIYNTZsvGK0V3T7OjhWvjhNPDPFv5/gswxPRo3hqCt7ExsfPw3JUh1lEIymNsrMnyXZG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmJDaVRITzFuWU1ybld3WkxFd01GU0RyQWdqSUsvQU5WRFFRUFBwWTFnTVlk?=
 =?utf-8?B?ZlJRVUVDQUd2QkhERWNLakNFVkdvMXFRUVNwNEVaZFZmUUZuc1hqSDd1TTcw?=
 =?utf-8?B?U3E3eUZ5RzV5THU1NDF5SUVjSmpGc0tHMUdaVjRlV1lwSG4rek0xaDFPZVlo?=
 =?utf-8?B?K1lCMUw1UUVnaytzY3VmZTV1enVUcVF6L1lSNWxxWG4rY00vYUFmL2RhRmdz?=
 =?utf-8?B?bE4razZSQWtkZmhsTVhWOGp1WHA0M0hjNk5kN0lxTjB1NExFdmpHRXpEL1Iy?=
 =?utf-8?B?Yk9hYllLVTJqb0J0MU8vQWMyNDFkS0Uzb2l3VXEwdHMwdnhidFhpL3JpcG1n?=
 =?utf-8?B?VjZSdGcyNXFGYXQ4Y1ZnNllXVWlUWVg1VVJlaHdScU1VbjBFWjAveU16RzR5?=
 =?utf-8?B?SEdBdXhwVDRxbmVkaStOL1hUQUR6YU9qbjNWOVhzdFhpM3dHUmFYM1hVQnFm?=
 =?utf-8?B?aWtYcFdrZmZIb3Bsdis1akptcXlJNVdZRnR0ZmlCRHlkL2RnQWl6eU5nSWtx?=
 =?utf-8?B?ckMvemNYWDJKaTg1dXJzOS9HYnNMNi8vUDA2RGd0OFoxdHhWUWt1NnNCSjhs?=
 =?utf-8?B?dHQrU1FlbE1rejNNRUpsMlk4N3Vac3lMT2tMTFB4SGpvSlBZNzMxdHppRFpW?=
 =?utf-8?B?SjhIVXhxYTA1QzdTVk5sMks3TWVnbitjQVFwejhEbVJwc0RyWG1UbzAxN25B?=
 =?utf-8?B?ZWlsb2NhcDFSTEJGdTZIV2JJSTlSNnJnQmZOY3RhdHpIUlpTZDBtNndzbE1a?=
 =?utf-8?B?SDJCUkQxMmRZMndyMFNaNFZVdTV2NU50UWltM2c5RHRNUzJNZWlpNTF5NlRZ?=
 =?utf-8?B?bUtHNTVGcXQ3QW1vZGxDUXlOZmg0U2paNVZSWkk2NS8zZGUxczRtOTV5T0dl?=
 =?utf-8?B?cFdsUEN5YUFXMjIyenB3RFlwdDg5T2ZNTWc0V3BURzJQQTBKS2o0T2Q2bmJC?=
 =?utf-8?B?RENNdDJoR2JZaW1qd2FNVlJyT0xxNHo0eGVKeEI2YktoejlXTkFENHg5dnVm?=
 =?utf-8?B?YWhrR0FWZ1FXY0NGRzdkSmlldDVkYytoRVA5T0UzcFNFODRjQWg5cGF0MUYw?=
 =?utf-8?B?TG9YcFFTTjdRaHZKU2RQcE5HeURzN2dmQVo3ZmF1UlVDY29EdGRzR3lnMWEy?=
 =?utf-8?B?T3B1L0RKQWVuVXl5U1BVOE81aE93UlUvd1A2aENwSW1HSVc5bkpUajZ2TGNV?=
 =?utf-8?B?YXNnd0RqYWhqT1V5K2pzeFpMUnAwem5NTUUzYXl6T3ZQa21OYWFuc203WDBj?=
 =?utf-8?B?cmFDdFRuMjZnM1ZOcHNXQXNnZnFqaHBERmNhamxjSkN0STUvNTVXbXBlU1F0?=
 =?utf-8?B?Q3gzaE5TdUVYbUlUT0NOR3h3ZG5YVWl1OTBpaXVDSFFuKzYwb1hUbitZejEy?=
 =?utf-8?B?enFXQkYyNUlYWWVJWXFiYUQwNk92N2ZXNUhhb2R0SlQ5TUlYSXZrUUt0a0Jl?=
 =?utf-8?B?c2NSQ3JzeW1NekNzZklLYTZQT3dYbnJVZmx1Q1hlVDMxbm5EQ0VLdWpkSGhZ?=
 =?utf-8?B?M2d6NktBME1tR1JlT2VUSEdWaVRhL2lSWnY5aEIyNzNsdzQ5VlowUUdDVXBn?=
 =?utf-8?B?V0lLVDkzakNxbGpsN2dpWmVjTmZxaERqQW9qcURxa0pRMzNnY2w2aUx3Qnhk?=
 =?utf-8?B?SytqaTVpRFlwbXhINXplQTdsRXZtUHVSKzJFRnJOVktMSEV0STNId1YrY3hM?=
 =?utf-8?B?V0d0WktXU1NVSmFSWnV3VWNkYXh4Q05URG0rYkFtRlViVHZFejFpTDg2MnJo?=
 =?utf-8?B?TlB6OEloU0pBbEVocjJxTkUvTmtxY2JIaHlEOW4yVUxXYnZLSVJIUnRjUzZ3?=
 =?utf-8?B?RWRpSmJaaUVjUzdjRkZTK0NVdmNKQlEwOGZnNTMzMjViV3hlcFRoRjhrakJ0?=
 =?utf-8?B?amxMcGlyemJralhaMlJxM3BNV3EvOFdYUG5pV1drL1FGN3RvR1hFSWlvTzhW?=
 =?utf-8?B?UG5PMkN2WmpDSVUyNE5xYnVERXJtSGphSzIwWUZZQ3hTWkIvNEhPcnJmQ0E5?=
 =?utf-8?B?NDlSR2pPTEhoR1lQMjF1UTNFdVlPemxKVWY5ckF6T2Zub1ZySC9VSVRNV1k4?=
 =?utf-8?B?MUZnaFp2b1JBYXpsUVQwdTdFTU9WaC9GOWQrSTZOdUszZkhMdll6YlcvNXhu?=
 =?utf-8?B?MWswNFczK2tzd0xjWjhsRkVSelBoQkRDNFR3bFpkMEJPSmswZ2ZyVmFKQitZ?=
 =?utf-8?B?LzVQM2tZRlZReTRDNCtUR0E1TkpxWkRLdm5zZEhzRDhaTWJPYVNQazRhTndC?=
 =?utf-8?B?S01JS0VuemtpVzdwcEcwRDBQMlJQdno0TjRQMmZNNWlKN2FoSXFtL25NWnZ1?=
 =?utf-8?B?NjlhZFBUU1ZxZVhxdmtDcXNEU1RYQjI5VGtKaWtJamRFNFVSUWdkdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df85e95-a39d-496d-4937-08de766ab0d5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:42:54.0654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ojm7P9wKrbS9UcPUBzxsYXTh8OglkZ9KGQsjDDyLTlHzm5711j4OjnVD0XLWxWJzBBuK4EjcUTMif7IrDN5Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12440
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

From: Ye Li <ye.li@nxp.com>

Change to use default board_phys_sdram_size implementation in soc.c,
which will call SM API to get DDR size.

If board has special implementation for DDR size, then board_phys_sdram_size
could be implemented in board file to override the default one in soc.c.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx94_evk/imx94_evk.c | 7 -------
 board/nxp/imx95_evk/imx95_evk.c | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/board/nxp/imx94_evk/imx94_evk.c b/board/nxp/imx94_evk/imx94_evk.c
index 2aeb21c1de7..4731b79b55d 100644
--- a/board/nxp/imx94_evk/imx94_evk.c
+++ b/board/nxp/imx94_evk/imx94_evk.c
@@ -26,10 +26,3 @@ int board_late_init(void)
 
 	return 0;
 }
-
-int board_phys_sdram_size(phys_size_t *size)
-{
-	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
-
-	return 0;
-}
diff --git a/board/nxp/imx95_evk/imx95_evk.c b/board/nxp/imx95_evk/imx95_evk.c
index 620a69b53e5..99a37e0593f 100644
--- a/board/nxp/imx95_evk/imx95_evk.c
+++ b/board/nxp/imx95_evk/imx95_evk.c
@@ -14,10 +14,3 @@ int board_late_init(void)
 
 	return 0;
 }
-
-int board_phys_sdram_size(phys_size_t *size)
-{
-	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
-
-	return 0;
-}

-- 
2.43.0

