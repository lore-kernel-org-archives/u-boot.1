Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4A2FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 08:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06875846B1;
	Tue,  5 May 2026 10:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="yY9pQvkO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1BA48483A; Tue,  5 May 2026 10:31:53 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B8B84198
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 10:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EReGA5uRuzswlDE2zT9UWJQuK/izx10HU0JKObgJb24FxhJBaI9I2CvebZbtCmpCJt8ySQbgyk06QBYxWaGoH72iKgpqbJqRyi+2oszmlo+GObjMlR/nt/AUPRe7p0kx7Uexm292loKTIyd6WQPGRvj5WLtjN3EjcamBxUxIjuTIM9gQcZ2OZRvPUEs2kJSwvj6lYo5Edxcb8rrjYUv88G/ElQsv/RrNiMfzMChDE1JrXMoDyIpc/zLvc7g5YC5HeBz5jCy+aF/0s8f3lP0MV9tcNxFuikQBq7AdweY2YF/Lx+q5nbaTaOAyB5uZv0342zzarDOn6orWGMjwUma64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfDr3cs4O/N9fz9mT4E1eGSV0GdfOTnuBPAp8Z36ws4=;
 b=jm4nn+OGlTWGyPzAOpmmnycLk0MxAUn1UtXYT7aegyaB1KMEJhdrwFRrUSvF6sZ1Q+PpdK2tCfXORSM3STsrT+Iq9jE3q9luDH8kRzW/L0xdDyNPiey0CskGhG4lqG6IfUHFsOymcsgI4kByacV8SlEPwUt3EI8Vb9755fXrYIlfjcqmu/XDiLxa/bECF9QFmKq4hwr7hlvdse8P6lqYeHbe66rqSt021mm/qbj//3Xt0qAHBnCHC8IB9f00Ox1s5tAd/ugSRfa38oe4bRDgxq/19ZOxW+khAioirphK1v+kQsdWNrezsFSTqdDAMG+ogJoRCp5QJyO7pZgPil2Emw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfDr3cs4O/N9fz9mT4E1eGSV0GdfOTnuBPAp8Z36ws4=;
 b=yY9pQvkOFKA30qJjJ4Azb4fR92McyRiWm/p3lXaD2iWjuPVnNROeQYts5JY/A8qcJap6o5LGhbcQ6m8qOj98JiYO9wZL00Y6PanlBMUjxxGNqG+jwMc1BCAfeGeXjBmtJZW5JmxUZlr5edPHs6X5u+yv27pE7wQO1VtLQ8qF8i7yGWTrmEP00e3aFFbE6TLamlWDdQfUbZmcjLgVVt24lV7UgjAwSjSItxXNBcqqkfCq8dc2VyAawDHBfcBO4ZLxaazBUSJHZ5PxOQ8r8q3dRsGf0ZEZbu9HBr0mq9brg20MrV+nbF7p96Clq3dHGv8m1nMDIyflYu8NoKBuoB+Vkw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV2PR10MB9674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:355::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:31:44 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:31:44 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "raymondmaoca@gmail.com"
 <raymondmaoca@gmail.com>
CC: "sjg@chromium.org" <sjg@chromium.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "casey.connolly@linaro.org"
 <casey.connolly@linaro.org>, "raymond.mao@riscstar.com"
 <raymond.mao@riscstar.com>, "pranav.sanwal@amd.com" <pranav.sanwal@amd.com>,
 "michal.simek@amd.com" <michal.simek@amd.com>
Subject: Re: [PATCH v2] lib: fdtdec: validate bloblist FDT before consuming
 libfdt size
Thread-Topic: [PATCH v2] lib: fdtdec: validate bloblist FDT before consuming
 libfdt size
