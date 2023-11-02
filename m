Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C07C4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 06:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8F4B86E88;
	Thu,  2 Nov 2023 07:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CJ2Ferjw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3BA3876FC; Thu,  2 Nov 2023 07:46:48 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54D6D8770D
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 07:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3add37de892so337618b6e.1
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 23:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698907604; x=1699512404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3tGXQ7IJXQZQ/S0nkhUtkKMN2OsrFTTbgmtRgH9/3w=;
 b=CJ2FerjwOd3eZi7TJNkogf35MD5KdL/YjkUNLLP14VhrwjQwrClL2+fhHJAAa3esIK
 J6jqF9Dv63r0LrjlodEhXfviffzPDpLO359SmQSwKRcOwP2VnxtGo7x8IUU7uxYi5QyJ
 Oh4FD26+iVBJT5Z6JCPzuIRuNxuCs10Sip6sweQBzZp8rKiP3IUKokPj2iBcLdjPMsrr
 2Md21CX5w9HiycjhzSVTaUR3PZUUM5yEltUh0PXu9+PWp+A3RtdVNoI5vdz9vSnR/0cr
 qstSezulRTDn0mfV4n4IdU/hLMZ3yRVKW7CEHjRFt4iFc9q6El1zeSX8rf3P+xbbrXtC
 noHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698907604; x=1699512404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3tGXQ7IJXQZQ/S0nkhUtkKMN2OsrFTTbgmtRgH9/3w=;
 b=j0YcYVo3AtQIISNIgOJagcfqJ79prY1Q+ssmu7NBBSkZiyYONZp9j++eW2s4VjcwYX
 Z1rd+WYxMn6PjJTBxyJAByCjYfvksjvPlktPQmCOq/cQv0keZfGOMk/zE5meVWm+JYtj
 7rD7MbmxQub47EsNvwn7XC1s8aKxrGcAnRULZ62GW2wy3yFHkQ3Fs909KIOplUZMDK4Z
 GM47lAjifDKLYgNbH2WP5RetdHHs0xgpxVvdt9JByQr8zSAiojyQSu0+hgEv318Q3b8u
 Sj1AFpuNyVSfRYMOTeb0D/jxW1mKZOcG/iU33LOppo8j1W4AJmPXxCzd33e2X9CrtSQi
 ynng==
X-Gm-Message-State: AOJu0YylBXA9Jf1kGfiJPUnKUeE5bXf8Q1I0fqJu+tilWTAosB9tKuF+
 IU0rLWfVVx+2L1VjpHMb053Hbk/vnxVeKOn3UnU=
X-Google-Smtp-Source: AGHT+IEFYkcl8c8ggce1lc2sIoI2YMFHP2P2g5P4p5SGeOqV8bH5HLKZ1cEfVqTNOv9S2RCbJGuEyg==
X-Received: by 2002:a05:6808:14d1:b0:3ab:8956:ada4 with SMTP id
 f17-20020a05680814d100b003ab8956ada4mr19819338oiw.10.1698907604408; 
 Wed, 01 Nov 2023 23:46:44 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 q17-20020a62ae11000000b006b4ca26f3c9sm2196052pff.74.2023.11.01.23.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 23:46:43 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v9 8/9] cmd: efidebug: add uri device path
Date: Thu,  2 Nov 2023 15:44:58 +0900
Message-Id: <20231102064459.3466953-9-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102064459.3466953-1-masahisa.kojima@linaro.org>
References: <20231102064459.3466953-1-masahisa.kojima@linaro.org>
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
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 cmd/efidebug.c | 51 ++++++++++++++++++++++++++++++++++++
 include/net.h  |  8 ++++++
 net/wget.c     | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 201531ac19..42b306e708 100644
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
@@ -829,6 +830,53 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 			argc -= 1;
 			argv += 1;
 			break;
+#if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
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
+
+			id = (int)hextoul(argv[1], &endp);
+			if (*endp != '\0' || id > 0xffff)
+				return CMD_RET_USAGE;
+
+			label = efi_convert_string(argv[2]);
+			if (!label)
+				return CMD_RET_FAILURE;
+
+			if (!wget_validate_uri(argv[3])) {
+				printf("ERROR: invalid URI\n");
+				r = CMD_RET_FAILURE;
+				goto out;
+			}
+
+			efi_create_indexed_name(var_name16, sizeof(var_name16),
+						"Boot", id);
+			lo.label = label;
+
+			uridp_len = sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
+			fp_size += uridp_len + sizeof(END);
+			fp_free = efi_alloc(fp_size);
+			uridp = (struct efi_device_path_uri *)fp_free;
+			uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
+			uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
+			uridp->dp.length = uridp_len;
+			strcpy(uridp->uri, argv[3]);
+			pos = (char *)uridp + uridp_len;
+			memcpy(pos, &END, sizeof(END));
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
@@ -1491,6 +1539,9 @@ U_BOOT_LONGHELP(efidebug,
 	"  -b|-B <bootid> <label> <interface> <devnum>[:<part>] <file path>\n"
 	"  -i|-I <interface> <devnum>[:<part>] <initrd file path>\n"
 	"  (-b, -i for short form device path)\n"
+#if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
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
index 2087146b37..6ae2237a0a 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -566,3 +566,74 @@ out:
 	return ret;
 }
 #endif
+
+/**
+ * wget_validate_uri() - validate the uri for wget
+ *
+ * @uri:	uri string
+ *
+ * This function follows the current U-Boot wget implementation.
+ * scheme: only "http:" is supported
+ * authority:
+ *   - user information: not supported
+ *   - host: supported
+ *   - port: not supported(always use the default port)
+ *
+ * Uri is expected to be correctly percent encoded.
+ * This is the minimum check, control codes(0x1-0x19, 0x7F, except '\0')
+ * and space character(0x20) are not allowed.
+ *
+ * TODO: stricter uri conformance check
+ *
+ * Return:	true on success, false on failure
+ */
+bool wget_validate_uri(char *uri)
+{
+	char c;
+	bool ret = true;
+	char *str_copy, *s, *authority;
+
+	for (c = 0x1; c < 0x21; c++) {
+		if (strchr(uri, c)) {
+			log_err("invalid character is used\n");
+			return false;
+		}
+	}
+	if (strchr(uri, 0x7f)) {
+		log_err("invalid character is used\n");
+		return false;
+	}
+
+	if (strncmp(uri, "http://", 7)) {
+		log_err("only http:// is supported\n");
+		return false;
+	}
+	str_copy = strdup(uri);
+	if (!str_copy)
+		return false;
+
+	s = str_copy + strlen("http://");
+	authority = strsep(&s, "/");
+	if (!s) {
+		log_err("invalid uri, no file path\n");
+		ret = false;
+		goto out;
+	}
+	s = strchr(authority, '@');
+	if (s) {
+		log_err("user information is not supported\n");
+		ret = false;
+		goto out;
+	}
+	s = strchr(authority, ':');
+	if (s) {
+		log_err("user defined port is not supported\n");
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

