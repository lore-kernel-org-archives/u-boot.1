Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FEFC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 08:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35272889A6;
	Wed, 31 Jul 2024 10:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="psmGoaKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B78889B4; Wed, 31 Jul 2024 10:28:50 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20713.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::713])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B25AD884A7
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dG9Oc6IQZFOnO6hYLf1sKlEXNx24pwPOGKmblYMskzKwUp7FMzOUmnpM1el/c+3HpEwUJpFhi5qRbkDw7oac2sRpieh6S57/tx8O6YwxhkKpddZbe3oIOKIvI5sEVOw7Nv+okb5tEzlQTNQdWxs241Uh96+zy9SpMZy2Dih5XjL8n/O4VpFXkUBfayY3VWp/KVjQTuIrh3JQh6VrWlT6Zq5o41ZBK/luA2xhTKqlFAO4jxo8A741s6I+9HC3qYp35LV4Z9IkUXL7Pw/4zlMPeZNR+3hrMDIYCvahvUs/nK1CP6A+xMYOSgsK5BpfpMml0SZu2h0Bn4aEz538S0MYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+aCfZbhjmdzdPBJwDBzwy4NvuNWc+JQczEsny/+QTE=;
 b=s5mCByIgHv5LTpuDaossta88ZpfXa9bL8zwJhe8DT3D3yybVQuX3AHr6+d+pIHLwbea4y9HgHKaDT+Oi6QPjt3zk1PpQDDsvNXrjw6v1mMlntcGD1FNwNpIa1RgGhDXWGodJmJjSuxT/BdQwQjjFlPXIWduzqWzG44EE1Hszngb+0rTJcAK5rw5pv0G6bIfodwEO6Z5dqQnroPmQhmQn8z7t2MnUhE9Ed6MR3+6u5O/naNK6xdvyRexMdDHYK9K/g6zyl+2tU3jNNfv+b+niO1P0YXIKKF6pV7ST4lnfXSa1HSYVKlDhlSGBc9ow8Oam472ikJRDh5/vqKos72wiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+aCfZbhjmdzdPBJwDBzwy4NvuNWc+JQczEsny/+QTE=;
 b=psmGoaKSACjRWepG0RUpHECNb/1Ukxu5fRWlXVDq7qam2Ejz0Rp1L/1EERwd4F3aKtgCWIhVH2gnyGOYGFcIqR/rR73amEALkiK+psadRLgJ6EJ8AErHpXjuu4boaIrU+o2ntQSRrJ7j4ktO0MgLawuOek3c4/0MmXVGnePVvjL5zy/R/Iw6qZuXDngTyCpXez4vi9IdvK7RsVndtMGRTnQOVbd3X65lkIfCeKchIoWGrUxiHPuinH6F8XWzAJMxKPjKzF+TYzSDYNdc3uFuQ2oLlWsne3Kk32L+Be6eAnaUBsZwRdduTIIzXB2/6m/fKdcYQMNaoE/mEuU0xLhHIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB7827.eurprd08.prod.outlook.com (2603:10a6:150:5b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 08:28:47 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 08:28:47 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 04/10] mtd: spinand: simulate behavior of linux's function
 spinand_wait()
