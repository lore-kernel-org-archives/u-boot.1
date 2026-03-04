Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C3BEDEC04
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 04:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5993383FAF;
	Wed,  4 Mar 2026 05:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tjHfHNJh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B4E483F7D; Wed,  4 Mar 2026 05:08:59 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 423EF83E7F
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 05:08:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJ236QmXawpelrbDulmRYPG7mI6M2JGUjo/ZxYZuIiphTiDtIQQDKTyfrXybno14qbCqfVqy8vXVszN4hn1Zl8EKw2zlf+CxeBIAxSJ0y2mkiuqdrovXVR3KXALh/fV4I/4i3BNEGefDu7hDqJxTDdX0ILCDZ4x1eGElLHXr7y/qQh/9eZNww8o2KMEL5BgaHlxpossPQOZU4Gc89m+N7OrTk+adVycq64l7GDvMztPB8qSTHrzU16JvK8GcoycDopupWokLBuRO2sAbpbiOFyETtAbLDR6CrI/s5vOefFQkCv7o6XZ1LmyZNMISRZCcx5YJJ3n7mSb8LuYCGpFWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPw5ZE0ijhkFIfBWFqUI0gONBiA9RsaoEOvDIsigwog=;
 b=MJstz0mTJz0IVjR0UYJfgBdnqeQPTAjYTSLFbW9BIVKQH/RNVrd6hrfSbT/yKbj8Vujkj9eBBBVW/C8bV5Tc8GvbQwnI5w2LuRPKBiIILvNo1hbRunu/ODdKTEwemzJhs9M1cBl80ZOXjHVGYy55bptxnUYJAqQFXOPw/L7yJmCIWkW3a/0HsvlqHR5twa+LgrdF570OszMS2aLXqk6eZamryPj4nQE+T6/dlQRjkkEiqPvcK1oPfJZYoPCehxuxzH7kZGyaF7YOt8C66LBkKpBjElEzW+Y925ukqw++HqdFoA725Byk7mQMsuvgOikfbGuSvy2QSAH8rB/OcprGfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPw5ZE0ijhkFIfBWFqUI0gONBiA9RsaoEOvDIsigwog=;
 b=tjHfHNJhUto/wLbTX6noVq/s0LSWH5XyirS1Ut2qVIbJZynzPxzrYB7X72amD79Q62myC/NlmbiVtiN/AVf0YqS3kl1VDjaT6cGo49QcqrKUmwFZnKc62D6cyfnxeSQiK35pr+aUNJ2b+89kcl111ObcPMsZ1Rewevo+WRf3bMD5Qv/W/gZskgqxCT6bqyzm54ea5Ibxy55+bI3I1j4fg0HvJc0JZRr4yK9U5Ofb5ZJ51yKMUTh09uHaUiTPgB/rg+MITRLZtf8mq3JWt0z1Nsa0bUakv0i81qnfkgdEaatgZZ67PmHDvpTZm0SkjpJA8LGSlPpWKXUtXayaMHu1mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SJ0PR03MB7101.namprd03.prod.outlook.com (2603:10b6:a03:4e2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 04:08:53 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 04:08:53 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] drivers: watchdog: Enhance watchdog support in SPL for N5X
