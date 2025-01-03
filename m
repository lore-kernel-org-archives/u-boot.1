Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34928E7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 542F0803F5;
	Fri,  3 Jan 2025 07:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xs72XMWP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD7B800D7; Fri,  3 Jan 2025 07:46:08 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DA628042F
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iai1efNkvfAWWRcZJAjUYnt0LGQEZnryQdbnqYU6wXvThHDhAZWMcnmoHt2xYjUSeRZXv5Hpiby+I2Bc/abf43Ha/Vc624TysRtj6HuT4+RzQFeQslhkoT5lPu0K6hjQi4/rC47tIAdGc8xiugl4FUfzDueEaFrhM2C18hfRTUPHZN4PnEUx3TawCf+/xHX9nfvMSsbWv4HpOU+jVVtRvg4W0v+nposQpj52lnM/g9iQfX5eQ9X0Qi+6Jv17yiSb/3rTV9sCugK5FNpjZ18HC8yho98u1Md/UN8ScLtEmv8Dz8NbOtqmEtJ8I3aMSX9/ekgk9mSdp3+whwlAm1jf8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdaUJq37u5NwRd1+15f37N53HB8K2yUwFC7jSB214UA=;
 b=LBp3eeex78u5PBojH7mQQdPAfCBf4Yk6wSt0VIxJJSEwrHFuq4hSvcyYK/+BCzR/IQqb/vY7Yr4ceoWKJWS0m5yXAP9Env6TEX5sXAobyKPFBvR2Gq4gsdiigRrA5KQZo1axB/1DqsAd40KLA7jL+a2n9ik6PU31RoO91eyP2KHAnn08aRsflMu57qrAskGBK0cSrMKD8XTujh103Wr+cRn95XKsllcaKz1eFfLlItWx0H7vVBSX7TSpbl7wniFII25rxcCWqBHpHvUYrggpVyqn8nYyXTTFY9hIuz9j/fJqoMzxXPJpxJNsng4wW7tCrGLkMPIwvkGiGdss/5+qdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdaUJq37u5NwRd1+15f37N53HB8K2yUwFC7jSB214UA=;
 b=xs72XMWPRQICv9R5AnS1hKdXJQr7RHUoP1wZcl0uz6mQSRsppzrDsAbrxuE3LeWmBZDdI6Wu9NE58ZCCkZtRoV2vQ+b2RM9/MfM5XDfvXfX22mQd25cIlmuUvsI/FPHF+kH/HaZR3EPhGUN1NthIHMBqr7QjF385Rxm2ZZA8DwRLYH0+jSxae/nn9PqrRqMHuclr8lME0PvtgqaAZ5wKmouAkAY0RB1TJVpbAt7jCGOqF1jTh1t3G0Z1DB4bpLIPY54w/958U90TArwdNKR9D82aDz5+wRei9Sp7vvBXSDsg0iZ9kDKdXEWDzzz22ox1kSt5do5cgLIB9GRwKRu4Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAWPR04MB10054.eurprd04.prod.outlook.com (2603:10a6:102:38b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:46:00 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:46:00 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 03 Jan 2025 14:45:38 +0800
Subject: [PATCH v3 03/17] pinctrl: nxp: add SCMI pin control protocol
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-imx95-v1-3-6744df5dc020@oss.nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com, 
 Peng Fan <peng.fan@nxp.com>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=12268;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=iuYYIv4PubC/TZlHfUYKQRO3Rk5FciGjCHlSMa9Dmfw=;
 b=wKF1KHCAe8W5Ppolyf3u8PARcscCt3G3xrWMUl/PkUvrY/heM5yxXSYiGFYWnt2gvmLzT8MEL
 Nmis6Fn/oivD4keYcrE8xXeIFg4b/kuE1IRlppRR4Z9otPzPHyUoDrA
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAWPR04MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f8015ad-7338-4d88-70aa-08dd2bc2491b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTB2cGJqZ3JxTks3YTZFZitWSzZVMUI0a1pwNFRSQzU4Zm9kZUlnVGZHQjA4?=
 =?utf-8?B?Z1hBWXRPd0JaR0E3cVM5MHVXZk9NY2RxbHVRVk1yZTMvQm5URXBjZHNLMDNF?=
 =?utf-8?B?QW42UHBsaklXVHhsNWtrN3puRW5VRTRJMm9XKysydEltOGJPN0RSSDN5YjhZ?=
 =?utf-8?B?L2tpdHc5YnlKVktOc0RGTXdZd2d1ZGQ5dk8ra3ZkMkptYnNqS2x6aDZObXZB?=
 =?utf-8?B?M2w0L2syTjNEVEVzSjJoOHF4MTlkMWtkN0FyeGdhM1B5MEs2VmUyV2gzc0Nj?=
 =?utf-8?B?VlNJekZzL0FCbTR3bnRTTk5zK3MvSW1pYzRCbWdZK21zWG5OM2RkOGlzeWRu?=
 =?utf-8?B?TExVUUNlOVpLVnByNEdLNU4yK0wxUUYyWEE1Wm1wbmtFNHpQOW5Xc2lPL2Iw?=
 =?utf-8?B?M1NzcDYrdm9iOFp2UTY4MG56SG8vdHlpR3ExS080ZURCTzF3bUVFMUt1cjBH?=
 =?utf-8?B?eXhqR3VseEd4TEY4eVd3RlRSUG9BREJEQzVoaDZReWtyMnVvSlU5NnpaUWNE?=
 =?utf-8?B?a2JmVHd6bjlibXZ6bVpId05MT2E0azU1dFhGakQ4NkVKdWR2dDA5Q0JDOFBP?=
 =?utf-8?B?eXpwakprWllWOXN0cXl1ZklhVG9mc0xMM21aZmp1OHd4NGUrYUZqVDJmbXNz?=
 =?utf-8?B?SHVGZTQyT2IzMmdrRS9UdHp0ZnBKT3N1eG1vZVh3OTNFblJ0bVhJMTBzS1Na?=
 =?utf-8?B?ZzBoU29kUjZ4SG9QVWV6Vy9NcWx5YVZXWWZjY25rcWh5RlRlaENsbXpiM01j?=
 =?utf-8?B?NG15aWNzNzJaMGxrSytkQXFtaFVSdjJMNmJ2aEo5SGkxbkI0TUk0dGdJU1ha?=
 =?utf-8?B?UFdqUmhueWh2amRiYkVWQUtGWUhuNmVoUjRRODZOVkIvMGFCME00Q0xVOWY1?=
 =?utf-8?B?VmJwdVU4ZGdxNmxnZTZRdHlVQnF1RE9DVnFHUGZKL1dlc1l0TXBkUFpYL3FJ?=
 =?utf-8?B?ZXFTVDlDUXUwU1E1aGJacUJwRUs5bzI1cytneWpYTlFrSlJ2NEM1VmhUT0Zv?=
 =?utf-8?B?RlRmdmFkRjM1UHd4anNHZ2xTbUhiOTNaZGlHWmw5b0w1VFFHakV5VnZOWGln?=
 =?utf-8?B?bkNXaDV0NFZQcDZScFBXcWJjZEFOelpqVzNkOUxYRkJYTm5TZEpYS2I5V1pi?=
 =?utf-8?B?aElOSDlaZDF6ZWV5ZXQzVzNyZmQwemtUM0NoWWhNd3NUZU1Jb2FzVVBqMjVa?=
 =?utf-8?B?M3dKdldTRmZVSXhNZ0RiUVQrb0dLdEZIU3p5U2JlY3RIOXNVLy95QitjNytM?=
 =?utf-8?B?ZW9rYlJ2NnRuQ3ZWZ2wzVHR3TFVLRG1sTlF1OE9GeXh3NFlDbTJWRFBLZTNV?=
 =?utf-8?B?NFp2Q2FsN0tBSmZyY3E1enc3TGQ4UHdoWm5jZlJiRzliVTlSdzNaSjRSV2Ns?=
 =?utf-8?B?YndMN0p1M3huRWhpV2FtVlc0ZHd2OVZkcEQzSFJIQk9OUXhuTkFoaCs2YWJT?=
 =?utf-8?B?Q3djRlIwWDNuNUczODVZL2NBTzljSmNaemtnTHlJZHFzT0M4UHBXbHdLeU1o?=
 =?utf-8?B?dG9vVXlYTkZxc2l2L09ORkN0YytzRnZLTml2S3FRRDUxVHlsdTAzZEVzVG8y?=
 =?utf-8?B?T3R4dVM4U0tXK1BDWWhsN0kwUUlTZG1tVjM3WkdZQzVac3M0cXRuVGhGOGht?=
 =?utf-8?B?Mm9tMis0TW9KWitNa3NqOGVZcnVVcUxJU2RWY2ViZ0xocHU0RXc3UUxGd016?=
 =?utf-8?B?R1pWcFpWU09GRFE0SnJaZnNReTdzRU8zOUZpQkd3T3RWVUMxelpJUFBlclMw?=
 =?utf-8?B?WDBXd01pcUwrSWcxWmcyWmtrYXZ0RVJNMk94cDcxc3hWQ0o4TFRFL2h3cy9T?=
 =?utf-8?B?aHVlaG5PNUttVzdJaXVucDBPRUg5Uk5aN3BUM0J5anFsbzhURlB0TjZwdHlS?=
 =?utf-8?B?d2JOWEF5eU5tN3I3TFNBTjEyODErS2tIR2VOZEdNaUlmeThvdUo4eHVzNUdJ?=
 =?utf-8?Q?/iPSFjPywJPNwxS4Gc4V6HCDtWGToNnN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXZMbUk3dTZOaXFaQ2VuY0gyRmJSa3Rpd1lOcFRQNUdiOGJCdUNWVkFtY0ds?=
 =?utf-8?B?WUpwWjlaS3R1RUZjL2V5eHp3VUxLaVlpbGlKUExHSlhqRGh4T0dtYkV4Vi8z?=
 =?utf-8?B?K20yMCtDUEZCSFhuV1h5dFNINHJ4WkpMR0IrOTQ1YlIyWjlxZE9JaHVtSjQx?=
 =?utf-8?B?QW1Ecmc2VncvekY4aFNEeUQvS0s0OTdBeDA4WFpuZEVDWXllNVBWdkVLNjUx?=
 =?utf-8?B?T2ppQmFqQ2dYYmhJRG83V3YzZkVKaysvU1gyMDVDNFFKTGRFays0VlFxWEI2?=
 =?utf-8?B?ZS9iWnUzUVJQTzlyNlF6bFZpd1J2WGsvYUJ3Z05TVFNtU3R2SE9PQ1FOVUYz?=
 =?utf-8?B?VEZ0L3BvLzM1YktrTE9RWUpUM2UxdndPejhkSjlWYkNQbFpkQ2JJVm1NUk5V?=
 =?utf-8?B?ZUZwRGYveFdpQ0VibGkvVS9WdVBuYzRHMG5vOCtpMlN1S25XaGlJdHBkYzlq?=
 =?utf-8?B?R0RKTFFVMkx1VGVqNE4vQW92T0tvb1l1YmVQZVE2d3Q1Tm9tb1A4Zlp2OFFw?=
 =?utf-8?B?Qzc2eWxQZUpWbjZUTkt0NGNwc2NNZWlBOElzSEN3R1kwNlU2Yk5NeENuRlhN?=
 =?utf-8?B?aHBPMlRVUi9UN2ozdG5Fb3NERm85dDJKdWpEc3hKdEhxc3BEeGpnMy8rNmZI?=
 =?utf-8?B?SEtXVWZnTzFkN0s0b3VoalNvS01hZCt1QTJIUExBb0lOUTFsbzV4V2lWUE93?=
 =?utf-8?B?c0lnUElTV3pIaW0xcFZNNkhpcUgzQnpSMVI1ZjhjSkpuMkxYTERnZjIyWEkx?=
 =?utf-8?B?Wk8rdC80TXdKdXl6MnBhV05ETmZCOXpUYnAzK1Rxc3V0Tk5ybnd5TlBBVkFu?=
 =?utf-8?B?cTJCMnVQZWF5bkZyZGdDaGhJcTJrWjdSWFRIZDNQbE9laVJobFRJSitodXhK?=
 =?utf-8?B?WHRraUlCR05vOTJCZFB5L1gzVjB3MFEzOGtzbkZLM1owbS9XUXlZWkJZVDZn?=
 =?utf-8?B?WGRacnNFUk51ODl5SnV0eGJQejFNblZVVjlwR05NWUk1R1Z5dVlWbUQvaHZw?=
 =?utf-8?B?akpqcHpXOGdCRXpteTg2SGE5bVFtdUhyUW1rTGlHTjFIRmkxbGI1TzYvNDZH?=
 =?utf-8?B?aER2eGgrUmxieVgyQmE1eERNSmh5YU5MYTZYdXVDOHlJZnZua1RRMEo3dDl2?=
 =?utf-8?B?OXYyeW1hYnpGb3MxMy9vMjlnTmR4TmpwNHpGR1BBekxZVWRiMXhHT2VveHJi?=
 =?utf-8?B?MUVqMGgxQUlpcHExTjNQMWJMRjNyd0E5TnNKdEl1YmZkSWczeUpLSTkycTNx?=
 =?utf-8?B?VmU3L3Vjbm1LbzVEdmJ6NVRhTmZvZ2dUaElRZXF4YmNoa05IVS9FOEIwbzZU?=
 =?utf-8?B?L3FwMGpDNHQ4VStXVHZ6YWJjZWNXVXpyU3pFVlJXbHduQlNGUmRva0t3OGVv?=
 =?utf-8?B?blpoMHRFVTYvY0xwY3VGcEdDa2taUTFabnpMbmRPN3dCc3dBZVlpTVI4NmY4?=
 =?utf-8?B?UVNVMEMwdnVPWE9KZ3U1S09DNjF6RlpHcVUxekNsbGtCelh3WDNUOU50alRu?=
 =?utf-8?B?bzZ5Y0h6V1V1em8zVE1KcjlOclYrZHloZVpFWDB0a2pQa1N2RG9BTldHMkEx?=
 =?utf-8?B?M3VFMFByV1Yza3BMWVpPekx5YzNVT1FkOUdRNWRjV1RKbEtpc053ZmxQYTdQ?=
 =?utf-8?B?V1NXRVUzcVdEN0JIYk4welo3ZW9ZSWtLU2hyU09xTXdnbHdvZkxaRlRQalkw?=
 =?utf-8?B?SjVJbTdFZDhyMGd4UkNra1F5c2ZUUGg1Yjd4SHE1c2FMVExRT016RnpIZWtU?=
 =?utf-8?B?SU82WjFaZXBoMlRRSUtNbDFuMlhxbDdkdkh6TUsyYksvbnA0ZTJGVDVmZkVJ?=
 =?utf-8?B?VVI1TlNYeHFEL29WRjJPelpXT3Rza01oU2hJL0xMUGVoZzZPT1JPSWtPSVNE?=
 =?utf-8?B?eS8yakJLUklFNmRvRkJZWFRBcThYZ09Tbm1PRVhnQ2FUdnRCazhqdjBKVkg4?=
 =?utf-8?B?SnlLNjFIS051cDRkVW5KU2hqRnluSjAwaFBUYkkyRVVqdnZhYTU3bkxZT0wy?=
 =?utf-8?B?UE9iZW1COGZWckhYNjFLalFES1kwcSt3N1U0SFJZZitxbnVBSVNEOEE3WUxl?=
 =?utf-8?B?SjV2cTdwVlBKQUliVDdOcG16SFVIN1p1d1hjWHJWcVVNS210SXU4dEc2TU5Y?=
 =?utf-8?Q?Xf+n/aC4cAF6yQ9VwyhCxyX0T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8015ad-7338-4d88-70aa-08dd2bc2491b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:46:00.7830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lZ6Whg2dRh9y2E+5YPu7L9+QWGrkpGcs3e9LKsEbJs97MIsFHFzgZyPo5afqqSvvJFDbp+uJkSYl6+pPx62aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10054
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

This patch provides a driver for the SCMI pin control protocol which is
based on ARM's System Control and Management Interface (SCMI) 3.2.
Currently, only the PINCTRL_CONFIG_SET command is implemented.

Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c |  11 +++
 drivers/pinctrl/nxp/Kconfig               |  13 +++
 drivers/pinctrl/nxp/Makefile              |   1 +
 drivers/pinctrl/nxp/pinctrl-imx.c         |   7 +-
 drivers/pinctrl/nxp/pinctrl-imx.h         |  11 +++
 drivers/pinctrl/nxp/pinctrl-scmi.c        | 136 ++++++++++++++++++++++++++++++
 include/scmi_agent-uclass.h               |   2 +
 include/scmi_protocols.h                  |  34 ++++++++
 8 files changed, 213 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 8c907c3b0328095c4b35ba089ed608fcda48b567..5f101f4ede8b585f8c562a42886ea7be4ef09953 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -97,6 +97,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		proto = priv->voltagedom_dev;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		proto = priv->pinctrl_dev;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		proto = NULL;
@@ -147,6 +150,9 @@ static int scmi_add_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		priv->voltagedom_dev = proto;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		priv->pinctrl_dev = proto;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		return -EPROTO;
@@ -436,6 +442,11 @@ static int scmi_bind_protocols(struct udevice *dev)
 				drv = DM_DRIVER_GET(scmi_voltage_domain);
 			}
 			break;
