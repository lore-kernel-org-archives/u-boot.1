Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9371AC3DA60
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 10:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5B35882DC;
	Thu, 18 Jul 2024 12:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="468pTkIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CCD48850A; Thu, 18 Jul 2024 12:15:38 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 006DA881BA
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 12:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9uJfMBoKayhuSgeG0vlBmKtFCgjCtBynpE0Qv0rmYpAQYbegrRshK9BTUMoLYTd5KN+GXb+64xgt2SYOnDWOYD6Ra/LvGmLUI19gr9M4xgiYvOM1243cVsRTt7qUEeL/sos88Mq2/fakkM0roH5Wg6ObQbuqi/pX9BKmRQTGOOuTcc5SfMSZnU7+bVt6y2VFBRoHoLg+X+PFXoGxCM6CbYqi73mi1t/uQxOc2aBGEYx0uN5Ijoh47gBx5I9xPW7tsV+Ldx173HevX0h3lDyQwQJRTbV9oDQYy79orDoJRJq+70PZKP66GRL2kno4fTTBWLYO/hD/4bzi+1kEBAoOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgYz5PPKfWveqgbbRVb2U/xpDevE1FzHveFStJgfAEs=;
 b=BsFU7mL4E0rWP0vOPZLLaPffcHz6tQH8Gb7NjgYdhKPZuAi/UokmGAKmdOXkwffuf8nw5ikw0h5n/wE+ifioSZDxQn9MidRA1//BkkpeSnN4cDAYFpgVxM4bYinBojQok9CgT4VplVh1B1E0FmcIrzlTYZgz0QNd7nkgQesBkLZy73p5kvSCqTE8gN+kvM33Q1ijwxyWUZ/HdndLS/xpvF5PZm1mSssWPReudoNGnc41ErBxuJdNZLpsVMAywRpCFTQf0aun+pw0ufIwolUlChamnK+YLhqOfFHFXYCJwJkNeTWHjD/jyBa2qT2OuQZnmuEdi9rNdBhlelVgba3v0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgYz5PPKfWveqgbbRVb2U/xpDevE1FzHveFStJgfAEs=;
 b=468pTkImh9KvKQ5T7zZM3Hy748car+WFvCnv5/d5IgzO6kUDsCZDnFpDqPHg3G+K15ycs6NWPVrwlPIYRS3McHdq9iSnsaCUc0aOZnJJ00W6jS83sBqPf7Fg5mFb1S+gVpWbIeaukrCEqxmBBUN87FK1OsYx5i0SHhgC/1Oqbxk=
