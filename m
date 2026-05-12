Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF3DCD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 08:22:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 756C38394E;
	Tue, 12 May 2026 10:22:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="sANFSqIQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 035A180398; Tue, 12 May 2026 10:22:28 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4A1F8394E
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 10:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CL5q58JMZdQur8Xu5q1S8wgjhZdC44dqhWzMvuHa2vuyNfSOUeqcnI9D+DufH5cePXtYXKy35LCyorXn8BmmKm3yUaM1BdwQC8zFRJ1wT1/AZfEf8vWcmh6V2X40o4fehyAJc57eHu3b3UqjwWsJyvyN7pdJoodfrcG3fcZGN0LfyDaxZAfa1hCqlwhtZUAEUgBTMbG46M/+SV5qPvqEKnEtnPFTyZw7kChhUIN86Cpa9k4U5aYOB7f3KqhDwCxalrhcOisdAEfgo0xnkZouca9B+lj85DBuWYJcMCnh8sypuMNaL/qGAjhrr/grmUL8ZjSRAvHF67en9IN1DRMrTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LwYaopaGPNQA3yYh9DuMgGczhjRORpCXp6WnuYKxfA=;
 b=Yrw/XgeUJ5jE6U8FXpFJMBgJZ9pEb5B+vVUZfGjeFquylfbvG60UZUHSHYAkEWJUvkv+0S4hQi+dmSJsVjeeeEsHaxTXsiRHSDfD8OhJW+hA76lacGWy+yieRNb+0UH/6bjF0H6wZ5ZvJb/mZW5wETgp9J1q+py0+3lsFkb1Oord9yaIwbonMCIXPej1CaQB28cPVJlzI4bZpQEQ5XC0ofSKShXoxgRw+Yyj3LPTLCu7yEonwFs2kQewTmlgSLZDaNckRAGDG6GD6U8XV/hs/Hw3kYNgG33jvlzzRIdjkayftLa5rHLAO3698zZv/VxwM2oLbwwAA7EwknEHPkR9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LwYaopaGPNQA3yYh9DuMgGczhjRORpCXp6WnuYKxfA=;
 b=sANFSqIQtn/dsQba5f+2tUCis5YKHQoSnmYQuP/wl4RJd55w7ILWX3pahf6pnOFI5WygeaZkThZCC7P8/BdKHNZNPy79abdFOYS5cuEcMwpnL9uQoajnA9hekc6zcwS09fprp3bqawM2mp7GZQiR8JgYObB6KAApUWbXpnKjj/vqpR8CsMptTmRfoGn5ca0AxeUbwkQg46lgDCDhRBMsQvqvdVxZY3v5EATgfhdwuEGNMGIYXGACnz57ZmfijTCMNpfFo9XG0wGcZpayLPjeKRfYd9Z2P5jac31VVwLi9zuJQ+ZsGdRewa05Wyd7Hogp43nFyxK7Vjr5HKugHF2FrA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV2PR10MB6066.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 08:22:20 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 08:22:20 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Alexander.Feilke@ew.tq-group.com" <Alexander.Feilke@ew.tq-group.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@ew.tq-group.com"
 <u-boot@ew.tq-group.com>
Subject: Re: [PATCH v2 2/8] rtc: pcf85063: adjust date format to adhere to the
 rtc_time spec
Thread-Topic: [PATCH v2 2/8] rtc: pcf85063: adjust date format to adhere to
 the rtc_time spec
Thread-Index: AQHc4T8bx9vFLF6sXk6aqTamevExibYKDmeA
Date: Tue, 12 May 2026 08:22:20 +0000
Message-ID: <fc7837526e8f6ea50135bcf929aa608d4b2306ed.camel@siemens.com>
References: <20260511120917.1017866-1-Alexander.Feilke@ew.tq-group.com>
 <20260511120917.1017866-3-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260511120917.1017866-3-Alexander.Feilke@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV2PR10MB6066:EE_
