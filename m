Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849ECEDEC03
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 04:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AEF383FB0;
	Wed,  4 Mar 2026 05:22:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hvfvsq/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2132383F7F; Wed,  4 Mar 2026 04:30:51 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54BC983F0A
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 04:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fT5em6CbUYRW/IqT1Oke+wqcEuvdYEsv76FTucMaOX+KTkf+aoLrNg78Mi+Te8NEK5mR5I6iwWK1u8BHfYxB6F8jUehiSSN7hV6XmXXYAdIIU4kl/8YTlH7746cUkvbikOUxdVvRB6DqKLaFu9vNe4uLbt2MzzZoOln4MQJ2fM2vejOOVeXmmGdMlusgIJ8YQK6E+0QU/VWYIS8yDJgBpQp3pMx0pl2z2SAuGmu/2ikfc7/xfES9MVOLufMbZWwMMRUCKQeMLqL/27TfPbdC/BtZTfb0odkw++Lulzpq18EluD0GBbMZOZBM5Mf92P1BlWrVM08/mFro4/oyLX65WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Si6eBhPCJNx4gW/IojvL5PkTYJjYEA2WGlM51Xh3RQ=;
 b=SBCsitRv5CM3UgX86M4a0/VCSg5QVWkjRqUEq+ptzHJ5yFop6KV2Gswc+MWbisRmFi2nr3xi+dSHupi44HhN5fCj+yqQSjio5W9CGhtCcmTICn2iNUzmROJAqG9wpbUYRzJ4BgQyxl5DhInwjJFGbFdOkidgm6DQoC0uIkqFNc4ukk9hvrtIQYblMKuTPGhKqaoa32K6gCAJhjMo4EhwiyfcQNJ0EM9Nx0igXCinnnwD2zero7n4PUuSlZkE7zCC7Z2J5tMGwS1Rts5/qqajzsWfAMCIs3sMdTg7ZZ3yhkhSkEeKqo7p+znG893ldsJEi5PZhKvmZnzY9TNL1Jx7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Si6eBhPCJNx4gW/IojvL5PkTYJjYEA2WGlM51Xh3RQ=;
 b=hvfvsq/B8x5Sjn3T/dRXAmbbRQBN7ICsZTq7P1BqxRgqpn2abHpfuIch6wYiG0gWQjLtzrFMXsRwSykMSCR7QIDe0+xaVh1lxeq5l5xxInQ5p3Kv63gjp/2IGWeyPyRhoFeu91BzevXn4QkX+C0zveHt9H24SVWK02NPQSY8M27hIXnupmXYJUwfhxdbtr6tHiOFcMT0n/1UIZonExH0xAksdfAVHegIqM8vRKEM00AjVICPSeIPLT0CBHHHKz3JgLIhm0lynSFibX6lnpp9LBs4206sHoQmPwyu2fbml+5l8+TEkJU7ybXkSYgnsbeUIg5GK8aGXMcbhvcvKkKrgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH0PR03MB6605.namprd03.prod.outlook.com (2603:10b6:510:b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 03:30:45 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 03:30:45 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH 1/3] arm: socfpga: Use custom header target buffer in SPL
