Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CD8C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 10:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C17183046;
	Mon,  7 Jul 2025 12:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tpbLSMAi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D9C7830CA; Mon,  7 Jul 2025 12:39:37 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72C1E83043
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 12:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbnI/YeiMMZK/vK44uYEPQg1l8s6T7Z55jglodITk5iuwy2aPI28AV8/tTZqwQ2S9f0yeGcEOFNpEII9z8aEagNvVgl7s+ic218TEPS0hSYt5xdYvFfQy0TN0nCfK1cjf9xgO5HSTQ8hy2LvrpFpmC5Lk59CrUKwToHpQWcFUbQNBo9KOBBMaiYifW96XTwIuwRHDLnw6dt3rfa8a8FB2SJs+GG7KrKoKVBuE0Xznpj0fGPXXb3kwWpatR4wntVM62fJprXxRjsEC+xMk8T/vMOg7PqrFQFX6qG3N0uVr60ye5rRQFYtAcpMMmRFgEEfdkAa5vGUgcBBLCCIzHJBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41gvtpO6gNM5Up9u5jqD9VP4TGtkUsE8ASo6cM7Ci4E=;
 b=PxOH0ReoVxVBtWdqFH+HK84fg9nIYunY/n7im/EDKWnoP677jZbmRVgdZC7E5HpHksuyukvTHBD8wDFrcZIeMaWnVkYHAJ6GxDAknkLtAPubzBtHOkgQ617I2xQZa36dNDTM0bola9siq7l2nmFVf/K06cMSAWayKttvDhjF0s4+zz3g7y5twwSfSx+qhoCwOKI3xRghNNJ/gnnvc7nWQStJ/m/Zyd7bdsVo6cdM2rQ21BPPEDc60FQVmEKdz1LJMXQaqrLWGkCRq+BuEu3blSkYlo+e9eCElCmlcc7NrDQAZ0oPZq7F0y+kPeIkmENXefTBBqTsnq2jUSTsyesXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41gvtpO6gNM5Up9u5jqD9VP4TGtkUsE8ASo6cM7Ci4E=;
 b=tpbLSMAiqGVP7d/H/sbsaUu7+ViaSdwr/kCUeFzmwync0+oaJnbmR8o0o+pJ5MlRf4c98kGP4SmOwsLvMFtNs1/+cDT3Vyvzf8fADD7YonJClgOGQ0DTqZcSxDlysq9GU7EUSFTHhiGPvCjNQ5SJHmd6FzofZVK7ugwxTZU3cPo=
Received: from CH2PR12CA0006.namprd12.prod.outlook.com (2603:10b6:610:57::16)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 10:39:31 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::82) by CH2PR12CA0006.outlook.office365.com
 (2603:10b6:610:57::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 10:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 10:39:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 05:39:28 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Jul 2025 05:39:26 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v2 1/2] FWU: Add platform hook support for fwu metata
