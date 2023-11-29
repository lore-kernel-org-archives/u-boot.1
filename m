Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003CDC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 12:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9F508774B;
	Wed, 29 Nov 2023 13:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="BvLN6mbS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2C6386F1C; Wed, 29 Nov 2023 09:05:39 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90D8186E6B
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVXTpDkupAvhwADvzBqRkwKXXlHD+SR07u1yRQAGGHe0vYER3MOSAL7KDBONo/7icz/TdjtarMlGd1O98FE48ibxO4RNNQuCNiaNbA8WnBkFgWQ9iQavAFzClzIoF5tHZ7mOjVzSSJwQ+f2121vXkQPbZxceFINxCz+5x3Zb97QDhzx3eurK/Kvj/NJMuU5u39OQfsrpYnw6P4Ecxon+VtSuJ7Uw2i94SjYFPEZqVkDEKfGpEq/ZWcYWf/+wKhqOtS2li/KXEG67TW5l0YcvpFtt6orXxk7BVcRe8jAcB0nhyJYaOHVMuEw7612o0gxHMOfI+5D6lvhyl/R5DraG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJyEnFycem/SLBImjIkftzFIq9uOXBOE+ALUrYEYUEw=;
 b=D2mlLQmfbiPUVCwmATJ6HIFr9d+Q7jM08IAYti9A8jaDDn6unqydr8NdhotMk62NIqBJZ5fsV+xxlUjejHySQG6qSGmdUSLxol+HxYJUfsgr9DofGVEJAU/laOYT6hMEZjIQ8YYzsJ6aaW5pxzRPjlpK3fGH1svCIvuRV2WKLgwjmHK7qsu5LPIpkIcytYGs/W5/xk8JMe4sybnCBqFZy9Tp+gSo0hPADsoByqCB0Q3vGAULQ5s0Nvk+B/do/fRfTR3WaV3J8WZjZl4Q8Gjq/32s1NuvtDocI0l6d6WTk8+VCpPhTvu8K7XUW7s9qdDqkdp0p25H+8GULtYOQskaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJyEnFycem/SLBImjIkftzFIq9uOXBOE+ALUrYEYUEw=;
 b=BvLN6mbSRQmuxYe64EGtWMSkSfhP+v9+7NY3kRP/ezCyjRjIHOpjI54i0jVU4LKDUzrQDQi0zwijuUIgqY6gv6DLc1rF7L0yhM7uHXpWD5BeSV7SrF6F4pr71/9ufNKBtk3YutjeWHrsdrczTyA8HXR3Ino5+R4wIv71th6Fk5aF7KrXWp8cjCniiC3dsFNaFJ44frDME1c7vln3ZgxYLPHl/2bBODdrg6yIuQL1gAfjUDc+Yyb9mMMQcc09pBG9jRNnByueaf1TR4DFlRIMwj7CUSUdldem+O7fsA1oLcHzDYuIXGK+x1g2qj3hUBBNydd5VYpVGXzV2RGmYIk/Cg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB7506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:425::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 08:05:35 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f1e6:2701:4840:b64f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f1e6:2701:4840:b64f%5]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 08:05:35 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Leto, Enrico"
 <enrico.leto@siemens.com>
Subject: Re: [PATCH 4/6] siemens: board: clean up draco products vs common
Thread-Topic: [PATCH 4/6] siemens: board: clean up draco products vs common
Thread-Index: AQHaIpgFlH6o+333OUWp45YqHrbMtLCQ8HmA
Date: Wed, 29 Nov 2023 08:05:35 +0000
Message-ID: <8c7d170299b2c79f4663e9db9609c863e1d2e101.camel@siemens.com>
References: <20231121142134.2147652-1-enrico.leto@siemens.com>
 <20231121142134.2147652-5-enrico.leto@siemens.com>