Received: from BN8PR04CA0002.namprd04.prod.outlook.com (2603:10b6:408:70::15)
 by SN7PR12MB7178.namprd12.prod.outlook.com (2603:10b6:806:2a6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 18 Jul
 2024 10:15:32 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:70:cafe::19) by BN8PR04CA0002.outlook.office365.com
 (2603:10b6:408:70::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 10:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Thu, 18 Jul 2024 10:15:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 05:15:30 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Manikanta Guntupalli <manikanta.guntupalli@amd.com>, Harini Katakam
 <harini.katakam@amd.com>, Neal Frager <neal.frager@amd.com>, "Radhey Shyam
 Pandey" <radhey.shyam.pandey@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: dts: Add rts delay property for rs485 mode on
 KD240
Date: Thu, 18 Jul 2024 12:15:23 +0200
Message-ID: <0e0c4c067236e11f661c1d067017e1ca975c9ddb.1721297721.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=hvMVHkWJSYiZphog1Go2Y4PHRazekK+87PVsdw7EMAc=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQZr20Uxc4nbHMVi2DMi7XY9cptR6fDvyKLX4eUe9fmG
 Vt8DSzoiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABPp7WGYK7r55z3DnTYRjdrP
 L8QIBQnPd5BNZVjQH3//eLtsFLfpvSOMRc721y7cKTIFAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|SN7PR12MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: e5551cb8-586a-47e4-0675-08dca7128e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tIoNJfjFdZ4DS/Jj+dhCqI0h/+bsRZ8B2SRDCzv93ZVog0gfnW/hLE4Vt7he?=
 =?us-ascii?Q?/XETsPehQkCj/hV+9cZR8Bh/Z5JAzkz4/jzr9MceCzmNCTWKGjSWhqOkFn0l?=
 =?us-ascii?Q?q0LnOGLbkRMT7/YkvDMmZidoC/CrkcVQ515duNqKWDOHoIej/rEGtLpZk4X4?=
 =?us-ascii?Q?MyA5MY2OzxyLeOP/Opq4qhBdelSTbRqNG2APLsWh5I3EX6yCp7W44dJ3+d5v?=
 =?us-ascii?Q?PngnizitcPq00HPofitRcZS9FBMDGPU0KP7GYfEqqc3h+1PM81iyIjWUZztr?=
 =?us-ascii?Q?UDA0ifuoNZIh4OeFP4I2gqidqOvAp9KShJySY0N8syl+flAWr2mne3SsS0mb?=
 =?us-ascii?Q?t4icy/B3A+qOICI+dumV8CAnYMQV5xkgbBrc7WcxfYH4RBz04kDxUltk4xqP?=
 =?us-ascii?Q?kY8Uc3gmEww5rUQURAtjuFALSrXituJIC/7GbNw0+//otUF3tT6MquF0qVak?=
 =?us-ascii?Q?2rZNJKJ14o3bv3qVEJ5aTyA6j/t/DtVACPanPrJbQcC6iLZrA3+dF73P/2A7?=
 =?us-ascii?Q?BUvgMBWaA/vaQAzjGDewlldZ9sabSIaR8JXgwcwqoFFzBwRlleZpQzxVZEV5?=
 =?us-ascii?Q?dhLoetqQmyMV+Z4RUOUTRqLPspLfv7Hc7SHM7PwcXfdBbh0hAWNfDvEWBago?=
 =?us-ascii?Q?+VlPjgNOyUNEo8gEfElEIo/q0/MMa62wvquEyBL3ZjHaoaevtVtmZjwTHCUp?=
 =?us-ascii?Q?FQcgGFfeEml71bKt0zykCy3k9UzqfJdwyHsn61OxFsN+fXqJkfSRqoZxpmlw?=
 =?us-ascii?Q?54m12hVyYI2p05ppFL/nXyf+S2PSvMR8LAtvCRkcTVqvTWDXuWG4Ve4QKJvY?=
 =?us-ascii?Q?wbH2o8WAJy9MYyOenOT4Q/wYcW4VIXcEgeFwfdaVphobMQOFzxAC5leKjYE0?=
 =?us-ascii?Q?etvO8Z7NzHRonlNkyYuZIuIHJ5rf22+YEown+0ykAnVLVwuuX5So1io+0Vmh?=
 =?us-ascii?Q?1iCv16s1cIFr1E3KdzXi40rTH7OXfa8jn8YqSTa9LXIyIfappEMP9V4CYaK2?=
 =?us-ascii?Q?e7WQzgLsOJaGxDPWGao9YkW24gm8izM97Q2CxqOkMtmALhWMn94iY/F0Q3lC?=
 =?us-ascii?Q?h8BOwZlUKTqDXoAX3vZwMRYx5ms6q9fFUaG5NVxUAmLu4iorLSZFdA8W56YN?=
 =?us-ascii?Q?9EG50EyinzJFa/HASer8BassDD061xRt35xCy48ZbaOJgNdA3PCvyVj5VFP7?=
 =?us-ascii?Q?edU7csT+Haxw21JXNs5n6+H5OKwAdffca0p3j1RDTY4NSsDR25i48RNLD7tm?=
 =?us-ascii?Q?yulcmB7MmmzY0hWF5PMyBWwA5HyXsABnut3hZMpRwSIS6qfkj/7lRUT179nB?=
 =?us-ascii?Q?Q8RcuPKE7yDu4QPIpcK/GdDf5pPSMCwH3B5h4hhCunSKFrjd4soqGk7yauL3?=
 =?us-ascii?Q?1VFkYFAH1HbL0xTrMqZXLSIE1UhbLfOC+y8nlLMVxZ8cQFiW1a25YiZwXF54?=
 =?us-ascii?Q?7WCJrCecbuc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 10:15:31.6247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5551cb8-586a-47e4-0675-08dca7128e3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7178
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

From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>

Add "rs485-rts-delay" property to uartps node with delay_rts_before_send
and delay_rts_after_send values as 10ms for rs485 mode on KD240.

10ms rts delay values have been chosen based on testing with rs485
temperature sensor (which is part of the kit) as safe minimum value
for reliable operation at a baud rate of 9600.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
index 1727a1cc15c1..4de29d5d3ff6 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
@@ -358,6 +358,7 @@
 	status = "okay";
 	rts-gpios = <&gpio 72 GPIO_ACTIVE_HIGH>;
 	linux,rs485-enabled-at-boot-time;
+	rs485-rts-delay = <10 10>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart0_default>;
 	assigned-clock-rates = <100000000>;
-- 
2.43.0

