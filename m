Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C66F433CD
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 00:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11E45841D5;
	Thu, 16 Apr 2026 02:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="aX36BLtL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AEB584206; Thu, 16 Apr 2026 02:14:37 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81505841C8
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mu/8varJwZjmC1PyMy2ZcUjj79HA0suG1KwwxJDIo6k6pYa36NsqgIttDQpSwokZ/AeqF5VzIJd1dtE73r0uQYAfpWeYA4lvOXtBl7YaigXylRr9w7JbeCBVSicjYlU03MDq74V/KehCD3r73M2ON7HSCTLZShzPQeIPXnFRw/2LbcrtdczpGPFm5HrtNb1VAuO5UJZ8FfqByZxl+Bsa/W0BsF5qryzbmEnjDMtmwNU5ImZbzJuso5i6dTp5W+csN/qRunb7+D/gbr0XlmBppn7bAnNopNbYvNvGeZIs+REK30D07JN+q0/TRmvAP7G6RZ9M52xddadMbMAQf5Pcbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6pf/1ECtFWDWuWDcgNyeakR0O3SH788uf+ZCiYsLNc=;
 b=EOZxJxFQN8lcVRqxxyd/I+Aq7zVZcuZ329pdRKwbSr3nOsr15r47qhYFywsPOXYm4oSPq+3li9sBYwUw8PREC06fqXnfWHenhEjGdZTfUFtcnfi/Ul69SANX26UnNlSgiLms0jk90Rrz6HWyKjMSscOT+yaLo3tlODkwsNweyheg53wlFsN9hSc7jE03+2zR6LYKByUfUKvpXnzmFMrlCgnNuXseY6d3sRtE1ZwoVQlElHWZxF691se4so5fVwNVTJbU7tBDbfispoanyQ07Bbkp3n+frAIAxO+6EjRQtKcWXIP3JxqZtSWZPyKOWkOoYADFKbMlD+zslZ9OIhLkxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6pf/1ECtFWDWuWDcgNyeakR0O3SH788uf+ZCiYsLNc=;
 b=aX36BLtLNYCD1a99X+5gdLG42WRin6p2gB4NQB55sw19vX+nybRvmQQO8E9o5qDF7i/PhY3p0QPEp4WEGQUthdWEnHmqleeYxZwCSe6VhUYL3WYVIrfAXOGhNXjn3oasiQvx/AfnEnXOrQhulnl5cZKX0ciLmENnVgyMAdnPXSt+kmfA9eKLaYgj8mN2n1PPyfrFD0JGRCgxxNqfzKh3UOdzz0VUksH6j9Nt6wWf4S9hQ8tm25WUxgFMSx8C8xjcUQw7p5Hb16qO3h4cQHQvKkDPr7y6pwHo98mTRovDsMA4vmeSGxNnOyyTFpWsL0OGWHmBTutdt+Lk03xNOz6TrA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8850.eurprd04.prod.outlook.com (2603:10a6:20b:42d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 00:14:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 00:14:33 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Primoz Fiser <primoz.fiser@norik.com>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>
Subject: RE: [PATCH] imx: imx9: Select ARCH_MISC_INIT for all i.MX9 SoCs
Thread-Topic: [PATCH] imx: imx9: Select ARCH_MISC_INIT for all i.MX9 SoCs
Thread-Index: AQHczM2S0cXvAU1Vl0Ga7ckAnHMIg7XgCVpQgAAIbYCAAMBvwA==
Date: Thu, 16 Apr 2026 00:14:33 +0000
Message-ID: <PAXPR04MB84594BED92985AB58BA16D8888232@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260415114658.3321643-1-primoz.fiser@norik.com>
 <DB9PR04MB8461701ACC88F0AE7F5B89CE88222@DB9PR04MB8461.eurprd04.prod.outlook.com>
 <f13a6b0e-7409-468c-a9a2-e597165b1e68@norik.com>
In-Reply-To: <f13a6b0e-7409-468c-a9a2-e597165b1e68@norik.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8850:EE_
x-ms-office365-filtering-correlation-id: 36fe777c-0a23-4864-5c56-08de9b4d231a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: lRWO9HdwLHIpOi5IYG9DmVWFZ1gHGFu0kEXEfjyrrTt+Lw97WwPZ+j1e6Oo1fyUEO3UVxioN25QgG5GiJoLYq3sFB9UpSpT2MiHq0AAbb862gf1tmMZ+DXT6izrC+pgXDamS+WjvB431DxAqGAdPneVoMcgTOKBAtiGPR5DJKsd9nubQg02VPJBsBxCUQhPQYMdflIwRZ4FT7Gc5Q6dMSHQ8wg4D9G3N9gFKqYsmrmo/GfEe5At/E+sFKQtwNnkpwVEr7xWHVkwZ9pD9gXfFVMpaRvlQqBynRsIspDz0m/uYZYctx+u3qCyfsMJIocU9ASQHPA6Qf6TN5KEbzUypYihS2vaPB73DkkwVcfMw+JepNFOhlcAvicTmSYmHdIVIbaU2MGQ4+q7Y/vsxlZXBC97VCY5M1QVC2f1WRXbGrliuri3TeWjEBMsnZBvW52/ZG7Sl5/ziqHw9yFSfPReHDh5JuEAjvy513LoUnnAuJkw9Cjb/6qQ3RVt8ACHZHzq3OByOIU44v+AVENRX8S0H1R6gxIlFgO/M+iRbB3rjY/GvaODvU2SlPL/XtjbkqCPOor9QfeprOW6VbDDQreQnjv4U1AK8IzONQ6oqs/qp4C8TsktgFNxdwmpfZddkSPJbuGZRTULqJuWsKYUlsPCkDl9zNUq5ohIkZMLfgQPBLpv3ysBNbkr3vnIQwgoOaZ3Fhp9YBGjnwFfoqGQFsXbE58PF/4SVFityYrdQD8V/gFMrWdpofugD8HGPxMQpju7OgzZ4AncYlXzSTLDEEHYE0JIGueoIskP7R+FoWSTAUQw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nlhld0l3SzBCdm80V1ZJc1ZSbkpUa0NpNHQrbkFMcjVKT3FlQ0lGbzhkRVZk?=
 =?utf-8?B?Zkcvc0w5Z0pPTXJiN0xDNXdVeEw4ZEFRMWdrN3k0ZWNQcFpCekh6SGFZZjhU?=
 =?utf-8?B?UHplOTVlVnFCNXRtQlNoc0lFdXZJUnZNbW1rQlh2QkJmM2JvSkU3b25tRUZV?=
 =?utf-8?B?WXVKcStnanZ0SHBQenJmODliYmVuU1lRMUJaclpIZDI4TXB2ZWV4OWVDWXpx?=
 =?utf-8?B?MFBBTWpCTm4vcTdvNWFKVHMydWFTbVp5amlSY1BPc3gyemppTEcrQ1J6eS9Y?=
 =?utf-8?B?MFJ2QXhKZmQvZ3BSN2hkenhuM3lWQ0xFME5IYVc1RVVuMExFaEJZQ3ZOYTlJ?=
 =?utf-8?B?QWZxSm03aHMvemZyU09UUXlPUTlENit2RklVaU5lcUVxSk1QK3d3TmlucHhs?=
 =?utf-8?B?VHl4Z1NzRG13KzhwTUZVOEw1YWFtZkxhaXRKSloxd2FtZGZIemFZRXdZM2Fk?=
 =?utf-8?B?dFpkTDNMbkh2V0FFZlJhY0FMM2FvSzdha1YwOHd3aFdZWXNWK2J5WkdRUm1z?=
 =?utf-8?B?bjJ5a1oyTFhVWnljR1VNaDdMQVV1VGhPM0l4dklxR0JCS1ZMUFpteEhhNzVC?=
 =?utf-8?B?SW9adHIvYWo5MjZNK1VyL0NlUkxIRFI5ckxlYmFYd3A2V3JKVkZKcGdvZm52?=
 =?utf-8?B?amFTN2J4U01HUDVYZDduaWw0bk80dVNQdy9yMUNYYlNvOW9NcXZJbWZTN2lo?=
 =?utf-8?B?dWNZWmMvZU4reWpJa0IxdW44eHNZVytBOHphRXNycS9EUUtHVEJOK0p0Rkpj?=
 =?utf-8?B?SlkvVzh6YTYzQVVtTlRaODluM2FrNUhndFVZM3lVWTcwME5IdTFxODhDTmFK?=
 =?utf-8?B?VDF4amdPRUNrTldoT3gxR3FDSy9WTzBKUlNPMWdLeHhMN1U3cHRkRytoZnRC?=
 =?utf-8?B?aHVKNGR1YXVFcVF1bEdmN1NOQm9EYktlTXlvenF5WjhLaHg1T3hYZ29xSCsw?=
 =?utf-8?B?OVN5YkJmaFU1TVhLVzFseVoxOU5sSmVsU2Y5OGRVRllXMWR4eGZQL1ZUbWNs?=
 =?utf-8?B?Z0NJN2RZRUJsWjVkeEo1SHBUUFJRSHFnTkd3Y1Y5QmRLNnlKUjIwSHc3QzNa?=
 =?utf-8?B?Uyt1dkVhUmNhNWFzVHEwWENXZXJNN3RHN3A4U2Q2bVRyaDJ0U0ZtYmw2aVpC?=
 =?utf-8?B?eGh5dlNkdlgyLzZKMHVFQ0gxRHVMWGxKMVBObFRUeGp1STd6ZUNLcEFteFcy?=
 =?utf-8?B?enFIa0FiUHJ3YlozcHkyRVdtdTNzK0VLN1o2ek5qN2VWVmRQclh6TkFRSGFj?=
 =?utf-8?B?MUt5cWZ4bXJjRHVYLzRySGVWNTBCL2M1NHdrbTJIN0tZMUlSd2ZCMG1JQUty?=
 =?utf-8?B?ZXdGQitPbDlMcXFKSzJwci91SlFTZTBhREdLeDlNYS8rUGg3ZlVIa2piK1RS?=
 =?utf-8?B?L0F4bWpINnIraHljbENLQUJJTnV5dnlqaXdOV2h2MHJTSHFMNzZmYVJHQmcz?=
 =?utf-8?B?QVpiVVk3bFJ1RU9TSnlob25kYmpwS3pKK2NkSW9pY01TSEkxSG0yc0JIaWQr?=
 =?utf-8?B?dHI2d1dabFNMMXcwRjFGUHM5Mk5kWHdJU0RHQVBFdUIxTnFZQzZOM1Aza1da?=
 =?utf-8?B?aUxTMG8wU21HcCtnNEVVYWJDT0NTU3l3TXZqdTlxYUR5OTBHblVvek8wTXNG?=
 =?utf-8?B?aysvelZGS1l3b0JSdkdCdjhvOTl2RmplcnNyK0NmRG1kTDJSQ1Q3ZnRvYmEv?=
 =?utf-8?B?R1BzWHQ3WFBqaGhNWmVXeU1qN2dnNCtQeFJmSm9rMFRIMFUyamJWSHQyMGNB?=
 =?utf-8?B?MVpSdmNoR2YyaHBpN3dwdkIwMlZoS2RKNVF5cjl0U0lvaXFzSngzUC9uaUp1?=
 =?utf-8?B?MmMrd0Y5djdmb3dvZU9lWXZhclhHOTZ2bC9KOGdHU0N2ejlTUVNZeUFnZW5i?=
 =?utf-8?B?Z2pCdWJSU1lJcmRTeHA3Z2dtQ1lmVEg1enByTkxZSEhZeit2NUJrcFJOOEVQ?=
 =?utf-8?B?ZFFSNC80TnR6UEZha3NnYzNhejFxbjZOVWpHL2tXcTJ0TXNYY3FralVmSjB2?=
 =?utf-8?B?c2ZMcXQ1Mkh5SE9VczF3c0lWdEZpbnhsdVVTZXE5U29UdlpvMmZTeGpHWVE5?=
 =?utf-8?B?aU0yNXpRVVVKTzlzR0hMRTFRQk8zWGx0ZWpCSlh5d3hBT3RXQm5jRmNITVhO?=
 =?utf-8?B?U05DNWdlWmtDazVTRGtvSmoyYU8zNTREbkFHRkxrbm9BSmZsakIvRjR2c1ow?=
 =?utf-8?B?by9wTlVObkpod3pPVHpMUEtycFdzYkt0VmRzbUlSNlNjY05iVDQxOFRMTVhK?=
 =?utf-8?B?WERmNXVIa0JuclpqS2FveEVBTHplN1FGSmJVd29NVFdEM1V0cEFGdWt0K2Vv?=
 =?utf-8?Q?1q/7ZYZEXEV9jErDia?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fe777c-0a23-4864-5c56-08de9b4d231a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 00:14:33.6675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fP9OWcYKwJiqXGg3Gaorj9bSKMXWkosVACuATwYGtK/Nx3odb632OVET6bqHv2ijTkLtp/nG4pX/UJzZhEayg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8850
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

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBpbXg6IGlteDk6IFNlbGVjdCBBUkNIX01JU0NfSU5JVCBm
b3IgYWxsIGkuTVg5DQo+IFNvQ3MNCj4gPiBUaGlzIHdpbGwgYWxzbyBtYWtlIHRoZSBLY29uZmln
IGJlaW5nIHNlbGVjdCBmb3IgaS5NWDkzIGFuZCBpLk1YOTQuDQo+ID4gSSB0aGluayB0aGlzIGlz
IG9rLiBCdXQgcGxlYXNlIG1lbnRpb24gdGhhdCBpbiBjb21taXQgbG9nLCB0aGVuOg0KPiA+DQo+
IA0KPiBJIHRoaW5rIGNvbW1pdCBtZXNzYWdlIGlzIGFscmVhZHkgY2xlYXIgaGVyZT8NCj4gDQo+
ICIuLi53aWxsIHByaW50IG91dCBFTEUgZmlybXdhcmUgQnVpbGRJbmZvIGZvciBhbGwgaS5NWDkg
U29DcyBub3cuLi4iDQo+IA0KPiBEbyB5b3UgdGhpbmsgZXhwbGljaXRseSBzcGVsbGluZyBvdXQg
ZWFjaCBTb0MgZnJvbSBpLk1YOSBmYW1pbHkgd2lsbA0KPiBoZWxwIGFueWhvdz8gVGhlbiBJIGFs
c28gaGF2ZSB0byBtZW50aW9uIGkuTVggOTUyLCByaWdodD8gOikNCj4gDQo+IEkgZXhwbGljaXRs
eSBtZW50aW9uZWQgaS5NWDkxIGFuZCBpLk1YOTUganVzdCBiZWNhdXNlIHRoZXkgd2VyZQ0KPiBh
bHJlYWR5IHNlbGVjdGluZyBBUkNIX01JU0NfSU5JVCBvcHRpb24uDQo+IA0KPiBBbnlob3cgSSB3
YXMgb25seSBhYmxlIHRvIHRlc3QgdGhpcyBvbiBpLk1YOTMgc2luY2UgSSBkb24ndCBoYXZlIGFu
eQ0KPiBpLk1YOTQgYm9hcmQgYXQgaGFuZC4gQnV0IEkgYW0gcHJldHR5IGNvbmZpZGVudCBpdCBz
aG91bGQgd29yayB0aGVyZQ0KPiB0b28uDQo+IA0KPiBGaW5hbGx5LCBzaG91bGQgSSBzZW5kIHYy
IHdpdGggaW1wcm92ZWQgY29tbWl0IG1lc3NhZ2Ugb3IgYXJlIHlvdQ0KPiBmaW5lIHdpdGggY3Vy
cmVudCBleHBsYW5hdGlvbj8NCg0KSSBhbSBvayB3aXRoIGN1cnJlbnQgZXhwbGFuYXRpb24uDQoN
ClRoYW5rcw0KUGVuZw0KDQo+IA0KPiBCUiwNCj4gUHJpbW96DQo+IA0KPiANCj4gPiBSZXZpZXdl
ZC1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBSZWdhcmRzDQo+ID4g
UGVuZy4NCj4gDQo+IC0tDQo+IFByaW1veiBGaXNlcg0KPiBwaG9uZTogKzM4Ni00MS0zOTAtNTQ1
DQo+IGVtYWlsOiBwcmltb3ouZmlzZXJAbm9yaWsuY29tDQo+IC0tDQo+IE5vcmlrIHN5c3RlbXMg
ZC5vLm8uDQo+IFlvdXIgZW1iZWRkZWQgc29mdHdhcmUgcGFydG5lcg0KPiBTbG92ZW5pYSwgRVUN
Cj4gcGhvbmU6ICszODYtNDEtNTQwLTU0NQ0KPiBlbWFpbDogaW5mb0Bub3Jpay5jb20NCg0K