In-Reply-To: <20231121142134.2147652-5-enrico.leto@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB7506:EE_
x-ms-office365-filtering-correlation-id: c64a5c6b-1b80-4924-91dc-08dbf0b1f7a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i2Eg9walWdSVFFjHWzS3WSio+ycIEo6HLxt0jjh/pwDNMhRq9GJuyTb+L2Wz994Xw9AIjMIqfurXPi5z3KO+8Cx7Vd2EdX/IPweotgjs436doNK0LWTPp12msc3AeTgW88Y4DGNJu/PCxmQPi2BodLJFCgaIO9g3ADUajWeUD17YujW5yuaszpTW4rbGKJnbaRhOpOFO1nAVeo5WaCG55dUVRF2jtlAcgtMeIhKkLGcxeQshZWRfJE3fxQYcXraE1P+r92SHt+Cooew3iGQzYDBP8WZ1zdybWuvAvjXlBXC96hSP9t8IE4rkodiqxtnfJe+sweTNzYF061M67bJLkeUVwTvt18/4jlXbSn4HKTKPwbZRTDd/mYOv5HmHDx0dE9yrujYilB/SqrSxzRj2O4EcfO8eTCw4wR36ad5WysaKD+oaJtdMdptJL/AnjuHlTD0sW1Z2mYT64OZcK8gXfXUePs0IHxd3NBk5hCF/pce8PmjTwK/+V1qGRILj+ztQ4g94Mbrc6FkgiVSy2NY2XnJ20oGOCC1mHW/UyxYSD4+LGKQh76MYe0wcHgSEK2QkLAkEBqrmr+fS2B+H/db5jNzcMK0c3wOpca+0W/ggIMt06ZOQXjfsZfNuaTDt8Nnt9UEkXwVGKsTxAztvYzy/BQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(36756003)(41300700001)(4001150100001)(38070700009)(122000001)(15974865002)(83380400001)(5660300002)(66446008)(2906002)(82960400001)(26005)(86362001)(2616005)(66476007)(6512007)(6506007)(8936002)(8676002)(71200400001)(478600001)(76116006)(110136005)(316002)(66946007)(91956017)(6636002)(66556008)(6486002)(64756008)(18886075002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTFxc1I5VDZuTmtSY1NoSzBHdUlwWG1MbThWSUc4M3k3MjdUQXBXU2FPQjJh?=
 =?utf-8?B?d0ZZRWhOd0YveHVJejBRR0ZaY21TaFdBcklkL2lXZkM0dmF0RjNYbGlpVm1n?=
 =?utf-8?B?QTgwRmtIaWJ2Vm13T1hIRnNrak1XazM0NytYUmFMem1aL09wV1dpU2s3ZG4x?=
 =?utf-8?B?UUNoZSs2Wi93YWNYSG5LcVNZNUdxRXlmT01XOEZOMU9NSGpVSzE5ZU1XYVRR?=
 =?utf-8?B?MndXMW9Va0FsWmR4cHR6V2kzUGFLUXZnSDZQblR0Y0lMdWRWVmx4OCt0S3cy?=
 =?utf-8?B?Um56QmE1Z1QwWmJscThGV0MxWHRwcHVCcm50T0pCSEFCbndySmRiNGJPd1VR?=
 =?utf-8?B?RTBhU2diTW5oTHlHMTZYT2x4amRudkR2Um1Kbm9DUEt0K1Q2MW1kMThYSEtv?=
 =?utf-8?B?cjBla3ZRbytjUUppUzNybWhaYTZ5Zk1MZnU4Z3FoN2Jsc041Ri9HaXI0QUFJ?=
 =?utf-8?B?M3hyQ1NPeG90R2NGelVyMCtCOVQzVmhxTTRMMlRCK0daSE9XRnBmQlVYZHY3?=
 =?utf-8?B?T0RkbWhEYW5EN01sUDhBU1lCUnh0OTJqOE0rQkZLcjZBYmlMakU5ckF3UDN1?=
 =?utf-8?B?NXo5TTY2MVNydzBrQ3c4M04rcWY1eHQrSGc0K0tTdUtMM0RrY21kTm1iNjA2?=
 =?utf-8?B?bkVLVTYyY1R5LzYxSU44eFo0bE40bjFwYU1qb0JaUXpTNGVSSmZlMEF3ZWtk?=
 =?utf-8?B?aHorM3dLL20wY3NocWl5bTlLQVg4ZE9ML05CNDhVNTU1WUhhVGlWUnhGcjZI?=
 =?utf-8?B?VDRieHN6ZThINVBXdnIvTFA0Z1ZBWERVZkVJQzJZWk1Rb053akNJMTBZS3JJ?=
 =?utf-8?B?NHBrYkdLSnZRNjlKMSt4SlZFOVJSSjQ2bzNyQS84L2s4d3V4aGxDOVdDN2ZL?=
 =?utf-8?B?c3RFZHhqQlNHTm5odVJkajhsY3pOejkxZUZBUHVGU1Buai9iTS9peGFjcHk5?=
 =?utf-8?B?SVV1N0ZKaG52YUFsVXByMWNvbExYVEkvRnp0SU9JeUhtOEN1R3FqSU1NaURC?=
 =?utf-8?B?bzJ0MWE3MkY2bVorWThZUDdTM3UyektMSndKaGZ3bWlCbFBOOWZWYmJRbGh0?=
 =?utf-8?B?NW9pQnd2Wk4zUUpuMG81N2tnRUJhSXp5ekk2aVBHTUUzSEYyRkg3Vmh0Wm91?=
 =?utf-8?B?WGFJVGxZREErOXZlZ3FSTWNzVFVYYjU3ZHhaV0d4M3pRc0FrRlNkYzQwdXc4?=
 =?utf-8?B?QTVROFVmczVKUExOM2puY2hhMktFd3Roa3ZwWWkwQXVzR1Jwd3VZZWdKS1JR?=
 =?utf-8?B?WlBZdHF2aWthT0ZEYTdFYWxSSnFrMG16cThDM1BYVnNCUG1kQTFXaDVMUk9l?=
 =?utf-8?B?b25Ob0l3REQ3QXkxQTBFOWZBM1JveC90bGFUQ1JwcVF2ak9BVUpVZVlZenZ4?=
 =?utf-8?B?TmY3L0tKRjV0cWdRRWdmYTNqZERoNkd1WUpTRmFvKzRvVmx3QXdTcUsyMUNJ?=
 =?utf-8?B?akNvTEpIQ29TYm85eTNBQ0R4NDlFM01qOGZBWWN1MjJKRnBXdzd0bmZidDg1?=
 =?utf-8?B?U21JUitWSks0YmZQbnB6SjZScDVxMDc2QkVINWVjajZoVG1pajdwVzE0Qmd1?=
 =?utf-8?B?Y2pyejhJeWl2NEU2VDh4U0ZBRGFQTTRiMUM1WWVOS2daWDRReElmVUQyOHlJ?=
 =?utf-8?B?dXhlbC9lT21mY2FUNW9KdDQxUGFoNTB5ZDBucWdSd1ppbFJqcUlrZEd4YmNw?=
 =?utf-8?B?U3YxRVdqYndHRVNzMk9DK2NNeFFGUXRiQmJ0NUxKREJ0ZjRPRmVhMENSUjFq?=
 =?utf-8?B?LzgramhqNXZaMUZIekh0NVpvTGc1ZUlWRVQ1WUNmR3NPN0ROa0tnSExLT0t4?=
 =?utf-8?B?KzZraFZHQUxGWE5nZE5QYXhBTGxOWkc5bFRtS3pmalIxaVBuT2k5Mk1JMFZ4?=
 =?utf-8?B?TWZ6OGlmVC9ndnRiNkNnc0xFck1KV2xoZ01lWUYzby94VEY0ZUM2SUhLeU9K?=
 =?utf-8?B?aDBXZkNLc0lqcjRIeEo1Zk1GYTNRakpzazA1ZDlGL2xHWiswakc4NUs1WDY2?=
 =?utf-8?B?elowRkduZVFtZ0dnZk1Hem01Zk9aUTFXRHduTWZyUWRPdjZUUHFTaVdURDdn?=
 =?utf-8?B?amV4N1pQWEU1UFJGWTdWUGsrUjNKME1BTVJ2c21Za0FMMDh2S3hMNEdhTFR2?=
 =?utf-8?B?ZG9oNmNLcnVJVWR4aG9tK1RPSnpaOUxFMmxBcm4vSEVJQWUrRVdqWkVhd3oz?=
 =?utf-8?Q?yXNNwd8apkWSnYDeR327UdI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1812696DF66E3E4B9808317DCA75D243@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c64a5c6b-1b80-4924-91dc-08dbf0b1f7a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 08:05:35.7029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOdQANrkzdrcaCLDgvXFk8BZbsnMLpLqJNGTirVmsiDLYO2yM1YBVfOP98RbBaI5WNIa8PKRcxhGMAGqnPmetHQs9+IvGwKasO/xXD+bx5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7506
X-Mailman-Approved-At: Wed, 29 Nov 2023 13:51:19 +0100
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

SGkgRW5yaWNvIGFuZCBhbGwsDQoNCk9uIFR1ZSwgMjAyMy0xMS0yMSBhdCAxNToyMSArMDEwMCwg
RW5yaWNvIExldG8gd3JvdGU6DQo+IFRoZSBjb21tb24gZm9sZGVyIHdhcyBpbml0aWFsaWFsbHkg
Y3JlYXRlZCBmb3IgdGhlIGNvbW1vbiBwYXJ0cyBvZiB0aGUNCj4gcHJvZHVjdHMgYmFzZWQgb24g
ZHJhY28tYW0zNTV4IGJvYXJkIGZhbWlseS4gVGhlc2UgYXJlIHRoZSBwcm9kdWN0DQo+IGxpbmVz
ICdweG0yJywgJ3J1dCcgYW5kIHRoZSBiYXNlIGxpbmUgbmFtZWQgJ2RyYWNvJyENCj4gDQo+IEFk
ZGluZyB0aGUgbmV3IGNhcHJpY29ybi1pbXg4IGJvYXJkIGZhbWlseSwgY29tbW9uIHdhcyBlbmhh
bmNlZCB3aXRob3V0DQo+IGNsZWFudXAuDQo+IA0KPiBNb3ZlIGFsbCBhbTM1NXggc3BlY2lmaWNz
IHRvIGEgbmV3IGZpbGUgJ2JvYXJkX2FtMzM1eCcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbnJp
Y28gTGV0byA8ZW5yaWNvLmxldG9Ac2llbWVucy5jb20+DQoNClJldmlld2VkLWJ5OiBBbGV4YW5k
ZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCg0KPiAtLS0NCj4g
wqBib2FyZC9zaWVtZW5zL2NvbW1vbi9ib2FyZC5jwqDCoMKgwqDCoMKgwqAgfCA1NCArKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gwqBib2FyZC9zaWVtZW5zL2NvbW1vbi9ib2FyZF9hbTMz
NXguYyB8IDU4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKgYm9hcmQvc2llbWVu
cy9jb21tb24vYm9hcmRfYW0zMzV4LmggfCAzOCArKysrKysrKysrKysrKysrKysrDQo+IMKgYm9h
cmQvc2llbWVucy9kcmFjby9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgIHzCoCAyICsNCj4gwqBib2Fy
ZC9zaWVtZW5zL2RyYWNvL2JvYXJkLmPCoMKgwqDCoMKgwqDCoMKgIHwgMTAgKystLS0NCj4gwqBi
b2FyZC9zaWVtZW5zL2RyYWNvL2JvYXJkLmjCoMKgwqDCoMKgwqDCoMKgIHwgMzIgKysrLS0tLS0t
LS0tLS0tLQ0KPiDCoGJvYXJkL3NpZW1lbnMvZHJhY28vbXV4LmPCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgMiArLQ0KPiDCoGJvYXJkL3NpZW1lbnMvcHhtMi9NQUlOVEFJTkVSU8KgwqDCoMKgwqAg
fMKgIDIgKy0NCj4gwqBib2FyZC9zaWVtZW5zL3B4bTIvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKg
IHzCoCAyICsNCj4gwqBib2FyZC9zaWVtZW5zL3B4bTIvYm9hcmQuY8KgwqDCoMKgwqDCoMKgwqDC
oCB8IDEwICsrLS0tDQo+IMKgYm9hcmQvc2llbWVucy9weG0yL2JvYXJkLmjCoMKgwqDCoMKgwqDC
oMKgwqAgfCAyMSAtLS0tLS0tLS0tLQ0KPiDCoGJvYXJkL3NpZW1lbnMvcHhtMi9tdXguY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0NCj4gwqBib2FyZC9zaWVtZW5zL3J1dC9NQUlOVEFJ
TkVSU8KgwqDCoMKgwqDCoCB8wqAgMiArLQ0KPiDCoGJvYXJkL3NpZW1lbnMvcnV0L01ha2VmaWxl
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICsNCj4gwqBib2FyZC9zaWVtZW5zL3J1dC9ib2FyZC5j
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMCArKy0tLQ0KPiDCoGJvYXJkL3NpZW1lbnMvcnV0L2Jv
YXJkLmjCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIxIC0tLS0tLS0tLS0tDQo+IMKgYm9hcmQvc2ll
bWVucy9ydXQvbXV4LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiDCoDE3IGZp
bGVzIGNoYW5nZWQsIDEyOSBpbnNlcnRpb25zKCspLCAxNDAgZGVsZXRpb25zKC0pDQo+IMKgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGJvYXJkL3NpZW1lbnMvY29tbW9uL2JvYXJkX2FtMzM1eC5jDQo+IMKg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGJvYXJkL3NpZW1lbnMvY29tbW9uL2JvYXJkX2FtMzM1eC5oDQo+
IMKgZGVsZXRlIG1vZGUgMTAwNjQ0IGJvYXJkL3NpZW1lbnMvcHhtMi9ib2FyZC5oDQo+IMKgZGVs
ZXRlIG1vZGUgMTAwNjQ0IGJvYXJkL3NpZW1lbnMvcnV0L2JvYXJkLmgNCg0KLS0gDQpBbGV4YW5k
ZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
