Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E63C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 15:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CE7B800B3;
	Tue,  4 Feb 2025 16:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V3bDPHTI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3094801DE; Tue,  4 Feb 2025 16:48:05 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3097E80040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 16:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38da940e689so451843f8f.2
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 07:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738684082; x=1739288882; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=spUsAI05l90AOsHikT1dAF6d6EYg3sP+zxUAEpK7RNc=;
 b=V3bDPHTIlWiG3+oeipT7IbU8eXR+PyHKiyXSOy8TY8RljUlk70NiYm/i2/ZS02Gs8D
 pjpOcgDd6n1Tuo1W6wohkphJ+pxjHAGWD67H9DsnbwU6bfvHbmWy2U/1ffXfHsP4pl5M
 pUjDQOzbd/ajQloiE65aAEGDRHdMSmKD68YJMODFZiH9UD5eYGuZgeGyMykf9wU76fu3
 PQK2zOrCJRnsE+5KmvD6vxE/imrMNQ81CuWMAEVs0H2dCsKDwWYRCqULsG89TZj5PxA9
 ZfvDcAh/wqYYehGjLg+OLLUEUYRppxP1qH+xDy/4J8XUkhKdZ4lFUF4DjXWQNMgAASBf
 c8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738684082; x=1739288882;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=spUsAI05l90AOsHikT1dAF6d6EYg3sP+zxUAEpK7RNc=;
 b=FF5ZhnQ6RVeHTXd3UPPDLnY9c0Y1vCrWFSqU9hI5+gVOPUzhzCOqpnRKzuCn/co+tE
 BkQuCUcVIj3D8zK3v+z/9NxQSUq+DXq58AA4HLimMNO6xeFfgYAam0G253EMut/ku4bS
 udQTk5iwA9tdBDAXQBUbxLgW3bmPDBZlkV0aNMd/1jBTvBBtDSLqG1urpU0zKK3KrZjn
 gDGfumSsH2C75Pz/nrBxZnDlwqzwtYrDrJHFnQng+GlA7Bw//iyWzT6orooBtmbxR4PO
 gwk8BodSWq90DEhvyRXjcKQt/YbLj3eV4grbZtzBJkukDPyiFcAmQPXW/JgI5XF6qlmn
 8gQQ==
X-Gm-Message-State: AOJu0YzgTxXvRToih54tsUG5dqoZqfcYtgCAx0DF5tYkxedI4FmaBPPv
 iY+/UPr+nhctrxlUQB/FkLICa27kNg55rpA4jMMMroN4YpNCfFrA8ONtihaTQS7uKsHOto1daKd
 CeXBLaH4g
X-Gm-Gg: ASbGncvoAG7YPh/FFy3nLQqalrbH5smw0fU/i9USSh4nMw+dXubDFgLiYV8EMm1yRcp
 9k0dHFNBCnJfCzoT03zXjJVfEZrI/Byj8BGT/7IM98TP6MzWhYTS79uWWvJmOIIJx3D86pZuP0M
 iWIJewpAzzShAB2SC3v+StidmddM8yPILDV2p1R05sbINn+JcGgZxLsZRGPiVTdMOSh5ai/AU/r
 ecoc9ugKSkTc8njliwKLFLOk9h/KNPO83jiNeh5csW0r2QcNa5jkbTPCXoJEjdldqPk3lmNvroU
 payZbb9m6fB1WxRDsBxbOI5q
X-Google-Smtp-Source: AGHT+IFECqUcGqFSxvlrOg0055iPARz/zryQNAgrtNde2S2Stckk5jOoqI6QKmHsYW3NyyMrdsGQWg==
X-Received: by 2002:a5d:5186:0:b0:38b:da6a:8a02 with SMTP id
 ffacd0b85a97d-38c520bd6fcmr14823737f8f.47.1738684082298; 
 Tue, 04 Feb 2025 07:48:02 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:43d5:b1e2:1df9:edcc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dad9a8663sm1926575f8f.6.2025.02.04.07.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 07:48:02 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH] net: Kconfig: depend on DM_RNG for WGET_HTTPS
Date: Tue,  4 Feb 2025 16:47:05 +0100
Message-ID: <20250204154707.3054802-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

net/lwip/wget.c/mbedtls_hardware_poll() is calling dm_rng_read() but
dependency is not recorded anywhere that's why depend on DM_RNG
when WGET_HTTPS is used.

Suggested-by: Michal Simek <michal.simek@amd.com>
Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig     |  1 +
 net/lwip/wget.c | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index e62817bd977..e3fbb7538ee 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2154,6 +2154,7 @@ config WGET_HTTPS
 	depends on CMD_WGET
 	depends on PROT_TCP_LWIP
 	depends on MBEDTLS_LIB
+	depends on DM_RNG
 	select SHA256
 	select RSA
 	select ASYMMETRIC_KEY_TYPE
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index b76f6c0f1d9..d9b639ce60e 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -433,10 +433,14 @@ bool wget_validate_uri(char *uri)
 
 	if (!strncmp(uri, "http://", strlen("http://"))) {
 		prefix_len = strlen("http://");
-	} else if (!strncmp(uri, "https://", strlen("https://"))) {
-		prefix_len = strlen("https://");
+	} else if (CONFIG_IS_ENABLED(WGET_HTTPS)) {
+		if (!strncmp(uri, "https://", strlen("https://"))) {
+			prefix_len = strlen("https://");
+		} else {
+			log_err("only http(s):// is supported\n");
+		}
 	} else {
-		log_err("only http(s):// is supported\n");
+		log_err("only http:// is supported\n");
 		return false;
 	}
 
-- 
2.43.0

