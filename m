Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CBDD2AB20
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 11:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBCD788DC6;
	Tue, 29 Oct 2024 12:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Day3FBEO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F195F89166; Tue, 29 Oct 2024 12:47:30 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 868E088D3A
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAjsP4S+HpaV5BncXoXQn3d9Ot7IvKSZ2j+sAl69+WJ9IEf0WWEErDLBHcPd2lSeU6i3OMcfJklV2p6+pxMfhHlsNlDd8zcjKCfYNYtXVenKBNkLcxQyEBYrLSuzxirxrY32+/CFsPW+niA2g4FPdQqY2UIuaZIFMMMtv4x9TaxIQHvGIFAFyKzJZncrskaLnx/eCPuJMedfi8dvpJBwwP0194J9jV/ReZ1JM2HtKbiDjc9dDPgxBhC3/hZl5m+qdvIKtOEw2r4//GzRn0vaqCTcFkgHl/oEY3pk+/ACOmnVqO/+dtswG9jSuFAkvp8CyLds0DmCR8iVjsPd8cirNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsqxaLMhxkZZrRcmI2Ct1Evz5XJ91QTHXhHknFiH/hU=;
 b=UODEt8mb5d6ZwQTqLLKBWL+ukQH01u+RduPuf8Mo74OTM0yGxW0/CH3yYw033/Yao03pVyJzo+lGAyok69GgTuU6+RNqSsmC/TrdOlxI2uq4QO+/55nzQb4Zy6xr9rA+xwwbqgXuo31yRbSHhA3j/iGw+Ga3FLzjGp+RRFwuHHSUAvd4lshtzQB5cYwka4z+pg3BhqlVo+xNKkCKSVWtrWp3lvKqXQQaIqab4AQ326GcXCLmBHNkSs2FT2dX37dFh9HIsEiaktTasyWl8imurHFSeLAcTR0t+Hpuq2Vu6tnOSif6AOB2rJp8UTNt9T9n24ty1CaBm0vMM1+exzKXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsqxaLMhxkZZrRcmI2Ct1Evz5XJ91QTHXhHknFiH/hU=;
 b=Day3FBEOoqEpXe6qpnA+nlWNB7ebDv7UDdyqUzDglXm8CXC3GSE8o74rDdR1UEyXjn65vEbWPlMyxpbUE81cAa/QmTVNqBlWdd+ji9K3tnl/GzgWHLIPJ+eQ89bNdfZiA4dgsfPdXafsN/mTyn/D1B48OxA36U1QNhddzsQYCXg=
