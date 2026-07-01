Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDBBC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 02:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9416B84A52;
	Wed,  1 Jul 2026 04:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="WcwtH/va";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE7084B03; Wed,  1 Jul 2026 02:11:42 +0200 (CEST)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24A8084AA2
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 02:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan_chen@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSJtelXg4wxsH4qxqQgGEnElOocqPFMDJKSpryW1UlfMa+19up+olFoyVT6CW5OGGLXwkkaT0xQXI6nMMsLViHf+c04uM8RBuBXVv7cQ088VGU/Xx8Xh9AScZf1ZwT/DH98xDDXI7iEaJj4h+WpgKeulW3hA3QYYT/w7b0Sg6xclpB4YYz0Ua0kc0HDv3IxNlIY4a3Qf/WjdJjDoZ9Q1jGDrSbXbYTD85UyiMbz4u5mFFvtNXkYcuHvop2FAFzcYWcDDaUQgG+AbZJ4TnT7dAwRD93wd+SealqiWhnJ71N7Zz/jQk9jCSuUK5EfK/MNA1O4sxOH05T2B80ypvQPFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3p8m5Jh2FdmYzZl2+jgWYZO00byGWaa9HsbLrhpa2mY=;
 b=w+iNQI4CpsrQh7QjRyINRVJnF7DXyMPQDrzW/p1oCKa7zeclxgTb0SKn+uSZBgMjgLrBAGZ1q10j35FUC9VcNUlXqnRdJTVo6FS3f2prE1GjYZbyo6ZJVoYcrJ2iIpjXYDf1139zWZVqzeOtthGhrAqPna7TD3YZQrqvCFrcAWefIgdBXO6g1UgDE6Pxf9Tyf3DhHcEc5qPafr28YXuuhJ0iC6SG8y3EpZz7tW9fKyi+6ZjD0rt3gIlM8ehcgNr8nkjIrBb1nHQ1URY531rpDhYtVXwOtSfBZwYGzD31f9xm9l3ZcIsV+w9O9OJZaqovWC+6nWCZhj4X/+IMajzjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3p8m5Jh2FdmYzZl2+jgWYZO00byGWaa9HsbLrhpa2mY=;
 b=WcwtH/vaENF0w826fufyHYY+e+GtLq03/f3G1GHZgqPAUATFIbU0DJt06bJ+bjp+I9J8xap1oFBR1Jbp04fzB6pyCuerx2DkjHa/O/0dd+dbB4ZM3AgoitkW7rDj2Sqxe8mHVGM3brAVRfvHuIcmCsGpM7c344b4zYg/MeuQckOXnhKSAMtTh3xvJ/gNxP2VcGs4CCqte0VejPmwN8mwsO5pzPAha+HEaqUS1abAt6SFITfJ9vy2FZL7ofwFoitNSibUpnmK7eHTjnoQyqTLSNmQDhKXrxFFLSPT2/IKwY2N0eUAliUhrrDsS8QHlEw2MNhJvBbtgfpkozFUAdOQTw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYNPR06MB8597.apcprd06.prod.outlook.com (2603:1096:405:3d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 00:11:33 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::43a0:9857:dd1e:76d2]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::43a0:9857:dd1e:76d2%4]) with mapi id 15.21.0159.016; Wed, 1 Jul 2026
 00:11:32 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Tom Rini <trini@konsulko.com>, BMC-SW <BMC-SW@aspeedtech.com>, Joel
 Stanley <joel@jms.id.au>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, ChiaWei Wang
 <chiawei_wang@aspeedtech.com>, Sumit Garg <sumit.garg@kernel.org>, Anshul
 Dalal <anshuld@ti.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Tien Fong Chee
 <tien.fong.chee@altera.com>, Andre Przywara <andre.przywara@arm.com>, Frieder
 Schrempf <frieder.schrempf@kontron.de>, Peng Fan <peng.fan@nxp.com>, Ernest
 Van Hoecke <ernest.vanhoecke@toradex.com>, Brian Sune <briansune@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, David
 Lechner <dlechner@baylibre.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Parth Pancholi <parth.pancholi@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>, Paul
 Kocialkowski <contact@paulk.fr>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Finley Xiao <finley.xiao@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, Kuan-Wei
 Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Philip Molloy
 <philip.molloy@analog.com>
