Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5E7C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D3A187852;
	Tue, 26 Dec 2023 10:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D2n8APpI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD9F78783F; Tue, 26 Dec 2023 10:36:46 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A07BA87808
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxYjGGnSA4jkPryd/RBe84jj+tVvmB2QwQUHJC4xbKv8GCHQMYD6EI8HzkaYSbzeeOrSgWV8vFdCzRwglPyjb1KQkjZuuRZJucRm8OH9iKQHdxRxVwvkuRg1Du72PrK4FVe1klfAbwOHWQEbhBNqRnh8VhbqH7Gw4CPAjfAsewZUiniuwz7kNZHZHI5IXxBpTrRoPPSYGOMHCPaGCTA1Q1n7ZOVUH8zOFRLG9QRIZqbAnaH6nUcks/1IWcjbdiOMRM8KMZHTnOWAfSPa74mAEuGA+63Tpesd/B36mcx4lpSPD85esx4WX8P6zlgtXp2DswvscE9VyFS23Zpv0vmxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8BS/l3gp2vvgdtCJa40EgZaWRNUEzOfmVcUTuBjVCM=;
 b=OoBSSFyYNRiXA+6cAuDSVDKwOXHPCEkjVIGYOB8m0qiDgyDCj7y/adVt4MiclkG6y3G2tRtUAJNV2p+A1IdG43U83kyyOVv2qmaTIQzy6GF1nULwrcSca9rPdMjxZaz3vd5Y2SukyZeDIxUbvdJcXK728Sw8Wp9Iqpnj1Ztp6MngCZX8efqK5YNTj6BtGCGeAYN4zZccRdmwwJcnjYsUwDUwv0+0gcVHdLa07Y5wClADY9YranTup7yfQ1lUzYiGrxx9Ub0DAdluz+ScZN41LlxHcsiZ/N31WiuAVoQGesSJ7J+MijycYdJFosCWAL3oxX8cJK6tOj1ICjwgzIk9SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8BS/l3gp2vvgdtCJa40EgZaWRNUEzOfmVcUTuBjVCM=;
 b=D2n8APpIh4EmViGonvbgYCJ/62zZ7YTQtDngxytaQA4noWMWr7fs/o+7gaOXX9OgW4hs1Yha8P8SfpQtsCWmlViBcCup/DY0UtYKXMI6GM32vMKAV+wQFqn4E7AOjnVa4KnfvpU52oZii8F6afMtX2M8h/BiFMWRrV7FzbFjZbs=
Received: from BL1PR13CA0386.namprd13.prod.outlook.com (2603:10b6:208:2c0::31)
 by CY8PR12MB8298.namprd12.prod.outlook.com (2603:10b6:930:7c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 09:36:40 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::24) by BL1PR13CA0386.outlook.office365.com
 (2603:10b6:208:2c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.17 via Frontend
 Transport; Tue, 26 Dec 2023 09:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Tue, 26 Dec 2023 09:36:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 26 Dec
 2023 03:36:39 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 26 Dec 2023 03:36:38 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>
Subject: [PATCH v8 7/8] config: xea: Enable the SPL_FIT config option
Date: Tue, 26 Dec 2023 15:06:14 +0530
Message-ID: <20231226093615.530089-8-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231226093615.530089-1-venkatesh.abbarapu@amd.com>
References: <20231226093615.530089-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CY8PR12MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 617d07d4-a2de-4105-fb8d-08dc05f629ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1efzxDglc8E4kCGGk4CVaF4lWjaOs54ULC81WdIadHujaOpBg6dcWmHnd5JnaJAx+kBS+i05Rme5IdYHoFuGvU9AJy79ZyS9oZ445gK0flvFTNhAo1/B9bi4qu1tN4RKriuiFMDXfxKVSRULjcWUYDzYDQJblsMzrCINlXJVBNLA8D9XW5PfUl5oQrKvyEOfFFSIo6sztLxhjtwUBxNqRkeVo4FlVkE3EclaIzf3RJBfoKBe5rhAkl5ZM47kTtknwdNYE1n82p4JSCQr5ErOveWLW/i0M2MmczzqQb2BHI5WeJcEMGqxr7yMBuaGz5/gvkaOM7cw3HYeVtU4v4CTTZF2XEI+MIRPeKF/pi5ADyNv0pKicEAH0S9swmpQ/VZ9Gw4SI6zfGRmXL1kDimOT9JLSMhIwlF/xeh75CMEYyLfC2fOsP3GJYySrTgORUECahG0eEoB26rppj70ACv/UMwhchAUjQz0buxr/b4iMybUwxfKu6UKFrWYuvsCdcj/Zff9+Lr568xv61n0HAWFPyGlDcKp/atkdtVErBLmPoo3y3hfxUD8qK7w0WURkuhxej1X5KsBZsgx0onupQ760UPOKFBcrPOxsflduoVhioNypnhDRD3VyKEiYcbd94dhRc6KPJhPW4g2+1BGCorWqIyhdZt0IXDPZxbX+1ark/PlHIobBZMU2/TbMLjHgOh6pj+DuzjdwRwn9BddCUEZSRTnH4jDr8RPkb+gNYOTtlE2mzMCFPIU/vmta2f0Hb++iD41VWBB3/lrr8PPG9jrqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(83380400001)(47076005)(41300700001)(2616005)(26005)(107886003)(356005)(81166007)(1076003)(82740400003)(316002)(36860700001)(4326008)(54906003)(8676002)(426003)(336012)(2906002)(5660300002)(4744005)(478600001)(8936002)(6666004)(70206006)(70586007)(6916009)(86362001)(40480700001)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 09:36:40.3142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617d07d4-a2de-4105-fb8d-08dc05f629ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298
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

Enable the config SPL_FIT.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/imx28_xea_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index c1b0487f7e..882b6093c9 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -29,6 +29,7 @@ CONFIG_SYS_LOAD_ADDR=0x42000000
 CONFIG_SPL_PAYLOAD="u-boot.img"
 CONFIG_TIMESTAMP=y
 CONFIG_FIT=y
+CONFIG_SPL_FIT=y
 # CONFIG_BOOTMETH_EXTLINUX is not set
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_OF_BOARD_SETUP=y
@@ -123,4 +124,3 @@ CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MXS_SPI=y
-# CONFIG_SPL_OF_LIBFDT is not set
-- 
2.25.1

