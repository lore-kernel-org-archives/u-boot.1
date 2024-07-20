Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6558C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C7C88675;
	Sat, 20 Jul 2024 14:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ogga.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ogga.onmicrosoft.com header.i=@ogga.onmicrosoft.com header.b="YFwDFNle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A2148839A; Sat, 20 Jul 2024 13:21:45 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D0A088655
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 13:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ogga.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zli@ogga.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOtPtr3KWYuJcCFzr/iCfPIDOMI09jWwytFEtjak3qRHdYntRnzlwiErXHslKzOWI9Vjf9M03c2GY/1YyUVcM0uaf7NIW1+kg11rcjXGKEbDZHfI59xaTVUnhz8iWJBV8abZVWlMOyjZ3HInJ5hZ6EjqYjJLYRzlSq5VuklssbBV4CplqakBj5o2IQXQpHr3xnB9rSDUmKuBoSoyqSJgfusTQvLh4YAE4ajT9736gwVAGKIqqgGaScYlPF31I0iVHqfJRDV3QWiPoMmfYdq8EIwt7vHaHHhzavimvHnIz44hHZVOqlXFOQq/+mpT5UpypLtYS/LD7+IviBBsSzPlnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvF9h6LSxqkFWxSxENb00NlcCabQgBZvkKQS58suzI8=;
 b=BOpzPUEMTMSbr0gmE1VtqafAM0bHl1TZyyuGzErFx64gMLynRHUgo6QT+UVAwlcwJyg4gNwlIABdlFEPl2ykjLv+L+GpIMFVrpN27sOCwOqdqbq3NoLHwi3nWtgXTd13tQ091o91wJjHkJ8l0cuXBqEUR4LNiPVc+MvtmUkviESQhfWNYet3Xd4BL22xGUCshoijLi0RH/O3es8fgXg/BuDbOUXPvppG2XPu9vnnOxG+AUf6AbaItwNxdwBt2k2ZlzVhNWDBe0ltxoiQg/YIcxmrhqifHRDm0UaYn4KG4IgY6E/LGWbXcaasn3dw5eAtcnmQ2jRBv2ypxAV43JFZ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ogga.fr; dmarc=pass action=none header.from=ogga.fr; dkim=pass
 header.d=ogga.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ogga.onmicrosoft.com; 
 s=selector1-ogga-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvF9h6LSxqkFWxSxENb00NlcCabQgBZvkKQS58suzI8=;
 b=YFwDFNlecT4Th1es+h1GZpxtOgNvGc6P1AwBqO6vdoaBb5D0hHqu/8woLEOhT+GcUTmunED1AS7jjrX4Ekajxz7nFwCZDbyJcNN9eJKayFkv8gOAae7Z0nQAJf3SmFs/hRZ3mDdWNJSTjL7vcwMJcY8pEAidnEAiHX4FQHmpPJU=
Received: from PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::20)
 by PR1P264MB2248.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Sat, 20 Jul
 2024 11:21:39 +0000
Received: from PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ead1:fb5b:e337:d4ff]) by PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ead1:fb5b:e337:d4ff%6]) with mapi id 15.20.7784.017; Sat, 20 Jul 2024
 11:21:39 +0000
From: Zixun Li <zli@ogga.fr>
To: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, open list
 <u-boot@lists.denx.de>
