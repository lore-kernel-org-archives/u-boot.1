Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACE4C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C335F80E0B;
	Mon, 24 Aug 2026 08:15:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xlMDPamYflbg; Mon, 24 Aug 2026 08:15:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787559354;
	bh=Vu7+0EybG9RwlUAQ6G3BZLJ5rI1XhwYuT10BChU22qY=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eqt0Ftyagmb3NaIw8VgdCEQWRgzkBSt0JNiHXpaaQHJLO7RvR4qXmEHJMCBhYGQV/
	 viqyXPnMZLilGHWEhdJ6u63uxYmYOHn+dH5Sy5l0fBwIYtxvoZxHMfxGyBKmG+9Qor
	 MseRVi1QS1IS82YpE2hrO1YdyVJKhra2jbuSwKZ5zUw9ixEEfyeKNmbBx4mLXMNLK1
	 3CmD8KAtsut68bFHUlMRJExmqYkth79b4ihAM00vjEV2A3PckP1sCXRjtnUfFY8AP2
	 +vnBzUyWSBqEEhtDdIEHGRIHV4aNx/sXWGabgMPtjookWnjjOhekyrSHa20Q1nkDF3
	 S3ab+eWo2E80Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4C2880DF8;
	Mon, 24 Aug 2026 08:15:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EF6F396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54B3360608
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:15:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QY6N-_FGkOdX for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:15:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=R2xGR9Aa
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EB25F605EB
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SynCJhnHPpYKEBiOXuSyi96tWyV2hOxgyz7HJv840PXUZ12xfxmjDQrpuMRPTlsEFBiXR6ZbYb/Dp9Ej8zbEqVr4D1wSZtIigNikxNaN5XiLlpD3/IdaCp0+5VBCsgj4DNGThqdHQpFdBb8JAsNVNC5T9REyBmVoESYgaGLizLzxmgiMg5fBromqDFKtpO3XAJ1E5boeRqxPTp30G4+1eQmurjGcbyeyn4zlgBGVhL9XJgt+pgZOC8OX76lr9APBPR5w9pteE8JG7SR9I8O2zEbTnls5ciaJMs9JHNT2pxcRVNd7qyTkOd8VVOO2Zs4bi98yuuLLHHoKYSfpkJw43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vu7+0EybG9RwlUAQ6G3BZLJ5rI1XhwYuT10BChU22qY=;
 b=c57+EgXPd3opOCko8BbOs2YbgMwxzLVL3XFQF+tl5pTJQY39R1Tt50l4wfFXjQnipT/Slf1GRKF/EIwN9wL0cC/hp7rvCBLK0slY7gQvHchuYUtZaIhn/y7il2V8oxBYxuv3v7aE3uzXCzxU4kOjWyJgAXO8eBg8Y6v+3z492pK4RqvzLaFP0Yqs3vqfbT/pOmtxF1piqcl4T9zMwEAVlbee4Z9N9vfmQdOdklUYE75KpiMysCSH98Pk8GdalSe5fObvAkRlC85010s853vk2O5CEov2wcZgk71iuOoG/coV6eRsU8RO3Onz0jHlkh7YM7Fo6MwJBC4BUA+DapJ6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu7+0EybG9RwlUAQ6G3BZLJ5rI1XhwYuT10BChU22qY=;
 b=R2xGR9AafW1fJmgPPBBTdnakiMBaE9xTFjoDw3cV/3bzVhTcV0t091sklau17In8+4btR1yH1pf1s44RqfGUlQyVUvcxFWHZrKf60UJgGlRXOwg5JcpvL43/sq3x6U8lvLQUcYx2rPainmZxNPTaoFpP+wwknZoPGYUqu8jGMIY=
Received: from BL1PR13CA0374.namprd13.prod.outlook.com (2603:10b6:208:2c0::19)
 by BL4PR12MB9508.namprd12.prod.outlook.com (2603:10b6:208:58e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 08:15:45 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::94) by BL1PR13CA0374.outlook.office365.com
 (2603:10b6:208:2c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Mon, 24
 Aug 2026 08:15:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 08:15:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 03:15:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 03:15:34 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 03:15:32 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH] configs: versal: Add amd_versal_premium_2 config fragment
