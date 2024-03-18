Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA6EC54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 09:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AA7287D66;
	Mon, 18 Mar 2024 10:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="CPkSi/xh";
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="b1j6CPM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13B9487D71; Mon, 18 Mar 2024 10:07:30 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9173587CB1
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 10:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1710752844; x=1742288844;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fU2upVweSYqAGNS2lLQSSghQZ96f9vBW7tyh/inlrt4=;
 b=CPkSi/xho+UbDIL8htS4fT3VA/0KGlJ9H3E+61RaQdNHuASOlbyBbA94
 KIlAbQbgML0X2PPFvLC0nj9lM26m60bdCPK9JYMe33AJgqhu/RjE5Kv+e
 nYosB0th9PKtBgliqWsg7Qp0Zf59LWFIC5jZlFXX83H7loCw7OZicL+bq
 rxkh1EJVoCJmPEetMWC2iZbQK53iS5DeTHrleyMS87JMs80PJ8YTtKa/X
 zG24Eoq3gBWhxEDrDi6giP3eB73Hc0XzY8cW7A1KaBuRCV8LZ8/8gZajE
 sswoZcYYJ6QxK3P/mO0F1E5DxYeDkkL/5sXb43+MhQq3LggCYlPYlObMe A==;
X-CSE-ConnectionGUID: HIZKmoFfTPWkrkq9ORXU6A==
X-CSE-MsgGUID: 5982YIjDQKaxK5Kvf+/36Q==
X-IronPort-AV: E=Sophos;i="6.07,134,1708412400"; d="scan'208";a="17748731"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Mar 2024 02:07:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 02:07:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 02:07:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RU0/Sw8qyW7IYT2LKLnnjou5Qizg/m46uSRZyQhR8yJmGsJLsEvqR+GGLXoY/OlxGHuFxSDq7tA/V3gMpLOt8D10SiwddEyehp9mvMi+S2ZvqejqDEcFrBbXrDhjg8LlPfMxO4K7YZM5dZbZParchonhSVNU6dx46DsK1yFNlT7T88MO/tLOQAS2sDFwd4JjAbETCpI8EOu5Szy2UH3/DtDlKTvN8hAi+5Lr3JBnKEVHT1E6FpjHN12kx3LBCpgWpEoWJR00NPJGju22AWCvXiQvaOgfBhzuKw/eOW0JyI0qC8JpfAY12wiRdC3W2oRc7GyYWf+D3MXj6vUIQtsKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fU2upVweSYqAGNS2lLQSSghQZ96f9vBW7tyh/inlrt4=;
 b=TBxfU4/5KFACmQ6m0UmlRoS+9/bnOxsLfBsJt2I4FA5z59pM8d69YCjFePQ03oOxF7hx+qGhNVjPDPN2hxEkWvW2GtkDJi1St/xj0aUxVfIWThl29Bs2YNuDC2RY35OaaDrIiivCz8jh9EzqyLIzsV2D1ADXJYTerRW4ldJEGNSrbZuQkce69EAr6pVQ4UvnvbGE8mEiV0sXyi8idzWVdq/vFJAfq1nQU65ACcZkbjXTzVXtqINHLk9joUFfA/QGvHOeCgQ1k4BAh9WfaECZU/4PgLAAwoiqBY5gDMIuRZqQT1dtSws6k0Hv5CzkN87yT3bXx9CXzv2iwNYpNV8Pgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU2upVweSYqAGNS2lLQSSghQZ96f9vBW7tyh/inlrt4=;
 b=b1j6CPM6wVqhD7N4Xf0+87fy20fcqagtwBTapAFzF4ABVh7pWTm8YdM1sYAyWtaqjBynjiICYqbpiBEZfH8nKS/5NqcN+l9IsJtqOxSIGW1ZsmwHLkCSEkYkgqZ40J24/X7c3G6j3mbXVDvUxRqv7KbUJEbLrjpCRtYKodhkWQm4CNsk6Yunuq0LmXl6C3iuQ7DlgS2S8M61xeTJTnaNWojPSDNuevugP3Yv8LCeclHRR/ASDQ9BbW3T2Dqa91pRECXOv0rFaMCPcvDMoeK1hGEm9v2pl40FpO0mTY2RgOmPeXmJjihJQRm9fSZY0XJPH6Pn6noiG1Zjqe+JSwGYww==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by PH7PR11MB6474.namprd11.prod.outlook.com (2603:10b6:510:1f2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.10; Mon, 18 Mar
 2024 09:07:10 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c%6]) with mapi id 15.20.7409.009; Mon, 18 Mar 2024
 09:07:09 +0000
