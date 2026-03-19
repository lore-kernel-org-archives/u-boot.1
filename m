Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1F51090237
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 15:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E80CC83D71;
	Thu, 19 Mar 2026 16:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="skBXmTkG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0144283EEF; Thu, 19 Mar 2026 16:05:52 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2AD283AC5
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 16:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaGdXJSX1YS1Me+GzF7PVWUakAZiFYaY0sl5NqX71DjIJ6iqWjmTk1/xVBNKBZmudZXhCApx3Vrcs74m+oVhEZEV3fTYC4QbbuyQ9NN3vTOba5Q1nNzVEYrinTuxxT0SLjTP5kwIISFW0mCLiped8jj6cnR6f+O7XIV9OUqabyhJQvMa0ZKO645ir/DLVAKSfrSaK7RjqZI198rsYsOCOKuM/XIM2NNScV43MpOrk+WN1LtstMG1zWGMFBXZuP/nGsm0mFJqc+87aQQJHsQvqHW4wFEoo8glJfqAowI8VcHz8jHOfsTnaSQ31qDqzm4QGKbKuYWRD6ntaiHPkIWVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EQ8lLR9AiwTP174MxMzr8ZSyGGEMsRFyvHWNZgzDCw=;
 b=assFvqcIpZKYHPy/vVgQEO68hvWwGXMImqACXu3Pz5HIk/tE1ARFl1T+T3judLGOOBxlLXv7VfHToq6ZXOnI4Q6xqMSXEbL63xYoVJDLAi8ref8llXmD6K5vgGtkAeDHTxUJx3pbgsvm82C9QaHuKUW8AVZiETlrDDqA49t7O0Li0g8Jv4/wBm+XExCGrRUzp+6ol6VINpyzAw0tvYoSlfYpzwOM1lpVVkm/XG208tut7bUs5ujEdxg0JbWO08vZ7WjSfsqI09oaHePCf8xeIA2kmGvtM6j5w1jxoMQPykp+1McuIx1rO6s+PZ6hqLExW5TVGVxd7oFGxNru/UiSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EQ8lLR9AiwTP174MxMzr8ZSyGGEMsRFyvHWNZgzDCw=;
 b=skBXmTkG7egqCbOrDQ17uWHBcp0Gr69VWGkJ5DoegHTDzcj5GaamTn/ECj4dKZ1+nhkKDZF3GQ/VqDaC8C16KHiCgDK7SGBoUkKsvL62t/3kkfj5O9o1LeecK7TxKJUkhP1RpDwJpCXJg0CFu8rE0M7uazDHNobNQ3bxyfq4cU0GygH2LYLAeHhfTXGMaCVVoBedH1AbN/jnm8riKqzVD1EPNBPSa5pdfPXQZvu0qJjMDohpxMSfNvR4Z8Rf7fT9UNJV3FnJYv1+HMd7MrvbbO+ZkdNAwraVMA/0urQftx/AfQs9U9LYNryQkThrYVkbhaof25r+gK5ay4ES+AtWPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by AS8PR04MB8995.eurprd04.prod.outlook.com (2603:10a6:20b:42e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 15:05:47 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 15:05:41 +0000
Date: Thu, 19 Mar 2026 17:17:35 +0200
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, 
 simona.toaca@nxp.com, ye.li@nxp.com, viorel.suman@nxp.com, ping.bai@nxp.com, 
 sebastien.szymanski@armadeus.com, ravi@prevas.dk, joao.goncalves@toradex.com,
 ji.luo@nxp.com, tharvey@gateworks.com, qijian.guo@nxp.com
Subject: Re: [PATCH v2 5/5] doc: board: nxp: Add Quickboot documentation
Message-ID: <7fg7jj4rou4ke7nkewytibvcz3oehxtot4q4apq2uhtz75a2gp@uvpcobhbwu33>
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <be6b07edb38e4e0dc86e65f8bac7b6b3b0e29d01.1773648510.git.simona.toaca@nxp.com>
 <d3b42af1-65a8-401f-9dda-1f79cb0dde9a@nabladev.com>
 <yuwvhik6p6eordghidde6l4ey6fclwwuxnzuqpttcoicxqa2r4@jpp2t42tl2wx>
 <541a05c0-e0f0-43ce-b944-d7656da585e1@nabladev.com>
 <becryuzd7ohecs7vq2goxhfv5fsrjh6a3ctav77y4uxrszzecd@wsnoc3muqoit>
 <78c40910-a90c-4cef-ba72-4e4cdfd5abe2@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78c40910-a90c-4cef-ba72-4e4cdfd5abe2@nabladev.com>
X-ClientProxiedBy: AS4PR09CA0028.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::16) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|AS8PR04MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: d94a9559-e6ec-45b7-8f4c-08de85c8fc4b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 58VMq1NOE1S8gP7mthbDP+vaahmSNVoun/UJHP/FEH4GfgrrR4PRmEdPaSDTtWb5nhG788ledwXJOZPti7+WGizFlPn7Y8Qo8aLr/7PkVuAtVAXJukbXcmcvlABTyLng9hCwMR0J7xb/JuaiiG7cTi2CUGFQm+hHh3yqyUSuWALPxarMKZAJa7uaQ7mmYAjHDd2UPgEFG/Flm7rraUqJEpEG5sIEACsd9Y4cODt14kh4OleD8PgBqoJpxB18K753yuXT43K5WLRrsuYvGMrDpfLGOO1SXxMdWthxgM5bCjQ0Pw/qKtV1EEI8MSF+M0UrzJl+qDIhKsOBiFtBE9JIyW72zr0TXLSrfAutWgE9VLBhUWpyeSIKSkfdv9geOBSYN5Z6lXej0Zu5DD3aIqMsyx0fH/Rp03JCoFj1357lSsf0FkZ3rAYM5PKEtrfaoSpXTnxjIuyO+qLra/y+jmZidS4Mup+RbdKEHnUHvLdhvUyzcDfARUKRFJGLd4A+VBX+cNE0hKVb12sg+Sa6QOu98WqWOc77Jq7zwM9w37EMw6B0fu0kv5xZVrUAfKHvhOKWrp6obWkx9ELKkviGB6SO6xw/awekaZlmVhVU/oFF75XMYWm3FsWsB9WO+LBg5n2sN1aWce5q4J2cs20oB26iTL9vA398n64Xhdbch/11W4nCa6W0+sqbxi+GXS0o1OGSVjqxDPBjKLhuYnDxv0q+wpLhAOEduzf5u1YCQqvjQO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FCGhH9wqnBTgtZ9nVAcqVpOUjXoQ2khBfCxsedTQuu0ku1q/IaOkZQcYbbpA?=
 =?us-ascii?Q?tBWJA96ORiE76l11kjzqk5uxJ1xT8XmqwF9CXGgOPaTLeKmoslIz+3TB/CE/?=
 =?us-ascii?Q?umlRg+T46xVEZKN2y11+IU+gC5aWPePGoN3ESdqVYSgSor+THlAJh2oQMFwN?=
 =?us-ascii?Q?+PTsVioT4228SzBSE9HM0Gff0Qt/1iZsGg9hVwP1FXSr6Inz8yhYCA3bPH3t?=
 =?us-ascii?Q?uNYcUpxZ7gMkc1iQr78VN6f7xkU20nnISPYfT8rXjPqlZlGGeT8qpmi4RfwR?=
 =?us-ascii?Q?ooTPsoFttC26g+UGbVD0BPOvq6KtJYhQL6rK0drjGLsrD0aqVO8CDnEHxP+j?=
 =?us-ascii?Q?olNemirz0a6qVLrr4Ig31ndbf7YfPYDNlaDTaNLPIlgKIkPCgFiBe5Up15Vr?=
 =?us-ascii?Q?Stt+It0Oyi44204ihUvxD191tuwX4zPJAwumfjSVaB0IallRL9GlqyriY6IG?=
 =?us-ascii?Q?XEKw3okBYW+oETO1l8Jz0BS3GXvO2QXJYJgeOL85qeWhPUI8VEfcP4sKaubW?=
 =?us-ascii?Q?Oe+g69J8LPcHW7+HDBvXHf6MP8eMcBtT6syyI6NFKqhftuNuv6UQQqOUqesY?=
 =?us-ascii?Q?m4m1QCW3UiveqbOPg2E2xpBwEsjGbqhqQI1c/oc7mqtbNsc2Y8r98BIdG2XW?=
 =?us-ascii?Q?jXhw6cJXjiKkxkd6hRWkk/VDxkqh6lgypxFmD8ixsEwA+VoiTu6G6F+TqY7+?=
 =?us-ascii?Q?n365wktYwVOpsEe3ZEqeSJFigyHDwlL+dJlkiOK+j6fZS8LcgRHv9qJNXnoJ?=
 =?us-ascii?Q?I/6sEA8KefhkKk8YzXRs8ho6NDWaidSO5uvTSFr08u1c8JU41x0g7qY5RfAg?=
 =?us-ascii?Q?IYW32zHnKcnFvxWIylpBj6pynOXyNydeBTCxMpYlvw56iESyq+W44yhT9Z3O?=
 =?us-ascii?Q?tkb8PzNYmlA5AZuvgjrWfGF64z8WJ8siGv/A7sPfc1ojM33fJx1S3PAyN+qN?=
 =?us-ascii?Q?M0lTKGbST0gbsk4/PMAZAe9UCsSfyx7ULhrCGBc0IksuFmJwpY5gE5zyxInK?=
 =?us-ascii?Q?kkXEXGV4ANYI+04FW9cmQz9oTJIuwvnUPe4E0no7PcWM28m4vjufLozKlSaF?=
 =?us-ascii?Q?rj57BHufDhYs40DjA4IQ92ff/YpiPT+lEtCQTctqm2YFW6pHc9LgFXUN3U3v?=
 =?us-ascii?Q?STyOFLmtbRT+BUIjsrl/8kDZZWCslQGsimye1vrwNme2xSIwEUz65rmHzjFD?=
 =?us-ascii?Q?3ld6FjH/JROhyqglnQ25LTlWemAwwv8yTUYvFoMiCNJ86q19fOS6s2Kx/Bgx?=
 =?us-ascii?Q?/xE6q+UoMnwagANMH7Ke6h/VbywTwwS469EhN2gfs1xVTL54icNluB0dBfI7?=
 =?us-ascii?Q?FuAcV/Rru7IhE6CMngIb7aONuU6sFL6d8K6MibZ0uFbsZKkmDEzgiBpJf6Fz?=
 =?us-ascii?Q?5Xai4OBHO7mJH3ylMV4gSWjBSg2cwi0DUgKEH4cem9iHXgrUyou+SUEjUAJH?=
 =?us-ascii?Q?wC6pI1B5iLLmw6+n2xMWIhBdNJBPDQHa8jjWJJ9swxy8con+YbDfWgDurHSx?=
 =?us-ascii?Q?GUKmD5vim+ReeflMsWRSklYCQnjJEl+8d95djUbc1/vzzW45OuSzYvzrsONa?=
 =?us-ascii?Q?6tEZqw3Ap2QbK3sV76VFCl1G6uabzagfKtvPPRPBqHAlwXakTWP1hykyJLno?=
 =?us-ascii?Q?uDP43HrlXsY8cYodcA/XZFoNmAFvwP/qvT1L7C5clekt/5LG8jfpi7xKz5tw?=
 =?us-ascii?Q?4GhoQ+xKGdLlc+5Mo1TFTb10hguW0l9DtpOpQ+E/0EEfQmx0vedoA4UBbtnC?=
 =?us-ascii?Q?bwJH4sZ5vA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94a9559-e6ec-45b7-8f4c-08de85c8fc4b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 15:05:41.0164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swGQ9/3kLxmr6zcT4036fNjtAOQU7BgCOLSQ+Xab5oLPgzKQP/eaq/2yxgnKy5rhYhFiGR0Vnyp5O/iL0IyEUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8995
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

