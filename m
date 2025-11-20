Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2E0CF8844
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 12:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9314840E6;
	Thu, 20 Nov 2025 13:09:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Vrl3ezfb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E8A840F8; Thu, 20 Nov 2025 13:09:26 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27C54840CF
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 13:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQWQmKkf1e8y528quopuEcdfUZgZpH+Zp5cJ4E+KeSLgaR2KdQdpLExtESGMX+OFChurp3OaJenl6uwFn9BAKpfJtV/gkBi4sY9lOwI8Bkivz4z9l+UC1ZxUtCP7e1dvR6Hs4gwbLvyhJ0GgcDPnZVd+P1XuFwsWBkT2HJi3Q1TPBVFCHzVacmbDvR3v/zc20gy6Nmht/c/ExmVDH/CP7RSlHj3ZHhr/lyV0lMwsLZr4TGvOn1xNOq7GzFeoQOIz0+fjk5t/K2klRTaZhO9vscUQ/JNZSrEQ1vr5XAqPH+wMVrJUqS3RFPZQ1eO8lCpKXHNaA94BvND3XWmWRDKoAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djKBT4AljNzXRqRGP+yy17vgVvhGl4HfCkJLyf/1ZCk=;
 b=mAOUCUuvVTh+wgX8L3n0JN1L5b8BbOt0IUHqNS0jPSHPyPbzzXKiA75q7njvY3GuWTUT8aLj7sj0pr1b2+d7zaRKQLG40oIl50SIH+yFEg73bu1go/kKow9eiL3rL8Mjfhf4R8JtfVlKXVXz1rC2IhtlBeZSflbv67Jreno8ljejFOwY0amQ///wur0xcCIdR4PRwdMqmDjftfF+TUdZDvmCDJr1cA7o0/9UiJN6+3QMZtt6NizXhE0tkNFSCjD4dwTKpmXGXCIHSEwNLGDMzKuq2GXn8WfKdAN9eHHK0WWVULTiBqmW5kME201De+2IpgqItuYV5RyBHA5t5cViAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djKBT4AljNzXRqRGP+yy17vgVvhGl4HfCkJLyf/1ZCk=;
 b=Vrl3ezfbftxjwN64yKJkdCnInzy52jWf1Am7gqliaAxetuKFHLUJnJo0gzk7Z4fQ5yGuq6Dr9gQ+HCrU+ozQZvyLinEdTFJLs1awTclPXoBCkaq54NIO2aA0jIfifu3TO2JXrWNNFta7nlkjc/RbbzfmhZfXBVl/EMtMZQMrE/ielPX+VJuthCVAU110DTXuaK6dvn2m+E5ofTAuZ2G4wAwZqLrMPWIDwLyIDgXy1o0IWBCCNy04uGvUxOVGOCUHMtb/sELIs1jsYfM0h46Zr5L/GxPMd3gfb8aXchh/J6Nfq3hCamhaE1ED3rh6WiNwotjpmIRRsAUXUuc6eumblg==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by GV1P195MB1620.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:63::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 12:09:20 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%6]) with mapi id 15.20.9320.021; Thu, 20 Nov 2025
 12:09:20 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Leonard Anderweit <L.Anderweit@phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "jerome.forissier@linaro.org"
 <jerome.forissier@linaro.org>
