Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780BDEE0209
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 04:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAEA988A1B;
	Wed, 11 Sep 2024 06:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="DnQn4GnX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E4458915A; Wed, 11 Sep 2024 05:21:48 +0200 (CEST)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feae::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DB2E88F5B
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 05:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jacky_chou@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWhEw9u3a4G++2ajY/nsW+YpMsxl9ROXICiMAnR/o9mNe2fSCsL5IULJOFDCT4rBVQK6xv79h2WAibPQVEiBeIzdGrZsvkHjd4tRXW+Er/6eb4Q8tlrxRiJ9cv8p2tLF0JT+GENoZFSifnsJgRIRAxK5u2LIKccgEFRWtUenmf36S1L1NMlj3xVyRcjvLUXMfhCZZlKmbBKC2A7/RmK4Nuse1jqC2NHuhKLhFSUIvmhYigMqA5j/HwbgqN5eh00h8oRLJl919epg+5ltTEWH5DGnnOPKbdUdLl7cqhsSwnm37JU5F3C5HGehEHtIzUuUH1TvjJt+BsXD2NaVXCJTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0T3UJYXTs7gFPTJrRoFp6Acj8jq3wyEL0F6190KiEw=;
 b=U735OG9oj5qKscHnQMu2Vyr9pQtuKrrXY6Ny9EnqX5HCd3Sdl0daw3dp5r0oVOsfXTv4bt3LelXd0QxEbjYAYYvPPvXpTJexMmFPFjT6+xgE3ngKSVrymDngxWlXNzKPiugdMkMeDlRdAroyvSs6d1Yzn4Ax64b/kpLIF9NGsJFGqoAIas6x7wr4vgyrXb0oTESgQIN2bs0MnmglP/2FTuzpZfC3eWHdUiPjNFql5e6BinlRxnwJtbDEB1YlVSuw2YxvWPiuyiZ0ZdqJzrmmQAkwZBFvsCIpJuXlD9Kul3znTBHvA/U5iQuplcMeJ/3c3jT7FyJTaLwXsRLrAgspUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0T3UJYXTs7gFPTJrRoFp6Acj8jq3wyEL0F6190KiEw=;
 b=DnQn4GnXbXZIJnUeIaCvQwVEcZyv3rnp1REe2cR3ERrQFm/2qmW/mjnGPmrAjcInonKuyJANmVODJAy17F1mOoJPzGMU44iM/28BSEzh+4hZIEej6uIBtCyPn6LXDBOmfXNiUVcJMNUEP1vuKO5gLasm8FulfnSPQCx6tkGyUmh7cGYEfJW25bIaD1mpcEHxlE9Ilz2L+zjVmJRbXNDjk4d0SQpaB0veNeS3TYqIaW1jRYjDoT48qhdpi6U9hiAPFszlRFGNwZZLi3EDODLh60BAjPF7ptKyTk8lqIVGly+oi8KkQ0N82dLGSE3/xJMqVrFRAVpruPhcclY/am2eVw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB7169.apcprd06.prod.outlook.com (2603:1096:405:b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 11 Sep
 2024 03:21:39 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 03:21:39 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Joel Stanley <joel@jms.id.au>
CC: Ryan Chen <ryan_chen@aspeedtech.com>, ChiaWei Wang
 <chiawei_wang@aspeedtech.com>, BMC-SW <BMC-SW@aspeedtech.com>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "kobedylan@gmail.com"
 <kobedylan@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Andrew
 Jeffery <andrew@aj.id.au>
Subject: =?utf-8?B?5Zue6KaGOiBbUEFUQ0hdIG5ldDogZnRnbWFjMTAwOiBBZGQgQXNwZWVkIEFT?=
 =?utf-8?Q?T2700_support?=
Thread-Topic: [PATCH] net: ftgmac100: Add Aspeed AST2700 support
Thread-Index: AQHa0P0c+8pwJpOIYkmnapYF3U/pw7JRQaKAgAELSRA=
Date: Wed, 11 Sep 2024 03:21:38 +0000
Message-ID: <SEYPR06MB5134FC4DDDE3508168429FED9D9B2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20240708060718.186075-1-jacky_chou@aspeedtech.com>
 <CACPK8XdVr8G7hBQ3QA2tXqbMwMiRjo2u0tZSa_2YjJEh4a8Cig@mail.gmail.com>
In-Reply-To: <CACPK8XdVr8G7hBQ3QA2tXqbMwMiRjo2u0tZSa_2YjJEh4a8Cig@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB7169:EE_
x-ms-office365-filtering-correlation-id: 37693de6-e238-441c-687b-08dcd210d96c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N3d3ZzNnN2dnQjNuKzBQd3N1VVcrZGxRc2dGVG1FWWVkc29BVHp0MExuNS95?=
 =?utf-8?B?UmVFeHZmcURUUlRGUVNNNjVEUWpXdTV5b3JhYkRLM0ozRGNOb3pGMC81SVBm?=
 =?utf-8?B?aUxON3NUOUd5b0pVSk56bnFOTmppNEtQTFV6eWF2Mjk4alFZMEtoUkh3bnc2?=
 =?utf-8?B?dTUwTUxMRGNxa3lmcTc5VkptZUNSRFhjQm1oR3FxZitZY29PS0UzMzY0M2tP?=
 =?utf-8?B?WVpPL0YxeE9sN1kvQTZhd2ZWS0xnRmVTVGhya1ZEaW8yTDJnSUlMZ2hPUDJk?=
 =?utf-8?B?d3hQdkR3UGhPNmJ3QldCaDQ5WXhZTi9DK1VIQUwvK3pQLy8zRkxtYmV6NGsv?=
 =?utf-8?B?V2RiejZYY0p4VG1YKzVDTHl0V3NJZ2dMRXR6c3hpbitjZzRkTkV3YyttK1dI?=
 =?utf-8?B?bjYwbVc3ZjV2V2F3cnMzRFhBa2g3YWdXcllnM0xSMEZvRkZpWFdONUJpeTBI?=
 =?utf-8?B?T0k1cnRQeUlaT1hqby9INkY1R3JmdUVSVzNleWRUdnZQZDdEZVFhbWM5Nkhs?=
 =?utf-8?B?WWEwSkVtZXQwMTJOSW82b2xsajUyZHBwcjc0MVJ2cXJzaExFRXJSZk1hMmNa?=
 =?utf-8?B?SUM5WG5OYXcvZEsvZlR0OGp4WUpXMFZYTFpqOHBwMncyWHJ6eHZWemNQMHBC?=
 =?utf-8?B?YWFFaDZrZ01mR3oydnJGSEk1akErYXh2ZDdSYkFRelFCNXlqTUZJMDVDZzFR?=
 =?utf-8?B?SUlRTE9QVEU3aURYRWxiM25SL1dZQXBxSkVsaW9LNEwvTGNpTElNYlNtakk4?=
 =?utf-8?B?REZSNXRXdTRMWVNCdFAvdnhPVTRDYjc0YU9QSHgrMG96WXIvSW9IRFowMnFT?=
 =?utf-8?B?SGxIMlh0cEJSczBuNloxYUFaYm4yaGh1S1l4RWtZYXpnZmtwbWE4ZWw2WDJU?=
 =?utf-8?B?cnlqMnkwWnJHa2QzaUkrWHBNclc0VlF6RHlLZ2hXYVduenRDR0l6Z0VXZFA0?=
 =?utf-8?B?cXpFNlI4Y3h4TFJkeDBHcCswd204eWRCQndzNjJUQ1R0am9EM0F4S2hwNHcx?=
 =?utf-8?B?c2h3WlpuMkVkL1lHdXZ5MlVkMnBQWWo5M2xOMnEzVmx3OVVNMVlWcG5mTUJG?=
 =?utf-8?B?cFMzUVo4NFMzSlBTWjAvK214MW5pdm90RGtNSDlQU1dLT1VUekRWWk1NVWtK?=
 =?utf-8?B?Tzc1MmtiTnVuS0kvUWtxY2VsZ2lNQzlta1BpSTIvSkU5Z3o0UEFUWjZrMFB0?=
 =?utf-8?B?bnJYN0Rlek1uZEhTVFUyWmlOVHdnSE9aMm5ZUHBJTkdWdFlBMzlXWExxbHhK?=
 =?utf-8?B?R1hiRHU0UkZEYm1IbTFhdzVZT0lLN1hWUSt3WDJtWlV3aUN3L0pGR3ZRNGx6?=
 =?utf-8?B?Z3BndXVrYmlNdEEzYlp5aDE1cTlQd2tnWGhGVllWUGFKK3NCNnZGdVloVDl6?=
 =?utf-8?B?c0QwelY0Y2l3aVl5ZENwZXp6UzFsczF0anZkMHBMSjQ1RVB0bXFGT3FtVnR5?=
 =?utf-8?B?Mjl2dXBYekg5WHlDSVlRaXFQMS81RVlNOHg0S0dFeEJHSmM5dVhYQjVJVlRZ?=
 =?utf-8?B?WjhOMThCMDUvbEhnL3l5N3BTc3ZZNzlUNWpqVzZxdGdqeGJGaURaRDBpZ28w?=
 =?utf-8?B?NWpzWnR6eGc5MXpVUVA2RUZla2VrWnY1aW8yUDQ1TWJzVGEzaHlPR21sQXoy?=
 =?utf-8?B?K0FSc21IMld1dEg4TnBkWkJTeTZoVjBIbjA5OUNvOWxuVmp4QzhrRXVwaXNB?=
 =?utf-8?B?cXFWKzJaaWZwQVg1b3d4eHJyUTErMU1na0gvbUxSbjcyUWxGdXkvR1Y0VGpV?=
 =?utf-8?B?aFJRMm53SmtjUXVZSVNqVmlOa0ttdFYzWXZnekdvdHZPeFc0TEcxSXJHY1dM?=
 =?utf-8?B?Y2tEYWlZQWo3ZEliNUVxTUsvRi9lL29FTWhhNnJqWktUUkFDQWc3MGJpbE9Q?=
 =?utf-8?B?Vzk1alJqTnVYemR0a20rOWhtUXdSWlpjYU5vdGhPcHpsS1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR06MB5134.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGZ3ck9ZQzJtYVlsdDFIdXlLZklrU3g5TUswc3FESXhkTVFjaXBYNndzV01j?=
 =?utf-8?B?V0cxM0xsQ3liOEpzbXZWQjJWRHpzbzBZVUpEcWM0MENrZ0htY3Rmb2RJVmtk?=
 =?utf-8?B?YmcyVW42dmpaV2Zzb05PcFB6SzlkMDVUdzh6NjcxUS9tSU5VSks4MmdJc1Uz?=
 =?utf-8?B?UWtIMGw5SU9PNG5DMExDazJJQ1p6TW1sVEYzRmZtVXZ3a3lqY0tOOHN5bFJZ?=
 =?utf-8?B?U2tBMmlvOUx1cTZZLzVEVXhwVytNMDNEdGU2UVl6OTN3Uk9FWnVFY2VOMW4y?=
 =?utf-8?B?V1hSVkpoNklHN2ltaXhJZkYwUkdGSWtZZGM1WVBjdGtkT2VOWTJjVElneGtG?=
 =?utf-8?B?V21wVmJBb3ppbUdJZi9xNlRkcUZsa2x2TGpvVHVCK1BNVVE0aEhvdEdOQ2R0?=
 =?utf-8?B?dkFtNk5rRkV1NW1RRzJWWXdBS1NJNmxxZWExZUViR1lEcXZGeUJxemFrclhD?=
 =?utf-8?B?S215ZUVSbXpnanllWENraFAyN2daN2JYdGp2Nm1YSElhS0pvTTJJOU9pNFV6?=
 =?utf-8?B?TnNzS3k2ZDNVWlRRQkt3a0xlZTd1M0ppSXM5MUJJNlJ1eWR0aGlzV0ZnWTlB?=
 =?utf-8?B?cE1qVGRBUHhEbU1sTm54OE01d082MTB0dlJMd2RtUkVSNjF3Q1doTmNuRC9K?=
 =?utf-8?B?NXJ5RjJMWTBpNDVKRldFVnBzd2RGQW9aSENnM0s0WGxlMkhISjArUmxjYWhm?=
 =?utf-8?B?UVBSUFJUQ3FmZXg1UUZZM2U5U2lhcnJMblhzdGgyTk9BQnU2ZXRzTWM0OFVT?=
 =?utf-8?B?Ukk1ZXozRFkyb1BvN2IxbWliWlVPKzRRNlhsV1k3K2JFa0lNWTZReVNuV2ox?=
 =?utf-8?B?RG1OQjRTS3pRSEJ2czdGSmdzN2ZmbFlMaDNkL3o5aWZ6WjRUVUhmN1hMY3Nw?=
 =?utf-8?B?RUxETFdvRytzQW1BenVDYkMvVGpsckRMcFhqbG5JN3hlOWRZeEZRcHFNN3ZN?=
 =?utf-8?B?WFNVeHBHbk93SHhldnJMa2hici80M256dk5iZEpZbW5Ob0lhaDlWaHFYdU1j?=
 =?utf-8?B?OGxlYjY5eVJtWmdyMGFHem9kR3o3OEZLaGg2RDlaVDlLQXlmK0h0T2pZV2Qv?=
 =?utf-8?B?ay9KYWxtWTNoMzY1WWxyemI4eGxmbWQ2aUtaSjZzV08zME1sTUx2dzBlbktU?=
 =?utf-8?B?TGZ1VVF5eXY5RGdNb0h3RERBdVFuVGpYck50d2YxbDRDYzR4MDk0WDR6c1pk?=
 =?utf-8?B?N1p2OU84eGw3b2lIdDZZaWJXTENNaXpUemN5c2tMQytwWVF3aUdaQmMxWWxj?=
 =?utf-8?B?eml6UVFwdnVTWStiaWdXbnNSVUtxcjNvMUlNVE1MNW03TWtZak1GQS9mRGJ4?=
 =?utf-8?B?b2JtNk1lVFhKTUVhRGNXdW05YWh5bExwbWVmdU0yQ3hMaGhBcjMvSUlFU000?=
 =?utf-8?B?S1ZXZkd0WVBPT1lWdXFVZklxYVVEVm10TnVqNm5WckNFTE9aU3ZrekplelRS?=
 =?utf-8?B?SEk1NG9TNTlSaU43MmdhVEtCNno3NjdqNUlSZ21pL0plZGdLcjJIcGxsSnQz?=
 =?utf-8?B?emx5VjlsQXN0cVZOZHN4RHVPZUIwYkxLVmVjd2dCUjJCNDdLYms0M2M2bVRy?=
 =?utf-8?B?QW1aTHdvTEdFSitvT3NLZFhha1lmNlFpazBiY21TeHRMRmxwK21hanpYRVpz?=
 =?utf-8?B?TGlvWHdoUTIzV1VqR1pLNmdSUGRieFo2Z0JTY3QyazMwVjdRQ1VaUjlibVVq?=
 =?utf-8?B?WHE5TU9rR1NRZE82NEJiRFRjdjhucVNXNkhhNUoxKzBQUUNydnZ4Yno4Zm5q?=
 =?utf-8?B?V0dsdXdKZUtuRHFxQWNUYytiK2NYcmxyQmc4TFlhNndzM1VKaXl6eUJmL2pT?=
 =?utf-8?B?a1Z2anJiSzZZZ0Y2VVBiTFB1T2UyQnRISGtPaXZGMTlyQ1JCOStvcFVVWmJM?=
 =?utf-8?B?NHdCVDRPSVhVSUVpSWRxdkRBYkc3OTMwSkhxejNMLzhmeXlVOUszQjNZejVl?=
 =?utf-8?B?Y3QzUlZhRHFJUUs2bjRMMGR4QW10MXFsWXEzOHBtUzd6Mlk5WXR1dko0dDB0?=
 =?utf-8?B?RXZoQXhGSEViWUxLV0prT3JGb2RaaGNMallYNHE0aDBQZjJMY21NU0FoZ3Fz?=
 =?utf-8?B?QzFzaS9TaStBNlpieUFmN1ljYVZQc0tLL2VsUjlqYk5GSzJqcWdVMkJCNHBQ?=
 =?utf-8?Q?WTl+EEXvVsjIGDvUVGcyAt9sp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37693de6-e238-441c-687b-08dcd210d96c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 03:21:38.8254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XA3T0WJDKYyNK8S2NI6B0ta1sadbympqGIe8YAdF+V/c9Y0yWGl1wc69Vx3vALggjqbeWMvCwfgo99vmdPNYMjO35PzE2P1qOx8peI2bZNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7169
X-Mailman-Approved-At: Wed, 11 Sep 2024 06:59:37 +0200
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

SGVsbG8gSm9lbCwNCg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KDQo+ID4NCj4gPiBBZGQgc3Vw
cG9ydCBvZiBBc3BlZWQgQVNUMjcwMCBTb0MuICBBU1QyNzAwIGlzIGJhc2VkIG9uIEFSTTY0IHNv
DQo+ID4gbW9kaWZ5IHRoZSBETUEgYWRkcmVzcyByZWxhdGVkIGNvZGUgdG8gZml0IGJvdGggQVJN
IGFuZCBBUk02NC4NCj4gPiBCZXNpZGVzLCB0aGUgUk1JSS9SR01JSSBtb2RlIGNvbnRyb2wgcmVn
aXN0ZXIgaXMgbW92ZWQgZnJvbSBTQ1U1MDAgdG8NCj4gPiBNQUM1MCBzbyBpbml0aWFsaXplIHRo
ZSByZWdpc3RlciBpbiBmdGdtYWMxMDBfc3RhcnQgY29ycmVzcG9uZGluZ2x5Lg0KPiANCj4gSXQg
bG9va3MgbGlrZSB0aGVzZSBjaGFuZ2VzIHdpbGwgYWZmZWN0IHRoZSBvbGRlciBwbGF0Zm9ybXMu
IEhhdmUgeW91IHRlc3RlZCBvbg0KPiBhbiBhc3QyNjAwPw0KDQpZZXMuIFdlIGhhdmUgdmVyaWZp
ZWQgb24gQVNUMjYwMCBhbmQgQVNUMjcwMC4gVGhlc2UgY2hhbmdlcyBkbyBub3QgYWZmZWN0Lg0K
DQo+IA0KPiBJcyBpdCBva2F5IHRvIGJlIHdyaXRpbmcgdG8gdGhlIG5ldyBtZW1vcnkgbG9jYXRp
b25zIG9uIHRoZSBvbGQgcGxhdGZvcm1zPyBJZg0KPiB0aGlzIGlzIHRoZSBjYXNlLCBwbGVhc2Ug
bWVudGlvbiBpdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNClllcy4gSSB3aWxsIHJlZmluZSB0
aGUgY29tbWl0IG1lc3NhZ2UgdG8gYWRkIG1vcmUgaW5mb3JtYXRpb24gaW4gdGhlIG5leHQgdmVy
c2lvbi4NCg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZnRnbWFjMTAwLmMgYi9k
cml2ZXJzL25ldC9mdGdtYWMxMDAuYyBpbmRleA0KPiA+IDlmYjhjMTI4MzguLmE5MDlhMGIzMDkg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZnRnbWFjMTAwLmMNCj4gPiArKysgYi9kcml2
ZXJzL25ldC9mdGdtYWMxMDAuYw0KPiANCj4gPiBAQCAtMzIxLDYgKzMzMyw3IEBAIHN0YXRpYyBp
bnQgZnRnbWFjMTAwX3N0YXJ0KHN0cnVjdCB1ZGV2aWNlICpkZXYpDQo+ID4gICAgICAgICBzdHJ1
Y3QgZXRoX3BkYXRhICpwbGF0ID0gZGV2X2dldF9wbGF0KGRldik7DQo+ID4gICAgICAgICBzdHJ1
Y3QgZnRnbWFjMTAwX2RhdGEgKnByaXYgPSBkZXZfZ2V0X3ByaXYoZGV2KTsNCj4gPiAgICAgICAg
IHN0cnVjdCBmdGdtYWMxMDAgKmZ0Z21hYzEwMCA9IHByaXYtPmlvYmFzZTsNCj4gPiArICAgICAg
IHVuaW9uIGZ0Z21hYzEwMF9kbWFfYWRkciBkbWFfYWRkciA9IHsuaGkgPSAwLCAubG8gPSAwfTsN
Cj4gDQo+IFlvdSBhbHdheXMgc2V0IGRtYV9hZGRyIGJlZm9yZSB1c2luZyBpdCwgc28gdGhpcyB6
ZXJvLWluaXQgaXMgdW5uZWNlc3NhcnkuDQoNCkFncmVlLiBJIGNoZWNrZWQgdGhpcyBwYXJ0IGFn
YWluLiBJdCBkb2VzIG5vdCBuZWVkIHRvIGluaXRpYWxpemUgdGhlIHZhcmlhYmxlIHRvIHplcm8u
DQpJIHdpbGwgcmVtb3ZlIGl0IGluIHRoZSBuZXh0IHZlcnNpb24uIFRoYW5rcyBmb3IgeW91ciBr
aW5kbHkgcmVtaW5kZXIuDQoNCj4gDQo+ID4gQEAgLTM1Miw3ICszNjYsMTQgQEAgc3RhdGljIGlu
dCBmdGdtYWMxMDBfc3RhcnQoc3RydWN0IHVkZXZpY2UgKmRldikNCj4gPiAgICAgICAgIGZsdXNo
X2RjYWNoZV9yYW5nZShzdGFydCwgZW5kKTsNCj4gPg0KPiA+ICAgICAgICAgZm9yIChpID0gMDsg
aSA8IFBLVEJVRlNSWDsgaSsrKSB7DQo+ID4gLSAgICAgICAgICAgICAgIHByaXYtPnJ4ZGVzW2ld
LnJ4ZGVzMyA9ICh1bnNpZ25lZCBpbnQpbmV0X3J4X3BhY2tldHNbaV07DQo+ID4gKyAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGludCBpcF9hbGlnbiA9IDA7DQo+ID4gKw0KPiA+ICsgICAgICAgICAg
ICAgICBkbWFfYWRkci5hZGRyID0gKGRtYV9hZGRyX3QpbmV0X3J4X3BhY2tldHNbaV07DQo+ID4g
KyAgICAgICAgICAgICAgIHByaXYtPnJ4ZGVzW2ldLnJ4ZGVzMiA9DQo+IEZJRUxEX1BSRVAoRlRH
TUFDMTAwX1JYREVTMl9SWEJVRl9CQURSX0hJLCBkbWFfYWRkci5oaSk7DQo+ID4gKyAgICAgICAg
ICAgICAgIC8qIEZvciBJUCBhbGlnbm1lbnQgKi8NCj4gPiArICAgICAgICAgICAgICAgaWYgKChk
bWFfYWRkci5sbyAmIChQS1RBTElHTiAtIDEpKSA9PSAwKQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGlwX2FsaWduID0gMjsNCj4gPiArICAgICAgICAgICAgICAgcHJpdi0+cnhkZXNbaV0u
cnhkZXMzID0gZG1hX2FkZHIubG8gKyBpcF9hbGlnbjsNCj4gDQo+IFBsZWFzZSBleHBsYWluIHdo
eSB0aGUgb2xkIGNvZGUgZGlkbid0IG5lZWQgYWxpZ25tZW50IGFkZGVkLCBhbmQgdGhlIG5ldw0K
PiB2ZXJzaW9uIGRvZXMuDQoNClNvcnJ5LiBJIGZvcmdvdCB0aGUgZHJpdmVyIG5vIGxvbmdlciBu
ZWVkIHRvIHN1cHBvcnQgSVAgYWxpZ25tZW4uDQpJUCBhbGlnbm1lbnQgd2FzIG9yaWdpbmFsbHkg
c3VwcG9ydGVkIGJlY2F1c2UgdGhlIE5DU0kgUEhZIGRyaXZlciB3b3VsZCBjcmFzaC4NCkkgaGF2
ZSBmaXhlZCB0aGUgTkNTSSBQSFkgZHJpdmVyIGFuZCBoYXZlIHN1Ym1pdHRlZCBmaXhlZCBwYXRj
aCB0byBVLWJvb3QuDQpBbmQgaXQgaGFzIGFjY2VwdGVkLiBUaGVyZWZvcmUsIEkgd2lsbCByZW1v
dmUgdGhpcyBwYXJ0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCj4gDQo+ID4gQEAgLTM5NCw2ICs0
MTksMTAgQEAgc3RhdGljIGludCBmdGdtYWMxMDBfc3RhcnQoc3RydWN0IHVkZXZpY2UgKmRldikN
Cj4gPiAgICAgICAgICAgICAgICAgRlRHTUFDMTAwX01BQ0NSX1JYX1JVTlQgfA0KPiA+ICAgICAg
ICAgICAgICAgICBGVEdNQUMxMDBfTUFDQ1JfUlhfQlJPQURQS1Q7DQo+ID4NCj4gPiArICAgICAg
IGlmIChwcml2LT5pc19hc3QyNzAwICYmIChwcml2LT5waHlkZXYtPmludGVyZmFjZSA9PQ0KPiBQ
SFlfSU5URVJGQUNFX01PREVfUk1JSSB8fA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHByaXYtPnBoeWRldi0+aW50ZXJmYWNlID09DQo+ID4gKyBQSFlfSU5URVJGQUNFX01P
REVfTkNTSSkpDQo+IA0KPiBVc2UgZGV2aWNlX2lzX2NvbXBhdGlibGUoZGV2LCAiYXNwZWVkLGFz
dDI3MDAtbWFjIikgaW5zdGVhZCBvZiBhZGRpbmcNCj4gaXNfYXN0MjcwMC4NCg0KQWdyZWUuIEkg
d2lsbCBhZGp1c3QgdGhpcyBjb2RlIHVzaW5nIGRldmljZV9pc19jb21wYXRpYmxlKCkgaW4gdGhl
IG5leHQgdmVyc2lvbi4NCg0KPiANCj4gPiArICAgICAgICAgICAgICAgbWFjY3IgfD0gRlRHTUFD
MTAwX01BQ0NSX1JNSUlfRU5BQkxFOw0KPiA+ICsNCj4gPiAgICAgICAgIHdyaXRlbChtYWNjciwg
JmZ0Z21hYzEwMC0+bWFjY3IpOw0KPiA+DQo+ID4gICAgICAgICByZXQgPSBwaHlfc3RhcnR1cChw
aHlkZXYpOw0KPiA+IEBAIC00NDMsOSArNDcyLDExIEBAIHN0YXRpYyBpbnQgZnRnbWFjMTAwX3Jl
Y3Yoc3RydWN0IHVkZXZpY2UgKmRldiwgaW50DQo+IGZsYWdzLCB1Y2hhciAqKnBhY2tldHApDQo+
ID4gICAgICAgICB1bG9uZyBkZXNfc3RhcnQgPSAoKHVsb25nKWN1cnJfZGVzKSAmIH4oQVJDSF9E
TUFfTUlOQUxJR04gLQ0KPiAxKTsNCj4gPiAgICAgICAgIHVsb25nIGRlc19lbmQgPSBkZXNfc3Rh
cnQgKw0KPiA+ICAgICAgICAgICAgICAgICByb3VuZHVwKHNpemVvZigqY3Vycl9kZXMpLCBBUkNI
X0RNQV9NSU5BTElHTik7DQo+ID4gLSAgICAgICB1bG9uZyBkYXRhX3N0YXJ0ID0gY3Vycl9kZXMt
PnJ4ZGVzMzsNCj4gPiArICAgICAgIHVuaW9uIGZ0Z21hYzEwMF9kbWFfYWRkciBkYXRhX3N0YXJ0
ID0geyAubG8gPSAwLCAuaGkgPSAwIH07DQo+IA0KPiBTYW1lIGhlcmUuDQoNCkkgd2lsbCByZW1v
dmUgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4gVGhhbmtzIGZvciB5b3VyIGtpbmRseSByZW1pbmRl
ci4NCg0KPiANCj4gPiAgICAgICAgIHVsb25nIGRhdGFfZW5kOw0KPiA+DQo+ID4gKyAgICAgICBk
YXRhX3N0YXJ0LmhpID0gRklFTERfR0VUKEZUR01BQzEwMF9SWERFUzJfUlhCVUZfQkFEUl9ISSwN
Cj4gY3Vycl9kZXMtPnJ4ZGVzMik7DQo+ID4gKyAgICAgICBkYXRhX3N0YXJ0LmxvID0gY3Vycl9k
ZXMtPnJ4ZGVzMzsNCj4gPiAgICAgICAgIGludmFsaWRhdGVfZGNhY2hlX3JhbmdlKGRlc19zdGFy
dCwgZGVzX2VuZCk7DQoNClRoYW5rcywNCkphY2t5DQo=
