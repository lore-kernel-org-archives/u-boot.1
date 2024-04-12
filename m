Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8B3C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 20:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C382587E75;
	Fri, 12 Apr 2024 22:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="ZSOhabc/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2501588137; Fri, 12 Apr 2024 22:30:35 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AE9287E4D
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 22:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXm5QdyeZLEGUVRHSVFPlLnvL7ALO0Mnfy1ZRDWHjD+Ojs8awETrw1+rxTRyESRhzfWfoRzU9ZAhuiobVKR/at0aOzNtDjnJGxgGXOQOpZ+BU8tgXk47xTktXQVW0X3Hsa9DSQLoWbr8te+0hfzsnxX+ZwGuKRvXCexeclt5FjTD6qJuGwQycbX6UAQ66p4yRgyf/F6Xrs+isYA8Fyu2z6Q0G5CEUCeatwBbaHZrhKvzcoQeuiAVwyA2t99oPQppeKyrQD3c82tCRivrsxwAFfs/2fTtKREM9wrA0h5UfGzONVZRI4yOEsQ0M2VLQdYBeJlnOwUkKVYDN7LDJX+qZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4tXuywG2mQdj42fyTagUiGciFkEGIerwaxqmp2pCzU=;
 b=HNYkTXrqZ/42FjOEWEEVh7cFphFiqGVuKdV7AQMMhwJu+Cpx6P+wRO+Ss99m9pGTHxbL2tUJ5SpRUgPCVd8ykDfzBM69pg+LFrR9rVcGCGbujWsvaeXK1Yr+AMfUMnkdCQkc00DCaxIX53yESoyazGLf/u0oBpCMzNw9OlWdYor57MzUaMEKOjpbwE0OWE2MpgwL0MJMIlU/qC/eoU4Bk8FqVEUVWp+x8DltAxes/QxjblJe1yjvcXAAtQFj4UAH3Rv/HpxMoG+O1to/HmRQiEMr4Wtiy+pfaZDVPJl0OA/1UP+79nL1f7MmxHrKWv8B8aWUbV14yKHArIGec09JNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4tXuywG2mQdj42fyTagUiGciFkEGIerwaxqmp2pCzU=;
 b=ZSOhabc/71RWOd7+vYy4XrfDfT7/aOw/7OrbldCMB7SFrE5Qykr2qp+scWkxQPn3bfnuq0Vo8LEQQoFS+Il02VaNEOEFrsGwubXMtG+vgOwbjwJ0jKm6d9K4Llcknqq/+RGOO8w6sIsUsWkDqidM/1aZ7KM8DyBXoGqHc7/o45QDvfBzuj5NEptjH/igX04Q5bSoS/Xdm2ohye4s1Ho6F1LLb9g6L4CWP46J5VB5SKqNFbJ/dv+uozawHgv2slZfjm8Bmq01nRIiZTLP0DMbY0bAfFpXqAm4f4QbCm+WmU0yZKgfBFzD8VrKDkNJb7AeXq5OXRXp/zTp6m23l3I/Ig==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB8PR10MB3912.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:169::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 20:30:31 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 20:30:31 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sjoerd@collabora.com"
 <sjoerd@collabora.com>
CC: "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "afd@ti.com" <afd@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "nm@ti.com" <nm@ti.com>, "martyn.welch@collabora.com"
 <martyn.welch@collabora.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "rogerq@kernel.org" <rogerq@kernel.org>
