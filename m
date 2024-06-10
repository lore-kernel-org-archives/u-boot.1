Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67AEC27C5F
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ACAE884DD;
	Mon, 10 Jun 2024 11:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ay/N0i6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F553884C7; Mon, 10 Jun 2024 11:11:10 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B99C884B8
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1A20E41332
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718010668;
 bh=1jitKbIjgpm4y92a1D3RutU5V51xNVF7yYLypo9SZeA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Ay/N0i6ce3rz15WUxD+i17MlmpSeVYAY6IEXZtiTBA/AdRkYsUN9jX5Ndk8UiFk2I
 ZQWYo7D8DcElSmk6VqQapqDkWS6s2pwHVibUBUKAcYtj1JanTysh/54wFia1WNePtE
 TGGIQ9S0JvWBuOEzzX3AWC4XOgEvS1qbQrB8uqT0LwqN44p8mrWCFVV9YwcPhZEpbS
 kbN+GExwsUqwCpt+iU/EvotFoxen17JPXTT8WqtggMom9XgiX4byKIu+VNeiTFR2FL
 ppoasaMRhGLo+xQmiMR3aJNqc0gy5sDsRJ6EXPr+vH7TqF88HN4waaYIoep71NAalh
 7f7Dj9kmE40+A==
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52b998cb52eso3263463e87.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718010667; x=1718615467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1jitKbIjgpm4y92a1D3RutU5V51xNVF7yYLypo9SZeA=;
 b=doCw8U/ed6uyppWImaO85SuqqS9wVFM8ZuMX8/qdzTafXsCS3l/oQHetRbDCtZY8MP
 567eApsPMIUazcXKYzTHj48IB+lDg2kChS1ZQnI3rzifjtibiHehBlixyC73KcdjT5qx
 yRKr0Nre/H9c9NXXqFmJw52f8FOBHGi57xHInREWkhMes+RtfEvBa58GrQ4fI6fKplt3
 BWw1PPngRsq0SCw7f1L+w8uimZF6l9lnCcekm0cfXiDYfqd2ZVT7UaiuFqm9TjcDpnrZ
 nlxYIjUAJeE/mfcpsdcHA7TR1Eu0Gy79ISzuBKDGqR/veQ/PvuuKTfo/uLZ4iwj2Hh3A
 JeSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWGeK7gTVqVfdlMRina+fnBfnI/O6IS9jO0QJG3MblO1tC8Ee0rei9WxbbRKCwKLv0wd4QS+91RgbA5C+EytEqShvHVA==
X-Gm-Message-State: AOJu0Yx+Yacf74Iz5aoErL5Xs9bEGEbsSZa4wQiF9b2X0yXBqm2C3p+e
 B3DsiZO3OiNJ0uACVqv39ENXH89XyaYR4M68jwbNKBb9Q6pxE9jqBQF7vIzchaygi3YB5hQQNJX
 0rl+T/O8aIRNE1uVK9zajH6b26s2L4D45LkuOg9jiW8zyajlJQlazEl07gHSB02yVZIU=
X-Received: by 2002:a19:641a:0:b0:516:cc2d:f6a1 with SMTP id
 2adb3069b0e04-52bb9fc572cmr4958533e87.51.1718010667357; 
 Mon, 10 Jun 2024 02:11:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW6Q+CMUVrqJBw8c3BPCl4jdx7gZIiAMq60ZPxhzcs476ulb6z+NJ6N7TQyZHjNkUA8ARm0w==
X-Received: by 2002:a19:641a:0:b0:516:cc2d:f6a1 with SMTP id
 2adb3069b0e04-52bb9fc572cmr4958509e87.51.1718010666627; 
 Mon, 10 Jun 2024 02:11:06 -0700 (PDT)
