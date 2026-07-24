Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF65C531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 05:19:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90DE260B2B;
	Fri, 24 Jul 2026 05:19:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eQv0reC2EC8u; Fri, 24 Jul 2026 05:19:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C7C860AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784870351;
	bh=PjZvtMir1gcL+Se/0cbxS09nXsbgSWS6s60Utz7zZqU=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OxtTIMygPF0QMSBLzhJ7wM6EANAKInp/rEB+1q8a7JTpTdIV/ao9T9EghEgk4eDDV
	 q4JvHUOO1oJiZ2ICG8weS6tE8GZqdLAGZyS9HSvzn9kmWsXStjg7hYfqjeWOxpItAb
	 oKI9DWQlbabbRxKeGu70a0rdBudO31hqZOJzsstNiaqYhC21xPrPSCEbuWtYd6bLuz
	 dt1XaM8+LomPhJNiIXsg66dUcobPm4TygdkqFnBGogWtgzAVvsVSW3D9Zfo9m6Hhdz
	 FlDMSs984IWegFgaoO3XA2NdX9u1udtVFPsbIca5apGa6lT9qc9KrTWfxiTIaenT6Q
	 AHUYojOEL/Rcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C7C860AA9;
	Fri, 24 Jul 2026 05:19:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FFE3707
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 05:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61640402A7
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 05:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DBVfoqMdkt95 for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 05:19:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::2;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 620134008A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 620134008A
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 620134008A
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 05:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIRrmDDkyyWwdby5QCwrK2EqQ4oQ65s2ufD00bf54BGiXArzSLlOOVogcQJHo/PhnYLqdLbxVTKjPRoLtZlp5gQvBdX6sajioE1FlL2A3Ck6uY62YapOjIXiXdKjL1GIZ4H/bRwXCmQD2pZwNcbS3wl3R1BZjy+1al/FkWeosL4LM8nZvn9Ry083HDfrd8NYahFg8uPkLSmN/0ccLtyG0c21U25wXX81g/ZRDCXc5+ISpMYqCAZN+9scPSSmjlIJI2y9be/S0R2fAApHOzUMl8uuI8HAIu5mZeT2M8SviKJe4hBFeMuDi5tUpjxaluVnCt6F0KAGvxLGsPHVVL8GJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjZvtMir1gcL+Se/0cbxS09nXsbgSWS6s60Utz7zZqU=;
 b=RHB2myB0WbRBfUO7TlXYtF7KtI6kgMYjSULt3u+5NlK06y35hmNSBAyniktoWq0xNr6oiuOT8veXyurAZRcMd5/X3ETvi+n3SrErlTHdVVdq+mGGpWkNor0cmlK3gD/9o8sKwRZbgqmNyhJ+0KF95k06HiSGSMJOU8ujv4kwkuxlz2K+GjbQOJoqcJW343e0NOtwh5012nPYdlb5+V+4ib9dxi31nFSYmFTa0HNFZxWn8zZbUvkBLriOfFmKO0Rxt9O3aNW9bTfrkhOA5WhSzgkNqbbbmUTb0lnoL1P9q2Cbl2RRdcJh9VRCbrXFp1VGbHpEpp/WLDKU5VAnulrsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from CH2PR07CA0048.namprd07.prod.outlook.com (2603:10b6:610:5b::22)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 05:19:03 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::97) by CH2PR07CA0048.outlook.office365.com
 (2603:10b6:610:5b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 05:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 05:18:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 00:18:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 00:18:58 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Fri, 24 Jul 2026 00:18:58 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Sean Anderson <sean.anderson@linux.dev>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] firmware: zynqmp: Remove duplicated sys_proto.h header
