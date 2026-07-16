Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8300C4450A
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 09:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBE2384C8E;
	Thu, 16 Jul 2026 11:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="OTtPOlMn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA30384C9E; Thu, 16 Jul 2026 11:43:52 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B004884AA8
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 11:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsutFCIC1rdSt+KNquPmj+Xtts4EVbVQlNYD0jylZQnJr+tQ5uwRzwDOJlDp3oB4NVkoKjiRmIv5+d2YfZDBWUsMDfyTYOlz96K4R2K7D/vfQ2Cx6RvCmXhRbD7DBqIWiNsBT64mwgM9ASEbBLD33RzcQQCvP6hJncv92IX1IN7xoEuxR4wZRSVHv86w5tGELTHn/KnuUN7uM2xt4n8iuixWtfEUrlbYmxOzvu1vKkuDUn560fcBC80PMauaU8PXmvJmaDxgPUuwMLGGVAwd5YLC+0x0+fBHgb48/FHExXOfLUf92Lzhx3roO2Gbgl0kpQa530PHih+Sjp9brOXy8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHL8cV272Hmau6tbTx7UDw2UyPPfGdd0V3wy5+bN/9U=;
 b=g37xfgnBf+kmhsHpFW0H53xFf9jS9QVuFY8m9/vWQcSIzgchefMUHaLGsNo0LIKMjFoZAt9+iXbiNLtjmrfQ9FpctM/+PvRjUEeSHCGtkBzE/hFHcgzX72FyZJUZjTt6O4DqB0HeVYuTAwPUQc3a7VcZai9RxVDB9MbIct9kwq6NOl2lB2vdbXwWaTP12bfv3jGOhZjJShExFF3FZqnzst+cdP7u3M0eTGaT/BVSUGgzsMzORMuKql3Ug5SqZIEO9yrcWNfUxYTEIA5qAlDo6TKuhWKzDBwf3LCfdwSzXF9gQsjn93vAae/8igI9WB+oSxQ3yzFl58eY2m9KwWCs+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHL8cV272Hmau6tbTx7UDw2UyPPfGdd0V3wy5+bN/9U=;
 b=OTtPOlMn8I18RIZME5NQ7lWcc4wtLNkBJedRYM0Q79cMoVQsFok5eZz+O+cXtxP5B5URef1eFkXUFA0ixIyZmssCzVmAkhu2h+YYW7g71g5+Vhm0gMjqbagOCXRuzbTR6tAf/V2HrbKuZUUeU3YlhFxEbV0kdVP8nTGETr/4WOaUT/m/wRL1POFuUyJaBO5BOmP6q6ghBdkCBMjSsevQZmUU8x5tehGioMKe8CT8jgHmML0geSlNzgHt3mH3rMYzLj+k+rz6iYLWlQpIoNWwHdpHsNWlKb9QcEbbPOp8pawULZzF1Ow71OBwwbKLu5uCGfHeh63Kg1k+wLzFL9RPpw==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by PRAP195MB1601.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:298::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 09:43:47 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7%4]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 09:43:46 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: INgo Rah <ingo.rah@linutronix.de>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>, "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Teresa Remmet <T.Remmet@phytec.de>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Benjamin Hahn <B.Hahn@phytec.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, Peng Fan
 <peng.fan@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, Gregor
 Herburger <gregor.herburger@linutronix.de>, Benedikt Spranger
 <b.spranger@linutronix.de>
Subject: Re: [PATCH v2 1/2] board: phycore_imx8mm: update RAM timings
Thread-Topic: [PATCH v2 1/2] board: phycore_imx8mm: update RAM timings
Thread-Index: AQHdD7Alhb5dIHG8uE6I1rdS+wzgkLZv79AA
Date: Thu, 16 Jul 2026 09:43:46 +0000
Message-ID: <0dbc2fd7b850eda92b59e6a1251937ee7e81a955.camel@phytec.de>
References: <20260709-ram_phygate-v2-0-36f8a2f44de2@linutronix.de>
 <20260709-ram_phygate-v2-1-36f8a2f44de2@linutronix.de>