Date: Mon, 7 Jul 2025 16:09:17 +0530
Message-ID: <20250707103918.4189148-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250707103918.4189148-1-padmarao.begari@amd.com>
References: <20250707103918.4189148-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 287e5025-248e-4c1f-d438-08ddbd428e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?USEf+YqArWkzqJgF0nvM6xjqh0LmiA0vMTO2G9cSgWPY7Pe7W1mQqN0FYIVn?=
 =?us-ascii?Q?7TPcRJuEEhC/+p4xWa2b6qOI6DVcQYprn3kGBnPui93Lg0y9C3Uc+42x9qZS?=
 =?us-ascii?Q?6nXHT1MBNpShU/ySmKbHhZHYJMdkqv3MvMIs0rEz2US6pS46SIsf0wvaEcG5?=
 =?us-ascii?Q?PFKoPW/cIO91fe2r+63wbn3fNZYsCdqx/0zI2I3TBsy9VvtkOCjv4bnGnnur?=
 =?us-ascii?Q?P9JVbPgdNsiooeTkstOZiPjmH6jmJ9FikgZNTUCnAoqNJXz6o/lrcw04La8a?=
 =?us-ascii?Q?SMWRX7QsvYc6X6Gxb0l2Jhw1RhxJCaa6egwaZd2bpU6Yfj8oCdmFOc2rqe2Q?=
 =?us-ascii?Q?RIpJY3YcbaolVE9SzL7hUyGpfxbv6QG7sn/BTZ2F7fFPUgQM5ocZe25Zlfyp?=
 =?us-ascii?Q?u6F4wE1quBlOOqfOJRnUN2FeFvRODn8o9/7MUZGpuF/hRNTeFAjV19qElnEV?=
 =?us-ascii?Q?sCi2T7wdWWkMZZmyEkHJnNziN6tHalLBPyztnoPsAsIHqPe13gSmDqgerikS?=
 =?us-ascii?Q?QjMV9LXykVsl2OofFdLAggqNL2xRXWrAdviT8xaH0YHwGdxgHuQEezo6Sj02?=
 =?us-ascii?Q?mi4CURaXqYLJB/n6VtA8RWkI0DxYfF8hvbU9Mg+1jMUlfLLH4bP1U7ZX5yPY?=
 =?us-ascii?Q?iQanxEXtg5Xi+ZsUuNN8hY/+r+NljpBydNnskxa8TPZuZ1MmVG7RiXuClvXG?=
 =?us-ascii?Q?MvLLsdcEBgLlRNnzkGdfjPrxTiWp+YRNKnHjGrc3M+n/zc/QznQb+OyFOvo0?=
 =?us-ascii?Q?1KP0qnLfkCXEviqHSkpL32DtXz/ZaCo7Njubx7y4yq6cu4OXhZ1Mvec6KN06?=
 =?us-ascii?Q?+ock0sbBKulCPA/dmYR92HFh2s67yp002w3+EOI8Dl+JYL/UQt5enmzyxwFJ?=
 =?us-ascii?Q?OCrwj9YF62zfOWpNdl7qAMfRwMS78C13k4cdeHd83GqdBqDkeD0gd6xaZizh?=
 =?us-ascii?Q?lCrtVkZRvIb9dJwHY7Gw2NxVAO1mkizGc1+1rQn2aNz0AHaY1sfNbu+NtjJ2?=
 =?us-ascii?Q?k96gfg0F8AoIc6eyEZSiJv7IqViqzJOogR5VgYLykfLY97pINHHEv04CMf3b?=
 =?us-ascii?Q?Nw6f9K5s0rK0AoVwHYgBJw6WU9+pM3VOvVQVV9uGtgUognq2v7KSbOwm83M/?=
 =?us-ascii?Q?3Z4pEikXn+FoHqzuk2trLY4kXsW8AxO7tV1DDUXyZ02YZl54WBmGmkIDP65U?=
 =?us-ascii?Q?RcfAt6n7vNKGoFKEh24SakjWygfP4+i9yas8Xk+2jYv2BNXIEssuYZBSh8gv?=
 =?us-ascii?Q?2j3+btKZsqFLSILBx+uvto3ixzAGrIKmwav/gJvZQ/Ce6ihaDPtFulrVlgOe?=
 =?us-ascii?Q?zKyeXVmjDrEPohbEqL+ZkYE/2QSZFJp11rFIDceX8iNjKZHTvH3RvU9T77Gn?=
 =?us-ascii?Q?Fj/TcwqFav340vEyV9Mack6cIqgPxqc6KkJiJeJ14QO7mwwUjjUYKPYLRwiA?=
 =?us-ascii?Q?2u8ze9J0TQ1BlTGkTJpdE6Pmb1yzF57Syli/yCnA7+CJu5A1hOYc6XAs3YzY?=
 =?us-ascii?Q?sA5eNT+zOzfFkx/KCFohctf124f1y835sfKJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 10:39:30.9712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 287e5025-248e-4c1f-d438-08ddbd428e5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
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

FWU metadata information is unavailable for platform-specific
operations since FWU initialization has not yet occurred.
The initialization function is invoked as part of the main
loop event. To address this, the FWU platform hook function
is introduced during FWU initialization, allowing metadata
processing with platform-specific operations.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 include/fwu.h         | 11 +++++++++++
 lib/fwu_updates/fwu.c | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/fwu.h b/include/fwu.h
index 6441de370c9..8d0b856cc81 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -129,6 +129,17 @@ int fwu_read_mdata(struct udevice *dev, struct fwu_mdata *mdata,
 int fwu_write_mdata(struct udevice *dev, struct fwu_mdata *mdata,
 		    bool primary, uint32_t size);
 
+/**
+ * fwu_platform_hook() - Hook the given FWU data copy
+ * @dev: FWU metadata device
+ * @data: FWU metadata
+ *
+ * It is a platform-specific function that processes fwu metadata.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_platform_hook(struct udevice *dev, struct fwu_data *data);
+
 /**
  * fwu_get_mdata() - Read, verify and return the FWU metadata
  *
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 7f085a0211f..9e913a04ed4 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -655,6 +655,16 @@ __weak void fwu_plat_get_bootidx(uint *boot_idx)
 		*boot_idx = 0; /* Dummy value */
 }
 
+/**
+ * fwu_platform_hook() - Hook the given FWU data copy
+ *
+ * Return: 0 if OK, -ve on error
+ */
+__weak int fwu_platform_hook(struct udevice *dev, struct fwu_data *data)
+{
+	return 0;
+}
+
 /**
  * fwu_update_checks_pass() - Check if FWU update can be done
  *
@@ -712,6 +722,7 @@ static int fwu_boottime_checks(void)
 {
 	int ret;
 	u32 boot_idx, active_idx;
+	struct fwu_data *data;
 
 	ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
 	if (ret) {
@@ -770,6 +781,13 @@ static int fwu_boottime_checks(void)
 	if (!ret)
 		boottime_check = 1;
 
+	data = fwu_get_data();
+	ret = fwu_platform_hook(g_dev, data);
+	if (ret && ret != -ENOSYS) {
+		log_err("fwu_platform_hook() failed\n");
+		return ret;
+	}
+
 	return 0;
 }
 EVENT_SPY_SIMPLE(EVT_MAIN_LOOP, fwu_boottime_checks);
-- 
2.25.1

