Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631F1C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 03:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 950C08875C;
	Mon, 29 Jul 2024 05:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="JNBIJPjG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B9F08878A; Mon, 29 Jul 2024 05:41:17 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FBC088602
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 05:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRKkpyTSlB//Yh047VEmvbFoLAiSEk0w7xiJB6h0mwHctZ7zJPf4QVQHPfjsho/9+ekpIpW6xyPSmYLBa//s5lM+XPwyMF2x2UxlPmTWR6PSQQ+x3lvVsbK1e9rPefBs5lYf7yOKlcU021Qs8OcST4kKAU4V68KYTckTykjlnmdw19gagqPKBIU3BxTjpka8yQj6wyCzW1WjIqfyyZTxOwUJD+6jEI9uNZOI1pNfJLhss8mCEenMMVJbJYcP4hTfwQUhExvGYt5b86PSc2Tn41bEjeHZdlzCSNhh6JVQnqKDHK8imylMk2+pmXUwuijD9F2nvV0dESQEjibgVsDVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPOmsJNq8FGibUWROzthWM6Ny7eNeJ8qekzoJJI302Q=;
 b=aDWKIua+4jADYDy77tw7htC/YVC5jb8LoTb6cEWfB/uvcYQ4sD+TdzJQtn0ZnA6ptO0qN01uBJh/sH9o0/PDKmGZsVIgtAwVBlDE/AnQoR7res3VEtYGxgWfnBGqgtlOyy3+aLz/glIBKV/SSdDfq5xWxJj34zPbQmp1xBrlUxXKTH16sof+mFy8T6vps+NHYWOhMDYkwGVCVOmTOKuSXdyOcQDsuLhVsLEb8cwT9f8ho/RM8TAx9Qa1Gi1v1Vy9lOVpAQz0X0ApFBCwsSBtf4+Ft8DdmrVV0RlpTOE4CE54JhjYWr7g4M4x2blz4lT6yOYpSw/cwDJGcP2yWj31hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPOmsJNq8FGibUWROzthWM6Ny7eNeJ8qekzoJJI302Q=;
 b=JNBIJPjGNt0ASD+SDQjm5NV6NOmQPwk4VTHaINPDgV8TD4a0sXqtZb1KTeudXceUqw6qUvpodt6CuDNI7rjfWU+a1oMpIuuo3tjsTLi1SnbAieKtT139nmZhdsqjHPUYKpx0oJaXjhxml1oYYqKG6TF+IBttieUqz7mrLsLiLMIKwj1o5SskDJ96173z4w2pVQaGfmFOHPIZElpCFJO5O2p8PYvkvo4Xc2wLkzFCD7fp88HIT8ElOfODfRx0jqJJnE4u2Xw4LWeguBHOE1jYF4+/o0Uv+yGx2qfIXVtqOJgU/Or9jtsZNOTVx2ZoIY79SNmQIb5Y8rNf6dM+2jPffg==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by AS1PR04MB9683.eurprd04.prod.outlook.com (2603:10a6:20b:473::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.25; Mon, 29 Jul
 2024 03:41:13 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 03:41:13 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, "festevam@gmail.com"
 <festevam@gmail.com>
Subject: RE: [PATCHv3 09/12] doc: cmd: add documentation for cpu command
Thread-Topic: [PATCHv3 09/12] doc: cmd: add documentation for cpu command
Thread-Index: AQHa34GFblzIfNAQB0SjCac+YuHMi7IMi72AgACAOBA=
Date: Mon, 29 Jul 2024 03:41:13 +0000
Message-ID: <DB9PR04MB92365CED39F1886FDA2AA10E84B72@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240726175108.34704-1-Zhiqiang.Hou@nxp.com>
 <20240726175108.34704-10-Zhiqiang.Hou@nxp.com>
 <CAFLszTiofnEZQEYJwjhsqGx0C7poHtuczcCfkZYsqDeHFnhd_Q@mail.gmail.com>
In-Reply-To: <CAFLszTiofnEZQEYJwjhsqGx0C7poHtuczcCfkZYsqDeHFnhd_Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|AS1PR04MB9683:EE_
x-ms-office365-filtering-correlation-id: 65d40c11-09c9-441a-3b67-08dcaf804b58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bFI0emk3dk0zamRSbFkxWU5GNUdqdzc3anljNlR2ZkV6bmxKTTA1b1JiejFJ?=
 =?utf-8?B?ai9BQTFiR04wd05zTUErZjBXT3h1akhYQllXN29aQ1UycVROYmJGSkpzVzhJ?=
 =?utf-8?B?aFBVWmc2Q2NyQVdvQ0N0Zmd4ZXpQZm5uVG5kejVsQjlvTFUxdUNuZjFUWTdI?=
 =?utf-8?B?K3BHbEpPeHNWM2t0Q3BKNmhnRTE1aWhpZmVIR0l2NnNYVWZmSUh3Wmw4eThy?=
 =?utf-8?B?bk1wYktZNU1kcGtJR0RXVzgzRG5Jc2V3VktFZVk3a1RjQUtIUW5NTFR2WWpN?=
 =?utf-8?B?NmNYdmpFZzRKS1JhZnB2UU9QazhlM3RlZXY1MExwMWJHUzRDcTFrMk5MSFRE?=
 =?utf-8?B?eXNTendoR2tzcUtRODFyTWlUTmxyckNvTUROZi9CL1BFY2g3bHI0K2Yzd2VY?=
 =?utf-8?B?OUcxV25PZXFWVUJzeXpsSDR1YW4xNzBNNzlXSFo5azk2UEJ6RlI2NU9NK04r?=
 =?utf-8?B?blVyTWtpN2pBS1NGc3NxYm5ycGdST3Z5aWwvSnBESGw0dEFSanZhT0hxdVo3?=
 =?utf-8?B?TEtsbys2dUl1UFRleDZQeThjV01JNUNmS2hwUkRJcUlHbVpCVGcvZ2tGWjFK?=
 =?utf-8?B?ZVg0TE1MZ1AvOVdwQUNzQkVDOEppR1ROYmFOdDd3TGtlRHI0U1FtTGg4aFJU?=
 =?utf-8?B?OVRUZHNMY2ZndjhodFVGcWFrQkNSclpKSVk3NTdiY2xYNE44MDlzM3lkZ0dN?=
 =?utf-8?B?ZXBxWTJvNVBYSkVQMnpXNENBdUFpR3N6M3ZhSmRwL0pKQ1VyL2dxR2pKUWo1?=
 =?utf-8?B?R0hWd2R3QWs5cU9WTU53cnprTHFFT0RHWFkxUy82VDhkUGVYTDJ3a01Za29p?=
 =?utf-8?B?MkVCUXhaTGxVbGhEb3o0MUVvRnpTanVyWWVZamtoQ2wySVVaM1A4QjZZcXd6?=
 =?utf-8?B?djhWd2Nld0NWQnoxclJBMDVoUk5SQWR1Ym43NVVXNWxPN2NsR0M4ZVJVVS9R?=
 =?utf-8?B?Snl6N2VSa0YvTm92bGl6M3pueDRZNERnaWFuRXptUldWSW1MdFIvVXNjQWRr?=
 =?utf-8?B?a0lVR2dESlFJa05tOFE5a0d4UnNzbjhMYUNnb0RPMVB2bTZCbFBWelZ5Qjls?=
 =?utf-8?B?RGVBRmlhRk94UE5rTldsUlAxS3RKWk14RytZcmtCby9OdjExUkgrMVZpZzFp?=
 =?utf-8?B?Vnp6NXRZRmNTRDJoZFlYZGh0bVBmWmM0cG9pR3VMQm9ndmFiZ1ZIMmpZcmp2?=
 =?utf-8?B?NWp1V3I5WnVOVDEwY3B2MFRpUFo1MzdkZkNZMFUyaEprQVdLRk54S0l2QVVk?=
 =?utf-8?B?SG00RTh6aktrcXNNRWxtVHZ6YmFTUUtuY3E4YXNKN1NwaExieGZyM3d0dDhz?=
 =?utf-8?B?TElhTFRTaUxoZUpKNmZINVNyQmx2NTlsenVQRThPY1BJNlN4ZCsxdDNGdDNV?=
 =?utf-8?B?WXhKVnliREN4dlh0azg4VVpuREFObXhhYVhxL0hnSWUxUFFoOHJuSkoyM2Mw?=
 =?utf-8?B?OWpWbGtFc0VlOXU2MGc2R2VER00yWFhxNHI0NldySFJTbTZsaWtKNy9JdHdh?=
 =?utf-8?B?TW1ZNHR4MEVKc3JpT3NxYVhGUld3M2RTUzUwaFNMMnc3TWJMNDRLOW1nZGNV?=
 =?utf-8?B?NGVCanZBeHJxRzlOaHlTMFJZREwvcEhFK0dvbXprTnJTb0hEQTFGZ0Y4dksy?=
 =?utf-8?B?aUxoSlg4dUN6NzRQY3RHc0VoWGc2aVZPWHhKMEFiR29QSERxelNjODNaL1FR?=
 =?utf-8?B?N3M1eUdzSE5vV0c1RXZpZ08rOFJUYTJHK3ByNllHUVlzZjRSNzc4Q1dSTGs0?=
 =?utf-8?B?UHlqZS8yZjR4UEVxNnlRRFkrU1lIQ24rSUpjbnRiYllrOExESGpBRmdpcS82?=
 =?utf-8?B?d25IcHQ2aHZsenkraXlmSGZUQ05xU2c2QVlaOGk5ODI3Z2hkNDlERVNjeXJv?=
 =?utf-8?B?enIybDFRMnRMVkVON3pRSC9mMHZXWmhyWE9ON1hOSnZpZGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dis1NFRsekpUZ1lPZm1NbzdZdlBrdzI4d2wxeVluNHVpQi9rR1J6dVBma3pN?=
 =?utf-8?B?dWNVN1c2Yk9Sa3E2RUlSTXNFL3ZydlhFTG5lQktoWFA3TW1aNnBWZHIzRVQw?=
 =?utf-8?B?S212TTZwOXYxb1RadHFaRjc0d29tK0drVHVRWGNROEl2SlZyb1BzZjVNWFpQ?=
 =?utf-8?B?VlFjS29USlNjby9YQjJlOGh1TzA2YlJwL1lYWmRWQ2lKdXowemhCdHVST0l5?=
 =?utf-8?B?bXlHaXo5WEgrM3ZqbXRjUGx6Q1NOM0h2aHJFcFhSTjhQcGViRyt3RnpXYlZq?=
 =?utf-8?B?aXdkWFBUMk5KeW1PMFFoWGxiNzJjMldWTmc1ZFhKc0ZSUDdXQjU4UGVPUUVz?=
 =?utf-8?B?WVE1VW5nNmk2MXJ1R2hmQ0hEN0F6QXlvWUZvUWM5TklrZnpVYTdoY3gvQVJV?=
 =?utf-8?B?bDVLbjdCQ2ZqQWxOalpSUEtBSTROWTB4S1lOVWNWWmJyUlo3ek43WTlWcjll?=
 =?utf-8?B?SDI1WHJMZnk1QmdXdE03Umk3anJPNVMzMHhWRzJxbUdXcnJSbXRLQ1dwT0M1?=
 =?utf-8?B?dk9QcGxUZ1pBS0tjYlBUcDJodHRxOUhxc2dTMU9sdFlBbTJGQVk4eE1sYkhO?=
 =?utf-8?B?eDdiWVlzbjZsZUNvVWhxVmhUdVl1WWVzMGV2S3dxWTZpdEJ2dUhZeTdlWE9l?=
 =?utf-8?B?RzltK3lwTFJrNVE4V015QlNNWHZIc3ZSVzNNRHJYY2FrWmk1SnZnYmphSUIx?=
 =?utf-8?B?a3hYbC9zdDZ6SmFNQ01NUTN4QTJRVXdFVFVTWkQzV0JXbmhzTVI1VnRiMjYx?=
 =?utf-8?B?SWZZUlBTeXkvaGRSMnhCdEFvTVhxSVp2L1RXR21DTzNqb0JHMjhHTE1nNzdO?=
 =?utf-8?B?bmlwMHBQelZBRFRLRSs4L3dRYjV1cFp5c04yK0gvc3FrOUxiZDRzd3ZsMGZM?=
 =?utf-8?B?bEJHT25SZU5IZlZ6S3BQdTF3ekZ1Vk5ESDZxRTZXSjhIcit5VzNHK3hDOVhj?=
 =?utf-8?B?a043WG04UFE0enpBUkJvWFFFSDZiWThLVXZKSmNhZlBDTkVtUnFRcXZGbE9s?=
 =?utf-8?B?NUJWKzhiZEhWRUdvSWRScHJBOWVUVk9aNWVpR3gxTEgySUVDVUxGajA1K3Y1?=
 =?utf-8?B?dGI4ejhoa2tKQ2VBUldnaWVMZkVobVZtbmNvZjZRYWtlbzVBRi8wdEdxYU93?=
 =?utf-8?B?WlFmdUx5anVpdlVjODhIR0V3RitYUjkyMzFYTzBTZk11Z0tzOWh4ekp0VHl0?=
 =?utf-8?B?QlVmaVZQdVR6YjJ2elVPMXVaU3ZXbm9FeHc0NjBTYmNIRWNJMjdWcmVxYStM?=
 =?utf-8?B?aTFiSjhncmxrOUxZNlRsSGVJV3ErUnpidUptcmpxWUg5TFMvRmY4K0VmMmx4?=
 =?utf-8?B?REM1bTRkOEcxZTNzT0RTalRKQVpWQVFlSFZGTm81SmROMXIwSXF2dndVZUoz?=
 =?utf-8?B?YkIwOFQyN0NwaXBIQVhFSS90TjY2N2c2VHo2UWhOT0E4OEtxakJMWkdSaVBQ?=
 =?utf-8?B?c0ZRVkVnN3Jkd0NxL1Fxa2MvRE9sVWJhWW0xUDZzRmU1bWxNWWw5MVBHOGY0?=
 =?utf-8?B?SmJoWTN0c1VTYUUxOTNmbUJlb3k3dThDMUZ1TllhMG5HdU5UVHhydU5CZmlS?=
 =?utf-8?B?N1NNUjBoS1hKbHNJWEp0bVRBMmpvY2M2RXBUdnd2UWYyMkxuZFVhVUpVb29z?=
 =?utf-8?B?VURiNVAxVE05Yisrc0g2QTJvU01vVnhWWE9uZHZ3VG1nVUYxQm1BeEN1VTh3?=
 =?utf-8?B?bXg2RUhuQ2Yxa3RWdlNNejl5Vzg2ZStlenE3ZEhVMFFiVlhtMTcvZCt2ZkxM?=
 =?utf-8?B?UUxiYTZ5eVhkNmpTRDVJd0wzeWdlVHNJU0pINCt0c2ZvUGFBcUh0TURtQllT?=
 =?utf-8?B?OWFoTmNUQWswamhiNnJTSmt1dzc1em9nMHdmMVZiSE9hb3BFR0UvL09ublFr?=
 =?utf-8?B?SHZZS3pUTmdQdjhoT2dLdkNOWnhSZVJqRWNmaldFT0VxeFpFcWh2a2V0anpE?=
 =?utf-8?B?bWx2OFluTVNTbnZRMUhwb1hYRUZyNjRucXA5V2NOdWVVK3k0NXMzMTN3NnVw?=
 =?utf-8?B?bUwxdmNnS2xYUDh1aHh2bGxiNmhhQkJJbXdMaWd0Yys1eXRtdWx4QlB5Nm1t?=
 =?utf-8?B?dmV6akZJUGp3cVhmaTVNWFhEVXp6ZnZKQURPMnNmVHg4Tm1xQnB4S2pZbzlC?=
 =?utf-8?Q?AYbwQ/9edx2iUjxZmm+y2kqQ6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d40c11-09c9-441a-3b67-08dcaf804b58
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 03:41:13.4354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: we9MmPpNNJfmeSzPGb61iiKERDXFHkj1zFXU1Ve8qI/IBTSov8wxr6ucotJdLJ4DXo5wy5Fx/mdVzNMVDMjQoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9683
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

SGkgU2ltb24sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24g
R2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgSnVseSAyOSwgMjAyNCAz
OjM2IEFNDQo+IFRvOiBaLlEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+OyBIZWlucmljaCBT
Y2h1Y2hhcmR0DQo+IDx4eXByb24uZ2xwa0BnbXguZGU+DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVu
eC5kZTsgdHJpbmlAa29uc3Vsa28uY29tOyBQZW5nIEZhbg0KPiA8cGVuZy5mYW5AbnhwLmNvbT47
IGZlc3RldmFtQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjMgMDkvMTJdIGRvYzog
Y21kOiBhZGQgZG9jdW1lbnRhdGlvbiBmb3IgY3B1IGNvbW1hbmQNCj4gDQo+ICtIZWlucmljaCBT
Y2h1Y2hhcmR0IGZvciByZXZpZXcgdG9vDQo+IA0KPiBIaSBaaGlxaWFuZywNCj4gDQo+IE9uIEZy
aSwgMjYgSnVsIDIwMjQgYXQgMTE6MzAsIFpoaXFpYW5nIEhvdSA8WmhpcWlhbmcuSG91QG54cC5j
b20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhw
LmNvbT4NCj4gPg0KPiA+IEFkZCBkb2N1bWVudGF0aW9uIGZvciB0aGUgJ2NwdScgY29tbWFuZCwg
dGFraW5nIE5YUCBpLk1YIDhNIFBsdXMgYXMgYQ0KPiA+IGV4YW1wbGUuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+IC0tLQ0K
PiA+IFYzOg0KPiA+ICAtIE5ldyBwYXRjaC4NCj4gPg0KPiA+ICBkb2MvdXNhZ2UvY21kL2NwdS5y
c3QgfCA4Mg0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDgyIGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRvYy91c2FnZS9jbWQvY3B1LnJzdA0KPiA+DQo+IA0KPiBJIHRoaW5rIHlvdSBoYXZl
IGxlZnQgYmVoaW5kIHRoZSByZXZpZXcgdGFncyBJIHNlbnQgb24gdGhlIHByZXZpb3VzIHZlcnNp
b24uIFlvdQ0KPiBzaG91bGQgcGljayB0aG9zZSB1cCBmb3IgdGhlIG5leHQgdmVyc2lvbiAoJ3Bh
dG1hbiBzdGF0dXMnIGNhbiBkbyBpdCBmb3IgeW91KS4NCg0KV2lsbCBhZGQgaW4gdjQuDQoNCj4g
DQo+ID4gZGlmZiAtLWdpdCBhL2RvYy91c2FnZS9jbWQvY3B1LnJzdCBiL2RvYy91c2FnZS9jbWQv
Y3B1LnJzdCBuZXcgZmlsZQ0KPiA+IG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAwMDAwLi4wOTcw
ZTU3ZDViNQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kb2MvdXNhZ2UvY21kL2NwdS5y
c3QNCj4gPiBAQCAtMCwwICsxLDgyIEBADQo+ID4gKy4uIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wKw0KPiA+ICsuLiBDb3B5cmlnaHQgMjAyNCBOWFANCj4gPiArDQo+ID4gKy4uIGlu
ZGV4OjoNCj4gPiArICAgc2luZ2xlOiBjcHUgKGNvbW1hbmQpDQo+ID4gKw0KPiA+ICtjcHUgY29t
bWFuZA0KPiA+ICs9PT09PT09PT09PQ0KPiA+ICsNCj4gPiArU3lub3BzaXMNCj4gPiArLS0tLS0t
LS0NCj4gPiArDQo+ID4gKzo6DQo+ID4gKw0KPiA+ICsgICAgY3B1IGxpc3QNCj4gPiArICAgIGNw
dSBkZXRhaWwNCj4gPiArICAgIGNwdSByZWxlYXNlIDxjb3JlIElEPiA8YWRkcj4NCj4gPiArDQo+
ID4gK0Rlc2NyaXB0aW9uDQo+ID4gKy0tLS0tLS0tLS0tDQo+ID4gKw0KPiA+ICtUaGUgKmNwdSog
Y29tbWFuZCBwcmludHMgaW5mb3JtYXRpb24gYWJvdXQgdGhlIENQVXMsIGFuZCByZWxlYXNlIGEN
Cj4gPiArQ1BVIGNvcmUgdG8gYSBnaXZlbiBhZGRyZXNzIHRvIHJ1biBhcHBsaWNhdGlvbnMuDQo+
ID4gKw0KPiA+ICtFeGFtcGxlDQo+ID4gKy0tLS0tLS0NCj4gDQo+IFdlIG5vcm1hbGx5IHB1dCB0
aGUgZXhhbXBsZXMgYXQgdGhlIGJvdHRvbSwgYWZ0ZXIgYWxsIHN1YmNvbW1hbmRzIGhhdmUNCj4g
YmVlbiBleHBsYWluZWQuDQoNCldpbGwgYWRkIGJyaWVmIGRlc2NyaXB0aW9uIGZvciBlYWNoIHN1
YmNvbW1hbmQuDQoNCj4gDQo+ID4gKw0KPiA+ICtjcHUgbGlzdA0KPiA+ICt+fn5+fn5+fg0KPiA+
ICtMaXN0IGFuZCBwcmludCBicmllZiBpbmZvcm1hdGlvbiBvZiBhbGwgdGhlIENQVSBjb3JlcyBP
biBpLk1YOE0gUGx1cyBFVks6DQo+ID4gKzo6DQo+ID4gKw0KPiA+ICsgICAgdS1ib290PT4gY3B1
IGxpc3QNCj4gPiArICAgICAgMDogY3B1QDAgICAgICBOWFAgaS5NWDhNUCBSZXYxLjEgQTUzIGF0
IDEyMDAgTUh6IGF0IDMxQw0KPiA+ICsNCj4gDQo+IEFyZSB0aGVyZSBibGFuayBsaW5lcyBoZXJl
PyBJdCBzZWVtcyBsaWtlIHRoZXJlIHNob3VsZCBub3QgYmU/DQoNClllcywgY29waWVkIGZyb20g
dGhlIHRlc3QgbG9ncy4NCg0KPiANCj4gPiArICAgICAgMTogY3B1QDEgICAgICBOWFAgaS5NWDhN
UCBSZXYxLjEgQTUzIGF0IDEyMDAgTUh6IGF0IDMwQw0KPiA+ICsNCj4gPiArICAgICAgMjogY3B1
QDIgICAgICBOWFAgaS5NWDhNUCBSZXYxLjEgQTUzIGF0IDEyMDAgTUh6IGF0IDMxQw0KPiA+ICsN
Cj4gPiArICAgICAgMzogY3B1QDMgICAgICBOWFAgaS5NWDhNUCBSZXYxLjEgQTUzIGF0IDEyMDAg
TUh6IGF0IDMxQw0KPiA+ICsNCj4gPiArY3B1IGRldGFpbA0KPiA+ICt+fn5+fn5+fn5+DQo+ID4g
K1ByaW50IG1vcmUgZGV0YWlscyBvZiBhbGwgdGhlIENQVSBjb3JlcyBPbiBpLk1YOE0gUGx1cyBF
Vks6DQo+ID4gKzo6DQo+ID4gKw0KPiA+ICsgICAgdS1ib290PT4gY3B1IGRldGFpbA0KPiA+ICsg
ICAgICAwOiBjcHVAMCAgICAgIE5YUCBpLk1YOE1QIFJldjEuMSBBNTMgYXQgMTIwMCBNSHogYXQg
MzFDDQo+ID4gKw0KPiA+ICsgICAgICAgICAgICBJRCA9IDAsIGZyZXEgPSAxLjIgR0h6OiBMMSBj
YWNoZSwgTU1VDQo+ID4gKyAgICAgIDE6IGNwdUAxICAgICAgTlhQIGkuTVg4TVAgUmV2MS4xIEE1
MyBhdCAxMjAwIE1IeiBhdCAzMEMNCj4gPiArDQo+ID4gKyAgICAgICAgICAgIElEID0gMCwgZnJl
cSA9IDEuMiBHSHo6IEwxIGNhY2hlLCBNTVUNCj4gPiArICAgICAgMjogY3B1QDIgICAgICBOWFAg
aS5NWDhNUCBSZXYxLjEgQTUzIGF0IDEyMDAgTUh6IGF0IDMxQw0KPiA+ICsNCj4gPiArICAgICAg
ICAgICAgSUQgPSAwLCBmcmVxID0gMS4yIEdIejogTDEgY2FjaGUsIE1NVQ0KPiA+ICsgICAgICAz
OiBjcHVAMyAgICAgIE5YUCBpLk1YOE1QIFJldjEuMSBBNTMgYXQgMTIwMCBNSHogYXQgMzFDDQo+
ID4gKw0KPiA+ICsgICAgICAgICAgICBJRCA9IDAsIGZyZXEgPSAxLjIgR0h6OiBMMSBjYWNoZSwg
TU1VDQo+ID4gKw0KPiA+ICtjcHUgcmVsZWFzZQ0KPiA+ICt+fn5+fn5+fn5+fg0KPiA+ICtPbiBp
Lk1YOE0gUGx1cyBFVkssIHJlbGVhc2UgdGhlIExBU1QgY29yZSB0byBydW4gYSBSVE9TIGFwcGxp
Y2F0aW9uLA0KPiA+ICt0aGUgPGNvcmUgSUQ+IGlzIHRoZSBzZXF1ZW5jZSBudW1iZXIgcmVmZXIg
dG8gdGhlICdjcHUgbGlzdCc6DQo+ID4gKzo6DQo+ID4gKw0KPiA+ICsgICAgIHUtYm9vdD0+IGxv
YWQgbW1jIDE6MiBDMDAwMDAwMCAvaGVsbG9fd29ybGQuYmluDQo+ID4gKyAgICAgNjYwMDggYnl0
ZXMgcmVhZCBpbiA1IG1zICgxMi42IE1pQi9zKQ0KPiA+ICsgICAgIHUtYm9vdD0+IGRjYWNoZSBm
bHVzaDsgaWNhY2hlIGZsdXNoDQo+ID4gKyAgICAgdS1ib290PT4gY3B1IHJlbGVhc2UgMyBDMDAw
MDAwMA0KPiANCj4gbG93ZXItY2FzZSBjDQoNCldpbGwgY2hhbmdlIGluIHY0Lg0KDQpUaGFua3Ms
DQpaaGlxaWFuZw0K
