Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750CECD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A61A784A1C;
	Tue, 23 Jun 2026 08:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="UUClZ/Ed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42EB8849E0; Tue, 23 Jun 2026 04:03:15 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21800849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 04:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iN9n7uIlb6TCTkxIyQEFA6RNHxVQ1VmtfJqeLybmNoL6rXFyxAqZp+H4RpFJD03R7m9yVfmP/GFSltI89L5m2WjUYvFwZRqgOxcOwvJzlCbVYt1i4tRheiWoABaXcsVPJYACsmD7foh874m+tf69aI2mBhDjzw/1FOJPzXTMKRLvbFvF8+i/xHgLzTLRWESPVua1ZI3z9qIsDqs1RQMIGKZhQ9FnXgVxW34wtetcH61PY43p+ioXlBhG4p2QLwB7yAxgODZbnhVRUCBSzlUtzcY/QEdN44ThFC4b7EIHFQpjPuB9vYinZ/k917gIf1r6GX9t/42XkBjBN2lbNMyjLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4DPKsiCCcN5eiUY+Qr6qPPTBeYi/03SetCsQM4Zm1k=;
 b=yrYwa09NDznlJmvaqQRjPFh1VEBxZ5TV7tRzU74GS7khOL4yJOhev09lTSnEjEyynUUhd8nBguCrC36qNYWpHs+DYVb/FZiAhlzfO6T1v8AB9SuGv9PEN+eWTsk8lcZC02XmYRQRedA2vk4lTMc3d57hJufESlLaT8MuXrb/2lucCWq0tjyahqfTaMfcDQdp8hKnIq8oKfQJGsDtvNdSa0DMnuX3fOHQ44d1wVS262T2AcvTNB2+gXMIgXXlRedK8jMO2gcCtN5wSzWg0Ak5H9pkOSw/5turlgGUxgqkfW5oqhLdegXfx0SY+EQYyrreK/LPST2rIC14kkLkkR8CDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4DPKsiCCcN5eiUY+Qr6qPPTBeYi/03SetCsQM4Zm1k=;
 b=UUClZ/EdbSdUZbkoVFYB8V0LOq0SFRovqz291IFw5cW5uA8PrxcUXCVzKxPiTwA/XGKojf7z8nXlEeG4QZ0ugPrS72Wcp/9iR+JwASNVrxmfA0I4CPT0JVg575NGSycpecfZqT/n94l86ouZgy0cMbvrbfmNrfm963B1rolquee23/kaaXY8IeSSAj5VqpLqZ6GF1vBCX3m8hu1psz/xUvWnypL5qleej3C9584IGJIzfeKy+3lYiWU+1G736yDlLI23uZOhmV6GFL1jBVcODqcXEJmE+z7FUzH/ypH3+A6+sel9PyqsZbBhSlw/O3SnCUROl06vXfOktyYFecYJTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by CH4PR03MB7627.namprd03.prod.outlook.com (2603:10b6:610:241::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 02:03:10 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:03:10 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v4 7/7] arm: socfpga: n5x: update SPL data save and restore
 implementation
