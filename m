Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81A7C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 22:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3454C88B35;
	Fri, 19 Jul 2024 00:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ogga.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ogga.onmicrosoft.com header.i=@ogga.onmicrosoft.com header.b="i77MARXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBFD088746; Thu, 18 Jul 2024 21:40:37 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5E9388AD8
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 21:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ogga.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zli@ogga.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XI6Upzy2UkKVzwj/apatJlBvwnvW8mvsfOi3Ii8OdazUOl3RsrYuG9sDpJYpUyvBTukt1y4/qmTPaJY1Z1wmkLsS9sToDJ90st0VEx+Auc1+jSAIC79b7ESWoUhol9RE+crEyAY7Afz60n2A6K9k2ku/q2vwVf424lp7pJz1gQwOJQOadMq7qBa9Ka25Qq30HqABE6Ch0ZZ/RJe7AYld5vwuHhIqluO1nZ6F+NRgIoL3EdSR/4xIXbadWGpCn8YDgrUpjC+5tLP9zfBzwlFMGRSoESK/cjecwcrJe8cDhZEQg9dybUv/bMJ9nqNPdPiFABsNHaPd0zHZNgAezGNSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzGgdmuHidxw27ijwnOFdi98Ea7gxmPMV3JiUAZCabo=;
 b=wocvYaw4flNlWmiPGMj3/nfWe1DjqK05iGq7b4VcO7N9N9lUS8X0y0kgTRa/nkw4DgEwB0K7SsXnEQSJ7wHNM0H5BanfTW7cDRFpx7inAUe0iA2QZxbkj3AfBs9FpIQrztVjlK4QpM2k4PwFFO8hGLdY73ZPUsJop8EiDVBE8gy1zxsKJ+3wzHCXqde9hNx6tByLoysj/6gOIbzlcryPzCzUIEn5AJAU1ayefNnkb5qmKgh0qQqx+2e7aSLiSwmsaVKDQlmtf5p/hvSUJFWPDBe3EBFwJIT52/On+ZpMAJStlBLcFRzeYcL2MZH6jyF947PhjcbjiATDBC2RJMHfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ogga.fr; dmarc=pass action=none header.from=ogga.fr; dkim=pass
 header.d=ogga.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ogga.onmicrosoft.com; 
 s=selector1-ogga-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzGgdmuHidxw27ijwnOFdi98Ea7gxmPMV3JiUAZCabo=;
 b=i77MARXIerC3eGBgdGaCYqNeuAomxWeSFOFYm5SUuXMoFoxQk/c+sTksaTmtIj0uQw+PmC6qi3dY+kwxEvEGMLneo/5WU0LR1P0rmRCY5Whxu1g+OMOTzVfCkMIkfGaxlH0DQi+eFfeYd+pXbLUC25vPtkMqAArRkD/bbeRLGmU=
Received: from PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::20)
 by PAZP264MB2766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 18 Jul
 2024 19:40:34 +0000
Received: from PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ead1:fb5b:e337:d4ff]) by PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ead1:fb5b:e337:d4ff%6]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 19:40:33 +0000
From: Zixun Li <zli@ogga.fr>
To: Alexander Dahl <ada@thorsis.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, open list <u-boot@lists.denx.de>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Subject: RE: [PATCH] mtd: nand: raw: atmel: Use ONFI ECC params if available
Thread-Topic: [PATCH] mtd: nand: raw: atmel: Use ONFI ECC params if available
Thread-Index: AdrSTW6mmB6pXteCRRSkKoT1NBAEcAATWGAAAauShtA=
Date: Thu, 18 Jul 2024 19:40:12 +0000
Deferred-Delivery: Thu, 18 Jul 2024 19:39:29 +0000
Message-ID: <PAZP264MB29745BAD4E854E1884E5A9CDB1AC2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
References: <PAZP264MB2974E713F54A40AB9B17DB85B1DB2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
 <20240710-talcum-repent-307fd836d683@thorsis.com>
