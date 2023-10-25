Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCA6C25B48
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 02:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E2A387A0D;
	Wed, 25 Oct 2023 04:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=omron.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=omron.com header.i=@omron.com header.b="X+heVyCv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D1A879A6; Wed, 25 Oct 2023 04:26:40 +0200 (CEST)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01on20730.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700c::730])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A514387983
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 04:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=omron.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niek.nooijens@omron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjQqOMYo8bQhi4rM6BRwiEP+65+ztINZDg6yqjSSj3ao0LVoH8jiv6qS3I7kjt/MpLua/QsHx2Y/Pi+zcwxW3JmGNMrghuE/qB4MFPixeE7PJuficghtVT6TANUmC69owuu2CBZ6J5i7KZIsISOMm/w/4e8M0mly1ZPxXnhY6P6Swi6hlyFvtx/wfTx1NIhZPh3s6N+blL4eO6vrx+3d6VIunuQF99ACNdnVpXo9UR9RFaULs7EWQWqmV9CJHLaLCMaaeeecz9T1UoDHoIeBlvMJowZ977OpgK3JIx0YQjdmKtP+kEhh5GR/V+i65uAZsf5LMPSENxs1/vhmRtarIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOoP8XLzOcr7q8+msJQ9B3UrAx9jpMYfk8mp/JXSe0w=;
 b=UrpZzM91xG33DVj+h3DpQk6qPRyE+eCKtDx9ZVyWvMTn5skIsiy9bhubpxiscVmlcNht7FCSOqBQr2fjZgt9I1owovgmHQ9BCAeJFRUY9gWGK+GYmQTdSe0Mbz9jHBqFX4X13VBj4JB7+3gAFgrlDbtuqQFDtQ0ok5mak/RsrHf4cVYsETHW4rrtJgHuYK2iHPdNx2X7cHOoDvO70+Q9SrT1Yh1RGkf0D6YxMNrZvdMaZlTSWNTZQdZGKp9ZJYu9/d01nqhdUCgi0RqGvqWpT+ulQhhYGoD2wM8EDzhbeUWtvh5XsWvEII3bpEQBY8hZjHGrR/ToMZHySAXGaEpRLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=omron.com; dmarc=pass action=none header.from=omron.com;
 dkim=pass header.d=omron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omron.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOoP8XLzOcr7q8+msJQ9B3UrAx9jpMYfk8mp/JXSe0w=;
 b=X+heVyCv5oCnOS7Jw9HWdrEeEONmP37/T6PdsdUh132rxpKmlav5LaKwbluKsbQ/36OLBzT8jP5o2ZHeOG2H/QlTjfys0VI9e8aJMI1aeq7cm1yTCuQapb2YpL9Z4xUKpfwyb3/noeT5BMqdlaYLX3gS+FuAe+rYOI1j1uXIMpE=
Received: from OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:17a::14)
 by TYYP286MB1905.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 02:26:33 +0000
Received: from OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c1fb:c9f3:b13e:1790]) by OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c1fb:c9f3:b13e:1790%7]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 02:26:33 +0000
From: "niek.nooijens@omron.com" <niek.nooijens@omron.com>
To: Simon Glass <sjg@google.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: quick question about TPM
Thread-Topic: quick question about TPM
Thread-Index: AQHaBjKW0la4Dg61rkK1nPrJuPcPf7BZPF6AgACKwQA=
Date: Wed, 25 Oct 2023 02:26:33 +0000
Message-ID: <OS3P286MB1495889DF57AD742064FDB56F6DEA@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
References: <OS3P286MB14955A84C3B71A32C4BBA352F6DFA@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
 <CAPnjgZ1A8vyEUx2wiXqOCb8Kf9zP96wqy4kXanfKRR-uN6yOmg@mail.gmail.com>
