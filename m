Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C32BCEB2FE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 05:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A3C8912A;
	Tue,  1 Oct 2024 07:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZYDoceLp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAE2E8912C; Tue,  1 Oct 2024 07:47:43 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DBA089121
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 07:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhYHxZBC3Fs57PBgtL+7TvdP4eZi0ApF1NdJJRhJRhbwJazUNtwF1qfRIZYz+aJghLBHt/zV3jpw2fHcDtUfkKtWWnACuNnVRL74DrrDv00Sr/SjvlP23XJUDCTsqPGQc1CxKFJiHvNrQJplE2A8kaboRE7FwZbczlvrAHJS9GS/DfX0ph70NMpKNjn40/0SeHQE9t6cdgDyifn6ISJpxsIcP/b9inUa2YFkw69MbWgFSiVZxy2EFITN61kAgPkUfKPiLWkGWArogSMf2mFb5AY7UqIvbUnAacVxR/p+OaWeq3Irl5NgmtRS1ytyCBdmiiYYUUhWpM3mtCkn3m+8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgSZw1i5Q0c7HYmAuFoCWRX1+3emHjmE0HH04gO+2+8=;
 b=GsIJoaKcpYfNko51Re72jyWHetV2fafveuy6WfGXHB5y7mUPWFt7gCd2xFRFfLd4MuGS+kd/T0MwK67Xp37PpHH2Ak7gERVwdGpTdZ/i3gHlDoIfYJ/W5C0PhorF/HUP2HV92eeauLPqpsO4VTs/jdVme6z05IElRql13MmEdCSx08Q6YwhzadnB0AiQI4TK3e37+OFUw7pgA6LWyWJOx2QDmx24G70Nm0X08lueXtPFinOrv/3tk416SdArw3cSc0jtmcON0t7V0ioQuu/X2bFwwrIhblHblPIm2kjHWR8n6/RzIu8SvuZHvJf9/WUlrRv3QMPWVIyjvAQMRdeQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgSZw1i5Q0c7HYmAuFoCWRX1+3emHjmE0HH04gO+2+8=;
 b=ZYDoceLpu9Pqfd9Ek4O4YpY7t0mOg7SbyZrFjZpD1wVncJLt0bqGMerz7jB9baNCcga/WBXrquzeWwVpt3CV7KIsRb3rpCTzVgXJaQA4OSYrZnxkyRJp/CZELv946JeUSuXF8tFEOwzCQvfWPj+sdeGRZAh5OQ7QpHZPqa+7frQ=
