Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CCAC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33F838804F;
	Wed, 20 Mar 2024 15:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="MlB5zXOR";
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="Y3IA1wDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29C0B8804B; Wed, 20 Mar 2024 15:09:18 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A427C88048
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:09:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1710943754; x=1742479754;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=G91lhaHoSE0hDcxlXbknIqIHpi0mfr+O1UoA8av/gLI=;
 b=MlB5zXORdzZaEnByJWpS8F/4VugPZ2aePT+09SF3ojEmhfOBnzkR/2oo
 gP6Vw3xdkloaOtQyEipDFbffmacXaQVuL2B1t8u4lIYzR3G5AMOF7wNvK
 0qNRL8GsTJcZlnPgLww0NKiHTTp1Ye1nP63YGR28P2cZVAPLb6sD7mT6S
 PG4gEL25t80ym2OTDdtgXp6/G+8EVGEvypaGHu7oBeU/LadAyzoJ6HU8h
 Dmd349yzIKPZq72K/mI4jYUh+4P602nFhNuKyvVp2yNMTF3GU32hujQTJ
 1+aYw6Rjvkr983uCNY0993Gd4xUXySTFI86XOscNlzHbI2q+3urGMDnNq w==;
X-CSE-ConnectionGUID: ssW3y9AQSqi16F+JyKJcgQ==
X-CSE-MsgGUID: Ab/vcNc8Ro2PCL23xAFYCg==
X-IronPort-AV: E=Sophos;i="6.07,140,1708412400"; d="scan'208";a="18436243"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 Mar 2024 07:09:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 07:08:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 07:08:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHDyI4KiW2JfoyFjsVdId6iqWr7cRv5Qu7P/ykffHJNclU5yYotMOGYWYOak28zbssgM3y5Kwwmh2v2MlBHdEhX6RCiOtz9vH3lpyVTzlrFQbuvwYMPHBaHrGsLu9Hj+WLzjVP66Ni9yGplBoNtBG0FFyMzktMZeiN/eMexG/mCDPnCaeJHn+0GeG1xjxhMZoEB+Yr2M33jyTIwDssyG+pgwMRicNZG876YPTp7mUm/e6V8avqcENaPC9QamD+4rulPj0uMQNNoaFPYwFTbRvbRv8Qu43yTk1SFL9rMtXfxk1ZPeS05jA2y/RpRGk01W73W6uLDBKxgwZ7hKfGdwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G91lhaHoSE0hDcxlXbknIqIHpi0mfr+O1UoA8av/gLI=;
 b=hj6dZ4vffPR4/69lQJYwv4VeLOsSujAVPO6kuy8nMYGwrUB6He5dzENrw7rvNSneVV3uAQa9emthL2tyZ75E+wcdiuefEJOxvBPa3kDZ06nnee2bdho3Yr8+I9UO9ZyZtSlWARARfbGYloNalgzlcenrSVJs+BNRc5cUTnhg/ZZeo19C4PzvPwiCI2Z0VvTz49jIdltygLTH9nlA8iljtMFzb6n52vJkFe3J5abyyc91SAjoneS7lv8zCSSgyQvMQx1yKeVE/yOVE+llufKhFYZ+s095XW98HyA0zvn4RZR2PV180l+WT+Lza4yeOvjvoguZwlKHhplagL01rwQq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G91lhaHoSE0hDcxlXbknIqIHpi0mfr+O1UoA8av/gLI=;
 b=Y3IA1wDGjZgP3UoYXe2cWGuApNW/mHgYlKMm94fAm1TSu4m1zR5yXiHTIy3rDsGdcRsHtnIS03WPqu5PONyuIE8ztI46Vnt4O9eitw32RduouormVEsFycBXAVLG3a9x2iEdU5j11J2Ax+b/ta+LJRNDnXSBdvBeMuPf/HJtcMyTtDobnFLWZPxYZq4/L5wyeUjWYJTOfjJyllTc3C0cJTZHqYvR+ffYfAMMtlBmxWH9cx5CdbKRFe2hPQVHBsmC6dTkuVqB44UOUYWGZb8LjMr7RR6bZGOfvbW6WkgnYsd2mDelVag3NtEwdKLJ3lEUTompwmoDIz+PKMzVVSZXvA==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by SA1PR11MB7039.namprd11.prod.outlook.com (2603:10b6:806:2b5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 14:08:48 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c%6]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 14:08:48 +0000
