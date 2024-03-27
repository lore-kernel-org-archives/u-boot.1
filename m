Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0011C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 12:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BBEC8803A;
	Wed, 27 Mar 2024 13:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="G+bjCiVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C55CE8802E; Wed, 27 Mar 2024 13:06:50 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0717.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC2FD8803A
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 13:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sd/WeirOcVAJL9ZyVhjBkKMZ4cDM4iESoO2Ei6CEepmwSZ1zeOaC5wkn/1YVMYEXVjXLswOCy56pyjxax4BvAcfhcW9Poxt0uAIDvLHiHLieKHG17ewrgOascBlMsD4S8FiJ//roDyQi/GTxPHRRWkYRoTn00CBeRvTZWRghjuWWM/YMycMIt0tNyA9a46izLhyHYCcO2c7TEtD976KjaqkhZtGg1eLePyvS8XtpDFnWl6rD9VCE1xdVRJfa+pDKsApjzKk7OhsSpR2zSx21JKqSQllThieiYyDtXOZZD3Z9x4HIquNyyv+TtLelHUjHqQXgHf1PWaY4ZzgzwrXckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCxxtiESGXQJaPGLxpfRrQw88jr3IPYQs1t9+LKB1TY=;
 b=dLsjcd3hZzhTMx5hAWxVyunYnyd3o2fAPBXc514Y/4ATCEn60PjpY7JbaO8J8UJwDNfeoDW0V6RIVSyY+JI+/oPpdFelSL0oa2+47rgAmAWJpM9JjKuer+uK4y9a+Itg6vO2K3vmvU2zdBFzF2M55B4bK6fNKqaLu3nTZH1f4WJj5wlsKnlgoam56Iu4IbT0/4YspbYR4k/QZB9g7VfuAaYpSshaK3brz/ZR/byAhWxxvuP8MgsT2DpL1SqKBkEhjZlmOnCuB2yGEPj1SfBMCI2QFcqFG1jYZDN2KEVw5OHx1EnVpMRDwOEbRf27rIVirqB6QeFCHgHYN68AdbpDMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCxxtiESGXQJaPGLxpfRrQw88jr3IPYQs1t9+LKB1TY=;
 b=G+bjCiVP10s4Ol7R2z104TbA7n45iueqDYPoGggSYNHFufy0DY/PGFW8qnln30catlF9iofRdtQsjyxTC64fJgK1BlX6QJXsvE+4nBButg7wI0h01ObfCafX/DNrPMXL7Km/KsKlxyZmVomJ4ZnwPlFn0leFMD4BxIp54XKyihU=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 12:06:44 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 12:06:44 +0000
From: Josua Mayer <josua@solid-run.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Yazan Shhady <yazan.shhady@solid-run.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 NXP i.MX
 U-Boot Team <uboot-imx@nxp.com>, Baruch Siach <baruch@tkos.co.il>, Marcel
 Ziswiler <marcel.ziswiler@toradex.com>, "christian.gmeiner@gmail.com"
 <christian.gmeiner@gmail.com>
Subject: Re: [PATCH] mx6cuboxi: fix ethernet after synchronise device-tree
Thread-Topic: [PATCH] mx6cuboxi: fix ethernet after synchronise device-tree
Thread-Index: AQHZRfGmbBGGt3VMDEKAEzTzn3Dc262SFdGAg7vcwoA=
Date: Wed, 27 Mar 2024 12:06:44 +0000
Message-ID: <30c35e80-2015-4fac-b9dc-6902cc09c58e@solid-run.com>
References: <20220728070540.28554-1-josua@solid-run.com>
 <CA+EmdG5+QYxVo27C-u5W6FkuDgcoey4i-md9L4b9cs1gtsv+1g@mail.gmail.com>
