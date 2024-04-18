Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97ABEC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 16:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E75B288668;
	Thu, 18 Apr 2024 18:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=csgroup.eu header.i=@csgroup.eu header.b="PfkZ2GM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A11908866E; Thu, 18 Apr 2024 18:03:33 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABB68885E5
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 18:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QV0xVJFoCf0EYS34+pyoKO/1b9KcS0Uqe9f7HlZq0fjJzsJTrYjfNKAw0DNHiyjhrzAlyisyz2NHs+R84zDkpJX2jSXD+MoAORe2rnQKi62emGWn3P/zwSq/ZIlCE6LwqvGD4RbHECMcIqmDOCKuU86wrqs3oDbyT1DUx3Mer/bAMwTMTeB3+LgLDnAcyR81uI9R09YdtL8rF6inJYeYnwaq8v89NvfwgwGnS4xYkxIocY/8zBmMU2F3iK5zxCUBY1BUZc1JSewizN3o3rQ9M/ckdMO09TxW7RlqSF9+Hbn587bkmnTYuGdh1CnMwS1EZPI54nU7/n2AMQ4n/Zu8SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCQgMgrOuxjAQFKnTweKZaYipzVFAQWmtozjXUNXvxs=;
 b=YzK+ntp1jJSmT1YOI44zPBszKhE0uZxHPhPbP5hj7U7VWgUBgP3gyDTcPLxOvQwJZT1AjlvVWoUtCwo4ZFE4r8qaLIq6MFuQyvA4KHxGZRyMV63y3zU0vMMZrcYMJ35Ob3ZyJKSM0cK96Y0SOGW6CnhlLdqMcDKYoVNkTs1ln6RkN1pZs8knMc1njLXIT5D/fk8z7Y5osfgr2/csz2GgqRmS8Yu/4eLGu3K+jVoyKqfOsa1jw4XPgouaAgP9MvoScgfQOh892prREBKXh3fEBk24OtX2vBFTIcHU8e1havIVA8u7KTU5dTWDUbDllWNmp3LyE+io25L5AuoXr9GSFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCQgMgrOuxjAQFKnTweKZaYipzVFAQWmtozjXUNXvxs=;
 b=PfkZ2GM04o+a2ipRvbHbbu4Ly/3/6vLTxY6lJvrDJ9s+cCPMjE0/Dgy5LOXxC21vjJ4iEJaccoLEihVizKKnqeKTbB/9qQ4+5HSPOHfg4MmZofwySypD4lIXLpaO7gOiyqnF17tLfKt78rSXvuCxOhvkqhbkw2Z3vlXYzLU6i8EfY5IywJmLezLVwQgLMEqqbCujrObUFyNUtNeuQSFMtSBnDRALFsqZdbLdtEf6xZoDf4mOFxN31U0ZLABxCqIclXbVlPsD7t8fTFQ8Ciizi56d+i1t0lLo7CN4fR0Advdxy8H3+LxR2lwqFPoVag3OVKzGearn+YbELQLJUk3TTA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3422.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:149::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.51; Thu, 18 Apr
 2024 16:03:28 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:03:28 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: CASAUBON Jean-Michel <jean-michel.casaubon@csgroup.eu>, TRINH-THAI Florent
 <florent.trinh-thai@csgroup.eu>, DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>
