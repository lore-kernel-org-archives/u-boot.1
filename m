Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AD4C282DE
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:28:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D84768164E;
	Wed,  5 Mar 2025 15:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vQyRlEnJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B658681428; Wed,  5 Mar 2025 15:27:25 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1E0E81428
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43bcad638efso14367145e9.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741184841; x=1741789641; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VToeK9rvmge7vGIsjMizB5Qvqb2KL2Jo2850qAV1D5k=;
 b=vQyRlEnJJN1UJgqZ8t6Ut8C2S/T1mnkkS9UYQv//qx4LQbvMI+EFMxO37h5DnWmQDB
 SX9fTCDUNZmpK0NZzActmCbIxwarz4f438iJ+TS0YhHYaLnRiJKQQfIFZGqeDtBht9bi
 3uM9S2E0BSxH2AD2fhv2gPvtMgX6M/VduXCCgVjVOUakhJszmWs858rcebJoTuJKdOPZ
 KSFSP/yL9G/+p1s6EeIcW8XH3I/LriaJ1oG0r/5+Slcp4se7iIvuy6c97kUz/RVCdxOI
 uVGaZDeYo5osmT4KGVV8avF+JE0Ff6dO9KBnLC8hFRpQMj5EEwl3gypgQpNA4uB6hdme
 ieAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184841; x=1741789641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VToeK9rvmge7vGIsjMizB5Qvqb2KL2Jo2850qAV1D5k=;
 b=HawUPYhZq5bOfO/wCiIM9DyWNhLhQmWhy2bpLdK5KL6N7w2C14JC3C4iDk5tHpbiAM
 MDrtyL1BRAT0UlYnFAWzpml2OFXxvsd1B1WwP9u/hBjjOhSSR+/mnx/d9gsZM6B9thJ8
 9ZiwoUVN2JTBJh8mHWPl1iViYsg0AB5ejnQulImf/Sct25o7/cpjuEq5hO8fMpAkKilv
 BZYxXUaPWpI9qjdP66+E6mb2e2OXpRnEHYgcOBs/rYHBx+WRjsi1VygoEkv4mZuMr/Qa
 sVnM0bOlwo/OC69qvn1XJ7IZVq7ycXRHgPPAEEk1kypjPnSZ5dNmms0ylJTwGl3nK+Vk
 kUhw==
X-Gm-Message-State: AOJu0Yx+7jOw+2FLjDDCv3VB6w/YzaEUPbxYub3NwN1xZRdjgL1TaJro
 bm3KHnwFtmEUmQ872ZLR6psVM/RfY22pL1YxcpnfgaajwfND2fYhwZNMhUNOh9sYmNFVtClOxuX
 C
X-Gm-Gg: ASbGncuF4Fduox0DT7sHL2HanF8705ThtOmaB0st8jB+6/WJwhjIPlgk5Xf07M33Rlp
 oY2BUHU5oA+m4gXSaTNuzJhlc45ADI2GxB+xowRCjGGfuiRN5Y2Si/wGmhPYbxb180lmP6ceFzT
 28M1t2zb2VDfLKIgYX8dt0bUOWP92e0l3qrx58rYvzTaIqNgNGx1J6Pyl0oh3XTJ7XEO4zOIhLB
 U2PSNHHF9vnPVh03Hm0NM3YYPe6ejNuSfM8heYEqGPlKjlBAbB9l2CRQvXKTxShCcygLrgFkMwM
 q/73292hx6JDG2EKoK4OunuhasZ7LmnOlZ7b9T3aHOQmbezWgHv9Cw==
X-Google-Smtp-Source: AGHT+IGoEo/Ij3jf8lezZOmMaDLQdol3Jeb1pdbK1UykotIzcOSQukb4rzzhoN9x26m9rXD5yq0BvQ==
X-Received: by 2002:a05:600c:474b:b0:43b:c528:d0b8 with SMTP id
 5b1f17b1804b1-43bd294e07fmr30738155e9.5.1741184839631; 
 Wed, 05 Mar 2025 06:27:19 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:369c:9bd8:7c87:9a39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-391188029e0sm5442456f8f.52.2025.03.05.06.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 06:27:19 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 5/6] doc: cmd: wget: document cacert subcommand
Date: Wed,  5 Mar 2025 15:26:46 +0100
Message-ID: <20250305142650.2966738-6-jerome.forissier@linaro.org>
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

