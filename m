Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85067C83F3E
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 08:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8A568690B;
	Tue,  5 Sep 2023 10:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lr9oYh7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C6686940; Tue,  5 Sep 2023 10:24:34 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 933C98654D
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 10:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RS7bffKddyHpFod2dvVuhBtkNLiNtu/gvcColc6V++9CaCbfAoQk/wUD7CZLIJl9JucARGET/AtDmZMAcOsB66Cc76ALD/w7bWXxj7ZbX66JQwI9een+pYEMF5DDtHUzE0PgFetOGrHjVL2NJCkEqJwma+pz4IQCLrvZfypI/+V+cMg7IgW/acgVnV5a89KNVxqH+RBLBy4e5gr9AKbu7tpbIuCuMtRa1DvwNDoN3XGRN1D8rUQDC1UxVFqITg3+UYaL1t6gs6y+ufdAA6NaO7Bair99Gh2s87K6Rz8XFjgVcrJYfUTBhNaEHnyioqPydt/ElFPZJycp9CxpgaCOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/FhMm2n/Vd4tNYeoIE68WA0FPU2M5engIYUJQhdvN0=;
 b=gz5WVGVLYQM27XPRyVaYpBWyDBHXH79LskDv26TDYQxa/xmpPpAPyk3/U7h4vzo/C0NwEwcK/8uN9iR8q10ALe/mjV4pr5dJDt+qIpAcqwwoH1qXkXYAFaxtK7ghjH99b9azbxd+AFUTZvQiut6hGLotnm6GTpQRbtspsWuB0q0vWf6v7xaw1sQpsVL+t1EIjHL5cVH5i77q1hooisY1FYN4waRHU15KV/RVPxjCo0r+2XZN8AJgZq/B5g41iuxE4h3SStIdUKuB1qfNwdBPPYsZ1AiXKjK9WyPqknNefNIOqMy4bhLZ/p6sdRS3pUe3bijQsmsszSR8uZamBAz3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/FhMm2n/Vd4tNYeoIE68WA0FPU2M5engIYUJQhdvN0=;
 b=Lr9oYh7QKBL3IVhVr1k3zXfvytmEzDuKdRr/ri6i9sDkeP+rdSgsIZZMq6a6o6e74yJ4lf1J1KdHU6xgfGOxSl8MZJhLSgKly9NZg8lMb+kjUL4V3WGFZ0q5dSYqgDnNHeoUJ1pARIk4DNda+ba0I6aoN4BAvTYMQ8g2cOw1C9s=
Received: from BL0PR0102CA0014.prod.exchangelabs.com (2603:10b6:207:18::27) by
 DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Tue, 5 Sep 2023 08:24:25 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:207:18:cafe::ff) by BL0PR0102CA0014.outlook.office365.com
 (2603:10b6:207:18::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.29 via Frontend
 Transport; Tue, 5 Sep 2023 08:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 08:24:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Sep
 2023 03:24:20 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] arm64: versal: Do not define boot command for mini
 configurations
