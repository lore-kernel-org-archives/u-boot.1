Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549B3C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 11:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D900B8801E;
	Tue,  5 Mar 2024 12:03:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mJUoiBzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D090B8801E; Tue,  5 Mar 2024 12:03:15 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E39AC88015
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 12:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdgVc66N8N3Vhna/JxuUHJX5+RLf11RY2WgmtoHw8XgMXk3RVF93nLCGiLXycF3UXm2pPruT0vM0MVrQeYI91n9nqgNCa48S8aNAmtJx8SFWYhHEPs1BEYFqeYKu6FHyj1Vdqkcclq2X3yciFImDocPeWGuCFcJYv9Fnt2rEbxiuZ3/VYWrLwVY54vKvTmbE0Z3cIf0ndLf985Ld/Lp6Ob8KQTb1kfKJrBnqr3ypqdysA3bUH7cxY5NqszTAMazy/TM0QI1kVzwNpSQ5ZQdeLV576yp4Azmi68HMdx4Uic6JsPB/ZBZID3+y1Rt15OIfy6LWzWxpHTFYfSklYEdGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G10XtqX/Glm27RFW2Z2xG5BW0Fg8qCMgflP5bu2X+FM=;
 b=dXH88nskIjBtJ4DJoUR70e+5k8sW3IGej5rDcakkQic9pTmLCWPkKE+71KmSxS8cJG4jcrj4zlQT8xafyMpTFY5ilsdtCJXYzDDGqEaz6dHSd2CFj97VxOQl4ji09mUyIDP2dvQvyclDHR0a6d7s+PKzHIVKLX0IxJBaEpGpJRgRxcDf+W0rS6Mh/oH0fYy3AREkYWFz5lepQS6HteBuQuh/IGkoCfwiNKsFh9cu4z4Mx5XT0XlPParra2bHLd2ln4pei6NOVL6SclJyLjEa4tQ2jSZhGUd/UMMrnJWV4H8FvzjoD33dWHlPi6cLnq4YtCg6bPo3R3WHFI7NOp5yzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G10XtqX/Glm27RFW2Z2xG5BW0Fg8qCMgflP5bu2X+FM=;
 b=mJUoiBzLZv0yB3QMyuL4W8+QNX4byMSc9LhbVzE0UU7GGl9KysCQZImbd8ktYRZBfgjQ1ep6PYLm0UH5gInFFLFXFdRjyocxXFfdXfPIry8gVz9Xsfs8k/JEc30IVURxCViIQUi3bNeueAO6dicrqGtE8VUOzSCgjbE/Ls6WYSg=
Received: from SA1PR03CA0023.namprd03.prod.outlook.com (2603:10b6:806:2d3::28)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 11:03:06 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::5f) by SA1PR03CA0023.outlook.office365.com
 (2603:10b6:806:2d3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Tue, 5 Mar 2024 11:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 11:03:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 05:03:05 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 5 Mar 2024 05:03:03 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>, Shubhangi Shrikrushna Mahalle
 <shubhangi.shrikrushna-mahalle@amd.com>
Subject: [PATCH] arm64: zynqmp: Add usb4 to the boot targets
Date: Tue, 5 Mar 2024 16:32:56 +0530
Message-ID: <20240305110256.153308-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|PH7PR12MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: e76f4cf1-f43b-4381-b00c-08dc3d03d5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5irYfrXIOQzCMBpUYKTqrhxghLhC533JW9aXwgdkzpdF2pz9rnKa4rr2Fq4x0/hvUSX+f7+va8uBdlINhLe/WLJtLbFAn0bXKDq2FUrdLV5HbZPzHL/P0iwaPcEB+lGngfIW3wOCR/Q+EYTwfvr6PsKDRu+Q4rYyfl7ui2W6Z9B09TTvECNRovYuUuxL1Zz6njivKI0PWEfEdMphoVAA9dpM06KsptKFLyVkzyFCoi2RJL5+pZu1+HX1ejLmA/Iq98I4Q6D/WgDsUHvLnHMk4hM5pqILZRrQKt4PAdXXJpr0kaz7fl1fQtf+0o2VPM9Zi+sAjjVHFst3hfX/YBTLnI6hyvV7wlpxP9nbHI2F22t50QYgLpvUF67Sw09tvDzlxvLHZbRKexFNPZy6iFGX8at6lhU0i0q10gHpwQ99OsqotOlrgUWtfFhmQDgUxoyAJqyzPPFPrWc8JzTnRj5IcAHqqW08gpIGidriv2M53h0B7W82X/+X68hjjaBjmBlGEnASjbR1GnkTp/VwkKX1gzBpjNQ4BGUM1CCvhOvDCRRqtYH1Rs1SmEoICnjZz54vahAcBSJglxEFMVg3ALvNOQhYkRswnH3E3oQ7t++F75zXPCEPDuFxsVW5U065nX1OFJNn2uKvkMA4mrBMF9KXaRvlEoKOuc4NtFhojX/swanIujnvICPdSZgpr65lX/PI29oq2rAzrXltL9B/wce0mclqSyGsueVTtm+4CBh9/53D9zWOMSwJhnqoviJZSDtv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 11:03:05.8268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e76f4cf1-f43b-4381-b00c-08dc3d03d5ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102
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

USB4 has been added to the boot targets and
also add support to enable JTAG.

Signed-off-by: Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 board/xilinx/zynqmp/zynqmp_kria.env | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
index 0f940bd68f..7d3ad31226 100644
--- a/board/xilinx/zynqmp/zynqmp_kria.env
+++ b/board/xilinx/zynqmp/zynqmp_kria.env
@@ -44,7 +44,8 @@ usb_boot=usb start; if usb dev ${devnum}; then devtype=usb; run scan_dev_for_boo
 preboot=setenv boot_targets; setenv modeboot; run board_setup
 
 # SOM specific boot methods
-som_cc_boot=if test ${card1_name} = SCK-KV-G; then setenv boot_targets mmc1 usb0 usb1 usb2 usb3 pxe dhcp && run distro_bootcmd; elif test ${card1_name} = SCK-KR-G; then setenv boot_targets usb0 usb1 usb2 usb3 pxe dhcp && run distro_bootcmd; else test ${card1_name} = SCK-KD-G; setenv boot_targets usb0 usb1 usb2 usb3 pxe dhcp && run distro_bootcmd; fi;"
+usb_boot_devices='usb0 usb1 usb2 usb3 usb4'
+som_cc_boot=if test ${card1_name} = SCK-KV-G; then setenv boot_targets mmc1 ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; elif test ${card1_name} = SCK-KR-G; then setenv boot_targets ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; else test ${card1_name} = SCK-KD-G; setenv boot_targets ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; fi;"
 som_mmc_boot=setenv boot_targets mmc0 && run distro_bootcmd
 
 k26_starter=SMK-K26-XCL2G
-- 
2.25.1

