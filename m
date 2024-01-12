Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C4EC4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 06:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22DA18718F;
	Fri, 12 Jan 2024 07:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="bwQOkRHW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57FA287930; Fri, 12 Jan 2024 07:24:43 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6C5187142
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 07:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9GGk1sjOtwyw/5zRuVL2dpDUbCKncSdHKZU6tp/wbWeSavjTwwYpc7gLSRdkbBCgmw03HhU1B2bL/bGqAn1ULaSsNoW5TUTcVUPTE69gxfjG3DsPiyiNqX0D2Van/CO2Rr8It7yWtvL/Cp72RXOMZ+1wCxvxpNSp9nCVSHE0FAPGF8JG4dfWS9klaFMN2IDqriRKcsqfVQK4AIgpKEy8afP9kN6+jquAVj6UCu01mrLfBUja1QjM4vB1Z8hMWV8N8CWKC73B+jqieqYXJjYDBn9JXSrQHOuCfr6gT/P1FNyK5iEQ4RNfTosrC56Sii7+AniG9uX+fxMQ8K1eskjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUcOmUh+ShmumI/8Z9G/HXQpILVz5psJFDxXa4clgMQ=;
 b=EauJ15b2hGVAOkR/f/M2l8Uv7ZVUUR3OeC1HaKIFRCU5TJDb29IjnFMMWUWa/DM5nRnvlN+XkXlmJ19Tyeb192wDiIFGdV7LtXc99H8wBHotspWH7iMWiOCZoeV6gyVpCN8wt88E2cyiWf9KzFNnNFTEMPJKAk2QI6OQLkON0qihrUF23tLOQR9HZ10zrGzrHE+cL2zrcNx8axCrUq9Vt/DCZLIHT/6kzO6OC2rKGpimKC0F7pGukSPobzSE8zz0En71mVj5TmeiRSe6f9zNfYK3/PBlQl2308leY17/pXt+cGJeWl05NBop9RkTR2QZdzHWmClBUfxbV+ILEWN2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUcOmUh+ShmumI/8Z9G/HXQpILVz5psJFDxXa4clgMQ=;
 b=bwQOkRHWMC+iB4zI1Rvp95ToDjrZPwlYtzCjM7/T3MplDzmdUL4ahQSUO/uHZYVOw/28QuDZfsqm2NJqzPzzNgfyYaE3yfDx1reyosrtzor8rihnxX/tJJeA8T/Vseb+wJ+IISfHxQq/uJDCmCpSRUHPJPdHbkD4DvamJnT2b84=
