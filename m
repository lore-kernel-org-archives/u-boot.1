Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A592FCD8C9D
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 02:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9222C84851;
	Tue,  9 Jun 2026 04:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="H++BiSR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D9084851; Tue,  9 Jun 2026 04:04:16 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1453846D3
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 04:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zun4Elqa/EWKF83DDb5cTilHvbLUoMlpkHZ6Qp4eYmEsYeptmawKBupEZHySS/OtwB4CJiIarsqtISjHUx/u5IuBVfZeUeeIMVXos02eToPmOmJM8AN6d58/RQjjjoWKto+Sx5l230L2zAMlobC/hP5xd1qIM7XRvEciwiyE0nPuyPbj3UvV8WJmQffaRnBxVomOuPgRg2VKxX6pnAaOtHj1+vhUWOkLtataCREbrdwmtEn8Ey/q3L5m/5uYsmYRJ9tLZ50Lq+Xropl7FFNM9q0IPsdwrH4egFae24s1650oMq4iYzQZ6/LaGZFZ6bivSpr4xzT7p2VWaaVOcZ+gjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfYeAB2PKfLQHV/nmFIrip1EWi8f4QYtdFQQbsQgUQA=;
 b=WsNhTFkFj0SW1CTXXaAmhqfCF7Udnd8qOLr+EVAdwcg6Pr1q+QdMXycnMK3os6x98RA/2jHpaaM2RgpYido3LbAFVO2uM3Z/BDtqJUASLLBz1m9qmZyDP94LjQ9x7DgiYz0HYkw/B0Lbk3GxCR8KBxDkxLS7YXOtwm/7eJwPgz7uBO7wVtzMTJRLbGheGj20BdNeKeTSJKFVlPiGrXvIWdsr6geg86jPutQGfHkM3/61FkVakYyMNbCyaiGosoQ726Z4dtpioxEKcty8ilIzUWjkeL4/ZXcb03XlAukCkmRqQS2VwcgSBy2pRkRORzdWmgdUfn7lthbajSZ8fpkK+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfYeAB2PKfLQHV/nmFIrip1EWi8f4QYtdFQQbsQgUQA=;
 b=H++BiSR/WOWixh3Po4PzUxnwDSi96SxqBTC+hoN3DcEYastjZ7VKH3+ihxYskmK0gqE9XT1I19GbyJhs6LXaTxkc/9dalMUvFJ4dO8KyytWJ81mIqu2YAVylT5ywlpEZdUbYwHJPcbwEAWdRMb8yxlgdt5lTuAGJbUIXF1MqHqP73JPDBSZP336S1qEwLcx9qcg/2VZOEvK6XaGMyv2HPDRbEgsFgb+AYY2JpeM/RCacaQq7Wd4BlLAWUAWmOFCoWd0GIWjswaAY7fnfG95+PxgR2KyC7wXsJlSQUf5pWtN8NXC4Tb6ApZ4Z9Yxyh+W3ReoDDeUaXvD6obkvS4NODQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MWHPR03MB989484.namprd03.prod.outlook.com (2603:10b6:303:2a8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 02:04:11 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Tue, 9 Jun 2026
 02:04:11 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, patrice.chotard@foss.st.com,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v4 1/3] arm: socfpga: Consolidate dram_bank_mmu_setup()
