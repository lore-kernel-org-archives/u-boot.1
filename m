Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AEEC02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 09:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D19080ECB;
	Wed, 12 Feb 2025 10:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="QmyZkh4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3879B80C7E; Wed, 12 Feb 2025 10:31:39 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09EA580C6F
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 10:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZIxcEvcYujXPCIeXX9AXMoSKjRkaMrmvOHDBoSdDpvu5LFOYgD9AvhTeHmwtkiEw8ED5e6+IUJ/zeidRS+5zF+a7pe7n1C/S0ck1fiWm0rsL1hp80s99Gw2KSCdJyHGN4Oio0slOaupN7sWlc/jyaMk8NJx4PCFNU8doJ51raw+WTTFjZF8cdjEerTOws+07qK62Khew5pQRh6168z0+L1rLM3U7S87hKs+5A9AK2TsUguH6j/mME4BNk5OPow7cki6SQux38Z+VmgrOIeqTG6blEfruVjTBpV42dwWaa/O6+Ou1OW+cvcIAzdTRumv1KMFwcSM+oNrrZgwk5xmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HvVSAodizKjJSDs6U9fJPoKZJ/cGj4SeYl5t2PEHwk=;
 b=juqsdYZk2QBZBh1c7y9tHXsrlyKPY8Alx5SBlqXovw4XnVrQhv2OD6HcM363/stD4WsD0xn0g14I3cuPGl57riaFz7zHHcR+iBOGMd+aJl4l+lvbbWCrLLneCgcVbRwBoCaaZLcgngFRslvf6Dvb5kININoenNnY0p0xtrgW4yOYsFaRfhLBcAIXwxTxQKLaybdjRRn25V0W8ueBcTJDM4ox4gO5moaN/mBDRq1GpgQAOKsq5i9F3pRUCMgHzNy8rp/alFUBOf/TwynKIeLrYExWB/hBMbxRD3KRPTBJen9ETqRFfraPqQNaPof3EdcLHusPPYsm1UQC/S7jB7t19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HvVSAodizKjJSDs6U9fJPoKZJ/cGj4SeYl5t2PEHwk=;
 b=QmyZkh4/q55dwZ3GCtXZa+vX9JjV+7P0Q9/t7dd7UosqaronNFMT+Ci3SGwyFfMy7ijH/7SsI5ewsQ8ZzQxAhgV5aGG0R5Z9pZSD1dgYk4vYVleP/Rn+g4ZVKCjlsSVMZ205zkjucJfkzPco2b6hFkQmAUlsdSnpy9G948ARvoZDWSt5JnOxtxypconmDUQTtIE+N1SKmPq8xgFqNXbbTPSZaRU1a+d3LMMFIKBwSiBc9UpjForur0j7dtMqhSwiCdXVy3eUeKs876WWNyrKBKVta12KkVL1O7y8o9vmMwTCFbVZKxmNJun4PchS/NFvOawLZroPOrJ7FRpOW+W/MQ==
Received: from MR1P264CA0147.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:54::9) by
 MR0P264MB4922.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4c::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Wed, 12 Feb 2025 09:31:34 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54:cafe::90) by MR1P264CA0147.outlook.office365.com
 (2603:10a6:501:54::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Wed,
 12 Feb 2025 09:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10
 via Frontend Transport; Wed, 12 Feb 2025 09:31:34 +0000
Received: from sah2lpt245.. (unknown [192.168.72.253])
 by proxy.softathome.com (Postfix) with ESMTPSA id 1719320065;
 Wed, 12 Feb 2025 10:31:34 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 4/6] tools: Add preload_check_sign to authenticate images with
 a pre-load
