Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC03CA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:54:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D99B083285;
	Tue,  2 Sep 2025 10:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3mFtFgch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D76583285; Tue,  2 Sep 2025 10:54:23 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B8483A99
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fn+2bVP1bcwsiWMhgARdAStY7tYTQosIn9X4+GntrPthaabp96jFqJxOcGUeydO7hXuvcUSXL73Jr9eRcTw1sCz+f/TGsyFacbJqFKu1rnssoblPWhPXRXpFgKSwl/aykQahONQOEQUSAT2u5GikF/qOcv/++TbHV51/OYEihoHoEQaNHsMfNev5P1UjU/MxnZfjuXIKHYHSvvnUD8k9L08dG3bCDLx6gqwL4fUsoAQY0MvSTcufPdDJbD8mkyCPLbOPL30qfhg6xgVn1bu/HCPiFrrQ3OceHmrB/Go8TEZ5kTTJEbgfVQ0NHtZwJ3suedF5sg3rgaapgz5G8Y0Vhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozt8WkoL6Z1tidwNsHOkWjQbHUU1W9edoJRr8iucGVA=;
 b=FvQwSHZM8wsdtce9pZlWFnUEP+3998vtrUpYSGa64TnyhIMg14YgGH0Atuu5FKYebmPnSLxKDF0Ts80MifXVP0oJFAwkltuhyVo4dhV1949EyimHPi/mg6zBXPEfT9Q7vYH2QJT2/NTKnmIVDmQyTIOoN+lNNQnmZkrNIZzF2BRb4CJm8AIzUvF15uTRqghvpj70eitUkX64QFv9orkbHHQGa71Lk5bEV0xm+5dng+TebcHuldAg5AYxSMe6FAgPTPCqR/qgmtwVn54r/vGMqmMv0Sl25L4iFcPJymreThpFK6HOR6kdcSRVvxLFRkXRozWISMKxQTCs/VAoRG/h9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozt8WkoL6Z1tidwNsHOkWjQbHUU1W9edoJRr8iucGVA=;
 b=3mFtFgch3UgguW6cxER8dPZ98q/K2xewlY13WSaRZjA3+3O6WdFNmcnIj/Q4C++TWW/5FCUwDLjggtivNlMSM/e9UqXaY3tShDaUM5xWv/04YTXANWgha2nXSIW2KuXUZu7rOUlWGuZA0gEqTJN+r6cy234KUqKKwCotLthHqGs=
Received: from MN2PR16CA0054.namprd16.prod.outlook.com (2603:10b6:208:234::23)
 by BL4PR12MB9479.namprd12.prod.outlook.com (2603:10b6:208:58e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:54:18 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::bf) by MN2PR16CA0054.outlook.office365.com
 (2603:10b6:208:234::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 08:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:54:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:54:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 01:54:16 -0700
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 03:54:16 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 06/12] arm64: zynqmp: Revert usb node drive strength and slew
 rate for zcu106
