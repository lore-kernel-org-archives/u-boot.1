Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D97C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 12:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8227B81111;
	Sun,  2 Mar 2025 13:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sii.pl header.i=@sii.pl header.b="cKxwHODp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD7D48118A; Sun,  2 Mar 2025 13:42:28 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20721.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::721])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A85F181101
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 13:42:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pkochanowski@sii.pl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6NGstfvYM8Ja6A700vkq8AxXPFbyPEpFtGmvIR9N7G4EAZcEbTv7tsZiVU4tiEsw/vFJg8eoYLknf00v9gtEASqq+mBu+Q7QS1Q/suUnjlk/5PBbidFbU9shZgP2Dgdt9XDF7vEEqEGX99LanWQS4HL2SMRQZidg+7i+9N9o/rBfcfnH353kVpD91TilnhUUxfAqGE73bLPKR6xvf03IvVtdXwDSojIcENmPoHW1m1km8ui+/Rv8V5LIX8YkgoGee4DmCZuCxLl9luFg8+8hERRVsdmCkQ4lKxU8BBpb6TUlWQl2QagGW30QLYyduY2ecgTTiWoqO/Axc5s45+cfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+djoVL8SZUMYBWmKfKIkksXP73Wb2wU5m3LZcP5HIQ=;
 b=dbKw4rsp6c/7RD29ZGGkRkxvMBUUr43De3QEl4+bNXi4rxv46Ag7ytWdUEMTKOw6ttfJxY7CmwddOSKrt8mgEREoRd9c4JFMdWhe8j4u0aKQmjCIeqBUbY2Wk19RptFegum0Gv55HI7qoueqoc0JjHAvkIqS6XSTXyMYhJ6HPR/dZaBjkVheX9/jWlyQKa8/W32uepS5QS9xzvwp/6TSD63qe1zB7qHC3lnag4DpVFIFahejXA+nF3Rd74kcz+ObxVYyixz/zPz6dbuABKgu0s3bdaFPnTOQCcMHdqFEhNaX2jBvvO2/zdnQ3cT8KCVoBsunQeXUI0SzbUuYpTCRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sii.pl; dmarc=pass action=none header.from=sii.pl; dkim=pass
 header.d=sii.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sii.pl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+djoVL8SZUMYBWmKfKIkksXP73Wb2wU5m3LZcP5HIQ=;
 b=cKxwHODp7kh53Kfjj735hV5bBU2+3uY9KCFu6w5EYzGRYPdq3o4xFasAKMwC2S0aieHfnETogf3tLHwMlAgc1WGBjWLzCLP2HGuIuWyj/ZCBdx4r60lZBMCbmLIZwdJh+w9BZ4RYItxxStH6G7zzK0Fl0J4Mn1+kjMbgp8DkrTWOyYl4+6tPgw5MDerBp/Y4WenLF12HDKRvuJuhUGB0zNTpQf1dH65EniXIBXJfZJnjYymfgFdQUXyjG1Q+8q5AQzJ3JqPJYgOjSuloAjukhrdHBUMmHTeN2ZUkifsdexrSLFLs1DCBKquTE9dn+31epwzlvRCeu0x1wLcFQRetng==
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::16)
 by GV1P191MB2193.EURP191.PROD.OUTLOOK.COM (2603:10a6:150:9f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sun, 2 Mar
 2025 12:42:22 +0000
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331]) by AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331%5]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 12:42:22 +0000
From: =?utf-8?B?UGF3ZcWCIEtvY2hhbm93c2tp?= <pkochanowski@sii.pl>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Gabriel Nesteruk
 <gnesteruk@sii.pl>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Glass <sjg@chromium.org>
Subject: RE: [PATCH] efi: Make FDT extra space configurable
Thread-Topic: [PATCH] efi: Make FDT extra space configurable
Thread-Index: AQHbe9XrZlcf1gYBKk206qhicRVTrLNP0faAgAAXXICAD/wL4A==
Date: Sun, 2 Mar 2025 12:42:22 +0000
Message-ID: <AM8P191MB1394241D3F057BDCB1F232CFA2CE2@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
References: <20250210160727.30993-1-pkochanowski@sii.pl>
 <CAC_iWjKLOw9gUxt+KE1iSTVsTawBPDXy40exTH97s7=+Bf3HRQ@mail.gmail.com>
 <6416d1a7-3221-4ea5-a88b-944f26af534f@gmx.de>
