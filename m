Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DBAC87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D393583E2B;
	Mon,  4 Aug 2025 03:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CzUAt/bV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FE0883E60; Mon,  4 Aug 2025 03:25:29 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8624F83DA9
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slQoDWtn3hLA8q8SUTG8HZ1EWO6x8jszKa6Zp5SDqw6soJIGwxvPYosvkeEoH96bObWpDRZYEG/EC5lPtHC6qCYsAKcHTopAiAo1AuRTHoIKX6vDAC1Mx0AeZuN2g52RxyO0aqbNY/4meGbVJNJsV/uiCgBqKmATWQsOUg48gt2GVieSko4Z4Idyr4sFyDc1GN5sG+YA1TYbAZmq9nZKrQU/wBsCbK3Rffq+CpYFisBp3yMZXLr8G3Feb9pWYMDyBJulxJHKY+MAcloBuleE+2/RYDbC4AmXc0C0x8+kn7bIV3ku57iTCROfUmACUR6nzK5KvJo+PHBtEmwpCws8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD2IWZfBvUX+GdnY4yvdpDL9K1Jf37lGrJ7OSVvjKmw=;
 b=k+VseyFNC9fFySGjdG0f7jS9hbOpPCvDsMLJ+iKGF1fw9xHxR4Kl7Z4DMSAg21DmzOjNTjXXLApBQfIegJVCPKjuyB4gNdLvpWHi1d1v25IYn/6Tq2Yy1gx33OKNlh1Vy1VeQJc1TCN/OPwjzOQBfmn93O/pk1/XJyQNkpXPd7DuMPEly2z9qERPBqsybRpMA+ORW6YsgNaBn1UvqYMQnhWmqQ6IXOWzvsv61owicIc0oO4un0ihFuW18TUwiTyK9zG9HPtFE0anfAYyasWYyONauhSoL70LheV0F8C6Mjc9L2Y6fpGC4OLLM+X95rqS5ZttUBAC2wWB0S1UBgrMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD2IWZfBvUX+GdnY4yvdpDL9K1Jf37lGrJ7OSVvjKmw=;
 b=CzUAt/bV4WNtKaGkRcgl4TjMJny1eb9yG/11vZm4D5w4xM9DRPX+stBKfhd6oo0+hlRgj7BdtekF6Lgc2zTDGmy/D8qTjykTcnN5E9DcO38ySxLkgcHFbALTTY98CBDJ78UG0VJdJM6IU3XDHeIwk6VipTx1ZMBi7RrPQjdnLA0j3EMKSs+9JSWlQiAEc0vkiBXZZkXdfF1OcuEg7wMzA9cZC9p9C5X1SOpOKvxv6aw0d++jptePSFUVlfYNJDJvbyHxp1bJ3Hn2NSFMM1rUKJrK5Yk6HIgQiHb8sG+O8rIKl38RHlZlMo6b+QQhYAvJhqCSkT7j7iKpJdGxf0VEdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:25 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:25 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 15/34] include: configs: socfpga: Add environment variables
 for distro boot
