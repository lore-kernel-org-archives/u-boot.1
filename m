Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3825C282EC
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 670DE80F56;
	Wed,  5 Mar 2025 15:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TCqg61kx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38EBF80F92; Wed,  5 Mar 2025 15:27:18 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CACA680F92
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3910e101d0fso2277282f8f.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741184835; x=1741789635; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OM/CQnAr6FiV5DCMs4qVGKNCQbCRd11dI1O97N7MLA=;
 b=TCqg61kxHY/aK1ymDlz9gsD/IpgTuDBgKu6QgAy6nRCR6EnCfAZ5s6A0EK2q0V4rCs
 WNiJ8ERvRP4DSWC+3aAnj0PEfnGCi2sUvsYMPOrp9D+ToW8BgNehVK50/o8WPCAxIbsK
 mlpILY++MT+lhU9sWMIe/Hon3P5fWc6RButYjQ07rS4Q9DsiVxZvaGmaL6P7sVVW7uXa
 HlhuuMqvIklNJSCOj7M8+xOAkaNqSKWn8xe9ykxlPDAwpWxRGTiZDeSd+Gpwv0pvIbOP
 8TdnlUDPBsu2+MNlWW6oizK3Av7rWJ4eyPL4IfajMr7erqF60UBxKexbz62yCBIjMrdG
 RPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184835; x=1741789635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8OM/CQnAr6FiV5DCMs4qVGKNCQbCRd11dI1O97N7MLA=;
 b=NK8LE5QA/013LWXb8RPQgQH7G+e70SeLziVkBeVRaM101tjdhgkArmBXhvE6GUs2Xd
 whci8AAHmWSgIc4zHlLGHM0sGTu4RnCPG7LG6HOghulP4El0gRyW46G3CXSIV3yHTr6k
 eeHJvPSEE+NC7THZkh13cKZYlo18B2QoENiDjyrupsfAoXLnHwPomdSfZAXjjyyfwBV7
 pVAvB+Cbe3i6L4SqFAfm4TX1nJQFR/bT+Rg4c9MjQrEgsJEx/iOzcL8J7FM84xaI1OdW
 30wvD4ZcPONBK+eaG3as9QdOOGMuMcCIAxOKoPX54PZEN0PNCg1YMaI+HlPET9ivJDUg
 fM/A==
X-Gm-Message-State: AOJu0Ywtt/RifvLTg0fl3GIYo0yzWra4i+JDVY4Sr3iBT68IfGnfu92F
 4JChIHl1AMU+iL9vragSpFGkpcx4YIJcY7dtOZCRRF1GSjsE8r9gww9gaW+Hi5uTFnCyvdawkfZ
 s
X-Gm-Gg: ASbGncvhZy8NiOIH5vU34SxnbOCTz019hKH88RpKV3MghvPHJWIgUUMp/yL6u4zapXO
 Mo8iMomQ4L+w3wwqJy8tRSHjnwsvHC82kqoK60bBfbwuLl3cJ0PIYjfFsfbWvlkV5XsbBVRGFKn
 YP0oco7jgCohdXukjMwTdzCkEtvG75Sc4WcUY2CNmm5Y6qNaO284UEPaBeDL+sCXw2t91wwYqGD
 xhGT0Uo1fWN0Uyf+h8PSo4k7go52rVbZjtrlPgBmAglxr80acRpMcXfJlKgP8nQC6Yfle3GW1Ur
 2u+2GVgHRbUOTnI5as6SXsl5OSioXcJWWmMA+Nsxxmr92f9Z+q5PEA==
X-Google-Smtp-Source: AGHT+IHTS+CdkgdNKNoYwFzjb26CYkqtfQwyT+IGXQN2kRUIRhbCVekH/ki6NE5vvz3coPEV8RxQmA==
X-Received: by 2002:a5d:5846:0:b0:391:2353:8a57 with SMTP id
 ffacd0b85a97d-39123538ab5mr1918042f8f.34.1741184835084; 
 Wed, 05 Mar 2025 06:27:15 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:369c:9bd8:7c87:9a39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-391188029e0sm5442456f8f.52.2025.03.05.06.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 06:27:14 -0800 (PST)
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
Subject: [PATCH v2 1/6] net: lwip: extend wget to support CA (root)
 certificates
Date: Wed,  5 Mar 2025 15:26:42 +0100
Message-ID: <20250305142650.2966738-2-jerome.forissier@linaro.org>
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

Add the "cacert" (Certification Authority certificates) subcommand to
wget to pass root certificates to the code handling the HTTPS protocol.
The subcommand is enabled by the WGET_CACERT Kconfig symbol.

Usage example:

 => dhcp
 # Download some root certificates (note: not authenticated!)
 => wget https://cacerts.digicert.com/DigiCertTLSECCP384RootG5.crt
 # Provide root certificates
 => wget cacert $fileaddr $filesize
 # Enforce verification (it is optional by default)
 => wget cacert required
 # Forget the root certificates
 => wget cacert 0 0
 # Disable verification
 => wget cacert none

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig     |   8 ++++
 cmd/net-lwip.c  |  17 ++++++--
 net/lwip/wget.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 121 insertions(+), 6 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8dd42571abc..d469217c0ea 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2177,6 +2177,14 @@ config WGET_HTTPS
 	help
 	  Enable TLS over http for wget.
 
