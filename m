Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D6EC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 03:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0FB487668;
	Wed,  8 Nov 2023 04:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=matrox.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=matrox0.onmicrosoft.com header.i=@matrox0.onmicrosoft.com header.b="DkyTE8g5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D73F87689; Wed,  8 Nov 2023 04:05:25 +0100 (CET)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241c::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EFAD87661
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 04:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=matrox.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=agendin@matrox.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh1h6IJuWVK1458XkXRlmLujd8JljJeAttY+ayNSI2DeJldn3EGFQxdgQ5F8CVUyaETd17GKSDqMunDq1U+6g9KYMtuHMN90YE4szGU5iFlaFaqTCADffPSODiFpKOP8diBldZp9ifX5qLZgNBtxXQl6bfLu15WTTlVPCKrsS3bc+Y/in6ebsAayHPBzv/kjOND3nmu8FKpXxlo5DU7lL2uMo2eyfX6p9oFANkfv1lZz5Uu6fZr6UgfzC6gZt6uuhpQCU2EgHaWuPGOvnSu3UUGxA+1NJE9cgM9bgZrHX7XCD7sko4KR3fs0FHOhefBpSbw8L5rw3G1NNFW3egRQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdNq9iagGxCDzhfDPNW2msCkosVAqzB7Mh0DLlEeobU=;
 b=C0Z17HDsL23mhjk25enP/CDRB1xEByMpClKjB8ut7eZ1W1LBj3dRnsdO+ounzYfne1msCuwh3PT1H6cnN3pgmKsX573BuHQNPwo3sTXbeUnRawikk5/UP366pn4ipJUW+s9EOG1F8MvDj5kHjAKHVBTuzMCzP+m4mQeiocT+sPVtnxRyjnL3RCIW4/rupSNF2DpGoY9GWUZDQzWx1SVuS27dhMadgr7tTi5/fR/AgKftNxJ51bXcg9VbT5Q35eTx4IdQLTpxegmgAzx8RpUVxNBWp68rw1NMdP4wBTg1BgQhH2w4GoUkfXNPyts00IEhp0I4VRFb0CJGQadDz/tQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=matrox.com; dmarc=pass action=none header.from=matrox.com;
 dkim=pass header.d=matrox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=matrox0.onmicrosoft.com; s=selector1-matrox0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdNq9iagGxCDzhfDPNW2msCkosVAqzB7Mh0DLlEeobU=;
 b=DkyTE8g5f47oV8ZQsFec1GipywJG2cnhtePdnY5nkUdqb7NII7oRkgvUMNT2Ih1vgG6z8EDa63VaSOdbujpHaT7AhjAHgL5Yv1prNNrT77oSqRyjyJPbsb/hMwFm4/R47IwaCjiiNnDXTFhf37sfejtaj0/hultvLkoOosc3SHA=
Received: from YT3PR01MB5626.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:60::18)
 by YT1PR01MB8329.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 03:05:20 +0000
