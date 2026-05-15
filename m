Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3324CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 12:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA7BD83EF9;
	Fri, 15 May 2026 14:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2t4QFMRP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85F8C8466F; Fri, 15 May 2026 14:48:17 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78CC983AA9
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rd5YgYLJuL/gggtIKxFePbBuEuQ5dYBUBTjdS/Zp/6e+ibEVTDmebQGCT/F5BkPuMH6CNoRAqQ0cviHP+xwkG9fsKfUf2ex0aP5G/ACC+JM6qp5QDnE2Bzed1MmxA4G8glwe+kdEltC7LRak8ImSvCLO9a6CEd70YPaRFe4dEj8xmQtYFmqcVVoBMKSS39zqC+G2GGoH2TlQtEpWo2az0IGCJ4su8MfpgQOuGyCNTz0OYlY94eMLT957tDvaxNE829v754RIP4xYbdRop3ePBvkDc6mMRZPiwY+fZiYc8eO6M/I0YtXNPQOoljAttltantfHxXmUKAF246tJDu5NCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jCtCipNU3ro8txWkO3AMNX01XYBTHYjtQMrUnenIfs=;
 b=ueJZtoMwlYVlxyOrF474ZSgBvHye4Hl13QWp0uJ7k4WAGNOTgX78V8R9bk8coX6wo1kP/OrQkMkcaw4bZWMl68ZGDtHbftyza/vBeaktgMwST26ve3O+TkBSm/QF6ty4szxokY4DsjhdeHrSAM/1J9RTFIJsGvdMN2He2YNz4uEZZcGMqYtkOqjeisBWh82dSO9zlwVEFblE3hV8HuNoG8s3Nn9cRDvnO9m7hT9FZUZIfX+A3jqnjGmgJgUBkm8p5bGW3c5uS7T1S+5bOu66u4Q3YIxo6yUbmYITO6d9QPKHy8VNCcOPvmbGBBqnvgco4uXz2StT7a6VE7tRwOog5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jCtCipNU3ro8txWkO3AMNX01XYBTHYjtQMrUnenIfs=;
 b=2t4QFMRPpKWoT8LY4GWpjydCUUcNMSmku3Oln8/5oDRIu/g1dD/AN4w5qG1GQT1r+oZWUCcqTblJ9/65G0QIilxTCOtfnH+/eJYVyolgWwvc3fIofhMs7C6yM4VXJMCpJSanPWoHZqL2P1/8wCTuutkQHCOx8VLuzbN0b6xCkqk=
Received: from MW4PR03CA0251.namprd03.prod.outlook.com (2603:10b6:303:b4::16)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 12:48:10 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::3a) by MW4PR03CA0251.outlook.office365.com
 (2603:10b6:303:b4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.13 via Frontend Transport; Fri,
 15 May 2026 12:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 12:48:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Fri, 15 May
 2026 07:48:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 May
 2026 07:48:05 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Fri, 15 May 2026 07:48:05 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Sandeep Gundlupet Raju
 <sandeep.gundlupet-raju@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/2] riscv: Exclude ACLINT for TARGET_XILINX_MBV
