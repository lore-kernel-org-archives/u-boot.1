Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9268BD6B6DA
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 21:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB93589277;
	Wed, 30 Oct 2024 22:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytec.com header.i=@phytec.com header.b="fue0FruC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4990889257; Wed, 30 Oct 2024 21:40:44 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::727])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 629C989250
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 21:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ggiordano@phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSxQSQby6VxCmqqBmF5xlvEWOY4jZ7Lqk8GCyhQMLX+rpswV+khLgEZeag4NUawHAUdik0j96Zx/G9MBOaD82krCUeMatwLobizspNk7KNbL3fAcgvVkCBrXV3VXmOF/9Yky7AuMOr2nJfIvpJDkWDt48t7ngrbV1mzToW2tgBUsqMyj2jzfoDHOk0KYJJUWw939i+td2hwJe2EwQFl0E5pHfZ7lDgHUjJg1Jj8vMdvQfFxGAgL9IHBiuguTLPzNTsAsmlWdxu1KprujKPIJUKk/356SY9ACDaJKFxRNgNLucV1SGh6jNBgQWRo9aebRimqpeC4Fl+d/EDdUUOlD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCqTZrhhCP04prTz11Id5Lmp6kpFGVkbVUcGqw60xgw=;
 b=h5+8h10TcF7qF/5PcxSVg2zqvqysAwmrGi24cHiMaN+avZYidpi7TnjRBtzTChUMf2FMPt9BZBNEmXGQ57nIiqk2xqmUBMIeSvpBbnSPeRqZ3HBHdu1PLWIgkK4EJrECjWsRwemnzm86L35zkn/zXtPWGNWr2Mos/r0WhGGzm1asabpZkD6wXDMsHDrV5InES7xQ2R0wvpX44E7vPA8rGx9+gDToYClWiqEdtPoagmc0AQlN2dQT8EPpJPE3J6KaoHalG48fy+7EtIZuLGV8ZRglJfvrk6steb8JbzPYjvKeQ05RITyao7a/jcysMub6PqaGmheNg94Y4KbkAfgfjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCqTZrhhCP04prTz11Id5Lmp6kpFGVkbVUcGqw60xgw=;
 b=fue0FruCRPs8GYs193NX+uQd+IWvmdSdZA4K5HFmNa+xCR3g8cY8cvHzvDq6ewkYfry5UnELvIVqkNzC4kUG2TBT/t14kBH4a8hDDkngGuE0ydLAZufZKOK0y4jHnmpiYrDLlKd9FVd0amKh/MDxg7Vy+behEvEZ5DkVuY+sAr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by DM4PR22MB3698.namprd22.prod.outlook.com (2603:10b6:8:65::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Wed, 30 Oct
 2024 20:40:36 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 20:40:36 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: trini@konsulko.com, afd@ti.com, bb@ti.com, w.egorov@phytec.de,
 vaishnav.a@ti.com, hnagalla@ti.com, j-choudhary@ti.com, a-nandan@ti.com,
 nm@ti.com, sjg@chromium.org, a-bhatia1@ti.com
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH] arm: mach-k3: am62a7: Provide a way to obtain boot device for
 non SPLs
