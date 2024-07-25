Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94F6C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 09:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 194AD8690D;
	Thu, 25 Jul 2024 11:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="X4Awc9lo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E149E86FB1; Thu, 25 Jul 2024 11:58:30 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D23578690D
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrcEdjvg4COlYqyORB8dWPWJte+kCQDxYtVTx0P9Fh8VVRb5nz+vQY+BZ9y1aaUPaM0xips/3PC9BBLzREDcjg0x4IPUrja9WoSZFfVDhF6V7HyrxjJ3ZhaJVFVth3vkC9PIk8guV9VJz/4VHKodbo/N6lyqWaxvzAMWwAqyDpz0MO/UFH4C19vQdNaxxJo7gildbIz/qGYbmEuoH+t9sdNgqSJZ6Ugh3JBSa9Dngg+0Xc5czXdTW0qkUKTblT2ptu8qWitLZndLRtrueW91wO5vjIyEGvRunZFyUUNvbfSCkR8GwaErsJVfFWCoM/ZY9IFvZtuLsZhobVM0FriXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImodFSJo5d4btRPVTZozwvwu5sp8XCM9K7mhZfhhAho=;
 b=NzmhV5yGXBe/gRdjM3W8KCwMXPn1nLsWAXnbZhtESpiudQ1LsAlVpLMjuWcTgL7a//DrdfZ4uJ4Fz1PBkCrvhfG/x+QQLTjsYEqyAkUfuRThNtQz8PZEF7utAhwbop4n63kiQsjhBAQSIhRdPRbP1GYEW5AHbunqAHKL6b5+1AqQ3fqH7hoFKPwUR/2DfYiQRh4i5Cm6UnmJLFa3gDJRsWWUwm4zdUTk934XDrqWGsYrz9R4b+jgbOo7fK/La9frmLMN2AICCbUoMk4PIqjjEhqZ00vWy7/vwZeioCkeKL6/Pu809qyG6OZO+6C92O2Jtx+dcovACFD3m6hNDVcnUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImodFSJo5d4btRPVTZozwvwu5sp8XCM9K7mhZfhhAho=;
 b=X4Awc9logF42RgvGc1SZodkx49rzBz69OtvP0nl30pKNNVlJ9Crmbt8LTuGrVDnMfcq+cXkQol6hEZfQJRtrH4/lL8NRZh66H47TjvwVgi/f+MV39EBkb4DBGsP4/l38Zokqiv2SE3Jkz/RxPfdRQr3aWZTCot13MpdYpjDHKdcSsDioMnO+2VQkcurRQsDANPIOGl+gKMZYC26xqcmCKur/bir2Dn8dYARXGOEklWGOe6KpS68uTBgTjk07F0YYZpzHxpl/elLqaHIKKNgM3YlQbx+WxD8JzeFnI19u7bqNdVi+QOj+8hnH4UYNgtXoKU62hQZphai4r/K/GBFhsw==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by AM9PR04MB8129.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 09:58:26 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 09:58:26 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Simon Glass
 <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com"
 <seanga2@gmail.com>
Subject: RE: [PATCH] clk: fix ccf_clk_get_rate
Thread-Topic: [PATCH] clk: fix ccf_clk_get_rate
Thread-Index: AQHa3mKN7U19CG9BQkGdhXtEbE4r3rIHDK2AgAANqsCAABI1gIAAAwEw
Date: Thu, 25 Jul 2024 09:58:26 +0000
Message-ID: <DB9PR04MB9236322AD261E061C1DB573484AB2@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240725073707.26040-1-Zhiqiang.Hou@nxp.com>
 <CAOf5uwm-kedmeH7at0F5+zfuJ9218NwRSJjA4_vjTGvpsJ7msA@mail.gmail.com>
 <DB9PR04MB9236ACC9C613982795A9E5AC84AB2@DB9PR04MB9236.eurprd04.prod.outlook.com>
 <CAOf5uw=nNter1RSuxvaXZ0NFkoOkqAKyQs2_97Ap4W5KhXSQmA@mail.gmail.com>
