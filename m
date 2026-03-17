Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E1DFD875F
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 12:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10511842C4;
	Tue, 17 Mar 2026 13:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V0nH7wof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E3F5842D7; Tue, 17 Mar 2026 13:41:25 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89075842B6
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 13:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNlIZXljax8ybYhB9FhysIZ+SR/FUVyRsSLjEHHUxSG755eidFS/VZiyWDZ6SHPtKOoEjpnTThvDVCQEqUJshZsbRLvC8gEu3kYO+oMJfca3ltIsoxyIHadfImD18tsgnunF6EYwDMD03DvOBd3aR/aIzK5OaHfJFo9uyVGmyIhCsCNPQR0+SYK/e9fv71xaLfthZxOfr7hTWi7ADzH/gZsDe7zTBtg30EUSm1iFyztCJa0phy/G4RaKUAS1BuqVA5+iVHcPzx1OtIkSLasOOGHu+wMW44ZmTK1FB6rROnT5qO9XARKAcp4Q5S4SyIjhjhbr5SgbvvV1UBTuoJbcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVcl3hv2sQH4Rd8wRkR7EF6RSNkK2fGsdrJPeuqjibQ=;
 b=cuXY+AZ4/riBr/56KST50/C/PPsDoME8CpXhibKYnBBKqIpt852ySU1aCsFB/61yzv2vrDk9bjUXW6aw02HCOGrX/1+3GKDd95eZrjPKQFm47Bac46PTCTyutbmiyiqah0YQGeaa6eWR9cMCjSi1j+gmyEUebOVf3Jks+4zMTuWxjjfO6ZD5NiqWFrbMtWCbfgt5Mt0Ffv1D5roRRxfNINemLa0M9SR/Rp90O1JaPXL/49fyZ8LyGChV2qf7jimtSc1ozW0bKpu+EXdxIMsTxaSJWDH26PZDC5hZdndZOe13M4RK6V1Mc0QMaS+bzK5oKXLPf5usl51NDupxmYSX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVcl3hv2sQH4Rd8wRkR7EF6RSNkK2fGsdrJPeuqjibQ=;
 b=V0nH7woffqJJ4nMSdSlwq2vBhOAjZblww21sM7uOagsOCHB8AbfP08+D1mAy3Z3/ZMaDTII4BE7lCsvyLeSLNLoAlbhXSH09SzXi1zLnezwH+0pW6ksdwJVRERfypMy6IVb+dev5fyjnFFXYax0nI4m5T2PJmrP0u5bw1XFMVLHB062ciAULSjrIQ+E581HE2roNo1GoTquYUJwVwNZzDkRFkAtN5sjD9xAwyjqL2vR6c4Tn5tb5xDLP9H3hPijfFwijdI3fk6w16u9ekGgpfNqGKdQDDJbkwicvRODVGESe+YOV5GAz8gdYiQhmZAHZSeTtmkZgDvUUGVxV+ujyEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by VI2PR04MB10907.eurprd04.prod.outlook.com (2603:10a6:800:271::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Tue, 17 Mar
 2026 12:41:20 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 12:40:54 +0000
Date: Tue, 17 Mar 2026 14:53:10 +0200
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, 
 simona.toaca@nxp.com, ye.li@nxp.com, viorel.suman@nxp.com, ping.bai@nxp.com, 
 sebastien.szymanski@armadeus.com, ravi@prevas.dk, joao.goncalves@toradex.com,
 ji.luo@nxp.com, tharvey@gateworks.com, qijian.guo@nxp.com
Subject: Re: [PATCH v2 5/5] doc: board: nxp: Add Quickboot documentation
Message-ID: <yuwvhik6p6eordghidde6l4ey6fclwwuxnzuqpttcoicxqa2r4@jpp2t42tl2wx>
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <be6b07edb38e4e0dc86e65f8bac7b6b3b0e29d01.1773648510.git.simona.toaca@nxp.com>
 <d3b42af1-65a8-401f-9dda-1f79cb0dde9a@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3b42af1-65a8-401f-9dda-1f79cb0dde9a@nabladev.com>
X-ClientProxiedBy: AM0PR10CA0057.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::37) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|VI2PR04MB10907:EE_
X-MS-Office365-Filtering-Correlation-Id: b0817836-4efc-472d-55f2-08de84226e3e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mFzQWJCj4BsWIBqduQ8AEfPvGPhyOOTbF0Q6GpEfo0dl8IETBVf5XU6kc6uXgPa5/5owhwm0X5mGa/ZEBqQl8uH2rKwBbVq3wBGWCW/Uuow9GBgloXN2qaNMlq9qbZ/qGtbUONZ66PqOK+dqoiyO3jX81Zb2eAzdjDm5LtZlKlULCeOuUDT5MuZzEtt04JcRhAVTw8glATIWpcBhZnAq39rFDfvjUBppJD92AgznWwdPBWxS7kXS9CDilVT0ztKJR1+wLYTmNQPXDnHE8DHacT1B9jzheR6D32haL7glRDwhxW7hd8oKOZ/VuN3OJRGgjrpyfNAblsydDs7JF19eM6W1DeGTCsM9JlY4sLH4YRT6PpZLrq02FWe01aQCvjfVUkH8VfKBptJG2ABRl6dE+HOe7Cg6pd/bVIyn3UTVLXDFbXH3rdkaQjqzg/iU3BfH7frE/O5kXj8UrVYR+mVulQIfae9KMCBbhzE2Zi0ZmjRJLQsCbmZ3DZnSWalJWgNlhpFDyyZQtihiwF8CK4IETINWXgeP2OQK0W7ouBXK3Xe2DQRu6FyB+ov4/O6Rj9TipppmlMAk2mTAR1+C8kDmrBJ4FgkX6R625VI36Sdus6yNtndO9jC+4WMBt1rkilnZzbFDVfo6cU/Vs85d7Fj5BibL8fBBJrbz0tfbSU42riiY+SmNkGNKwDMv0sjwzD3chtXvx9sdEoxkB3BhVvHTIbqSfXTuPqpm5JvitsJL4s4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s2WrAFTALEXk5bKDw+mFZZZXfN/BMXZOHxJVRiIjFjHeaZzanxtgcvWRlIh0?=
 =?us-ascii?Q?BaGidah12qzAxrm3Tm35O2l+bSmVw2kDuI7g1M7oqxMZH3ZJRb5ZpHphx9sV?=
 =?us-ascii?Q?JL6gvwlGK+ctkBA7zYruflpKKwkLqWs8ghiiPZ7TT69CpsLYS2SSSYqIl+L7?=
 =?us-ascii?Q?ii4YC5vPVDG2Fcd716toSRAxRwG+RI2YTCj+62CDGeixMF/vnCa3ouQ1cHp5?=
 =?us-ascii?Q?illEdAoP4xx4wizW0+WPjHxR0jSiukypgPIwdceoFcbXT2qpNpmnmXNJjcM2?=
 =?us-ascii?Q?xWinuSWjm6ZyjuA8FMoxi5GCeunLK4Gg7iPUilCMheF341tWdKuGEOIisVEd?=
 =?us-ascii?Q?OQL11HYIWd+iPBAp967wPE20swHd/Wz8buq7vT9wi2t/BFFzxNi4qaAtLIdD?=
 =?us-ascii?Q?NrvCdHhQmVZgagdivMjMufn2kP+HflTG1iDleAuDxOB9SzjfRMn5I7ubR3a/?=
 =?us-ascii?Q?zp0swvR8AfbMSQp9jnSY4yTxa/aayvDGe0PHlXSHYzKecBNg7rOHWrye6V7X?=
 =?us-ascii?Q?ydF58roEVpAU8z+xk1V2TpikadS2asdEtXgcLTeVJdqCgL0EisHBH6NlFpbt?=
 =?us-ascii?Q?VpkGj5UutLF2eIGYuJQBbDbd6nxT429Uzi2zDc+B6ZmgggumGq4yL9hrdzoR?=
 =?us-ascii?Q?ttrIHMSFVeL029YNZjKGWQIYaTqM8Hh7/8jR7+y1zzgCUC7NvUQpgrifr9Kj?=
 =?us-ascii?Q?JZ2mkFSCmACXpMaA0ad2QLkkG2819FnMuIPXrVtzAdHdNrm5Aymc0DdowxBn?=
 =?us-ascii?Q?I0YPTOIefKEuCjQjZTlwwdJ4230puy5ViydCK2ZZs+KPvDe9t85p77a6iCje?=
 =?us-ascii?Q?62n3/VmSStDui66R/60tZ8bY5Xx/Tn4Kv+w6RVQOxH/G8ecyos86+sEgY2d2?=
 =?us-ascii?Q?aSN9vT05JjlXBmw/R9AWC3hvtm37M2fubN1A7A5L046sJnVRmmzBSpfUSA3H?=
 =?us-ascii?Q?gvFwORATtrVU7Qwm5dbmqdmT1cX/b1dxyGX7TDP1lGHr2sJrAM0NgF3mSalp?=
 =?us-ascii?Q?xlphTnwgBmTXhGuRRVPDh5v1eFnnqKlsAblaadkDOzWJF1lkK0BYvrvj+cUK?=
 =?us-ascii?Q?hmZSQ+f7HQQ0sHn0EMMNaQ93FUbp2z+GzPB1TJj4DhuiJxhM5nyi3Ewx0AgR?=
 =?us-ascii?Q?wMrg7T3U82RZx81NmGk6XrW7dHc0rOCbb6aYh0Rg8zutQyWPdiWye0QWiLDH?=
 =?us-ascii?Q?43OuVijXDkV7hFrN1qSqdJFEp5Z5HafgizDwNjCk/vqV5sHnF9lnO+mHHzJm?=
 =?us-ascii?Q?a+m84zhzv+vZHei7PGaE9n7PL1hVQmoxLsj/RJeG5CNNPAQ0vI1Sw5AVchp7?=
 =?us-ascii?Q?yj3KO+uQq4L9R/CM3qHmxGkIB9s8Z5WDMxZWw07sKpJLoGN4eV6ChCObtbXY?=
 =?us-ascii?Q?85CjKYsjvTEOa6opvFrpmfM/dmRRc9k8H7f/hB7QH45MxgqupefAVxdHpgda?=
 =?us-ascii?Q?4qWorwkh4+XFmkKQ2zystq5ud5UcX6DnVMfyugpSvM8y5xmqXa8zk9Wl5D+u?=
 =?us-ascii?Q?3QgMim/9Ajt1MNwuJ4rFzXdcNigfvJxPf9n9+sg7YYFn8XK93AyMnw7KdE0Z?=
 =?us-ascii?Q?QUC6MzAkRGxhyNcBifeT4SoegEe9XO0KqEPYA/0cIILDgz6Zu6g5q3kAvclr?=
 =?us-ascii?Q?SbZLksvxBkX6Cd9WgBGOlUZCmd9b85EgCs5xYEB4x1VD257Bbk2tJ7wSagDR?=
 =?us-ascii?Q?a/dH7bP1YxEHo7PZGrlpGxcjIoxdHKgBIo0vZBxXOZxr1My2DETG6r1Sfqv3?=
 =?us-ascii?Q?lDeqTRfiuQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0817836-4efc-472d-55f2-08de84226e3e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:40:54.8469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlqTSWJUdeBYTGV7PYXRS9L7szD+7cjsvpE6Mwb4Rp3vlDfDpPBGRuPn03C+TUpGgH4BsW+f5PodxHxDh7S/nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10907
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

