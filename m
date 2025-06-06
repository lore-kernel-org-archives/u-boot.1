Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D0FC5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 07:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82855828F8;
	Fri,  6 Jun 2025 09:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="czbqDVl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A859082977; Fri,  6 Jun 2025 09:12:38 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE4E81FEE
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 09:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5Db2LjhqFP5LbmPslV/Q2fippTv0fHPgRkgsYIY26ZdyoL12ghEXdBdTdQNPDFtsuLgjyQcAw3ZxS1OUIPqM7WUxVYy3/c3CSDQM90Aw7FyaVPhJNY9c4IbAreBAYZ1mWdvaSiCPs+bT8mARr8CgLM3XqgxImicr8dVRNrCh2Otd2GOrohW2+vLG7H0rMk37gXHnhJNRU5/isnZdCWE7LWqcySAOWah6U7+fVCpNj163bf3I2UlQtw+98ZeQpJIP9705wWt+7D3Rdec/57HOdZDEErogUkJPDFog7C2Y6P5R7p7r8agzUeS4IxiFEiDfnIEF7c2g6YwaFTvjg96sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGg7aENzk6sOz3G914p04nbpdx1Ya2HzVM4gUDVAYv0=;
 b=mGDWNYTmGsJRDMmuWFcjXDxAKduzgq3fXrswwwzaLz0veREM3xY5nACHCP8ao3ffucVnWKloV6qpL5CTdSX0kA7FziO29xPJOUc+bgrKMiuiQKRQnfzMe8360ttGZiMX4DjHa1Wo0RcXTWH3LC/85Ptwp15CTwZhTE3rTIHFpHCIcQ8QAtk6yP6Z+cYnbtG2+AyaRBwDRXCIydCQQMTlSw39m86WzcAJoowtJUnkjFUMfX+QW8PCV/plCfeSRc5ROzExV2awG3TnVWe27FH8A3bPRcn97RQBx08a21HVlVWZnvjMupsGeBz5cswWbq1ADspun1Kiq68XAT8wNqrpmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGg7aENzk6sOz3G914p04nbpdx1Ya2HzVM4gUDVAYv0=;
 b=czbqDVl2ZTqzevVaheWUEQKrzxzIcw0gKCIryhp6Sl+eUHFKzBlEUsHVUAwzCt+ZpAuYAyBf07K7AdZ5qUtxgy3PJYSiziP03hpeD1ZMSEQQFFt37bLHSqbc1tgQ3QFvcw9o2u4xyCg4/jJtxWCC5MmLLUUMnfwBTLG6gjAAgkdr9Fk3+wl1qJT1Ttl939+HQw6AhHBxGRG8GYhRGGT1x5tK8EBJ20HY2Cs18MMAs6r7VScHvy20HNKEUbL5wVN/aG5zx1ze7C0yvEEPI36zR5dIeh2uu9TmVixKEMLR5SPzUGydpq77v353rpD7YNEN59KIqdMhPEFuYlLvhsB0KA==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by VI1P195MB2460.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:1c6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 07:12:32 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582%6]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 07:12:31 +0000
From: Martin Schwan <M.Schwan@phytec.de>
To: "trini@konsulko.com" <trini@konsulko.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>
CC: "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Wadim Egorov <W.Egorov@phytec.de>
Subject: Re: [PATCH v3 0/2] bootstd: New bootmeth for RAUC A/B systems
Thread-Topic: [PATCH v3 0/2] bootstd: New bootmeth for RAUC A/B systems
Thread-Index: AQHb1UqJu7bU4cfQfUG48IKL6GPmkrP02REAgAAl7ACAAA8uAIAAq/sA
Date: Fri, 6 Jun 2025 07:12:31 +0000
Message-ID: <9f8d945cc28bd501b39c0347f8b066492b0a2ab9.camel@phytec.de>
References: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
 <5621cd82-042a-48be-a708-a29ea96d4f7b@linaro.org>
 <20250605200238.GE1382132@bill-the-cat>
 <db594851-3e08-420a-a8d2-291eabe64a98@linaro.org>
