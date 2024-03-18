Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D54C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 11:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75C2C87D74;
	Mon, 18 Mar 2024 12:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="uJtTEJZz";
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="oipAz0qZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A87D87D8D; Mon, 18 Mar 2024 12:15:53 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6B3D87BF1
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 12:15:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1710760551; x=1742296551;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pVdRUJmi6K/bhy3ybN5qNJdwZVbnI3zyPU+HkAXOUUo=;
 b=uJtTEJZzl7NBcqNfrfspZE23cqw99TmYxG7u+NzQkobT5UbQoVIBszQ0
 C1n/8rM6CjhFOAdqB14Im0oWEFuKJ/bMVbuhqEafU1O6djfm0z8/BRI8l
 h2iksleaFwgIzt5r63/QQJIbwLvS4xdtbfGFHc4d0t8pSgrFopIS4GZ9b
 EAXoBgtAdkA4jrWmTHIaWsJs1xQEqJSQR161VKnIr70s5NY0C5Iz1RMYA
 t54o5kj8Q6VuShxjwu0UMx+ixpiAD65O3FybcVf4OBZQDn21KSd7843F9
 mX6t8c03oGkNnsUScSQ49MMGp50nE51bmFiVQZ2FqsMBgOEVX0KJuPzHG w==;
X-CSE-ConnectionGUID: qkm/5i3JTwaFk0HTCJLsog==
X-CSE-MsgGUID: LoSf7pboRdC6RABJ5mVXCg==
X-IronPort-AV: E=Sophos;i="6.07,134,1708412400"; d="scan'208";a="17783536"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Mar 2024 04:15:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 04:15:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 04:15:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3txdjq1rOEnM6cZ4U2STiscQqa8FZ82tLNuE11fcEXtL+B1haKmXnaUnB0HsG2zUQbscj4SZTqdWgR+KUQlp++bceldcA2sgXUU2RzLU0vymBK/BFyfvkIml5vOvaBWpheJrpE4y1vD+62jYFb7/uhbRPRn5QiqV7TPNE3/GCmm5vJuNE93tZVY4zA0o8L3AjpFKDcvTxeHN5QghoUomPXIZnl3ifVCwWtkGUZSJeCaxRWBPR8bN1PE3DNiLzgzw61Eu/CC/p0GwO1CTeq5p6UGjSK2vpfiZkgThOTsWYAcAwU9iZGadQAxIeAAwWWcPcP2Zpw3Mpp7uDfOq9dxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVdRUJmi6K/bhy3ybN5qNJdwZVbnI3zyPU+HkAXOUUo=;
 b=ar7jwhvYDMDfiY8BR9ONwM+JQQDBXsxgXOW3wHDoQJdI2JM0r0096C8rp75QZX8mEezG9WcVrw4obCpZxQYqa6j0WixfZ3O6IzgrwiUgbjMkjfV1usJ08CvZuyYMc2QopR6dFahTvAqF05ZURAsxzRB8rZFl1asHEOeiFxkZBKvBN9+DlUPxUh7X8oYkt2dfI9JFoGEg/uDrZEp1iyNaPuDmHImWo4JKCdrHHOYkyH6XG5fKAqNemLqLhlvkHUTU5m7PlmdMYbTJkBq/iQUm8Hhtp/hdK6T7vBAOBUh8XVt5rUSV8c2ykW/nDBTnRpCGLAKBY6PCZoltLtgdHROf5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVdRUJmi6K/bhy3ybN5qNJdwZVbnI3zyPU+HkAXOUUo=;
 b=oipAz0qZlfhEzmbRTSh1wy7/EFqt0j64a8PQOPNShG+WOqcw2hAml+/NJWrds2iXCPB7arE8dTQpesLQ65VzQ5acyvzfluvhxDwpg0rmfk72J+6Rs81O6PPamm1Px2O+OJ6dVuv6wdwviVK9eu/byjOL31f2Cd0a2lZ60H9Y7oh+mC0kcFaF4Y4jK8g9pDko8CZ/735rUEd2dFC7g2Wua21KmLY/UTHtFXrLBDwn+BTusmTmkkAi0QTvkO5YBZEky0oeCpOcDYjU+73iqIkh42sb8mlrq8P8HXDU9OALVI2KUcwVWvddZIznxVzp0H1rGtSdVUdC2dFx4W2+VLau6g==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by SJ1PR11MB6108.namprd11.prod.outlook.com (2603:10b6:a03:489::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.10; Mon, 18 Mar
 2024 11:15:19 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c%6]) with mapi id 15.20.7409.009; Mon, 18 Mar 2024
 11:15:19 +0000