Date: Tue,  9 Jun 2026 10:03:56 +0800
Message-ID: <20260609020358.25985-2-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260609020358.25985-1-alif.zakuan.yuslaimi@altera.com>
References: <20260609020358.25985-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MWHPR03MB989484:EE_
X-MS-Office365-Filtering-Correlation-Id: 10981d0d-428e-4013-43a6-08dec5cb65e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iYx7Yq4RAXMnGrAj2kWu0hLXKmpcSEJJNLY8s5Osn1mvfYCmeehQywDapjNRSvt4DoSoa3+tta6+eMrvXallFvqJl/38QlU+d4ZovblQ/7V0lGkn/d7+K9/BvGmcx/y4JF8k1Q5zVKaOKaAif9pU+7AWSIeiU3PJTKg2ptHIgY6/DGSr/qVLiRsCzOCFT+9cQDgbMMNXHCSKQNgR1tsYido1+3/FDCl5vPah06z2nlWv8ngLlM5OqnbzXGWBjtMTT85HtoTW9vxbDww9f5QVqSDkeqEpsoSgjM2apwaECbUsgyyvZg1ust/DNnRzIVCNYplXbVDLYdG7N0faSzCBCxtziyOLyqTbIXYVSCIaZ+skDGozYna/PaAyfhPVFLm81ZBcfc6l1lIKn1znGmpNNXjYBZBqrU8ZpUuVG4BrrQTJImAO42KIEf3ly3mAKqYLu12AwknM6CELT2uUrBEV7zkBXZqXRQBusLJjWmFbKBajrsxc9U/sK99RGhji3qBFEv/torJWUgMUX50ggV4g5aCmqXCVMiHnjWXYaS3mPdiKkHh+ob0MRogYP1BzwInrHdrIHpCI5JHgiVoNWhiTZXu1JGpgG7s8RfDITpvcBJAj2/1GkWZIvUKbA7D8ms0Qe9mgNFbm+u2ndSdxpZPnTOeJbB/MR6y86VZKgAIhcp1cTDHwTRvMyr6K9txZtFWc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2L35L9nH1KwkFa/F3ziQsPBS36pXzI5GFI14YG2OZNu9Dp2loJJUcrO3Ll3M?=
 =?us-ascii?Q?xQhLTlj9s04GIihC7RNW+7/KrkWBuNLNBDbHxfnFTrc75USWq6oGYS/MMacT?=
 =?us-ascii?Q?mpLFDcZN8fLzvXT/Him6C7+ovSnVX2zHoiy/U3/5FZn0q5ChpRlaR3Ducw1X?=
 =?us-ascii?Q?lfvtaXi1pQ0HF/3j8Puhw6gJPWokS+E29YX/I+llyd+E3VzJs2++MEu0LQsE?=
 =?us-ascii?Q?4TEqP9Epav/Vg1hatiK7g0HP6US5pJhpD33FSB8/BQFNS8rmKCqkDj9qh116?=
 =?us-ascii?Q?/qIeBRbdA0ebtM2rPg/R9B+BP7Ck+16I/JiHn9aUohrF/AMf0J0qwRmL1rpw?=
 =?us-ascii?Q?qvxjo3hYwGp6k7Cbs0v9pRNnFoOMlVT3Ba9j9WlWQfDj+kVvLEu+H1+DZrNL?=
 =?us-ascii?Q?MW4FHe/Nr2krZnu87P2F2GJnSJG4zFnBjzewvz1BbOIvE0s4ilwajpjNDRmr?=
 =?us-ascii?Q?rz1XYnY0abGSHpY3zTe9+Pnq6ROEdsP/uKuBGBXXuj5uu12S7ErUDUKvtlmN?=
 =?us-ascii?Q?J7t4QpOFP4svQixD13vlhKNRmpTe762iB7VChbFW7vSBucT+2OjmbQDGMJNc?=
 =?us-ascii?Q?C87qOcnBigzNIpizVJ5JDseNgTgpEvbz1wzapMwOfk9xbARWrp1WN27jwu+U?=
 =?us-ascii?Q?Wg20g8O8ksR1vEkyd6WCdWSeFBykgZT9RDjOjFkib8QWtZJwqrToZcd667xA?=
 =?us-ascii?Q?1qnxUakzOJ6e/Ut7xj6Xel20ZNbPAWgym54jy5fV9k0gC1HhJh12PxWdoh2Q?=
 =?us-ascii?Q?qp+N/M4DrbL9xKzGpjkSSFQLi1u4HqHtEOY7g0Z2m3ffFRGhonOprjmQpw41?=
 =?us-ascii?Q?Zk9wWnuHgcV9rsv4YaWcmRIzLFkl/kQByHFefg2WZR8iTfmsq4TblazoLMhY?=
 =?us-ascii?Q?yKuq8HJmUfv/8G2e34xQ8CdRPKMOtgKpUjQ0PZtE+x4wrSVdxqpIPHel5wit?=
 =?us-ascii?Q?SdeGICy7NN5oQ88pHGD5tu/o0ggyKqIokp8oZnGlyNRMTIhsQT3uInnJZT8X?=
 =?us-ascii?Q?YFdV2NvPweceAWSEzHQ8ia240TAS/DIB+E6UlIY5+6+bEjjdOjfuY7RgnzXn?=
 =?us-ascii?Q?Jw3JNrmMDCcVeMTWNBJXMxH79AiYlasQ1ePDxGwjerm8XbWV5DJytnqANQt0?=
 =?us-ascii?Q?az2Vg0PyHJx6oHU6iggOhjpbpUGK5Uw838X9+fdNh1aq9qq4YMr/+W5dDvRV?=
 =?us-ascii?Q?LRb9f2ilx/XJvepYAA/JZ07GES4xiyCR0cVzVcSPpQt2l8pm5GH1m5A1eiGi?=
 =?us-ascii?Q?X6JGrSsoDJuyGL+7oyzZ6QtA5XiVpuSkt3U7H3PRKiqczfKsY96GUeyZfNiI?=
 =?us-ascii?Q?arrUmMZDf8M3OUaTrdKY3he09LB9bCt/P+WJNZ6DD37VX+sjEl9dVaY7jgNA?=
 =?us-ascii?Q?cXzP7GAczhOOV/S74vLIBcbdlmJx5A1Z/6wkzljC0kz/tAxGEFj9dVQPtwZL?=
 =?us-ascii?Q?PhXuLzuaCfV3HpTogQc/OypOWaKgBzP9PQSqiTBiJotN6qF0pZgpCLz+02Ak?=
 =?us-ascii?Q?B0wZjtovP0p+SLQBgGpAnf19u74t1jblo2+wjdTw74c7ndHRwfpXhvWDMuFl?=
 =?us-ascii?Q?yi/+UXI5+sAJUdFIi025Dq2ym52l2ir683C3e+yk6uqKz69wG7Q3mn3JhxAO?=
 =?us-ascii?Q?a5pnVzKY0Dy0IetWrR0UDqs6R/6pRKYSfxaFDrPZUj6hcJKMyG4KRQ51bhoX?=
 =?us-ascii?Q?+YD+IfU51nZ29Gw6+q0m+JSc7bAPYSehPr7Zwgy+64LZd5ZTdBy4ZJGXmfaT?=
 =?us-ascii?Q?bSrQ3ilcHUDFmofbUkAJy4GJH59FVDc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10981d0d-428e-4013-43a6-08dec5cb65e9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 02:04:11.5055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Lec+Y/nEro0w9eF/0GQP8KjIjFvLTflT+gEWjs5+KTUtDoMWsq5GBLCwEQiSh83mHvLRuGDOmnTmXHlsokcHpYoPHinF5TsE25zJ9Bv/l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB989484
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

