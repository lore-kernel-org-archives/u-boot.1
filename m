Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DC6CDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:58:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 296EE8727A;
	Thu, 19 Oct 2023 16:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="4j8Hpz0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A17C9871A1; Thu, 19 Oct 2023 16:29:00 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34B8887073
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivan.ivanov@suse.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvJ+Fgd0WtormhMqSmRLRdvn9wXHSJXKjPoYekJ0n81RgJQBFlGq87HjhqLKd9kL0ZXQM9NyW8KMzzLbV2GpzhKQ0RBksLD3w0y3z3gZPvrabCu2GaLjoCE0gVjQlLfn0fgJSVpUK0k680c0cqgl9bEZ8++dhY9KIkOcrO3mbqyDqjNlBTMhnBqwIpOaZW7H5ZoDcTX6pjLOXpu1pKtph/nitpTfqmTrxelJs06o4LkufH826VAu9LG2JUNTUn4N2WOXiL7G9JzUJKZ5HHVId+8P37kaT7T5KBJhXOEEjq53nrk8AuWasgnUANdQz2GjsYhO/zKHgapCKDaU/FQp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0HtBJJL4ZxT2000lDYLOf/b7fheklwg6l2SsNLjCf8=;
 b=d1W9S6CFMVZS5Nw8sJpyLVSW89DI6zgp5MErdBBmMsPRw5L+LQ8fwlRSMzjBV7x3MDbrI2/cRKG18oyGqmo9VC7GkvUJH4Amy/sgp/AAql6pXMnzaiUVXbeUdgSqT6QrtDIruXPg4DgV7lXSfYNNOG5LMnPBqYePP86egib7QOqVQKJ9DHvb2yJtlmFbZ8oPKyzy0X4kRJ9d9kiY/UbON19O3LSgeDnh3qmc1FwTYBX91MkY8IfSnh+ph9vbvyKcLVDDbXlb3u8HBTy9dJNSRP/GPYmxOj+a3V3csZc7Dx4nvUCwdyMwJ+U3Dfu38kIMjhFlZaAPMeRuNXt5ueVmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0HtBJJL4ZxT2000lDYLOf/b7fheklwg6l2SsNLjCf8=;
 b=4j8Hpz0rPPtKbHsg1ABFNcLJTSPKj33tUNYZR9zeDkLEwkyYIr5B9MoqeolijqSk/dOm5QzGIqBttjHeOEBJ40wI63UAe0RDuVgPwEWbGs6TqrTYlWyG4Nptz9u/yMOkdeawa6P7c7CNkL65sKI8FXbLFWJabBM2MIHFaHV5qNbH/Zoa7NASZu5kQojVWKEzwDQZm+5YHvsm6FudLvAdHsgQrBgC7VFZAGw3gOabZX5V1xWHFYQDKuRTAjAKpAZJFjm+QE3hAlhjkBt2ysuJ6gpBevHVYfCiSUuxHijtM9HlKaQfjuvkZrbxhXl4I4YMB97uGEfgeqvER8WfUWedFQ==