From: <Mihai.Sain@microchip.com>
To: <ada@thorsis.com>
CC: <eugen.hristev@collabora.com>, <Balamanikandan.Gunasundar@microchip.com>, 
 <michael@amarulasolutions.com>, <u-boot@lists.denx.de>,
 <dario.binacchi@amarulasolutions.com>
Subject: RE: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Thread-Topic: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Thread-Index: AQHacHYz5NjLBjcwWUSp31aMRMD+07E9M2MAgAAHzoCAAAQkoIAAHZ4AgAALSwA=
Date: Mon, 18 Mar 2024 11:15:18 +0000
Message-ID: <PH8PR11MB68040409774B3441A8657DA1822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20240307091014.39796-1-ada@thorsis.com>
 <20240307091014.39796-5-ada@thorsis.com>
 <82a5ea3c-ab95-4460-9685-2676fe18d6b5@collabora.com>
 <PH8PR11MB6804301C3B361D21EADCEE71822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <00241bf0-2543-4836-b43f-1b6452caf2e6@collabora.com>
 <PH8PR11MB68048E53C58FAAE710FE51F3822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <20240318-renewal-properly-6edd58ed9c79@thorsis.com>
In-Reply-To: <20240318-renewal-properly-6edd58ed9c79@thorsis.com>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|SJ1PR11MB6108:EE_
x-ms-office365-filtering-correlation-id: 99de7da1-85d9-4291-8bb3-08dc473cb208
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4n2k5UE9Ukm1w5XMIq3VSH70gV5haO5bIryQ80Ao/lGIlaJiCvHf+Y9uI9F12wXGlOFJriFCJQvG7QR0khp6YbDyfkmVJW4OhylRbsp8EZWZpqT1nFKUPLXIcDnoKFnMk0wqOZ2Y8SYDiiv4TSFFTiQuZ4RQZuqTMkeYotHViFaYfv9tV/E5l7vsz26+hug9I2m9rZZrWJ3UwOaW2RGwGyyujN28W92YSuipf2WRN95zQspMThrOTqXSu706HPVmeeWGCdZuhBPsHU7uCUOOx4M9IC97wngPY9LAHo97AS+tbpk1bCIa2nLP2FmiR5EqAC+eM8xTH6/JcWoa3nLbriYQRuV2nju+lXrWckrvRtvw+K+Dn/d9ppa1kSnaBj8i6ZAKt1ms0NHjfqy18f7FDBndiEf7hWR2+NkxY6rc8ntblX8NlIpa+kveO4UXozhYCK90zlMzQOjL73RRJMsdmdxKCGpEY6RJNmKzw7Sn+ZYSbc1SzMGrscxgNSd8t03oZkwsO8+/nN2rTv7VZKR1geHzmGVcsxqk56TUAtFo6TLKvs1H9F8mGZoQJAekbyKForM27IuD5fZbYx88LPEvAlSEsEzcenfrP15FxHlGR6gEArriLmmXCtNkJPJBbdrkA52Wff14TKbxfbeq11V0HOheo5yQO/IW8/c3bpZ7H8c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1dEV2pSRlJYMFUyUUsvdWFneFdvZEFDMTdjaGpQMU5UbzUyek1lREpoK09J?=
 =?utf-8?B?cldLR3QwTzlWZHVHWi92VDNwOXhNd09CUkVMWDIvSk84RUYvdHJSZzJLZllQ?=
 =?utf-8?B?QTVwRWRhMWFVcU5oZXFtSmoyS3Z3WGc0VjBwVFRRRWg2MzBzMG9sYllrUTZ2?=
 =?utf-8?B?TXhpZkRNTUlucHhPUXJpM0JmM09ETmlucmozdDBCdlh2U1IzSmpFT3BCeGdZ?=
 =?utf-8?B?YWFSU3lPRVpxdXpTa1FBSHh0eGw0dTNCT0dQWllVOVhVWHpGb0FlVjdJbjVU?=
 =?utf-8?B?VFFTOUs2Qi82NDBBaGVVNEgrbFQ5d2tlTnllK01EYVdXVUMyWk0yMm5XczhR?=
 =?utf-8?B?Wm92dXpoQzJGK1Brc2ZVR3hHanlOVU5OaEgrb21OL3dnOXRoek85cFJzK0t0?=
 =?utf-8?B?d2piOWxNOVZSalozVmxpeWRHeHpMbHd3WEpuY0toN01nNHJnd2FRRVByYS90?=
 =?utf-8?B?L3NCdm9JUjNFZnNBNlpOY3dzU3ZWQVVPQzFoR3JWblVYK3g5S0lLRjVFMEZF?=
 =?utf-8?B?Tmg2SFI4cGtvZzRFOENUWkNGUnhvbUdXb1lXZGh6SW5OM2ZrMmlVb0VOWnBG?=
 =?utf-8?B?MTR1MS9RTzh0TDU3djBhWnNCbTBvSjF0c2U3V0FNbHNvWUdrdkgrVGZJb1ds?=
 =?utf-8?B?bUdqRk8zVXprc2oyTWZNWDQyUnEwTksxYVVDRlY4Q09BaGluS2phWXY1Vms0?=
 =?utf-8?B?R0s0aFU4a0k2dFNFajlJRzlRQUs2aUQ4c1MyMXErV3lLSGRpdzJocDlwY3dZ?=
 =?utf-8?B?ZURwcUZoTHZpbnFGcytFN3p6ajlqWXZKSjYrRDR4V0QzeUJuMWlBaDR3ejhY?=
 =?utf-8?B?VmNYQlYzdHRSbXZVVzh0WFlxWjRNaGZkT05XWVdyRlFuMnllMjlPdWp6MGsz?=
 =?utf-8?B?WVRKSGh1cXpCMnhwYmE2d0R0WVBKSEdqcnFVdVlaNVIzeUYrRzZUVnZNSjhP?=
 =?utf-8?B?dzZMcTR6R2YyaW91anlUbVkxUnNTeE5SWndycm9ReXJ5YlYvRzBxcU5pMEtv?=
 =?utf-8?B?azhKZzNvUUdtaWxTZFR0QVkrNG9QOEo2UWNSQ3g4QXpUUEdKNUZ4YU1IeXFN?=
 =?utf-8?B?M2dDbmpKT1dHMTkxdXJaQ1g4bnhGTE5ZWnR1RnZ1cklIZG5HUFBLMnR3eks4?=
 =?utf-8?B?N1lwZmgrRkNpYVhxR0dwaDhQZDFtZlMwVGdZN1Y1VURvWVB1YXJ0Q1FuT0t2?=
 =?utf-8?B?eXpLSEFOWlZrdXQxRWVmK2hJbW1sZS9wNVdRNjd0aHRDUzRDMzRadzVSSnlw?=
 =?utf-8?B?b21leXROWmdUL041SUN6cjA2amJoTHBmcDgxQkJNakN3eVJmS3Q4Y0RqNC9m?=
 =?utf-8?B?UmtyZXlyak5SZGh0M3dLMVo4YWtHaWdtNzRrZTN5dXBndVRFUmVoMW9Ia3cy?=
 =?utf-8?B?UzVQUVlDRk8zQkppQzQveHVRUXplSVdwRlQ1Z2ZkOW9odXY5Z0xNRTlJcGVi?=
 =?utf-8?B?YUd1dmIrV2pYcXdRRENURlJqcTRxcTVRYmkwNXhYVWQvb1g4blpBZlRSaVFx?=
 =?utf-8?B?OFNTV2tZdEtLY3NPQUM5YkNBcGY0V2tnQitKM0d1N1ZBZ1ZCcnV1WnVZVW80?=
 =?utf-8?B?S3dORUY1bTVVMDhFQmE2c3kxNWNtanVNWENmTkFrTVNKWjAwMkFJZlk1QytU?=
 =?utf-8?B?cVZPVXUwcm00azZpYzhlUmhtTTV0czBaQVZKMytyay9hazVxU1d4a1hTbmp4?=
 =?utf-8?B?b3I3N3B4cE1JaTlsSTEreG1KTjVTRDRvaHFrdkRNcG0xU3FsaDF6TUJHeGpj?=
 =?utf-8?B?UWFjOE40VWpaR2t4ckw5Vk83VmJPdkhMdGZVejk2SXc5TzdzbEN6K3NlREZV?=
 =?utf-8?B?WkY1NFJKSjQ2REpMd0Z6VUlhVDRkc29kamhxc0lmZHl6THVIVjBlVXpVZEQ1?=
 =?utf-8?B?RWZSZzJEdU01Zm1oc3BRVFVIK0NIS3gwMEc3TGtKMGxJTFpWS0lmN0FXOVlh?=
 =?utf-8?B?SFRlYVVkc3plcmtZTGthL1J4ekRGb1hlWkRGRENqK2ZzVUtlWUdvcDZFTU9a?=
 =?utf-8?B?c3o3WmZKTVAxdUZwaEY4YmpEbW13cUlTYTRUZUVkUnFhazlQWDN3aDcrSlZV?=
 =?utf-8?B?Y2orWFpYQnJHT0RwS08rWGVmRUpvbUdUSkcrTWJqNjFORW1yTEdoMTcwZ2JJ?=
 =?utf-8?Q?8uo81ZP+rvrBBA4kf5yxcy6gJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99de7da1-85d9-4291-8bb3-08dc473cb208
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 11:15:18.9654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNH6XoBjimEBzSefTCbpTUqTi91650TrvKBJ5alH8iY4tbIWNR6QUt2jFLzmhXz6j91p6kVsC0RnAvzkv9DQIVb7AFhG5ru8tVMPnxqhaks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6108
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

LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+IFRoZSBjb21tYW5kIGlzIHZlcnkgdXNlZnVsLg0KPiBJIHdvdWxkIGxpa2UgdG8gaGF2
ZSBhbHNvIHRoZSBPTkZJIHRpbWluZyBtb2RlIHByaW50ZWQgZm9yIG5hbmQtZmxhc2ggDQo+IPCf
mIoNCg0KQXMgZmFyIGFzIEkgY2FuIHNlZSB0aGUgYWN0dWFsbHkgc2V0IG1vZGUgaXMgbm90IHN0
b3JlZCBhbnl3aGVyZS4gIE9uZSBjb3VsZCBwcmludCBpdCBhZnRlciBpdCB3YXMgc3VjY2Vzc2Z1
bGx5IHNldCwgYnV0IHRoYXQgd291bGQgYmUgaW4gbmFuZCBiYXNlLCBub3QgaW4gdGhlIGF0bWVs
IGRyaXZlci4NCg0KCU9LLiBVbmRlcnN0b29kLg0KCVRoYW5rcy4NCg0KPiBBbHNvIEkgcmVjb21t
ZW5kIHRvIHByaW50IHRoZSBtYXN0ZXIgY2xvY2sgaW4gTUh6LCBhbmQgdG8gcHJpbnQgdGhlIG1h
c3RlciBjbG9jayBuYW1lL2xhYmVsIGZyb20gY2NmIGRyaXZlcjoNCj4gaHR0cHM6Ly9naXRodWIu
Y29tL3UtYm9vdC91LWJvb3QvYmxvYi9tYXN0ZXIvZHJpdmVycy9jbGsvYXQ5MS9zYW1hN2c1Lg0K
PiBjI0w0MTANCg0KU2hvdWxkIGJlIHBvc3NpYmxlLiAgSSBjb3VsZCBkbyB0aGlzIGFuZCBzZW5k
IGEgdjI/DQoNCglZZXMgUGxlYXNlIPCfmIoNCglBbHNvIHBsZWFzZSBub3RlIHRoYXQgb2xkZXIg
U0FNOS9TQU1BNSBzZXJpZXMgaGF2ZSBubyBjY2YgZHJpdmVycyDimLkNCglPbmx5IFNBTTlYNisg
YW5kIFNBTUE3IHNlcmllcyBoYXZlIGNjZiDwn5iKDQoJVGhhbmtzLg0KDQoNCkdyZWV0cw0KQWxl
eA0KDQo+DQo+IFRlc3RlZC1ieTogTWloYWkgU2FpbiA8bWloYWkuc2FpbkBtaWNyb2NoaXAuY29t
Pg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IE1paGFpIFNhaW4NCg==
