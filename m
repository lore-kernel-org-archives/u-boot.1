Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCFFCAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 14:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF4EF83287;
	Tue, 16 Sep 2025 16:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="RvSzxuUp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4989B83071; Tue, 16 Sep 2025 16:02:46 +0200 (CEST)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:201a::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A396800C1
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 16:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgET6BdJJLapQ/f+1mK/OuiN+zg3oI9TaaA6nbLZc34DrCXRGq14VaX6GdSFw01ha0cJMJHEP4qdSukuQE5bwVVTp5SGfYwldEAKwaycnDoPBM1DEDYM8g56ohfYRltrXuGaXB27sHD9agFKriZmV6j6QVQ3zkUwNPFpBQbMTFCJOKl0k3f44udvEWcl55pdM13qglyhDh+OVy0epi517WsHT+8Ks7bItsUxtZIkZapMfijrku9+2mzGLhtka4Tg4LSiYgGa2RLFbtfGe3HPPtDkhmvwWbEcYv9eyuCGzRkBJAPAZvvB6tZxQP7hn2btmzN7YacCkot3ZwDDOg7Akg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7khgHF2HMr4xtlt3brZR7dhtYXjdGc7f/yXcLhVU14=;
 b=tr5gT6c6/sKkQV+QqZVbw03uQkImrmTkFDniR1yNqzf1UBWNV6EIkcDGWEkSlnTCMgRRzT6GKRu00d7un2uMv0gb0rH84roP7svGgZ6ye7PJQMII9nvJhZLqlC0uH4JoMyJEMmbMbrojMHc2tpACpye2FEPrYPMLko0v+p/XdTTRMUsYXX2xZuvAnyLCbP6/74u+76vH96g7h4+xivvyLYAQ0/NV+D9g0hpR0VITAGiDtfVY3ACmG2HG15qXyctQ/nF4Se1HLhw9wwkVKWM6QgcZb3DVdJbH1jbAiqfQ3h8c+77gOWH6gjJX1lbFNdG25cumEYODzY0EsTBzCHTNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7khgHF2HMr4xtlt3brZR7dhtYXjdGc7f/yXcLhVU14=;
 b=RvSzxuUpChGZXv2zpuKxEYvprcEJ68WJAhUIqPpHj33xQHar7tDC7MVQdHIZhl3BItMtEEOLkHWiR2M5uspx4dB1W5TTHxZodAsS/7rjOINVQsHZgn/DTCvFuSF8DGGiSm0L7Zkc4yjBG41kgZt4IfzGucka1UpikUEvZPCDsrM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB6933.jpnprd01.prod.outlook.com (2603:1096:604:12c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 14:02:36 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 14:02:36 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>, Mathieu Othacehe
 <othacehe@gnu.org>, "paul@pbarker.dev" <paul@pbarker.dev>, Chris Paterson
 <Chris.Paterson2@renesas.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "anton.reding@landisgyr.com" <anton.reding@landisgyr.com>
Subject: RE: RZG2L and DTB blob from TF-A
Thread-Topic: RZG2L and DTB blob from TF-A
Thread-Index: AQHcJw31BG8AYAUJK0KvkgHo6W3hvrSV1Keg
Date: Tue, 16 Sep 2025 14:02:36 +0000
Message-ID: <TY3PR01MB11346F452EAE530A0931C9D228614A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <87plbqd0kk.fsf@gnu.org>
 <56857fb6-e3d4-4069-afde-57b43c4d2442@mailbox.org>
In-Reply-To: <56857fb6-e3d4-4069-afde-57b43c4d2442@mailbox.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB6933:EE_
x-ms-office365-filtering-correlation-id: 7839f43b-6b61-4a2a-34d5-08ddf529b08f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dG1BbGtEeHNZNTN3WUYxMmNZdTdZQ1gzMmNmNzlaSXdLbmJESENOb09uRUxY?=
 =?utf-8?B?b3N4WVVKaThodFFpZEJkZDBKYmZ3M3paVi9zSjJZT3FRcENMdHBaMG9hczNq?=
 =?utf-8?B?Y081aldmSkRXcDQ0cDc4SytkY0trYW9XTy80cmh3ZWQwNUxodGx2RVdXb0Mz?=
 =?utf-8?B?QzBBVVNkbFBUUkgvZFUvc084ZEp0dVN1MExrSG1IM2ppOGxzTTE3NkY0alEv?=
 =?utf-8?B?U2xVTkYxczY1Y0d1b3h0MkNpK3A0VGxsZTRRK2tVRnhxWldtUkRacWNNRys5?=
 =?utf-8?B?QUpJb0ZPNnN3U3lVYm9POTNzMUJITnVmZjJEbVhUVjQzdXhCeE9EMFBobXRI?=
 =?utf-8?B?eU9OZ2FIQ0NKVlpKNEI3VUhCZkdSOW05SE4vVkJDZGp5YzB2SDlIbFk2V2NR?=
 =?utf-8?B?ZlB1cjRYVFliUm4wV2pKL0RZdlFDdkx4ZmZLSFBNeGg2QmhGTkthTm9RUU9P?=
 =?utf-8?B?ZUlERTVYeHk1bUYrNFJnWmJ5bStEV1l4aG04RjlhbVN5Y3pSY1c4aUR1bEt3?=
 =?utf-8?B?dFFxR2crK1F2MDlqbnBPaUY3QWRvTEp2SHoxbExJMU1aODlBYkVwRTltSEtZ?=
 =?utf-8?B?NVFmMFRURGl2M0NobW5ocnhzU3E5TU5DdTdFQ3BjUFB5akJWY253bldUMjRD?=
 =?utf-8?B?NWphak9vTGZKaGxtckpIeGJhWWNYYlpsNUFzTjNlTkx4ZjU4M1pXY1pyVXAv?=
 =?utf-8?B?eS90OUFlMndITHZDUmZkSU5ld1dRTHZpUGQ5b1dRdzFGSFBpanJ4Q3gvQ1ZO?=
 =?utf-8?B?bERqeEx5OW1vMzB5NVpNZG5qYmJhKzVKTWltWE9HZmw5dU5MSkNUSC9LRDhQ?=
 =?utf-8?B?c3VQbVdCTTRkRkcwRzA4MzhXb2xvQldKeDZISkgwRnY3ZEt5anB1R0hEOFRv?=
 =?utf-8?B?ejdsOUNkU2dqTWhwQ0QzOVJWZ0tCeG5UM00vUHM3cUg4dUk0QjZ3c01Dckph?=
 =?utf-8?B?TVdWVmdyd2FqdjloemhDcFJ4WE91b2h0dXkzakNpdzdtU3NGWlFiNWV2MW5E?=
 =?utf-8?B?Q0tiQWN1UFhlWC8wTWVxNkRKcStFK2ZtYWlSM2JwUjlYd1M1OGN0ZUVQbjhK?=
 =?utf-8?B?a0hXM0V1RGVPalZJQ1JERjNMSHlJZTYxV1IzZEEycmRFRXJJYlo3MFhlMm9E?=
 =?utf-8?B?WnZYR2FtUnJ3OElsVmxSbFZjNWY1eFUyQ2hDcVFYRDBGSUEvU1pqWEpWdnJY?=
 =?utf-8?B?c2g4c1lScHplRDZlbWo4Sk80WjFtNUhxVENrSk1zOURsS0hUVTNmQWJWazFq?=
 =?utf-8?B?VWNtTCtpS01KZFl1a1NqcmIweVo2V0FkdytScS9PaEpWSEl2YmhUTnBvQTFt?=
 =?utf-8?B?QXR3NzhDZ3hJRlB4elQxSllZOXY1QTFFRlJqR1lHWmpQKzA3eVJ6VXlaZm10?=
 =?utf-8?B?ZXlFZ0tCaThWQ1l5UDJyQWJtV25DdFpGYW5RR1FiYzZuNGVOQ1J5aStaMFdp?=
 =?utf-8?B?YmNDdTF4dlVKZHVNMUZaSG1pVkVvUGEzL1FTazNXZzQwM0hEcldDWGFzRjFz?=
 =?utf-8?B?dFpKZjBUcjM3TGhyTXh0ZGQ2VWJCMGpVRnFyK2Q4OE1QaUNsbTVGb0t2aDFn?=
 =?utf-8?B?RW9kZmRjajNYUjdrUHg1d0tkbFl3ejRzZWRFRDVaQ01IOHJXNGcxZWdwVzMr?=
 =?utf-8?B?WlNhYi9nUEhvUU02QzNBOENPYzh1Y0VBcndFdlY5WlhGL2RHUy9nYXdDT01u?=
 =?utf-8?B?M1pEa3RqdUhrcEtSRDVCeWFCMm1zNlhDbnc5Z2dCd3FWR0pSSldhTWpmaGNp?=
 =?utf-8?B?K2FXZ3JRekk0dGVzTDNnc1MrNUc0VmtlYllzSExQeG9WWmhXdTBUS1NEUGd5?=
 =?utf-8?B?Q29HQmZXUVgrTVZsUGI1YXJ4OFVYR0dIbUZ5d0tPcFQ1eVprY2duV0h0SVZY?=
 =?utf-8?B?RndpQU5lK1hZeWw5Qy92ZjB5OFJmcHlHazFOODlMQWEwcHY3Z1Z5WmVIcmcz?=
 =?utf-8?B?SFZJWXdNYnZET0pPWGlWdlU1YVc1M1VDeEs5Lzd5dTJUOG9paHNwVm5nR1lZ?=
 =?utf-8?Q?ZbWISEvDGAmOMA1jonmTwXmJU7R0xs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2FPWDBOL0FEQlRQUkY4cW5XOHhGRHdUYjBzWjQ3eTRkWmVZMGdHdVZ0WVJk?=
 =?utf-8?B?RjUvT2lMKzZmL2RHZ0lWRGo1L1FFV3NBVXRwNnpQZVVTejlXdDludUpLWVls?=
 =?utf-8?B?YVdhSHlBd1M5VHJaYkNrR1lCL0tLS1d5aGNjTU5GYU45SjdYT1NRd3Z3aEkw?=
 =?utf-8?B?Ri92M0lyK0pTN20rNVRTUUZGaTNTaFZaVkFwTWVjVDVSMHNJNUJQSllncnJG?=
 =?utf-8?B?NHN3UFg0c3NEWkxtamtyZnZNZDdJVC91QlZYNjBsVFZIK05RVGg1a0FzbzVv?=
 =?utf-8?B?L3ZTMEpvODd3OHRIaEZaVXdGQUI1VHkyUUp2SGNWdFc0TUFSOFg2bnZPSzVI?=
 =?utf-8?B?b0RJbzZIZW01Q05SbzNiV0MxYVFHN3pPRUUwUEVKQnI2blFjM3d3ZmR0Z0My?=
 =?utf-8?B?N2pRakJKSTNyNUx6QXdCS0xqRWtLR3hKYXJ0ZlNzVjg3eWZxRjNLN1llYmRZ?=
 =?utf-8?B?M2NGbmt2YUFFS01CYThISVJ4bkRGNkw2aWlueCtNQUtlaTFydTJCbTBMRFRm?=
 =?utf-8?B?bS9vWEpmOHBCVDUwNVNlM09UOVBzeXVGSE90OFNFQmdiaVZielRtcjdPRFNt?=
 =?utf-8?B?RjZsYkdDeHp6andiUEJ1OEN4eWk4elFGRGllUWlOTUFXenI3cVZ5S3UydHgz?=
 =?utf-8?B?RS8zYllydlRnSTVoY0ZoMWZqVzBKQk1ic3k5R0cvajdSSkVKYVV3QWc3OHRT?=
 =?utf-8?B?RDN4SkgyV2U4SEMvT1VkQ3dHYkhwRDk4Q25JS3BQYkRHKzh2bnZIWDduS2JW?=
 =?utf-8?B?Z0hTVFNWZDBmRVJnRlA3bXRHaXZQeUx3bm02aCsxemFyUkJtQzJFejFuY1V6?=
 =?utf-8?B?TS9nR1hRM1p3bGp0bzRKbW5URHlmRTNoQ3oxSXFQUlVwWXUzcm04a3JYajZO?=
 =?utf-8?B?WnNtK3lncWdCYXFDU0Z4ZlF3bHlVaG56My9yL3h2aU1RNkR4amh0M2t5dXhT?=
 =?utf-8?B?cVZuRnQ0TE9mYkliRmNFbzVEZ3VlUmc5MGovYWRXcW1RT1dNOGh2amFEUC9I?=
 =?utf-8?B?eklKNnl6QkFZZmNUN1JBY056N2NTTWxNM0hjckdNVlg0OGQwVlJVbGU2b1hl?=
 =?utf-8?B?M0hvR1B1VnZkS3BlU0h4b1NEL1lUcFkrMHFrbkhDMjg2QXpDS25JOWc0SGh5?=
 =?utf-8?B?VllrNisvYnVlUWlhY3RkVDBsb214T05GbmtSV05LdGxhQXJ6N0pMK3RPV0F5?=
 =?utf-8?B?b2lMaUNZWFIxa25Sd3N5Tnk3WStLdVB2NVMrMTVwVU5VU3BKMHliZWkrMXBy?=
 =?utf-8?B?M2lWK3pESzJuaFA5dkFHQlZCTzNlYTdUdWR2TkJhbGpWc29ZZjhiMjNiUHJ2?=
 =?utf-8?B?WHo4R3JFeVBjVEdkMHlNVGI1Yk1mUGtnOEFFWGlibE9zSUJaQXFuSVg3eUp6?=
 =?utf-8?B?Y29LUjZVTmdqOVpTNUR1K1ZqbzR5Mk5mdzFFYklWbnFUdHdqamdGMnV1ZnQx?=
 =?utf-8?B?Q3N3c2ZnTW5ieXdBeXRZNm1wRTVLcytPY3ZzRUt0MnljdXlIdTFQQ3FGWnJU?=
 =?utf-8?B?TjY0dTd2NlRDTnhiRzE0RVVaSzNvRkdMVVAzREVDWCtHM3dlRHAwdnRMUmJy?=
 =?utf-8?B?Sm5FRmZrakh6RTdES1Z2RnE2RjdKS3NWMnQzRWhhcStKRm00TkhlcWE4MnIx?=
 =?utf-8?B?Tit0VExTZkFQMkFXd3hTdzNQTnVBbTlOMGlLZWNTR0lQZ1BlZlQ2cEU2eGNt?=
 =?utf-8?B?VnBrNWNpVlNqMHZINXZaN3F2Q2g5V1RTTm9ZSUlscTdyZGFZTE56elE1WnpV?=
 =?utf-8?B?VWNTeHczVnlIaHFKeWtPSXFSKzVHUDNQSlhHR3VmRVlUOGcvTU0ra3ZVVy9m?=
 =?utf-8?B?RHA2Wk9Qa2dNY3NyMlczTXN0Z045K01BM2tzNDdnNXh5NzFTdGt5THE2S1lD?=
 =?utf-8?B?YXdvems3MWNMemI3aysxbjdxa3FIL2tNNXYwSXVrYWdrcGJLblVMa0pJK01P?=
 =?utf-8?B?aEJudk5DbWJKOGVaUXp3Ym1JL0xyM0g4V004OHd0OHNFSHR3WlFXOWNja3dP?=
 =?utf-8?B?MHFXMlk3eVJMcXlxZDFOSE5sMVZ5bG45S25uSjNZY1NVZjNPMFhuUWx6aWkz?=
 =?utf-8?B?L3JUUFQ4N2Nrbm9ha083OVdQSVBnd2pLdXpuak1Vbm5iOEt3eHpZWEVwSUNo?=
 =?utf-8?B?ZE5Gb0h0K0krV1dCcDA2OXJDYWc1WHJWSXgxbllMSXVBMW9wSkRvTXhXeXRR?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7839f43b-6b61-4a2a-34d5-08ddf529b08f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 14:02:36.0880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0rn9xaTacYEIcoMu+KBr/LytmshWXisCdZy/1z7HIV3AmVEuJTa1uH4+5qwQ3gVwnV2LK0kndKiA00gSSHqlAJ+n8nrqRWDVf4xr8zbr24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6933
X-Mailman-Approved-At: Tue, 16 Sep 2025 16:12:14 +0200
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQgPG1h
cmVrLnZhc3V0QG1haWxib3gub3JnPg0KPiBTZW50OiAxNiBTZXB0ZW1iZXIgMjAyNSAxNDoyOQ0K
PiBUbzogTWF0aGlldSBPdGhhY2VoZSA8b3RoYWNlaGVAZ251Lm9yZz47IHBhdWxAcGJhcmtlci5k
ZXY7IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT47IENocmlzDQo+IFBhdGVy
c29uIDxDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb20+DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVu
eC5kZTsgYW50b24ucmVkaW5nQGxhbmRpc2d5ci5jb20NCj4gU3ViamVjdDogUmU6IFJaRzJMIGFu
ZCBEVEIgYmxvYiBmcm9tIFRGLUENCj4gDQo+IE9uIDkvMTYvMjUgMjo0OSBQTSwgTWF0aGlldSBP
dGhhY2VoZSB3cm90ZToNCj4gPg0KPiA+IEhlbGxvLA0KPiANCj4gK0NDIEJpanUsIENocmlzDQo+
IA0KPiA+IEkgYW0gd29ya2luZyBvbiB0aGUgUlpHMkwgZGV2a2l0IGZyb20gUmVuZXNhcyBhbmQg
dHJ5aW5nIHRvIGdldCB0aGUNCj4gPiBtYWlubGluZSBVLUJvb3Qgd29ya2luZyB0aGVyZS4NCj4g
Pg0KPiA+IEkgaGF2ZSBub3RpY2VkIHRoYXQgaW4gc2V2ZXJhbCBsb2NhdGlvbnMsIFUtQm9vdCBp
cyB1bmNvbmRpdGlvbmFsbHkNCj4gPiBleHBlY3RpbmcgdGhlIFRGLUEgdG8gcGFzcyBhIERUQiBi
bG9iOg0KPiA+DQo+ID4gSW4gYm9hcmQvcmVuZXNhcy9yemcybC9yemcybC5jOg0KPiA+DQo+ID4g
LS04PC0tLS0tLS0tLS0tLS0tLWN1dCBoZXJlLS0tLS0tLS0tLS0tLS0tc3RhcnQtLS0tLS0tLS0t
LS0tPjgtLS0NCj4gPiBzdGF0aWMgdm9pZCBhcHBseV9hdGZfb3ZlcmxheSh2b2lkICpmZHRfYmxv
Yikgew0KPiA+IAl2b2lkICphdGZfZmR0X2Jsb2IgPSAodm9pZCAqKShyY2FyX2F0Zl9ib290X2Fy
Z3NbMV0pOw0KPiA+ICAgICAgICAgIC4uLg0KPiA+IH0NCj4gPiAtLTg8LS0tLS0tLS0tLS0tLS0t
Y3V0IGhlcmUtLS0tLS0tLS0tLS0tLS1lbmQtLS0tLS0tLS0tLS0tLS0+OC0tLQ0KPiA+DQo+ID4g
SW4gYXJjaC9hcm0vbWFjaC1yZW5lc2FzL2NwdV9pbmZvLXJ6ZzJsLmM6DQo+ID4NCj4gPiAtLTg8
LS0tLS0tLS0tLS0tLS0tY3V0IGhlcmUtLS0tLS0tLS0tLS0tLS1zdGFydC0tLS0tLS0tLS0tLS0+
OC0tLQ0KPiA+IHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGZhX2luZm8gKmdldF90ZmFfaW5mbyh2b2lk
KSB7DQo+ID4gCXZvaWQgKmF0Zl9mZHRfYmxvYiA9ICh2b2lkICopKHJjYXJfYXRmX2Jvb3RfYXJn
c1sxXSk7DQo+ID4gICAgICAgICAgLi4uDQo+ID4gfQ0KPiA+IC0tODwtLS0tLS0tLS0tLS0tLS1j
dXQgaGVyZS0tLS0tLS0tLS0tLS0tLWVuZC0tLS0tLS0tLS0tLS0tLT44LS0tDQo+ID4NCj4gPiBO
b3csIHRoZSBURi1BIHRoYXQgSSBoYXZlIGNvbXBpbGVkICh2Mi41L3J6ZzJsLTEuMDAtNDMtZzk1
MGQ2YTZiOSkNCj4gPiBmcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9yZW5lc2FzLXJ6L3J6Z190cnVz
dGVkLWZpcm13YXJlLWEuZ2l0IGlzIG5vdA0KPiA+IHBhc3NpbmcgYW55IERUQiBibG9iOg0KPiA+
DQo+ID4gLS04PC0tLS0tLS0tLS0tLS0tLWN1dCBoZXJlLS0tLS0tLS0tLS0tLS0tc3RhcnQtLS0t
LS0tLS0tLS0tPjgtLS0NCj4gPiBJTkZPOiAgICBCTDMxOiBQcmVwYXJpbmcgZm9yIEVMMyBleGl0
IHRvIG5vcm1hbCB3b3JsZA0KPiA+IElORk86ICAgIEVudHJ5IHBvaW50IGFkZHJlc3MgPSAweDUw
MDAwMDAwDQo+ID4gSU5GTzogICAgU1BTUiA9IDB4M2M1DQo+ID4gVkVSQk9TRTogQXJndW1lbnQg
IzAgPSAweDANCj4gPiBWRVJCT1NFOiBBcmd1bWVudCAjMSA9IDB4MA0KPiA+IFZFUkJPU0U6IEFy
Z3VtZW50ICMyID0gMHgwDQo+ID4gVkVSQk9TRTogQXJndW1lbnQgIzMgPSAweDANCj4gPiBWRVJC
T1NFOiBBcmd1bWVudCAjNCA9IDB4MA0KPiA+IFZFUkJPU0U6IEFyZ3VtZW50ICM1ID0gMHgwDQo+
ID4gVkVSQk9TRTogQXJndW1lbnQgIzYgPSAweDANCj4gPiBWRVJCT1NFOiBBcmd1bWVudCAjNyA9
IDB4MA0KPiA+IC0tODwtLS0tLS0tLS0tLS0tLS1jdXQgaGVyZS0tLS0tLS0tLS0tLS0tLWVuZC0t
LS0tLS0tLS0tLS0tLT44LS0tDQo+ID4NCj4gPiBUaGF0IHJlc3VsdHMgaW4gZGVyZWZlcmVuY2lu
ZyBhIE5VTEwgcG9pbnRlciBhbmQgZmFpbGluZyB0byBydW4gVS1Cb290DQo+ID4gb24gdGhhdCBw
bGF0Zm9ybS4gT24gdGhlIG90aGVyIGhhbmQsIGRpc2FibGluZyB0aGUgdHdvIHBpZWNlcyBvZiBj
b2RlDQo+ID4gbWVudGlvbmVkIGJlbG93IGlzIGVub3VnaCB0byBoYXZlIGEgd29ya2luZyBVLUJv
b3QuDQo+ID4NCj4gPiBJdCBkb2VzIG5vdCBzZWVtIHRoYXQgdGhlIHVwc3RyZWFtIFRGLUEgaGFz
IHN1cHBvcnQgZm9yIHRoZSBSWkcyTCBDUFUuDQo+ID4gU28gbXkgcXVlc3Rpb24gaXMsIHdoYXQg
aXMgdGhlIGV4cGVjdGVkIFRGLUEgYnJhbmNoIC8gcmVwb3NpdG9yeSB0aGF0DQo+ID4gaXMgbWVh
bnQgdG8gYmUgdXNlZCB0b2dldGhlciB3aXRoIHRoZSByZW5lc2FzX3J6ZzJsX3NtYXJjX2RlZmNv
bmZpZw0KPiA+IFUtQm9vdCBjb25maWd1cmF0aW9uPw0KPiA+DQo+ID4gVGhhbmtzIGluIGFkdmFu
Y2UsDQo+IA0KPiBTb2Z0d2FyZSB2ZXJzaW9ucyB3b3VsZCBiZSBnb29kIHRvIGluY2x1ZGUsIFUt
Qm9vdCB2ZXJzaW9uLCBURkEgdmVyc2lvbi4NCg0KVXNlIHRoZSBjb21taXQgNzJjODZjMGFmMDFl
MDA3YjU1NDJmMzk4MjNkOWU2MTQwOTM3YjQzOQ0KDQpwbGF0OiByZW5lc2FzOiByejogRGlzYWJs
ZSB1bnVzZWQgQ1JZUFRPX1NVUFBPUlQNCg0KQWxzbywgeW91IG5lZWQgYSBwYXRjaCB0byBpZGVu
dGlmeSB0aGUgZGV2aWNlIGFuZCBwYXNzIGl0IGFzIGJsb2INCnRvIHRoZSBtYWlubGluZSB1LWJv
b3QNCg0KT24gVEYtQToNCi5lcF9pbmZvLmFyZ3MuYXJnMSA9ICh1aW50cHRyX3QpZmR0X2Jsb2Is
DQoNCkFsc28geW91IHNob3VsZCBmaWxsIHRoZSBtZW1vcnkgYmxvYihmZHRfYmxvYikuDQoNCkhv
cGUgeW91IGNhbiB0YWtlIG92ZXIgZnJvbSBoZXJlLg0KDQpDaGVlcnMsDQpCaWp1IA0KDQoNCg==
