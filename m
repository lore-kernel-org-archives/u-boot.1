Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC0AC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 996ED406DA;
	Mon, 24 Aug 2026 08:36:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2BLYQG2Pug1C; Mon, 24 Aug 2026 08:36:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787560572;
	bh=doOyJZ59y0iQl+dfwiwCPZrj40HZMX7wql984y/1gF0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cb3Y3WGFosX5NWEaFfOYu+sJ9TVNnx4N4c+AmGdkcDNgIWvjac0PEQ2qRBazED3Cn
	 HXfzRAPKqfKyYMnD14npqwj/XomEQ/VpMzk5uj6drqP5LRAqdJsLoMLKFGHIEo9qc0
	 FXQ5coakzx4DTs7uwNPb35AHmNFhp7QbnOS1Ue5IxqehZ/5hEWRzliRR+yaN3ksg3E
	 936YrbkmvDehW+X2hDSjGuWkiY61DolxEGQheRFxO+dD42w+ziNioKF+JzOYR+6bX3
	 A3/yBRRPX/DJlnwZa96Ia9oCJtfRcDzUXrKU0WQvEUyssWY/1rAj5MQQFjppT5InrD
	 6f0BBQ56iXjyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D38FA406CD;
	Mon, 24 Aug 2026 08:36:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DB7E3AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4FEA1400AE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:36:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vo2BtPZ58cmr for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:36:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=VIgqtkmF
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A32C4005C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VURICSKdBxvrMoX2X6iyJPlQLPYqNwnD27FCX9WJrqYs/Ekt5b+XwjfWc8uXDenyTYfkPKIVPRkRNgyVomqM9vCWrHlwdOUlugorIdWMXGys8KHDtpJjULfMZciZ9VJgiCrLCs4VD88XRdzrC69JsN4sajUwjRytIMHHfBnewSATBMZxApj4oHms5eWxnOSnbUaYs5ofWkLu4EHvK3oGkfsLrJ08Qw+ZuUkpXSCrX+R10+O/vwKwInD7fjH9kf44Z00O73Svir6TLmi5257TdumY0zo4l58q+rZ/CWg+nO2L0pCYNIz0wtlf2SPgU7ex/B63REwYIoYDJs67UCeEqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doOyJZ59y0iQl+dfwiwCPZrj40HZMX7wql984y/1gF0=;
 b=tFJch1g9QBHGd86G0wGUT5ty3KZzYDkeIYA2cH3AnoLeqQ9YUZ6BQtztEZh+Gc27MuMyqsaXXcOQ7BkhdY61jcmHN6pAC/1U73e00EoncOCypkykh6wbalPXQNd5ZzUIZ7eAO/bedK2WmgwR8VRBYL7p3/mPPCC6Tk/P4taMUA0UAIhykR93nI/jwrg92ocWmKQsstfjhsuX5ykHPmonpXBG20yvw4Xf6AwN+acjyEEOO5oDNGNMPKXgx18t6ilacWWOZ5hCgAwoDxc0yJD4YKgAxN6TQFiZsvctJLei+RxvmtsXEaFZxFChfm/ZLYRUdI+etKxDnO/f6K/QOVoi7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doOyJZ59y0iQl+dfwiwCPZrj40HZMX7wql984y/1gF0=;
 b=VIgqtkmFLHrZqgjX6IxtqbAXpH9/Nyl3zkOR8IeIOUo+pTuP0hAkhMn8UyYb6IaDwOlOBE4EbzNVDUV2riUTd8ombRm+6Iyb2RHXPBNIKaSC+F7FEVPEt66YFeCst0cI0kTzrlTSW17ItSz7W+SUHne27luppithU8LSznyZPNs=
Received: from BL1PR13CA0364.namprd13.prod.outlook.com (2603:10b6:208:2c0::9)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 08:36:04 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::89) by BL1PR13CA0364.outlook.office365.com
 (2603:10b6:208:2c0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Mon, 24
 Aug 2026 08:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Mon, 24 Aug 2026 08:36:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 03:35:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 03:35:57 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 03:35:55 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 2/2] configs: versal: Enable AMD DW PCIe controller for Versal
 Premium Gen 2
