Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9EA103E18F
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:44:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7902383DA7;
	Wed, 18 Mar 2026 15:44:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="kQ7Ahk2S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C977B84083; Wed, 18 Mar 2026 11:41:50 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B61C8405B
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 11:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/+YiwvhioIpIkHt79C6tW6EJJp9sOfJm+drcebG4MXCmkmsmZJATjEYSTABLteBSQTn1H3ilhwcpw5CEbb1Q/PIKmdvtNajViWu1lfslyyXkOZAF+3TMJLyQnJ8t2aqJVoXjCnOARrmzfHq5X7cakWMI/hnP0GfPuiwlR/jIo3I+8FK4AHhlmuNSD83WVz01d++Sg3fnTpZrIy/wM8vOM/QZg0H3Tai63ZBPrWq5tEW1bqup9b4I5H6PicwvRYmLl3rixUONGCxk3Sxr8vRQMpyeiBfd8NHomSZfl7M5fAccMp7vSEUbS49abmwOtD9s2SbAh6Xy7EhnDehyyScmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iddaiJ2+Xg7ka0hyl+2E/dCkyzjtylidu9pOMwYyOLc=;
 b=IUUwn1E6nTjAjYekYmeU85p+kr2AAZt/3iunM+tgD5NHwQoJV+2u8Zs524eQXg92svCIZkZUZeH9DjAP28lJks94f+hH8203qqSOxoz+zbl0lYsLtq52RxUk7MS0dXqzJ6Jlwe5xaHWHSX6niv63oZRllORfd6rEQSADQ3tPXIdgXhLyPCBWrGxUNsE2g59Zxn8EiS8oUlnNYUmUD9leL5Kp0727fflx3GWK5vTxPCon6grQaRHBw04P8DeR+J5f+dL9otUJf2/+w9Zlm0eMZ10LgZikWOfEqAFXF7z2Cn3yN/4LaejQOuH1Jw5swzx/sjGB72WaoEID6I1uzDjq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iddaiJ2+Xg7ka0hyl+2E/dCkyzjtylidu9pOMwYyOLc=;
 b=kQ7Ahk2SuX0k3VxQeuQr19eGGGqbRCtJiBMrnCwejegLQ437kL1DArGrhUgrXdOs4BPPowt/8NP2VofgrqbEfCt3dyf5XjRvfjV2n1yeqHVJlekWBNEVCTTKvt+R5MGZL64vGhgjvz20uw6l9psR5twAh3nhQEDk6Je/OstdK0mtqkdfh9DJYCCidZybZL/vN/XEBFlr29IJHV+blia5I4PRu5jUFI+ibll3yzVyqX8XQapU/HIhUHpeN/IavOx2s/qhWT9NfiFf6UEhqMUGBccokEa8b2Cu9opVUsnstlvbbVA1qvgIIoz83/fUrZwCi9NqYOqP2Lj+2zNn7TAVaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by MN2PR03MB5341.namprd03.prod.outlook.com (2603:10b6:208:19f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 10:41:42 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 10:41:43 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>, Brian Sune <briansune@gmail.com>,
 Chin-Liang See <clsee@altera.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] configs: socfpga: Add QSPI support for Cyclone 5