On Wed, Mar 18, 2026 at 09:32:33PM +0100, Marek Vasut wrote:
> On 3/18/26 3:20 PM, Simona Toaca wrote:
> 
> > > > > Can QB data be saved to arbitrary SPI NOR ?
> > > > > 
> > > > 
> > > > No, this SPI NOR refers to the SPI controller selected by
> > > > the CONFIG_SF_DEFAULT_BUS and CONFIG_SF_DEFAULT_CS options.
> > > 
> > > Maybe the user would want to make a backup of the QB data to another SPI NOR
> > > (e.g. if the device has two, which is not unheard of) ? They should not be
> > > prevented from doing so.
> > > 
> > > > The point is that the device we save the data to is also an
> > > > option to boot from, otherwise the qb data is useless.
> > > 
> > > The QB data could be stored for backup purposes, that is not useless.
> > > 
> > There is one thing that might make this clearer, and I forgot to
> > mention it explicitly:
> > 
> > The get_qbdata_offset method searches for a 64KB hole in the bootloader,
> > so it can save the data there. OEI knows that's where the data
> > should be saved. On an arbitrary non-boot device, or, on a filesystem
> > partition, the hole would not exist. It is mkimage that puts that
> > hole in the bootloader, and U-Boot explicitly checks for container
> > header tags.
> 
> Uh, is there any danger that this might accidentally corrupt the surrounding
> bootloader ?
> 

