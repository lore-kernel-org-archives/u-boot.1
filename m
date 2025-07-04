Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C0CC8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 21:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE50E82FD6;
	Fri,  4 Jul 2025 23:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yr9nj6hW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5727E82063; Fri,  4 Jul 2025 23:46:13 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3155582FCA
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 23:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72c09f8369cso492640a34.3
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 14:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751665570; x=1752270370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3CHjw3ZD2M0irSCxG7Ezajnrpfhiy6skPler4BpgsGY=;
 b=Yr9nj6hW9V+wWu6nDMuEu5AKI8qWkDukbXzzwbBZ0VrkhvH7aU4aZIOqCbAbWgDxlI
 Bo6DQqA5mgI9MXn+cgKJDNEqAk3+l2YvtHZEhhGvdh92qCvwQTBrExObx2pwdsDvoVxi
 37BoRBYzURDRNJWOifhjwEZIukkf6zmuY5nQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751665570; x=1752270370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3CHjw3ZD2M0irSCxG7Ezajnrpfhiy6skPler4BpgsGY=;
 b=Cqm8zoQX3QzhGAaqWoBtQH5Z//OA5Dkr2pwUgYHg4xhEmCNYR7gQiWwAZ6u2Dk/QhW
 41HEQbmb8Oo17v5IFj7feS7pZvJw/6nXtOfjELlb42NUFlEOrSOwD/3AVZJOmt0tnlgd
 hVZpHEUBLG0aGWcBF4JDV7khjY270EHqrLeKf4cTKjLoQQ575Yu7YPAQI22KS76feqza
 uF1JFSCj4TAMXJZGsOxXP9kfaPybyj0+vndSCgbmGkGd2KrHZVz4JlNMGuk61wkrcArs
 8K1gmLZl35uKF/iDohWycDq37G/r+PHuX2u77b44quCfmLhfXjmNSWtndNhhuY7DaR2T
 VDEw==
X-Gm-Message-State: AOJu0Ywz1HvxYJSN3NaDUlecljeCFzRc1Vdfep/ZL+71e5AzQGfNQIiL
 4LRcIkR7cAojfWmbLoQJ3gBxjkaTKXaY2RDMYHpKdNFDpUvnLY2MEznJhIvcucxai1TefVCiaXw
 imUniqvI=
X-Gm-Gg: ASbGncvryugkfHyr1drEUvVyfF8th9F0W+N0mNSUJFDUFr8g9DxtLUsC2dRSy32BsNB
 Sj9OXqQBTEHcTIgHvxTu+5k9i9WQIeuAPfR+lA1k01AZerIYaFtKvhzRsnygG7SAi4uXi9Noc9v
 udhjUVu6Y2JUHz9KcGE4b1GH9fBZyjlJ1OcaJ71SS+zMHWxntvbQsD4BJ10GEpfOE8CW8x4uXOC
 1N7//a9LnxqSwj7HeOAdgSaClVGLH90kL3eJiYL75ZGVtAyLBYflOExcjqWP7htCEYgCJBdXGRf
 5RKOv9c46A+JZy51dMeHtUrZFPLock/TMQXGvCzXq+B543gaW88jQoVlY6KoZxdn+bM/W//oZ+2
 1alS0M9NDARXGcX2j4ikTWeM=
X-Google-Smtp-Source: AGHT+IEKWxYtfCbAL/t907wfyJer4UGtNeJcxvpxM9Qk/uDllGRpLfvfBtKsEgvQWeGn8Au7skSbgA==
X-Received: by 2002:a05:6830:3c05:b0:72b:80b4:dbca with SMTP id
 46e09a7af769-73cb44a48f6mr235722a34.5.1751665569860; 
 Fri, 04 Jul 2025 14:46:09 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f9628d8sm519483a34.60.2025.07.04.14.46.08
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 14:46:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] Kconfig: Test for !COMPILE_TEST in some locations
Date: Fri,  4 Jul 2025 15:46:06 -0600
Message-ID: <20250704214606.3418898-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704214606.3418898-1-trini@konsulko.com>
References: <20250704214606.3418898-1-trini@konsulko.com>
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

We have a few options that we cannot enable in a "allyesconfig" type
build because we cannot use zero as a default value.

- The logic around HAS_BOARD_SIZE_LIMIT assumes that if we have set this
  then we compare with it. Similarly, we need to set SPL_NO_BSS_LIMIT as
  the default there.
- Both SYS_CUSTOM_LDSCRIPT and ENV_USE_DEFAULT_ENV_TEXT_FILE then prompt
  for a file name to use.
- The SYS_I2C_SOFT driver is a legacy driver which requires a lot of
  configuration within the board config. file instead, so disable it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 Kconfig             | 2 ++
 common/spl/Kconfig  | 1 +
 drivers/i2c/Kconfig | 1 +
 env/Kconfig         | 1 +
 4 files changed, 5 insertions(+)

diff --git a/Kconfig b/Kconfig
index 3571f5214e67..c883f1154595 100644
--- a/Kconfig
+++ b/Kconfig
@@ -537,6 +537,7 @@ config BUILD_TARGET
 
 config HAS_BOARD_SIZE_LIMIT
 	bool "Define a maximum size for the U-Boot image"
+	depends on !COMPILE_TEST
 	default y if RCAR_32 || RCAR_64
 	help
 	  In some cases, we need to enforce a hard limit on how big the U-Boot
@@ -555,6 +556,7 @@ config BOARD_SIZE_LIMIT
 
 config SYS_CUSTOM_LDSCRIPT
 	bool "Use a custom location for the U-Boot linker script"
+	depends on !COMPILE_TEST
 	help
 	  Normally when linking U-Boot we will look in the board directory,
 	  the CPU directory and finally the "cpu" directory of the architecture
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 9a17ccb2d3d4..5b520e6f62e9 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -132,6 +132,7 @@ config SPL_BSS_START_ADDR
 choice
 	prompt "Enforce SPL BSS limit"
 	depends on !PPC
+	default SPL_NO_BSS_LIMIT if COMPILE_TEST
 	default SPL_BSS_LIMIT
 	help
 	  In some platforms we only want to enforce a limit on the size of the
diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 9465e61a04c9..108b24b3dd23 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -619,6 +619,7 @@ endif
 
 config SYS_I2C_SOFT
 	bool "Legacy software I2C interface"
+	depends on !COMPILE_TEST
 	help
 	  Enable the legacy software defined I2C interface
 
diff --git a/env/Kconfig b/env/Kconfig
index c30785de48b1..c667e8f2da19 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -759,6 +759,7 @@ config SCSI_ENV_PART_UUID
 
 config ENV_USE_DEFAULT_ENV_TEXT_FILE
 	bool "Create default environment from file"
+	depends on !COMPILE_TEST
 	help
 	  Normally, the default environment is automatically generated
 	  based on the settings of various CONFIG_* options, as well
-- 
2.43.0