From: <Mihai.Sain@microchip.com>
To: <ada@thorsis.com>
CC: <eugen.hristev@collabora.com>, <dario.binacchi@amarulasolutions.com>,
 <michael@amarulasolutions.com>, <Balamanikandan.Gunasundar@microchip.com>,
 <u-boot@lists.denx.de>
Subject: RE: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Thread-Topic: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Thread-Index: AQHacHYz5NjLBjcwWUSp31aMRMD+07E9M2MAgAANRwCAAANSQA==
Date: Mon, 18 Mar 2024 09:07:09 +0000
Message-ID: <PH8PR11MB68045C740982A66703188E70822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20240307091014.39796-1-ada@thorsis.com>
 <20240307091014.39796-5-ada@thorsis.com>
 <82a5ea3c-ab95-4460-9685-2676fe18d6b5@collabora.com>
 <PH8PR11MB6804301C3B361D21EADCEE71822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <20240318-tug-shrank-ae6315aaa6f4@thorsis.com>
In-Reply-To: <20240318-tug-shrank-ae6315aaa6f4@thorsis.com>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|PH7PR11MB6474:EE_
x-ms-office365-filtering-correlation-id: d11727d2-51f3-4016-d34e-08dc472acad7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ghG2ESDDZNWzJVsOZ7NeCvnr0xgI/WPGNL7HrViRUQjMpiY4VOAZJqAxsF7GldnMh03/LlUOxOtLXcHXNeebV6z/QohKO4AaBGqmaqq4gFaGTJpLJL5mL+cbfkB1wOOZGUbuoyDZGVWdrLoLHW3+7hWCojCV/CxmQNRRUOCzCCtTEmSQ0fVf3P4H3ppEeWSHZM6YVDAxOLgN9fzss/7kTduJ0Ek43V3ItS8U6xcO5bvJVGxidlwlpWyyv5e8uC7p0RXtIMxaxmvlxio4bRtTYX3b2PC6wEEhy3zP09IOF2riy32DUkfFO2B2OUkqlqZ10GZFFvNYKrp5QgUqdII7EVo7A5Ja4U9OpYUpsep2P/PNnZVvMp/vhekXf9Fe/tkyqTyxCvkstWJ9ODlRJMEzHoQwZ+tK/NI6f6yf4+uTNiYCvJbG63pVuCH+O4bGtoGnXBxVBC19MUkHqWQvtn8sLyQTFO5iOjo+aKH7wFNzF1F2X0pY/HK0Wy2b4/TccBmvUb05rnxkI+L46yRRUZbHARg1ZvicdIRo/q7OoAnAGjiiC9Zv4ln3g+yd+jPjHmdVvlX0bPPw+om3dHuRdis1MiWtPLtz3GQCPAeSH6na3Vgy1wY9AyykXmTQPoaDqFGGqDEY/jexEpilBY3mCJKo0C86o69zo79oINObqL5uLE8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWFvMjFIUk1laGRrUElZNGViOTZ2NFErdlArbEJBQTR1cTU5clcvQXh3ZUd6?=
 =?utf-8?B?ZldLZ3BFMWRTeEtReGpuWTNuOEh0OXBhSUt3aWtvUUx0eHhjb0V5RVBJcmlH?=
 =?utf-8?B?aXF0ek45R1hxOTZZNVJWNHpPdW1HWXlPcVA1Tk51UlZpUXkxeWNiY1JacVkr?=
 =?utf-8?B?Y0FiRFVmWWtMQUZ5T2NIQ2FjNmNNK0kxS2NWMXk2U1NDZ0pPSllpQjBtOVNW?=
 =?utf-8?B?OW9TdjJFUGNtS0RuaFhZRnViNlBRNFVGbXdrWFZPQ0trZTlmSXFnTkdiOXp1?=
 =?utf-8?B?ZWNKN2pWT0FORS9hSGs0VEV3a3czY3NoUjdlN01XNk96OUpkNnVrSkxBd1dq?=
 =?utf-8?B?Q2JXV1FhVkJ3aFAyUDJ1L1RmSnlic081K1krOUROdmxlUkhKRVJ6aXV6d2RT?=
 =?utf-8?B?aTdVTWMva0Nwb2pEQytMR2ZLakpnNEJxeEIyZVZESEJsVGIwM042eUMvSUtz?=
 =?utf-8?B?cmM3N0h6TFBUUGg2NXdhc0Y0VU5odEhiUkV6TlgyM3dDNkJvS1ZPMEQ4dWEw?=
 =?utf-8?B?V1RrK2t3TXI3OUJqNCtJKzZadE1qRC9YekhYQ0wrbFpSazh1c0dNYjUvRkFB?=
 =?utf-8?B?eEx0OWNXN0UyYXgvWUJZbG8xZ21JQTdhcEpVOW1JVFRwY3NsT3VCc1MyNUdq?=
 =?utf-8?B?K2Z3cmZUUnc2cXdJV3NlUjNuYnNWM3J3TzF6RzRkakR3ZTlVVENibURBQXk2?=
 =?utf-8?B?L2FvdFd5SU1uTERld1BkbjNkNnVQczJ1Sjd4U1NDWEw1N1B1Q3g4RnFldG40?=
 =?utf-8?B?Y3prT1k2bDlpV0R1MVJGOThQR1ZhNnArUlEvekVmbTJRODFoOE9wRENYdnVr?=
 =?utf-8?B?K1VpVnlaRTdId2Q3N01JSFBsdlRHZzlJQ3JVWnJGOGVsZGNwOWZxaUd3VUFC?=
 =?utf-8?B?RXczYUUvNU9tcjJ5eHVGT0NZVmducllIUVZBTFc0eUg3dW9nRWlxU25na3ZB?=
 =?utf-8?B?SmJXZ2M3eDhnRHdDbDFoNHpUQkNyTUR0U0xGdnFKUHNZWmpsc050Z0twZ0dL?=
 =?utf-8?B?UEFGWkNrWEZ0WkdhQkw2UGFiQ1JwQmhjSmxKck5LVFRwU2VXN1UrMEFqSGhi?=
 =?utf-8?B?VnA4dTNPVytCc1doZWpRbTV0NXhuNm5BUm5WckhFYnNnSmMwckZHZVFJcGdW?=
 =?utf-8?B?TG9qVW1oc1lmL1NNSTQrOTVTZVBXSlg3clZYSUxIT0dqM1BzY1BuMjFmTHpu?=
 =?utf-8?B?YlY2dnFvL1Awa3d4NUFqUXhRdmhlZVZUdUVNaXIwQm0xNGR2OHc0TVVpdm8v?=
 =?utf-8?B?YmdabmdmKzdoYmNtRTdpeVFobE9kMm85VU9XY3F4VXd6bk1PUjlmbTNNTjAw?=
 =?utf-8?B?RGRwWkRFeUdTeVFHZTd0NDhaQU8xUXFHbzRnS2NnUyt2YTYvSC9tUWU1MU5V?=
 =?utf-8?B?dXB1M1UzU1hyKzZYb0lyL1A4RUxaK1dIaXB6STM2SE1kb2tCdzRrTGljSWRj?=
 =?utf-8?B?VEh6WUV6OTgxeVlRYmVJdWN6N0RCSDU1R093VEtlOXFXYXV2WXduODRta3By?=
 =?utf-8?B?by9Zanl2a0hXUjhoVlZyTXlZTGcyU08zQWoxT0c1bEQydHJxSDYwSWdsaGJa?=
 =?utf-8?B?Ui95bktiNzVNekJoTlI3UlpsU0Q4SHpSWm1xSGhLRktydEVMT3ZndFovWkR0?=
 =?utf-8?B?MDlyOG45NWF3ditWSGhVYldWbm1vQWI0L0REeHJBVVpCdW9HY29qNEc3Ti9n?=
 =?utf-8?B?UUp2d1lQVFQ3VGt1ZHZxZkZVT1VuVmFxSGZQT1hVK2VBb3BzbG8ybjJMbTBT?=
 =?utf-8?B?MHdHaTBqWEF1MmxQK0YwbW00SkJJbDdjZExFZzc3MXNWVDdMRHNmT3BzTVZO?=
 =?utf-8?B?VzduL1I1SUlXZm12RlUzeHJVZThYcGo1Y2RFd1c3U0FBdVpkcEdGNmJEUkpK?=
 =?utf-8?B?a24wbkdnRHhpY01hWm9UQmJYTjRmRHVMNFBvcVF0WDY1VGxGZE12dzhxUG9z?=
 =?utf-8?B?bHVZZUp0Rk1ZdmlaaVNaVDBJUVB4Z3c5a3U4eEtMUmthUlNNUkg2M0o4eDE2?=
 =?utf-8?B?U1VwcEVYZzBtZnVScEFqVXlBYnpNYkpFaWtLT3dUcWdXZjRHOVByVlhFTG9G?=
 =?utf-8?B?L3lWZGJQKzQ1cFVWRXhzWWZscWdxbTlmMVdETjdZd2krWFJEanhPQkRycFBu?=
 =?utf-8?Q?eBdFMk/2WSiebSwnRin+azVsS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11727d2-51f3-4016-d34e-08dc472acad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 09:07:09.7033 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUb0Klcc/8QTJGxYZ/qNRVwQrHzrHxK3qmsiW2laUj3KLv96djNb2goHYQXnmBakJk/pNBnijSbg7slcB0wqqmyJN9y8HxLnKW56MBVHHdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6474
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

