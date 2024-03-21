Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6B1C54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 08:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05D93879CC;
	Thu, 21 Mar 2024 09:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F036TYmu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F60A87B41; Thu, 21 Mar 2024 09:52:37 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 434B786DEE
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 09:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcY7As+jijz2mblYHpx/Jl2R2ocHPxMbMvzpPLwsh3dwNA4heSKLUSov6KnFB7e0nX783Uz7okYkE7Q7CevUQD8WJOMe6sCn4PUCJMgu+5Nz6AAeB1wqIP7G3Lmtf181bpiVperMvhvZNUemA1zk84CQctflB/lyuTD9DSbjRYpIHcr23K1h5kPBJIptIHy/MluAza0KEI3TAMilb97smcbchDUQNi+oX0/Htq2CjrIdAmYaMc2dpekhCSROVb2cT1sk3/pfs6Oofii31z+/tZecmCnKdDezJL2QJ65/dWX3BstvOP6dMPCu07Vb3wSBVfZQGPqoHtUh4z+7E0lATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQAPBPCjYzHjgELstiPRs0qvir6kIpvKWuykY3pZBWQ=;
 b=beIBss3cXvEX/xJ02KE5mBvHWxXUYZshu+rHbXPtebxArBf0v+SE1Sak+E9sVKtiIO6tTbqJxUKPh+jOtwL1QsfA8qizuCR6BxB2I8JteHo+U1feL97d9KqjXrEyf70t8omIv43n4K24LYk4KyCus32eBVzjd4c/0IkUA5ITmiErN/V9P83Sy5mlP1LQ9Dj/gy2dC9tDu6DSxG27KaeWUC+K41uv6xsAVdHNntHPt85u0v0XI5oYiWAywmG229kDtWi/2PiYvODkxBD+RZhIXBJdgtMIsHepD8R+x2iFQdfOF1MAMtX73I+yPveJcVzdp0O3PoDrjCXqnk57OvYZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQAPBPCjYzHjgELstiPRs0qvir6kIpvKWuykY3pZBWQ=;
 b=F036TYmu3i7cyeVs0XNq5BSQK6q6MU17l1KXNsJrforee8oyZbFeQ8e/yP/IHTL4ORF83rHga86y2lvLhT/fBP+oIqpKS7rV1k3LaDOv0H4fW26VIKP9tk42xjJ9WQtWmlJWwlcODASeXGTaUAW6rFmDGWjFNbeuwIWJj7gjxTs=
Received: from BL0PR02CA0099.namprd02.prod.outlook.com (2603:10b6:208:51::40)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.31; Thu, 21 Mar 2024 08:52:30 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:51:cafe::c) by BL0PR02CA0099.outlook.office365.com
 (2603:10b6:208:51::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Thu, 21 Mar 2024 08:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 08:52:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 03:52:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 03:52:28 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 21 Mar 2024 03:52:27 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>,
 <venkatesh.abbarapu@amd.com>, <git@amd.com>
Subject: [PATCH] arm64: zynqmp: Disable Tri-state for SDIO
Date: Thu, 21 Mar 2024 14:22:19 +0530
Message-ID: <20240321085220.2920792-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.37.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: a73ed47d-0f75-442b-1e91-08dc49843d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8T8lMDosP/BzWib2RHuKkgSNmkz/HsbyoXWmerfuwRJHdedDvZXdrg3dfhf6eF0YxmI2jEVXmfuMSG7XjUGnRE3FSCXEujrTshtQSp0zXUjJ0F8tTUqRgDkthFinwuHgbhRJ+LuJ65PIH8tXlkRatFq4KT1FpyEGjG4XfMEXl0kwFuIBaVv20hhKXotK5TnbSF73ko+GXBgUgJ2KBN7KVlROEW2lN4RXqdCxARWwN7ZWykGRCg9GqeB9Fg+p0nSKT+3XwzmUtDI0N8fevGfCHiKn55Igjk+39uJt/SqE/vIHmMquFvnMEAGE0F896MEBMOeAqPvyxJVZeSFcXa13IWXgTXBqTbHuxvNs/9JUmf0mPeLoqbEAB5P/C7yH+xQMDY6SVBnHJoh8ffr+1hqIvSnKXjPGdjIp3mnonjXRb9OEhuVCj12Ot3Nsv46Yh83xz1fN5bNNyPHu2LB0XdHI3bIdQxKhPl5jD8GKDwgwrnuRX7r8HD5gMTO78oiu5/ZCorab74/ZTG2mv1U2sL/bXZsHSag058KKXzbty0pJQMqK29sCawo9tM6KEP161JjLpVGVrI8S6mpu5iDY2V6RMnhKl8NU33gV40VnK6jAeht71ecHkyau1EoYcAgEP2D/RYFvMBF/XH1PfbB7uDS1poH9KHiBddsyYuQTp1200p08Ft/PEZnGDzjWHR7BPNTyLrMq+0eJXbPB7R5z6pi8E6nbMEnUaMPn349brbx11RDO4p2Cs6EO596A3QrUl/2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:52:29.6493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a73ed47d-0f75-442b-1e91-08dc49843d8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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

Since the zynqmp pinctrl driver now includes support for the
tri-state registers, ensure that the pins needing output-enable
are correctly configured for SOMs.

Currently, there is an issue with the detection of the MMC for
the SOM kv260, resulting in the following error:
ZynqMP> mmc dev 1
Card did not respond to voltage select! : -110

To address this problem, configure the SDIO pins for output-enable
to enable MMC detection.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 1 +
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index 6d0d5c487d..561b546e37 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -342,6 +342,7 @@
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 			bias-disable;
+			output-enable;
 		};
 
 		conf-cd {
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index a4b4465d20..13876fb47d 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -329,6 +329,7 @@
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 			bias-disable;
+			output-enable;
 		};
 
 		conf-cd {
-- 
2.37.6

