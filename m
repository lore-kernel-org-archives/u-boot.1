Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93652C7115D
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 10:30:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3E1582CBC;
	Fri, 20 Jun 2025 12:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CwiN5p/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91FCF82D4A; Fri, 20 Jun 2025 12:30:05 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 177A680E9A
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 12:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHKDC5hJrwQDr1IRCUfB4TxEpTC3mNtabh0ZOyENsMDAUqi38zQ3oS0EtNZX8tl5il2G9/aLiEx5e6C/XTFgEaEm6Aj7A0lpqrsYLlMTw6djc5GNrSOp7hY73cyDPrIjQkpTK95iTGfVlalo4x9xt0cubo+ClIiAIXJNPHIu9Sys9eYH30lNwhG99TybOuA4Cn7NETqZOvkCQWm9mgxYx0buSeCqGRcUbSqIqV8e5cnYg0jTvPZIqSN1uY4J8+25+C092MGQrwat6ruaQUQnxOptTNNt4rznPhqHe5f7Z3ycJ+1tUCVY8NNfO+1ddaULuHInx0gEWjC7wTBKgUr+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfAkxq2QUgQxsnxergmm/CFvWc8ylQmTEaYkf6ldITw=;
 b=ol7Sj0jxFiTfWROxP4KoLSVyNFjwfHZ2aD9iKlvryDiYBQnAwSJeedH10X897QUoc4flWHhnrxJEpOJ6q8fdwtv7GWC/2PWMo9CkPHo7VWEV2u7+HxSRA8QRBJ780HhkJ26yuSU372tA6nWpesaZP/ySY21QYJZ/RyADjaCVd8eN/pyCHRqv6yTpoz43gQb5Ho9jWVs032fZo3tIlTYziC+V8LEMF/DkghYTK5fHBuQi2L30IzOtshssVroFUnXcTy+BC3/I1OC4VvBaBlH620TBuj0egXMZKWENp/r8yEwsmjwi9RiGL8tq58JZ9TqVT/20/HhCFX/JlZAP5bXvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfAkxq2QUgQxsnxergmm/CFvWc8ylQmTEaYkf6ldITw=;
 b=CwiN5p/wCoVc6R10FMAp7yOx7FyN81y7+4y8VgRNLVGJ5iINVYQdAPfCD3FmAYDA0f79Ml6xy6eKdiuxlqFfylRyNpVy7kohJKvjMMkU3mHWnQKCnWrpxLKyy+3eqzl5mAxdNrA2BwRJ2JdTue2TJlQzuAnhbMffi0EmcXfJzM7dA3OGvAR+bAIiHtmZggcuSfA5zonTNsZXtNZYtAG+XlA4pyCkpfxNLfLVLIxdwQ2wNlcq7LEnxR2HW3f32khhUdPf/mGZp1lmwUP3j7hIxFoOiF/CdcdJQv24c86rV/J9HFMIif/bToair9h7gLkFwhtU7El52eAp5wFW7mMOrA==
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
Subject: [PATCH v1 1/2] mtd: nand: Allow full NAND framework in SPL
Date: Fri, 20 Jun 2025 03:29:52 -0700
Message-Id: <20250620102953.29633-2-alif.zakuan.yuslaimi@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5fe1266f-0077-4c22-af7d-08ddafe567b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hcmi3+tyXEfk0FWkKH09sMYi+iWTf1FuKVAlUOMSJPWjkNXfDotLNissI4/E?=
 =?us-ascii?Q?UDScUXof7nSG/g7rD5eU1+jO/M4LbaL1lWVj/ILrF4pieclBn/NNxUNy978O?=
 =?us-ascii?Q?5CnWE00tkNFLYggcZQoU8la6Zpu2lexFymwuaK+n3XqnqhIxk1xH1qvsfweP?=
 =?us-ascii?Q?JdqvqfEYbnlH4F20IMKk1mQyIzTgm00AzmLi35jSMAtI/iNsCfJTpBB4TqB9?=
 =?us-ascii?Q?fsW+2tvQeqhoSIvm33On2CghtaZNRUjYwARaZ8qOZuVADtGjx29/vixIADIl?=
 =?us-ascii?Q?QlBZ1oJ/A6CHhswc4vdm9RhBGPT1fvYLbhUXVqdVHaDVZ+H3s9J25eufo0RF?=
 =?us-ascii?Q?Y5rEINb4Myiz62WRagkBPR9RiGTy+Bu3r2FLwHWCgB3PswqQgZJ057jkEGyM?=
 =?us-ascii?Q?Jo80SEGwLE7/72DpZrpcz2uPfnXpulgRp57IusXVBs5gDrc3eONcd1xxpGi+?=
 =?us-ascii?Q?ppuPvCGj2r9/DtxhOFW2KeeKBDAPGaw2vsWnT849eEziYKUWzZ8tPN3o1My/?=
 =?us-ascii?Q?kk8/X0VqasoTxse/MjInqrvlKjreGK/XOpa5JXifZeqjrZ4kvHnkjOBqYMbw?=
 =?us-ascii?Q?z0iaBmBfQPagkiHtMkBmdKocz1yTeTBJaEEnmLRGgN0zpqvAbQnymHce6KW4?=
 =?us-ascii?Q?YzL20ycl42VMYBgNkmfht3dH2J3M/ZyqWsdve++HFEHvOXTfNOzYlVBw+lvE?=
 =?us-ascii?Q?WRia89P9YnJgSOllvbshNZ7t1Vi1UFPy8TvGYPsz9M2jWJkv9TUY5bkPFSl6?=
 =?us-ascii?Q?HzNU8hV42l7DL+itFep5qSDg1Rnv3FLxwUHN+x8eQQbpngMgVS8x1lbBmlpQ?=
 =?us-ascii?Q?y5j+g9cqLn4ydzBTNIO0kLpmM3k0SY3hrbeboMlcf+45Gldc/2Hcd7BYW3n0?=
 =?us-ascii?Q?Z8lCREuFPXZTkO8nEMmkzZZ1oHi3YMwsfK6KVRzXUjw9HyOfHc0J4An7IUxR?=
 =?us-ascii?Q?xu6rWr+Y/kxeey0bSaeXUj1sTE273gfjROv0/qWj5+Q/xhQuzfR0QQ9pN1cj?=
 =?us-ascii?Q?4huaepx3DJsu8fy0kdaPCddbJWuEon0V9e3ejVgbbRe1c21u09gZKUBtKWL3?=
 =?us-ascii?Q?kdzpdonB1pIhlnppw7WlGWO9n9HU1Kvlfem14lTwOaKJiCjaSnXL3/eAR9D5?=
 =?us-ascii?Q?xfUf+JRq9T0Fi9vwpqBANyWP2o1t/o7A/UNrh4ZdiJicNMpwhlxbOTIIzxHV?=
 =?us-ascii?Q?j1/iybSa0LmAT2brHEwX2QUlE29oEi7IO6v8MX1UMa7yUgRZ3j9DBK6dj6aA?=
 =?us-ascii?Q?gLA6M9i0BPOQN/pqCfoMBoe36xA/VISV3kCfkbYjH3pFQ9yGKRhzMrAFupjd?=
 =?us-ascii?Q?9NkB/hkmz3IWioG/EuYa5BX9xATBZqsSsx/pZaw9JBn3mWAX3RO4tWHeQiyv?=
 =?us-ascii?Q?MciFUvY8ZqK2hMSmGm60oyZB8wYIOaG4fHs3oPh0dM1UO8tdpcB7I8ShBy2Y?=
 =?us-ascii?Q?1OZBMlb/5iQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O2E6TlcEjOXKKEeFzGUNUDp+OkPKQX5ogZ60kvL0EfpwMNPAtIg3oWjGORYf?=
 =?us-ascii?Q?m3v4n+KIyYnXArmyZY2Nxc+AJS2Lk8SXhNZGZn5MkvFn8W0b2eV3EJwArSHu?=
 =?us-ascii?Q?X78XXSw5awFbLZrrFaqzXuy0fNsL8F7v85lIL8htIZSjE1rJfM3WnT9zlIHc?=
 =?us-ascii?Q?HDT3crPI458EpS+O63hWwEkWjqo1X8tHXkhWbb5MpJSJ9Po1Ugw/eMT3xdYe?=
 =?us-ascii?Q?gH9FgbGJNQnvGREhQHsGeQcikqhCgjS5Q1MSxxdeBtg25OXPVaZc3lOeIUOI?=
 =?us-ascii?Q?ZdJTRIBi2FMoezDawIR15lcIuB7b6gGI8xN7OAycmp0bD1UAo4H7Ofow4lDi?=
 =?us-ascii?Q?IZ0HKEqncuuhYK2S1GGCaYaF3wz9A+97ubX3VN1l8cjTaXI6ow3/2+lrl1iQ?=
 =?us-ascii?Q?wa+r+dR5d1uqmZmSodUgzmaCPWZFx6QjWuRu+8xRAwNqCWGW9BrFSdttg9LN?=
 =?us-ascii?Q?sbLb6zaXXowsOC3dk+erKjz6RtzxoRUEJ/EvN4HMp7ekKBrxchd4lk695m8m?=
 =?us-ascii?Q?D/5JxGWwEDfi6MaWDNmUU1Fshc2evqe5YbN+i/Itirlkdg07aLQG0rbkyDSX?=
 =?us-ascii?Q?MV6v/K8Nuub63rR+0IdbuYd8RII7scgFrjZGmOv/pE/p+l+lwP+ytcXC0cCP?=
 =?us-ascii?Q?kKGXOU3KNHwh6ovQ5sFk8xVvN8xrNKeFj1njQzwRo5LLa9rynhfuyx2TTT97?=
 =?us-ascii?Q?n61twifoxwcWwO9pgknsFl98/zJtx4bGlqlVxEgC1Nz33nnlS0r4/uRHWq2B?=
 =?us-ascii?Q?hPycygJUihqsz5XO72dwi9cbug55gCtjIs9iylFnCxE0NEA5Q6OsI0DdNIPA?=
 =?us-ascii?Q?WQavtIKMAIE/0TlXWpN2ICpkcjZIei+qly36/+4eeCdc9NZ6Ku7A1Z0waaaI?=
 =?us-ascii?Q?EhufZiIOaWCLidTpc79+wnyFzuyPjzOUO1OVi3Z4gurMBu5CWTYYCp7qJbAe?=
 =?us-ascii?Q?wKzNq/7MyYT1xvzzLcitXCcoAhtctG3b0S6ZgE9Q6atYQn118nzv07DlWOWf?=
 =?us-ascii?Q?I7d+aCan0cbWV8XuHtf3TxeqFMW+kC9q2579wNat8aZacGfAUBwSWAdCHZ3N?=
 =?us-ascii?Q?m7lrNbVeq+jF1MhcLoczCcAKipn9x7jrEmtfR+0Ehug2FWB2MANRIKBF627D?=
 =?us-ascii?Q?Bc7CAyEoitmZeC+FXlZguCg6pAaRX6kRksLTc2LO7C3BqZKnkufOZsQd5lr6?=
 =?us-ascii?Q?aF5/DV9wumVNrIvUE1cg/qxNZ0N+Krnfau4Yg7gKI32nH5cxh4WrhQfSUFRv?=
 =?us-ascii?Q?zgFDPPljV7jhZTRoE60Oi9kzH/xr4P60Gf1zoeN6Br1skSiIG+goEdIfXKmS?=
 =?us-ascii?Q?DkpdpwgWQ3N38jT9dAGt7SeLh/WeRlverNaNI1Hqn4vEsUnV0MoKzWgKSF6K?=
 =?us-ascii?Q?20UDhWJLP38F5S08DDR0VFjqnzVpd9CmMoTV22HyEBa6fFlodV+kgkRwL0wu?=
 =?us-ascii?Q?3beVrQLT2tMHyTw2eyWdrtB+riGCvNFEv7Zt0lkRzE0PTCh2UvHjhdXxRVQc?=
 =?us-ascii?Q?UvF2WfYvqpkY69XuSS9VUCkA1/S0zXnvZDsAcZM94M+rmKPrqd4B3zoc1lfm?=
 =?us-ascii?Q?cbXo9Wy6dPWeqeXMh0PCQpx/KjID6dOxN04S3nMNfEjyHr0mz35T3t4YLlsR?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe1266f-0077-4c22-af7d-08ddafe567b1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 10:29:58.0104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMKd1exXkl4qqFuWqAF1NNCmbztUnxRU+K+s+OBcMFTa0nukIfJ97pLFz9pdKWopMkn2x4dpfJ7smQmmZ8dPievPEVX0tv86Q19i3TAKf3Y=
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

