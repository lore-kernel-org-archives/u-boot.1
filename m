Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C8ACF043F
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 04:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A55F890B3;
	Wed,  9 Oct 2024 06:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="CnxhAYEb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A691890D8; Wed,  9 Oct 2024 06:45:09 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D17BD8905F
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 06:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Balamanikandan.Gunasundar@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inoiX/NG8TMTv+nIbNma96yP0d0mS6TtNa1KGWyLwdkJsGc3bPnXy4Hd9aI+jj99OyMba+UutdBKNWA9DToxsq5G19xve3p4OfxNaOsM2GCCsQSLhCQScE7p32qk5dkHvCeWqjwB+EGSWs6PCilhvPAICxbRTr84JpZTXsRE1fIhp88AmBbLhyMzmDpWwb+cd3WpX0Q7ZqI8kkmUQLLBhJmKOKAiHDjicycHKj2ZjeuNCW1SJDPQyeoJy6gspSVBoWQ6DhEteBsZb7QpvGFtVOar/GXF+KwWdoWe5HLdfwHELkwd+H+X91S2/jcpAXJFfQm78HewUFr0/MlSXQfN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLl2o41gF8fC6UqVgyPLlsiOyh5Eyp+NWLfrnGeLLAU=;
 b=IH6Mfjv2RjuZY+QIYtK6vpjpRYLh40Ck4PMRJKTNs0eZwhcmYylKX+IOEOUVR4UcywzDxcqjEOddyAKCcFFT6b7qVN8YhFf35dHlvZktew2iJCdlblH3xb8FKwM8uWWtgfIVzS6Ka5wqai2nUEzD00XXcZg1SXzvwjk7A2buEDQHO9a7Hy5vjCkVM3TLMxFENxOqe9fFIWS4wOEBk4nRvOrULoTxuba4xjRpibWqkG/76/hi/qxtPuS0DMC9MNfNOxJ2YOgLPBIvIMSoLEBZnCXAVN/31sECinor0hnRcMdJLikoQVEJHaomLkq4y90ZRl9oluGREJE8++2dFHDn9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLl2o41gF8fC6UqVgyPLlsiOyh5Eyp+NWLfrnGeLLAU=;
 b=CnxhAYEbiOnKbV9r9NyO/kcyuPQ0dbsUH2zgCtkggCa9Sq8tNdEoyshWKqO+xS5fr5cplTSOvnwUvqcAESYUsY1YATPcWiPgWjNOoL5JQwKn6I0elEkBYa+QcZ6hrNLuHYX1xE+pa7QynJDaVXDMCxlJgYAHDkXCtvPxYFe9nWYhPLYu8pPCdvVYW3sRgYmmJd0QKjAaB7fMa65++3ORtxCCN3ao+lE8GPHS5wrZ3dy9kuRkO1m5j8rn0DA1ntB5ooTGcT9rgh+ns4+a4FMcyeDzx4CFCsgb45QYE1hBof/VVatMD0ulfj3x+kV6EMZsJlmmEMetcRlDNP4/Q3tF9g==
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB5940.namprd11.prod.outlook.com (2603:10b6:a03:42f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Wed, 9 Oct
 2024 04:45:02 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 04:45:02 +0000
From: <Balamanikandan.Gunasundar@microchip.com>
To: <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <eugen.hristev@collabora.com>, <Mihai.Sain@microchip.com>,
 <Bin.Li@microchip.com>, <u-boot@lists.denx.de>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v3 3/3] mtd: nand: raw: atmel: Fix pulse read timing for
 certain NAND flashes
Thread-Topic: [PATCH v3 3/3] mtd: nand: raw: atmel: Fix pulse read timing for
 certain NAND flashes
Thread-Index: AQHajwq8fdO9YoR2dUG628nPViYq+rGstqoAgMRKuoCADeyGgA==
Date: Wed, 9 Oct 2024 04:45:02 +0000
Message-ID: <3a3cc57c-e696-408f-a050-39502081b6f3@microchip.com>
References: <20240415074547.779264-1-ada@thorsis.com>
 <20240415075755.780653-1-ada@thorsis.com>
 <20240528-among-detective-e8ad4c9b5457@thorsis.com>
 <20240930-pamperer-prance-8b4566ba43a6@thorsis.com>
