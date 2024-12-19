Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91212E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 13:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF25A803AB;
	Thu, 19 Dec 2024 14:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="ZMvkvLfz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81A918035E; Thu, 19 Dec 2024 14:06:05 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE5168035E
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 19 Dec 2024 14:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/cjKOvih7gu+shEqk/35oOufMj5eyRf8VN4qf66KZBct4Sc2dsu+D0ws9EIXFMExWeJg8PrcjdLkChd77scXRspIfC5MZSXDkki3iXJgV0fQcJD/LA9icbzg0F4jgJ2tSzXzjT+haZSzmDsGIRSQL6HoT5wXxRk+Ln4USYUAjCbRMyJ21baKu8vqCnt2u7g0oBQr+Cx3RnaRCFGRYDLdK0UmnyFB3Yf8d2Bv45q/l2vUrXm8IZ88yrXpjXC9aVMX9LRo8PIee9NQLfXtW4YB9kFsyLDQ5xGpVX7Mrc0sQdr7vl/MgSFWE8u8t4Qagu/6iwdiilxI6Y54NqYqM1YkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9zxPABgNtn8TEy3f7ndOaLMehngj+o79iSXDAkmbYA=;
 b=t6o1bjvkj6DpNVtYIMw8v6scs7PTZdYOxmze4gtknztQQwTh7C1LWBIyg4lZajcOIaImIZi3o9gph0Y7i+UoBMAcCSoOc51pFNd8BAGBzYhwZq+qGIKE11LwYYG3tBS3VlzRBXttmvShQHRYqfMC+ONk1HXSiKwmcx7kDH5Su19U6+ow/6n5gkmECYZmm4wFyYOJXZzP3R9NE5WY078QbMGTATedLinsRUchalFfdIJXxxfa2+Ym48NvURS5WcWau2PEtTeIKp2H/AY/vkSnhS4J8MrGSzmKQy+/fLkDuB8HqVdjldKKpjd+YiHQF+6Y82Q9ckE0LV5YM9TTPcqYgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9zxPABgNtn8TEy3f7ndOaLMehngj+o79iSXDAkmbYA=;
 b=ZMvkvLfzfJ7g0F6/wKrabs2s+IxGHdfj5gzuzWWN9gwx9V1ETjxPFsB+AD29z6aUtDeIAyOp5uBwoVUJZ5r3B0FVkvh305kictswSHk6LMj9JAe287ItnYgEc2QfxKS5NIeyCszonrJfckkSynPMba2fA04tmZ9E+0pMvNVL+FMfr6mLLNtnsk//P/KtJrslRHFwxeQMLq/xrB2rgWpMMlepIhcAp2K0BaR/9Ti5BMIdP8eLDsoURE/Mr1l83ael6lnUKJTgVIERhD6AYZoNbMQNtyn+565A3EAYZadiotS48Vv29AqhMRaUoH+xJbVD3wcGdfO7wuGi9OSDruogsA==
Received: from PA7P264CA0135.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36e::6)
 by PR0P264MB2502.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Thu, 19 Dec
 2024 13:05:56 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36e:cafe::7c) by PA7P264CA0135.outlook.office365.com
 (2603:10a6:102:36e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Thu,
 19 Dec 2024 13:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 19 Dec 2024 13:05:56 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 6175320223;
 Thu, 19 Dec 2024 14:05:56 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v7 2/9] tools: renesas_spkgimage.h: use
 linux/compiler_attributes.h
