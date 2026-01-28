Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF91D46BF6
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 19:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6D4D83DA9;
	Wed, 28 Jan 2026 20:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mPW1Xscb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF6A983DCB; Wed, 28 Jan 2026 20:38:42 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0B9B83C2B
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 20:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8zm3gH2gXZOPnDP2synuTWcnx8fVUXuqMSGwUrw0s6BEYbdxyQeVA2RhvDnCU/vm22Els5mJ3tZHu0ut+9zfTYo/50BNnVtkAQS5xzXnG2AXZCAuOAK/FB+pP2xcdVspJcT/LteznO2TFJ11x7zm8LSjpfoNAYk0xPbIAAxNeiEREuX+qbssIeEvtgpVKmnY0hIGCQzA+ikCbxrYfOh0svi4PconUb4LX3R4o1Usa62DnGgkwfu62R/DR6aOo+z5s+fBvo8V3BoqYBjW4BzOepVOnaPQv32dMOSkJa5+keU3DJzUzmF22XoBbAErnjdZlswqjPn7ntqIQuosgug6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDHYgdssdCZmu+hieCdmmiBaiJiH4Of8hjDsMk1+0XU=;
 b=NJ+SN2L16uIYZ/NRbxhVfSukU9jQjbPbPcYWc8mluCH0Owpp0oN7zNzAGwh8KGyhXGy28OCWenaR4kTrUq6J6bPkYSSxLNcF5buRQ0jZjLB/KAV+hSi07kYEkYatB1PDW5CD2KRCpVPASFxzp6y2of0PqLpbxpIFxprAMyKCRphi6Kyn344cvp90P7/hcjbLt1EhZ+y/lvmEM8KqplJU3omy0VQcawkgKfctNFs96FreiuTsAfAsn/fcep7LKFeZYOWjB1+9fqUKnDmFOglIQkEAbOwvzq51q76pifRrZt25DNIx2LfG3XEIOQWJL+/MlLyRy2s8g8aAP8qbNSE80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDHYgdssdCZmu+hieCdmmiBaiJiH4Of8hjDsMk1+0XU=;
 b=mPW1Xscbe907ry5JujvF1R3v9W9Cid4myytFoNMb0mSzLih1Y/rH17ef69LNKBB3W0aGHOKdspKP3lRcwjqUkuhiCGcaQoQ++tPwqVGBMbIeTp3H3HQpOc02h897H0Y4Y9yYIig5Pk/5a0LHQj5X1YnY1g7VMOWBQET/mLjGkns=
