Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2198D6406C
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 02:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC71F83979;
	Wed, 17 Dec 2025 03:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="V4Btdokr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B30483A8E; Wed, 17 Dec 2025 03:47:57 +0100 (CET)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c406::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D6988334F
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 03:47:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYreOUH2PSmSMjVbdiYBFQD3lcnV6JTA2i5ijdps0srAPsYJPlH6tfsyxFMVMdq202IEZBPYl5lHqmZyNDF7LBAhoUDn59SdmEld91KB4wdUcZqjW6V4pSQzbFztWTMUtDAIWrSs3UUPz/8AtLm4XAsbj2EnaifrWdCWfBCKqxZngQ1EpqyrcOAjMn+iynHSrh/EAGfvmjLiV5kVkyrPpUZoIjRNsRqDzqF2lAtWe/cL6L7++rDpO5S/dFq0ZQQAljZ6SyMBmA93VWR90C9CS24sbPVbWIQxYdkLgPpOvLjR9E1m+/RoSUOEDgz4cM43hIARrPwHCNUZ4oHYUY2dIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lv8La9gbdR3+lPL/cvNqlOFPEgkU267wCB4kzYhqRk=;
 b=qw6txOWA+wao9P+Jj2rDWvIYJ0KCLzWOg4gzKKnEsoYf1lIKxWZZIhHnjRf4eDFXGV1C4Ee55vxRvRnwg8Uh4vnatIOx9ZR8dAMFOSNru9L/cpdRrKrOJDffIvmPCQiA2FZ5dp6uw6hw1RUwCpFX0HUmEwZJu2AAiQtlT8kmniE6hh84gy8rr4iJHEZ/oRARUUFrshGYPeRzR32x4nDWxML/kq648x+HDjYmDtSzU4+E2zo26Uoawbtp5CpPY/PmKz8+l8wWqys4fdNMjmfDHJESnjHt/iHYlueUBfXJTZ+cxR9X1zBhoOb+6smniNfzBKve/lPnpuDkAeUJoqtKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lv8La9gbdR3+lPL/cvNqlOFPEgkU267wCB4kzYhqRk=;
 b=V4Btdokr0QDIJc1CHFer/7T1iVazVxPhnY+LiRFm6TBhMfzF4rO+9b6s0F1TMpNSIThQpTU9AVfKyKI1x9Nx6rfkEo02xlGEZ5S7jENVnYGi2R4Fm/dZcXa5TlpLRTT8BiXpPlJG5jbx/pVis1QVKlb/YtF7H6prt73141rsIgS5t4snb8pY2peU3wR88jNlNkzKPLYIP4tikUHrHH5GLxAhyNNWwm6OlNXZ7ypQJbnUoc5i/axfDkkZUkl8GChZUgDaNbqTJd9Oulyb77d9MkcF102xbpB4jgB3PecUA3nuWl0ZBPLHiGJJgygM2xxjrnMa9oYK+6SLHuIIRS5QdA==
