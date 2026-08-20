Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5142BC5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:33:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9270F80BED;
	Thu, 20 Aug 2026 15:33:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5OsGcqVmlS4z; Thu, 20 Aug 2026 15:33:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787240019;
	bh=I/9HD+ilqH8qtMP7raN5hpDFDIxsjX3ukejKB8RuXWg=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YKH83fIlrN6rCu8Yx0lf6KXEikP5vSgKNQ/Xk+jaUn46VAcHjNUNOyA517mzT9EIv
	 a+NmRLGpESU4ZX7omVmuebXGpQL4g5cT53CVfHAH0kwBMO306qxmaYXvW+7gB2qtdY
	 3P4UQv9BK7QmeFEYGtg9z5Im6+o3tNlmpZz211yFfaADczyG7arE7x+Nh4KFLKOVBk
	 QiGApGdL4K8VSLDf6lxP2JarpUCJXBpiSumjyLZOUKe26lAN32689QMDFqm6D1Y5sI
	 sBPvFPxXgDSSH6TB0R5SatGmjL6k95D2yYhh5oKg71TGZaN8oJ/Lya7U5VcN7Yb1sT
	 TEHXQ0NzPaGgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFCCA80DC9;
	Thu, 20 Aug 2026 15:33:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 803E139E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:33:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7DD9960779
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:33:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xGpfXzXbU9Xh for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:33:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=akshay.belsare@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=OSVLzdI0
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 684CE6065F
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cU1Q4qXSGz7OHQTKa5VeuJOSv6kBYDccO8zh7cG6McoBYZlWvdcCdfBgt7Uz+4IAfd7jJFJN+eYDUUM4b3F19JKWO273BkL1g29t+iV+lE6Ze0BRGwdvMA0hMSf2A8ii/wmMDX4XifxU/yjdApNh3FyKlHFrgmfM45SfR0Zeqclle2UKEzn7tmrLaLAisUTAtDuP2FsW5I6PGsmhrGg3fhZcIymvPCmA7ut9Wjb7EiZ0pgi68DIslJnyM5eIaycBMfcntWYSxzRNysmtX1cECLUDvfe4KsDhH6zUilWdbJ8j5+ydWqq/ndaGNpRpwTPfFmJzYie2VtFxkLejbkfJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/9HD+ilqH8qtMP7raN5hpDFDIxsjX3ukejKB8RuXWg=;
 b=L+3T2idYniIlOI5yXT7W/vWsP8R5odrDJS1k0dCFtVWI58H73u+Kk4UJuEGhUVfBedWliUhX7cYkdEC0liQU17nrOBuNmYslWGuGeE7sFb/2sa2na0pLlMpNUCpb2a2EgU/NLn6HE3kcj1eD7BsYkzN0v91MleKEp8o7QlkZziGpeQ8IdnZ7NehRmE99I16w0aBQdy6bzK7laStCFJv8MGuia1Fa0GavIf7+XNZIXmiy/GvzxTFMgGE1JY/ikScS6JOQq2Ek0pjNBA48kwH5F7Vcw+Cq7EGYcglsJCA9B4eGIDBxSm3NdcUuw77aVIJr7+tAxvGKgH4AcjY53/SsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/9HD+ilqH8qtMP7raN5hpDFDIxsjX3ukejKB8RuXWg=;
 b=OSVLzdI0hOa1ilbrNFB9oxvAigStgyVeFdnZnWBPHArYI6Q8tddTLyszo8JQ6gCQrQebrTSgXMh9pseGHP2bTrSRTQCazX0bvhyOx4ab1owdxZOLWSVFL9HMSgBN0SsTbymBtMnyTgwpWGWCunCNKyGNG0NHrOt/xPo1HXf71Ro=
