Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6262FE7D0D6
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 07:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ABD286925;
	Fri, 22 Sep 2023 09:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZkhDLqMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9DE886290; Fri, 22 Sep 2023 09:12:25 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A124886996
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 09:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-690bccb0d8aso1462480b3a.0
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 00:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695366742; x=1695971542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oaMDGqRnc0d/jvmwKTYWFSifA73Ii6B1GLrcLxcteYI=;
 b=ZkhDLqMcK4w9S1BiGKge44xVGqpnWODV/tmEQ9WaWUpid7rvA8UW/kiABpxZ3CTviT
 fInoQU9EW3SafTALO6/MjaeqzP0Es8do2DC8bsN763bUqk8DzlxhXpopqmzPTP3mtXkM
 YytdFPPTUFzhMGWpXnSYcGf6iLPGHAG0RUSL4TsyrYv63CObtm1TMl1ZOqDlo9QNBgAe
 aanDueUwJ94PM1ghDWccuSm6yod7grhtQbUEWa59UQRjFjhJM9t+9GOrn8c0RZnCMc2F
 I8WT3OYhuHOucegbmJEPLxdo1GbXxnssXkHTV8nq8bqiSFKHYQ2lZ6pS/HQxbK9x3cuX
 rMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695366742; x=1695971542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oaMDGqRnc0d/jvmwKTYWFSifA73Ii6B1GLrcLxcteYI=;
 b=PHHy8KV7eHprYy0VE4bvPY4LlhSjRhHeRqOFhTWTnPH6grICvpX4Y/LvVsbvtpCGSt
 WUYeNpodYFsrKL3imUGxEx4YZG8EwLCI9Hdk47t3WVwt8uKrghW64kPKAetJSQHh6aRq
 NhKsRzcaVgUEHfWkgF45JAmQVU1viInTqjItAvopEiQZvELHRZkdTFg/xGAVwWl7zUEQ
 qVTt1GkB75EiB3gPruPRALVjrjTK3bzlfr3HEDKR2VQDA+0J+UHxsZzIYxZHgbOW3Pwo
 Jqk/cTkzb+KFGR9qOhrChx+b7Cv9pfVMVc8jyh9qAhha+SZ20eUXU1ocX94iRH45t3uY
 os3Q==
X-Gm-Message-State: AOJu0YzvtzFT3WlaXU9LpbvQnGDr0FwIAPdL7lpceAdeUOFoVuJeEGnv
 qpU06wWPnr7douPDQUhE2E0YqOaU4k4gy+mh1x4=
X-Google-Smtp-Source: AGHT+IFQVHlqeoMGesZwNuuHhERYH72UvVugJ2c2iqMzgGD0Rn65/+h0nyz0joGplfnu3jdjVvqMQg==
X-Received: by 2002:a05:6a20:1585:b0:13e:9dba:ea52 with SMTP id
 h5-20020a056a20158500b0013e9dbaea52mr9141686pzj.13.1695366741750; 
 Fri, 22 Sep 2023 00:12:21 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 17-20020a17090a001100b00276a58e37c1sm4545333pja.38.2023.09.22.00.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 00:12:21 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v4 6/8] cmd: efidebug: add uri device path
Date: Fri, 22 Sep 2023 16:11:17 +0900
Message-Id: <20230922071119.1439482-7-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
References: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
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

This adds the URI device path option for 'boot add' subcommand.
User can add the URI load option for downloading ISO image file
or EFI application through network. Currently HTTP is only supported.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 cmd/efidebug.c | 50 +++++++++++++++++++++++++++++++++++
 include/net.h  |  8 ++++++
 net/wget.c     | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 0be3af3e76..f2fd6ba71d 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -19,6 +19,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <mapmem.h>
+#include <net.h>
 #include <part.h>
 #include <search.h>
 #include <linux/ctype.h>
@@ -829,6 +830,52 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 			argc -= 1;
 			argv += 1;
 			break;