Subject: [GIT PULL] Please pull u-boot-mpc8xx
Thread-Topic: [GIT PULL] Please pull u-boot-mpc8xx
Thread-Index: AQHakanz4f28keYlLkiMdTAcu+8xPQ==
Date: Thu, 18 Apr 2024 16:03:28 +0000
Message-ID: <c7025d62-5cd9-445b-90aa-506c20228834@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB3422:EE_
x-ms-office365-filtering-correlation-id: 19f2e96e-f4bb-419d-a6d8-08dc5fc115f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H+0xygndwiDyUhKW8+2fkPtRl4FFUApzEvHtdZLb+FNeirXgrOEg0UM0jB2DpIrRRpmf01/azqma7XmkuzO0hb3jqMgUlPfiSM0O03ISd5tESVEYFtEVOs9uEOghhnKoqqyqAvPw6qHfcNv7Btb3eCxZIEJ9+D13gS96v5mKlWEpZ/XsmSAMJ4JZ9lpdPX4ZSmKnQoH5ZBFeqVl/vhkh40n0g+EcUGq5NSB2kYiJ5LCorgFNmJxYVfV4TPSw3n/0vVBDnHdDlQzeRlGLG5aBafE4mlWm0FOZostdHNjaBE2DSKgAyffULfn8CgvCiiCoaepeE0EHKirCojAqM7l7TN3gE0XT1iA+pd77W6jsX0o8NUQj2h68JxiHX9cJykza+5GesWpN85P6igN8qOr6Ww2gShNIaofKG6xmcu5EeBMq88qzkl/pwsffbX+fa+KSywE0q170ql4yFiI8nJYzJshoZP+g67FTv65VLAuU/AtIcXZLplVabw7SmbJk7kVqwGNuDrohBSCqVwVeZE2tabr9XYybz05Z0C5kO/bx0cIC8c4C5nFTyar6xREjRoyZA67HVavX37fkxkiqFHc3m++CKu+kT0q4560pX1vHBz5RNe4UJYBye/w8VR9lCXEdFx61Dhvu6WpQN4jsVHAqo393YFvOrwp+VsydYESvf6OulymHdhQkjPBu9i+wguhHyjHDjzRKt3JqtIK3YwtCsHRelnvHtr0oDYG4mLHlP7Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXkvcEtQakdDNzFnd3d6ejJwdyt6RkFOam83Q1dBN05mcDJZM1I4R2JiRUcr?=
 =?utf-8?B?SCtCK3doVGxMbE1EOFU3T1EvQWk3ZERmSkZsbnBZMkIxRFd6WmVtdm8ya3NU?=
 =?utf-8?B?V1VaWTJqUy9XeGxLOGt0ZytjN2MrSXBmTmk4Vis3WmNBemxmd2xlVmt3RWtm?=
 =?utf-8?B?aHFOS0JYZG5hK0Y5UU1yRm0rWU1McDk3dkRyYk9xL1o0SVJXL0d1SUxUZCt5?=
 =?utf-8?B?bVRhdE5uSk9jTzlvREpaUjFTd2xHVHpoZWxuWGZyajlPbUFsUm8zWUNrTGx2?=
 =?utf-8?B?M3I1ZFU1NGZhcGZ3MFd5NzZ6eWlpRC91WnFrVC9WZGhla2hKUkZOMUk3QTJ6?=
 =?utf-8?B?cytEZVVNUnFQMEFIZTFUTTUvZWM0VHBMS2EyYmhjTzR1NVZTMUtmQjhkMzhh?=
 =?utf-8?B?RVhxTUVwdUkzb0MzQlFOTHQrT05RRU0rMHFFdC9tRkQ2UFdid1hBcHdwa1pQ?=
 =?utf-8?B?aWFuK3BMelI0OFRwazNPMWxRRHlDNDRjMkpZMTU0dk1sZGlaSFJlR0d1QktR?=
 =?utf-8?B?UUY0OTJUZHBzNmtQVDJKK05ZVlpITGp2V25zNVhuRWZ3dEtmeDNVdDU1d3dh?=
 =?utf-8?B?WkMzV0tiYmovYWFXVURlMWJUVldETHdFTm1jUi9tWlllUTN0akZSRnhjdEJJ?=
 =?utf-8?B?RXZtemQ4QW9wVnFWNW42TXRXRFAyNlhLZG96RnFuOHptN0Z3Z1pibkE0SVls?=
 =?utf-8?B?OUR5UmplV0VGd2MrcExzU2duMWFNaTl0VmlxL0tTYU4xQXNsWWUyU0oyQ1pI?=
 =?utf-8?B?N2FSTnRKclJHUDVSU0FPUnppbTBsK3NYalQ3QkJOSWZKR2I4ekN5amhGdnYr?=
 =?utf-8?B?THozUndGUE04N1FObnhnM0U3UFBpb0pjRU4zN2RRcTFRckJab2g4Uk5zOHVN?=
 =?utf-8?B?QTQzNCtkMmJwdmJOU3JJNkJ2aWp6SlNZYTN3TVptN3M0NXBrbFZQbXhkU3FD?=
 =?utf-8?B?UEs5TFYvOEVjQmV5dDhjdUJSSGdQYW9FTEp3MVo1UmNuK3RDL2V2V1B4TzBY?=
 =?utf-8?B?RHlVSE04dkR4VkZSSEJCbjJabzg5QllFQjA3dEk2MFdKbmppcU5wOHZBNmtv?=
 =?utf-8?B?TExQTldUUmJIdTJ2TTkwdWpHT1JiS3FyK3RabnVhRjZEMExlZGtTckc0Rjgv?=
 =?utf-8?B?Wld3T25pSDNIZnpZdFd2eis5RHFOUFVUdlZtWEc0VHlLMUZuaGxSdkZOZHg1?=
 =?utf-8?B?aEZUc1ZxOC9LMTVmclF2a1UyUUVZRFBVMVRpMXRVQmhWYWVGKyt2WWhrR1lo?=
 =?utf-8?B?VzlKMXFScm41TCs5OGNNWFF4dXgwb2h5cmNjejRMdkZjeEJvOVFBVmNhcEcz?=
 =?utf-8?B?K0NnVnQza2M1RGNsTG1SQ0FEYkduZ2pMMkR1eXNOVFNQNEs2a05iQTlWdWln?=
 =?utf-8?B?UmJ5c25WRzdtc3g0bjNyaUxoTzhGNGxLeGgwalA4WmEvQkM3a3VqTytCVVEy?=
 =?utf-8?B?NzdvbkF2MXlxUE1JNW81NGtvcGREZ0VwcDh4MkRrT0ZydEpseDN4N2Z1MkZS?=
 =?utf-8?B?MHZ0UVBpSVd4RkpSdk5rZEloNnVONitLcG1GY2xEbC9KczAxUmh6blhwS1R1?=
 =?utf-8?B?bnk1a3pQaXIvZUR1QUZtK0R2b2k5WXpTM21iUytULy9YZnpRdDZHcHk4M1pF?=
 =?utf-8?B?dnJlKzdmL2lxRW1FTkY5Sk41QWxLMTlvWkUybWJmU1UrNGFaMDVhWllBd29N?=
 =?utf-8?B?MlpuSFg3eStUWE96dXdKcUVXd3QwRzIzTlJCeENOM3ZOUDNmRkpJVXJZa3FY?=
 =?utf-8?B?b0o0UG5SeUkrc1VTSEUwUWRxV1FONU5TcFRLTTFYSkx1ZVFFYmNmQm1rODNK?=
 =?utf-8?B?SDFtMzZzV1NubGNVb0plS0lXYVVzMUQ5TEsvazdlRGNlSEh5Zyt0QWlZWEY0?=
 =?utf-8?B?eHBSTHJUWDRUS3ovUUV6dVE2TGJOQVEzNU9PM0FKcnF2WXVuNyszK3E0Zmo3?=
 =?utf-8?B?cDN3OURvK09mTmI0WTdLTStvNVBDZHhNUVZNVGNRQ2xaUGJUTTM2Q2YwRGpI?=
 =?utf-8?B?N3hPTy9yUHlVZDlwUWFiSEJka1N5ck93dWNjWFVTRm5peWFKQ1NmZ1BKR3FZ?=
 =?utf-8?B?YVlTeWVud0E1NG12ejNkcFJRYmRaLzlzay96OXpKK2VhaW9tS1Q4clQzVm5z?=
 =?utf-8?Q?7p/PbP+MOtsw4bHCn0JwJ7hFz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ABB556DEAB4EA48AFDE8245756EBF28@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f2e96e-f4bb-419d-a6d8-08dc5fc115f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 16:03:28.1250 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0heQELFemCbMbVLt7o22VLHn4MXUp7kkb3tJmCXrWOKL578sdwtJJy93WG+PvhgVm3N1Uswn7KHAFDK6iSUpPR4zAVnwmxQhlXoOvbISFhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3422
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

