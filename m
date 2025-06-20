Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0B9C7115D
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 10:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E82082D83;
	Fri, 20 Jun 2025 12:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="pmNHQtc+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A5C382D60; Fri, 20 Jun 2025 12:30:07 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F058F82D17
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 12:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+mJ+p8L+iiznzaY28luMUJWP/RNJpYY0LkcSm7pTaBDjqL8N9z58czIjJ4RQNjOZCrxkQXkjVQ8ew1aOPYKve3vUZWrvy6Bl5vN5Czn3u5PzNcxwD/WVEcb2EUu+7yGtHZrYiQL5pRYss/nHZDJ/6bZg2JnF5Z6l4B4DBCyX3kpqd8xjzD+OGZQfW9JBg7tTnxXIOSCUTEvAd7iFgnFXFacKq6HZ+cqFmxf7KOZD/25ZLjXmQTTybuS6Qx1N0X9LNnSqO40isBpytLSMM8UPAknwWVcl1omIF17nIqTQU1k2DtF9CXa6I8wHKeLNvGuDWRoxvQkAHa91LMCydoxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpr+KR3QAGgdP1u+e4Sb1Fo02p7uRfATxYkRvs4AWjM=;
 b=qFUZ1e9abAQM1/9tVpOLJ5XDYy/LQiu7S+W/PMX/XbLwJi1wTFMwHHMz7zldQDOWHUQBWYhVYU5X1HFg0lNgW5EPpQj78siPBn9btBFIftlLMlj0OTHbdaSHnys7HReDZROuup1nvS+MP+cdcEirZPcsR1qLndVqp2fH/zYKr9bORVz0nUr5AbI11GYkRAvSx5EKxs6U32bo2OfvhOyNLN+DOAfnu17GrYwWDSdHqlPqN4rUh6oVmlAUGev248zNKMaM+rNQ9xx7fv9qFAc1uta/aCg0Xbih1Qvd42NUPzqQFc4bCb7cB8oFa0Lp+xojQin+oJz+md0zGEuG9M1QgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpr+KR3QAGgdP1u+e4Sb1Fo02p7uRfATxYkRvs4AWjM=;
 b=pmNHQtc+PVgPmQuttmGmgRpDrMwu40DZKZKEY5du8IYL6CRTMhQHd0hluxxih7jn8Ldo7PDR6UHTFsF+NyTa8XF27a46FXfzdNTTru921cvBIRu3ipERbsa4u/0XFNAoMaUct3y9ovYuSQ9jeYBxofWgtL126QTRCuU36Cb+mIiRBh/oCy2IZxSl4qOSUkpazJqp7cFBDnrsXcUmr5LMob3YcRMo8bL7WGgdMLqw35XjBCZKWpCJqS18aC7ZASSw3oicww+981qyEhYURW0kCVFf4iexoAuojesKjzb13oPJMPbtWcMfCULbGjr88Ca7J2X6l3jxb+z6ND5Aacs1hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BY5PR03MB5250.namprd03.prod.outlook.com (2603:10b6:a03:220::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Fri, 20 Jun
 2025 10:29:58 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8857.016; Fri, 20 Jun 2025
 10:29:58 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 2/2] mtd: nand: denali: Add SPL image loader
