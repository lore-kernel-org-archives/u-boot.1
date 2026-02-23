Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84425EC110C
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:30:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 934EC83E36;
	Mon, 23 Feb 2026 18:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U5rXosZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0071083C39; Mon, 23 Feb 2026 15:46:18 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFFDE83935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:46:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCdU8YoRfCXgXT5p9ar7ky3LkFWRGB22jhG72BXLmIrA6if7YKvr60T7jsGbPkRLfPaY2Cf2MTW0tezlk0iZn+x5F1hMPzsZYPtko/D+DBH7E6bZjyQcawzL0X4JLyZXENUTBGXS59jB3CXIMFxU7ybxxaAO6F86hvAHblsVueky6y2k9T7TP18MiVlRibbrhoQTFzwtmImuyUVbdCFmJTuEwRO7K0/JCYmbZxDG2BXFSJobF7mwT+SJY/YCwzQsTZ8RiPPM7mUGT1SUoOctkNgvCXA5LjCYbCyinvDqmw/a3klF8bBic34KhhmTAUy9RX+9nOibxxc0omINUksCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXADJdvgkhEuosCHaGIlqgc2YLZdquNmg52YZnf6ofc=;
 b=T3MQFOLvvbuYGvTOeV28E68gMG77aZigZ/C2wrZdJyySo0UzPy4iEvefG5iOr+Tqsqf6vSkiBz+qZOlRZiCQaiDMFYHEofpCQb9LClW+f4wAxD4qlEVlI51DxflIjqbmKbli+RP6N9F2RSug/wFb+Q3jsdF2EvrDJXqs9fnkwDIaQVzxZv3wHRY2lc7pArw4iKNZo4eNehiAiugUkrxKmc1ZsVVktpGYtc0DXWY2bwznwem/V0wIqIesIFtuqBvbHma3AQ3aUmVaWoLXFBLo53OecLc1IP9MsiM+AZ1KLk0HQ01YNSshC4C0hpp/IBf4CDRDEFXjNzlH//gl1k5i2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXADJdvgkhEuosCHaGIlqgc2YLZdquNmg52YZnf6ofc=;
 b=U5rXosZwPXmZZL7Y/FQGq2aBpsZ2UjowASqpbBtxRwTX/wwnu6L5meo7bSDN44trsSFE23jUXuHH9RHsvSGxxBdq+LQoOkFtnx0Of4E4OPeArmqHAxsVNljsq7LcVdAxxRSzBHRk2kaVg2BJzlZTBkMf7sgTfTrtfcbqOtYmp7c=
Received: from SN7PR04CA0084.namprd04.prod.outlook.com (2603:10b6:806:121::29)
 by DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Mon, 23 Feb
 2026 14:46:11 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::c0) by SN7PR04CA0084.outlook.office365.com
 (2603:10b6:806:121::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 14:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 14:46:09 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 08:46:09 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 08:46:09 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 08:46:09 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.178])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61NEk57S980749;
 Mon, 23 Feb 2026 08:46:06 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <nm@ti.com>, <heiko.thiery@gmail.com>, <m-shah@ti.com>, 
 <j-keerthy@ti.com>, <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 "Diwakar Dhyani" <d-dhyani@ti.com>