+		case SCMI_PROTOCOL_ID_PINCTRL:
+			if (IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI) &&
+			    scmi_protocol_is_supported(dev, protocol_id))
+				drv = DM_DRIVER_GET(scmi_pinctrl_imx);
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
index 06c26f156f6c8f63204604d6065485629cfd9b61..0086f9825837bf568bd7633a21da860e410eeeee 100644
--- a/drivers/pinctrl/nxp/Kconfig
+++ b/drivers/pinctrl/nxp/Kconfig
@@ -1,6 +1,19 @@
 config PINCTRL_IMX
 	bool
 
+config PINCTRL_IMX_SCMI
+	bool "IMX pinctrl SCMI driver"
+	depends on ARCH_IMX9 && PINCTRL_FULL
+	select PINCTRL_IMX
+	help
+	  Say Y here to enable the imx pinctrl scmi driver
+
+	  This provides a simple pinctrl driver for i.MX SoC which supports
+	  SCMI. This feature depends on device tree configuration. This driver
+	  is different from the linux one, this is a simple implementation,
+	  only parses the 'fsl,pins' property and configure related
+	  registers.
+
 config PINCTRL_IMX_SCU
 	bool
 
diff --git a/drivers/pinctrl/nxp/Makefile b/drivers/pinctrl/nxp/Makefile
index f10aa6ef188e37583b181bdf9d70ac191e506d75..3ec3e2a9c6fdb875da4ae9bf151df5666256883b 100644
--- a/drivers/pinctrl/nxp/Makefile
+++ b/drivers/pinctrl/nxp/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PINCTRL_IMX6)		+= pinctrl-imx6.o
 obj-$(CONFIG_PINCTRL_IMX7)		+= pinctrl-imx7.o
 obj-$(CONFIG_PINCTRL_IMX7ULP)		+= pinctrl-imx7ulp.o
 obj-$(CONFIG_PINCTRL_IMX8ULP)		+= pinctrl-imx8ulp.o