Subject: RE: [PATCH v4 0/6] arm: aspeed: add initial AST2700 SoC support
Thread-Topic: [PATCH v4 0/6] arm: aspeed: add initial AST2700 SoC support
Thread-Index: AQHc+k/lqTfPUiDLnEiY9iw4Z/B5BbZWKZYAgAG90FA=
Date: Wed, 1 Jul 2026 00:11:32 +0000
Message-ID: <TY2PPF5CB9A1BE6963814348BB4A6887039F2F62@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260612-ast2700_clk-v4-0-9bea29cfdc39@aspeedtech.com>
 <178276888626.793204.9603360436084101355.b4-ty@konsulko.com>
In-Reply-To: <178276888626.793204.9603360436084101355.b4-ty@konsulko.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYNPR06MB8597:EE_
x-ms-office365-filtering-correlation-id: 118702e8-e04b-43e1-600c-08ded7054e7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|23010399003|4143699003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: vTpRNzIRL8mR0X26stlrTsef5yNxENxgrBQJIzlvPrm0lJKc+AV39qzQrOP0vsuWmuzKo5JjsDG/cylL8erSXOlkmlf+g2GmbIge50AVXQtd5TFyBa3Kw4A+sN+LPgF2q6bR6RLM2bbhShs+a60MZfsrArg3TXslq0nOz3XIAxkgPLP92SBKqZc32xcCkw2e+rxvCxYDUExBTyis4M72/zuJ+IolU3vSTorhrql/K0ShQ+Oa05pWNUkX10YDF+mWIqdKmR2otygYmxy0vdnpo2WYjml+b1VQ+FQH9ckjkQoaWaS07Nw+mJeLU73vFyzs74Z05WSJSQaGtdkkvgSf4tQc76ES/rsCQlVfdPWhANMBYe4MG0p22x/KOaCsyINFnTv4Kw2flcWhpfI95q44jpKjmpng2+h6DOWtJpDvG1/3wNkzeQR3J/hapTcXTRKEN0xidM3bte42g5Eo65JrkFqiFKu95IqC0My52NRG6r1M+UlizygNhsbvLBm331Z2KjnBIbof0r06gIhGtt/p+6wCbXu2R6sPMt/vRGGTGAsWiHjNAknxMW8zCwGp3jWc55PlTVjK50AQbkHOnrAx2fz5giu/kzI1Vk9u+lQKXT/s8JKvfg6SOKbO5CfmnsPEl9UhUbqwAqGFxFtF7AC2kRTeFZYM+cAAG38jLw5ovCikEbTg/l+hQgMDQH6EzCapNa1avoFcZAFEVw9U3bPbMM8+FJIz7SJ/7EkY2VDhHfw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(4143699003)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk1iZmR2VElvaTBhVXZTdDYvejVjMVE4WWRabVNEQTdGaDR2NXhHLzAwU2tT?=
 =?utf-8?B?dVNJTGdIWGgwNXAvMmR6VnlUc1hlQkNvSzM5dmkrM2xwcHd6ZEI3dU8vbWFE?=
 =?utf-8?B?aytPZ25nWWlhMGtnajVUT1ZTRFFQVGIycmgrNC9RVGtsM1NoWVZoNjcyMEJK?=
 =?utf-8?B?WFhwSWdVQ0xPTllKTGpmVm05ZHQvWm5qVVI1cjl3UkFrdXZBSzczNkZ4K09i?=
 =?utf-8?B?MXhlVG9rM0VhWFZUcTFCTHNFQzlSbFZDUGYwclArTVg2elFWMnN2QzNuek92?=
 =?utf-8?B?MkJtejhPaVFiTml3dDVTS21DRjdOVEVqVTUxOXRHZjcreXQ1SGxRVFJxRDRK?=
 =?utf-8?B?ZDY5T3NaUDE4SHozdGpEaitQQlVGZG44NjA0UDYvQjZCWDV4TWFCOTVUZkwv?=
 =?utf-8?B?SjRDM3N0aWF0SndmR1h1YXdJd3RuYlZFY0w3c0lBR0Y1bmFIY0ZUT1RwenY5?=
 =?utf-8?B?TmNvU05lVjhuZVJlYjVKMDhTRlg0SE1UQVMzRURNOS9ZQWhQK1VGdW9GQXVu?=
 =?utf-8?B?K0FiWCtFL0xDWjFRYkxOOE15UnVFalNyaXJ0NlR2bVV2NkRiaDBSckFkUkc1?=
 =?utf-8?B?MkQ1YjM1aEVKbUlscDc3dGJ0bTJYSmsxeEdKVWlJYzJyTzlJbmlscWx0Rmly?=
 =?utf-8?B?QVVENlBNOUp6ZmlVVFUzMkx2R0xhNWJxZ21xMTlwUi85R2RMcXlEbXdFVnly?=
 =?utf-8?B?MThCZE0zU3RUTmZZTVNFSmV3Y2NvWGFocUY5WDZNb09JYzh4bFRBR1dhT3hF?=
 =?utf-8?B?LzYwNHRGTFZkWk5tVmxsekh3STcwRzd3QitrZWwxTk4wT1dOSDZmdmpaZzRz?=
 =?utf-8?B?VDY4anJrcXBSeUxiSEhheWt2WjFTZXpqTVF4dXNpcmROeTlhYlJSTUgvcE9O?=
 =?utf-8?B?Tjh5M1BUWCtlSGdINXhha1h0MkhnWE8raWI5bXNwOWVhZDZHM3gwQlk4blln?=
 =?utf-8?B?N3BPbmdVY25LQVljV1hTZzFSa1N2K1FCOFlTYnZWaVZ0Uk5UT1FuYmQ2NFBM?=
 =?utf-8?B?dDVYRGsrNHZoL3ErbmdGYk16VUZmVURQNHJPNTc5ZUdlTEJJUzNraW05ZUsr?=
 =?utf-8?B?RXNHZEswZ0ZUbkhEdlQ3S09DUXowUkttZUtMRS9JSk5yRm1ZYzBhdk14djZ2?=
 =?utf-8?B?cTdnSVFraG82by9ZUDhFcElpRCs2Y1lGVnJxd1NNWGZlenRDTm1YbUR1OUNr?=
 =?utf-8?B?UDI3aU13cUFDNGtwTjhWcEdiN0YxaktJREt0TGN6QTdPcVhXVlI0c2tmRWpn?=
 =?utf-8?B?OUZhenBKcDdzdmNudzdxU0cxWnJPTXBwMFlMZ0hBWFJrdm1sK2xQNEM4VW5k?=
 =?utf-8?B?a1hndjMrdk5mRlYveU1jdHR1U1BBWDV3cTdUV1ZoQmpjbHAvdDBYWW5DSUo2?=
 =?utf-8?B?aksvQm83OXc0VFlIdXdCVjR0eTBYSHlnNmJNMk1ReERmM0pyQ3ZaendMR2tw?=
 =?utf-8?B?K2RJR3REbitPSkRiSjVkNlZDQXoyZTJadmYxZzFvVmpnazc1TCtONkRYeDN4?=
 =?utf-8?B?cGdPTVhYVjRhbjlvbmtoTDRnWUw5WTdXamdqYjRTQWxVaG5LdFVhOW40VVdU?=
 =?utf-8?B?TktaSUlYSVhWQTRTc1diYno5cDd3NkViTGwydkdteGNoL2dsY0pJUVhHOFBP?=
 =?utf-8?B?bTExamhPOU90eVhvWE51TC94eDJBLzB2WktHVEJ0RVM5cGNBa2VBaGF5bGFm?=
 =?utf-8?B?aFc1blBkSUNGNlJtTW96bTZVZE0zSDJ2ZXd0S3VzUnkxQlF3UTJzV0VHQVRS?=
 =?utf-8?B?ZXlwZlZTTk9ncnlzVFBqVzZhNG8vMlBlMGhVdC9GTlNVcnVyZmZvTmk3RURZ?=
 =?utf-8?B?ZmJyN1hocE5hNG11eDRENGd6MmxodUdRUVNFZmtUcncxYk5HU2ZQZjMxU3hi?=
 =?utf-8?B?SFZwUExhM2RMRVM2RkZpU1E2YnJ3RGE2RDhMOWwxc0RYM2ROeGo1UGJON25K?=
 =?utf-8?B?OFl4SzVHYk9PRVZrZ3N0L0dFMnhXNFJGUHNZeFh5SGxEQjZ5b3BJMk9JRXNx?=
 =?utf-8?B?N0Vtd2lGYmhqL3E4TFB5cjBKeU5vN1NXQklGRWNaeGt4YS9Lc1NlUjg3d1JP?=
 =?utf-8?B?NW9OVEZOWWFXZXNsaFZnSHhHSFdLVjJhbHhLYUVIMjJkMmlzRldUNmVtZ0ti?=
 =?utf-8?B?Z0Z0elNrc3FtTEVkNU1RcTVITHpxSzV5SVJyRy9vT094VklNdTNXQlNES1p2?=
 =?utf-8?B?ZVVrbHFjclpieEJwR3lCZzh0cHBDNXFGeEpSMnNmRHgzZFRLYjV4U3U0THVw?=
 =?utf-8?B?ZFVvWmNKdE1Dc0F1VU5uVDBPZ1JCQ0UzcVV4enlYeFJvQ3BieUxDNjdhK2hP?=
 =?utf-8?B?QkV2KzQwN1dHQlZBRjg2Ymd1L05YWitmd0RBaklFWmtkbmZoREZOZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fqHTlPVfvSI0p1T9ZGKMIxPUx6kYXgKQ4OFkoBOnMXyS19q4BqZBcx4ORcoysvT4xduglfWSCzMCSg2VDTH+buK1GUsDBFALJ7ft7CaVpPkjJiRT8iciNS2M0psER6NJ+l3OaxvezVPZhhWh51BZVpH7AUU7jmfqQYTh01LpuuF/nDgc+0c8jw7XXgbJq0G86FEKyr2AUh9T+aswfQXR1fhNZ1mdFs4vBj3rwHBQqV6VVsfpl19jhJ2v9pgfDP1szHFT/HM8ptRTwFgcYgRt4tGI9jeT7yw2/37BoXhQ8wN3dy/L0aBdS58pC8KkHD56dGZoNmyKRW0vgG3mHTmSiQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118702e8-e04b-43e1-600c-08ded7054e7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 00:11:32.4578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tk2GMMi5rqM+X4CtBK+fBKPM3uozPJ38bj5JDNAoMTwo5dn8yIHBgoTQ2m+balS3LfKy/hDGY89U6O5byYSI7PDjDDMr5bdDsaWJGHrFhxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8597
