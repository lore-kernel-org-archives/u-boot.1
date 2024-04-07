Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF411CD11C2
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 10:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45B9487FB5;
	Sun,  7 Apr 2024 12:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="QZyqWNpQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F7A887E87; Sun,  7 Apr 2024 12:26:36 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2071F87EDC
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 12:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fpsd2K4OWii4dVzZYSjcPbKJ4Lv6Wc84Pe3NtnlqDAigCPHNYuCIOa7Xo8jGOgj3pM0VObKTGVrYnGc/RWwd9RhAJMY84pTrrGqNNrLSqq0LYFODF4pE6LJ+/bkChm2Rhj+EaKJpZkFpXV3TeqUymmGQWol/rcpQjMKWrf5HlGCzZBJeVKK9F2SfJwbqBU29nyBt14F9PKgnj3Qykw7fAFhz0FQ7eo6CJXclYwx7LDazrEVhYKOP8xDTWoQgP2ScHhy3Zpk4JUhonAa5Tz1Ysvy+1GZXm/9PoZV19XfIlLRugh+71GfXqBqItvR6jgNQ5MniWgYwZHJVBBNTMRVCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0VaICtzxEHYS6ccf6FdVIYX7Ck5xCqvGcDxnkbIiAg=;
 b=HJa+sZHNTam5Ph+1RcHCeeDIyXPtHEcpRhltDnwkkkiVPf52Y7ZdtD9KQ/CN0jaXGYYeC/rWV/KzFQ08S/B+BzNw5IiQp8SBQBoWOO3GV1Aff8I1Tx47RAJU9orbeYqWJywlwj1/Xc5qDxEkkvLX6J2TAY0Ob86z0r06xa+jaVIeLpZhCGM3QWskBcUooJ5v0O1NsP3QynGOA+T9Vyaz5NNlyp30hM/bxqoHNlfcEnHBE6tVV6pxwJEGOQc5tY6FljQlmQekKrBOmP4MNscdSDB3XAE278sSeshYwTnRjlZiV6mlQeYyDY1lDr4vijLwZrMVOlPkvzBRim27KfGN/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0VaICtzxEHYS6ccf6FdVIYX7Ck5xCqvGcDxnkbIiAg=;
 b=QZyqWNpQcGdyRu20eclTrRoLA4f/7SkoMZlfvUN6Z4/3atuvUsVxZ0KduCmZQle1f7QEFN3q3qeR1HJPkw9Gf+jvgElRpRUMLVNh4uNjnFshzHxWF/7LNgDFGZyPmzo6da6nJdwh831u903M/ZloFfwOhNdYXZGO/hVNPy+5pdk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA2PR04MB10214.eurprd04.prod.outlook.com (2603:10a6:102:404::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 10:26:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 7 Apr 2024
 10:26:31 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 =?utf-8?B?U8OpYmFzdGllbiBTenltYW5za2k=?= <sebastien.szymanski@armadeus.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Mathieu Othacehe <m.othacehe@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
Thread-Topic: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
Thread-Index: AQHagMVDT80nSMU610ixQHv1ZnD59bFcqpGQ
Date: Sun, 7 Apr 2024 10:26:31 +0000
Message-ID: <DU0PR04MB94174FB9E94F1F74DA64F53688012@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
In-Reply-To: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA2PR04MB10214:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FYkVBoxZu21y2SJO5jeuDlqgZXgnPofc2kbJPossGE4awn6bDEbYWyXlgB3x5g32cMSdJAYPHvwgGIthl9bbK9kUNDSmA4vusl+c1C7ClC+GHozg0rex2oZ6FfXCFPwSYwrlIohWDq0P8sahNJ+qu/KBcUzoXOosL/V82esg4VGHigJZyRSF8p5PUBJ22gG5nzbzYpQFU8pyIesfSBbfSBIptcf2fCo05E6oQEiQk20q4IqhlfDdQjMIMczb5fRyVXSSTYux/pJbW2SdOro+WJLslsBWL3h/5TcZcNlt3sdYB9CtzMsOlPDwSlTHjDXmQo9NmhnjnarmEyykmp6c3vN5kB+7CFO8fE2H2rrOnG7rTuDDaYobQHogocWAMqBb/QdUgu1NJJuoWMH/8uFPcfjI+eivt56fu/ck9Z4b2AnvHwi9GL0KzJA3oeCipIglYkwlnkdY2JzNZLPVvhSYNtiJXMQ6dh1qv9weAPOjnJUVskMyfunLvmuRTvBO0U96sOzxJDQ7ijByPfV9Pgyu3qEKfU9zKPrDYhIpArQqR2rePSW0QkgF3XmeVp61O+x5WMtc+09U94BUKpPgNqq6I+dr9bkKScabuid1nwcvhSw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enNFTzhkNHZtdDdtUitpbmVyV3dsNmp4V0xMTnkvWEhPeDljcFgyY1pzYUxk?=
 =?utf-8?B?OVJCekQ0Z3lWUCtyUWpxbTlGc2h6c1BUZks4SzZoUXZ2WU9FU1J5K3EvYkU4?=
 =?utf-8?B?STR3M05oVlRucncxR3paWVVBVXdicmwvek5tK2I0RW5hcVNxTWJ1YzBRTCtW?=
 =?utf-8?B?OTJldTlzNzNuYkxDd3JsR2Jxalk5S0hEcXlSNFpSRTV4Z2dTN25KK3V1VkU5?=
 =?utf-8?B?UEVEdXZrRTlJSWRLdkdmU2xmTWtwU2hQOWJqNjhWQmlXUVpsMmpSSmNuNFZn?=
 =?utf-8?B?SjN3dmdzdkt6cEdwL2FzSUV5RHJEZU1jUWpQaG5XSVFEVHlrczhWZDFxMU5n?=
 =?utf-8?B?RStOTjNsOVFIQnZEVm0yNVRneHJ5VmhSQmQwVXdITXFJbFgwMkxnMTJtY1Jn?=
 =?utf-8?B?TDRFeWRhU2RjSE9Ob3RaeEZwcTJVUFNFRXdXcllHckJuSDdUdWpSNWpxRmdx?=
 =?utf-8?B?VC9iMm5CaEtJYW9oQkFCNUdGd2NWanQ2ZjRySkFYVFR3M0lQUXJTWmloMGJm?=
 =?utf-8?B?cjNOYUI4SzNoelhUT05RNkhQMm9taER3OFhZN25vaS8xekgyOERDZS9uS3pR?=
 =?utf-8?B?djhUdkwvN3IwVGNXNFVmZ3NJSHBCbTcrUVJKVHNlbVdNU3MyY2Y4WFdKSEZr?=
 =?utf-8?B?L0h4ak9JbWgwWGl4RFc1cXBxSEdQWTFacGx5VzNZeHVyV0JzV3RVWE5xYUpS?=
 =?utf-8?B?WmhoT1MyM3ozS21sdTl3NU5XOEsxdUM0eVQxWHMxdVFXMkp5SjY2TWo0dVlq?=
 =?utf-8?B?T21VWTh1ell6RGtoekl6RzNYeUNhaW80QTdENE0rdlZkbytBZ3BHWFA0aU4r?=
 =?utf-8?B?NXFieXRZeVAyT1JRQnkrclFOd3NPZVVwb2FQRjgxWHhDVWRETHRjOTdXZmpT?=
 =?utf-8?B?VUpMZjNFTHRmMG9iaWtDU0IwdDJIUFl6dGFXL04xRm9kQ245L1VLUlc3Nmtq?=
 =?utf-8?B?RTlmbnA0TkRKNnl3SDh6U0dZaUhSOXZDUDBoQXpFNUpHVWtVQ05ZZkYwZGZG?=
 =?utf-8?B?MzNjTGM0ZDE0RTBZRldXNmZqMitTdFUxUC9PcjlGTjNDUFRoazR2cHgvM0ZL?=
 =?utf-8?B?RmU2OHF3dU1ya3NWZTVaRDNsMmJ3blUvRDkrS3ZVcDl1Y25jbnkrdmhuUXdz?=
 =?utf-8?B?N25JNjduTFh5TmVzYzcrcDUvdm1nRGd0UHgyUm1vbFlLclJwdnRqd1ZvUGRo?=
 =?utf-8?B?cUdmMHpDWkwyUUxjVDVyN0lGbVQyVEplRnFPRzcwdjQ1Y3lhS25aUXJMaEI0?=
 =?utf-8?B?K2k0NGl4WWZNc0JxOUwrUDZ6VElqbkJDUHJyWEc3MzFJODNzblFEQ2tRdSto?=
 =?utf-8?B?Z2Y5Rjh1WHNpVUxsc24wamYwY2h4aWlzbDFia1pybWZzOUhEd1hTbG5Bb01U?=
 =?utf-8?B?NllVeFpVY3loNS9KT2lVOHRKSkhZVXh3UVExZXF4V2I1RW4reVE2UVBYRmcr?=
 =?utf-8?B?Zkl6d1hoYlRWekZNTjE3MTNEdkN6YldrM1BoWm1oWHRsMCtVWnlxSXl4NmJh?=
 =?utf-8?B?ODdwZ2w0QWZVN0RXODV4R1BId2poZGM5a1VaZ2RMbis1dkY1aFlwNzV5Snc3?=
 =?utf-8?B?N2l0YzcrVGpaT3RRcWJ5RUpYRUl3Tmp1TFdqMnRHRmJTWnVtbktlYXBObWND?=
 =?utf-8?B?dnh6RWt5MkQ3eHpBWmRwYStmS3ZNRlVJcGo1b01ES0NUcDE1SEhpM3N6eTZM?=
 =?utf-8?B?cm1KUHlpZHl6WEtpMTRKZFRpYWhwaHlQRk5oOUxUd3dkWlFUamw4Q2Vpc0JK?=
 =?utf-8?B?anQ5TXhqRmF4SHhLZURMZC9PeVIvT0tQYTlRakcyNk5iQjl3MGh4d0RRUkR0?=
 =?utf-8?B?TGFNT3YxOHpwMHVEREhYNTg1ckFEd0hFbjVxWFhVNVZlbTZzU1R1RzFxQTVG?=
 =?utf-8?B?V0xmZzkwVUkwOCtFK21RRzN2enZseXpBeWF4VjYyVGQ0VXRuY0Z2WlVLOEd2?=
 =?utf-8?B?MGV1bm94N2t4cTRCc3lSTGtrejREZmtMa2tPK0VFeW41anQ3ZThYbW9pMGZZ?=
 =?utf-8?B?OVF1eTczSVNLR0pLWjI3UEhtQW8zRVBOU3RTMTFRUncvcUNXRThxRWlkckMw?=
 =?utf-8?B?b2RzUTdoRklka1l2SnZCU21lbVVmbStYUlB5SHdqQkZLS3NhNGd1dnlKN1Fn?=
 =?utf-8?Q?G3cE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be15935-192f-415f-8871-08dc56ed3192
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 10:26:31.8511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMwR3/w9nKtcYPByt1YU7f0qZFCiWf4tYTFAHUJegwlSrGSDuAlCgN+6v3dzYgDEBBxhKx/joc6nQ7aWRNsI5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10214
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

QW55IGNvbW1lbnRzPw0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IFN1YmplY3Q6IFtQQVRDSCB2NCAw
LzVdIGlteDkzOiBDb252ZXIgdG8gT0ZfVVBTVFJFQU0NCj4gDQo+IEEgZmV3IG5vZGVzIHdlcmUg
YWRkZWQgdG8gc29jIGFuZCBib2FyZCB1LWJvb3QuZHRzaShscGkyYywgdXNib3RnKSwgdGhvc2UN
Cj4gbm9kZXMgY291bGQgYmUgZHJvcHBlZCBhZnRlciB1cHN0cmVhbSBsaW51eCBzdXBwb3J0cyB0
aGVtLg0KPiANCj4gVG8gc3VwcG9ydCBPRl9VUFNUUkVBTSwgYSBmZXcgZHJpdmVyIGNoYW5nZXMg
YXJlIGluY2x1ZGVkLg0KPiBGb3IgVE1VLCBzdGlsbCB1c2UgVS1Cb290IG5vZGUsIEkgd2lsbCBw
cmVwYXJlIGEga2VybmVsIHVwZGF0ZSwgdGhlbiBiYWNrIHRvIFUtDQo+IEJvb3Qgc3VwcG9ydC4N
Cj4gDQo+ICBNYXRoaWV1OiBwbGVhc2UgaGVscCB0ZXN0IHRoZSBib2FyZHMgeW91IG1haW50YWlu
IHdoZW4geW91IGhhdmUgdGltZS4NCj4gDQo+IFRoYW5rcywNCj4gUGVuZy4NCj4gDQo+IFRvOiBT
w6liYXN0aWVuIFN6eW1hbnNraSA8c2ViYXN0aWVuLnN6eW1hbnNraUBhcm1hZGV1cy5jb20+DQo+
IFRvOiBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT4NCj4gVG86IEZhYmlvIEVzdGV2YW0g
PGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gVG86ICJOWFAgaS5NWCBVLUJvb3QgVGVhbSIgPHVib290
LWlteEBueHAuY29tPg0KPiBUbzogTWF0aGlldSBPdGhhY2VoZSA8bS5vdGhhY2VoZUBnbWFpbC5j
b20+DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZh
biA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gDQo+IENoYW5nZXMgaW4gdjQ6DQo+ICAtIENvbnZlcnQg
YWxsIGkuTVg5MyBib2FyZHMNCj4gIC0gTGluayB0byB2MzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvci8yMDI0MDMyOC1pbXg5My1vZi12My0wLQ0KPiA0ZTdmMzQxZWQ3ZWFAbnhwLmNvbQ0KPiAN
Cj4gQ2hhbmdlcyBpbiB2MzoNCj4gIC0gVXBkYXRlIHBhdGNoIDUsIHRvIGRyb3AgdGhlIGlteDht
cC1ldmsgY2hhbmdlcyB3aGljaCBhcmUgd3JvbmdseQ0KPiAgICBpbmNsdWRlZA0KPiAgLSBMaW5r
IHRvIHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwMzI4LWlteDkzLW9mLXYyLTAt
DQo+IDkwOWY1ZDM3ZGE4N0BueHAuY29tDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAgLSBBZGQg
YSBuZXcgcGF0Y2ggdG8gc3luYyBjbG9jayBoZWFkZXIgdG8gYXZvaWQgYnJlYWtpbmcNCj4gIC0g
RHJvcCB0aGUgTWFrZWZpbGUgY2hhbmdlIHdoaWNoIGNoYW5nZSBpbmNsdWRpbmcgb3JkZXINCj4g
IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDMyNy1pbXg5My1v
Zi12MS0wLQ0KPiBhZmFiNmIzMTQyMmFAbnhwLmNvbQ0KPiANCj4gLS0tDQo+IFBlbmcgRmFuICg1
KToNCj4gICAgICAgZ3BpbzogaW14X3JncGlvMnA6IHN1cHBvcnQgb25lIGFkZHJlc3MNCj4gICAg
ICAgc2VyaWFsOiBscHVhcnQ6IHVzZSBpcGcgY2xrIGZvciBpLk1YN1VMUA0KPiAgICAgICBjcHU6
IGRyb3AgaW14OV9jcHUNCj4gICAgICAgY2xrOiBpbXg5MzogZml4IGFuYXRvcCBiYXNlDQo+ICAg
ICAgIGlteDkzOiBjb252ZXJ0IHRvIE9GX1VQU1RSRUFNDQo+IA0KPiAgYXJjaC9hcm0vZHRzL01h
a2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgLQ0KPiAgYXJjaC9hcm0vZHRz
L2lteDkzLTExeDExLWV2ay11LWJvb3QuZHRzaSAgICAgICAgfCAxMTkgKysrKw0KPiAgYXJjaC9h
cm0vZHRzL2lteDkzLTExeDExLWV2ay5kdHMgICAgICAgICAgICAgICAgfCAzMjIgLS0tLS0tLS0t
DQo+ICBhcmNoL2FybS9kdHMvaW14OTMtcGh5Ym9hcmQtc2VnaW4uZHRzICAgICAgICAgICB8IDEx
NyAtLS0NCj4gIGFyY2gvYXJtL2R0cy9pbXg5My1waHljb3JlLXNvbS5kdHNpICAgICAgICAgICAg
IHwgMTI2IC0tLS0NCj4gIGFyY2gvYXJtL2R0cy9pbXg5My1waW5mdW5jLmggICAgICAgICAgICAg
ICAgICAgIHwgNjIzIC0tLS0tLS0tLS0tLS0tLS0NCj4gIGFyY2gvYXJtL2R0cy9pbXg5My11LWJv
b3QuZHRzaSAgICAgICAgICAgICAgICAgIHwgIDgwICsrKw0KPiAgYXJjaC9hcm0vZHRzL2lteDkz
LXZhci1zb20tc3ltcGhvbnktdS1ib290LmR0c2kgfCAgMjIgKw0KPiAgYXJjaC9hcm0vZHRzL2lt
eDkzLXZhci1zb20tc3ltcGhvbnkuZHRzICAgICAgICAgfCAzMjMgLS0tLS0tLS0tDQo+ICBhcmNo
L2FybS9kdHMvaW14OTMtdmFyLXNvbS5kdHNpICAgICAgICAgICAgICAgICB8IDExMSAtLS0NCj4g
IGFyY2gvYXJtL2R0cy9pbXg5My5kdHNpICAgICAgICAgICAgICAgICAgICAgICAgIHwgOTA2IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9LY29uZmln
ICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgY29uZmlncy9pbXg5My1waHlib2FyZC1zZWdp
bl9kZWZjb25maWcgICAgICAgICAgfCAgIDIgKy0NCj4gIGNvbmZpZ3MvaW14OTNfMTF4MTFfZXZr
X2RlZmNvbmZpZyAgICAgICAgICAgICAgIHwgICAyICstDQo+ICBjb25maWdzL2lteDkzXzExeDEx
X2V2a19sZF9kZWZjb25maWcgICAgICAgICAgICB8ICAgMiArLQ0KPiAgY29uZmlncy9pbXg5M192
YXJfc29tX2RlZmNvbmZpZyAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gIGRyaXZlcnMvY2xr
L2lteC9jbGstaW14OTMuYyAgICAgICAgICAgICAgICAgICAgIHwgICAyICstDQo+ICBkcml2ZXJz
L2NwdS9pbXg5X2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8IDIyNCAtLS0tLS0NCj4g
IGRyaXZlcnMvZ3Bpby9pbXhfcmdwaW8ycC5jICAgICAgICAgICAgICAgICAgICAgIHwgIDQyICst
DQo+ICBkcml2ZXJzL3NlcmlhbC9zZXJpYWxfbHB1YXJ0LmMgICAgICAgICAgICAgICAgICB8ICAg
OSArLQ0KPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9pbXg5My1jbG9jay5oICAgICAgICAg
fCAyMDggLS0tLS0tDQo+ICBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL2ZzbCxpbXg5My1wb3dl
ci5oICAgICB8ICAxNSAtDQo+ICAyMiBmaWxlcyBjaGFuZ2VkLCAyNzMgaW5zZXJ0aW9ucygrKSwg
Mjk5MCBkZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiAyODBmMzRiYTdkNjhiYjUw
YzBiOGVhYTA0MDMyMmMxZjNiMzdkNDZlDQo+IGNoYW5nZS1pZDogMjAyNDAzMjgtaW14OTMtb2Yt
djItZjg3OWVmZWY3MzdkDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IFBlbmcgRmFuIDxw
ZW5nLmZhbkBueHAuY29tPg0KDQo=
