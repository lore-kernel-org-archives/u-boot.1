Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44863103E167
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 11:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A98C83E4C;
	Wed, 18 Mar 2026 12:42:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nrMPn2i+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F47F84118; Wed, 18 Mar 2026 12:42:00 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC2A383015
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 12:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPQDDnryqj7Yqrv1knvMnscVLWVZT0WHBm3VR7mQCHT2bnXMGU7mrj5zH/NCr2+RYtxbq/3gp2LOymI7YfDtRiXu9uSCIvOWe4xjhHtkU7wcwwpajCNQ1JB+g9Gq9d2JC8I0xbthamx/DV5ifRumIigX5dp3T8/zu2tz8yNqVcYLxJ0UYLqh8ihh1Uu99HzuQiI5zkaQc22UchZ1FPSzpeWZsITGBQn/bFzXx2BecBaUK9ZaHSlPTDzcWf6iYGNy3OxcQYPZ+P/QSRmHTz594V+6ppVtTTDHH1eGAwliIqYqs+uPVal4Oc2/X9BiF43lciE1UeqsmgsGMErSyTu+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYs6IX2PeAnqSxPkZM7NAQuw66OOMLLXwbvtl/PzOHM=;
 b=DE9A9X49j2ydEaFFhuohn5Z0dm8/tnyQPWsiU9aSQr4XnNd6cORhsw8Oa7JA7xAqsuCrHnPgvAP8FJrypG89k/pYc9bDdm7efr3sDrcMfLRx2par8qDMl18pTnT34dg3NF9+8MyCFkQuisW86x29LYN+lPIfZIm16smtjXL9Y+9Jnwtlpj8SFtEu7Umm3ML3pK/AHs5yAE21Jne1k7X7ITdAoGF9YFBCc8/hSdg52FntR7SmZg+k3eyWB9N/EJatSgJxDDKeDLTfAPV8/5RYlwA/EPtbW2Vcxb6WgUCwFh5/exsHnBJEvB+q0mCFeYYNMeo6sEOjxK0R7T2ux1PnIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYs6IX2PeAnqSxPkZM7NAQuw66OOMLLXwbvtl/PzOHM=;
 b=nrMPn2i+C26QPap0z9kkBzmNRT22sLNhtxtrGX+XCdjZzaku1DiTVxNKDMR27I9D19DeTVZZ7fXMprtADAW8MwuF+toOvx3rV8uZYC6D8HTr309SdIRCfrjc8YB0coZnV0xIGaXcnLCkg8j0DiwQRZL9TxnbKJJtHl5psrigBcs=
Received: from BL1P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::28)
 by CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 11:41:52 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::45) by BL1P223CA0023.outlook.office365.com
 (2603:10b6:208:2c4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 11:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 11:41:52 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 06:41:41 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 06:41:39 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Jerome Forissier <jerome.forissier@arm.com>,
 "Tom Rini" <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH] net: lwip: nfs: fix buffer overflow when using symlinks
Date: Wed, 18 Mar 2026 17:09:04 +0530
Message-ID: <20260318114124.3749184-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 82649b21-54f8-4ad4-9f51-08de84e35961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: hpYk8Y1lPLD+mn8tnwPbgZcjk8Ds49PjV3HK3lW3L88neJlnsh2puI8dt14npUkWEUd72SrPVUXQeKuO1DMkTzpgS2grmqOcy/6cb4LCs+DREPHH8dRg9v+hmOzEyvznrJLtEL4RAGGes2MS4neDALA0413xObz4uUghZg380T5tNRs6DVDOvr1HSDajKsecaJTaJMrAdRyTE/04JM2x83DIXPRamkC+/uuXcg+JcXHZx/HfzLpfnNBx1RVGCv7bFmnZovH9neFFSt5MsTXgsOHYWdcBae8c4aiubVgi2Q8T+YjOEk9nILYjciFFfS+HK6vOgAb0e1Yne02+KXsUhAhunqJDNwQBMWueDkT9L16ApH1mXxTCdxCexdpjOtOlKf97e+8IXrucS1DItZm3AVsGSHgucCB3b6mwhTtfZeMh8KbeDYTsKlPuGHKCL7dhE1sh3o6juEWG8EsbAB3YSYYrPyj6mrDUgD5veuuOFW6rIQbs1x6c1u/WzZ30GIQUQGVSNrhW863eeqmlOrSEgTCLtNDXyixD3Uvkc9VMpkdhjI65p8342SLNjhI92cqRNIg2NP9Nh1qNlsgwDpyOdqmUXPWzjfCF9WxeLSzXPEViXJMf0qzfIbELPfA/8mAGOdCXZySd484BaZoU3JsqjA76A0uP3M0gONXv+We8RFnb1K7pKTEOIlxE/XpsC3CmoL8B2Ozz/rs67CGOJk9iILDo5QrEd/xwT6olLTmgu0E46Pjw0aO2c2R//ev0XY70KnhLEoAftSErkeEmdsnhyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9RYebUcg75IqvkIyw4Oyaxc5BfppvDHFJZPrxy+JQQmRqAGQalSLWaQyqChfsfWuRxufxp5B5MlPIUxbqoTBq5KMCLTjBd6VydYnsNrB2vInNMYQYIS/MwqkFYLCPh8E1F5YHajuEUDShfK5BMC82QnwlSPsXBDKHTyBhfZ7z1Jk6rw1SF+ZtcIL2mtdnmqO85FotstRRB9xkC2ah76dPZa8Gc4wspMonA4itIP6jgynWIhK/8bb0XjC3VhgLICBlHJA6TgK+uceqHLhXmncMbLun2e0MXvLZvKQp/m9OAYb5LkziyB8r6tRzA3Cjs1RfQmyyf1+Rr+juUR0pwgB6cAWWsoIdAdEkyc5VZCGRKvzHWAZdLllMeCgxe82A3NJh+ySY9Uf+XJU6xdVm9SR1agxpYo1rz3cvyD2UQt6a9RXiGaX2hf26XcewUNjgNtr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 11:41:52.4845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82649b21-54f8-4ad4-9f51-08de84e35961
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631
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

When resolving a symlink, nfs_path points into a heap allocated buffer
which is just large enough to hold the original path with no extra
space. If the symlink target name is longer than the original
filename, the write goes beyond the end of the buffer corrupting
heap memory.

Fix this by ensuring nfs_path always points to a buffer large enough
to accommodate the resolved symlink path.

Fixes: 230cf3bc2776 ("net: lwip: nfs: Port the NFS code to work with lwIP")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 net/lwip/nfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
index c3b819a091e..b2e8fb3382d 100644
--- a/net/lwip/nfs.c
+++ b/net/lwip/nfs.c
@@ -114,8 +114,11 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
 	if (!netif)
 		return -1;
 
-	nfs_filename = nfs_basename(fname);
-	nfs_path     = nfs_dirname(fname);
+	nfs_path = nfs_path_buff;
+	strlcpy(nfs_path_buff, fname, sizeof(nfs_path_buff));
+
+	nfs_filename = nfs_basename(nfs_path_buff);
+	nfs_path     = nfs_dirname(nfs_path_buff);
 
 	printf("Using %s device\n", udev->name);
 
-- 
2.34.1