Subject: usb gadget driver initialization issue
Thread-Topic: usb gadget driver initialization issue
Thread-Index: AdraksYKvUdWMPd+RkiQx27iAfyB4A==
Date: Sat, 20 Jul 2024 11:21:27 +0000
Deferred-Delivery: Sat, 20 Jul 2024 11:21:06 +0000
Message-ID: <PAZP264MB2974BB43BCE300D4A9E2FC63B1AE2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ogga.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAZP264MB2974:EE_|PR1P264MB2248:EE_
x-ms-office365-filtering-correlation-id: 45fea817-2f21-4b63-4b98-08dca8ae1fb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eFlIbnpUNnJqMUhJWDA1MEgzNlJ3SlRScGlKUnpsU2Q2K2F2QnZ2UVlrZ1BY?=
 =?utf-8?B?SmJCN0hSTkIyOGNNMWlOeFN3MTV3dmtpQkM2ckhUTTkzRU8zU092NWtpVndo?=
 =?utf-8?B?WFp5N3Y1ajl0TlJlWnRuT1BkK3hoRkhVM2xxMVhQY2d5bHpBblBBRURybjU3?=
 =?utf-8?B?RGtNdDU1VmIvYkRBUk84TVA0RFNPeWVycHc1alkwTXg4QTdYUXMvbTYrUEc1?=
 =?utf-8?B?elB3YXRxQTVqN3AzUEVEeVdaSXdzbVJLeXgzckJsSlluV2V4SlNMQXNYLzVx?=
 =?utf-8?B?T01sRGhROUJOd0pLeHhVQlRYbk5mY2Rud0hFNWN5UlVxb3ZkeVUrUTlIRVJy?=
 =?utf-8?B?SHgvbURxa1FmZkFHU0toVEtFbEtoOHk3YWtCVHJQdUxaM1ZCMXUzeUIxekY5?=
 =?utf-8?B?Vmpra0tyN3VBREpUZXNMdnA5SjArTzIrZTNPVlhzaTZaK0hGSjNsdFdJNXZj?=
 =?utf-8?B?MEJIaHlXMFhOd2lhVTJDUklsYnkrREdTbUhuYXEvOU0rdWFXa2NEbGJNNFVZ?=
 =?utf-8?B?SHRTSTdRUjlnMDQ4dkZYUWdlNW5DYjNURWxGZVpSR0ZuUXJGanVTNVJHU3NW?=
 =?utf-8?B?eGZZaVVCbU5NdXgrTDhCeFpoMkgwNkZwa1NvbnVuaWdSRXF0Ny9NaENuelVh?=
 =?utf-8?B?bkJZVUlTTktxZVI1UUFVVlJxQldEeTBOcWE3YlRvQUVTL0x1V082My9xa0VG?=
 =?utf-8?B?WVFkRFpsbzZnMy9qbGwxK21RZmdTd2hqT2NNY1c0cUhnNGhvV1dMS2QxeFVH?=
 =?utf-8?B?WVE3NjliTDhTcUFsbFFqeU95dmhnakJ6RSs0QXR0UzdLelBCeW9GeVg0cHZT?=
 =?utf-8?B?bUo1d2tmTjcydDlWL1p3dHY0NXdYcWRvcGs4Rnl0V25nY3Y5RStHRko4WHBj?=
 =?utf-8?B?Ynh6dlFscTdUaHBUUEJPaG1GTlo2Ykx0anFteTdoMFB6bnp3RElleFdKd1Uy?=
 =?utf-8?B?aEg5b2oybU1FMHh0Nmh3VVVLREN5a0hLakVORWRDbjdOT1lDZ0x3OVowL3Mr?=
 =?utf-8?B?MHFyQnJMRENHdmFXNXlpZVExcURkSS9tbU9tbFRpd205Tlh2OWF4OG9Eb2dv?=
 =?utf-8?B?SSt0dW90QTVOaGVJVFAxd0JpWGI2U29mRFNTWXBTclVpa2JjZjhWNmlyekda?=
 =?utf-8?B?ZVVaNzU0M3ZFb2FUb09lVFdhNFhCMWtYdVhCcnRVQW9OdkRUaTRRS3ZGSTVY?=
 =?utf-8?B?VllTSTM1NGFoTk9HM01sYndpYlJ6ZHlEdnlRN3FWUUZtQ0d5U0trK2xtbkNY?=
 =?utf-8?B?WmFZeEVuYlBJdnhZVW90Y0tTM0ZPMWJQSEEwUzdWUzlCTnNRV1dtSkU2MjM3?=
 =?utf-8?B?aWMyaStkekNUOWloV3o3TDFMUUh5cnQwZnZWY3NPU3pGQmV3amdnWVdHOFAr?=
 =?utf-8?B?OGcyM1dSVGJIcUd4WnVxNUIzaU5KM2hkQ20rc25iNm9YTnlwTVJzVVZqT0R0?=
 =?utf-8?B?UE16bWtjY1VmbzNOZWFURFozQmpXOEtmQU11blN4NFEwK3MwSU8rdEl3bU9k?=
 =?utf-8?B?TExSNEVZQktxOFlRQUZ0YVBEV21uZHhud2l1TWlTeFU2VzRIL3diNUdENFdn?=
 =?utf-8?B?UC9iSHJrT0Q0V2RFeXFjeUg2Z3p4R2FWM2xDV0dPOVJ1U1g5Q1EyVjlWTUd3?=
 =?utf-8?B?ZTBKK3FnMG0yakZ0VlNEeTc2TGx1YWxxS0JiQklqYkdrdlBMd3Fndm5PQWds?=
 =?utf-8?B?a2hFUFZNZUIvaUhmTG5pT1RMbTFCbkdOSVZZbXhPZHhYZ1MyeVZUUEEwSHVH?=
 =?utf-8?B?UnBNK2twOTVJdUluK1VoTHZmTlVzY24xYkkrK1FWaHRqREFKNGNSSEU1WnB2?=
 =?utf-8?B?a1dHdXBvTElFSzlWTTN5VVZORE1STzFJM1E0Y2JqSHpVTjBpVlorSmJURndG?=
 =?utf-8?B?b0t5REtIaTc5TXRDWXhZeVZta2lyUWJRYlZ3RXlPODMyTmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFFkanRBdG9hWWwwOHlBMG5UU2RWV25lSlZuWG0wT20rTGdXY1B5QVduYkF2?=
 =?utf-8?B?bEJXMFVPMnRvcWdEWWE5SWd5a1UvRERLQ2RkUkxiZkpzNEZVT2YxaUJOWmM5?=
 =?utf-8?B?dHl0R0Q5SnlhUjdzZEZSZ1pvU1NMYXZFKzUzZUZWanFOQ0QvNXpRSjQrWUVW?=
 =?utf-8?B?azRtcnB5RFNnRDVGejVLVkh0cnk1eGlkMXc2Wk50dzhhNGE4aGVQUDhudytW?=
 =?utf-8?B?R1RzVXJodnUxV1pJTklML1RheDdOWCtzdTJwVkUzVTR1NDNQZnRwR2gzZENV?=
 =?utf-8?B?NUREdjFCekpocVZROGswYWRjR3JLS0k5SWVKL0VKU3llcWpaWHg1eHFvUGcy?=
 =?utf-8?B?L1d5QW5OaGYydTFadXY0NElsT0pTb2pJTGJlYWxmSDFzTHlOdEVvVGZnaXpv?=
 =?utf-8?B?UlZ6cVVTUkJnZW5wYS9XekRFTmtKdm9zcGlTdkYzalhVcHNPaVdWS2dCcms0?=
 =?utf-8?B?eDRyM0tBVVl0a3h3NXFHUVVBV2RURE52WjRVRUZFM2ExWHljNW1NUjIxZkJy?=
 =?utf-8?B?MzhibG9qWG9ISG54cTM3NWtxbmRxUGNMSFp0MUcwVFkyWU94ZE96R1NaVFpF?=
 =?utf-8?B?aTE3ZjFxaEs0aGdQNTFnNnZQSk1EaGZyWjhqODB1TmFzTzhwY0lMSlVDVkMr?=
 =?utf-8?B?WDFTTjMvUjJ6eDJVeGtGMnFFL3VtUGN2Q25lNWlIRnh5SWhxbHVuSVpKbnNJ?=
 =?utf-8?B?NzhqTUFvQ21qa3BQQ2ovbFFuV3NtQ3pyb2FoWFlmMDlxUmZibzVDMUhadGlx?=
 =?utf-8?B?dVRsNGhPMHpUL0ozYmp3K3NJcXRsR3ZpcWtSTU9PR3Q1eTVXTUxzV3pFdktw?=
 =?utf-8?B?d1BnUzZLYjlJY0N0S0tZeVBIRVBLakdMVUhieDJlKzVCd2RUeEpVZ3QxQ2s5?=
 =?utf-8?B?VWpPL2dBazdoZFRJdXgxU3A2ZWN5L2RVZGF5MGFtcXRQOCtVTGpDT3JkcGU0?=
 =?utf-8?B?dnVlWVBUUWZwNkFSQTFwVHYyNXRxSHMvaWpzdk13bzY1azZobEFxSDYxSjdO?=
 =?utf-8?B?SFJwaGd5czJqY3FOS0wvQW9scnpIT0dMOUxFV2VoK0tYYm1KZkpkMmJvR2RB?=
 =?utf-8?B?aEU4WVRhK0paQUdBWTB1cisvNU9QRnVpTnBwYlY2SkQzQ1plbWloTk1FNzZ3?=
 =?utf-8?B?dWZvVUsrL1BUNzNLZlVPWitSZ0RMbHF2NFp2eHV1OVlEQWw0bmtQcGk3QUtY?=
 =?utf-8?B?RmhOMUxZV0NwSXp1Q2hJVXBobEwxUVhrUmc2OS94RlBSRzJXbXFDa0RjODNN?=
 =?utf-8?B?MDI3SllHQnovaGh4aC9hdDFqV2JvSkpzcFl0NThxbTRFL2ZDVlZsUGZnVTlL?=
 =?utf-8?B?eDk0RXVlOHYvQ0xUUnY4Uk5ISDlFWTJBUXQ3b3d0cWpBdWpxaDJOUDY0Nk5M?=
 =?utf-8?B?eDZFWmp1dmRXc0tpMm9CTElIZHY2WWNBS3doYm1pNzNGSjM5VmYzZzk3VG93?=
 =?utf-8?B?b2U3L1hnd0diMkx3V3h2TDFqQ3VibHdScGhoZlNQblNBckJyQzRCdFpyUTVh?=
 =?utf-8?B?MmlVT0VDUlZsYTk2dEVpd3RSdmRMWjZCbmd0MTg0R1IwRTBXVllrcytRRHlp?=
 =?utf-8?B?dUk5MmlYdFRzalBNZE5telorRjFJY25iTVJ6ZHdlQjhweVVVVEJDcVpBbjVv?=
 =?utf-8?B?dCtaWkJEaEJGTTVtUnVzeWFWK1d4cVVLR0VCd21EYUZxZkxQMlZOL0t0bzBj?=
 =?utf-8?B?T2FzTnZsdERjV29ZTlExS1lacEJQWUYweW1iN2Q1NXlZV0ZOL3ltS25SZllK?=
 =?utf-8?B?MEJDdjZaT0hlZy9SOUQ5UE1jVEs0UWhLQW04MGp5SnpzemgxT0ZwR3paUEtx?=
 =?utf-8?B?aElNWTR2cnJ6SjQ4NXdTaGdIVFNFNmdFTkdYZnJjVjlsMXF0K2ZNL0lnenJn?=
 =?utf-8?B?QXBlbzJURnNLNWFndTY0bURMMk42dGNQTTVBYTV4c3dYeXo0V1dDMEJNdy9T?=
 =?utf-8?B?a2ZVaWhWcWtFSTVibWh5NERsMC9PVHVqMnpxWFNlN1FhWFlWdnFqaHUrTzIy?=
 =?utf-8?B?WlNqSWwveDFIcm1FVld3NUFhd1d2T2tSQnFreHZqUlRybmN2NkJwNzlwQmdW?=
 =?utf-8?B?aGRZcWduVEtkazFvYkVWbHdaUnZHSnQ3S01ZVzJDcUhVY1RrbUdpbnQzTlJ6?=
 =?utf-8?Q?BElQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ogga.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fea817-2f21-4b63-4b98-08dca8ae1fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2024 11:21:38.8830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a737871-c9db-44dc-a24e-55df547c3098
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0P8vs9WOV77/c4arE6azPvoA3VbpKFuoTeX8UX5IIWpB5DCbVL6h2YKFruhyXdG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2248
X-Mailman-Approved-At: Sat, 20 Jul 2024 14:54:48 +0200
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

