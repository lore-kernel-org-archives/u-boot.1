Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42CDC2BD09
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 03:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19CDB88665;
	Wed, 10 Jul 2024 05:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ogga.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ogga.onmicrosoft.com header.i=@ogga.onmicrosoft.com header.b="R5cm3JJ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C1358865D; Wed, 10 Jul 2024 00:28:21 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 852E1880DE
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 00:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ogga.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zli@ogga.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kybTXmt4CNwYCWZTR0p/KJS+/Q1hxY0aId2oprkOS4yLxrkfAsN/6ZmU6OpZ9C07YuuW1w7+aVBUo3B84Jh2WNaab400/kBxR6IeCV/DK8ZVvZXaZSiza3zLKAF/HDuAJ0b8cae6TFc65Ox4xhuTwAXEthEAza08M0+V8G9KSaOfJLYAmRfUg96swvXeIr+DGXx4cYBYcnMmJpG7/IuAW7afHXzX9vhS3nXHjAUSVfsrhlLF5pkSlU5LfWKCMAm2R1cOXaMrhNEfKCCaeSEMt2dwlk7caw1YsjS0h8AhjKgbKRoN3YT93Mv8fYb+jUY5k1P4oQ9kPto49hNQCRuQoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Avi1ptcnpzrD7kTtgHbksvHMpUkajoPm1SUY7jPMWI=;
 b=jqslrTcNFCw855r81Mc3j/6gdD9ez7zB+OUzsqnV+evlx0envTirnyVb8+z/K1J9iqkTFYnRYekmUlGuOaQVZqQWlHKGG7+mFxyTWTSHyOVBHj1tJhPRNCWPeMS9Kg6OGLZDT6dZsp3zJSk3QUpj+c15L1tpzsRbtkpf2SvCaUCwQs/sTRJ0o392VxKgM32CEKiX4xEGbs/vdhGSsXWo52SgVttkTr0e411Rkj3FeOzBvTRKINq73hyjhMJSpQyuW7enUkLBM+0rdV/a4n/+Wz38caUFWGhKJEdRh4IAEPTwSvbK6HoLwRdcwjDaLEaRLXLvpgcQoG6bZvBJ92ERoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ogga.fr; dmarc=pass action=none header.from=ogga.fr; dkim=pass
 header.d=ogga.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ogga.onmicrosoft.com; 
 s=selector1-ogga-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Avi1ptcnpzrD7kTtgHbksvHMpUkajoPm1SUY7jPMWI=;
 b=R5cm3JJ7kg8PTUuQIxhB9uP1L2iYtW6I6u9jdnHZjTWQhJbKhOlbUv92Acq0KVzlQpHPE80iFTPmA/1CuNDrQhjWdGPuvaxITvkdMq8uAw3RRZzAkbk+EQoi/BFCdsT/iCo4DKJVx5DLxKI1kfSYZDN6oeNMIORA5IJTGoQoaYU=
Received: from PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::20)
 by PARP264MB5342.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3ef::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 22:28:18 +0000
Received: from PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ead1:fb5b:e337:d4ff]) by PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ead1:fb5b:e337:d4ff%6]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 22:28:18 +0000
From: Zixun Li <zli@ogga.fr>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Zixun Li <zli@ogga.fr>, open list
 <u-boot@lists.denx.de>
