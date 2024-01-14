Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E08FC4707B
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 09:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A8F887707;
	Sun, 14 Jan 2024 10:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="NLZw1M+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2256287763; Sun, 14 Jan 2024 10:47:36 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 962388743A
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 10:47:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfjBNojF4p2c1ufw/b/W1HyTRhM3ksoTBE4XiU7dg4ky5bp1zyLlCoeMlnSuK1ym9d9Sj+4Hhr7NKPXrdYmp2KATP2qGbCXOnTek0pK6i2DSuMrIuq1GxCUahUbY+mIVZAA09/nta0PQmJuIqW211xBe6TZsebTIZu4idh0w1unpDENKnKiY4xm44CJKwGbFc6uARXBB+XL+6e8FP07Mju5Bhpe9LA8YPmbMC3SajDVgC0WTFynRUqpWF8n2ddw2e9WmtpkbboryiKOvDpodB+GVqROd5ldoM2EAN8bRsFlG2+25dTa9ndY0ZRWCPhK8cQyTvigF1y85WdbKN8Kn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMDsvb+yhP/+k7bXhFe0QpTuvzaI1MSuQbBI5uOiOFE=;
 b=IJvfT5xTT9QJ5PDH+i+/Mno+Quf06GAaH1yTo8PEmcuMjNX4i7zA1iZl5qsFY0m4Em/bUvmlpXS3F/JR+ZYeO25czQIqGxIzLtcJ9VdJOWKTz/Ff9fUAqGNw97AEllNu1Clm22Nloezb7LEvmZHWPcP9I4o+QwnZjXkVLSO60LIhQMxeUOcXbtituLLQqY6CPH1MgCuaihSHc9b2WlsNLeacDxwlUHHCOdxtWaV1rVkjAQQlYDuEl62XmTlRcH3aGmi+bYu/vg3N6hgtxmQIFFDp3KPKLEMHffLmwcM4cCCPDdKMs+YScGfRuzo36sIWJQCP2ia5ff68Ga2zubIskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMDsvb+yhP/+k7bXhFe0QpTuvzaI1MSuQbBI5uOiOFE=;
 b=NLZw1M+71QXy7vAzCtmpDK4A5TAcuP4ZRy94JSAjvNT8DOQ4cXukmRytFccaRo4Yidqt72aCETDaekq1DGmBHk9dI1Pra140leMc3MsQvvNG98jfBjh5uxuDaIvqY6KS3nkO52XoYwdpBc7FRk9O8L+pBnaL+n/w9bTa2HOSIiY=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DBAPR04MB7334.eurprd04.prod.outlook.com (2603:10a6:10:1aa::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Sun, 14 Jan
 2024 09:47:31 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Sun, 14 Jan 2024
 09:47:31 +0000
From: Josua Mayer <josua@solid-run.com>
To: Tom Rini <trini@konsulko.com>
CC: Dennis Gilmore <dgilmore@redhat.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/3] arm: mvebu: helios-4: add defconfig for spi booting
Thread-Topic: [PATCH 3/3] arm: mvebu: helios-4: add defconfig for spi booting
Thread-Index: AQHaRj7DNa2xbuM1UkuvtQ0LZOuCHLDX/bYAgAETLoA=
Date: Sun, 14 Jan 2024 09:47:31 +0000
Message-ID: <a28684d7-46e7-46d8-9018-4857de07a3c2@solid-run.com>
References: <20240113-helios4-spi-v1-0-2a5663a10e6a@solid-run.com>
 <20240113-helios4-spi-v1-3-2a5663a10e6a@solid-run.com>
 <20240113172236.GI1610741@bill-the-cat>
