Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1F2C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 14:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEABD87AF6;
	Wed, 25 Oct 2023 16:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=wiedemann-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=stwmm.onmicrosoft.com header.i=@stwmm.onmicrosoft.com header.b="W6FgfbJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32CC687ABB; Wed, 25 Oct 2023 15:43:47 +0200 (CEST)
Received: from mail.sensor-technik.de (mail.sensor-technik.de [80.150.181.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 210FB87AC4
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 15:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=wiedemann-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alex.michel@wiedemann-group.com
Received: from stwz1.stww2k.local (HELO stwz1.wiedemann-group.com)
 ([172.25.209.3])
 by mail.sensor-technik.de with ESMTP; 25 Oct 2023 15:43:39 +0200
Received: from stwz1.stww2k.local (localhost [127.0.0.1])
 by stwz1.wiedemann-group.com (Postfix) with ESMTP id 854E1B5ABC;
 Wed, 25 Oct 2023 15:43:39 +0200 (CEST)
Received: from mail.wiedemann-group.com (stwexm.stww2k.local [172.25.2.110])
 by stwz1.wiedemann-group.com (Postfix) with ESMTP id 4025FB5AAC;
 Wed, 25 Oct 2023 15:43:30 +0200 (CEST)
Received: from stwexm.stww2k.local (172.25.2.111) by stwexm.stww2k.local
 (172.25.2.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Wed, 25 Oct
 2023 15:43:30 +0200
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (104.47.51.233)
 by stwexm.stww2k.local (172.25.2.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32 via Frontend Transport; Wed, 25 Oct 2023 15:43:30 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCwaIy3jruzBbWzMYpcExbFtAmnrhJV/0ukkzR6PHkE1J6QT6jdwFeHrtIGziY6YFVhmhg/y7u5FzMrTRgrdELmtdckqJp+lmpk4Z4KQsvz6XkgqLxbOPJzggSjayluiL8HPpN2Fw1/2WcsE6HKiO5tj62OKj/YJMejkvjD2juiEVP07xP/AYd34nq8W+W52cuq4sCnznsPmxa4xFIKHGcs00oqspLLASB1NmZTRbZdNTjTtAgDYcmuD6+wb44qY0wOh5sKzfrTkmcRdKfQbLIftbZTFoEsIqtF5UsTDjg83Y0uZsjC5K5DxwpmIgc2nE+JI1wO503Ms0rT6bv42/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpeVlDg2N3CwCBbWbN5MsAH9ZyZf7YK6ftsrgL+l0hE=;
 b=Fe2RVgB5DGPkg/hdzal3wvbp3P9kHceie3uhFWGiF18FODs58klh7zhUTi8abfhBCMW/YdM6sAFnFGr5f9cZLa6TzI8Lz5YwZiIfxvQLHvA9Qfkvx+yfPZP184KoLCztb9/Zt+DbrqpfXwqvPtdo6k1GxMm630RZI33zdTI4YuTEfy8VNjE9y3g3guoPLlfFHjSbQXoeRzMVxWqv1oqvtYgeQrJIQNw2D7YgMCCwpZJpEqDCTXTGFF5pGoCepD9hgVRkbbU9+9mK6aU/C3XbeVdBoNhKgTM4QkUNb2loGm5L5wXOR+bqYHMT/N+v3imBItR1cGqU9NSmFp5m/aFamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiedemann-group.com; dmarc=pass action=none
 header.from=wiedemann-group.com; dkim=pass header.d=wiedemann-group.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwmm.onmicrosoft.com; 
 s=selector1-stwmm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpeVlDg2N3CwCBbWbN5MsAH9ZyZf7YK6ftsrgL+l0hE=;
 b=W6FgfbJgarEVMuoKFV8NmPDTRtDZ0v4I1Ko0kUnXoHA5OaFLuoWp8lodwpxR+z3CaeI8xnV+8lbaffdfl6cRN8Nv4orNSIdplxbqq/AR3nTR0/ifvpdc1lsVZesloJcB0YWMBRB+SvMqkjaA+bODyhpsDXW84dZ3aCFp300S6B4=
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:48d::22)
 by DU2P250MB0141.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:239::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 13:43:28 +0000
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::3848:f440:3c65:5e82]) by AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::3848:f440:3c65:5e82%7]) with mapi id 15.20.6863.046; Wed, 25 Oct 2023
 13:43:28 +0000
