Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121C8E77198
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 02:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F25E8036B;
	Wed,  8 Jan 2025 03:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="bvSQEuKo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51033803DC; Wed,  8 Jan 2025 03:13:25 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 089708007D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 03:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BplPU2GaDvXm8OqWpweRtWAyXH5f2NtD/gA9/Nf7TkhEHpOEJ2c7jTsOL/h7u+CDGfu3iIIKSUsyGx2pBbuoMPXT0oJzznq9AgKKT/wCZo59DspkZk0rfRoG9yW3KBdxosanQ+IgKb8f/B8Po60lGtyjkB1C/Gcf8gF3D/rot9+cfaQMrvqFPEmc95hQk7iFl99J9HoNK7nXa+KXjtBIg2IsFeJ142xqevmRovgmRde5BMpSqMEP+pXL2AFp9an0+JtO7Aijkj+rr2MWwOPngHyO28bWoiaeOw0f8YUOnLD32VdNoSkLkUDJ8LVAY9D1OBfMZQE9NQZLIR6TPyYyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKPVbf6NGTyOSiPzbVwv0K2f5fGNOZRhgtZHUegxrIU=;
 b=bT3gTyMgNGlnE8wiuH1RUGBhyAz2G6piGSoAXoWjwKnUrMrhaiTipJfA/iEj+zs8db9IRUGQCFGJmFcmc8A157fxuJ338hJQPUouJzahNOr/XNk3vJUsEE/Pbt/zGTXokmOLo/6YDr6OcRN8JmiNGNIHV6YA3bycJZLBCCLSRz+8ncl0oM7IXABjLD+Db5FPH1NzRsM6zn/TT1NWfIQN3+5IhUWTI8p8XGYOWJHwjJayVrikipvkPVrQfv4OjDXD/Zo/Pdo9tow8HKpyR0MZK9wbRibHIJR3VyrL3byn+HOdlNCLZBNwTPiBLfvgmLjOk4ru+9irBwbMaDH9gC2FPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKPVbf6NGTyOSiPzbVwv0K2f5fGNOZRhgtZHUegxrIU=;
 b=bvSQEuKoGxbkYXeHxATTVNo2zYG30CbqUnCJpXP9VvSWdHEoEWcGLMp0m3mkO24aTsAN7NFROo1bRRSE0sPE8bxzDBRK82C9LwvkoT5z46zOS3bBlP7WN5n7nkwqPI1JTxFbhREZVL/o0UcdmWSLAh79TL0St3vQ8kPTfkjh8oZN/9PzDpTmtk/7rMJKpw4SHOldDcVGsKqcJ9ZkstNffP8fSLeaxDHv4tkMcezgiyKaLALjSYDrBJUMVHwieTDcUSUUqOo6CSFzS3aHFHo0mDpIw/bY3apJt2mRnZJqf/Jsxg1jsBuANvBXUqwVSqEpPRGBV5zMGdHHXvM50Rsr9w==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6918.eurprd04.prod.outlook.com (2603:10a6:20b:10c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 02:13:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 02:13:21 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v2 16/16] imx: imx93-11x11-evk: drop duplicated nodes
Thread-Topic: [PATCH v2 16/16] imx: imx93-11x11-evk: drop duplicated nodes
Thread-Index: AQHbYNG4SCrUOpexg0CIWwn3CLMLKLMLnLYAgACHIUA=
Date: Wed, 8 Jan 2025 02:13:21 +0000
Message-ID: <PAXPR04MB8459CEEBDA97F0CB554701DA88122@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
 <20250107-imx-bootstd-v2-16-97671b1694cd@nxp.com>
 <CAOMZO5CmznxHyaA7+8JDn-ZSbBi1jAX4DYU7w2R=a4j8mY7gEg@mail.gmail.com>
