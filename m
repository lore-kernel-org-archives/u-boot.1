Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE5ECD5BA4
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 17:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC94E846BD;
	Wed, 20 May 2026 19:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="GY+eVn2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30965846EC; Wed, 20 May 2026 19:53:24 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 882C28464D
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 19:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=walter.schweizer@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHz7Kjwf5OVWrSZKfTxdWzzHFIopszzGE8IwZMfZSN4DIPzfo8oZvy2QtWJizMi1bI0fMl/3hgodLCnE1ofYaeIdIhChSzJhJ41HIuHtsYoQ5GDGplAjIyyzKP3UJtTUgxfttaEMQcpbzx1HV0SUHgWKW4w3HpS0l3JxbZkgAA027ZFPtDQ659dTdzgd/wXSttBATkBIXPRgnwMi68ur2sTD/k0Cqgo/yE6N0A32ycEkzpQNBpP2PWipp9l02o0idFW2HxHQPg68sAV7sg8mTZoWz5RRp3Zr/2KFXasUNMJA527SgYIYc4giKTmCYn1lmWuDsdXP3oe0z8JmdYvJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLfasw9mgtNem8FhAZVQYSpsosvwXd6sa6jooM7JCK8=;
 b=ErMFZlJSvxuXXm7pt0Glt6B6CBf5t7BqxsTnJg7ytuoxWKRU62XTb3vBTewxslL/edfdO/92NfzTeOTbX5G8gSxk+xsigK7koLwAv61a0GwkO29YAw8tmzAEASja2ldYU3oNYuhW2YZkF6DBSDrxBD+nRqIxOtrkm5sehU0IBZTe9/Oo34r7a6+Z5tbyQ6FkMPcW9SYDy7N1wbgdrg5UAP6Dbg6xSxjBFB3WfIjdEmr9eXoilAXy887Ue18+CsglD/U+f5Ox7KwUE0kNH+sMkzsBku5Ie3xND3pS5nKv0nt38Urh9Ux/xljy69+OUkbOaJ2GZ7aJJumQjao+OeQY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLfasw9mgtNem8FhAZVQYSpsosvwXd6sa6jooM7JCK8=;
 b=GY+eVn2iqEiSNoZoTdon0XI3UL71XoFmyjoZVuZGc2n0pOGM93GhuUIByYXNIZuEjUFdaQFcTJhrV6cbsiBoiv5qtePFzry2vR2x3cUHeHcLOoA7h+GwYrAyxXsSRpKdLRE1u30BdVyjt/gvLuUXYFOgHQ8QjnLMMCt/s4tx/Kxoil9WnpLZgL4fpfi5CYWsNjfmrp3trrQz/H3DBZh2m7CmZ2ZVdUq5LwHI6ZL5QQzx3lZyTfwuJLqko2zbBbVoMWipB69JpiexJRO/CwpzpzHQ6f09n8IwRPYQibBCCTL26R/E3S96ct2B8xBEZt7GPwDO5uhQhbv5fX5SaP80wA==
Received: from AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5af::15)
 by GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Wed, 20 May
 2026 17:53:12 +0000
Received: from AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b61d:120c:39a3:9714]) by AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b61d:120c:39a3:9714%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 17:53:11 +0000
From: "Schweizer, Walter" <walter.schweizer@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "james.hilliard1@gmail.com"
 <james.hilliard1@gmail.com>, "Sverdlin, Alexander"
 <alexander.sverdlin@siemens.com>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>, "mwalle@kernel.org"
 <mwalle@kernel.org>, "matthias.winker@de.bosch.com"
 <matthias.winker@de.bosch.com>, "pbrobinson@gmail.com"
 <pbrobinson@gmail.com>, "jerome.forissier@arm.com"
 <jerome.forissier@arm.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "Kiszka, Jan" <jan.kiszka@siemens.com>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>, "sumit.garg@kernel.org"
 <sumit.garg@kernel.org>, "quentin.schulz@cherry.de"
 <quentin.schulz@cherry.de>, "hs@nabladev.com" <hs@nabladev.com>,
 "dlechner@baylibre.com" <dlechner@baylibre.com>, "festevam@denx.de"
 <festevam@denx.de>, "daniel@makrotopia.org" <daniel@makrotopia.org>, "Jin,
 Le" <le.jin@siemens.com>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "quic_varada@quicinc.com"
 <quic_varada@quicinc.com>, "Freihofer, Adrian"
 <adrian.freihofer@siemens.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "dev@benjarobin.fr" <dev@benjarobin.fr>, "pro@denx.de" <pro@denx.de>,
 "philip.molloy@analog.com" <philip.molloy@analog.com>
