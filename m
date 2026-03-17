Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D771FED9E3
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 15:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B26F84376;
	Tue, 17 Mar 2026 16:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BsQvlDA5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8620D8437C; Tue, 17 Mar 2026 16:16:23 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80EF48435C
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxOaW7b3ujCj5Khi4yz6vio2EE0xPdvuOXk+B0OvmsCR5nc/YDivgEnaiIT7xArBTdgD5WCoKpbHDsm+rr9EZUivf7pEwTmdQ1VtLsrHhsNvWPDfQ/cmiMVElBEXalpVUEvZBHi/zSwNKRCbVFkON9pDke9HEzdRzM3IiZoUUKna4nDwT7DLxMYbnDZ127w5XgqfP4syvns7INf8++PgP1RG57rjWAZwtBp7S51coxjUCitnDcdg8EzYOwjt5mklJabgTYT2799c89upCe9KYl+qKlPHChPHQj8kUon58xMoahGvPXjB7BscKeZWDJJxg+i2Vto4WPNvl+mxhWkAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cm5hXLaEfOmLESu92en38iULDV7J3oUkb82akq/VBzE=;
 b=P2fxKAEERCs/PEZ4h8HzqPTJ5fdhVgbBIMKRG/ghyG7G+DD429XzAiwevzr2t8myDl0LknGSrXbCnhS5aI0taIL+oCpw9L5u5EkslCVIDlMI7JhAa+6RayrbVA1kMKj7VSpjX/EJovLUA5iECa8xSLTQgS5KtpbRQ0FrLrMHsqd9Fog8Irurf4L6Ru08yYk8EP9KB53T+hOf6IWQz38i/9VqvW+cKgywTFPGNZ1AWFGxH8j+hVbWufiR8AijwXROYtqd3CPG/IJq1aM5f5YGwsgqnkUwp5Ghu657fFlMVxOZCRFtd4k9zU0aw1yOc8FDaF+msErkvpsKWOoA9fZ1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cm5hXLaEfOmLESu92en38iULDV7J3oUkb82akq/VBzE=;
 b=BsQvlDA50jinoSmi4+biK2Ni+YOlUGDUcw1efzal0xRLHikM4SOobEYZNx0r52mzYotF7dlk9TnJjEyVhzdF63w30DOYQ3U+nBYXRNQGNZrdrEDuSG3KZ3FzxKExqDXOMVqxHUQOxZZV8gwXiyuOEN/vV/ZgTzj0aEYbN7ExuDgxSQk1MzcBeatKPe4yh2EvqS9SYUpDR1QDRBw9+NQzvmLiXXFd2hpAwAphN1hlfm0C4uHUdqUWP0TzH1IukDR0T+ODsTtSHs8njxTPlDQ2K7zye8e0PiscO3F3W8NXW3EqGc63SBN3ZNOGKK2BCGw8tgfjZ0ZWIJnAXXYwVIka0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by GV4PR04MB11902.eurprd04.prod.outlook.com (2603:10a6:150:2e6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 15:16:15 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 15:15:48 +0000
Date: Tue, 17 Mar 2026 17:28:04 +0200
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, 
 simona.toaca@nxp.com, ye.li@nxp.com, viorel.suman@nxp.com, ping.bai@nxp.com, 
 sebastien.szymanski@armadeus.com, ravi@prevas.dk, joao.goncalves@toradex.com,
 ji.luo@nxp.com, tharvey@gateworks.com, qijian.guo@nxp.com
Subject: Re: [PATCH v2 2/5] arm: mach-imx: Add command to expose QB
 functionality
Message-ID: <e4vlh2qtw64fa4kdwdzyt6v7fmtzg3bsgihni7bksfv3bs5ivu@5ucadvhzs6he>
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <2c33ee004dd272b8427b3d1962ade06cbb220149.1773648510.git.simona.toaca@nxp.com>
 <1e3b41bf-b6fe-4307-b6d1-dbc3ce0615e0@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e3b41bf-b6fe-4307-b6d1-dbc3ce0615e0@nabladev.com>
X-ClientProxiedBy: AS4P251CA0023.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::20) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|GV4PR04MB11902:EE_
X-MS-Office365-Filtering-Correlation-Id: 023499aa-70f8-44d2-5ef3-08de843811a0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8xP5Bt0eoExTHDCbSc/8D/DXGyq++RWMTJx9x8meen3TZUyJT+FAWN646Zu99kximcIYizazMCZxuBLNL3q+LQV1fYRGGdd40k6E2R4+pBEUlbkbBa7sykOhhnr0MTDOLWdokWm590ciwwpkoFUmx+s64oo6FwDDQZsdMS20rpmMJNBKB7Lq2Z/Mdo7HLBL+pxVt3EmeOgu4FkvTTVpeMGBhpBOIjkw41EpxvOasPix4deWXLOnyl6/ZSws90+Yy7cCdtLCPMn6A0TyfsouiQUK6WpfhRsTFf9xDGnOILcpxM7ctTm38ehoKEWrdKdi+ijQEnY24kmmtykDw1xkSrKPr6gViB3bjtbcBBN4tZRor87NDEp1/QZq1oJvrRQCEQsKzso3iiih4PgGi4aTaTvKNDxuilHAUVH6Zos7auEi8e2G4I7h3d5qew3SJ5o6KoyVmJA+JwXW0YVkUltb2SZXyDiiMmVZ+2/7TiSTa7IADcT6SsgXTYATiCQaZrsI52h0yG32sfEtqzeWGAyywg5277WacqPsEtkLaRuB4tKIeFlcmXvf/jzW3wjR603C6kSXcN88xG2zUhCzD8acHDcGj6AOlwxLZFg7iqfYi53N5aVdIRelNRf0uWQOvFjDEirCJQK8kgbx3Ly7HPYkMV8bB/yZtmQCqB2eOB7qJRzidxs6PkdiXZ3bq4ujCZYVBt/pGoxxbGq12rv8ZMbz1sJZDO1m9O4IkiLxeh3xSqYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vx6f4wR6/rjM0h3oWvjT0oucakccBbFYS7tanJiWCtuS7Xiu06znj2AMbAMS?=
 =?us-ascii?Q?ZL9ysxJ3/T0Mxsa3o8V+Oao5VIus57RdV77ipr4gYARxOZZ1xDmPTHeWASzR?=
 =?us-ascii?Q?SY912uukg02tcKb92kkjYH5I/lB2MvLGRoZ8Dk7WmzFRWqAO77rLiIakEEH7?=
 =?us-ascii?Q?UhyM2TB/pCYLY6kTTP1M/uY29a90dPZ96zhrAdlwvdKh15lyIbB7FxSA25ch?=
 =?us-ascii?Q?dEUVi+r7ECj5wum8hnVxACXaFWZvBXTIpOuCdP8fS7UOreksJUCsQphH14IF?=
 =?us-ascii?Q?aRL7/KrkYy970NRkJeknoCKRBfS43EQ3NfJKYnhn6TQI5ic1jHmQqpRJIX2i?=
 =?us-ascii?Q?eHalEG2xE8jUxGpMiDWK1CdRDE4kjVSD06KWhqwAYeyoXzEOD/3ZoMyTGQb6?=
 =?us-ascii?Q?lAk5n6nYTXyCz4xLw+P/P78qrxZAoq2+j10y+azC8WjQBi40h4fq05mleuKy?=
 =?us-ascii?Q?PKrG8D9C9w6pwE+evp/DyQ2M/dK2fpTGHdDxjsXy+Y8elj25+voRkzPv6s2K?=
 =?us-ascii?Q?2rjT0CHNvUL6dYgcXYlxQmf7zmlpZ2BcJLioeuF/FxJKamsM/sIubXZd2pcI?=
 =?us-ascii?Q?yOHcV83zIWPTt20/QEATO87QJB+4AiNzLQ042fQ24XG1eZb9OOOiaaObm/QJ?=
 =?us-ascii?Q?PHEn/HmW0c27TDKAW57xpCkov4cOs7BxHjiNc/frYyie9HGz7oEjvUstTsqM?=
 =?us-ascii?Q?EaStXcDCqjn7Da39hfZ3zLfVy9BNiolmro0lxfRFyZsZh0e01S6U9vZrH+BG?=
 =?us-ascii?Q?A6lyo6o9OkpvkuLw+o1pPVkyy1MUKHex1AXVsgfZGYbfik/wxrXYDZ+UAsU3?=
 =?us-ascii?Q?8lV/n2tGEJSwI1IYsomhF2qREbaoB+ANhtsZL3PG4ly02QhayP+0zBpa5AhV?=
 =?us-ascii?Q?+56r7lAPxqOCyQNQas/D9JOjCklH+wby2rnUVcP4GofX9kBawFRTMsxtNJj+?=
 =?us-ascii?Q?9Ya7isPAKcJCeIv56HGaQe4Ns4kQ0KDxKEWpOpSvIRcaoUaMyYm52Wf/4Zj2?=
 =?us-ascii?Q?4h9ScVpP33DccDlMLFu/o6oOEbRD9i73ZjgcmdVQ+bLlCkEQsNQmt78PYjtZ?=
 =?us-ascii?Q?xH7KZjEycFZNDEuEteiuiDWd+jR2u3dDRXdrXv+Nfc8hSBKWQlORYa0Kx5xh?=
 =?us-ascii?Q?CXRhlIMN/RZWcvNB6XWKPD6ex62dlrxWtSBRnUi9FBwjwpmfF6whLWIDbWO4?=
 =?us-ascii?Q?Ecpml+P8AzUIkNp09Q3v+ZNVYWqqy5/iAjhVHu2B13nxaa5+9S+l+Kw3Knt1?=
 =?us-ascii?Q?ZzIjNyaiCcCaOj42oxlJTPsDFjUPxaqSR8gouOXgoMU8HyV1Q63HJu1S3+Sd?=
 =?us-ascii?Q?oJKK1bw43bCa1CGpKQrGYPVCJ/YafSwhneUIJsfJCYq7VfOZhmdHmiJZZxq0?=
 =?us-ascii?Q?r3UmHuktXjWpKBzuFZ3PY9xPZ/FGA4Y7Lovv/+X6T2h6Dh/VFyYmWAUownff?=
 =?us-ascii?Q?RJfnR9IS/59e2hK28QHjIVLIcfguoFTjpsKZQj3z1H37+w4KVVum/aI9HUOG?=
 =?us-ascii?Q?TLjbuR9+yCuVS+DKmwCdtVlYir7xLc0mhb5RjdhWoaGKYvcipwGrXIOAtgac?=
 =?us-ascii?Q?mzf7M4yhGrDtkoeuW2KKuHZWU1RLsCzn+Ys1QWZg3Y9HHBD9wghIvgVXUtem?=
 =?us-ascii?Q?r1NFJs+gydJrWz6e+oMuSm5qk9Yxj6znDErY9JWWq9d2kvENMiqvATjbWLp2?=
 =?us-ascii?Q?bWGL55J5ry9N7E0yjgNcF9RnN6HZMs8aVLoN5YANFwn1iMIicPkGUxClPy/8?=
 =?us-ascii?Q?V57+wMJdLQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023499aa-70f8-44d2-5ef3-08de843811a0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:15:48.7258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7RY+9gA2z9w11ZNbx1Gq0lG9mxKmmpsK+F07rdmVEWiPl5S6XTiTg01v4thN10CndKA0J0D7g5gYRiFZ8KbQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11902
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

