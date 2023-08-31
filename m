Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65EEC83F32
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 12:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AD948658D;
	Thu, 31 Aug 2023 14:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wSs2+TNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F49805C1; Thu, 31 Aug 2023 05:17:24 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30C0686561
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dtwro7756RAq62ec6o78kZf3CfgAAesXEnd8KW4l53T6UM0Tn6E9CVP28yfLtddsRpLxTf2520HPetyAMdtPRZuPfZxM9dG0IOpJMaD3JeC5Cr//05lHoZZrxU1mlZbI6VJ/UynPVdwZ5+lV0Ay93xN6GcRlBK0jx0hwxsm8bv+6HjK/UY5U5PZm93bN+C/Akt+adW7C5Tk+c8KCXPPa2xfN/27zG69y6oh0xz3Qf00Gnx3NyjAIZzU0Z1x7F4R5yjav0nZR4Vxf4oSfxHqEJBItfWM92xi7NyatKeIVP8vWOQ6e/TpkMIJEM0Qpy+zuNG49YSA6bNYLMt+aMtUDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PF4dmS3eyNDPrc/Fkd5IxOumCzmOt7kDf/1C+uKdHA=;
 b=QuCU3eSAx7TJ2DKUAacxdA3WyAqu8PxljKzLI933k4Slbn/WZySwn0mxM33YtPV8vyZ5wC0ZKWUqnHzhMX8i5HBbsKcgsuOxmDzqOFcDBBQmtWWhir6dCSmP3AZt25abwqOLQanLm0eE88XqpREWX3P7fpSQZ105Pxmio29jY5bX8/f+LUfnHzSZsHJbKMG/eKB6nud1vgJCU7G9bUIp8IQRh3MRGKKOEfRGocTS035Nr1o/CAACds5HP8CuILGGbWWj9KvugIf+9vB/llCLIDyghFye31ez2e9xZ9OiuCw95dI99TiaBMUWT3IgP4y8BXDrqE9EP7XRGtzVzVgSvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PF4dmS3eyNDPrc/Fkd5IxOumCzmOt7kDf/1C+uKdHA=;
 b=wSs2+TNBQ1aQAbChIczarj25pvCHbIagnG1hRdnPUBXS/szlBq3fxwCKs1W0UwcRgSUxg7Wo60dCXRRLba5UMZXSQrD2eibEpqnOpPmMrgkTgVUiLbxDv4Sx+gWCQgKqpk9psBwRQku5UHUmv2mQLTRXd4mKeMfNtyG03SvJ/DU=
Received: from DS7PR03CA0194.namprd03.prod.outlook.com (2603:10b6:5:3b6::19)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 03:17:14 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::3d) by DS7PR03CA0194.outlook.office365.com
 (2603:10b6:5:3b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21 via Frontend
 Transport; Thu, 31 Aug 2023 03:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 03:17:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 22:17:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 22:17:11 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 30 Aug 2023 22:17:10 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH 0/3] arm64: versal-net: Enable CMD_KASLR and TPM
Date: Thu, 31 Aug 2023 08:46:55 +0530
Message-ID: <20230831031658.2203-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 3665edc1-cf42-46ab-0436-08dba9d0c58c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QP+pZZQQ9vKQSfvcc+3NgMAO4LtlPOOaDufloz1VJFqQcadpUXW0KilS/Yi0g7LK920Nuv7rtwsO008K8htB7Ahqn9tiOQl9SIv5JF8woHJTlVI5fPaWo2GvIPaV7oTVXFDA0Pz5NZPflakkXmgYv2m0D7mP9dMIy16pJgsWa/owhsU2sW6O51H/3EjGje3/aJf50nlpdLsds/WyH0hsoVRp6aEam5/E7Goll4FMm1+zWGD5J1/4DE6qWtSLHpVAqU746xIdFsnUOeWQvWSX6XNmgxp9Y8DZZo7UDSHZcHsfPSzxkOn1oxs2SKti20jvuUF4W38GH3xjl4sCmsemyQ8yvCNnFJDF4Teyi3qIVl3/GPd00jdMrChQa4OhLSgP9R2YAL64L7Y41/PlW+TA/Xg7/SCwbyvyCN7qNEy4QCyBa7zonKu347ZwkKDmYFb78IJru86Ewccyw0hUWHjTiKhH/APaAEFSww/ZpNB+CkE4Z10TlR3ZDSTGRWK2qHaVsdpMP9vB5xYlAtZxn6+Z/CPlYhOKBg6fhjV9CfRDzRX+9HF7S2d7PctlWSPbU20mC0nqERBvYD+0Xqz2ny+0si6t+4STMJockA6MUdM8JjXA1mV0HyD4G9zj6PONmsEOlW3QFXoo8LsAm27Tn94ZUWub96srghryAt6g73UBwCkmkMEQm97PlXoMC3rDgZG0fsnpMaP1vejiIQOGvkpO1lvBS7CGv/wyxPjL5m30S6m8Az2hnhlf9Rvm0hPYuGptSZjxKeHRE5nJj/gy7qV6hCp6scteB4ie1hYMF/RCHcNO99VNR10JN7iEAnR0NtXj7OrPRphDp0x1MsFn0TVYAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(6666004)(478600001)(83380400001)(1076003)(107886003)(2616005)(4744005)(336012)(426003)(26005)(2906002)(41300700001)(54906003)(6916009)(316002)(70206006)(70586007)(5660300002)(4326008)(8676002)(8936002)(36756003)(40460700003)(40480700001)(47076005)(36860700001)(86362001)(81166007)(356005)(82740400003)(36900700001)(473944003)(414714003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 03:17:13.4542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3665edc1-cf42-46ab-0436-08dba9d0c58c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705
X-Mailman-Approved-At: Thu, 31 Aug 2023 14:38:51 +0200
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

Enable the command kaslrseed and tpm.

Venkatesh Yadav Abbarapu (3):
  arm64: versal-net: Enable TPM for xilinx platforms
  arm64: versal-net: Enable sha1sum command
  arm64: versal-net: Enable the config CMD_KASLRSEED

 configs/xilinx_versal_net_virt_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.17.1