+#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENABLED(CONFIG_CMD_DNS))
+		case 'u':
+		{
+			char *pos;
+			int uridp_len;
+			struct efi_device_path_uri *uridp;
+
+			if (argc <  3 || lo.label) {
+				r = CMD_RET_USAGE;
+				goto out;
+			}
+			id = (int)hextoul(argv[1], &endp);
+			if (*endp != '\0' || id > 0xffff)
+				return CMD_RET_USAGE;
+
+			efi_create_indexed_name(var_name16, sizeof(var_name16),
+						"Boot", id);
+
+			label = efi_convert_string(argv[2]);
+			if (!label)
+				return CMD_RET_FAILURE;
+			lo.label = label;
+
+			uridp_len = sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
+			fp_free = efi_alloc(uridp_len + sizeof(END));
+			uridp = (struct efi_device_path_uri *)fp_free;
+			uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
+			uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
+			uridp->dp.length = uridp_len;
+			if (!wget_validate_uri(argv[3])) {
+				printf("ERROR: invalid URI\n");
+				r = CMD_RET_FAILURE;
+				goto out;
+			}
+
+			strcpy(uridp->uri, argv[3]);
+			pos = (char *)uridp + uridp_len;
+			memcpy(pos, &END, sizeof(END));
+			fp_size += uridp_len + sizeof(END);
+			file_path = (struct efi_device_path *)uridp;
+			argc -= 3;
+			argv += 3;
+			break;
+		}
+#endif
+
 		default:
 			r = CMD_RET_USAGE;
 			goto out;
@@ -1492,6 +1539,9 @@ static char efidebug_help_text[] =
 	"  -b|-B <bootid> <label> <interface> <devnum>[:<part>] <file path>\n"
 	"  -i|-I <interface> <devnum>[:<part>] <initrd file path>\n"
 	"  (-b, -i for short form device path)\n"
+#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENABLED(CONFIG_CMD_DNS))
+	"  -u <bootid> <label> <uri>\n"
+#endif
 	"  -s '<optional data>'\n"
 	"efidebug boot rm <bootid#1> [<bootid#2> [<bootid#3> [...]]]\n"
 	"  - delete UEFI BootXXXX variables\n"
diff --git a/include/net.h b/include/net.h
index 57889d8b7a..c748974573 100644
--- a/include/net.h
+++ b/include/net.h
@@ -935,4 +935,12 @@ static inline void eth_set_enable_bootdevs(bool enable) {}
  */
 int wget_with_dns(ulong dst_addr, char *uri);
 
+/**
+ * wget_validate_uri() - varidate the uri
+ *
+ * @uri:	uri string of target file of wget
+ * Return:	true if uri is valid, false if uri is invalid
+ */
+bool wget_validate_uri(char *uri);
+
 #endif /* __NET_H__ */
diff --git a/net/wget.c b/net/wget.c
index 4801e28eb9..6a4d22be32 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -558,3 +558,75 @@ out:
 	return ret;
 }
 #endif
+
+/**
+ * wget_validate_uri() - validate the uri for wget
+ *
+ * @uri:	uri string
+ * Return:	true on success, false on failure
+ */
+bool wget_validate_uri(char *uri)
+{
+	char c;
+	bool ret = true;
+	char *str_copy, *s, *authority;
+
+	/* TODO: strict uri conformance check */
+
+	/*
+	 * Uri is expected to be correctly percent encoded.
+	 * This is the minimum check, control codes(0x1-0x19, 0x7F, except '\0')
+	 * and space character(0x20) are not allowed.
+	 */
+	for (c = 0x1; c < 0x21; c++) {
+		if (strchr(uri, c)) {
+			printf("invalid character is used\n");
+			return false;
+		}
+	}
+	if (strchr(uri, 0x7f)) {
+		printf("invalid character is used\n");
+		return false;
+	}
+
+	/*
+	 * This follows the current U-Boot wget implementation.
+	 * scheme: only "http:" is supported
+	 * authority:
+	 *   - user information: not supported
+	 *   - host: supported
+	 *   - port: not supported(always use the default port)
+	 */
+	if (strncmp(uri, "http://", 7)) {
+		printf("only http:// is supported\n");
+		return false;
+	}
+	str_copy = strdup(uri);
+	if (!str_copy)
+		return false;
+
+	s = str_copy + strlen("http://");
+	authority = strsep(&s, "/");
+	if (!s) {
+		printf("invalid uri, no file path\n");
+		ret = false;
+		goto out;
+	}
+	s = strchr(authority, '@');
+	if (s) {
+		printf("user information is not supported\n");
+		ret = false;
+		goto out;
+	}
+	s = strchr(authority, ':');
+	if (s) {
+		printf("user defined port is not supported\n");
+		ret = false;
+		goto out;
+	}
+
+out:
+	free(str_copy);
+
+	return ret;
+}
-- 
2.34.1

