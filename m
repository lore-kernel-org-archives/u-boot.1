Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CEFC021AA
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 01:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54BC380805;
	Thu, 20 Feb 2025 02:52:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="dVciSGWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC2D880805; Thu, 20 Feb 2025 02:52:18 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9037A801DE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 02:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKK9GFeXp0rFqXyejEcMGN1sdfc8KTGIJQx51VQWX6rO0BLj7tDz7Yaz3alT5wMxhlYHqL81W8Sg5f2+LlXV2Tqu+3MTlRbTTCujEamaas69amOPxWDOGFuJ7p4FNrjf3DiXw2Ox8Ks6GUdDFLLfpnUF0HfiOy+Jeb9GQNGZCeblcGSMiWn1935edA7P/tHpFSFP6AmjT0NYLs3MLCMtL9XNSfhfG8lYVbhUWUT6/MLVGmbA0ZeeJFeSCpi+y9ti04xoYVaqhLX2vRW/ZfS8QHYyxNNIGg0Mi/wnE4itxu+BMZ9CS5qMs0Rcvh0yWf/huV43+NG3yF/C+/JM8d/dIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCxyqSM45xvoAqZh+AjsQ4Mqrr/2RqQKKGanlCcODsY=;
 b=Xy1yCSDEIGC+JX3SNkZfHOc7/YUD9DB0dM7vFyaYfkTgLMT1SBgd4HAoScWD5aQqbd8VAREE8hsITLpo3uXExCiQp7Aq07jg92EUCcADR7mm2qFgHAN209xuhqCCrLSMxmh/a8OI83WLOkpWo1pxQcSg5jCS05ik/GvuhKjoM5DVqQ5XPacqm6s1AfwWy9a99ehWCmzrDQtruBPiSQDml2urdII5c9e6A3OUpwCarbWTTvlNvaBNzuC7+BO6ckY1bcjXdZR+HKLk3OMN9JvC3ZlsR9SGOlvRDFnRdvqQ+jeDsS4zLLOztqKNAf05Wc0mddoOI/oB/jtzMmGUpfSzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCxyqSM45xvoAqZh+AjsQ4Mqrr/2RqQKKGanlCcODsY=;
 b=dVciSGWFIsk/Mb8yVOQlc2O5M1GY1M0bOvEk3u9AIx0I40VLrXoETJElmwAw9N4H4cVw9/M7f7P5JJelrnZHO0gi6YKeii0gp3tyKlOvCI9b2KQ0dUxs72qpji44R/n5d5bGqCnPo531awNYN7/ucdKdSYcDUrWt8SahxH4/L1Lbx9SqUJjEkWCazUHU81upc7tHbgZ09T7Gg184RW6RBRysWmlhqdfgjrbjn3IEyMs7LLx1sYYryc86cqs8m6f5YEnKFcrEsCuzVhvmFlGO4KHJOGZHeSzKExBwMNsjckxcfA6icy4b8GkW06XkY9KebdLHbi9sQeqUWWO0wWPTNA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA2PR04MB10411.eurprd04.prod.outlook.com (2603:10a6:102:424::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 01:52:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 01:52:15 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, Ludwig Nussel
 <ludwig.nussel@siemens.com>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] imx: fix imx8mm_evk config
Thread-Topic: [PATCH] imx: fix imx8mm_evk config
Thread-Index: AQHbgzjd/f21qu364EqR/DB38TDZNbNPa+9Q
Date: Thu, 20 Feb 2025 01:52:15 +0000
Message-ID: <PAXPR04MB8459BB961D40CC57FFBCA82288C42@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250213162123.69159-1-ludwig.nussel@siemens.com>
 <CAOMZO5As9nU4Bf1Ba_pUqgv2EdUd7niMte1bua9MBhk2zVr=Dw@mail.gmail.com>