Date: Wed, 30 Oct 2024 13:40:23 -0700
Message-Id: <20241030204023.2421381-1-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:408:e6::17) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|DM4PR22MB3698:EE_
X-MS-Office365-Filtering-Correlation-Id: 3324d604-f0a7-407d-cda0-08dcf9231b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?67GHc0rZUIVZ8KjEkfXFB54q2wz+9pOT0bHizTuRXjtX7QY0pZcnkDEIm6ny?=
 =?us-ascii?Q?AhOkEbtU/xWY6lgGzlzvpKZTo13fgqr9biN+9/1OsGWS2xMj0BHBvgE2pQIc?=
 =?us-ascii?Q?jXMBzoB56qL+rY90ZVva7E3x4vBlQO+e7ZxvqPWuHQQQ7jX5Exv/+MbIvnM9?=
 =?us-ascii?Q?FZHzXbBWK1EIYv9Gn+YE89j4ov66ecWoxrh2ShFglohWd5Fu+oPev5EyeLYN?=
 =?us-ascii?Q?noIoFRPHquSYI4DWw9Fe09Y1wbcjuN7qpTyu03kCophVAGpe6HbRiKr42gW3?=
 =?us-ascii?Q?HhUODiXq4VkzGoXF7FjEXAPsSPUgHpe55R/SQuvqtfRtIbbDquJurcuLpNv2?=
 =?us-ascii?Q?bjWIol/VgRzDkZ8nAXC+0GDOVIDDLp/cFld8tQ4BUky5wTadLzAyOi6lh6YI?=
 =?us-ascii?Q?B0wObDqQrRkPvhYoa0ZhFA2vdWxG1GdpRFv8e/J8G+WDqBsRyzAFXsMTtLyI?=
 =?us-ascii?Q?yi49XWCQuNDP6cm8MFl+eWIEH1L0uAMNTLFNnxLxdCB0Tqg8a6JPsfcLhTET?=
 =?us-ascii?Q?F8SK/b7nj/9RkIfRc/6qxAJhEsCxdG3rwtFcfTeIj1psvtjb2f8ZSYcKjXS2?=
 =?us-ascii?Q?PuvvSk2OpzdzzHyumKIoeouIbpzuQo4Syl4k77dVqOPxjrhm907ckSpwD1rN?=
 =?us-ascii?Q?368PEiN9XpAehhH0eT5UyjdjJdrWrrsgjuqWFa8i9PMvpcq7JGBndcZeMB/9?=
 =?us-ascii?Q?u+2M8b+69zXXULaG9tYbuVZ7rFKXSZ2evo9zHLvMkwOoAme+l59W5yp/mxGw?=
 =?us-ascii?Q?gXXErf8R8MF2ysGYV4ebTuALnjK3pqVkRgDpsyFeoK8Sez1zSugeA0K+Cmo6?=
 =?us-ascii?Q?RUAy8YDDFwAIlfLHlIDQ6jvCv3z9KPVEA2bnzsdF35IUXVeJlCI7erFwucsi?=
 =?us-ascii?Q?zN8o74t9LFFq33Or/Mc8LZh9+szXBLOegEksEAN37Tac8OpPk2s6mNPlR8d/?=
 =?us-ascii?Q?zUabAzdMHsqykJHAYSg2rxYxIN6P/BmlN+AtmHEEodBQ7GbqF9t37b1G+x0c?=
 =?us-ascii?Q?zREiYQpsxT43XwM5mprmKXN7rV7dUPkGp2ikyP3KryNSVhSxhqnKaej3MyqI?=
 =?us-ascii?Q?eYFl63MlZN1SEJcgqudFFxT3pZS0shM+yNzwM72RXAMwGN9VvU6bP+kmy5Yo?=
 =?us-ascii?Q?cm3X0yHbvLw4I7vOnjuzFMWbbSZk4w/RbFLTKxZcI2MtGM6LSIVKJh71CKwM?=
 =?us-ascii?Q?drtHqTF6dEmLwvzp/H/SJpGCLOXCY0ylrRhr5+AHhBKcIuGGnutVk6qphlAO?=
 =?us-ascii?Q?9Elwhq1CuQnnFw6BoYJ41MVEiHXeI1w1eChBoj0UGFVaE0Aozlxjm566pEZG?=
 =?us-ascii?Q?tNJF/ZeqW1RS6VdTdZWcs7VGLsSDzUP9tWLkAo9F3La32AZ1H1P+d7kxmb/g?=
 =?us-ascii?Q?Sio6NZoRKRJ5h9B0goLnCBJBD+Ke?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR22MB4354.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hiQmJdlQvkEq9+6xhZ5Pyw5VV11aEbJcuULq1vAYvAGDrOh8cWOAsehgpoOZ?=
 =?us-ascii?Q?T5nfOeKBpwymCxDA+kUPoF7wWzK//9W4hV10buwQWhOvXmt2FTVXnhGJfkaq?=
 =?us-ascii?Q?auVlqiShWgcG714mlvAR/0ATOXrs1XKHrBrAEHBtnfToPp+UKTktHvb+DP9B?=
 =?us-ascii?Q?ojQMSi5OHbt1h64mjoxUjWrohzQmV2mqWCVdUad+1Lp1rSlvv1lwrEeivEFM?=
 =?us-ascii?Q?p6fdAdfm8p6vtVb5OTznsRZ+nlbpGLP3TDbQNg1FQt7g4WvgbozRZJTk/rbH?=
 =?us-ascii?Q?kqavg7saNoLN0KtqZi0q9AwH45Ktisd4XgU68+NHB9TpaRoYX88z+I54pdtS?=
 =?us-ascii?Q?iNwEjpChmg/mX3CI9uAkmPJnmoboGAg0Ng/0yBjdM2MJv025KLnlsXe7vKbd?=
 =?us-ascii?Q?3gvw9tgkYJusUCvQKGn0HaBfpGzkK8OKn8dPD+M/G6fuzjEPtjGBCo+/wZt+?=
 =?us-ascii?Q?syg7Q15YeMjl8yWixdDKnx2acXxZjw9RLMEsvzTE/yBioNiJMdXNkwftaaay?=
 =?us-ascii?Q?WBxxDcrHkeKVy5boFAell96uq1LyiHJsfbsX1lHOzeeSHC9UeGz/7l2W3cpK?=
 =?us-ascii?Q?ObRD5oe6zqUNi69Cs5pBw7fUFrQteelBvfViUP15XkPWXIZDwbXo+fTSAO5l?=
 =?us-ascii?Q?/ux7wrgZHBo4c5P96mvaAqJvhfMxPjMPHYRf1uVDP6MiuCzFRbFk14+cCN39?=
 =?us-ascii?Q?+GX1XH9Tw9h6x2kslrjmPtDiwSqCWpmN7p+1zJ1HzlPBPys33vzIdp8CpRl/?=
 =?us-ascii?Q?E9qf459vsyxMfKmGmP8lVRqn6vDrzKWMWcd9C6jiJhx0sEY0isTY4Qww2YYR?=
 =?us-ascii?Q?dFHvsTmNVmpQUW9JMMY8+bgzeFMtpoMXojxVsvQQ5LJ5sKzuLtgSn69i9stl?=
 =?us-ascii?Q?nxDPWHdBUmlNqVN7rvRTL2vbN0Q6EQW98FQas8gUazubZqTA3hG8PIqsinmA?=
 =?us-ascii?Q?MdxMRJAXl9+7BAtxDnK9QSF1dFB2ZPkIKdKhg3/G2cljwD+PU+HOXC7qYGzc?=
 =?us-ascii?Q?2ZSJ+SB7uTFb4noqvifI69BUjAOFR6U/XZghA9ueeVFkcJz0RZEY40YsYqns?=
 =?us-ascii?Q?Uusv8byyemfompcIT5jbmnqvvaknascrxOO1wjEkyG9IKEtOU+QCNwHdy9lm?=
 =?us-ascii?Q?Tei0kfflcho/lhAIzEE53KNIRrK71dbW8vIsS2P9Exxb7DYrCcNQkAsRvLtK?=
 =?us-ascii?Q?jK406a+dUdOAc7qYQSUin0jE/Zv+gJW3sKzz7f9qJnVgKFyTZbBd9K8Fq+Wg?=
 =?us-ascii?Q?wEZCaQnOg1uoMd1gE5216/CJpwBSC+y7CAfO6l2xQObc1TBcH1jN2sAkWnY0?=
 =?us-ascii?Q?O1vd4ng+Toga8EsrD6rv5f4MlAbpaGW7znet/7hjdWir4KEptcf+7RZQQkJz?=
 =?us-ascii?Q?4oVSV8nI0XqqcL/GNvdjx6oILpCeAs6o8nO+KSMg4UJ0+l/h+TQCrqX7pjcf?=
 =?us-ascii?Q?H19acXujBojKnOQoBBC/Y4q8XJzM8Fbu4zgUY8VM3HTeCx9H56FTzU6be3Yr?=
 =?us-ascii?Q?yWlRB6n1vJicxGRrQLruL35ZDFj1MG0NTbftCPMEG6AZwmoEeu3bnu+Uw4Z7?=
 =?us-ascii?Q?Jk8EZLcpxB/6SlIQ/YnBoN6wLz6vHZ/VqzzsHhgm?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3324d604-f0a7-407d-cda0-08dcf9231b99
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 20:40:36.3891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OaMO3/Izlm63WoRyQexKLvk7PK8aanZbD6aUD4Wb4AWDuJ//HIqvDiw7l+7NfuSJo4BK1cwFZrfr9KN8y60mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR22MB3698
X-Mailman-Approved-At: Wed, 30 Oct 2024 22:00:12 +0100
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