In-Reply-To: <CAPnjgZ1A8vyEUx2wiXqOCb8Kf9zP96wqy4kXanfKRR-uN6yOmg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=omron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3P286MB1495:EE_|TYYP286MB1905:EE_
x-ms-office365-filtering-correlation-id: 090973d9-80f7-4e3b-b79c-08dbd501ce1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wr8P4eAJaakXtd9blWUYKAPgUq++GD5M/7I+lQzNMfhCYYICeJ/IbSvgEotsjD/abL543+a0MzAx3t2y8goRToKh+2bsbFsr89AP2CyTzsChuK8uVIUQFEUoIzM7+ZfsMm5fE1efKlgoHteb16MOBH/YDfsaZgZFookFs563QpouLRplCej2hXyuF4miO5soJsWb7Ze38DUQAvhVTo03+7K/XvWf9Bi+gyD3J2a/pPP838UKBCFqBe1tkkOhg+dJChUHalwRiOH+nk3M0rsmbHa2J2edeqPG2Lz6WRDKRgW7GeWZ+gXnBWFaXqvoApYGyWKXlfrMahZUqHTZvgEblza8XCK8ytXMJUeqo0UhHXp1M8uLdoHBJqmxoJtxiBHqQADw9uKX1m2DlPRfFbAd7aegwXc01kxpK2SYGbtIGkyUjqJ4NUCwYVlwEoclcp1rPKctE6N9BzFWOMTclOMzOKcOglmdaQJiagzSF8XygtitzPIXjn2sRQsqb1e0xrnn3MKBZV6dKeICBCtkDCnLhWVd35IxdNbcXmFZ3B6xfXNzNKoee+bmccVO8KCitJNJM7bkJYiCrpHYP1wAG5NAbXl6CX2BIkA2DIhEvaMz8zdlzzrAVMmAepIs2dzxPdSu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(64756008)(66946007)(66556008)(66476007)(66446008)(6916009)(316002)(38100700002)(478600001)(19627405001)(122000001)(76116006)(52536014)(41300700001)(86362001)(8936002)(8676002)(71200400001)(4326008)(9686003)(6506007)(7696005)(33656002)(5660300002)(38070700009)(2906002)(55016003)(83380400001)(3480700007)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VmFqU294NTlhWGJCUjRRTHRXTE5xSTFiZU5HbklSNS9ZKzNzbFl0WXZxdHJu?=
 =?gb2312?B?SlVOZjQ4bHI5NDJ4WVdhK25rdXpsYmtoQkhhNlI1NHhxazMzVVpTcnN2R0U5?=
 =?gb2312?B?bU1pOEZQSnNNMnhiMm1SZFZKaGFTbDNQSyt1dHE1QnNOVXZGaDBnenRVWEFJ?=
 =?gb2312?B?T0dFMTc5WExjdlNkSkxqRU1vMTBVTTFMaDV5S0xkZ2VTeFlwbENUbTdPeDZE?=
 =?gb2312?B?d1FRZXdHOGZZV2Z1S20yRmtWQk9GWFlYSkFOYTZQeUp1L0lmbkVFYVRyRW5Z?=
 =?gb2312?B?eWMwbUZnQWpQWTRhMkN1aHNOeXlEWUNPUWYybXJ5bFZRUlNoUDRLY3lOKzc2?=
 =?gb2312?B?eWR6UjVMVm1NMEc5TzdEbkJGOGtBYXZ6Y0N3RSt6S0JOSEpnblNPU0ZXLyt4?=
 =?gb2312?B?L2F0TkNNb2xDdmxOOWFxaEYwbVlWSlR6a0U1RGswRjkyY1FrbFJXKzJEa0tD?=
 =?gb2312?B?b2c2K3RnYUROUVlKeSs0dHdxd255aS9vc1VQMHAxTXgySjFEc3ZqdmJPMU5K?=
 =?gb2312?B?YkY0ZFp6THJkZlBhU0ZsOFJ5OXZsQzh1cTZ3NkR3T1ZmUXduL0crOC9rTURV?=
 =?gb2312?B?SGE0N21La3ZjY2NYNkluWDNXSmdETzF0d3hSV2FNbXRZMUNNWjFIZEJ0UUlv?=
 =?gb2312?B?Ukt5RGdMTjlhYUI2ZEMxU1R4S1ZneUlqVGVUYWRnaEFhNWVoRE54cG9lSnk1?=
 =?gb2312?B?Zmd2UEtrMWxiNEZLc0hjSDFyeDJ6MlFnZUd2QnZNZ2lWUEx3RGw4OGhhSHJU?=
 =?gb2312?B?YmRoZnN2UTJaL1pqcHVySDQ3bDYzai9pZ25scUJOc2kwQUFSRjFtaVo4VXhj?=
 =?gb2312?B?RzEzY0FtSm9oYzNwSjlWdEdiVm9NWnBLUkJnM3JZb2l4dlhVMVhSWG0wS1Fa?=
 =?gb2312?B?QUMyMUt5cmx4QlNlT1pTVDdSNmtZWVVJSWR5THJabzRYYnB5clBpTWpENG1s?=
 =?gb2312?B?NWpTS1ltSmIvQWpuSmVxV3NLN1g4YTFmbDMyOFRMT21GMS9sazF5REJTQU44?=
 =?gb2312?B?ajBlMzZrcVhiNGlCcmpwRVJQWXcrMGh1VHVmVEphZkRKV29YUHhYYktrTy82?=
 =?gb2312?B?N1R2Rk9CaklpbDhDVG9hWmpVaXFYNVppUXhCY3lMOTJvdGNId3IvNXFOemFS?=
 =?gb2312?B?WFQ4MlVMRnJWWmc2amlWOGYvREZGZnQzakV4QURkOHpKUkphMVZaWm56K3lE?=
 =?gb2312?B?Q0FHQkhnb2VBRi9NTVJ3cDk1MTVkV1h0L0c1YktYSUw4dGtmbmloOUR5TWRq?=
 =?gb2312?B?Rndhb1U1ZnNkQzUvWjRrSDFuQzczZzZHZnFvelhpamR4N0NESWo3K1Q2MXVo?=
 =?gb2312?B?SnloVUV2NUVSOEcwajVORld5YzNFVGlDTmcveUhycm91NWlqTisybHR5L0Jy?=
 =?gb2312?B?ZHFRcHlVTEloV084eVVTRjI2MVI0ZXlkUHhOVjRRSHVOb25tMHpRVGJaR2pB?=
 =?gb2312?B?eHk2bEFHY2xFbkZHcG1ucTNVMEkxUVN0YTJBUXRLdm95MHV0Y01qUUtmejFv?=
 =?gb2312?B?ZjB5SU9YYnl3K2JSYlVpaS9jK2FHOEtNYlA4YTIvUmpqaXJCTWd5QTErdWJT?=
 =?gb2312?B?UGxBdEZweStzdVp4QkVUMXRlNHRmWjk4VDFMUUJwY1IycFI4M0FXMDFacnRW?=
 =?gb2312?B?NVFGSnRSdjBCejhGUmNnOUxnK1JFU09IZnFJMDVtTXo0cXBwZjgrUXZwLzRI?=
 =?gb2312?B?eWtmdDFyb214NGY1QVdYamxPRGltWVZleEpxSXNPaUFWR3YwZzBuZXZRZ1hH?=
 =?gb2312?B?WjV2UC9YL2ZxajUybmxtdmd6TmhkYnJhTnJOYm5LbkYzR3phRjNlWERGUW9j?=
 =?gb2312?B?TCs0Vmtnd3lFTlJIU3JmN2dIQ0NUV0pWWXpLdTI5V29QTXpDcDU4NU4wSHNF?=
 =?gb2312?B?b09XSE1wSW9odCsra0JtRzcvek5WUWlJUnIrQXI5bWVtOEVJNXNjdldDTVVI?=
 =?gb2312?B?dnBRcjE3WWNvbFRPd0c0WmllMzNqRjFOaWFBVkxJRUIyM21Jb2JkY3ozYjFB?=
 =?gb2312?B?K3ZkODhSTE9yc1dKRERKUVVzOUpTVlhobWYwN3Q4cC9ZcEJWRHc2ckhpRDlw?=
 =?gb2312?B?UkpLVUlDSVlUd0NGTTRCRkhCdWJLVzZ0eloyQ0JtV3lVQnVQUmNUWFpRRyty?=
 =?gb2312?Q?q3vaWRpu+MAN2I+FxM2VFr6eR?=
