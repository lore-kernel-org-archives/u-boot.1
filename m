Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B957BC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 10:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 153E78800D;
	Wed, 27 Mar 2024 11:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="geCRIwIn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BC678806A; Wed, 27 Mar 2024 11:46:50 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2C498800D
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 11:46:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCgPmu1IRgcVfx9+rlCO4gkACbKsJF4DOIGrXYXBDVRV49jMbAiWhNNVn8JtNEU63vFx0ErhPX9YkVrAVR1gKBIDNKhlaM3C/2rQqFh1HLf/D4k+zcDtP/4ovpczz26JEJMyj4PXl759vahKsguY1wWDG7dz/dehtNHJrFP0/J/4dL8ea0QqCiI5Bw52ooovmACygfX8+cJsYHtNhDHxa5iK0/HVzy7Z5u4Ye/vndXQo+vw+OjB917nsNHW2J909PJ+EzO10gV3Nshst4DCSGAF2gP3mAUe4rldqMCmu6taBQjG9BnWRs6FP9bVQeV+xf/GjQlOjXBD2gOVUZOljFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V76TR+Qq6yuHzmf8QYD/b6MFzCQ4njdNy3vNei6QR+g=;
 b=Hw9klitjdhQF5Sn8zFNfY9cxaL+aoErnapqJlrNzKv/nMKU8lTr/Yd7TMtTTldW5Nmr4i3oYTcaIk1xDVzrc+EKD9LFq9VIQZrmM8nT1VMI1dZpZ8N+FGun4cGuI329OvbckaDIusJbOy9Ev2pX47Lg+K8XYDGOw0Qr/axab8xzArCwoG0nk93hQEj5RyhdKLGOyJpiYHwRmxNZ6QBTnwUgTmrjR8FUytGpFCY28hpfJ3NtI0TRMsBj8LftCAFRwByz/mEmSj2QxbYxDJeT3NFoD++3UWL/oBauHkDkLXnNOEPIa7pjDHoxOMF91XpqlxzKYrJpf5XmTicWM0ah5EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V76TR+Qq6yuHzmf8QYD/b6MFzCQ4njdNy3vNei6QR+g=;
 b=geCRIwInzg1g45K/ES3nLaPlXZPmc6sbT6DTPYhebsJ5udasLNxgkEbZg9tLawl0uxZkw2KrB/ZMy1fAVMFMzR8uJGs4qr5cd6OvVM6H/9OFnIGZ0Y2HWKP1tyr7sQN9NPsLn1Zw+giJaFrxY4Iz/k6fKjGh5GHCExzszBEQIuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS8PR08MB8064.eurprd08.prod.outlook.com (2603:10a6:20b:54d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 10:46:47 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5%6]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 10:46:47 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng@tinylab.org>,
 Chanho Park <chanho61.park@samsung.com>, Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] spl: Introduce SoC specific init function