In-Reply-To: <6416d1a7-3221-4ea5-a88b-944f26af534f@gmx.de>
Accept-Language: en-US
Content-Language: pl-PL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sii.pl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8P191MB1394:EE_|GV1P191MB2193:EE_
x-ms-office365-filtering-correlation-id: 81dcc96d-da42-4d0c-04e7-08dd5987ad9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RktxeHQyQTRGSHBwMkJBcG9saEZtdE5WZ3lGckVxaDBvTEluRE55UXhvQzRQ?=
 =?utf-8?B?UGFHQlQ4Vm4vVjdCWmRRVFhVS2tWS2dhVjgvT3B6bG4yT2FKMi9IK3FlOWpM?=
 =?utf-8?B?VjhhV2owWG84aHRTdEo1d3RNcmpKemlVa3p5VXRWdUptN2tDL0JFUThsRjRz?=
 =?utf-8?B?cU5BWnBlajNOSmlVeExhMldFRUdUaWJrRGYwNEkxaXZJZ2xtT1lnYUE4a1B3?=
 =?utf-8?B?VEZVellueitHc01xcjgrVUV2ejdQTHhOeHM0bkhQYVBzREZYTk9meVBIaUZ3?=
 =?utf-8?B?NEI2SGhLcVo4YWp3bWFjOTdkV3l3bmM4cTBlWHJUWXlidzVrZWxudTZ2YmEv?=
 =?utf-8?B?WEJjbGw2T0xuZndNNzgwM20rekJzUFVrcWw2MWQ4aWhGU1dpT0c4VUlldFdN?=
 =?utf-8?B?Ky9nUzFrYTg3RVVzR1AyV2QwblZvcHpXTWw0YmFzUUxRbkFHeVpYTUhkVTdT?=
 =?utf-8?B?U01DVENWM05NMFp4dHEra1hRRW1SZXY2SnFNSHdCNDFUQnJIWUUwMU9GcU9F?=
 =?utf-8?B?OENmZHY4b1l0S2FURm84bk1QcHpoSHBObXN3VGVLSXlUUGd1WU9Pcm1QRVhq?=
 =?utf-8?B?ejlVNm9tNy9Xdm5IZ3gveVI5bkVhT3ZrdlRmOVRlZkh4eDQrTHBUenUwVXQ3?=
 =?utf-8?B?dURtbmhDRDR1UzZxeDN3UjF5SjdLWGxuOGp1aDBWaUdVY0lZODhvamFMTk9B?=
 =?utf-8?B?QnVMcTZDQTduQjZUdjM2VUk2bHFGTXN6NnJ4TnAvOXJVWjFSVmNnZ0E2UWxN?=
 =?utf-8?B?TlUza2d0bStSdFNoTnc1VXVJMEhPSWs0L3NvbitxWEdMQ0VJQnp0RytTWnZF?=
 =?utf-8?B?dCtSUEtmMU9aUGdmc0xSZUFkWGQ4MDc5S3U3ak51aDZKckhQTGp2Y1F4RmNu?=
 =?utf-8?B?bzkxV3RXRW1wR3B6WG5uWTVQd21tbFJjR1k0ZWNvOU14RE1QQW5ZS0pycktW?=
 =?utf-8?B?S3A3WXFZR1EwdHozTGZJR3JUK1FwMUgrSnFSWFFkOFZoUUNYUDVVM2h4aFVR?=
 =?utf-8?B?RzlRVFBUOFRvS0MrN3crbUgzYVpGaTZmZ3dwMkloMzVrL21uZHdabjZvUzQr?=
 =?utf-8?B?d1c0RHZSU25RY2J4dlRmdUxqSUVzZ2NPNnhaYUpSa2NwRVlabXFrdlgwUlhW?=
 =?utf-8?B?Q3RZeTJHandmMTZmd2Y2bDB6NVFycmdlUHBrcW4rdHMzelJqeVNYQjJtWnhG?=
 =?utf-8?B?NC9QaUNDSi84eVBrc0NpNlJYdllzQWdjNi9meUllOTg0SFRkSS9qTEROUlNI?=
 =?utf-8?B?TDNPcVRkdzg0WTkwM3NPR3JRZFBwMGdWN1QrSW9CU0JzREJxaW1nV2dIclJq?=
 =?utf-8?B?MURYUTcwM2FJMnBxUUV0ZEwzelorbGJFM2crT2E5Qm43SVlFS2hKd2xFU2x4?=
 =?utf-8?B?M0Z3YUVUbTdXb2dTOHg1Tk0rWmxEMStTZDdTbmgwOTR4Y3kyYUovRFplNExG?=
 =?utf-8?B?RGIrbnQ2dkM5Wjl1RTNuWU14dHhDZkYwM1J1RVRadmFJb2pIL1l6ZTJTT01P?=
 =?utf-8?B?TTBicU53eDdnRVlOTEt4Y2tWbnM5bTErejFMQXRiOHNoV2VvM2FKa05BRVdu?=
 =?utf-8?B?NFBCcmlNQ2FPbVhhZ1N4MVRybGlBcXNlNFFhMVhJK1FjUm5ZR1k5M2tTcnZa?=
 =?utf-8?B?Y01OOEVkN3cxRy9sSjZvYnQxNyt2V282QVJIYlEvQnlXNWR3QUczQzluTWRD?=
 =?utf-8?B?YzcwV2wrY2R3dDRtMTJCZlZjYmZXTVFFaHdTaEpHNkpEMS9xQjVsbGhXeW12?=
 =?utf-8?B?Ym0vRno1K3NIc3o5N1pxZ1VnYkRpeXRkRlY5ajFaMnZOQTRIYnkwNytLUS9i?=
 =?utf-8?B?QnBldG1YMHB5VmFvZkRZcXErUjUvTXZvUlhqT2c2Y2k2a0lDY2hPQ0h1d0h1?=
 =?utf-8?B?ODF3REdZTWVWalN4RTNJRlFFb29TcFFQRzRYSmxHUTFlUnF4Si93VTFTa0Vw?=
 =?utf-8?Q?N4Dx6Qk8czOZrB8VKaBp9uLVahergT0V?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8P191MB1394.EURP191.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXh0L1NBd2oreWtmbnJ4R1R3QlNSUUhkWDNJaWN0UUJtZndmZ2pHU2hpU1Az?=
 =?utf-8?B?Y0IwNW13SFFUME9SVEoydlhENWdZQmsxK0NzSTlQam9rNjJ3Yy9VbEhrMjgx?=
 =?utf-8?B?SmFPOTJ2VWJIY043UTRBWWZrSE5wNW9hSm9kUUJQUVdXZ1EwenpvNVBmdVhy?=
 =?utf-8?B?b05GbVhCRUJIdHdndTlYY1VGVWRjTnc0RWdmdll3UTlvUHBIQ0xBTVYvNmN5?=
 =?utf-8?B?RVhVL01sNEw1T1hybHFTdmgzemx0U1JVdHB1UHc2WWx2cEZuMkNGN0M0TG1t?=
 =?utf-8?B?cWJEdkNHcjQ1OFRlbzdmeHlQbGVjc1RRMVVqaEp5UG1sTWhabmlpWGVIVWpo?=
 =?utf-8?B?eTBBSXM4MzA5Tk5IM09odFM4ZXk1YUxsRmhIWFFHa1FIN3Y1Qk5WNXhRNUdw?=
 =?utf-8?B?WEpuRnpmQ1M5MHRsV1pGbVpTSCtxOC9iV3FlZnY2eVYzQWlWeXV1YUQ2ME13?=
 =?utf-8?B?TVFRSUh0M1l2b0EyWjNXYVN3ZGsrSkluSmZJeWFkMUc3V2kzSElEWDdqblFU?=
 =?utf-8?B?Wk9IN05TdTJ3cnovdmY5SDgvR2RNYmJyWGd4dDdHeXhkTEdITUNQWVdVYmVk?=
 =?utf-8?B?d2U4UUd1aXpnZTlNamhPUlN2blgxZm9MZ3Y1a2puU3FOV3JVcWoyUHVQd20x?=
 =?utf-8?B?N1h4ZGtOYXV0YW1XZUpqcmR2VHp2b3dtVEtPeWMybDFBOW1qaktHWmJ6L3J4?=
 =?utf-8?B?YVNPYnR1eWo3Q1ZSRUtsOHdHeklDMjRFUThnajlRdG1OM2NUS1lVWUVaZlBN?=
 =?utf-8?B?U2RvQVVRSWx5UmtvRUVneHFQZ3BLYkFPRTJKaTg3emhSdkhRVXc5MW04dXpE?=
 =?utf-8?B?NUV5Ti9BbWV5UHFlc05vSE5CUm9YUy90UHZGd2tOd0pZMWo5TS9ScDNPUTVY?=
 =?utf-8?B?S0ZUOTB4bEp3eFRCVTZ4Mnd1WnlWSkhYVEFtcnYxZkdhaXZXV0h6TGQrYUNs?=
 =?utf-8?B?Y3I5K21QdnBkTFlpWVlYSnBLSjNKKzJZS29JQWNXRkF1b09nN2c0N2tUUENE?=
 =?utf-8?B?aHVveldUTEVHVDFTQXhzMW15Vy92a1pOaW9HNkU4L0M5MnBvbXBPTFlIa3pT?=
 =?utf-8?B?TDZPN1dqelNWZWpKaUxKUUYwM1EyZ1pCMTY0YjBhYkd4OUh2YWlZZzlYZHpx?=
 =?utf-8?B?SnNBVkFjckQ0RUgvSlN2T2NQYytlRjlOZE5IS1g3Y3czUHlOZFpmY3ltd2RT?=
 =?utf-8?B?eVRNZEc1WDQ1YnZnWGljN2I5eDhPSHBIOUFGdzFIaGlDbmF1K1BvV3dSQlNO?=
 =?utf-8?B?ZGFnNnp0Y3R4amtjTXBzdXR2eCtXRTZqV2puUVJjMVhsU0N4ankzMHRaSVR4?=
 =?utf-8?B?aVRrNThvWVFXSjZYTU1DYnRLSXhmUlpyMW5XclRaM1pkb2FXRHRkOFZlNDV6?=
 =?utf-8?B?OXlnb1JyN3pIRFhQM2F3eU1GaDIxNjF6YTBHWDN6R1VnbnlZQUdzcUp0ZmJU?=
 =?utf-8?B?LzdEOCtrVzJTVk9WQnNXdXpQZGZMamxaUHlEandBdDM4akZMMTBDV0tLcndO?=
 =?utf-8?B?NHV1YUx6UURRR3AxYlRjMjdZY0JGZ1J0bUQ2UUNUd1FtRnBZb1FkU1ZxRXJF?=
 =?utf-8?B?NHdKOUVBZ0pNeGYyYlAvVzVZSElCZ0g0MGdCSWxpa3FMbWkzZERTMEIrYlh1?=
 =?utf-8?B?NlZWalQxTWhUdGxESllqTHBhYlpjVERkUHZ3YkJIREVZS2IyVGRuQlJKcWs4?=
 =?utf-8?B?bFgvRGIwenZwQUJ4SUVaclp2MWhDRjY2NzlyQ3ZQYWRja1B4RTYxYW1QM1pq?=
 =?utf-8?B?Z0NxTnVCcThlajJHZi9lYUJzZnlrdTZqZjJQcHIyUWxLS1dLenloQXA0cUpm?=
 =?utf-8?B?bU8vcEowWWZPZW81dEdDamNzWWI3YjhsUTQzVUU5VENBKzFndDU4aE1sVTJV?=
 =?utf-8?B?dzJ5WnFGMWN6L0diSmQ1VHltRStYNGJCTHhvWUtGMnprVGVQaUh2eFlvMFBD?=
 =?utf-8?B?VGplZXpaeks3MHZQa2Y3UzZGQ2V6RVZFUHo0cTZYQjZ6NnBwOU9pSnJlNFR3?=
 =?utf-8?B?TjNjWUE3TVRhMkZxRE9wRE8xVmMzelhmLzhmSHhja1YvSVNNOG84TlNFU0Jr?=
 =?utf-8?B?aUV6clRmY0FLK0l5NkdDYVlKUWNPRS9TWEN1MGFlQXBrcEl3NVdGNGw4emQ4?=
 =?utf-8?Q?o5b4H04Dgjxdt8XN9w6mvdYYu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sii.pl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dcc96d-da42-4d0c-04e7-08dd5987ad9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 12:42:22.4586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9bd6df6-c449-481f-abb5-37bd036beb76
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eanDNWRifQHAs24WllQ65p0aeTpP5zKm3aH5qHOyutwphOiuiFUqn4TjLSKwuz+ZAXTxI9zyGwGsLPEJOC4bAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P191MB2193
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

