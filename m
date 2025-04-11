Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9F4C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 13:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 229C48403E;
	Fri, 11 Apr 2025 15:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="HM1PGLoR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E083B83EC9; Fri, 11 Apr 2025 09:00:23 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF7583EBA
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 09:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ls240+I2tAak2yX1E1h9A9Cr6tuS0FFk+zXgtvlpXzpvZ6T2XvhAJCzTR4Bfa7TOvCFCICRnYrGyfNORcZmxba0xlyx6qBxQMgmv5q7Zgeep9lIxC43Bvmaw+p2X+wTdBRTIHlPECz1aLeAoFCudPhReNYsmxaO8DiY6UN8j63MKzjH3byLKZ8XvAbPn/jBTumLgbjaUkhLcQdQMzjpQUZkCZJSQVJuieepVeIBD5z+al7qT4YvP7C++i7daV0KRWCnkciaUbv9GULL5qya5qUoD2ijuDAMarvx/C4G044nFLrrc5Wkm1AYG49b+bIxgIUsJEGF7/gxsamaqicnX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWB4Wfn6wHWMQAlR5ISk+jYDHOkVQRlf5zZTeahk+g4=;
 b=A8jC5wsRpJVD1E8jaVqXP808rn+WgiDarMzKN+nbrFZftN8UkMZTm+7U9Cj755XdsfecHNS17hkNEL0ovzPPqzkSER4AinSqzxdzJIGL/++/UPPdI5AKcyJ6TTQAGl3q1vqcQmdnqv3j/uaLXZSdeVwEutqSysVkJ4WXxPlXbFj05epvXMGqXqSSAv5pCmBpxWKzI87rIznVJ1ENSJXKEFW6CDsvMo6BzDyFGNnngaGGiKwSEsmTc7na3vLJBTkrnFKXvu8c0egtVzJHGkkS4G94uNuG5FETX0NIUyV/sb8eKbKyCrAQR5/Ps7iHfxBwAbTAQq4O03tCunCfkvRA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWB4Wfn6wHWMQAlR5ISk+jYDHOkVQRlf5zZTeahk+g4=;
 b=HM1PGLoRkOIwLIE8DElcCYuE4PtPn7r4TE02729yJxuAIkT0aL8IWIwK8hSziRuyZrOT/9pz7fwkLFEc3oiwR/eeI4v4X4YShNFvzEwGbnU+IxPqxOP0Z26hGXgeSrspW31WWj2KFgt62c7W1vK/KmQc/WzwyCFla7Ke3h61OkmsCOFK0LBeky7NTMHeAeAomyUYp9renPjTmWSHfVgRIMGZ1LRYEjla3nKjeoBW50x8vm43gWoswS8UVYDxoD6dbis+3Xm+6gZ7KHS7LPTvnq/CoIfdtyhsm9yQfzF/uPq1vUHT0EdJ6zYnW7CZgOw+iJngXGehxTW9CIDBEb1gfQ==
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by PH0PR03MB6336.namprd03.prod.outlook.com (2603:10b6:510:bf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 07:00:17 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8583.041; Fri, 11 Apr 2025
 07:00:17 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>, "Tang, Sieu Mun" <sieu.mun.tang@altera.com>
Subject: RE: [resend v3 00/12] Add Synopsys MIPI I3C Driver support
Thread-Topic: [resend v3 00/12] Add Synopsys MIPI I3C Driver support
Thread-Index: AQHbnJhPL6oic8rJyUK393me9B/PZbOZcsMwgAB4nYCABDovUA==
Date: Fri, 11 Apr 2025 07:00:16 +0000
Message-ID: <SA1PR03MB637095CF17776E7274561E5FF7B62@SA1PR03MB6370.namprd03.prod.outlook.com>
References: <20250324083704.26259-1-dinesh.maniyam@altera.com>
 <SA1PR03MB6370C3D360FC1E92B4766F3CF7B52@SA1PR03MB6370.namprd03.prod.outlook.com>
 <20250408142657.GX5495@bill-the-cat>
In-Reply-To: <20250408142657.GX5495@bill-the-cat>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR03MB6370:EE_|PH0PR03MB6336:EE_
x-ms-office365-filtering-correlation-id: ff7cab5f-c1b0-4a25-3675-08dd78c683f8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?sNm8hFRtaKQi7+7DuKLuPW5JxS8gg2Ke6Sf3TP49zNbEpYptNsnrF1Fa41ip?=
 =?us-ascii?Q?o/jbPnZrU9fKfx87CAh+LEPM2NAbH19h7gqQQwhMuxBYS/Mcb8xlfSmGbkmB?=
 =?us-ascii?Q?jm8/pl/BhKFQzPqaikJ1dxmn4yGLLDcCt4hDG84t9yxPIKHDDKlyyO3Gv/uB?=
 =?us-ascii?Q?9NLceTQ8RJPJ6Accd8mpxR/94i0n+qKGzZzhq5zJC8dIO0OO6+J8qfWnAP/Z?=
 =?us-ascii?Q?PTIuL8PJ7TlZUAuERxNmm9Xor3NlwMXKbBjirROXKhWf9kJ2hkACSqk1kGNs?=
 =?us-ascii?Q?rBXvDGkIRXVH3lVK3XQ8oygTi4WB8kQmLCiWpvap1X6Fu2kjvsjXbbiH1tsP?=
 =?us-ascii?Q?1oF0+0xBqbuwotbKdLzcuScKtgZ855P+4IHE5jCCB/D6EwUMgPXHvQ39D9GV?=
 =?us-ascii?Q?hIv0a+lT3ViQdVwtprYKRJo6yuXRVZt5cqZVJ9ER8bRuLq95xkqxqyNmRDYm?=
 =?us-ascii?Q?Vj3UD7pJpZZC3Nx6u7C4Xd/X/zLyl1lsoNAvwQ0+3pdc+fjf/KcwB9lNWuyu?=
 =?us-ascii?Q?jEu5Im8SEcW4g/1eZDpNI/P211yurGBmHLNDG7V2rHbaU46tniZuMwFZZZtd?=
 =?us-ascii?Q?wGDVcMkL3rMXOMYrZoKXDZOSwhECT+mBZ7w6XK8CWIk8ocl1i29adEVqXfUP?=
 =?us-ascii?Q?uj6eLgVAxTiY3zGIw+D8Cg73QY0h2OzOruL4cMXRvDe3RCwNQjE2SytymCNw?=
 =?us-ascii?Q?2D/9AhofZV1EENKCNlutnhfuN5fs3knHN4BNNhghqRDReE7reLkpJauOPoC/?=
 =?us-ascii?Q?U+uXQ8ToOATO/UWShbrR6i7RZKO3iYnVL3U5QYaUmnCbLpV4rvxA6N393cGB?=
 =?us-ascii?Q?CaMWuHmJ3tpu1I+HwfMpZJLCJkCMVIQyNTyrQkv07oEUZvmPNgFSWrkTNmiq?=
 =?us-ascii?Q?CANRJo9xmhwHnAvr+mTmf4euiEzkVXYjqEX8ZTBCaGWnvGT0ValHGn7XHSNM?=
 =?us-ascii?Q?tkE0UygBOqV2Wkj/YyQcOLuBwNj1q8Wn+jNsCrJInb37txbrnNwnitCNFQ0W?=
 =?us-ascii?Q?ITJma8ufA6w4Q96ScyDmVN69JC7d1JlurB9iVmdUXbEnIikNJ8uUr4vmMQB3?=
 =?us-ascii?Q?p+Ofh3tw/qxpM6P6J8i59F63rUJFVK1LmAJOpDD0XVhsRqwRhp11mwN/4pAe?=
 =?us-ascii?Q?04YK3Bd6DxCkmiMP2B1KGfW+3juuJfBL2ywzyGo0KszjdYOhUpOkEsjxFPc+?=
 =?us-ascii?Q?CFnjaJom2EHQvyzz6qH4Ocz46IMQsVtuY2virmz1apJ/O8fz/g5NXQEGQ/zy?=
 =?us-ascii?Q?rGCA+GMuLE9NyItBep/LrWeha62oJ8OLFm1UmH9mGzcB9Q5BpLjB4W+GUnxE?=
 =?us-ascii?Q?ay5KzCuJmZwb7U2IHsX39nJXHezEDl+lIJR5BCQLRtvnDpgN5KBWdfBhKvd9?=
 =?us-ascii?Q?3rxqCNNO25vKVpWhcZ3NVEYckik0Svozzy5d4ce0jexHdYJiX7TXdEF/YhUl?=
 =?us-ascii?Q?zXXWD9rRqQ8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Szb+7b4eA8j6AG9vQ38wRFNhxULcSrCz9PdOXKWvIrcKzNjjr48bQXF3ChXQ?=
 =?us-ascii?Q?I5CIEGEqvwyt4O140ubYUmWY9SyQJy4pFjUS7/8/LqUUO9GmyuUc0T4HALq0?=
 =?us-ascii?Q?0vmeeJUcZe86qRdhYrvAxLeukOQZ8N7PFlclDvukkyn9+YqKRSEPU/lSEklL?=
 =?us-ascii?Q?RV9W6Xnmy5ftvRjaoCllSD496Xd5jeDUjIGDf+9buEuCT3vKsXaQQC23vjvV?=
 =?us-ascii?Q?FElozgmLbo5V4LzY1Ho8ahYBF94IBn/b9yisB6/IJH1Nnq4iW3ShcKB3joWp?=
 =?us-ascii?Q?dPQvg/TR54PGwjshVELUTH4PZ7w51lDp+EZO3BXHAUv2eno1yq9Ci33azjao?=
 =?us-ascii?Q?q2beJib5kzJCbrIyVp/siHQ5DGn4PMVXA7t1T3VEvcK6GU9wrFYwobWxyrlo?=
 =?us-ascii?Q?oe/Qk+7SICGtOrh/NaC4zZwwoEntxCsfkBu4g41K58iYFeFX0/v5+vMCeGWD?=
 =?us-ascii?Q?hJGOD5N1aBpBNIcgyhBPtXGrm+xQll/otDxAh5P3xW2dxhAIGYguApnKB1ol?=
 =?us-ascii?Q?fHcSMggcirsFndcXE+59vepoWZN7SG2O7/KzqwHCTFEa4MvDVDMAfdl9bW44?=
 =?us-ascii?Q?kA/mNFg9p5hwlZkNmUbA4uCtBWKqhSW500mxu9vdONiKWFpJk96JWEbOggFN?=
 =?us-ascii?Q?gSwtVvF2s3sjmuvsjJcYJSAPvKHMFuurawdFegizvpKC4PknsBznoVPW/5n8?=
 =?us-ascii?Q?FE4aN+BwvQp1xGnEoKbfsf2n2kCflydtSOo5d0Owqqti5dChm9RDVQpVlQtC?=
 =?us-ascii?Q?58HdBSOR24U9N6DnCah7SJEEL0OImYG1itmiMNCPkoW2byFAvRDC8bowBzOc?=
 =?us-ascii?Q?TYIqX2HI3mftJ8X2XQJwLFeV61xssHvcqzAjL7ryn73YjNFtmWf3/ESpqFCC?=
 =?us-ascii?Q?wn50PU89ic5YZu6YSCyKZEfIhwqSneo0zK3TNA/pLr24KxtwiQcr4jYTbNgL?=
 =?us-ascii?Q?Un6uSp7GlGVYqWfv+6gFbCtI5LUKoCdNBcPkn35gkfsVKOIQ7/zcAvEUn3h9?=
 =?us-ascii?Q?HjwbZ638f/k5J0Xf4gPU5AeLQ13LXf39SgfXpVvUnYO3DrL8LVUSMFJQO2zq?=
 =?us-ascii?Q?cN/TDkTLDaHZfSdbDneul7+8EHo0UlMkQwy+QxjdEfHTEccdGup4QuhoqR/v?=
 =?us-ascii?Q?EBgkI0vsGaxmT+EgYxaBKIKOBgrLnFx7JGMbUq7Ebu04qtVavmw/uSAcYJFQ?=
 =?us-ascii?Q?qYX5yKP/M8qZDerKcIbc0mApr7fFSx3O6Lk+u6rrbIMcY6au39xCnbY7ah6s?=
 =?us-ascii?Q?ySZokEQYgogaNvHvgjz5enyR0bKVje/4Cr+cLmmcbDHYFjRtXOSKE0KKZelG?=
 =?us-ascii?Q?J0zICQ8CtlelxNLcyBxVWHfX1wnYX0U6aV1J0JGdkN5n8o9f0AX/vMe8mMXv?=
 =?us-ascii?Q?znykKakYMcudTkFLV83etBU+xM0e/tQ6XEpo79wLDIPxFHEV8p8JE4IEsb4q?=
 =?us-ascii?Q?ZkHyUcVPBPiXGELqKNYbi8zO2/c+gIjAkJ5Nn5n+enxqZbiqczmcl9cmqXI9?=
 =?us-ascii?Q?p1r8g/NWk6RrA8SSgVqBNMNu2WWyjKXD/iO5QfqJHeR7SoOnpzxoYmwK35zz?=
 =?us-ascii?Q?m3evxiVe1EjDlWX8aGMBUfD+eeZ7pKLRWkqEPkNfqdktJy3+BBOj0MCHv0ds?=
 =?us-ascii?Q?3hExHcQSRqvbXRak8NsYrwx80qrW0DHeES2gXoYn3t18?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7cab5f-c1b0-4a25-3675-08dd78c683f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 07:00:16.9170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6aghd2atl464lePMvybdbrIFX0FdBfhcqfqHetcqWj6osOLeaNSY9bth/uSRI+tOPk8lVMohiiWEF+cIWtsL89UMu8Xs0gbVC47OM/NnD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6336
X-Mailman-Approved-At: Fri, 11 Apr 2025 15:04:17 +0200
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



> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Tuesday, 8 April 2025 10:27 pm
> To: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> Cc: u-boot@lists.denx.de; Marek <marex@denx.de>; Simon
> <simon.k.r.goldschmidt@gmail.com>; Simon Glass <sjg@chromium.org>; Dario
> Binacchi <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
> Jerome Forissier <jerome.forissier@linaro.org>; Mattijs Korpershoek
> <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
> Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebastian
> Reichel <sebastian.reichel@collabora.com>; Meng, Tingting
> <tingting.meng@altera.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> Hea, Kok Kiang <kok.kiang.hea@altera.com>; Ng, Boon Khai
> <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>; Tang, Sieu Mun <sieu.mun.tang@altera.com>
> Subject: Re: [resend v3 00/12] Add Synopsys MIPI I3C Driver support
>=20
> On Tue, Apr 08, 2025 at 08:14:46AM +0000, Maniyam, Dinesh wrote:
>=20
> > Hi Tom Rini,
> >
> > > -----Original Message-----
> > > From: Maniyam, Dinesh
> > > Sent: Monday, 24 March 2025 4:40 pm
> > > To: u-boot@lists.denx.de
> > > Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> > > Simon Glass <sjg@chromium.org>; Tom Rini <trini@konsulko.com>; Dario
> > > Binacchi <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org>; Heinrich Schuchardt
> > > <xypron.glpk@gmx.de>; Jerome Forissier
> > > <jerome.forissier@linaro.org>; Mattijs Korpershoek
> > > <mkorpershoek@baylibre.com>; Ibai Erkiaga
> > > <ibai.erkiaga-elorza@amd.com>; Michal Simek <michal.simek@amd.com>;
> > > Dmitry Rokosov <ddrokosov@salutedevices.com>; Jonas Karlman
> > > <jonas@kwiboo.se>; Sebastian Reichel
> > > <sebastian.reichel@collabora.com>; Meng, Tingting
> > > <tingting.meng@altera.com>; Chee, Tien Fong
> > > <tien.fong.chee@altera.com>; Hea, Kok Kiang
> > > <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> > > <dinesh.maniyam@altera.com>; Ng, Boon Khai
> > > <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> > > <alif.zakuan.yuslaimi@altera.com>; Zamri, Muhammad Hazim Izzat
> > > <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> > > <jit.loon.lim@altera.com>; Tang, Sieu Mun <sieu.mun.tang@altera.com>
> > > Subject: [resend v3 00/12] Add Synopsys MIPI I3C Driver support
> > >
> > > From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> > >
> > > This patchset add Synopsys MIPI I3C Driver support for Intel Agilex5 =
devices.
> > >
> > > The i3c driver is leveraged from the master/dw-i3c-master.c,
> > > i3c/device.c and i3c/master.c Linux version 6.6.37 LTS And few
> > > header files included to be part of the migration; i3c/internals.h,
> > > include/linux/i3c/ccc.h, include/linux/i3c/device.h and
> include/linux/i3c/master.h.
> > > Additional i3c uclass driver and command files added to support i3c
> > > read and write in U-Boot.
> > >
> > > Patch status:
> > >
> > > Detail changelog can find in commit message.
> > >
> > > v3->v2:
> > > --------
> > > - Squash commit 10 to commit 9
> > > - Resolve index for new files to pass the checkpatch
> > >
> > > Commit: sandbox_defconfig: Enable configs for sandbox i3c
> > > Commit: agilex5_defconfig: Enable i3c configs for agilex5
> > > - use savedefconfig
> > >
> > > drivers: Enabled Kconfig and Makefile for i3c support
> > > - Add maintainer for i3c
> > >
> > > drivers: i3c: Enabled Kconfig and Makefile for DWI3C
> > > - Add empty lines for if/endif
> > >
> > > drivers: i3c: Add i3c sandbox simple test.
> > > - Removed DECLARE_GLOBAL_DATA_PTR
> > >
> > > v1->v2:
> > > --------
> > > Reorder commits.
> > >
> > > Added commits:
> > > - drivers: i3c: Add i3c sandbox simple test.
> > > - test: cmd: Add simple test for i3c
> > > - configs: sandbox_defconfig: Enable configs for sandbox i3c
> > > - configs: agilex5_defconfig: Enable i3c configs for agilex5
> > >
> > > History:
> > > --------
> > > [v1]:
> > > https://patchwork.ozlabs.org/project/uboot/cover/20250218025705.5005
> > > 1-1-
> > > dinesh.maniyam@intel.com/
> > > [v2]:
> > > https://patchwork.ozlabs.org/project/uboot/cover/20250314040902.4362
> > > 1-1-
> > > dinesh.maniyam@altera.com/
> > >
> > > Dinesh Maniyam (12):
> > >   drivers: i3c: Add new i3c uclass id
> > >   drivers: i3c: Add driver for MIPI DWI3C
> > >   drivers: i3c: Add i3c uclass driver.
> > >   drivers: Enabled Kconfig and Makefile for i3c support
> > >   drivers: i3c: Enabled Kconfig and Makefile for DWI3C
> > >   drivers: i3c: Add i3c sandbox simple test.
> > >   drivers: i3c: master: Enable probe i3c without slave device
> > >   i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
> > >   cmd: Add i3c command support.
> > >   test: cmd: Add simple test for i3c
> > >   configs: sandbox_defconfig: Enable configs for sandbox i3c
> > >   configs: agilex5_defconfig: Enable i3c configs for agilex5
> > >
> > >  MAINTAINERS                        |    7 +
> > >  arch/sandbox/dts/test.dts          |    8 +
> > >  cmd/Kconfig                        |    6 +
> > >  cmd/Makefile                       |    1 +
> > >  cmd/i3c.c                          |  193 +++
> > >  configs/sandbox_defconfig          |    4 +
> > >  configs/socfpga_agilex5_defconfig  |    3 +
> > >  doc/usage/cmd/i3c.rst              |   98 ++
> > >  drivers/Kconfig                    |    2 +
> > >  drivers/Makefile                   |    1 +
> > >  drivers/i3c/Kconfig                |   27 +
> > >  drivers/i3c/Makefile               |    5 +
> > >  drivers/i3c/device.c               |  262 ++++
> > >  drivers/i3c/i3c-uclass.c           |   38 +
> > >  drivers/i3c/internals.h            |   26 +
> > >  drivers/i3c/master.c               | 2072 ++++++++++++++++++++++++++=
++
> > >  drivers/i3c/master/Kconfig         |   11 +
> > >  drivers/i3c/master/Makefile        |    3 +
> > >  drivers/i3c/master/dw-i3c-master.c | 1058 ++++++++++++++
> > >  drivers/i3c/sandbox_i3c.c          |   56 +
> > >  include/dm/device.h                |    2 +
> > >  include/dm/uclass-id.h             |    1 +
> > >  include/dw-i3c.h                   |  252 ++++
> > >  include/i3c.h                      |   67 +
> > >  include/linux/i3c/ccc.h            |  385 ++++++
> > >  include/linux/i3c/device.h         |  286 ++++
> > >  include/linux/i3c/master.h         |  698 ++++++++++
> > >  test/cmd/Makefile                  |    1 +
> > >  test/cmd/i3c.c                     |   52 +
> > >  test/dm/Makefile                   |    1 +
> > >  test/dm/i3c.c                      |   34 +
> > >  31 files changed, 5660 insertions(+)  create mode 100644 cmd/i3c.c
> > > create mode 100644 doc/usage/cmd/i3c.rst  create mode 100644
> > > drivers/i3c/Kconfig  create mode 100644 drivers/i3c/Makefile  create
> > > mode
> > > 100644 drivers/i3c/device.c  create mode 100644
> > > drivers/i3c/i3c-uclass.c  create mode 100644 drivers/i3c/internals.h
> > > create mode 100644 drivers/i3c/master.c create mode 100644
> > > drivers/i3c/master/Kconfig  create mode 100644
> > > drivers/i3c/master/Makefile  create mode 100644
> > > drivers/i3c/master/dw-i3c- master.c  create mode 100644
> > > drivers/i3c/sandbox_i3c.c  create mode 100644 include/dw-i3c.h
> > > create mode 100644 include/i3c.h  create mode 100644
> > > include/linux/i3c/ccc.h  create mode 100644
> > > include/linux/i3c/device.h  create mode 100644
> > > include/linux/i3c/master.h  create mode 100644 test/cmd/i3c.c create
> > > mode 100644 test/dm/i3c.c
> > >
> > > --
> > > 2.26.2
> >
> > Please help to review the v3 of the patches.
> > Thanks for your time.
>=20
> Please run this through CI, see
> https://docs.u-boot.org/en/latest/develop/ci_testing.html, as there are b=
oth
> easy and less-easy doc failures, and then compile warnings:
> https://source.denx.de/u-boot/u-boot/-/jobs/1092473
>=20
> --
> Tom

https://github.com/u-boot/u-boot
Cloned the repo, tried to create and push a PR with the solution.
Thought, CI test will be triggered automatically once push the PR.
Since I'm not a maintainer I don't have the write access to push the PR.

Can I have access to push a PR just to trigger the CI test so that I can se=
e the result?
Or any other way to do it?

Dinesh