Date: Wed, 18 Mar 2026 18:40:18 +0800
Message-ID: <20260318104018.2261-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:a03:54::21) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|MN2PR03MB5341:EE_
X-MS-Office365-Filtering-Correlation-Id: d213d4e4-ef08-48b7-b382-08de84daf1bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|55112099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: OOEK2yEx40PJ8lExQqMJuOkyLMEN6Hf5b6/njNaw8DuYV52dpMaE6qP9rXAcJtZEn1RDZjdfW8jkRvBK3ppk4OfsEys6WqxB6ZXMBZavvVmJgNq43YJJPfHPkjDaWQhACOBjQp03Qjw1L6ib5Zur/dx00r0nz0Y1/MVehBJXErjpz8nFcou9VV0BONXSreISFAEcSU1Iu0gOQrBIcGuv0dGRd25AZsnpciO8C+4V8DmJGJXukF9vf1RrZefb0MQ8BzcWmduy8EqFlE4Fa7GM8YmzL+vhgJB3FmyijcA1vrOOwkhyQUDdczCMa0cmQvYzMGpXWl1njczYaAgytjJ3ttqf/kw1PY+05OtQMB47mNJMwpz2saeUUpO9oOeXVQAaBOVdKyeTzdaBQRK8MXhqqKdE0M85ndADJEQ7iZkhQrhlyt1RlbJLbFvluzAb5Y5UGuM253wc5wrBB8AE2gV52kGGTbi3X3dOxj0dnIG+RdEiARYjKQa4XCiYzQrA25HWoojLxrtkfnqbSpyzDHEwbIoTXTinPlVFpweacv/tYFZ0F9tJfDSmOD1BXMHQ0aD7jmjuOGOGOhKlYv8P3yPRBGF6YuWuKExuVPiRBJV6MQF05a9PeE2Og3AuSe9VIILmEawnu5x424ItIODvw06EUENeN3pxcipqQQVeOmQp4lkHKjQT3hEU25zO0kQ0BgJfwf8ZHSGR73tEc2YufbJQW533R22dscwW19/EFHzabuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I4+xiUiChS6Cdbj/FE0FVQjqMTBpXyYoPj0JY2Q5soPRmAkke5SfHC6OQWM+?=
 =?us-ascii?Q?t+MiA9KJmTHwJZko8rz05UkwMgQeiOZwJs1NE5aUit+gYh51akwd2qVj5Xc4?=
 =?us-ascii?Q?uTpvXA/nL8MHPni5Z0SdHxMBDidOdUH4ou8jfFzRrJyY3YIjxfPE6sKtbpmt?=
 =?us-ascii?Q?IA3UmtCxUhCA7fFWvFYhwNYyyTPYBVS4XmiiFhCBmKDB0UulKnCeYEDO9i83?=
 =?us-ascii?Q?/kJ6EqxGIgkRjTZm+MoKyS0Ve7ftqpNcdHb6NXOFhMriDvsUcwhv4+ggarGf?=
 =?us-ascii?Q?XoyA4u6tYzWw0j4MGBAIesTCbKXrXfpuV1CHbucSJCswtDKiFznjpliCGQI1?=
 =?us-ascii?Q?oU+Y1HY1G685dpQNNj/fuXtPTYRStfh5nqFS3eqS4jpelfvkOFCw4HAse48/?=
 =?us-ascii?Q?Z2zwdBH3AViNmIEyZ+WdVDGw8iJ4AcA6aWDstO8KriFJgaEWjpnHZz74I20y?=
 =?us-ascii?Q?0xd8i+tMq3aV0m42xzTT8E8EvZdGuKhebVSlsgSSu72OCLMPODpm2bwzQFVp?=
 =?us-ascii?Q?1V3WwRtu7n/WwRctKxaUfmYUfltCOLFVpVD4DeFmHKScvh3h/Cr9VsQk3fg+?=
 =?us-ascii?Q?2dg/ICQqv5Sm1boL/2DfkKG+Ns9sE1z2JoSCG7Gq7d3GUYMBfdOX0mYeBrZQ?=
 =?us-ascii?Q?5s5NafS62iZpeA+1oReb5l7S7jg0b44TH7WY+dsOvE2MixOHAoe5ijxSLWkf?=
 =?us-ascii?Q?72Qm0k6gNkrvl8r0tNkSuXF/W5StmFhBc5kHvf5wTFp5FjWk1cmafYf1O1wk?=
 =?us-ascii?Q?RP29eeDTxGydu5toRFNiZn9tzrNRP3gGhtSlbD2hm4tUq7P40q5Bbj0k74hL?=
 =?us-ascii?Q?Zgcbn7ED2otXYMUwTGgMihk26ARh/eXZO3Sy6/zdGj4BswH16G8B+ltfzzIJ?=
 =?us-ascii?Q?k8rmcI13/r051DBE1YECLJ34ytZTe9akBTJyrfquARFulAW4OASl1I680hs/?=
 =?us-ascii?Q?AmZhAplMz8LhzgGos+7UYzzvGmBBtDDSpKPIsG6xDIyHY90mbhTrPlaGlH8a?=
 =?us-ascii?Q?hwaLublxXZV2i7jkaBdl1A7TtupXtQkCIcY7uvAjdZJAn/CxPQTpMG3jQfKI?=
 =?us-ascii?Q?M15XYlzbcZ1WsbXidalaKxVm0lNeHRPXphiWb1VRAGJy4ifgSuUKI8C8vsPK?=
 =?us-ascii?Q?RtEsKTKQvoaZszMEKFpZD6lZGtCfskq1RJXIbBkSIx3+pe9XYNeWBRbEoW0Z?=
 =?us-ascii?Q?uYtOowfAzAJBibNAcbnWRLrcGArDiQQ5ZB94PAPUzmZcs5W5Vf5I9Jy/Lj79?=
 =?us-ascii?Q?bquuYzZJYUzb3VTNHbflunaXK0PspJQ9fA0zerQAn08x8oHuekQomSovJonM?=
 =?us-ascii?Q?9qJM748tY89ACrs3fsFLqRUEET71vrBizqRxhIP1Fzy3AE+HVR4AiDGdSNxC?=
 =?us-ascii?Q?kO1JgjupVIcLI0kbZupfuY+I6/nymZkuao/vt7gxOErBudwBxhHP0DutzPt/?=
 =?us-ascii?Q?W0otdTsfOuXhAid6X00usBNiasXYs4UbPbWw8HzO/XcnWWJNw9lDHTuH6N4G?=
 =?us-ascii?Q?1dgaZZJYjywoyv8NRI9sRmJgygvqHr434V0D87X+4cJx5QsYPwG35jFXhC9m?=
 =?us-ascii?Q?8/ZcUiogVpDpnNiXkBPE++ZTv5N5BVl2jGISJXthwbFBNCxM/eeTf58Whorw?=
 =?us-ascii?Q?Tj3fyZrKeQQjr78KGNO/0E6S+yu6ij/rnUbET7X6LkGplstlctQ3gTPBR7H8?=
 =?us-ascii?Q?CtpibhK9lxZwO/syH4WdKVUi6OPXFpew9gFurf/IjJdNuf+oyJf2xz4niUH1?=
 =?us-ascii?Q?aMBgdZ3YHA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d213d4e4-ef08-48b7-b382-08de84daf1bd
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:41:43.1140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JayPoUwqSnwdyX0zyqDSfQOdxahkjghJB4mHY43WpX3Ic064P6xBrlqTsYWq5OFERYnjpGxQkqK62lM3RSdeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5341
X-Mailman-Approved-At: Wed, 18 Mar 2026 15:44:01 +0100
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

