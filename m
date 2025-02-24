Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E028AC021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 21:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7818780FB9;
	Mon, 24 Feb 2025 22:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Ea5b9k4m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 035EE80F98; Mon, 24 Feb 2025 22:21:14 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E0280F53
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 22:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHXRBvGjv4+Xf34Rs6oK4YFZflpVDdWhXFVJNnc/DVGQi3twhI3NTxNZQoAup3xmrqdkvBnVLutZBxSXzjENOP1XpsxExqczKyomfGLxbK8Id3Px8eaWS9bU58hQxzykdz7/qOQkR6tFG9jC04U8Hp32PzCbGmsOeIkoevLbo2XUVsCn38kr92fFFaeDWyUzjXzHCnauW85A0hkL5+MTpgT+sFss0Iuor5x+8E9Cps0kfe9aZEKjlsC5kMum2qoEowOPV1kgh/qNSjmmHvCs1eqtuok0tSl+CdlwSKd/54k2FHsLvGUWlw1dYpY9rmLRSv41YNFc0EMda2CcrlUgzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r8nTcJTZIz8UC4btxhiuBKE48C6uY7HuGM9wKhFvBM=;
 b=S8zgeSK7fytmyOzmh4cndqeda89sVioDJiZ47nL1rbdLqqpBaLVuzJ8beoKJJ5hsRa679ogYiyMU9yFx7TzLpzxVw7vjE8xp8r++p4bt0HBGm92QIELmNaLBcdVoU8ZVShtucl7NcL6rnsqzcUsJn28+YWFtk1ux9LRuMi1MmTJ1lIAjpzVqdip2E1ghrl8/xed5uSpluOE2DKG1Elw7iXMBcOG7J4ASr42I1Umq6eFEBOkE2RrvCIkGp54SITvB674AP3U2D3Nzb1yoDE6WZDBL/FkddU89ScKX7mLwCRMaILj2dzBgyu3RINc1YKWtIqJEQCNrT30+TxclhKSEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r8nTcJTZIz8UC4btxhiuBKE48C6uY7HuGM9wKhFvBM=;
 b=Ea5b9k4m9jLbuVDWtRYiZ7iDZxPWjz+yRQZZfb6D7sdPtWrvi/CKGBtktOIV2Ds7zBgaf1nGoqRPOqWABrx0MUCEu2NTNSO6amhStDz3O264L8CJQBlghF0jBtms2Qhj0RBm+V6UkAtY4BxQbKzFNMHZWksWbXF31doxlXYIq8HfTCXa9D61RWYTJURTK+ILcyhoMlb5HqQ/73LZHnk7WzDd2Bqnwgc6P3JXnhgD/RyISErEKSJDAGL/ljv6QusU8pGHkXggyF6etIYr9NUnjD0qlOal4ekeO5npILB5C+bCht/ulfcxr6m+ff8/7v/iXyT85C9KCRt7qxwNALeL8w==
Received: from PA7P264CA0358.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37c::14)
 by PASP264MB5658.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:49f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 21:21:10 +0000
Received: from PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c:cafe::53) by PA7P264CA0358.outlook.office365.com
 (2603:10a6:102:37c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Mon,
 24 Feb 2025 21:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BA.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16
 via Frontend Transport; Mon, 24 Feb 2025 21:21:10 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id 74A19209B3;
 Mon, 24 Feb 2025 22:21:09 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, paul.henrysd+nodisclaimer@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 4/6] tools: Add preload_check_sign to authenticate images
 with a pre-load