Date: Wed, 31 Jul 2024 12:28:18 +0400
Message-Id: <20240731082824.3890809-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0103.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 856e77a6-e2a8-4aed-c1d2-08dcb13acbf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p01vFkBqK5p4BWFzJWHhkoT7WadhavEVC0J86iAFmaUPABQD+yxWKW6tZvlQ?=
 =?us-ascii?Q?/MuT3NRoJWatASXVyXVwyhLD7t8szxHWzRbX3MBqunHWoCA/Q1zvDcSRC8Vx?=
 =?us-ascii?Q?CbVuhzssyurOUn2XlLxqLI9X5WrgLzV7XcOLkOkSfL9Civ74tfa58c1FkImz?=
 =?us-ascii?Q?mBLPWcjfJQvvQYkayeiTHRJiIbhsyE5pQVFbKCWcxJMUqzgTCdIU045pyfh9?=
 =?us-ascii?Q?XIMX6bocBkh+nCx/SWC713vv337ixPt52dBet1FdtXvllCR+8s638MLwmeDK?=
 =?us-ascii?Q?XAO5oXRbNK1IqT47nKTV7e1/dkvl+EbuTtqnDH0HouBrD3XmYCT09Qez3+CA?=
 =?us-ascii?Q?CU63NyLE3jl3AR6TAsb8Rv+rul8+lXF96CIOBq4Vaz+3WVseFhjkZMv2VK18?=
 =?us-ascii?Q?yUS1QAim3UxchC8sl7Bz7u3ylfTRlkOTY8kjf/fq7FGYZ+HgMg8ZWwSLwiqA?=
 =?us-ascii?Q?tlRPNpFfc0Zfv46GeE3GS+31bCTGG38mF+37t8Ema0DvMP0kNcq+6fffiUVo?=
 =?us-ascii?Q?rCnBAI9y6IYtU4ydMsXEsaZFEFLpGBCIet0rKZjiSyPgQl3DaPW9Gpz3A474?=
 =?us-ascii?Q?Gd0fNpcF3h8DBLpgPKNfgUqYk3gbRlLlftYEBNmdpBbP0KboiUX2WgJf0Ea5?=
 =?us-ascii?Q?Rro73ZG5lEvEd+BexJL69X1CHn4WH4Ikb2ktzmKQYbQmelkpqWVbg7cnV18Q?=
 =?us-ascii?Q?QyB5UeYeL1LrVUu2DE1t83f8qE+kJ2RqXqo/tBuK6tUlfCMaYVpXrfcQynAk?=
 =?us-ascii?Q?J/3he45rDg7ISm2k3lF80+LmKGoPzHUNv+MtTjYSVDYiO1es4r0EiyHlRhp+?=
 =?us-ascii?Q?Izt2QyZPXzpHbouJV+23rWHYlw1hk8BWxT7RR1F8fyHG54KyPVEDAx6ZfL8X?=
 =?us-ascii?Q?EbqCLb4SrT5D1/41aGA+mF9XF2Bwu8xT0NoSnZKg9X27pTsl3sCGiaooX6ht?=
 =?us-ascii?Q?s7/bGz4dL06G3Ag72o2IFmLiWIoCwBKKXbB9U5nts5tB+N2XgJrZWHdECKgr?=
 =?us-ascii?Q?RNdmW/5pMwgL0UAy2dvxxSQHJ9X78awh+lpu4qB+BQXpQS7Vn3OAqNAdGzQq?=
 =?us-ascii?Q?8PP1QIYqw97KtVWJySpaPM72VwPBbK9rg1v5RUTUc/AZWqth/V/LsLvHykl9?=
 =?us-ascii?Q?s2dC1tJtMv4oEjKecvllweZKHDoA+JIvLQXLzU3dQUwFF73IiHniphFCezmC?=
 =?us-ascii?Q?sMpB12ba+LaCKqlgwf49LBwgJNQYt+4X8j4606NhZzaiZWEJgpl1xydjo8pL?=
 =?us-ascii?Q?GWd10iP1VouQwJ57BO4EQUUzK8gCGZP+U8LKVf9GzQA6MZ0s7UOBkb7Kyo/K?=
 =?us-ascii?Q?Oyx7Io4iuF1NFfGhkApnySFTfC59KHOY7uaFwtakSJl4sWUH+UxtAYei5e0x?=
 =?us-ascii?Q?agnozlXkWVVBLvF/SlBVQMmcGSu+zjHo8ksBkweVATXtXxjGMzBjPz8XMJWC?=
 =?us-ascii?Q?DHGutgd3UVA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UoQsWLYGRMPaNnCBOQenFoHIhmM3DMXXUTH2fE3yJejkU1Wh3wmmk4xJ7lvD?=
 =?us-ascii?Q?eoa3CsqQzI70sSnr6UHRYu5jKiil2ULdIUKkhgfIYqrzFEiJud5UMdChcs7h?=
 =?us-ascii?Q?TOxyP05b6igIhdAVolKpNWV1TTgBrrYEwbTv5OHQFGfkDTllI9UbKjBEXWZ9?=
 =?us-ascii?Q?qVuv48wno4DbB1iak4NsVasrNNLn1at2hUNbd2hMuVDcI1j+tjg4UaPD7XqL?=
 =?us-ascii?Q?u89IM0HctCDiZzxsi7+Qz2fbZGWq9tYAjmCc5I4gp3TGKWLJIV4hopWugjNu?=
 =?us-ascii?Q?HP81b10IQxhSunoecFyoPWWuUSX8hnl9fb2W5nMCGYrbNcxrRJolkOb8GPhP?=
 =?us-ascii?Q?eZwU406mhW28J4qkKOJ8nFf4aiEUaIsTWt3CCStfofVhc47rjww4mBLKLXt9?=
 =?us-ascii?Q?dPGB0g4vsLxtkwq9M9MY3H0tJ8A3SPZBR7wztkvm0WqqXnEI/O+2it9YhB48?=
 =?us-ascii?Q?NYUHR493o4PX5YKufBcx/ESHz8Q4VZU7kTiM8gWQWZUIdyac4REekrN3bIP5?=
 =?us-ascii?Q?jrotZLa4sdxSbMIXE5CHLif1cvx3zkhDD9/72acUQ3EhnqRBlF7Clt7fHG0D?=
 =?us-ascii?Q?w0HBLThopZeYiMaGBZWqgnNl9Qqb2AHbOL//vCCXiFze4UxqzPOjUMDoloQP?=
 =?us-ascii?Q?AUDQN9Z3r8da64yT5dITJhti4bymoqJlX6ocwiSt6egeybQK/0iBboj/oVJ8?=
 =?us-ascii?Q?nf6ByedNFEAEBTyzTUQwrbGJTrfEcCEhK4Ur3BCGO+dTkFAdTpyzrPDVlZxN?=
 =?us-ascii?Q?OODEzWtXHFn97J6WDAfy4afbGXxYHW4/c7mxBMulHQn/aCfxyZgYFztqxken?=
 =?us-ascii?Q?rBYQGC1f3bC/GD3u7tUXp9Fp5E/So6CRH+rBx5QWmgR8/J3CrvQ2GGj+4a2M?=
 =?us-ascii?Q?G0G+1isWRJD7wg31hMR7FO/jHwg69c9+v7fuYfowUAG5oXmNXjcuz3NllH/5?=
 =?us-ascii?Q?pszH+MW0pzQ7PNpmIAWe+hjrHHaOKsAPykEKiJV0etkDpabPuNCGV7RV/nI9?=
 =?us-ascii?Q?v5qLdShNpC0d9qcWLv9+/hh0U4eB1URbF35OJjuw4O0nPnR5acvG2xjUUF//?=
 =?us-ascii?Q?yCQx1/5C0g6QvUWP/L/myRuhO/ekXoQrLqq7kSWS99wddVpoquk1vSzp2d1M?=
 =?us-ascii?Q?nmDgj5HKuwsxW7SlLq85YvZZ1FD1/KSR8Snhac/yfycouUap4GNBC8/KV4/b?=
 =?us-ascii?Q?dh2RZnZOo3eMDguHsX/UO6fzaEi9v73wwYH8f/ao0+PcTmVf0ZDlCeDDfoS2?=
 =?us-ascii?Q?8Qp9TAMD+GyDOgHiUQ9RwVXhRypFveDRvH1bdAiQ3d4Z93krkVk2mXbCrQam?=
 =?us-ascii?Q?h/CH52YqrFrxE3KptH8SX9OqMLAIlH5D+C49ls2xskVpyZoVf9whgFX5SmqU?=
 =?us-ascii?Q?Ig0HM5Kziupsazg8g4VaRdlN1kfQ2OfenJjSMZNkycSkFrL2q58m9ZlV9MgJ?=
 =?us-ascii?Q?qHwa+VrGBIWiFAv+XZQ3jV7Y9bz2E8HQ89KQjuYPTm4aatLKvvk64vmskk8+?=
 =?us-ascii?Q?65h25xcIkSC8b/Qj07BVMOD4MXr8A7ulyxMWcZKj35XlTJh+Lned02vJNGZS?=
 =?us-ascii?Q?d0O4aTr+TG7Rb9tIX2l3bd5DmyogrYN5DZGxxHw39JLeggmbWtxU15R5pOwu?=
 =?us-ascii?Q?d7pYrBtxaMd4fDcb8XZ/oT0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 856e77a6-e2a8-4aed-c1d2-08dcb13acbf0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:28:46.8819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0CZ6AHjO1iLwwsNxbSnn+UdRY5PXTa3Lk+ptbvazJRpQWaWSC6sgEiX2Rc43D3uhawr9Vpd9mBOI8bwJ2nZ59leeXjP03VTqhRIzxVvOjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7827
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

