Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C331112245
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 00:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72D9B840AA;
	Thu,  2 Apr 2026 02:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XmW8Nt3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C26E883F7D; Thu,  2 Apr 2026 02:14:32 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAB8B80517
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 02:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3FnedgWXl5IaMu4sCdinL8vSz0pXgS+6mt4ToXtXfR5EYEJz7Q54HPalFrP8QLn/K2MfmR9x+3DyX7GFYF1ugJpg3Prj4tL/1hAcUI50xiMatTjDjuv2kiSsvlOJf17hru1xI0zx4MvDr3ZD/9EIRQiRbpgKsrgYr62/H++Nmq5tkKezAlOwdG4KBpof4ds5UMSJh2VGIxLu2PKuga4lYWQEstsDuvC3d0P9HAvY9GTMlVr8Ks4WdYFi/FLDhxg+35FCyLnYY4QqprJKPoX5PrBw0Jq3uPVGWfIp6SZbrQq6hGJFLDIhrI22Xb2LKsmVjwTZCQ3zh03r0UD3wID4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JNUBew1uMXUaWHUImq72QCyFFLXtCxDxr3AG0kI7Gw=;
 b=UW1iEbiXgpGbLpsPm3S2Wz0heKPU7wbmERnGtLhxduqwAFPdWEPdvZmi5e5RnFSqk0J/8LPZom5HutThtpIsjl5TmJpuJh8RBPGjsX+6SzeFhsj42TDJ2AFaPUfAskJs6wcLI/ACfXXRxaXv62tok+jO3JWmsHEfxFo/7O7QVmOJwqmD4N3z+RcmvhLhM3sNbgf02Oy8J57TKieXlyM3eVzGRtR3KYD1OGdXmgQawEiUcesN6MZ2SFc3qKA/oDdpykjbWIEfabPz0EPF6tSITX1C7Kp2yB/wk0dheAUZ/GA5Qpj1dHrfIA1oPkpPUGOygoocOxamrAV9ze08V4G+kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JNUBew1uMXUaWHUImq72QCyFFLXtCxDxr3AG0kI7Gw=;
 b=XmW8Nt3jo5g6KvXhNQyLWns6TCSXSM38MPfs0JIPH8zw75I1SaG47J1FYzgaKBtw/0+t9IgI76MntGhPQD0LCXE/m2B2SSQdTvsV72W2hIWURKhstTyDgaoeau9XPwaHzwt9sPEu2u1DxA6o0OXEtYEo8jMD4FUBxS9eE+75s1k=
Received: from PH7P220CA0084.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::7)
 by CH3PR10MB6737.namprd10.prod.outlook.com (2603:10b6:610:146::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 00:14:26 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::45) by PH7P220CA0084.outlook.office365.com
 (2603:10b6:510:32c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 00:14:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Thu, 2 Apr 2026 00:14:25 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 19:14:21 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 19:14:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 19:14:21 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6320EKsE1004385;
 Wed, 1 Apr 2026 19:14:20 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 4/6] efi_memory: nitpick removal loop
Date: Wed, 1 Apr 2026 19:14:08 -0500
Message-ID: <20260402001410.3736815-5-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402001410.3736815-1-rs@ti.com>
References: <20260402001410.3736815-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|CH3PR10MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b307522-9cc0-4bf7-32e2-08de904ccc71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qVPqFwu0H1zmfiC1eW0KZveJ3WOVht9PN3UZQp8dNpPFg/QUlRZTbPdXeH+RqiZ6cHaQTFQ9ugAR1EE1JCHT4NwJzXbeUBZwP62kVHeAjtLDZP884C6UvwiFmU6NuGxsGr5U/MaETLmaindhy7D9evduIVxUE752SJq8K+STFcuBDJRjsuxtraFRc1VRygU3snZEdGMcD0ZQHEZzVj7/uNFgO5Fcd2a/8tj22iMtJtnLJW7ko65a8YLteSmKYFqVvEDAVPQjUwhtnwAubeeA20/gaEZ+BFggvTFJBwKod3CHJ43uq2Ooxt9d+V8zLbs6LEjY0fhc/x63TVkSL8rqok7lFZa5gPWo7qRqgOMVDQjndbCdaO2iNj/PsAPAGAboP+Ps4zTuE2ryVjzRbR2zoK9jtYHQzbZprQPTz2rZD16jUpDg9o6tz5iiOlRAn+vTut/kaIm+JzuAVmnMwYM2SgDHqcUFgKyP2zGiSKzIhQZg+jJKKiNyTfQzk8OGKDlO8KbAoUy/2jLwQPkhg6BDLDm6UDw/bviDutSkIDrSX+1VaKxBtNZD/YwcxrxO4hyM7AviyXfPUTSjvMFGw3R1lqSrb7L1/OX06ZASXi3NNdY08IpO8//E5XqxvvTWawKklZ/4vq/Ss+ksMXA/kSs02FI3YEI1cStW3Ggr76cJCRC4nHevTrGEJ8mvEYS41Qc6J67HEUQ9//8hvjATbLO4mFsa++00JCVM5t8c6RI71Une6WlARLBlmw2OX8v4EoOfJFNW09loyS4E/0hNLvnt1Q==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6D4ypJm1zI286j6Ys+mNrp3anAOKiFs3GSlNxdljeZ2mz/ioOTWvbMvM/BxMin1RM5I/fVO8rAycVMPv4/9sTlBzmyIkn+UCx4TQ1YzKuvNDHC8Jl9P7O4aogK95zz/ne37/DMdrEABEAKvSt4wsH3Nq4QdDjdrvhFbaoMLTKMa97J7Mj3Fczl8hjvQ6+9zgCBzBvZoqS58K4CkMuDEBv+HFIIJO0pPEuDEsGm0Poe9Zxopjauf565nL21wuMNemiQwbmVfeKWR1n6Z7M9TVeMhDPHu8MhXIMAZei9A3etxSPdCdlNTHpNI4lsRKECtpyHW16ZmUshojWpFMga0abAV+Nqr3MrkJ3hw2RJgdpyutCLf7Xc3P1Q6co/HrMLigRzy7g+SMQqEMjIWzu68wblkEMqCI51cLg6RHMiNPZa/PfMwAUcsiXa/Gi8SAg23e
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 00:14:25.3761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b307522-9cc0-4bf7-32e2-08de904ccc71
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6737
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

From: Randolph Sapp <rs@ti.com>

I don't even want to think about the possibility of this pointer
containing a reference to something from a previous iteration.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 lib/efi_loader/efi_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index b77c2f980cc..882366a9f8a 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -129,13 +129,13 @@ static uint64_t desc_get_end(struct efi_mem_desc *desc)
 static void efi_mem_sort(void)
 {
 	struct efi_mem_list *lmem;
-	struct efi_mem_list *prevmem = NULL;
 	bool merge_again = true;
 
 	list_sort(NULL, &efi_mem, efi_mem_cmp);
 
 	/* Now merge entries that can be merged */
 	while (merge_again) {
+		struct efi_mem_list *prevmem = NULL;
 		merge_again = false;
 		list_for_each_entry(lmem, &efi_mem, link) {
 			struct efi_mem_desc *prev;
-- 
2.53.0