Date: Mon, 24 Feb 2025 22:20:53 +0100
Message-ID: <20250224212055.2992852-4-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224212055.2992852-1-paul.henrys_ext@softathome.com>
References: <20250224212055.2992852-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BA:EE_|PASP264MB5658:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f7bd079c-49b0-4a27-c616-08dd551928b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GV5Fiwfk9Yhd9blR0zLNo3l3XhXPNaLZKJ5PlYJhAgpX+JCJ1OW4uac8cWE6?=
 =?us-ascii?Q?nDPnk6jtyW10wNwCsJqnNFhRMKM4JU6sogRK62/OafgEvkPM1pQB1eBYDio8?=
 =?us-ascii?Q?XE1Nn65kKBzXFLY1TZXG3WnoGD8NKxQblx0rPMcrw8tsvtSGfXYOWrHNsrGG?=
 =?us-ascii?Q?ZmZKRj8cMY5jqW7lKMnJrRhWruZhFA8R9BCPr2Oj0VgCp0N/A6JTbOd29sfV?=
 =?us-ascii?Q?QjqFq9QxE52DuXy4qAVSItzSxRsdCJwAAdGs5N1MxUwQPR3WV7yYHXB9846+?=
 =?us-ascii?Q?ad+WaM5XixNyNsXAHX1zi2ui904JE81SiMrRo1NiNIF5/kv39ivKcGWY5Gad?=
 =?us-ascii?Q?si6LRoFNBysZX3C6p+OBZn/SBcwx9/7vhUlAeN6y1hOnNkgkk5J3sOz6dxRY?=
 =?us-ascii?Q?Qt2hZnHSgfDepVMur5icuBnJtWOwIey5IukDYFuwqtopC69HGidb60a26WPH?=
 =?us-ascii?Q?sj6w80jUv+yE8/jgt3/jj/eZ6yoxDv0U8ZEKjAsUeJ40jI1ZIZICLiBAk7ac?=
 =?us-ascii?Q?Pg9+CUzBVTvutu26g2hlH9cv0zGvaydR2pTXyBjF/kC6aCAbH2yokNZia0Up?=
 =?us-ascii?Q?qVxtCG9W2u6lW4R4kislt5CYpOVEQufhitrNGIInNTNNb0591yj99bVES4Qe?=
 =?us-ascii?Q?51naj7pIDtJcDB4DJQUhQFH3mo10D0vMnb7Jqlu+lfTI75vgSy6GNKiCq9rl?=
 =?us-ascii?Q?7GoNTn68wP8bU+OUa3oJ3NhOhhBdN4KIixHFVsAmU4//j3tvEPvEHMEWVZWV?=
 =?us-ascii?Q?hh/8Y3Zs5HAmDSYJtIsdplsHkGfoO08qAXUXpWa6eKY626Oj88FIqipXhy26?=
 =?us-ascii?Q?BkzgeUUOlpXhlRjBJM2RtDpx1GMO1oz4VVf2slVEEuaw0uutaRdVvlYKzuwk?=
 =?us-ascii?Q?py5sA0AErnojLHr5V9OjwW+PTI1jGWTPCIPktz7AgkR5EZeOpi8QNI4uRydx?=
 =?us-ascii?Q?GsIKI1PT1vGqBqENewi8vIvpcnvRlEe3AdbwJ0M9PK7bcMXynMdX8SJWKekp?=
 =?us-ascii?Q?Bna6FTWpaHsA0zUrn0DTE6RD3MwVYdNaA9KLp4vJl4saIPKL3/k5ofkL2II1?=
 =?us-ascii?Q?kjqLap5l01IDqMYkzu5qt5uXIO3ays2/wRvqJNAqNvUG6oWoltEO40IrOyCA?=
 =?us-ascii?Q?X8UTmABgvcjWHUsDPaTXfmfxhgHVhzux4RDS7AQjOC2tc/hq+kpcCLlUooqF?=
 =?us-ascii?Q?1FROhMpqv7l4GtrKug0cCv9lzo4gSxgiETghPBsq3HGnIC3xc0dTBeJ/Ebe0?=
 =?us-ascii?Q?rJkqq5PyVYF8tuZBHuFmsonuPxg7jrBb84btGqpzkZB0hNJ/EVQIlwBwtCvE?=
 =?us-ascii?Q?Uok9FfHQEuEczFxR3OZ0c+bJb/lJQnlwccjDegOtlXRI7zvwoB40V970vLg8?=
 =?us-ascii?Q?6BwGQbbrTJjvcV/bI6HRh8szakL6fHA4CD7QfuKxXPV6TQqQACwRbz1tSynu?=
 =?us-ascii?Q?kdDmCXnPJ/VCpAiPZZzbDqb42Dq+Cov7R3+aWcYDnXP9DNCllSsmc5kJGsUO?=
 =?us-ascii?Q?s+5w6oedetqM864=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:21:10.2129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bd079c-49b0-4a27-c616-08dd551928b9
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5658
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

preload_check_sign is added so that it can be used to authenticate images
signed with the pre-load signature supported by binman and U-Boot.
It could also be used to test the signature in binman tests signing
images with the pre-load.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
Changes for v2:
- Replace the call to EVP_PKEY_get_bits() by EVP_PKEY_size() supported by older
  openssl versions. It's also make more sense to use EVP_PKEY_size() than
  calculating the size.
  This fixes the tools build on MacOS using OpenSSL 1.1.

 tools/.gitignore           |   1 +
 tools/Kconfig              |   5 ++
 tools/Makefile             |   5 ++
 tools/preload_check_sign.c | 160 +++++++++++++++++++++++++++++++++++++
 4 files changed, 171 insertions(+)
 create mode 100644 tools/preload_check_sign.c

