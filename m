Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C72F5A8B1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:26:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B1DD8439E;
	Mon, 20 Apr 2026 21:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SX8gQDR7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C087B8435B; Mon, 20 Apr 2026 21:25:33 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 404A884368
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIN7/rv3WeivsgIKm8943Hq78yIPajUKZ+4ITH3kmttrPgqESuUVUFOX0oGHeFbwuHJc/lBLSZ+Si87XjaAGq2+AuhKNTXYxwzME5b1YMqF3I4ZhmOAppMTsddw8lj+hud25WCbLVmwIzJdHMI+emvO8qpWVQ3pAWDw8w8YN2ArUbuIyNy//PSWdu6PcVub2bSV/xZQ1neDGv9xwVLo+yJC0FG2QVidMsEqtUWrvYb5E8Hx99NDVRoDgYNHDo0MN/JhyJMPATdGCDaxszG0geGZmJJAfqwvm4COvi+SrANAqD5HLJnkh6ZJF48G/2v+5cv/mKRVCArqwHkgLMXs9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdcTv0+2zoc9+J4qVs/bczbAwtIlqvAH2DxqeUNyNWo=;
 b=NfB1an6cuAVT/NvCjyXeUh48PwEoc7XXkYyzC+0+AjoauqoExgxsGoMqVE3QRYO1YGyWRfldfLLx44W8x9J6F3g84huVv3UaDy+WU4/OxyeZO6b0tiUvTe0uXb8U5/P0yfVZH6xWtzKhxSvT5t/Qh5H2Trb+IgKzdZW02Cdnj/lL7UVnGCzePSRLCaA0kHUwf1UJ4/Obpn5+bRAnDE30XMvY7hf30BXabReOKHXbbryVuIRSbEnLhHpzGMXTTQ3tBW2JpzYCrzABqFgucwUZVxLqSI6co7GkicVaTHf5LryuIl+ftZrNZpBCXKni7Fcli8SRoIDczj9nn8AJDHnCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdcTv0+2zoc9+J4qVs/bczbAwtIlqvAH2DxqeUNyNWo=;
 b=SX8gQDR7MODMh//tOgMW6x0i/HwhadZz1EOKDlpx82qagZPca/v6ij/re5ttTFbWtdu5lqLHx2zmGw7WaTzq8UR42ffgVBMTB4NdBwuBYP04QeGZP9SouVahgb7ThkBNHW86EoPXI7rmnadEz47IiAkesIuwEfXoBVDPEpNEvvs=
Received: from MW4PR04CA0307.namprd04.prod.outlook.com (2603:10b6:303:82::12)
 by CH0PR10MB5132.namprd10.prod.outlook.com (2603:10b6:610:c2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Mon, 20 Apr
 2026 19:25:26 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::ba) by MW4PR04CA0307.outlook.office365.com
 (2603:10b6:303:82::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 19:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 19:25:25 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 14:25:23 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 14:25:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Apr 2026 14:25:23 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63KJPNh83399024;
 Mon, 20 Apr 2026 14:25:23 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv4 5/6] efi_mem_sort: use list_for_each_entry_safe instead
