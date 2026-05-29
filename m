Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCF2CD6E43
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 02:42:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 427CC84659;
	Fri, 29 May 2026 04:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B10CE84671; Fri, 29 May 2026 04:42:38 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20702.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DD598341A
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 04:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvZ5K6dahRiEABm35vALqepwUsRVdj4WRxj/+RyYStWxTmFTmBFQBOB7Dy6uAf4N/jZfvIU2JET/B08tuCyNazYiUo5h4MW9//4z+nMJ2clTkRS8+2Myp61LJFA6VimABggMQdvGifn6Kl3aRV6tTGwFo1NX8uJ2AfKsj8g3F/LlkfLW8rRh5Dggbjn/zJNHnRnbwIb88Q7I7eTsyjYwD4mycfT0e36XX1SAbmOfmC1pXBZ5mTP7ymB0/W5cZ8c/LEaWSgW1M/ir3XSb5CMPrhE+aFQKWVV/McZoSk9orSGWeojj/pHzlvC/v4GMB2kgArXqMV4IveFYMBgYGYaQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12JMZ4JkAn8afGiD61hcVwN8Fsqea1qmgtXhXETbwaQ=;
 b=ef80o1i//7kS4uT0ukbBTVe/BTVUGTNUi8PK6nqen9nFlxU0vSPxMxbezUgTYM/iJAG9Qt3S4ec92X5hzIMVk7HDouRn3j+HkYpUgkAmj0GvLa9ZZVhWyWZhPFeaD0cK8MhsjUkGVOmylnaDaIz+2U/TtYl3toocZpNv0JokPatbbAIM3l1/8ZhXCBKl+EFIPj+ua8wsvKmbNsp9Gkot/IiXo+sgAG7r8FGrEnvxyT9EkbEugtLgGu/REAbmqYqwGxMQLWsBf41NSjj5eLFfVSKygi19jSSN5QLF8J8fsZG/LznwiEBqKDfx9nTWnwp1aubJsX561yWuHQnqmaNRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 02:42:31 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0071.014; Fri, 29 May 2026 02:42:31 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Francois Berder <fberder@outlook.fr>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] drivers: watchdog: Fix dev_read_addr error check
