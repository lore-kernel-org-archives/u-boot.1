Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC01FC83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 12:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6677C865DF;
	Thu, 31 Aug 2023 14:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bYG7/EXx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03E9486556; Thu, 31 Aug 2023 05:26:50 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05E1E86558
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6YPABOU+yBbQoQ4ZtwgpgMy4IPSkoFY8VyFhuzvT9zzSoB33Nc43hkdOON0xKr9xstfVBY2O14+LDvUUdszSxSHUbcJHVb5/lUMM07yvpUwdaUwo5xhynRPf2lQKqMu7Hv3J9lznK/0dtMA4XldXbIC45UV3Vh/y9P6l/fq/nfb31O81I8J0VGaAdZnACm86a756AHCQSESNncXjP/O3RFMdj286t9h7ZeQZPa/OlV8UjEF6UJZvpll4SUk7bfaQrV+0fz4HuK7phRLW14hfmP2OqkI4jDhIt7sxtUUEzXP4mSWYbzprV3vvkT7+Z72JGgiDpzlPm2paQlFHjdUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zct3eSemp/JdYrfUErnkYW9VBEoXrAyrudU0CY9clro=;
 b=A75BVnbwxRY1q7BtMJki92BQ7YJxjPsrzH3ZsT8FXwX2vFYHTxMUHt7S7n2acxWxDTG9H79oEi8tQWHvcTNikxYMY6rrLVH/TO51GQY4xLW6eaeBOAzi8MbEx6iEtWb9fKsWnuMTDoUX0OG5j22uujm4gokQIOi4ykTGgLOgAs/2FdutCoUhMNj4zwaz8O2mZ8elpRtJ4HR9ZmzTquyRVM+kH4Np7Tc+P/ciGaoetqwPnhEtEdySGXswQ3mt6NvvOLjKWYGMSVbCwTe31Zdd1xaWobCHr9aO8qCLXdTJEQJX1fjZCIrRfZ6/i3ym8UtiqTaeEMnDD8hTm+Joj871zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zct3eSemp/JdYrfUErnkYW9VBEoXrAyrudU0CY9clro=;
 b=bYG7/EXxBIwyG33KlE5R+5348ZoTr8dK7d1MaVaE0bpsL0xqxp92uc3hU6HLz0YQIPVn86rp061dFxvJqWw7xVXXhpRr8uqaN0z8tXvXXPURxrlOswF4Nh2f909nLocUVMcpLiOWzLXDWse768JmepXzoQawtbvXC7y6TvhLxxQ=
Received: from MW4PR04CA0033.namprd04.prod.outlook.com (2603:10b6:303:6a::8)
 by BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 03:26:42 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::a8) by MW4PR04CA0033.outlook.office365.com
 (2603:10b6:303:6a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Thu, 31 Aug 2023 03:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 03:26:41 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 22:26:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 20:26:31 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 30 Aug 2023 22:26:30 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v2 3/3] arm64: versal: Enable the config CMD_KASLRSEED
Date: Thu, 31 Aug 2023 08:56:12 +0530
Message-ID: <20230831032612.2729-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230831032612.2729-1-venkatesh.abbarapu@amd.com>
References: <20230831032612.2729-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|BL1PR12MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ace6da-69b2-493b-bf51-08dba9d2183f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHT4SxpmevMhKsuaN+7ft28ndrPaMuodD8m/ILg9TjLi78k9yl7ri+jo8v1M6+um3tcQMfUzIqtRM0IOe/ba7Ex4CglqCWZaLfQixWOCt2fdigGqVf2jmJlrcYi+eqxYL09NKPyPIu9PXaHVeLiIWId6cmxgsf9q1nWxE4C4ip3yliowgwfkR/Tx2JCqA3EkBpyJCv5+duE8ShqKohJrmLJyV3X9XvMSFbtEn/rbzUXpghB7hpoLohLDvTMsjASZxqfTNroW5/5fUIIrqyL9Z88hWQRcMosYrSl7AhoT4jxrkOnrr4iqEx+InmIk6qfp0jSZdMW31Gm1Jvl0smpR7ilaGDKDU/O3c731SkSZW2HQlEUk11LhnA7XAH2F2DEiukdpyFwsHvDQ6HyjdMnX+GTn2mPc8j6NgMy37Mls2cmZIQUnCVvhJWPvYPOk9NrxtBtr3/mL42GxgWypdmLgnLiODiazPcTMY9vixd5ufzsCBYeu3a9pEQQ2EeupVUD1gsuLtblaGUpfYIZIH0O09aKRIYvYb+spj4hZHD4JlWCX+99a3MySQ1OMnLlV4frC1QF6DKwcF26N/VvGuEhnYsUQ7RvKy/MDbT6SY+lDDBvl7+a6RwfvsMm/tujUSgSSD7sFE1GULRihG2gzSueShwHnc344gB6MK4QE4NKSsEGi4d5lAifHZdHlKANbI7eqjRcSCqgI+7re8Z2Dj8TW30ez61pH4ZfULIrvF23rd47w/ckkh8Fcuv99lrnPw4mQJ2YNFGwIlW7PDDkpUsmV8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(426003)(40460700003)(316002)(41300700001)(336012)(5660300002)(4326008)(47076005)(107886003)(2616005)(83380400001)(8676002)(86362001)(26005)(36756003)(1076003)(36860700001)(6916009)(2906002)(40480700001)(8936002)(6666004)(356005)(82740400003)(81166007)(54906003)(70206006)(70586007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 03:26:41.6708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ace6da-69b2-493b-bf51-08dba9d2183f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777
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

Kernel Address Space Layout Randomization (KASLR) is a hardening
feature that aims to make it more difficult to take advantage
of known exploits in the kernel, by placing kernel data structures
at a random address at each boot.The bootloader supports randomizing
the virtual address at which the kernel image is loaded.
The bootloader must provide entropy by passing a random u64 value
in the /chosen/kaslr-seed device tree node.
When we run "kaslrseed" command from U-Boot, the bootloader will
genarate the kaslr-seed and update the /chosen/kaslr-seed DT property.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_versal_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index b4082c3dee..69af916c3b 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -50,6 +50,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
+CONFIG_CMD_KASLRSEED=y
 CONFIG_CMD_TIMER=y
 CONFIG_CMD_SMC=y
 CONFIG_CMD_TPM=y
-- 
2.17.1