In-Reply-To: <20240930-pamperer-prance-8b4566ba43a6@thorsis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6231:EE_|SJ0PR11MB5940:EE_
x-ms-office365-filtering-correlation-id: a995c07f-61f5-4327-57e9-08dce81d2333
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6231.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d3RvSUYvdFRpRkxPZlpXMXliZ093c0JNbFlBZk5tY0xwbTVXaEZLOXdZQ1Fk?=
 =?utf-8?B?eisxR3JyaDl3MnlsTldFK3U4bUpSSTk0SUdqdlFhbzFDM0VGOCtYcWxPYUor?=
 =?utf-8?B?SDBVbmozNmRlK0orSVRFaVJBWlVqQjFXbTZCcENnemtNZUVxRTZKZmgwMnAr?=
 =?utf-8?B?Qk9tMFBOVnE4V3BUMFR4aTBhRlI2S0lMNFhhT0JlM0Z2NzVXZ0lpSkVoV3FL?=
 =?utf-8?B?Zk5sVm8vVzVkRnAva2d2dlhQZVFpL2dGYWFWMzFtS3Rndm1CcWlkcVZ0WU1Y?=
 =?utf-8?B?Nkxvd21MRkhzSmlrNlpRaDhSNzFscjF1ZVFMWi9qMlk4dEdnR0wvYUJicVdu?=
 =?utf-8?B?Z3lteklGckswVXcxVTFRQW9lamVCUVMyVVhXU2E5cnl4dDliaVovL3NjZit0?=
 =?utf-8?B?RVdydnNqZ0lYOGJFM2FnaGlJOTJEZWk3R3oyOGNkQkxRdzB3akVUZ2pJblFK?=
 =?utf-8?B?YTl0Q1lXdzZJOXVwZWZwWS9iRyt4RTMzNkJHL3ZEZU12eGIyaVEyMi9HTE9h?=
 =?utf-8?B?QTVOQnRHR1ZBcS8wVEtYUkhNeUdldGN1YVVaWUlKUEU3THZzVmxOQ2htRkUv?=
 =?utf-8?B?TFdIVEo0R2tlaHZya3ZOT1JqSUlIc28zaTZlWWo3bWNGNE1IMjZqSjgrY0tp?=
 =?utf-8?B?aWpZTXJYKy9VTys1d1dvYU1KZk0xMU4yTHM3N1YydmJrRGhRQXB2cDZCTjFY?=
 =?utf-8?B?aDR2bUhJdWUvU2dwVUFWdC9rbER6TVNBOTQyTVBvbmVaK0x2UXdmTit2dUlW?=
 =?utf-8?B?Nnc2QkgwZHVCb1h3Tnk2RmtDZzZlbXl2Q3FORUR6MlZLT1RDenlXK1Z0ejkr?=
 =?utf-8?B?MUd4bTVXY3IxdXRneHZCZkpFWU15UHJSUExwWmY4RDhvOE16TWJ5NE9tbkNK?=
 =?utf-8?B?Vkx0WnI4MnhvZlNwdTh1dGVZOS9iQUFXL1k2RzFXMGl2bTBBVkMwcmlRSkp5?=
 =?utf-8?B?cHcyUkcvNndOcjRkZXhmU3dvaGFQdUMvWUpyK0s2cktyUC9wYm5jeGl6V24z?=
 =?utf-8?B?b3pQbGJ0K0dlWUlJTytQWHA4TGRHQmZLUkJvQnVrVFRGKzBDbzltWVhyNHV2?=
 =?utf-8?B?T3Y3VjViWi9rRnliZjc2WVJDWHE4MlhWeFpoWTQ4VzBGZDNUcit1OW04MDZD?=
 =?utf-8?B?dWVSdmlpUkg5N3RwR1lCdExxVVRRYTFNVVM0UWZXVlRHMEt4OVFubnM1VHMv?=
 =?utf-8?B?aUVqWWVCOERWT0lwMVdLcHo4ZWtTMTRPQWtSd0wwSlJJd3VjQjdDTHFnM0Qr?=
 =?utf-8?B?Z3Q1R2h0UXhvVlRpVDdTUHhub1Z4NGZrc200Vm5mZXJZYVd3ZVpIUFF3dkxO?=
 =?utf-8?B?QkhIUzB0NFNBSXRvekV5d3daTzlwOUNQdE9hVW90UGRSeUJFZnp3SElFMkpZ?=
 =?utf-8?B?N1JVVGdlMzZ6Q2NyczJCbXIrQ1NNZXNxR1JwRWdOMDZpMXlRd2xKZ0lpcUdi?=
 =?utf-8?B?d2haSGNTVHBtYWhOTmd4V21sWFJVNWRYdmxmVlZ6MTVUZjIxbWMvNkdxVDk0?=
 =?utf-8?B?aU9HZWhyNGc1bFZndVlibTh3cXdud000SEgzQ2cvdXpvM1h5SFI4RjlhUlZv?=
 =?utf-8?B?ZlNMNTA5dEIwYUtkU0dma0laWnc5OGNRS05tWUVoTkNqcDJDYXhWelNwWXQ1?=
 =?utf-8?B?eTBSNkVzYS9salVyc01BQ0xObElINzlWUGlidTgvTTl6K2lZdkxVdUkyTHZD?=
 =?utf-8?B?ejU1SzlhSm5hVWx3eUdzTnpKVmFicHQ1M3VlcGljdGJQTDhPVllLVXk1SVIx?=
 =?utf-8?Q?+ZB7dNzhZYFXEpGwk0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0gvTThVSXljZlhqNElGRGN0bXBwWTdxbzdHMnZCcThSOGJOWTlLeUFyY1du?=
 =?utf-8?B?T1lLNEhHckFLakhzOU5vMkxxbDgwdENBbVVyVkNNSTdOUTdSZWVYSkQ2MHFi?=
 =?utf-8?B?MFFnbnZsSEwxVVZpUW03RERuUllCWnNsVVVPYXQvM3hXRzRRa3pNL0hQelF5?=
 =?utf-8?B?OS9iQXdhaUl4dnRKZnlSTVRZc3FRVGY4NXA2VHpiMkJSZDUwLytabnVVbTBF?=
 =?utf-8?B?MEJxZUVWR1dOZmZJTlh5M3hib0dyaTA4NGx0aENDVGxZRHJYWEdLcHBZZWx4?=
 =?utf-8?B?YjJydmNMYURNMkozTXNKMGRZZlYzbVpXdXYraWMzS2hmZlBST3QrQTgweS8x?=
 =?utf-8?B?VzI4a2JBN2lvcVJxRUVkeHNPZWFxNjFFYzNIYmpSMWF1TjNlbEtJcGtJbHRu?=
 =?utf-8?B?d2VkVWtkSVhZbjAzQitUVUthUnFiSHlGb09zRnlkeDBiUGQyRk1KcHlwRjFK?=
 =?utf-8?B?S0lvdm5jcmIwdEt0elBxNTA0TnJjdWY1Qm9EMVhCUnVUdE84a09iZmN0S1Yx?=
 =?utf-8?B?aFI4Wk1Pb0xMYVVRcVY1ZERMVGFSd28rNHdNZ1R6YkJWNmRDTkt1S24zVDB2?=
 =?utf-8?B?M1ZTR0VtcTNrTitxWFVoNlFMMmlMdHVRRUhNSDdxV3VQZ1FTZ1BqUy9OYmhn?=
 =?utf-8?B?cVF0Wk80eE9sUURNNlBOSWRzZmFtN2hsSWxubk8vQ2VLd0FtU3NDZ0VQRWdT?=
 =?utf-8?B?cmtVbGJ1NnJZR1RLR2hEd1RvcG1YaEhaQU5uQXZJWnByYmdEOE1zcUZEdjV6?=
 =?utf-8?B?Yy9yZGhJTlR2YzJ1eWJDbkRlMFFHLy9qb2V1MXhhbE1GRXhYZHdoY04yTC90?=
 =?utf-8?B?RlhOK1EzYnBJUm5tNGNkUlFRYUxwSG52OEpmRXU2VEhEV3RUVFYrOUtiTURH?=
 =?utf-8?B?dFkrSmZhOFBhZzdZQ1Mvc2c1MlFwVzAvK3UveGpJMWxQSlZGUEdPaTROaE1D?=
 =?utf-8?B?UjBhMUFEdnUrdTdqRUlQNDhQZmlIYjlvTTc3eEw1VmJvSXJFVHRHYWNmZllF?=
 =?utf-8?B?cFhuMjhDTDlhK0lLcW9KLzNHRVM1bVVYamtDU0FQV21zK3hLUGsvaWxrQldK?=
 =?utf-8?B?cTlEcTJjdHowRFJibXMzSDQrcFVaMndrVjVjamx1QWFhTUsrejNPSjVXMkdv?=
 =?utf-8?B?Vkc3cTBPRTExUUp0Rm1BVHZDdk1iV2pXSHBac0pXZGNIZHVtM0dFdTh4MDVO?=
 =?utf-8?B?Skd4cWhoVEJFQzBxejZ4QWhKNWhoNVd1NEluTWZheEtJMVpwaTk5TEZPajZw?=
 =?utf-8?B?c1dVaUZrM0lMOW0rWjZXQ2crbmpQbkwzWlM1c0Zuc0pUY1ZYUEllZWlJRmVj?=
 =?utf-8?B?cTltTGtaeFRJZmVlOVlLZnBPN20zL2M3TXVuU3hwSTZ3NG5rbjVnNC9uYzZv?=
 =?utf-8?B?ekdWVzNVM3RRdE9GZXl5T0xGc1RmVTllMzdSK1hKZGVHWUJFYmJldW9CZWVo?=
 =?utf-8?B?K3AwOEt0Q2o5azJoNm9NT0xlNnpmNENWU0FnSXVWcmh0K1V6MDEzNTJZSitC?=
 =?utf-8?B?QmVXeW95TkNzUVlrVTZMQzc3eVBIaENsRGJjRXBSMHNWeE5nRzk0Y1N5OS9R?=
 =?utf-8?B?UFpNSUtkSXFINEU3TjE0UzkrNXNFNG1UNFlZYUlBRkFZZmZyUWU3dVkwSmRv?=
 =?utf-8?B?aXN3dG1hYnJ1WGVJc0phN1pIWlU0aGdqNFg4WXJEbzUxa0taQnA0N0JOTnRo?=
 =?utf-8?B?bk9Ya2pqVzdreXdENXl2ZzFqRlFyV1MrV3Y1a01PTldiMCtoTHVNbnlHWFNN?=
 =?utf-8?B?VkI2SVphbmJhT2VnOElsMVRDNGtWenIxOHFXVXRMaUh1SE02bDdONHlGYUVX?=
 =?utf-8?B?Ry8yUmtjRUpma0xwTXIxVEhyRnNBV0l2ZXVPNE9yaUJUSmtObm9pRi83YjJ6?=
 =?utf-8?B?TnA3QlZuRElFbzk4YWFid3V0cTJCQ3JzRnlsa0NiNkZLN2kxTm1acTNkbTNq?=
 =?utf-8?B?bjRzeTM2Y0RjR3JvSXo1VGUvQjRnMXZmQU9nRzNDNzZiSEM1d2hGRGtZZlFa?=
 =?utf-8?B?MU11eS9pMmpFdGN0dWRlUU9YUzY3S1B0YWNGV0RHTTdwUnBvdDEwS2hsUk9O?=
 =?utf-8?B?VE9SVEhEdHVjYytnZWdUOVdCMDBJeFVDeGRtcTVKRG5JSExYTEd2WDl1a24r?=
 =?utf-8?B?cmJZVDVyclFLUXhDVEd0OVQvYkJ3bUMvNmdZeGtZKysxSHFyN1JicTNPM3hh?=
 =?utf-8?Q?KKtuKIG7VpRJOL/HK+hD+1I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F77CD7676F55F4188A3F5ACBBBA3574@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a995c07f-61f5-4327-57e9-08dce81d2333
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 04:45:02.1583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: doOF0BvVOGL1cEvlOpkT84OTiVNJZsGcAUYtp5wTDM/2bYobbtdSxmhcyzNDcXfGa3ijf8j3hNHIPYbC6XPZvhvoDzaE7HC01VW07xBMYuoGo3vF9XisU2O+yqHpRmAk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5940
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