Received: from SJ0PR03CA0099.namprd03.prod.outlook.com (2603:10b6:a03:333::14)
 by MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 19:38:31 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::9c) by SJ0PR03CA0099.outlook.office365.com
 (2603:10b6:a03:333::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 19:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 19:38:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 13:38:29 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 11:38:28 -0800
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 28 Jan 2026 13:38:27 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <jagan@amarulasolutions.com>
Subject: [PATCH] spi: cadence_qspi: reset OSPI controller
Date: Thu, 29 Jan 2026 01:08:19 +0530
Message-ID: <20260128193819.1177944-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e81c091-9d37-4515-9e6f-08de5ea4d092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xnoZ8jOxecJo2/IU2932PABe2cWjeyM9D3DtfhGkLaxhVb8vMzyctU76ncJY?=
 =?us-ascii?Q?OJvisnV/zQipK2afTViEvinanC1lQsi17aVZ0Pz75mypH4crMDC47wuWGWUs?=
 =?us-ascii?Q?5aEBpArBSeBgRICzPpl43J7h6xdejVp0TGPbRPINkNqf7A9UBgVYr4Ooj/kv?=
 =?us-ascii?Q?Vv9QBsVMy/PG4ZhgFolEGsKk2dCPM73L4s3PyRTpggaQpzXeyA/S04APLfl5?=
 =?us-ascii?Q?gQrpwCr97xy+i/TuhGWUGqHzrrRdTHZ1O2zj3Y7jtIao9wqd0VOwG4r/bp8C?=
 =?us-ascii?Q?6NRMUfwptfokdzqQSNa9tvROJ78TQqT1uOZA/XlkmcNG9dmtwEGuJljsQ3yr?=
 =?us-ascii?Q?63En4ngjc4s+hF1zSDrNkJHkFMIVgwLtWo6xu3NXwbZCtm/Syp4IG0JV9WPX?=
 =?us-ascii?Q?2Z2d2x50JXc2VYrJGuAAfW3d17tgPMga1CEQjD16AsQ+Q1nvSg5feFOlm9fb?=
 =?us-ascii?Q?O0gKd5JKO7Mq2pgiDRITfKTA2qQuBbm6bGWfNG7Jg5hJsXzxHzaQVI+O2bfw?=
 =?us-ascii?Q?a2ViS7FOgPp0nhg1TIg9ZL5FwDW+PUlBRQ5e0I4Cw6p3tNQVFf6CywQE3nVe?=
 =?us-ascii?Q?vrjMipISZc9NuqBoxmP5E60Y/201AfLiyCvh9Ob+oQ6TZo987en54/m+/1+8?=
 =?us-ascii?Q?vQ6xETOl7IBSQKheKRS/DRIHR4/s8Djym+XugqpebS3JKrP/WgWmo4Aztcv1?=
 =?us-ascii?Q?1XLRWAEYCY9zolC6IUU9qUYuIr6tEqWoDrz3cYjWWGzysH8OnbHfRpvAViWE?=
 =?us-ascii?Q?vaPaLArPkT1pdeTJ+KOF8gWsBkgRslAn3T9LfJq3iq/Q23qPnjY8s0p0Q9+B?=
 =?us-ascii?Q?T4eVlOkUOf36xSLf05Gc9q5z0Y2i5fpukXuD+RLZp0c/CRRUgtHcLwAXEoXp?=
 =?us-ascii?Q?S7uoXPK92nwx3bgSMbqw5VQXeArEeYq8gvx80gmA3xhD67NrHZL6F0CTPpGy?=
 =?us-ascii?Q?TP73myQZHsVp4xaxotrdy/A/qAbbhooJ3Cehe0br4EUvA20GS3jtz5yc1N4Z?=
 =?us-ascii?Q?dP7rIbV2PVYIEDA0iKTZ03YEg4QlUUfHD9nGZWc4rntVMcO5mHAs/rKTPZCh?=
 =?us-ascii?Q?e+D6wf+Ge3+atO1QtK2q2V6cyzJkJyqLGTKvm4C38SMkD72tZxPx9VT7txDE?=
 =?us-ascii?Q?cmRGsKpUhQDJ+OXXPP7LBTqbwmqhmjPN8pVKFyQdBH0lijxrTASgooVkU+Eo?=
 =?us-ascii?Q?A37/MZzG5nLAyq3tqMXYZz6c4p6Fl56SYX8J4iYJFeH/fg8qbL9NeaJ9RE3Q?=
 =?us-ascii?Q?YCK6zkXWhjA1QKCpBLJgmVQ9PmvtFN/lND/o9Svy6QVxndGnj5WQVEaVqyvp?=
 =?us-ascii?Q?JLglzbb7xQ36kHksvSFU+OBd3QoxRQKhK024sAS47VKCnlstc2Zy//YhRWLc?=
 =?us-ascii?Q?3iPzNIjjzDlVfbHQEsg1iwmWWsAfliijPVtNuLh+tMxr8Kb8SsspRYPqkWnL?=
 =?us-ascii?Q?+NIkSuM5uBUb+SI2nqYUBhnvnu0V3PGUMDYz9GvMiFKftm5uZw5pLV1qNmo6?=
 =?us-ascii?Q?rBMpnkbAnz3FGRRkNAlejywNy5CV4mqwmDiMzI1xCKiGr3E4dZ+T6NVBcqln?=
 =?us-ascii?Q?/53qfgafTd851VFUpluL5yi2RnUFPeWXhQ9M2HWbTi76+f1xuuL603kA1UmY?=
 =?us-ascii?Q?8/6ym9qIS1LQW0/iNPEKiJISESK1ntHkFtLPqNaNZ/N0Z9NsWuMoF12fxpRd?=
 =?us-ascii?Q?b/L6Rw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 19:38:29.8772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e81c091-9d37-4515-9e6f-08de5ea4d092
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662
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

During probe, toggle the OSPI controller reset if
CONFIG_ZYNQMP_FIRMWARE is enabled to guarantee the block starts
from a clean state. Add the small delay and error handling
around reset assert/deassert. This ensures the OSPI controller
is reliably reset during probe on AMD FPGA platforms.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/spi/cadence_qspi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index d1404e13810..a29acf75abd 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -13,6 +13,7 @@
 #include <spi.h>
 #include <spi-mem.h>
 #include <dm/device_compat.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/io.h>
@@ -257,6 +258,24 @@ static int cadence_spi_probe(struct udevice *bus)
 	if (priv->resets)
 		reset_deassert_bulk(priv->resets);
 
+	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) && priv->resets) {
+		/* Assert ospi controller */
+		ret = reset_assert(priv->resets->resets);
+		if (ret) {
+			dev_err(bus, "Failed to assert OSPI reset: %d\n", ret);
+			return ret;
+		}
+
+		udelay(10);
+
+		/* Deassert ospi controller */
+		ret = reset_deassert(priv->resets->resets);
+		if (ret) {
+			dev_err(bus, "Failed to deassert OSPI reset: %d\n", ret);
+			return ret;
+		}
+	}
+
 	if (!priv->qspi_is_init) {
 		cadence_qspi_apb_controller_init(priv);
 		priv->qspi_is_init = 1;
-- 
2.34.1