Share dram_bank_mmu_setup() between Gen5 and Arria10 in misc.c. Before
relocation, map OCRAM and DRAM write-through so SPL can run
sdram_init_ecc_bits() with dcache; after relocation, use default DRAM
cache attributes.

Fixes: 503eea451903 ("arm: cp15: update DACR value to activate access
control")
Link: e26ecebc684b ("socfpga: arria10: Allow dcache_enable before
relocation")

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

Changes in v4:
- Commit message clean up

Changes in v3:
- Removed 'select SPL_CACHE if SPL' Kconfig guard from this patch and
  applied this condition alongside SOCFPGA_ECC_SUPPORT on patch 3

Changes in v2:
- Shared dram_bank_mmu_setup() is set as optional via Kconfig and defaulted
  on only for the reference Arria10/CycloneV boards to avoid SPL overflows
  on size-limited Gen5 defconfigs.

 arch/arm/mach-socfpga/misc.c         | 31 ++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/misc_arria10.c | 26 -----------------------
 2 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 1eef7893e54..80b054dcae9 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -318,3 +318,34 @@ phys_addr_t socfpga_get_clkmgr_addr(void)
 {
 	return socfpga_clkmgr_base;
 }
+
+#if IS_ENABLED(CONFIG_SYS_ARM_CACHE_CP15)
+void dram_bank_mmu_setup(int bank)
+{
+	struct bd_info *bd = gd->bd;
+	u32 start, size;
+	int i;
+
+	/* If we're still in OCRAM, don't set the XN bit on it */
+	if (!(gd->flags & GD_FLG_RELOC)) {
+		set_section_dcache(CFG_SYS_INIT_RAM_ADDR >> MMU_SECTION_SHIFT,
+				   DCACHE_WRITETHROUGH);
+
+		/*
+		 * The default implementation of this function allows the DRAM dcache
+		 * to be enabled only after relocation. However, to speed up ECC
+		 * initialization, we want to be able to enable DRAM dcache before
+		 * relocation.
+		 */
+		start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
+		size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
+		for (i = start; i < start + size; i++)
+			set_section_dcache(i, DCACHE_WRITETHROUGH);
+	} else {
+		start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
+		size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
+		for (i = start; i < start + size; i++)
+			set_section_dcache(i, DCACHE_DEFAULT_OPTION);
+	}
+}
+#endif
diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
index 7e0f3875b7c..635fc3568fb 100644
--- a/arch/arm/mach-socfpga/misc_arria10.c
+++ b/arch/arm/mach-socfpga/misc_arria10.c
@@ -243,29 +243,3 @@ int qspi_flash_software_reset(void)
 	return 0;
 }
 #endif
-
-void dram_bank_mmu_setup(int bank)
-{
-	struct bd_info *bd = gd->bd;
-	u32 start, size;
-	int i;
-
-	/* If we're still in OCRAM, don't set the XN bit on it */
-	if (!(gd->flags & GD_FLG_RELOC)) {
-		set_section_dcache(
-			CFG_SYS_INIT_RAM_ADDR >> MMU_SECTION_SHIFT,
-			DCACHE_WRITETHROUGH);
-	}
-
-	/*
-	 * The default implementation of this function allows the DRAM dcache
-	 * to be enabled only after relocation. However, to speed up ECC
-	 * initialization, we want to be able to enable DRAM dcache before
-	 * relocation, so we don't check GD_FLG_RELOC (this assumes bd->bi_dram
-	 * is set first).
-	 */
-	start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
-	size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
-	for (i = start; i < start + size; i++)
-		set_section_dcache(i, DCACHE_DEFAULT_OPTION);
-}
-- 
2.43.7

