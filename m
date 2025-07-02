Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1649C8303D
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1262782ADA;
	Wed,  2 Jul 2025 03:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="nXn4ottd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D280B82CFA; Wed,  2 Jul 2025 03:26:43 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFA8582103
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPcb4R3gTUTyii6sidLGaDlA8LPjr7ft/BQhekkSyCLwjeCJ+0Culmg3P5y4dR84+GOaajFSwiLmt+2BSlfvQS+ESctylGCg5Eu6e70uDJoMYRUxwc7+P75YJuLYEIHcjdgth+fCpTasf7h4H9/asj8fVWpyi2dcIksrJLTtjayI/NqAzrpkwJcXQ3E2VDdfM5dutF3yoPg7wBUCr20UN7ZhMmcIn7+Tntgf/fb+RFRGLVAWMu4krp2abqInIhotj3mQTQB0Y4ioKTU0eC2qt+jrf6z07AD08Neh7p8RmhzJcguDaGAQv/b87k0ypR1nBX3/jrGJXSQ98GehzTy7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru4mugGSD4tB/9qPDouu9E6qZe1s9UtzyJn3+gUxsvY=;
 b=SKIpnCIJ6DeKtDt9siI27BX6y/Rq7szqv4V0JkrJ5KoMUUPxZhQKHfNyJ57/Zbx/vKSPIaXL806OVWBHygNuv72q4vlcO9irPp6OT8LkaR336GJfaZy5UBcfIO5BCRYBp9jhpF83XpWGwXpsj4Q32yQBz7zreWtQC/VNXuph1LBCxuqh9y/C3X3Mc/Fbmmgxpgy2ID61dTAuG59SJLqvh3BqHjgCJkGPPkJzfYg1zpBZb13LvDl/7bmWcEcQyRrzc2ZwJ8AAKQaEpcDiwnjK4dA1nB288xzv6vJY0gKCIP8XvzSjziMumqGvpw3MMxqrFSdd7dpMogiPFNySLRl7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru4mugGSD4tB/9qPDouu9E6qZe1s9UtzyJn3+gUxsvY=;
 b=nXn4ottdxmlc+Kb4hjphZz+fp5hS0SQEaNopCrsUGE5WGWcENMFcDNI7AMRsm4mjLYGiJo7FzMwt41tTKj2VWVR3HaOnK0dKy2RNj5QKd5vzPUTLVvaVEr0pqr7YiCRSBSu0a0/EY5aFwErCqwPW3RwJFaLCFnLGvyl6OQjGX/y0+Qq9+lhkSqb3HJN9UTPM0QQTk/J0b5q23BoffgnPoIaXRJsTgAzohEpCuEqVgdVEPdm7jLRYB1oI+5uH0o1iOPy4agUyHL/j7qLNUi54k8VC5Zac+LzBzLMyVomJw17exBzsUQSfIuvCcJFza0O3dd5G13nU8rTdTRQpP7ea1g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7688.eurprd04.prod.outlook.com (2603:10a6:20b:29d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Wed, 2 Jul
 2025 01:26:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 01:26:38 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Gaurav Jain <gaurav.jain@nxp.com>, Fabio Estevam <festevam@gmail.com>
Subject: RE: [PATCH] crypto: fsl: Only allow these to be chosen on ARM/PowerPC
Thread-Topic: [PATCH] crypto: fsl: Only allow these to be chosen on ARM/PowerPC
Thread-Index: AQHb6u1CeCENJW+5v0q1lUabuwWaHbQeCr8A
Date: Wed, 2 Jul 2025 01:26:38 +0000
Message-ID: <PAXPR04MB84592D428721AA02336C66BB8840A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250702010419.18890-1-trini@konsulko.com>
In-Reply-To: <20250702010419.18890-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7688:EE_
x-ms-office365-filtering-correlation-id: 5c2b3080-9207-42da-1f6d-08ddb9077df7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?uL6coA/4v96IIGKM76hGeJC+Q8bUcC79w9313Hp33fFhsI7xjSnC2Bvdxih9?=
 =?us-ascii?Q?5bulzho1ofFHM40et64k/BPX7661G+wc6gA5EQrbK5YHX9IUpwBEowc3bui3?=
 =?us-ascii?Q?JVIAUsEkwyqI7ppXCmi1zUMS3S3M1Zb74JCb8/lLUVC9e/pbdF71C0Mi71dC?=
 =?us-ascii?Q?//OTB7OPf/harZIEcZ/cueuUFZuYy69cYNbE5hXDiU8z+bbAM/UXyJfxZyxH?=
 =?us-ascii?Q?3mpmOYV+ivYGnuejLzplMWvv3qng5oA+QrIRkSgEioMun3EwqHA61Aqd5nTy?=
 =?us-ascii?Q?eOzIStGrYftRFgrgTAxoNUC7lIUrcHhaYGB0yt89+gJV3C3VRcrMpR/d8uZY?=
 =?us-ascii?Q?UzQOGpFGN5FdRkrjLtKmPT0xb3xGUjw3vMuAyxHhEpGLwxfqjlLYuFOyXNrI?=
 =?us-ascii?Q?4B96HSDOw8l9BGbwG/xdG1Je/t0DYwidAhy0xk5AF2WpWaPJvodqk+IEU8wX?=
 =?us-ascii?Q?Ghh528dhg0TJeL6f4FFvoj2b1eB4pnOLuK4dz6kaIgDw87OtVsLHBetLPOQD?=
 =?us-ascii?Q?SdnokEmCTUxR+XBQTumNOGPSqPUWQ/sdlX37//8Sb/ge0RwpC/7s7ADjzjcg?=
 =?us-ascii?Q?HCIl3ciGOoaBOhkrYb9Os1L3l3cOX2rXDcE8BhF9TpJlIWFJiAtw9iGyERpf?=
 =?us-ascii?Q?BeSkjYJxODMdkUZHA8g4tvFTA3ujVHMpk7LwR7no6fe34Q2gAbg48aS3SEnQ?=
 =?us-ascii?Q?yOzXU7ocLWXGyolXALLjbLUSbAX20YNwBdHx+lFYXJw4Oe6IWkyXeconYSbv?=
 =?us-ascii?Q?saTv+6Q+iaD80ldj8GeUaYTHYy4YFMIuaz8LdHCwXcxNBK6naAmv+XHGDJ0o?=
 =?us-ascii?Q?yCZWJh+s+G3BNkFDi2bQRNvJjuC4WjSDt9KqEOTln+uCFlQvjeUS9CFzNLB9?=
 =?us-ascii?Q?yz3JWvyku5edqoe4i2sR6AJtenTA8X8oMHXWTfssyVbM44jPH3yva9f6VKMk?=
 =?us-ascii?Q?RoG+x/lIG92aj7mmCFWHvo68tAS2hsGiugTDVyRKRDorWNkN/UmGoWhpRjz0?=
 =?us-ascii?Q?vDD1p9/D6L5iOJUf7eP/5J1sPrVpRNJEnSatOUOiQUJ7A7PPDsEBqxD+eXfb?=
 =?us-ascii?Q?IYm9hszzYY1cy+NHSCanpcdr/2q9M0j/PFr9MBsV7PrUhQLEY2mFpdmjgx75?=
 =?us-ascii?Q?FC85XW5t4NdBV3Zl05YovXj1WiPcGOBdn//v7PcvieCYUPQKQuoaF++onA0C?=
 =?us-ascii?Q?WVkVGpFmxLdLrLl7aC/FsulmpX5lYzYLIay2I6u2wn56/RSbXVpB9UHwAwgm?=
 =?us-ascii?Q?9RaAgm0St9q8N6SVHJptxl2bLJPRSb4+5cNs04mSELRRUr0bp6H/WOYOQ8mf?=
 =?us-ascii?Q?Lw7vcJBlCJ8naluNSVkte6fWdh4KcuJ3Tz4Pt2f437vpXmmSMKITgn304Fav?=
 =?us-ascii?Q?vFCJcLAPXs7lwL5i5bkRTH26lrQAZqckZRC6SWLmwaxZzoELm2Y0T/hSJW+O?=
 =?us-ascii?Q?vgN1YLwtkmgKTpN4B8xBOY4JQidv9mCqtsSA8tZqpsV8E3kbzLiKlZugBtOO?=
 =?us-ascii?Q?tIV4w8KP1yfi2M8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o8oSXzJIFGhdxI+fkjmYCL9JvZUR8R3UZHAhSxP//zUia6mPHfup+ATCzJN0?=
 =?us-ascii?Q?jJJ3xPEiRJKONxH8tazdpbQksAwpLdb0At0MNDiaqyTNgWWUGrk/doX7VJyQ?=
 =?us-ascii?Q?hcdbCmh74KlIdypjDqviAIaeYk1hGQ5FU1yRa0s1q/01vD2mgaWbOQSc0MJB?=
 =?us-ascii?Q?1wLU0R93xy5y+8fBBK4HymozpWiVWP0AJPKstjJBCfPPBb4fpDy26wi1jKAU?=
 =?us-ascii?Q?56YR1czzt7iAiv5w27+gcosKDTKh7FeD/1Y60p8UI23az655HEYCUi6tNTXc?=
 =?us-ascii?Q?kNcWjWfSMRFrQ+PPaKm4dn1q39FL6qAKEoXlJrr5P2lgNleMeSX1TVGOkjt5?=
 =?us-ascii?Q?qcuMbaD3owvMr34Co05FbnIFfSo/Vj13Et/ZhopRKkg5rClNIzNBVrP3EGED?=
 =?us-ascii?Q?a9O4HGIb3t81uJIvTY0vCa7wiTKPFuWVO4GWk0KHsJlJLalJq9maf2Vbq+sF?=
 =?us-ascii?Q?HkHMdorUNnYiTGEhF6bpMteOI+2bp2WW/efpm0kDTw/ibWCjtU2rOf31uBLQ?=
 =?us-ascii?Q?rRAIe2a9MhoNmrKLRO2bCMii/F5hOuEp7zNpNGQz1p6Li9ugA+SrpFXb+Szm?=
 =?us-ascii?Q?ID/3kCoXX9vnfP1j5iDbElfCasPUIC11WgPhmJFyb3jTyiCb4UEn5DKL/d/X?=
 =?us-ascii?Q?/Nwh9rFeMsNv1uwvSKUaTdAeP/KN5BxCQ/z0sw03DkfI9NkpD+7ZxKJgWuLg?=
 =?us-ascii?Q?uOD2jl3svLhMdxohtWeN/TktSde/ZMo8fYJCotz8qNUWIDwscAWSn5NeCPw+?=
 =?us-ascii?Q?tgEIfr3YmJf0idvSd4n1+ug26Y6CITRwV13tPYkqFhD8HwT+eI7hHgQqqWe3?=
 =?us-ascii?Q?BSGUYwF0kV4qN/zNAM/hgPTPzUPudrH0/ckPIZD40OU0IpQeTkt9hhjxShDc?=
 =?us-ascii?Q?ayAAcr7aDHP36u2jHZPSjKabAA6RHwHM4IyuXITxq/QDMh3lwXF74AEnna6S?=
 =?us-ascii?Q?0ujLdI08L9k1JSAtm6H51tiIISGn64YMU8h6c1iZmvYSgA5q8iBi8/6Nl0ll?=
 =?us-ascii?Q?Qc+y7YN2nY/LwtgvAKc8W+KwLK/HHnCLRc/sIDtWf+Fa/9CrqnIWgZ6b2Dh6?=
 =?us-ascii?Q?2eMSjAal2LB7+mT0vWgzqF+oBjRrtryR3sO5ME4qXr4aBsPwEdUicfoTDKpr?=
 =?us-ascii?Q?kLUmGWHoL/2RXaB//tSxE3cYRPxeWBhW6T1Ovbu8o8MRlzb6N9v6q5x0Clf8?=
 =?us-ascii?Q?pHQwv9Tqt656WlZSjnQQuyMWrglIIqCLd+9J+6mXqqP5lwQsKDofiC8Fztwk?=
 =?us-ascii?Q?CaE1bpL1MUfMkJHTgGHyFrodKvagiz0FmhfCGxr7tbwLputCMgvhErbwbRVf?=
 =?us-ascii?Q?oTy/F2LELLfFZB56GGrU2qzc7XlEIMl+wrt0Ew/e8BrmRlcZ2biGku4LsMWp?=
 =?us-ascii?Q?01Ncj9Q8uy29qaDcsBWg0bZf4QsnDLgnbzIsd2j9wrcu/Sj40+1Ze4px44mH?=
 =?us-ascii?Q?CDpi/7b0xUxB6IhCMO6lsYdBLegqdckh3gVoPUb0jydQuTbGf5Kc5o8Mhl3f?=
 =?us-ascii?Q?4AP4x8xeh9FPa3rugJGOEqIOEjLrbOWvD8OagYlsfk2cyQGQiZJI0rKeXfAb?=
 =?us-ascii?Q?ZZ37PSf4r6T6J0dzC0w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2b3080-9207-42da-1f6d-08ddb9077df7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 01:26:38.5229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJRreo/6xKpScXdAVbJoKiV4+mLMHmi5MfZB5udjfsYPXofcQuwKq7CnI2AOAR6Cs8Lta613+rRIca3ceKW90Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7688
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

> Subject: [PATCH] crypto: fsl: Only allow these to be chosen on
> ARM/PowerPC
>=20
> These drivers require various headers which only exist on the ARM /
> PowerPC platforms which implement the hardware. Express that
> requirement in Kconfig as well.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Gaurav Jain <gaurav.jain@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