Date: Mon, 20 Apr 2026 14:25:19 -0500
Message-ID: <20260420192520.1444749-6-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420192520.1444749-1-rs@ti.com>
References: <20260420192520.1444749-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|CH0PR10MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac5c7c3-8f49-4274-0a65-08de9f12931c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: HvVJJ83oPnTpPxUUqYY3IGHC7ECJi4ZR124bJr+cyu0wk60xUMHSubLeW031T3KLk+mw/ZlocHjKqNrxhNhIB54VMtT79YvDkg0yKhH0tYbtCQISkKpYs5B9iCx/I2l3KLHOaSnhBGP37mdO/XcUt1ROIv1RMxC6KqHmTfWcx7gWEvC5G9c+1gJhTqARRH+ooO8BrcuFT0vEPmnfywYiDaTz//2BBrCRoz1NwzlJrej9RZxjscRVPLOj6ZpO0GGMFcjwnzSwhQj+OBXB93KtYbmJ23B3Y8e/JLxV36odlHp2CnotzsnP/OVmWa0EfHrt0zgI6/cWybd83xuR3IvfeY/4NL1SEfuAyRl4egICRPyKeM/3O3hY4JvYvFvQS1r4DMlYjkilWNj1rLAyUivI3O4o0W/H0OigLxHoc/mSCqVSXGBB0m9p/WlMj7d3w5lc+UYaBAm54uE4JH8C+mmO8tDHGGJKaQ+JAXT3NrIgEFDZyRsNZyjlzkh6g5EZxmyjvlkrVXTXQ4ZTeRtMAOWCqDEq39joQ7x7jXLnj+hMWXos2fpPBeaIssJtJNE2KFijnYGKOMxZHzLVQzqDua17NlvwcNW+oL3M6ktR0EqUv5TsVepH/MTIjZznB4UBMSFhIN2KEQ3Jz/9o8hG31ukO3u7CRX9gqb/uiOxaS0ldIfhQV4uSFfgEvkYmWpI4co4h3zZ8W+SMo7whiaU3O+YKnWTS0il35RcO4H2AnY9Aan65YCJqLMIVVrJGpIn95WWj3H1ahK0GYRp5+akPrJgjxg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VHzDLU8q+fCAEaZSlOkx9w6peIMR3QyNmronxsbLMfqu6F6/pMJhrsJKnfxJkIBc2lNu9z+7GuWpQ8YX2MEdNfwMvofbk4GaMo99A9uNre08nwKw+PifWVZP9SNNyeEwHZCwm5kkBfSFAzlJagZbUcIRFeMqm9Jd5fnBPPfOrqBMXCa9ws35BhbVdYM/TMyRTV81odgsGou4+0QGG3dIAhASvb9IZ9EdGSdJ3iTJZ21+/ANlVJ9K+fZ4OTNbhEYw66WizqzrGB/LvHSX/XaR/Ad2xzgqQtZCRo4dyKi6xUtJkJsQe/eSlDAaR1qCY7UATooGqXnfj4Ltxvj5dwwj1f4tgOsuYoruNTwa1rhndSxIygQZbHapXFD3RFY97m+SEY7pqZ/5MjlUdMPZPfoJUWh7U5NJMnvQSDsMPE80O3gXn+MLqrR7u/cdCASb7Gnd
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:25:25.8227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac5c7c3-8f49-4274-0a65-08de9f12931c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5132
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

Use list_for_each_entry_safe and comparisons against the current and
next efi_mem_desc. This reduces the computation required for merging
regions, prevents unnecessary additional iterations of the list, and
requires less temporary values.

Signed-off-by: Randolph Sapp <rs@ti.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 lib/efi_loader/efi_memory.c | 47 +++++++++++++------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index b77c2f980cc..046a2bb4641 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -128,44 +128,29 @@ static uint64_t desc_get_end(struct efi_mem_desc *desc)
  */
 static void efi_mem_sort(void)
 {
-	struct efi_mem_list *lmem;
-	struct efi_mem_list *prevmem = NULL;
-	bool merge_again = true;
+	struct efi_mem_list *curmem, *nextmem = NULL;
 
 	list_sort(NULL, &efi_mem, efi_mem_cmp);
 
 	/* Now merge entries that can be merged */
-	while (merge_again) {
-		merge_again = false;
-		list_for_each_entry(lmem, &efi_mem, link) {
-			struct efi_mem_desc *prev;
-			struct efi_mem_desc *cur;
-			uint64_t pages;
+	list_for_each_entry_safe(curmem, nextmem, &efi_mem, link) {
+		struct efi_mem_desc *cur;
+		struct efi_mem_desc *next;
 
-			if (!prevmem) {
-				prevmem = lmem;
-				continue;
-			}
+		/* Exit when we've got nothing to compare with */
+		if (&nextmem->link == &efi_mem)
+			break;
 
-			cur = &lmem->desc;
-			prev = &prevmem->desc;
-
-			if ((desc_get_end(cur) == prev->physical_start) &&
-			    (prev->type == cur->type) &&
-			    (prev->attribute == cur->attribute)) {
-				/* There is an existing map before, reuse it */
-				pages = cur->num_pages;
-				prev->num_pages += pages;
-				prev->physical_start -= pages << EFI_PAGE_SHIFT;
-				prev->virtual_start -= pages << EFI_PAGE_SHIFT;
-				list_del(&lmem->link);
-				free(lmem);
-
-				merge_again = true;
-				break;
-			}
+		cur = &curmem->desc;
+		next = &nextmem->desc;
 
-			prevmem = lmem;
+		if ((cur->physical_start == desc_get_end(next)) &&
+		    (cur->type == next->type) &&
+		    (cur->attribute == next->attribute)) {
+			/* There is another similar map coming up, reuse it */
+			next->num_pages += cur->num_pages;
+			list_del(&curmem->link);
+			free(curmem);
 		}
 	}
 }
-- 
2.53.0

