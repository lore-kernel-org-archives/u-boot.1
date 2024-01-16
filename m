Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63851C4706C
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 04:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20494876EF;
	Tue, 16 Jan 2024 05:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fL4jec9V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A4B7876EF; Tue, 16 Jan 2024 05:51:03 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F15870B4
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 05:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kvx82WESGSZ7S7oepxaC0nndm2DpLo6tAha7smshv+3ZObl732OO+tkE8HsEIt/NNzhX4yg4Lr6gxu2RLSMcVwqfUSrCc6K+3aSjWutEq+kVRqh+1VcYi7Av73Z/jn+vvbkE4ggTXdvoYDXMk/LRrhFBTmI8UnQ/2PtTK9LMkUpEbZr43ilJ1pBGKRL9Z16x75Wke6B0AkmvNiNYn3ebQP0/ElT0SBFRiphHkKj98py9wDKm2dETNpDzeF+9OZr1xtsClwLNZWtLy11r8Z5s9dJMXI7nb/9DyuMmZsY3MxYT5u3vmXHfg+QTEwjVe70jqF/j1qIZJpWxdbkbu2/QCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QKqfmvC1dgo6J9313x7TjlpLxCHC/SAl7Ai6Bvp/zU=;
 b=e2YcWuVHRvR2enw0VDUSp7kjFo94EF0gDwO7E2ONSLJ6RgquXs+LANjBD2nvkhBDXsgLpfuX4DNneGxtc+b1DQ3xf6KgUwlJgEVTbUWIbdyriJaYK5Yf2FtU6VfWNEQIH4cpUchIppfCqeDdt2xQnHPNHBzIQORGo5dALqQhUxe6vqwxG9PKQrUZq5I2dxFLCM7D+2yDWIzJZhbkK0479hSASxE2RI09GCet395w7KL+SSb5aVZJjRUKf3fU3qrRhDSWoga8ZuBPz/PBkNxzEwUu1b2h8PtcIyJ9rBb1ynm5thk5pDYB2CrqaKyEUTQBOWfHns0D3VeS+D9E0qwzkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QKqfmvC1dgo6J9313x7TjlpLxCHC/SAl7Ai6Bvp/zU=;
 b=fL4jec9VoFO2Y+cqCRjulr6hAsNkcBCEa8lK0oew7PzT79p53BrpsED0NcunkrkgBvr8psTMgQbaSIM9pY/qovnAEJXxq6T/nFRJslC7+Ql9o61TpO0oZsNDrhERH2/4cwFUx8P6AxG7bCsJ0SCDkRdmGBMFOCv7TCeSN5YGlGs=
Received: from DM5PR08CA0033.namprd08.prod.outlook.com (2603:10b6:4:60::22) by
 DM4PR12MB5166.namprd12.prod.outlook.com (2603:10b6:5:395::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.23; Tue, 16 Jan 2024 04:50:57 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::23) by DM5PR08CA0033.outlook.office365.com
 (2603:10b6:4:60::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28 via Frontend
 Transport; Tue, 16 Jan 2024 04:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 04:50:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 22:50:45 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 15 Jan 2024 22:50:44 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v2 2/2] configs: zynqmp_kria: Enable CONFIG_OF_BOARD_SETUP
Date: Tue, 16 Jan 2024 10:20:23 +0530
Message-ID: <20240116045023.580837-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116045023.580837-1-venkatesh.abbarapu@amd.com>
References: <20240116045023.580837-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|DM4PR12MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: 263d3447-54d7-47be-13d4-08dc164eba4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtHMl7Sy5v3INOJDmuXYuFAgI35HL8OqbChKVqxqXTBHJ7+MnaOo8GFmi2tPG8mGv69KGqQGjst2EavcVJqsJCoHoSFqpfCLZSKvnc2FCvos7h7L5g5x3tkQe6aG96j0MPFE+mMjbu8EWV347en7bYdQH82qkN2p3zXniCJRsFhq4Xv+6OF3HlCz5AcP8uTbaKTEAzPKncOJSVixlDYrgbUpR78ngXDdebmMUXxWWw4Z7aDWRMvItFwXC/c4xjihna+P6bRqim9ycxUzuYvoXRp5ZKfr6n2yG994zfVpjkv2VpVHWxplehzGzmSuyaaYQQUS9UJJ0jTqg/Gq9zWonjbS0XMvmtq5pSWz0+1MKp3CAWE0xTNbcgJbQub9ivVeaY5Lars/4LqN/wBAUO0FWOa3rhNFtAbWxz1uut73It0MSaD31KuZkZ8+YEFkdf9a27rnXBlooI23U4QWIImUjs2sdinNfAGMoHN2rj/tiuEIGdzgcxcBZtffcb66htjHwjjYaXa4mVa7XRYJNN7wypaH7Llfy+9txLusw3GCp4ej89p0cgFyqRApn1/+AM+ITyZ3YFXXZ0R/Yx/eYHvPGBh7VObYwfhJ4T+ld3hjVWcLx4dcqsUyz514e4qATTWLDkBWS5jU0UwI2fqU9gV4eLtmekMi/OfhBguD1Tz7MJNRhUA0cS72ItFT4RzgOsAdj4uagnKJVnX+vqtmgJ38HJC7R2SZexoquN4ce1dCHOUHYYGt9cAdHOKSpvXZPf/JJEXR3qOXXi4EEElODLhfEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(2906002)(54906003)(316002)(4744005)(6916009)(8936002)(4326008)(8676002)(5660300002)(6666004)(70586007)(70206006)(478600001)(41300700001)(82740400003)(356005)(81166007)(36860700001)(40480700001)(40460700003)(36756003)(86362001)(107886003)(47076005)(336012)(26005)(2616005)(426003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 04:50:56.7794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 263d3447-54d7-47be-13d4-08dc164eba4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5166
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

Enable CONFIG_OF_BOARD_SETUP, so we could use ft_board_setup()
to enable the kaslr-seed and pass to kernel.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_zynqmp_kria_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index a65a59c1ae..86741f1773 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -33,6 +33,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
 CONFIG_SYS_BOOTM_LEN=0x6400000
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_PBSIZE=2073
-- 
2.25.1

