Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE71F531C7
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 20:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADFA884222;
	Mon, 13 Apr 2026 22:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t1E3pUY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C6884242; Mon, 13 Apr 2026 22:36:31 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8137184228
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 22:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/j7O+E5t+mfuD3zpCnghXPln54ADoC4gh9/FdKSlpbuMwCXPkYP2CcIMA7nnL+54jt8z7r4R8dkiu/k8R2aAvysf80yJwQwKSu70df2kWPwxqkYkcyDzhzgU5eSwL6JsPgQwWQZRU1yhB8/CAiRFnKKg2MBRN5CPWk0QOWh2TaLUZWngkW1C6IPBAzOGvVsKx1+2gu9uB/JAtr9UHEj6jwMqNZC2aJyGldr4jSUmWYzy/vFAWzEnUersKYfbyJU2pqE2qY7il958eVcZxuBBtLPq86bjpDIYLJVaTmpzY9EIr4iba6cGNmILL+3KCcJh0Z0IzAVetGTevn4XejuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eq+tB3bgbR8TKICMNQRm6vnQICrwF0l75XD9ToSuq+o=;
 b=rIgJ3s4zD9Ts1xV11AgHkEOEgffoFsx9oMRnEOnxxV5NblQvwxmtWIw0Bx1ug8eEZ7Z47d44iJZcHFDx1zzyRpZgEqG/seIR5yd2H/EQEivWia5kthMzUX+NEpWHJju9XmKE70MJ/Z/Eeq/qXCZIyoxiAu3XRYxuFlTG9MxkPBKQNiYS1HvNB4RLGduCkH3NBLahs1KiOsFgZRHcT9YyOtruDe/B490WXkhJlFPC/Exns0JL3B+Wk6aZg8/ZAU/tZO0WP8hCpVOHEnF/ymYfdZwbnu0HmscVXOJCPwi/gaJNCEIvzbPGx97wJAUta9cCcrlqaP3uRobDwn8EbRi6qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eq+tB3bgbR8TKICMNQRm6vnQICrwF0l75XD9ToSuq+o=;
 b=t1E3pUY1y66nkER7buZ3bg31yKsjPydIwNstfBO38Sr0hrNA4PpfnvapKBpHH0W4z3zBTXSHEL9uTM3TdV+uWjW98Y+4FP4vt/1PeoKXaQEyY10aRUtJmYbwALcrReV7dVR8ahIi2n7Hjh8RPIf0La1cUsTXhC2r398tRqH7rws=
Received: from SJ0PR13CA0041.namprd13.prod.outlook.com (2603:10b6:a03:2c2::16)
 by CH0PR10MB5129.namprd10.prod.outlook.com (2603:10b6:610:d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 20:36:25 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::be) by SJ0PR13CA0041.outlook.office365.com
 (2603:10b6:a03:2c2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Mon,
 13 Apr 2026 20:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 20:36:23 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 15:36:12 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 15:36:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Apr 2026 15:36:12 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63DKaBse2729634;
 Mon, 13 Apr 2026 15:36:12 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv3 4/6] efi_selftest_memory: check for duplicates first
