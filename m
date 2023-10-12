Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24678CDB482
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 13:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8756E86E7A;
	Thu, 12 Oct 2023 15:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1JVWiMHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10D9386E8B; Thu, 12 Oct 2023 15:02:58 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75AE586E87
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 15:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwz0Ke832qA7e7VbltvfQT7padDZwqhiPWUBteTy7ZbfxCOLNOBrkcKgjxLtDJik64tJzmSfvbjWeGOXM4q3I5fjqIC2g4fMxqRn9v0DsnesEE6fR1eJqxPVqWMqjVDzCEw37p7H7ZTF7+1QnzEh6fUnHWgTjvZC+Ex2Lb0ytWIfYNssFg4oXsSsuPDdIkA2rCRJRKI0+jsHweiW35N5IrMhIUPhTkEJ9Y7TeF8isFCsI60jQsP2nux4wHPQhSTtdSdTSXVIekVBMVoThaItfpdzHI/EEL6Eyuqj1IQf4xbLNrzmuFRCwIvRJJblk4pk/RXDPwylTw7vphoBR8f5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNw8BFWezqsQv/YtmtWhVnM7+QqfwGkKefk4MWBCEJc=;
 b=iOo4X7UUsltco5Bkdu4MEhp1ihax46BfofJ8Q7DN4TCnjb8MBmDlffZ7gatbqEE/vEgTT1g+JKbyWsM2bXvRARmz3nQtlS/FUG43F3otZ2nxHHzboNFT3k8nvHlY3zPp1yMcH0g4URe7V8/b4fYbLuCvWwuOwKfVT3KCYIB2S/HNnif+OJ6KXRiMZzLuEQ/Pzl3ir8G+0fHlQTiLLK1RHpiXG9aMTePoXhvQB65ntSuLTm7RYm6dASDzwwdb/OuDzI8Ie79H2mVrpVbyLWgc2GJDVYFliQ6FN96/rCJyQ/GZFe2lnd8fxhVTfALTYRF36R2DyePf5IE/QqjIWhSe0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=amd.com; 
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNw8BFWezqsQv/YtmtWhVnM7+QqfwGkKefk4MWBCEJc=;
 b=1JVWiMHq6Ef7ySXITQtzYzC99PUUwpTUckAAmniVXFbm0QmgMKeGzw1srYXQb2Z8HkQROEXw+5qvyzIpl8Ex8rXaK8q4/XNMx/jEQOVZEeVxT2ZErrKK1LYKvD/TY6yRAs3JzY+SIOv+K14O8q3RfGIqqE3NitQYJVBvZY8RBEU=
Received: from BL0PR0102CA0003.prod.exchangelabs.com (2603:10b6:207:18::16) by
 CH3PR12MB7499.namprd12.prod.outlook.com (2603:10b6:610:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Thu, 12 Oct
 2023 13:00:51 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::54) by BL0PR0102CA0003.outlook.office365.com
 (2603:10b6:207:18::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Thu, 12 Oct 2023 13:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 13:00:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 08:00:06 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH 3/5] Revert "arm64: zynqmp: Add power domain description for
 PL"
Date: Thu, 12 Oct 2023 14:58:49 +0200
Message-ID: <7ed2a46383c6918fbbaca2d618459b1ee58f865c.1697115523.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1697115523.git.michal.simek@amd.com>
References: <cover.1697115523.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=790; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=tHVRV+zP+rgNKJiDV8SLpnXiUVCO7QhUM4LRvfWl/tM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlT1tx03L+l+5E+8sbviTNLUrml1LmZWu4ofT/abuaIkc
 NFxqZbSjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjAR07cM89S4JBuelp+/tvg2
 F//Xwme/GfbOrWOYZ9XImuy08MaLpWpui696LfGVl2oUBgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|CH3PR12MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e258b52-1e39-4020-b00e-08dbcb2340c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEznHsaEmerWvibKWZvhCy4GB4gpdOktyPg6HsJxX1MWnCv9WgTULBHQHU+bdI0uaNlvGFoVxPkdC8kW4te7yQKwtFX+0EUYMmarnlTJPESLGq8VGXlhvHHXfmqZr9sx7waLBnWqEdgD9MHmcn9sumzm14KglGhKb+YDR+Clz279ZZEHpa/VmgkHkdAzodF/cb3dhUhDZp9FkoosRfEpAA9+y78NbrN6vYeosqarXkGA07FI3nT8pvLjRZHOpVJNOn2V1jFzviR1VMj6wCZ9okJUuNDjCZxFyv3/2pWbmIFahXmv5LIgg4J6tnlfURGUQFCne+kp7wnZKjZgJ+HAdpPgIF+qxU5x33NsfmnJHIYX5WX137/qv+/iiJa2yyx4c+LTa0fQS9u8hGdMhgvu8nYCoySjS2b4CfI+R96+Axw2AEK4BCFBbkJdnVuUxyXkEGvefttN7dCrk9qXtAeKXuHQWmk+WIDAKASEU98QhA/rwMpQclV/mVRoejdchelIz5elTPpXZEwR0qMmRZrM6gyEsb/XTXM2q8iGEqu137siN3OINxIJLEb4q9S8CD5LiMOjqYMaEPB9RPFYcmdsaD1/FwlJRWJEwWkMuACcRohvjCK0TwWuLKRZHO/WjrDSKdelEK1JHQzkLBcDwVOwcKkX0Y0RQahwXfIecAa0lGFTf5kpehyHM5RAOoX7dJ3BzQ+uwNd5Hou6uN9210KM41kmm4Nrukisg7lPfmZH2t92IbAGjoiW5bSqEmsC0IjwCy0Pb5LuszGvDAhi7Bs9XA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(82740400003)(5660300002)(356005)(41300700001)(44832011)(81166007)(8676002)(4326008)(8936002)(86362001)(2906002)(4744005)(40480700001)(36860700001)(2616005)(426003)(16526019)(336012)(478600001)(47076005)(6666004)(36756003)(26005)(316002)(70206006)(54906003)(70586007)(63350400001)(63370400001)(110136005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:00:45.4658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e258b52-1e39-4020-b00e-08dbcb2340c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7499
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

This reverts commit d59fac2f3f247470708a1aed1af96802a05e0e61.

This power domain shouldn't be enabled by default. Power domain behavior
should be handled on case by case basis. Adding this property to
zynqmp.dtsi is breaking some suspend/resume cases that's why remove it
from this file.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 463ac14f4b59..366b50a104be 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -257,7 +257,6 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-		power-domains = <&zynqmp_firmware PD_PL>;
 	};
 
 	remoteproc {
-- 
2.36.1

