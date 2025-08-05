Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235BCC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 02:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 809F583AEE;
	Tue,  5 Aug 2025 04:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dNA2T90O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40ED583FF5; Tue,  5 Aug 2025 04:47:05 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 675B783A81
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 04:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlsuqKDJPxYZ9ofmp2/E5+T+7FZXWcfnGhmPFmLYzDQcWiCRbQmH5Hl5zWsdrmEkFLqiRMZTO0E0LLfcvyRHlBFqWKhtEl07b5u3C96EwJDUe5XSnA/bpW9b3vwQkyTxEaL352GBUZdoJn/WTsVua1J7OyNJw/qKvUJ696iZQG3s039/pWXpj6uJB8A0nHQVDUHaER4GOtt+iMQIQqH2Kaubjq7TDhQL+ewt7M9qa6UChgXd2JKkSeO1ygZaPa0tHRR5A/rhUVJ93yaWu31QxAAHO6vgMpxCGsa6PeiIwpRPUOs/c9EiR31Ru9f88pTg0kDhA9oMqimYgaIniMm6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YsBZ92S324VWUZbTwtbtbBYsIkKDTltK1HmtT40Vw8=;
 b=cr9t5G5aJXiUeIaOza5/cOkTEfQafPUODaSwHXv/HeaE45/hyTk3ngczrp8daA7+NyF/jm+dJxMUQJz5q1LnMRAvEAfW/5B7jmXHd760d+bdgQKhRRA5zU6kl0TsTBF9bqmgEcXUkSeObQJ/m6+TX6dVIusXvZM6uKV72P4gnmuqHXP5/jyCMLt0NdOk3vNUedctd7osQui39CBLs+VQ2bxEkoOVWWbR19dP1FphN3v50c5Acv3PDU9LaFhSP4XkL3tWLp9Xoh1Y+e4QV6oIQwnflqmZUIghMtxZcMgHCL2ND1H9xwi6Jte/0z8cpCp6lgXNjXH6kzuMcpuC84nrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YsBZ92S324VWUZbTwtbtbBYsIkKDTltK1HmtT40Vw8=;
 b=dNA2T90O0cffygBuCMWqG9WMWxHKh7KvfmIuVIfJ12dYY5GE5OBhmARCilqc8VOaDMBvHTj2x7YuzHNhOqjNKPftMPHWgB970XKiWKrBCqZWmYdX/+YbrmMN1SmCMvuXBSBGeJ5EnCWm5OQxP+zZjFXUvYBsLdaFc9Lb1fc7rhDEYbAyxuSwnDFXFdzr8Xj5KXtuv04SU8fOwZNRRz363Du56xRWP8+dp9SWHTcA4dm+VNuOGTb7/iuB+F1xuNN6afPbo0SLyzK8bz1J/HWsPbMQyDZWS3IbEheKrrzn3S+AVX/tJm669L+sdHAOoH2JP3m9aFndFaZ6+VH16Nw+Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by LV4PR03MB8187.namprd03.prod.outlook.com (2603:10b6:408:2e3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 02:46:44 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 02:46:43 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1] misc: fs_loader: Initialize actread variable