Date: Wed,  4 Mar 2026 12:08:43 +0800
Message-ID: <20260304040843.11298-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SJ0PR03MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e57023-6f8b-4c80-fd78-08de79a3bf6d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: Y1d3Yj9f5E2pSmKvVQL17jAflPxmXkeAGiUBJXAfMTegyMtHPFlLiBVPpu0kB3QEtxl7n/h3HcQkmKLPZFv23dxZE6JuHtKg7az/TljsRXDLBsCMG7DE4G/Ayi4FzCBWI1c5NXn7RrKUXbz7YK64JI0Q5WBqxZiPxjw9xTafSClBcDEy493A6yw5TsZdtKJ/g6F/KvzLZYOIJwLU6FwSeIhjA91gknIkBYhmYLCg5wiPuVQ6Gcpw332sts6lLWrBTY6QEcKFFz+YwCKkFRjUmil/nKFbo6KGZLuO3DRID/w7goGzFYOHd0BLnN10U/7dLfyVpv7rZ98BlPzDI4tGucWIk3ExnapexOT27LJkR/eOg1YS1SqHr1wKQoQv2nqpo6xZEKeOK8uvMfP3SMuNNvmbFJa33c4dsokKZXcHfWj2cZtSiJpc55Qog87Ygfe0oBsxKBScvHMIvNufnohxcwF0THZlMCWChIIPvJk66aHKax2oUOKq38YxQ62SU3tnqpZe2GgPhmLxUn7YaOYU0C1+CHVFzMEZCJcL8OCACvqJQhvtvxxxV3OUYprQHNyRZ4Lz80m1a2jzOav6mkA2N65q02HI+pcg2uSzx4OjYPyoeaGa24OkUJkMz82aAQTzQk8J54w8edToYFVW9K2Y8jyZS2Bk5HE2aBWYpBDCoid7/r8KgyCUGxtbPglRBfYEpLpDzk1ZKH2tUlRMvyiI+WUEvPmXI3WsNf16OVDOBZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VdEtUnbEoIGw6OkezyGfMYsRxEQLIHc9hCbBTDWWW9aBBWIPVSzxlORMSeBh?=
 =?us-ascii?Q?Z8zwBqvGoP921NjrPcMWWcLm0oicmsQ9JEs8IYvDm0xy37duVit0vpXQJBy/?=
 =?us-ascii?Q?ZuoWD100gqAZ0yxySG2Uj2HAnxtgKrXwJTvFhcscaM0Ar6DFQ4ETfmTx8tZw?=
 =?us-ascii?Q?+gv5jPgGZnwoUwQMiZ3Cbubf+PS+pL1GvXZ1PdL20UWrbf5YxP/sTQEQS33e?=
 =?us-ascii?Q?bvLnld1z17ha/Tr2S8fluyr1tessay3YuEtud+MDSCLMNaBOdK0Z+V8MH5tD?=
 =?us-ascii?Q?p+AUdQY7KlAHBeeG/FA63Zqi4KrRYdJBK4BeAzqu1aUhH/94uOi4s2ntZ0aI?=
 =?us-ascii?Q?Xltxq2SwfT5ZVBPUJIwA87HGd/mYcFDQf2HF50sFhF+upltOcc/kAjD2I5Ig?=
 =?us-ascii?Q?AUjPOjuaumKTc+IOK2UNWivHBeh1WWsv89juiyK7jwp/gqtwekGY6RG/3NLr?=
 =?us-ascii?Q?VwmBgFxZ5FcNwrSlbrt18zs1fQdsEhCCZWIqbmc1Z3CB9nU7oRWLBWgahLXl?=
 =?us-ascii?Q?ymoFM5AVcZ55PaekvvRXAc0T27w/OXO/U8jSrb/VDeaMEqtYz/RUtAdDN2Ok?=
 =?us-ascii?Q?eMt9SLn5i3EhM17yohsESDT3H2UmC8G3Oyy3vno60Fa1YgKLMRxqYzA1RY/K?=
 =?us-ascii?Q?UmAU1gDm7fWs99wHygBi++7bYAQmaiPs7HW3gpNbfD5bT4bstFP0MHHCkzyp?=
 =?us-ascii?Q?AkAUAlNu/KRSyDdobT6X43RzZsT/qJX/HMWj+zOjC8tKIbXQri1xOmEryY+C?=
 =?us-ascii?Q?enyy451PEAtw/lxtXfnKgSGmRBqYoUsUwJaQTsHn38mbmkf7g2qqbrsqWu/K?=
 =?us-ascii?Q?oIAv/b3v8A+ZH4TKCg4ppVkPS+YM5akHeNjXU1qCMtZMftSud8RzxEOYiwZj?=
 =?us-ascii?Q?vU9v3RQTlelZP0sfIqD/S2IcKNJYQRO/QAxkrLD/9f9TAYlVG4zJc0wDVXQ2?=
 =?us-ascii?Q?wkaWZyaxPI7tgLP5b2Sk/9iWSvmih2rRpT5o5X9TK1L3DHWOHhCTzlt6SI0l?=
 =?us-ascii?Q?Ov9IGtr3Jz6w15i90cFXYWEnPX+22V+SN5PegoT6UXAWfCjuh5U8YrXBocA0?=
 =?us-ascii?Q?7mno/c8eNoeJ7YYuymz7QhGCZhMVBbqlHfyQwYsu7kxX2vLlb5RdTSu+K184?=
 =?us-ascii?Q?Y1t1ckDXugxN0ATiXXONHV4fPeEVZ0SH+B87DXUxqOCQiGhydfLVie6jnrye?=
 =?us-ascii?Q?ZBaA+zzZ7jroXoEqb/BuP3e2WFNBM+DiIIHRAqQ7bX77zTIimy68TEgoMYyN?=
 =?us-ascii?Q?sa1UAW7S3WCq8LOr5NqSJeT0gCnOylCQzx7nKA2NvODVI60UrV+gEtDxW6tB?=
 =?us-ascii?Q?Y2x6JHNAXh9Jh12Ab2pSOWscC3CWSsBVU61nSN1OkWVYsiv9Sy5aDYZyzUZt?=
 =?us-ascii?Q?jGJRBs6tRPEdGd7c8JvIp5a5mooCdXFzQhaTC1QFxdhdBsXTEy+wyIv2E8pC?=
 =?us-ascii?Q?pAabdXbqmVoq1BednYndQ4aZPczNwXE/WB55ED92pS2Mggtbv6Tv3OGPhV8A?=
 =?us-ascii?Q?OMz+hd8NQikw2XUrcHPczTqhANeH2f0gDKOw8AgpeOu5lrbZFrJXlq0xjOwX?=
 =?us-ascii?Q?PpA2OfFIbp610kR1AOc+ipaQ+skFXOISAu2EcKc3ahiW7mWvUNFpRonGTvmo?=
 =?us-ascii?Q?cH8c0HSMfAJ9XfAY1SjLy2n3S+9SFz6wGQJbhu3/xJLQorRpwaUQoXnaeMQj?=
 =?us-ascii?Q?qyXo5LI5p7V+MwUtWrtr6ZoVLegGRqk8XDpvhqr2RWzM12hWN0+1o9WH9uXs?=
 =?us-ascii?Q?0bw1+tNzPbusvW+qw4uUgR5c1nPOLs8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e57023-6f8b-4c80-fd78-08de79a3bf6d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 04:08:53.4788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qBcb0JUAjGVGc99fIfFFmILhNz8X9Q/aCX4WhFFYLdggX6PD0CDf1MQKtVYrgfEFNCmAfCnf/DaOu5/1Cnbl0V3xQ5XwZYOXnhjWZ5WGvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7101
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

