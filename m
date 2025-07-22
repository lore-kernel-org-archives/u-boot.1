Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9467BC83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FCF883242;
	Tue, 22 Jul 2025 13:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="JHDkbIvz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B9E83865; Tue, 22 Jul 2025 13:41:59 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A06DD837E4
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkl4ZtbVztmqhv9mjvShiQFoUncEgTvlFoppvSu68Wpd5QKfhS4i0PeCq8K6etNUdo5H8U5TLlwSz2o07CoU3DBTh4vAx7rVOBdJcQZcBlFaHkmhz6u6u+ihN4EwQx3xBtnStRF7qeUGmHCk2rZHSYROQqB5rCLA/Pvt6hKqg952/wKePDg3qyq6H8qtk7MtDbZWN5Ev1zdMBh1evepUHBSZcCAjT7qASdhH/jNSp6qx4kGx1TfM/RBASr2voO/bzRca9DUff7/iDm2CYOLpG7rxSgI02P4y+ZpT3SvpVvZCoTjQrhu88AeiIauWEFPRDYA7lCa+NxORTll5R2FWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LZZcksHMXlhrdMcR8YBr1QZ89bwh3dvDkqLFXLYBYE=;
 b=bTHr5OCIPCFX+cxf3Wk5TQiRUtPbe0Q4pJvNfgbrOWno2m+yQ8qSGXeDPz7dVxvp3lAnV3yo6AtfWZsvhjkihI15hhSxDc6TZtNLWnKcW6XSh8mtV5gU70MplLZHiOHSrNbLSsI+ajXdIQYJaMsOhJR1XOVsNQ/Vaj/nj4FyCVOcLsOOkxRiNRN+Pw3+1Wt8nM3cxxkgRbDzAoOxJinYRXlE4OTp9FIXjNTalUMTublmkpUiTJrzxdX04nEzS05fUE1sCqBACi5sxKLytEaF/FudZpHbL/9J1DJ+zd/SGy/pEfNgmi29szFCNml097vQN5U/tisAfnmSD/HU5dsmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LZZcksHMXlhrdMcR8YBr1QZ89bwh3dvDkqLFXLYBYE=;
 b=JHDkbIvzkZTnpu9pWNt+4ByApQ/riY25DGXU4ecMNGxl3rqzSPidd5367msaZhZvIJKF1w/Z5tQbXPkKsSRgbwjFYJn/DpSvsfHnUKnUHBD9dc3UfFNz3oQpOpVTzdnT9TBPZpozg5xb5OB0tLWcaHQAHySd3Et70t4Iw/vQfhOt4l7LhYSzcp+tOw9bJcAOrx2NdFICkIukDaujS4NtDunPmAXPkgwmkvOi0oNqdcGMy5QpxK1+Iz0uUzqBrYar4JDJJqHXslwZ2+KLYLXyaM4jyZ7P+ajfPzj3U1DnbKDJ2DbxATq7PJ+RVKqbpmEdBJdIPSJNS8DTOZzcnBQXYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10351.eurprd08.prod.outlook.com (2603:10a6:20b:579::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 11:41:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:41:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 03/19] mtd: spinand: Add a NAND page I/O request type