Date: Thu, 19 Dec 2024 14:05:47 +0100
Message-Id: <20241219130554.49825-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241219130554.49825-1-philippe.reynes@softathome.com>
References: <20241219130554.49825-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|PR0P264MB2502:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0dd0f50f-758c-408e-cdd6-08dd202de051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/KCFMQgICpaUQrZA3Ba9KJyz+/DEoeO/Ykcyh/s/JET4zsr2zii6Gbjv6bqF?=
 =?us-ascii?Q?496V10VJG3rCb8d8IHRLjLbIUqmyrfPbQP8qXd35yKvh6XWJygF1OuAN0OZk?=
 =?us-ascii?Q?3kHxigZPHYHRZHAXqmtXHneX1uNX4xnOKLlpCa1HrZWFPY6SVi7RFu41FlCD?=
 =?us-ascii?Q?F0OiHK7VmS6m9EKZ9ExRI0xbLxdAt1nX0VfqG8QOoYH8My6H9KBPBbHxQTxC?=
 =?us-ascii?Q?TfGEFh5HAC/9Zu59YfTr+mzPPNn1KBdA3tNSF4D5Fzz/KMcJxOv49pb4uFVL?=
 =?us-ascii?Q?GdbCwx5ujVuHRgVyN0MFXDj0uKOWL9kg2rb3pJsS1WyV4IBNgeuiTwlJasrQ?=
 =?us-ascii?Q?TX/FKj+nAdU/5fYRWeocUqsMkxP2Ngv9CBhTFnocpIjpoTZsaWFPGweYuqZJ?=
 =?us-ascii?Q?EZsL59BFahETsfVBRkYUsyR1iqMVAF4XaTt89n3rTVSAPdD3zlsTU2p80dcH?=
 =?us-ascii?Q?iM1nlK7W6Vox53DuJxnrpPTU0oXaksXaXohTl4/CItgnkTDv53xq3iYxMOm9?=
 =?us-ascii?Q?W3k5FfuEjjEndFsLRtSkB5xsLKOCtYlhcBI+abNssjBlYuLrH2LUqzIIMOkX?=
 =?us-ascii?Q?rpUfS6Yn7a8b2P0gW4aFsQlN7TZkX1ePXEAZzsv74E2/Eq2InnOP/0lCHQ8e?=
 =?us-ascii?Q?FMTaBC4ZqZvJ4ykKyLGYOHscmlr4Qf3hXWN2Lkc9KpSsdv/7brJ4SxjAZKvT?=
 =?us-ascii?Q?65PIbPv79NpyR8RKeToKao57kbUql22S0TGlDfagN6ciNK9OEVpHMGxdDGlk?=
 =?us-ascii?Q?CsIAnCOC70g/FD4+RPkYxwbFJoA9YxtDqYM0BopJMZfkKqS1rz07pTohQs2r?=
 =?us-ascii?Q?xwwQHzbVWtmfaumB2USQ7/7foLMJXd9JwO42PJ5Hup6v+X8SccLB9DeXd79l?=
 =?us-ascii?Q?EfjQCHxbvJrjX51j/1H83ODkQbt+kcyzvKAHkf1+JZC1FCE9j5Lg4JHQ6+4m?=
 =?us-ascii?Q?EsRm0G0eRMvNcb2kAtkoayi8NEF+VzHeVlhkpy1RMK32sVaZvRSAruq9pztG?=
 =?us-ascii?Q?uZCfatf4fMZYIrQgq+IcL2vcxW44q9deHH9H9FLt49J88LkErpIZlXUyA1Kx?=
 =?us-ascii?Q?eeLgoxsuwLHJ5fkbOYX6O9+X9ZE2+EDAJhmbLUt2M63BKTrf2m2URJJzj/m6?=
 =?us-ascii?Q?cRQzDRVa0bKfueXd7t0qjKsxrb88DRELaow5YLnWtP5gAVNPMe8tDGs++MIf?=
 =?us-ascii?Q?qg0DVW890xMjZ8JgZFVd3WhW++V68igguR9CUb3qzncosmb6K2B5JvL5t7tK?=
 =?us-ascii?Q?AomVUkwWYZvKfgDaN0uKMSN/U14EgJfYXBdb/8l08YnRcvRi2uXxTawrndi1?=
 =?us-ascii?Q?wZh3vu8ARe/rhg1XMuQoG7+XElN/ISdsTBEqfxCtR2kvI8STn+1MOzsixJjQ?=
 =?us-ascii?Q?/XK76jjwhjDhVHR/N9HB0TNV6x1PDRTOHvvO5JBe3ficx2+JoivouHvujTKr?=
 =?us-ascii?Q?EjRb9LPZ+ESQ33xGSrZj49OapEswobqOzVzX8735dKH0qEA8bva5zzMvdnOj?=
 =?us-ascii?Q?oberiPNDwhRL3pU=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 13:05:56.5084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd0f50f-758c-408e-cdd6-08dd202de051
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2502
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

The attribute __packed was defined in the file
tools/renesas_spkgimage.h but this attribute is
already defined in linux/compiler_attributes.h.
So we include <linux/compiler_attributes.h.h>
and do not define __packed.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 tools/renesas_spkgimage.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/renesas_spkgimage.h b/tools/renesas_spkgimage.h
index 367e113de9d..83ec567b0d4 100644
--- a/tools/renesas_spkgimage.h
+++ b/tools/renesas_spkgimage.h
@@ -11,11 +11,7 @@
 #ifndef _SPKGIMAGE_H_
 #define _SPKGIMAGE_H_
 
-#ifdef __GNUC__
-#define __packed __attribute((packed))
-#else
-#define __packed
-#endif
+#include <linux/compiler_attributes.h>
 
 #define SPKG_HEADER_MARKER	{'R', 'Z', 'N', '1'}
 #define SPKG_HEADER_SIZE	24
-- 
2.25.1

