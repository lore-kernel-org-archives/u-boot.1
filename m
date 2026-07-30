Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FEBC54FDF
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 09:33:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6F8D80E66;
	Thu, 30 Jul 2026 09:33:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ip1QWPWy_E0N; Thu, 30 Jul 2026 09:33:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8673580E73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785403984;
	bh=S9Gb+ETBEoJbYBZk3OsU+JUEvKPpe0pwOqhg0JtfXw4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OYUsZl7hjO+4DKNugP6PiS/o8gaW9L9FDwDgFwlS7WrsJ/taVK7We538UlnsjwW9j
	 mN1y44kiYST3IKqFu0XvwhDzIKr7/KcmVeGHiaXaxwVKoftg0bfVSirnerUciD8NyL
	 5MUxIDlRx18Sumw9f54+cTNu5TTJ5h7N0emWSm6ai+TjLuXLqRhfTs2frgoXd6x2oI
	 DEKnLEMNdt41nyQmEaWesk4hYP4kKvGSCmVgm/sjxY9nLol3n6UcenX97Z4yYvO9NK
	 Mx/y26qBRt/u0nNSWR76D2TMoWROBP6v3wTm61xwponOyOYlLobDwmWIxGMWCfjkOo
	 ATT2LXAqjUrzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8673580E73;
	Thu, 30 Jul 2026 09:33:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 59460352
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:33:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B5CA40877
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:33:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jdfpjIVP2862 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 09:33:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=y.moog@phytec.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 660EC407C9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 660EC407C9
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 660EC407C9
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:33:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98CD88498B; Thu, 30 Jul 2026 11:32:59 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 625978063E
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 11:32:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDhQenrU15PC5mMdYF2v5lxj4WublnaorRaXVWHHxOYF9HlNwbNLCoJkB3FpgFEwACS/upydgK/TEQflVTDkEnIgEMrF6bKyi8HXnohjqilCquoK8zv6RhuiO9wHD/m60OuvqUovjSi3z60Y4vRcJmm/L07xwJcQTrUaTzm84t9YryK0LrMx5NzZD2stdO678h93ttV+/cOZ42GEbgCz3GJQ4/gefDWYzl8jNbbPU5X5ySvZIaHljSKSMfMQwcfsxGZn1VjBkPb9c0qPeLJmdttOCpID8ls/91W8/DyepLMNbbfrj5K2bOXVW8G9XcypOMBF6roSZ+ImoaaEbsJUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9Gb+ETBEoJbYBZk3OsU+JUEvKPpe0pwOqhg0JtfXw4=;
 b=XBe8wkMTUZSdXW1dnVGhUhx0ojdDrpjCVdiPeAuj27Y6bH3OxNS1+maBSDBKWyyNMf/pifnb6IfsKa+xC7/zxGXaMPe6zqTMaKHt3X1Fk4BWn6TMo01yVRghjog5J9rjZ71AfBulGbTp6vT34qR+4ThNKVn5Ck7mXH7S+7AKtahKlssapLt8rwIYU8x1x+d/72Ti6XQyZKjADKz1hicT5gL7tpV5bU/XHXEZzn8UsZNrbQj075ZWZ4/+XOo/KFwznzxh+9QFumsMMViPB5tUrghMjHbakX2j1gBU0WOxryFjSL1fd0i15ov8LJICrv6ZBUYvgzBgLi2xvhM9eMrYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by DB8P195MB0774.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:144::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 09:32:55 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7%4]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 09:32:54 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: INgo Rah <ingo.rah@linutronix.de>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Teresa Remmet <T.Remmet@phytec.de>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Benjamin Hahn <B.Hahn@phytec.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, Peng Fan
 <peng.fan@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, Gregor
 Herburger <gregor.herburger@linutronix.de>, Benedikt Spranger
 <b.spranger@linutronix.de>
Subject: Re: [PATCH v2 2/2] board: phycore_imx8mm: add 1 and 4GB RAM timings
Thread-Topic: [PATCH v2 2/2] board: phycore_imx8mm: add 1 and 4GB RAM timings
Thread-Index: AQHdD7Ake1Bxb5YILEWwfXXqtsO3NLaF7WsA
Date: Thu, 30 Jul 2026 09:32:54 +0000
Message-ID: <a668efe146a28b917f8d78cce9e27e3cb00e586d.camel@phytec.de>
References: <20260709-ram_phygate-v2-0-36f8a2f44de2@linutronix.de>
 <20260709-ram_phygate-v2-2-36f8a2f44de2@linutronix.de>