Date: Tue, 22 Jul 2025 14:41:19 +0300
Message-ID: <20250722114135.768998-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10351:EE_
X-MS-Office365-Filtering-Correlation-Id: f92bf493-0082-488f-d6ef-08ddc914c295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mpIikQBFiwtIj5FRXnX/Y5j25lxxzeuYn8vA42Y1RXWd+Khcjz6hgXI5QAVR?=
 =?us-ascii?Q?ehbqmWX24eNUDBaac/QxrN17RrTuZmgAfAeztSwfyzI/K6wlg6ZE7NrSL+g5?=
 =?us-ascii?Q?FhaW9pISx5ep0CmRmUDSQ6r9sSRgoH3ueZWLpWf8Shbbs2TNW7aUkU/DvVCy?=
 =?us-ascii?Q?JnWGayktBl4RCcqZMGYWurgGoOFRcnrG82QvIt0EWs/ZfE4nrDtxKu8YnNKy?=
 =?us-ascii?Q?8LdH7BID2HfvQGIm2qc7DGEjPAlyEaNTx4MWJRpfRxSMBTlHc5+H8RdyzbwD?=
 =?us-ascii?Q?EuFGZYB8jkN4Asd0A5a7exBjSFmwaRF6QZ2c8fNQrK9BPGTXVcq7i2KtV2Mw?=
 =?us-ascii?Q?Uk/ED1OQ5tmfZ9A7IzkjBx4gdlkHB0V30UnD8+TZABTF/kupeZ3p4uUFDdqY?=
 =?us-ascii?Q?wfnNLdiKYCCUU2xsIvNDSvEqQn2ySJbFsZdyUUdZiybFZoAMB4sSd4qiGnq4?=
 =?us-ascii?Q?WgjBuHqcYo987TUEoznCbHDgik41iqdTko6oMY9ru8Qb0lMFIfLuXHGry4sP?=
 =?us-ascii?Q?x8EKJpJiss1ARgQF6otf6PQM+gCqMAUlQlsEKuTG2kycXFy8+pUivVdor6XI?=
 =?us-ascii?Q?9Os9lzgkeeBCywtoC3roZ6HkFqCSpnukjT+m63KFUqhxlkDj58yuPeb9JGeK?=
 =?us-ascii?Q?4IqMsnVrppP3nD38aOskei5fmnB0UpqXIxFAvBz9mYYgY02aD78MA9Ekc3tO?=
 =?us-ascii?Q?Kqs49SgWagyEPz8SXMDM9Pvvr/BrjGwfa65vM0uORPWhW2P+OFUx6v0uM8+1?=
 =?us-ascii?Q?FCuSecX4j4tq8phvmhKZuwcAiaGwpQGKR5QW7QIUY33aA6tBSLbqIrjRs2LR?=
 =?us-ascii?Q?wAQj2LQiyQtVw5g3sh4SArD/4Mlmi4rl03HTl5Qld/d22QrMRbXZ9l62SHKH?=
 =?us-ascii?Q?6XeVWiDbVr1SLlyRqWx/Syb3RkMZrIjjYd6NQa6DVI5TF723pxobu1p7/zdx?=
 =?us-ascii?Q?j+m5R5l2SkH1r9dI3869qkOyHov0Alxx8K9Lg0GIC3geOkcFpouNvNfO0gJ6?=
 =?us-ascii?Q?GKUkj97CHj+NGlWs23mdgxjbT9Yem3b+9PeBfpdWwjSIxk7uoXtZGYlu3+v3?=
 =?us-ascii?Q?VX5Rz9ccuFsfOFGt7mRtWus+maK3rMCRNH60rC/nEpJ5eiByuvrsoO9rqmVT?=
 =?us-ascii?Q?buLPrwwCe7xyXg+LXC8RXTS9orX1IXeamm1tYWCSunQeRFUk+Bd+/ALvwp/E?=
 =?us-ascii?Q?r5AxGJ/Rnal8ks/NKPU2YaKcDruojd+yaLtmo5Bibledb67mLq/VrFHM5+tB?=
 =?us-ascii?Q?LLNzEHFDFuqWjnLWIuoU+CueAExMbIBuEOrItPXJPN3/qAa0+bgLlQzwvoIV?=
 =?us-ascii?Q?Sf4nvMifMd3fQwHsJ08CLBXXqIcQS5TWIHbWTYKBrlk2mude1TN2I1BHIp5u?=
 =?us-ascii?Q?mvvQtGVK0PggL7MTDcaLLDOesKo9Xrt3MYe6nd3FfRpXt+RHpJlTZs62r8Dc?=
 =?us-ascii?Q?lAYFnJkxggJCjc0xNLBjwlf09sv2o0ZTce3BIXZj5HJb8YWnwkjY7MowQKnF?=
 =?us-ascii?Q?YbGBlh+cdYCuUig=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aLeTBYB2VMGAguk9AewAJoPcE7nAr/sLyhvY0Eg8mJpf3hZ4Z4aBbCIXX/4D?=
 =?us-ascii?Q?SG+MiqZ0hdJGMSqO1TbrOhMZD1XjVkmwc9EnHy3M67VO9g0zFMuJRMlYshC3?=
 =?us-ascii?Q?l+698jYN8BqAgmokS5r5mtKQO+QuoCTBm3qJ26q6ZepEm/xl5ajSUHPa2l0e?=
 =?us-ascii?Q?wmo+WPwzJU7fvhn4CYqiR5agJnNIMh1QptQQqfnXLsOD2JhTM7CzfNoVJPV0?=
 =?us-ascii?Q?ObvC2qIuJABcijXd3mlFwtyj6kppClA2SJRGz2iZ2lsdBPM8a4b+53yqfsSq?=
 =?us-ascii?Q?PiY0TlXK3xMCDAxQH1ujsoTycM8GCPbdXBrn0JZ6c/xjMqBILWYuEqduDdJK?=
 =?us-ascii?Q?56aVsaMFC100Gi6hPzhHHQiL/aLzRbrW87AlfIdGuRwZ0LR8qfzyDcG6qtFK?=
 =?us-ascii?Q?xhW81JPBNa54qzSmAmnJsPsI/5k9lNPUsAZoVKbHcbtx3LMMe/QzX1raftta?=
 =?us-ascii?Q?TczZf1mLml4ihbblF9gKZUr9B1hfWua3M/zpTiY+PwwGe4YD4+4fPzM4O8Qt?=
 =?us-ascii?Q?r6KPRAdRF8dptBBA1gd8NNItY45ZlLPnewMKZ/96cg0EUSXSR+BNONGxXBcM?=
 =?us-ascii?Q?Fsmns+6Dws+BVyg9uCOBPD0ef3+kszAGU0BSgnV/Trrx7OQEJeG3xIMg35el?=
 =?us-ascii?Q?IHp2p2JCCPC5A90KTuy9VZN6yRLyDadGNh/2XU2YHS24aRI4lD/0vAl9Z07T?=
 =?us-ascii?Q?IOAYi/NT8H68kV+INnhm/RqzUFsOeHhYUObVSSh81G5Sq2fhMbqPo6B+Urte?=
 =?us-ascii?Q?dikMB4DHRN2y7kDa8vNC1d1MeerSB8FOMo6IqJSQYK7e6w8cFsB8OpKluLAX?=
 =?us-ascii?Q?O0Nik5yHHDGGU5g/cfE63MpXKoMmefWthf3wD8WyJPt1CuEKkOQDF7PYdo6B?=
 =?us-ascii?Q?KIWqqHfwE8USaYSKDJsST821yXi/rcdbsRIoeT1bOQhSx4O2KeHwFb0WFBrn?=
 =?us-ascii?Q?PmP8pTukMi74xrxoQisS+HGdqwXgNlXclBrG0mXG32HZpOelH9O1Pt7mBNtI?=
 =?us-ascii?Q?t4LBgwmq9i0ZwDpjPth+S1VB68O00eDoZS3E5k4uEmxps7kTNPOeGPv5/TDC?=
 =?us-ascii?Q?2tDIkrrXFS5582YUnHUmBr4PYHdOsbjSyoNlDTU/QVfmwIw2IrxXlYJQ6qSD?=
 =?us-ascii?Q?CfgPElxpKrD9lDDB02CXQ3OmzJrYUZZzV6Ezm0dCKhAez+axCfnDACRaH/BU?=
 =?us-ascii?Q?cBPx1pb1VqkP9Vf3abG3Xa/SbDt3dPsdqi/3yXMrdSC2Q+tZfF4iRVdPJ4qG?=
 =?us-ascii?Q?IREuA3mlO/P4dpiAi9WEyS7q/YgURJfPR01VxfiEMzsg/lwaxKxJppnNJzzn?=
 =?us-ascii?Q?lfnj+HHlEsTNyBpX0qpYJd/ZiHZqthBS5/1brdC4flQUSEy60hcgXUwM2NLR?=
 =?us-ascii?Q?Cvfi53e3yb6mepzsFvOeSWeIxZuh+z18n1sZbv9avL356zH0tUpzN4+8xr4X?=
 =?us-ascii?Q?cCH1VU8A2HNk+aOvVyrh6TZP3vJaqiUuuCgvg1dJpDIygQeg4uRSaIxVm4Q+?=
 =?us-ascii?Q?mrYI0HXcF0lzGXsPf8JTvzJTbvFS5XjKTcYxXo9YJV4MTX7+tStuUsDNxOGS?=
 =?us-ascii?Q?t/VRKQfPVFoQezJNvyVHAx/7eG4xDPGjMKge6aGU7NCTeyj+CVxtE+YuQgwT?=
 =?us-ascii?Q?ACc4GXEKBLZDOoytIiCZrLU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f92bf493-0082-488f-d6ef-08ddc914c295
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:41:56.0620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MZyUimhxw7RZBIQsLWEUFA3LtCMvME/Qe40pzS4HVjkqzr9INNvNZ46EH9YtqFjmiroexGqxv8EjFtlJ5VdQIweiPlEevwjzX07u09VR+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10351
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
index c1b8b9627f2..d8abd03e919 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -523,7 +523,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, from, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
@@ -575,7 +575,7 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
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
2.47.2