Subject: Re: [PATCH v3 1/2] env: migrate static flags list to Kconfig
Thread-Topic: [PATCH v3 1/2] env: migrate static flags list to Kconfig
Thread-Index: AQHc4XLwHBuux6sxck+4/mOZUs8WAbYKTwIAgAzxIgA=
Date: Wed, 20 May 2026 17:53:11 +0000
Message-ID: <3a1ebdb80b54dd56c760c8819dfdb54c7fffec47.camel@siemens.com>
References: <20260511182036.50453-1-james.hilliard1@gmail.com>
 <fca54a0ce5a2375531ad51dbac84b30fe996446b.camel@siemens.com>
In-Reply-To: <fca54a0ce5a2375531ad51dbac84b30fe996446b.camel@siemens.com>
Accept-Language: en-US, de-CH, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1+intune 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB7524:EE_|GVXPR10MB5837:EE_
x-ms-office365-filtering-correlation-id: 83323c1b-7037-45db-5871-08deb698a8a7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|11063799006|55112099003|6133799003|4143699003|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: CN28fkBF+aBqT0RpxeFPVDaKLnwhXio0R5HvkNwbfkyHDyQa4JQfxfIWeFITFpJLHsdhPKwGnXEEYFdkuQIrrsCyn7JvGfhOlgTm+nvm6a5a8anpxHvcn8Hkyb4ST6C5dLXU7vH19BgQ+iGtmczrsSB5QP785VmjYCwdPLrYD5mWuMWAu4Yd+ImFGjTNdHWGiIUasyg/nhRM0JK6mdEUBsddJ5mbFJIacGXG/U9bSQ2RJ0cH2AtYmeZZYnVHZuzv9o54tP/AK8rSWWMIZDfZy97WMQeWoCNdpeoEirCs7dWSlpZrKiELubSCBTyusBcxa/3lYpMyYHUmL6kUufJcb+bNlBH92ieTSZ53wOfDV8Mrtw1FVMDKiIMb9NNzXRyZK56B8XWabH6yBnQvX4fQV+WoxVvk0cRzLRAUGM+cu49gGmDNx4QEtFAhPo/7o7YGYmXe3XfenJ2OkD39XQCbjxdetDRRjghQe65wVxMIiAZkr6o+FJklnQh7pCQEOOhxcco2P4dFhH6gE4D6/3upUxo+S0T9UnOLFHXL7AttYD5791z1rKwTL0eWgJAMo9nJs89Fdo7WUOtHtIw1ELzr6cTJmP9wEEpkADT1ZIvDRIOSkRIxmafoDhJhzpftc3HOHZag1OIEFjoFp/BZM21qYzJVJ63aulZa9sRPdUUSqsahj8P3CqS23JYpnCA/qPFug7XBQukZZEjJaYNraQ0yz3t4zhhp9lbKuKmS+Y4x4U68rRNIIZvsJLP+UTROci9A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(11063799006)(55112099003)(6133799003)(4143699003)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkVtYnQwQVJIY0hhdm9nZzl0S3grRU9ZUTBwcUd4dElFQzhjakdUd3FEekdn?=
 =?utf-8?B?N2Zmb2JrcmxOclh6TTQwWllHVHVrdElVamtOYXkyOTlxMERodHBIek5lWVVB?=
 =?utf-8?B?enR2akxIR1Rya2VxQXA1MTI0WE1HWWpaT0p4TnFneCt2eS91am01VUdmWG1a?=
 =?utf-8?B?SVNXaWFFVWNNK1JNZUtCWWVycjdHMUpvWDdzc3JYWVdhR1pjN0s4WjVBSlV6?=
 =?utf-8?B?NndaVzgrZUdzSVVqWm1uNE5wV3VzdVBXc0tOSzZxUmxCRjBLNG1aV0ZOY2Jm?=
 =?utf-8?B?d3FseWROL3d2QkkxcmxKR2xRUW12RjM0NVNpU1UyM0crR1Q4V3FRbk9pV3Rq?=
 =?utf-8?B?MHpndVlXbVlGWXpRRkNNTHB2c2dlUFk1Y0I0RUxpdk5jcGwvejRMcUFQdmZG?=
 =?utf-8?B?YS9jQ2djd1FwcWhJZXpQbUNmUi9lWlVjMW1BY3J6YktPcTdOQkVyREhmQWVQ?=
 =?utf-8?B?WlNpNTdNRFovcDczT01Eb0lML0pQV244UDQ1NnpWRS9KOTQ0UHN4VGZSamEz?=
 =?utf-8?B?KzY1eDY5TU5xY3F2dmVkWDA5dmprZEtMYVpkTkpGNWxGMGgvRzlCY2I2OG5C?=
 =?utf-8?B?Mm9UdlYybVpwVUFaTFppcGtSNVEzbjBVaEx6Y2RGWFRJazVoTUVvSkUzWlU5?=
 =?utf-8?B?VmZMTEdDVmJuUWhZL0JQS0Q0V2poZHF2MmlUYVFhT0VZZlhzZC9CaDdwNlU2?=
 =?utf-8?B?VzFzN3cxMU9sSUl4QnZOSWhlampZa3VGWG9laGdvU2xmSTlLeWlZK3V0Z294?=
 =?utf-8?B?NUFSbHM1blRRNEhuOGRHZkJJdFVEZmZhWXpDeFNUZnJFWm9OZ3hzamVxd2xM?=
 =?utf-8?B?a2plV2hYNmtFd2QzWHowMVFmYWRtTE9mOFlxK3hYdzlQeXBPUlRMaG1wQkJn?=
 =?utf-8?B?enJNYzRJeUNtcmdJYVRDSFFxSGNOejYyWWRMU0lQbzAwUDlLeGNic29NS1hD?=
 =?utf-8?B?SGNlSjZyenZnZVRFZ1FlZ20wbEtocCtyb1hqOU9MYmZXS2ZSSmV5U1FiL2lZ?=
 =?utf-8?B?NmwyTU1QL0NqenBqdW5KZ3FSdlB3NnJ6NkZaZk5UaGR2NHpZTVRqazVFWEpS?=
 =?utf-8?B?aGJzb1BCakthZFQySlJ2cHZzOHRZWEVRc2hMUGNRa0ZIMXFnR3hMYjdSZjdZ?=
 =?utf-8?B?UmUrTjZPU2hXSzU3WkNvdzRJQmEweDI3UU90ODNvVHlTZU9WK3VUNitqSWFP?=
 =?utf-8?B?WmI3V2tGLzljVDVzckgzR25UaWtCMDA1NnJobFZnRzEvZFBQa2hsckt4Z2pD?=
 =?utf-8?B?ZlBaQ293RExlUnNMRSs0OWZvL3pYdGhQZ2NhdFg5T0ZQQ05mbHVienZBUGZJ?=
 =?utf-8?B?cFlQTng0bHBIeGlmdUZTYU5xQnBvcWgzczRpSG42ODVyNCt4WnpOWEdEZTd5?=
 =?utf-8?B?OXNPekFSdmhLNWRCb3dreVJLVTIwMVh0OVpQSy8vakdqcXN6UE94VyszYkNG?=
 =?utf-8?B?Q2lkMlZWVWoyYnJtS25YeURtWFI5dzl6bmsvbHlSNkdRY1pQZ2cySmxYa1Jm?=
 =?utf-8?B?Sk5xdWF1NW1OeGxUTWsvdytrWjFHcFZkZTl4RnYweDF6TnNkTEJQbnh0VEFt?=
 =?utf-8?B?K1QzRmhqSm51NWJHYXdINDdmb3AvVFBSMS8zY0NUZS9VT21sTjUrU2YrMmRp?=
 =?utf-8?B?azVKOEFyNFVqMTFFS004WWxFc24vVHQxREcrMmpvTkRtVHJTYTVxbWg2NlNh?=
 =?utf-8?B?UUVSZ0gwTU5nLzFReGpSVUUwenhkeUF2QisvZ1FQdFR0eHRhZS8waTdnL0hN?=
 =?utf-8?B?QmlHU1p6ZEIxZXpDZld6OTd4VU80VjlRWEJhUlpZQTZtYVI0MTYwVTFxRGsy?=
 =?utf-8?B?Z0lJcFhLOG9TaTNuNnF3djNKOTYrRWgrVGh0Zm0rb2NOTXM1YWkxaG1XWmMz?=
 =?utf-8?B?OGoycW45WVdPOWNBeGJWL3NWVFVQSUQvSnlWa00yVXhXOGNjZ2RWaWhaOWhx?=
 =?utf-8?B?NE5mSmNoTklrUGlleHZCUjJheVlPQm05cm9HRFJCU1FrS0ExNHNKWGdpVVhh?=
 =?utf-8?B?UTdWelpvd2U5cURFVXNtWGh4Wll2ZTBFMmN0SGtBaUhEaUJEMFhxOVBwaDhJ?=
 =?utf-8?B?UG5EdnB4Z2JxYU1YeUxUMG94SXVNMzZLMDJDcE53K21QZm9KaHVrZmEwRCs0?=
 =?utf-8?B?dmFCeVl1Qk5zb1dlOWNhZDJ6YlFRSHQxWHdpMjdWUE9YVFBtNUNYUEdLRDNZ?=
 =?utf-8?B?aEFDb1ZIb3ZueStBcys4K2hUOTd4VGwvZ256MDFqbkVjMGtaVk93N3dCcC96?=
 =?utf-8?B?WFQzUVZxYmRTaWlaMWg1Vm4xd2NJMFRERHZKWDR0RHBGVUwwYVVBei9BUWdC?=
 =?utf-8?B?OUp1alpQRjFHNVIzUkVDNU91MEdGYkZIVmJvQnozcGJtSlRuQ1VaNEM2cXY2?=
 =?utf-8?Q?obd41tb+zzbUK23QEjJjKO/glot8tZvvEgkLt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79795ABEF7A0F049B665281F116BF40B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 83323c1b-7037-45db-5871-08deb698a8a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 17:53:11.3498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZRg/ePTfuFlPrVF4w9aK+bgYEKSDqZYvUDn7jDFGQcdV9VZryP1bVSK51ynbEwKSAO6pqqgdKbehfWiSIIw7PvcO2e9Ks83M39Tj0rjQpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5837
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

