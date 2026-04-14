Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F323F9D0C9
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 12:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DC2584242;
	Tue, 14 Apr 2026 14:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="UMMCojmr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E5D84181; Tue, 14 Apr 2026 11:04:12 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFC47841CD
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 11:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AN/iZeHsFpkM58F2nmD2Om9JBm53zkFLtRRmdt0jWKX7Cu43QrEkApTPMZE4r95kgZ8ybZ00XAJxR/ldF4DfBKODZVMoxD+8JJ4ITVRiG5Lwy+o9EEsu74arYeAsUzLjDHOqv2s/deHZTWUVXk0/KnKXRtiCGiZEZJLfcDpjkvUjbGnQXpFfH9e3NAwlaGGe30B7vf9piOQEkKGmlNEmqhF01PaEYcWu3UW2sFlVdeg1HyUkLeL3lGGy5y6UxRsBwS/Yzpe7M5DDmN441brS3FRLzZ00JcZM1LOx/XKWgc7gzlasfIUOqKh/rQsuUC69F06QQkG2foNIwLgcUdyAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fyvnoGoRYuu1G26lCApngAkKpNZiqxqNl3aP1L3Hj0=;
 b=R18QBDC1I9AXrLn/ul8xXUhFenXC29cQWDsGyHwhVCVYj2ncyNyWDkMMjJyw25INpxRbW9GGcDxLpvLsr6FMlPlj9a+mbNSWPcfg5gz6ckl5WKpRiaG3FOKN6f+PLXKvhMZB3yWWQSi7adsREkEoH5hYhyE7gXL5/JqRrhlQ7M1GheQWntCoWzF6gqyKew2IlWTYl8WNacbqX7F6w9otSixhV3X+KN2kmcMnMg8JF9PjM3BY/hUsqXqN2oL8kCO+AT7PXLJreVNKdCV8GgWtvZnEAhRfIwA/AbDVAWIPpbNDBuM2zwtg05rBrlKD1hKxuM1cw6o5T/rkGeESR/lMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fyvnoGoRYuu1G26lCApngAkKpNZiqxqNl3aP1L3Hj0=;
 b=UMMCojmrxhApnvbVJYiKtlO1/ingncKXChzaiZqXDYdVPq6iPKcTvslqNWCNyL/XE4Vuj5LQzEB9t8CCr42SLDDNZmn6AG8sNnZhB5BX5IXOCpYYBh3zTZH6WIG45boM68caMhby8ya1VlWQIMCROmplaqHYUY4eh6Wcdt8C3PAOTjCTdWb8jenuyX7PL3A7fVxj+ByOb6P5tjNMqJH6ktgzJMQHVXP9eY9c8ygsozWJL+eXTjPDfM10wcc7eipCRED/dzgdeUtZ3xp1KMuRiEvTVfhgyNw8kTrnmKVEy4ohZ6Llzu3KWG/PeK5Dk/YjjCzOoMQN35zlPdOT4lW5tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by DS3PR03MB989216.namprd03.prod.outlook.com (2603:10b6:8:38e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 09:04:07 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 09:04:06 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Alexander Dahl <ada@thorsis.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 drosdi <danish.ahmad.rosdi@altera.com>
Subject: [PATCH v3] drivers: fpga: Use SOC64 conditional instead of
 Agilex/Stratix10
Date: Tue, 14 Apr 2026 17:03:50 +0800
Message-ID: <20260414090350.34455-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:254::12) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|DS3PR03MB989216:EE_
X-MS-Office365-Filtering-Correlation-Id: 624dcd97-e1e5-46eb-e736-08de9a04c845
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|55112099003; 
X-Microsoft-Antispam-Message-Info: f3FD/UPN+2rz+xpFhLoWCyosayT8Oa9XXRXCmitfa/fFxiHW8++h459Dsp/EobF5BbqVLDFpJotXh1AqtfqIGQ/aa8K4emF06oGs8A8X/KKPTG4zorNA6uehXRxkzku8zaAwFJwaXv8eC4UYLQ/R31TzDBIvhrOuC8W+OWmZ32cetZs3APfh5mOaC421xJPd7ftCOvrbmw23YIrYPwj8BbGNoO9/N++bnzBC1xv/1KyCMpQ9jx6BtDZH2t3et/k1x7h9+ovHAJU2IJ9pEstMnkx5hhu6VWkD2Dky+TTbvx6Q1OWel/5+Gyor1AD/iWFGEAbtM1cOIrZnOe6X9Yg9oj/ykux9t2SLf3Lqq1W5pWeBKEBkxQXwQZH+/CKzHgI5vic8k0/IC43DvNPIqKKWaM8QfpPSWRGi8B5SwCmfctbYoK7Jk32f6swpNu4A4tliAQOW98n+nJwZMgg6jMgg/THIUF4XTQpS6NxBKCJ+O5tl8mP1X304bDoyaH0h0YVPohcwXnravzZbDvp7o6AdX7/dqcnHHupMhQXYq/4nm2oi2DJbLEGFMD1EmXvKwKmTWqItiDE/6QQ+L6JNtyBaKYD1HUyrk7xHJkhlF8B4rW1+A27YCTM2Cz2aswQlauX2eJnfWoJLgLyo7R/jGCnZIMnYLApRsaNuIaZ9FlDOQBfWurmKurpK5g784/i4AvxUuN+SiXJXIBOtYgszo5KtKN7El5Du9mg2TXW9u2i42ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BazMURI3mSDDMT2X3lJQz2KbWjGDD2aMPbuVBSlnvUpBCr/Z2RgBREPQvq6D?=
 =?us-ascii?Q?s+m4Z6qGZz6ETTF01pAEniZ2YjUejERLGbsk+AecYtwkxadj7OTCkmE3/46q?=
 =?us-ascii?Q?nSckNpXVjOAqAyVUKtxjOxKrtvao3lVidxKSzqOLDK+psy3nh+rb8J5tTcIl?=
 =?us-ascii?Q?2YrR5J2P4dTrZeSVallFd7JN3UDaFoumDFseBwZoWkGhJYeimvwPvjdRSSpi?=
 =?us-ascii?Q?V9IHH8GNhMAGbqkfnTzPvmpLApJYP5ZJWbp/+UOMF5Nn0qUYHVxfqt0SkkQw?=
 =?us-ascii?Q?TmYd3ajKhNMYe9dp/+XMw+5c9PKnOcKekBpQGVP8DrKDG2cP7VzJ5g6Cz6LR?=
 =?us-ascii?Q?ixiTWDkHjhndkh6L8RUujWYg1ZOcY0J8mymF/A1YmhE15Dkj7QqSgIggqTHf?=
 =?us-ascii?Q?pGrJDFu5/XIqOqVWjfyCwTEQDG954EigsedYT/Bn/YxDT01toPhpyUKEBt64?=
 =?us-ascii?Q?Ps8a2OdUMWs/JPaWaOQIZ4X4v60X0HJonaBdkukixwA7zGYqPJVaFzbmIEYm?=
 =?us-ascii?Q?fnM+xxNseg28CZLIBlV39E0mMIrBADfktGImHWSUaakIQmv0a5JbsZIRyw5s?=
 =?us-ascii?Q?S3xaKEPD25ysX5bhlz7BTs4r/gD4TP09UPm9gHBHDBrlfI0MBNEN57jMxMzV?=
 =?us-ascii?Q?0jtnTCWULzoa/iP8RiV/pfygjnHphhX+5kuQ2Fov++WwNxIDiS3YGDUqoClD?=
 =?us-ascii?Q?ICytZVT//hR380flWDtGb29g6QlykcQKH59x/MIiwtxvMJ2Ri99osKZSElbn?=
 =?us-ascii?Q?FqCPlypw5eltZHTNatISFtOFkrQhcIOf50hvFuk58jq1rJKFsLQi2EM8e96w?=
 =?us-ascii?Q?7d7tlW8Mvqhj+8pjUMAIZOoeKApJlOAbLU1iY+2amyvnuoz/NJFMNxD6DCpl?=
 =?us-ascii?Q?bxgQxKfzm+ulPTCpebJVz3gL/U3dD0U36oeC+QbiN0dZn9RwWA1yu5MeMrAU?=
 =?us-ascii?Q?8Wq1tsTRoAoT7GrEw6J3MEB4Ly1IALT6KP23wxi9Wzc1BiAIKvWEJ4r64PXJ?=
 =?us-ascii?Q?72t73q2rhBDbR2BYYCXDXn84t9QNn5a1qK0sonyNB1sxH+PX5wh+e3OBFc7d?=
 =?us-ascii?Q?s27Vdio/8YLftROdJuLsvLhme7nIEk6sIfh07qunMUGrxy06OuTjsi+ecfwz?=
 =?us-ascii?Q?hLhzDiL6Vemspg8EHo/rEGbKGk0vb4oYg+mXUcVe7u1xb1+8ltaYBOAYCoKR?=
 =?us-ascii?Q?izW+09HYE9hfJU9cLimvfp/IYhCqLTQQbLUkH9TwYUqi2QJJMDUWdw4HpHcN?=
 =?us-ascii?Q?9nhH+D1ivdJ/Nm+4jq5PEeeLsPoey/l4upAaMtBULFgTx/vvoOMcI13AP3V3?=
 =?us-ascii?Q?RW9/U747kR7f2voYumY+iytzIdmZTBLeYvcdgJwuIaLhEUoB3db6xc48wPUR?=
 =?us-ascii?Q?oU98JKw1VA2bNIVc3kd9VEHEadvv6Ru0hkAR2wDqjDMym0ijjzR+qUPN2WKi?=
 =?us-ascii?Q?SWi+mST+cq8p3Cgj5rhTFhsYswiS85su03oFhzw6NyrQBN2I8VpP1cHXxC62?=
 =?us-ascii?Q?PNY9UEJ+vPMQwODSwsCqVx1KY3YAUvGkTpsYDSujmErwqfZU5dmv6xnYC6bo?=
 =?us-ascii?Q?ma+FrMo7rsg/43HI+60+g/7yaAvLc8PvOovo2aExZ1llAWNG6AD7DLKUbHmt?=
 =?us-ascii?Q?ZFfvVBhvv4iv7FEON8BdlIVsMfDwuxJBIOGG2K/iH5i9qcRLikZg2w+UKnjM?=
 =?us-ascii?Q?zdObs3G3tAbg65lZWngqZTid1xnrTjMQxPrudtM6IEPVdQxMVaAG6/rG2rU8?=
 =?us-ascii?Q?eCPQI658yWvAjoE28hbkmeb9iOH43a4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624dcd97-e1e5-46eb-e736-08de9a04c845
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 09:04:06.5993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6MKvdfF6yTJtNeMMEjmrUmrg2dUnkAniw8vPwjW6piyNlwGvNMD4d8BiCBD/b5OS7XxwEaLaNr6JdRiGMqpx1QqlEZckH4sKiU979fJgDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR03MB989216
X-Mailman-Approved-At: Tue, 14 Apr 2026 14:54:51 +0200
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

From: drosdi <danish.ahmad.rosdi@altera.com>

Replace the conditional compilation checks for
CONFIG_TARGET_SOCFPGA_AGILEX and CONFIG_TARGET_SOCFPGA_STRATIX10
with a CONFIG_ARCH_SOCFPGA_SOC64 check.

The affected code is common to all SOC64-based platforms, not just
Stratix10 and Agilex. Newer devices such as Agilex7M and Agilex5 also
fall under SOC64 and require the same handling.

Signed-off-by: drosdi <danish.ahmad.rosdi@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/fpga/altera.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c
index 822183c5785..7c7a6650b82 100644
--- a/drivers/fpga/altera.c
+++ b/drivers/fpga/altera.c
@@ -12,8 +12,7 @@
 /*
  *  Altera FPGA support
  */
-#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) || \
-	IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)
+#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_SOC64)
 #include <asm/arch/misc.h>
 #endif
 #include <errno.h>
@@ -48,8 +47,7 @@ static const struct altera_fpga {
 #endif
 };

-#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) || \
-	IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)
+#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_SOC64)
 int fpga_is_partial_data(int devnum, size_t img_len)
 {
 	/*
--
2.43.7