Date: Mon, 24 Aug 2026 13:44:46 +0530
Message-ID: <72ffdb382f929e9d07e6ebf4e697ea473567b136.1787558907.git.pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|BL4PR12MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7cf5f3-3f07-4c52-54da-08df01b7e594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|13003099007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: XcRXquUIXaYhUDquF8OA5z6nyARiblrVuOqvwHYPVsiWNuhnJQhPMrwj5BGebPRgsarEJeUCKUi1goyeG6GgguWfVaVI0Fmp1twZv/1kVonx9+m2SWRusU+vT5XNX6zpjhsF6VcNaXOpUeY2de6l5qfAeZsUP2xRjHPu+36SKTzQcrDr+V/MJHCT3CAD+6ehFkcoCpkqabHhBWNWBh4r2SDSObLav0r/oX+KUVC6ateZWdd5YM1KTDbsrqMv9SHATibTFbdWpLtcnTJ8BXByzoP9UiI7CBqAocAsSU0Ct6w4RIXDiZQllyD/QFtgJRnFxbzmxY3Y6XOzUiqZ/i7iYHpzaMu9BSCamF+kCPDi6R0Q7iNnlixidsCOjpQEFimaLQ9Kw0x9sFE26Htt6P6Ywec/x2j02DVyQbanPwM052ynF8vDAAVVGX+N8FW6l4IhzAoMjGflDcEGej9R2G5oIwxbZhttoDcBRQoGxry2eT0Qh7foFHuz62JhnVW7zx+Klh2blbqre9PZtaagtTqRRZ6fH6IZnT4QMP1s+mmhnD8/nZCRAdt1+mQeAiExyuR5tYHQkiHFkXNMvhvpuWDQxLgbETxK5hwYXky4JCMduQWFGr6oGQ7YrVf+FZHGE4hmSjbagDLUwlAK5mTp3/xvGg1DvkGb0RouQQzQ66oxE1c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(13003099007)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W6kt0LWfdden4FfiO8Ykwv52yKLjbFLFlvbNmGWEIBTTw/rb6vBF6qZeRHxX8m+mgsponuBBOksOg1ZXzvD98yUHLChd5tfOS4jvcDcsr4yWGsPBrvmyFge/S+Dk/ZstKq2H/d92vYKRFKNeGaQyDPWJzNL5zIjru0PX1TpworqGFnbtLHxa2d2eeVjOq8qdMKcL0zJgeQt/z5lUuzg7XyXsK2rnHLFBf3UbQyXxvTnkRyyk4EgEN22/Oxau13QYiZOXZFFxKjUOaaKrTRAxnfaQCjdKAuQmJLiXs+jFoB+kvqFtBNoS2vcC5tK8ZZvH2ufCabf0YvqnRWCT5DvlbM4I/hncm/dpuovrQdKNcG2TDfXenLUbFEsQV8k8M7JT6mEiUazrkNGSNJd1ZdHJLsobRIvQIXpd5TsacHqKbyO2fdy+V8bV+4LJBk0hJQHw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 08:15:45.1826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7cf5f3-3f07-4c52-54da-08df01b7e594
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9508
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Introduce a Kconfig fragment for the AMD Versal Premium Gen 2 platform.
Premium Gen 2 uses a different memory map than the base Versal virt
config: CONFIG_TEXT_BASE is 0x40000000 instead of 0x8000000, and the
incoming device tree is placed at 0x1000000 via
CONFIG_XILINX_OF_BOARD_DTB_ADDR instead of the ARCH_VERSAL default of
0x1000.

Build with:

  make xilinx_versal_virt_defconfig amd_versal_premium_2.config

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 board/xilinx/versal/MAINTAINERS     | 1 +
 configs/amd_versal_premium_2.config | 3 +++
 2 files changed, 4 insertions(+)
 create mode 100644 configs/amd_versal_premium_2.config

diff --git a/board/xilinx/versal/MAINTAINERS b/board/xilinx/versal/MAINTAINERS
index 07173ee916f..9113249de8d 100644
--- a/board/xilinx/versal/MAINTAINERS
+++ b/board/xilinx/versal/MAINTAINERS
@@ -5,4 +5,5 @@ T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
 F:	arch/arm/dts/versal*
 F:	board/xilinx/versal/
 F:	include/configs/xilinx_versal*
+F:	configs/amd_versal_premium_2*
 F:	configs/xilinx_versal*
diff --git a/configs/amd_versal_premium_2.config b/configs/amd_versal_premium_2.config
new file mode 100644
index 00000000000..26c5cfa536c
--- /dev/null
+++ b/configs/amd_versal_premium_2.config
@@ -0,0 +1,3 @@
+CONFIG_SYS_PROMPT="versalpremium2> "
+CONFIG_TEXT_BASE=0x40000000
+CONFIG_XILINX_OF_BOARD_DTB_ADDR=0x1000000
-- 
2.43.7

