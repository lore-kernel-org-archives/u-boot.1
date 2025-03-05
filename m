Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3394CC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90B1781420;
	Wed,  5 Mar 2025 15:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wQSj/Lei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AC6181276; Wed,  5 Mar 2025 15:27:23 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDAB8811C1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bcad638efso14366965e9.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741184840; x=1741789640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iw0NmlvEY0kN52IQfHtiNuKhb/OHaYv9SiWJGV1BIyA=;
 b=wQSj/LeiJRSLX1rxl9bXGhMvNfsgPruyx0izSaphMhaVhgvu5gFWrki8IGrEqXXZuv
 yfXc14jNUDiyPJfUuolLZ0aR6pquchW3EJUX8FMTXPDe0a8YMxYmQNLKg8gdgDfBjd/c
 bn0AzFWLMhPS6zNyhzqNyLgs3h55MvaAlzIYexcNQefMJDw/6J/n4SxSdguFXhARIJAa
 JScOTqla6U0iYEWukDgiIYZtCjm7GntZCVkt7xf91VK1zTNR1jml96fajAOzPYxyCzyJ
 MGJlJrBtYM4SiZ9R9830Bd2MiSeYoyBQr1J7LcAuCSuvND3egXVzAf3kN3yijhcjitGZ
 33lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184840; x=1741789640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iw0NmlvEY0kN52IQfHtiNuKhb/OHaYv9SiWJGV1BIyA=;
 b=NyzdW9AFcmE4ltq8e0gyqx30SudNyXyoqXJREThniT5mbZHVtwwmF850OzZ4+3qp7H
 psvqSSS2xqWZ56oWS2lcCZaq1F5Rmn2TgJEYlhevxbp/o5pzcga2kvDN0FDMG+egJvxW
 lFX0dLa+Cx80flNteLOcerWXlh9Hj6oUTp4xghKrBlvQIL0zWIhfG6uNNDGyRTN5JJdo
 V5P0HD9uVU7q56e7V999E2ASV0TLLBou5NI/HlfpPHa37xMglwD0g5vYU+6KTTKRMOIN
 vz8DiWBWjvjFYiQCSw5wpYfZreigwibyaNtAtQSY/yi7Sw9O8AzZcAf6THFzJgPGSdZj
 Tg6w==
X-Gm-Message-State: AOJu0YzkHKoeOoYmvoB7IkIUODRhtplZGP3JmQL2Ki5rzA7LSq5MIrsS
 LiufUsHmR8TUqzz4bd1KsL2XeduJVnNYI4PzneOzCnPmCb1o5ocqZzFRrG+gY7i49q7VmaUJGFp
 C
X-Gm-Gg: ASbGncsKhYoBys38g1ooZ6+RKntdiR90kksKsZxZO3MRyQH6TE0AYqgrrU/rG6c/gGn
 QbOLYHrpnv4fvER2Gal5Wm6rTCc1WVwPBRx/M9zyYbRQbX4C94itM9GO73cI/Ud4dJQM4adZaab
 eQBizRgoSp3WBVHS7rkmqWm3q9A/o6KZ0lRVFcFUPrE0Me5Vm3Q3TaqmgdHDVqK7rmoExu15TmU
 hyZDn6Qmz3n+swYPtbld0zUVCXc2bf+Sp2AxTKvW80cmFdUhOci0JqS2vtb42vhq+zvbBnOkHFg
 /ThIQKhy/kVzCTAVeIqM0xe9tKLJuHZVBdFaU3BG+mVAb8kplr/HeQ==
X-Google-Smtp-Source: AGHT+IGcN6FLnTUr3ghyqAqUnlNtEQhwnfS9KEFTwlMhIu3XhWzwpZm5PwC91QNjlS5vtwsZuznHcA==
X-Received: by 2002:a05:600c:45c6:b0:43b:c034:57b1 with SMTP id
 5b1f17b1804b1-43bd2aed7a7mr21852965e9.20.1741184838559; 
 Wed, 05 Mar 2025 06:27:18 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:369c:9bd8:7c87:9a39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-391188029e0sm5442456f8f.52.2025.03.05.06.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 06:27:18 -0800 (PST)
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
Subject: [PATCH v2 4/6] net: lwip: add support for built-in root certificates
Date: Wed,  5 Mar 2025 15:26:45 +0100
Message-ID: <20250305142650.2966738-5-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305142650.2966738-1-jerome.forissier@linaro.org>
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
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
WGET_BUILTIN_CACERT_PATH to provide root certificates at build time.

