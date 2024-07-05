Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330D9C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 14:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BFDC8899C;
	Fri,  5 Jul 2024 16:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BMRbJRqu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DA5588373; Fri,  5 Jul 2024 16:25:24 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F69388997
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 16:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bi7EMvImlYzpmVD+1tJD9odJBwj9JYVbZN3cWDc9RaHxeLvQzXCw11YAwz7piISo2OsxBNshwmkCfTuFJSiEx1MZYTEEnI896Srw1G0pfGWniRyEo+6oh2yIYbgPbRqmrb1iGT9vyijNlA0T+2suUdJ5J96MyUv4RrVFo5Q3HZhD6jbO1F5qwOFr2fNH4ygP2wyjE3xgvFjUxOg/9CLHk5vzaKkthZdQ3K7tRzdh80m99crRCvz/j7OhqC/IYMIAK18phaPFForkG/KN/5vkH9P+VFNbd2VMcXwVSt0OYXp6a3GLwJ2vKmnRCGTjuuMPtcAnICMbQDaqc/Brm+uX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8EnvMrHpCb99vhUVw0tOnnWHvKiKziIg5CVsH55wWQ=;
 b=RjkQNQZ+1cynlxBiff7mF2ammQxwd/h8LQs4JO5rMM5c6DynwPdaYY12TlroM/LCyZyandGxIcF1cav+OGSGQd+kZEFSo8SLq3IShacBjOAellJ2sM9XwIxcu9qMBd6c4bYc2yYyaWljJURSe82b4VcxAs6DL++hltdTOFKHAFXXFCqOAcBPLpxfdA2Q8ds/Q+yqdy7ZDiw40VGkLeKD7/8bHUacqctigIn8LUqgDK5oMbZPc1fiOelxhNOrm558eG8yjjb72aClJvb7cEm38LU9+q7EhlzV8mGPe6LKEYViTw1allczpaNvr40Ye4OneyX1bJVEOTpWmxlOObycXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8EnvMrHpCb99vhUVw0tOnnWHvKiKziIg5CVsH55wWQ=;
 b=BMRbJRqu5dUiBda1gYMTi6a/GXHxSsjx+rVK/kO3jOYhgDJq8ZOdlipO+qFqyegGVhUglo991hCoZZBxHrB6kMr7/Vwa7yvVvGCy/rAs4KZixZ6I45yiM6o1Pw430dv556iQQbBOGdulKBVtFU8XQgmfZEslj5VJSjOmElO4XhlmzKW6mHeuHO9HYOF5DiqtUGX3TLueik1ylYQazTrUqTr44s5cyo2sHbUuQ/uPRu5I2BGF+eVC8pGih5HxG9TQgXD+8XtvzEitHeTMwCsaetlfzWne325Ox9FOnSAmKVAaNRSXnvTEQAwOjqFdAnNdbYPqCHKjn6CKgaGOYOcMqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5978.eurprd08.prod.outlook.com (2603:10a6:10:1f5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 14:25:18 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 14:25:18 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Chuanhong Guo <gch981213@gmail.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 2/7] mtd: spinand: Add a NAND page I/O request type
