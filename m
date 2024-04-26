Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F817C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3038C886B1;
	Fri, 26 Apr 2024 16:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="WJbHLRLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DCF188693; Fri, 26 Apr 2024 16:13:57 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BD52885FA
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A5130424AD
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714140832;
 bh=GbALgmVHL+0wQnCP5jjAKRdXoH+xnZ0i1B9JJwMmhjM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=WJbHLRLtaNN01ghQ16wki03tyO017VpFFvPamqLZxAJB3SwMSuBMB53OITOwQRjiZ
 3OAL7vao9lWxYxSfroL2gtDh4jNG+08+IpAi1XHlXmhJA+jRH0fY849LPPYWQ1iVew
 uCYVKSPBB5fJaJ4ptLSEKTBFNUsOt884uI6ytFj7eQtp9JkSigUHdqtH7ART1T+X7Q
 iXg9PSbqFi7LKFqZVI9cFarBnntEuxjNeJwm8XQRr4Ifd6aKZjbzUhQ/J4A1LBeCz8
 AxBg/IP1rAEipJdwQmDMSCcm5TPITIPUx7Q0+cQRdPadecIoxdYz3HPBA/XQvyWMX/
 cQunbKGgE/COw==
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2db6acacdacso19710051fa.0
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714140831; x=1714745631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GbALgmVHL+0wQnCP5jjAKRdXoH+xnZ0i1B9JJwMmhjM=;
 b=tuHHZ/ZXnp/1mi9vBeQaXGW39PO8V6qBZqXZRUj3J4R9Fdg2XiW9tf3h12334T6/Fw
 eBQEwDzWrOb0/2XFe7htXyrhiyk11C3soEuzyX+pr4x53CE1aZT4vwHTofnOzhXUorFQ
 Z7by93w3B/NuB63ILtaWsFcbWCqLx5BW7MXVp8+9iCKfHNMN+TMQN2F+a3BH16rAQxOa
 dZ2Z9m7APDen9h3B1BafZJg3vFS3HR1T9qktG+nsPUZMd4hrPXFuod6R2M3SUOK23ixe
 xCtjc+N2q/eCngDpGMKyHSFQzV8+WCiyT18CHVJ3eZByC4pl0KYob8Dk0b2WbDGrdP+P
 88mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIcFqdPvTaok37HgO0VfEtKhTSlBzqzV19BoHwpUOZQyE0a9AZgifuaGjG01DwTPm4Eg3McbG+aIww+rlhYtTLG+UOxQ==
X-Gm-Message-State: AOJu0YzQCpI5k+DyCB6oB3EKhoqPRTX3fBxcMSG2VKoTr8tcuXW+X52e
 qNE0ksOtX+j/529rK5jNo8IjrzCpaGYvxtpMADoKzz/SsKXb92cMDdyqSesddcond/c2dvXwptP
 sfqgY8DqzT90c3kyWgFgREwwrP7/IcSuR68K8jeZmEg/JGa1no3riMRv/iFszEEqNcX4=
X-Received: by 2002:a2e:8ed7:0:b0:2da:b1fc:7b8f with SMTP id
 e23-20020a2e8ed7000000b002dab1fc7b8fmr2310828ljl.9.1714140831443; 
 Fri, 26 Apr 2024 07:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs/5xPN1JGwxxLRVpvyrID0KM9YezFkMYQ4RZD6ceMqkouAvPqA4DmRcnk/M+eInxkU2e2Kw==
X-Received: by 2002:a2e:8ed7:0:b0:2da:b1fc:7b8f with SMTP id
 e23-20020a2e8ed7000000b002dab1fc7b8fmr2310804ljl.9.1714140830973; 
 Fri, 26 Apr 2024 07:13:50 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s20-20020adfa294000000b003455e5d2569sm1460593wra.0.2024.04.26.07.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:13:50 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 05/14] cmd: efidebug: add support for setting fdt