Thread-Index: AQHc3AyQiseYSTlF3kO9NGPTIjkkqrX/GxuA
Date: Tue, 5 May 2026 08:31:44 +0000
Message-ID: <b7432c55f00b4c9b2043ca8efb262a5d5ec4d6e2.camel@siemens.com>
References: <20260504212524.1665166-1-raymondmaoca@gmail.com>
In-Reply-To: <20260504212524.1665166-1-raymondmaoca@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV2PR10MB9674:EE_
x-ms-office365-filtering-correlation-id: d7043d01-c460-4c83-47ca-08deaa80bd4e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|55112099003|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: Gb3rLAjN0zAc88wMxKrO22t4DiriRIhYDY+YRfn2rQaO/PLiOIwY83//vJ195PTc372MchSMV+OjFcRrWctZvS1iYMZ/QzhabwB1D5Rc1NpVp+tqVnY8xOziuV+1MVr/rDoToOhfKDO3Gv+1ta1LqUlLEU7PiKKPSUZF8kDgNnEZj3OSmDtve3/iLRLzaxkrmTipvPK80nAycK2+6MCGaNHUcvxYMkZVGVeyswjImFgHo5tl0ihr0qV4aG30ytK1r0XtzjRJA/ylPuQAe5+Vn1cZLBw/dYVo6pQTGozPn8rbHCzHiFH6KErFy86C+rEEZbhaDILK7aEAcLqabimitgb3sY7IcebUZyDsFvDe00LyVf8ZiWIt6vSKwzwZegjODUtUff14JoQT6laQfLpW7wFXyItSlHqUULeKtY8NoYEzgrH8iIMQiIoXPz/RZc4+DlX9MQb1qf8N7tuSpXUaq8iZbwm5Q7wRnF+7o9AOTepz6uA0VadLsgN5CWMwhD1F0XtOjFJzMiADozxmYRveXvSl3dpjsj9OUCMuPwXjXKpB5TgkajE/pPNmqxF2Ot4ouFd4qv41W1CFHvb76qkIy+gZYIf7nqjmJewVx9+/IiKFO6eFCQJlsDB8GanlphB+vHjYAKBafNWjsNl7V4IZdK7y/N7B7BAVYQHklbt9zngcSJgNkxEWhGnr216IC4TCZiI76JUB4YcWHKbjroWBAg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVVPTzN2czJHS2p1aFhEUW10Y2pENk5ITmYveG95aW80UXdRSGp3c0lQSkJw?=
 =?utf-8?B?Z3AvUjdDbFc2T2hnbjlaaGoyeFhNRytnKzJ3NHNUKzFiVWN1YzlxQUtWU1F4?=
 =?utf-8?B?S0JMaXM0OTVXaEx1ZDFjSWc2dzR1K2F2cFRvMmNaU1FOblo0TCsvY1BJTzZn?=
 =?utf-8?B?eVJpbmcveHRrUHpWQkNqSzFkU2ExZU9YOThjeUFBc0trNWlOU2kvQUs2amNQ?=
 =?utf-8?B?Z2k0aTdGZzZmSkhqOTBhRDlaUnlqNG16dzRpa1lGejJLSEM0Y1JtRWc5b01p?=
 =?utf-8?B?czlGWXZkeDFUQ0dvT01zTTQ0K1ZqZmFtalF0bHAyRlVMcjRqek9LNTRPOERJ?=
 =?utf-8?B?S3poOUNnZ2NqNlkyRGR0cDI5djRZUHlTOE9ZYXIrbFdGZWloVnBqN1J2QVYx?=
 =?utf-8?B?MUN3b3orTWFLTi9OZHZ3ZC9DSXZsc2xnaUd3aGZkTUpGaDFLQ2VWZExPVUM5?=
 =?utf-8?B?Wm91M1cvQVZmd1dwMnVMRWRRUThveXNMakJLejhVSkFidGxQQWdsNjlwM1FV?=
 =?utf-8?B?U3FnOVJ6bTRRSU1iL2U3aG11ZllRR0Q1Z1FpQlJiaU9OQTdXbkg5amVuaTlN?=
 =?utf-8?B?UnZXcU02NWdOYXU5emtuTS83MDJ5U3phYVJNbTRpOHI5ZG9RN2lwOVA5OGkr?=
 =?utf-8?B?UUJRVnhFZ21mMU9LVFdWR0xadFBrc3MxOStnQ3V5RVl5NTJhNWZraXRpMm1z?=
 =?utf-8?B?VC9qUDdWcElSV1NQczRSTHYzY0t6Y21RRDJyUUdhNnk3WFJNRGMwR29tTHIz?=
 =?utf-8?B?cE8wVHpYQVlKdm44bjAvWlIzMTlrYmYxejJrZTZXYXVlYkxGMlpCdFo5VUtB?=
 =?utf-8?B?SlhIOHBXL1g5Z2JSWms5UVA2SlF3RzlsbU80SXd5MG90MTlmY0VnYUZDVTkv?=
 =?utf-8?B?ZzRXVGZwbHNSakpHenZrVUl3YytuSmxQekRrZkZSKzFNbTdtemIwVkM2b1I4?=
 =?utf-8?B?ZmpPL2hPOE8zbUFzUENOZHB6YU1hY3dmV3JxNFVXM1UrSVgvQ1d4TFZqWXRF?=
 =?utf-8?B?ODlQUlRzbnJOaVB3clVIdWNXVUd6RldKYkdNbERvNDEydEttQ3lRU2IySzRx?=
 =?utf-8?B?WTZ6L0VNMGRpZTVVMGZNNVl6YTFWNGNuTk43UW5nbGVmSHdNbjl2R0J4aTd0?=
 =?utf-8?B?Z1J6dkdTZTR6dVBEL3kyaFNRcC9nUUtqaXV6bkk0QXdYYXIvZVEzREV1dElo?=
 =?utf-8?B?MTJ4Y08rNU0xTGVzM1BwdlhLRkM2dVRCTnpzQW9WUlhKMFNiVVNGdkZROGZW?=
 =?utf-8?B?d3YrOHYrRTNjWUFVWHBUTU5UWHY1RzFMZ2l2Y0MzMkhDdEQyRlhjN1B1aEZV?=
 =?utf-8?B?a0J3VzZzOENzbkRwbWh6cXVGa2pEdnFrSXFUQVkydTI5a3pUWkFmc1FrWkxo?=
 =?utf-8?B?aS9WdjBNcVk1aEFuTVhkc1k1TEhGb0lxK0tWQ3hMWVExOTR6NlNNRVFQLzcv?=
 =?utf-8?B?WitLYWZyRjVhRXJhWUtmN3g3eVFrbXdDTHhwRWJ2TGNGNnVzZUNDWGRObXo2?=
 =?utf-8?B?Z2dFTEx4ajBkd2VOTUlUMGNIQTRPc1JPODhGYWd0ZkNUQVRBUlAzNTdNZDNh?=
 =?utf-8?B?YmlGUTJuYmFhWkFSYmZQZklmR3dYMUdjQnNnWldjUkNwN0VpVDhRY2ZjZ2p1?=
 =?utf-8?B?NEZmM3A0eFpxRlZ4dktsWFlJVnZrYnJXN2tYaDVUaFptQ0JHdlVDZHA4aEFk?=
 =?utf-8?B?TUNSalQvMURQYlV3RlNpSlZzMHJsNUp4MzQyVEFZTkdMZWlzQWl2cXNob01W?=
 =?utf-8?B?Wm44b0NSZmJpK0krT28xcFI2NVNCb0tSY1hnREo1YmdxTDZkeEV2VnB1bDh1?=
 =?utf-8?B?dTJHdE9KOG9XcGhPeU1RM2pnZmNxSUJ3OHNERGNYdmg1Qk9lakZYZWxDdU5Y?=
 =?utf-8?B?YzUwRzBMdUlUVGFyTkcySWVGUm5BdEt6dHZ4U1d2dExIRFhRY29GZmRLK1Rs?=
 =?utf-8?B?ay82OXhCMGdqcGVjK1pidFF5UisvcmNDYVg1UUJRSHc0ZnV5aDllTytwUDNq?=
 =?utf-8?B?SVJqQTRPN1FVYzVpQjkwTjVYZzdlcmlmWnlSN0NwNTBhOHEwLy9mWERtWDRO?=
 =?utf-8?B?TWZ6N2lQZGo2Q21oMmtjTjVYMW5yVnVnd2IxOHpicEJ1czBYNUdBN21ZdXV3?=
 =?utf-8?B?a0trd1ZFVkg4aERKNlhVR0gycXRwRnVRdEhnak5KQU1UUkdpZ2tSV0taeUJ4?=
 =?utf-8?B?QndNRjVpUDV4VkRRQXRYdWRUTUZPeDFiNWtOQmpZcCs2dzdjdmVNem1pbU9v?=
 =?utf-8?B?eW5rWVQ2ZThOYXZzTm1TZ3pkbHk0Nzgvd25iSmJvRmszQU1WT00zR3N0dE9n?=
 =?utf-8?B?TlZCZmpmZzFFbmxMM05BT1pqODJYd3Z1S0J2YUZjUVZkVy8rbkxWRXgxdmRD?=
 =?utf-8?Q?dkRCVStHkIYIVEaw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <138B99DA0F303F40BA1DD5D459903BC4@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d7043d01-c460-4c83-47ca-08deaa80bd4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 08:31:44.1525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RRyKMn+eOu0wot+s5AavsPH1V+cOjVUCGX/BwsyzIWAimsWofuScl8gsstLaZ39mZJEJzzlt6p3goVSIGe2+BL5DzjvTAN10+lJFEkNQaJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9674
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

