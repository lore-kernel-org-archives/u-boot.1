Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E55C5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 19:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADD9282B20;
	Wed,  4 Jun 2025 21:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="dacoEiLE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57FE682B18; Wed,  4 Jun 2025 21:56:26 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78168801BE
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 21:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPQzpvPaEdMuIyMlWg+1Te0mCpI72LtZwZl8m4iQBJv4WH6JLaEKWQw5E7I4F2YSVqm8LqIGuCdwSM/vs/M9DZ57UDy7CP3HUKtsi0qSXo/nrpX5z4d1li94vkoQD48AqYPEpyIb1OVhVCrpcDuWtS5oSCjcXbSvRp8ZeQUAaWK1yO9auedZiR84qkMSTIzyRr5VECbeELM766Z+MOtlN89dB4j3BjCzB4OBQL9z2gOXe4Bce5Ul89F1M5sRy9VkUgP4o7vrGDL/kb1yeUMetRN7DOY2gX7ORv7tvEnZ6Zwbi79q4DCUcuYpBuk+1KyBS5Cr3iTiu1xWuBe95+p9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEkCl5eynP04YrVq4yNRsObAdPc4LTP60B7W4HaBMNw=;
 b=I9XF9szjcm35SDrhv8ysyK7jujAyconClbCKOze/6X4AV+DCMgXlCDemr8406DZD2n2pzbJno8srjvtYTMCXEnjg6bD9il29t8HLs4lzimlorLq8nKx/Owvv3k2UXN1dKDYydUaH68MzJstDUX5kMyB8ErLTh4ccZyRj/eHNjWJ4rHRwFu90gE+ZHuWqN15xsjgBJvCXAF+P3idKJoPfKL2q4qPW5isOXntLOG7cYRvxFoG53C8PRhyGnDyVEOxToL8T0L3AmIHMNF9h0rp1p+vHOIT6OHCjv+6/Vvq7a6F8X+UGFJiNmKvqv4/cYHPTAtnf+JR43vpRDjTaW16fFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEkCl5eynP04YrVq4yNRsObAdPc4LTP60B7W4HaBMNw=;
 b=dacoEiLEPasWmOM1JbngXM7a+SKFZhLCmQNUzc214xf3tAVKk+/d1WX3lqwET9gpNXaaWKNzTwJMcCm7Ks9qfsbKbRjKR+J+zNP/OSA2VA90l+Wnjgm1gjqRgpdi+GyazOCtSRF0n56MIg/AFFsuY7vJApO8IDgV3oB0PQ3AveM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 19:56:23 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 19:56:23 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 uboot-snps-arc@synopsys.com, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 07/12] arc: drop volatile qualifier from gd pointer
