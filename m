Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD334CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 07:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44EB6829E7;
	Fri, 19 Sep 2025 09:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="egfnfUEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E7118309A; Fri, 19 Sep 2025 09:02:21 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979BA81E13
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 09:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVaK9EMcWDxs8heSntfWBx70CJLXGmkOkdCF2814SvCIa3bh7lgnLSFSy6fBvG1ccltRpCuH1eQEpzh5FLTmNai2Y1WfzLP5WU8/TpAQQywENMpQRUmcSSBAVCLOScKFaPKP7wL1Lw2+K16M5iSbwknl4CTCC15NPxaOYU8XimZaovTrLrdOR2I+JBJfk0gGCbLQ5ZdzuV0QhHswMl6BbGqGRP6p/rBjgzueQMvBUkcA/9Q5S6Ca1Vf+pRhHsSOZGVRZdufW5P8qiwIIjzet3yk9RYqfGE0grE5p+wzDO4YgHeAE+0lKqN9+QPNQhtc02ailguUXHrfBfs7/gHYZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMgiv7/8BkGt2Mu7/BgVhTK8U9MUxm7weMsFVAtSoF0=;
 b=C4m14M1tMY9ciYSskdYxRUidKqZ5tX33/L7IOILP8noIo6fWO/O3oJeHseYIV0qc2p2pOuqD/ePWcN2dZD9WybT2upXNzSrCWj6aKViw38Bhuw8py+Ssxpuc/2oT4TyfTkX3RvusLb0gU+D8IcNHAJCn1gRDUGFlCrIY0PirFMnoV1vMhqgo1DfEz6GiPl2nN+btLS4BTRc5oDY+kaqGiEXahuBTyvCy01lVCvZx1nUUpLNZ6/qkMobpVXvfKxBB8o9LWR2kdL4+XNPj/1yn7ZpU3c+JfYK3xsAcN87Ei9E3FGtWfCKgIFjmloeVeyrjTEdShzaEMwP1BsvLfjiSLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMgiv7/8BkGt2Mu7/BgVhTK8U9MUxm7weMsFVAtSoF0=;
 b=egfnfUEj5CGwUuNmkxnYYXkYLmU+tduRZd0TeYhCrQZdCltHdiMyphhKLoLQdMcjydG71G9RDdZJtyCsULYousukUSxQMQBzjq+v5tTLVyRxGnE9YqeHgknAh4SFJyq8V8yZ9h03ybRUoAxvSnHOd9Rry0n2Yxxc5rZsjTHMRIwk9k5940auYtGbx4JI827+glYZdbrllSQEk2QF+gLUvCqL8pCgscaDGFvAX137T9J8YUHapvu5Yuws91pPltiWJmB+O+D7Bh0w1YGh2bZskgaMMsx8kcDsUcESjVOYchiAQtwO0tXrVJH/teSORKh8yqxEybVMsCHowJVoDozbww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AS4PR04MB9574.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 07:02:18 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 07:02:18 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	jagan@amarulasolutions.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com,
 marek.vasut@mailbox.org
