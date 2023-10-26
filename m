Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62781C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 421C687A49;
	Thu, 26 Oct 2023 16:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1ZCkWeXB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4390787B4A; Thu, 26 Oct 2023 16:05:03 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FF8C86FB0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:05:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZq4hSd82seLSfIZr1dhIrX4auc6C4sdQQvM5hnqp9DsmWSFXI/Rv/AUUMNryjjdvK7w5KrfNrBlpzyZ6RDHxvNZB0Tt8wntIvLC1uZDBfDPUny+fpjkFI4OmJdDSdy0F3i/5Dm7aD5DledZpPJk4X0WxxlArwCYT3MK/mwyQZGdaSQXKiZKQwFG80kDvP9AaQAAfuwlqbiurZsqyW/PAtJPkBJpyiFD2jtYAVWfcrL+11LeYWfMbp4PIYAa7uUCB0OHTXPDq072xuUMhOHERb8ussNhxankqXsWC2EIkeP39+vOwjP+m4q8R9C1ffex9BEVMvEvVIi7KzPhdS68Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJwU/lwC3jTGYbXSZwOzSI1S647EmVbS46nllgr11E8=;
 b=Ht3Jvm8yeFXVtuu40pgiNq9/j/fpZXmTUod4UEyVv+LIvP2pC+kBVj51HwMXFXDSKKNaanmNZPXhv9YIB3VJYFxzbqInHHd1FEM4F4lSCDUXKbfX5Y61X4GW8oOqYRGCUHz2+fLQPLh9KTl86ffJVRT8gC9y2+intyZacWjKDdtklA24Ldpng7SddSFmBMW9y6YVuxwPBxLwUDfnU5ipzAQiU0z706bdkNwI81AEk9SOThgCJVA3M5Dhs0LKehPNUwaNbfcQFfaTMbXsAPAQAeLqsnv+WVKdHqCwUOOd8s5Xz0MEHrvazUh5RwdTFY2gwSuyUR+FVxSEl9ZRlX3KMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJwU/lwC3jTGYbXSZwOzSI1S647EmVbS46nllgr11E8=;
 b=1ZCkWeXBwovSC7X2EavhKzCkAq0fBWyM1IXCbLxaxb1s9WzEklGz0pEUNvwujzNL8JVmtTJyOZEdX12L3g6+2UNDQWuErHD3T35P04+fyP0RreMFcFmFI4JY1zSnMiBdb7SWZVjXhhBLa3L3+pcQIwbYZDd1NKF78yqtbKw+xmE=
Received: from MN2PR14CA0018.namprd14.prod.outlook.com (2603:10b6:208:23e::23)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 14:04:56 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::9d) by MN2PR14CA0018.outlook.office365.com
 (2603:10b6:208:23e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Thu, 26 Oct 2023 14:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:04:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:04:53 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 0/4] xilinx: Add DTSes for mini qspi/ospi configuration
