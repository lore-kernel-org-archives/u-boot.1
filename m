Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F48C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 08:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8603188961;
	Thu, 25 Jul 2024 10:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Oz5jCT3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 646C188A06; Thu, 25 Jul 2024 10:23:25 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ADD188800
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 10:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYobl48df9OCb0blgbQ9Q1O43euEluX5Uzho8nj6I9Eh+nZB+9Gopb4aEuE3ufWSnL6k4U2pu+qJ+WQCSHed7m1cCNxcsqyx2dRaWQB0VfDQGlRh3ubgmLXUJ/09y1VqEk18kzSIesXuhrFays1piPfaDAwx5BCq/P0KhkWBktzC3qkbf5qaVGMiyXdNl+aav90bTGa9sV8rfakXJDCbdG7ZoD8HqyWxuDe5hYSKrs2QZ1AXWbQaqHEZ1a9l0bGfIjvE48VDVu5OZZUSoVrkunIrISN6uXA1vA3hOzXw1PoPxwTUYLAwk2tCuGZIo0rTcDCN+0lgfzDVYEMhdBGPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O62XXDxntk8jxc5wWm0VNOLs6eUgDt80/H/Mo8sAaaE=;
 b=OfJkXVoJUiaymHraWT4f703fURe3xHvP23qmeh3g3MZU9R4UnT2vh1pLWnmJjF7YuNdCHliKhFIL6EbzhTfGeCYE6iCCTPE2/aO0O1xbc333uogLXiP8Z0LMMQ7wlS6FPNX/wUUWn1Le0vZPfpJhmiAr3iSy4af8idkre+KTekdX8MsVRCUq7DGfeZEiNsZGZ/7bJGjUY8gc/yHELrDKVLh9C7KreoRdkJ49BCxYoxxX/UaLTp5HmVgHTsKm9/vs6Li8yrr7xp+02tbr0UYJVA2GnBeQhZqqkpvsIcu1VN3FSHCzHxYgDJmqX3Rq0a8drZWsO6+9U0nnCbooNe9iDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O62XXDxntk8jxc5wWm0VNOLs6eUgDt80/H/Mo8sAaaE=;
 b=Oz5jCT3deYac6yWcee9jMKeygKitncrMuVRU7HHldTd5TI3V9K4bGX+TlE5wHGsYn4uFrcrbY1uO6gOTyti7gSEUcr6siJhC4SE2BlXXy1+RYX5N6vJqR1BlM1jlNGV/y5Kqn73fCnCHbs5WdU730TUndA748sKp4OXb0HM61JZXvqRA11CgDqAZuLukL6sySXZvaydHG0CapEpCarJV+/X6zHagL4i9ukqKM7j5OTfkTc7MeKkpcWYMo8yhMmYPDJk5mh5bDQSilUJpw7J8gteLvSzW46Ay6PPZgSelQRuHFGfpxicRvAjLT6QkdkuNgBTaVGGf7mZZU71MixIx5g==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by AS5PR04MB9894.eurprd04.prod.outlook.com (2603:10a6:20b:655::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 08:23:19 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 08:23:18 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com"
 <seanga2@gmail.com>
Subject: RE: [PATCH] clk: fix ccf_clk_get_rate
Thread-Topic: [PATCH] clk: fix ccf_clk_get_rate
Thread-Index: AQHa3mKN7U19CG9BQkGdhXtEbE4r3rIHDK2AgAANqsA=
Date: Thu, 25 Jul 2024 08:23:18 +0000
Message-ID: <DB9PR04MB9236ACC9C613982795A9E5AC84AB2@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240725073707.26040-1-Zhiqiang.Hou@nxp.com>
 <CAOf5uwm-kedmeH7at0F5+zfuJ9218NwRSJjA4_vjTGvpsJ7msA@mail.gmail.com>
In-Reply-To: <CAOf5uwm-kedmeH7at0F5+zfuJ9218NwRSJjA4_vjTGvpsJ7msA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|AS5PR04MB9894:EE_
x-ms-office365-filtering-correlation-id: 207b3355-30d7-4ef5-365c-08dcac8309b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dCtWZ2pFOGpabnVqMmhnY3lvbFNkRHVjSWwrZE55dXBSSmtSVDQ0QjNZSGYw?=
 =?utf-8?B?OENodFY2WVNaTXlrOHoza0R5VTEwcjFIcnZvcTZJaXBDU0xKRnp5dWdSdFZI?=
 =?utf-8?B?RmRNc2xXZTN6bm9xUVFuMU10bGsxb3N4OVB6NDY4Rm1jWWVwWnVUMUw1MC9a?=
 =?utf-8?B?aEpYdWhXVUhpa0pNVWg4eWJMaXJ3ZnkxL2dpQlVteW1Fa3ZreHFrQytDZEc4?=
 =?utf-8?B?cEN3STRIK1lKR2I4cGxIL3NlN0Q0UGpCVkRzbzVzeTRob0xHZUk4NTdRb2h0?=
 =?utf-8?B?aHBBZ1hYVGRGR2xvZlNuaVVHWUZCUHk0UG1RSDJKdDdCWWFDeGQ0Ti9QM0tH?=
 =?utf-8?B?UjZpUk1ZRmt0bmRYYTN6LzVqUDlMYXNHcXA2bmdQNjM5Q1RsWnBmdG0wdjI3?=
 =?utf-8?B?aWNoMlUrUVJNbG85VHMwWXpTS3BML1U5OSs0RHNvdTY5RHN6QWJSRmkzazBH?=
 =?utf-8?B?L044Z2RvL2Y4RTk2b0JucjJXUDR4M2tsdDBPY2lDVmtzM2JTbFc0V0xueTFY?=
 =?utf-8?B?aTFmUWRaZlRDbDFvRVRlZFdKUmVqcTdDL2hlSy9FWk4xcUhoTG9qbkhtL3pW?=
 =?utf-8?B?NThZL0xtNXNISnpYaThnL1JWWWxmTTJpaFlsVFZEMlFYUjJudm11WXZtdmRJ?=
 =?utf-8?B?cUM0dVROOXlFN2N1K3FWYTRvQXBkZEljT01kaVJ3NHo4STdOMU1oY2NPYjVm?=
 =?utf-8?B?YjBHU0hNdERYSHhqRDViQnVhaE96aWNXR1k1cEdpQ3VXUzMvTUE5SHNQaTM3?=
 =?utf-8?B?bnZ5VXZaZmgyVlFmSGptR3lCZ1RaSitIVElpMW4zNDZjd3lIMkx4Q3RxaGox?=
 =?utf-8?B?YlR0NmhHS2xlQnVKTzRSYW5aY2dHVC9ScnVvVXRYdTV4MU5VR3pUakVqRmZw?=
 =?utf-8?B?UTNRNm9qRHRGQ3hTUmxyWVBsMi9hVnYvSWNiejdINndYMEk0azdYNzIzT3ZP?=
 =?utf-8?B?RUovTERqaFR6Ym5FOWtYeW5ZejJMU0YyUE5kdzhveWpDMElkcy9qSGtyb3V2?=
 =?utf-8?B?bU5FdW5IZHc5QjBMNUpvQUg4YnJXdnBBTCtPenZOYnJ1LzR2NmpGR2kyZ3hj?=
 =?utf-8?B?VmhyYmFpdERZbGdiNHZIWWZpOFhLeExzSkFtWFZta0NPMklvcGdpZ0xHTkNp?=
 =?utf-8?B?Kzl6SW9kZjBvaSs4akt4N2UvZEFOOUkrSXhqbXVKejVDaUVHTXEwN0Nxd3hM?=
 =?utf-8?B?QXRGTTZUdTlZKzhYV3BtY2RJK0VuTXIrNDZsOEdTZFlUK25qaHU0WHNGRDlt?=
 =?utf-8?B?NUNNWkdyR3pnYTNzblRyb3BVMFptd202dWg2djBPejVDamxKaFNvUStSWHNi?=
 =?utf-8?B?Tnl1dFJySXpsbUNINUV1OXhkamIvbmZlaHhXRzdqazhPeWh1aVYwVHpFWFFI?=
 =?utf-8?B?MW5LaVBkeFhNUTFXa1Ftd1pZM04rS1dQUU5TVzhUTTNXMzJBQ0FVUTRaRDY5?=
 =?utf-8?B?MzdYWnhqT3J6UCtWM2FQYkk4ZUtUYnR6R1lkb1FNSHd5RElwS0ZYeXkyTEdY?=
 =?utf-8?B?cm9MYzFSdHd4ZnNjR3FpUXZNRUk2ZTdRZnBPQUFTNnBrQkJvbkZpR0lXU056?=
 =?utf-8?B?REFKWHlnUUovVWZMeE1pK0w3b3VIcnhIbk1RTFlMejFONlBHTmgwU0poenlG?=
 =?utf-8?B?enJnU285OTIrUmRkWFFFalhkbG0zdDFVSlR0R0JSNEdRQ0dkaXFGb2FWT3Zm?=
 =?utf-8?B?ZWdaODhKSmJKWldHOFFIaktlSmpYdUdDT2N2UHJtQTRnMFpPSm82RWE4alZJ?=
 =?utf-8?B?TFA5akR2MzduMEJCSDNvQzl5M2lwTU5CRGh6OWhLZ0dxWVNxbGR0bGU0Tk1M?=
 =?utf-8?B?MnFiZU5HQ25BWjlMNHp2bzFmdnpCTGw5ejRselp6RERQSTFmcWw0TDFFVXBZ?=
 =?utf-8?B?OWNKajc1VTBEa3R0Q1ZTY2lUd2w3VUpDZ05JckdxTVBMdnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um5FdUpvTGw0RzVMa3ZyejNjUm4xMVRqS3JCNW5WeFpQN0NBRHFaM2NtczBW?=
 =?utf-8?B?WGpMYklXN1IweUJ3ekJMemYyeWUvKzJPRHZWQlFDaW1XM1JsOWd4dFdrdkRu?=
 =?utf-8?B?QjAvYjJlMlZzbDBacG5MZ3ExbXNUMllVMHJuRW5LRFVZNGxNM2sxWUpDY0xu?=
 =?utf-8?B?K0xwQmtpaWw5NzVuTFNyQjBkSys1VUpFSTJ6ZmZYeW04L1VGUkRmRXp3K1li?=
 =?utf-8?B?NUF5aG9XamxhL045SDhTZ0ZpYXhBRStzWlk1RXdWaUltUE1oajBWQjY4akd3?=
 =?utf-8?B?SnRNMHRpR3dNT0FPVzZlZXZKT2pCU0lTa2MxeDNRTDdoWkNnQTB3SUdNS21S?=
 =?utf-8?B?TWVpcnlpdjNENVpCYkZWRXBNbTJTQzE4dTUyL0lmTWczTFVoY2VONFIwQVdL?=
 =?utf-8?B?S1Q0SmpYb3Y4bm1PRkJNL3RLZkk4M1hwWVZjWnRXclJWK3JRdEtPTk1VOEdu?=
 =?utf-8?B?NElNRXJCeHAzUWNlWndhanFFU2M1b3BONHJ2T2R3a3I3d2ZSeXZCQy9KbjFN?=
 =?utf-8?B?WDNwNTloNFRXd21XMzRreFV3MjdwT0c2dDZKNWZIL1F2U3pqTVdycGtHVEJI?=
 =?utf-8?B?T3Nsa3pzamdaQXMyZTlYS1d5UFJsdU5Oa0pZcXpwSVpTM3laeXlaZGUreWdS?=
 =?utf-8?B?QWxrL01XYVp2a0ZhQlNOcGFuMGo1OTJJVlU3dTZXY1BqZ2ZRZUdCKzNpVU9x?=
 =?utf-8?B?TnBtM2l4UUxyaWwvK1NoeGlVcTFUT01QbzBEV1g4bDQ0RVRubDVjb0F4NEdG?=
 =?utf-8?B?R1gxSnVZODZzMnYvL0xPOC9aSHUwVFBZRWQ1MGZHL0xVdCtsam90T2I0RjNx?=
 =?utf-8?B?VGR3ZGZ3bW1pWGNBVUlBMjFBUFJXTjlzQ2FuUE1vampXVjBTNHpmeE1QM2RC?=
 =?utf-8?B?UUtGem1COHV6Tkx5UnF3RE43bVJab0xuYy9TeFBWZCtJb1l1clhFOTlRL0tW?=
 =?utf-8?B?ZmU2ZnQwcXhLOHpGZDNnTzlyMXJiRFgrVWhuL1BIZ0VEMlJRUXBaYU8vWEFJ?=
 =?utf-8?B?ZFVIL2NyS09iT2E3c0JWWkpRYWRWb2VsY1M0UFlvTmJiTWNYZFlYVmsxRkpE?=
 =?utf-8?B?aVpER1lEQ29GUHhzV0huTCtxckpMdXV2Y0phWnh1VnJqTFUzbzcxcWptenV1?=
 =?utf-8?B?Sy9XSUhadGF6cDdoTEk4b3pUNmw3djZQSTJ1dmNTMVFhUk95OU5mZmM5a1hp?=
 =?utf-8?B?TzBnSmcraUV3TjVJK09NWVppZ0xmekF3SjU1UFJtUHM1QlhFRG13SE5UWmNU?=
 =?utf-8?B?UUFRcXlvRVFEVE5adEE4czdoTE5weUl3Q25mcUVvOWFmZnlOSmZvb0dHaVBN?=
 =?utf-8?B?MWs5VVI4K1hBTjNLWHg3SFRVMFpFY3B5N0hhYVQ3UmNiUFNnY2JYMEZXRzZM?=
 =?utf-8?B?WjRTZzVqSlcvK0ltMmxwQUt1eDZoWkgvbTROYkM5KzJ1SkM0ZC9YbVlZOTIy?=
 =?utf-8?B?aUY2QTB5NDY0dkhVbnFkeVFTcnIzRXlVaUZQSVhKa0pORVU0VzZhSXpUM09S?=
 =?utf-8?B?c1FDRjFNdVR4OWNtbzY3TjdwTVp0cC9JVm5EKzFuYnRNK1l6TEdKV0ZRQ1B2?=
 =?utf-8?B?N2djSi9iVlo0NTd0cjE4bmwzNFlxSzNqb0xUTFhwM2UyQkdtSEh0ZENOeWND?=
 =?utf-8?B?eWtwcFR1ek53UzI4Z1NBOVdQL2I1SnBhZjZLYzFWZTBpUUtud2EyR3VPVTQ2?=
 =?utf-8?B?Skx4dDNBeHhESW1PSkhZd2JtVEpwUUVYbjhtbmZiS2ZYSnlNZVlpejZ6d0p5?=
 =?utf-8?B?V1ZSNEcrVFFCaCs0bXdoZW03QzdwVXdFR2NkTmFCeDF1Q3B5aTVTNVJxR1pK?=
 =?utf-8?B?SUlpajlXU0VIRDdwUE14Q2tibUlQb1Q3V2RtWWtPc3dUcmpVTmhidVdqTUYx?=
 =?utf-8?B?SXNtSHZVcUlvYTRoeHUzWjBmbFZULzRXTDRMV1ZQZ3dwS2MrdXlteXdteUJU?=
 =?utf-8?B?a0hmZVoyRGdiTDhDRlJ2Z1lFVHEvRitlNU5CbWVNR08vUFNZdW80ZTVCVEpp?=
 =?utf-8?B?M0NheXM4cjNGb1I5THI2YVZSa0NCVXhwQ1YvMjVZRCsrRTVtRzg0Z3c5WVVB?=
 =?utf-8?B?ZXJLbWhFNEJvdDc0cGpobzJ5NVlhKzRBWmNNNXNoOUp6NHVMSll3eU91aDBK?=
 =?utf-8?Q?EotRl5f+IoR8o4Yo9AcQntBZF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207b3355-30d7-4ef5-365c-08dcac8309b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 08:23:18.3011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HSnJhNaS25N3k24MeC8Mo1RGXsMmTuIMoPeoz3l2nStYBQr1RibdFRI9ZCDJLiGm4OObrJlIKvur/z+ri3HiEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9894
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

SGkgTWljaGFlbCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNo
YWVsIE5henphcmVubyBUcmltYXJjaGkgPG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDI1LCAyMDI0IDM6MzIgUE0NCj4gVG86IFouUS4gSG91IDx6
aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyB0cmluaUBr
b25zdWxrby5jb207IGx1a21hQGRlbnguZGU7DQo+IHNlYW5nYTJAZ21haWwuY29tDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGNsazogZml4IGNjZl9jbGtfZ2V0X3JhdGUNCj4gDQo+IEhpDQo+IA0K
PiBPbiBUaHUsIEp1bCAyNSwgMjAyNCBhdCA5OjE24oCvQU0gWmhpcWlhbmcgSG91IDxaaGlxaWFu
Zy5Ib3VAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpo
aXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gQXMgdGhlIHR5cGUgb2YgcmV0dXJuIHZhbHVl
IGlzICd1bG9uZycsIHdoZW4gY2xrX2dldF9ieV9pZCgpIGZhaWxlZCwNCj4gPiBpdCBzaG91bGQg
cmV0dXJuIDAgdG8gaW5kaWNhdGUgdGhlIGdldF9yYXRlIG9wZXJhdGlvbiBkb2Vzbid0IHN1Y2Nl
ZWQuDQo+ID4NCj4gDQo+IEkgdW5kZXJzdGFuZCB5b3VyIHBvaW50IGhlcmUgYnV0IHRoZSBjbGtf
Z2V0X3JhdGUgdGhhdCBjYW4gY2FsbCB0aGUgY2NmDQo+IGNsa19nZXRfcmF0ZSBjYW4gYWxyZWFk
eSByZXR1cm4gLUVOT1NZUy4NCg0Kd2lsbCBhbHNvIGZpeCBpdC4NCg0KVGhhbmtzLA0KWmhpcWlh
bmcNCg==