T24gMzAvMDkvMjQgMTozNyBwbSwgQWxleGFuZGVyIERhaGwgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGVsbG8sDQo+IA0KPiBBbSBUdWUsIE1heSAy
OCwgMjAyNCBhdCAxMjozMjo0NFBNICswMjAwIHNjaHJpZWIgQWxleGFuZGVyIERhaGw6DQo+PiBI
ZWkgaGVpLA0KPj4NCj4+IEFtIE1vbiwgQXByIDE1LCAyMDI0IGF0IDA5OjU3OjU1QU0gKzAyMDAg
c2NocmllYiBBbGV4YW5kZXIgRGFobDoNCj4+PiAgRnJvbSByZWFkaW5nIHRoZSBTMzRNTDAyRzEg
YW5kIHRoZSBTQU05WDYwIGRhdGFzaGVldHMgYWdhaW4sIGl0IHNlZW1zDQo+Pj4gbGlrZSB3ZSBo
YXZlIHRvIHdhaXQgdFJFQSBhZnRlciByaXNpbmcgUkUjIGJlZm9yZSBzYW1wbGluZyB0aGUgZGF0
YS4NCj4+PiBUaHVzIHB1bHNlIHRpbWUgbXVzdCBiZSBhdCBsZWFzdCB0UkVBLg0KPj4+DQo+Pj4g
V2l0aG91dCB0aGlzIGZpeCB3ZSBnb3QgUE1FQ0MgZXJyb3JzIHdoZW4gcmVhZGluZywgYWZ0ZXIg
c3dpdGNoaW5nIHRvDQo+Pj4gT05GSSB0aW1pbmcgbW9kZSAzIG9uIFNBTTlYNjAgU29DIHdpdGgg
UzM0TUwwMkcxIHJhdyBOQU5EIGZsYXNoIGNoaXAuDQo+Pj4NCj4+PiBUaGUgYXBwcm9hY2ggdG8g
c2V0IHRpbWluZ3MgdXNlZCBiZWZvcmUgd29ya2VkIG9uIHNhbTlnMjAgYW5kIHNhbWE1ZDINCj4+
PiB3aXRoIHRoZSBzYW1lIGZsYXNoIChTMzRNTDAyRzEpLCBwcm9iYWJseSBiZWNhdXNlIHRob3Nl
IGhhdmUgYSBzbG93ZXINCj4+PiBtY2sgY2xvY2sgcmF0ZSBhbmQgdGh1cyB0aGUgcmVzb2x1dGlv
biBvZiB0aGUgdGltaW5ncyBzZXR1cCBpcyBub3QgYXMNCj4+PiB0aWdodCBhcyB3aXRoIHNhbTl4
NjAuDQo+Pj4NCj4+PiBUaGUgYXBwcm9hY2ggdG8gZml4IHRoZSBpc3N1ZSB3YXMgY2FycmllZCBv
dmVyIGZyb20gYXQ5MWJvb3RzdHJhcCwgYW5kDQo+Pj4gaGFzIGJlZW4gc3VjY2Vzc2Z1bGx5IHRl
c3RlZCBpbiBhdDkxYm9vdHN0cmFwLCBVLUJvb3QgYW5kIExpbnV4Lg0KPj4+DQo+Pj4gTGluazog
aHR0cHM6Ly9naXRodWIuY29tL2xpbnV4NHNhbS9hdDkxYm9vdHN0cmFwL2lzc3Vlcy8xNzQNCj4+
PiBDYzogTGkgQmluIDxiaW4ubGlAbWljcm9jaGlwLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBB
bGV4YW5kZXIgRGFobCA8YWRhQHRob3JzaXMuY29tPg0KPj4+IC0tLQ0KPj4+DQo+Pj4gTm90ZXM6
DQo+Pj4gICAgICB2MzoNCj4+PiAgICAgIC0gaW5pdGlhbCBwYXRjaCB2ZXJzaW9uIChub3QgcHJl
c2VudCBpbiB2MSBhbmQgdjIpDQo+Pg0KPj4gVGhpcyBwYXRjaCB3YXMgc2VuZCBhcyBwYXJ0IG9m
IGEgc2VyaWVzLCB3aGljaCB5b3Ugd2FudGVkIHRvIGhhdmUgc29tZQ0KPj4gbW9yZSB0aW1lIHRv
IHRlc3QuICBCZXNpZGVzIHRoYXQsIGhhcyBhbnlvbmUgbG9va2VkIGludG8gdGhpcw0KPj4gcGFy
dGljdWxhciBmaXg/ICBNYXliZSBpdCBjYW4gYmUgYXBwbGllZCBzZXBhcmF0ZWx5Pw0KPiANCj4g
SSdkIGtpbmRseSBhc2sgd2hhdCB0aGUgc3RhdHVzIG9mIHRoaXMgcGF0Y2ggc2VyaWVzIGlzIGZy
b20gVS1Cb290DQo+IE5BTkQgc3Vic3lzdGVtIG1haW50YWluZXJzIFBPVj8gIENvdWxkIHlvdSB0
ZXN0IGl0PyAgU2hvdWxkIEkgcmViYXNlDQo+IGFuZCByZXNlbmQ/DQo+IA0KPiBUd28gb2YgdGhl
c2UgdGhyZWUgcGF0Y2hlcyBhcmUgc3BlY2lmaWMgdG8gYXQ5MSBmYW1pbHksIHdoYXQncyB0aGUN
Cj4gb3BpbmlvbiBvZiBhdDkxIG1haW50YWluZXJzIG9uIHRoaXM/DQo+IA0KPiBMaW5rIHRvIHRo
ZSBzZXJpZXMgZGlzY3Vzc2lvbiBmb3IgcmVmZXJlbmNlOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvdS1ib290LzIwMjQwNDE1MDc0NTQ3Ljc3OTI2NC0xLWFkYUB0aG9yc2lzLmNvbS9U
LyN1DQo+IA0KPiBHcmVldHMNCj4gQWxleA0KPiANCg0KSGkgQWxleCwNCg0KQXBvbG9naWVzIGZv
ciB0aGUgZGVsYXkgaW4gcmVzcG9uc2UuIEkgYWxzbyBmYWNlZCB0aGUgc2FtZSBraW5kIG9mIA0K
cHJvYmxlbSB3aGlsZSB0ZXN0aW5nIG91ciBuZXcgc2FtN2Q2NSBib2FyZCB3aXRoIE1YMzBMRjRH
MjhBRCBuYW5kIA0KZmxhc2guIEkganVzdCBoYWQgYSB3b3JrYXJvdW5kIHRvIGluY3JlYXNlIHRo
ZSBwdWxzZSB0aW1lIGJ5IDUgbnNlY3MgDQpqdXN0IGZvciB0ZXN0aW5nLiBUaGUgaXNzdWUgaGFz
IGJlZW4gcmVwb3J0ZWQgdG8gdGhlIHZhbGlkYXRpb24gdGVhbSBhbmQgDQphbiBpbnZlc3RpZ2F0
aW9uIGlzIHVuZGVyIHByb2dyZXNzLg0KDQpJIHdvdWxkIHJlcXVlc3QgYSBmZXcgbW9yZSBkYXlz
IGZvciB0aGlzIHBhdGNoIGFsb25lLg0KDQpUaGFua3MsDQpCYWxhLg0KDQo+Pg0KPj4gR3JlZXRz
DQo+PiBBbGV4DQo+Pg0KPj4+DQo+Pj4gICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9uYW5k
LWNvbnRyb2xsZXIuYyB8IDEzICsrKysrKysrKy0tLS0NCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvbmFuZC1jb250cm9sbGVyLmMgYi9kcml2ZXJzL210ZC9u
YW5kL3Jhdy9hdG1lbC9uYW5kLWNvbnRyb2xsZXIuYw0KPj4+IGluZGV4IGJiYWZjODhlNDRjLi4w
MGZmZWFkZDExMyAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9u
YW5kLWNvbnRyb2xsZXIuYw0KPj4+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvcmF3L2F0bWVsL25h
bmQtY29udHJvbGxlci5jDQo+Pj4gQEAgLTExMzMsNyArMTEzMyw3IEBAIHN0YXRpYyBpbnQgYXRt
ZWxfc21jX25hbmRfcHJlcGFyZV9zbWNjb25mKHN0cnVjdCBhdG1lbF9uYW5kICpuYW5kLA0KPj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBuYW5k
X2RhdGFfaW50ZXJmYWNlICpjb25mLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBhdG1lbF9zbWNfY3NfY29uZiAqc21jY29uZikNCj4+PiAgIHsNCj4+
PiAtICAgdTMyIG5jeWNsZXMsIHRvdGFsY3ljbGVzLCB0aW1lcHMsIG1ja3BlcmlvZHBzOw0KPj4+
ICsgICB1MzIgbmN5Y2xlcywgdG90YWxjeWNsZXMsIHRpbWVwcywgbWNrcGVyaW9kcHMsIHB1bHNl
Ow0KPj4+ICAgICAgc3RydWN0IGF0bWVsX25hbmRfY29udHJvbGxlciAqbmM7DQo+Pj4gICAgICBp
bnQgcmV0Ow0KPj4+DQo+Pj4gQEAgLTEyNTksMTEgKzEyNTksMTYgQEAgc3RhdGljIGludCBhdG1l
bF9zbWNfbmFuZF9wcmVwYXJlX3NtY2NvbmYoc3RydWN0IGF0bWVsX25hbmQgKm5hbmQsDQo+Pj4g
ICAgICAgICAgICAgICAgICAgICAgIEFUTUVMX1NNQ19NT0RFX1RERk1PREVfT1BUSU1JWkVEOw0K
Pj4+DQo+Pj4gICAgICAvKg0KPj4+IC0gICAgKiBSZWFkIHB1bHNlIHRpbWluZyBkaXJlY3RseSBt
YXRjaGVzIHRSUDoNCj4+PiArICAgICogUmVhZCBwdWxzZSB0aW1pbmcgd291bGQgZGlyZWN0bHkg
bWF0Y2ggdFJQLA0KPj4+ICsgICAgKiBidXQgc29tZSBOQU5EIGZsYXNoIGNoaXBzIChTMzRNTDAx
RzIgYW5kIFcyOU4wMktWeHhBRikNCj4+PiArICAgICogZG8gbm90IHdvcmsgcHJvcGVybHkgaW4g
dGltaW5nIG1vZGUgMy4NCj4+PiArICAgICogVGhlIHdvcmthcm91bmQgaXMgdG8gZXh0ZW5kIHRo
ZSBTTUMgTlJEIHB1bHNlIHRvIG1lZXQgdFJFQQ0KPj4+ICsgICAgKiB0aW1pbmcuDQo+Pj4gICAg
ICAgKg0KPj4+IC0gICAgKiBOUkRfUFVMU0UgPSB0UlANCj4+PiArICAgICogTlJEX1BVTFNFID0g
bWF4KHRSUCwgdFJFQSkNCj4+PiAgICAgICAqLw0KPj4+IC0gICBuY3ljbGVzID0gRElWX1JPVU5E
X1VQKGNvbmYtPnRpbWluZ3Muc2RyLnRSUF9taW4sIG1ja3BlcmlvZHBzKTsNCj4+PiArICAgcHVs
c2UgPSBtYXgoY29uZi0+dGltaW5ncy5zZHIudFJQX21pbiwgY29uZi0+dGltaW5ncy5zZHIudFJF
QV9tYXgpOw0KPj4+ICsgICBuY3ljbGVzID0gRElWX1JPVU5EX1VQKHB1bHNlLCBtY2twZXJpb2Rw
cyk7DQo+Pj4gICAgICB0b3RhbGN5Y2xlcyArPSBuY3ljbGVzOw0KPj4+ICAgICAgcmV0ID0gYXRt
ZWxfc21jX2NzX2NvbmZfc2V0X3B1bHNlKHNtY2NvbmYsIEFUTUVMX1NNQ19OUkRfU0hJRlQsDQo+
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbmN5Y2xlcyk7DQo+Pj4g
LS0NCj4+PiAyLjM5LjINCj4+Pg0KPj4NCg0K
