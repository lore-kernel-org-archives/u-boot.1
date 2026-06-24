Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFB9CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 09:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F5E2846E1;
	Wed, 24 Jun 2026 11:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RZMnRjwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F70E847C8; Wed, 24 Jun 2026 11:29:21 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E79380398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 11:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.remmet@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iopYRsTOf9EsaNfEf9caYlWbGKoCSRQX0J0Xzfy0h6jjZo4mZcf8CeAyxnZEmQr3prNCY3iottTD9MG9QY6pu3KA1CqB5M3N0FFDj+4qqPtJgj0wB/3IWHR0tZTiGGh85sMkacZ+IzIAH24fI4+SBKO/xoGzFvzgd+3Q/H+PIgkz/JL1QbWBsK15IXpXi2/0YcQDkYGV60IztzOkOffXGY6oPL0A0szP2FL2j0NlJ77dMcRM7dVMsETwtRL4Y5PdzqaZ6G6rlr6U30OKr84iFgo7HCfczJsgLp/udGt7l2NESHewUdU0tRgGhPaYLaK0tdYGSd1A1r3UoHMuXUJK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T75jIsV2okNLoKfWp/hbRgokIzkaMy22OD6nKH4dvU=;
 b=n3MeiziZGjR7IGEWBI5W6NaRWEcaOgB0kuacfeIHPwSZb6/3WYTIpksxH2IXizR8cYQ+Qte+82qey+evasc93znGiVqSw0MP3QuF4gForOGhQsP3dSW1pi2PDYxsiHiUyn/+tN+SYYS/yEoQ99if4X8e1OD1qVzVeNgaC0h1LHZ6f3cVYamEbUlXNJeBhvn7HIalpIJONAT9fq34vHZkPKcSfQARJp15gUOfePbFv6LuH0xzuWwvPbUTe251Yzts9JRg9DxsiMRHY+O99lsFnUgAEmcxrHgd29n4x+pHcCFQb8M1sq66jwJXmS0qRXKLZpkKi4lxtLaxiDa1AD/U5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9T75jIsV2okNLoKfWp/hbRgokIzkaMy22OD6nKH4dvU=;
 b=RZMnRjwNkAsEO7TXfiIkmYVj34O1mxVCHIMNLXEnts2FNBcoOQ+QbrDxGV4ny2vDXw2qJ2Zq6fCBvfFO0QAnFOh3S93YQZZ8WwhUtyDYIpTX0/ruy6jIeYOmdaYOo2etvjk7Vn+mr/Q+Hp24xJB/7xrt5OiUSpuvx5yLMCds+L/SGWG+QfLX3pdTN5x037R6NzuUe2CSP20KajutaV6xn2IvCeba7RIr83IUSS96Si/jby/sFv0OWEuYH1PCQ2mE7hukFMjC9q/54395dvyLS5azIa1tdfzDm1MNNAcjnZGQmHGEGmFkD1AwoB3mFYKaJHYE80nZlDgGpEI6ZAS1sw==
Received: from PAXP195MB1231.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1a3::10)
 by DU2P195MB2443.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:46f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Wed, 24 Jun
 2026 09:29:17 +0000