On Mon, Mar 16, 2026 at 01:32:48PM +0100, Marek Vasut wrote:
> On 3/16/26 9:15 AM, Simona Toaca (OSS) wrote:
> 
> > +After successful saving, U-Boot clears the data in volatile memory so
> > +that qb check fails at next reboot and the NVM isn't accessed again.
> > +
> > +There are 2 ways to save this data (both can be enabled):
> 
> Replace () with , .
> 
> > +1. automatically, in SPL (by enabling CONFIG_SPL_IMX_QB)
> > +
> > +- this will save the data on the current boot device (e.g. SD)
> > +- other configs specific to the boot device need to be enabled (CONFIG_SPL_MMC_WRITE for saving to eMMC/SD)
> > +- use for: automating qb save / saving qb data if using Falcon mode (skipping U-Boot proper)
> > +
> > +2. using qb command in U-Boot console (by enabling CONFIG_CMD_IMX_QB)
> > +
> > +- supports saving on the current boot device, or on another, specified device.
> > +- if flashing via uuu, the command can be added in an uuu script (boot device needs to be specified)
> > +- use for: saving the qb data during flashing / controlling the NVM to save to
> > +
> > +::
> > +
> > +        # To save/erase on current boot device
> > +        => qb save/erase
> > +
> > +        # To save/erase on other boot device
> > +        => qb save/erase mmc 0 # eMMC
> > +        => qb save/erase mmc 1 # SD
> > +        => qb save/erase spi   # NOR SPI
> 
> Can QB data be saved to arbitrary SPI NOR ?
> 

No, this SPI NOR refers to the SPI controller selected by
the CONFIG_SF_DEFAULT_BUS and CONFIG_SF_DEFAULT_CS options.

The point is that the device we save the data to is also an
option to boot from, otherwise the qb data is useless. And the
board will boot from the selected configs if one boots from spi.

> Looking at this, why can this QB not use the same interface to select
> arbitrary block storage device/partition/... that e.g. FS_GENERIC does use ?

There is a limited list of boot devices. By keeping things the way they are
we limit the usage of this command to the actually useful boot devices (and
that we also test this command on).
