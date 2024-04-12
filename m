Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B035C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 12:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 530F887F4B;
	Fri, 12 Apr 2024 14:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="YG61/rO2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6D5D8800D; Fri, 12 Apr 2024 14:35:05 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8597387F4B
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 14:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUKHIFHdjusTXFAW9eNyPXzoiWTN2aQZDDsd1sQ3ewLfIwnNjM7yx4/vHQw0qYxV+0irjwK6PGVWBjfU+20YMf3nZJ0mSfHYD7aCghxpnGxb2tAAiz2+aQHMNMH+m8C6A5/0vu02/NUS6qWrTMtMEWz1rzMjcx9zcW7R3N/U/JJGeQJTgEYfrnkTqfRYlp4B4hsLvpiNO8SkI7gAJESRtehPwllkaB55zE68U1vZuic3nbvaR5cUhWIl3TTi9xlCplyaK0hzrIt/2Qm94++IQ07PqjTorARDFmTloZ/W4Jnfuh1qVhnNH+iVFA7hJ1EvlxmNKZaCE8prVDZkctM7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7DKKGE2lHqSaRXb2M5K4xFVeQ3IYyZg5fzLdmAYKn0=;
 b=HoO/F++4r/14w8R3pE6aZ6XPJ2CqybvwRIPOvY852Hw7vOIM8oprQcVHg9pl/aPD4kGdsHuMBahnHs+dSwwNCAaPv2QZueiEhT9dN5Bm7pdIYSKBhGynq7P0yII47qlXVp+ggGR1zeLWf5YceceeyS1E3s40LvG6jgckwvThcL3GsfGj8zJlTihCqcjG0gi7R5QhXzftM5wDWkVfwpywpNo7H6NtQ/QqXvB2nUUIoaJV3RGv+pJGhgxIRfgEAyQvoViv3izER8WDL04g5ys8wprvK1R+epnKjtoVpGZxA4SElKa9xHX7oMcZZSENBuM2dDsBvtZtGRa0gG+lSY3Gfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7DKKGE2lHqSaRXb2M5K4xFVeQ3IYyZg5fzLdmAYKn0=;
 b=YG61/rO2MaKZzg5U8Chkbm/vpYf8OebhaTvyt6wMrleE4mBhiYSY7yRwdTKCD/nvzwyeyXdbDxr0+R8kfqLap7OKBvc+/MRSxA6xMJXBAidFbnpE+lTMYkFZv0Ww9SSbzpK63R3JMLuMP5JkoEf/OkOCll0t5HWElTQqa2TQHQw=
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by PA4PR04MB7712.eurprd04.prod.outlook.com (2603:10a6:102:ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 12:34:56 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54%3]) with mapi id 15.20.7409.039; Fri, 12 Apr 2024
 12:34:56 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>, Mathieu
 Othacehe <m.othacehe@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v5 2/5] serial: lpuart: use ipg clk for i.MX7ULP
Thread-Topic: [PATCH v5 2/5] serial: lpuart: use ipg clk for i.MX7ULP
Thread-Index: AQHai7+RHL/TvYVB3k2uESXcywYjA7FkfV6AgAAWirA=
Date: Fri, 12 Apr 2024 12:34:56 +0000
Message-ID: <PA4PR04MB94167FAE95C3B8172A1C3FB388042@PA4PR04MB9416.eurprd04.prod.outlook.com>
References: <20240411-imx93-of-v2-v5-0-9eb3c64ff160@nxp.com>
 <20240411-imx93-of-v2-v5-2-9eb3c64ff160@nxp.com>
 <CAOMZO5DDwsopWC8xnVhKsDtCCXLv3pVRxHt2ij6sJBCYBVRLYw@mail.gmail.com>