Subject: Re: [PATCH v2] net: tftp: Remove tftp_init_load_addr error path
Thread-Topic: [PATCH v2] net: tftp: Remove tftp_init_load_addr error path
Thread-Index: AQHcWfkk7UcZWy+cHk+GlvZu/2fW8LT7eQyA
Date: Thu, 20 Nov 2025 12:09:20 +0000
Message-ID: <fa014deb742ac1f8e7cea0644751f2d4b4235189.camel@phytec.de>
References: <20251120083855.2350372-1-l.anderweit@phytec.de>
In-Reply-To: <20251120083855.2350372-1-l.anderweit@phytec.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|GV1P195MB1620:EE_
x-ms-office365-filtering-correlation-id: c6d9071b-116a-45c8-9cc0-08de282da2c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Q1orb25tbnoweHF4by9ESkhxTkZpWWpzZDZNUmpiMWphQWpCQWVpd3dtRmY0?=
 =?utf-8?B?RDM5U3ZLeThLdTVTL0gxM0hIQzkvN0tkT3FhNG9sNFRzVk12b2dLNW13WGZh?=
 =?utf-8?B?MWQ0WkZreWRoNnhGY3RPZ2MxeHgvTjA2cVBpVXFGZTFlWnBUQStoZTljQ2o0?=
 =?utf-8?B?cmpxYk8ydzJqdDVpZ3RQdzhIMlNCcCtFcXhIb1g1OVYxSTBwK3A1ZWJVZmhC?=
 =?utf-8?B?TXp5QkRubEpBYW0vdGFjYnpPQkgrRUIxaUY3UGJNYTZXemM0dVBXR1JCMzEr?=
 =?utf-8?B?RkpkYUlrb1IrUzVOTUtrSVlKR05GcmZZMm03VGd3YWFhVnQ3SXhiR1UvZjNE?=
 =?utf-8?B?SkMrR1ZTRER1U2VGdExMT2lUdEpLdVFJS1FFdHFiTWtHOG1ZbGJaNW5KSzhq?=
 =?utf-8?B?aktCWjZNL0xjakQvWFQzSEt4cnBOTy9UTjdqUUx5SlA3RXNGYnE3VUhCUmhG?=
 =?utf-8?B?OFlCZmxCZ1Zidm5nVklPZGIrck9VNDl5RUVQUzZsK1BYYWtHSlBSZVBNb0k2?=
 =?utf-8?B?SkNxQkhlbzVZWnhiMkJLOE5QdlJoZnFwZmphS1k1UmhIYW5xZzRBOFRNelNK?=
 =?utf-8?B?ckJvSkw0cEpsY0I0anpIUzhEMTZxa1lKU3Y3aFc1Q2d3QjVjRnlsMm9HdWhp?=
 =?utf-8?B?T29lV1gzSmdRNDlGTzEyQlZGZFF0YUw5bllLMnE0L3VlR1BBRHhkR2pVM2g3?=
 =?utf-8?B?TWFoZVVmaktUWTdxWVZadFR2WWNyb2Z0bEhGYkJkQTlBUUx3NGZpSndTbmlq?=
 =?utf-8?B?Y05COTM3OUdDbTlKaGk5aDBPc1FJNTNIY2hydEszS1NlT0sveWZsSEUwMHF2?=
 =?utf-8?B?YlpVcU5DeXRLTEZSYW9vbVVNTVdFR3MrMWh4SnRKMW1PVDJoR0lleXpzVDNQ?=
 =?utf-8?B?c3Yva1ZFSzhRR21ZZmk0dmkxb1pBcXBPWWtjZXI1NE5kdmtmRVRoUkw4K0NK?=
 =?utf-8?B?MHhXcmkxSHpXTjJZb3ZQc3hyNXE3Y1ZWSkp3YnY5bEN3SGVVMXdKL1o1MU5z?=
 =?utf-8?B?bklVcEhRNjQ0Q29UelowQjFhZTI5WDl1VC9wK28yL0lIV3VOUVk3VzE3ZXZv?=
 =?utf-8?B?RzZITG02V2VnV0tkTERjb0JKL1REVjB1QWJtekl6RVc2YkFma1VFWkpFdURX?=
 =?utf-8?B?Z09waEtvLzU5d1hBdUpLTHh4SWJaVmpqRkhSRER5TmlsdkwyaTFlMGZlWWZw?=
 =?utf-8?B?RXRZclpINzJVdUdHV2lpd0pVMHRENGhINDdQYVVmbkdZazRTUGdmZ29qQm9Q?=
 =?utf-8?B?YVFyTEdKRzJFOEFIMndZSUNQUWtZd0xLcERneHZ4WEoxTGFWSXE5L3U4VmpF?=
 =?utf-8?B?VFp0b2x1Z3VDbklxU1FYdUx3WE1wNkFoL3ZpNVViNWhpZWJ0UXh1U0RZcnBJ?=
 =?utf-8?B?dmFQRUtkSUFFc29BMUdGMzcrK21GajZocHRJanZGeEU1QnpXeVVUMXdDRUxi?=
 =?utf-8?B?WGJvaW5WcFp6Ulhzd2VVeDNrYW9OT3RuVVlFU0lmL1l0OXNNOFU3T29ROGli?=
 =?utf-8?B?YmkzNXFmcU9kVGxUS0gzSzlCN0pGQnZXVzBMeDdlcWJuZEJicWZtUG8yRkZr?=
 =?utf-8?B?U0ZQeG92UUhsR3haOGhpcnREeERZc05CK2FpZS81LzBJbU9WRFVHWWVWVytR?=
 =?utf-8?B?SnlWRklDNTZrWHFlOTFsWmR2ODB1M2dNbjJ0TEk2aTlDc3JucjJEc2lJZTBr?=
 =?utf-8?B?Q05oSWJRTFkvQ2taU2VMOTNTYzdyWk9rckJna3lmTTRtNnJ4S3FGY3pmcmhR?=
 =?utf-8?B?TFVPZis3a2hYZnNmNHBBZlBLWlZnTm1TVEUrWlBsb0dtRmJOZGRweExkaDVZ?=
 =?utf-8?B?REdid1EwRmphWnowTGNQZSsvQlA0a2I1Y0xIdUpIRlB3SVFUWGpuN3llNWIz?=
 =?utf-8?B?MkFmN1R5WWVsbEZNRUxzd08rcmpHYzM3Sms2eE1mNEJwbS96T3h3QjN0VitI?=
 =?utf-8?B?L1BBRTFxKzNEV1F5RnVVWUtKQXBBb09MeVRHU1lSMWljcW1pdDlrdWcrMWpH?=
 =?utf-8?B?UmpvWGdFVmJqL0hteTJvdGtTRTRhTEp1ZURyRHpGRGNzTGhEdXI2QTZvK2Y2?=
 =?utf-8?Q?5tT29d?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWp6eitVWXpkKys1ZUkzeWZyNmxBYkgyRnBJd1Fmb2VLVFVvZzIxdmRZa3Nq?=
 =?utf-8?B?OVpsTTUwamxWMm8vdUJnVGh0L0NyT3hOMEJuQnBRTjdLMkFjNlAxY1Frd1hY?=
 =?utf-8?B?Tm12MHNLeEFIangxMVJyTlJaWlpGdXFDdFRwWk90aFFQeXkrOHMzQjZPMWlO?=
 =?utf-8?B?eDY2NXoza3JtbE5nWHpHTmNIdEEwNmlnc2RJM281Zm5NS1VEcHJCUFMyeWRZ?=
 =?utf-8?B?VjY4VnZ5ZjV3VzYzZTRpaGV3RVFsNnN1SkhoSkNpejBhUGlrSTNTdWVIaGFq?=
 =?utf-8?B?R3c5ckpHSG9maXZZSUFrWE80MVVNN1ZrMmo4N3Y3QWVBVUU4a2pCRFNwOS8z?=
 =?utf-8?B?MmQzMmhERXRsK2JsRlgrSExQQmJtVlJ3U1JwRFBnRFNYbHZrazFCT2hFcE1W?=
 =?utf-8?B?Nmc1UzEzVWs0dWV2dVFxVCt4bmJHUS9IeWxzalNrQlo2TmNVSWtMT3NjS3FT?=
 =?utf-8?B?RCtRczlnQTY0Z0tjZlZBUUhNWkpDQS83RjBvV215YWxNMXZJTWtLSnhnYTFv?=
 =?utf-8?B?dU40SFF5Ujl0eGJGNUx1NWZPUStuWEIwK0Z3UWRVRWNTNVhkZkJFT0tFTlVz?=
 =?utf-8?B?T3N3SXJIY1NZbG9UVnlEL2xtWEZBamIrbDU5RGZNVnd6bmwwbmU5b2ErZGhr?=
 =?utf-8?B?bzhqY2xEM281aUllaDc5ZWNkNjJ1MXllNDJjZm1lb3FjRTArQk1PbW9lTzlr?=
 =?utf-8?B?WmF6VGN1NGhNT3cydEVjU25Eb2t0eTArRUQ2VTAvdVNoSEQ3d0RtMlR2bnVw?=
 =?utf-8?B?UjhzSzRQT0FyVXVkNTlOalU4WGRUV0NxUGxLaEp5elhUdEUvTDYrMWhOU1Zi?=
 =?utf-8?B?YURrbTFqVEdZbXZnbWlqd3k5YVdsd2NTK1BiWDIvTGRJem1tY2t4VXBRckt3?=
 =?utf-8?B?VVdBR2xZV2p4c00wUG9mWkJYeXRqSTVGNGJHU0F5RCtPaFZpZmxLRXczeFNx?=
 =?utf-8?B?R204Q09Ka0pBWGlWc0VIK3FGN2xqSm1uTUhyaldRejdVTXNEU044TW10MW96?=
 =?utf-8?B?TzRwU3pxb0U0WmQzT0tYRVZzazdBVTM4enJUMitsZlVmWFFYTkdKZ1Q4VW95?=
 =?utf-8?B?ajRFSTNXM3FkWXcxckg1MkZmYTUvekRJQVBVUUpDYUVYYUFXak9XQXlEYWt3?=
 =?utf-8?B?NnlZNnFHbkxvK040ZURKd05zU09aWmg2RVdhcVlDMFd0K3dvenFkemdVeG9m?=
 =?utf-8?B?SFVFcXUwUkhTTUVqcW5OVDlueGV5WjNQU0h4OTV5ZllJVDgzUC9zeVFJMkU3?=
 =?utf-8?B?TmlvOTA1ZldBVXdjQUFPNldJZmVTaFU2TlFPYkFzTkVpUGNKaWp2WTVGTjVO?=
 =?utf-8?B?aDF0eENia1N4NUVvNFd6VVpaMmdLY2lGaHl6akNDR3RYTXorWURDdzdSK2Nt?=
 =?utf-8?B?S1RhQXBjVnpmOGI3SXU5K1dlcVlOR01LdzB6UUI5YVJVRVFUMU8rcno2ckZW?=
 =?utf-8?B?Z1dUbWhWc21tMlNXd3lONEd2RHQzL3Z3am13ZTJ1dmk0ZW10bDdRL0dieUF1?=
 =?utf-8?B?N2k2MGE0UnJ4aUZBYzlZTk5xOXVDNFRUOC9Wd25lWWpkUDdZUlFubk1yNXRp?=
 =?utf-8?B?ZUg1UDFWNG51QjE3VnpURkNIQ1hYd0dwOXlXajU5RDZhWUc3cVlQZkxWSElC?=
 =?utf-8?B?OWlTait3emhYdFlSMER5T20rYm9MazB3blpoZjZZSzIvaUNVb2s0THZPcUV2?=
 =?utf-8?B?UGVFL0JNUVJHbjhOTjMxRXY4UTNSMEdCY2NLRFluUHZad3h5eUlRelVPMGdv?=
 =?utf-8?B?WUFzeGJ6NWF4cEVDejg2WFF2Z1pycnhXWHl2UG14ajNnbVd5WlgzS2FjY0dk?=
 =?utf-8?B?WEYyWmtXM1FGWUg0aHJNREk1VnFSOE1kMy9qdWF2clJiUVFVRzJob0ZTNUJQ?=
 =?utf-8?B?RExDZUhZcFg1ODMyOHk3L0N2N1FzNTBLMmhCYURzSW4xem5seEZnT0VzMDZh?=
 =?utf-8?B?L0dEYXZhWjI1UmdkRmgvNkJUeUxTU2hueDV6d0V6WGNNVkFzVC9Bb1VaY2xq?=
 =?utf-8?B?SEdMN2FuRUxCUkJmRmhGRkJ2QkViOXhyKzY2Y1k4SDhLSHBIQmNmVjU1VzhW?=
 =?utf-8?B?RlRJZC81cGw3dHg4S1IzaU9iU2dJT1lNTnE1UE1CR2tYd0FrSEcxV3VKVVVs?=
 =?utf-8?Q?9LMQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <685A3D0025A07548ACDA378746C4A068@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d9071b-116a-45c8-9cc0-08de282da2c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 12:09:20.2329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSBGm/qaT4GYBjDwuIS0aCcCf4raStiGg7tRlFkHYQmLuifokm5AoJflrIir/PX7F7wab+7g1SBAqoEKGDLZTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1620
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

