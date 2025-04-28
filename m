Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74842C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1459882B78;
	Mon, 28 Apr 2025 15:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Tp9H/0Hw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B07482A33; Mon, 28 Apr 2025 15:45:54 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::70b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C2F282AFC
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuyQEka7x/qMWWzl/sjeAjA5O7SHe83lZ9U+UxmI+z8jJFR2dL+eXUkkvqjCdIPOKB9N27zOOtTbT1x5h6emcOuNiVca/1Do/j70HUxUAMCxwhnj++OQUmTwTp/MSBN1VDQHGYmnb/uu60ttxEn2644H+4KB49sFZJgNB+09r9YkOkNmEAAGVxv+hSYsfSGu9LoJTM+XyWF9HCV9ZGBZPTGJ2tEiwwEFzxF818lTjf9DjrcV5JrbNhXljYK3sM6dM9fXiAPKeumeKpvEo5vRP8G5XAIjY/AUE2cKnTrZM7awQrGFBIx6eht8TtABqKHLlGVBTUVBuqPJEucUwUpAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQDXwHmUMeUcvWjF+k3piWXynqFEc8+oYaczNr1PTNA=;
 b=BHe3iLn5nqhmZ+ti8TxWns3qL1utIoTFz42t4OVq2o+PjQB0GIP/mYPDYkdD3Sb8Z0ay+s8W3z3XdvNMl/eaJWxG7pWfyVDZJat8LSAp5kJ4H9Hl4Hm527m5t3nMSdlnlQBmwRqjLl7KS+Eg9OTxSfB2kMn80+lH4epNasV3uj4On8VXBgTRdXqQa7pSE1fwwDv7cFAJ9IbO7Fd0m88LFOjDfGp0un0BUgv5LF6uEeQkxK6BIkPyW75+CxeE9qKM/mt9dHI3mn2h7HD8BWBZiYofQGnw0ew0ymktWLUOv4ZP7Jk2aEtMaVIo+LWE1N0PWvTp+f4/yQproKbIrEPEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQDXwHmUMeUcvWjF+k3piWXynqFEc8+oYaczNr1PTNA=;
 b=Tp9H/0Hwrg+RqfpwjApIxKm/lhdfR1ENurtLYxPmFDNNkZ+se9IUfjRtIu3qt3Q9rx1Uz4jd76Z/HhFANdO0/QlNz+3gzssaZWeFNj7YbEsfq8OBNYrWQsQL+YSsPY6s95zYwEtNPoQiB5pZX+f67AYea/MYwdn9HWVm3Qza5ozAFytr/6O/oCIlb4LBgt137I79JJIulRfTDtrkoKjCJOh3rXjMX4S/bIC9CzBN74quhaeVuJPpY9H5X7YAvpGWzReCZkZHzbjSVGDw3siwAPlx3+OimTyR6Rbol0cLPxqLrJmHAxiBkYOpIr1LIx1TB4WMI8Hrq/o0fvZHxL4e+w==
