Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541BDCD4F57
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5620286A24;
	Fri, 22 Sep 2023 12:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uIiCghVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F958667B; Fri, 22 Sep 2023 12:36:03 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4FD86A9F
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrGOupCM9Lgqbpuc1JX35jHSDqnPwWJaww8xW0CUjAhOrErU7XcQbyrFKD6MbWUHymlOq8s8uMVPRO7u14UU9SsDGS6QoTSOGtRHc8Z0d2wb/LXsm5aeLpQoQ0eeirRyponlrZKx0SiAT9FW827pQwF15O6LWIFL1hTuKc/4C06FXifUewCN3fymk5uAVsKyG4XFJF/VTta4GtEBnl+yxBwK0IPyAn96p0UQiFntPx3gqWj8Ai3wEX/BJKZtJbrKUd1s8UAwgxaj+xlWi7n371dehIBA16YIc+8BN0hLmXi0fbUDppeBI/x+f8J86smNvg4QMgfehAUXE2Bs1R8hqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcY5zRRXJpVaUX92FOdQWIJcXbtfOP/wgwV2hsDhbP0=;
 b=lKHHehpF3st0E7wmfdIGqOzqUEMbla0GDBgTm6vDxx8XhGzNwvSx9p0MRjpKh/FRdDZE80fn9UfuGd3q1jGKZbDYKgxTEp4ZjEl/Pg5CZ/oYhBG2dTEbw3vXa63AGvcl0wurfKe/SDwosGazImAqDAC8E1MupHebU3nZr0FRHc5yCMV2CVaE+N+fwmU16R/6PdJkA4iZWWTFPxNWjFkSdIPHeL8y/nVdFUctyBK/ukeCEFif0Tu3Nvl5Qxni0cSNsuXhSQsJDRpmMQV0WxfiEhoJ7oG11BraNchJwyX7x0d6UcoFPIj5CzRPlz85T3+KqC5ooho70xo2EijbRq+rcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcY5zRRXJpVaUX92FOdQWIJcXbtfOP/wgwV2hsDhbP0=;
 b=uIiCghVsCDp+/W28jhjrl7Sri0SNl9qeKD1QLcWAoCtKuEMO7MoucHJhpuhAFtZrlfj+UIMCIC+7/jLwp8lD5c29R1fBBTUsDzzXkgVfZO/5+oRVa4UBQTebODjh54Kn7tFNeApbu8rVO7IoDpuC2i2OQKn7h/Kk1faHiwZgqPg=
Received: from CH0PR07CA0005.namprd07.prod.outlook.com (2603:10b6:610:32::10)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 10:35:57 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::7a) by CH0PR07CA0005.outlook.office365.com
 (2603:10b6:610:32::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 10:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 22 Sep 2023 10:35:57 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:35:55 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 04/14] arm64: xilinx: Use lower case for partition address
Date: Fri, 22 Sep 2023 12:35:33 +0200
Message-ID: <66b3361df883ecab4f36ce3b4196fb606c802598.1695378830.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695378830.git.michal.simek@amd.com>
References: <cover.1695378830.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Wgerdb+CpqHMGMqLl8J59A5ekx/E8hGIGLkC1A+FuBI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTe3Clv+rhOzVN4dmZO4H2lLTvC7KNuf9im7Gqh/GxB8
 aWVshNkO2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBE6r4xzA//IsEsdN8lbAW7
 teJt16Dbx9bY32KY75RQMP+nnmFSPO/FPUdePfuy2WT/bQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: ff56f237-9fbc-4225-2649-08dbbb57b4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NI7RXvf2a+iPLpGZ79ukT579vNQcyLOIJhei6B4i07ytWmGTs5HvzYVFeMm39xA2kabKlrlxLQl62JIh/0MseOUFlCTDJPmsgMjidHRMj2rJj6VHyvKzWdd6X6CnDIBvD7aLAbxFoVEi4xZx3XZGCcOEY6pyMsy8qYR7rjpEHifqSU2xA5K4LOAJ6jb/75cuunApaqcdigpsRNV3Gw67+KYyZI2q5R+Mpd34pCQedAJFLumF4jMe0ofSbxeRiqfDkqTa2gc0H36nP9a7fjyfoU21GpFRWGO3WFIdRNJe0+NXPxf7mZlbPWbNqFMYKjNfr5/SdnhLMGc/Zy2U5krrHT+iWus41AJPtoGrejYC/r/DHBUIbME3PJr6+66YZLtgxVM3tYr3i35ECQNSKGbUdZHT7BGj6djuXslzAJOi9X8NtqbIiFLyKxhdspAZ7onvh2ZuybPeEDSwL+aGkKMVoFrooO7steIidvd0mGAu4yLlHrMkfofzPIuzQuw+4fsiubRescHXIqB3Jqnd7LKuS7r6yy0DvwOzwYYBaWCuhFLFF+E91O7LEteF2hGi5s1s/7IWENc7N5YJeWpYxqQDNJ16/DsleMtMtk+NAI7sNgZdv5P9vT9RuBFfbiNgw5sFW+7bSzC6d/BqpFl6RcudVO+dB9v2i7wHEtnkQVmkgZgiYgaQPnK9jPqdHPLhzHWGDndXRcZe/lG0rjyVRW6q1hVHfK7WGGFoCt4qEZkZyaZ7vqLlSw+KsKm35B/1fWvlHk9AC9JJTBDYpVIJDx1m9E6Aij0uTUCrhXnkpy2fnwgS0+wp9G6ByQaVbqwJf9ny
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(186009)(230921699003)(451199024)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(40480700001)(81166007)(82740400003)(356005)(36756003)(86362001)(40460700003)(2906002)(478600001)(5660300002)(70206006)(8676002)(110136005)(44832011)(8936002)(70586007)(6666004)(4744005)(426003)(2616005)(83380400001)(47076005)(41300700001)(36860700001)(316002)(336012)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:35:57.1644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff56f237-9fbc-4225-2649-08dbbb57b4c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639
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

Lower case should be used for register address.
Issue is reported as:
flash@0: partitions: Unevaluated properties are not allowed
('partition@22A0000' was unexpected)

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sm-k26-revA.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
index 47e8e747ba36..1d62c48e062e 100644
--- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
+++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
@@ -233,9 +233,9 @@
 				label = "Secure OS Storage";
 				reg = <0x2280000 0x20000>; /* 128KB */
 			};
-			partition@22A0000 {
+			partition@22a0000 {
 				label = "User";
-				reg = <0x22A0000 0x1d60000>; /* 29.375 MB */
+				reg = <0x22a0000 0x1d60000>; /* 29.375 MB */
 			};
 		};
 	};
-- 
2.36.1

