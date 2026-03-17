Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0FFF33806
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 06:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78C4F83FED;
	Tue, 17 Mar 2026 07:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="uh8SiEjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ACE084020; Tue, 17 Mar 2026 07:41:46 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9E1D83FE9
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXj7j71GLlQ+FOx/8iIjc24EBfT+zHajD19xqr0TKrPuW7IkCjDOzaiSa0mXzlWt375gvKeeY3wkWZJF+1SbgUeKvrQQYlCvTYCQ6b38bNrWEx/OY0GJ9U2OZ7PGlQmj/TH87zmBJW5BFBT6Cmv3gGWjC1NkxSuEJv8HVTP7vI8GgvP4KUVMzYpN12dI3fH4LmehMkrQ+7sz0Kb1X+tlL3F3DGjEQSJ9xCTr5mp8bzE0CggCXJTm2J21j1JiYXsA9zW5YOsb3LbmzhLneUAefWqu0GVPYUbpESWC75foFvnsomyrE8/P3WoGDjwgztrQp4szoUGpNT1L+gAM5eInEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7YPim+UMkoETWpqEQVlvoeHDkrC9+QAgBdH1hOLMV8=;
 b=IUayJSJddVFe1BB424LO/+ZfSJHc1BggFQdzzGtJtrn47utVshoJ44mVRtWLcaWNvPwDogD2Ty4zriWtUIps+J6/geuuZU3RyCSsbEEl0/7IkHpP6bGcRmslJncI8QuoygtINNhXxfLUE+WSD5ybbozYIPkNkZJrNnXFm5B6zcWJAkDYTsHvdt+OMV96Ww7jeZ0/WntdK46L7zro0xgKCo4VG2flrDHQcNTY8Rv+Z4XOAVNskJXYB5YIARvSCkbhMO2tDOrON3NrZahgN3PliDOwSwAkwq/ElZm2zhJejSqKtyWOqNYTPxXBKteLM5ai8TBpNWzcF2wW7fgiC8vr7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7YPim+UMkoETWpqEQVlvoeHDkrC9+QAgBdH1hOLMV8=;
 b=uh8SiEjCznMRRtQwYtzKC5SPErCikkTW+EJocAN+fcsUsXmkGX4xnDrgAk/0Bl3KNbij07Nn0JELIo497f+IoLrwdWXRQRwOrasPVXMo30PHz9r4oQO25zhuWSixupUDR/kyoEqMdXmYLXpLnhjS7jBXdM6TAKJT+90XW+aK9Y1+TYIbAIAUDe7OtQya2OwIdiJw5B1UH1o+++rSoXlWWEIzGANdriSOHj88ZJE0YsrriO0EPFCJ6Edzt+/u2+uWDyZ8v7UEZnUrKU42pKRTP7LSTDUcV0YNwxmGSNd/ejwepc0BNHLkF4VGx3QbAFg4G29IWbxyDwri+0FgEOqm7A==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by DB9P195MB1828.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:39f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 06:41:35 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 06:41:35 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>, Ye Li <ye.li@nxp.com>
CC: U-Boot-Denx <u-boot@lists.denx.de>, Alice Guo <alice.guo@nxp.com>, Tom
 Rini <trini@konsulko.com>, Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: OPTEE on i.MX8MP
