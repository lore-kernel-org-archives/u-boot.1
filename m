Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5D7E9E30A
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 13:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29CAD83DAE;
	Wed, 11 Feb 2026 14:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gQFfxL7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E10D9831AC; Wed, 11 Feb 2026 10:49:44 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48A0782BF2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 10:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-sadik@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5PWQyeT4Jh/OiMAg5hWZuZrObKfsDcJfuIpAhUjoksqhZgQjb/Q5uQzprSHcRC4Df+IMif/k9onbCXl6nxYKVCmOg0AzFSukw7DXtozBV008YjEMRqqlHBhuVV3urXZ3U4R0mqsh5W2KnoRaG2Y0/tr8ZNqGCzH7C1ErACXYYcCE+ULxzGRy9G2cSDCNWMT/qLLNMcnDucxp0cJZA+0pyqbqnXkiArpsfk5V6MkN3CqMqD6TrsEwzD/JzGZdBWCHpybKjPshXhOZV/O4novde6EWBG6gnzQalQsDHwD7fJ3MYFFIi2p/rnwbuj6CE/GvZ/DRVlIxP3+l1X5ToItaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9CJvnujI3QrxulsikVr+tdTPD2j/FMATUpJZDavZtw=;
 b=wHuqq01mIuGcvT7q0t9n6je/n3gu3ocLYoHvMP8GljtXX3UMDdMyrd0QtkdgHiWKgG/XToAd/+4trPGPFpcoAbW11uBLgWQRfhaayBLc/WOA58Z0qrAJF7uqcLEkDsL4N5xfUdO1SesFhyV24xCoqJTOijo7MWLW9J44WaEFXeZ3x1WD5wwO7OjOIuqYvhO84XrS+CUXlVsMmTauaeabvmrV7ftAqc9UJb4oumCpMaY9pUYRqE/KS9fSnGpPfG2+rWMJJrMkLUSfk1vkEIxsqakxNgVRqdK42DrvaJzca66Ow4HH6kWQLBvU35XCY3WwJ6loaAqWUzd52pGlAJxqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9CJvnujI3QrxulsikVr+tdTPD2j/FMATUpJZDavZtw=;
 b=gQFfxL7Qeru8zifizWoes1jUkvs0q84cLPQeFVdkpwFlbLDykqsIF1L0lbLyjoOus77taY2TU/oeeoeR1rX/3zPmdLv0ss7O4bDK9xxsYpKsQCA59+M4hAXUv6MqMZ8eiWg+F7ohsZ6OBNHumbwzcWtirus/4RTEDVfU6GqazkE=