Received: from CH2PR17CA0025.namprd17.prod.outlook.com (2603:10b6:610:53::35)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Thu, 20 Aug
 2026 15:33:29 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::97) by CH2PR17CA0025.outlook.office365.com
 (2603:10b6:610:53::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.9 via Frontend Transport; Thu, 20
 Aug 2026 15:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 15:33:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 10:33:27 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 10:33:26 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 10:33:24 -0500
From: Akshay Belsare <akshay.belsare@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>
Subject: [PATCH 0/2] reset: zynqmp: move reset_assert() into firmware driver
Date: Thu, 20 Aug 2026 21:02:37 +0530
Message-ID: <20260820153258.261076-1-akshay.belsare@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: f532750e-90f3-45c0-d953-08defed061ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|6133799003|5023799004|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: qCLLtUhb3QeqpTlgo+P1JSPy9vNkTHS78nAYKkujUcos0RpPg0ilRoqCmHJ2+PD5SEU+hZt/ySNQzkNzJ3DmkhxcapwaIh0V9osvLuIryXb4r2oObodgy03ixYBZe44S8KGgHnfRuBJutlCo80eORWO4Q0kwqvwDGLcEYBJPDGqI/VZ9mOUY7W70hKsyIRuVW7VEPAGXzdxw5MDyBEsZbxtKO3zPnOsCS8P29wVIXlXo+8YaMmJg8FTvvxa+nWtp9qy4B5/4lwLOoXlDc0ZrYHInPTSAgZ1u/NUhg1glAmNAmAkfGN9SrlHc3fRBKOGwUBuRaeaeNS8ANNuWUGulsPSS/6XZhCBrZUSinA5PttGBk/73ooSaEsRD5/bd6MzvP942LhDJ6Lag8rC72m7Q+hV3v+HY2NdgXo1mNE26XicnM4jegOEHJvSbEjOGufQumCf/mm8prIv2XpO+V56kbhp2+GBpvTLcenURupUxk4m5hFEToYfUvWvkWhzc2bupLCY/2h7T8pkBcms9eBTYdj/PNbdP0f8XJ4EEzGkCrI44G7Wt8TKnp3GbVhHXYSi4enKINz8tzHxunVeeESoEgeWQPOo+VrCf+qvFX4LFRcUKPElhNKlNhuKUENhA6RFBKQFdZ+MWaKaxb4T08NWVm4oOIZXjoSCz863Iw1mm6gGtETix/M5M1xyowQpyoOX2t2s9F2PpKPV7zC+/meqAwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(6133799003)(5023799004)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l6jNy3BjKivch6mfmcAqHLA+e/sTwEQa9Zv2CNi7Il6Axr4Ye17B1f53UuIbX/02E1tbfvaaQo923g7wjZBc4yrHIdpSwNz1iKXukiN+n5KiuIFaMbyWHVGdkhdzJWTKihLAI2SqAC4rxl0q+jBt/tjm4kInwh9ph+CdrPEpOgZog61gj1fzYdaietlit7UEZrfHJ6PkwM5GJ4DufjPTl8+TsAFm3uWg+nBrIxwL773ALtDiV09TS5tFEtkdIsbF2uPZCcc2ofsLhuZoPy34aRF0CMbsjlKDtk1yREoWKxcb+h86yghHgb+fv+IOYunZBqFe4RpsSRp1+nTi8lJ88W0c7aHbepXLZ7Zo5yw7hTxJNnY/TV91+KBthgAkqwG3FJ8XqYZKV72P6uwVtqFCBFfBYy2P0iEReGzdHilhCYEwo5zoKOIbgDxUOuIkIF0o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 15:33:27.8245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f532750e-90f3-45c0-d953-08defed061ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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

The ZynqMP reset assertion helper currently resides in
drivers/reset/reset-zynqmp.c, even though the driver is built only when
CONFIG_ZYNQMP_FIRMWARE is enabled and the implementation is entirely
firmware-backed. This series moves zynqmp_pm_reset_assert() into
firmware-zynqmp.c, alongside the rest of the PM firmware interfaces.
 
With the helper residing in the firmware driver, reset_cpu() is updated
to invoke zynqmp_pm_reset_assert() directly rather than issuing the PM
request itself or relying on the reset uclass. This is important for
boot flows where reset_cpu() may be called before the reset framework is
available.

Akshay Belsare (2):
  reset: zynqmp: move reset assert helper into firmware driver
  board: xilinx: zynqmp: use reset assert helper in reset_cpu()

 board/xilinx/zynqmp/zynqmp.c       | 7 +++----
 drivers/firmware/firmware-zynqmp.c | 7 +++++++
 drivers/reset/reset-zynqmp.c       | 7 -------
 include/zynqmp_firmware.h          | 2 ++
 4 files changed, 12 insertions(+), 11 deletions(-)

-- 
2.34.1

