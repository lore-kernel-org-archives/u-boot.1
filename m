Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C754C02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23C5580F10;
	Sun, 26 Jan 2025 19:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DGqmxTep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E023480F96; Sun, 26 Jan 2025 19:43:48 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B21CE80F10
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:43:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-844e9b8b0b9so281268839f.0
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917024; x=1738521824; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LhUDkTK8BOnsVL7eLset4v5RNwfYPGvwtYOyjcHH70c=;
 b=DGqmxTep1/psRx6pYzVjv7G0sgb1tFgqcYGG8Wr0yzMa1LouzBU5L9wpn9CfOXIIpP
 zud+VfBf2F8Irsx2dpX4ykNn0pWAiHMuZuL8tjEV2UTT0KFRdhkW3z++AOE4dmlPw2pV
 v2xT+OvsLTvtuYiQKzBCORzqSkLcQHqQzOyxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917024; x=1738521824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LhUDkTK8BOnsVL7eLset4v5RNwfYPGvwtYOyjcHH70c=;
 b=gwmgeaUE5tMX90JxeGcksvFH51G0psy+RXk9dApvq1RXObtQo82yGlZgZlRx+r33W4
 xggQJB7NU+7E6XYvfOeqd1NTpfAuQUXkJArsQnfEtgmicjk7GjXse0a7zR8RorEBHVl4
 /AqIQrS90NzqpSCqbNoJWEJmPeLydKKDSkVyY/iTLroUu2+3c1t5H1vB8ci0NQyUrrOp
 lUTfsqrSTKgD2QG9dHEwtOMNMgZ1exM3pO6EIbBjp8sF5AYSd+YfYKn56W5HVUEkDd1z
 c3lIo/gV+qic7wKU0f0i5hK/XqfySEBWxdX3/r2WAw/2+xuiUy4Vj46UTuYz8fxooXqf
 6Imw==
X-Gm-Message-State: AOJu0YwhS8Sqj16xCUft0GsUQHOitAifQlG9TWio+ZlMYIzlOK760GrZ
 Ts8CSx2jUZjDNgMkJDxFfbS9gTEjW/gygnBs1wXiX62YDq9nTL88BOK4sXWKtf/8Om/XOmIqv9o
 =
X-Gm-Gg: ASbGnctcKJhUhoWL0yvHsiyle1nea5AR+oJypv8+qtRMHRvX7ZR75WOWMgIyP3DUcHM
 +54VcTqAmLNsAicrNjTuqVj8CAmM6Lr1vAHexF+hoZlywQMbZgU4paSrITBi0d6LsAoPVWrCGiN
 b0ak7rNwIbPf3CUnPPwDrfKyj0mA08hP2VL7hl36diZGmqG0oBx3Pz+VtnCSHRX41+Q+W76R3G4
 3qMB+y8noM0H4u8mofOr9XUS2b8+2cFfLeVhDrTrg0UjvEEinoOmoSfApfhtd4cInMvULX7Tuq3
 5Z10hKfwVq+GAi+T27Sl0ZnKCTkzOrW8iNFA6Z7HMQ==
X-Google-Smtp-Source: AGHT+IHORQoecY5LpyOIvu+2/aqPLBxrd8R8RBpwe81vbi+bJnn+YLrBTkKy0fYvTt182oHLoOXcHg==
X-Received: by 2002:a05:6602:4a0b:b0:84f:44de:9c99 with SMTP id
 ca18e2360f4ac-851b61f9123mr3655012639f.5.1737917024567; 
 Sun, 26 Jan 2025 10:43:44 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:43:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/19] mbedtls: Add SHA symbols for VPL
Date: Sun, 26 Jan 2025 11:43:11 -0700
Message-ID: <20250126184333.4058848-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
References: <20250126184333.4058848-1-sjg@chromium.org>
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

Add some symbols for supporting SHA1 etc. for VPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/mbedtls/Kconfig | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 78167ffa252..81274786106 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -112,6 +112,46 @@ config SPL_MD5_LEGACY
 
 endif # SPL
 
+if VPL
+
+config VPL_SHA1_LEGACY
+	bool "Enable SHA1 support in VPL with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && VPL_SHA1
+	help
+	  This option enables support of hashing using SHA1 algorithm
+	  with legacy crypto library.
+
+config VPL_SHA256_LEGACY
+	bool "Enable SHA256 support in VPL with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && VPL_SHA256
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  with legacy crypto library.
+
+config VPL_SHA512_LEGACY
+	bool "Enable SHA512 support in VPL with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && VPL_SHA512
+	help
+	  This option enables support of hashing using SHA512 algorithm
+	  with legacy crypto library.
+
+config VPL_SHA384_LEGACY
+	bool "Enable SHA384 support in VPL with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && VPL_SHA384
+	select VPL_SHA512_LEGACY
+	help
+	  This option enables support of hashing using SHA384 algorithm
+	  with legacy crypto library.
+
+config VPL_MD5_LEGACY
+	bool "Enable MD5 support in VPL with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && VPL_MD5
+	help
+	  This option enables support of hashing using MD5 algorithm
+	  with legacy crypto library.
+
+endif # VPL
+
 endif # LEGACY_CRYPTO_BASIC
 
 config LEGACY_CRYPTO_CERT
-- 
2.43.0

