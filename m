Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFB6E810B1
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D28386DBC;
	Wed, 27 Sep 2023 11:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hwhtFUgY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D21286DC5; Wed, 27 Sep 2023 11:37:54 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F129A86DC1
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-690bf8fdd1aso8455688b3a.2
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695807470; x=1696412270; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oaMDGqRnc0d/jvmwKTYWFSifA73Ii6B1GLrcLxcteYI=;
 b=hwhtFUgY4+7K5wDQgIORKkhKWN8wj3zfQY5Uy8BSa8+g7Bw9VgDzCkSJGNUsJAaAsq
 rj1e0/FwzG1E5SCZXe07y2LpP457d0pyaXG9wUNPy1bYoYJ1cpTpm5JVsYw0HJ+augGR
 tzABRC0+Zw+6rxE5o2R7h7qk6HQjesejbwG0eARjaq10swY5VYZYuFoeuxbVMe2J8B6B
 H1WoDpDtbhfUuvAB+7eXlX+472D8QrjJGfV1m0qTdq5hJq7dso4tMnP20BU7PTlDQQ6k
 U5kCmYFljQkBEdjVZic6nRnQkRdGpUAwvBxzrCLeNJfDieEg4OfGFqxAgXjdOgKeZwwC
 xnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695807470; x=1696412270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oaMDGqRnc0d/jvmwKTYWFSifA73Ii6B1GLrcLxcteYI=;
 b=F1VqEuNo/r1WvewQhBq88WVUELhMJsgrB0ArayhtgTKfWzTIddg2A8dU5NTLHr9F7D
 ZK34QX5jg0qlxlxk0F9vpBzOsbJIOr5AUxQqk+9ODDaFptI9gT9c0hPBW6+NJv/FUaWc
 XJoAiGEpGZnwSw2qHGo8Z94F5NNeaNHPoMCX4Yc62xFjmPTbjafNRZtI5LxQclNN2gZl
 Oyuf/kqiVN2ixV4p9pwIDnaEvRmLDZ8CMJdW0HwEvRsqVaNxxiAxH5pb97GvFLkT3uzo
 pPR6vF1B9hkINmnGpG/l1nhV7C6++jelCur3Zl8NQB1Ql+CvqZNfDDBrSSSTaxRtZPo5
 BU8w==
X-Gm-Message-State: AOJu0YznTSma7dC7DuIDm+8glKJnIkSpb9e19jW+LSrOF2gsaR+K1EGj
 69sD98NQhupbOCQOxww9JrzhspnVo+TWbv3pqHE=
X-Google-Smtp-Source: AGHT+IHnkQLvrsqvCkC4HXWdksoDVvaWMEr7CdK8HKV0Sakepmg/g05YdUwyAoTFAx7wbAOdfXMqPg==
X-Received: by 2002:a05:6a00:2e86:b0:68b:e29c:b61 with SMTP id
 fd6-20020a056a002e8600b0068be29c0b61mr1520886pfb.19.1695807469955; 
 Wed, 27 Sep 2023 02:37:49 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 x18-20020a62fb12000000b0068fe6ad4e18sm11396151pfm.157.2023.09.27.02.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 02:37:49 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v5 5/7] cmd: efidebug: add uri device path
Date: Wed, 27 Sep 2023 18:36:29 +0900
Message-Id: <20230927093631.1595494-6-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
References: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
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

