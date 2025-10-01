Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A411CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 06:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8958800B1;
	Wed,  1 Oct 2025 08:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l8vfTEPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DD97807C0; Wed,  1 Oct 2025 08:20:35 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3780B8004F
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 08:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6Cx9ukd9A4AIQEri1RY8MxNYUWXs6zZ2ExpfecjhAao0pq0ms1Qoa17flGZ48yGz0ULPeZZ9NNDsekBRsm65i9nHTSp3vUpjx+m5dDI9NCO/4X5YwC7RCkPKUlbtU+maaAL7zNNiKaOcaum6qxutVMFOZ5SCDXrXlJdTGmzQtCb3fJ2Wols1kXqMG7UOubE+MZAvZoARbNz8DHjbxjkhochMZ+6koifT0ANqQcO+8XScUqLy2+fLXqXTESpNpyx4beHi92zKg0PMB8RyQn8mG2LmlbKOOIrq67WbBNIWx5Igg/J21Zns2vAGcZyHPcxuTozsvrNeaO2kSAJ24hT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NumZIPzkg8dh6U0h+to/gE/exYez3uBQ6BrKFzulaGw=;
 b=eWqK8xs/noA0dlGmYoX9xQHkWHDAa7nYpGjsvaQuO19flgBvUUKmESfdwI4V2YyjvU2HYvZf6cPqHGvVj+hjydU0P7bzNQG4q1nOyqG/kC6umsewmC3Fm85YFppH4cfF5wCUio+dRMVl2MFT6uG6jGDtUCkvll3tRvVKYbzy5OoOAjuWmnsPMr5vLhwnKr0Iga5FfWtrLORyMz27BuhnZhl/7tRln68e1R89E4Yf995Tu1RiVCY+cggn7IuR+H9Chuwcvo5c4hYLhZ838PI8KM/40GHBJC/I27K+Kyjps/yEUZBYRwx4ZszL3b/1zAJJJfNVJQ9zyOABrzylaefsag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NumZIPzkg8dh6U0h+to/gE/exYez3uBQ6BrKFzulaGw=;
 b=l8vfTEPbQ3kf3/CCAonTS3U5NDdZ0nJBavkC45JLNbXIuzkgQ5RYFoxR8fVgdt40ScyWjhXwuUpAi4g//TkgUn0zejZAbchTn7aJX6T9fWZwzKcPXC6aHDDFt3a4XnRlOl9JWoxgoDaxqqZoI9njOxYA4z8xUH+pBgWxUmY1KcU=
Received: from SJ0PR05CA0093.namprd05.prod.outlook.com (2603:10b6:a03:334::8)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 06:20:29 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::90) by SJ0PR05CA0093.outlook.office365.com
 (2603:10b6:a03:334::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.13 via Frontend Transport; Wed,
 1 Oct 2025 06:20:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 06:20:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 23:20:16 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 23:20:15 -0700
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 30 Sep 2025 23:20:15 -0700
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <fabrice.gasnier@foss.st.com>,
 Marek Vasut <marex@denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Lukasz Czechowski
 <lukasz.czechowski@thaumatec.com>, Padmarao Begari <padmarao.begari@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v3] usb: onboard-hub: Make i2c-bus option