Date: Wed, 12 Feb 2025 10:31:24 +0100
Message-ID: <20250212093126.3722186-5-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
References: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|MR0P264MB4922:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d60cde9f-9370-44e2-eaeb-08dd4b480ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?86XfaxBKyhF8N4y8Qz8Lo/LsvJM6Wa/3ro8yQHpzg+fiP5b/FsYJqyT+Itt2?=
 =?us-ascii?Q?kHZsKErS+EBBhwXhgWK0x8xv2Ikd37LnxhI8BwXiFbNYaRvpHb9eDxKcd30T?=
 =?us-ascii?Q?FkihjPSbxaEid8RKuG7BbNK8FZ9ycOiZbz2EjlWwsy1OXV12rHIu1rclt8/S?=
 =?us-ascii?Q?mo4cVRsQzSVf2S876ESqiBt0ueyA8yMde0X7jCnhgbI1Hd+aLmiN+eSeYNko?=
 =?us-ascii?Q?4XuDB5qK90l9WzU73tz9LBuX1ffk5vzbFFQn/EF0c7sGR8zTzMNStvEljASz?=
 =?us-ascii?Q?hZ/648IpbRDfJeY61u5kt10ZqBCBZl8Qt5p7TrfiHs/f7RhbNObe6LmylRv4?=
 =?us-ascii?Q?EqOsZFgmqBw5YknsBF1tqLu3QugLpkpicy0veqfC6HBxhFWQbtzjeIlY4UBb?=
 =?us-ascii?Q?LQ6KiWne02qVasKaiw6LC2zbRpQVx5c+O6ovV4R445eu/3yn0PddXVIUtiH9?=
 =?us-ascii?Q?w4LPlcAy64jxmtbZnX5fRrmmJxhIarb0grhwlBlI3cQtKC80OuhUSgwhDoVk?=
 =?us-ascii?Q?cL2eWzrpCt2odPcUlnX3ZTHMVFu3ZTWg1idqxYjjDuteX4T46RsjOZLMGmZz?=
 =?us-ascii?Q?APU8zbwiCKi0sbXxvfEbDu3jBxAAxOLQSbp1tkNuuirgwBCjZD0+dKoJpYLt?=
 =?us-ascii?Q?nHVQRNuCXliTL+vM6Z7hrxzhLwhv1KMIxDaJhTmE2Upr5cVPfxmU/LPdovXd?=
 =?us-ascii?Q?7y6UnQk1OnpBB/E5/YT+Ki6c8LG5cPKkJZoElUjlOrgxr1viKdlqFmwAO+UF?=
 =?us-ascii?Q?XQxpxwnk9edWM6qRgHu9JLrGcXgxY5422ME3KlCGApwplSjkezBsNpCV/uNs?=
 =?us-ascii?Q?nhxg4msERvTr0ApYZ+vb6EVUIy1g9pxWnBaIg+swmgG3FUkVr+bQwpNgBrOD?=
 =?us-ascii?Q?7JhpxWHW8ZIPN/Z6F02fbphFdeuQGRIkkAP8QE/p7yRdKN/TWAMqPVI2IXXz?=
 =?us-ascii?Q?QdhwgzIo0f/AdI5U8gwDixrJ4fHFTDj8yyF/Fu80iC9IvF0AhM23pTuKFlXD?=
 =?us-ascii?Q?Ujpj3wPOaAqel2mz4NQlvreYu6GEXY+7YT4j22MEmzr/YYan+diRSGXctwao?=
 =?us-ascii?Q?ZizSDAxHOMgcSQKOPhS417x+YmHtsDfqSWhzOQaS27NDQ9pY/ddjFD3Br791?=
 =?us-ascii?Q?Lu3y44M3zzjLEqawL5aAkV9nbIahmuNKtpAL4hStqRy/fD8m8MWlIRt7D2m6?=
 =?us-ascii?Q?Lg9t/KUmiQs6zdqraV8dtHEbG84kpw7UE4LAAGaihJTlZszsufDqnuLSa+Ou?=
 =?us-ascii?Q?AW67qWC52TiD/Xw0zZJCNlvD1Xh2OGwx14w2ulSoJDVFppFd/tIw1I2G9QoA?=
 =?us-ascii?Q?V+4qO3VxjzrPkvAbO+KP6H7EgPXgv2mtkOxFJb8cjuRdYj6JWWQZAoITwqz/?=
 =?us-ascii?Q?8bfMSW7l0bc8Kvt6+rK+q+vfWFoOcgUIA7g1LmdB6pEasVCyE3MzU0YrsV8K?=
 =?us-ascii?Q?GkQr5PXYhr1CW1H5YEEiJNBjMXuyVfq/t64eAlQsxtMlCLkbM4/xeTfnLSn3?=
 =?us-ascii?Q?c/uQlNYT23ZDW5M=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 09:31:34.4948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d60cde9f-9370-44e2-eaeb-08dd4b480ab0
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB4922
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
 tools/.gitignore           |   1 +
 tools/Kconfig              |   5 ++
 tools/Makefile             |   5 ++
 tools/preload_check_sign.c | 161 +++++++++++++++++++++++++++++++++++++
 4 files changed, 172 insertions(+)
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
index 00000000000..63a778203f0
--- /dev/null
+++ b/tools/preload_check_sign.c
@@ -0,0 +1,161 @@
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
+#include <openssl/core_names.h>
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
+	info.sig_size = (EVP_PKEY_get_bits(pkey) + 7) / 8;
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

