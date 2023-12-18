Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284FEC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 12:57:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA15587E00;
	Mon, 18 Dec 2023 13:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dZazbEvO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F7C887E05; Mon, 18 Dec 2023 13:57:34 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2648F87DFB
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 13:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NO+KEhVGCLNH96YVpi5v41ttBzFDutkxLRVD2NUdDVrHAuwv7u9WbZhaRfhQpcsw93aNhY5YjpB6F4Pc1npuAMR02H0PQP88V7mo/KK10s3B21OnFqbSy0FGfTp+GHXZgYGlsa+Oo1EjuvUPfA47E5ORTMDzC7e7d9yH30u3W315C04bTu/xRvsKFP14v12xKVr4aUtfBx8fiDgXMbx/30e2GvkiTLbFUWdpLI/vgpAu6ZBtXi4XvyE/Gd7oUWmGBPoTWunoqYGQhSaxYVrQAm8os6EyYtw85PoNbGj9eUKHc1tSowuIp6LR4DhX26QCYAg0/bLwUSDbmZ6j0ND2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvYUDy7ORI0z/4kFQbhMRyGsNuyzOx0UzVP5le2prRM=;
 b=Jhwz8+Azwz8OhmE5G2Ibm2UQY6MjuUFAGnIYorME7+5QkJ393yYG+nqJQkLYVgVQFB4DTy/9gkY8XRQOiESs69jXS6+ADza7ejRAHcyFm2O9/kXP+wlqDIuXuqO9gKWRitM14U02NfuDDcbo2ni5mG4/Q0GxuslRsrPNXzx3iV2TMPFLK526Yqg2NzBR6Nmn6vDJHg96BtAdzhLRJJKusZLBAedr2k+UZEYUzTlyd70dAzI3VVXc4LGSIwdkTkeqhuV6+c9d2KY0ohGkDwKBAICxDfOG0SKfoufRyI4ZFyLo6scdJmPkO6BakHJwoTvL7XedQylCUGkng2agc9a4PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvYUDy7ORI0z/4kFQbhMRyGsNuyzOx0UzVP5le2prRM=;
 b=dZazbEvOQJJEN4ZzL6D0SRakkGnoMSkYpTAG/V3xFUn9/Ed6JLPdHYxEdYOjE6idJ5hyaFWx+7n6vWbM2QDsIusR2c9yKAdymOJ6pwhfIw+K7dP4wryfbWreHL59QODM/biGAhUMP9QZ3eEjSxoCHVqEHXuOkotRKZxcLu0H1v4=
Received: from SA9PR13CA0057.namprd13.prod.outlook.com (2603:10b6:806:22::32)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 12:57:27 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::47) by SA9PR13CA0057.outlook.office365.com
 (2603:10b6:806:22::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.16 via Frontend
 Transport; Mon, 18 Dec 2023 12:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 12:57:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 06:57:25 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] arm64: zynqmp: Describe ethernet phy on kd240
Date: Mon, 18 Dec 2023 13:57:22 +0100
Message-ID: <61f89dc055f191fd4138b80bb7e3217d814502f5.1702904236.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=yrW5IEiM1lquaFwfEqQWN10aajAg6PfNxEWYSUeA8MI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQGx7Um8uUpp3INnnLevxj3ynvyZ/tJV0seHzi/pV96s
 eJciXvGHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiGTIM890eKYV9XXvqtka6
 op7XlSqtFb+2+zHMU87gDJb4+PxI5oWbfovakp+5BSrmAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf4855b-25a9-42f6-bc91-08dbffc8e329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZeteKteH5JFgJd8SvYct27FGM7/meGuWn4XQdiH0c7EgG9Wd7iDOy0T7fF9nYzTavrVEptacQggtvr0eCcRbqBW1RLd/cIakWi4GCIMJ96U3ydyoINoo2Re6RFnPpLEz0HSpfXaQE/5hak7bNGxbnQbRHrmZJG3SSsink61vpJEv25IZGoMMdNI/AMf/fZxFTgZp7Kia3/HUkhuHn1xQrk6RVXuxsNyeziH4jG5KEl+qlaJ6iJTUkkdeQC2KvqdgkEslqqNMtZ1vlLo9KD2plCbYQr+GvLb9X03bQ8PzHTu0zd5bjx4nCnhOtA74rVzwdh9VuUOTHIofpH8oUX4WrnbHlqOz35xzydEsQ4MPgAksOaYKKQXmFN57WixFzdZ9KofPRvN6iBywOPwltJIClRRDg8iAHkVsUFjRlJWDxkAQBOJMW5yD3QcGdxUTy8ItxUItmTakhZ+H5NPtdhV/27JvDr1un0PApKbAI9BllbIW7hUE4fvDHRqmgdXzO6dQ3krnv9Zmk5YN5Gkx7SXQRXjinVyNLQ1qGmbn5cfh9ysyCdNB1K7wkvagxL6HJohnRXzsfv7lt39Cnkqm37HN1M7acc248+f8Wn/c8LAljwdQq1rCdHa4vCMPxw1SnMk0xlrRI5YhfoeFw8reRZ5+hAfYUIKnjS6nv4/CeBhMzZ6VvaM1h9gv6Oqf7ewMQDqhD/5n3PQ7nfq6TIMzOslM6h4GN39HYPv7jF1M2guyTWmLZZcky/oGayHTex8kvE3oAt/1Tvk6YMT6KlUsanBhVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(26005)(2616005)(426003)(6666004)(16526019)(336012)(82740400003)(44832011)(356005)(81166007)(86362001)(36756003)(8936002)(8676002)(110136005)(70206006)(36860700001)(478600001)(4744005)(2906002)(5660300002)(47076005)(41300700001)(316002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 12:57:27.2137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf4855b-25a9-42f6-bc91-08dbffc8e329
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
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

Describe ADIN phy present on KD240 via ethernet-phy-id compatible string.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
index 8d0ddecdc14c..298e80265e2a 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
@@ -120,6 +120,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		phy0: ethernet-phy@8 { /* Adin u31 */
+			#phy-cells = <1>;
+			compatible = "ethernet-phy-id0283.bc30";
 			reg = <8>;
 			adi,rx-internal-delay-ps = <2000>;
 			adi,tx-internal-delay-ps = <2000>;
-- 
2.36.1

