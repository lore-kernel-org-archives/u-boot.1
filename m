Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5394C48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 11:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE04487DFC;
	Wed, 14 Feb 2024 12:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RkyIxLJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC70687E19; Wed, 14 Feb 2024 12:53:00 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8383C87E02
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 12:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B22+RVnJstoEEOclYPOh/TyAn4mGhnY2b0ZbdqoUfp6KrYXCx0FDWx23r3+bcE/ZRnqEpNl+qgxModOhWcSamKdxz4NraWltGVGX4lKubgf1LzyURrusHZ7YsTRlwIGYvFPYoVa/7CttLSkTZbxNitkyLB9/EDv/HwIobcGGk5wD0/eoCN+3qVgnNpBtlj3ZvAgFT6iMhM569PCWQ3pVFMzz9ppEEOgKjtRNHFiJmDOv1IQob0l81adaQvuFXtguKCQ+zLdNKkbHPtm1kA43IElUFLcicO26UkfZlslrQXWPFnpc2AgifjOB3DZpkESAmQWsc5KorWSLFNuy81SIXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UmlvLNNDjGaGH5zVzseFmj/gxE/2fQ61IxTCrRMQKE=;
 b=VDYuAuvzydK5x7MT1eMKU1Vr5+JOFwT/zpXAWOFZlhtAPQqDUXOWpyMoCbR3MbV83anVPOQRiUzPFf7HYeR5B8xXlvCYuSa/QJe0t83/Wn0ybjSpw8U4AbLDoT/tBHDlCvWrVdDy6ETAADH/FYmnYdNCZv+zVAoyCeeRIcvoFhpOSWDn2mnHkC4GyWj2oMFmL6EzMfpzg6RFnLMm5p2eso+FieyXAzhh3L41/H+2SlsSjboLy+HtZNvLc7eYc9JEjyccFChhdzATph36MYVV63lFP1dpMZPQMyDPIiRve/RPAOU7qAx6q/r6ZG+gvtzoO1q6Uag7JMRUyl5SzavuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UmlvLNNDjGaGH5zVzseFmj/gxE/2fQ61IxTCrRMQKE=;
 b=RkyIxLJuU9/GedCwMEJNJNkHEuRPwXAzr3q/+FceJ0KKKs6C0IiCTG0mSQRGPkuiYoSai/xGFrS5/KCi0c80hNNrkV0sQooTnPZD5tafyiqwJyOjsJmakl52WdVrggM0tyox9iFBR2J8CvIkjpr6qSkjuCim1rcMTQnjkaKUZYY=
Received: from BN9PR03CA0651.namprd03.prod.outlook.com (2603:10b6:408:13b::26)
 by MW3PR12MB4556.namprd12.prod.outlook.com (2603:10b6:303:52::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 11:52:53 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::cd) by BN9PR03CA0651.outlook.office365.com
 (2603:10b6:408:13b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 11:52:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 11:52:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 05:52:51 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] riscv: mbv: Moving little_endian variable to data section
Date: Wed, 14 Feb 2024 12:52:32 +0100
Message-ID: <934dc8871c59265eb9d8012193aa97d9b8bd7f33.1707911544.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1707911544.git.michal.simek@amd.com>
References: <cover.1707911544.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=878; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ZIzxCKlt+zTIkoDB2NceJavRIIkamXSgFjffhAOlq4g=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQzK+vVNaWPdJ5i0Vt898j0JmFD5ogXDi9Waz14vL4tq
 Vf62u1bHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiW74zLGhtmfNLn+fIvDmr
 Z9TfTu07Kutu+I5hfnno6m4G90lJynGVEj/6N5uybvfJAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|MW3PR12MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ebbb7e-d818-427f-c6bd-08dc2d5379f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c//yGnRdLaaolkJ6EcVrllIVhNFAldUydSKHgvUjHxEixKahQ11sCuS5FS6vTwuhu7TlgEBSleLGEm6vKGo1b+OFm5igRmruPAXVEFf0MhzY9z3Po2Biiua29a5I6O2kPeVBAlu/KQ232XK8J1RDA3y5ZV9G3qODAS4rqWxTHDaJlyyP0915hrOmR/zLjwtFc6BwVGw5EK4NpHSGFLmv1/Cala2dLvrKLH8RfIM8PwOgGX6H1ps8diNAslbATcoEf39FXD4FNz7QQCEF5aSIIQHHQSvowPF3EZ03CK1I1t5H8jHMqAoFMXbSpPHH3CiC5ktzuqQlp73C3rRI+5ypp2IYb6heg4e2F3DEpzClPgO/K30o16xr8EFzD7TbBzQB6nkmjPfllmbwXlb7z9U488shl3/x6Cm2hLVaqfHazyslkJctVqxGP1bOHGjoF/BJXlEg8M3sKbxR0YcEWLuHfQIkVo5d7+ajLVQTd3EM45oYXLLjMygtys9npADKkCw6K4ABA/w50hgvim1uoq5vSBocrJkiegRAhglNPrkvJsuoFsbikhdKClbhq2ISF3lwpY7JK0znlOZ1msQS2WBqQMUzzsexPHs93b3HaNZAuuc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(86362001)(5660300002)(8676002)(70206006)(4744005)(4326008)(26005)(2906002)(44832011)(478600001)(83380400001)(356005)(82740400003)(16526019)(41300700001)(2616005)(81166007)(336012)(426003)(70586007)(8936002)(110136005)(6666004)(316002)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 11:52:53.1247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ebbb7e-d818-427f-c6bd-08dc2d5379f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4556
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

SPL is cleaning bss after calling board_init_f. Setting up console is done
and little_endian global variable is cleared which caused that console
stops to work. That's why move it to data seciton now. The patch should be
reverted when bss is cleared before board_init_f is called.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/serial/serial_xuartlite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/serial_xuartlite.c b/drivers/serial/serial_xuartlite.c
index b6197da97cc1..35df413321fe 100644
--- a/drivers/serial/serial_xuartlite.c
+++ b/drivers/serial/serial_xuartlite.c
@@ -23,7 +23,7 @@
 #define ULITE_CONTROL_RST_TX	0x01
 #define ULITE_CONTROL_RST_RX	0x02
 
-static bool little_endian;
+static bool little_endian __section(".data");
 
 struct uartlite {
 	unsigned int rx_fifo;
-- 
2.36.1

