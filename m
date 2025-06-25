Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FBCC7115C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B511582E08;
	Wed, 25 Jun 2025 15:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mK59m9Vp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6F6A82D83; Wed, 25 Jun 2025 15:21:42 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E1F082E40
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a6d1369d4eso1099968f8f.2
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750857692; x=1751462492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+m7C3uVBIMXLlK/DLH6/183foU3i6sc+JArGralzAU=;
 b=mK59m9Vp6B8a5Wf7NXb6772dmdAjpjHRNiPwzn2RFY3lBeZBLsAmnHMNa+7szwtR3f
 UhvU4bLf+ZgHRmGZ6DMWCLJevSwxn28zza3TLUdfYiHpcu6OFjAaOhFkbM3Ds7Dgbti2
 NSV5/klSZc9Tg1cYROS3CX+iM0yGar+9MUzodeEEW1N4HzJgk9jQc8gTIiTqfu17eZcC
 UMNzK2irGNnCh8BQnM3gr/hOAmDRkYH1zm9FJMErSBJ9IfjOYC4CJG03hpPrzb440zmY
 nIL0+OA3tF4cyVRirQvSF2aLnDVFdVyh4ivVRXWlRVScDnQj7IFqlAN711uC2seSXxHW
 NnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750857692; x=1751462492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+m7C3uVBIMXLlK/DLH6/183foU3i6sc+JArGralzAU=;
 b=Dzzh9GoAyvsGlVVqiaqug8aysasdi1izEzx18b3JQxwJf+JdJi9mbI9KXjUr42pzvP
 kvvJ/0Y51N1pj96+8Rs/LXtJyYldyEgcz6btCVQqh3ODenHNOO8PmViSju2/yLSmmUhf
 1lJADBQxBubZ7a2YXM/fV4PVzIxVPvEeNXwgVUfWofTf5aTAreZY2HT3PloMcSTkD6ir
 Zy3UOYodk9F2fomPN2dsOZU5r6jTfzYEfao2qbvqkl+l1sa9mIF4P4fKNAjkbCGonPYe
 5sV8KPN27CzP0UWj3Zt4DNfdK6CGej7McXmgk4BAGph4Mpw4nAfkhKo2G4Il+MsbY7gj
 rlfQ==
X-Gm-Message-State: AOJu0Yx8pTj+V5hA2vQACIUoLASBWOLshfa/qvKogn8mDUpoSKRLMomJ
 d4BCfPklHr3BCoVBtb81U7L6r47HtIBS2aKi6q3ASD57+DLzXkeKhXpKrUrndEGG/VKUxfhW0NJ
 BAg82xp8=
X-Gm-Gg: ASbGncvIm0rQeMRA/oGpPlzYCIi0QB+SAU1gRzxN4jNf4Lhxrfa6ryu6YAK8o7WmioO
 ++HT9dFpCvsn9nohditT8qvF5xGRE2pxOnRue/MincmuiEgVqYDpMjTOOM/HjWdP2FsoDQQi7gZ
 ZoLLYz6OvXQPxS8cah12C7r3XfJjdHuYPuqGHzPOOEHCSxiHz0/ASTjTiz9jVHg8C+xwxMuUmel
 tWkESdEaJAI4s9qari61Q/utlj2+5peHl0fUNNkVf/S2kcdNY90lW1Y5bQp+W+mJ+QmQbj5Kmm9
 tDzh2QosZCG4kt+4ZqonBkqw33Zm5zN5hghXQovOEmwGMctO4pvlQG4D1v/B1KGbZmJofFc=
X-Google-Smtp-Source: AGHT+IGDw4PFcKn5mxs1AXZ/ur8IJVi4QAp+1wSzewWBQHzUWMAmqhSGcib+9ymiaXLdYHYjxZgP8A==
X-Received: by 2002:a05:6000:650:b0:3a4:df80:7284 with SMTP id
 ffacd0b85a97d-3a6ed60c8e9mr2216793f8f.1.1750857691498; 
 Wed, 25 Jun 2025 06:21:31 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8068fd0sm4760042f8f.38.2025.06.25.06.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:21:31 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michael Walle <mwalle@kernel.org>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 05/13] lwip: split net/lwip/wget.c
Date: Wed, 25 Jun 2025 15:19:13 +0200
Message-ID: <20250625132108.3292932-6-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625132108.3292932-1-jerome.forissier@linaro.org>
References: <20250625132108.3292932-1-jerome.forissier@linaro.org>
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

Split net/lwip/wget.c in two: one part which implements CONFIG_WGET
stays in net/ while the part that implements CONFIG_CMD_WGET is moved
into cmd/.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v3)

Changes in v3:
- Remove WGET_CACERT guard around the auth_mode enum and the extern
  variables in include/net-lwip.h