In-Reply-To: <20240113172236.GI1610741@bill-the-cat>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|DBAPR04MB7334:EE_
x-ms-office365-filtering-correlation-id: 3ea4e0dd-89da-467f-74c0-08dc14e5d403
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dq53rpC8m7tuSVhlRtjwdihzID0hFGn3hjEVJA4TMte7n/TJExpqGgWHvfAs5kNTnRLvTbzrRYo0DI2kWOB8bh3uiS7/Mj8b0DoqL12k4xOtkTogfP6+LjhG6B8H7uLZ+PpMUMQQQ8AZrBisVT3AZMVqq1vvmlswSbkjTox7bW6wa1YBdjqDcSJo4udeHY09IDEyDrPcnuLxULNe/YyjQBan2B+MBEJOjq8fhShJjowTMR1KO7AHbsQ5wvKT0CBsKlI7xHM6BIEqveiSwE1ewkhqWEYe4Yp+bTujiF96PESNPPrUccOtLYmlVuE2JLmYZKGy9YP0YH7s15ws/CA1M0qA13SzfYsHNvLhNDYsnFjHp2QFEy1De1VD9STCLglOL+hwWCg2vz3GvmqdG01QEAjjhx1UHC8QwzXAde88ZKmOnUgLieBmZDtmarmXYyD7RBFb6OZed8GoSzP9jxv+3Ikp211M7VB/0clEOtnobTB8/sfl1Xdr96YPSfMFPxHp9Kb+0CxH0u55qXl+UFMYABcMlnaBaM3MIaQU3MmZhc09H+iqIg7LEac1CQr3A1Ch/z9aZWnEu6FjVX9CwY327mfvFaJRNZe3fJf4lggSUcRRyu/J2o0cOOPFX8cjbDO2T9rTRo8ow7Ur5cZLLRlzEA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39830400003)(366004)(376002)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6506007)(71200400001)(2616005)(316002)(6512007)(76116006)(54906003)(91956017)(66946007)(64756008)(66446008)(66476007)(66556008)(966005)(478600001)(6486002)(6916009)(26005)(41300700001)(5660300002)(2906002)(8676002)(8936002)(4326008)(36756003)(38100700002)(122000001)(38070700009)(86362001)(31696002)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVE0SDdkaXgxUzAzeFJRK2ZKOGZYS0diQ2V4ZlJmdjhqZWhqK3BSMHJ1Qmox?=
 =?utf-8?B?NlNUMWZZY1pZcHpwODBDbzBIN01ZakxyeFJUWkdNcGNGOSs5UnlnQ2czUmdK?=
 =?utf-8?B?Zk1GTnVRTWFRS3NOYVk2YXpOSFM4OHRmU0RhV1ZRM0IrQVZIQm9lRmZzUCtl?=
 =?utf-8?B?WGRxbE1QQlQvcUZsTTY4Z1hQUDZ5V2FweEFYSGQrYW5WMjIzdVp5LzYwaVM0?=
 =?utf-8?B?VXdWMEtlMldXcVQ5UElUc1BzWHdOeUFVMEdVM2N1Y3dpdmovaFluU3JnalNn?=
 =?utf-8?B?UnpDL1dDTFhqZnUrTTI1Y2lWaUZNc21oTUQ1UVpweXI4T3pYNk9BYTRwWTho?=
 =?utf-8?B?OHhuUDBtVTNlTml4QmFTR1NjLzBoeHIwSmlGV2tKa281dmU1czVXdlZybkxU?=
 =?utf-8?B?N0VpaWhrdE9kTFVvOGRiQ3ZsWkZRdE1iekcyUGNUajNXVTFlRlYreWlLOW1q?=
 =?utf-8?B?NUxjTm5vci8wRnlIRWJaM09XUnh6S09yaHFaSXliclU5VTVQcjVIZkZUMHhy?=
 =?utf-8?B?UXp3WnoyV0xPdnpTbE9CYXNBaGNlYXVqbndKTWNGakFIL3E0cUgwR1h2cSs2?=
 =?utf-8?B?TmxKSmFScTVYVVlNRmxySndvWkZYeFRXbWh0Ni9jSHRyTmlPOFZ4d2U2c3BF?=
 =?utf-8?B?NzJGWmRYYjR6Q1FBOTM3YVMzV05jeG1tdEE4M0pIVkZ0WEZCdkNZamxrZVBo?=
 =?utf-8?B?YThiSUduL0hWRGtVb01oeklGV0hxOXRMRmcyNGxkQUtCZmhCRzFRWWVuTUY3?=
 =?utf-8?B?cEFjYUJxYlBWaXpZTnJGVXZtcTVVeUVMK2ZOQTVYYXlGUStPOFpDdUFhT2ZV?=
 =?utf-8?B?a3FHNlhHWDlVaUYyTnVKTlF0VGZtc2E3cm8wZEVlV25SN2syVWxrZERnNTBK?=
 =?utf-8?B?K1hJVjBLd3VPa0JMdW83R2owcWsxa1BPUmNJYVhVYUtDOFdwVmIyNGNVcWEx?=
 =?utf-8?B?cHlSdXZaNWZkcCtmQ0xESDgyS3VpUGxMd1BCNzk4Qjh3Q2taQURBUmFiTkhC?=
 =?utf-8?B?YktNRnk4S1ZhK0tCcFZBR1pqQUJKTEluS1IzcjNnbnQ1VXBnK0NQNUw0K0Zi?=
 =?utf-8?B?MVU0QVFjc1dEa2NlU2tzcEY5ZVdCR2drbm9URXhMSjhrY05rY1BqYkF2VUsz?=
 =?utf-8?B?VExSUGFrT1VqK3NBVVVsNFBrdHN2cnBFNm1adWFVNVB6RnQ0UDdHNy91V095?=
 =?utf-8?B?VTBIT2xHczFNSldoODZtWnovaU5jSkNkNjFaQVNxTGxVWjlINW8veWF1eHlz?=
 =?utf-8?B?T1VCcjRTOXlOZHNGVWxvd1p0blZPOVFHWnV4K3VGYXJMNHlzRHV6bjYvYVV6?=
 =?utf-8?B?RkRKNGxKTzJPemM0ZVViOGJKZXJ4MkpUOHZrV1RuRVZjckJFYmh0S2ErUUxV?=
 =?utf-8?B?dWY0cjJKNWhNekF1MlJVS1ZBTVhDSzJYZDJ2L0tJV05weGt3R3l4WTVKUDVi?=
 =?utf-8?B?Y0Y4TjFwNTIxTmV4U0ZQaVp5Z2ppNGplbkgxenVBSFRWblc4WXhlOG5yODQz?=
 =?utf-8?B?VmhQVWdDUXJUMWtVOW05NlNaaVlkekQ5cUdTOFRRSmtOeDRSUUw3SkNzSlhX?=
 =?utf-8?B?cmI4aWpDVU9jK3ZRVFozVHN1TUgwWUF3RFVMSzdGOTN2bkZqcy8rbi9RWkFs?=
 =?utf-8?B?b1cxZGNUK1cxcE5BVEJ0TXJzQks1QzFDdG5Id1d5a2dtZW4zVWx3eWpoc1ZV?=
 =?utf-8?B?TUJYbjlRc3phOUpGUzFmc2s0c0tReHQvSktHOGptVDNUSWd6VnFGeWxiVCt2?=
 =?utf-8?B?TGhsMXdNY2Rwa00yb1VVa2Y0L25pOVBIdkd4dHJDUHZnL2lTdWtmNm5DL0RX?=
 =?utf-8?B?OE9iMVdaK0lNb3Zrb3hGNTl4NnJMZ0Mxbm1JdmtDNXVvS2g1NlQ1WjBOdUhH?=
 =?utf-8?B?cUdKZk84WVFhZVVGZzk2MU9pMVZoajRwNjV1NkRNcnFXeFJIWGRFM3dSMFBZ?=
 =?utf-8?B?R3JoRVlZTCtGYk9zOEx2alR4ZnJYV0FIcXVLc2JPQWJUUVN6RGlLejVBN0Fi?=
 =?utf-8?B?d1RiU09BcnZOWGRaZUNZMnU5eFRPTmVtaFJRT0JqVXdGZ2ZMKzBSZ2dta1Rv?=
 =?utf-8?B?VEhtdGR0MENEWnk5RmE1ZUJzRFhkeVNTbnBlN3IrRFZDbTQyclAxNlRGUmdo?=
 =?utf-8?Q?Ochk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6295A20C118DBF4DB0D309642B6BFAB3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea4e0dd-89da-467f-74c0-08dc14e5d403
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2024 09:47:31.6779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kSJdgSCTm/UDerVplnZp58U+PFoS9e/Rytz3SMMua3OT0kyxSatvfyGMg2/yLFgCkDfCcXxQrqsLZIkvsSJthg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7334
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

