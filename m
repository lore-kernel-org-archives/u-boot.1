Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4029C88E42
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 02:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62AE783DFA;
	Mon, 26 Jan 2026 03:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VYEBGNqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D105C83E61; Mon, 26 Jan 2026 03:11:25 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D61E683CF5
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 03:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiFfmlZReM7/vk5pWmXpYO+sqkUTx8xqXsEf4xOd4O2KaFLWEutVi7N2YCZxkOTEUCjOUMVgT9xYYJ5TXXcC5sMu1aEI5ED2gkjpVBPBEv586Cpx8wtOH/3SndyXFmgvjQA7aSWSgnReHGYUO6H6WfF+afaGp5eVDIuyC9a3b2DL2p+UbFPKj/WtMzJXE0dcwUiGZhMhMkRcV878r7YCJ5gqP6jDCbWVrFx8baFUNEJ1BF1BCnnPJvtnP/BQ3Ff0/Rz6ya0vOWNpIAPzrO5o+zXymcur16ce/iDYuGYaVf8jMWrZRmbL9M9bGtYFHLBInZqcFMo8SNp5Yg8VmeEHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5O6lPWXsjWDHbb5KYHgQxhvjzR0jf4zydDFAaUgI6Y=;
 b=YHPVdoghmjHU93GMxBj+W0a/aj1vwbpNhomeIcC7Z8eaYsS9PSo6WyD8gOphBAYDsXiV42To4qsozFfhh+ZGUOJIS4mLGiOHhJ8PZdwAQOv+Inh4nypO/UhN9xcvGawTktu2UTz5MdLtAoiWKI7QoKpWc+kdVB5wrhBz07OFVj8uX8FVyMeQbewq4H3gBkBj4TSTnB8UrcmNXzPo9QF2IKveQgJENuf/Bmw+UItS9mWMEK4pW6U6jAhMCPGGmX3ZA/cfp9qeCXUJz5xDO4ozTduJI6dvD1e90/mmObtcxnwomz7icweTzwE4ZmAhF3y0dJF7ckXQyBx+QLKLber/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5O6lPWXsjWDHbb5KYHgQxhvjzR0jf4zydDFAaUgI6Y=;
 b=VYEBGNqzviYcELfVMD7Y49YeeZZKmIDbtDYW8AFiJyMYciTEMQBbEKSItkRD32qH0G/ZoMkfbmM4eU2t3h1QaiHzNvW/ukIJPOq7HbV+p9pQCEQvxcXYHV8HCdSsFpi90gn9Bu8qpSn3+b/jMF6ClgAerdrn4sRLmKjR8y0OgWlNAq8SDS/AWHeT4iTcuQvEqu3KwzzGs5JKEq0OyHy/aGuDzfuRVW3e7gtXouZXR33dITO59m7QQb7PTGlaSdxQabrNI3xqWiXt8iaL9QrqEXpBTN+w8BrKpZLAGXnZ2VuchwXKp28Yj+9epRyo3HhOooI/iZiF1sbuqY/w2dO+QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AS8PR04MB8328.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 02:11:23 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 02:11:23 +0000
Date: Mon, 26 Jan 2026 10:11:20 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Mateus Lima <mateuslima.ti@gmail.com>
Cc: alison.wang@nxp.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2] armv7: Add CPLD support via IFC to the ls1021a-iot
 board.