In-Reply-To: <CA+EmdG5+QYxVo27C-u5W6FkuDgcoey4i-md9L4b9cs1gtsv+1g@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PA4PR04MB9222:EE_
x-ms-office365-filtering-correlation-id: ae7b2ae6-17e5-47f2-d4bc-08dc4e565ecd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uAsktyKN2q4DdlavbOoeN8Tt3uQsIfqbB6a1pH4JgxaqO2b0+BqQOJhXWQ6uzfR+oIbsLagvq3OKRtQy9bkRD6OiQoZRTaGFDps3Z3EulbbbOf1v2jw/s8UcjTX8TTIH5S3LHXhOxX6M5cyB3gYQ3AK+s3RO0yN9FUlofoPMtodE/jdoOy1tGbVmzFHh27oHLACihjyHM+reYIYKIhsr5JbQ2XljooIbVPV0G1s1IAmjLYS5JpR2nR7ceENX3+FqcrqLEsvGsBCba70n+cMjpp36wCuICER+cu6Mzl7VQGzYxqKhr2bsBvVvzQUHUDlYU3smlssVNr0Jktha3eH7BpofJqKdK1NKPegq228HjbVj3pixy5v59dzoUxPbApMj+6+krEHAPDH2TIgMFNlY3GBpkr6xrJFeZ57xITc1FbYuLgtxvi3OoERSh1kM3AwH/iLjmBrbzXnvuWv68f6/uDrWjmGiTVk17B4RAudo29hSkGj9BOQU9Y5wRZRNj4UAx3YQioHEibYBWWbseSpeNwQ95SIrrOMacfqLOE/ZY11g0Np3VQjbgNEyv6A5vtOI9Sk92+nhplWTNiDjywrqlTWJVctyh7AultpLzmI9rg1a1I/1zY+J5vZPRJuYYgLea0IGgu919+b24w8B5erptS6sHh1Ex3uN7lB01J7BR2YzitiVGugw/jo2lxTl0q/8EfILmSOVl4z3mM5SGU6g8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXVkeFJiKzl2V0VNQi9BbmNrRnFrVXA1aFg0Ti9XT3BwL29QaW9uU081VEQ5?=
 =?utf-8?B?b2plVTBLcmk5NjFNZXdyUkNCejFWZWhLSzFpZEh2Rm1HSDQ2S1l0ejJLYm9h?=
 =?utf-8?B?M0RNdXFrMmRKMEJHaUtKb0pSTTd3Qk9jWW10QnQrMDM2R2d1TGhCNWVKemxw?=
 =?utf-8?B?ZWVMQWVsL1d1ckwxVjFGSXNFaHRhdXd5Smt5VkFMV08rZGo0UjVEeGNvdXlE?=
 =?utf-8?B?RVpKWGIvdXo1RXE3Y3dhNWcrWEViRy9kcGhhdElVbk5LVkRMbkQwZnFtZk9m?=
 =?utf-8?B?dmZacUx6K0dNZU5USWdLdDhBQ0ZvOG5sMDUwdVppWVNWYjNHUDlROGRhSXo1?=
 =?utf-8?B?eHZ2MUVRTFdhbmFLTEJrdkJ4M0c0dXBEYXNlZWQ2dWxoRG1RcCtNcmZLZXlT?=
 =?utf-8?B?eUxRYVpXQW5EWnEveXREL3NFaHR3Z1Q4U0pCL3IxUjVsejVEMzk5UGlhdkNs?=
 =?utf-8?B?Y1Rha2N1VjQ2M2dOc1BQWEVUektVSW1BeWZqNWtsSXgrUGZMeFdJRW1mSTBM?=
 =?utf-8?B?Szl5WFZVN3FVMVBWaks0TGZZalpqM3g5eFl0UGlTWjYxRkord1E1NHI4eDBE?=
 =?utf-8?B?ZWF1aDdpZkR5TlBBamE1VDROdzFUd3VBN1NjK1QzSlhLODlGaTdmb2FZYjFu?=
 =?utf-8?B?dDREK1VyUDFpaTMrV0NBdVJPc2c0Vkx6Mlg0NW5Ua091Vk5nVk56MzRuVlJ2?=
 =?utf-8?B?VFgvUk8rTDhuQU5UUUt5U0FFRmlJbHo4R1lVUjdxdmJjZmsvV3E4bHA1cWFT?=
 =?utf-8?B?WnNDVTlYNnlHbUNQTHJUNjdCak5rcnJOWVZMdTJDSnpIbmZ2WjZ2V21leHFo?=
 =?utf-8?B?YWFSWFNlTTkzcHRPWE9sUmdqMUFuM080SVpVWENsUVVDSGJuM1IrTmRCL1Vw?=
 =?utf-8?B?REFIYUZIRDE2Y2FpdnJmMTdwT2pRQ0RNbTh6WEZlUmJOd2JIeEtadVhvZGpo?=
 =?utf-8?B?bVdyMVBMZDVvWm9LSkg0Qkwwb0Q4dW9RQ1VVcHNmTzRhd1BKWDZMbHREajhs?=
 =?utf-8?B?NGsvS1lCcDM1QS8yandWNTlzNS9vSWpVTnByaXAvMzdkOVo2a3l1QjBpb1E0?=
 =?utf-8?B?ZGFKK1BRSmF6T3BiZW0wYk4xUFZWOTgxaFlhZUZtbCtiWkFnMXMveWdTUHIy?=
 =?utf-8?B?YTNidml2eVlCampaemFuMm9oeUFYeDd0V0pDaVVwQSt0Q00xNUt5Q1JzaktM?=
 =?utf-8?B?M0VsZmEvR3BZQnY3V00rZ2FCNFNsRWFNS0pSRkd6OFFMQlhkWWZqYmV0U0JR?=
 =?utf-8?B?SWRneDNsNytWVXRuUW1SMVJsbnNHbXRqY0swa1R6bVJXSE1WMURYWVBLWkJo?=
 =?utf-8?B?eGN5a0c5SnJxQ3AwOUpqY1MzM2J0bkJhY1dMVitDOVZSVVpjZGFYM2c4MkRx?=
 =?utf-8?B?SFdxS1ZKYkc3aUpUeXFpVHNDMVBaV3haQlR5MTJxVHdDMFdmSmtZN3U4UlhS?=
 =?utf-8?B?MmJYajlBZHNCbW54V2VRMXBaWmpMNW1vWU0vc2gyUTRDbXpZSUJXMUVHdDlw?=
 =?utf-8?B?aCtiUHQzRFBvdVpiMzNzVll0RysrUmJmbWR1TlFHQnpaNkovZ1hWdkJ4L2lU?=
 =?utf-8?B?dmk2aTVQcTFyZmZ6RDlzQnRWV2VqUXg2Z3JYWTBtaStacnNrOUZBSlNGTUV3?=
 =?utf-8?B?NS9oK1EycjJNdGtjSkxUNFJKdFhjcDhZZGdBaVVkRm0zSFEyNkFJVzUyNFlo?=
 =?utf-8?B?MWlJS01SYzJRMFUwV09DcUlXTnZTYmwxMFNmcURQdmFPb1RMU0Y0ODArdVhk?=
 =?utf-8?B?bnNGRU5EVFAwdWgzV2tuQVZrRXFHYXRteklSRDRuZ3NmbDVIY1N0ajgvY2NO?=
 =?utf-8?B?dnRwTDdSZW5DenpPZ2NOZ2R5ZC9HZzhZZi96aUl0MzBrU0F1QVBQQThRa1hp?=
 =?utf-8?B?TVo3dTdDZHJGaDJ2eS81NjhVRGR1Y1g2UEU2V3k2eVJGdzNrQlRnSzh5bU9W?=
 =?utf-8?B?ZjU5RmllZkdWTWFqVFBOV1lLcU5paWVMRTlVSk9CMG5XMFhlR0NHMzFtWkxl?=
 =?utf-8?B?cDNvbkVJUTlVckRselFTRkIxd0VMSlhaZTF4QStkQU1IdUJWaXozOUVmdzdI?=
 =?utf-8?B?dnpTQmQ2dW00cDIreDl5UWNLSkVaR0hkRjYwRTZLU01NV1FaRzVmaTQwNHFj?=
 =?utf-8?Q?Jfbc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23125E4088E20F4180C7D5895DA65596@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7b2ae6-17e5-47f2-d4bc-08dc4e565ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 12:06:44.3885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8riMxT9ybJsT5vOk+KmTomsPVhFYwdRm+k6UYZWs/De7/pKMMOZ3ANWaAwZRe0r1K6OFPDgpHJ5N4lEjCNb6RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9222
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

