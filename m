Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE190D116F1
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 01:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2735983DCB;
	Tue,  2 Dec 2025 02:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ZUzItWNm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82EA883DDD; Tue,  2 Dec 2025 02:49:30 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E98D583DB6
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 02:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdAqnNulNBRAYHxWMERjBLWF0ffyuNCiJ5lYhuiJ5yJyns0EpVy7g2XtoFC6LOwMS+bkNleuUV0ISAzG+QV8k3h0D+/TgsaphCmO2judHBVk+79rlkNhFjAQ0UMqXx/S6zUJG7CB1sSUXX4ZqEUmj8oJktn1DhrCKJCCV1+dlRrTRyY3a9THR2wCOq6AsDsNNQ7CsMzlVerbWuAAlpuJWKjityegHlbuIWSUK5XoOKx2HyifM8O7Dy2PU72WGLPvxCNJy5mQ8vhg/ak59hpk+bSQm5gKNfVzx0qH8nIA8y1JKwE5V+j/3DzA81cFaQFOWODoEqDovbHs4+W7N4Qw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6rb9J8cJjdk5qQWNEgorsVsluo8/fAnKWmv/qrPsr4=;
 b=p1loR0qTwFAaBex5rINbYSWzQJ6lxkomiKYa60zKinwGNgL1e9LqOry1ykUJsu8OpBq4jmkZrYrWjy00lgrxjMm808hws8wiljt/bZ3b7Oxv6kFFvRb/lkPpSgLxlTnT1yy9aic1U88EoDyA8RkcXAVRyCFuQ2vqFckHUeHRa9fElBuTYausdLmh9kXuaRzg2A+wyycNYHd2v+9tCvjGldb0U9TWqZBz10+s9uROyqL0WoS30jCDJ5ZE0pBL1GOrbR5L0J5G7jsibuOsISWmvpAYE3EIm373YqsPR34FA4WhrLrtYhlK4Io3oHOF39rzO5dCGyOj0mzP5fwJBWjgag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6rb9J8cJjdk5qQWNEgorsVsluo8/fAnKWmv/qrPsr4=;
 b=ZUzItWNmnITQeLNOcX4aTw4mKyqLW9MisFgNcfRKSqgEUmZOIvHNOn2C11dHg/fzTFNlBorfo9ObyibpHMjYyL8VsT1s7nKhNAtsBv8YTtAhsrr/Vj9ljHzdTgt1vSE1wzec/FObSMKo4zprwl6QYaXoCkANkoxyUCYSntldfV081tRhaQNu10l+EIBoO0WU6DV4uxtYw+o82BhVPBUq+8XQO/MtF5RcY6LqZJVfGiCHP+80KjaHPVQaptqDgxMpmwsqti+vOPx+oyHi7smuOFqBqxp7aruXutQm6FaRMheK3KgnisJJWYNOU1TtK+4OtoP9PKKuJhRNcJ7vxic8Fw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB6816.eurprd04.prod.outlook.com (2603:10a6:803:12d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 01:49:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 01:49:24 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>, "sbabic@nabladev.com" <sbabic@nabladev.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "davidzangcs@gmail.com"
 <davidzangcs@gmail.com>
Subject: RE: [PATCH v1 1/2] imx8ulp_evk: Move environment variables to .env
 file
Thread-Topic: [PATCH v1 1/2] imx8ulp_evk: Move environment variables to .env
 file
Thread-Index: AQHcYrFcwx9Qnpb/o0yhdlK9QBLjPLUM29+AgAC6V5A=
Date: Tue, 2 Dec 2025 01:49:24 +0000
Message-ID: <PAXPR04MB84593934DDC86F86B14886B588D8A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251201105657.1968244-1-alice.guo@oss.nxp.com>
 <20251201144151.GD303283@bill-the-cat>
In-Reply-To: <20251201144151.GD303283@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB6816:EE_
x-ms-office365-filtering-correlation-id: e070eb35-8f4d-4f98-83d8-08de3145051d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jaUJyx3DpN/hKkwxWKzx236ARkQGCSks3OxjTqewqEJ3VLgQ0P6sMXN2zaZB?=
 =?us-ascii?Q?c0jQhvu2nrKJ6cTNZ2Hh6Wb6Dh7N0/FgPphypfzZfVDpDHQbqaV9WY/wDIb+?=
 =?us-ascii?Q?BVQ7dB2QJ+xzRYDGAG+OYnArcmGQjVG75f1kuAdhLzFoC3zaglGLYfphoq0t?=
 =?us-ascii?Q?u68Vit4Uw+FZ/Di0KaIP9WGccXH4I35hkcy/T0YtsmmGSsd8fgeg50ICnheg?=
 =?us-ascii?Q?FsTXBpcCBSkazvS8YYpBMOAucBY/imkh+gy55igekGNgYdYEo6hS0tJSVR8i?=
 =?us-ascii?Q?RmE9Cuwtf6yPdou4NuW9r/hlvfk5b08i95Brn9q53nOEqxzKaik0Jjso5scr?=
 =?us-ascii?Q?o/WqbBIMbufGjjkCo2bOFuU9fnxGddiwCPgTeAXB0AlYz9IHKo9uuffZCsP8?=
 =?us-ascii?Q?dX1gqVOFQf5/mUf+lvvYrFjY11Q4akb31TcVniuGsI6qyh2Fl7AIyYZEFIFQ?=
 =?us-ascii?Q?rORDNWSKZ0ugnaaIcc22kdIve0d+ec1kli6HDwHVk0xyxIXeBdYFxGlAgqdu?=
 =?us-ascii?Q?4rGCiNa9rcLeHowuiQCSw/sfdhDpPt/ZVvYPdP0qrBiNhkJoJmF7BzBksdDy?=
 =?us-ascii?Q?98M8zgZe04MGBKR3r2zA1sU4JL+tDQcWjRubcNCyQJo/M9DCxdzk1zz1V+b7?=
 =?us-ascii?Q?t7F2Gfv40RlbBwNdxR6Xcvcxdg28m5naTYimMuDG6KLAeivRPwNSK09+wHfg?=
 =?us-ascii?Q?jMm4u6OcW1RflRBKjiF8gwlxtJwoCrUKpc9dyseQerdNmLKWXbYpuk3ElDL2?=
 =?us-ascii?Q?0YWHzCjcmVaAfMl7/7lDmUeomFriHGKlanijty3yMGhNAvWCAqep6zfcPAOO?=
 =?us-ascii?Q?/JShhBHbG1IJ5dr2n7lMXsLxX4jYvJc6wNWa+t5n67vBU3Dib8rIFWwJyPXZ?=
 =?us-ascii?Q?bJs5PrixE2jEFZ0CuNehqN+pIL5AzPa4RUayPtO9XfJemZV2HXiSxObeZaUC?=
 =?us-ascii?Q?vyswAYLi9U/Uvr4sZukpRV3HaNausNqzEwLMgUmcIgDDWaM5DFrHtfveJ4h8?=
 =?us-ascii?Q?g0rtD6AfSeA8Sh6XxMdpOTWx4oZ4DERwDDuZzI3v+T/IrKRX73QoLWozwLPs?=
 =?us-ascii?Q?A42DeTVPLNtlDRTYcPW7JhQkcEU6iQy9rrtynp6jPe3sI7vSzW77I4xNbK/D?=
 =?us-ascii?Q?LvX9jB3Di1h5WVKe3pi87tQAPqkepmzS0j7PK/kaxhBBh20UF8rPIxSOpEVS?=
 =?us-ascii?Q?7DUMon9P6VkXrfvqplnQwuTGrxjtkRwtD7mD4KDqOa9//rkEaBMphhb411gG?=
 =?us-ascii?Q?auFA1SAfLCVSOUfXZpbmCzCCXy+yWBjCTKV7kd8+Wx5zv0/ZwAubZskAd7H+?=
 =?us-ascii?Q?DipnxrGqAQ1a4NcPCajAhLvZLV4vrqwX+e8oGwjefCnPpBYUwhf9KTRRaQZA?=
 =?us-ascii?Q?mVVZ7X/Zsx4EMMNqdNx3bwxaAlUtsMhmETmQotPGaEFuArALTQWtu1OP7T4I?=
 =?us-ascii?Q?CcPd07YQE39Thf8N7hGjXkAV3iJZFHM8iS/haB53FNudsUQQU3PNgfjBboza?=
 =?us-ascii?Q?1WU4Gt9JJVq2BUBh1Rhv3FFgDyCO+jM1Krnz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BziQji6BB/98l30amniWKppaoan+yywUE/o5E9vK0NQZ9gHw3NqBcaJkpnqS?=
 =?us-ascii?Q?lq58MzDsAM7j4j3KiH6d8m6VLVk/gp5AB2CVG6O+q0s6Pp4lRFbrjP2OFO7N?=
 =?us-ascii?Q?M0qlxRhnC82dk05cczI7HQJn4gbVPrLfoJQGUcffS2qZzeLUBa2jh3Wckhdy?=
 =?us-ascii?Q?BhNyMHydjnYaI6Y6+ae26FMNOS0zFQcOjfzaI1S+0ShHbrulVxxOlFVpR9tu?=
 =?us-ascii?Q?mU75tmMVY+1KiXJJxvmqZHCrQhMCKirQ3WHXFxJ7KQQMhK9AsqyjDmXfQjvT?=
 =?us-ascii?Q?Vc7Sgk0Hn984S0TNNhMDCrtDp+vhXexeuANnDDAEsbHuTFC0fCsgqDyBW390?=
 =?us-ascii?Q?iQhPqOWrzao9uQzOqFYLoBjCGLev3VzYUcK8SA7Y+c1o3l7z29ZGKxvlucxe?=
 =?us-ascii?Q?bgHiQ5VUgSaPoRZhKCh38nzwJGvnkPj696jTTRzU65+iHbb0fjoIxUkMOqS6?=
 =?us-ascii?Q?8tPVx7lCyk2lcun4tSryWKe+OUsQ1/dq307Y75GV8q2eSINSo0iSDeTJXhzQ?=
 =?us-ascii?Q?cd9Z/AQH43PlyqDefKFYpMQxLkmL+QcfmbgKPJPMYyfU2pm9+bD7KYmgwszo?=
 =?us-ascii?Q?f7BbK/yCgV0M5J6oGVIKWFZ92oA1qDCzTb6RvPLk4vGb/9YHz7K4v0+DVZxs?=
 =?us-ascii?Q?FBjsxWNgjKU+z9ikvqzvPjSIAqXVN4hLsBWDnS35+yqvWGga6G/RdB9tW6jM?=
 =?us-ascii?Q?9gLWU1owl9jh6Q8J2aJ/SFHwNlrAmIWupz7nipnVzEzuyctZDbP0XD5Hj6YO?=
 =?us-ascii?Q?tR0t9FiMiizBR96Aar3wC37Vusj7NObaeFlJTHfwDB3hvU4xkLBT6no5SNND?=
 =?us-ascii?Q?u9n7pVEkaNw+7gOQ0gotSkNtfUOoeer/9yjnJqLxZkYFiQfdn0q02POvFCqC?=
 =?us-ascii?Q?mSoh04NXRjz5zgyJHzfJTGIM7l5bftcgFA4JRkQXvmY8+Zquk73ifjDa2DO1?=
 =?us-ascii?Q?B0Wea4mAQrkAC4CfK94XPNNBox2XIhLO10uautJUY98kqKKMisffQTF3rl0h?=
 =?us-ascii?Q?lCYwgubwArdiBNFUIjEUICtlNzxazIGzhfH0HRrpJYVw60RUoHX/B0fSVjmx?=
 =?us-ascii?Q?lYYC2G7L3/0pqt844pX7GWrt7kdtInyOt6874KaMdVkgW6oSEJSHBUXxa6TK?=
 =?us-ascii?Q?mzlNdY9Ng0rr5YiTeNjV9fB6MQ7c2WMlBAO8YoXYb4AlE0mnOZnI95ubDVLR?=
 =?us-ascii?Q?mJcwsMeOq4x/qxms4PqdLAyG/lLnfzFJvG/VwdcStx9KBINNmWAVO0kq8RsS?=
 =?us-ascii?Q?v1NygoIVUSMGhompJOFCoQ+b86GddSjFd8uWkUiKEXO0v5PxbHkOfXXgIIH6?=
 =?us-ascii?Q?dgutBp+LF/OAZfKpIAxFNlyUVg6TOzI+UwdWWUhsdIixZNEz1tqb9HMM5jmo?=
 =?us-ascii?Q?P1E5lYyj2aUD7iNKDap955ec7y0LDGf7IQAm4DegrY1WMyCA7CV11TmwvwrI?=
 =?us-ascii?Q?rOT2AKq78lm/s4uDH5a2KpOYSxEvVOFLCKLSvK3t8cfYPNprYcCkRl64Gz06?=
 =?us-ascii?Q?xixRrTlIlxYfC1GJvEc5QbEwoaR0yhD8y9/BSvufeZcdn6usoFOIO9JKvwc/?=
 =?us-ascii?Q?D9mYpqzy1VHlF8FLWmg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e070eb35-8f4d-4f98-83d8-08de3145051d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 01:49:24.0873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9x2xj7ebBMGi8pphbQotorNG8ypXr3B7WNRPBH92ADqLGR+PqqWINGQU8at5/YNDU+HUluS6Bqazbx8FP+o92w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6816
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

> Subject: Re: [PATCH v1 1/2] imx8ulp_evk: Move environment variables
> to .env file
>=20
> On Mon, Dec 01, 2025 at 06:56:56PM +0800, alice.guo@oss.nxp.com
> wrote:
>=20
> > From: Alice Guo <alice.guo@nxp.com>
> >
> > Add board-specific environment variables to imx8ulp_evk.env for
> better
> > maintainability.
> >
> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> [snip]
> > +fdt_high=3D0xffffffffffffffff
>=20
> NAK. I just the other week sent out 40+ patches removing that setting
> from other platforms and you weren't even setting it before.

How about add a check in checkpatch.pl to give a warning on this?

Thanks,
Peng.

>=20
> --
> Tom
