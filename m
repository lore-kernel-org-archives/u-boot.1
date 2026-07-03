Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2924C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 06:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DEF984119;
	Fri,  3 Jul 2026 08:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="b5iw90WB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3DA841F2; Fri,  3 Jul 2026 08:16:22 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 117368407E
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 08:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2bp+q9RzhKxg0IioJEEYLOczDMrm+lUUi1g9uguWPWlbqyTyC2roYbHsJ0NEppjEYDGnHwXN5Q7MCFTW2qzMvcZ7nl/SjM0pFd3sAV0hVHJncD2wFcZXD5rA6qC2lvWNVvBh/jNPz/nMYbds6V/KfQX9wxI4XX5BbLmx/clNfMo3fN4swEqvodz0EfbWafJAB3K38h5V8ntauvhB4ktgrwvt0u3JaMfJMh8xaA+5deaxQ4tTsxEUvB2oKlzTfj2PJPcYpb5h1/WvimACmwAeZ5fqGGbkTX7CVW771wI+8S6GhpENxd2MtJDHSOum0YPUDxbG/SZqUnccavSKYkMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgZSBIvjC/CXsVuKh5toMrJJ1suZydZ9qHaDg+9tpR4=;
 b=dhKqn6MVJbZsm95ItfUD4vTheWt+AUddLloex+RuViZSAubUHkoNtk8733Hv4ZGETO6A4Lk9hKzcffRz+zjzgrycyOgNNeTeNiXhGMBRBxghXK5GshPAm5zZcXhMn92tYqL/K9QspIFhFaOB8nbc3AGIWKa4a8K7yK5jyF4rGy3Jl2cxcGIRipxQ7ImUbfqUt3ThUI3y4CCfIrU+91GbEzUqYbQxxoD6DefLBc3iJPz2m6qQovHh8dTPDLlE2ZSlU9nOi6xmPKy2DPTGhQ8vy+8FLZiglbTHy1I29SqviWq8oRqbqkK+ZRDzNGYAUupIXtxixZA51wGfkM7C75DGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgZSBIvjC/CXsVuKh5toMrJJ1suZydZ9qHaDg+9tpR4=;
 b=b5iw90WBwwCmOzxDxkEQJji3Wni73pKklAdoINWnDCHWg2dv/Uo+25YAvKEQvgdlxTDZ129feglBY0bWxAdatKb08BDuR6lMVByzMM9RNKIDhaF8LoEjro5Rc2N7xS8q8NUySex1ErM/tZdig0CrEO7FjB2uNaHD+oU8R6TWydZCDXOTviWsM57/LW6TK+wgp2mH2V60sJOyI0g0tJDg/REX6gdjJsN9/y+TMcfhhvjyyiLi65Nr520QkIztHdDUJgQ4EvHXEx5KR8lzJw5iCE4Ya1ypAQr9mcN3QBWKBC1cRtURJ/sZ+8wo1gsf8loiTiu9TlSdtVVUpZVxFX0qnQ==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by AS2P195MB2430.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:62e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 06:16:14 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 06:16:13 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Marek Vasut <marex@nabladev.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Fabio Estevam
 <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Simon Glass
 <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>, Tom Rini
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8m: Reinstate TEE ifdeffery
Thread-Topic: [PATCH] arm64: dts: imx8m: Reinstate TEE ifdeffery
Thread-Index: AQHdCKrnZwSzILPPFEWG4EepumfAgrZZ0MsAgAEBKACAAIObAA==
Date: Fri, 3 Jul 2026 06:16:13 +0000
Message-ID: <5147fb9ef450d4a6963b57dbfdd6ee03eb2ae29a.camel@phytec.de>
References: <20260630160951.122230-1-marex@nabladev.com>
 <0e9071095b0b590c45a139eacb210192e160823f.camel@phytec.de>
 <3200f8b6-6e5e-4275-8442-03ecb6a48597@nabladev.com>