In-Reply-To: <20240710-talcum-repent-307fd836d683@thorsis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ogga.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAZP264MB2974:EE_|PAZP264MB2766:EE_
x-ms-office365-filtering-correlation-id: f400d659-6b49-42f8-fbbc-08dca7617d0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L0ZyOUJPL2lYNW1zSng4UFpxR3VlbVIvZ05WM0JMMDVZV2RKSlhla3g1dTBz?=
 =?utf-8?B?SFAvUjVXMXVMaFJRb0hpRE1UZGxHVDQ4YUZPaU8zdk5DV09YQ21LMTJJdDhO?=
 =?utf-8?B?b2FaRHpQSER4WlJ6VHNERGlnUmJCOFJ6ZnBNUG43MTFCSUpHdlhQNHJpdFMw?=
 =?utf-8?B?MnJoeExNTldzdTNOZUQ0eG5MeGRZSmRCaTJyUmg0dGh4UW1oUFFtdVAySXVa?=
 =?utf-8?B?L0xhTzRzd2hrWG1WTnJjN2Z4ZzdzdG5QNTdLNUpiQ3R5eDl3TDF6UHVoeXkz?=
 =?utf-8?B?Y3ZpQXVPNVlGU3JpUnY1WG4xaHhMWitXWUFzTVFEUkR4cEdvTWRLSUtXYVNH?=
 =?utf-8?B?M3o5cVBZeXdMTmd0RHlkK2NLUytyVitDazBWOWg3Ylp6azFjc2hodU1waitI?=
 =?utf-8?B?S3pOSExIZTRLUHRqaHIvUnhjMVJiV011RmVsN1pCbVVkL2dhUUZ2aFYvMEFp?=
 =?utf-8?B?Uit1TE4xVVptaEJiV2tzKzEyNys4RnZ0U2xCc1BsQVJ0TnFEY2FCN0tMejhl?=
 =?utf-8?B?MXM4d0pIQXE4WGxyYXJLL0lXeGpDSVZuMlN4a0t5TlZwdjNMazZvSU1NR25U?=
 =?utf-8?B?ME9UKyttQ3NYbU9RTk1WREc5cWRFdEIxT3huSjlPdFYvM2RZMGhwb0pPa2F2?=
 =?utf-8?B?N0Nrc3JFaVlQczQ1VjAyR28zNWFEZDRwbC9pQmE1MHRMenJEZ1pZL3VTdW1p?=
 =?utf-8?B?dzlKRGE2WHBKeS9jYUkzMDJ1TElHbTVrT0F0WWo3U3Q3bzJwRklOVWwvRGQz?=
 =?utf-8?B?dUNsblRqQ0hvb0JYckpML0xUWXJOb2NMRklROEJmRXIyaTYrcXFWRTF1UmZx?=
 =?utf-8?B?dmEwcHFycWErUWhtdWJiSnIwckg1azdTQk9KM3NvaEYyWEJXRlFCMXRDb1Bh?=
 =?utf-8?B?S0hva01RWnhXWUVUWWFIY0l3MGY3RkVtNm92WGs4WlBsU3EzMk5jNExEd3hn?=
 =?utf-8?B?Q2kwSVRVRVVwMEp5Yy94dDQ0Mkg4a0NCNEcwZDlzYzlXSktCSU1Kc0MxM3NU?=
 =?utf-8?B?eUQrbUhIZHByZTFNY3Z4TGwzRnNudWdYNExEUEVLSXFNZDZLcFNTY05rTS9Z?=
 =?utf-8?B?ZmcyNHMveU9NaXVXZHJTWEhGeWZQNVVEVG54VDA0NVZDNmF4c3BBY2NBcVJE?=
 =?utf-8?B?TlE3Nzh3R3MxUWx4TUxCY3ZiYUpITUdFMG5VN0ErZlM5dXVjZ3lGK0gwcnNJ?=
 =?utf-8?B?M3BEWnB4K0wzTnNVR2VQbGtoSVA0WkdjeVdhVmc5VTFEZS85a0NpL0lwendn?=
 =?utf-8?B?dm1UdEZNQnN5NUxkcjIwQ3BLaVhWK1ZXZ2oxemQyOUdSbHE5VGNlVm1zbisz?=
 =?utf-8?B?ZkdFMG1QQmdVWld6WjQzSTc1WDdLS0N1VHVuSVVyaVlnQzBWWkFyT0VrY2NI?=
 =?utf-8?B?aWd1bnA0Z3BBN0M5dG0reVJwM0E4RGpFVkNud2FLd3g3OFo3ZUg4dVBDeXhs?=
 =?utf-8?B?clhtdEZ0cEtWWHJVaDFQa2NVQ3RTZHJ5ZlBrMnlnT2phM1c4WHg5VWpGK3RZ?=
 =?utf-8?B?ZDZrNmVJZ3MvdVExT25tSGkwUSs4aTNuS3N3NTRsTDYzNUIzTU5YbnZaMENM?=
 =?utf-8?B?VnRRaTBZRk1SbVBYOTMxa0tTNytVK1VxVEJWSWZjandkU3BRODZ0cTU3d0p3?=
 =?utf-8?B?ci9GdnB6M2F1cDF2eHVQeUpsbGNwNjdTbDR6Q2hWRGYzSGNybG9nYTZvQmhx?=
 =?utf-8?B?Z1lTakJTWnN0V3lCWUQrMmJsc29aelFJK0x5R3FINHBiOW5xTXZtd2lNNHNr?=
 =?utf-8?B?d0hWYXJmYytRaVlmK0lxS2tCajlaOVRtZmI1MW1XK1lxSWlTUm5DdGRFcGpK?=
 =?utf-8?B?ZVJCVHJEWFVSYnRxT2JKOFVUVnJGRDRVZ0lCQ3lqOG9PdmtPV1Y5d2o2Vk9H?=
 =?utf-8?B?VDY1U2drbjhLb1hsbXNucmdlMGhSOFZ5VHorUWk0VS8yd0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rllla2RDenBnQ2JzQTdjVWdEdDJ6b2JPWmNkdGRsOUt5c2JTaEtwU0tETFJR?=
 =?utf-8?B?MURpTEpETGdMK21aMFVNRk9rN2xvTHk3YkxZVmcweTdSSjRuV0RxRSsySzVV?=
 =?utf-8?B?azVuU0ZweE5CN29UdHhQQkdQdVoxMW9SanpsSytSVDVTYkRGajNVWlY0dWVV?=
 =?utf-8?B?Yng1V1grbmJmR2EyQlJ0OXBkZkZFYTczWHB6bE5DRzZ1aSt0UDVtNm5PRkFn?=
 =?utf-8?B?cnBlVmJtaVM1OGZJb0I0Y1hiOVZzRklKZ1R1ZVhsQ3RJS0tMYkMrYUNYVmhl?=
 =?utf-8?B?K0hoNERNSGM4b0xqeG41RWcxZDRza1l2RGEzVlRjTzNKVGdFSTg4cmdmWE5T?=
 =?utf-8?B?RXBuSVFIVHZGWWN1Sk1nSUsvdFZZR1h5eXVCQ0F4a3VjSjJUTStmYitNbUZG?=
 =?utf-8?B?VUtMVVFxdEs1VHdzKzl3Y2RBS29DMHkvOWN4ZUp6VFFpMkg1L3FDa3ZDaDRq?=
 =?utf-8?B?TUIwL2plbmM0aWZ5UG04NkoyQjl0Z0d5MVlWdkxzc3VBbUZqYmFPcWRVZUw0?=
 =?utf-8?B?NllPZ21tRStqNVovZDQxQ04xK3Y4a1cxeTZEZ2dOanlkRlR4SjN5WTdPcWdw?=
 =?utf-8?B?aFJFOStEY1lkR3QzeEpnYVNqVm9XY25MN1RtQ0RRUXJ3cDlwcHNCT1U0WG1L?=
 =?utf-8?B?VERiTURzZnBxejRsUDFJT2tFWFdWaGN3Rm5tcmlDUVg4aGh3K05XU3FKS1FZ?=
 =?utf-8?B?OXp2ZHBoTktJcDBSQ0k4YWl6dnJNWFFGeG9GRGtHMCtlWUJqOGRNR2NLTWQz?=
 =?utf-8?B?SmRCY0RFSklzVEhubkxTcVdGVUlSSkNVZ1JvMjh6RmYwVnZrbzN6TElURExQ?=
 =?utf-8?B?c3cvcmVBeVllL3NhQWY0YWNZZXVlenBOdmg3azhoaXk2L1QxSWhYMU5mYVNx?=
 =?utf-8?B?VVBWY24xSm5GMC9CM2NxczI2ZHowMnQzMmJCOWpvZnFWb1hobTViS2x4WEFW?=
 =?utf-8?B?bFdYWjdHeU91OEZiS0lQcDZJMmhvalFHY0pWclNFZmQ3RlIydWU4YS81Mndm?=
 =?utf-8?B?dWU0ZHNRSldVYlo5bTBvQzRqK3ZCbDg3U0hFOEJrMDNDWnU4VkM4N2VsSkE0?=
 =?utf-8?B?bE1CNUxwZktnL215S0J2RkhiTG50OTJXWm4wK25yY1QvMFBLU0srSmhFYWI5?=
 =?utf-8?B?K0JJVEw0M1IxWEZFT0t6emhLcm9RUDFCdDhTMHZtRml5Mnc0MFFWekJyRDI0?=
 =?utf-8?B?WW5sQnUvbS82cWo1Nm5mVE94NmtGNUlpdTNKRENEZzl6U0NzSjdtSmVpMDBS?=
 =?utf-8?B?bzZoSWlxZGFFZHNDQWppWmZZZ2o4OW9MZk1ndEpYVEhQbmxvNHpkNHlVTG5L?=
 =?utf-8?B?Y2IwUkwvY1FVaWU1dE90RVpFcE5RVE1BSHlCWGd5cG54ejRXeHYwL01LUUdw?=
 =?utf-8?B?YjkyWGpaWkptVW5od0tQanIwY1pBSHBSY1ZDVGo1Z2NqZFJGS05CbVBwSEsv?=
 =?utf-8?B?d2V0K0t6TEc0ZlY4eGloZlJYRXIyQ3YzWXlOdG1OeXRxUnJVbk5ucStCdG9w?=
 =?utf-8?B?UTZDUE9KL25STFF0a0x1a2dEY0VUYTVaSk9BVU5JMS90NHNNYS9VTzBpSENU?=
 =?utf-8?B?MUNzZnlKbHVnRkxWbStsZG5KRHdpalBXK0lYamdFQm02dU1xMUxWb092d0w5?=
 =?utf-8?B?ODhuaVp6VllIYzVHeTNtS015dCtSNkpRMGV6NWdVYmJlNjBINTdXSW1pVlpL?=
 =?utf-8?B?WnhtRWZ4NjZ6ZkJUcURydnlmV2tDRkxXYm5rK1F5MnVranVMdjhUVlE0cC9u?=
 =?utf-8?B?MDJyVlIvUHR5OWFVVUJ3MzVJSDBQS3dJUTd5MzRQSnZuUGM2amFGOE1OL1l4?=
 =?utf-8?B?UFMxM29DaFhDMThBdEp0ejVhNmt2aExLVlVGdkhKdGYrS2hka2w1cVZqK2V6?=
 =?utf-8?B?cFA0RzhoSC8xYlljWjJ6ZFFkMzE3OTQwZ0RUcXYwNktMaGpHaGJUVmw1cGtH?=
 =?utf-8?B?WFB1K3M1QUV3OE9QRmRKYm1abmxYVDI4cFJta2lOWUhVU1lNYmNwRXRSM1d4?=
 =?utf-8?B?NG1XWEt2cGdzYmpNbG1pUDVVcmR5NHVPS0M1Z1RhSkw4TFl1L21hQS8yRUZ4?=
 =?utf-8?B?ZHg5SnAvRGFPREU5MWJlSWluU1lxa0toa1hiT09QeGsvaStPQWJiQVBrR2Vm?=
 =?utf-8?Q?WbpE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ogga.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f400d659-6b49-42f8-fbbc-08dca7617d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 19:40:33.0818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a737871-c9db-44dc-a24e-55df547c3098
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zErmSGeZ0lAAkC/S57F1kq13WVku7Y0Mqgyxie4VCmZFGgVVphUT9Qr3SPrXrR8g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2766
X-Mailman-Approved-At: Fri, 19 Jul 2024 00:14:18 +0200
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

