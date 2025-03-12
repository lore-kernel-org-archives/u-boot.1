Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C52C282EC
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 02:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA95180F92;
	Wed, 12 Mar 2025 03:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="BlntuAPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27F2180F9C; Wed, 12 Mar 2025 03:06:30 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA73C801FB
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 03:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2suQBLlSLIXSyMLd72zYaeSk2IZBs2ezYGojJyUgxQsUet/0dalB1niqvoTsBIfbK2ytuSK+N+SKjx4xtQFWDaN7sIZdKXiyOGw62IY5xCjqwKyZub1L7kXhdS42jHVjlPqDAm8grH/UGn5LKQflHLqoRiG6DQybUTU9s+0pjYZ1ToCfv7lviTnmEFgmMUCRQBgLguftCY5DDDjZfhSIoqDx2mM7ZIayQsmDkZuQJk1Y5V2yT0e/cnhKh3D6kZoMmzMa9bwDkSBfoETOG6Q4ODE1GKcE33o063MTnE5J6f/eK0uvoW1lGsbogJpegwUh8J5pGfDn5cJhvH1KMUOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mtgFCcWhgVyBhA/RcGoQPK1QDVo6tfUjH/k0QxGMFk=;
 b=f7Xr46e2ZFEnfNwXXLpa1OyPuEQKJrKy+n7ad3UFcEHO/LatVkDJBRootcDKD2lK537rG2dw383efhGRDTQOh2DMkRCFhMJMLO6uMBDP+4oMqN0WcFRxM1gkztOKNMTUCkl+4+ay9buCDZy3jevQ6RJqWilRwTmUkOx4+A1BR1q8WBVywMtEwkDeZEP0sJU978zfJtqzwIY0BPSbnMhFCdcNbUbhlRekO7amcNI7BShpOvyH0ZbVK1HV7SlWxC2buam++j3jUjAzZ6biSZQRgITUTmazRz5HBSPPMV7LLx6AoHIc3WgKy3MhWsKV/zC2okCDmeJloYQMsDMpe411YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mtgFCcWhgVyBhA/RcGoQPK1QDVo6tfUjH/k0QxGMFk=;
 b=BlntuAPPh2yOd2vl6Mcjh73fNTciIGvQVpGRzzT9snXLdd1WlutIkOliF7kEwOE3ACUaF/3DI+fuTsmyfFE1ZDSsA2Hzw5fSfZDcISGKROllq1bnIbDAs2iBwFOF7lVlCjYqyUpf+invX3QbHfbq0c/T918G+TBqftj68XEo5MPL800e0zbGhS0z/cPfjt9I+UhxUQiQMKNrQ01UuD7i5Ew8yHzy5bfAGJVYTtWZOaXQXKByHd2IW1tdMT59RP2bw6CI2/iQ5fveLVeU9hEYApm6VVioVY5FMLefbLB/LCvoqBRaPFqoaKbTKkUogpE3TGgVXYj3n01iaHMsSGaVbg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10886.eurprd04.prod.outlook.com (2603:10a6:10:580::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Wed, 12 Mar
 2025 02:06:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 02:06:25 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Adam Ford <aford173@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "aford@beaconembedded.com" <aford@beaconembedded.com>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Peter Robinson
 <pbrobinson@gmail.com>
Subject: RE: [PATCH V2 02/10] clk: imx6q: Register UART clocks
Thread-Topic: [PATCH V2 02/10] clk: imx6q: Register UART clocks
Thread-Index: AQHbkuYl+AvxIkVSlEuoMc3WAtQxn7NuwMWg
Date: Wed, 12 Mar 2025 02:06:25 +0000
Message-ID: <PAXPR04MB84599360CA7FD2E5E707538388D02@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250312003041.110023-1-aford173@gmail.com>
 <20250312003041.110023-3-aford173@gmail.com>
In-Reply-To: <20250312003041.110023-3-aford173@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU4PR04MB10886:EE_
x-ms-office365-filtering-correlation-id: 6cbb03ac-acf3-4ed3-2f12-08dd610a7e7a
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?kW1c7v2JlyIrBG5xUpvDonZAlB6Ciw4HEynZsaKPis6bc0TrYvXSM7er+VW6?=
 =?us-ascii?Q?cOA/xFkYtVUmO4ptAm/aNrWvRJPeMk7hiKOee/TEGAkpUjs1D8JakKBY2fVX?=
 =?us-ascii?Q?gLDEPsI0dEio6tPfe9ptN6Cq3jhKrv3rSthbUlJeBiU410SezzZkvJO/GYFv?=
 =?us-ascii?Q?u4kZ755QPzqiwD5aryPFDsEVbYZZRaIYszYXL42Bu5mWxW1e+RjXiMODJnB8?=
 =?us-ascii?Q?2EVHIBJ4XJZzfP8WjUTd0lfIU9ho3mgQfvMhsOBXlgYxj095OivJ6hIsmr3K?=
 =?us-ascii?Q?f1UINJDttHPWYe2f38wCvr/09d/OrfYmsNoei38EF5csK2jUeqKvTs3fQe6d?=
 =?us-ascii?Q?tisNjscmqmU8VWcO3qE/Mf0S7EH1JQ4OOIHgSqneUboTBrY2VgJ0SVMB4cHb?=
 =?us-ascii?Q?aRg8pZCkZhio7NM55x+Ik2kwedsvJ7Xq9G43hZ+Y7D8lgcADA3P/yQOw9wGi?=
 =?us-ascii?Q?ATepsdro5G2hCNR50SYwHfNGmHdZHWKzw9e9YL5Pv8yBFJ0Rc4JJCYg73udC?=
 =?us-ascii?Q?WQZc2is2mJibsH1gm0IACEYIf3sb3YQ3bRyGZWQtK2EnAu8rZqQMx8NrXpvj?=
 =?us-ascii?Q?Mn57HCxpoJicoZOEhaVzL0YJJkVKflpMxQ/FtayKeY2MRx0iS4rTQbwWRiRC?=
 =?us-ascii?Q?v0suvvaaI6XIb33TwlwUOq+7vyXa0lMfsEOXikGW+Qtoxlpz+8J4BaaQZM66?=
 =?us-ascii?Q?BscBchKosJh4nRrUuo1ti/URzSdHJTQ7s3zhunQKg6hILxNIfhh3uYm50HUz?=
 =?us-ascii?Q?V+GqcOcky2P5D7rRbu8kxy1jz0affFkAu08oOOF5K7SHLTCtsO3YK3/OIiLB?=
 =?us-ascii?Q?NAGnGqHK6VEoJJ93lF4COgl3dCkBPeezLxtg4lmFp9rkG5CFgp9+7ba+dT2g?=
 =?us-ascii?Q?nReGJXEUv0EU1aNjQ2YW9q4G6OTY/COzGDZiEGAl3B1cKDwcYWUIcupfzHIy?=
 =?us-ascii?Q?c7bB/I9dVabDI9gZv0+I154pYjQMDSOY6mOgSOVw2XNzIdwhrC4jPYVC/3SQ?=
 =?us-ascii?Q?7bs6ATuh986giGmvUYBWt4erwFk/uuUcXnB2oGassoUXa9ibXXud/S/803O3?=
 =?us-ascii?Q?ySQKxnXpJPulc0kaFJLHuKIH8hfwZj2HDZ0hnS768mA8G7OLBrXlUbW4B2gn?=
 =?us-ascii?Q?+8OwUPl/O8eCTDlDm+0dfAxytYdH0zbMbEOMQrfhHJVNNDviXn2v3lsGgBaX?=
 =?us-ascii?Q?Z+RR+vUdFGa+sBhloPscBqqw0yCwr8ptrcQkGTdbb/hsnePLfNC+ZZnEMbQv?=
 =?us-ascii?Q?keue7N6HseHYqfWdflvX+CYDJLFHVeQsS4soi/gb0uJqDioMMVaLUp6hpIuj?=
 =?us-ascii?Q?t+DWxtWiVRJy2kSHVA27Zf2y3azT88krRyzzeve/WBAUJoOON9oC7QdNh1NS?=
 =?us-ascii?Q?10yk50wr41cqXCMrfJPIvOsq6HQhORt3bxlFDKN/us9MgKKqdqJz6w65d30u?=
 =?us-ascii?Q?2KdLtADgHtmao7lPvggH4Wj0UJOJq9tG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uGZdv+P52dd3uLMzntErjvsTsrJsLD7V5UGlyASSoRpOMLT4L3HMrjJcvQJK?=
 =?us-ascii?Q?PkHh/SBoT03b9YWEUo+t6t6B5RT1tSq+H5fBdTZKgGTQ2A53V3vRTm3ZwBcm?=
 =?us-ascii?Q?mb6X7tERVzeJpp6D2gTwV64UgSAUXpS4xy0AJgIJwBsNJ/i0N0/YGL+g0aG/?=
 =?us-ascii?Q?M0ROTvmNWTSEkn51oGaHyJOGxQ0lo7U9Eq8ddm3TQDXbRi4Zw1E1NRemmet3?=
 =?us-ascii?Q?BrUSH6xqjoCT+JggEMQuMg4BoGB9rqhSA8vU/gXwigg8XypAxmqY4lcLgpGX?=
 =?us-ascii?Q?mXnnAFXNKgiDysIl/YMh8kUOjdfT0UboBnDkcX8t7Rch8veLq93ehAU6Pbsp?=
 =?us-ascii?Q?RiQk1AURUzGjl6gYEvPhZLfP3Wpc7Yc1ND3ypTAMem/utRXG5rq7kRsT7KSe?=
 =?us-ascii?Q?DgbYsgzYNeQGLLpDEUcK3m7ElzjaUsr8uNIB83P13RA88eAr9PUCOY5Ix4C2?=
 =?us-ascii?Q?CYk49Lrun0oYFDyf/1xvdfyU+6q55u5kQgff1dx/9hryR2dgasi++ZVIGzxT?=
 =?us-ascii?Q?PHhTt5/8rdQ7mJcOckfVEc+Q2kDwqgoOVVAvP5YOsEGV1aV1garuHV7BM0di?=
 =?us-ascii?Q?y9ziNL2F8oC/RtXfRJ6s0ul9/slHx2/wwVUOsBHKAiISFSjuNXg76QO4tr6J?=
 =?us-ascii?Q?HpMIS/wxR/XaTKzPZNajkLJZ26kCDuuR3CR1U0ux+pYmlblvYNQYcTtQg9DM?=
 =?us-ascii?Q?o/kcc2Q9Fz5X41uVvk5aszp6JnGs5yUIC5un+s06MGavIsJbAW1HgwAqHyf3?=
 =?us-ascii?Q?jSvB5QRwNGSXdVOEaHEjhVc1aNfwDkRhO5TLs2CHNv78g5fF4fjsiBZNKVwO?=
 =?us-ascii?Q?Q0qyAd/euCsu9Dm/QmiVsnbzLnJNhJ/OIHm+XzNnoL2b051mBjSCO87GjGbq?=
 =?us-ascii?Q?GQV+tGHGQlwaUxZzVOHVa/81RJVpu6m/XqANUheT4WBc7kkrvqjO5kBVAGrY?=
 =?us-ascii?Q?z4ktE5uIW+Iehnxc57XMLV9mZc32poz9vBPkWmTA4vUcB/wEv/QeRhJx80qW?=
 =?us-ascii?Q?5ypn1xSe8zon11ddrWPx3n7j+An/QQU12HSRlePJf8v5RftQ2Y3Cnz63YXpb?=
 =?us-ascii?Q?q6EFSExcYSMOZ46ngs6veGmoPckKu+kMYUleloNoZy6Qh+AFWBAEmNM66/yy?=
 =?us-ascii?Q?7R74akvRu1IJPA6KLF5W/sU6Un697M+ww/0sedOwTB1QZs2my3ihlgNQsSvN?=
 =?us-ascii?Q?VNkJ4zhVyZmLC+sYfDC+dicHlWQ2Iv7RajqAKcP2mbKrQDK3SxYVzGbVASjs?=
 =?us-ascii?Q?xq6NgrAnqeH5+EaoRpQKOkjrHmybOBOigxwL3460sjew9j1XlquRqJb0PNp2?=
 =?us-ascii?Q?6Ue5nOtQXus9lsp6EeEQjgS00Pb76pc3CREgdEvZeRIk7FA6FkD59XIH/oxQ?=
 =?us-ascii?Q?H22tunjxnLTSji7u0q3uogzYGYASjKr2tUBMLaAVh31+dAsaU7xPa+1rLcwh?=
 =?us-ascii?Q?eTnRTJyH4Qtlxk2mHHG19SLLb40Zj3Y0J1IYbLegUFothDYdSucghlATMQUG?=
 =?us-ascii?Q?Rx/9yA7qnigxlKvXvv0shw8Fo0fvtOA6POUDfu4NUcrPmG/IyTSJ8bgbBMNE?=
 =?us-ascii?Q?lgg7AOXdQlp0lU2E98w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbb03ac-acf3-4ed3-2f12-08dd610a7e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 02:06:25.5712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHIOnw2CXLc4UGu5brv2vHpP51J3EO0Cc2i0bwRXWJev7gQowray3uHusaZ1QOCl3Z1aPK++yTr7dxgPqHYNNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10886
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

> Subject: [PATCH V2 02/10] clk: imx6q: Register UART clocks
>=20
> In order to use the driver model and clock system to enable UART
> clocks from the serial driver, it's necessary to register the UART clocks=
.
> With the helper function to check for imx6qp vs other variants, the
> UART can register for both scenarios.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
