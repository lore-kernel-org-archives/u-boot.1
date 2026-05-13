Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39471CD343F
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 02:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F7148464D;
	Wed, 13 May 2026 04:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="HB13Xha+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 653CC84663; Wed, 13 May 2026 04:13:42 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B82983EF9
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 04:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeCrBsDslJCq1dX1bM+WsWHPwX5nqA46rcUc3MUt4VLv0Ri+oFxUIz6/mWYMaFHq92bpjvCCwgaEgL1YnCS0+tgrUIkNVv3y8O2AnWv6CAdfDLgttezRFrADA8by5X0AkOiakzwcaF+1VLpv1A/rUjh7R+mIJuw/QR2YgBKvOLkg8YQ5N52PkK3yXJ0OWJgrbAChRQ+K0HpMX1tyaalJwKfD8aIOQGg628dL9w7e7ibRceHDTS6Mjlb7U/DYkrs9+OPQ0chIOjISYfmGCXTS9Az5hca2+GQijJ20wKY9uDb7FRPkBrnsatoGvDvcbzrAuwst0C2HNuWL7Ck73Udeew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+UKVP/4IcQNW4YnsWk5NRoa/6/QyN7A6Skd/RILwtU=;
 b=poKrQDkXUXDCt25Ya5ga6tf+lXwhOYjIoZ+g3nWS7UveFHJaq4jyHfkmHtoOsd+2z/nqVvISEUchNDwXqM4gR/3PJJSVeNfq1//EvFYnjWEH1MVQRoHvksRPM/qbcUVDnxO63FnzmX/Wx2TkIs247tPvpzA23P/xnkOfMul4V3UXW1mruWVHSNI95BiqmFsG6veRtzVeVA83/6sSPuVryqLMu5xBlG9FDm1APXtTvXtKFGwmlaj+/u140jq8E02bRcLqINKiHe327LGZs6lULI9KqOI1Eqvp580vaHUX4R42laTsLy2UTAspw0DRVNuJfe6jSB7VN7Oyy+bsnPM2eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+UKVP/4IcQNW4YnsWk5NRoa/6/QyN7A6Skd/RILwtU=;
 b=HB13Xha+3zVIUWic4lCtwbWock6AUy/UkCqHDgzi6triFcdJNk+phg1GtSwBH+k+Gb3ZAbxXJ0e7B2+nWM70o6+Q9OySRCgCmlrK8DiBA14feq7R3QfY9+X+WKG9YDlEW2Eu4ptni25mDfq9PT3ga3/meKAMRk0XrKr6fn3g11sNO7036pG9RIvLZhEaz9pzEsCzD/dVZNixKVx3SQ1RECw9lbfpoBBiLkzeZEZXdXYFfKdYjbYcillv+vd0R3/9+RSUECTtZ44fd0cYD8mO5BBHXOzcHU1+kEo1PmjFkkvLRrFYueK4yg9NKwsS1frrihkjADvMqN4rhm/Z77Gtyg==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DS7PR03MB5480.namprd03.prod.outlook.com (2603:10b6:5:2d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:13:34 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 02:13:34 +0000
From: "MANIYAM, DINESH" <dinesh.maniyam@altera.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: Tom Rini <trini@konsulko.com>, U-Boot-Denx <u-boot@lists.denx.de>, Marek
 Vasut <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Richard Genoud
 <richard.genoud@bootlin.com>, James Hilliard <james.hilliard1@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "NG, BOON KHAI" <boon.khai.ng@altera.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>
Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND
 dependencies
Thread-Topic: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND
 dependencies
Thread-Index: AQHcq4aKJh8vW2pBCk6IILThfZsHE7WeclEAgCHM7b+AADR+AIAS5yzogAAKkACAIMX8AIAXeH5K
Date: Wed, 13 May 2026 02:13:34 +0000
Message-ID: <PH7PR03MB69420121B7C50CBB0F30A4CFF7062@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <20260304032441.31558-1-dinesh.maniyam@altera.com>
 <20260304032441.31558-2-dinesh.maniyam@altera.com>
 <20260304143920.GT1388590@bill-the-cat>
 <PH7PR03MB6942D3E727EC89DE074BC0EFF756A@PH7PR03MB6942.namprd03.prod.outlook.com>
 <CAOf5uwm9eEMKe=CVGbZavGgmv3SArnnLZNcJs1RZJW7H6vgw_Q@mail.gmail.com>
 <PH7PR03MB6942E3711A99A34A114E614AF75AA@PH7PR03MB6942.namprd03.prod.outlook.com>
 <CAOf5uwkrp37jF-8FNZ=dJw=xfwq-gAPockLwKkK71sutfiE62w@mail.gmail.com>
 <d66ac683-af83-473f-9e75-f6f3a317280b@altera.com>
In-Reply-To: <d66ac683-af83-473f-9e75-f6f3a317280b@altera.com>
Accept-Language: en-MW, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|DS7PR03MB5480:EE_
x-ms-office365-filtering-correlation-id: b3e5d8c8-6c6b-473a-cc86-08deb0953c79
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|39142699007|31052699007|56012099003|22082099003|8096899003|18002099003|11063799003|55112099003|13003099007|38070700021;
x-microsoft-antispam-message-info: GuIFUSck+1EGI2TzjFakHroksdub2hv1hwwaiEbjSSboDUMfQOeHHByUQbhrXLV/21aJwNplyU8CbfgtpiEnx6Z6W0vZHeMhXYLuxqLGGRzrXhxl1s4On1A1Z/RPkJfiyfcqZaYErkCxx+FIeeYGkdbX50CCTYsexfes1teQB+JRGT1rpFwjMq3xzWz9IH4vMglgVaDydl8EAMqBvvxVcj0u8G4Tm7u8bH1QME2lcGtxGmsw1Bw8ZwGMW1+N98k0UmyrjTKSXZwLAXYMzp37IXZhc/A1TJTMZQ+Dj0ADn9XPu6DSiqN9XorJEcdoGDniki9EzPLFsGvsy3kWM0Oi1WxiNBL9VcgzcL+0JPN9telt2PGl8bapUime1yUExwA0rF+rwf8J00g8My0Xs2KjYsZ9ETLTDjwX15i7nbxksafEiZ+dhg87DO9V61AnVY6A/oXg4WAmgAvOfDfmm8U3qQKjHIyVSlCO7MQy+hPja6QL3zeCHNAOmRiIn22reqAdDK0nXJHr9ruJQgH2ThlCG7kvj651m0lnjzqoryIGFdmQkg8GGRfqfz3vsvxxSrxJMgXkgSChgr3p4JpBaNHSYKIxk949NLGxEklWVc+u2tHWzgqutWzNVBmvAR6diPrPnH/bZwgi8IP6lwOhKTQD8VwQKxKT7FK7T9LfQMFX41US9AtYys3uRMjerjp+7WhD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(39142699007)(31052699007)(56012099003)(22082099003)(8096899003)(18002099003)(11063799003)(55112099003)(13003099007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHY0R3gyaEk1ZE9HdWFSVytaVjI1cWdCRkNmUG1RY2ZySmtxMm9yYXJFWTcr?=
 =?utf-8?B?MlBPck9jMnhRM3N3MnUrb2xrYXNPZnVwbVdZMmlPK2FjQ0dYcnBTYVQ1Vk1D?=
 =?utf-8?B?aFNya0h3VFp2TVdkYzdaWUsrYXpPRGR0a2lKVWpiTGw3WER1WTIxWGk0ZUtz?=
 =?utf-8?B?ZlVTblhkQWdMNVZabXpSdHliTngyTFBpa1VORitXZjJFd1p0QXphdHVDb2VB?=
 =?utf-8?B?T1BqTVJ5L2NNUS9Ia2M1WmRCc0IrZlRuZkxXaVc0RjhiM2pLMFNTSk5nWmZs?=
 =?utf-8?B?UU84R0xUdDMyQTYwOWtuUHNXN25GeXcxeExTSFljRjd4VWJzaVoyOFFGaElS?=
 =?utf-8?B?SzNCUndCN3ovYlpud0dkMTZCaDUzSUZjMWh5TDlSMWFRb1VpZGFvTVQ5dkVo?=
 =?utf-8?B?M3pRMnVUYXE3WHhLYXZoTkZ1WXJzTHg2bjhIeC9mblpFdDhBUVRWTVQ2RHRY?=
 =?utf-8?B?QVZtNGdxc0Q3c2RuaXhQQXJjbFYwbnNvNWFRclBOd2NqRVFWa2VYckpSN3Vj?=
 =?utf-8?B?Ykh1RVplcGNDeWFBTnhXVmlVUDJYZlYydFFpd01NY3o2WkVuQ3AyaXdUMU40?=
 =?utf-8?B?OFpURS9uNVdFWG9QZGJINDVUTU9xaGVxR1p0UnRHL3o0UGpMUWlWRkxQMGw5?=
 =?utf-8?B?Q2Y0WkxieDBYYVhWeWUxU0psWjNnRndJZXgrQWRiMDNGbkFlcC9OTVpJcnl6?=
 =?utf-8?B?YUwrS2NXeHFmdzJrZmtwTVlYM3YwNEUwRXZJcE1vMEFVUnZBL1Y2d1gxbEt2?=
 =?utf-8?B?c0dOMlhxYmlObVpXTEVCRkdianQxU1FLQkYzWjI2RTRka3hYVnM0UkZnb281?=
 =?utf-8?B?THdNOXR4YkRCNGV2dXM4ajRyd3lHUTdQeGxUWlE1eWtrbzNBSHZZMGtvWmZm?=
 =?utf-8?B?eTAySEd2K0lJQjB5aXpuMHp1RUJNUldUS0hYWUlxUWNKb0NJUVNPS04yaDA2?=
 =?utf-8?B?UXJQV2FmYzdHRkdaRXRUeFZTTTdSUlRVME1SU3plRER1Wmp5eTg0cEt0NWxx?=
 =?utf-8?B?c2ZHNUdOUTYzU05HU01RL0VJWktlc0ZpTVAxZVVlaERwKzFZa2hneGpnaWxU?=
 =?utf-8?B?U094LzhIYUFxOGR3RUUwc2ZvNzh2SW1xYU1KSXFLZWVxd1I3dVFKY3JCVzdY?=
 =?utf-8?B?Z3dnZm5OYXliT1BDR0tMUytyMWE3RmxhZ0RGWENBRElJNjVmb1NaOUNBRnF0?=
 =?utf-8?B?bkJyZWRkUDZiWEsvM0FsZVkxLzV0M21xNmtSU1BIMkV0MkVVV0dZUndZZzFM?=
 =?utf-8?B?bk5IWGtxZ2NxVHd0Y1RvRnpjczZ0MDhrcE9zYXd0WXRHQnlpMnloQ2twSUtv?=
 =?utf-8?B?WnluZzU1K1BpdjBjUzRTUFVPZ3lNZFVxOHJVNmhHZmJWM0JUblZUSHdYOXp6?=
 =?utf-8?B?L1FHcUdkbGtQVGpVZWpBYWw4THBFdk9vbE1jTmlHSmt5R1hNQVZIaGV5TW9w?=
 =?utf-8?B?aHdzaklMckYrb0NlQ3lHb1lhRi9yQkZKeHRiYUJ5ZVhDM2gwZ1NiZUpGYzF1?=
 =?utf-8?B?QzdscEIzRmkxNjdGcGpoZkhSWHdhVHhWMlZVZFJwYklTbmhOSkZQbE5neG4v?=
 =?utf-8?B?a2kyV045ZWdvYWx3R0ZjOWM2TTBCWUdKL1l3TUQzSFkzeDFYMjBxdmV1disr?=
 =?utf-8?B?TGdpL3FVSUVaUTIxZlNzblpZNTdkbERXN0FzZmYzeWs0OFJLazQ0QU80b1Vz?=
 =?utf-8?B?OS80aGpMSTdNQXFPdWJINGE5SDRMMVdPMHZlY0IrNGdpcWg5dVA0Y0NrOFlB?=
 =?utf-8?B?VWRxMmZJbzZ2dktVdDM1N3lVUFlHSWJYYjJwZHVEWG14VGdKWkE1L0VIdUNl?=
 =?utf-8?B?V29KTVhyUk1qWXVJc0lWbm5ZaHkxbmkydm9aL2pvS2ljbndFVlVqdEJ2bmJ4?=
 =?utf-8?B?WFU4dFhHdzV4ckVod052NUxtQzB3THNzUWM4R0FDc3d0OVBtbjZzVVpVdHRa?=
 =?utf-8?B?SGVJZVFTSFNIRjN3NDFDWkxFWGJUUEZDanB6OUt2TFAra29UcFF6MXZLVzA3?=
 =?utf-8?B?RzBpeVNDdmlZT1ZHbzY2OCtTeW5vMCtteFFLNTdLY1owUVNtOEplZ2VwNUt5?=
 =?utf-8?B?RFZoRnA4SDZSNGwxRDZaQ3hEUmJ3ZU1BaTNGbVUzRlBTZ1kyTEdHTlJIQXVu?=
 =?utf-8?B?YWVCSis0TDlYNEFMS3ova0ZqaFErNnR3NVlEVWd3UkN2S1IxbTNwbWs3Mjhp?=
 =?utf-8?B?RytoN0VYdXpGd0crTnM3aFhrUjMxYU1qaCsxY2xPZWM1ektoRVFBenV4Ri80?=
 =?utf-8?B?VEJ6cmpmZERSR25ScXpyOWtQQVBuWEg2L2dHM004QzZzRDVkNWZGNHhzbUp0?=
 =?utf-8?B?M3FxMWN2TUZadnc1dXNRUkhrd2hDQUlJVzJEOUp6Q2ovaWRoZ0dXdz09?=
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e5d8c8-6c6b-473a-cc86-08deb0953c79
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 02:13:34.3853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRa1wl/XAdWQqmDxKDZFMtgsavfvr//r/M5XjflJc8BgfCU9wHRWvNORc3XXnJx+HRzXH6F1iumGlFTABaqwpXUNwYaM9Aep/SRuexYp4z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5480
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

SGkgVG9tIFJpbmksIE1pY2hhZWwsDQoNCkFueSB1cGRhdGU/IENhbiB3ZSBtZXJnZSB0aGlzIGN1
c3RvZGlhbiBicmFuY2ggdG8gdGhlIG1hc3Rlcj8NCmh0dHBzOi8vc291cmNlLmRlbnguZGUvdS1i
b290L2N1c3RvZGlhbnMvdS1ib290LW5hbmQtZmxhc2gvLS9jb21taXRzL25hbmQtMDcwNDIwMjY/
cmVmX3R5cGU9aGVhZHMNCg0KUmVnYXJkcw0KRGluZXNoDQoNCg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCkZyb206IE1BTklZQU0sIERJTkVTSA0KU2VudDogVHVlc2RheSwgMjgg
QXByaWwgMjAyNiAxMTo0NCBhbQ0KVG86IE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaSA8bWlj
aGFlbEBhbWFydWxhc29sdXRpb25zLmNvbT4NCkNjOiBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28u
Y29tPjsgVS1Cb290LURlbnggPHUtYm9vdEBsaXN0cy5kZW54LmRlPjsgTWFyZWsgVmFzdXQgPG1h
cmV4QGRlbnguZGU+OyBTaW1vbiBHb2xkc2NobWlkdCA8c2ltb24uay5yLmdvbGRzY2htaWR0QGdt
YWlsLmNvbT47IERhcmlvIEJpbmFjY2hpIDxkYXJpby5iaW5hY2NoaUBhbWFydWxhc29sdXRpb25z
LmNvbT47IFJpY2hhcmQgR2Vub3VkIDxyaWNoYXJkLmdlbm91ZEBib290bGluLmNvbT47IEphbWVz
IEhpbGxpYXJkIDxqYW1lcy5oaWxsaWFyZDFAZ21haWwuY29tPjsgTWlxdWVsIFJheW5hbCA8bWlx
dWVsLnJheW5hbEBib290bGluLmNvbT47IENoZWUsIFRpZW4gRm9uZyA8dGllbi5mb25nLmNoZWVA
YWx0ZXJhLmNvbT47IEhlYSwgS29rIEtpYW5nIDxrb2sua2lhbmcuaGVhQGFsdGVyYS5jb20+OyBO
RywgQk9PTiBLSEFJIDxib29uLmtoYWkubmdAYWx0ZXJhLmNvbT47IFlVU0xBSU1JLCBBTElGIFpB
S1VBTiA8YWxpZi56YWt1YW4ueXVzbGFpbWlAYWx0ZXJhLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0ggMS8yXSBtdGQ6IG5hbmQ6IHJhdzogS2NvbmZpZzogY2xlYW4gdXAgU1BMIENhZGVuY2UgTkFO
RCBkZXBlbmRlbmNpZXMNCg0KSGkgTWljaGFlbCwNCg0KT24gNy80LzIwMjYgMzoxNSBwbSwgTWlj
aGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpIHdyb3RlOg0KPiBbQ0FVVElPTjogVGhpcyBlbWFpbCBp
cyBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24uIFVubGVzcyB5b3UgdHJ1c3QgdGhlIHNl
bmRlciwgZG8gbm90IGNsaWNrIG9uIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgYXMgaXQgbWF5
IGJlIGEgZnJhdWR1bGVudCBlbWFpbCBhdHRlbXB0aW5nIHRvIHN0ZWFsIHlvdXIgaW5mb3JtYXRp
b24gYW5kL29yIGNvbXByb21pc2UgeW91ciBjb21wdXRlci5dDQo+DQo+IEhpIERJTkVTSA0KPg0K
PiBZb3VyIHNlcmllcyBpcyBoZXJlLCBJIHdpbGwgaGF2ZSB0aW1lIHRoaXMgd2Vlay4NCj4NCj4g
aHR0cHM6Ly9zb3VyY2UuZGVueC5kZS91LWJvb3QvY3VzdG9kaWFucy91LWJvb3QtbmFuZC1mbGFz
aC8tL2NvbW1pdHMvbmFuZC0wNzA0MjAyNg0KPg0KPiBJIG5lZWQgdG8gdGFrZSBjYXJlIG9mIG90
aGVyIHBhdGNoZXMgdG9vLiBJIGhhdmUgc29tZSBFYXN0ZXIgc3RvcHMgdG8NCj4gYWRkcmVzcywg
YW5kIEkgYWxzbyBoYXZlIG90aGVyIHBhdGNoZXMgZnJvbSBCb290bGluIHRvIGZpbmlzaA0KPiBy
ZXZpZXdpbmcgYW5kIG90aGVycyB0byBxdWV1ZSB0aGlzIHdlZWsNCj4NCj4gTWljaGFlbA0KPg0K
PiBPbiBUdWUsIEFwciA3LCAyMDI2IGF0IDg6NDHigK9BTSBNQU5JWUFNLCBESU5FU0gNCj4gPGRp
bmVzaC5tYW5peWFtQGFsdGVyYS5jb20+IHdyb3RlOg0KPj4gSGkgTWljaGFlbCwNCj4+DQo+Pj4g
SGkNCj4+Pg0KPj4+IFllcyBJIGhhdmUgdHdvIHNlcmllcyBvbiBteSBxdWV1ZSwgSSBJIHdpbGwg
d29yayBvbiB0aGVtIHRoaXMgd2Vlay4NCj4+Pg0KPj4+IE1pY2hhZWwNCj4+Pg0KPj4+IE1pY2hh
ZWwgTmF6emFyZW5vIFRyaW1hcmNoaQ0KPj4+IENvLUZvdW5kZXIgJiBDaGllZiBFeGVjdXRpdmUg
T2ZmaWNlcg0KPj4+IE0uICszOSAzNDcgOTEzIDIxNzANCj4+PiBtaWNoYWVsQGFtYXJ1bGFzb2x1
dGlvbnMuY29tDQo+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPj4+DQo+
Pj4gQW1hcnVsYSBTb2x1dGlvbnMgQlYNCj4+PiBKb29wIEdlZXNpbmt3ZWcgMTI1LCAxMTE0IEFC
LCBBbXN0ZXJkYW0sIE5MDQo+Pj4gVC4gKzMxICgwKTg1IDExMSA5MTcyDQo+Pj4gaW5mb0BhbWFy
dWxhc29sdXRpb25zLmNvbQ0KPj4+IHd3dy5hbWFydWxhc29sdXRpb25zLmNvbTxodHRwOi8vd3d3
LmFtYXJ1bGFzb2x1dGlvbnMuY29tPg0KPj4gQW55IHVwZGF0ZSBvbiB0aGVzZSAyIHNlcmllcz8N
Cj4+DQo+PiBSZWdhcmRzLA0KPj4gRGluZXNoDQo+PiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KPj4gRnJvbTogTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpIDxtaWNoYWVsQGFt
YXJ1bGFzb2x1dGlvbnMuY29tPg0KPj4gU2VudDogVGh1cnNkYXksIDI2IE1hcmNoIDIwMjYgMTo1
NyBwbQ0KPj4gVG86IE1BTklZQU0sIERJTkVTSCA8ZGluZXNoLm1hbml5YW1AYWx0ZXJhLmNvbT4N
Cj4+IENjOiBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsgVS1Cb290LURlbnggPHUtYm9v
dEBsaXN0cy5kZW54LmRlPjsgTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+OyBTaW1vbiBHb2xk
c2NobWlkdCA8c2ltb24uay5yLmdvbGRzY2htaWR0QGdtYWlsLmNvbT47IERhcmlvIEJpbmFjY2hp
IDxkYXJpby5iaW5hY2NoaUBhbWFydWxhc29sdXRpb25zLmNvbT47IFJpY2hhcmQgR2Vub3VkIDxy
aWNoYXJkLmdlbm91ZEBib290bGluLmNvbT47IEphbWVzIEhpbGxpYXJkIDxqYW1lcy5oaWxsaWFy
ZDFAZ21haWwuY29tPjsgTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT47
IENoZWUsIFRpZW4gRm9uZyA8dGllbi5mb25nLmNoZWVAYWx0ZXJhLmNvbT47IEhlYSwgS29rIEtp
YW5nIDxrb2sua2lhbmcuaGVhQGFsdGVyYS5jb20+OyBORywgQk9PTiBLSEFJIDxib29uLmtoYWku
bmdAYWx0ZXJhLmNvbT47IFlVU0xBSU1JLCBBTElGIFpBS1VBTiA8YWxpZi56YWt1YW4ueXVzbGFp
bWlAYWx0ZXJhLmNvbT4NCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBtdGQ6IG5hbmQ6IHJh
dzogS2NvbmZpZzogY2xlYW4gdXAgU1BMIENhZGVuY2UgTkFORCBkZXBlbmRlbmNpZXMNCj4+DQo+
Pg0KPj4gW0NBVVRJT046IFRoaXMgZW1haWwgaXMgZnJvbSBvdXRzaWRlIHlvdXIgb3JnYW5pemF0
aW9uLiBVbmxlc3MgeW91IHRydXN0IHRoZSBzZW5kZXIsIGRvIG5vdCBjbGljayBvbiBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIGFzIGl0IG1heSBiZSBhIGZyYXVkdWxlbnQgZW1haWwgYXR0ZW1w
dGluZyB0byBzdGVhbCB5b3VyIGluZm9ybWF0aW9uIGFuZC9vciBjb21wcm9taXNlIHlvdXIgY29t
cHV0ZXIuXQ0KPj4NCj4+IEhpDQo+Pg0KPj4gWWVzIEkgaGF2ZSB0d28gc2VyaWVzIG9uIG15IHF1
ZXVlLCBJIEkgd2lsbCB3b3JrIG9uIHRoZW0gdGhpcyB3ZWVrLg0KPj4NCj4+IE1pY2hhZWwNCj4+
DQo+PiBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkNCj4+IENvLUZvdW5kZXIgJiBDaGllZiBF
eGVjdXRpdmUgT2ZmaWNlcg0KPj4gTS4gKzM5IDM0NyA5MTMgMjE3MA0KPj4gbWljaGFlbEBhbWFy
dWxhc29sdXRpb25zLmNvbQ0KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
Pj4NCj4+IEFtYXJ1bGEgU29sdXRpb25zIEJWDQo+PiBKb29wIEdlZXNpbmt3ZWcgMTI1LCAxMTE0
IEFCLCBBbXN0ZXJkYW0sIE5MDQo+PiBULiArMzEgKDApODUgMTExIDkxNzINCj4+IGluZm9AYW1h
cnVsYXNvbHV0aW9ucy5jb20NCj4+IHd3dy5hbWFydWxhc29sdXRpb25zLmNvbTxodHRwOi8vd3d3
LmFtYXJ1bGFzb2x1dGlvbnMuY29tPg0KPj4NCj4+IElsIGdpbyAyNiBtYXIgMjAyNiwgMDM6NTcg
TUFOSVlBTSwgRElORVNIIDxkaW5lc2gubWFuaXlhbUBhbHRlcmEuY29tPiBoYSBzY3JpdHRvOg0K
Pj4NCj4+IEhpIE1pY2hhZWwsDQo+Pg0KPj4NCj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQo+PiBGcm9tOiBUb20gUmluaQ0KPj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCA0LCAy
MDI2IDEwOjM5IFBNDQo+PiBUbzogTUFOSVlBTSwgRElORVNIDQo+PiBDYzogdS1ib290QGxpc3Rz
LmRlbnguZGU7IE1hcmVrIFZhc3V0OyBTaW1vbiBHb2xkc2NobWlkdDsgRGFyaW8gQmluYWNjaGk7
IE1pY2hhZWwgVHJpbWFyY2hpOyBSaWNoYXJkIEdlbm91ZDsgSmFtZXMgSGlsbGlhcmQ7IE1pcXVl
bCBSYXluYWw7IENoZWUsIFRpZW4gRm9uZzsgSGVhLCBLb2sgS2lhbmc7IE5HLCBCT09OIEtIQUk7
IFlVU0xBSU1JLCBBTElGIFpBS1VBTg0KPj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIG10ZDog
bmFuZDogcmF3OiBLY29uZmlnOiBjbGVhbiB1cCBTUEwgQ2FkZW5jZSBOQU5EIGRlcGVuZGVuY2ll
cw0KPj4NCj4+IE9uIFdlZCwgTWFyIDA0LCAyMDI2IGF0IDExOjI0OjQwQU0gKzA4MDAsIGRpbmVz
aC5tYW5peWFtQGFsdGVyYS5jb20gd3JvdGU6DQo+Pg0KPj4+IEZyb206IERpbmVzaCBNYW5peWFt
IDxkaW5lc2gubWFuaXlhbUBhbHRlcmEuY29tPg0KPj4+DQo+Pj4gRml4IGFuZCBhbGlnbiBLY29u
ZmlnIGRlcGVuZGVuY2llcyBmb3IgQ2FkZW5jZSBOQU5EIGluIFNQTC4NCj4+PiBNb3ZlIFNQTC1z
cGVjaWZpYyBzZWxlY3RzIHRvIFNQTF9OQU5EX0NBREVOQ0UgYW5kIHJlbW92ZSB0aGVtIGZyb20g
dGhlDQo+Pj4gbm9uLVNQTCBOQU5EX0NBREVOQ0Ugb3B0aW9uLiBUaGlzIGF2b2lkcyBpbmNvcnJl
Y3Qgc3ltYm9sIHNlbGVjdGlvbiBhbmQNCj4+PiBrZWVwcyBTUEwgQ2FkZW5jZSBOQU5EIHN1cHBv
cnQgc2VsZi1jb250YWluZWQuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBEaW5lc2ggTWFuaXlh
bSA8ZGluZXNoLm1hbml5YW1AYWx0ZXJhLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBUb20gUmluaSA8
dHJpbmlAa29uc3Vsa28uY29tPg0KPj4NCj4+IC0tDQo+PiBUb20NCj4+DQo+PiBUaGlzIHBhdGNo
IGhhcyBiZWVuIHJldmlld2VkIGJ5IFRvbSBSaW5pLg0KPj4gV2hlbiB5b3UgaGF2ZSBhIGNoYW5j
ZSwgY291bGQgeW91IHBsZWFzZSB0YWtlIGEgbG9vaz8NCj4+IElmIHRoZXJlIGFyZSBubyBmdXJ0
aGVyIGNvbmNlcm5zLCBJ4oCZZCBhcHByZWNpYXRlIHlvdXIgY29uc2lkZXJhdGlvbiBmb3IgbWVy
Z2luZy4NCj4+IFRoYW5rcyBmb3IgeW91ciB0aW1lLg0KPj4NCj4NCj4gLS0NCj4gTWljaGFlbCBO
YXp6YXJlbm8gVHJpbWFyY2hpDQo+IENvLUZvdW5kZXIgJiBDaGllZiBFeGVjdXRpdmUgT2ZmaWNl
cg0KPiBNLiArMzkgMzQ3IDkxMyAyMTcwDQo+IG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20N
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPg0KPiBBbWFydWxhIFNvbHV0
aW9ucyBCVg0KPiBKb29wIEdlZXNpbmt3ZWcgMTI1LCAxMTE0IEFCLCBBbXN0ZXJkYW0sIE5MDQo+
IFQuICszMSAoMCk4NSAxMTEgOTE3Mg0KPiBpbmZvQGFtYXJ1bGFzb2x1dGlvbnMuY29tDQo+IHd3
dy5hbWFydWxhc29sdXRpb25zLmNvbTxodHRwOi8vd3d3LmFtYXJ1bGFzb2x1dGlvbnMuY29tPg0K
Pg0KPiBBbnkgdXBkYXRlIG9uIHRoZXNlIHBhdGNoZXMsIGRvIHlvdSBhYmxlIHRvIG1lcmdlIGl0
Pw0KPg0KPiBSZWdhcmRzDQo+IERpbmVzaA0K