Thread-Topic: OPTEE on i.MX8MP
Thread-Index: AQHctbLnUrshubmV60aSzY4elLVg57WyRsCA
Date: Tue, 17 Mar 2026 06:41:35 +0000
Message-ID: <4e42b1c5ea6ea728c84ba1a8d48f48ae55780332.camel@phytec.de>
References: <CAOMZO5D3yqFaDgriO2x3fnCrwGm0oV-chLsy3eOR2O3yg_MvNw@mail.gmail.com>
In-Reply-To: <CAOMZO5D3yqFaDgriO2x3fnCrwGm0oV-chLsy3eOR2O3yg_MvNw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|DB9P195MB1828:EE_
x-ms-office365-filtering-correlation-id: 652c31a6-85ae-48b3-3587-08de83f03c04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: nAQHeFWA4Bu8DLvV5JSuCIxqVqDwpZPj0tCBvmqBPtUqKRnJx2CG05/FKH7bcwVQ7u5nf1qkCAwCDFapDoRsv3LbfFHmA6Wbhk9ZAB+4ucxjQurfQJeta+l5DjaUrY0yL8dBDWjTrNHlTLRxbpJ1AVabmc+TeMZUgsmKU7M1yRNQjTxa7jv5iES3Jn53V4lTkmivgzAGen2i030RLe1Wu2kR5L7lbvaktmU0D0Pb/FM5W2KQasBvDcC8ilKi8xZOUg8jrUfRXYwnd+9tZUqrnsRAHvB2Rk+La6cexVkXCX8szlG5+rKIHvBIw+wjjKysgDE6ub+rQ2J9zP7XZaawOH69Ef+2zVgbRmpS0Opm1oI1/ZOWqgXkkDQ2H7MJIPq1HuOAgQU/eUm1xIBfXlNRFiALMR6fcsx0AgwsXwG5copG8jq5KPyl8gH5K5v+7Uq5FYdkWNJl+5KLVv6Mv55Ow2wxi5yoIh2+rDdEitcHM5JRPvaW8JiDWYHg1rPsGSaU2h4q9e2ZTt7gw2CJLWtHc/sH2qa6FXjw8EQVauzuaaYQBQzRFHclA0AsOxORfjlKjU8UO41m2jvB/h5T2Y5wODlEZuVufqGzt7xbRJBbHVMo+v7FFxRpfRfMww3ENKNs+eoxXK3Qphnk4yCfG67ZfKOYPNOImLqcoPNR07rxlZmL+pQ7tJaTnKz3PQC7wBl5v3XW/zOPNuphn0kotlfKE2LDu+aOfsoLW4GiSLc5Ox3larH7+i35duo67qdvTtM0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0tDWThDdWVZUlBWN3pmd2g5b3ZsdVk0elhOdU5yZGFLRGQ1QVdIQTdWZHNM?=
 =?utf-8?B?TmdOY2hTM2o5YTZma21iMStiOEdDQ1Y1WnV2dllZZnVnOGRpYzVScHN0b0Fw?=
 =?utf-8?B?dEdoOW9mVG1Na1diTkZlTDlLUWVVcEtVSUJadjBnWlpCTUpUdlIyb2dBZ0lV?=
 =?utf-8?B?Q0UvKzJoQkJuM0lWYzNlMWxHRUFDK0pBSEh5TTVvQWZWYWRLMXJIVWhVeCti?=
 =?utf-8?B?SFhBSVVjcExSWU8vaVhBdEZtak1zTWtxMFRqKzRZWWlGWHBOakRYaURkd2Qr?=
 =?utf-8?B?SEZhTWM1aVN5amYrV29KOU9zWCtFNUhOQ3B1RWZhNlpvV3B6VkVuWGFpMkdW?=
 =?utf-8?B?VjhIdjIxMFNQT3NqQWxzZkV0MG45enpuR25kRWZldXZ0eXA0b1Jzdm1YN3Ft?=
 =?utf-8?B?OE4rUGxvWlliTjNQU1oxaVpnb3RzdW5EQjV3aHEzY0NHZ1hSTG5yVGljY3dN?=
 =?utf-8?B?VlZDVmd5bXIzWldGYkVPaWdUdHJzNHdqb21PMHQ4YlRPZUJZaWgvY0dHWHM2?=
 =?utf-8?B?TjVvenBOZi9IU05qMW5lb2Y3dng1L1gyaDJaWTNDTTA4QVhVT09hWUhUQ3VH?=
 =?utf-8?B?V055SGpKSllMa3czaHlBcUtvTUFyT094dWRLNTBQYWtRTFNPSHAvYVM5RTVZ?=
 =?utf-8?B?ZDB6UjJMeFJvTUJjVm81WmVxcHNGNDg1ZitlRHdHbjJ0cWtmRmkwNjBFQWlE?=
 =?utf-8?B?MG54aUs1SkEzaklZcFlxSDBGUkNwQ2ZURmVJMFVlVkU5SnZpKzJ0VkN0Q05x?=
 =?utf-8?B?ZWp3QXQvS0ZKYjVTbXdzNDg2YzFSTEJ4WE10KzZveTdSNnRvbHUwblJ5dXhO?=
 =?utf-8?B?TTc3VStveUNHOHhHNGVaMk1PVTlURWNTd0QrWkJvTzNPQlM0ZjFuMkJqRXVJ?=
 =?utf-8?B?dmtSTGxYWW5LTVR6ZVRrZmxDMWxhU05zOEFSaTA3RHhnUlJtVzdiRzJNYUpw?=
 =?utf-8?B?TmxUL1Voeno5V21vUzZibFIrcnpON0FQK3hxZUFFcU1Pd0Q0d2N1VDRYUXEv?=
 =?utf-8?B?WEozd2JwQTJoVEZJMkFJR2RzVU80UndwNHZ1K1ZsUGFlRVFoMDNibkVEdkNX?=
 =?utf-8?B?S2ZNVnVjOWlFUTIwN2E0TWpobDFWa2tHQW5pZHBaclBLN0VXS2JHSHJhTGxs?=
 =?utf-8?B?ODlwVE5Pamp5Y3BtQ28vSFdFbzl5K1NibkxoN0w4ZjJBb0hpRFYyZlpDdlJ3?=
 =?utf-8?B?d1BiN2Zvbld4WjI0djFZT3gyU0J3a29qTTB1ZzliL2Vlb3l5NlZGbHYvUkFN?=
 =?utf-8?B?M0RQRGNoRm90a0ZYa20vQXg0M1pnbFpYSUJSZzlHMVZreVZ6Tlo3R2JuUVE4?=
 =?utf-8?B?bmlyN0pDbjQzdzRGcjVDQ1gwV3dWbXdwcTdqU0s2bllJRnpNVFd4RVRoazVX?=
 =?utf-8?B?NE40Rk5kcHY2OThoZG1EWDBGVXZ2eE9Felg0VVQ5WkxqZ2kvOWVLQmNteHBC?=
 =?utf-8?B?OC95azdZYkYxUFJCV2VVNURnTHRLRC9BNTdOMnlaWWduVHoxL1ZjMWJDSWti?=
 =?utf-8?B?QnN1QTM2aTR5cTIzSWxjKzA2YjhZREF5bmpyTDBrQmtDL2RDNjcrYzBxSUdj?=
 =?utf-8?B?SXk1dzRsQU1JL1M1eWM0WmpPTDVuUUhzek0vYWwyUUVDWXVKb3dYUzN2UUYy?=
 =?utf-8?B?dDFka2xzaXVoQSttUTFwOU13TmFWMDFpQ1VoM09TZWt4WmpNOGNtODd3MDFi?=
 =?utf-8?B?V29oeWVPT3dMbC9SZE1ic2F2QjRMbHA3YU5lZHRtdmhIcEp6WUNnZy94a3BO?=
 =?utf-8?B?eHhIMCttN00rV2VNMDhWdTFPVkN5aVpYUUJUSDdrMkU0RGRTT0xTRkt6K0gy?=
 =?utf-8?B?VDliSjRINjlmUHZ0b3p3aEVmMnZhcktjVmp3b3VPc3BZT1h3N1RpdWUrUjRV?=
 =?utf-8?B?ZXNycW1oU2xOYjBMdGdZdkhWVTB3WFdHRGtYcVRONkFuN3dxelFQRFBCSlNY?=
 =?utf-8?B?YXllajBpRjZ1WFVreDdzUkNleThLV2cwZG1FWm1RUGZna1JXamFNanBtcXdR?=
 =?utf-8?B?V0FSNS9Sa3VEVW9MU3VJeSt2NnluWlNxd2NabFVRazhEdWNoSGtaL2szWTly?=
 =?utf-8?B?ZWVJalVsR05aQUMzSU1RQ0JKTEVRdDh6M1ZGOVFLdkVIQk85ZTE0TTBBWnV3?=
 =?utf-8?B?VldEcENrQXc4dWZONkU5bVN2YmZud2Rpa091cVBHcHE1aHJKZ2hiVlhGVVZQ?=
 =?utf-8?B?aUJ2UVNiOVBNczNaM05wMjltbnVQMlgyK24zUyttUi8vei8rYnpXNHVkajB6?=
 =?utf-8?B?eU5kWlpwcVc1M1BGUk9ON0RMUGptNDFvb0hvVmVqUk1OUUxic3VNcWtia1Ba?=
 =?utf-8?Q?rKooXr5ZPiFRvBx9UL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F18CB44AF25A04894836BA7573B1231@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 652c31a6-85ae-48b3-3587-08de83f03c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 06:41:35.5239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TABMXriojxpeD0ZtxCtiY03nXUheljWranpdRUCpcXpRW0d2iKckvUjvJpSX2ZxF7jjHAz71SThBzYr62RzFMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1828
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

