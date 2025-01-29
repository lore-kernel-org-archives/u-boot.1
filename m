Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20B5C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 14:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5ECA81F00;
	Wed, 29 Jan 2025 15:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="pzQ+ELZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CA02809D0; Wed, 29 Jan 2025 15:25:57 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20704.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::704])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCE5480A09
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 15:25:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5a5NF4KVf/gcuZshgG7uA4iLKusgmgJiqxzlN6uoCgHoSMGqLDhC4dGFOY3tqqpkGXxqCJYVFf2vXfUATbxSoHiFBPXEyn2ovulXA5EaHjqqXg2jrCduAbQpozijGtx2s48yrcmTFoB6+2NoagmtCjylMMnmThk38SLoRsriPXVNZElq9bndBGuV4Y96kXr5WP5wHw+YJuwd+I374d8zSiWO/TMH5rvUF3zQDbJzSMzs9dkpB4WXWZP9Y43+hu4sgfPFwzupUvLfPVYb37pAGshuz8Z/4IWCNVE0kPNGsrnyfr4c2PMkL7CcPUmyY94rrQHqydQ+DH/RAFsL1iqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1T5ySLuhNpC0lZ2vHivkHX5C/u15WVn+6f//WNbYeE=;
 b=sVHUllA5zkhG/b2W10aJDYMVgLu2liedAuHdIVZMRorfRmP21BkGR24jsbIT4m9d0FjNug0U+6RN3p35l68JgaI0cmwLNMt2pQ9BZEL3LXBr+rwOqeRJ1Gkudc1M5LU5rKL6mDThN/rV81VwByc6gguu5OMYL0N/ZjcM2vm86jfaeyvd8dgO05rCKWONb/rw+F0vlSxYEEh8k7hlpP7JUzXZXh9MMFq8orDEqKzRTKJux1h1c4rtqyrLRojllQLIoooXcdyPZ7qhV8WO6/kCUBnfgiF/fF89ocvLyNzPtiw9bEykZy8cn3+nnCG0ahZSYZrtRd8cak3JZFEU2+WT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1T5ySLuhNpC0lZ2vHivkHX5C/u15WVn+6f//WNbYeE=;
 b=pzQ+ELZ2MAT6tpkBQeZCb6kBNQ04eV9sfr5fh9dv/8wRiK3cURml6DKrwsuCl/oQw4k4sIKp+GD7DjvzxGcSbv6YNZ2h+xbVxTuX/j3Y2bRzOwhRfoTsr2V32ade8jrr86s6Jb2AI6dzW+FDIDOUh73nNFdk5sqm/dA71DpB9pUvKToM8pZvswOp3VnAMpMgwYZ+M12rJkM/luuonopAk2z/GXmY0nDVokYwxo+I9yo2kY+QSY75vzDikdPbGuz7asG+GRrjdu/fwORsAseKH5uMGKcyg1phTSkgDJzmX6p/VO5Ja3M3z7/+tSnHzNJ3HUbLo4ab09EVpCZdOmTKDw==
Received: from DUZPR01CA0348.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::7) by DU0P195MB2048.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:413::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 14:25:49 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::6a) by DUZPR01CA0348.outlook.office365.com
 (2603:10a6:10:4b8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 14:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 14:25:48 +0000
Received: from Diagnostix.phytec.de (172.25.0.14) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 15:25:47 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.14) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 29 Jan 2025 15:25:47 +0100
Received: from lws-schwan.phytec.de ([172.25.32.136])
 by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
 with ESMTP id 2025012915254738-48 ; Wed, 29 Jan 2025 15:25:47 +0100 
