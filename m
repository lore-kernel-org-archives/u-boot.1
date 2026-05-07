Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8223CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 19:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7DE684B42;
	Thu,  7 May 2026 21:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="N+Ek99MW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59C2B84B58; Thu,  7 May 2026 21:46:33 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A64784B02
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 21:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRLGqdmqIeAO3PB2axblBTgyGML0SljyRi8IIQG5MniCi8BEL0f4ZXWPkWBGKKVIlhTHHspPW66AuRdHq/cX4to19Yc//fi/26JL23rkt2mRa83ZCAvv1nAxS3Sn/2kF9CZg3cC7qJ6SJ+kwDUiBPPEtWNmCoStSuQADFT5jVL3iDT2Os4IEvikcMwmjTH/kay4DqMW6u5OELFKXXMc9wl9sRD/eg1FyLr5lyTRbvENJEJeyeuUe9uMci4accLv2yWUAnb3rdiJs6qoZkAXgdes5rE4p73/AarDieIYWOEs7YKg25dL/DvMamN7ef1g4zEK1Zg2JUzEX4LhRWn4iRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eys9IkHTAMhOHnjDYX/c6krXYyi1Vbc679hIlMGPkqs=;
 b=DaFINeOqIb6ZFs0dyONzw8ABwTvYCF4SQvvYdFZsBtYG2pwt6rESKfiQI/HSFviyDi/Bb/weyfye37DriIP8znGJFS21MLXMbtKTYYxACXc4EiwZuQeHMiSwQXPyc++FziJ1HzFsw9t2C3cRt6y54zHMEF9fqBVXRf+UXXwG3SPT/v5C3fuq6QADn1H55FF7ZJw28Xt7yOzg+f9JQnLPyrLgljTaF2pHwWs49wbfaGeaMwPrlw4bFN3WqXXoE5AV44k6VN2nVhrxdviXY4brZzX5vviQu7uJ22zPh+NJfjv2R1MYv9SuUsfoLuXJykto5PHoxqhCIsSy9je+4lXsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eys9IkHTAMhOHnjDYX/c6krXYyi1Vbc679hIlMGPkqs=;
 b=N+Ek99MW2IMFJeUHBl3TBWpadnIhetXrh/Y6MWFYkxc8oa69cyDR7le9vfiur+BsPtXFT3n/yfoNnRhiOPrpdbZWj+1AuCZAp/6ziQfPgti29Q0Q2HPPSx9LhzJjGWHJZAvnWCAEoDYPkJzL7J1/8vVFQ2C4ZlwH3dlzjMKJeHQOwnhoJ4L+QtNcDUsxWBWWEm0YpDQW4ccCuhU66QgqwUljUM1CYsxz8aIe+S8a/OPA5MMAv1T1GkgbPHh2JBjipMj/KpqHx6VHj6AwA/nV8YEZyYxaPvHEaplNrcmyGp0P6q+dQopAi1KDkEIn3fzndWVbYg6IizLGxr5PIAWK4w==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS8PR10MB6530.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:567::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 19:46:28 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 19:46:28 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "raymondmaoca@gmail.com"
 <raymondmaoca@gmail.com>
CC: "sjg@chromium.org" <sjg@chromium.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "casey.connolly@linaro.org"
 <casey.connolly@linaro.org>, "raymond.mao@riscstar.com"
 <raymond.mao@riscstar.com>, "pranav.sanwal@amd.com" <pranav.sanwal@amd.com>,
 "michal.simek@amd.com" <michal.simek@amd.com>
Subject: Re: [PATCH v3] lib: fdtdec: validate bloblist FDT before consuming
 libfdt size
Thread-Topic: [PATCH v3] lib: fdtdec: validate bloblist FDT before consuming
 libfdt size