On Mon, Mar 16, 2026 at 01:20:06PM +0100, Marek Vasut wrote:
> On 3/16/26 9:15 AM, Simona Toaca (OSS) wrote:
> 
> [...]
> 
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -71,6 +71,17 @@ config CSF_SIZE
> >   	  Define the maximum size for Command Sequence File (CSF) binary
> >   	  this information is used to define the image boot data.
> > +config CMD_IMX_QB
> > +	bool "Support the 'qb' command"
> > +	default y
> > +	depends on IMX_SNPS_DDR_PHY_QB_GEN && (IMX95 || IMX94)
> 
> 94 should be before 95
> 

[ ... ]

> > +static struct cmd_tbl cmd_qb[] = {
> > +	U_BOOT_CMD_MKENT(check, 1, 1, do_qb_check, "", ""),
> > +	U_BOOT_CMD_MKENT(save,  3, 1, do_qb_save,  "", ""),
> > +	U_BOOT_CMD_MKENT(erase, 3, 1, do_qb_erase, "", ""),
> > +};
> > +
> > +static int do_qbops(struct cmd_tbl *cmdtp, int flag, int argc,
> > +		    char *const argv[])
> > +{
> > +	struct cmd_tbl *cp;
> > +
> > +	cp = find_cmd_tbl(argv[1], cmd_qb, ARRAY_SIZE(cmd_qb));
> > +
> > +	/* Drop the qb command */
> > +	argc--;
> > +	argv++;
> > +
> > +	if (!cp) {
> > +		printf("%s cp is null\n", __func__);
> 
> What does this error output even mean ? The user will be confused, please
> reword it.
> 

Looking at this, these error messages might be redundant, as U-Boot displays
the command usage anyway if CMD_RET_USAGE is returned. The repeatable error is
also redundant because the command is declared repeatable.

I have a suggestion: I could use the U-Boot API for commands from
include/command.h (U_BOOT_CMD_WITH_SUBCMDS), which declares and registers
do_<cmdname> with the default method body (which is almost the same as this
version). This would imply no actual error messages, just printing the usage,
and a cleaner code.

If it's not a good approach, I will just modify the error message here as you
suggested.

> > +		return CMD_RET_USAGE;
> > +	}
> > +
> > +	if (argc > cp->maxargs) {
> > +		printf("%s argc(%d) > cp->maxargs(%d)\n", __func__, argc, cp->maxargs);
> 
> Reword this too please.
> 
> > +		return CMD_RET_USAGE;
> > +	}
> > +
> > +	if (flag == CMD_FLAG_REPEAT && !cmd_is_repeatable(cp)) {
> > +		printf("%s %s repeat flag set  but command is not repeatable\n",
> 
> One space is enough.
> 
> > +		       __func__, cp->name);
> > +		return CMD_RET_SUCCESS;
> > +	}
> > +
> > +	return cp->cmd(cmdtp, flag, argc, argv);
> > +}
> > +
> > +U_BOOT_CMD(
> > +	qb, 4, 1, do_qbops,
> > +	"DDR Quick Boot sub system",
> > +	"check - check if quick boot data is stored in mem by training flow\n"
> > +	"qb save [interface] [dev]  - save quick boot data in NVM location    => trigger quick boot flow\n"
> > +	"qb erase [interface] [dev] - erase quick boot data from NVM location => trigger training flow\n"
> > +);
> > diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
> > index 3018d128a36..7dee144e0f4 100644
> > --- a/arch/arm/mach-imx/imx9/Makefile
> > +++ b/arch/arm/mach-imx/imx9/Makefile
> > @@ -15,5 +15,7 @@ obj-y += imx_bootaux.o
> >   endif
> >   ifeq ($(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN),y)
> > -obj-y += qb.o
> > +ifneq ($(CONFIG_XPL_BUILD),y)
> > +obj-$(CONFIG_CMD_IMX_QB) += qb.o
> > +endif
> 
> This shoudld be part of 1/5 , should it not ?

And squash commits 1 and 2, as this is cmd_qb related?
Can't I keep them separated, so there is not a lot of code
in one patch? I also find that this way I can explain each
piece of code in the commit message.

