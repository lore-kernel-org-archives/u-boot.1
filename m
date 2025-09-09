Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00665CAC583
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 11:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2960F83106;
	Tue,  9 Sep 2025 13:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="SCJlDRR7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F0048312A; Tue,  9 Sep 2025 13:12:39 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::706])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CCB9830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 13:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S93IZ8kWvLQ25MFiSUmrcvHKIipub6GUfPlN+hCKU20N2gYjsSb3cXqSFycT1QPjj8HKuv5P3RfSoOlkmkOd1Eusk62zK0QI5KZPupYRNWEYpoJByAKmiwMSJaBblC21oz2AmRYgae2jQPU56KsSJwgv14Avn5JKM/MjZNEwR0p+GJqzB3eDbRwitx7j3hikHmu6uzc1xNnu/aSoyvn0jUPGAmEIPvOtwqFVkthqDKWDSLTgFCtaklR9n1by55/XBaR2G1golVYZ5sd11Ad+24KU/ivNGmyBqXZHq9ALH3gj+kKOkvhN8QCgqnBfmeWDBP70XYsa4S42c1l9JzOKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlTTqzrfp64hX6RtYrOt2TB+SpDg8QeiOhLMPd9w4Dg=;
 b=U2SdohskT+ZIOPvW4nRzuapmb54z4OmFusopQnuyyUVtGXH8IUfw68BhFwTMC2aul5fUEKpdZaDChpATzcSrEK/ydLvSG3dOY+2zhNa1Sk/qfDUQoqOKa5NcceiUAcBLO3waC7yAphwSOF78++ELQ1begILXYfD0BADJFKDCTzxXFV4mwpEH4nWdp9mNL2JUR5fk2sgDkyQ/2BHzEPYhlo52WSMsG+EcaxZhZvJLcnGHoern1wwQQxck50CH8x9/jHj7POz4xymUxY1opxOrhLgODrMqcH2a8apNaCTUcrPU/7TjA/fzRBN3e5gpRtx+Lh/+zX0jdqs/c6SGxnnfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlTTqzrfp64hX6RtYrOt2TB+SpDg8QeiOhLMPd9w4Dg=;
 b=SCJlDRR7haHIG4n8v29+HhTilbhTH0bhpXPlXqGSrcUUZ+ZKuXTrJXMvi2yrKEeH6JWx+j/DyrgU/GXs+bkgTNfeOltKvUt/FzWKYZXnxL3N7+bDRHskqFn4J8oRqFMT423smhb0vqzL+bIazvxUjh5Bsry5NRQ4VelgItC8ou/tGdcctIEOsGnLt+nrVqfC0r13V7ZoVc0UehYFVxLqD0H+5sXQlighg0oe4JeMu7cLSFKvuKYhQzqlENIaugI3Ok2gtZQxuvzmjE/OMeHAscUlI+q1CzsvMq6L/Ka3l/hPwhqjf6k9hVN+0SCNT/l/5FcmwJlZXXai+SpG9Is90g==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by AS2P195MB2133.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:545::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:12:29 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 11:12:28 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Jerome Forissier <jerome.forissier@linaro.org>, Tom Rini
 <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, Teresa Remmet
 <T.Remmet@phytec.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, Yashwanth
 Varakala <Y.Varakala@phytec.de>, Jan Remmet <J.Remmet@phytec.de>
Subject: Re: [PATCH v3 3/3] doc: phytec: imx8m: Style and firmware update
Thread-Topic: [PATCH v3 3/3] doc: phytec: imx8m: Style and firmware update
Thread-Index: AQHcIIqbmVf/U4JkekmJXuFaLf0mCrSKn2cAgAAUxQA=
Date: Tue, 9 Sep 2025 11:12:28 +0000
Message-ID: <bd26f72ce7e0676c81d829aaef335aa4e60f582a.camel@phytec.de>
References: <20250908-imx8m-optee-enable-v3-0-14bfe249b3c6@phytec.de>
 <20250908-imx8m-optee-enable-v3-3-14bfe249b3c6@phytec.de>
 <c2da0d18-9ce0-4c0f-8495-977ad7d8ca5b@linaro.org>