Message-ID: <aXbNSAUDjG83gKsq@shlinux89>
References: <20260113142303.441190-1-mateuslima.ti@gmail.com>
 <aXGZVQhGzIrtXY86@nxa18884-linux.ap.freescale.net>
 <CAP8WwTH5=Aqy+QLLRv9QGJ3RTbwyMXA88BsO4eJOB-WawHfHMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8WwTH5=Aqy+QLLRv9QGJ3RTbwyMXA88BsO4eJOB-WawHfHMg@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AS8PR04MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: 035a5d29-3a06-4e60-c1e4-08de5c8033ab
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0o0WDFTcUlld2o1RUlhd3JnYXJIamFmS280K0duNEpFUFRsQTVvU1ZJTTRl?=
 =?utf-8?B?a2wzMTF1eVNRM1RtaG1HNS9SMGkxNy9uclIxazJQZlRNYTdHeWFaVFVZNlFq?=
 =?utf-8?B?RCtFdWE5T1R1R1Fxd3RrWCttTUtsZWdseDBZWmFjODJ3VU9JZmR1dDJwVUFR?=
 =?utf-8?B?eCtoa2FMWk16SEk1OTdBN051R213M3VGcldpWlZjbUZKUk1VMGtJTkFiNnR6?=
 =?utf-8?B?bzlvKzFZSXNaL1RQNER1cHU0QnBUNXAxSC8xbTNCL0Y2Zm5SOE5Gdk8vWUJz?=
 =?utf-8?B?Q0d6cC93bEpSdzZFK3FCWWVuNnZ5MFY2Y2NVZGJnclpQMWlpQmtUZGoweVpn?=
 =?utf-8?B?SmRpUURrWjI4bFNEdEc0U1IvY3hsby9qUDRnMjlqNGpWR0FocjhLZU9tUCs3?=
 =?utf-8?B?ZFNOVDV2SHFKN2pabGZURGRPbGV3YUIxd3ZyaW9TSTBzOUdwNDlVQUdhTlFB?=
 =?utf-8?B?MCtTWldDQnlpTmpjc0xKa1pZRHR2aVBFVzZ3WXpRU2tmNk95QThPeFc5QnVT?=
 =?utf-8?B?YW41OFYySmVDelFMd0kyRVJHTWhlM1VzdVhMQXNEdnNITDRPK3JXL29UOWJJ?=
 =?utf-8?B?aHE1MWpWSFhGUHRjS3UrZHlNNFA5U1NqOW1HWVJjdmhzZWpRc1c0ZDdJWnU4?=
 =?utf-8?B?ellVTGlnZFpnbU9oYTV1RlZWU0JDUDE0VmoxRVBlYXdCaUpaS3pRZjZZOGNO?=
 =?utf-8?B?MHJpcFdmczRxNFF4ZExTS1pGLzFPS3p0RFkzTzN5MVhYeDQxL1BOckNkM3FZ?=
 =?utf-8?B?c0JmUkMrdXhqWHFscnJLaUFKdGw1TC9ZV1NTTzBJYi8ybGE2bFM4QmdnbTI4?=
 =?utf-8?B?dHFUSHg2MWRlWUpwRmlGQ1JlckpVazVPdStXenhQMGNtVG90c0IrMFVOYWxj?=
 =?utf-8?B?NlpuNXRabzVyRWQ4dkFHM09RN1hZOXp3VWJHM2FsOXpHbFZvVG8rajFYMGVk?=
 =?utf-8?B?TVVvU3ZJSHRQb21MMUFVdmtZNitEc3lqbGZCU2lpWHpqQU10c2hoVFhGRCtC?=
 =?utf-8?B?MnJRVjM3OGNxUUVROXRUYy82Ukp5dVdpT2E5bm5BQmEwZVNXclZNQXE2T2ZS?=
 =?utf-8?B?aWlVb0RRQXNXaWFhN0dYRlcrNyt3Qjc2WVlVWEplL3RKRzdFQy8vZGs1M3Ay?=
 =?utf-8?B?ZU5JdmIxYm0yUnVlQVJVVndlQ0tYMHh1TFNQSVA4enRPcTRDbjF5KzEzaDJF?=
 =?utf-8?B?Zm5tMnVQRkdIQWttTS9CMXFER3VreDZjNGRraXB2YkRBUUJNaDlKdmY1WFRQ?=
 =?utf-8?B?YnFwODYzY1REMXl1dTNVL1puRFJCWVR1aVJlRE1hc0dnaTdmeDVIbmErV3Bi?=
 =?utf-8?B?QWE2Qm5VeTJBcFhUUUlpeFcvUGpQQ0l3bjRtMXpwNGI0M2dnVjFsbHd4SDZz?=
 =?utf-8?B?aEl5SEZzbzdTTWVrcnJQRm9LM2p4YSttb0h6aGM1TGNZbmhRd0FCSWZLME9W?=
 =?utf-8?B?cC9GTXNhSVJ3NjB4SFh6YXlKMkpHSzEwWlFiZkw2ZzNCWGQ3QlJxKy8vR0dq?=
 =?utf-8?B?eHhpYTcxZm0vQWd4K1J4YmJtYXpHVjYydDhBZC9VN2JEbTRhWHVJcGsxMUFJ?=
 =?utf-8?B?TXp3L2k4UXg4dFd2Z1N6NmZVV3dyS3kvU1Y1RFF0cC9odTZIRWhLTzJPNWZD?=
 =?utf-8?B?dE04UlJZZXk2SXBnL2EzQjlpaGQrVkFRQXo5TmN1QitPTXhGa3BCNWR5SmJz?=
 =?utf-8?B?eWYzYTB1ZTY0cmRhZHVSTEsvUDVmUnBERVBodjR1STl5MlViQVZtQ1NlVWhs?=
 =?utf-8?B?NDFnTUsxM29nR2V4dnhMK3B1Qmk1MEZ5VktVNjFaYjRVRlNIQjJrRlYvQlRY?=
 =?utf-8?B?MXE5RGUrbHhRanllYTRLT0prWWtlOEVlanNWcjBOQVUveU5uUmhqTkpiSnJl?=
 =?utf-8?B?MGY1d3Fva2FncTNwVGwrVEJYVzE2aHJEMnU1Sm1uZWVTWmZ4WVE3YTQ2emVz?=
 =?utf-8?B?MWt4QWV6N3hZbXJZN0xOSVBQTnovZnBiY21lMExINkx5Y2h6aVJ0amhOL0FL?=
 =?utf-8?B?QjdQNHMwc2g3UExSNGM4QTZwalc2VkJBc0VuWkhDWWloRStKeWw3Rk9aK2Fz?=
 =?utf-8?B?Q2E2Rk5KVzZJWHhqQzRRU2lDZ2hXbVFNMVZpbGRlZU80a0V5cHNCOG1SeWJj?=
 =?utf-8?B?Nmc3NG9GTlBGemZVN0VXT3Z5RnMrc3hOejMwampaMnRxbE1IajBwVCt2Qk1O?=
 =?utf-8?Q?FqSU4FdXznq7VGb/ZMAGLNE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eCtTRzhKWWRlVFlVWlh3WER0WVdMS25pNDVxMTNyUS9Ma2lXcGdvdGZzRWxo?=
 =?utf-8?B?S3RhU2gvczFJeFZCTkVxVi83cjVQSmV5aVA2TmQzRnNIYklGNW1DNjcrQ0NH?=
 =?utf-8?B?RlBUdWYycDZyVDVJcDhmRGlhT3Z3Z2kxaS9uUHg3NkVWRnIyYzQybkF2TEV6?=
 =?utf-8?B?NVZoWXRMOFJMRU8vUC95MnNHVXhMMEMxTTBhNm5rYmErbWlLd2pFQThqUkd1?=
 =?utf-8?B?S0xnYlpKNnkyUWh1NURDV2JhYzNVM3FNd2ZJQnV6NGdSdUNaZUU0M0QrQktF?=
 =?utf-8?B?OTduK3djZW9xVFVoVW9nTVFaclE4ZW51R0Z4T1Q3NHZGUXBHRDFRWUloY1Vt?=
 =?utf-8?B?S0t1QUVLU2tWSEZkSXFSZm01ck9YL1ZWclE2NS9NT2NOUTdvd05qZmEvcXJs?=
 =?utf-8?B?OVdjY0gwY2N1OStzOC9KTS9rRU9iM0lqZ3A1QzNjZ0ZiNTk3Yi9XT2ptS2FE?=
 =?utf-8?B?bkVBSG1Kc3Z4SkFRS1R1QTE1RlFBN2hqUmNzRzN0N0pKdDBYLzBNU1pnWFNG?=
 =?utf-8?B?alRWVXZRSWZHSG1qcXBORGVVc2svUkdtb2ZFYk9ZWXg3bU5UTEI3dmlCSVJG?=
 =?utf-8?B?c1V4YkNod09qSTJwRHNsZTdLWHFlYVR4YVhSVW8zcURqK0pEYkVzQ0FISEdV?=
 =?utf-8?B?Y3BRbUwwb2VLekdGVEwwSHd5SExacFZvcFdhbWhyUGo3TTZ1WGYrSWVjYXNp?=
 =?utf-8?B?TnFDdDlhNW5ySGMvdUJQY2VJVExScFVHUWVuQ01xUkNZdEdjYk0wRCtMSlVL?=
 =?utf-8?B?U3NqRGtuYVpId3o2MVU0Wm1TUTJDTmZKelpKZ0VHRjZOMDNBa1dXekVtZldl?=
 =?utf-8?B?YzdldEFwWURSa3FmYkc4ZnFGaUpMR0V1ZVRpNUppSVhyYWRraHgxSHRkaU1Y?=
 =?utf-8?B?TGhUL256K1hoOTJVMURLN0V1NXV2dC80MzJDRU9KdjFIQXBtS1h4ZFpzVUFv?=
 =?utf-8?B?eXdHNFFIRzRNaTJoS01MWVdQZGM1QXBITXdqdEgxQVBVZ0NuOE5NL091Rnpy?=
 =?utf-8?B?TXEzWVludWoxTnk4RFpUVk9GWEc1ZytMdnV1WWFhR0NEK0d1ZWJoU1hVQ2tx?=
 =?utf-8?B?WFFOajcwdDlHbjVkRUJIWkZpTTIwVTM5UDJEM0x6YVV0cVBXWUtBS0hpcGJN?=
 =?utf-8?B?aVVpK2lBdi9wbVEvUC9NUUY1Zi8yZXBiTUhCcElHZ2lvaWdMeFNrL2hoaFEz?=
 =?utf-8?B?amRBUkJ0L0cyZXRrSUtoSEZ5Vk9iL1VGaXpMOEZKSEFYQkNGQmxJWGUwOVRo?=
 =?utf-8?B?NVJ5TFRiaXZma2xSaDBGVnlOWmdMZ0pVS09KTmdENVMvMHdhYVpNUDhsKzRX?=
 =?utf-8?B?K3dwdm9BclBIaEtHRElZNnZvRDRkU0pKTTlCa3ExYlRVcWFSMktOaXJtL1JX?=
 =?utf-8?B?QzhUWTBJQVhJcVdya2wvQXpDS0Rwd280TEt5UEVVNTVNLzdydGtyUlJtaWFj?=
 =?utf-8?B?Ynphc3pISDdXWTJjcXRRdlZxcTNPZmlTcG95b2c5RjZIamJ1R04yUFVENFFY?=
 =?utf-8?B?UDlsYWVKdm5Zbk4vUU1VNHhEL3dOMFVrcElCWTlQVFNpWUhVQ1RlSVhVTW9m?=
 =?utf-8?B?cDgyZTl6T1dXc2ZmMnV3VEdNZ1hPQTFHSTR3MFRiR3NUdUlUUk9MVW85VEgv?=
 =?utf-8?B?Q2QrcjBEYU5pNVBFM0NtaXNwOS9pUXJGaUpzeDl1NGFhRW1lSldsWmNhbXFs?=
 =?utf-8?B?TWlDZ2lPNXFQamVURXNpRGVMaDBLSWJVUmhJMG5WK0xCWWVZZnV0MzFheWRl?=
 =?utf-8?B?MURtWU5SUnQxZ2RZU0hSTHZ4dk1pZjRCejRiOE56WEk4cG9rTktFNUM3MWx5?=
 =?utf-8?B?allMSHIxMUVEbW9tbTR2RWsrZEVsd3ZOaTNrYmpVSDZORjY4MEREZC9lU0ty?=
 =?utf-8?B?dU0vNHN6em8wOHlVeHJqTzBDNXRNclgwRmZYT3JJbFFzUlM2dHJQWGpzQ2E0?=
 =?utf-8?B?Y3JqRzdWTnMzRDZzdWpZTG1BU0JJK2MrVk5wNHAvUDVaR05oTWZWN1NIS3Nr?=
 =?utf-8?B?MmVOMWZZaGdiZTcwdGk2RCs1MTgwTEZCSGpNRSs0MVRUVFdJdEFWNktRbHQv?=
 =?utf-8?B?NUtYaVpGbVFNcFZXM3hvYVNacW9LamhhR3EyVEZhelN2cjh0QnNyOUptNSt1?=
 =?utf-8?B?VnBZckNoQUdVNzN5endrR1Qra1k3Z0tkd2NMdThTbSt4ZC9WNktsZ0IySUNw?=
 =?utf-8?B?UHF1Vk4wd3ZCNEpLL0FiT09mYnhoM1kwb0VTby91T3lydU5IRW90bC9MQTNq?=
 =?utf-8?B?ckNoRDNJV2lRRHYzOWhzQ0VEdFdlYWpOZEEzOXNyK3N3bVZzdENMWXZNcStu?=
 =?utf-8?B?b1dUcjlERDhDQlBLZWVFdGZra0FxOHVBcFFKc0c5Sms3VG9WWmdkQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035a5d29-3a06-4e60-c1e4-08de5c8033ab
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 02:11:22.9203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEDYli1iEq87PkuEHH7OsGnmKqsEIPMSVcHzSv2W6gfp2ILrFz/yFC14zZdUMDTU18lR0nYGHYnYyfH9BYgJOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8328
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