Date: Fri, 15 May 2026 14:47:53 +0200
Message-ID: <c01d51e5eb85295b48bc939fff505fd59afeac6b.1778849270.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f5c30c9faeba9e0f519fdf89c10e04c768c5f92b.1778849270.git.michal.simek@amd.com>
References: <f5c30c9faeba9e0f519fdf89c10e04c768c5f92b.1778849270.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=OUCsR16+jx4v79APuDu8xjW+8PdiFQ2OVrwbcSUuViQ=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSxi/4/ECvvMSfUSy9vO7+qdJtkUI0YR1hw2Labc/9vP
 C4610mno5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACZy7Rwjw94lahd2LI5PuKgU
 oT5VKv+M1EzWK7suWGUcDWk74DutSojhn8GVmTbLfO5VvngzZZdzCvcyW5lWxWYttbytT61nnLg
 hwwQA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb66bc1-38b5-4c7f-d402-08deb28037e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: vkf25vuMnsaZAPTnaNalgeg8fN8RFbO2sc7B7KcNYZk3quH/pLX5aKF2j2VA3Xivfnbe/khQEe4PNqV5ZHvAPWbNY0asPm76xNNCkTySHj+rAWQlrIDLmi5X3er/wbBvTw9DQT+hYqu2+aybq56iAPK4QM30FRQTubHzewiqggcEffTI4YP68P+6uVj0d7CIA8FmXccaO7hnZHA8R4KKDwfQhNJ/5yrT7k4MG3VVRL//sQsjAYivuSl8p8wxkd5Zf6rTesL/Tqz3rnyfPQVkfJugq6m08X5zQFxpV+CT0xR262FImwy33DZEBP//91PlkAqnmCQPrXvi6msfjkHoswA0FrFFj9lBAm1yleoD6lvyupz4YdG21iHHLFWqyzFn5cwLsF6xQxmKiktf8/H1ewoiA2WH7PkcM+qK+QN0CAqfNq3+KQfZPU9idfjz7X6lZw9Ytiyahlet3ElV2iIWnEo5e+lmMM28al2/ytHt7ddcCIFt4jkqDjQ/2ms7mS/7SF98sG9QpoU3YaAHVKB6dnI9+1KgAzjDyGAIYQESDZTRVG2g5LPL2AAoo38qDjwN2Xk4LmHN2NKR1wa45SsZn/fbV5waSTUIBCsjxJWibKlA/tMs3XIgsbtuu2W+UM3k9q6ibLsQSa0OeboS9TA7RiABWklA92qNcGilGNTPJwCHskKlUXQB1GV/eGXJY8m+yAkqb3ilYGmC4qd459crmvwdV94qNFEw56daAkVOzBQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(56012099003)(18002099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oP3FBZDI5/9aJpLKoCwHZvh+yRmTefnl4V+rdpG6y8naeh7CTO3DHnJhhd/uuCwkzys/jWvdjookuDzRszhJjfC/sBewFblz1Z2qy9ak+iUvM+Bqlit94RxVCrfpURFjlWTcrBfwY1uV+LF+0MN1PsZo5Vo6H+hVcPWDDsgiF+kICe8s/pp0sXCpvSWFfVIlMF2Olqp4Dhg7ZMomhkdVhoxOhp/gC0qFx3nUvgS/cWz9Nh6J6g1bIt0kRUtg9EpcXWStO+GKKGzGY8XdZnCOxoXjeImwR9TyCLwSHVHo273XCAr/TXr9t6NetppgaFdt+c6vNzA8XOaaqjGKh+ZVjMrI2o+rglJSQQuTG2jvdwvCn1qJtswX7hrKnExz9fm5KCDkCAXaFfvNsKFP6X7poAawbD51xQ4RPlIc9KHPPJ6zLYQij2Qg7TUwlZ4m/KWZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 12:48:09.5430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb66bc1-38b5-4c7f-d402-08deb28037e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
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

The Xilinx MicroBlaze V platform does not have an ACLINT (Advanced
Core Local Interruptor) hardware block. The timer functionality is
provided through a different mechanism.

Exclude both RISCV_ACLINT and SPL_RISCV_ACLINT from being implied
for TARGET_XILINX_MBV while keeping the default behavior for other
generic RISC-V targets that do have ACLINT hardware.

   spl/u-boot-spl: all -1382 data -360 rodata -200 text -822

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v2)

Changes in v2:
- Separate platform defconfig from core Kconfig

 configs/xilinx_mbv32_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 67b7db94d745..82bbba6d0f00 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -20,6 +20,8 @@ CONFIG_SYS_CLK_FREQ=100000000
 CONFIG_BOOT_SCRIPT_OFFSET=0x0
 CONFIG_TARGET_XILINX_MBV=y
 # CONFIG_RISCV_ISA_F is not set
+# CONFIG_RISCV_ACLINT is not set
+# CONFIG_SPL_RISCV_ACLINT is not set
 # CONFIG_SPL_SMP is not set
 # CONFIG_AVAILABLE_HARTS is not set
 CONFIG_SPL_OPTIMIZE_INLINING=y
-- 
2.43.0

base-commit: 6267afe7f46f3ae1cd58671e57aae88646c835bd
branch: debian-sent3
