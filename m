Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C626ACA0EE9
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F5C80422;
	Tue, 19 Aug 2025 06:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Va2QLIBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 634BB80EE5; Tue, 19 Aug 2025 06:53:11 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC6498006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQ1u9PhwnjZtKfoF8/UWOV8ZdCBc7CDccLK0BFICT7GhXWHUzfI5iNfThH/sUV4jy0AGpPfDSzGsyhvpxa8KmDuoN5Vi3Ull3NjKwZ8uR/OtN1Z0jM0DvHo7XlOkdMMpCFw3etZe1p23HJbYwWOoB+5URJDZ0j2QWxfzcLwGoWZ/56r3WPn6oyDyhmjlfl7tq1vh2cT8RbGFzB3nnWYuFKk/ge+78VC1yElM3bnsjOjJR60Qxei3NeNfmGT9T8ic/nCoor6tB+2oyAU7Z7r+SRPPoMX5RPTi5vMdz5Pms8/lW6xYSWibwGtktFEPjYfa3QSV24IFIc5cuHY3WuVNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AK7Qt8f64DBKnTpoZroLip4OamofbfAydIBGOYHrppY=;
 b=PaRSNHlC+DS14HG5kUe0Sw0+KMDJu3mHMeoQGjX32GVhEwdbo3bGp9ti2QUKtQPfOxsQTK+KZ67WwKHqE9n4LnYci4B1W57jpTtpjQlzbGfrlWZNXKzBEQxwjWW4DjkfQJWajGFSsjnxd2D1IWZY5YNobu9yJz20gntesdnKGsUx4SU2tz6d/+WLkdKfT0fm9QWM8gTu1qvZE9U/g8HO4UpQk9s/9/43Ar8Oosw987CPU99lm1Dza9ig3kDbw9qhp6DYN2Z0u1rV2IHEahHls9ni3AwhSARDcPcz2ckCc0VfFFT0O3VRDbz6qHDO6p5K9c6OYzB8oXiTZRVlJjPGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AK7Qt8f64DBKnTpoZroLip4OamofbfAydIBGOYHrppY=;
 b=Va2QLIBVkMPlQW1eWZ9CqUm7ycUui7+mbnKzLksOCyFAbYbJFk1q+iil4+PDSa3ZZSi1z0rkr/KQviGt5qA8Bh1V0XVuiwAXr0FdHvG6rIaeY2Rf/KA6ZDFZNf1aOc1YMSqmhp+BTwtpyHkxRKQZ0rlWtw4baOYWGN/KURqhgiqXRXGqVGTBtuV3EU5rW9chdeSkU+m+hwhtdXXI5IkZpQ0HiM0AUY3lCAUWrM7JC/RhPr5AM02Xx0y9RIRpYAxjFvcNjDIsTuAJ540ddKAJ77x/DBZPBmnEhh6klDn0DuI0FkpnXg4jTahJF0Vd/9srWGZZ/jY3CLC27VoJBy4OnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA6PR03MB8000.namprd03.prod.outlook.com (2603:10b6:806:42f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 04:53:06 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:53:06 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 2/4] arch: arm: socfpga: Add SMMU checking functions
