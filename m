Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33B5C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 15:16:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2CD182B37;
	Thu,  8 May 2025 17:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="TwLJWhRb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66C8682AFD; Thu,  8 May 2025 17:16:03 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20725.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::725])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D26B828BC
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 17:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4cVixlDy9sAol33ukaESBdlUJHSmIlzvsvWN5t4RKc07uy7rAp29hMsB51LgF1rxEs4AP7nVdfiEpCOJMp4QPQNxlQp4z2wpKLHrwCmok9S7OEXczMwmg5TA6UbLQ6d6QgGQCdErxU46osMrYU6wvYA1h6Uq7LoPhIFLggln88Xlxj2eIwOX9jWQkvYjVpVTQ0XguctIDvsEvf8MGE+NrjnDpChVF0FlTu4ZjOOOzELcmt/kiSjkDCnyKfjFaP1oDTWnKUvLBapO/w0hc5pXgEM7EGwIPSPA08iSGGaAd6mF08fCIvMwqM0I2MK1+SzTT1LGjz1P8ZopHleX8ZNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSrJCtaZq/8laMH9k4Y1MMkQotN9MmHpvukNJDUAd5I=;
 b=hOXti+CuAuIcWnfKiEgJ+YpMwanAWKo1cVLejZZRkt22yXPHoyiqhyht7z2vPyX8WL0pQvWbeGI4ZqFKmWwP08Twj3kDbh8ysgJkU6iQva3rtRUSQktqK2QyIheP71NmDpEB3n0v4CTqsJWazNGMkwEjvaP1eegy0KIvAFHLmGhqaW2nCKrY19eK6/ah6Mhr1fKfAHpldhsww7HeQm1pZycYmdJVbOhvaTUD3/CDke8Li4bQGNUU4InID+yruYsoIRL2N89VrZw/X/M9ea3FN2r2UxltZ2sVmM4OBo3D2DCzhYK4U0bY5QxPT2Gqp0GfD4v8c8YzwNl6AOY6FDxwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSrJCtaZq/8laMH9k4Y1MMkQotN9MmHpvukNJDUAd5I=;
 b=TwLJWhRbkruQJwjlK7ThKAGa647ggzzwiBK/LqfzokkuHAuAZ0n9S9aQWesvAQ8RGVmbgJfMEy4HkDz23n24qjRnhj7UstdSzItsfTYkX3z5/8boxxnCD6nG3TADMYsIxScYwd1Nu3C3PeabXRxKvj/G/4WtAeFQbBVdnajvVUugFwnatITi9IphxhQRy9RKRCiftibyXLT4AlPqx+ZwsMRFFJiZFkC6WlZ7jL2ZN3OxqWSJDsUYElcKx+05T40LbuxOuhpW7yRNc+tuH4o4jzSI7+2MZ2koBENEBnGgO7wnjqta6bRDiatSpwoiZxIzekhBF+7rjIAk2xGDgs7YwQ==