In-Reply-To: <20260709-ram_phygate-v2-2-36f8a2f44de2@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|DB8P195MB0774:EE_
x-ms-office365-filtering-correlation-id: 081b3682-58d4-4339-2fd8-08deee1d88ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|38070700021|6133799003|56012099006|4143699003|11063799006|10067099003|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info: L8hpdBw3pC3SK+Oxoe+hSpYppLcaK48gHd0f+leXgllHV7twD+OQWnzAQulhN2GjMij7aNBRjPqU1sjxyAklaIWHjcJyOcedXaxYAmziXS1nbqjfIaYmkj9CNjINFgiehJFjlXAZEXM+qP+T7YJY5nqhFN11YJOu6mO0U5bCarWKDhiJzKdGSiNX6YxlYiCvrOJ+0jCWHq5zGrbPNZcPiK8PClzZBgOXeuZOqVI6OGdhT0bpwr1o5tn2TwTKtHMN0GSjFQIq5lqbTsnxI2RBRn/ym4AipeBbPXs9ZbuhGUt+TnEZ0kLwrzCyGt1LyIWVno4/FVoCOfBNiMfUAS6WSsKC681njZyibvbhseZVEZz0Goks4FauDh9oj+CA4Zi70JJENrTRBbGCYsydZyWoCIB/YCcRl2rceo1qT+bl0bhLPDZ4IDi3e4esZB3sjQXm63UWFJmyx6VInE6SDSnCV/eS76Ep9prR5QOl4+EhDF7UdVPnK6UoMHqoIz54Sfrb17M27WA+YdSH1ilQlcnhCwbJsZ3KQSguuQ/QIbhtQra7P0LHqLHrwBBVji5T6dqakWVY+a4JdovWlgT8LjZDOxKrE41GTwhSHd/apD6zD6IzqdCh+Z33AGPdc0i4VOmjKIya1X15g06almJ+A/ooYbCiEw16TK01CgHx24kJyb0BVKYteh/pR8ZZREVtbgCwVrNw6lOlLY7khvLSnC6Ruw313FxqGStNHzOfP5IANv0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(38070700021)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFNWVmpvUW9OczN2RnZsWnZ1aTJGSGZleUJVeVEzaWF1bTBUb3dQY3hqcFQ5?=
 =?utf-8?B?N0lrVVovWTJwWVRLN2dCSFo0Y3pkTWlVZjJhbGVWem1icGpQVFcwUUZ0ODQy?=
 =?utf-8?B?UHZLZ1d1SnVBV2FGWW00QzFtREJtallWK29KaVBqY1NYeUdtNDU2SW81U1cx?=
 =?utf-8?B?VFFKUUMzV1h4ZEZCdTVvUlFoOVhudjRqZHZlelpYUkh2VERBZlVqbXQ5Zyt5?=
 =?utf-8?B?NmM0TGt4dDQ5T3BDOXZUOEo5bkxqZW05NjRRZFN2dWJ3QjdyRGJNS0VyNVdX?=
 =?utf-8?B?S1RYckZHMnRwRXgxQThqeVEyWTFHSWJuRExyRmxBRTdKaUUwRlFFcUt1eTZ3?=
 =?utf-8?B?OHcvUE5jTnhBZGQ2OTdKM2VSQ25vanJqWjQxaHJUVUtUcVcwRExqR09XYWpk?=
 =?utf-8?B?YzdvaVVGM2g4MWVjbmhUYTFVdEQ2d0E2bTRyMjdSbGVqcHh2YVE1YnZiWXN1?=
 =?utf-8?B?NHpzNW5iLzk2SHY3SDF4bElkZHBGWVI4eGRUM0dtUVBnN1Y1OEZZM1V6cURs?=
 =?utf-8?B?dTZVak5zZThXY1NRb2MrVTFFeTVIZTk1MWVxOTIySE1JdEVYa05rR3E1VStt?=
 =?utf-8?B?Ti96UG1CUmZveDB2dXN2RndXazNCL1Uyd2hiVnVyenZ3U2dLWERLbFRUbng5?=
 =?utf-8?B?WFA1SWFIQUk1NlRpY2lnakI3dThqQjhlVTkzVWdEWkcvMjlYVWQzZG1Dd3ox?=
 =?utf-8?B?YlhUU2xKZUN3Z1F5bjZnaXhaZE5wcTdnWUtBajgvNzVGS3ZlSG00WjdRdkdn?=
 =?utf-8?B?UGRzVzgwSW5XY2F3OG5ha0gySG9mY2QydXgzNmN0a3dMZGN3Q0lPOGJQVzNP?=
 =?utf-8?B?RFNzMkwvWm1rbXJ1VkdVQU9sOFMxV3Y3VkpvQnp1WmtwVzQxQWZxTW1kTG9J?=
 =?utf-8?B?Z3R1Wml4R0tyU29MYXNMc3MyZHFteGhrUllRVFFFYlVhQVljT0lBRFMyd2la?=
 =?utf-8?B?RHVhc1JDVnVoYzMxTzhCR1RkQ0EzcnZINDMrZWh5Y2FFbjFjL2owN24rd25t?=
 =?utf-8?B?SU4rbndmTDBmT2owQ09ZbldXS2xJeThqZkladGcwam1hbGQvMEdaN1dyNk5o?=
 =?utf-8?B?NnpWNHBMMW9ZeHhheWRPWHJTaVNaSVZKRVA2ak1pYzdSZzZWUGpEcmNlZ3NB?=
 =?utf-8?B?R1REQ3k4MVVtbDA2QmNQZ0NJRUcxTmh0OGFPd2lFeUpXejhUcEJBUmtqcXhh?=
 =?utf-8?B?TVB0bDgvUWtSUVUxcUl1OGdVWEk0MGlFYUJjZ3U5VXJvak13NWMzQ1U1ZkFq?=
 =?utf-8?B?WG50Q2grZzAwdnBvczJISHJYTHc2bzNhVFFFT2hiYjZ6RHcwTGFUSzh5U2JG?=
 =?utf-8?B?ZnhlY2w4WDRxeVpaRmN6TzZUYno3ZS9hakk2TmhCNzA3ZU5jRVo5bHNXNExY?=
 =?utf-8?B?K2o1Ylhvd1Bnckhnc2RDVWdEdHkrd0NCRC8rOGNBbTdaSTBtRGMxcmdvT1o2?=
 =?utf-8?B?dU83K0IrMm5BVlJuV0Vndmc0anZYUE1FcjJBSTVZUWZvY3pOb3hlWVFhN3Z1?=
 =?utf-8?B?MG53RjE1OWFXT01MdWliMnNvSVhCWjY1SlIvcjkrbUlZN3RLZ3g3cW9VSEht?=
 =?utf-8?B?ajYwWHExQXp6WllqVmRleWtSNldDbVZzeVlZZWN3WFRUdWVwOHgzc1ltemxX?=
 =?utf-8?B?ZHhqTEN2dHlDZWx2d0ZnbmFhbWJXdzRXV3k5KytEWWdJYW5qRzNzSVJYemZB?=
 =?utf-8?B?NWlyN0t4RDdudDZqT3RHeGFoTGtBZVVOT3pjSUNRT2xtZS9qTlN6S2paSWd6?=
 =?utf-8?B?Y25Mbk13SlkyOXJYWS9Xa3plSjlVUVY5ZGp1N1hKdXhaRGVUVXB4MzZLSjNw?=
 =?utf-8?B?ZUVHRGt4TUFTdVd1eml5dTBlaTYvZ1ZQZUNqQi9zbzQyNGtFc2NuSUdnWUxz?=
 =?utf-8?B?RCtGVjRLUk5qMjh1WWtXTFNRL2g1d2p0RU5tNi9hMmlYRUJocnFuby91M3Bs?=
 =?utf-8?B?dzdUNlB2RmlrZGluSlhmSGVyRVJvdXBOWm5oZFU3OFdQZE9GZ3YweHVnanhO?=
 =?utf-8?B?ZGQ2VWdjM0lwb2hjNmtIY2FoaE56SUFsWUN4V3Rqcm9SQU9vMHJvcU40M3B2?=
 =?utf-8?B?bURCalRibjBud2tQZFB6cXgzSUpmQmdVbkh0MzFUdHZyNStYTE1qUGI0SUNM?=
 =?utf-8?B?VGJuNFdBTDhtT1JMWE1JOVJxalZQamhVUnA0YWxRSCtuK2R1ZWVlaGlVY01u?=
 =?utf-8?B?UFpQYVFzaXdIbmlCUHRiZGtUSVA1ZWgyOFpOd252VGlob0tFb2sxVjYzNStE?=
 =?utf-8?B?OUwyRElTM1BuTUgrUTBLb2hrNDZyRkxPK1pFWVBZK3VlU0VwNG9CZlR1UlYz?=
 =?utf-8?Q?vEipVseT71XjPaBO5T?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2CB9D6BD415CD43908B6D0B419946D3@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 081b3682-58d4-4339-2fd8-08deee1d88ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 09:32:54.6314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3/YpEpnVPhDvmQAwXwP8WPmddeIHzDtAOpHAKlPFTNaWMN687WNXPM7xIDq6IlrwkOS/2FoNt3ArpCaR4kvFrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0774
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9Gb+ETBEoJbYBZk3OsU+JUEvKPpe0pwOqhg0JtfXw4=;
 b=PI+QAze6iTTr0ypGW4xhUxR7Dnc1F1aBdQLE9KGNhtsEjd4AxkUWHiQbxpLegTjRx30Zf1gzYEacf2Phm5vHBHxTVv/m9cUkwru0DJEgkQHfNtLa1+GISGrSz4E8BOvWPuz46cUh6TML8J+WDq2coYesopvQd5rKMoFSPji1XbZhbncdKbjqPkiAmOi5P5B1OsTrDxxThAon4xS5q9Bs4ctdjjmwwrWmU7PcVT797YzMuLD9cleZRse4b2tVeCGIxRdIjClreqvvqXda41mBBX16GKClQMtQqEK0E9kv0JonoW4a+QZUGAdNoJhH4yUMamfyqyBFZIZxaHiFqc1AVw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=phytec.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=PI+QAze6
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Y.Moog@phytec.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=phytec.de header.i=@phytec.de header.b="PI+QAze6"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