In-Reply-To: <c2da0d18-9ce0-4c0f-8495-977ad7d8ca5b@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|AS2P195MB2133:EE_
x-ms-office365-filtering-correlation-id: 1fd3bd7b-1148-4767-d182-08ddef91c3a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ajFSN3M2L0hCUkhiOUlUR2U1ajVJS2R0WHJDS055bENPSTRMUzNuUkZ0K0pZ?=
 =?utf-8?B?OExTdTU4N2dVcldnSmFueEhTRlZRbGNJdUtJamRWK2wrM2xHLzljNGp0SXR1?=
 =?utf-8?B?WmxOTktSeFJWVVlPakRua3lOQ2pqQThkc0xOWmJEbnVRYUliVkpwdlJxRlM4?=
 =?utf-8?B?UVZpbkczemc0QldmUHNGcHFSWlppdzd3UjRPK2c5VUpQVnpPbk5HTXlCNkVy?=
 =?utf-8?B?RzhLTWxXbnRjTkRRSUM0dW1PWkxWa1dQQm9RODVkMXlTZXZOWnpRbFVnd0dR?=
 =?utf-8?B?aDBQMG9qRjFFQm1YbGwraWlaS0tsQkJONHdyd3BxY2hGZlpHWGN1QjgzamZS?=
 =?utf-8?B?ejN4MlA5b2FnTkF1eUpCeDR0VndRVW5PUVhJaUdBbzNZODc4dk9pUHlaOGti?=
 =?utf-8?B?NW41a1pQNXR2RndydlplaU1LWG5Delo0b0p1MnFyK0VyQ1lOZzhsTnlSeDMx?=
 =?utf-8?B?cjZFakNXWDF0MVdjNmUzL2Z1OEY0WnlsY0dIeVhtcm9iaGhlY0ZRbE9DanhZ?=
 =?utf-8?B?Nk9TNXpDcWxFMFhiRXZmbVRkZDE2bVB5SUVGR3d1ZUpVaC9yQ2Z5L1ZPYU9r?=
 =?utf-8?B?R0QzWEVId0E4SzZxV25GaiszM01IRzZCSzFvUUEwQlAzTnNnZFZOekxvQWF2?=
 =?utf-8?B?YkduczJkNVZvek96amxzMXR1dnVwL1oxWDB4bHBCQStnMEFnUm15bWpHTCt5?=
 =?utf-8?B?c3lvdHdrdWtHMEZNdGlGeTZacU1RaUJKekVaREI1eHEvVW5sMWQ2d1FBaFU5?=
 =?utf-8?B?OXZQSmRtMmdhOU9NVHliRkxaUGRpU24wRG1TcDJ3ZHB5KzZLOFRNSDREZitQ?=
 =?utf-8?B?L2ZsOHdDKzkzMHZlK2xNaFhJZlM3akRCcHZoVGZmK1psM1pLTm1lVjVPS1k5?=
 =?utf-8?B?d1BhdGN3WmxTNjFDM1NWcEhXV05mM2pFUkRxcUdKTmNyM1RtRnozR3pscGR5?=
 =?utf-8?B?U3dqMEE4bnFsdU1Nclo1MnNycEFxMW5hUllOMTY1L0Y4MktXMFFVUm9kUGcw?=
 =?utf-8?B?WFZLU2x4TzBDUkt2QlBtTUwvcjY4U3NrMFhLSUtNdVByK3FsbUNtSlN1Tlhz?=
 =?utf-8?B?cTNNR1FrUjljYldRSUg1bkdFUVpBT2pEL3A3a01GMS9kTkcxcTJETk1EVEYw?=
 =?utf-8?B?S3FZWDdndE0vVWlpYTNMV1lpNmhZR1NGakxHY0FRTVhJVWtYajFhVlExc0E2?=
 =?utf-8?B?Szl4V2dDdEx0TXRTb2R6dEh1UEwwdHd6TkphSE85QkllMy8yZXc0VW5EalRq?=
 =?utf-8?B?NDFlWWF0dmIrMkNkTXlpbXJ4T29vUjRWeWJiTHhsdzY1NVQ1N0FqTGlEY3d3?=
 =?utf-8?B?TVlUWjk3ZC9hY1ZTQWNYb0tHamVKaG9FdkhJVGc0NXcrUnRqcGxsWHFOS2JK?=
 =?utf-8?B?RW5TTXlrOHRRRkVraFBWd1hKSDlKRFNVci9vRmtNK0dHS2gxSDQ5WTVVeGtV?=
 =?utf-8?B?d0dkeCt0Ty9RMmNTY3lMMHp3Wjc0R0Y3cFVHd1NDQ1RqMzNnSXFrVmNzWkFO?=
 =?utf-8?B?eEN4SlNnbVh0VFZEZkxLNHZQR0w5MS9KN3Z4TmFPaTdJM1QwMVEwaTQ4VHBz?=
 =?utf-8?B?ejBLK1p6NFVocGRHK0JBYmkvQm5NWG9TTWpMdzdxN0ZuUnlDaEtDNXpvd3hh?=
 =?utf-8?B?cVIweUFJYVZGYnhlQXVGVlZFR2J3YU4yeGxYWTJzcnVRTW5yRndLQUo0QURo?=
 =?utf-8?B?YVZ6MUJTU3MyTDdMaFhPekFQTHlmeUxpZW1JSVlldzZzMUtQaUMwSWR6UEsv?=
 =?utf-8?B?dHJGK0N6M2NRWXgrZlRaMjlYRkh4WXR1dXF0VGZ2KzhYMzRwbzVVZHRhZTFQ?=
 =?utf-8?B?KzRNblpJREd0TVF0NlIwZHFSL1NKVTBLQlIzcmU2Zi9aMEg5M1p0TkRzeDBm?=
 =?utf-8?B?dVp2ejVuTFh1SHIvY1lETkp2OWpBNE9xKzVBUjE4d3pqUDJwK0VHNFVFb1hO?=
 =?utf-8?Q?dR5ETAavoOvc6GDUTbIARMTJYHlQ2edE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE9wQlZGWGxDeC9ka2NqdFFFbVpPZUhhUytJUTRlcUpLWUhlT0pXUkNIcXdt?=
 =?utf-8?B?anFqbmVZTXpPNFVTeXlWSFhRdCtZa1FrRjRQQmlOQlVieVJvNW1yTkc2Mnpl?=
 =?utf-8?B?bTlROCtOendjVTk0L0NSZzA3YkJEVWl4WnRVcnR0UmZpaEp1bXBqTWJIMkta?=
 =?utf-8?B?Z0VsRFZkWGl6OGduVFYyU1RGQmVTd1daYWRhOHprUHlKdVJaYTZzcDVrNllL?=
 =?utf-8?B?VjRXVGllNk02NXM3eFhmRnNUaW4vSEIvWVBVL2pJSjAyUERKb2ZZaUQ1Qmdw?=
 =?utf-8?B?dTJSSWFoUENGU1BTaWIrTExkK1lNa08wbnlVMU5CNEdqbmJDMFBrR2VMdHps?=
 =?utf-8?B?b3FZRklwUVZUK1dpS3F4ZUc5SWowb0xGcXhoUDBoOC9EOXFRcU9Ed3lENTJJ?=
 =?utf-8?B?c0I0MXJsZXU3K1RUbzQwc1RxTWFEeHRINTRSTnpLYlc0d3dtTVh2TlRnRVVj?=
 =?utf-8?B?Um53UkZoRFZJSEozQXk2T25YUzlqQ2pKRit5QVRIKzRXcitWbmVOeXI3bkJz?=
 =?utf-8?B?dUZwOEZXaEJTcW1QY1ZlTUNXczBmMW51Q1ZGTXgrSE02S09weTl4WHZldVJv?=
 =?utf-8?B?b0dXK3h1OGhzcTJ6WjBOKzRia3hzOXJjSkVvTXM0V292NU53QWp6eC9ieEdJ?=
 =?utf-8?B?SnEwL0luVTJwTlJvMkFTK1JKbWZQdktjcHE4TzBtaVVGVkE0V1Nod3FpSFBX?=
 =?utf-8?B?Mkk1eEdIazA3M0FMUXNFMktRQ0JtY1JTdTQ1WjNneUJkc0V3S2kxT0J4SVF3?=
 =?utf-8?B?UU1yZytWUnkwQ0ZKQzlYbW5RMnNQNGpUbzFQSFo4V2d1Zk44akhKZFNHdndD?=
 =?utf-8?B?alJEQy8rdTIrM0xpMGV2NW81emx4Z3JtYnN5R1g2YUM3eXl2aGJGOEZuYmtx?=
 =?utf-8?B?dTQvWHhkeklxcGZmdlk4T2VyazlHb0VpQ2RFc2lvK1ltZlF4Qis4UWRUU2tM?=
 =?utf-8?B?VDZna0JNanlqc1o0WGw3WUVSRlZMNnptcFRTUllKeGVRbmlMVlZGRTh4Z1BO?=
 =?utf-8?B?RGJqNzVpdW9pOHZtNXZxTm9lN1BpbEdsVm1aSFM4ZlVHcHQ1UEo0REcxVGZF?=
 =?utf-8?B?eTVnemJBVk11SE1SN2tlOTV0THpjWnI1eEt2aHNYd1hqYnBqV29oN1pWaitn?=
 =?utf-8?B?V1lad1I2dlBVSytZMXQ3ZEQ1UEVUS3hjczdjZkJJNHFhNUtmS0daUU5iNEdR?=
 =?utf-8?B?azVUa0MrN3FVQzZTNWh0WTJNMDVhZW9UY0lDUm8vN1plN0hTTkxIMmxGdk9l?=
 =?utf-8?B?RDVqNHo2dWd6aVEzenkyTzJiYVRvT2JJQXMwYmJ2Qlh3bDJKbWlua0FLWjRM?=
 =?utf-8?B?SW0rZEdPTGUrZW05THErNUkxWlZsZUNZOWxIcFRUYWplMWZ3cUtuOW10MlNW?=
 =?utf-8?B?WWlsVmZPekxxTUpsYi9MdENyV0NNQlFnMVd0WnQ4QjJDSm8vMHcyZUtLMG9k?=
 =?utf-8?B?MDc1M0ZJdDJZZER6Q1lUeEU0amVzcXRiaDEwZTlZUzM4K3h6aXFvL1BMbnZk?=
 =?utf-8?B?MW5BNnJsU0plY293eDZLc1ZmOVcycVVWa2RuNU5xbmNsYk1ocy9sZ0wyUXpD?=
 =?utf-8?B?ZWZsL0lvbmNSWnNEYWE1a05FdmtaMDMrUmVjMHZQUk5nQ1FXbTZPbTM5Ylp0?=
 =?utf-8?B?TXZVUFJOM1UvKzI2cGVGTkR2UUx5UjZub0lvRFl6djRHTzlsY01hb1RSTjBt?=
 =?utf-8?B?bUEzSDhxOVprcXBrWnIyU3Zicm5saS9KQ0owdEFiLzJTaHZJNU9yV2V2RkJT?=
 =?utf-8?B?UzBya2liMHBmdXFEWUxrN2VOeVNVSGRBNERkbXJFb2VKcUtILzZXOFBWV002?=
 =?utf-8?B?TnRid2ZpN0w4clVEYThYNXB0M2gxRGl5dGcrTk1ueS93VTV2T1pZdFVFTGVa?=
 =?utf-8?B?NUwrcWtSN3Q4Skw2MTh5RUs5ZFlDUmxvV2hKWERvWVdPNTdhT0RibWhZdFFH?=
 =?utf-8?B?MGZSb2lXZkQvbEVVY05vczRHSklWb3VjRkIvYWlZQmhlQ2FYaGx3Vmg4VDM5?=
 =?utf-8?B?VE9TL052VTFjcEUzY00wQTRvc3RqSGJFcldGS293SHNQdG9RMHg4ZFhZK2o4?=
 =?utf-8?B?VzFTMldVcjk5UklpWFpKaUhWVVBUZGN5U1E5VUVGUjNWWGY2eldQZC82Zkpm?=
 =?utf-8?Q?Wqak=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1837C73510A18340AD2EEC594FB4773C@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd3bd7b-1148-4767-d182-08ddef91c3a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 11:12:28.7634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D99e9nwYlQrfddVcgSR34C9mONX4pcPXny7mludnJy6da8j2jEb4r48vUvOrV6HTHGdYlfQWRtmI0Mc3vd+Kuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2133
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