SGkgVGltLA0KDQpBbSAxMy4wMS4yNCB1bSAxODoyMiBzY2hyaWViIFRvbSBSaW5pOg0KPiBPbiBT
YXQsIEphbiAxMywgMjAyNCBhdCAwNTozNjo1N1BNICswMTAwLCBKb3N1YSBNYXllciB3cm90ZToN
Cj4NCj4+IEFkZCBhIG5ldyBkZWZjb25maWcgYmFzZWQgb24gZXhpc3RpbmcgaGVsaW9zNF9jb25m
aWcgZmlsZSB0byBzdXBwb3J0DQo+PiBib290aW5nIGZyb20gc3BpIGZsYXNoLg0KPj4NCj4+IFNl
dHRpbmdzIGZvciBlbnZpcm9ubWVudCBsb2NhdGlvbiBhcmUgYmFzZWQgb24gdmVuZG9yIHUtYm9v
dDoNCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9rb2JvbC1pby91LWJvb3QvYmxvYi9oZWxpb3M0L2lu
Y2x1ZGUvY29uZmlncy9oZWxpb3M0LmgjTDU5DQo+Pg0KPj4gQSBzZXBhcmF0ZSBkZWZjb25maWcg
aXMgcmVxdWlyZWQgYmVjYXVzZSB0aGUgb3B0aW9ucyBhcmUgbm90DQo+PiBpbnR1aXRpdmUgZnJv
bSBtZW51Y29uZmlnLCBudW1lcmljIHZhbHVlcyBpbiBwYXJ0aWN1bGFyLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPj4gLS0tDQo+PiAg
Y29uZmlncy9oZWxpb3M0X3NwaV9kZWZjb25maWcgfCA4MSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDgxIGluc2VydGlvbnMo
KykNCj4gU28sIGEgc3VwZXIgbmV3IHRoaW5nIHRoYXQgbWlnaHQgYmUgb2YgaW50ZXJlc3QsIGJ1
dCBwbGVhc2UgdHJ5IHRoaXMNCj4gc2luY2UgSSdkIGxpa2UgdG8gcHJvdmUvZGlzcHJvdmUgdGhl
IHVzZS1jYXNlLiAgVGhpcyBjb3VsZCBpbnN0ZWFkIGJlOg0KPiBjb25maWdzL2hlbGlvczRfc3Bp
X2RlZmNvbmZpZzoNCj4gI2luY2x1ZGUgImNvbmZpZ3MvaGVsaW9zNF9kZWZjb25maWciDQo+IC4u
LiBlbmFibGUvZGlzYWJsZSBvcHRpb25zIHNwZWNpZmljIHRvIHRoZSBTUEkgYm9vdCB1c2UgY2Fz
ZSAuLi4NCkkgd2lsbCB0cnkgaXQsIEkgbGlrZSB0aGUgaWRlYSBjb25jZXB0dWFsbHkuDQo+DQo+
IEFuZCBzbyBub3cgYm90aCBib2FyZHMgd2lsbCBvdGhlcndpc2UgYmUga2VwdCBpbi1zeW5jIGZv
ciBnZW5lcmFsIGNvbmZpZw0KPiBjaGFuZ2VzLiAgSXQgY291bGQgZnVydGhlciBiZSBkb25lIGFz
Og0KPiBjb25maWdzL2hlbGlvczRfc3BpX2RlZmNvbmZpZzoNCj4gI2luY2x1ZGUgImNvbmZpZ3Mv
aGVsaW9zNF9kZWZjb25maWciDQo+ICNpbmNsdWRlICJib2FyZC9rb2JvbC9oZWxpb3M0L3NwaWJv
b3QuY29uZmlnIg0KSGVyZSBpcyBwb3RlbnRpYWwgZm9yIG1ha2luZyBpdCBpbmZpbml0ZWx5IGNv
bXBsZXguDQpFLmcuIG9uZSBtaWdodCBhcmd1ZSB0aGVyZSBzaG91bGQgYmUgYW4gYXJtYWRhMzh4
X3NwaS5jb25maWcNCj4NCj4gQW5kIGhhdmUgYm9hcmQva29ib2wvaGVsaW9zNC9zcGlib290LmNv
bmZpZyBjb250YWluIHRoZSBTUEktYm9vdA0KPiBzcGVjaWZpYyBvcHRpb25zLiAgVGhpcyBwYXRo
IHdvdWxkIGFsbG93IGZvcjoNCj4gbWFrZSBoZWxpb3M0X2RlZmNvbmZpZyBzcGlib290LmNvbmZp
Zw0KPiB0byBiZSBhIHZhbGlkIGFsdGVybmF0aXZlIHdheSBvZiBjb25maWd1cmluZyBhIGJ1aWxk
IGZvciBzcGlib290Lg0KPg0K
