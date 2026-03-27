Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2563710F284A
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F2C184154;
	Fri, 27 Mar 2026 17:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="MsscClVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2575F83DA7; Fri, 27 Mar 2026 14:51:04 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAE988394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 14:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jU1jJIyr/tvcprX9WKD7oPeMtlB3iF2z53uV8AVzXK1OLqLiSF0cZBi5wyRgfARiOrFJG+CLdMnlJxRcwZSp/3lfQeyAOzUIrNFfAGE24Q+eMmY4AL+VL8y05XdU87soAkHjrJWbnvWRFDZ8gNwcWIUODijSMr3JL9Ocmr/nMftsYMQ87ay8xYNUL6He1ca1KkTXhisa1Ul3edR55oB4w20iym9mSs1qD42008etn1bZeZv6jCxpx2nMbJ+LUHlGcP4srMACrBRxPp2RKeAWzTGbo7Ox73sf8GSDXBuBBj21mAlzCEV5qO6tI3GrtGfl+0YrejuOIjCDTotf5Z+gVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cZ5vYMd0tCC8HxAWYPrH8G5R82R4cJ740GOtk6aaes=;
 b=qFtDQqWUWJ7pUrg45YR6ZIMq3/Z8pQizrgokMYAgxoS4YxRdFOF3JwG5gKR6FyX/ruBy6EcWgz1W6tBGiuWnBeHKshzYdjPhW7FBYMdDcLYtPgR+7y3iWYyCx7P/F7GpeZ/VJdvGOc6gihUbJDhl0XwptpY7JvsuWkHQ42QxtNTox8IY1o3fyfRThacJK46caJznAVZ2tInxtuYNnW63F4upDD4MphSzSDPTSbuWZKicXp3EYBeu+MhrkfRCHNFgHEzGEoCxlH0oeLWwb9KpP1yFWgV56KgSEeQmWmo4vt/peBwIibhLnjwa5pI0hpY2AKPjAJMCyn9imf/GSaooxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cZ5vYMd0tCC8HxAWYPrH8G5R82R4cJ740GOtk6aaes=;
 b=MsscClVssy7I6qyb06BnsM2VLl+llPiQZ82GObG3CGmDvX6kYTpGIY2Rdz8ZfwOVysIELxV8QJSZDScwQv+w6sG7nw0MGNyM7A+j7IBGH+1MUNyHOm+67rvJLIX7timjY2AhAIliOwIoq4mxhUV8cgJFxV/KDT93B6/9wAeZZy67e/yCuaMWwcz7mIf3PvAyfpWc6hbUdHvhIyLPZDpvXxiBm2idnlbHD6RZv6QoIW1wihg4UFlzxWabq0A1lYOmv289a3ERwPffrEKWywda/TJBT8613ij3x+hYBjT4tXUFF5xI8ZpSL/tV0Fa5GTZ3K+eIvRVeCIO7+jQhTILXpw==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by GVXPR09MB7859.eurprd09.prod.outlook.com (2603:10a6:150:1d8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 13:50:57 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 13:50:57 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: Tom Rini <trini@konsulko.com>, Leo Liang <ycliang@andestech.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 7/8] libfdt: Allow non-64b aligned memreserve entries
Thread-Topic: [PATCH v5 7/8] libfdt: Allow non-64b aligned memreserve entries
Thread-Index: AQHcdOyU+hjYlttjF0usnk+3K9+TBbWy8PSAgABObACAD7g/AA==
Date: Fri, 27 Mar 2026 13:50:57 +0000
Message-ID: <e8ca05f3-f820-45f5-9fff-a4f96c6e71a0@htecgroup.com>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
 <20251224154449.946780-8-uros.stajic@htecgroup.com>
 <abkZr1hBcosqgBZd@swlinux02> <20260317134736.GV502704@bill-the-cat>
