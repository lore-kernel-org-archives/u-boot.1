Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF8F1098796
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 15:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D91E83D71;
	Fri, 20 Mar 2026 16:18:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZW7FZEIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98D6983E36; Fri, 20 Mar 2026 16:18:03 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4874B83AC5
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 16:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pozYBMdRl29Sz+tkb2rQ/S9vc6McbMy8CUQLHbBumnWmnWVvdvKelNoW5NC2IiMpAhlyItkDGFUc081JSfFU44/EBEqD2BigzoLwJNpZfR9QdxGggVzCQm60kWU1/kCc4ea7G/VfgwdPzx0aKa/hZpZuumgPSownBQ3KJcdTb71xFGi47HWT1ko4ooHFQ67m4Fkr3vvUon6lnXVdUz4nn8XgwGFj49oquPbyj4pPfHIOgHJqnRA/cJxxNAWKgb+rsszJyzzH6amddpEIidlVUvTlk6FsthP6tuK7pD4NpK8tK3H1cAxZv55k5ItewCq00rrhzfYD7FWgASDHLr7uuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+nPzTFildEzUUT7cpYpIamakGvZW2B7sACi1tCQcCc=;
 b=ApFErY2HwndDkj0dmu9e8ce4cuxOeWoJKr7jx3Rr17wpw1BfSWd3TAj8Xg22DAWAV9HgsOckBqp025nM3ZKfjum522kUVL8FqYDE6aFhglH1wpYbfXv1pZEML03lEfXVFAkljRBmVS9qyTkykakqB8KSZoRGus7nBGT7SJLo9Qc3dvmbUZtG6ED6U1QplyWKDh1TaMhmTf+/Nm/Poc5y32xN/eUqbolDJoBuE9rHlcwcRFfEDw7EZrTmCty+jlyf+/ZqpLJ424p6WEZoDtAJRLOJp9FOZSbtjNn8XoCSB8oVcKtWaXuo6f4zsU1AaZBWsiN+bqPAP0HbAQ0lZI2jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+nPzTFildEzUUT7cpYpIamakGvZW2B7sACi1tCQcCc=;
 b=ZW7FZEIVwm6uad83o3C6rT+qQMrt+XJ90sUCcJJpkmmqL/tgniTWJLnvwkLTFSpkH6fKt9jfozOQplqw/D+vFjdpvkSIl6GD+U7X4o0YN9S6g4ILc005g/qpwZAM0o+LJ1EGaeBv1qQ9n6vZIdodaET+ypjIRnJTOhZ13Q6r/7suTfvLrupqYVxDbKiwkPC0mVVaURPXS9uu8EpneBgkpX0RcRupo6XfIfN4up4LgQYpcNN3jcxXgVHTTQlxPELeUnM38qYJdv9Js+fkVlyd0BYfGq7OLPhtkPxmJIidNybT4u/wV4fiRk9pbUaOkpyhJKgbHbvSUgYPdcH3LihSTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by GVXPR04MB10235.eurprd04.prod.outlook.com (2603:10a6:150:1be::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 15:17:49 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 15:17:47 +0000
Date: Fri, 20 Mar 2026 17:29:44 +0200
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, 
 simona.toaca@nxp.com, ye.li@nxp.com, viorel.suman@nxp.com, ping.bai@nxp.com, 
 sebastien.szymanski@armadeus.com, ravi@prevas.dk, joao.goncalves@toradex.com,
 ji.luo@nxp.com, tharvey@gateworks.com, qijian.guo@nxp.com
Subject: Re: [PATCH v2 5/5] doc: board: nxp: Add Quickboot documentation
Message-ID: <7ew7523twjd26673q2pezosnhyu2qzf7foywuga7r3hoamqpfb@bm2d4fsbk3ld>
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <be6b07edb38e4e0dc86e65f8bac7b6b3b0e29d01.1773648510.git.simona.toaca@nxp.com>
 <d3b42af1-65a8-401f-9dda-1f79cb0dde9a@nabladev.com>
 <yuwvhik6p6eordghidde6l4ey6fclwwuxnzuqpttcoicxqa2r4@jpp2t42tl2wx>
 <541a05c0-e0f0-43ce-b944-d7656da585e1@nabladev.com>
 <becryuzd7ohecs7vq2goxhfv5fsrjh6a3ctav77y4uxrszzecd@wsnoc3muqoit>
 <78c40910-a90c-4cef-ba72-4e4cdfd5abe2@nabladev.com>
 <7fg7jj4rou4ke7nkewytibvcz3oehxtot4q4apq2uhtz75a2gp@uvpcobhbwu33>
 <a8f0a62a-9b26-46c7-bf5c-edd26bb1f29c@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8f0a62a-9b26-46c7-bf5c-edd26bb1f29c@nabladev.com>
X-ClientProxiedBy: AS4P195CA0046.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::27) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|GVXPR04MB10235:EE_
X-MS-Office365-Filtering-Correlation-Id: 81253b09-d362-4f60-b242-08de8693d776
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EFKsC0hyZybyXkMOHVwAUz4z+BRP0lFaxTIao+40mk9LSjC+jDtJVFaAwfV8mp7rkjcRwgxelrxYSGSVRVuvNACNr/FEbiepCmD/qHQC6Hfj0gEizSl/ctffVm/TTYvs16eAP2Kf9T2H6f7TzmJO+lBbmZmdceBxMTK/93pqeLB9rnPZqg/+TanMDJ9y4umxlnUmtJNivxhpPMILsRNSWWNk7PxbmNSSgWGDulSyMpdMXdq1/TZq9tEuHbeS+lxVqDA2EoZMPLPRkwrxTV7ObfHjdQpIC1HsgpxHUHg2UPTKpYZcQvUwR1es85kWbzR2WrkV4Hh62gGnna/j6+JeDodolW3PFIkHgVdFew0NUBrzsyNRpf9A9q4J1S4Ej8/L1PNvp+OwET5OY+lsPHyxLTiORgfGtxawh9j5FawZRhsIR7Kd2seNrTW9hz5X+vI+4XbxcVIz1kmW2KEXVk/42yrZw5eJfcEWvpBymNTSp2cEVqbUt/lH7zsu2Vu+WmXqrSZs4wlAdMnyVfJB5AHM1L/Ti5dMgSv9MAcUZyhOLPKXeNwEULmnhiNBA+OVNOZpl3UCuEbqJ2zP71wRuzrUkv+Bmv0oCfrgw+2LqDgR5REpX3AZqr5VD66gyDS46dd0bsV2t9FI9uG4rylH46A/CSxrKQn+05aFbI+My9RY3zAWU91af+R3m8Lz1u1HIUa2imEmw+ZHQgEcC/r4H6lCBImaeI93Uv7IgNRBKGedym0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?twr6k4ow2/XkpvHk7vGkP/QWkbfkRtd3q1DB/l4+74bPOpBo5evxBJkeUV0I?=
 =?us-ascii?Q?poS9JvOsSPuAHC0ry9WCx4Gtm3aewlcSitqy63zNmLAqdwCFBO9eeENZvzOJ?=
 =?us-ascii?Q?IqdpiAl1/P9mutZ5e5RN0aENBNYdjoZ0P9klIZgn6aHNoXFEUSH0eYHVbzpc?=
 =?us-ascii?Q?Fu5axb7HzPPrYtOaU1xrJ2IlBhao7mpBNusfpN7t76no/Yem0We93sR0uLOd?=
 =?us-ascii?Q?N4Lp+CZ4QEaSrGA4E1ZM2DswyQK3i8ZBfvmgvK9EjjV2hC8/QpCOwseyBs/C?=
 =?us-ascii?Q?kwGk6iLFEyScebEQeFrW8KSmzuz9Q3AuaNQnxDdjYVw7y15hhBKqRsfF5yb+?=
 =?us-ascii?Q?qGjKccTkB+Z03UUZSlVzW8BM+h9He6JP+f0dBixfXBOnzwefedwlpsG3IZkz?=
 =?us-ascii?Q?zHvV1lr1ivwdTlV73FQnYiTB/vgfvzeXh/ZJNFPD2Uc0jeE/I8r/25uMigAE?=
 =?us-ascii?Q?G2YGus3yy0psUnhzo0F/O6nQKlRfKJHPfrjhPfP5yUI5ZnaJuVQLG0mmWveg?=
 =?us-ascii?Q?qUYQ78AOmVrthNaYDHt7IHOpyRq7ZUIfIUBn8M+qcoP8wrLyAEikeQ4Zhe6C?=
 =?us-ascii?Q?yuytLdDRRFf9B2+EcLhnB4+pCsRx+PacrushbyviUGZT5ZLkCn4GsLtKYLhO?=
 =?us-ascii?Q?z51QZgtpHBqV/4f2N6ry4seATlBoMRmAtiC0HIOaDeTDpBYb55G3rDUX1Jig?=
 =?us-ascii?Q?/sCPjWPAWy/0d5NEC/wxz0fwIottiMetokqxfbLZ2za/bmY8M3jUv7Q0ZOLS?=
 =?us-ascii?Q?flM3r2CiJtA23FhVpn93OnQDPr5jIWPseYkJpW7r4d8rcsIh0ybAl85ujS5p?=
 =?us-ascii?Q?hQG3oJdzn6RLbwDAuvgyJLHMzmSnVlKTn85Zv46EIYYIasbCw7wP6AhrXhCB?=
 =?us-ascii?Q?URtKyuRPvJJSSFmAEM/xNzL+86yGyFoYhJ3jw3du89JaePBDZt+tTQst4KKr?=
 =?us-ascii?Q?sQHTM0Xii4zs105Ds3LGLVnfsqmqwUOpGXS6mrNFUAI2MFBfSzXZr+d5qfAc?=
 =?us-ascii?Q?cVvRzchGwV+Hck9RaLBPBdGX9RvV6qEayOyotQpP1qg+i4JnJvD5qkmZaGXE?=
 =?us-ascii?Q?2TqehUxkNJ3suuqXvWyVZbGYcjw3DCGnQyyZb/lIkEuVCWaUnHl3xvjK3k+L?=
 =?us-ascii?Q?skJWuW4FXk19ahapAFMat9U3pTruRVGZZUQJf8wBL2llPVta84Blkzzk7z5t?=
 =?us-ascii?Q?BI/flDcQQGvLzEYPWP0WAJaTCACOsSQcVFdDwhrRlHFxX6WAhsoImI6TjiTt?=
 =?us-ascii?Q?ta6zCrlspIqQFsRj+aJDP6KJLXzFLK7sjEfrrhxchuJyDUtlFtzn2g02Qp5b?=
 =?us-ascii?Q?tuI7laSXwm8rxSkmMPgm23Zv4rybejsRD/EuJadg1VWGnCG7nqurHM0qlKDM?=
 =?us-ascii?Q?djE1zkhOVXro32ayIp5t2tFdwy/G1+A390IFr/nTwwmQNblY3smqynceJGn6?=
 =?us-ascii?Q?lZV7JUzWKitE1uRPZU5J7MWahxFAtwDO2nBVJwqrJ+7Jg6C8JllZ/7VfNBoP?=
 =?us-ascii?Q?rjB1VJg77ofgce2bJoUdMdAAI6WblSK8xK3/OAKAJ7wwmyQazSJ1a0DWIC54?=
 =?us-ascii?Q?eRI3xztFnzL5u3+MlIsCU++2ZL9oKBVrnOCQsaHMf9VfUGtdQrchNkKHQohy?=
 =?us-ascii?Q?oeJfjXq5169kgeuXUiPaGpOR3h4NYrdLL/eKVOLJIwKUxTij0H+MPy+GwnUb?=
 =?us-ascii?Q?/QpyDpPJiqjujzqZwHrc1YFLI+x304rvLO2cG5SZ0Lkk3iE/hcTioDZHvOBf?=
 =?us-ascii?Q?n1F+eTnaAg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81253b09-d362-4f60-b242-08de8693d776
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 15:17:47.1008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8VvWlVpVHILytH4GIXjtr1GM1KgiSBk5wNbXAh/nRiDX8Zibmg+6kcHsWgqWecITSiyTtYfq9Kt/H5WsFCGug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10235
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