On Thu, Jan 22, 2026 at 10:12:36AM -0300, Mateus Lima wrote:
>On Wed, Jan 21, 2026 at 11:13 PM Peng Fan <peng.fan@oss.nxp.com> wrote:
>
>> On Tue, Jan 13, 2026 at 11:23:01AM -0300, Mateus Lima Alves wrote:
>> >This patch adds CPLD support via IFC to the ls1021a-iot board.
>> >
>> >Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
>>
>> CI report build failure.
>>
>>   CC      drivers/video/hitachi-tx10d07vm0baa.o
>> In file included from drivers/misc/fsl_ifc.c:8:
>> include/fsl_ifc.h:16:10: fatal error: asm/ppc.h: No such file or directory
>>    16 | #include <asm/ppc.h>
>>       |          ^~~~~~~~~~~
>> compilation terminated.
>> make[3]: *** [scripts/Makefile.build:271: drivers/misc/fsl_ifc.o] Error 1
>> make[2]: *** [scripts/Makefile.build:492: drivers/misc] Error 2
>> make[2]: *** Waiting for unfinished jobs....
>>   CC      drivers/rtc/ht1380.o
>>   CC      drivers/video/hitachi_tx18d42vm_lcd.o
>>   CC      drivers/rtc/i2c_rtc_emul.o
>>
>> make[1]: *** [Makefile:2191: drivers] Error 2
>> make: *** [Makefile:362: __build_one_by_one] Error 2
>> Cleaning up project directory and file based variables
>>
>> Regards
>> Peng
>>
>Hi Peng,
>
>Thank you for the test, and apologies for not having validated the patch on
>other targets.
>In fact, this driver was not being used by any target (neither ARM nor PPC)
>and after this patch it became enabled again. However, PPC targets fail
>when trying to include the asm/ppc.h header, which is not available for
>some reason.
>
>For now, I am thinking of submitting a v3 of the patch adding an explicit
>dependency on ARM, something like:
>
>+ depends on ARM
>
>This way we would avoid building the driver for PPC targets.
>What do you think about this approach?

It should be ok.

Thanks,
Peng

>
>Thanks again for the report and the feedback.
>
>BR,
>Mateus