Thread-Index: AQHc3WhrLW0ZSU5Kj06KoEfcmeFGHLYC+ZGA
Date: Thu, 7 May 2026 19:46:28 +0000
Message-ID: <2fa267c2f1a15b95a1ace18ab0c1fabd9169a096.camel@siemens.com>
References: <20260506145535.1679611-1-raymondmaoca@gmail.com>
In-Reply-To: <20260506145535.1679611-1-raymondmaoca@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS8PR10MB6530:EE_
x-ms-office365-filtering-correlation-id: 36b14b5c-6ced-4c0f-449d-08deac7154a8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|38070700021|56012099003|18002099003|22082099003|55112099003;
x-microsoft-antispam-message-info: i6PVNqzs6aeGfVtMEgzCh7CfW8fro2RO3rMY24dfgQwr3ZE0/ljc8DHrsmSqVmevWb/E3Parj6GairmK3UmTwRnZKLv7HFcgbYAmfIK7FC283usTY7P/LK/4J7p1jipOWvwRdrO+qZ8kPV97/EVCP5OKfuqVM1b3wGZPQ4hMmxQ+UIFQ4J681Cw3Ph8yI6iR4eRGX+ZMsvkS7uGs/prH/I5DUL+/Lug/aPypJr86z09rt5wl2B+8BR1FszMhQODc+orhdNS1879f/vC+uSIVu5CEMDnn7hPYly0UOnuH5//DaKK78syZhCX3Zyb/4s0UsV0QXcMrf5PE0a33mnqdR8FeZvsy825AqRcNjdgihTkaqr8/Iu/p0QTH2EsTUGuR1EdskYlUpHACiCagq4QMR78u+pFGEkyWUHR4pt2YcJjuM+439PwMx0x8n/umiSqljUDdspUZ7REqYZjUj6CAAvuqEk0UDeySctykvTMW7zlw5Arf4DGbjlGh+8VXO6WXpZi7mUjQJdJVBpLgjk1aSsYLYhTE/oyv0CPUeg7GRYSP5sIU1AVGPBOb2/p700eVD/V8bhcvep8f4Ken0rJranN0InfU8AMHs6cLwUqhCBe3TAwfaXk9fdFgCoaGKavRzZmplwm31n2EJ5Z96MsgZw02bMC197OJChpwHD/+1tosS3GWi77wu+tuuv7+LEpmQDUAN/DGPMocFJiVBPUXaA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700021)(56012099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVNJK25HYnVmSFgzaHVGMUVJVkR6N1FXSHVsZTJFdlpxYjVsa1RoWEpPY1JO?=
 =?utf-8?B?dUlmb2pQSWpXUXN2bjRpNVp1aEphZ3k3aThxQWc2V3FIcXc1UkFKNWtYeVlx?=
 =?utf-8?B?bXRJNlBhT044TXNCcjR4RXlKQTNKbnJTYVBNVzIxbE9aWFhRb0EvRGsvUmEz?=
 =?utf-8?B?VVdHNFd0dFZERDQ0eDdkMEQreEh6V1hKUzFERE9IZ2NEUjRsOEErc0dXZitm?=
 =?utf-8?B?QWpkd0l1VU5WNjBBajU5alNHc01adVlXbVp1Q2VSUTNyZHJOQm9XR2N4eGhY?=
 =?utf-8?B?Mnk2VjVDbUtVbHl6OC94NkFHdzhrZUtzZi9mYTlyZ2llcHdHcWdEWGtIMTZI?=
 =?utf-8?B?RkhsamVicDluMVAvR2RQUFE0eHUzVnRRVzdLNzhCY0FRcmRyWG1wV2Q0Z2tX?=
 =?utf-8?B?WERyQWNBaExjbDNvaGR6T0ZwQnlPV2JocGNEQmpzYmkvbTZjSFBhNjNqK1lu?=
 =?utf-8?B?RjdnOTlKUlAwbzlwa2kvNG10UlBYeXllU0Q1WGhMRUt4MXJtSmtvclpRRmlh?=
 =?utf-8?B?WkRmTE5NeEhaaDQ2WEc3dXNybGovTWI2dWxod2t1MGp2RGJ3QTVJMjRkeXZS?=
 =?utf-8?B?K2psaFNvdGtRREJnQlB1Q3h0b0VXOU92dmpjRW00Z0o1MDhqTGhibkxEZTNu?=
 =?utf-8?B?NFl2UWZjMGVQbCtkaVlxS2gyL1g3ZlBrdm1Ja29rRFl2bkUzcHJoM0YrTjBq?=
 =?utf-8?B?R3dzTlV2MnpsK2RNYWV5dUZ6V3krLzhkdktZL3lPTXl3M0FGRE83V0R5MCs4?=
 =?utf-8?B?dTk2VjVuWW53OGwvVVphUU5Fa1RxOStMc2pUTkZuc1BnT1E4TUQ5c3dXRjJZ?=
 =?utf-8?B?OW42ZHRGaTltZHo4akt6SHJNdGt6ZFNWVWNnYkMvS2wrQXdlek00MEdheVZI?=
 =?utf-8?B?QjhQOXEvSDlCR3R4VFdOV2Nwb0QwdUpwNU4xUUltNEg3MkhVOGMrOW1zMFlU?=
 =?utf-8?B?ODlTeEp5citNR0tmY09mOFBJR2wwcVhlUVZKRjZERkFOa3NBRk56NFN3WnNS?=
 =?utf-8?B?Mzc4eDdncExWR1JlYjdkV2dqZDF3VVNLVXQrMVZpUHhpbWtobmozelNyMTQ2?=
 =?utf-8?B?eFR1cllEVkE4MUVEOUJ2U0RGcXBaLy9mSjJCYURoS1pSSXJENkYyM0k3MEV5?=
 =?utf-8?B?MGM4bFppdlNLT3JWM013Ym03U1dJTFZET2lFYmZKZ0tqS3pCc1VsK2FXdlht?=
 =?utf-8?B?SkY1NW9aazM2OG15OEVyWlMxNUZYVDJUZE9qc3NpNTRuVWU5b04rTXBPZlRU?=
 =?utf-8?B?WWNlTzBKY1hOZWhPdEVNZEY5TjNENkNaZGhwVzdnc2c5RzkyTFhvVXVMbVRD?=
 =?utf-8?B?QjV4TFphMFEwbUJlajBiclNEbFNPMmMrQkJDTElyTGovdXZuT1huQzRSRkw4?=
 =?utf-8?B?NVVNQVA5ZFZDVWQ2R2lhdUZpMjZwTUk5R2JjeFZZdVRDdmhNKzJNTGppREhK?=
 =?utf-8?B?MkJ0KzNyaFo5OGJTTnJFbkdoS3JJeU1WMFJkeGJYTG1KQkV0YlhhYlZRRVBW?=
 =?utf-8?B?YU04ZElhQTI1VUNTYUxyQ1NFOTd4ZExXUkQyNlhTemZXS2VpQVl0aU1LTC9T?=
 =?utf-8?B?RmhJL2RDSGF3d3B0YnRQNHVrNUNCK2NDa1llTHJWd20yL1ZoSzViNmthWkla?=
 =?utf-8?B?U20vZG5QaEg3aDFVaEVtNHRLMkZycFlFUXJCN1pSVUZRTkZLZTRqWFB3YkFH?=
 =?utf-8?B?U0VFM3h1cXNTOWpqV2ZBRXVjQk1DK2NJaExSRTQzY0FmVHUwajZzYk1HdHRS?=
 =?utf-8?B?VmpKNy9GeTVsMDdCQzkzTDVZQVNuRkdhK0FQVHRXVmNud041ODkxUUhMZXc4?=
 =?utf-8?B?WjNkRGJQTDJHbzd6Q2N3ditsaHZXM0VGQ0ltZkVDdDBaQlo1UzBNV3NQOUtn?=
 =?utf-8?B?OHNrNkxINnk4Rnc2aHpLaG81WXJPNWJsWkZIaEx3M1RzTks0dXZMWkRYb0Vh?=
 =?utf-8?B?WXdKQW5BOENHUEIxdWJLY2RUK2tIMloxMENremc0aGxWampvZlF1TXZPWWhk?=
 =?utf-8?B?NE9EakxhSktRQjA5YkNZZ0hScXV5Z0Q0WktMcCt4azB1ZW9uRExWMkQzWlVB?=
 =?utf-8?B?V0JrTXRuMmFwblJHUU9kdXpic2dXL0p3RW1zUENXNTFwM1dNTDU5YjFMK01W?=
 =?utf-8?B?cDJrVFhUdkpvaEQvMmR3TFk5SHg4aWRUaTJ4aW5qaHhNb2lPSWM2TVlna1R4?=
 =?utf-8?B?ZDdqU1orbFR0MlJXcFdvNGx3U1lEaXJVQWMwV3BFb1FkaFlwQU9WWDNLUU96?=
 =?utf-8?B?cTVocUV6Zjh5VlREdlhybXNxNGl4VC9EUG5OWkFUb2crYXB0bllmMHFZTnVW?=
 =?utf-8?B?NTlFUFVQME9wZ3FwQ2xDSk9QYzRpblNzQkg2ZElFLzk1QStFZyt2RmdrYkZC?=
 =?utf-8?Q?pCs91kGalMbIE6VE9YJpTUqMy3nW+jMegTsxual5294st?=