Date: Wed,  4 Jun 2025 21:56:07 +0200
Message-ID: <20250604195612.2312979-8-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604195612.2312979-1-ravi@prevas.dk>
References: <20250604195612.2312979-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0031.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::19) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a2b896-cdfe-41cb-34e7-08dda3a1e1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CCP+2LJoeekRfrJypdxwbfDZxcnHTs7kMAALXFIbWWKku+qdy6Mvyg+ccjhM?=
 =?us-ascii?Q?bnMZa4P6OU9GBT6iy1MITxH21/Q2mWr4VwULcuXXgp0GNMZCgiskUL6PT0Yt?=
 =?us-ascii?Q?bDm1Om180omdTwyPqVQjui1lPhNdyQCKoeazKzBxlJnrHjaptnhK7LathTDO?=
 =?us-ascii?Q?O4O+o3GK1WHT+LkB8JDyIb/Uu+euMAMqSNShLTtglt1+Yq8e2M5rj+plEuc5?=
 =?us-ascii?Q?aCKVJ6bZdgOUc1I2N/p2Hh+FYwcQBkF1g8pf2c530/4XS7PGkTgXOgcf9ikW?=
 =?us-ascii?Q?ELn7QCnvEwj4sVAJWSSFOAz6/y0WqPF1clIDlRMOn/sNIECvHAeAOiN43Bre?=
 =?us-ascii?Q?WRFY3scin2I148Oe6e43MKdu0KxFvZfF9Syya92u/yKuma0IrtPuxKgR5OOW?=
 =?us-ascii?Q?1PwHmQlZj9JO9kkdm7n0gprOi7ysUz2yZIaK79KEbZubc7LXt4rsFOZXeGoq?=
 =?us-ascii?Q?LUKwDuLFPN2XhiOXn4lSzWHuo5SaVKTqi/LwZD/50wsenJa6tNiQ3adzHnxn?=
 =?us-ascii?Q?eROttsTBMq7Erq6s/M/IAj4yZjm/Y7tvgBE09l+6HIs7VeaPEw3IxCY/fJ2n?=
 =?us-ascii?Q?j7amNAMYGyDPaDQMRQ/qRltUnZrB5n3REoMkPC7y/ueWvYgKZlxZA2SZHf84?=
 =?us-ascii?Q?5/uTVpV6VZYwgEbGi9qlHe6oa+vDbcpftSH98OMuyeKtGpDOF/nk3cE3UFV/?=
 =?us-ascii?Q?aS6EajuM8vP3jNsdXG3BA6WhlT6FFY+XiHH0+iwI6/HBXlHNZNQ6shbDj4ze?=
 =?us-ascii?Q?Baxctzdb8Wws1QzYduRlgpikw3WmiUVwty6X9gTxyXfDOWxI+yIi4EXsBCW5?=
 =?us-ascii?Q?ynVRuXh33JFNevtG9AgccjxNxGhdwewoxzIUYWqjG4WQSSt8Z/OJwM9TZoO8?=
 =?us-ascii?Q?h6rwoSxIjqK6Z2yk09tcKr0IE9vxJWY6PSgcLdm5r8jDeERmQ3iafhCV+6Zj?=
 =?us-ascii?Q?OdJEfqFKwo03XkOCfUYBr6+IDLM5snDw+FVJfYgfVwT8r+gc95jFb16Y9a3T?=
 =?us-ascii?Q?obgQs/mJwPgYcy50XPaPGL/igun6AT7ixMPg0HT77Ll0GpHBpd0LTCPNxPpn?=
 =?us-ascii?Q?3IjumiwOfHjB2YgibKelHPt7yCPknMBX6ckC7q7vrzmQMrYzlb5e/b5VdWQL?=
 =?us-ascii?Q?lSKyHD8HwDW21WVByveKtDR9rMItWGLD6ZvYIOlTSPEf2jV0Jc+z/C+FlSU6?=
 =?us-ascii?Q?kxhrJkNDFxVWnQ7FuMNUMScjNf8qSyMiAKJLQV+edY3XB+mDXNRfpiUKZtRX?=
 =?us-ascii?Q?sPeK3IZpW+w/A7naJJEX/8ySD17qeKTRajE0pOR/eAqgz0ZnzLc8kaqosr6d?=
 =?us-ascii?Q?zeqkibwfzD6n6KEnyNuLIzEBssZ3fbHP+X5I3F/mFecC4zDGnZlxMmHToMu4?=
 =?us-ascii?Q?6vMD/XTZNoYhuAWWXUVXAMyocV+1aKRg6VLiIPha66Zv1rxj7bQu6JnjGDO1?=
 =?us-ascii?Q?Qw7wfNfpZBk/JGdwcLSWiGEwSczErLO93C9ydU+kqGgGdKA2eUdc+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UDYeMXcj3Y+KbRSBifO0rDbL5bHx2bHw8iCAqhvXDGHouw6fgBns29kuB6/K?=
 =?us-ascii?Q?Ic3zAccDhHniLclp7NLeYUhed06ZFOjEvkZgHtFOjvtNlmmXdXGwk+1DGOur?=
 =?us-ascii?Q?zriOUjlArH0uDy4l5qD9fpuSlUuJxugWFe6PDniLs0uk444hFGCL1qTD0s/h?=
 =?us-ascii?Q?ks3y4q6m9Sqo4obL/Sdos/CRcBsZl1lb4IVxmURpzmvXLUosD6L5ZUgNAWbn?=
 =?us-ascii?Q?f/6YXYGnyZ8TH6cBjB2qtQorNO1l4PMl+3F/xOQtbLaYcITIHxd1GoEElxYu?=
 =?us-ascii?Q?iAB2GN6Gi+XmreXaYGI/6b9vz6+EwL+FNJmoTLkAqfeqgwMEdPkW19KHEWwp?=
 =?us-ascii?Q?m1MWrf/iialooaC1mj/ZsO4U2fUALecbS5pcXCWGBddG+x3ZIvhb3VGABX7v?=
 =?us-ascii?Q?tfpvhOkE+OjiEkLokmRL8hoJZkotSyWbNFdd5puPYpNWZPnEQXpHqGVoWena?=
 =?us-ascii?Q?m+q6NrQ8tpU4M+ttPhW2cSnRFDR/ZzV0B4TXmoE3BMeAVvP2iLpDOJIyzbI6?=
 =?us-ascii?Q?8P24IraubdJw21u81je88x39ZEbZfAK5jKiaJqGy3IONburFVuVWAeia0q54?=
 =?us-ascii?Q?PcYmGOdT/xM3wrNhIEzKGKb3QgsiuIziGlEuTU8/p9SBECkJXx+uc2JqkP5y?=
 =?us-ascii?Q?1r1mcv6HKV0UrO8MLmVDbzpfQTMTCdeCwqnvo4gKNK8E5YFgG8lXOMlZozAe?=
 =?us-ascii?Q?gkNIWKWnwkvWKDCfwyoAOuOH/7NAyf4ZhpI5pV4gFqyF64gO5zhYdpJV9DRB?=
 =?us-ascii?Q?yQcnvTFGjxA4gZ8Cw4yWP93oQsAqmFNsF087kjsMD2NdVUAcHRESoC8++PuT?=
 =?us-ascii?Q?oO7OHeYCGNq4vODgjeXRi589+5i5twAvoLFcSfTm2e3jxj6dxreo0MFxBAV3?=
 =?us-ascii?Q?JTBCGbydZzErrWVn9Lwy9EKjb+0fmCPdoCfPcYfZBA/y6D8XGbO+sK0M8bZU?=
 =?us-ascii?Q?gYllRSCCDtJXQ9piij2QFRsWRsfScNkkR2dcbLWS5LxsXjmFUrHvMhMoJN/R?=
 =?us-ascii?Q?s3U6dd0TM8vPI1d4A8t8sILaVzoOdujMKdArPVupxhXv6WqqkRhCkBP1E+6P?=
 =?us-ascii?Q?vQgsyrGhdnz93rLEOMKza5daiYVjKd2h+n4F6KFuavNRE6JedkroZparvUuz?=
 =?us-ascii?Q?iGtBbiX1IVXlLzaGdaKltJeEoeBmsTPkMdE9OFHOQB8QEwBtauNSFKZvbFjD?=
 =?us-ascii?Q?ay8EUNp+NychWvKySD4pBuZf9dS/lQuj/WDivV8DKYGVNf0n7gIBuspVlCVX?=
 =?us-ascii?Q?qOTxfLQ7IVqRi8PI3vCdFQ1le5CZ4CrEQfPN92rgm3OcTuh/GHBBM5sD/o1S?=
 =?us-ascii?Q?/jlBPeQoOBN23hbZflM1VNJbPdaLPBJs2zOQT8LrowmuoF5EAiFo9bpez1Jq?=
 =?us-ascii?Q?9ZoX4sd+xWO484JDpcxvFRBARbty2dT9MBn/JTiPzKOlUrGKulRBz3JZS2pf?=
 =?us-ascii?Q?PnsDY+oRZSxPtoJ8Px6z+W6/dsXOx00pLS/LH4Gf/yKAe7Dtfdeh0fXE5Ebv?=
 =?us-ascii?Q?mWgRtycvD3F/Ynzx84u7svwja3kai0IMptoI1o2MN9qXb5LQjZde7DwEnk/+?=
 =?us-ascii?Q?Qejb+B4oTp+MkzJjc28vgPbWRqtgnrRbe1R8F9eG5/ernDvy73DirxwBKJCO?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a2b896-cdfe-41cb-34e7-08dda3a1e1dc
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:56:23.1770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4EGuDbCfbM+wh8bv8F68B127BLrYS6QeR1Fx863kdvm2eWWmbQUtCQjxsn4owpOmhtKKSeTIhCGvZBoMAO+30pvJf/UM06+9LmoQNDQ5R4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6940
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

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/arc/include/asm/global_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/include/asm/global_data.h b/arch/arc/include/asm/global_data.h
index fd9b7fb5f8d..4c3a25996fc 100644
--- a/arch/arc/include/asm/global_data.h
+++ b/arch/arc/include/asm/global_data.h
@@ -20,6 +20,6 @@ struct arch_global_data {
 
 #include <asm-generic/global_data.h>
 
-#define DECLARE_GLOBAL_DATA_PTR		register volatile gd_t *gd asm ("r25")
+#define DECLARE_GLOBAL_DATA_PTR		register gd_t *gd asm ("r25")
 
 #endif /* __ASM_ARC_GLOBAL_DATA_H */
-- 
2.49.0