x-ms-office365-filtering-correlation-id: f07ea190-d493-452d-9cd7-08deafff961e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799003|18002099003|56012099003|22082099003|55112099003|38070700021;
x-microsoft-antispam-message-info: N8n/EemmfE13SLUEgUdwxfspRo+0IkH/w3Q/tMtqnvaxwVzSPYCTiUQDOoruxicpdZDmfcwsvnm8OjTIw2OBobyjMB6PXZbv1qwKY5jTYFsaw6GQiA2pModkTIDqsJ4YGTvJ1QgSTgkMKGupt7Boub8OrataZIE/81QKPkduxyzxJmaitEmIbJwXpN58kdhh/n+LSAspDSw8qzNLSsgRnCzvlAdCqWQjIDrrcVN6P7gk/f/vm/oyVtu0uzvrf6lpheXh+LDf8Ok8iuwryBhELyV5cJjmQ0VvA96QdBMfnnKo/Q5vDaifncqN3j+cmrMZy6kZhi8meggdb73H8n3Lja291Y6ZMI4UdhJkqAy5Ny+5kMQoWLApiGMjgwVDWrJMej3WmRGPMSm3kZxEAJekFKDtvkW92WuTiV7IOZl9NQ7OZYwguApQIZ4KEl/kqlvp+zFpUYqFL9RZdCF9Ux2nF26XfBnsRWQHbj5v6pYYJz+Ju40X29iow8msB3lvvPajlhJiUw9gJVqJ3rMFMexavcS3eaR0sTL6CmTNfT7Zn/YRks6T6j81Mnxr7LmjtBtWE4/4hKDSyG/8EL4WaurKN7mOY9H//4QH2rJGZH4SIuikJu6Kl5K4C4b92TjwLfCIsrZmRVwc+Z5Sm/R4U/8af5llChgyiSUhHuxSuyoJuYspaP9M0MY9CyVbWu12pTbp+XHXqpiFM65/0zioG2bSVw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003)(55112099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVNWYjVrUFF4Z0JoOE45MnlhSDFpK1l0dlZLTUU0L0loTk5FQmNBazcrbXl4?=
 =?utf-8?B?VmFHZmY5dFVhMDhaSFVicUl0Nkl1MUZZTjd5M1VkTWZnMUh0TStiZ0FjK2R5?=
 =?utf-8?B?U0NhQU1KY0lFVjBCbUNiU3NBNTZMcHJ4SUNCUU1jenlyTXpmUUFWSzBLa0dS?=
 =?utf-8?B?YzBiazEzUUMwVDJvMWM5UmZCem0zcGdOblVrekhxVUdLdXVLbVVUN2c5UTFM?=
 =?utf-8?B?NjRTakVGOXljd01RSU9jd2I1cHlSVTZjRmwyanJ2UHo3RGZWaUVrY09mQTZp?=
 =?utf-8?B?L1plZEJvNlB6aEg0bStJb1hhK2FQWkFBMG5zc1VYK3o5cFAzNDRRWHBKLzBY?=
 =?utf-8?B?OHN6SmlKa3hqaWQyZ0pzYnlCTDhlVk9WVTNzYnZLSXZteWZKaFJqV2wza3Zu?=
 =?utf-8?B?aDRIK3pFOGd1WlEyL1ZVVzhyeFBZL1BxQ2Y4UVhRdjNjVTZaSjh2R2UvUTlt?=
 =?utf-8?B?NzZFTUJrdk9uVllEMHduaXRkaGR4VVByMGtJd3dDZ09pNDFySXZBSHVkTmhH?=
 =?utf-8?B?VGljZmR3UE91bDEzb1F5OTlNTk0yRHVVSWh3M25qNjNuNWRSN0FWNGdZd3Bt?=
 =?utf-8?B?VDBzTW1jUXdUUmNIM3NTc20rWmFndHhKdlY3SlBkbEt2NVRSSEIxUzhaOGRo?=
 =?utf-8?B?RXNEU3hDMlhIQlVVdTJxeDdNSzd4OG0rR21mQ1pWY3ZYZ1p4N1BXbmh5d2Zv?=
 =?utf-8?B?OENWS2EvamoyTzY4RGg2WDM4Tms1QVNFSEFlY1NsSUhZa3lNL2hmMGFxL3Z5?=
 =?utf-8?B?ZmlWYjA2Qzc2STJGdE5wZStraTBnNkFVUkhoaEdTUmV6OUhkM0JjUjVBMGcr?=
 =?utf-8?B?a1FwTlU5Vk1uTCs5ellvczN0TUc2S1JkSnFKcjE3S3hWR1BBQ3FKSDQ4NEhq?=
 =?utf-8?B?cFhSNytSdkdRZm13cWNZcDYxRlQwVUhPWjQzeHdTU2FhQmJtVk01RDEyMm5h?=
 =?utf-8?B?RG0zclhqei9hdUZkOWtUcXU2REc2Qk0xMTBVOEMrWGNYQlk3S3NBM3VHQzRP?=
 =?utf-8?B?NnIrek5LWVIzdi8yTDYwRlN0eWxLUXlVQkU1THRMS2toZmM1QXRrQ1ZUTEtm?=
 =?utf-8?B?WW5TOUVHdThPV0hNZTZYZVdjaHhoOGtKM3k0ZzhIOHgvTmFoSGZJc1Z2aVhv?=
 =?utf-8?B?Uk85T1J2RURCYXhrbGNJMzc1NCtUVGoyMk9udjVsc1ByMzBQM1ZpZ3VVcSth?=
 =?utf-8?B?K1E3MDlZdmx1ZkRuVkgzcldxakpsYmJkcEZIa2pSQ1ZXYllHOFkrcHFMc2dW?=
 =?utf-8?B?SzQ2a1pZL1F3ZEJhNGlTY0hKbDAxS1BlK1FiK1dvdktoaG9KNW82c1YrZ1Fq?=
 =?utf-8?B?QkI0akFyT2hBWGQ4RjlVTFlUMkF1UDV6cU05d0xXTjdsNEtuWGJGQk1kUzJ3?=
 =?utf-8?B?dEdaNk9iYmhrTmtIQ01QSGhFQjNDUkVCT1dWMzdFUXROM3JmN3JieTVmeGNk?=
 =?utf-8?B?czJ4a2x3bTlsK01sbmsyTnhxTGtBLzNTMm9ZeVZOcGZJQWhzbGQ2ODVUQzhn?=
 =?utf-8?B?eHEzazU1VTl3dHBZZVdoM0RiUjAvU1BjNFRhN2IzS1Q5ODJVeFJSVlY2YVdK?=
 =?utf-8?B?ZmhZR0dBdmJ2MEc5OVNkRFVzZDh3dkVKMGpsT3lQMDlpVkoyMnE4NkNPTk1B?=
 =?utf-8?B?elIrYU8wRytaZFR5R1lOdUxxa1lNemxBazY4VXV4RjVnYjF2cC95S0dNM2JK?=
 =?utf-8?B?Q01PajhNK1FuVk9HMnVVcXVNWVFGcHVFRGM2MmhuWWc1Uitma2YzZ3NOS3l0?=
 =?utf-8?B?Rk80RzBCQkw3YXdXdjkzL244Z05sTWNvRDhKcTRkN0MwbjBzTVJDMGJ2Qmhn?=
 =?utf-8?B?OUVERUtnNGplWXpvVStRVlc1bklKTGRScnZRYjFINE9wMGFzMmFhWUlTcWZt?=
 =?utf-8?B?UzE0Q1h4Sm5uZzVzYzBnQmVyT0NjVjRBTGliZEU1TmtTVXBQOUtneGhubVpu?=
 =?utf-8?B?WWZhVldHZHJFSGJFbU1uaWtCSUgxWXNmaDVCdEltVklkdzEwZHkrc0hqYVE2?=
 =?utf-8?B?YkY0bERXRFRyR0RYcGVIdHpncHVPOUVFVnIvMlplQ0h3ck9XdURsQVFFNXVN?=
 =?utf-8?B?czUzck1yZThrSFZkT3ZTWFladDRKU2NuT2NHZnoyRDl3ckRUTkIzK0lvY093?=
 =?utf-8?B?S0NBa2ZDYS9KcEc0ZnFxdWVSVUh3SVNWc0VRNlJZdTd1WFNHK2hJQjQ3b3Z0?=
 =?utf-8?B?WUtZcUczWDA0UFlWQmYxa3lRajEyR3RqL1pZeUtnd1FSRWk3N0xMell4eld0?=
 =?utf-8?B?eVkrOGhQdkhjY3RZRlJoTk0wT2FpOXU5TTZ0Q3lweUIwTGlWa1FLclZsTXJD?=
 =?utf-8?B?blIzM1RkMlJJVEV1cVA0UGM3bjQ3SlNEN01XcUhab3BTQi95Z1ZLY0NVd0FI?=
 =?utf-8?Q?fVEx1t+4fxkzU8Ds=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <522411975D74B946BC34107FAEBC6384@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f07ea190-d493-452d-9cd7-08deafff961e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 08:22:20.2914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7sSz+IVGGXgtLi0pIMtbJ70lgB/m0B6hawKJPNMYRmdgxjgluQlbS+PrPyv0y1wHG4fddjjepsz3uv5MPTsnv5kIBy4YLakmBsLUGsUP74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6066
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

