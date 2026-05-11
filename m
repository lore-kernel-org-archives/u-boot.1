Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AA9CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 07:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73CA78482E;
	Mon, 11 May 2026 09:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="V1sqwGqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF76284836; Mon, 11 May 2026 09:23:24 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27529846C1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 09:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O36X8UwHY+7LUISsVNkozJwVDd8dNyJU11ETRtBvNMGSxOlUIOES0E4nBkZtlgYShHe6vPmmSqWm96mgHe9UQyzPwPcsKBXHlbBi6E6Q23emKErROzXSnJTV7mUeTWhfFbR5G1Cpny5KT5/L+kXLG4UCNt3uhGiG5rbzvFP9kAtkPhZ7ePy28ZLqt79FcWwxvUEtLLx6/jU4eT6sYRNpX0fLCPc8LtNJ5sJrDWESGavkdQz0ZXJWV+KGfyqSJ1OkT+uPpdbVPQgBBekEXX7PJseZ14mry1eKggtsad7MB4mHUsf7n2lBazC3fuxBKjO9Z2jnDUPLYk3hI2sYZ9U+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5OT0mSpNaBGN3MIcm9yfmihk+KD6qfodJn9wQrf1kM=;
 b=W6JOsQgIyr4CZYzkbXAjrl0qYF/uUBx64nFIkdEBtUY8MiKQXn4CbfNf0c9xTB35z+lYhrGpAH7CYwTf1NogsgSnZbVl+9frumdf3tVQHgqaklMglc76bX5//Foj0v9vl2BjgeZ4dzD7BS9IqvX/34Dw8nBg3wCMYHey2Z1DNkVO9ATl63llNefRowBOu39olz2aoobVWdqs9APhSPkzoen3LnEvudbr5G+uZ0x+XF/SnblQeVbiuJ+HQv7jxNaLUdQ34PVsQnowHMovWxs0LxAimKD60u042/YQ2I8JoFifqF4bUQChhnGgyfZqCSNBRxgZOdsYY8i9SNveY0ERrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5OT0mSpNaBGN3MIcm9yfmihk+KD6qfodJn9wQrf1kM=;
 b=V1sqwGqOi8u39TjlJlpKIvTrZ5B9/JNcHOKfjCRGmOXnZuWPI+wUxVPuQlTQA/NSO57j0TnXYdqBhPl+VgJ2SbQ3wv1Wdzmws8+bIoXR77ySdGzNsPVfj/d8qJ4nUyoKioRqioHbFn0lecbO2mGo+yQRAGbe83fjAmRbcc9hcTvXluHvHNLfENdbcQ7WRBXBGSJPOGmxLDdTi1Qjna18buizLxM1K7VPfOCnjSxgGCoOFldSkBXfVuvlfU3e1ZvOQwfZVxtkTYwPrIs3CMDLZZzkPt1hSlj8pHK7r4+jV/IPB+asVZGSxyF/KH+H77HUzcbETwhXQgAxtPsCZG98Aw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VE1PR10MB3935.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:160::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 07:23:17 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 07:23:17 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "james.hilliard1@gmail.com"
 <james.hilliard1@gmail.com>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>, "mwalle@kernel.org"
 <mwalle@kernel.org>, "matthias.winker@de.bosch.com"
 <matthias.winker@de.bosch.com>, "pbrobinson@gmail.com"
 <pbrobinson@gmail.com>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>, "trini@konsulko.com" <trini@konsulko.com>, 
 "Kiszka, Jan" <jan.kiszka@siemens.com>, "sumit.garg@kernel.org"
 <sumit.garg@kernel.org>, "quentin.schulz@cherry.de"
 <quentin.schulz@cherry.de>, "hs@nabladev.com" <hs@nabladev.com>,
 "dlechner@baylibre.com" <dlechner@baylibre.com>, "daniel@makrotopia.org"
 <daniel@makrotopia.org>, "quic_varada@quicinc.com" <quic_varada@quicinc.com>, 
 "Jin, Le" <le.jin@siemens.com>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "Schweizer, Walter"
 <walter.schweizer@siemens.com>, "Freihofer, Adrian"
 <adrian.freihofer@siemens.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "dev@benjarobin.fr" <dev@benjarobin.fr>, "pro@denx.de" <pro@denx.de>,
 "philip.molloy@analog.com" <philip.molloy@analog.com>
