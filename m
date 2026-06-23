Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48628CD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 03:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C979849D1;
	Tue, 23 Jun 2026 05:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ytp4fDCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8006E849D2; Tue, 23 Jun 2026 05:54:58 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05154849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 05:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrcxilWDWvu05wexWQJOa5X2PbHTkqio+ySw8PiMckNmR8stnTFwiE27MHjiYciJdDfY28rGuwGp1PK6mKrMzpk4HdVmdIIL8XVL1uZoN1UsDSWqcp46gPXa/guaqBiPKhuZBRa7z/OUJWvFfJNDty2mE55oZUsPrjV31IC5WUhyN5lJMnvUE67MdsKkJzugBQWLdPupAEnpsPC3bZSvERfnYOg/XGHDlVSMt0QWYB+wv0LoWkjwSkXaZ2QLLl/TDixopyjnWl28L4u7tf+7+Ld6gvdXd5Bmih+jhjh1j0LxRpWFkN1QRtpezdPRIEvO3ffGhx2ltTlhl94YXaRulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBTo/iz+6vAAlDMd+Tp0KC/0wQhsXliTXUOaLhKFLlM=;
 b=hN6iEbmNkhCRvPtT/bAsCiz008t076W1L1bGHOU6XPZDd9aT1OpN2hnjRNUfXQgZuV2gC626x5as/heFRV+xHTkZPzEpqKbMcTja0JGi66QNY5fCUwZ6Y7r8o+ttTAabNImDvycXw4+ARbEsHZWrRtcR1Q1caTH7C6RfFCZZ1+a/05Y2/NmY/9W5HeinmV5ENiiXqV9u95XFgcnqKNRIQ1hNmEZxYvyV6Z/wKkxVxIxlFwKXXrX1/8cSNaS0Ch5WOhzb6Vl0KRLDZWvjGTYb9tI9odDpK/PuDO0pd0riZ3+nmH8pZThXlgYfv4vDIhUsLyTlusyiO4VzKzuV6d5nxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBTo/iz+6vAAlDMd+Tp0KC/0wQhsXliTXUOaLhKFLlM=;
 b=Ytp4fDCriYEtzM1Lt5jEQE8ndD65TIK349W4OgDM+YPHYe5bFAlvOEwQyaCnf8+Xlx7+qA0IPPKEJwfUQLbo4YV0YwDb9zzrH1/8MOTuRgfnXP4/CbXiQ5QCNtEluYCRhdZRfkLUldfXkYr9Kcsg0t0ZoJNPmh9UKw4V2qTbPcM=
Received: from BN0PR04CA0046.namprd04.prod.outlook.com (2603:10b6:408:e8::21)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 03:54:51 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::4d) by BN0PR04CA0046.outlook.office365.com
 (2603:10b6:408:e8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 03:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 03:54:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 22:54:50 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 22 Jun 2026 22:54:47 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, <akshay.belsare@amd.com>,
 "Pranav Tilak" <pranav.vinaytilak@amd.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>, "Neha
 Malcom Francis" <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] ufs: amd-versal2: Fix missing .priv_auto in driver
 registration
Date: Tue, 23 Jun 2026 09:23:51 +0530
Message-ID: <20260623035411.2088224-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 3444bf50-5127-46d8-9fbd-08ded0db2d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: U9ArmegMG1yUTAiXOIU78rJw4nwDidVG8PFhefiRESfpGyOCBdIlgjiOQsUqMNdgy3PgyEDoAFtpi/FktwvXhueN4PaOKl3OFp5Q+7zn7YXpL59wBOsjDBlskLtj0K1KlmZHcTnXx7DkAEYKI1QfNwgonFFbsGXF1sFLMm6kWrNXbqOKW2WGnbnH9KYT43rafiiLleVNiM7yBiTZfU3TRkUbcT4ZWL6rFBWCrCNk7uAyH/iCb37Z/7p6ICSEmg3dnwVQlvVhOLliKC/97BS6FrKz2eoMYXAt9UyjT4yedhlWb5oiDopqDtSN6ZcpfQnWNVHS/UHEfX6OAS+cA6Nwbs8yIChskL5Fm1EsrIW9Ed9Af2C2+sUiayMyb59/SMAOUATbNG5pvuYASExUL0RlLAI5l61VSVoWqKWj52Bs3vz3a4q0XOFV8IGEkwlWmvIuyaKg6GsuqfwLZD6pxqjXbcgUPGN4HcUgQOUB0DqvggRyXH83rw/JeFihKpDkiz3LC0+5KsGWWzfjLfL6tWNemJIfWHSF5C+gCGQ9FZCcBHdWbH+znDHlocO0xv82+/oaxe/A+0bBZPS4RIlaKKK/JjLVswQ4vj4G5hem7UZp+5fb7kr76sKyFYnNcrmL/Q+UDN+kbD3o+5MeqGCqCq/4bvtEQRBMjJzFWb8zbLzLHc18GiWafi8s88IQFQFcQ1r32LGRPip+9eaVM/5B5DnW4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d9Bk7/yGqGwbib8/vlR3t/1vVtE+UOmQSxTnsYBQbInUPvFTqDYr+08EymaKpUlw4SEubNBjzG+tldLyaiUD/Ap1CxNPmBMykpfgHTgAfwqu6IBFC+8ZVf5XZUURKJW0vbjXDf1Pd/kQZNdYUuSBdypPhKYfppmoWrcFGr+H6a+Z8LTTkID+Ygdc6iL/t/Qa5NmBnoXLyPtsb0cI2an8gIKzT4ojvPO3xDimFeQWwJT6qEGERaFPgxozGlJENi+ZN/ows5eH7kPhrLr4sLw+h6SiQWbXljAFWKqOOzM3lFFSNzPniPuSnImUXAR9cTUcGLSPVzRzXuQCihAqBLYBe4UEQPiW6DCEP2ioPBw6rUe0YccWVazKGLpvKBXwyupTzBYNYMJ5OCnP9eINuRhco+2tDu7F80V5Fte3HHRupfrQ9BaLDJc82SbFKddiUlVo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:54:51.0804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3444bf50-5127-46d8-9fbd-08ded0db2d65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
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

Add missing .priv_auto field to the driver. Without it,
struct ufs_versal2_priv is never properly allocated and dev_get_priv()
returns NULL, leading to DDR corruption at low DDR addresses.

Fixes: b5ac5f030720 ("ufs: ufs-amd-versal2: Add support for AMD UFS controller")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 drivers/ufs/ufs-amd-versal2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
index 6c949b2ca76..3369d32d924 100644
--- a/drivers/ufs/ufs-amd-versal2.c
+++ b/drivers/ufs/ufs-amd-versal2.c
@@ -563,4 +563,5 @@ U_BOOT_DRIVER(ufs_versal2_pltfm) = {
 	.id		= UCLASS_UFS,
 	.of_match	= ufs_versal2_ids,
 	.probe		= ufs_versal2_probe,
+	.priv_auto	= sizeof(struct ufs_versal2_priv),
 };
-- 
2.34.1

