Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BC4F531CC
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 20:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2137841A2;
	Mon, 13 Apr 2026 22:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wZ48SqfJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC9884207; Mon, 13 Apr 2026 22:36:26 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF4B884199
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 22:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTOYCRcEi3xBID5zy7g6f7fFHpcc4+3OMy8/1p0Wb1IbMdWTSY+e14YXsj4Ujix/nYP1Lr4pggf7LTIdWjThVxsk1Q3LTquW0tPHR4/OIpbbS6HNcvOdd0Ezkbb4SeNHkK6EJC0xewN1AdPKG/sJIXDL4wZDrCSH4i2u97bEFUuVFjuBkKEM2WKGI9pqWMHOZ0Hsrn1ySBHj1r3KmsqU0NQ0iRB5LtyBfZe09ZMiRfyjMszezbJT27CjWjCkEXeBNPX6a9afXfZYhEvTfGgTWdS6X6mJtrddvQfHhtvMk7+lqP1zSfCwTyb0pmtqZnu0lXrq7zBmGhG0peZcx8iZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqgjTY+xD4mOL70HfTIBydG6C9BPEjyMvVWUMsD0axg=;
 b=oBO8w5r67Ds0tg9ieJDWwVPCcj5O87zqY2gKhYxBr9J7R5kKmMTRtzVkgTpjBObw9mL1WlFfzgJPV7o0+tbBKl0NamsMEfpGilhdG9L1s2EM1oFJdTtWuWJUrLT+MffChfsLQitioc3CagkhrqtThBt5kBOi7zy9HNz/Zrc2QSQOxfsdQNuPfy/uAesxdIUh7pDv+lkQyEyVisr/W/ccr2nsmrtC9sOu3+8sbhc6goQ+PIRoKYzy7HfqBuKQ1xHKvETginEP4Wuf+ckWR5Dw3T6ohg8ffw3/WjaU+0qXpqRWuY3LmJc9s+DRuty7RXzNmTtFhP6Q/uNR/Zvx2KxUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqgjTY+xD4mOL70HfTIBydG6C9BPEjyMvVWUMsD0axg=;
 b=wZ48SqfJPNjgCtePVSJao7/AVVZJv1nevVxz2nRUzS8L66100SXDPfBNxDh+wn73GK8AnokMz8zvmdl1YsZZhBuYp3AYs4fLoQ6di1SOOBWbo8Xtj5PczIGceITc2byCASn+YPJdbXK3f4vDXD4ZcnS0RoaZ+7ylsq9PyBmbdHg=
Received: from SJ0PR13CA0039.namprd13.prod.outlook.com (2603:10b6:a03:2c2::14)
 by PH7PR10MB7765.namprd10.prod.outlook.com (2603:10b6:510:308::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 20:36:21 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::c4) by SJ0PR13CA0039.outlook.office365.com
 (2603:10b6:a03:2c2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 20:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 20:36:18 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 15:36:12 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 15:36:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Apr 2026 15:36:12 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63DKaBsb2729634;
 Mon, 13 Apr 2026 15:36:12 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv3 1/6] lmb: allocation flags macro documentation
Date: Mon, 13 Apr 2026 15:35:50 -0500
Message-ID: <20260413203555.1990337-2-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413203555.1990337-1-rs@ti.com>
References: <20260413203555.1990337-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|PH7PR10MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e48d6d5-34a7-47dc-f2c4-08de999c50ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: MJvuueFJ6rNna4+1fhHAmjEEqjqPexnJWDB7mhHImD7015Aymefe3cBM2SxreSK4wh1PbzokY4stovteODVfzQYj3nCCHEAXB3Di7KY3D26GfKtBleiAjTynExwoMrRecerxBr6alugkS3Lm5ikcoOHp9rqntz7SsdKVnXRjJdtc8pfnJoPmbPFVBHgzFgz1E4sgZhmpWeyAB+iQWQz3MiVAhp8maVWG3yWFNn/6acCQfKp+jAjHklT4//T3YcpO3yQ8LChDMkHnpOjgEKV9TSCZFNTxFHt5tw7LId+C1W4UhSpK1LAlBPX95lN1fNSu1B51a3R/q5pndry9LU1UlgUTdebKN8/3r1Dl83tHlJny0QJq9f4PcBO6nyTHZXKk5a817FLMvKdFrEloQyLLm79ld4z86NobLiB0LmCKYkgQmUfbx4Udg0rYENk395i3t7wdFtTw9wLkTDU41VIM6G6PjhB0A0JqmubozqaYJR7YolZIu/3K4L7XU9/flv4PBfgiEn4wLG0cehjYwdGndrxCDUaYYcazH07kW2jqv1cnHijt4i9ZfeGxGE5GZEdw5szM0fwKzispDVomSsPAx2i5RYyPYkLQKOSZcSDRTTt7iy0c+cgWOnySyJ4OFHkUBVKYYfQi2Wf+9IlRwnlJU60c+qmYpD8muTXp1mbq/tUczq3W93S49tv+m72TD9iyMSjys2I91ExrwsTDAD/6G8yMR478vlKQphxlqIhSWwECdXdhqHm7DnaBPqnzcebnhR2g/pwaPsYDQXzuRzSnHQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ecS+TawhN98tv+HngbCjtbkH16nq9DZomy9FQf+QzwfJjdXXc1qsdS1yNIxbrycn7ntHZBjrQyBAqt93ZIwTamqEF+xxzSQ6aLVtYJdbE87NW6sovgWR34T7IyV60kJGXfd5CRGSAv3KF7fMZJzIHIeA+XUaLCio9Ufl8+UY8/2+S8XE+OaZPQLQtz/aw0JbTiWGNrLXrNm+/w8XWgeHA4B4vcR0+VOELmPESoxFpYrmKK8/KmsNMzuI7wj06oSzsUUQdwpNHmyJNOL1uoNIOwUGqKFTdqWXgFzXprzPkTkC17bkx8oQ1wAWoOb/ydFLrvDk6UDT3Dj2O5+Dh0prflpUX+NHQNAy55VWqVeesLyTgL6BJgJ/8kvy7Q3UOT2Q7bxlQKpjM0qQ4DKElcklSNSmUBQW3uNDzvvYUAgQUeXQfnRNikT7i1g/NmgtkdHe
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 20:36:18.3534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e48d6d5-34a7-47dc-f2c4-08de999c50ec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7765
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
object like macro documentation.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 include/lmb.h | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 5d5f037ccb9..427d701bc30 100644
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
+ * LMB Memory region attribute flag to indicate that there is no special
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
+ * define LMB_NOOVERWRITE - do not overwrite/re-reserved
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

