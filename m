Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E6EC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 12:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DB0187777;
	Wed, 29 Nov 2023 13:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="zp7TIl2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8633F86F1C; Wed, 29 Nov 2023 09:12:52 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FE878654D
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DztZehfEZ4JbHAUKVSm79q0iea4Fu4JEDxE52nwRomvybdG291wOAG3t5NM9L6ccDHk0t7tFw0jJPbS+ANhCx9ThLC2BtNSfhojc2OD28RxnBuoUrTeB/RGp1Q8jInonyaz2Ym3PViAnihy1nKrCFw/+q9ITFmxgj05jlW1ACegQkQflu1uUeM/3kqnqt3QXFWcH5Uy7iH13n71/do2nL+HhVh23rCbhtFPIGyGHfK8pzH2WSoKGo4mW4wI/ZdC7pb87lx2ob+mCcAJRCnh1vrtxRRB9w3niEvhmatsxtyjo/89RYlQTTx3m6X23zHQu3ifPCDmhIFp0fU23ByKhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3N4eQclcs6JovtGnNud7xvHDJRWagslus23RBCka1U=;
 b=eEYCET79gOG+HJoAKOCpiYg+x8tW+VoCniEdt3G3Cno0fFEQt5/TXRobwnZoYVJsoYzsVS6RpinJ/8Z0xtdwa3JIzFu9dAmBXtnaryhlfFZtymXzOm1IE4fomw9FWbK1abvkavxEAzFlIqavYClUqIw1XAf52BsfEmOnDjIRc8sWMmDEMw5QwVCW84SICPhCFK/oFQ4IPzbay5+VO/WXDOBhx0P3t/7N+97znLU3R3QKw7wGDHzqbky4nOeojHyjS+ZaEiEGoNvjLU9l98e84Q6FQe2wehwS+itbIiHc4WK8wnxA/210oOMt6hB3cpJAaXcg7glHyYsUxsZFBZ4w9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3N4eQclcs6JovtGnNud7xvHDJRWagslus23RBCka1U=;
 b=zp7TIl2X2R022ZxltiPgYJGu6N8121j7fvd0K5U20QJ846g68Pez3nnpBto8o4wRx1cGMZzQlCJzwV6B0e193M335Jd34WoGj2StOo0r6cizg0dKvH6PPFWbXlcfpyzU0m0QKwjw2nClIWqASyOqUroBMQJVVEBwAn8iROSc726PlnEPifmEwLmzAYDa7ydY52VmzPtCLmhipwkP2lChtu6ivwRSeJR91qfD2tNkSmCKh08tUvpigriuWJyhtHzp6jTPP62f3BhEP1gC1jHVR9MXAXx0wtJ9zFc6qogRwMhBkcOBCYJGIvwB74WVAwCiSAhCJM8GJV/9xXS6Y4GOCA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB8PR10MB3530.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:137::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 08:12:48 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f1e6:2701:4840:b64f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f1e6:2701:4840:b64f%5]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 08:12:48 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Leto, Enrico"
 <enrico.leto@siemens.com>
Subject: Re: [PATCH 1/6] siemens: eeprom: clean up definitions
Thread-Topic: [PATCH 1/6] siemens: eeprom: clean up definitions
Thread-Index: AQHaIpfMizk0MYjn/UW97AIedRAqyrCQ8n4A
Date: Wed, 29 Nov 2023 08:12:48 +0000
Message-ID: <eab2f1a649a7ed4fdbb53eb94aaace7a8a1f9e0c.camel@siemens.com>
References: <20231121142134.2147652-1-enrico.leto@siemens.com>
 <20231121142134.2147652-2-enrico.leto@siemens.com>
