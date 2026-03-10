Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82005FD2D77
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 929D683FF5;
	Tue, 10 Mar 2026 14:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tdqB4yM2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 392AB83F6D; Tue, 10 Mar 2026 11:06:37 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5968A83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 11:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-kaur@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqDiR3BJLKe3DAS1oiWiSXpTjKkb6evKrq0ZUx/zl0O7CTb+RsqVTam/12ir6mgkV+xft2uMQ4DPiC83e12uQFrbgMkAMYYhcCSmnTa7bU7+N+1fuUyKO2cAXVZWxvAnX3aY/IzWlXwYmqylfz1piOCFYlrGwzKUVZQvL0oa2CoG6HPeoU+/FONl/BCmwqnSJO/+XxHzPkbnEMHHqxGCTt/dFkcD99aGKGt30MZFPSiOnLvAxbTVqE8ZPF7OjFPxvw8xlXmgR/FQ+WbUrAwGUks+j3N8KX0YEzvtFuLdM7YDgOSvkvobZrHLVDjEZuQtkN2pL92pC2ddEdkXw6/h7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3jE6m4ADKKb/bWFs8wQ49mryXHXlr+NcQB6A/ipbto=;
 b=cCsw/+x7lGdRP8depwthnvAa2ERL1NaCvR38e5l56waUqEDXYO4fszmxiLxCRYKjJ3TyfbZfhjUvh7aid6pvwpHdVTAIJ9EJnHsPt2N17oyZQO49F7G2OLLcI7nKZHTqjudwVWI+oNuTKdmSAcNTrY+bhhNv8e52nKiMmBxJYZ5jL5/IibTanzEPpG+5CRU01rBSKMoDt6mAMF2p5SPyALmPlCqzxLKF4pzY4WeMn/VbAcuF5dAjf3WeNdS/MT2x1vUX8OwRWPPaPbpul8jl0fsqX266mHy4mickXED333Y3RcbQmYKfqxN0964MtiufiyaKs7uOUvCuSLEiH8vKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3jE6m4ADKKb/bWFs8wQ49mryXHXlr+NcQB6A/ipbto=;
 b=tdqB4yM2Nk49/Hv+EY3gQj7w1oXwurUKldJ00lRNb7ZhsK4CShAxj/tah43oJzYcqly2LcGCmPg5iDK9XLq5xuh7nb2fVPFUfSrvm27T+CH71xBxUnl/NcODz1TiUl3oszGylyqr8dQ9NJTLHcvJ+/R2tzMJPz0LpmsGNhNo9mc=
