Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF17CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 10:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E21EB84119;
	Mon, 18 May 2026 12:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="fOCQB0cq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C941D84664; Mon, 18 May 2026 12:35:53 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A038983EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 12:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsWF30lGtRIMGeW5TkB4bHDUg8YtBAtxGjuWU5W48HNqq4eWmXJSF3yd/+2cs5SNIeCnqcOHQ6GWQRQoMCcvdT7ti5FwC2jHIAiYLx+I9d5UFS5LeyEuOy0uvINkyULXm0wl130o/3RRcd1Eff6dRY5nSw/XLoQqMXBGcONoVShRnhUBJDDgwNMFzUqYPPWvlWTEtZmM9v63l6PTtru4HoqD+Q4I+9X3nz4j5bDpocLv/y8wU+sc4KnpiVfxIZmmdI8Z/sBXZ0lP6z5u6jb0HFrB2p8sUX6m+KMKwDKxyyHbTjeKhMnzAhUOQxg5O6EmoHfl+xzxCYI4Wm/8rkV7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHmFTEYyMuHCtumT0FdZ/dclP8v0uVWOHM0T27sPB/k=;
 b=n3pb85BvOXBJul8pSax14aaiWbbgWduWRSi+QjodbgqXLJby2mRedoMGT4oVBjtlPM5dkHNq0MOvyUceuSxP4G35Wwtl3kx60Xjy/Nh666e6LaEnAxFleRYZmF6HZJvgOMCIy7JsG1hetnSnwewcTP0HsbAqbwnYSYwjNzKZisCOG2Un2GMSPZRpihSZ5nmkZ3mxYRotZMSxsU0n0DIG6iW0mGa/8Y9zRKGhY4MOSpMsBitmAdUvwgeESSo5SFosoZXry575fqVdZEBrM5RwcwTumiPL26R0f2IAT4yfphy05oODNq6r2gd9sh84l6h71TVeJ86foGfMkH2Tnc8bHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHmFTEYyMuHCtumT0FdZ/dclP8v0uVWOHM0T27sPB/k=;
 b=fOCQB0cqUZFgCa7PEMckTDlj0DyyeYRpmEvEB190G5yIa7AEQ6JmTg2dW9l5tcK3Udo7cVm0al/fy8XRhajGqJSON/QRhfpkwtCEiwdkELl3rKD2sa7/fvkkNp1dJHEMN+1uQxi3g0SnfnimD8p/KKz9ZRP5PR3ZgUh1d/rOIpvBj7HZqZhVfp1NZxCbRidd2KNRm6YDPA00gpNDvJyZ7Wdt7kCf8L9/mLGR7lCBjoBemrLTPzs7SmmlQkJevpj8AIpMYoFBPeCHcLdIGooI9zeFp5liejBUBvgSBjxd8zBcWcKQN33L5mTvl2lTNueCw3PBZjcpU0wo5NDDsfORhQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV2PR10MB7077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:de::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Mon, 18 May
 2026 10:35:46 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 10:35:45 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "festevam@gmail.com" <festevam@gmail.com>
CC: "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "michael@amarulasolutions.com"
 <michael@amarulasolutions.com>, "ye.li@nxp.com" <ye.li@nxp.com>,
 "lukma@denx.de" <lukma@denx.de>, "peng.fan@nxp.com" <peng.fan@nxp.com>
Subject: Re: [PATCH] clk: imx: don't build i.MX6/RTxxxx code for all users of
 CCF
Thread-Topic: [PATCH] clk: imx: don't build i.MX6/RTxxxx code for all users of
 CCF
Thread-Index: AQHc2YdbP9wvhWpEGUmIboBKL1MDiLYPMcQAgAR/VgA=
Date: Mon, 18 May 2026 10:35:45 +0000
Message-ID: <d2d9e056ebcdba71abd29aff76368061dc453dc6.camel@siemens.com>
References: <20260501162706.543779-1-alexander.sverdlin@siemens.com>
 <CAOMZO5B9W=WOXHRKdj-gpirD3z1WeODiFkYFB9ULZR-a=QE8sg@mail.gmail.com>