In-Reply-To: <20231121142134.2147652-2-enrico.leto@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB8PR10MB3530:EE_
x-ms-office365-filtering-correlation-id: e15bc8b2-f379-48cd-0c5a-08dbf0b2f9a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JW2MtSxHQUUHuY56vsKdFR3cqCXISoc5rYVwsh1S3TTRE+xPvf+w28Z/oNnLdU4Nj+XLGfF69K/WzyzG4CbcDWpopOt7hCks1WORWxUwi4VGqIiUKUHleOxpcQeumXFLLoXwd9/VPLD9Xb7HL1epYjBK4HItMqv02vCeHSsRXo0k62bDZ+h0+JxMGWxtYnxxKvChl5E5PTD/mg+pOYur0ifT6CK9IGk3avU9CkZX/ARePnPK9Q0QDIvAxTWhcXVwPBAmyB3RLpt1nocrnpYguBwWJ8Poxi+umH0HP7d/JEB08pg8W7RAHym4ReFR2ShmaCX2xZ0FA9n39udiHP2Hsc219uutmVYXyH7/0sZ9CJJJMJLgbHa8OrDnbwEB3CjAb+ycy6dQS2aoTRkxqHVrP548pMJiNo94WhTBMUYBpWXpiwkRyIH5z9/hql/bAEWa0E2Ww02W3rnmXticwGwWUZtis+jVEoIDM1052+s1jA9Y7Ujw1rGvnSPD7lefJkrmwKabPuwItXoWn1mj4/8eWzwOQXfw65PXI5I0j1Sze0J8FQHGIc3sSD3Cw3IWrrW7/QvT1yVRh0aT/aPNesXVQdYlYzJWhzK4caDeRs8eaHd64BCdUSDi2gGl+tz1uj+VlmKVMx2TKSR0PnxRMbcHZw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(316002)(6636002)(26005)(6512007)(6506007)(2616005)(8676002)(8936002)(2906002)(71200400001)(4001150100001)(478600001)(4744005)(5660300002)(6486002)(41300700001)(83380400001)(76116006)(91956017)(66946007)(66556008)(66476007)(66446008)(110136005)(64756008)(38100700002)(122000001)(82960400001)(15974865002)(86362001)(36756003)(38070700009)(18886075002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEptVFE2OXZENTdiMWZLQ3FqMTRLWmJIVmJOYkk2Y1VHVE5SdFU5Qjg4U2E0?=
 =?utf-8?B?L2pnOWsxNE9GcmpEM20wU0tpZ3hDbnUrU2VVK3REYklZcDZtZlNKZTRtRDNo?=
 =?utf-8?B?aTE2ekNhS3hwUVNtL1dnUkpNWW9jTkRJRndGKzR3VzZIOFVLdHoyRlhOYnhp?=
 =?utf-8?B?Wkd4aVUyTmVTQ1pjZHlRdXF3dlVTZUxrQ0htWGt2TDNRVFlzRXBteUtrSDBD?=
 =?utf-8?B?SWFCWlBLRks2czUzWFkvdkg3aXVyK085Wm1aS2xMcFhnQ0hlRHF2Z25ZQmx4?=
 =?utf-8?B?MzRwTzRXRE5SVVUxb1lYbGxYdEVpQ2JJcElSOGZscjZSa3hGWUhPMkg4M2Fz?=
 =?utf-8?B?M3BEU09IU2JSNDlTWS8rOWRESlZtdHJLMEt3cUU2eGd6Nk4vZlNVTGJQemYx?=
 =?utf-8?B?MGhCVUlMTWxDMDZSNjZRQzhka0dyalBzaUY0dzlSZjFZVXhWNFFCWmhUdlJY?=
 =?utf-8?B?Snkxako4REdVL0NteGN3RWgvalpNZjJ1TjdNeUpWWVhQcm8rZEtWU1VDeDY5?=
 =?utf-8?B?ay9nWGlucWNSSGhneG9NQmJTMHUxazNpQlJEK3BsYStzUHA2OHJNaGtHa0V2?=
 =?utf-8?B?VzYrYklHMmU4TFRKT0N4WjU0aDlpYU1xckp3amlBVWllODFwdGgzUUpFKzQ1?=
 =?utf-8?B?a1BIem02TW1oR0xEZmlwNngvY05sVGZSQXdDZmQ1WHFCS0xMR1EyQWJNaXE4?=
 =?utf-8?B?K21jVWdQM1IrdkZOMUlncVdlYVFqa3B3VkRLY0Q0MGpmN0lqR0dzajdlTW5K?=
 =?utf-8?B?STVEV2pobm9QNStIYTl5Wk4zTnFxZDNFMm1odW45MXdMMWJVMUFnZHVsajcw?=
 =?utf-8?B?SXQwbGxINUZNUmJVZVBzSXp3OGduZk03NHN6THFramZNZU5NRnNVK25VS1BM?=
 =?utf-8?B?NVI5bm5SUFdqbGJiK2k2V2RvbEhLRXdJVTdaWWNHRi9WR0xXR0YxcUhGR2dm?=
 =?utf-8?B?L2Q0eGZjYWR2TUZKbDMxRmU2NVFqY00yS1A1cDdySmlqeldLdEVIOEMvR09l?=
 =?utf-8?B?TitNM1ZReS9mOElzMC9rMy8wWWxYM29tbnZDV3NLL3JGYjF0ZFhFd0NGZ3Ri?=
 =?utf-8?B?S1Vwb2psY0hZeHBMZ092Tmd5Q0xEVlAwVW1wRWJYYTkrd0ltN2pFT2UxWGNq?=
 =?utf-8?B?ME5ucm5lOW1xdTZwcmhDTkxYTENjOWxLWXFBQm9EZDFMYURjN2ptdk03RmxM?=
 =?utf-8?B?WGZJWnpzeW1JcklLMGZIdWpGSkIvdzFBaWRVcUZDSXFzc3NLeTd5emxZTEhV?=
 =?utf-8?B?QmdWSWNrLy9zbzJYUlU5NXRVZHI2d1Vra2Q3VndNWXlMYWZzK1BidUN6NEhK?=
 =?utf-8?B?K1VEQXVtdmd6akcvWi95amdHM3ZIa0E5R2RFYWc2QmJNSStQV0x6YTlxMy83?=
 =?utf-8?B?eXE4ekl3R0ttZ2ZKUHc5QTQ0cjFaNnhRN3lRK3A5ZEpTOEt5WFBNemU0eVgy?=
 =?utf-8?B?bDFyUDB3NGJKU0pZdXJqcHdxT21qNEtxc3NBQ2l2T0libEhHcWc0QUgrZXZE?=
 =?utf-8?B?RDA1bnF5ZVNzOXJ0UGlMM3AvN2ZDYnlQQk5ZYWR6T09oUXNDaEhjVmpYOUVC?=
 =?utf-8?B?WW5uSSszcXVYdzBBMFhKQXFRcC81NkR0NEJnSzkzY3F1eHdLQitxUjdKdGVU?=
 =?utf-8?B?Q0pia0xwN3JLMElnNVNnZy8yTS9rbVhBRm5Eb2E3MUR1RVRsUmZYUjJFVEp0?=
 =?utf-8?B?a0p4bytjbE9lRHhQUmlDVFFCSWJjMzZldVUwTGVHNTlpb0dQU0ttOThXTFBQ?=
 =?utf-8?B?bHB3UDJVbm84bHY5NndaTTJ3WFVKWkkxbXFlVndGZytlN3hLOElNNW1paVY1?=
 =?utf-8?B?TzhlSDFsNEVrZy9iR29JME5OMUhleTVEQzB3bGdwUGRNMHN0aTVsZE50MHo0?=
 =?utf-8?B?MUZwanlZYk9mQmJVa00xbWc5UjNwazdncytYY1h0OEFzbjM0WXZIa25Dckdz?=
 =?utf-8?B?Z25jb0NCNzh5enFZNDExc3VuWGl0clFZTnE3d3p1N0gwS3JHeFpmTkgyOGg1?=
 =?utf-8?B?LzQ2NkhRQ2dMQlNGQkI4UW9yR1VHdFh4SnIzb0c2RXQvV0pvV3pGaGlyRkVF?=
 =?utf-8?B?NnZYS09xOVB1UmlEcWNPV2JVTVBqTWttVjRKbjJYNThGcVJBeFZTcndLWVJQ?=
 =?utf-8?B?ZXZIbEdta28vZ3JuWU56UWFKbSt2WUk1NU9iczZGWjJrSVR2V0ptdDhuSElk?=
 =?utf-8?Q?nTUv3eBlvzCLbnyEFkMqS9o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2660EC2ABCA9684484EFF6726DC949F5@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e15bc8b2-f379-48cd-0c5a-08dbf0b2f9a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 08:12:48.5857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aFD5j+lJowobnem/JtJMZxz4S3JHxnY8VPsbPv0fa0dJh7EaQp5eblluzzvnaeSeY/Y27sPenwFDtteB7gh/fixxvwOpZBLFJZ5ru5g25hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3530
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
RW5yaWNvIExldG8gd3JvdGU6DQo+IE1vdmUgdGhlIEkyQyBhbmQgRUVQUk9NIGFkZHJlc3MgZGVm
aW5pdGlvbnMgaW4gY29tbW9uIGJvYXJkIGhlYWRlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVu
cmljbyBMZXRvIDxlbnJpY28ubGV0b0BzaWVtZW5zLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXhh
bmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0K
PiDCoGJvYXJkL3NpZW1lbnMvY2Fwcmljb3JuL2JvYXJkLmPCoMKgIHzCoCA1ICsrLS0tDQo+IMKg
Ym9hcmQvc2llbWVucy9jb21tb24vYm9hcmQuY8KgwqDCoMKgwqAgfMKgIDYgKysrLS0tDQo+IMKg
Ym9hcmQvc2llbWVucy9jb21tb24vYm9hcmQuaMKgwqDCoMKgwqAgfCAyMSArKysrKysrKysrKysr
KysrKysrKysNCj4gwqBib2FyZC9zaWVtZW5zL2NvbW1vbi9mYWN0b3J5c2V0LmMgfCAxMiArKysr
KystLS0tLS0NCj4gwqBib2FyZC9zaWVtZW5zL2RyYWNvL2JvYXJkLmPCoMKgwqDCoMKgwqAgfCAx
MyArKysrKy0tLS0tLS0tDQo+IMKgaW5jbHVkZS9jb25maWdzL2RyYWNvLWV0YW1pbi5owqDCoMKg
IHzCoCAzIC0tLQ0KPiDCoGluY2x1ZGUvY29uZmlncy9kcmFjby1yYXN0YWJhbi5owqAgfMKgIDMg
LS0tDQo+IMKgaW5jbHVkZS9jb25maWdzL2RyYWNvLXRodWJhbi5owqDCoMKgIHzCoCAzIC0tLQ0K
PiDCoDggZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pDQo+
IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGJvYXJkL3NpZW1lbnMvY29tbW9uL2JvYXJkLmgNCg0KLS0g
DQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