Date: Tue, 5 Sep 2023 10:23:36 +0200
Message-ID: <41ac52d946ac53d162c407094dc215e6a932af92.1693902205.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=e/+pMkZsowkDze8hiFVp5No/IHhc+1qF27dRA9KmaHI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpRvT2uPiy7R/C82p13M2PzjxfJFvAUWn5pbd6dPzrx8g
 Gfzp0DfjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRYxMZ5oc5zXxgtr7TSnPn
 jejbXEffnr2Yy8gwv0Il+pmZ6sm2TtNLrtdST1wJOaB7AwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: d74f496a-cd42-4ff4-4ade-08dbade98399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9nALi9fd8Vrp7OM4lNJgnI9tgydpDqPpq+X7RcvZAJXXIpEURKI+awA2zQMQbe+L3vo4uoDrQioxFopLBM2+ymplQExrHKeW1vKV4HKtLdZFdeu3OLYLKhv4ybfR9ARgwf/MQN/QGFIisnWrjXeP/KqRz8FH8BRjadPRPz9lSKKuUVSiEEp6z3V0b1UKLvwgAZQmX27rCPdOBc+DKDhqpQNKLcKZTB8djuURJse4TL5AaME8JsmOTfatJ4qcYDAcPWlz83496/eLUihqhz9dIZy8A/5RkYD005wdz3m4Zd7veQwp3Ab7kWhTmG+/UiGn46GRIBQ4JwUW/3eeWFIQzd5anRE6mzvat8YCchxU1ov5WTEQvcj/GdZ8HmH75XsMHUFaZ6d4vCcGnJyezaiivY45U6Bw+2uliuy8Fdd91QZGle0M9m/B7jLIrsKLO6jDQawcETN325pu144UyG21X4Cgns2horpOOV4kg/ftPcHYaBCxbkFP4CnhQTTQHk2E1tw/j18qexrJ70OVQKTIs5cTiuDovQhCtywcgunjMcC2JFyQZBAIHb9XoCFduhyphW6UU0mbkxcBJCia1O4HQ85X5Okl+VuktYRST07tYZwWpwGfMvZgFAAvO15i21KqnGvQs2eEYn9kEy0+ebMx1Dv2MOdgvNx/9Q4zcPrGgT7ek/LX5POlYWfC6mdpNzIaYK8ymrvuV4IbbZCohZxBAfsBIEEVfqU1kGUZ+uDo2B17W8h1qyu4JN7/Uccps/dOB9ABArrIeTJIhwsF1Z8niA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(1800799009)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(36860700001)(40460700003)(47076005)(2906002)(36756003)(86362001)(81166007)(356005)(82740400003)(40480700001)(6666004)(8936002)(8676002)(2616005)(26005)(5660300002)(44832011)(16526019)(110136005)(41300700001)(70206006)(316002)(70586007)(426003)(336012)(83380400001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 08:24:24.9435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d74f496a-cd42-4ff4-4ade-08dbade98399
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475
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

Mini configuration is not design to boot anything that's why there is no
reason to setup boot command. CONFIG_DISTRO_DEFAULTS is disabled anyway.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_versal_mini_defconfig       | 2 --
 configs/xilinx_versal_mini_emmc0_defconfig | 2 --
 configs/xilinx_versal_mini_emmc1_defconfig | 2 --
 3 files changed, 6 deletions(-)

diff --git a/configs/xilinx_versal_mini_defconfig b/configs/xilinx_versal_mini_defconfig
index 53376db9df30..78be2002fb8a 100644
--- a/configs/xilinx_versal_mini_defconfig
+++ b/configs/xilinx_versal_mini_defconfig
@@ -21,8 +21,6 @@ CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
 # CONFIG_LEGACY_IMAGE_FORMAT is not set
 # CONFIG_AUTOBOOT is not set
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run distro_bootcmd"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_BOARD_EARLY_INIT_R=y
diff --git a/configs/xilinx_versal_mini_emmc0_defconfig b/configs/xilinx_versal_mini_emmc0_defconfig
index 31b3c02f7389..129ddce3ef06 100644
--- a/configs/xilinx_versal_mini_emmc0_defconfig
+++ b/configs/xilinx_versal_mini_emmc0_defconfig
@@ -17,8 +17,6 @@ CONFIG_SYS_LOAD_ADDR=0x8000000
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_AUTOBOOT is not set
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run distro_bootcmd"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_BOARD_EARLY_INIT_R=y
diff --git a/configs/xilinx_versal_mini_emmc1_defconfig b/configs/xilinx_versal_mini_emmc1_defconfig
index 5480cf1d9cc4..116ec450bda8 100644
--- a/configs/xilinx_versal_mini_emmc1_defconfig
+++ b/configs/xilinx_versal_mini_emmc1_defconfig
@@ -17,8 +17,6 @@ CONFIG_SYS_LOAD_ADDR=0x8000000
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_AUTOBOOT is not set
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run distro_bootcmd"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_BOARD_EARLY_INIT_R=y
-- 
2.36.1