Received: from DB9PR06CA0029.eurprd06.prod.outlook.com (2603:10a6:10:1db::34)
 by AM0P195MB0674.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:160::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 15:15:58 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::aa) by DB9PR06CA0029.outlook.office365.com
 (2603:10a6:10:1db::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Thu,
 8 May 2025 15:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 15:15:58 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 17:15:57 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 17:15:57 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <n-francis@ti.com>, <nmorrisson@phytec.com>
Subject: [PATCH v2 4/7] configs: phycore_am6xx: Default BOOTCOMMAND to
 standard boot
Date: Thu, 8 May 2025 17:15:45 +0200
Message-ID: <20250508151548.162122-4-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508151548.162122-1-w.egorov@phytec.de>
References: <20250508151548.162122-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9C:EE_|AM0P195MB0674:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b2d366-f88e-4585-efa5-08dd8e433c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4gll8WJemhgdgf/oVQUpK8P7W0GAsR3+LRYpXeW2WO5rX0Qfk6E6WEAMAjy6?=
 =?us-ascii?Q?q0OeTYwo+H8dlA1qmQUZoTvRWioAnW1xg4QVayQ5Roqmk7KDImrTBdZ5oagJ?=
 =?us-ascii?Q?ZoR1AbrkTjU1BCLyiJ1o6dYnINjnBUjD7T6p2c9jl2joW8YR1PrDB+A+6dqj?=
 =?us-ascii?Q?9DzsDuIMJh3ringazxGK6hZFPcEAZ+7NLpo5u0PJ3C2MLDMLnOfO6f4LZMuK?=
 =?us-ascii?Q?+eI16DNnLjE6nQDmp0CZQz2p3UOjLFDAIr/ofQ1rjySmKRoWnYkQcumdc1wp?=
 =?us-ascii?Q?457CjjWk/5cRqF3gSe37BcapV7HJjMgi0VRdy6sfhtE2wAlQclBgwq1ttxcA?=
 =?us-ascii?Q?XM2SoK+/iBsbt6FzYe5kwbuhYtQdHxUCjVK8CyPR9FFv8NcOhgmGaL0MAxSK?=
 =?us-ascii?Q?SSRXSvMGvW1kIwSi3cH7sNcfknZxqKN4PO0dhr+WasfGGIzRdnx2AC5dSixf?=
 =?us-ascii?Q?ibIdTYgHYvsyb7A9DFWqneDj+PG3YqoY0PzJ8H7fQxOsEsDP5j1A2qlz0Q1p?=
 =?us-ascii?Q?nS6AnN0NLJgV1hjkxzmGGwE2cKqb+VjqauNpNHWChgksML34hijtuN6+JgKk?=
 =?us-ascii?Q?hhrFV+L4Og1B5bUjP+Z1UOU6d/DMCs4tKx6T22PNke3wSYFjHFGmpZs0M55k?=
 =?us-ascii?Q?6v/zppdwsgzYkdeJFjQuBHUf5E24WG25fkbKOuXgLx5w2h+i2PiHSK9ZRmZY?=
 =?us-ascii?Q?V2nptv+01YY+PvfpVS/7JGt7qJvEJrT+XkQmaFsnRbKTS6tBBCxAgWpMUhna?=
 =?us-ascii?Q?eg5WHYzsjyLD11EevzEdIAN9iwfkXWSJrCheykcU98RZPZeJHbiyJM5L5PEg?=
 =?us-ascii?Q?CayioZi1iP7aEScqyEf+XBp1tYau4DGZdBAxikG2rh8lNRXnhNuKVlEFJdny?=
 =?us-ascii?Q?vMNd7jHOGauZyER4/7I6/jpC7mQglz7prNUIaktne/Bh8eY/EUW6b3z6MsoJ?=
 =?us-ascii?Q?WvJ5BUsbOkStZmtvJR3FAX/OVj9Kwe/X4Yk7yJ84fEXu0T/7i8kxHffengyC?=
 =?us-ascii?Q?l/fhHu4ssiQO7nVwmfGN5XotNk2Hhuwo9WA3pdWzyOcaNCzKC9M0Tkdr2Gex?=
 =?us-ascii?Q?0lgct7YBIFGRu1XIZ1vhgWx5sYMXsh62H5EnCdwiJCAVEFPtMIIo4GoKJfMq?=
 =?us-ascii?Q?JcmtLGS6O4Ba0zTm0AzaLaoqAZBTpHfhMY7bZ6efAYGorkexEvtRHo7BEZn6?=
 =?us-ascii?Q?3nC1TjmJFGhxrXIgx/RpnO3O9m9oBVmiXR6i1FCfFrtCluB58wAwexYpYm1s?=
 =?us-ascii?Q?emoGvTFKQlUCDtvJ7zf5ougUmkDqubrZ3nPNy23iVZ0INnyp/qD7IQ1g57GR?=
 =?us-ascii?Q?sZ0OTrJgyNqumiHaYbJ5/npOI6U/eksFzueoKx49JT/LQ5cpMCy312+NOCfQ?=
 =?us-ascii?Q?zs5+YsCYUfily9/6KHIo20EeuHKfEm0N4qu674kUhBUZPL7oTw0+thFREE5Q?=
 =?us-ascii?Q?TMmRKdcjDifdl0PTJDzPxLl4Fpgz5Q5b4PlsEXds+nAtAUQFkt+KJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:15:58.5653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b2d366-f88e-4585-efa5-08dd8e433c8d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0674
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

Make the "bootflow scan -lb" command execute first and
fallback to the legacy BSP boot scripts.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v1: https://lists.denx.de/pipermail/u-boot/2025-April/588142.html
v2: No changes
---
 configs/phycore_am62ax_a53_defconfig | 2 +-
 configs/phycore_am62x_a53_defconfig  | 2 +-
 configs/phycore_am64x_a53_defconfig  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
index 94176929f9a..64bf89b14c2 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -41,7 +41,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run ${boot}boot; bootflow scan -lb"
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run ${boot}boot"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index c52a2f76200..e60ac1f363f 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -44,7 +44,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run ${boot}boot; bootflow scan -lb"
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run ${boot}boot"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index d4842939096..7b3d21e8ee2 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -40,7 +40,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run ${boot}boot; bootflow scan -lb"
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run ${boot}boot"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x180000
-- 
2.34.1