Subject: Re: [PATCH] env: add Kconfig option for static flags list
Thread-Topic: [PATCH] env: add Kconfig option for static flags list
Thread-Index: AQHc4Afm0+GQBrndjk6vd1c5berlLrYIbgCA
Date: Mon, 11 May 2026 07:23:17 +0000
Message-ID: <e1e43a0034dff719e0df12437f8d018d5aed82ae.camel@siemens.com>
References: <20260509230147.1308308-1-james.hilliard1@gmail.com>
In-Reply-To: <20260509230147.1308308-1-james.hilliard1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VE1PR10MB3935:EE_
x-ms-office365-filtering-correlation-id: eab8f173-765c-427d-6aed-08deaf2e2bea
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003|55112099003|38070700021;
x-microsoft-antispam-message-info: B0f7MYVOSkDY2pbMAPDrcihjMU4RxabBc09sH3HXcCA0D77IhY1YxBmzveNdKvXfCVMadDo3wk6LScjMpBp1ykK6GHsdPOHT1szfuGHuYDmQJS4KVZ+xmdnb6mKFU/W/hu4zZIGLkXYueQBeTtwRD8pDHswtCOK8tFqr56Ugg1TjtzSHuPxj0uPp/drbpTLRIy+cLJlVHNO8eDM5RB/kTh9ZH+CiJ91NXaYTokg4HvGwyHW8noKtMqNwWDQytHIxHqTZKqT8YffpHns9N0CPPjFOMu5f36j2ZhJgWB94qUl+vqpSuLqMMEEWfVOsdSIybs/O4urXbtAjtvTb+g7eO4eMZT9o52mW633nq3UGxAzhqEzGFWXsgw0bshXXUDoKTqcV7ad4mpW6zoxvfwfPTod4GIpVLc5C2WJNoTDXnPNj6jgP7uiB8t/Gq/inMDLuG9BVasWazidWkT4QERitdQJqKkhYB9a8t2S7z/G6satXuQGAgA5SeJwdNPHX57bAisJ+j8rVsumv1h6RskGXuccUQT8wJbmQCw0qMK89K6x3PXKN/1iav1oP7Cm+8DZwcO8bsYv+TRNyw/6qJCuXgQDcuGy6w2wDHSgpP862lsIySl/C6/92kGIMQqo8kGrDxD/w51TBV950SOzRp5XPkKFYg/Pr1bCiiqSslktHIjDJ3Lg4nLWqneWSSfeStMLhTzslylKU13om+z1d2FIt0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(55112099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWc3SUI2SEV4dVVmVlNSd092eEN5aDdGd3ZCMjBEYzRsbXN6b2tXdVovK013?=
 =?utf-8?B?cUJJWWpuWlFOdDlDZnEvNFE0WmwzeE1FQ2tWQXJwekR0WnRkSU52Y3pQS0ti?=
 =?utf-8?B?U0FCNFF5Tlk5RGtkRGFyQXJ0dzIvTURvaHNEdU9EdVlOUUNZdEVUaDgwMmF1?=
 =?utf-8?B?eFRBUzJ6MnpaNXIzMlpITStHbS9CY3JJdDhYbDVEUzBYdFFUT0N2cXQ4QWhW?=
 =?utf-8?B?cTh4eXJFMnl5dWFGNDJKNVdpeGxPRXJMalRjSEJrTUUvRVdFNGwrTzNXZit2?=
 =?utf-8?B?RncraDZ4dG1OZUFLT2xFVHQwUGsvQ254OVdUOENrOG9uRmlHRGlORjVoNkd0?=
 =?utf-8?B?b3VXeXVkOXFZUFZXcXhkWDlRWnY0MnMraG1aMmFqamp5SmdqcHBoakhGKytN?=
 =?utf-8?B?ZjMrNWY2cmNBWnNZOENOU1hubWMvdTNxeGVpTkN5Q3BZU25XZzBIUGlDSG9B?=
 =?utf-8?B?cGhXa3ZTcWt2RVBZeFFLMHJ6RzFtSWRlZG81K241bWVvQ056WkNjME5lYkNT?=
 =?utf-8?B?dmNqcTkzeDRSSDBTSys0NVVNclNQUUQ5YSt2bkpNdTF4c1FVejFvLzUwamd4?=
 =?utf-8?B?b2J1R2J5a2l5L3U1OU5zM3NTVTh4Skd2bDV0bGVkSWxTRVpFSTRzK1k2eDgy?=
 =?utf-8?B?Uk9BdXJ0eHk4YTZXUFlGRVhOZ3JNdGtMV3ZLeEpvZGZlWWJxRG5xTGlKUC94?=
 =?utf-8?B?aVQrZ1hremFmbnA2U0NSYmptWlJxSjIwNFU1M3ZHMzI0bEQrOUdiSytwQzNO?=
 =?utf-8?B?d1hRSHVTdHEyMWpJN0VwajZCZlltL2NKK3JyUGNLOTMzaUZBd3cxS1pzb0hx?=
 =?utf-8?B?MS9CbWoyNG1HLzFVeWh4Q0p6SW5LTFZqS3NyUU94akR0bVNGcStmQ2xweVVj?=
 =?utf-8?B?ODVIMWhvMHpkM2R2cVowbzlMZnlBM3ZhbzZHY094azc2cUYrbkhRdGkyUFZC?=
 =?utf-8?B?eVNMdGk1MDV3VU5Ram9qOTQwZ1dDQmgvQ2VMSlhkSlFpWWxCbHQwOXZSNkxk?=
 =?utf-8?B?RzBORVhUVnRWQWJMMnlOaG9lNkRUcTJjblVFSWNJbXlYazEzZ0g5VHo0RHJs?=
 =?utf-8?B?cWU2NFJodnAzbXY1U0pseGpUaHFjbVBpMzNGRnM0MllRYmtDcDBFYlNFaE9J?=
 =?utf-8?B?N0NaQWdVUU9EdFRaT3E1SDJHemlCcm8rYUZmTUNoUU4vaFd5ZFlsQ0ZMNWM1?=
 =?utf-8?B?MjR2UkwzRWNaYit6dEdMRXRGZFQwQTJaTTlRUmNGTzJUWnRXT1JQeUtzK3c5?=
 =?utf-8?B?YVJoYjNrRjdBZ3I1V0sxMDU3K3Fpeml1QVFVbzZUdjh6cjB2RGVXZEZDbmFD?=
 =?utf-8?B?SmsrMnVWSkovSG1JY0FxcWNTSVhiUU1QMXBsN2FnV0xreERZalJIK1RlRHI5?=
 =?utf-8?B?Y3MzM043OFJBRmJKdCtIL0dxdWExQXh2d0lkbVdYZjlDY2hwWXR2Ylk5THNt?=
 =?utf-8?B?NzhyOUs4NHI5WjNWN3d5TmU1Y3plb055MmtxU2VhcU54dWl5ZGgwU3AxMTNM?=
 =?utf-8?B?MElzSWU4WXJWZDVULzIyamIxamt2TTRxS3Z0K1pnbnVPVzBKSElQWkhjQWdk?=
 =?utf-8?B?bmRjc1BQelhEQVcyQ0grNWZaVW1jRGROY1Q5NEg4dTF0V0czeEp1UjZXdkV3?=
 =?utf-8?B?UDBuVnBScDhKTmt5VUw3V1J6WGtFdjRRYVMxeG92M1psb0JaRXh5QmduUjF1?=
 =?utf-8?B?TzJnS2cvclIxV3dUQ0hvTXhES3BqTXZ1ck9NOXk2MUwwL2N2OTUra0FSdXU1?=
 =?utf-8?B?bDJ5VzBpeXdEcHVEcGhsZlhxQXpGM1ZhSU1RUUFoQzBmRUczazc4cUI1WEhj?=
 =?utf-8?B?amFOUjdHV2h4eisydXJIZHJIcS9BSklSNzhyNWJINDVyaU1LWnd3MTNOTWFS?=
 =?utf-8?B?am8yZEhkSHFKeThVRUxTODNZSTkvSlNXWFlQQ2xIVHdIYWVnSy94MlZtaDE5?=
 =?utf-8?B?Q0tlYmtrYWpzdVpTQVNiS0h2V2M0dWtUNWFOTlNDdXdqbGFkMUJjNVN3by9L?=
 =?utf-8?B?N3FlZmtHWmVlbVd6WktiSCtaODNNck9CWmtmTDBRT3JhTEJHRDBzaUYxc0Mw?=
 =?utf-8?B?eGFUL3Q5NE8wUDJLR1UxdjA4UktUcXUrMTFPLzRENXZreGp4L0d1ZENGQ3pB?=
 =?utf-8?B?NHVVK2hXbWdzM3pmaWZnaDBzdnUzaXY5dWh2YzB0Q20xODhQNVBYUUdEbE5N?=
 =?utf-8?B?SzkzQnBEQ3RaTmdyQ3RZcTk3S3poZXpzajRESWtrK2NsWmIvamErMEhScXF3?=
 =?utf-8?B?R1JXTkJVTTdqZkE3bVF5aFBGUTJ0VG00MUpINWpETGt3UG45KzF1RjBjZnFM?=
 =?utf-8?B?NE5vSEdVVHc5Yy9tLzcyeDV1WHVzQzFObTVCWktsMXlOMldEdzhCV3M1TzFT?=
 =?utf-8?Q?NYy5fuYauZsWjqyDELCjJZwmurcXqDoyeNb+T?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97E517E072548B41B8E4E51344F099A9@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eab8f173-765c-427d-6aed-08deaf2e2bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 07:23:17.2725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BOGJq87jvH6TaFzUc/WfnOEwj6oa4vr07ma3MkIjuBAQgxU0H7zaQClsPHzHK5+R9/8EhuhHnD08rob5ObhCyo1mtYxHl8yOPzb+CfXx/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3935
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

SGkgSmFtZXMsIA0KDQpPbiBTYXQsIDIwMjYtMDUtMDkgYXQgMTc6MDEgLTA2MDAsIEphbWVzIEhp
bGxpYXJkIHdyb3RlOg0KPiBFbnZpcm9ubWVudCBjYWxsYmFja3MgY2FuIGFscmVhZHkgYmUgY29u
ZmlndXJlZCBmcm9tIEtjb25maWcgd2l0aA0KPiBDT05GSUdfRU5WX0NBTExCQUNLX0xJU1RfU1RB
VElDLCBidXQgc3RhdGljIGVudmlyb25tZW50IGZsYWdzIHN0aWxsDQo+IHJlcXVpcmUgYm9hcmQg
aGVhZGVycyB0byBkZWZpbmUgQ0ZHX0VOVl9GTEFHU19MSVNUX1NUQVRJQy4NCj4gDQo+IEFkZCBD
T05GSUdfRU5WX0ZMQUdTX0xJU1RfU1RBVElDIGFuZCBhcHBlbmQgaXQgdG8gRU5WX0ZMQUdTX0xJ
U1RfU1RBVElDDQo+IGFmdGVyIHRoZSBsZWdhY3kgQ0ZHX0VOVl9GTEFHU19MSVNUX1NUQVRJQyB2
YWx1ZS4gTm9ybWFsaXplIGV4aXN0aW5nDQo+IENGR19FTlZfRkxBR1NfTElTVF9TVEFUSUMgZGVm
aW5pdGlvbnMgdG8gZW5kIHdpdGggYSBjb21tYSBzbyB0aGUgS2NvbmZpZw0KPiBsaXN0IGNhbiBi
ZSBjb25jYXRlbmF0ZWQgZGlyZWN0bHkuDQo+IA0KPiBUaGlzIGxldHMgYm9hcmRzIGNvbmZpZ3Vy
ZSB3cml0ZWFibGUtbGlzdCBwb2xpY3kgYW5kIHR5cGUgdmFsaWRhdGlvbg0KPiBmcm9tIGRlZmNv
bmZpZyB3aXRob3V0IGFkZGluZyBhIGNvbmZpZyBoZWFkZXIgc29sZWx5IGZvciBlbnYgZmxhZ3Mu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBIaWxsaWFyZCA8amFtZXMuaGlsbGlhcmQxQGdt
YWlsLmNvbT4NCj4gLS0tDQo+IMKgUkVBRE1FwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDYgKysrKysrDQo+IMKgZW52L0tjb25maWfC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTMgKysrKysr
KysrKysrKw0KPiDCoGluY2x1ZGUvY29uZmlncy9jYXByaWNvcm4tY29tbW9uLmggfMKgIDIgKy0N
Cj4gwqBpbmNsdWRlL2NvbmZpZ3MvaG1pYnNjLmjCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiAr
LQ0KPiDCoGluY2x1ZGUvY29uZmlncy9pbXg2cS1ib3NjaC1hY2MuaMKgIHzCoCAyICstDQo+IMKg
aW5jbHVkZS9jb25maWdzL2lvdDIwNTAuaMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQ0KPiDC
oGluY2x1ZGUvY29uZmlncy9zb2NyYXRlcy5owqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQ0KPiDC
oGluY2x1ZGUvZW52X2ZsYWdzLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMg
KystDQo+IMKgOCBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL1JFQURNRSBiL1JFQURNRQ0KPiBpbmRleCA2ODM2YTkxN2M3
OS4uYjk2M2NlMjMwNzggMTAwNjQ0DQo+IC0tLSBhL1JFQURNRQ0KPiArKysgYi9SRUFETUUNCj4g
QEAgLTExMDcsNiArMTEwNyw3IEBAIENvbmZpZ3VyYXRpb24gU2V0dGluZ3M6DQo+IMKgCQlVc2Ug
YnVmZmVyZWQgd3JpdGVzIHRvIGZsYXNoLg0KPiDCoA0KPiDCoC0gQ09ORklHX0VOVl9GTEFHU19M
SVNUX0RFRkFVTFQNCj4gKy0gQ09ORklHX0VOVl9GTEFHU19MSVNUX1NUQVRJQw0KPiDCoC0gQ0ZH
X0VOVl9GTEFHU19MSVNUX1NUQVRJQw0KPiDCoAlFbmFibGUgdmFsaWRhdGlvbiBvZiB0aGUgdmFs
dWVzIGdpdmVuIHRvIGVudmlyb25tZW50IHZhcmlhYmxlcyB3aGVuDQo+IMKgCWNhbGxpbmcgZW52
IHNldC7CoCBWYXJpYWJsZXMgY2FuIGJlIHJlc3RyaWN0ZWQgdG8gb25seSBkZWNpbWFsLA0KPiBA
QCAtMTEzMywxMSArMTEzNCwxNiBAQCBDb25maWd1cmF0aW9uIFNldHRpbmdzOg0KPiDCoAkJciAt
IFJlYWQtb25seQ0KPiDCoAkJbyAtIFdyaXRlLW9uY2UNCj4gwqAJCWMgLSBDaGFuZ2UtZGVmYXVs
dA0KPiArCQl3IC0gV3JpdGVhYmxlIGlmIENPTkZJR19FTlZfV1JJVEVBQkxFX0xJU1QgaXMgZW5h
YmxlZA0KPiDCoA0KPiDCoAktIENPTkZJR19FTlZfRkxBR1NfTElTVF9ERUZBVUxUDQo+IMKgCQlE
ZWZpbmUgdGhpcyB0byBhIGxpc3QgKHN0cmluZykgdG8gZGVmaW5lIHRoZSAiLmZsYWdzIg0KPiDC
oAkJZW52aXJvbm1lbnQgdmFyaWFibGUgaW4gdGhlIGRlZmF1bHQgb3IgZW1iZWRkZWQgZW52aXJv
bm1lbnQuDQo+IMKgDQo+ICsJLSBDT05GSUdfRU5WX0ZMQUdTX0xJU1RfU1RBVElDDQo+ICsJCURl
ZmluZSB0aGlzIHRvIGEgbGlzdCAoc3RyaW5nKSB0byBhZGQgdG8gdGhlIHN0YXRpYyBmbGFncw0K
PiArCQlsaXN0Lg0KPiArDQo+IMKgCS0gQ0ZHX0VOVl9GTEFHU19MSVNUX1NUQVRJQw0KPiDCoAkJ
RGVmaW5lIHRoaXMgdG8gYSBsaXN0IChzdHJpbmcpIHRvIGRlZmluZSB2YWxpZGF0aW9uIHRoYXQN
Cj4gwqAJCXNob3VsZCBiZSBkb25lIGlmIGFuIGVudHJ5IGlzIG5vdCBmb3VuZCBpbiB0aGUgIi5m
bGFncyINCj4gZGlmZiAtLWdpdCBhL2Vudi9LY29uZmlnIGIvZW52L0tjb25maWcNCj4gaW5kZXgg
N2FiZDgyYWI2ZjMuLmNhOGY5YWZmMTllIDEwMDY0NA0KPiAtLS0gYS9lbnYvS2NvbmZpZw0KPiAr
KysgYi9lbnYvS2NvbmZpZw0KPiBAQCAtMzQsNiArMzQsMTkgQEAgY29uZmlnIEVOVl9DQUxMQkFD
S19MSVNUX1NUQVRJQw0KPiDCoAnCoCBJZiB0aGUgY2FsbGJhY2sgbmFtZSBpcyBub3Qgc3BlY2lm
aWVkLCB0aGVuIHRoZSBjYWxsYmFjayBpcyBkZWxldGVkLg0KPiDCoAnCoCBTcGFjZXMgYXJlIGFs
c28gYWxsb3dlZCBhbnl3aGVyZSBpbiB0aGUgbGlzdC4NCj4gwqANCj4gK2NvbmZpZyBFTlZfRkxB
R1NfTElTVF9TVEFUSUMNCj4gKwlzdHJpbmcgIlN0YXRpYyBmbGFncyBsaXN0Ig0KPiArCWRlZmF1
bHQgIiINCj4gKwloZWxwDQo+ICsJwqAgVGhlIGVudmlyb25tZW50IGZsYWdzIGFyZSBhc3NvY2lh
dGVkIHdpdGggdmFyaWFibGVzIGluIGEgc3RhdGljDQo+ICsJwqAgbGlzdC4gRGVmaW5lIHRoaXMg
bGlzdCBpbiB0aGUgc2FtZSBmb3JtYXQgYXMNCj4gKwnCoCBDRkdfRU5WX0ZMQUdTX0xJU1RfU1RB
VElDLg0KPiArDQo+ICsJwqAgV2hlbiBDT05GSUdfRU5WX1dSSVRFQUJMRV9MSVNUIGlzIGVuYWJs
ZWQsIHRoZSAndycgYWNjZXNzIGF0dHJpYnV0ZQ0KPiArCcKgIGNhbiBiZSB1c2VkIHRvIG1hcmsg
dmFyaWFibGVzIGFzIHdyaXRhYmxlLg0KPiArDQo+ICsJwqAgU3BhY2VzIGFyZSBhbHNvIGFsbG93
ZWQgYW55d2hlcmUgaW4gdGhlIGxpc3QuDQo+ICsNCj4gwqBjb25maWcgU0FWRUVOVg0KPiDCoAlk
ZWZfYm9vbCB5IGlmIENNRF9TQVZFRU5WDQo+IMKgDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Nv
bmZpZ3MvY2Fwcmljb3JuLWNvbW1vbi5oIGIvaW5jbHVkZS9jb25maWdzL2NhcHJpY29ybi1jb21t
b24uaA0KPiBpbmRleCBlZTEzZDJhYjk1MC4uOTVhMDVkNjRkNjggMTAwNjQ0DQo+IC0tLSBhL2lu
Y2x1ZGUvY29uZmlncy9jYXByaWNvcm4tY29tbW9uLmgNCj4gKysrIGIvaW5jbHVkZS9jb25maWdz
L2NhcHJpY29ybi1jb21tb24uaA0KPiBAQCAtNDgsNyArNDgsNyBAQA0KPiDCoAkic2lnX2E6c3cs
c2lnX2I6c3csIiBcDQo+IMKgCSJ0YXJnZXRfZW52OnN3LCIgXA0KPiDCoAkidXBncmFkZV9hdmFp
bGFibGU6ZHcsIiBcDQo+IC0JInVzdGF0ZTpkdyINCj4gKwkidXN0YXRlOmR3LCINCg0KdGhlIGlt
cGxpY2l0IHJlcXVpcmVtZW50IHRvIGhhdmUgYSBjb21hIGF0IHRoZSBlbmQgbG9va3MgYSBiaXQg
ZnJhZ2lsZQ0Kb3IgZXJyb3ItcHJvbmUgdG8gbWUsIEknbSBub3Qgc3VyZSBpZiB0aGVyZSBjb3Vs
ZCBiZSBhIGJldHRlciBvcHRpb24uLi4NCg0KPiDCoCNlbmRpZg0KPiDCoA0KPiDCoC8qIERlZmF1
bHQgbG9jYXRpb24gZm9yIHRmdHAgYW5kIGJvb3RtICovDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2NvbmZpZ3MvaG1pYnNjLmggYi9pbmNsdWRlL2NvbmZpZ3MvaG1pYnNjLmgNCj4gaW5kZXggOTUw
ZWM4YjE5MGQuLmNjYTU2MmE2NmM5IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2NvbmZpZ3MvaG1p
YnNjLmgNCj4gKysrIGIvaW5jbHVkZS9jb25maWdzL2htaWJzYy5oDQo+IEBAIC0xMCw2ICsxMCw2
IEBADQo+IMKgDQo+IMKgLyogUEhZIG5lZWRzIGEgbG9uZ2VyIGFuZWcgdGltZSAqLw0KPiDCoA0K
PiAtI2RlZmluZSBDRkdfRU5WX0ZMQUdTX0xJU1RfU1RBVElDICJCT09UX0FfTEVGVDpkdyxCT09U
X0JfTEVGVDpkdyxCT09UX09SREVSOnN3Ig0KPiArI2RlZmluZSBDRkdfRU5WX0ZMQUdTX0xJU1Rf
U1RBVElDICJCT09UX0FfTEVGVDpkdyxCT09UX0JfTEVGVDpkdyxCT09UX09SREVSOnN3LCINCj4g
wqANCj4gwqAjZW5kaWYNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvY29uZmlncy9pbXg2cS1ib3Nj
aC1hY2MuaCBiL2luY2x1ZGUvY29uZmlncy9pbXg2cS1ib3NjaC1hY2MuaA0KPiBpbmRleCA4NGRh
ODI1MDY4NC4uNTY2MmI1OTM0M2UgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvY29uZmlncy9pbXg2
cS1ib3NjaC1hY2MuaA0KPiArKysgYi9pbmNsdWRlL2NvbmZpZ3MvaW14NnEtYm9zY2gtYWNjLmgN
Cj4gQEAgLTU0LDcgKzU0LDcgQEANCj4gwqAJImZpdHBhcnQ6ZHcsIiBcDQo+IMKgCSJtbWNwYXJ0
OmR3LCIgXA0KPiDCoAkicHJvZHVjdGlvbjpidywiIFwNCj4gLQkidXN0YXRlOmR3Ig0KPiArCSJ1
c3RhdGU6ZHcsIg0KPiDCoA0KPiDCoCNlbHNlDQo+IMKgLyogU0QgQ2FyZCBib290ICovDQo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2NvbmZpZ3MvaW90MjA1MC5oIGIvaW5jbHVkZS9jb25maWdzL2lv
dDIwNTAuaA0KPiBpbmRleCA1YzU4YzdiYmFhYi4uZmUzZmQ1NDA1ZDcgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvY29uZmlncy9pb3QyMDUwLmgNCj4gKysrIGIvaW5jbHVkZS9jb25maWdzL2lvdDIw
NTAuaA0KPiBAQCAtNDMsNyArNDMsNyBAQA0KPiDCoAkiYm9hcmRfdXVpZDpzdyxib2FyZF9uYW1l
OnN3LGJvYXJkX3NlcmlhbDpzdyxib2FyZF9hNWU6c3csIglcDQo+IMKgCSJtbGZiOnN3LGZ3X3Zl
cnNpb246c3csc2Vib290X3ZlcnNpb246c3csIgkJCVwNCj4gwqAJIm0yX21hbnVhbF9jb25maWc6
c3csIgkJCQkJCVwNCj4gLQkiZXRoMWFkZHI6bXcsZXRoMmFkZHI6bXcsd2F0Y2hkb2dfdGltZW91
dF9tczpkdyxib290X3RhcmdldHM6c3ciDQo+ICsJImV0aDFhZGRyOm13LGV0aDJhZGRyOm13LHdh
dGNoZG9nX3RpbWVvdXRfbXM6ZHcsYm9vdF90YXJnZXRzOnN3LCINCj4gwqAjZW5kaWYNCj4gwqAN
Cj4gwqAjZW5kaWYgLyogX19DT05GSUdfSU9UMjA1MF9IICovDQo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2NvbmZpZ3Mvc29jcmF0ZXMuaCBiL2luY2x1ZGUvY29uZmlncy9zb2NyYXRlcy5oDQo+IGlu
ZGV4IDAwNmQ2NDlmNmVkLi45Y2QwYWJkNjBhYSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9jb25m
aWdzL3NvY3JhdGVzLmgNCj4gKysrIGIvaW5jbHVkZS9jb25maWdzL3NvY3JhdGVzLmgNCj4gQEAg
LTEwOCw3ICsxMDgsNyBAQA0KPiDCoCAqLw0KPiDCoCNkZWZpbmUgQ0ZHX1NZU19CT09UTUFQU1oJ
KDggPDwgMjApCS8qIEluaXRpYWwgTWVtb3J5IG1hcCBmb3IgTGludXgJKi8NCj4gwqANCj4gLSNk
ZWZpbmUgQ0ZHX0VOVl9GTEFHU19MSVNUX1NUQVRJQyAiZXRoYWRkcjptdyxldGgxYWRkcjptdyxz
eXN0ZW0xX2FkZHI6eHcsc2VyaWFsIzpzdyxldGhhY3Q6c3csZXRocHJpbWU6c3ciDQo+ICsjZGVm
aW5lIENGR19FTlZfRkxBR1NfTElTVF9TVEFUSUMgImV0aGFkZHI6bXcsZXRoMWFkZHI6bXcsc3lz
dGVtMV9hZGRyOnh3LHNlcmlhbCM6c3csZXRoYWN0OnN3LGV0aHByaW1lOnN3LCINCj4gwqANCj4g
wqAvKiBwYXNzIG9wZW4gZmlybXdhcmUgZmxhdCB0cmVlICovDQo+IMKgDQo+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2Vudl9mbGFncy5oIGIvaW5jbHVkZS9lbnZfZmxhZ3MuaA0KPiBpbmRleCAxMjNm
ZGJjYjBiYS4uOThiNTBjNzIyMjcgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvZW52X2ZsYWdzLmgN
Cj4gKysrIGIvaW5jbHVkZS9lbnZfZmxhZ3MuaA0KPiBAQCAtODksNyArODksOCBAQCBlbnVtIGVu
dl9mbGFnc192YXJhY2Nlc3Mgew0KPiDCoAlORVRfRkxBR1MgXA0KPiDCoAlORVQ2X0ZMQUdTIFwN
Cj4gwqAJU0VSSUFMX0ZMQUdTIFwNCj4gLQlDRkdfRU5WX0ZMQUdTX0xJU1RfU1RBVElDDQo+ICsJ
Q0ZHX0VOVl9GTEFHU19MSVNUX1NUQVRJQyBcDQoNCldoaWxlIG90aGVyIG1hY3JvcyBhcmUgbG9j
YWwgdG8gdGhpcyBoZWFkZXIsIENGR19FTlZfRkxBR1NfTElTVF9TVEFUSUMNCmlzIGV4dGVybmFs
IHRvIGl0IGFuZCB0aGUgcmVxdWlyZW1lbnQgdG8gaGF2ZSBhIHRyYWlsaW5nIGNvbWEgaXMgbm90
DQpvYnZpb3VzLi4uIFRoZSBwYXRjaCBpdHNlbGYgbG9va3MgZ29vZCB0aG91Z2gsIGJ1dCBtYXli
ZSB0aGVyZSBpcyBhIHdheQ0KdG8gbWFrZSB0aGlzIG1vcmUgcm9idXN0Lg0KDQo+ICsJQ09ORklH
X0VOVl9GTEFHU19MSVNUX1NUQVRJQw0KPiDCoA0KPiDCoCNpZmRlZiBDT05GSUdfQ01EX0VOVl9G
TEFHUw0KPiDCoC8qDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cu
c2llbWVucy5jb20NCg==