Add configuration option to compile the entire NAND framework into
U-Boot SPL. This is required by some drivers, like the Denali NAND,
which use a lot of functionality from the NAND core.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/mtd/nand/raw/Kconfig  |  8 ++++++++
 drivers/mtd/nand/raw/Makefile | 28 ++++++++++++----------------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index adb271dfb8f..28b48d53def 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -208,6 +208,7 @@ config NAND_CADENCE
 config NAND_DENALI
 	bool
 	select SYS_NAND_SELF_INIT
+	select SYS_NAND_ONFI_DETECTION if TARGET_SOCFPGA_SOC64
 	imply CMD_NAND
 
 config NAND_DENALI_DT
@@ -826,4 +827,11 @@ config SYS_NAND_HW_ECC_OOBFIRST
 
 endif	# if SPL
 
+config SPL_NAND_FRAMEWORK
+	bool "Compile the entire NAND framework into the SPL"
+	help
+	  Some drivers require a lot of functionality from the NAND framework
+	  core when used in SPL. This option allows compiling the full NAND
+	  framework into the SPL instead of it's reduced version.
+
 endif	# if MTD_RAW_NAND
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 34cba77046a..08829406902 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -3,8 +3,18 @@
 # (C) Copyright 2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
+nand-framework-objs := nand.o nand_bbt.o nand_ids.o nand_util.o \
+		       nand_ecc.o nand_base.o nand_timings.o nand_amd.o \
+		       nand_hynix.o nand_macronix.o nand_micron.o \
+		       nand_samsung.o nand_toshiba.o
+
 ifdef CONFIG_XPL_BUILD
 
