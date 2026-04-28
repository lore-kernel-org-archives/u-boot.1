Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD57FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:39:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8025A84691;
	Tue, 28 Apr 2026 09:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Vvoqz96X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C33D83BC4; Tue, 28 Apr 2026 08:50:43 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0374583A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 08:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxnZockSZW+XMMlHgcwWm9HZkSSXwMFf3HesSqZOslDRdQyfLs5yvTbcHtQeFeSorJnCwMLLzIPNeP3+RAHJ7dklxIuRDbMFB/y2xZxi+5Kp9p+0ONlKG0wQ7vIYW7GAv1MiL9XgOubg7pXo07AlMbspo/2SMk6/oJzdgd1+c6EZozgcXxH8Y/rHlPPpG0ly7Cs7PBpVq232RmaLReBi7rYEVFK/9ICCVJx5FAqaGuyTtrkLS5IJ2B1Ky3KIbsObcfubSXBQr32VW9bKy1y9hBbFVId3hgUS6IZ/lEbcpfXKbUD4Um1nGGxVGe1/BzZs1YI7wXoF7IV5MlzhoQmk6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JD/rTH99v6Vgo6kyhfqldLEwDqQeL/yXyijmLumggi0=;
 b=Ewe8/G0N80wssBDCHIVQ1adbk+MRtJdCnKtTdQvQXr25lSfzLtcjyCMDWNL4NY0jh3MrvV5qyluVZ4aJ9rkE+Eb0FoN1Ybd6ObUyqPHwOzPAi6qkkhBl4ts7ugxqeFNdJ8mN4MOAAgJLKrgN3JTezJfy2s9vDNoVJ8wrs9VfX0P0sJ7JVS0lmDXrOqRYDlYJ/pY4lXVk/OQkmBxLR0D8pMFDU/cNExBxCmeQmNRDjj4PavdiLVOnr0MK+eo4n5UgriW1ntZoSVPC1ilXq4GtLrUhNEjuqSBToSRT7hNN291hLTguwbqef0BLaYDO9Pcipif3EBM1z2NRjDAI/6YqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD/rTH99v6Vgo6kyhfqldLEwDqQeL/yXyijmLumggi0=;
 b=Vvoqz96Xj71nHnsF4DDySVZUTg0nCDdHa72tcoybJ7lXEixNbo6ymOPNItRrNARvcZa2Akp6vFE2oeQ48WzLNmQeXrQaudkaJD4sw1hVazRdbphatwTkFNcv449sy4XUl0Ch+ZW6zXC+8C9B71I++tvV/0fzBnJlJC+dA/RqcMHZOzFs6T1vUoshnUIfe4TCnAzn0Gy4Z47UOAu8Iebs9iS+D3U1TkfzkVk2vj01dy02DOXVOgp8tC1clB86HA89rOzgeMEPNZpcK+Jwq4+IaSqUvbujt+j9pIHuj8oi9AvazSZ+kvEuW8FAnHkwSrgGIeoMyYdMJkmmWbL5EroNdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BL4PR03MB8038.namprd03.prod.outlook.com (2603:10b6:208:58d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 06:50:38 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 06:50:38 +0000
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
Subject: [PATCH v2 8/8] arm: socfpga: n5x: update SPL data save and restore
 implementation
Date: Tue, 28 Apr 2026 14:49:52 +0800
Message-ID: <20260428064952.3965-9-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428064952.3965-1-chen.huei.lok@altera.com>
References: <20260428064952.3965-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|BL4PR03MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: e88109c9-fbb4-4f94-e5bf-08dea4f274d9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: dzggNhzyTUpcT+uVcBGT0eBVTrPzcIk2CsGOWKPqRzgUy3wYkdZj14FezB+3RGzrZilujbSx1Xm2m9h/0YTyCpb4quTJItxfkmfwmW9L4XukARbh8dqxUoO9ZesmQY56riN/BFDvKXtHEOMnCjgXRLnpQHGYxZLbYlXeIOkK/SVCAT6gMNzAEgsN05IfOn19aQr5fvzeFCuCG5sEqaKHcZ/8cV3bDKYrQK/aBJ84LDeT7aU3h1HzYhl3rS9l0vTfJ5Gta1j6ydpBcBzd1adFKHGpVCf4Qi35Kbqx7WmSHdAdJcjMrGu+iTP4ljUbTVd//KijASMe81MJ51+sxeMjh0WwRbUmjtVq0DQt64tWK/6EvLLGCk5dCqDEy6lEgpNjAKp6Clf2btzoDGM+unqLssw/GHJ8hE+Bw5wdLLEytBAkt09fAReeB+e/7qcaSJS1Lx2VenjHAj4RK07zW2url2c2enqPdPe/YoWOvzx9TPDkG5vixQuiZO2dkBbvV3Jn8mP5Kdc17pYBVq6SpGYRLdtYJoEVcmC1hUBxG450lnF9mhg5km82k10iJH9kCXCq2wrrv2HXnSrAbw4J4+Sq2pYPxtNz6sntJbfPd9+rFaeGlFhwOmiNTkXPMK2WR1C0UfXzkR56YFQ9wLHoNEKvgOCLVUVpHqn+ypAoCcDE7ZOjm3ns3LQ2m9PGQtnXxBPdkJk7Y7XmnGNQYx81kQS8ozGQ14UNc/fqVRbEDT3WgMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z/iT6islcSFz6IZxogiXbwRrz+enxgHuo08SY4Kd6txU7vHZewMiUB1sKPBE?=
 =?us-ascii?Q?8qJr3zWzHxz2sx/5/VLMvHEejBs6sGiX3V9haP0L7Nv7qEg9f+FykrGE6G0R?=
 =?us-ascii?Q?Ph57bWjzdOF+LIkkgnaxBMloIWw3er6WqcE1Aur8bIRLFTnCK+wf34eeZe7L?=
 =?us-ascii?Q?OQbCgGmnpzNrklUQCqmaZlrdx+YF/iWrK/YPM92eYumJx2JTkKgtAQOx2Mde?=
 =?us-ascii?Q?PX+js8/B1BMOrT9RMFXHeyREl6Rg86/7Z2VA1rht4/KkaMna+lV/YLwQZ/WX?=
 =?us-ascii?Q?vZe1YIXyiqWgKXawY7vIDtdru/6ZcNy+xvcrUxUBWgTkM5umfZLS27I7IKS/?=
 =?us-ascii?Q?2F1MkWtPPihVTvkAgMl+b8plFZXNLZ/FWhGb3NpP8TzSWevn46HwYH3A79lx?=
 =?us-ascii?Q?uSCzNbZVvCbAuzRQMP9JD5dckx5ylDCVHrkg2TJin1cgLBb+aOgmoTuD6hJn?=
 =?us-ascii?Q?YDuF0u5olD1rbLK7UAo80Dks1YAfolvmkztOvNjI2VGMpZekV+qqqVOReLPb?=
 =?us-ascii?Q?6Jh1+t+vzxYEKNlkwQ+QirNUpkqe2t32tJV662b1ncBMBZQhU7U4ydTVV7Hh?=
 =?us-ascii?Q?6bd8/DMV/6/IPBbrr2+al/meC8XfR3Nm/nveVHuPBN8JlxFjHtfpeTo2jWzd?=
 =?us-ascii?Q?6H5RDGFnVWOJUNoM9ftWvBAI0qrX0jNc2YXrgJWYpKGlsyLWjYxxbOvDqBIK?=
 =?us-ascii?Q?bkKMyK+5Sbl4Dh+LzVSfsBcK54sVRvkyu8nLHsIoPSRxBN6aPbAw68GA5Sm1?=
 =?us-ascii?Q?O/SQTAxjTeP3xip5n7DTNJFeCWqRfSzVVNr2cKKFNou9YwFycB7iI8p2HIQJ?=
 =?us-ascii?Q?ULG7GD2SZK/munQwxeUgBZc0JRucC1eQTG/D2CZAyijXCkyqNGSazOEWYVGe?=
 =?us-ascii?Q?qyltb3Q020Nd5j240ECIi9nbWOEdFDbBPA4c/eXNHtzbCIAOUTnmqkRvgSo7?=
 =?us-ascii?Q?RUXM5PCcDOADsafxP27QxD7COmxQF35hNt0tdqepcL1MNnCDF0boIJId2G8E?=
 =?us-ascii?Q?IOtBPYufqxKxF61uWrtyfcnnIc6YR7HTw8i6Lg4pRnbX+X2vg1+h+IUh3nw9?=
 =?us-ascii?Q?ULtTI4CkeFjR3b/5iRMXy3A4KMBeBCOHRpbgHsNZ6VAU+HXTHA7aktYw3ERg?=
 =?us-ascii?Q?LxTLNvazdS4547GO9jquRJrckx6CwlAfw+bWJlA5b5aZaadw4tyI7pIKUb+G?=
 =?us-ascii?Q?QLkrBsPeK021yRiMnXaHO7xVMxub2XGaOrzZbXjrKbt9iRDbtSCWfPqmjYuS?=
 =?us-ascii?Q?eTKOUWgQWHqsy7jgxygSmDuCURbx2mv9V5G7Imqe60wt4cXs68rpv/PwS78p?=
 =?us-ascii?Q?sInjG8j7ZkOqKgF+GG531/kACs/rDAZ+77PF0F305mXPSBQLs+FPyZ7y8ghL?=
 =?us-ascii?Q?D8X/8WerXzAlt4aMjvYuo+lZJhTToXPZZlmxwKVVknoI0uZFJ9jl0ZJiDr8M?=
 =?us-ascii?Q?87pfypSumgU1qTaA0W+d0AoNAkZA0+h4T3G7Zxe9e0lbyLRc3A0ZWLqGyzMH?=
 =?us-ascii?Q?yh4pVRAfFEmr26sIAPCBrPmWJ8RG9Rt1azFADWkmpKnoNzXMe4I1tyB5JZNU?=
 =?us-ascii?Q?QWcjziSw2uVFmSEPWl3SYfCXSW/CHw+raLCseD+MzppMAmvyyqW8Ysv28nSZ?=
 =?us-ascii?Q?fXCnHxxuX6P0YiJ7E6x9Fba2e7T7Cde+k98b42D4r1sDAdQtQz8F0wWqOA3G?=
 =?us-ascii?Q?6dLks01lBTD0jHK8iLFJjvZOwYfMudTRM6gUkmNbf3ELd3fuRvhbv7eRXojn?=
 =?us-ascii?Q?BJDwLg+FJzOSmhqzth4hkKQmkxvMlks=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88109c9-fbb4-4f94-e5bf-08dea4f274d9
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:50:38.6177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXsI0mQy33qfR+wJhEifcfxfOGiH8ypjHWwO9ArMmwiLi5LXdDEsNX932NhXn8Y84BhqI9eO1a+qN2OFhR4lBP6YN9Kd2Tcf5S8AUSPJ/WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8038
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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
Made-with: Cursor
---
 arch/arm/mach-socfpga/spl_n5x.c | 18 ++++++++++++++++++
 configs/socfpga_n5x_defconfig   |  1 +
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index f776d0c0327..8933811a7ec 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -19,11 +19,29 @@
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
index 8ad6316bce4..27e15a13659 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -22,6 +22,7 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_n5x"
 CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_SPL_FIT_SIGNATURE=y
-- 
2.43.7