T24gTW9uLCAyMDI2LTA1LTExIGF0IDE0OjA5ICswMjAwLCBBbGV4YW5kZXIgRmVpbGtlIHdyb3Rl
Og0KPiBGcm9tOiBBbGV4YW5kZXIgRmVpbGtlIDxhbGV4YW5kZXIuZmVpbGtlQGV3LnRxLWdyb3Vw
LmNvbT4NCj4gDQo+IFRoZSBydGNfdGltZSBkb2N1bWVudGF0aW9uIGluIHJ0Y19kZWYuaCBub3Rl
cyBhIGRpZmZlcmVuY2VzDQo+IHRvIHRoZSBjb21tb24gInN0cnVjdCB0aW1lIiB0aGF0IHNwZWNp
ZmllcyB0bV9tb24gYXMgMSAuLi4gMTINCj4gYW5kIHRtX3llYXIgYXMgeWVhciBzaW5jZSAwLiBB
bHNvIHRyaW0gcmVnaXN0ZXIgdmFsdWVzIHRvIHZhbGlkIGJpdHMuDQo+IA0KPiBGaXhlczogMWMy
YTIyNTNmNzk4ICgiZHJpdmVyczogcnRjOiBhZGQgUENGODUwNjMgc3VwcG9ydCIpDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgRmVpbGtlIDxhbGV4YW5kZXIuZmVpbGtlQGV3LnRxLWdy
b3VwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2
ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiDCoGRyaXZlcnMvcnRjL3BjZjg1MDYzLmMg
fCAxOSArKysrKysrKysrKysrKystLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvcGNm
ODUwNjMuYyBiL2RyaXZlcnMvcnRjL3BjZjg1MDYzLmMNCj4gaW5kZXggNzM3ZDQ1NDdhY2EuLjIx
NjQwYjAzOWMxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3J0Yy9wY2Y4NTA2My5jDQo+ICsrKyBi
L2RyaXZlcnMvcnRjL3BjZjg1MDYzLmMNCj4gQEAgLTM1LDcgKzM1LDkgQEAgc3RhdGljIGludCBw
Y2Y4NTA2M19nZXRfdGltZShzdHJ1Y3QgdWRldmljZSAqZGV2LCBzdHJ1Y3QgcnRjX3RpbWUgKnRt
KQ0KPiDCoAl0bS0+dG1faG91ciA9IGJjZDJiaW4ocmVnc1syXSAmIDB4M2YpOw0KPiDCoAl0bS0+
dG1fbWRheSA9IGJjZDJiaW4ocmVnc1szXSAmIDB4M2YpOw0KPiDCoAl0bS0+dG1fd2RheSA9IHJl
Z3NbNF0gJiAweDA3Ow0KPiAtCXRtLT50bV9tb24gPSBiY2QyYmluKHJlZ3NbNV0gJiAweDFmKSAt
IDE7DQo+ICsJLyogcnRjIHJlZ2lzdGVyIGFuZCBydGNfdGltZSBzcGVjIHVzZXMgMSAtIDEyICov
DQo+ICsJdG0tPnRtX21vbiA9IGJjZDJiaW4ocmVnc1s1XSAmIDB4MWYpOw0KPiArCS8qIGFkanVz
dCBydGNfdGltZSAoeWVhcnMgc2luY2UgMCkgdG8gbWF0Y2ggcmVnaXN0ZXIgc3BlYyAqLw0KPiDC
oAl0bS0+dG1feWVhciA9IGJjZDJiaW4ocmVnc1s2XSkgKyAyMDAwOw0KPiDCoA0KPiDCoAlyZXR1
cm4gMDsNCj4gQEAgLTUwLDEyICs1MiwyMSBAQCBzdGF0aWMgaW50IHBjZjg1MDYzX3NldF90aW1l
KHN0cnVjdCB1ZGV2aWNlICpkZXYsIGNvbnN0IHN0cnVjdCBydGNfdGltZSAqdG0pDQo+IMKgCQly
ZXR1cm4gLUVJTlZBTDsNCj4gwqAJfQ0KPiDCoA0KPiAtCXJlZ3NbMF0gPSBiaW4yYmNkKHRtLT50
bV9zZWMpOw0KPiArCS8qIGhvdXJzLCBtaW51dGVzIGFuZCBzZWNvbmRzICovDQo+ICsJcmVnc1sw
XSA9IGJpbjJiY2QodG0tPnRtX3NlYykgJiAoflBDRjg1MDYzX1JFR19TQ19PUyk7DQo+ICsNCj4g
wqAJcmVnc1sxXSA9IGJpbjJiY2QodG0tPnRtX21pbik7DQo+IMKgCXJlZ3NbMl0gPSBiaW4yYmNk
KHRtLT50bV9ob3VyKTsNCj4gKw0KPiArCS8qIERheSBvZiBtb250aCwgMSAtIDMxICovDQo+IMKg
CXJlZ3NbM10gPSBiaW4yYmNkKHRtLT50bV9tZGF5KTsNCj4gLQlyZWdzWzRdID0gdG0tPnRtX3dk
YXk7DQo+IC0JcmVnc1s1XSA9IGJpbjJiY2QodG0tPnRtX21vbiArIDEpOw0KPiArDQo+ICsJLyog
RGF5IG9mIHdlZWsgMCAtIDYgKi8NCj4gKwlyZWdzWzRdID0gdG0tPnRtX3dkYXkgJiAweDA3Ow0K
PiArDQo+ICsJLyogcnRjIHJlZ2lzdGVyIGFuZCBydGNfdGltZSBzcGVjIHVzZXMgMSAtIDEyICov
DQo+ICsJcmVnc1s1XSA9IGJpbjJiY2QodG0tPnRtX21vbik7DQo+ICsJLyogYWRqdXN0IHJlZ2lz
dGVyIHRvIG1hdGNoIHJ0Y190aW1lIHNwZWMgKi8NCj4gwqAJcmVnc1s2XSA9IGJpbjJiY2QodG0t
PnRtX3llYXIgJSAxMDApOw0KPiDCoA0KPiDCoAlyZXR1cm4gZG1faTJjX3dyaXRlKGRldiwgUENG
ODUwNjNfUkVHX1NDLCByZWdzLCBzaXplb2YocmVncykpOw0KDQotLSANCkFsZXhhbmRlciBTdmVy
ZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