In-Reply-To: <CAOf5uw=nNter1RSuxvaXZ0NFkoOkqAKyQs2_97Ap4W5KhXSQmA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|AM9PR04MB8129:EE_
x-ms-office365-filtering-correlation-id: 2826c79e-944c-4277-0571-08dcac905417
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MEJ3OTlHa3lJZW94M25LSURGVjA1Qi9YMnl1MHcxVXNUbjU2eDVqUTNrdUhN?=
 =?utf-8?B?YjdsVVNsYzhkVFlRN1lkTUdwd0lBSkJoeisyRm5KR2N5bGFHdmRQVm5UcmVP?=
 =?utf-8?B?RDEyNFUvSStFOXIxZUVsN3FwZ0hDVWVvYmlUQmtDNWFmZEhUbkhReFdEc2hV?=
 =?utf-8?B?VzViUXhaN1M5S1BPV1ZvYTJTak9NUVhzNjljZE5ZLzE2SFBMU2hVVStYekM0?=
 =?utf-8?B?YWxwWGFMOWgrNXFVUVd2VUxHT1U2bDFoeUpwQ0NQMFFENVVnWEptbVFoZ0dU?=
 =?utf-8?B?WVhxL1p0WUVTd3JrZ01wanpSZmlva0Y3c09DV0NRTVZ6Mk9kNFBsS21lcUJt?=
 =?utf-8?B?WTEzdFRueitTdXk3SUREbGllWHJHYzl6TnFETWFrVTkrQXEzMEpuVXRwQlhG?=
 =?utf-8?B?NTNMY3hlN0oyYU84VmlNUmxWa3FyQTc3MFpaMEF5Q2tNb091VWlmQ1NVMjZF?=
 =?utf-8?B?aVVmTE0vQWpWazA2cTRtcnNWU0F0dkpKcGsyRzNQeDhPd05vZ21CcW9Jdm9m?=
 =?utf-8?B?U1lJS2VBeDFHM1pKUnVZUUxNbFZLbklTNHJvWnVjamhuUXhzMGloWXh1OTRR?=
 =?utf-8?B?RUZwTmhpcW1hUS9CK0JmdU4xU1Zxb2VqV0poWmZFSzBoSHdnMkI5M21nL0oz?=
 =?utf-8?B?aDk5QXdtZnU4RE9nRERKMWc3OCtvMHV4d2tKLy9ubkc5Zjc0UUxIM3J1bHZi?=
 =?utf-8?B?cW1YUmpKblJwOG5LZUE2bzhuOVRVWE03MWtTZHdsVXRvRW83YkVlYmxSM3ht?=
 =?utf-8?B?WmRHT2R2c1I5a1JjM0xFWUhtT2JHS3lSQStYV2M5ZktUVlRDdXFwVC9ocXNt?=
 =?utf-8?B?K1lOeVFwNGRYbHZWQjNZVFRwcEpXWVJEUHpyT2lXdHRSalhmN055RW85RFdB?=
 =?utf-8?B?Z2ZmZEJoYkJqWG02U2VGWDE1dzVDUGJLU3U3VnNjSE9jZENGSEFUSXh5K00y?=
 =?utf-8?B?bDE2eGZYZXVia25kR0NpbHJ3ZHFhZThUQm5WUms2WFM4NVBLZThyaUYzOGFJ?=
 =?utf-8?B?VUpVTm14UksrcXExK2dJT3BCMWVtZDdOMlNmMEY0MUNQQS8yb2t5b2pmWkk0?=
 =?utf-8?B?WnhCNS81SWFiSmF2UGtHWitJSEFoYjFYL3RaRDE3WVBlQXRna3lrN3hqdVQ3?=
 =?utf-8?B?b0VJL0RzaUd0SjYzWFk0dUpITFJnbWlYMWZYQ1VIRmVMa2NldU0rWmp4ek4x?=
 =?utf-8?B?ODFEZmtBVkFJSWY0SW1EZ3RPZWJGUWVKU0lrbjc2QjBJK2VGYWI4cUFVb0l6?=
 =?utf-8?B?bUIrZ2pNclF1Lzc2MlRxUDh5Y1VkOUhHV2l3cFRTNHRuYVBJMmhkSjVKM2pC?=
 =?utf-8?B?dEQ1KzFDbHlzTHJ3QS9aS2hrUUJCM3lKbE1vaFhPNGh2VENCM2VkOXRuM3po?=
 =?utf-8?B?YUg5cytzSDQwcmliN2RqZTFVK0c3OEQrRHJSeWhPUjJIdmo4aktSeTlNQzhn?=
 =?utf-8?B?TExYaERQRE5JWG95Um1SYlVoQXdWaXhXMXE4N29FVVhHeUIyWG1jNEZkcUhW?=
 =?utf-8?B?VE9lNVNHNWh2TlA3QmM1c0Q1RllKeW9TMG1nVU1ObzZPbGw1RFEwb1FOTjRt?=
 =?utf-8?B?QnBqRGlFNlhlTEtBVGVvcWdoeDJ1MVVrNDZVUXdLL1dOdDFkZ0dkcTRNUnlm?=
 =?utf-8?B?a3lLTG00c01mdFZOQllZcm5KUXlsWk9CTW9hK2xkSTc1U0JWRW1Tb2FNbFdJ?=
 =?utf-8?B?RmdvcnY1M2cvT3dMWXNqano0UWFVM3M0d3M4VlM0TVlhL016eXFTQW1XUmdz?=
 =?utf-8?B?TC85ZThNR0hPNGk4MGRFNjlTSkV5ajFDZ2VuTW1lbDRzSXlNd01MY3Rmdk1X?=
 =?utf-8?B?bGpwL1hXU2xMRldRYnRaRkVLeFpYU2EzcGFZU3BLSmtuN2YzUEp4M0dmakhq?=
 =?utf-8?B?MVJ1Y0JVd0FMWXFLcWpBNkdveW9qMStRaFpVdmt1cmlDQlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0VYYy9rNzB3WXl2ZVJrNTJ5NXpYN0Z0cWw5V1BOMW9BOGpUUHdZZjlEYks3?=
 =?utf-8?B?NzA2bU00TWlHK1FoeVRYcEN6ZllXYzhyWngrWm4wRmVzZUFoZGRSZnlSeCtV?=
 =?utf-8?B?T0o3YlVRNVhpMUprNmo3MkpCNW1haGlnU2pVWUd0OU56aTU0UW9ETlRaYnBl?=
 =?utf-8?B?N0ZrdzVBeTBIbi8xRythc2wxa2hYZTlKdldCa3BpRFQ0MUp2SVAzWHk2NnA0?=
 =?utf-8?B?UUY5M3FNTmtaL3BRVm9MNms4U3NQTWJNZktiTkN2ckVET0dEc2tEK1NiVzcw?=
 =?utf-8?B?THRheS9tbDROWUlwQUlwQkRGNU5PT3NMS0hCTUc5a1FQTzVwRlZvRkoxaGww?=
 =?utf-8?B?dWlFY0pTRzYxQ3h1dUpHOUd1aG40UXp0MTVINkx2Tll1NEJ0aXd1SHhNSVVG?=
 =?utf-8?B?RjVkaGkwKy9IV1ZBemswU0VBdHBWQ0VyV3VsbzJPZ1g3V1NpSzJPdkJNTDlv?=
 =?utf-8?B?RGthajlzaXZyd204azBpQVpRRDVuVkJXOExrdkhodTliNytmSzFKVUIvL0U1?=
 =?utf-8?B?OEZIZUNzMWtXSkkwd1hLMDdSTktlVEdLZExJc2JiZWc5cVkxcytpYWdqQ0FF?=
 =?utf-8?B?UFhwWVBNeGRCSG12NEdLODB4WmVXWm1OWkZrVUowWndVNVBBMkZaU0RrSFE2?=
 =?utf-8?B?M2toK1NCUkE0dm83eEk0Ui9KZWxxY21UYTdSL3F0UlJFN2tEcUhoSnVHMGJ0?=
 =?utf-8?B?T0RMZUVLQnIrdGxhTkpzOXZSZ3IxSTZ6eCsvWXBPWFRHTWlkUVRDT0JvVUY5?=
 =?utf-8?B?R2YvVE9yWlVBWHorcXF4Z0NkQTlHY0xYQVRyUCtvZGxpZ1lJUVlwVXkrR1VG?=
 =?utf-8?B?NVk0RWdBUW9EUlgwUXVONmRRWU9XaWxSbVhTbUExZFFoLzlqclJXRlVxOGVt?=
 =?utf-8?B?TXVMb2k5TU5FdjhtbThnSUdzZjlCTlJrRE1BVnpvd2N4clB1Qmg2RGtJN3pN?=
 =?utf-8?B?UkNFZVIyVkd2SUd4MDJkYzhPeGhaOWFTMDBEYVBTa01uZnlCTUtGMGNIc2Z5?=
 =?utf-8?B?MlZ2WDAyOXZDR1BKckJwSk9hSlhjN2FDSzFSZ2Jmb3RYZHMwYWthRGh2am84?=
 =?utf-8?B?MFRpeEcwUVFuNlVCK01qMHpVK3EzN2MvUUtxNVdBbXNuNXp4d2dYenpmOTQ5?=
 =?utf-8?B?Y1ZyaVpjM25URGY1Y1lDaEowNGtxNWtyTU8zRlZZWlc0OWFoOVNvZnN5QmxU?=
 =?utf-8?B?UE42WHQveU5GRnl6Ly9sMHFpQ2NxMHR1aURUdGQxN0hCclRlczRsZy9kS09M?=
 =?utf-8?B?MENEenBpaFdjSDNKV05TTEVnUS9VN1cyU1lueTg5U1d4SjJmWGFIK29NZFJN?=
 =?utf-8?B?UXJxTmN0REFiY0VzTmpqOFlMZU1MMXJsdG5tTHJ0ZDFibThUd0JFUzBIeGNN?=
 =?utf-8?B?VllWV3BNaUQ4RC96MmJnWk13YUd0YlQwNENKb2EwK3FSVzFFSFFhS0JicXYx?=
 =?utf-8?B?Smd4UXhvMTlZaXRENCs2bVZ0Wms1Vm01ZEd6TE1NNUxzTC9sQVlmOUo4MWtO?=
 =?utf-8?B?UURsQ21mUmhweFpHUk0zZUFzQkx5SkxDSTNCYlVCWVp1bm9DRjMrTlJ0N3ZT?=
 =?utf-8?B?OXQxcGVPM1BMbUptanoyVjdpSHRjMGp5NWsyVU94bHh2blZwbTV5M09Falor?=
 =?utf-8?B?M05pbVVZSFpLR01STXBLRjlRWTdEYTQvUnpXVUhTenYzYkhGbmJmTE5OZWxy?=
 =?utf-8?B?NjNiVXpZbGhuampsMkxoZVdWNWlBOGhoYms3T2g2OFhsWHgzZm1oNkxYNzds?=
 =?utf-8?B?eDErdmxGOG03cjgxWFRWWXVsTnB5a0wzNWZUZk5LM0hEdHpRY2VHZVlKN0lE?=
 =?utf-8?B?bnRKK1p6Ylk1VzZOZnBZSk4xanptbEhja002QWZoV3Z0QXNOdy9aSFFmdmZq?=
 =?utf-8?B?UUdYd0FrcDk3UktGSXRmWlc2SHhEWlVzc1UwQ0pBS3MrdUM0bFgxOXZ5SU44?=
 =?utf-8?B?Q25HZ1pWNUthK0tlVnBlS1A0d3dnWmZKWFV4SW8zOGlwaHJXTTVaUjNuWmtS?=
 =?utf-8?B?cE1wUzVRUG1VMExSYnRZUVNubE5sd0MydWdmemdDRGx0ZFh5RkNReElIQkh3?=
 =?utf-8?B?SGt1eTVJZ0RzTGl3b1c1akF5bXhoYXRyNzBrSC9xcUpEZkhtNWk5Y1VqRk9a?=
 =?utf-8?Q?NNU5KK7G24gUSfUCkIPealgeu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2826c79e-944c-4277-0571-08dcac905417
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 09:58:26.5639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXHlnnNTBAcF60M6H5t8TH0Z4sFqDAvECkW/7v4xJ8F/IoGW81+msOItqlaMzPHwzdH5gYYc2ZnhEZeHh61hew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8129
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

SGkgTWljaGFlbCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNo
YWVsIE5henphcmVubyBUcmltYXJjaGkgPG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDI1LCAyMDI0IDU6MjYgUE0NCj4gVG86IFouUS4gSG91IDx6
aGlxaWFuZy5ob3VAbnhwLmNvbT47IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPg0KPiBD
YzogdS1ib290QGxpc3RzLmRlbnguZGU7IHRyaW5pQGtvbnN1bGtvLmNvbTsgbHVrbWFAZGVueC5k
ZTsNCj4gc2VhbmdhMkBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY2xrOiBmaXgg
Y2NmX2Nsa19nZXRfcmF0ZQ0KPiANCj4gSGkNCj4gDQo+IE9uIFRodSwgSnVsIDI1LCAyMDI0IGF0
IDEwOjUz4oCvQU0gWi5RLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPiB3cm90ZToNCj4gPg0K
PiA+IEhpIE1pY2hhZWwsDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPiBGcm9tOiBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkgPG1pY2hhZWxAYW1hcnVsYXNv
bHV0aW9ucy5jb20+DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgSnVseSAyNSwgMjAyNCAzOjMyIFBN
DQo+ID4gPiBUbzogWi5RLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiA+ID4gQ2M6IHUt
Ym9vdEBsaXN0cy5kZW54LmRlOyB0cmluaUBrb25zdWxrby5jb207IGx1a21hQGRlbnguZGU7DQo+
ID4gPiBzZWFuZ2EyQGdtYWlsLmNvbQ0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gY2xrOiBm
aXggY2NmX2Nsa19nZXRfcmF0ZQ0KPiA+ID4NCj4gPiA+IEhpDQo+ID4gPg0KPiA+ID4gT24gVGh1
LCBKdWwgMjUsIDIwMjQgYXQgOToxNuKAr0FNIFpoaXFpYW5nIEhvdSA8WmhpcWlhbmcuSG91QG54
cC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gRnJvbTogSG91IFpoaXFpYW5n
IDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gQXMgdGhlIHR5cGUgb2Yg
cmV0dXJuIHZhbHVlIGlzICd1bG9uZycsIHdoZW4gY2xrX2dldF9ieV9pZCgpDQo+ID4gPiA+IGZh
aWxlZCwgaXQgc2hvdWxkIHJldHVybiAwIHRvIGluZGljYXRlIHRoZSBnZXRfcmF0ZSBvcGVyYXRp
b24gZG9lc24ndA0KPiBzdWNjZWVkLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IEkgdW5kZXJzdGFu
ZCB5b3VyIHBvaW50IGhlcmUgYnV0IHRoZSBjbGtfZ2V0X3JhdGUgdGhhdCBjYW4gY2FsbCB0aGUN
Cj4gPiA+IGNjZiBjbGtfZ2V0X3JhdGUgY2FuIGFscmVhZHkgcmV0dXJuIC1FTk9TWVMuDQo+ID4N
Cj4gPiB3aWxsIGFsc28gZml4IGl0Lg0KPiA+DQo+IA0KPiBJcyB0aGVyZSBhbnkgdXNhZ2Ugb2Yg
dGhlIGVycm9yIHNldCBvbiB0aGUgbGF0ZXN0IGJpdCBvZiB0aGUgY2xvY2s/IFdlIG5lZWQgdG8N
Cj4gYmUgc3VyZSB0aGF0IHRoaXMgaXMgY29ycmVjdCB1c2UgYWNjcm9zcyB0aGUgdWJvb3QuIFRo
ZSBjbGstdWNsYXNzIGRlZmluZSB0aGUNCj4gZXJyb3IgdGhhdCBjYW4gcmV0dXJuDQoNClRoZSBw
cm9ibGVtIGlzIHRoaXMgZnVuY3Rpb24ncyByZXR1cm4gdmFsdWUgaXMgJ3Vsb25nJywgaWYgdXNl
IHRoZSBlcnJvciBzZXQsIHRoZSBjYWxsZXIgd2lsbCB0cmVhdCBpdCBhcyBhIGdvb2QgdmFsdWUg
aW5zdGVhZCBvZiBhIGVycm9yIG51bWJlci4gVGhlcmUgYXJlIHNldmVyYWwgQVBJcyBoYXZlIHRo
ZSBzYW1lIHByb2JsZW0uDQoNCjIgbWV0aG9kcyB0byBmaXggaXQ6DQoxLiBrZWVwIHRoZSBBUEkn
cyBwcm90b3R5cGUsIGFuZCB1c2UgJzAnIHRvIGluZGljYXRlIGVycm9yIGNvbmRpdGlvbiwgYnV0
IGEgcmVhbCAnMCcgcmV0dXJuIHZhbHVlIGlzIGFsc28gY29uc2lkZXJlZCBhcyBlcnJvci4NCjIu
IENoYW5nZSB0aGUgcmV0dXJuIHR5cGUgdG8gbGlrZSAnbG9uZyBsb25nIGludCcsIGFuZCB1c2Ug
YSBuZWdhdGl2ZSBlcnJvciBudW1iZXIgdG8gaW5kaWNhdGUgZXJyb3IgY29uZGl0aW9uLiBOZWVk
IHRvIHVwZGF0ZSB0aGUgY2hlY2sgb2YgcmV0dXJuIHZhbHVlIGZvciBhbGwgdGhlIGNhbGxlcnMu
DQoNCkFueSBzdWdnZXN0aW9uPw0KDQpUaGFua3MsDQpaaGlxaWFuZw0K