Date: Wed, 27 Mar 2024 11:46:37 +0100
Message-Id: <20240327104638.2432672-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240327104638.2432672-1-lukas.funke-oss@weidmueller.com>
References: <20240327104638.2432672-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::13) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS8PR08MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: e519f17f-ae6e-4b00-2018-08dc4e4b3364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIKEXNGGtX4Ff/70Tk4W+1CTDMN71Eg/gt2yWVLwxJyJKt22SdIHf1Lg/rZX12n/pGdOhN/zic1g5nxoIJaZuE2TPFHVHKDdLtsly33MhEIuZfME8oM6x3ps0ZqJGoji5UTOrjO/DcE74IzPa79WKiwMGevQWh0uCZ6nLjTNUFp/Z9l6unW3sh12dkIbNiCw62E+me/IAI1jzDK8RJD4xs9+ljStk2X0CZTbEBWrRmg95W7JjKQWJFAjAiHGAdaMFMC0+vsu18ExpMYSpbd+VoAHsETup9DGjnnTa8BI9mIYjBJByYziouIhavfbiLP2Wcy3A2h+40jktRUHfKHFSuVfpj2V3pAr+D0MHj7HYVs7nsv6EtKOBTpV5XnNGQ4fr5oLN8wuHjMlA+GFTYiYFPZA2qcZoWQ+NqGs9PMlIcBxiJGPJgGke6WoDxsvSbhgnaEZScCn9Rn9q0X73bMYQ56K6FjsuU9ukzOUyFdT7RD0Ayhz+Hspkw4YvKSSJgb0aMs+dJfZReGwYwF545uIal4J8sWboRtr9b/LUDMgnOZjiQnIYtz07+RTF4+ZLKVs55Bq0G4mgaaJb5kWhwKqGkyZ14mWgSS4bt6TuRd8MOTcHrz4oDuM2T8X1UP7FpTo+fe7xT4WqeANHzI8VMigtYTAVus2IRI8TU2pWDJNZJNlCLjH0HxHNC54o+q2INHx/zkkIk5eEfbv8pEJGAxG3gMgRjD4cROE+kBkQ6VpgUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IjO20MDWke/VbZOIPNBpSMc+JFGY7v4uEIiJVjbch44SGt1t1Ezv5ID5fkiK?=
 =?us-ascii?Q?1BHF75ck67yja6zW6zqrproSWQAv87sX6Y7smRJzfy8ohhYlDYVBtNIa2faY?=
 =?us-ascii?Q?YqEtLRDZNNoClDKPCATx+m41ESIry18mfketxhnXhcvBb1VIMYx+0x23HPYz?=
 =?us-ascii?Q?iFvtW7ve2y1uCr6UNmnOvygATn90mt+6Mnu7VIYdNEayeDPGnJBNWk+ao88h?=
 =?us-ascii?Q?t86hjt/bI3AfEx4fO4nAgP5RkmWv8vlhNs5j4OC57o77uCdNq0Ax4b+CQOi3?=
 =?us-ascii?Q?+aCxDZZ6GCn5TBHTn/11EPbwFB+X799sQj/8jXZ4Xvcs8Qand0hpcUZhCbmR?=
 =?us-ascii?Q?G5fZgq83nQRPlTBy5y30ftb8Oar+bIw8H94sYprF/YrlEpWIqhi4wPRdr/ww?=
 =?us-ascii?Q?iWMThU4pycsMmWdzUs7OHFVmUGAgfDw5P4M5H891SsWlB9/a1Vxmssjt66Or?=
 =?us-ascii?Q?1NfCDOiIp3Nyz77ySEk2yuh9MV0Tx+56WlW04QKK4/06f/EwvPTR1HROWXun?=
 =?us-ascii?Q?kPbI9ax5YCQizChfeAWvxoRmKJxSZrCUXQNz+DeWACROz7dAmVb2bqJ6g1Qy?=
 =?us-ascii?Q?lhE03ZDGlLjQRl1P59s9YPnWEOiWB0MosaWaf/d1M88REyDBvkuNj+yyq4Gp?=
 =?us-ascii?Q?47LCLvG7OEm9NzTd3mu9nmvxgRXeh2IQVwhAiVM63BJVcPkzkEs7cAE2sTXo?=
 =?us-ascii?Q?QosQiXaaFaGmvwPPOkh5WQ1CfbW5rWhBq78RMYiHsKFuVS4IZ/2R3xZaMeVN?=
 =?us-ascii?Q?8l4+xGsUfjfTeqphBxT36oaY7RvgmBCrkptewj5QIiczsxwLfaf2ofXvhtRF?=
 =?us-ascii?Q?+cf/zZyyS4l555hF/1ZLgdKyXl7dsXh7rkXHCCJpY2moQFxFBuklVzJJoGc3?=
 =?us-ascii?Q?ttCMp0ShgEqm8qq2KPNIH+nu6rBS1138Jjo+/cbSVHsIytO1qwIUQr9HkaVI?=
 =?us-ascii?Q?VqtJ7kZkHRiupD+ssS4DhbFP1bMD3OjivVyRes4BzqvcaYqkT/4R7FzWgcDv?=
 =?us-ascii?Q?TZEAlp1u5RCo2a6g3AOkpuCxmbf/hAoVCkky0EmRgiC2L2CpZW+RZ7TBSxyV?=
 =?us-ascii?Q?ZpSBKhVXyJghdIs/d6ci/skHaHC4wVNPoKXZNkw7d1weOyt4xUH69aSNEMlj?=
 =?us-ascii?Q?lGdC8Tih0sC8MYrBffEx+LA5aAmEuWhz6cMxqZ4XkYPIx98s8yr8UvilF0Uw?=
 =?us-ascii?Q?ZIglO3i45hAYmgTrN4Z/n/MTKiZnaX19wkGRnhadSHBc53zABlz2aivrBsSz?=
 =?us-ascii?Q?cSzDM8WL48Z4FUeZfIntMhW15SIi0+3yhRa1VLRimng3eAodnXxA3M71wWRH?=
 =?us-ascii?Q?3aaoFYEQpXWy5GJpdNOJ024G83fBMQRJzXPl14BIAw+xyCz3bRbWULxrU2MM?=
 =?us-ascii?Q?ZaXtRI2kJMjC73cbE3ewWIny8dzPOdm7JGVlGToPsSwmp+AuZ74q74biUcrL?=
 =?us-ascii?Q?gsnDstu+F0I6UiEDeDTSAPRCFtlK1CNsnG5OyfxckD+FqXNH6mn5US6HEVsQ?=
 =?us-ascii?Q?B5+hR8m615KGbVR2SeuWGpmdxJyE6JVtmbjLTN0/Smrnx0r+iXX8UcKzzVx0?=
 =?us-ascii?Q?j8gHbvs7Hgc2gRPnMoHDCS1ZiJFxDmU+5BKo49QCbZMxX5dAlOBMGE6cqX/4?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e519f17f-ae6e-4b00-2018-08dc4e4b3364
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 10:46:47.2252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zbyukNSaIluZyEYo6qxHTCb1eiKTSBUObQ6VS9fL2qrdPGho55dl2cn3Bwi5KRd8kzJ/KleH5e548RG/grYUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8064
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