SGksDQoNCj4gRnJvbTogSGVpbnJpY2ggU2NodWNoYXJkdCA8eHlwcm9uLmdscGtAZ214LmRlPg0K
PiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjAsIDIwMjUgOToyMiBBTQ0KPiANCj4gT24gMi8y
MC8yNSAwNzo1OCwgSWxpYXMgQXBhbG9kaW1hcyB3cm90ZToNCj4gPiBPbiBNb24sIDEwIEZlYiAy
MDI1IGF0IDE4OjA3LCBQYXdlbCBLb2NoYW5vd3NraSA8cGtvY2hhbm93c2tpQHNpaS5wbD4NCj4g
d3JvdGU6DQo+ID4+DQo+ID4+IEZyb206IEdhYnJpZWwgTmVzdGVydWsgPGduZXN0ZXJ1a0BzaWku
cGw+DQo+ID4+DQo+ID4+IFUtQm9vdCBjdXJyZW50bHkgcmVzZXJ2ZXMgb25seSAweDMwMDAgYnl0
ZXMgd2hlbiBjb3B5aW5nIHRoZSBGRFQgaW4NCj4gPj4gYGNvcHlfZmR0KClgLCB3aGljaCBtYXkg
bm90IGJlIHN1ZmZpY2llbnQgaWYgYWRkaXRpb25hbCBub2RlcyAoc3VjaA0KPiA+PiBhcyBGTUFO
IGZpcm13YXJlKSBhcmUgYWRkZWQgbGF0ZXIuDQo+ID4+DQo+ID4+IFRoaXMgcGF0Y2ggaW50cm9k
dWNlcyBhIG5ldyBgQ09ORklHX0ZEVF9FWFRSQV9TUEFDRWAgS2NvbmZpZyBvcHRpb24NCj4gPj4g
dG8gYWxsb3cgdXNlcnMgdG8gZGVmaW5lIHRoZSBhbW91bnQgb2YgZXh0cmEgc3BhY2UgcmVzZXJ2
ZWQgZm9yIEZEVA0KPiA+PiBleHBhbnNpb24uIFRoZSBkZWZhdWx0IHJlbWFpbnMgMHgzMDAwLg0K
PiA+Pg0KPiA+PiBUaGlzIGNoYW5nZSBwcmV2ZW50cyBwb3RlbnRpYWwgY29ycnVwdGlvbiB3aGVu
IHJlc2l6aW5nIEZEVCBhZnRlciBFRkkNCj4gPj4gYm9vdCwgZXNwZWNpYWxseSB3aGVuIGZpcm13
YXJlIGxpa2UgRk1BTiByZXF1aXJlcyBhZGRpdGlvbmFsIHNwYWNlLg0KPiA+Pg0KPiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBHYWJyaWVsIE5lc3RlcnVrIDxnbmVzdGVydWtAc2lpLnBsPg0KPiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBQYXdlbCBLb2NoYW5vd3NraSA8cGtvY2hhbm93c2tpQHNpaS5wbD4NCj4gPj4g
LS0tDQo+ID4+ICAgbGliL2VmaV9sb2FkZXIvS2NvbmZpZyAgICAgIHwgOSArKysrKysrKysNCj4g
Pj4gICBsaWIvZWZpX2xvYWRlci9lZmlfaGVscGVyLmMgfCAyICstDQo+ID4+ICAgMiBmaWxlcyBj
aGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9saWIvZWZpX2xvYWRlci9LY29uZmlnIGIvbGliL2VmaV9sb2FkZXIvS2NvbmZpZyBp
bmRleA0KPiA+PiBkNGY2YjU2YWZhYS4uYmQyY2JlOTk1YzkgMTAwNjQ0DQo+ID4+IC0tLSBhL2xp
Yi9lZmlfbG9hZGVyL0tjb25maWcNCj4gPj4gKysrIGIvbGliL2VmaV9sb2FkZXIvS2NvbmZpZw0K
PiA+PiBAQCAtNTg2LDYgKzU4NiwxNSBAQCBjb25maWcgQk9PVEVGSV9URVNUQVBQX0NPTVBJTEUN
Cj4gPj4gICAgICAgICAgICBObyBhZGRpdGlvbmFsIHNwYWNlIHdpbGwgYmUgcmVxdWlyZWQgaW4g
dGhlIHJlc3VsdGluZyBVLUJvb3QgYmluYXJ5DQo+ID4+ICAgICAgICAgICAgd2hlbiB0aGlzIG9w
dGlvbiBpcyBlbmFibGVkLg0KPiA+Pg0KPiA+PiArY29uZmlnIEVGSV9GRFRfRVhUUkFfU1BBQ0UN
Cj4gPj4gKyAgICBoZXggIkV4dHJhIHNwYWNlIHRvIGFsbG9jYXRlIGZvciBGRFQgZXhwYW5zaW9u
Ig0KPiANCj4gSGVsbG8gUGF3ZWwsDQo+IA0KPiBJcyB0aGlzIHByb2JsZW0gcmVhbGx5IEVGSSBz
cGVjaWZpYz8gV291bGRuJ3QgeW91IGhhdmUgYSBzaW1pbGFyIHByb2JsZW0gd2hlbg0KPiBib290
aW5nIHZpYSBib290aT8NCj4gDQpZZXMgaXQgc2VlbXMgdGhhdCB0aGlzIHByb2JsZW0gb2NjdXJz
IG9ubHkgaW4gRUZJIGFzIHRoaXMgRkRUIHJlbG9jYXRpb24gaXMgZG9uZSB3aXRoDQpoYXJkY29k
ZWQgc2l6ZS4gSW4gb3RoZXIgY2FzZXMgdGhlIGJvb3RfcmVsb2NhdGVfZmR0KCkgaXMgdXNlZCBh
bmQgDQpDT05GSUdfU1lTX0ZEVF9QQUQgYnl0ZXMgYXJlIGFkZGVkIGluc3RlYWQuDQoNCldvdWxk
IGl0IG1ha2Ugc2Vuc2UgdG8gc2ltcGx5IHVzZSB0aGUgY29uZmlnIFNZU19GRFRfUEFEIGFsc28g
aGVyZT8NCkl0IGFscmVhZHkgaGFzIGluY3JlYXNlZCBwYWRkaW5nIHNpemUgaW4gY2FzZSBGTUFO
X0VORVQgb3B0aW9uIGlzIHVzZWQuDQoNCj4gPj4gKyAgICBkZWZhdWx0IDB4MzAwMA0KPiA+PiAr
ICAgIGhlbHANCj4gPj4gKyAgICAgIERlZmluZXMgYWRkaXRpb25hbCBzcGFjZSAoaW4gYnl0ZXMp
IHJlc2VydmVkIGZvciBleHBhbmRpbmcgdGhlDQo+ID4+ICsgICAgICBGbGF0dGVuZWQgRGV2aWNl
IFRyZWUgKEZEVCkgd2hlbiBwYXNzZWQgdG8gdGhlIEVGSSBzeXN0ZW0uDQo+ID4+ICsgICAgICBJ
bmNyZWFzZSB0aGlzIHZhbHVlIGlmIHlvdXIgZmlybXdhcmUgKGUuZy4sIEZNQU4pIG5lZWRzIHRv
IGFkZA0KPiA+PiArICAgICAgbW9yZSBkYXRhIHRvIHRoZSBkZXZpY2UgdHJlZSBhZnRlciBVLUJv
b3QgcmVsb2NhdGlvbi4NCj4gPj4gKw0KPiA+PiAgIGVuZGlmDQo+ID4+DQo+ID4+ICAgc291cmNl
ICJsaWIvZWZpL0tjb25maWciDQo+ID4+IGRpZmYgLS1naXQgYS9saWIvZWZpX2xvYWRlci9lZmlf
aGVscGVyLmMNCj4gPj4gYi9saWIvZWZpX2xvYWRlci9lZmlfaGVscGVyLmMgaW5kZXggMDRiMmVm
YzRhM2IuLjkxYjJhNWI4NjUzIDEwMDY0NA0KPiA+PiAtLS0gYS9saWIvZWZpX2xvYWRlci9lZmlf
aGVscGVyLmMNCj4gPj4gKysrIGIvbGliL2VmaV9sb2FkZXIvZWZpX2hlbHBlci5jDQo+ID4+IEBA
IC00NzcsNyArNDc3LDcgQEAgc3RhdGljIGVmaV9zdGF0dXNfdCBjb3B5X2ZkdCh2b2lkICoqZmR0
cCkNCj4gPj4gICAgICAgICAgICogbmVlZHMgdG8gYmUgZXhwYW5kZWQgbGF0ZXIuDQo+ID4+ICAg
ICAgICAgICAqLw0KPiA+PiAgICAgICAgICBmZHQgPSAqZmR0cDsNCj4gPj4gLSAgICAgICBmZHRf
cGFnZXMgPSBlZmlfc2l6ZV9pbl9wYWdlcyhmZHRfdG90YWxzaXplKGZkdCkgKyAweDMwMDApOw0K
PiA+PiArICAgICAgIGZkdF9wYWdlcyA9IGVmaV9zaXplX2luX3BhZ2VzKGZkdF90b3RhbHNpemUo
ZmR0KSArDQo+ID4+ICsgQ09ORklHX0VGSV9GRFRfRVhUUkFfU1BBQ0UpOw0KPiANCj4gVGhpcyBp
cyBub3QgdGhlIG9ubHkgcGxhY2Ugd2hlcmUgdGhlIGNvbmZpZ3VyYXRpb24gdmFsdWUgbmVlZHMg
dG8gYmUNCj4gY29uc2lkZXJlZDoNCj4gDQo+IGxpYi9lZmlfbG9hZGVyL2VmaV9kdF9maXh1cC5j
OjE3MToNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MzAwMDsNCj4gDQo+IENv
dWxkIHlvdSwgcGxlYXNlLCBzZW5kIGEgbmV3IHJldmlzaW9uIG9mIHlvdXIgcGF0Y2guDQo+IA0K
PiBCZXN0IHJlZ2FyZHMNCj4gDQo+IEhlaW5yaWNoDQoNClBsZWFzZSBsZXQgbWUga25vdyBpZiB0
aGUgaW5pdGlhbGx5IHByb3Bvc2VkIEVGSV9GRFRfRVhUUkFfU1BBQ0Ugb3IgdGhlIA0KZ2xvYmFs
IFNZU19GRFRfUEFEIHNob3VsZCBiZSB1c2VkIGFuZCBJIHdpbGwgcHJlcGFyZSBhbmQgdGVzdCBu
ZXcgcGF0Y2guDQoNCkJSLA0KUGF3ZWwNCj4gDQo+ID4+ICAgICAgICAgIGZkdF9zaXplID0gZmR0
X3BhZ2VzIDw8IEVGSV9QQUdFX1NISUZUOw0KPiA+Pg0KPiA+PiAgICAgICAgICByZXQgPSBlZmlf
YWxsb2NhdGVfcGFnZXMoRUZJX0FMTE9DQVRFX0FOWV9QQUdFUywNCj4gPj4gLS0NCj4gPj4gMi40
My4wDQo+ID4+DQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogSWxpYXMgQXBhbG9kaW1hcyA8aWxpYXMu
YXBhbG9kaW1hc0BsaW5hcm8ub3JnPg0KDQo=