Received: from BL0PR02CA0016.namprd02.prod.outlook.com (2603:10b6:207:3c::29)
 by SA1PR12MB7294.namprd12.prod.outlook.com (2603:10b6:806:2b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 05:14:53 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:207:3c:cafe::e8) by BL0PR02CA0016.outlook.office365.com
 (2603:10b6:207:3c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 05:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.2 via Frontend Transport; Tue, 1 Oct 2024 05:14:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 00:14:47 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 1 Oct 2024 00:14:45 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v3 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
Date: Tue, 1 Oct 2024 10:35:27 +0530
Message-ID: <20241001050529.17922-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SA1PR12MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e9bbf1f-fcac-4d0a-93b9-08dce1d7faf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?djdIJd5Iwmr8n0GQYNLMvLWfdetjXulpK7uRLBy9w/pA59Y0w+6ID/21O/GV?=
 =?us-ascii?Q?s6dZPWSGGyChngCz9v7Jj2xgIev2wHa9l/IYCZkHmyQy+68+Kai8dEKU4p+9?=
 =?us-ascii?Q?fTzMU51woy7dUhx81jRYH15Gg0D+OhnRe/q5qf0DqIYWLd1jznzosxELiH/0?=
 =?us-ascii?Q?+G9CUXtKeKmrhaeTNgjahndIfkW3GwpBDlrBDBreu1oHlF7jsR2MkEqcGdHt?=
 =?us-ascii?Q?CYtLmj5lQOkzzsdzH+8BMs6Th7KzpsPgr1BPRjw2+JPnIuED0mz6EuLRzEGL?=
 =?us-ascii?Q?QdCO2ZFc8x2xEYyV8rce4LBt6aL1k0t3AKveS6ll58OTZZg219uWnLarxkTL?=
 =?us-ascii?Q?ksKRw4FaI/hUpyRobElKBucPdygu70Q0lV7o3fMPfHHEStozugibC6xfvEmS?=
 =?us-ascii?Q?lCbVDt2fUEeMQQUE0Kni+6Ur5M4BZyoED4kSgxkd96i9qMOGXcA8K3/i9Wbc?=
 =?us-ascii?Q?8olehPWcFIc58SvLTbrXJcUscZXlEl9e7m44Ydj2/xkPkENTSvkHLP5e9wP2?=
 =?us-ascii?Q?V1gcgwQjV+1L486PmXsuV/nIlROJVGO6vpRtyjkuhGg4Ce87TQXJwmewgWyM?=
 =?us-ascii?Q?HRzjaA+LNMFtzGR5L8vmm/wRSKZwPVdvHsMv5JlqNHCre5knl4L8ElhcQ2n4?=
 =?us-ascii?Q?CR3UgmMO3IrcNlX1ER3fpjm1z39QQjiJyY13Sm4EjkFkA/eP6UOv3OzjUuUg?=
 =?us-ascii?Q?JDifAigMFI1Osv+fHZk06/nGvjHUjIo8+jBxZ8gPeAZSFxr+tAj3o5vICYo0?=
 =?us-ascii?Q?+PIGy0kpcGQynEJJuhkYsTI/10zfxOdb5FkmBVKvP7GDau8XMYTlqo/QiwGH?=
 =?us-ascii?Q?yb30Exz+1opEAEZ7OPens8GaRI06nvVZf6hi9OV8ygdlzZkLqoW34Ginu9Ch?=
 =?us-ascii?Q?3HK6k7M5oGm/UC8tAZHUHLu68ybM83+ogkwt7aZD5ieucwLVa9WU4ESm+6Uo?=
 =?us-ascii?Q?JY1yWg9a/QeizoSpygeE8KI8oLGBgrpkpxG/B6iJGzndmBTRkF52ppeMSrlx?=
 =?us-ascii?Q?EWUuRS0cKug6BGRkdZmRoSM/WROikGrWwA5vzT32m3LzEUCh+ygU0rL3BjEq?=
 =?us-ascii?Q?uGqg9WIxJMCLIEXWLGBG/VWhxkXCi6XiRc8ved0Eajhz5yug4sOnhi0Rub4h?=
 =?us-ascii?Q?LnVCQLYmj4ULNwCMD0fKCKN5xgfAuSV/qlnl4t3GZvsg2LVQ45Y+NklIoO01?=
 =?us-ascii?Q?pFX4yeHizRoiaG5bEdmqpKF6LADGi7s9qo5DgdfvLyp7p4BJj79AxAS/deqq?=
 =?us-ascii?Q?NWVUdss6059KuF5ieJJPtWQTT56eT/gZ7I12FKwXihEE3LQ4llFbGREC8cIb?=
 =?us-ascii?Q?kJbFCZ0RpgXYGwnv7pqQ1w1SQC8iK2Rw15UZi0UfJzl1/tZ1qH9LoAJEmwm5?=
 =?us-ascii?Q?zAFVQWM3y6/hmOTln5SdwKcRF7qg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 05:14:52.3406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9bbf1f-fcac-4d0a-93b9-08dce1d7faf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7294
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

The .bind function is implemented to bind the correct
"half" of the hub that the driver wants to bind,
and returning -ENODEV for the other "half".

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 common/usb_onboard_hub.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index f5012ebfbe..8ee37abc5e 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -165,6 +165,26 @@ err:
 	return ret;
 }
 
+static int usb_onboard_hub_bind(struct udevice *dev)
+{
+	struct ofnode_phandle_args phandle;
+	const void *fdt = gd->fdt_blob;
+	int ret, off;
+
+	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
+	if (ret)  {
+		dev_err(dev, "peer-hub not specified\n");
+		return ret;
+	}
+
+	off = ofnode_to_offset(phandle.node);
+	ret = fdt_node_check_compatible(fdt, off, "usb424,5744");
+	if (!ret)
+		return 0;
+
+	return -ENODEV;
+}
+
 static int usb_onboard_hub_remove(struct udevice *dev)
 {
 	struct onboard_hub *hub = dev_get_priv(dev);
@@ -205,6 +225,7 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 U_BOOT_DRIVER(usb_onboard_hub) = {
 	.name	= "usb_onboard_hub",
 	.id	= UCLASS_USB_HUB,
+	.bind   = usb_onboard_hub_bind,
 	.probe = usb_onboard_hub_probe,
 	.remove = usb_onboard_hub_remove,
 	.of_match = usb_onboard_hub_ids,
-- 
2.17.1