T24gVGh1LCAyMDI2LTA3LTA5IGF0IDE2OjM0ICswMjAwLCBJTmdvIFJhaCB3cm90ZToKPiBUaGUg
UGh5dGVjIFRhdXJpIEwgaXMgc29sZCB3aXRoIG11bHRpcGxlIG1lbW9yeSBjb25maWd1cmF0aW9u
cyBiZXlvbmQgdGhlCj4gYmFzZSAyIEdCIHZhcmlhbnQuIFRvIHN1cHBvcnQgdGhlc2UgYWx0ZXJu
YXRpdmUgY2FwYWNpdGllcyBzZWFtbGVzc2x5LAo+IHJlYWQgdGhlIHBoeXNpY2FsIG1lbW9yeSBz
aXplIGRpcmVjdGx5IGZyb20gdGhlIEVFUFJPTSBvZiB0aGUgdW5kZXJseWluZwo+IHBoeUNPUkUg
bW9kdWxlIGFuZCBhcHBseSB0aGUgYXBwcm9wcmlhdGUgRERSIHRpbWluZyBwYXJhbWV0ZXJzIGF0
IHJ1bnRpbWUuCj4gCj4gQWx0ZXJuYXRpdmVseSwgYSBmaXhlZCBtZW1vcnkgY29uZmlndXJhdGlv
biBjYW4gc3RpbGwgYmUgZW5mb3JjZWQgdmlhIGEKPiBkZWRpY2F0ZWQgS2NvbmZpZyBvcHRpb24g
aWYgZHluYW1pYyBkZXRlY3Rpb24gaXMgbm90IGRlc2lyZWQuCj4gCj4gTm90ZSB0aGF0IHdoaWxl
IFUtQm9vdCBjb3JyZWN0bHkgZGlzY292ZXJzIHRoZSBmdWxsIHBoeXNpY2FsIG1lbW9yeSBiYW5r
LAo+IHRoZSBkZXZpY2UgdHJlZSBleGNsdWRlcyB0aGUgbWVtb3J5IGJleW9uZCAzIEdCwqAgKGJl
bG93IHRoZSA0IEdCIGJvdW5kYXJ5KS4KPiBUaGlzIGVuc3VyZXMgdGhhdCBVLUJvb3QgYWxsb2Nh
dGlvbnMgYW5kIGVhcmx5IEVGSSBzdGFnaW5nIGJ1ZmZlcnMgcmVtYWluCj4gc2FmZSBmcm9tIDMy
LWJpdCBpbnRlcmNvbm5lY3QgRE1BIGxpbWl0YXRpb25zIGluaGVyZW50IHRvIHNvbWUgaS5NWDhN
TQo+IElQIGJsb2Nrcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBJTmdvIFJhaCA8aW5nby5yYWhAbGlu
dXRyb25peC5kZT4KPiBSZXZpZXdlZC1ieTogR3JlZ29yIEhlcmJ1cmdlciA8Z3JlZ29yLmhlcmJ1
cmdlckBsaW51dHJvbml4LmRlPgo+IFJldmlld2VkLWJ5OiBCZW5lZGlrdCBTcHJhbmdlciA8Yi5z
cHJhbmdlckBsaW51dHJvbml4LmRlPgoKUmV2aWV3ZWQtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dA
cGh5dGVjLmRlPgpUZXN0ZWQtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPgoKPiAt
LS0KPiDCoGFyY2gvYXJtL2R0cy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLXUtYm9vdC5kdHNpIHwg
MjMgKysrKysrKysrCj4gwqBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vS2NvbmZpZ8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IDY1ICsrKysrKysrKysrKysrKysrKysrKysrKysKPiDCoGJv
YXJkL3BoeXRlYy9waHljb3JlX2lteDhtbS9waHljb3JlLWlteDhtbS5jwqDCoMKgIHwgMTggKysr
KysrKwo+IMKgYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1tL3NwbC5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8IDU2ICsrKysrKysrKysrKysrKysrKysrLQo+IMKgY29uZmlncy9pbXg4
bW0tcGh5Z2F0ZS10YXVyaS1sX2RlZmNvbmZpZ8KgwqDCoMKgwqDCoMKgIHzCoCAxICsKPiDCoGlu
Y2x1ZGUvY29uZmlncy9waHljb3JlX2lteDhtbS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCA1ICstCj4gwqA2IGZpbGVzIGNoYW5nZWQsIDE2NSBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvaW14OG1tLXBoeWdhdGUt
dGF1cmktbC11LWJvb3QuZHRzaSBiL2FyY2gvYXJtL2R0cy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS0K
PiBsLXUtYm9vdC5kdHNpCj4gaW5kZXggMjYzNjE3ODBjMDEuLjQ1MmJmM2Q0MWYxIDEwMDY0NAo+
IC0tLSBhL2FyY2gvYXJtL2R0cy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLXUtYm9vdC5kdHNpCj4g
KysrIGIvYXJjaC9hcm0vZHRzL2lteDhtbS1waHlnYXRlLXRhdXJpLWwtdS1ib290LmR0c2kKPiBA
QCAtNiw2ICs2LDIxIEBACj4gwqAjaW5jbHVkZSAiaW14OG1tLXUtYm9vdC5kdHNpIgo+IMKgCj4g
wqAvIHsKPiArCXJlc2VydmVkLW1lbW9yeSB7Cj4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47Cj4g
KwkJI3NpemUtY2VsbHMgPSA8Mj47Cj4gKwkJcmFuZ2VzOwo+ICsKPiArCQkvKgo+ICsJCSAqIExp
bWl0IG1lbW9yeSB1c2FnZSBiZWxvdyB0aGUgNCBHQiAoMzItYml0KSBib3VuZGFyeS4KPiArCQkg
KiBUaGUgaS5NWDhNTSBETUEgYW5kIHBlcmlwaGVyYWxzIGNhbm5vdCBhY2Nlc3MgPjMyLWJpdAo+
ICsJCSAqIGFkZHJlc3Nlcy4gVGhpcyBwcmV2ZW50cyBhbGxvY2F0aW9uIGZhaWx1cmVzIGluIFVF
RkkgbW9kZS4KPiArCQkgKi8KPiArCQl1X2Jvb3Rfc2RtYV9zaGllbGQ6IHNkbWEtc2hpZWxkQDEw
MDAwMDAwMCB7Cj4gKwkJCXJlZyA9IDwweDEgMHgwMDAwMDAwMCAweDAgMHg0MDAwMDAwMD47Cj4g
KwkJfTsKPiArCX07Cj4gKwo+IMKgCXdkdC1yZWJvb3Qgewo+IMKgCQljb21wYXRpYmxlID0gIndk
dC1yZWJvb3QiOwo+IMKgCQl3ZHQgPSA8Jndkb2cxPjsKPiBAQCAtMjksNiArNDQsMTAgQEAKPiDC
oAl9Owo+IMKgfTsKPiDCoAo+ICsmcGluY3RybF9pMmMxIHsKPiArCWJvb3RwaC1wcmUtcmFtOwo+
ICt9Owo+ICsKPiDCoCZwaW5jdHJsX3VhcnQzIHsKPiDCoAlib290cGgtcHJlLXJhbTsKPiDCoH07
Cj4gQEAgLTczLDYgKzkyLDEwIEBACj4gwqAJYm9vdHBoLXByZS1yYW07Cj4gwqB9Owo+IMKgCj4g
KyZpMmMxIHsKPiArCWJvb3RwaC1wcmUtcmFtOwo+ICt9Owo+ICsKPiDCoCZ1c2RoYzIgewo+IMKg
CWJvb3RwaC1wcmUtcmFtOwo+IMKgfTsKPiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3BoeWNv
cmVfaW14OG1tL0tjb25maWcgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vS2NvbmZpZwo+
IGluZGV4IDA2NDQ5MTI4YmE4Li42MDljMTE1ODBjZSAxMDA2NDQKPiAtLS0gYS9ib2FyZC9waHl0
ZWMvcGh5Y29yZV9pbXg4bW0vS2NvbmZpZwo+ICsrKyBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lt
eDhtbS9LY29uZmlnCj4gQEAgLTEyLDUgKzEyLDcwIEBAIGNvbmZpZyBTWVNfQ09ORklHX05BTUUK
PiDCoGNvbmZpZyBJTVhfQ09ORklHCj4gwqAJZGVmYXVsdCAiYm9hcmQvcGh5dGVjL3BoeWNvcmVf
aW14OG1tL2lteGltYWdlLThtbS1zZC5jZmciCj4gwqAKPiArY29uZmlnIFBIWUNPUkVfSU1YOE1N
X1JBTV9TSVpFX0ZJWAo+ICsJYm9vbCAiU2V0IHBoeUNPUkUtaS5NWDhNTSBSQU0gc2l6ZSBmaXgg
aW5zdGVhZCBvZiBkZXRlY3RpbmciCj4gKwlkZWZhdWx0IGZhbHNlCj4gKwloZWxwCj4gKwnCoCBS
QU0gc2l6ZSBpcyBhdXRvbWF0aWMgYmVpbmcgZGV0ZWN0ZWQgd2l0aCB0aGUgaGVscCBvZgo+ICsJ
wqAgdGhlIEVFUFJPTSBpbnRyb3NwZWN0aW9uIGRhdGEuIFNldCBSQU0gc2l6ZSB0byBhIGZpeCB2
YWx1ZQo+ICsJwqAgaW5zdGVhZC4KPiArCj4gK2Nob2ljZQo+ICsJcHJvbXB0ICJwaHlDT1JFLWku
TVg4TU0gUkFNIHNpemUiCj4gKwlkZXBlbmRzIG9uIFBIWUNPUkVfSU1YOE1NX1JBTV9TSVpFX0ZJ
WAo+ICsJZGVmYXVsdCBQSFlDT1JFX0lNWDhNTV9SQU1fU0laRV8yR0IKPiArCWhlbHAKPiArCcKg
IFNlbGVjdCBhIGZpeGVkIFJBTSBzaXplIGluc3RlYWQgb2YgRUVQUk9NIGludHJvc3BlY3Rpb24K
PiArCcKgIGRhdGEuCj4gKwo+ICtjb25maWcgUEhZQ09SRV9JTVg4TU1fUkFNX1NJWkVfMUdCCj4g
Kwlib29sICIxR0IgUkFNIgo+ICsJaGVscAo+ICsJwqAgU2V0IFJBTSBzaXplIGZpeCB0byAxR0Ig
Zm9yIHBoeUNPUkUtaS5NWDhNTQo+ICsJwqAgaW5zdGVhZCBvZiBydW50aW1lIGRldGVjdGlvbiBm
cm9tIEVFUFJPTS4KPiArCj4gK2NvbmZpZyBQSFlDT1JFX0lNWDhNTV9SQU1fU0laRV8yR0IKPiAr
CWJvb2wgIjJHQiBSQU0iCj4gKwloZWxwCj4gKwnCoCBTZXQgUkFNIHNpemUgZml4IHRvIDJHQiBm
b3IgcGh5Q09SRS1pLk1YOE1NCj4gKwnCoCBpbnN0ZWFkIG9mIHJ1bnRpbWUgZGV0ZWN0aW9uIGZy
b20gRUVQUk9NLgo+ICsKPiArY29uZmlnIFBIWUNPUkVfSU1YOE1NX1JBTV9TSVpFXzRHQgo+ICsJ
Ym9vbCAiNEdCIFJBTSIKPiArCWhlbHAKPiArCcKgIFNldCBSQU0gc2l6ZSBmaXggdG8gNEdCIGZv
ciBwaHlDT1JFLWkuTVg4TU0KPiArCcKgIGluc3RlYWQgb2YgcnVudGltZSBkZXRlY3Rpb24gZnJv
bSBFRVBST00uCj4gKwo+ICtlbmRjaG9pY2UKPiArCj4gK2NvbmZpZyBQSFlDT1JFX0lNWDhNTV9S
QU1fU1RBVElDX1NPTV9SRVYKPiArCWJvb2wgIlNldCBzdGF0aWMgcGh5Q09SRS1pLk1YOE1NIFNv
TSByZXZpc2lvbiBmb3IgUkFNIHRpbWluZyBzZXR1cCIKPiArCWRlZmF1bHQgZmFsc2UKPiArCWhl
bHAKPiArCcKgIHBoeUNPUkUtaS5NWDhNTSBTb00gcmV2aXNpb24gNyB1c2VzIGEgdXBkYXRlZCBz
ZXQgb2Ygb3B0aW1pemVkCj4gKwnCoCBSQU0gdGltaW5ncyBjb21wYXJlZCB0byByZXZpc2lvbiA2
IGFuZCBvbGRlci4gU2V0IHRoZSBTb00KPiArCcKgIHJldmlzaW9uIGR1cmluZyBjb21waWxlIHRp
bWUgaW5zdGVhZCBvZiBiZWluZyBkZXRlY3RlZC4KPiArCj4gK2Nob2ljZQo+ICsJcHJvbXB0ICJw
aHlDT1JFLWkuTVg4TU0gUkFNIHRpbWluZyBTb00gcmV2aXNpb24gc3RhdGljIGNvbmZpZyIKPiAr
CWRlcGVuZHMgb24gUEhZQ09SRV9JTVg4TU1fUkFNX1NUQVRJQ19TT01fUkVWCj4gKwlkZWZhdWx0
IFBIWUNPUkVfSU1YOE1NX1VTRV9TT01fUkVWXzcKPiArCWhlbHAKPiArCcKgIFVzZSBhIGZpeGVk
IHJldmlzaW9uIHNldHRpbmcgaW5zdGVhZCBvZiBydW50aW1lCj4gKwnCoCBhdXRvIGRldGVjdGlv
bi4KPiArCj4gK2NvbmZpZyBQSFlDT1JFX0lNWDhNTV9VU0VfU09NX1JFVl82Cj4gKwlib29sICJS
QU0gVGltaW5ncyBmb3IgU29NIFJldmlzaW9ucyA2IGFuZCBvbGRlciIKPiArCWhlbHAKPiArCcKg
IFVzZSBvcHRpbWl6ZWQgUkFNIFRpbWluZ3MgZm9yIHBoeUNPUkUtaS5NWDhNTSBTb00gUmV2aXNp
b25zIDYKPiArCcKgIGFuZCBvbGRlciBpbnN0ZWFkIG9mIGF1dG9kZXRlY3RpbmcuCj4gKwo+ICtj
b25maWcgUEhZQ09SRV9JTVg4TU1fVVNFX1NPTV9SRVZfNwo+ICsJYm9vbCAiUkFNIFRpbWluZ3Mg
Zm9yIFNvTSBSZXZpc2lvbiA3Igo+ICsJaGVscAo+ICsJwqAgVXNlIG9wdGltaXplZCBSQU0gVGlt
aW5ncyBmb3IgcGh5Q09SRS1pLk1YOE1NIFNvTSBSZXZpc2lvbiA3Cj4gKwnCoCBpbnN0ZWFkIG9m
IGF1dG9kZXRlY3RpbmcuCj4gK2VuZGNob2ljZQo+ICsKPiDCoHNvdXJjZSAiYm9hcmQvcGh5dGVj
L2NvbW1vbi9LY29uZmlnIgo+IMKgZW5kaWYKPiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3Bo
eWNvcmVfaW14OG1tL3BoeWNvcmUtaW14OG1tLmMgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4
bW0vcGh5Y29yZS0KPiBpbXg4bW0uYwo+IGluZGV4IDlmNmE0ZWM3MDRkLi4yNWU1MWRjZTczOSAx
MDA2NDQKPiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vcGh5Y29yZS1pbXg4bW0u
Ywo+ICsrKyBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtbS9waHljb3JlLWlteDhtbS5jCj4g
QEAgLTksNiArOSw3IEBACj4gwqAjaW5jbHVkZSA8YXNtL21hY2gtaW14L2Jvb3RfbW9kZS5oPgo+
IMKgI2luY2x1ZGUgPGVudi5oPgo+IMKgI2luY2x1ZGUgPG1paXBoeS5oPgo+ICsjaW5jbHVkZSA8
aW5pdC5oPgo+IMKgCj4gwqBzdGF0aWMgaW50IHNldHVwX2ZlYyh2b2lkKQo+IMKgewo+IEBAIC01
MCwzICs1MSwyMCBAQCBpbnQgYm9hcmRfbGF0ZV9pbml0KHZvaWQpCj4gwqAKPiDCoAlyZXR1cm4g
MDsKPiDCoH0KPiArCj4gK2ludCBib2FyZF9waHlzX3NkcmFtX3NpemUocGh5c19zaXplX3QgKnNp
emUpCj4gK3sKPiArCWlmICghc2l6ZSkKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCj4gKwkvKgo+
ICsJICogY2hlY2sgdmFyaW91cyBSQU0gc2l6ZXMgKDEsIDIgYW5kIDQgR0IpIG90aGVyd2lzZQo+
ICsJICogcmV0dXJuIHRoZSBkZWZhdWx0IG9mIDJHQgo+ICsJICovCj4gKwkqc2l6ZSA9IGdldF9y
YW1fc2l6ZSgodm9pZCAqKVBIWVNfU0RSQU0sCj4gKwkJCcKgwqDCoMKgIChsb25nKVBIWVNfU0RS
QU1fU0laRSArIFBIWVNfU0RSQU1fMl9TSVpFKTsKPiArCWlmICgqc2l6ZSA9PSAwKQo+ICsJCSpz
aXplID0gU1pfMkc7Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gK30KPiBkaWZmIC0tZ2l0IGEvYm9hcmQv
cGh5dGVjL3BoeWNvcmVfaW14OG1tL3NwbC5jIGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1t
L3NwbC5jCj4gaW5kZXggZTY4ODc5M2JjNzQuLmEzODc5ODgxZWI3IDEwMDY0NAo+IC0tLSBhL2Jv
YXJkL3BoeXRlYy9waHljb3JlX2lteDhtbS9zcGwuYwo+ICsrKyBiL2JvYXJkL3BoeXRlYy9waHlj
b3JlX2lteDhtbS9zcGwuYwo+IEBAIC0xNiwxMSArMTYsMTkgQEAKPiDCoCNpbmNsdWRlIDxsb2cu
aD4KPiDCoCNpbmNsdWRlIDxzcGwuaD4KPiDCoAo+ICsjaW5jbHVkZSAibHBkZHI0X3RpbWluZy5o
Igo+IMKgI2luY2x1ZGUgIi4uL2NvbW1vbi9pbXg4bV9zb21fZGV0ZWN0aW9uLmgiCj4gwqAKPiDC
oCNkZWZpbmUgRUVQUk9NX0FERFIJCTB4NTEKPiDCoCNkZWZpbmUgRUVQUk9NX0FERFJfRkFMTEJB
Q0sJMHg1OQo+IMKgCj4gK2VudW0gcGh5dGVjX2lteDhtbV9kZHJfZWVwcm9tX2NvZGUgewo+ICsJ
SU5WQUxJRCA9IFBIWVRFQ19FRVBST01fSU5WQUwsCj4gKwlQSFlURUNfSU1YOE1NX0REUl8xR0Ig
PSAxLAo+ICsJUEhZVEVDX0lNWDhNTV9ERFJfMkdCID0gMywKPiArCVBIWVRFQ19JTVg4TU1fRERS
XzRHQiA9IDUsCj4gK307Cj4gKwo+IMKgaW50IHNwbF9ib2FyZF9ib290X2RldmljZShlbnVtIGJv
b3RfZGV2aWNlIGJvb3RfZGV2X3NwbCkKPiDCoHsKPiDCoAlzd2l0Y2ggKGJvb3RfZGV2X3NwbCkg
ewo+IEBAIC00MiwxNyArNTAsNjMgQEAgaW50IHNwbF9ib2FyZF9ib290X2RldmljZShlbnVtIGJv
b3RfZGV2aWNlIGJvb3RfZGV2X3NwbCkKPiDCoHN0YXRpYyB2b2lkIHNwbF9kcmFtX2luaXQodm9p
ZCkKPiDCoHsKPiDCoAlpbnQgcmV0Owo+ICsJZW51bSBwaHl0ZWNfaW14OG1tX2Rkcl9lZXByb21f
Y29kZSBzaXplID0gUEhZVEVDX0VFUFJPTV9JTlZBTDsKPiArCXU4IHJldiA9IFBIWVRFQ19FRVBS
T01fSU5WQUw7Cj4gwqAKPiDCoAlyZXQgPSBwaHl0ZWNfZWVwcm9tX2RhdGFfc2V0dXBfZmFsbGJh
Y2soTlVMTCwgMCwgRUVQUk9NX0FERFIsCj4gwqAJCQlFRVBST01fQUREUl9GQUxMQkFDSyk7Cj4g
LQlpZiAocmV0KQo+ICsJaWYgKHJldCAmJiAhSVNfRU5BQkxFRChDT05GSUdfUEhZQ09SRV9JTVg4
TU1fUkFNX1NJWkVfRklYKSkKPiDCoAkJZ290byBvdXQ7Cj4gwqAKPiDCoAlyZXQgPSBwaHl0ZWNf
aW14OG1fZGV0ZWN0KE5VTEwpOwo+IMKgCWlmICghcmV0KQo+IMKgCQlwaHl0ZWNfcHJpbnRfc29t
X2luZm8oTlVMTCk7Cj4gwqAKPiArCWlmIChJU19FTkFCTEVEKENPTkZJR19QSFlDT1JFX0lNWDhN
TV9SQU1fU0laRV9GSVgpKSB7Cj4gKwkJaWYgKElTX0VOQUJMRUQoQ09ORklHX1BIWUNPUkVfSU1Y
OE1NX1JBTV9TSVpFXzFHQikpCj4gKwkJCXNpemUgPSBQSFlURUNfSU1YOE1NX0REUl8xR0I7Cj4g
KwkJZWxzZSBpZiAoSVNfRU5BQkxFRChDT05GSUdfUEhZQ09SRV9JTVg4TU1fUkFNX1NJWkVfMkdC
KSkKPiArCQkJc2l6ZSA9IFBIWVRFQ19JTVg4TU1fRERSXzJHQjsKPiArCQllbHNlIGlmIChJU19F
TkFCTEVEKENPTkZJR19QSFlDT1JFX0lNWDhNTV9SQU1fU0laRV80R0IpKQo+ICsJCQlzaXplID0g
UEhZVEVDX0lNWDhNTV9ERFJfNEdCOwo+ICsJfSBlbHNlIHsKPiArCQlzaXplID0gcGh5dGVjX2dl
dF9pbXg4bV9kZHJfc2l6ZShOVUxMKTsKPiArCX0KPiArCj4gKwlpZiAoSVNfRU5BQkxFRChDT05G
SUdfUEhZQ09SRV9JTVg4TU1fUkFNX1NUQVRJQ19TT01fUkVWKSkgewo+ICsJCWlmIChJU19FTkFC
TEVEKENPTkZJR19QSFlDT1JFX0lNWDhNTV9VU0VfU09NX1JFVl82KSkKPiArCQkJcmV2ID0gNjsK
PiArCQllbHNlIGlmIChJU19FTkFCTEVEKENPTkZJR19QSFlDT1JFX0lNWDhNTV9VU0VfU09NX1JF
Vl83KSkKPiArCQkJcmV2ID0gNzsKPiArCX0gZWxzZSB7Cj4gKwkJcmV2ID0gcGh5dGVjX2dldF9y
ZXYoTlVMTCk7Cj4gKwl9Cj4gKwo+ICsJaWYgKHJldiA+PSA3IHx8IHJldiA9PSBQSFlURUNfRUVQ
Uk9NX0lOVkFMKSB7Cj4gKwkJZGVidWcoIiVzOiBVc2luZyByZXY3IFJBTSB0aW1pbmdzLlxuIiwg
X19mdW5jX18pOwo+ICsJCXNldF9kcmFtX3RpbWluZ3NfcmV2NygpOwo+ICsJfSBlbHNlIHsKPiAr
CQlkZWJ1ZygiJXM6IFVzaW5nIHJldjYgUkFNIHRpbWluZ3MuXG4iLCBfX2Z1bmNfXyk7Cj4gKwl9
Cj4gKwo+ICsJc3dpdGNoIChzaXplKSB7Cj4gKwljYXNlIFBIWVRFQ19JTVg4TU1fRERSXzFHQjoK
PiArCQlzZXRfZHJhbV90aW1pbmdzXzFnYigpOwo+ICsJCWJyZWFrOwo+ICsJY2FzZSBQSFlURUNf
SU1YOE1NX0REUl8yR0I6Cj4gKwkJYnJlYWs7Cj4gKwljYXNlIFBIWVRFQ19JTVg4TU1fRERSXzRH
QjoKPiArCQlzZXRfZHJhbV90aW1pbmdzXzRnYigpOwo+ICsJCWJyZWFrOwo+ICsJZGVmYXVsdDoK
PiArCQlnb3RvIG91dDsKPiArCX0KPiArCWRkcl9pbml0KCZkcmFtX3RpbWluZyk7Cj4gKwo+ICsJ
cmV0dXJuOwo+IMKgb3V0Ogo+ICsJcHV0cygiQ291bGQgbm90IGRldGVjdCBjb3JyZWN0IFJBTSBz
aXplLiBGYWxsIGJhY2sgdG8gZGVmYXVsdC5cbiIpOwo+ICsJc2V0X2RyYW1fdGltaW5nc19yZXY3
KCk7Cj4gwqAJZGRyX2luaXQoJmRyYW1fdGltaW5nKTsKPiDCoH0KPiDCoAo+IGRpZmYgLS1naXQg
YS9jb25maWdzL2lteDhtbS1waHlnYXRlLXRhdXJpLWxfZGVmY29uZmlnIGIvY29uZmlncy9pbXg4
bW0tcGh5Z2F0ZS10YXVyaS1sX2RlZmNvbmZpZwo+IGluZGV4IDlkYzdmZTIxODIwLi4zYWU5MmZm
MDlmNiAxMDA2NDQKPiAtLS0gYS9jb25maWdzL2lteDhtbS1waHlnYXRlLXRhdXJpLWxfZGVmY29u
ZmlnCj4gKysrIGIvY29uZmlncy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sX2RlZmNvbmZpZwo+IEBA
IC00LDYgKzQsNyBAQCBDT05GSUdfVEVYVF9CQVNFPTB4NDAyMDAwMDAKPiDCoENPTkZJR19TWVNf
TUFMTE9DX0xFTj0weDIwMDAwMDAKPiDCoENPTkZJR19TUExfR1BJTz15Cj4gwqBDT05GSUdfU1BM
X0xJQkNPTU1PTl9TVVBQT1JUPXkKPiArQ09ORklHX1BIWVRFQ19TT01fREVURUNUSU9OPXkKPiDC
oENPTkZJR19FTlZfU0laRT0weDEwMDAwCj4gwqBDT05GSUdfRU5WX09GRlNFVD0weDNDMDAwMAo+
IMKgQ09ORklHX0RNX0dQSU89eQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2NvbmZpZ3MvcGh5Y29y
ZV9pbXg4bW0uaCBiL2luY2x1ZGUvY29uZmlncy9waHljb3JlX2lteDhtbS5oCj4gaW5kZXggMjBl
MmFiODMyZWUuLmQ0NTcxY2M2ZjM5IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvY29uZmlncy9waHlj
b3JlX2lteDhtbS5oCj4gKysrIGIvaW5jbHVkZS9jb25maWdzL3BoeWNvcmVfaW14OG1tLmgKPiBA
QCAtMjgsNiArMjgsNyBAQAo+IMKgI2RlZmluZSBDRkdfU1lTX1NEUkFNX0JBU0UJCTB4NDAwMDAw
MDAKPiDCoAo+IMKgI2RlZmluZSBQSFlTX1NEUkFNCQkJMHg0MDAwMDAwMAo+IC0jZGVmaW5lIFBI
WVNfU0RSQU1fU0laRcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNaXzJHIC8qIDJH
QiBERFIgKi8KPiAtCj4gKyNkZWZpbmUgUEhZU19TRFJBTV9TSVpFwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKFNaXzJHICsgU1pfMUcpIC8qIDNHQiAqLwo+ICsjZGVmaW5lIFBIWVNf
U0RSQU1fMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MTAwMDAwMDAw
Cj4gKyNkZWZpbmUgUEhZU19TRFJBTV8yX1NJWkXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgU1pfMUcgLyogNEdCIEREUiAqLwo+IMKgI2VuZGlmIC8qIF9fUEhZQ09SRV9JTVg4TU1fSCAq
Lwo=