In-Reply-To: <20260709-ram_phygate-v2-1-36f8a2f44de2@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|PRAP195MB1601:EE_
x-ms-office365-filtering-correlation-id: 052e053f-f0f5-4df7-18dc-08dee31ebb72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: wuPSRxLn9bDg2Foa9SwBfr50C33+YDBKsdbjAzHGwS4OFpbQUJ+7OL8pq0/gSirHOCd6ewUVRMAdQL4f1IvqZHksUiLWLO7IgOgQZqmuaNFQ9/X3yx1vhxZCThhRmEUgPPPNff/zUPMLoEDgMrckVYDcxHBiyo0EfO3q8KimIFw4Lcxtfanydvlkkw/8m172H/zKNhOfZj76CK1KEisf37HZGOSehD/V8pi8GZoUNfOmfOxwyVQxEoJGavNYpPMBPHcXm/dblYQrCUvs0kVgVGne9+n0FYuUPUXdAsMvY7Eq78A7W7xG6T4bWk+WpwMjafCVVhBoEDlYSBGe912fd+MrDXiS3tGdfg1V8B/EJX4qSn3rj1iV4upmCM4cQgHLKhW5/7EgP6kMunYzcCie8L0SPB5/EG3efoyZsHc02zt+C2yVgQIKtj8uUP75ZDof05rDvubROUrCbV96WG66TaCZcVZTiSCi14tiyA95F1XGP7XHOCs3W7i8FQfu1vo0pDkInTVvfiQ4SQUNAACObHX0bZ9OndWUT1ZrAx75rgDGYVCxYa3klWDtdEbJUA6rOP0E1FtovJvbCdf8hXFI9/HeezKShTiji0O5dmdyS0CvNq1h7vEZ06/kJ2+t1+yC2xJjXTSipsGY+PmHVHixmpRzdItGRRbNZRerfVzc+7h2L/beVbXBci0NnWpyfqJ3j3A5VGevnBVR4g797VxM640PHNdshfEIich/bBNmGHg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmYzcTRKS1V1MnVmR0VhNmdXbmZjTVMydDVFNy9KSGhLK0psVHZ2cjZRRy9P?=
 =?utf-8?B?RGhjcXdnazlpTFdDM0JKVlhpc2IvYkc5SzhWQ2xseUphNzVhRlhES3RZK0Nt?=
 =?utf-8?B?Z2pBSHJRZ2w4YTFZT1VQelNxcVBEZWt4R0RHQ2JCYmZoM2hLNWpmVXdidXFJ?=
 =?utf-8?B?VzVydWpKbUQ2TGNnVDJsdWJaUXpML25vcmRTQUlzNHFoQkNpZzhjb3hyWFRi?=
 =?utf-8?B?T2lkTzlocXkrd2pKa24zSjd1UENyTkdMVk9TTnFOME9lMFRyN1V1UGpsdVlE?=
 =?utf-8?B?MkxpazF5c1l0dFpEZWpJOXMyNkJLMXpmM0w1QXkrM2hkZTFoeHh1MG1LeFhn?=
 =?utf-8?B?c3J5L2FqVFRjVVA2UW5jbVViaWFGU0xJb01WOHczSVNEMlpCNk1Hdk1FdHpv?=
 =?utf-8?B?NzlyL3pFUGZiSVMzT0NJSjcxZjlsVkZwUEI5S1dLVUFBcjZqeUJkYkQ3MjZD?=
 =?utf-8?B?dklyejdNSndtVXhKVzdrTUdqaUJ0MUpDUzNpRi9VS09weGdFdVZwMmkrOWFV?=
 =?utf-8?B?Vks4Z3FqUU5ITTNEVDZuSHY3MklNbllDVWpmSHJHYmd0RFhqRlRZKzcwZ1ln?=
 =?utf-8?B?MEdUd0d6b2dHWUJERnkrcmR1S1ZEcHRtaWZHdE9FcXdkZGdsR0E1UjFVdk5G?=
 =?utf-8?B?Y3Q1aFVnSnh3VjVuc2pNMzRrVnJ6RS9sMmVvVDhVNTdLWE94Z2lYeCsyQzA1?=
 =?utf-8?B?RGhsaWl3V2lGSU5nK0VGakcyRVFrMHZhWHZJRE9GL08rK0FXcmM3SHNpUzMr?=
 =?utf-8?B?bTk4NnJRK3R5andyeDdqaGJvRzNwK0VXQVlkYzI5SXo4aDM1Y3NVa1NtSTdw?=
 =?utf-8?B?SXRBNUFrZXluWURiYVJONFNERFh4VXFFcGhDZElBU0J3OUtoSTB5VnFhUEFO?=
 =?utf-8?B?ZmdIU0pkNG1Vd0JJZUNsbEhwT2M2elNlczJiZjJOdVBwZ2dVY1EreUhJQVJz?=
 =?utf-8?B?UHV6eGlsRDJJK0pqakJFd01QR1RyVDQzdTlpV0d3aUFOWTdvZHJHSXE3ZExl?=
 =?utf-8?B?MDMxcDNibGJqVFVteVVoNnVDT0tiUkZCNm5UTElkWEgrODJrNFN1SmdDMVFl?=
 =?utf-8?B?YXoyaFgvZndLS2xJSUZJTUlKZDRHQmtlZlFDQTcxL3haU05QTFB0WlptblRQ?=
 =?utf-8?B?cHdNOWFPdTFVa2wzUHY0UmZiNmg5My92ZnNrcmxaSWMvWXloMEZYdUlvSHdT?=
 =?utf-8?B?bE52S1RVRDdXN0Y1Mzl4OTFrMy8wa0tSWU9ZMjdBbFBmTnhtSGVNSnZkb1E4?=
 =?utf-8?B?UUtLbmJCbTlGYkc1ai84Q0luc1FmS1E4ZTlpUGFHNG1HWjljN1RQWWN2VXJE?=
 =?utf-8?B?dkpwVEZ0QVBMbDloVy9mOG5ycUZOcVp2V1Y4cDdUMDZ5K1ZwV1hKMnFkWVd2?=
 =?utf-8?B?alpDK25iWndBZFFzcVowVCtLN0dyK1BGTm52YTdwejZxUXd3d3hMSU5wVElv?=
 =?utf-8?B?MDFHMkt0SnN6ZWgxUGFadHU5K3MwZ0xEZkNhYUlXdmh5QlorajI2SkdkSWNO?=
 =?utf-8?B?TWYwY2p6dzRyckdFUHZiYkZ1TmQzdzl1MUZ2MkF2eDlmSUFhQUNSWGN5Qkli?=
 =?utf-8?B?TGxGeGJXUzhXNllYY3d6Smp4YWZmVkJFZG5OV29Cb2hGalBKdmNHWkpTTkcz?=
 =?utf-8?B?MWZkU3J4UUJZNWM5T2hyWlYwQ0VuTmd2U2RjTkIwSWo0VmoyWDgrREpEdFd5?=
 =?utf-8?B?RVdOOEZiQVhUMksrdWxjdFdCUXh3TXdnK0hNM2tTOXVmamZjVEdEUUVRcFNJ?=
 =?utf-8?B?NVJnWmdqcXlYUFZqaDZsbCthWU5JNk9ibU1zZ0x6cVdFQ2M5MFpRTER0VUpL?=
 =?utf-8?B?YXBMRkVKaE45UHR2VHhlbmcydTVSVEtzTE11dnE1OFYxbzNpL3pheXFuckNS?=
 =?utf-8?B?MkdqSllrT2NCZXZqSllFVmNWSWliZzdmNFR6VVo4UW9BdWFLcVpUNTYxU3VK?=
 =?utf-8?B?Ukx5NVl6anRzM1ZiQUovUWZ3V0txbnVac3NFV3I1QnlRSEs4clVRQzgrYXIr?=
 =?utf-8?B?akZrUWRYL21SMjNUclZ4SEhpZE1UOHNSYXRCTXRjRkp3RkNxYXRoMU9qZUhu?=
 =?utf-8?B?ZjZnMW0xVG9HN04wbE9iajQ0T2o5WnNGVXIwVXpOUjJodE9MNklrdVNmSzIw?=
 =?utf-8?B?cGVHTVMyTnFqU3RLbTlRZ1FYM3dIRUVHbzBwUW1HSzhvL05iZjR2eVRNUkln?=
 =?utf-8?B?MktaeTVrMkFKQ2tiRjNtNXZJN3hFdnBQazc0dzZKaC91RTQ2UTdXMmQ4REZK?=
 =?utf-8?B?VG83c0tWdlRGRk1BbzJjUFlyVUEyK0R2VG9yTUNUY0VweEswNjZKd3J0R0RT?=
 =?utf-8?Q?kkKZYCGtIVunEjcc3s?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAE015814BBA014C9D92276B4BD49F0B@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 052e053f-f0f5-4df7-18dc-08dee31ebb72
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 09:43:46.6445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Os6utjhAy0EY3+XF5AU89LT21G0z9S9I/32ehuyGixIoOh56/3X7xuTVGveM+5Z+CDB4o18AUEBVS9m0MwireA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP195MB1601
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

