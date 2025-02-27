Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E47C1B0FF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A156581249;
	Thu, 27 Feb 2025 17:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rYsTPhcG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC0CE81111; Thu, 27 Feb 2025 17:09:39 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F99811D8
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43995b907cfso7667655e9.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740672576; x=1741277376; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfI6d9OG2eQBM8ef+VTF0Zzv0JfUrlSXEUI5pOss0zo=;
 b=rYsTPhcGgtzEoXLQDOD5Al8sHAjCpClg7OXQLcz7Rhf43CgEJ8AKvIIqgCy/wdnYkE
 Wn+wpKnd5eWZaoVcg5C19F/5tZ8B8OFjcz9fUoAk/by6AclcwaBj+De+PazdYXF7MSAy
 crGTGy8m03GZ861aOqK8D9D+vMUrOfQ0sQYBC49LYIUvJUYv+DliPJ67oxQMyzTPvyyF
 V+LIuaavh1fXrdyrHICkSmiBbkMKuS/GJzRWQNZ8VTSlDBURScsecAkXzvXdsshya96M
 za8Ska2mE0DKqmdjvFvJF8drc46vOjz3TH1WJOywlbhteB7oGswKiV7QEd6NvDA4GBln
 GOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740672576; x=1741277376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zfI6d9OG2eQBM8ef+VTF0Zzv0JfUrlSXEUI5pOss0zo=;
 b=k5MGPRPtUCeBOvCDxFuWO1rUTg0J6PTPV/VoKvyh3EQryfftj3n7u7Wn8yhSmZgTyt
 5G2ZFIcZXqrFfnuDrQUziN595UNHUbLIq+5v1rJ2OycDROA8VwmGF46jOC9KMUBt83w4
 S8Lmu1CujGg6TEUHs8hnL1bxkS4hasFRbzEFNuD60Kzes6dtHLFZ1l8MBWu7MgW5+NM4
 tCJs+Kdi70XWVRp3pU1EpWtT3uo3PZUsHuGsi8czLSOWMW6xqOCtahK5HjMcvoKKj5Jz
 USMbSE+krbYlFohRwIGfXxtpaxB3xoWfunYRd7m4dgbdgTet1/bvuT57lX08mhOaiLXY
 D0yw==
X-Gm-Message-State: AOJu0YwCuAza3FYevlSRCejQJFuPH8KW1rqE5FyOEp3/Q4TYedUuzDV3
 DjMW6qFrQAnUlrw2KwWht4yLLnTduVh+TvWSwUCcXZR4YY9I5UzaGFnZaEMnJPoez6aNWC1PVnx
 uVgk=
X-Gm-Gg: ASbGncvzYRuOWAz43mJ8ikxk57zEKA2DK3AHmTssyUk6UFrxpp16mZSKquvNNRFvWTu
 eHIaM3J35ZAVwdZD72/1MUUpydN3Dt5aSyKmoFFtZ2+0zzqz4FAVHux1ftrj5Cyvg0Dli3egKRc
 d27puj6fwZxj9oL770xGfcXgDOffY9HR0EJyyw1UHRN8I3SjqVPMho1iDkkaJa4Uj4k4JN6R/4H
 kbEvuLhOK+lwNEuHZQnz6CjRf9i5yUyF0JvFQFB/3ySWcc0BmzlXhMeqFIzRVPICgkFiIDGbcRs
 TVMQoeAa5IdOLOOoSAeH7eB8NKZc2qDJzt8=
X-Google-Smtp-Source: AGHT+IH5caz3PJVrdqK5qkdQse9xzBZCpJcBNgJhjDKT9UCfbAFJoo3jc83zkhBiF9Cx8STZuugdNg==
X-Received: by 2002:a05:600c:3ba8:b0:439:a138:20 with SMTP id
 5b1f17b1804b1-43ab0f65faemr94196405e9.20.1740672574726; 
 Thu, 27 Feb 2025 08:09:34 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52b925sm59506795e9.7.2025.02.27.08.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:09:34 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 4/5] net: lwip: add support for built-in root certificates
Date: Thu, 27 Feb 2025 17:09:04 +0100
Message-ID: <fc96dd94cb39b60571b43ef80c5c89ff7999e94b.1740672437.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740672437.git.jerome.forissier@linaro.org>
References: <cover.1740672437.git.jerome.forissier@linaro.org>
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

Introduce Kconfig symbols WGET_BUILTIN_CACERT and
WGET_BUILTIN_CACERT_PATH to provide root certificates at build time. The
file may be a DER-encoded (.crt) or PEM-encoded (.pem) X509 collection
of one or more certificates. PEM encoding needs MBEDTLS_LIB_X509_PEM.

Usage example:

 wget https://curl.se/ca/cacert.pem
 make qemu_arm64_lwip_defconfig
 echo CONFIG_WGET_BUILTIN_CACERT=y >>.config
 echo CONFIG_WGET_BUILTIN_CACERT_PATH=cacert.pem >>.config
 echo CONFIG_MBEDTLS_LIB_X509_PEM=y >>.config
 make olddefconfig
 make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
 qemu-system-aarch64 -M virt -nographic -cpu max \
    -object rng-random,id=rng0,filename=/dev/urandom \
    -device virtio-rng-pci,rng=rng0 -bios u-boot.bin
 => dhcp
 # HTTPS transfer using the builtin CA certificates
 => wget https://www.google.com/
 18724 bytes transferred in 15 ms (1.2 MiB/s)
 Bytes transferred = 18724 (4924 hex)

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig       | 16 +++++++++++++-
 cmd/net-lwip.c    |  4 ++++
 net/lwip/Makefile |  6 ++++++
 net/lwip/wget.c   | 53 +++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 69 insertions(+), 10 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a188a2ef24b..cb3cc859616 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2186,12 +2186,26 @@ config WGET_CACERT
 	  to the HTTPS engine.
 
 config MBEDTLS_LIB_X509_PEM