Date: Mon, 13 Apr 2026 15:35:53 -0500
Message-ID: <20260413203555.1990337-5-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413203555.1990337-1-rs@ti.com>
References: <20260413203555.1990337-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|CH0PR10MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e10ed5-4dd3-4d50-f62e-08de999c541e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0R0Wa1vZ5Cle/BdNrcFGKNK6EYdMsh/TNyQNT+rItc/9hFSRCRnybmEnFW8UvBW7Z9oUCDFMHrhjOE4bgQZSUgniKMxwVrsY21xzIBpseO8zSn/Ph7eeC9HQjuT7zBZAMHU3q2kz/YgyiC8FPIhPKoQ4ZYTkKyAqDhanixbLQZf1xtxqGnIak9jvOXuVJz8OpdZahZIKf+I+Sp+xooG2J/6Wjy6hiykTSAMHygrEnlqLe2Y0LJQoMOv8+JrjpjQkMb1tV7yMvlnHWJjDnALs+PnQxjYABGtRXBpF5343wehsWe6dJ/fMhUpLns7FKjDkTuLb2BWHXfOIj0Vy/z3yI3W1yD+cjUHvjgarNPSSEMYeL4zFpW6h5NLrOLtxs0byV1b2YKM6uX4JNk481hAy9NNT0ZLen3rjM0/iglxwY2tHGLndIsOzRA6ij06P1MwhyVryK+4YwVRFhZSnzwUqWS/Zy4CehypaKDAM7kWd7HOYtGM//DCBFuj4BQS/ZvjK8xUb4P5Ojtj1gIqIZIIMg8dLnKpOdHJysdiSBfwHt6U+mW0YaidGQuFvQXGER6b07om7UZfy6okDetFRYURgT0gkA2FrE6fTQStRLB3KaAc9w5Vlvd5dkF0bC1BHKjYIO0LX3PsivREvi/xkqewxdMma4KZ437uFHNEWDJShBUBUeSIOmwk7gdnrgYYvFEEuM/FmmpRJ5jvOlG+KW2S7Us6feVAGAHw7QZPkq0UXnDVXOQj7OTP+ifsMs0ik8tyMnl6MMmZltJ4YeQ+HLjAAbQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: glOJLQfCg5bg+8jkL8h9esAyKuNqWmcev5h1Rb62/PkLNi2pNuGx5pBqa2ECwQUCrQlsI/49d8RYEuYQQ/mzNMvfTWILPBIQypiZB7/21xzbeVM+Ne1u4w3XMVJbIYIpejXBb70RKeqJEnx669eEpM6i45gtR2h/B8uEb/n9HNMwXYMmTtyeBgzgtoMC9xjgzl/oBP1MV/UU+bWgKHb8DPq1pZGKs7umDdhuWBna7sNpAJSznG90C+JMJWqnVPfTQRCEY3wzVPV9vcbwYiWqcyIIwUdERnLLAvn/jdz7C0b/IwPi05BYi2olhbqwl0rWQkjisPbh0z0Hew0lc9vYWou4ggwcQmOSRCV+29kTtpKm0rMWoboa2FrBbu7TZPxK1rhEuQHEZvg5C+4LMc3MxPtUJqH1AjqzzV9lxCgJb+K+55X42TW0EIgoLJK2icep
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 20:36:23.7125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e10ed5-4dd3-4d50-f62e-08de999c541e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5129
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

Check for duplicate memory mappings before reporting any incorrect
attributes. Could be that second allocation has the correct type while
the first doesn't. Knowing there is a duplicate in this scenario is
more helpful than just reporting the first mismatch.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 lib/efi_selftest/efi_selftest_memory.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_memory.c b/lib/efi_selftest/efi_selftest_memory.c
index 4d32a280061..7320964c129 100644
--- a/lib/efi_selftest/efi_selftest_memory.c
+++ b/lib/efi_selftest/efi_selftest_memory.c
@@ -60,7 +60,7 @@ static int find_in_memory_map(efi_uintn_t map_size,
 			      u64 addr, int memory_type)
 {
 	efi_uintn_t i;
-	bool found = false;
+	struct efi_mem_desc *match = NULL;
 
 	for (i = 0; map_size; ++i, map_size -= desc_size) {
 		struct efi_mem_desc *entry = &memory_map[i];
@@ -72,24 +72,23 @@ static int find_in_memory_map(efi_uintn_t map_size,
 
 		if (addr >= entry->physical_start &&
 		    addr < entry->physical_start +
-			    (entry->num_pages << EFI_PAGE_SHIFT)) {
-			if (found) {
+				    (entry->num_pages << EFI_PAGE_SHIFT)) {
+			if (match) {
 				efi_st_error("Duplicate memory map entry\n");
 				return EFI_ST_FAILURE;
 			}
-			found = true;
-			if (memory_type != entry->type) {
-				efi_st_error
-					("Wrong memory type %d, expected %d\n",
-					 entry->type, memory_type);
-				return EFI_ST_FAILURE;
-			}
+			match = entry;
 		}
 	}
-	if (!found) {
+	if (!match) {
 		efi_st_error("Missing memory map entry\n");
 		return EFI_ST_FAILURE;
 	}
+	if (memory_type != match->type) {
+		efi_st_error("Wrong memory type %d, expected %d\n", match->type,
+			     memory_type);
+		return EFI_ST_FAILURE;
+	}
 	return EFI_ST_SUCCESS;
 }
 
-- 
2.53.0

