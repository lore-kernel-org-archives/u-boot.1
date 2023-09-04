Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5A1C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 13:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1EB786967;
	Mon,  4 Sep 2023 15:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xOvH/Piy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50AFD86867; Mon,  4 Sep 2023 05:20:53 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D896867B5
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 05:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSgI6eHXZ+C51fBfZW32+9JrDdi9SHnzfXTWyGSHVC8f0EH0atCUK9GY/7nwF8pPrW0PoNp83/Ajxu74ag1gamuOFRF+e8oAdpeLxkVjK2GQIAeBuabhOvrsown0BK4CeRf54MfBfKsKV3QMW3P2b37I937ANxUtdjZblgJY7dS0odTxjBJ3CKwhPRYwPVBfGRqPkrYREbsheD8nBNhMT41iqUp5nBUpQGTaxGf9Nv2HrxAwI3DdDWKgcJhyNAng1nizBFTErpWdDSYVbYoVbd5IVdeGAgkd6guZ/oVv1qfd4lSoxT8DbDsvSkzuxaMGynqd4UDHcBAJpYT29OhLuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cg3nIYxStJkrdNAHKDsPX4p+RndmEuOCBpXguvzhyNU=;
 b=e5lv0lzcamYwU40XOBEENfUfRDXxHGf/VtxywEIiYPO+mhwnjtMEpWxZJ4lJSHiN9DrGber97Z3bgVkn2SBp1AH5TvQabghBscnKRxEWQYWmAqeHrTiB4+0mp0eZpLLL1sFxZc3a3aDKTfcO51oCyMTIlyAifKVPX4XL4jObGMzyqkAJOYS8DGcT/UQX8MAuBYxA7tcKzk/c+D9RFsJ/gwATMO7EFN8QXkndiaBml33oGx7RZAvBOSnxjPuwtSeaMUqUUa9A0Bq8yFMB7mN3PVoBSsMbZKZeZL/J6iv2fpXLlwjGt1EFzag5MiDcUfl634DovfvesSz3Y3jzNGKa/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cg3nIYxStJkrdNAHKDsPX4p+RndmEuOCBpXguvzhyNU=;
 b=xOvH/Piy95fEGp2ObuBNiOGPL1p7LwXBSrLjuyLP4+Gj3Lo4Uzpc/i9krPZZrqJ3cSSshj54rBNbly5YGSYjjeJBAiacnKRES8i6Js3H4dKebvZ3CrrFPjoBD8rjOlnjGFbxE5S0LAmR8/GHdFCiLb6kEhAenP79rlW6FjVuDPc=
Received: from DM6PR11CA0030.namprd11.prod.outlook.com (2603:10b6:5:190::43)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 03:20:45 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::9e) by DM6PR11CA0030.outlook.office365.com
 (2603:10b6:5:190::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32 via Frontend
 Transport; Mon, 4 Sep 2023 03:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 4 Sep 2023 03:20:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 22:20:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 22:20:43 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Sun, 3 Sep 2023 22:20:42 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH 0/3] Do not setup boot_targets if driver is not enabled
Date: Mon, 4 Sep 2023 08:50:32 +0530
Message-ID: <20230904032035.11926-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c51070-06be-446a-0e1a-08dbacf5ed0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+UQvy4Y0KM2xnuVfW/Gyd+oeMX5OmewD87KElSatCijbCyZeBb4RGWgHT57cJPlTGWliqmJ4ofIbw2U/j754I/+acbhjZB0dwklb6hVcfJgZ7JEySaAcbcpz2tGIVE6y1n6g+/mk7eUHytimdGfu+mhmXyDKwSvG0HxJLA+dRwqysIH6PnGpqn4yDRPGaE5Oj8LcPUC6FOkyVXyamnstNiM8RzpQCt+EsbkTXaa8q+ScvfxYSyNaEYTJ4YYbDxuoqY1bEcdz6MZB/2dzn6KJJ3lW7eqLVGnL7q+gPEGudnAushSNjAFTt5WNYyKxPh4mAcynILlbzZHsH7rYktzjVLJi1HRlrVEuZzP/XZXJabKPMbFyWOi58Kp9U9J1X1aSOYyPjc9PbdK7/14uCPbUKxnnwLwnfR/gKmyTM+F5/uFsProMraSkRbgRXSOeGWTY6/VvNRs2hC+sNFfqcqsnNN2ijjiPkx2yJppD1oHfFUGpH1vW97yc6R6ZGtYIdBQKZCWK5waJBddKRHh4Dgu20BrzpOwHLP+C+oDxZMYmRi/SdBEVv58xWwu9bHlwRdnapraBaGkpItjsemssgWxUaKJELERMcBV5FfTix3K+2xpe5w+r971xyP6IOasgLz/lvmgAKNmoX6zUH4oX7FLwN/5FK40EdbNnI1bateq/qoaJ4qm/sn6upaHz3i2vriRyWpi0rD0JYKaP8a68dPrtPG/bnjqiw+gEStQGRNdaN8Dly/j8FyJXCxls8T+/bIsrF0gZBI4j+6PiqQGLH/BJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(70206006)(70586007)(2906002)(36756003)(54906003)(86362001)(316002)(6916009)(40480700001)(5660300002)(8936002)(8676002)(4326008)(41300700001)(40460700003)(107886003)(1076003)(47076005)(2616005)(83380400001)(426003)(336012)(26005)(36860700001)(4744005)(478600001)(81166007)(356005)(82740400003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 03:20:44.5984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c51070-06be-446a-0e1a-08dbacf5ed0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
X-Mailman-Approved-At: Mon, 04 Sep 2023 15:58:13 +0200
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

Fixing the boot_targets for versal-net, versal and zynqmp platforms.

Venkatesh Yadav Abbarapu (3):
  xilinx: versal-net: Do not setup boot_targets if driver is not enabled
  xilinx: versal: Do not setup boot_targets if driver is not enabled
  xilinx: zynqmp: Do not setup boot_targets if driver is not enabled

 board/xilinx/versal-net/board.c | 76 ++++++++++++++++-----------------
 board/xilinx/versal/board.c     | 67 +++++++++++++++--------------
 board/xilinx/zynqmp/zynqmp.c    | 71 +++++++++++++++---------------
 3 files changed, 108 insertions(+), 106 deletions(-)

-- 
2.17.1

