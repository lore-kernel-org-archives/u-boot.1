Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ABEC87FCC
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 15:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD90F8129F;
	Wed, 30 Jul 2025 17:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="qMd5BrEG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5AC3805D7; Wed, 30 Jul 2025 17:42:32 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::710])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E3E80C93
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 17:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SP4I6Ru4KG/1R6++dlfEJrlaiCCFYxMC5x36FGf8y6VwVrxHtc20SnpaThjZIPTe5f+Jyd3t47Z0mClIOQmOuA/Va4Bcczxh46dhIOZ0rLQxAAE3vR1+5jzg638k+M/eWupnykkOQGfGPwuSJHbHOMV15CYLRdvV236v0oyS6pquKlR6BtVHXg3730TgwKD1NDXneSulJOAhBtOQt/LI9ds6fNxCRmOUw6TiUk3mdpUTO4q0cMkPcIvEmiwwEx5RmqyQ6grxbUQPT/m4OZBGrjXZlyCmP5XI0PG14Msgd8MjjP6v3JH4M+EYzhnZk2hDyR7Eg0fDpheEOKl7cRhuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jdy6RVbxjDG5WZ8oIw0t/zAV5OJ3y77W1KcQCOB9X+g=;
 b=nk779McC0uU4ZhrtVC+sW5xZiiisAfeqLoIiuqg329cMicYIT1e/DQ9Y91r1k3RzbkYaO2ktBpWST31ddlevIvmUpPuTKifxIJn+YpYZ9AGNH0UsnZLJNdpnRGTBvs+wvcFYFgd5yl1C3uCZm2vMRA5Y4LwdpWQuQxwh6hY6cwYXzZNM44nADUoZxLG/f+LCWKV9FlQJVuazfLtNIHTL2KE3sI+YEvZW8/qQCxU/UrIqpiHpyABbrnvrsf4ZGVqHDshRmBAWp1qk9yXx86mBHI7vBS2AnasDhyXjr0HinDlfHwOjzAopNhYu2ALEA02V2waiOPSAQ+Fgvvp0uamy1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jdy6RVbxjDG5WZ8oIw0t/zAV5OJ3y77W1KcQCOB9X+g=;
 b=qMd5BrEGHILMWQAFYCuWuPmzHyJH7E1uZhVHEjivRwJyoJ+2WWCRfxMgelI649PyVm7thZmtRI4FCj408z8Rxi+lo+tDOBWomYsK4eQtswBPBZzJUUFVa73X85QBxYd4SRoTGBxxXKhaYJVaL36IFPHJMO4wQQ+pxE68hKk420ODXh/EOUEVXUmFHolgD+gnruNrBQ+UfP9nbmioD3PK9SDRti3Nk27i8PcztyJS3Twd//Vol4w0zYosjmDdFbmPJTcG7suyV9lihNSNUJVBxhd9jqBoSWg4G1x3dHosFZ/qC2jiNtnew8jJMjuCSFyicslSHasvgjbvCdmdyy5vyQ==