Subject: [PATCH] mtd: nand: raw: atmel: Use ONFI ECC params if available
Thread-Topic: [PATCH] mtd: nand: raw: atmel: Use ONFI ECC params if available
Thread-Index: AdrSTW6mmB6pXteCRRSkKoT1NBAEcA==
Date: Tue, 9 Jul 2024 22:28:12 +0000
Deferred-Delivery: Tue, 9 Jul 2024 22:27:39 +0000
Message-ID: <PAZP264MB2974E713F54A40AB9B17DB85B1DB2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ogga.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAZP264MB2974:EE_|PARP264MB5342:EE_
x-ms-office365-filtering-correlation-id: 5e25a3fe-7ed7-4202-a22d-08dca0666e70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eWlKMWc0WU5DK3BBWWNkYTF2cHBHbllXR1g2dUZWNkxqb1VmSFVQaW5KZFNo?=
 =?utf-8?B?ZXFVOEhsMW9CZnlEQW40L01LZE01SXNCMDZ1YWJydHpYa3BnRFp1T09US2E0?=
 =?utf-8?B?dGVyWFFaY1prN0tIdFdHN1dobUlqWjJQbDhiN0VsWnhGQ2FDOVhlakc1Tk9z?=
 =?utf-8?B?R1NIM1pUUk03K21Gak1uazg3VzF5UDZ3a0pjSW0rSlpDa0pzeFJnZjNTcGdr?=
 =?utf-8?B?QXNKbHltelRGQkxTc0ZIL21WL1JlNGlXYnRqUXBtRDZOMGpjSzVPT1hHRUFB?=
 =?utf-8?B?NGZWRnd4bzFialV4bW9oVExtNnpXYjYzSlpiVDhWS2Urb1BtQy9LU2lkQ25F?=
 =?utf-8?B?U2FTbjNPejJveUw5ZUxPK3VKMWdzSHhNWEZDNytld0JGRUFHL0VBN2MzUEc0?=
 =?utf-8?B?SzJ5NGhzS21xQ0dQNmJLazRxN0E5QytPUmZDOEJBUUpKMzcybW9KeWc4enVT?=
 =?utf-8?B?YXU2ZjJrc3cvOGdhb080dGRoSTZoS2QxREYyVG1pNzNyblZzelRHSzVxeHVi?=
 =?utf-8?B?aEx3VzduMlV2TDBWMzNJdzVrcnZ5b1dpdWQwbytHUnZXc3UyRElOS3V6dWxM?=
 =?utf-8?B?NUErTWN1V3IzRTNsR2piYkZxVGluZEFBK2M2VWtjRy9Ec2l2N095dlliOWN3?=
 =?utf-8?B?ak5EMUxaRXBXb2dRa0MzSXlURnIyWk5UZlN3M0Fra2JPS1dlbDBrSnZXUG5J?=
 =?utf-8?B?L1Y5OE5RWEh6allVSFVLYThpZ1hyREVxNmpHRE1OMEZNUlVvZi81QUZxenlp?=
 =?utf-8?B?TTFQWll0amFScXFmbTlGbTVIYS8weWh0V2VUdGllQ1owTDBFVmRmSUtScTEw?=
 =?utf-8?B?cHRkcjVwN1NsMnVvbS9UbUptSXNQOUUrYlY0dTE2b2NGZ3BiVDJ3MVlwTHdY?=
 =?utf-8?B?YlR0MzVRRUZSTktZeC9LWkRNdjZxNjh2Zkd4V3VFc2QvSHZjQ1FZcm8yQWh6?=
 =?utf-8?B?cjZTckFnQ2xnYWdpaDZ0aDdraVZYT01IS0FaNmlLMmYyV3dQWkNNTGxNeGFR?=
 =?utf-8?B?REFsbUtIdUFYOTBIS3gyeFF5T3ZLQ0dCZzFCOW1hakdqLzFNU0lhSTFpb0cw?=
 =?utf-8?B?KzdDV1V0OXkycTNvQk1sTVF0R2tQNWF1T3R0WkpBY1Uxck1MMzIwY1ZSeVZW?=
 =?utf-8?B?WGFaS3dXdER1dVZXWktvc0FONVZKTzhCYmYyT3ZNS0kwN0xIdDNUYkNwaEJt?=
 =?utf-8?B?NFNwbDlCR200VlhkUDVHRXZMSXk1ek43dFdJZUZBR1E1RVY3SGZOZU1CRnl6?=
 =?utf-8?B?RGNheFp1SDA4eUdna0dicmUxUFFtaUE3RitHL2p1YmNlMlpzb2Q2R0FQY2ZN?=
 =?utf-8?B?VHNJTUwxMWF1c3UzbEZOSERiT21QNy9qajB1Zi9IeUhGbnNBR0ZMa0NtZE5v?=
 =?utf-8?B?a09XViswYm1pRTlEMFFDUWlkRHZ5U0hMVXgxN1k3Znp1dG5qWkdWNm1ZNEY0?=
 =?utf-8?B?cXlTVWp2NThhYSsvWWhNOTljNXdZS1kzRm04bUdxQjk1dnJHc0dKQjZnMEZS?=
 =?utf-8?B?dnpWbFlsandKQm1HcU1kbitlRXptdlkweGRjUUF4UEFuaGpydVcxK3lOSjkv?=
 =?utf-8?B?ZGJVOFlGaGdJMHhybWZvbStYNU1JRWFyMVgrdDh4S1hKSkNTNThWUE9Td2U3?=
 =?utf-8?B?MTZDK3Q1dWo2YVEvQnRoaHY0NUtXWTdpdFlBQ09sZUxnYWcvRFRRSm8xWGhL?=
 =?utf-8?B?Wlk1NldETWc4TVZMRGxWYnJTSVliZFRvWS9BeE93a2kyL0hDVjRMcTcyR3Nn?=
 =?utf-8?B?bDRrcElkWi81MHFzbVBpdzU4Qm5uWFZQTktLaHlLTE9peDgwcFUwWWZpR2tD?=
 =?utf-8?B?M3NFeGJlRS9abldRcGhiMmpCa1VXSHdYa2NONzQ1VVpnVUZvSG1DTEhBVjhD?=
 =?utf-8?B?VXpFU01WRStqZ0kwa0MvL3M2QzFvYXNpQzVGUnhNNWdwY2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWZBZ1U0OEZvNlUxZUQ3YW5MWWk4SnhhWUZ3ZGErYy9RVUVxUnhlV1RLZWFz?=
 =?utf-8?B?NjA0Q1ZjSW1sU2JJMUxEejEyb3hEZ2ZndjJ5SzEwSUZyN295dUdOSzFjQXlR?=
 =?utf-8?B?M3dhOEUwTFJZNEhPSEc1cXpkaGNqYjhOWHZWMzN3M0t3UFJkcWtTZnFhMmg1?=
 =?utf-8?B?cVdkM0FHQ0l2NnR5SHZoMDZkYndkMkdvdWp2ZXUxT2I4SVloVWg0NXNBZS9F?=
 =?utf-8?B?VVg3RkJaNXBOR1d6VHJZYVF6UUlaalhMWGE1UTBHdDB5b3ErcXRMUTJaTTlX?=
 =?utf-8?B?NHdYSFFQRlBrUlROYkhwOHR1YzEyRmtNTWc3Mkh0aXVBYXNuQ3lObWlwSXdz?=
 =?utf-8?B?YXl6NVJVVDI3Y0RhRnB6Nm1KS3ZwTFUxZkVYU2wwV05BSFlNVjNiNjVTVklL?=
 =?utf-8?B?cHlsODhjSDN5SWN6TmdPZlFEMTFMUFJENHlHUWJsdVZQQmlKWEgydUlWKzYz?=
 =?utf-8?B?N2dCM25IQlRhU1dmeDlEVFBFRlN3bFUxWklCc3N0b2l0UnNFakFvSXZNMzRo?=
 =?utf-8?B?ZTdtTjNRUS9nMFc0MkFpeEZSTGx1L1Y1SkZoVUM0dW1MVWszdVNuYjhIYldD?=
 =?utf-8?B?VXZDUFhCUFd2dVJkUUlXenVwQVhLRXJJRXpDb3JPZWJlQlJyK3JEc1VtQWs5?=
 =?utf-8?B?dkhSK3pUTml5REdqZEZiSFJIMjFmMGx3alphaE14Vk0wYm5kR0VzUVRoTUZx?=
 =?utf-8?B?SEFrRSs5eElsbnl3bys4Zk5YU0FUU1BRcDFCVE9CT0tCbDJWNCtHVEMvRFNk?=
 =?utf-8?B?QUFtM0MwRWJPSVlZZ05vSjgvZFVNSkh6Z0lCM1l0RXJ4MHdkU1pZVko1UmpX?=
 =?utf-8?B?NVlaRUFXV0JZd21kbWxSTWdxUWlvOEEyL1dEQUxXVzZDeGRkczNLZ0J3eGcz?=
 =?utf-8?B?WlVEUFRWbVN4SEJTRmZwZDNuWTVQdS84OENHTWhKRDc0WGIxVHZtK2o2K2dm?=
 =?utf-8?B?cXo3YUJGWEdsWGdjSGt0NFpyTWh1OXBkUEVBRlpWaTRNVHJBV2hMTnBYWk14?=
 =?utf-8?B?TmRCdVNxdUFEME50WTlZZXUraHZyTmJsU0wyU1o0RlBlQU8zZjhscHpZWEY2?=
 =?utf-8?B?T1VORkpJQlFoa2taWU5zRmQ4UVJXWW54NGdqc0I3ZzAwWmE3aHFjeDhIMVNC?=
 =?utf-8?B?VFFVUCs2aC8rcVZPZGZMZ1NpR0NEUjlWREJYVi8wSGRBN0pmeW40ZzkwM1Mr?=
 =?utf-8?B?MEFPbG1XQndTbkZzNXdLcXNtT0JxbXMrakN0S24vQk1uUVdaUDM4YzJDTFRz?=
 =?utf-8?B?ZFR0cGJ0V1l0eWxUa29aTUdNSlNiVTkrSEZmMUJsZW16R1VaY0hBcDlFbFF2?=
 =?utf-8?B?dm9aM21BU29SYURRbGVKekZ2N1RHUnBEU2ROV1NLOVhEUkIwd1VZb29adncy?=
 =?utf-8?B?eng5S09FdHRQZWpCS1ZwMDhzMGpldVdDMkszY3ZXTmR6N1F4Q09TaFdUeGJV?=
 =?utf-8?B?bFpOR3BNOU52UUV5NVVOcUQxOC9jWlFYc2N1N3p3SERZejVvMGtpSktHa0Fa?=
 =?utf-8?B?a05WYlQwRFI4Y1VPTU9sZFhOcEUvL09VS1V4OVV3RllFaWZ4VWRBUENuSHJx?=
 =?utf-8?B?UjdyWVM1QmFycmFOOUdiQjB2MTRkWHJicVlncTRhRVRsU3MvM0dQTVJWMSsv?=
 =?utf-8?B?c3lQelgxblVmeGFNWjEzMW1sSDlieEdrQmJkbGEwTmtGQkwzc2F6aEloVXFw?=
 =?utf-8?B?d3VxYmRJUXY1SUU1R3hxcTVXN2JxU3V5QjY3MFdyWEZZRGpPOUhVV0dYdW96?=
 =?utf-8?B?RlJvbHBJY0FUd1N0OGZqeWpKcFc5dFdVRXgyb0doYys2QzVIbkxUYzVTb1U1?=
 =?utf-8?B?MnlxMkNueW1tSHVhc1VJeStsTVNCU2s2ZWtzMlhzT0ovSTFBdXN3Y1lNRzJS?=
 =?utf-8?B?bnRqNTRHT1lHT2VZV1N3dWN6Q0lFcXVsU0JvY0VYSVRkU2x0V1g1bzlnWk5X?=
 =?utf-8?B?bTRMUGZ1R0xnb3FHZ0ZlSE42WkpTbnowMjF3MVluaGt1QmVJbE4xWmo2ZFcv?=
 =?utf-8?B?UzAxT3Q2REVPQ2g3ZjdsN2x1L1plYUhONHNxSXh1OUxGNkRGTE9kOGU4Q05G?=
 =?utf-8?B?S3dCMllGbmsrTTYwN1BuaHpZeDRybUVzRVVtOVpjcTJYbVpvamhnelNNbFAw?=
 =?utf-8?Q?UUHk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ogga.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e25a3fe-7ed7-4202-a22d-08dca0666e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 22:28:17.9349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a737871-c9db-44dc-a24e-55df547c3098
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: urOHkVYP7Y0kfeSPPyXYr10aFEiNnsR8cNebCyY2qrZYt4M3AhmnOELUluvjGDi7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5342
X-Mailman-Approved-At: Wed, 10 Jul 2024 05:10:36 +0200
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