Received: from YT3PR01MB5626.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17d:3de3:e313:a672]) by YT3PR01MB5626.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17d:3de3:e313:a672%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 03:05:19 +0000
From: Alexander Gendin <agendin@matrox.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] test: cmd: mbr: Remove unreachable code
Thread-Topic: [PATCH] test: cmd: mbr: Remove unreachable code
Thread-Index: AQHaEfBoLgRdAisnHEe1wG0NTM0Mww==
Date: Wed, 8 Nov 2023 03:05:19 +0000
Message-ID: <ZUr67-KKyaSDv_vk@alg-gentoo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=matrox.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT3PR01MB5626:EE_|YT1PR01MB8329:EE_
x-ms-office365-filtering-correlation-id: 54386024-33b0-4b72-b548-08dbe0078ab6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: je3UcRm+8XQATnWNKoFoKYV9hj18j6wcGPyFNt8M7eDSKOJYhnHN/jaCZxaFmu8IrQkfqsZmGHTls/Ha1Kj6AOz5VVepenGisgH7KXsFGzFf75lFv9hhgCI5jBv9CmRHXV4+N0rzrrPqeXh1hXFKR6KgcVNR3XxiwW6WCcwJB2SKpyEgjcIhsX/JZb2wUoOOJwgQT7yrFgoyPFHxsNMbn45jV8R8bfNyFll+3cNfRX3dthPxkMbS+H+4KFrNizXx/FDlsYMutjKlfFza9OyI/RFXT1gaLehDsl4KMYpo47tG2a+yfUs9o2HeXc72SMeE4dwwDU6XcJ8nuVQCAg3KR/LwGJpV8KkfcXGBKY102/vrE6e8HdG3wwh7QOucomaIb3rV7QLy3YDB4KkBg3ne/gaKHgaYKvpqHuqRwc5U0ptejNJDv0FVD75AIQFFoFJP4UpCW6B2qcZAU+28wELoxMrnLSqn6nFPPazvRmIf3rdTklJBdFdnUVkSMYR3T1lHdckFu8es90Yi7XmaZrhg3pilNAMwO1LKJtiS3SGx3QXKyu/Y/f/4aaK+KLuZa+SGVwXPbJE3K+typQPAUWycQTtWjks2GWLuYxYm826dcGY/m1sjBBjE+JPwQW2FoIrP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB5626.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(39850400004)(396003)(366004)(136003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(316002)(122000001)(86362001)(6916009)(76116006)(91956017)(64756008)(66946007)(5660300002)(66446008)(66476007)(66556008)(478600001)(8676002)(4744005)(8936002)(6486002)(4326008)(2906002)(71200400001)(38100700002)(6506007)(9686003)(6512007)(33716001)(38070700009)(83380400001)(26005)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N24xYzdqL0ZxbWUxOFIveWVDbjd3T3FvTS9vM2FDQm55ZVN5RlBWWHZoVE5W?=
 =?utf-8?B?bnJkcklveTVvdHVRTWsvTW8wUnBRcnlYTm5yTWc1bEUyRXBtWW9icEFzZ0JV?=
 =?utf-8?B?RnVOTzBhUHlQNmxjcFNTdWU4S0xRcXlicmR2WThydndLRXZpRkxZSlBqREwx?=
 =?utf-8?B?Qlo1ZFZ5bE1ObXpZay9Idm96OWlpVW9SdTdyVEpvTk16WjJDdGtVMkZ0QW1j?=
 =?utf-8?B?VS9wUlZSNmhrbVVOdzNQRVVsYlpyd1d2T0d6a3hRR3lvUjlVNWtTZlZrUnhD?=
 =?utf-8?B?SFN6anFUbHJWN3h0bmhva0dsblNqMWd2Y1VWVE4xY2dlTmpJSHkrOHp6akJw?=
 =?utf-8?B?Y0F1T1NSWUtSaUZxNlErMmlFTCtTMS9lL3F2MjR3bFpXMVJxYlorTFZlQU1O?=
 =?utf-8?B?RVEyNW1nRCs2ZjZ0akUxMkFXVCtpZXdid2V2SFJUVXpEMkxUMi8xT1g4S3ps?=
 =?utf-8?B?cFQyZFRWRG90ZnhvekhQdE56Vm1aOG9OZHJpbThjQVhCUFRnalEyMERyUDQw?=
 =?utf-8?B?eUkyYURrR1NVUnhDZTIvVkRaeU9NcEVxV0RkNjlNeEdNZHUreVQ1NFd4aTBX?=
 =?utf-8?B?eGpoSGpTRXllOGRKdTVZT2hZa3hWZmNFTE9VY2JuR2creWZvbHN3cng4TGV5?=
 =?utf-8?B?TlZ1Zm01NUFhVG1SUHErZTdVTFlESEhsczJvR2hXaVFkdFc1Q1lsaDVLZUc1?=
 =?utf-8?B?cEVFaXp5Y3F6YVR6dWlHODYzcXhqOGd4bVJYYXVKajIyUjhkb3AvdXlucVJI?=
 =?utf-8?B?NndXd3UwRHhTbmxibWxBRHRVRVRYbmZjWnlrT1FvWWRrem1nUXpoTVRMNm1j?=
 =?utf-8?B?ZUU5OWtQV0h5U2IyM0ZEV1A0K2VjUnJJTUFnUFZoVFpjWFVINlR6cTdsK2M3?=
 =?utf-8?B?K2JESzZiT2Zvc05RMHZUMWkxdURJbGpSQjNkSi9aS1RvaHdFdFM5ejRiSDNT?=
 =?utf-8?B?RU9jWEJ1dWVDTVEvZ3djTGtKZDM3YXY3Nm1pWDhhS2VQTXpGcFFESXpPSlFY?=
 =?utf-8?B?dUxtZXBtbkE2blh3dnNSTGkxcG5JWHE1OEZPbDExNTFMTVVYS0VCemxFNGMx?=
 =?utf-8?B?SExBanVsTmNSQ3lWT0tWS2p3cExzTHNyZGc1OHJFajdNc0ZqWW1JM0NxWnpn?=
 =?utf-8?B?NHFvcEZDcDJhK1BIWTR1QjdON2pwT3N2bUo4N2JPTWVDbzdIUSt3c25xSjI0?=
 =?utf-8?B?WnBQdWdQUGk2L2lEMHZoOE91a2tsb3JkNjE1SitWaUxwMFdlYU1WSWxycXNj?=
 =?utf-8?B?UEtlT21YbDlFZ2RUU3lHQytYMUFsUHhTc3pldWV4Zkw2NEhYZ0cwU09iS1ll?=
 =?utf-8?B?UkQ5clJ2am10UEJWVDZWQjNRSHhXRzgyelhvcFR2VjlsTmFNTFZVZXdLWWdN?=
 =?utf-8?B?dFlCeTdCd1lYWmJMZXZvN0xOTnFUSXpER3JYS0p4YVc4SWUvYkp1L3lqR0Zk?=
 =?utf-8?B?bkpSYmJTTUdWMTR4NHN3cVArWmpka0VjQjVTK1BGelZ3djd5NnkyTlQyaDBK?=
 =?utf-8?B?dUpNZzVNQkVvb1FpRTMvSWRrNUI5cUx1dHcwV2grTUdwZlZ6QVI4WjIrNG5s?=
 =?utf-8?B?S1BtcWdicDVDMVQrTmYveXRJeUJrc0h5SElueVpUaW83eGxiVGZSU3ZMUTV3?=
 =?utf-8?B?QXpSYUhWR0hsTVVWSERPa3pWNXMvNFFjelNNeDBtZXNRQ0VkWG45Q2ZWZVdz?=
 =?utf-8?B?cEhmMnlEZHdHMmpSYkkxZmVZQmlKc3dtSXg2YU42ZEVRcWIwZ01kYnV5Rld4?=
 =?utf-8?B?VE1nTWFsSkxpeGtDSUgxTzFmdDNCRGMzQTU2WFp0SUVPRTBscCt2K09zeEJE?=
 =?utf-8?B?UjBzZ25oYldBVXk3bU0wdXgreGdacmw1aUhrUjZiYTJuY05xaGJ5eEpqVHpy?=
 =?utf-8?B?eW8rRlRML0lQejY5Y1hXQ1E0dm96bDZCZThZdWJrYmkzeXhFMTRuQVA4Y3Nt?=
 =?utf-8?B?eklRY0hVYkI2Qzhrdy9wUHM4SjBVSUl4OWRNM3RZWnBYb2ZNMnR2dlZqbDdQ?=
 =?utf-8?B?VzBidFN5QUxTa2p4TTRtbmlBSExMUFNLUkJaZUN6Lzl2R1V3enV1UVdrQXQw?=
 =?utf-8?B?UHg1MllmaGYyeDg5S0RjcVA3bHRSS3UxSG9LUmdWYVp4eFVvQWVxT2FmYzYr?=
 =?utf-8?Q?Yx7DhaOEkd5mzxSDyLmWHHg07?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <940849AA38120140BF4D0F76D7485240@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: matrox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB5626.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 54386024-33b0-4b72-b548-08dbe0078ab6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 03:05:19.9671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 09c2e324-8cf7-459c-b6b4-e23db24b9d4a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w90KbfnnCQBZF3AMSaMbwoAR519WQwzFLCbsJMHE7L1vrHhFsFvZIDNu8lTgCTcwohmXbW+7IeNMDH9HLlG3mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8329
X-Mailman-Approved-At: Wed, 08 Nov 2023 04:53:08 +0100
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

Rml4IENvdmVyaXR5IChDSUQgNDY3NDA0KTogQ29udHJvbCBmbG93IGlzc3VlcyAoREVBRENPREUp
Lg0KRml4IGNvZGUgaW5kZW50YXRpb24uDQoNClJlcG9ydGVkLWJ5OiBDb3Zlcml0eSAoQ0lEIDQ2
NzQwNCkNClNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBHZW5kaW4gPGFnZW5kaW5AbWF0cm94LmNv
bT4NCi0tLQ0KIHRlc3QvY21kL21ici5jIHwgMTYgKysrKysrKy0tLS0tLS0tLQ0KIDEgZmlsZSBj
aGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS90
ZXN0L2NtZC9tYnIuYyBiL3Rlc3QvY21kL21ici5jDQppbmRleCA1ZDc0MDIxNTRkLi40NmI3OGU3
MDZjIDEwMDY0NA0KLS0tIGEvdGVzdC9jbWQvbWJyLmMNCisrKyBiL3Rlc3QvY21kL21ici5jDQpA
QCAtMjA1LDE2ICsyMDUsMTQgQEAgc3RhdGljIHVuc2lnbmVkIGJ1aWxkX21icl9wYXJ0cyhjaGFy
ICpidWYsIHNpemVfdCBidWZfc2l6ZSwgdW5zaWduZWQgbnVtX3BhcnRzKQ0KIAkJCQkJYnl0ZXNf
cmVtYWluaW5nIC09IGN1cl9zdHJfc2l6ZTsNCiANCiAJCQkJfQ0KLQkJCWVsc2UgaWYgKG51bV9w
YXJ0cyA9PSA1KSB7DQotCQkJCWN1cl9zdHJfc2l6ZSA9IHNpemVvZihtYnJfcGFydHNfcDUpOw0K
LQkJCQlpZiAoY3VyX3N0cl9zaXplICsgMSA+IGJ5dGVzX3JlbWFpbmluZykNCi0JCQkJCXJldHVy
biAxOw0KLQkJCQlzdHJjYXQoY3VyX2J1ZiwgbWJyX3BhcnRzX3A1KTsNCi0JCQkJYnl0ZXNfcmVt
YWluaW5nIC09IGN1cl9zdHJfc2l6ZTsNCisJCQkJZWxzZSBpZiAobnVtX3BhcnRzID09IDUpIHsN
CisJCQkJCWN1cl9zdHJfc2l6ZSA9IHNpemVvZihtYnJfcGFydHNfcDUpOw0KKwkJCQkJaWYgKGN1
cl9zdHJfc2l6ZSArIDEgPiBieXRlc19yZW1haW5pbmcpDQorCQkJCQkJcmV0dXJuIDE7DQorCQkJ
CQlzdHJjYXQoY3VyX2J1ZiwgbWJyX3BhcnRzX3A1KTsNCisJCQkJCWJ5dGVzX3JlbWFpbmluZyAt
PSBjdXJfc3RyX3NpemU7DQogDQotCQkJfQ0KLQkJCWVsc2UgaWYgKG51bV9wYXJ0cyA+IDUpDQot
CQkJCXJldHVybiAxOw0KKwkJCQl9DQogCQkJfQ0KIAkJfQ0KIAl9DQotLSANCjIuNDEuMA0K