Received: from KL1PR0601MB5488.apcprd06.prod.outlook.com
 (2603:1096:820:9d::10) by TYSPR06MB6693.apcprd06.prod.outlook.com
 (2603:1096:400:478::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 02:47:47 +0000
Received: from KL1PR0601MB5488.apcprd06.prod.outlook.com
 ([fe80::d45a:6698:a285:990]) by KL1PR0601MB5488.apcprd06.prod.outlook.com
 ([fe80::d45a:6698:a285:990%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 02:47:47 +0000
From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
To: David Lechner <dlechner@baylibre.com>, Ryan Chen
 <ryan_chen@aspeedtech.com>, BMC-SW <BMC-SW@aspeedtech.com>, Joel Stanley
 <joel@jms.id.au>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] pwm: aspeed: replace %pe in dev_err()
Thread-Topic: [PATCH] pwm: aspeed: replace %pe in dev_err()
Thread-Index: AQHcbvAQicUrb/syq0mtobC0laIi4bUlIDKA
Date: Wed, 17 Dec 2025 02:47:47 +0000
Message-ID: <KL1PR0601MB5488ECFFD0A5BED78BCA917F91ABA@KL1PR0601MB5488.apcprd06.prod.outlook.com>
References: <20251216-pwm-aspeed-no-printf-pe-v1-1-fd7d1ca726b2@baylibre.com>
In-Reply-To: <20251216-pwm-aspeed-no-printf-pe-v1-1-fd7d1ca726b2@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5488:EE_|TYSPR06MB6693:EE_
x-ms-office365-filtering-correlation-id: 8c989acd-5577-4a67-9510-08de3d16a974
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?eXlxZGdyMGJlNUNOZENrSW1MZmQ0R1dEZklFbnpQc3BHRDYxcDFoYXpqc0J4?=
 =?utf-8?B?cTJEeFRIT2NaeE9rS2hqaERYQzRvZHZERUE2TFZ5L0JvRGRlUDNDQ2RZcE5S?=
 =?utf-8?B?VVlUT1orbXExK0tHMlRjSituSXNhbTBlZFk4NENON2dnbmg2SEtJSTJtSGpP?=
 =?utf-8?B?L2RKSHZ1VnhHdDExdERaTHV1bVczK3ZSWFdTNlM2NklqdzdJY0IzN3Y4SnZ1?=
 =?utf-8?B?ZGV0aHBENlBmQk9UYkM4MFRXNjNNSm9WWEtmWlpac0t1Sjg0NFduNWRTSm5p?=
 =?utf-8?B?OGx4azF5ci9BWnc1SnI0RVg5SktnZFZvbWl1dTBtbXFRMFlpT2VvbHJTNW45?=
 =?utf-8?B?dHd5VUJwK2ZqQVBTOXpxUXhjdjdSZEN3N1cwVUtFeDNjSGJYMEx2Q1BWZFNy?=
 =?utf-8?B?UkxwUkRvdDEzcjJ3dU5lckFETUJHUGh3WitSWFNtRHplTmhuVlNFVmFyZHND?=
 =?utf-8?B?VHNIM2s4YjN0NkJUK1JwV1JyV3hwcFpueEU3MWV6cHJ0dDMxS3JyUnE5a0d0?=
 =?utf-8?B?L1BZYUdlZUk3b25YWS9NTmx3RVJjTHNxajhKbmMzM2hvRkJnaWZQTHlFTzJZ?=
 =?utf-8?B?TmVmbFcvQTVOMzIvVjhoNXhJMXJpQmJ6aDZPOUJ0ejhxNituVVJJdGZic0xa?=
 =?utf-8?B?YnFNRWZraVUzaTFsSkJZa0lNWm1NeG4wbjRoL0lWNjZZSmEzUXJWam1iTUZv?=
 =?utf-8?B?bGhQVlcxSGc5cllIU0s1eTBOUnFxL2V2VW9BZGpBNWl5dDdvcWVrdjZzaGE2?=
 =?utf-8?B?dkxmcG1aNGwyakRYZHdZYWFadmpMUG9hMk44NStWWU85c2lyOVZ2bFNZUHVt?=
 =?utf-8?B?Vys1YXIwakZGcUJWb2JZTFhkeFhZNHFYOTE4c0JUVTFHYXYwNmZ0S2lKSHRz?=
 =?utf-8?B?WE14ZHFjd01WaGRnTWMwTDYyYk40ZkFMSzJ4aDJEaDdRbG0wM2VEYmZ5cGwz?=
 =?utf-8?B?ejZrNU5WTGlSS0Q2ZzdpaFhWUzQ3c2FQMWZ6WFAwWFdqQ1c4S05keGg3WEJX?=
 =?utf-8?B?MDBobVNnUkhJbG9CTGpXQVVWNHBlYmhIaXYrL2JsTW1OZHQ4bVhKNTRQbE5S?=
 =?utf-8?B?Rk9KQXhmZTVtcXlMS2hOdHNuU1EvT0d2VTgwQ2dVRWNXOENWRHJzV1JESUtK?=
 =?utf-8?B?NWF6TnJjVWQ5cjBEanRYblprNjMybk5kV09ic04zdGp4dU16aEFlZTgvZGZu?=
 =?utf-8?B?YzQzbUlUdGtFZDlYQ1dRZzJ5OTYzVEpGdU9TUitURnZBMk1ScW1HYjVpaHVQ?=
 =?utf-8?B?YklWUk5YWUdTTzJlcnhwc1BmdTN0ckVhYjBHSjBCNXROK0UzaEtTL0VqUDND?=
 =?utf-8?B?R2J5WDVCRTFLRlo0QXU4MFRURkxBdXRlSnRoUmpZSWw3dlU4MEF2MUFWK2Ju?=
 =?utf-8?B?bERsU1RLTWZueE1lb20rOTY5OVczYm1OOXY4a3pLT1o2bFlPbW9iVzU2UWRC?=
 =?utf-8?B?Ny9sajhrM0l0QzZwcm9vWmhIemNOWlJhVllrdXF0RlVYQ05DMVRSOFpXajkw?=
 =?utf-8?B?Y1ppLzNDbW5vUFJLUUtKN3BzbU5wK0F5aXdRVEN2RzFsa2NrcnZCMjhlL1p4?=
 =?utf-8?B?YXJQNitPckR1bytEUkV3N2ZmRmwvazJVS282YmQxMCtSaGJ5MEhQbUpadWVh?=
 =?utf-8?B?S0VEb1F2M2pYdmlpTkIxVWdLYWVRQWtkL1o2UHlxNWcvTzJPRGhnejJhazZH?=
 =?utf-8?B?dDBVSzExMnJFYVNhdWthWWx0WEV4aENGaDlJUUtDMzlHRFAxODAzMm5FclV5?=
 =?utf-8?B?dnZxeXMvc2s5b2tMUGp2T0lUeE5JWWxBZFhxU0YyZ05HbGhlemIxM015ZFQ0?=
 =?utf-8?B?U214MnFON21GMmxzYTBXbi81YUtrLzFYMG5xT2M0akI0RS8va1FqMVlnT0RI?=
 =?utf-8?B?b0hOL0xTMDJQMWlIY1kzSExNYlFiK1ZTNWxhd2R0bm5ZaXNUNUpKR1dnR3BO?=
 =?utf-8?B?QlBHaCsxbitKaDZGWmFKTGg3WmRHZThmLzF4MlNDK1J4c2FlYmRrWGlZU2pO?=
 =?utf-8?B?bWVvQVFGU1prczNQTklRV1pjS0lzQUpTV0dDS1lTSTRCTUZrT0FablppR1Yy?=
 =?utf-8?Q?rRRoSi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB5488.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1RjQmJlcnhjQ0FzUFBLdmxYV0Z2UDFjdVlaUXlkVVd0NWdsKzRNVXdtMmVP?=
 =?utf-8?B?aGJteHpENm9hRUtLMWxBQ1ZuSEpwWWkxUXdRdk9ZWUM1bFZaZW1oMVArOU1h?=
 =?utf-8?B?akhGbHBtY002WlRIRFI1QmwreWFGMzJtS1l1aXBWNzAzY01CdklYMVFPWFBa?=
 =?utf-8?B?WTdmWC9PWUdWaW8yWFNIKzNneFF3OWIvMXc3d0J3ODNWK0dGL0FnRDQ1WGlS?=
 =?utf-8?B?QmdiSmNnRHl5b2JWbzNlVytoWGlESytJYUpQQVE2Z0JkMEJUWEQyN2lORE84?=
 =?utf-8?B?WEpuWEZlVVNheEdnZU5EZXFNVlJIdzhaQ3pLVUdwWUk2VVM5eDZJOVZMZDNS?=
 =?utf-8?B?V3haNlVOSnBCUlc1Ris2eStSSnFWNWR1bUU4WG5lRzhZeXdlYlhWY0VNYmp5?=
 =?utf-8?B?VkFwNWtYSE9SV2o0eXhFYy9TNXZ2R2s0N0xvYjRjaVZJK2txVnc2TVhYdWhY?=
 =?utf-8?B?NzlGVnlEMEI5NjBHbkxnZ3c1NTh6MXZYV1lPTWcwYnFYVWVYMHBKV1BZNXhl?=
 =?utf-8?B?SzN4MHo5MXdFakpoRTJZY3FPbHRWVFZmazdVcFFTZ2lYNTFFMVYyakRvSE04?=
 =?utf-8?B?ZzQ5aEZBb3RwOWVDWjMyTDByaDI1TnJFS25Fd1dieW8vTElYcFEwOTJOdWNQ?=
 =?utf-8?B?K2NhYlNWRmZUbE5LcGIydVVMeUJBb1pQRlJSU2paSTd0dWN5ZnExM2FKUG1w?=
 =?utf-8?B?M1habE1GeVN2UzZ2OWx2TkdPRkgyQjZoWm84aFFDS2JvaW1Rby9ZRDNxQnEw?=
 =?utf-8?B?QWs1MTh4UkNZWjA5WDZQTE9JYnpxZzhseXJGeWVQbEhIVGhFWEdZY25JUUt1?=
 =?utf-8?B?REdNQ1VCaXcveDNrSmtxRlZPQ2NmSkV6ZER5d1JJVFAzeDZGdStaazg1Z0lQ?=
 =?utf-8?B?ZTg5MWNwcXNRRlc0RDlReS85bFpid1FDV0g1MmZPV01lT0wrRThYcGN2cG1j?=
 =?utf-8?B?VHlWeWVaQXFoVUVHYnFpSmlGR21mci8yVFViL2dGVmpRdUVNWVZXY09nVEtE?=
 =?utf-8?B?U2pKZzN1VFhlZXR1Wmo1a2tXRnRPM0xWUUgyRmhnSFVtV0hFY3hIVTFRRWN2?=
 =?utf-8?B?WGZoSXlEb1pkOE1DZ0hNekoyb1ZtK2RtWHNSUm1yZG4xY1NwSkVNNjU5YTBO?=
 =?utf-8?B?MDB6M1Q2UmhLeTk0ekZBc2owRTJCNFNaRVdXakJIRk5QWkF4WXA2Tm1NQmFH?=
 =?utf-8?B?S3ZYQnBXenVlV0w5U2t4UXpiS0J3bTRuamlGY29MdjI5aUFBOWY2VGZTNE9L?=
 =?utf-8?B?TFVzM2RVVTZrMEVTMFZFSU04ZnR2OFQ2UkVNb3pkNkR3S1F2Vkd1MXZLWGd3?=
 =?utf-8?B?cDAxWUU4d2M4QVFITzBkQXcxVFgwYXhKMGlWUXBZWmR2YUw4R3RMckphOW1F?=
 =?utf-8?B?amFQWENJb0p1RmQrMU9CV3Y5SmVoU01hcTdqVUxTSDV4OFFERVU1NFY4OCtn?=
 =?utf-8?B?NWlVL053VEpxQzJjbktGajdMSHJtUG56cnc1MHV2TGpzK2VNK0wySy9xUGZR?=
 =?utf-8?B?TWJPU0tNU002UUtaOHJXcW1XM01QbG10ZGhGaDd1d0hiRDBRVnBTYW9FbGMz?=
 =?utf-8?B?bHl1YkliYXYvODZ5VDF3V2ZrY1V6WE5XUVZGOXpTNmpTMXM3MnQxWHRKOGpY?=
 =?utf-8?B?NGZmd2lGT2pjejl0WVc2WXNpclZybHFpN0ZXRUx0dnZyMk1tRC8va0lDc1JJ?=
 =?utf-8?B?UFhuV1cvd2wyelhMUHJiSldCZEtJRkpWclZCbHpqSE41Wnl3clMvdnI2RXBO?=
 =?utf-8?B?STJJVzA0dDJrd25YckpvYUx3UEltWEkyNXc5b3oydUdGNXRUMXhFVnQ3N21M?=
 =?utf-8?B?c082TW5GSmFzbmovNmRnWmoyQ1pmQXlsUVZQYWRDUTdFOG1oWGkyREZtN1VX?=
 =?utf-8?B?VlJ5S1NBQkxjTUFXYk9SWGZmS2twUnJ1MUUyaWVqbmQwMysvRUZGNjVOV29w?=
 =?utf-8?B?VmRCVFJtcnFuejFoTVJDRFM4TnA1SFRsZVRpaUdBR1c2dVJuZ3d2YVNNTHJv?=
 =?utf-8?B?VzZBeWpNVFRLSHdhS1I1KytIbnI1M2NEWXU3VHRRV3lqVm8yZm5JSVVCRGdz?=
 =?utf-8?B?dlVvK0J4Zm5XY05haGZDSWN3N2IyTVZPRjRYSFZkeFMwZFhiOWhjY0ErajBn?=
 =?utf-8?B?U2oyQVV3Ly9PNnRncFdEMlFIK0tqTkJPRm1XTE5lL2h2YWR0ZFdNb3Y0Uk43?=
 =?utf-8?B?TXhlK3l1Mi9abHBSaHFiditSMENidjA1RW41RDBrZWpWMjh2eVRnVWJmeW9Z?=
 =?utf-8?B?RS9vRkJiL2NRVFVaVG54NTdNMWFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5488.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c989acd-5577-4a67-9510-08de3d16a974
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 02:47:47.4660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PpmncJZzushN7HVqiEiIvLewvnokP8qlf5+wEhu+ko2Bfkx/s8zK1hKXhjP03/feF7nwBP6YU2peBxmbezGHdP+AV3xtRxBChq1ERskjh4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6693
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

PiBGcm9tOiBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgRGVjZW1iZXIgMTcsIDIwMjUgODo1NyBBTQ0KPiANCj4gUmVwbGFjZSAlcGUgd2l0
aCAlZCBhbmQgYWRqdXN0IHRoZSBhcmd1bWVudCBhY2NvcmRpbmdseSBpbiBhIGRldl9lcnIoKSBj
YWxsDQo+IGluIHRoZSBwd20tYXNwZWVkIGRyaXZlci4gVS1ib290IGRvZXNuJ3Qgc3VwcG9ydCB0
aGUgJXBlIGZvcm1hdCBzcGVjaWZpZXIuDQo+IExpa2VseSBpdCB3YXMgY29waWVkIGZyb20gTGlu
dXguDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJy
ZS5jb20+DQoNClRoYW5rcyBmb3IgdGhlIGZpeC4NCg0KUmV2aWV3ZWQtYnk6IENoaWEtV2VpIFdh
bmcgPGNoaWF3ZWlfd2FuZ0Bhc3BlZWR0ZWNoLmNvbT4NCg==
