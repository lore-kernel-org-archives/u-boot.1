Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE04C43602
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 12:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15604846FD;
	Mon,  6 Jul 2026 14:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="BiSgN79Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65FEC8488D; Mon,  6 Jul 2026 14:36:43 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FA76846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 14:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=US8kx8k8wR/1tTA4uNR2VGPTHSS4RZr2NbVwv9OmOqWiDBvitjtCn3eOychIG+JOYqVFa2R8zQbeiuwWkSuYT0i45dP7BC2JGZ3ma8OpRgCK9fNwLNvUjD/txgH0y07mWu3zddg1752c4m+U2Azhfq6q5nnOqvq/9+TkKZLlUjil4Zs9kpX4MxzGM55ns9HQfW4YUWztlXt0mT5UVZD11rFYakouYQkeh8maa7kl15QOfxCppIUT9q2XGetmBr++wjFu+sKPidQmbLDEfLJ6n7bN6+jvClb6Ok1N2rBFRwUK32xQxVoBUDys2n8IzW7Oz/LM3s6v0XfdxIUr6laWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ypFU+kAwPORMblqIqv0pZOGsobOLVhmWNbJI0Kpw6Q=;
 b=JYHxGypXphTcIIFuULF4sqRNJcml1SqkpHH2XvgKQgwRbmQOFgZD/8lKp698pO0efbwk42a0jPL0eMIwJQlXrGR3YycEs3kAsZsxyEm5fppZImWbUUqVF7afhvrIKVO6/Gbm6+jCjxP5K8NXlEoqoEf8DJmFcN5oSBxTCb50WURJfUMlpcs/caWFxaZlDyhWcrszkrBmZQwi/3P2XSg45rgnNB35ZbCaYVWI2ekrf90FxFnnSrzEwd4s85USEPA6zFivKbqJ8joxd2UDIQP5RRv9gYEa3AvgeYPEY0JoDYnu2wlWp8xbRDEcpy+bVlNfAJgyq17rIAw0kudz6KziTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ypFU+kAwPORMblqIqv0pZOGsobOLVhmWNbJI0Kpw6Q=;
 b=BiSgN79ZWypTbOCBHfFjYbVA+q76Xo2271EGdAdpMQUzieqbNZ4IPKm5lyN7CQAiqY0zilNBeHcEI8gWYkFYI0SLjegIbv38SW3qWyqQ0PGD24PlYwXcFNkZq2L5IjyRGRI1sZZoGpBTU/vbUSTedhciNuEMCDMtkh6no6OUP77naYw8UzjDSn1fYR068NEWPyy10GwWtJUiPnGRxLgh4viXLAUK11abVENvF1x62UmDjU/dDooB1zbHJ0dtX7tST5n3Of1TACgLCwaGNXstr+nPLYXnx5aiaj5HTviKAhcyJoobzFWSDJ9FPr+y16w6WMMYh2TfjOQmurfSWPaVcA==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by PA1PPF0D0495D73.EURP195.PROD.OUTLOOK.COM (2603:10a6:108:1::1c6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 12:36:38 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:36:38 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Marek Vasut <marex@nabladev.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Fabio Estevam
 <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Simon Glass
 <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>, Tom Rini
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8m: Reinstate TEE ifdeffery
Thread-Topic: [PATCH] arm64: dts: imx8m: Reinstate TEE ifdeffery
Thread-Index: AQHdCKrnZwSzILPPFEWG4EepumfAgrZZ0MsAgAEBKACAAIObAIACfCYAgAKlIoA=
Date: Mon, 6 Jul 2026 12:36:38 +0000
Message-ID: <8b8468aedb4510d4956ffd548e6e6a8c69cbafe3.camel@phytec.de>
References: <20260630160951.122230-1-marex@nabladev.com>
 <0e9071095b0b590c45a139eacb210192e160823f.camel@phytec.de>
 <3200f8b6-6e5e-4275-8442-03ecb6a48597@nabladev.com>
 <5147fb9ef450d4a6963b57dbfdd6ee03eb2ae29a.camel@phytec.de>
 <95b68d7f-e0e6-46b2-af35-8da68c2a9b6a@nabladev.com>
In-Reply-To: <95b68d7f-e0e6-46b2-af35-8da68c2a9b6a@nabladev.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|PA1PPF0D0495D73:EE_
x-ms-office365-filtering-correlation-id: 08137359-2af0-491a-7b55-08dedb5b3941
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11063799006|4143699003|56012099006|22082099003|18002099003|6133799003|38070700021;
x-microsoft-antispam-message-info: BYoeMTCrC/qduAxta/U884GHGAjGOd2x63Tv1luMyOVnAyimYLyMjDs85wki40NoTOiU70+HjqL1bNHzXIlwFTEpV3+Yhs3nY89PdFDtFAS/AdXcyrLZLgScuNgJukwqKLk/5Xi1NzA4C3yYaYN6QxUTwcJkalXnj1gMvXOGPjfkrFo7gQD+vPXB1U9ZwFRzdkbWSVDhBhq0rodBXLKVdZOktvFjLBkiGE3pBHzyXa8ngEFZ5FgxskKzjgTaCVsZeYtaQ+8+PV/CexYXojaTH1zcvEzMvTPV4vY+3VKK2gnMRsi6ZoCLELk7rhjT53sbLz9stgTHAkBNQpSJMYXJJ3lN2AZ+wXn+EVzIO/pehSyrMzmOmwKMmEL1pQYeU6WSc0JuEsNhPSJUhLmWjFOl0+x7nKLyVo8/C2PAgWHgmuh130uewxW6gYrJAEa8+sc6aZa2XHKD2OgA4ubceWlB2BT1Qv70S2yxWsANbeaoL0d7cIMULelRHiST7gY8nQxDddZsQCA9AbBdm1zie9K+GA449kM0QtaxN7BTXt8dO5lsGYcS6fvqYr3lRO5b51aYRlVKxkeBdG4GfHmYsvDn8CpvFGk7PUO/mMjMfFgDlSOv6NvR2R/ODLMsY266aZKHWxbE1+D0WKfK6+Pw1juHsCDZUb+LtPyMCFJWpCEy66t8Bz/0j7H/uqeGc2p2qmsvzJD1rhevpgPDBO4ygp/Qi4JYU/rdV6Hy2GvUpwYgyKA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(6133799003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUU2REV6MW5YdWtndWVyVW1Vc0R4WDVyY1oxRTIrd2JURWtCVm53MGd6Ymh2?=
 =?utf-8?B?U3pCbFdiMW1rS0ZKSE54V2NFR0tJc2RSVFd4Z3FjdFZKYkVPN0NoUVp5NXBF?=
 =?utf-8?B?a3paTE9objVFVkI5bi9mZjdHRlNnRmpoMVJxaVpHY1JBM3lyZHFvbmN0M3hY?=
 =?utf-8?B?NUdlTDh0VHY2cnFBc2xzUi9qaFZDTVFIR0NtRWNYM2ZzMDlCaE04cXBsaUtK?=
 =?utf-8?B?NnZxbzlSUW85eXEra0Vra0Q3RGIxL25NVFZLRWJReThWYVdsQkk0c2NZVVRj?=
 =?utf-8?B?SXF4cHFZMjcya3hvT0VlZmlYSzVodzVpRzY3RG1JTURiTm5qRWtIa2tPdTdX?=
 =?utf-8?B?aWN3UEpRd242MEdVVzN0NlJwa2FVRWhmclpRclUxMFJucTIvTDJ6UEROY3VR?=
 =?utf-8?B?V2s4V2pxeTQzZXRLRnBJNTFYRjY0bWwvZGhiRFRBNThBYUY1Q2kwMFk2b3R4?=
 =?utf-8?B?SWtHUkttK0hBbEdRcVF4bXFFcGphS3puT1ptQm92UXQrUHVRZENIYnduQThy?=
 =?utf-8?B?OU95S1ZidXhhckZiSG1GekVnaTZXL2RKcWdmeFlETjMxWCtmYklBVU9vaE5F?=
 =?utf-8?B?eFJrd0FDSEw1ZVNvZW81ZEVEN2puOUhOSG5HdnoySlhORXlPb012c2ZhcTlW?=
 =?utf-8?B?SFpHRk52dnl3aVhOZjcwajZuSTFFZ1dId2xlS0ZlNUVJZEZXM0ppWFo3eUY4?=
 =?utf-8?B?UWRGTUdBcy9leXRnckpVdmRSTWtyNkVQMGZKUkUxUFJtblQvRkhxejZOYXA1?=
 =?utf-8?B?cFVjWDNMaUluSlM2NG9xSU1nR1BZMW1sWlRmT1RxUXpxTWx3L3JoZUZScjRh?=
 =?utf-8?B?YmZINW43V09xTXpRR0tQTmFHcW5jUFI0bEkwdVdJUXQra3R2Sm5wZFJFVllO?=
 =?utf-8?B?WVdYTXllVk5JT0Z5SXNIOGtPd0tiL2F3T2dyRFlTMlEvbFB2Q1dOaDhnaHVs?=
 =?utf-8?B?Z3VlYU9wRzZndSswOVF5UG1rUDhGREREV0hNR1JrVlZUZ21HNDI3NkNRbjdT?=
 =?utf-8?B?WjcvVXR1TGtibmdFT1JSL1A4b05VMW9nMmpMSk1KWTM0VmVGeCtJbzk0cW1O?=
 =?utf-8?B?R2htTVFacEQ5amRWcDFKaExIb0tVakthLzdvMSsvcElHK1ozTzM5RFZlcU1I?=
 =?utf-8?B?NTJ3WmVQRHR4N3h1K0RPamRqdVJkV0RiYzNEZ1hrMGJrM3BkdERGZkxWaTdX?=
 =?utf-8?B?bkVhcEpkMkRhbHRnSXVSTExGWVROK1BrNCt3aklJeERXb0k3OWR0THd3eGR6?=
 =?utf-8?B?Wjk0ckJwcUhSNVRhbjJUVFVFczdBcjYvYUt4Mlk1OWFUZ3k5aE1XeWdPc0xN?=
 =?utf-8?B?RlNhQ3dUdm4vY2hvVnBRTjZrVFJTOUo0RzdKakxKTVB0TUp3NmVBRmdUQXI3?=
 =?utf-8?B?clRFaCtZUitISWdCb0lLKys2QmtqdzNhRHRaUVpzNEtLbzNmTWk0U2FDMytz?=
 =?utf-8?B?SCszMys1bHpkQ2ZDaGNhNnY1aXFRcWRoZGsrdG5EOHNPQk9aeUhTZ1RsV04w?=
 =?utf-8?B?NTFvQURLenI5S1R0cUVkYW9nNWJTWXFpcFo3WGcvdEtHWCtSNnpzdVhEZTYw?=
 =?utf-8?B?WCtBT0VSUXhKeFJSVGNhNnYrbTE5VjZJS3E5WjRqb0dCVkRRNG9RK3FuWDJz?=
 =?utf-8?B?U1FsdUtlZzcxc1p1MUZ1ZW1BczYwQVgwZ0l2SEM5VURWcUEvQ1BONHNYQ0tQ?=
 =?utf-8?B?Q1hienJmT3RqcGlSUCtZMkVnMFhrRWdiY3hCNnlFRjE2cC9xODRqWmxZRFJu?=
 =?utf-8?B?VGR0UTNlUEErUERRc0w0T2VJL3dZR2hyellCWE5ReFBwVStSb1U4YlFuT0d6?=
 =?utf-8?B?QzlTeXIxaitESDJBcFNtWjlsVmFzMHBFMEdYWFJZNVppREt2TGVrTTFEMFcv?=
 =?utf-8?B?ZDJUOGk1VVVxN0hFYVkwZHJCN3d3NmJXczd5b1A3SEo4aTNCQnlvM2I0SkpH?=
 =?utf-8?B?WDRxZDJzK3hlaDNSS205dC9VSkVtclNqa001NlJRbjRsTnM3RzUrclQ0MHdv?=
 =?utf-8?B?RE1lMGJpdlV1RElkajlsK3BZbWVJNzA0azFycDRwSzVWSHRRVTlVNENjK3hp?=
 =?utf-8?B?aFd5cWR4eXo5M3ZyWmFjamQ0OWk1RkZaa2lpNlVZOVhPdFVudmxKNGkvb3BY?=
 =?utf-8?B?NWc5a1FLOWFzdnlBVWhnVEc2YUxSUkg0WlNnRHJHdDEvQW9ETGE0cGRVUXdW?=
 =?utf-8?B?V2daK204UE9ZMm5BdnFxZVEwZS9sSDdOU0paRnV4ZUgvd3NwWjNYRmpYalp4?=
 =?utf-8?B?Q09FYjVLVHZkSTBhRVoxZEZNNzU2YWc3VGRxWHl5SWprZmlQem8wRzRrbGpF?=
 =?utf-8?Q?fyn2eOJI3o2tryNGvr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <832CE75F9B792E448FF30F7A3A6DB89F@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 08137359-2af0-491a-7b55-08dedb5b3941
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 12:36:38.1848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nAriCdcBIlhQG1p83tALFILBUa5Wb6l6rbtSEqsc7JARZboUVduSVnvDtoxgsdONbf4odhegB3wc464loeMQYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PPF0D0495D73
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

SGV5IE1hcmVrLAoKT24gU2F0LCAyMDI2LTA3LTA0IGF0IDIyOjEzICswMjAwLCBNYXJlayBWYXN1
dCB3cm90ZToKPiBPbiA3LzMvMjYgODoxNiBBTSwgWWFubmljIE1vb2cgd3JvdGU6Cj4gCj4gSGVs
bG8gWWFubmljLAo+IAo+IFsuLi5dCj4gCj4gPiA+ID4gaXMgbm90IGFjY3VyYXRlLiBZb3Ugd2Vy
ZSBhYmxlIHRvIHBhY2thZ2UgT1AtVEVFIHdpdGhvdXQgbmVlZGluZyB0byBlbmFibGUgc3VwcG9y
dCBpbiBVLQo+ID4gPiA+IEJvb3QuCj4gPiA+ID4gQW5kCj4gPiA+ID4gYWZhaWsgdGhpcyBpcyBh
IHBlcmZlY3RseSB2YWxpZCB1c2UtY2FzZS4KPiA+ID4gCj4gPiA+IFdoZW4geW91IGluY2x1ZGUg
b3B0ZWUtb3MgaW4gdGhlIFUtQm9vdCBmaXRJbWFnZSwgd2hhdCBkbyB5b3UgZG8gd2l0aAo+ID4g
PiB0aGF0IG9wdGVlLW9zIHdoaWNoIFUtQm9vdCBkb2VzIG5vdCBzdXBwb3J0ID8gRGV0YWlscyBw
bGVhc2UgPwo+ID4gCj4gPiBTdXJlLCBzb3JyeS4gT1MgY2FuL3dpbGwgdXNlIGl0LiBUaGVyZSBp
cyBubyByZXF1aXJlbWVudCwgdGhhdCBJIGtub3csIG9mIGFueSBib290bG9hZGVyCj4gPiBpbnRl
cmZhY2luZyB3aXRoIE9QLVRFRSBmb3IgcHJvcGVyIGZ1bmN0aW9uYWxpdHkgYW5kIGl0cyBwdXJw
b3NlIGlzIHRvIHdvcmsgd2l0aCBMaW51eCBrZXJuZWwuCj4gCj4gQXQgbWluaW11bSwgaWYgQ09O
RklHX09QVEVFIGlzIG5vdCBlbmFibGVkLCBVLUJvb3Qgd29uJ3QgZXhlY3V0ZSAKPiBvcHRlZV9j
b3B5X2ZkdF9ub2RlcygpIGFuZCB3b24ndCB0cmFuc2ZlciBhbnkgb3B0ZWUtb3MgZmlybXdhcmUg
YW5kIAo+IHJlc2VydmVkLW1lbW9yeSBEVCBub2RlcyB0byB0aGUgTGludXggRFQgd2hlbiBzdGFy
dGluZyB0aGUga2VybmVsLCBzbyAKPiBMaW51eCBEVCB3aWxsIGJlIGJ1Z2d5IGFuZCBMaW51eCBt
YXkgcG9zc2libHkgbWlzYmVoYXZlLgoKR290IGl0LiBJIHRlc3RlZCB5b3VyIHRoZW9yeSBhbmQg
d2l0aCBhbGwgVEVFIGNvbmZpZ3Mgb2ZmIGFuZCBPUC1URUUgcGFja2FnZWQsIGtlcm5lbCBkZXZp
Y2UgdHJlZQpzdGlsbCBoYXMgdGhlIG5lY2Vzc2FyeSBkZXZpY2UgdHJlZSBub2Rlcy4gSXMgdGhl
cmUgc29tZXRoaW5nIEkgbWlzc2VkIChhbSB1c2luZyBwaHljb3JlLWlteDhtcApib2FyZCkgPyBI
b3cgZG9lcyB5b3VyIExpbnV4IGR0YiBsb29rIGxpa2UgaW4gdGhhdCBzY2VuYXJpbz8KCj4gCj4g
PiBJIGd1ZXNzIHRoZSBvbmx5IGpvYiBib290bG9hZGVyIG5lZWRzIHRvIGRvIGlzIGxvYWQgaXQg
aW50byBtZW1vcnkuIEkgZG9uJ3Qga25vdyBkZXRhaWxzIGFib3V0Cj4gPiBzcGVjaWZpYyB1c2Vz
IHdpdGhpbiB0aGUgc2VjdXJpdHkgY29udGV4dCBhbmQgaWYgdGhlcmUgYXJlIGFueSB0aGF0IHJl
cXVpcmUgYm9vdGxvYWRlciBzdXBwb3J0Lgo+IAo+IElmIGluIHlvdXIgdXNlIGNhc2UsIFUtQm9v
dCBpcyBzdXBwb3NlZCB0byBvbmx5IGxvYWQgb3B0ZWUtb3MgaW50byAKPiBtZW1vcnkgLCB3aHkg
bm90IGxvYWQgaXQgZnJvbSBVLUJvb3QgY29tbWFuZCBsaW5lIG9yIGFzIHBhcnQgb2YgZml0SW1h
Z2UgCj4gd2hlbiBib290aW5nIExpbnV4IGtlcm5lbCA/CgpJIGZpZ3VyZWQgdmlhIHRoZSB1LWJv
b3QuZHRzaSBpcyB0aGUgZWFzaWVzdCBzb2x1dGlvbi4KCj4gCj4gSXQgc2VlbXMgaW4geW91ciB1
c2UgY2FzZSwgb3B0ZWUtb3MgZG9lcyBub3QgaGF2ZSB0byBiZSBwYXJ0IG9mIHRoZSAKPiBib290
bG9hZGVyIGltYWdlIGF0IGFsbCA/CgpJIGJlbGlldmUgaXQgZG9lcy4gVGhlIGluaXQgcGhhc2Ug
bG9va3MgdGhlIGZvbGxvd2luZyAob24gaW14OG0pCgpST00gLT4gVS1Cb290IFNQTCAtPiB0Zi1h
IC0+IE9QLVRFRSAtPiB0Zi1hIC0+IFUtYm9vdCBwcm9wZXIKCmFuZCBzb21ldGhpbmcgaGFzIHRv
IGxvYWQgT1AtVEVFIGludG8gbWFpbiBtZW1vcnkgd2hlbiB0Zi1hIGlzIGRvbmUgd2l0aCBpbml0
IGFuZCBqdW1wcyB0byB0aGUKT1BURUUgbG9hZCBhZGRyLiBUaGF0J3Mgd2hhdCBVLUJvb3QgZG9l
cy4KCj4gCj4gPiA+ID4gV2l0aCB0aGlzIGNoYW5nZSB5b3UgY2FuIG5vIGxvbmdlciBkbyB0aGF0
LCBzbyB0aGlzIGNoYW5nZSBpcyBhIHJlZ3Jlc3Npb24uCj4gPiA+ID4gCj4gPiA+ID4gQWJvdXQg
dGhlIHdhcm5pbmcgbWVzc2FnZS4gSSB1bmRlcnN0YW5kIHRoYXQgeW91IGZpbmQgaXQgY29uZnVz
aW5nOyBiaW5tYW4gaXMgZGVzaWduZWQgc28KPiA+ID4gPiB0aGF0Cj4gPiA+ID4gaXQKPiA+ID4g
PiBlbWl0cyBhIHdhcm5pbmcgd2hlbiBhbiBvcHRpb25hbCBibG9iIGlzIG5vdCBmb3VuZC4KPiA+
ID4gCj4gPiA+IFBsZWFzZSBzZWUgYWJvdmUuCj4gPiA+IAo+ID4gPiA+IEkgcHJlZmVyIHRoYXQg
YXBwcm9hY2ggdG8gbm8gbWVzc2FnZSBhdCBhbGwuIFlvdSBtYXkgd2FudCB0byBwYWNrYWdlIE9Q
LVRFRSAoZS5nLiB5b3UgaGF2ZQo+ID4gPiA+IGFuCj4gPiA+ID4gdGYtYQo+ID4gPiA+IGJsb2Ig
d2hpY2gganVtcHMgdG8gT1AtVEVFIGFkZHIpIGFuZCBiZWluZyBhbGVydGVkIHRvIGEgcG9zc2li
bGUgbWlzdGFrZSBpcyBpbXBvcnRhbnQ7Cj4gPiA+ID4gTGV0J3MKPiA+ID4gPiBzYXkKPiA+ID4g
PiB0ZWUgcGF0aCB3YXMgaW5jb3JyZWN0IGR1cmluZyBidWlsZC4KPiA+ID4gCj4gPiA+IElzIHRo
aXMgc29tZSBzb3J0IG9mIGEgYm9hcmQtc3BlY2lmaWMgY29uZmlndXJhdGlvbiA/Cj4gPiAKPiA+
IGtpbmQgb2YuIFdlIGhhdmUgdGVlIHBhdGggc2V0IGluIDxzb2M+LXUtYm9vdC5kdHNpOiBmaWxl
bmFtZSA9ICJ0ZWUuYmluIjsKPiA+IAo+ID4gQ291bGQgaGFwcGVuIHRoYXQgVEVFPXRlZWUuYmlu
IGlzIHNldCBvciBmaWxlIGlzIG5hbWVkIHRlZS1yYXcuYmluIGFuZCB0aGVuIGl0IGhlbHBzIHRv
IGdldCBhCj4gPiB3YXJuaW5nIHRoYXQgYmlubWFuIHdhcyBub3QgYWJsZSB0byBwYWNrYWdlIHRo
ZSBibG9iLgo+ID4gCj4gPiA+IAo+ID4gPiBXaHkgZG9lcyBVLUJvb3Qgbm90IGVuYWJsZSBPUFRF
RS1PUyBzdXBwb3J0IGluIHRoaXMgY2FzZSA/Cj4gPiAKPiA+IE5vIG5lZWQgdG8uIE1heWJlIHRv
IGNvbnNlcnZlIHNwYWNlLCBvciBieSBwcmluY2lwbGUgb25seSBlbmFibGUgdGhlIGNvbmZpZ3Mg
dGhhdCBhcmUgYWN0dWFsbHkKPiA+IG5lZWRlZD8gSSBiZWxpZXZlIFBIWVRFQyBib2FyZHMgdXNl
ZCB0byBkbyB0aGF0IGJlZm9yZSBLQVNMUiBzdXBwb3J0Lgo+IAo+IFRoaXMgZG9lcyBub3Qgc2Vl
bSBjb3JyZWN0LCBwbGVhc2Ugc2VlIGFib3ZlLgo+IAo+IEF0IHRoaXMgcG9pbnQsIEkgd291bGQg
c3VnZ2VzdCB0aGF0IGlmIHlvdSB3YW50IHRvIHJldGFpbiB0aGlzIGtpbmQgb2YgCj4gY29uZmln
dXJhdGlvbiBmb3IgeW91ciBoYXJkd2FyZSwgaXQgc2hvdWxkIGJlIG1vdmVkIGludG8gYm9hcmQg
c3BlY2lmaWMgCj4gRFQsIGl0IHNob3VsZCBub3QgYmUgcGFydCBvZiB0aGUgY29tbW9uIERUcy4K
PiAKPiA+ID4gPiBBbHNvLCBrZWVwaW5nIG9wdGlvbmFsIHdoZW4gdXNpbmcgaWYgZGVmcyBpcyBu
b3QgYSBnb29kIGlkZWEuIEJpbm1hbiB3aWxsIHN0aWxsIGJ1aWxkIHlvdQo+ID4gPiA+IGFuCj4g
PiA+ID4gaW1hZ2UKPiA+ID4gPiB3aGVuIG5vIE9QLVRFRSBibG9iIGlzIHByZXNlbnQsIGJ1dCBz
aG91bGQgbm90IHNpbmNlIHlvdSBlbmFibGVkIE9QVEVFIGNvbmZpZ3MuIElmIHlvdQo+ID4gPiA+
IGVuYWJsZQo+ID4gPiA+IE9QVEVFLCB5b3Ugc2hvdWxkIGhhdmUgYW4gT1AtVEVFIGJsb2IgcGFj
a2FnZWQuCj4gPiA+ID4gV2UgY291bGQgYWRkIGlmbmRlZiBPUFRFRSBhcm91bmQgdGhlIG9wdGlv
bmFsIHByb3BlcnR5Lgo+ID4gPiAKPiA+ID4gVGhlIG9wdGlvbmFsIGtleXdvcmQgaXMgYWN0dWFs
bHkga2VwdCBpbiB0aGlzIGNhc2UsIGl0IGlzIG5vdCBhIGZ1bGwgcmV2ZXJ0Lgo+ID4gPiAKPiA+
ID4gWW91IGRpZCBob3dldmVyIG1pc3Mgb25lIHZpdGFsIHBvaW50IC0tIHRoZSB0ZWUgbm9kZSBp
cyBwYXJ0IG9mIHRoZQo+ID4gPiBVLWJvb3QgZml0SW1hZ2UsIGV2ZW4gaWYgdGhlIHRlZS5iaW4g
YmluYXJ5IGlzIG5vdCBwcmVzZW50IGFuZCBPUFRFRQo+ID4gPiBzdXBwb3J0IGluIFUtQm9vdCBp
cyBkaXNhYmxlZC4gQmlubWFuIHByaW50cyBhIGNvbmZ1c2luZyBtZXNzYWdlLCBhbmQKPiA+ID4g
Z2VuZXJhdGVzIGEgYm9ndXMgZW1wdHkgdGVlIHt9IG5vZGUgaW4gdGhlIGZpdEltYWdlLiBUaGF0
IGlzIGluY29ycmVjdC4KPiA+IAo+ID4gWWVzLCBmb3Jnb3QgdG8gYWRkcmVzcyB0aGF0LiBJIGRv
bid0IHRoaW5rIGl0IGlzIGNvbmZ1c2luZywgYXQgbGVhc3QgY29udGVudCB3aXNlLiBWaXN1YWxs
eSwgSQo+ID4gY2FuCj4gPiBzZWUgaG93IHRoYXQgaXMgY29uZnVzaW5nLiBJIHdhbnQgdG8gbmVp
dGhlciBhZ3JlZSBub3IgZGlzYWdyZWUgb24gdGhlIGNvcnJlY3RuZXNzIHBhcnQgYmVjYXVzZQo+
ID4gSQo+ID4gZG9uJ3QgcmVhbGx5IGtub3cgdGhlIGZpdEltYWdlIHNwZWMuIEhhdmluZyB0aGUg
dGVlIG5vZGUgYmUgcGFydCBvZiB0aGUgZml0SW1hZ2UgaXMgYSBkZXNpZ24KPiA+IGNob2ljZSwg
YWxsIG9wdGlvbmFsIGJsb2JzIGJlaGF2ZSB0aGF0IHdheSBmcm9tIG15IHVuZGVyc3RhbmRpbmcu
Cj4gCj4gSXQgaXMgYSBicm9rZW4gbm9kZSBpbnRyb2R1Y2VkIGJ5IGNvbW1pdCBiNTdlZDE0Nzkz
OWMgKCJkdHM6IAo+IGlteDhte20sbixwLHF9OiBNYWtlIG9wdGVlIHBhY2thZ2luZyBvcHRpb25h
bCIpICwgaXQgaXMgbm90IHN1cHBvc2VkIHRvIAo+IGJlIHBhcnQgb2YgdGhlIGZpdEltYWdlIHVu
bGVzcyBvcHRlZS1vcyBpcyBidW5kbGVkIGludG8gdGhlIGZpdEltYWdlLgoKVGhpcyBJIHN0aWxs
IGRvIG5vdCB1bmRlcnN0YW5kIGhvdyB5b3UgY29tZSB0byB0aGUgY29uY2x1c2lvbiB0aGF0IGl0
ICh0ZWUgbm9kZSkgaXMgbm90IHN1cHBvc2VkIHRvCmJlIHBhcnQgb2YgdGhlIGZpdEltYWdlLiBD
YW4geW91IHBvaW50IG1lIHRvIHRoZSBkb2MgdGhhdCBkaXNhbGxvd3MgdGhpcz8KCgo+IAo+ID4g
SSBndWVzcyBpdCBtZWFucyB0aGF0IHRoZXJlIGlzIGEgYnVnIGluIGJpbm1hbiBpZiB5b3Ugc2F5
IGhhdmluZyBlbXB0eSB0ZWUgbm9kZSBpcyBpbmNvcnJlY3QuCj4gPiBBbmQgc28gaXQgc2hvdWxk
IGJlIGZpeGVkIGluIGJpbm1hbiBpdHNlbGYgaW1vLCBub3QgaGVyZSBmb3IgaW14OC4KPiBObywg
dGhpcyBpcyBub3QgYSBidWcgaW4gYmlubWFuLCBwbGVhc2Ugc2VlIGFib3ZlLgoKQWxzbywgYXNz
dW1pbmcgdGhhdCBpdCBpcyBpbmRlZWQgaWxsZWdhbDogQmlubWFuIGxvb2tzIGF0IGFuIGV4dGVy
bmFsIGJsb2IgYW5kIGRvZXMgbm90IHJlbW92ZSB0aGUKcGFyZW50IG5vZGUgd2hlbiBpdCBpcyB0
aGUgb25seSBjaGlsZCBhbmQgZm91bmQgdG8gYmUgbWlzc2luZy4KQ2FuIHlvdSBwbGVhc2UgY2xh
cmlmeSB3aGF0IHNob3VsZCBoYXBwZW4gd2hlbiBubyB0ZWUgYmxvYiBjb3VsZCBiZSBmb3VuZCBh
bmQgcGFja2FnZWQ/CkkgYW0gYXNraW5nIGJlY2F1c2UgeW91IHdhbnRlZCB0byBrZWVwIHRoZSBv
cHRpb25hbCBwcm9wZXJ0eSB3aGljaCB3aWxsIGNhdXNlIHVzIHRvIGVuZCB1cCBpbiB0aGUKc2Ft
ZSBzaXR1YXRpb24geW91IHNhaWQgaXMgaWxsZWdhbDogSGF2aW5nIHRoZSB0ZWUgbm9kZSBpbiB0
aGUgZml0SW1hZ2UgYnV0IG5vIHRlZSBibG9iLgoKWWFubmljCg==
