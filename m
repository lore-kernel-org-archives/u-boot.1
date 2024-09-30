Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C281CCE8375
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 17:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24CEC88AA7;
	Mon, 30 Sep 2024 19:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5555F88F83; Mon, 30 Sep 2024 18:05:52 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20700.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49ED388E56
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 18:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK6LFQ+tr19CbHa16KLfVQ8dBJxAU4euOMRuShXOve2FWj870+9RNmFPqhdXjJXehIZCKKQXQbpWkx9zh72FKlU8gq1tRXSjgtu2xLLAbJMVB5CiANUdML5an6fe+oFFwNXbjAl/GabUuLWtck6vaOE/bFRzyt9059Pa1ujagryx36oNp0jqPN49B8u/MWq0/4C/ts575SqdV//BHatUuSWF/u+YxSvEp0GPnzknUCLrZ1pyB14aqUjyKbidfz+kR7pR2v6MNK6A41ANs5fV6VWu/3C90kHs+VXNvpX/fnyTzsKhPBLZAtZ7t3ehbvpHtPTRI13qtdnJvq0QSOci2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVOw3kLVeLL3+4MLumz7ApSPiLhK3rryflzHhp4dSkc=;
 b=DFvRmqbqnwgjyQhQHEMfYw2VS1b+ln6/pU5tUSGsCjmjowgfuoy93Cu5jK1BfFWumleNazzW2jVhEluKpvLtdlZXx2Th/mVr5G39OMQJaJEcX5YE397Mpc4DPi4JYKKJtr0lDgiyruImPQ12Grs0/pN4MqVnfodOtQdpGksIYCOeVQK4FEEV6uQlIC82VcEU7RyYem1Bn1qwrGzj9Q/oSYq0tOKSXRHjuBWwCGdjhYFpxF74zf//XDg6KOKubuoYdKhFN5OWxFg3SUdnCthJoSpJfm7x84pa2XaGESCulqGPqXKJe00fmEFJ7JiauhV2novuwFTyxpfgOIJaIiVdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1148.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 15:59:40 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:59:40 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1 12/12] doc: board: starfive: Update the building guide