Received: from MN0P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::21)
 by CO1PR10MB4594.namprd10.prod.outlook.com (2603:10b6:303:9a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 10:06:31 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::7e) by MN0P223CA0008.outlook.office365.com
 (2603:10b6:208:52b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 10:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 10:06:30 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 05:06:30 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 05:06:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 05:06:30 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com
 (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62AA6Hr22355078;
 Tue, 10 Mar 2026 05:06:27 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <msp@baylibre.com>
CC: <u-boot@lists.denx.de>, <vishalm@ti.com>, <sebin.francis@ti.com>,
 <d-gole@ti.com>, <k-willis@ti.com>
Subject: [PATCH v2 2/4] mach-k3: am62xx-lpm: Add 32kHz LFOSC enable function
 declaration
Date: Tue, 10 Mar 2026 15:36:12 +0530
Message-ID: <20260310100614.951573-3-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310100614.951573-1-a-kaur@ti.com>
References: <20260310100614.951573-1-a-kaur@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|CO1PR10MB4594:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc03797-dce7-45e8-1753-08de7e8cb3ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: 8YMgjtMcHVsJniPFNfofoZCsibEob8mMTcPz3Yq2SgFJqxqx6p5DHxj9PAJEKtGjNn9k0d7oa73IjiNP9z7ei2EzDkJoEXDQUGhE0wrrIgk30wEr8UqXMwknmiBOr4h/giq89lwqwL7RQbgsVoaTyGXfXFxwHdz0m39Oo6U6V0Udv+m48Z8ZVnztTxZQh6AzhvP33Avbr9kd98BhmSJ0nYld1OSXNkXBVd8ovFRNUGKRs9BozPq+wzbbixXzpsN83BY8OmA2/An2ycQUud+WRTVeYGeEIxkbwuAJLLz/u5NtC4JgKzeEJc8f8tzzJDIG65f/vOxI5rUdc1SZUB9pcjHZyo6yVAwv8YodHRFtEOl25ZzwAstSMwrdJ9F19gkl3fz6/ec3hs/fD3LGFkbsSMHcP0ovgXX4dBKj9+HGQN++qYy/pyMFbrEIacrvJCDYAHXz18PVLQZoGlRPj48/wuew+p4KOw43CLQM3/Bhu24GBQKOxIUYsO7fsTH/sqEMyz0UKsi5ApqQ9ulCLXNYpMmjDDnSB9oR3P4LFEpk8RrZ8Jo2qkNW1loJC3KB+uDEkkZVi5KBRUg5WGX3+krseUNVKYvF3QtVge0fzLarC683sFCd0URrdAFavjpYYMgdYWK9HvxzgpHcTRPpQJEE5USXDLSGY26Jpf3tyohDTcTAZLBwT/Hf+RHGSojEsFkVFDEWBYXlbRk06tLbKHbuhMH7lcezJQt6bWmTaMmxc8XSc1jUYwT78F/QI5tIcovY9oSCPTQ4Ko+sz2f3vNnu3A==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W5M05c/7qKO5DY1ZtajLgNubxaDCTSdxtWkmIPYehotI/VAT8JbHmA+iM9pQHwyM5quYTEtSZIfLq9dxsGlrL3ni73qmkflMw5884Txn07fk8E2NxZW2InEYeGYrS9eYPF6PeG3fs4FlfInEaWnc0PuBMdHL0A1i0OxYUFkt7Nj4sS1WbOqo7Il7HzDKINjmF0g/JZd+uqrKldRlNgwWJOvHToCw5QbIpzrvoeqCai2nLVAt8MT1kHwWbxRztOpWpVyxcIJ+WQo/a1LBBibltJzvP7a7Yr6wE+rnLW6jzMhHIzD401BG/4gOR993xm+s3BtK7+Tm9BKGGmjrK4sUZ+ZpMgOg19Rb8iXykjA6W43+ylGVSIV6EOAOwqsO46kmlPkljfIkvs8okfDQvRMymrcQB2Lcl+8pCRTb9lDXZkF0UnOeb/x5N4n9LNOq9gYR
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 10:06:30.7442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc03797-dce7-45e8-1753-08de7e8cb3ba
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4594
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:02 +0100
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

Add enable_32k_lfosc() function declaration to am62xx-lpm-common.h
to support enabling the 32kHz low-frequency oscillator during
IO+DDR low power mode resume.

The 32kHz clock is required by the RTC to maintain timekeeping and
generate wakeup events during deep sleep on SoCs with external
32.768kHz crystal oscillators.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 arch/arm/mach-k3/am62xx-lpm-common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-k3/am62xx-lpm-common.h b/arch/arm/mach-k3/am62xx-lpm-common.h
index 741e3ccbcbd..9eb3ab99200 100644
--- a/arch/arm/mach-k3/am62xx-lpm-common.h
+++ b/arch/arm/mach-k3/am62xx-lpm-common.h
@@ -15,5 +15,6 @@ bool wkup_ctrl_is_lpm_exit(void);
 int wkup_ctrl_remove_can_io_isolation_if_set(void);
 int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr);
 void lpm_resume_from_ddr(u64 meta_data_addr);
+void enable_32k_lfosc(void);
 
 #endif  /* _AM62XX_LPM_COMMON_H_ */
-- 
2.34.1