Date: Tue, 2 Sep 2025 10:53:28 +0200
Message-ID: <14d3408cf547ac188c07c10abb0ddfaac9d915c4.1756803198.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756803198.git.michal.simek@amd.com>
References: <cover.1756803198.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=tI67BueaMmk1VUpuS6OCMHeDCopG0XmaBc50jgAw9oU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRs29B1oeHm5h0vVh2+bbD6+MzUnUucDq24Oy/uQrClp
 /Ld6ByH0I5SFgYxDgZZMUWW6Uw6Dmu+XVsqtjwyH2YOKxPIEAYuTgGYCKckI8OCwoxPkd0lqzaI
 75zjdP/goqsXnrxLXqT+7oGGbLvs9ANnGBmakzLOWV6qW15c8q7nrkzE8fblPj+FHP3PT/po9KW
 NeT4TAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|BL4PR12MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: ff84ee0d-8728-4e77-53fe-08dde9fe4d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uEXJyKC2GD7If6soLXpjheGGQUx1d5ilf5Fo8lq88IJRyZKVxErLdXVW4n8Y?=
 =?us-ascii?Q?SKTGM/zSwrYiedqLWU6/sQIVB0hupMFheaG079bTKk2bn3THU3lXe2v79e8P?=
 =?us-ascii?Q?zV2IRYbLvJQ0Z9l+xyMX9ClVzJKZ14UhIODWqnMqlEO1F+DFXwE0SGBJ4q1K?=
 =?us-ascii?Q?q1S7haBhZnyMJCW8W5kWKupnp1+W/wsOvW05frs9MiVlQp3LT2WRbHwpw369?=
 =?us-ascii?Q?wlTW6n/siVjfcpzbgSAjV6vu9r6DnlEvh3hXQDQDSS/t522oc1Q+IfRU97XK?=
 =?us-ascii?Q?kQ/NK+bfg/iNJfTl+d9HWThcQCdEZglzLIyQT6y3PjDX4BrnqOJ/IOYkUu8M?=
 =?us-ascii?Q?mCXCsjdZuJ3RUecXjx81pu6L2o0ccyaf9ox6q7iX/WViC6Cvbin/aEb47yvj?=
 =?us-ascii?Q?jrDzKA7y5LCuxt6xfzdqthwvDBl3rwxYCVFmA+9hV9qtq2uMnPifEZhq4M9F?=
 =?us-ascii?Q?cfU96LJ+XM/OKrCn3ANPCD650aVbKQa3FmoT11KGYcCAqMRK62WUg3A8ViqR?=
 =?us-ascii?Q?kaRzoS2fZq3ST4PvgHJIQ9IwhWfHHb4ImlMNsVo5nQ/VghD7wObGP+rG0lal?=
 =?us-ascii?Q?DllLKMuuhTH/qYXX5RfVHictRJQqL6008JGgT0aeEr0Ii0mReNLRW+Eo9ImM?=
 =?us-ascii?Q?45ZWEPWpVSP54kE439DeiSzLSFuprxHiPdH5Znl1c7v6OzTx9YbMDjba/lcs?=
 =?us-ascii?Q?jV/VRwrLlu3tkRWUUXJvdMsYhM0n8Q+d+/Homj6QYaMwJMGurLNtdKmmpR/s?=
 =?us-ascii?Q?ERBsYnUQcBMqUVEIWFCm/pcsdS76rj5stKU/DenJ3Tv5TrdyvV8okkO0jbzT?=
 =?us-ascii?Q?7rjx/4tQgUKOsfgTGeiDZtVJSaIoNIR5zl90cn5nQF2BDQvFomTda40WI3Bi?=
 =?us-ascii?Q?Zng0267NATJpxdzKCoByu6MDQZbKfCCh698vrxGoN7VbYYk3re2R6ZulKgZb?=
 =?us-ascii?Q?Y6WZlYDtT37DV5Du7kPWLCBuAK3Ls7BPe+g/tEab4zAPgUtlllV0hzUua9y3?=
 =?us-ascii?Q?jOzDbNwi/0Yo8humiinzdYmogjcV1auaySkUa00JHNgeEtxnK8ng2fCyQaIT?=
 =?us-ascii?Q?VFiV4R7KY90DkANvhkl9Mz6w2BZXOK2AqzHtlO23OAuUVWCxT7fX8+NgoAYn?=
 =?us-ascii?Q?HUUd5sYWDSE/pEk4NEnydZd17/I/XM+m1MNkA/Rc/iAhdQYN9H2IRdnjGvso?=
 =?us-ascii?Q?ydxsRvbtc6O1s0AFT+l7AXFIwMxFdS5F+gaccSHQCZ9ok7g1QvOVann3ToiK?=
 =?us-ascii?Q?9DU0E3/ywc20JgCbj3KSNFBDGMF7fqfJlkd69b/j7Hpxfin/Wd6TPjpAj/l0?=
 =?us-ascii?Q?B1x+pI1ZhGiga65whhKVW3eIsH7HgqQhIEg4rQwZwz1ORKPLrUvGCahzkJ06?=
 =?us-ascii?Q?uNwvUCMB3xyHY+N6G3tklZo7NMsesTo9ZBXL1S+VBmtQPZsC2cHr7N35XYYW?=
 =?us-ascii?Q?rKwztZ6qklGnThkWqmLmBtaRkrupnuFz1CKDt9vuQNSey6j834EsYi2jPwkC?=
 =?us-ascii?Q?cI3Ydi40tzZvqzcxVHOXrRw/zLwASDdTTgum?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:54:18.2616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff84ee0d-8728-4e77-53fe-08dde9fe4d39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9479
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

From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

On a few zcu106 boards USB devices (Dell MS116 USB Optical Mouse, Dell USB
Entry Keyboard) are not enumerated on linux boot due to commit
'b8745e7eb488 ("arm64: zynqmp: Fix usb node drive strength and slew
rate")'.

To fix it as a workaround revert to working version and then investigate
at board level why drive strength from 12mA to 4mA and slew from fast to
slow is not working.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-zcu106-revA.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
index ba3989cad3e4..a19d78e5546e 100644
--- a/arch/arm/dts/zynqmp-zcu106-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
@@ -827,8 +827,8 @@
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			       "MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
-			drive-strength = <4>;
-			slew-rate = <SLEW_RATE_SLOW>;
+			drive-strength = <12>;
+			slew-rate = <SLEW_RATE_FAST>;
 		};
 	};
 
-- 
2.43.0

