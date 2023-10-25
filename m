Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BEBC25B47
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 08:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF51D86FB5;
	Wed, 25 Oct 2023 10:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Msi5ygwB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B9886FB5; Wed, 25 Oct 2023 10:23:15 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73FED87A71
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 10:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mItKabW4tyWE/QOUOVcVdatsZlW30U/3LwsBDPqy8oS4BZGht7yxFAiT/PZwKEhSEC5n3rxIrbdbhJLD7X3zELB0M0QGNVK7cy4W9lpzfqkGtObdPdTx2nXq/I0nYu8zyY2QNGCpUWRXj0pKi4fbbKu6SEe2gBIE+r9HIHrj7sB1kTZ/RX2ljn/GWh3LM81541C1CdAcIMSCo/dScB3/zJk/GfIVWmdiUAgDl/rpz1G8YkSkuOwl89+50Q6iu1gtPKj2w/Zzz1CYZ5XmRZk55GES2u7zx/55oyG41dmi1h0UzIR6kMjDYpTas3yj/KXZrcKr5fHv2xxShW1pVishOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8QaGuCFCEDpGeQZ28Qz2Y0FYC5FCxLpH6zzUxZ/8Mk=;
 b=C38F3Zk1XAt90B9xfwhgx5/OwJAnTtawfe/jl9WSbRMWBEC/PXgTKuDEeraZ3THfgZ8ntd0r1AaUPJXzXcX66t4PTSgPiQHevQSILCvZAmbne1aUekZdqWBhvmkfvOzMgyCApdaTfDBuMwGRXs+qQ1pMAqemmjA9tTtCoXFdamp3HIsvN4SHno0rpNJuD9+yohhQAi2tum7TD0+/JZGRoi5wKOkrin+qsNxPqEG6Vr7+QJuNG2CDPNOUxRkmjg8YRM2fDRov6mj0QPjyqptMlYQkVKEAxXSdJ6sl2aPq/3V/XhVI/xmsI+B2nWCa9u7U3N9uLEc5g9uM7o4XxyVYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8QaGuCFCEDpGeQZ28Qz2Y0FYC5FCxLpH6zzUxZ/8Mk=;
 b=Msi5ygwBodTvK/0Z9/k2SAazzKkxBsFG4pKXzOJMolvSZcEIgFMQ7S6nebarkYXShndlgNicPWTDvEHjpsx3sgJXSFxpiElRpVEdWrHsiDvqt6JI4bL0v1tY7VXk/ICTP6G6z6xtkKgMJclQJJ4aCz27Qb0DBU748yCM0/gsApI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM0PR04MB7091.eurprd04.prod.outlook.com (2603:10a6:208:197::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Wed, 25 Oct
 2023 08:23:10 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::8b13:3926:f19a:b07b]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::8b13:3926:f19a:b07b%6]) with mapi id 15.20.6933.014; Wed, 25 Oct 2023
 08:23:09 +0000
From: Josua Mayer <josua@solid-run.com>
To: u-boot@lists.denx.de
Cc: sr@denx.de, sjg@chromium.org, kabel@kernel.org,
 Josua Mayer <josua@solid-run.com>
Subject: [PATCH v2 2/2] cmd: mvebu/bubt: move eMMC data-partition uboot from
 LBA-0 to 4096