Date: Mon, 30 Sep 2024 23:59:19 +0800
Message-ID: <20240930155919.111738-13-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240930155919.111738-1-hal.feng@starfivetech.com>
References: <20240930155919.111738-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1148:EE_
X-MS-Office365-Filtering-Correlation-Id: b030f687-268b-4c3b-cdca-08dce168e44d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|41320700013|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: uZu8bz1X0I0AN3u1fj1aRcodXmtLO0JM/EOlGeOrzGEGpuyTMm1ZTCmFKxyxceoUtpuT1aRqOssYgz1/zmzXYuuOxSUBU0ZXvYJ4VyblvN0KasGo91E6ziIcWQ7CbfwPitVD/Jj7R5SDHylpHum815p/wynMtNF083km+Ps+2s4QffJgFcrBJqpQOmOLUs349nmw6yRoE/W3mVP8lP3aGFslFYM95fd6PYCL7iRO8/xB6DAk3RYZydNUC4ZJYXmHLP7STUUc+bLGUOfKQsm2zgSMm9NRtcmPUpXd5KIGqFFEHZjEAbxRVLRWRLSaLnaMKs3mp70o9FxRUJLhVU84MyhDQvrigw6zZ/W0Zo/gPiV0GFY9IV8pzatOFPvjVYsYsmo0LHbF83qojUMs16WKs11IGZQGGKb1yHrBDBgtuGuP8jy/I/EMyNshIcHnMwQ/tnv/YuWs0C5n+qVfVwrubc/YZ9NaymNApWA+xMq0PDpS9hXvacakHLxAB6gcjDIxbqD8z6ZXYELzJhBWVQ4dh7y77QYGSrjphUgmjU4tP+5xrE1i+UPMd5mDbDdd/m2Qyt4a+cVioQpcorAGO8Go5EhKeRm3whq13wWL3oPqs1MxGg994XrZOa/xggKARSkx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(41320700013)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n8PpAOyYYtdaZY+t+epgovYwuJZx4U9MsW1taCNUi7jgxheXWbJYA2otmd77?=
 =?us-ascii?Q?QqpFyZ249Yg+RWiVJtP1OZpYFwnI3zF1mw6wtQsEcz5T9ocpgminQybwc3S4?=
 =?us-ascii?Q?4C5CVwmVJhUBrSN8ZY9la1nEd0Vf5oBiziq88lYCK2PqqkJhHkjhh4/MZX7m?=
 =?us-ascii?Q?nu1ZE/9nd8s87QexTaDUwUurwXjhMeO3J9LxKlRkjfek4l7J5ar2LmF2ifOe?=
 =?us-ascii?Q?jS02szY3Wo6EK8+a0jhChQjowsJGzGwSuc/NgF8s4WUNw7z/TeXXzJ/pmJ/F?=
 =?us-ascii?Q?kkyZQ13Cbp+69YUppXBO92ZP5H4OQnHAxqN6+DXqvG2HNldF8MwcOL5ogAUP?=
 =?us-ascii?Q?QgE9aNFFSBMx3mlk+ulBeJ+78EHXriQNdTIKEo3BvEQDRHEbj/n80Ub6Iy5/?=
 =?us-ascii?Q?bVuClstaoMooyRJ7Lm01rn1cT9mUf1xLzoUAixOKphru7G8v9x6oLEiHBIlY?=
 =?us-ascii?Q?2njMIPEJSkpTDtHXO9Np8tatxnYNSGe9+w86N2ZuZpp6onbZ0riLTA2BgDuN?=
 =?us-ascii?Q?EiZXwsfNJb0noKzPLkdzfwGpIhyoSR3R++7bbz7iSkFnPEGwtMuHHbc24ONk?=
 =?us-ascii?Q?6ZLNijKd3AD/WpOI7hqSiKKp6J6dkpkEgBrQaCJCUWfMAhmiiUqN24Zmw0GJ?=
 =?us-ascii?Q?TN11epsZjxAqF8x9H1mE7/bHyqICFPOkA5FDjxU70Nxzq05JhOOobzoaV5BB?=
 =?us-ascii?Q?cJa0FWhbcu+AAO7eYXxobYKV5mu6egQ96mJJxMZAn40K/CzC6q2+NY2C4EW2?=
 =?us-ascii?Q?Q3mY4QUl2u16FzuSvht/1gQn9QvxQp9I9aLCj1pppctDOdhlbvVibpMrBnSP?=
 =?us-ascii?Q?tstYXDIsIHrULv01IWDgI3ZXXgdmXUSYPUq5AiwK+Lpb2mwTSLOxXRkKesgV?=
 =?us-ascii?Q?+rrq86J3KRMeajGRbDbqJ0s4hVoFjKm1o8L09l0gGimiW7pr7L0AuUNdv6u6?=
 =?us-ascii?Q?maw0IoYGMvPA4rn4EQVbn71AKn7TNodwCMkGc3ECFl3z/6g1tWiU0UwwB55d?=
 =?us-ascii?Q?7FG9kd6K1sIjnZHp3E+1qGmLZ16OjGVfjEcz0TN5zvZIJ284gIssA/FWWemd?=
 =?us-ascii?Q?6GBcikLcXVL2clkxaw/ktPzODnkwZTB5jtMYx6cECOILLFm8vAYYmTa32UHe?=
 =?us-ascii?Q?dvQpq1nd32gPhWQbgsRmmxaW/NKKHLnM3MRNx1YY0tPzlhwUiDod+GsSYpPZ?=
 =?us-ascii?Q?zKgOLDljI1lfmOykj9UO7N6dAerUsDapZnQVz2950klnEMM7yI2jeAqMXusB?=
 =?us-ascii?Q?Ri8q3aq+X89fdx/5hO/o51POdRpZlvSGSL9RlIz90xirF7c+QimLyEk+tvqu?=
 =?us-ascii?Q?ytfb77rXVcJkfclB11HDUGhHR5ivzgedT9bEgL1xhboMLbY3yJicj/OHkWnN?=
 =?us-ascii?Q?v7XaVDmTyZF6Cq7tCRxsOefGAx65FO+j66EZD92IHCYdaRiMc7lkhT+2zJTK?=
 =?us-ascii?Q?c0ARno+yht5ZzUTpo/Ilrx2YdnCjJ55fYfFxwvWJ0sGDKUQcmmO1uQXaPjlk?=
 =?us-ascii?Q?y+ncPHCvpURt6G5SEO4333XxVo2UOb9SWYSI2QI9mHU1ze8pRkVxLYqyP/gR?=
 =?us-ascii?Q?UCrK5u5YwUDYmLqZG6l/kVMTAEYGwp0sOMNeSCMGo96UscUBayOU+H/0Y2uz?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b030f687-268b-4c3b-cdca-08dce168e44d
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:59:40.4089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjzRBnXtDfSi8H+t/SiOlUy5GRBSxtq9QblkNtY3HO0kzmsx0GAy4F3FZ21AnyCzcildvPf26yFdZghN4peWBVwTglrQZe2JM696/gbYh6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1148
X-Mailman-Approved-At: Mon, 30 Sep 2024 19:03:44 +0200
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