Received: from DU2P250CA0007.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::12)
 by AS8P195MB1239.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 15:42:27 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::25) by DU2P250CA0007.outlook.office365.com
 (2603:10a6:10:231::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 15:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 15:42:27 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 30 Jul
 2025 17:42:25 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 30 Jul
 2025 17:42:25 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <ggiordano@phytec.com>, <bb@ti.com>, <d.schultz@phytec.de>,
 <nmorrisson@phytec.com>, <joe.hershberger@ni.com>
Subject: [PATCH 4/7] board: phytec: phycore-am62x: Add watchdog start to
 bootcmd
Date: Wed, 30 Jul 2025 17:42:14 +0200
Message-ID: <20250730154217.1116751-4-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250730154217.1116751-1-w.egorov@phytec.de>
References: <20250730154217.1116751-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|AS8P195MB1239:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fdb199-2151-4561-e220-08ddcf7fafa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zdzD32YLVe6T4VIz1JUg53Xrvgj6gY9JDLPqP4oZERWuEKGFzZvdAvlLGtmD?=
 =?us-ascii?Q?H66CJFXka7eNgSbcjlRKcBsPL3So0EIvzoLIHXswTOz8C/YFYvKpelIViD0f?=
 =?us-ascii?Q?CtlNXpwCEGNMizvlWtduL4BGIn1Eb/XqnIaGEMxEKf1RXff4Z+uWFS4OD6e3?=
 =?us-ascii?Q?tIWgM6ftf4iZsgSaxuTSGIaKdhMRXuEcRzXRkYlSPnyQ8VpXuXnyaGMpAuYR?=
 =?us-ascii?Q?yRO/+och8P2iuBEBFmdWH9VpSwtiKTL0uibxJ6Eg2C25hDPcBLFC4aZ/zGuL?=
 =?us-ascii?Q?u5B2yk8nkdi+/mRTUFH4Jcx/QNMgjcbUxKatFwMx5sjKQbKUUbAuFY+Y2tTM?=
 =?us-ascii?Q?M72swAx0AI3bORHfAqgebfALz1GlVrdY8CewbZEQMGnyDadOP/yWBZiqstrG?=
 =?us-ascii?Q?gO5yGwDizFLSHy0LC2E9N1i3KO9014D+gX3Tew+j2ycoo5hdVG0ks/fpsDPJ?=
 =?us-ascii?Q?Ef+Ge4Wfrb6Q+vjdVFj5sw9QRcx4vI/v5V1nzTE/vA7rTQQnnj4aZsffCP2/?=
 =?us-ascii?Q?6Q1mLBceF7IZin+Kud5TeWrknhnaFqQ09qB6CDji4FdobTVIhUWXddTyyfby?=
 =?us-ascii?Q?1kc9Zg7ID1iN4XHEby8TBlK3Dyr60nkdSUMf0cBUjBThw/eNjmWNd5AbGhB0?=
 =?us-ascii?Q?Sx03zPmzOKK3iE/fXWTobvUDBBvD1FwtapLfGvpgaCd8djY7q5QxnVB+/0Kf?=
 =?us-ascii?Q?0FyOiu6K5HirSFhamrzs8t9JupdUChMqZsmDN+A2uU97LIvOLukyo0UsSYXx?=
 =?us-ascii?Q?m5QaMLAk9zxjJOwGRkxUzT6ErgcitrsssII7KY1Lh6LgcDtshaaOI2DbBwLU?=
 =?us-ascii?Q?WSj+AiBlUhL/C/W7mChBoKXMogwuftS/QXJ4ANDf6xJQJNjLIrkupCqj+oRi?=
 =?us-ascii?Q?G+Nfnh3ZzR5VFDxThnvXnUJSrVQxUozvb5JLZTTFxOhnyPu1O7NaLjsDhDQs?=
 =?us-ascii?Q?DnuFxMdHvVEtm8yaMAAuYAyKIPKftjiwR9POV0c6Ow5otZdvk6x0EUEUqiFo?=
 =?us-ascii?Q?xxTDk55zO1bSCuauUgs6+xG7p5xzuFEBuvT+8mWlIESo+BecSoWA1noRV4eN?=
 =?us-ascii?Q?syc+ScmvnrMOnDXmRSO7pBBdJ7R/Dnxnn/4UaPhquVyE8w+RiWMALYwEW9tO?=
 =?us-ascii?Q?IxJ+OC9MtdhVBgYlyoRB6qOa40PjJ6ilMuVmBqMBayUG5Ec9bPz8/oOIvtio?=
 =?us-ascii?Q?q7TFQpAlQsWleMx6fYcji5GxRO0dLRCF/b6xjQrlLkUtE240bbygrLzn8f1Z?=
 =?us-ascii?Q?BORX77iESrsyMgUf6yGvItv2IRmrBD5BI2SbRCkQ0cEOG9q+eXUl7bLGzhGD?=
 =?us-ascii?Q?4/004GOTeE0kDhArnU9mWNhySq5WjKOzr1gvGXx25HGf3ZJxrleCcLCfbAS0?=
 =?us-ascii?Q?+8U4d5c53G8i41UZlYOAy34k2A2yFyQYq39eZ7ndazzC6eusrEnwj0vGlH5R?=
 =?us-ascii?Q?AeyS3JETPQl16FwplD3ljaIG8hxLtKFk10lXbrU4yQ1vuxdAeH1rrulhALrY?=
 =?us-ascii?Q?hdOLPcjzPktBBV3TgIh7YcZgC1BB/0KYiMRC?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 15:42:27.0197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fdb199-2151-4561-e220-08ddcf7fafa2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1239
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

Allows run-time control over watchdog auto-start and the timeout via
setting the environment variable watchdog_timeout_ms. A value of zero
means "do not start". Use CONFIG_WATCHDOG_TIMEOUT_MSECS as initial value.
Users can enable the watchdog to monitor the boot process until userspace
or OS takes over to serve the watchdog.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62x/phycore_am62x.env |  3 +++
 configs/phycore_am62x_a53_defconfig          |  7 ++++++-
 include/env/phytec/watchdog.env              | 11 +++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 include/env/phytec/watchdog.env

diff --git a/board/phytec/phycore_am62x/phycore_am62x.env b/board/phytec/phycore_am62x/phycore_am62x.env
index 797904013dc..3f4b3cc4f0d 100644
--- a/board/phytec/phycore_am62x/phycore_am62x.env
+++ b/board/phytec/phycore_am62x/phycore_am62x.env
@@ -2,6 +2,7 @@
 #include <env/phytec/k3_mmc.env>
 #include <env/phytec/k3_net.env>
 #include <env/phytec/k3_spi.env>
+#include <env/phytec/watchdog.env>
 
 fdtaddr=0x88000000
 loadaddr=0x82000000
@@ -27,3 +28,5 @@ spi_ramdisk_addr=0x2200000
 
 bootmeths=script efi extlinux pxe
 boot_targets=mmc1 mmc0 spi_flash dhcp
+
+watchdog=watchdog@e000000
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 978604b0232..931ec39905b 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -44,7 +44,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="bootflow scan -lb; run ${boot}boot"
+CONFIG_BOOTCOMMAND="run start_watchdog; bootflow scan -lb; run ${boot}boot"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 # CONFIG_BOARD_INIT is not set
 CONFIG_BOARD_LATE_INIT=y
@@ -79,6 +79,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RTC=y
@@ -175,5 +176,9 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_DFU=y
+# CONFIG_WATCHDOG is not set
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_K3_RTI=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 # CONFIG_HEXDUMP is not set
diff --git a/include/env/phytec/watchdog.env b/include/env/phytec/watchdog.env
new file mode 100644
index 00000000000..f2e65baf1e9
--- /dev/null
+++ b/include/env/phytec/watchdog.env
@@ -0,0 +1,11 @@
+watchdog_timeout_ms=CONFIG_WATCHDOG_TIMEOUT_MSECS
+start_watchdog=
+	if test ${watchdog_timeout_ms} -gt 0; then;
+		if test -z "${watchdog}"; then;
+			echo No watchdog device set, skipping watchdog start;
+		else;
+			wdt dev ${watchdog};
+			wdt start ${watchdog_timeout_ms};
+			echo Watchdog started, timeout ${watchdog_timeout_ms} ms;
+		fi;
+	fi;
-- 
2.48.1