In-Reply-To: <CAOMZO5CmznxHyaA7+8JDn-ZSbBi1jAX4DYU7w2R=a4j8mY7gEg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM7PR04MB6918:EE_
x-ms-office365-filtering-correlation-id: 5bfc352a-a78b-4c18-4a2c-08dd2f8a062a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VC9RaVB4SUY3bkJVaWJIOVBMQzdOWHVWeEhXSEtXcGhjVDJYNWQ4QjVCUStT?=
 =?utf-8?B?TnAzbE1aVm5XdEdDaTl5TnkwSnEwQUlPem9tYzBEQjJiUklzVWYrdEZPQTc0?=
 =?utf-8?B?Yjh0YUllK3BTeFptaVJCNk1ObVRLNkpGSWd6V1lFV2VGeW91TkRuanpxcEtw?=
 =?utf-8?B?ZGU5cmYwVm53Mk1uc3hCWEdTOUZoY1pDRDJxS2NDajdmdjhaS3FZNGFOZHFG?=
 =?utf-8?B?TzFFR3pLMmVmeTFPMFNNZEcvdlJ0eTdsSFBKMTBURjNhdHY5anljK3RzMXlB?=
 =?utf-8?B?dXBLdkJzNmdMNjN4NkRkZDBzM28wd1FqeThJQnpGeEhIZFIwaHFZb2dFK2x6?=
 =?utf-8?B?Q1RMdm5YY05Yd2d3UmhWYXZwM1FEWDVTNDhqZHlYSmVobjV3TWlucU83N2Fs?=
 =?utf-8?B?Z1lOcktmbUdxZWFSSm1oOERkVU94WFNFZmRlb0hnenNSTWpHZ2tOeGRadXN3?=
 =?utf-8?B?Wmd1SSt0cmNWblpBL0JrVHRzTVgrZjlMbkdsSEtRc29nQVN6WXRFaktLejhh?=
 =?utf-8?B?NlFsWTl0aUhQd0VVekx0cnJhaXlSQ1hlcEtnMkNsMzZOM3Rpd0RRNDlObEV4?=
 =?utf-8?B?M1RCcVpHejFiS0tGM2ROcm82ZlQyd0RVaU1vSGp0Wk8wUUMwYitEbmRDTDRh?=
 =?utf-8?B?RUhCdWcxcDFaQWhLbFdidnV2aGRuSE81TkJSdnA3aUhiY3RudWZLanlnOHBW?=
 =?utf-8?B?WDZtUVJKNDlyNzlLZVI4aXJrU1I1dEwxbW1MNWpLWGx1U2doSFhySWpUeFNm?=
 =?utf-8?B?Z0VTNmV3N1ZMNWNXUXhvOTVXWDBSaFkzMnBMd3lZcHdPajZJL1dNNStlS2lF?=
 =?utf-8?B?bmFwaGhVR0dnMU92aHpxRTJ5dWpxUmxEMnNaVDFsOHl4SDZ1TWRPT0VPaWUz?=
 =?utf-8?B?QXhVbURNTFB4NkxweUxON1JkYnV4LzNUSzVlU3lPamsydjhmQU9uS0wzYWJH?=
 =?utf-8?B?VG8vQVJwcUREeUpJUGtpa1o0c1A2NDRLVWZqamMvcVgzZHdweU5uaUtPV3R4?=
 =?utf-8?B?Y2lTVzlLRnhuY0RSZFE1NWx0ZmRKM3dvTS96bFgrQ0VVNzA3c3hua0toTW9C?=
 =?utf-8?B?dzRFRkoxeHFYMHVJeklZeTBOL3o5SG9kOVRMT042WWh0TStqOFAxcGtlMGdl?=
 =?utf-8?B?V2dWbEgvMitrRktOSHB5S1ZsS1JpV0dtRmFzOElualNwSlhnbngyZ1EzdXIv?=
 =?utf-8?B?NXFiaWJyb1V0eG9FL1MrTnE3RCtrMnA4RG1vRHFocDBmcXNSbG1uTHBaa0tE?=
 =?utf-8?B?RklZQmF2MVpNU1A2QXhiR1Z5Q016c0w3Tjk4TEVjdWM4ZTJ4TU1pcXRpZExu?=
 =?utf-8?B?Q0FiQkhCdUFaWTlrOXZBVG5NYlhsekVkYVhhNzZpcFYyWjB2RTBKSzBpZEwr?=
 =?utf-8?B?dUVBdlhLL1hnYzI4SGw2dEtabzFkUDFIcGV3NFdDZkE0d1ZXdkpBZllUU01j?=
 =?utf-8?B?L3RISmhxbGpiKzBiSDF4Sktrc1N1SzJOVW0rT1VDcDNKdEZjZFBLUjN1RzUz?=
 =?utf-8?B?bk8wVlRvS3EwN3lRSGQ3UXdYUnc0M003YjUwbHFpS1h6VWZEL3paa2lpcUhP?=
 =?utf-8?B?WWE0dS8yTUlEQzZ0QWFUdHh5TGMwRHhHNFRhTjB0cUMyV0dCdUQ0SElJd285?=
 =?utf-8?B?MkM4NTB0MWJxR0g3S2htcnc2YWpDU0ROemFpSjB4dW1HWFlxOWhEZlJ3a3gw?=
 =?utf-8?B?bEtQSElIa3JRVUhMN3I5YzQzRTlHVWRYLzVFTWhUb2VkdVZrTW81NER6WVFY?=
 =?utf-8?B?RmF5bFgxUHo1YTRMeDFjUTFKWVU2eWk2cEtmZFJudUpyVE0zbXJMY0FCcW1B?=
 =?utf-8?B?M2FrK29reUxYNi9lK055L0NxcjRRaGxsTGJLTFhzS1JJZmtrYjdFZENpSEI2?=
 =?utf-8?B?ZHRQenFZQmo0RlEwMk1lQzhaa29wODlSWWxFTlUvbmt1YUY2d1BObEcrZTZT?=
 =?utf-8?Q?+MB8/vc18DqqDJpM6ju5olnkH3HBc4tL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFVzRjYzNi9hTEVBVWtNNUdtSW1RckxpOG45MFhkci96NE5yYTdIMjROYkgr?=
 =?utf-8?B?SHZXMXV3ODcwN0lIcXFOSjgzYlljSGEwNDVDTFlYa20wTmE0ZVJ5SjNIOTZs?=
 =?utf-8?B?Y3NlVm1YazA2bmRwKy91TGYrNUo5ZXA2NStOZ2xicUVERU4vUDhMV29LTE0z?=
 =?utf-8?B?eFBKM2pLck5rNTVpQThKemlzRkkvSzRDT3RFZkkwWm5SK2V2eWJIUmxPaFNT?=
 =?utf-8?B?SklqU1p1V0lIL1F6VVNGRk9zb0t0UHZsN1gxVVNNeS9CSHZwaENpRW5Ba0V3?=
 =?utf-8?B?ekFhZXlIYWp4SEdIVHhrQzBnWnYrY283WDJ5UW8yYSt5TytETUlxeW9ROXFT?=
 =?utf-8?B?cXdISnNZVDN1THlOcXJWTmd6M29aSTJ5Z1AvbzZsZDVFNUdYQ2R5SG1xVFQ4?=
 =?utf-8?B?MGNjeEJXL3E3QkptYkdFR1JUbUkzeThRUzZYaExzcGZITjhSdy9kVzlFSVdw?=
 =?utf-8?B?Q1A1MytwQWp6cDhCeFVGQS9YbzQwOEdobHA1S29hemRzUnRpTmVWZU1sK240?=
 =?utf-8?B?MEhWcXpqTUY2WjBiK0ZhVUFIOTFMekcrb3Z2MUQ1ZjFNSG1lZ3RZc1JubUJz?=
 =?utf-8?B?S01RdGE0WmJRNk5yUnVmRzdyTjBseXJpaWEzYWpLaUZOOENiN0dSaEdsb3kv?=
 =?utf-8?B?VkJJTkJKZG1oQzhBU3htYXg4SW9BRkZDYkd2Wkc1VjQxMVZ6ZWFaTUYybEh5?=
 =?utf-8?B?MlhKQXN6Uk91bWs2SCtoZk4xRXNvbWJNNlFXRmplTkVvRDQ1OTBGbXRWMjcr?=
 =?utf-8?B?YzNXZEhmMUNNbWJTVm0vVSsyWVQwZFcwY2FxdE90NnVDRjlKSzVhTHIxUWdp?=
 =?utf-8?B?T2RNZ2F2eE1JMEVOVlNSbG8ycUxaMS9iN3F4Y1dZVlh5L21YeFhkeGlnc3VW?=
 =?utf-8?B?QnQxWGRyWmJNSGVtZ2hVN3pTSk9acWVBMllBckE2cHI0a3pJL251SEhxYWVF?=
 =?utf-8?B?MWp4S1BaVktpWUt0cGh6dlFqcTBJZktERFJjWlRhTGdGSW9EUVhvZVVvb2du?=
 =?utf-8?B?QUhmL29UTU9laW43Ym9HaGFoWjJQRlUzVHZMVWdEdVZFSG9oYitieG1FNlBV?=
 =?utf-8?B?SWtJUGZrcHhpUmd6djdZSUk1YWovbWN1enc4WVNnOTduWHk2eWdUT2xzS2tx?=
 =?utf-8?B?V1BudjZmaVptQ0RWdnZNN2laRFNXcUhTTHhkc1BLNEQzWERkUXlZY2NYdGNC?=
 =?utf-8?B?RTVrT1FkakVoeEZTNFpsaTdoVXR2TEdWbG14b0xJb3dNdzFHYUxqVE90Tzc2?=
 =?utf-8?B?dDREYkpjN2N0R3hOclRPVm1oQnlaRjN1dW50eXVjUldtRnRtZEc1NzJzU3hz?=
 =?utf-8?B?TURhYXdIc25GZldJVDBzdmpLL1R2YTZtTGF1UDhBWnQ4UTU5akVmYWJ0M1FH?=
 =?utf-8?B?R3FWL0QrWUVXcFdmdFJYREg5eHFNd3R4MC80ME1DenVlNGJaZUE1dmN1Tldk?=
 =?utf-8?B?by80azVLNnNIZko1d2RrcGZIUE5wNHRjSXNEV081UUErNkNKM1JzSDNrWFMz?=
 =?utf-8?B?cUxjMFJkOUFZaWpNRWxGMUkrcFdoSlE5dUo1UkNjQVRYOGg4RzhWMEFpUDEr?=
 =?utf-8?B?dXVSWDhIVTczcUh0N2k5M1JHZWxCcTdDKzBvdllqazZIR1AxU0djTDRLRnAv?=
 =?utf-8?B?cTBpODhqQk1SRVlCNVhXMSs3N3BRQkFMdHY0cjVyZ290aUZMOSttSXJlVWZJ?=
 =?utf-8?B?UjhHSTgxQVdyYktCL1FEYVdZdXlkUHFQcjU3dlo5ekduVTFlSXBaamtIWkpj?=
 =?utf-8?B?WkhuUUZ4NmNPUmNZK1c0QVFRUXltWE1jVjAycUtTZHN4ekZJMklkWm5UQUcv?=
 =?utf-8?B?VG92dkwycFJ3bjNaRm9zNHFidFNKc1pLWWROb2JxZy9jL0JUZDM0bVJNMkQ0?=
 =?utf-8?B?eEs5QncyVXhkdnp1RUJBY0F1REM3N0twMU9DcW9zdUxDemY4UTBRS1BhaTJw?=
 =?utf-8?B?emFNb3JmZFlZQzV3TzRJTlNuMjRrTEpTNzJ2WTA2Zm9VUUtBN1pidklDTTla?=
 =?utf-8?B?U3JWTGJueVRVQk1ob0Myd1hpc3puZ0V0UWp0eDdkN3hCenpsMVVYNXovbXdX?=
 =?utf-8?B?d2N1b1I3QUZpOU9ZUEJNSk5pY1VqYzVJNlFOYkUyUzEwNmNkcjdYdHdLNFhm?=
 =?utf-8?Q?UIZc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfc352a-a78b-4c18-4a2c-08dd2f8a062a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 02:13:21.1850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QFeNsFKeheMYqCyEkYW+7xtfj5cBQ7cuPNqfCnHzvViz7R9P0FWzTfZ6iHoR2lnbtgauwr4wFiAN5vUDUDqUwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6918
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDE2LzE2XSBpbXg6IGlteDkzLTExeDExLWV2azogZHJv
cCBkdXBsaWNhdGVkDQo+IG5vZGVzDQo+IA0KPiBIaSBQZW5nLA0KPiANCj4gT24gVHVlLCBKYW4g
NywgMjAyNSBhdCAzOjU54oCvQU0gUGVuZyBGYW4gKE9TUykNCj4gPHBlbmcuZmFuQG9zcy5ueHAu
Y29tPiB3cm90ZToNCj4gDQo+ID4gLS0tIGEvZHJpdmVycy9ncGlvL2FkcDU1ODVfZ3Bpby5jDQo+
ID4gKysrIGIvZHJpdmVycy9ncGlvL2FkcDU1ODVfZ3Bpby5jDQo+ID4gQEAgLTIyNCw3ICsyMjQs
NyBAQCBzdGF0aWMgaW50IGFkcDU1ODVfcHJvYmUoc3RydWN0IHVkZXZpY2UNCj4gKmRldikgIH0N
Cj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHVkZXZpY2VfaWQgYWRwNTU4NV9pZHNbXSA9
IHsNCj4gPiAtICAgICAgIHsgLmNvbXBhdGlibGUgPSAiYWRwNTU4NSIgfSwNCj4gPiArICAgICAg
IHsgLmNvbXBhdGlibGUgPSAiYWRpLGFkcDU1ODUiIH0sDQo+IA0KPiBQbGVhc2UgZG9uJ3QgbWl4
IGR0cyB3aXRoIGRyaXZlciBjaGFuZ2VzLg0KPiANCj4gTWFrZSB0aGlzIGRyaXZlciBjaGFuZ2Ug
YSBzZXBhcmF0ZSBwYXRjaC4NCg0KQ291bGQgSSBqdXN0IHNlbmQgb3V0IHR3byBwYXRjaGVzIGZv
ciB0aGlzIGNoYW5nZSB3aXRob3V0DQpyZXNlbmRpbmcgdGhlIHdob2xlIHBhdGNoc2V0PyBPciB5
b3UgZXhwZWN0IG1lIHRvIHNlbmQgb3V0DQp2MyBmb3IgdGhpcyBwYXRjaHNldD8NCg0KVGhhbmtz
LA0KUGVuZy4NCg0K