+obj-$(CONFIG_PINCTRL_IMX_SCMI)		+= pinctrl-scmi.o
 obj-$(CONFIG_PINCTRL_IMX_SCU)		+= pinctrl-scu.o
 obj-$(CONFIG_PINCTRL_IMX8)		+= pinctrl-imx8.o
 obj-$(CONFIG_PINCTRL_IMX8M)		+= pinctrl-imx8m.o
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index b1960c56b512cc113a810304dc3ac3f99b237a7e..3d53d0cd4b60c0685dd4c73c23e61cb712cda0ee 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
+ * Copyright 2024 NXP
  */
 
 #include <malloc.h>
@@ -65,7 +66,9 @@ static int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 
 	npins = size / pin_size;
 
-	if (info->flags & IMX8_USE_SCU) {
+	if (info->flags & IMX_USE_SCMI) {
+		return imx_pinctrl_scmi_conf_pins(dev, pin_data, npins);
+	} else if (info->flags & IMX8_USE_SCU) {
 		imx_pinctrl_scu_conf_pins(info, pin_data, npins);
 	} else {
 		/*
@@ -216,7 +219,7 @@ int imx_pinctrl_probe(struct udevice *dev,
 	priv->dev = dev;
 	priv->info = info;
 
-	if (info->flags & IMX8_USE_SCU)
+	if ((info->flags & IMX8_USE_SCU) || (info->flags & IMX_USE_SCMI))
 		return 0;
 
 	addr = ofnode_get_addr_size_index(dev_ofnode(dev), 0, &size);
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.h b/drivers/pinctrl/nxp/pinctrl-imx.h
index fa4c084e2fc067fcb4e92c33312d4f430081fffd..b2f8865ded0ae380fc0156baa5eaea505c12f501 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.h
+++ b/drivers/pinctrl/nxp/pinctrl-imx.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
+ * Copyright 2024 NXP
  */
 
 #ifndef __DRIVERS_PINCTRL_IMX_H
@@ -47,6 +48,7 @@ extern const struct pinctrl_ops imx_pinctrl_ops;
 #define ZERO_OFFSET_VALID	0x2
 #define CFG_IBE_OBE		0x4
 #define IMX8_USE_SCU		0x8
+#define IMX_USE_SCMI		0x10
 
 #define IOMUXC_CONFIG_SION	(0x1 << 4)
 
@@ -65,4 +67,13 @@ static inline int imx_pinctrl_scu_conf_pins(struct imx_pinctrl_soc_info *info,
 }
 #endif
 
+#ifdef CONFIG_PINCTRL_IMX_SCMI
+int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins);
+#else
+static inline int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins)
+{
+	return 0;
+}
+#endif
+
 #endif /* __DRIVERS_PINCTRL_IMX_H */