V2hlbiBFQ0MgcGFyYW1ldGVycyBhcmUgbm90IHNwZWNpZmllZCBpbiBEVCwgZmlyc3QgdHJ5IE9O
RkkgRUNDIHBhcmFtZXRlcnMNCmJlZm9yZSBmYWxsYmFjayB0byBtYXhpbXVtIHN0cmVuZ3RoLiBU
byBiZSBpbmxpbmUgd2l0aCBrZXJuZWwgZHJpdmVyIGJlaGF2aW9yLg0KDQpTaWduZWQtb2ZmLWJ5
OiBaaXh1biBMSSA8emxpQG9nZ2EuZnI+DQotLS0NCiBkcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1l
bC9uYW5kLWNvbnRyb2xsZXIuYyB8IDQgKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L2F0bWVsL25hbmQtY29u
dHJvbGxlci5jIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvbmFuZC1jb250cm9sbGVyLmMN
CmluZGV4IDk4NzNkMTEyNTQuLmQyOWE5YzZmMTAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL210ZC9u
YW5kL3Jhdy9hdG1lbC9uYW5kLWNvbnRyb2xsZXIuYw0KKysrIGIvZHJpdmVycy9tdGQvbmFuZC9y
YXcvYXRtZWwvbmFuZC1jb250cm9sbGVyLmMNCkBAIC0xMDY0LDExICsxMDY0LDE1IEBAIHN0YXRp
YyBpbnQgYXRtZWxfbmFuZF9wbWVjY19pbml0KHN0cnVjdCBuYW5kX2NoaXAgKmNoaXApDQogCQly
ZXEuZWNjLnN0cmVuZ3RoID0gQVRNRUxfUE1FQ0NfTUFYSU1JWkVfRUNDX1NUUkVOR1RIOw0KIAll
bHNlIGlmIChjaGlwLT5lY2Muc3RyZW5ndGgpDQogCQlyZXEuZWNjLnN0cmVuZ3RoID0gY2hpcC0+
ZWNjLnN0cmVuZ3RoOw0KKwllbHNlIGlmKGNoaXAtPmVjY19zdHJlbmd0aF9kcykNCisJCXJlcS5l
Y2Muc3RyZW5ndGggPSBjaGlwLT5lY2Nfc3RyZW5ndGhfZHM7DQogCWVsc2UNCiAJCXJlcS5lY2Mu
c3RyZW5ndGggPSBBVE1FTF9QTUVDQ19NQVhJTUlaRV9FQ0NfU1RSRU5HVEg7DQogDQogCWlmIChj
aGlwLT5lY2Muc2l6ZSkNCiAJCXJlcS5lY2Muc2VjdG9yc2l6ZSA9IGNoaXAtPmVjYy5zaXplOw0K
KwllbHNlIGlmKGNoaXAtPmVjY19zdGVwX2RzKQ0KKwkJcmVxLmVjYy5zZWN0b3JzaXplID0gY2hp
cC0+ZWNjX3N0ZXBfZHM7DQogCWVsc2UNCiAJCXJlcS5lY2Muc2VjdG9yc2l6ZSA9IEFUTUVMX1BN
RUNDX1NFQ1RPUl9TSVpFX0FVVE87DQogDQotLSANCjIuNDUuMQ0KDQo=