In-Reply-To: <CAOMZO5B9W=WOXHRKdj-gpirD3z1WeODiFkYFB9ULZR-a=QE8sg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV2PR10MB7077:EE_
x-ms-office365-filtering-correlation-id: 443ff209-f5b3-4c12-31db-08deb4c9384f
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003|11063799003|55112099003|4143699003|38070700021;
x-microsoft-antispam-message-info: 43aDN0g0Z2gHQEO0og2VW+jNyiDPMVMMWoTHVDPMCtwBYDPoVb3NbZy4GEtD4nJjDN4J/gWjm1OuDQU8hIHNjrtpuumtsWWvoIndtr4qcKirvJtg0X73kxaNTwPwdez+syCFIWM/uRnKiv3n1KlO7oEiFH9NpGnCMFAu/3wbDStdZESjNUaPO/2gY/WMbCsn7/1BVRYso0FnTa0rxvQkTpW1V0L6etpHrERHE4vv633jDJy8uQf3cyok6Pfl8g9X0y4pqRszw1E120lJyXYY9ATn9GQZ3gOuA4ZNq36h6m+AMjt7cRLfqmKAAXkIiYGpl2Q47OmGAnc75kIx75Idn6t2kx6Nl6qerPZwFuf3sJ3fNodtmjKJLyxF4U1QEk54RODbeqlmrvt7r233RR008flecpwkzIaZhsIlMcGTAD7cEAsH6F+/Kpzs7C2qnPGOlxI3ebV0lsy62zmLBMds02hrEs7vHNLPrgMgCMAch2Uy5yYPR0TSw4MC4XkPjbbdGSvo2SvvYXmw+qy0ISf0f3AkTf9IRQgfxIIxVGhsVVLoWcnbbTuLbUd5781DaTQQ8MQsLOL3bY3AV72TGSvAqAqYqj4ZWvcCu6FckXAHBfOrnQgkKojWWfaRpus55+alH0VIeiWU0vxfz3u51T/O6jR/7ntYA7Dypuv/cNuWrHhxK6MvbRzOu2cbMTOav9XI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(11063799003)(55112099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDRiQ2hxREVIemRnOEhEb3lCVm1tb0p3czE1MWNSM0tSeXNsbDVwL0RTcDRy?=
 =?utf-8?B?d3VtQUNCeHVHeEhLRHlpaVo2RytWNVBHY1FvOGY1TVprdk90MGM0OXdBSmJq?=
 =?utf-8?B?TGsrZ3RibmNjZE11Z0VlVDhkV1dKVkU0bVh1UUNScWM5Mkd3SzZJSVN4RTJv?=
 =?utf-8?B?dXNNTE55SlNUNU0vUTExOW90U2JUS3pkQkZWZlZtRFkvOFk5QVlOWXdzMTVm?=
 =?utf-8?B?S3crQUo1a1BUYnpyaGdheTZyUWxOR1VaVmJ5S1hYanptQ2taTkxKN1oxT2g4?=
 =?utf-8?B?djVGcUI2N0hpUDU0VlMydkI5OU1SYVVyTi9xY3lVRVl3WHNYYkczNFNZYnBs?=
 =?utf-8?B?Um1teTdyZk1rejdMOTdQSWtDZjRCYlhNalpXcEVmblVubFhsMzN1VjdJNlNB?=
 =?utf-8?B?NFdBMXY0b1EzaG9WaFpVaXFGclE0OElBSElIcjA2cDhYYm1FQWZuT2k3Y0c5?=
 =?utf-8?B?QkZFaGVsVVFDWFdxZzFuVVQyOGd4alpOb0UzMFVSZkhtMXVOWmFOMXh5V2Z0?=
 =?utf-8?B?MjVQQUVUUVNGeGN4UHpKNjBYcmo3N3dJTnQ2UUpzb2hNeWdVSmtQZ2gvVHNO?=
 =?utf-8?B?T0p2T3kzRTZjSXFSeFBaMFRkY1pmaGlXNmVxaHdoemkveGVFZzByT2UrblNL?=
 =?utf-8?B?R3crcldpVUg1b0pUd1F4Vld1NHByR0lTU2ZaQitIT1o3bEdWOXp4UVlDdHps?=
 =?utf-8?B?ZkxaSjVGcFVKUXJuQVVIRTFsV0EvamRKRFdkUE5zUlBEcTdrZ0hQbHp2Nmpx?=
 =?utf-8?B?Q0hZZnlwVGlDaUJ6Nnk0NHROV2llNkkyR3paTzZqWmNZL0taSHowQnVHSlB4?=
 =?utf-8?B?SzVCcmdQTC9WZnBMQlBQZSs1ZFhBM1VEUUxXU05GYVRkVm9BWURvVnppOXl5?=
 =?utf-8?B?OWpDVllNcjRnbDkrNEMyRUd4dDZDOVY2L2JyUzliUkk0N0tPRkhQdjhBaUFR?=
 =?utf-8?B?bUFIQmFiZXAvdHRMRm9CSlF4K3RCR08ydXpsdVN5NnZZUEdzbUZLdy9kcUFS?=
 =?utf-8?B?UlVvZmNuSFFQckxEL1hubyt6bUE4VFZocnlhcHp3akVlTE9VUm9mMktzS3V3?=
 =?utf-8?B?bVh0NFVkZW8wRTM0TlluVEVmcW5PbWlDTzJiWHAyMHZkTDAxa2dDYXl6WEFW?=
 =?utf-8?B?c3cvdndBTVJya1FOeGZwMnNmWjM5UlFHYWo0UkJ5WkRVbXZzMGJjcHc0Y2Fq?=
 =?utf-8?B?VkprZ3F3L2dJZGR1aEg1QlRaemZVQVozNWUvaW1CVTIxWGFuQ2FSUnZURVBa?=
 =?utf-8?B?MW9WWTY4UzRqbmFnSWwrM1grekpPMWJTQjhFeGUxK2ZIL2NaZ0tyZC9UTGIr?=
 =?utf-8?B?YzBBNXZEK3BPOEJnWFdXMGE2eU1vK1pZTVlwWHFDcWhzK3BWSVQvU1M3SDlG?=
 =?utf-8?B?ZnJEMS9ER0x0czJzRnUrUDYyb3ZXSE13S3RuaHpuRWxJNjdtMzd4TDU2eTB4?=
 =?utf-8?B?N3hEdHRXQzBmQ3EyajdwdTVXK0M2dlA2YndJU3lrSEtJVG96Z1B0eHpSY2V5?=
 =?utf-8?B?VGZyZGs1amJDTDNmeWRpQ2gyc0lLREtiZkl5UFovUWtXUzJoaHMyLytNMjA3?=
 =?utf-8?B?VkpnU054dWdmbzNFd1FPUWNSd3NvV3ZIQkFKelJHV2tOUUdNdG9ZenBjMUtm?=
 =?utf-8?B?SDNqTHhaVSt6WkhsZUFqVzRxeTJRMXlJTjJSV2ZpbDZXVnBxTzQ0TXBDamcy?=
 =?utf-8?B?d2hRS0t2Sk1Ucmp0K1lGQ0sybTR0Ujk2anhWcWxpMXZHTmp3VnZ4TkltSFEr?=
 =?utf-8?B?bjRtQlZHa0ZmVVpmVWc3dWhtUzlsZjJUc0g5N2Z0YVVEbDI4RHArTjVkSkkr?=
 =?utf-8?B?ZTJsSXhsODdvVGI5bHlvRHl3bWtvVDNUWFhHcTVmTDY1UnFhU1pnRVA4Sjcz?=
 =?utf-8?B?WHY4VnhTcjRZbGV3MXg2WXhsbkpOUkZSMXVocWFLc2YwQlVMV0dNMzZSaGFu?=
 =?utf-8?B?VWFIbzdyaFlSZlVaL0FRWW1tNFRBeENIMkl1QU5OS3krZWN0elpsZ01iNGpV?=
 =?utf-8?B?QUNWUmdMbUI4c2lxRUIzMmNGNEd4Vnk5eWZVTTdZdGVLdmVtcHN3MkZoU3lG?=
 =?utf-8?B?MzJzMVhxbHFCUVpCNE9RcHR0N2ptT3VhMFd3Nm1Zc01JU2JpYTdWVjBTUGlU?=
 =?utf-8?B?aWR3UlVhaGtvdHlVWlQ0NitRdVpNQ095UTV5NTRxN2djcUFkWC9xWGR3ek5w?=
 =?utf-8?B?STdNeEpmbXA4Y09VUXQreUttTmhrSVBLc1hjTFVvaU9WRVoyNFdhSnI4ZGRF?=
 =?utf-8?B?Y2Z2QUdiVkEwZGpmV1RMb0Y5V0Y2V3pFNTJwUDQ1TEx3TTJtQkJBalBLSGhr?=
 =?utf-8?B?RS85QzJzTWRFdG1Jem43RXh2ZW5sa2VnaFNQVkJzbUhnQWQySm5JOUNRbkM3?=
 =?utf-8?Q?Gp7bWWP4UtYATwXs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CADAFC466DDD6E48A9CBFE238B2D3951@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 443ff209-f5b3-4c12-31db-08deb4c9384f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 10:35:45.9121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwEpYF6/E+k4OwyerXr2HVSG+Y/lKNCRhnemro4kHZhRpzYmFBtptYUZDm7MH6VS9HtkP+3SEEKr8ZJ08coBozTBFruxrnkLB5ysjFR2x8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7077
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

VGhhbmtzIGZvciBxdWljayB0ZXN0IEZhYmlvIQ0KDQpPbiBGcmksIDIwMjYtMDUtMTUgYXQgMTA6
NTQgLTAzMDAsIEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+IE9uIEZyaSwgTWF5IDEsIDIwMjYgYXQg
MTo1MuKAr1BNIEEuIFN2ZXJkbGluDQo+IDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+
IHdyb3RlOg0KPiA+IA0KPiA+IEZyb206IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2
ZXJkbGluQHNpZW1lbnMuY29tPg0KPiA+IA0KPiA+IFdoZW4gY29tbWl0IDFkNzk5M2QxZDBlZg0K
PiA+ICgiY2xrOiBQb3J0IExpbnV4IGNvbW1vbiBjbG9jayBmcmFtZXdvcmsgW0NDRl0gZm9yIGlt
eDZxIHRvIFUtYm9vdCAodGFnOiB2NS4xLjEyKSIpDQo+ID4gaW50cm9kdWNlZCB0aGUgcGFydHMg
b2YgTGludXggQ29tbW9uIENsb2NrIEZyYW1ld29yaywgaXQgd2FzIGRvbmUgZm9yIGkuTVg2DQo+
ID4gb25seSBhbmQgZXZlbiBoYWQgImRlcGVuZHMgb24gU1BMX0NMS19JTVg2USIgY29uZGl0aW9u
cy4gU2luY2UgY29tbWl0DQo+ID4gY2NhYjA2Njg5YWEyICgiY2xrOiBpbXg6IGV4cG9zZSBDQ0Yg
ZW50cnkgZm9yIGFsbCIpIHRoZSBmcmFtZXdvcmsgY2FuIGJlDQo+ID4gcmUtdXNlZCB3aXRoIFNv
Q3Mgb2Ygb3RoZXIgdmVuZG9ycyAoc2F5LCBUSSksIGJ1dCBOWFAgU29DLXNwZWNpZmljIGNvZGUg
aXMNCj4gPiBzdGlsbCBiZWluZyBidWlsZC4gSXMgaXMgZXNwZWNpYWxseSBwcm9ibGVtYXRpYyBm
b3Igc2l6ZS1jb25zdHJhaW5lZCBTUEwNCj4gPiBpbWFnZXMgb24gVEkgQU02MnguDQo+ID4gDQo+
ID4gTWFrZSB0aGUgYnVpbGQgb2YgdGhlIGkuTVg2L1JUeHh4eCBjb2RlIG5vdCBvbmx5IGRlcGVu
ZGVudCBvbg0KPiA+IENPTkZJR18kKFBIQVNFXylDTEtfQ0NGLCBidXQgYWxzbyBvbiB0aGUgY29y
cmVzcG9uZGluZyBDT05GSUdfQVJDSF8qDQo+ID4gb3B0aW9ucyB0YWtpbmcgaW50byBhY2NvdW50
IHRoYXQgb25seSB0d28gcGxhdGZvcm1zIHNlZW0gdG8gdXNlIHRoZSBjb2RlIGluDQo+ID4gcXVl
c3Rpb24uDQo+ID4gDQo+ID4gVGhpcyBzYXZlcyAyMjY0IGJ5dGVzIG9uIEFSTSBwbGF0Zm9ybXMg
W3VzaW5nIENDRl0uDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIFN2ZXJkbGlu
IDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+IA0KPiBUaGlzIGJyZWFrcyB0aGUg
YnVpbGQuDQoNCkknbGwgc2VuZCB2MiB3aXRoIGEgYnJvYWRlciBDT05GSUdfTUFDSF9JTVggYXMg
YSBzZWxlY3RvciBpbnN0ZWFkLg0KDQo+IG1ha2UgaW14OG1tLWljb3JlLW14OG1tLWN0b3VjaDJf
ZGVmY29uZmlnDQo+IG1ha2UNCj4gL3Vzci9saWIvZ2NjLWNyb3NzL2FhcmNoNjQtbGludXgtZ251
LzEzLy4uLy4uLy4uLy4uL2FhcmNoNjQtbGludXgtZ251L2Jpbi9sZDoNCj4gL3RtcC9jYzFSYTdB
MC5sdHJhbnM0Lmx0cmFucy5vOiBpbiBmdW5jdGlvbiBgaW14OG1tX2Nsa19wcm9iZSc6DQo+IC9o
b21lL2ZhYmlvL2N1c3RvZGlhbi91LWJvb3QtaW14L2RyaXZlcnMvY2xrL2lteC9jbGsuaDoxMjk6
KC50ZXh0LmlteDhtbV9jbGtfcHJvYmUrMHhiZDApOg0KPiB1bmRlZmluZWQgcmVmZXJlbmNlIHRv
IGBjbGtfcmVnaXN0ZXJfZ2F0ZTInDQo+IC91c3IvbGliL2djYy1jcm9zcy9hYXJjaDY0LWxpbnV4
LWdudS8xMy8uLi8uLi8uLi8uLi9hYXJjaDY0LWxpbnV4LWdudS9iaW4vbGQ6DQo+IC9ob21lL2Zh
YmlvL2N1c3RvZGlhbi91LWJvb3QtaW14L2RyaXZlcnMvY2xrL2lteC9jbGsuaDoxMjk6KC50ZXh0
LmlteDhtbV9jbGtfcHJvYmUrMHhjMTApOg0KPiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBjbGtf
cmVnaXN0ZXJfZ2F0ZTInDQo+IC91c3IvbGliL2djYy1jcm9zcy9hYXJjaDY0LWxpbnV4LWdudS8x
My8uLi8uLi8uLi8uLi9hYXJjaDY0LWxpbnV4LWdudS9iaW4vbGQ6DQo+IC9ob21lL2ZhYmlvL2N1
c3RvZGlhbi91LWJvb3QtaW14L2RyaXZlcnMvY2xrL2lteC9jbGsuaDoxMjk6KC50ZXh0LmlteDht
bV9jbGtfcHJvYmUrMHhjNTApOg0KPiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBjbGtfcmVnaXN0
ZXJfZ2F0ZTInDQo+IC91c3IvbGliL2djYy1jcm9zcy9hYXJjaDY0LWxpbnV4LWdudS8xMy8uLi8u
Li8uLi8uLi9hYXJjaDY0LWxpbnV4LWdudS9iaW4vbGQ6DQo+IC9ob21lL2ZhYmlvL2N1c3RvZGlh
bi91LWJvb3QtaW14L2RyaXZlcnMvY2xrL2lteC9jbGsuaDoxMjk6KC50ZXh0LmlteDhtbV9jbGtf
cHJvYmUrMHhjOTApOg0KPiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBjbGtfcmVnaXN0ZXJfZ2F0
ZTInDQo+IC91c3IvbGliL2djYy1jcm9zcy9hYXJjaDY0LWxpbnV4LWdudS8xMy8uLi8uLi8uLi8u
Li9hYXJjaDY0LWxpbnV4LWdudS9iaW4vbGQ6DQo+IC9ob21lL2ZhYmlvL2N1c3RvZGlhbi91LWJv
b3QtaW14L2RyaXZlcnMvY2xrL2lteC9jbGsuaDoxMjk6KC50ZXh0LmlteDhtbV9jbGtfcHJvYmUr
MHhkYjgpOg0KPiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBjbGtfcmVnaXN0ZXJfZ2F0ZTInDQo+
IC91c3IvbGliL2djYy1jcm9zcy9hYXJjaDY0LWxpbnV4LWdudS8xMy8uLi8uLi8uLi8uLi9hYXJj
aDY0LWxpbnV4LWdudS9iaW4vbGQ6DQo+IC90bXAvY2MxUmE3QTAubHRyYW5zNC5sdHJhbnMubzov
aG9tZS9mYWJpby9jdXN0b2RpYW4vdS1ib290LWlteC9kcml2ZXJzL2Nsay9pbXgvY2xrLmg6MTI5
Og0KPiBtb3JlIHVuZGVmaW5lZCByZWZlcmVuY2VzIHRvIGBjbGtfcmVnaXN0ZXJfZ2F0ZTInIGZv
bGxvdw0KPiBjb2xsZWN0MjogZmF0YWwgZXJyb3I6IGxkIHRlcm1pbmF0ZWQgd2l0aCBzaWduYWwg
MTEgW1NlZ21lbnRhdGlvbg0KPiBmYXVsdF0sIGNvcmUgZHVtcGVkDQo+IGNvbXBpbGF0aW9uIHRl
cm1pbmF0ZWQuDQo+IG1ha2U6ICoqKiBbTWFrZWZpbGU6MjEwOTogdS1ib290XSBFcnJvciAxDQo+
IG1ha2U6ICoqKiBEZWxldGluZyBmaWxlICd1LWJvb3QnDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJk
bGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
