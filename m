Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1565DC4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 20:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7167387C6A;
	Thu,  1 Feb 2024 21:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=variscite.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=variscite.com header.i=@variscite.com header.b="FwuCNkVo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6288487C00; Thu,  1 Feb 2024 21:17:10 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1E9F87BDB
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 21:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=variscite.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ken.s@variscite.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQWEMaJAQh1s208HHvJvEnUiT8IuDJy0gXPOMgo3i/msvZ0FLG1xsXbJA922+mgTZ/H+2GjZIGyuaPifvUOT3nm0JT/8NHLsmZoBFaBmk2JveZEeBdiSb2V4/sUa7pdU30UtlcUj0gBiBpR1DPnS8SgMFvxKwXoD0uOXWbzTFodOGz7JLeR4UngMC5vapn7XwGLj8Ei6jy5HDdUQJXOZpfIEGOevguqk68R48bdx2/Ab9v+Za9uiPNYuQmFcagJO05xtJ4Zm8NPwoYxNW+zKp5d/sX9Y3FwK9G5+TCttleWdQzU5aOnANz7C1BEfLsno/aAbRdN9uL18RkZdR/Nq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+eM/r9rQpJLJ2x48jryHM0Vmp5dPKeGiDCt9BJ8Sxo=;
 b=nynf+Ve9jRUPd58uvJm+GQmT+JXebPr4CSaX2LMHBrCYlZe2XTFv6WEB81CY5Ue430yQu5a/dv9RilBR4pZnMw4LUdbKKCcndoXwU5x27620kHDYRHowjT6PVu5qajyNsBa2bg3xh/WjJQUmEX0YGIv7+74ajYIGP5MV6Kk8ADflx+aWbCeEugxi83f8/EA2FqN/0gX7O8OWJnJHtqZxATszxjRQSrKv4SKeD8R13Raef8dX+wTcheVwruxYI9NeCnuXP6aQh0+mXvHyslFohGJaO4mU+YeL9Jt58If8e914dePmP2A8Uwp53yN9vp1mMWlPJydZbC3gcWG1Cv4BAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+eM/r9rQpJLJ2x48jryHM0Vmp5dPKeGiDCt9BJ8Sxo=;
 b=FwuCNkVoYy3ZTyFYTO48O5b4VFhhNrk1IGBTzGozHKedeagbt0Q+dEqlSJu39/IgvaX5XNUC+C3qLhQdaGEdmDiHhQe4B3ywGF/6m8kUBfoRHuA6K4bOTjqfQHguh+HJH9ISbghbMAmV2/ZiMENap/PoWsxyqSuSsPClPwJJHhu0Dp9s+ORQhsRMwu5QuUFxt2strmw94Y707GMvEJJQFGj+rnwV2ho9X1Mjz/Z7Xqwjz8QTxpZO51/gqMrsjo5W/2hGzQ6bYpQmo9d4KDKjdPmq/bLU3k31oJxlTwPlnmflmUJlLQuQJsNGJEq0iWli3oZc4Ow+iVvqQeDe7mbUGw==