+config WGET_CACERT
+	bool "wget cacert"
+	depends on CMD_WGET
+	depends on WGET_HTTPS
+	help
+	  Adds the "cacert" sub-command to wget to provide root certificates
+	  to the HTTPS engine. Must be in DER format.
+
 endif  # if CMD_NET
 
 config CMD_PXE
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index 0fd446ecb20..1152c94a6dc 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -27,9 +27,20 @@ U_BOOT_CMD(dns, 3, 1, do_dns, "lookup the IP of a hostname",
 #endif
 
 #if defined(CONFIG_CMD_WGET)
-U_BOOT_CMD(wget, 3, 1, do_wget,
-	   "boot image via network using HTTP/HTTPS protocol",
+U_BOOT_CMD(wget, 4, 1, do_wget,
+	   "boot image via network using HTTP/HTTPS protocol"
+#if defined(CONFIG_WGET_CACERT)
+	   "\nwget cacert - configure wget root certificates"
+#endif
+	   ,
 	   "[loadAddress] url\n"
-	   "wget [loadAddress] [host:]path"
+	   "wget [loadAddress] [host:]path\n"
+	   "    - load file"
+#if defined(CONFIG_WGET_CACERT)
+	   "\nwget cacert <address> <length>\n"
+	   "    - provide CA certificates (0 0 to remove current)"
+	   "\nwget cacert none|optional|required\n"
+	   "    - set server certificate verification mode (default: optional)"
+#endif
 );
 #endif
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 14f27d42998..c22843ee10d 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -285,9 +285,68 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
 	return ERR_OK;
 }
 
+#if CONFIG_IS_ENABLED(WGET_HTTPS)
+enum auth_mode {
+	AUTH_NONE,
+	AUTH_OPTIONAL,
+	AUTH_REQUIRED,
+};
+
+static char *cacert;
+static size_t cacert_size;
+static enum auth_mode cacert_auth_mode = AUTH_OPTIONAL;
+#endif
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
+	mbedtls_x509_crt crt;
+	ulong addr, sz;
+	int ret;
+
+	if (cacert)
+		free(cacert);
+
+	addr = hextoul(saddr, NULL);
+	sz = hextoul(ssz, NULL);
+
+	if (!addr) {
+		cacert = NULL;
+		cacert_size = 0;
+		return CMD_RET_SUCCESS;
+	}
+
+	cacert = malloc(sz);
+	if (!cacert)
+		return CMD_RET_FAILURE;
+	cacert_size = sz;
+
+	memcpy(cacert, (void *)addr, sz);
+
+	mbedtls_x509_crt_init(&crt);
+	ret = mbedtls_x509_crt_parse(&crt, cacert, cacert_size);
+	if (ret) {
+		printf("Could not parse certificates (%d)\n", ret);
+		free(cacert);
+		cacert = NULL;
+		cacert_size = 0;
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+#endif
+
 static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 {
-#if defined CONFIG_WGET_HTTPS
+#if CONFIG_IS_ENABLED(WGET_HTTPS)
 	altcp_allocator_t tls_allocator;
 #endif
 	httpc_connection_t conn;
@@ -312,11 +371,34 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 		return -1;
 
 	memset(&conn, 0, sizeof(conn));
-#if defined CONFIG_WGET_HTTPS
+#if CONFIG_IS_ENABLED(WGET_HTTPS)
 	if (is_https) {
+		char *ca = cacert;
+		size_t ca_sz = cacert_size;
+
+		if (cacert_auth_mode == AUTH_REQUIRED) {
+			if (!ca || !ca_sz) {
+				printf("Error: cacert authentication mode is "
+				       "'required' but no CA certificates "
+				       "given\n");
+				return CMD_RET_FAILURE;
+		       }
+		} else if (cacert_auth_mode == AUTH_NONE) {
+			ca = NULL;
+			ca_sz = 0;
+		} else if (cacert_auth_mode == AUTH_OPTIONAL) {
+			/*
+			 * Nothing to do, this is the default behavior of
+			 * altcp_tls to check server certificates against CA
+			 * certificates when the latter are provided and proceed
+			 * with no verification if not.
+			 */
+		}
+
 		tls_allocator.alloc = &altcp_tls_alloc;
 		tls_allocator.arg =
-			altcp_tls_create_config_client(NULL, 0, ctx.server_name);
+			altcp_tls_create_config_client(ca, ca_sz,
+						       ctx.server_name);
 
 		if (!tls_allocator.arg) {
 			log_err("error: Cannot create a TLS connection\n");
@@ -369,6 +451,20 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 	ulong dst_addr;
 	char nurl[1024];
 
+#if CONFIG_IS_ENABLED(WGET_CACERT)
+	if (argc == 4 && !strncmp(argv[1], "cacert", strlen("cacert")))
+		return set_cacert(argv[2], argv[3]);
+	if (argc == 3 && !strncmp(argv[1], "cacert", strlen("cacert"))) {
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
 	if (argc < 2 || argc > 3)
 		return CMD_RET_USAGE;
 
-- 
2.43.0