Received: from AM6PR04MB5302.eurprd04.prod.outlook.com (2603:10a6:20b:7::20)
 by DU2PR04MB8743.eurprd04.prod.outlook.com (2603:10a6:10:2e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 06:24:39 +0000
Received: from AM6PR04MB5302.eurprd04.prod.outlook.com
 ([fe80::d91e:b436:3bf2:14c8]) by AM6PR04MB5302.eurprd04.prod.outlook.com
 ([fe80::d91e:b436:3bf2:14c8%5]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 06:24:39 +0000
From: Ye Li <ye.li@nxp.com>
To: =?utf-8?B?VGhvbWFzIFNjaMOkZmVy?= <thomas.schaefer@kontron.com>, "Peng Fan
 (OSS)" <peng.fan@oss.nxp.com>, "'u-boot@lists.denx.de'"
 <u-boot@lists.denx.de>
CC: Peng Fan <peng.fan@nxp.com>
Subject: RE: [EXT] AW: FIELD_RETURN on i.MX8MNANOLPD4 EVK
Thread-Topic: [EXT] AW: FIELD_RETURN on i.MX8MNANOLPD4 EVK
Thread-Index: AQHaREF0N2unmKFe7Ua4zeP9gnUWrbDT/hMwgACgyICAARgmIA==
Date: Fri, 12 Jan 2024 06:24:38 +0000
Message-ID: <AM6PR04MB53021F538715C1CE5AA286A8E46F2@AM6PR04MB5302.eurprd04.prod.outlook.com>
References: <GV2PR10MB6453B5A6CA444FD371798D65F76A2@GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM>
 <1dd93112-b593-6d8a-ce56-1ffe7ebdf0db@oss.nxp.com>
 <AM6PR04MB5302071D0CD6F54193CBB8EFE4682@AM6PR04MB5302.eurprd04.prod.outlook.com>
 <GV2PR10MB6453CB47656E8C01D701D545F7682@GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <GV2PR10MB6453CB47656E8C01D701D545F7682@GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5302:EE_|DU2PR04MB8743:EE_
x-ms-office365-filtering-correlation-id: 8e167a01-00c7-4559-c620-08dc133727bb
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wMVFdF49BY27xihHgUP/2YB3MdPg1kkXKew9tQ8CcmkgZBrTae/Rt0bZXRHLeSTGfuv2mo2A3QxsmwUUIyRP+1FlhpaNnrjt8J8mli2PkZAbR85lmdyqfU/9m4vAbCLsGtB1klxGhiKA//HsVDgIYtprCoCPpfm+PGBeIj157lZWEI7m0Gxy4YNSgtA9jXtHLl+uCdUwv6apxa6R0SLz+ivhvHM76zhn94ce7MA7jh1GZ9cNgUW8ewvdCHAO43C6dl0ndnL9w14syyF4Xl73AwUvw3KepVi+Itmtdn5FypVJwQKE1UC/JXl9IQaBHOhd0OI5rtjI7wD3lNMpHfXM6OCkdY93hPEeZkd4+4DS9jYBLleTxzJlEewAGemy/lohGyl7W5tl1XDIVCXTdcYFYuoRtpYuujU4+S0HLzCD+is0orciIrk3dVG7zBVGewn35K6SWQ4BB8rGYyJjxM0r2AEXObCfXagfnv/4tncCWoxhud4XiluRwOa0qw/Opt71a1BtIXHs6LOtKB0Xyeo/CjTMSeyG3bkdNNc0s1HHPnOEiiBg+RuzXBgSwJOBtE/yh8nQFy8GQXGmUZLC1D3y4yf9kK0/TzB0IPGYxGPVyPDIlX0Ss6YYE0hCkdXT7ZGgxwM26BPvGidKp5kFII2NOh9Mapvui/XCkweQ8IJJnB9Vq7h/kSTKfSW4PdSIi4xurQn/27GFzew6FXk0CKi85ZTCaoHjXAR/XhPrKbTr6RA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB5302.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(39860400002)(376002)(396003)(230373577357003)(230473577357003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(1800799012)(186009)(451199024)(966005)(7696005)(6506007)(53546011)(66574015)(71200400001)(26005)(83380400001)(38070700009)(38100700002)(86362001)(122000001)(33656002)(41300700001)(9686003)(478600001)(8936002)(52536014)(8676002)(44832011)(4326008)(5660300002)(45080400002)(66946007)(66476007)(66556008)(110136005)(55016003)(76116006)(316002)(2906002)(66446008)(64756008)(491001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEw1aUx2REw2V0Q0VGlYczIyTEd2bHlWMnl4a3NMS0p5NFc5Zm1JL21Yd3VM?=
 =?utf-8?B?ODdwNitIOXRKcUYrSG5SQUNCRzYrMHRVRjYxWWVpMmdsa2NlVHJyRGo0d2lx?=
 =?utf-8?B?L2Z2ZkMwbGRpS216QzFRUUR3WjhZSzRUTmdQMEFUU2ZVbkgxMnNDNVB4aTZB?=
 =?utf-8?B?S1hlWnV4eHpCZmZFelRDVWNTUGVNN1JJMlcxTE1rd0FyY0w4Zk9pdWdMditw?=
 =?utf-8?B?ejMzSDFnRUgwdWl0L1ZOYmNQRm1tb2RXdU5iTk5sZzVVU2R4MWlzMkNWRjRr?=
 =?utf-8?B?cW9HOEU2UWVmMlNZVkR5OGxXRUFKbkhJaEkzL1FZY2NXOUpOV0V6ZzMzZTdQ?=
 =?utf-8?B?dWh5TXNZdEkrVHg2ZlB4OFNqa3dKeVJ4ZWhwQTErUXg1VGlRb01LVDVkR1Aw?=
 =?utf-8?B?ZXM4TC9FVkxCaXF1aXQ0YmJWYm9PZnFxTGNTRUhQbXZ3RVVNRXVXL0E2TTRI?=
 =?utf-8?B?VGwyZjRwV2tWS0JoZ2ZkOStqMG5YYkovTmoyQXMzSDRESWdVZnVRRVF0NlZu?=
 =?utf-8?B?MEFoZHRyUWE3NElEak84Z1pmZThZWVo4ZGdkU0xhNXlVejRwYkx0c3plb2Fl?=
 =?utf-8?B?NC93QVpIek5oOFRZMUx4emIzYzljKzBWdXNLeG1zWDJEeHlodFFyWlJwZmNW?=
 =?utf-8?B?eTZSbEk0ZHBmbkFsQzJmcHRnWTRZNEpzOTBKRTlOVlBVSW1JWnRoV1h5SWlj?=
 =?utf-8?B?dThxN0NKeXdpMUtPN1JzeXFsZFRTMmk0Qk9yd08yTlBZWkMrU3pPS3A1eEQ3?=
 =?utf-8?B?YTB1cC8rdDZsV2lHUXNVOXB6eXRWMU1GblV4V1ZMUlBrSlpqYWFJQkxMcnkx?=
 =?utf-8?B?UW4rc0k4VlM1TXUyM1d2S0FzTWRlK1VVd1hNVkJCdVdUbGtvTWZEdDB6cEsy?=
 =?utf-8?B?TE0ybmJZUkZRZFhTK21VRTV3TU1yZWtMNWZMTUM4d2hsZzAzRUJKR05naEZa?=
 =?utf-8?B?dlBGOG93NDRWRDRBc09idUVLMlgvNFRHWGpabEwxN0RKa2hoaDVwWFZ2OGZP?=
 =?utf-8?B?YzVaSFF1NCs5TUpsc3lkMGN3cXZ6L2YyMHBkZUtVYXYySE5heFM1N3EvUHdt?=
 =?utf-8?B?a1VaeTllNVFDMXZWM0ZmWU1UVFAvWmthSjJ3NzkybEZMVkJFamZwR2VZdHdk?=
 =?utf-8?B?eHMxNG0rSVF2d2N1dm1aT29lSTAraWV0L3R3RmJWWVdKM1hBVEs2TGx0Y2Fo?=
 =?utf-8?B?TzJMWStXcGFDVTYvbkdEakY0MzZGaTdycStnbStqcjZqSFhCejhRL1dVdjdK?=
 =?utf-8?B?RTh4OEwrRDZ0TmVmekVYbm15bGt0MVBoeFJSZ2V4VW9HbURZYkF1cHRIZDlH?=
 =?utf-8?B?eEtkWHVVMzNRc1N3QlMzd0pVcGpkQ3h0M0xobmczcENBYUhWOE1pSkJGRXc2?=
 =?utf-8?B?UHQwT1BNODBubDBDeWcyQU1UakpORms0bnBURnVxZmZ3R3VKUGNSUUJSa1VJ?=
 =?utf-8?B?bFlRcUtpUjEzd0dCVmgwQ2VTY1BIT1pTdUh0SkQwWUtPV29nTnordjAwdUFm?=
 =?utf-8?B?dlhqdktXZTVvQmJ6R3pxYlBhWGNyenFjWGJleGFqbTc2WmFlS3hrZnREMExR?=
 =?utf-8?B?OUYzRGlDNjEyR0lGVkhubXlDYlo4SFJkR0hEN3BzZnZtRWF0RTVKUmZVTERD?=
 =?utf-8?B?WlFRYmh3OWhBK0xORTZBcTFQcmJVL2cyQ01nQjU2WE5jV0xTdzdnR0pJQ21x?=
 =?utf-8?B?MzlDNlQxVCt5TzEwSUpKL08rb2ZTUXFmaGRySzJpNS95UjB6a0huRDFLQU9a?=
 =?utf-8?B?WlZKUnI4WmJhZDJ5VmlTZE10NDVsTmE4MnFJNS9PRFR6bnhrOEFXTWRHQTlv?=
 =?utf-8?B?VWxvVWRmTGRMaWsrMytNd0Y4WUxvYlFDc0x4RVNhTkdkY2hEOXhGSTNJU21R?=
 =?utf-8?B?NlV3YW9wL1h4dzhKMTlacXRwZVE1eDlVaFJSYWViVXVvbHY5dVpVTnJ2MmVC?=
 =?utf-8?B?YklYM3pxMHhQUjU0SGFZRWdyKzV1eDkrR3Uza2Q5cDVGYTNsUlJPOXdjZkZJ?=
 =?utf-8?B?bUNoMHNyQldKd1MxekhCZS9ZTUZlT3hwSmQ0NHZidW5leEJNYkpYUjdsYUdH?=
 =?utf-8?B?dHR3ZkQxUlQ4VTkwZkJVU2ZKeXU3ME9XNytLbDVjOXdzaHd5YUc1SzMwSDBW?=
 =?utf-8?Q?VmtE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e167a01-00c7-4559-c620-08dc133727bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 06:24:39.0050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGgZ3VUeXwHhbdBi9C6rw9qoKJFnlT4wwxNFz8e06QnpZF43pylvzjoeTO7VYpUI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8743
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

SGkgVGhvbWFzLA0KDQoJSXQgaXMgZHVlIHRvIEFSTVY4X1NQTF9FWENFUFRJT05fVkVDVE9SUyBu
b3QgZW5hYmxlZCBieSBkZWZhdWx0IGluIHVwc3RyZWFtLiBJIHdpbGwgc2VuZCBhIHBhdGNoIA0K
DQpCZXN0IHJlZ2FyZHMsDQpZZSBMaQ0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBUaG9tYXMgU2NoYWVmZXIgPFRob21hcy5TY2hhZWZlckBrb250cm9uLmNvbT4NCj4gU2Vu
dDogVGh1cnNkYXksIEphbnVhcnkgMTEsIDIwMjQgOTo0MCBQTQ0KPiBUbzogWWUgTGkgPHllLmxp
QG54cC5jb20+OyBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+Ow0KPiAndS1i
b290QGxpc3RzLmRlbnguZGUnIDx1LWJvb3RAbGlzdHMuZGVueC5kZT4NCj4gQ2M6IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBBVzogRklFTERfUkVUVVJOIG9u
IGkuTVg4TU5BTk9MUEQ0IEVWSw0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBl
bWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcg
YXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUg
J1JlcG9ydCB0aGlzDQo+IGVtYWlsJyBidXR0b24NCj4gDQo+IA0KPiBIaSBZZSwNCj4gDQo+IFll
cywgSSBjYW4gYm9vdCBTUEwgd2l0aG91dCBzaWduYXR1cmUuIEkgYWxzbyBhZGRlZCBzb21lIGRl
YnVnIG1lc3NhZ2VzIHRvIG15DQo+IGJ1aWxkIGFuZCBJIGNhbiBzZWUgdGhhdCBTUEwgY2FuIGxv
YWQgdS1ib290IHByb3BlciB2aWEgVVNCIHVudGlsICdKdW1waW5nIHRvDQo+IFUtQm9vdCcgbWVz
c2FnZSBpbiBib2FyZF9pbml0X3IgZnVuY3Rpb24gKGNvbW1vbi9zcGwvc3BsLmMpDQo+IA0KPiBB
Y3R1YWxseSB0aGlzIGxvb2tzIGxpa2UgdGhlIFNFcnJvciBwcm9ibGVtIGNhdXNlZCBieSBlcnJh
dGEgRVJSMDUwMzUwIHdoaWNoDQo+IGhhcyBiZWVuIHdvcmtlZCBhcm91bmQgaW4gcGF0Y2ggMmYz
YzkyMDYwZGNkLiBCdXQgdGhhdCBwYXRjaCBpcyBjdXJyZW50bHkNCj4gYWN0aXZlIGluIHUtYm9v
dCBhbmQgc28gSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgdGhlIHByb2JsZW0gaXMgaGVyZSBpbiB0
aGlzIGNhc2UuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IFRob21hcw0KPiANCj4gLS0tLS1VcnNw
csO8bmdsaWNoZSBOYWNocmljaHQtLS0tLQ0KPiBWb246IFllIExpIDx5ZS5saUBueHAuY29tPg0K
PiBHZXNlbmRldDogRG9ubmVyc3RhZywgMTEuIEphbnVhciAyMDI0IDA1OjA5DQo+IEFuOiBQZW5n
IEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+OyBUaG9tYXMgU2NoYWVmZXINCj4gPHRo
b21hcy5zY2hhZWZlckBrb250cm9uLmNvbT47ICd1LWJvb3RAbGlzdHMuZGVueC5kZScNCj4gPHUt
Ym9vdEBsaXN0cy5kZW54LmRlPg0KPiBDYzogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+
IEJldHJlZmY6IFJFOiBGSUVMRF9SRVRVUk4gb24gaS5NWDhNTkFOT0xQRDQgRVZLDQo+IA0KPiBb
WW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHllLmxpQG54cC5jb20uIExlYXJuIHdoeSB0
aGlzIGlzIGltcG9ydGFudCBhdA0KPiBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRl
bnRpZmljYXRpb24gXQ0KPiANCj4gSSB0aGluayB0aGVyZSBpcyBubyBwYXJ0aWN1bGFyIFNXIHN1
cHBvcnQgbmVlZGVkIGZvciBGSUVMRF9SRVRVUk4gb24gOE1OLg0KPiBGcm9tIHdoYXQgeW91IGRl
c2NyaWJlZCwgeW91IGhhdmUgbW92ZWQgdGhlIHBhcnQgZnJvbSBjbG9zZWQgdG8NCj4gRklFTERf
UkVUVVJOLiBTbyBhcmUgeW91IGFibGUgdG8gYm9vdCBpbnRvIFNQTCB3aXRob3V0IHNpZ25hdHVy
ZT8NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gWWUgTGkNCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+IEZyb206IFBlbmcgRmFuIChPU1MpIDxwZW5nLmZhbkBvc3MubnhwLmNvbT4N
Cj4gPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSAxMSwgMjAyNCAxMTo1MSBBTQ0KPiA+IFRvOiBU
aG9tYXMgU2Now6RmZXIgPHRob21hcy5zY2hhZWZlckBrb250cm9uLmNvbT47ICd1LWJvb3RAbGlz
dHMuZGVueC5kZScNCj4gPiA8dS1ib290QGxpc3RzLmRlbnguZGU+OyBZZSBMaSA8eWUubGlAbnhw
LmNvbT4NCj4gPiBDYzogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gU3ViamVjdDog
UmU6IEZJRUxEX1JFVFVSTiBvbiBpLk1YOE1OQU5PTFBENCBFVksNCj4gPg0KPiA+ICtZZQ0KPiA+
DQo+ID4g5ZyoIDEvOS8yMDI0IDQ6NTIgUE0sIFRob21hcyBTY2hhZWZlciDlhpnpgZM6DQo+ID4g
PiBIaSBhbGwsDQo+ID4gPg0KPiA+ID4gV2UgYXJlIHRyeWluZyB0byBlbmFibGUgRklFTEQgUkVU
VVJOIG9uIHRoZSBOWFAgaS5NWDhNTmFubyBMUEQ0IEVWSw0KPiA+IGJvYXJkLg0KPiA+ID4NCj4g
PiA+IFdlIGVuYWJsZWQgU2VjdXJlIEJvb3QgaW4gdS1ib290IGluIHRoZSBmaXJzdCBzdGVwLiBB
ZnRlciBjaGVja2luZw0KPiA+ID4gcHJvcGVyDQo+ID4gZXhlY3V0aW9uIG9mIGEgc2lnbmVkIGJv
b3Rsb2FkZXIgaW1hZ2Ugd2UgY2xvc2VkIHRoZSBib2FyZCBibG93aW5nIHRoZQ0KPiA+IFNFQ19D
T05GSUcgZnVzZS4NCj4gPiA+DQo+ID4gPiBJbiB0aGUgbmV4dCBzdGVwIHdlIGNyZWF0ZWQgdGhl
IGJvYXJkIHNwZWNpZmljIHNpZ25hdHVyZSB3aXRoIFVJRCBvZg0KPiA+ID4gdGhlIENQVQ0KPiA+
IGluY2x1ZGVkIHRvIHJlbW92ZSB0aGUgRklFTEQgUkVUVVJOIGxvY2suIEFmdGVyIHRoYXQgd2Ug
d2VyZSBhYmxlIHRvDQo+ID4gYmxvdyB0aGUgRklFTERfUkVUVVJOIGZ1c2Ugd2l0aCAnZnVzZSBw
cm9nIDggMyAweDEnIGNvbW1hbmQuIEJ1dCBub3csDQo+ID4gdGhlIGJvYXJkIGNhbm5vdCBib290
IGFueSBtb3JlLCBpdCB3aWxsIGhhbmcgYWZ0ZXIgZXhlY3V0aW9uIG9mIHRoZSBTUEwNCj4gYm9v
dGxvYWRlciBwYXJ0Lg0KPiA+ID4NCj4gPiA+IFdlIGNhbiBvYnNlcnZlIHRoaXMgYmVoYXZpb3Ig
d2l0aCBib3RoIHNpZ25lZCBhbmQgdW5zaWduZWQNCj4gPiA+IGJvb3Rsb2FkZXINCj4gPiBpbWFn
ZXMuDQo+ID4gPg0KPiA+ID4gSXMgdGhlIEZJRUxEX1JFVFVSTiBmZWF0dXJlIGZvciB0aGUgaS5N
WDhNTmFubyBzdXBwb3J0ZWQgd2l0aCB1LWJvb3QNCj4gPiB2MjAyNC4wMT8NCj4gPiA+DQo+ID4g
PiBCZXN0IHJlZ2FyZHMsDQo+ID4gPiBUaG9tYXMNCj4gPiA+DQo+ID4gPg0KPiA+ID4gVGhvbWFz
IFNjaMOkZmVyDQo+ID4gPiBTVyBEZXNpZ24gRW5naW5lZXINCj4gPiA+DQo+ID4gPiB0aG9tYXMu
c2NoYWVmZXJAa29udHJvbi5jb20NCj4gPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3DQo+ID4gPiAlMkYmZGF0YT0w
NSU3QzAyJTdDeWUubGklNDBueHAuY29tJTdDMDYwYjJkNmVmYzQ0NDc0ZjZiNjMwOGRjMQ0KPiAy
YWFkM2MNCj4gPiA+DQo+IDglN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAl
N0MwJTdDNjM4NDA1NzcyMTMwMTk0Mg0KPiA1NCU3Qw0KPiA+ID4NCj4gVW5rbm93biU3Q1RXRnBi
R1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2DQo+IElr
DQo+ID4gPg0KPiAxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0Mmc2RhdGE9VEgx
M0pyakE1Y2pxQWVJZlJBdngNCj4gMlNzMWwNCj4gPiA+IDRpSFE3WXZicyUyRnVReUtyWSUyQlEl
M0QmcmVzZXJ2ZWQ9MA0KPiA+ID4gLmtvbnRyb24uY29tJTJGJmRhdGE9MDUlN0MwMiU3Q3Rob21h
cy5zY2hhZWZlciU0MGtvbnRyb24uY29tJTcNCj4gQzdlYjM4DQo+ID4gPg0KPiBmNTdhMDMwNGYw
MzBmMmYwOGRjMTI1YjFjNzQlN0M4YzlkM2M5NzNmZDk0MWM4YTJiMTY0NmYzOTQyZGFmMSU3QzAN
Cj4gJTcNCj4gPiA+DQo+IEMwJTdDNjM4NDA1NDI5NzMzNDkyMDk1JTdDVW5rbm93biU3Q1RXRnBi
R1pzYjNkOGV5SldJam9pTUM0d0xqDQo+IEF3TURBaQ0KPiA+ID4NCj4gTENKUUlqb2lWMmx1TXpJ
aUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0Mmc2QNCj4gYXRh
DQo+ID4gPg0KPiA9bk91V2IyTlNwUEJSbDVGYVY4eGE1TWlRWiUyRnpFN3o4RiUyRkMyUmZ2JTJG
N3l6byUzRCZyZXNlcnZlZD0NCj4gMA0KPiA+ID4NCj4gPiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+
IEtvbnRyb24gRXVyb3BlIEdtYkgNCj4gPiA+IEhlaW5yaWNoLUJhcnRoLVN0cmHDn2UgMS0xYSB8
IDY2MTE1IFNhYXJicsO8Y2tlbiB8IEdlcm1hbnkNCg==