Subject: [PATCH] cmd: sf: align erase and write on erase block boundary
Date: Fri, 19 Sep 2025 15:01:56 +0800
Message-Id: <20250919070156.1497268-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AS4PR04MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: bedd78df-9408-449f-290f-08ddf74a789e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|42112799006|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1jyNQkofPb66zTdhD1CmOpqcD2BZ5dUyMWKCdMOUZGR7Cs9+7k5KBGtnrnOf?=
 =?us-ascii?Q?/1jPv/VO391ZyqHrr9vANQJc/EtLITy414tuQsWJ1QRHb9tXFwigI4dl31kP?=
 =?us-ascii?Q?aSH1O11hij3b4P7nIFIVQb4oJNayvvmR5y2TFO3pMfjj/n8+M38wuV1FXJHM?=
 =?us-ascii?Q?Sl0UdfRXvPCKjNO7NHjhzq10nTzYAgJYxHFguFxeBYt2QfR44/yyTEvuk7Bk?=
 =?us-ascii?Q?TRVfnd24bK7kJDlMqa/NQShkq8MiOZpGE9Nhh11mBpZ4qO4dI7/ZCmVqqJVp?=
 =?us-ascii?Q?uQBsVjP6fvy8oDjOT9V0PvaMg1wm7OGRxbnD/AVFWy3ESGSUoBqX9RRC/Qzp?=
 =?us-ascii?Q?onyAWdEjNzbteipQMhwCl2t15S8OeRNzpDJg7pQAkJiLbirJho37lvm4Ocvq?=
 =?us-ascii?Q?HS827qkG1JcaxTEnjyphUXC4kHg/m0VfkRXbZjI6Kfj8SoO8IDNDxo5Wn/7E?=
 =?us-ascii?Q?TaqUFRDDp99MXmzF8Sf7MoXHKMU7woNY5IR/qCgmBuanCp1xSXtsgaDR2OkM?=
 =?us-ascii?Q?f3PbeWRiuOLaminUlcNhnsUZPvwmQTiqEZ5ovtAYtB+DgJCiHzYSUjU4ce2F?=
 =?us-ascii?Q?JAvwdI7lIdKaBrCsBVQDxtrHjWzrwctf58zteHV6SATMWyZf+EN8JFki++QB?=
 =?us-ascii?Q?aqawBRXIrlj2XxVk/j+eGfLs+OPRFbE9FAdYgvq5gCvdYPVe+MmnLwF/wW6X?=
 =?us-ascii?Q?QFb5P+/lYKITDNlz09xrx0Qn2tHcPOsAa9Hzv4PPqRwE+y4noi9ss7wkyUEm?=
 =?us-ascii?Q?iSW1eAMoJVEKNqsQsdjaBQLNfWcdPOyDvuqugrMSFEZk6K2k7BJkD9NkpuVz?=
 =?us-ascii?Q?ecK9xzGFsF3vB6HJc7GzMp4LB/Wf4+Qet4iwjcvIJ+d87Q/YrRmQC1L7weBO?=
 =?us-ascii?Q?CmjBEOs78AIPFJwDKJHqfNX8P8LJrRGXbp4FKGj01FFarXkYUG2iXvGMJmCW?=
 =?us-ascii?Q?bnMkoMSLW1+b9naBNmm+zfNj5IddDUKVCunC4ysnmBtgHurTGnFUuwR2u3Xo?=
 =?us-ascii?Q?T93UwVp7WBo7zOcnSdwnGCZM5GvWlAGtB92JxUsm3SbYcFfysGDvslGlQGlA?=
 =?us-ascii?Q?03OQoUsSbktjJkWu/EGT0s+a3WjVynZwDEmWttcKSOP/gKxdW30Uu9j7R1do?=
 =?us-ascii?Q?GITBqsYsYGCxC/UCasioaoBdHkyFWiNNtUG0afb3mPgvfgNXgRBVkXp3nVWv?=
 =?us-ascii?Q?Y+Xi8uLsZYbaXacX2QlG6FX4cFQ416ly+LgVp/mObjWgppcHb28On0tYxM2E?=
 =?us-ascii?Q?IZHsI2lwgqqpdec1ZgdfbSULSHK0LlnPm6qsPnx30MLI2se1FbTCwBR2vA2+?=
 =?us-ascii?Q?cYNKPZzKcuz6WW4Em6+gS21VZJnlgUoXvsYklJWKlXejtUBjBtTlAmZVkF4s?=
 =?us-ascii?Q?X0VJM4hzf8VhC/5yyt6WWJ2E4HQZHHtnisQdWZtC5uBAhfVwwYTZIAUuJXeZ?=
 =?us-ascii?Q?0orBmOVR2AmcwKDkiHzF8wwA69N6BYGxxbknhdeTk5Ux6FWyVQdJbg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(42112799006)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2LSrR83tNj7L/O9bPrXtsbNr5QdO6qU7sKyLwCzYTXU+zcV7cTgzKhG21SYi?=
 =?us-ascii?Q?vXPUhtJb7g+ptzQR0ZgGHexnGnt8+Ex0kwZOmT25HivgvDGcD2FekPQVcaW1?=
 =?us-ascii?Q?UHCMbjmrlm97hgtdVjxFSZ6ApRflr/FavzLuH07alPrN9hLq056Aw/ebraoG?=
 =?us-ascii?Q?MzgkNPvO4GMfR2ACl1eQaYLKqCJb4NMPPpiRCiEQH17amUrHWTTd1mKEbEzu?=
 =?us-ascii?Q?cCVtrLGn1XkSu8E/KbhM7pUMAbrtIXYVKVQ+LV8LvZ2HxAvqH0mC37Alkzhc?=
 =?us-ascii?Q?KMHkLSKikB2J51yZc1Uo+Jk2YSLmimfhAcQUs0Dt3KYoNG6YvXp4+6Cd/CkZ?=
 =?us-ascii?Q?+y2YLS6i7DKKEVE8HQKQ/B/mGeKENv+SI0deHdjFeRBBpmONUpoNdUugIybr?=
 =?us-ascii?Q?8bJnJAqGs+b65JKKFoGZRnfBfEnTUpIJE/qtAez0RYjRh8TTXHKB40FZ/ICR?=
 =?us-ascii?Q?Gi5TxjbcGHg4MZ/Q37a2z/5Mblm3T9cUmGLThaf/xpEomLzvtkm3KUsKg8TD?=
 =?us-ascii?Q?elUHkEnkpgCFAuQdWohALIt1v298/VCcK68V8x0vH+mNYNUAfRLbPvyLkXi1?=
 =?us-ascii?Q?pB1Gb7Ki72oHcmp0sWiZnKra5UY7rN9mGEuucCNCDBN6lJUFw+p/d3j8BrWu?=
 =?us-ascii?Q?Rz/usl9Usq3v1hAMGOCxwYQXuSwpqJ7mDCNlX9SHvAm/9RCaAcSH1YQVTLsb?=
 =?us-ascii?Q?zYmhinf+JE0R8B5/9Yy2n10a9P4A2VkRlR5NiFEY1Wa/vScGO9P/+c2x9kL8?=
 =?us-ascii?Q?YGPJbeYWqvQhfroB0IbLrhih88mk9ZiUqYEoVUyYQg9O3ppX7kOzt7aNlPbb?=
 =?us-ascii?Q?2LESPy+ckEbLe0+aTbEqfKhhimtIskKW+CEi4fzQbhHa4/w7s0iaUXzzhX1q?=
 =?us-ascii?Q?c6FZPj4ZQF2BS/OGaNvrCHDSof0UJ/5CwR2XfkY0l0cb7NX5jLzD6nhvQHZO?=
 =?us-ascii?Q?WIxQZXN25zMTQ8skjlKg8zvQchcoJKcb0WhVDcdd3IUY5chqLnsh0DN7RNER?=
 =?us-ascii?Q?AEDFGd//EDz23l99D1dYsQgj04fRw7p8qb5nc1IE1Rh/0a4H+ZhZ9CrSVOFR?=
 =?us-ascii?Q?yCQW5pznBRQJNzQoDuy+/GXg741Vygn+KY9K7OLsmn4m14v4ps4+2XwrppBh?=
 =?us-ascii?Q?npcbLtUQkaY85vpSVurnxFV/YoGK0FzrKdrrtJHEhgyuxmSAhFDoZpavLzOi?=
 =?us-ascii?Q?7G1yP9SLflNMCkYjIN5QkS7qh2kAXcYBzJ+HzzWgLPbZROfRvy/we+YoB44F?=
 =?us-ascii?Q?LnPyNB5IpbBuCcgAbIOLri1SbVPGQcQ09lkCvLCNi4CNwTfrXUBvbJZP3ilm?=
 =?us-ascii?Q?tAdgi5quL5WV8cudqo+mZdwSveqEavms4OD5aT5MvC+OBLWtuoFOTGpHw5Qz?=
 =?us-ascii?Q?Asg7LPOIE5V47z9dADfl2PR3wewBhyqlTmlr8dYzcpPt8phza62XY1FqTx7c?=
 =?us-ascii?Q?9JHHmClkjy1+wWG/S2DPHehDTaeIeOOrmy1cfwIciTYeoL/+99yu4Wn76CGv?=
 =?us-ascii?Q?/loij2U3SjcXmPu2OGIO1xQ9dRpes40EeYh92yB62boBzl2q5uSrJUHWzOwP?=
 =?us-ascii?Q?Z5LbEslkVs1cwKCcMzc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedd78df-9408-449f-290f-08ddf74a789e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 07:02:18.1610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTEydJqhoy+dw9fIxdVptxIUnl45/AESIhVpy2eIzlmsh0MyK9tS+7iNslMBY8Ro
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9574
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

