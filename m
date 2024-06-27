Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C5AC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF80E88569;
	Thu, 27 Jun 2024 13:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="xLIQZguN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8420B8852A; Thu, 27 Jun 2024 13:20:17 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 714138852E
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:20:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eb4VCdhW65/s6hdoey8DK1t/6U13zJLTTR3HpCBNlh6dyhlMCna7LvTHYOuNlT8bClBRgy99s5tvJhVRUc/pdYfMJyqN6pK0o67WAGSwIchnTQZW2a44/lxQDm//5ghHsAmG6eJd3BO+cEzw+4+6deu/oGIchjrbxsxyu5I7uDg3bsIva1KQEvU8hzD1Rojd6YUFoWXV4aFwe3BrQzsuUlSg2XOWQ9elDPfveefc7fVfZwV+cpbsVc9qQOfp7/0amiwx9Y7Ov3R9JqSeEqhXH9/YseC/B5rH06DvPSoOsuKwGBO6zM0i9E36bea12V6dzEJB6p2gHHNlMd0jmfrQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q66fcJbJjM2OxpF2cxI0+3gtEFaeBOuxQRfFS1WPzyQ=;
 b=VvF8UAhhC/Asza/3FrA52eYne/Y9uRZAknZZcqUIaWRlVipqSz+FP2/KvKtso6IlS6mqOOfN85i5b3y5Kf6cxkxJTRHpU2+di+UvEE0PgSxRX5gHtYfY30Qzk9r2Kkh1oKLezlWe36++UwtmTdQc6w5hKs3Lcy3GTXsCvhjaDvPGdOBAh0WfBP4176Fzd1agNV3kOYaUEX9ayeg78pNpjkykBQOR9lWi5MBRvJENu9xU44nuGnuN4k1+Xw1FJdqpTkbMEmZqqC42hJkmMQRsANwLnkgCU7wkaYnLnM81rydP6qQyhMy3yPSQvpZXlBxiSvw6xc+OtS2x5ZugsEof1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q66fcJbJjM2OxpF2cxI0+3gtEFaeBOuxQRfFS1WPzyQ=;
 b=xLIQZguNBg2PY9KI5eI/U3flSR2QqxPFjKzK0/ep4R2KpYS438miGxCExnFYWoeyEuHxBkJ0b8hNcTdtMotfQtyKNf8ZiHEY+S+vamO1KsSwzp/BJBUCR+3G5RgAypEcKDlZRqRzQm19Iv+elbszRQogmECpQLZOK5FMQq9UCp6OGPKuNnWHZUqYCoq5jpA94azNEbIlCrfwxKtMBNqzHmCJ1ACSiQdM4nloupQ11zq/qJV1yFwbm81RePVaiPmow3TNZhKFhXDBJ2quAH2huO9MBbyC1OvogskYw3AG1rEexsZg02Nuj6MEdmwL1A/F+p8hIFhp+Bx3RK60/xHNTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6064.eurprd08.prod.outlook.com (2603:10a6:102:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:20:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:20:14 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Subject: [PATCH 2/7] mtd: spinand: Add a NAND page I/O request type
Date: Thu, 27 Jun 2024 14:20:00 +0300
Message-ID: <20240627112005.99375-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627112005.99375-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240627112005.99375-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0000FA79.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:4:0:6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: b2459e5b-2331-4b51-be9a-08dc969b1d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZEQpOwxFfcW2ruOvpeIhZjXXlHWeahct4h20+r/udeW18QH6yz2Vx2LygvmR?=
 =?us-ascii?Q?nIcooStxr+oZNc8BY3PI8v3pFE8mcHI9RmtK0cGX1dj2Jw2vYlDlA0tqZaM6?=
 =?us-ascii?Q?w9733+HpaeGfGq9ei/CNlHpXmrld3n37mZzWTGEOFj3QF/pJSvhUtgzfxTSq?=
 =?us-ascii?Q?04NIcne8BPuby6IwkMKx/Lv8a7YHRbaT3gRXw6o8A7YD7v3wu/RT6gwUy6R6?=
 =?us-ascii?Q?VghlyMNkI7MZ1YbCnStLC0VEZ3bCs14QZuQDxEx25J6GtvbkE5sGzvIFxYYi?=
 =?us-ascii?Q?uETplztH+1tsAz/8lIP+wTMqoiil2XBlfTtA4BrLHbYbGDI2fIXb8cn9H+CK?=
 =?us-ascii?Q?ejyAHHZ76sRi+bfTb/1c3mewomWohCmr/FgCUaZzNTtqMhaYjAVQQxorT23X?=
 =?us-ascii?Q?jr8vokU1IZiMTq9GmH7ifqJDEXVbkncFwy1rMnzrFgT0I2VHpgS6Wxhjo3+F?=
 =?us-ascii?Q?dNlROx4oyzIsZTbo0874Xagr8nrBt/r4LdZ6aNHmC9CpK2GipthC+a/5Da+t?=
 =?us-ascii?Q?I/Z4pnxoIIQ31pqELoFpInMcer61STDeZvvXZk949FwbBQxlj0kNi4QowDBE?=
 =?us-ascii?Q?LSrOEcmv7nG6k+afBGwOviKUnctw7u0hXUoXza9Zh25GwBbMj6y++jI7SAa/?=
 =?us-ascii?Q?NGf0ecbtPJcIy8lMU/5di1gvOljFbAlvvnYjC1pt2Rx1pgxVLTYrNy5H75CN?=
 =?us-ascii?Q?Gs/pWDjdAF4HVdt+AcPqVUbQji5nJBo7a9o4eDfpccBqKQUFFmyt/6AH1Gr2?=
 =?us-ascii?Q?8gSLLU7QTWHh7qjxsuq1ePMuzh+fzI7NsrdQXdnij7ed/6xZmGtdNp3cqmt2?=
 =?us-ascii?Q?aLGdtlY7KyCODurGwV1U3R2FU7Uae/w5nFQe5Zf6K43j+aWh4vAa032wqxJ8?=
 =?us-ascii?Q?5NUF2AEDbql4lPKHR3Mzx6hVzWZgQhtrj7x2Bp7IIRnI4ETeoJH2sTlUbdIk?=
 =?us-ascii?Q?58/4mz8m2DfnDq86iZNwqSSs7Tu5ewJuaoKgYf553L9tosM3Dd0S0U7xckFC?=
 =?us-ascii?Q?YaFoXtxPpeFY19TcsKaUjveshJ1Dxoxsrw31pjdQEA1Zc8fdh1mMA6eJZt09?=
 =?us-ascii?Q?q7etAPXUHCEK8Ysp1HlkFiP4zoa7Qw+p3JcbT3fntBgoTkzOPOw5VREdHUJp?=
 =?us-ascii?Q?O+g+LvBQTAx/hqHCwFoCs+O26qkS/DlB+g83iJN6pmpFAIXjHP6hPRjwKW+i?=
 =?us-ascii?Q?1BLPEy/ZsqjcxkgjlGRptjsC3HSExJaBmOKc4Prcxg0/WBxM5BDKGnmhX4Xp?=
 =?us-ascii?Q?tmu7CEjmqmdVSzb7d3d9oVQ22qyRvMbx52+82xCcsMdXOG1UyEGRkCMDubqm?=
 =?us-ascii?Q?FuXuAdSWPntZAxzagbnmbCfATMSGAkUnXxt67/KdyO+grpQFTRIRv9Ystc1H?=
 =?us-ascii?Q?vDqBLuqSZKGaERcw1OMrqOp+V/C5h1aZWGe6fg/VMTtc2Sam32akwWfcqQYp?=
 =?us-ascii?Q?2QAZP7agW5U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bJJzAzzsn2Kdriz1HU7bOSPDWTH61SnoodDlS6Y24iqFWlpi5re/Qf4u1vrc?=
 =?us-ascii?Q?RAyZ4rdY1z99xsRGW1Ug8sWI70zm/J862BAXQp94wdDQNC0Wsx9kp6H6dljg?=
 =?us-ascii?Q?0uYcWA5ciPzT2oSGCTfXWVraq73k8GEcch+JfdPnzYEzNJ/lsk3S12CzM1QP?=
 =?us-ascii?Q?Lel6/S2HhFf0Dpxr7dA+x+dMPbEltc6h1tTzK9V0CTW0l7Nd5A8ptztFMz10?=
 =?us-ascii?Q?PeYdH2WrutMTx54XiPcXUk34wG9WEpbcWqAlHYPAuG2IU+dv8W7M6jPooA2u?=
 =?us-ascii?Q?D3MkwXzYxSQxlzxWo1CCodI0fGa2+NpRvzqlPUH3TIHL7ye0loiz4hENmAop?=
 =?us-ascii?Q?B4meNjxK91HY+X3UartotByzW8IjVVa0N4k0km1FQ/bfzew0aMsixGS1aRLL?=
 =?us-ascii?Q?CVVysraJNAKITe9ZYDDpHHtaN5zlSLIdlGRIt1eQS+pTSscZJWi2t7MGg+6k?=
 =?us-ascii?Q?pQme8eWHrxNTwagDQXUCa0mAahzNhYfzJWIzt+C2BZ53XkWzKClrU44o8pnr?=
 =?us-ascii?Q?vSz9AySyoAZ3sdZUD7oMdP8qFikoFNtK2Okhw9XJttycFTYQwYyTUQDZKLNz?=
 =?us-ascii?Q?fmAXAhR9Rn/dTeL4kDvLJ5/oeykSl8Uxsic22l482yu98OyHZBS3lEQKcd0f?=
 =?us-ascii?Q?E9YFD0S8H+ncO4FGr743XActwLsKjpdiyVY22SMChhcr9Yyv15EwS+rBC8eX?=
 =?us-ascii?Q?Dg9ou6xg/k/UHjRHj3/rJiJKkmZjCo7yvHA4dEOq4Udlu/Ih2qT2fhPJDqVW?=
 =?us-ascii?Q?4uHb/XOtr4Gj1O46QsMzcpsNAjik7Gjp2yl0gLnLuuhROqAW3bv50A8dLwgW?=
 =?us-ascii?Q?OIHRCOrFOEY28b88zl1a7qrd2wC5SGnXmNyxUm+uNpVlzwIahpMd6l7ZuFaX?=
 =?us-ascii?Q?u1snWJN51kVrafwcrf+2nELzlJah5TFadl//DcLXhRFcHuzLaJhhuf0PP7mW?=
 =?us-ascii?Q?UZ3kaTwnt/ADHVbr8qOpMUmCasxLCNaU9JM7JUU8E/T4KjdwvYFTGfiGPNcc?=
 =?us-ascii?Q?5uKKQmf0jQz1dL/iF6/8by8bMQyC+EWwLbmjh+X8Dgp44IT5ihsXuG5FOOlD?=
 =?us-ascii?Q?EjNvkWQXHQO91tHtxQChpvxLdk/Nf5VP0CGb9T2ZkOtgPePkS9NDcF5nt97s?=
 =?us-ascii?Q?MeI05fD0JCzl7Zs+amaBu7Mwe1XZ3EOZM4JIPpx9JR6sTgi+NpLqk1XnAWxp?=
 =?us-ascii?Q?uYLOXGyRoDdbcTpTwRRp5kTBtoWORCqdDTTbtfHC1DhTwdkkS+JrRGuzYO87?=
 =?us-ascii?Q?4KwC7NYCKcIRUQPzZ3hbFxmdJkRFzLOW8kpk42MU7wrzpomaU+YWdBR4lhui?=
 =?us-ascii?Q?K09Inj2y6Fk3Q+HsDkk/pD6X4M59Mu/dKFf0a5GylcIYbXgpYInLv30L92Gh?=
 =?us-ascii?Q?j6m3bnRgrRcMsJlAv29tihO2m0aN9COQ9nwW5+Oy3DtHfhzhnm2duck4mamk?=
 =?us-ascii?Q?c0fxxJSP/46KYEAHLHJrNHs6DyeBXlYWAhIpt8wSp22jO2wDqC7wPIkMx0X5?=
 =?us-ascii?Q?b5KM1xHwXnTiz6JoPc2GZLkRkjaXp3cNmV2umzu/+M3QvhbDcSEGnOf7dKeD?=
 =?us-ascii?Q?XcPXpdMeG86k628XkbzI1wSV/np0ECtLGb56IhBJj6J5p+uDHLsUTlgouIPH?=
 =?us-ascii?Q?8RWTwc1s0WbkQ+4eDmSw7uY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b2459e5b-2331-4b51-be9a-08dc969b1d87
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:20:14.0938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvJX5JC3OfuYhx4eUGDlFj5jsteFt+fjAitH4EJP53ZNnVXAPkYUtdM2xV3atGbMAaijo9dXd2OLBW95QsG1LAojCCVZdt5+fCd8sgqsjy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
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

Use an enum to differentiate the type of I/O (reading or writing a
page). Also update the request iterator.

This is a port of linux patch 701981cab01696584a12e5f0e7c2ad931a326059
created by Miquel Raynal <miquel.raynal@bootlin.com>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c |  4 ++--
 include/linux/mtd/nand.h    | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index adc67d7a40d..f10a3dbfdff 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -519,7 +519,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, from, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
@@ -571,7 +571,7 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, to, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 651f8706df5..0afdaed5715 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -80,8 +80,19 @@ struct nand_pos {
 	unsigned int page;
 };
 
+/**
+ * enum nand_page_io_req_type - Direction of an I/O request
+ * @NAND_PAGE_READ: from the chip, to the controller
+ * @NAND_PAGE_WRITE: from the controller, to the chip
+ */
+enum nand_page_io_req_type {
+	NAND_PAGE_READ = 0,
+	NAND_PAGE_WRITE,
+};
+
 /**
  * struct nand_page_io_req - NAND I/O request object
+ * @type: the type of page I/O: read or write
  * @pos: the position this I/O request is targeting
  * @dataoffs: the offset within the page
  * @datalen: number of data bytes to read from/write to this page
@@ -97,6 +108,7 @@ struct nand_pos {
  * specific commands/operations.
  */
 struct nand_page_io_req {
+	enum nand_page_io_req_type type;
 	struct nand_pos pos;
 	unsigned int dataoffs;
 	unsigned int datalen;
@@ -613,11 +625,13 @@ static inline void nanddev_pos_next_page(struct nand_device *nand,
  * layer.
  */
 static inline void nanddev_io_iter_init(struct nand_device *nand,
+					enum nand_page_io_req_type reqtype,
 					loff_t offs, struct mtd_oob_ops *req,
 					struct nand_io_iter *iter)
 {
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
 
+	iter->req.type = reqtype;
 	iter->req.mode = req->mode;
 	iter->req.dataoffs = nanddev_offs_to_pos(nand, offs, &iter->req.pos);
 	iter->req.ooboffs = req->ooboffs;
@@ -687,8 +701,8 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
  *
  * Should be used for iterate over pages that are contained in an MTD request.
  */
-#define nanddev_io_for_each_page(nand, start, req, iter)		\
-	for (nanddev_io_iter_init(nand, start, req, iter);		\
+#define nanddev_io_for_each_page(nand, type, start, req, iter)		\
+	for (nanddev_io_iter_init(nand, type, start, req, iter);	\
 	     !nanddev_io_iter_end(nand, iter);				\
 	     nanddev_io_iter_next_page(nand, iter))
 
-- 
2.43.0

