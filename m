Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E219C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 10:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F04D84B88;
	Wed,  1 Jul 2026 12:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ksaJo8KH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C836584B88; Wed,  1 Jul 2026 12:28:57 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF56E84A7C
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 12:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUDpSzMoUBRPXmA0AtVhsqxDejF2DFFygrWsdZJ2ZN2lgqXXQ9koO8TPbitS71FmVeLREj6djEY+2KqGDTGkci3xc5ijUpHVcE2DOY+CNE7Z2vclV0wXiufTMK6IcNKzXynTEWWiGC/M0m+jXsl2LornmO0/WU+Ht9W1AJE7WH1MelGwLXbn9x/ylCDpa44JFpZFZuHre4hX7JdGL5sdqvOgST7nT2rTJoVW3SplqNtP7UNCBJSUxOaNjGtUfsBOtTtrh6j8KJA6y/qyoE8DZr0Ev2AlVrOqP/4iC/kdsYJyEXrcS/TWEJ1nnz5wonOe/JJRfwuXk5QyR9LcBnOREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne40CCgCxNqbXCd8WrNsIptMiJIiYFlVGye6/toJmBw=;
 b=bC5U1Ej3hi0tjOQFLmPOOb29jKsD0Iww1YnAuKyfVFjK55++JFTzypAtn3n24SlJsdhjPuwKpXk2IwglvZat3xofB0P/TYJ9Twenc0z408xFdtfvd4wd18NK/iBk4uhJdjKDsfqIXDUBwwXvgPA+IKaJz5gi6GjqsLxlUYk/jzWk2pzuMA1zcunbV8cML/vFYN+0+RINddQS18qZEXOE/KW5yH/YMAQw/wdK6KB1Oy8Iiabj+Z7KssJQ5pgftS7YmUWKVMaakU7VW28mnxdO2a7PqA7tMx5tJWiG+UncCEuAmBv3S7tZM0zx5L3w0I9Msw9gsJkqaySHGxGlCiUf8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ne40CCgCxNqbXCd8WrNsIptMiJIiYFlVGye6/toJmBw=;
 b=ksaJo8KHvTwaxPBtyp4/OdGB5DZt0BJQiNvxQ3DTRZyzsgxPkq0tiUvGr75Yt/Gsj7hWB0ZE/dHt68uoM+5yzv4DYbKCI7RcbQmvkJ0MohqG3UQAXT983z8ciZu3j8zwjQeG0gxpjeL8svO43aBy1uoXqrGE2hwr03PikbTlR/o=
Received: from PH2PEPF0000384F.namprd17.prod.outlook.com (2603:10b6:518:1::71)
 by DS0PR12MB7769.namprd12.prod.outlook.com (2603:10b6:8:138::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:28:49 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2a01:111:f403:f90e::3) by PH2PEPF0000384F.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 10:28:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 10:28:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:28:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 03:28:47 -0700
Received: from xhdpvinayti50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Wed, 1 Jul 2026 05:28:45 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Dinesh <dinesh.maniyam@altera.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 1/4] i3c: dw: make resets optional in probe
Date: Wed, 1 Jul 2026 15:57:17 +0530
Message-ID: <20260701102754.345049-2-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701102754.345049-1-pranav.vinaytilak@amd.com>
References: <20260701102754.345049-1-pranav.vinaytilak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|DS0PR12MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d73fb99-f7bf-4347-5c3a-08ded75b89b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0+u9s8cyVeXjGiBirVvzB64wuPrV0Z5AV1MvvcxQvb6TmTuXPREr/R3rHMomo94LtNA0kObWQReBo8tSsjoiGc42aNE0M7JJ+5Q5NqlmmXZSWYnZ9TV2B3w0sZzfdle8Xl05+T2auSI2pef7+LzhrDhjkTXrqA8ixOClMz++YCORZeb54lsySjML4upTsclzRxPOb+7LT2XWO+gVZrZUbruALBZgrlqTe3jxDYDS1IpVbX+J7FBYl+Wz0Ozxmz4k4DJ39760iiprq/cJVnjX45dleZjtq3ej5qTLB0bR97WnTMAqqFjpkgPElCFygu8o0TfEJbWeUxK7o6ZlzbfKpj6dpPPm/AwyG2qClI9/A38yG2G4Bt+//FzRMINGFNfCh5LBhnznRxSAGC6WKj6B4z1qWr3ezY3dvPj+LhN5mwm8YVgt8TqsqLO9EBLRVIQPojO/j35FjL2A2RDkCWa1sfFmA8K30FFG8KzIrGqmbApTjZiyxYhlk39rmNq0+/tK5gdyvMvUW3udhYuOpuYwFp28oNaFmfedsYzFadNJsZSo1P0imYWpOHRH3F0nbNVeasIIePOKQv7Jjefg5ME9qThvHq9kUzfPemLPvg+BpIvCemxJL/CKGF04aI/gvWd2KvJN7OxHmxJEmM2NEWn1qNa8/tpCrUrF79qWzJbYVHO/JqTIU4KDciP22vGD8I5rK4w8qH32FYiIxOQ2PkPSyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fi7dABM1q8JnomLLe3qbwKoUSpIw7OJSpH7J1UIrJJoXC7ISxjLEmp0d5tayPfylNrzXCFiWDQqi6Yd5etaA1oMNFPopBen6S0LSbB5B7EuszT16Cdw4iQkMlqxYeixYWp4gfe2wFJ1Z/xO6o4M85Ru8c+qawl2EnxYfvAbI8eR53X8nJn8FWxsu7SQP8fogKzoqEV5x5ucT0tvdNFDss37T6MadXdy2XPQ1YPwkKsZhYalKUnPuhljB3ZLeyd1JUx08uDjXDXWM/cQYJWg0smwXBL69cgMVz7QyvUsT3dLigT18NUiKseqy8fDAXZez1ei+s3ou0qohOrLb+I1iBPIC3i8KXwJJmBrqrvT/6tPEYMPE33MCMjAdQOTjT2e6TMiRrbWSeXK9cZqySR6nUZCIYn5eI08LSNh52dZ+KLBbWB8lHwu8KJW4nL71RWKi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:28:48.5092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d73fb99-f7bf-4347-5c3a-08ded75b89b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7769
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

Treat -ENOENT and -EOPNOTSUPP from reset_get_bulk() as non-fatal to
support platforms where no resets are defined in the DTS. The resets
property is not yet documented in the DT binding.

Fixes: 1009c96f1590 ("drivers: i3c: Add driver for MIPI DWI3C")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 drivers/i3c/master/dw-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 0c4af7e528a..384fd27b750 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -972,7 +972,7 @@ static int dw_i3c_probe(struct udevice *dev)
 	}
 
 	ret = reset_get_bulk(dev, &master->resets);
-	if (ret) {
+	if (ret && ret != -EOPNOTSUPP && ret != -ENOENT) {
 		dev_err(dev, "Can't get reset: %d\n", ret);
 		return ret;
 	}
-- 
2.43.0