Date: Wed, 1 Oct 2025 08:20:07 +0200
Message-ID: <8d5ce6f2bf23e1bed12f4929745b0189df8e2f3c.1759299606.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=RFvEw+HN2+5abWABKS3+2hiWKTpTc4leK+8zDxsjjdk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTcOSGp/O/M88NSPBfWiTzUNVps9Vroyc+rX1+fYGLzC
 +mN4pTl7ChlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJhKoz/JVjzC6QU850z/fN
 +O26TDa9jfvwFN+GR1lid57OucUbP5OR4c3p7xMuvnvvzL00l/GBVvXc6o5r6nu/6ukWdtqu/XH
 LhBkA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f6ff95-f7f3-4c65-cd3d-08de00b29de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xRh6GbSar3/fVCbafJQRBtgcq0QKW3iwHRYx/W155pZViLzC7ci/nOwDQHHI?=
 =?us-ascii?Q?CbhR6bkncZLaFQNvx0OZRy9ZQsaIwE6iuj6AOFQnn6KLvvqsYuAULRaUl8bv?=
 =?us-ascii?Q?jU5/lJIFwXKEVunuYnuHLcaZcId0qYLdn/FrTednEevT5/Z9vflGKw9vtVsQ?=
 =?us-ascii?Q?8n4kgt8oLxs6nsgOHBnej/35HZRGyEsxKfaxgG0ZQKxrJfuMczPZquGMDYUH?=
 =?us-ascii?Q?1l5/+PQx59suSePhShUtLsnUIQMfrqnaHlmBLLmj+084RB8zuiSeJBefIz/M?=
 =?us-ascii?Q?ssj7356p6zlbxTBPNCiNlD3IjeWREVLKNhGaYDOx6meErDbEc1wbjlqILOY8?=
 =?us-ascii?Q?g0uX/BextVRaoOfGlLfyDCgwQaQKVq8YIIr85zxN4lG9/TY/wY6o9TLoK2Uy?=
 =?us-ascii?Q?l0q4nmvOreouTmdSRwGJJzcQdPfxhusONhxfgaEpRCxRwHClRXPaU6sipJQP?=
 =?us-ascii?Q?fjAtDhY1bB9lPTyWWkZta5xGGmt5zhhMZRRRMiYECBPa8KNE62DD6rb/imVI?=
 =?us-ascii?Q?+EvQi67zLOu//Gkb3Mjiha2Q5K0Zt52pKBK3d51gRE2aNic6n44a5Zoq5wmP?=
 =?us-ascii?Q?mpw7sV/m7a6SQGg3EPhA0ROam/3ZP7ludLkTlYuf3Hwqb78Za9h3N95ja2fq?=
 =?us-ascii?Q?7gnOJUrx20GduuIdt5AwauuTBSYfReVRIKCfP4OTLsofIOThoaBFiMFTUAKi?=
 =?us-ascii?Q?Gn82D6Us8QvzXqsSH0VFYjwmQU3khq49qWIBPHzMV99CfI+qtHl8ZbFDyL6C?=
 =?us-ascii?Q?yakKN9B/zolQ7ody25ruvrwIJ2fCXxXL1DexNSFVM504ZGIbUwu5CyTJeMa5?=
 =?us-ascii?Q?B3ZjhpglNmzwunyXm/FZdjYkc8VgbwCfYT9JjlS+bm1bVyucP/wyQx856o84?=
 =?us-ascii?Q?Ax/g3qr7njPEE/tSrHswec/KS7P8jtqP/MgZ1odi3r7jgMz8XZ9J4ldEZhOr?=
 =?us-ascii?Q?jpxdedg9OFz7Bq8P5sD1w7dmvDCdwrsPcACIWNkeQ7tXivAP8lWacFRBofbA?=
 =?us-ascii?Q?39VGpdL9CMemlob71skLVoKHBP0wgchm/mewMJj+/wbrLh4SiT8gXkzjDKHa?=
 =?us-ascii?Q?FfcCrvFq4jpDe95w1CxiRTH6b619kg9soNY0EwP/9jahxvYlGubu1AetCf3Q?=
 =?us-ascii?Q?Z5GvhBhQ+ez9PXxZAav2GMoZ6EVHB6jfFnxry4O14hzTmAw9k6FQPOh8OR3+?=
 =?us-ascii?Q?wMID4Ceau0hAVLVWI/Ok+h12Z9cgAqS9zFWJFyU4EyysSi4a58/8VTJMwaW8?=
 =?us-ascii?Q?CC9CEtItoZhGgeJfSJuelDdYY/6jq7bAe1yVyG0qKqeAdKnh5jnq1JW9cxp4?=
 =?us-ascii?Q?0lc/rZc9vcGh2bT5WcJbksof7oUaLDTNM6c0FIPEed8QuFxJcdG+PcwrjEbW?=
 =?us-ascii?Q?ZOpJ2fQ3ZTzDPAukYIjAJ5NIi43GBh5XE0irW8mBAgAEjyKM0Afr+CTJZ8b/?=
 =?us-ascii?Q?m8CPUJHWNVsFgwyLUsUyHCTottTG1oYZmTrLWXfVxOBSKvbcfQNz7ChD8vye?=
 =?us-ascii?Q?oT2RwzGSdq1c/HK5ODChqVAUYVRc4+cg2WWcGQ/QEE08OyIwXFfRoeUrxmCS?=
 =?us-ascii?Q?jlOqtlluRwMkMflNOgQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 06:20:28.5271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f6ff95-f7f3-4c65-cd3d-08de00b29de8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261
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

DT binding doesn't mandate i2c-bus as required property because hub itself
doesn't need to have i2c connected.
It can be in standalone mode that only power regulator and reset should be
handled.
Or hub should be configured via spi interface.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
---

Changes in v3:
- Add Marek's line

Changes in v2:
- Handle -ENOENT separately

 common/usb_onboard_hub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 70fa349a8817..b265321c42ef 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -61,8 +61,13 @@ static int usb5744_i2c_init(struct udevice *dev)
 	int ret, slave_addr;
 
 	ret = dev_read_phandle_with_args(dev, "i2c-bus", NULL, 0, 0, &phandle);
+	if (ret == -ENOENT) {
+		dev_dbg(dev, "i2c-bus not specified\n");
+		return 0;
+	}
+
 	if (ret) {
-		dev_err(dev, "i2c-bus not specified\n");
+		dev_err(dev, "i2c-bus read failed\n");
 		return ret;
 	}
 
-- 
2.43.0

base-commit: fd2f6b70cc7564bdba47241353dbfdee775c9f72