diff --git a/tools/.gitignore b/tools/.gitignore
index 0108c567309..6a5c613f772 100644
--- a/tools/.gitignore
+++ b/tools/.gitignore
@@ -29,6 +29,7 @@
 /mxsboot
 /ncb
 /prelink-riscv
+/preload_check_sign
 /printinitialenv
 /proftool
 /relocate-rela
diff --git a/tools/Kconfig b/tools/Kconfig
index 01ff0fcf748..8e272ee99a8 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -9,6 +9,11 @@ config MKIMAGE_DTC_PATH
 	  some cases the system dtc may not support all required features
 	  and the path to a different version should be given here.
 
+config TOOLS_IMAGE_PRE_LOAD
+	def_bool y
+	help
+	  Enable pre-load signature support in the tools builds.
+
 config TOOLS_CRC16
 	def_bool y
 	help
diff --git a/tools/Makefile b/tools/Makefile
index 237fa900a24..e5f5eea47c7 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -66,6 +66,7 @@ mkenvimage-objs := mkenvimage.o os_support.o generated/lib/crc32.o
 hostprogs-y += dumpimage mkimage
 hostprogs-$(CONFIG_TOOLS_LIBCRYPTO) += fit_info fit_check_sign
 hostprogs-$(CONFIG_TOOLS_LIBCRYPTO) += fdt_add_pubkey
+hostprogs-$(CONFIG_TOOLS_LIBCRYPTO) += preload_check_sign
 
 ifneq ($(CONFIG_CMD_BOOTEFI_SELFTEST)$(CONFIG_FWU_MDATA_GPT_BLK),)
 hostprogs-y += file2include