Date: Mon, 18 Aug 2025 21:52:35 -0700
Message-Id: <20250819045237.18142-3-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250819045237.18142-1-nareshkumar.ravulapalli@altera.com>
References: <20250819045237.18142-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA6PR03MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b3d1e8f-1a0a-4ec1-f318-08dddedc4956
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9bOqzcOKMWyEryZJcYkQJGf3ChjXdYQkaf5kZ3lx6Hz0/V3lzohbfTG7CMbj?=
 =?us-ascii?Q?XlDny121tUf73Zs5/0x/9/IWVQaN7lnmspNRGxHhE2EXCGGKTLZGiqQydF01?=
 =?us-ascii?Q?ZjigOkZwxsOu9J3U+g1RRCwiQ9J4PeGq0QO14b/q3I9hSDbaO/RGKOCBjruS?=
 =?us-ascii?Q?HHWlK2o1qYJlwArD2bGbtm4nVl0S+1IcN+bNwQTRFwNDNjvm6OUHjiTySCW+?=
 =?us-ascii?Q?N62ExkP9hWJn83QCl0AQxugNdoFWMF3YMyljCONdj29FF5NQGiQlxL8LyO0R?=
 =?us-ascii?Q?57LrAcsTB9x7W1sjBeQ1qVfnLt4X5GbFIuQOJzrqT4+v8ZRc15v755zq9EMp?=
 =?us-ascii?Q?pX+ONWJxje08fAMcCu+KRpvuHOOc+YjVclttunmgRrdYS5bx+3GELZPURryc?=
 =?us-ascii?Q?amr1OyVktFXj7R7PnmuUIZ3Eh/iFzkeVN2gG/BxOU2C9MLQjnBL4UdTPoplj?=
 =?us-ascii?Q?g8WLKf0bEwdF+4+Lpw1y5LpTSvQupVXfouN4OhxhfKRyI+EqT5r+4EV8Jmtt?=
 =?us-ascii?Q?601Qq1xrLITy+FZ1gmloj55gk3hz8Y/KDzeQbpP8bGJVB8XlCCjfzix3XbUR?=
 =?us-ascii?Q?thBz6nE9Y+qLkTt6xt0bTzmIJX707ZZT4PVSZZooiDLTnbVXuc6By8qHgM/C?=
 =?us-ascii?Q?kGsGBlTiASLWRMvViuXXvNKxb89Q0FGb2qFWKmPLgzKa35SGsdr1UxcPJcth?=
 =?us-ascii?Q?MhhzYi5sfdVyVE1sHfm0WV7haCeZ8jztgxwr48og37MWqmaxchpurd2dTqzU?=
 =?us-ascii?Q?aWnm6OeD4Wv2lkfiwPCQcK42GBFYZwA9bRhlO1nFVwIw9CltBVT6/AP6AI92?=
 =?us-ascii?Q?GgX4246n6fML2z4TGG3hoa7zWQ+RLWC7solNhPgBOoBCoxcH8uJsqdTP6uDA?=
 =?us-ascii?Q?aeNJCQK2Mpfp1HSdmAH3Z3CM2zWalU9ok4woaBecH64oSvJuH7ICJtrYoYMu?=
 =?us-ascii?Q?8Q2V4G95prmLsNBRP/z8hEQ6EpRaMHi/KElkW2jgjA58cqhUVmf1C0QEMZ9/?=
 =?us-ascii?Q?grHRmorQ8qqYkAj05BBhkBpRadHZjSxdlCf3QD/Ig0v0XjmWmNhRUqtSlo5a?=
 =?us-ascii?Q?JlOneEznrmM7w0xxWQIHe4r79wvAY1NBTQSH+pZil6X7nwWyF5t9b7pSCcYy?=
 =?us-ascii?Q?jZDUjyM3isK3JeHaHbgogY1ziYASK6Oy3w95K4tVuVWl4SgK8lurwrwib2uZ?=
 =?us-ascii?Q?RHJztAK/00FkFqc3hKgN9hg6WqJrebaVMID9tmuElwHh4rYaqD7YxhV3OqaE?=
 =?us-ascii?Q?gJkDPW2mXbTGllAvI16jYvqAij9J7R2CRQcYJnaNb320r53LdfVaKn68wtzm?=
 =?us-ascii?Q?ANQ3HL4yARhtHIXOLEuE+GYtFMS07eeEcuHswZDrppB98udAkY723xXFg0KO?=
 =?us-ascii?Q?PkSVS1x4tIFL8IO0hkkBzS6+DDvSKJzVBi05wd+ZMuvro1NZFayRxhKHGMax?=
 =?us-ascii?Q?ORh8A2uLQas=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kAY4p8qFAZqWLMm/YPdhEyg7GVjPPENUbDCZAovvdRZcTVG6Tc4d6/+VQth2?=
 =?us-ascii?Q?HcZf6Sej3Epl6NYIqWkPFqTuBZkHLY79yJ6LJdRKwJ/vdUYT9tCF44sHRRVQ?=
 =?us-ascii?Q?oLd9f7um/pT21uN6J+y/9IrsNByAL2ftxVTCe2sxY0AGVKPOttK7hXjimA1p?=
 =?us-ascii?Q?vDLHTMKskkl/BxoMgFNhbzkL/GKNrnbFKCaF4KAnqYFO0YiG/MFZ7LGygWb0?=
 =?us-ascii?Q?hnw1JSU2eFeY+hadx3Ll3MwDo/VwHtIiPDVEqEacb1b0Qg4ktKthxXB5adxY?=
 =?us-ascii?Q?PfAnxMDu8+acwzT8JSPekABQm65nLL0r82ngly5jd4eyhL+OQlMHgvivzbkm?=
 =?us-ascii?Q?UBR6wOpLZvGPuxztQYKdihtqi9MRnLlTxQXLYNXTzauNU3PiOEIyVhRnnLrD?=
 =?us-ascii?Q?NhvN9yALBaXppQPtqC9F+Tz4oAtHMV4N1dq+guqeOLCZYEvB2RcCqjQn5S1P?=
 =?us-ascii?Q?q8w01j8O+j10RVKBiHqa+vb3eWaIafKj6b+rkqQMHsAerFHOK6emPx9f7vCA?=
 =?us-ascii?Q?Rswp6sCGKRe1hQ3JY0OJTsLSwjlSFIfbLf37bTxKML3P0merOD3YKi1ZLHuZ?=
 =?us-ascii?Q?MIB/9ZbIIIb5WAGyi56uzGhkJaJDnGw8g6bVXHc3XnmRFPlIQ0YT4NuqrPkN?=
 =?us-ascii?Q?3gRpUOjIrzkuXWm+uyL2b8f7pocPAZJ9MYjn6SzM6yeIiXsF/P+Y8ipAYO6L?=
 =?us-ascii?Q?hCvzpK3X1P59ld6uQD3fhvIUthS3YiOpwcVy9fr/j5HHIfoN/L2WJOv35lxz?=
 =?us-ascii?Q?EMkYQjfEZUbbULz8P8TrhhsPKdku+s32WwMDtrH20cODSPYDIhkeZkUKI6/E?=
 =?us-ascii?Q?z86fsLFWHfI43fBqxo/1zccJU0wBs8Yln3uKnpvVsH9ZMUqF7H09YdY9DAD1?=
 =?us-ascii?Q?me0GUOMGAyySbp8a4bFFDhZxB6bhoNZLqd3KbV9UNTldUFcqIkKZEhpQh63l?=
 =?us-ascii?Q?d4wFRmowpfKkom5dSi9mstjvdKc8NOLVv/TPwBnxdeRHZNKgVK5QYitqvsVz?=
 =?us-ascii?Q?nPSgi12PSHqwrSKkr5v/i+ucH5MkqHFCwK6hfyt5Trmxh8vAKqfMaKKNCn4K?=
 =?us-ascii?Q?d9JVOdsRSRIrsV+gUrxdenMunbJnf/DmHLGraV67j7Ia/uIDIs8NGIdf8REj?=
 =?us-ascii?Q?bURvhF6NOyafS31k+APP8VPN9TrLKQjDLTzdLo5NOLpXtqX3oPk9QAx/zagt?=
 =?us-ascii?Q?zwAqtgLIq3hVGUQ0N5ksNhq0+S565s8QhsicZ8viZBKGKg7bK45chdI1FLO7?=
 =?us-ascii?Q?4CuxNqvxXz0eUSooj+IVnGiMXI4RGanDtr85u/6Ve0hYwuIoQ0xwurYxPRii?=
 =?us-ascii?Q?KwZ4goVVpRqthJ7YYiUcEZ/syhdU/uMDhYNrPC0MHFDi+W/WWberOViF3JTK?=
 =?us-ascii?Q?OaLSKfbQM0Dp5imTVP1VDfgwb2l65A9eNqJ1x+VQKtXldJczCNLX4FZsXHOD?=
 =?us-ascii?Q?xaPt9YZk+OcJ0XVcknyulv+cyOx54dYYfL9fx++/xIU4KDbNRPlsfPiEwE9p?=
 =?us-ascii?Q?IdR5LKvno1rT31CQA49KlWd8LGhki8pHtcjaaaAInT2g5Aj8DLML6xBSyjA9?=
 =?us-ascii?Q?6A1whK36vn+oiEpD6F8KNcCWtURuaoKXprZbE8zQM59uS9ZDpSWT6PgzA7CG?=
 =?us-ascii?Q?WbRXKWGDqdYsnH8VGO43qjE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3d1e8f-1a0a-4ec1-f318-08dddedc4956
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:53:06.2103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2Y75otd82QwosUNbs8EGacoLjLnHluFnzpN2cuKjymerHX2qM3BAxRQQlrlZWuSHUvqBottJscjtYDCRt3/mBAg7ZfPyzpRavj0vxU+1rnvil3yUOu7+lwPXyomKuJJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB8000
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