Q2M6IGNocmlzdGlhbi5nbWVpbmVyQGdtYWlsLmNvbQ0KDQpIaSBDaHJpc3RpYW4sDQoNCnBsZWFz
ZSB0YWtlIGEgbG9vayBhdCB0aGlzIHBhdGNoLCBJIHN1c3BlY3QgaXQgd2lsbCAoaGFjay0pZml4
IHlvdXINCmV0aGVybmV0IGlzc3VlLg0KDQpVbmZvcnR1bmF0ZWx5IEkgaGFkIG5vIHRpbWUgdG8g
cmV2aXNpdCB0aGlzIHlldCBhbmQgaW1wbGVtZW50IGEgY29ycmVjdCBzb2x1dGlvbi4NCg0Kc2lu
Y2VyZWx5DQpKb3N1YSBNYXllcg0KDQpBbSAyOC4wNy4yMiB1bSAwOTowOCBzY2hyaWViIEpvc3Vh
IE1heWVyOg0KPiBQbGVhc2UgaG9sZCBvZmYgbWVyZ2luZyB0aGlzIHBhdGNoIHVudGlsIHNvbWVv
bmUgdGVzdGVkIGl0LCBJIGNhbiBub3QgZG8gc28gdGhpcyB3ZWVrLg0KPiBAVG9tIENhbiB5b3Ug
Y29uZmlybSBpZiB0aGlzIGZpeGVzIHRoZSBuZXR3b3JraW5nIG9uIHlvdXIgQ3Vib3g/DQo+IEFs
c28gbm90ZSB0aGF0IHRoZSBwaHktaGFuZGxlIHByb3BlcnR5IG1heSBvciBtYXkgbm90IGJlIHJl
cXVpcmVkLCBJIGFtIG5vdCBzdXJlLg0KPg0KPiBzaW5jZXJlbHkNCj4gSm9zdWEgTWF5ZXINCj4N
Cj4gT24gVGh1LCBKdWwgMjgsIDIwMjIgYXQgNzowNSBBTSBKb3N1YSBNYXllciA8am9zdWFAc29s
aWQtcnVuLmNvbT4gd3JvdGU6DQo+DQo+ICAgICBUaGUgaS5NWDYgQ3Vib3gtaSBhbmQgSHVtbWlu
Z0JvYXJkcyBjYW4gaGF2ZSBkaWZmZXJlbnQgUEhZcyBhdCB2YXJ5aW5nDQo+ICAgICBhZGRyZXNz
ZXMuIFUtQm9vdCBuZWVkcyB0byBhdXRvLWRldGVjdCB3aGljaCBwaHkgaXMgYWN0dWFsbHkgcHJl
c2VudCwNCj4gICAgIGFuZCBhdCB3aGljaCBhZGRyZXNzIGl0IGlzIHJlc3BvbmRpbmcuDQo+DQo+
ICAgICBBdXRvLWRldGVjdGlvbiBmcm9tIG11bHRpcGxlIHBoeSBub2RlcyBzcGVjaWZpZWQgaW4g
ZGV2aWNlLXRyZWUgZG9lcyBub3QNCj4gICAgIGN1cnJlbnRseSB3b3JrIGNvcnJlY3QuIEFzIGEg
d29yay1hcm91bmQgbWVyZ2UgYWxsIHRocmVlIHBvc3NpYmxlIHBoeXMNCj4gICAgIGludG8gb25l
IG5vZGUgd2l0aCB0aGUgc3BlY2lhbCBhZGRyZXNzIDB4ZmZmZmZmZmYgd2hpY2ggaW5kaWNhdGVz
IHRvIHRoZQ0KPiAgICAgZ2VuZXJpYyBwaHkgZHJpdmVyIHRvIHByb2JlIGFsbCBhZGRyZXNzZXMu
DQo+ICAgICBBbHNvIGZpeHVwIHRoaXMgZmFrZSBhZGRyZXNzIGJlZm9yZSBib290aW5nIExpbnV4
LCAqaWYqIGJvb3Rpbmcgd2l0aA0KPiAgICAgVS1Cb290J3MgaW50ZXJuYWwgZHRiLg0KPg0KPiAg
ICAgU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+ICAg
ICBGaXhlczogZDAzOTlhNDZlN2NkDQo+ICAgICAtLS0NCj4gICAgIMKgYXJjaC9hcm0vZHRzL2lt
eDZxZGwtc3Itc29tLmR0c2nCoCDCoCDCoHwgMzAgKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiAgICAgwqBib2FyZC9zb2xpZHJ1bi9teDZjdWJveGkvbXg2Y3Vib3hpLmMgfMKgIDYgKysr
KystDQo+ICAgICDCoDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRp
b25zKC0pDQo+DQo+ICAgICBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL2lteDZxZGwtc3Itc29t
LmR0c2kgYi9hcmNoL2FybS9kdHMvaW14NnFkbC1zci1zb20uZHRzaQ0KPiAgICAgaW5kZXggY2U1
NDNlMzI1Yy4uMmQ3Y2JjMjZiMyAxMDA2NDQNCj4gICAgIC0tLV9hL2FyY2gvYXJtL2R0cy9pbXg2
cWRsLXNyLXNvbS5kdHNpDQo+ICAgICArKysgYi9hcmNoL2FybS9kdHMvaW14NnFkbC1zci1zb20u
ZHRzaQ0KPiAgICAgQEAgLTUzLDYgKzUzLDcgQEANCj4gICAgIMKgJmZlYyB7DQo+ICAgICDCoCDC
oCDCoCDCoCBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAgICAgwqAgwqAgwqAgwqAgcGlu
Y3RybC0wID0gPCZwaW5jdHJsX21pY3Jvc29tX2VuZXRfYXI4MDM1PjsNCj4gICAgICvCoCDCoCDC
oCDCoHBoeS1oYW5kbGUgPSA8JnBoeT47DQo+ICAgICDCoCDCoCDCoCDCoCBwaHktbW9kZSA9ICJy
Z21paS1pZCI7DQo+DQo+ICAgICDCoCDCoCDCoCDCoCAvKg0KPiAgICAgQEAgLTY4LDMwICs2OSwx
NyBAQA0KPiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQo+ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAjc2l6ZS1jZWxscyA9IDwwPjsNCj4NCj4g
ICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qDQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgKiBUaGUgUEhZIGNhbiBhcHBlYXIgYXQgZWl0aGVyIGFkZHJlc3MgMCBvciA0IGR1ZSB0
byB0aGUNCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIGNvbmZpZ3VyYXRpb24gKExF
RCkgcGluIG5vdCBiZWluZyBwdWxsZWQgc3VmZmljaWVudGx5Lg0KPiAgICAgLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICovDQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBldGhlcm5ldC1w
aHlAMCB7DQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZWcgPSA8
MD47DQo+ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwaHk6IGV0aGVybmV0LXBoeUAwIHsN
Cj4gICAgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qDQo+ICAgICArwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBUaGUgUEhZIGNhbiBhcHBlYXIgZWl0
aGVyOg0KPiAgICAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogLSBBUjgw
MzU6IGF0IGFkZHJlc3MgMCBvciA0DQo+ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgKiAtIEFESU4xMzAwOiBhdCBhZGRyZXNzIDENCj4gICAgICvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIEFjdHVhbCBhZGRyZXNzIGJlaW5nIGRldGVjdGVkIGF0
IHJ1bnRpbWUuDQo+ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKi8N
Cj4gICAgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlZyA9IDwweGZmZmZm
ZmZmPjsNCj4gICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHFjYSxjbGst
b3V0LWZyZXF1ZW5jeSA9IDwxMjUwMDAwMDA+Ow0KPiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgcWNhLHNtYXJ0ZWVlLXR3LXVzLTFnID0gPDI0PjsNCj4gICAgIC3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoH07DQo+ICAgICAtDQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBldGhlcm5ldC1waHlANCB7DQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZWcgPSA8ND47DQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBxY2EsY2xrLW91dC1mcmVxdWVuY3kgPSA8MTI1MDAwMDAwPjsNCj4gICAgIC3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHFjYSxzbWFydGVlZS10dy11cy0xZyA9IDwyND47
DQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9Ow0KPiAgICAgLQ0KPiAgICAgLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgLyoNCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIEFE
SU4xMzAwIChzb20gcmV2IDEuOSBvciBsYXRlcikgaXMgYWx3YXlzIGF0IGFkZHJlc3MgMS4gSXQN
Cj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIHdpbGwgYmUgZW5hYmxlZCBhdXRvbWF0
aWNhbGx5IGJ5IFUtQm9vdCBpZiBkZXRlY3RlZC4NCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAqLw0KPiAgICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXRoZXJuZXQtcGh5QDEgew0K
PiAgICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmVnID0gPDE+Ow0KPiAg
ICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYWRpLHBoeS1vdXRwdXQtY2xv
Y2sgPSAiMTI1bWh6LWZyZWUtcnVubmluZyI7DQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAgICAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfTsNCj4gICAgIMKgIMKgIMKgIMKgIH07DQo+ICAgICDCoH07DQo+ICAgICBkaWZm
IC0tZ2l0IGEvYm9hcmQvc29saWRydW4vbXg2Y3Vib3hpL214NmN1Ym94aS5jIGIvYm9hcmQvc29s
aWRydW4vbXg2Y3Vib3hpL214NmN1Ym94aS5jDQo+ICAgICBpbmRleCBkZWJmNGY2YTNiLi41MjE3
MmEwM2IxIDEwMDY0NA0KPiAgICAgLS0tX2EvYm9hcmQvc29saWRydW4vbXg2Y3Vib3hpL214NmN1
Ym94aS5jDQo+ICAgICArKysgYi9ib2FyZC9zb2xpZHJ1bi9teDZjdWJveGkvbXg2Y3Vib3hpLmMN
Cj4gICAgIEBAIC00NDYsNyArNDQ2LDcgQEAgc3RhdGljIGludCBmaW5kX2V0aGVybmV0X3BoeSh2
b2lkKQ0KPiAgICAgwqAgKi8NCj4gICAgIMKgaW50IGZ0X2JvYXJkX3NldHVwKHZvaWQgKmZkdCwg
c3RydWN0IGJkX2luZm8gKmJkKQ0KPiAgICAgwqB7DQo+ICAgICAtwqAgwqAgwqAgwqBpbnQgbm9k
ZV9waHkwLCBub2RlX3BoeTEsIG5vZGVfcGh5NDsNCj4gICAgICvCoCDCoCDCoCDCoGludCBub2Rl
X3BoeSwgbm9kZV9waHkwLCBub2RlX3BoeTEsIG5vZGVfcGh5NDsNCj4gICAgIMKgIMKgIMKgIMKg
IGludCByZXQsIHBoeTsNCj4gICAgIMKgIMKgIMKgIMKgIGJvb2wgZW5hYmxlX3BoeTAgPSBmYWxz
ZSwgZW5hYmxlX3BoeTEgPSBmYWxzZSwgZW5hYmxlX3BoeTQgPSBmYWxzZTsNCj4gICAgIMKgIMKg
IMKgIMKgIGVudW0gYm9hcmRfdHlwZSBib2FyZDsNCj4gICAgIEBAIC00NzgsNiArNDc4LDEwIEBA
IGludCBmdF9ib2FyZF9zZXR1cCh2b2lkICpmZHQsIHN0cnVjdCBiZF9pbmZvICpiZCkNCj4gICAg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAwOw0KPiAgICAgwqAgwqAgwqAgwqAgfQ0K
Pg0KPiAgICAgK8KgIMKgIMKgIMKgLy8gdXBkYXRlIFUtQm9vdCdzIG93biB1bmlmaWVkIHBoeSBu
b2RlIHBoeSBhZGRyZXNzLCBpZiBwcmVzZW50DQo+ICAgICArwqAgwqAgwqAgwqBub2RlX3BoeSA9
IGZkdF9wYXRoX29mZnNldChmZHQsICIvc29jL2J1c0AyMTAwMDAwL2V0aGVybmV0QDIxODgwMDAv
bWRpby9waHkiKTsNCj4gICAgICvCoCDCoCDCoCDCoHJldCA9IGZkdF9zZXRwcm9wX3UzMihmZHQs
IG5vZGVfcGh5LCAicmVnIiwgcGh5KTsNCj4gICAgICsNCj4gICAgIMKgIMKgIMKgIMKgIC8vIHVw
ZGF0ZSBhbGwgcGh5IG5vZGVzIHN0YXR1cw0KPiAgICAgwqAgwqAgwqAgwqAgbm9kZV9waHkwID0g
ZmR0X3BhdGhfb2Zmc2V0KGZkdCwgIi9zb2MvYnVzQDIxMDAwMDAvZXRoZXJuZXRAMjE4ODAwMC9t
ZGlvL2V0aGVybmV0LXBoeUAwIik7DQo+ICAgICDCoCDCoCDCoCDCoCByZXQgPSBmZHRfc2V0cHJv
cF9zdHJpbmcoZmR0LCBub2RlX3BoeTAsICJzdGF0dXMiLCBlbmFibGVfcGh5MCA/ICJva2F5IiA6
ICJkaXNhYmxlZCIpOw0KPiAgICAgLS1fDQo+ICAgICAyLjM3LjENCj4NCg==