also call schedule() to allow periodic actions

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 35 ++++++++++++++++++++++++++++-------
 include/linux/mtd/spinand.h | 22 ++++++++++++++++++++++
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 4741d3e087c..bc16d9888d5 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -31,6 +31,7 @@
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 #include <linux/printk.h>
+#include <linux/delay.h>
 #endif
 
 /* SPI NAND index visible in MTD names */
@@ -357,21 +358,29 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand, u8 *s)
+static int spinand_wait(struct spinand_device *spinand,
+			unsigned long initial_delay_us,
+			unsigned long poll_delay_us,
+			u8 *s)
 {
 	unsigned long start, stop;
 	u8 status;
 	int ret;
 
+	udelay(initial_delay_us);
 	start = get_timer(0);
-	stop = 400;
+	stop = SPINAND_WAITRDY_TIMEOUT_MS;
 	do {
+		schedule();
+
 		ret = spinand_read_status(spinand, &status);
 		if (ret)
 			return ret;
 
 		if (!(status & STATUS_BUSY))
 			goto out;
+
+		udelay(poll_delay_us);
 	} while (get_timer(start) < stop);
 
 	/*
@@ -413,7 +422,10 @@ static int spinand_reset_op(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	return spinand_wait(spinand, NULL);
+	return spinand_wait(spinand,
+			    SPINAND_RESET_INITIAL_DELAY_US,
+			    SPINAND_RESET_POLL_DELAY_US,
+			    NULL);
 }
 
 static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
@@ -461,7 +473,10 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_READ_INITIAL_DELAY_US,
+			   SPINAND_READ_POLL_DELAY_US,
+			   &status);
 	if (ret < 0)
 		return ret;
 
@@ -493,9 +508,12 @@ static int spinand_write_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_WRITE_INITIAL_DELAY_US,
+			   SPINAND_WRITE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_PROG_FAILED))
-		ret = -EIO;
+		return -EIO;
 
 	return ret;
 }
@@ -697,7 +715,10 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_ERASE_INITIAL_DELAY_US,
+			   SPINAND_ERASE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_ERASE_FAILED))
 		ret = -EIO;
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5934b7604cc..b701d25f73d 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -176,6 +176,28 @@ struct spinand_op;
 struct spinand_device;
 
 #define SPINAND_MAX_ID_LEN	4
+/*
+ * For erase, write and read operation, we got the following timings :
+ * tBERS (erase) 1ms to 4ms
+ * tPROG 300us to 400us
+ * tREAD 25us to 100us
+ * In order to minimize latency, the min value is divided by 4 for the
+ * initial delay, and dividing by 20 for the poll delay.
+ * For reset, 5us/10us/500us if the device is respectively
+ * reading/programming/erasing when the RESET occurs. Since we always
+ * issue a RESET when the device is IDLE, 5us is selected for both initial
+ * and poll delay.
+ */
+#define SPINAND_READ_INITIAL_DELAY_US	6
+#define SPINAND_READ_POLL_DELAY_US	5
+#define SPINAND_RESET_INITIAL_DELAY_US	5
+#define SPINAND_RESET_POLL_DELAY_US	5
+#define SPINAND_WRITE_INITIAL_DELAY_US	75
+#define SPINAND_WRITE_POLL_DELAY_US	15
+#define SPINAND_ERASE_INITIAL_DELAY_US	250
+#define SPINAND_ERASE_POLL_DELAY_US	50
+
+#define SPINAND_WAITRDY_TIMEOUT_MS	400
 
 /**
  * struct spinand_id - SPI NAND id structure
-- 
2.39.2