Subject: Re: [PATCH v4 4/7] arm: dts: k3-am625-sk: Enable usb port in u-boot
Thread-Topic: [PATCH v4 4/7] arm: dts: k3-am625-sk: Enable usb port in u-boot
Thread-Index: AQHaRTTn9d8jk+WdSkKahzqDDxEIQrFlphsA
Date: Fri, 12 Apr 2024 20:30:31 +0000
Message-ID: <4587dfd642c82f4589f233df6a6bfcbd7cc79069.camel@siemens.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-5-sjoerd@collabora.com>
In-Reply-To: <20240112085317.1866449-5-sjoerd@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB8PR10MB3912:EE_
x-ms-office365-filtering-correlation-id: e210b11c-e37e-4340-9476-08dc5b2f6626
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zWGBwNJ9xfuT3JNAdTmZvePxu5WAdM6CwMH1d3WYiV2L2r/pBUVnERMOfqhwQDyrG1r+lYtgbjBDcowhmT1PS+NxuRmOIQPVhmwuFo5RWO+TG0EqNOGM2GcfhiyDQhlR0avzEu7+EhnOZDjYHSB/V5me3UrVs2CHQL851gO468hUHjE9ADJXNdaE6+K68m8yQaPE1TtJ5hFlB6x5egxFbcuLusXlyKlirzDd5rptGt9Mbwx5jkxS6o4eoSfulVxl2RevFQEED3z5tDW63jpiq2Uh3KAMHA6ORE23rtQ42XQ8A2Nk52AEpOpYb4iuzO/3Ux4ZFtoKiWBIUeduAkDwjn3MqCdfskS6DUhJZqn6tqc8jVS/VXg8UB1x+ULIQpBz5HIbRKaG0CivEK3Wkz49Be1QE74ugkKSyfSetgyOxn17dLu3PjsdQ9oUPu0+5NDI+PaVUBL0LCUB+MEe2kLioqPZTUU4NObYZoV4NSzCBQeQf6xqGuwOYpZhxm+txA5auoBvqr9yiSjAv6nXfxizHS5vvwgSuNwHYmovACdoZBC2SwE7FxQ0VnxkmUITUVmlbS+iE4Qlae+99f44DSDqH6PdKBSq/bq6Xvw1Ip5SJ5eZEfp3Wg6E5b8Ff41h8FPRkIAMiI2JJyWbwkpCMikg2EUhzAfAn8WfOk54ZnfW6DY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzhjWGJQY3N0YlFpYVJtci9BdklaNCswcTFNOFZMRytxVFNudnhJcTByK0tu?=
 =?utf-8?B?QWVRMzlJYTkvOEFud0hsa3kwb1ltT1l3ZVoyOU5KdlJ5cndDTWVNNGVnczJI?=
 =?utf-8?B?TDIveWtZY284RTVKdXRsZGtZZFZ1SkZIUTdqNGJmYm1ENFBjVE1BdG5TcW5z?=
 =?utf-8?B?cWd6d2VIOHlOU2NEVUNNa2YwemJlWDZRVGZsY3RyVzdXWktaTmxHS1hnVzhx?=
 =?utf-8?B?eVVMS2xIbm5UMVIzUFdReFNLR3FaUk8zVWtLTitGU0RUZEowZTNtYlpRVkhK?=
 =?utf-8?B?QVhibDVMeWJlRVBUTTRjd0NwbVhrV2FuWVg0aUYvdlpvTTlGZmxhOURMZFJR?=
 =?utf-8?B?am9ielh4TEd2WXVNckpQbVhtY05Ka0hTRVdqckNWclZXWlovZlZTVjhNU2JG?=
 =?utf-8?B?QUZBMm0ydGEyT1dweExHRUdnOHlFWXE0c0ZUWG9oWlJhcWNURGdNUmhzRFNK?=
 =?utf-8?B?ZW1LaCsrMitOeHFINDdKSVRlZVRUZkxTdTExcWRrRHhrTTcvd0E3NXRPMmd0?=
 =?utf-8?B?WXBoQTZlNytZQ3Y5NVl4TjgwaVR4RVRmeTk0VklOVmNFVzNnc3ZLSldxc0Fu?=
 =?utf-8?B?WlJtK2NLQzhIMitUdnZLVDNuUm80MElsbFBEcG5wVVYwdlQ1Um5PRkFGTzRO?=
 =?utf-8?B?YlpITGdkM3hYOU5xd2NNRlpEc24xV08zbDNPME9XSy9pTEhRRnZKRDBiL3dN?=
 =?utf-8?B?S0xUZHJIQzYwZnFsZ3l3aDRwcTdYY3Bmamk2YmVKVGZzV0tCZDljMGZhQU1F?=
 =?utf-8?B?bXlWYSs2VGszWlA4Zk56eHVYSHczTC9Mc3daYmgxRzJUTVV0K2svMDRPSmh6?=
 =?utf-8?B?NDczVGhoSlJnVnFFbGNaRzFwTEZSaGwyUTF6VWVhelNUUWE1dlVzTUFIRFF4?=
 =?utf-8?B?cmZtR05XbUUrcnNZWXFoSzRGUXdnYVErMHY3QzVpVEJPdGlnYUhLMVZmWTFj?=
 =?utf-8?B?Y3l3bDE1VWJnZGhVZXZRbmt3Tnp6WWFjcnhndTVOaGpKTyszTVh5eVhiV2Fi?=
 =?utf-8?B?N3Roam9SUm9URzVHTVJaSW1tUEJRb3J2dHB6Q2t6bS9WT1FOTDVSdm52MmpZ?=
 =?utf-8?B?ZzdqckZtaUhrbnN0VWlEaWVnTlgwZ0RrMlB1R2JNMi9iRlh1Mm9FazFHcE1K?=
 =?utf-8?B?NkI1UzI0M0pqa3RQSlBab1hveW1DbnRySmxxU0ZaNXdoaGNDNkhaSDQ3SUVY?=
 =?utf-8?B?N3gwK2h2Rm9MNm9WSklWanNIaklwOUkwdHA4VFhDMjFQVm5LNFlGV0Zsa3Nj?=
 =?utf-8?B?aWovMUFrcGVSM2VCTjJGZkdvV2psWkY0M2hNV3pvbVNTWDRUN0xkcDhmRExa?=
 =?utf-8?B?ZlNKL2tUSjlpMFFaK2tidXRHalZWbUhhVWpXcVJDV1Q1ZkxNRUxyeG5EU3ht?=
 =?utf-8?B?V0VWSThZZ0xvQXhZYlBFWDBXYmxFK1lUZk5qeTlDWS94bmgvUTBidUE4bW9K?=
 =?utf-8?B?QUN5WWF5aS80L0IvQUh4WVhuS1lXOW4xeXVOVTBTOEJPUWlBcnZ1TkUwa2tY?=
 =?utf-8?B?TUNEK2hybDR2SlBJS2VRK2NpTlM2RlJLc1FScmNueHVOSDk1SnpJZ2VJNXVu?=
 =?utf-8?B?cWtFNmwyTE1JakxJM0wvUHRhT3Q4SVRlK2Y3RlVsdkZTK25BTDZWS28zS3RI?=
 =?utf-8?B?WnpqU0hYUDdvNzlFZ1AxcDhJdDNPODhKRzRSMFBLYWhPTjJ5SUU2Tk9tekpr?=
 =?utf-8?B?NWhIUmFlQVVHS2ZsRXI4K3ovdUtnN0g1TXdqb3hxWHpoK3VNbnlPNFZpR3Zx?=
 =?utf-8?B?bVdMN1c5YWY2d3gwVmNycGRnSVVEVFhoMlpiVUJ5Z2dna3J3UHF5K0M4cEt1?=
 =?utf-8?B?NmxrcDhEbU1UU2FnSHJoQVN3dENtYXZZR055S0FIcWVmdkdIOGZ6blZSbnJu?=
 =?utf-8?B?TitmK0VWcWpTdVlVaHJTUnNoQ25xbCtDTjlVaEtHMGhYQmRBVTZzbk95ZXVD?=
 =?utf-8?B?QWk4K2Z5RVRieEcxNDAxTDFYQ1IrMDQvQ0RUY2hqZnpnQjUvdG54VEZJaW9N?=
 =?utf-8?B?L2lQbnFPOWdDYXRVYTJVYnhrejEwaGF6RjQvUXc3SXRVYjFLd1l2bEkrRlc2?=
 =?utf-8?B?YWJDdWpYS3d6c3lUOElwZkk1MVhyUVBTc3dVVVAvWFppU1hNL1VqUXoweXE5?=
 =?utf-8?B?NVlDWlJPc01ya1NxTW5HN3JoSTFPWEt2V25aSFIyZm8wWVdUekxlajNqM2Q3?=
 =?utf-8?B?M2ZIZDc2ZnM1SmpKRkduenNaRHpaMjdFcnNia0JNbnhicXF3cUVQTmQxdCtZ?=
 =?utf-8?Q?lEnv6IqOHW/7sMnfnO68d5d1aoIK3NBAz8WJxjHMFo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0166C09978367A4D986AFFC994B1B306@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e210b11c-e37e-4340-9476-08dc5b2f6626
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 20:30:31.4650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNCO1i+B2Vk+0kfBu1bztsejLabF9vVQw5xsl0b7VbHRJXDR4tYm3Mr7kMKPmqAUWjr8jtf7Ipb8IdHZF8gi8eKDnovjht0uDWx1msBiwOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3912
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