Received: from AS8PR08MB7991.eurprd08.prod.outlook.com (2603:10a6:20b:570::15)
 by AM8PR08MB5649.eurprd08.prod.outlook.com (2603:10a6:20b:1dd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Thu, 1 Feb
 2024 20:17:05 +0000
Received: from AS8PR08MB7991.eurprd08.prod.outlook.com
 ([fe80::b2bf:19a4:2606:e0a4]) by AS8PR08MB7991.eurprd08.prod.outlook.com
 ([fe80::b2bf:19a4:2606:e0a4%4]) with mapi id 15.20.7249.023; Thu, 1 Feb 2024
 20:17:05 +0000
From: Ken Sloat <ken.s@variscite.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "mripard@kernel.org"
 <mripard@kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "s-anna@ti.com" <s-anna@ti.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>
CC: Roger Quadros <rogerq@kernel.org>, Nate Drude <Nate.D@variscite.com>, Eran
 Matityahu <eran.m@variscite.com>
Subject: [PATCH v2 1/1] net: ti: am65-cpsw-nuss: Remove incorrect RGMII_ID bit
 functionality
Thread-Topic: [PATCH v2 1/1] net: ti: am65-cpsw-nuss: Remove incorrect
 RGMII_ID bit  functionality
Thread-Index: AQHaVUUPFzGzeSZhj0GNDCBbBcFrnA==
Date: Thu, 1 Feb 2024 20:17:05 +0000
Message-ID: <AS8PR08MB79915B184330438FBFE664DAEC432@AS8PR08MB7991.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR08MB7991:EE_|AM8PR08MB5649:EE_
x-ms-office365-filtering-correlation-id: 26896f4f-2487-4b84-9bfd-08dc2362c237
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x6m6W5iKIX/Wa/SnvoFTYyMPp7Vo/XaCICQJSkKQUJAWF5GjTO2wmwpTZz7ggqAvuewdDPCg3NRVersFwItaGzNAkj8J5MCXhv3ojyUYDVZIClYP+/r9LBTSBTTcwQGQvL7RjLCwaM+TElMe9FNd4ezDxt8tA/ppgo4rqNOx02ZDGEIrt+2Ilrzh0KB5cp6K4yCUHlcssXV+oErXt3c+VwsIHJ9kU7gdS1/STlfSpkOHs2mlTfdnEkakObBiMJ6pOW4hw+ZVFqKwwOo7zCDx3iM6KIUM8JNk6w2eVLFLqQhxGUSyN2ym/yvMu8a+bPCcsRvIh22alYH/kH8+BIxidWIDQUvlsnBlyrS0Yr3yOxW4kBKGmPcSxiF/6W0ian7LRruol+fOeynUkn+1jQjb4dPXt5IuWIVX3zMISy6cFMHZnCNER9DAn/JIZKEA4fuGb6iZlHaDZwA5q5PuY58rO1McufQbDuDOn5J4CDx+virG1hhp2PYivJfe+aVetoGfDye3cBm4QX3E02Cpp+Lp1PMfH2Hnjqd8Y8j6seKmZLzluciOUYfpfEqsGmWnRfzNgMPOuPwjE2l9Jf7tJs8Np6qub3LDFKN7UFGqDPiiH7w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7991.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(136003)(396003)(346002)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(83380400001)(33656002)(86362001)(41300700001)(38070700009)(122000001)(107886003)(38100700002)(26005)(9686003)(966005)(7696005)(6506007)(2906002)(478600001)(66946007)(76116006)(110136005)(91956017)(316002)(66556008)(71200400001)(66476007)(66446008)(64756008)(54906003)(5660300002)(4326008)(52536014)(8936002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXhHU0V3WjA2R3JiUStSWmdUWjR6RkMyMmRJdmcyQktGKytpZGx1RlNIam1Y?=
 =?utf-8?B?US9kbTJQSWVaV2dkdUorbWhCOUdNMm9idXVnQnZlRGgvMVJyaTFvOFdsdGZ3?=
 =?utf-8?B?bjdsMmhrS3RCNzJzNTRCMXlKbEl5azZQYzYvVERHbmpoR2QrbDYzOFltcEhv?=
 =?utf-8?B?L1dDUFBYVzBPM0dsTDl6Y3d0WHluclluMjVuMzJEZ1hBalRVZUtFWjJDeEcw?=
 =?utf-8?B?WFlUdmlOOVpFclI2QXRjeHVudDlxZnpZeHdYeFdXZ083cVhQYXJwY0JWUGRz?=
 =?utf-8?B?dXBqT3ZMNHBiS25MSHFXZloxeDIvM2tYWTY0VW0wT0lpNFkxKzFSVXFON0Fs?=
 =?utf-8?B?U1VvNDl3TlRkZldCRHVoRTgrOVZYUGhybkpVMWVxcFRRR1Rmdjg0dnhUdWFk?=
 =?utf-8?B?TnJ6azJjNUo4ZHhxWm45NmZuYlkvTXY1ejh4Yk9KN2M5NmZKMVhHb3ZYRE5m?=
 =?utf-8?B?YUY5blZLeVlQNTBJeWpvOGh6ZGg5UTFBK3dRMTFkdStUNEFkS2dPK3JsSXRM?=
 =?utf-8?B?ZGpsdEVQSGpaMUJkT2s2QWEvbFFUY1kxZDBxZmdrb1VLMHEwUFdnQ2U4cXZD?=
 =?utf-8?B?SXZ4NTN0STh5SVU2d05VUnVBdytUZndZWGJBUzZKTzl1blBRZGRoV3dWTFFS?=
 =?utf-8?B?eG1VZFVORE1FOStmRENvMjJRWmU2Z3lVb1UzODMyeHBXZklnWUo2eFpzTmN1?=
 =?utf-8?B?V0VydVFKS1BtcG01M3BpYldMM05VNXVHQnkveHdOOVRtZzFVd0tJbXgxVmNr?=
 =?utf-8?B?NjEzcFAvK0dTem5oUzVJaXlzd3llVjVjTXBaQ2t3aHpqVDgyeTlDM1htWTIx?=
 =?utf-8?B?bWJyR3hscDVtL01mYlJ4TnNuYzRLbVhRMXpKZnNMVG5HSElsRndGQnhDeXBL?=
 =?utf-8?B?UmJuL05RbkhTTkZVZSs3VW53LzQzWUZNbXVYSFVaWHA2Yll5WlZIeGFvOEVN?=
 =?utf-8?B?cmNkaWZybk9pbkdWdDZ2aDI5SW5mcFZ1NTlPV0pkcFFmS3dXMHM2K0o0UGJz?=
 =?utf-8?B?dXhMbkorY2NkQS9hd0JYNjRvbnBpNEk1bm45L2cvWVo3MW4yYWw3UkEreVZP?=
 =?utf-8?B?bHhkSmlNdFpkQkVLaG1jWmxkcDJXdmROaGgxS0pMa0NCNkZMd1cvaW14NXJO?=
 =?utf-8?B?bmlnaUlsQmRXMDU5aldwSmVTTlFLYTBKN0xLZzNCRjhnTXAxWnhzc2dueDhh?=
 =?utf-8?B?QldSbnZHNk5wMytvNERwVzNjSVZMTnZub1hBZEdkQzk0UmZhZ3ZWOHI2VXRj?=
 =?utf-8?B?QlZWN1VNQVVSUDg1TExjaXdXeFVrYTN0WGNnbFVMMjZlazhvQzh3UDVDcU5r?=
 =?utf-8?B?TWtaZ1lnY0lRRlBEd1kwL095eURKSUIwcGJiN1EvTE1WWnJqQXhxMHhWdXph?=
 =?utf-8?B?bEFWVmpZWlNmWkpLV2E5NzFWdGN6ajRTeE1wU3dqMDgzWmNrNkJYd3RuYllj?=
 =?utf-8?B?UnRIdlloWG9jQVppRU9tQmkvMUdkU0xSRGhoUXhUSmltOWIwUUUvcWFQYXBK?=
 =?utf-8?B?U3dhZzVXL005M3BoekRHTm5PejFPa3FQVVFrTERFSkJmZnhodVk2TkVwMTRM?=
 =?utf-8?B?NVVhRnp5aktiVnk5U1FPSjYxR0F4RkYrYWdtM3h2bjF3OFpVK2lONm82dnpX?=
 =?utf-8?B?N2ttY3NLK2ZCMkpTdzMwUnd5emF5Y1FmMnE2UEhOVlM5WXNRWGN4dTNRMVU5?=
 =?utf-8?B?c1VLRXRTYyt2N3JRQTJpQUk4cXE2UzZmeG9lMnYxQlZpQ0ZSL2RLYUFHMWZ1?=
 =?utf-8?B?RnhIdHkxdzhWQms2ZWNwOXhDd28vaUYrcE50WjBOdjdSUGp2NXBxeUw2b1hx?=
 =?utf-8?B?bDJDdVVYUUptRmRWTTRJMHdldWV6NGxZcDJ3NjNzdE1NRmFTSERHUGNYcEpJ?=
 =?utf-8?B?TTd0TXFnd2RYNFNyODNlbmFIUkJQTjNZK3YzRE1VWDBmTGUzWll3dWFLT0pM?=
 =?utf-8?B?YzR3UE1XVzBsbXhjZUl5OVlsdjRBejUraFBhTVNoNHBwTkFkVG5xK1hmcUsr?=
 =?utf-8?B?bWJFa0k4ZmxVaUVSWHBEZHh1QVpoQTVGMkh4OUtpZWZ6QUxleWRKYTdiemc2?=
 =?utf-8?B?UnUwZm4wMTZzQ2lTWG1yZklFaFN2T0JSL3hZVzlwRGJleXVBRGdCdzU3Y29W?=
 =?utf-8?Q?aMKw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7991.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26896f4f-2487-4b84-9bfd-08dc2362c237
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 20:17:05.1773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esVMsjGokez8cwCdt9TRdn5MS7Fqgmjdm1uNz5rSiNL/GufL9fJRdVhDqW9CLz4KoVSmde1L+dVGiOLYUf51Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5649
X-Mailman-Approved-At: Thu, 01 Feb 2024 21:39:23 +0100
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

VGhlIENQU1cgaW1wbGVtZW50YXRpb25zIG9uIHRoZSBBTTZ4IHBsYXRmb3JtcyBkbyBub3Qgc3Vw
cG9ydCB0aGUKc2VsZWN0YWJsZSBSR01JSSBUWCBjbGsgZGVsYXkgZnVuY3Rpb25hbGl0eSB2aWEg
dGhlIFJHTUlJX0lEX01PREUgYml0IGFzCnRoZSBlYXJsaWVyIHBsYXRmb3JtcyBkaWQuIFdoaWxl
IGl0IGlzIHBvc3NpYmxlIHRvIHdyaXRlIHRoZSBiaXQsCmFjY29yZGluZyB0byB2YXJpb3VzIFRJ
IEFNNnggZGF0YXNoZWV0cywgcmVmZXJlbmNlIG1hbnVhbHMsIGhhcmR3YXJlCmRlc2lnbiBndWlk
ZXMgYW5kIFRJIGZvcnVtIHBvc3RzIGZyb20gVEksIHRoaXMgYml0IGlzICJub3QgdGltZWQsIHRl
c3RlZApvciBjaGFyYWN0ZXJpemVkLiBSR01JSV9JRCBpcyBlbmFibGVkIGJ5IGRlZmF1bHQuIgoK
VGhlIGRyaXZlciBpbXBsZW1lbnRhdGlvbiB0b2RheSBob3dldmVyLCB3aWxsIGluY29ycmVjdGx5
IHNldCB0aGlzIGJpdAp3aGVuZXZlciB0aGUgaW50ZXJmYWNlIG1vZGUgaXMgaW4gUkdNSUlfSUQg
b3IgUkdNSUlfVFhJRC4gU2luY2UKZGlzYWJsaW5nIHRoZSBkZWxheSAoYml0PTEpIGlzIG5vdCBz
dXBwb3J0ZWQgYnkgVEksIHRoaXMgYml0IHNob3VsZAphbHdheXMgYmUgd3JpdHRlbiBhcyAwLgoK
U2VlOgpodHRwczovL2UyZS50aS5jb20vc3VwcG9ydC9wcm9jZXNzb3JzLWdyb3VwL3Byb2Nlc3Nv
cnMvZi9wcm9jZXNzb3JzLWZvcnVtLzEyMTEzMDYvYW02MjUtZW5ldDFfY3RybF9yZ21paV9pZC1f
bW9kZQpodHRwczovL3d3dy50aS5jb20vbGl0L3BkZi9zcHJ1aXY3IChSZXYuIEIgRmlndXJlIDE0
LTE3MTcpCmh0dHBzOi8vd3d3LnRpLmNvbS9saXQvZ3BuL2FtNjI1IChSZXYuIEIgRmlndXJlIDct
MzEgTm90ZSBBKQpodHRwczovL3d3dy50aS5jb20vbGl0L2FuL3NwcmFkMDViL3NwcmFkMDViLnBk
ZiAoUmV2LiBCIFNlY3Rpb24gNy40KQoKU2lnbmVkLW9mZi1ieTogS2VuIFNsb2F0IDxrZW4uc0B2
YXJpc2NpdGUuY29tPgotLS0KCk5vdGVzOgrCoCDCoCBDaGFuZ2VzIGluIHYyOgrCoCDCoCAtRXhw
bGljaXRseSBjbGVhciBSR01JSV9JRCBiaXQgaW4gYWxsIGNhc2VzCsKgIMKgIC1DbGFyaWZ5IGNv
bW1pdCBtZXNzYWdlIGJhc2VkIG9uIGl0ZW1zIGluIHYxIHJldmlldwoKwqBkcml2ZXJzL25ldC90
aS9hbTY1LWNwc3ctbnVzcy5jIHwgMTIgKysrKysrLS0tLS0tCsKgMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC90
aS9hbTY1LWNwc3ctbnVzcy5jIGIvZHJpdmVycy9uZXQvdGkvYW02NS1jcHN3LW51c3MuYwppbmRl
eCA2ZGEwMThjMGY5Li4wODM2ZGExNTgzIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC90aS9hbTY1
LWNwc3ctbnVzcy5jCisrKyBiL2RyaXZlcnMvbmV0L3RpL2FtNjUtY3Bzdy1udXNzLmMKQEAgLTI1
MCwxMyArMjUwLDEzIEBAIG91dDoKwqAjZGVmaW5lIEFNNjVfR01JSV9TRUxfTU9ERV9TR01JSeKA
guKAguKAgjMKwqAKwqAjZGVmaW5lIEFNNjVfR01JSV9TRUxfUkdNSUlfSURNT0RF4oCCQklUKDQp
CisjZGVmaW5lIEFNNlhfR01JSV9TRUxfTU9ERV9TRUxfTUFTS+KAguKAguKAguKAguKAguKAgkdF
Tk1BU0soMiwgMCkKwqAKwqBzdGF0aWMgaW50IGFtNjVfY3Bzd19nbWlpX3NlbF9rMyhzdHJ1Y3Qg
YW02NV9jcHN3X3ByaXYgKnByaXYsCsKg4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCIHBoeV9pbnRlcmZhY2VfdCBwaHlf
bW9kZSkKwqB7CsKg4oCC4oCC4oCC4oCC4oCCc3RydWN0IHVkZXZpY2UgKmRldiA9IHByaXYtPmRl
djsKwqDigILigILigILigILigIJ1MzIgb2Zmc2V0LCByZWcsIHBoYW5kbGU7Ci3igILigILigILi
gILigIJib29sIHJnbWlpX2lkID0gZmFsc2U7CsKg4oCC4oCC4oCC4oCC4oCCZmR0X2FkZHJfdCBn
bWlpX3NlbDsKwqDigILigILigILigILigIJ1MzIgbW9kZSA9IDA7CsKg4oCC4oCC4oCC4oCC4oCC
b2Zub2RlIG5vZGU7CkBAIC0yOTYsNyArMjk2LDYgQEAgc3RhdGljIGludCBhbTY1X2Nwc3dfZ21p
aV9zZWxfazMoc3RydWN0IGFtNjVfY3Bzd19wcml2ICpwcml2LArCoOKAguKAguKAguKAguKAgmNh
c2UgUEhZX0lOVEVSRkFDRV9NT0RFX1JHTUlJX0lEOgrCoOKAguKAguKAguKAguKAgmNhc2UgUEhZ
X0lOVEVSRkFDRV9NT0RFX1JHTUlJX1RYSUQ6CsKg4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCCbW9kZSA9IEFNNjVfR01JSV9TRUxfTU9ERV9SR01JSTsKLeKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAgnJnbWlpX2lkID0gdHJ1ZTsKwqDigILigILigILigILigILigILigILi
gILigILigILigIJicmVhazsKwqAKwqDigILigILigILigILigIJjYXNlIFBIWV9JTlRFUkZBQ0Vf
TU9ERV9TR01JSToKQEAgLTMxMywxNSArMzEyLDE2IEBAIHN0YXRpYyBpbnQgYW02NV9jcHN3X2dt
aWlfc2VsX2szKHN0cnVjdCBhbTY1X2Nwc3dfcHJpdiAqcHJpdiwKwqDigILigILigILigILigILi
gILigILigILigILigILigIJicmVhazsKwqDigILigILigILigILigIJ9OwrCoAot4oCC4oCC4oCC
4oCC4oCCaWYgKHJnbWlpX2lkKQot4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCbW9k
ZSB8PSBBTTY1X0dNSUlfU0VMX1JHTUlJX0lETU9ERTsKK+KAguKAguKAguKAguKAgi8qIFJHTUlJ
X0lEX01PREUgPSAxIGlzIG5vdCBzdXBwb3J0ZWQgKi8KK+KAguKAguKAguKAguKAgnJlZyAmPSB+
QU02NV9HTUlJX1NFTF9SR01JSV9JRE1PREU7CivigILigILigILigILigIJyZWcgJj0gfkFNNlhf
R01JSV9TRUxfTU9ERV9TRUxfTUFTSzsKK+KAguKAguKAguKAguKAgnJlZyB8PSBtb2RlOwrCoAot
4oCC4oCC4oCC4oCC4oCCcmVnID0gbW9kZTsKwqDigILigILigILigILigIJkZXZfZGJnKGRldiwg
ImdtaWlfc2VsIFBIWSBtb2RlOiAldSwgbmV3IGdtaWlfc2VsOiAlMDh4XG4iLArCoOKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAgnBoeV9tb2RlLCByZWcpOwrCoOKAguKAguKAguKAguKA
gndyaXRlbChyZWcsIGdtaWlfc2VsKTsKwqAKLeKAguKAguKAguKAguKAgnJlZyA9IHJlYWRsKGdt
aWlfc2VsKTsKK+KAguKAguKAguKAguKAgnJlZyA9IEFNNlhfR01JSV9TRUxfTU9ERV9TRUxfTUFT
SyAmIHJlYWRsKGdtaWlfc2VsKTsKwqDigILigILigILigILigIJpZiAocmVnICE9IG1vZGUpIHsK
wqDigILigILigILigILigILigILigILigILigILigILigIJkZXZfZXJyKGRldiwKwqDigILigILi
gILigILigILigILigILigILigILigILigILigILigILigILigILigILigIIiZ21paV9zZWwgUEhZ
IG1vZGUgTk9UIFNFVCE6IHJlcXVlc3RlZDogJTA4eCwgZ21paV9zZWw6ICUwOHhcbiIsCi0twqAK
Mi4zNC4xCg==