Date: Wed, 25 Oct 2023 10:22:54 +0200
Message-Id: <20231025082254.31630-3-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231025082254.31630-1-josua@solid-run.com>
References: <20231025082254.31630-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AM0PR04MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 433c1498-fe6d-4beb-b2a5-08dbd5339f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wz3EeO5y9yYgJaGoWiCp8HhhK2a2diSwW+jad3QxZz6NCWUApqQBygSj5E2qtv/HfD3em0Wemh4gQ9h+HwvGvdYNFPAZpDDN9B209WWnVCYm0DSKKgyqouEfGRCQprwsrVpLHDUSSNpEwI9G1bk4RrqnU+3jRlVvqn//xgAueZ2Ua/qGpI3NaCiskqLL4wZXYLA8BD92amX7wi8L68f5+UDc241/kTw0XYVjR3mzOgmQlc1REHLuEeSAlGcYMyVe5VRLA8sFtZb/AJpnuNadz7BFAcfZgFRC22QPxgYidjt5ko1/Q7ebJe1RMT/YJuzfIiqIms8/Oozm3obKq6SSQEONM9nybYeRsmCIlVPXLVkPT0iej2Cgey3fnVQKysMCqIvsQUGUMOHqnH222dyOBU0G0VmXTe4VVzMK4t3lkPeYTyz8gQtg5bGKG5XfDZ7nTFTiRmQHWeBWIvMclwmOE5GWSAsdSINvVBbvuwYYiVNngEH+NeTBFd6h22Gtf8Wniiyi5P3R4mnyMN98LhjsbMRdeb9qU1mteEsPhms4fNVR0L2zlkUQED9qEzDFSUK/nTDyK+b+wmNYjdx0ytSNyA0eKA/R4z9IAXIugZmNu8ZVAtqmPX0HvahQiRxtuBiV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(136003)(39840400004)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(38350700005)(41300700001)(38100700002)(2906002)(6506007)(107886003)(36756003)(5660300002)(4326008)(86362001)(8676002)(8936002)(478600001)(2616005)(6916009)(66556008)(1076003)(52116002)(316002)(6666004)(66946007)(66476007)(83380400001)(6512007)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P8gd9ejrhgVNu28lqzdkRCItgaI7vgI8TIG0RQg9RWvkm3TrkzSnM6zArRKY?=
 =?us-ascii?Q?wrnoBAWYzjyZiHsevK7j40ZgChdFDpdKPo4HJTr1ySAU38ErmmsGv+IlewB7?=
 =?us-ascii?Q?ytTCqhvNzfXnCX5TVErgCF1/cVFM7fTtVlI44Gk98DKvzOIPB8L9OjLOHTyy?=
 =?us-ascii?Q?dcsdhWcV9PEtKq1dpJpYO2/YOilactkknh2/sEBXwHpTDbUUloefwVD1l+25?=
 =?us-ascii?Q?W+eTWy8E6Bch7I7mAu4iP9Ek8KoZxFQffYmSXDEwWwGLEhmETPDcc9wnd44D?=
 =?us-ascii?Q?Zogaln+2Q0+wDdt0vSuIwTTMhuUKWM+wImE9WH+4fDXxbCXKzsmTpN11DOx6?=
 =?us-ascii?Q?Ytn4umoS7QRI5fhsoNAS0lMpSm2fsYhhJFjHCLKNEX7rIEhdklMT3JROoszd?=
 =?us-ascii?Q?y3uE/YZs04mX+sXjvSYo+MkBvB47XngQwG/Q7rmYryzKZ0lC1l4PzPD+3pOq?=
 =?us-ascii?Q?yV+DIDCxFjrHLtwV0GxB2EWm+zVaNcHLk6fiJ52R8SSFljS8pXWfX3bL7QIL?=
 =?us-ascii?Q?nn/Q5PH3APWXDyQZD0iQMomb+lY3AfwE24XfcasAHrpUwPaJOOcYQiRmYv35?=
 =?us-ascii?Q?KFMqk/JxqC6H8LQckOHqXD5nrKuQxlRh8Zj2iIAJsD6WWiLbABD47CPTUKyQ?=
 =?us-ascii?Q?in3MAEgTeyiLZp6p91jwn5OA5MoRWSD67UkC1qgH4iwfuW4E1RYuIdid+BCk?=
 =?us-ascii?Q?GTtI6l9wODqi4mFCH4kR6EYgr8Qb94owoT7z0kO5wbWPqTFU/2GTkf2wC281?=
 =?us-ascii?Q?rdPv6SoZRsxwYjto9v1GyjlOvZkhkafsEHl6yiiUFaXBgc66cMI6L8Hy3BZA?=
 =?us-ascii?Q?1wxMCiuI/eD/wna3L6BokEfq6DfyQd3HaYcU8f2d03nEFb/1E85CoZz5zqjW?=
 =?us-ascii?Q?cLGPaMtYzTUtxVVL57jUz4g1yUv7NZXIvUepcAz0eezgLyU3qsBJtnodkHgr?=
 =?us-ascii?Q?hlUSrxzEGYoIcXlTuxShihBRCwj+kntY3meIoxpXC7Kzs+TAgpAxdr59/nm6?=
 =?us-ascii?Q?m6Xvt5DB0c7rN8Qm3JWqx9fNUPioHCEP4LZeUdMWZeCXvOzNZPLxK2tTwwuv?=
 =?us-ascii?Q?K/Q0v+CnqCL0jdTv/KeEguuZtgO1nWox3v0RAa8Opqkj4A/zp0Mferzy8jQt?=
 =?us-ascii?Q?XzKkhy9/WKFnkQHA8fdOGIwp52E3tjZ+e+uM3jbGrpHDF9JVj3WumHAWqoab?=
 =?us-ascii?Q?yfY6kdeuKgqF4cWkd+ySuGhrEWEnUfX9fgOiBwEXieTIRjnC63IdtzU9wyil?=
 =?us-ascii?Q?yuTplqsoXd8Nb74XdfMOWL7eZk/Ut24PA98RkkSqIbd7+Hk/J56dhXXou/gh?=
 =?us-ascii?Q?Kdi77KecUP0t2+RJ+rR5y7iMv79IxJYZL+MPnHsOMkXWOpXvDcklDLSFJ6jq?=
 =?us-ascii?Q?NLyuqOGjVqXA6EACvIPTc7D8+Gge3D+P+P7ssJpJYYmvVYQVqa9/PbDtKSKs?=
 =?us-ascii?Q?DWsRjH5MUPGLNqbHHwU1UN77cuiUjHGj86viVieNX2vpQwP60lrbJ+/1Sjr5?=
 =?us-ascii?Q?cMwkkf2USwzohSD95wpcTcIM/pePRSpNVlga7j9oPcVyxDQJpA6Vqwx6pJ0A?=
 =?us-ascii?Q?Vs701EL89O8h3wZu5eXgXeGe+Qs/2muez3epLDQN?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433c1498-fe6d-4beb-b2a5-08dbd5339f68
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 08:23:09.9106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GhwawC4KHFMkWGB5ZQueIPpvw3G0zsdt8+RmPMgTl4hmw4+23VvLLgLv1+tiwSlG38oT7lBVwSUH1njS5D1cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091
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