After implementing OF_UPSTREAM, v1.3b DT is set as
the default DT, so if you need to build a u-boot
for the other boards, specify DEVICE_TREE in your
compilation commands.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 doc/board/starfive/milk-v_mars.rst    |  2 +-
 doc/board/starfive/milk-v_mars_cm.rst |  2 +-
 doc/board/starfive/pine64_star64.rst  |  2 +-
 doc/board/starfive/visionfive2.rst    | 11 ++++++++++-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/doc/board/starfive/milk-v_mars.rst b/doc/board/starfive/milk-v_mars.rst
index 554932ecfd..4aaed71e93 100644
--- a/doc/board/starfive/milk-v_mars.rst
+++ b/doc/board/starfive/milk-v_mars.rst
@@ -34,7 +34,7 @@ Now build the U-Boot SPL and U-Boot proper.
 
 	cd <U-Boot-dir>
 	make starfive_visionfive2_defconfig
-	make OPENSBI=$(opensbi_dir)/build/platform/generic/firmware/fw_dynamic.bin
+	make OPENSBI=$(opensbi_dir)/build/platform/generic/firmware/fw_dynamic.bin DEVICE_TREE=starfive/jh7110-milkv-mars
 
 This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
 as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
diff --git a/doc/board/starfive/milk-v_mars_cm.rst b/doc/board/starfive/milk-v_mars_cm.rst
index 52d4e5e909..dd7ec84733 100644
--- a/doc/board/starfive/milk-v_mars_cm.rst
+++ b/doc/board/starfive/milk-v_mars_cm.rst
@@ -64,7 +64,7 @@ Now build the U-Boot SPL and U-Boot proper.
 
 	cd <U-Boot-dir>
 	make starfive_visionfive2_defconfig
-	make OPENSBI=$(opensbi_dir)/build/platform/generic/firmware/fw_dynamic.bin
+	make OPENSBI=$(opensbi_dir)/build/platform/generic/firmware/fw_dynamic.bin DEVICE_TREE=starfive/jh7110-milkv-mars
 
 This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
 as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
diff --git a/doc/board/starfive/pine64_star64.rst b/doc/board/starfive/pine64_star64.rst
index 52e9a90791..126487ad17 100644
--- a/doc/board/starfive/pine64_star64.rst
+++ b/doc/board/starfive/pine64_star64.rst
@@ -34,7 +34,7 @@ Now build the U-Boot SPL and U-Boot proper.
 
 	cd <U-Boot-dir>
 	make starfive_visionfive2_defconfig
-	make OPENSBI=$(opensbi_dir)/build/platform/generic/firmware/fw_dynamic.bin
+	make OPENSBI=$(opensbi_dir)/build/platform/generic/firmware/fw_dynamic.bin DEVICE_TREE=starfive/jh7110-pine64-star64
 
 This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
 as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
index 2c68df3ce4..95ffaa627e 100644
--- a/doc/board/starfive/visionfive2.rst
+++ b/doc/board/starfive/visionfive2.rst
@@ -60,7 +60,8 @@ More detailed description of steps required to build FW_DYNAMIC firmware
 is beyond the scope of this document. Please refer OpenSBI documenation.
 (Note: OpenSBI git repo is at https://github.com/riscv/opensbi.git)
 
-Now build the U-Boot SPL and U-Boot proper
+Now build the U-Boot SPL and U-Boot proper.
+If you build for VisionFive 2 v1.3B, run
 
 .. code-block:: console
 
@@ -68,6 +69,14 @@ Now build the U-Boot SPL and U-Boot proper
 	make starfive_visionfive2_defconfig
 	make OPENSBI=$(opensbi_dir)/opensbi/build/platform/generic/firmware/fw_dynamic.bin
 
+If you build for VisionFive 2 v1.2A, run
+
+.. code-block:: console
+
+	cd <U-Boot-dir>
+	make starfive_visionfive2_defconfig
+	make OPENSBI=$(opensbi_dir)/opensbi/build/platform/generic/firmware/fw_dynamic.bin DEVICE_TREE=starfive/jh7110-starfive-visionfive-2-v1.2a
+
 This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
 as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
 
-- 
2.43.2