SGksDQoNCkluIHVkY19iaW5kX3RvX2RyaXZlcigpLCBVU0IgZGV2aWNlIGNvbnRyb2xsZXIgaXMg
aW5pdGlhbGl6ZWQgYnkgDQp1c2JfZ2FkZ2V0X3VkY19zdGFydCgpIGFuZCBlbnRlcmVkIGNvbm5l
Y3RlZCBzdGF0ZSBieSB1c2JfZ2FkZ2V0X2Nvbm5lY3QoKS4NCg0KRnJvbSB0aGUgaG9zdCdzIHBv
aW50IG9mIHZpZXcsIGEgZGV2aWNlIGlzIHJlYWR5IHRvIGJlIGVudW1lcmF0ZWQuDQpIb3dldmVy
LCBzaW5jZSBkbV91c2JfZ2FkZ2V0X2hhbmRsZV9pbnRlcnJ1cHRzKCkgaXMgb25seSBjYWxsZWQg
aW5zaWRlIA0KZnVuY3Rpb24gZHJpdmVyLCBhdCB0aGlzIHN0YWdlIFVTQiBldmVudHMgYXJlIG5v
dCBtYW5hZ2VkLCBob3N0J3MNCmVudW1lcmF0aW9uIGF0dGVtcHRzIHdpbGwgZmFpbCBhbmQgcmVz
dWx0aW5nIGVycm9yIGxpa2U6DQogICAgdXNiIDEtMTogbmV3IGhpZ2gtc3BlZWQgVVNCIGRldmlj
ZSBudW1iZXIgNTAgdXNpbmcgeGhjaV9oY2QNCiAgICB1c2IgMS0xOiBkZXZpY2UgZGVzY3JpcHRv
ciByZWFkLzY0LCBlcnJvciAtMTEwDQogICAgdXNiIDEtMTogZGV2aWNlIGRlc2NyaXB0b3IgcmVh
ZC82NCwgZXJyb3IgLTExMA0KICAgIHVzYiB1c2IxLXBvcnQxOiBhdHRlbXB0IHBvd2VyIGN5Y2xl
DQoNCkkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gbGVhdmUgdGhlIGRldmljZSBpbiBkaXNjb25uZWN0
ZWQgc3RhdGUgd2hpbGUgDQpwcm9iaW5nIGFuZCBjb25uZWN0IGl0IG9uY2UgYSBnYWRnZXQgZnVu
Y3Rpb24gaXMgaW52b2tlZC4NCg0KSSBzZWUgcmVjZW50bHkgdGhlcmUgYXJlIG1hbnkgRE0gcmVs
YXRlZCByZXdvcmtpbmcsIHBsZWFzZSBmb3JnaXZlIG1lIA0KaWYgaXQncyBhbHJlYWR5IG9uIHRo
ZSBUb2RvIGxpc3QuDQoNCi0tDQpaaXh1biBMSQ0K
