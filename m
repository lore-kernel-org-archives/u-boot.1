Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7592AFC5937
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 12:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20C5C83E83;
	Thu, 26 Feb 2026 13:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KDFDqZR1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E7A983642; Thu, 26 Feb 2026 13:08:45 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B92483642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 13:08:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bETKYIDAMD40auWr9DGpskfuSP9b1ctY9vxpqlxF9h51aPqZ2waqx+ZocWCZSt1pQBF8VAlaUTjjgMHRF1k8vV2+add4YE3ovEhubxDUF0+kHWotSZVFL1aE94b6aXKHzZAZocT2Bb9zhM2bTWpMmSHKaAwbBoUrVqFIje51Xywbeals/7o18byufO5mut+JK8vpoXYyAPxaTONSIBj/dXGc1f4Wtk8EE6y6sBAnV0f4/FhQvXzk8kKYTNaXa8WZi+/NW3cWU0T+4CQORPusIRq/f2VKDymdtQTwo/9jVe0BAABO0tMEsF9b8ET1lgn+EUblt2f17mi5Gj6BmxjRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPJAC+wkfn5GXpi+MzGwCtE7M/IXH3k2DtwyyTZdYJ0=;
 b=erQ5oXRapzpa5S/6CGm4b55yiqEprU1VOY01/Lj1f15nSUun2P5eSBlBQO9u5U2p8hOaUVrjra7bgWW7aNaqKVqVZuVIDDwbR5X61jM1BJN/0onsCFRk3pOMMfL14434mItrIfkTy+HwKdVw3CsCNwA3Ej1FwhLIR838rDP8I6nUoO3CJIdBCyts95AMEFz+oQneaGEHc5TjQJKNpUr78NfTIRiSNN+GdJDbbI1c6NC9c4TPywL37Hx5B8wSxAa+BL6PAPQyqJUQra2h7TtEmeIXjYVMp3XQTjo/JE6ooyIs+12KcLLHNvElS7wEfHOXxv8g6spE/kHnmhpmAMWZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPJAC+wkfn5GXpi+MzGwCtE7M/IXH3k2DtwyyTZdYJ0=;
 b=KDFDqZR1kAwRnlGgPnVxrGsWt9FjQi6QmIO2KhKgqnNjTyyDJg0NnHd9nisUDFPq6VGqAFYmF4CcGRfw+lJ0Ag6hSwu+CBocenzJQQGKE3ao3iDHxlRD+0r/3XAG4Pgwsu3lj/qr2BUZMp/OjaF3KKzGaG8q8HjJsMYJ/gV2oBE=
