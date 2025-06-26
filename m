Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5A8C77B7F
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 06:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FCB082D21;
	Thu, 26 Jun 2025 08:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AMXUv+LO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C49BE82D83; Thu, 26 Jun 2025 08:25:13 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6590B82AA4
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 08:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLthxWD3M8KqTDqg+pR6ZZYejFr+/9IM38APgOj0ZHliwdaoh1z5cmIT2YAoM6f0ByamDiEpz/wKi96wrnFOIxG7IOoSHsohADwY9atoG1bHE9krS6WwML9/paEbf9FVwe3TqPw/5m8qnf8ff7obl7q1lyABYyDVwTh2Qp5EE/HJVnPZtrWt504QD5yX8hatpYoTl6WnJkoh0VygCcTtf2ujEN/S+I+vSbVlQmCVTlAEFgGILXR15KgOrn78He4kE1PF7Gn/Hsr3JVj91EgDLeM3B2Wj62cNC3S/Ror51YSDW2nYHpgdb9ziNc9miL2ubx8ywhic6zhd5FF58zHamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8MkLXzEwLGGUPAePBZRFoHOfGYRBZ0L2X2t8msJNfA=;
 b=GPMbvBjURBy3OaeLhpax53YILByfcnqbiQ1Dd+gWtWoCjplGw4k4SaBsEh7GiLu+pY7Zr2jBkYloce8E8txH0EVyBLvGueH82aAqEcliCcHHj70CnkJAqKEYaP1ZkryPHmvvfOvswS9Fofxjwb8EyjogMrfSamUkW5AJc5D6UrRBSQb5+OQXLfHz1K3v5TJ2Q0o1/aG+Y2ZqWJAQ8pP2yZB//7W2iLdz5JCnO3zhzkUqyQoMZxt8TvwqSRtJ3iJBC4idu4oJPEBQykreVE9JwRPy3ZhS/tQIy0OjvO+//4DF0kh1EGR9IquvHrj7N5GRFvxKsgQzC73jWa4FqLcAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8MkLXzEwLGGUPAePBZRFoHOfGYRBZ0L2X2t8msJNfA=;
 b=AMXUv+LOCNnw6koCumEgSdDhfsD5NqWO0DXrSF9utRb9KhF/QaMEtnQLVoaxs2H/WglE0iJ1/p7pcuSwPKIjhTaT1c/zo2ryXpFy1acTvktJR/i7/2wjvbXpm6ZHbOjR4Nb9cBveoclMguYFRhDuotneXYUVS7o6HR8EZ7c3YwA=