In-Reply-To: <CAOMZO5As9nU4Bf1Ba_pUqgv2EdUd7niMte1bua9MBhk2zVr=Dw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA2PR04MB10411:EE_
x-ms-office365-filtering-correlation-id: abea64d8-d1a9-4133-9039-08dd51513353
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b3htVTRRazZZa0NCQjJOUTdWYTFXMGQzTDlJQk05UmxxUXNhdHlCM3hudFRa?=
 =?utf-8?B?empOcDZFWXJjYnpaLzZiSEVpQXhUUkxDY3BYUEY1RTNxVVdURHFqWXowMzg1?=
 =?utf-8?B?WEVWRnVWdVdPRWZRazhBcXUvd0RCc1I5bzlvVUpzejlWSjYzemVTb3NpQWVC?=
 =?utf-8?B?MHFNbktxV0xjZ3A5UkRpcTBwYUNYRUZ4S3AvbEFWK2d0UHJuMUU2OXNZRFZQ?=
 =?utf-8?B?ZmxjTW9JNTlhZERLd1VYV0NkZnRVQ2NRbTF5Y3M4RmJ4czNsbzNoY0ExMmVB?=
 =?utf-8?B?bUV4SDBRZVFxRGttRUdIdHhDZ2czK0tYa1g3c1VTdkxOSk9Ob0JmNmk3RnhT?=
 =?utf-8?B?U0djdWM3bVBHMG9JRUowQVVwUGtaYm9wSThHNjVpcDhzY2ZVVjV3VjJHYXBY?=
 =?utf-8?B?VDBWTk9KOWl1Q0QxN2N6alRFWkZsSC96RHd3aXlBUC80ZUpWKzdqTllrYTUr?=
 =?utf-8?B?YjZqQmNuRnIvWEN6d3drMnJFbDJxNjB2d3dCeWw3WklBUUh1YWhXbE9yVUhr?=
 =?utf-8?B?S0NqYWt2dG1pRjhlOEJBbm9nZzV2Z2EyVTMxb1M4RWx4djRVSDVQejdIcVZM?=
 =?utf-8?B?NkdRcVJaeTRwZTE1eUl1N2c1OERpTHJZTmNmTGwyMzh5UnN6cVRJZzNlQXpF?=
 =?utf-8?B?Z0lscFZGT0hRQ01HS1kyK1hrRlVxMkE2WFBlK3poUTluUm01UTIwNExSMVVD?=
 =?utf-8?B?Ylp4emtxUGhiRmVLZjdBdk9aRWJDMDc2dmtUY25sRmErbThkNWQ0RTlKSGdp?=
 =?utf-8?B?WC9DTUFNZ0NaSFZlTC9aeWdkMU5uWU9SNDVlN3g1ek5XRkxvSVhqcnY0ZEJj?=
 =?utf-8?B?MnRRMDBPT1lZQWhBdWpnSGU0b0hhT3NHMU5XMzhwZXhaY1g0NnRQb2JZd3lV?=
 =?utf-8?B?aml4L01TdlYxU04ySzFKMWRnbzh0a1c5aTNUTE5qVzRZbjNZNXNZVjRPSHRO?=
 =?utf-8?B?TmpkWjFNUG1Rc01jbHdLSVFCcVJGK0YxK2lYc2t3LzFWUWVwODEySGVtb0tm?=
 =?utf-8?B?M3VLUUdBa0JMbnVINDRia3AwdGF0emR3RXdFcFl5dzlDek9WME93ZmZNd2xr?=
 =?utf-8?B?a3pIVzlGeURvbWpnbWdIUnRxaFljQUl1U0hxZk1aNEIrUG5wQnhkS1hOLyty?=
 =?utf-8?B?bDJyWUZsTnpsbDVlenZYZUR0c3hZMGtPUXg2NXE2UVkwc0xPWFhYcktsNFhR?=
 =?utf-8?B?MWRvTDQ5RE9hU1Y2Y3NyV1JWOHBqcG1vY3VvY0FHcmlDREV5Sno5T3dRWklB?=
 =?utf-8?B?bXFvQjluWWsrNzFvVERJQzBXeFpSOHRLTnV3TXE4YU91U09kejJWZjdqZ3g3?=
 =?utf-8?B?WkpLdWV0Snc4ZHFEUEpldkkvS0VRZGRJV3Z3ODYvT3Q0VVZZNUJVdmdqd0NF?=
 =?utf-8?B?WU9pMThMRFRlZlhsVHA1a1R2b3NnN1pXa2NTTEE5SWwvTHFNNHFkUzBqaVJl?=
 =?utf-8?B?dzdvQjVFQUdvNVZWM1gyL01zNnB1U2JveEQ1aGNXdkZ5aXlTRmhyZ0RMODhu?=
 =?utf-8?B?OEthdTE3QWVRR1k0REg3QnRDc3JKZEJVdm4rNm9QVzVtMGlaNUdEZ0ZSbWt6?=
 =?utf-8?B?VGI0T0NDRHF5K01sOGY5Q0FPdVVXWTJWcnAyMlc0WUF5SzRLd3NvRUx3MFp0?=
 =?utf-8?B?VGhoaFpzVlRieC9FLzBWRkFXTXRKV0V3VGYwV1VOdFN5WEV0OUNQTStvVThL?=
 =?utf-8?B?WmtQaHBIY2xBOWg2U2tOY0FuUEkydDVtUXJHc0hDbDVveWRTbzFBZEZyWFI0?=
 =?utf-8?B?YjI2R1c3Y1RpTUNqR204VVpZeXk0NW1aQ0RMM0EzUFlrY3FhUm1WOEN0Tks1?=
 =?utf-8?B?b1QvRHo0ZnlkMTd3V04rMlpMZWF1cWN5aDU0cUNYWlA2STkxdVhBR1J0YUtL?=
 =?utf-8?B?ZkwyZHdSK1Q0UUFtNHhkbVlPdTBMSkdHTnkwanV4N3RmUUZTYTZrd05SdTRO?=
 =?utf-8?Q?xBteW/qZTbF6qHQe71qVOYTUR1UKHgE3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTc5dEVsVHdQb28rQ2RZQXpvM3prZ2FKUkVqZzhUVGpqQVlGdGFqTlk5WnJp?=
 =?utf-8?B?V0tNUGdnN3dUcVV1cVBKZnA2Umt5UC9tQzk1NWZSQnhLcHhid0RUNHB4dEJR?=
 =?utf-8?B?ZTE1U1N1RUM5RHFxYllKZDIxOVVQejR1RUJaUHgwbjdpQzlzUlZ6bksrcVN0?=
 =?utf-8?B?QmQ4QzFXclVXaXhpN0xUM0xKcXVWUEU3Z3YrVUVJakRCMVNpN0ZzaTU5aTJr?=
 =?utf-8?B?OU5sMDBTYmlRQ0JwK2lVNXlsMU1saTRQVUUrOUpqbllIL3daR2VybVZwRktj?=
 =?utf-8?B?REJnYXV5NFUrY3BWdjQrb25vTVpMWE9Wc2tpbU5YOVFWN0tIODB4L25LYjJL?=
 =?utf-8?B?d2NtZ0dLWlhIc1ZZT05oMHFNM3gwREplWkFXRjRocGFVam9RTHdQOTFSTWtw?=
 =?utf-8?B?MHNsaTcxYlFwekU4RE9aZUpqYk1pRTRGNjBORVJvMUhEOE5vV2dmVGdJSy9m?=
 =?utf-8?B?bDc1MzJoa2F0L2ZOTjlhMTIvZis5OThya1U3U1Bmc1I1V0hZT1REdmZRRkF6?=
 =?utf-8?B?ZFlXaUU1TjFXVGcyZU5wTDNRU2lEZy9FZzNhRWNhZ0ViUklDVHF3YlZENldl?=
 =?utf-8?B?WXFSUlNhbTFwTldVdGxSSTRuTERxRHlGeHNhbjY2MUNYV1hwRGxoeUdxaG1m?=
 =?utf-8?B?cW9sTjRUTGtFK3NNR1VNbmhVU28wS2cxWklLeDJRTU9vTlJxcC9FamJIdUln?=
 =?utf-8?B?YVJwL2lkNWplVjl2NTVaMFV3YXdRZnJ4TjJiTklPUmFVUGhhY1dHaHhGWmwy?=
 =?utf-8?B?ZDUvcm9NUWdnZjZTMkMvU0o4OUVKR2lsVTNHZGVIN1owREh4aFA1cDlITmds?=
 =?utf-8?B?S1Zjc0xqSFcrcXhkaG9tNzkzRXVBSGtqZjQyaXRidHAwMlRTZjhtZFpzSWJL?=
 =?utf-8?B?RlFMZ0J3RmltVk1sUlJ6OFhtZUc3MlZzTVlWMk9KT1lDbHlHV0dFeGtaZGZl?=
 =?utf-8?B?QjE5NEhUMG1oRkgyWHJTbVZvMTFSOGRkSE5QVjVpVFRQZ1NUQkQrMktuOGZI?=
 =?utf-8?B?U1dzRysxN3dOeWVuUjEwcndoM3hhQktWYm0zSnBXZXE3OVlwa0g3QmVYbWxB?=
 =?utf-8?B?TFV3UVZFWGhCTTM5azBaeXJPc01ZN0ptT2ZzZ1JXbTRsRnp4T2pTYkYrRitJ?=
 =?utf-8?B?Sm1hdC9yZ243eGRMMysxUFRvOEZEbTNzRzVUeG1UWGwwQWh2VEVCdU95VDEw?=
 =?utf-8?B?ZXJlNm85cUdSMUc5OUlFWXVLQlhvWlhrR0R6VEFjaklCR3BoRXUvZXhNYkYy?=
 =?utf-8?B?NnhUMWRPZjE3bGRNandJQTlic2w0ZTlpdUJ2T0IyMXNSOWsrTzBwNzFuWFpY?=
 =?utf-8?B?dEtaSGd6bzZBcmhQdjE4YWxqSU9MZ2VmT3E3NFl1QjBjbUdjZWFEcW4vTGpH?=
 =?utf-8?B?QzlRWnpzTkVJdWViZ21Sd2l3ZjN6N21GbmxudWZxTXVIL2FVUTNWSTllaHoy?=
 =?utf-8?B?VGZOanRIZmF4bzhOZWUvTEZjWVZ3d21Wd1htS3pjYy93ZkRLL2dTYnorNFI1?=
 =?utf-8?B?RUFHaUxuWmk4bVg2U0RJckVoOEUyeDlyUFA2Y2Y1am10VVpvUSthZmZ4MTZQ?=
 =?utf-8?B?QXNZZTR2VmdiZlR3Y3ZycnNXSUpkTG5EWFlOOHB1Rml6Y2w2aWo3RCtaZElu?=
 =?utf-8?B?YWQvVWdlblhwNG9obkk3UzA2M29NZ2VaN1VJbUZFMm9vczQ4VVpzRlFHQ2Ix?=
 =?utf-8?B?OFBUQjJ1cklHcDIxRGl1alNXUFVqYk5KWDBHc205WHNoQUJKWis2U2xCRUxN?=
 =?utf-8?B?MEtCbTdEYnB0SWE2N1htVWR2T2pvWXM1ZXQ3WWpwVndjb3hHV3hBMGNyeXFr?=
 =?utf-8?B?UmY5TjEyZ3hwSUVxOVRMY2NRUWZhWHl0eHZ2UmNsTXNENTZPN0I3UFErVGlL?=
 =?utf-8?B?KzRSdWpyOVR0UjdJNXBXZzM1SGRvcGt6RkhQZGpBam1BYWpJNDE5MzBzclk0?=
 =?utf-8?B?V2FBV2p5SlFYSEpibDZZOUlFZXhmeWg1NVNOcFArRjlDVXc4MjFPM2JQL1FZ?=
 =?utf-8?B?QkdLV1MxYWMwdmhUYTJ4WjBUdjc4Ymt6U1VpYmJsRUE1dU12bHBZdEU4a3Rj?=
 =?utf-8?B?ZllGS0pQNTBsd0xiaFpucW5qU1RCUTBuRjg3b1dEUklZZThtb1Rrb0p2SkxD?=
 =?utf-8?Q?WiLE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abea64d8-d1a9-4133-9039-08dd51513353
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 01:52:15.1617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LX2260kjdoCFxhy5xF2R+kIZiV0FVs5ufD6K4CChmjCPhvKpqOZGLYMRWQ38+qt11GGUHJ+AAcxIFsXWMXwZmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10411
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