- Fix build with WGET_CACERT=n and WGET_CACERT_BUILTIN=y

Changes in v2:
- New patch

 cmd/lwip/wget.c    | 195 +++++++++++++++++++++++++++++++++++++++++++
 include/net-lwip.h |  14 ++++
 net/lwip/wget.c    | 202 +--------------------------------------------
 3 files changed, 211 insertions(+), 200 deletions(-)

diff --git a/cmd/lwip/wget.c b/cmd/lwip/wget.c
index 3f5b9952c93..902d155727b 100644
--- a/cmd/lwip/wget.c
+++ b/cmd/lwip/wget.c
@@ -2,7 +2,9 @@
 /* Copyright (C) 2024-2025 Linaro Ltd. */
 
 #include <command.h>
+#include <image.h>
 #include <net.h>
+#include <lwip/altcp_tls.h>
 
 U_BOOT_CMD(wget, 4, 1, do_wget,
 	   "boot image via network using HTTP/HTTPS protocol"
@@ -24,3 +26,196 @@ U_BOOT_CMD(wget, 4, 1, do_wget,
 #endif
 #endif
 );
+
+#if CONFIG_IS_ENABLED(WGET_CACERT) || CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+char *cacert;
+size_t cacert_size;
+enum auth_mode cacert_auth_mode = AUTH_OPTIONAL;
+
+#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+extern const char builtin_cacert[];
+extern const size_t builtin_cacert_size;
+bool cacert_initialized;
+#endif
+
+static int _set_cacert(const void *addr, size_t sz)
+{
+	mbedtls_x509_crt crt;
+	void *p;
+	int ret;
+
+	if (cacert)
+		free(cacert);
+
+	if (!addr) {
+		cacert = NULL;
+		cacert_size = 0;
+		return CMD_RET_SUCCESS;
+	}
+
+	p = malloc(sz);
+	if (!p)
+		return CMD_RET_FAILURE;
+	cacert = p;
+	cacert_size = sz;
+
+	memcpy(cacert, (void *)addr, sz);
+
+	mbedtls_x509_crt_init(&crt);
+	ret = mbedtls_x509_crt_parse(&crt, cacert, cacert_size);
+	if (ret) {
+		if (!wget_info->silent)
+			printf("Could not parse certificates (%d)\n", ret);
+		free(cacert);
+		cacert = NULL;
+		cacert_size = 0;
+		return CMD_RET_FAILURE;
+	}
+
+#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+	cacert_initialized = true;
+#endif
+	return CMD_RET_SUCCESS;
+}
+
+#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+int set_cacert_builtin(void)
+{
+	cacert_auth_mode = AUTH_REQUIRED;
+	return _set_cacert(builtin_cacert, builtin_cacert_size);
+}
+#endif
+#endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
+
+#if CONFIG_IS_ENABLED(WGET_CACERT)
+static int set_auth(enum auth_mode auth)
+{
+	cacert_auth_mode = auth;
+
+	return CMD_RET_SUCCESS;
+}
+
+static int set_cacert(char * const saddr, char * const ssz)
+{
+	ulong addr, sz;
+
+	addr = hextoul(saddr, NULL);
+	sz = hextoul(ssz, NULL);
+
+	return _set_cacert((void *)addr, sz);
+}
+#endif
+
+/*
+ * Legacy syntax support
+ * Convert [<server_name_or_ip>:]filename into a URL if needed
+ */
+static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
+{
+	char *p = nurl;
+	size_t n;
+	char *col = strchr(arg, ':');
+	char *env;
+	char *server;
+	char *path;
+
+	if (strstr(arg, "http") == arg) {
+		n = snprintf(nurl, rem, "%s", arg);
+		if (n < 0 || n > rem)
+			return -1;
+		return 0;
+	}
+
+	n = snprintf(p, rem, "%s", "http://");
+	if (n < 0 || n > rem)
+		return -1;
+	p += n;
+	rem -= n;
+
+	if (col) {
+		n = col - arg;
+		server = arg;
+		path = col + 1;
+	} else {
+		env = env_get("httpserverip");
+		if (!env)
+			env = env_get("serverip");
+		if (!env) {
+			log_err("error: httpserver/serverip has to be set\n");
+			return -1;
+		}
+		n = strlen(env);
+		server = env;
+		path = arg;
+	}
+
+	if (rem < n)
+		return -1;
+	strncpy(p, server, n);
+	p += n;
+	rem -= n;
+	if (rem < 1)
+		return -1;
+	*p = '/';
+	p++;
+	rem--;
+	n = strlen(path);
+	if (rem < n)
+		return -1;
+	strncpy(p, path, n);
+	p += n;
+	rem -= n;
+	if (rem < 1)
+		return -1;
+	*p = '\0';
+
+	return 0;
+}
+
+int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	char *end;
+	char *url;
+	ulong dst_addr;
+	char nurl[1024];
+
+#if CONFIG_IS_ENABLED(WGET_CACERT)
+	if (argc == 4 && !strncmp(argv[1], "cacert", strlen("cacert")))
+		return set_cacert(argv[2], argv[3]);
+	if (argc == 3 && !strncmp(argv[1], "cacert", strlen("cacert"))) {
+#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+		if (!strncmp(argv[2], "builtin", strlen("builtin")))
+			return set_cacert_builtin();
+#endif
+		if (!strncmp(argv[2], "none", strlen("none")))
+			return set_auth(AUTH_NONE);
+		if (!strncmp(argv[2], "optional", strlen("optional")))
+			return set_auth(AUTH_OPTIONAL);
+		if (!strncmp(argv[2], "required", strlen("required")))
+			return set_auth(AUTH_REQUIRED);
+		return CMD_RET_USAGE;
+	}
+#endif
+
+	if (argc < 2 || argc > 3)
+		return CMD_RET_USAGE;
+
+	dst_addr = hextoul(argv[1], &end);
+	if (end == (argv[1] + strlen(argv[1]))) {
+		if (argc < 3)
+			return CMD_RET_USAGE;
+		url = argv[2];
+	} else {
+		dst_addr = image_load_addr;
+		url = argv[1];
+	}
+
+	if (parse_legacy_arg(url, nurl, sizeof(nurl)))
+		return CMD_RET_FAILURE;
+
+	wget_info = &default_wget_info;
+	if (wget_do_request(dst_addr, nurl))
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
diff --git a/include/net-lwip.h b/include/net-lwip.h
index b762956e8fd..9c1167482e9 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -6,6 +6,20 @@
 #include <lwip/ip4.h>
 #include <lwip/netif.h>
 
+/* HTTPS authentication mode */
+enum auth_mode {
+	AUTH_NONE,
+	AUTH_OPTIONAL,
+	AUTH_REQUIRED,
+};
+
+extern char *cacert;
+extern size_t cacert_size;
+extern enum auth_mode cacert_auth_mode;
+extern bool cacert_initialized;
+
+int set_cacert_builtin(void);
+
 enum proto_t {
 	TFTPGET
 };
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index ea1113e18b1..539812b68e9 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -5,7 +5,6 @@
 #include <console.h>
 #include <display_options.h>
 #include <efi_loader.h>
-#include <image.h>
 #include <linux/kconfig.h>
 #include <lwip/apps/http_client.h>
 #include "lwip/altcp_tls.h"
@@ -137,72 +136,6 @@ static int parse_url(char *url, char *host, u16 *port, char **path,
 	return 0;
 }
 
-/*
- * Legacy syntax support
- * Convert [<server_name_or_ip>:]filename into a URL if needed
- */
-static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
-{
-	char *p = nurl;
-	size_t n;
-	char *col = strchr(arg, ':');
-	char *env;
-	char *server;
-	char *path;
-
-	if (strstr(arg, "http") == arg) {
-		n = snprintf(nurl, rem, "%s", arg);
-		if (n < 0 || n > rem)
-			return -1;
-		return 0;
-	}
-
-	n = snprintf(p, rem, "%s", "http://");
-	if (n < 0 || n > rem)
-		return -1;
-	p += n;
-	rem -= n;
-
-	if (col) {
-		n = col - arg;
-		server = arg;
-		path = col + 1;
-	} else {
-		env = env_get("httpserverip");
-		if (!env)
-			env = env_get("serverip");
-		if (!env) {
-			log_err("error: httpserver/serverip has to be set\n");
-			return -1;
-		}
-		n = strlen(env);
-		server = env;
-		path = arg;
-	}
-
-	if (rem < n)
-		return -1;
-	strncpy(p, server, n);
-	p += n;
-	rem -= n;
-	if (rem < 1)
-		return -1;
-	*p = '/';
-	p++;
-	rem--;
-	n = strlen(path);
-	if (rem < n)
-		return -1;
-	strncpy(p, path, n);
-	p += n;
-	rem -= n;
-	if (rem < 1)
-		return -1;
-	*p = '\0';
-
-	return 0;
-}
-
 /**
  * store_block() - copy received data
  *
@@ -337,93 +270,9 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
 	return ERR_OK;
 }
 
-#if CONFIG_IS_ENABLED(WGET_HTTPS)
-enum auth_mode {
-	AUTH_NONE,
-	AUTH_OPTIONAL,
-	AUTH_REQUIRED,
-};
-
-static char *cacert;
-static size_t cacert_size;
-static enum auth_mode cacert_auth_mode = AUTH_OPTIONAL;
-#endif
-
-#if CONFIG_IS_ENABLED(WGET_CACERT)
-static int set_auth(enum auth_mode auth)
-{
-	cacert_auth_mode = auth;
-
-	return CMD_RET_SUCCESS;
-}
-#endif
-
-#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
-extern const char builtin_cacert[];
-extern const size_t builtin_cacert_size;
-static bool cacert_initialized;
-#endif
-
-#if CONFIG_IS_ENABLED(WGET_CACERT) || CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
-static int _set_cacert(const void *addr, size_t sz)
-{
-	mbedtls_x509_crt crt;
-	void *p;
-	int ret;
-
-	if (cacert)
-		free(cacert);
-
-	if (!addr) {
-		cacert = NULL;
-		cacert_size = 0;
-		return CMD_RET_SUCCESS;
-	}
-
-	p = malloc(sz);
-	if (!p)
-		return CMD_RET_FAILURE;
-	cacert = p;
-	cacert_size = sz;
-
-	memcpy(cacert, (void *)addr, sz);
-
-	mbedtls_x509_crt_init(&crt);
-	ret = mbedtls_x509_crt_parse(&crt, cacert, cacert_size);
-	if (ret) {
-		if (!wget_info->silent)
-			printf("Could not parse certificates (%d)\n", ret);
-		free(cacert);
-		cacert = NULL;
-		cacert_size = 0;
-		return CMD_RET_FAILURE;
-	}
-
-#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
-	cacert_initialized = true;
-#endif
-	return CMD_RET_SUCCESS;
-}
-
-#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
-static int set_cacert_builtin(void)
-{
-	return _set_cacert(builtin_cacert, builtin_cacert_size);
-}
-#endif
 
 #if CONFIG_IS_ENABLED(WGET_CACERT)
-static int set_cacert(char * const saddr, char * const ssz)
-{
-	ulong addr, sz;
-
-	addr = hextoul(saddr, NULL);
-	sz = hextoul(ssz, NULL);
-
-	return _set_cacert((void *)addr, sz);
-}
 #endif
-#endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
 
 int wget_do_request(ulong dst_addr, char *uri)
 {
@@ -466,6 +315,7 @@ int wget_do_request(ulong dst_addr, char *uri)
 		char *ca;
 		size_t ca_sz;
 
+#if CONFIG_IS_ENABLED(WGET_CACERT) || CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
 #if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
 		if (!cacert_initialized)
 			set_cacert_builtin();
@@ -492,7 +342,7 @@ int wget_do_request(ulong dst_addr, char *uri)
 			 * with no verification if not.
 			 */
 		}