In-Reply-To: <db594851-3e08-420a-a8d2-291eabe64a98@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|VI1P195MB2460:EE_
x-ms-office365-filtering-correlation-id: fe920f71-f35e-4789-b3e6-08dda4c98119
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cmNYVDA3c1dGdUNqREJ5K1lGeHlHSXBINWszUlFGcE9kQVdiS3B5TGpkY1l0?=
 =?utf-8?B?OVBlaW83bkt1KzJITzQxckwyKzhLYnFreGViNHRLUWhTSldUYVR6OS9CdFdn?=
 =?utf-8?B?VVVIakQ0aHZGQXZpUGJqWC9vaHVpRFBLWG9TOEZWNXB4KzZBclFubXJUY2FB?=
 =?utf-8?B?c3Y1Umdydzg2RU12dDlZV2swRElPSFZVT2M2NGFzSWptSWp3V0tKSVorN2Rt?=
 =?utf-8?B?d1hXeWpFdTFNbGx6bk5zTTRYb2tsd0RiMW95ZkxBNXpwQ05oVC9pSStqd2t4?=
 =?utf-8?B?OWRQNVh4OFNrSkd1QUVKMmI2NWNXVFpxSzBqL0RRcllSZ0hHWjlEZ0Mxb2tx?=
 =?utf-8?B?SWdkVENOaXdmRXh3ZEk3MWlvQnJHT09kMGhwRzVoQUExbjFXZklsNkp5RDdL?=
 =?utf-8?B?LzdzTWxKNHY1YnFsRzZhUmYwSjlkc3lheTZrSzhDNXlVWmtPQlVnVGZ4NkZv?=
 =?utf-8?B?L1A2RHhtMkFzZ3pBY1FPM29iTFdtNFNCaTlXYVg2ZUphZGIyeHlEWmk0WkNJ?=
 =?utf-8?B?cnZYU2VMKzVZbks2REJOKzJFalZOR1JDdWgwZ2dNME5jdVgwbWwrRTNRUHB0?=
 =?utf-8?B?VVRxTnA5Zm9wQVdML25uUlVPMGt0b2lSbXZyMUQ4VEkvTWVEMCtkdkFPOXZp?=
 =?utf-8?B?QlcyKzV1YlhEaGZmbDJ0aTBzODlxaEJ6eUhpdnMxK0tTanZXUEYvM0VlYWpy?=
 =?utf-8?B?WHJrcmtldHpqM1ZzVS9yak1CVUhjUVROQ2NaUkhKWnpIdExISzJwMmNIckdC?=
 =?utf-8?B?dlY5WXpEY3loTmJtVWtYU1h1cTFlVkJUcnBtK3J2RTZXdU5GTCtwZVJhV2xO?=
 =?utf-8?B?SFNlU3VZZW1PbmttS0V6YW5IdWQ1LzlsTDRacHdmbVRWbDZDalRPUUxnYnVv?=
 =?utf-8?B?UXVHZk9EcDUybkdveVkrZ0E2YVN5Y3pzS1FSenV0a0NxeDBNV1JXMytrZmJR?=
 =?utf-8?B?bkhlVmF0Z3IvemR0YnVSUzJOWC9Eckl5MTJFOFJDZisxbUxSU0daUklGdnBX?=
 =?utf-8?B?ajZZM3M1bDBwazJjOHdVZnJoVXZvWDI2Rm5iY3hFbmw2NXo0YVNMSWRNWlEy?=
 =?utf-8?B?V0xzalVvZ3pHYlFEN213RFNoZFMvOVVZMGZ5MGVvSmNBcEl1R2NabU94cDhJ?=
 =?utf-8?B?c1BXQ1d3QkxYV0VCOUFZb1JOWVgva1cvTWQ2NWx3eTlhUGlPeHJFOVZaa29w?=
 =?utf-8?B?YVBNaGU3d1pVQjdoUjBTcHdxbXpabUFkTTdTSlhrYkhyVzl2QU9qVlB0R1d4?=
 =?utf-8?B?dUtwOGhVWXBBOE9mTWVvYURCRWU5b3pkOTRiZmZ1UlQ0M2dMMXYweWhXdkJt?=
 =?utf-8?B?MFBGMEZpdGtnTVRVbXB1V0t1YnYxOWNLK1g0N2srYVFFcVFjMSttaFdMR1Nr?=
 =?utf-8?B?ZVNLUkVDT2srTFd4RmVaZWkzcjNrZVgzYVZBTjduS2JmMzF5WlcvZmh1djRL?=
 =?utf-8?B?dXFNT1piZExLUHMzK20yeEg1MXQ0bnhLeUNsVVA5THNySG5nSHVFU0pGZ3Br?=
 =?utf-8?B?NGozVDJRc0pzVjVhbW9nV3EyKzcwaVRoVFBSNTNiYlovaXRKZ3Jqd1I3RUJG?=
 =?utf-8?B?SVZweXBCZmdUUmJKUFd6dWpaMGg1R3ZldW1TVmNrNWttUHZtN1IreHRvSWx3?=
 =?utf-8?B?TjVjUjFUaCtEL0tkT2RRaUh5VzRJR3pnQnI4ZXBRcHp1QlRCK3NXNFRxVEEr?=
 =?utf-8?B?eHVES2ZGTE9QNUZSV0N3dFY3MEpUSjJTNEVQWlpIeXdRamdVVUpHa2NMRU0w?=
 =?utf-8?B?d1J5UzZvQVdvVi9rY2VtREVuS29aOWxidGdlc2tlbDNjSXRIUExIV3RabnA3?=
 =?utf-8?B?Ui9jb01hdG1ucW9WYmVydWxmU2trVk5GRktEanpJbktoS2tUb3N2VllxRDh2?=
 =?utf-8?B?dk1BTVk5VHVXSDRLVUplV1QzNVAwZWtIMUJVSGNsazJNeXYyMTVWaE5XRjlv?=
 =?utf-8?Q?fbsnnT8KnrQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T29FNW5BblN0TEtIWnRwZDhKenJ0eEsrYVdQMkJyREFGenJGb2lIN0Qvdnlv?=
 =?utf-8?B?eTBJS3pQOTFHMFBlbzFUYjZUN084OWlPRXNvOUtHSkZOVWJTeEg3UmRNUlMw?=
 =?utf-8?B?dHhUYk4yaG9XZUFsZ2tOaTZ4UnRzQzZiUGFsN3hQclZCdFhpNngwWjUrMFdR?=
 =?utf-8?B?ZGsvOUlONTFtTXJrTmF4Yk94M0tleC9ZNlVXNHhQcXphNzJCdGduZUFRS2Nl?=
 =?utf-8?B?cksyekU1S0d3dDhiYjlYNDdBeG90clhKQzhRUk5xakQzRHJZRWwyNkc5ei85?=
 =?utf-8?B?V211UURkelNXVmo2aFRjK3hTYjVFY1ZxMU1scFU1d0RZWEUwRmNyU0ZPNHF5?=
 =?utf-8?B?cWJ4ZFZ0M0J5SEZkdVA4ZVZLYlJFbU0xUDhyOVdPRTM2b2x1b2hRWWZ6TVFy?=
 =?utf-8?B?R21pK05sMWM4OXJLR2lnc1ZibllucGZpd3dnNm9sdk9pd3JMamYvcXQzalNL?=
 =?utf-8?B?aDBiVm85QmtIalZOSlNnUWdIWTA2dVdKOWREVG5ueXJoVnAxRW52eVFYSEFU?=
 =?utf-8?B?ck9zZHJVV1FRWlkzOTVWUldpZnh4REFrM1RyUVZ2Q3BsLzVJMUwrVUpGQ1kz?=
 =?utf-8?B?Q0NKdVZ0NjJZR2hPa0NQUTkyMWpzZjUzWVVhM3NFcGxyTXFSQUh2RGFmN0tx?=
 =?utf-8?B?cmgwamV4Wm91MDViL3JxaDBhanJ6YlVvZ0lZMHRoSk8vcndMUkVZczBhcmh5?=
 =?utf-8?B?QVdXeWJSTHN2NjhSNnNyb2hDaHVFRDFtdjNFTmQ5TldQa09LKzZIVUMva1Q1?=
 =?utf-8?B?MU1SU1dUWm1LWEk1bTFVb29QYkMzVExZT3FxaXc0bHFJZzIxUmdERkRWQkZV?=
 =?utf-8?B?UmdIMnVPWmI3QVVqMEJ4enlBNkhpdTVPcHZqVi9ROFp2Wmtsa2hrbXhrSHVY?=
 =?utf-8?B?bVJXKzlDVkV2VnZVazJZemd1LzNodHg4VGdXN1hwTEk1U09kYlNlZmJYOHJF?=
 =?utf-8?B?STBOTkk5ejBwb1d5RytFaTB1Y1dBN1RvRHNqWm9LL2sySTg3UWU1dGhyL3Fm?=
 =?utf-8?B?NFJNY2c1Y3RmQkpBblBLMk5vRjNta0ZiT2dxWlpQQm1vSkR5YS9SQlNTaUpE?=
 =?utf-8?B?aGQyQnRLYm9Ybjg2WHVkdjNmckRmYlpoanlNU2d2N0pTNktlbE5ZUWdIWGhK?=
 =?utf-8?B?R0xKRy9MRmZDS09oMVE1ZWw3Q0g1NnM3TTdEa3UxMHFRK0QwbmFOQ0JQQmZV?=
 =?utf-8?B?eHZkb05GTHA3TWdvd0lFZ1I3UUZkNXBoNXJ5ek95V2NRV1FDaHNvV012bXAv?=
 =?utf-8?B?T2R6bUF1RTZVd0xzeGRYR25SdHBoOFpsMjdId3NXZEdjbmEwMi8xNFBMVzR2?=
 =?utf-8?B?TVQrTkVCWUMvTG9pTkN1TjRwM04xVk84NTh4aXBmOEp5UFU2Ym5Ba2w0TkdD?=
 =?utf-8?B?b2ZSdTl0eXpjcW10c0kzN3BqZlRScHc0b0V3MEJDV2srWFRPWWFUUU1TTjZ4?=
 =?utf-8?B?T3JZZm5idU5yY2NGR2dZckNFajljU1ArVnRXSS9KZWhhMEJDV0p5K2VSWGJz?=
 =?utf-8?B?bnZIK0NiRGx0R0p5dTdSZVc2bU1nZE0wWm1ua0RwV3l2MnByV0RLNEVpSlpQ?=
 =?utf-8?B?Yys5KzlnNktQM1dlT1ppKytKZG9qK0NtM25QOGFYZlJvL2Mra01sVU0zN0R2?=
 =?utf-8?B?ZTlhSWxLemcyVXFCenRyT1hTbTd5bTNNSkEvWlVzWE1Lbkg3cFhNNithcVNI?=
 =?utf-8?B?VlkxWkpzNmczRkFKNSt5OHVNeUdmL1kxdFRUMW94UlFuTUFHQThJY3F6Ni9l?=
 =?utf-8?B?bEh6UnE1azBSTEd2YjdHMitQR0M1dDdweUVWaDVxekFLSDh4OHhKSmZ2c0Nk?=
 =?utf-8?B?K0IrYUtOSVdOOXdOdFFPU1BqTWV2ZnorWXFuZjhkVlhtc3MwMUJvTk14ZHB6?=
 =?utf-8?B?N1JRaE9wRENRTUg3U0p5Zkg2cldrVUozc2JkU0ovcXFkSTNHWDQzUThvekJh?=
 =?utf-8?B?dE4wSXlvS1BPM3hud2lQdkpXN3hnaVM3V3VFZ0VaT3N6UFhVekxpUGpsUldM?=
 =?utf-8?B?T0tHTHFFUy9wLzhZeHd0ZTZWZml1eDVjcm8zUEh6MkhJTjFsKzRBWHllcHZL?=
 =?utf-8?B?YVkvVnVaOHVvanpDaEpYa09tckh1UEh3ME5scURKOTg1bXRrY05pSXZZUkRY?=
 =?utf-8?B?K1FiNkdNTzllaEVNR3A1SEpnc2MzY053bGZRN3BCak0rbml6L096aHVlSVd4?=
 =?utf-8?Q?vEM28TVFPd4kP7elWFLqqbJCJVs+2VhbOUtMnBaXlMv9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6299ACF38E06D42B30FC64C253B9A9E@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fe920f71-f35e-4789-b3e6-08dda4c98119
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 07:12:31.7586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gn6F60N5rUGkZBL0JOGi87vJhC3+beUzbHvB19rJMADV57upfW+IN5lo9W49+gEQzYSOHGyGmPFbRZSBRaerVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB2460
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

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBNTEyDQoNCkhpIFRv
bSwNCkhpIE5laWwsDQoNCmZpcnN0IG9mIGFsbDogVGhhbmsgeW91IGZvciB0aGUga2luZCB3b3Jk
cyENCg0KT24gVGh1LCAyMDI1LTA2LTA1IGF0IDIyOjU2ICswMjAwLCBOZWlsIEFybXN0cm9uZyB3
cm90ZToNCj4gT24gMDUvMDYvMjAyNSAyMjowMiwgVG9tIFJpbmkgd3JvdGU6DQo+ID4gT24gVGh1
LCBKdW4gMDUsIDIwMjUgYXQgMDc6NDY6NTRQTSArMDIwMCwNCj4gPiBuZWlsLmFybXN0cm9uZ0Bs
aW5hcm8ub3JnwqB3cm90ZToNCj4gPiA+IEhpLA0KPiA+ID4gDQo+ID4gPiBPbiAwNC8wNi8yMDI1
IDE0OjE1LCBNYXJ0aW4gU2Nod2FuIHdyb3RlOg0KPiA+ID4gPiBUaGlzIHNlcmllcyBpbXBsZW1l
bnRzIGEgbmV3IGJvb3RtZXRoIGZvciBSQVVDIEEvQiBzeXN0ZW1zLg0KPiA+ID4gPiBSQVVDIChS
b2J1c3QNCj4gPiA+ID4gQXV0byBVcGRhdGUgQ29udHJvbGxlcikgaXMgYSBsaWdodHdlaWdodCB1
cGRhdGUgY2xpZW50LA0KPiA+ID4gPiBwcm92aWRpbmcgIlNhZmUNCj4gPiA+ID4gYW5kIFNlY3Vy
ZSBPVEEgVXBkYXRlcyBmb3IgRW1iZWRkZWQgTGludXgiLiBTZWUgdGhlIGZvbGxvd2luZw0KPiA+
ID4gPiBsaW5rcyBmb3INCj4gPiA+ID4gbW9yZSBpbmZvcm1hdGlvbiBhYm91dCBSQVVDOg0KPiA+
ID4gPiANCj4gPiA+ID4gwqDCoMKgIGh0dHBzOi8vcmF1Yy5pby8NCj4gPiA+ID4gwqDCoMKgIGh0
dHBzOi8vcmF1Yy5yZWFkdGhlZG9jcy5pby9lbi9sYXRlc3QvDQo+ID4gPiA+IA0KPiA+ID4gPiBQ
SFlURUMgdXNlcyBSQVVDIGluIGl0cyBZb2N0byBiYXNlZCBkaXN0cmlidXRpb24gIkFtcGxpcGh5
IiBhcw0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gZGVmYXVsdCB3YXkgb2YgdXBkYXRpbmcgZW1iZWRk
ZWQgZGV2aWNlcyBiYXNlZCBvbiBQSFlURUMNCj4gPiA+ID4gaGFyZHdhcmUuIFNvDQo+ID4gPiA+
IGZhciwgdGhlIGxvZ2ljIHNlbGVjdGluZyB0aGUgY29ycmVjdCBwYXJ0aXRpb25zIGFuZCBmaWxl
cyB0bw0KPiA+ID4gPiBib290IHdhcw0KPiA+ID4gPiBiZWluZyBpbXBsZW1lbnRlZCBpbiB0aGUg
VS1Cb290IGVudmlyb25tZW50LiBXaGlsZSB0aGlzIGlzIGENCj4gPiA+ID4gc3RyYWlnaHRmb3J3
YXJkIHdheSB0byBkbyBpdCwgYWRkaW5nIGFuZCBzdXBwb3J0aW5nIG5ldw0KPiA+ID4gPiBwbGF0
Zm9ybXMgYmVjYW1lDQo+ID4gPiA+IHNvbWV3aGF0IHRlZGlvdXMgYW5kIGlzIHBsYXRmb3JtLXNw
ZWNpZmljLiBUaGUgaW50cm9kdWN0aW9uIG9mDQo+ID4gPiA+IFUtQm9vdCdzDQo+ID4gPiA+ICJT
dGFuZGFyZCBCb290IiBwcm92aWRlZCBhIGNvbnZpbmNpbmcgYWx0ZXJuYXRpdmUsIHByb21pc2lu
ZyBhDQo+ID4gPiA+IHNpbXBsZXINCj4gPiA+ID4gYW5kIG1vcmUgcG9ydGFibGUgd2F5IG9mIGJv
b3RpbmcsIGV2ZW4gZm9yIFJBVUMgc3lzdGVtcy4gVGhpcw0KPiA+ID4gPiBsZWQgbWUgdG8NCj4g
PiA+ID4gaW1wbGVtZW50IGEgbmV3IGJvb3RtZXRoIHN1cHBvcnRpbmcgUkFVQyBBL0Igc3lzdGVt
cy4gTm90ZSwNCj4gPiA+ID4gdGhhdCB0aGlzDQo+ID4gPiA+IG5ldyBib290bWV0aCBpcyBub3Qg
cHJvcHJpZXRhcnkgdG8gUEhZVEVDIHByb2R1Y3RzIGFuZCBpcw0KPiA+ID4gPiBkZXNpZ25lZCB0
bw0KPiA+ID4gPiB3b3JrIG9uIG90aGVyIGhhcmR3YXJlIHdpdGggYSBSQVVDIEEvQiBzeXN0ZW0s
IHRvby4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBib290bWV0aCBjdXJyZW50bHkgb25seSBzdXBw
b3J0cyBzeW1tZXRyaWMgQS9CIHBhcnRpdGlvbmluZw0KPiA+ID4gPiBsYXlvdXRzLg0KPiA+ID4g
PiBFLmcuIEEvcmVzY3VlIGlzIG5vdCAoeWV0KSBzdXBwb3J0ZWQuIFRoZSBwYXJ0aXRpb24gaW5k
ZXhlcyBhbmQNCj4gPiA+ID4gZGVmYXVsdA0KPiA+ID4gPiBzbG90IHRyaWVzIGNhbiBiZSBzcGVj
aWZpZWQgdmlhIGNvbmZpZ3VyYXRpb24gb3B0aW9ucy4NCj4gPiA+ID4gDQo+ID4gPiA+IEZvciBu
b3csIHRoZSBib290bWV0aF9yYXVjIHVzZXMgYSBzaW1pbGFyIGFwcHJvYWNoIGZvciBsb2FkaW5n
DQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBLZXJuZWwgYW5kIGRldmljZSB0cmVlIGFzIHRoZSBib290
bWV0aF9zY3JpcHQsIGluIHRoYXQgaXQNCj4gPiA+ID4gcmVxdWlyZXMgYSBGSVQNCj4gPiA+ID4g
Y29udGFpbmluZyBhIFUtQm9vdCBzY3JpcHQgbG9hZGluZyB0aGUgZGVzaXJlZCBkaXN0cm8uIEl0
IGNvdWxkDQo+ID4gPiA+IGJlDQo+ID4gPiA+IHBvc3NpYmxlIHRvIHN1cHBvcnQgYm9vdGluZyB3
aXRob3V0IGEgc2NyaXB0IGFuZCBsb2FkIHRoZQ0KPiA+ID4gPiBLZXJuZWwgYW5kIERUDQo+ID4g
PiA+IGRpcmVjdGx5IHdpdGggdGhpcyBib290bWV0aCwgYnV0IEkgZm91bmQgdGhlIHNjcmlwdCBt
ZXRob2QgdG8NCj4gPiA+ID4gYmUgdmVyeQ0KPiA+ID4gPiBmbGV4aWJsZSBmb3Igbm93LCBpbiBs
ZXR0aW5nIHRoZSBkaXN0cm8gZGVjaWRlIHdoYXQgdG8gbG9hZC4NCj4gPiA+ID4gDQo+ID4gPiA+
IFRoZSBib290bWV0aF9yYXVjIHdhcyB0ZXN0ZWQgb24gYSBwaHlCT0FSRC1Qb2xsdXggaS5NWDhN
IFBsdXMNCj4gPiA+ID4gWzFdIHdpdGgNCj4gPiA+ID4gQlNQLVlvY3RvLUFtcGxpcGh5LWkuTVg4
TVAtUEQyNC4xLjIgWzJdLg0KPiA+ID4gPiANCj4gPiA+ID4gU3VwcG9ydGVkIGJvb3QgZGV2aWNl
cyBhcmUgY3VycmVudGx5IG9ubHkgTU1DIGRldmljZXMsIGJ1dCBpdA0KPiA+ID4gPiBzaG91bGQg
YmUNCj4gPiA+ID4gcG9zc2libGUgdG8gYWRkIFNQSSBmbGFzaGVzIGluIHRoZSBmdXR1cmUuDQo+
ID4gPiANCj4gPiA+IEl0J3MgcXVpdGUgYSBsYXRlIGNvbW1lbnQsIGJ1dCB0aGlzIGltcGxlbWVu
dGF0aW9uIGhhcyByZWFsbHkNCj4gPiA+IG5vdGhpbmcNCj4gPiA+IHNwZWNpZmljIHRvIGRvIHdp
dGggTU1DLCB5b3UgY291bGQganVzdCBzdXBwb3J0IGFueSBibG9jayBkZXZpY2UuDQo+ID4gPiAN
Cj4gPiA+IFNvIGlmIHlvdSBjb3VsZCBqdXN0IGFkZCBhIGNvbmZpZyBzZWxlY3RpbmcgdGhlIGJs
b2NrIHR5cGUsDQo+ID4gPiBkZWZhdWx0aW5nDQo+ID4gPiB0byBtbWMsIHRoaXMgY291bGQgYmUg
dXNlZCBvbiBhbnkgYmxvY2sgbGlrZSBVU0IsIFVGUywgTlZNZSwgLi4uDQo+ID4gPiB3aXRoDQo+
ID4gPiBhbG1vc3QgMCBjaGFuZ2VzLg0KPiA+IA0KPiA+IEkgcmFpc2VkIHRoaXMgd2l0aCB2MS4g
VGhlIGNoYWxsZW5nZSBpcyB0aGF0IFJBVUMgaXRzZWxmIGRvZXNuJ3QNCj4gPiB5ZXQNCj4gPiBz
dXBwb3J0IG5vbi1NTUMgb3B0aW9ucy4gSWYvd2hlbiB0aGF0IGNoYW5nZXMgaXQncyBlYXN5IHRv
IHVwZGF0ZQ0KPiA+IGhlcmUuDQo+ID4gDQo+IA0KPiBBY2sgdGh4LCBpbmRlZWQgdGhlIGNvZGUg
Y2hhbmdlIHdvdWxkIGJlIG1pbmltYWwNCg0KTmVpbCBpcyB0aGVvcmV0aWNhbGx5IHJpZ2h0IGhl
cmUgYW5kIHNvbWUgYWRkaXRpb25hbCBibG9jayBkZXZpY2VzIGFyZQ0Kc3VwcG9ydGVkIGJ5IFJB
VUMsIHdoaWNoIGFyZSBjdXJyZW50bHkgbm90IHN1cHBvcnRlZCBieSB0aGUNCmJvb3RtZXRoX3Jh
dWMuIFRoZSBvZmZpY2FsIFJBVUMgZG9jdW1lbnRhdGlvbiBbMV0gbGlzdHMgdGhlIGZvbGxvd2lu
Zw0Kc3VwcG9ydGVkIGRldmljZXM6DQoNCi0gLSBTRCBjYXJkDQotIC0gZS5NTUMNCi0gLSBTU0Qv
TlZNZQ0KLSAtIE5BTkQNCg0KSSd2ZSBhZGRlZCB0aGlzIHRvIG15IHRvLWRvIGxpc3QsIHNvIGF0
IGxlYXN0IFNTRCBhbmQgTlZNZSBkcml2ZXMgd2lsbA0KYmUgcHJvcGVybHkgc3VwcG9ydGVkIGlu
IHRoZSBmdXR1cmUuIEknbGwgc2VuZCBhIHNlcGFyYXRlIHBhdGNoIGZvcg0KdGhhdC4NCg0KUmF3
IE5BTkQgZmxhc2ggaXMgYW5vdGhlciBzdG9yeSwgYXMgdGhlc2UgdHlwaWNhbGx5IGRvIG5vdCBo
YXZlIHJlYWwNCnBhcnRpdGlvbnMsIGJ1dCByYXRoZXIgd29yayB3aXRoIHJhdyBvZmZzZXRzIG9y
IFVCSSB2b2x1bWVzLiBBZ2FpbiwgSSdkDQpjb25zaWRlciB0aGlzIHNvbWV0aGluZyB0byBiZSBm
b3IgYSBzZXBhcmF0ZSBwYXRjaC4NCg0KUmVnYXJkcywNCk1hcnRpbg0KDQpbMV06DQpodHRwczov
L3JhdWMucmVhZHRoZWRvY3MuaW8vZW4vbGF0ZXN0L2ludGVncmF0aW9uLmh0bWwjcGFydGl0aW9u
aW5nLXlvdXItZGV2aWNlDQoNCj4gDQo+IE5laWwNCg0KLS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJF
LS0tLS0NCg0KaUhVRUFSWUtBQjBXSVFUaDlqYzhOQlZLbU1HOWd4TlIzWVU0NTJlVEFRVUNhRUtV
M2dBS0NSQlIzWVU0NTJlVA0KQVZDa0FQOWh5OXJFZWh3SVlsdE5qMVpjTEw5emJPTjJkZjVta1Nx
TWVKTjhCS3pWMVFFQXBvUjQrWm40QXpxUg0KcVY4UlBWY3JjWGZvcjc0UGNBdE83UXVDRXhiNGhB
ST0NCj1rZCtKDQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0NCg==
