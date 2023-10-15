Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1AACDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 23:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E78D86DE8;
	Mon, 16 Oct 2023 01:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PhvjuYgJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C9E6867F6; Mon, 16 Oct 2023 01:51:30 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE80086AE9
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 01:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c88b467ef8so26463245ad.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 16:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697413859; x=1698018659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ix7OkLuT2UMlsZ+CYDlpWbnES/L/lF+FUZtbgDuoIRo=;
 b=PhvjuYgJLU2ytdZOqlM+5TCppOA3hSTebD0bpENYOEjAcOIgJiQEhtv8aXsnrIaKIh
 5UOYsvu77ir3mLWdZmFq5cXGqsrL+QRPS01cM3XRdgbSVgdb53iEWyVSY7OQmHydzqf/
 lhyBQOgNkta6EFmaVIwfRFH8D+TVCjcwJoV8ThUOM46lBs6VV9sRVLUZ24jwhpnQk/D+
 iqlo5TPzuelTfuTdGEo1x60ytNX/f7d4ItrtZp3JG2bOIqWpKQrOCcjuuX2tPr3NUG3f
 uBavR5b2l6mbFsyt4+Qp2P85/KkZGMLIhdC5v9I80nKTCOyHcA1ihm6Pm+JgJeOAVLpn
 uTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697413859; x=1698018659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ix7OkLuT2UMlsZ+CYDlpWbnES/L/lF+FUZtbgDuoIRo=;
 b=FivuVcnBC/wvVIUHdJkfeAFR+VLO4aM4vofYMTj2380vbWCoLHCGNtTF7VbIY3yjJn
 oAMzTLxuynrX9f4xc7tcAG6aHNHP+qLXzG2Y+aL6IOzBDI5FzxYLPcuY9ax03c/darji
 Dsk5YNzZy32x0aBAk5pjf03/KjWJiWBt8/8Zj2uPiwOJBdTjoR1sP7NLIegGOaMy+pvi
 LNumXfYxX3A9QbjbtfU8tDTdpHv0p98J1OuYqD+yeN879oinbCJf3fewH4xc0+VeWvqP
 znD2U4oPzDkhDAyVfzsizpncLdV/vWbC0TZ9XLmP1CrqHyI7q3wTTRzW7Cow5zmnkxkU
 kO7Q==
X-Gm-Message-State: AOJu0Yy+lrgDsC8EdHWFIG2KjrhEGbSfy5MtHC1z0kRz03XdzITIisIV
 9ef4rlYjtI92plv1+v9Y+tKaIBKNS68P7abeFn0=
X-Google-Smtp-Source: AGHT+IFtPgc5x6XCEvutEiSTWvFh4QSgXGkKdDPQ6Gtix+LwwRmr843JazgCXEUvZyT5m8/bnOJxOg==
X-Received: by 2002:a17:903:cb:b0:1ca:7dcf:a74 with SMTP id
 x11-20020a17090300cb00b001ca7dcf0a74mr836146plc.22.1697413859187; 
 Sun, 15 Oct 2023 16:50:59 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 i18-20020a170902eb5200b001bdeedd8579sm7206879pli.252.2023.10.15.16.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 16:50:58 -0700 (PDT)
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
Subject: [PATCH v6 8/9] cmd: efidebug: add uri device path
Date: Mon, 16 Oct 2023 08:49:06 +0900
Message-Id: <20231015234907.2362717-9-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231015234907.2362717-1-masahisa.kojima@linaro.org>
References: <20231015234907.2362717-1-masahisa.kojima@linaro.org>
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
 net/wget.c     | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 0be3af3e76..5f392d2ffd 100644
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