Date: Fri, 26 Apr 2024 16:13:12 +0200
Message-ID: <20240426141321.232236-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
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
---
 cmd/efidebug.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 93ba16efc7d..32c64711b6c 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -660,16 +660,33 @@ static int do_efi_show_tables(struct cmd_tbl *cmdtp, int flag,
  * @part:	disk partition
  * @file:	filename
  * @shortform:	create short form device path
+ * @fdt:	create path for device-tree
  * Return:	pointer to the device path or ERR_PTR
  */
 static
 struct efi_device_path *create_initrd_dp(const char *dev, const char *part,
-					 const char *file, int shortform)
+					 const char *file, bool shortform,
+					 bool fdt)
 
 {
 	struct efi_device_path *tmp_dp = NULL, *tmp_fp = NULL, *short_fp = NULL;
 	struct efi_device_path *initrd_dp = NULL;
 	efi_status_t ret;
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
 	const struct efi_initrd_dp id_dp = {
 		.vendor = {
 			{
@@ -696,7 +713,8 @@ struct efi_device_path *create_initrd_dp(const char *dev, const char *part,
 	if (!short_fp)
 		short_fp = tmp_fp;
 
-	initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
+	initrd_dp = efi_dp_concat((const struct efi_device_path *)
+				  (fdt ? &fdt_dp : &id_dp),
 				  short_fp);
 
 out:
@@ -796,6 +814,7 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 	struct efi_device_path *fp_free = NULL;
 	struct efi_device_path *final_fp = NULL;
 	struct efi_device_path *initrd_dp = NULL;
+	struct efi_device_path *fdt_dp = NULL;
 	struct efi_load_option lo;
 	void *data = NULL;
 	efi_uintn_t size;
@@ -860,6 +879,27 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 			argc -= 5;
 			argv += 5;
 			break;
+		case 'd':
+			shortform = 1;
+			fallthrough;
+		case 'D':
+			if (argc < 3 || fdt_dp) {
+				r = CMD_RET_USAGE;
+				goto out;
+			}
+
+			fdt_dp = create_initrd_dp(argv[1], argv[2], argv[3],
+						  shortform, true);
+			if (!fdt_dp) {
+				printf("Cannot add a device-tree\n");
+				r = CMD_RET_FAILURE;
+				goto out;
+			}
+			argc -= 3;
+			argv += 3;
+			fp_size += efi_dp_size(fdt_dp) +
+				sizeof(struct efi_device_path);
+			break;
 		case 'i':
 			shortform = 1;
 			/* fallthrough */
@@ -870,7 +910,7 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 			}
 
 			initrd_dp = create_initrd_dp(argv[1], argv[2], argv[3],
-						     shortform);
+						     shortform, false);
 			if (!initrd_dp) {
 				printf("Cannot add an initrd\n");
 				r = CMD_RET_FAILURE;
@@ -929,6 +969,15 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 		}
 	}
 
+	if (fdt_dp) {
+		final_fp = efi_dp_merge(final_fp, &fp_size, fdt_dp);
+		if (!final_fp) {
+			printf("Cannot create final device path\n");
+			r = CMD_RET_FAILURE;
+			goto out;
+		}
+	}
+
 	lo.file_path = final_fp;
 	lo.file_path_length = fp_size;
 
@@ -952,6 +1001,7 @@ out:
 	free(data);
 	efi_free_pool(final_fp);
 	efi_free_pool(initrd_dp);
+	efi_free_pool(fdt_dp);
 	efi_free_pool(fp_free);
 	free(lo.label);
 
@@ -1014,7 +1064,8 @@ static int do_efi_boot_rm(struct cmd_tbl *cmdtp, int flag,
  */
 static void show_efi_boot_opt_data(u16 *varname16, void *data, size_t *size)
 {
-	struct efi_device_path *initrd_path = NULL;
+	struct efi_device_path *fdt_path;
+	struct efi_device_path *initrd_path;
 	struct efi_load_option lo;
 	efi_status_t ret;
 
@@ -1043,6 +1094,12 @@ static void show_efi_boot_opt_data(u16 *varname16, void *data, size_t *size)
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
@@ -1570,8 +1627,9 @@ U_BOOT_LONGHELP(efidebug,
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