Date: Sun,  3 Aug 2025 18:24:42 -0700
Message-Id: <20250804012501.21811-16-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 18aab4dd-db91-4ae1-df87-08ddd2f5c9ae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KqqTiGcZStC5aF7/a61xas3Vo252ry4EAYY2rQ7dkvoqeVTnKD+vQ/p+9V4W?=
 =?us-ascii?Q?o+k77rPgGI+CYiHNVGbDR0JDyhBAu+hr+AsImbFdsEt4Nz57YGbyLzfqGu7S?=
 =?us-ascii?Q?8s1q2aSr8ie0J1n6zB9yi3FogjqzVXh+daguOxJtOvqxI7meZ6RFe6mj9C1t?=
 =?us-ascii?Q?fkW14MW8CmjxLnP8Ym4/AsOQ4q5nCJEgEcJq2lg+9QDl+Nx38eImvCaMCWk7?=
 =?us-ascii?Q?Ty6xjr+5EbO51c1Lz/CVn0caWlsz8SC0dKyrDk+EGtbPf7+PU3tgOO4PoDNm?=
 =?us-ascii?Q?xsgqdE6nC9ARLruwg+w1nv7m3vUlesLMsescfpba0vIFxxRDy5VWdpy9Upla?=
 =?us-ascii?Q?ETvo03dcZ/tA3Z85eBd+qze2tcXDh8CnV5GI0XVH7DgZ8Jwo63mfmyTae1r8?=
 =?us-ascii?Q?07oa46PphZAeJIyuJYfjLvlCKjGtVGhkdmAOFXVZ243jG9bQ3gEEIoMpwHjt?=
 =?us-ascii?Q?HaQKcx4ljLMwskpYfH7N1Z8aNnqSvzQ/4whL4qJTpqflBxHg6pmO2pTCsnL6?=
 =?us-ascii?Q?TZ0089P9a3hAzjz8Uz0aHsp2eBUEX4re2IymIlwldNblZRNXQ71E51cErcBe?=
 =?us-ascii?Q?6G6XSfHz95g6zL+ubXazv1sqlO8BFEn3EHERzK8pZy9U709zql1JrLCiNpee?=
 =?us-ascii?Q?9kcJIrh71LVXZmthUABpvKtHoWnShtRRpvzDWYJYnRFq5oTpqwkaHOYpXT8z?=
 =?us-ascii?Q?rP+JXpkI45oFrBCZdzYMiFkhbAya+VrmBlRKVn5bux2kfOjN3lesjwSYr0q9?=
 =?us-ascii?Q?VCoi4cFPyrD1i3sdPtYwDnHjEV5Tm7oF5JOAx43BLtrJCjo4Yie+x2QwygkC?=
 =?us-ascii?Q?tH+RqEIlZuF9m7eVMc2hbr3wJUOKg5mQEHiGF/falxj84VHRgp2WQXkDmEI9?=
 =?us-ascii?Q?REKvdreF5Fug/08eJ0+VCcLV7NNq4DG5zh4zv6DuQtI4THq9ZWU2i6jOk9Ck?=
 =?us-ascii?Q?jqPsD3p2AvXoajkH9ecjc1mHZhPjoKdf0kf2sihkDG2UThCeK7nEcUzdhPSF?=
 =?us-ascii?Q?PQ1rlQ1V1fao8oIxzViMuyxCtcsAaEyhnntQbMPLmEkivEQdCLn2YGU2j7pS?=
 =?us-ascii?Q?ClvZ+qHqOyl4dwzmNl0AAxfJ79xfr4VKH1/EpsHpj+HGeONcTWUV5UnK680y?=
 =?us-ascii?Q?W7Ywd0bE3rjpP4dVdHu3oxdx1/fJd+9KR9watPey+hXgHdpMIELAD7yloJCc?=
 =?us-ascii?Q?maXhMzXi6d50L36XWIPH0udoyzOfXn1ip1zypz7Lu9ieJXX+8umQO6CG4zsq?=
 =?us-ascii?Q?raZbXsylfxU4OJd0fSaVos6BrGLafPecwicAQSgTpqgjHSoi/MaWIfRIlu6j?=
 =?us-ascii?Q?ZdYRY8UsikiSD5b81LRozUWh7VQIu4JqgqeZt/DVU+0Cfsv57qAG95rmhWUa?=
 =?us-ascii?Q?B3T/TKSoWbeF6I7PeOjbx3EmXql7R40oXuOxpISbqOm62ygRBwBNOy8slhVW?=
 =?us-ascii?Q?tajFbdT+jPA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hXIN98cyXKPeTwMEfMoqRpbUZppvazVM5OB60mX9+VhEUfJh3MriVTOFsQKT?=
 =?us-ascii?Q?KBxkUdq/zwVqxQkj0TZnWtAxJst4SbKNNg1SHJw923iuTX3ybmhN2LeBF4gm?=
 =?us-ascii?Q?YLlwkzOebd8Gh+l/WoOYaB7o0AGyNyAYOFHaSmaRz3/syJQUbbjYJTOiBJX4?=
 =?us-ascii?Q?MQ0rS1zfEKlDXldVi6agcRiIUTQeFnvXStpUIvo96HSDxdVgM5yV0a0glDmI?=
 =?us-ascii?Q?MDotjlXl2/HynAGGFM9W6N5F2pPxGf7HhjpTwNinOSUJ8Dbog46CB6FHUfGl?=
 =?us-ascii?Q?9M5VqWreUXhKHrrRfOoZdeuYa3Z2Q57Xv44oP8Ql91mWerlXoQDKXTUhGdS2?=
 =?us-ascii?Q?mTef39EatVKwgcH84WAKYmP4z73/+eJ6DZWn3S1P0orQPf/8S7+XuCwlV+fW?=
 =?us-ascii?Q?hunQi5s/80pFYwV/F89RBRfas7RBNL2CFaEaK1pnXvXbOMqaqAxCzzIh0Q34?=
 =?us-ascii?Q?Ql1o++gvsIzGKpYDgkKQf79ab8UBEK+/Q88U8N2affouex6d/vsFmbdq6Wdn?=
 =?us-ascii?Q?p4nRPfrHcwA8x7s0ibgCF5Q4V0tg8zZpXYUczXfQBwhpv2NpV5Bys5VGUQeL?=
 =?us-ascii?Q?gufSNCgiRvWiNRx5wmCiw9QWQVqIJQlRPTImfu5IT6b2/T6nevOG52XPLgNA?=
 =?us-ascii?Q?b0BU8Jv8O8O1iYEZmfzUVHvtdlzTy2RItDWpxdOVJAD95psi6CUll//lZ/EK?=
 =?us-ascii?Q?w8iyuKMcLnOQ0KZP4jVlVTnzcwMCZ9MWkgHqmJaCp/JR+FIQ7Majj65OF+NG?=
 =?us-ascii?Q?VoPIuaDORgdYdb1VJxr9u6dnaBB5XpgNOKClhtT0OdBfhnVio8M6mK0e4mZ8?=
 =?us-ascii?Q?YtE+NiEIKGfcizq4rrBKTRC6Q9l4IKKnF/UGdFHUOv9OIxsBPjehZUBOUzRC?=
 =?us-ascii?Q?A5jc2tdP6FiWCXJYH42OzmKdYMjNvWmenZYntlJ6Rh+RcbsIjAiZhM2lmt0W?=
 =?us-ascii?Q?9miBbNQr6hZm2Tofm8TUSs8ycxZ5TDIU9PGTptRy0iS9I7qVghSgcDzk7AQx?=
 =?us-ascii?Q?Q5AfXe01m7UvmvZfaB2vTyqbmmdQsspEr8h+SQr4mFeLWyNQ8Hm0xLTILh7b?=
 =?us-ascii?Q?C7ceX5H69PFiY6Hvc/+aS7JxeFerhF5duaOPvAHc0vmjaV9XjUlJ7tEvNbAz?=
 =?us-ascii?Q?aegQQMUvyCZx2zJx+Sy3nX8luxrl8WdiOgjT+pZrsuvggfdDdqCdIuN289aL?=
 =?us-ascii?Q?I/GrBJovxNrpGiyEXZEQysmvkaod7T1wzVhfVhFarPQKQ126CaeN65Dia8hX?=
 =?us-ascii?Q?nY/Hs1KUi27nI5k/RYBA1ZgfhL/VygiWl7p5Pe8WmG6VZcxyuO193A1BdWUe?=
 =?us-ascii?Q?STmfRqA+/4hvEm+Ecjs0AW0yFgMqFSze4W/RrNoCnfM/VHTfhoQGFUgM+W0f?=
 =?us-ascii?Q?mrApDEN46C7vYxiloGhhS/XWUZsHDsA9Lhbdi5iaM4GtjkEQSlRteBSax1Aj?=
 =?us-ascii?Q?zWa8ajyORG5HIhXEnj37gpdIHZAbdWnHN0CLscdLBjD79zo7b/0v85vM4KCo?=
 =?us-ascii?Q?3rxouYTelxB/hgVbuvjYEoKvvRO/vQg0HYVpOwj+Gf3A+Mr0HnsANPE2fEtP?=
 =?us-ascii?Q?DkJxgSFq50qNJCgvekmdtKt7lluzk0YnEgUVQb9OmX8k52G4hzDS9jjoJcq6?=
 =?us-ascii?Q?MZXyP/VWMklsgjwtE5FQ8tE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18aab4dd-db91-4ae1-df87-08ddd2f5c9ae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:25.0761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uku8VK59nBsqHazfBuGPRhClqR2ywzfWALBW4DyeguhvKwRwxu92AdG53H2iUvCE8owXl1E3rMhbhYQ/qO8lG7TKofwGqZaHw8VeL1tckoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