T24gMTAvMDcvMjAyNCAwOToyOCwgQWxleGFuZGVyIERhaGwgd3JvdGU6DQoNCj4gRGVzcGl0ZSB0
aGUgbWlzc2luZyBzcGFjZSBiZXR3ZWVuICdpZicgYW5kIHRoZSBvcGVuaW5nIGJyYWNrZXQgKGNo
ZWNrcGF0Y2gNCj4gc2hvdWxkIGhhdmUgdG9sZCB5b3U/KSB0aGlzIGxvb2tzIHZlcnkgbXVjaCBs
aWtlIHdoYXQgZ290IGludG8gbGludXggd2l0aCB2NC4xMQ0KPiBidXQgd2FzIGNoYW5nZWQvcmV3
b3JrZWQgbXVsdGlwbGUgdGltZXMgYWZ0ZXJ3YXJkcy4gIEkgd29uZGVyIHdoeSB0aGlzIHdhcw0K
PiBub3QgcG9ydGVkIHRvIFUtQm9vdCB3aGVuIGludHJvZHVjaW5nIHRoaXMgZHJpdmVyPyAgSW4g
NmE4ZGZkNTcyMjBkICgibmFuZDoNCj4gYXRtZWw6IEFkZCBETSBiYXNlZCBOQU5EIGRyaXZlciIp
IGl0IHdhcyBjbGFpbWVkIHRoZSBkcml2ZXIgd2FzIHBvcnRlZA0KPiBmcm9tIGxpbnV4LTUuNC1h
dDkxLCBzbyB0aGlzIGZlYXR1cmUgd2FzIHByb2JhYmx5IGRyb3BwZWQgaW50ZW50aW9uYWxseT8N
Cj4gRG9lcyBhbnlvbmUga25vdyB3aHk/DQo+IA0KDQpIaSwNCg0KU29ycnkgZm9yIHRoZSBmb3Jt
YXQgaXNzdWUuIElzIHRoZXJlIGFueSBjb21tZW50IGZyb20gbWFpbnRhaW5lcnMgPw0KDQpJJ2xs
IHB1c2ggYSB2MiBpZiB0aGlzIHBhdGNoIGlzIGNvbnNpZGVyZWQuDQotLQ0KWml4dW4gTEkNCg0K
DQo=