T24gVHVlLCAyMDI2LTA1LTEyIGF0IDEyOjE1ICswMDAwLCBTdmVyZGxpbiwgQWxleGFuZGVyIChT
SSBCIFBSTyBUSSBFQUMNCkNDUCkgd3JvdGU6DQo+IEhpIEphbWVzLA0KPiANCj4gT24gTW9uLCAy
MDI2LTA1LTExIGF0IDEyOjIwIC0wNjAwLCBKYW1lcyBIaWxsaWFyZCB3cm90ZToNCj4gPiBFbnZp
cm9ubWVudCBjYWxsYmFja3MgY2FuIGFscmVhZHkgYmUgY29uZmlndXJlZCBmcm9tIEtjb25maWcg
d2l0aA0KPiA+IENPTkZJR19FTlZfQ0FMTEJBQ0tfTElTVF9TVEFUSUMsIGJ1dCBzdGF0aWMgZW52
aXJvbm1lbnQgZmxhZ3Mgc3RpbGwNCj4gPiByZXF1aXJlIGJvYXJkIGhlYWRlcnMgdG8gZGVmaW5l
IENGR19FTlZfRkxBR1NfTElTVF9TVEFUSUMuDQo+ID4gDQo+ID4gQWRkIENPTkZJR19FTlZfRkxB
R1NfTElTVF9TVEFUSUMgYW5kIHVzZSBpdCBhcyB0aGUgb25seSBib2FyZC0NCj4gPiBwcm92aWRl
ZA0KPiA+IHN0YXRpYyBlbnZpcm9ubWVudCBmbGFncyBsaXN0LiBDb252ZXJ0IHRoZSByZW1haW5p
bmcgZGVmYXVsdC1jb25maWcNCj4gPiB1c2Vycw0KPiA+IGZyb20gQ0ZHX0VOVl9GTEFHU19MSVNU
X1NUQVRJQyB0byBkZWZjb25maWcgc2V0dGluZ3MgYW5kIGRyb3AgdGhlDQo+ID4gbGVnYWN5DQo+
ID4gaGVhZGVyIG1hY3JvIGZyb20gRU5WX0ZMQUdTX0xJU1RfU1RBVElDLg0KPiA+IA0KPiA+IE1v
dmUgdGhlIGVudmlyb25tZW50IGZsYWdzIGZvcm1hdCBkb2N1bWVudGF0aW9uIG91dCBvZiBSRUFE
TUUgYW5kDQo+ID4gaW50bw0KPiA+IHRoZSBkZXZlbG9wZXIgZW52aXJvbm1lbnQgZG9jdW1lbnRh
dGlvbi4gSW5jbHVkZSB0aGUgZm9ybWF0IGluIHRoZQ0KPiA+IEtjb25maWcgaGVscCBhcyB3ZWxs
Lg0KPiA+IA0KPiA+IFRoaXMgbGV0cyBib2FyZHMgY29uZmlndXJlIHdyaXRlYWJsZS1saXN0IHBv
bGljeSBhbmQgdHlwZQ0KPiA+IHZhbGlkYXRpb24NCj4gPiBmcm9tIGRlZmNvbmZpZyB3aXRob3V0
IGFkZGluZyBhIGNvbmZpZyBoZWFkZXIgc29sZWx5IGZvciBlbnYgZmxhZ3MuDQo+ID4gDQo+ID4g
VGhpcyBwcmVzZXJ2ZXMgdGhlIGJlaGF2aW9yIG9mIGRlZmF1bHQgY29uZmlncy4gSGVhZGVyLW9u
bHkgY2FzZXMNCj4gPiB0aGF0DQo+ID4gd2VyZSBpbmFjdGl2ZSBpbiB1cHN0cmVhbSBkZWZjb25m
aWdzIGFyZSBub3QgY29udmVydGVkIGludG8NCj4gPiBkZWZjb25maWcNCj4gPiBlbnRyaWVzOiBp
b3QyMDUwIGNhbiBhZGQgaXRzIGxpc3Qgd2hlbiBlbmFibGluZyBFTlZfV1JJVEVBQkxFX0xJU1Qs
DQo+ID4gYW5kDQo+ID4gc21lZ3cwMSBjYW4gYWRkIG1tY2RldjpkdyBzdXBwb3J0IGlmIHRoZSB1
bmxvY2tlZCBTWVNfQk9PVF9MT0NLRUQ9bg0KPiA+IGNvbmZpZ3VyYXRpb24gaXMgbmVlZGVkLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWVzIEhpbGxpYXJkIDxqYW1lcy5oaWxsaWFyZDFA
Z21haWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29t
Pg0KPiA+IFJldmlld2VkLWJ5OiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4gDQo+
IExHVE0NCj4gDQo+IFJldmlld2VkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5z
dmVyZGxpbkBzaWVtZW5zLmNvbT4NCj4gDQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyB2MiAtPiB2MzoN
Cj4gPiDCoCAtIE5vdGUgdGhhdCBpbmFjdGl2ZSBoZWFkZXItb25seSBpb3QyMDUwIGZsYWdzIGFu
ZCB0aGUgc21lZ3cwMQ0KPiA+IMKgwqDCoCBTWVNfQk9PVF9MT0NLRUQ9biBtbWNkZXY6ZHcgZmxh
ZyBhcmUgbm90IGNvbnZlcnRlZCBpbnRvDQo+ID4gZGVmY29uZmlncy4NCj4gPiANCj4gPiBDaGFu
Z2VzIHYxIC0+IHYyOg0KPiA+IMKgIC0gQ29udmVydCBleGlzdGluZyBDRkdfRU5WX0ZMQUdTX0xJ
U1RfU1RBVElDIHVzZXJzIHRvDQo+ID4gwqDCoMKgIENPTkZJR19FTlZfRkxBR1NfTElTVF9TVEFU
SUMgaW4gZGVmY29uZmlncy4NCj4gPiDCoCAtIERyb3AgQ0ZHX0VOVl9GTEFHU19MSVNUX1NUQVRJ
QyBzdXBwb3J0IGluc3RlYWQgb2YgYXBwZW5kaW5nIHRoZQ0KPiA+IG5ldw0KPiA+IMKgwqDCoCBL
Y29uZmlnIHZhbHVlIGFmdGVyIHRoZSBsZWdhY3kgQyBtYWNyby4NCj4gPiDCoCAtIFJlbW92ZSB0
aGUgdHJhaWxpbmctY29tbWEgcmVxdWlyZW1lbnQgZm9yIGJvYXJkLXNwZWNpZmljIHN0YXRpYw0K
PiA+IGZsYWdzLg0KPiA+IMKgIC0gUGxhY2UgdGhlIG1pZ3JhdGVkIGRlZmNvbmZpZyBlbnRyaWVz
IGluIHNhdmVkZWZjb25maWcgb3JkZXIuDQo+ID4gwqAgLSBNb3ZlIGVudmlyb25tZW50IGZsYWdz
IGRvY3VtZW50YXRpb24gZnJvbSBSRUFETUUgdG8NCj4gPiDCoMKgwqAgZG9jL2RldmVsb3AvZW52
aXJvbm1lbnQucnN0Lg0KPiA+IMKgIC0gQWRkIHRoZSBmbGFncy1saXN0IGZvcm1hdCB0byB0aGUg
Q09ORklHX0VOVl9GTEFHU19MSVNUX1NUQVRJQw0KPiA+IEtjb25maWcNCj4gPiDCoMKgwqAgaGVs
cCB0ZXh0Lg0KPiA+IC0tLQ0KPiA+IMKgUkVBRE1FwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNDUgKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gLS0tLQ0KPiA+IMKgY29uZmlncy9hcmlzdGFpbmV0b3MyY19kZWZjb25maWfC
oMKgwqDCoCB8wqAgMSArDQo+ID4gwqBjb25maWdzL2FyaXN0YWluZXRvczJjY3NsYl9kZWZjb25m
aWcgfMKgIDEgKw0KPiA+IMKgY29uZmlncy9obWlic2NfZGVmY29uZmlnwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCAxICsNCj4gPiDCoGNvbmZpZ3MvaW14NnFfYm9zY2hfYWNjX2RlZmNvbmZp
Z8KgwqDCoCB8wqAgMSArDQo+ID4gwqBjb25maWdzL2lteDhxeHBfY2Fwcmljb3JuLmNvbmZpZ8Kg
wqDCoMKgIHzCoCAxICsNCj4gPiDCoGNvbmZpZ3Mvc21lZ3cwMV9kZWZjb25maWfCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gPiDCoGNvbmZpZ3Mvc29jcmF0ZXNfZGVmY29uZmlnwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiA+IMKgZG9jL2RldmVsb3AvZW52aXJvbm1lbnQu
cnN0wqDCoMKgwqDCoMKgwqDCoMKgIHwgNDANCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gwqBlbnYvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwgMjMgKysrKysrKysrKysrKysNCj4gPiDCoGluY2x1ZGUvY29uZmlncy9h
cmlzdGFpbmV0b3MyLmjCoMKgwqDCoMKgIHzCoCAzIC0tDQo+ID4gwqBpbmNsdWRlL2NvbmZpZ3Mv
Y2Fwcmljb3JuLWNvbW1vbi5owqDCoCB8IDEzIC0tLS0tLS0tDQo+ID4gwqBpbmNsdWRlL2NvbmZp
Z3MvaG1pYnNjLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgLS0tDQo+ID4gwqBpbmNs
dWRlL2NvbmZpZ3MvaW14NnEtYm9zY2gtYWNjLmjCoMKgwqAgfCAxMiAtLS0tLS0tLQ0KPiA+IMKg
aW5jbHVkZS9jb25maWdzL2lvdDIwNTAuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDggLS0t
LS0NCj4gPiDCoGluY2x1ZGUvY29uZmlncy9zbWVndzAxLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgMTUgLS0tLS0tLS0tLQ0KPiA+IMKgaW5jbHVkZS9jb25maWdzL3NvY3JhdGVzLmjCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqAgMiAtLQ0KPiA+IMKgaW5jbHVkZS9lbnZfZmxhZ3MuaMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDYgKy0tLQ0KPiA+IMKgMTggZmlsZXMgY2hh
bmdlZCwgNzIgaW5zZXJ0aW9ucygrKSwgMTA2IGRlbGV0aW9ucygtKQ0KPiANClRoYW5rcyBKYW1l
cw0KDQpSZXZpZXdlZC1ieTogV2FsdGVyIFNjaHdlaXplciA8d2FsdGVyLnNjaHdlaXplckBzaWVt
ZW5zLmNvbT4NCg==