Added environment variables needed to support NAND distro boot

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 include/configs/socfpga_soc64_common.h | 32 +++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
index 5ed17671f79..f21c9001297 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -39,6 +39,9 @@
  * U-Boot environment configurations
  */
 
+#define CFG_SYS_NAND_U_BOOT_SIZE	(1 * 1024 * 1024)
+#define CFG_SYS_NAND_U_BOOT_DST	CONFIG_TEXT_BASE
+
 /*
  * Environment variable
  */
@@ -73,9 +76,31 @@
 #define BOOTENV_DEV_NAME_QSPI(devtypeu, devtypel, instance) \
 	"qspi "
 
+#if IS_ENABLED(CONFIG_CMD_NAND)
+# define BOOT_TARGET_DEVICES_NAND(func)	func(NAND, nand, na)
+#else
+# define BOOT_TARGET_DEVICES_NAND(func)
+#endif
+
+#define BOOTENV_DEV_NAND(devtypeu, devtypel, instance) \
+	"bootcmd_nand=ubi detach && " \
+	"setenv mtdids 'nor0=nor0,nand0=nand.0' && " \
+	"setenv mtdparts 'mtdparts=nor0:66m(qspi_uboot),190m(qspi_root);" \
+	"nand.0:2m(u-boot),500m(root)' && " \
+	"env select UBI; saveenv && " \
+	"ubi part root && " \
+	"ubi readvol ${scriptaddr} script && " \
+	"echo NAND: Trying to boot script at ${scriptaddr} && " \
+	"source ${scriptaddr}; " \
+	"echo NAND: SCRIPT FAILED: continuing...; ubi detach;\0"
+
+#define BOOTENV_DEV_NAME_NAND(devtypeu, devtypel, instance) \
+	"nand "
+
 #define BOOT_TARGET_DEVICES(func) \
 	BOOT_TARGET_DEVICES_MMC(func) \