Date: Tue, 23 Jun 2026 10:02:21 +0800
Message-ID: <20260623020221.32362-8-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260623020221.32362-1-chen.huei.lok@altera.com>
References: <20260623020221.32362-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|CH4PR03MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: f3874803-b8dc-453c-0572-08ded0cb9339
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: GPXKi4fYX9QZECRXe5iXG6+ssY4DeHWMSBiHlqjNBy7LymfN/lFj+Kt91QpLIt3ZsAw6rQGGBXyCeCq2TLpVXmc+x8Cs1anY0NCXKF9HsTyTAENqve2rulvxvhxVc/OkLZzUxmXDfFk2skE88CNFkvzIjV1Y6q+3Q7IAp0kMM1t4+KnRsOXFwWYefxq1/y8c3ULI4OKxT11kNWtZi5WYVRjFcRs3onwt1yqCiGJAOjg3AqSGzavUn5iakrzlloaf7NeAf4d9mnClsYfzKXORVs0etMeSdhMH4TnKbYnR2AJxF1SOuhNG4PQCV11x9RHoTT6CsdqbFG3ulEgTsCBvfX5pgsTb6YKEtNLymuOeLfESbF3TjC+cixylmNQGN8sGzgfOHiBjGG9JqDxQjzkrpgUXDCR3Drv5DhGAHjO9TXDaAV62fpTbWwPzwVTBAT1qxvZBhxeGThaXYEmTxgT5Jjtkn2ouEKMgKpPQsL92HkHxFCBRvfTBFQe1jfOYhMofpwY5RVFpVqMADeGNf+8jDePbkOnZy/iI7aFi0iRCMk8VyuLJLWg+FhrIHKiSr8iSsVkk6Mj/OABy9R775y2gigSSThrSNmvMRfC46pyILmG+I2Zk88ImBhzN/mPpHVP6WKE+Ae6zI7Cge4NHHpHywlfxXwgnPadn5OS6JnKl3LI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8CXeQQhCkVVwvuBbU595eWurdNhMeaGYgXLaM74WYYqIAHa7KKEl4TIvU+75?=
 =?us-ascii?Q?w8dmRwF07Phc1le+l+rGPBwTmmITybUwC5qTwo43MeuWkUdu8I29COrirkIg?=
 =?us-ascii?Q?hU4YN6TE3tpkELetxZ8vEE/p8SQOscx/R5ujkWhfRah3Fd7J4o7pWTj3TACT?=
 =?us-ascii?Q?eML+ruTjrAKA4jDADIBoNNbwy8B5sWPMhkJsMxSewx6YrKv0nPZy7oo/XQx+?=
 =?us-ascii?Q?9IV7m+oEl5/fPpAx4fYjqpo+KQzr1ynUlnnQe5hcyiWNr/LkxDyRSFamCRyI?=
 =?us-ascii?Q?pj5LJkSBE/psgRHyBjUK/O8zJcE6v8IH97kkEHnmmUSZuv6YJiYC/bwut5aO?=
 =?us-ascii?Q?1xRt7fZ71VRtAhBKx/9WZpoTveyM2vPB4vV/Fb1EKXeXwPWUvGxpObHF+o5D?=
 =?us-ascii?Q?DewgSMh9qsB1H89PP8O4X8TIpMGsXKTK0szYiMIO0XaX6jEeX3L/ym8me+yd?=
 =?us-ascii?Q?m93K0ng6O0nTqZiilad6UZYl6paU0gfHzr8ge3X2zqXGeP+KPB0N0J3r9xrs?=
 =?us-ascii?Q?e9OM/X3q9JSGY5WivNMpQga4jViEcow4+hJnyNvWqoLFvDwQlBz6BjYXEK8y?=
 =?us-ascii?Q?SpY1d7bBHM0lZwhhBH0CtxXQgQmCHJFCWgpYNb0rldmvnHBF8/gaWkzEmro6?=
 =?us-ascii?Q?09aDebCngU3J/JAw5x0TYVtIlQVJ+XiIZATwDKjSGtULm6FUzuAFnxCc85QW?=
 =?us-ascii?Q?wA8U4SRcC7EfoTe8zkzrD3SgqFnZPLqJQuhl0o7UancXgZtT51qI/tBdmHk8?=
 =?us-ascii?Q?StG3LpaFqD8jEh69zIGotIqSt2nNfW9DLIninweKzJ1YQV8jFUeNb9+uk3PO?=
 =?us-ascii?Q?C9O59ceNyv+rw1UMbk8MR8ZSPn1+QcHtzzo5j17pg7xgI3VrU4U02ie23GQO?=
 =?us-ascii?Q?IqWvawD7CqyqDXeqnnUmxmv62kHnzRC2oGwf77TvHohHfQMOcztlMaQz12tS?=
 =?us-ascii?Q?gi1eMCyBK9fR13Dh5s+tSX5GjXzu1E3DlMxxdBIE3EDP+EzWRiShD1OA34LE?=
 =?us-ascii?Q?J00dTpQChkIfyPfyWjOGRsl4/vqS0jiPDCewwe75klVu8KtDM9oQjnNAPMiC?=
 =?us-ascii?Q?udNXKkM+8M62JJmLaAS/yQqCNCBqzFbdAwYsJIn2bloAMFUBy2POIHsUZ4sT?=
 =?us-ascii?Q?bZSbU5tBVfRSIMmq0NDVkn2RGd+2mTe3CqEWdM1Fcz3mRi+KKJU1Gxkbrkbh?=
 =?us-ascii?Q?tjwZcoTR7rn2oFZ7hIfm+QAfQESmrlBspJFjUpV6aq7WKpwD58Na/aUkU9P3?=
 =?us-ascii?Q?+tnqHE2S/cZXC+l9yytmMID8Wn+1CNIKBKOYlRnjRnnwCjA28H6cUyy30Crr?=
 =?us-ascii?Q?RYXX2cztnWOvpM1LvuNRiOI81EL6fhlTxJ0qnVIxd/+XDPbBQvEMmdV1tR3t?=
 =?us-ascii?Q?BhcHlhehbE8dFC6SPV4vgymoFAj8o4A69z3ZBMI+GWNuf8VS1tr7GOQEg7iW?=
 =?us-ascii?Q?sBdQ7lLrlPSuFsloEUk8eZk+KtYSW78mmAKGYgyh+MbjVSDnk6cEiHeM4kJD?=
 =?us-ascii?Q?vvqC5a1yUzMJDD4xiwGDJ6QLvaTubWBcx2blhAG6OjP3L7InnLCqVWjwamGz?=
 =?us-ascii?Q?41LtFirER+cN6CN4GbnywhaNifT70GZsMuDMVJeUPVdyIEywbcviSsuF2Us0?=
 =?us-ascii?Q?kedhtCTWzVuowb/n6JSTiOC+Md+f9SzDTDZrTicmFucL/J/3JdyeWj1v7wih?=
 =?us-ascii?Q?8nRw6DwQziGlcZD5z7DbCCXpFh4fznAyTRoRx479R1M7aeAoru292lj1vEVa?=
 =?us-ascii?Q?GFMwIPu1G1fFzt6vlPwWirrOvIzebtk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3874803-b8dc-453c-0572-08ded0cb9339
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:03:10.3845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdqR2Jq5GpcZS22rQK5By5/rWnCvyBFXnnCm+AR9EEY/Wee/kkHcfc87SX6r7n8jOwOk/FwBXpxwDapBt53T5aY9Oa9r4IEX17mqAkjckkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7627
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:46 +0200
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

Enable backup for data section to support warm reset as no SPL image
would be reloaded in warm reset.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/mach-socfpga/spl_n5x.c | 18 ++++++++++++++++++
 configs/socfpga_n5x_defconfig   |  1 +
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index 0a8dd6d0fee..8b03d047f33 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -18,11 +18,29 @@
 #include <spl.h>
 #include <watchdog.h>
 
+u32 reset_flag(u32 flag)
+{
+	/* Check rstmgr.stat for warm reset status */
+	u32 status = readl(SOCFPGA_RSTMGR_ADDRESS);
+
+	/* Check whether any L4 watchdogs or SDM had triggered warm reset */
+	u32 warm_reset_mask = RSTMGR_L4WD_MPU_WARMRESET_MASK;
+
+	if (status & warm_reset_mask)
+		return 0;
+
+	return 1;
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
 	struct udevice *dev;
 
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_RECOVER_DATA_SECTION)
+	spl_save_restore_data();
+#endif
+
 	ret = spl_early_init();
 	if (ret)
 		hang();
diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index d706366337f..8f4723398df 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -21,6 +21,7 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_n5x"
 CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_SPL_FIT_SIGNATURE=y
-- 
2.43.7