Add functions for checking SMMU bypass status and also,
matching valid hardware device Stream IDs in SMMU Stream Mapping
registers.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/mach-socfpga/include/mach/smmu_s10.h | 28 +++++++++++
 arch/arm/mach-socfpga/smmu_s10.c              | 48 +++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/smmu_s10.h b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
index 4a28b109b0d..209caa86e38 100644
--- a/arch/arm/mach-socfpga/include/mach/smmu_s10.h
+++ b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
@@ -4,7 +4,35 @@
  * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
+/* SMMU registers */
+#define SMMU_SCR0			0
+#define SMMU_SIDR0			0x20
+#define SMMU_SIDR1			0x24
+
+#define SMMU_SCR0_CLIENTPD		BIT(0)
+#define SMMU_SIDR0_NUMSMRG_MASK		GENMASK(7, 0)
+#define SMMU_SIDR1_NUMCB_MASK		GENMASK(7, 0)
+
+/* Stream mapping registers */
+#define SMMU_GR0_SMR(n)			(0x800 + ((n) << 2))
+#define SMMU_SMR_VALID			BIT(31)
+#define SMMU_SMR_MASK			GENMASK(30, 16)
+#define SMMU_SMR_ID			GENMASK(14, 0)
+
+#define SMMU_GR0_S2CR(n)		(0xc00 + ((n) << 2))
+#define SMMU_S2CR_TYPE			GENMASK(17, 16)
+#define SMMU_S2CR_CBNDX			GENMASK(7, 0)
+
+/* Register groups for Context Bank */
+#define SMMU_GR0_CB(n, r)		(0x20000 + ((n) << 12) + ((r) << 2))
+#define SMMU_CB_SCTLR			0
+#define SMMU_CB_SCTLR_M			BIT(0)
+
+#define SMMU_SID_SDM2HPS_PSI_BE		0
+
 void socfpga_init_smmu(void);
