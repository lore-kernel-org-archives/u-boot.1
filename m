Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49335C30658
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 00:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 682788875D;
	Wed,  3 Jul 2024 02:34:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="OFsEQKy4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C56C8875D; Wed,  3 Jul 2024 02:34:25 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49AF4887B2
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 02:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdsX0kMsL91dQUg/o8berVitbrik6t+pUvKz1uKASLZR3+2Eon74ujm+vDj1469bTNwRbmdhWKQCwxGF77cTZe9mP9Qbg5ZlmZCDbj3lokGEdhyiMtAO1ePC1XobyXfnOVWU5Z4hPPFuKUkJ3QLb6aHplxUG519PR4NNG/Ugadram4o99Znq7fMwl4n6owuq/sO3oMUHSWfGTHArzuQzCA3n1o4D/JDXc6FSv9YVH4nZNbwXgBrrUIuO7lU28J9clejgHIXLcwVE5/mhxAaNE0npCxia3dOv9S5UExKxp0QSvz8OXvXIM5AayWQIED4pOkE5v9Slixn0SJsZRYhZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwXISQaRQBOQQTTPCuCpo4JUbeAyR3050LYxaOj71uU=;
 b=mymwxkqB66zccc9EfwRIbm20GUulvvIjoIQn5WyLN3B4kHYBBp+Q3XPq9AwSQR4bO4Ccpr/dGGdtTRxj1QW7jJmz7MvAb3z2e7liFN25ENVFREGSCT/b/Ej5Nb7GuuW6BzPDrN5STaqroGDWwz6KUajf7sUWXGbdpPoT68ytq3nkl+inlAmyy1bapcBVlyHUY6T7Cfx+pvJ391wal2tIK4hCp9yCZskoxdyyOqhntrOOMRuDh7ymGHyY2KKwpcdNksicB+yGflhgTUD3uzusaVdnsrDlb/eBr/f7PvBP1udFSmXoYwKCbv7Fiv6uqshAB1f/f0KdTY19ccj1O5kqSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwXISQaRQBOQQTTPCuCpo4JUbeAyR3050LYxaOj71uU=;
 b=OFsEQKy4q6q1QcmsefE/nhPqTMAwGmtNN4/mMZEt4408Dc8tSAF2xCh86Y876/x+K8jzTgczPabcR1vFPC7hfHraFAuLDEOOgMOg7aOrGqzSBHE2vEr8k5Tosg/CgN/IMPvhb1s3k1mFTtbqw4yr/0Ug90OZPyjzBoaDk/UXElo=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by GV1PR04MB9197.eurprd04.prod.outlook.com (2603:10a6:150:28::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 00:34:19 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 00:34:19 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, Hiago
 De Franco <hiago.franco@toradex.com>, Mathieu Othacehe
 <m.othacehe@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Sean Anderson
 <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH] mx9: Correct repeatable build error