MIME-Version: 1.0
X-OriginatorOrg: omron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 090973d9-80f7-4e3b-b79c-08dbd501ce1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 02:26:33.2376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ecff5a9-4bef-4a7b-96ec-a96579b4ac37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j25x+YQdbZ9HI4O6qnq3sfyT6hGuEVzm3GLFmLrXpB8XOPxV0y5ndNpBesuQ8vyJPzYxMqx4QK6xe7qk9DoC3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1905
X-Mailman-Approved-At: Wed, 25 Oct 2023 04:34:13 +0200
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

SGkgU2ltb24NCg0KRHJpdmVyIG1vZGVsIGlzIGVuYWJsZWQsIHNvIGl0J3MgcHJldHR5IHdlaXJk
IGl0IGRvZXNuJ3Qgc2hvdyB1cC4NCkNPTkZJR19ETT15DQpDT05GSUdfU1BMX0RNPXkNCkNPTkZJ
R19ETV9XQVJOPXkNCg0KVGhlIFRQTSBtZW51IGlzIHRoZXJlLCB5ZXQgc29tZWhvdyBlbXB0eS4N
ClRoaXMgaXMganVzdCBhZnRlciAibWFrZSBzb2NmcGdhX2N5Y2xvbmU1X2RlZmNvbmZpZyIgYW5k
ICJtYWtlIG1lbnVjb25maWciDQppZiBJIHVzZSAibWFrZSBzbm93X2RlZmNvbmZpZyIgdGhlIG1l
bnUgaXMgdXNhYmxlIGxpa2Ugbm9ybWFsLCBzbyBzb21ldGhpbmcgaXMgZGlzYWJsaW5nIGl0LCB5
ZXQgd2hlbiBncmVwLXBpbmcgZm9yIFRQTSBpbiBzb2NmcGdhIHRoZXJlIGFyZSBubyByZXN1bHRz
Lg0KQWRkaW5nIGl0IHRvIC5jb25maWcgbWFudWFsbHkgYWxzbyBkb2Vzbid0IHNlZW0gdG8gd29y
ay4gc28gSSdtIGEgYml0IGNvbmZ1c2VkIGFib3V0IHdoYXQncyBnb2luZyBvbi4gQW55aG93IHRo
YW5rcyBmb3IgdGhlIGhlbHAhDQoNCk5pZWsNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQqy7rP2yMs6IFNpbW9uIEdsYXNzIDxzamdAZ29vZ2xlLmNvbT4NCsvN0MXI1ZVyOiAyMDIz
xOoxMNTCMjXI1SAwMzowMw0KzfDPyDogTmllayBOb29pamVucyAvIE9DLUlBQiBQQkQtQyBERVZF
TCAxLTEgPG5pZWsubm9vaWplbnNAb21yb24uY29tPg0KQ0M6IHUtYm9vdEBsaXN0cy5kZW54LmRl
IDx1LWJvb3RAbGlzdHMuZGVueC5kZT4NCrz+w/s6IFJlOiBxdWljayBxdWVzdGlvbiBhYm91dCBU
UE0NCg0KSGkgTmllaywNCg0KT24gVHVlLCAyNCBPY3QgMjAyMyBhdCAwNDo1MSwgbmllay5ub29p
amVuc0BvbXJvbi5jb20NCjxuaWVrLm5vb2lqZW5zQG9tcm9uLmNvbT4gd3JvdGU6DQo+DQo+IEhp
DQo+DQo+IEp1c3QgYSBxdWljayBxdWVzdGlvbi4gSSdtIGRldmVsb3BpbmcgYSBwbGF0Zm9ybSB1
c2luZyB0aGUgc29jZnBnYV9jeWNsb25lNV9kZWZjb25maWcNCj4gZXZlcnl0aGluZyBpcyB3b3Jr
aW5nLCBsaW51eCBib290cywgYnV0IHdlIGRlY2lkZWQgdG8gYWRkIGEgVFBNIHRvIGl0J3MgU1BJ
IGJ1cy4NCj4gRm9yIHNvbWUgcmVhc29uIHRoZSBUUE0gc3VwcG9ydCBtZW51IGluIHRoZSBtZW51
Y29uZmlnIGlzIGRpc2FibGVkIGFuZCBJIGNhbid0IHNlZW0gdG8gZmluZCBvdXQgd2h5LCBvciB3
aGljaCBmaWxlIGRpc2FibGVzIGl0LiBjYW4geW91IHBvaW50IG1lIGluIHRoZSByaWdodCBkaXJl
Y3Rpb24/DQoNClRoZSBvbmx5IHRoaW5nICdjb25maWcgVFBNJyBkZXBlbmRzIG9uIGlzIERNIChk
cml2ZXIgbW9kZWwpLiBJcyB0aGF0DQpzb21laG93IGRpc2FibGVkPyBPbmNlIHlvdSBlbmFibGUg
dGhhdCwgaXQgc2hvdWxkIGFwcGVhci4NCg0KUmVnYXJkcywNClNpbW9uDQo=
