Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC17EE3F2D
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 06:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C86686BB9;
	Tue, 26 Sep 2023 08:46:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=csgroup.eu header.i=@csgroup.eu header.b="Azylv5Ei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3300586C23; Tue, 26 Sep 2023 08:46:01 +0200 (CEST)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e19::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4204586B95
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDxoWgMjQK5ZScEY0CSodTGeRWgyLvYAHRGX3XT6noKNtbW/vWKVpz3EiSxXMUVGAfXamPU0Xy4zXqNb/lmoPFXEDcY3BheLegq2y+w0RR1qhUWNaJc+vrycQeq7oC/ILejpMZ8E4reWzfDbQKcpjorKo8oSNV1ya2K9U5KOxpBCA7G1sG7TpJvLpZhICpxfGIb/qiNL/o+EYefH4/OGMPUH7HR5gg0Dn6FGLGFqBX9rJjlrZyyYokIsBlHEV0cNVrhAhFN0W3M/McrV07etUtmryd6aRNE/9PJA6S9ndjBPVaQlnFOjsi7q2YTgMtrnUbSGgIFf3EDxg64NRtzCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=am3quUJN+Y0+82npN1IL9bvYH+KdPz6aCXxeGuN+N/w=;
 b=g7rsTtXp2CKjTVf7kLApNIurx8eHYXw0g325k0xas0eL/7IBbyyuUgjIYKx9QRZapx9npMDGt72cV0UgJA4Q42gDF1NH7wmTHwV8l4Q/zmL+t29S4j5+MrQTkfe9OEUYW5avxvsmhCwo11VbKS4PvNSqqDVUW+zuLAo8OAu7MkFol08T/FAj5Nau35+dh193k22SHiSEQrvzHqKvVaWzP3Jte4z4f5pzzABaKdvEhk2QRgLSAguYIrX29qki8mC5QTuyxrwxUJPxVkUQvZmIVNwWNTMPYz/ChzxSsJQsTsxBMCPFtFeVOQ7YZdGaUjhcetQw3oEmOlorOveSCUFS5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am3quUJN+Y0+82npN1IL9bvYH+KdPz6aCXxeGuN+N/w=;
 b=Azylv5EiMU2rVziETNy8TyVk8Q7Hlp1Hr6LhSlGhIGVfzqY2AqdhbdWd4ge8PZJASipaIp7S1b8pNQb8BJkumMOcjOfqtsE/XUouyswJzhfidQLD+QvXGTy4W+hQmVw6WfSZpfBLeKMNS2ElPrhoOVWJoq4/ERDIjkMkG/VST6J85Gt6mLyY7ldsP8OVzoMx/O0aJqXNuCcg19ttvJGNbmmcWSpds/0D9jJrJmD+uxuisCb09jUK++O8s4Ij1+sFiUecUYPO7WtRVwDL3umuNdGUqQQuh95aSFO9UfTxUK0v419zkM+rscGK5a8IvPSvb3O9BEWN86xSneeUFZtKAg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2424.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 06:45:57 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 06:45:57 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Andy Fleming
 <afleming@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, Mario Six
 <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>, Priyanka Jain
 <priyanka.jain@nxp.com>, Stefan Roese <sr@denx.de>, Wolfgang Denk
 <wd@denx.de>
Subject: Re: [PATCH v3 04/38] spl: mx6: powerpc: Drop the condition on
 timer_init()
Thread-Topic: [PATCH v3 04/38] spl: mx6: powerpc: Drop the condition on
 timer_init()
Thread-Index: AQHZ7xzxueVy233VfE6BFQhVA5DVILAsq/kA
Date: Tue, 26 Sep 2023 06:45:57 +0000
Message-ID: <19d0cda7-1943-74f2-03aa-f5be970fff26@csgroup.eu>
References: <20230924192536.1812799-1-sjg@chromium.org>
 <20230924192536.1812799-5-sjg@chromium.org>