Date: Fri,  5 Jul 2024 18:24:55 +0400
Message-Id: <20240705142500.2272803-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705142500.2272803-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240705142500.2272803-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: b71234de-dcf1-447f-d78c-08dc9cfe4baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|1800799024|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X4Cvnt6uTMjoARpb7yBR2t1fqM3tOClpFsKof2ibWZjKONvzqf5ItQWjW74U?=
 =?us-ascii?Q?WV1lvs5DfvyGoOdOnXoDUd9y3NHHpvptjMBrtD94lQR84RIuPH/QMsinpo9N?=
 =?us-ascii?Q?pB7iu8XDxpAX6vtAUuRNC51/gEpDXV5s7Nd8gZ9GXMyFla0vs7BKHduRee5F?=
 =?us-ascii?Q?7SZPZg6LVLAlp4LOOmq0ZhAdJSAIBsAToQZ/UkD40XWUOXAsSXVYK5l29+g6?=
 =?us-ascii?Q?44e+r+VQHT4jSBGEo+wXqwwqsc3fNaYGGPzR85WHSwh6MVH/JIkGWERt/vG8?=
 =?us-ascii?Q?sYoKAghO57XmC4yBVD2moxyVRgpmHTkZALHnXgQ9iY4QdWrHkZVagzaG466x?=
 =?us-ascii?Q?Klpe82cKQ43Y0f708Jf8TnfD85QcO7MH4BvHsqnY+jEy/xPkUefZNYrz3ULY?=
 =?us-ascii?Q?QOa/FY+Wdy0skdoOf7DwWiBvFa5nylv5oxnTAyXySvxtk4WV9fbk/l/7Kmwr?=
 =?us-ascii?Q?/VWog2SXklROPWIeQTKHqPp1jBNe1uoTMCWGNjUC/i3+Gk9pZxIcqqyWpHiP?=
 =?us-ascii?Q?8z59H/PrPPH+NkJnogwaDsqtl7FwvsRQe9jFTM30jGwygfY99B6dn+nLL14A?=
 =?us-ascii?Q?Vz6UELJopfz1GaCqygEp/HLFLLGqdFGvP4iB/T3N1mc6paqhzyZNifdmKvj4?=
 =?us-ascii?Q?ra574PNbMoO26krLLmmZKshT5XPHcLSuLXx5Mn1swnYUtGe5dYN5Yv19M8+l?=
 =?us-ascii?Q?saZM266R2Ms/q0rEPb8xgKCWvhts6kFAfMCB+Vm5WDxf245tefjxGX0VG1sp?=
 =?us-ascii?Q?zD/ZV91hRCZGDwsV0FPSNIdRjng5x/8eJFp0kp548HFf13Dr8nuLvEpqJ8CK?=
 =?us-ascii?Q?RnQfkAaJghgiqHb0076mmaPzqF3j83vvPY1lNu9Cu1s29oy4ADCmLrEEb/uK?=
 =?us-ascii?Q?G/Gvx56lGcbrp48th5RI4CwzN9dG8XN8Inugx4QHkIwkx1tBKYm2+ZOPK3ZE?=
 =?us-ascii?Q?x+rXV/tpqgAdigjshL2a1O5TRt6Wl1f9spFbuwCcjAupYAclI8o68Bte0hiu?=
 =?us-ascii?Q?e+YV4GrupsMki9+A1m25x6uu/SIDAq72YHSB70J3eWCm8/e9lCpp33uArn/y?=
 =?us-ascii?Q?yBTffqUrp1okS89v4fEir223kLW7t9zoMnirkxNRp+j4kzKHU6QvIcqum02q?=
 =?us-ascii?Q?iwmi/G77lSxuxznfJ6Qv/6+W/pB88a2y9uKRe3wDDXir0pBsii2yjKTqLMQ/?=
 =?us-ascii?Q?BLww9JAA3os2xa//xHX0xX3ZHrH0/6sGmpin9LEhtq1sbTKqepLz3Qa313/Y?=
 =?us-ascii?Q?ikhT8AdoUJ22TE5BZ17vRQC5VgvXxHd3cIqSI7g3NXKay9Fxl7OpTQNeOHgm?=
 =?us-ascii?Q?LOUC/HgjLl6F8FcLzL3LgNuDfQ++IY0R4EkaYDxbkuSuTQEPyyHN+HSsyazF?=
 =?us-ascii?Q?qkfipUcFhNPZ5guWd9hhuZxKP1t3AmPEKgOczq9V8BnmwfHH2vNZDit6KhuO?=
 =?us-ascii?Q?l8aO6rW5RB4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(1800799024)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fs3a9P1EYimbL0PIpReoTvbst5rnemh7HeMB3B/NKb90g2jD14o8WffoGvZf?=
 =?us-ascii?Q?gbI57TUjePy5C2JfJRpR+oXHQeBnWMCX9dAoOjPxUsU785j+zMWbm7Xb3DVg?=
 =?us-ascii?Q?2yWTh4hi9aYo/gj7pcZ0m9Pi99BdPwd88k3tycOpATJZti5FkCvxVLBM2Zjo?=
 =?us-ascii?Q?zvcIhVJFkqH0zC2LqgIRubAYt4jPoyVOyyGdvCi7R0hlPDlCeikeE3jTHpC7?=
 =?us-ascii?Q?kqBsG+la3SBjTqAyzCbdCVq8Vbvmpa19nueAqoFT0mpU/XrFQvYb4/PtjIS/?=
 =?us-ascii?Q?DGe8vyCS37bV5bD+/i+QzauL3kSP/OM3iaEOc6sB+DRH96gxnEu9pvxzMdrf?=
 =?us-ascii?Q?Fwjbp2yOnRpxn/xKrejptVuX4mB/BaDJFqc6E2AAkU3J7nj3eQRGuk92D2Ib?=
 =?us-ascii?Q?pJVRvOYZcxy77avqxvA2SkTQHwrjvj/lDH1uQq6Zo+uQAL8aC25L09hfeakY?=
 =?us-ascii?Q?UTaNdhHhp2F8jrMUYveZeh4TFjxNqkY0NLyj1AqjpxoeOx4P0d6FmBkRis9e?=
 =?us-ascii?Q?WxBDcrnpy4UBtkrwgZ4MbhSryIJkGG7IVURozOg5N/3VBllmE340RTvCoUF1?=
 =?us-ascii?Q?6sBazgC5GRp1wrtPZk9KKQOo58u6A3dO2fRqmgeFDJmASXpSVaVsVMrASUo6?=
 =?us-ascii?Q?7QNmCosATVd3IlPVcDn/8CLsyZy1e1u7P2Of1+2A2MyA1IICYpRIZhRpES5A?=
 =?us-ascii?Q?b7ptX6ZjCU04u+0EjwpkUTnFewqUIgWDgaR0HPT5/yGuHHqhiVO63n7j2lQD?=
 =?us-ascii?Q?e+fjIzBF470F6ci/I8MWDcCR+BOhh9E4AvUVxSlLu4PDeGbGy00efAGL+CaE?=
 =?us-ascii?Q?nZkP1Jn3A0hvU2aensOVLRa3RV+M8k9HqUI14b4ik9yT66o9m0VAIEZDtgMd?=
 =?us-ascii?Q?ZhCKstxO2HE/ATfO1WRXWr9Wb3BQ4BYaKqulEhesL2WLcTR2DLP/k0k4EJAG?=
 =?us-ascii?Q?w1e4mp7BBhb8EcET22xOXIK+Xo9pbNZXSsCuTnZ51uH8Z3GX63XhDhQN6kuo?=
 =?us-ascii?Q?pFVhKydTt6cb7B090pf1/MAloc/PlZ1x//P+vz/Pu+jp/ISdDZPlCEcj7g1M?=
 =?us-ascii?Q?rbOOsSx9cCso03nzk3YAc8r4zIx3TDhoM0JNeGWOWW7NMIWwDxgnmApCt4nQ?=
 =?us-ascii?Q?gQCBg4abzBBTfQBIWMy840OqIrHYQZ04ElS7w1LtzP9wZeb+I7OP9wCs9bAV?=
 =?us-ascii?Q?yzoiqYgbIj3J73xNWiwgn2rOu6gL1bmOw3ZphSOf+Wec53ENzn673Hri+hus?=
 =?us-ascii?Q?/A6h5T99TZoekKS+X6Z6Au+6nD0GgnCsn7hLXOa4rTwMzAw8jnLfiAWnbkg+?=
 =?us-ascii?Q?AdIaDRX0/VE6aG+kfWKz0rE2fXCyOni2RloyZqMPtJ+fDkia9tt1y1B6uIW3?=
 =?us-ascii?Q?b//697H/Tatr6gdYcadVV1Zhy+jTtmCt6/h/5KwjAAs48H3SojE7h76WUUoj?=
 =?us-ascii?Q?lWMOCjhUh4lebJFCbWca1xxJi9A0bAdPubUCmv6dDwHCq7XAU1/0p7Ac0hse?=
 =?us-ascii?Q?YfeXivqPEP5PFjrYgrB+s7lvk/Jsv27/nj0XMAddbuPUMnxAbu8VXJjnNpx/?=
 =?us-ascii?Q?oWHCO7GpNJ9zhSTuhTWfOCIrwX9SX9tVj/KZOoPYi+tKX9lu+i6JkEigK1Of?=
 =?us-ascii?Q?UkVHFCdTMOLQGAW7UANdjJk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b71234de-dcf1-447f-d78c-08dc9cfe4baa
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 14:25:18.6460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+XOaVNPGXUfBEOAO9IbAnxC9Fdv5tZ4kpJNctPt7LFtPC6YRQD7O40ALszdWbPmhYbTWbOQx5NMP3WZ34j59AHtoUoI7JoVci9jIxtlRBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5978
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
2.39.2