A38x bootrom only searches 2 sectors when booting from eMMC,
irregardless of data or boot partition: 0 & 4096.

For eMMC boot partitions sector 0 is fine, but on data partition it
conflicts with MBR.

Change bubt command default to 4096 for eMMC data partition only, to
allow using an MBR partition table on the eMMC data partition while also
booting from it.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
V1 -> V2: fixed build without CONFIG_SUPPORT_EMMC_BOOT

 cmd/mvebu/bubt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/cmd/mvebu/bubt.c b/cmd/mvebu/bubt.c
index ca24a5c1c4b..744b1c20aa8 100644
--- a/cmd/mvebu/bubt.c
+++ b/cmd/mvebu/bubt.c
@@ -240,9 +240,16 @@ static int mmc_burn_image(size_t image_size)
 #endif
 
 	/* SD reserves LBA-0 for MBR and boots from LBA-1,
-	 * MMC/eMMC boots from LBA-0
+	 * MMC/eMMC boots from LBA-0 and LBA-4096
 	 */
-	start_lba = IS_SD(mmc) ? 1 : 0;
+	if (IS_SD(mmc))
+		start_lba = 1;
+#ifdef CONFIG_SUPPORT_EMMC_BOOT
+	else if (part)
+		start_lba = 0;
+#endif
+	else
+		start_lba = 4096;
 #ifdef CONFIG_BLK
 	blk_count = image_size / mmc->write_bl_len;
 	if (image_size % mmc->write_bl_len)
-- 
2.35.3