Date: Fri, 20 Jun 2025 03:29:53 -0700
Message-Id: <20250620102953.29633-3-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250620102953.29633-1-alif.zakuan.yuslaimi@altera.com>
References: <20250620102953.29633-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:254::10) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|BY5PR03MB5250:EE_
X-MS-Office365-Filtering-Correlation-Id: f21aac89-d34e-46ae-2bd8-08ddafe56803
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MKlLm6bGUZD3orAMkM6fjQwh8qEyI9en8M0SmQmg37O+4sBGPNlDcs2CqOHO?=
 =?us-ascii?Q?1MDu5DiOu2RZezugkar3EUZ9l3gI2zn1puda8pwj17zGo3KDAJCkS2C1gv0l?=
 =?us-ascii?Q?hbH8BEy20TX1qf6ey8mIgE/Bz0FwStNRY+e0WRqBKVs7bF8TulOjuukYRns5?=
 =?us-ascii?Q?dtrti4Khrs7jPL594TgM2yktK3ewRAKO9dBoq4LASnYmWJNrsXRYVLwvzs3u?=
 =?us-ascii?Q?5lMiXyI+/XYBEW8ecfaMQSoEGyjtXW06GzJrOctdhFkRRXqvE9cmpojSBIvi?=
 =?us-ascii?Q?4Fbjo+u7hwxE87yfVUfVj2xg952+Nj+9sHxhh/o7rtrsM6c9jrsDlaPKrXXb?=
 =?us-ascii?Q?eJJtQISeizSLKzejHPIjIhnvV7Z9C7ZqoLoCG0rRzgaDzLUzWgKidGuO+IKf?=
 =?us-ascii?Q?eyydiwjqhQX+A/StxaOPww+b65NWKgRdYUKqW2DdVfWYAn90JcJwkmNK7wH8?=
 =?us-ascii?Q?QvM+SniG71HEnqZPiUExICoh5pnhO/ziqsfizFagtR4vGMdfsilGXoaPK4K9?=
 =?us-ascii?Q?Xlz7ID+gLSr9n/Xf0mTucJin0QmMl9hvH48tjMnq4MAZNz+X16Xtu89/1FdN?=
 =?us-ascii?Q?GP0YEKySNcNU00qq1mBembg4SokL0Pj+ZudN9GdMwnEihCaVdQd9DI+HRc2a?=
 =?us-ascii?Q?8rBy7q6MeK4L+SEXXTQxtdcwLnwhFfm2E8uXsHxCqQwxpFl8/ER7A6GTee6Q?=
 =?us-ascii?Q?uBDthCxuE1kmXqecZv5NUywXNHGdaW3rsN/QTJ81zUvCUDI1Y8Ke/Z3E2IGm?=
 =?us-ascii?Q?nkY5gJaNnc/xZd+zC627YwCdr8TVIoVDwsPk2GB/FTJ4y+V/dDAhrIjhHMD2?=
 =?us-ascii?Q?lJIgHPbC5pd4v5K9HaaYqsD6mNjVYTRrdFpXGQt2obzuh9l3Sz4pX/iluUqo?=
 =?us-ascii?Q?keofvOHj/JNNzILGkI7btCHMnk6pHUAjWso1pPn0k2WcxKdPjHIEpeoUp8KI?=
 =?us-ascii?Q?oX3876zcm06Gs1CueVlSGR5VZ8Ysx4RbX3ifDwgh5Irvv7kqzx3tNjAQLZv/?=
 =?us-ascii?Q?/Ts4FzkEbuMALwFLfFKOMlFmfF/5NKTx2ckFE8chCOxBZgTlHkdO1CKQxmOs?=
 =?us-ascii?Q?gtCg5Eq01QBifKGbZ9yDLMbTmPcD9cM9iqe9QN4PdiE8MAhNNE8a2PUnZx+0?=
 =?us-ascii?Q?25SEIStnFfDjb0AxYA5AwZDoyp6FWI5ia75O+NJVOimP5y4MbTK4EcQabkEN?=
 =?us-ascii?Q?i0eFUWSeRtTZpmLAyeY6SkaGZ7YecBSn1KMBAQBDvIkJ5jPmHmCYDjQ2adNG?=
 =?us-ascii?Q?5876R3B9A1qgq4uSHdN3GEq3YiGkTUlHT+hLxPK6zsLUGXdkYmU3ueEsAxfj?=
 =?us-ascii?Q?q1EsYe6RaHv9TfQhIZOeeTvqcdyG3XiCbQ6uJG0CIhG2l/zRrIurcJQs2Vn1?=
 =?us-ascii?Q?FFJHq2w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9gtpa5Pyvh01XWvEekjdz5eat0aRwTEJ7tXLQeLe/7Th0li49isuMKPWRF1f?=
 =?us-ascii?Q?hbvOG9k7rShD7QOzU38MnumFi7I7vHUOe9kh+fCjNt8bwQk0PIz8pKpO+1ba?=
 =?us-ascii?Q?L6TrmDGoBkMOiApNeDEQWiDgQTRR68ROnOPY4R9V/JR3f6z18cH1eoacyj8N?=
 =?us-ascii?Q?h17RhEw36K+znCGiVLwv1gxuCy+Iboaoe6vinaghzaZf7km3dt5Wk1bqetBc?=
 =?us-ascii?Q?MdQZ/cNV0G/j0sgdIhckS0iZsfE1wf9S37z0zcMaubsc5YrOE7W4Y6ik/II2?=
 =?us-ascii?Q?1VMReczz1nqYqnhTIMsHRDBTirb35g/TuJ+t6u+qw4F0n992w7QKdGSyGFKT?=
 =?us-ascii?Q?2AVDpLa8pcwP18xaOr6LCsFbgICipl8tSXwTk7QBq4yE+ik97OldcdfaXfbG?=
 =?us-ascii?Q?BMskcDhaGb0CI5eOjuBr4DCoXCLR4V0hnM4sFFTN239dWDLz6VGxeztc/IEi?=
 =?us-ascii?Q?akQ5yvZuMleMvzVLi05xQ6B5i+8qoF6im/tzaw5DYYMYnYjnXB3SIpc+mMeF?=
 =?us-ascii?Q?DWdB3tFONxuQ3kOEpGAGFnTRuK/KKE2OkjjCrEHvuaqLGTZAKFsL5ezxgy3M?=
 =?us-ascii?Q?egP4iIZ9vjU8t6z/u7HJfdf2Q7PctcV9UFQ+aV39OlVYZDym04C4Bg0wbTzV?=
 =?us-ascii?Q?tva7/mDkqBcGus2uUNy73POIIskQz74L+FS4TGO+6frJeu0bPs7xGdfT+6M6?=
 =?us-ascii?Q?dSZPi5V3cziMmatP1sxrycjN1rySspJdlI0ubHX2VS80yeFD6QTli9/B2I7o?=
 =?us-ascii?Q?btgkIKReSjeWZ1YIPwtSZTXN9jox13UvVdG87P/Wq/I3QhA2N3k2Rk+wlVXl?=
 =?us-ascii?Q?MhlH1sXrLJozPyTuu027EJptiPioUqcmIIX396m7dqMvUlVv2PMOGxOgjoUd?=
 =?us-ascii?Q?QA5ytH/TQgj0aL8fgsK5acLFU6C74xFKo0mwgrcB1A/r1xnm/3wZp3qGbS0F?=
 =?us-ascii?Q?PgPpNKl0o6lxQRFknGCzMoj8Whbl5P5ZzJzZUkv2gF9Y224zzre0XUOI+vUk?=
 =?us-ascii?Q?KTNrD+Dcy0zKx1rZZ1Wi9sGJTUDsM8PyTCeWnrUHVF0IVzW+NmKBKHXYVmZD?=
 =?us-ascii?Q?l/kqZXVo0ioPPF5sMVz6VKkhQtfhlKUV9IJ0ntitDoh1dDtxpmS3ShMiB/y/?=
 =?us-ascii?Q?DVbmwjDnxfyl51XsGr00oqFGva4jkwtwgBDajnCN/P7yChi02L2IYwkmLDVD?=
 =?us-ascii?Q?cyN7VDTWNjXxeFbsy6CV5xXfNfOZ77mTv8oDMXP60or28oOxpDFNvYd/uZlJ?=
 =?us-ascii?Q?gbn1xUeLr13FVLIXGcphM5bS5gq4i1cp2KH/7kJorCekD9NvSUYh9bWL9aPZ?=
 =?us-ascii?Q?7DHcc41Wc/aWsu3sg5tv1YdlmiK9EACAZSfDDpQj3CHV3B1/ee723h1ALVzD?=
 =?us-ascii?Q?WisthRW/d5b7qBloQGfio6SOoDZKb+Ii4nwreLB7sy98kCuS3RpqYmtf00Xh?=
 =?us-ascii?Q?44k1PM3ewsDLIL0Gc7S7UO4QsuRct4Cb+PkT1yTjGnPgM/hGzkAB1/b0gR21?=
 =?us-ascii?Q?iy0yuMmJ7zLBvzz2WaBctty3bjb572ewRBhcPSoad9b1KostjDc+Ls4155Pa?=
 =?us-ascii?Q?ci6PaV1ZjK8kiWwgOBHl3xW8/kZSm9bQFPkYqplarTeW4ZBej+o8QoDZY3XU?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21aac89-d34e-46ae-2bd8-08ddafe56803
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 10:29:58.5603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tA4bq5kEQFzwZVrQF6b++MGxoIhALGJ+dXsAne5EQyDYgQmZFl2vnI3UHCLmyql7A6Rh72NHfmOVQCMC21wkk1qzvcWl4BdKwcAA5MCZ33c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5250
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

