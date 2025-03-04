Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF551C282D1
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 02:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAF9A80842;
	Tue,  4 Mar 2025 03:35:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="h63VLca0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A03338104B; Tue,  4 Mar 2025 03:35:40 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 571558059D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 03:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWteEidth+Pet52DGE77pfGQ2VLj9Jwc+qYhCX1AV4F3LGKo4GXl2oFlIeeGWH6BeHoC8261WVDdlHdsB7ZLnxw7cRHWRAaAP+tQYL36vg16WLtgU2J0AHtrthid0IazNqm1H650H1j4LHGIXzueOtcg8snQoUfhE+Mfd2CagnFJ7vl8o6cKLmewLe82/pn/KZfZ3ww3xzL09PcqPipbtiP4xvPMnZf5iTeXwKl7AIJsenjRydCBO209XlOVPIyjXuS29Fr7/I/D5HhSi8bC2lAPDrFtL/0PUq/dcQYTQ8eXwWIpH4ISnGw5J0Kz8ZMYiXljD/cLW/N4qrjSd1R8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDhFf/nyZR4oFUjkg0gYEnTsoruUJ3tdrKgpVRvFdPc=;
 b=LaxWryyZKXKolwN9iMdVVtOfwmj2fGrt0p/Rt+eDy6QyA3YSU3RK3howlBQ5z3ShFET5hhMwLebyn+8BnVicQRlgN8NiuFuYJ7jeO53D+ektQJcHOp6a+PlV7e4A5wXNLcDpVABGoUycKceNLnndFYIbrQCIdRU70TNrZVpV2Ctpy3TvCfh6CJJgwEeOtL8Ktkfo8sr3szZMEbxVccxtJrX9LgB00hsPFGdQbh2GlAZkO3hxI8XcesGM6yDChnK+57OlWnywI+HIakhQg5+0tyTCHGs5fJnbkNdhdaD5fg+wtNuyodaHoflz9gpNaqz1ga3C3ckltHM5WUjftikfkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDhFf/nyZR4oFUjkg0gYEnTsoruUJ3tdrKgpVRvFdPc=;
 b=h63VLca0bKAA1/KjxDypf3LuRFBlrPDQ5WWXUWuFZh0/iOJJ+2cJUVtTEvqHZIumpLDyDjXUPVQIEEgH4b/Uvjwp9L0VKMoeYGpITiJ4XnCBD3f+pGEexkWr0HRF7BJJq/V3buEn1/OzF1LutaQl7K1uEv3ptRhMIOU4NLHyfDwBFvDWN8ACtBfDyQuA6FVVizvRiEKSGitToPBtzU46rmZuUifug77es24xvLus7RLusQcdFMx6DBWjPwkWpsw4gnJGolAAU4lJQ3wLNSo6KumE+UdnNxffj6DmJQ4xhvWqmt6t5ifPmuS1gG98hzJ8WUYjP2cdWcTSdTikVujqNg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10550.eurprd04.prod.outlook.com (2603:10a6:10:586::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 02:35:35 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Tue, 4 Mar 2025
 02:35:35 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "sbabic@denx.de" <sbabic@denx.de>, 
 "festevam@gmail.com" <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "alpernebiyasak@gmail.com"
 <alpernebiyasak@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Peng Fan
 <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, Ye Li
 <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjFdIG1haWxib3g6IGFkZCBpLk1YIE1lc3NhZ2lu?=
 =?utf-8?Q?g_Unit_(MU)_driver?=
Thread-Topic: [PATCH v1] mailbox: add i.MX Messaging Unit (MU) driver
Thread-Index: AQHbi+/EHSBl4rFpxUeCNbOwfp0XDrNh12MAgABj8fA=
Date: Tue, 4 Mar 2025 02:35:35 +0000
Message-ID: <PAXPR04MB96445643235AE5C18C2D8824E2C82@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250303035231.2680198-1-alice.guo@oss.nxp.com>
 <3f5b9ee6-0def-43c6-a312-6248db8c588b@denx.de>
In-Reply-To: <3f5b9ee6-0def-43c6-a312-6248db8c588b@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DU4PR04MB10550:EE_
x-ms-office365-filtering-correlation-id: cb0ba4c3-1a75-4dd3-23d5-08dd5ac53e57
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?d3BtLzdBWFR4RWdpR3FtUnRBaFQ1RWJ6NVdXSFVWOUh0Tm5MVU82S3Vtc0V5?=
 =?utf-8?B?ZDd1T1daVkQ5Y2JmWFVlNnc0ay9CRUxIdlZ2c1pxNE9XYW8rUmUwOVZ0bmU1?=
 =?utf-8?B?UGNsc0pSYnBnQWljcEtCNVovRmNOZnVmVnJkWXRpK3FrN2xkcDVxWFc5NW1t?=
 =?utf-8?B?LzZkZGx0VkMrdGRKaE9sTGVQUnpaOVhPRk55cjVWZ3h2Ym9xT0x4WjVzT3N2?=
 =?utf-8?B?Y2hPaUc0M25DUnUwRDg4RXJYejRJY3RvY1ZzR2h0YVdTcnZ5TTVwcGMvaXJm?=
 =?utf-8?B?NDFGVlp5SlZNUm5qdll4Q0VKOHRRWU8wZURncXFqbFhYNTl5a0p0NC9jTWNN?=
 =?utf-8?B?WVJSdkV4djJNSTN3dmxieVJlT200Z3RFMEl0UDZSSVZaZkhxRWdMQ0tIVHVz?=
 =?utf-8?B?QU9yaEVFeERMbTRlTGVDblpxN2RsZER0NFR5NjczbExSU3pKaVZlMFd3STV2?=
 =?utf-8?B?QXA0TjcwNExLTUhXS1hVUjVtTlNIOHBKKy9lckhZQ2c2Nm10Yy84cFlha3ph?=
 =?utf-8?B?MEIzNDNJU01BUHdoN2w3ZGN6ZFhlRGtOeStvOFRya0pkanZnU1BWVzhTWUlN?=
 =?utf-8?B?Z29oWCtoaXZHZHltaWQ5T1VJVUUxd3RyUE94QWdBcThHOVJSU0N1MzFHQUZB?=
 =?utf-8?B?Mm5IWmdVcEJuZ2ttMDBKZko3SHJRMURnTVVFVVJYY1RHb1NKT2dyK1p1eVpU?=
 =?utf-8?B?NHB0ZHRvbHYyZnN4dFFuTFhHaDNFNHo5cUV3ZE1SMCtHdUdnWjRmWjRFdmo0?=
 =?utf-8?B?ajBuY1A0K0ZYR0NYN1p3R3M0Nm9YSWRCSDl5QXV0MVZzVG9JTllEdjVNYm5r?=
 =?utf-8?B?TStRMTVpd0VpejltUEcxWWhzUTJNeVMvUXFnM2tVWk0xbFJhZjREbC9tZlFt?=
 =?utf-8?B?ZkR4UUx1bTNWUDRlcjhpQm1BRmJtOFlGS2pudkJ2OGxXOE1sRUZjb1cwUU1i?=
 =?utf-8?B?QjNmTkJMZjlCUDJrRVBxd1RVSEpLR09HazY1TkxaR21VaUZQQnN1d0xqaGtV?=
 =?utf-8?B?WGlHYkNtRDVJWitJRlJZZjByQzR0YWV2SXpYSmdLUXdGYmFabWRwYlF2OHF5?=
 =?utf-8?B?ZTBrWlAvb0FQWDc5U0ZqY2JvRnRXMlo0eWJUaVpLenJjN21ZUXJRQldhYzlB?=
 =?utf-8?B?b0tMMEFXd0c2YWI3c3l0bGlhWXNIaWREb3ZBcGdLN0ZOaTRKK0ZncDVqSmJH?=
 =?utf-8?B?V1pxZzdYNDJuKzV6NXp5MzBrRVhJS2wrbTZNSWFKajErZWY1V3BCcXFXNHZi?=
 =?utf-8?B?ajBnVnlLSVREcUcrdUVGaUgyV091SXNzdVpZRzZTUnplSHRvTHdsS1N1Yjd0?=
 =?utf-8?B?V3duN0JVMENtMnVhczFmeWtlbmhsMDRjSHF2Nm9aanB6dS9LTDl5WnMzSWYr?=
 =?utf-8?B?THNwaXpDRlYxMFgrN1Y0cUc1U3ZVeE5UdzJqV3RKNEg0WHhXYmlzeVhUTERp?=
 =?utf-8?B?NHBSZDZjZlM0YzVyUFJRL04ya3Y2UldPYk1wOXZTdzRBTGFTZ1pHNDRudlNj?=
 =?utf-8?B?T1hRSmF3ZkxNaFdmSGRBbzBRSUdpRWdNMXVZbnYyZmxMd1ZIbjZ3QVRsTTdD?=
 =?utf-8?B?bTNTdDJPRGxlSWh0Z2NjbjEzejJZQ0pPeXcwSWRDb29BZERIMzFuVjk5Q0NV?=
 =?utf-8?B?TnRta2VpZCtLT0lKdWJwU0h3RVdPVVB4dWpvOEgvMmhyMWpPUUpoWXVFMDdU?=
 =?utf-8?B?SjFOait6SUNtdnVpWGpEUEFGcFhCMTJybXI1NGlRanpZbTVwL21hMk1PVERG?=
 =?utf-8?B?M3dsS2VjQkc3d1lKK0lxcHBSSnNNdlN4WjM0cGV5bUVaa1NtaG1vOXd3N0hT?=
 =?utf-8?B?SnJHWG1PeVRrV3R2VTd5Q2JpU04zOGJSR1FHWGp3VVloa0k5Mmk0ZlFYQUQv?=
 =?utf-8?B?cU52TmgyM3pOTEZsenIwazAvOUx6WDZNVC9mTDc1TFRLRXhGdmhOOWI1QjEr?=
 =?utf-8?B?TStRMjdFVHVKRnRNRmh0Y0tqd05IU1Z6WmFTbzc0dVlqZHRrS0hNNEt0QUVj?=
 =?utf-8?B?eVpuSUdQRTB3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG5ZYnF4STlyR0FZS3VrSzN2L0tPaSsrbGgzK2R5Y1lNRVhPM3FNUDZEano3?=
 =?utf-8?B?Q1QxTFgrQmRPNHN6MGhqd2dtV080aVF5dmNONXkvWWkzTTJrQUN3NkhON3c5?=
 =?utf-8?B?bStyMnhQZVJhSmNWYjNROVJZRloxMm5mU3JWemgrOFpjRGJHOUR2bG9kTk92?=
 =?utf-8?B?TlExdjl5YnhNcjA3RkhOWFNVWC9pRWdqUkp3K3U1MHJCYmpkUnhMdFdZVVZJ?=
 =?utf-8?B?SEVHRm9NOVR5Z0JYcGgyd0xXa3NnM0xVdEd5YXhzTzN3SkNvZ0U4Ky9FMnlT?=
 =?utf-8?B?SWRlSjQ2ZWdRaFlNM0oyYmRXVWs3UlRENFRLc1hvVXVub0tvM01HdUg1R09R?=
 =?utf-8?B?U3FoOEFGb1VZQVF1eUpZY0duRVdkQk5JQ2lVb2tFVEc3M1pvMU1XckFsaDRV?=
 =?utf-8?B?dU93eWZxZjdrRE51a0p0dmx5OE9iSzR3YU5mVUplenlpK2JRMldOREU2bmVM?=
 =?utf-8?B?T1N5ZWNkd2FNQWhwS0hQRVJwNXdRQ2lPTHBERjBGNUQxalN1SzN4d1JTMk1C?=
 =?utf-8?B?VkpJOU1uUVdpcDg2c1hRMXRlem03dGxoZmQwZGcrMUtLWnAxbk9OWUZpRStk?=
 =?utf-8?B?S2twWmVWbklnVGFOYUJOWXlHR29nWXludkJYTHNlMXI3T2l4S0U3OStQcGdD?=
 =?utf-8?B?ZVpleC9IcytQRVIyUjRDMXVKdThqeFl5RlJpWWhVakF4N0dwZEZvYlFpNnRi?=
 =?utf-8?B?akh3VVJ4eTVTMnhFckt0TlNpKzdaVllOUGxZeGc1MCttTGhwVkR3aWlTT2xy?=
 =?utf-8?B?cDlvR2kwQTk3TVIzUGZxVzVuMUZyc3F0SzJneDJMQlFHTHVGVmsrUitWVmRt?=
 =?utf-8?B?bnJtWW5rb2FYM3lGNU9yYzgwdzU3NktnQVVvMFQ0TUNzUVlRQkcxNVYrOTUv?=
 =?utf-8?B?a2o3YzZVbURFV2NLenRla0RLV2VOM25tMDFzT1BhbkQrcEk1ZkJaR2NKU2ll?=
 =?utf-8?B?UCtuZWV3THYzRjlXeWhGTWxjWkVpMmJadlVrUFZ2WXpGdVp5a1dUb2lOTGdM?=
 =?utf-8?B?RWVQeGg2QlJPYWJIRW1MOFNDT053YUtRMXlFdk80Y1RGeXlFVjhQV002ekZs?=
 =?utf-8?B?cTJOdU5pNnhUNkZGSVg2d0JHblB0ckdSMjlSMjZwQUhNektiZ3JQZHhUNnV4?=
 =?utf-8?B?NExDWmNrbWtWeWJ4ZDk0SEZYVGEwbWgrZ2s2aGp5NkpPZ1U3MEdoaFl6cmkx?=
 =?utf-8?B?Vy9WcUVEelhzOGhMMUxmaU1FZXJ3UkV2VisvQXBZeHFLZlN2dmJqTmx1Ykti?=
 =?utf-8?B?em5YYWIzaGppZkhFQTkwdEk0cGJCVG5Hak1WdTR6YllwK3VDUlZ6b3lYdEdS?=
 =?utf-8?B?bUpLWk9qcmdHb0VsaDNZYlVtY1BRdGVZTTJHMHNwTXdaQ1RYQkVIL0N3NzNk?=
 =?utf-8?B?bkt5eHBQR3ViUDQ0YWJ5TThzT3p2aWpaaWkxNXVWV2dCaVREZ3N0U2VSaCtX?=
 =?utf-8?B?Z3J2dlFTdUZZU2FhWjBsUlBVY3UzcU9qUzJGcE5SVUhTMHRPZDlyL3Jya09Q?=
 =?utf-8?B?RFFQNGdXZUtFcFlzRmZOMExVOC9hazFrcDFrSFE5RkJNQ1RTRmlSWEZUa3c3?=
 =?utf-8?B?SDJWYmRnTUp5QWVZUWJ1U2lMRlpybGwvTWpsUEZjNmM0SGxaZ0hYYTRXZm5y?=
 =?utf-8?B?MWZteWpKM2U0OE9VZ3o2Vk9FUEFLMjR5d0xNS0tNWC9lL2o0d2w2YUNCOHJx?=
 =?utf-8?B?bGdOd0U1SGV6a3ltcVVsTVEybjJ1b0J0T2tDUldiWGU2QVBrMkVOcXhKRUFR?=
 =?utf-8?B?SVlReUhHT2hNbzBYZG5RMmlPVkR0MG84VHk2a2RMcXE0U0EwT21xaUJOVHRN?=
 =?utf-8?B?dU1vdmlkRG5UZDlyQmNhcGErT2pVem9ONnFsaytXTlFNcFdzQ3dDSXFka0V4?=
 =?utf-8?B?TkRzWkFWQTJibndKRjlJalNJSzRnM0d1a0diRGtrc0dIcllodEtFWVJFWWhh?=
 =?utf-8?B?UHVFQUljam1CUHZKaEpDcGk0WDlYV1VsV1luOVhZdGNUV0NLM2RSTmg1elI0?=
 =?utf-8?B?QUp4bWxFYStlcCtIRG9RWkNqT1F0ZTVsS2c0eWVWWmNZMmg2SFNjdFNGU3Nk?=
 =?utf-8?B?TGg5WXZab3ZCbE5jSEZjTjY5akxpQnhGVlBBbENsZXhHVU5YRVpjUzN4cStw?=
 =?utf-8?Q?bZ8E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0ba4c3-1a75-4dd3-23d5-08dd5ac53e57
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 02:35:35.7092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20qMD6oabeTnGYb4qlzobfAAxHkV6UvenTfrm3Y052Bur/ImGHVsHtARED655H9whGsKHjukkilufVj5jht4XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10550
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDPmnIg05pelIDQ6MDYNCj4g5pS25Lu2
5Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IHRyaW5pQGtvbnN1
bGtvLmNvbTsNCj4gc2JhYmljQGRlbnguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtdWJvb3Qt
aW14IDx1Ym9vdC1pbXhAbnhwLmNvbT47DQo+IGx1a21hQGRlbnguZGU7IHNlYW5nYTJAZ21haWwu
Y29tOyBzamdAY2hyb21pdW0ub3JnOw0KPiBhbHBlcm5lYml5YXNha0BnbWFpbC5jb20NCj4g5oqE
6YCBOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBW
aW9yZWwgU3VtYW4NCj4gPHZpb3JlbC5zdW1hbkBueHAuY29tPjsgWWUgTGkgPHllLmxpQG54cC5j
b20+DQo+IOS4u+mimDogUmU6IFtQQVRDSCB2MV0gbWFpbGJveDogYWRkIGkuTVggTWVzc2FnaW5n
IFVuaXQgKE1VKSBkcml2ZXINCj4gDQo+IE9uIDMvMy8yNSA0OjUyIEFNLCBBbGljZSBHdW8gKE9T
Uykgd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgdWRldmlj
ZV9pZCBpZHNbXSA9IHsNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDZzeC1tdSIsIC5k
YXRhID0gKHVsb25nKSZpbXhfbXVfY2ZnX2lteDZzeCB9LA0KPiA+ICsJeyAuY29tcGF0aWJsZSA9
ICJmc2wsaW14N3VscC1tdSIsIC5kYXRhID0gKHVsb25nKSZpbXhfbXVfY2ZnX2lteDd1bHAgfSwN
Cj4gPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDh1bHAtbXUiLCAuZGF0YSA9ICh1bG9uZykm
aW14X211X2NmZ19pbXg4dWxwIH0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg5NS1t
dSIsIC5kYXRhID0gKHVsb25nKSZpbXhfbXVfY2ZnX2lteDk1IH0sDQo+IFdvdWxkbid0IGl0IGJl
IHVzZWZ1bCB0byBpbmNsdWRlIGFsc28gZnNsLGlteDk1LW11LWVsZSBhbmQgZnNsLGlteDk1LW11
LXYyeCBmb3INCj4gaU1YOTUgPyBFc3AuIHRoZSBFTEUgaXMgc29tZXRoaW5nIHdoaWNoIHN1cmVs
eSBpcyBwcmVzZW50IGR1ZSB0byB0aGUgQUhBQg0KPiBjb250YWluZXIsIHJpZ2h0ID8NCg0KVGhl
IGNvbXBhdGlibGUgIiBmc2wsaW14OHVscC1tdSIgdXNlZCBieSBpLk1YOFVMUCBNVSBpcyBpbmNv
cnJlY3QuIFdpbGwgbW9kaWZ5IGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNClRoZSBkcml2ZXIg
b2YgaS5NWDk1IEVMRSBNVSBpcyBpbiBkcml2ZXJzL21pc2MvaW14X2VsZS9lbGVfbXUuYy4NCg0K
Tm8gbmVlZCB0byBhZGQgdGhlIGRyaXZlciBmb3IgaS5NWDk1IE1VIFYyWCBpbiBVLUJvb3QuDQo=
