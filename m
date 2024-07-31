Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC82C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 10:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAAC9889D9;
	Wed, 31 Jul 2024 12:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="lHuAAimK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BBA5889D4; Wed, 31 Jul 2024 12:20:20 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7BF9889C5
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bo80I2eZJW187o2T5fYBui/5gCy+/kQj2G7VHP0ZgfKLnu+rVQO5a3Fvg6mZU6AqzfO4GOkmuq7uey2vy+HC7tAdmNdCzOB+5potlYd8MU5dL22gTOhHw+TKWIKU5kxIB0cTL0TByON7bVMxEpKt3jROT1WZ1nuo58lEwWKRfJmfEdaiEkWCnrJBQlf/M5PFvlmnG9wYuYXXjdb3ueFeyBM5WpTedH2+vt6XGyVZR6sOy0+95V/5Vf631B+BKfrP6RJGT8iJgHyS2jwjQXp0IEq7LmsvMn7pcCJ2Y+6DIUXZpXI0SQqyi/wVFMIxt/0iDXvb3bLJK9Oz9Ac5A+LlHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQTwLRE/0ph1Pw4b1GSQg7lG0t4sJtahM78/rsFItvc=;
 b=p/Es2Q0aLDixF4+901tfuj4Cs0DKj0c1ls86mK4DxV0euqHsa5SPLbvpFilgcUwdKtXV4J3OpkksO8qeeMdYMoxtDkmubGI7P2CsE6oSTPdR4Sr6zHmcukqiWpiO9tF7abBDiYr6qVJBpsguM8dr+mA1wo+JORAZGkGIXVM6K3Gl5jhlSlE8Jusr1didtpzdzicT43jX7fZ1wVcmqVWu05hTzEn7IxGFftCG1cnVPPhLU9Q9GPF4HZyzd95WEr90rMHgadYztT6rmlznaE6/+mrQpEaqtGPcRE7iVg82iNGaXuOc3D51cxlZATGj8VTkM2v+TZmjRWaz4xxHWjgBmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQTwLRE/0ph1Pw4b1GSQg7lG0t4sJtahM78/rsFItvc=;
 b=lHuAAimK0O0NUrAgk1grpkVChMNOx7cuHtv+lMG9NDMA7V5p31ZQ4BkpRWj+iBgWSWtq3yjugOK9KoqQXi7X+fH0Ivw1LFkylHX4j7droGMAx/KcqlqaPHrblCitLhAbchRpwfqOkMiop9O7SLJER698NO95XfZUs2T4SkIofCZ+2VFKY2Io5D6b141IB94WiIqBH6mBmAZ9UbpRjWszaGsVTb+Vn51B+AuLPpq+pkeZpvuAmgpE+SKZr4b3+CY1DcKJje1QmQ4HndoptB+TMGGHGfA0pwhU/Xn/OvgHGDKZlqn2LYbR7cSDJE9iWS81HpBgIV+D6O9u0s9J6cj9kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB10076.eurprd08.prod.outlook.com (2603:10a6:800:1bd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 10:20:16 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 10:20:16 +0000
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
Subject: [PATCH v4 02/10] mtd: spinand: Add a NAND page I/O request type
Date: Wed, 31 Jul 2024 14:19:53 +0400
Message-Id: <20240731102001.4030460-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB10076:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7c5cd8-7dd4-4a21-73e8-08dcb14a5f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|52116014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B7jqpcwSMD+IHiyWldE9rI4nWrWSXUkUqblzcrTQ2QLMhT4gHKSH7i11F7Kh?=
 =?us-ascii?Q?S6r/JUsfg5Z99a9t9WUdOhyVFRWWA64/BGx3S2+JfeRaRMIJRnEi2ryqDRWs?=
 =?us-ascii?Q?DtumpjGjl/Oe6GUVogEh5CF/JgVJPA4DkUY0BlG6EuomUX08r/aTXXSJxTDc?=
 =?us-ascii?Q?v8/LoUvsq4Oj0xhoM/Fwos50VP+Z4xjeOd9bKUcGWjEw5HE3pDLWeA64Z1Q2?=
 =?us-ascii?Q?ctNWQKIlH7F5zNc5HPuE1I1Qcj/yNLtAfuJBXW6zRMoFmkWy+2AWqIcHzkS6?=
 =?us-ascii?Q?aomMp4FTlICXh9743XLVg0PFSmSoT838PkOABg7z+Ya+P8niFJYImIktYxc6?=
 =?us-ascii?Q?V4jP5j7Q1Ho7H1pzqWXwhTaKnyZe1mIjcGkaimXbZCAXM+4CC8bF60+wE7IO?=
 =?us-ascii?Q?vNS6vT7XGsLgh2AoYrp7uNhSUQY/7Ynq7fumMzv+ZlooinwAW+p80CSHL7tt?=
 =?us-ascii?Q?gdeX8mJUwHrAFiJitDntVQrnL6DHwtSb955DTYWLwmWukCk4GtfCrHSzDLez?=
 =?us-ascii?Q?ssAqPPcchWwVRoasuHITd4AgnSwMrSbcF4gdrLt2/mI8GB/FjMiFqYaaTc8s?=
 =?us-ascii?Q?GISWmWzPg5rzcea73XdMsbVI4+p/6HgrmoDsltYiETncITntDpa4aHyb85hm?=
 =?us-ascii?Q?LNmTFvsNib1y8GmaqMjP4iFZdVH/HYt4t5B2XwDSXZqoKddgn/KZHS0u+oQY?=
 =?us-ascii?Q?WYEzeKoTpnm+epr9HqBc6dzc1YRD6ULBEtDDRBAXS0j4SwePpkhTgcKfeKyE?=
 =?us-ascii?Q?3UVneVswwBA+MlLXLWC8hSGDPAAdEVVGoOhE+ud8RJd4Tu7SwisKl6hBsvhS?=
 =?us-ascii?Q?OZk2l5ur6xEOfQq4tXYpFioiO9iX9tCrTYYDGPsFwz37IIJnvIklI3ljjiEZ?=
 =?us-ascii?Q?5bh6Hgj+Gn8VJReGGvwc//bO9L6ue9HslWv8Wb2ynRuBaSRsT25+GfuAm5EM?=
 =?us-ascii?Q?C86xr0881rD+98FqF3yfg7BHyOs1K9zQS8V9xluBinaXt6jtE6eefpiU0wXX?=
 =?us-ascii?Q?ZlHGqJIS9zuJ16R7nKLYQSWhuOAxAmDnAWqluk56zb20tCUt+cY5nq4mfjcG?=
 =?us-ascii?Q?1vsYt94vR7OHugGPEP+ODGmdMT6ZY3dGdbXKczD9A3IbDazm9u2cLH1YhHgK?=
 =?us-ascii?Q?7o3EbRfJ4DgHkjoG9jBXJMBH+jLjzP+XOT84DRmCBhGXxrPMv/1dF3H/SX7U?=
 =?us-ascii?Q?bfv9EIV6FikRa+SMN4GAZq5eS8p5rWQW7pvFSS9GxtxH9W5jQ1nKCUYEe0CJ?=
 =?us-ascii?Q?mpPzee6FscmC/dODWvh5hwZ8CrTdpfqCINRU/hcEyY9ybyX4KTQxf7+LuAk0?=
 =?us-ascii?Q?Fy49IIZIWmMXDXPDekNW/Q7UusArXj2Wfiprm/uEUEAMgnRdeCkO6DQQdSuJ?=
 =?us-ascii?Q?RJNrcjNPguoFWQWjPiUpkCepayUTURNkJ8e3wq8AMVDIZduA03PsbheWUz9n?=
 =?us-ascii?Q?FWCDKNehGO0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L8Fd55mqNmhf7m1l/ewluLtwYCnv3ROIJ/ttnqc0qysEPzLJYxAmMe37IjkR?=
 =?us-ascii?Q?mF2toVm4sZER6AMieySBuxE4kHCs0QhVIvpOuTNajRavjZFToo2fLcEflkaB?=
 =?us-ascii?Q?fEQTo/Faxj8X4OcfDi/OEeGjgznLZt84eBsogjzRapBaR8eFaGvDwTncx4Fn?=
 =?us-ascii?Q?ideuv3LlTxbcJZ/g7fF9bmae23Rj9kgucZGrVfX2ZErneBO3OmAgJcPo9nX2?=
 =?us-ascii?Q?YjJiJj7kRS917KpssKRG8pEsjlb5etpZK72zMm0WdjSkZopN7OOYpvMPdFBm?=
 =?us-ascii?Q?nHYCxSHJbCH1sEfTQGCZB+dnuUT9b4Vdx3RwD+sUp1GohDNIFjpbM+0p+3UN?=
 =?us-ascii?Q?qHSqn88x8PtjtHfmRUKjQUH+IvOpj4XaXQmdGMEu7nLQKBYyHsSJT0jK+292?=
 =?us-ascii?Q?T6vHQXKaItXPuT196qoRYqNoFWXTVEZqUxZEHWR2vTiP9MV1qzc2qJi+6kEa?=
 =?us-ascii?Q?fNoQlihaT3cwzG0wH6LHN1LerJ9EYQbPlUP4FW6EZFDmk6mwqNZAcEdHDMLx?=
 =?us-ascii?Q?4EjqWIUpYM6IN3LRYptuEwtWmDFC7rb+ytVcbE4+6RMNKe1QaUsd94tz5oP0?=
 =?us-ascii?Q?uN0PgOGH+c9aPJj7AvPjxhXxpXi6gHkzc2LARCyazRm2YUAS4AyNaWop0Sr0?=
 =?us-ascii?Q?0EZFKgksq+PtYBpdphxDkA49wIG55lfu3404NT2zIvP4Ly4h2B2j51gIsm7o?=
 =?us-ascii?Q?4yPH4dkKkcnl2t8eQA4yqXNr8h+W3whkagn8w+u5NL1jI7CfN6bB1xt6lgJ3?=
 =?us-ascii?Q?HRLeAVRcpz1blYAUNf6BJYi55tt3t/2mFG45D4OKd1wWwoKk2Pn0JAs+C7Fj?=
 =?us-ascii?Q?wTH+CpBZhoEDWlvTPmtMT1nB6ih0vBkoi1K0AYMXby1x/JVBqQBaSpnynSNi?=
 =?us-ascii?Q?BXxucj9yFdr9feYDo0gfsSt/x3ieH+HGio8GGBu/6OJIh7i9ohsYPnPC7mI7?=
 =?us-ascii?Q?DzBLCJxKAdOzDZOj65GfFW1ahsTSf87kIu2TLC03PMAfn74vVHYpEWjyJ5LV?=
 =?us-ascii?Q?Rjd132uoYQ07wYY5wajnHjySKplNGmuLoKNe9/m9j3a7F22qJdjAOFFYe1v1?=
 =?us-ascii?Q?CAKCldReUVSDQ0tGKct81Rztdj2wMseIWV8oelUPVvGpzvzwGPFws9l6oank?=
 =?us-ascii?Q?11BBgWtPAfIACH5vtQzS3Gh7jncAZSR3jBgjO8hz7MbusnHh94sKvfq5keoC?=
 =?us-ascii?Q?O0hiMaku5IQBdKgviK57gNSoT1nmlW44/KTBw8L/EfatoIKw4BGFoNCAqPtV?=
 =?us-ascii?Q?bC+rAPb5Fzpbd2/lap8hrqyQGgz6KxfvnItDhBYpddpmUfOkLMeak5t/Zoua?=
 =?us-ascii?Q?dL8Qr3IJZUyv8x83ZR7gWSiyrXpmU2xyyBjmoJfFUr31rSZ/buaFr7Oek3B1?=
 =?us-ascii?Q?YXR27Bg/RWzx8uigy1AFmo+QTxip8nCiyMpJWpSy5hxZ7SgCUfwYYRZPiS/w?=
 =?us-ascii?Q?yUkRTukO+ryRnh5VB42Ac9YsrwKF+5oRDeFumSONcnHLTzadPQrMEd9vvNmj?=
 =?us-ascii?Q?7ZjLlf1pdXN5MEDt45q3PH5fEnwpIt7pvY5/05sHBKiPI/mzlROC4ghPu6bW?=
 =?us-ascii?Q?gcSXE4GmHDPiqxHLHxR6EPau6lO27CXGlfjIAWNzZGD6n8vjhgz44FV+PXEk?=
 =?us-ascii?Q?suUdWiXa3bobvsKiq6ulCsM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7c5cd8-7dd4-4a21-73e8-08dcb14a5f1a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 10:20:16.2542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzgkPqMA0AoTLrSE1B1VhQ3WsYr0mTSvyzKlrolA2iPoxPAkNr1d3DndEYi5Oys19J9yBjXwX8G0D7lJufYejQ36fm3OtTYzt6d2pDE6Dl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10076
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
index 2a7e9c164f5..ca07c70e217 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -518,7 +518,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, from, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
@@ -570,7 +570,7 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
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
2.39.2

