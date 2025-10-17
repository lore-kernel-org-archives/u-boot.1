Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE27CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 03:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74FDE837E2;
	Fri, 17 Oct 2025 05:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gigadevice.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=gigadevice.com header.i=@gigadevice.com header.b="ZlUiGyV3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 436BA837E4; Fri, 17 Oct 2025 05:58:10 +0200 (CEST)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c406::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A123B8367F
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 05:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gigadevice.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vlim@gigadevice.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2lND242mpsQaRMpmZ4ZisjZ0/zp6Q6dt56nvkB8LGwEPkXjhoMBs1K/UhSQcRZdbsZOe+VH7ZrKYpex9AnDutToTH5FA+X6L30f7K/4q2GIsHyKwdh/TpJplb+svwN0DKFTFdBQiyDhRE2rvxz7tHWRbsRyzZA+3z0ShQU4XkxGSMrs8Ml7xIjjQqFh14qPwpsDs9SzN8V8+XTCc/1EaFiUJVItBsjbjouxlxcWV01xPjgHxb6efRskSUBKnU5Eu2vTfFlpVc5eG59OKx+64NaJvQGvjsrvIbNJ+kqGLc0M9r52BozhxeUzgorlZXj8v4FhV48Zz/cJBkfm0yYjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSql1tOEaplAsUfsQNavRe9MTIRx58+y79eMY63GvQg=;
 b=D1VlikOaLak27NCILm30+aPlNlLBUMhsYz0C1oUijaD+jjxi0/mR1wRh2wyH9QM4gLpmRtcOh2CxM2R+cmBuOkoEmoAIjiFLpxi31jy3KwBdBK8ZLWPg6I9gqgMaMmHHGhs3AWu7lvJ+C7C0aDdwjj4Y4R77vCLf1sl5lacJeoK5MaEFNcTpNON8b02hH86BQHtCAnIE2/YciKjgKceNkPK8ZtIT5s1v+boplFNJik118T6gj0U72bEUHhRse6isQK5zVAMXUzqXN8d9HPc5mtwqUIs05o4bAwO9pGQQOCBn85GSiQhesCGuJy2iEGa8ZSziSpnVsJG1+UkfxnFVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigadevice.com; dmarc=pass action=none
 header.from=gigadevice.com; dkim=pass header.d=gigadevice.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigadevice.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSql1tOEaplAsUfsQNavRe9MTIRx58+y79eMY63GvQg=;
 b=ZlUiGyV3rPYX8ko+gsO9gCCgtTWyOYUNYbAaSxwLP2PD72a6EafAalutSj6Rk+C7J7Y3Hc40IitlsOCXbH+sKPJFHuVSG3GoL4FX3lO6ZUa8/Mxs6i/jAEos2c+Cxd+Nu1rS6JQ5pZNRbuxVexIlKDM6r2s9ySje3UOyhU/U6VY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigadevice.com;
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com (2603:1096:4:26f::11)
 by TYZPR06MB5663.apcprd06.prod.outlook.com (2603:1096:400:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 03:58:03 +0000
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16]) by SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 03:58:03 +0000
From: Victor <vlim@gigadevice.com>
To: u-boot@lists.denx.de, git@amd.com, venkatesh.abbarapu@amd.com,
 dunaev@tecon.ru, han.xu@nxp.com, alice.guo@nxp.com,
 Takahiro.Kuwano@infineon.com, trini@konsulko.com, tudor.ambarus@linaro.org,
 vigneshr@ti.com, jagan@amarulasolutions.com, havish.mutya@amd.com