Thread-Topic: [PATCH v2] drivers: watchdog: Fix dev_read_addr error check
Thread-Index: AQHc7IW9OAvKDBRWtkaO4bwsdb4Mq7YkUIow
Date: Fri, 29 May 2026 02:42:31 +0000
Message-ID: <ZQ2PR01MB13072404FBDD8AA19DA8D050E6162@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <BESP194MB28051DF5B61C4ED0C8C0F297DA0A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <BESP194MB28051DF5B61C4ED0C8C0F297DA0A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1145:EE_
x-ms-office365-filtering-correlation-id: 77c3f9d1-4f9f-42e7-97f5-08debd2bee41
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: TUULOULOVdwx73ExlMWpmFu3GbpdqSa2s7ykzdfRgPvcVsVYDWKVsD6JmtUkb05lz3vFd8rBgci5MBcdbwCCB7Np7sUsJd8Go6OVdg0ZSOlexil0HAyHGjws2sBP/auhy3JAmxl6tWqvvd41FIPPEvKS7bubd/Jx8WlnTRmt1cjmIpIr9mdtb88vTnyt1ou6OjT4CKnoQ2GYbdQN1cpdcyNHgrqUDTHYW1LwTluqUrC7AnTEmolVfNf9h4dLl0lPJuA/+Duwzd9WCd388BBm3waELfQHEaeOYAoWhnqCCduM2Dh6G5LTO15N1CeBUZBIFkP5prU9UI1xJeUdR2LMLIZaqSju58Sff3O/b9TRvLjni1zWE6HNvmwBz4eaT8Z9jLQBenuiGC7F9FeqNaRKV/Jjlg/19r0mwkQ7vkOAlJbgYnb1SJ4YLlWBZjY64bBmqPjaM/GzeWGWPoVjE/Ak4/zoIvaLdu9WJ57D4a6lTYmbb+cLswRHpD69ZbvUPXaDrLdtulZloadjRp6xjivRlOndsp2GmBqMqdUVgyvT1zRLQC7MxeeQ5N/Sh2//S1F3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1c5OUV3c2VtY09HaW5icnFwa3lHS3pDQXNaS1ltdnk2ZTJpc0EyMXJwc0JH?=
 =?utf-8?B?cG5zYjhqVjJNNGdkOE9paXBIN0F2QnVZZUtEcHo4SkdnOW11YUc1emlVUUMw?=
 =?utf-8?B?RVlxaERjemlEVktqemthL3ZKVUVHWVcvcU41VjEwTGI0bnpIa01yNnJtTXFF?=
 =?utf-8?B?ZStWdDRjWVpONHBhT3lnSkwyQmFrOHducENndEtxNGwxamVkcnFjWTFFallD?=
 =?utf-8?B?VU1GOGh4MmNBY201N1gwNDdCRXd2SkxZYi9BUUNXQmZRQklhOTRKZ2dsUDdW?=
 =?utf-8?B?K2hjbEdQT2xtTHhHYXA3ZDllWkYwV3U5VkFieFowL1dqZWN4S08vaXk5UE1N?=
 =?utf-8?B?YTF4U0tBdzVnSzhCQ2hGbkNhMHhLRUhlb3czYys3N2FhYmpzbnEwUkE1ZnJ4?=
 =?utf-8?B?OU1SazdKZnBROXBEU2hSamc2MkkrL0MwckFjU2dnSUw1UzlKV3gzbjcveENY?=
 =?utf-8?B?Ris1TXEzY1NrTUN5cC9CTzBmUGNqSGorVnBRUHdneklWTjV0bmhuWkFYTXFM?=
 =?utf-8?B?UElRQ2twcEMyRzc3Q1pJczlUSkZ1Um1ab2dyeWFGVmh0cmNQWWlRQ0swSUJS?=
 =?utf-8?B?UldwaUowNXc3M296MmIrSW8zUGdnSzZuVTJzVzdRdElRNFhLdm81S3hNRFN6?=
 =?utf-8?B?ZGtNTTQrQXhJZ1M4bUx1MDQ3azVKNndkdGRheUt2b3pLWDFYYXh5cE5UcXZs?=
 =?utf-8?B?cmV6RFhOQnlKNUliZWM1SzNZYXhHQ2h3VENibUNSQzFaYnZmSzg0ZVl0ZkRY?=
 =?utf-8?B?UGh1TEdtQS9GVk1ydkFVb1NkWWcyR0Z4czdLc3JueklxMHBSeTVhL2EwLzlV?=
 =?utf-8?B?VUNtbit4UzRRYkwxYW5HemJmU1JMZHZmcTVLbVhkb284b2dUbUNqcjZKTEdN?=
 =?utf-8?B?MUt4bExBbm1pN2ZrU21RdHVsVXB4WjQ3UDFJRHhtQ1dLVk9Na2JDZi90ckk5?=
 =?utf-8?B?UVJzajNGYkUzMGg2ZUJnYjhMNVZxQ29hN3lhajAyMVI1eXNndjJGSGtSUytD?=
 =?utf-8?B?ODRNbDlPRUlqTWpuYlhwS2FTZTNOcDZUdjhmVmJ5cjhsY1RkamNQQ1h6Unox?=
 =?utf-8?B?d2hSbktteUlvNzBDdU1DQmVabU1OLzV3N1AzbHVXTFE4bUNNS0F0M01vNUVP?=
 =?utf-8?B?bGFuVUE4akMvVElJeTU4NUNQOWRuREl6NlJuMTgvL2N6VUtodU92Tnl2dlFl?=
 =?utf-8?B?Q2RJa0dnU1NqQXZRTXJ6cjhBL0NlVUZVbm0zamdEdWhhNjhjSlBBYWRQV2Fx?=
 =?utf-8?B?Umk0bm45aFQ1dUd1TW1IWjB5ai82YWlWUHJOMlBRRkRhc1JWNU43KytkZXJU?=
 =?utf-8?B?Z1grSFBOS3h3dVFMNzJpR1NMM29UTEVGcklNaGdjbjJwcWlSZFFvTXFJanRa?=
 =?utf-8?B?b0J0c1VlcUNxS2txa21OTFlSVnRzY1JaY1V4NGFVK3ZMM0V6VDA2VHhyZkpH?=
 =?utf-8?B?NEIxR2ttbUtsRW5ZdXFmaVJFVGtObXJtVzNjUDhNOHFrY283Ylh1ZDFoSEZu?=
 =?utf-8?B?SFplSEJQU1U3QXZUclo3QTZRRDRUbmNNZGZncnNIWUNpd0lEdDlRbkp1VUZs?=
 =?utf-8?B?aEQwK1doc0JBUGdXc2Npb3VkVjFFQXduSTdyZEpjS2hYemZabXNGbnJlMTdw?=
 =?utf-8?B?OVRHTXZiTjhMYkgzMTFKMXlncGtIVWJOV2pud0hMNk9ONVVxbmh0d1o5WDJD?=
 =?utf-8?B?S3dkU2ZwVCtXNHBjUmRmUFdWcnhScXZSNDI2RFBLekdWZTRlUC9Xb0UyZ2w4?=
 =?utf-8?B?TFlzL3lINzNMZTd5bWErZ3gzUDVaMGhNUHFsYkFOci9uamMrd21ON0pMVi9X?=
 =?utf-8?B?VHQzVU9sdXJFZkdUck85UjFzUDUyenhwb0Qvbm1wUmN0VGpON2RtTzFlS1NX?=
 =?utf-8?B?SWF1RGc0ZFRjSThiaTduWWVLQlVabWRmSzNZWDg1UkFLaUtSZHBMSVFFbGs5?=
 =?utf-8?B?SDY1cDlSWHpLU3BCL0ZGcy9nRVA3TlJ5ampXV20yT2taOXlUR25tQTRHcjE5?=
 =?utf-8?B?SWY3eStmei9QZW5abmY4Q2NDL3dYR3pmMFVWbGNoeURMcmdsdi9tVC95RjZZ?=
 =?utf-8?B?UXUrN2svbW5wK3EzYklqZm5QdnU4MDJaWExuRDNqcWY5SDNUQ2VFUU1kNEY0?=
 =?utf-8?B?aVlqK2NvTFhzNEhTSTJmYXQrWm1hVDdJall5NXNveHhCYktMaXQ4S1NKTjRO?=
 =?utf-8?B?NStUejRnM2g1d05MMUN4MWVzajREWk1BSDF1T2QyMDlZRDlwUjBmNTJzNWl6?=
 =?utf-8?B?Wk14ZWg2RnBDSkd1ZUlRRzBwSkJpbWxiK3BQY1ZHTW5vNC8rcTRKUkx6bnVJ?=
 =?utf-8?B?b2RGZFZnZGVhWGhuNGJ5eENsLzZGYkNqYXNtZGpEN0NFWkhaUTUxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c3f9d1-4f9f-42e7-97f5-08debd2bee41
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 02:42:31.1623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gIeDWCY3SjTrB3BPgJehR2FeQMEvsL0eXGWqlxlOhz2lf8Q5/TmkNIaaI8jRTMd8tAw7RirJOyk+Sgg5uN2Jq/E8K6uDXvr5zGn2dnSghq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1145
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