Document the 'wget cacert' subcommand which allows to configure root
(CA) certificates for HTTPS.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 doc/usage/cmd/wget.rst | 82 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
index 48bedf1e845..cc82e495a29 100644
--- a/doc/usage/cmd/wget.rst
+++ b/doc/usage/cmd/wget.rst
@@ -12,7 +12,9 @@ Synopsis
 ::
 
     wget [address] [host:]path
-    wget [address] url          # lwIP only
+    wget [address] url                  # lwIP only
+    wget cacert none|optional|required  # lwIP only
+    wget cacert <address> <size>        # lwIP only
 
 
 Description
@@ -54,6 +56,32 @@ address
 url
     HTTP or HTTPS URL, that is: http[s]://<host>[:<port>]/<path>.
 
+The cacert (stands for 'Certification Authority certificates') subcommand is
+used to provide root certificates for the purpose of HTTPS authentication. It
+also allows to enable or disable authentication.
+
+wget cacert <address> <size>
+
+address
+    memory address of the root certificates in X509 DER format
+
+size
+    the size of the root certificates
+
+wget cacert none|optional|required
+
+none
+    certificate verification is disabled. HTTPS is used without any server
+    authentication (unsafe)
+optional
+    certificate verification is enabled provided root certificates have been
+    provided via wget cacert <addr> <size> or wget cacert builtin. Otherwise
+    HTTPS is used without any server authentication (unsafe).
+required
+    certificate verification is mandatory. If no root certificates have been
+    configured, HTTPS transfers will fail.
+
+
 Examples
 --------
 
@@ -97,11 +125,61 @@ In the example the following steps are executed:
    1694892032 bytes transferred in 492181 ms (3.3 MiB/s)
    Bytes transferred = 1694892032 (65060000 hex)
 
+Here is an example showing how to configure built-in root certificates as
+well as providing some at run time. In this example it is assumed that
+CONFIG_WGET_BUILTIN_CACERT_PATH=DigiCertTLSRSA4096RootG5.crt downloaded from
+https://cacerts.digicert.com/DigiCertTLSRSA4096RootG5.crt.
+
+::
+
+   # Make sure IP is configured
+   => dhcp
+   # When built-in certificates are configured, authentication is mandatory
+   # (i.e., "wget cacert required"). Use a test server...
+   => wget https://digicert-tls-rsa4096-root-g5.chain-demos.digicert.com/
+   1864 bytes transferred in 1 ms (1.8 MiB/s)
+   Bytes transferred = 1864 (748 hex)
+   # Another server not signed against Digicert will fail
+   => wget https://www.google.com/
+   Certificate verification failed
+
+   HTTP client error 4
+   # Disable authentication to allow the command to proceed anyways
+   => wget cacert none
+   => wget https://www.google.com/
+   WARNING: no CA certificates, HTTPS connections not authenticated
+   16683 bytes transferred in 15 ms (1.1 MiB/s)
+   Bytes transferred = 16683 (412b hex)
+   # Force verification but unregister the CA certificates
+   => wget cacert required
+   => wget cacert 0 0
+   # Unsurprisingly, download fails
+   => wget https://digicert-tls-rsa4096-root-g5.chain-demos.digicert.com/
+   Error: cacert authentication mode is 'required' but no CA certificates given
+   # Get the same certificates as above from the network
+   => wget cacert none
+   => wget https://cacerts.digicert.com/DigiCertTLSRSA4096RootG5.crt
+   WARNING: no CA certificates, HTTPS connections not authenticated
+   1386 bytes transferred in 1 ms (1.3 MiB/s)
+   Bytes transferred = 1386 (56a hex)
+   # Register them and force authentication
+   => wget cacert $fileaddr $filesize
+   => wget cacert required
+   # Authentication is operational again
+   => wget https://digicert-tls-rsa4096-root-g5.chain-demos.digicert.com/
+   1864 bytes transferred in 1 ms (1.8 MiB/s)
+   Bytes transferred = 1864 (748 hex)
+   # The builtin certificates can be restored at any time
+   => wget cacert builtin
+
 Configuration
 -------------
 
 The command is only available if CONFIG_CMD_WGET=y.
-To enable lwIP support set CONFIG_NET_LWIP=y.
+To enable lwIP support set CONFIG_NET_LWIP=y. In this case, root certificates
+support can be enabled via CONFIG_WGET_BUILTIN_CACERT=y
+CONFIG_WGET_BUILTIN_CACERT_PATH=<some path> (for built-in certificates) and/or
+CONFIG_WGET_CACERT=y (for the wget cacert command).
 
 TCP Selective Acknowledgments in the legacy network stack can be enabled via
 CONFIG_PROT_TCP_SACK=y. This will improve the download speed. Selective
-- 
2.43.0