@@ -89,6 +90,8 @@ ECDSA_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := $(addprefix generated/lib/ecdsa/, ecdsa-
 AES_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := $(addprefix generated/lib/aes/, \
 					aes-encrypt.o aes-decrypt.o)
 
+PRELOAD_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := generated/boot/image-pre-load.o
+
 # Cryptographic helpers and image types that depend on openssl/libcrypto
 LIBCRYPTO_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := \
 			generated/lib/fdt-libcrypto.o \
@@ -158,6 +161,7 @@ fit_info-objs   := $(dumpimage-mkimage-objs) fit_info.o
 fit_check_sign-objs   := $(dumpimage-mkimage-objs) fit_check_sign.o
 fdt_add_pubkey-objs   := $(dumpimage-mkimage-objs) fdt_add_pubkey.o
 file2include-objs := file2include.o
+preload_check_sign-objs := $(dumpimage-mkimage-objs) $(PRELOAD_OBJS-y) preload_check_sign.o
 
 ifneq ($(CONFIG_MX23)$(CONFIG_MX28)$(CONFIG_TOOLS_LIBCRYPTO),)
 # Add CFG_MXS into host CFLAGS, so we can check whether or not register
@@ -195,6 +199,7 @@ HOSTLDLIBS_dumpimage := $(HOSTLDLIBS_mkimage)
 HOSTLDLIBS_fit_info := $(HOSTLDLIBS_mkimage)
 HOSTLDLIBS_fit_check_sign := $(HOSTLDLIBS_mkimage)
 HOSTLDLIBS_fdt_add_pubkey := $(HOSTLDLIBS_mkimage)
+HOSTLDLIBS_preload_check_sign := $(HOSTLDLIBS_mkimage)
 
 hostprogs-$(CONFIG_EXYNOS5250) += mkexynosspl
 hostprogs-$(CONFIG_EXYNOS5420) += mkexynosspl
diff --git a/tools/preload_check_sign.c b/tools/preload_check_sign.c
new file mode 100644
index 00000000000..ebead459273
--- /dev/null
+++ b/tools/preload_check_sign.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Check a file including a preload header including a signature
+ *
+ * Copyright (c) 2025 Paul HENRYS <paul.henrys_ext@softathome.com>
+ *
+ * Binman makes it possible to generate a preload header signing part or the
+ * complete file. The tool preload_check_sign allows to verify and authenticate
+ * a file starting with a preload header.
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <openssl/pem.h>
+#include <openssl/evp.h>
+#include <openssl/err.h>
+#include <image.h>
+
+extern void image_pre_load_sig_set_info(struct image_sig_info *info);
+extern int image_pre_load_sig(ulong addr);
+
+static void usage(char *cmdname)
+{
+	fprintf(stderr, "Usage: %s -f file -k PEM key file\n"
+			"          -f ==> set file which should be checked\n"
+			"          -k ==> PEM key file\n"
+			"          -a ==> algo (default: sha256,rsa2048)\n"
+			"          -p ==> padding (default: pkcs-1.5)\n"
+			"          -h ==> help\n",
+		cmdname);
+	exit(EXIT_FAILURE);
+}
+
+int main(int argc, char **argv)
+{
+	int ret = 0;
+	char cmdname[256];
+	char *file = NULL;
+	char *keyfile = NULL;
+	int c;
+	FILE *fp = NULL;
+	FILE *fp_key = NULL;
+	size_t bytes;
+	long filesize;
+	void *buffer = NULL;
+	EVP_PKEY *pkey = NULL;
+	char *algo = "sha256,rsa2048";
+	char *padding = "pkcs-1.5";
+	struct image_sig_info info = {0};
+
+	strncpy(cmdname, *argv, sizeof(cmdname) - 1);
+	cmdname[sizeof(cmdname) - 1] = '\0';
+	while ((c = getopt(argc, argv, "f:k:a:p:h")) != -1)
+		switch (c) {
+		case 'f':
+			file = optarg;
+			break;
+		case 'k':
+			keyfile = optarg;
+			break;
+		case 'a':
+			algo = optarg;
+			break;
+		case 'p':
+			padding = optarg;
+			break;
+		default:
+			usage(cmdname);
+			break;
+	}
+
+	if (!file) {
+		fprintf(stderr, "%s: Missing file\n", *argv);
+		usage(*argv);
+	}
+
+	if (!keyfile) {
+		fprintf(stderr, "%s: Missing key file\n", *argv);
+		usage(*argv);
+	}
+
+	fp = fopen(file, "r");
+	if (!fp) {
+		fprintf(stderr, "Error opening file: %s\n", file);
+		ret = EXIT_FAILURE;
+		goto out;
+	}
+
+	fseek(fp, 0, SEEK_END);
+	filesize = ftell(fp);
+	rewind(fp);
+
+	buffer = malloc(filesize);
+	if (!buffer) {
+		fprintf(stderr, "Memory allocation failed");
+		ret = EXIT_FAILURE;
+		goto out;
+	}
+
+	bytes = fread(buffer, 1, filesize, fp);
+	if (bytes != filesize) {
+		fprintf(stderr, "Error reading file\n");
+		ret = EXIT_FAILURE;
+		goto out;
+	}
+
+	fp_key = fopen(keyfile, "r");
+	if (!fp_key) {
+		fprintf(stderr, "Error opening file: %s\n", keyfile);
+		ret = EXIT_FAILURE;
+		goto out;
+	}
+
+	/* Attempt to read the private key */
+	pkey = PEM_read_PrivateKey(fp_key, NULL, NULL, NULL);
+	if (!pkey) {
+		/* If private key reading fails, try reading as a public key */
+		fseek(fp_key, 0, SEEK_SET);
+		pkey = PEM_read_PUBKEY(fp_key, NULL, NULL, NULL);
+	}
+	if (!pkey) {
+		fprintf(stderr, "Unable to retrieve the public key: %s\n",
+			ERR_error_string(ERR_get_error(), NULL));
+		ret = EXIT_FAILURE;
+		goto out;
+	}
+
+	info.algo_name = algo;
+	info.padding_name = padding;
+	info.key = (uint8_t *)pkey;
+	info.mandatory = 1;
+	info.sig_size = EVP_PKEY_size(pkey);
+	if (info.sig_size < 0) {
+		fprintf(stderr, "Fail to retrieve the signature size: %s\n",
+			ERR_error_string(ERR_get_error(), NULL));
+		ret = EXIT_FAILURE;
+		goto out;
+	}
+
+	/* Compute signature information */
+	info.sig_info.name     = info.algo_name;
+	info.sig_info.padding  = image_get_padding_algo(info.padding_name);
+	info.sig_info.checksum = image_get_checksum_algo(info.sig_info.name);
+	info.sig_info.crypto   = image_get_crypto_algo(info.sig_info.name);
+	info.sig_info.key      = info.key;
+	info.sig_info.keylen   = info.key_len;
+
+	/* Check the signature */
+	image_pre_load_sig_set_info(&info);
+	ret = image_pre_load_sig((ulong)buffer);
+out:
+	if (fp)
+		fclose(fp);
+	if (fp_key)
+		fclose(fp_key);
+	if (info.key)
+		EVP_PKEY_free(pkey);
+	free(buffer);
+
+	exit(ret);
+}
-- 
2.43.0

