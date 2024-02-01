Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E940CC47DDF
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 12:39:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 307BB8784B;
	Thu,  1 Feb 2024 13:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QZwZhZo1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1CBC877D7; Thu,  1 Feb 2024 13:39:19 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A50D58784B
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 13:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtC6+sWvcnz6rStn2xU9VdwlpnE5UsyXXf0Fb5s8PaVr+Ak5hyuR2kBC3Q0MKwRyXR6Oh5Wau0x2fMXMUcUTzY5PTVGfY2AJopIFdoiPFkO1eXHs0UWBdNuw+42hntpHuzZ32VdlMOFeVH4w0Wg0KLbQmk1xA1uXib7ia7OSWly/397/YtpMntxFu5rx+SObNFR/Asz3MtpifZh3RwMP2SLtgjrNd0wNgaLMaONCKvw9QYWn2qcJlvLggCVXEIARetI6jxtB4T2i8MbrRHOWo5aY4XGj9N5/VkwTHnwhxINLLBL7IEyuf01WitKzQ7e9MUfxG3gX1N8//VKls0KJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPm45CRw9PSDXL2xmsStmpVmZLlWAfwzuQRl9vJSo/8=;
 b=TOfJY7m3+bnFgLiBybY5pl1Emu+lCZSeV1LH9n26Gxs2b74pLmPUEVmTZZ4Sk/HEM3vif8RTz5Ym+n4E76JhFVZziPF7WoHGDPxHG2Id8w5E/R8IW2BX4y5W77/n790Y/2oaa8tVApSKW9/Xur7fZuf1o1c/5rEHJmpOQHPTxeF1exrl3EoH5EhSj8q2ECxdI8TBUNuHMzHk4ZU+qqKp8zZ2uYZ1PWwkQ0hziEHfbBq/jhcXw5eY2QHgMbRi2wCLoFo6eAkzjS4NdykmLfu/S0rD+PaDsTU72YPyQ856jI9Jcmj/kwwxPYPTFVS9WoYXZZe+p7zqPWaCzZ7FrBymVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPm45CRw9PSDXL2xmsStmpVmZLlWAfwzuQRl9vJSo/8=;
 b=QZwZhZo1YsgUAl0C85kAItIYFNmMO1CnYnS2xijomxqdUu7Do/pVZrTvnAWS0YaJqb8zgQRfLkfvSty8selqqTx4zJbQqtQSfIBhddpLDhohhmz/fEXFXaP+V5Ykoqqns1IDZsL2WFnABrVjgUEZdZF7m6/iHv8dDh9LlC8w7sE=
Received: from SA9PR11CA0007.namprd11.prod.outlook.com (2603:10b6:806:6e::12)
 by SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 12:39:04 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::bc) by SA9PR11CA0007.outlook.office365.com
 (2603:10b6:806:6e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 1 Feb 2024 12:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 12:39:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 06:39:03 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Harini Katakam <harini.katakam@amd.com>, Manikanta Guntupalli
 <manikanta.guntupalli@amd.com>, Neal Frager <neal.frager@amd.com>, "Radhey
 Shyam Pandey" <radhey.shyam.pandey@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/5] arm64: zynqmp: Disable DP on kd240
Date: Thu, 1 Feb 2024 13:38:44 +0100
Message-ID: <f6de217b3350c9d59032ef54800882e48f240398.1706791116.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <78e6e3f287f79917eb92c6c74accbaf955526aad.1706791116.git.michal.simek@amd.com>
References: <78e6e3f287f79917eb92c6c74accbaf955526aad.1706791116.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=672; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=t94dWa8zCteSvulV0kciQuafAARmvLv41Jxfs0OMa98=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTdEy5t1w72Mt7YdqGl69SxyECbFx2mJR9c/K00bipbb
 Lqz6qRhRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiIpTnDPNUpt1ezxRancC4W
 4Vv0WMm/Rsicn2F+0Loei1vpKxV9Zk4Ruid9y1b2gaA9AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SN7PR12MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f05e080-a4a7-47e6-8fed-08dc2322c686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZgmqAGhT6hmGvPtoaLrPQ8MzNZqcDXKTx3iTjFqMcKJARADeCZjYhpwlO3mffYfc+OlGxpuziLTioirc4QCPDPqpBA7KLLUwDM7dBJ4+aHNe3WgORxDNGtDWX4X1yv60IbFHh0nxj5KTiIQV6fOGm/zeP/Uw3TNJ6G41MEdy+bKi7N42lNpGCeX/nUb9KBgJgyjsrg1edQhY+ZBIRRdLsFb5uxz309rf3tGj8/psR4bh6+leBYcBgUJX95S5zvvGzH4WjA3Jznd4Df+IEUM2nyLFHPuB0pbB4PT2kPEYmUUO/Nml3Mtg6Dw4Y0Wucqw+4M0QukrVzmEE1w/jpDBHoi33ulG8X6dUt/dFs+o6q5XHCdV909WnAdu9zto2Gk4baUruOHaAu/+xbXXPeLuAD39IOp6zomxcMnQFj8hpOLAySScvc0nPCAq9Wkk0CcCLcWRj3gtvYs6pvcfzl1fWb7Za6iyf5NhuHo58VrwgxZhiOsZ04YuZcoOaUGLSv3EHr/6eXN6DVRC5+UUmsIgeUwmZrkEKLpL6L8zwKtZaGZbysdWfq1CCWCGWAdFBB7bkvi6Dtl04xazOzUUOfKnsKGV1tXqTkoyR8P8fFTtPnfRJE3nBtICXnN70SdIkKH+8zwzC6gwLQt5Ls408cw5/uJScnjPdYdeANC13bybjM2pBKURr7HUgOoYyqlkHFnwTRmaGwB/14FSOA540lmNhuDrTCcvFuqPWHDyBmHadJ09IW1wO3onYFTlhU+pfL72TyE6aGGbHuxBwAzr3+xRC3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(316002)(4326008)(54906003)(70586007)(110136005)(8936002)(70206006)(8676002)(36756003)(478600001)(86362001)(5660300002)(2906002)(41300700001)(4744005)(44832011)(40460700003)(336012)(83380400001)(40480700001)(47076005)(16526019)(26005)(2616005)(426003)(82740400003)(81166007)(356005)(36860700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 12:39:04.5866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f05e080-a4a7-47e6-8fed-08dc2322c686
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769
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

When SOM dt is combined with kd240 overlay DPSUB is enabled but kd240 has
no DP wired that's why change disable it via status property.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
index b3fc17cbd577..5202b7c48198 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
@@ -366,3 +366,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_default>;
 };
+
+&zynqmp_dpsub {
+	status = "disabled";
+};
-- 
2.36.1