-	BOOT_TARGET_DEVICES_QSPI(func)
+	BOOT_TARGET_DEVICES_QSPI(func) \
+	BOOT_TARGET_DEVICES_NAND(func)
 
 #include <config_distro_bootcmd.h>
 
@@ -137,6 +162,7 @@
 		" ${qspi_clock}; echo QSPI clock frequency updated; fi; fi\0" \
 	"scriptaddr=0x05FF0000\0" \
 	"scriptfile=boot.scr\0" \
+	"nandroot=ubi0:rootfs\0" \
 	"socfpga_legacy_reset_compat=1\0" \
 	"smc_fid_rd=0xC2000007\0" \
 	"smc_fid_wr=0xC2000008\0" \
@@ -192,6 +218,10 @@
 	"scriptfile=u-boot.scr\0" \
 	"fatscript=if fatload mmc 0:1 ${scriptaddr} ${scriptfile};" \
 		   "then source ${scriptaddr}:script; fi\0" \
+	"nandfitboot=setenv bootargs " CONFIG_BOOTARGS \
+			" root=${nandroot} rw rootwait rootfstype=ubifs ubi.mtd=1; " \
+			"bootm ${loadaddr}\0" \
+	"nandfitload=ubi part root; ubi readvol ${loadaddr} kernel\0" \
 	"socfpga_legacy_reset_compat=1\0" \
 	"smc_fid_rd=0xC2000007\0" \
 	"smc_fid_wr=0xC2000008\0" \
-- 
2.35.3