Received: from BYAPR07CA0040.namprd07.prod.outlook.com (2603:10b6:a03:60::17)
 by CH4PR10MB8074.namprd10.prod.outlook.com (2603:10b6:610:23d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 11 Feb
 2026 09:49:37 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:a03:60:cafe::44) by BYAPR07CA0040.outlook.office365.com
 (2603:10b6:a03:60::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 09:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Wed, 11 Feb 2026 09:49:35 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 03:49:31 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 03:49:31 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Feb 2026 03:49:31 -0600
Received: from sadik-PC.dhcp.ti.com (sadik-pc.dhcp.ti.com [172.24.233.244])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61B9nSHW993339;
 Wed, 11 Feb 2026 03:49:28 -0600
From: Mahammed Sadik Shaik <s-sadik@ti.com>
To: <u-boot@lists.denx.de>
CC: Raghavendra Vignesh <vigneshr@ti.com>, Bajjuri Praneeth <praneeth@ti.com>, 
 Tom Rini <trini@konsulko.com>, Paresh Bhagat <p-bhagat@ti.com>, "Bryan
 Brattlof" <bb@ti.com>, Andrew Davis <afd@ti.com>, Romain Gantois
 <romain.gantois@bootlin.com>
Subject: [PATCH v2] configs: Add fragment config for snagfactory tool
Date: Wed, 11 Feb 2026 15:19:19 +0530
Message-ID: <20260211094919.571885-1-s-sadik@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CH4PR10MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: e9753c31-3da7-401a-fb47-08de6952dd2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ys97or2aR434pdmxsM2qPz+cKmhSF2wah3QLpW+79Dtpg4y6Mf7siItCqZfR?=
 =?us-ascii?Q?DW+4ej/z/WkymhqXNyCQf+mMD+vN5Pz38HpVqiNxR0dlJns6QnBwYtXMUL1V?=
 =?us-ascii?Q?XEfSpyKgAZrmv8CebVBvfntWDm1aPZDdlXWQJA1fEcavEC/jYXHlaCERCW/q?=
 =?us-ascii?Q?f2Oa8WGq9atLFTuVWVNhp4wP+8C3Rt1EytsvZwrPHkatMxd/UefggpF2dsLN?=
 =?us-ascii?Q?dye6f9fv380MgXSyZ2C7/rIhQLHvWk0dNZ8jZbHiVwphKqW3++BHYFTZ52db?=
 =?us-ascii?Q?CbF/nKJSxTxmVMEiCxITCg2qeSO252YDS7LAGDpCImj//TzfWHWFXD7/NUxT?=
 =?us-ascii?Q?i9t+x/FiHcDbQw4vqC4lQJAM94NSJkC6wDhDeX4ifbI5ebx8iiLJG4ARle3A?=
 =?us-ascii?Q?JJ1+9EC8/KDZykQsrtzQlLfROUzt9JAPfGUEeHPFkCcbHERveYD7oT95hcPm?=
 =?us-ascii?Q?rOw9ACsOE2eqHQjHBuah4SqCNhilVKlt5iomo3HRHIFX7CIxDra8YQ1yTzLa?=
 =?us-ascii?Q?WsVX//HzsIz2hij2fzuveT5rZ+eN96udKjXxRSyxYu6XQGeqmfUJ64NjnyhO?=
 =?us-ascii?Q?0kk+8YitKxaVpahnOU7mHirAsjS6sGHePWnsgjhqgTnmLx6Y4oPLgAutn09y?=
 =?us-ascii?Q?IZrJ7MuzXTuNPS2AVI86mgGmMswNv0xsXemERhr4YwH9uMaz/i4eN0T9yKsZ?=
 =?us-ascii?Q?37nTIi8RMzGIgvGewm0AfDOAeiBtYgnXGCf5sf5VsXVzzxRk3v4tDaw1ad0X?=
 =?us-ascii?Q?ATH6UdnIVgGA6cMF1htY2scMbqpIh5+ogm4woq2QLBlh96uFtIkgSibKaXrH?=
 =?us-ascii?Q?JW2cP1bByD/C93BYjZfelztvBOrzpOdSu/UexoBmru2kcbkVnSPUtaBR+4Oi?=
 =?us-ascii?Q?onTT1IfYIkLiDxIznm3bIh8MXTzf+3WbSA4gixijshMpp/IpJs44EqVPs4qQ?=
 =?us-ascii?Q?KirW8Dl+5m7gemu/E/pTL/r3r9uewza4IP1x8dhf1isNsaG2DDqrT8us8AUx?=
 =?us-ascii?Q?V7owRKvffgGm1Q6V2gM8oVuI7hfm4nnaooLqgDIfp1OYBSqA6J/AQJuagtmJ?=
 =?us-ascii?Q?HFHafVQ50OL4+iEsKsjEE3JXY/ENDX7x6fJngO4EagsWo6MIzGogPw24G7W9?=
 =?us-ascii?Q?obkR7j6nY+PrYBLMuE6YmOVVJft2v2YqosHw4K0QPJa8/YDnPoHIuOgdHM67?=
 =?us-ascii?Q?Lsmd6koPRExZYZMRCwSCYC4Ypkr//ZQNa19s5It45NYj2je1quzouRavq91Z?=
 =?us-ascii?Q?/6UDGgyG2dTsF+RH8bzL++LJF8lYyI2lYVSf9urLh3wTTvRsT07OzLXSbhAM?=
 =?us-ascii?Q?l4LFIQ1XVPwZnrJ54KxMeTJ7Wjj5b1fbMrsK1tdPuhReVm1e6XSEcgFV8Yhx?=
 =?us-ascii?Q?gw56m9vMfVdoW1paT8Mi5ibWfeyLrEZYE0505d9CfYuJiqIuGsYNmJ6d0wZA?=
 =?us-ascii?Q?uXM84mA1dAhJhsJg7Z4NK7Re+wU+GSI6wG8q/Aw5fGyAA/pZr8RwXLk0ISeH?=
 =?us-ascii?Q?a4nvHU0CHazsboz03cRd4vws67nf9m8vtjRD/UAIwc1b+zYdx5Od4LL0sQJW?=
 =?us-ascii?Q?HrqK9A/SVaeTlaryO0A/1Mmlhg6vJv24ijTCFIZO1sDnZTdllfIzSXKTOABW?=
 =?us-ascii?Q?beGhP0tfTXkIcYzotdxOxY8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: izi2b+f6Rf8JvUdFiCMbvPn+UCtjOrVABVOlMaLCCk8W+DxdU2fKR0GV7wSIA+2/qaT9HgTlFG6TIHrx0Pj5x2KEKCiPiJUZB6Corsy0yz+sY9TMi3USe1hTDEWBScm86VL3yhapG0mJx9L4ZTMmFUFwLh2o2yMyhWmZn4rZrmD08Qy9VSh7oCXamunvtZESEOpPFsqG/fcxUXHUb+jLfdX8befh+l55cIhdB1LCuB0673RqGsEUovt8mrr3V6WUFjWOXbXOzrlL8WMAtsg0zdJOHlQQa4YRDtyEQqM8Nxww4zVkDDJZlMXtuNBJBWYTICLK/ssge6nJN37RAE7sIBW90btXaI6X2gL27rShGlZs6J9M9FrRLc3uZQAHAu/ra9tuUa74sYu9ZkfoLOse3IoC06C4fjIPLveQFgi8AHGuRTvNCubDG55s3whTB7Mo
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 09:49:35.0654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9753c31-3da7-401a-fb47-08de6952dd2a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8074
X-Mailman-Approved-At: Wed, 11 Feb 2026 14:54:02 +0100
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

From: Paresh Bhagat <p-bhagat@ti.com>

Introduce a new fragment configuration in u-boot to enable support for
the snagfactory tool [1], used for factory flashing of boards. Snagfactory
tool first recovers the board via USB DFU (peripheral boot), and then
uses fastboot to flash given binaries/images to MMC or other on-board
memory via USB. The fragment config can be used to generate boot binaries
for board recovery. This fragment config needs to be added additionally,
while building a53 images for USB DFU boot.

The fragment config enables configurations to allow flashing via
fastboot, manage MMC partitions and boot partitions, customize buffer
size and memory usage for fastboot and also integrate OEM commands and
UUU compatibility. It sets CONFIG_BOOTCOMMAND to start fastboot mode
immediately on startup. It also sets BOOTDELAY to 0 to reduce snagfactory
recovery time. Since BOOTCOMMAND and BOOTDELAY configs are being
modified, these changes cannot be placed in existing DFU fragment config.

Snagfactory used mtd support for flashing both SPI NAND and SPI NOR
devices. The fragment config enables mtd in u-boot and also allows SPI
flash to be treated as an MTD device.

[1]: https://github.com/bootlin/snagboot

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
Signed-off-by: Mahammed Sadik Shaik<s-sadik@ti.com>
---

snagfactory dut log: https://gist.github.com/sadik-smd/85124d0a0a37e739055a6357a42c8310

vi<->v2:
	Sending the v2 after subscribing to mailing list.
---
 configs/am6x_a53_snagfactory.config | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 configs/am6x_a53_snagfactory.config

diff --git a/configs/am6x_a53_snagfactory.config b/configs/am6x_a53_snagfactory.config
new file mode 100644
index 00000000000..ed136407afb
--- /dev/null
+++ b/configs/am6x_a53_snagfactory.config
@@ -0,0 +1,22 @@
+CONFIG_BOOTCOMMAND="fastboot usb 0;"
+CONFIG_CMD_FASTBOOT=y
+CONFIG_FASTBOOT=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC=y
+CONFIG_FASTBOOT_OEM_RUN=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_GPT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x82000000
+CONFIG_FASTBOOT_BUF_SIZE=0x7000000
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_RANDOM_UUID=y
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_BOOTDELAY=0
+CONFIG_FASTBOOT_MMC_BOOT1_NAME="mmc0boot0"
+CONFIG_FASTBOOT_MMC_BOOT2_NAME="mmc0boot1"
+CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_MTDPARTS=y
-- 
2.34.1

