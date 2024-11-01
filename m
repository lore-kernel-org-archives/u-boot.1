Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AED3E6B24F
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 12:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFEB889D2;
	Fri,  1 Nov 2024 13:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Ejmw5GS8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC909891DD; Fri,  1 Nov 2024 13:09:17 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B61B9892CF
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 13:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nfgb8Uhk4Ds7Y3anOBTgnbCcWgXgyeirCKucKlVEHwToX4uh7PGEDY+4zz4JuHucPJiUyhgkqFO+Ri6OlqRUvbQxFcUTdXeGsbn4uOSZlXDyOP/26+IBrC/WeD2CpmWJUIsu8ZDhq7o8TuZuBxA0SVDMeQrPdPCHP71KQJRqOUNFX1t+QUoZvrrSeBZBVo3f+vDe568Z+DVgz8WbAM5y5A8Cau19M0uJpbE1OPJ8ltOrLsgGlblTdTi03p9K3M9uGvUYWsZOKhI1WyELvZDd0qXt97QkTdIE2qDHiBRFvZECdBl3TD0h1ZOgQxTKwfuci+XkpEyTw5Its/nRP5xkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns9HqpuSLSk9L2vrLhzg/cGNYnezha73S/YyqKoZ06w=;
 b=O4Fza81wt+4BOg+uvS5fBdgW+pVmECryD/kF+uhZK5HsiK6r9TG6hMlvZjP5qBOp5iN2+qF55nl/wRH3/ah3tMnx1UxwnCaXXgQ+U9jJ8n7udkNUyquaqKZ9wLViT8Cy9VYaQj/+L3zxsP5PG1X8YSVhli1d+XVvrAb7s9c4Nqd8N1ddmoJtcjS0IRVoTBy2LL6PFU+cTe/zGLhk1uFL/uRN6eJlrfMeDipwH50pFWERIiJTRDUokQ8ZvtXzwgwh6iad8InPYIMmEgNbcNZmrcEBNoO5GuoMCReRwH6G1xdhrLO85B+H/N63oFvxrwGfDyuKwo9t0hsXowqoofwCPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns9HqpuSLSk9L2vrLhzg/cGNYnezha73S/YyqKoZ06w=;
 b=Ejmw5GS8t5VD5sJ2OZ4Yrgqdg7U5Ey+SMqh+uQUjTtreXb5ImTVvA6J1mtjImT4hafP9xqshnYd6Umj5+lgeCN1Ys3JVGXpTlIF/Tyfwlpw93tT5rthOfLnvJfjHNuN7bdJtgTjvBTxE0npuVVIbqjUELCvDO/g1hz98Zovd7yGW428lG/SiF5Cm6MgeaJrlwSY8MzWlX5dXsiyofneLlAtKaIbBlO3S0QuTfZIfkMapcTS+4Lxx8smvuc25EgyB9WHDqGsUbGK3221NSKl5SHy81bS4VMbw2IuNZl/mCVDRztACtdAi/oGEgm/BGHTbPfNIkbbi1qWqZBZrLV+ZIw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10649.eurprd04.prod.outlook.com (2603:10a6:102:48c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 12:09:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 12:09:13 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "egyszeregy@freemail.hu" <egyszeregy@freemail.hu>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "sbabic@denx.de" <sbabic@denx.de>, "festevam@gmail.com"
 <festevam@gmail.com>
Subject: RE: [PATCH] imx9: Improve boot device auto-selection
Thread-Topic: [PATCH] imx9: Improve boot device auto-selection
Thread-Index: AQHbHZdg9PRX9ypEMkGYCrSJBu+Zw7KicnUA
Date: Fri, 1 Nov 2024 12:09:13 +0000
Message-ID: <PAXPR04MB8459A2266A5BAB9A51CD20FF88562@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241013174120.1872-1-egyszeregy@freemail.hu>
In-Reply-To: <20241013174120.1872-1-egyszeregy@freemail.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA1PR04MB10649:EE_
x-ms-office365-filtering-correlation-id: 2e8b7d4b-8a34-4ceb-153e-08dcfa6e0005
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TkFtN1lQWWQ3bVFnSFJEeWJUSzhIWlNuUHlTZG9nc2plQzRFVURJQ0FsOEJi?=
 =?utf-8?B?R0YraEtobkpYMHM1TERZeWZ4MnpTWHlqS0RuS25TT21ybWZqTytIRXR6aWtI?=
 =?utf-8?B?bGwyMXlLUlRkVkZDTXNFNHNWaTVvRm9lNlo2YWs5YTAwRnFwVFZhZDVFcXRu?=
 =?utf-8?B?bVNiT0lKMm9DQmQxWFU4NjVaa1pBUytwOFhpNk8xZkRnRCtMK3dxVDZJaEpp?=
 =?utf-8?B?ME5TWlhKMmpLMFdlUzFHWkEweWxSU0RSK2dLS0RTNGtwUEhYaFJyTXpJTkF1?=
 =?utf-8?B?dk1lMFhlakI5SXIvMzRRUXZkdUw5ZjNSK1l6VE80M0h2UWhZSUJRZU0wM1hM?=
 =?utf-8?B?NEU3bG0wUmZBdnc5TE0yZXMrVDVFRVJhR3BMbHlzNTZ3YzRwOFVYUWRDQW9T?=
 =?utf-8?B?dlpOWG8vbkdQNjFYejVvQXB2WWRHTlRtOWtxMmVRdXlTVkRlb1lsSGVxWDNl?=
 =?utf-8?B?UjVTV3RCT1JpbVRXYWlObXFSZkNHbHRyTWhNUnRrd2t6WWxSRWc4VDNxM1NO?=
 =?utf-8?B?RlBiVVErV2gyMjlxenduSFZCNFpnWnN5TVR6SHpjTU43aDhQQ3lER0VBTEdS?=
 =?utf-8?B?enV2SzdyWjhnUEUxM3VlSnpSZlI5dXpJbGpPT1FNK2FLTTdKVldMY2hiWUpt?=
 =?utf-8?B?b29wR2lnZWt1ZXhKckU0dk9PN094VFM3ZFNORWNtMUsxNGRZd3RKdFR3TDNC?=
 =?utf-8?B?dzVWSkNvVmFkSWhqRGhERDNUQUtLeGgzZ21aa2VSTGlHVjBhRTc0Q1VJMU0r?=
 =?utf-8?B?OG9wcE54RjROU2c4QTJTVVl2VjVZb2hxQ1ZRUDBnRysrM01BRFB6ZDV6d3Fm?=
 =?utf-8?B?RzNYSUwrOUJpRXBxYzJHS3hZUnpZU1V0VkxKUFFWdUpPSzRXbC9mYmVnWGpF?=
 =?utf-8?B?enNZTjBJV1hRdlZlalo1YTY3cWRJcVEvSTFIa0RRRTJnWUdkOUtCaU1zUzFY?=
 =?utf-8?B?ckVKN1JMelp5L1dSeUo5dDlGWGdPbXRFTjIrcGNJOWFhWURjU2M3c1d2cFFY?=
 =?utf-8?B?UTBkQno3ckkweXljb3ZOb0ZtZ0RsYTltL1llQVhPNGlKMTc0MmJla25GL05Q?=
 =?utf-8?B?Skk0WmhjWFEwOE1VWU8vNXJ5NHJmRWsyTDBrUEhoaTlpWnVyUmEwRnpVcmVZ?=
 =?utf-8?B?cGlyNmZGelhmcGdxRG8wNlVNSFZyTVNnMDJmYjZQMVJvMC9MSTFjTzl2WXRD?=
 =?utf-8?B?UFhrS0ozelR1WUUwK3RtNlZkeTh0eStReXd3dG1Fa1I5d1JHbG1UcnRRUG9Z?=
 =?utf-8?B?SFpaRm5wd3VoeUltMHRMK1FscTNoZnJDdjB4RTdIUGthSld5UllKUkVGbmx2?=
 =?utf-8?B?MEk5cDluYmlQYWcyMkgxYWlpbklqNFhpd2xtWWVweFNybFc0MDFrNVp3TTcv?=
 =?utf-8?B?ajhPNHN0aUVpVnRjaHRxdmR0WGRPMlpra1YrYW11MFBpbU84QzU4ZlN5UjQw?=
 =?utf-8?B?c0JpcFIvRVp5cFEza3lveS9NelZQSUtZVng4V0hQWDh2ODUzSEczV2NiYVdz?=
 =?utf-8?B?SkR0TTBjQVlxaDlXc1lpSURzb2VSNEFQV0Qya0pOOWNybkpDU0h3SDl1bTIv?=
 =?utf-8?B?TTE5d2NLTlIrZEF5UkxXRGJKaS82QlNiLzAyVVF2b3EvRWw5OFVaR3h1b013?=
 =?utf-8?B?ZFJRcWZUb0haMnZVUTBmNkhpV2pJSTVLTjlsYUdXOWRYR1poR2taK0JWRnND?=
 =?utf-8?B?ZDdpbXZuRjUyS2ovRXpSbEVwdmRlSWpMeXJLc01MeEhEekhTQ0FjSnlUYW52?=
 =?utf-8?B?ZUxqTGxhQXd6WXBNVEJGQStrclNrWTlSTGRnT014c2h4WGhDcTliTmcydUww?=
 =?utf-8?Q?OJhf4bl9P+IOQx36uQmyyVG+dt6hc4cLFCCLA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ni9EOEtPNEsycHBTVDl3cWd2Tmc5MXFpSjEvMmFSR0R3RVpxSW4wTEE1N2ln?=
 =?utf-8?B?V0JXWStNQUhtNWtKQ1hQVnNYNDJGWW5PSUhBNHI5ZURrWkhaSzVBb211aWlK?=
 =?utf-8?B?bVI4SFNwQXlyTmxLRkNUUkE5OXRJSEEwR201Z1ZZY3R2WnpjeC9Kc3Jkd0tE?=
 =?utf-8?B?YmZWWGtrQnN6Y05kb1J6bHl4Si8zbThrYWJYcEJxMENzM3RsVFcxTndpcWVr?=
 =?utf-8?B?aU9QS1IrQ21YWEZRSXVaSHNtQjk4QS9nZktKa2dDWmJ4T01kaWIvN09wK2sy?=
 =?utf-8?B?ZmdPTmJidG9CNXEwWTAwS3FpMXVncEdibnhNSXI1RkRPOUVwbklNSm1nMFVD?=
 =?utf-8?B?b1hSTEluRGVsb0Z5QWpTRCsvemxRalNLNzEyZzR1VDdsMjlrUVlGbmRJZFNj?=
 =?utf-8?B?YXQ4eHRUTFNBajRaOGhBYS96RkdCTFloRGdEbGRUdGU4N2tsdjhpcEZybklI?=
 =?utf-8?B?QVk1b2dERERzT0lpZ2VrM0RIREk4ZWVuNitvaTZrNjBENWczclpQTFdrTmxG?=
 =?utf-8?B?TU0zTzFzcytUZ0JUL3pUdjlmUk80VEpIT2Vtc1lGdVQwT0FpOEVrdTMxZkh0?=
 =?utf-8?B?eXYvOG4vZkRNV2htcSs3UTg0MTh4bjM4MEtnSldweSszbDMvQXpQMThoL1Ar?=
 =?utf-8?B?Uit5WFUyYW5kYTlCc0xLVmlDdXRsTTJNZmVvWHJBRW43bXlCZDdyOG96VCs0?=
 =?utf-8?B?b1hiVlZNdDNSN2pTdUJLWjBGd1laUDJQMkJUYyt6SzZqMWdFRHFaUDIyOWVU?=
 =?utf-8?B?c2F2Z1JrVCtOSmp0UzkvSFNaQlQrbEpxb0k5Z3NIOTJJbVVVeGdaU3RaSkxk?=
 =?utf-8?B?Skt6RGhCSmJvVFl1NTZ4SWJJekdLRUdUb3pKKzhEUjJibkxYVFVpK3Q0aVhX?=
 =?utf-8?B?dDNlMnpSamYvdCtwaSt2Z1BCdS9aU08veXhSQ0RXZmI0SjRYU0FDeFNiTCt0?=
 =?utf-8?B?N0cxVUFySmFWeW9uTGN5bzhuT2xjYTgwUlkyRVIxNDdOZ1kvcmZhY3VQWEFy?=
 =?utf-8?B?QXIvTmhocjZ1RDAyOEZuSlJaSzJmdm1XeGZMWVBjcFRyaEVicTIwc04yYXZz?=
 =?utf-8?B?eWxBUlpuRVNhWStBdHBMbmY2Y3YxNExJa3ZTREk5MElTaCt4Qm5PUFlsU0tF?=
 =?utf-8?B?WC81M2Z5N2pWRjdQckpKRStFOWFNUFRhVmg0UHZtT05WMUE2TW94b0Y1WDJD?=
 =?utf-8?B?SnNKaGd0akd0cUsvbzhMdldMQ01paWRWQ1MrNFIrS2ZyWkVSVnFwL29kQncy?=
 =?utf-8?B?M05Bc3NqZ2lZYTdYd29xVEhrQlprdkFoVHJtRGNXQ2FzUDlaNzFFYVZiekJh?=
 =?utf-8?B?dFFGZWQwNDJXRXdnQXVSWS92TWJMR3ZEVC9wUXZvQ0VFZm1RN0FpSVNDYW1j?=
 =?utf-8?B?cllHS01xaDBnOEppZUFTbkE3L1RaNkJUcXVVL3pENzZkNGtmdFJ1WDd6QjdY?=
 =?utf-8?B?T2l2YitnUXB4Rm92SzM4N1FtSWZJUjdLTHFUbFFqdmZ4ZXJSK2sxcWoxdTRX?=
 =?utf-8?B?WXNUYXZKSjBNVEFJWWxBOXVqck95OG5XT2oxQno3a0ZwcWc5cjJiSk9LNkJR?=
 =?utf-8?B?ZU9EMlhweFVDd1VlK3lKL3dVTWIrV1VsZjE2YjRwU2c0eVFiZHlIZ2o5elN4?=
 =?utf-8?B?cjNtUnRTSVNIQ2llbWtUMnoyelFWNVZyTGM0K3JySTV6VlIvUE1TYktZc2VE?=
 =?utf-8?B?L3YvQlA5ZmV0dEtLbWZwQkUraWJXUjFudUh3M0FJd29zNXNxQjBwK1E2ZmhZ?=
 =?utf-8?B?NmoybHVkMkRUeGptUkhpY043ZjVBbUZyK1V4a1lIeUlJSXhOMXF2RHhwWS9F?=
 =?utf-8?B?alI5cUJEQ3V5Y2RWaDFpN2FBTmo0VHUxaGhncDR0WGhRVGxsTTE1NEVtS3BS?=
 =?utf-8?B?VDladmcyQjhvQm1YOHRiQkFKRUh1bktOb2wzSXExcHFJYmtIQTRaaFNLdzAz?=
 =?utf-8?B?aTdsaEdHTFdZMkU3Y1RDTXh2eldtVVhWVjFvQzZVK3pYbldVNGx6SmRGWisw?=
 =?utf-8?B?TDlpbFRKUmJMZDUrOUl1ME43MGg2M0wwSEloVXVGdXB1c2dtL2ZrUUxUSzA5?=
 =?utf-8?B?eFJmOVpzd3c5QTJkZ0hvZk1RYmZMM3lkaUVVYVdNREtvWGZCc1BrVWgvR29o?=
 =?utf-8?Q?DbLc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8b7d4b-8a34-4ceb-153e-08dcfa6e0005
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 12:09:13.3193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wT9HScodN+4UiZKta9/I+dq+3b2qrfOae7ecm303qkDGsq50CCx6C7LE5YsdLUaTai+0KZYLQib0cPpMDeJnRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10649
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

PiBTdWJqZWN0OiBbUEFUQ0hdIGlteDk6IEltcHJvdmUgYm9vdCBkZXZpY2UgYXV0by1zZWxlY3Rp
b24NCj4gDQo+IEZyb206IEJlbmphbWluIFN6xZFrZSA8ZWd5c3plcmVneUBmcmVlbWFpbC5odT4N
Cj4gDQo+IEltcHJvdmUgIm1tY2F1dG9kZXRlY3Q9eWVzIiBib290IGRldmljZSBhdXRvLXNlbGVj
dGlvbiB0byBhYmxlIHRvDQo+IHVzZSBpdCBpZiBDT05GSUdfRU5WX0lTX05PV0hFUkUgaXMgZW5h
YmxlZCBmb3IgaS5NWDkgU29DIGFuZA0KPiBpLk1YOTMgRVZLIGJvYXJkLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQmVuamFtaW4gU3rFkWtlIDxlZ3lzemVyZWd5QGZyZWVtYWlsLmh1Pg0KPiAtLS0N
Cj4gIGFyY2gvYXJtL21hY2gtaW14L2lteDkvc29jLmMgICAgICAgICAgfCA2ICsrKysrLQ0KPiAg
Ym9hcmQvZnJlZXNjYWxlL2lteDkzX2V2ay9pbXg5M19ldmsuYyB8IDIgKy0NCj4gIGluY2x1ZGUv
Y29uZmlncy9pbXg5M19ldmsuaCAgICAgICAgICAgfCA2ICsrKysrKw0KPiAgMyBmaWxlcyBjaGFu
Z2VkLCAxMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL21hY2gtaW14L2lteDkvc29jLmMgYi9hcmNoL2FybS9tYWNoLQ0KPiBpbXgvaW14
OS9zb2MuYyBpbmRleCA3YzI4ZmEzOWUxLi43OWRkYmM3MjQxIDEwMDY0NA0KPiAtLS0gYS9hcmNo
L2FybS9tYWNoLWlteC9pbXg5L3NvYy5jDQo+ICsrKyBiL2FyY2gvYXJtL21hY2gtaW14L2lteDkv
c29jLmMNCj4gQEAgLTQyLDEyICs0MiwxNiBAQCBERUNMQVJFX0dMT0JBTF9EQVRBX1BUUjsNCj4g
DQo+ICBzdHJ1Y3Qgcm9tX2FwaSAqZ19yb21fYXBpID0gKHN0cnVjdCByb21fYXBpICopMHgxOTgw
Ow0KPiANCj4gLSNpZmRlZiBDT05GSUdfRU5WX0lTX0lOX01NQw0KPiArI2lmIENPTkZJR19JU19F
TkFCTEVEKEVOVl9JU19JTl9NTUMpIHx8DQo+ICtDT05GSUdfSVNfRU5BQkxFRChFTlZfSVNfTk9X
SEVSRSkNCj4gIF9fd2VhayBpbnQgYm9hcmRfbW1jX2dldF9lbnZfZGV2KGludCBkZXZubykgIHsN
Cj4gIAlyZXR1cm4gZGV2bm87DQo+ICB9DQo+IA0KPiArI2lmbmRlZiBDT05GSUdfU1lTX01NQ19F
TlZfREVWDQo+ICsjZGVmaW5lIENPTkZJR19TWVNfTU1DX0VOVl9ERVYgMA0KPiArI2VuZGlmDQo+
ICsNCj4gIGludCBtbWNfZ2V0X2Vudl9kZXYodm9pZCkNCj4gIHsNCj4gIAlpbnQgcmV0Ow0KPiBk
aWZmIC0tZ2l0IGEvYm9hcmQvZnJlZXNjYWxlL2lteDkzX2V2ay9pbXg5M19ldmsuYw0KPiBiL2Jv
YXJkL2ZyZWVzY2FsZS9pbXg5M19ldmsvaW14OTNfZXZrLmMNCj4gaW5kZXggMzQxODMxYTdkMy4u
YzkxNzFkZjMzMCAxMDA2NDQNCj4gLS0tIGEvYm9hcmQvZnJlZXNjYWxlL2lteDkzX2V2ay9pbXg5
M19ldmsuYw0KPiArKysgYi9ib2FyZC9mcmVlc2NhbGUvaW14OTNfZXZrL2lteDkzX2V2ay5jDQo+
IEBAIC01OCw3ICs1OCw3IEBAIGludCBib2FyZF9pbml0KHZvaWQpDQo+IA0KPiAgaW50IGJvYXJk
X2xhdGVfaW5pdCh2b2lkKQ0KPiAgew0KPiAtI2lmZGVmIENPTkZJR19FTlZfSVNfSU5fTU1DDQo+
ICsjaWYgQ09ORklHX0lTX0VOQUJMRUQoRU5WX0lTX0lOX01NQykgfHwNCj4gK0NPTkZJR19JU19F
TkFCTEVEKEVOVl9JU19OT1dIRVJFKQ0KPiAgCWJvYXJkX2xhdGVfbW1jX2Vudl9pbml0KCk7DQo+
ICAjZW5kaWYNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2NvbmZpZ3MvaW14OTNfZXZrLmgg
Yi9pbmNsdWRlL2NvbmZpZ3MvaW14OTNfZXZrLmgNCj4gaW5kZXggNTNmYjhjOWIxYi4uMmE5NTk1
YTI2MSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9jb25maWdzL2lteDkzX2V2ay5oDQo+ICsrKyBi
L2luY2x1ZGUvY29uZmlncy9pbXg5M19ldmsuaA0KPiBAQCAtMjcsNiArMjcsMTIgQEANCj4gICNk
ZWZpbmUgQk9PVEVOVg0KPiAgI2VuZGlmDQo+IA0KPiArI2lmIENPTkZJR19JU19FTkFCTEVEKEVO
Vl9JU19OT1dIRVJFKQ0KPiArI2lmbmRlZiBDT05GSUdfU1lTX01NQ19FTlZfREVWDQo+ICsjZGVm
aW5lIENPTkZJR19TWVNfTU1DX0VOVl9ERVYgMA0KPiArI2VuZGlmDQo+ICsjZW5kaWYNCj4gKw0K
PiAgLyogSW5pdGlhbCBlbnZpcm9ubWVudCB2YXJpYWJsZXMgKi8NCj4gICNkZWZpbmUgQ0ZHX0VY
VFJBX0VOVl9TRVRUSU5HUwkJXA0KPiAgCUJPT1RFTlYgXA0KPiAtLQ0KPiAyLjQ3LjAud2luZG93
cy4xDQoNClJldmlld2VkLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCg0K