From: Martin Schwan <m.schwan@phytec.de>
Date: Wed, 29 Jan 2025 15:25:25 +0100
Subject: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
MIME-Version: 1.0
Message-ID: <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
References: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
In-Reply-To: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August
 17, 2016) at 29.01.2025 15:25:47,
 Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.01.2025 15:25:47, Serialize complete at 29.01.2025 15:25:47
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFD:EE_|DU0P195MB2048:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c9534b-30ef-4ce9-5cef-08dd4070d3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUxXS0hSamhtQzJqZzU3a3ZHNjhhWnh0dHo4WU9JUnAwZnl0azBZaG1JaDl6?=
 =?utf-8?B?M2FNWU4vbis4YW5ZYUNGd0V5ZkZxeWpmRktLRWdDTjR5eElSc0NFbVlsbXcv?=
 =?utf-8?B?c2xEZlJpK1pVbHRJeGR6Q2pNUFRhbktiVnN0ZEJCVGQ4bWZZa0JGS0RqT3Jv?=
 =?utf-8?B?aFFDc29mUUVBemt6K2g2VU94ZjliVDRDV0k0cXFEb3pwR1I0KzFEYXBVQU5z?=
 =?utf-8?B?Smk4MnpWcGo5V3MrRTMzR0Z6Y05wOGdkdVcxdDJQZFg1Rml0VVRYYUp5ZHNT?=
 =?utf-8?B?WHAxTHZRbnRkbHJOU09vSzY1RG1CcEZrSE1YOUV2alpmcmJqa3BncXBCcVlI?=
 =?utf-8?B?U0w2YTVuZGxLMTljTzlrbmtXSGJxVnNSL1daL0wvRUE5RGZTKzE4V20raVFo?=
 =?utf-8?B?TVJXQlpKTURFanV2T2FURW1VeVcrV1M0RXcxVXdJeXZER0VYeEtvZkQ0R2Jx?=
 =?utf-8?B?Z09CNmo4RG9YeFB3TlUveTFoQ2JaMHNHZkRHRU1kdWdNclVJUDdqdiswSHpx?=
 =?utf-8?B?QW9OV0V0QWVocWRjZzZyR2JWaGdCTWk1ZTdQVlVrUlF5SnhJOTFGVE42MVY5?=
 =?utf-8?B?SHdWMExRM3A3cVc3bHNlZ2h6MGJzU2dDWG16V3I0N1NtVEhxT3pMbVF1OTNk?=
 =?utf-8?B?TFQrNnFsWm5oNWozQ2NXc0ppcmVlRzNkMW0rcWMzNnZ3ampIU253N1UvSVNi?=
 =?utf-8?B?MlFaNWR4bzBYSCs2ckdaVWpuSjRvSEo3Z3JoQll4N3BEY2oyRTN2MTB5aDMz?=
 =?utf-8?B?UXlzMFBTUjdRSno4Zjk2MGdrWGlSSXduNU9RdktFWkhhUWUrNWFqME1jMEZL?=
 =?utf-8?B?MVR0c2poSGdMREloZVE2KzRHQUNzSlVPRjJLa1piUkQ4VjkrVTA5WTU5V0lv?=
 =?utf-8?B?TnBPSHM4YjZKa1RUZldQdU5TR1pTeUwzQzhoSjB4eHI2enM3ZlA0NXdxY3Qx?=
 =?utf-8?B?czlNNzY2ckk0YXI5U2gwVHIrd2xabEc0aUdCR1laTlp2SDJNR3JFakZiV1ZO?=
 =?utf-8?B?Wm9PRWxkZ3BJWjdma1dYZy9TdjlpbmhvWTUwbnJ3OS9nRFZDaWhJdHRzZGti?=
 =?utf-8?B?RlRmcCtWT05MNEdNbXYrMi8reG9BRy84SENQVWxCVEljU1g4SWhkaDlZV2xw?=
 =?utf-8?B?OWRmNzZlZ28wb1BKOHI0QXJLUkpHSURad3h6cmxNS201WFFUeFBoNnAzRG43?=
 =?utf-8?B?dmxnU0VFT3N0SHJjWWxJYW1HY1dJWG80LzJaWTNxRU1uZkZmKzdDbjk1K1l1?=
 =?utf-8?B?ZmFvSEpQOEYzT1dPUkp0Q0dSUFNZNEJaZnp2bTNlU3hYSVJRT3gvSjFISkxr?=
 =?utf-8?B?L1pOYWRpK2RwcGt4NzB1V3ZSZmR5S1ZqbmRSZUxFWWxiU1hPc211ZFV3SE5V?=
 =?utf-8?B?NUhZZVp3STlNQnJxV1ZvRkRwWG9pMDhZNWFaaDhNL3FiVGJPNGk1Y1VpQ2Vp?=
 =?utf-8?B?WUVFTjNPaVJaTy9OdnVDZHlzWVZmNUFEakFRTFBERS9YVkxKU0NoV3BpdmFv?=
 =?utf-8?B?T3U2cmlLb01QYzdjVm9nWG5TV3FBMjVHQmZIZ3k0SllsYVlWZ2ZhVEFOMUZK?=
 =?utf-8?B?OUJVRGhRQVhyc1dLSHhqM3IwZUd3YldxSkFpa1B1NWxQVEVUUjZjbFM1N0tq?=
 =?utf-8?B?MnRjNjhXN1QrZ2VFNVpUUzNwWWN3SjBHNDBOekFoSFYrTFFzMGpTZ1B3SnIr?=
 =?utf-8?B?N3g2ZkV1bWFrRGVnOENhL044S3U3V0ZoNGdBeFVieUl0eFVLdUZFaktSek9Z?=
 =?utf-8?B?NGtWaUVXelZMMzkrWTI1SmMwdVNqYm9EVk4yVEpkYXZKR0NXaWxFWVFxT0Q1?=
 =?utf-8?B?elQxMk1pVGszYXB3ckVnN1l2U3NzUU0rdDRzRXpQY05BMklTc21oWi9JRU42?=
 =?utf-8?B?WWRFRWMwelk4Y0podFlSb3N1YmcrWVJWaEl4b2hwWXJNUlowNWlCOGRaV2d0?=
 =?utf-8?B?Rkhtb2NiNGIrZ2hSUkNGOEUxVlI2QUZPbWtwejNWVXRUYWg0WEpjK2RTdkdB?=
 =?utf-8?Q?PBxGogWj3PPEQ5V6K+NvK9FwtGBvDU=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 14:25:48.9925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c9534b-30ef-4ce9-5cef-08dd4070d3d1
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB2048
X-Mailman-Approved-At: Wed, 29 Jan 2025 15:30:27 +0100
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

