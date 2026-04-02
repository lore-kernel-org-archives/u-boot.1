Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC09D6AB10
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 20:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8512784056;
	Thu,  2 Apr 2026 22:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BRmVbxxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0271E80212; Thu,  2 Apr 2026 22:51:25 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F369B80212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 22:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFRi8306KE+o3Vu7Y+RVZMoJF81tzqHZkuqzaSYRJuzI79laqkBMTVBzibyQvkJP74Z0KJPBbD2XQi3fT86WNpedR6/0H0LD39AxbrdeoIzOHFHFHvlDZTexRbwg6f08987KgzpwCgNcPWwBKVPDqdKzQmc13qFX2IiezIrEZQYivFVj/RLDLukZSNpaFS5Sqabal5ZonlTsPx0/jf50AuiVmkAtpt+7a+rd1mBE8XYkl0MEoQZPi+AdLEEnjFqAcf386mp0TnuITjzNtykFWdNuMrU6f4vHNO3UbOct2SrKN1wjNEVFJTN/t4GClDw1NQdP9g1hULTUVI6u6dfgbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eq+tB3bgbR8TKICMNQRm6vnQICrwF0l75XD9ToSuq+o=;
 b=L7Qyu1SSfgv45+DJ/91NCQsBInkTrxrVC/uHQzl0JwvxbAtLM2mFkVGxa9LD6tGo5hPoUF25crYsfB7y7OD/DfTH22trWr1z9q21oPyz/zosQ4nYb6IFNCWY+bsgck2J2q6lt5MyNq+60SuoY3mTki0trXvT6mIDWtbQNtD5tdLWhQqNHwtznJcNGOSEG2Rj6FRJH4eBxdD975dwR+TNzPiLyKC3xgSbSWmJLlZQTnf01NK0n+f26wLdJWmqcBwQYfvEkfozSkVNKOomKREFC2aB4+7UPteThr+oEGyiIBVkGbXGmS2NWtZhLNEfcTkncG7JEX6kepBB1ydeakuYvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eq+tB3bgbR8TKICMNQRm6vnQICrwF0l75XD9ToSuq+o=;
 b=BRmVbxxdtAgGuI7tgN4VewzfbNdxq/9hHZYJLJtaJvHvp4MupSDuvjpjXhRIg/olnvp2fa+9WFCcGZJZ3iRMQIRPObb9rH8bGAK3SLwePwJv6j6r/v9ujhuitVZot/jYj3MQcJzpisoDk5zEyrWoYTxoF+IjMJl/a8fiYSR+seE=
Received: from BY3PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:39a::13)
 by CH3PR10MB6788.namprd10.prod.outlook.com (2603:10b6:610:14b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 2 Apr
 2026 20:51:18 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::4b) by BY3PR03CA0008.outlook.office365.com
 (2603:10b6:a03:39a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Thu,
 2 Apr 2026 20:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 20:51:16 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 15:51:00 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 15:51:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Apr 2026 15:51:00 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 632Kp0bQ2708543;
 Thu, 2 Apr 2026 15:51:00 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv2 3/5] efi_selftest_memory: check for duplicates first
Date: Thu, 2 Apr 2026 15:50:36 -0500
Message-ID: <20260402205038.4005350-4-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402205038.4005350-1-rs@ti.com>
References: <20260402205038.4005350-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|CH3PR10MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4bba51-f444-43cc-da23-08de90f995c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: f9ifWaPFQ3uWBW6Zbe1sjtA+shx6Egm3AacpvzvGikdIGhBCKB+ytIvJQDEAgKZPAT+JzNZ1Dzl7gQGyMMs6YzSd44KlNbH8vrrCvbjkvnqQTkCY5aj5llQ9Grx32aqGcoMRHb0wVnyC8PoL3yiDOVgOj31522AoFr2JQpZlB5JvlGD+zCXa/sfUKMqk73YXE3nXUS5CfpWWe3SAjrzngImFMUyzwy/U1g0KyFZjXYMITBMRvouS+zE7fzYZDlcEkVPbd48rLyAXVLi3Z6v3lHhWxwW06zAGqNA6UDeW6M24NwhFc0xE5BqgEBGw9r4uFT20d4Pu8fMil9ISCGf4OEgbkA40FrrCs2Zb92lnLalJoDyYNV54UZkwb585+W6fnbNMS52Qrieid96ccxZSpJlT2rvDHgSAcZUeDE9A87k2SJLsWUr3VMsYsdsWpSSO28ClH/KK4Y6142qQPxvKxW7UnUDAPXDOXwZ57twYC/EhP4oseRhRGt5Exbc8sFpoqTFB310abGvWVkcFHk0Bwntw3cSY1mGRCAWGZx7iukDj98QqyllGvGHT6f7Vgj1Md31DeFeuhOq4IFGcxakQqrZKD6bFwLhWfyGrkgZ2Vc0MStE1zNhv9j18q9CFtX2StZ/9lMX/6jStYWohsKy3ZbnrlpTIYyoEyS1FqVFy0u2XoztOj1rgUbXb4EgS/rt26C9IiYmeimh38oJtRoExwLblaas3jYuxh5y8I9OJ4Mr2yfwSukbUTI09mHmsvEMKxR4tSTLSpicplwzgCISE1A==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 51dUe20utSYZSWW/31gLJnRFb7FB9rp03jIEpcfaPXG88iGeTY988D2JejfyOMvg27MkPiFJwCsV6EaiUBfco6BGsgYnCTcqL8emdGwNMTSUfJjg+V9AN19myTnp1WxTFZOH88CP7YVhs+rHkE/5t3kBFnSKlPk9/X/+4YL0kvHWVbZ+xdM7Y2QYBBKwrT4aCSPhyjY9648BVqCOfjWsm7oiXAIeAGabny2jALaujyu8pdlpiQhOMv+ko1Q8Jo3t2YOPVow2xrJkXsYxlOqJifThGCl+CLPsmfCaASpoURjHxKbh0LJtwWO0LqxV0E4+nktGnta5AEtMgeX2aSj56fB1YKyZdXwzMvLfI5mp4RbWSInBFHGMkEsAAQgrO1xP/2dC5Sy2NB1+9uV2auvpBARjCmFFXlBaAMqJ4d+EtixTf5XBzXnV0FW2gdeaAkX8
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 20:51:16.5879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4bba51-f444-43cc-da23-08de90f995c4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6788
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