Received: from PAXP195MB1231.EURP195.PROD.OUTLOOK.COM
 ([fe80::ec71:80eb:9e92:9d7f]) by PAXP195MB1231.EURP195.PROD.OUTLOOK.COM
 ([fe80::ec71:80eb:9e92:9d7f%3]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 09:29:16 +0000
From: Teresa Remmet <t.remmet@phytec.de>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "ingo.rah@linutronix.de"
 <ingo.rah@linutronix.de>
CC: "sbabic@nabladev.com" <sbabic@nabladev.com>, Benjamin Hahn
 <B.Hahn@phytec.de>, "b.spranger@linutronix.de" <b.spranger@linutronix.de>,
 "trini@konsulko.com" <trini@konsulko.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "gregor.herburger@linutronix.de"
 <gregor.herburger@linutronix.de>, "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "me@ziyao.cc" <me@ziyao.cc>,
 "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>, Yannic Moog
 <y.moog@phytec.de>
Subject: Re: [PATCH] Board phycore_imx8mm: spl: add 1 and 4GB RAM timings
Thread-Topic: [PATCH] Board phycore_imx8mm: spl: add 1 and 4GB RAM timings
Thread-Index: AQHdAtkOOG0147P5+ESu4FvnH/ToJbZNciaA
Date: Wed, 24 Jun 2026 09:29:16 +0000
Message-ID: <84b2efd77b4218aa392b19474d33a4e7111094ae.camel@phytec.de>
References: <20260623062429.532567-1-ingo.rah@linutronix.de>
In-Reply-To: <20260623062429.532567-1-ingo.rah@linutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXP195MB1231:EE_|DU2P195MB2443:EE_
x-ms-office365-filtering-correlation-id: f45e63e4-e90a-45b5-8bca-08ded1d30fc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|23010399003|366016|376014|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003|3023799007|38070700021;
x-microsoft-antispam-message-info: kexEWijf8EMuw5fbtozccxej9OWlbkbgGJjui2WGdMs2zBLr8SHpAFNCksZVzyhApokd5QMtzlkVCXA5Ajm7uzJ/Q1lMBifAbwmt1mKYyfnXGBAKuBCws4eZYXXIMKwBGPSMnR2TKCpbkLv3qIBhc5yjgvgEOdQrFYprWYRvB0TP0u//zuZZHA1Vrfb7iGZe+hgpnrP2mANXFVBDNevL5j1vsM62/K89I+08TTVatIUc5/ciis1QdUNcj6tTo5hzq5pnBd8xkzn829f2HGrKq+MhjzgN0pODD5zISW4rGW7Q6EeQhxMyVyI8hM1scT+bJCFCjD9gm2G4vshskDJ76DJ8D4UH5sjIUY81N+AlHaG8CQxMGFpKKile0NmyQcDkxQqEAgNjHt5qkEPpAoURT14hGW8WbuNQGQUdtKan0uXKbDDE+dwiyNn0KxuO27DtVX4jhp7zyb9QDzWoN+g/LU8T3HZc3L8wD7n414YWGmfHrY6GHfGAHcBWCHRny9JftOVeT6l6Lh8jaNied4GPqFKDL1QdR3NK/7gdYQfPjETXpzJi/TXSYk+8Z0L7wH+uIuefs2ci+M0PUXC9u8oEmoo18pI1F/MvFYgLhc3yakMeej8pqyFfJX5J+myM3MRhXA+GGiHhT9AQ9UsORozaMlKuUDX32tymaBvkOzKQYtmgStjPxzRgIV5hOA/WXJK9gF4iAL1HDqCWJKrHVCMvDx+JGYF/WSx9N2tZdwKnRRc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXP195MB1231.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajdUOFFKcWVwa3NQZXNLNWdkVGRuL0NJQ3VCTW4rckVCM3VGUk10MUhQQ2Ry?=
 =?utf-8?B?S1NjT3krSnBEaEsxZVBialYyU1lPbzhyVFZ5UE9rMnNGckY1aHN4ejI3MDV6?=
 =?utf-8?B?NzRnQXZQTmx3bGRGbnlFZ2NOMCtJRjBPNi9zVXdzUWFiQVRqZW56RzJnUVNi?=
 =?utf-8?B?ZnBNc25IUVdPWHJpQlJVRStsK05RMml5QXEvSU5Vb3hXR2hDSW5tVVMvczcx?=
 =?utf-8?B?M0dRQVlGUkxBYTlVeGlWb092R2Exa1U1QU80ZFZUZTYxOWw3T0w0bHpKeWtY?=
 =?utf-8?B?REdsaVRWcC94Wmh6SVQ0NTVvcDJseUpMTE9aK240YmtDVlVZRXJWd0R4eWR6?=
 =?utf-8?B?Z3ZkOFM0YVl1dFp0czFRcjdpWFh5aHVDZ1duZ1YrbGw4Z3VZOEsrSkRsdVVS?=
 =?utf-8?B?TnRKRVkzaURGR0VEejRmek9kZldEMUFGQXFBa0hVeXNmdElQU2h2bVNMOEs0?=
 =?utf-8?B?S1I5ZGVWWTNxcmRVUE0rb3dZcDYzVkVNVFFjZ1BmOTZ3U0pjNWJQK0Y2TUR5?=
 =?utf-8?B?REtjUDgzL3cwUEFlNyttZldyL3dMRUZjQjQ5WU5RMXhJM1BtZ0hybTM4cDdB?=
 =?utf-8?B?RDlqWVYzZ0t5dGF3VnpSdzAzTFo1R1JLVUwweVBxSnpyZjFlR2JIWnY0WkFp?=
 =?utf-8?B?TlBQYmRSQ04yMDVPbE5hOGMzemVrUHIyWThwQkdpaTlXOEtoNW9yYWw1NmNy?=
 =?utf-8?B?UEluNzg5RWxQV3pPcnU2bDF0YklHTDNkeUJacGNFVjdBdmtHc05NNmdWWnA4?=
 =?utf-8?B?WnVUOUFxTDdPWCtHM3l6YWFzVk8wcXFQNjdSbGpRWFk1dXJUS01EaktNSjJI?=
 =?utf-8?B?TDA3Z25wYzAxTUJsSHJOTFhCcFVrYWhyMjJlRGFMS1RxSDRJVEdCS2tqbWU0?=
 =?utf-8?B?UVVLSENVZmVFUCtqNWR1bWRIemxuajFGNHNxQ1F4SXZ1NDBjQS9TaU5tMDhG?=
 =?utf-8?B?SG9CK0E0dTVYYUtGdWJnazdEVVY2OHVBY0FKa1AwaXpxQU1nNjYrYm9rcmVR?=
 =?utf-8?B?bGkwZjIvMDNoNkoyWEVhUkNYcVA3aVRIS3Z0SDJaZ3d5ZmRMTS9taEZkcW1R?=
 =?utf-8?B?N2x1Wm84NnB5cWtIa3JJdjVsenloTCtmQzAxT3FjVkd6eTBIYVlkU2U2NlFC?=
 =?utf-8?B?dWtrYVVWRUVPUnlRT2VZVU1MQU5VNmxYUnl2akFmY3NmOG85UWFqdklwZ29Y?=
 =?utf-8?B?aVI0blpJc3VEcXl4NWE1NmEvcldqeHIzS1Fob1pLM3NTWVQ3SEsxZVI5UmFh?=
 =?utf-8?B?eEhTY2FNZk9GclZmVytNSnd0bzJTaEtzZy90OWNrSWdtK3ZYSFFnc3hyM2RP?=
 =?utf-8?B?eVB2S3NSLy9XYWJHbHFiK0JtNFJLdkVsZXB6eXUzVDhmMmw2dGpNdHQyWnpv?=
 =?utf-8?B?aGdGR3lkcEd3TkRxcU5lVjd2UzBONGRnOWJYd2xBd2Zaa1Byd2ZpV3RoOEEw?=
 =?utf-8?B?SlRqNndTOFVvVFNreDVXNUZzZHkrbmFUelI5bmpQS3pHdzAwaU50aDZVRWEz?=
 =?utf-8?B?REoxSFZKUmZ1WXF4MFd1TytGcHRqVitqajJUSnJ0N1ZXZHVuVStlak5rb0J1?=
 =?utf-8?B?MCtlYWNXOHJCYngxbU1iUjB6SEJ4THczOFNwZVRkN2wyVWdER25sVzNnWDFk?=
 =?utf-8?B?SVgwK1YxQmExRVgwSEdZN2M3WTlyTHNmYlIzUHNVcXpGQmg2S1FTTUo3V2VF?=
 =?utf-8?B?bEdOd0pxUmkzTzdHQWhLR2syZm1MRG9IWnVyV25WbXJHODlYVkYySkNxbldn?=
 =?utf-8?B?UDZuL1kyWTh2dW5aR1NPNU92cFRoVWhzM2JZOERrbDVCbUVIRk81dmQ0Z3dH?=
 =?utf-8?B?SUtodkp4RWhsMEN6VmVQcmtDK0lpWUZJdEhDclp3dVh3NG1wMGQ5eE90QU1n?=
 =?utf-8?B?Ulh0SHgrS2t0djlnaW5WZHUyclR4dHNtQ09KTVkyZ2pXcmFxcjBZSHQ4OUZm?=
 =?utf-8?B?UU1WVVB0aWpFQmtIZE94dmk0SDM4N3ZlRGhYRjJocVM2M3lLOWpORE5jK1Iy?=
 =?utf-8?B?azZQQXpaSnhmVU5kdGRzYmUrSnBpWEhocStuNlVacWlYVWhTV3Q0U1ZDZ0Vz?=
 =?utf-8?B?RjRZSzY2VHV1aC9QenFtOTR5OFVwNnZabElucmZ6MjliY0ROblg4QmFhZ242?=
 =?utf-8?B?WHp5d3dvZGk1Tm5TdzBGRFZ3UFg1UE9aZisraVdienYzaEd1aTgwQWdQZ1ZS?=
 =?utf-8?B?djFtbTEzMEZ6RlhXM3VndE5Bb09WUTdGMzVXc0hTSmRPa3pNRlAvSzYyQ056?=
 =?utf-8?B?ZnVyTjFRLzZYdHpwMkp1dUpXVTkyeTFkM3dOZUIwMGdVMkNQaGNEMkUxaXRV?=
 =?utf-8?B?VXFBaVdKbHd3aXg2aGs5VmlYUGpvVWcydzk1d2tTbzl0UXYwRGtvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DEF5A4A7FA9C74AA5F6977F79B9984B@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXP195MB1231.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f45e63e4-e90a-45b5-8bca-08ded1d30fc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 09:29:16.5509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8pMmnAGHbDsi2mI3utGaSqy+hH53I6wCfQnaWkNGGJVudIAls7QHNZ8bXazWZQmXPrvtDKV+SK4BDYTM+giBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P195MB2443
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

SGVsbG8gSU5nbywNCg0KQW0gRGllbnN0YWcsIGRlbSAyMy4wNi4yMDI2IHVtIDA4OjI0ICswMjAw
IHNjaHJpZWIgSU5nbyBSYWg6DQo+IFRoZSBQaHl0ZWMgVGF1cmkgTCBpcyBzb2xkIHdpdGggb3Ro
ZXIgbWVtb3J5IGNvbmZpZ3VyYXRpb25zIHRoZW4gMg0KPiBHQi4NCj4gR2F0aGVyIHRoZSBtZW1v
cnkgc2l6ZSBmcm9tIHRoZSBFRVBST00gb2YgdGhlIHVuZGVybGF5aW5nIFBoeUNvcmUNCj4gbW9k
dWxlDQo+IGFuZCBzZXQgdGltaW5nIGluZm9ybWF0aW9uIGFjY29yZGluZ2x5Lg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogSU5nbyBSYWggPGluZ28ucmFoQGxpbnV0cm9uaXguZGU+DQo+IFJldmlld2Vk
LWJ5OiBCZW5lZGlrdCBTcHJhbmdlciA8Yi5zcHJhbmdlckBsaW51dHJvbml4LmRlPg0KPiBSZXZp
ZXdlZC1ieTogR3JlZ29yIEhlcmJ1cmdlciA8Z3JlZ29yLmhlcmJ1cmdlckBsaW51dHJvbml4LmRl
Pg0KPiAtLS0NCj4gQm9hcmQgcGh5Y29yZV9pbXg4bW06IHNwbDogYWRkIDEgYW5kIDRHQiBSQU0g
dGltaW5ncw0KPiDCoCBUaGlzIHBhdGNoIGhlYXZpbHkgYm9ycm93ZWQgY29kZSBmcm9tIGdpdDov
L2dpdC5waHl0ZWMuZGUvdS1ib290LQ0KPiBpbXggY29tbWl0DQo+IMKgIDAwYWM3NjVkNjAzMiAo
IkJTUElNWDhNLTI4OTMgYm9hcmQ6IHBoeWNvcmVfaW14OG1tOiBzcGw6IGFkZCAxIGFuZA0KPiA0
R0IgUkFNDQo+IMKgIHRpbWluZ3MiKSBhbmQgY29tbWl0IDkzOTYyNDIxZDdiNCAoIkJTUElNWDhN
LTI4OTMgYm9hcmQ6DQo+IHBoeWNvcmVfaW14OG1tOg0KPiDCoCBzcGw6IGFkZCAxIGFuZCA0R0Ig
UkFNIHRpbWluZ3MiKQ0KDQp0aGVyZSBoYXMgYmVlbiBtZWFud2hpbGUgYW4gbmV3IHVwZGF0ZSBv
ZiB0aGUgUkFNIFRpbWluZ3MuDQpDYW4geW91IGNoZWNrb3V0IGRvd25zdHJlYW0gY29tbWl0czoN
CmY1ZTljNGU4Y2I3NCAoImJvYXJkOiBwaHl0ZWM6IHBoeWNvcmUtaW14OG1tOiBVcGRhdGUgUkFN
IFRpbWluZ3MiKQ0KYTJhZWViODJlMWQ5ICgiQlNQSU1YOE0tMzg5MTogYm9hcmQ6IHBoeXRlYzog
cGh5Y29yZS1pbXg4bW06IFNldA0KY29ycmVjdCBSQU0gdGltaW5nIGZhbGxiYWNrIikNCg0KPiAN
Cj4gwqAuLi4vZHRzL2lteDhtbS1waHlnYXRlLXRhdXJpLWwtdS1ib290LmR0c2nCoMKgwqAgfMKg
IDggKysrKysrDQo+IMKgYm9hcmQvcGh5dGVjL2NvbW1vbi9pbXg4bV9zb21fZGV0ZWN0aW9uLmjC
oMKgwqDCoCB8wqAgNyArKysrKysNCj4gwqBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vbHBk
ZHI0X3RpbWluZy5jwqDCoCB8IDI1DQo+ICsrKysrKysrKysrKysrKysrKysNCj4gwqBib2FyZC9w
aHl0ZWMvcGh5Y29yZV9pbXg4bW0vbHBkZHI0X3RpbWluZy5owqDCoCB8IDEyICsrKysrKysrKw0K
PiDCoGJvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtbS9zcGwuY8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8IDI0DQo+ICsrKysrKysrKysrKysrKysrLQ0KPiDCoGNvbmZpZ3MvaW14OG1tLXBoeWdh
dGUtdGF1cmktbF9kZWZjb25maWfCoMKgwqDCoMKgIHzCoCAxICsNCj4gwqA2IGZpbGVzIGNoYW5n
ZWQsIDc2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gwqBjcmVhdGUgbW9kZSAxMDA2
NDQgYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1tL2xwZGRyNF90aW1pbmcuaA0KPiANCg0KWy4u
Ll0NCg0KPiArI2VuZGlmIC8qIF9fTFBERFI0X1RJTUlOR19IX18gKi8NCj4gZGlmZiAtLWdpdCBh
L2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtbS9zcGwuYw0KPiBiL2JvYXJkL3BoeXRlYy9waHlj
b3JlX2lteDhtbS9zcGwuYw0KPiBpbmRleCBlNjg4NzkzYmM3NC4uYzlmMjI0M2M4MTkgMTAwNjQ0
DQo+IC0tLSBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtbS9zcGwuYw0KPiArKysgYi9ib2Fy
ZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vc3BsLmMNCj4gQEAgLTE2LDYgKzE2LDcgQEANCj4gwqAj
aW5jbHVkZSA8bG9nLmg+DQo+IMKgI2luY2x1ZGUgPHNwbC5oPg0KPiDCoA0KPiArI2luY2x1ZGUg
ImxwZGRyNF90aW1pbmcuaCINCj4gwqAjaW5jbHVkZSAiLi4vY29tbW9uL2lteDhtX3NvbV9kZXRl
Y3Rpb24uaCINCj4gwqANCj4gwqAjZGVmaW5lIEVFUFJPTV9BRERSCQkweDUxDQo+IEBAIC00Miw2
ICs0Myw3IEBAIGludCBzcGxfYm9hcmRfYm9vdF9kZXZpY2UoZW51bSBib290X2RldmljZQ0KPiBi
b290X2Rldl9zcGwpDQo+IMKgc3RhdGljIHZvaWQgc3BsX2RyYW1faW5pdCh2b2lkKQ0KPiDCoHsN
Cj4gwqAJaW50IHJldDsNCj4gKwllbnVtIHBoeXRlY19pbXg4bW1fZGRyX2VlcHJvbV9jb2RlIHNp
emUgPQ0KPiBQSFlURUNfRUVQUk9NX0lOVkFMOw0KPiDCoA0KPiDCoAlyZXQgPSBwaHl0ZWNfZWVw
cm9tX2RhdGFfc2V0dXBfZmFsbGJhY2soTlVMTCwgMCwNCj4gRUVQUk9NX0FERFIsDQo+IMKgCQkJ
RUVQUk9NX0FERFJfRkFMTEJBQ0spOw0KPiBAQCAtNDksMTAgKzUxLDMwIEBAIHN0YXRpYyB2b2lk
IHNwbF9kcmFtX2luaXQodm9pZCkNCj4gwqAJCWdvdG8gb3V0Ow0KPiDCoA0KPiDCoAlyZXQgPSBw
aHl0ZWNfaW14OG1fZGV0ZWN0KE5VTEwpOw0KPiAtCWlmICghcmV0KQ0KPiArCWlmICghcmV0KSB7
DQo+IMKgCQlwaHl0ZWNfcHJpbnRfc29tX2luZm8oTlVMTCk7DQo+ICsJCXNpemUgPSBwaHl0ZWNf
Z2V0X2lteDhtX2Rkcl9zaXplKE5VTEwpOw0KPiArCX0NCj4gwqANCj4gKwlzd2l0Y2ggKHNpemUp
IHsNCj4gKwljYXNlIFBIWVRFQ19JTVg4TU1fRERSXzFHQjoNCj4gKwkJcHV0cygiMSBHaUJcbiIp
Ow0KDQpJIHdvdWxkIHByZWZlciBpZiB5b3UgZHJvcCB0aGUgb3V0cHV0IGhlcmUgYW5kIGJlbG93
wqANCmFzIHUtYm9vdCBwcm9wZXLCoHByaW50cyB0aGUgc2l6ZSwgdG9vLg0KDQpUZXJlc2ENCg0K
PiArCQlzZXRfZHJhbV90aW1pbmdzXzFnYigpOw0KPiArCQlicmVhazsNCj4gKwljYXNlIFBIWVRF
Q19JTVg4TU1fRERSXzJHQjoNCj4gKwkJcHV0cygiMiBHaUJcbiIpOw0KPiArCQlicmVhazsNCj4g
KwljYXNlIFBIWVRFQ19JTVg4TU1fRERSXzRHQjoNCj4gKwkJcHV0cygiNCBHaUJcbiIpOw0KPiAr
CQlzZXRfZHJhbV90aW1pbmdzXzRnYigpOw0KPiArCQlicmVhazsNCj4gKwlkZWZhdWx0Og0KPiAr
CQlnb3RvIG91dDsNCj4gKwl9DQo+ICsJZGRyX2luaXQoJmRyYW1fdGltaW5nKTsNCj4gKwlyZXR1
cm47DQo+IMKgb3V0Og0KPiArCXB1dHMoIkNvdWxkIG5vdCBkZXRlY3QgY29ycmVjdCBSQU0gc2l6
ZS4gRmFsbCBiYWNrIHRvDQo+IGRlZmF1bHQuXG4iKTsNCj4gwqAJZGRyX2luaXQoJmRyYW1fdGlt
aW5nKTsNCj4gwqB9DQo+IMKgDQo+IGRpZmYgLS1naXQgYS9jb25maWdzL2lteDhtbS1waHlnYXRl
LXRhdXJpLWxfZGVmY29uZmlnDQo+IGIvY29uZmlncy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sX2Rl
ZmNvbmZpZw0KPiBpbmRleCBlMzRmMTJjYWJmMy4uODY2ZTVkMWRiYjMgMTAwNjQ0DQo+IC0tLSBh
L2NvbmZpZ3MvaW14OG1tLXBoeWdhdGUtdGF1cmktbF9kZWZjb25maWcNCj4gKysrIGIvY29uZmln
cy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sX2RlZmNvbmZpZw0KPiBAQCAtNCw2ICs0LDcgQEAgQ09O
RklHX1RFWFRfQkFTRT0weDQwMjAwMDAwDQo+IMKgQ09ORklHX1NZU19NQUxMT0NfTEVOPTB4MjAw
MDAwMA0KPiDCoENPTkZJR19TUExfR1BJTz15DQo+IMKgQ09ORklHX1NQTF9MSUJDT01NT05fU1VQ
UE9SVD15DQo+ICtDT05GSUdfUEhZVEVDX1NPTV9ERVRFQ1RJT049eQ0KPiDCoENPTkZJR19FTlZf
U0laRT0weDEwMDAwDQo+IMKgQ09ORklHX0VOVl9PRkZTRVQ9MHgzQzAwMDANCj4gwqBDT05GSUdf
RE1fR1BJTz15DQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogZjA3MjYyMGRjOWZmZGEwMGIwMTA3ODNk
YTI3YzQxMjMxYzNhNDM5Yg0KPiBicmFuY2g6IGZlYXR1cmUvcGh5Z2F0ZQ0KPiANCg0KLS0gDQpQ
SFlURUMgTWVzc3RlY2huaWsgR21iSCB8IEJhcmNlbG9uYS1BbGxlZSAxIHwgNTUxMjkgTWFpbnos
IEdlcm1hbnkNCg0KR2VzY2jDpGZ0c2bDvGhyZXI6IERpcGwuLUluZy4gTWljaGFlbCBNaXRlemtp
LCBEaXBsLi1JbmcuIEJvZG8gSHViZXIsDQpEaXBsLi1JbmcuIChGSCkgTWFya3VzIExpY2tlcyB8
IEhhbmRlbHNyZWdpc3RlciBNYWlueiBIUkIgNDY1NiB8DQpGaW5hbnphbXQgTWFpbnogfCBTdC5O
ci4gMjYvNjY1LzAwNjA4LCBERSAxNDkwNTk4NTUNCg==