Subject: [PATCH] mach-k3: j722s: unlock mmr after spl_early_init
Date: Mon, 23 Feb 2026 20:15:58 +0530
Message-ID: <20260223144558.395289-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS0PR10MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: f24c497f-8b44-4fa7-6727-08de72ea4886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wbaSrw5RT2zXR683JiP5mG4/wdfXq/tsbghIisHb9KhFudU3HUsv40S36dCT?=
 =?us-ascii?Q?M4ZNoOg5dlmUMEpOcQMWpycCDqjSVe0QZOR9HIkpO9uaeWYqJWIkRiZiYPt2?=
 =?us-ascii?Q?NaBvPthAwpE4MerfphKFGJXcszt4rMG8N72OYQA3b1OW041blz3d4//2cLdj?=
 =?us-ascii?Q?jXdjfq/PDfPUTrvZceKx9b2v6NMubVE8D4X3eeGqbd/AZ3St+N0j+9NLsZUM?=
 =?us-ascii?Q?jbZZt8dRg10PP01WoXgkxQxcAW3B0PzEwFreGEcuK1NN3cDmxM716JCjg+Yz?=
 =?us-ascii?Q?/4DIlGlaBOFSRUGS/GoIf8grHutRRLZEsrPYKTfiWQP4wDbXUTC7hvZhqziv?=
 =?us-ascii?Q?IgXKPOOM9WBENZlkyjlrmayZGn+Wi4bM5rdZONAjNl0h+D+FW+PWvejG5vdV?=
 =?us-ascii?Q?BJ4F1mBH+AscaaXid+YRSQJluKtW7p+U2IjGxIaLA9QD+cb0kgPyVJHLR1xz?=
 =?us-ascii?Q?ny4DIgFrPazSHzcaObYf8LOnnyTbwQZSIZzhLqfoSbjoTJHjkSRY6/Ggrsfs?=
 =?us-ascii?Q?UJVTJ1L1OgwLOKUMHUxe3tJsf/DIuaQOB57UeHyZ5yYyA1RcvXtn7n5glOMn?=
 =?us-ascii?Q?g4h7wpJSJjqS/4ioYD/3RjxPF1P53EIz7YwY18DLCkt3M+EliKz9NH1ssAC2?=
 =?us-ascii?Q?evbN4GVzCd3MulbgXYaItkYwpFfIkIKhlPOfIPBAnApEaXRFwsTK5xSShNau?=
 =?us-ascii?Q?GR+m2EM2Gm7PQO44XqRxK/GW0+3ZjsZbi6JwD7DqssWPBW0D3nV9vaNgb6U5?=
 =?us-ascii?Q?afjfHdhYiPTzot0oXPTqB31ZtgQ7ZxEp3W75pntvbHx3cON3L5YerpuY5AEw?=
 =?us-ascii?Q?PJWNDAUsPJCpwqTxw2jB/Kc4wk4XJt5n6TzvR9wy7qYY+O3woS2ATffLkXvB?=
 =?us-ascii?Q?IbS5MYPwCogcNJtmBF9R98qKqissRp6FeoRyTDGfwIQAnKVG1yIy/ufQwfZY?=
 =?us-ascii?Q?tksFS69fZzHzlC0rCrYwTS5se1hDrTKyzFo/uBdyuMzgNDfmPnbtTR45fxRr?=
 =?us-ascii?Q?7hfPqm/do3jPjpCtmhBQvtkiC3jXue+/MrDRqEQdVhxMKmQ/bP0EJGh8P6ij?=
 =?us-ascii?Q?B6hHqzBFIYeX4WRDCAQ34H51T83OfmorzNRPpM0/2AX13iOckQ0QLaVs1ayO?=
 =?us-ascii?Q?uTe0Y6ZgGSDJXSFxWGYdIgfrm42W39ZSw7kEs26b9pC+vFpAZFsyBRfkbai1?=
 =?us-ascii?Q?DPuA31yY/FtXWdrrGH6+RxPufH/exl9aF6gWgkD2dBRBsMl5QRFoDcftCTbI?=
 =?us-ascii?Q?lx5Vesai02kX4b3EgtyQM7OQ2JpOIklvk1KtLgpXrTzASoNbx3iKUpDGDBWb?=
 =?us-ascii?Q?AXiy6/l3tRaMrWPgg8RqGc999nBoriXmobJzcZ+xvOe26V9t7nc3dlpx1OWu?=
 =?us-ascii?Q?VSpH+lM0yQYFbSq5v0EBuXo+v6FDI8LCpi/jnBXvPMhpKSis9Qe2Sjt4f99M?=
 =?us-ascii?Q?0n4ZJoJ1KsPHr06o2KhFGit/1PyXhGRsyW2B2+X8wPoniZIq5/0uj5NOaLrk?=
 =?us-ascii?Q?hbIjLs2eIe7JRfc3dGopeuaiIxGXRYYAJj46yQq3QGSprFZH8h2nAiwwNm05?=
 =?us-ascii?Q?mxmBH4e/un6XPa1+It/TaqJKBfontkLtJ94+PlNLcyrnMfu0czt/Sar0KBdV?=
 =?us-ascii?Q?YUxEcH6z1ttHZJtEiaTPmS8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vrn5MQ4U4sOTdFSi/7RfFQ201a056Gg3x4sDkuaXExZWA5pFoM5oi2Fzn9l7mlksVMZZq7TbUMNxauV67DVH7vXbCNYzQDfH3cxy02s49Ksmbzf+E1NheQdYphIBgIk+jHxlk8ZOb+WAuzynBHD0FoUb21xCeNFdEnaajzmigkqxoZCZrhqNEkHoQ++IwRf85hshNoLW6x7vSwZ6NpoyDEBmKFmVrfRljihguDTF8YvpVOKJJvFICOOn+Ir8ulSvYMHScoFkJwXn94q+PDAencjlVjKwvRNCRiJESAyvRBr4xTYhuBY+D6Lc7y+/y8Xr2FMc75zROySQ6UwhN/wvjRuEeIjXLFb0QET8IPwQS5MvqC4jeI0qKpIUWSSuyKahtZ3elvy3etY+4WL+4Ak2s/Z97rWSdQZKg46Yex1L3ySUcv3mzSc1nt6nlHOS1uKq
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 14:46:09.7172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f24c497f-8b44-4fa7-6727-08de72ea4886
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6974
X-Mailman-Approved-At: Mon, 23 Feb 2026 18:29:27 +0100
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

unlocking control mmr before spl_early_init leads to
unpredicable behaviour.
So unlock it after spl_early_init.

Fixes: 5e291ee34fd4 ("arch: mach-k3: Introduce basic files to support J722S SoC family")
Reported-by: Diwakar Dhyani <d-dhyani@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
On HS-SE of J722S in particular, enable_mcu_esm_reset function is not able to reset bit-17 of ctrl mmr CTRLMMR_MCU_RST_CTRL.
Which leads to wdt is not functional. With this change
bit-17 was getting reset properly on HS-SE and HS-FS devices.

HS-FS
https://gist.github.com/uditkumarti/4ba05c9335212630ce9240ac67e11c2d#file-hs-fs

HS-SE
https://gist.github.com/uditkumarti/4ba05c9335212630ce9240ac67e11c2d#file-hs-se

 arch/arm/mach-k3/j722s/j722s_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
index 1180c75f551..a0dab5d7032 100644
--- a/arch/arm/mach-k3/j722s/j722s_init.c
+++ b/arch/arm/mach-k3/j722s/j722s_init.c
@@ -84,13 +84,13 @@ static void k3_spl_init(void)
 	 */
 	store_boot_info_from_rom();
 
-	ctrl_mmr_unlock();
-
 	/* Init DM early */
 	ret = spl_early_init();
 	if (ret)
 		panic("spl_early_init() failed: %d\n", ret);
 
+	ctrl_mmr_unlock();
+
 	/*
 	 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
 	 * regardless of the result of pinctrl. Do this without probing the
-- 
2.34.1

