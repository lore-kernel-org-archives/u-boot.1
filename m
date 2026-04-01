Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90928D3517D
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 13:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4E8E83D8A;
	Wed,  1 Apr 2026 15:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Dilm1UVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3956784010; Wed,  1 Apr 2026 15:26:49 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A07C483CE3
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 15:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.remmet@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUpFxLHJ+XA0BDvdkFf7wazI6tpW+QbhMa23QT1mDj2Eoj63amsJLILARUwcvlTkeVr5vcL79sjiB6CyaiQiRVp/894y7H9WF26VNm9/7BTQ4Eg5on4WK8LsPB5xuXzvEKKvktDErLimJIqMghs4HM8cuYAmwAotqWyJEc8YG2gZ98l/MgpjncqwQabIDuH9vce7SiHziiHd94TPdLP31rhzBxqg5GNK6si/Hsi7qytzuldeM/1OYyfr6achHqR1NuOwgVgfVfmBJm9XsTKxUfzUGC/6EiupS7IDUihRRgTpD5H03zVKvdXE5YJpg7pw2bivMbPGOF+vBkQjufZeXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAdioFnhTfLcVeSbd/yyv/G6OXAKyBGMHMgCiG7e7SQ=;
 b=rf0DNSoI5XGorVZz50+4CDEnHZeeX5tbOfLFS3EcZOX1VrYMtxUOUJsx0KDcg8laUh3pDVtRLMun9Y/DMQTi/lMW48giGUCur/F+VlTic7tlC1xj0M5dGO9EcDKLRU/Ggxmq2TNOAsbuTwMRpIB1QS4g6mf1j20kmcfMxPYKtM/1kCdNnfpBaOcbf0/gLoYMGpKvd6Zlg7U+KY1bsNE60hFXwmEjJTfMn2N4lMbcnLEJRroqJK0Vn+xsai1Fgsk/nWB0ZJ5NeggNX90S415M3MbS9MaEI0K4QvSmBatQFPn6UGvlDAgXg5KSHoxtxUgAWQv3jv8KjCnH3B1t2CL0Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAdioFnhTfLcVeSbd/yyv/G6OXAKyBGMHMgCiG7e7SQ=;
 b=Dilm1UVJYXIxpooiFVtdc8o9KYn7zuNPRrGIEo9iXECjVXZl6XErSkiEJoewMCGGQokz0cROwYxjhSNvUwc0XYfiDZLwgSu/zMmcHNfuh3/dgawJmCEltL3y4njWA1jivKAcHOUS6O2UAFYkrOjb+iBQbAOwEg/p2YlgdHrphg9meiHnzds1isLpK1Zjyy+gmaRvGHKsUToaEmL6C7BemycQ2fgwwaB5rICFI3P+rkgJkffW/mUvFM/07EI1CTH87uIEQVmGnSxGHmsWz8t9gxuonC5fHWG2WEZ1ISIvOiKrBFPaF7YbpUIM74NgjXnW9XLTRkhIMyC3aLRrnhkj8w==
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:297::14)
 by DB8P195MB0600.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:147::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 13:26:44 +0000
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::efce:766c:909a:9335]) by DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::efce:766c:909a:9335%3]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 13:26:44 +0000
From: Teresa Remmet <t.remmet@phytec.de>
To: "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "sbabic@nabladev.com" <sbabic@nabladev.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "trini@konsulko.com" <trini@konsulko.com>
CC: Benjamin Hahn <B.Hahn@phytec.de>, Leonard Anderweit
 <l.anderweit@phytec.de>, "abbaraju.manojsai@amarulasolutions.com"
 <abbaraju.manojsai@amarulasolutions.com>, "emanuele.ghidoli@toradex.com"
 <emanuele.ghidoli@toradex.com>, "peng.fan@nxp.com" <peng.fan@nxp.com>, Yannic
 Moog <y.moog@phytec.de>, "francesco.dolcini@toradex.com"
 <francesco.dolcini@toradex.com>, "matteo.lisi@engicam.com"
 <matteo.lisi@engicam.com>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Thread-Topic: [PATCH v2 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Thread-Index: AQHcwEN7iy5f8M8/Vk+CItRMsiE/b7XKNdWA
Date: Wed, 1 Apr 2026 13:26:44 +0000
Message-ID: <81426d99c052a510ae5bf73612d7564f4e19ddde.camel@phytec.de>
References: <20260330-power-legacy-v2-0-47dde3182a2c@nxp.com>
 <20260330-power-legacy-v2-1-47dde3182a2c@nxp.com>
In-Reply-To: <20260330-power-legacy-v2-1-47dde3182a2c@nxp.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB1228:EE_|DB8P195MB0600:EE_
x-ms-office365-filtering-correlation-id: e4e6eccf-1920-4414-0e0e-08de8ff25165
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: MSS4PPCtaNfHLwfiHZ3Clm5D7/Q8VdqoDDUW3+71ZLPNutZpDkQ3k81ZNdPYf9a3/bmeCwE/GmI/r5pMgaikW67nymCZ+skVv20ho2kGmJrkfty1R/GaAb6sANnjezKbvyybJx3nCze3JnPMuVK+ThtquhAJLIprWu8ZhJtlWQYfiwyjXqOL+onrFR1uef/MjNpARHLGkbVYv+0bMkJ1qWlSYTHBiIPKC2d+v9Rw3z7bYXgGbnm9+KfMlfYyFdeV0o9N3UngD1jOHIrbZBTFRy1omTkNBE7do5kMiYAb7ULMhdT+YqgbL3l9BEkakipNOOEjFGdaUckM4me02gRL1eBxWQz5805w3Us+sqSBsSclEktQMY3h5cJA3fRx7y/5DV4T9iy2BL3aAKtKH89h2TnL/hr1bmoXLmpJNmQC/8d/e4hJHdNQH1Pt9faG1oPUKA+3zZvONN6V1OtnY1ZDoukL75e5L4YT7S5+vCnUUBScfzjGeDFjd6uMAD6J5SHmIG4VjYKKvkQ6Z0a3TVIDTIx3TkgPXrutZLm+kkCjBZEpCEBeaYRXH0S0y5CzB/UdKJEnAyw7Y1PGRvjdkFyXmSpVfVPlnwVrVIY/Qk8w5mejeGtL89F9GsbUkFLCRZUf8an8L/GalXPJLaBWM6ZeqLP7h7geCPi9pS+RFV+b7XbAJuKrWT2XcCukhU4XIDn7lPuJHkPP6byO2ZdEp8c4rdx/Q/4T2O1GXYmNF0eled44E5doioUKN3kmcxzyXv5UqVF7ozyQCS4qAlOrHsqwVlbAN4BFdB/i47aW0ywJvYY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1228.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2xBUVVOUkQ0ZG00YmROMHJLaEVtVG5nRmRmdnRGMEdSZWhVcGZEWlZwdWhS?=
 =?utf-8?B?ZzFXcGo4Y3luTzdML1ZMK2p2cThDSjdoNEg4a0F4QWF3S2pScFdKTXVsR2tH?=
 =?utf-8?B?bkVsVzhxb0s2UDkyM1Vrbk9pZEoyY0RzV1dOdnByNjNVcjZOVnpic0M0Qmdh?=
 =?utf-8?B?ZDFmV3h0Qng4Z3RRQ2dBdWRYRGhuN09QdldNZXk2S2dOOW1rZnpoT3kzd241?=
 =?utf-8?B?Wi9LeWVta0J1eEExd3RKZDZVUUJCWVd4NllGaFBTekl0bjZYMEJoNHZQU0pW?=
 =?utf-8?B?OW9WMTd4bmhYbWhPWUdKV21xUG5oRm02cnRYM2VaVFN2UnRvYVpScC9rN1VV?=
 =?utf-8?B?cjdIbGJubVZNcUFZWnhHVHpkbE9mQkgzWCtWeEVOYnVUV0pYbERaOWtIRS9I?=
 =?utf-8?B?eWo5S3RaM3NPRGtOL3hXZFg5UHBoakl2TGFCS1E2dW9VazgrT1UrenNUZllV?=
 =?utf-8?B?UHpOblZjais1RmF0RWRDb2VmelZzNWF3T2dqd0xXd3JGVTdjVHN3WTdQQ0Uv?=
 =?utf-8?B?c3lqYXBCeXhROVJpUXpKR3FHZmpZclBIakxPNU81Y2N5elVqeDI2TS9Zck1r?=
 =?utf-8?B?bFlzcVdBVlNlcVZQYzN0Zm5TWHIxRFBCUUY0M3hleGlYQkFWM1pha044akR5?=
 =?utf-8?B?L1RIci8wZ3BaTTY5NkQ2cmlZWGhId3VaR0FwMEZlODVYTFduVWszc3d2Slpm?=
 =?utf-8?B?YW9zZFN2M05HYVR3aFVqRnBsQXlFME5jcHByUzU5NldzY0U4cjBCNUl4NXR0?=
 =?utf-8?B?eXBzRjFFL0hrRTlCMWxOVStXMjUyL3JkTTZQYSthMnBWMHFDRlI3Q1BFSmFT?=
 =?utf-8?B?ZzlWSmg5NG9jRmcxdm1XT1V1c2tSUUpZRmZEY015L3ErOHZzNlJKUXhEQmxs?=
 =?utf-8?B?cmd1bGl0TlU2VUlDZ1o2dHZPQURtSUM1cmgxWmpqaGRJMVVscUlIUDRydWNX?=
 =?utf-8?B?cURsOHVDdDJ5dWNRWWw0ZmtBazROdkZjRCtnUVpHSDMzMExFNVk4eVdieXdh?=
 =?utf-8?B?UHpJK2wyZkJBamxmazhTUGVqdWJqbEF4MmUvM0cxSEs0N0dqNEFYckM3YmRl?=
 =?utf-8?B?TTc3aEpDQURIUDVsOGo0UGUvR3hDYXJkR0lDQmMvMDYremJjekkzeFV0ajJE?=
 =?utf-8?B?NnNhNEJhdTZTZXhWa3RlQTI0TDVJZFRBY0dIc0hjK0xOODhFVDFDQnBRVUY0?=
 =?utf-8?B?Q2o3WTNldlgvRzJqd3hFeWhqTy9hYjQ5TGtSUHlnS3V6d2NGa0NjNVNtUjBU?=
 =?utf-8?B?VGlVREZlSUNLRGdnWkx6ZHdnSXRDNDZVZ0VCd3VKY290R015Nkx4NEcyeU5l?=
 =?utf-8?B?ZzdEcWh3SnhQclBVY0lQRlpKWGN3Yno5N0RXNmJqaktPRStaM1k0WmttYVFG?=
 =?utf-8?B?aTVDc29Qa0Nsa0JSNzRHdXRFRzlwUHRxRWsxOFRubVg1d2lWbU1yTnNLRnRu?=
 =?utf-8?B?bzZ2dDZpMEpWUmZ2UG4vMlRKNlBuemNWMFRxL3ltWHdCWUtzTjQzN0FNdlZM?=
 =?utf-8?B?SDRHSlArcm5OSkpDcTdzQlBFazEzUXhUTktPRUhmQW03b0hsczRZTHF4NTd6?=
 =?utf-8?B?ck9Ra2wrT2dyL3R5VXFodnM0Wk15Z3JuTXdNSzd3MTZtSG9ueUNzVGsxaDVB?=
 =?utf-8?B?algxUDBBeGdHOEhnVTJFQjB6V09sZWdGR0F0VTV0WkwrbzVVNUVwdjVQbWxZ?=
 =?utf-8?B?MzhMQTdTRFFXYzBCalVWKzhocm9XRGNUV0ZOS0txZ0wzV1Z6ZGozeTkrOUxY?=
 =?utf-8?B?RU9JVlpoeVJzM0h0dzFUbG1jU3N2bE5wK2RjUUwzTUJlRzVLNEFZNkdCQ2pi?=
 =?utf-8?B?NFhFa3ZnNHo2ajRDSER0TGVVREpaNi9ZYlZETVJCU29tSDBUdjlDVnRTOU1X?=
 =?utf-8?B?cTVHTEIyMmY4ZVYrdmhqY2NxY3pOZ1NUY2hrdE1JNVYxdUNJUTZQenVqdDds?=
 =?utf-8?B?dFRNNFJLOVROVjJsN0VWbmt0a1pacEdhcTNUZDNqOUI2ZEtOK2pEMlVHRUVF?=
 =?utf-8?B?aDVMRCtMek1zaHBMYXpETU9FZ1lGYW81bXdlaXBLK0hoQitHb3BVS09YRW40?=
 =?utf-8?B?VTd3N3VwK01xcCtHb2Q2VlFDc1BiaUdzYUdBY1lHaTNlaXRPVUVYTXlUYmNo?=
 =?utf-8?B?Y2NzYlBCKzhkam1zZ1NFbmxONDg0dXhycmVSNDY5R1hrQkxqbmJBNHRMWTdt?=
 =?utf-8?B?Mk8ySzluSUVPT093VWRpRnhKZ2l0cm1sUS9kU3pRUm04KzEzYjl0aTFSb3ZQ?=
 =?utf-8?B?T1FmeVJ6Wi81dlFOUjNrdktRNVBtSGVFUWdoNEJFYVA3a3dhZGlhVFBUKzNx?=
 =?utf-8?B?TVVDS0xud3l3WE1GcFpsZUExb0JiaCsrVUgzNnJVNCtyV3A2SHloQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F62949D1D19E74996E3DCBF86294C4B@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e6eccf-1920-4414-0e0e-08de8ff25165
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 13:26:44.3361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riInceBno7NsrKVjFZIbhGJIF0Nn30Q86fgAvRwR8oA9jbWqlYKFKT/u5h30hv5wvhXzkITvcXIWiYkKnseTEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0600
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

QW0gTW9udGFnLCBkZW0gMzAuMDMuMjAyNiB1bSAyMjowNCArMDgwMCBzY2hyaWViIFBlbmcgRmFu
IChPU1MpOg0KPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gDQo+IENvbnZl
cnQgdGhlIGJvYXJkIHRvIHVzZSBETV9QTUlDIGluc3RlYWQgb2YgdGhlIGxlZ2FjeSBTUEwgSTJD
L1BNSUMNCj4gaGFuZGxpbmcuDQo+IA0KPiBDaGFuZ2VzIGluY2x1ZGU6DQo+IC0gRW5hYmxlIERN
X1BNSUMsIERNX1BNSUNfUENBOTQ1MCwgYW5kIFNQTF9ETV9QTUlDX1BDQTk0NTAgaW4NCj4gZGVm
Y29uZmlnLg0KPiAtIERyb3AgbGVnYWN5IFNQTCBJMkMgYW5kIFBNSUMgb3B0aW9ucy4NCj4gLSBS
ZW1vdmUgbWFudWFsIEkyQzEgcGFkIHNldHVwIGFuZCBsZWdhY3kgcG93ZXJfcGNhOTQ1MF9pbml0
KCkgdXNhZ2UuDQo+IC0gVXNlIERNLWJhc2VkIHBtaWNfZ2V0KCkgd2l0aCB0aGUgRFQgbm9kZSAi
cG1pY0AyNSIuDQo+IC0gVXBkYXRlIFBNSUMgcmVnaXN0ZXIgcHJvZ3JhbW1pbmcgdG8gdXNlIHN0
cnVjdCB1ZGV2aWNlIEFQSS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZh
bkBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogVGVyZXNhIFJlbW1ldCA8dC5yZW1tZXRAcGh5dGVj
LmRlPg0KDQo+IC0tLQ0KPiDCoC4uLi9hcm0vZHRzL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRr
LXUtYm9vdC5kdHNpIHwgMjIgKysrKysrKysrKy0NCj4gwqBib2FyZC9waHl0ZWMvcGh5Y29yZV9p
bXg4bXAvc3BsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNDMgKysrKysr
Ky0tLS0tDQo+IC0tLS0tLS0tLS0NCj4gwqBjb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZp
Z8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEwICsrLS0tDQo+IMKgMyBm
aWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAzNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGstdS1ib290
LmR0c2kNCj4gYi9hcmNoL2FybS9kdHMvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGstdS1ib290
LmR0c2kNCj4gaW5kZXggNDgwNGEyMDRlOTIuLmU5NDAzZDllYTgyIDEwMDY0NA0KPiAtLS0gYS9h
cmNoL2FybS9kdHMvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGstdS1ib290LmR0c2kNCj4gKysr
IGIvYXJjaC9hcm0vZHRzL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLXUtYm9vdC5kdHNpDQo+
IEBAIC0zNCw2ICszNCwxOCBAQA0KPiDCoAl9Ow0KPiDCoH07DQo+IMKgDQo+ICsmcGluY3RybF9p
MmMxIHsNCj4gKwlib290cGgtYWxsOw0KPiArfTsNCj4gKw0KPiArJnBpbmN0cmxfcG1pYyB7DQo+
ICsJYm9vdHBoLWFsbDsNCj4gK307DQo+ICsNCj4gKyZ7L3NvY0AwL2J1c0AzMDgwMDAwMC9pMmNA
MzBhMjAwMDAvcG1pY0AyNS9yZWd1bGF0b3JzfSB7DQo+ICsJYm9vdHBoLWFsbDsNCj4gK307DQo+
ICsNCj4gwqAmcmVnX3VzZGhjMl92bW1jIHsNCj4gwqAJYm9vdHBoLXByZS1yYW07DQo+IMKgfTsN
Cj4gQEAgLTgzLDExICs5NSwxMSBAQA0KPiDCoH07DQo+IMKgDQo+IMKgJmkyYzEgew0KPiAtCWJv
b3RwaC1wcmUtcmFtOw0KPiArCWJvb3RwaC1hbGw7DQo+IMKgfTsNCj4gwqANCj4gwqAmcG1pYyB7
DQo+IC0JYm9vdHBoLXByZS1yYW07DQo+ICsJYm9vdHBoLWFsbDsNCj4gwqB9Ow0KPiDCoA0KPiDC
oCZ1c2JfZHdjM18wIHsNCj4gQEAgLTk2LDYgKzEwOCwxMiBAQA0KPiDCoA0KPiDCoCZ1c2RoYzIg
ew0KPiDCoAlib290cGgtcHJlLXJhbTsNCj4gKwkvKg0KPiArCSAqIExETzUgb3V0cHV0IGRlcGVu
ZHMgb24gU0QyX1ZTRUwsIGJ1dCBubyB3YXkgdG8gcmVhZCBiYWNrDQo+IFNEMl9WU0VMDQo+ICsJ
ICogd2hlbiB1c2luZyBTREhDIGNvbnRyb2xsZXIgVlNFTEVDVCB0byBjb250cm9sIFNEMl9WU0VM
Lg0KPiBTbyBkcm9wDQo+ICsJICogdnFtbWMtc3VwcGx5IHRvIGF2b2lkIGZzbF9lc2RoY19pbXgg
cmVhZCBiYWNrIHdyb25nDQo+IHZvbHRhZ2UuDQo+ICsJICovDQo+ICsJL2RlbGV0ZS1wcm9wZXJ0
eS8gdnFtbWMtc3VwcGx5Ow0KPiDCoH07DQo+IMKgDQo+IMKgJnVzZGhjMyB7DQo+IGRpZmYgLS1n
aXQgYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvc3BsLmMNCj4gYi9ib2FyZC9waHl0ZWMv
cGh5Y29yZV9pbXg4bXAvc3BsLmMNCj4gaW5kZXggZmM3YWVmZDAwNzMuLmZjNmY1MTA0OTI1IDEw
MDY0NA0KPiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvc3BsLmMNCj4gKysrIGIv
Ym9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL3NwbC5jDQo+IEBAIC0xMTcsNDUgKzExNywzMiBA
QCBvdXQ6DQo+IMKgCWRkcl9pbml0KCZkcmFtX3RpbWluZyk7DQo+IMKgfQ0KPiDCoA0KPiAtI2Rl
ZmluZSBJMkNfUEFEX0NUUkwgKFBBRF9DVExfRFNFNiB8IFBBRF9DVExfSFlTIHwgUEFEX0NUTF9Q
VUUgfA0KPiBQQURfQ1RMX1BFKQ0KPiAtI2RlZmluZSBQQyBNVVhfUEFEX0NUUkwoSTJDX1BBRF9D
VFJMKQ0KPiAtc3RydWN0IGkyY19wYWRzX2luZm8gaTJjX3BhZF9pbmZvMSA9IHsNCj4gLQkuc2Ns
ID0gew0KPiAtCQkuaTJjX21vZGUgPSBNWDhNUF9QQURfSTJDMV9TQ0xfX0kyQzFfU0NMIHwgUEMs
DQo+IC0JCS5ncGlvX21vZGUgPSBNWDhNUF9QQURfSTJDMV9TQ0xfX0dQSU81X0lPMTQgfCBQQywN
Cj4gLQkJLmdwID0gSU1YX0dQSU9fTlIoNSwgMTQpLA0KPiAtCX0sDQo+IC0JLnNkYSA9IHsNCj4g
LQkJLmkyY19tb2RlID0gTVg4TVBfUEFEX0kyQzFfU0RBX19JMkMxX1NEQSB8IFBDLA0KPiAtCQku
Z3Bpb19tb2RlID0gTVg4TVBfUEFEX0kyQzFfU0RBX19HUElPNV9JTzE1IHwgUEMsDQo+IC0JCS5n
cCA9IElNWF9HUElPX05SKDUsIDE1KSwNCj4gLQl9LA0KPiAtfTsNCj4gLQ0KPiDCoGludCBwb3dl
cl9pbml0X2JvYXJkKHZvaWQpDQo+IMKgew0KPiAtCXN0cnVjdCBwbWljICpwOw0KPiArCXN0cnVj
dCB1ZGV2aWNlICpkZXY7DQo+IMKgCWludCByZXQ7DQo+IMKgDQo+IC0JcmV0ID0gcG93ZXJfcGNh
OTQ1MF9pbml0KDAsIDB4MjUpOw0KPiAtCWlmIChyZXQpDQo+IC0JCXByaW50ZigicG93ZXIgaW5p
dCBmYWlsZWQiKTsNCj4gLQlwID0gcG1pY19nZXQoIlBDQTk0NTAiKTsNCj4gLQlwbWljX3Byb2Jl
KHApOw0KPiArCXJldCA9IHBtaWNfZ2V0KCJwbWljQDI1IiwgJmRldik7DQo+ICsJaWYgKHJldCA9
PSAtRU5PREVWKSB7DQo+ICsJCXB1dHMoIk5vIHBtaWNAMjVcbiIpOw0KPiArCQlyZXR1cm4gMDsN
Cj4gKwl9DQo+ICsJaWYgKHJldCA8IDApDQo+ICsJCXJldHVybiByZXQ7DQo+IMKgDQo+IMKgCS8q
IEJVQ0t4T1VUX0RWUzAvMSBjb250cm9sIEJVQ0sxMjMgb3V0cHV0ICovDQo+IC0JcG1pY19yZWdf
d3JpdGUocCwgUENBOTQ1MF9CVUNLMTIzX0RWUywgMHgyOSk7DQo+ICsJcG1pY19yZWdfd3JpdGUo
ZGV2LCBQQ0E5NDUwX0JVQ0sxMjNfRFZTLCAweDI5KTsNCj4gwqANCj4gwqAJLyogSW5jcmVhc2Ug
VkREX1NPQyBhbmQgVkREX0FSTSB0byBPRCB2b2x0YWdlIDAuOTVWICovDQo+IC0JcG1pY19yZWdf
d3JpdGUocCwgUENBOTQ1MF9CVUNLMU9VVF9EVlMwLCAweDFDKTsNCj4gLQlwbWljX3JlZ193cml0
ZShwLCBQQ0E5NDUwX0JVQ0syT1VUX0RWUzAsIDB4MUMpOw0KPiArCXBtaWNfcmVnX3dyaXRlKGRl
diwgUENBOTQ1MF9CVUNLMU9VVF9EVlMwLCAweDFDKTsNCj4gKwlwbWljX3JlZ193cml0ZShkZXYs
IFBDQTk0NTBfQlVDSzJPVVRfRFZTMCwgMHgxQyk7DQo+IMKgDQo+IMKgCS8qIFNldCBCVUNLMSBE
VlMxIHRvIHN1c3BlbmQgY29udHJvbGxlZCB0aHJvdWdoDQo+IFBNSUNfU1RCWV9SRVEgKi8NCj4g
LQlwbWljX3JlZ193cml0ZShwLCBQQ0E5NDUwX0JVQ0sxT1VUX0RWUzEsIDB4MTQpOw0KPiAtCXBt
aWNfcmVnX3dyaXRlKHAsIFBDQTk0NTBfQlVDSzFDVFJMLCAweDU5KTsNCj4gKwlwbWljX3JlZ193
cml0ZShkZXYsIFBDQTk0NTBfQlVDSzFPVVRfRFZTMSwgMHgxNCk7DQo+ICsJcG1pY19yZWdfd3Jp
dGUoZGV2LCBQQ0E5NDUwX0JVQ0sxQ1RSTCwgMHg1OSk7DQo+IMKgDQo+IMKgCS8qIFNldCBXRE9H
X0JfQ0ZHIHRvIGNvbGQgcmVzZXQgKi8NCj4gLQlwbWljX3JlZ193cml0ZShwLCBQQ0E5NDUwX1JF
U0VUX0NUUkwsIDB4QTEpOw0KPiArCXBtaWNfcmVnX3dyaXRlKGRldiwgUENBOTQ1MF9SRVNFVF9D
VFJMLCAweEExKTsNCj4gwqANCj4gwqAJcmV0dXJuIDA7DQo+IMKgfQ0KPiBAQCAtMTkzLDggKzE4
MCw2IEBAIHZvaWQgYm9hcmRfaW5pdF9mKHVsb25nIGR1bW15KQ0KPiDCoA0KPiDCoAllbmFibGVf
dHpjMzgwKCk7DQo+IMKgDQo+IC0Jc2V0dXBfaTJjKDAsIENPTkZJR19TWVNfSTJDX1NQRUVELCAw
eDdmLCAmaTJjX3BhZF9pbmZvMSk7DQo+IC0NCj4gwqAJcG93ZXJfaW5pdF9ib2FyZCgpOw0KPiDC
oA0KPiDCoAkvKiBERFIgaW5pdGlhbGl6YXRpb24gKi8NCj4gZGlmZiAtLWdpdCBhL2NvbmZpZ3Mv
cGh5Y29yZS1pbXg4bXBfZGVmY29uZmlnIGIvY29uZmlncy9waHljb3JlLQ0KPiBpbXg4bXBfZGVm
Y29uZmlnDQo+IGluZGV4IDJmY2Y3ZGI5ZTVjLi41MWQ5NzM3YWZiMyAxMDA2NDQNCj4gLS0tIGEv
Y29uZmlncy9waHljb3JlLWlteDhtcF9kZWZjb25maWcNCj4gKysrIGIvY29uZmlncy9waHljb3Jl
LWlteDhtcF9kZWZjb25maWcNCj4gQEAgLTEwLDcgKzEwLDYgQEAgQ09ORklHX1NGX0RFRkFVTFRf
U1BFRUQ9ODAwMDAwMDANCj4gwqBDT05GSUdfRU5WX1NJWkU9MHgxMDAwMA0KPiDCoENPTkZJR19F
TlZfT0ZGU0VUPTB4M0MwMDAwDQo+IMKgQ09ORklHX0VOVl9TRUNUX1NJWkU9MHgxMDAwMA0KPiAt
Q09ORklHX1NZU19JMkNfTVhDX0kyQzE9eQ0KPiDCoENPTkZJR19ETV9HUElPPXkNCj4gwqBDT05G
SUdfREVGQVVMVF9ERVZJQ0VfVFJFRT0iZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgt
cmRrIg0KPiDCoENPTkZJR19JTVg4TV9PUFRFRV9MT0FEX0FERFI9MHg3ZTAwMDAwMA0KPiBAQCAt
MTEzLDggKzExMiw2IEBAIENPTkZJR19GQVNUQk9PVF9NTUNfVVNFUl9TVVBQT1JUPXkNCj4gwqBD
T05GSUdfRkFTVEJPT1RfTU1DX1VTRVJfTkFNRT0ibW1jMiINCj4gwqBDT05GSUdfTVhDX0dQSU89
eQ0KPiDCoENPTkZJR19ETV9JMkM9eQ0KPiAtIyBDT05GSUdfU1BMX0RNX0kyQyBpcyBub3Qgc2V0
DQo+IC1DT05GSUdfU1BMX1NZU19JMkNfTEVHQUNZPXkNCj4gwqBDT05GSUdfSTJDX0VFUFJPTT15
DQo+IMKgQ09ORklHX1NZU19JMkNfRUVQUk9NX0FERFI9MHg1MQ0KPiDCoENPTkZJR19TVVBQT1JU
X0VNTUNfQk9PVD15DQo+IEBAIC0xNDQsMTUgKzE0MSwxNiBAQCBDT05GSUdfUEhZX0lNWDhNUV9V
U0I9eQ0KPiDCoENPTkZJR19QSU5DVFJMPXkNCj4gwqBDT05GSUdfU1BMX1BJTkNUUkw9eQ0KPiDC
oENPTkZJR19QSU5DVFJMX0lNWDhNPXkNCj4gLUNPTkZJR19TUExfUE9XRVJfTEVHQUNZPXkNCj4g
wqBDT05GSUdfUE9XRVJfRE9NQUlOPXkNCj4gwqBDT05GSUdfSU1YOE1fUE9XRVJfRE9NQUlOPXkN
Cj4gwqBDT05GSUdfSU1YOE1QX0hTSU9NSVhfQkxLQ1RSTD15DQo+IC1DT05GSUdfUE9XRVJfUENB
OTQ1MD15DQo+ICtDT05GSUdfRE1fUE1JQz15DQo+ICtDT05GSUdfRE1fUE1JQ19QQ0E5NDUwPXkN
Cj4gK0NPTkZJR19TUExfRE1fUE1JQ19QQ0E5NDUwPXkNCj4gwqBDT05GSUdfRE1fUkVHVUxBVE9S
PXkNCj4gK0NPTkZJR19ETV9SRUdVTEFUT1JfUENBOTQ1MD15DQo+IMKgQ09ORklHX0RNX1JFR1VM
QVRPUl9GSVhFRD15DQo+IMKgQ09ORklHX0RNX1JFR1VMQVRPUl9HUElPPXkNCj4gLUNPTkZJR19T
UExfUE9XRVJfSTJDPXkNCj4gwqBDT05GSUdfRE1fUk5HPXkNCj4gwqBDT05GSUdfRE1fU0VSSUFM
PXkNCj4gwqBDT05GSUdfTVhDX1VBUlQ9eQ0KPiANCg0KLS0gDQpQSFlURUMgTWVzc3RlY2huaWsg
R21iSCB8IEJhcmNlbG9uYS1BbGxlZSAxIHwgNTUxMjkgTWFpbnosIEdlcm1hbnkNCg0KR2VzY2jD
pGZ0c2bDvGhyZXI6IERpcGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1JbmcuIEJvZG8g
SHViZXIsDQpEaXBsLi1JbmcuIChGSCkgTWFya3VzIExpY2tlcyB8IEhhbmRlbHNyZWdpc3RlciBN
YWlueiBIUkIgNDY1NiB8DQpGaW5hbnphbXQgTWFpbnogfCBTdC5Oci4gMjYvNjY1LzAwNjA4LCBE
RSAxNDkwNTk4NTUNCg==