-	depends on WGET_CACERT
+	depends on WGET_HTTPS
 	bool "Support for PEM-encoded X509 certificates"
 	help
 	  This option enables MbedTLS to parse PEM-encoded X509 certificates.
 	  When disabled, only DER format is accepted.
 
+config WGET_BUILTIN_CACERT
+	bool "Built-in CA certificates"
+	depends on WGET_HTTPS
+
+config WGET_BUILTIN_CACERT_PATH
+	string "Path to root certificates"
+	depends on WGET_BUILTIN_CACERT
+	default "cacert.crt"
+	help
+	  Set this to the path to a DER- or PEM-encoded X509 file containing
+	  Certification Authority certificates, a.k.a. root certificates, for
+	  the purpose of authenticating HTTPS connections. Do not forget to
+	  enable MBEDTLS_LIB_X509_PEM if the file is PEM.
+
 endif  # if CMD_NET
 
 config CMD_PXE
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index 0672f48a7a8..a848d0b1dcf 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -39,6 +39,10 @@ U_BOOT_CMD(wget, 4, 1, do_wget,
 #if defined(CONFIG_WGET_CACERT)
 	   "\nwget cacert <address> <length>\n"
 	   "    - provide CA certificates (0 0 to disable verification)"
+#if defined(CONFIG_WGET_BUILTIN_CACERT)
+	   "\nwget cacert builtin\n"
+	   "    - use the builtin CA certificates"
+#endif
 #endif
 );
 #endif
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 79dd6b3fb50..950c5316bb9 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -6,3 +6,9 @@ obj-$(CONFIG_CMD_DNS) += dns.o
 obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 obj-$(CONFIG_WGET) += wget.o
+
+ifeq (y,$(CONFIG_WGET_BUILTIN_CACERT))
+$(obj)/builtin_cacert.c: $(CONFIG_WGET_BUILTIN_CACERT_PATH:"%"=%) FORCE
+	$(call if_changed,bin2c,builtin_cacert)
+obj-y += builtin_cacert.o
+endif
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 14466598d7c..f24aa9c2380 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -288,31 +288,34 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
 #if defined CONFIG_WGET_HTTPS
 static char *cacert;
 size_t cacert_size;
+
+#if defined CONFIG_WGET_BUILTIN_CACERT
+extern char builtin_cacert[];
+extern const size_t builtin_cacert_size;
+static bool cacert_initialized;
+#endif
 #endif
 
-#if defined CONFIG_WGET_CACERT
-static int set_cacert(char * const saddr, char * const ssz)
+#if defined CONFIG_WGET_CACERT || defined CONFIG_WGET_BUILTIN_CACERT
+static int _set_cacert(void *addr, size_t sz)
 {
 	mbedtls_x509_crt crt;
-	ulong addr, sz;
+	void *p;
 	int ret;
 
 	if (cacert)
 		free(cacert);
 
-	addr = hextoul(saddr, NULL);
-	sz = hextoul(ssz, NULL);
-	sz++; /* For the trailing '\0' in case of a text (PEM) file */
-
 	if (!addr) {
 		cacert = NULL;
 		cacert_size = 0;
 		return CMD_RET_SUCCESS;
 	}
 
-	cacert = malloc(sz);
-	if (!cacert)
+	p = malloc(sz);
+	if (!p)
 		return CMD_RET_FAILURE;
+	cacert = p;
 	cacert_size = sz;
 
 	memcpy(cacert, (void *)addr, sz - 1);
@@ -328,10 +331,33 @@ static int set_cacert(char * const saddr, char * const ssz)
 		return CMD_RET_FAILURE;
 	}
 
+#if defined CONFIG_WGET_BUILTIN_CACERT
+	cacert_initialized = true;
+#endif
 	return CMD_RET_SUCCESS;
 }
+
+#if defined CONFIG_WGET_BUILTIN_CACERT
+static int set_cacert_builtin(void)
+{
+	return _set_cacert(builtin_cacert, builtin_cacert_size);
+}
 #endif
 
+#if defined CONFIG_WGET_CACERT
+static int set_cacert(char * const saddr, char * const ssz)
+{
+	ulong addr, sz;
+
+	addr = hextoul(saddr, NULL);
+	sz = hextoul(ssz, NULL);
+	sz++; /* For the trailing '\0' in case of a text (PEM) file */
+
+	return _set_cacert((void *)addr, sz);
+}
+#endif
+#endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
+
 static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 {
 #if defined CONFIG_WGET_HTTPS
@@ -361,6 +387,10 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	memset(&conn, 0, sizeof(conn));
 #if defined CONFIG_WGET_HTTPS
 	if (is_https) {
+#if defined CONFIG_WGET_BUILTIN_CACERT
+		if (!cacert_initialized)
+			set_cacert_builtin();
+#endif
 		tls_allocator.alloc = &altcp_tls_alloc;
 		tls_allocator.arg =
 			altcp_tls_create_config_client(cacert, cacert_size,
@@ -420,6 +450,11 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 #if defined CONFIG_WGET_CACERT
 	if (argc == 4 && !strncmp(argv[1], "cacert", strlen("cacert")))
 		return set_cacert(argv[2], argv[3]);
+#if defined CONFIG_WGET_BUILTIN_CACERT
+	if (argc == 3 && !strncmp(argv[1], "cacert", strlen("cacert")) &&
+	    !strncmp(argv[2], "builtin", strlen("builtin")))
+		return set_cacert_builtin();
+#endif
 #endif
 
 	if (argc < 2 || argc > 3)
-- 
2.43.0

