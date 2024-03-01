Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A228CC5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 04:21:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 107668800C;
	Fri,  1 Mar 2024 05:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=SocionextGlobal.onmicrosoft.com header.i=@SocionextGlobal.onmicrosoft.com header.b="riDOwIwk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED3F880BE; Fri,  1 Mar 2024 05:21:01 +0100 (CET)
Received: from ps82.spcmail.jp (ps82.spcmail.jp [35.74.107.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FBEB87BFD
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 05:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kojima.masahisa@socionext.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mog0fIdaFm4LHDgx29h46BUqXU5mf1lpYvgezZgKyXv0o4o8REg1nMcB/ZMYSdWE2h3Hp16HEldDyISzxJ4t+fYrkfdbnpqBV84Kk+mc1o2RjFLE/jlJ+33BlHGPUsUCFQgMf/idBLrIdoPSPef6d+roAeJsjZdXXrQTlMgYKF93Ob4wSyg3o0DgHiPIPDGMGlqiLjc/j4URieuh7i474TWwlswPIDdi5a56N6c8CFp8cKJcu7jvuDu8ryEbDvj3+JjtOidmEiP1JyWq1412BfsnRen0f6SDKxwBJ7Gx+GgFr/2P6GaZLKz/yNTWnhyJQiIlsZa7kY3PxUoziqYmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bhe+mhtnpaQxVrRPXTJjrEwEN9tLYvuK0wYIZm9he/c=;
 b=Qym1TyY7QCIZYh9kflCwGlmvuupdi3+6ifnh241/ItcmshLv4hbGuKbdv1DlcFB3mCs48o+olNzSlDsefzeHX12nvfOKXWolXj4WyjslHwwLUxA/2ReTl9p+lwVcG5wlKDHXgZFe2opLTkkMsFJEvaIdGg4A1lwQucpwok32mqMqH5f5Uk5mMluO3CQU+IUXLTqzFjx0V6ZekRrec10zin2Z396iPQbad0qJZ5e7MyXYRowlUGg6ZaDPMDPdjLpx5DVIE4F17LixP/fA5MII3sFZJoQb9msupABtbrJfafnMHCFlUtLxxwwRLggkj9D4/DosC2dw83sQIflYSkX/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=socionext.com; dmarc=pass action=none
 header.from=socionext.com; dkim=pass header.d=socionext.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SocionextGlobal.onmicrosoft.com;
 s=selector1-SocionextGlobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bhe+mhtnpaQxVrRPXTJjrEwEN9tLYvuK0wYIZm9he/c=;
 b=riDOwIwkry0Vc3SF3Hn6b+hsFq0vS2OSr95QIk5omJ6QD7IO9JF5gf00qtGjK7AcaLbCRGuBQdVyF16hq96mQKuospbRmG8TObAoUd2BVlNZTui1z3YKkloIgiC9OUK9SQfRQqk11eX/tDlETj8HtK3RnNn/yvlW+E6V1/ipALc=
Received: from TYCPR01MB8375.jpnprd01.prod.outlook.com (2603:1096:400:151::10)
 by TYCPR01MB9571.jpnprd01.prod.outlook.com (2603:1096:400:197::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 04:20:39 +0000
Received: from TYCPR01MB8375.jpnprd01.prod.outlook.com
 ([fe80::e609:6e11:910b:f949]) by TYCPR01MB8375.jpnprd01.prod.outlook.com
 ([fe80::e609:6e11:910b:f949%5]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 04:20:39 +0000
From: <kojima.masahisa@socionext.com>
Subject: RE: [PATCH] board: synquacer: developerbox: add myself as
 co-maintainer
Thread-Topic: [PATCH] board: synquacer: developerbox: add myself as
 co-maintainer
Thread-Index: AQHaa3CZDnD7dp/JpUK1RDk4rjVn2bEiRu4AgAABltA=
Date: Fri, 1 Mar 2024 04:20:39 +0000
Message-ID: <TYCPR01MB8375BC1AF5783D7A3BDAB801E35E2@TYCPR01MB8375.jpnprd01.prod.outlook.com>
References: <20240301003731.2308083-1-kojima.masahisa@socionext.com>
 <CABb+yY1Ty3G3MMe9J387adcWwCPpktvURJxmT4c=8Tp9yX-FiA@mail.gmail.com>
In-Reply-To: <CABb+yY1Ty3G3MMe9J387adcWwCPpktvURJxmT4c=8Tp9yX-FiA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ccmail7: Relayed
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=socionext.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8375:EE_|TYCPR01MB9571:EE_
x-ms-office365-filtering-correlation-id: 76655dfb-88d9-4ffb-50d4-08dc39a6f3be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MPSk11HZ4zdcwtpIVHb/sigtyZsXQSmyQMcflwTrRwVCgHTA+c0HC5S2k3ZcuTwjdTH1W1/ipw/oE9lMcwV36HeR+9bLrGmA0GaMSBVHunP0pM96bXxR4frkL1BgfbeZWCGIn1F9Vb/OuIzSlUw/nh7Fdit1siVO8Zx2GIE1dIabmlswDYrhHlgB+yzA78PZ0RZYvFzu5W6St8kCQYOWO3tcYxZq3gRjZ91lHvSMfg9ivNe4nW8HpW0fBwzwaCgRTV1VCkFkjogUGKoHVpGt/S+Kt7/DbW7xqxZLK6cNviIJwBRb76Rsi4+BRX2N/mZ3vvor2VKJx0nt2LpZmp1zUskTJBWFl5A33T7AFeFvtfC42PugCK5S2BEVytOvvuq3DGyGHBLGQwm1TEsK6oSjRQDO4hOPfLQUchRaFAwGjTuJV4E8bh4zExby06+o5yGx02PleHJl0zpDhNnw44/3JSP9CmEBZaMYC4N4X4f4uz1Fz45OTfdJBlU9sCHLl2Yj5G68zc5rdOgUnONY/ZAOpA5CyFEnMf/CmHVQucdLlNfgjj6C3aluFVDS+/YwEtx+7sKNJyROVAHzjIYdzYf6r1mgHU97A1NkhP18FWb8KchBaMzQPiGM9y153nuiTiUJ1SF/aiKhi143AlMIEYrkO9vnLYms+S014khbW4qAldv1YNDmcOUS6AjR5C3h3rHhiyDAXd9aCC716zamQBEjbn4HagrK8gPWoii6qrhGySp5fKWlE4VhgpX9Bvv0NxIE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB8375.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1580799018)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clFIbEdJSU41bndTcUVwdEFFbVppNm83Yno4Z0U1dUY3TlBUa0xvS0ZYcjRB?=
 =?utf-8?B?aCt4Z2lmbmI1K2d5Zk5GUGRKcUFlbUE4RHBIT3F3QzdhRVVQWXVXbHlUZ2My?=
 =?utf-8?B?ZU9uUHRjSktKMzhyWGhMc0hwYnBrMnRDOVRycEhhek5rT2NFaGNnMEN1OUUr?=
 =?utf-8?B?alNVek8rMWQ2UjhSSzZtUGhJKzg5WG9EQjhEZzM4c0lKSkMrWHcxTS94V0RR?=
 =?utf-8?B?ZEtUSHNCeFgwZHdIMjFyMCswYnhuektOT2pIdUlCZDJsZjVlYnRjMy9YY1Jq?=
 =?utf-8?B?TjdXd0V4dVFOL29Ib2tMdGtCdnp6aDBlbnBybi8zOXg2RkNNbGlOcVpiamJP?=
 =?utf-8?B?c21Dd1llcllKYmx3VmFlQjE4SWYrK3I5Q2lzNGNIeHNobDRqbVdkaytWajZY?=
 =?utf-8?B?dUlIaS9GTTRQbGgvOHNIZDVpQmxQWUJ4ZnB3MXhDTUNTUitPRXdpbCs0WE9F?=
 =?utf-8?B?QmNSKy9DbXU5ajVNanpFZFVGY0ZBVEp4aVJWcnJoSGxVanZoeDliSmIrSmlu?=
 =?utf-8?B?S1VMQnJ4aXFLMG1PWUZMVU5QTmZBU3V4cUFEY2svSDVBT0E5SzV4alE3dE1Y?=
 =?utf-8?B?TlY2aS94RU5zbm4xenMwWkVKay9BTWY0WTlBRUR1VC8zai9xRHVSRjExQ3BW?=
 =?utf-8?B?eEc2ajBnOU1VRTFHcWF5cXhBUXMzTndKUlByeVQ0bkQrYkgzRmlRY1U0cWVu?=
 =?utf-8?B?SUt6Zkd1NUdmY1Vlb3JjVXo5UmhIVS9wZU9QRE9abXdYWkR6RW1oaGJsY01H?=
 =?utf-8?B?UFpSeTlqTngyc1NUOTBrS1Qzd0U2cmwvM1dRZjRJbXlVNDVSajNYZE02MGFi?=
 =?utf-8?B?UjY2T1dyQ0l3ajhXOHZWK1dyaExwak1VVWIrZVAwVS93VW05RXU1SktpK0Ru?=
 =?utf-8?B?YWRUcDY1dXVRcm9RbzY5cmV4YzB1Z3FYNU1NTjY3ZmNRVE8wdzBZY21FMHN6?=
 =?utf-8?B?dks3cmpRcUpsTmRrcjRUZWxmRmpzaUk5dFBMSFVNd1FzL2lhVk9QN00wdG90?=
 =?utf-8?B?TE5MaFFuVWIyVFJyNFM1bHQvRzZNK1hGaG1qLzk0NndGZW00SzdOMmhMR1FV?=
 =?utf-8?B?RjJpeWJFQ04yakdvY1hyM3JjREtHSjFCWGp6VDBEd0tEdHAyemxqVU5KSjJj?=
 =?utf-8?B?RFJUYW5YM3NvUTFtQ2tlaC9TWjVCUXNTbDZyVDNLVUthZEtTUWdSTVlra1Ni?=
 =?utf-8?B?QmNLb2FubFZHeFU4ZndOejZCRUJ6NytPMWVSbURQSm94TWpNR05JNTZrL25W?=
 =?utf-8?B?ajlpK0VRWCt2MGZ2WUxtR05uSlhhRU1NQ0dQSEN0b2FKSHhseDdOTXNhN1JU?=
 =?utf-8?B?QU5ibHp0L1BNMGNWVW5YK3RJT2pCOVA1REJpbHdBUXd6Q3dBRkluMVZ2bU1Z?=
 =?utf-8?B?aXNVSjlNZXhwNUtsZFhPQVQ1UXVlMkk5Q1FsYzhQQ1Z5Q3UrcUoraEpVT3B1?=
 =?utf-8?B?aTZUWjlXUzJubzBEQ1V0dW5IQ1B2bVd5SmlmYnIzNzJ6ZWhKdk9PeVFnRDd5?=
 =?utf-8?B?UVhpeEtEcDl1VE9ZTUZudE1TaksvQkltT3pHR3o2bmVPMFpzZ3QwSGxqc2lR?=
 =?utf-8?B?alovb3AwODRRQXFXYjhTQ1drOGJlcU5lS3ZWcmM1WlRYNE1qa0VCMTBOeVFZ?=
 =?utf-8?B?dW9KRDhHdXVGc0RjVmRXdi9CUHFMVmhseURFRCtpRU5CRHVxcDhIankrQnYy?=
 =?utf-8?B?cStlS0t3TGw3U05xM0VHanloWGozU2RJQnlGcnNBWVNiOTZaMGlwSnBUTHlV?=
 =?utf-8?B?SmIxNUR4SHZYanFWdVBuL01zNTFLOWRudUFKNHBJdU50T054eUU5SkNVNVl5?=
 =?utf-8?B?RnFZaDQzVGZyWENQS0dYZldLMlJ4bGF1WkFYbXo5T2p1dHVwd0xaNVQvVGtv?=
 =?utf-8?B?V255MGc0Mk9RZ2JKa00yS0hKRjhPZXAxZWF6czJ3dk9GK1ZpcUhicW45NHov?=
 =?utf-8?B?UVUvSmpMZFJSNDFHaFlNTTMrN2JFU0twaFJJRzY2SGtmNmRCa21ZSkdKRmg3?=
 =?utf-8?B?WFltWVdJVlJETGlUZUJBZ0l1TEZ2YjBaS0ZpRjdJVE01Z2pjODQ2SXFMZUM5?=
 =?utf-8?B?VDJjRlpiNFR4dWdaL2VyRWVjcGNnOVpEVzM1Y2I1NjVGRE1FenAwNXQ3bjJW?=
 =?utf-8?B?SlJpdU8zZHg0aG5uSHNkakpIVDJsYUNjMURxcVVReDJsZU16K1pvSmpadHlT?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qysETwCbPxi4NR9H60ytkv3iMPsW/LQqDTeTAPJEzSSOA8F55zobcsqzPhcpHj8kuwh+lyvKjRybEwGXS+ZiMoX/SV2573h2MGmOoBZGSP++6witoDTLH6LouaacEtYf9s8/fVsZOcBSPfUc0tiviHt8r5u9vnR7sLblgwIaUX4lX276umpqE2SXfOGctE/9mqFUl6nuyCL2AXRugL2DXz8bH1FqTRU7w1foPdLa1hT9CDEUaLBnR6WQbNNokZQdoeO5e9YmwsRQhTk9+Ai/66bMmGLvR+pjK7xotMV9UKmMoTpgAZba4tFQspmUgtrFJry77kYzq+Yi7rygjv2n8cGg8l6gZlGy+O2wLsKWNXhO+ZFb+TJB0j6ogbIKwNOxrqyVsswho0H4sl4W7mty2uwbxkyY7OZ7bc0HAwg8JEonPsgihyfFfEy1Hbc4vhbEQZOt0p2rxm6YCE3E4dgD38JoPl9/NwntmMZQhsp4JDC+7mTGlpO7cogiYMTphBO1U/av2Mzad77oWUZEpQGDJ234g1w1/KuvkjqBats0U8WBQqrxSJcPZEycjh8OZLun6DVwGmDSODLM6aLkR8yl9HJPIKNYRjeKMb0fi3crfmfWb8O3V40tz22si7Mlga51U4fY0Z6QXaBS/dAP707cpJYrwrcr09+FixnH+ZJ3Z6nXEvo1VUqTV6CctlIBR7RKDFPhS/VXU4mfy2E5p5MdHUrieZ2UyqEEcCmkhcJnucB4Gmdgd0Ne4QVkXTmyPz36
X-OriginatorOrg: socionext.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8375.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76655dfb-88d9-4ffb-50d4-08dc39a6f3be
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 04:20:39.6232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33c08a51-ea9e-46de-8669-aff1f467d3fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJ8DMGrseEeH9AafS4FsjPziHdWTkRRoSRz+mv9iagcvF4arjsZDLMESoO72khv2ZhJ6SHiWF1G9/N2HwI2GAkzxtb9GW9I9NEmnV3NnLnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9571
X-CC-Mail-RelayStamp: CC/Mail Relayed
X-CC-Mail-RelayStamp: CC/Mail EncServer Relayed
To: <jassisinghbrar@gmail.com>
Cc: <u-boot@lists.denx.de>, <jaswinder.singh@linaro.org>, <trini@konsulko.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzc2kgQnJhciA8amFz
c2lzaW5naGJyYXJAZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDEsIDIwMjQgMTox
NCBQTQ0KPiBUbzogS29qaW1hLCBNYXNhaGlzYS/lsI/ls7Yg6ZuF5LmFIDxrb2ppbWEubWFzYWhp
c2FAc29jaW9uZXh0LmNvbT4NCj4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBKYXNzaSBCcmFy
IDxqYXN3aW5kZXIuc2luZ2hAbGluYXJvLm9yZz47IFRvbSBSaW5pDQo+IDx0cmluaUBrb25zdWxr
by5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGJvYXJkOiBzeW5xdWFjZXI6IGRldmVsb3Bl
cmJveDogYWRkIG15c2VsZiBhcw0KPiBjby1tYWludGFpbmVyDQo+IA0KPiBPbiBUaHUsIEZlYiAy
OSwgMjAyNCBhdCA2OjM34oCvUE0gTWFzYWhpc2EgS29qaW1hDQo+IDxrb2ppbWEubWFzYWhpc2FA
c29jaW9uZXh0LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBBZGQgbXlzZWxmIGFzIGNvLW1haW50YWlu
ZXIgZm9yIFN5blF1YWNlciBEZXZlbG9wZXJib3gsDQo+ID4gYXMgSSdtIGN1cnJlbnRseSB3b3Jr
aW5nIG9uIGl0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFzYWhpc2EgS29qaW1hIDxrb2pp
bWEubWFzYWhpc2FAc29jaW9uZXh0LmNvbT4NCj4gPiAtLS0NCj4gPiAgYm9hcmQvc29jaW9uZXh0
L2RldmVsb3BlcmJveC9NQUlOVEFJTkVSUyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ib2FyZC9zb2Npb25leHQvZGV2ZWxv
cGVyYm94L01BSU5UQUlORVJTDQo+IGIvYm9hcmQvc29jaW9uZXh0L2RldmVsb3BlcmJveC9NQUlO
VEFJTkVSUw0KPiA+IGluZGV4IGM2ZDRmMjc0OWQuLmQ3NzJiYzNiNGMgMTAwNjQ0DQo+ID4gLS0t
IGEvYm9hcmQvc29jaW9uZXh0L2RldmVsb3BlcmJveC9NQUlOVEFJTkVSUw0KPiA+ICsrKyBiL2Jv
YXJkL3NvY2lvbmV4dC9kZXZlbG9wZXJib3gvTUFJTlRBSU5FUlMNCj4gPiBAQCAtMSw1ICsxLDYg
QEANCj4gPiAgREVWRUxPUEVSIEJPWA0KPiA+ICBNOiAgICAgSmFzc2kgQnJhciA8amFzd2luZGVy
LnNpbmdoQGxpbmFyby5vcmc+DQo+ID4gK006ICAgICBNYXNhaGlzYSBLb2ppbWEgPGtvamltYS5t
YXNhaGlzYUBzb2Npb25leHQuY29tPg0KPiA+ICBTOiAgICAgTWFpbnRhaW5lZA0KPiA+ICBGOiAg
ICAgYXJjaC9hcm0vZHRzL3N5bnF1YWNlci0qDQo+ID4gIEY6ICAgICBib2FyZC9zb2Npb25leHQv
ZGV2ZWxvcGVyYm94LyoNCj4gPg0KPiBDb25zaWRlcmluZyB0aGF0IEkgbm8gbG9uZ2VyIGhhdmUg
YSBEZXZlbG9wZXJib3gsIG1heWJlIHJlbW92ZSBtZSBhcyBhDQo+IG1haW50YWluZXIgdG9vLg0K
DQpPSywgd2lsbCBzZW5kIHYyLg0KDQpUaGFua3MsDQpNYXNhaGlzYSBLb2ppbWENCg0KPiANCj4g
VGhhbmtzLA0KPiBKYXNzaQ0K