diff --git a/drivers/pinctrl/nxp/pinctrl-scmi.c b/drivers/pinctrl/nxp/pinctrl-scmi.c
new file mode 100644
index 0000000000000000000000000000000000000000..19b1b433a5ced0bb85e52f4d19bdeab2825f275e
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-scmi.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <misc.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#include <asm/io.h>
+#include <asm/mach-imx/iomux-v3.h>
+#include <linux/bitops.h>
+
+#include "pinctrl-imx.h"
+
+#if defined(CONFIG_IMX93)
+#define DAISY_OFFSET	0x360
+#endif
+#if defined(CONFIG_IMX95)
+#define DAISY_OFFSET	0x408
+#endif
+
+/* SCMI pin control types */
+#define PINCTRL_TYPE_MUX        192
+#define PINCTRL_TYPE_CONFIG     193
+#define PINCTRL_TYPE_DAISY_ID   194
+#define PINCTRL_TYPE_DAISY_CFG  195
+#define PINCTRL_NUM_CFGS_SHIFT  2
+
+static int imx_pinconf_scmi_set(struct udevice *dev, u32 mux_ofs, u32 mux, u32 config_val,
+				u32 input_ofs, u32 input_val)
+{
+	int ret, num_cfgs = 0;
+
+	/* Call SCMI API to set the pin mux and configuration. */
+	struct scmi_pinctrl_config_set_out out;
+	struct scmi_pinctrl_config_set_in in = {
+		.identifier = mux_ofs / 4,
+		.function_id = 0xFFFFFFFF,
+		.attributes = 0,
+	};
+	if (mux_ofs != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_MUX;
+		in.configs[num_cfgs].val = mux;
+		num_cfgs++;
+	}
+	if (config_val != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_CONFIG;
+		in.configs[num_cfgs].val = config_val;
+		num_cfgs++;
+	}
+	if (input_ofs != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_ID;
+		in.configs[num_cfgs].val = (input_ofs - DAISY_OFFSET) / 4;
+		num_cfgs++;
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_CFG;
+		in.configs[num_cfgs].val = input_val;
+		num_cfgs++;
+	}
+	/* Update the number of configs sent in this call. */
+	in.attributes = num_cfgs << PINCTRL_NUM_CFGS_SHIFT;
+
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PINCTRL,
+					  SCMI_MSG_PINCTRL_CONFIG_SET, in, out);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret != 0 || out.status != 0)
+		dev_err(dev, "Failed to set PAD = %d, daisy = %d, scmi_err = %d, ret = %d\n", mux_ofs / 4, input_ofs / 4, out.status, ret);
+
+	return ret;
+}
+
+int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins)
+{
+	int mux_ofs, mux, config_val, input_reg, input_val;
+	int i, j = 0;
+	int ret;
+
+	/*
+	 * Refer to linux documentation for details:
+	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+	 */
+	for (i = 0; i < npins; i++) {
+		mux_ofs = pin_data[j++];
+		/* Skip config_reg */
+		j++;
+		input_reg = pin_data[j++];
+
+		mux = pin_data[j++];
+		input_val = pin_data[j++];
+		config_val = pin_data[j++];
+
+		if (config_val & IMX_PAD_SION)
+			mux |= IOMUXC_CONFIG_SION;
+
+		config_val &= ~IMX_PAD_SION;
+
+		ret = imx_pinconf_scmi_set(dev, mux_ofs, mux, config_val, input_reg, input_val);
+		if (ret && ret != -EPERM)
+			dev_err(dev, "Set pin %d, mux %d, val %d, error\n",
+				mux_ofs, mux, config_val);
+	}
+
+	return ret;
+}
+
+static struct imx_pinctrl_soc_info imx_pinctrl_scmi_soc_info __section(".data") = {
+	.flags = ZERO_OFFSET_VALID | IMX_USE_SCMI,
+};
+
+static int imx_scmi_pinctrl_probe(struct udevice *dev)
+{
+	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = devm_scmi_of_get_channel(dev);
+	if (ret) {
+		dev_err(dev, "get channel: %d\n", ret);
+		return ret;
+	}
+
+	debug("%s %p %s\n", __func__, priv, dev->name);
+	return imx_pinctrl_probe(dev, &imx_pinctrl_scmi_soc_info);
+}
+
+U_BOOT_DRIVER(scmi_pinctrl_imx) = {
+	.name = "scmi_pinctrl_imx",
+	.id = UCLASS_PINCTRL,
+	.probe = imx_scmi_pinctrl_probe,
+	.remove = imx_pinctrl_remove,
+	.priv_auto = sizeof(struct imx_pinctrl_priv),
+	.ops = &imx_pinctrl_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 33e0e18c30d4ae4ddaaa2cb3830c03cd7a559cc0..4beec43cb080b14a777cac1cb0f18ef53433596c 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -27,6 +27,7 @@ struct scmi_channel;
  * @clock_dev:		SCMI clock protocol device
  * @resetdom_dev:	SCMI reset domain protocol device
  * @voltagedom_dev:	SCMI voltage domain protocol device
+ * @pinctrl_dev:	SCMI pin control protocol device
  */
 struct scmi_agent_priv {
 	u32 version;
@@ -43,6 +44,7 @@ struct scmi_agent_priv {
 	struct udevice *clock_dev;
 	struct udevice *resetdom_dev;
 	struct udevice *voltagedom_dev;
+	struct udevice *pinctrl_dev;
 };
 
 static inline u32 scmi_version(struct udevice *dev)
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 7abb2a6f36ba53223bd9103fcc02f58506fbfc8d..2367467512a6b65253317e51bea71de396aa96f9 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -24,6 +24,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_SENSOR = 0x15,
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
+	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
 };
 
 enum scmi_status_code {
@@ -1005,4 +1006,37 @@ struct scmi_voltd_level_get_out {
 	s32 voltage_level;
 };
 
+/* SCMI Pinctrl Protocol */
+enum scmi_pinctrl_message_id {
+	SCMI_MSG_PINCTRL_CONFIG_SET = 0x6
+};
+
+struct scmi_pin_config {
+	u32 type;
+	u32 val;
+};
+
+/**
+ * struct scmi_pad_config_set_in - Message payload for PAD_CONFIG_SET command
+ * @identifier:	Identifier for the pin or group.
+ * @function_id:	Identifier for the function selected to be enabled for the
+ * 					selected pin or group. This field is set to 0xFFFFFFFF if no
+ * 					function should be enabled by the pin or group.
+ * @attributes:	Bits[31:11] Reserved, must be zero.
+ * 				Bit[10] Function valid.
+ * 				Bits[9:2] Number of configurations to set.
+ * 				Bits[1:0] Selector: Whether the identifier field refers to a pin or a group.
+ * @configs:	Array of configurations.
+ */
+struct scmi_pinctrl_config_set_in {
+	u32 identifier;
+	u32 function_id;
+	u32 attributes;
+	struct scmi_pin_config configs[4];
+};
+
+struct scmi_pinctrl_config_set_out {
+	s32 status;
+};
+
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.34.1

