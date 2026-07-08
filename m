Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1A0C43602
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D1CF84ADB;
	Wed,  8 Jul 2026 14:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aDsjHcPY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8448384979; Wed,  8 Jul 2026 13:17:59 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED19384118
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 13:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=akshay.belsare@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhKzWvNul2hCTIRERBDt+2aMKREpM8XbWbxRr7PNIB6MZYOc0wytqSPd2uhaZe6LplH96QV5NoSZSwicj8afx60B5hEoIQHcwIYEQfq2h9FKeVfgGvgqGgd6WpFOFmWnzQJgEtHRnPN6H7StaX8MWshCBzkhGdbtbtXh5i3HTdSy4jdUm/0AWTGTHZy8QI1aOKvw2ydjxAJG/kQ7owxH07olFedh5/qWdtr3evKSKUjv/4YuVT4b86qItyItva+Q+P+ruoLQU+YdVQy6T3s220vAibVShFhscHh/DCYhvz25yaLU5gksbsR1ksafhcANMetnzkCjwMqze5JjI2JBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN5tOwtWio6vS7vkHGPvES9lbdS/j9CSwC3Bp4RpXFQ=;
 b=al4HbcN0miZbE4o378fr3FTsADz3BRgT/iw/Nyv/QnzN2zACi4QQs/xgVAa99+VFs3YzHvMa3swlGEeXWjFZ37eMVpzihWLUgwQjq7RBV39VbJs229WUWxrTxNEVnUzkX3qIcGQsCAYvIMdR4QlYvQ001uuQGN8GtNg9UhQK63NPKJkcRevzw55Zz8584fSZxDa7g7tsVuQ49mw6k/IK5H1GBqDkVseEo6JO4oeZjqo6k7wfk30GM29+BVjxe2zDB+mYz/V5mN+j559FgwEOLp3r773cz01iSa6KGwp+FensaeJ4OSiY3h7Rk4k6PDNhys01R4ih7L4nmzoX4FAtJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN5tOwtWio6vS7vkHGPvES9lbdS/j9CSwC3Bp4RpXFQ=;
 b=aDsjHcPY+fARH+CofXCl5inx9KVR4x1FO4Dl+47n/MwY7gzwsj60tIq9dv+vYDr1t2Qg9I4uxPPM27qbD9hF8f8ZMaAvlbQhDFthk6k/lWGA7z+OV69QKnG8PpYhBYhKq8XGZiBmUlW1Vi2gj01/xKtcrRXECnFvo919dJ34RHo=
Received: from DS7P220CA0076.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::10) by
 CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Wed, 8 Jul 2026 11:17:50 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:8:259:cafe::7a) by DS7P220CA0076.outlook.office365.com
 (2603:10b6:8:259::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 11:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 11:17:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 06:17:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 04:17:40 -0700
Received: from xhdamitn40u.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 8 Jul 2026 06:17:37 -0500
From: Akshay Belsare <akshay.belsare@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Anshul Dalal <anshuld@ti.com>, Casey Connolly
 <casey.connolly@linaro.org>, Dhruva Gole <d-gole@ti.com>, Simon Glass
 <sjg@chromium.org>, Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH] arm: armv8: mmu: fix DCACHE_OFF incorrectly unmapping region
