Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0EBC5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26F5A82AFC;
	Fri,  6 Jun 2025 08:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cV/4/JX/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A54082AAF; Fri,  6 Jun 2025 08:42:29 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65A13800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so1818225f8f.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 23:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749192147; x=1749796947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kw9a2XLk8kXpQxlBmMgzUu7g4Vpcw/5hcgrEpS0z510=;
 b=cV/4/JX/TikZGv1fO22ONsUaglHedOPTSvcLBoqrfk6IX9DSipTNevaLshv+WMuAC8
 jpceVvNqMjcurCHnPzVKtTwDv8dQoLlRzbLFKp7GG5XNCdxSDp+Wxu05jOEL5aIFiyek
 Vruh7SFtUOQqIeaFGJFEoYesIYckGOF4LCE0gu/y3TQHlv68EPC6gxpWW+Ro3VYysDaF
 +DwMROT0T6bx7KcQ9XKzCVNvQTze6Qq6jJwEO51rApyWi55EP7Br3jczn1E37QJGvE+g
 wlsWgUc5HMXgr0Kiw8y3N91wDmWyAbgcsgkOwpF8RECjE12rIwvguzqQPntjCos/S/Kh
 CFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749192147; x=1749796947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kw9a2XLk8kXpQxlBmMgzUu7g4Vpcw/5hcgrEpS0z510=;
 b=m3LR27+B25y8Z0nFm9kWhvysmQWpE1kb73v37xI/j5B/rtALWzrmNH14negvfSC3J4
 zR5YG8VPi1Qqx94KVn1b8zbpnvkKEWTNMNRV9kQonqSPktbIUZzAv9WdoxqsSAd9PjzO
 x7Ed5Q2FcMyG7I2Gt4A+VPgRHMUa49U2QLhOe97uj7lsylQHFGcnIRWAqAcN0z82mDTb
 k0rUlR1J75kt2+Sy0lk/S9LOPXRBLfmrbVDybOBoHrMzZ3vGgXfo1yjhf9OoIWeftAj2
 uW8IP36RvjyaYw+w8fWuTtoYcXtAeRwD9bppJaN1GhBg6i4kryHR1gciesTENT202s+J
 nhPw==
X-Gm-Message-State: AOJu0YwKyMHX2avk5+7DrNW1X3Ht2E25ELXo8Tpia855LHPv9X/P5eJN
 J/Mc45TrbI2PQiFJp8qr/NjGz0qz8in9eejJuPB8OXZvspCoDVkueZBcffYFaSwZxwu+E47gVND
 g47ZP
X-Gm-Gg: ASbGncv1YoOb46BSGoEz3h95v6xkEWAvOvajW/KvyoQPM57DIcZ8BG24bgC1zsaH13/
 oL6dQ9Tkcehh4Ulutlcs8jH+WDuBjBq3g8Qh7jOdeRgzwrli5w1bj9+i6s8t/kv5g9iPFwXEd7j
 7lElfWdayyEYIlbIkEkcyeVT3AebC9taj1VN1O19TbElPcMQuJP2dmX3J8z04IVB5Htbbu/RBgC
 rsWepzGO31JdmIOQh3Gxjp2//wwwkk8ANe6Ab7FZVo86/Hg6orlb3ZxsTKJGjDEYuOESY1e8PNs
 dwC1lmHtI64TgrBHeCdVL3iB+CTPGIVgCHf08soiSBlR6aNg/8pjG3LzCrHQ
X-Google-Smtp-Source: AGHT+IE+M1okuDEmTO5LqoQ3T5ZdrhnXJwOkd91D/g3XBbI8KqXQqoRXAuu0glf6thUzU6YpeqIPtQ==
X-Received: by 2002:a05:6000:400c:b0:3a5:23c6:eeee with SMTP id
 ffacd0b85a97d-3a531434352mr1887531f8f.21.1749192146521; 
 Thu, 05 Jun 2025 23:42:26 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d10asm994627f8f.67.2025.06.05.23.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 23:42:26 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michael Walle <mwalle@kernel.org>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/13] lwip: split net/lwip/wget.c
Date: Fri,  6 Jun 2025 08:41:39 +0200
Message-ID: <20250606064211.3091237-4-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606064211.3091237-1-jerome.forissier@linaro.org>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
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

Changes in v2:
- New patch

 cmd/lwip/wget.c    | 192 ++++++++++++++++++++++++++++++++++++++++++
 include/net-lwip.h |  13 +++
 net/lwip/wget.c    | 206 +--------------------------------------------
 3 files changed, 209 insertions(+), 202 deletions(-)

diff --git a/cmd/lwip/wget.c b/cmd/lwip/wget.c
index 3f5b9952c93..5baad2e0f19 100644
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
@@ -24,3 +26,193 @@ U_BOOT_CMD(wget, 4, 1, do_wget,
 #endif
 #endif
 );
+
+#if CONFIG_IS_ENABLED(WGET_CACERT)
+char *cacert;
+size_t cacert_size;
+enum auth_mode cacert_auth_mode = AUTH_OPTIONAL;
+
+static int set_auth(enum auth_mode auth)
+{
+	cacert_auth_mode = auth;
+
+	return CMD_RET_SUCCESS;
+}
+
+#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+static const char builtin_cacert[];
+static const size_t builtin_cacert_size;
+static bool cacert_initialized;
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
+static int set_cacert_builtin(void)
+{
+	return _set_cacert(builtin_cacert, builtin_cacert_size);
+}
+#endif
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
+#endif  /* CONFIG_WGET_CACERT */
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
index b762956e8fd..cf3cf513b2b 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -6,6 +6,19 @@
 #include <lwip/ip4.h>
 #include <lwip/netif.h>
 
+#if CONFIG_IS_ENABLED(WGET_CACERT)
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
+#endif
+
 enum proto_t {
 	TFTPGET
 };
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index ea1113e18b1..78f28c56410 100644
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
@@ -463,9 +312,10 @@ int wget_do_request(ulong dst_addr, char *uri)
 	memset(&conn, 0, sizeof(conn));
 #if CONFIG_IS_ENABLED(WGET_HTTPS)
 	if (is_https) {
-		char *ca;
-		size_t ca_sz;
+		char *ca = NULL;
+		size_t ca_sz = 0;
 
+#if CONFIG_IS_ENABLED(WGET_CACERT)
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