Usage example:

 wget -O cacert.crt https://cacerts.digicert.com/DigiCertTLSECCP384RootG5.crt
 make qemu_arm64_lwip_defconfig
 echo CONFIG_WGET_BUILTIN_CACERT=y >>.config
 echo CONFIG_WGET_BUILTIN_CACERT_PATH=cacert.crt >>.config
 make olddefconfig
 make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
 qemu-system-aarch64 -M virt -nographic -cpu max \
    -object rng-random,id=rng0,filename=/dev/urandom \
    -device virtio-rng-pci,rng=rng0 -bios u-boot.bin
 => dhcp
 # HTTPS transfer using the builtin CA certificates
 => wget https://digicert-tls-ecc-p384-root-g5.chain-demos.digicert.com/
 1867 bytes transferred in 1 ms (1.8 MiB/s)
 Bytes transferred = 1867 (74b hex)

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig       | 14 ++++++++++++
 cmd/net-lwip.c    |  4 ++++
 net/lwip/Makefile |  6 +++++
 net/lwip/wget.c   | 57 +++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index d469217c0ea..312bf94d4e8 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2185,6 +2185,20 @@ config WGET_CACERT
 	  Adds the "cacert" sub-command to wget to provide root certificates
 	  to the HTTPS engine. Must be in DER format.
 
+config WGET_BUILTIN_CACERT
+	bool "Built-in CA certificates"
+	depends on WGET_HTTPS
+	select BUILD_BIN2C
+
+config WGET_BUILTIN_CACERT_PATH
+	string "Path to root certificates"
+	depends on WGET_BUILTIN_CACERT
+	default "cacert.crt"
+	help
+	  Set this to the path to a DER-encoded X509 file containing
+	  Certification Authority certificates, a.k.a. root certificates, for
+	  the purpose of authenticating HTTPS connections.
+
 endif  # if CMD_NET
 
 config CMD_PXE
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index 1152c94a6dc..58c10fbec7d 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -41,6 +41,10 @@ U_BOOT_CMD(wget, 4, 1, do_wget,
 	   "    - provide CA certificates (0 0 to remove current)"
 	   "\nwget cacert none|optional|required\n"
 	   "    - set server certificate verification mode (default: optional)"
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
index c22843ee10d..ec098148835 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -304,28 +304,34 @@ static int set_auth(enum auth_mode auth)
 
 	return CMD_RET_SUCCESS;
 }
+#endif
 
-static int set_cacert(char * const saddr, char * const ssz)
+#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+extern const char builtin_cacert[];
+extern const size_t builtin_cacert_size;
+static bool cacert_initialized;
+#endif
+
+#if CONFIG_IS_ENABLED(WGET_CACERT) || CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+static int _set_cacert(const void *addr, size_t sz)
 {
 	mbedtls_x509_crt crt;
-	ulong addr, sz;
+	void *p;
 	int ret;
 
 	if (cacert)
 		free(cacert);
 
-	addr = hextoul(saddr, NULL);
-	sz = hextoul(ssz, NULL);
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
 
 	memcpy(cacert, (void *)addr, sz);
@@ -340,10 +346,32 @@ static int set_cacert(char * const saddr, char * const ssz)
 		return CMD_RET_FAILURE;
 	}
 
+#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+	cacert_initialized = true;
+#endif
 	return CMD_RET_SUCCESS;
 }
+
+#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+static int set_cacert_builtin(void)
+{
+	return _set_cacert(builtin_cacert, builtin_cacert_size);
+}
 #endif
 
+#if CONFIG_IS_ENABLED(WGET_CACERT)
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
+#endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
+
 static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 {
 #if CONFIG_IS_ENABLED(WGET_HTTPS)
@@ -373,8 +401,15 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	memset(&conn, 0, sizeof(conn));
 #if CONFIG_IS_ENABLED(WGET_HTTPS)
 	if (is_https) {
-		char *ca = cacert;
-		size_t ca_sz = cacert_size;
+		char *ca;
+		size_t ca_sz;
+
+#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+		if (!cacert_initialized)
+			set_cacert_builtin();
+#endif
+		ca = cacert;
+		ca_sz = cacert_size;
 
 		if (cacert_auth_mode == AUTH_REQUIRED) {
 			if (!ca || !ca_sz) {
@@ -455,6 +490,10 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 	if (argc == 4 && !strncmp(argv[1], "cacert", strlen("cacert")))
 		return set_cacert(argv[2], argv[3]);
 	if (argc == 3 && !strncmp(argv[1], "cacert", strlen("cacert"))) {
+#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+		if (!strncmp(argv[2], "builtin", strlen("builtin")))
+			return set_cacert_builtin();
+#endif
 		if (!strncmp(argv[2], "none", strlen("none")))
 			return set_auth(AUTH_NONE);
 		if (!strncmp(argv[2], "optional", strlen("optional")))
-- 
2.43.0