Hi,

On Thu, Mar 19, 2026 at 07:02:58PM +0100, Marek Vasut wrote:
> On 3/19/26 4:17 PM, Simona Toaca wrote:
> 
> Hi,
> 
> > > > If one wants to store the data elsewhere, they could use
> > > > the generic fs methods to make the backup wherever they want, and re-load
> > > > it themselves to the QB_SAVED_STATE_BASE address, so that U-Boot can save
> > > > it from there.
> > > 
> > > It would be good to document this mechanism, esp. how to locate the QB data
> > > in RAM and how much data have to be saved into backup storage.
> > > 
> > 
> > I don't recommend anyone does this sort of backup, although it is possible.
> 
> I think I know of at least one such use case.
> 
> > I don't see why one would do that since OEI runs training and the data can be
> > saved then. The data is board, ddr configuration and firmare specific,
> > and I wouldn't want to encourage someone to think they could save it and re-use it
> > just like that. Why not re-run OEI and save the data (by using SPL_IMX_QB, for
> > example, which does it automatically)? Or run the training multiple times and use
> > the cmdline qb command to save to all the boot devices?
> 
> Consider a device that is trained in factory, at 25C. The training data are
> saved, and backed up. Then, due to some sort of training data corruption, a
> slow retraining happens in field at unknown and possibly very high or very
> low temperature, which could lead to low quality QB data. Worse, the next
> time the device starts, the conditions can be the exact opposite, very low
> or very high temperature and the DRAM may start to suffer from bitflips
> because of that. In this deployment, it is better to use the factory QB data
> from backup than to rely on the in-field training.
>
Low/High temperatures don't generate 'low quality' data, just data
more suitable for that temperature point. If there are issues with the
DRAM, one can erase the data themselves, using 'qb erase', to force a
new training. This way, the data is collected under the current operating
conditions.

If there are any PHY firmware updates, or changes in DDR configuration,
performing training again is necessary, cannot use the 'backup' data.

If the concern also includes the training time, if the data gets
corrupted, the training will happen regardless.

I am not saying it can't be done, I am just saying that for things
to work the proper way, I encourage the usage of 'qb save/erase',
as I said in my previous reply.

[ ... ]

Kind regards,
Simona
