Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD270C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 03:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAB1587707;
	Wed, 17 Jan 2024 04:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BYSV3iA5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61DAF8786C; Wed, 17 Jan 2024 04:20:39 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B2C876D3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 04:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8272hbiAPznhx8t92RaETTgz9l2pTyefP1e7lThIGO3lt1w5jA5t8Xk0NVsAPJZnbFBDw2R6pbSxqzGTkpg/Dsqy8nGb/kw+fPYmAebMPoYPPh3fXR0tssOY7ZK+w3tUsmMzgFWY/GrO7ofjawrwOTkCLcd1+92XD0vrYMX91OQuyiAAjHuWqjpyMZQvNHGA8nHwnHP+WiW1GqR57K5/aTcSqbxMKO8buuZbvGlYbkTotbP8NrNFI029/YwSCPbVl3xDGxm1gclkE1fLHCi7zygi7QIfxa8uZy6hmcv9Z+6B9/DlZR3go2R1sW08Dx21dSP3y2mN+2n0Qh3l0v9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QKqfmvC1dgo6J9313x7TjlpLxCHC/SAl7Ai6Bvp/zU=;
 b=Y1h1G4ubEBXNe0Gtuq8MWABtHKjJUfVQXjl3AN5f5GqXtWCe+tGHKHz+SEbpRyMGG8cDIBNVSW9hgRC6Iw14loRTEpGlK6d20cJJj3SK9Wl2wrh5agWlBeAnI+PyUSQ9NyeiUOWC1ubnyPKxcjK2xwvERkzmWWONIdTwNuCil1lxmc2ZZFRv6dbO4YOE4oqCdcY3qdVEEL6XI/VoUUcUi+aKHO103Qqi6JPj81NymU8xPlrNEMWC0vu5uME7NxpwC6BXhhEAkR3kBw6Q+7uaspPAlzRy4+0PKxK+QRj/WPFPxAHbAviu6NbOuSd4ylnV6Gvn7f9j5v+xFVUmssB+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QKqfmvC1dgo6J9313x7TjlpLxCHC/SAl7Ai6Bvp/zU=;
 b=BYSV3iA5OwKshJ4LhjccSvFhxaO7+EwxJwUtFS3ekvmJrwgEtXE+KlwTD8z1E0PC6Ab6yyI1r4XV87Ee+gtct1/lk50J1nSEmyfZt//vbYmGetAP5wkTpvFMRCiHC7jwBorPQKdXoT5I1licSXrAnpn0fp5IP7YTFPNTFjT/pJ4=
Received: from CH0PR04CA0087.namprd04.prod.outlook.com (2603:10b6:610:74::32)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Wed, 17 Jan
 2024 03:20:33 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::6e) by CH0PR04CA0087.outlook.office365.com
 (2603:10b6:610:74::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 03:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 03:20:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 21:20:30 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 16 Jan 2024 21:20:29 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v3 2/2] configs: zynqmp_kria: Enable CONFIG_OF_BOARD_SETUP
Date: Wed, 17 Jan 2024 08:50:14 +0530
Message-ID: <20240117032014.1014084-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117032014.1014084-1-venkatesh.abbarapu@amd.com>
References: <20240117032014.1014084-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 33654012-6364-4d97-95fa-08dc170b42d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VWSrNklihg+8JQRpNM2nczR4GLWF/pwgj8Pmn5trg28clt6So8zYMDgaavaQygUl+6D10dh6ZYtl4uVJWRv9uOa+B6sAMTGSdYntTLVvpFnVxkNePtYJ/TcPu8sVwDbr+TMoDPwvJx6wAjTa2RD3bvFi/zqwhDnHwTgx4lb2fAQxCqupNpgt12q72Q/sFvLn/Vs1y1MxFqL0pIj/wp9tbU7DPeFlbNaMaQUOKdSGz7R+Cfromzoqcn3XxEnL5VWsE9pfVkFMZAw1og+Ib7J68ffh87+7W0mM+CjYh4+BX5aYwRwNnInyunjxMd3oiUGCVimZCKbYnOc67FVgixBAeAJyfIYE4jBkoaObPbusXTkzWOm95gZ32yaAUBk7UxclGtqthQ7qVQuWr7ecNpVk3+rRBRrDpRAQ2rOIZmAT+LQ6czYCqfUyHaeEfydMFCPuUHLWkmbTV6GLv47g65179KgbUDUiZYtV/RcFDnms1qfJ0aT4KINn9BadElpNwrO0Es2hQC5zjwG2v+XlF7cfVVTNjkh5VL5UP/CYZ+f3KGYNTa0ZwDcy0gt7aMfsXNF+tP1RFkeVUMGxSPszw3QpBx6IGoq+Npsk2ll4+zXOpCEgixBfT+1pVf7j7GhtPVlK05wPrp1MLAbdGVWkod8NF9Ox+EZmrcuIFSPhBSSk59FqxwimTMXf//CgvPw73bJjHILZZQ9pppQDH1wxTMv10poXFyDJ4uxZARgvCMAyFpoZDCeRS+isOXQzRf6O2CwMUPGb+5Zkp31x1dU2BhcsPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799012)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(426003)(41300700001)(70586007)(36756003)(81166007)(356005)(70206006)(86362001)(36860700001)(82740400003)(47076005)(26005)(336012)(1076003)(2616005)(107886003)(478600001)(8936002)(6916009)(6666004)(316002)(54906003)(2906002)(4744005)(4326008)(5660300002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 03:20:31.1563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33654012-6364-4d97-95fa-08dc170b42d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832
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

