Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB1BC48BC4
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 11:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6189387E12;
	Wed, 14 Feb 2024 12:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pe3yswWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0052287C6D; Wed, 14 Feb 2024 12:52:52 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B025287C6D
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 12:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXDDFqphEQSemn7C5bhDVxeJU+Ni+FDgatwx2A/3n7D15K1rX8v26pk9jgq+lInfnkEzud0JC94tNeAXK219FDuxeexzalUeMJM8gJqg5jEX84Hqqp/crpdgQpB476DCzJqmqlW/Sa8SmgOv1DP9Os5Vu62rluEUO7Qop1qIX6ELoST3sozr/175d52JTvc5a+MjdO+5d2ArNR4wORq/k0HvxZFOtBPvvp7SHJZ4qOhtr1S9hydhevp/KbiNqFq/CZ+H8M56qBjC1yf4/Hkt8b8nR87aPo2J6qm59btf80y9yeXX4hlzMHlUhKtGFhIDgkISVAeZwoTbXoK1dMnbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sui9V7WXGLSS2x9FOHanN83PVLJFhZlQrOaRTfJ+DtQ=;
 b=gyLLQfd00E9sBD5abtpuyMPCNR8lKuOhXDBumW8J9GV/AE/3Fc3dhM/stYr3H1NjglHhUZwVqhf8YuBvwUyDavMqcHomkmV16TZqSEsndwAP50+KUXNIkqleB2qCnNxZ/9yRAaPhpZcVJ/WEE77kCOW8fnIrXqPFLIHKeak3FASPwtzF4RDrntJlQDFXmOm5AaBcWDCEEBokLWDYHCPBrTvOXtSXdfvTnFkObtPZVX9KWa6pw9W+ayQpy7H+ApUYmo51cW/Orru9mIyDHHPxGefnghkbWeWFYbMDjc8K/DliytflzlAoyVuPOCl3VGaTQ+A1v4OYXAU00wix0+DgVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sui9V7WXGLSS2x9FOHanN83PVLJFhZlQrOaRTfJ+DtQ=;
 b=pe3yswWwdO3HIXxkaxkmFL1YNRyVFzjifbpkFFaGAO6s9k8oJa7J5vBQJzE/L+njH/KNIn0Qn0fC1c+vRh4OgQ35VWNAwoglPGh5p0Ogel9AYaugznnvG6lbHeVCic31aA0K4PWX5ckpUnzoW0uwkkTkR0TuwTBUgq0xq6HULxU=
Received: from BN9PR03CA0666.namprd03.prod.outlook.com (2603:10b6:408:10e::11)
 by SJ0PR12MB5454.namprd12.prod.outlook.com (2603:10b6:a03:304::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 11:52:45 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::f8) by BN9PR03CA0666.outlook.office365.com
 (2603:10b6:408:10e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 11:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 11:52:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 05:52:43 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Leo Yu-Chi Liang <ycliang@andestech.com>, Padmarao Begari
 <padmarao.begari@microchip.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/5] riscv: mbv: Enable REMAKE_ELF by default
Date: Wed, 14 Feb 2024 12:52:30 +0100
Message-ID: <50bc5a360c37accd0eee1eecfd291b145a29acd0.1707911544.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1707911544.git.michal.simek@amd.com>
References: <cover.1707911544.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=YioY3rI4hRVEsC3DjF+TuyY5NjDnXsJ9X2T4wTims0c=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQzK+v++ESfWGcV/P/V8jfhG/leKZoG6Mx+Fvd1bsPv/
 zFft8wO7IhlYRBkYpAVU2SRtrlyZm/ljCnCFw/LwcxhZQIZwsDFKQATUZZjWNBkXN3MNLF9eoH8
 w5lLbLlKt1/QVGSYZ3bEYdZK/z8dER0XxTfcUzHMFjT8BQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SJ0PR12MB5454:EE_
X-MS-Office365-Filtering-Correlation-Id: bd943d9b-989d-4aeb-cced-08dc2d537544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4D9NpY4sF7GEWdlofof4AF8C8pX2k+8zVC0SWuPehp0vLpDrr8etMljtHvFKInuTW1Dr60VEj1smn89K/g7NFKqYgxdqRPEEuTtS0zehBpU0iP5pb3XwKYGR2Czv2Gdo2g1aNvlLV103QFtGgioLMm/rNOFC/8QdbqzN2wMEHXy2qzcsFzOGWHNyw3cjDGWHfAGPp4kyIibzVdMuhsVC7B8c+p7172ycS4fW+nFbE3tHdU4XupzBrHoPclFt05ryu84fFrmW0A+WCsNNxP6Oqzy9ghLCj1UINu6Kn0rH7KumTWcUrBFgHPmIKU9YAYJKhjpMtEW2VepSZNG9cOxlJStAUKUEJsCiLSwA9NBgNRLtnqZ9OoaDvGz2M8s4HvaKCin1JvsmnCyuEMAylNU8y0G0PyxN8YqgvbGiVJzWhppRbgRLYfC/0CvsoAzBaIewUbPJ8fY0EVhEpp/3rParSE+t/v/da2UyJuyJdDW7przFYZkcnOPC0WG6RvsMUYdYRkNB4+fHS2qjjSdsqNzMBdQ9zE0dCdrrZOvY7/q4o9aHAyuOwn7/CDUbRmVXszxdr106/xHrwbWmtWtbVBM2iQ3wmo4kcTb7Mv9KHmPEpL8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(44832011)(5660300002)(8936002)(4326008)(8676002)(70206006)(70586007)(2906002)(26005)(16526019)(336012)(426003)(82740400003)(81166007)(356005)(36756003)(86362001)(110136005)(54906003)(6666004)(316002)(2616005)(41300700001)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 11:52:45.2433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd943d9b-989d-4aeb-cced-08dc2d537544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5454
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

Create also u-boot.elf out of u-boot ELF. It is better to align it with
other Xilinx SOC where u-boot.elf also exists and tools like bootgen works
only with files with .elf extension.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig       | 1 +
 configs/xilinx_mbv32_smode_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 912355f42911..89fb3fbd2fbd 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -12,6 +12,7 @@ CONFIG_BOOT_SCRIPT_OFFSET=0x0
 CONFIG_SYS_LOAD_ADDR=0x20200000
 CONFIG_DEBUG_UART=y
 CONFIG_TARGET_XILINX_MBV=y
+CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_DISPLAY_CPUINFO=y
diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
index 3c911607a8d9..844afdecebf5 100644
--- a/configs/xilinx_mbv32_smode_defconfig
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -12,6 +12,7 @@ CONFIG_BOOT_SCRIPT_OFFSET=0x0
 CONFIG_SYS_LOAD_ADDR=0x20200000
 CONFIG_TARGET_XILINX_MBV=y
 CONFIG_RISCV_SMODE=y
+CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_DISPLAY_CPUINFO=y
-- 
2.36.1