Received: from DU2PR04CA0032.eurprd04.prod.outlook.com (2603:10a6:10:234::7)
 by DB8P195MB0565.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:15b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 13:45:42 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::a8) by DU2PR04CA0032.outlook.office365.com
 (2603:10a6:10:234::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Mon,
 28 Apr 2025 13:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:45:42 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 15:45:41 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 15:45:41 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <n-francis@ti.com>, <nmorrisson@phytec.com>
Subject: [PATCH 5/7] board: phytec: common: k3: Update boot_targets at runtime
Date: Mon, 28 Apr 2025 15:45:29 +0200
Message-ID: <20250428134531.2884940-5-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428134531.2884940-1-w.egorov@phytec.de>
References: <20250428134531.2884940-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|DB8P195MB0565:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b0fbf7-a8fb-405e-8d97-08dd865af82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QhHbWE0BdPUTc3QZIXilKABc7ds2TnFA7qGP0bTeHb8Lt2xyqGL0yfBWQK1R?=
 =?us-ascii?Q?iNzrUxDeYLvnQv0j9a4thf1UEzyjaR0xgQqOLj7/1kpigQ6Ze2EvlPS0oFmP?=
 =?us-ascii?Q?aTAdN4Qco05VxYBiUT9uLxpWeiwAwSEFc26FIpLkK8aX1m2VQuq7WuJkcDAN?=
 =?us-ascii?Q?8HAxaBal3JqqGQcjrmHYPJuJeXnt+E6M0YkyTYDnUbaKQ80+UstN7z86eUFf?=
 =?us-ascii?Q?7L66qvXFxdYbKwWMTvaYYsq6q9j0CPUDIjI0BOb3yL/86ChY4KUpnl12EAly?=
 =?us-ascii?Q?w2ZR3WL2h2xFytUxRcN+s7bZ/WXlMPj42+gJNCu1F1SCyu/HyqhRwPzEuSws?=
 =?us-ascii?Q?m6+yLgaa0pIUefFY9RLixkU3AMjCSSOh4VUj3vaVpXrujpe4UypbOIWkA8GO?=
 =?us-ascii?Q?ZB7n+Y7zGYZPzx2XYABPohyKMd7rLJOOXVL34Odgeqiy2j52CqCIwyRT+2if?=
 =?us-ascii?Q?FNihBvGWc78YoA3GYcjT99T3noFhhnsp15PtEl4pM3oshtT8KlK25Rj9LqIw?=
 =?us-ascii?Q?zIwNH6lY2WfSTOG+Q75I8LYFMtu9cIWiUN+3DO3r67fQPe3DWRTZXCVtMwwT?=
 =?us-ascii?Q?JzM4xeUS53a+T4SFVUHHPp9rT+19Ou7w9pxThjG9tqdVNE2wCbTdW3aJU8Ek?=
 =?us-ascii?Q?cGidWlpLmOQJlkbA6YuW4KpduYwGsDCteFUM+uyd6Z080Oi4aji8o9vzISu7?=
 =?us-ascii?Q?Y3QjPFrGj60zw1jNf8ZVr67uLjYV8FKfIAPSRQ7k76HfJLxJJeGPq/ihW72Q?=
 =?us-ascii?Q?1FDdnrYjC/0iXE2U/Qyc7AcUGh8BboIBSRtY45FSAOwyBFYKhryLe9/D0/VG?=
 =?us-ascii?Q?BYdG6x8tfK2c14ZYoFaY/z4ub+FvutIpDPrCp/qsgYC/kSzRjqnQC6JtJBkQ?=
 =?us-ascii?Q?f5Kcci7ylEItHAT9twoa9ZbHu3tjrs2GSUhaPvWUHYRPWdQ4uvHhw0vG4r2u?=
 =?us-ascii?Q?QSbGFaEFUFEKrf1mloIb2UHRTEJ7UvkiNRmDjkXDW59E6TB0KyqmPm1qTCua?=
 =?us-ascii?Q?ZKeRZAMK56wo1llC9jtxMpjJmSNyAmCmvC9p6pK/fiqAjcEhimuLL1rwlXhk?=
 =?us-ascii?Q?U5PPSlb9Zc8xiI/KpNr53WmGAFoFJQQNBrh9PJlLoM81qTSkdg/jGq/cvneJ?=
 =?us-ascii?Q?lbxP22t2YC7MK98E9MuekmwO5LcKiYwUzU85pq9zX8tePaQeo+1ZbG06p39x?=
 =?us-ascii?Q?aswb/3iDX0thW8IEyjT8kBTrNTO8Xr4RqxSxTZZnzyHvSbcjIJM0SfevGfuL?=
 =?us-ascii?Q?s4szhH7u0gA+GJnM7fAlGAM5JOXT3f36N7zGltq40y6pA59Wx8KfJt4mnc/l?=
 =?us-ascii?Q?oO2CTNS4WRfTySDDBU90yTeJbp8Kpx04BEYjYguYBw2mpdCMpiTJQSyRRhVt?=
 =?us-ascii?Q?7Rc83iIuBDzy0Iyvqarbq7Kene9Mm3Qivk6YMAeiGvdXkTqRAFci0TJ6JD4C?=
 =?us-ascii?Q?QtfM+ijZrfFDaS5WaVUCLmwM2hlCX77wCbrEyuCk+9vgeFzexVTQ1/Gub/Np?=
 =?us-ascii?Q?7zvJ+zXsaIivG2YmztETOr/0DOPsTO/Gwc+h?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:45:42.4524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b0fbf7-a8fb-405e-8d97-08dd865af82b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0565
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

Factor out boot device detection from board_late_init() into a new
boot_targets_setup() helper.

Adjust the boot_targets environment variable to favor the device we
just booted from. If boot_targets is still at its default value,
prepend the current boot device to the list; otherwise leave any
user-customized order untouched.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/common/k3/board.c | 36 ++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index 828973a8e28..bddc818743a 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -120,25 +120,37 @@ enum env_location env_get_location(enum env_operation op, int prio)
 	};
 }
 
-#if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
-int board_late_init(void)
+/**
+ * Ensure the boot order favors the device we just booted from.
+ * If boot_targets is still at its default value, move the current
+ * boot device to the front of the list. Otherwise, leave any customized
+ * order untouched.
+ */
+static void boot_targets_setup(void)
 {
 	u32 boot_device = get_boot_device();
+	const char *boot_targets = NULL;
+	char boot_targets_default[100];
+	int ret;
 
 	switch (boot_device) {
 	case BOOT_DEVICE_MMC1:
 		env_set_ulong("mmcdev", 0);
 		env_set("boot", "mmc");
+		boot_targets = "mmc0 mmc1 spi_flash dhcp";
 		break;
 	case BOOT_DEVICE_MMC2:
 		env_set_ulong("mmcdev", 1);
 		env_set("boot", "mmc");
+		boot_targets = "mmc1 mmc0 spi_flash dhcp";
 		break;
 	case BOOT_DEVICE_SPI:
 		env_set("boot", "spi");
+		boot_targets = "spi_flash mmc0 mmc1 dhcp";
 		break;
 	case BOOT_DEVICE_ETHERNET:
 		env_set("boot", "net");
+		boot_targets = "dhcp mmc0 mmc1 spi_flash";
 		break;
 	case BOOT_DEVICE_UART:
 		env_set("boot", "uart");
@@ -148,6 +160,26 @@ int board_late_init(void)
 		break;
 	};
 
+	if (!boot_targets)
+		return;
+
+	ret = env_get_default_into("boot_targets", boot_targets_default, sizeof(boot_targets_default));
+	if (ret < 0)
+		boot_targets_default[0] = '\0';
+
+	if (strcmp(boot_targets_default, env_get("boot_targets"))) {
+		debug("boot_targets not default, don't change it\n");
+		return;
+	}
+
+	env_set("boot_targets", boot_targets);
+}
+
+#if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
+int board_late_init(void)
+{
+	boot_targets_setup();
+
 	if (IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS)) {
 		struct phytec_api3_element *block_element;
 		struct phytec_eeprom_data data;
-- 
2.34.1