In-Reply-To: <20260317134736.GV502704@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|GVXPR09MB7859:EE_
x-ms-office365-filtering-correlation-id: 9ac82ffa-7d55-46c4-9b2a-08de8c07df40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: UZOq92ua35OGQRa13tX6p28ugdsoOpqFeBizsRK2EPfimH0IOmM7Y5moxg/cqGrlL7LBRbRC2mSsb6Yyx0u9jWoT6PvT2EIK6RxIfh1cQjdPWgaSRemJLc3rLqrBnM35Ga2QEc2pf7wJOIobjaIDtGWEwnqZ0d/smPgfBXVh4VAqC1zY8c1u5+sjoJkBrHvR2ImX4Knut6bTTYKbHlGn8LE/htpN4TbQJj+WHRqh1XqMSgEGrh20kqYDWqOIPuZVUGUIHtDoDD5k/a0wLYoYsizNTTKlbH0OXiE+isfNM9lTzHmO8Gt1U9YP6drSajlSLJzNGxveDracEYyTZE85DL+Dbuxu3ur9iMwP+hmbCtRQPGDhLvpXdLZQR1rfmHrzXHgUKEZ1waUAIlwBMKEZOE6Q/YJpo3EzCklK3zMcrzW5Efyz0WaNAKhUm6W1+UH77N2OuMEDWlrdQF5+qQH2az7aqfkizDfvBA+P0B7Mzi1dPRqnu1LtnCuB8nQZv3WGw8dNEivv2pCYmx13eip7uOnNGzni5kr7aUyB0c8w7le04Iuf/booSZb6XQ2F2KY7qB/Gveejd5C3ww9YbRFqlXpZztTTaABRJmTt3xWEyCmz0KG1YrjS2KRsjgRSGmrAKOBOdIxr5PZJb5xXxGOPe7WGMw5BET3UxIjoEWLQRdGQRICavXPecA/rlQYK0FIryepZ8O2737iCIukP2bNelOc2aBiTm02m4w3cfyU5KBS3ymqi4JKstCHMbAC27wTDZS2rr/idL6Olv9S5ZRzcJpFcoKLCyI3fSLrVvG6DVBw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azBOOVo2M2NsYzNiZVkxcmN2bE8xSldteUZqSnRKYjZJcERJc0JOVUgwaFUx?=
 =?utf-8?B?bnlGMkVNSDlFVW5Mc2ZVelBpR0N3SW4yaGRsejdsK2QxeitTaHhOampwdUh4?=
 =?utf-8?B?RnowdmZDMkRudjVzUWwxa2NRaVhtR0dqcE45dXNtcEJZOEg4TGc2blFLcmhu?=
 =?utf-8?B?NlNhdStHZ3pPU0VUdVZFdDFpc09aN29SdVRzVW4vZWhlN1FyOS9OREVSOXBK?=
 =?utf-8?B?U1FyOWZ1RTNZQURaTWpWREllTDVyVFJ3NGdjam42cU1nSml0bFZXbkNvcEdC?=
 =?utf-8?B?S3p6eXVWNGRtTFVPaHpRMDZOa3hyY1VrdHNWNzdMNzNTdW8xVWwxRXdpQTZT?=
 =?utf-8?B?ZEdUSXo3SU1OZ0t5NUJRcnQraGpCVzFjbUM0cnhwTnZlOCtIZjFtZXA3Vit0?=
 =?utf-8?B?SHRPUVpaZUhXTGFtOENIWDBkcVFUR1dGa2QrRFVLYXNraWY4T0ltYXRjY1Zj?=
 =?utf-8?B?ak43b1dPVmN2bVlLeDJmeE55RHA2OWw4dnBPZ2k1VUZvY1ZlOU1PVmV0Zzd5?=
 =?utf-8?B?TkwxRTVadnBPckVEeEdCTitOTzBuVnF1RFg1WmxPZjdXdWwrempCeW0yN0xM?=
 =?utf-8?B?aXhiUGp1QTRNY0ZnTkVoZ2VlUEUySENsbk9wUExqUXRQQ1lSZ0pQMHBidXhQ?=
 =?utf-8?B?R0VjbEs2QVUyOGdJS0JlN2ZXMkVERE9RUUs1N1BETjl5RWNEWGs0U2pKejU1?=
 =?utf-8?B?SmRWdE4zcFBKVVFaSGgxdEJOQUFiT1krWE1Jd1ZHYWJKUFFKT1BLSCs0eHlM?=
 =?utf-8?B?RVVQVWxXdVVia3FhRE9RQThxeVJHUHRreUk4S0w2S2NYOGEzV1dtTW9aNTQx?=
 =?utf-8?B?V1RKMURmSHllMi9sdGlLNE9CaVl2c1JJQ1BDNlUwV2l4bjZDamlSWURQTDZv?=
 =?utf-8?B?K1RNSFZzQTgyYjcrTGFpUWJDV1RvdXFhRmwwNkZlQnZEeHlkL3cxRHJyb2sy?=
 =?utf-8?B?VVl3djNVTko1TmJTTE9FVDVaUzZRNTUyaURIaHdRVTMyR3FyTzJqZno1U3l3?=
 =?utf-8?B?QTJHUGFIVGxtWGVHRUx5MWU5N1ZWWkV4VG9ScFUzd2llUkRvemxTSTZUN0E0?=
 =?utf-8?B?Z3lzWktaY1BRalpmaGplV0l4cHl0dVhFQ1lpOGQxVnd2VlpyQ2VJQnZlc0ZW?=
 =?utf-8?B?TGNzTm9JWndlMXJCMWdabmFBSVRPd2JCbjVEcHBSMU1vcDMzWmZFTjZGdWVa?=
 =?utf-8?B?YlgzaDE1M3BHaURBTlBCQ0JYL08xTlFxNmdrdXlsMmdGSW80Z3plK1pWUm5j?=
 =?utf-8?B?NTVtenRMbnFDeVBsYnhJUm0vUkFwSmhkV3JjYXNwYW5ZU05DTEhYUzBrclVZ?=
 =?utf-8?B?VldpMlh5cEQ4NWtSNGhDT1hWWFp0S3p0ZEdNSzlja0RyQUI2MmFJeUdMUkJj?=
 =?utf-8?B?SnNNb2ZjcGtJSFdtbGZ4TmJiMTVkY2FFV3pmdlBYc3EyZU5oaXNhWmU0cFRx?=
 =?utf-8?B?c3dJRGppWXR5VW02WjFFdWJoT1dyanEzY2txTDYvamdaSWtCK0dKY1lDL1Vn?=
 =?utf-8?B?bFlnK1RkZmhWQ3UxSHhqbTV5OEZxZ0RYZzZVb2lGVURVMS9qQkI0WTRKTTBh?=
 =?utf-8?B?UVRRekhWYWluSWZJd0toeVJCL0U2K1ZkMXJjRm5hZlY5cU5CVWJVUE9TalJH?=
 =?utf-8?B?RzdiV1RIWWFUUnIzNW4xRk1jS2ZlQ0NkZ2FTSlMzNk8wNCsvT0xJOW4yd2RJ?=
 =?utf-8?B?bVFIVnNBdE5tcHRmZkg5MU1PUWlvUWJNZnNQZlQxMUU2TExha3pXcmVEdEhJ?=
 =?utf-8?B?NDYyY2xVcEpTd2xFS0ZFUlFnRGM2SjQweisyalRjZWduZjNWL09vNnM2aVcx?=
 =?utf-8?B?TkpQb2x0YzcwS2wvOHlpcENRRG03dlVucDF0RTZJQWZJWHk1Qk90M0J5WFFL?=
 =?utf-8?B?SEFZNCtRUUpybDJwek1pU1lRN3pScjVKeFFpMDdlYzJRWVgvVkp1WXJycERw?=
 =?utf-8?B?Z2E4RlNGTjNONU50dVFsaERCNzUxTUVjbWFsTGhYQWtOWERaU0VBeVJSVjEw?=
 =?utf-8?B?c0RvVUpsbFhwdmV5Vm42a3czZHczOVZBckIzVmpVemgwT2psUUNYeXpKTG1W?=
 =?utf-8?B?ZzVES1RrKy9FWitBVlRzWUpIWHJhR01TMWgwNHF6MS9xSnQyVDQzWW9TY3F2?=
 =?utf-8?B?SWVDRTBRd1pZck95Z3JWRlJ2QWRTc3hEdUQxUysyNXg4NTY3M0hrTFkzd2xh?=
 =?utf-8?B?RnpUZkpLZmkySEl2alBudW1HYkFDRU5BNEplaS9VeHZNSmdZcmZtWStLWHlT?=
 =?utf-8?B?Vks2ZWk2S0FKVXNnZFN4MW1jOTVMNDRoRXNremFGK0FRdmtwcXdsbGcwdm5v?=
 =?utf-8?B?aWJETVgvQmdXV0lJR2w2Umh4ZXlCbEtTNEh2K0J3VGtuazhIVTY1ZHp5cFZr?=
 =?utf-8?Q?6mH2DtuR/ADoZyw0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A56B4B0D0375DF4F84405B4E31DAA626@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac82ffa-7d55-46c4-9b2a-08de8c07df40
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 13:50:57.0227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cd419KpACR7sFE5WLn9lvqY7WAT/UV6de/HcqET5BAWcK70a7ME81cAt4UdqJjuQFK6j/K9mnvFviKSa7CPz6jcKSaCFrBY3EpcBudqFo7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB7859
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:54 +0100
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