Date: Wed, 8 Jul 2026 16:47:10 +0530
Message-ID: <20260708111721.1455945-1-akshay.belsare@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d45b43-2708-4c19-575f-08dedce28bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: eaPVDqJOQltaORbvFE1YLcB8mAcuB/KyQVs8pqt8wnAz8XTF8yySx+p0r6qvWtxePJC1al97PDH7nD41u4a6NZtf6qKCadIVErug9mx9OwpxP0k6ciSCB2rJSHs97F3CQLZuvzDQcg+odEXoYjkVCksmGeRMJmZrDi1N2/eixe49exov9AgzuQN7KGJ1hxgQvUDY3CEBCBAUoVEM9/2d+1i5Yy5YoFDklVhWmVk+L4F9nUsqKbFk9u0nCYb4xXqNyIbGfUE8w/W5d/RpyDe745fCd4M1GkUk2Qv8TcIvFyDAMMw/JIBN8os3cIiSBFoHkNAgQvupeugpRTzPm2kr0kCNOLKur5bfCtBYxTe7jIXZYGnL9tbtbr1c82yCKxm5QYSvuywscrFObcLMDRLma5o23e4xVzKf7VWUr5BZefE1dX5HeGivAu9J1X6/X/Xo0/1PlBdyhkMacQ97+4J/KuWJ6B7vjkC9RhZVcdsDn9jokqnLollG6u6o7F6ZzDfMM3Mt7rZFNjyCGXuiBPORiOnTFQkt5BvSUMd8kDqT50p1vro1GnTTismGY3l0JCnOE9Lk2/RaSC2p8I5GhVJ/SW6p5RV6Us1xNycOdIR84RtAQ6QMCL5JRKm/gATjsEDOf0mHGSJXm4hJwZzM2VpqgygEUrs5+LidU7RT/XdqGJSH5nTHZjs2xCRW4iFYY4PZN8JyA8y7bf6HaQOUx+fkpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Dn+WExI7HkBN1uNHQ90nV3uSwsM4hY3Fc7Nym6wIxUJM3dDF9Q0q9WXyrmt2iKoMMuk79DyMmGa++LxL4zZgf66WV5QfD+pAagQfdbDlQhqKKqU3ceS9nk8g1eApqsC5dbyiCvAyTqvbGj5DJEwC1RL2zrd1cEOnA4hJYPEXsYhtU+Mv5Sixd5xxVnqaclu12CkcL5cGM4XTwhO2cKo5Q9KWr8cUorPbLpzVQlDG4mLtI4aw4KzmIKELLOooKClLbVauDEn8gmzu1je20uZEA5e07yqmOx2BUZ8e3drSdMxUjLGllb4qmacWCHinGame12qmAbjTShl+iDs6kFIBlnCEpHedpy08yVIhtLe8UTBMpd9wTvBbFue2u08KslPOzASJ0ft/XaaoySgxQOhhcq+LQUnKD9KhCz0vTpA9fUXD8mVj2NfN+Jn5yd7FfQuG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 11:17:50.0882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d45b43-2708-4c19-575f-08dedce28bee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

DCACHE_OFF is defined as (0 << 2) = 0, and PTE_TYPE_FAULT is defined
as (0 << 0) = 0. In mmu_set_region_dcache_behaviour(), the cache
attribute passed to set_regions() is computed as:
  attrs = PMD_ATTRINDX(option >> 2)
For DCACHE_OFF=0 this evaluates to PMD_ATTRINDX(0) = 0, which equals
PTE_TYPE_FAULT.

Commit 6468ca13ffd6f ("armv8: mmu: fix and optimise explicitly unmapping
regions") added an unmap path to set_one_region() that
triggers when attrs == PTE_TYPE_FAULT. Because DCACHE_OFF and
PTE_TYPE_FAULT share the same numerical value (0), any call to
mmu_set_region_dcache_behaviour() with DCACHE_OFF silently unmaps the
target region instead of changing its cache attributes to non-cached.

The subsequent flush_dcache_range() call at the end of
mmu_set_region_dcache_behaviour() then crashes with a Level 3
translation fault because the region it tries to flush has just been
unmapped.

The existing flag parameter already distinguishes the two callers:
 - mmu_set_region_dcache_behaviour() always passes flag=false
 - mmu_change_region_attr_nobreak() always passes flag=true, and is the
   only legitimate caller that passes PTE_TYPE_FAULT to unmap a region

Guard the unmap path with flag so that DCACHE_OFF attribute changes
take the correct else branch, which ORs in the ATTRINDX bits only,
leaving the PTE valid.

This was observed as a boot crash on Versal, Versal Net, and ZynqMP
platforms during network initialisation. The zynq_gem driver calls
mmu_set_region_dcache_behaviour() with DCACHE_OFF to make its BD
descriptor ring non-cached. With the bug the BD memory is unmapped,
and the subsequent dcache flush inside
mmu_set_region_dcache_behaviour() faults.

Fixes: 6468ca13ffd6f ("armv8: mmu: fix and optimise explicitly unmapping regions")
Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
---
 arch/arm/cpu/armv8/cache_v8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index e59528e576e..ad232435eb2 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -1006,7 +1006,7 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
 
 	/* Can we can just modify the current level block/page? */
 	if (is_aligned(start, size, levelsize)) {
-		if (attrs == PTE_TYPE_FAULT) {
+		if (attrs == PTE_TYPE_FAULT && flag) {
 			if (pte_type(pte) == PTE_TYPE_TABLE && level < 3)
 				*pte = 0;
 			else
-- 
2.25.1