Received: from BN7PR06CA0071.namprd06.prod.outlook.com (2603:10b6:408:34::48)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 26 Jun
 2025 06:24:56 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:34:cafe::db) by BN7PR06CA0071.outlook.office365.com
 (2603:10b6:408:34::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.18 via Frontend Transport; Thu,
 26 Jun 2025 06:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 06:24:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 01:24:54 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 26 Jun 2025 01:24:52 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <peng.fan@nxp.com>, <jh80.chung@samsung.com>, <git@amd.com>
Subject: [PATCH v2] mmc: zynq_sdhci: Reset the host controller
Date: Thu, 26 Jun 2025 11:54:40 +0530
Message-ID: <20250626062440.295301-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: a3366d72-6614-4b32-95e5-08ddb47a2b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gLT3Dv6B7c2XbRWeC7ivHJh+GzUANKI1Hi1FRIjW88voy6jzXDXQcv8TpBXZ?=
 =?us-ascii?Q?bYbg10s4VqXJidHBPM2lDR/3U1E3NdWxZM1cTQg6wh3kSI1UGccBNHpv2zRZ?=
 =?us-ascii?Q?q45jp2YKFWjqg4i5Y3MqD0js2n1kKjLrSR0WlRb/RNJKcUq913RfKb2hLTis?=
 =?us-ascii?Q?B0x+kZXLeTGr50ofNb0PAelMMqs/b7SprehInlGJH0Gys7nwMhuQEkr0gYS6?=
 =?us-ascii?Q?uKhIERFgwPHDqNVI7fJa4YwY45mF9xnor7wwjocHQ1ib792Son/HX34GaDJ5?=
 =?us-ascii?Q?WOhMvtUPV8jd0XJwETEUHzF2CogGyosKPCONu/kGTtHZ35+mnG3M3WAnEhny?=
 =?us-ascii?Q?hFni/uMVWFowEgL/BAIPvvPY3tIvfe3Gg81mlE2AsXo/9BOiDlRnelMeRqhL?=
 =?us-ascii?Q?EfmVMocuWZaVo27CAAP7NcViMBO0TOCaTM9lnwt8K4sItqqk3ZXrSxFhviDi?=
 =?us-ascii?Q?y6Qln1tizASYwbHfY3DDOotrLUePPib8kooSQwopsmBt4fUYdwG+oS/Zm9lh?=
 =?us-ascii?Q?Lext8Aeh8XSyi3yB0h06L0Buz5vPKlU/9nDTzeBExjeUzFE12IPGCiM5SyRP?=
 =?us-ascii?Q?hMsuHbRkH0iq7je6NaudB2wuozBKIvBaKP3GN7OUjr5CEihM5SwkSV7K5K22?=
 =?us-ascii?Q?VcxMh4wKnsnIqzqoCtgXNg8JS0KUJymZrhJy0gl5L5F4h0Tnzq/2/Eo78oFn?=
 =?us-ascii?Q?DwqcUPblplYqHSTSBlfehxMUffp6+s+ROzQS7X5Id19TMroWM/q0Owud4Wi1?=
 =?us-ascii?Q?AhBCbnL2gvNIw0J1vt10fIGwAVc5pNQIYVbqoqurBvJgv8JreNWxnxtFxzT/?=
 =?us-ascii?Q?NzBCmrVAXLqiCk6dtesoRBh0P6Mj4L+0uleOiCuBGIoZYDDDOlIYMPfUop9F?=
 =?us-ascii?Q?L2F0R1nT9I2WRebjcDulqW/9K7IF1Kp7sR3QWtbHJ+f313kUoWSZAyGoZsO+?=
 =?us-ascii?Q?HPlxb48SIp30K5JHYdkckU1bY50RjIENZXGpWcNI+0WbK2spP9435Fu88Oel?=
 =?us-ascii?Q?lglciiJoLaDCw0pXJjo2G+/hbUIoGideYqQHBcE5uaKDY6phHl0dCkJroT26?=
 =?us-ascii?Q?P6iAKjhe/LH9cuklSlHMx8K8NUkmtTZ3SSz+UDItTWHzkZrijeBO7WhyYLJj?=
 =?us-ascii?Q?PIgreSn4ocOFXXneRv33jVRJTw4xRT+NC+lJ5D7NBFdTOzGNU5pSuC/xYK+y?=
 =?us-ascii?Q?4xgRCsuRRXbQxNUbDuWfJdEGP03+KMqLJy42IboYtoSsG24atcnKqYUdAEaz?=
 =?us-ascii?Q?YCipAc0Jbj74x+RX4KGeBN+hQqDdjsNpqH17StcWplKHo1K0mXX9dGpQkTgo?=
 =?us-ascii?Q?7P04bRY/eRit08A2/YYTGErHmmSL2IjeJaCyKoLeWC+kr2BPDIPAW8mWCOSU?=
 =?us-ascii?Q?s8dHCNHiSJXvQ1OkBP+FcqfdFQX/aFgq5GbY8TFDEPjXNEhxaj36ITir2zOI?=
 =?us-ascii?Q?IDDafU3SH8PzNiPW36QkWTKLfDNXJJs9oNXtSwme2fYuTdHUUXNjbt+ODreO?=
 =?us-ascii?Q?jPIUc77y07KJrPrIOpiHZbxEM3MxONe0XsW8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 06:24:55.7368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3366d72-6614-4b32-95e5-08ddb47a2b0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
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

Reset the host controller at the early stage of probe so that the
configuration will be done properly for reboot cases.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Reset is optional, so don't return if reset property is not found from
the device tree.
---
 drivers/mmc/zynq_sdhci.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
index 0e2bdab4e7e..4d1f92931a3 100644
--- a/drivers/mmc/zynq_sdhci.c
+++ b/drivers/mmc/zynq_sdhci.c
@@ -1127,6 +1127,28 @@ static int arasan_sdhci_probe(struct udevice *dev)
 	if (arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_VERSAL_NET_EMMC))
 		priv->internal_phy_reg = true;
 
+	ret = reset_get_bulk(dev, &priv->resets);
+	if (ret == -ENOTSUPP || ret == -ENOENT) {
+		dev_warn(dev, "Reset not found\n");
+	} else if (ret) {
+		dev_err(dev, "Reset failed\n");
+		return ret;
+	}
+
+	if (!ret) {
+		ret = reset_assert_bulk(&priv->resets);
+		if (ret) {
+			dev_err(dev, "Reset assert failed\n");
+			return ret;
+		}
+
+		ret = reset_deassert_bulk(&priv->resets);
+		if (ret) {
+			dev_err(dev, "Reset release failed\n");
+			return ret;
+		}
+	}
+
 	ret = clk_get_by_index(dev, 0, &clk);
 	if (ret < 0) {
 		dev_err(dev, "failed to get clock\n");
-- 
2.34.1

