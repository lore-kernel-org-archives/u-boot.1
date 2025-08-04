Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0352BC87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A18683D77;
	Mon,  4 Aug 2025 03:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="kqWNovsF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DBDD83E9F; Mon,  4 Aug 2025 03:25:36 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 386AD83E7A
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgWqXcQf+cKNx9EzC+lxtjkKhlSvOdRTIQhnttfamdsn5FVk2lBcvZkkMj/u/GCETXMQyVLg3G0YCRCzHiCfxutSup29A6hMvaiUScZb2xmyUr7fS0WQaZuGB5YzdCrGmZOZHKNqx1muReJJ0OJjVenx5wiDun0CjQ1rSlFn3PBJ5d6RLSJ4i6h2KsCem74Nm5+4x/9bkC8GeJL7NWCPjfPEEr84jBScrqyKHdb+UQ1rL0OIQ2uR8+a9p0t5sSp5vVXBb4XE0NxFwzGQBl2I+v9PHNwOfQ38sc5Y6ov33kQM5a0R3rKweE3qjnRHaMia6cd5aiuscbTCAPCTqoEyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=me0GEVxoDb+NAFKM7hB/9rVOnNwfkh6z5iiciwGqzqM=;
 b=RHfogSdaXZG0H3Vp7kL1lQVHK6k0iXNr8JqzO3a2LFAwYIVcj7I37b6+o9TISnWVR5Sir36UcrvXjW8ILjbAeYvhYYIjh4ZvqdSFsL0XO29Zlcb3M7RrRYKMrxeASqD/6WgN2pneZYvzS5ZE6mSJtxfg70EC0FMUxMsxeNZ4WNgBEbTm3EMK3dD2ASpfH8yD0gM3Z8qUBJ8V22PAxyHyHtMo/2xFcVFybnDYRqQ2NgxLuz0t6QrHq83jRxKsGka27Eoaf8HyeoE8qIhbpRxkftI7geWkMUOoGdC0Bvyj+Ll6UamIOz9S5QmztBjinbV4U5a2N3U7JK88v+U6mvQ6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me0GEVxoDb+NAFKM7hB/9rVOnNwfkh6z5iiciwGqzqM=;
 b=kqWNovsFiXN4fyK65We2VQJWH8Po0ICrk46uNmoqYoX3zwkoXJTUy+u/JT8zr1ivWFH/z7pYvxo0CDfHhhukhV660MssiQkQASTYCxBLcW8nSP0DjaMSCc3bfqBAyHJocNiiFpw9HSgtOSPmiyiCUMQdzjtZ+e5FP6GnbpjCPyrK8bpUr/tRbS19y78QZC7xTF0sCGRBUYR6wFohlrf+eNlXGWF4OY9uIp399SJzsMggMWyAExExnkGFUklrlKQR6ilwR4NrFlVLOyWKjtB60h7voyDBXIzmMxEMWPz1Hb1NwI+0ESxDw63zITKA7WXxR4p0Xw+sYTDtfQb3q7nYkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MW4PR03MB6346.namprd03.prod.outlook.com (2603:10b6:303:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 01:25:31 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:31 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 25/34] include: configs: Add config header file for Agilex7
 M-series
