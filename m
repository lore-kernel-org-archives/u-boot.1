Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7558EC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 04:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 675A68778B;
	Fri, 10 Nov 2023 05:28:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KUs4iRV1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07A398779F; Fri, 10 Nov 2023 05:27:56 +0100 (CET)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B2B387783
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 05:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7b9bd9f8bfaso661748241.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 20:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699590457; x=1700195257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=si9i4cdutpBbC+26YE8jjQg39hK8ZliLEIT6vpdk+so=;
 b=KUs4iRV15N4vv8nmu+bQA+KFdlCmjYdRSie9hidytzUEmS6uMT+2Oz4RnqYAQ0e40H
 Zk2nTx68aNEveIRZOTnsG7w50AnB/6jr3O59DMuJjov+TCPL8/HkEKJbfz5UzO9+L0cd
 r2rs9TP9SuNxZxXxDfllTTnw2shC/cSMrkEiV4pjR4DvFzFffhmhqvC9BPtKY1VfD+Fu
 DP7xWuMqnaK1JHgGg8ZTOX0+Ik+DKtXxiZ/xPSKskX1Tlsdd6WfLxWJdjZBxAQgsBjfr
 fV9ykbB+z01MnINEXWqLaxqK7nX2YBJ25dYTsF4HG0q9MvrU02cWf4UifSvNNHbHnYhE
 OYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699590457; x=1700195257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=si9i4cdutpBbC+26YE8jjQg39hK8ZliLEIT6vpdk+so=;
 b=rdE7Li88XfQ8qbZ2aAMiuUImhTvl4nW28jxKrLpX9zx5q0MJ+4f+a4LKz5Q0V9Nkfn
 FfKEmnIFk94ALS5RqeIDguATsIkv3o0rlEPUFC820pinGVJohlnELt4ZyBIdGHOG44fA
 6plZ7nQLKoqdeGcmUICQMRuv4ggOSjMB3CHjyd+6LsJxZISjwhp7rFGWyg2SWKoGy61q
 weMjCp3g/BFmFGtE48s7Ey1xKJfU6OVaq6/h7nL/fqrN32zELwVAvztY2HG3feHKc89z
 URyvl+ie0PxdJhac+NjaMDfqRE7l3LCNNfVRY/8K9HCgZDE88DG/VHAlSYWjMxKEqZHz
 snVg==
X-Gm-Message-State: AOJu0YzIZSA+auyjofOmQev9CfRENknb4JnzthQLEXdl8KVEqyG347sz
 SynUWXh98a7Nl5FZmjc6zmY4SdKLmCTO3mOnjp0=
X-Google-Smtp-Source: AGHT+IExNkO6Ndn48UP/EAWb/FJpDLA19NocqRfx9sZ3KCsyGVMAA6UPYLqWQUmsY0Yj1y+NefFNQw==
X-Received: by 2002:a67:e149:0:b0:45f:75e0:131e with SMTP id
 o9-20020a67e149000000b0045f75e0131emr6823998vsl.33.1699590457531; 
 Thu, 09 Nov 2023 20:27:37 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 h19-20020a170902f7d300b001c8836a3795sm4337016plw.271.2023.11.09.20.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 20:27:36 -0800 (PST)
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
Subject: [PATCH v12 8/9] cmd: efidebug: add uri device path
Date: Fri, 10 Nov 2023 13:25:41 +0900
Message-Id: <20231110042542.3797301-9-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
References: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
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
 cmd/efidebug.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/net.h  |  8 ++++++
 net/wget.c     | 71 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 201531ac19..78ef16f4cb 100644
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
@@ -707,6 +708,65 @@ out:
 	return initrd_dp;
 }
 
+/**
+ * efi_boot_add_uri() - set URI load option
+ *
+ * @argc:		Number of arguments
+ * @argv:		Argument array
+ * @var_name16:		variable name buffer
+ * @var_name16_size:	variable name buffer size
+ * @lo:			pointer to the load option
+ * @file_path:		buffer to set the generated device path pointer
+ * @fp_size:		file_path size
+ * Return:		CMD_RET_SUCCESS on success,
+ *			CMD_RET_USAGE or CMD_RET_RET_FAILURE on failure
+ */
+static int efi_boot_add_uri(int argc, char *const argv[], u16 *var_name16,
+			    size_t var_name16_size, struct efi_load_option *lo,
+			    struct efi_device_path **file_path,
+			    efi_uintn_t *fp_size)
+{
+	int id;
+	char *pos;
+	char *endp;
+	u16 *label;
+	efi_uintn_t uridp_len;
+	struct efi_device_path_uri *uridp;
+
+	if (argc < 3 || lo->label)
+		return CMD_RET_USAGE;
+
+	id = (int)hextoul(argv[1], &endp);
+	if (*endp != '\0' || id > 0xffff)
+		return CMD_RET_USAGE;
+
+	label = efi_convert_string(argv[2]);
+	if (!label)
+		return CMD_RET_FAILURE;
+
+	if (!wget_validate_uri(argv[3])) {
+		printf("ERROR: invalid URI\n");
+		return CMD_RET_FAILURE;
+	}
+
+	efi_create_indexed_name(var_name16, var_name16_size, "Boot", id);
+	lo->label = label;
+
+	uridp_len = sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
+	uridp = efi_alloc(uridp_len + sizeof(END));
+	uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
+	uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
+	uridp->dp.length = uridp_len;
+	strcpy(uridp->uri, argv[3]);
+	pos = (char *)uridp + uridp_len;
+	memcpy(pos, &END, sizeof(END));
+
+	*file_path = &uridp->dp;
+	*fp_size += uridp_len + sizeof(END);
+
+	return CMD_RET_SUCCESS;
+}
+
 /**
  * do_efi_boot_add() - set UEFI load option
  *
@@ -829,6 +889,21 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 			argc -= 1;
 			argv += 1;
 			break;
+		case 'u':
+			if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT)) {
+				r = efi_boot_add_uri(argc, argv, var_name16,
+						     sizeof(var_name16), &lo,
+						     &file_path, &fp_size);
+				if (r != CMD_RET_SUCCESS)
+					goto out;
+				fp_free = file_path;
+				argc -= 3;
+				argv += 3;
+			} else{
+				r = CMD_RET_USAGE;
+				goto out;
+			}
+			break;
 		default:
 			r = CMD_RET_USAGE;
 			goto out;
@@ -1491,6 +1566,9 @@ U_BOOT_LONGHELP(efidebug,
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