Some architectures use spl_board_init() in their SoC specific
implementation. Board developers should be able to add board specific
implementation via spl_board_init(). Hence, introduce a spl_soc_init()
method which is called right before spl_board_init() for SoC
specific implementation.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 common/spl/Kconfig | 7 +++++++
 common/spl/spl.c   | 3 +++
 include/spl.h      | 8 ++++++++
 3 files changed, 18 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 6405374bcc..9b5cc8daa7 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -272,6 +272,13 @@ config SPL_TEXT_BASE
 	help
 	  The address in memory that SPL will be running from.
 
+config SPL_SOC_INIT
+	bool "Call arch-specific initialization in SPL"
+	help
+	  If this option is enabled, U-Boot will call the function
+	  spl_soc_init() from board_init_r(). This function should be
+	  provided by the architecture.
+
 config SPL_BOARD_INIT
 	bool "Call board-specific initialization in SPL"
 	help
diff --git a/common/spl/spl.c b/common/spl/spl.c
index b65c439e7a..9b83c85df5 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -711,6 +711,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		}
 	}
 
+	if (CONFIG_IS_ENABLED(SOC_INIT))
+		spl_soc_init();
+
 	if (CONFIG_IS_ENABLED(BOARD_INIT))
 		spl_board_init();
 
diff --git a/include/spl.h b/include/spl.h
index 043875f10f..5dfdf778d2 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -816,6 +816,14 @@ int spl_early_init(void);
  */
 int spl_init(void);
 
+/*
+ * spl_soc_init() - Do architecture-specific init in SPL
+ *
+ * If SPL_SOC_INIT is enabled, this is called from board_init_r() before
+ * jumping to the next phase.
+ */
+void spl_soc_init(void);
+
 /*
  * spl_board_init() - Do board-specific init in SPL
  *
-- 
2.30.2