Received: from AM7PR04MB6839.eurprd04.prod.outlook.com (2603:10a6:20b:103::9)
 by PA4PR04MB7871.eurprd04.prod.outlook.com (2603:10a6:102:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 14:28:56 +0000
Received: from AM7PR04MB6839.eurprd04.prod.outlook.com
 ([fe80::529d:3ac4:e17f:174b]) by AM7PR04MB6839.eurprd04.prod.outlook.com
 ([fe80::529d:3ac4:e17f:174b%7]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 14:28:56 +0000
From: Ivan Ivanov <ivan.ivanov@suse.com>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: Guillaume Gardet <Guillaume.Gardet@arm.com>, Matthias Brugger
 <mbrugger@suse.com>, "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
Thread-Topic: U-Boot 2023.10 does not boot from uSD on RPi4
Thread-Index: Adn7Wr0e+LRv6MRIS4aqQVJurtxargACOEoAAAB9fxAACSUYgACMvy5QAStVywAACoWvgAABAOWA
Date: Thu, 19 Oct 2023 14:28:56 +0000
Message-ID: <d0cfe8627544d1699031315cc53b961c4cadc126.camel@suse.com>
References: <VI1PR08MB2847E276099DF7263424F70083CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CALeDE9N6nhRBwtYqJ=7nqYuCsmbw03j3RBXRQ8jYsD=OMY=gBw@mail.gmail.com>
 <VI1PR08MB28474179AFB989B308072B1E83CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CAPnjgZ3t9-trzoLGc7Jcj0=J0sQLQcHSGN3_Pf+3=iZ6=rPPqA@mail.gmail.com>
 <VI1PR08MB2847B5EFD8F36E5A4D41FEBD83D2A@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <a151e6508695fcc2cee740f299e58e0fee6146b3.camel@suse.com>
 <CAPnjgZ0KVwF-u5G2r-zt8+FmiHK_2ASEsoro3MtVsah58_WqMg@mail.gmail.com>
In-Reply-To: <CAPnjgZ0KVwF-u5G2r-zt8+FmiHK_2ASEsoro3MtVsah58_WqMg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB6839:EE_|PA4PR04MB7871:EE_
x-ms-office365-filtering-correlation-id: 8ae1bf74-7753-457e-366a-08dbd0afba0c
x-ld-processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iGGdTt6wQlKGh4WN90pfU5Hqmrq4pyovHZ7J9rgH0HdWKUxgT2zFKR/ZkFHyYtM+rnyqwVZtxf1MzFh09tAaQxM5prbki9okrg0gqPqj7ZO6QDI/ugFG42b5PXLNyun21Wry4l2nb6bSTil/Pl4GtC/OUN7RxJPyg2fAUNcC4APZI4zXY6FrzuyUSAsJfjmf4rxUC6MyfxahhE25z2uA/kqzngMS7slxte1NhCuyN+P2SpXHAiosJVIWl61DVoPbfqa86Rm5GYnLUhKm0vMlPXsJMXC5bc959XhLgN6IQ+77yR/LhPVYFaaO517y0hOG6egBJ6vIT42xIARsS+hVkVmukpPqR2DmGj/oN0OlM6gyg+9XqYF3xvPED+QBkHKoW3ho9HDwhuB8+LVANBViLP9OyAHdJ2aZZIb1kaVuoJA7n5wMlIt5GtIQC7NNX/qLNXLi9ecsul/PvjtjmIpb9gxYBA5Hklr0GD+Xz647VMLi2jmENFoKPywH+LwNi3JyKw+c5IA3TMGpEgOaKCI3gz0WnRLWwkkcGK2oDQp09/+pKQaW80G/ZEgfdM8z6rE6ob4tqG3uq2aneF875aj21pWx0sPhIpSNazjD+k8atfc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB6839.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(6506007)(6512007)(2616005)(83380400001)(71200400001)(44832011)(6486002)(966005)(478600001)(8676002)(38100700002)(316002)(122000001)(36756003)(5660300002)(41300700001)(86362001)(38070700005)(8936002)(4326008)(91956017)(2906002)(4001150100001)(66476007)(66556008)(54906003)(66946007)(64756008)(66446008)(76116006)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3hVR0Z3b2FPK1hJOFN6U0M1THdGK1JxUnVGYzZHQ0tyd1ZnMHphSk9IUkhu?=
 =?utf-8?B?STJjOWZuNWNPQndnei83WjdueHcybFRwNHY4aVdHQ2pONE16d252KzNaZmVL?=
 =?utf-8?B?SXJiUjBiU0dnUldNRVo4TElYYWRSeWZ1Sy9MNTZNV1FsblMyaXd6M3VZT2c2?=
 =?utf-8?B?RTVQTjNHa3B3TFdsTkRJKzhpSEhBVWo3RnczbEt3ZVZHODV4MXRZV0I3bFRo?=
 =?utf-8?B?ZzgzSmswSEs1YTc1aGE2dDNzNWtTM2hxZDE1Q2NmU3JqMm9zbXhBWTFYZmVS?=
 =?utf-8?B?b0pmL3RGaU9WK2FmNXVwQ3VKMyt4bFI5MVllYjFGRUtpSHptZ2RVa3RCemtu?=
 =?utf-8?B?bFJqQVFIelY4N05wUk5zQXcrRm94bWRhWDlFT2xVL21ybXpCMGFoT2dhbXNM?=
 =?utf-8?B?UDRNYUJTYlNCL1BON3lLLzhXc0JEdXNza01La1lmOXlsekV2VGxXSExrdVJ1?=
 =?utf-8?B?S1I5T1JDSlU4Wmo4VjU5SWtINHBBU25Xc0tJSHRIWUxzdnFNTVdMaGk3c2lC?=
 =?utf-8?B?S0VRNEkrSm5jTkxhSjBYRWZhV3VtMmQ5WDhWV3RQOU12NUxrWGhYZE5vM3lT?=
 =?utf-8?B?aHVzR09KOGdKV0k5WFVSTXFKdkNZSnUxSTNDeG5iSUc2WE1ZdjNpUFpVd1Vl?=
 =?utf-8?B?QkFRSzZySG9RSkcxTnJhUVI0NmVpRjZXT1JYa2ZGM1AzcDdyWWhHUEx2Wmdo?=
 =?utf-8?B?d0dMeElyZ2NXNS9RZzcxUzJJOUVWK2xEcTNCeGxyc25SWlZMTlVNdFc2dTlX?=
 =?utf-8?B?UlVuNzlFR3NvVWtVbElQL095TWdFdXozR2FXbDBXY1B2dTVsQlh0dFl5eHhM?=
 =?utf-8?B?M1dRd1dnNHpqYk9ua3JJc0hJbmthUFBXSnlONGJpUTZsMHF3d01XVTBhbGxQ?=
 =?utf-8?B?VHFCUW1OQ054eGpMMWRDU0t4NmwvOHdFQ2x3YTc5KzF3eEFZSnJDbFpBWERP?=
 =?utf-8?B?NWh3eFpPRUZ3Z2FJcHR6eEhCc0NDODV0U2o2cUt6c3NDekhtMk5pNm9tRFJ6?=
 =?utf-8?B?aE5iK2k4WXRadzNJUnJXVDQxaVZBSkE1VlZUSVlQdWRMUFNDN0ozQURYNlRV?=
 =?utf-8?B?dThpUE1rMzgrMDZkTWxaWUxpd0RRR3ZUUFJodElaNVkwaThwVGF4RGlqQ3pa?=
 =?utf-8?B?b3Z3TWNKY0RuaURXUmhRclhyRHN6K3puK0poS3VUTnRuWEx4WEdhWjEzR3lQ?=
 =?utf-8?B?d21VRFBKd01XYVNGdnl2VS80UTJjU2FVdXFKaVRVUlJrdGh2SGZkWEp2aUpD?=
 =?utf-8?B?NnFqSDYxMG8vMFBWSEtibG5tWTZaMDhLRStCMkNyTG1Pc1RPWHhpZU8vcENt?=
 =?utf-8?B?ZkRYbG5LU1VXc0tuaUFZRHhGU1dxSFBsSHBucDZKaFdiSkJKUVJwK3FHRU9k?=
 =?utf-8?B?Wi9Ba2NFY3FZMVVKTE1MUTRwVE5pTER2YWpDYmVPcDE1WGR1YkxHcHVxVVFp?=
 =?utf-8?B?RlBtclh5WEFJci9YalZmckVSL3N0TGwzS2dtVHVLTzF5QlJEcHJpdlVZeWxE?=
 =?utf-8?B?dzVxWDYzUDNWWE1JU2hVdThSRnkxOU5ISG1hNmIrVmhtK2ZWM05RcXFpUEl0?=
 =?utf-8?B?QmNXL3V0SU1aVHhUeDhpbjRHZGRzeFB2ZWF0MGVEZ3FTdTMwSHN1ZzhJMGN6?=
 =?utf-8?B?Qlh1Q0d3eS9wVEQzY09rZkRzRi9pOHNHS3E1OCsxeWZNZnVYTEtNK0o4RExN?=
 =?utf-8?B?cnI5V2xSM3VvLzVHSVBscFI1WFJmdWtTQXVxQ1dLQzZxTUhnMmtWQ0thaUxa?=
 =?utf-8?B?UnBGdDFnR1pTNndDMS9nb2VOSVFVZ3B2TzFra3A0dUxVZ1hzcDV2ck5CK21O?=
 =?utf-8?B?SktGRzZaOW5hWVdVL24vMjBVdFBuVjJ1eUNYSGdoK3dCNEcxL05PYVJ0ZVJi?=
 =?utf-8?B?dUFCd3VSM3FDa2l5THhONjlnR0UrVytyc09ybFJRSmwvMUphYTVDdjhwemJm?=
 =?utf-8?B?RG9La29iODk2Zlh5d2hnZHoxN2ZzWjJpMWFsTHFEb04rQldwYUFPWGw0aVlh?=
 =?utf-8?B?d3U4ZE5Eb3RhUnJ6TnVtRm1jdGI0R0VpVEVRVS8yUldHeVR3Q0x1eHlTTm9Q?=
 =?utf-8?B?UExuazNaQ0ZlZWRCSEFiSEYwRVlncy92ZmVvT05jeW9xV3l4MDFZN0RwRXVN?=
 =?utf-8?Q?byzpCa2jVLR/lagIgxgVB3aVx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCFC31D445679B4EADDE3C346EEC2607@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6839.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae1bf74-7753-457e-366a-08dbd0afba0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 14:28:56.1773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uyIBRUEubUhNEwVYzmoQu+z4corwkmMqnndH4pJEAjLirf/fJd5y5AiRkF8YoK5mktIDniUCV5frwhzS+v+H+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7871
X-Mailman-Approved-At: Thu, 19 Oct 2023 16:58:19 +0200
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

T24gVGh1LCAyMDIzLTEwLTE5IGF0IDA4OjAwIC0wNjAwLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4g
PiA+IA0KPiA+ID4gWzJdIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC91Ym9v
dC9wYXRjaC8yMDIzMDkyMzIwNTAxNy4xNzU0MzQwLTEtc2pnQGNocm9taXVtLm9yZy8NCj4gPiA+
IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFsxXSBodHRwczovL2xpc3RzLmRlbnguZGUvcGlwZXJt
YWlsL3UtYm9vdC8yMDIzLU9jdG9iZXIvNTMzMTU4Lmh0bWwNCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ICdnaXQgYmlzZWN0JyBwb2ludHMgdG86DQo+ID4gPiA+ID4gPiAqKioqKioqKioqDQo+ID4g
PiA+ID4gPiBjb21taXQgYzc3MWU1YjhjMmExODZmYjA3MmI2YzZmNTcxZDRhM2NjODZlZmJhOQ0K
PiA+ID4gPiA+ID4gQXV0aG9yOiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4gPiA+
ID4gPiA+IERhdGU6ICAgVGh1IEp1bCAyNyAxNTo1NDoyOCAyMDIzIC0wNjAwDQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+ICAgICAgYXJtOiBycGk6IFN3aXRjaCB0byBzdGFuZGFyZCBib290DQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICAgICAgRHJvcCB1c2Ugb2YgdGhlIGRpc3RybyBzY3Jp
cHRzIGFuZCB1c2Ugc3RhbmRhcmQgYm9vdCBpbnN0ZWFkLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiAgICAgIFdlIGRvbid0IG5lZWQgdG8gc3BlY2lmeSB0aGUgbW1jIGRldmljZXMgaW5kaXZp
ZHVhbGx5LCBzaW5jZSB0aGV5IGFyZQ0KPiA+ID4gPiA+ID4gICAgICB1c2VkIGluIG9yZGVyIGZy
b20gMCB0byAyLCBhbmQgc3RhbmRhcmQgYm9vdCB1c2VzIHRoYXQgb3JkZXIgYW55d2F5Lg0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAgICAgIFNpZ25lZC1vZmYtYnk6IFNpbW9uIEdsYXNzIDxz
amdAY2hyb21pdW0ub3JnPg0KPiA+ID4gPiA+ID4gKioqKioqKioqKg0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiBUaGUgZm9sbG93aW5nIHBhdGNoIGZpeGVzIHRoZSBib290IGZyb20gdVNEIG9u
IFJQaTQgKG5vdCB0ZXN0ZWQgb24gUlBpMyBub3IgUlBpDQo+ID4gPiA+ID4gWmVybyAyIFcpOg0K
PiA+ID4gPiA+ID4gKioqKioqKioqKg0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2JvYXJkL3Jh
c3BiZXJyeXBpL3JwaS9ycGkuZW52DQo+ID4gPiA+ID4gPiBiL2JvYXJkL3Jhc3BiZXJyeXBpL3Jw
aS9ycGkuZW52IGluZGV4IDMwMjI4Mjg1ZWQuLjAyMjEwYjk3YjUgMTAwNjQ0DQo+ID4gPiA+ID4g
PiAtLS0gYS9ib2FyZC9yYXNwYmVycnlwaS9ycGkvcnBpLmVudg0KPiA+ID4gPiA+ID4gKysrIGIv
Ym9hcmQvcmFzcGJlcnJ5cGkvcnBpL3JwaS5lbnYNCj4gPiA+ID4gPiA+IEBAIC03NCw0ICs3NCw0
IEBAIHB4ZWZpbGVfYWRkcl9yPTB4MDI1MDAwMDANCj4gPiA+ID4gPiA+ICAgZmR0X2FkZHJfcj0w
eDAyNjAwMDAwDQo+ID4gPiA+ID4gPiAgIHJhbWRpc2tfYWRkcl9yPTB4MDI3MDAwMDANCj4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gLWJvb3RfdGFyZ2V0cz1tbWMgdXNiIHB4ZSBkaGNwDQo+ID4g
PiA+ID4gPiArYm9vdF90YXJnZXRzPW1tYzAgbW1jMSBtbWMyIHVzYiBweGUgZGhjcA0KPiA+ID4g
PiA+ID4gKioqKioqKioqKg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBTbywgdGhlIGNvbW1l
bnQgZnJvbSBTaW1vbiAiIFdlIGRvbid0IG5lZWQgdG8gc3BlY2lmeSB0aGUgbW1jIGRldmljZXMN
Cj4gPiA+ID4gPiBpbmRpdmlkdWFsbHksIHNpbmNlIHRoZXkgYXJlIHVzZWQgaW4gb3JkZXIgZnJv
bSAwIHRvIDIsIGFuZCBzdGFuZGFyZCBib290IHVzZXMgdGhhdA0KPiA+ID4gPiA+IG9yZGVyIGFu
eXdheSIgc2VlbXMgd3JvbmcgZm9yIHRoZSBSUGk0IGNhc2UuDQo+ID4gPiA+ID4gPiANCj4gPiAN
Cj4gPiBJIGFtIGFmcmFpZCB3ZSBzdGlsbCBoYXZlIGEgYm9vdCBpc3N1ZS4gVGhpcyB0aW1lIGRl
dmljZSBjYW4gbm90IGJvb3QgZnJvbSBVU0IuDQo+ID4gRGV2aWNlIGJvb3Qgb3JkZXIgd2FzIGNo
YW5nZWQgdG8gVVNCIGZpcnN0IHRoZW4gdVNELiB1U0QgY2FyZCBpcyByZW1vdmVkLg0KPiA+IA0K
PiA+IFBsZWFzZSBzZWUgWzFdIGF0dGFjaG1lbnQgIzg3MDMyMSBmb3IgYm9vdCBsb2cgZGV0YWls
cy4NCj4gPiANCj4gPiBJIGhhdmUgbm90IGludmVzdGVkIHRpbWUgdG8gZGVidWcgdGhpcywgc3Rp
bGwuDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBpbmZvLiBJcyB0aGlzIHVzaW5nICdib290X3Rhcmdl
dHM9bW1jIHVzYiBweGUgZGhjcCc/DQo+IA0KDQpZZXMuICJib290X3RhcmdldHM9bW1jIHVzYiBw
eGUgZGhjcCIuIEZ1bGwgZW52aXJvbm1lbnQgYWRkZWQgdG8gdGhlIGJ1Zy4NCg0KaHR0cHM6Ly9i
dWd6aWxsYS5zdXNlLmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTIxNjAzNg0KDQoNCg==