SGkgSU5nbywKCk9uIFRodSwgMjAyNi0wNy0wOSBhdCAxNjozNCArMDIwMCwgSU5nbyBSYWggd3Jv
dGU6Cj4gVXBkYXRlZCBSQU0gdGltaW5ncyB3aXRoIG5ldyBnZW5lcmF0ZWQgc2V0dGluZ3MgdXNp
bmcKPiBERFIgVG9vbCB2My42LjBfMjItYWEwMTg1NDMuCj4gUHJvdmlkZSBmdW5jdGlvbnMgZm9y
IDFHQiwgNEdCIGFuZCByZXZpc2lvbiA3IHZhcmlhbnRzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IElO
Z28gUmFoIDxpbmdvLnJhaEBsaW51dHJvbml4LmRlPgo+IFJldmlld2VkLWJ5OiBHcmVnb3IgSGVy
YnVyZ2VyIDxncmVnb3IuaGVyYnVyZ2VyQGxpbnV0cm9uaXguZGU+Cj4gUmV2aWV3ZWQtYnk6IEJl
bmVkaWt0IFNwcmFuZ2VyIDxiLnNwcmFuZ2VyQGxpbnV0cm9uaXguZGU+Cj4gLS0tCj4gwqBib2Fy
ZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vbHBkZHI0X3RpbWluZy5jIHwgMTg2NyArKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0KPiDCoGJvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtbS9scGRkcjRf
dGltaW5nLmggfMKgwqAgMTMgKwo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA5MjEgaW5zZXJ0aW9ucygr
KSwgOTU5IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9ib2FyZC9waHl0ZWMvcGh5Y29y
ZV9pbXg4bW0vbHBkZHI0X3RpbWluZy5jCj4gYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0v
bHBkZHI0X3RpbWluZy5jCj4gaW5kZXggZjVhMmYzMjY4YjMuLjE2MmIwMjA5ZDkyIDEwMDY0NAo+
IC0tLSBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtbS9scGRkcjRfdGltaW5nLmMKPiArKysg
Yi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vbHBkZHI0X3RpbWluZy5jCj4gQEAgLTEsMTYg
KzEsMTcgQEAKPiDCoC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVy
Cj4gwqAvKgo+IC0gKiBDb3B5cmlnaHQgMjAxOSBOWFAKPiAtICogQ29weXJpZ2h0IChDKSAyMDIz
IFBIWVRFQyBNZXNzdGVjaG5payBHbWJICj4gKyAqIENvcHlyaWdodCAyMDI1IE5YUAo+ICsgKiBD
b3B5cmlnaHQgMjAyNSBQSFlURUMgTWVzc3RlY2huaWsgR21iSAo+IMKgICoKPiAtICogR2VuZXJh
dGVkIGNvZGUgZnJvbSBNWDhNX0REUl90b29sCj4gKyAqIENvZGUgcGFydGlhbGx5IGdlbmVyYXRl
ZCB3aXRoIEREUiBUb29sIHYzLjYuMF8yMi1hYTAxODU0My4KPiArICogRERSIFBIWSBGVzIwMTcu
MDkKPiDCoCAqLwo+IMKgCj4gwqAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+Cj4gwqAjaW5jbHVk
ZSA8YXNtL2FyY2gvZGRyLmg+Cj4gwqAKPiAKClsuLi5dCgo+ICsKPiArdm9pZCBzZXRfZHJhbV90
aW1pbmdzXzFnYih2b2lkKQo+ICt7Cj4gKwlkcmFtX3RpbWluZy5kZHJjX2NmZ1s1XS52YWwgPSAw
eDJkMDA4NzsKPiArCWRyYW1fdGltaW5nLmRkcmNfY2ZnWzIxXS52YWwgPSAweDhkOwo+ICsJZHJh
bV90aW1pbmcuZGRyY19jZmdbNDJdLnZhbCA9IDB4ZjA3MDcwNzsKPiArfQo+ICsKPiArdm9pZCBz
ZXRfZHJhbV90aW1pbmdzXzRnYih2b2lkKQo+ICt7Cj4gKwlkcmFtX3RpbWluZy5kZHJjX2NmZ1sy
XS52YWwgPSAweGEzMDgwMDIwOwo+ICsJZHJhbV90aW1pbmcuZGRyY19jZmdbMzddLnZhbCA9IDB4
MTc7Cj4gKwlkcmFtX3RpbWluZy5mc3BfbXNnWzBdLmZzcF9jZmdbOF0udmFsID0gMHgzMTA7Cj4g
KwlkcmFtX3RpbWluZy5mc3BfbXNnWzBdLmZzcF9jZmdbMjBdLnZhbCA9IDB4MzsKPiArCWRyYW1f
dGltaW5nLmZzcF9tc2dbMV0uZnNwX2NmZ1sxMV0udmFsID0gMHgzMTA7Cj4gKwlkcmFtX3RpbWlu
Zy5mc3BfbXNnWzFdLmZzcF9jZmdbMjNdLnZhbCA9IDB4MzsKPiArfQoKSSB0aGluayB0aGVyZSBp
cyBhbiBlcnJvciBpbiB0aGUgNGdiIHRpbWluZ3MuIEF0IGxlYXN0IHdoZW4gSSB1c2UgdGhlIHRp
bWluZyB2YWx1ZXMgeW91IHJlZmVyZW5jZWQKaW4geW91ciBjb3ZlciBsZXR0ZXIgKGNvbW1pdCAw
MGFjNzY1ZDYwMzIpLCA0R0IgUkFNIHZhcmlhbnQgZG9lcyBib290IGNvcnJlY3RseS4gV2l0aCB0
aGVzZSB0aW1pbmcKdmFsdWVzLCBpdCBkb2VzIG5vdC4KCkFsc28sIGZvciBlYXNpZXIgdHJvdWJs
ZXNob290aW5nIChpLmUuIGJpc2VjdCksIEkgc3VnZ2VzdCB0byBmaXJzdCBhZGQgMUdCIGFuZCA0
R0Igc3VwcG9ydCBhbmQKYWZ0ZXIgdGhhdCBjcmVhdGUgYW5vdGhlciBjb21taXQgdGhhdCB1cGRh
dGVzIHRoZSB0aW1pbmdzLgoKWWFubmljCgo+ICsKPiArdm9pZCBzZXRfZHJhbV90aW1pbmdzX3Jl
djcodm9pZCkKPiArewo+ICsJZHJhbV90aW1pbmcuZGRyY19jZmdbMTBdLnZhbCA9IDB4NTUwMDRk
Owo+ICsJZHJhbV90aW1pbmcuZGRycGh5X2NmZ1s2NF0udmFsID0gMHg2MTg7Cj4gKwlkcmFtX3Rp
bWluZy5kZHJwaHlfY2ZnWzY1XS52YWwgPSAweDYxODsKPiArCWRyYW1fdGltaW5nLmRkcnBoeV9j
ZmdbNjZdLnZhbCA9IDB4NjE4Owo+ICsJZHJhbV90aW1pbmcuZGRycGh5X2NmZ1s2N10udmFsID0g
MHg2MTg7Cj4gKwlkcmFtX3RpbWluZy5kZHJwaHlfY2ZnWzY4XS52YWwgPSAweDYxODsKPiArCWRy
YW1fdGltaW5nLmRkcnBoeV9jZmdbNjldLnZhbCA9IDB4NjE4Owo+ICsJZHJhbV90aW1pbmcuZGRy
cGh5X2NmZ1s3MF0udmFsID0gMHg2MTg7Cj4gKwlkcmFtX3RpbWluZy5kZHJwaHlfY2ZnWzcxXS52
YWwgPSAweDYxODsKPiArCWRyYW1fdGltaW5nLmRkcnBoeV9jZmdbNzJdLnZhbCA9IDB4NjM7Cj4g
KwlkcmFtX3RpbWluZy5kZHJwaHlfY2ZnWzczXS52YWwgPSAweDYzOwo+ICsJZHJhbV90aW1pbmcu
ZGRycGh5X2NmZ1s3NF0udmFsID0gMHg2MzsKPiArCWRyYW1fdGltaW5nLmRkcnBoeV9jZmdbNzVd
LnZhbCA9IDB4NjM7Cj4gKwlkcmFtX3RpbWluZy5kZHJwaHlfY2ZnWzc2XS52YWwgPSAweDYzOwo+
ICsJZHJhbV90aW1pbmcuZGRycGh5X2NmZ1s3N10udmFsID0gMHg2MzsKPiArCWRyYW1fdGltaW5n
LmRkcnBoeV9jZmdbNzhdLnZhbCA9IDB4NjM7Cj4gKwlkcmFtX3RpbWluZy5kZHJwaHlfY2ZnWzc5
XS52YWwgPSAweDYzOwo+ICsJZHJhbV90aW1pbmcuZGRycGh5X2NmZ1s4MF0udmFsID0gMHg2MzsK
PiArCWRyYW1fdGltaW5nLmRkcnBoeV9jZmdbODFdLnZhbCA9IDB4NjM7Cj4gKwlkcmFtX3RpbWlu
Zy5mc3BfbXNnWzBdLmZzcF9jZmdbM10udmFsID0gMHgzYzMwOwo+ICsJZHJhbV90aW1pbmcuZnNw
X21zZ1swXS5mc3BfY2ZnWzExXS52YWwgPSAweDRkNTU7Cj4gKwlkcmFtX3RpbWluZy5mc3BfbXNn
WzBdLmZzcF9jZmdbMTZdLnZhbCA9IDB4NGQ1NTsKPiArCWRyYW1fdGltaW5nLmZzcF9tc2dbMF0u
ZnNwX2NmZ1syM10udmFsID0gMHg1NTAwOwo+ICsJZHJhbV90aW1pbmcuZnNwX21zZ1swXS5mc3Bf
Y2ZnWzI5XS52YWwgPSAweDU1MDA7Cj4gKwlkcmFtX3RpbWluZy5mc3BfbXNnWzFdLmZzcF9jZmdb
M10udmFsID0gMHgzYzMwOwo+ICsJZHJhbV90aW1pbmcuZnNwX21zZ1sxXS5mc3BfY2ZnWzE0XS52
YWwgPSAweDRkNTU7Cj4gKwlkcmFtX3RpbWluZy5mc3BfbXNnWzFdLmZzcF9jZmdbMTldLnZhbCA9
IDB4NGQ1NTsKPiArCWRyYW1fdGltaW5nLmZzcF9tc2dbMV0uZnNwX2NmZ1syNl0udmFsID0gMHg1
NTAwOwo+ICsJZHJhbV90aW1pbmcuZnNwX21zZ1sxXS5mc3BfY2ZnWzMyXS52YWwgPSAweDU1MDA7
Cj4gK30KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1tL2xwZGRyNF90
aW1pbmcuaAo+IGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1tL2xwZGRyNF90aW1pbmcuaAo+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAwMDAuLjM0MGZlZmUwMWMzCj4g
LS0tIC9kZXYvbnVsbAo+ICsrKyBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtbS9scGRkcjRf
dGltaW5nLmgKPiBAQCAtMCwwICsxLDEzIEBACj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9yLWxhdGVyICovCj4gKy8qCj4gKyAqIENvcHlyaWdodCAoQykgMjAyNSBQSFlU
RUMgTWVzc3RlY2huaWsgR21iSAo+ICsgKi8KPiArCj4gKyNpZm5kZWYgX19MUEREUjRfVElNSU5H
X0hfXwo+ICsjZGVmaW5lIF9fTFBERFI0X1RJTUlOR19IX18KPiArCj4gK3ZvaWQgc2V0X2RyYW1f
dGltaW5nc18xZ2Iodm9pZCk7Cj4gK3ZvaWQgc2V0X2RyYW1fdGltaW5nc180Z2Iodm9pZCk7Cj4g
K3ZvaWQgc2V0X2RyYW1fdGltaW5nc19yZXY3KHZvaWQpOwo+ICsKPiArI2VuZGlmIC8qIF9fTFBE
RFI0X1RJTUlOR19IX18gKi8K