SGkgVG9tLA0KDQpUaGlzIHB1bGwgcmVxdWVzdCBhZGRzIHN1cHBvcnQgZm9yIHRlbXBlcmF0dXJl
IHNlbnNvcnMgZXQgRlBHQSBsb2FkaW5nIA0Kb24gYm9hcmRzIGZyb20gQ1MgR1JPVVAgRnJhbmNl
Lg0KDQpDSTogaHR0cHM6Ly9zb3VyY2UuZGVueC5kZS91LWJvb3QvY3VzdG9kaWFucy91LWJvb3Qt
bXBjOHh4Ly0vcGlwZWxpbmVzLzIwNDE2DQoNClRoYW5rcw0KQ2hyaXN0b3BoZQ0KDQpUaGUgZm9s
bG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDJjM2ZhNGI4YWRkM2NiNmE0NDAxODRhYjY3ZGVi
YzY4NjdkMzgzYzA6DQoNCiAgIHNhbmRib3g6IGRvbid0IGNhbGwgb3NfY2xvc2Ugd2l0aCBpbnZh
bGlkIGZpbGUgZGVzY3JpcHRvciAoMjAyNC0wNC0xNyANCjE3OjA2OjE2IC0wNjAwKQ0KDQphcmUg
YXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICAgZ2l0QHNvdXJjZS5kZW54
LmRlOnUtYm9vdC9jdXN0b2RpYW5zL3UtYm9vdC1tcGM4eHguZ2l0IGZvci0yMDI0LjA3DQoNCmZv
ciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA3NDFlMzBlOGMyYjgzN2RjOTJlZTJlZWRlYzU0
NzhhZmRkODNhMzE2Og0KDQogICBib2FyZDogY3NzaTogUmVhZCBhbmQgZGlzcGxheSBNQ1IgYm9h
cmQgYWRkcmVzcyAoMjAyNC0wNC0xOCAxNTo0Nzo0NiANCiswMjAwKQ0KDQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpDaHJp
c3RvcGhlIExlcm95ICgxMyk6DQogICAgICAgYm9hcmQ6IGNzc2k6IEZpeCBTUEkgbm9kZXMgaW4g
RFRTDQogICAgICAgc3BpOiBtcGM4eHg6IEFkZCBHUElPIGRlcGVuZGVuY3kNCiAgICAgICBzcGk6
IG1wYzh4eDogRml4IHRyYW5zZmVydCB3aGVuIGlucHV0IG9yIG91dHB1dCBidWZmZXIgaXMgTlVM
TA0KICAgICAgIHRoZXJtYWw6IEFkZCBzdXBwb3J0IGZvciBUSSBMTTc0DQogICAgICAgYm9hcmQ6
IGNzc2k6IEFkZCBzdXBwb3J0IGZvciBTUEkgYnVzIG9uIE1DUjMwMDAgYm9hcmQNCiAgICAgICBi
b2FyZDogY3NzaTogYWRkIHN1cHBvcnQgZm9yIHJlYWRpbmcgdGVtcGVyYXR1cmUNCiAgICAgICBw
b3dlcnBjOiA4eHg6IFNldCBTRE1BIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXIgY29ycmVjbHkNCiAg
ICAgICBzcGk6IG1wYzh4eDogQWxsb3cgdHJhbnNmZXIgb2YgbW9yZSB0aGFuIE1BWF9CVUZGRVIg
bGVuDQogICAgICAgc3BpOiBtcGM4eHg6IFVzZSAxNiBiaXQgbW9kZSBmb3IgbGFyZ2UgdHJhbnNm
ZXJzIHdpdGggZXZlbiBzaXplDQogICAgICAgc3BpOiBtcGM4eHg6IFNldCB1cCBzcGVlZCBhcyBy
ZXF1ZXN0ZWQNCiAgICAgICBib2FyZDogY3NzaTogVXNlIEhBVkVfVkVORE9SX0NPTU1PTl9MSUIg
bG9naWMNCiAgICAgICBib2FyZDogY3NzaTogTG9hZCBGUEdBIG9uIE1DUjMwMDAgYm9hcmQNCiAg
ICAgICBib2FyZDogY3NzaTogUmVhZCBhbmQgZGlzcGxheSBNQ1IgYm9hcmQgYWRkcmVzcw0KDQpI
dWdvIER1Ym9pcyAoMik6DQogICAgICAgYm9hcmQ6IGNzc2k6IEluaXRpYWxpc2UgcG9ydCBGIG9u
IE1JQUUNCiAgICAgICBib2FyZDogY3NzaTogUHJvcGVybHkgaW5pdGlhbGlzZSBNQUMgYWRkcmVz
cyBmb3IgZmlicmUgb24gQ01QQzg4NSANCmJvYXJkDQoNCkplYW4tTWljaGVsIENBU0FVQk9OICgy
KToNCiAgICAgICBib2FyZDogY3NzaTogRml4IE1DUjMwMDAgYm9hcmQgZW52aXJvbm1lbnQNCiAg
ICAgICBib2FyZDogY3NzaTogQWxsb3cgdXNlIHdpdGhvdXQgSFVTSCBzaGVsbA0KDQogIGFyY2gv
cG93ZXJwYy9jcHUvbXBjOHh4L2NwdV9pbml0LmMgfCAgICA2ICsNCiAgYXJjaC9wb3dlcnBjL2R0
cy9jbXBjODg1LmR0cyAgICAgICB8ICAgMTggKy0NCiAgYXJjaC9wb3dlcnBjL2R0cy9jbXBjcHJv
LmR0cyAgICAgICB8ICAgMTYgKy0NCiAgYXJjaC9wb3dlcnBjL2R0cy9tY3IzMDAwLmR0cyAgICAg
ICB8ICAgNDEgKw0KICBib2FyZC9jc3NpL2NtcGM4ODUvTWFrZWZpbGUgICAgICAgIHwgICAgMiAr
LQ0KICBib2FyZC9jc3NpL2NtcGM4ODUvY21wYzg4NS5jICAgICAgIHwgICAgNCArLQ0KICBib2Fy
ZC9jc3NpL2NtcGM4ODUvY21wYzg4NS5lbnYgICAgIHwgICAgNCArLQ0KICBib2FyZC9jc3NpL2Nt
cGNwcm8vTWFrZWZpbGUgICAgICAgIHwgICAgMiArLQ0KICBib2FyZC9jc3NpL2NtcGNwcm8vY21w
Y3Byby5lbnYgICAgIHwgICAgNCArLQ0KICBib2FyZC9jc3NpL2NvbW1vbi9NYWtlZmlsZSAgICAg
ICAgIHwgICAgOCArDQogIGJvYXJkL2Nzc2kvY29tbW9uL2NvbW1vbi5jICAgICAgICAgfCAgIDQy
ICstDQogIGJvYXJkL2Nzc2kvbWNyMzAwMC9NYWtlZmlsZSAgICAgICAgfCAgICAxICsNCiAgYm9h
cmQvY3NzaS9tY3IzMDAwL2ZwZ2FfY29kZS5oICAgICB8IDk3NzggDQorKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCiAgYm9hcmQvY3NzaS9tY3IzMDAwL21jcjMwMDAuYyAgICAg
ICB8ICAgNTggKw0KICBib2FyZC9jc3NpL21jcjMwMDAvbWNyMzAwMC5lbnYgICAgIHwgICAgMiAr
LQ0KICBib2FyZC9jc3NpL21jcjMwMDAvbWNyMzAwMF9ncGlvLmMgIHwgIDEwOSArDQogIGNvbmZp
Z3MvQ01QQzg4NV9kZWZjb25maWcgICAgICAgICAgfCAgICAzICsNCiAgY29uZmlncy9DTVBDUFJP
X2RlZmNvbmZpZyAgICAgICAgICB8ICAgIDMgKw0KICBjb25maWdzL01DUjMwMDBfZGVmY29uZmln
ICAgICAgICAgIHwgICAgOCArDQogIGRyaXZlcnMvc3BpL0tjb25maWcgICAgICAgICAgICAgICAg
fCAgICAyICstDQogIGRyaXZlcnMvc3BpL21wYzh4eF9zcGkuYyAgICAgICAgICAgfCAgMTEzICst
DQogIGRyaXZlcnMvdGhlcm1hbC9LY29uZmlnICAgICAgICAgICAgfCAgICA2ICsNCiAgZHJpdmVy
cy90aGVybWFsL01ha2VmaWxlICAgICAgICAgICB8ICAgIDEgKw0KICBkcml2ZXJzL3RoZXJtYWwv
dGktbG03NC5jICAgICAgICAgIHwgICA1MiArDQogIDI0IGZpbGVzIGNoYW5nZWQsIDEwMjQ0IGlu
c2VydGlvbnMoKyksIDM5IGRlbGV0aW9ucygtKQ0KICBjcmVhdGUgbW9kZSAxMDA2NDQgYm9hcmQv
Y3NzaS9jb21tb24vTWFrZWZpbGUNCiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJvYXJkL2Nzc2kvbWNy
MzAwMC9mcGdhX2NvZGUuaA0KICBjcmVhdGUgbW9kZSAxMDA2NDQgYm9hcmQvY3NzaS9tY3IzMDAw
L21jcjMwMDBfZ3Bpby5jDQogIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3RoZXJtYWwvdGkt
bG03NC5jDQo=