From: Viorel Suman <viorel.suman@nxp.com>

Align erase and write on erase block boundary in line
with how read was aligned in commit 622b5d35613.

Fixes: 622b5d35613 ("cmd: sf: Handle unaligned 'update' start offset")
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 cmd/sf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/cmd/sf.c b/cmd/sf.c
index 08e364e1914..b5b7f671fb9 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -197,7 +197,7 @@ static const char *spi_flash_update_block(struct spi_flash *flash, u32 offset,
 		return NULL;
 	}
 	/* Erase the entire sector */
-	if (spi_flash_erase(flash, offset, flash->sector_size))
+	if (spi_flash_erase(flash, read_offset, flash->sector_size))
 		return "erase";
 	/* If it's a partial sector, copy the data into the temp-buffer */
 	if (len != flash->sector_size) {
@@ -205,7 +205,7 @@ static const char *spi_flash_update_block(struct spi_flash *flash, u32 offset,
 		ptr = cmp_buf;
 	}
 	/* Write one complete sector */
-	if (spi_flash_write(flash, offset, flash->sector_size, ptr))
+	if (spi_flash_write(flash, read_offset, flash->sector_size, ptr))
 		return "write";
 
 	return NULL;
@@ -241,7 +241,6 @@ static int spi_flash_update(struct spi_flash *flash, u32 offset,
 		ulong last_update = get_timer(0);
 
 		for (; buf < end && !err_oper; buf += todo, offset += todo) {
-			todo = min_t(size_t, end - buf, flash->sector_size);
 			todo = min_t(size_t, end - buf,
 				     flash->sector_size - (offset % flash->sector_size));
 			if (get_timer(last_update) > 100) {
-- 
2.37.1