PiBPbiAyNi4wNS4yNiAwNDozMywgRnJhbmNvaXMgQmVyZGVyIHdyb3RlOg0KPiBkZXZfcmVhZF9h
ZGRyIGRvZXMgbm90IHJldHVybiBhIHZvaWQqIGJ1dCBmZHRfYWRkcl90Lg0KPiBSZXBsYWNlIGlu
dmFsaWQgdXNhZ2Ugb2YgZGV2X3JlYWRfYWRkciBieSBkZXZfcmVhZF9hZGRyX3B0ci4NCg0KSSB0
aGluayB0aGUgYmV0dGVyIHJlYXNvbiBmb3IgdGhlIGNoYW5nZSBpcyB3aGF0IHlvdSBzYWlkIGlu
IHRoZSBvdGhlciBwYXRjaDoNCiJkZXZfcmVhZF9hZGRyIHJldHVybnMgRkRUX0FERFJfVF9OT05F
ICgtMSksIG5vdCBOVUxMLCBpbiBjYXNlIG9mIGVycm9ycy4iDQoNCkFueXdheSwNClJldmlld2Vk
LWJ5OiBIYWwgRmVuZyA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCg0KQmVzdCByZWdhcmRz
LA0KSGFsDQoNCj4gDQo+IHYyOg0KPiAgLSBSZXBsYWNlIGRldl9yZWFkX2FkZHIgYnkgZGV2X3Jl
YWRfYWRkcl9wdHINCj4gIC0gQ2hhbmdlIGVycm9yIHRvIEVJTlZBTA0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogRnJhbmNvaXMgQmVyZGVyIDxmYmVyZGVyQG91dGxvb2suZnI+DQo+IC0tLQ0KPiAgZHJp
dmVycy93YXRjaGRvZy9zdGFyZml2ZV93ZHQuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3dhdGNoZG9nL3N0YXJmaXZlX3dkdC5jIGIvZHJpdmVycy93YXRjaGRvZy9zdGFyZml2ZV93
ZHQuYw0KPiBpbmRleCBlZTllYzRjZGMzYS4uZDJjMTYxNTBmNGMgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvd2F0Y2hkb2cvc3RhcmZpdmVfd2R0LmMNCj4gKysrIGIvZHJpdmVycy93YXRjaGRvZy9z
dGFyZml2ZV93ZHQuYw0KPiBAQCAtMjkwLDkgKzI5MCw5IEBAIHN0YXRpYyBpbnQgc3RhcmZpdmVf
d2R0X29mX3RvX3BsYXQoc3RydWN0IHVkZXZpY2UgKmRldikgIHsNCj4gIAlzdHJ1Y3Qgc3RhcmZp
dmVfd2R0X3ByaXYgKndkdCA9IGRldl9nZXRfcHJpdihkZXYpOw0KPiANCj4gLQl3ZHQtPmJhc2Ug
PSAodm9pZCAqKWRldl9yZWFkX2FkZHIoZGV2KTsNCj4gKwl3ZHQtPmJhc2UgPSBkZXZfcmVhZF9h
ZGRyX3B0cihkZXYpOw0KPiAgCWlmICghd2R0LT5iYXNlKQ0KPiAtCQlyZXR1cm4gLUVOT0RFVjsN
Cj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiAgCXdkdC0+YXBiX2NsayA9IGRldm1fY2xrX2dl
dChkZXYsICJhcGIiKTsNCj4gIAlpZiAoSVNfRVJSKHdkdC0+YXBiX2NsaykpDQo+IC0tDQo+IDIu
NDMuMA0K