From: <Mihai.Sain@microchip.com>
To: <ada@thorsis.com>, <dario.binacchi@amarulasolutions.com>,
 <michael@amarulasolutions.com>
CC: <Balamanikandan.Gunasundar@microchip.com>, <eugen.hristev@collabora.com>, 
 <Bin.Li@microchip.com>, <u-boot@lists.denx.de>
Subject: RE: [PATCH v2 6/6] cmd: nand: Add new optional sub-command 'onfi'
Thread-Topic: [PATCH v2 6/6] cmd: nand: Add new optional sub-command 'onfi'
Thread-Index: AQHaeqVdowafu/slREqOi+gSHR5Ol7FAqWrA
Date: Wed, 20 Mar 2024 14:08:48 +0000
Message-ID: <PH8PR11MB680479987099973E85D6CC6C82332@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20240320090214.40465-1-ada@thorsis.com>
 <20240320090214.40465-7-ada@thorsis.com>
In-Reply-To: <20240320090214.40465-7-ada@thorsis.com>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|SA1PR11MB7039:EE_
x-ms-office365-filtering-correlation-id: 4f783ba6-a3fe-4fff-5aa1-08dc48e7436b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hyatROaDpbaIs75nVAC+0X27OLXBezZywMzlgGDbjICVRoJGHEqmt/fKnBEBAMq966XBy5XuvCP8MFfDebgHCoy/bOAFBWBiPFGOaLIdOL3p6lWjaDd/vgYcl35EzjU4qoWwF84vDhS7UWOm+TNCtSa1GOEzdUYNrDiqG8fpBkd4rpcdlMZlR/3TjhPNIFVTJIP6IhOAR84ZbuVu470iQZBGQmlUqPqoeGJefalgdvOsDnCv7QTLHTOxrmfZWNBrPIimM2fsfGLpgi/K+25+lxppcMPyiXr2qvDgoCMpbi265DCe18Aju0RA8RMsqHIuNzZxom5xq5cxYiV7wkfBV/OSXbeXJXEYeoiRRAiJKWhP0L2uG76rulsk39Mzl7NofqRWhFMSpGebQxElRAHwgXFpoyJbIL9BccD9nhMN8IGg6xgR0PFtjFSmVwuG/y2GnmxZRWbKBCxxXzDPu8AqMkmfnm5GrF1W0Xk19aTmBr+NMIZWlpstYPnHmoNfZn8yDcD44thd0XdWSvdMVW5EaPGz1vdKRv/GzElKWD29AvUdHPBjQK2TzEOvlaZSsWI8utFwVQyrXEezutfQxhc5zCoB0Urto06hIgGt5tlsgQROyt8bCkJVAhzMaY6EkKFggUcsS3Iow6JQZ44Mk5ILLBjyLgOSpuG/a8iQhUbGIVvQZR7Rcki5ZvIJq6zdE+Ddz2e6Sp4xAZzD3zJvkHObk/CmxZrf14SFoAqLjuiPMiM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlRFMERxRVFFaS9PRGtSYjY4ZjNmZDBhKytnTEZKQ1ZXelVsVmMxT2tEdzhj?=
 =?utf-8?B?azVmUWZUVTVWckhpeG9pdnVCYmxtWkw3ditMWlNHVjN2R24wVk1CYWpHV24z?=
 =?utf-8?B?ZjNuRU8za3crUVNLM29MN3lzQ0lxbGZDdmx5UHV2NHQxNS9VUnpRWlhzY25v?=
 =?utf-8?B?bjRRQnVyTDZyYStYYWNSWjZvVEZTdlVXZ0VOWUs3c3JkMG9RakJuNjJxOU9R?=
 =?utf-8?B?bC82bkVqc1FYeklReGpyRWQwUTExaTJZTnV2NlBxZU9tMld0bVVRYWlkcGh0?=
 =?utf-8?B?dmtvMk5oUVBUMDlQd1FQekZTZ1hPbWlsRDBBeEh0R2dXaFRNVCtzWmxqUUR4?=
 =?utf-8?B?YTBHOGZUaEQwT0lnREhvaVhYdC9ZekFpR042NmJCZVRnUUIxZVFYOVdGQmVV?=
 =?utf-8?B?bytrbkxUVEJwemJVcEhBYVRoRVk0aWphaWdMVHN1elI3eGhVdVJ6TzJZRmFY?=
 =?utf-8?B?SnYraVlucFo4SzgwN1RaTUhTRk9KU2tvbjhGb1NpNmlWek8wVnNjT2Mya011?=
 =?utf-8?B?UmtMTlRENUZYSk1Rb1l6dDBHMjRSWk53eXNFYnVBeVRQTnh6QjVoMmpBRFRD?=
 =?utf-8?B?aGY4bHYvSDVNbWdvenJ3UHlwYVBpMGp4bEZuTHZKRW9XaXA5K0VZUjV2Wjg2?=
 =?utf-8?B?bGluRG0ydmF5Z0JqUklxdCt3ZDlEMHlGYnltVVZuUmt1WnNManRNMVpCLzlH?=
 =?utf-8?B?MkFJYWRibXhLTE91UVdQcG84bGdwUUpMVUthS2IvcHEzK2dHRmt1SHlkNklJ?=
 =?utf-8?B?SW1QOXB3TTk5N3o3dTd2R3BoWEVsVlc2TE5vdmlvd0QzZnQzcmVGK0V4WER1?=
 =?utf-8?B?ZDFlWmJCTlJzNnAzamsxSlhZSjFraElXVGFUTHZlUHVWSjhZU285RXI0aTVU?=
 =?utf-8?B?NUpxOXphZFNJNVlUYlMzY2VkK3hTblRTK0Y4OTNLam56eDJ2enBMbCtEbity?=
 =?utf-8?B?VEkzalo0YWtGendDaWdNSnB4bGRMKy9BVjVoVnhxbU92NFUxV3lvMC9YRTNS?=
 =?utf-8?B?Q3VEdzVDYTNMV0MreXJNVnpkZ3BwanFPaXFFZXBNa3ZraS8yMmdUeFE0U2g3?=
 =?utf-8?B?OUJKOE9hYVFmL3I5R0xqWmcvbHVOL2FHcVRMQXRoRmd4Ti9ST0tJSlV1MUZs?=
 =?utf-8?B?c3FlMWFJbCtBWnVmRVpuTk1KVmxKUEJxWjNOWGRZWHI0b1JDakluTExTcmFC?=
 =?utf-8?B?bklUanA2Sm1lWHN3V0F2dW5IR09EUGVLVGJQay82Nmd3dEtaV3FkY0JsR0FF?=
 =?utf-8?B?SUl3MUF6cjZoUjVWUjdhR2x4d0JaQmhUa1c1S0x5cXluV0pKaHNCeDF4enIz?=
 =?utf-8?B?Q1o3Zm4xRW55ck1GK0xVdVBIZnVQNjNHNDFialNFSTUwWlVJNExnTGw5dEtj?=
 =?utf-8?B?bDhjV0tMZk1zeFh6cXlPM0FjUzU0eG5qZ1N5NFFlRkk4eGU0bmpOUE81VkFl?=
 =?utf-8?B?d1VZYWFoenJNUlZOdDM4Y01nZ3IwNFhzNkZYcEdacndWU0p5ZnRDb3J3YmFp?=
 =?utf-8?B?Y05LL1ZkSjRTd24wMEJ2OGVwSzlSZU5UejRJS0pRcFlwM0dKVkZ5NFdndlBp?=
 =?utf-8?B?NUdjWnJmSjBOZHpGMitxK3VCdGFZVmdUSXNZMzhmSWxiTndnbEEyU2FSaTRE?=
 =?utf-8?B?L0ZmeTFEREhhd0gzQlR5bEJmcWlMNHdrTDA5OVlEbFZxTVk2MEtyS3lRUTJk?=
 =?utf-8?B?Q0hCMjJ5R0t4U0NhTGgxMGVTS2JDTWxkWi84R2JuRmlGOFp1UXlUOTdkMk1a?=
 =?utf-8?B?Vmg2bU10M29KWkdIQVA5bUVmVkZFeVVvb2RIbXBhM2RGOExFWnV2dGpVSFEw?=
 =?utf-8?B?NWxCRXBybmdUTWpUMHg5YzhLVlNNNmFXa0pYSm9HOFVra3FURjRQQ25QRGVK?=
 =?utf-8?B?UDJWYm44ZVk5QUU3ZEJ4bmZkYzNITkYxUmFHeW54NDZrYTFHTUxzS2E3TVNO?=
 =?utf-8?B?MU4ydzF6RGFVMEVDaE1qRTdWcm1aSDVObFpCZVc4YWtBeEE0K1NJOGlJV1BH?=
 =?utf-8?B?czQ2ZWVyekF0anBGZmx0Vmx0d09ZbUYrTU5qRmRWalBqMThFcFJPcE5kNmV0?=
 =?utf-8?B?c3NUdUhPb1pBaWl1Ny9HQ1NLSGlLWDMxTTUwMjlVL2VjcWpxVDZTWmJqSW1q?=
 =?utf-8?Q?yscoyHvUHMRlbFmQM9MNjUAA6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f783ba6-a3fe-4fff-5aa1-08dc48e7436b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 14:08:48.5344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jaDVgdWUpD7Nxph4uWnx6Voo0EIcAeeaVVcrrNBEMmYcAjrzANBUGNqbBFDeCK8K8cJ47MXItLfWyxeFLs2wVG4ClP+60KzeHnQrOQvJQro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7039
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

SGkgQWxleCwNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCg0KT3ZlcnJpZGUgdGhlIE9ORkkgdGltaW5nIG1vZGUgYXQgcnVudGltZS4N
Cg0KU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIERhaGwgPGFkYUB0aG9yc2lzLmNvbT4NCi0tLQ0K
DQpJIHVzZWQgdGhlIHNhbWUgYm9hcmQgc2FtOXg3NS1jdXJpb3NpdHkgdG8gdGVzdCBtb2RlIDUg
8J+Yig0KDQpJIGZvcmNlZCBpbiBuZmMgZHJpdmVyIHRoZSBtb2RlIDU6DQorICAgICAgIGlmIChj
b25mLT50aW1pbmdzLnNkci50UkNfbWluIDwgMjAwMDApDQoNCkFuZCBJIHJhbiB0aGUgbmFuZCB0
b3J0dXJlIG9uIDE2IE1pQjoNCg0KPT4gbmFuZCBvbmZpIDANCj0+IGhzbWMgZGVjb2RlDQoNCk1D
SyByYXRlOiAyNzAgTUh6DQoNClNNQ19TRVRVUDI6ICAgICAweDAwMDAwMDA3DQpTTUNfUFVMU0Uy
OiAgICAgMHgyMjExMjIxMQ0KU01DX0NZQ0xFMjogICAgIDB4MDAyMjAwMjINClNNQ19NT0RFMjog
ICAgICAweDAwMWYwMDAzDQpOQ1NfUkQ6IHNldHVwOiAwICgwIG5zKSwgcHVsc2U6IDM0ICgxMDIg
bnMpLCBob2xkOiAwICgwIG5zKSwgY3ljbGU6IDM0ICgxMDIgbnMpDQogICBOUkQ6IHNldHVwOiAw
ICgwIG5zKSwgcHVsc2U6IDE3ICg1MSBucyksIGhvbGQ6IDE3ICg1MSBucyksIGN5Y2xlOiAzNCAo
MTAyIG5zKQ0KTkNTX1dSOiBzZXR1cDogMCAoMCBucyksIHB1bHNlOiAzNCAoMTAyIG5zKSwgaG9s
ZDogMCAoMCBucyksIGN5Y2xlOiAzNCAoMTAyIG5zKQ0KICAgTldFOiBzZXR1cDogNyAoMjEgbnMp
LCBwdWxzZTogMTcgKDUxIG5zKSwgaG9sZDogMTAgKDMwIG5zKSwgY3ljbGU6IDM0ICgxMDIgbnMp
DQpTdGFuZGFyZCByZWFkIGFwcGxpZWQNClRERiBvcHRpbWl6YXRpb24gZW5hYmxlZA0KVERGIGN5
Y2xlczogMTUgKDQ1IG5zKQ0KRGF0YSBCdXMgV2lkdGg6IDgtYml0IGJ1cw0KTldBSVQgTW9kZTog
MA0KV3JpdGUgb3BlcmF0aW9uIGNvbnRyb2xsZWQgYnkgTldFIHNpZ25hbA0KUmVhZCBvcGVyYXRp
b24gY29udHJvbGxlZCBieSBOUkQgc2lnbmFsDQoNCj0+IHRpbWUgbmFuZCB0b3J0dXJlIDB4ODAw
MDAwIDB4MTAwMDAwMA0KDQpOQU5EIHRvcnR1cmU6IGRldmljZSAwIG9mZnNldCAweDgwMDAwMCBz
aXplIDB4MTAwMDAwMCAoYmxvY2sgc2l6ZSAweDQwMDAwKQ0KIFBhc3NlZDogNjQsIGZhaWxlZDog
MA0KDQp0aW1lOiAzMC4xNTIgc2Vjb25kcw0KDQo9PiBuYW5kIG9uZmkgNQ0KPT4gaHNtYyBkZWNv
ZGUNCg0KTUNLIHJhdGU6IDI3MCBNSHoNCg0KU01DX1NFVFVQMjogICAgIDB4MDAwMDAwMDENClNN
Q19QVUxTRTI6ICAgICAweDBiMDYwODA0DQpTTUNfQ1lDTEUyOiAgICAgMHgwMDBiMDAwOA0KU01D
X01PREUyOiAgICAgIDB4MDAxZjAwMDMNCk5DU19SRDogc2V0dXA6IDAgKDAgbnMpLCBwdWxzZTog
MTEgKDMzIG5zKSwgaG9sZDogMCAoMCBucyksIGN5Y2xlOiAxMSAoMzMgbnMpDQogICBOUkQ6IHNl
dHVwOiAwICgwIG5zKSwgcHVsc2U6IDYgKDE4IG5zKSwgaG9sZDogNSAoMTUgbnMpLCBjeWNsZTog
MTEgKDMzIG5zKQ0KTkNTX1dSOiBzZXR1cDogMCAoMCBucyksIHB1bHNlOiA4ICgyNCBucyksIGhv
bGQ6IDAgKDAgbnMpLCBjeWNsZTogOCAoMjQgbnMpDQogICBOV0U6IHNldHVwOiAxICgzIG5zKSwg
cHVsc2U6IDQgKDEyIG5zKSwgaG9sZDogMyAoOSBucyksIGN5Y2xlOiA4ICgyNCBucykNClN0YW5k
YXJkIHJlYWQgYXBwbGllZA0KVERGIG9wdGltaXphdGlvbiBlbmFibGVkDQpUREYgY3ljbGVzOiAx
NSAoNDUgbnMpDQpEYXRhIEJ1cyBXaWR0aDogOC1iaXQgYnVzDQpOV0FJVCBNb2RlOiAwDQpXcml0
ZSBvcGVyYXRpb24gY29udHJvbGxlZCBieSBOV0Ugc2lnbmFsDQpSZWFkIG9wZXJhdGlvbiBjb250
cm9sbGVkIGJ5IE5SRCBzaWduYWwNCg0KPT4gdGltZSBuYW5kIHRvcnR1cmUgMHg4MDAwMDAgMHgx
MDAwMDAwDQoNCk5BTkQgdG9ydHVyZTogZGV2aWNlIDAgb2Zmc2V0IDB4ODAwMDAwIHNpemUgMHgx
MDAwMDAwIChibG9jayBzaXplIDB4NDAwMDApDQogUGFzc2VkOiA2NCwgZmFpbGVkOiAwDQoNCnRp
bWU6IDE1Ljg5MSBzZWNvbmRzDQoNCkJlc3QgcmVnYXJkcywNCk1paGFpIFNhaW4NCg==