In-Reply-To: <20230924192536.1812799-5-sjg@chromium.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2424:EE_
x-ms-office365-filtering-correlation-id: 2b135dbd-1b3f-4c49-d3ad-08dbbe5c3cec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jqf2qX1PpOOwE7dplROVLAVIHak2VP1W5EoYz0uLEMhHmYZpiaZmalYJ/cW4VjB8kKjqBnXre1gG2Q66ZuEhhhonsxgIegNpPNYAvNvHVWyZFqi5A7Cf+JrhaTE0O1F/uZPxrcnXplSq9WVT/zJ4J1SG/bmcXdc6Joe8sgZx1+dkZucnMn+cnxzkx5NSl8KDNybd/Xpcb8NAcG5U4XeqJuS5sZkHSQMBkxgGYyJxmAj5277DaQy8+Dz+UDUno6qDUV+Td+IYG46NRwrX+6eM4V5BAo2h3WdCZWPOP+qQkQsRhNVLyZnSC0oyhOrKkdN9PQo0Y88vYb974C/uSO7yQLMm+3OcAtC3AflzJPN6bIABXOVXESIpeI7t9ngeXFWm0EdZSTgwniM3VeJSHrLtVFFRxULei9xAopWezDGxAaT2XtiAF7DxoAQ2F5S7momO4d4pRI+gTOmZpN/exMtmZTwvgmDxreHvHk4OKjmFvCnp0GsK19g2q84iOH+zDDS9WXkXi+zo8TSmh5wGisHh2PUOd/4MTV4b19SoJklNfQxUoQNnYEvDFcuz0VW1aniGRJZKSyBzhFNmtFyX0B+pFiROcDUCMJIkXVSTvBdwbwpLWpWYKOsViHiRnW8927w5E4MQdi66mEI+fqa0Adz3mlFMBk9cySyPkcxmQnymWJFXJ6DCCTAYw8uyYx57ScVT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(346002)(396003)(136003)(230922051799003)(186009)(451199024)(1800799009)(71200400001)(6506007)(6512007)(6486002)(122000001)(38100700002)(38070700005)(86362001)(31696002)(36756003)(26005)(2616005)(83380400001)(91956017)(110136005)(76116006)(5660300002)(2906002)(7416002)(66946007)(4326008)(41300700001)(54906003)(64756008)(66446008)(66476007)(66556008)(44832011)(8676002)(316002)(31686004)(8936002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlBzSUpsMWVRWnJlM2dpTEJUZEwwZ1pRREQrUTlvMFBEeEoyNE1RVm1JT1Nk?=
 =?utf-8?B?QXhBK0lYQ2ZwREV5Yjd5aWpCWkJHZmFORkxEZWJ5NUxvekJJMnpuckJETEk4?=
 =?utf-8?B?bzVkcndxOWc1TWFKYm4vTTZsc2d2Nyt6NUZ1SEZuYWx3aDVBaTQrdVB6QU4w?=
 =?utf-8?B?TjdrcGlvTVBCekpFWnVLNHRMNFNUQ0U2UThSZjFEYk52YmxlYWdCQmc4TGlS?=
 =?utf-8?B?Z2hPRUpwa2U4V2tjdVlXL09qVEliZ1BBV3lnZm8zTmFWMmdYajQwQWpsZXJJ?=
 =?utf-8?B?QS9iNjZUanhYUytaL2xrd0lFZWtxS1pidWpVSndXT25PTjBWVXl0eWtWT3cz?=
 =?utf-8?B?MHJxaFNuWWNiQWVnMWEyTzB0M1laRkFLV29kZTJ1MUxZZURpa0Rjc1ppakhS?=
 =?utf-8?B?MjFtVUV6QnRJZkxxT0t6bmlXdVNTRjhxdkZ0dzV3ZCtkNjgvaWgrbHRuVmpB?=
 =?utf-8?B?dHFGSjZwVjQ1S3JXdDQreklMajNpbHc5QWU2a0pDQThGamtSejN5TzFnbjhM?=
 =?utf-8?B?Y1U5MEpkMkR5emNuOTFWSmlENk1YTno2dUlmOGdwNmRaRVRPdXFmRDZkNUZj?=
 =?utf-8?B?QVRqQjB6TFJXdlk0SERiLzd4VW4wdjFFK0FOalArWWJCNzFBaU1FdmQ1RVVm?=
 =?utf-8?B?anZUejk2cHZ5T0dCdXlnV2RMQm44QTdXQkE3dzcwL0w2U1JqTlZrOUNNRklV?=
 =?utf-8?B?bTlVSGEyUEdsY1N6VWtwMktQWnlNbkM3YzlEUTVDNmpac0RIUXZ1dEsvRnpM?=
 =?utf-8?B?WTlUUUpmUHJHd0RUdldMdUNKWkdMM2FDdEgrb2MzL0x3bmtBUnE5T1N0YUtj?=
 =?utf-8?B?alZqU1UxK09BM0huRDVZQjNmV1oxdjh6dTVjenZHUjNWYlUxUU5zNXJ1M2Mx?=
 =?utf-8?B?aUg5eXE2ck91UmJOWnJkMWkyYVRnOVB5aWpESjByV0pqbUR3a3FKaU1jR2Ru?=
 =?utf-8?B?NnovZlA0emFzQkF0NzRjZ3l2a1lRQmxzSlVXYU5TdzdWMHk2WGdZK2JlYy9S?=
 =?utf-8?B?SExqL2RKMGhaR1pmM0RLd3ZCZUI2NmhyRDRiSkpLT1BzVEhYUzV5alVsaHZv?=
 =?utf-8?B?UzVBY2g0K3ZDNkptS3RWQlk4MVY3dFQ5QUc2TklTYTNaOW1ESG0rQmY2NHBt?=
 =?utf-8?B?NHg5bEdVY1JLQTVMbXhJOTBKdHdLV0xxY1Q0TlJDUUZzMU1tTjdRTlJzTTBB?=
 =?utf-8?B?WEd3YklmMWF2MFVOQk0vbURudWl1RmRmTThCT2dvTWZQbjNiQ2ZRbjhmZWVH?=
 =?utf-8?B?YTROWUQ2UitaWmxkZlUrZUFIRVZ5ZGtkeFA2ajFVZ1lPZXpjZXYzQytqeWN5?=
 =?utf-8?B?VHhRZXZDRzd2Nlo5WWU1VmFkY2pKbFR3blBHeXpFU0RoWVJIdlZHbzVCS2l6?=
 =?utf-8?B?SUZ4Q1pXUEIzdGhVUmZON2JOYXN4WmlwNGZHSlBIRFJYd1VseWN3VDUzVUVM?=
 =?utf-8?B?Zk1rRDFaODRkczI0SWo3STk5WDNLVEo5RkM1QU5ZU1FWOWdaWEJWTzAzQ2Jw?=
 =?utf-8?B?MkxiNEhKcmpqUExCQ2pLb1AvWWdMVlpVMVpsYXdHNEdoa1B2ZWo0RGZrcnVw?=
 =?utf-8?B?VmlJT2lwbmlTRVk2U2dwOGRRNkhNZDhCdGNvbXg1OGJ4TVN6bnRpYVpYRU0x?=
 =?utf-8?B?U2RxOFFGUDRYdGNROEN0L1NHdVhndUZVMHBKelhZT2tpN3llSTVHbTByYnpv?=
 =?utf-8?B?WTd2MDZ1S2h3QVlQNFFZREJDWkNqQm9HTlpUOUJzc1FQWExFeFpCallQdktj?=
 =?utf-8?B?Vkp3RnFPUzlQZEVhdmRxb2VwSjR3clE1bkN5dUcyVllKcjdRU0lnSDVBUE5T?=
 =?utf-8?B?MmxvR2ZHcVA2L1RBeTFtS01Ta3EzL0JDWFNkUXFCUjlselBmWmJDSWNWdUpr?=
 =?utf-8?B?RFN2b1dLemtBRERQMkUzQUVzSUYxb0J5RHFyamROZENNRU8zYkZJVnBuU2FE?=
 =?utf-8?B?LzNqL0NDSnhXaVNwOFIrMXgwOWQ1MEdTWG1UUlg0SjRWYUhWUWI4SVJET0FI?=
 =?utf-8?B?UVVRbDVYdUJoQklkOHlOR3pjU1p0ZWlWdFgvZ3F1OWZDVmh6dkdNekx1bnNu?=
 =?utf-8?B?WkFmaWtNNHJhMHNQTmgvZVFTR0wyREJlelFPTDdpNmN5WEpaemFLeURneW1W?=
 =?utf-8?B?R3J3RHMyYTNWQ05KQWdWWUpvRTBEeWVadDFWMzJwRUhlRzRrdGc0NnZValF5?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E5DB754EB2DDC40811751ECE0CBF195@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b135dbd-1b3f-4c49-d3ad-08dbbe5c3cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 06:45:57.1158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGzPmzdUZB2koXDXJU1FspO+uvzjVyIOHmGF5g8GpSgO506+PQXR4MU+bhLk4gGa7VDJ1BReCm+1GgS1/MT0xJbdvqP34a12qPxv3JLWe7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2424
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

DQoNCkxlIDI0LzA5LzIwMjMgw6AgMjE6MjQsIFNpbW9uIEdsYXNzIGEgw6ljcml0wqA6DQo+IEl0
IGRvZXNuJ3QgbWFrZSBzZW5zZSB0byBoYXZlIHNvbWUgYm9hcmRzIGRvIHRoaXMgZGlmZmVyZW50
bHkuIERyb3AgdGhlDQo+IGNvbmRpdGlvbiBpbiB0aGUgaG9wZSB0aGF0IHRoZSBtYWludGFpbmVy
cyBjYW4gZmlndXJlIG91dCBhbnkgcnVuLXRpbWUNCj4gcHJvYmxlbXMuDQoNClRoaXMgd2FzIGFk
ZGVkIGJ5IGNvbW1pdCBlYTgyNTZmMDcyICgiU1BMOiBQb3J0IFNQTCBmcmFtZXdvcmsgdG8gDQpw
b3dlcnBjIiksIGFuZCB0aGUgY29tbWl0IGxvZyBleHBsYWlucyB3aHkuDQoNClRoZW4gY29tbWl0
IDcwZTJhYWYzODAgKCJib2FyZF9mOiBwb3dlcnBjOiBVc2UgdGltZXJfaW5pdCgpIGluc3RlYWQg
b2YgDQppbml0X3RpbWViYXNlKCkiKSBicm91Z2h0IHRpbWVyX2luaXQoKSB0byBwb3dlcnBjLg0K
DQpBbGwgdGltZXJfaW5pdCgpIGRvZXMgaXQgcmVzZXQgdGhlIHRpbWViYXNlIHJlZ2lzdGVyIHRv
IDAgaW5zdGVhZCBvZiANCmxlYXZpbmcgYSBwb3RlbnRpYWxseSByYW5kb20gdmFsdWUuIFRoYXQg
c2hvdWxkIGp1c3QgYmUgZmluZS4NCg0KVGhlcmVmb3JlIHRoaXMgY2hhbmdlIHNob3VsZCBiZSBv
ayBmb3IgcG93ZXJwYy4NCg0KQWNrZWQtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUu
bGVyb3lAY3Nncm91cC5ldT4NCg0KPiANCj4gVGhpcyBoYXMgYmVlbiB0ZXN0ZWQgb24gcWVtdS1w
cGNlNTAwDQo+IA0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1
bS5vcmc+DQo+IC0tLQ0KPiANCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBNZW50aW9uIHRlc3Rpbmcg
b24gcWVtdS1wcGNlNTAwDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIEV4cGxpY2l0bHkgY29w
eSB0d28gbWFpbnRhaW5lcnMgYXMgaXQgc2VlbXMgb25seSBNYXJpbyB3YXMgYXV0by1jYydkDQo+
IA0KPiAgIGNvbW1vbi9zcGwvc3BsLmMgfCA2IC0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NvbW1vbi9zcGwvc3BsLmMgYi9jb21t
b24vc3BsL3NwbC5jDQo+IGluZGV4IDVjYzg2Mjg4MTQ1Yi4uNDIzMzM5MGQ3ZGUyIDEwMDY0NA0K
PiAtLS0gYS9jb21tb24vc3BsL3NwbC5jDQo+ICsrKyBiL2NvbW1vbi9zcGwvc3BsLmMNCj4gQEAg
LTc2MiwxMyArNzYyLDcgQEAgdm9pZCBib2FyZF9pbml0X3IoZ2RfdCAqZHVtbXkxLCB1bG9uZyBk
dW1teTIpDQo+ICAgCQlpZiAoc3BsX2luaXQoKSkNCj4gICAJCQloYW5nKCk7DQo+ICAgCX0NCj4g
LSNpZiAhZGVmaW5lZChDT05GSUdfUFBDKSAmJiAhZGVmaW5lZChDT05GSUdfQVJDSF9NWDYpDQo+
IC0JLyoNCj4gLQkgKiB0aW1lcl9pbml0KCkgZG9lcyBub3QgZXhpc3Qgb24gUFBDIHN5c3RlbXMu
IFRoZSB0aW1lciBpcyBpbml0aWFsaXplZA0KPiAtCSAqIGFuZCBlbmFibGVkIChkZWNyZW1lbnRl
cikgaW4gaW50ZXJydXB0X2luaXQoKSBoZXJlLg0KPiAtCSAqLw0KPiAgIAl0aW1lcl9pbml0KCk7
DQo+IC0jZW5kaWYNCj4gICAJaWYgKENPTkZJR19JU19FTkFCTEVEKEJMT0JMSVNUKSkgew0KPiAg
IAkJcmV0ID0gYmxvYmxpc3RfaW5pdCgpOw0KPiAgIAkJaWYgKHJldCkgew0K
