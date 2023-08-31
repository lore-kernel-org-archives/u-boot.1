Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127BDC83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 12:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E155E86594;
	Thu, 31 Aug 2023 14:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p1v8Aw+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB9F78655F; Thu, 31 Aug 2023 05:17:24 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A29E86562
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkXoqh8W1ywspzj8htZ2IDba5xfFFqUxdU64sZVWU5PQyzLS561dVPe6hKCEqtRgs10u3/Lvt5/gALjarIsZp4HWyoioGqxIXD3/w0t0riSVBG3J7hppfIGbK3+TDTlxXbvSux/Ydix9hhSPKvVmn6dPq/yXkl5nQzABBat926539acwn+v8cQnicSFSPy24w8g/R7/97o2W5AYWtA0tm6+4uyPBppBItDxuIPWT4EQtDo3lD1DggYQEaLNE31YAKase8xTdU02M2Wy9b31TUhktkK+aRR6WP4gf08pM2eoSvXz+gXJCrkuJ9GAZE3SOR0KvuEOteQyphapGfxlPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yf0Nj0pe6aMa9b1QcWmADBv0+LibItrpH+eFId80IX8=;
 b=aQsXVdd0rAfIQNJq6z7v14G+UT33XB7WxSkpFlWVigK+cMhmdELi7E2SounYtKWxM2Zx88GczZ1+mMTwsNkAjlV/RonuaU2UXgHeLoxA/Ko0tPV5QJtNOWzmiii5yz0zdZYN8FBTQDVaNdP+Ly63OMExXknZhOn3JFdaXAuHkjU98MVelz7fVwwN/YIHIaRnAVoPK652gP4zwoQcsfw8esMfQxzKoDEPoySKLGdibUVEpPNf8YSFkabm8sV02bmiSdMNmFwbXHV+X1RGWocfgA82bqRKEGRDg7VSL9hSIyTZ4dWCrkC1DbZQcMOK/gc8NLbhn5ztcRyI09NJGQhkgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yf0Nj0pe6aMa9b1QcWmADBv0+LibItrpH+eFId80IX8=;
 b=p1v8Aw+LoQCUELwCOVLozf9RvB9oGt+pe+6FXMNxEtSuGxoJxTobdLw112DvvyU9HhCYGCYPzLt60sIYFhGky94oaO0aEXDVXQywLZfI/9Emee82TvORnfp5AzsvlfrJ6S5VCWv7gViYNoSxSxrzpt8xNyYCIFkUH+iFk9Vhvv4=
Received: from DS7PR03CA0195.namprd03.prod.outlook.com (2603:10b6:5:3b6::20)
 by SA0PR12MB4589.namprd12.prod.outlook.com (2603:10b6:806:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 03:17:16 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::f) by DS7PR03CA0195.outlook.office365.com
 (2603:10b6:5:3b6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Thu, 31 Aug 2023 03:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 03:17:15 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 22:17:13 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 20:17:12 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 30 Aug 2023 22:17:11 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH 1/3] arm64: versal-net: Enable TPM for xilinx platforms
Date: Thu, 31 Aug 2023 08:46:56 +0530
Message-ID: <20230831031658.2203-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230831031658.2203-1-venkatesh.abbarapu@amd.com>
References: <20230831031658.2203-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SA0PR12MB4589:EE_
X-MS-Office365-Filtering-Correlation-Id: 9554fbc4-5611-4f7f-7d3c-08dba9d0c709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHP+KzLdsiN1BYsdjHDRZsqG8Vskrtiqahq+5BcyN/mahzHHYjQnHuuyklgwV/7/zmJ+RybIarMBJxyj8ygHKQxegXimx6K0qZTMQq1pj8C6YFY28jCL95socMyK93v5zG6qgL56H8IOENXC5Mtf3L1ttLqhrAtWtqAmf+rnZdluRQyhdLaIFfddGzSBlm07ulwKk9UNdHkvlUFiWDrbArlebILCRhHubIIWC3NUB3vWXNi+eM8zhjnW9v/sO+Zm6joMmay8S4o8qKNnob8q8BrvV3IPQ/D1MZ/YJQ6vw//Dl21zqpMo+Uv+y6XqLEtM6hKqoqJ9s/HfSuQdkPY3ncOwlm5C4VfZH3n8mVTJhSC2P8zWbs3k3AgKLgfrefLX46onl3kMO8YDGI63R6cbN+izyTJ0LqND6PhE5e+kpt9mJbkk+T5mlEgoiV0PGy5w9WfE+y4WQjvLIlFVcUevUXZFVhSxQxwgKyayWKlqLaQP0BLNg1IBE3UvWv4b0teKmjlPEQi4V51J2+n8GTfWSQSwdeEg9LIFhqjGPjEWBy15rp0ZlCAusXjn/DeiXIMtDLsu9iVBvli6uTt86Rc6zP2p0TMLciS8ORlGi7DDLPeDTZ+3Rlp89jq4/i30C68hauWyedNFvDb1CbIBxkHjPxsbLcmQBnrtRoZKoTDO0HoGG0jrXFR2wJuvJ4pg6kkSxzBZ5F3mmRKFPCU6VY1WakI+GgEPi0Bl08pUKpDEVQ2aa/MTsmT2TWIMgIGYBhb9F/zQ+M7u6Tiv6203Uk+TZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(36756003)(40460700003)(40480700001)(8676002)(83380400001)(5660300002)(86362001)(41300700001)(8936002)(4326008)(1076003)(6666004)(26005)(2616005)(426003)(36860700001)(336012)(107886003)(47076005)(478600001)(81166007)(82740400003)(2906002)(6916009)(54906003)(356005)(70586007)(70206006)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 03:17:15.9542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9554fbc4-5611-4f7f-7d3c-08dba9d0c709
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4589
X-Mailman-Approved-At: Thu, 31 Aug 2023 14:38:51 +0200
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

TPMs are becoming popular that's why enable drivers and command for it.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_versal_net_virt_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 97904bdec0..0510bb4cf0 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -51,6 +51,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
 CONFIG_CMD_TIMER=y
 CONFIG_CMD_SMC=y
+CONFIG_CMD_TPM=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_MTDPARTS=y
@@ -110,7 +111,6 @@ CONFIG_ZYNQ_GEM=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_ZYNQMP_POWER_DOMAIN=y
 CONFIG_RESET_ZYNQMP=y
-CONFIG_DM_RNG=y
 CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
 CONFIG_XILINX_UARTLITE=y
@@ -122,6 +122,7 @@ CONFIG_CADENCE_QSPI=y
 CONFIG_CADENCE_OSPI_VERSAL=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
@@ -139,3 +140,4 @@ CONFIG_USB_FUNCTION_THOR=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
+CONFIG_TPM=y
-- 
2.17.1