SGkgRmFiaW8sCgpPbiBNb24sIDIwMjYtMDMtMTYgYXQgMjM6MDcgLTAzMDAsIEZhYmlvIEVzdGV2
YW0gd3JvdGU6Cj4gSGksCj4gCj4gSSdtIHRyeWluZyB0byBib290IHRoZSBpbXg4bXAtZXZrIGJv
YXJkIHdpdGggT3B0ZWUgc3VwcG9ydC4KPiAKPiBURi1BIHYyLjE0Cj4gbWFrZSAtajEyIENST1NT
X0NPTVBJTEU9YWFyY2g2NC1saW51eC1nbnUtIFBMQVQ9aW14OG1wIFNQRD1vcHRlZWQgYmwzMQo+
IAo+IE9wdGVlLU9TIDQuOS4wCj4gbWFrZSAtajEyIENST1NTX0NPTVBJTEU9YWFyY2g2NC1saW51
eC1nbnUtIE89b3V0L2FybSBQTEFURk9STT1pbXgtbXg4bXBldmsKPiAKPiBUaGVuIEkgY29waWVk
IHRoZSBibDMxLmJpbiBhbmQgdGVlLmJpbiB0byB0aGUgVS1Cb290IGRpcmVjdG9yeToKCk15IGd1
ZXNzIGlzIHRoYXQgeW91IGNvcGllZCB0ZWUuYmluLCBub3QgdGVlLXJhdy5iaW4gWzFdIHRvIHRo
ZSBVLUJvb3QgZGlyZWN0b3J5LgpXZSBuZWVkIHRlZS1yYXcuYmluLgoKWWFubmljCgpbMV0gaHR0
cHM6Ly9vcHRlZS5yZWFkdGhlZG9jcy5pby9lbi9sYXRlc3QvYXJjaGl0ZWN0dXJlL3BvcnRpbmdf
Z3VpZGVsaW5lcy5odG1sI2lkNQoKPiAKPiBVLUJvb3QgU1BMIDIwMjYuMDQtcmM0LTAwMDA2LWdl
ZWZiODIyZmI1NzQgKE1hciAxNiAyMDI2IC0gMjI6NTE6MDUgLTAzMDApCj4gV0RUOsKgwqAgU3Rh
cnRlZCB3YXRjaGRvZ0AzMDI4MDAwMCB3aXRoIHNlcnZpY2luZyBldmVyeSAxMDAwbXMgKDYwcyB0
aW1lb3V0KQo+IFNFQzA6wqAgUk5HIGluc3RhbnRpYXRlZAo+IE5vcm1hbCBCb290Cj4gVHJ5aW5n
IHRvIGJvb3QgZnJvbSBCT09UUk9NCj4gQm9vdCBTdGFnZTogUHJpbWFyeSBib290Cj4gaW1hZ2Ug
b2Zmc2V0IDB4ODAwMCwg77+9Cj4gVS1Cb290IFNQTCAyMDI2LjA0LXJjNC0wMDAwNi1nZWVmYjgy
MmZiNTc0IChNYXIgMTYgMjAyNiAtIDIyOjUzOjMwIC0wMzAwKQo+IFdEVDrCoMKgIFN0YXJ0ZWQg
d2F0Y2hkb2dAMzAyODAwMDAgd2l0aCBzZXJ2aWNpbmcgZXZlcnkgMTAwMG1zICg2MHMgdGltZW91
dCkKPiBTRUMwOsKgIFJORyBpbnN0YW50aWF0ZWQKPiBOb3JtYWwgQm9vdAo+IFRyeWluZyB0byBi
b290IGZyb20gQk9PVFJPTQo+IEJvb3QgU3RhZ2U6IFByaW1hcnkgYm9vdAo+IGltYWdlIG9mZnNl
dCAweDgwMDAsIHBhZ2VzaXplIDB4MjAwLCBpdnQgb2Zmc2V0IDB4MAo+IGxvYWRfc2ltcGxlX2Zp
dDogU2tpcCBsb2FkICd0ZWUnOiBpbWFnZSBzaXplIGlzIDAhCj4gKioqKioqKioqKioqKioqKioq
KioqKioqKioqKiogVGVlIGltYWdlIGlzIG5vdCBmb3VuZAo+IE5PVElDRTrCoCBEbyBub3QgcmVs
ZWFzZSBKUjAgdG8gTlMgYXMgaXQgY2FuIGJlIHVzZWQgYnkgSEFCCj4gTk9USUNFOsKgIEJMMzE6
IHYyLjE0LjAocmVsZWFzZSk6c2FuZGJveC92Mi4xNAo+IE5PVElDRTrCoCBCTDMxOiBCdWlsdCA6
IDIyOjE5OjIxLCBNYXIgMTYgMjAyNgo+IEVSUk9SOsKgwqAgRXJyb3IgaW5pdGlhbGl6aW5nIHJ1
bnRpbWUgc2VydmljZSBvcHRlZWRfZmFzdAo+IAo+IAo+IFUtQm9vdCAyMDI2LjA0LXJjNC0wMDAw
Ni1nZWVmYjgyMmZiNTc0IChNYXIgMTYgMjAyNiAtIDIyOjUzOjMwIC0wMzAwKQo+IAo+IENQVTrC
oMKgIE5YUCBpLk1YOE1QWzhdIFJldjEuMCBBNTMgYXQgMTIwMCBNSHoKPiBNb2RlbDogTlhQIGku
TVg4TVBsdXMgRVZLIGJvYXJkCj4gRFJBTTrCoCA2IEdpQgo+IG9wdGVlIG9wdGVlOiBPUC1URUUg
YXBpIHVpZCBtaXNtYXRjaMKgICoqKioqKioqKioqKioqKioqKioqKioqKiogVUlEIG1pc21hdGNo
Cj4gLi4uLgo+IAo+IEFueSBpZGVhcyBhcyB0byB3aHkgT3B0ZWUgZmFpbHM/Cj4gCj4gRG9lcyBh
bnlvbmUgaGF2ZSBPcHRlZSB3b3JraW5nIG9uIGlteDhtcD8KPiAKPiBUaGFua3MsCj4gCj4gRmFi
aW8gRXN0ZXZhbQo=