+ifdef CONFIG_SPL_NAND_FRAMEWORK
+obj-y += $(nand-framework-objs)
+NORMAL_DRIVERS=y
+endif
+
 ifdef CONFIG_SPL_NAND_DRIVERS
 NORMAL_DRIVERS=y
 endif
@@ -15,9 +25,7 @@ obj-$(CONFIG_SPL_NAND_DENALI) += denali_spl.o
 obj-$(CONFIG_SPL_NAND_SIMPLE) += nand_spl_simple.o
 obj-$(CONFIG_SPL_NAND_LOAD) += nand_spl_load.o
 obj-$(CONFIG_SPL_NAND_ECC) += nand_ecc.o
-obj-$(CONFIG_SPL_NAND_BASE) += nand_base.o nand_amd.o nand_hynix.o \
-				nand_macronix.o nand_micron.o \
-				nand_samsung.o nand_toshiba.o
+obj-$(CONFIG_SPL_NAND_BASE) += nand_base.o
 obj-$(CONFIG_SPL_NAND_IDENT) += nand_ids.o nand_timings.o
 obj-$(CONFIG_$(PHASE_)NAND_INIT) += nand.o
 ifeq ($(CONFIG_SPL_ENV_SUPPORT),y)
@@ -28,19 +36,7 @@ else # not spl
 
 NORMAL_DRIVERS=y
 
-obj-y += nand.o
-obj-y += nand_bbt.o
-obj-y += nand_ids.o
-obj-y += nand_util.o
-obj-y += nand_ecc.o
-obj-y += nand_base.o
-obj-y += nand_amd.o
-obj-y += nand_hynix.o
-obj-y += nand_macronix.o
-obj-y += nand_micron.o
-obj-y += nand_samsung.o
-obj-y += nand_toshiba.o
-obj-y += nand_timings.o
+obj-y += $(nand-framework-objs)
 
 endif # not spl
 
-- 
2.25.1