Add a bootmeth driver which supports booting A/B system with RAUC as
their update client.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 boot/Kconfig         |  11 ++
 boot/Makefile        |   1 +
 boot/bootmeth_rauc.c | 408 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 420 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index 20935a269c60dad53ce11ac7e58247dc23cf617e..966573d8eb7675d36f299c8c2fa6509bac147cae 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -782,6 +782,17 @@ config EXPO
 	  The expo can be presented in graphics form using a vidconsole, or in
 	  text form on a serial console.
 
+config BOOTMETH_RAUC
+	bool "Bootdev support for RAUC A/B systems"
+	default y if BOOTSTD_FULL
+	depends on CMDLINE
+	select BOOTMETH_GLOBAL
+	select HUSH_PARSER
+	help
+	  Enables support for booting RAUC A/B systems from MMC devices. This
+	  makes the bootdevs look for a 'boot.scr.uimg' or 'boot.scr' in the
+	  respective boot partitions, describing how to boot the distro.
+
 config BOOTMETH_SANDBOX
 	def_bool y
 	depends on SANDBOX
diff --git a/boot/Makefile b/boot/Makefile
index c2753de8163cf59b1abdc01149a856e2847960e6..427898449a8727747137ab1c7c571c473148c8c3 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_QFW) += bootmeth_qfw.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_RAUC) += bootmeth_rauc.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_SCRIPT) += bootmeth_script.o
 obj-$(CONFIG_$(PHASE_)CEDIT) += cedit.o
diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
new file mode 100644
index 0000000000000000000000000000000000000000..fcb7e8df4556710b160349f1dcc54cdda9b59c9d
--- /dev/null
+++ b/boot/bootmeth_rauc.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Bootmethod for distro boot with RAUC
+ *
+ * Copyright 2025 PHYTEC Messtechnik GmbH
+ * Written by Martin Schwan <m.schwan@phytec.de>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+#define LOG_DEBUG
+
+#include <asm/cache.h>
+#include <blk.h>
+#include <bootflow.h>
+#include <bootmeth.h>
+#include <bootstd.h>
+#include <dm.h>
+#include <env.h>
+#include <fs.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <string.h>
+
+static const char * const script_names[] = { "boot.scr.uimg", "boot.scr", NULL };
+static const char * const rauc_files[] = { "/usr/bin/rauc", "/etc/rauc/system.conf", NULL };
+
+/**
+ * struct distro_rauc_slot - Slot information
+ *
+ * @name	The slot name
+ * @left	The number of boot tries left
+ * @boot_part	The boot partition number on disk
+ * @root_part	The boot partition number on disk
+ */
+struct distro_rauc_slot {
+	char *name;
+	ulong left;
+	int boot_part;
+	int root_part;
+};
+
+/**
+ * struct distro_rauc_priv - Private data
+ *
+ * @slots	All slots of the device in default order
+ * @boot_order	The current boot order string containing the active slot names
+ */
+struct distro_rauc_priv {
+	struct distro_rauc_slot *slots;
+	char *boot_order;
+};
+
+static int distro_rauc_check(struct udevice *dev, struct bootflow_iter *iter)
+{
+	/* This distro only works on whole MMC devices, as multiple partitions
+	 * are needed for an A/B system. */
+	if (bootflow_iter_check_mmc(iter))
+		return log_msg_ret("mmc", -EOPNOTSUPP);
+	if (iter->part != 0)
+		return log_msg_ret("part", -EOPNOTSUPP);
+
+	return 0;
+}
+
+static int distro_rauc_scan_boot_part(struct bootflow *bflow)
+{
+	struct blk_desc *desc;
+	struct distro_rauc_priv *priv;
+	int exists;
+	int i;
+	int j;
+	int ret;
+
+	desc = dev_get_uclass_plat(bflow->blk);
+	if (!desc)
+		return log_msg_ret("desc", -ENOMEM);
+
+	priv = bflow->bootmeth_priv;
+	if (!priv || !priv->slots || !priv->boot_order)
+		return log_msg_ret("priv", -EINVAL);
+
+	for (i = 0; priv->slots[i].name != NULL; i++) {
+		exists = 0;
+		for (j = 0; script_names[j] != NULL; j++) {
+			ret = fs_set_blk_dev_with_part(desc, priv->slots[i].boot_part);
+			if (ret)
+				return log_msg_ret("blk", ret);
+			exists |= fs_exists(script_names[j]);
+		}
+		if (!exists)
+			return log_msg_ret("fs", -ENOENT);
+	}
+
+	return 0;
+}
+
+static int distro_rauc_scan_root_part(struct bootflow *bflow)
+{
+	struct blk_desc *desc;
+	struct distro_rauc_priv *priv;
+	int exists;
+	int i;
+	int j;
+	int ret;
+
+	desc = dev_get_uclass_plat(bflow->blk);
+	if (!desc)
+		return log_msg_ret("desc", -ENOMEM);
+
+	priv = bflow->bootmeth_priv;
+	if (!priv || !priv->slots || !priv->boot_order)
+		return log_msg_ret("priv", -EINVAL);
+
+	for (i = 0; priv->slots[i].name != NULL; i++) {
+		exists = 0;
+		for (j = 0; rauc_files[j] != NULL; j++) {
+			ret = fs_set_blk_dev_with_part(desc,
+					priv->slots[i].root_part);
+			if (ret)
+				return log_msg_ret("set", ret);
+			if (!fs_exists(rauc_files[j]))
+				return log_msg_ret("fs", -ENOENT);
+		}
+	}
+
+	return 0;
+}
+
+static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow)
+{
+	struct distro_rauc_priv *priv;
+	int ret;
+	char *slot;
+	int i;
+	char *boot_order;
+	char *partitions;
+	const char **partitions_list;
+	char *slots;
+	const char **slots_list;
+	char boot_left[32];
+	char *parts;
+	ulong default_tries;
+
+	bflow->state = BOOTFLOWST_MEDIA;
+
+	priv = malloc(sizeof(struct distro_rauc_priv));
+	if (!priv)
+		return log_msg_ret("buf", -ENOMEM);
+
+
+	partitions = env_get("rauc_partitions");
+	if (!partitions)
+		return log_msg_ret("env", -ENOENT);
+	partitions_list = str_to_list(partitions);
+
+	slots = env_get("rauc_slots");
+	if (!slots)
+		return log_msg_ret("env", -ENOENT);
+	slots_list = str_to_list(slots);
+
+	boot_order = env_get("BOOT_ORDER");
+	if (!boot_order) {
+		if (env_set("BOOT_ORDER", slots))
+			return log_msg_ret("env", -EPERM);
+	}
+	priv->boot_order = strdup(boot_order);
+
+	default_tries = env_get_ulong("rauc_slot_default_tries", 10, 3);
+	for (i = 0; slots_list[i] != NULL; i++) {
+		sprintf(boot_left, "BOOT_%s_LEFT", slots_list[i]);
+		if (!env_get(boot_left))
+			env_set_ulong(boot_left, default_tries);
+	}
+
+	for (i = 0; slots_list[i] != NULL && partitions_list[i] != NULL; i++);
+	priv->slots = malloc((i + 1) * sizeof(struct distro_rauc_slot));
+	if (!priv->slots)
+		return log_msg_ret("priv", -ENOMEM);
+	for (i = 0; slots_list[i] != NULL && partitions_list[i] != NULL; i++) {
+		priv->slots[i].name = strdup(slots_list[i]);
+		sprintf(boot_left, "BOOT_%s_LEFT", slot);
+		priv->slots[i].left = env_get_ulong(boot_left, 10, default_tries);
+		parts = strdup(partitions_list[i]);
+		priv->slots[i].boot_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
+		priv->slots[i].root_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
+		free(parts);
+		parts = NULL;
+	}
+	priv->slots[i].name = NULL;
+	priv->slots[i].left = 0;
+	priv->slots[i].boot_part = 0;
+	priv->slots[i].root_part = 0;
+
+	bflow->bootmeth_priv = priv;
+	bflow->state = BOOTFLOWST_FS;
+
+	ret = distro_rauc_scan_boot_part(bflow);
+	if (ret < 0)
+		goto free_priv;
+	ret = distro_rauc_scan_root_part(bflow);
+	if (ret < 0)
+		goto free_priv;
+
+	bflow->state = BOOTFLOWST_READY;
+
+	return 0;
+
+free_priv:
+	for (i = 0; priv->slots[i].name != NULL; i++)
+		free(priv->slots[i].name);
+	free(priv->slots);
+	free(priv);
+	bflow->bootmeth_priv = NULL;
+	return ret;
+}
+
+static int distro_rauc_read_file(struct udevice *dev, struct bootflow *bflow,
+				 const char *file_path, ulong addr,
+				 enum bootflow_img_t type, ulong *sizep)
+{
+	/* Reading individual files is not supported since we only operate on
+	 * whole MMC devices (because we require multiple partitions)
+	 */
+	return log_msg_ret("Unsupported", -ENOSYS);
+}
+
+static int distro_rauc_load_boot_script(struct bootflow *bflow, const char *slot)
+{
+	struct blk_desc *desc;
+	struct distro_rauc_priv *priv;
+	const char *prefix = "/";
+	int ret;
+	int i;
+
+	if (!slot)
+		return log_msg_ret("slot", -EINVAL);
+
+	desc = dev_get_uclass_plat(bflow->blk);
+	priv = bflow->bootmeth_priv;
+
+	bflow->part = 0;
+	for (i = 0; priv->slots[i].name != NULL; i++) {
+		if (strcmp(priv->slots[i].name, slot) == 0) {
+			bflow->part = priv->slots[i].boot_part;
+			break;
+		}
+	}
+	if (!bflow->part)
+		return log_msg_ret("part", -ENOENT);
+
+	ret = bootmeth_setup_fs(bflow, desc);
+	if (ret)
+		return log_msg_ret("set", ret);
+
+	for (i = 0; script_names[i] != NULL; i++) {
+		if (!bootmeth_try_file(bflow, desc, prefix, script_names[i]))
+			break;
+	}
+	if (bflow->state != BOOTFLOWST_FILE)
+		return log_msg_ret("file", -ENOENT);
+
+	bflow->subdir = strdup(prefix);
+
+	ret = bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN,
+				  (enum bootflow_img_t)IH_TYPE_SCRIPT);
+	if (ret)
+		return log_msg_ret("read", ret);
+
+	return 0;
+}
+
+static int decrement_slot_tries(const char *slot)
+{
+	ulong tries;
+	char boot_left[32];
+
+	sprintf(boot_left, "BOOT_%s_LEFT", slot);
+	tries = env_get_ulong(boot_left, 10, ULONG_MAX);
+	if (tries == ULONG_MAX)
+		return log_msg_ret("env", -ENOENT);
+	if (tries <= 0)
+		return 0;
+
+	return env_set_ulong(boot_left, tries - 1);
+}
+
+static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
+{
+	struct blk_desc *desc;
+	struct distro_rauc_priv *priv;
+	char *boot_order;
+	const char **boot_order_list;
+	const char *active_slot;
+	char raucargs[32];
+	ulong addr;
+	int ret = 0;
+	int i;
+
+	desc = dev_get_uclass_plat(bflow->blk);
+	if (desc->uclass_id != UCLASS_MMC)
+		return log_msg_ret("blk", -EINVAL);
+	priv = bflow->bootmeth_priv;
+
+	/* RAUC variables */
+	boot_order = env_get("BOOT_ORDER");
+	if (!boot_order)
+		return log_msg_ret("env", -ENOENT);
+	boot_order_list = str_to_list(boot_order);
+
+	/* Device info variables */
+	ret = env_set("devtype", blk_get_devtype(bflow->blk));
+	if (ret)
+		return log_msg_ret("env", ret);
+
+	ret = env_set_hex("devnum", desc->devnum);
+	if (ret)
+		return log_msg_ret("env", ret);
+
+	/* Kernel command line arguments */
+	active_slot = strdup(boot_order_list[0]);
+	if (!active_slot)
+		return log_msg_ret("env", -ENOENT);
+	sprintf(raucargs, "rauc.slot=%s", active_slot);
+	ret = env_set("raucargs", raucargs);
+	if (ret)
+		return log_msg_ret("env", ret);
+
+	/* TODO: If active_slot is in boot_order, but has 0 tries left, remove
+	 * it from boot_order. Then, set active_slot to other, if available.
+	 */
+
+	/* Partition info variables */
+	for (i = 0; priv->slots[i].name != NULL; i++) {
+		if (strcmp(priv->slots[i].name, active_slot) == 0) {
+			ret = env_set_hex("mmcroot", priv->slots[i].root_part);
+			if (ret)
+				return log_msg_ret("env", ret);
+			break;
+		}
+	}
+
+	/* Load distro boot script */
+	ret = distro_rauc_load_boot_script(bflow, active_slot);
+	if (ret)
+		return log_msg_ret("load", ret);
+	ret = env_set_hex("distro_bootpart", bflow->part);
+	if (ret)
+		return log_msg_ret("env", ret);
+
+	ret = decrement_slot_tries(active_slot);
+	if (ret)
+		return log_msg_ret("env", ret);
+	ret = env_save();
+	if (ret)
+		return log_msg_ret("env", ret);
+
+	log_debug("devtype: %s\n", env_get("devtype"));
+	log_debug("devnum: %s\n", env_get("devnum"));
+	log_debug("distro_bootpart: %s\n", env_get("distro_bootpart"));
+	log_debug("mmcroot: %s\n", env_get("mmcroot"));
+	log_debug("raucargs: %s\n", env_get("raucargs"));
+	log_debug("rauc_slots: %s\n", env_get("rauc_slots"));
+	log_debug("rauc_partitions: %s\n", env_get("rauc_partitions"));
+	log_debug("rauc_slot_default_tries: %s\n", env_get("rauc_slot_default_tries"));
+	log_debug("BOOT_ORDER: %s\n", env_get("BOOT_ORDER"));
+	for (i = 0; priv->slots[i].name != NULL; i++) {
+		log_debug("BOOT_%s_LEFT: %ld\n", priv->slots[i].name,
+			  priv->slots[i].left);
+	}
+
+	/* Run distro boot script */
+	addr = map_to_sysmem(bflow->buf);
+	ret = cmd_source_script(addr, NULL, NULL);
+	if (ret)
+		return log_msg_ret("boot", ret);
+
+	return 0;
+}
+
+static int distro_rauc_bootmeth_bind(struct udevice *dev)
+{
+	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
+
+	plat->desc = "RAUC distro boot from MMC";
+	plat->flags = BOOTMETHF_ANY_PART;
+
+	return 0;
+}
+
+static struct bootmeth_ops distro_rauc_bootmeth_ops = {
+	.check		= distro_rauc_check,
+	.read_bootflow	= distro_rauc_read_bootflow,
+	.read_file	= distro_rauc_read_file,
+	.boot		= distro_rauc_boot,
+};
+
+static const struct udevice_id distro_rauc_bootmeth_ids[] = {
+	{ .compatible = "u-boot,distro-rauc" },
+	{ }
+};
+
+U_BOOT_DRIVER(bootmeth_rauc) = {
+	.name		= "bootmeth_rauc",
+	.id		= UCLASS_BOOTMETH,
+	.of_match	= distro_rauc_bootmeth_ids,
+	.ops		= &distro_rauc_bootmeth_ops,
+	.bind		= distro_rauc_bootmeth_bind,
+};

-- 
2.48.1