Date: Mon, 24 Aug 2026 14:05:02 +0530
Message-ID: <e52a8d8dc31ea762d6a54ca5b23e2a1d31125c2c.1787559753.git.pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787559753.git.pranav.sanwal@amd.com>
References: <cover.1787559753.git.pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0efbd4-bc95-4d79-f53b-08df01babb85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: xGZ8xO+FdHGLzm4Sv91D+wziHeFqRjJC5ME8zgM47MhJ9h0QpY/mZe7c0K1MJhfMacjAvrVlIkFk80tH2Gyl9z51T5xizPJV/tTpoxVWku8Na8Vb0/BJDuOQltQYVjNhqUVzPcFfPRtaxcW+zxC7LVtR0Rlg2Ie5xhg25GtkBqDBZT9Mps+05GaI8LqjgpcN2q2t3KI/cVwNcYpIpVXCTTcq4EStCOVnf2uACkgp8hKZaVFRdIuFYeU4IS4JwXUJ2NBaculg2jioo6CXB++pkieixPz60eLRm/QGgSDAhgwU+0QjkIAVPuH3fLtR8yOqHlrG9DNO+g2tfCBFSV+gxay13+udS4cwcOzcXTf9OFVB6lcislKmgBtKFZVYsXSiUk+bvAhcII6PQFiwmAtKljBb65CZ1lpqMyakHA1Fm9DQmZGoVVjr8tJ7YfxJAyGIHfYdaEmThgZR/ASzSaaIYsYR/n8xDVk6Q/TOPcVUcxOUljOCaFvybHT6zbHKmUHOrPHhqtbE+GW8A7o66iWsU9+kJ7f3/k9Ut+pmZk+7e1gSR22eTuwvwNCyDlgMtKCCdfZ6/G6VudumUMDPOEp4z+zRKT1cU2k0xng+HZ25vZ/9qQeijxhLX9br/3YRbH85s7CRdj44evD4ri34nghT1wIu+6hzIH1JJs+LVbteKUqGsWYkaAzWTuL3cmy92mEg5Av0WWDOdLobEkUM0IFyeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 45hzHwIpMGbIcjwMFoES+0LgmtFx7AYGtZrILfTyhe0h3vKkplEWDkemzQkVtFipdLkK6HA43B+G6mH6239SAs7uCu619ytwwqd7MV+JHaBI67eBU5Es74r9wFHR7GBRtg7zsi/5LfNit94aaidR+ikQwC+h7JEFjvFm21Vi3flUcV9HG7pMxzMgukwOZbnN9T8jHalxo/n7Fx316XwgpQ2UTee9mm59DsIQ5Nug4aP2cheSNuc0Z04LpNuz5TlwTBJbzxTWz7CElkaQGwA3CcZvl3BuNIsLcW2IWS1u3HJ3zdx92qlQoL4p8w74s/EKO68BRu9E+R+/1JPe/1wfc9Q40BM2IZdetHSjZUfrznFmZZjJ/dIoL/pao6TcS4juFUcvvwnV1V/aqhnOBxhbuueSBkCtXbeD85rHa+dg6hgynI7GxDmfSM/LOfnfx7AC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 08:36:03.1168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0efbd4-bc95-4d79-f53b-08df01babb85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486
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

Turn on CONFIG_PCIE_DW_AMD in the amd_versal_premium_2 fragment so it
is scoped to Premium Gen 2 hardware.

Explicitly disable CONFIG_PCIE_AMD_CPM and CONFIG_PCIE_AMD_QDMA_PL,
the legacy PCIe controller drivers already enabled in
xilinx_versal_virt_defconfig, since Premium Gen 2 uses PCIE_DW_AMD
instead.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 configs/amd_versal_premium_2.config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/amd_versal_premium_2.config b/configs/amd_versal_premium_2.config
index 26c5cfa536c..1e43c0ba6b1 100644
--- a/configs/amd_versal_premium_2.config
+++ b/configs/amd_versal_premium_2.config
@@ -1,3 +1,7 @@
 CONFIG_SYS_PROMPT="versalpremium2> "
 CONFIG_TEXT_BASE=0x40000000
+CONFIG_PCI=y
+CONFIG_PCIE_DW_AMD=y
+# CONFIG_PCIE_AMD_CPM is not set
+# CONFIG_PCIE_AMD_QDMA_PL is not set
 CONFIG_XILINX_OF_BOARD_DTB_ADDR=0x1000000
-- 
2.43.7