Received: from workstation5.. ([2a00:20:43:88b5:6b2b:e162:4c45:5c4c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42183c08f49sm41059465e9.6.2024.06.10.02.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:11:06 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 3/9] cmd: efidebug: add support for setting fdt
Date: Mon, 10 Jun 2024 11:10:51 +0200
Message-ID: <20240610091057.64463-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
References: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We already support creating a load option where the device-path
field contains the concatenation of the binary device-path and
optionally the device path of the initrd which we expose via the
EFI_LOAD_FILE2_PROTOCOL.

Allow to append another device-path pointing to the device-tree
identified by the device-tree GUID.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v3:
	Add missing '@' in EFI_LP_DP_PART_FDT description
	No change
v2:
	Rename create_initrd_dp() to create_lo_dp_part().
	Use enum as parameter for create_lo_dp_part().
	Use function efi_load_option_dp_join() to avoid code duplication.
---
 cmd/efidebug.c | 130 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 93 insertions(+), 37 deletions(-)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 762027daf8a..966b4b83361 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -654,38 +654,80 @@ static int do_efi_show_tables(struct cmd_tbl *cmdtp, int flag,
 }
 
 /**
- * create_initrd_dp() - create a special device for our Boot### option
+ * enum efi_lo_dp_part - part of device path in load option
+ */
+enum efi_lo_dp_part {
+	/** @EFI_LO_DP_PART_BINARY: binary */
+	EFI_LO_DP_PART_BINARY,
+	/** @EFI_LO_DP_PART_INITRD: initial RAM disk */
+	EFI_LO_DP_PART_INITRD,
+	/** @EFI_LP_DP_PART_FDT: device-tree */
+	EFI_LP_DP_PART_FDT,
+};
+
+/**
+ * create_lo_dp() - create a special device path for our Boot### option
  *
  * @dev:	device
  * @part:	disk partition
  * @file:	filename
  * @shortform:	create short form device path
+ * @type:	part of device path to be created
  * Return:	pointer to the device path or ERR_PTR
  */
 static
-struct efi_device_path *create_initrd_dp(const char *dev, const char *part,
-					 const char *file, int shortform)
+struct efi_device_path *create_lo_dp_part(const char *dev, const char *part,
+					  const char *file, bool shortform,
+					  enum efi_lo_dp_part type)
 
 {
 	struct efi_device_path *tmp_dp = NULL, *tmp_fp = NULL, *short_fp = NULL;
-	struct efi_device_path *initrd_dp = NULL;
+	struct efi_device_path *dp = NULL;
+	const struct efi_device_path *dp_prefix;
 	efi_status_t ret;
-	const struct efi_initrd_dp id_dp = {
+	const struct efi_initrd_dp fdt_dp = {
+		.vendor = {
+			{
+			DEVICE_PATH_TYPE_MEDIA_DEVICE,
+			DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
+			sizeof(fdt_dp.vendor),
+			},
+			EFI_FDT_GUID,
+		},
+		.end = {
+			DEVICE_PATH_TYPE_END,
+			DEVICE_PATH_SUB_TYPE_END,
+			sizeof(fdt_dp.end),
+		}
+	};
+	const struct efi_initrd_dp initrd_dp = {
 		.vendor = {
 			{
 			DEVICE_PATH_TYPE_MEDIA_DEVICE,
 			DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
-			sizeof(id_dp.vendor),
+			sizeof(initrd_dp.vendor),
 			},
 			EFI_INITRD_MEDIA_GUID,
 		},
 		.end = {
 			DEVICE_PATH_TYPE_END,
 			DEVICE_PATH_SUB_TYPE_END,
-			sizeof(id_dp.end),
+			sizeof(initrd_dp.end),
 		}
 	};
 
+	switch (type) {
+	case EFI_LO_DP_PART_INITRD:
+		dp_prefix = &initrd_dp.vendor.dp;
+		break;
+	case EFI_LP_DP_PART_FDT:
+		dp_prefix = &fdt_dp.vendor.dp;
+		break;
+	default:
+		dp_prefix = NULL;
+		break;
+	}
+
 	ret = efi_dp_from_name(dev, part, file, &tmp_dp, &tmp_fp);
 	if (ret != EFI_SUCCESS) {
 		printf("Cannot create device path for \"%s %s\"\n", part, file);
@@ -696,13 +739,12 @@ struct efi_device_path *create_initrd_dp(const char *dev, const char *part,
 	if (!short_fp)
 		short_fp = tmp_fp;
 
-	initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
-				  short_fp, 0);
+	dp = efi_dp_concat(dp_prefix, short_fp, 0);
 
 out:
 	efi_free_pool(tmp_dp);
 	efi_free_pool(tmp_fp);
-	return initrd_dp;
+	return dp;
 }
 
 /**
@@ -793,9 +835,8 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 	efi_guid_t guid;
 	u16 *label;
 	struct efi_device_path *file_path = NULL;
-	struct efi_device_path *fp_free = NULL;
-	struct efi_device_path *final_fp = NULL;
 	struct efi_device_path *initrd_dp = NULL;
+	struct efi_device_path *fdt_dp = NULL;
 	struct efi_load_option lo;
 	void *data = NULL;
 	efi_uintn_t size;
@@ -843,22 +884,31 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 			lo.label = label; /* label will be changed below */
 
 			/* file path */
-			ret = efi_dp_from_name(argv[3], argv[4], argv[5],
-					       NULL, &fp_free);
-			if (ret != EFI_SUCCESS) {
-				printf("Cannot create device path for \"%s %s\"\n",
-				       argv[3], argv[4]);
+			file_path = create_lo_dp_part(argv[3], argv[4], argv[5],
+						      shortform,
+						      EFI_LO_DP_PART_BINARY);
+			argc -= 5;
+			argv += 5;
+			break;
+		case 'd':
+			shortform = 1;
+			fallthrough;
+		case 'D':
+			if (argc < 3 || fdt_dp) {
+				r = CMD_RET_USAGE;
+				goto out;
+			}
+
+			fdt_dp = create_lo_dp_part(argv[1], argv[2], argv[3],
+						   shortform,
+						   EFI_LP_DP_PART_FDT);
+			if (!fdt_dp) {
+				printf("Cannot add a device-tree\n");
 				r = CMD_RET_FAILURE;
 				goto out;
 			}
-			if (shortform)
-				file_path = efi_dp_shorten(fp_free);
-			if (!file_path)
-				file_path = fp_free;
-			fp_size += efi_dp_size(file_path) +
-				sizeof(struct efi_device_path);
-			argc -= 5;
-			argv += 5;
+			argc -= 3;
+			argv += 3;
 			break;
 		case 'i':
 			shortform = 1;
@@ -869,8 +919,9 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 				goto out;
 			}
 
-			initrd_dp = create_initrd_dp(argv[1], argv[2], argv[3],
-						     shortform);
+			initrd_dp = create_lo_dp_part(argv[1], argv[2], argv[3],
+						      shortform,
+						      EFI_LO_DP_PART_INITRD);
 			if (!initrd_dp) {
 				printf("Cannot add an initrd\n");
 				r = CMD_RET_FAILURE;
@@ -878,8 +929,6 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 			}
 			argc -= 3;
 			argv += 3;
-			fp_size += efi_dp_size(initrd_dp) +
-				sizeof(struct efi_device_path);
 			break;
 		case 's':
 			if (argc < 1 || lo.optional_data) {
@@ -897,7 +946,6 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 						     &file_path, &fp_size);
 				if (r != CMD_RET_SUCCESS)
 					goto out;
-				fp_free = file_path;
 				argc -= 3;
 				argv += 3;
 			} else{
@@ -917,14 +965,14 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 		goto out;
 	}
 
-	final_fp = efi_dp_concat(file_path, initrd_dp, 1);
-	if (!final_fp) {
+	ret = efi_load_option_dp_join(&file_path, &fp_size, initrd_dp, fdt_dp);
+	if (ret != EFI_SUCCESS) {
 		printf("Cannot create final device path\n");
 		r = CMD_RET_FAILURE;
 		goto out;
 	}
 
-	lo.file_path = final_fp;
+	lo.file_path = file_path;
 	lo.file_path_length = fp_size;
 
 	size = efi_serialize_load_option(&lo, (u8 **)&data);
@@ -945,9 +993,9 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 
 out:
 	free(data);
-	efi_free_pool(final_fp);
 	efi_free_pool(initrd_dp);
-	efi_free_pool(fp_free);
+	efi_free_pool(fdt_dp);
+	efi_free_pool(file_path);
 	free(lo.label);
 
 	return r;
@@ -1009,7 +1057,8 @@ static int do_efi_boot_rm(struct cmd_tbl *cmdtp, int flag,
  */
 static void show_efi_boot_opt_data(u16 *varname16, void *data, size_t *size)
 {
-	struct efi_device_path *initrd_path = NULL;
+	struct efi_device_path *fdt_path;
+	struct efi_device_path *initrd_path;
 	struct efi_load_option lo;
 	efi_status_t ret;
 
@@ -1038,6 +1087,12 @@ static void show_efi_boot_opt_data(u16 *varname16, void *data, size_t *size)
 		efi_free_pool(initrd_path);
 	}
 
+	fdt_path = efi_dp_from_lo(&lo, &efi_guid_fdt);
+	if (fdt_path) {
+		printf("  device-tree path: %pD\n", fdt_path);
+		efi_free_pool(fdt_path);
+	}
+
 	printf("  data:\n");
 	print_hex_dump("    ", DUMP_PREFIX_OFFSET, 16, 1,
 		       lo.optional_data, *size, true);
@@ -1565,8 +1620,9 @@ U_BOOT_LONGHELP(efidebug,
 	"\n"
 	"efidebug boot add - set UEFI BootXXXX variable\n"
 	"  -b|-B <bootid> <label> <interface> <devnum>[:<part>] <file path>\n"
+	"  -d|-D <interface> <devnum>[:<part>] <device-tree file path>\n"
 	"  -i|-I <interface> <devnum>[:<part>] <initrd file path>\n"
-	"  (-b, -i for short form device path)\n"
+	"  (-b, -d, -i for short form device path)\n"
 #if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
 	"  -u <bootid> <label> <uri>\n"
 #endif
-- 
2.43.0

