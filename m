Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE56BF8D761
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 17:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 246A88407E;
	Thu, 16 Apr 2026 19:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dZ2kWLHZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A13FB83EEF; Thu, 16 Apr 2026 19:32:51 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB74F83EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 19:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyfPZ/lpbzG7BUrm4jr1SUfSPNjsWzkzgrz7zmwqN6BPx86BW+elNjg2TdSndTzSmXd1WFIkgMblg0/wr78BMdCdIo9tJ8iyUEF89OuTbtxubFGrbj4DwKNiBlOTPKmsxysKY9FGCpDCVB1WIby+vfkGZUbCPQvZUow9uz6+GrpJ2hGz0NDdACkkv6LX7UkjTQJXEY1DnV5wGaRCgKaK93J5tAVFN5JQ0idwGKNMXmxolnr6XDKurI6X7MMGj1vGlLsGlryaqBBvq8doMEAenwBntI5CJ0P0JooVafVtE9vh+Zk7Ck2hYXhloQvMif3+2FFrYsl7haCwhe6nOPlm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zw1y39u74pqLbDUmAdduOKpvqh1TeLJeH5/hTwlFJt0=;
 b=K0ErMT7WUb7m3RM3D8Lz7fqo2bbBAeFxxP/M2oUIP2ipPrb9QENq3BY6HFf+wrh03rquvkS3pT0oapn4hr6OOXJBGsMe/kFn1pLe+OF6q55xFjojcQdTgCbBxz+sWY0Yuqbow8Wk/TjxBMFu6xlxvkXWEtMxzE0M4qQ7nTYYe5/W+Fo1pCDTG5NxL899SW335pQDpwoOHa6ehRIOLfStsnaRlxHNvy/VcyQgtBTHoMA0Gd/V4G2DocNJDcZcax+w7360dlfMNVqpdVeSeR0xPwKgxwwjUZA0sgeoNygo3oKLk+5LKj33AeXFPZhh8HsClRVe+svto/Li3gOMmhSTow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw1y39u74pqLbDUmAdduOKpvqh1TeLJeH5/hTwlFJt0=;
 b=dZ2kWLHZZ5h+YqnH+q3QMO1+OpC79l0LrE8q7YW0VktirBrfI8Z5naLPkqs6sl4nHWINVoLB/ar52oZJVIZEZ68Sgu+qN0DGU2RGcGPdcRVXgsYmE4UxBX24FTx13zjopoH0u+b7ngyodyQ52INPb3QacRNkmDubv/77rtyQ2Zk=
Received: from PH8PR07CA0026.namprd07.prod.outlook.com (2603:10b6:510:2cf::21)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 17:32:37 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:2cf:cafe::ab) by PH8PR07CA0026.outlook.office365.com
 (2603:10b6:510:2cf::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 17:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Thu, 16 Apr 2026 17:32:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 16 Apr
 2026 12:32:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Apr
 2026 12:32:07 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 16 Apr 2026 12:32:07 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Pieter Van Trappen <pieter.van.trappen@cern.ch>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2] fpga: xilinx: Add option to skip bitstream ID check