SGkgUmF5bW9uZCwNCg0KT24gTW9uLCAyMDI2LTA1LTA0IGF0IDE3OjI1IC0wNDAwLCBSYXltb25k
IE1hbyB3cm90ZToNCj4gRnJvbTogUmF5bW9uZCBNYW8gPHJheW1vbmQubWFvQHJpc2NzdGFyLmNv
bT4NCj4gDQo+IENvdmVyaXR5IFNjYW4gZGVmZWN0cyBhcmUgb2JzZXJ2ZWQgaW4gZmR0ZGVjX2Fw
cGx5X2Jsb2JsaXN0X2R0b3MoKSwNCj4gc2luY2UgdGhlIGxpdmUgRkRUIHRha2VuIGZyb20gdGhl
IGJsb2JsaXN0IGlzIHBhc3NlZCB0byBsaWJmZHQgaGVscGVycw0KPiB3aGljaCBjb25zdW1lIGhl
YWRlciBzaXplL29mZnNldCBmaWVsZHM6DQo+IC0gZmR0X29wZW5faW50bygpDQo+IC0gZmR0X3Bh
Y2soKQ0KPiAtIGJsb2JsaXN0X3Jlc2l6ZSguLi4sIGZkdF90b3RhbHNpemUoLi4uKSkNCj4gDQo+
IEFkZCBhIHNtYWxsIGhlbHBlciB0byB2YWxpZGF0ZSB0aGUgRkRUIGhlYWRlciBhbmQgY29uZmly
bSB0aGF0IHRoZQ0KPiBhZHZlcnRpc2VkIHRvdGFsc2l6ZSBmaXRzIHdpdGhpbiB0aGUgY3VycmVu
dGx5IGFsbG9jYXRlZCBibG9ibGlzdA0KPiByZWNvcmQuIFVzZSB0aGUgc2FuaXRpemVkIHNpemUg
YmVmb3JlIGNhbGxpbmcgZmR0X29wZW5faW50bygpLCBhZ2Fpbg0KPiBhZnRlciBvdmVybGF5cyBh
cmUgYXBwbGllZCBiZWZvcmUgY2FsbGluZyBmZHRfcGFjaygpLCBhbmQgb25jZSBtb3JlDQo+IGFm
dGVyIHBhY2tpbmcgYmVmb3JlIHNocmlua2luZyB0aGUgYmxvYmxpc3QgcmVjb3JkLg0KPiANCj4g
VGhpcyBrZWVwcyB0aGUgZXhpc3RpbmcgZmxvdyB1bmNoYW5nZWQgd2hpbGUgbWFraW5nIHRoZSBz
aXplIGNvbnN1bWVycw0KPiBvcGVyYXRlIG9uIHZhbGlkYXRlZCBGRFQgbWV0YWRhdGEuDQo+IA0K
PiBGaXhlczogYjcwY2JiZmJmOTRmICgiZmR0ZGVjOiBhcHBseSBEVCBvdmVybGF5cyBmcm9tIGJs
b2JsaXN0IikNCj4gQWRkcmVzc2VzLUNvdmVyaXR5LUlEOiBDSUQgNjQ1ODM3OiAoVEFJTlRFRF9T
Q0FMQVIpDQo+IFNpZ25lZC1vZmYtYnk6IFJheW1vbmQgTWFvIDxyYXltb25kLm1hb0ByaXNjc3Rh
ci5jb20+DQo+IC0tLQ0KPiBjaGFuZ2VzIGluIHYyOg0KPiAtIFJlYmFzZWQgb24gbWFzdGVyLg0K
PiANCj4gIGxpYi9mZHRkZWMuYyB8IDQzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2xpYi9mZHRkZWMuYyBiL2xpYi9mZHRkZWMuYw0K
PiBpbmRleCAyZDY2ODYwZjZlZC4uNjAxZjQxOGRiNmUgMTAwNjQ0DQo+IC0tLSBhL2xpYi9mZHRk
ZWMuYw0KPiArKysgYi9saWIvZmR0ZGVjLmMNCj4gQEAgLTE3NDQsOSArMTc0NCwzMSBAQCBzdGF0
aWMgaW50IGZkdGRlY19hcHBseV9kdG9fYmxvYih2b2lkICoqYmxvYiwgX19tYXliZV91bnVzZWQg
aW50IHNpemUpDQo+ICAJcmV0dXJuIGZkdF9vdmVybGF5X2FwcGx5X3ZlcmJvc2UoKHZvaWQgKiln
ZC0+ZmR0X2Jsb2IsICpibG9iKTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGludCBmZHRkZWNfZ2V0
X3ZhbGlkX2ZkdF9zaXplKGNvbnN0IHZvaWQgKmZkdCwgaW50IGFsbG9jX3NpemUsDQo+ICsJCQkJ
ICAgICBpbnQgKmZkdF9zaXplcCkNCj4gK3sNCj4gKwlpbnQgcmV0LCBmZHRfc2l6ZTsNCj4gKw0K
PiArCS8qDQo+ICsJICogVmFsaWRhdGUgdGhlIGhlYWRlciBiZWZvcmUgbGliZmR0IHRydXN0cyBh
bnkgaGVhZGVyIG9mZnNldHMvc2l6ZXMuDQo+ICsJICogQWxzbyBtYWtlIHN1cmUgdGhlIGFkdmVy
dGlzZWQgdG90YWxzaXplIGZpdHMgaW4gdGhlIGJsb2JsaXN0IHJlY29yZC4NCj4gKwkgKi8NCj4g
KwlyZXQgPSBmZHRfY2hlY2tfaGVhZGVyKGZkdCk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJu
IHJldDsNCj4gKw0KPiArCWZkdF9zaXplID0gZmR0X3RvdGFsc2l6ZShmZHQpOw0KPiArCWlmIChm
ZHRfc2l6ZSA+IGFsbG9jX3NpemUpDQo+ICsJCXJldHVybiAtRkRUX0VSUl9UUlVOQ0FURUQ7DQoN
CmhlcmUgeW91IHJldHVybiBhbiBlcnJvciBmcm9tIHRoZSBsaWJmZHQgZXJyb3Igc3BhY2UsIGJ1
dC4uLg0KDQo+ICsNCj4gKwkqZmR0X3NpemVwID0gZmR0X3NpemU7DQo+ICsNCj4gKwlyZXR1cm4g
MDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBmZHRkZWNfYXBwbHlfYmxvYmxpc3RfZHRvcyh2
b2lkKQ0KPiAgew0KPiAtCWludCByZXQ7DQo+ICsJaW50IHJldCwgbGl2ZV9mZHRfc2l6ZTsNCj4g
IAlzdHJ1Y3QgZmR0X2hlYWRlciAqbGl2ZV9mZHQ7DQo+ICAJaW50IGJsb2Jfc2l6ZTsNCj4gIAlz
aXplX3QgcGFkZGVkX3NpemUsIG1heF9zaXplOw0KPiBAQCAtMTc2MCw4ICsxNzgyLDEyIEBAIHN0
YXRpYyBpbnQgZmR0ZGVjX2FwcGx5X2Jsb2JsaXN0X2R0b3Modm9pZCkNCj4gIAlpZiAobGl2ZV9m
ZHQgIT0gZ2QtPmZkdF9ibG9iKQ0KPiAgCQlyZXR1cm4gLUVOT0VOVDsNCg0KLi4uIHRoZSBjYWxs
ZXIgcmV0dXJucyB0aGUgY29kZXMgZnJvbSB0aGUgc3RhbmRhcmQgZXJybm8uaA0KDQo+ICANCj4g
KwlyZXQgPSBmZHRkZWNfZ2V0X3ZhbGlkX2ZkdF9zaXplKGxpdmVfZmR0LCBibG9iX3NpemUsICZs
aXZlX2ZkdF9zaXplKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICAJ
LyogQ2FsY3VsYXRlIHRoZSBhbGxvd2VkIHBhZGRlZCBzaXplICovDQo+IC0JcGFkZGVkX3NpemUg
PSBmZHRfdG90YWxzaXplKGxpdmVfZmR0KSArIENPTkZJR19TWVNfRkRUX1BBRDsNCj4gKwlwYWRk
ZWRfc2l6ZSA9IGxpdmVfZmR0X3NpemUgKyBDT05GSUdfU1lTX0ZEVF9QQUQ7DQo+ICAJbWF4X3Np
emUgPSBibG9ibGlzdF9nZXRfdG90YWxfc2l6ZSgpIC0gYmxvYmxpc3RfZ2V0X3NpemUoKSArIGJs
b2Jfc2l6ZTsNCj4gIAlpZiAocGFkZGVkX3NpemUgPiBtYXhfc2l6ZSkNCj4gIAkJcGFkZGVkX3Np
emUgPSBtYXhfc2l6ZTsNCj4gQEAgLTE3NzIsNiArMTc5OCw3IEBAIHN0YXRpYyBpbnQgZmR0ZGVj
X2FwcGx5X2Jsb2JsaXN0X2R0b3Modm9pZCkNCj4gIAkJaWYgKHJldCkNCj4gIAkJCXJldHVybiBy
ZXQ7DQo+ICANCj4gKwkJYmxvYl9zaXplID0gcGFkZGVkX3NpemU7DQo+ICAJCXJldCA9IGZkdF9v
cGVuX2ludG8obGl2ZV9mZHQsIGxpdmVfZmR0LCBwYWRkZWRfc2l6ZSk7DQo+ICAJCWlmIChyZXQp
DQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiBAQCAtMTc4MSwxMiArMTgwOCwyMCBAQCBzdGF0aWMgaW50
IGZkdGRlY19hcHBseV9ibG9ibGlzdF9kdG9zKHZvaWQpDQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0
dXJuIHJldDsNCj4gIA0KPiAtCS8qIFNocmluayB0aGUgYmxvYiB0byB0aGUgYWN0dWFsIEZEVCBz
aXplICovDQo+ICsJcmV0ID0gZmR0ZGVjX2dldF92YWxpZF9mZHRfc2l6ZShsaXZlX2ZkdCwgYmxv
Yl9zaXplLCAmbGl2ZV9mZHRfc2l6ZSk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsN
Cj4gKw0KPiAgCXJldCA9IGZkdF9wYWNrKGxpdmVfZmR0KTsNCj4gIAlpZiAocmV0KQ0KPiAgCQly
ZXR1cm4gcmV0Ow0KPiAgDQo+IC0JcmV0dXJuIGJsb2JsaXN0X3Jlc2l6ZShCTE9CTElTVFRfQ09O
VFJPTF9GRFQsIGZkdF90b3RhbHNpemUobGl2ZV9mZHQpKTsNCj4gKwlyZXQgPSBmZHRkZWNfZ2V0
X3ZhbGlkX2ZkdF9zaXplKGxpdmVfZmR0LCBibG9iX3NpemUsICZsaXZlX2ZkdF9zaXplKTsNCg0K
ZG9lc24ndCB0aGUgZmR0X3BhY2soKSBhbHJlYWR5IGd1YXJhbnRlZSBhIHZhbGlkIGhlYWRlcj8g
Q2FuIHRoZSBwYWNrZWQgc2l6ZQ0KZXhjZWVkIHRoZSBibG9iX3NpemUgaWYgcGFja2luZyBvbmx5
IHNocmlua3M/DQoNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJLyog
U2hyaW5rIHRoZSBibG9iIHRvIHRoZSBhY3R1YWwgRkRUIHNpemUgKi8NCj4gKwlyZXR1cm4gYmxv
Ymxpc3RfcmVzaXplKEJMT0JMSVNUVF9DT05UUk9MX0ZEVCwgbGl2ZV9mZHRfc2l6ZSk7DQo+ICB9
DQo+ICANCj4gIGludCBmZHRkZWNfc2V0dXAodm9pZCkNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRs
aW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