Thread-Topic: [PATCH] mx9: Correct repeatable build error
Thread-Index: AQHazJXaLziDWcu+bUqP+8HszvuXd7HkKCgg
Date: Wed, 3 Jul 2024 00:34:18 +0000
Message-ID: <AM6PR04MB5941E0F4122EBA4EC4B2D78388DD2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240702153739.2651815-1-sjg@chromium.org>
In-Reply-To: <20240702153739.2651815-1-sjg@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|GV1PR04MB9197:EE_
x-ms-office365-filtering-correlation-id: 70f14299-cba2-4c25-8e4f-08dc9af7e04b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Jq5fJ8U6fpa78AVBUIxXVBfVcq0oDOYAF9bFN667inhHhnBK3ri33LjBMWUs?=
 =?us-ascii?Q?hgK3DqieXQS0gvvN9v0YV/NlW8yY6fCRd2bTPNCYtRnqEFXX4XvrnlBC8Fo7?=
 =?us-ascii?Q?jbDHiNPdqJbt1IWHqdc3QJZ7Jv5KONq7Avbqo2xtgJuyUqDgEHWxMsga+jMx?=
 =?us-ascii?Q?RB9hG4/54mzse5dPWF97tMgnR9Zhh3wQAmicBUztIr/YGHzl5L+q64KfdNBf?=
 =?us-ascii?Q?vv0gho2rEoJqyB8KAVa3Bpm9qEgbkxJyIE3e9s0uRWlfYaGq+DFaB07Gt7hQ?=
 =?us-ascii?Q?yRnnNbNbh4ag00v72F3n/2h/F8CTX54C/5F0gnun1kDN8sbWjY7QG0uDV676?=
 =?us-ascii?Q?TaqaqLyhNNV8kJ79NJb8nt1t1QS6180HVpgIvjGbtrQ1ZXXOwVsbeUW+dU0V?=
 =?us-ascii?Q?V2M92JA8j6kLwFxHOrNSOzAfMsEQSI2enMsb/WqREqAT+L0pTgJVb6EZRGgp?=
 =?us-ascii?Q?ME2GcBILLJqTu+HR4Flk1If8ih9KvtMop2tXmvpKwGHnSoXdhLe1DM3B7g2q?=
 =?us-ascii?Q?jxvUoqGVmkoDK8EkelXaSlWAVmMHNb4P4r95OKdxmM7SJG1wEzqnUeAs/AH2?=
 =?us-ascii?Q?bVciJEcbkryATw5bsMq2TkY0LKdez+GOvLFlsS2Sk/RwwPXab2PZUtiANwpX?=
 =?us-ascii?Q?c1p5O7JgYqmJEokkbaf5/klWXCoVER/R+87YgrJmGjgEBa9A0doFpisKXOeI?=
 =?us-ascii?Q?jfxbrMv+Uvin1SUXXa77RFUAs6P1hQiyl8cgz7aoz62HeVpJZaxmxjfvVSzs?=
 =?us-ascii?Q?g7OA+PESCGXH7Yf0eBAwp9N3QEipN3riw4wedfB1L2v3DzI6U6wUyPxUwbeM?=
 =?us-ascii?Q?32mICY3X/xbkbusi4O0YikWJ0+oJct/hG/SWt/NvMGiEglrwZrkT1DWGkfVL?=
 =?us-ascii?Q?Glg1Foq6nlJWcBNEyd66Uy3qYHw7V7ON55owj+vPbo02MLfPrILgBdt+mjJT?=
 =?us-ascii?Q?Sy9N26QGmTJE1H8AaA/pEM5UuQLfP0Fri7RwLZf2Tey0hNnv++OZ7DrWoSrj?=
 =?us-ascii?Q?eAa4AlThFag0L5w2eRE+dKYDt8kdiZberu7RA5C27l+f7LRDvc7/Q0Bdhh0f?=
 =?us-ascii?Q?j7hL82/FvoLrYKuE7OoGBYX7JkwqMbaK2ZGPwZecN5okAlQd8f3ndC8Wsi5v?=
 =?us-ascii?Q?xty8Pf792sPbLYAmQEg7XjkfFIB2meWse5P7iToBHKwphl5rcKcaTfO7K/NQ?=
 =?us-ascii?Q?quEl347TeUR+cxbsyaG+v/cdS3JrP/CDQ/oWz7IjoA9Xy18VA4qKTGdEz9ls?=
 =?us-ascii?Q?mVltKVToTFqMUOrFAjN0Mxd4qpZIh6FTktzaKAAsbIGxYVG8asyxUjV/1EDV?=
 =?us-ascii?Q?+xgeM7T1jk5j1Wh0lKwfxOmDkiUgEySWwCGcJ1DV2AnBx5kFHLUOVw4m0WGo?=
 =?us-ascii?Q?tiLzgjXWQuA53ZZN23rZivH4LE3hGSgtBRwKE70h8QyuPxf9lQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB5941.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g5GHIswj3nNT7XRm5r/U5KEk9sxj1KLRv4b6OX9uvugrvXzgqaU3557B+Kui?=
 =?us-ascii?Q?MLOJ6S4lakr/J6KTDFOzmM+XCaJy/9qPRSaYxgpJFs8B/caCJFkgQG0mCrhI?=
 =?us-ascii?Q?KDzbmDdWysT8WhpykWnQW6rqd4yALPmr+nFVWARLpiGQpJ91OkQOuRCDyHOt?=
 =?us-ascii?Q?8e9KibeEn23szPFvP+R5mtT/+5UJcowt2t1Ovxw6lbG0AuHAddssh6TqjLQY?=
 =?us-ascii?Q?6DJog7fAJR/L2njW07hlb1Qx3a6Ebf3S9Zn9Z2AvUPLp9k1H1K/dF9Mvv9WG?=
 =?us-ascii?Q?P6kdGBD2uTKJJP/JTxhFT1DPKE+2hdovtJbv0V76xhaYnD9U03/qDZ+dZv6R?=
 =?us-ascii?Q?ZT6Y1hvTAeTK8zthJ+/JU8SsTFY1+2w73L435VVh/0b9B9md+yCJCt1og74s?=
 =?us-ascii?Q?AecJoRSARQ/MHZPl9aNnhtHLdOnL7LnmFESQf6tRi+l3fAPlUq9/oAt8mtTa?=
 =?us-ascii?Q?lk4PEQ3/POBTn2HW0uFxd16t7PjwANchBiyOyTkPG+MzXB3hzYdw7OsOQRLQ?=
 =?us-ascii?Q?9I+ljtrojNuw6mlWswSdK1mvK4LRX+BsQboMATEV+ahTfFaF6RUyQjv98iUk?=
 =?us-ascii?Q?OLcCpHmeaDwhpWuw8KFsz3SfbE6BgSSg+8s9baNc6JJuwIfBWrfHpczQV0s+?=
 =?us-ascii?Q?rMvpFIRlujgCRt+eVtQ5RS9KrWmOdTyB3uNEeWJMXh/LH0l/bEOYbtyatxsc?=
 =?us-ascii?Q?CThKlvSkb65st8EAKKC3uuHonsRnDpbm+nuT9ao+vtS+nPUZ6VEmScaVXWTt?=
 =?us-ascii?Q?8vOwnQekjM5MO05CcoNw419ookuLAdFDljgVpjZo+94Ny7c8pAr9wAiytpE5?=
 =?us-ascii?Q?2NmI4nvvy8Mux+kyZylBzUZHk8e9HlhsiWw2SdSo2WnnJEYqLIxWjlM3WDXR?=
 =?us-ascii?Q?R9XpY5TT9VTnrWk+5KI92VPWdjVdcXX0WkLWixyNC64YTeEf95mh13T9j9PE?=
 =?us-ascii?Q?gY/VxiECGdLqQerx5bLsYjhLHS15aERW8eAR99AsPY/UiqKnmWEPk3ffTBsd?=
 =?us-ascii?Q?o9oXn5BrIga1tPnO5OEkLY4f12alo2I7H1SvDzlDebVMzFGjHwOeTIkS7k2M?=
 =?us-ascii?Q?JlXM2CdKwvo4WL/hI6eilrk3CWqki+dVlEwT+2F4hao/amEme9Dd2SGnxymT?=
 =?us-ascii?Q?ScKw7ZrWC3cYMkZUeJUmqpMJKG9gqfupDDhfw8ADqeQLDTqxZkbWqMBOkOqc?=
 =?us-ascii?Q?6X9EpNuzobFbvfS/vMpeBeVvr2dfej0Gyr2kqeV85W5yo4NGT93Iqj2pppg2?=
 =?us-ascii?Q?XYym57/USGf45RmmFwq2c8C7/TiEW6JhR/VREUDaol1X9eXwEV4PLVc2ajX3?=
 =?us-ascii?Q?9jaD8Sm4ue/ZZgbW3nPajdyDTaGNQ0Uoi3bSFjD/ky68uY+ZN0VAjLliw7Lb?=
 =?us-ascii?Q?Qy023xgS2pu9JbeLbFAap3/pdqgGZvgkQSqIb3oCufgxGPK+D5EtyzKpgYGn?=
 =?us-ascii?Q?lDZxD5txwn3yH3zNcqUYLHrqXz7jD6LI0v/2P5fMkM4eGLYBFFDvAxdTmU+p?=
 =?us-ascii?Q?6dl2+adl4FC+vGpum723BOnYQeDSBSxt3MEtE+USYuuVc8wp8zSIMSySm/Xc?=
 =?us-ascii?Q?o9U+4/Jvf2q+YUgyVzs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f14299-cba2-4c25-8e4f-08dc9af7e04b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 00:34:18.9832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cIRJC9c8z5YUMkSqoYeC10vY19z9EJ156LZVf9nebuTaP5oRdlR47pRyC9/eMCGUekgXVVsALhziRFRLFjVcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9197
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

> Subject: [PATCH] mx9: Correct repeatable build error
>=20
> For some reason every second time imx93_11x11_evk is built it gives
> an
> error:
>=20
>    make O=3D/tmp/x BINMAN_ALLOW_MISSING=3D1
>=20
> It seems to sometimes skip generation of the .cfgout file and then
> eventually Binman complains:
>=20
>    ValueError: Error 1 running 'mkimage -d ./mkimage.spl.mkimage -n
>       spl/u-boot-spl.cfgout -T imx8image -e 0x2049A000
>       ./mkimage-out.spl.mkimage': Fail open first container file
>       mx93a1-ahab-container.img
>=20
> Correct this by using if_changed instead of if_changed_dep
>=20
> The only reason this hasn't come up in CI is that buildman did not retry
> failing builds of current source, but now it does.
>=20
> Note: The logic in this Makefile should be moved to Binman, e.g. these
> warnings duplicate Binman functionality:
>=20
>   WARNING 'bl31.bin' not found, resulting binary may be not-functional
>   WARNING 'tee.bin' not found, resulting binary may be not-functional
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