Date: Sun,  3 Aug 2025 18:24:52 -0700
Message-Id: <20250804012501.21811-26-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MW4PR03MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 5631172a-c8d0-4636-186c-08ddd2f5cd9f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Le5O1V1CxiabbAkXbZHIwfhIqeP04WfD1XPM1hM4Q9rKxupYOL9MN8x6DdmV?=
 =?us-ascii?Q?eBuqakt59YZ0jL1TQ740wPwmZKKwL/U8ecoV4ZXIYpMSU+DxglqMcBbLsxc2?=
 =?us-ascii?Q?fiZxkO+MenkABNRAKONs8t5UA/IAIglsoXWBw8rggQSaVECHGpRn5JVoHYkU?=
 =?us-ascii?Q?ReSXY+A7/ttpKpTuiStiVUc4Dr6I5VjHbMx6Dw6dKdZkrCLvtjbB+j6mB6qI?=
 =?us-ascii?Q?TaquFrPaBDht3rUCrC9xSJrY1SZjxwu2JrMK6Lcjyns0s6yYLA9j/5i1iAYb?=
 =?us-ascii?Q?7Ku5yqnJ3Jwqgqno00QVlkodPbifc6oPAuxdIhSaMq+K8X3P+pXZwKHwC+6w?=
 =?us-ascii?Q?0lc7xvggQBs1ZLtd62H6iP9kCrlv48yf67Q40DnSNL7YfVvwjvm40kSmyIrU?=
 =?us-ascii?Q?U2X9lsJq7iVWcfTu27Rs0223w2XBtm9AaRKOPfOaZMNKlNJY/4FWfxoWrqAm?=
 =?us-ascii?Q?2yKXEpBQNEq1OV2bSZ/BxckHmRq2i7SDW/9hbOK5hrEKbAIKNxiLg+LFbDUU?=
 =?us-ascii?Q?RbDen18ecaVX+nbcxbR4KCN+LoUzFtqQtHam3P2AINQz5t/xv4oBGHWryeKC?=
 =?us-ascii?Q?Uhnp4Y9+4bSlSsMHV6tllk8tPx+2Gl9JU8x1Imh/O7x9GcsE+G7MkiSL9xYz?=
 =?us-ascii?Q?FbN1HF7/lSaTRBYFkQQgIqCkFUnBpId28U5EfNq5iyyeUB5I5LKO+ar3Czmw?=
 =?us-ascii?Q?AI9P+XDbdynJEV/jp7n/oX4W20MpZpkTy3dwSNdWhScwOO5W2PCUl0S0Q8g8?=
 =?us-ascii?Q?D8hLPb/gSsOFFlkeX5ZHMky65HcusrUjyz6OzCfeXe4D9Xf4Yizeaw8GsXff?=
 =?us-ascii?Q?I8DGD8QbGswRRGWqOGcYM65i5wwkBSCQMi5kRyJ/R7uQZ/ZUHS8EOzGEdpIx?=
 =?us-ascii?Q?IdJOV9cG3EilReCw+f2xMg3rKvmMJUhHseQy0qu+8FuDVSiIFKOTsmy0Cc7q?=
 =?us-ascii?Q?XwzpSWhsF+qc6rY5TsmAwtVh2xJ57MTDoqfLOoIMHYAC/j1gJMkh59sbn7gr?=
 =?us-ascii?Q?VB68KclCPmxggqteZgqbIUFqzqyOpDBqXopY7cK41KxnIR8/aIAe9keavbUM?=
 =?us-ascii?Q?NPX2xxG2y01v+6u2o2DHRm8WPwLqFMVQlRatJmwCsj91PyifhaaLKCL77ryt?=
 =?us-ascii?Q?xi3/mtda+j9I1cPyex7flDODmRjcUTEi0LlU0HatLsQMh+tzTtaYp5lJpEMO?=
 =?us-ascii?Q?EyxigfvwOU7APf7g5t470nd/xvI3AERDtk0pxplwy3Z1iEhatF8I80RZvrNy?=
 =?us-ascii?Q?Den/KNbibFQxjaxQrbfmNEWNuvYgg63gUBGnv3dIRGxswYgS0Oyr/Qu+8Yp3?=
 =?us-ascii?Q?E/FUU1+OIjKFvAy3Oc2faHeGhmpOJ4rmoLDz0rZgJbpRRPlcsluN1q6i2qRF?=
 =?us-ascii?Q?gcjQCRcUJJjkHioLO1ggB7wQDH+i0dM7B1AOJE63ysvUdAEhNH26NvxI+ZiE?=
 =?us-ascii?Q?6sXZEbJs+rU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RhXDG56NxLkxDiMNQbVBDQYY52dAmXDKm/VbgOpOGydVS/JXTFv2+SveRrGg?=
 =?us-ascii?Q?LuIXcTC+073qKcKZNQ+PbFTJZY2BgRKxVwK29V8KoKoAcXktuCA2dfbJ2J8l?=
 =?us-ascii?Q?m1O/qJ0YQgKdS7U/+40LPNzu8jnwfJ4G88CjuYwac3oCCQH6Jn+m1oyNxMn8?=
 =?us-ascii?Q?kwiKqGNz70/if74NQZ39d72cqgGKI8rXJdmD3hLy8MOqXF3JM6WJCAuXcr2Q?=
 =?us-ascii?Q?EfCIF090JHL32bQhZQAXlYcmXNh09DjMRKD63Eu0BuZZ53ClmkwpWmJBlNOT?=
 =?us-ascii?Q?Rhlohtmv1qEAXK1CUBLDqFLNrAjA+zq8pQt/1Q8kU2xJW6DY6ZmMhecWYCa+?=
 =?us-ascii?Q?9KPW5v1euuiXP9sE3zdTg2iSxtNt6JTawpKbVjY/Nss5enyWbtNESUJByjRB?=
 =?us-ascii?Q?1jE5hOeZdq8924gNaBWMoj6RypoPphYxrKmNU5HpBYH9973Z1h0j7t5grV1t?=
 =?us-ascii?Q?2LQDm6ebis2Mh8/qkhYlzRpHDytJ0+qwVyJiA0FnlhEr4f/M2AT+yf6esH4U?=
 =?us-ascii?Q?Hduaflh0fy8V5xaTfvGWQKaYpnmFDbRLGcOjFCYpTUDusKZ0dVOo0MTkQl0L?=
 =?us-ascii?Q?W8IBIOC6TPS7CKFM+zGp6MjWu3YGWgga3+PU4xigspJWEZho2qQRDVdwuO8q?=
 =?us-ascii?Q?2su2B4FjLOPYGiasdh+TpGTbILr37cQlLtXgLECNgNHQLahvwOQMva4bs0KQ?=
 =?us-ascii?Q?VNnTlHBBCgnzMOhjz/aNmZHsg9H+/iEY4HPZ3nVlvtY7R1hJ3qHu78Nr4pIZ?=
 =?us-ascii?Q?uAIyilgKJ5bX8azOAfA0UJFSocLcDYAno9ieYah4OeB5hQfhFnAvNdU2xgZb?=
 =?us-ascii?Q?RYvS5XiYI4S3bbAhlSpLnEgztxy69i1+I+5mIyXgZFE+csMoe6oRmg/1jyxm?=
 =?us-ascii?Q?JH0KFFXKESkL2RwXwG5cAebhPPkOQHvINYssS8YI6gb+GJjDItvNBJjEk6Ar?=
 =?us-ascii?Q?yCXX9i86gBoaCEaA9X1A4oz2gSwok0JTktwhFoMFA4ihNaeDu8LY0dha+UFZ?=
 =?us-ascii?Q?tvOiZdZ3gOdYevmaqIkvYKHjTHfRPDN1XiaYUG+THnpPWl3O9Ivu3iAAJkBL?=
 =?us-ascii?Q?DtnHs54uuVgP8bYn8JXdJNpyTbmag0qAhtE0P2/BgloIjaZy8SKMxIoZgSiu?=
 =?us-ascii?Q?gR06afWpHpCMBQEdaqxObvbEnMlQjRQAnyk4b+7wqcYhQYNddc5b230UXrVf?=
 =?us-ascii?Q?76xdAZn2wWEpM+uQxn+lApJNi9nXlYockHUFhd69EOlwhfYZfVw9MSkmYzg6?=
 =?us-ascii?Q?F3rfFkLzw20vtZGXvPi9AlhTUtIraYPhiQs4b0GYQ0VsLPFg7r/Ief4vCH7d?=
 =?us-ascii?Q?nU1C5NvfBLRLbK3SENx7hyKAmTPfcbtBqliV+LjenrInbX1wvZI7x3tcEnIY?=
 =?us-ascii?Q?r7oNNfll35JgA5/7nwKg0sX4jY/9dU4kWFBKLFg2BbuG4ZEfUNEjDZV6e5iZ?=
 =?us-ascii?Q?AUZ22BIcRD6ujEdC1VH8NuVtINIEbTrr8Y8cj/4UHldejfw7Rsxt7wXpUUkf?=
 =?us-ascii?Q?M37nbfkDWLKyoL9FW7fyq+9RygWYO/EhOG5Ond9/oxB9mqMLhNSm70Q1FBDk?=
 =?us-ascii?Q?PBMUsEFn7AVxtqHCZgp1FcKDKL6n4lczGQYBT1ZBFiJzdYxVMzmkNTk9JRft?=
 =?us-ascii?Q?sWMZmwdsYGUy5upYC0CG21I=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5631172a-c8d0-4636-186c-08ddd2f5cd9f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:31.6575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gO1XPTbVJR1+olanwjU9IoPnD4Piuz5R8W4kcGibe+A/PAlIV5H/iUCYAY1/ZjA2Fe+QF5SQ4hVRh/ngmNLEWcl2ZkJ/F+gwIhEW15WhPHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6346
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

From: Tingting Meng <tingting.meng@altera.com>

Add config header file for new platform Agilex7 M-series.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 include/configs/socfpga_agilex7m_socdk.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 include/configs/socfpga_agilex7m_socdk.h

diff --git a/include/configs/socfpga_agilex7m_socdk.h b/include/configs/socfpga_agilex7m_socdk.h
new file mode 100644
index 00000000000..deff70ee67a
--- /dev/null
+++ b/include/configs/socfpga_agilex7m_socdk.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ *
+ */
+
+#ifndef __CONFIG_SOCFGPA_AGILEX7M_H__
+#define __CONFIG_SOCFGPA_AGILEX7M_H__
+
+#include <configs/socfpga_soc64_common.h>
+
+#endif	/* __CONFIG_SOCFGPA_AGILEX7M_H__ */
-- 
2.35.3