Add QSPI boot support to boot target devices list.
Platform can provide their own boot settings through
OCFPGA_BOOT_SETTINGS macro if needed.

Add SOCFPGA_BOOT_SETTINGS for Cyclone 5.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 include/configs/socfpga_common.h         | 18 ++++++++++++++++++
 include/configs/socfpga_cyclone5_socdk.h | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/configs/socfpga_common.h b/include/configs/socfpga_common.h
index 36d6bfb3d03..5d98d662ea7 100644
--- a/include/configs/socfpga_common.h
+++ b/include/configs/socfpga_common.h
@@ -137,11 +137,28 @@
 #define BOOT_TARGET_DEVICES_MMC(func)
 #endif
 
+#ifdef CONFIG_CMD_SF
+#define BOOT_TARGET_DEVICES_QSPI(func) func(QSPI, qspi, na)
+#else
+#define BOOT_TARGET_DEVICES_QSPI(func)
+#endif
+
+#define BOOTENV_DEV_QSPI(devtypeu, devtypel, instance) \
+	"bootcmd_qspi=run qspiload; run qspiboot\0"
+
+#define BOOTENV_DEV_NAME_QSPI(devtypeu, devtypel, instance) \
+	"qspi "
+
 #define BOOT_TARGET_DEVICES(func) \
 	BOOT_TARGET_DEVICES_MMC(func) \
+	BOOT_TARGET_DEVICES_QSPI(func) \
 	BOOT_TARGET_DEVICES_PXE(func) \
 	BOOT_TARGET_DEVICES_DHCP(func)
 
+#ifndef SOCFPGA_BOOT_SETTINGS
+#define SOCFPGA_BOOT_SETTINGS
+#endif
+
 #include <config_distro_bootcmd.h>
 
 #ifndef CFG_EXTRA_ENV_SETTINGS
@@ -154,6 +171,7 @@
 	"pxefile_addr_r=0x02200000\0" \
 	"ramdisk_addr_r=0x02300000\0" \
 	"socfpga_legacy_reset_compat=1\0" \
+	SOCFPGA_BOOT_SETTINGS \
 	BOOTENV
 
 #endif
diff --git a/include/configs/socfpga_cyclone5_socdk.h b/include/configs/socfpga_cyclone5_socdk.h
index c23ba2325b8..3ebb7b18020 100644
--- a/include/configs/socfpga_cyclone5_socdk.h
+++ b/include/configs/socfpga_cyclone5_socdk.h
@@ -10,6 +10,24 @@
 /* Memory configurations */
 #define PHYS_SDRAM_1_SIZE		0x40000000	/* 1GiB on SoCDK */
 
+/* QSPI boot */
+#define FDT_SIZE		__stringify(0x00010000)
+#define KERNEL_SIZE		__stringify(0x005d0000)
+#define QSPI_FDT_ADDR		__stringify(0x00220000)
+#define QSPI_KERNEL_ADDR	__stringify(0x00230000)
+
+#define SOCFPGA_BOOT_SETTINGS \
+	"fdt_size=" FDT_SIZE "\0" \
+	"kernel_size=" KERNEL_SIZE "\0" \
+	"qspi_fdt_addr=" QSPI_FDT_ADDR "\0" \
+	"qspi_kernel_addr=" QSPI_KERNEL_ADDR "\0" \
+	"qspiboot=setenv bootargs earlycon " \
+		"root=/dev/mtdblock1 rw rootfstype=jffs2; " \
+		"bootz ${kernel_addr_r} - ${fdt_addr_r}\0" \
+	"qspiload=sf probe; " \
+		"sf read ${kernel_addr_r} ${qspi_kernel_addr} ${kernel_size}; " \
+		"sf read ${fdt_addr_r} ${qspi_fdt_addr} ${fdt_size}\0"
+
 /* The rest of the configuration is shared */
 #include <configs/socfpga_common.h>
 
-- 
2.43.7