No, the space in the bootloader is exactly 64K, and memcpy uses a fixed size,
sizeof(struct ddrphy_qb_state), which is less that 64K.

> > If one wants to store the data elsewhere, they could use
> > the generic fs methods to make the backup wherever they want, and re-load
> > it themselves to the QB_SAVED_STATE_BASE address, so that U-Boot can save
> > it from there.
> 
> It would be good to document this mechanism, esp. how to locate the QB data
> in RAM and how much data have to be saved into backup storage.
> 

I don't recommend anyone does this sort of backup, although it is possible.

I don't see why one would do that since OEI runs training and the data can be
saved then. The data is board, ddr configuration and firmare specific,
and I wouldn't want to encourage someone to think they could save it and re-use it
just like that. Why not re-run OEI and save the data (by using SPL_IMX_QB, for
example, which does it automatically)? Or run the training multiple times and use
the cmdline qb command to save to all the boot devices?

> > > > And the
> > > > board will boot from the selected configs if one boots from spi.
> > > Please see above.
> > > 
> > > > > Looking at this, why can this QB not use the same interface to select
> > > > > arbitrary block storage device/partition/... that e.g. FS_GENERIC does use ?
> > > > 
> > > > There is a limited list of boot devices. By keeping things the way they are
> > > > we limit the usage of this command to the actually useful boot devices (and
> > > > that we also test this command on).
> > > 
> > > I would argue that it is better to use generic code instead of hand-writing
> > > local ad-hoc implementation which is a limited version of the same.
> > 
> > In the above context, using filesystem methods might not
> > be feasible.
> Look at cmd/blk_common.c , that is not filesystem, that is generic interface
> for block devices.

I looked through the code and it seems that the driver for the storage device
has to call blk_create_device in order to be able to use the blk_* commands
later. MMC indeed does that, and some other drivers. For SPI NAND I could find
that mtd_bind is called and that calls blk_create_device. But for SPI NOR there
is no such thing.

Is there something I missed?

My implementation is also aligned with what happens in SPL for parsing the
image containers (see arch/arm/mach-imx/image-container.c).

Regards,
Simona