Date: Mon,  4 Aug 2025 19:46:30 -0700
Message-Id: <20250805024630.24558-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:334::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|LV4PR03MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 599aa65e-b9a0-4910-130d-08ddd3ca4fdf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fMCF9bYkGpaoj/wfuVlo+UgmW8vLMXqYNh6avundy4PflQ1CEnYs2H33qO3I?=
 =?us-ascii?Q?yI9nC0ujpbTD3WnoC5HWYvOHG0o9lOyre6pswb/HEh9a2XDx5jnqk4lSl9GT?=
 =?us-ascii?Q?y0oIToQh3rYa7wKwJabHtMgFx14MRz+KurtC0bZvFQR/XY2A4jryMx5zi4VU?=
 =?us-ascii?Q?CZoMEIs2MRrlgrY6BxXnv0hhGCWKHShteWIaMfBV/ycgzV7bXAEo7LrXb2w/?=
 =?us-ascii?Q?qQY4AYWT+2RDU0L7W9xkNGMwtlzrrYOkXJJ/mC6HkQiIq+q2FH59fKNvE/+f?=
 =?us-ascii?Q?d4lJW+kq0n0rC8NioKlF4IziYF18mcw6xhUGD+fUJ3KNQdB1U4bzNJF8s9qB?=
 =?us-ascii?Q?1C7CupyyB8TaebX3Bh5oh2NuvW/hJwEysWpdVtnTMJhx5NyYoPSOHCN93VB0?=
 =?us-ascii?Q?wZolXK284bpLzA93uB5lqmANOnds2EFT05aqxppVPgH8u+5OJ9BmukjkW9OK?=
 =?us-ascii?Q?nht40RL8VV7GP3gn37XIcKoQW2G7rdVQRgVTA4Ue65/7nRHggc+MXdzCRpbu?=
 =?us-ascii?Q?3dvB/MNYedSoTIQlckiikp1BfCPptyHxF+x/QOGmlbtbS9kkdIwIjKaazkO9?=
 =?us-ascii?Q?qF6jt8L/k0vYeyAKyH07jo9nllhg1YTXxmyppn9hUFQD/upN4OwT/6qWMeFv?=
 =?us-ascii?Q?FXoN/dElIBRUlZpxvqbCl1hl4HH9WEBGq445BS8Mb9slwHunGViCmCXC5/vY?=
 =?us-ascii?Q?REdMs1EurOFqWNPU/vaPKilg2ftVP6zmn6tbIOSuw5GHLgQTiWifDQQzbSMI?=
 =?us-ascii?Q?aW+8ccSQsFB0hXFkmyqWEKU+ZKYXUl0hwD7qcKvhzm95KZykxwsBHTZBIeGf?=
 =?us-ascii?Q?uE4b6yUAqWUJTiBeie1LwQYwx8Hknx6iPi7xcwl1TulR4mMCw+ZkPE4BDd/T?=
 =?us-ascii?Q?NJw00sjyzefwKpf17urq3OWQSe9ujwP39spC8DlfJiRg5xEX/XSFpfEUOrIP?=
 =?us-ascii?Q?m9Juf4GzBrsxKlKHWvrBn9bSrtXgMEe82aOLUeFB9p1E6FaU+67zo4CiacQ0?=
 =?us-ascii?Q?oQS1iqSm54qFKmjxYg8h7WNRsr0mn8OG81N4uYMYPUcoDB3D83Fzx6W0Znp4?=
 =?us-ascii?Q?eT7y+Rkm9k/yH6Men8OFrLTHD1r7h2GGPHvJyIiyFmoTi2EpS+Kc4b2KpPSv?=
 =?us-ascii?Q?aicfEta6s1n+rHJtar0FvDVF5v94WjfTsFUYX+YyqVjyjiEPMj1H6g/hGKRw?=
 =?us-ascii?Q?BwoYd47zfNrewOPH5xhlo+I4mBh9wUYqudFnxioWTYUIgCDAgLCDsaIbb0cG?=
 =?us-ascii?Q?hPAwc/4KvGk79CQKomqXgAvIM2S9ts2u5ibQJ5hd5GnZtiVTq1cP9+oUja7H?=
 =?us-ascii?Q?3VVvPs7F+/sgPvSz9/MjBymh1g38f2zBKQ7gcUu7z/k1kHOf/mn3HpU09kOL?=
 =?us-ascii?Q?7d6e9HY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sofBl1rO+j67Kd37RhFrVNjatlMrnI4V19hQdv/2ZMUhRIcC8R+jG2pZLXp0?=
 =?us-ascii?Q?RSQvm/79g/xcJ3kzzDjlKQWwZIVir1GSU9w2pP58RB15dkeso/8lXOf8s1iE?=
 =?us-ascii?Q?Mh9eLUn9Nsh8TFaIDxTgluiV86vfrWyA39bmQKMnU+XCnSXDOUFzWbAVQu5a?=
 =?us-ascii?Q?TAWa+mBvLXIhgZjcb7bGnyFpUfPmBAxoC31Q6TqNDOZ62vHreQmxizMv0GWV?=
 =?us-ascii?Q?IavVt4dkt92hiwy1tGKBjLQsNyr3QWcZfIRLBYAnHB2HlOvk7PwJ1DAmxg3+?=
 =?us-ascii?Q?iOeyzzvkSBgWGBHx5v5N8rFXnydQbjUFc4HHfZPCN1p9HdvdmP5rl7gpHqUg?=
 =?us-ascii?Q?JC0TqenUE4CRvp3qKycIqX79Ddv+BblBDyg9u9RZtR5c4wXrkEbTaBQWF+Xf?=
 =?us-ascii?Q?uTi5ah05L8+5TMH1JiBmFV475ujvG16sTZORBsqpHru99hpZVTHAu9A2W/ng?=
 =?us-ascii?Q?14YAq8qXTizxYiJ2Rll0bNeLnrPnZq0NWg54E+D4qo1dmmAu11a0X+tBeJZJ?=
 =?us-ascii?Q?FVIeOkvysKtMf16Z9BmVWp8k7d4uABFZseLfFdvET/10iYO/WqCuVUZ7LJqa?=
 =?us-ascii?Q?GIfcqTDr8Nolwg9zguFFByWC2dj1m6tois4M9x9qWNSHKX2Kl0ib2WCT3ZNO?=
 =?us-ascii?Q?QdH7n1SgI/O3RLNH5dzrYxr8PTT1O5ccqLnFSjZ6YOKJqZ4AwbiLNCIuNwPf?=
 =?us-ascii?Q?Whci89L/n3/nDEPKRmYmFoalvBrdBQewTPMPtPHril16P2OoizjdnabaNxKu?=
 =?us-ascii?Q?ZMfngIMtti5j7gRWQhuvt7TMHr3vH/mjq+MmjRfl5uM+WVvZM7RQQb/alo0S?=
 =?us-ascii?Q?m7XkJzmbdns4Rht30OyT5aWPHtaWI0bBtSaOYle6Iznhb0C9fBoCEktHSsSN?=
 =?us-ascii?Q?D1jLKH2MT9Mdkv9M4s+q0dwI3CYhdeZAAannQNz4YlpZbKuwwBb5CDE1sYpz?=
 =?us-ascii?Q?b2KeyPjTvylh5oZCfAsuHfY0ZKy6stA+VAVr3dFq+oFx607W2WGHnE+2Zfln?=
 =?us-ascii?Q?CPjQ9dRPN5fVJ6Z2v68K3in205V7+V49EtJpud3lQjonbCtbqx+vTvW8jKG5?=
 =?us-ascii?Q?1WXW4pxrjdAGy9kLCabCCuzGC1YikxK6KFNkAMqIchsznaqeF+VL8AzRSZTf?=
 =?us-ascii?Q?LwHRWESpt17qq08TPoewxs+3AyzUciT7CuUNnFexVU7WC/Xy7CBPKVtIGw+5?=
 =?us-ascii?Q?Fyzm73LtN1JCKL145Rz651o4a/cjr5T8PLzmJKWkmv3bv7pogsziC0E2x8Pq?=
 =?us-ascii?Q?Ruu69o0EF2r0Q8sUgZ7mxp9j3Y8R6UHEk77/e93j914L4mZL3rM6NJ0j7a/d?=
 =?us-ascii?Q?vk1S9BZxJwxLUDkvUsUr7LASNkksCOGJ6MrARsL+qn1ojHcxydEAuOzg0A/4?=
 =?us-ascii?Q?+c1QFupjhBWbQZYgyaAGEJ66sDgqVmXqm2QuidlE1bW9fE9dSraCq/EWw1Dw?=
 =?us-ascii?Q?3Fzs+8PjYhmy2aW8NfZZrqP2DEFHvxHkxfk/HMCgk9nYCdTLSdm1Z/Z/QQwH?=
 =?us-ascii?Q?c2IUvwKkDDczMkLCB5Sk55ODFO3S6PdxKrafRuCLAGCpZ1QKmqVzpJhommTv?=
 =?us-ascii?Q?XiIiXT6T4QWn1Z3OEeZemPkx8/5ebR1odwZkwwrViqGjGaC7x5aCuAEfv082?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599aa65e-b9a0-4910-130d-08ddd3ca4fdf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 02:46:43.5345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qibb/ptVaFvI+KyWR0VlX8rhyYi1r1a+e/QYgHIZk2wc6pwlMUYeyH3DtxRMmLi76bXLjQdsNL8SAiEs1Mq7YD88o1wod1pVKvPIF+MGNjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8187
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Initialize the actread variable to prevent undefined behavior
that can occur if the variable is used before being assigned a
value.

This will help to prevent potential issues, especially if
actread is used (e.g., read, incremented, or returned) before
being explicitly set elsewhere in the code.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/misc/fs_loader.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 66803f4b997..cc07bfa7f14 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
  /*
  * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
 
@@ -148,7 +149,7 @@ static int _request_firmware_prepare(struct udevice *dev,
  */
 static int fw_get_filesystem_firmware(struct udevice *dev)
 {
-	loff_t actread;
+	loff_t actread = 0;
 	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
 	int ret;
 
-- 
2.35.3