Received: from PH8PR22CA0019.namprd22.prod.outlook.com (2603:10b6:510:2d1::28)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22; Tue, 29 Oct
 2024 11:47:25 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::fd) by PH8PR22CA0019.outlook.office365.com
 (2603:10b6:510:2d1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24 via Frontend
 Transport; Tue, 29 Oct 2024 11:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 11:47:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 06:47:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 06:47:22 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 29 Oct 2024 06:47:20 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <love.kumar@amd.com>
Subject: [PATCH] test/py: spi: prevent overwriting relocation memory
Date: Tue, 29 Oct 2024 17:17:09 +0530
Message-ID: <20241029114709.3983243-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b8c505-14e2-4aaa-eba6-08dcf80f747e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dzkReTQGgPXxbcyLD3CiDDwj1eSmhhvPpQwn30Mb/px6AWE9CRhQYKR4hGoI?=
 =?us-ascii?Q?zOIhalXujCJqXkrAmj0zxHlPgTNlOU+bME/9R850eXzGYzgHifyprqX93Dkz?=
 =?us-ascii?Q?n1L9E98je1g13fBjhELc6//bxDoFpEWwH7dbbKWNggah8yA5wolkFj0cbQ41?=
 =?us-ascii?Q?P6xx17MOgogh9/h7XH8Ir2t7zbKIUo93gJap/QA5S1LwNVlmvbEBIoz/kV6R?=
 =?us-ascii?Q?sbrbWisSNLwfyPLKlhwEkul8T8alkVnjwI86Z2cUWZRNjwfN5VZAaWaees45?=
 =?us-ascii?Q?ENCvGUPCTXMjoZ5b9nC9kseoZOLdWs4DNIUU7ghVrh9NoJXRf/WszsvwlYvw?=
 =?us-ascii?Q?yCfhrv96VZIMXnLzrB6Ax1f8VWLLKklf4A81gw2MZG+x01+IfyNAZZC7Dxhr?=
 =?us-ascii?Q?SMLOE9m+HoQlUXCIAH3burQqJQ5SbbAb5/ReYOgj+NofcpNeU6L7g6iSKkqv?=
 =?us-ascii?Q?NK/KLWuu3gUH2ej7ENbCw2EFVvzRRoMNzV1UhFylmZG42IyaS0jZ56ZnbX2U?=
 =?us-ascii?Q?Z0GBOorOG3tIlGKvOh3uVQoghlBPrIm5eNwfXRhAKWPFLd46DnVtwOp82clf?=
 =?us-ascii?Q?3NOKywgnXABYLuhMYcydbeOaSQIWh0amIOTJn5aDjtaXDdZTiuTcXWESE6lU?=
 =?us-ascii?Q?y0QTxYT6jMiLURO5xBNFwnutQbzH9V/fFvk6EV/zQIMBeUDm00rCdaJdB2yS?=
 =?us-ascii?Q?rgDLULXwgNcGjBk+wHf+H02sXNO69PFfmndyJmCOxDLqfMgwa1bs4fwBCdzo?=
 =?us-ascii?Q?0OY8MrJM8qJ6tWHdODZcbxA7dDiuwEwSQbLOzpghZH1QM9AdAxhOi1aVQLt7?=
 =?us-ascii?Q?6G8aTAaXsA2FucIyXOyIdHCS9XpssU/bQ0GvSfSesxc94d2bDt9NK2IEwbCP?=
 =?us-ascii?Q?XkA789TvbLxoLMcpgkeg04TRkQGcy+q6s/pw74yT+Um4TiXSSUQYijaJZDno?=
 =?us-ascii?Q?kX4UVYTMAcfr4Qp7aG5sRz4OF2g8e/r/M4w5l34kDcAHi5lGrS0xQ56aX7CF?=
 =?us-ascii?Q?5wtUunV4wZIwNu616S5t4qeecU4O1CI/FMYhn3ivtiKDCOyXYpuK+SEsowcu?=
 =?us-ascii?Q?+gOJZ/g5LlNU8ilt1vFniGwfMOQFLAiCm8Prj0lkIxUmybUPY7Yg1RONRoWo?=
 =?us-ascii?Q?Q2ZjDtQXNLamW5IfIWK9dZ0jDclphDHyQtoGHDPv2QT62crIZ34XbR04cpbL?=
 =?us-ascii?Q?q5URex6xXl2ABWJXsFp8mqm6/SpOvmZPz1dMvefyM0hS65/KJaUvCVj03x4t?=
 =?us-ascii?Q?Sjpie2wXXptcrg+ZCafqUjyq47SQ5W+23JT/I8CbgOVBPJCOswwqZlu2fcI7?=
 =?us-ascii?Q?B79WbP+eDAAXN+MjX1n50idSfJ8pv30jQDJ7kjYN+i5mPFE2kiRlOahnCkC7?=
 =?us-ascii?Q?qcnqThdWFC4P/j/4AzP2DdUOh2Z8jjTcBudrmIJS7WnJUB9/Dg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 11:47:24.0878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b8c505-14e2-4aaa-eba6-08dcf80f747e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760
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

Update spi negative test case to prevent SF command
from overwriting relocation memory area.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 test/py/tests/test_spi.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
index 3160d58540..caca930327 100644
--- a/test/py/tests/test_spi.py
+++ b/test/py/tests/test_spi.py
@@ -693,4 +693,16 @@ def test_spi_negative(u_boot_console):
             u_boot_console, 'read', offset, size, addr, 1, error_msg, EXPECTED_READ
         )
 
+        # Read to relocation address
+        output = u_boot_console.run_command('bdinfo')
+        m = re.search('relocaddr\s*= (.+)', output)
+        res_area = int(m.group(1), 16)
+
+        start = 0
+        size = 0x2000
+        error_msg = 'ERROR: trying to overwrite reserved memory'
+        flash_ops(
+            u_boot_console, 'read', start, size, res_area, 1, error_msg, EXPECTED_READ
+        )
+
         i = i + 1
-- 
2.25.1