Cc: vlim@gigadevice.com
Subject: [PATCH V1 1/1] MTD/SPI-NOR: Add new device
Date: Thu, 16 Oct 2025 20:57:19 -0700
Message-Id: <20251017035719.122911-2-vlim@gigadevice.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017035719.122911-1-vlim@gigadevice.com>
References: <20251017035719.122911-1-vlim@gigadevice.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:610:77::15) To SI6PR06MB7813.apcprd06.prod.outlook.com
 (2603:1096:4:26f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI6PR06MB7813:EE_|TYZPR06MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 7caf5d37-9406-4e79-e532-08de0d315eb9
X-LD-Processed: f84ba339-959c-4ab1-9b67-1e43414f945e,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CVEcQFZ+U+BRBCy9GeB4NQ5htZw+NGK4B6aFx3R1KdLQOA0iLtSEdTvTne7O?=
 =?us-ascii?Q?/HXV8oIY3O3ddbj9jbMy0wcHfDfyTB2XymYtAy4vOHBiV1LXjFmqOlGxnksD?=
 =?us-ascii?Q?u6To9/WijjVX6+L+dJPcxmgFwEGwFavjqAtKYGMg7lqlTzcGWjO15ze5vvhk?=
 =?us-ascii?Q?17eb3vL2PoLBlzQMQJ2ZYBRGdnurmKRtNNefqHKmUGLjkmWKxRKvnYvva9i9?=
 =?us-ascii?Q?7BLqXjChVS0dRuGM4W1wQ1XGlnfo+KFNtO7ZR1bnBto9kghT7NbLxU2Skkku?=
 =?us-ascii?Q?t5FwV1L4voaqBBLq+prtjGj+B+WACQQAg9Z0/JcYngMqgOLdrTaRvMhKIaHU?=
 =?us-ascii?Q?gSBdAKOwFJ7aMvkxEftJJFuAghyYbtLz3Awuzs7smCggJfbNWhxv7At6iFSY?=
 =?us-ascii?Q?7sDgU++rVzEVBLx4b4w1OfarwKxG2TA9zSB70OSSd3HZSc6J6ixOVVk3Skaf?=
 =?us-ascii?Q?RP2w+xjCz+rczxEljkUKlOVxNOqnyKRaFl4WXq/08k9gtUB7u+3WZc4CiRem?=
 =?us-ascii?Q?XQ/wnEvxeatonltIbrPEPNcXqhArICuO2HIpYlL4ujbzk/KZl1sKIJcwOT4M?=
 =?us-ascii?Q?OncEjG05uC9tqi8CltgNQ+aJDAkNY35y6MsvQg2IDbZXk+8Ii3E6Y/WcjQUE?=
 =?us-ascii?Q?vxDEm60vL4H3DsGZUwjMujIzDHq5tYsxl5r//eDZ2KD6Dz2x6OvdWWPNR9sx?=
 =?us-ascii?Q?8mVOTf8POY7/2jGH6jQ2v49ukDiQQlK3I794XIzEBpAvhPjDO6IuE4k5VzJg?=
 =?us-ascii?Q?TnwSBN+xLmtpCz6bor8LU2KGAeqjKYTiNpEUP61IbG1HzLEVu404/oS2Dbog?=
 =?us-ascii?Q?wyNfLwOqutJGVba3gNEfl0794h7btDeZ4CtpjM7Y8YWPPAz4q8T3a0uZZl+e?=
 =?us-ascii?Q?gNSuNsVmYQyO6Jj3tM9L6fvczrP1oUczZ/jlBextugYX5QNCr7oC8ca++ty5?=
 =?us-ascii?Q?J7ldEx6ULp32lL2eXykoeQvpquM3RskfjRcd8fvdkWt/GShSn4I6ZXeKkHSs?=
 =?us-ascii?Q?5qBo9VeLUX1ND16y7oaaWcCJLgq302DYnvxTtpp3B0hUQMs2uRLVhk0eB8ru?=
 =?us-ascii?Q?4Ws1b2V8iBXiJzCBe3kHVSSWBNP8y/yCYaRudyWWjP9aoE8A4Jf5ttEQ95Ss?=
 =?us-ascii?Q?Etk3VoPt2SZA7B93fFFZl6A7Gp7Rzb2jipqk0dwODfT7HtTQ3AshpBykb95G?=
 =?us-ascii?Q?dFx6g36C9XoMERmzxYUM92oOs+UbUGrrb2EkmZbTZXoJ9k+y7Jh0fl6MSiA1?=
 =?us-ascii?Q?DQU9kU3QSH2jObpWaQAU/9uwU/xOtWvlcGd0lfMpZxhkbkM3mNX+WfGgLsuI?=
 =?us-ascii?Q?yLEty3w6sHEeoJ0LFbudf3ZWgUg6T0HbLOjcTdbTX9Mrpf5ZEpS9OI2nrNWf?=
 =?us-ascii?Q?Lp3XbssOBQ5nNXU88mgCWYJQ2xQ4K3kiyNjPu931Z2i2aQlmr7iDjgyCCnET?=
 =?us-ascii?Q?tGDxFxIAtgZJ6SpI3tIVXUEGhoQDAbJ7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7813.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BNcJEy7onj7H63svdlEaB4RHQfasroM+hHxjU/jBmoJWV26Jfkgc0FBss6Yv?=
 =?us-ascii?Q?GnPipidVjpMiUX8+R1Isz9WxhB37/OVXrabVFRT85snkogKVEtXDL0LBsVxz?=
 =?us-ascii?Q?ezHeez4DOtYF+T3GL0LxmevVu5eT9t6J3kRHaB9SNgjT/E0NFV4VrPLIgrXs?=
 =?us-ascii?Q?fA5ItvmVBCQNznAAA9Erksv1WopTZpoz2fEMwo5Pq+K43KHR5VN8i4uvi9k2?=
 =?us-ascii?Q?LJc4zXsNkgqlU3XwlZUtvcPantsU4OPUX+GNKTkmD4hsCPTtF+tk5TYn+CGg?=
 =?us-ascii?Q?hu74r87aPuUDpVRthPUuvxO5iAFRHyHCr0geJkdg35tVQQ2/6Ruwl++CG48m?=
 =?us-ascii?Q?40AX/tP9Gfhf7cu5zylTZYaBzReQgebJnSvGl6bzudlykvjXPI2Sz3N+vMnw?=
 =?us-ascii?Q?c45sMvBA2iHvjeu08My3u9dMDmy3cgYSmW3J3OCqjUnk1QAYkBR4+yROBYkS?=
 =?us-ascii?Q?a5YL0sBB13SGuyDKz9kLECwpIvXckLBqndfhHjbceslO7ArZt3U5ATEO2iBA?=
 =?us-ascii?Q?Ng+aS7FCIZracvux2NvR0WtQAI3hO2i/ybJE6/nCfz9SnoQlDMMfvDRuAagz?=
 =?us-ascii?Q?ucRjqds/4XW8D14C4L129zSXpHwoj/LkB+673i6oaKm6+NR/ZidRSsZv35tz?=
 =?us-ascii?Q?Kp4MvmCG20x0iGv+etE5NQE8RXd88q5PW7x89vg+HiPkq0eiYpJaXjIHSmEI?=
 =?us-ascii?Q?brzA3QoR5pWwBiJRjTbERvcxodj36i9cygdR5KkrrvV5NyL/neLQzrf2mSEE?=
 =?us-ascii?Q?xooBpSyfgSLLEQrV1pByRZE6TlCUg2f3JfuiGo20ZpgYTY8HPQrjWGFygGUe?=
 =?us-ascii?Q?X0bMTh/SHKLL70BXvcGqEPOIpS+KyEQ6+8e5dSFrVyLWHKfkfW8OfbMHV32p?=
 =?us-ascii?Q?tse+q+n2HtJdX+O3EJEoabaXiq8cFtEsCoqCKpkPceYzfGhLm8/115pBpn2i?=
 =?us-ascii?Q?0MSpmTrGAi/tOTRTYK4x5F5Ui1jQ8ujFPP2o/kwSGTgP3HKlkCWP4ioPwXYz?=
 =?us-ascii?Q?IEpvFCVig68zMSkxgGOxedOuMj+WP2u7fjnE7nRf+lWwGbnyf2oV5Gx0H/Vb?=
 =?us-ascii?Q?WF5y+jOzROuegc23XpFWBSEiNtnM57mUkM1XcU9L5ZJAaMjiIUej8lo3xcIZ?=
 =?us-ascii?Q?cJ4iYF5kmmk+sj7oxmkIyUDWOjmhfUF8FjiIyDmpOvG/lkEG8gPI2ioVNNMS?=
 =?us-ascii?Q?4keI7GxC8/lAUANv5hDnIRYjNeHiznM4IqexoCJggO1x5l4QZgrl6dYxNmF6?=
 =?us-ascii?Q?7fUzr3Y7AQfv+wvBwl+xdDVSVN/DfjGrEkPa0xccjIOzeb6MAetC3yzjVuvV?=
 =?us-ascii?Q?th9I1lD4/oBHB0v+S/OEKDREWcBMUsFHu9V3Zs4pefRhUxDSvHI+GfG+B6yt?=
 =?us-ascii?Q?VwQSg/3bj2TZu/GhWkomYy/pp68s31iUEn1l7TyI1AOGw2T0uvT8Lb/oc0Dm?=
 =?us-ascii?Q?xvoJdckAvioOozT0ZnKaxKAAnR6+vxRX9sC6JTQVK42RAU8Md3Nht06N8lob?=
 =?us-ascii?Q?L0Qu20V/F0CRJfoDTpzgky+L2kdIzzztCeb5J/07ZTNHQxAr1auuPuYBXDF1?=
 =?us-ascii?Q?IE36T03ricmDuhK5VAB7h9XdRqRkWspjpQUoMgOxP2W18+OMpc1zMQvyQ1hs?=
 =?us-ascii?Q?toUBsIGQMN2sQv2kS+ATqQ/Njp6BLQDUpa2vwcarKI0b?=
X-OriginatorOrg: gigadevice.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7caf5d37-9406-4e79-e532-08de0d315eb9
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7813.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 03:58:03.0270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f84ba339-959c-4ab1-9b67-1e43414f945e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQ+ThaZIuKauBrHgHT3S7PPw6kq9zF03ptsFdJL8C/EdlTlHDe5t5hAHmlKxiZ3qDYDm407ItPshSOGOWmBOXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5663
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

GD25B512 with ID C8401A
This is a 3V 512Mbit SPI NOR Flash.
Link to the datasheet: 
https://download.gigadevice.com/Datasheet/DS-00975-GD25B512MF-Rev1.1.pdf

Tested on Xilinx Zynq-7000, on Digilent Arty-Z7
Test result on cover page.

Signed-off-by: Victor <vlim@gigadevice.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 0383175beb5..666203c8485 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -121,6 +121,8 @@ const struct flash_info spi_nor_ids[] = {
 	/* adding these 3V QSPI flash parts */
 	{INFO("gd25b256", 0xc84019, 0, 64 * 1024, 512,	SECT_4K |
 	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)	},
+	{INFO("gd25b512", 0xc8401A, 0, 64 * 1024, 1024,	SECT_4K |	SPI_NOR_HAS_TB |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd25b512", 0xc8471A, 0, 64 * 1024, 1024,	SECT_4K |
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd55b01g", 0xc8471B, 0, 64 * 1024, 2048,	SECT_4K |
-- 
2.34.1

