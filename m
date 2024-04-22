Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077E3C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 13:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F520883D8;
	Mon, 22 Apr 2024 15:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="RlNjr2VT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88DE18834C; Mon, 22 Apr 2024 15:16:27 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0701.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 823F6883A7
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 15:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0gl/zrEeA1TVb2SqHUFscHyaojKuhvC81tLU5oUS0kMSGLnRkWqENi2vkGr81wOm9uSw34TwE/PkWQXHppTRjCJLdkcoy7qONRbyd+8xsDv05Dv4d5RO3g+qO6rCNsExltVtmWw8RvQgnQDOICKAkKKmh70f4VKM03ePKANCbFFFoWT7RX6LiUcgyGNAhUzZOB9mnN0lo7qHHW8MuEHabGyvKLnaeIc38HtCioa/CtZZDcWibh+THVUwUGGwMynxDSHl7KM2DXvW2mslmuA6OPjMaDBQnoc1BJDVIV2X2KJ2/cQHr+MhKgdaAa9KEJ3NMJPjE00keasYb521cPz0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy9A1Kimt70Cnht0g1nRIII8S6PKJEY6sap9zA0UFao=;
 b=mb3Zx3yylpAIY2+OrhGRKTUK9LE/652AepLgippkO92SCcU3eo45/Wr5tUwe0+RRp5cN7uRwavuzGdBRASVtJADko6Swnpc/VO3ma26Kq57n7oBtNVQCEwZ9ZySvkjmvo5gmrUsbXeuiqqYbgTfYsSJjp9AbCLqsOy3swPkK0J9UXrkGSGwWofznhgU2LKn51+jR+1fy08jXQcsPy657Wk9r3Tti8xPJiNFFrwQhAFNMzqnWokuN5H8lWOPgNjJ9uCGPKv/4vxr94He8YKe/FaEWedq4RHny9TJxVOw+67A7YzXF/kM93Tcg3ebu7G8AgpOPo56bJJxRsA4LlideNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy9A1Kimt70Cnht0g1nRIII8S6PKJEY6sap9zA0UFao=;
 b=RlNjr2VT9VKOhL2XoBG2BNV8HQ4YSN0PUCFmPLo+/9KsgIPbgQyZ1Gs8IIHplShqec9SNaxNAOgDKQKXTrY07Z/+p9iVxHVeMAkQmOxdJjneCRuRjkWLoVpQ5NhRCisjid8MEMpLrv5q/nptv2/q9xTUPdHzOfO2ORlb8uRD1jA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB5620.eurprd08.prod.outlook.com (2603:10a6:20b:1c6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:16:23 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 13:16:23 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>, Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@sysam.it>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <monstr@monstr.eu>,
 Minda Chen <minda.chen@starfivetech.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Priyanka Jain <priyanka.jain@nxp.com>, Rick Chen <rick@andestech.com>,
 Scott McNutt <smcnutt@psyent.com>, Shengyu Qu <wiagn233@outlook.com>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Thomas Chou <thomas@wytron.com.tw>,
 Tom Rini <trini@konsulko.com>, Wolfgang Denk <wd@denx.de>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: [PATCH v1 1/3] arch: riscv: Rename spl_soc_init() to spl_dram_init()
Date: Mon, 22 Apr 2024 15:16:11 +0200
Message-Id: <20240422131613.84304-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240422131613.84304-1-lukas.funke-oss@weidmueller.com>
References: <20240422131613.84304-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1b3df6-bdfa-4d38-b45c-08dc62ce682c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j2W1iNeV5xwrddakrhUSJcVRX0BQWK+QXykoVweEhSUY8NkUz54/tHGmLRuU?=
 =?us-ascii?Q?Xks7V+Xf3QMvWI1KmPzsaYYI1h9B+dU2KXS3gIPJqrWH9Wqk+kAEMoT0nolg?=
 =?us-ascii?Q?FPHGvI+alAKj+H1Skovc7wTXqVhg0cl68gdvFkTFSF5RuPnoEbvSKpGKTB5h?=
 =?us-ascii?Q?SYrrqfSvxU/Tt2lDz7eEGjDOoSj8R9HBA82WAEfD5ih53U/0dyFxMOibcvU7?=
 =?us-ascii?Q?yiA8W01dqHhWiuSCUmrLjQH1ynLQrfSHPhwBMVlYyW1BVbentocbZAsICQKY?=
 =?us-ascii?Q?3t5R8OY3O1zecYLNQJd6rBaSg0TtViVLzDN6GBVASsVY+OKetaP+frv5kK9E?=
 =?us-ascii?Q?zBogwlzl/UwioGnVYB/bfS7TIXYDlSFBbFd6JzClikUNVdXGYcIK+bLTEvMF?=
 =?us-ascii?Q?pcuAvgqrwKHYU5XEV0NArvEx/mCVTz3ZeVtqkbJAoT352PjPp8LeMI6lrqJi?=
 =?us-ascii?Q?1XnyC5PmbfPrTHhV+WrEvQ3BBrbhDD7aHidnbfG3UP9RwKPSSbQG+7QmXx61?=
 =?us-ascii?Q?jSDNGqMjCCEUgbifYBDssemNxtPoxArXU8TyBB6vb3r/5CFwO3DrM0I09out?=
 =?us-ascii?Q?h0ux80QIMObi6M+u826xTNVaAByTXSrd8k9IevQToAI3SzT0SopIGX2xVjzf?=
 =?us-ascii?Q?EUJH4T/oGW1ySteXMbMsBERY1iRgWciO4TsPHT4QHS6F4brOgCmLtDU06GHT?=
 =?us-ascii?Q?B/ogdDbnGvkSFt5yg1ye4lORvO6lKbpSLFbAj2GiQdR1gfnXcQh+iKm/5tMZ?=
 =?us-ascii?Q?fEvuACjeJ75t76yxgUOeVC0ZDvrOqG3JYLZoddUUwrYME3RfHTPpS36mPJhd?=
 =?us-ascii?Q?nrjSeQZnEKfQd6Es+cK8O9AlfTfmHxDiEi64MTqTiFKoAEOgwSjwoRnH2xf9?=
 =?us-ascii?Q?8NBOGq/PBZt9DiN3yeaCiDmixNUZXwNfSTSrXtdxNbUOHfz9E0cAKZeywBK2?=
 =?us-ascii?Q?HKduuz8ChqQ6MVxH3gwg8ulWje0o1QSsQ7I3nycGCSWZeHO0j675pZ4R4Dak?=
 =?us-ascii?Q?v1ARM9hIPtVqtp0yLsBZvMoHTkJhBHGTx8gO4xXudPlQ6fk3scMa8Rq5wQNa?=
 =?us-ascii?Q?onND64XP7UhlJrBP9JUA4k6OMu1dQRIaxMzbt3r+IkFhvGFNuWluvc2hE3O0?=
 =?us-ascii?Q?tX9Auhmka/A6LpDfysOpPRRKMLSPnWfEQ2VNs33jgnnd+otm5zObKnwGVkuj?=
 =?us-ascii?Q?vL9/nNCPONqoqwBlnkplKH+P2UlYmjL3CmD+6IbrI4RNZBsQzahEzYmlVWMO?=
 =?us-ascii?Q?M4TRo/9eHQnRnh67EayuDcQLlUnvKg0E3hROzbKV/tmP2n2IPsYj3R8Ph63Z?=
 =?us-ascii?Q?y/t5ZUAQVaOCvYbDGDvNLM7TEikvM2/7w+cSyO9Mo9YQdA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(376005)(7416005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kSHY3jj26VjTsT/ji/zTiU/VkL0Ju2I3PLjWMrI1TVuYYMFLEjaMwNN1ZePU?=
 =?us-ascii?Q?384ai5dOOeWEXW9MKU0PJwDmO4ELUlEdyFLJ7uhT70AtYCLMD0KL+Cxv3bHl?=
 =?us-ascii?Q?1CUUhA7PGAmkxYkOefd3KADaDY5XifyvU6uHvlqJ7ei2OvL2SxIPgonb+qqB?=
 =?us-ascii?Q?b1tkJOhQyCAieN2WC+Hr7K+QyMdn5Cr4Zle0umxLsH6zP1QhaoYh7AzO7vCv?=
 =?us-ascii?Q?25JKeCIpSQgqxVnYy2IGB6ObWJLlFh5D7hWjHTM4rrumY/WMC+Hayb2wyWtQ?=
 =?us-ascii?Q?qWfU788fWbSExAew0kxGnN5Da9oERrTAGpv1Xx8A5mpfveo411Oo8KK4rq2J?=
 =?us-ascii?Q?quD1z+GynpKsGogh7DoIsN7I/ECudCBGyTBbwIhLYGJ4Q/79fF8m7U9o37lu?=
 =?us-ascii?Q?LipXEk+rNaqFCQX7vL6APF17Tt0idNiftnjQVnCkqbIo0cbEQBAyvxgikALR?=
 =?us-ascii?Q?Inr119vdY97zJOyJSRl3N4o3g3DHxgdD7dnRo/j55ACxPMafX2y0+JMRsEl4?=
 =?us-ascii?Q?jL40WNgNnGT3wfhb2HredPRFxwQh+pxXmIKa1nT7b0ci486flys7jCccGYyM?=
 =?us-ascii?Q?iX8PpfPI2hyufLn9YXUEFlCCwGkBTxjBaL//TBPdTZjf/6dfnFtqbrjPVXl4?=
 =?us-ascii?Q?pzDzzRpL/GLdC0r8cbaITRVMbtajPVYpXpgs3aDCgLtFVjswA1pGVUH3/BPF?=
 =?us-ascii?Q?T+9Zblg1cZfiEwUmDr5h19XiBlWGkK5ksYcIVEZ51ac8RG3r0tISgYdFszJr?=
 =?us-ascii?Q?8iVphzXc7y+gk1V8SD8y4I0KDexh6uJ7aytfkr29Z2Yfl3fuNLBG0nmmQYRD?=
 =?us-ascii?Q?YzB3Nghk0oBkbrFrT4PSNgOsp3pJRUyhMKYPh6Ubv8O43akp62eANkUOuiD1?=
 =?us-ascii?Q?xNB70YIT2lQZYWyzP3jKOiQU116nmoQcd9hDZN4V08/tuGC90QEz+zcCyhOw?=
 =?us-ascii?Q?rm9UhNGuuelhw/a5Am0kasas4UICVb8CYBpaQF0rCwGlT9Ko0GDzXikruB2l?=
 =?us-ascii?Q?3Kk9196NBmAW8bR60cjQKxUsv3GFrvTgA4gJdUmWYyPK2CVUoTd/1Ww2tMcs?=
 =?us-ascii?Q?Y/G89HxwvtDcItI4+6/g3iFzsn7CJdh2kejVBU5OskSNuxiMjdkKBHgzRikD?=
 =?us-ascii?Q?/s32mRnl2eM/oSG314ioISEJddfgjjlAQbKg3AUMQh1sMy9tSUMNBeOukf/J?=
 =?us-ascii?Q?PIpwCGXT57CEq07sE1hcZeWviU4pMr1pReC6CZAsouxLgAOmTGWfKyN6E7Jj?=
 =?us-ascii?Q?ov3V7vTMrgYYAjxULBrdNwNvl/uJOfIySyhKaA0cYxmHfWT+2IKruN/8dvyb?=
 =?us-ascii?Q?UJRV2UoMGcmsb6SoJ25WcuaHWo0xZ+eqB3yXFKsUD14cNniTHKIaic4DvjBG?=
 =?us-ascii?Q?vAOTAC7BWq7vL1hs95nJC0Dl4B6mh9BfO2VKiYjVf3TKANM3ziMdFaUrBenn?=
 =?us-ascii?Q?CHOccXu9JNW4aNnJi739x4ADMjuFYb+xIYIHyldgUQa/aIjhjG2ZQXMNYrgf?=
 =?us-ascii?Q?s08xZRdsPD2bqR2NiHr7DeVQ3pKCALGw0GExoq1ZBjBqM15DHSIwKeRuJfdt?=
 =?us-ascii?Q?YfSWujukEX1pO2EEn97pBgx3Ao9Ejw5IlfodptNr/qwBY5Q+r5cDcNsKZLWI?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1b3df6-bdfa-4d38-b45c-08dc62ce682c
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:16:23.1870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IKsQM0LqS3QNd5wEwffnZqmYrbYcB1cX0xGl42XnadJ1wG+8ZGAfG5jq9wyKK1QP6aFqzA7alcjYnub2Dzimg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5620
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Rename spl_soc_init() to spl_dram_init() because the generic function
name does not reflect what the function is actually doing. In addition
spl_dram_init() is commonly used for dram initialization and should
be called from board_init_f().

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 arch/riscv/cpu/fu540/spl.c               | 2 +-
 arch/riscv/cpu/fu740/spl.c               | 2 +-
 arch/riscv/cpu/jh7110/spl.c              | 2 +-
 arch/riscv/include/asm/arch-fu540/spl.h  | 2 +-
 arch/riscv/include/asm/arch-fu740/spl.h  | 2 +-
 arch/riscv/include/asm/arch-jh7110/spl.h | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/cpu/fu540/spl.c b/arch/riscv/cpu/fu540/spl.c
index 45657b7909..cedb70b66a 100644
--- a/arch/riscv/cpu/fu540/spl.c
+++ b/arch/riscv/cpu/fu540/spl.c
@@ -7,7 +7,7 @@
 #include <dm.h>
 #include <log.h>
 
-int spl_soc_init(void)
+int spl_dram_init(void)
 {
 	int ret;
 	struct udevice *dev;
diff --git a/arch/riscv/cpu/fu740/spl.c b/arch/riscv/cpu/fu740/spl.c
index c6816e9ed4..16b307f036 100644
--- a/arch/riscv/cpu/fu740/spl.c
+++ b/arch/riscv/cpu/fu740/spl.c
@@ -10,7 +10,7 @@
 
 #define CSR_U74_FEATURE_DISABLE	0x7c1
 
-int spl_soc_init(void)
+int spl_dram_init(void)
 {
 	int ret;
 	struct udevice *dev;
diff --git a/arch/riscv/cpu/jh7110/spl.c b/arch/riscv/cpu/jh7110/spl.c
index 6bdf8b9c72..87aaf86524 100644
--- a/arch/riscv/cpu/jh7110/spl.c
+++ b/arch/riscv/cpu/jh7110/spl.c
@@ -28,7 +28,7 @@ static bool check_ddr_size(phys_size_t size)
 	}
 }
 
-int spl_soc_init(void)
+int spl_dram_init(void)
 {
 	int ret;
 	struct udevice *dev;
diff --git a/arch/riscv/include/asm/arch-fu540/spl.h b/arch/riscv/include/asm/arch-fu540/spl.h
index 4697279f43..519e7eb210 100644
--- a/arch/riscv/include/asm/arch-fu540/spl.h
+++ b/arch/riscv/include/asm/arch-fu540/spl.h
@@ -9,6 +9,6 @@
 #ifndef _SPL_SIFIVE_H
 #define _SPL_SIFIVE_H
 
-int spl_soc_init(void);
+int spl_dram_init(void);
 
 #endif /* _SPL_SIFIVE_H */
diff --git a/arch/riscv/include/asm/arch-fu740/spl.h b/arch/riscv/include/asm/arch-fu740/spl.h
index 15ad9e7c8b..b327ac5036 100644
--- a/arch/riscv/include/asm/arch-fu740/spl.h
+++ b/arch/riscv/include/asm/arch-fu740/spl.h
@@ -9,6 +9,6 @@
 #ifndef _SPL_SIFIVE_H
 #define _SPL_SIFIVE_H
 
-int spl_soc_init(void);
+int spl_dram_init(void);
 
 #endif /* _SPL_SIFIVE_H */
diff --git a/arch/riscv/include/asm/arch-jh7110/spl.h b/arch/riscv/include/asm/arch-jh7110/spl.h
index 23ce8871b3..d73355bf35 100644
--- a/arch/riscv/include/asm/arch-jh7110/spl.h
+++ b/arch/riscv/include/asm/arch-jh7110/spl.h
@@ -7,6 +7,6 @@
 #ifndef _SPL_STARFIVE_H
 #define _SPL_STARFIVE_H
 
-int spl_soc_init(void);
+int spl_dram_init(void);
 
 #endif /* _SPL_STARFIVE_H */
-- 
2.30.2