+int is_smmu_bypass(void);
+int is_smmu_stream_id_enabled(u32 stream_id);
 
 #define SMMU_SET_STREAMID(x, r, w)	(((x) << (r)) | ((x) << (w)))
 
diff --git a/arch/arm/mach-socfpga/smmu_s10.c b/arch/arm/mach-socfpga/smmu_s10.c
index 50be049538b..c3230ce860e 100644
--- a/arch/arm/mach-socfpga/smmu_s10.c
+++ b/arch/arm/mach-socfpga/smmu_s10.c
@@ -75,3 +75,51 @@ void socfpga_init_smmu(void)
 	set_smmu_streamid();
 	set_smmu_accessible_reg();
 }
+
+int is_smmu_bypass(void)
+{
+	return readl(SOCFPGA_SMMU_ADDRESS + SMMU_SCR0) & SMMU_SCR0_CLIENTPD;
+}
+
+int is_smmu_stream_id_enabled(u32 stream_id)
+{
+	int i;
+	u32 smrg_num;
+	u32 smr, s2cr, sid_mask;
+	u32 cb, cb_index, cb_num;
+
+	if (is_smmu_bypass())
+		return 0;
+
+	/* Get number of Stream Mapping Register Groups */
+	smrg_num = readl(SOCFPGA_SMMU_ADDRESS + SMMU_SIDR0) &
+		   SMMU_SIDR0_NUMSMRG_MASK;
+
+	/* Get number of Context Bank */
+	cb_num = readl(SOCFPGA_SMMU_ADDRESS + SMMU_SIDR1) &
+		 SMMU_SIDR1_NUMCB_MASK;
+
+	for (i = 0; i < smrg_num; i++) {
+		smr = readl(SOCFPGA_SMMU_ADDRESS + SMMU_GR0_SMR((u64)i));
+		sid_mask = (smr & SMMU_SMR_MASK) >> 16;
+
+		/* Skip if Stream ID is invalid or not matched */
+		if (!(smr & SMMU_SMR_VALID) || (smr & sid_mask) != stream_id)
+			continue;
+
+		/* Get Context Bank index from valid matching Stream ID */
+		s2cr = readl(SOCFPGA_SMMU_ADDRESS + SMMU_GR0_S2CR((u64)i));
+		cb_index = s2cr & SMMU_S2CR_CBNDX;
+
+		/* Skip if Context Bank is invalid or not Translation mode */
+		if (cb_index >= cb_num || (s2cr & SMMU_S2CR_TYPE))
+			continue;
+
+		cb = readl(SOCFPGA_SMMU_ADDRESS + SMMU_GR0_CB((u64)cb_index,
+							      SMMU_CB_SCTLR));
+		/* Return MMU enable status for this Context Bank */
+		return (cb & SMMU_CB_SCTLR_M);
+	}
+
+	return 0;
+}
-- 
2.35.3