Add image loader used by the NAND SPL into the full Denali NAND
driver. This allows usage of the full Denali NAND driver in SPL instead
of the reduced SPL-only version.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/mtd/nand/raw/denali.c | 66 ++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index b2401116689..1f302a6f1e7 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2014       Panasonic Corporation
- * Copyright (C) 2013-2014, Altera Corporation <www.altera.com>
+ * Copyright (C) 2013-2025, Altera Corporation <www.altera.com>
  * Copyright (C) 2009-2010, Intel Corporation and its suppliers.
  */
 
 #include <dm.h>
+#include <hang.h>
 #include <malloc.h>
+#include <memalign.h>
 #include <nand.h>
 #include <asm/cache.h>
 #include <asm/dma-mapping.h>
@@ -1373,3 +1375,65 @@ free_buf:
 
 	return ret;
 }
+
+#if IS_ENABLED(CONFIG_XPL_BUILD)
+struct mtd_info *nand_get_mtd(void)
+{
+	struct mtd_info *mtd;
+
+	mtd = get_nand_dev_by_index(nand_curr_device);
+	if (!mtd)
+		hang();
+
+	return mtd;
+}
+
+int nand_spl_load_image(u32 offset, u32 len, void *dst)
+{
+	size_t count = len, actual = 0, page_align_overhead = 0;
+	u32 page_align_offset = 0;
+	u8 *page_buffer;
+	int err = 0;
+	struct mtd_info *mtd;
+
+	if (!len || !dst)
+		return -EINVAL;
+
+	mtd = nand_get_mtd();
+
+	if ((offset & (mtd->writesize - 1)) != 0) {
+		page_buffer = malloc_cache_aligned(mtd->writesize);
+		if (!page_buffer) {
+			debug("Error: allocating buffer\n");
+			return -ENOMEM;
+		}
+
+		page_align_overhead = offset % mtd->writesize;
+		page_align_offset = (offset / mtd->writesize) * mtd->writesize;
+		count = mtd->writesize;
+
+		err = nand_read_skip_bad(mtd, page_align_offset, &count,
+					 &actual, mtd->size, page_buffer);
+
+		if (err)
+			return err;
+
+		count -= page_align_overhead;
+		count = min((size_t)len, count);
+		memcpy(dst, page_buffer + page_align_overhead, count);
+		free(page_buffer);
+
+		len -= count;
+		if (!len)
+			return err;
+
+		offset += count;
+		dst += count;
+		count = len;
+	}
+
+	return nand_read_skip_bad(mtd, offset, &count, &actual, mtd->size, dst);
+}
+
+void nand_deselect(void) {}
+#endif
-- 
2.25.1