SGkgU2pvZXJkIQ0KDQpPbiBGcmksIDIwMjQtMDEtMTIgYXQgMDk6NTIgKzAxMDAsIFNqb2VyZCBT
aW1vbnMgd3JvdGU6DQo+IEVuYWJsZSB1c2IwIGluIGFsbCBib290IHBoYXNlcyBmb3IgdXNlIHdp
dGggREZVDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTam9lcmQgU2ltb25zIDxzam9lcmRAY29sbGFi
b3JhLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2
ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiANCj4gQ2hhbmdlcyBpbiB2NDoNCj4gLSBE
b24ndCBmb3JjZSB1c2IwIGludG8gcGVyaXBoZXJhbCBtb2RlDQo+IA0KPiBDaGFuZ2VzIGluIHYz
Og0KPiAtIEVuYWJsZSB1c2Igbm9kZXMgaW4gYWxsIGJvb3QgcGhhc2VzDQo+IA0KPiBDaGFuZ2Vz
IGluIHYyOg0KPiAtIE9ubHkgZW5hYmxlIHVzYiBwb3J0IDAgREZVIGluIFNQTA0KPiANCj4gwqBh
cmNoL2FybS9kdHMvazMtYW02MjUtc2stdS1ib290LmR0c2kgfCA4ICsrKysrKysrDQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2R0cy9rMy1hbTYyNS1zay11LWJvb3QuZHRzaSBiL2FyY2gvYXJtL2R0cy9rMy1hbTYyNS1zay11
LWJvb3QuZHRzaQ0KPiBpbmRleCBmYTc3OGIwZmY0Yy4uNjdjOWZhMmJiYzMgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvYXJtL2R0cy9rMy1hbTYyNS1zay11LWJvb3QuZHRzaQ0KPiArKysgYi9hcmNoL2Fy
bS9kdHMvazMtYW02MjUtc2stdS1ib290LmR0c2kNCj4gQEAgLTQ2LDMgKzQ2LDExIEBADQo+IMKg
JmNwc3dfcG9ydDIgew0KPiDCoMKgwqDCoMKgwqDCoMKgc3RhdHVzID0gImRpc2FibGVkIjsNCj4g
wqB9Ow0KPiArDQo+ICsmdXNic3MwIHsNCj4gK8KgwqDCoMKgwqDCoMKgYm9vdHBoLWFsbDsNCj4g
K307DQo+ICsNCj4gKyZ1c2IwIHsNCj4gK8KgwqDCoMKgwqDCoMKgYm9vdHBoLWFsbDsNCj4gK307
DQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20N
Cg==
