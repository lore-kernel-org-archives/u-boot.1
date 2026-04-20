Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BC2F5A8B1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40D9E84366;
	Mon, 20 Apr 2026 21:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xfuYRzVS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA2C38439E; Mon, 20 Apr 2026 21:25:33 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C9798435B
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+NNudGmsqvdwhIybUhEk+4y7qRk9BZJ3UjaPHvhWD1ixpaUp3PXetHQpPqw8G1i9Qv0mvwyjQcglcFRB2IwHax5/UdOe5kjToTaKpicVMRpDiert9qrgysdWvBqjR9etRRJsXnq52RzRLAvXQWg87fsy07XC9GFEaoWmBt7sfiYxHvWDDEX5Cgukja8LCQom3FiAj91x6T2+5FS/z9csJrIZIz9mHukK3jDJAH3foFQ6LHTaGpb1Y4EmMEAGJpFSd9ad6aFlrU18YB3gdk6Pi3ZKsjTz/dPLAbOkM+GX/rE0EDGHnn2I42t17tYj4JpwHE3iXe6Ge3SEig/G4O1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXDloI1kWfNskPImrOGto0uHPd4VQM+HoEUhXTjC7DI=;
 b=YnsIJ/rPB1Cxjz2fRH75yj7Du+Nvwv7Cp4XOP1bMTE0bRvwhEaCLvwBIcWcgkrQ5KJmy+j4Iw0TeaosZQo+1Vlmrc0YQySUhmkGVOuLx+EK/KjmOSFMB2TXV4MdmtjahD0edTxq+x/eGsfSIi8gVeBUUGTl2SnFWXy9Bc693hjCaJeWFCgLZCmzvDXb04QvyB3NlX55VQKp+GbBQZFvLL5GZ9CJm0utIqmFDyRtW+hTJ7G9WZdDdf0MwP2QoS+OHB8JdMSKCalUyi+7L6Ebkx1RKezzce2u4ioNeiVA5szQXeT1ai91jwnkqoTp1awufQIfszxTuyo70flBn3u7c6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXDloI1kWfNskPImrOGto0uHPd4VQM+HoEUhXTjC7DI=;
 b=xfuYRzVSGB39GklDUJJdD9zQTO32OyrNLQ+vX+kvztIyhMMqRKGJjJz1bLc73wyp5dyiM/q/EDYUBBFOIFdGImrW2uFa0HZADnXTV9o7AI0UAnPK4Pcn1O3Q0KbU6uylZXsDSAMuqMedSeFRRnJrcHu9AaKN2AnjrXeWjiX18+U=
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by SA1PR10MB6413.namprd10.prod.outlook.com (2603:10b6:806:258::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 19:25:24 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::b8) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 19:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 19:25:24 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 14:25:23 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 14:25:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Apr 2026 14:25:23 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63KJPNh43399024;
 Mon, 20 Apr 2026 14:25:23 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv4 1/6] lmb: allocation flags macro documentation
Date: Mon, 20 Apr 2026 14:25:15 -0500
Message-ID: <20260420192520.1444749-2-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420192520.1444749-1-rs@ti.com>
References: <20260420192520.1444749-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|SA1PR10MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: a43f76ed-249f-4ec3-ce83-08de9f129225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CO0yK+7j+aEzk5//ATRwXQMto/TfALKQk9Sjn8eIUZNe2zkNduArpr4Bd0u/I3TCkhmM2lcOLI+ZjHEtVQ6It3jrL4MbToKRLc0TkUaS7kp1HZNYMIq/arwB65wFwEX9Yxj1mKh/Vf2dFZloiNooHGg8PmNhbczrlvZiOEOskWSMIVvU83A3ry30ru5sPkltj4JYe7LKBJeqPH50viw/dOYFiYyuRpIzK5Zd51JkEitIAhHsdDMSq6HgtuY36CzjH3nQMEPxmdvBrQtYRypC0JocsABNKY12AUQvnXoMeXbWlDZkq9PZRUNjdycPVw/54mP7OiM49p8xqjve/NZwzaHU9TopTb4uVUwNSZXzn8zG8rKLDcnisbnZ868VKK7HxmTF5Svq0KKOUdeA11i64LtWidj7loxPth/CDvwnsssdVfUgFuXGzpgXvr8KJJqrXbpunv0VRT1nEpDaUr9NkweuN5xNxiJsPLSzrEZGaPMvyf72oPLz9e8HRvqeA61wMrX9v4z4EDYqWyNehMTtqPUCjdtqgPoC097IsirIw/ddK2Oabpmrog+y1b1HtUaIhae53mL5qaDBwyRLrtOq7SdYc80XSWSHbWJBNtda9l1FZQVooLYNzY4PArQ5a29hZmJafkzD06EEnz9COvfO2IyHUoy5+mhgqQ9DwdD1d+MDzE6ctsbALifneLS2uwcSK1Acf5lsYVR07JZvDfQrpWBNw+3CJH5v+YAsOZw73SIU8eQEHZ+8+YF+aOdsWWD4ZtVszIsi6pKQBR8MUkDdlg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EwExxjKTdfBSaplAPf/XG3rPtWCTyDcqZSSb/d+MXoOD2UMT7RJLZb4Wx8C4B7hNuL0UGODBV1Qtyoj7OQA6RbNRNwOk8qX6Mmxqpy2Dv+VWwkoWiH8FMYublR6m4bXZBHgxKe6dvtJZ7ftuUt66rb4ndPBdQeD+J96ch/6xqe/+7MGegtWbVIFErif+rE5+hzno+ifR3Uz4j+X9I7+7l/qPrLujsX8kfCAOWBnYIxRwFc+cUVDBhbRK6/42iOx5CkzU8UaL864fIDWIHYprQUNhxOMs6S7dAgPD+DVYe5dl56OsJehPbG1bqQ3wseyZaE5FSgr/Ufx7KsAROoIgmJ3J4qqgNLxn1H+/B5HHV7uFdcgqozyekXNcf+rufNFa1UmfGAGkW2LrP1pT6QLPK5psGN0Bg4yEcV0056iSciNsWKfpETYxyTI4z5fCMF1m
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:25:24.2083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43f76ed-249f-4ec3-ce83-08de9f129225
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6413
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