Date: Fri, 24 Jul 2026 07:18:47 +0200
Message-ID: <cd3c11a7e09ed8db3945910cdfed0eb860dcd61e.1784870326.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=661; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=nVt5RFP8FGErX+OFcRU2OeE8HdmHcfbimlAY0RZcziA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQlfd2957ZJ7/3QcIeb0stfH/yctev/kWglxn3/3hT3T
 fGqZVi7oaOUhUGMg0FWTJFlOpOOw5pv15aKLY/Mh5nDygQyhIGLUwAmUrSJkeGoQ619FPssJ+OW
 Y/nCLydJJIfrZNqerJ74+Ua89D+HvEuMDB+nVWaqSH7kz3W4zn9zz72Fj7nT3Fimyp4QKi7T2sG
 6nwsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DS7PR12MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 1720e11b-5157-4b73-0fa0-08dee9431177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: FhqAPINitXnRdFHftwmYXQraJdRC1XJEwO/vP2UbCO/clSKd4iNoe00dOuG0QYmL07rBoNKJnPjjpNuY3kKhM6O3DTBr/F6xpu822yL1t1DcmDEoewrXR/uKVk0isbWLZJvlxMtFTwMknAdKAjym9IQBK6WHKFepzogsu6dmcgw2JBHAKuK5H8WW3zmB2nlmFbGngfKY08Py2hgK+gjZNPf/W4PeWkc4un9T0tobMYh8nseo75tQ8fSzNiwO8AQlyW15V0zWBgtgcUC/Fb3ssKL0kUqiakjy6G6bJgbDpHf8Sy06+SaFHGY5pDhfOfyiqbzGS9sqtDfNFdNGaT8dVbV7iVXWc5XsBXPLoKFv27TSVPKjZwBzteURy1TSPxvgsBgrCNpUANDOCnLHcUK4nUmJZHstcCxyBQXbuyMmWXCeByK+H6qqdRqaEV40aTfzLSy+T1sf17QHjZYvDICjSkOTlvEkgX6KNNkP4lP3jU+LElAOKX7pZDRyGzOGXecn+Ci/PexgmqH7i/c8X3N3+zAx/OYsnpN6wln7ZxvpYkNM8XasgJ+6PXfFF60PWt7R/sO2xw8wsMIl7iwpoDkbGm/46Ama4W5LVY1Zn7Jq63xtdg3IoE7OrJp1+hTGPuWW/jAqGReQuRhB/Oris7+fREyds0lhS3e+blMvk5BY5dYSia8v8MNj/n9hNDQwHzPASpwa4rPvJcA8RN0UWapgpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8vDAblAdYfnXBAkeXfHxsr37MFCMw6/No8kvs1byQqr5I30/Xb3cvWesPS2P66EF7HwADZM5YjZ4xVEdLEiY0dgYsHvumD/dqmuV0d/SUtjeEm3kmM0AMff+0aT8gZY5GMAQ4XZOoyQMCADrX9+PJWzpXeUojNDcSFM3ttWM6KT2sueN62aHW2vO0CYLhdJvkAroE0CHfEAZgas0+q68YNSOsnFxlGfz0T3iQrZBYh1xBwdEaAuDGlRlIR5Xjik6DaMzGGv2Pf9j8Xb/v/VQZ3O5HcPJ+fMhp5/Q6jjsdjq8EW9W33/Hit/ia3etRxPvxT1UwbwdBsSqLEaFtE2jkXPDPsJ2NnVu3gc1uNAvDu5Dk1BKw10pek0XlxymT1vqX3V7Cz2e8na6x9Lu6IhoLVwtnGDCJnXIoUTp8eP4H76Jx6A3NS7iVNofZEj9oFKD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 05:18:59.7555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1720e11b-5157-4b73-0fa0-08dee9431177
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjZvtMir1gcL+Se/0cbxS09nXsbgSWS6s60Utz7zZqU=;
 b=wwHFpYc5MCtUilKP1rPT7tyrD3jMC9jt7ZvG7qV0r/RSSkrpzxV/n4d2Oz6oXP0Y5doGp95IjhcD/v1Y1aaglIAmt40jQYuOo6VgZtXJHTfdJo2ZAPtg8FGn10IDmtRSKnGQQfag93MeOmX7ngNfdu2JKoKr55eXZk89b/KxMx8=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=wwHFpYc5
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

asm/arch/sys_proto.h is included twice that's why remove one.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/firmware/firmware-zynqmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index ade761830dd1..2bdb1c4d9f89 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -22,7 +22,6 @@
 
 #if defined(CONFIG_ZYNQMP_IPI)
 #include <mailbox.h>
-#include <asm/arch/sys_proto.h>
 
 #define PMUFW_PAYLOAD_ARG_CNT	8
 
---
base-commit: ef665e159fefceae515aacd1a2744d1153c38210
branch: debian-sent3

-- 
2.43.0