Date: Thu, 16 Apr 2026 19:32:02 +0200
Message-ID: <d0f11d0a8d48b284683f00d20dfbe323c11f2943.1776360720.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Pn/XMlE8A80Y6lR5tnm6Ft9sYolmbltrWMEzc9u3CU0=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ+lBWZo+V7woLl6v0TDs/27YhbfeZM6EFT/Z/XKj2id
 Bm3NjFt7ihlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJcO9m+F9by6r6MDVU5kY/
 Q+21g5LvBLseXjH8+ZvB9+rPhi5NMzGG/66T2RZ9e2Da5b93Mg8L592UxQuU2J7EtszZ1z51oXL
 dGXYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: c361c651-11b3-4f96-1914-08de9bde26a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: aZzag8GjCd2dbnXoT1GLN7gJx3cN8QGvSrLWBgptdyR0Zc+/cmVUINnr5xj+pLcVgjZfPDvqeja/gjKMdcYjApEP1h+wod4U7WbiT0McVSfFm8e9Cfa9yTAEZUtgQikdfQBRVQrPUDyRmdX0wGegBAPHE3qSy4hpos2OkvUtg0KG6lLGYK+uNbeuMIDKyWiKBqAJEDBV/hXUinO34WUDj0o8DAvOCtGS/FyX+ExeYW0PsEC/IQaGt7d/uoHRDKH0lalghPfhZLvB+e2dyZzzlNHtdOEbmZQIXbB6oH5V1FN6PneYPrMdT5s0SqsIvZ/qfomBHzKL7THjdgTAphZudvJZMLSvkn7MJkcaBPeP+qiFrXtGzeuxJhvIn8HOjMbFWw5oTMU1PuEG4YATiRm/SBX1xIEVbt7iUUDj2d7jNL6VMLUCPRvZLi61PlrolFndNqQO7kzqhJWvymFWkq75RKNcdn+RYSQRPxAHv0m4ob+JPA9O8CJ6+E+zOFQlJpkbmCT9C52ex27wphTwQ3j7TEec2pZBHUe0sajKrdHDDSQ0mb/o2zIqMq2VVXg6QcF4suU0dXWnxEOP2EenQro0nuWPLXhLxecY9YSuTIBOy0GWQFB2sNsNGuW3i6uR+CxuTgqyZo87KJNnzN7FcE/av67wuM3bP9vw99WC6cI82PqHrrAppxokubBpxlvJH6G4oqK8CMoZG34Y9FBuhK+ENPIdyPajOnlW+/vu8M2dK/zSxHRqRgLcd63B5YkLpcR3HoVKVl03mIBVKtFdj6Sx4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wESQaM7+BsSqM3dVp7XA1GUa0IOnglLo7yj9WRwFvGeKITPqi3gUOYIl+EtzsL2wyp4whcJ2P6uahBLcKiNludcYOdZYUCdNHdRq/rUNIOazraq8e1DiFEe8M2VeApzmAPdhdN514fe8ROocjcWVQFWSR1uuNAykvXWCeLDr8DMuBUN0UFRyShjVC68sKmOcwPPKeuikHRqqeJTqSiBPB/gEt4SZ+5uwBxRdskIco7w0FxbGuAffCPiaNN1UYbjrnLXR6Z/BsIWRYEBCZ6zDkGj2zyikKXAeOsFmutX8bw2zcWZFq89K2k3oMQJ0ZzBu5p16zCTod+51YxM9sCnxrj5JHRL/q5+tTPd3jvgN8rEpX3B1yiAMpVfaJ752FtPDbcJZ2yA9wlhx7qzit7If5wKrojxJA6q42mPWpF/E527+UKaJdo9zFvJ5KKANfMni
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 17:32:36.5389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c361c651-11b3-4f96-1914-08de9bde26a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696
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

Add environment variable 'fpga_skip_idcheck' that when set to '1' or
'y' allows bypassing the device ID validation during bitstream loading.
This is useful for loading bitstreams on devices whose ID codes are not
yet recorded in the SOC driver.

Usage: setenv fpga_skip_idcheck 1
  fpga loadb 0 ${loadaddr} ${filesize}

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Cover SPL case too because of failing brcp150_defconfig in CI

 drivers/fpga/xilinx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/xilinx.c b/drivers/fpga/xilinx.c
index 25b348648eff..44d7ad6bd543 100644
--- a/drivers/fpga/xilinx.c
+++ b/drivers/fpga/xilinx.c
@@ -11,6 +11,7 @@
  *  Xilinx FPGA support
  */
 
+#include <env.h>
 #include <fpga.h>
 #include <log.h>
 #include <virtex2.h>
@@ -92,7 +93,11 @@ int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
 			       __func__);
 			printf("%s: Bitstream ID %s, current device ID %d/%s\n",
 			       __func__, dataptr, devnum, xdesc->name);
-			return FPGA_FAIL;
+			if (!CONFIG_IS_ENABLED(ENV_SUPPORT) ||
+			    env_get_yesno("fpga_skip_idcheck") != 1)
+				return FPGA_FAIL;
+
+			printf("%s: Skipping ID check\n", __func__);
 		}
 	} else {
 		printf("%s: Please fill correct device ID to xilinx_desc\n",
-- 
2.43.0

base-commit: 991c55451d54b330b2c05246cc7426748a2c3ad5
branch: debian-sent3