SGkgSmVyb21lLAoKQW0gRGllbnN0YWcsIGRlbSAwOS4wOS4yMDI1IHVtIDExOjU4ICswMjAwIHNj
aHJpZWIgSmVyb21lIEZvcmlzc2llcjoKPiBIaSBZYW5uaWMsCj4gCj4gT24gOS84LzI1IDA4OjM0
LCBZYW5uaWMgTW9vZyB3cm90ZToKPiA+IFVzZSBzaW5nbGUgbWFrZSBjb21tYW5kIGZvciBjb21w
aWxpbmcgYmxvYnMgYW5kIFUtQm9vdC4KPiA+IFVwZGF0ZSB0aGUgaW14IGZpcm13YXJlIHZlcnNp
b24uCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRl
Pgo+ID4gLS0tCj4gPiDCoGRvYy9ib2FyZC9waHl0ZWMvaW14OG1tLXBoeWdhdGUtdGF1cmktbC5y
c3QgfCAyNyArKysrKysrKysrKysrKy0tLS0tLS0tCj4gPiDCoGRvYy9ib2FyZC9waHl0ZWMvcGh5
Y29yZS1pbXg4bW0ucnN0wqDCoMKgwqDCoMKgwqDCoCB8IDI4ICsrKysrKysrKysrKysrLS0tLS0t
LS0KPiA+IMKgZG9jL2JvYXJkL3BoeXRlYy9waHljb3JlLWlteDhtcC5yc3TCoMKgwqDCoMKgwqDC
oMKgIHwgMzYgKysrKysrKysrKysrKysrKystLS0tLS0tLS0KPiA+IC0tLQo+ID4gwqAzIGZpbGVz
IGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDM1IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZm
IC0tZ2l0IGEvZG9jL2JvYXJkL3BoeXRlYy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLnJzdAo+ID4g
Yi9kb2MvYm9hcmQvcGh5dGVjL2lteDhtbS1waHlnYXRlLXRhdXJpLWwucnN0Cj4gPiBpbmRleAo+
ID4gN2VmYzkzOTIzNjFiNGE4NjdjZTJiYzE4ZGIxMWFhY2YzMTIwODgwMC4uNGRkODJjZDk3ODVm
YTU4NWVkMjE2NjY0YTI1ZjU5M2Q0ZQo+ID4gNzIzZGJiIDEwMDY0NAo+ID4gLS0tIGEvZG9jL2Jv
YXJkL3BoeXRlYy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLnJzdAo+ID4gKysrIGIvZG9jL2JvYXJk
L3BoeXRlYy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLnJzdAo+ID4gQEAgLTIxLDkgKzIxLDEzIEBA
IEJ1aWxkIHRoZSBBUk0gVHJ1c3RlZCBmaXJtd2FyZSBiaW5hcnkKPiA+IMKgCj4gPiDCoMKgwqAg
JCBnaXQgY2xvbmUgaHR0cHM6Ly9naXQudHJ1c3RlZGZpcm13YXJlLm9yZy9URi1BL3RydXN0ZWQt
ZmlybXdhcmUtYS5naXQKPiA+IMKgwqDCoCAkIGNkIHRydXN0ZWQtZmlybXdhcmUtYQo+ID4gLcKg
wqAgJCBleHBvcnQgQ1JPU1NfQ09NUElMRT1hYXJjaDY0LWxpbnV4LWdudS0KPiA+IC3CoMKgICQg
ZXhwb3J0IElNWF9CT09UX1VBUlRfQkFTRT0weDMwODgwMDAwCj4gPiAtwqDCoCAkIG1ha2UgUExB
VD1pbXg4bW0gQkwzMl9CQVNFPTB4YmUwMDAwMDAgU1BEPW9wdGVlZCBibDMxCj4gPiArwqDCoCAk
IG1ha2UgLWogJChucHJvYykgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCBDUk9TU19DT01QSUxF
PWFhcmNoNjQtbGludXgtZ251LSBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgIFBMQVQ9aW14OG1t
IFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAgSU1YX0JPT1RfVUFSVF9CQVNFPTB4MzA4ODAwMDAg
XAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCBCTDMyX0JBU0U9MHhiZTAwMDAwMCBcCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgIFNQRD1vcHRlZWQgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCBibDMx
Cj4gPiDCoAo+ID4gwqBCdWlsZCB0aGUgT1AtVEVFIGJpbmFyeQo+ID4gwqAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQo+ID4gQEAgLTMyLDggKzM2LDkgQEAgQnVpbGQgdGhlIE9QLVRFRSBiaW5hcnkK
PiA+IMKgCj4gPiDCoMKgwqAgJCBnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL09QLVRFRS9v
cHRlZV9vcy5naXQKPiA+IMKgwqDCoCAkIGNkIG9wdGVlX29zCj4gPiAtwqDCoCAkIG1ha2UgQ0ZH
X1RFRV9CRU5DSE1BUks9biBcCj4gPiArwqDCoCAkIG1ha2UgLWogJChucHJvYykgXAo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqAgQ1JPU1NfQ09NUElMRT1hYXJjaDY0LWxpbnV4LWdudS0gXAo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoCBDRkdfVEVFX0JFTkNITUFSSz1uIFwKPiAKPiBUaGlzIENGRyBo
YXMgYmVlbiByZW1vdmVkIGZyb20gb3B0ZWVfb3Mgc2luY2UgNC4yLjAgYW5kIGhhcyBuZXZlciBi
ZWVuIGVuYWJsZWQKPiBieSBkZWZhdWx0LCBzbyBJIHdvdWxkIHRoaW5rIHRoZXJlIGlzIG5vIG5l
ZWQgdG8gc2V0IGl0IHRvIG4gaGVyZS4KClRoYW5rcyBmb3IgdGhlIGluZm8sIHdpbGwgcmVtb3Zl
IGl0LgpTaG91bGQgd2UgcmVtb3ZlIGl0IGZyb20gdGhlIG9wdGVlIGRvYyBhcyB3ZWxsIHRoZW4/
Cmh0dHBzOi8vb3B0ZWUucmVhZHRoZWRvY3MuaW8vZW4vbGF0ZXN0L2J1aWxkaW5nL2dpdHMvb3B0
ZWVfb3MuaHRtbCNidWlsZC11c2luZy1nbnUtbWFrZQoKWWFubmljCgoKPiAKPiBUaGFua3MsCg==