Date: Thu, 26 Oct 2023 16:04:48 +0200
Message-ID: <cover.1698329087.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4687; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=GuwEjDZAvu/XzKCWmxwtSVV6IIJLLBCiaesMYAMrHvg=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlSrIoaZZ/Y+f682PZ39PyvL1M2ezga2ge1WajYFHD+6D
 zyV3+DQEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACZSbMUwP22dlfyuz4Yxc5Ls
 P8lrVSb9EYo4ybCgscowS/PoagbTQ5efXhKXWmc/jdEGAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae21756-1755-4035-177e-08dbd62c87f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6/N04XhVDySAepi8tUpgwzW28PAJdhX5qzNkHbUOJPAPRdXiFpVwwHh12QS0nd9Z8vEkU4MCxoPkq1ht7idgnM6zbukTVECgImK2f40JjJM1rB1VEBRxEBdPy2o4dR8A2J+NWH6spVk53hG43QTUEacZvlB15fco1bnMaotMrsrgwJOztblU3/H+JgKN/0sqSdbRthosG9K3aFTdUETSPlSeNICxw1ZrG3w9DLFwt4pXW2xRcGaI0lUVVsQ9c+JreLBnyvIh1Kkawb7fbGARJcACieznJnLjf/iwsGN36skig73W0lwQwWYwV36jNKowmpEcm7ephxCb7+rMGKwHbS5DKb82YGHXLub15upH67dY7TDI0x1xNFRVz+wJ5sni08Ra+bKEG7bmz1i88y/dGAO2jJsEgR6MjfYt8pZQKNuTStcqkN3DuA2hsthsdQ+1O73N3pUPCbF71/YR9Ocacb2hFUb5JSRC8mbJOkEs4gbDZQYP+QPsdLkI6QpWGpODdUP58YjL4Mhr2zab9U7v/Cqb49O4pCJEMmpytIisoiypWzouKt4XJ3kSBiE/sb2KeM4rG0p5dq3jSUSgn9V0a2IqY+03vMs6W2LvNIjepP8TDQ7LCSrMHT2txvATdW/bfvbCfMnotRtTrbK5diqwgbW11kwy9J6scBw9bYFlhZP/N9qVe0tZMHiv/HEyUchuX8kHVuTg0j2km+TN4Rw9+WRfAO4Kpj7PzsJQtfuuqadbrtg+xLL+cmqTdY+pMTj0oxNfkhOaS7bEhn1ZO7+dC0T8/lXkzK1YZRcoGQoEDHU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(451199024)(1800799009)(64100799003)(186009)(40470700004)(36840700001)(46966006)(41300700001)(8936002)(8676002)(40460700003)(2906002)(44832011)(40480700001)(5660300002)(47076005)(6666004)(16526019)(426003)(336012)(36756003)(356005)(86362001)(82740400003)(81166007)(2616005)(26005)(966005)(316002)(478600001)(36860700001)(70206006)(70586007)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:04:55.0323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae21756-1755-4035-177e-08dbd62c87f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870
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

Hi,

we are using U-Boot mini configurations for years. We already upstream
configurations for mtest, single qspi/ospi or emmcs for all Xilinx SOCs.
But we didn't push configuration for different qspi/ospi configurations
which were missing upstream dt description. This has changed some time ago
by:
https://lore.kernel.org/all/20220126112608.955728-3-miquel.raynal@bootlin.com/

and we are also pushing support for it in core here:
https://lore.kernel.org/all/20231020031817.267959-1-venkatesh.abbarapu@amd.com/

that's why it is good time to also upstream description for these
configurations. Functionality depends on core changes but description
itself is independent of it.

Thanks,
Michal