SGksDQoNCk9uIDMvMTcvMjYgMTQ6NDcsIFRvbSBSaW5pIHdyb3RlOg0KPiBPbiBUdWUsIE1hciAx
NywgMjAyNiBhdCAwNTowNjo1NVBNICswODAwLCBMZW8gTGlhbmcgd3JvdGU6DQo+PiBIaSBVcm9z
LA0KPj4NCj4+IE9uIFdlZCwgRGVjIDI0LCAyMDI1IGF0IDAzOjQ3OjE3UE0gKzAwMDAsIFVyb3Mg
U3RhamljIHdyb3RlOg0KPj4+IEZyb206IENoYW8teWluZyBGdTxjZnVAbWlwcy5jb20+DQo+Pj4N
Cj4+PiBBbHRob3VnaCBtZW1yZXNlcnZlIGVudHJpZXMgaW4gYW4gRkRUIGFyZSA2NC1iaXQgYWxp
Z25lZCByZWxhdGl2ZSB0byB0aGUNCj4+PiBzdGFydCBvZiB0aGUgRkRULCB3ZSBjYW5ub3QgZ3Vh
cmFudGVlIHRoYXQgdGhlIEZEVCBpdHNlbGYgaXMgNjQtYml0IGFsaWduZWQNCj4+PiBpbiBtZW1v
cnkuIFRoaXMgaXMgZXNwZWNpYWxseSBjb21tb24gd2hlbiB1c2luZyBhIEZJVCBpbWFnZSwgd2hl
cmUgdGhlDQo+Pj4gYWxpZ25tZW50IG9mIHRoZSBlbWJlZGRlZCBEVEIgY2Fubm90IGJlIGNvbnRy
b2xsZWQuDQo+Pj4NCj4+PiBPbiBzeXN0ZW1zIHRoYXQgZG8gbm90IHN1cHBvcnQgdW5hbGlnbmVk
IDY0LWJpdCBtZW1vcnkgYWNjZXNzZXMsIHRoaXMgbGVhZHMNCj4+PiB0byBmYXVsdHMgd2hlbiBh
Y2Nlc3NpbmcgdGhlIG1lbXJlc2VydmUgc2VjdGlvbiBiZWZvcmUgdGhlIEZEVCBpcyByZWxvY2F0
ZWQuDQo+Pj4gVG8gcmVzb2x2ZSB0aGlzLCBjb3B5IHRoZSA2NC1iaXQgdmFsdWVzIGludG8gc3Vp
dGFibHkgYWxpZ25lZCBvbi1zdGFjaw0KPj4+IHZhcmlhYmxlcyBiZWZvcmUgYWNjZXNzaW5nIHRo
ZW0uDQo+IFllcywgYW5kIHNvIHlvdSBtdXN0IGFsaWduIHRoZSBkZXZpY2UgdHJlZSBmaXJzdC4g
V2Ugc2hvdWxkIGhhdmUNCj4gYWRkcmVzc2VkIGFsbCBvZiB0aGVzZSBwcm9ibGVtcyBpbiBjdXJy
ZW50IG1hc3RlciBub3cuIElmIHdlIGhhdmUgbm90LA0KPiBwbGVhc2UgZXhwbGFpbiB3aGF0IHRo
ZSB1c2UgY2FzZSB5b3UncmUgZW5jb3VudGVyaW5nIG5vdyBpcy4NCj4gDQo+IFtzbmlwXQ0KPj4g
SGkgVG9tLA0KPj4NCj4+IFNob3VsZCB3ZSBhY2NlcHQgdGhpcyBwYXRjaCBpbiB1LWJvb3Q/DQo+
IE5vLCB3ZSBjYW5ub3QsIHRoYW5rcyBmb3IgY2hlY2tpbmcuDQo+IA0KPiAtLSBUb20NCg0KVGhh
bmtzIGZvciBjaGVja2luZy4gV2l0aCBjdXJyZW50IG1hc3RlciBJIG5vIGxvbmdlciBzZWUgdGhl
IGlzc3VlIHRoYXQgDQpvcmlnaW5hbGx5IG1vdGl2YXRlZCB0aGlzIHBhdGNoLCBzbyBJIHdpbGwg
ZHJvcCBpdCBmcm9tIHY2Lg0KDQpCZXN0IHJlZ2FyZHMsDQpVcm9z
