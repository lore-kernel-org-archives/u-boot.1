Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D819CF34C3
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:30:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B37DC88E65;
	Thu,  3 Oct 2024 23:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="O8IDALYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7FC589020; Thu,  3 Oct 2024 23:28:28 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B786988F60
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGe0HOB1K5mFF5tQezvHMVusOo8FSvOlGCYqZZ5k6o3GU0hx3gJZ+Mrd+IQhlrEke1ESXEhEIruOdstxrgMr/8+iP5ulzeKdD1gP52wXA8M2EmPYpdoYiVJUU3lWKNbTZfsg8FJ9hR961eQYuLd3461kAJrgfhNtDRekLAcF/toPFSIrLhZa1Tar1SrPmFrx+6+tfjj760WSezroxyBbGP49OH+RZE45gMUuY3sHi6UmqyzCeaPkXDOz5M/I2A6y8VNYVq1e6i2W8LwsPRFRF+YAeJ1kof7apWXvNWZAHIg5fVD+NDq3dzeTHx2b2HQWEg+iaGNHgulLpZiLp83NUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MvmDKyt7Sz+URPXbK4nZQ/FnXgamE8ubop+LtYSrZA=;
 b=rNbO/pXirgxlISGlvrdEgRDWiqMqi43LE3dlE/s68nn6mMMhHh2t5U6kDEQ4j+hwvTfHUcdL1a+cenVt2n52fKuaxJDBznVUYR1C9BFjH0aqwAJWF4IoQEgOu4K9M2/ka5esPNkS1be1oRsIBpDEkS+CybI33urUKEOpWiJ9ZucwVZrVdhEwAVEBi+t/jbxmsZo3DLch4g5TEcglMqsSc1d1RlWB1V2bBQCCHCGeiOwX2ry6eSVFf01yB37tl8+vAvuYsOspscz8Xsj6zjGSYt4XLz0ATsJBWrI9VmCjJDk0/mWdRbW5YQ8oZ2sb1VSA2uHDRksBpgq+QNNBbkQSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MvmDKyt7Sz+URPXbK4nZQ/FnXgamE8ubop+LtYSrZA=;
 b=O8IDALYujTp4R9Nub5xRLG34nVMc1wECETsEbjIF3UTk4wUstERQsvvrL0JLCvFkHNzT4J/yOiRukxEPHr9s06fmKLUARJKutM14DpAd+41yoa5KrT5PwFV4lds6HsoxerUn/igWkLsVWii6e7mnN1VDO0n6QBfv1q45L6aQWLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS4PR10MB6063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:582::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 21:28:24 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 21:28:24 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 11/13] ddr: altera: include u-boot/schedule.h