In-Reply-To: <CAOMZO5DDwsopWC8xnVhKsDtCCXLv3pVRxHt2ij6sJBCYBVRLYw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9416:EE_|PA4PR04MB7712:EE_
x-ms-office365-filtering-correlation-id: 0dca0fea-d4b4-4a3f-dc5e-08dc5aecf5f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: te17a9KyZabU+ZVrRzKLszkg5oeF2TeL4/0P2tYmDXIRWxPWC6KBq0cOjRqhJFmrDy7YNv3jvxgLwIM7QzNo6KUGy0ea77QkKSFUH/h+5hdxBAPomo99yMB/MWjMVKWotRjs2UtVCUXBPlgFC3vrgFD/g6o/r0nUf1mF/8eWJLjQ+B2c3xorO/BqBoCccVqmqYzaBdGZ07HhLpM/+GMY2UoNOhsqX8RTVHIpCtxQ561APrV36YIiqVZysXT9nIgi54rfuO/UsNw7jvyh5vw4L+jgqnhRoP+VkjMyHUvCvmlWvaTU9bqIhuHvGM8lXsxVd5Dl5ghzypQZN3tKKy5K4xN6tJAqcCUlwK1elKI/LLfYnLfVYMRPcm5KQD/K5HqP3tjcMHBXmP39HxwoNi1QdsjteiyK/4vzH/x7oUCTlLIKTymZM5yYn2loMiz5GstGZA1h67Z8Q1rjS5ity97GQ75Q3bGxnmAUM+SNaNiv0CuIijGD78ZuwQ1tH2ZF4/ChEThrQG89F9Wl/SDhGTGrIlUfcdo+oJpOtlKayiX54pFLJmOcQcpfqAC5MUKm/oiz74nRIcyyDGWGqfh8dftqH/n5q5C/4Jh4XDM4Nw/kRVF4utN15yW9quLLcEuAC/ZPFDXGX5JotM1UKIfx6o17/o+6ya6USnqfLkAKEWhMFxcOZ9S5OFWWmoLkk/YqG0zer0DeKpdzdkvPAmgelwR/BQ2cTenm5wChC8C6xneQT98=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9416.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmtmWVRCZE1ZOVI0am1IMDFDMDJOeHhreDhJMFhpNld2eUhYcU1Oa1ZTc1Rn?=
 =?utf-8?B?aHV6WHl4TG1ya0dkelQ3WHZZUGtZVS8xaG8wOFJEbDBRc2l6MTdueUxmalpI?=
 =?utf-8?B?cGxEM29yNGwzbHZ4T1B4WWdzRDVyRlhOS0paSXFLUytHR0twenFOd05TQjlZ?=
 =?utf-8?B?ZmUwV3JuMFpCT2RUZFpnR0hmeVRISWk5U2t5WTY5QVJGR0tMOHJZWDZ6RWZl?=
 =?utf-8?B?MytLTjJlb2h0SGduc2x5a2h1eXdORmlYaE1KcHJVSEtzYlRhUEdZYUhIVysy?=
 =?utf-8?B?em5aTS9aSWxEL0NQcG5GK1hHY2w5K0NtQklGQXBlU1B5V2hyTllJNnZCR3Bk?=
 =?utf-8?B?VENMZ2xhdTJMTFFjV29zcFZsNnhFU3pRMFZZQUY5MmNsYWUwcmJ2N05taFhv?=
 =?utf-8?B?cTFaZ05kMWVvNlRQclpuVEJ3UUhGMGZ1ek1FdlZJV216empUUGEwVmxrdjJ3?=
 =?utf-8?B?R2E2MFUwZHlOa3Aveml5dVJSYmVDb2hOYXZKajl4MEgxVitqT0diOEE0TlZQ?=
 =?utf-8?B?bmIvZ3lwc0ZmdFVFUEhBWDVlWGlZb01vbmRsbGViaU5sbUp2Z1pvZUp4dk1q?=
 =?utf-8?B?UmpMcWI0ZW9UY0IxYWJYRE5xQnNUcEtKNndOVVhWbERLOGw4Qk1ENnViK0hY?=
 =?utf-8?B?cTBiekxlWUtqTEh0UjF1UU9iM2RDS2xmK2NKV1dVdzF0RGlGck5yTFVIdXo4?=
 =?utf-8?B?cjRyWURGcGl2S3YyckNRa2s2bGFJK05LckFLWlBnWGtCWEdmdUpHTE4xM2s3?=
 =?utf-8?B?STdyWlhFK3Q1UnlJTUxXUVlSSUU2T1lFVHJBTWN0cFgxc2ZVRlpON0UzcDZ2?=
 =?utf-8?B?dm52dmtTdkpoQ0VpRlhUUno1MGlOUXJ0U0w4K2Y4UmxLa094R0FOQzNWdUx5?=
 =?utf-8?B?ZGhqa2lidGREeDZpTlA2dWxiakUzL2MzVmpwS0xDK2xvV1AyMjRZNFArY0dN?=
 =?utf-8?B?SUprVGkvK2FMaTVEcktBYVcwczZIRy9CamRsaVRycGRicDlYMWZhWW1qWlV3?=
 =?utf-8?B?YkdFQndLQ2UxWkNMc25aQXBTemkyamJoY05NUjdSUkd6NGJwTFdkYWg0eDBs?=
 =?utf-8?B?WTd6R1dWRUQzNWVVYXErL0tzZkpVSzk5bmYxbXRCSjJaR2FhOCtNL1E2eWNx?=
 =?utf-8?B?UnZUSW83M0hndEE3Y0RjNFR5YVh1b0pXQk9haXpnSDc1c2dST3VjVS9iRE5D?=
 =?utf-8?B?dndjUFAvSDAyalduejhkbFZEVHJxZ2tsLyt6Zkk0aG9sRSs0ZWZRTTlJSENH?=
 =?utf-8?B?Ny9sNnpveEhTSE5LWmxhQys2K1lUS3REUkhNT1lUSUpVRDlLaFZQODNyRmNa?=
 =?utf-8?B?ZlpHVlJvVDVFcWdaa0VKUnRvaEE0TVcwTnlqQ2FpTkp1bUtJS0o4TWVTTWk4?=
 =?utf-8?B?d0ZOeHc5RHhhdnpkdHVjRzdOSHZPNktSN2E2OHlRY0RsOWRwZGNjb25jU3RH?=
 =?utf-8?B?U2FXNUgwb2pvY2pEQ2Z2c1hWOHp3ODduN1haSG51UDFPeEpkeEFBSFdHMWw3?=
 =?utf-8?B?Q3NwVHBvMUVESlMyMHpVRERXQkYwS1JhdDdFV3IwSjZFdzBSS29lcVl6Vkpw?=
 =?utf-8?B?WWtaLzAveUswQXpmTHR6dVgwYTFZOGE5Y0dxNjNDWkdUS05NREZtQzVtMjFv?=
 =?utf-8?B?S3RUeEFOV0dkaEc5dE51SnZHNWwrc3R5Y1Z6b0R4Vm85c283bFFvaUw0SXFT?=
 =?utf-8?B?c05LQy9LbGh2M2puVE5XakhFMUdTQlVwbjRQNXE4cmhLclY2b3ZGaHdCcmdu?=
 =?utf-8?B?S0lUSlR2ZFQrNnZnc1JRdVVKaklPQmRrU2VqUDVFVzBTb054UjNmM0RrL2lQ?=
 =?utf-8?B?MWhpNHJnRDBoYTc1aUJqNk1hRGM0bHR3akpkazViTVFTWE5LejBUREtSbjg0?=
 =?utf-8?B?WGlkTFZTN2Yrd0pIanBhMUFnMVM3a3lqaERicHMzcnN3TlpKS2hkM2RFbDNM?=
 =?utf-8?B?S0szYXU1YjBocTA1eC8zeDllQWdYS0NZMERKMTltcGdkZnRQSC95czdhSWZ5?=
 =?utf-8?B?Nzh5RGVYdFhYbFNQTWRlbDdQUWdkL05GeU9INmZpbWdHRnp1VVlLcjF3dWt3?=
 =?utf-8?B?YlJTVUh5ZWJHZW5vM2NoZkFzU0k4Tkc3TnJ5QzBrbHlqREdadGNKdkRHcnVU?=
 =?utf-8?Q?Nbu4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dca0fea-d4b4-4a3f-dc5e-08dc5aecf5f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 12:34:56.4633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCjMdXxwd+9AQRsGj4gkC8qcgwCzWb/yoodHYstdLkuZwkXr5gHjlQlXWm/iNHhEpcchgIeIZIYMhik3c0j0OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7712
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDIvNV0gc2VyaWFsOiBscHVhcnQ6IHVzZSBpcGcgY2xr
IGZvciBpLk1YN1VMUA0KPiANCj4gSGkgUGVuZywNCj4gDQo+IE9uIFRodSwgQXByIDExLCAyMDI0
IGF0IDEyOjIz4oCvQU0gUGVuZyBGYW4gKE9TUykgPHBlbmcuZmFuQG9zcy5ueHAuY29tPg0KPiB3
cm90ZToNCj4gPg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+
ID4gVG8gaS5NWDdVTFAgY29tcGF0aWJsZSBscHVhcnQsIHRoZXJlIGlzIG9ubHkgaXBnIGNsaywg
bm8gcGVyIGNsay4NCj4gPiBTbyBhZGQgYSBkZXZ0eXBlIGNoZWNrIGZvciBpLk1YN1VMUC4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL3NlcmlhbC9zZXJpYWxfbHB1YXJ0LmMgfCAyOCArKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA5
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2VyaWFsL3Nlcmlh
bF9scHVhcnQuYw0KPiA+IGIvZHJpdmVycy9zZXJpYWwvc2VyaWFsX2xwdWFydC5jIGluZGV4IGNl
MDhhNmI0NDg2Li44OTEzNTIyOTNmOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NlcmlhbC9z
ZXJpYWxfbHB1YXJ0LmMNCj4gPiArKysgYi9kcml2ZXJzL3NlcmlhbC9zZXJpYWxfbHB1YXJ0LmMN
Cj4gPiBAQCAtMTExLDExICsxMTEsMTggQEAgdTMyIF9fd2VhayBnZXRfbHB1YXJ0X2Nsayh2b2lk
KSAgI2lmDQo+ID4gQ09ORklHX0lTX0VOQUJMRUQoQ0xLKSAgc3RhdGljIGludCBnZXRfbHB1YXJ0
X2Nsa19yYXRlKHN0cnVjdCB1ZGV2aWNlDQo+ID4gKmRldiwgdTMyICpjbGspICB7DQo+ID4gKyAg
ICAgICBzdHJ1Y3QgbHB1YXJ0X3NlcmlhbF9wbGF0ICpwbGF0ID0gZGV2X2dldF9wbGF0KGRldik7
DQo+ID4gICAgICAgICBzdHJ1Y3QgY2xrIHBlcl9jbGs7DQo+IA0KPiBZb3UgaWdub3JlZCBteSBw
cmV2aW91cyBjb21tZW50LiBIZXJlIEkgZ28gYWdhaW46DQo+IA0KPiBQbGVhc2UgcmVuYW1lICdw
ZXJfY2xrJyB0byAnY2xrJy4NCg0KU29ycnkgZm9yIHRoYXQuIEkgd2lsbCBmaXggaW4gdjYuDQoN
Cj4gDQo+ID4gICAgICAgICB1bG9uZyByYXRlOw0KPiA+ICAgICAgICAgaW50IHJldDsNCj4gPiAr
ICAgICAgIGNoYXIgKm5hbWU7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKHBsYXQtPmRldnR5cGUg
PT0gREVWX01YN1VMUCkNCj4gPiArICAgICAgICAgICAgICAgbmFtZSA9ICJpcGciOw0KPiA+ICsg
ICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICBuYW1lID0gInBlciI7DQo+ID4NCj4gPiAt
ICAgICAgIHJldCA9IGNsa19nZXRfYnlfbmFtZShkZXYsICJwZXIiLCAmcGVyX2Nsayk7DQo+ID4g
KyAgICAgICByZXQgPSBjbGtfZ2V0X2J5X25hbWUoZGV2LCBuYW1lLCAmcGVyX2Nsayk7DQo+IA0K
PiAuLi4gYmVjYXVzZSBpdCBpcyBjb25mdXNpbmcgdGhhdCBwZXJfY2xrIGNhbiBiZSBpcGcgb3Ig
cGVyIGNsb2NrLg0KDQpZZWFoLg0KDQo+IA0KPiA+ICAgICAgICAgaWYgKHJldCkgew0KPiA+ICAg
ICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBnZXQgcGVyIGNsazogJWRcbiIs
IHJldCk7DQo+IA0KPiBBbmQgdGhlbiBhbHNvIGNoYW5nZSB0aGUgZXJyb3IgbWVzc2FnZSB0byAi
Y2xrIi4NCg0KRml4IGluIHY2Lg0KDQpUaGFua3MsDQpQZW5nLg0K
