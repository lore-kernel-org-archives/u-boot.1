Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4C6CD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 11:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BFF78486D;
	Thu,  4 Jun 2026 13:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Avp6IJhd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2AE2848BC; Thu,  4 Jun 2026 13:54:12 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4CCE8486A
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 13:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xS4pncGCNqF+TbN/WqRlEpV7ypfxbOK4BxLGsL6TLqcGMvxUGI7eAMakiwQSqCwHCN9Tz+IBf3tqCZzp+J1cnrQ1M4Pb7qPa/XGO1QHUBp6EVSnGZ1bNh5vxjTTEtU4PUaVRakl+tXJHPk8a4HPaXhQiKzV1dS4Cmeqt4PWJQaropFBJy2mx8KFSzCB/Rz8pCZkbN01DdtK23S0AFe+f80KOrXKfiE3lznPz8pLt2IHWqneKqYbAFiEfN6RqAg05I5zsgYHjZGxCANK7EB2iR1EUbesZvwyXOhtFvxpn0/O2/0g3e0AksD3KHkomXNrKqpfNk8sI1KZxN5cNnaE12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzyk33KKna1INYWh76sL4O/gm3PN8q+9BMmdK+AyHxo=;
 b=tdjF/mBPW02GKEyoBCWbVu9ZuccwRP5DAfe8T47Rs4tdmroaxKLwbvxFunqolcNTlLfehknxCxWSgU7GwAFeEc/tm8O8tZ/gJP/hDqQ5yavO9HcrwgK3JLTvxspVW1WLQp6bCIPc5Iq0QMrlvhICDXr6usVUisVLWUxNAHbJADFrfxgZhSnKRPk0Vt0NVdNYpZHgWY9KB5jdHPJd0vd4T3kB9lOtIJLbI8dQEYiH9MR4mWMzXQJnghh5Na+at1a9ldqTPZBiDUgRBdxIpiFQ42oN5P/uwm92TiyqAriPx6dAbobwtgTP6/+BXso9Ly0W0W/LZAdvwY3pT53rOq/cvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzyk33KKna1INYWh76sL4O/gm3PN8q+9BMmdK+AyHxo=;
 b=Avp6IJhdD88Q8/Hkt6N5vHOAO6S44KT413xLMSrfgHAStF2NcS5HxJoZl5DR/VDdYFWFPb+MwKOG+VluHj06VzpLYzmHcLkVKCU3iZidI4eb3yPW7rL8kljvSV6B4pdz+0PlrO6G2smgeMHrqYZ9U6XK+vITrETjrZrxLSby+YEwKAPA2ctwtOoNWpSdDARiRRCSHJ8O2Vkv1bofufT8g3pdFt+sscxs6XOpmmZ14lLLwjh27I23wzWqFKSh+6QVuQl3Jash8b2zO79qrKafNzblxd4hV5Y82BgsY/FLohfsdCoHmGdh1R5M69GglkLbURimgaBsMMDkM0Vq1jWkTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by PA1PR04MB11472.eurprd04.prod.outlook.com (2603:10a6:102:4e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:54:08 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:54:08 +0000
Date: Thu, 4 Jun 2026 15:04:37 +0300
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, 
 ye.li@nxp.com, simona.toaca@nxp.com, viorel.suman@nxp.com, fedor.ross@ifm.com, 
 joao.goncalves@toradex.com, ravi@prevas.dk, ping.bai@nxp.com, ji.luo@nxp.com, 
 qijian.guo@nxp.com
Subject: Re: [PATCH v4 1/4] imx9: Add support for saving DDR training data to
 NVM
Message-ID: <ztfrnuoiq5ab5im4q3bhiicxwkquds3hopggh5xjgbpskqldav@45vjod722rik>
References: <cover.1777536451.git.simona.toaca@nxp.com>
 <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
 <acfe5311-2ec4-48fb-80bd-55c11931b377@nabladev.com>
 <4phebvxijyyk5yd4p7omjlup3iotsqgp6r3kt5aiwgimwg6nyp@hnl3qq4imsf2>
 <4dd5cfbf-18d3-4411-bb02-c746611ecceb@nabladev.com>
 <9e3611ff-55f0-4a04-864a-935e6c7a3623@nabladev.com>
 <doqobuvsxnnhfyey4ly72shhxue3g5pnqfybc4k6jaiawld3rg@rb7srjxsb5i2>
 <295b60bf-d027-4587-b808-c7d71b64286a@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <295b60bf-d027-4587-b808-c7d71b64286a@nabladev.com>
X-ClientProxiedBy: AM0PR02CA0126.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::23) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|PA1PR04MB11472:EE_
X-MS-Office365-Filtering-Correlation-Id: 7087a22a-bf78-4a5c-b120-08dec22ffbce
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: X5vU8ShjYbwJFQfF3HD9cNj6CR/HDCBSd/pDZlS7x4yqex6/HYaSVKASFd6GKn4sV8sSwXd7oU4M0co0wNHswvAMbtmGOas7HC9ppt+cO7V2r/fjukf9KNfhjomqVKF42T1XWRGq4FngOI9/SJjDKEmR2o+AdjDofgMYngDXwjvasJ4qiUtvmsSa2NAwJeCepU+5cMy9HPYJLJA3l0e1fH+M93LxKjCgz2QwDncWeOQtWz1s5Qrx+E0Hh14GIe0sKDb9BjtAp9Sso5eukgOqti5Mi4g7IMOHBOK3Q9cSE8An2HgSKDFoC4q3rr0iWYU9feXfbIoqd9f71nS9j4Vfm7uyg2qVevLZKvb2jaDR9qNAyx/rLELAm9KgD75hUSoNQOhncXZb+KyUJ86qi5MIzX10C9PCole3jWOnxcjPiANG0oTD/m2WbsywzN8cY/rv7sQfJBdskcONB8gectngRUPV7aCfwUIer9qZpKBdAZNiPqgjshc7LBaAaZhqvTGSIzOvYmLL8aySpjOgA0DcNgNCXfAb60RZ6//Ml19u4UJNtJxTLxcVT6Lt+vJEsTqy2H/I5MBxpfr/ang5/v0g6s00djGLnjvQmJR+qPeQpFHNLX8o7HPOxqSS4lcDZ1TchMIfKHOuwEjc99MWWdWQeZG7jBKY3+uiHP26pp/CJ1CmpLKUw3vf+eJNErChm8be
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zh0EMCYwiIFfhIGrOIR+vOaF0Zw03zUsSOK+adQrV85BEIWrGYIROKNaFNGR?=
 =?us-ascii?Q?6kH5/YQqw9rdlyPiiP5SRl6KAGnvHiywiyUu1uRidZ342xgD6ltleMDZOGNd?=
 =?us-ascii?Q?KyJvjiOF6OdBoduaomgNBnpDlm+i993/51JQmIgNyl4CIGdv4jz6QezFQxLI?=
 =?us-ascii?Q?E6bFLh8vAoneWLA5gmthgDE6xl7ItxMnKt81EM5/Pbi9woUoZWIvfxkhgwg3?=
 =?us-ascii?Q?uiH7MC8xgL6SyEdP6RiN7Zd4EkKw3yKYDURIJMFD1NpOO1Vs90r7jcz+XXkG?=
 =?us-ascii?Q?mmy/6hljvmvBKSuC8Lwc00Ll/JGI5Pg7cfKL3mpsiXT89so68CiAIoDaWrfn?=
 =?us-ascii?Q?vNYa2blqaKBzi/EWNzGHSaTn3WtsSEQdM9NUKs+yOiJDntFFicjlYHO9Z3Uw?=
 =?us-ascii?Q?K6t76quFz/IcZ+W78jd1izjP+5PhGUskAG3oG7PxKiuu6S2H+InwSschQh2+?=
 =?us-ascii?Q?rY2igh0FG/WK7XPQMEIcVNEPLSzh6A0ZN9UvIGfw9Yrw3OmSYLIczQj6VCht?=
 =?us-ascii?Q?vcCVTmOzCvBJo3gqsolvUANdvgE0+gDGUwQzNLME+LVwyYcYPit01Lg8vkUR?=
 =?us-ascii?Q?/RImWaNlfEB/x3CSn+bzQP2fEWCHF57BMifpiPiIVH3mxaMgXiTCZJPuYK98?=
 =?us-ascii?Q?j/P5AtUk3nG+rHyrJz2MyxjyzaGhimZanMln7PTfgpq8TFXhs6vO5kQG12IX?=
 =?us-ascii?Q?QwbOeWQhRpGDSFMr4+yagSbKXaBoaxnTYWVuL2VgXKfSVkiDQupsAYvSc87z?=
 =?us-ascii?Q?og7XAES+WCaQTRZHcPw6eXY3eXzE1WL46EGBVlAlYTxWvdRlsQpSuNb/yJgc?=
 =?us-ascii?Q?xAqc7XvXKJt50uX52e//cImSl2i2QcjabAccSWToODjkC2JzHMg2369P7hdC?=
 =?us-ascii?Q?ut/5Za+ZcUIE++FRJXWT386aClc+LeZ3LsoMAoN7U7sEFOI8mzUFfso8793q?=
 =?us-ascii?Q?edQQ781u4vXAr7h7O/j6vT4+wImUTd3V5owVlD+Wnm74RSfAqM0pR89rrGS1?=
 =?us-ascii?Q?ceDea2HU/GMJbHzbUMK6F5ZJ5/Y6X3682b3Mvn8oImE1Tct5kGsJHxWlUR27?=
 =?us-ascii?Q?lJPt/dmHcUhrUuaNWCtoin9WuZ1QJQ1mBFpuSW96mvKWX39g0Em7JsFp/3ZN?=
 =?us-ascii?Q?9wQnKWZFPU9hl8hOWMOad2bheEkBg4niV6qVPrCV/WN9/AJE676MZMQElrYm?=
 =?us-ascii?Q?w+MSedKFORoPRqQptgflgb8rUKEHHVAkqZMBIIJIDoGbWq+drAr0DsgC54F1?=
 =?us-ascii?Q?FYdiVJQWCn7EgnFSRYXtmUC3Y/Y+jROv2ETFkFGF+kDsF+y8m5TSJBLZ5fzA?=
 =?us-ascii?Q?wfhp2cfjbHCBdZfU32bTo1ab8zulPkP6Q73bYnvvwGuMh+tYMwdramMd1uKR?=
 =?us-ascii?Q?KUd2F2deVDB9ESLTYb3555/qcky4SIT93aveh8K/pPoxVWumYpq7qugVEwb0?=
 =?us-ascii?Q?ITQq6iDru6KCkXIUrFWPfCc34j0ACxB9cnZORFB6VEtDrYXKsB9QJDjVAYWK?=
 =?us-ascii?Q?XSdEUtAiP7LP0tvgzkrq8yJ7NAgcThA00MOymxlpeSoeUBdavGXb4kr/3lDI?=
 =?us-ascii?Q?8qIiaOsvRnC6MjJdUsJEwlswhpzTC7A9ZoQw5GmiM89q+fScwyn4vjkQ/8GH?=
 =?us-ascii?Q?NZj5/fKfzJLHtZFskj6LhJsefzWEpWW/JW1Zr2CyD9PzHECg/Kg9r1vyz5Sg?=
 =?us-ascii?Q?gbZ6hIm1ZN/6qqOLNd4msYM22arXvjCYByZzrjgytx3pOuWo7pjneySaMaZG?=
 =?us-ascii?Q?r9LJP7IDBA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7087a22a-bf78-4a5c-b120-08dec22ffbce
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:54:07.9641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbmzBXst4mu9CSZsUQkJBKx9cXDOLdZuOfelh8J9dNlQO3HnthgUDZetTlxYMcPqlRPWNo7wSJB4iRVkyL+UCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11472
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

On Wed, Jun 03, 2026 at 03:53:04PM +0200, Marek Vasut wrote:
> On 6/3/26 3:31 PM, Simona Toaca wrote:
[...]
> > > It seems that on iMX95 B0, the DDR_DUMMY offset is 0x76400 (aligned to 1
> > > kiB, which is too low):
> > Yes, this is indeed too low. We align our DDR_DUMMY offset to 0x1000 (4KiB) in
> > imx-mkimage, I see that here is not the case. At the same time, aligning
> > it everytime (even for eMMC/SD case) to 64KiB seems overkill.
> 
> Are you testing this patchset with upstream U-Boot mkimage ?
> 
I tested it with U-Boot mkimage on SD/eMMC. For saving to SPI NOR, I was not
aware of the 'fspi' option in the dtsi, so I used imx-mkimage, not expecting
things to be different regarding DDR DUMMY in upstream U-Boot mkimage.

Thank you for catching this issue.

Regards,
Simona