SGkgRmFiaW8sDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaW14OiBmaXggaW14OG1tX2V2ayBj
b25maWcNCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiBPbiBUaHUsIEZlYiAxMywgMjAyNSBhdCAyOjM0
4oCvUE0gTHVkd2lnIE51c3NlbA0KPiA8bHVkd2lnLm51c3NlbEBzaWVtZW5zLmNvbT4gd3JvdGU6
DQo+ID4NCj4gPiBDb21taXQgMzY0YmE2OGVkMWEgYWRqdXN0ZWQgS2NvbmZpZyBmb3IgaW14OG1u
X2V2ayBpbnN0ZWFkIG9mDQo+IA0KPiBZb3UgaGF2ZW4ndCB0ZXN0ZWQgMzY0YmE2OGVkMWEsIGhh
dmUgeW91Pw0KDQpOb3QgdGVzdCBhbGwgdGhlIHRhcmdldHMsIDkzIGFuZCA4bXAgd2VyZSB0ZXN0
ZWQuDQoNClN0dXBpZCBpc3N1ZXMsIGNvcHkgcGFzdGUgZnJvbSBvbmUgYm9hcmQgdG8gdGhlIG90
aGVyLCBidXQgZm9yZ290IG1lDQp1cGRhdGUgdGhlIG5hbWUuIHNoYW1lIG9uIG1lLg0KDQpTb3Jy
eSBmb3IgdGhpcy4NCg0KV291bGQgeW91IGV4cGVjdCBhIHYyIGZyb20gTHVkd2lnIG9yIG5lZWQg
bWUgdG8gYWRkcmVzcyB0aG9zZSBpbg0KYSBzZXBhcmF0ZSBwYXRjaD8NCg0KVGhhbmtzLA0KUGVu
Zy4NCj4gDQo+ID4gaW14OG1tX2V2ayBmb3IgYm9vdHN0ZC4gVGhlcmVmb3JlIG1tIGlzIGFjdHVh
bGx5IGxlZnQgYnVpbGRpbmcNCj4gd2l0aG91dA0KPiA+IGJvb3RzdGQgYnkgZGVmYXVsdC4NCj4g
Pg0KPiA+IEFsc28gdGhlIG5hbWUgb2YgdGhlIGR0YiByZWZlcmVuY2VkIG1wIGluc3RlYWQgb2Yg
bW0uIElJVUMNCj4gPiBDT05GSUdfREVGQVVMVF9GRFRfRklMRSBpcyBtZWFudCB0byBwb2ludCB0
byB0aGUgcGF0aCBvZiB0aGUgZHRiDQo+ID4gd2l0aGluIHRoZSBrZXJuZWwgaW5zdGFsbCBkaXJl
Y3RvcnkuIFRoZXJlZm9yZSBhZGRpbmcgZnJlZXNjYWxlLyBhcw0KPiA+IHN1YmRpciB0b28uDQo+
IA0KPiA+IC0tLSBhL2NvbmZpZ3MvaW14OG1tX2V2a19kZWZjb25maWcNCj4gPiArKysgYi9jb25m
aWdzL2lteDhtbV9ldmtfZGVmY29uZmlnDQo+ID4gQEAgLTI1LDcgKzI1LDcgQEAgQ09ORklHX0ZJ
VD15DQo+ID4gIENPTkZJR19GSVRfRVhURVJOQUxfT0ZGU0VUPTB4MzAwMA0KPiA+ICBDT05GSUdf
U1BMX0xPQURfRklUPXkNCj4gPiAgQ09ORklHX09GX1NZU1RFTV9TRVRVUD15DQo+ID4gLUNPTkZJ
R19ERUZBVUxUX0ZEVF9GSUxFPSJpbXg4bXAtZXZrLmR0YiINCj4gPiArQ09ORklHX0RFRkFVTFRf
RkRUX0ZJTEU9ImZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0YiINCj4gDQo+IEkgdGhpbmsgdGhpcyBj
b3VsZCBiZSBDT05GSUdfREVGQVVMVF9GRFRfRklMRT0iaW14OG1tLWV2ay5kdGIiDQo+IA0KPiA+
ICBDT05GSUdfU1lTX0NCU0laRT0yMDQ4DQo+ID4gIENPTkZJR19TWVNfUEJTSVpFPTIwNzQNCj4g
PiAgQ09ORklHX0JPQVJEX0xBVEVfSU5JVD15DQo+ID4gZGlmZiAtLWdpdCBhL2NvbmZpZ3MvaW14
OG1tX2V2a19mc3BpX2RlZmNvbmZpZw0KPiA+IGIvY29uZmlncy9pbXg4bW1fZXZrX2ZzcGlfZGVm
Y29uZmlnDQo+ID4gaW5kZXggNGE4ZDQ5OTRiODAuLmEwNmI0N2FjM2JhIDEwMDY0NA0KPiA+IC0t
LSBhL2NvbmZpZ3MvaW14OG1tX2V2a19mc3BpX2RlZmNvbmZpZw0KPiA+ICsrKyBiL2NvbmZpZ3Mv
aW14OG1tX2V2a19mc3BpX2RlZmNvbmZpZw0KPiA+IEBAIC0yOSw3ICsyOSw3IEBAIENPTkZJR19G
SVQ9eQ0KPiA+ICBDT05GSUdfRklUX0VYVEVSTkFMX09GRlNFVD0weDMwMDANCj4gPiAgQ09ORklH
X1NQTF9MT0FEX0ZJVD15DQo+ID4gIENPTkZJR19PRl9TWVNURU1fU0VUVVA9eQ0KPiA+IC1DT05G
SUdfREVGQVVMVF9GRFRfRklMRT0iaW14OG1wLWV2ay5kdGIiDQo+ID4gK0NPTkZJR19ERUZBVUxU
X0ZEVF9GSUxFPSJmcmVlc2NhbGUvaW14OG1tLWV2ay5kdGIiDQo+IA0KPiBEaXR0by4NCj4gDQo+
IEFub3RoZXIgZXJyb3IgSSBzZWUgd2l0aCAzNjRiYTY4ZWQxYSBpcyB0aGlzIGh1bms6DQo+IA0K
PiAtLS0gYS9jb25maWdzL2lteDhtbV9ldmtfZnNwaV9kZWZjb25maWcNCj4gKysrIGIvY29uZmln
cy9pbXg4bW1fZXZrX2ZzcGlfZGVmY29uZmlnDQo+IEBAIC01LDYgKzUsNyBAQCBDT05GSUdfU1lT
X01BTExPQ19MRU49MHgyMDAwMDAwDQo+IENPTkZJR19TUExfR1BJTz15ICBDT05GSUdfU1BMX0xJ
QkNPTU1PTl9TVVBQT1JUPXkNCj4gQ09ORklHX1NQTF9MSUJHRU5FUklDX1NVUFBPUlQ9eQ0KPiAr
Q09ORklHX0VOVl9TT1VSQ0VfRklMRT0iaW14OG1uX2V2ayINCj4gDQo+IFlvdSBjYW5ub3QgdXNl
IHRoZSBlbnZpcm9ubWVudCBmb3IgaW14OG1uX2V2ayBvbg0KPiBpbXg4bW1fZXZrX2ZzcGkuDQo+
IA0KPiBKdXN0IHJlbW92ZSB0aGlzIGxpbmUsIGFuZCB0aGUgY29ycmVjdCBlbnYgd2lsbCBiZSB1
c2VkLg0K