Introduce get_boot_device() to obtain the booting device. Make it also
available for non SPL builds so u-boot can also know the device it
is booting from.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 arch/arm/mach-k3/Makefile             |   1 +
 arch/arm/mach-k3/am62ax/Makefile      |   1 +
 arch/arm/mach-k3/am62ax/am62a7_init.c |  97 +----------------------
 arch/arm/mach-k3/am62ax/boot.c        | 106 ++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 96 deletions(-)
 create mode 100644 arch/arm/mach-k3/am62ax/boot.c

diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index 8c4f6786a5b..ce09a30e58f 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -10,6 +10,7 @@ obj-y += common.o security.o
 obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
 obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
 obj-$(CONFIG_SOC_K3_AM625) += am62x/
+obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
 obj-$(CONFIG_SOC_K3_AM642) += am64x/
 obj-$(CONFIG_SOC_K3_AM654) += am65x/
 obj-$(CONFIG_SOC_K3_J721E) += j721e/
diff --git a/arch/arm/mach-k3/am62ax/Makefile b/arch/arm/mach-k3/am62ax/Makefile
index e2ef88196f8..4e35e0c844d 100644
--- a/arch/arm/mach-k3/am62ax/Makefile
+++ b/arch/arm/mach-k3/am62ax/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_OF_SYSTEM_SETUP) += am62a7_fdt.o
 obj-$(CONFIG_XPL_BUILD) += am62a7_init.o
