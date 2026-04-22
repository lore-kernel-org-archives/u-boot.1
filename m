Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEF4FA1FD7
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 17:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F32843FB;
	Wed, 22 Apr 2026 19:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LWy2DR2g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEB7E84370; Wed, 22 Apr 2026 19:10:09 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FF78843C5
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 19:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cayies+RJoIsLLtliOzAUQt+MuoWXzYGGcAMTGZThGnb81BUjPZj9zUwYo+8r5uSs2Gd7JBnXTuITX+uWy22ltEOaXfL4hx3BTrvTxeGuQvq0bEw8852IJUeyfB8h7iOJPLNuGkYhrffWZ5bMMfORWcbvMg+jsVIs2ARh9GbMPnzlAuCZ6iAk1To1ptpkrjWYB5EGvRpD0R6nClajT8zVDScnsdDl2UMqSX6fbF6rLR7kJOGuxg9TtdE0HXhgKjwRAIBjj1bp2NwRyXqWKv8TzGyuJFguhGkwAUbwYL1c5SXqOqvkr2GupKlAUuyJTuJAmez9W+vrwHc/Rvb9trNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPQEel4MmKWS16hH+JoHX9OgeVT3Jy8Rj7QqUqrZxuQ=;
 b=KMEyUWu60akxwj6EkeN7Dnu4tLR+ZPJIXQ/a4MEKsLOOEj1lF01jKTxpH52VifaqG1LM0MyrvsnQzWjSjnw/X62TGSuLt8zg/MLwk93nE6xifR9S5cea8KErqOBcgve0po6zIyprxf2erWxqowCtsBW/gxhUNUK9OdOrqDHqcVW5mK+lw8K90nYypC92Ei2rO7ZiqsL4HKr6n4UXZ49YBY5VePeEbEiB2yQveqjFjCuQXadhMatXrD4LwVD8Ks1ZimuE0eGHZC1ZE7GqMX/QDU9qnltK6NkJgOTlnZ5NJ69ABIFMI9CWEUnzooDOzQpjU/6EI2CQK9ehOO/DJAUxhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPQEel4MmKWS16hH+JoHX9OgeVT3Jy8Rj7QqUqrZxuQ=;
 b=LWy2DR2g1olyynTVrshLzSN8QGs5qnhhPulKVQyFVyJxXOQxYWUqBnVNPuerDEmpGzXEB8cucemG10/LKS+LYiF5Ug0PhW0fIjTlUPNW9YmeHG2ejSteM7t/tsSxHkbeBCjDXYO/hnwGS9/z1qRs0O7YDBjDTShWxL0uGNS7UWU=
Received: from DS7PR03CA0322.namprd03.prod.outlook.com (2603:10b6:8:2b::29) by
 DM6PR10MB4251.namprd10.prod.outlook.com (2603:10b6:5:21d::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.20; Wed, 22 Apr 2026 17:10:01 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::d) by DS7PR03CA0322.outlook.office365.com
 (2603:10b6:8:2b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 17:10:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 17:09:57 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 12:09:57 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 12:09:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Apr 2026 12:09:57 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63MH9uPL2769561;
 Wed, 22 Apr 2026 12:09:57 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv5 1/6] lmb: allocation flags macro documentation
