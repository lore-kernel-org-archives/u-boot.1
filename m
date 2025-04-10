Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22ACBC369A6
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE2FC83C8C;
	Thu, 10 Apr 2025 14:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="dgqDzhUx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C41E83B63; Thu, 10 Apr 2025 11:29:04 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD2A983B32
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 10 Apr 2025 11:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLcp3nYz3TjcNFIU+efkKAeHKYBmMNCxJXQXt5xDT+Hytkjiai7pIUzulQielgtStx5DpI2u//5OlhwMVUoouAxDcKcY/xVSf2zzQjBJ7sdDaAzHxTsUl2Gha/f2WDRNa8w3LO+HKajMNhpmpznBWD6iv6tlw7BMmKI4S0S8NJg7nWabEfWxE/K8gcCNHtgQ4G5pMH2W6DorlZYuvAg5s0i/q+vYQTBLsoBDzYSbgZhT5qnvmMaZYWvBv1qq/tT8C1xMPs3ZP2YVB87QANwviviNsH/RLBF+TXojGQ8+NdY9/1TG+SE7og371g+QVm6J/PWonO9qnJwxDptSMr760Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xe8hmd1D/FsPtwxKx2rdZg8VyWHtAAPFLA7SmkjAaZg=;
 b=M4sX8dkAZZ3orxFbiJ/022rh2hFhNk2xAC91BQZXjANAjt59ZJrMdrD5HXIbrKXpbdDYxJR52JCFUmNord6CyqQ4Eu7Rhj6iHyyh05TvrfrHB3pC9GGtJeXXmdpFtMO2gO0JQpTl6le3BFAz9oI7WckGgxc8WtfF4uInkOWjoUCW9RfdoIwDGNYcwbj2URGv2dZn8ZjoyUIA6rb9vKy0yKzn3mLZ3WAvxGYHX8gJ7XTuRbwmnjLOMy9p8BmvSimgQnFba5ofKeu9RjBHAnkj6WECnuif1hZrO8cQylaoMO1NVmbqB0BqeW3vPPsT+oOSziXxBVhItVn4bWE/6ctqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=konsulko.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe8hmd1D/FsPtwxKx2rdZg8VyWHtAAPFLA7SmkjAaZg=;
 b=dgqDzhUx+na3SKKIr7//iXtrR5Rv067Bo4YDgtJqysyigyY/7IkAj6kOdvIXpuvpAHGq8TheCkoYUYYOn/Z4EAW8aE0809BzpjT38/iA4jKseVPS8NU4oKkzXPHLJzucHCqKcfI0gIY+8/Z/P8nUippLbAwSRY9ZJMAq5GtKyonT4Wr2o3JMIANbi5b16C+25ogSh68hDQAZfZzLoo3i4SatJ3HHGsMhyYVcD6kgbI/sDLNIKKDVhh+hm6yy6DFRBawpf5eAMVAQv+Iq2FBfmbJK3d4jnhukXqsa9zq2znT5hXicnShhpEDuzJ8xWQGL18PhmhhVWyN7M8bjldbJhg==
