Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEC9EE6454
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 10:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53EF386900;
	Fri, 15 Sep 2023 12:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eNJP4UWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99DD586900; Fri, 15 Sep 2023 12:18:07 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73E9886906
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 12:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3ab3aceaf2aso1168524b6e.2
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 03:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694773083; x=1695377883; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LWiqwehaOJfaSmRgwHlzxULDaEEZ5775jRQ1ZEyTgk=;
 b=eNJP4UWFg3MAd/bdMq19PDu5HrjTqepyaXI8JiCeesInuUrCHCqtpPvqM8axt1DASl
 IHyZP/2KK7LywvtS/qwXW6X192Tg/DHkBULXtqEM1tkr95WaMqikVvRCLoH6j7rqQ7LD
 ERwwUR9TkZpsywn9TsYBlM9HF3g01BLHWFLVoumGoGQz5LuBzHtTA63JKiztjPWMLTgO
 0Fes0FIL1c36MSjfphWDaAE8VPgKXm+3rWanS1BH5s4xbDHmZUL94mK9f9kJQtrJzSFd
 E+ufZ3slxD0/DPfCO2ifKvMJke9zRF02cwmUZkf+wx/N8qQw4QcWpfS85gmANNuEUxWM
 nBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694773083; x=1695377883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2LWiqwehaOJfaSmRgwHlzxULDaEEZ5775jRQ1ZEyTgk=;
 b=BiM7aDteQRYYDDGMRQ1/VQtOWY9wKrKj6guCEwgOcISO/N2wGQh0+1gjxoywEftrV5
 sdB28GqxDXQOSKfSAyBpWfkWt27oRY/lhTYTz+Kiug7Iv8lUVWkZ5WvXZ5E6VC3QuTDA
 Rh7RqghJ9I0sgLyLS5t7PuHbbDodft5OmzhXyZkj5rJM2+lGtSaa1bVjniSS7RcCZDVc
 Nk1VZvatqLfasNUhHg3SG6vYpoGY8bdRgxBu4NP28T5KwUEB3rQi6hcJQzy+xoyiyjRA
 Phzw95sBrJKpqqxBB7rqT77t0e5fluhKcTwDit8Nv8lO8BR8TMuHWa2PVFviWz/O0a/J
 /Ucw==
X-Gm-Message-State: AOJu0Yz+eBZxUyK3XXM3n3tXQiS7f/QYYzwXQ08ahFF8c8K9qRlADzyg
 OpbQzHMSo8G/Tp9Cmk/HNrxa/kNxbO4DBclSyH0=
X-Google-Smtp-Source: AGHT+IH0VcxqZsjuwgHrpRtt/mcWUQOH6+lQJmbVbzcw9CkQqGn6sa6y84GF9X/3g/iGIC5N/dhGsg==
X-Received: by 2002:a05:6808:242:b0:3a8:43c6:3cf with SMTP id
 m2-20020a056808024200b003a843c603cfmr1064408oie.57.1694773083579; 
 Fri, 15 Sep 2023 03:18:03 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 i16-20020aa78b50000000b0068883728c16sm2782583pfd.144.2023.09.15.03.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 03:18:02 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v3 6/7] cmd: efidebug: add uri device path
Date: Fri, 15 Sep 2023 19:16:39 +0900
Message-Id: <20230915101640.1166332-7-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915101640.1166332-1-masahisa.kojima@linaro.org>
References: <20230915101640.1166332-1-masahisa.kojima@linaro.org>
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
 include/net.h  |  1 +
 net/wget.c     | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)

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
index b9cba5244a..4b42672070 100644
--- a/include/net.h
+++ b/include/net.h
@@ -927,5 +927,6 @@ static inline void eth_set_enable_bootdevs(bool enable) {}
 #endif
 
 int wget_with_dns(ulong dst_addr, char *uri);
+bool wget_validate_uri(char *uri);
 
 #endif /* __NET_H__ */
diff --git a/net/wget.c b/net/wget.c
index bdf940a315..0bc0bf33bb 100644
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

