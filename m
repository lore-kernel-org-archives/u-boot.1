Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690121112245
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 00:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 643FA840B0;
	Thu,  2 Apr 2026 02:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eRj+8SuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C401683CE3; Thu,  2 Apr 2026 02:14:30 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 763DC80212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 02:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHEyBAAnFEUBMiCnYi0IxMCblhQjNlG7IGPG+DSg9ZPNzWCKUnDhCoIypy510M59ZnsCfyZwO+jvK/YXtMn83uvDIQjIPqy4SnK8ZoBfUs/inXCE9wzQuIRcDAENDVsNoOY5fh2tZJRE9tzQnXAkFqpOSzPqtf+jDtF+1+nCnJOcbQyBwVa+Wqy5OOacDgU0+fymgkWyjZWHi+10Lz1bKJqLf3bGbkJzgleT9wnBxDShpPN3nq6IZSbK3WhZ4wS7Hl+woOQEAdffXdO3LX+8d++aOAjPXUrYtT0hWz5G3ymCaXHBIQJQ95XmngmBUomBw21HdWvpZL/TOqfry3yJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eq+tB3bgbR8TKICMNQRm6vnQICrwF0l75XD9ToSuq+o=;
 b=EbG1n8Xw3qtpjyyWNOitRD16I53ulop0IlmlSBAg0/+s0zaWKqRlp53/HsBl9ZM+ZO8V2zTjohUxOSYI77E8/nSY6U/0/1pG+QUF+lTou1q3SPkmM9ws5s87HzW9BXm5dqDA9tinb8W6JcfkdQEQg14Vq6xUVwcjsb+nisFHft0VEDMn1JUkXbHcRqYH96Y98lGLSPpytd4K5ZDbmM34V2Gg0criwsbkd5zf+7jGPPf48JYz4to+fSeFkOSY/dSb8yWqoASW0dLz2p2GrRK/9twdUPn2h2hBq4RP3Ipy6/7Sy/+2DRexv2PirG68jWzXqdTVDw5+Lo5oTMDeTIgV0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eq+tB3bgbR8TKICMNQRm6vnQICrwF0l75XD9ToSuq+o=;
 b=eRj+8SuDiDROK7Gpb5i2QwEIn0PdFhvbV5WLTSRqhiRinjV8zL1cHOdMBMRE9XQxPmiOOIh8fU4Kslb2/2y+j8ATAB28APFA6wgynN8U4iA1nhLNSnLFhe+YmQg9Rr+VBNVQ9Z7j5Anw7ubxFi9XnpFj4m/Mlq8Z1GgftAeitXc=
Received: from DS7PR03CA0267.namprd03.prod.outlook.com (2603:10b6:5:3b3::32)
 by LV3PR10MB8060.namprd10.prod.outlook.com (2603:10b6:408:288::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 2 Apr
 2026 00:14:22 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::55) by DS7PR03CA0267.outlook.office365.com
 (2603:10b6:5:3b3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Thu,
 2 Apr 2026 00:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 00:14:22 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 19:14:21 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 19:14:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 19:14:20 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6320EKsD1004385;
 Wed, 1 Apr 2026 19:14:20 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 3/6] efi_selftest_memory: check for duplicates first
Date: Wed, 1 Apr 2026 19:14:07 -0500
Message-ID: <20260402001410.3736815-4-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402001410.3736815-1-rs@ti.com>
References: <20260402001410.3736815-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|LV3PR10MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 162f2fe5-f08c-447b-f018-08de904cca6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ux51+Fc848HJtDqlTxCBaJbad6+UmP0teKL+vVAQLSxjIHwofcz6O68GN2PThdWCzMMHNQRrpdOdeak5G7dE3872lywMthDax7BcTVwvulBRfzr1rC6/fF5QMsELXbhiovtuvLELKxxaawJRzzBpGdZVyc73hd97ahqi/5zoBf2LIKa8xypob4E/0NQ+PKM4FEHcxIh1UXuL9lp37iefe7HAhiPgUAsHX/YOvOOO7hVAgIXn1FjjSC5AYVSuWBf5RuUB6GY1oM/aCjy3cm/B6Cct209xG41eWeoOGrVgRrNAlAGVVowIgRF3O0PNHsUkjm4PdZ0cXJAFaeGe10NjK29SW2h4vmMak93q53kmTLS79lJiPz2IVU0+guJWmtIquBgE0rq9T65Tk8DtPwscf//hEzfaCxnSdmgqNDlRxAeeEypN8oJ8kufoB7JLvRRcGYw7PZzuo9Qto8uXVZdJSHO+KU3K9sSnzY4kpj8YjMpBftmKIxAl8q4gOg628zgmTte3lbaUO9H+GTyXI826oCQus4YmbhF5gkjJTldYuB7shGic4xkfrXekqGoSHdCFSrRXiZzJEjkt6T1d6tBGwdMPWn8qDuPj1Z4s4Uvms4A4r/fh2aXKhx81ZMO82tS8clrEZPkpCGLJHvIXBHQkEBGwbjmtPOLzpUN5A1Kn9YchDD7EJX2Chs9XVfUW8frFyWpQJIJrgfsucewLh7ifVovySAonjyGc1qoUYIZXpLzZ/1mdVFdd1zT4OvjNR8FbZQw10Ns6vXi6VzAOIxQgCQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zEnRBotQDm8wbxsmyGawpHsEkB95TH1CRJQM5yki+OOP3e3MoLcFctcIIv3yy7rGzwl0GV06ieVlFiT97+/fCr64Gm1XQogJdS3vQ6r63Vk2V5JZcRKLd+0pUtV8Wq6/XobnLVrsVLy0DsCH4Ntb3olnbFyy5OigZ4Lcn69F2shDTgtPKginvCn4SemmQ/Fq3fqOGX0Nvwgg1Q59HZ7/3unhG/+c7H/HivdvT4aosJsGM8qmKkSUelmaSQE2J12lz771IeR3chLRcnSPZsKX2LrnDzZM8F093yH9GmVoCAxD7dJsAtegIIc49gDeF3tLoyza9LRiOpwUkXMwGYMsLqnPiafBH+oGPXnf3s3huRrIQre1jQN3qdaBBamxy+iW/nFEXLUATPmqa/HBinUQIV/11nCZNvBOl42k2ukmhwMpsLrGwaItvo3jINzEYVeH
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 00:14:22.0321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 162f2fe5-f08c-447b-f018-08de904cca6d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8060
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