Date: Wed,  4 Mar 2026 11:30:27 +0800
Message-ID: <20260304033029.10825-2-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260304033029.10825-1-dinesh.maniyam@altera.com>
References: <20260304033029.10825-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::17) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH0PR03MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 58448732-dfbf-4440-ac06-08de799e6b92
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: oI6pRLAIxz7N1gKHPkUPAdDTyvMbtOILdJYv75Bq8CYiM4l4u7ba8d7PTXvQxY5rnh8QrDxoHWJGS7lyzmXhP1RShE68mJnwFI8qFMNW99yFdWUX+pv6howF1YXDRVi1aolY9Yk+cLZekTLOKscoYe9jzx/rvKOWDz3zXvM8hx6yIx70xQlai3MhSzUClLroeIxj6NMd6KCcj6BhT6eiLpGeIO0Cr2ucg3hf1bj4WngQrXfMA+Lc2T7LlAIkYEhFo9bGLeE1GexIDqe3aXWGweX/7h2ptgBicqV87uJ3x+/vl+6DItxl5BfmBcdaiccyoC8ZM+eY5/79jXhaxdy+BF4VDGBowXU9ML/0RyQ0BRNb/nsYt5pDYU6W00hGNDEogDxugyQyXj7uVYgLlTSKQKrKfGqyMnlOwKAp2JlA6g9s5IVffd9MlzwDvuFd+eQhe0dzUDFvcan8LmGUzmW6L8jGfAq+rAfF4ZjRuUZZp1U7VxGWF+uF9Dkjko0d13fB6R4sfPznOvV1YgNuRSKoE0S6y7aFHKa53pGnJ94kCn1kRjD+0YhhMCcnlZBv+K9ap8MK5kqFbB51MwS4/GIIXdTyMK8/OHs7EPtzXhsbm8/JkpZqu5A5Ou+mYyq+iAP/rsojcD6XSZhmI4qUbwbjn8yVlRx6mgkEwUV1qfpho6UuxHLb482+NSE62qF/MbN/Gwh00DWlicxfGn4nfMfbuPPgjgI0sAIzTgkqq9PBalc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sVkTz0LX0jTyxuCSQeb1GIxHSD18Zn2iFbN3R9altm3UbjDJh5hFmQgCbQR/?=
 =?us-ascii?Q?bnuoMCQbjbsnoHWkicF23Y5CHsgddLPYNoJPX/OpcBuSHCscqdU8BbxOKerN?=
 =?us-ascii?Q?KygK91ht0u+sCM7ao1Z4t0T0dWnqLf0I4Ce4kx+DdiVvlqpump6vpCdZRTgu?=
 =?us-ascii?Q?L0FKgwgH1/ZATu/fmAvztwOjaf7pJdkJiN2uKrgKUaM8UafTgvei52Ch8lxm?=
 =?us-ascii?Q?Dh+NUm5U5Rud7jdduggctBCAiroq/dZfi9f0acHPoL8JAEBUxCl+X3rgyd3V?=
 =?us-ascii?Q?FkhhstlGvMtblXJU8TL0v0Lm85jNe1FB9HeClOdRSAsgL76L/WL5VePeUfge?=
 =?us-ascii?Q?imLwzWLD31P//kNqW4Wh1G74e91x3Y4wx84N8ARjA3IBh0tdJqF+T0axG2ET?=
 =?us-ascii?Q?T26LFqveYHxU6dkZv7Jf7/zg0mXt4SI0+o0lCLDqQZGr+rgK0je/kQt3tGxo?=
 =?us-ascii?Q?SkhxANu1VP/VoGs6mR2JBTm6KycWef/142HM/SvHUlKwtW5v1IFpMyRKQ1tk?=
 =?us-ascii?Q?ndr927xVsW6DEP8wSgTHI2vvUGqV32EVafMx9ASvSoO3L/a509kCs6kN8uzJ?=
 =?us-ascii?Q?ObS2gd2s9BzGmeqwpYCc4tclnzE0yZXQhawvCjju8ytMZb/21GSIh269Ce2B?=
 =?us-ascii?Q?flg0RxfUHKUXjaFFJS0CWed21P5yE1mQt+nB9UOF+91SEeSqxT94Zsy+G7Kq?=
 =?us-ascii?Q?4gYuCYuUTUWUr5zeWdPEG/DZkINh1ThTE2Vx2QJi2M1sc0F/KAvOpHP46qJS?=
 =?us-ascii?Q?vyoLVlBRbG6xmE8V5RlKaG33E5xIaRSaeW0S01fcEqPo+watgRNiY4NVJs9a?=
 =?us-ascii?Q?uQeZb5lB+szgYpY3h0QAk+ytrOeHOspxHLiC5PZ9/6coe7pfrc3V40mlUZIL?=
 =?us-ascii?Q?dzB9MJj/J7BW4HgW3Thz/iYkoy8fZH9f6pi4VdVsQyU0GB/gQBNOPgK4N+LL?=
 =?us-ascii?Q?3k9wa4IyAy8zC/Jb44op26gaqghz5IocDXoGko0V+S/Jb4wyHoe+eNvZaeN2?=
 =?us-ascii?Q?yayxczGB93iXoqd2PuZFclhgxS/Ih+b7HglMY8k6XTXELHY/dX/7X1UHR6uJ?=
 =?us-ascii?Q?9U8dcUyRKCkF9T70l1QCrs08PUMqwrnEghSv14S5udXNRtDPO6TpA0jkwZLE?=
 =?us-ascii?Q?BIagAueXN8GIotN/k9pT3CNYqmXfNyyppkqbfFmi1gms0r08L2AGIPxy7fSP?=
 =?us-ascii?Q?f/08UgBbIOb5oDBs/9WTFIXMK79a5tpYEB4eLkxd70JrwSALZBzP1a/G53+3?=
 =?us-ascii?Q?wtsuo+FhURDW2HH6OkKdFs+LnpToCPTp1HXs9EwnMX4mkNgJZHXHW00WRO3j?=
 =?us-ascii?Q?CfW+/IFA6/traZc3DQyalhEfTDpE+zt4ZXmdisP0b7kXZHk3sNkMDP1JrBAp?=
 =?us-ascii?Q?YDRqLcsR/V2HrjysRQVKWsKQr9iQ+h8LXp6aFeTlwF3uShWlT3r/ggA+nDgo?=
 =?us-ascii?Q?j6ZlIXwMKAZVq9mU7gLkNFKer9OXu3PMNtl9CbVaGKGHkrH+XQt8uCYcw4Jc?=
 =?us-ascii?Q?ay5IHU5+skWSWb/n4txecxTaQTVMulqtrhbTfvbcBlzT1s1ff7u812zzUywR?=
 =?us-ascii?Q?CGkComgv2SxIMqSONnCrxNat9BxgOlxMFMi2496/bu6STHejU+VdW/7PPAOK?=
 =?us-ascii?Q?2vWkD5zbttCudDv/t3d35HPlBSzNUxOF+uKMJM50+5hD8zs/wvqI9Ha2o9A1?=
 =?us-ascii?Q?avoEL3Z63AVO0evCtfZ7IamDIk/sbIFu3gsqVYCup62IOb7cK5tYOb8EmqxI?=
 =?us-ascii?Q?unz9GcbXhLoUiSNx678obJXZczPBD1U=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58448732-dfbf-4440-ac06-08de799e6b92
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 03:30:45.3833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSLKrzqtfobn6L8SXynjHdlvSBbqYoW/bXqGTduc2uCCXYTywhPE5mFlZh/Q19GALkeoiqZQFJ14DKr9rTPwYaO8C12S9SeoQFXcLzPHv98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6605
X-Mailman-Approved-At: Wed, 04 Mar 2026 05:22:07 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Allocate buffer from bottom half of DDR for the image headers in SPL on
Arria10. This allows SPL to load the fitImage header, parse it,
extract the FPGA core bitstream section from it, and program the FPGA.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/spl_a10.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
index c20376f7f8e..c3fd90de8c5 100644
--- a/arch/arm/mach-socfpga/spl_a10.c
+++ b/arch/arm/mach-socfpga/spl_a10.c
@@ -27,6 +27,8 @@
 #include <watchdog.h>
 #include <asm/arch/pinmux.h>
 #include <asm/arch/fpga_manager.h>
+#include <exports.h>
+#include <log.h>
 #include <mmc.h>
 #include <memalign.h>
 #include <linux/delay.h>
@@ -284,3 +286,13 @@ void spl_board_prepare_for_boot(void)
 	writel(FSBL_IMAGE_IS_VALID, socfpga_get_sysmgr_addr() +
 	       SYSMGR_A10_ROMCODE_INITSWSTATE);
 }
+
+#if CONFIG_IS_ENABLED(SPL_LOAD_FIT) && CONFIG_IS_ENABLED(SPL_SPI_LOAD)
+struct legacy_img_hdr  *spl_get_load_buffer(int offset, size_t size)
+{
+	if (gd->ram_size)
+		return (struct legacy_img_hdr *)(gd->ram_size / 2);
+	else
+		return NULL;
+}
+#endif
-- 
2.43.7