Enable watchdog before initializing other component (example: DDR).
Thus, watchdog need to be fully executed in onchip ram.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/spl_n5x.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index 81283ef7162..22c20f89b4b 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -9,6 +9,7 @@
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
+#include <asm/arch/smmu_s10.h>
 #include <asm/arch/system_manager.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
@@ -19,6 +20,7 @@
 #include <init.h>
 #include <spl.h>
 #include <watchdog.h>
+#include <wdt.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -37,13 +39,6 @@ void board_init_f(ulong dummy)
 	writel(SYSMGR_WDDBG_PAUSE_ALL_CPU,
 	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_WDDBG);
 
-#ifdef CONFIG_HW_WATCHDOG
-	/* Enable watchdog before initializing the HW */
-	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
-	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
-	hw_watchdog_init();
-#endif
-
 	/* ensure all processors are not released prior Linux boot */
 	writeq(0, CPU_RELEASE_ADDR);
 
@@ -69,6 +64,14 @@ void board_init_f(ulong dummy)
 		hang();
 	}
 
+	/*
+	 * Enable watchdog as early as possible before initializing other
+	 * component. Watchdog need to be enabled after clock driver because
+	 * it will retrieve the clock frequency from clock driver.
+	 */
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
 	print_reset_info();
 	cm_print_clock_quick_summary();
 
-- 
2.43.7