+obj-y += boot.o
diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 0f62f39075b..5c0d3ee6869 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -171,102 +171,7 @@ void board_init_f(ulong dummy)
 	debug("am62a_init: %s done\n", __func__);
 }
 
-static u32 __get_backup_bootmedia(u32 devstat)
-{
-	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
-				MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
-	u32 bkup_bootmode_cfg =
-			(devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
-				MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
-
-	switch (bkup_bootmode) {
-	case BACKUP_BOOT_DEVICE_UART:
-		return BOOT_DEVICE_UART;
-
-	case BACKUP_BOOT_DEVICE_USB:
-		return BOOT_DEVICE_USB;
-
-	case BACKUP_BOOT_DEVICE_ETHERNET:
-		return BOOT_DEVICE_ETHERNET;
-
-	case BACKUP_BOOT_DEVICE_MMC:
-		if (bkup_bootmode_cfg)
-			return BOOT_DEVICE_MMC2;
-		return BOOT_DEVICE_MMC1;
-
-	case BACKUP_BOOT_DEVICE_SPI:
-		return BOOT_DEVICE_SPI;
-
-	case BACKUP_BOOT_DEVICE_I2C:
-		return BOOT_DEVICE_I2C;
-
-	case BACKUP_BOOT_DEVICE_DFU:
-		if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
-			return BOOT_DEVICE_USB;
-		return BOOT_DEVICE_DFU;
-	};
-
-	return BOOT_DEVICE_RAM;
-}
-
-static u32 __get_primary_bootmedia(u32 devstat)
-{
-	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
-				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
-	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
-				MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
-
-	switch (bootmode) {
-	case BOOT_DEVICE_OSPI:
-		fallthrough;
-	case BOOT_DEVICE_QSPI:
-		fallthrough;
-	case BOOT_DEVICE_XSPI:
-		fallthrough;
-	case BOOT_DEVICE_SPI:
-		return BOOT_DEVICE_SPI;
-
-	case BOOT_DEVICE_ETHERNET_RGMII:
-		fallthrough;
-	case BOOT_DEVICE_ETHERNET_RMII:
-		return BOOT_DEVICE_ETHERNET;
-
-	case BOOT_DEVICE_EMMC:
-		return BOOT_DEVICE_MMC1;
-
-	case BOOT_DEVICE_SPI_NAND:
-		return BOOT_DEVICE_SPINAND;
-
-	case BOOT_DEVICE_MMC:
-		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
-				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
-			return BOOT_DEVICE_MMC2;
-		return BOOT_DEVICE_MMC1;
-
-	case BOOT_DEVICE_DFU:
-		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
-		    MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
-			return BOOT_DEVICE_USB;
-		return BOOT_DEVICE_DFU;
-
-	case BOOT_DEVICE_NOBOOT:
-		return BOOT_DEVICE_RAM;
-	}
-
-	return bootmode;
-}
-
 u32 spl_boot_device(void)
 {
-	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
-	u32 bootmedia;
-
-	if (bootindex == K3_PRIMARY_BOOTMODE)
-		bootmedia = __get_primary_bootmedia(devstat);
-	else
-		bootmedia = __get_backup_bootmedia(devstat);
-
-	debug("am62a_init: %s: devstat = 0x%x bootmedia = 0x%x bootindex = %d\n",
-	       __func__, devstat, bootmedia, bootindex);
-	return bootmedia;
+	return get_boot_device();
 }
diff --git a/arch/arm/mach-k3/am62ax/boot.c b/arch/arm/mach-k3/am62ax/boot.c
new file mode 100644
index 00000000000..af7fce1e5e9
--- /dev/null
+++ b/arch/arm/mach-k3/am62ax/boot.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/am62a_spl.h>
+
+static u32 __get_backup_bootmedia(u32 devstat)
+{
+	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
+				MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
+	u32 bkup_bootmode_cfg =
+			(devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
+				MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
+
+	switch (bkup_bootmode) {
+	case BACKUP_BOOT_DEVICE_UART:
+		return BOOT_DEVICE_UART;
+
+	case BACKUP_BOOT_DEVICE_USB:
+		return BOOT_DEVICE_USB;
+
+	case BACKUP_BOOT_DEVICE_ETHERNET:
+		return BOOT_DEVICE_ETHERNET;
+
+	case BACKUP_BOOT_DEVICE_MMC:
+		if (bkup_bootmode_cfg)
+			return BOOT_DEVICE_MMC2;
+		return BOOT_DEVICE_MMC1;
+
+	case BACKUP_BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+
+	case BACKUP_BOOT_DEVICE_I2C:
+		return BOOT_DEVICE_I2C;
+
+	case BACKUP_BOOT_DEVICE_DFU:
+		if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
+			return BOOT_DEVICE_USB;
+		return BOOT_DEVICE_DFU;
+	};
+
+	return BOOT_DEVICE_RAM;
+}
+
+static u32 __get_primary_bootmedia(u32 devstat)
+{
+	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
+
+	switch (bootmode) {
+	case BOOT_DEVICE_OSPI:
+		fallthrough;
+	case BOOT_DEVICE_QSPI:
+		fallthrough;
+	case BOOT_DEVICE_XSPI:
+		fallthrough;
+	case BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+
+	case BOOT_DEVICE_ETHERNET_RGMII:
+		fallthrough;
+	case BOOT_DEVICE_ETHERNET_RMII:
+		return BOOT_DEVICE_ETHERNET;
+
+	case BOOT_DEVICE_EMMC:
+		return BOOT_DEVICE_MMC1;
+
+	case BOOT_DEVICE_SPI_NAND:
+		return BOOT_DEVICE_SPINAND;
+
+	case BOOT_DEVICE_MMC:
+		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
+			return BOOT_DEVICE_MMC2;
+		return BOOT_DEVICE_MMC1;
+
+	case BOOT_DEVICE_DFU:
+		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
+		    MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
+			return BOOT_DEVICE_USB;
+		return BOOT_DEVICE_DFU;
+
+	case BOOT_DEVICE_NOBOOT:
+		return BOOT_DEVICE_RAM;
+	}
+
+	return bootmode;
+}
+
+u32 get_boot_device(void)
+{
+	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
+	u32 bootmode = *(u32 *)(K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
+	u32 bootmedia;
+
+	if (bootmode == K3_PRIMARY_BOOTMODE)
+		bootmedia = __get_primary_bootmedia(devstat);
+	else
+		bootmedia = __get_backup_bootmedia(devstat);
+
+	debug("%s: devstat = 0x%x bootmedia = 0x%x bootmode = %d\n",
+	      __func__, devstat, bootmedia, bootmode);
+
+	return bootmedia;
+}
-- 
2.25.1