x-ms-exchange-antispam-messagedata-1: LmdN1uEml3nerwq1q54eHSqdZcwU+HPSYbP7JPPxyAfx7/KR26mdpRM4
Content-Type: text/plain; charset="utf-8"
Content-ID: <352DD1B86CA6024C8D160BD3ED4BFD44@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b14b5c-6ced-4c0f-449d-08deac7154a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 19:46:28.4334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rn+yC/Ii0RO2XWDPHwXpWCnY9+cJs4Q8FogK23kgKUG3mFJjRQwdXUTkwHIk9o1fG8nBvOvYHhRSrVbvZ6fd3wzTU33l4tRNRp99qahz7aM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6530
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

SGkgUmF5bW9uZCwNCg0KdGhhbmsgeW91IGZvciBhIHF1aWNrIHJld29yayENCg0KT24gV2VkLCAy
MDI2LTA1LTA2IGF0IDEwOjU1IC0wNDAwLCBSYXltb25kIE1hbyB3cm90ZToNCj4gRnJvbTogUmF5
bW9uZCBNYW8gPHJheW1vbmQubWFvQHJpc2NzdGFyLmNvbT4NCj4gDQo+IENvdmVyaXR5IFNjYW4g
ZGVmZWN0cyBhcmUgb2JzZXJ2ZWQgaW4gZmR0ZGVjX2FwcGx5X2Jsb2JsaXN0X2R0b3MoKSwNCj4g
c2luY2UgdGhlIGxpdmUgRkRUIHRha2VuIGZyb20gdGhlIGJsb2JsaXN0IGlzIHBhc3NlZCB0byBs
aWJmZHQgaGVscGVycw0KPiB3aGljaCBjb25zdW1lIGhlYWRlciBzaXplL29mZnNldCBmaWVsZHM6
DQo+IC0gZmR0X29wZW5faW50bygpDQo+IC0gZmR0X3BhY2soKQ0KPiANCj4gVmFsaWRhdGUgdGhl
IGJsb2JsaXN0IEZEVCB3aXRoIGZkdF9jaGVja19mdWxsKCkgYmVmb3JlIGNhbGxpbmcNCj4gZmR0
X29wZW5faW50bygpIGFuZCBhZ2FpbiBhZnRlciBhcHBseWluZyBvdmVybGF5cyBiZWZvcmUgY2Fs
bGluZw0KPiBmZHRfcGFjaygpLiBUaGlzIG1ha2VzIHRoZSBsaWJmZHQgY29uc3VtZXJzIG9wZXJh
dGUgb24gYSBjaGVja2VkIEZEVA0KPiBibG9iIHdoaWxlIGtlZXBpbmcgdGhlIGV4aXN0aW5nIGZs
b3cgdW5jaGFuZ2VkLg0KPiANCj4gQWxzbyBub3JtYWxpemUgbGliZmR0IHJldHVybiBjb2RlcyBm
cm9tIHRoaXMgcGF0aCB0byBlcnJubyB2YWx1ZXMsDQo+IGluY2x1ZGluZyB0aGUgb3ZlcmxheSBj
YWxsYmFjayBwYXRoIHRocm91Z2ggYmxvYmxpc3RfYXBwbHlfYmxvYnMoKS4NCj4gDQo+IEZpeGVz
OiBiNzBjYmJmYmY5NGYgKCJmZHRkZWM6IGFwcGx5IERUIG92ZXJsYXlzIGZyb20gYmxvYmxpc3Qi
KQ0KPiBBZGRyZXNzZXMtQ292ZXJpdHktSUQ6IENJRCA2NDU4Mzc6IChUQUlOVEVEX1NDQUxBUikN
Cj4gU2lnbmVkLW9mZi1ieTogUmF5bW9uZCBNYW8gPHJheW1vbmQubWFvQHJpc2NzdGFyLmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNp
ZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiBjaGFuZ2VzIGluIHYyOg0KPiAtIFJlYmFzZWQgb24gbWFz
dGVyLg0KPiBjaGFuZ2VzIGluIHYzOg0KPiAtIHJlcGxhY2UgdGhlIGxvY2FsIGhlbHBlciBmZHRk
ZWNfZ2V0X3ZhbGlkX2ZkdF9zaXplKCkgd2l0aA0KPiDCoCBmZHRfY2hlY2tfZnVsbCgpLg0KPiAt
IHJlbW92ZSB0aGUgY2hlY2sgYWZ0ZXIgZmR0X3BhY2soKS4NCj4gLSBhZGQgaGVscGVyIHRvIG1h
cCBGRFRfRVJSIHRvIGVycm5vLCBhbmQgbm9ybWFsaXplIHJldHVybiBjb2RlcyBvZg0KPiDCoCBm
ZHRkZWNfYXBwbHlfZHRvX2Jsb2IoKSBhbmQgZmR0ZGVjX2FwcGx5X2Jsb2JsaXN0X2R0b3MoKS4N
Cj4gDQo+IMKgbGliL2ZkdGRlYy5jIHwgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9saWIvZmR0ZGVjLmMgYi9saWIvZmR0ZGVjLmMNCj4g
aW5kZXggMmQ2Njg2MGY2ZWQuLmM2N2I2ZThjMTMzIDEwMDY0NA0KPiAtLS0gYS9saWIvZmR0ZGVj
LmMNCj4gKysrIGIvbGliL2ZkdGRlYy5jDQo+IEBAIC0xNzI5LDE5ICsxNzI5LDM4IEBAIHN0YXRp
YyBpbnQgZmR0ZGVjX21hdGNoX2R0b19jb21wYXRpYmxlKGNvbnN0IHZvaWQgKmJhc2UsIGNvbnN0
IHZvaWQgKmR0bykNCj4gwqAJcmV0dXJuIDA7DQo+IMKgfQ0KPiDCoA0KPiArc3RhdGljIGlubGlu
ZSBpbnQgZmR0ZGVjX3JldF90b19lcnJubyhpbnQgcmV0KQ0KPiArew0KPiArCXN3aXRjaCAocmV0
KSB7DQo+ICsJY2FzZSAtRkRUX0VSUl9OT1RGT1VORDoNCj4gKwkJcmV0dXJuIC1FTk9FTlQ7DQo+
ICsJY2FzZSAtRkRUX0VSUl9FWElTVFM6DQo+ICsJCXJldHVybiAtRUVYSVNUOw0KPiArCWNhc2Ug
LUZEVF9FUlJfTk9TUEFDRToNCj4gKwljYXNlIC1GRFRfRVJSX05PUEhBTkRMRVM6DQo+ICsJCXJl
dHVybiAtRU5PU1BDOw0KPiArCWRlZmF1bHQ6DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCX0N
Cj4gK30NCj4gKw0KPiDCoHN0YXRpYyBpbnQgZmR0ZGVjX2FwcGx5X2R0b19ibG9iKHZvaWQgKipi
bG9iLCBfX21heWJlX3VudXNlZCBpbnQgc2l6ZSkNCj4gwqB7DQo+IMKgCWludCByZXQ7DQo+IMKg
DQo+IMKgCXJldCA9IGZkdF9jaGVja19oZWFkZXIoKmJsb2IpOw0KPiDCoAlpZiAocmV0KQ0KPiAt
CQlyZXR1cm4gcmV0Ow0KPiArCQlyZXR1cm4gZmR0ZGVjX3JldF90b19lcnJubyhyZXQpOw0KPiDC
oA0KPiDCoAlyZXQgPSBmZHRkZWNfbWF0Y2hfZHRvX2NvbXBhdGlibGUoZ2QtPmZkdF9ibG9iLCAq
YmxvYik7DQo+IMKgCWlmIChyZXQpDQo+IMKgCQlyZXR1cm4gcmV0Ow0KPiDCoA0KPiAtCXJldHVy
biBmZHRfb3ZlcmxheV9hcHBseV92ZXJib3NlKCh2b2lkICopZ2QtPmZkdF9ibG9iLCAqYmxvYik7
DQo+ICsJcmV0ID0gZmR0X292ZXJsYXlfYXBwbHlfdmVyYm9zZSgodm9pZCAqKWdkLT5mZHRfYmxv
YiwgKmJsb2IpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiBmZHRkZWNfcmV0X3RvX2Vycm5v
KHJldCk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gwqB9DQo+IMKgDQo+IMKgc3RhdGljIGludCBm
ZHRkZWNfYXBwbHlfYmxvYmxpc3RfZHRvcyh2b2lkKQ0KPiBAQCAtMTc2MCw2ICsxNzc5LDEwIEBA
IHN0YXRpYyBpbnQgZmR0ZGVjX2FwcGx5X2Jsb2JsaXN0X2R0b3Modm9pZCkNCj4gwqAJaWYgKGxp
dmVfZmR0ICE9IGdkLT5mZHRfYmxvYikNCj4gwqAJCXJldHVybiAtRU5PRU5UOw0KPiDCoA0KPiAr
CXJldCA9IGZkdF9jaGVja19mdWxsKGxpdmVfZmR0LCBibG9iX3NpemUpOw0KPiArCWlmIChyZXQp
DQo+ICsJCXJldHVybiBmZHRkZWNfcmV0X3RvX2Vycm5vKHJldCk7DQo+ICsNCj4gwqAJLyogQ2Fs
Y3VsYXRlIHRoZSBhbGxvd2VkIHBhZGRlZCBzaXplICovDQo+IMKgCXBhZGRlZF9zaXplID0gZmR0
X3RvdGFsc2l6ZShsaXZlX2ZkdCkgKyBDT05GSUdfU1lTX0ZEVF9QQUQ7DQo+IMKgCW1heF9zaXpl
ID0gYmxvYmxpc3RfZ2V0X3RvdGFsX3NpemUoKSAtIGJsb2JsaXN0X2dldF9zaXplKCkgKyBibG9i
X3NpemU7DQo+IEBAIC0xNzcyLDIwICsxNzk1LDI1IEBAIHN0YXRpYyBpbnQgZmR0ZGVjX2FwcGx5
X2Jsb2JsaXN0X2R0b3Modm9pZCkNCj4gwqAJCWlmIChyZXQpDQo+IMKgCQkJcmV0dXJuIHJldDsN
Cj4gwqANCj4gKwkJYmxvYl9zaXplID0gcGFkZGVkX3NpemU7DQo+IMKgCQlyZXQgPSBmZHRfb3Bl
bl9pbnRvKGxpdmVfZmR0LCBsaXZlX2ZkdCwgcGFkZGVkX3NpemUpOw0KPiDCoAkJaWYgKHJldCkN
Cj4gLQkJCXJldHVybiByZXQ7DQo+ICsJCQlyZXR1cm4gZmR0ZGVjX3JldF90b19lcnJubyhyZXQp
Ow0KPiDCoAl9DQo+IMKgDQo+IMKgCXJldCA9IGJsb2JsaXN0X2FwcGx5X2Jsb2JzKEJMT0JMSVNU
VF9GRFRfT1ZFUkxBWSwgZmR0ZGVjX2FwcGx5X2R0b19ibG9iKTsNCj4gwqAJaWYgKHJldCkNCj4g
wqAJCXJldHVybiByZXQ7DQo+IMKgDQo+IC0JLyogU2hyaW5rIHRoZSBibG9iIHRvIHRoZSBhY3R1
YWwgRkRUIHNpemUgKi8NCj4gKwlyZXQgPSBmZHRfY2hlY2tfZnVsbChsaXZlX2ZkdCwgYmxvYl9z
aXplKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gZmR0ZGVjX3JldF90b19lcnJubyhyZXQp
Ow0KPiArDQo+IMKgCXJldCA9IGZkdF9wYWNrKGxpdmVfZmR0KTsNCj4gwqAJaWYgKHJldCkNCj4g
LQkJcmV0dXJuIHJldDsNCj4gKwkJcmV0dXJuIGZkdGRlY19yZXRfdG9fZXJybm8ocmV0KTsNCj4g
wqANCj4gKwkvKiBTaHJpbmsgdGhlIGJsb2IgdG8gdGhlIGFjdHVhbCBGRFQgc2l6ZSAqLw0KPiDC
oAlyZXR1cm4gYmxvYmxpc3RfcmVzaXplKEJMT0JMSVNUVF9DT05UUk9MX0ZEVCwgZmR0X3RvdGFs
c2l6ZShsaXZlX2ZkdCkpOw0KPiDCoH0NCj4gwqANCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4N
ClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