Date: Wed, 22 Apr 2026 12:09:41 -0500
Message-ID: <20260422170946.3394481-2-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422170946.3394481-1-rs@ti.com>
References: <20260422170946.3394481-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DM6PR10MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8aff14-3a0b-4649-58cc-08dea091fb14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: zdjw6liZh6JlW59mu95fIdDgVsY5VH8yGuIiIrQDfS9I7Ow4XywD2ZcUyjZ0GclNBbXG0wYkOlbeU07RYDnWeD7y4qhgUVx735iCBebvt2u3DX9/iljbN/+HiCsCQjM/aNVU1rmF0RitDrCgbmJVSDt/z/nJEj/MjuJObaMqMfC+XwPEL586isWGjKQQu8P7oCMMsyzDC1Hy7Oo3J3AZOiD/6z9RGdcCU3bcTOHGwVLqF7AZkDym2UDrlj3VFuaqjp2mqIGdmixdcm7bhTwFYRvlQZ0eSKimE5XfUXVvyiKRTJMgKgAMpjC0Ds98QgoeIIO8RKauL7TnenuiVuW79cXLhl8/mdUXsuNiTriCOeZvXFhSPagXBZdjiBI2C2CpLo327aNW+7SQ3c1BSqWRSwWPXltKdSL75CFaZJHwN+1DKeinQkg/RB0/kQv9k+0HAZ8pKR3OizN+S4e14aGuE1rEwgMifLdaTR0EakcM0Ai2aKTsO5dRW21XpODqfi2HsZ9RmZjQKziPoGCWjmm3aI5ovLZxI8SMuYaL/TaYt/F3YgKKXHebmimEPXQ7+EbwjyM/C6x62rvOkozLpPVXs7yaWX2MJcu9gsCEQfulJuzmH+IcFWzU6mxMufkSQiH/ArEJMF05k+46IX6bXKhyNsOMEeoqw1VQNo5qKgDBX1gLXfxFXGtaBgnpx4u++fS6UHAjXC5JQmbwnVogX2CPkanp0UJUiIY1bHJtTbcYdG4ghCsx4eIxyZ0H9zd1GO6Z7s4cjR8Q7ksro06TEUZUTQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U+/NwEfe5tVWuXOVtWzZu5SXY5SW0RAQ66uXytD23fz4COnrP6W0AWN2SjG4FoHVWftzKTFiyL7O8Z/kg4zc1GgQjOOWdQv2dwthdTAa/inzEU9x74gWVUxEbxhzWTZuONTVj4zJr76uY/XIdV6o575x5IholF0bBbc2cSvC2S6BI/qvbsiLhcKWKIIbL3nRvepqjEa+tS6IZsteifmxtVA+WsOX4RxBUKPH1nKk9or1J8+eam9BEU55QX4pjP1uY6xekTS/dbTb3ufXOL2USCBzpeUdcULH6utwCLgN1CQcFDgOZOsT5oyr+JQIXQuefojRnBi6k0IYSqaYpWnjk4X5rZUQdzwTuHo4MxMpLud83qa5xpJlP+o/S8RyCGVakR3b9gTjVH0VYjAMJpnE6owJSq2ZemKVH9QadKSwr33RcB7ei2N9VumbUugpGC3j
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 17:09:57.5471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8aff14-3a0b-4649-58cc-08dea091fb14
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4251
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

Update the allocation flags inline documentation to follow the kernel
object like macro documentation specification.

Use active voice for the short descriptions.

Signed-off-by: Randolph Sapp <rs@ti.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/lmb.h | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 5d5f037ccb9..ed472e9ef2e 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -19,16 +19,36 @@
 #define LMB_ALIST_INITIAL_SIZE	4
 
 /**
- * DOC: Memory region attribute flags.
+ * define LMB_NONE - no special request
  *
- * %LMB_NONE: No special request
- * %LMB_NOMAP: Don't add to MMU configuration
- * %LMB_NOOVERWRITE: The memory region cannot be overwritten/re-reserved
- * %LMB_NONOTIFY: Do not notify other modules of changes to this memory region
+ * LMB Memory region attribute flag to indicate that there are no special
+ * requests for this region. Normally used as a placeholder value.
  */
 #define LMB_NONE 0
+
+/**
+ * define LMB_NOMAP - do not add to MMU configuration
+ *
+ * LMB Memory region attribute flag to indicate that the region will not be
+ * mapped by LMB. Normally used for reserved regions.
+ */
 #define LMB_NOMAP BIT(1)
+
+/**
+ * define LMB_NOOVERWRITE - do not overwrite/re-reserve
+ *
+ * LMB Memory region attribute flag to indicate that the region will not be
+ * overwritten or re-reserved. Normally used for reserved regions.
+ */
 #define LMB_NOOVERWRITE BIT(2)
+
+/**
+ * define LMB_NONOTIFY - do not notify other modules of changes
+ *
+ * LMB Memory region attribute flag to indicate that the region will not notify
+ * downstream allocators (currently just the EFI allocator) of changes to this
+ * region through lmb_map_update_notify().
+ */
 #define LMB_NONOTIFY BIT(3)
 
 /**
-- 
2.53.0