In-Reply-To: <3200f8b6-6e5e-4275-8442-03ecb6a48597@nabladev.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|AS2P195MB2430:EE_
x-ms-office365-filtering-correlation-id: 40fd2aef-9d5b-40af-dceb-08ded8ca9531
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|6133799003|11063799006|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 69eI0SI4PWAPapx21z1oYgadryTDzmFIbF83Emnvr6ZJ11Nr6sP++bOsMiBaeC2Rgj/89LkkJ7X48qdHjz63F7gfqz2hOSmDTqFsogbZTHu+SqjesFsdlLjeGsFWNeSaZFRL0+mvL0zm6R2X7bFq1ag3jE7zKiXkH2xFI8Bb2vC6kLq4YLtWcnICoqQK3mOvfEVFYjsOchg2CkPPg8qmuk4YrN61zWvO9zK7U1DxnuO4ZP2/Vxqdxut1dnF7hPqDwHazoxdt0OiIPkyvaTl6ZCKUtbRKNczPQJmeHRNX8BLbIXJyQF2bfpIKWz9QK1+ELr6FMSNgA7VN/4V9Oj7nxhKJKSbN4D2RLRZrrq1TQ0SbynyQo20MN7WF7Xh1Ea8GosEBjbQ9LxFJW6zedkPB10sNKUscnFBfn+6CzHE/9qpG9Y/bgtstsgQ3+28wxzoU5QhE+n+F2L0G13awtxHx92CEXfG3NTavth11ie1XuB2xSK0A3LqYAii4RivLxm2hfZnumigbqfBubkWZpav4Q5oKCzu5kPoPNYsd35OlJSvIeuObnkGAP2mQ6wgj216dU5LeaAhWvGGgBBGtp2sHxgfgylOTPsLKICvPYfM7v2eBXrgB1gp1WUfUOVxW2se1JPxyVATAHYpKW45MVVG7RQgP2oCHwixyUi0RoaKjP0w0Dg/wxk2+YnUpAPPAw5durg4G38HkOQ/wHkJgzBoL4qzI+xLGuLtDMMmOw42yD3c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2VKUkMvdG1xU2YvNDVoekY0Tm5wMEQ0RHZsZkFKQ04zWldmN2pBUC9QbUVz?=
 =?utf-8?B?SDgwejkzOTM3aFc2NnkxWml2OFlVbnVGalpnNGVMbEwvZi8wRHpmQWw5TnY1?=
 =?utf-8?B?R2Jzc1M2YjVrM0cwR0RadkVGMEQzczFSYVV4cUd2SlpycmVhOUUwUVdwNTlq?=
 =?utf-8?B?OUhHTDUxWXRaMjhiTjdjaUpRTk5wd0RwNUYyTDNSelM2ckJ3ZG41TXkrZVdB?=
 =?utf-8?B?Q3FodkJwZXhTd0hBMTB0ak5kUm0xZFdmZnBwTHhPVkxnVS9ibDFQYmFPMHY5?=
 =?utf-8?B?MEw5MGsrTmJDeDBLcUx1UCtKWHlyN21EcjdmTnBWdUwrWXByYS8yMEM3MDBr?=
 =?utf-8?B?UlFndG5tT1Z2dDJZVkZCL0NCSkZVWjJzYmZXN2creEZLWTFnVkp0S3dKMlJQ?=
 =?utf-8?B?KzRuYnpkT3pDQUZYTUJQOUVYMHJBOVNlM3pIYzlrUE1qUTNibFl5ZnVYUU14?=
 =?utf-8?B?QmVnYTB1US9MQTdMTERWRng2cmVYaUVUYmpaS2hLQTRGRUcwVXdVckphRHdt?=
 =?utf-8?B?NFBhbXFmNTBHSHI3b0E5MnZKRGthcmgyVlRaT2NXck9wRnUyQVFJTm9mS1oy?=
 =?utf-8?B?V3FjdkV5dDFhbnZtbGFJcElXWnI3OE1icGJBVnYyL00xWGZ2dVlNMis1bnF3?=
 =?utf-8?B?V0hGaUl1YStuU0FrRW9ERDloSmNSSU1QeXZmejBaTVVQZkJmMGNmb1QvNDd4?=
 =?utf-8?B?VWZMSExkdmp4MHIxeHNoTWFqSEZTNmFKOEhSWWpjbUQ2amV5ZkU4UnZLMzM0?=
 =?utf-8?B?Z0FKOWJLTDVhR0d6cEdhalBFcUFldWkvdGljRDdELzBUVkRpQVZaZlA3akxF?=
 =?utf-8?B?RTlDYnF0akZER20ra0cwOHliV08rNnpDY3hNbldxalhRcWNzZkxFWjdtOEVP?=
 =?utf-8?B?L3JSZm91T2FKV2o1bFdoVkFrK25YYjU4SFE0VkNJQU8zVkJucHZUS1RFeTVh?=
 =?utf-8?B?aFd3OEgxVWIzYW9wN0wwM0lERFduN2g1aFAzOUs0WHJzalpSS3EwQi9tUHFY?=
 =?utf-8?B?WkR5QTdlZFgxZDBnR1FnOFAwQ3RCY3l6MC9jRGtWM0xKOXNVZ3NmRGFoNmNO?=
 =?utf-8?B?V1NySUVvMGtNRWVkTlRlKytocXc2QWo0aGpycEljSHpFYzhvdUNDL3NHOS8v?=
 =?utf-8?B?YTBqZ1o5eEF3Z1lCM0F0NW0yeHNQQWRSclAwOFZITlJkY1ZRcTdxMWNwYUNh?=
 =?utf-8?B?Z2VSdHVNZDZqVEkrczBQODQzaFo5cUxQUFI2ZFBYNGp4NjZpa001Ymw1Vm9z?=
 =?utf-8?B?dnpaUzAreklUNGljK0xXUG1CeEFzcjFqVXpJQ1BJcjZqTnRCRHZpQnJiMVNI?=
 =?utf-8?B?OUJMQklIT3VSempsVGl1L2c4dSs5enRVbURoU0k1SU1CNk9iUkJzdWJkVzIz?=
 =?utf-8?B?T1VXMjhPMmFadjlSR1NTTkZ1SGJzak5JcHZRZVZHU3VsVVhDNnVOTTlJQXVL?=
 =?utf-8?B?Zjc3aWhFWDlXWUlEbVlsenozM3NMa0dPTlUzVGlQd0FoTUdzQ0w3aFJWOS81?=
 =?utf-8?B?K2owc21zamJaV0tobHhxcy9wNTloZjBvck1VczJxVklZWHNjV0ludXhzYy9B?=
 =?utf-8?B?WlV6S2s5a04yclU2MUdUbzltbzhwZEdYSVM4RGlhMEErWHJsMzNrNWdWdS8x?=
 =?utf-8?B?NFpMRzhKU1NTcUtMbXpBK3luU0cxU3Y4RUVLNmZoOFBnY0NWc0p5ZTE1WVd1?=
 =?utf-8?B?VUk3YkRaRFpSN295cjEwblVpYWlHVWY2VkhIT2YzeUdwY3d3andRQ2FxWXp1?=
 =?utf-8?B?Ui9DR1VldjVaV0dDcnhwODBGdU0ycUhlYVFtL3JRQzFCS0JPeG1ablptamxt?=
 =?utf-8?B?MzNuY0FZVGpzV3IzYmNmZFNoVWJFM3hja1VtanJUdWlMQmppRWZrM045QWpS?=
 =?utf-8?B?cnB2SnNoNnhlTGFlOWswZUFXVGREMnlyYTBkUkZpeGVZa1R2MGs5bTAxeFlm?=
 =?utf-8?B?Z1F2TkI1L2drTTNSdTNuMGcxRXFhYkZBTmp5NitJRC9VRnJNOStTR2N5Wms0?=
 =?utf-8?B?YXBCd1VzbHRLRkRRdU9XTHcvM1FqSVRXWWNOL0dSUVJSOGFCTjVhczJVRGl0?=
 =?utf-8?B?WXVQT1RVcG9aeFY5NklzTDJJdjdJdjkrWm9RMTFrVGpBRmFiUGdyMXk0UEtt?=
 =?utf-8?B?TjJkbXh2dGlIa3hxTW1rdWxXMTNSaDdORm9XSEVmTUNUbXVaSjZvSnp0K1dT?=
 =?utf-8?B?UW0xcUErOWkvZHVlM1RwZVRmZm13RUV6YUVNN3VlR0ZYRnhNbjAxaEc1KzU4?=
 =?utf-8?B?SnBUQUl3ME5GR3JqNjBaOG9Vc1JsSWlsckppM2E0OGdEUGdCRUwxZS9SU1lh?=
 =?utf-8?Q?jASJdCNt2nDpps+q4A?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FC1E1CEF7484449A9FCC534D64A1CDD@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fd2aef-9d5b-40af-dceb-08ded8ca9531
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:16:13.1199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhqJHD0XvuRP+4hBU17IPboJ/1xyhmcbPwRX6zzpNUIacd8F1jaxVZmiLzFlROPQHGD6SQqt9aBfGp98L2tSqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2430
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