Received: from PR0P264CA0071.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::35)
 by PR1P264MB1872.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 09:28:59 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d:cafe::cb) by PR0P264CA0071.outlook.office365.com
 (2603:10a6:100:1d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.24 via Frontend Transport; Thu,
 10 Apr 2025 09:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.13
 via Frontend Transport; Thu, 10 Apr 2025 09:28:59 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id BCBA52007F;
 Thu, 10 Apr 2025 11:28:59 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com
Cc: u-boot+nodisclaimer@lists.denx.de,
	yan wang <yan.wang@softathome.com>
Subject: [PATCH] spin_table: add missing header for ENODEV and ENOSPC symbols
Date: Thu, 10 Apr 2025 11:28:50 +0200
Message-Id: <20250410092850.316905-1-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|PR1P264MB1872:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ea10ac38-ee8d-4c91-1a59-08dd78122016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yNxlrjZsxn9GAO1ZA459MJvOhrDdbWTOO2TEEJCXon6o9Kw2FZfAdI6BERYj?=
 =?us-ascii?Q?MEZ3qrytpoegNm1AbP4RM2yGnvtOCPcGjQjoEjIIRJYHQMUO9eDmsJKqySKw?=
 =?us-ascii?Q?C+MEG6aKwD0QFPgXJsS0J1OpI7vtZRPQ200kJ47r0mlBToBOXcKnQS3H4Yq5?=
 =?us-ascii?Q?ifHWgRZKflPxMPwsf4wyxjCjwl/PW1FHqs9goQYsaIXKYjhZ20PYnj+nQPCA?=
 =?us-ascii?Q?8KWpZ67KntMaan+qpw9cvaLrfFTbcLJT+GGnqbmOvB264EacL/rQQRRqnco+?=
 =?us-ascii?Q?H6AZdT3qJ4SCB1uVSrzwuQduSvmMVuBOS7ze7NfjqZfqT43/ihJXyrTZ+n8C?=
 =?us-ascii?Q?Dfg7OvCv2+p20NfBrjb++XoffR1gUbu20atbe9vK28Bv+arY3PXuadHSBUhr?=
 =?us-ascii?Q?CnPXuqe1npzqD6rurugT/VWQvvJkS4U/Gab4qkKkDOkwofjelsVk281n6zoM?=
 =?us-ascii?Q?333TF+y7EigLwSBvNzBJlq0hkTDqxZkdy52fZy1OEYEft4thCc5KpwS1qKhD?=
 =?us-ascii?Q?MO2fOUw+AA6Tjuuu9adSrtBz5U+Oz3geC6tj47TmYHK2bmLAypTlekzsdMYW?=
 =?us-ascii?Q?RWZCquKBtwl89E8HSFCACx1PumwuQ/maWsyj9y3I6M3JMhWawTQplIwxuR6b?=
 =?us-ascii?Q?7l6hn5eGXvYAa58q5bna+BVX6wTxePIlqmjERoJp3zSGmRLZi4bGFumxqmUv?=
 =?us-ascii?Q?QDMTLCytGRCiPmDozveCddT7KHFVUYyso5nOw2sSYf6LEgqhXAtzcyMOZiR8?=
 =?us-ascii?Q?ZY0LRg+nCMVcpMxNM7KBRZ3SOpElzIWNe+yvlCXCva9gqwsyMj5LekdzInxo?=
 =?us-ascii?Q?1aQbvB9ayyVc8DH6uy0Y7SMiEQjOam/TCgJwrPYJ0IExQKJMH861Asko3dMj?=
 =?us-ascii?Q?2c93ylVBqiyWqZG0vwJXxQG5/VCc4cQ3wuJOSZai3A5g5Wg9263tVj5ndSMp?=
 =?us-ascii?Q?c66BWbYUrK2Tzg0XsamVKZBc5+Xi1JzZwXhJZgQaP/XGsLKuA57sLyBaiX8+?=
 =?us-ascii?Q?GQ7pSSwA5LM+GgdkRvth3g8DWaJXsTc2XNxvrcE1mtYkj0LSRyO6k7bwhksJ?=
 =?us-ascii?Q?Dv3BZTBXlN4msxKPOnlTrt5jyMdQlUsopIWsLnfabLtc+QzhyzdVVNlX9q72?=
 =?us-ascii?Q?9xgwnHnRxF0KT/GfkaqbRalZPA0JZhl7MPSRt1yRE6SvStjam/mNgTZ6+ww0?=
 =?us-ascii?Q?UKQHjTJ36kN5XdBGYF88wbPGXZTzWAbxW76IAXCj/0oO1XEFk+Vgjk3IgAGz?=
 =?us-ascii?Q?lEdR2qqGA2sfyctBXG+WY8xp8MMi7gu/3jb6TiVFhW8rnBVGW2sj7Jn01wd2?=
 =?us-ascii?Q?mVTgaD0omDtlaPbido6EBSS3f+/l+BBLHctiCJISpXcrEfjfNMtWM0gJPGLL?=
 =?us-ascii?Q?oB7g/0EoREMbqo9tgqjjwyiYoGbiZYhakVyUQmlTfnfzDu4AoIeYUl242BHw?=
 =?us-ascii?Q?u7r+T82tlDRVL4uc6kOS5oygWNQxyyULJWtK2CPdvD1oMRuqu/jz48qXzIxQ?=
 =?us-ascii?Q?ez/l8pVFDWO7FS7AJAlOLORzOdxS1WYaZGHJ?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 09:28:59.9386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea10ac38-ee8d-4c91-1a59-08dd78122016
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1872
X-Mailman-Approved-At: Thu, 10 Apr 2025 14:58:33 +0200
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

Add the necessary header as <common.h> is removed

Signed-off-by: yan wang <yan.wang@softathome.com>
---
 arch/arm/cpu/armv8/spin_table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/cpu/armv8/spin_table.c b/arch/arm/cpu/armv8/spin_table.c
index 485294b88d0..5ba20efa33b 100644
--- a/arch/arm/cpu/armv8/spin_table.c
+++ b/arch/arm/cpu/armv8/spin_table.c
@@ -4,6 +4,7 @@
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
+#include <errno.h>
 #include <linux/libfdt.h>
 #include <asm/spin_table.h>
 
-- 
2.25.1