Received: from BN9PR03CA0703.namprd03.prod.outlook.com (2603:10b6:408:ef::18)
 by BY5PR10MB4275.namprd10.prod.outlook.com (2603:10b6:a03:210::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 12:08:37 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::78) by BN9PR03CA0703.outlook.office365.com
 (2603:10b6:408:ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 12:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Thu, 26 Feb 2026 12:08:35 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 06:08:33 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 06:08:33 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Feb 2026 06:08:33 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61QC8RJv2328866;
 Thu, 26 Feb 2026 06:08:30 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <bb@ti.com>, <reatmon@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>, 
 <gehariprasath@ti.com>, <s-k6@ti.com>, <n-francis@ti.com>
Subject: [PATCH 1/2] configs: k3_*: Add config fragments for enabling inline
 ECC and/or BIST
Date: Thu, 26 Feb 2026 17:38:26 +0530
Message-ID: <20260226120827.2258728-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226120827.2258728-1-n-francis@ti.com>
References: <20260226120827.2258728-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|BY5PR10MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ac61f4-335c-4854-d1e9-08de752fc4ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|34020700016|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: wSwm2iLz3bbEX138IYCgA2+mWRY8Mt0uV0uotws6sBn1DVsTDb6h4gxnYIPYCx0yorA8Mx1zRwQ2upmYPTjBBMgguLJLW+UGzQBdiXs4wtUWnzstDcbnHuJTstM757Z8iOSqbCPfD0Hdh+RMlpobW4oRA6pCQN9kGMX3o/Za7fxxoEkK9LKLPS73pGooyabHJEpM5sWxW7zLI6eG2TTNk4l6ClDqS16BZjEJyI6X0Y8SeKA0hN18d0zS3FSoSs4oRaatHFeyN5pW/A6G/wLrkdJNuoa0vYS98CvQaN8sweV81OZHOn/PQoveJkr1Ep4nMdEe1gtBl+nCZIcWUOek6e+Ih3tOERATPNcUBcFMfSldIGYvN80ff1FXqeJwDXVnNRs0+AhryLDoGOm1QKn3zRybvvWxouu0PSGD72c1gKtPNtVN7T6JYop6fQ00cuoqcH6Fp5YPEGPlXYH5ugyKn/NTHOR4MzaJa/0s/fHMxD8lhL7EIPgJ9Gdn4gPZBbEAXg0N+MhEapUH7mUXZLYUhrGdvtCruFnRU2pxBv79zOVaW4C9T+wpnUrZiI+nLbinf00QV3zE+eJQ1638UXAEMRo4Dox3JFEiHWVIRPkLrmWnT5zcMpEFYnT2nQAcXRdgyE6jQbydbso7OqNl3SlD98IQpe2D+dQSAeM5V5psUh1vluytQ+R8ph8/5xDFHE/g3dvXXuHJrQOSTpe+uFkb/eL4FFyeBI7ZNR5/h6ItRRbvFaWNUMv3ImJdqs9uJHd+4GmubiI+xcJ14J1d6jzOGQtpYHm0HeXoVt4+AAmZterJmVulQh20TxcIxfNJoVasXXnWXW8SDnX0xFt0/BoOrQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(34020700016)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ieaHTbcO20Pp0CQ6MFWxVw6fUKXWEe2UyhiUcw2z/OFMBEV/gKy9LPw194OSvY9hS1m7/cgHLmV2LWWCYoH1Yp5cOEOQyKOl7hibRtY04kcw5GwbEKDeJn1lZGur0ehh1UxDQVngqBZUK+zb4M7Y6jqQ/6xrnAKbEyECje31EPMEKz5j77mt0rIWdnhMgm/3eiW9Nod3FFisEVDRNPtvKM+T/5RwpO4AuZ9I5Nx0gaaSPspyBYibTo1a5h18tz3mJ+S5JBdSmYKcjk000m167v2dKhmu9FN946HEr6WToiD5huij+rS4bQl/AcYx6WTY8Z0D8tZBZD+lmSzoU4YCk+SMBAdZYKbOH3PgI8Atw7jSWHbHNMbn4uisifWGirIym9A3OHcf+xF+hTj2s2wm6hJ+VwnLiUwb/FXKn/vCtQYQsU/4sPm3r0yluTD+BwFU
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 12:08:35.9930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ac61f4-335c-4854-d1e9-08de752fc4ef
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4275
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

Add config fragment support for enabling inline ECC and/or BIST on TI K3
supported platforms.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Changes since v1:
- move from configs/ to board/ti/common

 board/ti/common/k3_bist.config       | 1 +
 board/ti/common/k3_inline_ecc.config | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 board/ti/common/k3_bist.config
 create mode 100644 board/ti/common/k3_inline_ecc.config

diff --git a/board/ti/common/k3_bist.config b/board/ti/common/k3_bist.config
new file mode 100644
index 00000000000..671dda1a9dc
--- /dev/null
+++ b/board/ti/common/k3_bist.config
@@ -0,0 +1 @@
+CONFIG_K3_BIST=y
diff --git a/board/ti/common/k3_inline_ecc.config b/board/ti/common/k3_inline_ecc.config
new file mode 100644
index 00000000000..143c814b41c
--- /dev/null
+++ b/board/ti/common/k3_inline_ecc.config
@@ -0,0 +1 @@
+CONFIG_K3_INLINE_ECC=y
-- 
2.34.1