T24gRnJpLCAyMDI2LTA3LTAzIGF0IDAwOjI1ICswMjAwLCBNYXJlayBWYXN1dCB3cm90ZToKPiBP
biA3LzIvMjYgOTowNCBBTSwgWWFubmljIE1vb2cgd3JvdGU6Cj4gCj4gSGVsbG8gWWFubmljLAo+
IAo+ID4gT24gVHVlLCAyMDI2LTA2LTMwIGF0IDE4OjA4ICswMjAwLCBNYXJlayBWYXN1dCB3cm90
ZToKPiA+ID4gU2luY2UgYjU3ZWQxNDc5MzljICgiZHRzOiBpbXg4bXttLG4scCxxfTogTWFrZSBv
cHRlZSBwYWNrYWdpbmcgb3B0aW9uYWwiKQo+ID4gPiB0aGUgVEVFIG5vZGUgaXMgYWx3YXlzIHBy
ZXNlbnQgaW4gVS1Cb290IHByb3BlciBmaXRJbWFnZSwgZXZlbiBpZiB0aGUKPiA+ID4gQ09ORklH
X09QVEVFIGlzIGRpc2FibGVkIGJlY2F1c2UgdGhlIHUtYm9vdC5pdGIgc2hvdWxkIG5vdCBjb250
YWluIGFueQo+ID4gPiB0ZWUuYmluLiBUaGlzIGlzIHdhc3RlZnVsLCBhbmQgcHJvZHVjZXMgdGhl
IGZvbGxvd2luZyB3YXJuaW5nIHdoaWNoIGlzCj4gPiA+IGFsc28gY29uZnVzaW5nIHRvIHVzZXJz
Ogo+ID4gPiAKPiA+ID4gIgo+ID4gPiBJbWFnZSAnaW1hZ2UnIGlzIG1pc3Npbmcgb3B0aW9uYWwg
ZXh0ZXJuYWwgYmxvYnMgYnV0IGlzIHN0aWxsIGZ1bmN0aW9uYWw6IHRlZS1vcwo+ID4gPiAKPiA+
ID4gL2Jpbm1hbi9zZWN0aW9uL2ZpdC9pbWFnZXMvdGVlL3RlZS1vcyAodGVlLmJpbik6Cj4gPiA+
IMKgwqDCoCBTZWUgdGhlIGRvY3VtZW50YXRpb24gZm9yIHlvdXIgYm9hcmQuIFlvdSBtYXkgbmVl
ZCB0byBidWlsZCBPcGVuIFBvcnRhYmxlCj4gPiA+IMKgwqDCoCBUcnVzdGVkIEV4ZWN1dGlvbiBF
bnZpcm9ubWVudCAoT1AtVEVFKSBhbmQgYnVpbGQgd2l0aCBURUU9L3BhdGgvdG8vdGVlLmJpbgo+
ID4gPiAiCj4gPiA+IAo+ID4gPiBSZWluc3RhdGUgdGhlIENPTkZJR19PUFRFRSBpZmRlZmZlcnkg
dG8gbWl0aWdhdGUgdGhlIHByb2JsZW0sIGJ1dCByZXRhaW4gdGhlCj4gPiA+IGJpbm1hbiAib3B0
aW9uYWwiIGtleXdvcmQgYXQgdGVlLmJpbiAuCj4gPiAKPiA+IEkgZGlzYWdyZWUuIFlvdSBhcmUg
cmVtb3ZpbmcgYSBmZWF0dXJlIGFuZCBjYXVzZSBmdXJ0aGVyIHByb2JsZW1zIHdpdGggdGhpcyBj
b21taXQuCj4gCj4gSSB0cmllZCB0byBhdm9pZCBvdXRyaWdodCByZXZlcnRpbmcgdGhlIG9mZmVu
ZGluZyBjb21taXQgYjU3ZWQxNDc5MzljIAo+ICgiZHRzOiBpbXg4bXttLG4scCxxfTogTWFrZSBv
cHRlZSBwYWNrYWdpbmcgb3B0aW9uYWwiKSB3aGljaCBpbnRyb2R1Y2VkIAo+IHRoZSBwcm9ibGVt
IEkgZGVzY3JpYmVkIGFib3ZlLgo+IAo+ID4gWW91ciBpbml0aWFsIGFzc3VtcHRpb24KPiA+IAo+
ID4gPiBldmVuIGlmIHRoZQo+ID4gPiBDT05GSUdfT1BURUUgaXMgZGlzYWJsZWQgYmVjYXVzZSB0
aGUgdS1ib290Lml0YiBzaG91bGQgbm90IGNvbnRhaW4gYW55Cj4gPiA+IHRlZS5iaW4KPiA+IAo+
ID4gaXMgbm90IGFjY3VyYXRlLiBZb3Ugd2VyZSBhYmxlIHRvIHBhY2thZ2UgT1AtVEVFIHdpdGhv
dXQgbmVlZGluZyB0byBlbmFibGUgc3VwcG9ydCBpbiBVLUJvb3QuCj4gPiBBbmQKPiA+IGFmYWlr
IHRoaXMgaXMgYSBwZXJmZWN0bHkgdmFsaWQgdXNlLWNhc2UuCj4gCj4gV2hlbiB5b3UgaW5jbHVk
ZSBvcHRlZS1vcyBpbiB0aGUgVS1Cb290IGZpdEltYWdlLCB3aGF0IGRvIHlvdSBkbyB3aXRoIAo+
IHRoYXQgb3B0ZWUtb3Mgd2hpY2ggVS1Cb290IGRvZXMgbm90IHN1cHBvcnQgPyBEZXRhaWxzIHBs
ZWFzZSA/CgpTdXJlLCBzb3JyeS4gT1MgY2FuL3dpbGwgdXNlIGl0LiBUaGVyZSBpcyBubyByZXF1
aXJlbWVudCwgdGhhdCBJIGtub3csIG9mIGFueSBib290bG9hZGVyCmludGVyZmFjaW5nIHdpdGgg
T1AtVEVFIGZvciBwcm9wZXIgZnVuY3Rpb25hbGl0eSBhbmQgaXRzIHB1cnBvc2UgaXMgdG8gd29y
ayB3aXRoIExpbnV4IGtlcm5lbC4KSSBndWVzcyB0aGUgb25seSBqb2IgYm9vdGxvYWRlciBuZWVk
cyB0byBkbyBpcyBsb2FkIGl0IGludG8gbWVtb3J5LiBJIGRvbid0IGtub3cgZGV0YWlscyBhYm91
dApzcGVjaWZpYyB1c2VzIHdpdGhpbiB0aGUgc2VjdXJpdHkgY29udGV4dCBhbmQgaWYgdGhlcmUg
YXJlIGFueSB0aGF0IHJlcXVpcmUgYm9vdGxvYWRlciBzdXBwb3J0LgoKPiAKPiA+IFdpdGggdGhp
cyBjaGFuZ2UgeW91IGNhbiBubyBsb25nZXIgZG8gdGhhdCwgc28gdGhpcyBjaGFuZ2UgaXMgYSBy
ZWdyZXNzaW9uLgo+ID4gCj4gPiBBYm91dCB0aGUgd2FybmluZyBtZXNzYWdlLiBJIHVuZGVyc3Rh
bmQgdGhhdCB5b3UgZmluZCBpdCBjb25mdXNpbmc7IGJpbm1hbiBpcyBkZXNpZ25lZCBzbyB0aGF0
Cj4gPiBpdAo+ID4gZW1pdHMgYSB3YXJuaW5nIHdoZW4gYW4gb3B0aW9uYWwgYmxvYiBpcyBub3Qg
Zm91bmQuCj4gCj4gUGxlYXNlIHNlZSBhYm92ZS4KPiAKPiA+IEkgcHJlZmVyIHRoYXQgYXBwcm9h
Y2ggdG8gbm8gbWVzc2FnZSBhdCBhbGwuIFlvdSBtYXkgd2FudCB0byBwYWNrYWdlIE9QLVRFRSAo
ZS5nLiB5b3UgaGF2ZSBhbgo+ID4gdGYtYQo+ID4gYmxvYiB3aGljaCBqdW1wcyB0byBPUC1URUUg
YWRkcikgYW5kIGJlaW5nIGFsZXJ0ZWQgdG8gYSBwb3NzaWJsZSBtaXN0YWtlIGlzIGltcG9ydGFu
dDsgTGV0J3MKPiA+IHNheQo+ID4gdGVlIHBhdGggd2FzIGluY29ycmVjdCBkdXJpbmcgYnVpbGQu
Cj4gCj4gSXMgdGhpcyBzb21lIHNvcnQgb2YgYSBib2FyZC1zcGVjaWZpYyBjb25maWd1cmF0aW9u
ID8KCmtpbmQgb2YuIFdlIGhhdmUgdGVlIHBhdGggc2V0IGluIDxzb2M+LXUtYm9vdC5kdHNpOiBm
aWxlbmFtZSA9ICJ0ZWUuYmluIjsKCkNvdWxkIGhhcHBlbiB0aGF0IFRFRT10ZWVlLmJpbiBpcyBz
ZXQgb3IgZmlsZSBpcyBuYW1lZCB0ZWUtcmF3LmJpbiBhbmQgdGhlbiBpdCBoZWxwcyB0byBnZXQg
YQp3YXJuaW5nIHRoYXQgYmlubWFuIHdhcyBub3QgYWJsZSB0byBwYWNrYWdlIHRoZSBibG9iLgoK
PiAKPiBXaHkgZG9lcyBVLUJvb3Qgbm90IGVuYWJsZSBPUFRFRS1PUyBzdXBwb3J0IGluIHRoaXMg
Y2FzZSA/CgpObyBuZWVkIHRvLiBNYXliZSB0byBjb25zZXJ2ZSBzcGFjZSwgb3IgYnkgcHJpbmNp
cGxlIG9ubHkgZW5hYmxlIHRoZSBjb25maWdzIHRoYXQgYXJlIGFjdHVhbGx5Cm5lZWRlZD8gSSBi
ZWxpZXZlIFBIWVRFQyBib2FyZHMgdXNlZCB0byBkbyB0aGF0IGJlZm9yZSBLQVNMUiBzdXBwb3J0
LgoKPiAKPiA+IEFsc28sIGtlZXBpbmcgb3B0aW9uYWwgd2hlbiB1c2luZyBpZiBkZWZzIGlzIG5v
dCBhIGdvb2QgaWRlYS4gQmlubWFuIHdpbGwgc3RpbGwgYnVpbGQgeW91IGFuCj4gPiBpbWFnZQo+
ID4gd2hlbiBubyBPUC1URUUgYmxvYiBpcyBwcmVzZW50LCBidXQgc2hvdWxkIG5vdCBzaW5jZSB5
b3UgZW5hYmxlZCBPUFRFRSBjb25maWdzLiBJZiB5b3UgZW5hYmxlCj4gPiBPUFRFRSwgeW91IHNo
b3VsZCBoYXZlIGFuIE9QLVRFRSBibG9iIHBhY2thZ2VkLgo+ID4gV2UgY291bGQgYWRkIGlmbmRl
ZiBPUFRFRSBhcm91bmQgdGhlIG9wdGlvbmFsIHByb3BlcnR5Lgo+IAo+IFRoZSBvcHRpb25hbCBr
ZXl3b3JkIGlzIGFjdHVhbGx5IGtlcHQgaW4gdGhpcyBjYXNlLCBpdCBpcyBub3QgYSBmdWxsIHJl
dmVydC4KPiAKPiBZb3UgZGlkIGhvd2V2ZXIgbWlzcyBvbmUgdml0YWwgcG9pbnQgLS0gdGhlIHRl
ZSBub2RlIGlzIHBhcnQgb2YgdGhlIAo+IFUtYm9vdCBmaXRJbWFnZSwgZXZlbiBpZiB0aGUgdGVl
LmJpbiBiaW5hcnkgaXMgbm90IHByZXNlbnQgYW5kIE9QVEVFIAo+IHN1cHBvcnQgaW4gVS1Cb290
IGlzIGRpc2FibGVkLiBCaW5tYW4gcHJpbnRzIGEgY29uZnVzaW5nIG1lc3NhZ2UsIGFuZCAKPiBn
ZW5lcmF0ZXMgYSBib2d1cyBlbXB0eSB0ZWUge30gbm9kZSBpbiB0aGUgZml0SW1hZ2UuIFRoYXQg
aXMgaW5jb3JyZWN0LgoKWWVzLCBmb3Jnb3QgdG8gYWRkcmVzcyB0aGF0LiBJIGRvbid0IHRoaW5r
IGl0IGlzIGNvbmZ1c2luZywgYXQgbGVhc3QgY29udGVudCB3aXNlLiBWaXN1YWxseSwgSSBjYW4K
c2VlIGhvdyB0aGF0IGlzIGNvbmZ1c2luZy4gSSB3YW50IHRvIG5laXRoZXIgYWdyZWUgbm9yIGRp
c2FncmVlIG9uIHRoZSBjb3JyZWN0bmVzcyBwYXJ0IGJlY2F1c2UgSQpkb24ndCByZWFsbHkga25v
dyB0aGUgZml0SW1hZ2Ugc3BlYy4gSGF2aW5nIHRoZSB0ZWUgbm9kZSBiZSBwYXJ0IG9mIHRoZSBm
aXRJbWFnZSBpcyBhIGRlc2lnbgpjaG9pY2UsIGFsbCBvcHRpb25hbCBibG9icyBiZWhhdmUgdGhh
dCB3YXkgZnJvbSBteSB1bmRlcnN0YW5kaW5nLgpJIGd1ZXNzIGl0IG1lYW5zIHRoYXQgdGhlcmUg
aXMgYSBidWcgaW4gYmlubWFuIGlmIHlvdSBzYXkgaGF2aW5nIGVtcHR5IHRlZSBub2RlIGlzIGlu
Y29ycmVjdC4KQW5kIHNvIGl0IHNob3VsZCBiZSBmaXhlZCBpbiBiaW5tYW4gaXRzZWxmIGltbywg
bm90IGhlcmUgZm9yIGlteDguCgpZYW5uaWMK
