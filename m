Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0000CE7AF8
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 03:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE04186DD5;
	Thu, 28 Sep 2023 05:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b/o+Cj6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DEC286D09; Thu, 28 Sep 2023 05:50:01 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4070D86A24
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 05:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFUniH9bqyawmLiU8NNuiDYj32Nr6V/6EtZpjqnEXD4ZbpSz11fd5XsQaPHzgCpVJOyofEMbrVQowfiLsyODcAG62qTfFRa1PWHjS8WAzD2PmB/sUpfxntmBiamOwvoGrr8gDcmry8kQviSbKFBIjtRHdoYlgmTakn+a6RWsmqbkHOBxPtXddGi5oI/PitDHzn2woXgybUXZBvrkuaTgnCz1EcMsyKjzIR6snK+IbOh48AF5G6r6KjIWxNue5O7oRBwrErmxXpGzmhPZGgYrbFgq2dpfDD0rDNAuqdA/8ZLWy0AjuUEyF9HZiKTal5nETQ01NJJAJjXjoPR6mPdUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jrlc8lPlgHBBvTYW/sK8qlYSpdN6YN1SU+aLAiFifds=;
 b=ne5vg/6mBbGWpkk5bp9Z9cqzw1CJXAKcP1pNPUdJRc1Wq4e2Un+ywsYuVdGXG2wINpWBPLQe1e2JebY3k1PEY6GrIM6rU6rp3wZuBpMSrIemDg7cJfyVWqASfm63QAtaRkOpHxzjHtkQFvZG9e1GAuQ3pF+OEhNuLpESKpVAcs6WbE7x1kUFGegozmmIWZz+9mTrHcTDh8ngcn61SKRchqoLW4M1zEwrWZ0C3mERhk43FQldolTOs4XxF148s3Rz4RM15NWwddT1NgWeFEouJMAPm20nOKGCR12gNJZK1PZouNL11mfuheL6lKEeAm6bKM/Q+wwp7zaNscIph+xRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jrlc8lPlgHBBvTYW/sK8qlYSpdN6YN1SU+aLAiFifds=;
 b=b/o+Cj6TaPauNc3IsH42Qb6NK76B4w1sQpoGGfiJiEtwAiKmqe4aCrICB2rN7xqhstAed6+u70+/Vn6RVS59UZDgvYKLhz5LG8LyrjnbxYarf4vWDKKtmUOMb5PCNv+CNA1N+8T/IMSC24x18e0i8sIP+tk/yWlu6ZG2tMsS8qM=
Received: from SN7PR04CA0094.namprd04.prod.outlook.com (2603:10b6:806:122::9)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 28 Sep
 2023 03:49:55 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::4c) by SN7PR04CA0094.outlook.office365.com
 (2603:10b6:806:122::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24 via Frontend
 Transport; Thu, 28 Sep 2023 03:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 28 Sep 2023 03:49:54 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 22:49:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 20:49:53 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 22:49:52 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>
Subject: [PATCH 0/3] Add spi flash lock option
Date: Thu, 28 Sep 2023 09:19:37 +0530
Message-ID: <20230928034940.2220-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DM6PR12MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b82fbe-c221-4d72-b1ea-08dbbfd5f9e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0pYLKcsS3w8swSRq1AhHiBRTEhq+qKuEzYS8mhrWENEsQOkx1mMpY+EPdU4Q6QSxKCSQ73XQt3lnKEM90N562Fhaxs9Qc9zq5Mu71nPon4pWsM7El7nwN56fMQxl1OunFm4vumN1H1NNOq4ii19/osISjpL6ahKInouwpA/ZX+Jp2vX8ExCGKgGCYyh+GRhwGLfTFTxGl8E2gBxrVoeEPk1MAicf4m7/Y/qyNfAfWwAPqKviJxJmcYmi5Ygl7kkO9iJ40WwJOYY+FrzU26hJ0twiushtqMDKGqvWs8rXkfDVyMKQQlGgT7Edk/Di/Ude65eNbsJHpSmFwaMUeubBvKwUZJwjzdMohnfnQETmHqSimy2ipiqPSNtcrMb/MdUjbcCJQVyLo7K1mrRmjdtp3uCkk3IjihHRPlq72sfkcwnUbRMVVuiU04HWigMYuolTppS1/srtWWXAmLoorGJ/pZfM/OQWeJfThl3s9gQ1H7thTazeRLoT71HGmfe3aE/mrmjscQCE0oYaES5+/xz+kvsBnL2sbs6NVZ+7LYj1qsT89rKN9yDeqZoINthHgzuLaRzyAIuLMsEdQrPRg4n5Lek1GGsgP6SBT1aJ3VIW/X8dscM+0VUNgeWntFHOgcq9CYOLML1G0+UMRQgapNGdbBQlpkwRcI+kuGG7YuTmF8UE7AY9LMP/dzrqEHsU3KddaOLMRfsSyS8AIcA0Duqrqk1KrN0Us+qQIEjAb7I5BajWmF8vw6GqN2KhR727AmlorBMFowPOJtXXlAHOqW2Ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(46966006)(36840700001)(40470700004)(70586007)(6916009)(316002)(41300700001)(40480700001)(54906003)(70206006)(478600001)(6666004)(86362001)(40460700003)(4744005)(2906002)(36756003)(8676002)(4326008)(5660300002)(336012)(8936002)(426003)(26005)(83380400001)(1076003)(2616005)(107886003)(36860700001)(47076005)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 03:49:54.3754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b82fbe-c221-4d72-b1ea-08dbbfd5f9e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
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

Disabling the flash lock option for versal and versal-net 
mini ospi and qspi defconfigs.

Venkatesh Yadav Abbarapu (3):
  mtd: spi-nor: Add spi flash lock config option
  arm64: versal: Disable the lock option for mini ospi and qspi
  arm64: versal_net: Disable the lock option for mini ospi and qspi

 configs/xilinx_versal_mini_ospi_defconfig     | 3 ++-
 configs/xilinx_versal_mini_qspi_defconfig     | 3 ++-
 configs/xilinx_versal_net_mini_ospi_defconfig | 3 ++-
 configs/xilinx_versal_net_mini_qspi_defconfig | 3 ++-
 drivers/mtd/spi/Kconfig                       | 7 +++++++
 drivers/mtd/spi/spi-nor-core.c                | 8 +++++++-
 6 files changed, 22 insertions(+), 5 deletions(-)

-- 
2.17.1