PiBVLUJvb3Q+IG5hbmQgaW5mbw0KPg0KPiBEZXZpY2UgMDogbmFuZDAsIHNlY3RvciBzaXplIDI1
NiBLaUINCj4gICBNYW51ZmFjdHVyZXIgIE1BQ1JPTklYDQo+ICAgTW9kZWwgICAgICAgICBNWDMw
TEY0RzI4QUQNCj4gICBEZXZpY2Ugc2l6ZSAgICAgICAgNTEyIE1pQg0KPiAgIFBhZ2Ugc2l6ZSAg
ICAgICAgIDQwOTYgYg0KPiAgIE9PQiBzaXplICAgICAgICAgICAyNTYgYg0KPiAgIEVyYXNlIHNp
emUgICAgICAyNjIxNDQgYg0KPiAgIGVjYyBzdHJlbmd0aCAgICAgICAgIDggYml0cw0KPiAgIGVj
YyBzdGVwIHNpemUgICAgICA1MTIgYg0KPiAgIHN1YnBhZ2VzaXplICAgICAgIDQwOTYgYg0KPiAg
IG9wdGlvbnMgICAgICAgMHgwMDAwNDIwMA0KPiAgIGJidCBvcHRpb25zICAgMHgwMDAyODAwMA0K
DQpUaGlzIHNlZW1zIHRvIGJlIHRoZSBzYW1lIE5BTkQgY2hpcCBhcyBvbiB0aGUgc2FtOXg2MCBj
dXJpb3NpdHksIGJ1dCB5b3VyIG91dHB1dCBoYXMgdGhyZWUgYWRkaXRpb25hbCBsaW5lcywgc2Vl
IG1pbmU6DQpEbyB5b3UgaGF2ZSBzb21lIGFkZGl0aW9uYWwgcGF0Y2hlcyBwcmludGluZyBtYW51
ZmFjdHVyZXIsIG1vZGVsLCBhbmQgZGV2aWNlIHNpemU/ICBJIGNhbid0IHNlZSB0aG9zZSBsaW5l
cyBwcmludGVkIGluDQpuYW5kX3ByaW50X2FuZF9zZXRfaW5mbygpIGhlcmUuDQoNClllcy4gSSBo
YXZlIPCfmIoNCisJcHJpbnRmKCIgIE1hbnVmYWN0dXJlciAgJXMgXG4iLCBjaGlwLT5vbmZpX3Bh
cmFtcy5tYW51ZmFjdHVyZXIpOw0KKwlwcmludGYoIiAgTW9kZWwgICAgICAgICAlcyBcbiIsIGNo
aXAtPm9uZmlfcGFyYW1zLm1vZGVsKTsNCisJcHJpbnRmKCIgIERldmljZSBzaXplICAgJThkIE1p
QlxuIiwgKGludCkoY2hpcC0+Y2hpcHNpemUgPj4gMjApKTsNCg0KPiBVLUJvb3Q+IGhzbWMgZGVj
b2RlDQo+DQo+IG1jayBjbG9jayByYXRlOiAyMDAwMDAwMDANCj4NCj4gSFNNQ19TRVRVUDM6ICAg
IDB4MDAwMDAwMDENCj4gSFNNQ19QVUxTRTM6ICAgIDB4MDcwNDA4MDQNCj4gSFNNQ19DWUNMRTM6
ICAgIDB4MDAwNzAwMDgNCj4gSFNNQ19USU1JTkdTMzogIDB4ODgwNDAyZjINCj4gSFNNQ19NT0RF
MzogICAgIDB4MDAxZjAwMDMNCj4gTkNTX1JEOiBzZXR1cDogMCAoMCBucyksIHB1bHNlOiA3ICgz
NSBucyksIGhvbGQ6IDAgKDAgbnMpLCBjeWNsZTogNyAoMzUgbnMpDQo+ICAgIE5SRDogc2V0dXA6
IDAgKDAgbnMpLCBwdWxzZTogNCAoMjAgbnMpLCBob2xkOiAzICgxNSBucyksIGN5Y2xlOiA3IA0K
PiAoMzUgbnMpDQo+IE5DU19XUjogc2V0dXA6IDAgKDAgbnMpLCBwdWxzZTogOCAoNDAgbnMpLCBo
b2xkOiAwICgwIG5zKSwgY3ljbGU6IDggKDQwIG5zKQ0KPiAgICBOV0U6IHNldHVwOiAxICg1IG5z
KSwgcHVsc2U6IDQgKDIwIG5zKSwgaG9sZDogMyAoMTUgbnMpLCBjeWNsZTogOCANCj4gKDQwIG5z
KSBUREYgb3B0aW1pemF0aW9uIGVuYWJsZWQgVERGIGN5Y2xlczogMTUgKDc1IG5zKSBEYXRhIEJ1
cyANCj4gV2lkdGg6IDgtYml0IGJ1cyBOV0FJVCBNb2RlOiAwIFdyaXRlIG9wZXJhdGlvbiBjb250
cm9sbGVkIGJ5IE5XRSANCj4gc2lnbmFsIFJlYWQgb3BlcmF0aW9uIGNvbnRyb2xsZWQgYnkgTlJE
IHNpZ25hbA0KDQpUaGlzIGlzIGFsc28gaW50ZXJlc3RpbmcuICBHaXZlbiB0aGUgbWNrIGNsb2Nr
IHJhdGUgaXMgdGhlIHNhbWUgYXMgb24gc2FtOXg2MCwgSSB3b3VsZCBoYXZlIGd1ZXNzZWQgdGhl
IHRpbWluZ3Mgc2V0IGJ5DQphdG1lbF9zbWNfbmFuZF9wcmVwYXJlX3NtY2NvbmYoKSBzaG91bGQg
Z2l2ZSB0aGUgc2FtZSByZXN1bHRzLCBib3RoIGZvciBPTkZJIHRpbWltaW5nIG1vZGUgMywgd2hp
Y2ggaXMgdGhlIGZhc3Rlc3QgbW9kZSB0aGUgKEgpU01DIHN1cHBvcnRzIGFjY29yZGluZyB0byBj
b21tZW50cyBpbiB0aGUgZHJpdmVyLiAgVGhpcyBpcyB0aGUgb3V0cHV0IHdpdGggdGhlIHBhdGNo
IGluIHF1ZXN0aW9uIGFwcGxpZWQgb24gbmV4dCBmb3Igc2FtOXg2MDoNCg0KICAgIFUtQm9vdD4g
aHNtYyBkZWNvZGUNCg0KICAgIG1jayBjbG9jayByYXRlOiAyMDAwMDAwMDANCg0KICAgIFNNQ19T
RVRVUDM6ICAgICAweDAwMDAwMDAyDQogICAgU01DX1BVTFNFMzogICAgIDB4MDYwMzA3MDMNCiAg
ICBTTUNfQ1lDTEUzOiAgICAgMHgwMDA2MDAwNw0KICAgIFNNQ19NT0RFMzogICAgICAweDAwMWYw
MDAzDQogICAgTkNTX1JEOiBzZXR1cDogMCAoMCBucyksIHB1bHNlOiA2ICgzMCBucyksIGhvbGQ6
IDAgKDAgbnMpLCBjeWNsZTogNiAoMzAgbnMpDQogICAgICAgTlJEOiBzZXR1cDogMCAoMCBucyks
IHB1bHNlOiAzICgxNSBucyksIGhvbGQ6IDMgKDE1IG5zKSwgY3ljbGU6IDYgKDMwIG5zKQ0KICAg
IE5DU19XUjogc2V0dXA6IDAgKDAgbnMpLCBwdWxzZTogNyAoMzUgbnMpLCBob2xkOiAwICgwIG5z
KSwgY3ljbGU6IDcgKDM1IG5zKQ0KICAgICAgIE5XRTogc2V0dXA6IDIgKDEwIG5zKSwgcHVsc2U6
IDMgKDE1IG5zKSwgaG9sZDogMiAoMTAgbnMpLCBjeWNsZTogNyAoMzUgbnMpDQogICAgU3RhbmRh
cmQgcmVhZCBpcyBhcHBsaWVkLg0KICAgIFRERiBvcHRpbWl6YXRpb24gZW5hYmxlZA0KICAgIFRE
RiBjeWNsZXM6IDE1ICg3NSBucykNCiAgICBEYXRhIEJ1cyBXaWR0aDogOC1iaXQgYnVzDQogICAg
TldBSVQgTW9kZTogMA0KICAgIFdyaXRlIG9wZXJhdGlvbiBjb250cm9sbGVkIGJ5IE5XRSBzaWdu
YWwNCiAgICBSZWFkIG9wZXJhdGlvbiBjb250cm9sbGVkIGJ5IE5SRCBzaWduYWwNCg0KTm90aWNl
IHRoZSBwdWxzZSB0aW1lcyBmb3IgcmVhZCBhcmUgb25lIGNsb2NrIGN5Y2xlIHNtYWxsZXIgdGhh
biBpbiB5b3VyIG91dHB1dCwgYW5kIHRoZSB0aW1pbmdzIGZvciB3cml0ZSBhcmUgYWxzbyBkaWZm
ZXJlbnQuICBEbyB5b3UgaGF2ZSBjaGFuZ2VzIGZvciBhdG1lbF9zbWNfbmFuZF9wcmVwYXJlX3Nt
Y2NvbmYoKSBhcHBsaWVkIHdoaWNoIGFyZSBub3QgdXBzdHJlYW0geWV0PyAgT3IgaXMgdGhlIEhT
TUMgb24gc2FtYTdnNTQgc29tZWhvdyBkaWZmZXJlbnQgdGhhbiBvbiBvbGRlciBTb0NzPw0KDQpZ
ZXMuIEkgZm9yY2UgdGltaW5nIG1vZGUgMiBpbiBuYW5kLWNvbnRyb2xsZXIuYzoNCisJaWYgKGNv
bmYtPnRpbWluZ3Muc2RyLnRSQ19taW4gPCAzMDAwMSkgLy8gZm9yY2UgdGltaW5nIG1vZGUgMiwg
MzVucyBmb3IgcmVhZC93cml0ZSBjeWNsZQ0KDQpUaGlzIHdpbGwgcGFzcyB0aGUgbmFuZCB0b3J0
dXJlIHRlc3Qg8J+Yig0KDQpVLUJvb3Q+IG5hbmQgdG9ydHVyZSAweDgwMDAwMCAweDEwMDAwMDAN
Cg0KTkFORCB0b3J0dXJlOiBkZXZpY2UgMCBvZmZzZXQgMHg4MDAwMDAgc2l6ZSAweDEwMDAwMDAg
KGJsb2NrIHNpemUgMHg0MDAwMCkNCiBQYXNzZWQ6IDY0LCBmYWlsZWQ6IDANCg0KTm90ZTogSSdt
IGN1cnJlbnRseSB0ZXN0aW5nIGEgcGF0Y2ggY2hhbmdpbmcgdGhlIGNvbXB1dGF0aW9uIG9mIHRo
ZSByZWFkIHB1bHNlIGN5Y2xlcyBiYXNlZCBvbiBhIHBhdGNoIGZvciBhdDkxYm9vdHN0cmFwIFsx
XSwgYnV0IHRoYXQgaXMgbm90IGFwcGxpZWQgaGVyZSBmb3IgdGhlIG91dHB1dCBxdW90ZWQgYWJv
dmUuDQoNCkdyZWV0cw0KQWxleA0KDQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4NHNhbS9h
dDkxYm9vdHN0cmFwL2lzc3Vlcy8xNzQjaXNzdWVjb21tZW50LTE5NzA2OTg1MjcNCg0KPg0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IE1paGFpIFNhaW4NCg==