Date: Thu,  3 Oct 2024 23:28:00 +0200
Message-ID: <20241003212802.3810-12-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003212802.3810-1-ravi@prevas.dk>
References: <20241003212802.3810-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0061.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::21) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb20c10-b303-437a-9399-08dce3f2500f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uVsXWwkoVteIaM7Ra8OnaG3zIFaG6SKpxKlH9iJx46tezBZpqQk+7puDYJSt?=
 =?us-ascii?Q?hAfPNPIHo7oPJa2hcW/4RD+uw5B23e5r+6TaJdTXSDFV3BzD7R6iOBLKE2XU?=
 =?us-ascii?Q?bIMMA2+jeDj5peA4L0owCxCYEPdbuC2SvRk7pSPp+Qn01S13CpldnOQfcfvP?=
 =?us-ascii?Q?8dTV7NKH40S5oWS5r2pXDkde0HstTl+H+IfIjdagfPsvNAxZDopmvBXbqwvE?=
 =?us-ascii?Q?ktAZqkea5tHWM6ZvzS1skPLmh79QG/EO4O8Rax+ombfGaeT8oJrd9JHcQ+kf?=
 =?us-ascii?Q?aWgGtQzTiGeCyB4GSqYNQHu8ZgrM7T6jgfrmf0/WrZz6uMSBvAbK2JPAsdA+?=
 =?us-ascii?Q?3c2nsUBLnTxiTBo6e7w+TVlfvGJWYq/gmTX4x1jVdPT4iNbOos/jz54dgw42?=
 =?us-ascii?Q?9jz7qUmimE5sh2rl3PBjSIHlo3VQIvD5hZuEhO/p+zpA5UKRh8q21bMQQutl?=
 =?us-ascii?Q?5FfVMhr2/gUwjqhay241s5owB7g/tDd46+J5W3nKpPmf9M6Aryxln+71Dozt?=
 =?us-ascii?Q?7VEaexEGVEA36sWt7V9fRD/Cjo5rKz/aplYPeSub6/pJxaqUyHZGEr7jJOdD?=
 =?us-ascii?Q?d4pgHF6BcCZQlAWzpajN6hJ20m/E/h0SAj864ScdaWW4DFrnUPjtRu8OHYl7?=
 =?us-ascii?Q?5+MidYXUjwrAhnKjSyi8z5YNRz4C4gQHX3hYQ/vv8Y1tPSmWUcxrIgzTZM0H?=
 =?us-ascii?Q?SAwg5ldzBHSh4uqta7F7C8oN8Oy0nY/fXNGBniD9UXj35pcV7XJid/eo9S83?=
 =?us-ascii?Q?x+hyyKVBSMpIr080gRVikgO7JCICiT3emD9q75+4f9k8tJBjkIx/R3xAPoL+?=
 =?us-ascii?Q?SqO5YTb9X3NW9HO7pzXJgIHpWS+D6bRlTZFsi0b9tp/4BKGvdpMK/0AiZyWj?=
 =?us-ascii?Q?m+npnX+x+kQHkKToTzqE9YvAgLft1RED8bH+otey7FjSw7kHOR37GVAYRjXQ?=
 =?us-ascii?Q?h/Y2XiLPFg0PuqYnJr7TeRqSUx0cXAgXWO1e3ETfisMe9zq8pT0JDydkSVC5?=
 =?us-ascii?Q?c8qx1rxXSUEgB8XVNauWJv489/HPXo95cItCnVTv+qMeSQ2AIrboZz11N3v7?=
 =?us-ascii?Q?kFxkLoduMxXy8EWq9CS3mphJZ64QMwd/ApIb+heUYHd6cqrob5T4+KzJ3Pk1?=
 =?us-ascii?Q?5EY04RD8gsfxNGILVgo0aNf0HhmEaQFj6wuNzPr/RNSpQNVy4YRDvdT8xIU6?=
 =?us-ascii?Q?sT8HKFBDB9NN2c1U1zKDsiYhMm79zPUfjeVVq0Pwt52yc0qYHrU7NXcAd28Q?=
 =?us-ascii?Q?ErP9oQqRjUk2RcYTNp3G86cXtjj0e38+iATAcsVx6lnOyRVLGBkWNVzQrkqQ?=
 =?us-ascii?Q?j7W5YgXcT7kfxCPduseOnCif58N9Yk3mRRgaHR3GyaWABg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lzRFsGxuP8eNJb2GbJD/k+WxwQEUCTfMajD1DG+Zkn0AeaZ4RVUmUL3ldtbS?=
 =?us-ascii?Q?31KqRJCD4qP4PZ6AD2HEK6mJqowFjzCNQ4HUQtN1oFHtPkRWePidyAAsAWod?=
 =?us-ascii?Q?JTV5Aez6m8DlOS0t1BNIzG0IxMS4EA1mzwxAZiTElyQa3KzLugICO7VenuRY?=
 =?us-ascii?Q?Wz/nUp3sOnMJXtAnldKhzKATndukNSkRapfDSfYJlRPyseAhapzwwWvBu+lv?=
 =?us-ascii?Q?1b50V9KRhzIQPB3+Tn8E14zbpLiMtyRhsU85/c52wqdPf0qf4J0X35XYuI0B?=
 =?us-ascii?Q?VmLBOzuNTLeDMKKXmi+fLIYwxKnaRRt2Pz/zVSFtKl4eFIp2n74B6sqzSwu9?=
 =?us-ascii?Q?YWLL1Qiyu5oFmL+3WtInn6bnHJzoqZHiYMjKN7PCKDixahl0x6M1eUbG9iDk?=
 =?us-ascii?Q?DcfmLFyX0s/eRcEJ5SRcPIOUG+XkxvrRwZFasZ8KUghQPry1m89Ggzn9TvMR?=
 =?us-ascii?Q?41QxwEFaDapKZ2bUQifHEBu4QwQ5pqLXuqZm/9xdY3r5fMfBnzKgyKydQoD5?=
 =?us-ascii?Q?2WOS/iP3uNacn8YZsZdQ2aqzRivs6WRF2w2+Fba2PPJXrifj1P3a7LV2uMPv?=
 =?us-ascii?Q?GaWq6js5vnivz4q7KFaCsrLnJycjcQzq0bDfluJImXCmUme9RRUnIDNvSMIy?=
 =?us-ascii?Q?QLBgU4/hghQJLEGH0evEQuIIhBPLtbrtPcgQRKL9+zcy2vaspTUUzqlqQ949?=
 =?us-ascii?Q?nf2Shl+Km6E2MXt8O038wcCVdcE70xQXWBereUAqhLUrrlL0cVSm+PMIKedL?=
 =?us-ascii?Q?JPcoV8ZIOeAFJXW5jIIMhrW5f16EkapXPwlfn4xRD3XlmCfdCLZjaxIKxz9g?=
 =?us-ascii?Q?I8bC4uJm9vbw2z1tv18LVxDAsJoUSIDzacjyptxTWTgIJiZSIll2z0Z/TkXd?=
 =?us-ascii?Q?PTDogmgk1pyir0pFhUDmRJkgwhisIT7nY4IHxUVZLtU4/hmytuJqghPoVin6?=
 =?us-ascii?Q?4QxbpVnKs/7XakoR5Pn6SKaeMDMI/88zHvK4sS+cGSx7I1AggQMWg5WLOGho?=
 =?us-ascii?Q?kdlQg6EW5YjOasLS1I9cSoJ05+E3FDYxzrrFz1tI3lxniiOMXMfp64OFlL4J?=
 =?us-ascii?Q?VZcNaymR+WiOmQQzYaDtxwoodWi2pKJ/sT+sVDVsYoLXPGqGigopZeSDvJSx?=
 =?us-ascii?Q?qbpUm8kW03n05WZJuJMkGxyuVy9DZjVS4xiF8ZZ2pywWtQIHC0FNYqctB4ZE?=
 =?us-ascii?Q?x8Sd/xwvys8wAKtZx5toE5TtvHAJhPw44JpfCZelLVgkKXNYV6DKmckCDyUh?=
 =?us-ascii?Q?vrlL15IhG6psE3BUkIKMaajOiVuWG8mumwV5XoX8jljeBGWCg82RAlA+BP99?=
 =?us-ascii?Q?vuSMm8NuWHUmyStOv8mS3AEgivwF1qcmxlhA4kR2GVPEP1CnNa6cpjj8NScL?=
 =?us-ascii?Q?KSchXt9xJEEkOT95ppyuydhq91aD/1j002vVO5ORkA82RiuJg77H0L309pKf?=
 =?us-ascii?Q?r3AIeTVSCQhnYsmvjf2W9g0lvB3vz/0hEMFHzEjL703oa8AxdqYZ2GH3+mT5?=
 =?us-ascii?Q?PhbyNxMO2dJsVdWXzHknPoNaD+0EzSqGhV9ZNRE+SpK040SLkA+tHNnBN+mm?=
 =?us-ascii?Q?hrx+INu2ggUhro7JXvUbaYCt1uMYUoFLMTzZTvLp0YsY+Grl6/UjQ2TH7kBP?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb20c10-b303-437a-9399-08dce3f2500f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:28:24.5351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWiRXiQY1eNEe6m7VZG66wfigw69IJMEIPZvMFLeWaeDKpowY1lJhgdMv/LPfHNBtLu/tZhaMiY+3tULPOR2MreHyMNbVMlfgvkfsuLFADk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6063
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

These TUs currently rely on getting a declaration of schedule()
through some nested include. Include the proper header directly.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/ddr/altera/sdram_n5x.c   | 1 +
 drivers/ddr/altera/sdram_soc64.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index db09986f64b..d1fc93b6bdd 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -22,6 +22,7 @@
 #include <asm/io.h>
 #include <linux/err.h>
 #include <linux/sizes.h>
+#include <u-boot/schedule.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
index 9e57c2ecfa4..10a8e64af3d 100644
--- a/drivers/ddr/altera/sdram_soc64.c
+++ b/drivers/ddr/altera/sdram_soc64.c
@@ -24,6 +24,7 @@
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <linux/sizes.h>
+#include <u-boot/schedule.h>
 
 #define PGTABLE_OFF	0x4000
 
-- 
2.46.2