T24gVGh1LCAyMDI1LTExLTIwIGF0IDA5OjM4ICswMTAwLCBMZW9uYXJkIEFuZGVyd2VpdCB3cm90
ZToKPiB0ZnRwX2luaXRfbG9hZF9hZGRyKCkgYWx3YXlzIHJldHVybnMgMCBzaW5jZSBjb21taXQg
YWY0NWM4NDg3MWU0Cj4gKCJ0ZnRwOgo+IHJld29yayB0aGUgbG9naWMgdG8gdmFsaWRhdGUgdGhl
IGxvYWQgYWRkcmVzcyIpLCBzbyB3ZSBkb24ndCBuZWVkIHRvCj4gY2hlY2sgaWYgaXQgZmFpbGVk
IGFuZCBjYW4gcmVtb3ZlIHRoZSBlcnJvciBoYW5kbGluZy4KPiBBbHNvIGNoYW5nZSB0ZnRwX2lu
aXRfbG9hZF9hZGRyKCkgdG8gc3RhdGljIHZvaWQgc2luY2UgdGhlIHJldHVybgo+IHZhbHVlCj4g
aXMgbm93IHVudXNlZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBMZW9uYXJkIEFuZGVyd2VpdCA8bC5h
bmRlcndlaXRAcGh5dGVjLmRlPgpSZXZpZXdlZC1ieTogWWFubmljIE1vb2cgPHkubW9vZ0BwaHl0
ZWMuZGU+Cgo+IC0tLQo+IHYyOiBjaGFuZ2UgdGZ0cF9pbml0X2xvYWRfYWRkcigpIHRvIHN0YXRp
YyB2b2lkIGFzIHN1Z2dlc3RlZCBieQo+IFlhbm5pYwo+IC0tLQo+IMKgbmV0L3RmdHAuYyB8IDE4
ICsrKy0tLS0tLS0tLS0tLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MTUgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL25ldC90ZnRwLmMgYi9uZXQvdGZ0cC5j
Cj4gaW5kZXggMTc2MDg3NzEwN2ZhLi4zYjBmNGNkMjAwNmUgMTAwNjQ0Cj4gLS0tIGEvbmV0L3Rm
dHAuYwo+ICsrKyBiL25ldC90ZnRwLmMKPiBAQCAtNzE0LDEwICs3MTQsOSBAQCBzdGF0aWMgdm9p
ZCB0ZnRwX3RpbWVvdXRfaGFuZGxlcih2b2lkKQo+IMKgCX0KPiDCoH0KPiDCoAo+IC1zdGF0aWMg
aW50IHRmdHBfaW5pdF9sb2FkX2FkZHIodm9pZCkKPiArc3RhdGljIHZvaWQgdGZ0cF9pbml0X2xv
YWRfYWRkcih2b2lkKQo+IMKgewo+IMKgCXRmdHBfbG9hZF9hZGRyID0gaW1hZ2VfbG9hZF9hZGRy
Owo+IC0JcmV0dXJuIDA7Cj4gwqB9Cj4gwqAKPiDCoHN0YXRpYyBpbnQgc2F2ZWRfdGZ0cF9ibG9j
a19zaXplX29wdGlvbjsKPiBAQCAtOTAxLDEzICs5MDAsNyBAQCB2b2lkIHRmdHBfc3RhcnQoZW51
bSBwcm90b190IHByb3RvY29sKQo+IMKgCX0gZWxzZQo+IMKgI2VuZGlmCj4gwqAJewo+IC0JCWlm
ICh0ZnRwX2luaXRfbG9hZF9hZGRyKCkpIHsKPiAtCQkJZXRoX2hhbHQoKTsKPiAtCQkJbmV0X3Nl
dF9zdGF0ZShORVRMT09QX0ZBSUwpOwo+IC0JCQlwdXRzKCJcblRGVFAgZXJyb3I6ICIpOwo+IC0J
CQlwdXRzKCJ0cnlpbmcgdG8gb3ZlcndyaXRlIHJlc2VydmVkCj4gbWVtb3J5Li4uXG4iKTsKPiAt
CQkJcmV0dXJuOwo+IC0JCX0KPiArCQl0ZnRwX2luaXRfbG9hZF9hZGRyKCk7Cj4gwqAJCXByaW50
ZigiTG9hZCBhZGRyZXNzOiAweCVseFxuIiwgdGZ0cF9sb2FkX2FkZHIpOwo+IMKgCQlwdXRzKCJM
b2FkaW5nOiAqXGIiKTsKPiDCoAkJdGZ0cF9zdGF0ZSA9IFNUQVRFX1NFTkRfUlJROwo+IEBAIC05
NTMsMTIgKzk0Niw3IEBAIHZvaWQgdGZ0cF9zdGFydF9zZXJ2ZXIodm9pZCkKPiDCoHsKPiDCoAl0
ZnRwX2ZpbGVuYW1lWzBdID0gMDsKPiDCoAo+IC0JaWYgKHRmdHBfaW5pdF9sb2FkX2FkZHIoKSkg
ewo+IC0JCWV0aF9oYWx0KCk7Cj4gLQkJbmV0X3NldF9zdGF0ZShORVRMT09QX0ZBSUwpOwo+IC0J
CXB1dHMoIlxuVEZUUCBlcnJvcjogdHJ5aW5nIHRvIG92ZXJ3cml0ZSByZXNlcnZlZAo+IG1lbW9y
eS4uLlxuIik7Cj4gLQkJcmV0dXJuOwo+IC0JfQo+ICsJdGZ0cF9pbml0X2xvYWRfYWRkcigpOwo+
IMKgCXByaW50ZigiVXNpbmcgJXMgZGV2aWNlXG4iLCBldGhfZ2V0X25hbWUoKSk7Cj4gwqAJcHJp
bnRmKCJMaXN0ZW5pbmcgZm9yIFRGVFAgdHJhbnNmZXIgb24gJXBJNFxuIiwgJm5ldF9pcCk7Cj4g
wqAJcHJpbnRmKCJMb2FkIGFkZHJlc3M6IDB4JWx4XG4iLCB0ZnRwX2xvYWRfYWRkcik7Cg==