From: Michel Alex <Alex.Michel@wiedemann-group.com>
To: =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
CC: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: [PATCH v3] misc: i2c_eeprom: consider pagesize when writing to eeprom
Thread-Topic: [PATCH v3] misc: i2c_eeprom: consider pagesize when writing to
 eeprom
Thread-Index: AQHaB0k8fclo6LpSakerEcgKxm8NEw==
Date: Wed, 25 Oct 2023 13:43:28 +0000
Message-ID: <AS1P250MB0608FEE6029FBF1697FF45F5A9DEA@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
References: <AS1P250MB0608EFCD6443148D5D9837C6A9F8A@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <20231024231543.GN496310@bill-the-cat>
 <AS1P250MB06088A3DFC19C7673DB0F551A9DEA@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <20231025152526.4c3c18c2@karo-electronics.de>
In-Reply-To: <20231025152526.4c3c18c2@karo-electronics.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiedemann-group.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1P250MB0608:EE_|DU2P250MB0141:EE_
x-ms-office365-filtering-correlation-id: a08b9af7-5770-4e90-2dfe-08dbd5605eb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dUJac8jk/haeR7wX09ka9dtIiej3oVjDQBxqVx+V4A6hoAvEi/E1ZqgJnaM/AYiRTf/lnbZ1Kzs1914YdskWwd5cAhvnlw7TVZOn3Wz6TTCNdgVF4IWnGkFkTG4SFuSqTlCK/iPeZ0EgWS4iKPrUiX/PhNw0jevqex2UW1k4B8DyYwyCUQvhyPHNGxp4VYdUE7STzuwgYl5wAGr1xAqY/rqNbnBoldpoL5k7d4uECugAd8EGCLSYox5r5yRFWcmQbYouAxa6Df12rxnH9Jg0G7l9hJ9Hx0SEOwGLO3RARG15k7iZAXsFdhFjFv9vCu+NhC+iyGNH/wCcjj/SWn5SYSEymCc8g7ZhbV+XvnUnwTVbWrM+Z10hHLNMjpfXBfuUXAcgLTAIpLpTSX6YvwgflSo14oYVpNhElt47W/TJqPq90pnsLhJBG36EEQx+P3nw30crlfelDpsjhXna3vjmN+i3UiuORCOagg7LSwPO58PtGWDkiPiZrYj44hqMrFWc9UW3niXgyj6WgJtapg7pKQMjZ0/FiTBo2aj/y95UpdVaj36g43KGH+6MD34DptyzYqmZ8IOI4PPFGA3sY8BXrybiI0tTUdbFV6eC0ujQpt1PdHt6YVHC8KM2K13J9wXd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1P250MB0608.EURP250.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(39840400004)(396003)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38100700002)(41300700001)(2906002)(86362001)(33656002)(122000001)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(26005)(54906003)(83380400001)(6916009)(316002)(38070700009)(9686003)(7696005)(6506007)(71200400001)(478600001)(8676002)(55016003)(8936002)(4326008)(5660300002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXZHZVJSTTZRNjBVOERGUVkxL0Q4TTQxRUwrYTdKcllTNFFaOUpWSHc3Qkhm?=
 =?utf-8?B?d0VQalg4bS93K092NGVNMWVjOCs5VVVOcWNQbHVQYmpkSzd4SHJPZmlDWWFI?=
 =?utf-8?B?aVU2YlFwaU0xZ1JKVld2QkRRcHRlUk1KVG13bUhRczhlNUptNm5iV3J6cHFI?=
 =?utf-8?B?RFliK2p2cDgxdlF0NkFydUtCRGEwTFFxbS9pdXcyb3F1TUZvYXprV0trSlVv?=
 =?utf-8?B?Skw2V29vVHNReWZOUEJvN0FyU29SZUd6eWJmcHlsTk5ueXRuc251alVYS015?=
 =?utf-8?B?VlM4d1hkbVYyRHlURnVKKzZHUjVBQ2R1WllOa05Fcmw1VUcybTBWRWNHSGlt?=
 =?utf-8?B?a0J0QXdLUW9hMnRDaDdXNm1pdnkzdzVERjhONFlPQkxocEVaUWl5eUlCNWM4?=
 =?utf-8?B?aml4NEt1dTRiM3krSzN3MU9wVWcyTHhieVVoMHhsYm10bzNtQTgxZzFaeVV2?=
 =?utf-8?B?WmxCVTRMc2x5WDRTZGQ1ZGZaSkw3MlZVeUdkNC9ad2h3dkRhUHAzeXk2OUMv?=
 =?utf-8?B?SWZoSXpQRmpPUG1FZXE1WU1ZQjJkcnF6RFA2S1MrZWZteVdSWW5mWVV2MGFC?=
 =?utf-8?B?ZEtuS0NtMTlucGF0eEQ0cG4xakhRV09SSVU5b2FIYUlIMVRSOVQ5ZlVyZjlt?=
 =?utf-8?B?RlFaejdKRjM5S1RoTldDTU9BS2RpYlBQeTMrV2VjVTNyL0hSczYvM0sxcUFL?=
 =?utf-8?B?UFBuN3kvRWVPMnJNemV0a3JRaGM3R1ZMRW5NYzdzQ2lsbU94UWNrbkhHbFBV?=
 =?utf-8?B?anR3L2FmSytvNnR6a0k0OGE1UXltWkZ4ZmlhVXk0TzZyblJCYTdnMytVVHlr?=
 =?utf-8?B?eE9GOHRSUUpyS2Frb3VIWWlsUmZGVkVuejJyTHBBQkIwYlRmRStTQTZrTCty?=
 =?utf-8?B?TUVLMHljWlh3QzRDS280N1A4d3NlTkNoY0tJcXFnb3NZb3F4NUdkSHVsMWht?=
 =?utf-8?B?ZUNKcmprc2hNMTJlZSsvSmVYZXA1cWhsOG9FTnlnaHd6VGdWR2wrMlZWVXdj?=
 =?utf-8?B?UEVYQUVHcjdsNHd5MkdROGlxNGxKc3ZhU1BjQkM1Mm9tVE5PMW9zSnBTcXRo?=
 =?utf-8?B?TFdmZ3g1WjdvZ29XVHBxT1h2RVBtaU5PaTV0aGNWL2xJRjJBeS9LWUhvRi9m?=
 =?utf-8?B?REUzQURuQTI1aHU4QzJFM2NLZUpCb0NDZm1PSjg5cGFiVStmYVdYNjdaSGFJ?=
 =?utf-8?B?a2lSR0hWNzFKTWF3WHVONk8vWUpEN2RCQjU5T3dwMlozaTU4K2ptYzcvR0FU?=
 =?utf-8?B?d3pBQ3MyV2kzOVlXblM3c3hoa0Z6ek5OeXRFeVF6dGoxWDBTSnVLd0F5djlK?=
 =?utf-8?B?OU9pcW9OOTNnSldMS01lN3M5WTVUdmp6QytJV2h5RXQ5T25ja2RMVE5VdUlP?=
 =?utf-8?B?NGpsVUNiODVQYnF0cC9yK1ZZaVpIb3ZrV3dFa2ZodHVYWkduVU9UdjRuYTAy?=
 =?utf-8?B?cVVhVmsxZnpKUldlei8yMmhOTnhWaHVFMU9iSEpia25pbFF3OFZGemxOc3pB?=
 =?utf-8?B?Z3RvM1BKTXNING5qKzBXVndNOFJ4dTBrZ3VwTGc0N2c0WkExWXZSNlRpN2t0?=
 =?utf-8?B?V2MzZm9nV1owcTZqOG1TTG83K2tPdmlzSFg3Z0hOb2hlRlc2Q01zcGZNamFY?=
 =?utf-8?B?TjJaUnlmYmtLQ3RiVWJ1aG1mcFRVSjRTTzB3bEZCUlVLZWpvemZ6VERidGl2?=
 =?utf-8?B?bUZFNkIvVGFHOTFCV2lmTUQzcVlucU5hS1BPdlMwYk9MKzBxdElUb1pTeHFM?=
 =?utf-8?B?c2ZCQ3JoelJEUjlXYndQQm1Kc2w2UWUvTzJiaHZER01vaFVpU3VOZG5LTHRF?=
 =?utf-8?B?TUxKRHBNVW5OTUxHV0t5Wnl2M2t3eEo3c290NkI3eHRWV0F2LzljZU92Q0VF?=
 =?utf-8?B?RHpoUkFYRTg5MkFKdCtvMjlUQm54c1F1SHFkZUlHQlJENllaUThqbHdncWJW?=
 =?utf-8?B?T2Y2V1RxcUxTSlhsd2thcEhmUFZOSUlaVTM3NVU5YzZkTGE2a3Jjc0cyT25T?=
 =?utf-8?B?YUhKRjZIUGEvdDk4cWc1TE5hMDZiRnRuOXltRW1sbXM3WlZsdlBmRTBjdlh0?=
 =?utf-8?B?UHVRN2dsYzBvcHRjQ293Mk5iNG5aNThsUzdUQ2lBam52TDllTHBGeWVWeGtj?=
 =?utf-8?B?KzZWWXlCQk1Ib0g0RTBIMFdxSWxWdUw3cjRybGJ6NnRITnV4TVJxUkZhTTd0?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dhWbnTsqulm9Gv32WPT7Kde4q3OswNFu7+j2qHL6CAkFOWqMj9/bR5ttVTBmtViOvQSHPJaEne3zIUrZ7m3d3bYFfY71vJAYURvJOFedeUPY38SLRre4s5iJgS+4F/I7z0dd1nVJ2+EXV/2mrDXr7QLZS15t5dTXv8hUtW7FrTVmUJD2xr84MP8n8tT6WbrePmx33zC/aNwMpIS5+eTLUiCv1G9JI2dsOeHIYjtdmG2VWdwffYck03W2huOip0Pl3mw9PCXzpIPKPyrLvlZDvtIwKud2o2M+RuLRm/qEGO2Gn24Y8cFuvCQs4gE5u2LnK0k7QHwjBN9HAsb2zJFmzlGiEplfk9/qMlmCkmUfi6RO5QNo8UGJ/kLxIKTrsmiCLRD7EaSMxz5yYcowrPMLHdKUGXbFq4iSJ6HunPXUS3R/cPbNGvvaCrGBfT+bisYobrJKGkYVYpQTF78k11QFFB9psBzRO7gG64MvYRVo331rhpyYuDueTRUSZKNsF4g+oFQrGFBlp15nLLs9jESwYjBIy7QS787oRp1k+oCHIBxn1pPVLUYr6onUZAU+Zz/3HIGVB7ze7nuV0liw+TXDnBzrwq1jweFWaz2tNj86+HhpNxmbgAnqoQlLeyvBMg4YH14dSXfv6wRyf5hd2+SOxAsZLP+1ScI6yr/EC26miVXb0Qek9msyjbSYALK15tR+RJqxZ0iMIzarcJiqZydnwYZP9QRCB/6hOB1wpVZirvBc3U9KglM66IaM8vv0OgVPU2Zsv6tkEp4iQvbdDh+4J9TLLujoVk56A8Wu3PG90jDr++yUDyqpHnRReI/nxT9vtyXzytyoHqlgmWW2wNwhCQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a08b9af7-5770-4e90-2dfe-08dbd5605eb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 13:43:28.5340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f92d38a3-9c84-427f-afc3-aef091509c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNk/efYf4q1KPPOg5OiT4CHw2jRkPyr7AVlZG1zykQQi5kStxKqpiudzAHh3tV/MQO3vHzYGxPeZbzWHiwCzvnxCFg+swUyiBmWtZodD8mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P250MB0141
X-C2ProcessedOrg: 71f8fb5e-29e9-40bb-a2d4-613e155b19df
X-TBoneOriginalFrom: Michel Alex <Alex.Michel@wiedemann-group.com>
X-TBoneOriginalTo: =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
X-TBoneOriginalCC: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
X-TBoneDomainSigned: false
X-Mailman-Approved-At: Wed, 25 Oct 2023 16:20:24 +0200
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

Q2FsY3VsYXRlIHRoZSBtYXhpbXVtIGxlbmd0aCBvZiB0aGUgYnVmZmVyIHdoZW4gd3JpdGluZw0K
YWNyb3NzIHRoZSBwYWdlIGJvdW5kYXJ5LiBJZiB0aGUgYnVmZmVyIGxlbmd0aCAobGVuKQ0KZXhj
ZWVkcyB0aGUgcGFnZSBib3VuZGFyeSAocGFnZXNpemUpLCBzcGxpdCBpdC4gVXNlIHRoaXMNCmxl
bmd0aCBpbnN0ZWFkIG9mIGNvbXBhcmluZyB0aGUgbGVuZ3RoIHdpdGggdGhlIHBhZ2VzaXplLA0K
YmVjYXVzZSBpZiB0aGUgd3JpdGUgc3RhcnQgYWRkcmVzcyAob2Zmc2V0KSBpcyBub3QgYXQgdGhl
DQpiZWdpbm5pbmcgb2YgYSBwYWdlIGFuZCB0aGUgcGFnZV9vZmZzZXQgKyBsZW4gaXMgZ3JlYXRl
cg0KdGhhbiB0aGUgcGFnZSBib3VuZGFyeSAocGFnZXNpemUpLCB0aGUgd3JpdGUgb3BlcmF0aW9u
DQp3b3VsZCBvdmVyZmxvdyB0aGUgY3VycmVudCBwYWdlIGFuZCB0aGUgYmVoYXZpb3VyIGNhbiBi
ZQ0KdW5kZWZpbmVkIChlLmcuIGF0MjQpLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbGV4IE1pY2hlbCA8
YWxleC5taWNoZWxAd2llZGVtYW5uLWdyb3VwLmNvbT4NCi0tLQ0KQ2hhbmdlcyBmb3IgdjI6DQot
IGZpeGVkIGRldmlhdGlvbnMgZnJvbSBjaGVja3BhdGNoLnBsDQotIGltcHJvdmVkIGNvbW1pdCBt
ZXNzYWdlDQpDaGFuZ2VzIGZvciB2MzoNCi0gY2xlYW5lZCB1cCBicmFja2V0cw0KLS0tDQogZHJp
dmVycy9taXNjL2kyY19lZXByb20uYyB8IDEzICsrKysrKysrKysrKy0NCiAxIGZpbGUgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9taXNjL2kyY19lZXByb20uYyBiL2RyaXZlcnMvbWlzYy9pMmNfZWVwcm9tLmMNCmluZGV4IGJk
ZDdlMDE4Y2MuLjk0N2VlYjU2NDggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21pc2MvaTJjX2VlcHJv
bS5jDQorKysgYi9kcml2ZXJzL21pc2MvaTJjX2VlcHJvbS5jDQpAQCAtNjAsNiArNjAsMTcgQEAg
c3RhdGljIGludCBpMmNfZWVwcm9tX3N0ZF9yZWFkKHN0cnVjdCB1ZGV2aWNlICpkZXYsIGludCBv
ZmZzZXQsIHVpbnQ4X3QgKmJ1ZiwNCiAgICAgICAgcmV0dXJuIGRtX2kyY19yZWFkKGRldiwgb2Zm
c2V0LCBidWYsIHNpemUpOw0KIH0NCg0KK3N0YXRpYyBpbnQgaTJjX2VlcHJvbV9sZW4odW5zaWdu
ZWQgaW50IG9mZnNldCwgdW5zaWduZWQgaW50IGxlbiwgdW5zaWduZWQgaW50IHBhZ2VzaXplKQ0K
K3sNCisgICAgICAgaW50IHBhZ2Vfb2Zmc2V0ID0gb2Zmc2V0ICYgKHBhZ2VzaXplIC0gMSk7DQor
ICAgICAgIHVuc2lnbmVkIGludCBtYXhsZW4gPSBwYWdlc2l6ZSAtIHBhZ2Vfb2Zmc2V0Ow0KKw0K
KyAgICAgICBpZiAobGVuID4gbWF4bGVuKQ0KKyAgICAgICAgICAgICAgIGxlbiA9IG1heGxlbjsN
CisNCisgICAgICAgcmV0dXJuIGxlbjsNCit9DQorDQogc3RhdGljIGludCBpMmNfZWVwcm9tX3N0
ZF93cml0ZShzdHJ1Y3QgdWRldmljZSAqZGV2LCBpbnQgb2Zmc2V0LA0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjb25zdCB1aW50OF90ICpidWYsIGludCBzaXplKQ0KIHsNCkBAIC02
Nyw3ICs3OCw3IEBAIHN0YXRpYyBpbnQgaTJjX2VlcHJvbV9zdGRfd3JpdGUoc3RydWN0IHVkZXZp
Y2UgKmRldiwgaW50IG9mZnNldCwNCiAgICAgICAgaW50IHJldDsNCg0KICAgICAgICB3aGlsZSAo
c2l6ZSA+IDApIHsNCi0gICAgICAgICAgICAgICBpbnQgd3JpdGVfc2l6ZSA9IG1pbl90KGludCwg
c2l6ZSwgcHJpdi0+cGFnZXNpemUpOw0KKyAgICAgICAgICAgICAgIGludCB3cml0ZV9zaXplID0g
aTJjX2VlcHJvbV9sZW4ob2Zmc2V0LCBzaXplLCBwcml2LT5wYWdlc2l6ZSk7DQoNCiAgICAgICAg
ICAgICAgICByZXQgPSBkbV9pMmNfd3JpdGUoZGV2LCBvZmZzZXQsIGJ1Ziwgd3JpdGVfc2l6ZSk7
DQogICAgICAgICAgICAgICAgaWYgKHJldCkNCi0tDQoyLjM0LjENCg0K