X-Mailman-Approved-At: Wed, 01 Jul 2026 04:52:21 +0200
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvNl0gYXJtOiBhc3BlZWQ6IGFkZCBpbml0aWFsIEFT
VDI3MDAgU29DIHN1cHBvcnQNCj4gDQo+IE9uIEZyaSwgMTIgSnVuIDIwMjYgMTc6NDM6MDcgKzA4
MDAsIFJ5YW4gQ2hlbiB3cm90ZToNCj4gDQo+ID4gQVNUMjcwMCBpcyB0aGUgOHRoIGdlbmVyYXRp
b24gb2YgSW50ZWdyYXRlZCBSZW1vdGUgTWFuYWdlbWVudA0KPiA+IFByb2Nlc3NvciBpbnRyb2R1
Y2VkIGJ5IEFTUEVFRCBUZWNobm9sb2d5IEluYy4gSXQgaXMgYSBCb2FyZA0KPiA+IE1hbmFnZW1l
bnQgQ29udHJvbGxlciAoQk1DKSBTb0MgZmFtaWx5IHdpdGggYSBkdWFsLWRpZSBhcmNoaXRlY3R1
cmU6DQo+ID4gU29DMCAoIkNQVSIgZGllIHdpdGggZm91ciBBUk0gQ29ydGV4LUEzNSBhcHBsaWNh
dGlvbiBjb3JlcykgYW5kDQo+ID4gU29DMSAoIklPIiBkaWUgd2l0aCBwZXJpcGhlcmFscykgZWFj
aCBTb0MgaGF2ZSBpdHMgb3duIFNDVSBQTExzLCBjbG9jaw0KPiA+IGRpdmlkZXJzIGFuZCByZXNl
dCBkb21haW5zLg0KPiA+DQo+ID4gWy4uLl0NCj4gDQo+IEFwcGxpZWQgdG8gdS1ib290L25leHQs
IHRoYW5rcyENCkhlbGxvIFRvbSwNCglBcHByZWNpYXRlIHlvdXIgaGVscC4NCj4gDQo+IFsxLzZd
IHNwaTogYXNwZWVkOiBhZGQgQVNUMjcwMCBzdXBwb3J0DQo+ICAgICAgIGNvbW1pdDogM2ZhMWI0
OWM5NDBmZmZhNTU2NjU2MGQ1MTM0Zjc0YjA2MzY0NWI3Yg0KPiBbMi82XSBhcm06IGFzcGVlZDog
YWRkIEFTUEVFRCBBU1QyNzAwIFNvQyBmYW1pbHkgc3VwcG9ydA0KPiAgICAgICBjb21taXQ6IGI2
MmI1NWJhNGIyZDFjYWJkNmJiMDk0MzY4NWMzMTE1ZjZlZThiZDMNCj4gWzMvNl0gYXJtOiBkdHM6
IGFzcGVlZDogQWRkIGluaXRpYWwgQVNUMjd4eCBTb0MgZGV2aWNlIHRyZWUNCj4gICAgICAgY29t
bWl0OiA0MGJmMTQxN2JhYjYzNjMxOTNjMDIxM2FmMDExZWZlYjEwNWFmMmMyDQo+IFs0LzZdIGNs
azogYXN0MjcwMDogYWRkIGNsb2NrIGRyaXZlciBzdXBwb3J0DQo+ICAgICAgIGNvbW1pdDogMDc1
OGZkZGIzNzI5YjhiNGUxMzBmMzU3Y2Y4NjA4YWIxZjRkZWY1Yg0KPiBbNS82XSByZXNldDogYXN0
MjcwMDogYWRkIHJlc2V0IGRyaXZlciBzdXBwb3J0DQo+ICAgICAgIGNvbW1pdDogNmZiNDA4MTJk
ZGI4NDZiMDJkNTg1YzU1ODk1MjQyOTU5Y2JiNjQ5NQ0KPiBbNi82XSByYW06IGFzcGVlZDogYWRk
IFNEUkFNIGNvbnRyb2xsZXIgZHJpdmVyIGZvciBBU1QyNzAwDQo+ICAgICAgIGNvbW1pdDogNGE3
MmZkOWZiMDkxMDk4NTczMDNjYTY0ZmQyNTkwMDllMWQ0YjU1NA0KPiAtLQ0KPiBUb20NCj4gDQoN
Cg==