-
+#endif
 		if (!ca && !wget_info->silent) {
 			printf("WARNING: no CA certificates, ");
 			printf("HTTPS connections not authenticated\n");
@@ -541,54 +391,6 @@ int wget_do_request(ulong dst_addr, char *uri)
 	return -1;
 }
 
-int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
-{
-	char *end;
-	char *url;
-	ulong dst_addr;
-	char nurl[1024];
-
-#if CONFIG_IS_ENABLED(WGET_CACERT)
-	if (argc == 4 && !strncmp(argv[1], "cacert", strlen("cacert")))
-		return set_cacert(argv[2], argv[3]);
-	if (argc == 3 && !strncmp(argv[1], "cacert", strlen("cacert"))) {
-#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
-		if (!strncmp(argv[2], "builtin", strlen("builtin")))
-			return set_cacert_builtin();
-#endif
-		if (!strncmp(argv[2], "none", strlen("none")))
-			return set_auth(AUTH_NONE);
-		if (!strncmp(argv[2], "optional", strlen("optional")))
-			return set_auth(AUTH_OPTIONAL);
-		if (!strncmp(argv[2], "required", strlen("required")))
-			return set_auth(AUTH_REQUIRED);
-		return CMD_RET_USAGE;
-	}
-#endif
-
-	if (argc < 2 || argc > 3)
-		return CMD_RET_USAGE;
-
-	dst_addr = hextoul(argv[1], &end);
-	if (end == (argv[1] + strlen(argv[1]))) {
-		if (argc < 3)
-			return CMD_RET_USAGE;
-		url = argv[2];
-	} else {
-		dst_addr = image_load_addr;
-		url = argv[1];
-	}
-
-	if (parse_legacy_arg(url, nurl, sizeof(nurl)))
-		return CMD_RET_FAILURE;
-
-	wget_info = &default_wget_info;
-	if (wget_do_request(dst_addr, nurl))
-		return CMD_RET_FAILURE;
-
-	return CMD_RET_SUCCESS;
-}
-
 /**
  * wget_validate_uri() - validate the uri for wget
  *
-- 
2.43.0