Michal Simek (4):
  ARM: zynq: Add DTSes for mini qspi configurations
  ARM: zynq: Add DTSes for mini qspi configurations
  arm64: versal: Add DTSes for mini qspi/ospi configuration
  arm64: versal-net: Add DTSes for mini qspi/ospi configuration

 arch/arm/dts/Makefile                         | 27 +++++++++++++++++++
 arch/arm/dts/versal-mini-ospi-stacked.dts     | 22 +++++++++++++++
 arch/arm/dts/versal-mini-qspi-parallel.dts    | 22 +++++++++++++++
 arch/arm/dts/versal-mini-qspi-stacked.dts     | 22 +++++++++++++++
 arch/arm/dts/versal-mini-qspi-x1-single.dts   | 17 ++++++++++++
 arch/arm/dts/versal-mini-qspi-x1-stacked.dts  | 23 ++++++++++++++++
 arch/arm/dts/versal-mini-qspi-x2-single.dts   | 17 ++++++++++++
 arch/arm/dts/versal-mini-qspi-x2-stacked.dts  | 23 ++++++++++++++++
 arch/arm/dts/versal-net-mini-ospi-stacked.dts | 22 +++++++++++++++
 .../arm/dts/versal-net-mini-qspi-parallel.dts | 22 +++++++++++++++
 arch/arm/dts/versal-net-mini-qspi-stacked.dts | 22 +++++++++++++++
 .../dts/versal-net-mini-qspi-x1-single.dts    | 17 ++++++++++++
 .../dts/versal-net-mini-qspi-x1-stacked.dts   | 23 ++++++++++++++++
 .../dts/versal-net-mini-qspi-x2-single.dts    | 17 ++++++++++++
 .../dts/versal-net-mini-qspi-x2-stacked.dts   | 23 ++++++++++++++++
 arch/arm/dts/zynq-cse-qspi-parallel.dts       | 22 +++++++++++++++
 arch/arm/dts/zynq-cse-qspi-stacked.dts        | 22 +++++++++++++++
 arch/arm/dts/zynq-cse-qspi-x1-single.dts      | 16 +++++++++++
 arch/arm/dts/zynq-cse-qspi-x1-stacked.dts     | 22 +++++++++++++++
 arch/arm/dts/zynq-cse-qspi-x2-single.dts      | 16 +++++++++++
 arch/arm/dts/zynq-cse-qspi-x2-stacked.dts     | 22 +++++++++++++++
 arch/arm/dts/zynqmp-mini-qspi-parallel.dts    | 21 +++++++++++++++
 arch/arm/dts/zynqmp-mini-qspi-single.dts      | 12 +++++++++
 arch/arm/dts/zynqmp-mini-qspi-stacked.dts     | 21 +++++++++++++++
 arch/arm/dts/zynqmp-mini-qspi-x1-single.dts   | 17 ++++++++++++
 arch/arm/dts/zynqmp-mini-qspi-x1-stacked.dts  | 23 ++++++++++++++++
 arch/arm/dts/zynqmp-mini-qspi-x2-single.dts   | 17 ++++++++++++
 arch/arm/dts/zynqmp-mini-qspi-x2-stacked.dts  | 23 ++++++++++++++++
 28 files changed, 573 insertions(+)
 create mode 100644 arch/arm/dts/versal-mini-ospi-stacked.dts
 create mode 100644 arch/arm/dts/versal-mini-qspi-parallel.dts
 create mode 100644 arch/arm/dts/versal-mini-qspi-stacked.dts
 create mode 100644 arch/arm/dts/versal-mini-qspi-x1-single.dts
 create mode 100644 arch/arm/dts/versal-mini-qspi-x1-stacked.dts
 create mode 100644 arch/arm/dts/versal-mini-qspi-x2-single.dts
 create mode 100644 arch/arm/dts/versal-mini-qspi-x2-stacked.dts
 create mode 100644 arch/arm/dts/versal-net-mini-ospi-stacked.dts
 create mode 100644 arch/arm/dts/versal-net-mini-qspi-parallel.dts
 create mode 100644 arch/arm/dts/versal-net-mini-qspi-stacked.dts
 create mode 100644 arch/arm/dts/versal-net-mini-qspi-x1-single.dts
 create mode 100644 arch/arm/dts/versal-net-mini-qspi-x1-stacked.dts
 create mode 100644 arch/arm/dts/versal-net-mini-qspi-x2-single.dts
 create mode 100644 arch/arm/dts/versal-net-mini-qspi-x2-stacked.dts
 create mode 100644 arch/arm/dts/zynq-cse-qspi-parallel.dts
 create mode 100644 arch/arm/dts/zynq-cse-qspi-stacked.dts
 create mode 100644 arch/arm/dts/zynq-cse-qspi-x1-single.dts
 create mode 100644 arch/arm/dts/zynq-cse-qspi-x1-stacked.dts
 create mode 100644 arch/arm/dts/zynq-cse-qspi-x2-single.dts
 create mode 100644 arch/arm/dts/zynq-cse-qspi-x2-stacked.dts
 create mode 100644 arch/arm/dts/zynqmp-mini-qspi-parallel.dts
 create mode 100644 arch/arm/dts/zynqmp-mini-qspi-single.dts
 create mode 100644 arch/arm/dts/zynqmp-mini-qspi-stacked.dts
 create mode 100644 arch/arm/dts/zynqmp-mini-qspi-x1-single.dts
 create mode 100644 arch/arm/dts/zynqmp-mini-qspi-x1-stacked.dts
 create mode 100644 arch/arm/dts/zynqmp-mini-qspi-x2-single.dts
 create mode 100644 arch/arm/dts/zynqmp-mini-qspi-x2-stacked.dts

-- 
2.36.1

